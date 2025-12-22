/******************************************************************************
                                      biniax
		            			        by
					              Jordan Tuzsuzov

                               http://www.biniax.com

- VERSION :
Implements gameplay revision 1.0;
Game version 1.2 (4+1 keys control (directions+select/menu), new/continue/quit)
Program version 1.2 (ANSI C);


- WHAT IS THIS :
This program is an ANSI C version of "Biniax" computer game. This is the 
"Biniax-Classic" implementation with pure game logic and without in-game
bonuses, speed-ups, multiplayer, etc. The goad of "Biniax-Classic" is to
define minimalistic computer game, which can be "stand-alone" game, but
also a basis of new complex arcade or logical games of "Biniax" family.

- REALIZATION AND SUPPORTED PLATFORMS :
The code is structured as a game core (this file and the header files from the
root of the project) and computer/OS - related parts of code in respective
folders :
/desktop	for OS with support of SDL (Windows, Linux, BSD, MacOS, Solaris);
/pocketpc	for WindowsCE 3.0 and higher (supported by EasyCE);
/symbian	for Symbian based PDAs and smartphones;
/embXXX		for specific embedded hardware;		

- LICENSE :
This program is Copyright Jordan Tuzsuzov. You can read the code and take any
parts of it to use it as you want, but not the game itself. You are not able 
to modify and redistribute the game as "Biniax" or clone of it without the 
permission of the author.

- COPYRIGHT :
Biniax game (as a gameplay and rules), art and name "Biniax" are Copyright 
Jordan Tuzsuzov, (C) 2005.

- CONTACTS :
Email : jordan@biniax.com
Web : www.biniax.com
******************************************************************************/

/******************************************************************************
INCLUDES
******************************************************************************/

#include "game.h"
#include "inc.h"

/* Global instance of GAME structure */
BNX_GAME Game;

/******************************************************************************
ALL FUNCTIONS IN THE MODULE
******************************************************************************/

void initGame( BNX_GAME *game );
void initPlayer( BNX_GAME *game );
void initGrid( BNX_GAME *game, BNX_INT16 lines );
BNX_UINT8 initPair( BNX_UINT8 maxel );
void initLine( BNX_GAME *game, BNX_INT16 line );
BNX_BOOL scrollDown( BNX_GAME *game );

BNX_BOOL canTake( BNX_GAME *game, BNX_INT16 x, BNX_INT16 y );
BNX_BOOL takePair( BNX_GAME *game, BNX_INT16 x, BNX_INT16 y );
BNX_BOOL moveUp( BNX_GAME *game );
BNX_BOOL moveDown( BNX_GAME *game );
BNX_BOOL moveLeft( BNX_GAME *game );
BNX_BOOL moveRight( BNX_GAME *game );

BNX_BOOL gameSession( BNX_GAME *game );
BNX_INT16 mainMenu( BNX_GAME *game );

BNX_BOOL saveGame( BNX_GAME *game );
BNX_BOOL loadGame( BNX_GAME *game );
BNX_BOOL saveHiScore( BNX_GAME *game );
BNX_BOOL loadHiScore( BNX_GAME *game );

/******************************************************************************
PROGRAM START
******************************************************************************/

int main( int argc, char *argv[] )
{
	BNX_BOOL	bquit		= BNX_FALSE;
	BNX_BOOL	bautoSave	= BNX_TRUE;
	BNX_INT16	nmenu		= 0;

	if ( gfxInit() == BNX_FALSE )
		return -1;
	if ( sysInit() == BNX_FALSE )
		return -2;
	if ( inpInit() == BNX_FALSE )
		return -3;
	if ( sndInit() == BNX_FALSE )
		return -4;
	
	while ( bquit == BNX_FALSE )
	{
		/* Proceed menu */
		nmenu = mainMenu( &Game );
		switch ( nmenu )
		{
			case cOptionContinue:
				if ( loadGame( &Game ) == BNX_FALSE )
				{
					initGame( &Game );
				}
				loadHiScore( &Game );
				break;
			case cOptionNew:
				initGame( &Game );
				loadHiScore( &Game );
				break;
			case cOptionQuit:
				bquit = BNX_TRUE;
				continue;
			default:
				break;
		}

		/* Play one game session */
		bautoSave = gameSession( &Game );
		if ( bautoSave == BNX_TRUE )
		{
			saveGame( &Game );
		}
	}

	return 0;
}

