#include <SDL/sdl.h>
 
#include <cstdlib> // exit()
#include <assert.h>

#include "parameters.h"
#include "highscores.h"
#include "board.h"


/** Game states */
enum {
    PLAYING = 0,
    NEW_GAME,
    GAME_OVER,
    QUIT,
    IDLE
};


/** For level requirements */
struct Level {
    unsigned int level;
    unsigned int score;
};


/** Level number and score requirement */
Level levels[6] =
{
    1, 500, // basic levels, including the black piece
    2, 1500,
    3, 2000, // Add one color (brown -yuk!) - should make game a lot harder
    4, 3000,
    5, 5000,
    6, 10000
};


void idle(Board* board);
unsigned int handleEvents(Board* board, unsigned int gameState);
string askName(Board* board);


/** Out of comments right now */
int main( int argc, char* argv[] )
{
    Board* board;
    bool gameOn = true;
    int gameState = IDLE;

    // Initialize SDL
    if ( (SDL_Init( SDL_INIT_VIDEO /*| SDL_INIT_AUDIO*/ ) == -1 ) )
    { 
        printf("Could not initialize SDL: %s.\n", SDL_GetError() );
        return -1;
    }

    // Create singleton, loads highscores etc...
    Highscores::instance();

    board = new Board();

    if ( board )
    {
        if ( board->init() )
        {
            board->clear();
            
            while( gameOn )
            {

                switch( gameState )
                {

                case NEW_GAME:
                    board->clear();
                    board->setUndo( true );
                    board->nextTurn();
                    board->nextTurn();
                    board->draw();
                    gameState = PLAYING;
                    break;

                case PLAYING:
                    gameState = handleEvents( board, gameState );
                    break;

                case GAME_OVER:
                    gameState = IDLE; 
                    break;

                case QUIT:
                    gameOn = false;
                    break;

                case IDLE:
                    idle( board );
                    gameState = NEW_GAME;
                    break;

                default:
                    assert( false );

                } // switch

            } // while

        } // if
		else
		{
			delete board;
		}

    } // if

    // Destroy singleton
    delete Highscores::instance();

    // Shutdown the SDL
    SDL_Quit();

    return 0;
}


/** Show highscores and wait for input */
void idle(Board* board)
{
    SDL_Event event;
    bool ready = false;

    board->draw();

    while ( !ready )
    {
        board->demo( 50 );

        if ( SDL_PollEvent(&event) )
        {
            switch ( event.type )
            {
            case SDL_MOUSEBUTTONDOWN:
            case SDL_KEYDOWN:
            case SDL_QUIT:
                ready = true;
                break;
            } // switch-case
        } // if
    } // while
}


