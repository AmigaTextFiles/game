#define __NOLIBBASE__

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/iffparse.h>
//#include <libraries/iffparse.h>
#include <string.h>
#include <stdio.h>
#include <string.h>
#include "catalog.h"

struct Library
 *IFFParseBase;

#if defined(__amigaos4__)

struct IFFParseIFace *IIFFParse	= NULL;

#define GETINTERFACE(iface, base)	(iface = (APTR)GetInterface((struct Library *)(base), "main", 1L, NULL))
#define DROPINTERFACE(iface)			(DropInterface((struct Interface *)iface), iface = NULL)

#else

void
	*IFFParse 		= NULL;

#define GETINTERFACE(iface, base)	TRUE
#define DROPINTERFACE(iface)

#endif

static struct AppString
{
	ULONG id;
	char *str1;
} app[] =
{
	MSG_MENU_PROJECT,
	"Projekt",

	MSG_MENU_NEW,
	"N\1Neues Spiel",

	MSG_MENU_OPENEPD,
	"Öffne EPD ...",

	MSG_MENU_OPENPGN,
	"Öffne PGN ...",

	MSG_MENU_SAVEEPD,
	"Speichern als EPD ...",

	MSG_MENU_SAVEPGN,
	"Speichern als PGN ...",

	MSG_MENU_QUIT,
	"Q\1Beenden",

	MSG_MENU_GAME,
	"Spiel",

	MSG_MENU_AUTOPLAY,
	"A\1Automatisches Spiel",

	MSG_MENU_SUPERVISOR,
	"Ü\1SpielÜberwachung",

	MSG_MENU_SWAP,
	"V\1Vertausche Seiten",

	MSG_MENU_SWITCH,
	"Wechsle Seite",

	MSG_MENU_UNDO,
	"H\1Halbzug zurücknehmen",

	MSG_MENU_REMOVE,
	"Z\1Zug zurücknehmen",

	MSG_MENU_BOOK,
	"Buch",

	MSG_MENU_BOOKADD,
	"Züge hinzufügen ...",

	MSG_MENU_BOOKOFF,
	"Aus",

	MSG_MENU_BOOKON,
	"An",

	MSG_MENU_BOOKBEST,
	"Bester Zug",

	MSG_MENU_BOOKWORST,
	"Schlechtester Zug",

	MSG_MENU_BOOKRANDOM,
	"Zufälliger Zug",

	MSG_MENU_DEPTH,
	"Suchtiefe",

	MSG_MENU_DEPTH0,
	"Benutze Zeiteinstellung",

	MSG_MENU_TIME,
	"T\1Zeiteinstellung",

	MSG_MENU_SHOWTHINKING,
	"D\1Zeige Denken",

	MSG_MENU_NULL,
	"Nullzüge",

	MSG_MENU_USEHASH,
	"Benutze Hashtabelle",

	MSG_MENU_DISPLAY,
	"Anzeige",

	MSG_MENU_BOARDSIZE,
	"Brettgröße",

	MSG_MENU_BOARDSMALL,
	"1\1Klein",

	MSG_MENU_BOARDMEDIUM,
	"2\1Mittel",

	MSG_MENU_BOARDLARGE,
	"3\1Groß",

	MSG_MENU_BOARDDESIGN,
	"Brettdesign",

	MSG_MENU_PIECES,
	"Figuren",

	MSG_MENU_EDITBOARD,
	"E\1Brett bearbeiten",

	MSG_MENU_REVERSEBOARD,
	"+\1Brett umdrehen",

	MSG_MENU_VOICE,
	"Stimme",

	MSG_MENU_HIDEMOVES,
	"Zughistorie ausblenden",

	MSG_MENU_EXTRAS,
	"Extras",

	MSG_MENU_EVALUATE,
	"Bewertung",

	MSG_MENU_STATISTICS,
	"Statistik",

	MSG_END,
	"",

	MSG_MYMOVE,
	"Mein Zug",

	MSG_BESTLINE,
	"Beste Kombination",

	MSG_WHITE,
	"Weiß",

	MSG_BLACK,
	"Schwarz",

	MSG_TIMESETTINGS,
	"Zeiteinstellung",

	MSG_MOVESIN,
	"Züge in",

	MSG_MINUTES,
	"Minuten",

	MSG_SEARCHITIME,
	"Suchzeit in sek",

	MSG_PROMOTEPAWN,
	"Bauer umwandeln in ...",

	MSG_STATISTICS,
	"Statistik",

	MSG_STAT_INIT0,
	"Knoten: 0 -> 0 pro sek",

	MSG_STAT_INIT1,
	"Züge: 0 -> 0 pro sek",

	MSG_STAT_INIT2,
	"Bewertung: 0 <-> 0",

	MSG_STAT_FORM0,
	"Knoten: %u -> %u pro sek",

	MSG_STAT_FORM1,
	"Züge: %u -> %u pro sek",

	MSG_STAT_FORM2,
	"Bewertung: %d <-> %d",

	MSG_POSEVAL,
	"Positionsbewertung",

	MSG_POSEVAL_INIT1,
	"Material: 0/0  Entwicklung: 0",

	MSG_POSEVAL_INIT2,
	"Bauer: 0  Springer: 0  Läufer: 0",

	MSG_POSEVAL_INIT3,
	"Turm: 0  Dame: 0  König: 0",

	MSG_POSEVAL_FORM1,
	"Material: %4d/%4d  Entwicklung: %d",

	MSG_POSEVAL_FORM2,
	"Bauer: %d  Springer: %d  Läufer: %d",

	MSG_POSEVAL_FORM3,
	"Turm: %d  Dame: %d  König: %d",

	MSG_POSEVAL_FORM4,
	"Bewertung: %d",

	MSG_BOOK_OPENED,
	"Buch geöffnet!",

	MSG_BOOK_NOTCONFORM,
	"Buch entspricht nicht dem aktuellen Format. Rekompilieren Sie die das Eröffnungsbuch.", /* MSG_BOOK_NOTCONFORM */

	MSG_BOOK_READPOS,
	"%d Buchpositionen gelesen. Hatte %d Hashkollisionen.",

	MSG_BOOK_NOTCREATE,
	"Konnte Buch nicht erzeugen.",

	MSG_BOOK_NOTWRITE,
	"Konnte nicht ins Buch.",

	MSG_BOOK_CREATENEW,
	"Erzeuge neues Buch!",

	MSG_BOOK_NOTREAD,
	"Konnte Buch nicht zum Lesen öffnen!",

	MSG_BOOK_GOTCOLLISIONS,
	"Hatte %d Hashkollisionen.",

	MSG_BOOK_READING,
	"Lese Eröffnungsbuch ...",

	MSG_BOOK_COLLISIONS,
	"%d Hashkollisionen.",

	MSG_COMP_LOSEBLACK,
	"1-0: Computer verliert als Schwarz.",

	MSG_COMP_LOSEWHITE,
	"0-1: Computer verliert als Weiß.",

	MSG_COMP_WINBLACK,
	"0-1: Computer gewinnt als Schwarz.",

	MSG_COMP_WINWHITE,
	"1-0: Computer gewinnt als Weiß.",

	MSG_STALEMATE,
	"1/2-1/2: Patt",

	MSG_DRAW,
	"1/2-1/2: Remis",

	MSG_FROMBOOK,
	"Aus dem Buch.",

	MSG_BOARDWRONG,
	"Brett falsch!",

	MSG_NOTPOSSIBLE,
	"Nicht möglich im Überwachungsmodus!",

	MSG_SEARCHTIMESET,
	"Suchzeit auf %.1f sek gesetzt.",

	MSG_TIMECONTROL,
	"Zeitkontrolle: %d Züge in %.1f sek.",

	MSG_EDITBOARD,
	"Brett bearbeiten",
	
	MSG_EDITBOARD_CLEAR,
	"Brett löschen",

	MSG_OK,
	"Ok",

	0,0
};

