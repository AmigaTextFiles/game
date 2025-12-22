/************************************************************************/
/* Gadget definitions													*/
/************************************************************************/

#include <intuition/gadgetclass.h>

#include <libraries/gadtools.h>

#include <proto/gadtools.h>

#include "global.h"
#include "gfx.h"
#include "gnuchess.h"
#include "Interface.h"

static struct NewGadget NGArray[GADGETS] = {
	{   6,  31, 185,  24, "White"     , &TA_Courier15, GAD_WHITE     , PLACETEXT_BELOW, NULL, NULL },
	{ 209,  31, 185,  24, "Black"     , &TA_Courier15, GAD_BLACK     , PLACETEXT_BELOW, NULL, NULL },
	{   6,  76, 388,  24, "Tournament", &TA_Courier15, GAD_TOURNAMENT, PLACETEXT_BELOW, NULL, NULL },
	{   6, 121, 388,  24, "Opening"   , &TA_Courier15, GAD_OPENING   , PLACETEXT_BELOW, NULL, NULL },
	{   6, 166, 388,  24, "Note"      , &TA_Courier15, GAD_NOTE      , PLACETEXT_BELOW, NULL, NULL },
	{   6, 219,  80,  24, "OK"        , &TA_Courier15, GAD_OK        , PLACETEXT_IN   , NULL, NULL },
	{  96, 219,  80,  24, "CANCEL"    , &TA_Courier15, GAD_CANCEL	 , PLACETEXT_IN   , NULL, NULL },
	{ 186, 219,  80,  24, "CLEAR"     , &TA_Courier15, GAD_CLEAR     , PLACETEXT_IN   , NULL, NULL },

	{ 112, 371, 102,  24, "OK"       , &TA_Courier15, GAD_OK		, PLACETEXT_IN   , NULL, NULL },
	{ 112, 342, 102,  24, "DEFAULT"  , &TA_Courier15, GAD_DEFAULT	, PLACETEXT_IN   , NULL, NULL },
	{   6, 371, 102,  24, "CLEAR"    , &TA_Courier15, GAD_CLEAR		, PLACETEXT_IN   , NULL, NULL },
	{   6, 313, 208,  24, NULL       , &TA_Courier15, GAD_TOMOVE	, PLACETEXT_IN   , NULL, NULL },
	{  56, 342,  52,  24, "No."      , &TA_Courier15, GAD_MOVENUM	, PLACETEXT_LEFT , NULL, NULL }
};

static char *ToMoveText[] = {
	"WHITE TO MOVE",
	"BLACK TO MOVE",
	NULL
};

static struct Gadget GAD_EdB12 = {
	NULL, 58, 258, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &SKWFImage, (APTR) &SKSFImage,
	NULL, 0, NULL,
	GAD_SK,
	NULL
};

static struct Gadget GAD_EdB11 = {
	&GAD_EdB12, 8, 258, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WKWFImage, (APTR) &WKSFImage,
	NULL, 0, NULL,
	GAD_WK,
	NULL
};

static struct Gadget GAD_EdB10 = {
	&GAD_EdB11, 58, 208, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &SDWFImage, (APTR) &SDSFImage,
	NULL, 0, NULL,
	GAD_SD,
	NULL
};

static struct Gadget GAD_EdB09 = {
	&GAD_EdB10, 8, 208, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WDWFImage, (APTR) &WDSFImage,
	NULL, 0, NULL,
	GAD_WD,
	NULL
};

static struct Gadget GAD_EdB08 = {
	&GAD_EdB09, 58, 158, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &SLWFImage, (APTR) &SLSFImage,
	NULL, 0, NULL,
	GAD_SL,
	NULL
};

static struct Gadget GAD_EdB07 = {
	&GAD_EdB08, 8, 158, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WLWFImage, (APTR) &WLSFImage,
	NULL, 0, NULL,
	GAD_WL,
	NULL
};

