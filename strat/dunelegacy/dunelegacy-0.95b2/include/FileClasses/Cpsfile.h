/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CPSFILE_H
#define CPSFILE_H

#include "Decode.h"
#include <SDL.h>
#include <SDL_rwops.h>
#include <stdio.h>


/// A class for loading a *.CPS-File.
/**
	This class can read cps-Files and return them as a SDL_Surface.
*/
class Cpsfile : public Decode
{
public:
	Cpsfile(SDL_RWops* RWop);
	~Cpsfile();

	SDL_Surface * getPicture();

private:
	unsigned char* Filedata;
	Uint32 CpsFilesize;
};

#endif // CPSFILE_H
