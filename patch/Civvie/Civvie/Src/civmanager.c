/* civmanager.c
	vi:ts=3 sw=3:
	
	The main program
 */

#include <stdlib.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/asl.h>
#include <libraries/asl.h>
#include <utility/tagitem.h>
#include <dos/dostags.h>

#include "proto.h"
#include "public_port.h"

/* ask user which file to restaure, and restaure it */
static void ask_and_restaure_file(void)
	{
	struct Library *AslBase = OpenLibrary("asl.library", 0);
	if (AslBase)
		{
		struct FileRequester *fr;

		fr = AllocAslRequestTags(ASL_FileRequest, 
			ASL_Hail, (ULONG)"Savegame to restore", 
			ASL_Dir, (ULONG)BASEDIR,
			TAG_DONE);
		if (fr)
			{
			if (AslRequest(fr, NULL))
				{
				BPTR dirlock, olddir;
					
					/* If we got asl.library, a file requester, and the user
					 * requested a file, we restaure it */
					 
					/* handle directory */
				dirlock = Lock(fr->rf_Dir, SHARED_LOCK);
				olddir = CurrentDir(dirlock);
					/* restaure file */
				restaure_file(fr->rf_File);
					/* don't forget to restaure dir */
				CurrentDir(olddir);
				UnLock(dirlock);
				}
			FreeAslRequest(fr);
			}
		CloseLibrary(AslBase);
		}
	}


/* gcc/ixemul needs Exec/Dos v37. Under SAS/C, we should check for >= 2.0 */

int main(int argc, char *argv[])
   {
	struct MsgPort *end_port;
	
		/* buffer for file copying operations */
		 
	setup_iobuf();

		/* create public msg port for rendez-vous with our child */
	end_port = setup_public_port(PORTNAME);
	if (!end_port)
		exit(10);

		/* simple-minded argument handling: which file to restaure */
	if (argc >= 2)
		restaure_file(argv[1]);
	else
		ask_and_restaure_file();
		/* start civilization by spawning sub task
		 * Don't need anything fancy as civ provides for its own IO	*/
	if (CreateNewProcTags(NP_Entry, (ULONG)civ_and_die, 
								 NP_Name, SUBTASK,
								 TAG_DONE))
		/* if task created ok, watch for save file changes, until subtask sends 
		 * a message to end_port */
		watcher(end_port);
		
	cleanup_subtask(end_port);
	remove_public_port(end_port);
	exit(0);
	}