/** Handle mouse moving while playing */
unsigned int handleEvents(Board* board, unsigned int gameState)
{
    SDL_Event event; 
    unsigned int state = gameState;
    unsigned int fromX, fromY;
    bool loop = true;
    bool mouseDown = false;

    /* Loop waiting for ESC+Mouse_Button */
    //while ( SDL_WaitEvent(&event) > 0 && loop )
    while ( loop )
    {
        while ( ! SDL_PollEvent(&event) )
        {
            SDL_Delay(50);
        }

        switch (event.type) {
                    
            case SDL_MOUSEBUTTONDOWN:
            {
                fromX = (unsigned int)(Parameters::m_xSize * ( (float)(event.motion.x - Parameters::m_boardXOffSet) / Parameters::m_boardXSize ));
                fromY = (unsigned int)(Parameters::m_ySize * ( (float)(event.motion.y - Parameters::m_boardYOffSet) / Parameters::m_boardYSize ));                      
                
                mouseDown = true;
            }
            break;

            case SDL_MOUSEMOTION:
            {
                if ( mouseDown )
                {
                    // Help player to see if he/she is able to move a block with a visual clue...

                    unsigned int toX = (unsigned int)(Parameters::m_xSize * ( (float)(event.motion.x - Parameters::m_boardXOffSet ) / Parameters::m_boardXSize ));
                    unsigned int toY = (unsigned int)(Parameters::m_ySize * ( (float)(event.motion.y - Parameters::m_boardYOffSet ) / Parameters::m_boardYSize ));

                    if ( fromX >= 0 && fromX < Parameters::m_xSize
                        && fromY >= 0 && fromY < Parameters::m_ySize
                        && toX >= 0 && toX < Parameters::m_xSize
                        && toY >= 0 && toY < Parameters::m_ySize )
                    {
						static unsigned int lastTX = 0;
						static unsigned int lastTY = 0;

                        unsigned int fromPiece = board->get(fromX, fromY);
                        unsigned int toPiece = board->get(toX, toY);
						
						// Draw again only, when cursor is in a new place
						if ( lastTX != toX || lastTY != toY )
						{
							board->blitMark( lastTX, lastTY, board->get(lastTX,lastTY) );

							lastTX = toX;
							lastTY = toY;

	                        //board->draw();
							// Re-draw only old piece, not the whole board!
							board->blitMark( fromX, fromY, fromPiece );
							
	                        if ( NONE != fromPiece && BLACK != fromPiece ) {
                            
    	                        if ( NONE == toPiece && abs( (int) (fromX - toX) ) < 2 && abs( (int) (fromY - toY) ) < 2 )
   	                         	{   
                                	board->blitMark( toX, toY, OK );
    	                        }
        	                    else
            	                {
                  	            	board->blitMark( toX, toY, NOT_OK );
                            	}   
                        	}
                        	else
                        	{
                            	board->blitMark( toX, toY, NOT_OK );
                        	}

						}                       
                    }
                }
                
                // On New Game button?
                if ( event.motion.x > 99 && event.motion.x < 188 
                    && event.motion.y > 236 && event.motion.y < 254 )
                {
                    board->blitNewGame( &Parameters::m_white );
                    board->update();
                }
                else
                {
                    board->blitNewGame( &Parameters::m_yellow );
                    board->update();                
                }

                // On UNDO button?
                if ( board->getUndo() && board->getTurn() > 0 )
                { 
                    if ( event.motion.x > 15 && event.motion.x < 60 
                        && event.motion.y > 236 && event.motion.y < 254 )
                    {
                        board->blitUndo( &Parameters::m_white );
                    }
                    else
                    {
                        board->blitUndo( &Parameters::m_yellow );
                    }
                    board->update();
                }
            }
            break;

            case SDL_MOUSEBUTTONUP:
            {
                mouseDown = false;
                board->draw();

                // Move a block?

                unsigned int toX = (unsigned int)(Parameters::m_xSize * ( (float)(event.motion.x - Parameters::m_boardXOffSet ) / Parameters::m_boardXSize ));
                unsigned int toY = (unsigned int)(Parameters::m_ySize * ( (float)(event.motion.y - Parameters::m_boardYOffSet ) / Parameters::m_boardYSize ));

                if ( fromX >= 0 && fromX < Parameters::m_xSize
                    && fromY >= 0 && fromY < Parameters::m_ySize
                    && toX >= 0 && toX < Parameters::m_xSize
                    && toY >= 0 && toY < Parameters::m_ySize )
                {
                    if ( board->getFree() > 0 && board->moveBlock(fromX, fromY, toX, toY) )
                    {
                        board->checkBoard();
                        
                        // Check winning!
//                      if ( Parameters::m_xSize * Parameters::m_ySize - board->getFree() < 5 )
//                      {
//                          break;
//                      }

                        board->nextTurn();

                        board->checkBoard();

                        // Check level requirements
                        if ( board->getScore() >= levels[ board->getLevel() - 1].score )
                        {
                            board->setLevel( board->getLevel() + 1 );
                            
                            char buf[8];
                            
                            sprintf( buf, "Level %1d", board->getLevel() );

                            board->writeText( "Welcome to", (unsigned int)(0.5 * ( Parameters::m_windowXSize - strlen( "Welcome to" ) * Parameters::m_fontXSize) ),
                                110, &Parameters::m_green );

                            board->writeText( buf, (unsigned int)(0.5 * ( Parameters::m_windowXSize - strlen( buf ) * Parameters::m_fontXSize ) ),
                                130, &Parameters::m_blue );

                            board->update();

                            SDL_Delay( 3000 );

                            board->draw();

                        } // if                 
                    } // if
                } 
                // QUIT
                else if ( event.motion.x > Parameters::m_windowXSize - 16 && event.motion.y < 16)
                {
                    state = QUIT;
                    loop = false;
                }
                // NEW GAME
                else if ( event.motion.x > 99 && event.motion.x < 188 
                    && event.motion.y > 236 && event.motion.y < 254 )
                {
                    state = NEW_GAME;
                    loop = false;
                }
                // UNDO
                else if ( board->getUndo() && event.motion.x > 15 && event.motion.x < 60 
                    && event.motion.y > 236 && event.motion.y < 254 )
                {
                    board->undo();
                }

            }
            break;

            case SDL_QUIT:
            {
                state = QUIT;
                loop = false;
            }
            break;

        } // switch-case


        unsigned int free = board->getFree();

        // Board full, Game over then...or less than 5 pieces left -> Victory!
        if ( 0 == free /*|| (Parameters::m_xSize * Parameters::m_ySize - free < 5 && board->getTurn() > 0)*/ )
        {
            unsigned int index, score;

            score = board->getScore();

            if ( 0 == free )
            {
                board->writeText( "Game Over", (Parameters::m_windowXSize - strlen("Game Over") * Parameters::m_fontXSize) / 2, 70, &Parameters::m_red );
            }
//          else
//          {
//              board->writeText( "Congratulations", (Parameters::m_windowXSize - strlen("Congratulations") * Parameters::m_fontXSize) / 2, 70, &Parameters::m_red );
//          }

            char buf[5];
            sprintf(buf, "%d", board->getTurn() );

            board->writeText( "Turn Bonus", (Parameters::m_windowXSize - strlen("Turn Bonus") * Parameters::m_fontXSize) / 2, 90, &Parameters::m_green );

            board->writeText( buf, (Parameters::m_windowXSize - strlen(buf) * Parameters::m_fontXSize) / 2, 110, &Parameters::m_blue );

            score += board->getTurn();

            board->update();

            SDL_Delay( 5000 );

            if ( (index = Highscores::instance()->isNewHiscore( score ) ) < Parameters::m_hiscores )
            {
                Highscore highscore;
                highscore.name = askName( board );
                highscore.score = score;

                Highscores::instance()->updateList( highscore, index );
            }

            state = GAME_OVER;
            loop = false;
        } // if

    } // while

    return state;
}


