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

#include "connwrap.h"
#include <flogger.h>

CConnectionWrapper* CConnectionWrapper::NewL() {
	CConnectionWrapper* self = NewLC();
	CleanupStack::Pop(self);
	return self;
}

CConnectionWrapper* CConnectionWrapper::NewLC() {
	CConnectionWrapper* self = new(ELeave) CConnectionWrapper();
	CleanupStack::PushL(self);
	self->ConstructL();
	return self;
}

void CConnectionWrapper::ConstructL() {
}

CConnectionWrapper::CConnectionWrapper() {
	iAborted = EFalse;
}

CConnectionWrapper::~CConnectionWrapper() {
	delete iConn;
}

bool CConnectionWrapper::isClient() {
	if (iConn) {
		iConn->setCallback(cb);
		return iConn->isClient();
	}
	return false;
}

void CConnectionWrapper::CancelConn() {
	if (iConn) {
		iConn->setCallback(cb);
		iConn->CancelConn();
	} else
		iAborted = ETrue;
}

int CConnectionWrapper::ready(const char **errString) {
	if (iAborted) {
		*errString = NULL;
		return -1;
	}

	if (iConn) {
		iConn->setCallback(cb);
		return iConn->ready(errString);
	}

	return 0;
}

bool CConnectionWrapper::read(const char **errString) {
	if (iConn) {
		iConn->setCallback(cb);
		return iConn->read(errString);
	}
	return true;
}

bool CConnectionWrapper::write(const unsigned char *ptr, int n, const char **errString) {
	if (iConn) {
		iConn->setCallback(cb);
		return iConn->write(ptr, n, errString);
	}
	return false;
}

void CConnectionWrapper::SetDelegate(CSymbianConnection* aConn) {
	iConn = aConn;
	if (iConn)
		iConn->setCallback(cb);
}

CSymbianConnection* CConnectionWrapper::GetDelegate() {
	return iConn;
}



