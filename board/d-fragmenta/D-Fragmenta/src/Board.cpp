#include <SDL/SDL.h>

#include "board.h"
#include "parameters.h"
#include "highscores.h"

//#include <string>
#include <stdlib.h>
#include <assert.h>

#include <list>

using namespace std;


/** Ctor */
Board::Board()
{
	srand( (long)this );

	m_board = new int[ Parameters::m_xSize * Parameters::m_ySize ];

	m_freePieces = new CoordinatePair[ Parameters::m_xSize * Parameters::m_ySize ];

	m_lastPieces = new CoordinatePair[ Parameters::m_newBlocksPerTurn ];

	m_undoPieces = new int[ Parameters::m_xSize * Parameters::m_ySize ];

	m_connected = new int[ Parameters::m_xSize * Parameters::m_ySize ];

	m_free = Parameters::m_xSize * Parameters::m_ySize;

	m_level = 1;
	m_turn = 0;
	m_score = 0;
	m_undo = false;
}


/** Dtor */
Board::~Board()
{
	delete [] m_freePieces;
	delete [] m_board;
	delete [] m_lastPieces;
	delete [] m_undoPieces;
	delete [] m_connected;
}


/** Initialize board */
bool Board::init()
{
	m_videoInfo = SDL_GetVideoInfo();

	m_surface = SDL_SetVideoMode(Parameters::m_windowXSize, Parameters::m_windowYSize, m_videoInfo->vfmt->BitsPerPixel, SDL_HWPALETTE|SDL_DOUBLEBUF);	

	m_boardGFX = SDL_LoadBMP( Parameters::m_boardPath );
	m_piecesGFX = SDL_LoadBMP( Parameters::m_piecePath );
	m_fontGFX = SDL_LoadBMP( Parameters::m_fontPath );

	if ( !( m_surface && m_piecesGFX && m_boardGFX && m_fontGFX ) )
	{
		printf( "Initializing GFX failed, check datafiles too\n" );
		return false;
	}

	// For alpha rendering the font
	SDL_SetColorKey( m_fontGFX, SDL_SRCCOLORKEY, 0);

	return true;
}


/** Draw some blocks and show highscores until time in msecs has gone */
void Board::demo(unsigned int time) const
{
	int x, y, c;
	SDL_Rect pieceRect, boardRect;

	// never changing values
	pieceRect.y = 0;
	pieceRect.w = Parameters::m_blockXSize;
	pieceRect.h = Parameters::m_blockYSize;

	unsigned int initTime = SDL_GetTicks();

	while ( (SDL_GetTicks() - initTime) < time )
	{		
		// colour
		c = getRnd(RED, NONE);
		pieceRect.x = c * Parameters::m_blockXSize;

		// position on board
		x = getRnd(0, Parameters::m_xSize - 1);
		y = getRnd(0, Parameters::m_ySize - 1);

		boardRect.x = Parameters::m_boardXOffSet + x * Parameters::m_blockXSize;
		boardRect.y = Parameters::m_boardYOffSet + y * Parameters::m_blockYSize;
		boardRect.w = Parameters::m_blockXSize;
		boardRect.h = Parameters::m_blockYSize;

		SDL_BlitSurface( m_piecesGFX, &pieceRect, m_surface, &boardRect);
		

		unsigned int textYOffset = 0;

		// Title
		writeText( "< D-Fragmenta >", Parameters::m_windowXSize / 2 - ( strlen("< D-Fragmenta >") * Parameters::m_fontXSize / 2 ),
			Parameters::m_boardYOffSet + textYOffset * Parameters::m_fontYSize,
			&Parameters::m_red );

		textYOffset += 2;

		writeText( "Highscores:", Parameters::m_windowXSize / 2 - ( strlen("Highscores:") * Parameters::m_fontXSize / 2 ),
			Parameters::m_boardYOffSet + textYOffset * Parameters::m_fontYSize,
			&Parameters::m_blue );

		for ( unsigned int i = 0; i < Parameters::m_hiscores; i++ )
		{
			textYOffset++;

			char *name = Highscores::instance()->getName( i );
			unsigned int score = Highscores::instance()->getScore( i );

			char buffer[6+6+1]; 

			sprintf(buffer, "%5d %6s", score, name);

			writeText(buffer, Parameters::m_windowXSize / 2 - ( strlen( buffer ) * Parameters::m_fontXSize / 2 ),
			Parameters::m_boardYOffSet + textYOffset * Parameters::m_fontYSize,
			&Parameters::m_green );
		}

		SDL_Delay( 50 );

		SDL_Flip( m_surface );	
	} 
}


