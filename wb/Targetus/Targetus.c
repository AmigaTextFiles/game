/*

	$VER: Targetus.c 3.0 (20.03.1997)
	Copyright 1991, 1995, 1997 by Dalibor Kezele

	e-mail: dkezele@mia.os.carnet.hr

*/

#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfx.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>

void
	SafeExit(int code),
	DrawTarget(void),
	PrintScore(char * message),
	CheckShoot(void),
	AskWait(char *message, char *gadgetmsg, char *condition, struct Image *image),
	AskExit(void),
	ChangeSpeed(unsigned char high_low),
	AboutTarget(void),
	HighScore(void),
	_cli_parse() { };

struct GfxBase *GfxBase;
struct IntuitionBase *IntuitionBase;
struct Window *win1, *win2;
struct Screen *WB;
struct RastPort *rport1, *rport2;
struct IntuiMessage *imsg1, *imsg2;

char
	version[] = "$VER: Targetus 3.0 (20.03.1997) Copyright by Dalibor Kezele",
	highname[10] = "(NOBODY)",
	txtsht[6] = "SHOOT",
	scoretext[160],
	gadgtmsg[80],
	gadgtext[80],
	text1[48] = "Targetus version 3.0, 15.03.1997",
	text2[48] = "Author's address:  Dalibor Kezele",
	text3[48] = "                   Toplicka 127",
	text4[48] = "                   42204 Turcin",
	text5[48] = "                   CROATIA",
	text6[48] = "and e-mail: dkezele@mia.os.carnet.hr",
	text7[48] = "Feel the best power of BLAZEMONGER (tm).",
	text8[18] = "Enter a name:",
	topaz[12] = "topaz.font",
	bms[16], bus[16];

struct TextAttr
	T8 = { (UBYTE *) topaz, 8, 0, 0 },
	T9 = { (UBYTE *) topaz, 9, 0, 0 };

short
	coordin1[10] = { 611, 13, 611, 185, 7, 185, 7, 13, 611, 13 },
	coordin2[10] = { 72, 0, 72, 11, 0, 11, 0, 0, 72, 0 },
	coordin3[10] = { 338, 1, 338, 84, 1, 84, 1, 1, 338, 1 },
	coordin4[10] = { 38, 1, 38, 26, 1, 26, 1, 1, 38, 1 },
	coordin5[10] = { 0, 0, 107, 0, 107, 11, 0, 11, 0, 0 },
	coordin6[10] = { 117, 0, 117, 25, 0, 25, 0, 0, 117, 0 },
	coordin7[10] = { 38, 1, 38, 53, 1, 53, 1, 1, 38, 1 };

struct StringInfo
	strinfo = { (UBYTE *)bms, (UBYTE *)bus, 0, 9, 0, 0, 9, 0, 0, 0, 0L, 0, 0L };

struct Border
	border1 = { 0, 0, 1, 0, JAM1, 3, &coordin1[0], 0L },
	border2 = { 0, 0, 2, 0, JAM1, 3, &coordin1[4], &border1 },
	border3 = { 0, 0, 1, 0, JAM1, 3, &coordin2[0], 0L },
	border4 = { 0, 0, 2, 0, JAM1, 3, &coordin2[4], &border3 },
	border5 = { 0, 0, 2, 0, JAM1, 3, &coordin3[0], 0L },
	border6 = { 0, 0, 1, 0, JAM1, 3, &coordin3[4], &border5 },
	border7 = { 0, 0, 1, 0, JAM1, 3, &coordin4[0], 0L },
	border8 = { 0, 0, 2, 0, JAM1, 3, &coordin4[4], &border7 },
	border9 = { -3, -2, 3, 0, JAM1, 5, &coordin5[0], 0L },
	border10 = { 0, 0, 2, 0, JAM1, 3, &coordin6[0], 0L },
	border11 = { 0, 0, 1, 0, JAM1, 3, &coordin6[4], &border10 },
	border12 = { 0, 0, 1, 0, JAM1, 3, &coordin7[0], 0L },
	border13 = { 0, 0, 2, 0, JAM2, 3, &coordin7[4], &border12 };

