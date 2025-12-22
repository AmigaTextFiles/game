#ifdef MUSIC /* If you don't want music playing, change makefile a bit */

#include <stdio.h>

#include <exec/types.h>
#include <exec/lists.h>
#include <exec/nodes.h>
#include <dos/dos.h>
#include <proto/exec.h>

/* ReAction includes */
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

//#include <inline/medplayer_protos.h>
//#include <inline/octaplayer_protos.h>
//#include <inline/octamix_protos.h>

#include "proplayer.h"
#include "med.h"

#define MUSICFILES 20

extern struct Library *MEDPlayerBase, *OctaPlayerBase, *OctaMixPlayerBase;
extern struct MMD0 *sng;
extern struct List songList;

extern struct Library *ChooserBase;

extern ULONG initialFreq;

UBYTE files[20][31];

LONG playRoutine;


/* Build the list for songs found in path... */
void buildListOfSongs( STRPTR dir ) {
  
	struct FileLock *lock;
	struct FileInfoBlock fib;

	struct Node *node;

	WORD index = 0;

	/* Try to lock the dir: */
	lock = (struct FileLock *) Lock( dir, SHARED_LOCK );

	/* Success ? */
	if( lock == NULL )
	{
		printf("Could not lock the directory!\n");
		return;
	}

	/* Try to examine the directory/device/(file): */
	if( Examine( lock, &fib ) )
	{
		/* Check if it is a directory/device: */
		if( fib.fib_DirEntryType > 0 )
		{

			while( ExNext( lock, &fib ) )
			{
				if( fib.fib_DirEntryType < 0 ) {
				
					strncpy( files[index], fib.fib_FileName, 30 );
					files[index][31] = '\0';
					//printf( "<%s> -> list...\n", files[index] );

					/* Allocate memory for List item */
					node = AllocChooserNode( CNA_Text, files[index], TAG_DONE );

					index++;

					/* Adding it to the list */
                    if (node) {
						AddTail( &songList, node );
				    }

					/* Can't take no more */
					if (index == MUSICFILES)
						break;

				}


			}

		}

	} else
		printf("Directory Error: %s!\n", dir );

	/* Unlock the dir: */
	UnLock( lock );

}


/* Empty the list of songs */
void destroyList() {

	struct Node *node = songList.lh_Head;
	struct Node *nextNode;

	while( nextNode = node->ln_Succ ) {
	
		FreeChooserNode( node );
        node = nextNode;

    }

	NewList(&songList);
	//printf("List empty\n");

}


/* Play med file, Teijo's example code was used as skeleton */
BOOL playMusic( STRPTR file )
{
    STRPTR dir = "music/";
	UBYTE path[ 6+30+1 ]; /* dir+file+'\0' */
	BOOL error = FALSE;
    ULONG size = 32;


// path = strcat( dir, file );
//    if ( AddPart( dir, file, size ) ) {
      sprintf( path, "%s%s", (STRPTR)dir, (STRPTR)file );
//		  printf("<%s> : OK\n", path);
//    } else {
//    	  printf("Path Error\n");
//        return TRUE;
//    }

	/* Assume 4-ch mode (medplayer.library)
	   We use V7 to obtain RequiredPlayRoutine */

	if (!MEDPlayerBase) {
		printf("Can't open medplayer.library!\n");
		return TRUE;
	}

	printf("Loading '%s'...\n", (STRPTR)path);
	sng = (struct MMD0 *)LoadModule( path );

	if (!sng) {
		printf("Load error (DOS error #%d).\n", (WORD)IoErr());
		error = TRUE;
	}

	if (!error) {
		/* Test which play routine is required... */
		playRoutine = RequiredPlayRoutine(sng);

		switch(playRoutine) {

		case 0: // medplayer.library...
			break;

		case 1:	// octaplayer.library...
			if(!OctaPlayerBase) {
				printf("Can't open octaplayer.library v7!\n");
				error = TRUE;
			}
			break;

		case 2: // octamixplayer.library
			if(!OctaMixPlayerBase) {
				printf("Can't open octamixplayer.library v7!\n");
				error = TRUE;
			}
			break;

		default:
			printf("Requires an unknown playing routine!\n");
			error = TRUE;
			break;

		} /* switch-case */

		if ( !error ) {

			// Then allocate the player and play...
			switch(playRoutine) {
			
			case 0:	// 4-channel
				{
					long count,midi = 0;
				
					/* Check if it's a MIDI song. We check the MIDI channel of
					each instrument. */
					for(count = 0; count < 63; count++) {
						if(sng->song->sample[count].midich) {
							midi = 1;
						}
					}

					if(GetPlayer(midi)) {
						printf("Resource allocation failed.\n");
						error = TRUE;
					}

					if ( !error )
						PlayModule(sng);
				}
				break;

			case 1: // 5-8-channel
				if(GetPlayer8()) {
					printf("Resource allocation failed.\n");
					error = TRUE;
				}
				
				if ( !error )
					PlayModule8(sng);
				
				break;

			case 2: // mixing
				if(GetPlayerM()) {
					printf("Resource allocation failed.\n");
					error = TRUE;
				}

				if (!error) {
					SetMixingFrequency( initialFreq * 100 );
					PlayModuleM(sng);
				}
				break;
			}

		} // if

	} // if

	if ( error ) {
		closePlayer( sng );
    	return TRUE;
    } else
    	return FALSE;

}


/* Pick up the real name for a selected song */
BOOL playSong( WORD selection ) {

	struct Node *node;
    LONG songName;
	WORD index = 0;
	BOOL error, unload = FALSE;

	if ( sng != NULL ) {
		closePlayer(sng);
		sng = NULL;
    }

	node = songList.lh_Head;

	while ( node->ln_Succ ) {

		if ( selection == index )
        	break;

		node = node->ln_Succ;

		index++;
    }

  	GetChooserNodeAttrs( node, CNA_Text, &songName, TAG_DONE );

	error = playMusic( (STRPTR)songName );

	return error; /* return possible error code */
}


/* Free the resources etc */
void closePlayer( struct MMD0 *sng ) {

	BOOL unload = FALSE;

	//printf("Shutting down the player...\n");

	if ( (playRoutine < 3) && (playRoutine >= 0) ) {
		stopAudio();
		freeAudio();

		playRoutine = 999;

	    if (MEDPlayerBase) {
			if ( sng != NULL ) {
				UnLoadModule(sng);
				unload = TRUE;
				sng = NULL;
			}
	    }
		
	    if (OctaPlayerBase) {
			if ( sng != NULL ) {
				if (!unload) {
					UnLoadModule8(sng);
					unload = TRUE;
					sng = NULL;
				}
			}
		}

		if (OctaMixPlayerBase) {
			if ( sng != NULL ) {
				if (!unload) {
					UnLoadModuleM(sng);
					sng = NULL;
				}
			}

		}

	}
}


/* Stop the music */
void stopAudio() {

	switch ( playRoutine ) {
	case 0:
		StopPlayer();
		break;

	case 1:
		StopPlayer8();
		break;

	case 2:
		StopPlayerM();
		break;
	}

}


/* Free resources */
void freeAudio() {

	switch ( playRoutine ) {

	case 0:
		FreePlayer();
		break;

	case 1:
		FreePlayer8();
		break;

	case 2:
		FreePlayerM();
		break;
	}

}

#endif
