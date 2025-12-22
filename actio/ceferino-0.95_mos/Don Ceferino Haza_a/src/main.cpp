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


#include <stdio.h>
#include <stdlib.h>
#include "mundo.h"
#include "int.h"

#ifdef __MORPHOS__
const char *version_tag = "$VER: ceferino 0.95 (2005-05-31)";
#endif

#ifdef WIN32
#include <windows.h>
int WINAPI WinMain(HINSTANCE x1, HINSTANCE x2, LPSTR x3, int x4)
#else
/*!
 * \brief funcion inicial de todo el programa
 */
int main(void)
#endif
{
#ifndef WIN32
	setlocale (LC_ALL, "");
	bindtextdomain (PACKAGE, LOCALE_DIR);
	textdomain (PACKAGE);
#endif
	mundo mundo;
	
	printf("\n");
	printf(" Don Ceferino Hazaña - version " VER"\n");
	printf(" (c) - Hugo Ruscitti - www.losersjuegos.com.ar\n");
	printf("\n");
	
	if (mundo.cargar_opciones(".ceferino"))
		return 1;
	
	if (mundo.iniciar())
		return 1;
	
	mundo.correr();
	mundo.eliminar();

	printf(_("\nThanks for playing\n\n"));
	
	return 0;
}