/** Map a key press to an ASCII code */
char findKey(SDL_keysym& keysym)
{
    typedef struct {
        SDLKey key;
        char c;
    } charMap;
    
    charMap small[] = {
        SDLK_a, 'a',
        SDLK_b, 'b',
        SDLK_c, 'c',
        SDLK_d, 'd',
        SDLK_e, 'e',
        SDLK_f, 'f',
        SDLK_g, 'g',
        SDLK_h, 'h',
        SDLK_i, 'i',
        SDLK_j, 'j',
        SDLK_k, 'k',
        SDLK_l, 'l',
        SDLK_m, 'm',
        SDLK_n, 'n',
        SDLK_o, 'o',
        SDLK_p, 'p',
        SDLK_q, 'q',
        SDLK_r, 'r',
        SDLK_s, 's',
        SDLK_t, 't',
        SDLK_u, 'u',
        SDLK_v, 'v',
        SDLK_w, 'w',
        SDLK_x, 'x',
        SDLK_y, 'y',
        SDLK_z, 'z'
    };

    charMap capitals[] = {
        SDLK_a, 'A',
        SDLK_b, 'B',
        SDLK_c, 'C',
        SDLK_d, 'D',
        SDLK_e, 'E',
        SDLK_f, 'F',
        SDLK_g, 'G',
        SDLK_h, 'H',
        SDLK_i, 'I',
        SDLK_j, 'J',
        SDLK_k, 'K',
        SDLK_l, 'L',
        SDLK_m, 'M',
        SDLK_n, 'N',
        SDLK_o, 'O',
        SDLK_p, 'P',
        SDLK_q, 'Q',
        SDLK_r, 'R',
        SDLK_s, 'S',
        SDLK_t, 'T',
        SDLK_u, 'U',
        SDLK_v, 'V',
        SDLK_x, 'X',
        SDLK_y, 'Y',
        SDLK_z, 'Z'
    };

    charMap misc[] = {
        SDLK_0, '0',
        SDLK_1, '1',
        SDLK_2, '2',
        SDLK_3, '3',
        SDLK_4, '4',
        SDLK_5, '5',
        SDLK_6, '6',
        SDLK_7, '7',
        SDLK_8, '8',
        SDLK_9, '9',
        SDLK_SPACE, ' ',
        SDLK_EXCLAIM, '!',
        SDLK_QUOTEDBL, '\"',
        SDLK_HASH, '#',
        SDLK_DOLLAR, '$',
        SDLK_AMPERSAND, '&',
//      SDLK_PROCENT, '%',
        SDLK_QUOTE, '\'',
        SDLK_LEFTPAREN, '(',
        SDLK_RIGHTPAREN, ')',
        SDLK_ASTERISK, '*',
        SDLK_PLUS, '+',
        SDLK_MINUS, '-',
        SDLK_COMMA, ',',
        SDLK_PERIOD, '.',
        SDLK_SLASH, '/',
        SDLK_AT, '@',
        SDLK_COLON, ':',
        SDLK_SEMICOLON, ';',
        SDLK_LESS, '<',
        SDLK_GREATER, '>',
        SDLK_QUESTION, '?'
    };


    // Search for char
    int i;
    for ( i = 0; i < 25; i++ )
    {
        if ( small[i].key == keysym.sym )
        {
            // Check if we need to return a capital letter
            if ( keysym.mod & KMOD_CAPS || keysym.mod & KMOD_SHIFT )
            {
                return capitals[i].c;               
            }

            return small[i].c;
        }
    }

    // Check for numerals and space
    for ( i = 0; i < 31; i++ )
    {
        if ( misc[i].key == keysym.sym )
        {
            return misc[i].c;
        }
    }

    return '\0'; // Shifts etc are not interpreted as char input!
}


