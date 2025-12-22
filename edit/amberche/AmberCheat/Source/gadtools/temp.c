/*************************************************************************/
/*                                                                       */
/*   Includes                                                            */
/*                                                                       */
/*************************************************************************/

#define NODEBUG
#define __NOLIBBASE__
#include  <proto/exec.h>
#include  <proto/asl.h>
#include  <proto/intuition.h>
#include  <proto/graphics.h>
#include  <proto/gadtools.h>


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

/*************************************************************************/
/*                                                                       */
/*   Prototypes                                                          */
/*                                                                       */
/*************************************************************************/

void HandleMenus( struct Window *, struct Menu *, ULONG, APTR );

void InitGadgets( struct Window *, struct Gadget **);
void GetActiveChar( UWORD num );
BOOL OpenAmberSaves( struct Window * );
void CloseAmberSaves( BOOL write );
void GetPartySize( void );
void request( struct Window *, STRPTR, APTR, ...);
ULONG ask( struct Window *win, STRPTR text, APTR arg1, ...);


/*************************************************************************/
/*                                                                       */
/*   Variables                                                           */
/*                                                                       */
/*************************************************************************/

extern struct Library *DOSBase;
extern struct Library *IntuitionBase;
extern struct Library *GfxBase;
extern struct Library *AslBase;

extern  ULONG RangeSeed;           /* Seed from amiga.lib */
extern  struct Custom custom;

struct AmberSaves *Saves      =   NULL;
struct AmberHeader *Header    =   NULL;
struct AmberHeader *UndoHeader=   NULL;
struct Character *ActChar     =   NULL;
struct Character *UndoChar    =   NULL;
BPTR              InFile      =   0;
BPTR              OutFile     =   0;
BPTR              AmberLock   =   0;
BPTR              SavesFH     =   0;
BPTR              OldDir;

char             AmberFile[512];

#ifdef DEBUG
char            * AmberDir    = "Games:role/Ambermoon/Amberfiles/";
#else
char            * AmberDir    = "/AmberFiles/";
#endif

char            * SaveDirTempl= "Save.%02ld/%s";
char            * SaveFile    = "Saves";
char            * CheatFile   = "Party_Char.amb";

char            *NameList[]   = { "Eigener Charakter",
																	"NETSRAK          ",
																	"MANDO            ",
																	"ERIK             ",
																	"CHRIS            ",
																	"MONIKA           ",
																	"TAR DER DUNKLE   ",
																	"EGIL             ",
																	"SELENA           ",
																	"NELVIN           ",
																	"SABINE           ",
																	"VALDYN           ",
																	"TARGOR           ",
																	"LEONARIA         ",
																	"GRYBAN           ",
																	NULL };

BOOL            Undo          = FALSE;
BOOL            Changes       = FALSE;
ULONG           PartyLen      = 10832;

/*************************************************************************/
/*                                                                       */
/*   Functions                                                           */
/*                                                                       */
/*************************************************************************/

/* Functions for AmberCheat */


void request( struct Window *win, STRPTR text, APTR arg1, ... )
{
	SleepWindow( win );
	struct EasyStruct es = { sizeof (struct EasyStruct), 0, "AmberCheat:", NULL, "OK" };
	es.es_TextFormat = text;
	EasyRequestArgs( win, &es, NULL, &arg1 );
	WakenWindow( win );
}

ULONG ask( struct Window *win, STRPTR text, APTR arg1, ...)
{
	ULONG rt=0;

	SleepWindow( win );
	struct  EasyStruct es = { sizeof (struct EasyStruct), 0, "AmberCheat - Frage!", NULL, "JA|NEIN" };
	es.es_TextFormat = text;
	rt = EasyRequestArgs( win, &es, NULL, &arg1 );
	WakenWindow( win );

	return ( rt );
}

void GetPartyLen( void )
{
	struct FileInfoBlock  * fib;
	BPTR                    lock;

	if ( lock = Lock( CheatFile, ACCESS_READ ) )
	{
		if ( fib = AllocDosObject( DOS_FIB, TAG_END ) )
		{
			if ( Examine( lock, fib ) )
			{
				PartyLen = fib->fib_Size;
			}
			FreeDosObject( DOS_FIB, fib );
		}
		UnLock( lock );
	}
}

