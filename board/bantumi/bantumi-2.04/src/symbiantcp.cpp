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

#include "symbiantcp.h"
#include <charconv.h>
#include <eikenv.h>
#include <flogger.h>
#include "socketreader.h"
#include "socketwriter.h"
#include "bantumiappui.h"

void internalShowWarning(TInt aError);
void internalShowWarning(const char *str);

CTCPConnection* CTCPConnection::NewL(MTCPGui* aGui) {
	CTCPConnection* self = NewLC(aGui);
	CleanupStack::Pop(self);
	return self;
}

void CleanupGui(TAny* aPtr) {
	MTCPGui* gui = (MTCPGui*) aPtr;
	delete gui;
}

CTCPConnection* CTCPConnection::NewLC(MTCPGui* aGui) {
	CleanupStack::PushL(TCleanupItem(CleanupGui, aGui));
	CTCPConnection* self = new(ELeave) CTCPConnection(aGui);
	CleanupStack::Pop(aGui);
	CleanupStack::PushL(self);
	self->ConstructL();
	return self;
}

void CTCPConnection::ConstructL() {
	CSymbianConnection::ConstructL();
	User::LeaveIfError(iTimer.CreateLocal());
}

CTCPConnection::CTCPConnection(MTCPGui* aGui) {
	iGui = aGui;
	iState = ENotStarted;
	iError = KErrNone;
	iListenerOpened = EFalse;
	iResolverOpened = EFalse;
	iClient = EFalse;
}

CTCPConnection::~CTCPConnection() {

	iTimer.Cancel();
	iTimer.Close();

	if (iListenerOpened)
		iListenSocket.Close();
	if (iResolverOpened)
		iResolver.Close();
	if (iConnOpened)
		iConn.Close();

	delete iGui;
}

void CTCPConnection::CancelConn() {
	Cancel();
	iState = ECancelled;
}

int CTCPConnection::ready(const char **errString) {
	if (iError != KErrNone) {
		*errString = GetErrorString(iError);
		return -1;
	}

	switch (iState) {
	case ECancelled:
		*errString = NULL;
		return -1;

	case ENotStarted:
	case EConnectingNet:
	case EResolvingHost:
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

void CTCPConnection::ConnectL() {
	iClient = ETrue;

	CBantumiAppUi *appUi = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());

	iHost = appUi->GetHostname();
	iPortNumber = appUi->GetPortNumber();
	if (!iGui->GetHostPortL(iHost, iPortNumber)) {
		iAborted = ETrue;
		iState = ENotStarted;
		return;
	}
	appUi->SetHostname(iHost);
	appUi->SetPortNumber(iPortNumber);

#ifdef UIQ3
	User::LeaveIfError(iConn.Open(iSocketServer));
	iConnOpened = ETrue;
	iState = EConnectingNet;
	iStatus = KRequestPending;
	iConn.Start(iStatus);
	SetActive();
#else
	iState = EConnectingNet;
	iStatus = KErrNone;
	RunL();
#endif

}

void CTCPConnection::AcceptL() {
	iClient = EFalse;

	CBantumiAppUi *appUi = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());

	TInt port = appUi->GetPortNumber();
	if (!iGui->GetPortL(port)) {
		iAborted = ETrue;
		iState = ENotStarted;
		return;
	}
	appUi->SetPortNumber(port);

	iState = EListening;

	User::LeaveIfError(iListenSocket.Open(iSocketServer, KAfInet, KSockStream, KProtocolInetTcp));
	iListenerOpened = ETrue;
	iAddress.SetPort(port);
	User::LeaveIfError(iListenSocket.Bind(iAddress));
	User::LeaveIfError(iListenSocket.Listen(1));
	User::LeaveIfError(iSocket.Open(iSocketServer));
	iSockOpened = ETrue;
	iStatus = KRequestPending;
	iListenSocket.Accept(iSocket, iStatus);
	SetActive();

}

// important! don't set iAborted before the warning is shown, otherwise the progress bar is terminated within the wrong event loop
void CTCPConnection::Abort(TInt aError) {
	internalShowWarning(GetErrorString(aError));
	iAborted = ETrue;
	iState = ENotStarted;
}

void CTCPConnection::RunL() {

	switch (iState) {
	case EConnectingNet:
		if (iStatus == KErrNone) {
			iState = EResolvingHost;
			iTriedV6 = EFalse;
			User::LeaveIfError(iResolver.Open(iSocketServer, KAfInet, KProtocolInetUdp));
			iResolverOpened = ETrue;
			iResolver.GetByName(iHost, iNameEntry, iStatus);
			SetActive();
		} else if (iStatus == KErrCancel) {
			iAborted = ETrue;
			iState = ENotStarted;
		} else {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("connecting net: %d"), iStatus.Int());
			Abort(iStatus.Int());
			return;
		}
		break;
	case EResolvingHost:
		if (iStatus == KErrNone) {
			TInt err = iSocket.Open(iSocketServer, KAfInet, KSockStream, KProtocolInetTcp);
			if (err != KErrNone) {
				Abort(err);
				return;
			}
			iState = EConnecting;
			iSockOpened = ETrue;
			iAddress = TInetAddr::Cast(iNameEntry().iAddr);
			iAddress.SetPort(iPortNumber);
			iSocket.Connect(iAddress, iStatus);
			SetActive();

			iResolver.Close();
			iResolverOpened = EFalse;
		} else if (iStatus == KErrCancel) {
			iAborted = ETrue;
			iState = ENotStarted;
		} else {
			iResolver.Close();
			iResolverOpened = EFalse;

			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("resolving: %d"), iStatus.Int());
			TInt err = iStatus.Int();
			if (!iTriedV6) {
				err = iResolver.Open(iSocketServer, KAfInet6, KProtocolInetUdp);
				iTriedV6 = ETrue;
				if (err == KErrNone) {
					iResolverOpened = ETrue;
					iResolver.GetByName(iHost, iNameEntry, iStatus);
					SetActive();
				} else {
					RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("open v6 resolver: %d"), err);
					err = iStatus.Int();
				}
			}
			if (err != KErrNone) {
				Abort(err);
			}
		}
		break;
	case EConnecting:
		if (iStatus != KErrNone) {
			RFileLogger::WriteFormat(_L("debug"), _L("sock.txt"), EFileLoggingModeAppend, _L("connecting: %d"), iStatus.Int());
			Abort(iStatus.Int());
			return;
		}
		iState = EConnected;
		iReader->Start();
		break;
	case EAborting:
		iAborted = ETrue;
		iState = ENotStarted;
		break;
	case EListening:
		if (iStatus != KErrNone) {
			Abort(iStatus.Int());
			return;
		}
		iState = EConnected;
		iReader->Start();
		iListenSocket.Close();
		iListenerOpened = EFalse;
		break;

	default:
		break;
	}

}

void CTCPConnection::DoCancel() {

	switch (iState) {
	case EConnectingNet:
		iConn.Stop();
		break;

	case EResolvingHost:
		iResolver.Cancel();
		break;

	case EListening:
		iListenSocket.CancelAccept();
		break;
	case EConnecting:
		iSocket.CancelConnect();
		break;
/*
	case EAborting:
		iTimer.Cancel();
		break;
*/
	case ECancelled:
	case ENotStarted:
		break;

	default:
		TRequestStatus *status = &iStatus;
		User::RequestComplete(status, KErrNone);
	}

}


