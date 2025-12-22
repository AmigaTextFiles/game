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

#include <main.h>

#include <globals.h>

#include <config.h>

#include <FileClasses/FileManager.h>
#include <FileClasses/FontManager.h>
#include <FileClasses/DataManager.h>
#include <FileClasses/INIFile.h>
#include <FileClasses/Palfile.h>
#include <FileClasses/music/DirectoryPlayer.h>
#include <FileClasses/music/ADLPlayer.h>
#include <FileClasses/music/XMIPlayer.h>

#include <GUI/GUIStyle.h>
#include <GUI/dune/DuneStyle.h>

#include <Menu/MainMenu.h>

#include <misc/fnkdat.h>
#include <misc/FileSystem.h>

#include <SoundPlayer.h>
#include <CutScene.h>

#include <SDL.h>
#include <SDL_rwops.h>
#include <iostream>

#include <stdio.h>
#include <time.h>
#include <locale.h>



void setVideoMode();
void realign_buttons();

unsigned long __stack = 1000000;

char* houseName[9] =
{
	"Atreides",
	"Ordos",
	"Harkonnen",
	"Sardaukar",
	"Fremen",
	"Mercenary"
};

void setVideoMode()
{
	int videoFlags = 0;
	if (settings.Video.DoubleBuffered)
		videoFlags |= SDL_HWSURFACE | SDL_DOUBLEBUF;
	if (settings.Video.Fullscreen)
		videoFlags |= SDL_FULLSCREEN;

	screen = SDL_SetVideoMode(settings.Video.Width, settings.Video.Height, SCREEN_BPP, videoFlags);
	if(screen)
	{
		SDL_SetColors(screen, palette->colors, 0, palette->ncolors);
		SDL_ShowCursor(SDL_DISABLE);
    }
	else
	{
		fprintf(stdout, "ERROR: Couldn't set video mode: %s\n", SDL_GetError());
		exit(EXIT_FAILURE);
    }
}