void CloseAmberSaves( BOOL write )
{
	if ( write )
	{
		/* Schreibe die veränderten Daten */
		Write( InFile, Header, PartyLen );
		Write( OutFile, Header, PartyLen );
	}

	if ( InFile )     Close( InFile );
	if ( OutFile )    Close( OutFile );
	if ( SavesFH )    Close( SavesFH );
	if ( Header )     FreeVec( Header );
	if ( UndoHeader ) FreeVec( UndoHeader );
	if ( Saves )      FreeVec( Saves );
	if ( AmberLock )  UnLock( AmberLock );
	CurrentDir( OldDir );
}

BOOL OpenAmberSaves( struct Window *win )
{
	SleepWindow( win );
	/* Versuche ins Ambermoon verzeichnis zu springen */
	if ( AmberLock = Lock( AmberDir, ACCESS_READ ) )
	{
		/* Wechsle nach AmberMoon/ */
		OldDir = CurrentDir( AmberLock );

		/* Hole die Länge der Charakterbögen */
		GetPartyLen();

		/* Versuche speicher für "Saves"-File zu allokieren */
		if ( Saves = AllocVec( SAVES_LEN, MEMF_ANY|MEMF_CLEAR ) )
		{
			/* Versuche speicher für Spielstand zu allokieren */
			if ( Header = AllocVec( PartyLen, MEMF_ANY|MEMF_CLEAR ) )
			{
				if ( UndoHeader = AllocVec( PartyLen, MEMF_ANY|MEMF_CLEAR ) )
				{
					/* Versuche "Saves" zu öffnen */
					if ( SavesFH = Open( SaveFile, MODE_OLDFILE ) )
					{
						/* Lese "Saves" */
						Read( SavesFH, Saves, SAVES_LEN );

						/* Hole Spielstandsverzeichnis "Save.xx" */
						sprintf( AmberFile, SaveDirTempl, Saves->as_Actual, CheatFile );

						/* Lade nun In-/ und OutFile */

						if ( InFile = Open( CheatFile, MODE_READWRITE ) )
						{
							if ( OutFile = Open( AmberFile, MODE_READWRITE ) )
							{
								Read( InFile, Header, PartyLen );
								/* Setze Dateizeiger auf Anfang zurück */
								Seek( InFile, 0, OFFSET_BEGINNING );

								/* Kopiere den Header nun auf das UNDO char */
								CopyMem( (APTR)Header, (APTR)UndoHeader, PartyLen );

								/* Prüfe, ob Charakterbogen gültig */
								if ( Header->ah_MagicCookie == MAGIC_COOKIE )
								{
									GetActiveChar( 0 );
									WakenWindow( win );
									return TRUE;
								}
								else
									request( win, "Charakterbogen ungültig!", NULL );
							}
							else
								request( win, "Kann %s nicht öffnen!", AmberFile);
						}
						else
							request(win, "Kann %s nicht öffnen!", CheatFile);
					}
					else
						request(win, "Kann %s nicht öffnen!", SaveFile);
				}
				else
					request(win, "Kann Speicher (%ld Bytes) für den \nUnDo-Buffer nicht allokieren!", (APTR)PartyLen);
			}
			else
				request(win, "Kann Speicher (%ld Bytes) für den\nCharakterbogen nicht allokieren!", (APTR)PartyLen);
		}
		else
			request(win, "Kann Speicher (382 Bytes) für die\nSpielstandsdatei nicht allokieren!", NULL);
	}
	CloseAmberSaves( FALSE );
	WakenWindow( win );
	return( FALSE );
}

void GetActiveChar( UWORD num )
{
	register ULONG  x;
	register ULONG  len = sizeof( struct AmberHeader);

	if ( num < (UWORD)Header->ah_NumChars )
	{
		/*
		** Der eigene Charakter steht gleich nach dem Header.
		** Die restlichen haben eine unterschiedliche Länge,
		** die jedoch im Header angegeben wird.
		** Um nun CharNum 3 zu bekommen, müssen sämtliche
		** Längen CharNum-1 zum Header addiert werden.
		*/

		for( x=0; x < num; x++ )
			len += Header->ah_Lens[x];

		ActChar = (struct Character *) ( (ULONG) Header + len) ;
		UndoChar = (struct Character *) ( (ULONG) UndoHeader + len );
	}
}