struct IntuiText
	itext0 = { 0, 1, JAM1,  4, 1, &T8, (UBYTE *) "Slower", 0L },
	itext1 = { 0, 1, JAM1,  4, 1, &T8, (UBYTE *) "Faster", 0L },
	itext2 = { 0, 1, JAM1,  2, 1, &T8, (UBYTE *) "------------", 0L },
	itext3 = { 0, 1, JAM1,  4, 1, &T8, (UBYTE *) "Pause", 0L },
	itext4 = { 0, 1, JAM1,  4, 1, &T8, (UBYTE *) "About", 0L },
	itext5 = { 0, 1, JAM1,  4, 1, &T8, (UBYTE *) "Quit", 0L },
	sctext = { 3, 0, JAM2,  0, 0, &T8, (UBYTE *) &scoretext, 0L },
	rbtext = { 0, 1, JAM1, 20, 4, &T8, (UBYTE *) "Are you sure ?", 0L},
	rptext = { 0, 1, JAM1,  6, 4, &T8, (UBYTE *) "Yes", 0L},
	rntext = { 0, 1, JAM1,  7, 4, &T8, (UBYTE *) "No", 0L},
	intxt0 = { 1, 0, JAM1, 5,  2, &T8, (UBYTE *) &gadgtmsg, 0L },
	intxt7 = { 2, 0, JAM2, 0, 64, &T8, (UBYTE *) text7, 0L },
	intxt6 = { 1, 0, JAM2, 0, 52, &T8, (UBYTE *) text6, &intxt7 },
	intxt5 = { 1, 0, JAM2, 0, 42, &T8, (UBYTE *) text5, &intxt6 },
	intxt4 = { 1, 0, JAM2, 0, 32, &T8, (UBYTE *) text4, &intxt5 },
	intxt3 = { 1, 0, JAM2, 0, 22, &T8, (UBYTE *) text3, &intxt4 },
	intxt2 = { 1, 0, JAM2, 0, 12, &T8, (UBYTE *) text2, &intxt3 },
	intxt1 = { 3, 0, JAM2, 0,  0, &T9, (UBYTE *) text1, &intxt2 },
	sttext = { 1, 0, JAM1, 0, -11, &T8, (UBYTE *) text8, NULL };

struct Gadget
	gadget = { 0L, 90, 21, 73, 12, GADGHCOMP, GADGIMMEDIATE|RELVERIFY,
		BOOLGADGET, (APTR) &border4, 0L, &intxt0, 0L, 0L, 1, 0L },
	gadget2 = { 0L, 75, 28, 104, 10, GADGHCOMP, RELVERIFY|STRINGCENTER,
		STRGADGET, (APTR)&border9, 0L, &sttext, 0L, (APTR)&strinfo, 1, 0L };

struct NewWindow
	neww0 = {
		0, 0, 620, 200, 0, 1, CLOSEWINDOW|MENUPICK|MOUSEBUTTONS|VANILLAKEY
		|ACTIVEWINDOW|INACTIVEWINDOW, WINDOWCLOSE|WINDOWDRAG|
		WINDOWDEPTH|ACTIVATE|NOCAREREFRESH, 0L, 0L, (UBYTE *) "Targetus", 0L, 0L,
		0, 0, 0, 0, CUSTOMSCREEN },
	neww1 = {
		0, 0, 200, 46, 0, 1, GADGETUP|CLOSEWINDOW|VANILLAKEY,
		WINDOWDRAG|WINDOWCLOSE|ACTIVATE|RMBTRAP|NOCAREREFRESH,
		&gadget, 0L, (UBYTE *) gadgtext, 0L, 0L, 0, 0, 0, 0, CUSTOMSCREEN },
	neww2 = {
		0, 0, 404, 100, 0, 1, CLOSEWINDOW|MOUSEBUTTONS|VANILLAKEY,
		WINDOWCLOSE|WINDOWDRAG|ACTIVATE|RMBTRAP|NOCAREREFRESH,
		0L, 0L, (UBYTE *) "About Targetus", 0L, 0L, 0, 0, 0, 0, CUSTOMSCREEN },
	neww3 = {
		0, 0, 200, 46, 0, 1, GADGETUP|GADGETDOWN,
		NOCAREREFRESH|WINDOWDRAG|ACTIVATE|RMBTRAP, &gadget2, 0,
		(UBYTE *)"Targetus high score", 0L, 0L, 0, 0, 0, 0, CUSTOMSCREEN };

