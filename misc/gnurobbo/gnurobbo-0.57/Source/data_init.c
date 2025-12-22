/*
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
#include <sys/stat.h>

/****************************************************/
/*** Transformation char for object value ***********/
/****************************************************/

int transform_char(char c)
{
	switch(c)
	{
		case '.':
			return EMPTY_FIELD;
		case 'R':
			return ROBBO;    
		case 'O':
			return WALL;
		case 'Q':
			return WALL_RED;
		case 'T':
			return SCREW;
		case '\'':
			return BULLET;
		case '#':
			return BOX;
		case '%':
			return KEY;
		case 'b':
			return BOMB;
		case 'D':
			return DOOR;
		case '?':
			return QUESTIONMARK;
		case '@':
			return BEAR;
		case '^':
			return BIRD;
		case '!':
			return CAPSULE;
		case '+':
			return LIVE;
		case 'H':
			return GROUND;
		case 'o':
			return WALL_GREEN;
		case '*':
			return BEAR_B;
		case 'V':
			return BUTTERFLY;
		case '&':
			return TELEPORT;
		case '}':
			return GUN;
		case 'M':
			return MAGNET;
		case ' ':
			return BLACK_WALL;
		case '~':
			return PUSH_BOX;
		case '=':
			return BARRIER;
	}
}


/*****************************************************/
/* Searching levelfile for number for typed code *****/
/*****************************************************/

int read_convert_code(char *code) {	// we must find number of level having code
	FILE *fp;
	char line[MAX_X+1];
	int temp = 0;
	char readed_code[CODE_LENGTH+1];
	int readed_level;


	if((fp = fopen(ROBBO_LEVELS,"r")) == NULL) {
		printf("Cannot read from file %s\n",ROBBO_LEVELS);
		printf("Program terminated...\n");
		return 1;
	}

	while((fgets(line, MAX_X + 1, fp)) != NULL) {
			if(!strncmp(line, "[level]", 7)) {
				fscanf(fp,"%i.%6s.%s",&readed_level,&TextRGBColor,&readed_code);
				if(!strncmp(code,readed_code,CODE_LENGTH)) {
					fclose(fp);
					return readed_level;
				}
			}
	}	
	fclose(fp);
	return -1;		// no level found
}


/**************************************************************/
/* Function for testing .gnurobborc file in user home dir *****/
/* If file exists function returns 0 **************************/
/**************************************************************/

int test_resource_file()
{
	struct stat statbuf;
	if(stat(path_resource_file,&statbuf) == -1) {
		fprintf(stdout,"Nie otwarto\n");
		return -1;
	}	
	return 0;
}


/**************************************************************/
/***** Function for reading data from resource file ***********/
/**************************************************************/

void read_resource_file()
{
	FILE* file;
	int n;
	file= fopen(path_resource_file,"r");
	fscanf(file,"%6s",&TypeBuffer);
	n = read_convert_code(TypeBuffer);
	if(n != -1) {
		robbo.level = n;
		level.number = n;
		sprintf(level.code,"%5s\0", &TypeBuffer);
	}
	sprintf(TypeBuffer,"%s","     \0");
	fclose(file);
}



/**************************************************************/
/***** Function for saving data to resource file **************/
/**************************************************************/

void save_resource_file()
{
	FILE* file;
	int n;
	if((file = fopen(path_resource_file,"w")) == NULL)
		return;
	fprintf(file,"%5s",level.code);
	fclose(file);
}

/**************************************************************/
/*** Transformation RGB hex value onto Uint32 *****************/
/**************************************************************/

Uint32 transform_RGB_colour(char *TextRGB) {
	int i;
	Uint32 value, colour;
	value = 1;
	colour = 0;
	
	for(i=5;i>=0;i--) {
		switch(TextRGB[i]) {
			case '0':
				break;
			case '1':
				colour += value;
				break;
			case '2':
				colour += value * 2;
				break;
			case '3':
				colour += value * 3;
				break;
			case '4':
				colour += value * 4;
				break;
			case '5':
				colour += value * 5;
				break;
			case '6':
				colour += value * 6;
				break;
			case '7':
				colour += value * 7;
				break;
			case '8':
				colour += value * 8;
				break;
			case '9':
				colour += value * 9;
				break;
			case 'a':
			case 'A':
				colour += value * 10;
				break;
			case 'b':
			case 'B':
				colour += value * 11;
				break;
			case 'c':
			case 'C':
				colour += value * 12;
				break;
			case 'd':
			case 'D':
				colour += value * 13;
				break;
			case 'e':
			case 'E':
				colour += value * 14;
				break;
			case 'f':
			case 'F':
				colour += value * 15;
				break;
			default:
				fprintf(stdout,"Unknown character in RGB colour value\n");
				break;
		}
		value = value * 16;
	}
	return colour;
}

