/****************************************************************
   This file was created automatically by `FlexCat 1.5'
   from "Chaos.cd".

   Do NOT edit by hand!
****************************************************************/

/****************************************************************
    This file uses the auto initialization possibilities of
    Dice, gcc and SAS/C, respectively.

    Dice does this by using the keywords __autoinit and
    __autoexit, SAS uses names beginning with _STI or
    _STD, respectively. gcc uses the asm() instruction,
    to emulate C++ constructors and destructors.

    Using this file you don't have *all* possibilities of
    the locale.library. (No Locale or Language arguments are
    supported when opening the catalog. However, these are
    *very* rarely used, so this should be sufficient for most
    applications.
****************************************************************/


/*
    Include files and compiler specific stuff
*/
#include <exec/memory.h>
#include <libraries/locale.h>
#include <libraries/iffparse.h>

#if !defined(_DCC)
#define __autoinit
#define __autoexit
#if !defined(__SASC)  &&  !defined(__GNUC__)
#define _STIOpenChaosCatalog OpenChaosCatalog
#define _STDCloseChaosCatalog CloseChaosCatalog
#endif
#endif

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/locale.h>
#include <proto/utility.h>
#include <proto/iffparse.h>

#include <stdlib.h>
#include <string.h>



#include "Chaos_Cat.h"


