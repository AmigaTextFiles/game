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

#include "fuente.h"
#include "procesos.h"
#include "juego.h"

///estados del mensaje de texto
enum {ENTRANDO, NORMAL, SALIENDO, ENTRA_RAPIDO, NORMAL_RAPIDO, SALE_RAPIDO};

/*!
 * \brief vincula el objeto al juego
 */
void fuente :: iniciar(grafico *_graficos, int _x, int _y, char _letra, int animacion)
{
	paso=0;
	graficos = _graficos;
	x = _x;
	y = _y;

	if (animacion)
		estado=ENTRANDO;
	else
		estado=ENTRA_RAPIDO;

	if (isdigit(_letra))
		ima = _letra-'0'+26;
	else
		if (_letra != ' ')
			ima = _letra - 'a';
		else
			ima=-1;

}

/*!
 * \brief actualizacion logica de la cadena
 */
void fuente :: actualizar(void)
{
	
	switch (estado)
	{
		case ENTRANDO:

			if (paso>=5)
			{
				estado=NORMAL;
				paso=0;
			}
			else
				paso++;

			break;
			
		case NORMAL:
			if (paso>=200)
				estado=SALIENDO;
			else
				paso++;
			
			break;
			
		case SALIENDO:
			y += (-150 - y) >> 3;
//			y_destino = -150;
			
			if (y <= -30)
				estado=-1;
			break;


		case ENTRA_RAPIDO:
			
			if (paso>=5)
			{
				estado=NORMAL_RAPIDO;
				paso=0;
			}
			else
				paso++;

			break;

		case NORMAL_RAPIDO:
			if (paso>=100)
			{
				paso=0;
				estado=SALE_RAPIDO;
			}
			else
				paso++;
			
			break;

		case SALE_RAPIDO:
			if (paso>=5)
			{
				estado=-1;
				paso=0;
			}
			else
				paso++;

			break;
	}
}


/*!
 * \brief muestra la letra en pantalla
 */
void fuente :: imprimir(SDL_Surface *screen, SDL_Rect *rect)
{
	if (estado!=NORMAL && estado!=NORMAL_RAPIDO)
		graficos->imprimir(ima, screen, rect, x, y, 1);
	else
		graficos->imprimir(ima+40, screen, rect, x, y, 1);
}