/******************************************************************************
GAME INIT
******************************************************************************/

void initGame( BNX_GAME *game )
{
	initPlayer( game );
	initGrid( game, cInitLines );

	game->ingame	= BNX_TRUE;
	game->score		= 0;
	game->scroll	= cMaxScroll;
	game->speed		= cMaxScroll;
	game->message	= cTextIngameScore;
}

void initPlayer( BNX_GAME *game )
{
	game->player.x = 0;
	game->player.y = 0;
	game->player.e = ( BNX_INT8 ) sysRand( cMaxElements );
}

void initGrid( BNX_GAME *game, BNX_INT16 lines )
{
	BNX_INT16	x;
	BNX_INT16	y;

	for ( y = 0; y < cGridY; ++y )
	{
		for ( x = 0; x < cGridX; ++x )
		{
			game->grid[ x ][ y ] = 0;
		}
	}

	for ( y = 0; y < lines; ++y )
	{
		scrollDown( game );
	}
}

BNX_UINT8 initPair( BNX_UINT8 maxel )
{
	BNX_UINT8	left;
	BNX_UINT8	right;
	left = ( BNX_INT8 ) sysRand( maxel );
	do 
	{
		right = ( BNX_UINT8 ) sysRand( maxel );
	} 
	while ( left == right );

	return ((left << 4) | right);
}

void initLine( BNX_GAME *game, BNX_INT16 line )
{
	BNX_INT16	x;

	for ( x = 0; x < cGridX; ++x )
	{
		game->grid[ x ][ line ] = initPair( cMaxElements );
	}
	game->grid[ sysRand( cGridX ) ][ line ] = 0;
}

BNX_BOOL scrollDown( BNX_GAME *game )
{
	BNX_INT16	x;
	BNX_INT16	y;
	BNX_BOOL	ingame = BNX_TRUE;

	for ( y = 0; y < cGridY - 1; ++y )
	{
		for ( x = 0; x < cGridX; ++x )
		{
			game->grid[ x ][ y ] = game->grid[ x ][ y + 1 ];
		}
	}
	initLine( game, cGridY - 1 );

	if ( game->ingame == BNX_TRUE )
	{
		if ( game->player.y > 0 )
		{
			game->player.y --;
		}
		else if ( takePair( game, game->player.x, game->player.y )==BNX_FALSE )
		{
			game->player.y --;
			ingame = BNX_FALSE;
		}
	}

	return ingame;
}

/******************************************************************************
ACTIONS
******************************************************************************/

BNX_BOOL canTake( BNX_GAME *game, BNX_INT16 x, BNX_INT16 y )
{
	BNX_UINT8	pair = game->grid[ x ][ y ];

	if ( pair == 0 )
		return BNX_TRUE;

	if ( pairLeft( pair )==game->player.e || pairRight( pair )==game->player.e )
		return BNX_TRUE;
	else
		return BNX_FALSE;
}

BNX_BOOL takePair( BNX_GAME *game, BNX_INT16 x, BNX_INT16 y )
{
	BNX_UINT8	pair = game->grid[ x ][ y ];
	BNX_BOOL	cantake = BNX_FALSE;

	if ( pair == 0 )
		return BNX_TRUE;

	if ( pairLeft( pair ) == game->player.e ) 
	{
		game->player.e = pairRight( pair );
		cantake = BNX_TRUE;
	}
	else if ( pairRight( pair ) == game->player.e )
	{
		game->player.e = pairLeft( pair );
		cantake = BNX_TRUE;
	}
	else
	{
		cantake = BNX_FALSE;
	}

	if ( cantake == BNX_TRUE )
	{
		game->grid[ x ][ y ] = 0;
		game->score += cScoreStep;
	}

	return cantake;
}

