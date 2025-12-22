#include  <exec/types.h>
#include  <dos/dos.h>
#include  <libraries/mui.h>
#include  <proto/exec.h>
#include  <proto/dos.h>

#include  "amber_defines.h"
#include  "ambercheat_gui.h"
#include  "ambercheat_req.h"

#ifdef    NO_INLINE_STDARG
#undef    NO_INLINE_STDARG
#endif

/*///"global vars "*/
struct Library  *MUIMasterBase    =   NULL;
struct ObjApp   *gui              =   NULL;

struct AmberSaves   *Saves        =   NULL;
struct AmberHeader  *Header       =   NULL;
struct AmberHeader  *UndoHeader   =   NULL;
struct Character    *ActChar      =   NULL;
struct Character    *UndoChar     =   NULL;
BPTR                InFile        =   0;
BPTR                OutFile       =   0;
BPTR                AmberLock     =   0;
BPTR                SavesFH       =   0;
BPTR                OldDir;

char                AmberFile[512];

#ifdef DEBUG
char            * AmberDir    = "Games:role/Ambermoon/Amberfiles/";
#else
char            * AmberDir    = "/AmberFiles/";
#endif

char            * SaveDirTempl= "Save.%02ld/%s";
char            * SaveFile    = "Saves";
char            * CheatFile   = "Party_Char.amb";

BOOL            Undo          = FALSE;
BOOL            Changes       = FALSE;
ULONG           PartyLen      = 10832;

char            * BackupFile  = "backup.amb";

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

char            *oNameList[]  = { "Eigener Charakter",
																	"NETSRAK",
																	"MANDO",
																	"ERIK",
																	"CHRIS",
																	"MONIKA",
																	"TAR DER DUNKLE",
																	"EGIL",
																	"SELENA",
																	"NELVIN",
																	"SABINE",
																	"VALDYN",
																	"TARGOR",
																	"LEONARIA",
																	"GRYBAN",
																	NULL };

/*///*/
/*///"void Backup(void )"
** Backup original file, if not allready exists
*/
#ifdef 0
void Backup(void)
{
	BPTR  in, out;
	long  len;

	/* try to open backuped file. */
	if( !(in = Open( BackupFile, MODE_OLDFILE ) ) )
	{
		/* file does not exists, so copy it. */
		in = Open( BackupFile, MODE_NEWFILE );
		out = Open(
}
#endif
/*///*/
/*///"int main(void )"
** The simple, simple, simple main function for any MUI-Application */
int main( void )
{
	ULONG           sigs;

	/* Try to open muimaster.lib */
	if(!( MUIMasterBase = OpenLibrary( MUIMASTER_NAME, MUIMASTER_VMIN ) ) ){
		puts("Could not open muimaster.library V11++\n");
		return(20);
	}
	#ifdef 0
	/* Backup original file if not allready exists */
	Backup();
	#endif

	/* Open all of the needed things to start AmberCheat */
	if(CreateAmberCheat() )
	{
		/* Try to create application */
		if( gui = CreateApp() )
		{
			/* Update the contents of the gadgets */
			UpdateContents();

			/* Do this loop until user pressed something which indicated an MUIV_Application_quit */
			while( DoMethod( (Object *)gui->App, MUIM_Application_NewInput, &sigs ) != MUIV_Application_ReturnID_Quit )
			{
				/* If there are any signals... */
				if( sigs ){

					/* ...then wait until the next message received */
					sigs = Wait(sigs | SIGBREAKF_CTRL_C );
					if( sigs & SIGBREAKF_CTRL_C ) break;
				}

				/* Test, if user tries to open AC twice */
			}

			/* Dispose our application */
			DisposeApp( gui );
		}
		DisposeAmberCheat();
	}
	/* And close the library */
	CloseLibrary( MUIMasterBase );
}
/*///*/
