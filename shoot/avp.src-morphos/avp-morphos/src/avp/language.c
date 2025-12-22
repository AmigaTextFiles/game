/*KJL***************************************
*    Language Internationalization Code    *
***************************************KJL*/
#include "3dc.h"
#include "inline.h"
#include "module.h"
#include "gamedef.h"


#include "langenum.h"
#include "language.h"
#include "huffman.hpp"

// DHM 12 Nov 97: hooks for C++ string handling code:
#include "strtab.hpp"

#define UseLocalAssert Yes
#include "ourasert.h"
#include "avp_menus.h"
#include "amigautils.h"

#ifdef AVP_DEBUG_VERSION
	#define USE_LANGUAGE_TXT 0
#else
	#define USE_LANGUAGE_TXT 1
#endif

static char EmptyString[]="";

static char *TextStringPtr[MAX_NO_OF_TEXTSTRINGS] = { EmptyString };
static char *TextBufferPtr;

void InitTextStrings(void)
{
	char *filename;
	char *textPtr;
	int i;

	/* language select here! */
	GLOBALASSERT(AvP.Language>=0);
	GLOBALASSERT(AvP.Language<I_MAX_NO_OF_LANGUAGES);
	
#if MARINE_DEMO
	filename = "menglish.txt";
#elif ALIEN_DEMO
	filename = "aenglish.txt";
#elif PREDATOR_DEMO
	filename = "english.txt";
#elif USE_LANGUAGE_TXT
	filename = "language.txt";
#else
	filename = LanguageFilename[AvP.Language];
#endif
	TextBufferPtr = LoadTextFile(filename);
		
	if (TextBufferPtr == NULL) {
		Amiga_FatalError("Unable to load language text file.");
	}
	
	if (!strncmp (TextBufferPtr, "REBCRIF1", 8))
	{
		textPtr = (char*)HuffmanDecompress((HuffmanPackage*)(TextBufferPtr)); 		
		DeallocateMem(TextBufferPtr);
		TextBufferPtr=textPtr;
	}
	else
	{
		textPtr = TextBufferPtr;
	}

	AddToTable( EmptyString );

	for (i=1; i<MAX_NO_OF_TEXTSTRINGS_FROM_FILE; i++)
	{	
		/* scan for a quote mark */
		while (*textPtr++ != '"') 
			if (*textPtr == '@') return; /* '@' should be EOF */

		/* now pointing to a text string after quote mark*/
		TextStringPtr[i] = textPtr;

		/* scan for a quote mark */
		while (*textPtr != '"')
		{	
			textPtr++;
		}

		/* change quote mark to zero terminator */
		*textPtr = 0;
		textPtr++;

		AddToTable( TextStringPtr[i] );
	}
	

	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_TITLE_HELP] = "Choose screen resolution to run the game.";

	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_MIPMAPS] = "Texture Mipmaps";
	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_MIPMAPS_HELP] = "Choose whether texture mipmapping will be used or not.";
	
	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_TEXTURE_QUALITY] ="32bit textures";
	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_TEXTURE_QUALITY_HELP] = "Use high quality textures. Reduces video memory usage when disabled.";
	
	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_FULLSCREEN] = "Fullscreen";
	TextStringPtr[TEXTSTRING_VIDEOOPTIONS_FULLSCREEN_HELP] = "Choose whether to play the game fullscreen or in a window.";

	TextStringPtr[TEXTSTRING_AVOPTIONS_ENABLEMUSIC] = "In-game Music";
	TextStringPtr[TEXTSTRING_AVOPTIONS_ENABLEMUSIC_HELP] = "Choose whether to play in-game music. This may affect performance on lower spec machines.";

	TextStringPtr[TEXTSTRING_AVOPTIONS_CDVOLUME] = "Music Volume";
	TextStringPtr[TEXTSTRING_AVOPTIONS_CDVOLUME_HELP] = "Adjust the volume of in-game music";

	
	
#ifdef __MORPHOS__
	TextStringPtr[TEXTSTRING_MAINMENU_EXITGAME_HELP] = "Exit the game and return to MorphOS";
#elif defined __AMIGAOS4__
	TextStringPtr[TEXTSTRING_MAINMENU_EXITGAME_HELP] = "Exit the game and return to AmigaOS4";
#elif defined __AROS__
	TextStringPtr[TEXTSTRING_MAINMENU_EXITGAME_HELP] = "Exit the game and return to AROS";
#else
	TextStringPtr[TEXTSTRING_MAINMENU_EXITGAME_HELP] = "Exit the game and return to AmigaOS";
#endif


#if 0
	// The language file for PC Classic2000 edition still says "Gold Edition" so they probably
	// hardcoded it in a similar way as this...
	TextStringPtr[TEXTSTRING_MAINMENU_SUBTITLE] = "Classic 2000";
#endif
}

void KillTextStrings(void)
{
	UnloadTextFile(LanguageFilename[AvP.Language],TextBufferPtr);

	UnloadTable();
}

char *GetTextString(enum TEXTSTRING_ID stringID)
{
	LOCALASSERT(stringID<MAX_NO_OF_TEXTSTRINGS);

	return TextStringPtr[stringID];
}


