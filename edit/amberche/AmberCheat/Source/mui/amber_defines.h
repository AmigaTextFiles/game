#ifndef   AMBER_DEFINES_H
#define   AMBER_DEFINES_H
#ifndef   EXEC_TYPES_H
#include  <exec/types.h>
#endif
/*************************************************************************/
/*                                                                       */
/*   Structures                                                          */
/*                                                                       */
/*************************************************************************/

struct  AmberSaves
{
	UWORD   as_Actual;
	char    as_Names[10][39];
};

struct  AmberHeader
{
	ULONG   ah_MagicCookie;
	UWORD   ah_NumChars;
	ULONG   ah_Lens[15];
	ULONG   ah_Fill00;
};


struct  Character
{
	UBYTE   chr_Type, chr_Stufe;
	UWORD   chr_Unknown01[7];
	UWORD   chr_SLP;
	UWORD   chr_TP;
	UWORD     chr_Gold;
	ULONG   chr_Fill00[4];
	UWORD     chr_Str, chr_MStr;
	ULONG    chr_Fill01;
	UWORD     chr_Int, chr_MInt;
	ULONG    chr_Fill02;
	UWORD     chr_Ges, chr_MGes;
	ULONG    chr_Fill03;
	UWORD     chr_Sch, chr_MSch;
	ULONG    chr_Fill04;
	UWORD     chr_Kon, chr_MKon;
	ULONG    chr_Fill05;
	UWORD     chr_Kar, chr_MKar;
	ULONG    chr_Fill06;
	UWORD     chr_Glu, chr_MGlu;
	ULONG    chr_Fill07;
	UWORD     chr_Anm, chr_MAnm;
	ULONG    chr_Fill08;
	UWORD     chr_Age, chr_MAge;
	ULONG    chr_Fill09[3];
	UWORD     chr_Att, chr_MAtt;
	ULONG    chr_Fill10;
	UWORD     chr_Par, chr_MPar;
	ULONG    chr_Fill11;
	UWORD     chr_Sch2, chr_MSch2;
	ULONG    chr_Fill12;
	UWORD     chr_Kri, chr_MKri;
	ULONG    chr_Fill13;
	UWORD     chr_Faf, chr_MFaf;
	ULONG    chr_Fill14;
	UWORD     chr_Fae, chr_MFae;
	ULONG    chr_Fill15;
	UWORD     chr_Sco, chr_MSco;
	ULONG    chr_Fill16;
	UWORD     chr_Suc, chr_MSuc;
	ULONG    chr_Fill17;
	UWORD     chr_Srl, chr_MSrl;
	ULONG    chr_Fill18;
	UWORD     chr_Mab, chr_MMab;
	ULONG    chr_Fill19;
	UWORD     chr_LP, chr_MLP;
	UWORD    chr_Fill20;
	UWORD     chr_SP, chr_MSP;
	UWORD     chr_Fill21[10];
	UWORD     chr_Fill22[3];
	ULONG    chr_EP;
	ULONG    chr_Fill23[8];
	char    chr_Name[16];
};

/* Some Defines */

#define MAGIC_COOKIE  0x414d4252      /* "AMBR" */
#define SAVES_LEN     382
#endif
