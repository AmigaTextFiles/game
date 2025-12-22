/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

/* game.c - controls all the game logic; this is the core of the game. */

// This loads the palette and draws the stars on the screen.  Then it copies
// that to the virtual screens.

#include <stdio.h>
#include <string.h>
#include "SDL.h"
#include "ta.h"
#include "modern.h"
#include "game.h"
#include "scores.h"

static graphic *ship, *blast, *eplasma, *star, *kamikaz1, *kamikaz2;
static graphic *sweeper1, *sweeper2, *debris0, *debris1, *debris2, *lifemark;
static graphic *bomb;
static graphic *ebolts, *explpics[9];
static graphic *missileboss, *laserboss, *missiles, *laserbolt;
static graphic *massivebattleship, *mbsmissiles, *mbslasers;

static byte gameover, canblast=1, playerdead=0, lives;
static byte waveover;
static unsigned long score=0, targetscore=10000;
static int wavecounter;
static wave curwave; // Current wave information
static int ddx,ddy; // these are the acceleration values of the player's ship

int ms_per_frame = 15*5;
static int now, target;

sprite player, blasts[NUMBLASTS];
sprite enemies[NUMENEMIES], eblasts[NUMEBLASTS], junk[NUMDEBRIS], expls[NUMEXPLS];
sprite stars[NUMSTARS];

void handle_event_game(SDL_Event *event)
{
    if(event->type == SDL_KEYDOWN) {
	switch(event->key.keysym.sym) {
	case SDLK_ESCAPE:
	    if (!gameover) {
		killplayer();
	    }
	    lives = 0;
	    gameover = 1;
	    break;
	case SDLK_RIGHTBRACKET:
	case SDLK_RETURN:
	case SDLK_KP_ENTER:
	case SDLK_SPACE:
	    newblast();
	    break;
	case SDLK_KP8:
	case SDLK_UP:
	    if (momentumconserved) {
		ddy = -1;
	    } else {
		player.dy = -3;
	    }
	    break;
	case SDLK_KP4:
	case SDLK_LEFT:
	    if (momentumconserved) {
		ddx = -1;
	    } else {
		player.dx = -3;
	    }
	    break;
	case SDLK_KP6:
	case SDLK_RIGHT:
	    if (momentumconserved) {
		ddx = 1;
	    } else {
		player.dx = 3;
	    }
	    break;
	case SDLK_KP2:
	case SDLK_DOWN:
	    if (momentumconserved) {
		ddy = 1;
	    } else {
		player.dy = 3;
	    }
	    break;
	default:
	    handle_event_top(event);
	}
    } else if (event->type == SDL_KEYUP) {
	switch(event->key.keysym.sym) {
	case SDLK_RIGHTBRACKET:
	case SDLK_RETURN:
	case SDLK_KP_ENTER:
	case SDLK_SPACE:
	    canblast=1;
	    break;
	case SDLK_KP8:
	case SDLK_UP:
	    if(momentumconserved) {
		if (ddy == -1) {
		    ddy = 0;
		}
	    } else {
		if (player.dy == -3) {
		    player.dy = 0;
		}
	    }
	    break;
	case SDLK_KP4:
	case SDLK_LEFT:
	    if(momentumconserved) {
		if (ddx == -1) {
		    ddx = 0;
		}
	    } else {
		if (player.dx == -3) {
		    player.dx = 0;
		}
	    }
	    break;
	case SDLK_KP6:
	case SDLK_RIGHT:
	    if(momentumconserved) {
		if (ddx == 1) {
		    ddx = 0;
		}
	    } else {
		if (player.dx == 3) {
		    player.dx = 0;
		}
	    }
	    break;
	case SDLK_KP2:
	case SDLK_DOWN:
	    if(momentumconserved) {
		if (ddy == 1) {
		    ddy = 0;
		}
	    } else {
		if (player.dy == 3) {
		    player.dy = 0;
		}
	    }
	    break;
	default:
	    handle_event_top(event);
	}
    } else {
	handle_event_top(event);
    }
}

void game_process_input()
{
    SDL_Event event;
    while (SDL_PollEvent(&event)) {
	handle_event_game(&event);
    }
}

void newstar(int x, int y)
{
    int i;
    for(i=0;i<NUMSTARS;i++) {
	if(!stars[i].active) {
	    stars[i].active=1;
	    stars[i].x=x;
	    stars[i].y=y;
	    stars[i].picture=star;
	    i = NUMSTARS;
	}
    }
}