/** Prompt for a name */
string askName(Board* board)
{
    SDL_Event event;

    bool loop = true;
    string name = "";
    //static char name[7] = { 0 };

    unsigned int chars = 0;

    board->draw();

    board->writeText( "Enter your name", 21, 70, &Parameters::m_blue );
    
    board->writeText( "......", 21, 110, &Parameters::m_white );

    board->writeText( "And press ENTER", 21, 150, &Parameters::m_green );

    board->update();

    /* Wait for character input or Enter */
    while ( loop /*&& SDL_WaitEvent(&event) >= 0*/  )
    {
        while ( !SDL_PollEvent(&event) )
        {
            SDL_Delay( 50 );
        }

        switch (event.type) {

            case SDL_KEYDOWN:
                
                switch ( event.key.keysym.sym )
                {

                case SDLK_ESCAPE:
                case SDLK_RETURN:
                    loop = false;
                    break;

                case SDLK_BACKSPACE:
                    if ( chars > 0 )
                    {
                        chars--;
                        name.erase( name.length()-1, 1 );
                        //name[chars] = '\0';
                        board->draw();

                        board->writeText( "Enter your name", 21, 70, &Parameters::m_blue );
                        
                        board->writeText( const_cast<char*>(name.c_str()), 21, 110, &Parameters::m_white );

                        board->writeText( "And press ENTER", 21, 150, &Parameters::m_green );

                        board->update();
                    }
                    break;

                default:

                    if (chars < 6)
                    {
                        char ch = findKey( event.key.keysym );
                        
                        if ( 0 != ch )
                        {
                            chars++;
                            name += ch;
                            //name[chars] = ch;

                            board->draw();

                            board->writeText( "Enter your name", 21, 70, &Parameters::m_blue ); 

                            board->writeText( const_cast<char*>(name.c_str()), 21, 110, &Parameters::m_white );

                            board->writeText( "And press ENTER", 21, 150, &Parameters::m_green );

                            board->update();
                        }
                    }
                    break;
                
                } // inner switch

                break;

        } // switch-case

    } // while

    return name;
}
