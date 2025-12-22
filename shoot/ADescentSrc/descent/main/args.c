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
 * $Source: /usr/CVS/descent/main/args.c,v $
 * $Revision: 1.6 $
 * $Author: nobody $
 * $Date: 1998/11/09 22:20:31 $
 * 
 * Functions for accessing arguments.
 * 
 * $Log: args.c,v $
 * Revision 1.6  1998/11/09 22:20:31  nobody
 * *** empty log message ***
 *
 * Revision 1.5  1998/04/01 21:18:31  tfrieden
 * Removed printing of program name from active switches
 *
 * Revision 1.4  1998/03/31 14:31:02  tfrieden
 * Fixed bug with first argument
 *
 * Revision 1.3  1998/03/27 00:58:45  tfrieden
 * NewIcon IM1/IM2 Tooltypes are ignored now
 *
 * Revision 1.2  1998/03/23 20:00:34  hfrieden
 * Added workbench tooltypes support
 *
 * Revision 1.1.1.1  1998/03/03 15:12:11  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:38  hfrieden
 * Initial Import
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: args.c,v 1.6 1998/11/09 22:20:31 nobody Exp $";
#pragma on (unreferenced)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <workbench/workbench.h>
#include <workbench/startup.h>
#include <workbench/icon.h>
#include <proto/exec.h>
#include <proto/icon.h>

int Num_args=0;
char * Args[100];
char *progname = "ADescent";

extern void ShowInfoWindow(void);
extern char *InfoTxt;
extern struct DiskObject *IconFromWBArg(struct WBArg *);

struct Library *IconBase;


int FindArg( char * s )
{
	int i;

	for (i=0; i<Num_args; i++ ) {
		if (! stricmp( Args[i], s))
			return i;
	}

	return 0;
}

void SplitArg(char *src, char *dest1, char *dest2)
{
	char *dest = dest1;
	*dest1=0; *dest2=0;
	while (*src) {
		if (*src == '=') {
			src++;
			*dest=0;
			dest=dest2;
		}
		*dest++ = *src++;
	}
	*dest=0;
}


void InitArgs( int argc,char **argv )
{
	int i;
	struct DiskObject *dob;
	struct WBStartup *wbs;
	char **toolarray, *tool;
	int j;
	char opt[50], arg[50];
	int noicon = 0;

	Num_args=0;

	if (argc == 0) {
		ShowInfoWindow();
	}
	else printf("%s\n", InfoTxt);

	if (argc >0) {
		for (i=0; i<argc; i++ ) {
			Args[Num_args++] = strdup( argv[i] );
		}
	}

	if (argc >= 2) {
		noicon = (stricmp(argv[1], "-noicon") == 0);
	}

	if (!noicon) {
		Args[Num_args++] = progname;
		IconBase = OpenLibrary("icon.library", 0L);
		if (IconBase) {
			if (argc != 0) dob = GetDiskObjectNew(argv[0]);
			else {
				wbs = (struct WBStartup *)argv;
				dob = IconFromWBArg(wbs->sm_ArgList);
			}
			if (dob) {
				toolarray = (char **)dob->do_ToolTypes;
				j=0; tool = toolarray[j];
				while (tool) {
					if (*tool != '*' && *tool != '(' && *tool != '<' &&
					  strnicmp(tool, "IM1", 3) != 0 && strnicmp(tool, "IM2", 3) != 0) {
						SplitArg(tool, opt, arg);
						Args[Num_args] = malloc(strlen(opt)+3);
						strcpy(Args[Num_args], "-");
						strcat(Args[Num_args], opt);
						Num_args++;
						if (*arg!='\0') {
							Args[Num_args++] = strdup(arg);
						}
					}
					j++;
					tool=toolarray[j];
				}
			}
			FreeDiskObject(dob);
			CloseLibrary(IconBase);
		}
	} else printf("Ignoring icon settings\n");

	for (i=0; i< Num_args; i++ )    {
		if ( Args[i][0] == '/' )  
			Args[i][0] = '-';

		if ( Args[i][0] == '-' )
			strlwr( Args[i]  );     // Convert all args to lowercase

		//printf( "Args[%d] = '%s'\n", i, Args[i] );
	}

	printf("Options in effect:\n");
	for (i=1; i<Num_args; i++) {
		if (stricmp(Args[i],argv[0]) != 0 && stricmp(Args[i], "ADescent") != 0)
			printf("%s ", Args[i]);
	}
	printf("\n");
}
