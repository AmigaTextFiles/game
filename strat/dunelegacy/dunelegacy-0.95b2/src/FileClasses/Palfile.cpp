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

#include <FileClasses/Palfile.h>

Palfile::Palfile(SDL_RWops* rwop)
{
	int filesize;
	if((filesize = SDL_RWseek(rwop,0,SEEK_END)) < 0) {
		fprintf(stdout,"Palfile::Palfile(): SDL_RWseek failed!\n");
		exit(EXIT_FAILURE);
	}

	if(filesize % 3 != 0) {
		fprintf(stdout,"Palfile::Palfile(): Filesize must be multiple of 3!\n");
		exit(EXIT_FAILURE);
	}

	SDL_RWseek(rwop,0,SEEK_SET);

    m_palette = new SDL_Palette;
    m_palette->ncolors = filesize / 3;

    m_palette->colors = new SDL_Color[m_palette->ncolors];

    /* SDL_Color contains a member named "unused". This is never *
     * used and thus it would remain uninitialized. But Valgrind *
     * will complain about this because deep inside SDL this value
     * influences a conditional jump. Thus we will zero out this
     * palette to stop Valgrind complaining. */
    memset(m_palette->colors, 0, sizeof(SDL_Color)*m_palette->ncolors);

    SDL_Color* c = m_palette->colors;
	char buf;

    for (int i=0; i<m_palette->ncolors; i++,c++)
    {
		if(SDL_RWread(rwop,&buf,1,1) != 1) {
			fprintf(stdout,"Palfile::Palfile(): SDL_RWread failed!\n");
			exit(EXIT_FAILURE);
		}
        c->r = (char) (((double) buf)*255.0/63.0);

		if(SDL_RWread(rwop,&buf,1,1) != 1) {
			fprintf(stdout,"Palfile::Palfile(): SDL_RWread failed!\n");
			exit(EXIT_FAILURE);
		}
        c->g = (char) (((double) buf)*255.0/63.0);

		if(SDL_RWread(rwop,&buf,1,1) != 1) {
			fprintf(stdout,"Palfile::Palfile(): SDL_RWread failed!\n");
			exit(EXIT_FAILURE);
		}
        c->b = (char) (((double) buf)*255.0/63.0);
    };
}

/// Returns the palette in this palfile.
/**
	This method returns a copy of the palette in this PAL-File. Use this method
	if you want to modify the returned palette or use it beyond the existance of this Palfile-Object.
	Both the returned SDL_Palette as the contained SDL_Color-Array should be freed with delete.
	Free it like this:<br>
	\code
	SDL_Palette myPalatte = myPalfileObj->getCopyOfPalette();
	//...
	delete [] myPalatte->colors;
	delete myPalatte;
	\endcode
	\return	Pointer to a newly created palette
*/
SDL_Palette* Palfile::getCopyOfPalette() {
		SDL_Palette* retPalette = new SDL_Palette;
		retPalette->ncolors = m_palette->ncolors;
		retPalette->colors = new SDL_Color[m_palette->ncolors];
		memcpy(retPalette->colors, m_palette->colors, sizeof(SDL_Color)*m_palette->ncolors);
		return retPalette;
}

Palfile::~Palfile()
{
	delete [] m_palette->colors;
    delete m_palette;
}
