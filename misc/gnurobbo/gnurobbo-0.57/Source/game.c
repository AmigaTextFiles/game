/*   GNU Robbo
 *   Copyright (C) notes:
 *   An Idea and Atari version: LK Avalon, Janusz Pelc, 1989
 *   	            Linux Code: Arkadiusz Lipiec, 2002
 *               		<alipiec@elka.pw.edu.pl>
 *
 *  GNU Robbo is free software - you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  GNU Robbo is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the impled warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with GNU CC; see the file COPYING. If not, write to the
 *  Free Software Foundation, 59 Temple Place - Suite 330,
 *  Boston, MA 02111-1307, USA.
 *
 */
#include "game.h"
#include "time.h"	/* for random data */
#include "stdlib.h"
#include "string.h"
/***********************************************************/
/* This function checks if Robbo is killed - are there *****/
/* any killing object near? ********************************/
/***********************************************************/

int is_robbo_killed(){
	if((robbo.x + 1) < level.x)
		if(board[robbo.x+1][robbo.y].killing == 1)
			return 1;
	if((robbo.x - 1 ) > 0)
		if(board[robbo.x-1][robbo.y].killing == 1)
        		return 1;
        if((robbo.y + 1) < level.y)
		if(board[robbo.x][robbo.y+1].killing == 1)
			return 1;
	if((robbo.y - 1) > 0)
		if(board[robbo.x][robbo.y-1].killing == 1)
			return 1;
  return 0;
}

/************************************************************/
/* This function checks if object can move on the field *****/
/* described by direction and coordinates, if not returns 0 */
/************************************************************/

int can_move(struct Coords coords,int direction)
{
	if(update_coords(&coords,direction) || (board[coords.x][coords.y].type != 0) || ((robbo.x == coords.x) && (robbo.y == coords.y)) || board[coords.x][coords.y].moved > 0)
		return 0;
   	else
   		return 1;
};


/*************************************************************/
/*  This function checks every field for refreshing **********/
/*************************************************************/

void board_needs_refresh()
{
 int x, y;
 for(x = 0; x< level.x; x++)
 	for(y=0; y<level.y; y++)
 		board_changed[x][y] = 1;
}

/*************************************************************/
/****** Negating object state (birds waves their wings etc.. */
/*************************************************************/

void negate_state(int x, int y) {
	board[x][y].state = !board[x][y].state;
	refresh_field(x,y);
}

/*************************************************************/
/***** Checking field for refreshing *************************/
/*************************************************************/

void refresh_field(int x, int y) {
	board_changed[x][y] = 1;
}

/*************************************************************/
/**** Function returning coords of finding teleport **********/
/**** Updates coords of found teleport of 0 if not found *****/
/*************************************************************/

int find_teleport(struct Coords *coords, int teleportnumber, int teleportnumber2)
{
	int i,j;
	
  	for(i=0;i<level.x;i++)
  		for(j=0;j<level.y;j++) {
  			if(board[i][j].type == TELEPORT) {
				if(teleportnumber == board[i][j].teleportnumber) {  // found the same kind
					if(teleportnumber2 == board[i][j].teleportnumber2) { //next teleport
						set_coords(coords,i,j);
						return 1;	// found exact_teleport
					}
				}
  			}
  		}
  	
  	return(0);		// teleport with this number has not been found...  
}


/************************************************************/
/********** Init questionmark objects **********************/
/************************************************************/

void init_questionmarks()
{
	int i,j;
	
  	for(i=0;i<level.x;i++)
  		for(j=0;j<level.y;j++) {
  			if(board[i][j].type == QUESTIONMARK) {
  				board[i][j].id_questionmark = random_id();
  			}
		}
}

/**************************************************/
/* Function moves object deleting object data *****/
/* from one field and moves them to another *******/
/**************************************************/
void move_object(int x,int y,struct Coords coords)
{
	int x1, y1;

	if((x==coords.x) && (y == coords.y)) /* move to the same place */
		return;
    
	x1 = coords.x;
	y1 = coords.y;
 
	board[x1][y1].type =  board[x][y].type;
	board[x1][y1].state = board[x][y].state;
	board[x1][y1].direction = board[x][y].direction;
	board[x1][y1].destroyable = board[x][y].destroyable;
	board[x1][y1].blowable = board[x][y].blowable;
	board[x1][y1].killing = board[x][y].killing;
	board[x1][y1].shooted = board[x][y].shooted;
	board[x1][y1].rotable = board[x][y].rotable;
	board[x1][y1].movable = board[x][y].movable;
	board[x1][y1].moved = board[x][y].moved;
	board[x1][y1].rotated = board[x][y].rotated;
	board[x1][y1].randomrotated = board[x][y].randomrotated;
	board[x1][y1].solidlaser = board[x][y].solidlaser;
	board[x1][y1].direction2 = board[x][y].direction2;
	board[x1][y1].id_questionmark = board[x][y].id_questionmark;
	board[x1][y1].shooting = board[x][y].shooting;
	board[x1][y1].blowed = board[x][y].blowed;

	set_images(board[x1][y1].type, x1, y1);
	clear_field(&board[x][y]);
	
	refresh_field(x,y);
	refresh_field(x1,y1);
}

/********************************************************************/
/*** Robbo moving function ******************************************/
/********************************************************************/

