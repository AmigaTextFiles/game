/*
Copyright (C) 2004 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "headers.h"

Directory::Directory()
{
	strcpy(name, "");
	fileCount = 0;
	sprite = NULL;
	active = false;
	x = y = -1;
	fileCount = 0;
	realFileCount = 0;
	label = NULL;
}

Directory::~Directory()
{
	destroy();
}

GameObject *Directory::getRandomFile()
{
	GameObject *file = fileList.getHead();

	int r = rand() % realFileCount;
	int i = 0;

	while (file->next != NULL)
	{
		file = file->next;
		if (r == i)
			return (File*)file;

		i++;
	}

	return NULL;
}

bool Directory::addFile(GameObject *file)
{
	if (realFileCount == 50)
		return false;

	fileList.add(file);
	fileCount++;
	realFileCount++;

	return true;
}

int Directory::getRealFileCount()
{
	return realFileCount;
}

void Directory::reset()
{
	fileCount = realFileCount;
}

void Directory::destroy()
{
	if (label != NULL)
		SDL_FreeSurface(label);
		
	fileList.clear();
}
