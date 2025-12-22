/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include "servicesearcher.h"
#include <bt_sock.h>
#include <flogger.h>
#ifdef UIQ3
#include <qbtselectdlg.h>
#include <qbtselectdlg.hrh>
#endif
/* Heavily influenced by Nokia's examples */

enum TCheckType { ECheckType, ECheckValue, EReadValue, ECheckEnd, ECheckFinish };

static const struct {
	TCheckType iCheck;
	TSdpElementType iType;
	TInt iValue;
} KSdpRecord[] = {
	{ ECheckType, ETypeDES },
		{ ECheckType, ETypeDES },
			{ ECheckValue, ETypeUUID, KL2CAP },
		{ ECheckEnd },
		{ ECheckType, ETypeDES },
			{ ECheckValue, ETypeUUID, KRFCOMM },
			{ EReadValue, ETypeUint },
		{ ECheckEnd },
	{ ECheckEnd },
	{ ECheckFinish }
};
	
CServiceSearcher::CServiceSearcher(TUUID aUuid) {
	iUuid = aUuid;
	iNotifierConnected = EFalse;
}

CServiceSearcher::~CServiceSearcher() {
	if (iNotifierConnected) {
		iNotifier.CancelNotifier(KDeviceSelectionNotifierUid);
		iNotifier.Close();
	}
	delete iAgent;
	delete iSdpSearchPattern;
}

#ifdef UIQ3
void SelectDeviceL(TRequestStatus& aStatus, TBTDeviceResponseParams& aParams) {
	CBTDeviceArray* array = new(ELeave) CBTDeviceArray(5);
	BTDeviceArrayCleanupStack::PushL(array);
	CQBTUISelectDialog* dialog = CQBTUISelectDialog::NewL(array);
	TUint32 flag = KQBTUISelectDlgFlagNone;
	TInt ret = KErrCancel;
	if (dialog->RunDlgLD(flag) == EBTDeviceSelected) {
		aParams.SetDeviceAddress(array->At(0)->BDAddr());
		ret = KErrNone;
	}
	CleanupStack::PopAndDestroy(array);
	TRequestStatus* statusPtr = &aStatus;
	User::RequestComplete(statusPtr, ret);
}
#endif

void CServiceSearcher::SelectDevice(TRequestStatus& aStatus) {
#ifdef UIQ3
	TRAPD(err, SelectDeviceL(aStatus, iResponse()));
	if (err != KErrNone) {
		TRequestStatus* statusPtr = &aStatus;
		User::RequestComplete(statusPtr, err);
	}
#else
	iNotifier.Connect();
	iNotifierConnected = ETrue;
	iSelectionFilter().SetUUID(iUuid);
//	iSelectionFilter().SetDeviceClass(TBTDeviceClass(EMajorServiceObjectTransfer, EMajorDeviceComputer, EMinorDeviceComputerUnclassified));
	aStatus = KRequestPending;
	iNotifier.StartNotifierAndGetResponse(aStatus, KDeviceSelectionNotifierUid, iSelectionFilter, iResponse);
#endif
}

void CServiceSearcher::CancelSelect() {
	iNotifier.CancelNotifier(KDeviceSelectionNotifierUid);
}

void CServiceSearcher::FindServiceL(TRequestStatus& aStatus) {
	iServiceFindStatus = &aStatus;
	*iServiceFindStatus = KRequestPending;
	iAgent = CSdpAgent::NewL(*this, iResponse().BDAddr());
	iSdpSearchPattern = CSdpSearchPattern::NewL();
	iSdpSearchPattern->AddL(iUuid);
	iAgent->SetRecordFilterL(*iSdpSearchPattern);
	iServiceFound = EFalse;
	iAgent->NextRecordRequestL();
}

void CServiceSearcher::CancelFind() {
	Finished(KErrNone);
}