void SetCYNames(struct Window *win, struct Gadget *Gad )
{
	ULONG   i, x;

	for(i = 0; i<Header->ah_NumChars; i++ )
	{
		GetActiveChar( i );
		CopyMem( (APTR)ActChar->chr_Name, (APTR)NameList[ i ], 15L );
	}

	GetActiveChar( 0 );

	GT_SetGadgetAttrs(Gad, win, NULL, GTCY_Labels, NameList, TAG_DONE );
}


/*
** Setzt die Werte der Gadgets wie aus dem geladenen Charakter
*/
void InitGadgets( struct Window *win, struct Gadget *wingads[] )
{
	/* Attribute */
	GT_SetGadgetAttrs( wingads[INID_STR], win, NULL, GTIN_Number, ActChar->chr_Str, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSTR], win, NULL, GTIN_Number, ActChar->chr_MStr, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_INT], win, NULL, GTIN_Number, ActChar->chr_Int, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MINT], win, NULL, GTIN_Number, ActChar->chr_MInt, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_GES], win, NULL, GTIN_Number, ActChar->chr_Ges, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MGES], win, NULL, GTIN_Number, ActChar->chr_MGes, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SCH], win, NULL, GTIN_Number, ActChar->chr_Sch, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSCH], win, NULL, GTIN_Number, ActChar->chr_MSch, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_KON], win, NULL, GTIN_Number, ActChar->chr_Kon, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MKON], win, NULL, GTIN_Number, ActChar->chr_MKon, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_KAR], win, NULL, GTIN_Number, ActChar->chr_Kar, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MKAR], win, NULL, GTIN_Number, ActChar->chr_MKar, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_GLU], win, NULL, GTIN_Number, ActChar->chr_Glu, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MGLU], win, NULL, GTIN_Number, ActChar->chr_MGlu, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_ANM], win, NULL, GTIN_Number, ActChar->chr_Anm, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MANM], win, NULL, GTIN_Number, ActChar->chr_MAnm, TAG_END );

	/* Fähigkeiten */
	GT_SetGadgetAttrs( wingads[INID_ATT], win, NULL, GTIN_Number, ActChar->chr_Att, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MATT], win, NULL, GTIN_Number, ActChar->chr_MAtt, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_PAR], win, NULL, GTIN_Number, ActChar->chr_Par, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MPAR], win, NULL, GTIN_Number, ActChar->chr_MPar, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SCHW], win, NULL, GTIN_Number, ActChar->chr_Sch2, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSCHW], win, NULL, GTIN_Number, ActChar->chr_MSch2, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_KRI], win, NULL, GTIN_Number, ActChar->chr_Kri, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MKRI], win, NULL, GTIN_Number, ActChar->chr_MKri, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_FAF], win, NULL, GTIN_Number, ActChar->chr_Faf, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MFAF], win, NULL, GTIN_Number, ActChar->chr_MFaf, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_FAE], win, NULL, GTIN_Number, ActChar->chr_Fae, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MFAE], win, NULL, GTIN_Number, ActChar->chr_MFae, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SCO], win, NULL, GTIN_Number, ActChar->chr_Sco, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSCO], win, NULL, GTIN_Number, ActChar->chr_MSco, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SUC], win, NULL, GTIN_Number, ActChar->chr_Suc, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSUC], win, NULL, GTIN_Number, ActChar->chr_MSuc, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SRL], win, NULL, GTIN_Number, ActChar->chr_Srl, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSRL], win, NULL, GTIN_Number, ActChar->chr_MSrl, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MAB], win, NULL, GTIN_Number, ActChar->chr_Mab, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MMAB], win, NULL, GTIN_Number, ActChar->chr_MMab, TAG_END );

	/* Anderes */
	GT_SetGadgetAttrs( wingads[INID_LP], win, NULL, GTIN_Number, ActChar->chr_LP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MLP], win, NULL, GTIN_Number, ActChar->chr_MLP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SP], win, NULL, GTIN_Number, ActChar->chr_SP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_MSP], win, NULL, GTIN_Number, ActChar->chr_MSP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_TP], win, NULL, GTIN_Number, ActChar->chr_TP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_SLP], win, NULL, GTIN_Number, ActChar->chr_SLP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_EP], win, NULL, GTIN_Number, ActChar->chr_EP, TAG_END );
	GT_SetGadgetAttrs( wingads[INID_GOLD], win, NULL, GTIN_Number, ActChar->chr_Gold, TAG_END );

}