struct MenuItem
	mintxt6 = {
		0L, 10, 60, 92, 9, ITEMTEXT|ITEMENABLED|HIGHBOX|COMMSEQ,
		0L, (APTR) &itext5, 0L, 'Q', 0L, 0 },
	mintxt5 = {
		&mintxt6, 10, 49, 92, 9, ITEMTEXT|ITEMENABLED|HIGHCOMP|COMMSEQ,
		0L, (APTR) &itext4, 0L, 'A', 0L, 0 },
	mintxt4 = {
		&mintxt5, 6, 40, 92, 10, ITEMTEXT|HIGHNONE,
		0L, (APTR) &itext2, 0L, 0, 0L, 0 },
	mintxt3 = {
		&mintxt4, 10, 30, 92, 10, ITEMTEXT|ITEMENABLED|HIGHCOMP|COMMSEQ,
		0L, (APTR) &itext3, 0L, 'P', 0L, 0 },
	mintxt2 = {
		&mintxt3, 6, 20, 92, 10, ITEMTEXT|HIGHNONE,
		0L, (APTR) &itext2, 0L, 0, 0L, 0 },
	mintxt1 = {
		&mintxt2, 10, 10, 92, 10, ITEMTEXT|ITEMENABLED|HIGHCOMP|COMMSEQ,
		0L, (APTR) &itext1, 0L, 'F', 0L, 0 },
	mintxt0 = {
		&mintxt1, 10, 0, 92, 10, ITEMTEXT|ITEMENABLED|HIGHCOMP|COMMSEQ,
		0L, (APTR) &itext0, 0L, 'S', 0L, 0 };

struct Menu
	menu = {
		0L, 0, 0, 112, 10, MENUENABLED, (BYTE *) " Preferences ", &mintxt0, 0, 0, 0, 0 };

UWORD
	pointer_data[32] = {
		0x0000, 0x0000, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
		0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0280, 0x0280,
		0xfefe, 0xfefe, 0x0280, 0x0280, 0x0100, 0x0100, 0x0100, 0x0100,
		0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0000, 0x0000 },
	*pointer_chip,
	image_data[32] = {
		0x03C0, 0x07e0, 0x0cf0, 0x7ffe, 0x1818, 0x1818, 0x1818, 0x0c30,
		0x0660, 0x7c3e, 0xe007, 0xc003, 0xc003, 0xc003, 0xc003, 0xffff,
		0x0000, 0x0000, 0x0300, 0x0000, 0x07e0, 0x07e0, 0x07e0, 0x03c0,
		0x0180, 0x03c0, 0x1ff8, 0x3ffc, 0x3ffc, 0x3ffc, 0x3ffc, 0x0000 },
	*image_chip,
	caffee_data[32] = {
		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
		0x3ffc, 0x7ffe, 0x3ffc, 0x1ff8, 0x1ff8, 0x0ff0, 0xe007, 0x7ffe,
		0x0550, 0x0aa8, 0x0550, 0x02a0, 0x0150, 0x02a0, 0x0140, 0x0280,
		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe007, 0x7ffe },
	*caffee_chip,
	info_data[32] = {
		0x0fc0, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x0fc0,
		0x0000, 0x0fc0, 0x1ee0, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60,
		0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60,
		0x1f60, 0x1f60, 0x7fbe, 0xffc3, 0xffc3, 0xffc3, 0xffc3, 0xffff },
	*info_chip,
	mark_data[32] = {
		0x0fc0, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60, 0x1f60,
		0x1f60, 0x1f60, 0x0fc0, 0x0000, 0x0fc0, 0x1f60, 0x1f60, 0x0fc0,
		0x0000, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080,
		0x0080, 0x0080, 0x0000, 0x0000, 0x0000, 0x0080, 0x0080, 0x0000 },
	*mark_chip;

