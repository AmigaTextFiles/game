/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <clib/dos_protos.h>
#include <stdio.h>
#include <string.h>
#include "scores.h"
#include "keys.h"
#include "game.h"
#include "graphics.h"
#include "think.h"
#include "setup.h"

struct hs_post
{
	int score;
	char name[max_namelength];
};

struct hs_post hiscores[number_hs];

int corruptfile=0; /* If set, do not save highscores */

int savescores(void)
{
	FILE *hs_file=NULL;
	int count, cpos;
	long int checksum=0;

	if(corruptfile) return 0;

	if(!(hs_file=fopen("NeverMind.scores","wb")))
		return 0;

	for(count=0; count<number_hs; count++)
	{
		if(!(fwrite(&hiscores[count].score, sizeof(int), 1, hs_file)))
		{
			fclose(hs_file);
			return 0;
		}
		checksum+=hiscores[count].score*(count+1); // Checksum +Score*Count

		if(!(fwrite(hiscores[count].name, sizeof(char), max_namelength, hs_file)))
		{
			fclose(hs_file);
			return 0; 
		}

			for(cpos=0; cpos<max_namelength; cpos++)
				checksum+=hiscores[count].name[cpos]*(count+1); // Checksum +Characters*Count
	}

	if(!(fwrite(&checksum, sizeof(long int), 1, hs_file)))
	{
		fclose(hs_file);
		return 0;
	}


	fclose(hs_file);
	return 1;
}

int loadscores(void)
{
	FILE *hs_file=NULL;
	int count, cpos;
	long int checksum=0, readsum;

	for(count=0; count<number_hs; count++)
	{
		hiscores[count].score=0;
		strcpy(hiscores[count].name,"NEVERMIND THIS SCORE!!!!");
	}

	if(!(hs_file=fopen("NeverMind.scores","rb")))
		return 0;

	for(count=0; count<number_hs; count++)
	{
		if(!(fread(&hiscores[count].score, sizeof(int), 1, hs_file)))
		{
			fclose(hs_file);
			return 0;
		}
		
		checksum+=hiscores[count].score*(count+1);
			
		if(!(fread(hiscores[count].name, sizeof(char), max_namelength, hs_file)))
		{
			fclose(hs_file);
			return 0;
		}

			for(cpos=0; cpos<max_namelength; cpos++)
				checksum+=hiscores[count].name[cpos]*(count+1);
	}

	if(!(fread(&readsum, sizeof(long int), 1, hs_file)))
	{
		fclose(hs_file);
		return 0;
	}

//	printf("readsum: %d, checksum: %d\n",readsum, checksum);
	if(!(readsum==checksum))
	{
		fclose(hs_file);
		corruptfile=1;
		shutdown("Highscore-file corrupted!\nAre you trying to cheat?\nDelete NeverMind.scores\nand restart NeverMind!");
	}

	fclose(hs_file);
	return 1;
}

void displayscores(void)
{
	int count, scorecopy, exponent, row=0;
	char scoretext[max_namelength+15], ascii_score[2]="0";

	pressedkey=0;

	textxy("----------------------------------------\n",0,130,9);
	textxy("----------------------------------------\n",0,230,9);

	if(mines_per_row==2)
		textxy("Beginner HighScores    \n",80,150,15);
	if(mines_per_row==3)
		textxy("Novice HighScores      \n",85,150,10);
	if(mines_per_row==4)
		textxy("Professional HighScores\n",70,150,12);
	if(mines_per_row==5)
		textxy("HBe-Expert HighScores  \n",80,150,13);

	for(count=5*(mines_per_row-2); count<(5*(mines_per_row-2)+5); count++)
	{
		strncpy(scoretext,hiscores[count].name, max_namelength);
		strcat(scoretext, "     ");		

		scorecopy=hiscores[count].score;
		for(exponent=1000;exponent>0;exponent/=10)
		{
	  		ascii_score[0]=(char)('0'+scorecopy/exponent);
			strcat(scoretext, ascii_score);
			scorecopy=scorecopy%exponent;
		}
		scoretext[max_namelength+8]='\n';
		scoretext[max_namelength+9]='\0';
		if(row<4)
			textxy(scoretext,30,170+(row*10),8-row);
		else
			textxy(scoretext,30,170+(row*10),1);
		row++;
	}

	while( !((pressedkey==space) || checkabort()) )
	{
		getkeypress();
	}
}

int checkhighscore(int score)
{
	int count, position=20, letterpos;	
	char letter[]="_\n";

	for(count=5*(mines_per_row-2)+4; count>=(5*(mines_per_row-2)); count--)
	{
		if(score>=hiscores[count].score) position=count;
	}
	if(position<20)
	{
		for(count=5*(mines_per_row-2)+3; count>=position; count--)
		{
			for(letterpos=0; letterpos<max_namelength; letterpos++)
				hiscores[count+1].name[letterpos]=hiscores[count].name[letterpos];		
			hiscores[count+1].score=hiscores[count].score;
		}
		
		letterpos=0;
		setpalette(menupal);
		menutitle();

		textxy("You've gotta highscore, gimme ya name:\n",5,135,12);
		textxy(letter, 20+8*letterpos, 150, 7);

		while(!(pressedkey==enter))
		{
			if((letter[0]=highscorekeypress()) !='0')
			{
				if(letter[0]=='-')
				{
					if(letterpos>0)
					{
						hiscores[position].name[letterpos-1]=' ';				
						letterpos--;
						if(letterpos<0) letterpos=0;
						letter[0]=hiscores[position].name[letterpos];
						textxy(letter, 20+8*letterpos, 150, 7);
						textxy("_  \n",20+8*letterpos, 150,7);
					}
				}
				else
				{
					if(letterpos>23) letterpos=23; 
					hiscores[position].name[letterpos]=letter[0];
					textxy(letter, 20+8*letterpos, 150, 7);
					textxy("_\n", 20+8*(letterpos+1), 150, 7);
					letterpos++;
				}	
			}
		}

		while(letterpos<24)
		{
			hiscores[position].name[letterpos]=' ';
			letterpos++;
		}

		hiscores[position].score=score;	/* Insert the score in the right position */

		cleararea(0,121, 320, 125);			
		displayscores();
		wipescreen(0);
		return(1); /* Highscore, then exit to main menu */
	}

	return(0); /* No highscore */
}

int finalscore(int score)
{
	int bonus=0, add, x, y;
	
	for(y=0;y<pf_ysize;y++)
	{
		for(x=0;x<pf_xsize;x++)
		{
			if(miscfield[x][y]==markedmine)
			{		
				if(playfield[x][y]==mine) bonus+=5;
				else bonus-=5;
			}
		}
	}

	for(bonus+=mines_per_row*200; bonus!=0; score+=add, bonus-=add)
	{
		add=0;
		if(!add && ((bonus%10)>0)) add=1;
		if(!add && ((bonus%10)<0)) add=-1;
 		if(!add && ((bonus%100)>0)) add=10;
 		if(!add && ((bonus%100)<0)) add=-10;
		if(!add && ((bonus%1000)>0)) add=100;
		if(!add && ((bonus%1000)<0)) add=-100;
		if(!add && ((bonus%10000)>0)) add=1000;
		if(!add && ((bonus%10000)<0)) add=-1000;
		gamebar(checkmines(), score);
		Delay(10);
	}

	gamebar(checkmines(), score);
	Delay(50);
	return(score);
}

