#ifndef MAKE_ID
#define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif

#include  <proto/alib.h>
#include  <proto/exec.h>
#include  <libraries/gadtools.h>
#define   NO_INLINE_STDARG
#include  <proto/muimaster.h>


#include "AmberCheat_gui.h"
#include "AmberCheat_req.h"
#include "AmberCheat_guiExtern.h"
#include "amber_vars.h"

extern  void hookEntry( void );
extern  struct ObjApp *gui;

/*///"void AboutMUI( Object *o)"*/
void AboutMUI( Object *o )
{
	if(!gui->aboutwin )
	{
		gui->aboutwin = AboutmuiObject,
			MUIA_Window_RefWindow, gui->MainWindow,
			MUIA_Aboutmui_Application, gui->App,
		End;
	}

	if(gui->aboutwin )
		set(gui->aboutwin, MUIA_Window_Open, TRUE );
	else
		set(gui->ABOUTMUI, MUIA_Window_Open, TRUE );
}
/*///*/
/*///"struct ObjApp *CreateApp(void )"
** Create the application and generate the notifications.
*/
struct ObjApp *CreateApp(void)
{
	struct ObjApp *MBObj;
	ULONG  open = 0;
	APTR  MNlabel1Projekt, MNLadeOrig, MNlabel1SichereCharakterbogen, MNlabel1Sicheretemporr;
	APTR  MNlabel1BarLabel1, MNlabel1aboutMUI, MNlabelaboutAmberCheat, MNlabel1BarLabel2;
	APTR  MNlabel1Information, GROUP_ROOT_0, GR_Register, GR_Attribute, GR_Gadgets1;
	APTR  LA_label_0, LA_label_2cccc, LA_label_3, LA_label_4, LA_label_5, LA_label_6;
	APTR  LA_label_7, LA_label_8, GR_FAEHIGK, GR_Gadgets2, LA_label_0C, LA_label_2C;
	APTR  LA_label_3C, LA_label_4C, LA_label_5C, LA_label_6C, LA_label_7C, LA_label_8C;
	APTR  LA_label_9, LA_label_10, GR_Others, obj_aux0, obj_aux1, REC_label_2;
	APTR  G_LPASP, LA_label_1, LA_label_2, REC_label_3, G_GoldAndSo, obj_aux2;
	APTR  obj_aux3, G_GoldAndSoCC, obj_aux4, obj_aux5, obj_aux6, obj_aux7, REC_label_0C;
	APTR  GR_OTHERS, Space_0, REC_label_0, G_Actions, GROUP_ROOT_1, G_TEXT;
	APTR  Space_1CC, G_OKAY, Space_1, Space_2cc, GROUP_ROOT_2, G_TEXTCC, G_OKAYCC;
	APTR  Space_3CC, Space_1CCCC, GROUP_ROOT_3, GR_grp_0, GR_grp_1;
	static const struct Hook ChangeRegPageHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC) ChangeRegPage, NULL};
	static const struct Hook UndoHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC)DoUndo, NULL};
	static const struct Hook CreateCharacterHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC) CreateCharacter, NULL};
	static const struct Hook SaveCharactersHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC) SaveCharacters, NULL};
	static const struct Hook ReallyQuitHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC) ReallyQuit, NULL};
	static const struct Hook ChangeCharacterHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC) ChangeCharacter, NULL};
	static const struct Hook InfoReqHook = { {NULL, NULL}, (APTR)hookEntry, (HOOKFUNC)InfoReq, NULL};
	static const struct Hook AboutMUIHook = {{NULL, NULL}, (APTR)hookEntry, (HOOKFUNC)AboutMUI, NULL};

	if (!(MBObj = (struct ObjApp *) AllocVec(sizeof(struct ObjApp), MEMF_PUBLIC|MEMF_CLEAR)))
		return(NULL);

	MBObj->STR_TX_label_2 = "\n\033c\0338MUIAmberCheat\0332\n\nThis is a MUI-Application.\n\033cMUI is copyrighted by Stefan Stuntz.\n\nGUI designed with Eric Totel's\nMUIBuilder V2.2b\n";
	MBObj->STR_TX_label_2CC = "\n\033c\0338AmberCheat\0332 Version 1.1MUI\n\nAmberCheat ist ein Programm, mit dem es auf einfache\nArt und Weise möglich ist, die vorgegebenen\nCharaktere aus AmberMoon zu\nverändern.\n\n\033bAuthor:\033n\npernathw@stud.fak11.uni-muenchen.de\n";

	MBObj->CY_CHARContent[0] = "Eigener Charakter";
	MBObj->CY_CHARContent[1] = "NETSRAK";
	MBObj->CY_CHARContent[2] = "MANDO";
	MBObj->CY_CHARContent[3] = "ERIK";
	MBObj->CY_CHARContent[4] = "CHRIS";
	MBObj->CY_CHARContent[5] = "MONIKA";
	MBObj->CY_CHARContent[6] = "TAR DER DUNKLE";
	MBObj->CY_CHARContent[7] = "EGIL";
	MBObj->CY_CHARContent[8] = "SELENA";
	MBObj->CY_CHARContent[9] = "NELVIN";
	MBObj->CY_CHARContent[10] = "SABINE";
	MBObj->CY_CHARContent[11] = "VALDYN";
	MBObj->CY_CHARContent[12] = "TARGOR";
	MBObj->CY_CHARContent[13] = "LEONARIA";
	MBObj->CY_CHARContent[14] = "GRYBAN";
	MBObj->CY_CHARContent[15] = NULL;
	MBObj->STR_GR_Register[0] = "Attribute";
	MBObj->STR_GR_Register[1] = "Fähigkeiten";
	MBObj->STR_GR_Register[2] = "Anderes";
	MBObj->STR_GR_Register[3] = NULL;

	MBObj->CY_CHAR = CycleObject,
		MUIA_HelpNode, "NODE_HEROS",
		MUIA_ShortHelp, "Dieser Schalter wählt den\naktuellen Helden aus.",
		MUIA_ControlChar, 'c',
		MUIA_Cycle_Entries, MBObj->CY_CHARContent,
	End;

	LA_label_0 = Label("STÄ");

	MBObj->SL_STR = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Stärke: Beeinflußt Höchstgewicht\ndes Gepäcks.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSTR = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_2cccc = Label("INT");

	MBObj->SL_INT = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Intelligenz: Beeinflußt die Lernfähigkeit.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MINT = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_3 = Label("GES");

	MBObj->SL_GES = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Geschicklichkeit: Beeinflußt Öffnen\nund Finden von Fallen.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MGES = SliderObject,
		MUIA_HelpNode, "NODE_ATTRS",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_4 = Label("SCH");

	MBObj->SL_SCH = SliderObject,
		MUIA_HelpNode, "SL_SCH",
		MUIA_ShortHelp, "Schnelligkeit: Wann kommt dieser\nCharakter im Kampf zum Zug?",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSCH = SliderObject,
		MUIA_HelpNode, "SL_MSCH",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_5 = Label("KON");

	MBObj->SL_KON = SliderObject,
		MUIA_HelpNode, "SL_KON",
		MUIA_ShortHelp, "Konstitution: Was kann ein Charakter\nan Schädigung aushalten?",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MKON = SliderObject,
		MUIA_HelpNode, "SL_MKON",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_6 = Label("KAR");

	MBObj->SL_KAR = SliderObject,
		MUIA_HelpNode, "SL_KAR",
		MUIA_ShortHelp, "Charisma: Beeinflußt das\nVerhalten von Händlern.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MKAR = SliderObject,
		MUIA_HelpNode, "SL_MKAR",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_7 = Label("GLÜ");

	MBObj->SL_LUC = SliderObject,
		MUIA_HelpNode, "SL_LUC",
		MUIA_ShortHelp, "Glück: Wahrscheinlichkeit für das\nÜberleben einer Falle.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MLUC = SliderObject,
		MUIA_HelpNode, "SL_MLUC",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_8 = Label("A-M");

	MBObj->SL_ANM = SliderObject,
		MUIA_HelpNode, "SL_ANM",
		MUIA_ShortHelp, "Anti-Magie: Widerstandskraft\ngegen magische Angriffe.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MANM = SliderObject,
		MUIA_HelpNode, "SL_MANM",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	GR_Gadgets1 = GroupObject,
		MUIA_FramePhantomHoriz, TRUE,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_Group_Columns, 3,
		MUIA_HelpNode, "NODE_ATTRS",
		Child, LA_label_0,
		Child, MBObj->SL_STR,
		Child, MBObj->SL_MSTR,
		Child, LA_label_2cccc,
		Child, MBObj->SL_INT,
		Child, MBObj->SL_MINT,
		Child, LA_label_3,
		Child, MBObj->SL_GES,
		Child, MBObj->SL_MGES,
		Child, LA_label_4,
		Child, MBObj->SL_SCH,
		Child, MBObj->SL_MSCH,
		Child, LA_label_5,
		Child, MBObj->SL_KON,
		Child, MBObj->SL_MKON,
		Child, LA_label_6,
		Child, MBObj->SL_KAR,
		Child, MBObj->SL_MKAR,
		Child, LA_label_7,
		Child, MBObj->SL_LUC,
		Child, MBObj->SL_MLUC,
		Child, LA_label_8,
		Child, MBObj->SL_ANM,
		Child, MBObj->SL_MANM,
	End;

	GR_Attribute = GroupObject,
		MUIA_Weight, 75,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_FrameTitle, "Charakter Eigenschaften",
		Child, GR_Gadgets1,
	End;

	LA_label_0C = Label("ATT");

	MBObj->SL_ATT = SliderObject,
		MUIA_HelpNode, "SL_ATT",
		MUIA_ShortHelp, "Attacke: Wahrscheinlichkeit für einen\nTreffer im Kampf.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MATT = SliderObject,
		MUIA_HelpNode, "SL_MATT",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_2C = Label("PAR");

	MBObj->SL_PAR = SliderObject,
		MUIA_HelpNode, "SL_PAR",
		MUIA_ShortHelp, "Parade: Erfolgreiche Abwehr im Kampf.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MPAR = SliderObject,
		MUIA_HelpNode, "SL_MPAR",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_3C = Label("SCH");

	MBObj->SL_SCH2 = SliderObject,
		MUIA_HelpNode, "SL_SCH2",
		MUIA_ShortHelp, "Schwimmen: Wie hoch ist der Schaden\nbeim Schwimmen?",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSCH2 = SliderObject,
		MUIA_HelpNode, "SL_MSCH2",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_4C = Label("KRI");

	MBObj->SL_KRI = SliderObject,
		MUIA_HelpNode, "SL_KRI",
		MUIA_ShortHelp, "Kritische Treffer: Wahrscheinlichkeit\neines tödlichen Treffers.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MKRI = SliderObject,
		MUIA_HelpNode, "SL_MKRI",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_5C = Label("F-F");

	MBObj->SL_FaF = SliderObject,
		MUIA_HelpNode, "SL_FaF",
		MUIA_ShortHelp, "Fallen finden: Wahrscheinlichkeit Fallen zu finden.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MFaF = SliderObject,
		MUIA_HelpNode, "SL_MFaF",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_6C = Label("F-E");

	MBObj->SL_FaE = SliderObject,
		MUIA_HelpNode, "SL_FaE",
		MUIA_ShortHelp, "Fallen entschärfen: Wahrscheinlichkeit,\nFallen zu entschärfen.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MFaE = SliderObject,
		MUIA_HelpNode, "SL_MFaE",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_7C = Label("S-Ö");

	MBObj->SL_ScO = SliderObject,
		MUIA_HelpNode, "SL_ScO",
		MUIA_ShortHelp, "Schlösser öffnen: Schlösser ohne Dietrich öffnen.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MScO = SliderObject,
		MUIA_HelpNode, "SL_MScO",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_8C = Label("SUC");

	MBObj->SL_SUC = SliderObject,
		MUIA_HelpNode, "SL_SUC",
		MUIA_ShortHelp, "Suchen: Wahrscheinlichkeit, versteckte\nSchätze zu finden.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSUC = SliderObject,
		MUIA_HelpNode, "SL_MSUC",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_9 = Label("SRL");

	MBObj->SL_SRL = SliderObject,
		MUIA_HelpNode, "SL_SRL",
		MUIA_ShortHelp, "Spruchrollen lesen: Erlernen von magischen\nSprüchen.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSRL = SliderObject,
		MUIA_HelpNode, "SL_MSRL",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	LA_label_10 = Label("M-B");

	MBObj->SL_MAB = SliderObject,
		MUIA_HelpNode, "SL_MAB",
		MUIA_ShortHelp, "Magie benutzen: Anwendung eines\nmagischen Spruchs.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MMAB = SliderObject,
		MUIA_HelpNode, "SL_MMAB",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Weight, 50,
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 99,
		MUIA_Slider_Level, 0,
	End;

	GR_Gadgets2 = GroupObject,
		MUIA_FramePhantomHoriz, TRUE,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_Group_Columns, 3,
		MUIA_HelpNode, "NODE_FAEH",
		Child, LA_label_0C,
		Child, MBObj->SL_ATT,
		Child, MBObj->SL_MATT,
		Child, LA_label_2C,
		Child, MBObj->SL_PAR,
		Child, MBObj->SL_MPAR,
		Child, LA_label_3C,
		Child, MBObj->SL_SCH2,
		Child, MBObj->SL_MSCH2,
		Child, LA_label_4C,
		Child, MBObj->SL_KRI,
		Child, MBObj->SL_MKRI,
		Child, LA_label_5C,
		Child, MBObj->SL_FaF,
		Child, MBObj->SL_MFaF,
		Child, LA_label_6C,
		Child, MBObj->SL_FaE,
		Child, MBObj->SL_MFaE,
		Child, LA_label_7C,
		Child, MBObj->SL_ScO,
		Child, MBObj->SL_MScO,
		Child, LA_label_8C,
		Child, MBObj->SL_SUC,
		Child, MBObj->SL_MSUC,
		Child, LA_label_9,
		Child, MBObj->SL_SRL,
		Child, MBObj->SL_MSRL,
		Child, LA_label_10,
		Child, MBObj->SL_MAB,
		Child, MBObj->SL_MMAB,
	End;

	GR_FAEHIGK = GroupObject,
		MUIA_Weight, 75,
		MUIA_HelpNode, "NODE_FAEH",
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_FrameTitle, "Charakter Fähigkeiten",
		Child, GR_Gadgets2,
	End;

	MBObj->STR_Name = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_ControlChar, 'n',
		MUIA_HelpNode, "STR_Name",
		MUIA_ShortHelp, "Name: Neuer Name des Helden.\nAchtung: Nur Großbuchstaben eintragen!",
		MUIA_String_MaxLen, 16,
		MUIA_String_Accept, "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
	End;

	obj_aux1 = KeyLabel2("Name", 'n');

	obj_aux0 = GroupObject,
		MUIA_Group_Columns, 2,
		Child, obj_aux1,
		Child, MBObj->STR_Name,
	End;

	REC_label_2 = RectangleObject,
		MUIA_Rectangle_HBar, TRUE,
		MUIA_FixHeight, 8,
	End;

	LA_label_1 = Label("LP");

	MBObj->SL_LP = SliderObject,
		MUIA_HelpNode, "SL_LP",
		MUIA_ShortHelp, "Lebenspunkte: Gesundheit des Charakters",
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 1000,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MLP = SliderObject,
		MUIA_HelpNode, "SL_MLP",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 1000,
		MUIA_Slider_Level, 0,
	End;

	LA_label_2 = Label("SP");

	MBObj->SL_SP = SliderObject,
		MUIA_HelpNode, "SL_SP",
		MUIA_ShortHelp, "Spruchpunkte: Verbliebene magische Energie.",
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 1000,
		MUIA_Slider_Level, 0,
	End;

	MBObj->SL_MSP = SliderObject,
		MUIA_HelpNode, "SL_MSP",
		MUIA_ShortHelp, "Maximal erreichbarer Wert.",
		MUIA_Frame, MUIV_Frame_Slider,
		MUIA_Slider_Min, 0,
		MUIA_Slider_Max, 1000,
		MUIA_Slider_Level, 0,
	End;

	G_LPASP = GroupObject,
		MUIA_Group_Columns, 3,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, LA_label_1,
		Child, MBObj->SL_LP,
		Child, MBObj->SL_MLP,
		Child, LA_label_2,
		Child, MBObj->SL_SP,
		Child, MBObj->SL_MSP,
	End;

	REC_label_3 = RectangleObject,
		MUIA_Rectangle_HBar, TRUE,
		MUIA_FixHeight, 8,
	End;

	MBObj->STR_GOLD = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_ControlChar, 'g',
		MUIA_HelpNode, "STR_GOLD",
		MUIA_ShortHelp, "Gold: Wieviel Gold trägt Charakter mit sich?\nAchtung: Gold hat ein Gewicht!",
		MUIA_String_Accept, "0123456789",
		MUIA_String_MaxLen, 10,
	End;

	obj_aux3 = KeyLabel2("Gold", 'g');

	obj_aux2 = GroupObject,
		MUIA_Group_Columns, 2,
		Child, obj_aux3,
		Child, MBObj->STR_GOLD,
	End;

	G_GoldAndSo = GroupObject,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, obj_aux2,
	End;

	MBObj->STR_TP = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_ControlChar, 't',
		MUIA_HelpNode, "STR_TP",
		MUIA_ShortHelp, "Trainingspunkte: Wieoft kann Charakter noch trainiert werden?",
		MUIA_String_Accept, "0123456789",
		MUIA_String_MaxLen, 10,
	End;

	obj_aux5 = KeyLabel2("TP", 't');

	obj_aux4 = GroupObject,
		MUIA_Group_Columns, 2,
		Child, obj_aux5,
		Child, MBObj->STR_TP,
	End;

	MBObj->STR_SLP = StringObject,
		MUIA_Frame, MUIV_Frame_String,
		MUIA_ControlChar, 'l',
		MUIA_HelpNode, "STR_SLP",
		MUIA_ShortHelp, "Spruchlernpunkte: Wieviele Sprüche kann dieser\nCharakter noch erlernen?",
		MUIA_String_Accept, "0123456789",
		MUIA_String_MaxLen, 10,
	End;

	obj_aux7 = KeyLabel2("SLP", 'l');

	obj_aux6 = GroupObject,
		MUIA_Group_Columns, 2,
		Child, obj_aux7,
		Child, MBObj->STR_SLP,
	End;

	G_GoldAndSoCC = GroupObject,
		MUIA_Group_Columns, 2,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, obj_aux4,
		Child, obj_aux6,
	End;

	GR_Others = GroupObject,
		MUIA_Weight, 75,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_FrameTitle, "Allgemeines über Charakter",
		MUIA_HelpNode, "NODE_OTHERS",
		Child, obj_aux0,
		Child, REC_label_2,
		Child, G_LPASP,
		Child, REC_label_3,
		Child, G_GoldAndSo,
		Child, G_GoldAndSoCC,
	End;

	GR_Register = RegisterObject,
		MUIA_Register_Titles, MBObj->STR_GR_Register,
		MUIA_Weight, 75,
		MUIA_Frame, MUIV_Frame_Group,
		MUIA_FrameTitle, "Charakter Eigenschaften",
		Child, GR_Attribute,
		Child, GR_FAEHIGK,
		Child, GR_Others,
	End;

	REC_label_0C = RectangleObject,
		MUIA_Rectangle_HBar, TRUE,
		MUIA_FixHeight, 8,
	End;

	MBObj->BT_Undo = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'o',
		MUIA_Text_Contents, "Originale Werte",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'O',
		MUIA_HelpNode, "NODE_ORIGINAL",
		MUIA_ShortHelp, "\euUndo:\en Macht letzte Änderung rückgängig.\nAchtung: Gilt nur, solange Charakter aktiv!",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	Space_0 = HSpace(10);

	MBObj->BT_Rnd = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'w',
		MUIA_Text_Contents, "Auswürfeln",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'w',
		MUIA_HelpNode, "NODE_RANDOM",
		MUIA_ShortHelp, "\euAuswürfeln:\en Würfelt Attribute und Fähigkeiten\ndes Charakters aus.",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	GR_OTHERS = GroupObject,
		MUIA_Group_Columns, 3,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, MBObj->BT_Undo,
		Child, Space_0,
		Child, MBObj->BT_Rnd,
	End;

	REC_label_0 = RectangleObject,
		MUIA_Rectangle_HBar, TRUE,
		MUIA_FixHeight, 8,
	End;

	MBObj->BT_Save = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 's',
		MUIA_Text_Contents, "Sichern",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 's',
		MUIA_HelpNode, "NODE_SAVE",
		MUIA_ShortHelp, "\euSichern:\en Sichert Änderungen und beendet AC.",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	MBObj->BT_Abbort = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'a',
		MUIA_Text_Contents, "Abbruch",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'a',
		MUIA_HelpNode, "NODE_QUIT",
		MUIA_ShortHelp, "\euAbbrechen:\en Beendet AC ohne zu sichern.",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	G_Actions = GroupObject,
		MUIA_Group_Columns, 2,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, MBObj->BT_Save,
		Child, MBObj->BT_Abbort,
	End;

	GROUP_ROOT_0 = GroupObject,
		Child, MBObj->CY_CHAR,
		Child, GR_Register,
		Child, REC_label_0C,
		Child, GR_OTHERS,
		Child, REC_label_0,
		Child, G_Actions,
	End;

	MNLadeOrig = MenuitemObject,
		MUIA_Menuitem_Title, "Lade Original",
		MUIA_Menuitem_Shortcut, "l",
	End;

	MNlabel1SichereCharakterbogen = MenuitemObject,
		MUIA_Menuitem_Title, "Sichere Charakterbogen",
	End;

	MNlabel1Sicheretemporr = MenuitemObject,
		MUIA_Menuitem_Title, "Sichere temporär...",
	End;

	MNlabel1BarLabel1 = MUI_MakeObject(MUIO_Menuitem, NM_BARLABEL, 0, 0, 0);

	MNlabel1aboutMUI = MenuitemObject,
		MUIA_Menuitem_Title, "Über MUI...",
	End;

	MNlabelaboutAmberCheat = MenuitemObject,
		MUIA_Menuitem_Title, "Über AmberCheat",
	End;

	MNlabel1BarLabel2 = MUI_MakeObject(MUIO_Menuitem, NM_BARLABEL, 0, 0, 0);

	MNlabel1Information = MenuitemObject,
		MUIA_Menuitem_Title, "Information...",
		MUIA_Menuitem_Shortcut, "?",
	End;

	MNlabel1Projekt = MenuitemObject,
		MUIA_Menuitem_Title, "Projekt",
		#ifdef NEUNEU
		MUIA_Family_Child, MNLadeOrig,
		MUIA_Family_Child, MNlabel1SichereCharakterbogen,
		MUIA_Family_Child, MNlabel1Sicheretemporr,
		MUIA_Family_Child, MNlabel1BarLabel1,
		#endif
		MUIA_Family_Child, MNlabel1aboutMUI,
		MUIA_Family_Child, MNlabelaboutAmberCheat,
		MUIA_Family_Child, MNlabel1BarLabel2,
		MUIA_Family_Child, MNlabel1Information,
	End;

	MBObj->MN_Projekt = MenustripObject,
		MUIA_Family_Child, MNlabel1Projekt,
	End;

	MBObj->MainWindow = WindowObject,
		MUIA_Window_Title, "AmberCheat V1.1MUI",
		MUIA_Window_Menustrip, MBObj->MN_Projekt,
		MUIA_Window_ID, MAKE_ID('0', 'W', 'I', 'N'),
		WindowContents, GROUP_ROOT_0,
	End;

	MBObj->TX_label_2 = TextObject,
		MUIA_Background, MUII_BACKGROUND,
		MUIA_Text_Contents, MBObj->STR_TX_label_2,
		MUIA_Text_SetMin, TRUE,
	End;

	G_TEXT = GroupObject,
		MUIA_Background, MUII_BACKGROUND,
		MUIA_Frame, MUIV_Frame_ReadList,
		Child, MBObj->TX_label_2,
	End;

	Space_1CC = VSpace(4);

	Space_1 = HSpace(4);

	MBObj->BT_OKAY = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'o',
		MUIA_Text_Contents, "OK",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'o',
		MUIA_HelpNode, "BT_OKAY",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	Space_2cc = HSpace(4);

	G_OKAY = GroupObject,
		MUIA_Group_Columns, 3,
		MUIA_Group_HorizSpacing, 10,
		MUIA_Group_VertSpacing, 4,
		Child, Space_1,
		Child, MBObj->BT_OKAY,
		Child, Space_2cc,
	End;

	GROUP_ROOT_1 = GroupObject,
		MUIA_Background, MUII_RequesterBack,
		Child, G_TEXT,
		Child, Space_1CC,
		Child, G_OKAY,
	End;

	MBObj->ABOUTMUI = WindowObject,
		MUIA_Window_Title, "About MUI",
		MUIA_Window_ID, MAKE_ID('1', 'W', 'I', 'N'),
		MUIA_Window_SizeGadget, FALSE,
		MUIA_Window_NoMenus, TRUE,
		WindowContents, GROUP_ROOT_1,
	End;

	MBObj->TX_label_2CC = TextObject,
		MUIA_Background, MUII_BACKGROUND,
		MUIA_Text_Contents, MBObj->STR_TX_label_2CC,
		MUIA_Text_SetMin, TRUE,
	End;

	G_TEXTCC = GroupObject,
		MUIA_Background, MUII_BACKGROUND,
		MUIA_Frame, MUIV_Frame_ReadList,
		MUIA_HelpNode, "NODE_INFOREQ",
		Child, MBObj->TX_label_2CC,
	End;

	Space_3CC = HSpace(40);

	MBObj->BT_OKAYCC = TextObject,
		ButtonFrame,
		MUIA_Weight, 50,
		MUIA_Background, MUII_ButtonBack,
		MUIA_ControlChar, 'o',
		MUIA_Text_Contents, "OK",
		MUIA_Text_PreParse, "\033c",
		MUIA_Text_HiChar, 'o',
		MUIA_HelpNode, "NODE_INFOREQ",
		MUIA_InputMode, MUIV_InputMode_RelVerify,
	End;

	Space_1CCCC = HSpace(40);

	G_OKAYCC = GroupObject,
		MUIA_Weight, 50,
		MUIA_Group_Columns, 3,
		Child, Space_3CC,
		Child, MBObj->BT_OKAYCC,
		Child, Space_1CCCC,
	End;

	GROUP_ROOT_2 = GroupObject,
		MUIA_Background, MUII_RequesterBack,
		Child, G_TEXTCC,
		Child, G_OKAYCC,
	End;

	MBObj->WIABOUTAC = WindowObject,
		MUIA_Window_Title, "Über AmberCheat",
		MUIA_Window_ID, MAKE_ID('2', 'W', 'I', 'N'),
		MUIA_Window_SizeGadget, FALSE,
		MUIA_Window_NoMenus, TRUE,
		WindowContents, GROUP_ROOT_2,
	End;

	MBObj->App = ApplicationObject,
		MUIA_Application_Author, "Wanja Pernath",
		MUIA_Application_Base, "AmberCheat",
		MUIA_Application_Title, "AmberCheat MUI",
		MUIA_Application_Version, "$VER: AmberCheat 1.1MUI  (20.12.97)",
		MUIA_Application_Copyright, "1997 Wanja Pernath",
		MUIA_Application_Description, "Programm zum kreieren eigener Charaktere in AmberMoon",
		MUIA_Application_SingleTask, TRUE,
		MUIA_Application_HelpFile, "AmberCheat_dt.guide",
		SubWindow, MBObj->MainWindow,
		SubWindow, MBObj->ABOUTMUI,
		SubWindow, MBObj->WIABOUTAC,
	End;

	if (!MBObj->App)
	{
		FreeVec(MBObj);
		return(NULL);
	}

	DoMethod((Object *) MNlabel1aboutMUI,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		MBObj->App,
		2,
		MUIM_CallHook, &AboutMUIHook
		);

	DoMethod((Object *) MNlabelaboutAmberCheat,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		MBObj->WIABOUTAC,
		3,
		MUIM_Set, MUIA_Window_Open, TRUE
		);

	DoMethod((Object *) MNlabelaboutAmberCheat,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		MBObj->WIABOUTAC,
		3,
		MUIM_Set, MUIA_Window_Activate, TRUE
		);

	DoMethod((Object *) MNlabel1Information,
		MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
		MBObj->App,
		2,
		MUIM_CallHook, &InfoReqHook
		);

	DoMethod((Object *) MBObj->MainWindow,
		MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		MBObj->App,
		2,
		MUIM_CallHook, &ReallyQuitHook
		);

	DoMethod((Object *) MBObj->CY_CHAR,
		MUIM_Notify, MUIA_Cycle_Active, MUIV_EveryTime,
		MBObj->App,
		2,
		MUIM_CallHook, &ChangeCharacterHook
		);

	DoMethod((Object *) MBObj->CY_CHAR,
		MUIM_Notify, MUIA_Cycle_Active, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, TRUE
		);

	DoMethod((Object *) GR_Register,
		MUIM_Notify, MUIA_Group_ActivePage, MUIV_EveryTime,
		MBObj->App,
		2,
		MUIM_CallHook, &ChangeRegPageHook
		);

	DoMethod((Object *) MBObj->SL_STR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_STR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_STR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &str
		);

	DoMethod((Object *) MBObj->SL_MSTR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MSTR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSTR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mstr
		);

	DoMethod((Object *) MBObj->SL_INT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_INT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_INT,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &Int
		);

	DoMethod((Object *) MBObj->SL_MINT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MINT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MINT,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mint
		);

	DoMethod((Object *) MBObj->SL_GES,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_GES,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_GES,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &ges
		);

	DoMethod((Object *) MBObj->SL_MGES,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MGES,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MGES,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mges
		);

	DoMethod((Object *) MBObj->SL_SCH,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_SCH,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_SCH,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &sch
		);

	DoMethod((Object *) MBObj->SL_MSCH,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MSCH,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSCH,
		3,
		MUIM_WriteLong,MUIV_TriggerValue,&msch
		);

	DoMethod((Object *) MBObj->SL_KON,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_KON,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_KON,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &kon
		);

	DoMethod((Object *) MBObj->SL_MKON,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MKON,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MKON,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mkon
		);

	DoMethod((Object *) MBObj->SL_KAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_KAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_KAR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &kar
		);

	DoMethod((Object *) MBObj->SL_MKAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MKAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MKAR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mkar
		);

	DoMethod((Object *) MBObj->SL_LUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_LUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_LUC,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &glu
		);

	DoMethod((Object *) MBObj->SL_MLUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MLUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MLUC,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mglu
		);

	DoMethod((Object *) MBObj->SL_ANM,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_ANM,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_ANM,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &anm
		);

	DoMethod((Object *) MBObj->SL_MANM,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MANM,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MANM,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &manm
		);

	DoMethod((Object *) MBObj->SL_ATT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_ATT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_ATT,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &att
		);

	DoMethod((Object *) MBObj->SL_MATT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MATT,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MATT,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &matt
		);

	DoMethod((Object *) MBObj->SL_PAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_PAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_PAR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &par
		);

	DoMethod((Object *) MBObj->SL_MPAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MPAR,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MPAR,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mpar
		);

	DoMethod((Object *) MBObj->SL_SCH2,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_SCH2,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_SCH2,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &sch2
		);

	DoMethod((Object *) MBObj->SL_MSCH2,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MSCH2,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSCH2,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &msch2
		);

	DoMethod((Object *) MBObj->SL_KRI,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_KRI,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_KRI,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &kri
		);

	DoMethod((Object *) MBObj->SL_MKRI,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MKRI,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MKRI,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mkri
		);

	DoMethod((Object *) MBObj->SL_FaF,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_FaF,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_FaF,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &faf
		);

	DoMethod((Object *) MBObj->SL_MFaF,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MFaF,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MFaF,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mfaf
		);

	DoMethod((Object *) MBObj->SL_FaE,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_FaE,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_FaE,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &fae
		);

	DoMethod((Object *) MBObj->SL_MFaE,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MFaE,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MFaE,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mfae
		);

	DoMethod((Object *) MBObj->SL_ScO,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_ScO,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_ScO,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &sco
		);

	DoMethod((Object *) MBObj->SL_MScO,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MScO,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MScO,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &msco
		);

	DoMethod((Object *) MBObj->SL_SUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_SUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_SUC,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &suc
		);

	DoMethod((Object *) MBObj->SL_MSUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MSUC,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSUC,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &msuc
		);

	DoMethod((Object *) MBObj->SL_SRL,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_SRL,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_SRL,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &srl
		);

	DoMethod((Object *) MBObj->SL_MSRL,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MSRL,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSRL,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &msrl
		);

	DoMethod((Object *) MBObj->SL_MAB,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MAB,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MAB,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mab
		);

	DoMethod((Object *) MBObj->SL_MMAB,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->SL_MMAB,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MMAB,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mmab
		);

	DoMethod((Object *) MBObj->STR_Name,
		MUIM_Notify, MUIA_String_Contents, MUIV_EveryTime,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, FALSE
		);

	DoMethod((Object *) MBObj->STR_Name,
		MUIM_Notify, MUIA_String_Contents, MUIV_EveryTime,
		MBObj->STR_Name,
		3,
		MUIM_WriteString, MUIV_TriggerValue, &name
		);

	DoMethod((Object *) MBObj->SL_LP,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_LP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &lp
		);

	DoMethod((Object *) MBObj->SL_MLP,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MLP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &mlp
		);

	DoMethod((Object *) MBObj->SL_SP,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_SP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &sp
		);

	DoMethod((Object *) MBObj->SL_MSP,
		MUIM_Notify, MUIA_Slider_Level, MUIV_EveryTime,
		MBObj->SL_MSP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &msp
		);

	DoMethod((Object *) MBObj->STR_GOLD,
		MUIM_Notify, MUIA_Numeric_Value, MUIV_EveryTime,
		MBObj->STR_GOLD,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &gold
		);

	DoMethod((Object *) MBObj->STR_TP,
		MUIM_Notify, MUIA_Numeric_Value, MUIV_EveryTime,
		MBObj->STR_TP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &tp
		);

	DoMethod((Object *) MBObj->STR_SLP,
		MUIM_Notify, MUIA_Numeric_Value, MUIV_EveryTime,
		MBObj->STR_SLP,
		3,
		MUIM_WriteLong, MUIV_TriggerValue, &slp
		);

	DoMethod((Object *) MBObj->BT_Undo,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->App,
		2,
		MUIM_CallHook, &UndoHook
		);

	DoMethod((Object *) MBObj->BT_Undo,
		MUIM_Notify, MUIA_Selected, FALSE,
		MBObj->BT_Undo,
		3,
		MUIM_Set, MUIA_Disabled, TRUE
		);

	DoMethod((Object *) MBObj->BT_Rnd,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->App,
		2,
		MUIM_CallHook, &CreateCharacterHook
		);

	DoMethod((Object *) MBObj->BT_Save,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->App,
		2,
		MUIM_CallHook, &SaveCharactersHook
		);

	DoMethod((Object *) MBObj->BT_Save,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->App,
		2,
		MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit
		);

	DoMethod((Object *) MBObj->BT_Abbort,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->App,
		2,
		MUIM_CallHook, &ReallyQuitHook
		);

	DoMethod((Object *) MBObj->MainWindow,
		MUIM_Window_SetCycleChain, MBObj->CY_CHAR,
		MBObj->SL_STR,
		MBObj->SL_MSTR,
		MBObj->SL_INT,
		MBObj->SL_MINT,
		MBObj->SL_GES,
		MBObj->SL_MGES,
		MBObj->SL_SCH,
		MBObj->SL_MSCH,
		MBObj->SL_KON,
		MBObj->SL_MKON,
		MBObj->SL_KAR,
		MBObj->SL_MKAR,
		MBObj->SL_LUC,
		MBObj->SL_MLUC,
		MBObj->SL_ANM,
		MBObj->SL_MANM,
		MBObj->SL_ATT,
		MBObj->SL_MATT,
		MBObj->SL_PAR,
		MBObj->SL_MPAR,
		MBObj->SL_SCH2,
		MBObj->SL_MSCH2,
		MBObj->SL_KRI,
		MBObj->SL_MKRI,
		MBObj->SL_FaF,
		MBObj->SL_MFaF,
		MBObj->SL_FaE,
		MBObj->SL_MFaE,
		MBObj->SL_ScO,
		MBObj->SL_MScO,
		MBObj->SL_SUC,
		MBObj->SL_MSUC,
		MBObj->SL_SRL,
		MBObj->SL_MSRL,
		MBObj->SL_MAB,
		MBObj->SL_MMAB,
		MBObj->STR_Name,
		MBObj->SL_LP,
		MBObj->SL_MLP,
		MBObj->SL_SP,
		MBObj->SL_MSP,
		MBObj->STR_GOLD,
		MBObj->STR_TP,
		MBObj->STR_SLP,
		MBObj->BT_Undo,
		MBObj->BT_Rnd,
		MBObj->BT_Save,
		MBObj->BT_Abbort,
		0
		);

	DoMethod((Object *) MBObj->BT_OKAY,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->ABOUTMUI,
		3,
		MUIM_Set, MUIA_Window_Open, FALSE
		);

	DoMethod((Object *) MBObj->ABOUTMUI,
		MUIM_Window_SetCycleChain, MBObj->BT_OKAY,
		0
		);

	DoMethod((Object *) MBObj->WIABOUTAC,
		MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		MBObj->WIABOUTAC,
		3,
		MUIM_Set, MUIA_Window_Open, FALSE
		);

	DoMethod((Object *) MBObj->BT_OKAYCC,
		MUIM_Notify, MUIA_Selected, TRUE,
		MBObj->WIABOUTAC,
		3,
		MUIM_Set, MUIA_Window_Open, FALSE
		);

	DoMethod((Object *) MBObj->WIABOUTAC,
		MUIM_Window_SetCycleChain, MBObj->BT_OKAYCC,
		0
		);

	set(MBObj->MainWindow,
		MUIA_Window_Open, TRUE
		);

	/* Test, if opening was successfully */
	get(MBObj->MainWindow, MUIA_Window_Open, &open );

	if(!open){
		MUI_RequestA( MBObj->App, NULL, 0, "Fehler!", "*Okay", "Konnte Hauptfenster nicht öffnen!\n\nAbhilfe: Wähle einen größeren (virtuellen) Bildschirm\noder warte auf die nächste Version,\ndie die vielen Schalter anders arrangiert.\n", NULL );
		DisposeApp( MBObj );
		MBObj = NULL;
	}

	return(MBObj);
}
/*///*/
/*///"void DisposeApp( struct ObjApp *)"
** Free all the ressources allocated by CreateApp().
*/
void DisposeApp(struct ObjApp * MBObj)
{
	MUI_DisposeObject( (Object *) MBObj->App);
	FreeVec(MBObj);
}
/*///*/
