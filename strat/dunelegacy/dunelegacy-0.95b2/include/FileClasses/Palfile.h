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

#ifndef PALFILE_H
#define PALFILE_H

#include <SDL.h>
#include <SDL_rwops.h>

///	A class for reading palettes out of PAL-Files.
/**
	This class can be used to read PAL-Files. PAL-Files are palette files used by Dune2.
*/
class Palfile
{
    public:
        Palfile(SDL_RWops* rwop);
        ~Palfile();

		/// Returns the palette
		/**
			This method returns a pointer to the palette in this PAL-File. This pointer is only
			valid as long as the Palfile-Object exist.
			\return A pointer to the palette
		*/
		SDL_Palette* getPointerToPalette() { return m_palette; }

		SDL_Palette* getCopyOfPalette();

    private:
        SDL_Palette* m_palette;

};

#endif // PALFILE_H
