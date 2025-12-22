// Copyright Andrew Williams and the University of Bolton
// Do what you like with the program, but please include your 
// sourcecode with any distribution and retain my copyright notices

#define GP2X      (1)

#include "math.h"

#include "SDL.h"
#include "SDL_mixer.h"

#include "AWSprite.h"
#include "AWMagazine.h"
#include "AWFont.cpp"
#include "joystickmapping.h"
#include "AWSplashScreen.cpp"
#include "BulbSocket.h"

#define WIDTH				(320)
#define HEIGHT				(240)

#define SNOWSPEED			(0.6f)
#define FAST				(1)
#define HOWMANYSOCKETS     	(7)
#define BULBHANDOFFSETX		(6)
#define BULBHANDOFFSETY		(9)


#ifdef GP2X
#define BULBMULTIPLIER		(1)
#define SNOWFREQUENCY		(30)
#define POWERMULTIPLIER		(0.153f)
#else
#define BULBMULTIPLIER		(8)
#define SNOWFREQUENCY		(300)
#define POWERMULTIPLIER		(0.138f)
#endif

// Show how long the city has lasted
void report_time(Uint32 startTicks, Uint32 timeNow, AWFont *font, int xStart, int yStart) {
	Uint32 elapsedTime, elapsedSeconds, elapsedHundredths;
	char timeString[16];	

	elapsedTime = timeNow - startTicks;
	elapsedSeconds = elapsedTime / 1000;
	elapsedHundredths = (elapsedTime - (1000*elapsedSeconds)) / 10;
	snprintf(timeString, 16, "%02d.%02d", elapsedSeconds, elapsedHundredths);
	int endX = font->print_string(timeString, xStart, yStart);
}


