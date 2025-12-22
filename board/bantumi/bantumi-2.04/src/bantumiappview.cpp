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

#include <coemain.h>
#include "bantumiappview.h"
#include <flogger.h>
#include "bantumi.h"
#include "bantumigl.h"
#include "glfont.h"
#include <hal.h>
#include <eikenv.h>
#include <GLES/gl.h>
#include "bantumiappui.h"
#ifdef UIQ3
#include <bantumigl.rsg>
#include <qikcommand.h>
#else
#include <aknutils.h>
#endif

#include <time.h>
#include <stdlib.h>

GLFont *makeSymbianGLFont(CFbsBitGc *gc, int height);

void debug(const char *str) {
	TBuf<100> buf;
	while (*str != '\0')
		buf.Append(*str++);
	RFileLogger::WriteFormat(_L("debug"), _L("bantumi.txt"), EFileLoggingModeAppend, _L("%S"), &buf);
}

#ifdef UIQ3
CBantumiAppView* CBantumiAppView::NewL(CQikAppUi& aAppUi, TBool aFullscreen) {
	CBantumiAppView* self = CBantumiAppView::NewLC(aAppUi, aFullscreen);
	CleanupStack::Pop(self);
	return self;
}

CBantumiAppView* CBantumiAppView::NewLC(CQikAppUi& aAppUi, TBool aFullscreen) {
	CBantumiAppView* self = new(ELeave) CBantumiAppView(aAppUi);
	CleanupStack::PushL(self);
//	self->ConstructL(aFullscreen ? EFullscreen : EWindowed, EPixmap, ETrue, ETrue);
	self->ConstructL(aFullscreen ? EFullscreen : EWindowed, EEGLWindow, EFalse, EFalse);
	return self;
}

CBantumiAppView::CBantumiAppView(CQikAppUi& aAppUi) : CGLAppView(aAppUi) {
	iStoredData = EFalse;
}

#include "bantumiapp.h"
const TUid KUidBantumiView = { 1 };
TVwsViewId CBantumiAppView::ViewId() const {
	return TVwsViewId(KUidBantumiApp, KUidBantumiView);
}

TInt CBantumiAppView::ViewConfigurationId() const {
	return R_BANTUMI_UI_CONFIGURATIONS;
}

#else
CBantumiAppView* CBantumiAppView::NewL(const TRect& aRect, TBool aFullscreen) {
	CBantumiAppView* self = CBantumiAppView::NewLC(aRect, aFullscreen);
	CleanupStack::Pop(self);
	return self;
}

CBantumiAppView* CBantumiAppView::NewLC(const TRect& aRect, TBool aFullscreen) {
	CBantumiAppView* self = new(ELeave) CBantumiAppView();
	CleanupStack::PushL(self);
	self->ConstructL(aRect, aFullscreen ? EFullscreen : EWindowed, EPixmap, ETrue, ETrue);
	return self;
}

CBantumiAppView::CBantumiAppView() {
	iStoredData = EFalse;
}
#endif

void CBantumiAppView::SetStoredData(TInt aNum, TInt aLevel) {
	iStoredData = ETrue;
	iNum = aNum;
	iLevel = aLevel;
}

void CBantumiAppView::ConstructAppL() {
	srand(time(NULL));
	iBantumiGL = new(ELeave) BantumiGL(Rect().Width(), Rect().Height());
	if (iStoredData) {
		iBantumiGL->setNum(iNum);
		iBantumiGL->setLevel(iLevel);
	}
	InitFonts();

	iBantumi = new(ELeave) Bantumi(iBantumiGL);
	iBantumiGL->useScissor(iDrawMode == EPixmap);
}

#ifdef UIQ3
const CFont* CBantumiAppView::GetFont(TInt aFont) {
	switch (aFont) {
	case 1:
		return &ScreenFont(TCoeFont::AnnotationFont());
	case 2:
	default:
		return &ScreenFont(TCoeFont::LegendFont());
	case 3:
		return &ScreenFont(TCoeFont::TitleFont());
	}
	return NULL;
}
#endif

void CBantumiAppView::InitFonts() {
	delete iGLTextFont;
	delete iGLNumFont;
	int textTexSize = 128;
#ifdef UIQ3
	const CFont *textFont = &ScreenFont(TCoeFont::NormalFont());
	const CFont *numFont = &ScreenFont(TCoeFont::AnnotationFont());
#elif defined(EKA2)
	const CFont *textFont = AknLayoutUtils::FontFromId(EAknLogicalFontSecondaryFont);
	const CFont *numFont = NumberPlain5();
	int maxDim = Rect().Width();
	if (Rect().Height() > maxDim)
		maxDim = Rect().Height();
	if (maxDim >= 320)
		numFont = LatinBold13();
	if (maxDim >= 416) {
		numFont = LatinBold17();
		textTexSize = 256;
	}
#else
	const CFont *textFont = LatinBold13();
	const CFont *numFont = NumberPlain5();
#endif
	if (iDrawMode != EEGLWindow)
		iGLTextFont = makeSymbianGLFont(iGc, Rect().Height());
	else
		iGLTextFont = makeGLFont((const char*) textFont, 0, textTexSize, textTexSize, ' ', 'ö', 'z'+1, 'ö'-1);
	iGLNumFont = makeGLFont((const char*) numFont, 0, 64, 64, '0', '9');
	static_cast<TexGLFont*>(iGLNumFont)->setAllowScaling(false);
	iBantumiGL->setNumFont(iGLNumFont);
	iBantumiGL->setTextFont(iGLTextFont);
}

