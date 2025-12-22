#include <proto/intuition.h>
#include <proto/graphics.h>

#define MAXROWS 50	/* just for window sizing */
#define MAXCOLS 100

#define FONTHEIGHT 8
#define FONTWIDTH 8
extern unsigned char fontheight;
extern unsigned char fontwidth;

extern struct ReqLib *ReqBase;
extern struct IntuitionBase *IntuitionBase;
extern struct GfxBase *GfxBase;
extern struct Window *WLWin,*DPWin;
extern struct RastPort *WLRP,*DPRP;
extern struct IntuiMessage *IMsg,Msg;

extern struct Gadget Words[];
extern struct StringInfo WordInfo[];
extern struct Gadget *LastWord;

extern struct PropInfo xp, yp, zp;
extern struct Image ximg, yimg, zimg;
extern struct Gadget x, y, z;
extern struct NewWindow NewWinWL, NewWinDP;

extern struct IntuiText IText[], IT[];

extern struct MenuItem M0I4[],M0I5[],M1I1[],M1I2[],M2I2[],M0[],M1[],M2[],M3[];
extern struct Menu TheMenu[];