BNX_BOOL moveUp( BNX_GAME *game )
{
	BNX_PLAYER	*p = &game->player;
	BNX_INT8	newY = p->y + 1;

	if ( newY < cGridY )
	{
		if ( takePair( game, p->x, newY ) == BNX_TRUE )
		{
			p->y = newY;
			return BNX_TRUE;
		}
	}

	return BNX_FALSE;
}

BNX_BOOL moveDown( BNX_GAME *game )
{
	BNX_PLAYER	*p = &game->player;
	BNX_INT8	newY = p->y - 1;

	if ( newY >= 0 )
	{
		if ( takePair( game, p->x, newY ) == BNX_TRUE )
		{
			p->y = newY;
			return BNX_TRUE;
		}
	}

	return BNX_FALSE;
}

BNX_BOOL moveLeft( BNX_GAME *game )
{
	BNX_PLAYER	*p = &game->player;
	BNX_INT8	newX = p->x - 1;

	if ( newX >= 0 )
	{
		if ( takePair( game, newX, p->y ) == BNX_TRUE )
		{
			p->x = newX;
			return BNX_TRUE;
		}
	}

	return BNX_FALSE;
}

BNX_BOOL moveRight( BNX_GAME *game )
{
	BNX_PLAYER	*p = &game->player;
	BNX_INT8	newX = p->x + 1;

	if ( newX < cGridX )
	{
		if ( takePair( game, newX, p->y ) == BNX_TRUE )
		{
			p->x = newX;
			return BNX_TRUE;
		}
	}

	return BNX_FALSE;
}

void correctSpeed( BNX_GAME *game )
{
	BNX_INT32 scrollRange = cMaxScroll - cMinScroll;
	BNX_INT32 speedIndex = (scrollRange << 8) / cMaxSpeedScore;

    if ( game->score < cMaxSpeedScore )
    {
		game->speed = cMaxScroll - ( ( game->score * speedIndex ) >> 8 );
    }
	else
	{
		game->speed = cMinScroll;
	}
}

/******************************************************************************
GAME SESSION
******************************************************************************/

BNX_BOOL gameSession( BNX_GAME *game )
{
	BNX_BOOL	bgameSes = BNX_TRUE;
	BNX_BOOL	bautoSave = BNX_TRUE;
	BNX_INT32	startTime;
	BNX_INT32	prevScore;
	BNX_INT8	sndType;
	BNX_BOOL	flagTake;
	BNX_BOOL	flagMove;
	BNX_BOOL	prevIngame;

	while ( bgameSes )
	{
		startTime = sysGetTime();

		sndType = cSndNone;
		flagTake = BNX_FALSE;
		flagMove = BNX_TRUE;

		// Handle user input
		inpUpdate();
		if ( inpKeyA() || inpKeyB() )
		{
			bgameSes = BNX_FALSE;
			bautoSave = game->ingame;
		}
		if ( game->ingame == BNX_TRUE )
		{
			prevScore = game->score;
			if ( inpKeyLeft() )
			{
				flagTake = moveLeft( game );
			}
			else if ( inpKeyRight() )
			{
				flagTake = moveRight( game );
			}
			else if ( inpKeyUp() )
			{
				flagTake = moveUp( game );
			}
			else if ( inpKeyDown() )
			{
				flagTake = moveDown( game );
			}
			else
			{
				flagMove = BNX_FALSE;
			}
			// Play respective sound
			game->sounds = cSndNone;
			if ( flagMove == BNX_TRUE && flagTake == BNX_TRUE )
			{
				if ( prevScore < game->score )
				{
					game->sounds |= soundMask( cSndTake );
				}
			}
			else if ( flagMove == BNX_TRUE && flagTake == BNX_FALSE )
			{
				game->sounds |= soundMask( cSndFail );
			}
		}
		
		// Detect shake start. Don't *play* shake at high speed
		if ( game->scroll == cShakeAfter && game->score < cMaxSpeedScore )
		{
			game->sounds |= soundMask( cSndShake );
		}

		// Move the field and determinate Game Over
		if ( game->ingame == BNX_TRUE && ( -- ( game->scroll ) ) <= 0 )
		{
			prevIngame = game->ingame;
			game->ingame = scrollDown( game );

			if ( prevIngame == BNX_TRUE && game->ingame == BNX_FALSE )
			{
				if ( game->best < game->score )
				{
					game->best = game->score;
					game->message = cTextBestScore;
					saveHiScore( game );
				}
				else
				{
					game->message = cTextGameOver;
				}
			}

			game->sounds |= soundMask( cSndScroll );
			game->scroll = game->speed;
			correctSpeed( game );
		}

		// Render the game screen
		gfxRenderGame( game );
		gfxUpdate();

		// Play the sounds on this step
		sndPlay( game );
		sndUpdate();

		// Synchronize with the clock
		while ( sysGetTime() - startTime < cDeltaTime )
		{
			sysUpdate();
		}
	}

	return bautoSave;
}

