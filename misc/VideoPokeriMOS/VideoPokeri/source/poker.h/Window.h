
/***********************************************************************
 *                                                                     *
 *  Headerfile   : graniteWindow.h                                     *
 *                                                                     *
 *  Program      : VIDEO-POKERI                                        *
 *                                                                     *
 *  Version      : 0.98       (06.11.1991)   (28.04.1992)              *
 *                                                                     *
 *  Author       : JanTAki                                             *
 *                 92100  RAAHE ,  FINLAND                             *
 *                                                                     *
 *  E-mail       : janta@ratol.fi                                      *  
 *                                                                     *
 ***********************************************************************/


/* graniteWindow.h */

#define GRAN_LEFTEDGE  0
#define GRAN_TOPEDGE  10
#define GRAN_WIDTH   320
#define GRAN_HEIGHT  245
#define SYSGADSWIDTH  80
#define SYSGADSHEIGHT 19

struct NewWindow graniteWindow =
	{
	GRAN_LEFTEDGE,
	GRAN_TOPEDGE,
	GRAN_WIDTH,
	GRAN_HEIGHT,
	0,0,
	GADGETDOWN | GADGETUP | MOUSEBUTTONS | RAWKEY,
	SMART_REFRESH | ACTIVATE | NOCAREREFRESH | 
	BORDERLESS | BACKDROP | RMBTRAP,
	NULL, NULL, NULL, NULL, NULL,
	SYSGADSWIDTH,
	SYSGADSHEIGHT,
	0xFFFF,
	0xFFFF,
	CUSTOMSCREEN,
	};

struct NewWindow aboutWindow =
	{
	30,
	20,
	260,
	214,
	4,5,
	GADGETUP | RAWKEY,
	SMART_REFRESH | ACTIVATE | NOCAREREFRESH | BORDERLESS | RMBTRAP,
	NULL, NULL, NULL, NULL, NULL,
	SYSGADSWIDTH,
	SYSGADSHEIGHT,
	0xFFFF,
	0xFFFF,
	CUSTOMSCREEN,
	};

/* end of graniteWindow.h */

