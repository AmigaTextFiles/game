/*
 * Don Ceferino Hazaña - video game similary to Super Pang!
 * Copyright (c) 2004, 2005 Hugo Ruscitti
 * web site: http://www.loosersjuegos.com.ar
 * 
 * This file is part of Don Ceferino Hazaña (ceferino).
 * Written by Hugo Ruscitti <hugoruscitti@yahoo.com.ar>
 *
 * Don Ceferino Hazaña is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Don Ceferino Hazaña is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 * 
 */


#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <string.h>
#include "comojugar.h"
#include "mundo.h"
#include "grafico.h"
#include "utils.h"
#include "int.h"

comojugar :: comojugar(void)
{
	strcpy(mensaje,_("how to play"));
	
	paso = 0;
	pos = 0;
	posy_letra = 0;
	posx_letra = 0;
}

comojugar :: ~comojugar(void)
{
	SDL_FreeSurface(fondo);
}


/*!
 * \brief genera la escena como jugar
 *
 * return 1 en caso de error
 */
int comojugar :: iniciar(class mundo *_pmundo, int _modo_video, SDL_Surface *_screen)
{
	SDL_Rect rect;
	pmundo = _pmundo;
	screen = _screen;
	fondo = SDL_DisplayFormat(screen);

	pmundo->libgrafico.ima_menu_oscuro->imprimir(0, fondo, &rect, 0, 0, 1);
	pmundo->libgrafico.ima_how_to_play->imprimir(0, fondo, &rect, 0, 0, 1);
	
	SDL_BlitSurface(fondo, NULL, screen, NULL);
	SDL_Flip(screen);

	return 0;
}


/*!
 * \brief actualiza los textos que se muestran en pantalla
 */
void comojugar :: actualizar(void)
{
	Uint8 *tecla;

	tecla = SDL_GetKeyState(NULL);

	if (paso>5)
	{
		if (mensaje[pos] != '\0')
		{
			if (mensaje[pos] != '#')
			{
				imprimir_caracter(mensaje[pos], \
						10 + posx_letra*26, \
						20 + posy_letra * 33, 0);
				posx_letra++;
			}
			else
			{
				posx_letra=0;
				posy_letra++;
			}
			
			pos++;
			paso=0;
		}
	}
	
	paso++;

	
	if (tecla[SDLK_SPACE] || tecla[SDLK_ESCAPE])
		pmundo->cambiar_escena(MENU);
}


/*!
 * \brief impresion programada desde mundo
 */
void comojugar:: imprimir(void)
{
}


/*!
 * \brief imprime un caracter en pantalla
 */
void comojugar :: imprimir_caracter(char letra, int x, int y, int resaltar)
{
	SDL_Rect rect;
	
	switch (letra)
	{
		case ' ':
			rect.x=0;
			rect.y=0;
			rect.w=1;
			rect.h=1;
			break;
			
		case '.':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					36+resaltar*40,screen, &rect, x, y, 1);
			break;

		case ':':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					37+resaltar*40,screen, &rect, x, y, 1);
			break;
			
		case '(':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					38+resaltar*40,screen, &rect, x, y, 1);
			break;
				
		case ')':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					39+resaltar*40, screen, &rect, x, y, 1);
			break;

		default:
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					letra - 'a'+resaltar*40, screen,\
					&rect, x, y, 1);
			break;
	}

	SDL_UpdateRect(screen, rect.x, rect.y, rect.w, rect.h);
}

void comojugar :: pausar(void)
{
}
