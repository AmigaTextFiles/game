#ifndef _PARAMETERS_H_
#	define _PARAMETERS_H_


#include <SDL/SDL.h>

/** Static variables to hold the game parameters, documented in .cpp */
class Parameters {

public:

	const static unsigned int m_xSize;

	const static unsigned int m_ySize;

	const static unsigned int m_hiscores;

	const static char * m_hiscoreFile;

	const static char * m_piecePath;

	const static char * m_boardPath;

	const static char * m_fontPath;

	const static unsigned int m_initialBlocks;

	const static unsigned int m_newBlocksPerTurn;

//	const static unsigned int m_movesPerTurn;

	const static bool m_blackBlocks;

	const static bool m_jokerBlocks;

	const static unsigned int m_fontXSize;

	const static unsigned int m_fontYSize;

	const static unsigned int m_boardXSize;

	const static unsigned int m_boardYSize;

	const static unsigned int m_blockXSize;

	const static unsigned int m_blockYSize;

	const static unsigned int m_windowXSize;

	const static unsigned int m_windowYSize;

	const static unsigned int m_boardXOffSet;
	
	const static unsigned int m_boardYOffSet;

	static SDL_Color	m_red;
	static SDL_Color	m_green;
	static SDL_Color	m_blue;
	static SDL_Color	m_yellow;
	static SDL_Color	m_black;
	static SDL_Color	m_white;
	static SDL_Color	m_multiCol;
};

#endif