std::string CheckAndGetConfigFile()
{
	// determine path to config file
	char tmp[FILENAME_MAX];

	fnkdat(CONFIGFILENAME, tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
        
	std::string configfilepath(tmp);

	// check if it exists
	if(ExistsFile(configfilepath) == true) {
		// OK
		return configfilepath;
	}

	SDL_RWops* file = SDL_RWFromFile(configfilepath.c_str(), "w");

	const char configfile[] =	"[General]\n"
								"Play Intro = false\t\t# Play the intro when starting the game?\n"
								"Concrete Required = true\t# If false we can build on sand\n"
								"Player Name = Player\t\t# The name of the player\n"
								"Language = en\t\t\t# en = English, de = German\n"
								"\n"
								"[Video]\n"
								"# You may decide to use half the resolution of your monitor, e.g. monitor has 1600x1200 => 800x600\n"
								"Width = 640\n"
								"Height = 480\n"
								"Fullscreen = false\n"
								"Double Buffered = false\n"
								"FrameLimit = true\t\t# Limit the frame rate to save energy\n"
								"\n"
								"[Audio]\n"
								"# There are three different possibilities to play music\n"
								"#  adl\t\t- This option will use the Dune 2 music as used on e.g. SoundBlaster16 cards\n"
								"#  xmi\t\t- This option plays the xmi files of Dune 2. Sounds more midi-like\n"
								"#  directory\t- Plays music from the \"music\"-directory inside your configuration directory\n"
								"#\t\t  The \"music\"-directory should contain 5 subdirectories named attack, intro, peace, win and lose\n"
								"#\t\t  Put any mp3, ogg or mid file there and it will be played in the particular situation\n"
								"Music Type = adl\n";

	SDL_RWwrite(file, configfile, 1, strlen(configfile));

	SDL_RWclose(file);

	return configfilepath;
}

int main(int argc, char *argv[])
{
	bool ExitGame = false;
	bool FirstInit = true;


    // init some globals
    shade = true;
    fog_wanted = false;
    debug = false;

setlocale(LC_ALL, "C");

       	// init fnkdat
	if(fnkdat(NULL, NULL, 0, FNKDAT_INIT) < 0) {
      perror("Could not initialize fnkdat");
      exit(EXIT_FAILURE);
	}

	do {
		int seed = time(NULL);

		INIFile myINIFile(CheckAndGetConfigFile());

		settings.General.PlayIntro = myINIFile.getBoolValue("General","Play Intro",true);
		settings.General.ConcreteRequired = myINIFile.getBoolValue("General","Concrete Required",true);
		settings.General.PlayerName = myINIFile.getStringValue("General","Player Name","Player");
		settings.Video.Width = myINIFile.getIntValue("Video","Width",640);
		settings.Video.Height = myINIFile.getIntValue("Video","Height",480);
		settings.Video.Fullscreen = myINIFile.getBoolValue("Video","Fullscreen",false);
		settings.Video.DoubleBuffered = myINIFile.getBoolValue("Video","Double Buffered",false);
		settings.Video.FrameLimit = myINIFile.getBoolValue("Video","FrameLimit",true);
		settings.Audio.MusicType = myINIFile.getStringValue("Audio","Music Type","adl");
		std::string Lng = myINIFile.getStringValue("General","Language","en");
		if(Lng == "en") {
			settings.General.setLanguage(LNG_ENG);
		} else if (Lng == "de") {
			settings.General.setLanguage(LNG_GER);
		} else {
			fprintf(stdout,"INI-File: Invalid Language \"%s\"! Default Language (en) is used.\n",Lng.c_str());
			settings.General.setLanguage(LNG_ENG);
		}

		lookDist[0] = 10;lookDist[1] = 10;lookDist[2] = 9;lookDist[3] = 9;lookDist[4] = 9;lookDist[5] = 8;lookDist[6] = 8;lookDist[7] = 7;lookDist[8] = 6;lookDist[9] = 4;lookDist[10] = 1;

		srand(seed);

		if (argc > 1)	//check for overiding params
		{
			if (strcmp(argv[1], "-f") == 0)
				settings.Video.Fullscreen = true;
			else if (strcmp(argv[1], "-w") == 0)
				settings.Video.Fullscreen = false;
		}

		if (SDL_Init(SDL_INIT_AUDIO | SDL_INIT_TIMER | SDL_INIT_VIDEO) < 0)
		{
			fprintf(stdout, "ERROR: Couldn't initialise SDL: %s\n", SDL_GetError());
			exit(EXIT_FAILURE);
		}
		SDL_EnableUNICODE(1);
		SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);

		SDL_WM_SetCaption("Dune Legacy", "Dune Legacy");

		if(FirstInit == true) {
			fprintf(stdout, "initialising sound..... \t");fflush(stdout);
			if ( Mix_OpenAudio(22050, /*MIX_DEFAULT_FORMAT*/ AUDIO_S16SYS, 2, 1024) < 0 )
			{
				SDL_Quit();
				fprintf(stdout,"Warning: Couldn't set 22050 Hz 16-bit audio\n- Reason: %s\n",SDL_GetError());
				exit(EXIT_FAILURE);
			}
			else
				fprintf(stdout, "allocated %d channels.\n", Mix_AllocateChannels(4)); fflush(stdout);
		}

		if((pFileManager = new FileManager()) == NULL) {
			fprintf(stdout,"main: Cannot create FileManager!\n");
			exit(EXIT_FAILURE);
		}

		SDL_RWops* RWpal = pFileManager->OpenFile("IBM.PAL");

		Palfile* myPalfile = new Palfile(RWpal);
		if(myPalfile == NULL) {
			fprintf(stdout,"main: Cannot load palette IBM.PAL\n");
			exit(EXIT_FAILURE);
		}
		SDL_RWclose(RWpal);

		palette = myPalfile->getCopyOfPalette();
		delete myPalfile;
		screen = NULL;
		setVideoMode();


		fprintf(stdout, "loading fonts.....");fflush(stdout);
		pFontManager = new FontManager();

		fprintf(stdout, "\t\tfinished\n"); fflush(stdout);

		////////load the datafile
		fprintf(stdout, "loading data....."); fflush(stdout);

		//get the house palettes
		houseColour[HOUSE_ATREIDES] = COLOUR_ATREIDES;
		houseColour[HOUSE_ORDOS] = COLOUR_ORDOS;
		houseColour[HOUSE_HARKONNEN] = COLOUR_HARKONNEN;
		houseColour[HOUSE_SARDAUKAR] = COLOUR_SARDAUKAR;
		houseColour[HOUSE_FREMEN] = COLOUR_FREMEN;
		houseColour[HOUSE_MERCENARY] = COLOUR_MERCENARY;

		if((pDataManager = new DataManager()) == NULL) {
			fprintf(stdout,"main: Cannot create DataManager!\n");
			exit(EXIT_FAILURE);
		}

		fprintf(stdout, "\t\tfinished\n"); fflush(stdout);

		GUIStyle::SetGUIStyle(new DuneStyle);

		if(FirstInit == true) {
			fprintf(stdout, "starting sound:\t"); fflush(stdout);
			soundPlayer = new SoundPlayer();
			fprintf(stdout, "\n");

            fprintf(stdout, "starting music player...\t"); fflush(stdout);
			if(settings.Audio.MusicType == "directory") {
			    fprintf(stdout, "playing from music directory\n"); fflush(stdout);
                musicPlayer = new DirectoryPlayer();
			} else if(settings.Audio.MusicType == "adl") {
			    fprintf(stdout, "playing ADL files\n"); fflush(stdout);
                musicPlayer = new ADLPlayer();
			} else if(settings.Audio.MusicType == "xmi") {
			    fprintf(stdout, "playing XMI files\n"); fflush(stdout);
                musicPlayer = new XMIPlayer();
			} else {
                fprintf(stdout, "failed\n"); fflush(stdout);
                exit(EXIT_FAILURE);
			}
		}

		if((settings.General.PlayIntro == true) && (FirstInit==true)) {
			fprintf(stdout, "playing intro.....");fflush(stdout);
			DuneCutScene *introScene = new DuneCutScene();
			introScene->parseScenesFile("data/intro.scene");
		//	introScene->parseScenesFile("data/atrefinale.scene");
		//	introScene->parseScenesFile("data/ordosfinale.scene");
		//	introScene->parseScenesFile("data/harkfinale.scene");
		//	introScene->parseScenesFile("data/credits.scene");
			introScene->playCutScene();
			delete introScene;
			fprintf(stdout, "\t\tfinished\n"); fflush(stdout);
		}

		FirstInit = false;

		fprintf(stdout, "starting main menu.......");fflush(stdout);

		MainMenu * myMenu = new MainMenu();

		fprintf(stdout, "\tfinished\n"); fflush(stdout);

		if(myMenu->showMenu() == -1) {
			ExitGame = true;
		}
		delete myMenu;

		fprintf(stdout, "Deinitialize....."); fflush(stdout);

		GUIStyle::DestroyGUIStyle();

		// clear everything
		if(ExitGame == true) {
		    delete musicPlayer;
			delete soundPlayer;
			Mix_HaltMusic();
			Mix_CloseAudio();
		}

		// destroy palette
		delete [] palette->colors;
		delete palette;

		delete pDataManager;
		delete pFontManager;
		delete pFileManager;
		if(ExitGame == true) {
			SDL_Quit();
		}
		fprintf(stdout, "\t\tfinished\n"); fflush(stdout);
	} while(ExitGame == false);

	// deinit fnkdat
	if(fnkdat(NULL, NULL, 0, FNKDAT_UNINIT) < 0) {
		perror("Could not uninitialize fnkdat");
		exit(EXIT_FAILURE);
	}

	return EXIT_SUCCESS;
}
