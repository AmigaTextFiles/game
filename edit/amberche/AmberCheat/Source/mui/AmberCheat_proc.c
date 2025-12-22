#include  <libraries/mui.h>

#include  <proto/muimaster.h>
#include  <proto/exec.h>

#include  "AmberCheat_gui.h"
#include  "AmberCheat_req.h"
#include  "amber_defines.h"
#include  "amber_vars.h"

/* These variables gets automatical updated by MUI */
ULONG slp, tp, gold, str, mstr, Int, mint, ges, mges, sch, msch;
ULONG kon, mkon, kar, mkar, glu, mglu, anm, manm;
ULONG att, matt, par, mpar, sch2, msch2, kri, mkri, faf, mfaf;
ULONG fae, mfae, sco, msco, suc, msuc, srl, msrl, mab, mmab;
ULONG lp, mlp, sp, msp;
char  name[16];
BOOL  WriteChanges = 0;

const char  *Classes[] = {  "Abenteuerer",
											"Schwarzmagier",
											"Dieb",
											"Krieger",
											"Alchemist",
											"Heiler",
											"Schwarzmagier",
											"Krieger",
											"Dieb",
											"Schwarzmagier",
											"Heiler",
											"Ranger",
											"Magier",
											"Mystiker",
											"Paladin"
										};

extern  struct ObjApp *gui;
#define getnum( o, n )  get(o, MUIA_Numeric_Value, &n)

