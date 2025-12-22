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

#include "init.h"

/*
Show the GNU Public License the first time the game is played. Waits 4 seconds
and then proceeds. THIS MUST NOT BE REMOVED!!!!!
*/
void showLicense()
{
	graphics.clearScreen(graphics.black);
	graphics.delay(1000);

	SDL_Surface *pic = graphics.loadImage("gfx/main/licensePic.png");
	graphics.blit(pic, 0, 0, graphics.screen, false);
	graphics.fade(185);
	SDL_FreeSurface(pic);

	engine.loadData("data/LICENSE");

	char line[255];
	int y = 0;

	char *token = strtok(engine.dataBuffer, "\n");

	graphics.setFontSize(1);

	while (true)
	{
		sscanf(token, "%d %[^\n]", &y, line);

		graphics.drawString(400, y, true, graphics.screen, line);

		token = strtok(NULL, "\n");

		if (token == NULL)
			break;
	}

	graphics.delay(4000);

	graphics.drawString(400, 540, true, graphics.screen, "Press Space to Continue...");

	engine.flushInput();
	engine.clearInput();

	while (true)
	{
		graphics.updateScreen();
		engine.getInput();
		if (engine.keyState[SDLK_SPACE])
			break;
	}
	
	graphics.clearScreen(graphics.black);
	graphics.delay(500);
}

/*
This bit is just for Linux and Unix users. It attempts to get the user's
home directory, then creates the .parallelrealities and .parallelrealities/q
directories so that saves and temporary data files can be written there. Good, eh? :)
*/
#if UNIX
void setupUserHomeDirectory()
{
	char *userHome;

	char *name = getlogin();

	passwd *pass;

	if (name != NULL)
		pass = getpwnam(name);
	else
		pass = getpwuid(geteuid());

	if (pass == NULL)
	{
		printf("Couldn't determine the user home directory. Exitting.\n");
		exit(1);
	}

	userHome = pass->pw_dir;

	strcpy(gameData.directorySearchPath, userHome);

	debug(("User Home Directory is %s\n", gameData.directorySearchPath));

	char dir[PATH_MAX];
	strcpy(dir, "");

	sprintf(dir, "%s/.parallelrealities", userHome);
	if ((mkdir(dir, S_IRWXU|S_IRWXG|S_IROTH|S_IXOTH) != 0) && (errno != EEXIST))
		exit(1);

	sprintf(dir, "%s/.parallelrealities/virusKiller", userHome);
	if ((mkdir(dir, S_IRWXU|S_IRWXG|S_IROTH|S_IXOTH) != 0) && (errno != EEXIST))
		exit(1);

	char gameSavePath[PATH_MAX];
	sprintf(gameSavePath, "%s/.parallelrealities/virusKiller/", userHome);
	engine.setUserHome(gameSavePath);
}
#endif

bool loadConfig()
{
	char configPath[PATH_MAX];

	sprintf(configPath, "%sconfig", engine.userHomeDirectory);

	debug(("Loading Config from %s\n", configPath));

	FILE *fp = fopen(configPath, "rb");

	if (!fp)
		return true;
		
	fread(&engine.fullScreen, sizeof(int), 1, fp);
	fread(&gameData.soundVolume, sizeof(int), 1, fp);
	fread(&gameData.musicVolume, sizeof(int), 1, fp);
	fread(&gameData.gamma, sizeof(int), 1, fp);

	fread(&gameData.nightmareCount, sizeof(int), 1, fp);

	for (int j = 0 ; j < 5 ; j++)
	{
		for (int i = 0 ; i < 10 ; i++)
		{
			fread(&gameData.highScore[j][i], sizeof(HighScore), 1, fp);
		}
	}

	fclose(fp);

	// Open a config file to get search path, this is mostly for
	// non Linux/Unix users...
	#if !UNIX

		fp = fopen("config.txt", "rb");
		if (!fp)
		{
			printf("Couldn't read the config file... See README.TXT for help\n");
			exit(1);
		}

		char dir[PATH_MAX];
		strcpy(dir, "");

		fscanf(fp, "%[^\n]", dir);

		strcpy(gameData.directorySearchPath, dir);

		debug(("Using '%s' as search path", gameData.directorySearchPath));

		fclose(fp);

	#endif

	return false;
}