int sprite_collide(sprite *s1, sprite *s2)
{
    int s1w, s1h, s2w, s2h;
    int x, y;

    if (!(s1->active && s2->active)) {
	return 0;
    }

    s1w = s1->picture->surface->w/2;
    s1h = s1->picture->surface->h/2;
    s2w = s2->picture->surface->w/2;
    s2h = s2->picture->surface->h/2;

    /* check bounding boxes first. */
    if ((s2->x - s1->x > s1w) || (s1->x - s2->x > s2w)) {
	return 0;
    }
    if ((s2->y - s1->y > s1h) || (s1->y - s2->y > s2h)) {
	return 0;
    }

    /* Now check at the pixel level. */

    for(y = 0; y < s1h; ++y) {
	int s2y = s1->y+y-s2->y;
	if (s2y < 0 || s2y >= s2h)
	    continue;
	for (x = 0; x < s1w; ++x) {
	    int s2x = s1->x+x-s2->x;
	    if (s2x < 0 && s2x >= s2w)
		continue;
	    if (s1->picture->outline[y*s1w+x] && s2->picture->outline[s2y*s2w+s2x])
		return 1;
	}
    }

    return 0;
}

void draw_sprite(sprite *s, SDL_Surface *where)
{
    if(s->active) {
	draw_graphic(s->picture, s->x << 1, s->y << 1, where);
    }
}

void setupscreen(void)
{
    int i;
    for(i=0;i<25;i++) 
	newstar(get_random(61)*10, get_random(37)*10);
}

void rungame()
{
    initgame();
    setupscreen();
    curwave.length=750; curwave.update=wave1update;
    curwave.intro=wave1intro;
    ms_per_frame = 15*(9-speed);
    initwave(&curwave);
    runwave(&curwave);
    if(!gameover)
    {
	curwave.length=150;
	curwave.update=wave1bossupdate; curwave.intro=blankintro;
	initwave(&curwave);
	runwave(&curwave);
    }
    if(!gameover)
    {
	curwave.length=1000;
	curwave.update=wave2update; curwave.intro=wave2intro;
	initwave(&curwave);
	runwave(&curwave);
    }
    if(!gameover)
    {
	curwave.length=150;
	curwave.update=wave2bossupdate; curwave.intro=blankintro;
	initwave(&curwave);
	runwave(&curwave);
    }
    if(!gameover)
    {
	curwave.length=1000;
	curwave.update=wave3update; curwave.intro=wave3intro;
	initwave(&curwave);
	runwave(&curwave);
    }
    if(!gameover)
    {
	curwave.length=1;
	curwave.update=wave3bossupdate; curwave.intro=blankintro;
	initwave(&curwave);
	runwave(&curwave);
    }
    if(!gameover)
    {
	blankintro();
    }
    if(!gameover)
    {
	endingsequence();
    }
    if(gameover)
    {
	if(curwave.length<500) waveintro("Game","Over",1);
	else waveintro("Game","Over",2);
    }
    if(!gameover) do_long_credits();
    endgame();
}


void blankintro()
{
    waveintro("","", 1);
}

void wave1intro()
{
    waveintro("Wave 1","The First Encounter", 2);
}

void wave2intro()
{
    waveintro("Wave 2","Cosmic Hurricane", 2);
}

void wave3intro()
{
    waveintro("Wave 3","The Last Resort", 2);
}

void delay_for_frame()
{
    target += ms_per_frame;
    now = SDL_GetTicks();
    if (now < target) {
	SDL_Delay(target - now);
    } else {
      target = now; /* Don't make up for lost time */
    }
}

void runwave(wave *w)
{
    do {
	w->update();
	if(++wavecounter>w->length) waveover=1;
	updateeverything();
	draweverything(screen);
	SDL_Flip(screen);
    } while((!gameover)&&(waveover!=2)); // Until the game or wave is over
}

