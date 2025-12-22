#include "parameters.h"

//////////////////
// Game parameters
//////////////////

/** Hiscore table size */
const unsigned int	Parameters::m_hiscores = 5;

/** Blocks in a row */
const unsigned int	Parameters::m_xSize = 10;

/** Blocks in a column */
const unsigned int	Parameters::m_ySize = 10;

/** Blocks in the beginning */
const unsigned int	Parameters::m_initialBlocks = 8;

/** New blocks / turn */
const unsigned int	Parameters::m_newBlocksPerTurn = 4; // 4

//const unsigned int	Parameters::m_movesPerTurn = 1;

/** Non-movable blocks */
const bool	Parameters::m_blackBlocks = true;

/** Jokers */
const bool	Parameters::m_jokerBlocks = true;


//////
// GFX
//////

/** Courier font width */
const unsigned int Parameters::m_fontXSize = 11;

/** Courier font height */
const unsigned int Parameters::m_fontYSize = 18;

/** Game area width */
const unsigned int Parameters::m_boardXSize = 162;

/** Game area height */
const unsigned int Parameters::m_boardYSize = 162;

/** Block width */
const unsigned int Parameters::m_blockXSize = 16;

/** Block height */
const unsigned int Parameters::m_blockYSize = 16;

/** Window width */
const unsigned int Parameters::m_windowXSize = 206;

/** Window height */
const unsigned int Parameters::m_windowYSize = 274;

/** From window origo X to game area origo X */
const unsigned int Parameters::m_boardXOffSet = 23;

/** From window origo Y to game area origo y */
const unsigned int Parameters::m_boardYOffSet = 57;


////////
// Paths
////////

/** Highscore file */
const char	* Parameters::m_hiscoreFile = "hiscores.dat";

/** Block graphics */
const char  * Parameters::m_piecePath	= "gfx/pieces.bmp";

/** Board graphics */
const char  * Parameters::m_boardPath	= "gfx/board.bmp";

/** Font graphics */
const char  * Parameters::m_fontPath	= "gfx/c18font.bmp";


/////////
// Colors
/////////

SDL_Color Parameters::m_red		= { 255,   0, 255 };
SDL_Color Parameters::m_green	= { 136, 255, 119 };
SDL_Color Parameters::m_blue	= { 0,   153, 255 };
SDL_Color Parameters::m_yellow	= { 255, 238, 119 };
SDL_Color Parameters::m_black	= { 0,   0,   0 };
SDL_Color Parameters::m_white	= { 255, 255, 255 };

// Not a real color - used to pick a color randomly in Board::writeText()
SDL_Color Parameters::m_multiCol = { 1, 2, 3};

