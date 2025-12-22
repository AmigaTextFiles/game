
SHORT BorderVectors1[] = {
	0,0,
	143,0,
	143,1,
	0,1,
	0,1
};
struct Border Border1 = {
	0,1,	/* XY origin relative to container TopLeft */
	2,0,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors1,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget22 = {
	NULL,	/* next gadget */
	238,122,	/* origin XY of hit box relative to window TopLeft */
	145,4,	/* hit box width and height */
	GADGHBOX+GADGHIMAGE,	/* gadget flags */
	NULL,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border1,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

struct TextAttr TOPAZ80 = {
	(STRPTR)"topaz.font",
	TOPAZ_EIGHTY,0,0
};
struct IntuiText IText2 = {
	3,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	6,15,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"High Score",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText IText1 = {
	3,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"GRAND TOTAL",	/* pointer to text */
	&IText2	/* next IntuiText structure */
};

struct Gadget Gadget21 = {
	&Gadget22,	/* next gadget */
	236,130,	/* origin XY of hit box relative to window TopLeft */
	148,27,	/* hit box width and height */
	GADGHBOX+GADGHIMAGE,	/* gadget flags */
	NULL,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	NULL,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText1,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors2[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border2 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors2,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText3 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Chance",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget20 = {
	&Gadget21,	/* next gadget */
	236,107,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border2,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText3,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	CHANCE,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors3[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border3 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors3,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText4 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Yat-Z",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget19 = {
	&Gadget20,	/* next gadget */
	236,93,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border3,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText4,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	YATZ,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors4[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border4 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors4,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText5 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Large Straight",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget18 = {
	&Gadget19,	/* next gadget */
	236,79,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border4,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText5,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	LGSTRAIGHT,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors5[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border5 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors5,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText6 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Small Straight",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget17 = {
	&Gadget18,	/* next gadget */
	236,65,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border5,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText6,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SMSTRAIGHT,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors6[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border6 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors6,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText7 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Full House",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget16 = {
	&Gadget17,	/* next gadget */
	236,51,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border6,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText7,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	FULLHOUSE,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors7[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border7 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors7,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText8 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"4 Of a Kind",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget15 = {
	&Gadget16,	/* next gadget */
	236,37,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border7,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText8,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	FOUROFAKIND,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors8[] = {
	0,0,
	148,0,
	148,12,
	0,12,
	0,0
};
struct Border Border8 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors8,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText9 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"3 Of a Kind",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget14 = {
	&Gadget15,	/* next gadget */
	236,23,	/* origin XY of hit box relative to window TopLeft */
	147,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border8,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText9,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	THREEOFAKIND,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

struct IntuiText IText11 = {
	3,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,11,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"> 62 Bonus",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText IText10 = {
	3,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Left Total",	/* pointer to text */
	&IText11	/* next IntuiText structure */
};

struct Gadget Gadget13 = {
	&Gadget14,	/* next gadget */
	87,107,	/* origin XY of hit box relative to window TopLeft */
	133,20,	/* hit box width and height */
	GADGHBOX+GADGHIMAGE,	/* gadget flags */
	NULL,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	NULL,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText10,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors9[] = {
	0,0,
	41,0,
	41,25,
	0,25,
	0,0
};
struct Border Border9 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	2,3,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors9,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget12 = {
	&Gadget13,	/* next gadget */
	15,132,	/* origin XY of hit box relative to window TopLeft */
	40,24,	/* hit box width and height */
	GADGDISABLED,	/* gadget flags */
	GADGIMMEDIATE+TOGGLESELECT,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border9,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	DICE+4,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors10[] = {
	0,0,
	41,0,
	41,25,
	0,25,
	0,0
};
struct Border Border10 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	2,3,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors10,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget11 = {
	&Gadget12,	/* next gadget */
	15,105,	/* origin XY of hit box relative to window TopLeft */
	40,24,	/* hit box width and height */
	GADGDISABLED,	/* gadget flags */
	GADGIMMEDIATE+TOGGLESELECT,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border10,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	DICE+3,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors11[] = {
	0,0,
	41,0,
	41,25,
	0,25,
	0,0
};
struct Border Border11 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	2,3,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors11,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget10 = {
	&Gadget11,	/* next gadget */
	15,78,	/* origin XY of hit box relative to window TopLeft */
	40,24,	/* hit box width and height */
	GADGDISABLED,	/* gadget flags */
	GADGIMMEDIATE+TOGGLESELECT,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border11,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	DICE+2,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors12[] = {
	0,0,
	41,0,
	41,25,
	0,25,
	0,0
};
struct Border Border12 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	2,3,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors12,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget9 = {
	&Gadget10,	/* next gadget */
	15,51,	/* origin XY of hit box relative to window TopLeft */
	40,24,	/* hit box width and height */
	GADGDISABLED,	/* gadget flags */
	GADGIMMEDIATE+TOGGLESELECT,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border12,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	DICE+1,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors13[] = {
	0,0,
	41,0,
	41,25,
	0,25,
	0,0
};
struct Border Border13 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	2,3,JAM2,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors13,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget Gadget8 = {
	&Gadget9,	/* next gadget */
	15,24,	/* origin XY of hit box relative to window TopLeft */
	40,24,	/* hit box width and height */
	GADGDISABLED,	/* gadget flags */
	GADGIMMEDIATE+TOGGLESELECT,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border13,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	DICE,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors14[] = {
	0,0,
	134,0,
	134,28,
	0,28,
	0,0
};
struct Border Border14 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors14,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct TextAttr TOPAZ60 = {
	(STRPTR)"topaz.font",
	TOPAZ_SIXTY,0,0
};
struct IntuiText IText12 = {
	3,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	45,10,	/* XY origin relative to container TopLeft */
	&TOPAZ60,	/* font pointer or NULL for default */
	(UBYTE *)"ROLL",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget7 = {
	&Gadget8,	/* next gadget */
	87,130,	/* origin XY of hit box relative to window TopLeft */
	133,27,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border14,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText12,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	ROLL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors15[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border15 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors15,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText13 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Six",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget6 = {
	&Gadget7,	/* next gadget */
	87,93,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border15,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText13,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE+5,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors16[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border16 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors16,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText14 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Five",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget5 = {
	&Gadget6,	/* next gadget */
	87,79,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border16,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText14,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE+4,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors17[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border17 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors17,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText15 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Four",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget4 = {
	&Gadget5,	/* next gadget */
	87,65,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border17,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText15,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE+3,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors18[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border18 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors18,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText16 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Three",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget3 = {
	&Gadget4,	/* next gadget */
	87,51,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border18,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText16,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE+2,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors19[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border19 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors19,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText17 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"Two",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget2 = {
	&Gadget3,	/* next gadget */
	87,37,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border19,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText17,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE+1,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT BorderVectors20[] = {
	0,0,
	134,0,
	134,12,
	0,12,
	0,0
};
struct Border Border20 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	3,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors20,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText IText18 = {
	1,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	5,2,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	(UBYTE *)"One",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget Gadget1 = {
	&Gadget2,	/* next gadget */
	87,23,	/* origin XY of hit box relative to window TopLeft */
	133,11,	/* hit box width and height */
	GADGHBOX,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border20,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText18,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	SCORE,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

#define GadgetList1 Gadget1

struct NewWindow NewWindowStructure1 = {
	239,34,	/* window XY origin relative to TopLeft of screen */
	401,166,	/* window width and height */
	0,1,	/* detail and block pens */
	GADGETDOWN+GADGETUP+CLOSEWINDOW,	/* IDCMP flags */
	WINDOWDRAG+WINDOWDEPTH+WINDOWCLOSE+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	&Gadget1,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	(UBYTE *)"Yat-Z V1.1 by Greg Pringle",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	5,5,	/* minimum width and height */
	-1,-1,	/* maximum width and height */
	WBENCHSCREEN	/* destination screen type */
};


/* end of PowerWindows source generation */
