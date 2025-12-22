#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <SDL/SDL.h>
#include "img.h"
#include "cplayer.h"
#include "cbrick.h"

struct SBox {
	int x;
	int y;
} box[80];

SDL_Surface *screen;
cplayer players[4];
int activeplayer;
int numberofplayers;
int dice;
int counter;

int SelectMove() {
	int notfound = true;
	int selected;
	do {
		SDL_Event event;
		while (SDL_PollEvent(&event)) {
			if (event.type == SDL_QUIT) { exit(1); }
			if (event.type == SDL_KEYDOWN) {
				int i;
				switch (event.key.keysym.sym) {
					case SDLK_1: i = 0;	break;
					case SDLK_2: i = 1; break;
					case SDLK_3: i = 2; break;
					case SDLK_4: i = 3; break;
				}
				if (i == 0 || i == 1 || i == 2 || i == 3) {
					if (players[activeplayer].bricks[i].field == 0 && dice == 6 && players[activeplayer].bricks[i].home == false) return i;
					if (players[activeplayer].bricks[i].field != 0 && players[activeplayer].bricks[i].home == false) return i;
					if (players[activeplayer].bricks[i].field == 0 && dice != 6) printf("\tIllegal move. Selected brick can only leave HB if you get a 6.\n");
				}
			}
		}
	} while (notfound);
	return 1;
}

int RollDice() {
	return rand()%6+1;
}

void setBox(int n, int x1, int y1) {
	box[n+1].x = x1;
	box[n+1].y = y1;
}

void LoadBoxes() {
	setBox(0, 32, 192);
	setBox(1, 64, 192);
	setBox(2, 96, 192);
	setBox(3, 128, 192);
	setBox(4, 160, 192);
	setBox(5, 192, 160);
	setBox(6, 192, 128);
	setBox(7, 192, 96);
	setBox(8, 192, 64);
	setBox(9, 192, 32);
	setBox(10, 192, 0);
	setBox(11, 224, 0);
	setBox(12, 256, 0);
	setBox(13, 256, 32);
	setBox(14, 256, 64);
	setBox(15, 256, 96);
	setBox(16, 256, 128);
	setBox(17, 256, 160);
	setBox(18, 288, 192);
	setBox(19, 320, 192);
	setBox(20, 352, 192);
	setBox(21, 384, 192);
	setBox(22, 416, 192);
	setBox(23, 448, 192);
	setBox(24, 448, 224);
	setBox(25, 448, 256);
	setBox(26, 416, 256);
	setBox(27, 384, 256);
	setBox(28, 352, 256);
	setBox(29, 320, 256);
	setBox(30, 288, 256);
	setBox(31, 256, 288);
	setBox(32, 256, 320);
	setBox(33, 256, 352);
	setBox(34, 256, 384);
	setBox(35, 256, 416);
	setBox(36, 256, 448);
	setBox(37, 224, 448);
	setBox(38, 192, 448);
	setBox(39, 192, 416);
	setBox(40, 192, 384);
	setBox(41, 192, 352);
	setBox(42, 192, 320);
	setBox(43, 192, 288);
	setBox(44, 160, 256);
	setBox(45, 128, 256);
	setBox(46, 96, 256);
	setBox(47, 64, 256);
	setBox(48, 32, 256);
	setBox(49, 0, 256);
	setBox(50, 0, 224);
	setBox(51, 0, 192);
	// Player 1 lane
	setBox(52, 32, 224);
	setBox(53, 64, 224);
	setBox(54, 96, 224);
	setBox(55, 128, 224);
	setBox(56, 160, 224);
	setBox(57, 192, 224);
	// Player 2 lane
	setBox(58, 224, 32);
	setBox(59, 224, 64);
	setBox(60, 224, 96);
	setBox(61, 224, 128);
	setBox(62, 224, 160);
	setBox(63, 224, 192);
	// Player 3 lane
	setBox(64, 416, 224);
	setBox(65, 384, 224);
	setBox(66, 352, 224);
	setBox(67, 320, 224);
	setBox(68, 288, 224);
	setBox(69, 256, 224);
	// Player 4 lane
	setBox(70, 224, 416);
	setBox(71, 224, 384);
	setBox(72, 224, 352);
	setBox(73, 224, 320);
	setBox(74, 224, 288);
	setBox(75, 224, 256);
}

