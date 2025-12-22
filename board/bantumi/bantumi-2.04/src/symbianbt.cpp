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

#include "symbianbt.h"
#include <charconv.h>
#include <eikenv.h>
#include "servicesearcher.h"
#include <flogger.h>
#include "socketreader.h"
#include "socketwriter.h"
#include <btmanclient.h>
#ifdef UIQ3
#elif defined(EKA2)
#include <btnotifierapi.h>
#else
#include <btnotif.h>
#endif
#include "bantumiapp.h"

//#define SYMBIAN_BT_8

#define KServiceUUID 0x10273929

void internalShowWarning(TInt aError);
void internalShowWarning(const char *str);

CBTConnection* CBTConnection::NewL() {
	CBTConnection* self = NewLC();
	CleanupStack::Pop(self);
	return self;
}

CBTConnection* CBTConnection::NewLC() {
	CBTConnection* self = new(ELeave) CBTConnection();
	CleanupStack::PushL(self);
	self->ConstructL();
	return self;
}

void CBTConnection::ConstructL() {
	CSymbianConnection::ConstructL();
	User::LeaveIfError(iTimer.CreateLocal());
}

CBTConnection::CBTConnection() {
	iState = ENotStarted;
	iError = KErrNone;
	iIsAdvertising = EFalse;
	iClient = EFalse;
}

CBTConnection::~CBTConnection() {
	RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("CBTConnection::ready: error %d"), iError);

	iTimer.Cancel();
	iTimer.Close();

	StopAdvertising();

	delete iServiceSearcher;
	if (iListenerOpened)
		iListenSocket.Close();

}

void CBTConnection::CancelConn() {
	Cancel();
	iState = ECancelled;
}

int CBTConnection::ready(const char **errString) {
	if (iError != KErrNone) {
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("CBTConnection::ready: error %d"), iError);
		*errString = GetErrorString(iError);
		return -1;
	}

	switch (iState) {
	case ECancelled:
		*errString = NULL;
		return -1;

	case ENotStarted:
	case EGettingDevice:
	case EFindingService:
	case EConnecting:
	case EAborting:
	case EListening:
		return 0;
	case EConnected:
		return 1;
	}
	*errString = "Unknown internal state";
	return -1;
}


void CBTConnection::ConnectL() {
	iClient = ETrue;
	iServiceSearcher = new(ELeave) CServiceSearcher(KServiceUUID);
	iStatus = KRequestPending;
	SetActive();
	iServiceSearcher->SelectDevice(iStatus);
	iState = EGettingDevice;
	iAborted = EFalse;
}

void CBTConnection::AcceptL() {
	iClient = EFalse;
	iState = EListening;

#ifndef UIQ3
	// commented out since it isn't available on s60 1st edition
	// does seem to work on 3650 anyway
	// enable bluetooth
	TPckgBuf<TBool> param(EFalse);
	RNotifier notifier;
	User::LeaveIfError(notifier.Connect());
	TRequestStatus status = KRequestPending;
	TBTDeviceResponseParamsPckg response;
	notifier.StartNotifierAndGetResponse(status, KPowerModeSettingNotifierUid, param, response);
	User::WaitForRequest(status);
	notifier.Close(); 
	if (status != KErrNone) {
		iAborted = ETrue;
		return;
	}
#endif

	User::LeaveIfError(iListenSocket.Open(iSocketServer, _L("RFCOMM")));
	iListenerOpened = ETrue;
	TInt channel;
	User::LeaveIfError(iListenSocket.GetOpt(KRFCOMMGetAvailableServerChannel, KSolBtRFCOMM, channel));
	iListenAddr.SetPort(channel);
	SetSecurityOnChannelL(EFalse, EFalse, ETrue, channel);
	User::LeaveIfError(iListenSocket.Bind(iListenAddr));
	User::LeaveIfError(iListenSocket.Listen(1));
	SetSecurityOnChannelL(EFalse, EFalse, ETrue, channel);
	// on >= 8.1a, SetSecurity must be before Bind
	// on <= 7.0s, SetSecurity must be after Listen
	// so we're calling it twice...
	User::LeaveIfError(iSocket.Open(iSocketServer));
	iSockOpened = ETrue;
	iStatus = KRequestPending;
	iListenSocket.Accept(iSocket, iStatus);
	SetActive();
	StartAdvertisingL(channel);
}

// important! don't set iAborted before the warning is shown, otherwise the progress bar is terminated within the wrong event loop
void CBTConnection::Abort(TInt aError) {
	internalShowWarning(GetErrorString(aError));
	iAborted = ETrue;
	iState = ENotStarted;
}