/** Calculate how many free blocks are on the board */
unsigned int Board::findFree()
{
	m_free = 0;

	for (unsigned int y = 0; y < Parameters::m_ySize; y++)
	{
		for (unsigned int x = 0; x < Parameters::m_xSize; x++)
		{
			if ( NONE == m_board[ y * Parameters::m_xSize + x ] )
			{
				// Mark found free squares
				m_freePieces[ m_free ].x = x;
				m_freePieces[ m_free ].y = y;
				m_free++;
			}
		}
	}	

	return m_free;
}


/** Check if there are colour combinations on the board which could be removed */
void Board::checkBoard()
{
//	unsigned int /*x, y,*/ score = 0;
//	unsigned int jokers, same;

	for ( unsigned int y = 0; y < Parameters::m_ySize; y++ )
	{
		for ( unsigned int x = 0; x < Parameters::m_xSize; x++ )
		{
			// NOTE: search can't start from empty block or joker
			if ( get(x, y) != NONE && get(x, y) != JOKER )
			{
				findConnected( x, y );	
			}
		}
	}

//	for ( y = 0; y < Parameters::m_ySize - 1; y++ )
//	{
//		for ( x = 0; x < Parameters::m_xSize - 1; x++ )
//		{
//			jokers = howManyJokers(x, y);
//			same   = howManySame(x, y);
//
//			if ( ( jokers == 4 ) ||
//				( ( jokers == 3 ) && ( same == 1 ) ) || 
//				( ( jokers == 2 ) && ( same == 2 ) ) ||
//				( ( jokers == 1 ) && ( same == 3 ) ) ||
//				( ( same == 4 ) )
//			)
//			{
//				m_score += 10;
//				
//				// Destroy blocks
//				set(x, y, NONE);
//				set(x+1, y, NONE);
//				set(x, y+1, NONE);
//				set(x+1, y+1, NONE);
//
//				// Remove last piece information if a new block will be destroyed
//				for ( unsigned int i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
//				{
//					if ( (m_lastPieces[i].x == x && m_lastPieces[i].y == y)
//						|| (m_lastPieces[i].x == (x+1) && m_lastPieces[i].y == y)
//						|| (m_lastPieces[i].x == x && m_lastPieces[i].y == (y+1))
//						|| (m_lastPieces[i].x == (x+1) && m_lastPieces[i].y == (y+1) ) )
//					{
//						m_lastPieces[i].x = 69;
//					}
//				}
//
//
//				// Print some score text
//				SDL_Rect rect;
//				for ( unsigned int n = 1; n <= Parameters::m_blockXSize; n++ )
//				{	
//					rect.x = (x + 1) * Parameters::m_blockXSize + Parameters::m_boardXOffSet - n;
//					rect.y = (y + 1) * Parameters::m_blockXSize + Parameters::m_boardYOffSet - n;
//
//					rect.w = n * 2;
//					rect.h = n * 2;
//
//					SDL_FillRect( m_surface, &rect, 0xffffffff );
//
//					writeText( "10", x * Parameters::m_blockXSize + Parameters::m_boardXOffSet + 6 + ( (rand() % 3) - 2 ), y * Parameters::m_blockYSize + Parameters::m_boardYOffSet + ( (rand() % 3) - 2 ) + 9, &Parameters::m_multiCol );
//
//					SDL_Delay( 50 );
//
//					SDL_Flip( m_surface );
//				}
//
//			} // if
//
//		} // x
//	} // y


	findFree();

	draw();

//	return score;
}


