/***************************************************************************
                          file.h  -  description
                             -------------------
    begin                : Thu Jan 18 2001
    copyright            : (C) 2001 by Michael Speck
    email                : kulkanie@gmx.net
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/


#ifndef __FILE_H
#define __FILE_H

/*
====================================================================
Return a list (autodeleted strings)
with all accessible files and directories in path
with the extension ext (if != 0). Don't show hidden files or
Makefile stuff.
The directoriers are marked with an asteriks.
====================================================================
*/
List* dir_get_entries( char *path, char *root, char *ext );

#endif
