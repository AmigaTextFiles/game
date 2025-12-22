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

#include "glfont.h"
#include <e32base.h>
#include <gdi.h>
#include <fbs.h>
#include <bitdev.h>
#ifdef UIQ3
#include <eikenv.h>
#include "bantumiappui.h"
#include "bantumiappview.h"
#else
#include <aknutils.h>
#endif
#include <charconv.h>
#include <flogger.h>
#include <GLES/egl.h>

GLFont *makeGLFont(const char *name, int size, int w, int h, unsigned char first, unsigned char last, unsigned char skipstart, unsigned char skiplast) {
	int offset = first;
	int n = last - offset + 1;
	TexGLFont *f = new TexGLFont(offset, n);
	CFont *font = (CFont*) name;

	CFbsBitmap *bitmap = new(ELeave) CFbsBitmap();
	User::LeaveIfError(bitmap->Create(TSize(w, h), EColor16M));
	CFbsBitmapDevice *device = CFbsBitmapDevice::NewL(bitmap);
	CFbsBitGc *gc;
	User::LeaveIfError(device->CreateContext(gc));

	gc->UseFont(font);
	gc->SetBrushColor(KRgbBlack);
	gc->Clear(TRect(0, 0, w, h));
	gc->SetPenColor(KRgbWhite);

	CCnvCharacterSetConverter *conv = CCnvCharacterSetConverter::NewL();
	conv->PrepareToConvertToOrFromL(KCharacterSetIdentifierIso88591, CEikonEnv::Static()->FsSession());
	TInt state = CCnvCharacterSetConverter::KStateDefault;

	int margin = 1;

	int cury = 0;
	int curx = 0;
	int nexty = cury;
	for (int c = offset; c < offset+n; c++) {
		if (c >= skipstart && c <= skiplast)
			continue;

		TBuf8<10> buf8;
		buf8.Append(c);
		TBuf16<10> buf;
		conv->ConvertToUnicode(buf, buf8, state);

		int width = font->TextWidthInPixels(buf);
		int height = font->HeightInPixels();

		TOpenFontCharMetrics metrics;
		const TUint8 *ptr;
		TSize size;
		font->GetCharacterData(c, metrics, ptr, size);
		int adv = metrics.HorizAdvance();
		TRect r;
		metrics.GetHorizBounds(r);

		if ((curx + width + margin > w && nexty + height + margin > h) || cury + height + margin > h)
			break;
		if (curx + width + margin > w) {
			curx = 0;
			cury = nexty;
		}
		gc->DrawText(buf, TPoint(curx, cury + height - r.iBr.iY));
		f->setParams(c, curx, cury, width, height, adv, 0, font->DescentInPixels() - r.iBr.iY);

		if (cury + height + margin > nexty)
			nexty = cury + height + margin;
		curx += width + margin;

	}

	TUint8 *pixels = new TUint8[4*w*h];
	for (int y = 0; y < h; y++) {
		for (int x = 0; x < w; x++) {
			TRgb c;
			bitmap->GetPixel(c, TPoint(x, y));
			pixels[4*y*w + 4*x + 0] = c.Red();
			pixels[4*y*w + 4*x + 1] = c.Green();
			pixels[4*y*w + 4*x + 2] = c.Blue();
			pixels[4*y*w + 4*x + 3] = (c.Red() + c.Green() + c.Blue())/3;
		}
	}
	f->setImage(pixels, w, h);
	delete pixels;

	delete conv;

	gc->DiscardFont();
	delete gc;
	delete device;
	delete bitmap;

	return f;
}

class SymbianGLFont : public GLFont {
public:
	SymbianGLFont(CFbsBitGc *gc, int h);
	~SymbianGLFont();
	void draw(const char *str, GLTYPE h, GLTYPE offX, GLTYPE offY, const GLTYPE *color);
	void setClipping(int x1, int y1, int x2, int y2);

private:
	CFbsBitGc* gc;
	int height;
	CCnvCharacterSetConverter *conv;
	TInt state;
	const CFont* font1;
	const CFont* font2;
	const CFont* font3;
};

SymbianGLFont::SymbianGLFont(CFbsBitGc *gc, int h) {
	this->gc = gc;
	height = h;

	conv = CCnvCharacterSetConverter::NewL();
	conv->PrepareToConvertToOrFromL(KCharacterSetIdentifierIso88591, CEikonEnv::Static()->FsSession());
	state = CCnvCharacterSetConverter::KStateDefault;
#ifdef UIQ3
	CBantumiAppView* appView = static_cast<CBantumiAppUi*>(CEikonEnv::Static()->AppUi())->AppView();
	font1 = appView->GetFont(1);
	font2 = appView->GetFont(2);
	font3 = appView->GetFont(3);
#elif defined(EKA2)
	font1 = AknLayoutUtils::FontFromId(EAknLogicalFontSecondaryFont);
	font2 = AknLayoutUtils::FontFromId(EAknLogicalFontPrimaryFont);
	font3 = AknLayoutUtils::FontFromId(EAknLogicalFontTitleFont);
#else
	font1 = LatinPlain12();
	font2 = LatinBold13();
	font3 = LatinBold17();
#endif
}

SymbianGLFont::~SymbianGLFont() {
	delete conv;
}

void SymbianGLFont::draw(const char *str, GLTYPE h, GLTYPE offX, GLTYPE offY, const GLTYPE *color) {
	int x = TOINT(offX);
	int y = height - 1 - TOINT(offY);
	gc->DiscardFont();
	const CFont *font = font1;
	if (h > F(0.9*font->HeightInPixels()))
		font = font2;
	if (h > F(font->HeightInPixels()))
		font = font3;

	gc->UseFont(font);
	TRgb rgbcol(TOINT(255*color[0]), TOINT(255*color[1]), TOINT(255*color[2]));
	gc->SetPenColor(rgbcol);
	gc->SetDrawMode(CGraphicsContext::EDrawModePEN);
	TBuf8<50> buf8;
	while (*str)
		buf8.Append((*str++)&0xFF);
	TBuf16<50> buf;
	conv->ConvertToUnicode(buf, buf8, state);
	int textWidth = font->TextWidthInPixels(buf);
	int textHeight = font->HeightInPixels();
	eglWaitGL();
	gc->DrawText(buf, TPoint(x - textWidth/2, y + textHeight/2 - font->DescentInPixels()));
	gc->DiscardFont();
	eglWaitNative(EGL_CORE_NATIVE_ENGINE);
}

void SymbianGLFont::setClipping(int x1, int y1, int x2, int y2) {
	if (x1 == x2 && y1 == y2)
		gc->CancelClippingRect();
	else
		gc->SetClippingRect(TRect(TPoint(x1, height - 1 - y2), TPoint(x2 + 1, height - y1)));
}

GLFont *makeSymbianGLFont(CFbsBitGc *gc, int height) {
	return new SymbianGLFont(gc, height);
}

