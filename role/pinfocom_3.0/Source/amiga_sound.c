/* amiga_sound.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/amiga_sound.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* SoundInit():
	 *
	 *	Allocate resources for sound routine.
	 */

Bool
SoundInit()
{
		/* Create io reply port. */

	if(SoundPort = CreatePort(NULL,0))
	{
			/* Create io control request. We will use it
			 * later to change the volume of a sound.
			 */

		if(SoundControlRequest = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
		{
				/* Create io request for left channel. */

			if(SoundRequestLeft = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
			{
					/* Create io request for right channel. */

				if(SoundRequestRight = (struct IOAudio *)CreateExtIO(SoundPort,sizeof(struct IOAudio)))
				{
						/* Channel allocation map,
						 * we want any two stereo
						 * channels.
						 */

					STATIC UBYTE AllocationMap[] =
					{
						LEFT0F | RIGHT0F,
						LEFT0F | RIGHT1F,
						LEFT1F | RIGHT0F,
						LEFT1F | RIGHT1F
					};

						/* Set it up for channel allocation,
						 * any two stereo channels will do.
						 */

					SoundControlRequest -> ioa_Request . io_Message . mn_Node . ln_Pri	= 127;
					SoundControlRequest -> ioa_Request . io_Command				= ADCMD_ALLOCATE;
					SoundControlRequest -> ioa_Request . io_Flags				= ADIOF_NOWAIT | ADIOF_PERVOL;
					SoundControlRequest -> ioa_Data						= AllocationMap;
					SoundControlRequest -> ioa_Length					= sizeof(AllocationMap);

						/* Open the device, allocating the channel on the way. */

					if(!OpenDevice(AUDIONAME,NULL,(struct IORequest *)SoundControlRequest,NULL))
					{
							/* Copy the initial data to the
							 * other audio io requests.
							 */

						CopyMem((BYTE *)SoundControlRequest,(BYTE *)SoundRequestLeft, sizeof(struct IOAudio));
						CopyMem((BYTE *)SoundControlRequest,(BYTE *)SoundRequestRight,sizeof(struct IOAudio));

							/* Separate the channels. */

						SoundRequestLeft  -> ioa_Request . io_Unit = (struct Unit *)((ULONG)SoundRequestLeft  -> ioa_Request . io_Unit & (LEFT0F  | LEFT1F));
						SoundRequestRight -> ioa_Request . io_Unit = (struct Unit *)((ULONG)SoundRequestRight -> ioa_Request . io_Unit & (RIGHT0F | RIGHT1F));

							/* Return success. */

						return(TRUE);
					}
				}
			}
		}
	}

		/* Clean up... */

	SoundExit();

		/* ...and return failure. */

	return(FALSE);
}

	/* SoundExit():
	 *
	 *	Free resources allocated by SoundInit().
	 */

VOID
SoundExit()
{
		/* Free the left channel data. */

	if(SoundRequestLeft)
	{
			/* Did we open the device? */

		if(SoundRequestLeft -> ioa_Request . io_Device)
		{
				/* Check if the sound is still playing. */

			if(!CheckIO((struct IORequest *)SoundRequestLeft))
			{
					/* Abort the request. */

				AbortIO((struct IORequest *)SoundRequestLeft);

					/* Wait for it to return. */

				WaitIO((struct IORequest *)SoundRequestLeft);
			}
			else
				GetMsg(SoundPort);
		}

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundRequestLeft);

			/* Leave no traces. */

		SoundRequestLeft = NULL;
	}

		/* Free the right channel data. */

	if(SoundRequestRight)
	{
			/* Did we open the device? */

		if(SoundRequestRight -> ioa_Request . io_Device)
		{
				/* Check if the sound is still playing. */

			if(!CheckIO((struct IORequest *)SoundRequestRight))
			{
					/* Abort the request. */

				AbortIO((struct IORequest *)SoundRequestRight);

					/* Wait for it to return. */

				WaitIO((struct IORequest *)SoundRequestRight);
			}
			else
				GetMsg(SoundPort);
		}

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundRequestRight);

			/* Leave no traces. */

		SoundRequestRight = NULL;
	}

		/* Free sound control request. */

	if(SoundControlRequest)
	{
			/* Close the device, free any allocated channels. */

		if(SoundControlRequest -> ioa_Request . io_Device)
			CloseDevice((struct IORequest *)SoundControlRequest);

			/* Free the memory allocated. */

		DeleteExtIO((struct IORequest *)SoundControlRequest);

			/* Leave no traces. */

		SoundControlRequest = NULL;
	}

		/* Free sound io reply port. */

	if(SoundPort)
	{
			/* Delete it. */

		DeletePort(SoundPort);

			/* Leave no traces. */

		SoundPort = NULL;
	}

		/* Free previously allocated sound data. */

	if(SoundData && SoundLength)
	{
			/* Free it. */

		FreeMem(SoundData,SoundLength);

			/* Leave no traces. */

		SoundData	= NULL;
		SoundLength	= 0;
	}

		/* Clear current sound number. */

	SoundNumber = -1;
}

	/* SoundAbort():
	 *
	 *	Abort any currently playing sound and wait for
	 *	both IORequests to return.
	 */

VOID
SoundAbort()
{
		/* Abort sound playing on the left channel. */

	if(!CheckIO((struct IORequest *)SoundRequestLeft))
		AbortIO((struct IORequest *)SoundRequestLeft);

		/* Abort sound playing on the right channel. */

	if(!CheckIO((struct IORequest *)SoundRequestRight))
		AbortIO((struct IORequest *)SoundRequestRight);

		/* Wait for the request to return. */

	WaitIO((struct IORequest *)SoundRequestLeft);

		/* Wait for the request to return. */

	WaitIO((struct IORequest *)SoundRequestRight);
}

	/* SoundStop():
	 *
	 *	Stop sound from getting played (somewhat equivalent to ^S).
	 */

VOID
SoundStop()
{
		/* Fill in the command. */

	SoundControlRequest -> ioa_Request . io_Command = CMD_STOP;

		/* Send it off. */

	SendIO((struct IORequest *)SoundControlRequest);
	WaitIO((struct IORequest *)SoundControlRequest);
}

	/* SoundStart():
	 *
	 *	Restart any queued sound (somewhat equivalent to ^Q).
	 */

VOID
SoundStart()
{
		/* Fill in the command. */

	SoundControlRequest -> ioa_Request . io_Command = CMD_START;

		/* Send it off. */

	SendIO((struct IORequest *)SoundControlRequest);
	WaitIO((struct IORequest *)SoundControlRequest);
}