/***************************************************************/
/* This function is called every time we need new level ********/
/***************************************************************/


int read_from_file(int level_number)
{
	FILE *fp;
	char line[MAX_X+1];
	int level_temp = 0;
	char readed_code[CODE_LENGTH+1];
	int param_number = 0;
	int i=0;
	int screws = 0;
	int values[6]; /* buffer for additional params */
	int ok = 0;
	int x=0,y=0;		/* board coordinations */
	char n;
	
	
	if((fp = fopen(ROBBO_LEVELS,"r")) == NULL) {
		printf("Cannot read from file %s\n",ROBBO_LEVELS);
		printf("Program terminated...\n");
		return 1;
	}

	while((fgets(line, MAX_X + 1, fp)) != NULL && (ok == 0)) {
		if(level_temp == 0) {
			if(!strncmp(line, "[level]", 7)) {
				fscanf(fp,"%i.%6s.%s",&level_temp,&TextRGBColor,&readed_code);
				if(level_temp == level_number) {
					level.number = level_temp;
				}
				else
					level_temp = 0;
			}
		}
		else {
			level.color = transform_RGB_colour(TextRGBColor);
			if(!strncmp(line,"[size]",6)) {
				fscanf(fp,"%i.%i.%i",&level.x,&level.y);
			}

			if(!strncmp(line,"[author]",8)) {
				i=0;
				while((n = fgetc(fp)) != '\n') {
					level.author[i] = n;
					i++;
				}
				level.author[i] = '\0';
			}

			if(!strncmp(line,"[data]",6)) {
				while(fgets(line,MAX_X+1,fp) != NULL && (ok == 0)) {
					if(!strncmp(line,"[additional]",12)) {
						fscanf(fp,"%i",&param_number);
						for(i=0;i<param_number;i++) {
							fscanf(fp,"%i.%i.%c.%i.%i.%i.%i.%i.%i",&x,&y,&n,&values[0],&values[1],&values[2],&values[3],&values[4],&values[5]);

							switch(transform_char(n)) {
								case TELEPORT:
									board[x][y].teleportnumber = values[0];
									board[x][y].teleportnumber2 = values[1];
									break;
								case GUN:
									board[x][y].direction = values[0];
									board[x][y].state = values[0];
									board[x][y].direction2 = values[1];
									board[x][y].solidlaser = values[2];
									board[x][y].movable = values[3];
									board[x][y].rotable = values[4];
									board[x][y].randomrotated = values[5];
									break;
								case MAGNET:
									board[x][y].state = values[0];
								case BARRIER:
									board[x][y].direction = values[0];
									break;
								case BIRD:
								        board[x][y].direction2 = values[1];
								        board[x][y].shooting = values[2];
								case BEAR_B:
								case BEAR:
									board[x][y].direction = values[0];
									break;
							}
							
						}
						ok = 1;
					}
					else {
								/* board init */
						for(x=0;x<level.x;x++) {
							clear_field(&board[x][y]);
							board[x][y].type = transform_char(line[x]);
							if(board[x][y].type != 0)
								create_object(x,y,board[x][y].type);

							if(board[x][y].type == SCREW)
								screws++;
							else if(board[x][y].type == WALL_RED) {
								create_object(x,y,WALL);
								board[x][y].state = 1;
								}
							else if(board[x][y].type == WALL_GREEN) {
								create_object(x,y,WALL);
								board[x][y].state = 2;
								}
							else if(board[x][y].type == BLACK_WALL) {
								create_object(x,y,WALL);
								board[x][y].state = 3;
								}
						}
	     					y++;
					}
	    			}
			}
		}
	}

	fclose(fp);
	
	if(level_temp == 0 || ok == 0) {
		sprintf(level.code,"%s\0"," ");
		return 1;           /* level not found or not succesfully readed */
	}
	
	sprintf(level.code,"%s\0",readed_code);
	robbo.screws = screws;		// how many screws Robbo has to collect?
	robbo.bullets = 0;
	level.screws = level.init_screws = screws;
	level.bullets = 0;

	return 0;
}

/**********************************************/
/*  Robbo initialization **********************/
/* robbo.level value is set by the game *******/
/**********************************************/


