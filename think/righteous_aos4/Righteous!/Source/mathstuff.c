/*	Righteous
	Copyright (C) 2006 Ben Hull 
	
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.
		      
	This program is distributed in the hope that it will be fun,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
			       
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int determine_digits(int num,int digit)  // determine the value of the digit
{ 

	int temp=1, digits, x;

	for(x=0;x<digit;x++) temp*=10; // assign the power of 10

	digits=num/temp;

	 return digits;

}




void valuetoscreen(SDL_Surface * screen, SDL_Surface * numbers, int value, int destx, int desty)
{

		SDL_Rect src,dest;

		int digit=-1,temp=1;
		
		do{
			digit++;
			temp*=10;
		} while(temp<=value);
		
		int tmp, digits[40];

		temp=value;
		
		
		
		
		for(tmp=digit;tmp>=0;tmp--) { // loop through the value

			int x=0,y=1;

			digits[tmp] = determine_digits(temp,tmp); // determine the value of the digit

			do { y*=10; x++; } while(x<tmp); // determine the power of 10
			
			temp-=digits[tmp]*y; // subtract from the temporary value

		}
		
		src.y = 0;
		dest.w = src.w = 20;
		dest.h = src.h = numbers->h;

		for(tmp=0;tmp<=digit;tmp++) { // display the value

			temp = digits[tmp];

			src.x = temp*20;

			dest.x = destx+(digit*15)+(tmp*-1*15); dest.y = desty;

			SDL_BlitSurface(numbers, &src, screen, &dest);
	
		}
		

}

int gridgetx(int temp)
{

	if(temp<0) temp+=32;
	
	while(temp>=16) temp-=16;
	return temp;

}


int gridtoposX(int grid)
{

	if(grid<0) {
	
		if(grid<-16) grid+=16;
		
		return (636-(grid*30));
	
	}



	while(grid>=16) grid-=16;
	
	return (156+(grid*30));
	
}

int gridtoposY(int grid)
{

	if(grid<0) {
	
		if(grid<-16) return 96;
		
		return 66;
	
	}


	grid*=0.0625;
	
	return (156+(grid*30));
	
}
