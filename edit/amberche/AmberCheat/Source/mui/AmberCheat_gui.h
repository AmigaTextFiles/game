
#include <inline/exec.h>
#include <libraries/mui.h>
#include <exec/memory.h>


struct ObjApp
{
	APTR  App;
	APTR  MainWindow;
	APTR  MN_Projekt;
	APTR  CY_CHAR;
	APTR  SL_STR;
	APTR  SL_MSTR;
	APTR  SL_INT;
	APTR  SL_MINT;
	APTR  SL_GES;
	APTR  SL_MGES;
	APTR  SL_SCH;
	APTR  SL_MSCH;
	APTR  SL_KON;
	APTR  SL_MKON;
	APTR  SL_KAR;
	APTR  SL_MKAR;
	APTR  SL_LUC;
	APTR  SL_MLUC;
	APTR  SL_ANM;
	APTR  SL_MANM;
	APTR  SL_ATT;
	APTR  SL_MATT;
	APTR  SL_PAR;
	APTR  SL_MPAR;
	APTR  SL_SCH2;
	APTR  SL_MSCH2;
	APTR  SL_KRI;
	APTR  SL_MKRI;
	APTR  SL_FaF;
	APTR  SL_MFaF;
	APTR  SL_FaE;
	APTR  SL_MFaE;
	APTR  SL_ScO;
	APTR  SL_MScO;
	APTR  SL_SUC;
	APTR  SL_MSUC;
	APTR  SL_SRL;
	APTR  SL_MSRL;
	APTR  SL_MAB;
	APTR  SL_MMAB;
	APTR  STR_Name;
	APTR  SL_LP;
	APTR  SL_MLP;
	APTR  SL_SP;
	APTR  SL_MSP;
	APTR  STR_GOLD;
	APTR  STR_TP;
	APTR  STR_SLP;
	APTR  BT_Undo;
	APTR  BT_Rnd;
	APTR  BT_Save;
	APTR  BT_Abbort;
	APTR  ABOUTMUI;
	APTR  TX_label_2;
	APTR  BT_OKAY;
	APTR  WIABOUTAC;
	APTR  TX_label_2CC;
	APTR  BT_OKAYCC;
	APTR  WIINFOWIN;
	APTR  TX_INFOTXT;
	APTR  BT_INFO_OKAY;
	char *  STR_TX_label_2;
	char *  STR_TX_label_2CC;
	char *  STR_TX_INFOTXT;
	char *  CY_CHARContent[16];
	char *  STR_GR_Register[4];
	APTR aboutwin;
};


extern struct ObjApp * CreateApp(void);
extern void DisposeApp(struct ObjApp *);
