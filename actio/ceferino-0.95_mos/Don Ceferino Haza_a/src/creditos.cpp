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


///etapas de la sección creditos
enum {INICIAL, WEB, GPL};


#include <SDL/SDL.h>
#include <string.h>

#include "menu.h"
#include "mundo.h"
#include "grafico.h"
#include "utils.h"
#include "int.h"

/*!
 * \brief asigna los valores iniciales al menu creditos
 */
creditos :: creditos(void)
{
	f=0;
	c=0;
	pausa=0;
	delay=0;
	etapa=INICIAL;
	limite=86;	

	fila_letra=0;
	columna_letra=0;
	color=0;
}

creditos :: ~creditos(void)
{
	SDL_FreeSurface(fondo);
}

/*!
 * \brief genera la escena
 *
 * \return 1 en caso de error
 */
int creditos :: iniciar(class mundo *_pmundo, int _modo_video, SDL_Surface *_screen)
{

	SDL_Rect rect;	
	
	pmundo = _pmundo;
	modo_video = _modo_video;
	screen = _screen;
	

	fondo = SDL_DisplayFormat(screen);

	if (fondo == NULL)
	{
		printf(_("error: Can't copy screen: '%s'\n"), SDL_GetError());
		return 1;
	}

	cambiar_etapa(INICIAL);
	
	pmundo->libgrafico.ima_menu_oscuro->imprimir(0, fondo, &rect, 0, 0, 1);
	SDL_BlitSurface(fondo, NULL, screen, NULL);
	SDL_Flip(screen);
	return 0;
}


/*!
 * \brief actualizacón lógica
 */
void creditos :: actualizar(void)
{
	Uint8 *tecla;
	
	tecla = SDL_GetKeyState(NULL);


	if (tecla[SDLK_ESCAPE])
	{
		pmundo->audio.play(4);
		pmundo->cambiar_escena(MENU);
	}

	if (tecla[SDLK_SPACE] && pausa)
	{
		etapa++;
			
		if (etapa > GPL)
		{
			pmundo->audio.play(4);
			pmundo->cambiar_escena(MENU);
		}
		else
		{
			pausa=0;
			fila_letra=0;
			columna_letra=0;
			c=0;
			f=0;
			cambiar_etapa(etapa);
			pmundo->audio.play(5);
			SDL_BlitSurface(fondo, NULL, screen, NULL);
			SDL_Flip(screen);
		}
	}
	

}

/*!
 * \brief imprime un texto de creditos
 */
void creditos :: imprimir(void)
{	
	if (pausa)
		return;

	// crear letras
	if (delay>1)
	{

		if (mensaje[c] == '\\')
		{
			delay=0;
			c++;
			f++;
			fila_letra++;
			columna_letra=0;
			return;
		}

		
		if (mensaje[c] == '\0')
		{
			imprimir_pie();
			pausa=1;
			return;
		}

		if (mensaje[c] == '#')
		{
			if (color==1)
				color=0;
			else
				color=1;
		}
		else
		{
			imprimir_caracter(mensaje[c], 10 + columna_letra*25,\
					10+fila_letra*40, color);
			columna_letra++;
			delay=0;
		}

		c++;

	}

	delay++;

}


/*!
 * \brief imprime un caracter sobre screen y actualiza esa zona
 */
void creditos :: imprimir_caracter(char letra, int x, int y, int resaltar)
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
			pmundo->libgrafico.ima_fuente_2->imprimir(36+resaltar*40,\
					screen, &rect, x, y, 1);
			break;

		case ':':
			pmundo->libgrafico.ima_fuente_2->imprimir(37+resaltar*40,\
					screen, &rect, x, y, 1);
			break;
			
		case '(':
			pmundo->libgrafico.ima_fuente_2->imprimir(38+resaltar*40,\
					screen, &rect, x, y, 1);
			break;
				
		case ')':
			pmundo->libgrafico.ima_fuente_2->imprimir(39+resaltar*40,\
					screen, &rect, x, y, 1);
			break;

		default:
			pmundo->libgrafico.ima_fuente_2->imprimir(letra - 'a' + \
					resaltar*40, screen, &rect, x, y, 1);
			break;
	}

	SDL_UpdateRect(screen, rect.x, rect.y, rect.w, rect.h);
}


/*!
 * \brief mensaje (space para continuar)
 */
void creditos :: imprimir_pie(void)
{
	char fin[200];
	int i;

	strcpy (fin, _("(space to continue)"));

	for (i=0; fin[i] != '\0'; i++)
	{
		imprimir_caracter(fin[i], 25+i*24, 440, 0);
	}
}


/*!
 * \brief asigna una nueva etapa (ver enum)
 */
void creditos :: cambiar_etapa(int nueva)
{
	etapa = nueva;
	
	switch (etapa)
	{
		case INICIAL:
			strcpy(mensaje,\
_(\
"\\developed by:\\ .#hugo ruscitti#\\\\graphics by:\\ .#walter velazquez#\\"
"\\music by:\\. #javier da silva#\\"));
		break;

		case WEB:
	strcpy(mensaje,\
_(\
"you can know more\\about what we are doing\\visitting the web site\\of the "
"losers proyect:\\\\#www.losersjuegos.com.ar#\\"));

			break;

		case GPL:
			strcpy(mensaje,\
_(\
"license:\\\\this program is\\#free software# and is\\distributed under the"
"\\terms of the license\\#gpl#. please read the\\copyng and the readme\\files "
"to obtain more\\information.\\"));
			break;

			
	}
}


void creditos :: pausar(void)
{
}
