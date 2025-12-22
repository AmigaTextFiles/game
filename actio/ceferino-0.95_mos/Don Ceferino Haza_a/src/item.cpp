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


#include "item.h"

/*!
 * \brief asigna los valores iniciales del item
 *
 * \param _graficos imagenes de los items
 * \param _x coordenada horizontal
 * \param _y coordenada vertical
 * \param _tipo tipo de item (bomba, doble tiro, etc)
 */
void item :: iniciar(class juego *_juego, grafico *_graficos, int _x, int _y, int _tipo)
{
	tipo = _tipo;
	x = _x;
	y = _y;
	estado=0;
	vida=400;
	velocidad=-3;
	ima_items = _graficos;
	juego = _juego;
}

/*!
 * \brief actualizacion logica
 */
void item :: actualizar(void)
{
	if (juego->nivel->get_dist_suelo(x,y-10, 1) != 0)
	{
		y+= juego->nivel->get_dist_suelo(x, y-10, (int) velocidad);
		velocidad += 0.1;
	}
	else
		velocidad=0;

	if (vida<0)
		estado=-1;
	else
		vida--;
}

/*!
 * \brief muestra el item por pantalla
 *
 * \param screen pantalla
 * \param rect rectangulo que modifica
 */
void item :: imprimir(SDL_Surface *screen, SDL_Rect *rect)
{
	if (vida > 30)
		ima_items->imprimir(tipo, screen, rect, x, y, 1);
	else
		ima_items->imprimir(tipo+7, screen, rect, x, y, 1);
}

/*!
 * \brief accion a realizar si colisiona con el protagonista
 */
void item :: colisiona_con_protagonista(void)
{	
	if (estado != -1)
	{
		juego->pagar_item(tipo);
		estado = -1;
	}
}