void updateeverything()
{
    int i;
    // Update your ship
    updatestarblazer();
    // Update each active plasma blast, yours and theirs
    for(i=0;i<NUMBLASTS;i++)
	if(blasts[i].active)
	    updateplasmablast(&blasts[i]);
    for(i=0;i<NUMEBLASTS;i++)
	if(eblasts[i].active)
	    eblasts[i].update(&eblasts[i]);
    // Update all active enemies, and set waveover to 2 if the
    // wave is over and no enemies are left onscreen.  The wave
    // will NOT end until all enemies are unactive.
    if(waveover==1) waveover=2;
    for(i=0;i<NUMENEMIES;i++) {
	if(enemies[i].active)
	{
	    if(waveover==2) waveover=1;
	    enemies[i].x+=enemies[i].dx;
	    enemies[i].y+=enemies[i].dy;
	    if((enemies[i].y>199)||(enemies[i].x<-enemies[i].picture->surface->w/2)||(enemies[i].x>319)||enemies[i].y < -enemies[i].picture->surface->h/2)
		enemies[i].active=0;
	    enemies[i].update(&enemies[i]);
	    if(get_random(100)<enemies[i].firefreq)
		enemies[i].fire(&enemies[i]);
	}
    }
}
// Runs a generic wave intro.  It writes "Wave x" on the screen for some
// number x.  If x is 0, then it just idles the game for a while.  (No
// enemies or anything.  Good for clearing out the screen.)

void waveintro(char *line1, char *line2, int speed)
{
    int j, x1, x2, y1, y2;
    x1=320-((XElen(line1))>>1);
    x2=320-((XElen(line2))>>1);
    if((*line1)&&(*line2))
    {
	y1=160;
	y2=220;
    } else {
	y1=y2=190;
    }
    for(j=0;j<75;j++)
    {
	if(gameover) curwave.update();
	updateeverything();
	if(!gameover) rotate(speed);
	draweverything(screen);
	if(*line1) writeXE(x1,y1,line1,screen);
	if(*line2) writeXE(x2,y2,line2,screen);
	SDL_Flip(screen);
    }
}

void endingsequence()
{
    int j;
    // setvect(9, BIOSkey); // Player loses control
    ddx=0; ddy=0; player.dy=-1;
    // Part one of ending: Center your ship on the screen.
    while((player.dx)||(player.dy))
    {
	if(player.x < 160) player.dx = 1;
	if(player.x > 160) player.dx = -1;
	if(player.x == 160) player.dx = 0;
	if(player.y < 180) player.dy = 1;
	if(player.y > 180) player.dy = -1;
	if(player.y == 180) player.dy = 0;
	updateeverything();
	rotate(1);
	draweverything(screen);
	SDL_Flip(screen);
    }
    // Part two; fill the screen with mass destruction
    for(j=0;j<50;j++)
    {
	newexpl(get_random(300), get_random(180)+10, 0, 2);
	newexpl(get_random(300), get_random(180)+10, 0, 2);
	newexpl(get_random(300), get_random(180)+10, 0, 2);
	newexpl(get_random(300), get_random(180)+10, 0, 2);
	updateeverything();
	rotate(1);
	draweverything(screen);
	SDL_Flip(screen);
    }
}

// Collision-check code, now kept out of the drawing routines
void collision_check()
{
    int i;
    if((!playerdead)&&(player.active>=50)&&(!godlike)) {
	for (i = 0; i < NUMEBLASTS; ++i) {
	    if (sprite_collide(&player, eblasts+i)) {
		killplayer();
		break;
	    }
	}
	if (!playerdead) {
	    for (i = 0; i < NUMENEMIES; ++i) {
		if (sprite_collide(&player, enemies+i)) {
		    killplayer();
		}
	    }
	}
    }

    for(i = 0; i < NUMBLASTS; i++) {
	if (blasts[i].active) {
	    destroysomething(i);
	}
    }	
}

