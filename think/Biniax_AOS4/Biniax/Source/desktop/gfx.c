/******************************************************************************
BINIAX GRAPHICS-RELATED IMPLEMENTATIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

/******************************************************************************
INCLUDES
******************************************************************************/

#include <stdlib.h>
#include <stdio.h>

#include "inc.h"

/******************************************************************************
LOCALS
******************************************************************************/

BNX_GFX _Gfx;

/******************************************************************************
FUNCTIONS
******************************************************************************/

BNX_BOOL gfxInit()
{
	SDL_Surface	*temp;

	if ( SDL_Init( SDL_INIT_VIDEO|SDL_INIT_TIMER|SDL_INIT_AUDIO ) < 0 ) 
	{
		return BNX_FALSE;
	}

	_Gfx.screen = 0;
	_Gfx.screen = SDL_SetVideoMode( cGfxScreenX, cGfxScreenY, cGfxColorDepth,
									SDL_SWSURFACE|SDL_ANYFORMAT );
	if ( _Gfx.screen == 0 )
	{
		return BNX_FALSE;
	}

	SDL_ShowCursor( SDL_DISABLE );
	SDL_WM_SetCaption("BINIAX", "");

	/* Load GAME related graphics data */
	temp = SDL_LoadBMP("data/background.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.background = SDL_DisplayFormat(temp);
	if ( _Gfx.background == 0 )
	{
		return BNX_FALSE;
	}
	SDL_FreeSurface(temp);

	// Loading Game Elements
	temp = SDL_LoadBMP("data/element0.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.elements[ 0 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/element1.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.elements[ 1 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/element2.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.elements[ 2 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/element3.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.elements[ 3 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/shield.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.shield = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/cursor0.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.cursors[ 0 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/cursor1.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.cursors[ 1 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/gameover.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.gameover = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);

	/* Load MENU related graphics data */
	temp = SDL_LoadBMP("data/splash.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.splash = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/option0.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.options[ 0 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/option1.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.options[ 1 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = SDL_LoadBMP("data/option2.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.options[ 2 ] = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);

	/* Load FONT related graphics data */
	temp = SDL_LoadBMP("data/font.bmp");
	if ( temp == 0 )
	{
		return BNX_FALSE;
	}
	_Gfx.font = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);

	return BNX_TRUE;
}

void gfxRenderMenu( const BNX_INT16 option )
{
	SDL_Rect	pos;

	pos.x = cGfxOptionX;
	pos.y = cGfxOptionY;

	SDL_BlitSurface( _Gfx.splash, NULL, _Gfx.screen, NULL );
	SDL_BlitSurface( _Gfx.options[ option ], NULL, _Gfx.screen, &pos);
}

void gfxRenderGame( const BNX_GAME *game )
{
	BNX_INT16		i;
	BNX_INT16		j;
	BNX_INT16		tmpx;
	char			text[ 128 ];
	SDL_Rect		pos;
	SDL_Rect		sub;
	static BNX_BOOL	prevIngame = BNX_TRUE;
	static BNX_INT8	cursor = 0;

	if ( prevIngame == BNX_TRUE )
	{
		/* Render In-game screen */
		SDL_BlitSurface( _Gfx.background, NULL, _Gfx.screen, NULL );
		
		pos.y = cGfxZeroY;
		for ( j = 0; j < cGridY; ++j )
		{
			pos.x = cGfxZeroX;
			if ( game->scroll <= cShakeAfter )
			{
				pos.x = cGfxZeroX + (cGfxShake >> 1) - sysRand( cGfxShake );
			}
			if ( game->scroll % cGfxCursorSpeed == 0 )
			{
				cursor = ( cursor + 1 ) % cGfxCursors;
			}

			for ( i = 0; i < cGridX; ++i )
			{
				if ( game->grid[ i ][ j ] != 0 )
				{
					tmpx = pos.x;
					SDL_BlitSurface(_Gfx.elements[pairLeft(game->grid[ i ][ j ])],
									NULL, _Gfx.screen, &pos);
					pos.x += cGfxNextPlusX;
					SDL_BlitSurface(_Gfx.elements[pairRight(game->grid[ i ][ j ])],
									NULL, _Gfx.screen, &pos);
					pos.x = tmpx;
					pos.x += cGfxShieldPlusX;
					SDL_BlitSurface(_Gfx.shield, NULL, _Gfx.screen, &pos);
					pos.x = tmpx;
				}

				pos.x += cGfxPairPlusX;
			}

			pos.y += cGfxPairPlusY;
		}

		pos.x = cGfxZeroX + game->player.x * cGfxPairPlusX;
		pos.y = cGfxZeroY + game->player.y * cGfxPairPlusY;
		SDL_BlitSurface( _Gfx.cursors[cursor], NULL, _Gfx.screen, &pos );

		pos.x = cGfxZeroX + game->player.x * cGfxPairPlusX + cGfxPlayerPlusX;
		pos.y = cGfxZeroY + game->player.y * cGfxPairPlusY;
		SDL_BlitSurface( _Gfx.elements[game->player.e], NULL, _Gfx.screen, &pos );
	}
	else
	{
		/* Make some Game-Over effect */
		for ( i = 0; i < cGfxSpray; ++i )
		{
			pos.x = sysRand( cGfxScreenX );
			pos.y = cGfxInfoBar + sysRand( cGfxScreenY - cGfxInfoBar );
			pos.w = cGfxSpraySize;
			pos.h = cGfxSpraySize;
			SDL_FillRect( _Gfx.screen, &pos, 0 );
		}
		for ( i = 0; i < cGfxSpray >> 2; ++i )
		{
			sub.x = sysRand( _Gfx.gameover->w - cGfxSpraySize );
			sub.y = sysRand( _Gfx.gameover->h - cGfxSpraySize );
			sub.w = cGfxSpraySize;
			sub.h = cGfxSpraySize;
			pos.x = cGfxGameoverX + sub.x;
			pos.y = cGfxGameoverY + sub.y;
			SDL_BlitSurface( _Gfx.gameover, &sub, _Gfx.screen, &pos );
		}
	}

	switch ( game->message )
	{
		case cTextIngameScore :
			sprintf( text, "SCORE : %d", game->score );
			gfxPrintText( cGfxScoreX, cGfxScoreY, text );
			sprintf( text, "BEST : %d", game->best );
			gfxPrintText( cGfxBestX, cGfxBestY, text );
			break;
		case cTextGameOver :
			sprintf( text, "GAME OVER, SCORE : %d", game->score );
			gfxPrintText( cGfxScoreX, cGfxScoreY, text );
			break;
		case cTextBestScore :
			sprintf( text, "CONGRATULATIONS : %d", game->best );
			gfxPrintText( cGfxScoreX, cGfxScoreY, text );
			break;
		default :
			break;
	}

	prevIngame = game->ingame;
}

void gfxPrintText( BNX_INT16 x, BNX_INT16 y, const char *text )
{
	char		c;
	SDL_Rect	tpos, ppos;

	ppos.x = x;
	ppos.y = y;
	ppos.w = cGfxFontSizeX;
	ppos.h = cGfxFontSizeY;
	tpos.w = cGfxFontSizeX;
	tpos.h = cGfxFontSizeY;

	while ( *text != '\0' )
	{
		c = *text - ' ';
		tpos.x = ( ((BNX_INT16)(c)) % cGfxFontTileX ) * cGfxFontSizeX;
		tpos.y = ( ((BNX_INT16)(c)) / cGfxFontTileX ) * cGfxFontSizeY;
		SDL_BlitSurface( _Gfx.font, &tpos, _Gfx.screen, &ppos );
		ppos.x += cGfxFontSizeX;
		text ++;
	}
}

void gfxUpdate()
{
	SDL_Flip( _Gfx.screen );
}

