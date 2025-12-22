/*************************************************************************/
/*                                                                       */
/*   Includes                                                            */
/*                                                                       */
/*************************************************************************/
#include "AmberCheatGUI_Includes.h"
#include "AmberCheatGUI.h"

/*************************************************************************/
/*                                                                       */
/*   Variables and Structures                                            */
/*                                                                       */
/*************************************************************************/
extern struct IntuitionBase *IntuitionBase;
extern struct GfxBase       *GfxBase;
extern struct UtilityBase   *UtilityBase;
extern struct Library *GadToolsBase ;
extern struct Library *AslBase      ;

/*************************************************************************/
/*                                                                       */
/*   Defines                                                             */
/*                                                                       */
/*************************************************************************/
#define GADGET_DOWN  0
#define GADGET_UP    1

#define RASTERX (GfxBase->DefaultFont->tf_XSize)
#define RASTERY ((GfxBase->DefaultFont->tf_YSize/2)+4)

#define XSIZE(x)  ((x)*RASTERX)
#define YSIZE(x)  ((x)*RASTERY)

#define XPOS(x)   (XSIZE(x)+customscreen->WBorLeft)
#define YPOS(x)   (YSIZE(x)+customscreen->BarHeight+1)

/*************************************************************************/
/*                                                                       */
/*   ProtoTypes                                                          */
/*                                                                       */
/*************************************************************************/

struct  Menu *BuildMenus( APTR );

/*************************************************************************/
/*                                                                       */
/*   WindowStructures                                                    */
/*                                                                       */
/*************************************************************************/
struct AmberCheatData
	{
	BOOL    gd_Disabled_BTSaveGG;
	BOOL    gd_Disabled_BTAbort;
	BOOL    gd_Disabled_CYActualChar;
	UWORD   gd_Active_CYActualChar;
	char * *gd_Labels_CYActualChar;
	BOOL    gd_Disabled_TXStrength;
	char    gd_Text_TXStrength[256];
	BOOL    gd_Disabled_TXInt;
	char    gd_Text_TXInt[256];
	BOOL    gd_Disabled_TXGes;
	char    gd_Text_TXGes[256];
	BOOL    gd_Disabled_TXSch;
	char    gd_Text_TXSch[256];
	BOOL    gd_Disabled_TXKon;
	char    gd_Text_TXKon[256];
	BOOL    gd_Disabled_TXKar;
	char    gd_Text_TXKar[256];
	BOOL    gd_Disabled_TXGlu;
	char    gd_Text_TXGlu[256];
	BOOL    gd_Disabled_TXAnm;
	char    gd_Text_TXAnm[256];
	BOOL    gd_Disabled_INStr;
	ULONG   gd_Number_INStr;
	BOOL    gd_Disabled_INMStr;
	ULONG   gd_Number_INMStr;
	BOOL    gd_Disabled_INInt;
	ULONG   gd_Number_INInt;
	BOOL    gd_Disabled_INGes;
	ULONG   gd_Number_INGes;
	BOOL    gd_Disabled_INSch;
	ULONG   gd_Number_INSch;
	BOOL    gd_Disabled_INKon;
	ULONG   gd_Number_INKon;
	BOOL    gd_Disabled_INKar;
	ULONG   gd_Number_INKar;
	BOOL    gd_Disabled_INGlu;
	ULONG   gd_Number_INGlu;
	BOOL    gd_Disabled_INAnM;
	ULONG   gd_Number_INAnM;
	BOOL    gd_Disabled_INMInt;
	ULONG   gd_Number_INMInt;
	BOOL    gd_Disabled_INMGes;
	ULONG   gd_Number_INMGes;
	BOOL    gd_Disabled_INMSch;
	ULONG   gd_Number_INMSch;
	BOOL    gd_Disabled_INMKon;
	ULONG   gd_Number_INMKon;
	BOOL    gd_Disabled_INMKar;
	ULONG   gd_Number_INMKar;
	BOOL    gd_Disabled_INMGlu;
	ULONG   gd_Number_INMGlu;
	BOOL    gd_Disabled_INMAnM;
	ULONG   gd_Number_INMAnM;
	BOOL    gd_Disabled_TXAtt;
	char    gd_Text_TXAtt[256];
	BOOL    gd_Disabled_TXPar;
	char    gd_Text_TXPar[256];
	BOOL    gd_Disabled_TXSchw;
	char    gd_Text_TXSchw[256];
	BOOL    gd_Disabled_TXKri;
	char    gd_Text_TXKri[256];
	BOOL    gd_Disabled_TXFaF;
	char    gd_Text_TXFaF[256];
	BOOL    gd_Disabled_TXFaE;
	char    gd_Text_TXFaE[256];
	BOOL    gd_Disabled_TXScO;
	char    gd_Text_TXScO[256];
	BOOL    gd_Disabled_TXSuc;
	char    gd_Text_TXSuc[256];
	BOOL    gd_Disabled_TXSrL;
	char    gd_Text_TXSrL[256];
	BOOL    gd_Disabled_TXMaB;
	char    gd_Text_TXMaB[256];
	BOOL    gd_Disabled_INAtt;
	ULONG   gd_Number_INAtt;
	BOOL    gd_Disabled_INPar;
	ULONG   gd_Number_INPar;
	BOOL    gd_Disabled_INSchw;
	ULONG   gd_Number_INSchw;
	BOOL    gd_Disabled_INKri;
	ULONG   gd_Number_INKri;
	BOOL    gd_Disabled_INFaF;
	ULONG   gd_Number_INFaF;
	BOOL    gd_Disabled_INFaE;
	ULONG   gd_Number_INFaE;
	BOOL    gd_Disabled_INScO;
	ULONG   gd_Number_INScO;
	BOOL    gd_Disabled_INSuc;
	ULONG   gd_Number_INSuc;
	BOOL    gd_Disabled_INSrL;
	ULONG   gd_Number_INSrL;
	BOOL    gd_Disabled_INMaB;
	ULONG   gd_Number_INMaB;
	BOOL    gd_Disabled_INMAtt;
	ULONG   gd_Number_INMAtt;
	BOOL    gd_Disabled_INMPar;
	ULONG   gd_Number_INMPar;
	BOOL    gd_Disabled_INMSchw;
	ULONG   gd_Number_INMSchw;
	BOOL    gd_Disabled_INMKri;
	ULONG   gd_Number_INMKri;
	BOOL    gd_Disabled_INMFaF;
	ULONG   gd_Number_INMFaF;
	BOOL    gd_Disabled_INMFaE;
	ULONG   gd_Number_INMFaE;
	BOOL    gd_Disabled_INMScO;
	ULONG   gd_Number_INMScO;
	BOOL    gd_Disabled_INMSuc;
	ULONG   gd_Number_INMSuc;
	BOOL    gd_Disabled_INMSrL;
	ULONG   gd_Number_INMSrL;
	BOOL    gd_Disabled_INMMaB;
	ULONG   gd_Number_INMMaB;
	BOOL    gd_Disabled_INLP;
	ULONG   gd_Number_INLP;
	BOOL    gd_Disabled_TXLP;
	char    gd_Text_TXLP[256];
	BOOL    gd_Disabled_INMLP;
	ULONG   gd_Number_INMLP;
	BOOL    gd_Disabled_TXSP;
	char    gd_Text_TXSP[256];
	BOOL    gd_Disabled_INSP;
	ULONG   gd_Number_INSP;
	BOOL    gd_Disabled_INMSP;
	ULONG   gd_Number_INMSP;
	BOOL    gd_Disabled_TXTP;
	char    gd_Text_TXTP[256];
	BOOL    gd_Disabled_TXSLP;
	char    gd_Text_TXSLP[256];
	BOOL    gd_Disabled_INTP;
	ULONG   gd_Number_INTP;
	BOOL    gd_Disabled_INSLP;
	ULONG   gd_Number_INSLP;
	BOOL    gd_Disabled_TXEP;
	char    gd_Text_TXEP[256];
	BOOL    gd_Disabled_TXGold;
	char    gd_Text_TXGold[256];
	BOOL    gd_Disabled_INEP;
	ULONG   gd_Number_INEP;
	BOOL    gd_Disabled_INGold;
	ULONG   gd_Number_INGold;
	BOOL    gd_Disabled_BTZufall;
	BOOL    gd_Disabled_BTOriginal;
	};