// Draws everything!
void draweverything(SDL_Surface *where)
{
    int i;
    char sc[80];
    SDL_Rect header;

    delay_for_frame();

    clear_graphic(where);

    // Draw all stars
    for(i=0; i<NUMSTARS; i++)
	draw_sprite(stars+i, where);

    // Draw all the enemies' shots
    for(i=0;i<NUMEBLASTS;i++)
	draw_sprite(eblasts+i, where);

    // Draw all enemies
    for(i=0;i<NUMENEMIES;i++)
	draw_sprite(enemies+i, where);

    // Draw the StarBlazer, or wait until reincarnation
    // If the 'Blazer has hit anything lethal, kill it
    if(!playerdead)
    {
	if(player.active&2)
	{
	    draw_sprite(&player, where);
	}
	if((player.active<50)) player.active++;
    }
    else
    {
	if(++playerdead>25)
	{
	    player.x=160;
	    player.y=180;
	    player.dx=0;
	    player.dy=0;
	    playerdead=0;
	    player.active=0;
	    if((!lives)||(gameover)) {gameover=1;playerdead=1;}
	}
    }
    // Draw the explosions.  expls.active, if from 1 to 9, means that it
    // should display that frame.  If it is from 100 to 109, that means
    // that the explosion is a "teenyexpl" and the last four frames are
    // the same as the first four.
    for(i=0;i<NUMDEBRIS;i++) {
	if(junk[i].active)
	{
	    junk[i].x+=junk[i].dx; junk[i].y+=junk[i].dy;
	    draw_sprite(junk+i, where);
	    if((junk[i].y>199)||(junk[i].x<-junk[i].picture->surface->w/2)||(junk[i].x>319)||junk[i].y<-junk[i].picture->surface->h/2)
		junk[i].active=0;
	}
    }
    for(i=0;i<NUMEXPLS;i++)
	if(expls[i].active)
	{
	    expls[i].x+=expls[i].dx; expls[i].y+=expls[i].dy;
	    if(expls[i].active < 100) {
		expls[i].picture = explpics[expls[i].active-1];
		draw_sprite(expls+i, where);
		if(++expls[i].active>9) expls[i].active=0;
	    }
	    else {
		if(expls[i].active < 103) {
		    expls[i].picture = explpics[expls[i].active-100];
		    draw_sprite(expls+i, where);
		} else {
		    expls[i].picture = explpics[106-expls[i].active];
		    draw_sprite(expls+i, where);
		}
		if(++expls[i].active>106) expls[i].active=0;
	    }
	}
    // Draw the plasma blasts, and see if they hit anything
    for(i=0;i<NUMBLASTS;i++)
	draw_sprite(blasts+i, where);

    // Draw the header at the top of the screen
    header.x=header.y=0;
    header.w=640; header.h=26;
    SDL_FillRect(where, &header, SDL_MapRGB(where->format, 0, 0, 0));
    sprintf(sc,"Score: %010lu", score);
    writeXE(100,3,sc,where);
    for(i=0;i<lives;i++)
	draw_graphic(lifemark, 400+i*30, 3, where);
    collision_check();
}

// Update the StarBlazer and make sure it stays onscreen
void updatestarblazer()
{
    game_process_input();
    if(momentumconserved)
    {
	player.dx+=ddx; player.dy+=ddy;
	if((player.dx<-5)||(player.dx>5)) player.dx-=ddx;
	if((player.dy<-5)||(player.dy>5)) player.dy-=ddy;
    }
    player.x+=player.dx; player.y+=player.dy;
    if(player.x<0) player.x=player.dx=0;
    if(player.x>319-player.picture->surface->w/2)
    {
	player.x=319-player.picture->surface->w/2;
	player.dx=0;
    }
    if(player.y<10) {player.y=10;player.dy=0;}
    if(player.y>199-player.picture->surface->h/2)
    {
	player.y=199-player.picture->surface->h/2;
	player.dy=0;
    }
}

// Updates plasma blast i
void updateplasmablast(sprite *i)
{
    i->x+=i->dx; i->y+=i->dy;
    if(i->dy>-8) i->dy--;
    if(i->y<-10) i->active=0;
}

void updateenemyplasma(sprite *i)
{
    i->x += i->dx;
    i->y += i->dy;
    if(i->dy<8) i->dy++;
    if(i->y>199) i->active=0;
}

void updatesweeper(sprite *i)
{
    if(i->active==1)
    {
	i->dy++;
	if(i->dy>5)
	    i->active=2;
    } else {
	i->dy--;
	if(i->dy<-5)
	    i->active=1;
    }
}

void updatemissileboss(sprite *i)
{
    if((i->x+i->dx<0)&&(i->dx<0)) i->dx*=-1;
    if((i->x+i->dx>(319-i->picture->surface->w/2))&&(i->dx>0)) i->dx*=-1;
}

void updatelaserboss(sprite *i)
{
    if((i->x+i->dx<0)&&(i->dx<0)) i->dx*=-1;
    if((i->x+i->dx>(319-i->picture->surface->w/2))&&(i->dx>0)) i->dx*=-1;
    if((i->y+i->dy<10)&&(i->dy<0)) i->dy*=-1;
    if((i->y+i->dy>150)&&(i->dy>0)) i->dy*=-1;
    if(i->active>1)
    {
	i->fire(i);
	i->active--;
    }
    else
    {
	if(get_random(100)<10) i->active=5;
    }
}

void updatemassivebattleship(sprite *i)
{
    if((i->x+i->dx<0)&&(i->dx<0)) i->dx*=-1;
    if((i->x+i->dx>(319-i->picture->surface->w/2))&&(i->dx>0)) i->dx*=-1;
    if((i->y+i->dy<10)&&(i->dy<0)) i->dy*=-1;
    if((i->y+i->dy>150)&&(i->dy>0)) i->dy*=-1;
    if(i->active>1)
    {
	shootmbslasers(i);
	i->active--;
    }
    else
    {
	if(get_random(100)<10) i->active=7;
    }
}