void init_robbo()
{
	robbo.state = 0;
	robbo.direction = 0;
	robbo.score = robbo.score>0?robbo.score:0;
	robbo.moved = DELAY_ROBBO;
	robbo.keys = 0;
	robbo.shooted = 0;
	robbo.alive = 1;
	robbo.mapoffsetx = 0;
	robbo.mapoffsety = 0;
	robbo.exitopened = 0;
	robbo.blocked = 0;
	robbo.blocked_direction = 0;
}

/******************************************************/
/* Field clearing - After then we have an empty field */
/******************************************************/

void clear_field(struct object *obj)
{
	int i;
	if(obj->type != QUESTIONMARK)
		obj->id_questionmark = 0;
	obj->type = 0;
	obj->state = 0;
	obj->direction = 0;
	obj->destroyable = 0;
	obj->blowable = 0;
	obj->killing = 0;
	obj->blowed = 0;
	obj->randomrotated = 0;
	obj->rotated = 0;
	obj->shooted = 0;
	obj->moved = 0;
	obj->direction2 = 0;
	obj->movable = 0;
	obj->rotable = 0;
	obj->solidlaser = 0;
	obj->returnlaser = 0;
	obj->teleportnumber = 0;
	obj->teleportnumber2 = 0;
	obj->shooting = 0;
	for(i=0;i<5;i++) {
		obj->icon[i].x = 0;		/* resetting the coords of icon */
		obj->icon[i].y = 0;
	}
}

void create_object(int x, int y, int type)
{
	int i;
	for(i=0;i<5;i++) {
		board[x][y].icon[i].x = 0;
		board[x][y].icon[i].y = 0;
	}

	switch(type) {
		case ROBBO:
			robbo.x = robbo.init_x = x;
			robbo.y = robbo.init_y = y;
			robbo.state=0;
			board[x][y].type = 0;
			return;
		case WALL:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			board[x][y].killing = 0;
			break;
		case SCREW:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case BULLET:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
		case PUSH_BOX:
		case BOX:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case KEY:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case BOMB:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
		case DOOR:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case QUESTIONMARK:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
		case CAPSULE:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			break;
		case LIVE:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
		case GROUND:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
		case BEAR:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			board[x][y].killing = 1;
			break;
		case BIRD:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			board[x][y].killing = 1;
			break;
		case LITTLE_BOOM:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			board[x][y].killing = 0;
			break;
		case LASER_L:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case LASER_D:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case BEAR_B:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			board[x][y].killing = 1;
			break;
		case BUTTERFLY:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			board[x][y].killing = 1;
			break;
		case TELEPORT:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case BIG_BOOM:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			board[x][y].killing = 0;
			break;
		case GUN:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 1;
			break;
		case MAGNET:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			break;
		case BLASTER:
			board[x][y].destroyable = 0;
			board[x][y].blowable = 0;
			break;
		case BARRIER:
			board[x][y].destroyable = 1;
			board[x][y].blowable = 1;
			break;
 	}

	board[x][y].type = type;
	board[x][y].blowed = 0;
	board[x][y].moved = 0;
	board[x][y].shooted = 0;
	board[x][y].rotated = 0;
	board[x][y].randomrotated = 0;
	board[x][y].direction2 = 0;
	board[x][y].solidlaser = 0;
	board[x][y].shooting = 0;
	board[x][y].returnlaser = 0;

        set_images(board[x][y].type,x,y);
        refresh_field(x,y);
}

int update_coords(struct Coords *coords, int direction)
{
	struct Coords coords_temp;
	coords_temp.x = coords->x;
	coords_temp.y = coords->y;

	if(direction == 0)
		coords->x++;
	else if(direction == 1)
		coords->y++;
	else if(direction == 2)
		coords->x--;
	else
		coords->y--;

	if(coords->x < 0 || coords->y < 0 || coords->x >= level.x || coords->y >= level.y) {
		set_coords(coords,coords_temp.x,coords_temp.y);
		return 1;
	}
	return 0;
}

void set_coords(struct Coords *coords, int x, int y)
{
	coords->x = x;
	coords->y = y;
}

int coords_out_range(struct Coords coords)
{
	if(coords.x < 0 || coords.x >= level.x || coords.y < 0 || coords.y >= level.y)
		return 1;
	else
		return 0;
}

