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
	printf("Virus Killer (Version %.1f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2004 Parallel Realities\n");
	printf("Licensed under the GPL\n\n");
	
	printf("The Virus Killer gameplay manual can be found in,\n");
	printf("\t%s\n\n", GAMEPLAYMANUAL);

	printf("Additional Commands\n");
	printf("\t-fullscreen         Start the game in Full Screen mode\n");
	printf("\t-mono               Use mono sound output instead of stereo\n");
	printf("\t-noaudio            Disables audio\n");
	printf("\t-version            Display version number\n");
	printf("\t--help              This help\n");
	printf("\t-safemode           Build file information from temp directory (%s)\n\n", TEMPDIR);

	exit(0);
}

void showVersion()
{
	printf("\n");
	printf("Virus Killer (Version %.1f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2004 Parallel Realities\n");
	printf("Licensed under the GPL\n\n");
	exit(0);
}

int main(int argc, char *argv[])
{
	atexit(cleanup);

	bool useSafeMode = false;

	for (int i = 1 ; i < argc ; i++)
	{
		if (strcmp(argv[i], "-fullscreen") == 0) engine.fullScreen = true;
		else if (strcmp(argv[i], "-noaudio") == 0) engine.useAudio = 0;
		else if (strcmp(argv[i], "-mono") == 0) engine.useAudio = 1;
		else if (strcmp(argv[i], "-version") == 0) showVersion();
		else if (strcmp(argv[i], "--help") == 0) showHelp();
		else if (strcmp(argv[i], "-safemode") == 0) useSafeMode = true;
	}

	initSystem();

	if (useSafeMode)
		strcpy(gameData.directorySearchPath, TEMPDIR);

	loadResources();

	engine.loadDefines();
	buildFileList(gameData.directorySearchPath, 0);
	gameData.removeEmptyDirectories();
	engine.defineList.clear();

	int requiredSection = SECTION_TITLE;
	
	while (true)
	{
		switch (requiredSection)
		{
			case SECTION_TITLE:
				requiredSection = doTitle();
				break;
			case SECTION_GAME:
				requiredSection = doGame();
				break;
			case SECTION_HIGHSCORE:
				requiredSection = addHighScore();
				break;
		}
	}

	return 0;
}
