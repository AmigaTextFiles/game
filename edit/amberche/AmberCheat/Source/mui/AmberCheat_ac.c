/*
** AmberCheat_ac.c
** ---------------
**
** This source contains all relevant data and routines to
** open, change and close the ambercheat session.
*/
#include  <dos/dos.h>
#include  <libraries/mui.h>
#include  <proto/exec.h>
#include  <proto/dos.h>

#include  "AmberCheat_gui.h"
#include  "AmberCheat_req.h"
#include  "amber_defines.h"
#include  "amber_vars.h"

extern  struct ObjApp   *gui;
extern  BOOL            WriteChanges;

void GetActiveChar( UWORD );

/*///"void GetPartyLen( void )"*/
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
/*///*/
/*///"void CloseAmberSaves( BOOL write )"*/
void CloseAmberSaves( BOOL write )
{
	if ( WriteChanges )
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
	(APTR)InFile = (APTR)OutFile = (APTR)SavesFH = (APTR)Header = NULL;
	(APTR)UndoHeader = (APTR)Saves = (APTR)AmberLock = NULL;

	CurrentDir( OldDir );
}
/*///*/
/*///"BOOL OpenAmberSaves( void )"*/
BOOL OpenAmberSaves( void )
{
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
									return TRUE;
								}
								else
									requestNA( "Charakterbogen ungültig!\n", NULL);
							}
							else
								requestNA( "Kann %s nicht öffnen!\n", AmberFile);
						}
						else
							requestNA("Kann %s nicht öffnen!\n", CheatFile);
					}
					else
						requestNA("Kann %s nicht öffnen!\n", SaveFile);
				}
				else
					requestNA("Kann Speicher (%ld Bytes) für den \nUnDo-Buffer nicht allokieren!\n", (APTR)PartyLen);
			}
			else
				requestNA("Kann Speicher (%ld Bytes) für den\nCharakterbogen nicht allokieren!\n", (APTR)PartyLen);
		}
		else
			requestNA("Kann Speicher (382 Bytes) für die\nSpielstandsdatei nicht allokieren!\n", NULL);
	}
	CloseAmberSaves( FALSE );
	return( FALSE );
}
/*///*/
/*///"void GetActiveChar( UWORD num )"*/
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
/*///*/
/*///"void SetCYNames( void )"*/
void SetCYNames( void )
{
	ULONG   i, x;

	for(i = 0; i<Header->ah_NumChars; i++ )
	{
		GetActiveChar( i );
		CopyMem( (APTR)ActChar->chr_Name, (APTR)NameList[ i ], 15L );
	}

	GetActiveChar( 0 );
}
/*///*/
/*///"BOOL CreateAmberCheat( void )" */
BOOL CreateAmberCheat( void )
{
	int ret = 1;
	int i;
	ULONG len = sizeof(struct AmberHeader );

	if( OpenAmberSaves() )
	{
		SetCYNames();
		return( 1 );
	}
	return( 0 );
}
/*///*/
/*///"void DisposeAmberCheat( void )"*/
void DisposeAmberCheat( void )
{
	CloseAmberSaves( FALSE );
}
/*///*/
/*///"void UpdateContents( void )"*/
void UpdateContents( void )
{
	/* Set mui Cycle-Gadget to get this contents */
	set(gui->CY_CHAR, MUIA_Cycle_Entries, NameList );

	/* copy all vars to my global vars */
	CopyVarContents();

	/* Update mui's gadget contents */
	UpdateGadgets();

	/* set mui Undo-Gadget to disabled */
	set(gui->BT_Undo, MUIA_Disabled, TRUE );
}
/*///*/