void DrawBox(int x, int y, int R, int G, int B) {
	SDL_Rect rect = {x, y, 32, 32};
	SDL_FillRect(screen, &rect, SDL_MapRGB(screen->format, 0, 0, 0));
	SDL_Rect rect2 = {x+2, y+2, 28, 28};
	SDL_FillRect(screen, &rect2, SDL_MapRGB(screen->format, R, G, B));
}

void DrawBox(int x, int y) {
	DrawBox(x, y, 255, 255, 255);
}

void DrawScene() {

	SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 0, 0));

	// Draw board
	SDL_Rect rect = {0, 0, 192, 192};
	SDL_Rect rect2 = {0, 288, 192, 192};
	SDL_Rect rect3 = {288, 0, 192, 192};
	SDL_Rect rect4 = {288, 288, 192, 192};
	SDL_FillRect(screen, &rect, SDL_MapRGB(screen->format, 200, 200, 0));
	SDL_FillRect(screen, &rect4, SDL_MapRGB(screen->format, 0, 200, 0));
	SDL_FillRect(screen, &rect2, SDL_MapRGB(screen->format, 200, 0, 0));
	SDL_FillRect(screen, &rect3, SDL_MapRGB(screen->format, 0, 0, 200));
	for (int i = 1; i <= 52; i++) {
		DrawBox(box[i].x, box[i].y);
	}
	for (int i = 53; i <= 58; i++) {
		DrawBox(box[i].x, box[i].y, 200, 200, 0);
	}
	for (int i = 59; i <= 64; i++) {
		DrawBox(box[i].x, box[i].y, 0, 0, 200);
	}
	for (int i = 65; i <= 70; i++) {
		DrawBox(box[i].x, box[i].y, 0, 200, 0);
	}
	for (int i = 71; i <= 76; i++) {
		DrawBox(box[i].x, box[i].y, 200, 0, 0);
	}
	// Player home bases
	DrawBox(32, 32); DrawBox(32, 128); DrawBox(128, 32); DrawBox(128, 128);
	DrawBox(320, 32); DrawBox(320, 128); DrawBox(416, 32); DrawBox(416, 128);
	DrawBox(32, 320); DrawBox(128, 320); DrawBox(32, 416); DrawBox(128, 416);
	DrawBox(320, 320); DrawBox(320, 416); DrawBox(416, 320); DrawBox(416, 416);

	// Draw stars and globes
	IMG globe("gfx/globe.bmp");
	IMG star("gfx/star.bmp");
	globe.draw(box[1].x+3, box[1].y+3);
	globe.draw(box[9].x+3, box[9].y+3);
	globe.draw(box[14].x+3, box[14].y+3);
	globe.draw(box[22].x+3, box[22].y+3);
	globe.draw(box[27].x+3, box[27].y+3);
	globe.draw(box[35].x+3, box[35].y+3);
	globe.draw(box[40].x+3, box[40].y+3);
	globe.draw(box[48].x+3, box[48].y+3);
	star.draw(box[6].x+3, box[6].y+3);
	star.draw(box[12].x+3, box[12].y+3);
	star.draw(box[19].x+3, box[19].y+3);
	star.draw(box[25].x+3, box[25].y+3);
	star.draw(box[32].x+3, box[32].y+3);
	star.draw(box[38].x+3, box[38].y+3);
	star.draw(box[45].x+3, box[45].y+3);
	star.draw(box[51].x+3, box[51].y+3);

	SDL_Rect rect5 = {482, 0, 800, 600};
	SDL_FillRect(screen, &rect5, SDL_MapRGB(screen->format, 255, 255, 255));

	SDL_Rect rect6 = {480, 0, 800, 55};
	SDL_FillRect(screen, &rect6, SDL_MapRGB(screen->format, 0, 0, 0));

	IMG logo("gfx/heroludo.bmp");
	logo.draw(480, 0);

	// Players + active player
	IMG playername;
	IMG active("gfx/active.bmp");
	for (int i = 1; i <= numberofplayers; i++) {
		char buffer[80];
		sprintf(buffer, "gfx/player%d.bmp", i);
		playername.load(buffer);
		playername.draw(520, 120+(i-1)*110);
		if (activeplayer+1 == i) {
			active.draw(505, 135+(i-1)*110);
		}
	}

	// Draw Dice
	IMG diceimg;
	char buffer[80];
	sprintf(buffer, "gfx/dice%d.bmp", dice);
	diceimg.load(buffer);
	diceimg.draw(630, 60);

	// Draw player bricks
	for (int i = 0; i <= numberofplayers-1; i++) {
		for (int j = 0; j <= 3; j++) {
			int x, y;
			if (players[i].bricks[j].field == 0) {
				switch (i) {
					case 0:
						switch (j) {
							case 0: x = 32; y = 32; break;
							case 1: x = 128; y = 32; break;
							case 2: x = 32; y = 128; break;
							case 3: x = 128; y = 128; break;
						}
						break;
					case 1:
						switch (j) {
							case 0: x = 320; y = 32; break;
							case 1: x = 416; y = 32; break;
							case 2: x = 320; y = 128; break;
							case 3: x = 416; y = 128; break;
						}
						break;
					case 2:
						switch (j) {
							case 0: x = 320; y = 320; break;
							case 1: x = 416; y = 320; break;
							case 2: x = 320; y = 416; break;
							case 3: x = 416; y = 416; break;
						}
						break;
					case 3:
						switch (j) {
							case 0: x = 32; y = 320; break;
							case 1: x = 128; y = 320; break;
							case 2: x = 32; y = 416; break;
							case 3: x = 128; y = 416; break;
						}
						break;
				}
			} else if (players[i].bricks[j].home) {
					x = 550 + j*50;
					y = 280+(i-1)*110;
			} else {
				x = box[players[i].bricks[j].field].x;
				y = box[players[i].bricks[j].field].y;
			}
			IMG brick;
			char buffer[80];
			sprintf(buffer, "gfx/player%d-%d.bmp", i+1, j+1);
			brick.load(buffer);
			brick.draw(x+3, y+3);
		}
	}
	SDL_Flip(screen);
}

