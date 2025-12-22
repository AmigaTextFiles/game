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

#include "connectwaitcontainer.h"
#include "connection.h"
#include "gui.h"
#include "symbianconn.h"
#include <bantumigl.rsg>
#include <aknnotewrappers.h>
#include <flogger.h>
#include "bantumiappview.h"
#include "bantumiappui.h"
#include <textresolver.h>
#include <charconv.h>
#include <string.h>
#include <eikmenub.h>
#include "connwrap.h"
#include <aknquerydialog.h>
#include "symbiantcp.h"

// don't call this until we're actually returning to the main game loop
// otherwise the main callback can be called from these event loops
void restartTimer() {
	CBantumiAppUi *appui = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());
	CBantumiAppView *appview = appui->AppView();
	appview->SetForeground(ETrue);
}

void showWarningL(const char *str) {
	CCnvCharacterSetConverter *conv = CCnvCharacterSetConverter::NewLC();
	conv->PrepareToConvertToOrFromL(KCharacterSetIdentifierUtf8, CEikonEnv::Static()->FsSession());
	TInt state = CCnvCharacterSetConverter::KStateDefault;

	int len = strlen(str);
	HBufC8 *buf8 = HBufC8::NewLC(len+1);
	TPtr8 ptr8 = buf8->Des();
	while (*str)
		ptr8.Append(*str++);
	HBufC *buf = HBufC::NewLC(len);
	TPtr ptr = buf->Des();
	conv->ConvertToUnicode(ptr, ptr8, state);

	CAknWarningNote* note = new(ELeave) CAknWarningNote(ETrue);
	note->ExecuteLD(ptr);
	CleanupStack::PopAndDestroy(buf);
	CleanupStack::PopAndDestroy(buf8);
	CleanupStack::PopAndDestroy(conv);
}

void internalShowWarning(const char *str) {
	TRAPD(err, showWarningL(str));
}

void showWarning(const char *str) {
	if (str)
		internalShowWarning(str);
	restartTimer();
}

void showWarningL(TInt aError) {
	CTextResolver* resolver = CTextResolver::NewLC();
#ifdef EKA2
	TPtrC err = resolver->ResolveErrorString(aError);
#else
	TPtrC err = resolver->ResolveError(aError);
#endif
	CAknWarningNote* note = new(ELeave) CAknWarningNote(ETrue);
	note->ExecuteLD(err);
	CleanupStack::PopAndDestroy(resolver);
}

void internalShowWarning(TInt aError) {
	TRAPD(err, showWarningL(aError));
}



CConnectWaitContainer* CConnectWaitContainer::NewL(CSymbianConnection *aConn) {
	CConnectWaitContainer* self = new(ELeave) CConnectWaitContainer(aConn);
	CleanupStack::PushL(self);
	self->ConstructL();
	CleanupStack::Pop(self);
	return self;
}

CConnectWaitContainer::CConnectWaitContainer(CSymbianConnection *aConn) {
	iConn = aConn;
}

CConnectWaitContainer::~CConnectWaitContainer() {
}

void CConnectWaitContainer::ConstructL() {
}

void CConnectWaitContainer::DialogDismissedL(TInt aButtonId) {
}

TBool CConnectWaitContainer::IsProcessDone() const {
	if (iConn->iAborted) {
		return ETrue;
	}
	const char *err;
	int retval = iConn->ready(&err);
	if (retval == 0)
		return EFalse;
	// don't print any warning here, either
	// the connection shows the warning itself
	// or lets the game show it
/*
	if (retval < 0) {
		internalShowWarning(err);
	}
*/
	return ETrue;
}

void CConnectWaitContainer::ProcessFinished() {
}

void CConnectWaitContainer::StepL() {
}



TBool showDialogL(CSymbianConnection* aConn, TBool aClient) {
//	CSymbianConnection *conn = CBTConnection::NewLC();
	if (aClient)
		aConn->ConnectL();
	else
		aConn->AcceptL();

	CConnectWaitContainer *container = CConnectWaitContainer::NewL(aConn);
	CleanupStack::PushL(container);
	CAknWaitNoteWrapper* wrapper = CAknWaitNoteWrapper::NewL();

	CleanupStack::PushL(reinterpret_cast<CBase*>(wrapper));
	TBool success = wrapper->ExecuteL((aClient ? R_BANTUMI_WAITING_CLIENT : R_BANTUMI_WAITING_SERVER), *container, ETrue);
	CleanupStack::PopAndDestroy(wrapper);
	CleanupStack::PopAndDestroy(container);

	restartTimer();

	if (!success)
		return EFalse;

	if (aConn->iAborted)
		return EFalse;
		
	const char *err;
	if (aConn->ready(&err) > 0) {
		return ETrue;
	}

	return EFalse;
}

void showDialog(CSymbianConnection* aConn, TBool aClient) {
	TBool success = EFalse;
	TRAPD(err, success = showDialogL(aConn, aClient));
	if (err != KErrNone) {
		internalShowWarning(err);
		restartTimer();
		aConn->CancelConn();
	} else {
		if (!success)
			aConn->CancelConn();
	}
}

/*
Connection *showConnectDialog() {
	Connection *conn = NULL;
	TRAPD(err, conn = showDialogL(ETrue));
	if (err != KErrNone) {
		internalShowWarning(err);
		restartTimer();
		return NULL;
	}
	return conn;
}


Connection *showAcceptDialog() {
	Connection *conn = NULL;
	TRAPD(err, conn = showDialogL(EFalse));
	if (err != KErrNone) {
		internalShowWarning(err);
		restartTimer();
		return NULL;
	}
	return conn;
}
*/

Connection *showMultiplayerDialogL() {
	CBantumiAppUi *appui = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());
	CConnectionWrapper *conn = CConnectionWrapper::NewLC();
	CEikMenuBar *menubar = CEikonEnv::Static()->AppUiFactory()->MenuBar();
	menubar->SetMenuTitleResourceId(R_BANTUMI_MENUBAR);
//	menubar->StopDisplayingMenuBar();
	menubar->TryDisplayMenuBarL();
//	menubar->SetMenuTitleResourceId(R_BANTUMI_MENUBAR);
	CleanupStack::Pop(conn);
	appui->SetConnection(conn);
	return conn;
}

Connection *showMultiplayerDialog() {
	Connection *conn = NULL;
	TRAPD(err, conn = showMultiplayerDialogL());
	if (err != KErrNone) {
		internalShowWarning(err);
		restartTimer();
		return NULL;
	}
	return conn;
}


class CTCPGui : public MTCPGui {
public:
	TBool GetHostPortL(TDes& aHost, TInt& aPort) {
		CEikDialog* dlg = CAknMultiLineDataQueryDialog::NewL(aHost, aPort);
		if (!dlg->ExecuteLD(R_BANTUMI_CONNECT_QUERY)) {
			return EFalse;
		}
		return ETrue;
	}

	TBool GetPortL(TInt& aPort) {
		CEikDialog* dlg = CAknNumberQueryDialog::NewL(aPort);
		if (!dlg->ExecuteLD(R_BANTUMI_ACCEPT_QUERY)) {
			return EFalse;
		}
		return ETrue;
	}
};

MTCPGui* GetTCPGuiL() {
	return new(ELeave) CTCPGui();
}


