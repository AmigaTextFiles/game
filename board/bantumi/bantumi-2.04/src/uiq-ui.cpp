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

#include "connection.h"
#include "gui.h"
#include "symbianconn.h"
#include <bantumigl.rsg>
#include <flogger.h>
#include "bantumiappview.h"
#include "bantumiappui.h"
#include <charconv.h>
#include <string.h>
#include <eikmenub.h>
#include "connwrap.h"
#include <qiksimpledialog.h>
#include <eikdialg.h>
#include <qikmenupopout.h>
#include "bantumi.hrh"
#include <eikedwin.h>
#include <qiknumbereditor.h>
#include "symbiantcp.h"

// don't call this until we're actually returning to the main game loop
// otherwise the main callback can be called from these event loops
void stopTimer() {
	CBantumiAppUi *appui = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());
	CBantumiAppView *appview = appui->AppView();
	appview->SetForeground(EFalse);
}

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

//	stopTimer();
	CEikonEnv::Static()->InfoWinL(_L("Warning"), ptr);
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

void internalShowWarning(TInt aErr) {
	char buffer[500];
	switch (aErr) {
	case KErrGeneral:
		internalShowWarning("General error");
		break;
	case KErrNotFound:
		internalShowWarning("Not found");
		break;
	case KErrTimedOut:
		internalShowWarning("Timed out");
		break;
	default:
		sprintf(buffer, "Error %d", aErr);
		internalShowWarning(buffer);
		break;
	}
}

class CMySimpleDialog : public CQikSimpleDialog {
public:
	void Close(TInt aCode) {
		CloseDialog(aCode);
	}
};

class CWaitController : public CBase {
public:
	CWaitController(CMySimpleDialog* aDialog, CSymbianConnection* aConn) {
		iDialog = aDialog;
		iConn = aConn;
	}
	void SetDialog(CMySimpleDialog* aDialog) {
		iDialog = aDialog;
	}
	void ConstructL() {
		iPeriodic = CPeriodic::NewL(CActive::EPriorityStandard);
		iPeriodic->Start(50*1000, 50*1000, TCallBack(StaticCallback, this));
		iTick = User::TickCount();
	}

	static TInt StaticCallback(TAny* aPtr) {
		CWaitController* self = (CWaitController*) aPtr;
		CSymbianConnection* conn = self->iConn;
		if (conn->iAborted)
			self->iDialog->Close(EBantumiCancel);
		const char* err;
		int retval = conn->ready(&err);
		if (retval == 0)
			return 0;
		self->iDialog->Close(retval < 0 ? EBantumiCancel : EBantumiJoin);
/*
		if (User::TickCount() - self->iTick >= 200) {
			if (self->iDialog)
				self->iDialog->Close(EBantumiJoin);
		}
*/
		return 0;
	}

	~CWaitController() {
		iPeriodic->Cancel();
		delete iPeriodic;
	}

private:
	CMySimpleDialog* iDialog;
	CSymbianConnection* iConn;
	CPeriodic* iPeriodic;
	TUint32 iTick;
};