void CServiceSearcher::AttributeRequestComplete(TSdpServRecordHandle aHandle, TInt aError) {
	TRAPD(err, AttributeRequestCompleteL(aHandle, aError));
	if (err != KErrNone)
		Finished(err);
}

void CServiceSearcher::AttributeRequestResult(TSdpServRecordHandle aHandle, TSdpAttributeID aAttrID, CSdpAttrValue* aAttrValue) {
	TRAPD(err, AttributeRequestResultL(aHandle, aAttrID, aAttrValue));
	if (err != KErrNone)
		Finished(err);
}

void CServiceSearcher::NextRecordRequestComplete(TInt aError, TSdpServRecordHandle aHandle, TInt aTotalRecordsCount) {
	TRAPD(err, NextRecordRequestCompleteL(aError, aHandle, aTotalRecordsCount));
	if (err != KErrNone)
		Finished(err);
}

void CServiceSearcher::AttributeRequestCompleteL(TSdpServRecordHandle aHandle, TInt aError) {
	if (iServiceFound) return;
	iAgent->NextRecordRequestL();
}

void CServiceSearcher::AttributeRequestResultL(TSdpServRecordHandle aHandle, TSdpAttributeID aAttrID, CSdpAttrValue* aAttrValue) {
	if (iServiceFound) return;
	iIndex = 0;
	aAttrValue->AcceptVisitorL(*this);
	iServiceFound = ETrue;
	Finished(KErrNone);
}

void CServiceSearcher::NextRecordRequestCompleteL(TInt aError, TSdpServRecordHandle aHandle, TInt aTotalRecordsCount) {
	if (iServiceFound) return;
	if (aError == KErrEof)
		Finished(KErrNone);
	else if (aError == -6004)
		Finished(KErrTimedOut);
	else if (aError != KErrNone)
		Finished(aError);
	else if (aTotalRecordsCount == 0)
		Finished(KErrNotFound);
	else
		iAgent->AttributeRequestL(aHandle, KSdpAttrIdProtocolDescriptorList);
}

void CServiceSearcher::Finished(TInt aError) {
	if (aError == KErrNone && !iServiceFound)
		aError = KErrNotFound;
	if (*iServiceFindStatus == KRequestPending)
		User::RequestComplete(iServiceFindStatus, aError);
}

TBTSockAddr CServiceSearcher::GetSockAddr() {
	TBTSockAddr addr;
	addr.SetBTAddr(iResponse().BDAddr());
	addr.SetPort(iChannel);
	return addr;
}

void CServiceSearcher::VisitAttributeValueL(CSdpAttrValue& aValue, TSdpElementType aType) {
	switch (KSdpRecord[iIndex].iCheck) {
	case ECheckType:
		if (aValue.Type() != KSdpRecord[iIndex].iType)
			User::Leave(KErrGeneral);
		break;
	case ECheckValue:
		if (aValue.Type() != KSdpRecord[iIndex].iType)
			User::Leave(KErrGeneral);
		switch (KSdpRecord[iIndex].iType) {
		case ETypeUUID:
			if (aValue.UUID() != TUUID(KSdpRecord[iIndex].iValue))
				User::Leave(KErrGeneral);
			break;
		case ETypeUint:
			if (aValue.Uint() != (TUint) KSdpRecord[iIndex].iValue)
				User::Leave(KErrGeneral);
			break;
		default:
			break;
		}
		break;
	case EReadValue:
		if (aValue.Type() != KSdpRecord[iIndex].iType)
			User::Leave(KErrGeneral);
		iChannel = aValue.Uint();
		break;
	case ECheckEnd:
	case ECheckFinish:
		User::Leave(KErrGeneral);
	}
	iIndex++;
}
void CServiceSearcher::StartListL(CSdpAttrValueList& aList) {
}
void CServiceSearcher::EndListL() {
	if (KSdpRecord[iIndex].iCheck != ECheckEnd)
		User::Leave(KErrGeneral);
	iIndex++;
}

