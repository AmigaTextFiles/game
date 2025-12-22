
/***********************************************************************
 *                                                                     *
 *  Headerfile   : gadgets.h                                           *
 *                                                                     *
 *  Program      : VIDEO-POKERI                                        *
 *                                                                     *
 *  Version      : 0.99e      (05.11.1991)   (14.05.1992)              *
 *                                                                     *
 *  Author       : JanTAki                                             *
 *                 92100  RAAHE ,  FINLAND                             *
 *                                                                     *
 *  E-mail       : janta@ratol.fi                                      *  
 *                                                                     *
 ***********************************************************************/


/* gadgets.h */

/* Gadget-structure-definitions */

struct Gadget KorttiPohja[] =
	{
		{
		NULL,                   /* next */
		KORTTIX, KORTTIY, 		/* x- & y-coord. */
		KORTTIL, KORTTIK, GADGHNONE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		NULL, NULL, NULL, NULL, NULL, 0, NULL	/* id-number */
		},
		{
		&KorttiPohja[0],					/* next */
		KORTTIX+KORTTIL+KORTTIVALI, KORTTIY,		/* x- & y-coord. */
		KORTTIL, KORTTIK, GADGHNONE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		NULL, NULL, NULL, NULL, NULL, 1, NULL	/* id-number */
		},
		{
		&KorttiPohja[1],		/* next */
		KORTTIX+2*KORTTIL+2*KORTTIVALI, KORTTIY, 		/* x- & y-coord. */
		KORTTIL, KORTTIK, GADGHNONE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		NULL, NULL, NULL, NULL, NULL, 2, NULL	/* id-number */
		},
		{
		&KorttiPohja[2],		/* next */
		KORTTIX+3*KORTTIL+3*KORTTIVALI, KORTTIY,		/* x- & y-coord. */
		KORTTIL, KORTTIK, GADGHNONE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		NULL, NULL, NULL, NULL, NULL, 3, NULL	/* id-number */
		},
		{
		&KorttiPohja[3],		/* next */
		KORTTIX+4*KORTTIL+4*KORTTIVALI, KORTTIY, 		/* x- & y-coord. */
		KORTTIL, KORTTIK, GADGHNONE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		NULL, NULL, NULL, NULL, NULL, 4, NULL	/* id-number */
		}
	};	

struct Gadget Eexit =
	{
	&KorttiPohja[4],	/* next */
	0, 2,			/* x- & y-coord. */
	8, 8, GADGHNONE,
	RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
	NULL, NULL, NULL, NULL, NULL, 99, NULL	/* id-number */
	};

struct Gadget Pelit =
	{
	&Eexit,					/* next */
	18, 8,					/* x- & y-coord. */
	72, 15, GADGHNONE,
	RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
	NULL, NULL, NULL, NULL, NULL, 49, NULL	/* id-number */
	};

struct Gadget Panos =
	{
	&Pelit,					/* next */
	138, 6,					/* x- & y-coord. */
	24, 23, GADGHNONE | GADGIMAGE,
	RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
	(APTR)&PanosImage, NULL, NULL, NULL, NULL, 50, NULL	/* id-number */
	};

struct Gadget Voitot =
	{
	&Panos,					/* next */
	205, 8,					/* x- & y-coord. */
	98, 15, GADGHNONE,
	RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
	NULL, NULL, NULL, NULL, NULL, 51, NULL	/* id-number */
	};

UBYTE UNDOBUFFER[20];
UBYTE JonoPuskuri[20];

struct StringInfo JonoInfo =
	{
	JonoPuskuri,
	UNDOBUFFER,
	0,
	20,
	0,
	0,0,0,0,0,
	0,
	0,
	NULL
	};

struct Gadget Jono =
	{
	&Voitot,					/* next */
	149, 208,
	162, 12,
	NULL,
	RELVERIFY | GADGIMMEDIATE,
	STRGADGET,
	NULL,
	NULL,
	NULL,
	NULL,
	(APTR)&JonoInfo,
	20,
	NULL
	};

struct Gadget Painike[] =
	{
		{
		&Jono,					/* next TUPLAUS */
		PAINIKEX, PAINIKEY,		/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[10], (APTR)&PainikeImage[11],
		NULL, NULL, NULL, 16, NULL	/* id-number */
		},
		{
		&Painike[0],			/* next PIENI */
		PAINIKEX+PAINIKEL+PAINIKEVALI, PAINIKEY,	/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[8], (APTR)&PainikeImage[9],
		NULL, NULL, NULL, 15, NULL	/* id-number */
		},
		{
		&Painike[1],			/* next SUURI */
		PAINIKEX+2*PAINIKEL+2*PAINIKEVALI, PAINIKEY,	/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[6], (APTR)&PainikeImage[7],
		NULL, NULL, NULL, 14, NULL	/* id-number */
		},
		{
		&Painike[2],			/* next PANOS */
		PAINIKEX+3*PAINIKEL+3*PAINIKEVALI, PAINIKEY,	/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[4], (APTR)&PainikeImage[5],
		NULL, NULL, NULL, 13, NULL	/* id-number */
		},
		{
		&Painike[3],		/* next VOITONMAKSU */
		PAINIKEX+4*PAINIKEL+4*PAINIKEVALI, PAINIKEY,	/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[2], (APTR)&PainikeImage[3],
		NULL, NULL, NULL, 12, NULL	/* id-number */
		},
		{
		&Painike[4],		/* next JAKO */
		PAINIKEX+5*PAINIKEL+5*PAINIKEVALI, PAINIKEY,	/* x- & y-coord. */
		PAINIKEL, PAINIKEK, GADGHIMAGE | GADGIMAGE,
		RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
		(APTR)&PainikeImage[0], (APTR)&PainikeImage[1],
		NULL, NULL, NULL, 11, NULL	/* id-number */
		},
	};

struct Gadget About =
	{
	NULL,			/* next */
	201, 184,		/* x- & y-coord. */
	49, 19,
	GADGHCOMP,
	RELVERIFY | GADGIMMEDIATE, BOOLGADGET,
	NULL, NULL, NULL, NULL, NULL, 111, NULL	/* id-number */
	};


/* end of gadgets.h */