void updatekamikaze(sprite *i)
{
    if((i->x-player.x>20)&&(i->dx>-3)) i->dx--;
    if((i->x-player.x<-20)&&(i->dx<3)) i->dx++;
}

// Bombs just sit there.
void updatebomb(sprite *i) {};

void updatemissiles(sprite *i)
{
    if((i->x-player.x>10)&&(i->dx>-3)) i->dx--;
    if((i->x-player.x<-10)&&(i->dx<3)) i->dx++;
    if(i->dy<10)i->dy++;
    i->x+=i->dx;
    i->y+=i->dy;
    if(i->y>199) i->active=0;
}

void updatelasers(sprite *i)
{
    i->x+=i->dx;
    i->y+=i->dy;
    if(i->y>199) i->active=0;
}

void initgame()
{
    int i;
    loadallsprites();
    now = SDL_GetTicks();
    target = now;
    player.dx=0; player.dy=0; player.y=180; player.x=160;
    player.picture=ship; player.active=51; playerdead=0;
    // setvect(9,mykey);  // Set the keyboard vector to game controls
    score=0; targetscore=10000; lives=3;
    gameover=0; waveover=0;
    // Deactivate everything
    for(i=0;i<NUMBLASTS;i++) blasts[i].active=0;
    for(i=0;i<NUMENEMIES;i++) enemies[i].active=0;
    for(i=0;i<NUMEBLASTS;i++) eblasts[i].active=0;
    for(i=0;i<NUMDEBRIS;i++) junk[i].active=0;
    for(i=0;i<NUMEXPLS;i++) expls[i].active=0;
    for(i=0;i<NUMSTARS;i++) stars[i].active=0;
}

void endgame()
{
    updatehiscores(score);
    godlike=0;  // Turn off God Mode if it was on
}

void initwave(wave *x)
{
    wavecounter=0; waveover=0;
    x->intro();
}

void wave1update()
{
    rotate(2);
    if(!waveover)
    {
	if(!get_random(25)) newkamikaze(kamikaz1);
	if(!get_random(20)) newsweeper(sweeper1);
	if(!get_random(400)) newbomb(bomb);
    }
}

void wave2update()
{
    rotate(2);
    if(!waveover)
    {
	if(!get_random(25)) newkamikaze(kamikaz2);
	if(!get_random(20)) newsweeper(sweeper2);
	if(!get_random(400)) newbomb(bomb);
    }
}

void wave3update()
{
    rotate(2);
    if(!waveover)
    {
	if(!get_random(60)) newkamikaze(kamikaz1);
	if(!get_random(60)) newkamikaze(kamikaz2);
	if(!get_random(50)) newsweeper(sweeper1);
	if(!get_random(50)) newsweeper(sweeper2);
	if(!get_random(400)) newmissileboss();
	if(!get_random(400)) newlaserboss();
	if(!get_random(500)) newbomb(bomb);
    }
}

// OK, we detected a collision between a blast and something.  This handles
// that aspect of it.

void destroysomething(int blasttocheck)
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
    {
	if(enemies[i].active)
	{
	    if (sprite_collide(blasts+blasttocheck, enemies+i)) 
	    {
		blasts[blasttocheck].active=0;
		enemies[i].hitstokill--;
		if(!enemies[i].hitstokill)
		{
		    enemies[i].active=0;
		    enemies[i].destroy(&enemies[i]);
		    score+=enemies[i].pointvalue;
		    if(score >= targetscore)
		    {
			if(!godlike) lives++;
			targetscore+=10000;
		    }					
		}
		else {
		    newteenyexpl(blasts[blasttocheck].x,blasts[blasttocheck].y,enemies[i].dx,enemies[i].dy);
		}
		i=NUMENEMIES;
	    }
	}
    }
}

//  The player was just slain.  Slay him.
void killplayer()
{
    playerdead=1;
    bigexpl(&player);
    lives--;
}

// Kill a smaller enemy
void smallexpl(sprite *i)
{
    newexpl(i->x,i->y,i->dx,i->dy);
}

// Kill a bigger enemy
void bigexpl(sprite *i)
{
    int j,numexpls;
    numexpls=get_random(3)+3;

    for(j=0;j<numexpls;j++)
	newexpl(i->x, i->y, i->dx-3+get_random(7), i->dy-3+get_random(7));
}

