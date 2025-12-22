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

#ifdef UIQ3
#include <qikon.hrh>
#include <uikon.hrh>
#include <qikcommand.h>
#else
#include <avkon.hrh>
#endif
#include <flogger.h>
#include <bantumigl.rsg>

#include "bantumi.pan"
#include "bantumiappui.h"
#include "bantumiappview.h"
#include "bantumi.hrh"
#include "bantumi.h"
#include "symbianbt.h"
#include "connwrap.h"
#include "symbiantcp.h"
#include <eikmenub.h>

void showDialog(CSymbianConnection* aConn, TBool aClient);
MTCPGui* GetTCPGuiL();

void CBantumiAppUi::ConstructL() {
#ifdef UIQ3
	CQikAppUi::ConstructL();
	iAppView = CBantumiAppView::NewLC(*this, ETrue);
	AddViewL(*iAppView);
	CleanupStack::Pop(iAppView);
	iMenuPopout = CQikMenuPopout::NewL(*iEikonEnv, *this);
	iMenuClosedTimer = CPeriodic::NewL(CActive::EPriorityStandard);
#else
	BaseConstructL(EAknEnableSkin);
	iAppView = CBantumiAppView::NewL(ClientRect(), ETrue);
	AddToStackL(iAppView);
#endif
}

CBantumiAppUi::CBantumiAppUi() {
	iPortNumber = 8471;
}

CBantumiAppUi::~CBantumiAppUi() {
#ifdef UIQ3
	delete iMenuClosedTimer;
	delete iMenuPopout;
#else
	if (iAppView) {
		RemoveFromStack(iAppView);
		delete iAppView;
		iAppView = NULL;
	}
#endif
}

void CBantumiAppUi::HandleCommandL(TInt aCommand) {
	CBantumiAppView* appView = static_cast<CBantumiAppView*>(iAppView);
	switch(aCommand) {
	case EEikCmdExit:
#ifndef UIQ3
	case EAknSoftkeyExit:
	case EAknSoftkeyBack:
#endif
		DoExit();
		break;

	case EBantumiSoftkey1:
		if (appView->iBantumi)
			appView->iBantumi->pressed(START);
		break;

	case EBantumiSoftkey2:
		if (appView->iBantumi)
			appView->iBantumi->pressed(ESCAPE);
		break;

	case EBantumiHost:
		if (iConnectionType == EBantumiBluetooth)
			iConn->SetDelegate(CBTConnection::NewL());
		else
			iConn->SetDelegate(CTCPConnection::NewL(GetTCPGuiL()));
		HandleForegroundEventL(EFalse);
		appView->EnableCallback(EFalse);
		showDialog(iConn->GetDelegate(), EFalse);
		appView->EnableCallback(ETrue);
		iConn = NULL;
		break;

	case EBantumiJoin:
		if (iConnectionType == EBantumiBluetooth)
			iConn->SetDelegate(CBTConnection::NewL());
		else
			iConn->SetDelegate(CTCPConnection::NewL(GetTCPGuiL()));
		HandleForegroundEventL(EFalse);
		appView->EnableCallback(EFalse);
		showDialog(iConn->GetDelegate(), ETrue);
		appView->EnableCallback(ETrue);
		iConn = NULL;
		break;

	case EBantumiCancel:
		iConn->CancelConn();
		iConn = NULL;
		break;

	case EBantumiTCPIP:
		// don't show any host/join dialog in this case
		iConnectionType = aCommand;
		iConn->SetDelegate(CTCPConnection::NewL(GetTCPGuiL()));
		HandleForegroundEventL(EFalse);
		appView->EnableCallback(EFalse);
		showDialog(iConn->GetDelegate(), ETrue);
		appView->EnableCallback(ETrue);
		iConn = NULL;
		break;

	case EBantumiBluetooth: {
		iConnectionType = aCommand;
#ifdef UIQ3
		ShowMenuL(R_BANTUMI_MULTIPLAYER_COMMANDS);
#else
		CEikMenuBar *menubar = CEikonEnv::Static()->AppUiFactory()->MenuBar();
//		menubar->StopDisplayingMenuBar();
		menubar->SetMenuTitleResourceId(R_BANTUMI_MULTIPLAYER_MENUBAR);
		menubar->TryDisplayMenuBarL();
#endif
		}
		break;

	default:
		Panic(EBantumiUi);
		break;
	}
}

void CBantumiAppUi::ProcessCommandL(TInt aCommand) {
	// when selecting something from the popupmenu,
	// the functions are called in the order ProcessCommandL, SetEmphasis, HandleCommandL
	switch(aCommand) {
	case EBantumiHost:
	case EBantumiJoin:
	case EBantumiBluetooth:
	case EBantumiTCPIP:
	case EBantumiCancel:
		iMenuSelected = ETrue;
		break;

	default:
		break;
	}

#ifdef UIQ3
	CQikAppUi::ProcessCommandL(aCommand);
#else
	CAknAppUi::ProcessCommandL(aCommand);
#endif

}

void CBantumiAppUi::SetEmphasis(CCoeControl* aMenuControl, TBool aEmphasis) {
#ifndef UIQ3
	if (aEmphasis) iMenuSelected = EFalse;

	if (iConn && !aEmphasis && !iMenuSelected) {
		// closing menu, but no action was selected in the menu
		if (iConn) {
			iConn->CancelConn();
			iConn = NULL;
		}
	}
#endif
	CGLAppUi::SetEmphasis(aMenuControl, aEmphasis);
}

// workaround for the winscw compiler, which on s60 3.0 seems to
// leak memory (causes alloc panic on exit) if there exists a
// TRAP in the call stack to Exit()

void CBantumiAppUi::DoSave() {
	TRAPD(err, SaveL());
}

void CBantumiAppUi::DoExit() {
	DoSave();
	Exit();
}


void CBantumiAppUi::SetConnection(CConnectionWrapper* aConn) {
	iConn = aConn;
}

CBantumiAppView* CBantumiAppUi::AppView() const {
	return static_cast<CBantumiAppView*>(iAppView);
}

void CBantumiAppUi::SetHostname(const TDesC& aName) {
	iHostname = aName;
}

const TDesC& CBantumiAppUi::GetHostname() const {
	return iHostname;
}

void CBantumiAppUi::SetPortNumber(TInt aPort) {
	iPortNumber = aPort;
}

TInt CBantumiAppUi::GetPortNumber() const {
	return iPortNumber;
}

#ifdef UIQ3
TInt CBantumiAppUi::StaticCallback(TAny* aPtr) {
	CBantumiAppUi* self = (CBantumiAppUi*) aPtr;
	if (!self->iMenuPopout->MenuPane()) {
		self->iMenuClosedTimer->Cancel();
		if (!self->iMenuSelected)
			self->HandleCommandL(EBantumiCancel);
	}
	return 0;
}

void CBantumiAppUi::ShowMenuL(TInt aResource) {
	iMenuPopout->SetCommandListL(aResource);
	TPoint point(0, AppView()->Size().iHeight);
	iMenuPopout->DisplayL(point, EPopupTargetBottomLeft, ETrue);
	iMenuClosedTimer->Cancel();
	iMenuSelected = EFalse;
	iMenuClosedTimer->Start(50*1000, 50*1000, TCallBack(CBantumiAppUi::StaticCallback, this));

}

void CBantumiAppUi::HandleCommandL(CQikCommand& aCommand) {
	iMenuSelected = ETrue;
	HandleCommandL(aCommand.Id());
}

#endif