/*
    Variables
*/
struct FC_String Chaos_Strings[229] = {
    { (STRPTR) "Tournamentfile-selection", 0 },
    { (STRPTR) "Cannot open %s as write-file!\nDOS-Error %ld", 1 },
    { (STRPTR) "DOS-Error %ld while writing %s!", 2 },
    { (STRPTR) "Cannot open %s as read-file!\nDOS-Error %ld", 3 },
    { (STRPTR) "%s is no Chaos-V5-file!", 4 },
    { (STRPTR) "DOS-Error %ld while reading %s!", 5 },
    { (STRPTR) "Attention!", 6 },
    { (STRPTR) "Changes have been made!\nDo you want to save the tournament first?", 7 },
    { (STRPTR) "Yes|No", 8 },
    { (STRPTR) "Cannot open Tournament-input-window!", 9 },
    { (STRPTR) "No pairings possible!\nToo much rounds?", 10 },
    { (STRPTR) "Cannot connect to printer!", 11 },
    { (STRPTR) "Page", 12 },
    { (STRPTR) "Name", 13 },
    { (STRPTR) "Rating", 14 },
    { (STRPTR) "Chess-club", 15 },
    { (STRPTR) "Home", 16 },
    { (STRPTR) "Address", 17 },
    { (STRPTR) "Birthday", 18 },
    { (STRPTR) "Phone", 19 },
    { (STRPTR) "List of players", 20 },
    { (STRPTR) "Result", 21 },
    { (STRPTR) "White", 22 },
    { (STRPTR) "Black", 23 },
    { (STRPTR) "Games of round %ld", 24 },
    { (STRPTR) "Place", 25 },
    { (STRPTR) "Points", 26 },
    { (STRPTR) "Buchholz", 27 },
    { (STRPTR) "Ext.Bchh.", 28 },
    { (STRPTR) "SnnBrgr.", 29 },
    { (STRPTR) "Table of round %ld %s", 30 },
    { (STRPTR) "Table %s", 31 },
    { (STRPTR) "Ratings", 32 },
    { (STRPTR) "Nr.", 33 },
    { (STRPTR) "List of rankings (round %ld)", 34 },
    { (STRPTR) "Table of progress until round %ld", 35 },
    { (STRPTR) "Opponent (Nr., Result, Color)", 36 },
    { (STRPTR) "    free", 37 },
    { (STRPTR) " dropped", 38 },
    { (STRPTR) "1 p. bye", 39 },
    { (STRPTR) "free", 40 },
    { (STRPTR) "(np)", 41 },
    { (STRPTR) "Input of games (round %ld)", 42 },
    { (STRPTR) "Games have already been paired!\nDo you really want to add new players?", 43 },
    { (STRPTR) "Games have already been paired!\nDo you really want to modify players?", 44 },
    { (STRPTR) "Games have already been paired!\nDo you really want to delete players?\n"\
	"(Mark them as withdrawn.)", 45 },
    { (STRPTR) "Do you really want to delete\nthe player %s?", 46 },
    { (STRPTR) "Do you really want to mark\n%s as withdrawn?", 47 },
    { (STRPTR) "Don't care!", 48 },
    { (STRPTR) "Player %s\nhas already been marked as withdrawn!", 49 },
    { (STRPTR) "Ok", 50 },
    { (STRPTR) "o", 51 },
    { (STRPTR) "Error!", 52 },
    { (STRPTR) "Out of memory!", 53 },
    { (STRPTR) "Swiss pairing", 54 },
    { (STRPTR) "Round Robin (FIDE-system)", 55 },
    { (STRPTR) "Round Robin (shift-system)", 56 },
    { (STRPTR) "Input of tournament-data", 57 },
    { (STRPTR) "Input of new players", 58 },
    { (STRPTR) "\033uW\033nhite wins", 59 },
    { (STRPTR) "\033uD\033nraw", 60 },
    { (STRPTR) "\033uB\033nlack wins", 61 },
    { (STRPTR) "Result \033u\033nmissing", 62 },
    { (STRPTR) "\033uP\033nlayed", 63 },
    { (STRPTR) "\033uN\033not played", 64 },
    { (STRPTR) "Project", 65 },
    { (STRPTR) "New", 66 },
    { (STRPTR) "Load", 67 },
    { (STRPTR) "Save", 68 },
    { (STRPTR) "Save as", 69 },
    { (STRPTR) "About", 70 },
    { (STRPTR) "Quit", 71 },
    { (STRPTR) "Players", 72 },
    { (STRPTR) "Add", 73 },
    { (STRPTR) "Import", 74 },
    { (STRPTR) "Modify", 75 },
    { (STRPTR) "Delete", 76 },
    { (STRPTR) "Round", 77 },
    { (STRPTR) "Make pairings", 78 },
    { (STRPTR) "Swiss pairing", 79 },
    { (STRPTR) "Round Robin (FIDE-system)", 80 },
    { (STRPTR) "Round Robin (shift-system)", 81 },
    { (STRPTR) "Enter results", 82 },
    { (STRPTR) "Output", 83 },
    { (STRPTR) "Player-list", 84 },
    { (STRPTR) "short", 85 },
    { (STRPTR) "long", 86 },
    { (STRPTR) "Rankings", 87 },
    { (STRPTR) "Round", 88 },
    { (STRPTR) "Table", 89 },
    { (STRPTR) "All", 90 },
    { (STRPTR) "Seniors", 91 },
    { (STRPTR) "Juniors", 92 },
    { (STRPTR) "Women", 93 },
    { (STRPTR) "Juniors (A)", 94 },
    { (STRPTR) "Juniors (B)", 95 },
    { (STRPTR) "Juniors (C)", 96 },
    { (STRPTR) "Juniors (D)", 97 },
    { (STRPTR) "Juniors (E)", 98 },
    { (STRPTR) "Table of progress", 99 },
    { (STRPTR) "DWZ-report", 100 },
    { (STRPTR) "Cross-table", 101 },
    { (STRPTR) "Ascii", 102 },
    { (STRPTR) "TeX", 103 },
    { (STRPTR) "Player-cards", 104 },
    { (STRPTR) "Ascii", 105 },
    { (STRPTR) "TeX", 106 },
    { (STRPTR) "Preferences", 107 },
    { (STRPTR) "scoring", 108 },
    { (STRPTR) "Simple", 109 },
    { (STRPTR) "Buchholz", 110 },
    { (STRPTR) "Buchholz (extended)", 111 },
    { (STRPTR) "Sonneborn-Berger", 112 },
    { (STRPTR) "Output-Device", 113 },
    { (STRPTR) "Screen", 114 },
    { (STRPTR) "Printer (Draft)", 115 },
    { (STRPTR) "Printer (LQ)", 116 },
    { (STRPTR) "File", 117 },
    { (STRPTR) "Set Games", 118 },
    { (STRPTR) "Make icons", 119 },
    { (STRPTR) "Save window settings", 120 },
    { (STRPTR) "Special", 121 },
    { (STRPTR) "Players:", 122 },
    { (STRPTR) "Rounds:", 123 },
    { (STRPTR) "Tournamentname:", 124 },
    { (STRPTR) "Tournamentfile:", 125 },
    { (STRPTR) "Tournamentmode:", 126 },
    { (STRPTR) "Cancel", 127 },
    { (STRPTR) "c", 128 },
    { (STRPTR) "Ok", 129 },
    { (STRPTR) "Tournamentname", 130 },
    { (STRPTR) "Name", 131 },
    { (STRPTR) "Home", 132 },
    { (STRPTR) "Address", 133 },
    { (STRPTR) "Chess-club", 134 },
    { (STRPTR) "Phone", 135 },
    { (STRPTR) "Birthday", 136 },
    { (STRPTR) "Rating", 137 },
    { (STRPTR) "ELO", 138 },
    { (STRPTR) "Senior", 139 },
    { (STRPTR) "Junior", 140 },
    { (STRPTR) "Woman", 141 },
    { (STRPTR) "Junior (A)", 142 },
    { (STRPTR) "Junior (B)", 143 },
    { (STRPTR) "Junior (C)", 144 },
    { (STRPTR) "Junior (D)", 145 },
    { (STRPTR) "Junior (E)", 146 },
    { (STRPTR) "Players name is missing!", 147 },
    { (STRPTR) "Error in birthday of player %s!", 148 },
    { (STRPTR) "This program is governed by the terms and conditions of the GNU General "\
	"Public License. A copy should have come with this distribution. (See the "\
	"file COPYING.) In that license it is made clear that you are welcome to "\
	"redistribute either verbatim or modified copies of the program and the "\
	"documentation under certain conditions. Further you are told that this "\
	"program comes with ABSOLUTELY NO WARRANTY!\n\n\n", 149 },
    { (STRPTR) "My thanks go to\n"\
	"\n"\
	"    Stefan Stuntz for MUI. Finally the user interface should be satisfying "\
	"for everyone.\n"\
	"\n"\
	"    Reinhard Spisser and Sebastiano Vigna for the Amiga-version of texinfo. "\
	"The documentation is written using this.\n"\
	"\n"\
	"    The Free Software Foundation for creating texinfo and many other "\
	"excellent programs.\n\n", 150 },
    { (STRPTR) "    The Betatesters: Kai Bolay, Frank Geider, Franz Hemmer, Jürgen Lang "\
	"(Quarvon), Christian Soltenborn and Volker Zink (The_Zinker)\n"\
	"\n"\
	"    My friend Mathias Moersch for his help in the manual's english "\
	"translation: Spending nearly 6 years in the USA finally does some good!\n"\
	"\n"\
	"    The people of #AmigaGer for answering many stupid questions and lots of "\
	"fun, for example PowerStat (Kai Hoffmann), ZZA (Bernhard Möllemann), "\
	"Stargazer (Petra Zeidler), stefanb (Stefan Becker), Tron (Mathias "\
	"Scheler) and ill (Markus Illenseer)\n"\
	"\n"\
	"    Commodore for the Amiga and Kickstart V2.x. Keep on developing and I'll "\
	"be an Amiga-user the next 8 years too. :-)\n"\
	"\n"\
	"    Douglas Adams and Tom Sharpe for creating Arthur Dent and Tom Sharpe. "\
	"My favourite (anti)-heroes!\n"\
	"\n"\
	"    and to my parents for their bath-tub: There's no better place to think "\
	"about something ;-)", 151 },
    { (STRPTR) "Player %s doesn't have a birthdate!\n"\
	"Please select an age-group or make another decision:", 152 },
    { (STRPTR) "20 or younger|21-25|26 or older|Modify|Skip|Cancel", 153 },
    { (STRPTR) "DWZ-Ratings", 154 },
    { (STRPTR) "Informations", 155 },
    { (STRPTR) "ELO", 156 },
    { (STRPTR) "S", 157 },
    { (STRPTR) "J", 158 },
    { (STRPTR) "W", 159 },
    { (STRPTR) "A", 160 },
    { (STRPTR) "B", 161 },
    { (STRPTR) "C", 162 },
    { (STRPTR) "D", 163 },
    { (STRPTR) "E", 164 },
    { (STRPTR) "(dd.mm.yyyy)", 165 },
    { (STRPTR) "L", 166 },
    { (STRPTR) "S", 167 },
    { (STRPTR) "A", 168 },
    { (STRPTR) "I", 169 },
    { (STRPTR) "N", 170 },
    { (STRPTR) "M", 171 },
    { (STRPTR) "Select a player to modify", 172 },
    { (STRPTR) "TeX-file-selection", 173 },
    { (STRPTR) "Games have already been paired.\nNo new players possible!", 174 },
    { (STRPTR) "It isn't possible to enter new players,\nwhen round 1 is finished!", 175 },
    { (STRPTR) "Player modification", 176 },
    { (STRPTR) "Select a player to delete", 177 },
    { (STRPTR) "No players may be deleted\n in a round robin tournament!", 178 },
    { (STRPTR) "Yes|No|Cancel", 179 },
    { (STRPTR) "Setting of games", 180 },
    { (STRPTR) "Delete", 181 },
    { (STRPTR) "d", 182 },
    { (STRPTR) "F", 183 },
    { (STRPTR) "Output file selection", 184 },
    { (STRPTR) "Round selection", 185 },
    { (STRPTR) "Please select a round number", 186 },
    { (STRPTR) "Canot open window: %s", 187 },
    { (STRPTR) "Ok", 188 },
    { (STRPTR) "Out of memory", 189 },
    { (STRPTR) "Out of chip memory", 190 },
    { (STRPTR) "Invalid window object", 191 },
    { (STRPTR) "Missing library", 192 },
    { (STRPTR) "Cannot create ARexx port", 193 },
    { (STRPTR) "Application is already running", 194 },
    { (STRPTR) "Unknown error", 195 },
    { (STRPTR) "Number of active players is even:\n"\
	"No one point bye allowed.", 196 },
    { (STRPTR) "Players %s\n"\
	"and %s\n"\
	"have already been paired in round %ld.", 197 },
    { (STRPTR) "Players %s\n"\
	"and %s\n"\
	"had %s pieces in the last two rounds.\n\n"\
	"Do you really want to pair them?", 198 },
    { (STRPTR) "Player %s has withdrawn\n"\
	"and cannot be set.", 199 },
    { (STRPTR) "Player %s is already set as\n"\
	"opponent of player %s.", 200 },
    { (STRPTR) "Player %s already\n"\
	"had an one point bye.", 201 },
    { (STRPTR) "Modify", 202 },
    { (STRPTR) "m", 203 },
    { (STRPTR) "Result", 204 },
    { (STRPTR) "Mode", 205 },
    { (STRPTR) "Finish", 206 },
    { (STRPTR) "f", 207 },
    { (STRPTR) "Chaos selects colors", 208 },
    { (STRPTR) "User determines colors", 209 },
    { (STRPTR) "(cd)", 210 },
    { (STRPTR) "Player %s already had\n"\
	"the %s pieces in the last two rounds.\n"\
	"Do you really want this?", 211 },
    { (STRPTR) "w", 212 },
    { (STRPTR) "d", 213 },
    { (STRPTR) "b", 214 },
    { (STRPTR) "m", 215 },
    { (STRPTR) "p", 216 },
    { (STRPTR) "n", 217 },
    { (STRPTR) "A player %s already exists.", 218 },
    { (STRPTR) "Delete him|Skip him|Cancel", 219 },
    { (STRPTR) "Withdraw him|Skip him|Cancel", 220 },
    { (STRPTR) "Please select players to import", 221 },
    { (STRPTR) "Import", 222 },
    { (STRPTR) "i", 223 },
    { (STRPTR) "Reverse", 224 },
    { (STRPTR) "r", 225 },
    { (STRPTR) "Cancelling output:\nPrinter trouble.", 226 },
    { (STRPTR) "Winner points:", 227 },
    { (STRPTR) "Draw points:", 228 }
};

