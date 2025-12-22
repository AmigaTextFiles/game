
/***********************************************************************
 *                                                                     *
 *  Headerfile   : graphics.h                                          *
 *                                                                     *
 *  Program      : VIDEO-POKERI                                        *
 *                                                                     *
 *  Version      : 0.99e      (05.11.1991)   (15.05.1992)              *
 *                                                                     *
 *  Author       : JanTAki                                             *
 *                 92100  RAAHE ,  FINLAND                             *
 *                                                                     *
 *  E-mail       : janta@ratol.fi                                      *  
 *                                                                     *
 ***********************************************************************/

/* graphics.h */


#define KORTTIX     16
#define KORTTIY    118
#define KORTTIL     50
#define KORTTIK     78
#define KORTTIVALI  10
#define PAINIKEX    16
#define PAINIKEY   227
#define PAINIKEL    40
#define PAINIKEK    18
#define PAINIKEVALI 10

extern USHORT JakoUpData[];
extern USHORT JakoDownData[];
extern USHORT VoittoUpData[];
extern USHORT VoittoDownData[];
extern USHORT PanosData[];
extern USHORT PanosUpData[];
extern USHORT PanosDownData[];
extern USHORT SuuriUpData[];
extern USHORT SuuriDownData[];
extern USHORT PieniUpData[];
extern USHORT PieniDownData[];
extern USHORT TuplausUpData[];
extern USHORT TuplausDownData[];
extern USHORT JakoUpEng[];
extern USHORT JakoDownEng[];
extern USHORT VoittoUpEng[];
extern USHORT VoittoDownEng[];
extern USHORT PanosEng[];
extern USHORT PanosUpEng[];
extern USHORT PanosDownEng[];
extern USHORT SuuriUpEng[];
extern USHORT SuuriDownEng[];
extern USHORT PieniUpEng[];
extern USHORT PieniDownEng[];
extern USHORT TuplausUpEng[];
extern USHORT TuplausDownEng[];

struct Image PanosImage =
    {            
    -1,-1,         
    24,23,       
    5,           
    PanosData,    
    0xff,0x0,    
    NULL         
    };

struct Image PainikeImage[] =
	{
		{
		-1,-1,				/* JAKO-painike ylh‰‰ll‰ */
		41,19,
		5,
		JakoUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* JAKO-painike alhaalla */
		41,19,
		5,
		JakoDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* VOITTO-painike ylh‰‰ll‰ */
		41,19,
		5,
		VoittoUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* VOITTO-painike alhaalla */
		41,19,
		5,
		VoittoDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PANOS-painike ylh‰‰ll‰ */
		41,19,
		5,
		PanosUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PANOS-painike alhaalla */
		41,19,
		5,
		PanosDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* SUURI-painike ylh‰‰ll‰ */
		41,19,
		5,
		SuuriUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* SUURI-painike alhaalla */
		41,19,
		5,
		SuuriDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PIENI-painike ylh‰‰ll‰ */
		41,19,
		5,
		PieniUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PIENI-painike alhaalla */
		41,19,
		5,
		PieniDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* TUPLAUS-painike ylh‰‰ll‰ */
		41,19,
		5,
		TuplausUpData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* TUPLAUS-painike alhaalla */
		41,19,
		5,
		TuplausDownData,
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* JAKO-painike ylh‰‰ll‰ */
		41,19,
		5,
		JakoUpEng,			/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* JAKO-painike alhaalla */
		41,19,
		5,
		JakoDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* VOITTO-painike ylh‰‰ll‰ */
		41,19,
		5,
		VoittoUpEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* VOITTO-painike alhaalla */
		41,19,
		5,
		VoittoDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PANOS-painike ylh‰‰ll‰ */
		41,19,
		5,
		PanosUpEng,			/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PANOS-painike alhaalla */
		41,19,
		5,
		PanosDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* SUURI-painike ylh‰‰ll‰ */
		41,19,
		5,
		SuuriUpEng,			/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* SUURI-painike alhaalla */
		41,19,
		5,
		SuuriDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PIENI-painike ylh‰‰ll‰ */
		41,19,
		5,
		PieniUpEng,			/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* PIENI-painike alhaalla */
		41,19,
		5,
		PieniDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* TUPLAUS-painike ylh‰‰ll‰ */
		41,19,
		5,
		TuplausUpEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		},
		{
		-1,-1,				/* TUPLAUS-painike alhaalla */
		41,19,
		5,
		TuplausDownEng,		/* ENGLANTI */
		0xff,0x0,
		NULL
		}
	};


SHORT datapakkakehys[] =
	{
	0,0,
	KORTTIL,0,
	KORTTIL,KORTTIK,
	0,KORTTIK,
	0,0
	};

struct Border pakkakehys =
	{
	-1, -1,
	1,0,JAM1,
	5,
	datapakkakehys,
	NULL
	};

/* end of graphics.h */

