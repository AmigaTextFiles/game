#include <exec/types.h>

#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>

#include <libraries/gadtools.h>

#include <stdlib.h>
#include <string.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>

#include "Global.h"

static struct EasyStruct AboutES = {
	sizeof(struct EasyStruct),
	0,
	"About",
	"GNUChess Intuition Interface by\n"
	"  Michael Böhnisch,\n"
	"  Löher Str. 2,\n"
	"  33102 Paderborn,\n"
	"  Federal Republic of Germany\n"
	"GNUChess (c) 1986,1987 Free Software Foundation, Inc.",
	"Yup."
};

void About(void)
{
	EasyRequestArgs(w, &AboutES, NULL, NULL);
}

static struct IntuiText PartieDataITx = {
	COLOR_RAHMEN, COLOR_BCK, JAM1, 155, 8, &TA_Times18, " Game Data ", NULL
};

static WORD PDBCord1[] = { 0, 252,    0,   0,  399, 0,  398, 1,    1,   1,  1, 251 };
static WORD PDBCord2[] = { 0, 253,  399, 253,  399, 1,  398, 2,  398, 252,  1, 252 };

static struct Border PartieDataBordr2 = {
	0, 0, COLOR_WFIG  , COLOR_BCK, JAM1, 6, PDBCord1, NULL
};

static struct Border PartieDataBordr1 = {
	0, 0, COLOR_RAHMEN, COLOR_BCK, JAM1, 6, PDBCord2, &PartieDataBordr2
};

static struct Requester PartieDataReq = {
	NULL,
	0, 0, 400, 254, 0, 0,
	NULL,
	&PartieDataBordr1,
	&PartieDataITx,
	POINTREL | SIMPLEREQ | USEREQIMAGE,
	COLOR_REQBCK,
	NULL,
	{ 0 },
	NULL,
	NULL,
	&Req1Image,
	{ 0 }
};

char	Player1[STRSIZE],
		Player2[STRSIZE],
		Turnier[STRSIZE],
		Opening[STRSIZE],
		Notiz[STRSIZE];
int		StartZugNr	= 1,
		WhoBegins	= WHITE;

void PartieData(void)
{
	struct IntuiMessage	*msg;
	int					quit = FALSE;

	PartieDataReq.RWindow	= w;
	PartieDataReq.ReqGadget = Req_GL;

	strcpy(GADGETSTR(Gad[GAD_WHITE     ]), Player1);
	strcpy(GADGETSTR(Gad[GAD_BLACK     ]), Player2);
	strcpy(GADGETSTR(Gad[GAD_TOURNAMENT]), Turnier);
	strcpy(GADGETSTR(Gad[GAD_OPENING   ]), Opening);
	strcpy(GADGETSTR(Gad[GAD_NOTE      ]), Notiz  );

	Request(&PartieDataReq, w);

	while ( ! quit ) {
		WaitPort(IDCMPORT);
		msg = GT_GetIMsg(IDCMPORT);
		switch ( CLASS(msg) ) {
			case IDCMP_REFRESHWINDOW:
				GT_BeginRefresh(w);
				GT_EndRefresh(w, TRUE);
				break;
			case IDCMP_GADGETUP:
				switch ( GADGETID(msg) ) {
					case GAD_WHITE:
						ActivateGadget(Gad[GAD_BLACK], w, &PartieDataReq);
						break;
					case GAD_BLACK:
						ActivateGadget(Gad[GAD_TOURNAMENT], w, &PartieDataReq);
						break;
					case GAD_TOURNAMENT:
						ActivateGadget(Gad[GAD_OPENING], w, &PartieDataReq);
						break;
					case GAD_OPENING:
						ActivateGadget(Gad[GAD_NOTE], w, &PartieDataReq);
						break;
					case GAD_NOTE:
						ActivateGadget(Gad[GAD_WHITE], w, &PartieDataReq);
						break;
					case GAD_OK:
						strcpy(Player1, GADGETSTR(Gad[GAD_WHITE     ]));
						strcpy(Player2, GADGETSTR(Gad[GAD_BLACK     ]));
						strcpy(Turnier, GADGETSTR(Gad[GAD_TOURNAMENT]));
						strcpy(Opening, GADGETSTR(Gad[GAD_OPENING   ]));
						strcpy(Notiz,   GADGETSTR(Gad[GAD_NOTE      ]));
						quit = TRUE;
						break;
					case GAD_CANCEL:
						quit = TRUE;
						break;
					case GAD_CLEAR:
						strcpy(GADGETSTR(Gad[GAD_WHITE     ]), "");
						strcpy(GADGETSTR(Gad[GAD_BLACK     ]), "");
						strcpy(GADGETSTR(Gad[GAD_TOURNAMENT]), "");
						strcpy(GADGETSTR(Gad[GAD_OPENING   ]), "");
						strcpy(GADGETSTR(Gad[GAD_NOTE      ]), "");
						GT_BeginRefresh(w);
						RefreshGadgets(Req_GL, w, &PartieDataReq);
						GT_EndRefresh(w, TRUE);
						break;
					default:
						break;
				}
				break;
			default:
				break;
		}
		GT_ReplyIMsg(msg);
	}
	EndRequest(&PartieDataReq, w);
}