STATIC struct Catalog *ChaosCatalog = NULL;
#ifdef LOCALIZE_V20
STATIC STRPTR ChaosStrings = NULL;
STATIC ULONG ChaosStringsSize;
#endif



#if defined(__GNUC__)  ||  defined(__SASC)  ||  defined(_DCC)
STATIC __autoexit VOID _STDCloseChaosCatalog(VOID)
#else
VOID CloseChaosCatalog(VOID)
#endif

{
    if (ChaosCatalog) {
	CloseCatalog(ChaosCatalog);
    }
#ifdef LOCALIZE_V20
    if (ChaosStrings) {
	FreeMem(ChaosStrings, ChaosStringsSize);
    }
#endif
}


#if defined(__GNUC__)  ||  defined(__SASC)  ||  defined(_DCC)
STATIC __autoinit VOID _STIOpenChaosCatalog(VOID)
#else
VOID OpenChaosCatalog(VOID)
#endif

{
    if (LocaleBase) {
	if ((ChaosCatalog = OpenCatalog(NULL, (STRPTR) "Chaos.catalog",
				     OC_BuiltInLanguage, "english",
				     OC_Version, 8,
				     TAG_DONE))) {
	    struct FC_String *fc;
	    int i;

	    for (i = 0, fc = Chaos_Strings;  i < 229;  i++, fc++) {
		 fc->msg = GetCatalogStr(ChaosCatalog, fc->id, fc->msg);
	    }
	}
    }
}

