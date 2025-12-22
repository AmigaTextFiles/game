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

#include "bantumiappui.h"
#include "bantumidoc.h"
#include "bantumiapp.h"
#include "bantumiappview.h"
#include "bantumigl.h"
#include <flogger.h>

CBantumiDocument* CBantumiDocument::NewL(CEikApplication& aApp) {
	CBantumiDocument* self = NewLC(aApp);
	CleanupStack::Pop(self);
	return self;
}

CBantumiDocument* CBantumiDocument::NewLC(CEikApplication& aApp) {
	CBantumiDocument* self = new(ELeave) CBantumiDocument(aApp);
	CleanupStack::PushL( self );
	self->ConstructL();
	return self;
}

void CBantumiDocument::ConstructL() {
}

#ifdef UIQ3
CBantumiDocument::CBantumiDocument(CEikApplication& aApp) : CQikDocument(aApp) {
#else
CBantumiDocument::CBantumiDocument(CEikApplication& aApp) : CAknDocument(aApp) {
#endif
}

CBantumiDocument::~CBantumiDocument() {
}

CEikAppUi* CBantumiDocument::CreateAppUiL() {
	return static_cast<CEikAppUi*>(new(ELeave) CBantumiAppUi());
}

CFileStore* CBantumiDocument::OpenFileL(TBool aDoOpen, const TDesC& aFilename, RFs& aFs) {
	return CEikDocument::OpenFileL(aDoOpen, aFilename, aFs);
}

void CBantumiDocument::StoreL(CStreamStore& aStore, CStreamDictionary& aStreamDic) const {
	CBantumiAppUi *appUi = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());
	BantumiGL *fe;
	if (appUi && appUi->AppView() && appUi->AppView()->iBantumiGL)
		fe = appUi->AppView()->iBantumiGL;
	else
		return;
	RStoreWriteStream stream;
	TStreamId id = stream.CreateLC(aStore);
	stream.WriteInt32L(2);
	stream.WriteInt32L(fe->getNum());
	stream.WriteInt32L(fe->getLevel());
	const TDesC& hostname = appUi->GetHostname();
	stream.WriteInt32L(hostname.Length());
	stream.WriteL(hostname);
	stream.WriteInt32L(appUi->GetPortNumber());
	stream.CommitL();
	CleanupStack::PopAndDestroy();
	aStreamDic.AssignL(KUidBantumiApp, id);
}

void CBantumiDocument::RestoreL(const CStreamStore& aStore, const CStreamDictionary& aStreamDic) {
	CBantumiAppUi *appUi = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi());
	CBantumiAppView *appView = NULL;
	BantumiGL *fe = NULL;
	if (appUi && appUi->AppView() && appUi->AppView()->iBantumiGL) {
		fe = appUi->AppView()->iBantumiGL;
	} else if (appUi && appUi->AppView()) {
		appView = appUi->AppView();
	} else {
		RFileLogger::WriteFormat(_L("debug"), _L("bantumi.txt"), EFileLoggingModeAppend, _L("no appUi or appView"));
		return;
	}
	TStreamId id = aStreamDic.At(KUidBantumiApp);
	RStoreReadStream stream;
	stream.OpenLC(aStore, id);
	TInt version = stream.ReadInt32L();
	if (version >= 1) {
		if (fe) {
			fe->setNum(stream.ReadInt32L());
			fe->setLevel(stream.ReadInt32L());
		} else {
			TInt32 num = stream.ReadInt32L();
			TInt32 level = stream.ReadInt32L();
			appView->SetStoredData(num, level);
		}
	}
	if (version >= 2) {
		TInt length = stream.ReadInt32L();
		TBuf<100> buf;
		stream.ReadL(buf, length);
		appUi->SetHostname(buf);
		appUi->SetPortNumber(stream.ReadInt32L());
	}
	CleanupStack::PopAndDestroy();
	SetChanged(EFalse);
}