void set_images(int type,int x, int y)
{
	if(FIELD_SIZE == 16)		// This part of code needed only after decreasing icons two times
	{
		switch(type) {
			case EMPTY_FIELD:
				set_coords(&board[x][y].icon[0],0,0);
				break;
			case WALL:
				set_coords(&board[x][y].icon[0],35,1);  /* setting coords for icon */
				set_coords(&board[x][y].icon[1],52,1);
				set_coords(&board[x][y].icon[2],86,35);
				set_coords(&board[x][y].icon[3],120,18);
				break;
			case SCREW:
				set_coords(&board[x][y].icon[0],69,1);
				break;
			case BULLET:
				set_coords(&board[x][y].icon[0],86,1);
				break;
			case BOX:
				set_coords(&board[x][y].icon[0],103,1);
				break;
			case PUSH_BOX:
				set_coords(&board[x][y].icon[0],137,18);
				set_coords(&board[x][y].icon[1],137,18);	// pushed box changes state
				break;
			case KEY:
				set_coords(&board[x][y].icon[0],120,1);
				break;
			case BOMB:
				set_coords(&board[x][y].icon[0],137,1);
				break;
			case DOOR:
				set_coords(&board[x][y].icon[0],154,1);
				break;
			case QUESTIONMARK:
				set_coords(&board[x][y].icon[0],1,18);
				break;
			case CAPSULE:
				set_coords(&board[x][y].icon[0],86,18);
				set_coords(&board[x][y].icon[1],103,18);
				break;
			case LIVE:
				set_coords(&board[x][y].icon[0],1,35);
				break;
			case BEAR:
				set_coords(&board[x][y].icon[0],18,18);
				set_coords(&board[x][y].icon[1],35,18);
				break;
			case BIRD:
				set_coords(&board[x][y].icon[0],52,18);
				set_coords(&board[x][y].icon[1],69,18);
				break;
			case LITTLE_BOOM:
				set_coords(&board[x][y].icon[0],35,35);
				set_coords(&board[x][y].icon[1],18,35);
				set_coords(&board[x][y].icon[2],35,35);
				set_coords(&board[x][y].icon[3],52,35);
				break;
			case GROUND:
				set_coords(&board[x][y].icon[0],69,35);
				break;
			case BEAR_B:
				set_coords(&board[x][y].icon[0],103,35);
				set_coords(&board[x][y].icon[1],120,35);
				break;
			case BUTTERFLY:
				set_coords(&board[x][y].icon[0],137,35);
				set_coords(&board[x][y].icon[1],154,35);
				break;
			case LASER_L:
				set_coords(&board[x][y].icon[0],1,52);
				set_coords(&board[x][y].icon[1],18,52);
				break;
			case LASER_D:
				set_coords(&board[x][y].icon[0],35,52);
				set_coords(&board[x][y].icon[1],52,52);
				break;
			case TELEPORT:
				set_coords(&board[x][y].icon[0],1,69);
				set_coords(&board[x][y].icon[1],18,69);
				break;
			case BIG_BOOM:
				set_coords(&board[x][y].icon[0],35,69);
				set_coords(&board[x][y].icon[1],52,69);
				set_coords(&board[x][y].icon[2],69,69);
				set_coords(&board[x][y].icon[3],52,69);
				set_coords(&board[x][y].icon[4],35,69);
				break;
			case GUN:
				set_coords(&board[x][y].icon[0],86,69);
				set_coords(&board[x][y].icon[1],103,69);
				set_coords(&board[x][y].icon[2],120,69);
				set_coords(&board[x][y].icon[3],137,69);
				break;
			case MAGNET:
				set_coords(&board[x][y].icon[0],1,1);
				set_coords(&board[x][y].icon[1],18,1);
				set_coords(&board[x][y].icon[2],18,1);
				set_coords(&board[x][y].icon[3],1,1);
				break;
			case BLASTER:
				set_coords(&board[x][y].icon[0],35,69);
				set_coords(&board[x][y].icon[1],52,69);
				set_coords(&board[x][y].icon[2],69,69);
				set_coords(&board[x][y].icon[3],52,69);
				set_coords(&board[x][y].icon[4],35,69);
				break;
			case BARRIER:
				set_coords(&board[x][y].icon[0],156,52);
				set_coords(&board[x][y].icon[1],156,69);
				break;
		}
	}
	else if(FIELD_SIZE == 32)
	{
	
		switch(type) {	
			case EMPTY_FIELD:
				set_coords(&board[x][y].icon[0],0,0);
				break;
			case WALL:
				set_coords(&board[x][y].icon[0],70,2);  /* setting coords for icon */
				set_coords(&board[x][y].icon[1],104,2);
				set_coords(&board[x][y].icon[2],172,70);
				set_coords(&board[x][y].icon[3],240,36);
				break;
			case SCREW:
				set_coords(&board[x][y].icon[0],138,2);
				break;
			case BULLET:
				set_coords(&board[x][y].icon[0],172,2);
				break;
			case BOX:
				set_coords(&board[x][y].icon[0],206,2);
				break;
			case PUSH_BOX:
				set_coords(&board[x][y].icon[0],274,36);
				set_coords(&board[x][y].icon[1],274,36);	// pushed box changes state
				break;
			case KEY:
				set_coords(&board[x][y].icon[0],240,2);
				break;
			case BOMB:
				set_coords(&board[x][y].icon[0],274,2);
				break;
			case DOOR:
				set_coords(&board[x][y].icon[0],308,2);
				break;
			case QUESTIONMARK:
				set_coords(&board[x][y].icon[0],2,36);
				break;
			case CAPSULE:
				set_coords(&board[x][y].icon[0],172,36);
				set_coords(&board[x][y].icon[1],206,36);
				break;
			case LIVE:
				set_coords(&board[x][y].icon[0],2,70);
				break;
			case BEAR:
				set_coords(&board[x][y].icon[0],36,36);
				set_coords(&board[x][y].icon[1],70,36);
				break;
			case BIRD:
				set_coords(&board[x][y].icon[0],104,36);
				set_coords(&board[x][y].icon[1],138,36);
				break;
			case LITTLE_BOOM:
				set_coords(&board[x][y].icon[0],70,70);
				set_coords(&board[x][y].icon[1],36,70);
				set_coords(&board[x][y].icon[2],70,70);
				set_coords(&board[x][y].icon[3],104,70);
				break;
			case GROUND:
				set_coords(&board[x][y].icon[0],138,70);
				break;
				case BEAR_B:
				set_coords(&board[x][y].icon[0],206,70);
				set_coords(&board[x][y].icon[1],240,70);
				break;
			case BUTTERFLY:
				set_coords(&board[x][y].icon[0],274,70);
				set_coords(&board[x][y].icon[1],308,70);
				break;
			case LASER_L:
				set_coords(&board[x][y].icon[0],2,104);
				set_coords(&board[x][y].icon[1],36,104);
				break;
			case LASER_D:
				set_coords(&board[x][y].icon[0],70,104);
				set_coords(&board[x][y].icon[1],104,104);
				break;
			case TELEPORT:
				set_coords(&board[x][y].icon[0],2,138);
				set_coords(&board[x][y].icon[1],36,138);
				break;
			case BIG_BOOM:
				set_coords(&board[x][y].icon[0],70,138);
				set_coords(&board[x][y].icon[1],104,138);
				set_coords(&board[x][y].icon[2],138,138);
				set_coords(&board[x][y].icon[3],104,138);
				set_coords(&board[x][y].icon[4],70,138);
				break;
			case GUN:
				set_coords(&board[x][y].icon[0],172,138);
				set_coords(&board[x][y].icon[1],206,138);
				set_coords(&board[x][y].icon[2],240,138);
				set_coords(&board[x][y].icon[3],274,138);
				break;
			case MAGNET:
				set_coords(&board[x][y].icon[0],2,2);
				set_coords(&board[x][y].icon[1],36,2);
				set_coords(&board[x][y].icon[2],36,2);
				set_coords(&board[x][y].icon[3],2,2);
				break;
			case BLASTER:
				set_coords(&board[x][y].icon[0],70,138);
				set_coords(&board[x][y].icon[1],104,138);
				set_coords(&board[x][y].icon[2],138,138);
				set_coords(&board[x][y].icon[3],104,138);
				set_coords(&board[x][y].icon[4],70,138);
				break;
			case BARRIER:
				set_coords(&board[x][y].icon[0],308,104);
				set_coords(&board[x][y].icon[1],308,138);
				break;
		}
	}
	
}


/****************************************************/
/**** Returning really random object ****************/
/****************************************************/

int random_id()  /* Function returning random object id */
{
	int ids[14]={EMPTY_FIELD, PUSH_BOX, SCREW, BULLET, KEY, BOMB, QUESTIONMARK, LIVE, GROUND, BUTTERFLY, GUN, CAPSULE};
	return ids[my_rand()%12];
}
/***************************************************/
/* Random number choosing **************************/
/***************************************************/

int my_rand(void) {
	next_rand = next_rand * 103515245 + 12345;
	return (next_rand >> 7);
}

/***************************************************/
/*** Random generator init :) **********************/
/***************************************************/ 

my_srand(unsigned int seed) {
	next_rand += seed;
}
