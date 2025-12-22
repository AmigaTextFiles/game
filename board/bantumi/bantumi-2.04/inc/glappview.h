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

#ifndef __GLAPPVIEW_H
#define __GLAPPVIEW_H

#include <GLES/egl.h>

#ifdef UIQ3
#include <qikviewbase.h>
class CGLAppView : public CQikViewBase, public MDirectScreenAccess {
#else
#include <coecntrl.h>
class CGLAppView : public CCoeControl, public MDirectScreenAccess {
#endif
public:

	enum TDrawMode { EEGLWindow, EPixmap, EPbuffer };
	enum TWindowMode { EWindowed, EFullscreen };

	~CGLAppView();
	void Draw(const TRect& aRect) const;
	static int StaticCallback(TAny* aArg);

	void SizeChanged();

	void SetForeground(TBool aForeground);

	void Restart(RDirectScreenAccess::TTerminationReasons aReason);
	void AbortNow(RDirectScreenAccess::TTerminationReasons aReason);

	void SetDrawMode(TDrawMode aMode, TBool aUseDSA = EFalse, TBool aReset = EFalse, TBool aAllowFail = EFalse);
	void SetWindowMode(TWindowMode aMode);

#ifdef UIQ3
	void ViewConstructL();
	void ViewActivatedL(const TVwsViewId& aPrevViewId, TUid aCustomMessageId, const TDesC8& aCustomMessage);
	void ViewDeactivated();
	virtual TInt ViewConfigurationId() const = 0;
	void HandleCommandL(CQikCommand& aCommand);
#else
	void HandleResourceChange(TInt aType);
#endif


	void EnableCallback(TBool aEnable);

protected:
	virtual void InitGC() {}
	virtual void DeinitGC() {}
	virtual void ConstructAppL() {}
	virtual void ReinitApp() {}
	virtual void UpdateAndDraw() { FinishGLDrawing(); }
	virtual void FPSUpdated() {}
	virtual void AppClearContext() {}

#ifdef UIQ3
	CGLAppView(CQikAppUi& aAppUi);
	void ConstructL(TWindowMode aWinMode = EFullscreen, TDrawMode aDrawMode = EEGLWindow, TBool aUseDSA = EFalse, TBool aAllowFail = EFalse);
#else
	CGLAppView();
	void ConstructL(const TRect& aRect, TWindowMode aWinMode = EFullscreen, TDrawMode aDrawMode = EEGLWindow, TBool aUseDSA = EFalse, TBool aAllowFail = EFalse);
#endif

	void ConstructDrawEnvL();

	void FinishGLDrawing();


private:

	void SetupBitmap();
	void Update();
	void InitEGL(TBool aAllowFail);
	void Callback();
	void SetDrawing(TBool aDrawing);


	EGLDisplay iDisplay;
	EGLContext iContext;
	EGLSurface iSurface;
	CPeriodic* iPeriodic;

	CFbsBitmap* iBitmap;
	CFbsBitmapDevice* iDevice;
	CDirectScreenAccess* iDrawer;
	TBool iDSAStarted;

	TBool iEGLInited;

	TBool iInCallback;

	TBool iAllowFail;

protected:
	CFbsBitGc* iGc;

	TInt iFrame;
	TInt iPeriod;
	TUint iLastFPSTime;
	TInt iLastFPSFrame;
	TInt iLastFPS;
	TBool iStarted;
	TInt iLastTick;
	TUint iTime;
	TInt iFrameTickLength;
	TInt *iFrameTick;
	TInt iRelTick;
	TInt iLastResetTick;
	TInt iLastAfterTick;

	TDrawMode iDrawMode;
	TBool iUseDSA;
	TWindowMode iWinMode;

	TBool iForeground;

};

#endif
