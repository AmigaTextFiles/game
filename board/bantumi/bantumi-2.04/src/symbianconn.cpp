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

#include "symbianconn.h"
#ifndef UIQ3
#include <textresolver.h>
#endif
#include <charconv.h>
#include <eikenv.h>
#include <flogger.h>
#include "socketreader.h"
#include "socketwriter.h"
#include <bantumigl.rsg>
#include "bantumiappui.h"

void internalShowWarning(TInt aError);
void internalShowWarning(const char *str);

void CSymbianConnection::ConstructL() {
	User::LeaveIfError(iSocketServer.Connect());
	CActiveScheduler::Add(this);
	iReader = new(ELeave) CSocketReader(this, &iSocket);
	iWriter = new(ELeave) CSocketWriter(this, &iSocket);
}

CSymbianConnection::CSymbianConnection() : CActive(EPriorityStandard) {
	iSockOpened = EFalse;
	iBufferPos = 0;
}

CSymbianConnection::~CSymbianConnection() {
	delete iReader;
	delete iWriter;

	Cancel();

	if (iSockOpened)
		iSocket.Close();

	iSocketServer.Close();
}

bool CSymbianConnection::isClient() {
	return iClient ? true : false;
}

bool CSymbianConnection::read(const char **errString) {
	if (iBufferPos > 0) {
		cb->received(iInitialBuffer, iBufferPos);
		iBufferPos = 0;
	}
	return true;
}

bool CSymbianConnection::write(const unsigned char *ptr, int n, const char **errString) {
	iWriter->Send(ptr, n);
	return true;
}


void CSymbianConnection::Received(TDesC8& aDes) {
	if (cb) {
		if (iBufferPos > 0) {
			cb->received(iInitialBuffer, iBufferPos);
			iBufferPos = 0;
		}
		cb->received(aDes.Ptr(), aDes.Length());
	} else {
		TInt bufferSize = sizeof(iInitialBuffer)/sizeof(iInitialBuffer[0]);
		TInt index = 0;
		while (index < aDes.Length() && iBufferPos < bufferSize)
			iInitialBuffer[iBufferPos++] = aDes[index++];
		if (index < aDes.Length())
			SetError(KErrOverflow);
	}
}

void CSymbianConnection::SetError(TInt aError) {
	RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("seterror: %d"), aError);
	if (iError == KErrNone)
		iError = aError;
}

const char* CSymbianConnection::GetErrorString(TInt aError) {
	if (aError == KErrDisconnected || aError == KErrEof)
		return "Connection closed";
	else if (aError == KErrCouldNotConnect)
		return "Could not connect";

#ifdef UIQ3
	sprintf(iErrorBuffer, "Error %d", aError);
#else
	CCnvCharacterSetConverter *conv = CCnvCharacterSetConverter::NewLC();
	conv->PrepareToConvertToOrFromL(KCharacterSetIdentifierUtf8, CEikonEnv::Static()->FsSession());
	CTextResolver* resolver = CTextResolver::NewLC();
#ifdef EKA2
	TPtrC err = resolver->ResolveErrorString(aError);
#else
	TPtrC err = resolver->ResolveError(aError);
#endif

	HBufC8 *buf8 = HBufC8::NewLC(err.Length()*4);
	TPtr8 ptr8 = buf8->Des();
	conv->ConvertFromUnicode(ptr8, err);


	int len = ptr8.Length();
	int buflen = sizeof(iErrorBuffer)/sizeof(iErrorBuffer[0]);
	if (len >= buflen)
		len = buflen-1;
	for (int i = 0; i < len; i++)
		iErrorBuffer[i] = ptr8[i];
	iErrorBuffer[len] = '\0';
	CleanupStack::PopAndDestroy(buf8);
	CleanupStack::PopAndDestroy(resolver);
	CleanupStack::PopAndDestroy(conv);
#endif
	return iErrorBuffer;
}


