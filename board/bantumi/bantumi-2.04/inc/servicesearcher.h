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

#ifndef __SERVICESEARCHER_H
#define __SERVICESEARCHER_H

#include "connection.h"

#include <e32base.h>
#include <btextnotifiers.h>
#include <btsdp.h>
#include <bt_sock.h>

class CServiceSearcher : public CBase, public MSdpAgentNotifier, public MSdpAttributeValueVisitor {
public:

	CServiceSearcher(TUUID aUuid);
	~CServiceSearcher();

	void SelectDevice(TRequestStatus& aStatus);
	void CancelSelect();
	void FindServiceL(TRequestStatus& aStatus);
	void CancelFind();
	TBTSockAddr GetSockAddr();

	void AttributeRequestComplete(TSdpServRecordHandle aHandle, TInt aError);
	void AttributeRequestResult(TSdpServRecordHandle aHandle, TSdpAttributeID aAttrID, CSdpAttrValue* aAttrValue);
	void NextRecordRequestComplete(TInt aError, TSdpServRecordHandle aHandle, TInt aTotalRecordsCount);

	void VisitAttributeValueL(CSdpAttrValue& aValue, TSdpElementType aType);
	void StartListL(CSdpAttrValueList& aList);
	void EndListL();

private:
	void AttributeRequestCompleteL(TSdpServRecordHandle aHandle, TInt aError);
	void AttributeRequestResultL(TSdpServRecordHandle aHandle, TSdpAttributeID aAttrID, CSdpAttrValue* aAttrValue);
	void NextRecordRequestCompleteL(TInt aError, TSdpServRecordHandle aHandle, TInt aTotalRecordsCount);

	void Finished(TInt aError);

private:
	TUUID iUuid;
	RNotifier iNotifier;
	TBool iNotifierConnected;
	TBTDeviceSelectionParamsPckg iSelectionFilter;
	TBTDeviceResponseParamsPckg iResponse;
	CSdpAgent* iAgent;
	CSdpSearchPattern* iSdpSearchPattern;
	TRequestStatus* iServiceFindStatus;
	TBool iServiceFound;

	TInt iIndex;
	TInt iChannel;
};

#endif
