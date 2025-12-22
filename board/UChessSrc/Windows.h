
struct NewScreen NewScreenStructure = {
	0,0,	/* screen XY origin relative to View */
	640,400,	/* screen width and height */
	4,	/* screen depth (number of bitplanes) */
	0,1,	/* detail and block pens */
	LACE+HIRES,	/* display modes for this screen */
	CUSTOMSCREEN,	/* screen type */
	&NULL,	/* pointer to default screen font */
	"UChess v1.0",	/* screen title */
	NULL,	/* first in list of custom screen gadgets */
	NULL	/* pointer to custom BitMap structure */
};

#define NEWSCREENSTRUCTURE NewScreenStructure

USHORT Palette[] = {
	0x0455,	/* color #0 */
	0x0CCE,	/* color #1 */
	0x0FFF,	/* color #2 */
	0x068B,	/* color #3 */
	0x000F,	/* color #4 */
	0x0F0F,	/* color #5 */
	0x00FF,	/* color #6 */
	0x0FFF,	/* color #7 */
	0x0620,	/* color #8 */
	0x0E50,	/* color #9 */
	0x09F1,	/* color #10 */
	0x0EB0,	/* color #11 */
	0x055F,	/* color #12 */
	0x092F,	/* color #13 */
	0x00F8,	/* color #14 */
	0x0CCC	/* color #15 */
#define PaletteColorCount 16
};

#define PALETTE Palette

struct TextAttr TOPAZ80 = {
	(STRPTR)"topaz.font",
	TOPAZ_EIGHTY,0,0
};
struct IntuiText IText1 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Set Time",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem3 = {
	NULL,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText1,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText2 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Test",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem2 = {
	&MenuItem3,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText2,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText3 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Hint",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem1 = {
	&MenuItem2,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText3,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'H',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu Menu4 = {
	NULL,	/* next Menu structure */
	162,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	63,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"Special",	/* text of Menu name */
	&MenuItem1	/* MenuItem linked list pointer */
};

struct IntuiText IText4 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Thinking",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem8 = {
	NULL,	/* next MenuItem structure */
	0,32,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'T',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText5 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Undo",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem7 = {
	&MenuItem8,	/* next MenuItem structure */
	0,24,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText5,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'U',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText6 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Move Now",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem6 = {
	&MenuItem7,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText6,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'M',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText7 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"AutoPlay",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem5 = {
	&MenuItem6,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText7,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText8 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Swap Sides",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem4 = {
	&MenuItem5,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText8,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'S',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu Menu3 = {
	&Menu4,	/* next Menu structure */
	92,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	63,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"Control",	/* text of Menu name */
	&MenuItem4	/* MenuItem linked list pointer */
};

struct IntuiText IText9 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"ReverseBoard",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem11 = {
	NULL,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText9,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText10 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"3D",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem10 = {
	&MenuItem11,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText10,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText11 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"2-D",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem9 = {
	&MenuItem10,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText11,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu Menu2 = {
	&Menu3,	/* next Menu structure */
	46,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	39,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"View",	/* text of Menu name */
	&MenuItem9	/* MenuItem linked list pointer */
};

struct IntuiText IText12 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Quit",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem15 = {
	NULL,	/* next MenuItem structure */
	0,24,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText12,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'Q',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText13 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Save Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem14 = {
	&MenuItem15,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText13,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText14 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Load Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem13 = {
	&MenuItem14,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText14,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText IText15 = {
	3,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"About..",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem MenuItem12 = {
	&MenuItem13,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText15,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu Menu1 = {
	&Menu2,	/* next Menu structure */
	0,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	39,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"File",	/* text of Menu name */
	&MenuItem12	/* MenuItem linked list pointer */
};

#define MenuList1 Menu1

struct NewWindow NewWindowStructure1 = {
	0,0,	/* window XY origin relative to TopLeft of screen */
	640,400,	/* window width and height */
	0,1,	/* detail and block pens */
	MOUSEBUTTONS+MENUPICK+VANILLAKEY,	/* IDCMP flags */
	BACKDROP+BORDERLESS+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	NULL,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	" ",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	640,400,	/* minimum width and height */
	-1,-1,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};


void HandleEvent(object)
APTR object;
{
  if (object == (APTR)&MenuItem12) { DoAbout(object); return; }
  if (object == (APTR)&MenuItem13) { LoadAGame(object); return; }
  if (object == (APTR)&MenuItem14) { SaveAGame(object); return; }
  if (object == (APTR)&MenuItem15) { DoQuit(object); return; }
  if (object == (APTR)&MenuItem9) { Go2D(object); return; }
  if (object == (APTR)&MenuItem10) { Go3D(object); return; }
  if (object == (APTR)&MenuItem11) { DoReverse(object); return; }
  if (object == (APTR)&MenuItem4) { DoSwap(object); return; }
  if (object == (APTR)&MenuItem5) { DoAutoPlay(object); return; }
  if (object == (APTR)&MenuItem6) { MoveNow(object); return; }
  if (object == (APTR)&MenuItem7) { TakeBack(object); return; }
  if (object == (APTR)&MenuItem8) { DoThinking(object); return; }
  if (object == (APTR)&MenuItem1) { DoHint(object); return; }
  if (object == (APTR)&MenuItem2) { DoTest(object); return; }
  if (object == (APTR)&MenuItem3) { SetTime(object); return; }
}

/* end of PowerWindows source generation */