// Kill a massive enemy
void megaexpl(sprite *i)
{
    int j,numexpls;
    numexpls=get_random(6)+6;

    for(j=0;j<numexpls;j++)
	newexpl(i->x, i->y, i->dx-3+get_random(7), i->dy-3+get_random(7));
}

// Destroy everything on the screen
void ultramegaexpl(sprite *i)
{
    int j;
    megaexpl(i);
    for(j=0;j<NUMENEMIES;j++)
	if(enemies[j].active)
	{
	    enemies[j].active=0;
	    enemies[j].destroy(&enemies[j]);
	    score+=enemies[j].pointvalue<<1;
	    if(score >= targetscore)
	    {
		if(!godlike) lives++;
		targetscore+=10000;
	    }
	}
}

// Unleashes twin flaming plasma blasts of unstoppable destruction
void newblast()
{
    int i;
    // Only shoot if the user released the key before and is still alive.
    if(canblast&&!playerdead)
	for (i=0;i<NUMBLASTS;i++)
	    if(!(blasts[i].active))
	    {
		blasts[i].active=1;
		blasts[i].x=player.x+((player.picture->surface->w/2-blast->surface->w/2)>>1);
		blasts[i].y=player.y-10;
		blasts[i].picture=blast;
		if(momentumconserved)
		{
		    blasts[i].dx=player.dx;
		    blasts[i].dy=player.dy;
		} else {
		    blasts[i].dx=0;
		    blasts[i].dy=-2;
		}
		canblast=0;
		i=NUMBLASTS;
	    }
}

void shootplasma(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-eplasma->surface->w/2)>>1);
	    eblasts[i].y=shooter->y;
	    eblasts[i].picture=eplasma;
	    eblasts[i].update=updateenemyplasma;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

void wave1bossupdate()
{
    rotate(1);
    if(!waveover && !(wavecounter%30) && !gameover) newmissileboss();
}

void wave2bossupdate()
{
    rotate(1);
    if(!waveover && !(wavecounter%30) && !gameover) newlaserboss();
}

void wave3bossupdate()
{
    rotate(1);
    if(!waveover&&(!gameover)) newmassivebattleship();
}

void shootmissiles(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-missiles->surface->w/2)>>1);
	    eblasts[i].y=shooter->y+shooter->picture->surface->h/2;
	    eblasts[i].picture=missiles;
	    eblasts[i].update=updatemissiles;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

void shootlasers(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-laserbolt->surface->w/2)>>1);
	    eblasts[i].y=shooter->y+shooter->picture->surface->h/2;
	    eblasts[i].picture=laserbolt;
	    eblasts[i].update=updatelasers;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=eblasts[i].picture->surface->h/2+shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=eblasts[i].picture->surface->h/2+shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

void shootmbsmissiles(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-mbsmissiles->surface->w/2)>>1);
	    eblasts[i].y=shooter->y+shooter->picture->surface->h/2;
	    eblasts[i].picture=mbsmissiles;
	    eblasts[i].update=updatemissiles;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

void shootmbslasers(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-mbslasers->surface->w/2)>>1);
	    eblasts[i].y=shooter->y+shooter->picture->surface->h/2;
	    eblasts[i].picture=mbslasers;
	    eblasts[i].update=updatelasers;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=eblasts[i].picture->surface->h/2+shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=eblasts[i].picture->surface->h/2+shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

void shootbolts(sprite *shooter)
{
    int i;
    for (i=0;i<NUMEBLASTS;i++)
	if(!(eblasts[i].active))
	{
	    eblasts[i].active=1;
	    eblasts[i].x=shooter->x+((shooter->picture->surface->w/2-ebolts->surface->w/2)>>1);
	    eblasts[i].y=shooter->y;
	    eblasts[i].picture=ebolts;
	    eblasts[i].update=updateenemyplasma;
	    if(momentumconserved)
	    {
		eblasts[i].dx=shooter->dx;
		eblasts[i].dy=shooter->dy;
	    } else {
		eblasts[i].dx=0;
		eblasts[i].dy=shooter->dy;
	    }
	    i=NUMEBLASTS;
	}
}