#if defined(__GNUC__)
__asm ("  .text;  .stabs \"___CTOR_LIST__\",22,0,0,__STIOpenChaosCatalog");
__asm ("  .text;  .stabs \"___DTOR_LIST__\",22,0,0,__STDCloseChaosCatalog");
#endif



#ifdef LOCALIZE_V20
VOID InitChaosCatalog(STRPTR language)

{
    struct IFFHandle *iffHandle;

    /*
    **  Use iffparse.library only, if we need to.
    */
    if (LocaleBase  ||  !IFFParseBase  ||  !language  ||
	Stricmp(language, "english") == 0) {
	return;
    }

    if ((iffHandle = AllocIFF())) {
	char path[128]; /* Enough to hold 4 path items (dos.library 3.1)    */
	strcpy(path, "PROGDIR:Catalogs");
	AddPart((STRPTR) path, language, sizeof(path));
	AddPart((STRPTR) path, "Chaos.catalog", sizeof(path));
	if (!(iffHandle->iff_Stream = Open((STRPTR) path, MODE_OLDFILE))) {
	    strcpy(path, "LOCALE:Catalogs");
	    AddPart((STRPTR) path, language, sizeof(path));
	    AddPart((STRPTR) path, language, sizeof(path));
	    iffHandle->iff_Stream = Open((STRPTR) path, MODE_OLDFILE);
	}

	if (iffHandle->iff_Stream) {
	    InitIFFasDOS(iffHandle);
	    if (!OpenIFF(iffHandle, IFFF_READ)) {
		if (!PropChunk(iffHandle, MAKE_ID('C','T','L','G'),
			       MAKE_ID('S','T','R','S'))) {
		    struct StoredProperty *sp;
		    int error;

		    for (;;) {
			if ((error = ParseIFF(iffHandle, IFFPARSE_STEP))
				   ==  IFFERR_EOC) {
			    continue;
			}
			if (error) {
			    break;
			}

			if ((sp = FindProp(iffHandle, MAKE_ID('C','T','L','G'),
					   MAKE_ID('S','T','R','S')))) {
			    /*
			    **  Check catalog and calculate the needed
			    **  number of bytes.
			    **  A catalog string consists of
			    **      ID (LONG)
			    **      Size (LONG)
			    **      Bytes (long word padded)
			    */
			    LONG bytesRemaining;
			    LONG *ptr;

			    ChaosStringsSize = 0;
			    bytesRemaining = sp->sp_Size;
			    ptr = (LONG *) sp->sp_Data;

			    while (bytesRemaining > 0) {
				LONG skipSize, stringSize;

				ptr++;                  /*  Skip ID     */
				stringSize = *ptr++;
				skipSize = ((stringSize+3) >> 2);

				ChaosStringsSize += stringSize+1;  /*  NUL */
				bytesRemaining -= 8 + (skipSize << 2);
				ptr += skipSize;
			    }

			    if (!bytesRemaining  &&
				(ChaosStrings = AllocMem(ChaosStringsSize, MEMF_ANY))) {
				STRPTR sptr;

				bytesRemaining = sp->sp_Size;
				ptr = (LONG *) sp->sp_Data;
				sptr = ChaosStrings;

				while (bytesRemaining) {
				    LONG skipSize, stringSize, id;
				    struct FC_String *fc;
				    int i;

				    id = *ptr++;
				    stringSize = *ptr++;
				    skipSize = ((stringSize+3) >> 2);

				    CopyMem(ptr, sptr, stringSize);
				    bytesRemaining -= 8 + (skipSize << 2);
				    ptr += skipSize;

				    for (i = 0, fc = Chaos_Strings;  i < 229;  i++, fc++) {
					if (fc->id == id) {
					    fc->msg = sptr;
					}
				    }

				    sptr += stringSize;
				    *sptr++ = '\0';
				}
			    }
			    break;
			}
		    }
		}
		CloseIFF(iffHandle);
	    }
	    Close(iffHandle->iff_Stream);
	}
	FreeIFF(iffHandle);
    }
}
#endif