void CBTConnection::RunL() {
	switch (iState) {
	case EGettingDevice:
		if (iStatus == KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EGettingDevice: done"));
			iState = EFindingService;
			iServiceSearcher->FindServiceL(iStatus);
			SetActive();
		} else if (iStatus == KErrCancel) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EGettingDevice: cancelled"));
			iAborted = ETrue;
			iState = ENotStarted;
		} else {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EGettingDevice: %d"), iStatus.Int());
			// the device selecter shows it's own error messages
			// wait for them to close before aborting
			iState = EAborting;
			iStatus = KRequestPending;
			iTimer.After(iStatus, 3500*1000);
			SetActive();
		}
		break;
	case EFindingService: {
		if (iStatus == KErrNotFound) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EFindingService: not found"));
			internalShowWarning("Necessary services not found");
			iAborted = ETrue;
			iState = ENotStarted;
			return;
		} else if (iStatus != KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EFindingService: error %d"), iStatus.Int());
			Abort(iStatus.Int());
			return;
		}
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EFindingService: done"));
		iState = EConnecting;
		TBTSockAddr addr = iServiceSearcher->GetSockAddr();
		delete iServiceSearcher;
		iServiceSearcher = NULL;
		TInt err = iSocket.Open(iSocketServer, _L("RFCOMM"));
		if (err != KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("CBTConnection: RSocket::Open: error %d"), err);
			Abort(err);
			return;
		}
		iSockOpened = ETrue;
		iSocket.Connect(addr, iStatus);
		SetActive();
	}
		break;
	case EConnecting:
		if (iStatus != KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EConnecting: error %d"), iStatus.Int());
			Abort(iStatus.Int());
			return;
		}
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EConnecting: done"));
		iState = EConnected;
		iReader->Start();
		break;
	case EAborting:
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EAborting: done"));
		iAborted = ETrue;
		iState = ENotStarted;
		break;
	case EListening:
		if (iStatus != KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EListening: error %d"), iStatus.Int());
			Abort(iStatus.Int());
			return;
		}
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("EListening: done"));
		iState = EConnected;
		iReader->Start();
		StopAdvertising();
		iListenSocket.Close();
		iListenerOpened = EFalse;
		break;
	default:
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("CBTConnection::RunL in state %d"), iState);
		break;
	}
}

void CBTConnection::DoCancel() {
	switch (iState) {
	case EListening:
		iListenSocket.CancelAccept();
		break;
	case EConnecting:
		iSocket.CancelConnect();
		break;
	case EAborting:
		iTimer.Cancel();
		break;
	case EGettingDevice:
		iServiceSearcher->CancelSelect();
		break;
	case EFindingService:
		iServiceSearcher->CancelFind();
		break;
	case ECancelled:
	case ENotStarted:
		break;
	default:
		TRequestStatus *status = &iStatus;
		User::RequestComplete(status, KErrNone);
	}
}

void CBTConnection::SetSecurityOnChannelL(TBool aAuthentication, TBool aEncryption, TBool aAuthorisation, TInt aChannel) {

#ifdef SYMBIAN_BT_8

	TBTServiceSecurity security;
	security.SetUid(KUidBantumiApp);
	security.SetAuthentication(aAuthentication);
	security.SetEncryption(aEncryption);
	security.SetAuthorisation(aAuthorisation);
	iListenAddr.SetSecurity(security);

#else

	TBTServiceSecurity security(KUidBantumiApp, KSolBtRFCOMM, aChannel);
	security.SetAuthentication(aAuthentication);
	security.SetEncryption(aEncryption);
	security.SetAuthorisation(aAuthorisation);
//	security.SetChannelID(aChannel);

	RBTMan manager;
	User::LeaveIfError(manager.Connect());
	CleanupClosePushL(manager);

	RBTSecuritySettings settings;
	User::LeaveIfError(settings.Open(manager));
	CleanupClosePushL(settings);

	TRequestStatus status;
	settings.RegisterService(security, status);
	User::WaitForRequest(status);
	User::LeaveIfError(status.Int());

	CleanupStack::PopAndDestroy();
	CleanupStack::PopAndDestroy();
#endif

}

void CBTConnection::StartAdvertisingL(TInt aChannel) {
	User::LeaveIfError(iSdpSession.Connect());
	User::LeaveIfError(iSdpDatabase.Open(iSdpSession));
	iSdpDatabase.CreateServiceRecordL(KServiceUUID, iRecord);
	iIsAdvertising = ETrue;
	CSdpAttrValueDES* descriptor = CSdpAttrValueDES::NewDESL(NULL);
	CleanupStack::PushL(descriptor);

	TBuf8<1> channel;
	channel.Append(aChannel);

	descriptor
	->StartListL()
		->BuildDESL()
		->StartListL()
			->BuildUUIDL(KL2CAP)
		->EndListL()
		->BuildDESL()
		->StartListL()
			->BuildUUIDL(KRFCOMM)
			->BuildUintL(channel)
		->EndListL()
	->EndListL();

	iSdpDatabase.UpdateAttributeL(iRecord, KSdpAttrIdProtocolDescriptorList, *descriptor);
	CleanupStack::PopAndDestroy(descriptor);

	descriptor = CSdpAttrValueDES::NewDESL(NULL);
	CleanupStack::PushL(descriptor);
	descriptor
	->StartListL()
		->BuildUUIDL(KPublicBrowseGroupUUID)
	->EndListL();
	iSdpDatabase.UpdateAttributeL(iRecord, KSdpAttrIdBrowseGroupList, *descriptor);
	CleanupStack::PopAndDestroy(descriptor);

	iSdpDatabase.UpdateAttributeL(iRecord, KSdpAttrIdBasePrimaryLanguage + KSdpAttrIdOffsetServiceName, _L("Bantumi GL"));
//	iSdpDatabase.UpdateAttributeL(iRecord, KSdpAttrIdServiceAvailability, 0xFF);
//	iSdpDatabase.UpdateAttributeL(iRecord, KSdpAttrIdServicRecordState, ++iRecordState);
}

void CBTConnection::StopAdvertising() {
	if (iIsAdvertising) {
		iIsAdvertising = EFalse;
		iSdpDatabase.DeleteRecordL(iRecord);
		iSdpDatabase.Close();
		iSdpSession.Close();
	}
}