static struct Gadget GAD_EdB06 = {
	&GAD_EdB07, 58, 108, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &SSWFImage, (APTR) &SSSFImage,
	NULL, 0, NULL,
	GAD_SS,
	NULL
};

static struct Gadget GAD_EdB05 = {
	&GAD_EdB06, 8, 108, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WSWFImage, (APTR) &WSSFImage,
	NULL, 0, NULL,
	GAD_WS,
	NULL
};

static struct Gadget GAD_EdB04 = {
	&GAD_EdB05, 58, 58, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &STWFImage, (APTR) &STSFImage,
	NULL, 0, NULL,
	GAD_ST,
	NULL
};

static struct Gadget GAD_EdB03 = {
	&GAD_EdB04, 8, 58, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WTWFImage, (APTR) &WTSFImage,
	NULL, 0, NULL,
	GAD_WT,
	NULL
};

static struct Gadget GAD_EdB02 = {
	&GAD_EdB03, 58, 8, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &SBWFImage, (APTR) &SBSFImage,
	NULL, 0, NULL,
	GAD_SB,
	NULL
};

static struct Gadget GAD_EdB01 = {
	&GAD_EdB02, 8, 8, 48, 48,
	GFLG_GADGHIMAGE | GFLG_GADGIMAGE | GFLG_SELECTED,
	GACT_RELVERIFY  | GACT_IMMEDIATE | GACT_TOGGLESELECT,
	GTYP_BOOLGADGET,
	(APTR) &WBWFImage, (APTR) &WBSFImage,
	NULL, 0, NULL,
	GAD_WB,
	NULL
};

struct Gadget *Req_GL;
struct Gadget *EdB_GL = &GAD_EdB01;
struct Gadget *EdB_GL2;
struct Gadget *Gad[STR_GADGETS];
struct Gadget *GAD_MoveNum;
struct Gadget *GAD_ToMove;
struct Gadget *GAD_Ok;

void InitGads(void)
{
	struct Gadget	*gad;
	int		i;

	for ( i = 0; i < GADGETS; i++ ) {
		NGArray[i].ng_VisualInfo = vi;
	}

	gad = CreateContext(&Req_GL);
	Gad[0] = gad = CreateGadget(
		STRING_KIND, gad, &NGArray[0],
		GTST_MaxChars,			80,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);
	Gad[1] = gad = CreateGadget(
		STRING_KIND, gad, &NGArray[1],
		GTST_MaxChars,			80,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);
	Gad[2] = gad = CreateGadget(
		STRING_KIND, gad, &NGArray[2],
		GTST_MaxChars,			80,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);
	Gad[3] = gad = CreateGadget(
		STRING_KIND, gad, &NGArray[3],
		GTST_MaxChars,			80,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);
	Gad[4] = gad = CreateGadget(
		STRING_KIND, gad, &NGArray[4],
		GTST_MaxChars,			80,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);
	gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[5],
		TAG_DONE
	);
	gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[6],
		TAG_DONE
	);
	gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[7],
		TAG_DONE
	);

	if ( ! gad )
		ExitChess(11);

	gad = CreateContext(&EdB_GL2);

	GAD_Ok = gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[8],
		TAG_DONE
	);
	gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[9],
		TAG_DONE
	);
	gad = CreateGadget(
		BUTTON_KIND, gad, &NGArray[10],
		TAG_DONE
	);
	GAD_ToMove  = gad = CreateGadget(
		CYCLE_KIND , gad, &NGArray[11],
		GTCY_Labels,			ToMoveText,
		GTCY_Active,			0,
		TAG_DONE
	);
	GAD_MoveNum = gad = CreateGadget(
		INTEGER_KIND, gad, &NGArray[12],
		GTIN_Number,			1,
		GTIN_MaxChars,			3,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);

	if ( ! gad ) ExitChess(12);
}

void FreeGads(void)
{
	FreeGadgets(Req_GL);
	FreeGadgets(EdB_GL2);
}
