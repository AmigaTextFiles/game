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
#include "glappview.h"
#include <flogger.h>
#include <hal.h>
#include <eikenv.h>
#include <GLES/gl.h>
#ifdef UIQ3
#include <eikappui.h>
#include <qikappui.h>
#include <qikcommand.h>
#else
#include <aknutils.h>
#include <aknnotewrappers.h>
#endif

#ifndef GL_OES_VERSION_1_1
#ifdef USE_OES_1_1
#undef UES_OES_1_1
#endif
#endif

#ifdef UIQ3
CGLAppView::CGLAppView(CQikAppUi& aAppUi) : CQikViewBase(aAppUi, KNullViewId) {
#else
CGLAppView::CGLAppView() {
#endif
	iDisplay = EGL_NO_DISPLAY;
	iContext = EGL_NO_CONTEXT;
	iSurface = EGL_NO_SURFACE;
	iEGLInited = EFalse;
}


CGLAppView::~CGLAppView() {
	delete iBitmap;
	delete iDevice;
	delete iGc;
	delete iDrawer;
	delete iPeriodic;

	eglMakeCurrent(iDisplay, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
	eglDestroySurface(iDisplay, iSurface);
	eglDestroyContext(iDisplay, iContext);
	eglTerminate(iDisplay);
#ifdef EGL_VERSION_1_2
	eglReleaseThread();
#endif

	delete [] iFrameTick;
}

#ifdef UIQ3
void CGLAppView::ConstructL(TWindowMode aWinMode, TDrawMode aDrawMode, TBool aUseDSA, TBool aAllowFail) {
	BaseConstructL();

	iDrawMode = aDrawMode;
	iUseDSA = aUseDSA;
	iAllowFail = aAllowFail;
	iWinMode = aWinMode;
}

void CGLAppView::ViewConstructL() {
	InitComponentArrayL();
	ViewConstructFromResourceL(ViewConfigurationId());
	ActivateL();
	if (iWinMode == EFullscreen) {
		TQikViewMode vm;
		vm.SetFullscreen();
		vm.SetStatusBar(ETrue);
		SetViewModeL(vm);
	}
}

void CGLAppView::ViewDeactivated() {
	SetForeground(EFalse);
}

void CGLAppView::HandleCommandL(CQikCommand& aCommand) {
	if (aCommand.Id() == EQikCmdGoBack) {
		SetForeground(EFalse);
		CQikViewBase::HandleCommandL(aCommand);
	} else
		iQikAppUi.HandleCommandL(aCommand.Id());
}

void CGLAppView::ViewActivatedL(const TVwsViewId& aPrevViewId, TUid aCustomMessageId, const TDesC8& aCustomMessage) {
	CQikViewBase::ViewActivatedL(aPrevViewId, aCustomMessageId, aCustomMessage);

	if (iPeriodic) {
		SetForeground(ETrue);
		return;
	}
	ConstructDrawEnvL();
}

#else

void CGLAppView::ConstructL(const TRect& aRect, TWindowMode aWinMode, TDrawMode aDrawMode, TBool aUseDSA, TBool aAllowFail) {
	iDrawMode = aDrawMode;
	iUseDSA = aUseDSA;
	iAllowFail = aAllowFail;

	iWinMode = aWinMode;

	CreateWindowL();
	if (iWinMode == EFullscreen) {
		SetExtentToWholeScreen();
	} else {
		SetRect(aRect);
	}
	ActivateL();

	ConstructDrawEnvL();
}

void CGLAppView::HandleResourceChange(TInt aType) {
	CCoeControl::HandleResourceChange(aType);
	if (aType == KEikDynamicLayoutVariantSwitch) {
		if (iWinMode == EFullscreen)
			SetExtentToWholeScreen();
		else
			SetRect(static_cast<CEikAppUi*>(iEikonEnv->AppUi())->ClientRect());
	}
}

#endif

void CGLAppView::ConstructDrawEnvL() {
	TInt err;

	iDSAStarted = EFalse;

	iFrameTickLength = 50;
	iFrameTick = new(ELeave) TInt[iFrameTickLength];
	for (int i = 0; i < iFrameTickLength; i++)
		iFrameTick[i] = 0;



	if (HAL::Get(HALData::ESystemTickPeriod, iPeriod) != KErrNone)
		iPeriod = 1000/64;
	else
		iPeriod /= 1000;


	ConstructAppL();

	iPeriodic = CPeriodic::NewL(CActive::EPriorityIdle);
	iStarted = EFalse;
	SetForeground(ETrue);

	iFrame = 0;
	iLastFPSFrame = 0;
	iLastFPSTime = (TUint)-1;
	iTime = 0;
	iLastFPS = 0;
	iLastResetTick = 0;
	iLastAfterTick = 0;

	RFs &fs = iEikonEnv->FsSession();
	RFile file;
	_LIT(KFileName, "c:\\logs\\debug\\gles.txt");
	TInt flags = EFileWrite | EFileStreamText;
	err = file.Replace(fs, KFileName, flags);
	if (err == KErrNone) {
		const GLubyte* str = glGetString(GL_VENDOR);
		TBuf8<500> buf;
		buf.Format(_L8("vendor: %s\n"), str);
		file.Write(buf);

		str = glGetString(GL_RENDERER);
		buf.Format(_L8("renderer: %s\n"), str);
		file.Write(buf);

		str = glGetString(GL_VERSION);
		buf.Format(_L8("version: %s\n"), str);
		file.Write(buf);

		str = glGetString(GL_EXTENSIONS);
		buf.Format(_L8("extensions: %s\n"), str);
		file.Write(buf);
		file.Close();
	}

	iAllowFail = EFalse;
}

void CGLAppView::SetWindowMode(TWindowMode aMode) {
	if (aMode == iWinMode)
		return;

	iWinMode = aMode;
#ifdef UIQ3
	TQikViewMode vm;
	if (iWinMode == EFullscreen) {
		vm.SetFullscreen();
		vm.SetStatusBar(ETrue);
	} else {
		vm.SetNormal();
	}
	SetViewModeL(vm);
#else
	if (iWinMode == EFullscreen)
		SetExtentToWholeScreen();
	else
		SetRect(static_cast<CEikAppUi*>(iEikonEnv->AppUi())->ClientRect());
#endif
}

void CGLAppView::SizeChanged() {
	SetupBitmap();
}

void CGLAppView::SetupBitmap() {
	DeinitGC();
	delete iBitmap;
	delete iDevice;
	delete iGc;

	iBitmap = new(ELeave) CWsBitmap(iEikonEnv->WsSession());
	iBitmap->Create(Rect().Size(), iEikonEnv->ScreenDevice()->DisplayMode());

	iDevice = CFbsBitmapDevice::NewL(iBitmap);
	TInt err = iDevice->CreateContext(iGc);
	if (err != KErrNone) {
		_LIT(KPanicMsg, "CFbsBitmapDevice::CreateContext");
		User::Panic(KPanicMsg, err);
	}

	InitGC();

	SetDrawMode(iDrawMode, iUseDSA, ETrue, iAllowFail);

	if (iAllowFail && iSurface == EGL_NO_SURFACE) {
		iDrawMode = EEGLWindow;
		iUseDSA = EFalse;
		iAllowFail = EFalse;
		SetDrawMode(iDrawMode, iUseDSA, ETrue, iAllowFail);
	}
}

void CGLAppView::SetDrawMode(TDrawMode aMode, TBool aUseDSA, TBool aReset, TBool aAllowFail) {
	if (aMode == EEGLWindow)
		aUseDSA = EFalse;

	if (aUseDSA != iUseDSA || aReset) {
		iUseDSA = aUseDSA;

		delete iDrawer;
		iDrawer = NULL;

		if (iUseDSA) {
			iDrawer = CDirectScreenAccess::NewL(iEikonEnv->WsSession(), *(iEikonEnv->ScreenDevice()), Window(), *this);
			iEikonEnv->WsSession().Flush();
			TRAPD(err, iDrawer->StartL());
			if (err == KErrNone) {
				iDrawer->ScreenDevice()->SetAutoUpdate(ETrue);
				iDSAStarted = ETrue;
			}
		}
	}

	if (aMode != iDrawMode || aReset) {
		iDrawMode = aMode;
		InitEGL(aAllowFail);
	}

}

static TBool Better(TInt aSize, TInt aGreen, TInt aAlpha, TInt aBestSize, TInt aBestGreen, TInt aBestAlpha) {
	// sort according to total size, red size, alpha
	if (aSize > aBestSize) return EFalse;
	if (aSize < aBestSize) return ETrue;
	if (aGreen > aBestGreen) return EFalse;
	if (aGreen < aBestGreen) return ETrue;
	if (aAlpha > aBestAlpha) return EFalse;
	if (aAlpha < aBestAlpha) return ETrue;
	return EFalse;
}

void CGLAppView::InitEGL(TBool aAllowFail) {
	EGLConfig config;
	TBool reinit = EFalse;

	if (!iEGLInited) {
		iDisplay = eglGetDisplay(EGL_DEFAULT_DISPLAY);
		if (!iDisplay) {
			_LIT(KGetDisplayFailed, "eglGetDisplay failed");
			User::Panic(KGetDisplayFailed, eglGetError());
		}

		if (eglInitialize(iDisplay, NULL, NULL) == EGL_FALSE) {
			_LIT(KInitializeFailed, "eglInitialize failed");
			User::Panic(KInitializeFailed, eglGetError());
		}

		iEGLInited = ETrue;
	} else {
		AppClearContext();
		eglMakeCurrent(iDisplay, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
		eglDestroySurface(iDisplay, iSurface);
		eglDestroyContext(iDisplay, iContext);
		iSurface = EGL_NO_SURFACE;
		iContext = EGL_NO_CONTEXT;
		reinit = ETrue;
	}

	EGLConfig *configList = NULL;
	EGLint numConfigs = 0, configSize = 0;

	if (eglGetConfigs(iDisplay, configList, configSize, &numConfigs) == EGL_FALSE) {
		_LIT(KGetConfigsFailed, "eglGetConfigs failed");
		User::Panic(KGetConfigsFailed, eglGetError());
	}

	configSize = numConfigs;
	configList = (EGLConfig*) User::Alloc(sizeof(EGLConfig)*configSize);
	if (!configList) {
		_LIT(KConfigAllocFailed, "config alloc failed");
		User::Panic(KConfigAllocFailed, eglGetError());
	}

	TDisplayMode mode = Window().DisplayMode();
	TInt bufferSize = 0;
	TInt minGreen = 0;

	switch (mode) {
		case EColor4K: bufferSize = 12; minGreen = 4; break;
		case EColor64K: bufferSize = 16; minGreen = 6; break;
		case EColor16M: bufferSize = 24; minGreen = 8; break;
		case EColor16MU: bufferSize = 32; minGreen = 8; break;
		default:
			_LIT(KModeError, "unsupported displaymode");
			User::Panic(KModeError, 0);
			break;
	}
	RFileLogger::WriteFormat(_L("debug"), _L("egl.txt"), EFileLoggingModeAppend, _L("mode: %d bs: %d mg: %d"), mode, bufferSize, minGreen);

	EGLint type = EGL_WINDOW_BIT;
	switch (iDrawMode) {
	case EEGLWindow:
		type = EGL_WINDOW_BIT;
		break;
	case EPixmap:
		type = EGL_PIXMAP_BIT;
		break;
	case EPbuffer:
		type = EGL_PBUFFER_BIT;
		break;
	}

#ifdef USE_OES_1_1
	type |= EGL_PBUFFER_BIT;
#endif

	EGLint attribList[] = {
		EGL_BUFFER_SIZE, bufferSize, EGL_DEPTH_SIZE, 16,
		EGL_SURFACE_TYPE, type,
		EGL_NONE
	};

	if (eglChooseConfig(iDisplay, attribList, configList, configSize, &numConfigs) == EGL_FALSE) {
		_LIT(KChooseConfigFailed, "eglChooseConfig failed");
		User::Panic(KChooseConfigFailed, eglGetError());
	}

	int best = -1;
	int bestGreen = 0;
	int bestSize = 0;
	int bestAlpha = 0;
	for (int n = 0; n < numConfigs; n++) {
		EGLint red, green, blue, alpha, size;
		if (eglGetConfigAttrib(iDisplay, configList[n], EGL_RED_SIZE, &red) != EGL_TRUE) continue;
		if (eglGetConfigAttrib(iDisplay, configList[n], EGL_GREEN_SIZE, &green) != EGL_TRUE) continue;
		if (eglGetConfigAttrib(iDisplay, configList[n], EGL_BLUE_SIZE, &blue) != EGL_TRUE) continue;
		if (eglGetConfigAttrib(iDisplay, configList[n], EGL_ALPHA_SIZE, &alpha) != EGL_TRUE) continue;
		if (eglGetConfigAttrib(iDisplay, configList[n], EGL_BUFFER_SIZE, &size) != EGL_TRUE) continue;


		if (green < minGreen) continue;

		RFileLogger::WriteFormat(_L("debug"), _L("egl.txt"), EFileLoggingModeAppend, _L("rgbas: %d %d %d %d %d - %d"), red, green, blue, alpha, size, n);

		if (best < 0) {
			best = n;
			bestGreen = green;
			bestSize = size;
			bestAlpha = alpha;
		} else {
			if (Better(size, green, alpha, bestSize, bestGreen, bestAlpha)) {
//			if (size <= bestSize && green <= bestGreen && alpha <= bestAlpha) {
				best = n;
				bestGreen = green;
				bestSize = size;
				bestAlpha = alpha;
			}
		}
	}
	if (best < 0) {
		if (aAllowFail)
			return;
		_LIT(KNoSuitableConfigs, "No suitable configs");
		User::Panic(KNoSuitableConfigs, 0);
	}
	RFileLogger::WriteFormat(_L("debug"), _L("egl.txt"), EFileLoggingModeAppend, _L("using config %d"), best);

	config = configList[best];
	User::Free(configList);

	switch (iDrawMode) {
	case EEGLWindow:
		iSurface = eglCreateWindowSurface(iDisplay, config, &Window(), NULL);
		break;
	case EPixmap:
		iSurface = eglCreatePixmapSurface(iDisplay, config, iBitmap, NULL);
		break;
	case EPbuffer: {
			EGLint surfaceAttribs[] = {
				EGL_WIDTH, iBitmap->SizeInPixels().iWidth,
				EGL_HEIGHT, iBitmap->SizeInPixels().iHeight,
				EGL_NONE
			};
			iSurface = eglCreatePbufferSurface(iDisplay, config, surfaceAttribs);
		}
		break;
	}

	if (!iSurface) {
		if (aAllowFail)
			return;
		_LIT(KCreateSurfaceFailed, "eglCreate*Surface failed");
		User::Panic(KCreateSurfaceFailed, eglGetError());
	}

	iContext = eglCreateContext(iDisplay, config, NULL, NULL);
	if (!iContext) {
		_LIT(KCreateContextFailed, "eglCreateContext failed");
		User::Panic(KCreateContextFailed, eglGetError());
	}

	if (eglMakeCurrent(iDisplay, iSurface, iSurface, iContext) == EGL_FALSE) {
		_LIT(KMakeCurrentFailed, "eglMakeCurrent failed");
		User::Panic(KMakeCurrentFailed, eglGetError());
	}

	if (reinit)
		ReinitApp();
}


void CGLAppView::SetForeground(TBool aForeground) {
	iForeground = aForeground;
	SetDrawing(aForeground);
}

void CGLAppView::SetDrawing(TBool aDrawing) {
	if (!iForeground)
		aDrawing = EFalse;
	if (!iPeriodic)
		return;
	if (aDrawing) {
		if (!iStarted) {
			iPeriodic->Start(100, 100, TCallBack(CGLAppView::StaticCallback, this));
			iLastTick = User::TickCount();
		}
	} else {
		if (iStarted)
			iPeriodic->Cancel();
	}
	iStarted = aDrawing;
}


void CGLAppView::Draw(const TRect& aRect) const {
	CWindowGc& gc = SystemGc();
#ifdef HYBRID_EGL_VERSION // defined on rasteroid 3 and newer
	if (iDrawMode != EEGLWindow)
		gc.BitBlt(TPoint(0, 0), iBitmap);
#else
#ifndef UIQ3
	if (iDrawMode == EEGLWindow) {
		eglCopyBuffers(iDisplay, iSurface, iBitmap);
		eglWaitGL();
	}
#endif
	gc.BitBlt(TPoint(0, 0), iBitmap);
#endif
}


void CGLAppView::Update() {
	if (!iForeground) return;
	TInt err = KErrNone;
	if (!iDSAStarted) {
		TRAP(err, iDrawer->StartL());
		if (err == KErrNone) {
			iDrawer->ScreenDevice()->SetAutoUpdate(ETrue);
			iDSAStarted = ETrue;
		}
	}
	if (err == KErrNone) {
		iDrawer->Gc()->BitBlt(TPoint(0, 0), iBitmap);
	}
}

void CGLAppView::Restart(RDirectScreenAccess::TTerminationReasons aReason) {
	SetDrawing(ETrue);
}

void CGLAppView::AbortNow(RDirectScreenAccess::TTerminationReasons aReason) {
	SetDrawing(EFalse);
	iDSAStarted = EFalse;
}


void CGLAppView::EnableCallback(TBool aEnable) {
	iInCallback = !aEnable;
}

TInt CGLAppView::StaticCallback(TAny* aArg) {
	CGLAppView* view = (CGLAppView*) aArg;
	if (view->iInCallback) return 0;
	view->iInCallback = ETrue;
	view->Callback();
	view->iInCallback = EFalse;
	return 0;
}

void CGLAppView::FinishGLDrawing() {
	if (iDrawMode == EPbuffer) {
		eglCopyBuffers(iDisplay, iSurface, iBitmap);
		eglWaitGL();
	}
}

void CGLAppView::Callback() {
	iFrame++;

	TInt tick = User::TickCount();
	iRelTick += tick - iLastTick;
	iTime = iRelTick*iPeriod;
	iLastTick = tick;

	UpdateAndDraw();
	if (!iForeground) return;

	iFrameTick[iFrame % iFrameTickLength] = iRelTick;


	if (iDrawMode == EEGLWindow) {
		eglSwapBuffers(iDisplay, iSurface);
	} else {
		if (iUseDSA)
			Update();
		else
			DrawNow();
	}

	if (iLastFPSTime == (TUint)-1)
		iLastFPSTime = iTime;

	if ((tick - iLastResetTick)*iPeriod >= 3000) {
		User::ResetInactivityTime();
		iLastResetTick = tick;
	}
	if ((tick - iLastAfterTick)*iPeriod >= 1500) {
		User::After(0);
		iLastAfterTick = tick;
	}

	if (iTime - iLastFPSTime > 1000) {
		iLastFPS = 1000*(iFrame - iLastFPSFrame)/(iTime - iLastFPSTime);
		FPSUpdated();
		iLastFPSTime = iTime;
		iLastFPSFrame = iFrame;
	}
}

