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

#include "socketwriter.h"
#include "symbianbt.h"
#include <flogger.h>

CSocketWriter::CSocketWriter(CSymbianConnection* aConn, RSocket* aSocket) : CActive(EPriorityStandard) {
	iConn = aConn;
	iSocket = aSocket;
	CActiveScheduler::Add(this);
}

CSocketWriter::~CSocketWriter() {
	Cancel();
}

void CSocketWriter::Send(const unsigned char *aPtr, int aN) {
	if (IsActive()) {
		while (aN > 0 && iSecondaryBuffer.Length() < iSecondaryBuffer.MaxLength()) {
			iSecondaryBuffer.Append(*aPtr++);
			aN--;
		}
		if (aN > 0)
			iConn->SetError(KErrOverflow);
	} else {
		iMainBuffer.Zero();
		while (aN > 0 && iMainBuffer.Length() < iMainBuffer.MaxLength()) {
			iMainBuffer.Append(*aPtr++);
			aN--;
		}
		if (aN > 0)
			iConn->SetError(KErrOverflow);

		iStatus = KRequestPending;
		iSocket->Send(iMainBuffer, 0, iStatus);
		SetActive();
	}
}

void CSocketWriter::DoCancel() {
	iSocket->CancelSend();
}

void CSocketWriter::RunL() {
	if (iStatus == KErrNone) {
		if (iSecondaryBuffer.Length() > 0) {
			iMainBuffer = iSecondaryBuffer;
			iSecondaryBuffer.Zero();

			iStatus = KRequestPending;
			iSocket->Send(iMainBuffer, 0, iStatus);
			SetActive();
		}
	} else {
		RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("CSocketWriter: error %d"), iStatus.Int());
		iConn->SetError(iStatus.Int());
	}
}