void move_robbo(int x,int y)
{
	int x_tmp, y_tmp, x2_tmp, y2_tmp;
	int i,j,k;
	struct Coords coords;

	if(robbo.moved > 0 || robbo.blocked)  /* robbo cannot move yet */
		return;

	x_tmp = robbo.x+x;
	y_tmp = robbo.y+y;
   

	if((x == 1) && (y== 0))
		robbo.direction = 0;
	else if((x == 0) && (y== 1))
		robbo.direction = 2;
	else if((x == -1) && (y == 0))
		robbo.direction = 4;
	else if((x == 0) && (y== -1))
		robbo.direction = 6;

	if(x_tmp<0 || x_tmp >= level.x || y_tmp< 0 || y_tmp >= level.y)
		return;
    
	switch(board[x_tmp][y_tmp].type){

		case EMPTY_FIELD:
		case ROBBO:			/* Robbo can move there */
			break;
		case SCREW:
			if(robbo.screws > 0)
			{
				robbo.screws--;
			}
			if(robbo.screws == 0)
				open_exit();
			robbo.score += 100;
			clear_field(&board[x_tmp][y_tmp]);
			break;
		case BULLET:
			robbo.bullets += 9;
			robbo.score += 50;
			clear_field(&board[x_tmp][y_tmp]);
			break;
		case KEY:
			robbo.keys++;
			robbo.score+=75;
			clear_field(&board[x_tmp][y_tmp]);     
			break;
		case DOOR:			/* Robbo cannot move */
			if(robbo.keys > 0){	/* should open the door first */
				robbo.keys--;
				robbo.score += 100;
				clear_field(&board[x_tmp][y_tmp]);
				refresh_field(x_tmp, y_tmp);
				robbo.moved = DELAY_ROBBO;
			}
			return;
		case LIVE:
			robbo.lives++;
			robbo.score+=200;
			clear_field(&board_copy[x_tmp][y_tmp]);  // if we play again in the same level - the life won't be here
			clear_field(&board[x_tmp][y_tmp]);
			if((my_rand() & 0x07) == 0) {		// there's a little chance that animals will be killed
				for(i=0;i<level.x;i++)
					for(j=0;j<level.y;j++) {
						switch(board[i][j].type) {
							case BIRD:
							case BEAR:
							case BEAR_B:
							case BUTTERFLY:
								board[i][j].blowed = 1;
								board[i][j].moved = DELAY_ROBBO;
								break;
						}
					}
			}
			break;
		case TELEPORT:		
			if(board[x_tmp][y_tmp].teleportnumber == 0)
			    break;
			
			i = 0;
			j = board[x_tmp][y_tmp].teleportnumber2;
			
			while(i==0){
				j++;
				
				if(((find_teleport(&coords, board[x_tmp][y_tmp].teleportnumber, j))==0) && j != board[x_tmp][y_tmp].teleportnumber2) {// teleport not found
					if(j> MAX_TELEPORT_IDS)
						j = -1;
					continue;
				}
				
				      if(can_move(coords,(robbo.direction/2))) {
						board[robbo.x][robbo.y].blowed = 1;
						update_coords(&coords,robbo.direction/2);
						x_tmp = coords.x;
						y_tmp = coords.y;
						board[x_tmp][y_tmp].blowed = 1;
						robbo.moved = DELAY_BIGBOOM*6;
						i=1;
					}
					else {
					
						for(k=0;k<4;k++) {
        						if(k == (robbo.direction/2))
        							continue;
        							
        						if(can_move(coords,k)) {
								board[robbo.x][robbo.y].blowed = 1;
								update_coords(&coords,k);
								x_tmp = coords.x;
								y_tmp = coords.y;
								robbo.direction = k * 2;
								board[x_tmp][y_tmp].blowed = 1;
								refresh_field(x_tmp, y_tmp);
								robbo.moved = DELAY_BIGBOOM*6;
								i=1;
								break;
							}
						}
					}
				
				if(j==board[x_tmp][y_tmp].teleportnumber2 && i==0) {  // protect from freezing the game
					board[robbo.x][robbo.y].blowed=1;
					robbo.moved = DELAY_BIGBOOM*7;
					i=1;
					return;
				}				
			}
			
			break;
		case CAPSULE:
			if(robbo.exitopened){
				robbo.level++;
				level_init(robbo.level, 1);
				return;
			}
		case BOX:		/* Moveable objects */
		case PUSH_BOX:
		case BOMB:
		case QUESTIONMARK:
		case GUN:
			if((board[x_tmp][y_tmp].type == GUN) && (board[x_tmp][y_tmp].movable == 0))
				return;
			y2_tmp = robbo.y+(2*y);
			x2_tmp = robbo.x+(2*x);
			if(x2_tmp < 0 || x2_tmp >= level.x || y2_tmp < 0 || y2_tmp >= level.y)
				return;

			coords.x = x2_tmp;
			coords.y = y2_tmp;
     
			if(board[x2_tmp][y2_tmp].type == EMPTY_FIELD) {
				if(board[x_tmp][y_tmp].type == PUSH_BOX) {
					board[x_tmp][y_tmp].state = 1;		// box is pushed
					board[x_tmp][y_tmp].direction = (robbo.direction/2);
				}
				move_object(x_tmp,y_tmp,coords);
				if(board[coords.x][coords.y].type != GUN)
					board[coords.x][coords.y].moved = DELAY_PUSHBOX;	
			}
			else {
				robbo.moved = DELAY_ROBBO;
				return;
			}
			break;
		default:		/* every else objects */
			return;
	}

	robbo.x = x_tmp;
	robbo.y = y_tmp;
	
	if(robbo.moved == 0)
		robbo.moved = DELAY_ROBBO;	/* delay robbo */
	
	score_was_changed = 1;
}

/************************************************************/
/* Mapoffset for map scrolling ******************************/
/************************************************************/

void set_mapoffset()
{	
	int xx,yy;
	xx = FIELD_SIZE * robbo.x;
	yy = FIELD_SIZE * robbo.y;

	if(robbo.mapoffsetx == xx && robbo.mapoffsety == yy)
		return;
		
		
	if(robbo.mapoffsety < yy) {			// set offset of vertical scrolling
		robbo.mapoffsety+= SCROLL_RATE;
	}
	else if(robbo.mapoffsety > yy)
	{
		robbo.mapoffsety-= SCROLL_RATE;
	}
		
	if(robbo.mapoffsetx < xx)
	{
		robbo.mapoffsetx+= SCROLL_RATE;
	}
	else if(robbo.mapoffsetx > xx)
	{
		robbo.mapoffsetx-= SCROLL_RATE;
	}
		board_needs_refresh();
}

/*********************************************************/
/** Robbo shoots - x, y means coords of Robbo ************/
/*********************************************************/

void shoot_robbo(int x, int y)
{

	int x_tmp, y_tmp;
  
	if(robbo.shooted > 0)
		return;

	x_tmp = robbo.x + x;
	y_tmp = robbo.y + y;

	if((x == 1) && (y== 0))
		robbo.direction = 0;
	else if((x == 0) && (y == 1))
		robbo.direction = 2;
	else if((x == -1) && (y == 0))
		robbo.direction = 4;
	else if((x == 0) && (y == -1))
		robbo.direction = 6;

	if(robbo.bullets == 0)
		return;

	if(x_tmp<0 || x_tmp >= level.x || y_tmp< 0 || y_tmp >= level.y) {
		robbo.bullets--;
		robbo.shooted = DELAY_LASER;
		return;
	}

	switch(board[x_tmp][y_tmp].destroyable) {
		case 1:				/* objects can be destroyed */
			board[x_tmp][y_tmp].blowed = 1;
			robbo.shooted = DELAY_LASER;
			robbo.bullets--;
			score_was_changed = 1;
			return;
		case 0:
			robbo.shooted = DELAY_LASER;
			robbo.bullets--;
			score_was_changed = 1;
			break;
	}

	switch(board[x_tmp][y_tmp].type) {
		case EMPTY_FIELD:
			if(robbo.direction == 0 || robbo.direction == 4)
				create_object(x_tmp,y_tmp,LASER_L);
			else
				create_object(x_tmp,y_tmp,LASER_D);
				
			board[x_tmp][y_tmp].moved = DELAY_LASER;
			board[x_tmp][y_tmp].direction = robbo.direction/2;
			break;
	}
}

