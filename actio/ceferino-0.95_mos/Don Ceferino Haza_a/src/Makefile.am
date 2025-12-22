#
# Don Ceferino Hazaña - video game similary to Super Pang!
# Copyright (c) 2004, 2005 Hugo Ruscitti
# web site: http://www.loosersjuegos.com.ar
#
# This file is part of Don Ceferino Hazaña (ceferino).
#                                                                            
# Don Ceferino Hazaña is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#                                                                            
# Don Ceferino Hazaña is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#                                                                            
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

SUBDIRS = ima sonidos niveles musicas
DEFS= @DEFS@ 
AM_CPPFLAGS = -DLOCALE_DIR=\"${localedir}\" -DPACKAGE=\"${PACKAGE}\" \
-DSRC_DIR=\"${datadir}/${PACKAGE}\" -DVER=\"${VERSION}\" -I../intl

LIBS = -lSDL -lSDL_image -lSDL_mixer

bin_PROGRAMS = ceferino ceferinosetup ceferinoeditor

ceferino_SOURCES = actor.cpp audio.cpp barra.cpp bloque.cpp bomba.cpp \
		creditos.cpp final.cpp fuente.cpp gaucho.cpp grafico.cpp\
		intro.cpp item.cpp item_menu.cpp juego.cpp libgrafico.cpp\
		main.cpp marcas.cpp menu.cpp mundo.cpp nivel.cpp pelota.cpp\
		procesos.cpp simple_sprite.cpp tiro.cpp utils.cpp comojugar.cpp

ceferinoeditor_SOURCES = main_ed.cpp grafico.cpp utils.cpp

ceferinosetup_SOURCES = main_op.cpp grafico.cpp utils.cpp

EXTRA_DIST = actor.h audio.h barra.h bloque.h bomba.h creditos.h escena.h\
	final.h fuente.h gaucho.h grafico.h intro.h item.h item_menu.h juego.h\
	libgrafico.h main_ed.h main_op.h marcas.h menu.h mundo.h nivel.h\
	pelota.h procesos.h simple_sprite.h tiro.h utils.h int.h comojugar.h