// Creates a new sweeper.  Sweepers weave up and down and shoot at random.
void newsweeper(graphic *newpic)
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=newpic;
	    if(get_random(2))
	    {
		enemies[i].x=319;
		enemies[i].dx=-3;
	    }
	    else
	    {
		enemies[i].x=-enemies[i].picture->surface->w/2+1;
		enemies[i].dx=3;
	    }
	    enemies[i].y=get_random(100)+10;
	    enemies[i].dy=2;
	    if(get_random(2)) enemies[i].dy=-2;
	    enemies[i].pointvalue=150;
	    enemies[i].active=1;
	    enemies[i].firefreq=5;
	    enemies[i].update=updatesweeper;
	    enemies[i].fire=shootplasma;
	    enemies[i].destroy=smallexpl;
	    enemies[i].hitstokill=1;
	    i=NUMENEMIES;
	}
}

// Creates a new kamikaze.  Kamikazes home in on your ship, firing
// constantly.  They are insanely dangerous.
void newkamikaze(graphic *newpic)
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=newpic;
	    enemies[i].x=get_random(319-enemies[i].picture->surface->w/2);
	    enemies[i].y=-(enemies[i].picture->surface->h/2);
	    enemies[i].dx=(get_random(3)-1)*2;
	    enemies[i].dy=get_random(3)+3;
	    enemies[i].pointvalue=250;
	    enemies[i].firefreq=15;
	    enemies[i].active=1;
	    enemies[i].update=updatekamikaze;
	    enemies[i].fire=shootbolts;
	    enemies[i].destroy=smallexpl;
	    enemies[i].hitstokill=1;
	    i=NUMENEMIES;
	}
}

// Creates a new bomb.  Bombs are stationary relative to the background.
// Destroying one annihilates everything on the screen.
void newbomb(graphic *newpic)
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=newpic;
	    enemies[i].x=get_random(319-enemies[i].picture->surface->w/2);
	    enemies[i].y=-(enemies[i].picture->surface->h/2);
	    enemies[i].dx=0;
	    enemies[i].dy=2;
	    enemies[i].pointvalue=0;
	    enemies[i].firefreq=0;
	    enemies[i].active=1;
	    enemies[i].update=updatebomb;
	    enemies[i].destroy=ultramegaexpl;
	    enemies[i].hitstokill=1;
	    i=NUMENEMIES;
	}
}

void newmissileboss()
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=missileboss;
	    if(get_random(2))
	    {
		enemies[i].x=319;
		enemies[i].dx=-(get_random(3)+3);
	    }
	    else
	    {
		enemies[i].x=-enemies[i].picture->surface->w/2;
		enemies[i].dx=(get_random(3)+3);
	    }
	    enemies[i].y=get_random(50)+10;
	    enemies[i].dy=0;
	    enemies[i].pointvalue=1250;
	    enemies[i].firefreq=4;
	    enemies[i].active=1;
	    enemies[i].update=updatemissileboss;
	    enemies[i].fire=shootmissiles;
	    enemies[i].destroy=bigexpl;
	    enemies[i].hitstokill=5;
	    i=NUMENEMIES;
	}
}

void newlaserboss()
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=laserboss;
	    if(get_random(2))
	    {
		enemies[i].x=319;
		enemies[i].dx=-(get_random(3)+1);
	    }
	    else
	    {
		enemies[i].x=-enemies[i].picture->surface->w/2;
		enemies[i].dx=(get_random(3)+1);
	    }
	    if(get_random(2))
	    {
		enemies[i].dy=-(get_random(3)+1);
	    }
	    else
	    {
		enemies[i].dy=(get_random(3)+1);
	    }
	    enemies[i].y=get_random(140)+10;
	    enemies[i].pointvalue=1250;
	    enemies[i].firefreq=0;
	    enemies[i].active=1;
	    enemies[i].update=updatelaserboss;
	    enemies[i].fire=shootlasers;
	    enemies[i].destroy=bigexpl;
	    enemies[i].hitstokill=5;
	    i=NUMENEMIES;
	}
}

void newmassivebattleship()
{
    int i;
    for(i=0;i<NUMENEMIES;i++)
	if (!enemies[i].active)
	{
	    enemies[i].picture=massivebattleship;
	    if(get_random(2))
	    {
		enemies[i].x=319;
		enemies[i].dx=-(get_random(3)+1);
	    }
	    else
	    {
		enemies[i].x=-enemies[i].picture->surface->w/2;
		enemies[i].dx=(get_random(3)+1);
	    }
	    if(get_random(2))
	    {
		enemies[i].dy=-(get_random(3)+1);
	    }
	    else
	    {
		enemies[i].dy=(get_random(3)+1);
	    }
	    enemies[i].y=get_random(140)+10;
	    enemies[i].pointvalue=5000;
	    enemies[i].firefreq=4;
	    enemies[i].active=1;
	    enemies[i].update=updatemassivebattleship;
	    enemies[i].fire=shootmbsmissiles;
	    enemies[i].destroy=megaexpl;
	    enemies[i].hitstokill=25;
	    i=NUMENEMIES;
	}
}