/* Menu */

struct  NewMenu MyMenu[] =
	{
		{ NM_TITLE, "Projekt",                        0, 0, 0, 0,},
		{  NM_ITEM, "Original laden",              "L", 0, 0, 0,},
		{  NM_ITEM, "Charaktere sichern",             "S", 0, 0, 0,},
		{  NM_ITEM, "Als Voreinstellung sichern...",  "V",0,0,0,},
		{  NM_ITEM, NM_BARLABEL, 0,0,0,0,},
		{  NM_ITEM, "Über...",                        "?",0,0,0,},
		{  NM_ITEM, NM_BARLABEL, 0,0,0,0,},
		{  NM_ITEM, "Hilfe...",                       "H",0,0,0,},
		{  NM_ITEM, NM_BARLABEL, 0,0,0,0,},
		{  NM_ITEM, "Ende",                           "Q",0,0,0,},
		{ NM_END, NULL, 0,0,0,0},
	};

/*************************************************************************/
/*                                                                       */
/*   Routines to handle gadgets                                          */
/*                                                                       */
/*************************************************************************/
void HandleGadgetsAmberCheat(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,struct AmberCheatData *gadgetdata,APTR userdata)
{
	switch(gadgetid)
		{
		case BTID_SAVE:
			BTSave(win,wingads,gadgetid,messagecode,userdata);
			break;
		case BTID_ABBRUCH:
			BTAbbruch(win,wingads,gadgetid,messagecode,userdata);
			break;
		case CYID_ACTCHAR:
			ChangeCharacter(win,wingads,gadgetid,messagecode,userdata);
			break;
		case BTID_ZUFALL:
			BTZufall(win,wingads,gadgetid,messagecode,userdata);
			break;
		case BTID_ORIGINAL:
			BTOriginal(win,wingads,gadgetid,messagecode,userdata);
			break;

		default:
			INClicked(win,wingads,gadgetid,messagecode,userdata);
			break;
		};
}

