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

#ifndef __BANTUMIAPPVIEW_H
#define __BANTUMIAPPVIEW_H

#include <coecntrl.h>
#include <GLES/egl.h>
#include "glappview.h"

class Bantumi;
class BantumiGL;
class GLFont;

class CBantumiAppView : public CGLAppView {
public:

#ifdef UIQ3
	static CBantumiAppView* NewL(CQikAppUi& aAppUi, TBool aFullscreen);
	static CBantumiAppView* NewLC(CQikAppUi& aAppUi, TBool aFullscreen);
	TVwsViewId ViewId() const;
	TInt ViewConfigurationId() const;
	const CFont* GetFont(TInt aFont);
#else
	static CBantumiAppView* NewL(const TRect& aRect, TBool aFullscreen);
	static CBantumiAppView* NewLC(const TRect& aRect, TBool aFullscreen);
#endif
	~CBantumiAppView();

	TKeyResponse OfferKeyEventL(const TKeyEvent& aKeyEvent, TEventCode aType);
	void HandlePointerEventL(const TPointerEvent& aPointerEvent);
#ifdef UIQ3
	void HandleCommandL(CQikCommand& aCommand);
#endif

	void SizeChanged();
	void InitFonts();

	void SetStoredData(TInt aNum, TInt aLevel);

protected:
	void DeinitGC();
	void InitGC();
	void ConstructAppL();
	void ReinitApp();
	void UpdateAndDraw();
	void FPSUpdated();

private:
#ifdef UIQ3
	CBantumiAppView(CQikAppUi& aAppUi);
#else
	CBantumiAppView();
#endif

	const CFont* iFont;

public:
	Bantumi* iBantumi;
	BantumiGL* iBantumiGL;
	GLFont* iGLNumFont;
	GLFont* iGLTextFont;
	TBool iExit;

	TBool iStoredData;
	TInt iNum;
	TInt iLevel;

};

#endif