/** Recursive function that tries to find connected blocks */
unsigned int Board::findConnected(unsigned int x, unsigned int y)
{
	// std::list
	typedef list<CoordinatePair*> BLOCKLIST;
	
	// Current color
	unsigned int piece = get(x, y);

	// Number of connected blocks so far
	unsigned int number = 0;
		
	// List for connected blocks
	static BLOCKLIST destroyables;

	// Level of recursion
	static unsigned int level = 0;
	
	// Because of joker blocks, we have to know which colour we are searching for.
	// The search can't start from joker so let's init the value to the first color.
	static unsigned int colorToFind = 0;

	// If joker found (we are deeper in recursion then!),
	// hack the piece to color we are looking for, because otherwise joker blocks could
	// confuse the searching.
	if ( JOKER == piece )
	{
		piece = colorToFind;
	}
	else
	{
		colorToFind = piece;	
	}

	// Helper for visited blocks info
	enum {
		CLEAR,
		VISITED
	};

	// When entering the function, clear the visited table
	if ( 0 == level )
	{
		for (unsigned int y = 0; y < Parameters::m_ySize; y++)
		{
			for (unsigned int x = 0; x < Parameters::m_xSize; x++)
			{
				m_connected[ y * Parameters::m_xSize + x ] = CLEAR;
			}	
		}
	}

	// Mark current block as visited to prevent endless snake-tail recursion
	m_connected[y * Parameters::m_ySize + x] = VISITED; 

	// Add current block to 'connected' list
	destroyables.push_back( new CoordinatePair(x, y) );
	
	// Increase the number of the connected blocks
	number++;

	level++;


	/////////////////////////////////////////
	// Find more connected blocks recursively
	/////////////////////////////////////////


	// Check east
	if ( x + 1 < Parameters::m_xSize && ( get(x + 1, y) == piece || get(x + 1, y) == JOKER ) )
	{
		// Check if the block hasn't yet been visited
		if ( CLEAR == m_connected[y * Parameters::m_ySize + x + 1] )
		{
			number += findConnected( x + 1, y );
		}
	}

	// Check north
	if ( y > 0 && ( get(x, y - 1) == piece || get(x, y - 1) == JOKER ) )
	{
		if ( CLEAR == m_connected[(y - 1) * Parameters::m_ySize + x] )
		{
			number += findConnected( x, y - 1 );
		}
	}

	// Check west
	if ( x > 0 && ( get(x - 1, y) == piece || get(x - 1, y) == JOKER) ) 
	{
		if ( CLEAR == m_connected[y * Parameters::m_ySize + x - 1] )
		{
			number += findConnected( x - 1, y );
		}		
	}

	// Check south
	if ( y + 1 < Parameters::m_ySize && ( get(x, y + 1) == piece || get(x, y + 1) == JOKER ) )
	{
		if ( CLEAR == m_connected[ (y + 1) * Parameters::m_ySize + x] )
		{
			number += findConnected( x, y + 1 );
		}
	}

	level--;

	// Ok, we are back to the 'root' level, so let's check out if we have more than 3 connected
	// blocks on the list.
	if ( level == 0 )
	{
		int helper = number, score = 0;
		char buf[2];

		for ( BLOCKLIST::iterator itr = destroyables.begin(); itr != destroyables.end(); itr++ )
		{
			if ( number > 3 )
			{
				CoordinatePair *cp = (*itr);

				// Remove last piece information if a new block will be destroyed
				for ( unsigned int i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
				{
					if ( (m_lastPieces[i].x == cp->x && m_lastPieces[i].y == cp->y)
						|| (m_lastPieces[i].x == (cp->x+1) && m_lastPieces[i].y == cp->y)
						|| (m_lastPieces[i].x == cp->x && m_lastPieces[i].y == (cp->y+1))
						|| (m_lastPieces[i].x == (cp->x+1) && m_lastPieces[i].y == (cp->y+1) ) )
					{
						m_lastPieces[i].x = 69;
					}
				}
				
				score = number - (--helper);
				sprintf( buf, "%2d", score);

				// Simple destruction animation
				SDL_Rect rect;
				for ( unsigned int n = 1; n <= Parameters::m_blockXSize; n += 2 )
				{	
					rect.x = (cp->x) * Parameters::m_blockXSize + Parameters::m_boardXOffSet + (int)( (Parameters::m_blockXSize - n ) * 0.5 );
					rect.y = (cp->y) * Parameters::m_blockXSize + Parameters::m_boardYOffSet + (int)( (Parameters::m_blockYSize - n ) * 0.5 );

					rect.w = n;
					rect.h = n;

					SDL_FillRect( m_surface, &rect, 0xffffffff );

					writeText( buf, cp->x * Parameters::m_blockXSize + Parameters::m_boardXOffSet - 3, cp->y * Parameters::m_blockYSize + Parameters::m_boardYOffSet, &Parameters::m_multiCol );

					SDL_Flip( m_surface );

					//SDL_Delay( 5 );

					draw();
				}

				set( cp->x, cp->y, NONE );
				
				m_score += score;

			} // if

		} // for

		// Clear the list
		destroyables.clear();
	
	} // if

	return number;
}


/** Clears the board */
void Board::clear()
{
	for (unsigned int y = 0; y < Parameters::m_ySize; y++)
	{
		for (unsigned int x = 0; x < Parameters::m_xSize; x++)
		{
			m_board[ y * Parameters::m_xSize + x ] = NONE;
			m_freePieces[ y * Parameters::m_xSize + x ].x = x;
			m_freePieces[ y * Parameters::m_xSize + x ].y = y;
		}
	}

	findFree();

	// 'Clear' last added info
	for (unsigned int i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
	{
		m_lastPieces[i].x = 69;
	}

	m_turn = 0;
	m_score = 0;
	m_level = 1;
}


/** Returns a piece by coordinate */
unsigned int Board::get(unsigned int x, unsigned int y) const
{
	assert( (x >= 0 && x < Parameters::m_xSize) );
	assert( (y >= 0 && y < Parameters::m_ySize) );

	return m_board[ y * Parameters::m_xSize + x ];
}


/** Random number between min and max, inclusive */
unsigned int Board::getRnd(unsigned int min, unsigned int max) const 
{
	max++;
	return ( (rand() % (max-min)) + min);
}


/** Lottery for next pieces */
void Board::nextTurn()
{
	unsigned int tryX, tryY, tryCol, i, blocks, index;

	if ( getFree() >= Parameters::m_newBlocksPerTurn )
	{
		blocks = Parameters::m_newBlocksPerTurn;
	}
	else
	{
		blocks = getFree();
	}

	for ( i = 0; i < blocks; i++ )
	{
		index = getRnd( 0, findFree() - 1 );
		tryX = m_freePieces[index].x;
		tryY = m_freePieces[index].y;

//		if ( Parameters::m_blackBlocks )
//		{
			if ( m_level > 2 )
			{
				tryCol = getRnd(RED, BROWN);
			}
			else
			{
				tryCol = getRnd(RED, BLACK); // 0,5
			}

//			// Make black pieces more random
//			if ( tryCol == BLACK )
//			{
//				tryCol = getRnd(0, 5);
//			}

//		}
//		else
//		{
//			tryCol = getRnd(0, 4);
//		}

		set(tryX, tryY, tryCol);
		
		m_lastPieces[i].x = tryX;
		m_lastPieces[i].y = tryY;
	}

	draw();

	findFree();
}


/** Undo the pieces positions. Works once per game! */
void Board::undo(void)
{
	// Undo board
	if ( m_turn > 0 && m_undo )
	{
		unsigned i;
		for ( i = 0; i < Parameters::m_xSize * Parameters::m_ySize; i++ )
		{
			m_board[i] = m_undoPieces[i];
		}

		// Clear last pieces
		for ( i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
		{
			m_lastPieces[i].x = 69;
		}

		m_turn--;

		m_score = m_undoScore;

		m_undo = false;

		draw();

		findFree();
	}
}


/** Set a piece on the board */
void Board::set(unsigned int x, unsigned int y, unsigned int c)
{
	assert( (x >= 0 && x < Parameters::m_xSize) );
	assert( (y >= 0 && y < Parameters::m_ySize) );

	m_board[ y * Parameters::m_xSize + x ] = c;
}


/** Draw the board */
void Board::draw() const
{
	unsigned int x, y;

	SDL_Rect pieceRect, boardRect;

	// Draw board's frame
	SDL_Rect rect = {0, 0, Parameters::m_windowXSize, Parameters::m_windowYSize};
	SDL_BlitSurface( m_boardGFX, &rect, m_surface, &rect );

	// never changing values!
	pieceRect.y = 0;
	pieceRect.w = Parameters::m_blockXSize;
	pieceRect.h = Parameters::m_blockYSize;

	boardRect.w = Parameters::m_blockXSize;
	boardRect.h = Parameters::m_blockYSize;


	// draw blocks
	for ( y = 0; y < Parameters::m_ySize; y++ )
	{
		
		for ( x = 0; x < Parameters::m_xSize; x++ )
		{

			pieceRect.x = get(x, y) * Parameters::m_blockYSize;

			boardRect.x = x * Parameters::m_blockXSize + Parameters::m_boardXOffSet;
			boardRect.y = y * Parameters::m_blockYSize + Parameters::m_boardYOffSet;

			SDL_BlitSurface( m_piecesGFX, &pieceRect, m_surface, &boardRect);

		} // for x

	} // for y

	// Mark last added blocks
	for ( unsigned int i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
	{
		// 
//		if ( m_lastAdded[i].x < Parameters::m_xSize )
		{
			pieceRect.x = BLACK_FRAME * Parameters::m_blockXSize;

			boardRect.x = m_lastPieces[i].x * Parameters::m_blockXSize + Parameters::m_boardXOffSet;
			boardRect.y = m_lastPieces[i].y * Parameters::m_blockYSize + Parameters::m_boardYOffSet;

			SDL_SetColorKey( m_piecesGFX, SDL_SRCCOLORKEY, 2 );

			SDL_BlitSurface( m_piecesGFX, &pieceRect, m_surface, &boardRect);

			SDL_SetColorKey( m_piecesGFX, 0, 0 );
		}
	}

	// Print text and buttons
	char charBuf[6];

	// SCORE
	writeText( "Score", 132, 10, &Parameters::m_blue );
	sprintf( charBuf, "%5d", m_score );
	writeText( charBuf, 132, 26, &Parameters::m_red );

	// TURN
	writeText( "Turn", 16, 10, &Parameters::m_green );
	sprintf( charBuf, "%4d", m_turn );
	writeText( charBuf, 16, 26, &Parameters::m_red );

	// UNDO
	if ( m_undo && m_turn > 0 )
	{
		blitUndo( &Parameters::m_yellow );
	}

	// NEW GAME
	blitNewGame( &Parameters::m_yellow );
	
	SDL_Flip( m_surface );
}


/***/
void Board::blitUndo(SDL_Color* col) const
{
	writeText( "UNDO", 16, 237, col );
}


/***/
void Board::blitNewGame(SDL_Color* col) const
{
	writeText( "NEW GAME", 100, 237, col );
}


///** Check if there are four same coloured pieces in a rectangular shape */
//unsigned int Board::howManySame(unsigned int x, unsigned int y) const
//{
//	unsigned int reds = 0, greens = 0, blues = 0, yellows = 0, blacks = 0, empties = 0;
//	unsigned int most, xIndex, yIndex;
//
//	assert( (x >= 0 && x < Parameters::m_xSize - 1) );
//	assert( (y >= 0 && y < Parameters::m_ySize - 1) );
//
//	for ( yIndex = y; yIndex <= y + 1; yIndex++ )
//	{
//		for ( xIndex = x; xIndex <= x + 1; xIndex++ )
//		{
//			switch( get(xIndex, yIndex) )
//			{
//			
//			case RED:
//				reds++;
//				break;
//
//			case GREEN:
//				greens++;
//				break;
//
//			case BLUE:
//				blues++;
//				break;
//			
//			case BLACK:
//				blacks++;
//				break;
//			
//			case YELLOW:
//				yellows++;
//				break;
//
//			case NONE:
//				empties++;
//				break;
//			}
//
//		} // x
//	} // y
//
//	// return the highest amount minus possible empty blocks
//	most = reds;
//
//	most = max(greens, most);
//	most = max(blues, most);
//	most = max(yellows, most);
//	most = max(blacks, most);
//
//	return (most - empties);
//}
//
//
///** Calculate the amount of joker pieces in a rectangular shape */
//unsigned int Board::howManyJokers(unsigned int x, unsigned int y) const
//{
//	unsigned int jokers = 0;
//
//	assert( (x >= 0 && x < Parameters::m_xSize - 1) );
//	assert( (y >= 0 && y < Parameters::m_ySize - 1) );
//
//	if ( get(x, y) == JOKER )
//		jokers++;
//
//	if ( get(x+1, y) == JOKER )
//		jokers++;
//
//	if ( get(x, y+1) == JOKER )
//		jokers++;
//
//	if ( get(x+1, y+1) == JOKER )
//		jokers++;
//
//	return jokers;
//}


/** Move a block from a position to another */
bool Board::moveBlock(unsigned int fromX, unsigned int fromY, unsigned int toX, unsigned int toY) 
{
	unsigned int fromPiece = get(fromX, fromY);
	unsigned int toPiece = get(toX, toY);

	// Copy board for Undo
	unsigned int i;
	for ( i = 0; i < Parameters::m_xSize * Parameters::m_ySize; i++ )
	{
		m_undoPieces[i] = m_board[i];
		m_undoScore = m_score;
	}

	// Check range
	if ( abs( (int)(fromX - toX) ) <= 1 && abs( (int)(fromY - toY) ) <= 1 )
	{
		if ( fromPiece != BLACK && fromPiece != NONE && toPiece == NONE )
		{
			set(fromX, fromY, NONE);
			set(toX, toY, fromPiece);

			// Clear last piece information if moved 
			for ( i = 0; i < Parameters::m_newBlocksPerTurn; i++ )
			{
				if ( m_lastPieces[i].x == fromX && m_lastPieces[i].y == fromY )
				{
					m_lastPieces[i].x = 69;
				}
			}

			m_turn++;

			draw();	
			
			return true;
		}
	}

	return false;
}
					   

//void Board::writeText(string& text, unsigned int x, unsigned int y, SDL_Color *col) const
//{
//	char* ptr = text.c_str();
//	writeText( ptr, x, y, col );
//}


/** Simple font engine, using the Courier 11 * 18 font...also creating
black outlines */
void Board::writeText(char* text, unsigned int x, unsigned int y, SDL_Color *col) const
{
//	assert( strlen(text) );

	if ( strlen(text) > 0 )
	{
		char c; 

		SDL_Rect charRect;
		
		SDL_Rect destRect;

		SDL_Color *color;

		charRect.w = Parameters::m_fontXSize;
		charRect.h = Parameters::m_fontYSize;

		destRect.y = y;
		destRect.w = Parameters::m_fontXSize;
		destRect.h = Parameters::m_fontYSize;

		// Pick a random color 
		if ( col == &Parameters::m_multiCol )
		{
			switch ( getRnd(0, 3) )
			{
			case 0:
				color = &Parameters::m_red;
				break;
			case 1:
				color = &Parameters::m_green;
				break;
			case 2:
				color = &Parameters::m_blue;
				break;
			case 3:
				color = &Parameters::m_yellow;
				break;
//			case 4:
//				color = &Parameters::m_white;
//				break;
			}
		}
		else
		{
			color = col;
		}


		for (unsigned int i = 0; i < strlen(text); i++, x += Parameters::m_fontXSize )
		{
			c = text[i];

			// We 'know' only some basic characters like SPACE, 0...9, A-Z, a-z
			assert( (c > 31 && c < 91) || (c > 96 && c < 123) );

//			SDL_SetAlpha( m_fontGFX, SDL_SRCALPHA, 128 );			

			SDL_SetColors( m_fontGFX, &Parameters::m_black, 1, 1 );

			// Numerals + miscellaneous
			if (c > 32 && c < 65)
			{
				charRect.y = 0;
				charRect.x = (c - 33) * Parameters::m_fontXSize;

				// Left side
				destRect.y = y + 2;
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Right side
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// LA
				destRect.y = y + 1;
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// RA
				destRect.x = x + 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				destRect.x = x;

				// Above
				destRect.y = y + 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Below
				destRect.x = x;
				destRect.y = y + 3;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );
				
				// LB
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// RB
				destRect.x = x + 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Inner
				SDL_SetColors( m_fontGFX, color, 1, 1 );
//				SDL_SetAlpha( m_fontGFX, SDL_SRCALPHA, 255 );
				destRect.x = x;
				destRect.y = y + 2;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );
			}
			// Capital letters
			else if (c > 64 && c < 91)
			{
				charRect.y = Parameters::m_fontYSize;
				charRect.x = (c - 65) * Parameters::m_fontXSize;

				// Left
				destRect.y = y + 1;
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Right
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				destRect.y = y;// - 1;

				// LA
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// RA
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Above
				destRect.x = x;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Below
				destRect.y = y + 2;//1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// LB
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// RB
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

//				SDL_SetAlpha( m_fontGFX, SDL_SRCALPHA, 255 );

				// Inner
				SDL_SetColors( m_fontGFX, color, 1, 1 );
				destRect.x = x;
				destRect.y = y + 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );
			}
			// Small letters
			else if (c > 96 && c < 123)
			{
				charRect.y = Parameters::m_fontYSize + Parameters::m_fontYSize;
				charRect.x = (c - 97) * Parameters::m_fontXSize;

				// Left
				destRect.y = y;
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Right
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Left Above
				destRect.y = y - 1;
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Right Above
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Above
				destRect.x = x;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Below
				destRect.y = y + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Left Below
				destRect.x = x - 1;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

				// Right Below
				destRect.x = x + 1;				
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );

//				SDL_SetAlpha( m_fontGFX, SDL_SRCALPHA, 255 );

				// Inner
				SDL_SetColors( m_fontGFX, color, 1, 1 );
				destRect.x = x;
				destRect.y = y;
				SDL_BlitSurface( m_fontGFX, &charRect, m_surface, &destRect );
			}

		} // for

//		SDL_Flip( m_surface );
	
	} // if
}


/** Blit a single GFX piece onto the board */
void Board::blitMark(unsigned int x, unsigned int y, unsigned int offset) const
{
	SDL_Rect rect, destRect;
	
	destRect.w = rect.w = Parameters::m_blockXSize;
	destRect.h = rect.h = Parameters::m_blockYSize;

	rect.y = 0;
	rect.x = offset * Parameters::m_blockXSize;

	destRect.x = Parameters::m_boardXOffSet + x * Parameters::m_blockXSize;  
	destRect.y = Parameters::m_boardYOffSet + y * Parameters::m_blockYSize;

	SDL_BlitSurface( m_piecesGFX, &rect, m_surface, &destRect );

	update();
}