/*************************************************************************/
/*                                                                       */
/*   Routines to build menus                                             */
/*                                                                       */
/*************************************************************************/

struct Menu *BuildMenus( APTR vi )
{
	struct  Menu *menu=NULL;

	if ( menu = CreateMenus( MyMenu, TAG_END ) )
	{
		if ( LayoutMenus( menu, vi, GTMN_NewLookMenus, TRUE, TAG_END ) )
		{
			return( menu );
		}
		FreeMenus( menu );
	}
	return( NULL );
}
/*************************************************************************/
/*                                                                       */
/*   Routines to create gadgets                                          */
/*                                                                       */
/*************************************************************************/
struct Gadget *CreateGadgetsAmberCheat(struct Gadget **gadgetlist,struct NewGadget newgad[],struct Gadget *wingads[],struct AmberCheatData *gadgetdata)
{
	struct Gadget *gadget=CreateContext(gadgetlist);
	if (gadget)
		{
		wingads[BTID_SAVE]=gadget=CreateGadget(BUTTON_KIND,gadget,&newgad[BTID_SAVE],GA_Disabled,gadgetdata->gd_Disabled_BTSaveGG,GT_Underscore,'_',TAG_END);
		wingads[BTID_ABBRUCH]=gadget=CreateGadget(BUTTON_KIND,gadget,&newgad[BTID_ABBRUCH],GA_Disabled,gadgetdata->gd_Disabled_BTAbort,GT_Underscore,'_',TAG_END);
		wingads[CYID_ACTCHAR]=gadget=CreateGadget(CYCLE_KIND,gadget,&newgad[CYID_ACTCHAR],GA_Disabled,gadgetdata->gd_Disabled_CYActualChar,GTCY_Labels,(ULONG)gadgetdata->gd_Labels_CYActualChar,GTCY_Active,gadgetdata->gd_Active_CYActualChar,TAG_END);
		wingads[TXID_STR]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_STR],GA_Disabled,gadgetdata->gd_Disabled_TXStrength,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXStrength,TAG_END);
		wingads[TXID_INT]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_INT],GA_Disabled,gadgetdata->gd_Disabled_TXInt,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXInt,TAG_END);
		wingads[TXID_GES]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_GES],GA_Disabled,gadgetdata->gd_Disabled_TXGes,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXGes,TAG_END);
		wingads[TXID_SCH]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SCH],GA_Disabled,gadgetdata->gd_Disabled_TXSch,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSch,TAG_END);
		wingads[TXID_KON]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_KON],GA_Disabled,gadgetdata->gd_Disabled_TXKon,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXKon,TAG_END);
		wingads[TXID_KAR]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_KAR],GA_Disabled,gadgetdata->gd_Disabled_TXKar,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXKar,TAG_END);
		wingads[TXID_GLU]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_GLU],GA_Disabled,gadgetdata->gd_Disabled_TXGlu,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXGlu,TAG_END);
		wingads[TXID_ANM]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_ANM],GA_Disabled,gadgetdata->gd_Disabled_TXAnm,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXAnm,TAG_END);
		wingads[INID_STR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_STR],GA_Disabled,gadgetdata->gd_Disabled_INStr,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INStr,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSTR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSTR],GA_Disabled,gadgetdata->gd_Disabled_INMStr,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMStr,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_INT]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_INT],GA_Disabled,gadgetdata->gd_Disabled_INInt,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INInt,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_GES]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_GES],GA_Disabled,gadgetdata->gd_Disabled_INGes,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INGes,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SCH]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SCH],GA_Disabled,gadgetdata->gd_Disabled_INSch,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INSch,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_KON]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_KON],GA_Disabled,gadgetdata->gd_Disabled_INKon,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INKon,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_KAR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_KAR],GA_Disabled,gadgetdata->gd_Disabled_INKar,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INKar,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_GLU]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_GLU],GA_Disabled,gadgetdata->gd_Disabled_INGlu,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INGlu,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_ANM]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_ANM],GA_Disabled,gadgetdata->gd_Disabled_INAnM,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INAnM,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MINT]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MINT],GA_Disabled,gadgetdata->gd_Disabled_INMInt,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMInt,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MGES]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MGES],GA_Disabled,gadgetdata->gd_Disabled_INMGes,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMGes,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSCH]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSCH],GA_Disabled,gadgetdata->gd_Disabled_INMSch,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMSch,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MKON]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MKON],GA_Disabled,gadgetdata->gd_Disabled_INMKon,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMKon,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MKAR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MKAR],GA_Disabled,gadgetdata->gd_Disabled_INMKar,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMKar,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MGLU]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MGLU],GA_Disabled,gadgetdata->gd_Disabled_INMGlu,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMGlu,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MANM]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MANM],GA_Disabled,gadgetdata->gd_Disabled_INMAnM,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMAnM,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[TXID_ATT]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_ATT],GA_Disabled,gadgetdata->gd_Disabled_TXAtt,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXAtt,TAG_END);
		wingads[TXID_PAR]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_PAR],GA_Disabled,gadgetdata->gd_Disabled_TXPar,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXPar,TAG_END);
		wingads[TXID_SCHW]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SCHW],GA_Disabled,gadgetdata->gd_Disabled_TXSchw,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSchw,TAG_END);
		wingads[TXID_KRI]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_KRI],GA_Disabled,gadgetdata->gd_Disabled_TXKri,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXKri,TAG_END);
		wingads[TXID_FaF]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_FaF],GA_Disabled,gadgetdata->gd_Disabled_TXFaF,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXFaF,TAG_END);
		wingads[TXID_FAE]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_FAE],GA_Disabled,gadgetdata->gd_Disabled_TXFaE,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXFaE,TAG_END);
		wingads[TXID_SCO]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SCO],GA_Disabled,gadgetdata->gd_Disabled_TXScO,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXScO,TAG_END);
		wingads[TXID_SUC]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SUC],GA_Disabled,gadgetdata->gd_Disabled_TXSuc,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSuc,TAG_END);
		wingads[TXID_SRL]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SRL],GA_Disabled,gadgetdata->gd_Disabled_TXSrL,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSrL,TAG_END);
		wingads[TXID_MAB]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_MAB],GA_Disabled,gadgetdata->gd_Disabled_TXMaB,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXMaB,TAG_END);
		wingads[INID_ATT]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_ATT],GA_Disabled,gadgetdata->gd_Disabled_INAtt,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INAtt,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_PAR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_PAR],GA_Disabled,gadgetdata->gd_Disabled_INPar,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INPar,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SCHW]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SCHW],GA_Disabled,gadgetdata->gd_Disabled_INSchw,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INSchw,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_KRI]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_KRI],GA_Disabled,gadgetdata->gd_Disabled_INKri,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INKri,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_FAF]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_FAF],GA_Disabled,gadgetdata->gd_Disabled_INFaF,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INFaF,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_FAE]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_FAE],GA_Disabled,gadgetdata->gd_Disabled_INFaE,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INFaE,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SCO]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SCO],GA_Disabled,gadgetdata->gd_Disabled_INScO,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INScO,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SUC]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SUC],GA_Disabled,gadgetdata->gd_Disabled_INSuc,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INSuc,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SRL]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SRL],GA_Disabled,gadgetdata->gd_Disabled_INSrL,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INSrL,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MAB]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MAB],GA_Disabled,gadgetdata->gd_Disabled_INMaB,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMaB,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MATT]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MATT],GA_Disabled,gadgetdata->gd_Disabled_INMAtt,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMAtt,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MPAR]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MPAR],GA_Disabled,gadgetdata->gd_Disabled_INMPar,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMPar,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSCHW]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSCHW],GA_Disabled,gadgetdata->gd_Disabled_INMSchw,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMSchw,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MKRI]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MKRI],GA_Disabled,gadgetdata->gd_Disabled_INMKri,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMKri,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MFAF]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MFAF],GA_Disabled,gadgetdata->gd_Disabled_INMFaF,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMFaF,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MFAE]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MFAE],GA_Disabled,gadgetdata->gd_Disabled_INMFaE,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMFaE,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSCO]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSCO],GA_Disabled,gadgetdata->gd_Disabled_INMScO,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMScO,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSUC]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSUC],GA_Disabled,gadgetdata->gd_Disabled_INMSuc,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMSuc,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSRL]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSRL],GA_Disabled,gadgetdata->gd_Disabled_INMSrL,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMSrL,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MMAB]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MMAB],GA_Disabled,gadgetdata->gd_Disabled_INMMaB,GA_TabCycle,TRUE,GTIN_MaxChars,2,GTIN_Number,gadgetdata->gd_Number_INMMaB,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_LP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_LP],GA_Disabled,gadgetdata->gd_Disabled_INLP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INLP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[TXID_LP]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_LP],GA_Disabled,gadgetdata->gd_Disabled_TXLP,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXLP,TAG_END);
		wingads[INID_MLP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MLP],GA_Disabled,gadgetdata->gd_Disabled_INMLP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INMLP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[TXID_SP]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SP],GA_Disabled,gadgetdata->gd_Disabled_TXSP,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSP,TAG_END);
		wingads[INID_SP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SP],GA_Disabled,gadgetdata->gd_Disabled_INSP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INSP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_MSP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_MSP],GA_Disabled,gadgetdata->gd_Disabled_INMSP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INMSP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[TXID_TP]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_TP],GA_Disabled,gadgetdata->gd_Disabled_TXTP,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXTP,TAG_END);
		wingads[TXID_SLP]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_SLP],GA_Disabled,gadgetdata->gd_Disabled_TXSLP,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXSLP,TAG_END);
		wingads[INID_TP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_TP],GA_Disabled,gadgetdata->gd_Disabled_INTP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INTP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_SLP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_SLP],GA_Disabled,gadgetdata->gd_Disabled_INSLP,GA_TabCycle,TRUE,GTIN_MaxChars,3,GTIN_Number,gadgetdata->gd_Number_INSLP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[TXID_EP]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_EP],GA_Disabled,gadgetdata->gd_Disabled_TXEP,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXEP,TAG_END);
		wingads[TXID_GOLD]=gadget=CreateGadget(TEXT_KIND,gadget,&newgad[TXID_GOLD],GA_Disabled,gadgetdata->gd_Disabled_TXGold,GTTX_Border,FALSE,GTTX_CopyText,TRUE,GTTX_Text,(ULONG)gadgetdata->gd_Text_TXGold,TAG_END);
		wingads[INID_EP]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_EP],GA_Disabled,gadgetdata->gd_Disabled_INEP,GA_TabCycle,TRUE,GTIN_MaxChars,5,GTIN_Number,gadgetdata->gd_Number_INEP,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[INID_GOLD]=gadget=CreateGadget(INTEGER_KIND,gadget,&newgad[INID_GOLD],GA_Disabled,gadgetdata->gd_Disabled_INGold,GA_TabCycle,TRUE,GTIN_MaxChars,5,GTIN_Number,gadgetdata->gd_Number_INGold,STRINGA_ExitHelp,TRUE,STRINGA_Justification,GACT_STRINGCENTER,STRINGA_ReplaceMode,FALSE,TAG_END);
		wingads[BTID_ZUFALL]=gadget=CreateGadget(BUTTON_KIND,gadget,&newgad[BTID_ZUFALL],GA_Disabled,gadgetdata->gd_Disabled_BTZufall,GT_Underscore,'_',TAG_END);
		wingads[BTID_ORIGINAL]=gadget=CreateGadget(BUTTON_KIND,gadget,&newgad[BTID_ORIGINAL],GA_Disabled,gadgetdata->gd_Disabled_BTOriginal,GT_Underscore,'_',TAG_END);
		return gadget;
		}
	else return NULL;
}
/*************************************************************************/
/*                                                                       */
/*   Routines to handle windows                                          */
/*                                                                       */
/*************************************************************************/
void HandleAmberCheat(struct Screen *customscreen,LONG left,LONG top,APTR userdata)
{
	APTR             visualinfo   = NULL;
	struct Gadget   *gadgetlist   = NULL;
	char            *title        = "AmberCheat V1.0g ©1996 by W. Pernath";
	struct Window   *win          = NULL;
	struct Menu     *menu         = NULL;

	struct Gadget   *wingads[149];
	struct TextAttr  textattr     = { NULL,8,FS_NORMAL,FPF_DISKFONT };
	ULONG  height=29,width=64,maxheight=29,maxwidth=64;

	textattr.ta_Name  = ((struct GfxBase *)GfxBase)->DefaultFont->tf_Message.mn_Node.ln_Name;
	textattr.ta_YSize = ((struct GfxBase *)GfxBase)->DefaultFont->tf_YSize;

	visualinfo        = GetVisualInfo(customscreen,TAG_DONE);

	char *LA_CYActualChar[]  = { "Eigener Charakter", NULL };

			
	struct BevelFrame bevels[] = { XPOS(0),YPOS(3),XSIZE(22),YSIZE(20),"Attribute",2,
																XPOS(23),YPOS(3),XSIZE(20),YSIZE(23),"Fähigkeiten",2,
																XPOS(44),YPOS(3),XSIZE(20),YSIZE(20),"Anderes",2 };
		
		struct NewGadget newgad[] = { XPOS(0),YPOS(27),XSIZE(12),YSIZE(2),"_Sichern",&textattr, BTID_SAVE,PLACETEXT_IN,visualinfo,NULL,
			XPOS(52),YPOS(27),XSIZE(12),YSIZE(2),"_Abbruch",&textattr, BTID_ABBRUCH,PLACETEXT_IN,visualinfo,NULL,
			XPOS(0),YPOS(0),XSIZE(64),YSIZE(2),NULL,&textattr, CYID_ACTCHAR,PLACETEXT_ABOVE,visualinfo,NULL,
			XPOS(2),YPOS(5),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_STR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(7),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_INT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(9),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_GES,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(11),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_SCH,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(13),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_KON,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(15),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_KAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(17),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_GLU,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(2),YPOS(19),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_ANM,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(5),XSIZE(5),YSIZE(2),NULL,&textattr, INID_STR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(5),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSTR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(7),XSIZE(5),YSIZE(2),NULL,&textattr, INID_INT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(9),XSIZE(5),YSIZE(2),NULL,&textattr, INID_GES,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(11),XSIZE(5),YSIZE(2),NULL,&textattr, INID_SCH,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(13),XSIZE(5),YSIZE(2),NULL,&textattr, INID_KON,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(15),XSIZE(5),YSIZE(2),NULL,&textattr, INID_KAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(17),XSIZE(5),YSIZE(2),NULL,&textattr, INID_GLU,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(7),YPOS(19),XSIZE(5),YSIZE(2),NULL,&textattr, INID_ANM,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(7),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MINT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(9),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MGES,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(11),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSCH,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(13),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MKON,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(15),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MKAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(17),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MGLU,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(13),YPOS(19),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MANM,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(4),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_ATT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(6),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_PAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(8),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_SCHW,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(10),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_KRI,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(12),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_FaF,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(14),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_FAE,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(16),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_SCO,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(18),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_SUC,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(20),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_SRL,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(25),YPOS(22),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_MAB,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(4),XSIZE(5),YSIZE(2),NULL,&textattr, INID_ATT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(6),XSIZE(5),YSIZE(2),NULL,&textattr, INID_PAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(8),XSIZE(5),YSIZE(2),NULL,&textattr, INID_SCHW,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(10),XSIZE(5),YSIZE(2),NULL,&textattr, INID_KRI,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(12),XSIZE(5),YSIZE(2),NULL,&textattr, INID_FAF,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(14),XSIZE(5),YSIZE(2),NULL,&textattr, INID_FAE,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(16),XSIZE(5),YSIZE(2),NULL,&textattr, INID_SCO,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(18),XSIZE(5),YSIZE(2),NULL,&textattr, INID_SUC,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(20),XSIZE(5),YSIZE(2),NULL,&textattr, INID_SRL,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(29),YPOS(22),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MAB,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(4),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MATT,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(6),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MPAR,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(8),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSCHW,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(10),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MKRI,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(12),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MFAF,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(14),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MFAE,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(16),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSCO,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(18),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSUC,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(20),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MSRL,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(35),YPOS(22),XSIZE(5),YSIZE(2),NULL,&textattr, INID_MMAB,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(49),YPOS(4),XSIZE(6),YSIZE(2),NULL,&textattr, INID_LP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(4),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_LP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(56),YPOS(4),XSIZE(6),YSIZE(2),NULL,&textattr, INID_MLP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(6),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_SP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(49),YPOS(6),XSIZE(6),YSIZE(2),NULL,&textattr, INID_SP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(56),YPOS(6),XSIZE(6),YSIZE(2),NULL,&textattr, INID_MSP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(10),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_TP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(12),XSIZE(4),YSIZE(2),NULL,&textattr, TXID_SLP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(51),YPOS(10),XSIZE(7),YSIZE(2),NULL,&textattr, INID_TP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(51),YPOS(12),XSIZE(7),YSIZE(2),NULL,&textattr, INID_SLP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(16),XSIZE(3),YSIZE(2),NULL,&textattr, TXID_EP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(45),YPOS(18),XSIZE(7),YSIZE(2),NULL,&textattr, TXID_GOLD,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(51),YPOS(16),XSIZE(10),YSIZE(2),NULL,&textattr, INID_EP,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(51),YPOS(18),XSIZE(10),YSIZE(2),NULL,&textattr, INID_GOLD,PLACETEXT_LEFT,visualinfo,NULL,
			XPOS(44),YPOS(24),XSIZE(20),YSIZE(2),"_Zufall",&textattr, BTID_ZUFALL,PLACETEXT_IN,visualinfo,NULL,
			XPOS(0),YPOS(24),XSIZE(22),YSIZE(2),"_Originale Werte",&textattr, BTID_ORIGINAL,PLACETEXT_IN,visualinfo,NULL
			};

		struct AmberCheatData gadgetdata = {
			/* belongs to a button */
			FALSE, FALSE, FALSE, 0, (char * *)LA_CYActualChar, FALSE, "STÄ", FALSE, "INT", FALSE, "GES", FALSE, "SCH", FALSE, "KON", FALSE, "KAR", FALSE, "GLÜ", FALSE,  "A-M", FALSE,
			0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, "ATT", FALSE, "PAR",
			FALSE, "SCH", FALSE, "KRI", FALSE, "F-F", FALSE, "F-E", FALSE, "S-Ö", FALSE, "SUC", FALSE, "SRL", FALSE, "M-B", FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0,
			FALSE, 0,  FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, 0, FALSE, "LP ", FALSE, 0, FALSE, "SP",
			FALSE, 0, FALSE, 0, FALSE, "TP", FALSE, "SLP", FALSE, 0, FALSE, 0, FALSE, "EP", FALSE, "Gold", FALSE, 0, FALSE, 0, FALSE, FALSE };
	
	if (visualinfo)
	{
	
		height= YSIZE(height);
		width = XSIZE(width) ;
		left = (customscreen->Width -width )/2;
		top  = (customscreen->Height-height)/2;

		if (CreateGadgetsAmberCheat(&gadgetlist,newgad,wingads,&gadgetdata) != NULL)
			{
			if (height>customscreen->Height || width>customscreen->Width) GUIC_ErrorReport(NULL,ERROR_SCREEN_TOO_SMALL);
			win=OpenWindowTags(NULL,WA_Activate,         TRUE,
						WA_CloseGadget,      TRUE,
						WA_DepthGadget,      TRUE,
						WA_SizeGadget,       TRUE,
						WA_DragBar,          TRUE,
						WA_Gadgets,          (ULONG)gadgetlist,
						WA_InnerHeight,      height,
						WA_InnerWidth,       width,
						WA_IDCMP,            IDCMP_CLOSEWINDOW|IDCMP_VANILLAKEY|IDCMP_REFRESHWINDOW|IDCMP_GADGETUP|BUTTONIDCMP|INTEGERIDCMP|CYCLEIDCMP|IDCMP_MENUPICK,
						WA_Left,             left,
						WA_Top,              top,
						WA_MaxHeight,        maxheight,
						WA_MinHeight,        height,
						WA_MaxWidth,         maxwidth,
						WA_MinWidth,         width,
						WA_SizeBRight,       FALSE,
						WA_SizeBBottom,      TRUE,
						WA_SmartRefresh,     TRUE,
						WA_CustomScreen,     (ULONG)customscreen,
						WA_Title,            (ULONG)title,
						WA_NewLookMenus,     TRUE,
					TAG_END);
			if (win)
				{
					if ( menu = BuildMenus( visualinfo ) )
					{
						SetMenuStrip( win, menu );

							struct IntuiMessage  *imessage   = NULL;
							struct Gadget        *idcmpgad   = NULL;
							struct Gadget        *firstboopsi= 0;
							ULONG  idcmpclass                = 0;
							UWORD  messagecode               = 0;
							BOOL   running                   = TRUE;
							ULONG  signal                    = 0;
							ULONG  longpointer1              = 0;
							ULONG  longpointer2              = 0;
							LONG                 xscale      = 1;
							LONG                 yscale      = 1;
							ULONG                i           = 0;
							struct NewGadget     ngcopy[149];
							struct BevelFrame    bbcopy[3];
							char * stringpointer             = NULL;

							CopyMem(newgad,ngcopy,sizeof(ngcopy));
							CopyMem(bevels,bbcopy,sizeof(bbcopy));
							SetFont(win->RPort,((struct GfxBase *)GfxBase)->DefaultFont);
							CreateBevelFrames(win,visualinfo,3,bevels);
							GT_RefreshWindow(win,NULL);
							UserSetupAmberCheat(win,wingads,userdata);
							do
								{
								WindowLimits(win,width+win->BorderLeft+win->BorderRight,height+win->BorderTop+win->BorderBottom,maxwidth,maxheight);
								if (running) signal=Wait(SIGBREAKF_CTRL_C | 1L << win->UserPort->mp_SigBit);
								if (signal & SIGBREAKF_CTRL_C) running=FALSE;
								WindowLimits(win,win->Width,win->Height,win->Width,win->Height);
								while (running && (imessage=GT_GetIMsg(win->UserPort)))
									{
									idcmpgad=(struct Gadget *)imessage->IAddress;
									idcmpclass=imessage->Class;
									messagecode =imessage->Code;

									GT_ReplyIMsg(imessage);

									switch(idcmpclass)
										{
										case IDCMP_REFRESHWINDOW:
											GT_BeginRefresh(win);
											GT_EndRefresh(win,TRUE);
											break;
										case IDCMP_CLOSEWINDOW:
											BTAbbruch(win, NULL, 0, 0, NULL );
											break;
										case IDCMP_GADGETUP:
										case MXIDCMP:
											HandleGadgetsAmberCheat(win,wingads,idcmpgad->GadgetID,messagecode,&gadgetdata,userdata);
											break;
										case IDCMP_NEWSIZE:
											RemoveGList(win,gadgetlist,-1);
											SetAPen(win->RPort,0L);
											RectFill(win->RPort,win->BorderLeft,win->BorderTop,win->Width-win->BorderRight-1,win->Height-win->BorderBottom-1);
											RefreshWindowFrame(win);

											xscale=(long)win->Width /(long)(width+win->BorderLeft+win->BorderRight);
											yscale=(long)win->Height/(long)(height+win->BorderTop+win->BorderBottom);
											for (i=0;i<149;i++)
												{
												ngcopy[i].ng_LeftEdge=(WORD)((long)newgad[i].ng_LeftEdge*xscale);
												ngcopy[i].ng_TopEdge =(WORD)((long)newgad[i].ng_TopEdge *yscale);
												ngcopy[i].ng_Width   =(WORD)((long)newgad[i].ng_Width   *xscale);
												ngcopy[i].ng_Height  =(WORD)((long)newgad[i].ng_Height  *yscale);
												}
											for (i=0;i<3;i++)
												{
												bbcopy[i].bb_LeftEdge=(WORD)((long)bevels[i].bb_LeftEdge*xscale);
												bbcopy[i].bb_TopEdge =(WORD)((long)bevels[i].bb_TopEdge *yscale);
												bbcopy[i].bb_Width   =(WORD)((long)bevels[i].bb_Width   *xscale);
												bbcopy[i].bb_Height  =(WORD)((long)bevels[i].bb_Height  *yscale);
												}
											
											GT_GetGadgetAttrs(wingads[CYID_ACTCHAR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTCY_Active,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Active_CYActualChar=longpointer2;
											
											GT_GetGadgetAttrs(wingads[INID_STR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INStr=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INStr=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSTR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMStr=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMStr=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_INT],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INInt=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INInt=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_GES],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INGes=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INGes=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SCH],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSch=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSch=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_KON],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INKon=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INKon=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_KAR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INKar=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INKar=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_GLU],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INGlu=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INGlu=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_ANM],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INAnM=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INAnM=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MINT],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMInt=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMInt=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MGES],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMGes=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMGes=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSCH],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMSch=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMSch=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MKON],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMKon=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMKon=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MKAR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMKar=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMKar=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MGLU],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMGlu=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMGlu=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MANM],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMAnM=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMAnM=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_ATT],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INAtt=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INAtt=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_PAR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INPar=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INPar=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SCHW],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSchw=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSchw=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_KRI],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INKri=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INKri=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_FAF],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INFaF=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INFaF=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_FAE],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INFaE=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INFaE=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SCO],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INScO=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INScO=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SUC],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSuc=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSuc=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SRL],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSrL=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSrL=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MAB],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMaB=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMaB=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MATT],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMAtt=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMAtt=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MPAR],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMPar=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMPar=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSCHW],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMSchw=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMSchw=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MKRI],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMKri=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMKri=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MFAF],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMFaF=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMFaF=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MFAE],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMFaE=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMFaE=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSCO],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMScO=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMScO=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSUC],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMSuc=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMSuc=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSRL],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMSrL=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMSrL=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MMAB],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMMaB=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMMaB=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_LP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INLP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INLP=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSP=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_MSP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INMSP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INMSP=longpointer2;
											
											GT_GetGadgetAttrs(wingads[INID_TP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INTP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INTP=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_SLP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INSLP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INSLP=longpointer2;
											
											GT_GetGadgetAttrs(wingads[INID_EP],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INEP=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INEP=longpointer2;
											GT_GetGadgetAttrs(wingads[INID_GOLD],win,NULL,GA_Disabled,(ULONG)&longpointer1,GTIN_Number,(ULONG)&longpointer2,TAG_END);
											gadgetdata.gd_Disabled_INGold=(longpointer1 == 0)?FALSE:TRUE;
											gadgetdata.gd_Number_INGold=longpointer2;
											
											FreeGadgets(gadgetlist);
											gadgetlist=NULL;

											CreateGadgetsAmberCheat(&gadgetlist,ngcopy,wingads,&gadgetdata);
											AddGList(win,gadgetlist,-1,-1,NULL);
											RefreshGList(gadgetlist,win,NULL,-1);
											GT_RefreshWindow(win,NULL);
											CreateBevelFrames(win,visualinfo,3,bbcopy);
											UserRefreshAmberCheat(win,wingads,userdata);
											break;

										case IDCMP_MENUPICK:
											HandleMenus( win, menu, messagecode, userdata );
											break;

										case IDCMP_VANILLAKEY:
											switch(messagecode)
												{
												case 's':
													GT_GetGadgetAttrs(wingads[BTID_SAVE],win,NULL,GA_Disabled,(ULONG)&longpointer1,TAG_END);
													if (longpointer1 == 0)
														{
														ShowGadget(win,wingads[BTID_SAVE],GADGET_DOWN);
														Delay(5);
														ShowGadget(win,wingads[BTID_SAVE],GADGET_UP  );
														HandleGadgetsAmberCheat(win,wingads,BTID_SAVE,messagecode,&gadgetdata,userdata);
														}
													break;
												case 'a':
													GT_GetGadgetAttrs(wingads[BTID_ABBRUCH],win,NULL,GA_Disabled,(ULONG)&longpointer1,TAG_END);
													if (longpointer1 == 0)
														{
														ShowGadget(win,wingads[BTID_ABBRUCH],GADGET_DOWN);
														Delay(5);
														ShowGadget(win,wingads[BTID_ABBRUCH],GADGET_UP  );
														HandleGadgetsAmberCheat(win,wingads,BTID_ABBRUCH,messagecode,&gadgetdata,userdata);
														}
													break;
												case 'z':
													GT_GetGadgetAttrs(wingads[BTID_ZUFALL],win,NULL,GA_Disabled,(ULONG)&longpointer1,TAG_END);
													if (longpointer1 == 0)
														{
														ShowGadget(win,wingads[BTID_ZUFALL],GADGET_DOWN);
														Delay(5);
														ShowGadget(win,wingads[BTID_ZUFALL],GADGET_UP  );
														HandleGadgetsAmberCheat(win,wingads,BTID_ZUFALL,messagecode,&gadgetdata,userdata);
														}
													break;
												case 'o':
													GT_GetGadgetAttrs(wingads[BTID_ORIGINAL],win,NULL,GA_Disabled,(ULONG)&longpointer1,TAG_END);
													if (longpointer1 == 0)
														{
														ShowGadget(win,wingads[BTID_ORIGINAL],GADGET_DOWN);
														Delay(5);
														ShowGadget(win,wingads[BTID_ORIGINAL],GADGET_UP  );
														HandleGadgetsAmberCheat(win,wingads,BTID_ORIGINAL,messagecode,&gadgetdata,userdata);
														}
													break;
												}
											break;
										}
									/* end-switch */
									}
								/* end-while */
								}
							while (running);

						ClearMenuStrip( win );
						FreeMenus( menu );
					}

				if (win) CloseWindow(win);
				}
			else GUIC_ErrorReport(win,ERROR_NO_WINDOW_OPENED);
			if (gadgetlist) FreeGadgets(gadgetlist);
			}
		else GUIC_ErrorReport(NULL,ERROR_NO_GADGETS_CREATED);
		if (visualinfo) FreeVisualInfo(visualinfo);
		}
	else GUIC_ErrorReport(NULL,ERROR_NO_VISUALINFO);
}