void saveConfig()
{
	char configPath[PATH_MAX];

	sprintf(configPath, "%sconfig", engine.userHomeDirectory);

	FILE *fp = fopen(configPath, "wb");

	if (!fp)
	{
		printf("Error Saving Config to %s\n", configPath);
		return;
	}

	fwrite(&engine.fullScreen, sizeof(int), 1, fp);
	fwrite(&gameData.soundVolume, sizeof(int), 1, fp);
	fwrite(&gameData.musicVolume, sizeof(int), 1, fp);
	fwrite(&gameData.gamma, sizeof(int), 1, fp);
	
	fwrite(&gameData.nightmareCount, sizeof(int), 1, fp);

	for (int j = 0 ; j < 5 ; j++)
	{
		for (int i = 0 ; i < 10 ; i++)
		{
			fwrite(&gameData.highScore[j][i], sizeof(HighScore), 1, fp);
		}
	}

	fclose(fp);
}

/*
Chugg chugg chugg.... brrr... chugg chugg chugg...brrrrrr... chugg ch..
BRRRRRRRRRRRRRRRRRMMMMMMMMMMMMMMMMMMM!! Well, hopefully anyway! ;)
*/
void initSystem()
{
	#if UNIX
		setupUserHomeDirectory();
	#endif

	bool displayLicense = loadConfig();

	/* Initialize the SDL library */
	if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO) < 0) {
		printf("Couldn't initialize SDL: %s\n", SDL_GetError());
		exit(1);
	}

	if (!engine.fullScreen)
		graphics.screen = SDL_SetVideoMode(SCREENWIDTH, SCREENHEIGHT, 0, SDL_HWPALETTE);
	else
		graphics.screen = SDL_SetVideoMode(SCREENWIDTH, SCREENHEIGHT, SCREENDEPTH, SDL_HWPALETTE | SDL_FULLSCREEN);

	if (graphics.screen == NULL)
	{
		printf("Couldn't set %dx%dx%d video mode: %s\n", SCREENWIDTH, SCREENHEIGHT, SCREENDEPTH, SDL_GetError());
		exit(1);
	}

	if (TTF_Init() < 0)
	{
		printf("Couldn't initialize SDL TTF: %s\n", SDL_GetError());
		exit(1);
	}

	if (engine.useAudio)
	{
		if (Mix_OpenAudio(22050, AUDIO_S16, engine.useAudio, 1024) < 0)
		{
			printf("Warning: Couldn't set 22050 Hz 16-bit audio - Reason: %s\n", Mix_GetError());
			printf("Sound and Music will be disabled\n");
			engine.useAudio = 0;
		}
	}

	SDL_EventState(SDL_MOUSEMOTION, SDL_DISABLE);
	SDL_ShowCursor(SDL_DISABLE);

	graphics.registerEngine(&engine);
	graphics.mapColors();

	audio.registerEngine(&engine);
	audio.setSoundVolume(gameData.soundVolume);
	audio.setMusicVolume(gameData.musicVolume);

	srand(time(NULL));
	
	#if USEPAK
		remove(TEMPDIR"font.ttf");
		SDL_Delay(1000); // wait one second, just to be sure!
		if (!engine.unpack("data/vera.ttf", PAK_FONT))
			engine.reportFontFailure();
	#endif

	graphics.loadFont(0, "data/vera.ttf", 11);
	graphics.loadFont(1, "data/vera.ttf", 14);
	graphics.loadFont(2, "data/vera.ttf", 22);
	graphics.loadFont(3, "data/vera.ttf", 26);
	graphics.loadFont(4, "data/vera.ttf", 32);

	SDL_WM_SetIcon(graphics.loadImage("gfx/main/alienDevice.png"), NULL);
	SDL_WM_SetCaption("Virus Killer", "Virus Killer");

	if (displayLicense)
		showLicense();
		
	engine.allowQuit = true;
	engine.flushInput();
	engine.clearInput();
}

/*
Removes [hopefully] all the resources that has been
loaded and created during the game. This is called by
atexit();
*/
void cleanup()
{
	debug(("Cleaning Up...\n"));

	debug(("Destroying GameData...\n"));
	gameData.destroy();

	debug(("Freeing Audio...\n"));
	audio.destroy();

	debug(("Closing Audio...\n"));
	if (engine.useAudio)
		Mix_CloseAudio();

	debug(("Freeing Engine Data...\n"));
	engine.destroy();

	debug(("Freeing Graphics...\n"));
	graphics.destroy();

	debug(("Closing SDL Sub System...\n"));
	SDL_Quit();

	saveConfig();

	debug(("All Done.\n"));
}
