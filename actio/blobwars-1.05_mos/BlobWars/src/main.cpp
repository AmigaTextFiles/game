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

#include "main.h"

void showHelp()
{
	printf("\n");
	printf("Blob Wars, Episode I - Metal Blob Solid (Version %.2f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2004 Parallel Realities\n");
	printf("Licensed under the GNU General Public License (GPL)\n\n");

	printf("The Metal Blob Solid gameplay manual can be found in,\n");
	printf("\t%s\n\n", GAMEPLAYMANUAL);

	printf("Additional Commands\n");
	printf("\t-fullscreen         Start the game in Full Screen mode\n");
	printf("\t-mono               Use mono sound output instead of stereo\n");
	printf("\t-noaudio            Disables audio\n");
	printf("\t-version            Display version number\n");
	printf("\t--help              This help\n\n");

	exit(0);
}

void showVersion()
{
	printf("\n");
	printf("Blob Wars, Episode I - Metal Blob Solid (Version %.2f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2004 Parallel Realities\n");
	printf("Licensed under the GNU General Public License (GPL)\n\n");
	exit(0);
}

int main(int argc, char *argv[])
{
	#if !USEPAK
	debug(("Not Using PAK...\n"));
	#endif

	atexit(cleanup);

	int requiredSection = SECTION_INTRO;
	bool showSprites = false;
	bool hub = false;

	for (int i = 1 ; i < argc ; i++)
	{
		if (strcmp(argv[i], "-fullscreen") == 0) engine.fullScreen = true;
		else if (strcmp(argv[i], "-noaudio") == 0) engine.useAudio = 0;
		else if (strcmp(argv[i], "-mono") == 0) engine.useAudio = 1;
		else if (strcmp(argv[i], "-version") == 0) showVersion();
		else if (strcmp(argv[i], "--help") == 0) showHelp();
		
		#if !USEPAK
		else if (strcmp(argv[i], "-map") == 0) {game.setMapName(argv[++i]); requiredSection = SECTION_GAME;}
		else if (strcmp(argv[i], "-skill") == 0) game.skill = atoi(argv[++i]);
		else if (strcmp(argv[i], "-showsprites") == 0) showSprites = true;
		else if (strcmp(argv[i], "-hub") == 0) hub = true;
		else if (strcmp(argv[i], "-randomscreens") == 0) graphics.takeRandomScreenShots = true;
		else if (strcmp(argv[i], "-nomonsters") == 0) engine.devNoMonsters = true;
		else if (strcmp(argv[i], "-credits") == 0) requiredSection = SECTION_CREDITS;
		#endif
	}
	
	#if DEMO
		game.setMapName("data/floodedTunnel1");
		requiredSection = SECTION_GAME;
		game.skill = 1;
	#endif

	initSystem();

	player.setName("Player");

	engine.flushInput();
	
	engine.allowQuit = true;

	if (hub)
	{
		requiredSection = SECTION_HUB;
		loadGame(0);
		loadResources();
	}
	
	if (game.skill == 3)
	{
		game.hasAquaLung = game.hasJetPack = true;
	}

	if (showSprites)
	{
		showAllSprites();
	}

	while (true)
	{
		switch (requiredSection)
		{
			case SECTION_INTRO:
				requiredSection = doIntro();
				break;

			case SECTION_TITLE:
				requiredSection = title();
				break;

			case SECTION_HUB:
				requiredSection = doHub();
				break;

			case SECTION_GAME:
				if (!game.continueFromCheckPoint)
				{
					#if DEMO
						showDemoStart();
					#endif
					checkStartCutscene();
					loadResources();
				}
				requiredSection = doGame();
				break;

			case SECTION_GAMEOVER:
				requiredSection = gameover();
				break;
				
			case SECTION_EASYOVER:
				map.clear();
				game.clear();
				easyGameFinished();
				requiredSection = SECTION_TITLE;
				break;
				
			case SECTION_CREDITS:
				doCredits();
				requiredSection = SECTION_TITLE;
				break;
		}
	}

	return 0;
}