/*///"Obsolete ChangeRegPage()"*/
void ChangeRegPage( Object *o )
{
}
/*///*/
/*///"CopyContens2Var( void )"*/
void CopyContents2Var( void )
{
	ActChar->chr_SLP  = slp;
	ActChar->chr_TP   = tp;
	ActChar->chr_Gold = gold;
	ActChar->chr_LP   = lp;
	ActChar->chr_MLP  = mlp;
	ActChar->chr_SP   = sp;
	ActChar->chr_MSP  = msp;
	strncpy( ActChar->chr_Name, name, 16 );

	ActChar->chr_Str  = str;
	ActChar->chr_MStr = mstr;
	ActChar->chr_Int  = Int;
	ActChar->chr_MInt = mint;
	ActChar->chr_Ges  = ges;
	ActChar->chr_MGes = mges;
	ActChar->chr_Sch  = sch;
	ActChar->chr_MSch = msch;
	ActChar->chr_Kon  = kon;
	ActChar->chr_MKon = mkon;
	ActChar->chr_Kar  = kar;
	ActChar->chr_MKar = mkar;
	ActChar->chr_Glu  = glu;
	ActChar->chr_MGlu = mglu;
	ActChar->chr_Anm  = anm;
	ActChar->chr_MAnm = manm;

	ActChar->chr_Att  = att;
	ActChar->chr_MAtt = matt;
	ActChar->chr_Par  = par;
	ActChar->chr_MPar = mpar;
	ActChar->chr_Sch2 = sch2;
	ActChar->chr_MSch2= msch2;
	ActChar->chr_Kri  = kri;
	ActChar->chr_MKri = mkri;
	ActChar->chr_Faf  = faf;
	ActChar->chr_MFaf = mfaf;
	ActChar->chr_Fae  = fae;
	ActChar->chr_MFae = mfae;
	ActChar->chr_Sco  = sco;
	ActChar->chr_MSco = msco;
	ActChar->chr_Suc  = suc;
	ActChar->chr_MSuc = msuc;
	ActChar->chr_Srl  = srl;
	ActChar->chr_MSrl = msrl;
	ActChar->chr_Mab  = mab;
	ActChar->chr_MMab = mmab;
}
/*///*/
/*///"CopyVarContents( void )"
** This function copies the global Saves Vars to those updated by mui */
void CopyVarContents( void )
{
	slp   = ActChar->chr_SLP;
	tp    = ActChar->chr_TP;
	gold  = ActChar->chr_Gold;
	lp    = ActChar->chr_LP;
	mlp   = ActChar->chr_MLP;
	sp    = ActChar->chr_SP;
	msp   = ActChar->chr_MSP;
	strncpy( name, ActChar->chr_Name, 16 );

	str   = ActChar->chr_Str;
	mstr  = ActChar->chr_MStr;
	Int   = ActChar->chr_Int;
	mint  = ActChar->chr_MInt;
	ges   = ActChar->chr_Ges;
	mges  = ActChar->chr_MGes;
	sch   = ActChar->chr_Sch;
	msch  = ActChar->chr_MSch;
	kon   = ActChar->chr_Kon;
	mkon  = ActChar->chr_MKon;
	kar   = ActChar->chr_Kar;
	mkar  = ActChar->chr_MKar;
	glu   = ActChar->chr_Glu;
	mglu  = ActChar->chr_MGlu;
	anm   = ActChar->chr_Anm;
	manm  = ActChar->chr_MAnm;

	att   = ActChar->chr_Att;
	matt  = ActChar->chr_MAtt;
	par   = ActChar->chr_Par;
	mpar  = ActChar->chr_MPar;
	sch2  = ActChar->chr_Sch2;
	msch2 = ActChar->chr_MSch2;
	kri   = ActChar->chr_Kri;
	mkri  = ActChar->chr_MKri;
	faf   = ActChar->chr_Faf;
	mfaf  = ActChar->chr_MFaf;
	fae   = ActChar->chr_Fae;
	mfae  = ActChar->chr_MFae;
	sco   = ActChar->chr_Sco;
	msco  = ActChar->chr_MSco;
	suc   = ActChar->chr_Suc;
	msuc  = ActChar->chr_MSuc;
	srl   = ActChar->chr_Srl;
	msrl  = ActChar->chr_MSrl;
	mab   = ActChar->chr_Mab;
	mmab  = ActChar->chr_MMab;
}
/*///*/
/*///"UpdateGadgets( void )"*/
void UpdateGadgets( void )
{
	char  num[10];
	char *form = "%ld";
	int  i;

	setslider( gui->SL_STR, str);
	setslider( gui->SL_MSTR, mstr);
	setslider( gui->SL_INT, Int);
	setslider( gui->SL_MINT, mint);
	setslider( gui->SL_GES, ges);
	setslider( gui->SL_MGES, mges);
	setslider( gui->SL_SCH, sch);
	setslider( gui->SL_MSCH, msch);
	setslider( gui->SL_KON, kon);
	setslider( gui->SL_MKON, mkon);
	setslider( gui->SL_KAR, kar );
	setslider(gui->SL_MKAR, mkar);
	setslider(gui->SL_LUC, glu);
	setslider(gui->SL_MLUC, mglu);
	setslider(gui->SL_ANM, anm);
	setslider(gui->SL_MANM, manm);

	setslider(gui->SL_ATT, att);
	setslider(gui->SL_MATT, matt);
	setslider(gui->SL_PAR, par);
	setslider(gui->SL_MPAR, mpar);
	setslider(gui->SL_SCH2, sch2);
	setslider(gui->SL_MSCH2, msch2);
	setslider(gui->SL_KRI, kri);
	setslider(gui->SL_MKRI, mkri);
	setslider(gui->SL_FaF, faf );
	setslider(gui->SL_MFaF, mfaf);
	setslider(gui->SL_FaE, fae );
	setslider(gui->SL_MFaE, mfae);
	setslider(gui->SL_ScO, sco);
	setslider(gui->SL_MScO, msco);
	setslider(gui->SL_SUC, suc);
	setslider(gui->SL_MSUC, msuc);
	setslider(gui->SL_SRL, srl);
	setslider(gui->SL_MSRL, msrl);
	setslider(gui->SL_MAB, mab);
	setslider(gui->SL_MMAB, mmab);
	setslider(gui->SL_LP, lp);
	setslider(gui->SL_MLP, mlp);
	setslider(gui->SL_SP, sp);
	setslider(gui->SL_MSP, msp);

	sprintf(num, form, gold );
	setstring(gui->STR_GOLD, num);
	sprintf(num, form, tp);
	setstring(gui->STR_TP, num);
	sprintf(num, form, slp);
	setstring(gui->STR_SLP, num);
	setstring(gui->STR_Name, name);
}
/*///*/
/*///"DoUndo( o )"*/
void DoUndo( Object *o )
{
	CopyMem( (APTR)UndoChar, (APTR)ActChar, sizeof(struct Character) );
	CopyVarContents();
	UpdateGadgets();
}
/*///*/
/*///"CreateChar(o)"*/
void CreateCharacter( Object *o )
{
	int     i;
	UWORD   seed;
	UWORD   *Gen=(UWORD *)((ULONG)ActChar + 38);

	for (i=0; i<16; i+=2){
		if ( Gen[i+1] > 0 )
			Gen[ i ] = RangeRand( Gen[ i+1 ] );
		else
			Gen[ i ] = 0;
		(ULONG)Gen += 4;
	}

	(UWORD *)Gen = (UWORD *)((ULONG)ActChar + 118);  /* Offset = 80 */

	for (i=0; i<20; i+=2){
		if ( Gen[i+1] > 0 )
			Gen[ i ] = RangeRand( Gen[ i+1 ] );
		else
			Gen[ i ] = 0;
		(ULONG)Gen += 4;
	}

	CopyVarContents();
	UpdateGadgets();
	set(gui->BT_Undo, MUIA_Disabled, FALSE);
}
/*///*/
/*///"SaveChars(o)"*/
void SaveCharacters( Object *o)
{
	CopyContents2Var();
	WriteChanges = 1;
}
/*///*/
/*///"ReallyQuit(o)"*/
void ReallyQuit( Object *o )
{
	if( request( "\ec\e8Scherzfrage:\en\e2\n\nWillst Du wirklich schon aufhören?\nEs fängt doch gerade erst an,\nSpaß zu machen!", NULL ) ){
		Signal( FindTask(NULL), SIGBREAKF_CTRL_C );
	}
}
/*///*/
/*///"void InfoReq( Object *o )"*/
void InfoReq( Object *o )
{
	int i;
	/* Then get new active character */
	get( gui->CY_CHAR, MUIA_Cycle_Active, &i );

	requestNA( "\ec\e8\euAllgemeine Information:\el\en\e2\n\n"
						 "Aktueller Spielstand: %s\n"
						 "Speicherslot: %ld\n"
						 "\ec---------------------------\el\n\n"
						 "\ec\e8\euCharakter Information:\ec\e2\en\n\n"
						 "Slot Name: %s\n"
						 "Slot Nummer: %ld\n"
						 "Neuer Name: %s\n"
						 "Klasse: %s\n"
						 "Stufe: %ld\n",

						 (STRPTR *)Saves->as_Names[ Saves->as_Actual - 1 ],
						 (APTR)((ULONG)Saves->as_Actual),
						 oNameList[ i ],
						 (APTR)i,
						 &ActChar->chr_Name,
						 Classes[ i ],
						 ActChar->chr_Stufe
					 );

}
/*///*/
/*///"ChangeChar(o)"*/
void ChangeCharacter( Object *o )
{
	int i;

	/* First update the charlist */
	CopyContents2Var();

	/* Then get new active character */
	get( gui->CY_CHAR, MUIA_Cycle_Active, &i );
	GetActiveChar( i );

	/* Then copy the charlist to global variables */
	CopyVarContents();

	/* and update the gadgets */
	UpdateGadgets();
}
/*///*/
