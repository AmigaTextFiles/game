#include	<stdlib.h>
#include 	<stdio.h>
#include	<time.h>

#include 	<exec/semaphores.h>
#include 	<dos/dos.h>
#include 	<proto/exec.h>
#include 	<proto/dos.h>

#include 	"dynamite.h"


int
main()
{
	struct dynamitesemaphore	*dynasema;
	struct player 				*ourplayer;
	BOOL						done = FALSE,
								delay;

  LONG thisbotnum;

	/* check if dynamite is running */

	srand (time(NULL));

	Forbid();	/* try to find the semaphore */
	dynasema=(struct dynamitesemaphore *)FindSemaphore("dynAMIte.0");
	if(dynasema)
	{
		/*
		increase opencount to tell dynamite that you are using the
		semaphore. dynamite will remove semaphore only if opencnt is
		0 at its end
		*/

		dynasema->opencnt++;

    thisbotnum=dynasema->opencnt;

    /* set botinfo string */
    dynasema->botinfo[thisbotnum]=(char*)"dynamite sample bot v1.0 - doing nothing useful"

		printf("Clients using the semaphore: %ld\n",dynasema->opencnt);
	}
	Permit();

	if(dynasema)
		{
		printf("dynAMIte is started\n");

		while (!done)
  		{
			if(CheckSignal(SIGBREAKF_CTRL_C))
				{
				done=TRUE;
				}
			else
				{
				delay=TRUE;
				ObtainSemaphore(&dynasema->sema);

				if(dynasema->quit)
					{
					/* dynamite wants to quit, so we do dynamite a favour */
					printf("dynAMIte is about to quit...\n");
					done=TRUE;
					}
				else
					{
					/* if a game is running */
					if(dynasema->gamerunning>=GAME_GAME)
						{
						/* and player is no observer */
						if(dynasema->thisplayer<8)
							{
							delay=FALSE;

							ourplayer=dynasema->players[dynasema->thisplayer];

							/* and our player is alive */
							if(ourplayer->dead)
								{
								/* do your AI stuff */
								dynasema->walk= rand()%DIR_UP+1;
								}
							}
						}

  				}

				ReleaseSemaphore(&dynasema->sema);

				if(delay)
					{
					/* no game is running */
					/* do a small delay to let the cpu do other things :( */
					Delay(10);
					}

			}
		}

		ObtainSemaphore(&dynasema->sema);

    /* reset direction */
    dynasema->walk=DIR_NONE;

    /* set botinfo entry back to 0 */
    dynasema->botinfo[thisbotnum]=NULL;

		/*
		decrease opencount to tell dynamite that you no longer need
   	the semaphore.
   	dynamite will remove the semaphore only if opencnt is
   	0 at the end
		*/

		dynasema->opencnt--;
		ReleaseSemaphore(&dynasema->sema);
		}
	else
		{
		printf("dynamite is not running\n");
		}


	return EXIT_SUCCESS;
}