void UserSetupAmberCheat(struct Window *win,struct Gadget *wingads[],APTR userdata)
{
	ULONG len=sizeof(struct AmberHeader);
	int i;

	if ( OpenAmberSaves( win ) )
	{
		SetCYNames(win, wingads[CYID_ACTCHAR]);
		GT_SetGadgetAttrs( wingads[BTID_ORIGINAL], win, NULL, GA_Disabled, TRUE, TAG_END );
		GT_SetGadgetAttrs( wingads[INID_EP], win, NULL, GA_Disabled, TRUE, TAG_END );

		InitGadgets( win, wingads );
	}
	else
	{
		request(win, "Aktueller Spielstand konnte nicht\nermittelt werden.", NULL);
		Signal( FindTask( NULL ), SIGBREAKF_CTRL_C );
	}
}

void UserRefreshAmberCheat(struct Window *win,struct Gadget *wingads[],APTR userdata)
{
}

void BTSave(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
	SleepWindow( win );
	CloseAmberSaves( TRUE );
	WakenWindow( win );
	Signal( FindTask( NULL ), SIGBREAKF_CTRL_C );
}

void BTAbbruch(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
BOOL  really=FALSE;

	if ( Changes )
		really = ask( win, "Es wurden Veränderungen am Projekt vorgenommen.\nWollen Sie wirklich beenden?", NULL );
	else
		really = TRUE;

	if ( really )
	{
		CloseAmberSaves( FALSE );
		Signal( FindTask( NULL ), SIGBREAKF_CTRL_C );
	}
}

void ChangeCharacter(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
	SleepWindow( win );

	Undo = FALSE;
	GT_SetGadgetAttrs( wingads[BTID_ORIGINAL], win, NULL, GA_Disabled, TRUE, TAG_END );

	GetActiveChar( messagecode );
	InitGadgets( win, wingads );
	WakenWindow( win );
}

void INClicked(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
	ULONG   value=0;

	GT_GetGadgetAttrs( wingads[gadgetid], win, NULL, GTIN_Number, &value, TAG_END );

	if (!Undo)
	{
		Undo = TRUE;
		GT_SetGadgetAttrs( wingads[BTID_ORIGINAL], win, NULL, GA_Disabled, FALSE, TAG_END );
	}

	switch( gadgetid )
	{
		case  INID_STR:
			ActChar->chr_Str = value;
			break;
		case  INID_MSTR:
			ActChar->chr_MStr = value;
			break;
		case  INID_INT:
			ActChar->chr_Int = value;
			break;
		case  INID_MINT:
			ActChar->chr_MInt = value;
			break;
		case  INID_GES:
			ActChar->chr_Ges = value;
			break;
		case  INID_MGES:
			ActChar->chr_MGes = value;
			break;
		case  INID_SCH:
			ActChar->chr_Sch = value;
			break;
		case  INID_MSCH:
			ActChar->chr_MSch = value;
			break;
		case  INID_KON:
			ActChar->chr_Kon = value;
			break;
		case  INID_MKON:
			ActChar->chr_MKon = value;
			break;
		case  INID_KAR:
			ActChar->chr_Kar = value;
			break;
		case  INID_MKAR:
			ActChar->chr_MKar = value;
			break;
		case  INID_GLU:
			ActChar->chr_Glu = value;
			break;
		case  INID_MGLU:
			ActChar->chr_MGlu = value;
			break;
		case  INID_ANM:
			ActChar->chr_Anm = value;
			break;
		case  INID_MANM:
			ActChar->chr_MAnm = value;
			break;

		case  INID_ATT:
			ActChar->chr_Att = value;
			break;
		case  INID_MATT:
			ActChar->chr_MAtt = value;
			break;
		case  INID_PAR:
			ActChar->chr_Par = value;
			break;
		case  INID_MPAR:
			ActChar->chr_MPar = value;
			break;
		case  INID_SCHW:
			ActChar->chr_Sch2 = value;
			break;
		case  INID_MSCHW:
			ActChar->chr_MSch2 = value;
			break;
		case  INID_KRI:
			ActChar->chr_Kri = value;
			break;
		case  INID_MKRI:
			ActChar->chr_MKri = value;
			break;
		case  INID_FAF:
			ActChar->chr_Faf = value;
			break;
		case  INID_MFAF:
			ActChar->chr_MFaf = value;
			break;
		case  INID_FAE:
			ActChar->chr_Fae = value;
			break;
		case  INID_MFAE:
			ActChar->chr_MFae = value;
			break;
		case  INID_SCO:
			ActChar->chr_Sco = value;
			break;
		case  INID_MSCO:
			ActChar->chr_MSco = value;
			break;
		case  INID_SUC:
			ActChar->chr_Suc = value;
			break;
		case  INID_MSUC:
			ActChar->chr_MSuc = value;
			break;
		case  INID_SRL:
			ActChar->chr_Srl = value;
			break;
		case  INID_MSRL:
			ActChar->chr_MSrl = value;
			break;
		case  INID_MAB:
			ActChar->chr_Mab = value;
			break;
		case  INID_MMAB:
			ActChar->chr_MMab = value;
			break;

		case  INID_LP:
			ActChar->chr_LP = value;
			break;
		case  INID_MLP:
			ActChar->chr_MLP = value;
			break;
		case  INID_SP:
			ActChar->chr_SP = value;
			break;
		case  INID_MSP:
			ActChar->chr_MSP = value;
			break;
		case  INID_TP:
			ActChar->chr_TP = value;
			break;
		case  INID_SLP:
			ActChar->chr_SLP = value;
			break;
		case  INID_GOLD:
			ActChar->chr_Gold = value;
			break;
	}
	Changes = TRUE;
}

