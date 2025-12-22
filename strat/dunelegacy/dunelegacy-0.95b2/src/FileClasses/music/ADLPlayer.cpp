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

#include <FileClasses/music/ADLPlayer.h>

#include <globals.h>

#include <FileClasses/FileManager.h>
#include <FileClasses/adl/adl.h>

#include <mmath.h>

ADLPlayer::ADLPlayer() : MusicPlayer() {
    musicVolume = MIX_MAX_VOLUME/2;
    Mix_VolumeMusic(musicVolume);

    currentCadlPlayer = NULL;

	currentMusicNum = 0;

	changeMusic(MUSIC_INTRO);
}

ADLPlayer::~ADLPlayer() {
    setMusic(false);
}

void ADLPlayer::changeMusic(MUSICTYPE musicType)
{
	int musicNum = -1;
	std::string filename = "";

	if(currentMusicType == musicType) {
		return;
	}

	switch(musicType)
	{
		case MUSIC_ATTACK: {

            switch(getRandomInt(0, 4)) {
                case 0:     filename = "DUNE11.ADL";    musicNum = 7;   break;
                case 1:     filename = "DUNE12.ADL";    musicNum = 7;   break;
                case 2:     filename = "DUNE13.ADL";    musicNum = 7;   break;
                case 3:     filename = "DUNE14.ADL";    musicNum = 7;   break;
                case 4:     filename = "DUNE15.ADL";    musicNum = 7;   break;
            }

		} break;

		case MUSIC_INTRO: {
		    filename = "DUNE0.ADL";
		    musicNum = 2;
        } break;

		case MUSIC_LOSE: {
		    filename = "DUNE1.ADL";
		    musicNum = 3;
		} break;

		case MUSIC_PEACE: {

            switch(getRandomInt(0, 8)) {
                case 0:     filename = "DUNE2.ADL";     musicNum = 6;   break;
                case 1:     filename = "DUNE3.ADL";     musicNum = 6;   break;
                case 2:     filename = "DUNE4.ADL";     musicNum = 6;   break;
                case 3:     filename = "DUNE5.ADL";     musicNum = 6;   break;
                case 4:     filename = "DUNE6.ADL";     musicNum = 6;   break;
                case 5:     filename = "DUNE9.ADL";     musicNum = 4;   break;
                case 6:     filename = "DUNE10.ADL";    musicNum = 2;   break;
                case 7:     filename = "DUNE18.ADL";    musicNum = 6;   break;
                case 8:     filename = "DUNE19.ADL";    musicNum = 4;   break;
            }

		} break;

		case MUSIC_WIN: {
		    filename = "DUNE20.ADL";
		    musicNum = 2;
		} break;


		case MUSIC_RANDOM:
		default: {

            switch(getRandomInt(0, 16)) {
                // attack
                case 0:     filename = "DUNE11.ADL";    musicNum = 7;   break;
                case 1:     filename = "DUNE12.ADL";    musicNum = 7;   break;
                case 2:     filename = "DUNE13.ADL";    musicNum = 7;   break;
                case 3:     filename = "DUNE14.ADL";    musicNum = 7;   break;
                case 4:     filename = "DUNE15.ADL";    musicNum = 7;   break;

                // intro
                case 5:     filename = "DUNE0.ADL";	    musicNum = 2;   break;

                // lose
                case 6:     filename = "DUNE1.ADL";	    musicNum = 3;   break;

                // peace
                case 7:     filename = "DUNE2.ADL";     musicNum = 6;   break;
                case 8:     filename = "DUNE3.ADL";     musicNum = 6;   break;
                case 9:     filename = "DUNE4.ADL";     musicNum = 6;   break;
                case 10:    filename = "DUNE5.ADL";     musicNum = 6;   break;
                case 11:    filename = "DUNE6.ADL";     musicNum = 6;   break;
                case 12:    filename = "DUNE9.ADL";     musicNum = 4;   break;
                case 13:    filename = "DUNE10.ADL";    musicNum = 2;   break;
                case 14:    filename = "DUNE18.ADL";    musicNum = 6;   break;
                case 15:    filename = "DUNE19.ADL";    musicNum = 4;   break;

                // win
                case 16: 	filename = "DUNE20.ADL";    musicNum = 2;   break;
            }

		} break;
	}

	currentMusicType = musicType;

	if((musicOn == true) && (filename != "")) {

        Mix_HookMusic(NULL, NULL);
	    delete currentCadlPlayer;

	    SDL_RWops* rwop = pFileManager->OpenFile(filename);
	    if(rwop == NULL) {
            printf("Unable to load %s!\n",filename.c_str());
	    } else {
            currentCadlPlayer = new CadlPlayer(rwop);

            SDL_RWclose(rwop);

            currentCadlPlayer->rewind(musicNum);

            Mix_HookMusic(currentCadlPlayer->callback, currentCadlPlayer);

            printf("Now playing %s!\n",filename.c_str());
	    }
	}
}

void ADLPlayer::musicCheck() {
	if(musicOn) {
		if(currentCadlPlayer->isPlaying() == false) {
			changeMusic(MUSIC_PEACE);
		}
	}
}

void ADLPlayer::setMusic(bool value) {
	musicOn = value;

	if(musicOn) {
		changeMusic(MUSIC_RANDOM);
	} else {
	    Mix_HookMusic(NULL, NULL);

	    delete currentCadlPlayer;
	    currentCadlPlayer = NULL;
	}
}


void ADLPlayer::toggleSound()
{
	if(musicOn == false) {
		musicOn = true;
		currentMusicType = MUSIC_RANDOM;
		changeMusic(MUSIC_PEACE);
	} else {
		setMusic(false);
	}
}