/*************************************************************/
/******* If objects shoots... ********************************/
/*************************************************************/

void shoot_object(int x, int y, int direction)
{
	struct Coords coords;

	if(board[x][y].shooted > 0)
		return;

	set_coords(&coords,x,y);

	if(update_coords(&coords,direction)) {
		board[coords.x][coords.y].shooted = DELAY_LASER;
		return;
	}

	if((coords.x == robbo.x) &&( coords.y == robbo.y))
		kill_robbo();

	switch(board[coords.x][coords.y].destroyable) {
		case 1:
			board[coords.x][coords.y].blowed = 1;
			board[coords.x][coords.y].shooted = DELAY_LASER;
			if(board[x][y].solidlaser == 1) {
				board[x][y].moved = DELAY_LASER;
			}
			return;
		default:
			break;
	}

	switch(board[coords.x][coords.y].type) {
		case EMPTY_FIELD:			
			if(direction == 0 || direction == 2) {
				clear_field(&board[coords.x][coords.y]);
				create_object(coords.x,coords.y,LASER_L);
			}
			else
			{
				clear_field(&board[coords.x][coords.y]);
				create_object(coords.x,coords.y,LASER_D);
			}
			
			board[coords.x][coords.y].direction = direction;
			board[coords.x][coords.y].solidlaser = board[x][y].solidlaser;
			board[x][y].shooted = DELAY_LASER;
			board[coords.x][coords.y].moved = DELAY_LASER;
			break;
		case LASER_D:
		case LASER_L:
			break;
	}
}

/****************************************************************/
/* Function marks all objects blowed around the bomb ************/
/****************************************************************/

void blow_bomb(int x,int y)
{
	struct Coords coords;
	int i;

	for(i=0;i<9;i++) {
		switch(i) {
			case 0:
				coords.x = x;
				coords.y = y;
				break;
			case 1:
				coords.x = x + 1;
				coords.y = y;
				break;
			case 2:
				coords.x = x+1;
				coords.y = y+1;
				break;
			case 3:
				coords.x = x;
				coords.y = y+1;
				break;
			case 4:
				coords.x = x-1;
				coords.y = y+1;
				break;
			case 5:
				coords.x = x-1;
				coords.y = y;
				break;
			case 6:
				coords.x = x-1;
				coords.y = y-1;
				break;
			case 7:
				coords.x = x;
				coords.y = y-1;
				break;
			case 8:
				coords.x = x+1;
				coords.y = y-1;
		}

     				/* Robbo was near blowing up */
     		if((robbo.x == coords.x) && (robbo.y == coords.y)) {
     			kill_robbo();
     		}

		if(coords_out_range(coords) || !board[coords.x][coords.y].blowable || board[coords.x][coords.y].blowed)
			continue;
		else {
		
				board[coords.x][coords.y].blowed = 1;
				board[coords.x][coords.y].moved = DELAY_BIGBOOM*2;
				board[coords.x][coords.y].id_questionmark = 0; /* blowed questiomark doesn't uncover */
		}
	}
}

/*********************************************************/
/********************** robbo moving *********************/
/*********************************************************/

Uint32 time_left(void)
{
	Uint32 now;
	now = SDL_GetTicks();
	if(next_time <= now)
		return 0;
	else
		return next_time - now;
}

/*************************************************/
/*** Robbo doesn't like this function :) *********/
/*************************************************/

void kill_robbo()
{
	int x,y;
	if(robbo.alive == 0)
		return;
	robbo.alive = 0;
	robbo.blocked = 0;
	if(robbo.lives >= 0)
		robbo.lives--;			

	create_object(robbo.x,robbo.y,BIG_BOOM);
	board[robbo.x][robbo.y].moved = DELAY_BIGBOOM;

	for(x=0;x<level.x;x++)
		for(y=0;y<level.y;y++)
			switch(board[x][y].type) {
				case EMPTY_FIELD:
				case WALL:
					break;
				default:
					board[x][y].moved = DELAY_BIGBOOM * 1;
					board[x][y].blowed=1;
			}
	if(robbo.lives < 0)
		game_is_started = 0;
		
	board_needs_refresh();
}

/**********************************************************/
/** If Robbo collects the last screw exit opens ***********/
/**********************************************************/

void open_exit() {
	robbo.exitopened = 1;
	level.now_is_blinking = DELAY_BLINKSCREEN;
	board_needs_refresh();
}

/**********************************************************/
/* Copying and archiving read level ***********************/
/**********************************************************/

		// these two functions don't look good - need to use copy_field function or something...
void copy_board() {
	int x, y;
	for(y=0;y<level.y;y++) {
		for(x=0;x<level.x;x++) {
			board_copy[x][y].type = board[x][y].type;
			board_copy[x][y].state = board[x][y].state;
			board_copy[x][y].direction = board[x][y].direction;
			board_copy[x][y].destroyable = board[x][y].destroyable;
			board_copy[x][y].blowable = board[x][y].blowable;
			board_copy[x][y].killing = board[x][y].killing;
			board_copy[x][y].moved = board[x][y].moved;
			board_copy[x][y].blowed = board[x][y].blowed;
			board_copy[x][y].shooted = board[x][y].shooted;
			board_copy[x][y].rotated = board[x][y].rotated;
			board_copy[x][y].solidlaser = board[x][y].solidlaser;
			board_copy[x][y].rotable = board[x][y].rotable;
			board_copy[x][y].randomrotated = board[x][y].randomrotated;
			board_copy[x][y].teleportnumber = board[x][y].teleportnumber;
			board_copy[x][y].teleportnumber2 = board[x][y].teleportnumber2;
			board_copy[x][y].direction2 = board[x][y].direction2;
			board_copy[x][y].movable = board[x][y].movable;
			board_copy[x][y].returnlaser = board[x][y].returnlaser;
			board_copy[x][y].shooting = board[x][y].shooting;
			board_copy[x][y].id_questionmark 	= 0;

		}	
	}
}

