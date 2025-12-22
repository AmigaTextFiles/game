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

#ifndef __SYMBIANCONN_H
#define __SYMBIANCONN_H

#include "connection.h"

#include <e32base.h>
#include <es_sock.h>

class CSocketReader;
class CSocketWriter;

class CSymbianConnection : public CActive, public Connection {
public:
	virtual ~CSymbianConnection();

	bool isClient();
	bool read(const char **errString);
	bool write(const unsigned char *ptr, int n, const char **errString);


	virtual void ConnectL() = 0;
	virtual void AcceptL() = 0;

	virtual void CancelConn() = 0;
	virtual void Received(TDesC8& aDes);
	virtual void SetError(TInt aError);

	const char *GetErrorString(TInt aError);



protected:
	CSymbianConnection();
	void ConstructL();

protected:
	CSocketReader* iReader;
	CSocketWriter* iWriter;
	TBool iClient;
	RSocket iSocket;
	TBool iSockOpened;
	RSocketServ iSocketServer;
	unsigned char iInitialBuffer[1000];
	TInt iBufferPos;
	TInt iError;
	char iErrorBuffer[200];

public:
	TBool iAborted;
};

#endif
