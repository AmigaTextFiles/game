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

#ifndef __CONNWRAP_H
#define __CONNWRAP_H

#include "connection.h"

#include <e32base.h>

#include "symbianconn.h"

class CConnectionWrapper : public CBase, public Connection {
public:

	bool isClient();
	int ready(const char **errString);
	bool read(const char **errString);
	bool write(const unsigned char *ptr, int n, const char **errString);

	static CConnectionWrapper* NewL();
	static CConnectionWrapper* NewLC();
	~CConnectionWrapper();

	void SetDelegate(CSymbianConnection* aConn);
	CSymbianConnection* GetDelegate();
	void CancelConn();

private:
	CConnectionWrapper();
	void ConstructL();

private:
	CSymbianConnection* iConn;
	TBool iAborted;
};

#endif