void restore_board() {
	int x, y;
	for(y=0;y<level.y;y++) {
		for(x=0;x<level.x;x++) {
			board[x][y].type 		= board_copy[x][y].type;
			board[x][y].state 		= board_copy[x][y].state;
			board[x][y].direction 		= board_copy[x][y].direction;
			board[x][y].destroyable 	= board_copy[x][y].destroyable;
			board[x][y].blowable 		= board_copy[x][y].blowable;
			board[x][y].killing 		= board_copy[x][y].killing;
			board[x][y].moved 		= board_copy[x][y].moved;
			board[x][y].blowed 		= board_copy[x][y].blowed;
			board[x][y].shooted 		= board_copy[x][y].shooted;
			board[x][y].rotated 		= board_copy[x][y].rotated;
			board[x][y].solidlaser 		= board_copy[x][y].solidlaser;
			board[x][y].rotable 		= board_copy[x][y].rotable;
			board[x][y].randomrotated 	= board_copy[x][y].randomrotated;
			board[x][y].teleportnumber 	= board_copy[x][y].teleportnumber;
			board[x][y].teleportnumber2 	= board_copy[x][y].teleportnumber2;
			board[x][y].id_questionmark 	= 0;
			board[x][y].direction2 		= board_copy[x][y].direction2;
			board[x][y].movable 		= board_copy[x][y].movable;
			board[x][y].returnlaser 	= board_copy[x][y].returnlaser;
			board[x][y].shooting 		= board_copy[x][y].shooting;
			set_images(board[x][y].type,x,y);
		}	
	}
}

/**************************************************************/
/***** Level initialization ***********************************/
/**************************************************************/

int level_init(int level_value, int force_fileread)
{
	int i;
		
	level.now_is_blinking = 0;
	init_robbo();
	KeyPressed = 0;
	KeyLastPressed = 0;

	robbo.level = level_value;
	level.number = level_value;
	
	if(level_value > LAST_LEVEL) {	// you've completed all levels
		game_is_started = 2;
		show_endscreen();
		return;
	}


	if(old_level == level_value && (force_fileread == 0)) {		// the same level - we have this in the board_copy
		restore_board();
		robbo.x = robbo.init_x;
		robbo.y = robbo.init_y;
		robbo.screws = level.init_screws;
		level.screws = level.init_screws;
		robbo.bullets = 0;
		level.bullets = 0;
	}
	else {
		i = read_from_file(level_value);
		old_level = level_value;
		copy_board();			// copy new board to board_copy
		
		if(i)
			game_is_started = 0;
				
	}
	
	if(level.screws == 0) {
		open_exit();
	}

	
	init_questionmarks();

	robbo.mapoffsetx = FIELD_SIZE * robbo.x;
	robbo.mapoffsety = FIELD_SIZE * robbo.y;
	
	
	board_needs_refresh();
	clear_screen();
	score_was_changed = 1;
	return i;
}


void check_object_if_blowed(int x, int y) {
	if(board[x][y].blowed && board[x][y].type != BIG_BOOM) {
		if(board[x][y].type == BOMB)
			blow_bomb(x,y);
		create_object(x,y,BIG_BOOM);
		refresh_field(x, y);
		board[x][y].moved = DELAY_BIGBOOM;
	}
}

/*****************************************************/
/**** Main function for the game - called every tick */
/*****************************************************/

