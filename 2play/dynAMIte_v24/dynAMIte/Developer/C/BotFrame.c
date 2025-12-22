#include	<stdlib.h>
#include 	<stdio.h>
#include	<time.h>

#include 	<exec/semaphores.h>
#include 	<dos/dos.h>
#include 	<proto/exec.h>
#include 	<proto/dos.h>

#include 	"dynamite.h"


BOOL		checkDynamite (struct dynamitesemaphore ** );
void		mainLoop (struct dynamitesemaphore *);
void		doAI (struct dynamitesemaphore *);

LONG thisbotnum

int
main (void)
{
	struct dynamitesemaphore	*dynasema;


	srand (time(NULL));

	if ( FALSE == checkDynamite (&dynasema) )
	{
		puts ("*** DynAMIte not running!");
		return EXIT_FAILURE;
	}

	/* some information */
	printf ("Number of clients: %Ld\n",dynasema->opencnt);

	/* enter main loop */
	mainLoop (dynasema);

	/* decrease opencount to tell dynamite that you no
	longer need the semaphore. dynamite will remove the
	semaphore only if opencnt is 0 at the end */
	ObtainSemaphore(&dynasema->sema);

  /* reset direction */
  dynasema->walk=DIR_NONE;

  /* set botinfo entry back to 0 */
  dynasema->botinfo[thisbotnum]=NULL;

	dynasema->opencnt--;
	ReleaseSemaphore(&dynasema->sema);

	return EXIT_SUCCESS;
}

BOOL
checkDynamite (struct dynamitesemaphore ** dynasema )
{
	Forbid();	/* try to find the semaphore */
	if (*dynasema = (struct dynamitesemaphore *)FindSemaphore ("dynAMIte.0")
		{
		/* increase opencount to tell dynamite that you are using the
		semaphore. dynamite will remove semaphore only if opencnt is
		0 at its end */

		++ dynasema->opencnt;

    thisbotnum = dynasema->opencnt;

    /* set botinfo string */
    dynasema->botinfo[dynasema->opencnt]=(char*)"dynamite sample bot v1.0 - doing nothing useful"

		}
	Permit();

	if ( NULL == *dynasema )
		return FALSE;

	return TRUE;
}

void
mainLoop (struct dynamitesemaphore * dynasema)
{
	struct player 				*ourplayer;
	BOOL						done = FALSE,
								delay;

	while (FALSE == done)
	{
		if (CheckSignal (SIGBREAKF_CTRL_C))
			done = TRUE;
		else
		{
			delay = TRUE;
			ObtainSemaphore (&dynasema->sema);

			if (dynasema->quit)
			{
				/* dynamite wants to quit, so we do dynamite a favour */
				printf ("dynAMIte is about to quit...\n");
				done = TRUE;
			}
			else
			{
				/* if a game is running */
				if (dynasema->gamerunning>=GAME_GAME)
				{
					/* and player is no observer */
					if (dynasema->thisplayer < 8)
					{
						delay = FALSE;

						ourplayer = dynasema->players[dynasema->thisplayer];

						/* and our player is alive */
						if (ourplayer->dead)
							doAI (dynasema);
					}
				}
			}

			ReleaseSemaphore (&dynasema->sema);

			if (delay)
			{
				/* no game is running */
				/* do a small delay to let the cpu do other things :( */
				Delay (10);
			}

		}
	}
}

void
doAI (struct dynamitesemaphore * dynasema)
{
	dynasema->walk = rand() % DIR_UP+1;
}