int NumberRequest(char *text, int def)
{
	static struct Requester NumberRequester = {
		NULL,
		0, 0, 200, 60, 0, 0,
		NULL,
		NULL,
		NULL,
		POINTREL | SIMPLEREQ,
		COLOR_REQBCK,
		NULL,
		{ 0 },
		NULL,
		NULL,
		NULL,
		{ 0 }
	};
	struct Gadget			*gad, *glist = NULL;
	static struct NewGadget	ng = { 50, 30, 100, 19, NULL, &TA_Courier15, 0, PLACETEXT_ABOVE, NULL, NULL };
	int						quit = FALSE, result;
	struct IntuiMessage		*msg;

	ng.ng_VisualInfo = vi;
	ng.ng_GadgetText = text;

	gad = CreateContext(&glist);
	gad = CreateGadget(
		INTEGER_KIND,
		gad,
		&ng,
		GTIN_Number,			def,
		GTIN_MaxChars,			10,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);

	result = def;

	if ( gad ) {
		gad->GadgetType |= GTYP_REQGADGET;
		NumberRequester.ReqGadget = gad;
		if ( Request(&NumberRequester, w) ) {
			DrawBevelBox(
				NumberRequester.ReqLayer->rp,
				0, 0, 200, 60,
				GT_VisualInfo,	vi,
				TAG_DONE
			);
			ActivateGadget(gad, w, &NumberRequester);
			while ( ! quit ) {
				WaitPort(IDCMPORT);
				msg = GT_GetIMsg(IDCMPORT);
				switch ( CLASS(msg) ) {
					case IDCMP_REFRESHWINDOW:
						GT_BeginRefresh(w);
						GT_EndRefresh(w, TRUE);
						break;
					case IDCMP_GADGETUP:
						result	= GADGETINT(GADGET(msg));
						quit	= TRUE;
						break;
				}
				GT_ReplyIMsg(msg);
			}
			EndRequest(&NumberRequester, w);
		}
	}
	FreeGadgets(glist);
	return result;			
}

char *StringRequest(char *text, char *def)
{
	static struct Requester StringRequester = {
		NULL,
		0, 0, 200, 60, 0, 0,
		NULL,
		NULL,
		NULL,
		POINTREL | SIMPLEREQ,
		COLOR_REQBCK,
		NULL,
		{ 0 },
		NULL,
		NULL,
		NULL,
		{ 0 }
	};
	struct Gadget			*gad, *glist = NULL;
	static struct NewGadget	ng = { 50, 30, 100, 19, NULL, &TA_Courier15, 0, PLACETEXT_ABOVE, NULL, NULL };
	int						quit = FALSE;
	static char				result[20];
	struct IntuiMessage		*msg;

	ng.ng_VisualInfo = vi;
	ng.ng_GadgetText = text;

	gad = CreateContext(&glist);
	gad = CreateGadget(
		STRING_KIND,
		gad,
		&ng,
		GTST_String,			def,
		GTST_MaxChars,			10,
		STRINGA_Justification,	GACT_STRINGCENTER,
		TAG_DONE
	);

	strcpy(result, def);

	if ( gad ) {
		gad->GadgetType |= GTYP_REQGADGET;
		StringRequester.ReqGadget = gad;
		if ( Request(&StringRequester, w) ) {
			ActivateGadget(gad, w, &StringRequester);
			DrawBevelBox(
				StringRequester.ReqLayer->rp,
				0, 0, 200, 60,
				GT_VisualInfo,	vi,
				TAG_DONE
			);
			while ( ! quit ) {
				WaitPort(IDCMPORT);
				msg = GT_GetIMsg(IDCMPORT);
				switch ( CLASS(msg) ) {
					case IDCMP_REFRESHWINDOW:
						GT_BeginRefresh(w);
						GT_EndRefresh(w, TRUE);
						break;
					case IDCMP_GADGETUP:
						strcpy(result, GADGETSTR(GADGET(msg)));
						quit	= TRUE;
						break;
				}
				GT_ReplyIMsg(msg);
			}
			EndRequest(&StringRequester, w);
		}
	}
	FreeGadgets(glist);
	return result;			
}
