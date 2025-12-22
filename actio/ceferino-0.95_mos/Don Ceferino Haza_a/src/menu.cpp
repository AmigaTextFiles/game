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
#include "menu.h"
#include "mundo.h"
#include "grafico.h"
#include "utils.h"
#include "int.h"

menu :: menu(void)
{
	lim_todos=0;
	opcion=0;
	tecla_pulsada=0;
	titulo_activo=1;
}

menu :: ~menu(void)
{
	int i;

	for (i=0; i<5; i++)
		delete item_menu[i];
	
	for (i=0; i<3; i++)
		delete simple_sprite[i];
	
	SDL_FreeSurface(fondo);
}

/*!
 * \brief genera los componentes del menu
 *
 * \return 1 si falla, 0 en caso contrario 
 */
int menu :: iniciar(class mundo *_pmundo, int _modo_video, SDL_Surface *_screen)
{
	SDL_Rect rect;
	
	pmundo = _pmundo;
	modo_video = _modo_video;
	screen = _screen;

	fondo = SDL_CreateRGBSurface(SDL_SWSURFACE, screen->w, screen->h, 16, \
			screen->format->Rmask, screen->format->Gmask, \
			screen->format->Bmask, screen->format->Amask);

	if (fondo == NULL)
	{
		printf(_("error: can't create a copy of the screen : '%s'\n"),\
					SDL_GetError());
		return 1;
	}
	
	item_menu[0] = new class item_menu;
	item_menu[1] = new class item_menu;
	item_menu[2] = new class item_menu;
	item_menu[3] = new class item_menu;
	item_menu[4] = new class item_menu;
	
	simple_sprite[0] = new class simple_sprite;
	simple_sprite[1] = new class simple_sprite;
	simple_sprite[2] = new class simple_sprite;

	item_menu[0]->iniciar(pmundo->libgrafico.ima_fuente_1, -350, 250-25,\
		320, 250-25,_("new game"));
	item_menu[1]->iniciar(pmundo->libgrafico.ima_fuente_1, 740, 300-25,\
		320, 300-25, _("how to play"));
	item_menu[2]->iniciar(pmundo->libgrafico.ima_fuente_1, -510, 350-25,\
		320, 350-25, _("credits"));
	item_menu[3]->iniciar(pmundo->libgrafico.ima_fuente_1, 740, 400-25,\
		320, 400-25, _("best points"));
	item_menu[4]->iniciar(pmundo->libgrafico.ima_fuente_1, -500, 450-25,\
		320, 450-25, _("exit"));

	
	simple_sprite[0]->iniciar(pmundo->libgrafico.ima_tit_1, -594, 616, 6,\
			10);
	simple_sprite[1]->iniciar(pmundo->libgrafico.ima_tit_2, 830, 616, 230,\
			0);
	simple_sprite[2]->iniciar(pmundo->libgrafico.ima_tit_3, -500, 750, \
			100, 110);
	
	item_menu[0]->seleccionar();
	
	pmundo->libgrafico.ima_menu->imprimir(0, screen, &rect, 0, 0, 1);
	pmundo->libgrafico.ima_menu->imprimir(0, fondo, &rect, 0, 0, 1);
	
	SDL_Flip(screen);

	pmundo->audio.play_musica(1);
	pmundo->reiniciar_reloj();
	return 0;
}


/*!
 * \brief actualizacion logica del menu
 */
void menu :: actualizar(void)
{
	Uint8 *tecla;

	if (termino_titulo()) // terminó la animación del titulo
	{
		item_menu[0]->actualizar();
		item_menu[1]->actualizar();
		item_menu[2]->actualizar();
		item_menu[3]->actualizar();
		item_menu[4]->actualizar();

		tecla = SDL_GetKeyState(NULL);

		// mover el cursor
		if (tecla[SDLK_DOWN] && tecla_pulsada==0)
		{
			item_menu[opcion]->no_seleccionar();
			
			if (opcion == 4)
				opcion=0;
			else
				opcion++;
			
			item_menu[opcion]->seleccionar();
			tecla_pulsada=1;
			pmundo->audio.play(5);
			
		}

		// mover el cursor
		if (tecla[SDLK_UP] && !tecla_pulsada)
		{
			item_menu[opcion]->no_seleccionar();

			if (opcion == 0)
				opcion = 4;
			else
				opcion--;
			
			item_menu[opcion]->seleccionar();
			tecla_pulsada=1;
			pmundo->audio.play(5);
		}


		// selecciona una opcion	
		if (tecla[SDLK_SPACE] || tecla[SDLK_x] || tecla[SDLK_c] || tecla[SDLK_z] || tecla[SDLK_RETURN])
		{
			switch (opcion)
			{
				case 0:
					pmundo->cambiar_escena(JUEGO);
					break;

				case 1:
					pmundo->cambiar_escena(COMOJUGAR);
					break;

					
				case 2:
					pmundo->cambiar_escena(CREDITOS);
					break;

				case 3:
					pmundo->cambiar_escena(MARCAS);
					break;

				case 4:
					pmundo->terminar();
					break;
			}

			pmundo->audio.play(4);
		}

		if (!tecla[SDLK_DOWN] && !tecla[SDLK_UP])
			tecla_pulsada=0;
	}
	else
	{
		simple_sprite[0]->actualizar();
		simple_sprite[1]->actualizar();
		simple_sprite[2]->actualizar();
	}
}


/*!
 * \brief imprime el titulo del juego y las opciones del menu
 */
void menu :: imprimir(void)
{
	int i;

	lim_actual = 0;

	if (termino_titulo())
	{
		if (titulo_activo) // fija el titulo al fondo de pantalla
		{
			for (i=0; i<3; i++)
			{
				simple_sprite[i]->imprimir(fondo, rect_actual,\
						&lim_actual);
				simple_sprite[i]->imprimir(screen, rect_actual,\
						&lim_actual);
			}
			
			titulo_activo=0;
			pmundo->reiniciar_reloj();
		}
	
		for (i=0; i<5; i++)
			item_menu[i]->imprimir(screen, rect_actual, &lim_actual);
	}
	else
	{
		for (i=0; i<3; i++)
			simple_sprite[i]->imprimir(screen, rect_actual, &lim_actual);
	}
	
	copiar_rectangulos(rect_todos, &lim_todos, rect_actual, &lim_actual, screen->w, screen->h);
	SDL_UpdateRects(screen, lim_todos, rect_todos);

	lim_todos=0;
	copiar_rectangulos(rect_todos, &lim_todos, rect_actual, &lim_actual, screen->w, screen->h);

	// pinta el fondo modificado
	for (i=0; i<lim_actual; i++)
		SDL_BlitSurface(fondo, &(rect_actual[i]), screen, &(rect_actual[i]));

}


/*!
 * \brief informa si la animacion del titulo 'Don Ceferino...' terminó
 * 
 * \return 1 si termino, 0 en caso contrario
 */
int menu :: termino_titulo(void)
{
	if (simple_sprite[0]->termino_anim() && \
			simple_sprite[1]->termino_anim() && \
			simple_sprite[2]->termino_anim())
	{
		return 1;
	}
	else
		return 0;
}



void menu :: pausar(void)
{
}