void BTZufall(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
	int     i;
	UWORD   seed;
	UWORD   *Gen=(UWORD *)((ULONG)ActChar + 38);

	SleepWindow( win );

	/* Kalkuliere einen BasisWert für die Zufallszahlen */

	seed = FastRand( custom.vhposr & 0x3ffe );
	RangeSeed = seed;

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

	InitGadgets( win, wingads );
	Undo = TRUE;
	Changes = TRUE;
	GT_SetGadgetAttrs( wingads[BTID_ORIGINAL], win, NULL, GA_Disabled, FALSE, TAG_END );

	WakenWindow( win );
}

void BTOriginal(struct Window *win,struct Gadget *wingads[],ULONG gadgetid,ULONG messagecode,APTR userdata)
{
	/* Setze Attribute zurück auf Originalzustand */

	if (Undo)
	{
		SleepWindow( win );
		Undo = FALSE;
		GT_SetGadgetAttrs( wingads[BTID_ORIGINAL], win, NULL, GA_Disabled, TRUE, TAG_END );
		CopyMem( (APTR) UndoChar, (APTR) ActChar, sizeof( struct Character ) );
		InitGadgets( win, wingads );
		WakenWindow( win );
	}
}

void HandleMenus( struct Window *win, struct Menu *menu, ULONG menNumber, APTR userdata)
{
	struct MenuItem *item;
	UWORD menuNum, itemNum, subNum;

	if ( menNumber != MENUNULL )
	{
		item = ItemAddress( menu, menNumber );

		menuNum = MENUNUM( menNumber );
		itemNum = ITEMNUM( menNumber );
		subNum = SUBNUM( menNumber );

		switch( menuNum )
		{
			case MEN_PROJEKT:

				switch( itemNum )
				{
					case MENI_LOADORIG:
						break;
					case MENI_SAVECHAR:
						break;
					case MENI_SAVEPRESET:
						break;
					case MENI_ABOUT:
						request(win, "AmberCheat V1.0g\nCopyright (c)1996 by Wanja Pernath\n\nAmberCheat ist ein Programm mit dem man auf einfache\nArt und Weise eigene Charaktere für Ambermoon®\nentwerfen oder bestehende verändern kann.\n\nAmberCheat ist Public Domain.\nDer Autor behält alle Rechte über das Programm\nund die Quelltexte.\nAmberCheat darf jedoch frei verteilt werden.", NULL );
						break;
					case MENI_HELP:
						request( win, "Informationen:\nAktueller SpeicherSlot: %ld\nAktueller Spielstand: %s\nAktuelle Stufe: %ld",
										 Saves->as_Actual,
										 (STRPTR *)Saves->as_Names[ Saves->as_Actual - 1],
										 ActChar->chr_Stufe);

						break;
					case MENI_QUIT:
						BTAbbruch(win, NULL, 0, 0, NULL);
						break;
				}
				break;
		}
	}
}