char ver[]="$VER: AmiChess.catalog 2.2a (09.09.2006)";

static void correct(char *str)
{
	int i;
	char *s = str;

	for(i = strlen(str); i>0; i--,s++)
	{
		if(*s==1)
		{
			*s=0;
			break;
		}
	}
}

int main(int argc,char *argv[])
{
	
	ULONG i,j;
	char null=0;
	char *str;
	char *s;
	struct IFFHandle *iff;

	if (!(IFFParseBase = OpenLibrary("iffparse.library", 50 ))) return FALSE;
	GETINTERFACE(IIFFParse, IFFParseBase);

	if( (iff=AllocIFF()) )
	{
		if( (iff->iff_Stream=Open("Catalogs/Deutsch/AmiChess.catalog",MODE_NEWFILE)) )
		{
			InitIFFasDOS(iff);
			if(!OpenIFF(iff,IFFF_WRITE))
			{
				if(!PushChunk(iff,'CTLG','FORM',IFFSIZE_UNKNOWN))
				{
					if(!PushChunk(iff,0,'FVER',IFFSIZE_UNKNOWN))
					{
						WriteChunkBytes(iff,ver,strlen(ver)+1);
						PopChunk(iff);
					}
					
					if(!PushChunk(iff,0,'LANG',IFFSIZE_UNKNOWN))
					{
						WriteChunkBytes(iff,"deutsch",8);
						PopChunk(iff);
					}
					
					if(!PushChunk(iff,0,'CSET',IFFSIZE_UNKNOWN))
					{
						for(i=0;i<32;i++) WriteChunkBytes(iff,&null,1);
						PopChunk(iff);
					}
					
					if(!PushChunk(iff,0,'STRS',IFFSIZE_UNKNOWN))
					{
						for(i=0;;i++)
						{
							s=app[i].str1;
							if(!s) break;
	
							str=s;
							j=strlen(s);
							correct(str);
							if(!(j&3)) j++;
							s=(char *)str;
							
							WriteChunkBytes(iff,&i,4);
							WriteChunkBytes(iff,&j,4);
							WriteChunkBytes(iff,s,j);

							switch(j&3)
							{
								case 1:
									WriteChunkBytes(iff,&null,1);
									WriteChunkBytes(iff,&null,1);
									WriteChunkBytes(iff,&null,1);
									break;
								case 2:
									WriteChunkBytes(iff,&null,1);
									WriteChunkBytes(iff,&null,1);
									break;
								case 3:
									WriteChunkBytes(iff,&null,1);
							}
						}
						PopChunk(iff);
					}
					PopChunk(iff);
				}
				CloseIFF(iff);
			}
			Close(iff->iff_Stream);
		}
		FreeIFF(iff);
	}

	if (IFFParseBase){ CloseLibrary(IFFParseBase); }
	if (IIFFParse){ DROPINTERFACE(IIFFParse); }

	return 0;

}
