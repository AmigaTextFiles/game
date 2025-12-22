/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/main/text.c,v $
 * $Revision: 1.3 $
 * $Author: tfrieden $
 * $Date: 1998/03/30 12:37:27 $
 * 
 * Code for localizable text
 * 
 * $Log: text.c,v $
 * Revision 1.3  1998/03/30 12:37:27  tfrieden
 * Now prints about upgrading the HOG file
 *
 * Revision 1.2  1998/03/13 23:52:36  tfrieden
 * various changes with sound, joystick, shareware, notwork
 *
 * Revision 1.1.1.1  1998/03/03 15:12:31  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:21:04  hfrieden
 * Initial Import
 */


#pragma off (unreferenced)
static char rcsid[] = "$Id: text.c,v 1.3 1998/03/30 12:37:27 tfrieden Exp $";
#pragma on (unreferenced)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//#include "cfile.h"
#include "cfile.h"
#include "mem.h"
#include "error.h"

#include "inferno.h"
#include "text.h"
#include "args.h"
#include "compbit.h"

char *text;

extern int UseShareware;

char *Text_string[N_TEXT_STRINGS];

free_text()
{
	free(text);
}

// rotates a byte left one bit, preserving the bit falling off the right
void
encode_rotate_left(char *c)
{
	int found;

	found = 0;
	if (*c & 0x80)
		found = 1;
	*c = *c << 1;
	if (found)
		*c |= 0x01;
}

//load all the text strings for Descent
void load_text()
{
	CFILE  *tfile;
	CFILE *ifile;
	int len,i, have_binary = 0;
	char *tptr;
	char *filename="descent.tex";
	int num = N_TEXT_STRINGS;

	if ((i=FindArg("-text"))!=0)
		filename = Args[i+1];

	if ((tfile = cfopen(filename,"rb")) == NULL) {
		filename="descent.txb";
		if ((ifile = cfopen(filename, "rb")) == NULL)
			Error("Cannot open file DESCENT.TEX or DESCENT.TXB");
		have_binary = 1;

		len = cfilelength(ifile);

		//MALLOC(text,char,len);//Won't compile... working on it..-KRB
		text=malloc(len*sizeof(char));//my hack -KRB
		atexit(free_text);

		cfread(text,1,len,ifile);

		cfclose(ifile);

	} else {
		int c;
		char * p;

		len = cfilelength(tfile);

		//MALLOC(text,char,len);//Won't compile... working on it..-KRB
		text=malloc(len*sizeof(char));//my hack -KRB

		atexit(free_text);

		//fread(text,1,len,tfile);
		p = text;
		do {
			c = cfgetc( tfile );
			if ( c != 13 )
				*p++ = c;
		} while (c!=EOF);

		cfclose(tfile);
	}

	for (i=0,tptr=text;i<num;i++) {
		char *p;

		Text_string[i] = tptr;

		tptr = strchr(tptr,'\n');
		
		if (!tptr)
			Error("Not enough strings in text file - expecting %d, found %d.\n"
				  "Upgrade your HOG file to 1.5",num,i);

		if ( tptr ) *tptr++ = 0;

		if (have_binary) {
			for (p=Text_string[i]; p < tptr - 1; p++) {
				encode_rotate_left(p);
				*p = *p ^ BITMAP_TBL_XOR;
				encode_rotate_left(p);
			}
		}
		
		//scan for special chars (like \n)
		for (p=Text_string[i];p=strchr(p,'\\');) {
			char newchar;

			if (p[1] == 'n') newchar = '\n';
			else if (p[1] == 't') newchar = '\t';
			else if (p[1] == '\\') newchar = '\\';
			else
				Error("Unsupported key sequence <\\%c> on line %d of file <%s>",p[1],i+1,filename); 

			p[0] = newchar;
			strcpy(p+1,p+2);
			p++;
		}

	}
	
//  Assert(tptr==text+len || tptr==text+len-2);
	
}