int main ( int argc, char *argv[] )
{
	Uint32 startTicks; 	
	Uint32 timeNow;
	double snowSpeed = SNOWSPEED;
	int endX; // Used for text output
	int lxMove;
	Uint32 launchX = 155*BULBMULTIPLIER;
	bool firing = false;
	Uint32 bu, bs; // Counting variables
	int howManyDone = 0;
	bool musicPlayed = false;
						
	/* initialize SDL */
	SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK | SDL_INIT_TIMER | SDL_INIT_AUDIO);

	// Open up the Audio
	/* We're going to be requesting certain things from 
	   our audio device, so we set them up beforehand 
	*/
	/* Mix_OpenAudio takes as its parameters 
	   the audio format we'd _like_ to have. 
	*/
 	if(Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, AUDIO_S16, MIX_DEFAULT_CHANNELS, 128) < 0) {
 		printf("Unable to open audio!\n");
		exit(1);
	}

	Mix_Chunk *bloop = NULL;
	bloop = Mix_LoadWAV("bloop.wav");
	Mix_Chunk *floop = NULL;
	floop = Mix_LoadWAV("floop.wav");
	Mix_Music *jingle = NULL;
	jingle = Mix_LoadMUS("jinglebells.ogg");
	if(!jingle) {
		printf("Error loading jingle bells: %s\n", Mix_GetError());
		exit(1);
	}

	/* set the title bar */
	SDL_WM_SetCaption("Christmas Tree", "Tree");

	/* create window */
	SDL_Surface* screen = SDL_SetVideoMode(320, 240, 0, 0);

	// Open up the joystick
	SDL_Joystick *joystick;
	SDL_JoystickEventState(SDL_ENABLE);
	joystick = SDL_JoystickOpen(0);

	// Disable the cursor
	SDL_ShowCursor(SDL_DISABLE);

	
	// load backdrop
	SDL_Surface* temp = SDL_LoadBMP("city.bmp");
	SDL_Surface* bg = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);

	AWMagazine *snow = new AWMagazine(125, "snow.bmp", 6);
	snow->set_transparent_colour(0, 0, 0);

	AWSprite *window = new AWSprite("window.bmp", 1);
	window->set_world_position(0, 0);
	window->set_transparent_colour(0, 0, 0);

	AWSprite *clock = new AWSprite("clock.bmp", 4);
	clock->set_transparent_colour(0, 0, 0);
	clock->set_world_position(280, 4);
	clock->set_auto_animate(250);
	
	AWSprite *tree = new AWSprite("tree2.bmp", 1);
	tree->set_world_position(60, 16);
	tree->set_transparent_colour(0, 0, 101);
		
	// The "extra" frame at the end makes it easier to achieve maximum power
	AWSprite *power = new AWSprite("power2.bmp", 26);
	power->set_world_position(3, 210);
	power->set_auto_animate(120);

	AWSprite *hand = new AWSprite("hand.bmp", 1);
	hand->set_transparent_colour(0,0,0);
	hand->set_world_position(155, 215);

	AWSprite *launcher = new AWSprite("bulb.bmp", 2);
	launcher->set_transparent_colour(255, 255, 255);
	launcher->set_world_position(hand->get_x()+BULBHANDOFFSETX, hand->get_y()+BULBHANDOFFSETY);
 	
	AWMagazine *bulbs = new AWMagazine(1, "bulb.bmp", 2);
	bulbs->set_transparent_colour(255, 255, 255);
	
	// These are the sockets for the lights on the tree
	BulbSocket *bSocket[HOWMANYSOCKETS];
	bSocket[0] = new BulbSocket("socket.bmp", 2);
	bSocket[0]->set_world_position(143, 31);
	bSocket[0]->set_transparent_colour(255, 255, 255);
	bSocket[0]->set_auto_animate(400);
	bSocket[1] = new BulbSocket("socket.bmp", 2);
	bSocket[1]->set_world_position(99, 96);
	bSocket[1]->set_transparent_colour(255, 255, 255);
	bSocket[1]->set_auto_animate(400);
	bSocket[2] = new BulbSocket("socket.bmp", 2);
	bSocket[2]->set_world_position(196, 87);
	bSocket[2]->set_transparent_colour(255, 255, 255);
	bSocket[2]->set_auto_animate(400);
	bSocket[3] = new BulbSocket("socket.bmp", 2);
	bSocket[3]->set_world_position(138, 112);
	bSocket[3]->set_transparent_colour(255, 255, 255);
	bSocket[3]->set_auto_animate(400);
	bSocket[4] = new BulbSocket("socket.bmp", 2);
	bSocket[4]->set_world_position(133, 65);
	bSocket[4]->set_transparent_colour(255, 255, 255);
	bSocket[4]->set_auto_animate(400);
	bSocket[5] = new BulbSocket("socket.bmp", 2);
	bSocket[5]->set_world_position(115, 145);
	bSocket[5]->set_transparent_colour(255, 255, 255);
	bSocket[5]->set_auto_animate(400);
	bSocket[6] = new BulbSocket("socket.bmp", 2);
	bSocket[6]->set_world_position(173, 136);
	bSocket[6]->set_transparent_colour(255, 255, 255);
	bSocket[6]->set_auto_animate(400);
	
	AWMagazine *lights = new AWMagazine(10, "lights.bmp", 8);
	lights->set_transparent_colour(255, 255, 255);
		 
	AWFont *font = new AWFont("vera.bmp", "vera.dat");

	SDL_Event event;
	int gameover = 0;
   
	// Start the timer
	startTicks = SDL_GetTicks();
	srand(startTicks);

	/* game loop*/
	while (!gameover)
	{
		// Every now and again, introduce a snowflake
		int r = rand() % SNOWFREQUENCY;
		if(r==0) {
			AWBullet *snowflake = snow->allocate_a_bullet();
			if(snowflake != NULL) {
				int snowX;
				snowX = (rand() % 320);
				snowflake->set_world_position(snowX, 0);
				if(howManyDone >= HOWMANYSOCKETS) {
					snowflake->set_animation_subset(1, 5);
					snowflake->set_auto_animate(250);
				}
				float velX;
				float r = ((float)rand() / ((float)(RAND_MAX)+(float)(1)) );
				if(snowX > WIDTH/2) {
				velX = -(r*0.15f);
				} else {
					velX = +(r*0.15f);
				}
				snowflake->set_velocities(velX, snowSpeed);
				snowflake->set_auto_move(30);
			}
		}

		/* look for an event */
		if (SDL_PollEvent(&event)) {
		  switch (event.type) {
			case SDL_QUIT:
			  gameover = 1;
			  break;
			case SDL_KEYDOWN:
			  switch (event.key.keysym.sym) {
				case SDLK_ESCAPE:
				case SDLK_q:
				  gameover = 1;
				  break;
				case SDLK_LEFT:
				  lxMove = -FAST;
				  break;
				case SDLK_RIGHT:
				  lxMove = +FAST;
				  break;
				case SDLK_SPACE:
				  firing = true;
				  break;
			  }
			  break;
			case SDL_KEYUP:
			  switch (event.key.keysym.sym) {
				case SDLK_LEFT:
				  if(lxMove < 0) lxMove = 0;
				  break;
				case SDLK_RIGHT:
				  if(lxMove > 0) lxMove = 0;
				  break;
				case SDLK_SPACE:
				  firing = false;
				  break;
			  }
			  break;

			case SDL_JOYBUTTONDOWN:  /* Joystick Button Press */
				switch (event.jbutton.button) {
					case GP2X_BUTTON_SELECT:
						gameover = 1;
						break;
					case GP2X_BUTTON_R:
						lxMove = +FAST;
						break;
					case GP2X_BUTTON_L:
						lxMove = -FAST;
						break;
					case GP2X_BUTTON_LEFT:
						lxMove = -FAST;
						break;
					case GP2X_BUTTON_RIGHT: 
						lxMove = +FAST;
						break;
					case GP2X_BUTTON_UPLEFT: 
						lxMove = -FAST;
						break;
					case GP2X_BUTTON_UPRIGHT: 
						lxMove = +FAST;
						break;
					case GP2X_BUTTON_DOWNLEFT: 
						lxMove = -FAST;
						break;
					case GP2X_BUTTON_DOWNRIGHT: 
						lxMove = +FAST;
						break;
					case GP2X_BUTTON_A:
					case GP2X_BUTTON_B:
					case GP2X_BUTTON_X:
					case GP2X_BUTTON_Y:
						firing = true;
						break;
				}				
				break;
			case SDL_JOYBUTTONUP:  /* Joystick Button Release */
				switch (event.jbutton.button) {
					case GP2X_BUTTON_R:
						if(lxMove > 0) lxMove = 0; 
						break;
					case GP2X_BUTTON_L:
						if(lxMove < 0) lxMove = 0;
						break;
					case GP2X_BUTTON_LEFT:
						if(lxMove < 0) lxMove = 0;
						break;
					case GP2X_BUTTON_RIGHT:
						if(lxMove > 0) lxMove = 0; 
						break;
					case GP2X_BUTTON_UPLEFT: 
						if(lxMove < 0) lxMove = 0;
						break;
					case GP2X_BUTTON_UPRIGHT: 
						if(lxMove > 0) lxMove = 0;
						break;
					case GP2X_BUTTON_DOWNLEFT: 
						if(lxMove < 0) lxMove = 0;
						break;
					case GP2X_BUTTON_DOWNRIGHT: 
						if(lxMove > 0) lxMove = 0;
						break;
					case GP2X_BUTTON_A:
					case GP2X_BUTTON_B:
					case GP2X_BUTTON_X:
					case GP2X_BUTTON_Y:
						firing = false;
						break;
				}
				break;
		  }
		}

		// Now move the bulb
		launchX = launchX + lxMove;
		if(launchX < (20 * BULBMULTIPLIER))  launchX =  20 * BULBMULTIPLIER;
		if(launchX > (280 * BULBMULTIPLIER)) launchX = 280 * BULBMULTIPLIER;
		hand->set_world_position(launchX/BULBMULTIPLIER, hand->get_y());
		launcher->set_world_position(hand->get_x()+BULBHANDOFFSETX, hand->get_y()+BULBHANDOFFSETY);

		// Fire!
		if(firing && howManyDone < HOWMANYSOCKETS) {
			AWBullet *bulb = bulbs->allocate_a_bullet();
			if(bulb != NULL) {
				Mix_PlayChannel(-1, floop, 0);
				bulb->set_world_position(hand->get_x()+BULBHANDOFFSETX, hand->get_y()+BULBHANDOFFSETY);
				float velY = (-3.9f - (power->get_currentFrame() * POWERMULTIPLIER));
				bulb->set_velocities(0.0f, velY);
				bulb->set_auto_move(20);
				bulb->set_accelerations(0.0f, 0.53f);
				bulb->set_auto_accelerate(100);
				firing = false;
			}
		}
		

		// draw the background 
		SDL_BlitSurface(bg, NULL, screen, NULL);

		// Show all the sprites
		snow->update_everything();
		window->update_everything();
		tree->update_everything();
		lights->update_everything();
		if(howManyDone < HOWMANYSOCKETS) {
			hand->update_everything();
			power->update_everything();
			launcher->update_everything();
			for(bs=0; bs < HOWMANYSOCKETS; bs++) bSocket[bs]->update_everything();
			bulbs->update_everything();
			clock->update_everything();
			// Work out the time the time
			timeNow = SDL_GetTicks();
		}
		
		// Display the time
		report_time(startTicks, timeNow, font, 268, 185);
								
		/* update the screen */
		SDL_Flip(screen);
		
		// Check to see if we had a "hit" with the bulb
		for(bu=0; bu < bulbs->size(); bu++) {
			AWBullet *bulb = bulbs->get(bu);
			if(bulb->inUse == false) continue;
			for(bs=0; bs < HOWMANYSOCKETS; bs++) {
				if(bSocket[bs]->check_bulb_insertion(bulb)) {
					// Hooray! A hit.
					howManyDone = howManyDone + 1;
					if(howManyDone >= HOWMANYSOCKETS && !musicPlayed) {
						// Start the music
						Mix_PlayMusic(jingle, -1);
						musicPlayed = true;
					}
					AWBullet *light = lights->allocate_a_bullet();
					if(light != NULL) {
						Mix_PlayChannel(-1, bloop, 0);
						int animationStart = 2 * (rand() % 4);
						light->set_world_position(bSocket[bs]->get_x() + 5, bSocket[bs]->get_y() + 5);
						light->set_currentFrame(animationStart);
						light->set_auto_animate(420);
						bSocket[bs]->make_invisible();
						bulb->inUse = false;
						break;
					}
				}
			}
		}
	}  // This is the end of the game loop

	if(musicPlayed) {
		Mix_HaltMusic();
	}

	/* free the background surface */
	SDL_FreeSurface(bg);

	/* cleanup SDL */
	SDL_Quit();

	return 0;
}

