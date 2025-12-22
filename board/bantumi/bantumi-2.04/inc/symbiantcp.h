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

#ifndef __SYMBIANTCP_H
#define __SYMBIANTCP_H

#include "connection.h"

#include "symbianconn.h"

#include <e32base.h>
#include <es_sock.h>
#include <in_sock.h>


class CSocketReader;
class CSocketWriter;

class MTCPGui {
public:
	virtual ~MTCPGui() {}
	virtual TBool GetHostPortL(TDes& aHost, TInt& aPort) = 0;
	virtual TBool GetPortL(TInt& aPort) = 0;
};

class CTCPConnection : public CSymbianConnection {
public:
	enum TConnState { ENotStarted, EConnectingNet, EResolvingHost, EConnecting, EConnected, EAborting, EListening, ECancelled };

	int ready(const char **errString);

	static CTCPConnection* NewL(MTCPGui* aGui);
	static CTCPConnection* NewLC(MTCPGui* aGui);
	~CTCPConnection();

	void ConnectL();
	void AcceptL();

	void RunL();
	void DoCancel();

	void CancelConn();

private:
	CTCPConnection(MTCPGui* aGui);
	void ConstructL();
	void Abort(TInt aError);

private:

	MTCPGui* iGui;

	TConnState iState;
	RSocket iListenSocket;
	RHostResolver iResolver;
	TBool iSockOpened;
	TBool iListenerOpened;
	TBool iResolverOpened;
	TNameEntry iNameEntry;
	TInetAddr iAddress;

	RTimer iTimer;

	TBuf<100> iHost;
	TInt iPortNumber;
	TBool iTriedV6;

	RConnection iConn;
	TBool iConnOpened;
};

#endif
