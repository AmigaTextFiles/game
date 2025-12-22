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

#include <FileClasses/music/DirectoryPlayer.h>

#include <misc/FileSystem.h>
#include <misc/fnkdat.h>
#include <mmath.h>

DirectoryPlayer::DirectoryPlayer() : MusicPlayer() {
	// determine path to config file
	char tmp[FILENAME_MAX];
	fnkdat(NULL, tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
	std::string configfilepath(tmp);

	AttackMusic = getMusicFileNames(configfilepath + "/music/attack/");
	IntroMusic = getMusicFileNames(configfilepath + "/music/intro/");
	LoseMusic = getMusicFileNames(configfilepath + "/music/lose/");
	PeaceMusic = getMusicFileNames(configfilepath + "/music/peace/");
	WinMusic = getMusicFileNames(configfilepath + "/music/win/");

	musicVolume = MIX_MAX_VOLUME/2;
    Mix_VolumeMusic(musicVolume);

	music = NULL;

	changeMusic(MUSIC_INTRO);
}

DirectoryPlayer::~DirectoryPlayer() {
	if(music != NULL) {
		Mix_FreeMusic(music);
		music = NULL;
	}
}

void DirectoryPlayer::changeMusic(MUSICTYPE musicType)
{
	int musicNum = -1;
	std::string filename = "";

	if(currentMusicType == musicType) {
		return;
	}

	switch(musicType)
	{
		case MUSIC_ATTACK:
			if(AttackMusic.size() > 0) {
				musicNum = getRandomInt(0, AttackMusic.size()-1);
				filename = AttackMusic[musicNum];
			}
			break;

		case MUSIC_INTRO:
			if(IntroMusic.size() > 0) {
				musicNum = getRandomInt(0, IntroMusic.size()-1);
				filename = IntroMusic[musicNum];
			}
			break;

		case MUSIC_LOSE:
			if(LoseMusic.size() > 0) {
				musicNum = getRandomInt(0, LoseMusic.size()-1);
				filename = LoseMusic[musicNum];
			}
			break;

		case MUSIC_PEACE:
			if(PeaceMusic.size() > 0) {
				musicNum = getRandomInt(0, PeaceMusic.size()-1);
				filename = PeaceMusic[musicNum];
			}
			break;

		case MUSIC_WIN:
			if(WinMusic.size() > 0) {
				musicNum = getRandomInt(0, WinMusic.size()-1);
				filename = WinMusic[musicNum];
			}
			break;

		case MUSIC_RANDOM:
		default:
			int maxnum = AttackMusic.size() + IntroMusic.size() + LoseMusic.size() + PeaceMusic.size() + WinMusic.size();

			if(maxnum > 0) {
				unsigned int randnum = getRandomInt(0, maxnum-1);

				if(randnum < AttackMusic.size()) {
					musicNum = randnum;
					filename = AttackMusic[musicNum];
				} else if(randnum < IntroMusic.size()) {
					musicNum = randnum - AttackMusic.size();
					filename = IntroMusic[musicNum];
				} else if(randnum < LoseMusic.size()) {
					musicNum = randnum - AttackMusic.size() - IntroMusic.size();
					filename = LoseMusic[musicNum];
				} else if(randnum < PeaceMusic.size()) {
					musicNum = randnum - AttackMusic.size() - IntroMusic.size() - LoseMusic.size();
					filename = PeaceMusic[musicNum];
				} else {
					musicNum = randnum - AttackMusic.size() - IntroMusic.size() - LoseMusic.size() - PeaceMusic.size();
					filename = WinMusic[musicNum];
				}
			}
			break;
	}

	currentMusicType = musicType;

	if((musicOn == true) && (filename != "")) {

		Mix_HaltMusic();

		if(music != NULL) {
			Mix_FreeMusic(music);
			music = NULL;
		}

		music = Mix_LoadMUS(filename.c_str());
		if(music != NULL) {
			printf("Now playing %s!\n",filename.c_str());
			Mix_PlayMusic(music, -1);
		} else {
			printf("Unable to play %s!\n",filename.c_str());
		}
	}
}

void DirectoryPlayer::musicCheck() {
	if(musicOn) {
		if(!Mix_PlayingMusic()) {
			changeMusic(MUSIC_PEACE);
		}
	}
}

void DirectoryPlayer::setMusic(bool value) {
	musicOn = value;

	if(musicOn) {
		changeMusic(MUSIC_RANDOM);
	} else if(music != NULL) {
		Mix_HaltMusic();
	}
}


void DirectoryPlayer::toggleSound()
{
	if(musicOn == false) {
		musicOn = true;
		changeMusic(MUSIC_PEACE);
	} else {
		musicOn = false;
		if (music != NULL) {
			Mix_HaltMusic();
            Mix_FreeMusic(music);
            music = NULL;
		}
	}
}

std::vector<std::string> DirectoryPlayer::getMusicFileNames(std::string dir) {
	std::vector<std::string> Files;
	std::list<std::string> tmp;
	std::list<std::string>::const_iterator iter;

	tmp = GetFileNames(dir,"mp3",true);
	for(iter = tmp.begin(); iter != tmp.end(); ++iter) {
		Files.push_back(dir + *iter);
	}

	tmp = GetFileNames(dir,"ogg",true);
	for(iter = tmp.begin(); iter != tmp.end(); ++iter) {
		Files.push_back(dir + *iter);
	}

	tmp = GetFileNames(dir,"wav",true);
	for(iter = tmp.begin(); iter != tmp.end(); ++iter) {
		Files.push_back(dir + *iter);
	}

	tmp = GetFileNames(dir,"mid",true);
	for(iter = tmp.begin(); iter != tmp.end(); ++iter) {
		Files.push_back(dir + *iter);
	}

	return Files;
}