struct Image
	targetimage = { 0, 0, 16, 16, 2, 0L, 3, 0, 0L },
	caffeeimage = { 0, 0, 16, 16, 2, 0L, 3, 0, 0L },
	infoimage = { 0, 0, 16, 32, 1, 0L, 1, 0, 0L },
	markimage = { 0, 0, 16, 16, 2, 0L, 3, 0, 0L };

int
	speed = 60, real = 50, score = 0, high = 0, target = 0, toggle = 0, timer = 0;

unsigned char targetx, quit = 0;
char targety, count;
long xt = 100, yt = 100;
unsigned mousex, mousey;

/* -------------------------------------------------------------------- */

int main(void)
{

if(!(GfxBase = (struct GfxBase *) OpenLibrary("graphics.library", 0L)))
	SafeExit(100);

if(!(IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library", 0L)))
	SafeExit(200);

if(!(image_chip = (UWORD *) AllocMem ((long)(2L * sizeof(image_data)), MEMF_CHIP)))
	SafeExit(300);

if(!(caffee_chip = (UWORD *) AllocMem ((long)(2L * sizeof(image_data)), MEMF_CHIP)))
	SafeExit(400);

if(!(info_chip = (UWORD *) AllocMem ((long)(2L * sizeof(info_data)), MEMF_CHIP)))
	SafeExit(500);

if(!(mark_chip = (UWORD *) AllocMem ((long)(2L * sizeof(mark_data)), MEMF_CHIP)))
	SafeExit(600);

if(!(pointer_chip = (UWORD *) AllocMem((long)(sizeof(pointer_data)), MEMF_CHIP)))
	SafeExit(700);

WB = (struct Screen *) IntuitionBase -> ActiveScreen;
neww0.Screen = neww1.Screen = neww2.Screen = neww3.Screen = (struct Screen *) WB;

neww0.TopEdge = ((WB -> Height) - (neww0.Height)) / 2;
neww0.LeftEdge = ((WB -> Width) - (neww0.Width)) / 2;

neww1.TopEdge = ((WB -> Height) - (neww1.Height)) / 2;
neww1.LeftEdge = ((WB -> Width) - (neww1.Width)) / 2;

neww2.TopEdge = ((WB -> Height) - (neww2.Height)) / 2;
neww2.LeftEdge = ((WB -> Width) - (neww2.Width)) / 2;

neww3.TopEdge = ((WB -> Height) - (neww3.Height)) / 2;
neww3.LeftEdge = ((WB -> Width) - (neww3.Width)) / 2;

if(!(win1 = (struct Window *) OpenWindow(&neww0)))
	SafeExit(800);

for (count = 0; count < 32; count++)

for (count = 0; count < 32; count++) {
	*(image_chip + count) = image_data[count];
	*(caffee_chip + count) = caffee_data[count];
	*(info_chip + count) = info_data[count];
	*(pointer_chip + count) = pointer_data[count];
	*(mark_chip + count) = mark_data[count];
	}

targetimage.ImageData = image_chip;
caffeeimage.ImageData = caffee_chip;
infoimage.ImageData = info_chip;
markimage.ImageData = mark_chip;

rport1 = win1 -> RPort;

DrawBorder(rport1, &border2, 0, 0);

AskWait("Start Targetus", "Execute!", "START", &markimage);

SetPointer(win1, (short *) pointer_chip, 14, 16, -7, -7);
SetMenuStrip(win1, &menu);

srand(rand());
DrawTarget();

while (!quit) {
	Delay(1L);
	if(timer++ >= speed) DrawTarget();

	imsg1 = (struct IntuiMessage *) GetMsg(win1->UserPort);
	if (!imsg1) continue;

	switch (imsg1 -> Class) {
		case CLOSEWINDOW:
			AskExit();
			break;

		case INACTIVEWINDOW:
			while(1) {
				Delay(5L);
				imsg1 = (struct IntuiMessage *) GetMsg(win1->UserPort);
				if(!imsg1) continue;
				if(imsg1 -> Class == ACTIVEWINDOW) break;
				ReplyMsg(imsg1);
				}
			break;

		case VANILLAKEY:
			if(imsg1 -> Code == 27) quit = 1;
				break;

		case MENUPICK :
			if (!(MENUNUM(imsg1 -> Code)))
				switch(ITEMNUM(imsg1 -> Code)) {
					case 0: ChangeSpeed(FALSE); break;
					case 1: ChangeSpeed(TRUE); break;
					case 3: AskWait("Targetus Pause", "Continue", "PAUSE", 0L); break;
					case 5: AboutTarget(); break;
					case 6: AskExit();
				}
			break;

		case MOUSEBUTTONS:
			if (toggle ^= 1) CheckShoot();
		}

	ReplyMsg(imsg1);
	}

ClearMenuStrip(win1, &menu);
ClearPointer(win1);

SafeExit(0);
return 0;
}

/* -------------------------------------------------------------------- */

void SafeExit(int code)
{

if(code)
	puts("***ERROR: Not enough memory!\n");
if(pointer_chip)
	FreeMem(pointer_chip, (long)(sizeof(pointer_data)));
if(mark_chip)
	FreeMem(mark_chip, (long)(2L * sizeof(mark_data)));
if(info_chip)
	FreeMem(info_chip, (long)(2L * sizeof(info_data)));
if(caffee_chip)
	FreeMem(caffee_chip, (long)(2L * sizeof(caffee_data)));
if(image_chip)
	FreeMem(image_chip, (long)(2L * sizeof(image_data)));
if(win1)
	CloseWindow(win1);
if(IntuitionBase)
	CloseLibrary(IntuitionBase);
if(GfxBase)
	CloseLibrary(GfxBase);
if(code)
	exit(code);
}

/* -------------------------------------------------------------------- */

void DrawTarget(void)
{

SetAPen(rport1, 0);
RectFill(rport1, xt, yt, xt + 16, yt + 16);

targetx = rand();
targety = rand();
if (targety == -128) targety = 127;
if (targety < 0) targety =- targety;
xt = targetx * 2 + 45;
yt = targety + 30;
if (target++ == 64) {
	target = 0;
	if(high < score) HighScore();
	AskWait("Targetus Game Over", "New Game", "START", &markimage);
	score = 0;
	}
timer = 0;

DrawImage(rport1, &targetimage, xt, yt);
PrintScore(0L);

}

/* -------------------------------------------------------------------- */

void PrintScore(char *message)
{

if(!message) message = &txtsht[0];

real = 110 - speed;

sprintf(&scoretext,
	"[%5s]  Score: %04d · Speed: %04d · Target: # %02d · High: %04d by %-9s",
	message, score, real * 100, target, high, &highname);

PrintIText(rport1, &sctext, 12, 189);

}

/* -------------------------------------------------------------------- */

void CheckShoot(void)
{

mousex = win1 -> MouseX;
mousey = win1 -> MouseY;

if ((mousex >= xt) && (mousey >= yt)
	&& (mousex <= xt + 16) && (mousey <= yt + 16)) {
		score += real;
		DisplayBeep(win1 -> WScreen);
		DrawTarget();
		}
}

/* -------------------------------------------------------------------- */

void AskExit(void)
{

PrintScore("QUIT?");

quit = (unsigned char)
	AutoRequest (win1, &rbtext, &rptext, &rntext, 0, 0, 170, 50);

PrintScore(0L);

}

/* -------------------------------------------------------------------- */

void AskWait(char *message, char *gadgetmsg, char *condition, struct Image *image)
{

PrintScore(condition);
strcpy(&gadgtext, message);
strcpy(&gadgtmsg, gadgetmsg);

if(!image) image = &caffeeimage;

win2 = (struct Window *) OpenWindow(&neww1);
if (win2) {

	rport2 = win2 -> RPort;
	DrawImage(rport2, image, 25, 19);
	DrawBorder(rport2, &border8, 13, 13);
	DrawBorder(rport2, &border11, 67, 14);

	while(1) {
		Delay(5L);
		imsg2 = (struct IntuiMessage *) GetMsg(win2->UserPort);
		if(!imsg2) continue;
		if(imsg2 -> Class == GADGETUP) break;
		if(imsg2 -> Class == CLOSEWINDOW) break;
		if((imsg2 -> Class == VANILLAKEY) && (imsg2 -> Code == 13)) break;
		}

	ReplyMsg(imsg2);
	CloseWindow(win2);
	}
else
	DisplayBeep(win1 -> WScreen);

PrintScore(0L);

}

/* -------------------------------------------------------------------- */

void ChangeSpeed(unsigned char high_low)
{

if(!high_low) {
	if (speed < 100) speed += 5;
		}
else
	if (speed > 15) speed -= 5;

PrintScore(0L);
}

/* -------------------------------------------------------------------- */

void AboutTarget(void)
{

PrintScore("ABOUT");

if(win2 = (struct Window *) OpenWindow (&neww2)) {

	rport2 = win2 -> RPort;

	PrintIText(rport2, &intxt1, 66, 20);
	DrawBorder(rport2, &border6, 56, 12);

	DrawImage(rport2, &targetimage, 21, 76);
	DrawBorder(rport2, &border8, 9, 70);

	DrawImage(rport2, &infoimage, 21, 24);
	DrawBorder(rport2, &border13, 9, 12);

	while (1) {
		Delay(5L);
		imsg2 = (struct IntuiMessage *) GetMsg(win2 -> UserPort);
		if(!imsg2) continue;
		if ((imsg2 -> Class == CLOSEWINDOW)
			|| (imsg2 -> Class == MOUSEBUTTONS))
				break;
		if ((imsg2 -> Class == VANILLAKEY)
			&& (imsg2 -> Code == 27 || imsg2 -> Code == 13))
				break;
		}
	ReplyMsg(imsg2);
	CloseWindow(win2);
	}
else
	DisplayBeep(win1 -> WScreen);

PrintScore(0L);
}

/* -------------------------------------------------------------------- */

void HighScore(void)
{

PrintScore("SCORE");

high = score;
if(win2 = (struct Window *) OpenWindow (&neww3)) {

	rport2 = win2 -> RPort;

	DrawImage(rport2, &markimage, 25, 19);
	DrawBorder(rport2, &border8, 13, 13);
	DrawBorder(rport2, &border11, 67, 14);

	do {
		ActivateGadget(&gadget2, win2, 0L);

		while(1) {
			Delay(5L);
			imsg2 = (struct IntuiMessage *) GetMsg(win2->UserPort);
			if(!imsg2) continue;
			if(imsg2 -> Class == GADGETUP) break;
			ReplyMsg(imsg2);
			}
		}
		while(!strlen(&bms));

	strcpy(&highname, &bms);
	CloseWindow(win2);
	}
else
	DisplayBeep(win1 -> WScreen);

PrintScore(0L);
}

/* -------------------------------------------------------------------- */