// Ha ha! Something got killed.  This initializes an explosion sprite.
void newexpl(int x, int y, int dx, int dy)
{
    int i, j;
    for(i=0;i<NUMEXPLS;i++)
	if(!expls[i].active)
	{
	    expls[i].active=1;
	    expls[i].x=x;
	    expls[i].y=y;
	    expls[i].dx=dx;
	    expls[i].dy=dy;
	    i=NUMEXPLS;
	}
    for(i=0;i<NUMDEBRIS;i++)
	if(!junk[i].active)
	{
	    junk[i].active=1;
	    junk[i].x=x;
	    junk[i].y=y;
	    junk[i].dx=dx;
	    junk[i].dy=get_random(5)-10;
	    j=get_random(3);
	    switch(j)
	    {
	    case 0: junk[i].picture=debris0; break;
	    case 1: junk[i].picture=debris1; break;
	    case 2: junk[i].picture=debris2; break;
	    }
	    i=NUMDEBRIS;
	}
    for(i=0;i<NUMDEBRIS;i++)
	if(!junk[i].active)
	{
	    junk[i].active=1;
	    junk[i].x=x;
	    junk[i].y=y;
	    do {
		junk[i].dx=dx+get_random(5)+5;
		junk[i].dy=dy+get_random(5)+1;
            } while(junk[i].dx==junk[i].dy);
	    j=get_random(3);
	    switch(j)
	    {
	    case 0: junk[i].picture=debris0; break;
	    case 1: junk[i].picture=debris1; break;
	    case 2: junk[i].picture=debris2; break;
	    }
	    i=NUMDEBRIS;
	}
    for(i=0;i<NUMDEBRIS;i++)
	if(!junk[i].active)
	{
	    junk[i].active=1;
	    junk[i].x=x;
	    junk[i].y=y;
	    do {
		junk[i].dx=dx-get_random(5)-5;
		junk[i].dy=dy+get_random(5)+1;
	    } while(junk[i].dx==junk[i].dy);
	    j=get_random(3);
	    switch(j)
	    {
	    case 0: junk[i].picture=debris0; break;
	    case 1: junk[i].picture=debris1; break;
	    case 2: junk[i].picture=debris2; break;
	    }
	    i=NUMDEBRIS;
	}
}

void newteenyexpl(int x, int y, int dx, int dy)
{
    int i;
    for(i=0;i<NUMEXPLS;i++)
	if(!expls[i].active)
	{
	    expls[i].active=100;
	    x-=(explpics[0]->surface->w/2-blast->surface->w/2)>>1; // center the explosion
	    y-=(explpics[0]->surface->h/2-blast->surface->h/2)>>1;
	    expls[i].x=x;
	    expls[i].y=y;
	    expls[i].dx=dx;
	    expls[i].dy=dy;
	    i=NUMEXPLS;
	}
}

void loadallsprites()
{
    ship = gfx+6;
    lifemark = gfx+7;
    blast = gfx+8;
    eplasma = gfx+9;
    ebolts = gfx+10;
    star = gfx+11;
    debris0 = gfx+12;
    debris1 = gfx+13;
    debris2 = gfx+14;
    kamikaz1 = gfx+15;
    kamikaz2 = gfx+16;
    sweeper1 = gfx+17;
    sweeper2 = gfx+18;
    explpics[0] = gfx+19;
    explpics[1] = gfx+20;
    explpics[2] = gfx+21;
    explpics[3] = gfx+22;
    explpics[4] = gfx+23;
    explpics[5] = gfx+24;
    explpics[6] = gfx+25;
    explpics[7] = gfx+26;
    explpics[8] = gfx+27;
    missileboss = gfx+28;
    missiles = gfx+29;
    laserboss = gfx+30;
    laserbolt = gfx+31;
    massivebattleship = gfx+32;
    mbsmissiles = gfx+33;
    mbslasers = gfx+34;
    bomb = gfx+35;
}

// rotate updates the starfield.
void rotate(int howmanytimes)
{
    int i;
    for (i = 0; i < NUMSTARS; i++) {
	if(stars[i].active) {
	    stars[i].y += howmanytimes*2;
	    if(stars[i].y > 200) {
		stars[i].active = 0;
	    }
	}
    }
    if(!get_random(10/howmanytimes)) {
	newstar(get_random(305), -15);
    }
}