void update_game()
{
	int x,y,i;
	struct Coords coords, coords_temp;
	
	if(is_robbo_killed())  	/* check if robbo is alive */
		kill_robbo();
		
	if(robbo.moved > 0)				/* lower time modificators of last action */
		robbo.moved--;

	if(robbo.shooted > 0)
		robbo.shooted--;

	if(robbo.moved == DELAY_ROBBO/2)		/* changing Robbo image */
		robbo.state = !robbo.state; 		/* state */
	
	if(robbo.blocked == 1 && robbo.moved == 0) {		// Robbo is killing by the magnet
			set_coords(&coords, robbo.x, robbo.y);
			
			if(can_move(coords,robbo.blocked_direction)) {
				if(robbo.blocked_direction == 0)
						robbo.x++;
				else if(robbo.blocked_direction == 2)
						robbo.x--;
				robbo.moved = DELAY_ROBBO * 2;
			}
			else {
				kill_robbo();
					return;
			}
	}

	for(x=0;x<level.x;x++)
		for(y=0;y<level.y;y++) {
							// checking every field
			if(board[x][y].type == GUN || board[x][y].type == BIRD) {
				if(board[x][y].shooted > 0)	    // gun shooted delay is not empty, decrease value
           				board[x][y].shooted--;
				if(board[x][y].rotated > 0)	    // rotation delay is not empty, decrease it
					board[x][y].rotated--;
			}
			
			if(board[x][y].rotated > 0)
				board[x][y].rotated--;

			if(board[x][y].moved > 0) {	    // object delay is not empty, next field
				board[x][y].moved--;
				continue;
			}
			else
				check_object_if_blowed(x,y);	// blow objects marked for blowing

			set_coords(&coords, x, y);

			switch(board[x][y].type) {
				case BEAR:
				case BEAR_B: {
					int dir, ndir, dir_inc, dir_temp;
					struct Coords coords_temp;
					set_coords(&coords_temp, x, y);
					dir_temp = board[x][y].direction;
					if(!update_coords(&coords_temp,dir_temp)) {
					
						if(board[coords_temp.x][coords_temp.y].type == LASER_L || 
						   board[coords_temp.x][coords_temp.y].type == LASER_D ||
						   (board[coords_temp.x][coords_temp.y].type == PUSH_BOX && 
						   board[coords_temp.x][coords_temp.y].state == 1))
						   	if(board[coords_temp.x][coords_temp.y].direction == ((board[x][y].direction + 2) & 0x03)) {
								board[x][y].moved = DELAY_BEAR;
								negate_state(x,y);
								break;
							}
					}
						
				
					dir_inc = board[x][y].type == BEAR ? 1 : (4 - 1);
					dir = ndir = (board[x][y].direction + 4 - dir_inc) & 0x03;
					do {
						board[x][y].direction = dir;		
						
						if(can_move(coords,dir)) {
							if(!update_coords(&coords, dir)) {
								if((dir == ((dir_temp +2 ) &0x03)) ) { // if bear is turning back - should wait a moment
									board[x][y].direction = board[x][y].type == BEAR ? (board[x][y].direction + 1) & 0x03 : (board[x][y].direction + 3) & 0x03;
									board[x][y].moved = DELAY_BEAR;
									negate_state(x,y);
									break;
								}
								else	{
									move_object(x,y,coords);
								}
							}
							board[coords.x][coords.y].moved = DELAY_BEAR;
							break;
						}
						dir = (dir + dir_inc) & 0x03;
					} while (dir != ndir);
					
					board[coords.x][coords.y].moved = DELAY_BEAR;
					negate_state(coords.x,coords.y);
					break;
				}
				case BARRIER: {
						int x_tmp, flag, temp_state, temp_blowed, temp_direction;
						struct Coords dest;
						flag = 0;
						x_tmp = x;
						
						if(board[x][y].direction == 0) {
							
							while(board[x_tmp][y].type != WALL && x_tmp < level.x)
								x_tmp++;
							x_tmp--;
							if(board[x_tmp][y].type == BARRIER) {
								temp_state = board[x_tmp][y].state;
								temp_blowed = board[x_tmp][y].blowed;
								temp_direction = board[x_tmp][y].direction;
								clear_field(&board[x_tmp][y]);
								negate_state(x_tmp,y);
								flag = 1;
							}

							while(board[x_tmp][y].type != WALL && x_tmp >= 0) {
								x_tmp--;
								if(board[x_tmp][y].type == BARRIER) {
									check_object_if_blowed(x_tmp,y);
									dest.x = x_tmp + 1;
									dest.y = y;
									
									if((dest.x == robbo.x) &&( dest.y == robbo.y))
										kill_robbo();
									move_object(x_tmp,y,dest);
							//		board[dest.x][dest.y].direction = 0;
									board[dest.x][dest.y].moved = DELAY_BARRIER;
									negate_state(dest.x,dest.y);
								}
							}
							
							x_tmp++;
							
							if(flag == 1) {
								if((dest.x == robbo.x) &&( dest.y == robbo.y))
									kill_robbo();
								create_object(x_tmp,y,BARRIER);
								board[x_tmp][y].state = temp_state;
								board[x_tmp][y].blowed = temp_blowed;
								board[x_tmp][y].direction = temp_direction;
								board[x_tmp][y].moved = DELAY_BARRIER;
								negate_state(x_tmp,y);
							}
						}	
						else if(board[x][y].direction == 2) {
							while(board[x_tmp][y].type != WALL && x_tmp >= 0)
								x_tmp--;
							
							x_tmp++;
							
							if(board[x_tmp][y].type == BARRIER) {
								temp_state = board[x_tmp][y].state;
								temp_blowed = board[x_tmp][y].blowed;
								temp_direction = board[x_tmp][y].direction;
								clear_field(&board[x_tmp][y]);
								negate_state(x_tmp,y);
								flag = 1;
							}

							while(board[x_tmp][y].type != WALL && x_tmp < level.x) {
								x_tmp++;
								if(board[x_tmp][y].type == BARRIER) {
									check_object_if_blowed(x_tmp,y);
									dest.x = x_tmp - 1;
									dest.y = y;
									
									if((dest.x == robbo.x) &&( dest.y == robbo.y))
										kill_robbo();
									move_object(x_tmp,y,dest);
								//	board[dest.x][dest.y].direction = 2;
									board[dest.x][dest.y].moved = DELAY_BARRIER;
									negate_state(dest.x,dest.y);
								}
							}
							
							x_tmp--;
							
							if(flag == 1 && temp_blowed == 0) {
								if((dest.x == robbo.x) &&( dest.y == robbo.y))
									kill_robbo();
								create_object(x_tmp,y,BARRIER);
								board[x_tmp][y].state = temp_state;
								board[x_tmp][y].moved = DELAY_BARRIER;
								board[x_tmp][y].direction = temp_direction;
								negate_state(x_tmp,y);
							}
						}
						
					break;
					}
				case BIRD:
					if(can_move(coords,board[x][y].direction)) {
						update_coords(&coords,board[x][y].direction);
						move_object(x,y,coords);

					}
					else
						board[x][y].direction = (board[x][y].direction +2) & 0x03;

					if(board[coords.x][coords.y].shooting) {
						if(board[coords.x][coords.y].shooted == 0) {
							if((my_rand() & 0x07) == 0)						// bird shoots
								shoot_object(coords.x,coords.y,board[coords.x][coords.y].direction2);
							else
								board[coords.x][coords.y].shooted = DELAY_LASER;
						}
					}
					board[coords.x][coords.y].moved = DELAY_BIRD;
					negate_state(coords.x,coords.y);
					break;
				case BUTTERFLY:
					if(can_move(coords, board[x][y].direction)) {
						update_coords(&coords,board[x][y].direction);
						move_object(x,y,coords);
					}
				
					if(!(rand() & 0x07))				// chances for random move
						board[coords.x][coords.y].direction = rand() & 0x03;
					
					else if((rand() & 0x01) == 0) {			// if butterfly flies horizontally
						if(robbo.x > coords.x)
							board[coords.x][coords.y].direction = 0;
						else if(robbo.x < coords.x)
							board[coords.x][coords.y].direction = 2;
					}
					else {								// if butterfly flies vertically
						if(robbo.y > coords.y)
							board[coords.x][coords.y].direction = 1;
						else if(robbo.y < coords.y)
							board[coords.x][coords.y].direction = 3;
					}
				
					board[coords.x][coords.y].moved = DELAY_BUTTERFLY;
					negate_state(coords.x,coords.y);
					break;
				case BLASTER:
					if(!update_coords(&coords, board[x][y].direction) && board[x][y].state == 0) {
						if(robbo.x == coords.x && robbo.y == coords.y)
							kill_robbo();
							
						switch(board[coords.x][coords.y].type) {
							case WALL:
							case BOX:
							case PUSH_BOX:
							case GUN:
							case LASER_D:
							case LASER_L:
							case BLASTER:
							case SCREW:
							case CAPSULE:
								break;
							default:
								clear_field(&board[coords.x][coords.y]);
								create_object(coords.x,coords.y,BLASTER);
								board[coords.x][coords.y].direction = board[x][y].direction;
								board[coords.x][coords.y].direction2 = board[x][y].direction2;
								board[coords.x][coords.y].moved = DELAY_BLASTER;
						}
					}
				
					if(board[x][y].state < 4) {
						board[x][y].state++;
						board[x][y].moved = DELAY_BLASTER;
					}
					else {
						clear_field(&board[x][y]);
					}
					
					refresh_field(x, y);
					break;
				case CAPSULE:
					if(robbo.exitopened) {
						negate_state(x, y);
						board[x][y].moved = DELAY_CAPSULE;	
					}
					break;
				case LITTLE_BOOM:
					if(board[x][y].state < 4) {
						board[x][y].state++;
						board[x][y].moved = DELAY_BOOM;
					
					}
					else
						clear_field(&board[x][y]);
					refresh_field(x, y);
					break;
				case LASER_L:
				case LASER_D:
					update_coords(&coords,board[x][y].direction);
					board[x][y].moved = DELAY_LASER;

					if((coords.x == robbo.x) &&( coords.y == robbo.y) && !board[x][y].returnlaser) {
						kill_robbo();
						break;
					}
				
					set_coords(&coords, x, y);
					if(board[x][y].solidlaser == 0) {
						negate_state(x, y);

						if(can_move(coords,board[x][y].direction)) {				// normal shooting
							update_coords(&coords,board[x][y].direction);
							move_object(x,y,coords);
							board[coords.x][coords.y].moved = DELAY_LASER;	
						}
						else {														// blow object if it's destroyable
							if(!update_coords(&coords,board[x][y].direction) && board[coords.x][coords.y].destroyable) {
								clear_field(&board[x][y]);
								board[coords.x][coords.y].blowed = 1;
								refresh_field(coords.x, coords.y);
							}
							else {
								clear_field(&board[x][y]);							// clear lasertrack
								create_object(x,y,LITTLE_BOOM);
								board[x][y].moved = DELAY_BOOM;
								break;
							}
						}
					}
					else {											// laser is solid
						if(can_move(coords,board[x][y].direction) && board[x][y].returnlaser == 0) {	// if can shoot
							update_coords(&coords,board[x][y].direction);
							shoot_object(x,y,board[x][y].direction);
							board[coords.x][coords.y].moved = DELAY_LASER;
						}
						else {
							if(board[x][y].returnlaser == 1) {
								set_coords(&coords,x,y);					// checking if laser is near gun
								update_coords(&coords,(board[x][y].direction+2) & 0x03);
								clear_field(&board[x][y]);
							
								if(board[coords.x][coords.y].type == GUN) {
									create_object(x,y,LITTLE_BOOM);
									break;
								}
						
								if(board[coords.x][coords.y].type == LASER_D || board[coords.x][coords.y].type == LASER_L) {
									board[coords.x][coords.y].returnlaser = 1;
									board[coords.x][coords.y].moved = DELAY_LASER;
								}
									
							}
							else {		
								set_coords(&coords, x, y);
								if(!update_coords(&coords,board[x][y].direction)) {
									if(board[coords.x][coords.y].type == LASER_D || board[coords.x][coords.y].type == LASER_L) {
										if(board[coords.x][coords.y].direction == board[x][y].direction)
											break;
									}
									if(board[coords.x][coords.y].destroyable)
										board[coords.x][coords.y].blowed = 1;
								}	
								board[x][y].returnlaser = 1;
							}
						}
					}
					refresh_field(x, y);
					break;
				case BIG_BOOM:
					if(board[x][y].state < 4) {
						board[x][y].state++;
						board[x][y].moved = DELAY_BIGBOOM;
					}
					else {
						i = board[x][y].id_questionmark;
						if((i > 0) && robbo.alive) {
							clear_field(&board[x][y]);
							board[x][y].id_questionmark = 0;
							create_object(x,y,i);
							switch(i) {
								case CAPSULE:
									open_exit();
									break;
								case GUN:
									board[x][y].rotable = 1;
									board[x][y].randomrotated = 1;
									board[x][y].direction = rand() & 0x03;
									break;
								default:
									break;
							}
						}
						else
							clear_field(&board[x][y]);
                   			}
			                   	refresh_field(x, y);
					break;
				case TELEPORT:
					negate_state(x, y);
					board[x][y].moved = DELAY_TELEPORT;
					break;
				case PUSH_BOX:
					if(board[x][y].state == 1) {	// box is moving
						set_coords(&coords,x,y);
						if(!update_coords(&coords,board[x][y].direction)) {
							if(board[coords.x][coords.y].type == EMPTY_FIELD) {
								move_object(x,y,coords);
							}
							else {
								shoot_object(x,y,board[x][y].direction);
								board[x][y].state = 0;
							}
						}
						else
							board[x][y].state = 0;	
						board[coords.x][coords.y].moved = DELAY_PUSHBOX;
					}
					break;
				case MAGNET:
					i=0;
					while(i==0) {
						if(!update_coords(&coords,board[x][y].direction)) {
							if(robbo.x == coords.x && robbo.y == coords.y) {
								robbo.blocked = 1;
								robbo.blocked_direction = (board[x][y].direction+2) & 0x03;
							}
							else
								switch(board[coords.x][coords.y].type) {
										// this things don't protect from magnet
									case EMPTY_FIELD:
										break;
									default:
										i=1;
										break;
								}
						
						}
						else
							i=1;
					}
					break;
				case GUN: {
					if(board[x][y].movable) {
						if(can_move(coords,board[x][y].direction2)) {
							update_coords(&coords,board[x][y].direction2); 
							move_object(x,y,coords);
							board[coords.x][coords.y].moved = DELAY_GUN;
						}
						else {
							board[x][y].direction2 = (board[x][y].direction2+2) & 0x03;
							board[x][y].state = board[x][y].direction;
							board[x][y].moved = DELAY_GUN;
						}
					}

					if(board[coords.x][coords.y].rotable)
						if(board[coords.x][coords.y].rotated == 0) {
							if(board[coords.x][coords.y].randomrotated)
								board[coords.x][coords.y].direction = rand() & 0x03;
							else
								board[coords.x][coords.y].direction = (board[coords.x][coords.y].direction+1) & 0x03;
							board[coords.x][coords.y].rotated = DELAY_ROTATION;
							refresh_field(coords.x,coords.y);
						}

					if(board[coords.x][coords.y].shooted == 0) {
					
						if(board[coords.x][coords.y].solidlaser == 2) {
							if((rand() & 0x07) == 0) {			// it's blaster 
								set_coords(&coords_temp,coords.x,coords.y);
								update_coords(&coords_temp,board[coords.x][coords.y].direction);
							
								if(robbo.x == coords_temp.x && robbo.y == coords_temp.y)
									kill_robbo();
								
								switch(board[coords_temp.x][coords_temp.y].type) {
									case BLASTER:
									case WALL:
									case BOX:
									case PUSH_BOX:
									case CAPSULE:
									case SCREW:
									case GUN:
										board[coords.x][coords.y].shooted = DELAY_LASER;
										break;
									default:
										clear_field(&board[coords_temp.x][coords_temp.y]);
										create_object(coords_temp.x, coords_temp.y,BLASTER);
										board[coords_temp.x][coords_temp.y].direction = board[x][y].direction;
										board[coords_temp.x][coords_temp.y].direction2 = board[x][y].direction2;
										board[coords_temp.x][coords_temp.y].moved = DELAY_BLASTER;
										board[coords.x][coords.y].shooted = DELAY_LASER;
								}
							}
							else
								board[coords.x][coords.y].shooted = DELAY_LASER;
						}
						else {
							if((rand() & 0x07) == 0)						// gun shoots
								shoot_object(coords.x,coords.y,board[coords.x][coords.y].direction);
							else
								board[coords.x][coords.y].shooted = DELAY_LASER;
						}
					}

					board[coords.x][coords.y].state = board[coords.x][coords.y].direction;
					break;
					}
		} 
	} 
}


