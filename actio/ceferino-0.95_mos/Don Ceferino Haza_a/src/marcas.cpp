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
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#include "menu.h"
#include "mundo.h"
#include "grafico.h"
#include "utils.h"
#include "int.h"

marcas :: marcas(void)
{
	f=0;
	c=0;
	delay=0;
	pausa=0;
}


marcas :: ~marcas(void)
{
	SDL_FreeSurface(fondo);
}

/*!
 * \brief vincula el objeto creado
 */
int marcas :: iniciar(class mundo *_pmundo, int _mvideo, SDL_Surface *_screen)
{
	SDL_Rect rect;	
	
	pmundo = _pmundo;
	modo_video = _mvideo;
	screen = _screen;

	fondo = SDL_DisplayFormat(screen);

	if (fondo == NULL)
	{
		printf(_("error: Can't copy screen: '%s'\n"), SDL_GetError());
		exit(1);
	}

	cargar_marcas();

	pmundo->libgrafico.ima_menu_oscuro->imprimir(0, fondo, &rect, 0, 0, 1);
	SDL_BlitSurface(fondo, NULL, screen, NULL);
	SDL_Flip(screen);

	imprimir_titulo();
	return 0;
}

/*!
 * \brief actualización lógica
 */
void marcas :: actualizar(void)
{
	Uint8 *tecla;
	
	tecla = SDL_GetKeyState(NULL);

	if (tecla[SDLK_ESCAPE])
	{
		pmundo->cambiar_escena(MENU);
		pmundo->audio.play(4);
	}
}

/*!
 * \brief imprime los records en pantalla
 */
void marcas :: imprimir(void)
{
	if (pausa)
		return;

	if (delay>1)
	{
		if (f<7)
		{
			if (vec_marcas[f].nombre[c] == '\0')
			{
				char puntos[5];
				c=0;
				
				puntos[0] = (vec_marcas[f].puntos/1000) % 10 +'0';
				puntos[1] = (vec_marcas[f].puntos/100) % 10+'0';
				puntos[2] = (vec_marcas[f].puntos/10) % 10 +'0';
				puntos[3] = vec_marcas[f].puntos % 10 + '0';
				puntos[4] = '\0';

				for (int i=0; puntos[i] != '\0'; i++)
					imprimir_caracter(puntos[i], \
							520+i*25, \
							65+f*50, 1);
				
				f++;
				delay=-2;
			}
			else
			{
				imprimir_caracter(vec_marcas[f].nombre[c], \
						c*25+30, 65+f*50, 0);
				c++;
				delay=0;
			}
		}
		else
		{
			imprimir_pie();
			pausa=1;
		}
	}


	delay++;
}

/*!
 * \brief imprime una letra, de nombres o puntajes
 */
void marcas :: imprimir_caracter(char letra, int x, int y, int resaltar)
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
					36+resaltar*40, screen, &rect, x, y, 1);
			break;

		case ':':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					37+resaltar*40, screen, &rect, x, y, 1);
			break;
			
		case '(':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					38+resaltar*40, screen, &rect, x, y, 1);
			break;
				
		case ')':
			pmundo->libgrafico.ima_fuente_2->imprimir(\
					39+resaltar*40, screen, &rect, x, y, 1);
			break;

		default:
			if (isdigit(letra))
				pmundo->libgrafico.ima_fuente_2->imprimir(\
						letra-'0'+26 + resaltar*40, \
						screen, &rect, x, y, 1);
			else
				pmundo->libgrafico.ima_fuente_2->imprimir(\
						letra - 'a'+resaltar*40, \
						screen, &rect, x, y, 1);
			break;
	}

	SDL_UpdateRect(screen, rect.x, rect.y, rect.w, rect.h);
}


/*!
 * \brief imprime el mensaje al pie de la pantalla (escape para salir)
 */
void marcas :: imprimir_pie(void)
{
	char fin[200];
	int i;

	strcpy(fin, _("(escape to exit)"));

	for (i=0; fin[i] != '\0'; i++)
		imprimir_caracter(fin[i], 20+i*25, 430, 1);
}



/*!
 * \brief imprime "mejores puntuaciones"
 */
void marcas :: imprimir_titulo(void)
{
	char fin[200];
	int i;

	strcpy(fin, _("best point"));
	
	for (i=0; fin[i] != '\0'; i++)
		imprimir_caracter(fin[i], 20+i*25, 10, 1);
}


/*!
 * \brief carga las marcas desde el archivo .ceferinomarcas
 */
void marcas :: cargar_marcas(void)
{
	FILE *arch;
	char ruta_completa[100];

#ifdef WIN32
	strcpy(ruta_completa, "marcas.dat");
#else
#ifdef __MORPHOS__
	strcpy(ruta_completa, "Progdir:");
#else
	strcpy(ruta_completa, getenv("HOME"));
	strcat(ruta_completa, "/");
#endif
	strcat(ruta_completa, ".ceferinomarcas");
#endif

	arch = fopen(ruta_completa, "rb");

	if (!arch)
	{
		printf(_("Can't open the marcs file\n"));
		cargar_marcas_estandar();
		arch = fopen(ruta_completa, "rb");
	}
	
	fread(vec_marcas, sizeof(struct entrada), 7, arch);
	fclose(arch);
}


void marcas :: pausar(void)
{
}
