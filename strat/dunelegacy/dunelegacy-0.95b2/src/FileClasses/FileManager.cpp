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

#include <FileClasses/FileManager.h>

#include <globals.h>

#include <config.h>

//#include <clib/debug_protos.h>

FileManager::FileManager() {

	switch(settings.General.Language) {
		case LNG_ENG:
		{
			numPakfiles = 13;

			if((PakFiles = (Pakfile**) malloc(numPakfiles*sizeof(Pakfile*))) == NULL) {
				fprintf(stderr,"FileManager: Cannot allocate memory!\n");
				exit(EXIT_FAILURE);
			}

			PakFiles[0] = new Pakfile(DATADIR "LEGACY.PAK");
			PakFiles[1] = new Pakfile(DATADIR "HARK.PAK");
			PakFiles[2] = new Pakfile(DATADIR "ATRE.PAK");
			PakFiles[3] = new Pakfile(DATADIR "ORDOS.PAK");
			PakFiles[4] = new Pakfile(DATADIR "ENGLISH.PAK");
			PakFiles[5] = new Pakfile(DATADIR "DUNE.PAK");
			PakFiles[6] = new Pakfile(DATADIR "SCENARIO.PAK");
			PakFiles[7] = new Pakfile(DATADIR "MENTAT.PAK");
			PakFiles[8] = new Pakfile(DATADIR "VOC.PAK");
			PakFiles[9] = new Pakfile(DATADIR "MERC.PAK");
			PakFiles[10] = new Pakfile(DATADIR "FINALE.PAK");
			PakFiles[11] = new Pakfile(DATADIR "INTRO.PAK");
			PakFiles[12] = new Pakfile(DATADIR "SOUND.PAK");

		} break;

		case LNG_GER:
		{
			numPakfiles = 10;

			if((PakFiles = (Pakfile**) malloc(numPakfiles*sizeof(Pakfile*))) == NULL) {
				fprintf(stderr,"FileManager: Cannot allocate memory!\n");
				exit(EXIT_FAILURE);
			}

			PakFiles[0] = new Pakfile(DATADIR "LEGACY.PAK");
			PakFiles[1] = new Pakfile(DATADIR "GERMAN.PAK");
			PakFiles[2] = new Pakfile(DATADIR "DUNE.PAK");
			PakFiles[3] = new Pakfile(DATADIR "SCENARIO.PAK");
			PakFiles[4] = new Pakfile(DATADIR "MENTAT.PAK");
			PakFiles[5] = new Pakfile(DATADIR "VOC.PAK");
			PakFiles[6] = new Pakfile(DATADIR "MERC.PAK");
			PakFiles[7] = new Pakfile(DATADIR "FINALE.PAK");
			PakFiles[8] = new Pakfile(DATADIR "INTRO.PAK");
			PakFiles[9] = new Pakfile(DATADIR "SOUND.PAK");

		} break;

		default:
		{
			fprintf(stderr,"FileManager: Unknown language!\n");
			exit(EXIT_FAILURE);
		}
	}

	for(int i = 0; i < numPakfiles; i++) {
		if(PakFiles[i] == NULL) {
			fprintf(stderr,"FileManager: Cannot open PAK-File!\n");
			exit(EXIT_FAILURE);
		}
	}
}

FileManager::~FileManager() {
	for(int i = 0; i < numPakfiles; i++) {
		if(PakFiles[i] != NULL) {
			delete PakFiles[i];
			PakFiles[i] = NULL;
		}
	}

	free(PakFiles);
	numPakfiles = 0;
}

SDL_RWops* FileManager::OpenFile(std::string Filename) {
	SDL_RWops* ret;

        
	for(int i = 0; i < numPakfiles; i++) {
                ret = NULL;
		ret = PakFiles[i]->OpenFile(Filename);
                
		if(ret != NULL) {
                        return ret;
		}
	}

	fprintf(stderr,"FileManager::OpenFile(): Cannot find %s!\n",Filename.c_str());
	
	exit(EXIT_FAILURE);

	return NULL;
}