TBool showDialogL(CSymbianConnection* aConn, TBool aClient) {
//	CSymbianConnection *conn = CBTConnection::NewLC();

	if (aClient)
		aConn->ConnectL();
	else
		aConn->AcceptL();

	// use some kind of more or less animated dialog for this instead, to make it modal
//	CEikonEnv::Static()->BusyMsgL(_L("Busy"));
/*
	CConnectWaitContainer *container = CConnectWaitContainer::NewL(aConn);
	CleanupStack::PushL(container);
	CAknWaitNoteWrapper* wrapper = CAknWaitNoteWrapper::NewL();

	CleanupStack::PushL(reinterpret_cast<CBase*>(wrapper));
	TBool success = wrapper->ExecuteL((aClient ? R_BANTUMI_WAITING_CLIENT : R_BANTUMI_WAITING_SERVER), *container, ETrue);
	CleanupStack::PopAndDestroy(wrapper);
	CleanupStack::PopAndDestroy(container);
*/
	CWaitController* waitController = new(ELeave) CWaitController(NULL, aConn);
	CleanupStack::PushL(waitController);
	waitController->ConstructL();

	CMySimpleDialog* dialog = new(ELeave) CMySimpleDialog();
	waitController->SetDialog(dialog);

	dialog->PrepareLC(R_BANTUMI_WAIT_DIALOG);
	TBool success = dialog->RunLD() != EBantumiCancel;

	CleanupStack::PopAndDestroy(waitController);

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


Connection *showMultiplayerDialogL() {
//	User::Leave(KErrNotFound);
/*
	CQikSimpleDialog* dialog = new(ELeave) CQikSimpleDialog();
	dialog->PrepareLC(R_BANTUMI_MULTIPLAYER_DIALOG);
	dialog->RunLD();
*/

	CEikonEnv* eikEnv = CEikonEnv::Static();
	CBantumiAppUi* appUi = static_cast<CBantumiAppUi*>(eikEnv->AppUi());
	CConnectionWrapper* conn = CConnectionWrapper::NewLC();

	appUi->ShowMenuL(R_BANTUMI_MULTIPLAYER_TYPE_COMMANDS);

	CleanupStack::Pop(conn);
	appUi->SetConnection(conn);

//	CEikDialog* dlg = new(ELeave) CEikDialog();
//	dlg->ExecuteLD(R_BANTUMI_MULTIPLAYER_DIALOG2);
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

class CMyTCPIPDialog : public CQikSimpleDialog {
public:
	void SetHostname(const TDesC& aStr) {
		iHost = aStr;
	}
	void SetPort(TInt aPort) {
		iPort = aPort;
	}
	void GetHostname(TDes& aStr) {	
		CEikEdwin* hostEdwin = LocateControlByUniqueHandle<CEikEdwin>(EBantumiHostnameEdwin);
		hostEdwin->GetText(aStr);
	}
	TInt GetPort() {
		CQikNumberEditor* portEditor = LocateControlByUniqueHandle<CQikNumberEditor>(EBantumiPortEditor);
		return portEditor->Value();
	}
protected:
	void PostLayoutDynInitL() {
		CEikEdwin* hostEdwin = LocateControlByUniqueHandle<CEikEdwin>(EBantumiHostnameEdwin);
		if (hostEdwin)
			hostEdwin->SetTextL(&iHost);
		CQikNumberEditor* portEditor = LocateControlByUniqueHandle<CQikNumberEditor>(EBantumiPortEditor);
		if (portEditor)
			portEditor->SetValueL(iPort);
	}
private:
	TBuf<100> iHost;
	TInt iPort;
};

class CTCPGui : public MTCPGui {
public:
	TBool GetHostPortL(TDes& aHost, TInt& aPort) {
		CMyTCPIPDialog* dialog = new(ELeave) CMyTCPIPDialog();
		dialog->PrepareLC(R_BANTUMI_CONNECT_DIALOG);
		dialog->SetHostname(aHost);
		dialog->SetPort(aPort);
		if (dialog->RunL() == EBantumiCancel) {
			CleanupStack::PopAndDestroy(dialog);
			return EFalse;
		}
		dialog->GetHostname(aHost);
		aPort = dialog->GetPort();
		CleanupStack::PopAndDestroy(dialog);
		return ETrue;
	}
	TBool GetPortL(TInt& aPort) {
		CMyTCPIPDialog* dialog = new(ELeave) CMyTCPIPDialog();
		dialog->PrepareLC(R_BANTUMI_ACCEPT_DIALOG);
		dialog->SetPort(aPort);
		if (dialog->RunL() == EBantumiCancel) {
			CleanupStack::PopAndDestroy(dialog);
			return EFalse;
		}
		aPort = dialog->GetPort();
		CleanupStack::PopAndDestroy(dialog);
		return ETrue;
	}
};

MTCPGui* GetTCPGuiL() {
	return new(ELeave) CTCPGui();
}