/******************************************************************************
MAIN MENU
******************************************************************************/

BNX_INT16 mainMenu( BNX_GAME *game )
{
	BNX_INT16 option = 0;

	do
	{
		inpUpdate();
		if ( inpKeyLeft() || inpKeyUp() )
		{
			option = ( option + cMaxOptions - 1 ) % cMaxOptions;
			game->sounds |= soundMask( cSndFail );
		}
		else if ( inpKeyRight() || inpKeyDown() )
		{
			option = ( option + 1 ) % cMaxOptions;
			game->sounds |= soundMask( cSndFail );
		}

		gfxRenderMenu( option );
		gfxUpdate();
		sndPlay( game );
		sndUpdate();
		sysUpdate();
	}
	while ( inpKeyA() == BNX_FALSE );

	return option;
}

/******************************************************************************
GAME AND HISCORE SAVE / RESTORE
******************************************************************************/

BNX_BOOL saveGame( BNX_GAME *game )
{
	FILE		*file;

	file = fopen( "autosave.bnx", "wb" );

	if ( file == (FILE *) NULL )
		return BNX_FALSE;

	fwrite( game, 1, sizeof( BNX_GAME ), file );

	fclose( file );

	return BNX_TRUE;
}

BNX_BOOL loadGame( BNX_GAME *game )
{
	FILE		*file;

	file = fopen( "autosave.bnx", "rb" );

	if ( file == (FILE *) NULL )
		return BNX_FALSE;

	fread( game, 1, sizeof( BNX_GAME ), file );

	fclose( file );

	return BNX_TRUE;
}

BNX_BOOL saveHiScore( BNX_GAME *game )
{
	BNX_INT32	test;
	FILE		*file;

	file = fopen( "hiscore.bnx", "wb" );

	if ( file == (FILE *) NULL )
		return BNX_FALSE;

	test = game->best + 1;
	fwrite( &game->best, 1, sizeof( game->best ), file );
	fwrite( &test, 1, sizeof( test ), file );

	fclose( file );

	return BNX_TRUE;
}

BNX_BOOL loadHiScore( BNX_GAME *game )
{
	BNX_INT32	test;
	FILE		*file;

	game->best = 0;

	file = fopen( "hiscore.bnx", "rb" );

	if ( file == (FILE *) NULL )
		return BNX_FALSE;

	fread( &game->best, 1, sizeof( game->best ), file );
	fread( &test, 1, sizeof( game->best ), file );
	if ( test-1 != game->best )
	{
		game->best = 0;
		return BNX_FALSE;
	}

	fclose( file );

	return BNX_TRUE;
}