int main(int argc, char *argv[]) {
    // Read in number of players
    //----------------------------------------------
    numberofplayers = 4;
    if (argc > 1) {
        numberofplayers = atoi(argv[1]);
    }
    printf("%d\n", numberofplayers);

    // Initialize SDL Library
	//----------------------------------------------
	if (SDL_Init(SDL_INIT_AUDIO|SDL_INIT_VIDEO) <0) {
		fprintf(stderr, "Couldn't initialize SDL:%s\n", SDL_GetError());
		exit(1);
	}

	// Set clean-up command
	//----------------------------------------------
	atexit(SDL_Quit);

	// Initialize the display in a 640x480 32-bit
	// palattized mode or return error and exit.
	//----------------------------------------------
	screen = SDL_SetVideoMode(800, 600, 32, SDL_SWSURFACE|SDL_DOUBLEBUF);
	if (screen == NULL) {
		fprintf(stderr, "Couldn't set 800x600x32 video mode: %s\n", SDL_GetError());
		exit(1);
	}

	// Set windows title and icon = NULL
	//----------------------------------------------
	SDL_WM_SetCaption("Hero Ludo", NULL);

	// Load board field boxes
	//----------------------------------------------
	LoadBoxes();


	// Init 4 human players
	// TODO: Make it possible to select humans/ai
	//----------------------------------------------
	players[0].set("Player 1", 1);
	players[1].set("Player 2", 2);
	players[2].set("Player 3", 3);
	players[3].set("player 4", 4);

	// Init randomizer
	//----------------------------------------------
	srand(time(NULL));

	// Set the activeplayer to player 1
	//----------------------------------------------
	activeplayer = 0;

	// Start game loop
	int gamerunning = true;
	while (gamerunning) {
		SDL_Event event;

		// New player turn
		//-------------------------------------------
		int playerturn = true;
		counter = 1;
		printf("---- Player %d's turn - onfield = %d ----\n", activeplayer+1, players[activeplayer].onField);
		char buffer[80];
		sprintf(buffer, "SDL Ludo - Player %d", activeplayer+1);
		SDL_WM_SetCaption(buffer, NULL);

		do {
			// Throw dice
			// TODO: Create dice class
			//-----------------------------------------
			dice = RollDice();
            /*
			printf("\tStatus: Dice throw %d=%d - B1=%d|%d B2=%d|%d B3=%d|%d B4=%d|%d\n", counter, dice,
					players[activeplayer].bricks[0].fieldsmoved, players[activeplayer].bricks[0].field,
                    players[activeplayer].bricks[1].fieldsmoved, players[activeplayer].bricks[1].field,
					players[activeplayer].bricks[2].fieldsmoved, players[activeplayer].bricks[2].field,
                    players[activeplayer].bricks[3].fieldsmoved, players[activeplayer].bricks[3].field);
            */
			for (int f=0; f<=numberofplayers-1; f++) {
				for (int g=0; g<=3; g++) {
					if (players[f].bricks[g].home) {
						printf("\tPlayer %d brick %d - I am home\n", f+1, g+1);
					}
				}
			}
			DrawScene();

			// Check if player should get another turn
			//-----------------------------------------
			if ((players[activeplayer].onField == 0) && (dice != 6) && (counter < 3)) {
				counter++;
				continue;
			}

			// Go to next player
			//-----------------------------------------
			if ((dice != 6) && ( counter >= 3)) {
				break;
			}

			// Let user select what move he want to make
			//------------------------------------------
			int i = SelectMove();

			// If selected brick moves out from homebase
			// increase players onField number
			//------------------------------------------
			if (players[activeplayer].bricks[i].field == 0 && dice == 6) {
				players[activeplayer].onField++;
			}

			// Move the selected brick
			//------------------------------------------
			players[activeplayer].bricks[i].doMove(dice);
			if (players[activeplayer].bricks[i].home) {
				players[activeplayer].onField--;
			}
			
			// Check if players bricks is all home
			//------------------------------------------
			int home = 0;
			for (int j = 0; j <= 3; j++) {
				if (players[activeplayer].bricks[j].home) {
					home++;
				}
			}
			
			if (home == 4) {
				printf("Player %d won the game\n", activeplayer+1);
				exit(0);
			}

			// Check if brick kicked someone home
			//------------------------------------------
			for (int j = 0; j <= numberofplayers-1; j++) {
				if (j == activeplayer) continue; // No reason to check own bricks

				for (int k = 0; k <= 3; k++) {
					if (players[activeplayer].bricks[i].field == players[j].bricks[k].field && players[activeplayer].bricks[i].home == false && players[j].bricks[k].home == false) {
							players[j].bricks[k].field = 0;
							players[j].onField--;
							players[j].bricks[k].fieldsmoved = 0;
							printf("\tBrick kicked Player %d's brick #%d home!\n", j+1, k+1);
					}
				}
			}

			// If player got a 6 let him throw again
			//------------------------------------------
			if (dice == 6) {
				counter = 1;
				continue;
			}

			// Draw screen before next playerturn
			//------------------------------------------
			DrawScene();

			// Exit player loop
			//------------------------------------------
			playerturn = false;
		} while (playerturn);

		// Select next player and rerun playerloop
		//--------------------------------------------
		activeplayer++;
		if (activeplayer == numberofplayers) {
			activeplayer = 0;
		}
	}
}
