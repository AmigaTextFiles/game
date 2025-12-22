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

#ifndef __SYMBIANBT_H
#define __SYMBIANBT_H

#include "connection.h"

#include "symbianconn.h"

#include <e32base.h>
#include <btextnotifiers.h>
#include <es_sock.h>
#include <btsdp.h>
#include <bt_sock.h>

class CServiceSearcher;
class CSocketReader;
class CSocketWriter;

class CBTConnection : public CSymbianConnection {
public:
	enum TConnState { ENotStarted, EGettingDevice, EFindingService, EConnecting, EConnected, EAborting, EListening, ECancelled };

	int ready(const char **errString);

	static CBTConnection* NewL();
	static CBTConnection* NewLC();
	~CBTConnection();

	void ConnectL();
	void AcceptL();

	void RunL();
	void DoCancel();

	void CancelConn();

private:
	CBTConnection();
	void ConstructL();
	void Abort(TInt aError);
	void SetSecurityOnChannelL(TBool aAuthentication, TBool aEncryption, TBool aAuthorisation, TInt aChannel);
	void StartAdvertisingL(TInt aChannel);
	void StopAdvertising();

private:
	TConnState iState;
	CServiceSearcher* iServiceSearcher;
	TBTSockAddr iListenAddr;
	RSocket iListenSocket;
	TBool iListenerOpened;

	RSdp iSdpSession;
	RSdpDatabase iSdpDatabase;
	TSdpServRecordHandle iRecord;
	TBool iIsAdvertising;

	RTimer iTimer;

};

#endif
