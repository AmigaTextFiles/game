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


#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <math.h>

#include "item_menu.h"

///estados de la cadena de texto
enum {ENTRANDO, NORMAL};

/*!
 * \brief genera el item
 */
void item_menu :: iniciar(grafico *_ima_letras, int _x_inicial, int _y_inicial, int _x_final, int _y_final, char *_cadena)
{
	ima_letras = _ima_letras;

	x_destino = _x_final  - strlen(_cadena)*16;
	y_destino = _y_final;
	
	x = _x_inicial;
	y = _y_inicial;

	seleccionado=0;
	strcpy(cadena, _cadena);

	vel=0;
	estado=ENTRANDO;
}

/*!
 * \brief actualizacion logica de la cadena
 */
void item_menu :: actualizar(void)
{

	if (abs(x_destino - x) < 10 && x_destino - x != 0)
		x+= (x_destino - x) / abs(x_destino - x);
	else
		x+= (x_destino - x) / 10;
	

	if (abs(y_destino - y) < 10 && y_destino - y != 0)
		y+= (y_destino - y) / abs(y_destino -y);
	else
		y+= (y_destino - y) / 10;

	
	switch (estado)
	{
		case ENTRANDO:

			if (x_destino-x == 0 && y_destino-y == 10)
				estado=NORMAL;
			break;

		case NORMAL:

			if (seleccionado)
			{
				
				vel+=0.1;
				y+=(int) vel;

				if (vel >= 2)
					vel=-2;
			}

			break;
	}
}



/*!
 * \brief muestra en pantalla la cadena de textos
 */
void item_menu :: imprimir(SDL_Surface *screen, SDL_Rect *rect, int *cant_modif)
{
	int i;
	
	for (i=0; cadena[i] != '\0'; i++)
	{
		if (cadena[i] != ' ')
		{
			if (seleccionado)
				ima_letras->imprimir(cadena[i] - 'a' +40, screen, rect+*cant_modif, x+i*33, y, 1);
			else
				ima_letras->imprimir(cadena[i] - 'a', screen, rect+*cant_modif, x+i*33, y, 1);

				(*cant_modif)++;
		}
	}
}

/*!
 * \brief el objeto es seleccionado por el usuario
 */
void item_menu :: seleccionar(void)
{
	vel=-2;
	seleccionado=1;
}

/*!
 * \brief el objeto deja de estar seleccionado
 */
void item_menu :: no_seleccionar(void)
{
	vel=0;
	seleccionado=0;
}
