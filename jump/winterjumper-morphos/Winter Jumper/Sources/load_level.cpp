#include "_variables.h"

void loadLevel()
{
	fprintf(stdout, "\nattempting to load level %i...\n", LEVEL_NUMBER);
	
	GoodieX = -100;
	GoodieY = -100;

	// RESETS ALL BLINGS
	defineBling();
	// RESETS ALL BLINGS

	// VARIABLES NEEDED IN THIS FUNCTION
	Uint32 temparray[100000];
	int x;
	int y;
	// VARIABLES NEEDED IN THIS FUNCTION

	if(LEVEL_NUMBER > LASTLEVEL) {LEVEL_NUMBER = 1;}
	Giana.direction = 1;
	Giana.jumpcounter = 0;
	Giana.accelleration = 0;
	resetEnemies();

	if(LEVEL_NUMBER == 0){
        Giana.x = 100;
        Giana.y = 50;
		}

	if(LEVEL_NUMBER == 1){
		Giana.x = 17;
		Giana.y = 190;
		Enemy[1].inUse = 1;	Enemy[1].x = 375;	Enemy[1].y = 196;	Enemy[1].type = 1;
		Enemy[2].inUse = 1;	Enemy[2].x = 1900;	Enemy[2].y = 197;	Enemy[2].type = 2;
		Enemy[3].inUse = 1;	Enemy[3].x = 700;	Enemy[3].y = 197;	Enemy[3].type = 2;
		Enemy[4].inUse = 1;	Enemy[4].x = 1350;	Enemy[4].y = 197;	Enemy[4].type = 2;
		Enemy[5].inUse = 1;	Enemy[5].x = 1550;	Enemy[5].y = 200;	Enemy[5].type = 3;
		Enemy[6].inUse = 1;	Enemy[6].x = 600;	Enemy[6].y = 100;	Enemy[6].type = 5;
		}

	if(LEVEL_NUMBER == 2){
		Giana.x = 30;
		Giana.y = 50;
		Enemy[1].inUse = 1;	Enemy[1].x = 180;	Enemy[1].y = 195;	Enemy[1].type = 3;
		Enemy[2].inUse = 1;	Enemy[2].x = 375;	Enemy[2].y = 191;	Enemy[2].type = 1;
		Enemy[3].inUse = 1;	Enemy[3].x = 650;	Enemy[3].y = 195;	Enemy[3].type = 3;
		Enemy[4].inUse = 1;	Enemy[4].x = 750;	Enemy[4].y = 195;	Enemy[4].type = 3;
		Enemy[5].inUse = 1;	Enemy[5].x = 1000;	Enemy[5].y = 195;	Enemy[5].type = 3;	Enemy[5].direction = 1;
		Enemy[6].inUse = 1;	Enemy[6].x = 1160;	Enemy[6].y = 206;	Enemy[6].type = 2;
		Enemy[7].inUse = 1;	Enemy[7].x = 1500;	Enemy[7].y = 190;	Enemy[7].type = 2;
		Enemy[8].inUse = 1;	Enemy[8].x = 1800;	Enemy[8].y = 110;	Enemy[8].type = 5;
		}

	if(LEVEL_NUMBER == 3){
		Giana.x = 17;
		Giana.y = 187;
		Enemy[1].inUse = 1;	Enemy[1].x = 250;	Enemy[1].y = 199;	Enemy[1].type = 1;
		Enemy[2].inUse = 1;	Enemy[2].x = 300;	Enemy[2].y = 199;	Enemy[2].type = 1;
		Enemy[3].inUse = 1;	Enemy[3].x = 510;	Enemy[3].y = 171;	Enemy[3].type = 3;
		Enemy[4].inUse = 1;	Enemy[4].x = 800;	Enemy[4].y = 198;	Enemy[4].type = 2;
		Enemy[5].inUse = 1;	Enemy[5].x = 750;	Enemy[5].y = 86;	Enemy[5].type = 2;
		Enemy[6].inUse = 1;	Enemy[6].x = 1580;	Enemy[6].y = 199;	Enemy[6].type = 1;
		}

	if(LEVEL_NUMBER == 4){
		Giana.x = 17;
		Giana.y = 120;
		Enemy[1].inUse = 1;	Enemy[1].x = 350;	Enemy[1].y = 120;	Enemy[1].type = 3;
		Enemy[2].inUse = 1;	Enemy[2].x = 645;	Enemy[2].y = 200;	Enemy[2].type = 3;
		Enemy[3].inUse = 1;	Enemy[3].x = 625;	Enemy[3].y = 200;	Enemy[3].type = 1;
		Enemy[4].inUse = 1;	Enemy[4].x = 1550;	Enemy[4].y = 190;	Enemy[4].type = 3;
		Enemy[5].inUse = 1;	Enemy[5].x = 1700;	Enemy[5].y = 190;	Enemy[5].type = 2;
		Enemy[6].inUse = 1;	Enemy[6].x = 1800;	Enemy[6].y = 190;	Enemy[6].type = 2;
		}

	if(LEVEL_NUMBER == 5){
		Giana.x = 17;
		Giana.y = 190;
		Enemy[1].inUse = 1;	Enemy[1].x = 388;	Enemy[1].y = 171;	Enemy[1].type = 1;
		Enemy[2].inUse = 1;	Enemy[2].x = 605;	Enemy[2].y = 112;	Enemy[2].type = 1;
		Enemy[3].inUse = 1;	Enemy[3].x = 700;	Enemy[3].y = 100;	Enemy[3].type = 3;
		Enemy[4].inUse = 1;	Enemy[4].x = 900;	Enemy[4].y = 190;	Enemy[4].type = 3;
		Enemy[5].inUse = 1;	Enemy[5].x = 1150;	Enemy[5].y = 190;	Enemy[5].type = 3;
		Enemy[6].inUse = 1;	Enemy[6].x = 1261;	Enemy[6].y = 130;	Enemy[6].type = 1;
		Enemy[7].inUse = 1;	Enemy[7].x = 1580;	Enemy[7].y = 180;	Enemy[7].type = 1;
		Enemy[8].inUse = 1;	Enemy[8].x = 1750;	Enemy[8].y = 65;	Enemy[8].type = 5;
		}
    
	FILE* levelfile;
	if(LEVEL_NUMBER == 0){levelfile = fopen("intro.txt",  "r");}
	if(LEVEL_NUMBER == 1){levelfile = fopen("level1.txt", "r");}
	if(LEVEL_NUMBER == 2){levelfile = fopen("level2.txt", "r");}
	if(LEVEL_NUMBER == 3){levelfile = fopen("level3.txt", "r");}
	if(LEVEL_NUMBER == 4){levelfile = fopen("level4.txt", "r");}
	if(LEVEL_NUMBER == 5){levelfile = fopen("level5.txt", "r");}

	if(LEVEL_NUMBER == 0){LevelBackgroundColour = 0;}
	if(LEVEL_NUMBER == 1){LevelBackgroundColour = 0;}
	if(LEVEL_NUMBER == 2){LevelBackgroundColour = 1;}
	if(LEVEL_NUMBER == 3){LevelBackgroundColour = 0;}
	if(LEVEL_NUMBER == 4){LevelBackgroundColour = 1;}
	if(LEVEL_NUMBER == 5){LevelBackgroundColour = 0;}

	if (levelfile == NULL)
	{
		 // file doesn't exist
		fprintf(stderr,"LEVEL %i NOT FOUND!!!", LEVEL_NUMBER);
	}
	else
	{
		 // file exists
		fprintf(stdout,"level %i found...\n", LEVEL_NUMBER);
		// write levelinformation into an array 
		for (x = 0; x < TOTAL_TILES; x++)
		{
			fscanf(levelfile, "%i,", &temparray[x]);
		}
		// write the temporary array into the level-array
		//(don't know how to write into a 2d array directly, yet)
		for(y = 0; y < LEVEL_HEIGHT; y++)
		{
			for (x = 0; x < LEVEL_WIDTH; x++)
			{
				TileArray[x][y] = temparray[y * LEVEL_WIDTH + x];
			}
		}

		fprintf(stdout,"level %i loaded correctly...\n", LEVEL_NUMBER);
		fclose(levelfile);
		
		// writing level-array to stdout, to test if level was loaded correctly
		/*
		for(y = 0; y < LEVEL_HEIGHT; y++)
		{
	        for (x = 0; x < LEVEL_WIDTH; x++)
			{
				fprintf(stdout, "%i", TileArray[x][y]);
				if(x != LEVEL_WIDTH - 1)
				{
					fprintf(stdout, ",");
				}
			}
				fprintf(stdout,"\n");
		}
		*/

	}
}