/*********************************/
/**** Main loop ******************/
/*********************************/

int main()
{
	int quit, n, x, y, c;
	time_t t;

	quit = n = x = y = c = 0;
	
	time(&t);
	my_srand(t);	/* random generator init */
	 
	if(SDL_Init(SDL_INIT_VIDEO)) {
		fprintf(stdout, "Cannot init SDL: %s",SDL_GetError());
		return 1;
	}

	atexit(SDL_Quit);
	
	load_bitmaps();

	SDL_WM_SetCaption("GNU Robbo","gnurobbo");
	SDL_WM_SetIcon(icon,NULL);
	
	screen = SDL_SetVideoMode(580,500,16,SDL_DOUBLEBUF | SDL_HWSURFACE |  SDL_ANYFORMAT);
 
	if(screen == NULL) {
		fprintf(stdout, "Cannot initiate screen: %s\n",SDL_GetError());
		exit(1);  
	}
   
   	if(TTF_Init()) {
   		fprintf(stdout,"Cannot initialize SDL_ttf module\n");
   		exit(1);
 	}
 	
	/* font initialization */ 	
 	if((font = TTF_OpenFont(ROBBO_FONT,FONTSIZE)) == NULL) {
		fprintf(stdout,"Cannot load robbo font: %s\n",ROBBO_FONT);
		exit(1);
	}

	
 	KeyPressed = 0x00000;
 	MenuPosition = 0;
 	typing_code = 0;
 	strcpy(TypeBuffer,"_\0");
 	strcpy(TextBuffer," \0");
 	
 	level_init(ROBBO_LEVEL_START,1);
 	robbo.level = 1;
 	strcpy(level.code,"ROBBO");
 	game_is_started = 0;

#ifdef __AMIGA__ 	
 	user_home_dir = (char*) "PROGDIR:";
#else
 	user_home_dir = (char*) getenv("HOME");
#endif
	strncpy(path_resource_file,user_home_dir,80);
	strcat(path_resource_file,RESOURCE_FILE);
	
	if(test_resource_file() == 0)
 		read_resource_file(); 	
							// a bit of description displayed at console
#ifndef __AMIGA__
	fprintf(stdout,"Welcome to GNU ROBBO\n\n");
	fprintf(stdout,"This is old ATARI XE/XL game ported to linux.\n");
	fprintf(stdout,"Help robbo to get out of this planet. Go to the \n");
	fprintf(stdout,"capsule which will take you to the next level...\n");
	fprintf(stdout,"Unfortunatelly, most of capsules are incomplete,\n");
	fprintf(stdout,"so you have to collect all their parts to make them work.\n");
	fprintf(stdout,"The planet is occupied by unfriendly animals\n");
	fprintf(stdout,"trying to kill Robbo. There are many items, try\n");
	fprintf(stdout,"to shoot them, push to check what is their purpose.\n\n");
	fprintf(stdout,"Good Luck\n\n");
	fprintf(stdout,"Keys:\n-------\n");
	fprintf(stdout,"F9 - quit game\n");
	fprintf(stdout,"ESC - make suicide\n");
	fprintf(stdout,"ARROWS - move robbo\n");
	fprintf(stdout,"SHIFT + ARROWS - shoot\n");
	fprintf(stdout,"\nThere're 52 planets available as for now,\n");
	fprintf(stdout,"but check cvs gnurobbo.sourceforge.net to get more...\n");
#endif	
	next_time = SDL_GetTicks() + TICK_INTERVAL;
	show_startscreen();

	while(quit == 0) {
		if(game_is_started == 1)
		{
			while(SDL_PollEvent(&event)) {
				switch(event.type) {
					case SDL_KEYDOWN:
						switch(event.key.keysym.sym) {
							case SDLK_ESCAPE:
										kill_robbo();
								break;
							case SDLK_RETURN:
									if(!robbo.alive)
										level_init(robbo.level,0);
								break;
							case SDLK_LEFT:
									if(robbo.alive) {
										KeyPressed |= 0x00100;
										KeyLastPressed = 0x00100;
									}
								break;
							case SDLK_RIGHT:
									if(robbo.alive) {
										KeyPressed |= 0x10000;
										KeyLastPressed = 0x10000;
									}
								break;
							case SDLK_DOWN:
									if(robbo.alive) {
										KeyPressed |= 0x01000;
										KeyLastPressed = 0x01000;
									}
								break;
							case SDLK_UP:
									if(robbo.alive) {
										KeyPressed |= 0x00010;
										KeyLastPressed = 0x00010;
									}
								break;
							case SDLK_RSHIFT:
							case SDLK_LSHIFT:
									if(robbo.alive)
										KeyPressed |= 0x00001;
								break;
							case SDLK_F9:
								game_is_started = 0;
								break;
							default:
								break;
						}
						break;
						
					case SDL_KEYUP:
						switch(event.key.keysym.sym) {
							case SDLK_LEFT:
									if(robbo.alive) {
										KeyPressed &= 0x11011;
										if(KeyLastPressed == 0x00100)
											KeyLastPressed = 0;
									}
								break;
							case SDLK_RIGHT:
									if(robbo.alive) {
										KeyPressed &= 0x01111;
										if(KeyLastPressed == 0x10000)
											KeyLastPressed = 0;
									}
								break;
							case SDLK_DOWN:
									if(robbo.alive) {
										KeyPressed &= 0x10111;
										if(KeyLastPressed == 0x01000)
											KeyLastPressed = 0;
									}
								break;
							case SDLK_UP:
									if(robbo.alive) {
										KeyPressed &= 0x11101;
										if(KeyLastPressed == 0x00010)
											KeyLastPressed = 0;
									}
								break;
							case SDLK_RSHIFT:
							case SDLK_LSHIFT:
									if(robbo.alive)
										KeyPressed &= 0x11110;
								break;
							default:
								break;
						}
						break;
					case SDL_QUIT:
						quit = 1;
						break;
					default:
						break;
				}
			}

			if(KeyPressed > 1) {
				if(KeyLastPressed) {
					if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x10000)
						move_robbo(1,0);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x10001)
						shoot_robbo(1,0);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x01000)
						move_robbo(0,1);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x01001)
						shoot_robbo(0,1);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x00100)
						move_robbo(-1,0);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x00101)
						shoot_robbo(-1,0);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x00010)
						move_robbo(0,-1);
					else if((KeyLastPressed | (0x00001 & KeyPressed)) == 0x00011)
						shoot_robbo(0,-1);
				}
				else {
					if((KeyPressed & 0x10001) == 0x10000)
						move_robbo(1,0);
					else if((KeyPressed & 0x10001) == 0x10001)
						shoot_robbo(1,0);
					else if((KeyPressed & 0x01001) == 0x01000)
						move_robbo(0,1);
					else if((KeyPressed & 0x01001) == 0x01001)
						shoot_robbo(0,1);
					else if((KeyPressed & 0x00101) == 0x00100)
						move_robbo(-1,0);
					else if((KeyPressed & 0x00101) == 0x00101)
						shoot_robbo(-1,0);
					else if((KeyPressed & 0x00011) == 0x00010)
						move_robbo(0,-1);
					else if((KeyPressed & 0x00011) == 0x00011)
						shoot_robbo(0,-1);
				}
			}
			update_game();
			set_mapoffset();
			switch(game_is_started) {
				case 0:
					show_startscreen();
					break;
				case 1:
					show_gamearea();
					break;
				case 2:
					show_endscreen();
					break;
			}
			next_time++;
			SDL_Delay(TICK_INTERVAL);
		}
		else if(game_is_started == 0) {				// start screen
			while(SDL_PollEvent(&event)) {
				switch(event.type) {
					case SDL_KEYDOWN:
						switch(event.key.keysym.sym) {
							case SDLK_DOWN:
								if(typing_code == 0)
									if(MenuPosition < 2)
										MenuPosition++;
								break;
							case SDLK_UP:
								if(typing_code == 0)
									if(MenuPosition > 0)
										MenuPosition--;
								break;
							case SDLK_RETURN:
								if(MenuPosition == 0) {
									if(typing_code == 0) {
										game_is_started = 1;
										robbo.level = robbo.level == 0 ? ROBBO_LEVEL_START : robbo.level;
										robbo.score = 0;
										robbo.lives = ROBBO_LIVES_START;
										level_init(robbo.level,1);
										show_gamearea();
									}
								}
								else if(MenuPosition == 1) {
									if(typing_code == 0) {
										typing_code = 1;
										sprintf(TypeBuffer,"_\0\0\0\0\0");

									}
									else {
										c = 0;		// position of TypeBuffer
										typing_code = 0;
										// Finding level...
										n = read_convert_code(&TypeBuffer); 
										if(n != -1) {
											robbo.level = n;
											level.number = n;
											sprintf(level.code,"%5s\0", TypeBuffer);
										}
										sprintf(TypeBuffer,"%s","     \0");
									
									}
									break;
								}
								else if(MenuPosition == 2) {
									quit = 1;
								}
								break;
							case SDLK_a:
								if(typing_code == 1 &&  c < CODE_LENGTH) {
									TypeBuffer[c++] = 'A';
								}
								break;
							case SDLK_b:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'B';
								}
								break;
							case SDLK_c:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'C';
								}
								break;
							case SDLK_d:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'D';
								}
								break;
							case SDLK_e:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'E';
								}
								break;
							case SDLK_f:
								if(typing_code == 1 && c <CODE_LENGTH) {
									TypeBuffer[c++] = 'F';
								}
								break;
							case SDLK_g:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'G';
								}
								break;
							case SDLK_h:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'H';
								}
								break;
							case SDLK_i:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'I';
								}
								break;
							case SDLK_j:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'J';
								}
								break;
							case SDLK_k:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'K';
								}
								break;
							case SDLK_l:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'L';
								}
								break;
							case SDLK_m:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'M';
								}
								break;
							case SDLK_n:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'N';
								}
								break;
							case SDLK_o:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'O';
								}
								break;
							case SDLK_p:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'P';
								}
								break;
							case SDLK_q:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'Q';
								}
								break;
							case SDLK_r:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'R';
								}
								break;
							case SDLK_s:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'S';
								}
								break;
							case SDLK_t:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'T';
								}
								break;
							case SDLK_u:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'U';
								}
								break;
							case SDLK_v:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'V';
								}
								break;
							case SDLK_w:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'W';
								}
								break;
							case SDLK_x:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'X';
								}
								break;
							case SDLK_y:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'Y';
								}
								break;
							case SDLK_z:
								if(typing_code == 1 && c < CODE_LENGTH) {
									TypeBuffer[c++] = 'Z';
								}
								break;
							case SDLK_BACKSPACE:
							case SDLK_DELETE:
								if(typing_code == 1 && c > 0)
								{
									c--;						
									TypeBuffer[c] = ' ';
								}
								break;

							default:
								break;
						}
						switch(game_is_started) {
							case 0:
								show_startscreen();
							break;
							case 1:
								show_gamearea();
								break;
							case 2:
								show_endscreen();
								break;
							}
						break;
					case SDL_QUIT:
						quit = 1;
						break;
				}
			}
		next_time++;
		SDL_Delay(TICK_INTERVAL);
		}
		else if(game_is_started == 2) {	//end screen
			//show_endscreen();
			while(SDL_PollEvent(&event)) {
				switch(event.type) {
					case SDL_KEYDOWN:
						switch(event.key.keysym.sym) {
							case SDLK_RETURN:
								game_is_started = 0;
								level.number = 1;
								robbo.level = 1;
								strncpy(level.code,"ROBBO",5);
								break;
							default:
								break;
						}
						switch(game_is_started) {
							case 0:
								show_startscreen();
							break;
							case 1:
								show_gamearea();
								break;
							case 2:
								show_endscreen();
								break;
							}
						break;
					case SDL_QUIT:
						quit = 1;
						break;
				}
			}
		next_time++;
		SDL_Delay(TICK_INTERVAL);
		}
		
	}
	TTF_CloseFont(font);
	TTF_Quit();
	save_resource_file();
	return 0;
}
