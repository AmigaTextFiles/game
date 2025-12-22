#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <pragmas/dos_pragmas.h>
#include <pragmas/exec_pragmas.h>

#include <dos.h>
#include <exec/types.h>

extern struct Library *DOSBase;

/*
 *  Simple program to output time in a number of
 *  formats to ENV variables
 */

static char Ver[] = "$VER: BuildTime [" __AMIGADATE__ "] (c) John Girvin\n";

/*
 *  Structure to define the things we will output
 */

typedef struct S_timdef
{
    char *td_fmt;	// strftime format string
    char *td_fnam;	// output filename
};

/*
 *  Actually define the output formats
 */

#define MAX_TIMELEN (100)

static struct S_timdef OutTimes[] =
	            	    {	"%a %d-%b-%y, %H:%M", "ENV:BuildTime.s",
    	            	 	"%d-%m-%y %H:%M"    , "ENV:BuildTimeS.s",
    	            	 	"%d.%m.%y"          , "ENV:BuildTimeA.s",
					  		NULL				, NULL
	            	    };

ULONG main(void)
{
	ULONG d;

    time_t ttTime;
    struct tm tmTime;

	struct S_timdef *timdef;
	BPTR  filptr;
    UBYTE filbuf[MAX_TIMELEN];
	ULONG buflen;

	__tzset();

	// Endless loop (until CTRL-C)
	while(TRUE)
	{
	    // Get current time and store
	    if (time(&ttTime) != -1)
	    {
	        CopyMem(localtime(&ttTime), &tmTime, sizeof(tmTime));
		
			// Process all time formats
			timdef = OutTimes;
			while (timdef->td_fmt != NULL)
	        {
	            if ((filptr = Open(timdef->td_fnam, MODE_NEWFILE)) != NULL)
	            {
					// Write header
					Write(filptr, "\tdc.b\t\"", 7);

					// Format and write time string
	                buflen = strftime(filbuf, MAX_TIMELEN, timdef->td_fmt, &tmTime);
					Write(filptr, filbuf, buflen);

					// Write trailer
					Write(filptr, "\"\t;Written by BuildTime\n", 24);

	                Close(filptr);
	            }
				timdef++;
	        }
	    }

		// Sleep for a minute
		for (d = 0; d < 60; d++)
		{
			Delay(50);
		}
	}
}
