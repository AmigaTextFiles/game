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

#ifndef __SOCKETWRITER_H
#define __SOCKETWRITER_H

#include <e32base.h>
#include <es_sock.h>

class CSymbianConnection;

class CSocketWriter : public CActive {
public:
	CSocketWriter(CSymbianConnection* aConn, RSocket* aSocket);
	~CSocketWriter();

	void Send(const unsigned char *aPtr, int aN);

	void RunL();
	void DoCancel();

private:
	CSymbianConnection* iConn;
	RSocket* iSocket;
	TBuf8<1000> iMainBuffer;
	TBuf8<1000> iSecondaryBuffer;
};



#endif
