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
#ifndef _FUENTE_H
#define _FUENTE_H

#include "grafico.h"

/*!
 * \brief Una letra
 */
class fuente
{
	public:
		void iniciar(grafico *_graficos, int x, int y, char letra, int animacion);
		void actualizar(void);
		void imprimir(SDL_Surface *screen, SDL_Rect *rect);
		int get_estado(void) {return estado;}
		
	private:
		class grafico *graficos;
		int x;
		int y;
		int paso;
		int ima;
		int estado;
};

#endif