void CBantumiAppView::SizeChanged() {
	if (iBantumiGL)
		iBantumiGL->reinitGL(Rect().Width(), Rect().Height());

	CGLAppView::SizeChanged();

	if (iBantumiGL)
		InitFonts();
}

void CBantumiAppView::ReinitApp() {
	if (iBantumiGL)
		iBantumiGL->reinitGL(Rect().Width(), Rect().Height());
}

void CBantumiAppView::DeinitGC() {
//	if (iFont && iGc)
//		iGc->DiscardFont();
}

void CBantumiAppView::InitGC() {
//	iFont = LatinBold13();
//	iFont = LatinPlain12();
//	iFont = NumberPlain5();
}


CBantumiAppView::~CBantumiAppView() {
	DeinitGC();
	delete iBantumi;
	delete iBantumiGL;
	delete iGLNumFont;
	delete iGLTextFont;

	CloseSTDLIB();
}


void CBantumiAppView::UpdateAndDraw() {

	if (iBantumiGL->exit()) {
		static_cast<CBantumiAppUi*>(iEikonEnv->AppUi())->DoExit();
	}

	iBantumi->update();

	iBantumiGL->draw(iTime);

	FinishGLDrawing();

/*	if (iDrawMode != EEGLWindow) {
		eglWaitGL();
		TPoint point(2, 2 + iFont->HeightInPixels());
		TBuf<20> buf;
		buf.Format(_L("%d fps"), iLastFPS);
		iGc->UseFont(iFont);
		iGc->SetPenColor(KRgbWhite);
		iGc->SetDrawMode(CGraphicsContext::EDrawModeXOR);
		iGc->DrawText(buf, point);
		TInt ticklength = iRelTick - iFrameTick[iFrame % iFrameTickLength];
		buf.Format(_L("%d ticks/%d frames"), ticklength, iFrameTickLength);
		point.iX = Rect().Width() - 2 - iFont->TextWidthInPixels(buf);
		iGc->DrawText(buf, point);
		eglWaitNative(EGL_CORE_NATIVE_ENGINE);
	}
*/
}

void CBantumiAppView::FPSUpdated() {
	RFileLogger::WriteFormat(_L("debug"), _L("bantumi.txt"), EFileLoggingModeAppend, _L("%d fps"), iLastFPS);
}

TKeyResponse CBantumiAppView::OfferKeyEventL(const TKeyEvent& aKeyEvent, TEventCode aType) {
	if (aType != EEventKey)
		return EKeyWasNotConsumed;

	if (iBantumi) {
		switch (aKeyEvent.iScanCode) {
#ifndef UIQ3
		case EStdKeyDevice3:
			iBantumi->pressed(SELECT);
			break;
#endif
		case EStdKeyUpArrow:
			iBantumi->pressed(UP);
			break;
		case EStdKeyDownArrow:
			iBantumi->pressed(DOWN);
			break;
		case EStdKeyLeftArrow:
			iBantumi->pressed(LEFT);
			break;
		case EStdKeyRightArrow:
			iBantumi->pressed(RIGHT);
			break;
#ifdef UIQ3
/*
		case EStdKeyF13: // left softkey, emulator
			iBantumi->pressed(SELECT);
			break;
		case EStdKeyF14: // right softkey, emulator
			iBantumi->pressed(ESCAPE);
			break;
*/
		case EStdKeyDevice1: // jogdial up
			iBantumi->pressed(UP);
			break;
		case EStdKeyDevice2: // jogdial down
			iBantumi->pressed(DOWN);
			break;
		case EStdKeyDevice4: // arrow up, emulator
			iBantumi->pressed(UP);
			break;
		case EStdKeyDevice5: // arrow down, emulator
			iBantumi->pressed(DOWN);
			break;
		case EStdKeyDevice6: // arrow left, emulator
			iBantumi->pressed(LEFT);
			break;
		case EStdKeyDevice7: // arrow right, emulator
			iBantumi->pressed(RIGHT);
			break;
		case EStdKeyDevice8: // jogdial select, select, emulator
			iBantumi->pressed(SELECT);
			break;
		case EStdKeyDevice1B: // jogdial select, P1i
			iBantumi->pressed(SELECT);
			break;
		case EStdKeyNkp2:
			iBantumi->pressed(UP);
			break;
		case EStdKeyNkp4:
			iBantumi->pressed(LEFT);
			break;
		case EStdKeyNkp5:
			iBantumi->pressed(SELECT);
			break;
		case EStdKeyNkp6:
			iBantumi->pressed(RIGHT);
			break;
		case EStdKeyNkp8:
			iBantumi->pressed(DOWN);
			break;
#endif
		default:
//			RFileLogger::WriteFormat(_L("debug"), _L("bantumikey.txt"), EFileLoggingModeAppend, _L("down %d %d"), aKeyEvent.iScanCode, aKeyEvent.iCode);
			return EKeyWasNotConsumed;
		}
		return EKeyWasConsumed;
	}
	return EKeyWasNotConsumed;
}

void CBantumiAppView::HandlePointerEventL(const TPointerEvent& aPointerEvent) {
	switch (aPointerEvent.iType) {
	case TPointerEvent::EButton1Down:
		iBantumi->click(aPointerEvent.iPosition.iX, aPointerEvent.iPosition.iY);
		break;
	default:
		break;
	}
}

#ifdef UIQ3
void CBantumiAppView::HandleCommandL(CQikCommand& aCommand) {
	if (aCommand.Id() == EQikCmdGoBack)
		iBantumi->pressed(ESCAPE);
	else
		CGLAppView::HandleCommandL(aCommand);
}
#endif


