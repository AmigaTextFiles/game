/* amiga_clip.c
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
 * $Header: RCS/amiga_clip.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H
#include "amiga_global.h"
#endif	/* !_AMIGA_GLOBAL_H */

	/* ClipClose():
	 *
	 *	Close clipboard handle, stop reading.
	 */

VOID
ClipClose()
{
		/* Did we allocate a clipboard handle? */

	if(ClipHandle)
	{
			/* Close the handle. */

		CloseIFF(ClipHandle);

			/* Close the stream. */

		if(ClipHandle -> iff_Stream)
			CloseClipboard((struct ClipboardHandle *)ClipHandle -> iff_Stream);

			/* Free the handle. */

		FreeIFF(ClipHandle);

			/* Leave no traces. */

		ClipHandle = NULL;
	}

		/* Did we allocate a clipboard buffer? */

	if(ClipBuffer)
	{
			/* Release the buffer. */

		FreeVec(ClipBuffer);

			/* Leave no traces. */

		ClipBuffer = NULL;
	}

		/* Reset input source. */

	ClipInput = FALSE;
}

	/* ClipSave(const STRPTR Buffer,const LONG Len):
	 *
	 *	Save text to the clipboard.
	 */

VOID
ClipSave(const STRPTR Buffer,const LONG Len)
{
		/* Is iffparse.library available? */

	if(IFFParseBase)
	{
		struct IFFHandle *ClipHandle;

			/* Allocate iff handle. */

		if(ClipHandle = AllocIFF())
		{
				/* Open the primary clipboard buffer for reading. */

			if(ClipHandle -> iff_Stream = (ULONG)OpenClipboard(PRIMARY_CLIP))
			{
					/* Make it known as a clipboard handle. */

				InitIFFasClip(ClipHandle);

					/* Open the handle for reading. */

				if(!OpenIFF(ClipHandle,IFFF_WRITE))
				{
						/* Push parent chunk on the stack. */

					if(!PushChunk(ClipHandle,ID_FTXT,ID_FORM,IFFSIZE_UNKNOWN))
					{
							/* Push data chunk on the stack. */

						if(!PushChunk(ClipHandle,0,ID_CHRS,Len))
						{
								/* Write the data. */

							WriteChunkBytes(ClipHandle,Buffer,Len);

								/* Pop the data chunk. */

							PopChunk(ClipHandle);
						}

							/* Pop the parent chunk. */

						PopChunk(ClipHandle);
					}

						/* Release the write handle. */

					CloseIFF(ClipHandle);
				}

					/* Close the clipboard stream. */

				CloseClipboard((struct ClipboardHandle *)ClipHandle -> iff_Stream);
			}

				/* Free the write handle. */

			FreeIFF(ClipHandle);
		}
	}
}

	/* ClipRead(STRPTR Buffer,LONG Len):
	 *
	 *	Read text data from clipboard and put it into the supplied buffer.
	 */

LONG
ClipRead(STRPTR Buffer,const LONG Len)
{
	LONG BytesRead = 0;

		/* Is the read buffer already exhausted? */

	if(!ClipLength)
	{
			/* Is there still any data to read? */

		if(ClipSize)
		{
			LONG Size = MIN(ClipSize,CLIP_LENGTH);

				/* Try to read the data and return failure if necessary. */

			if(ReadChunkRecords(ClipHandle,ClipBuffer,Size,1) < 1)
				return(-1);
			else
			{
				ClipSize	-= Size;
				ClipLength	 = Size;
				ClipIndex	 = ClipBuffer;
			}
		}
		else
		{
				/* We just parsed a single chunk, now go on and
				 * look for another one.
				 */

			if(!ParseIFF(ClipHandle,IFFPARSE_SCAN))
			{
				struct ContextNode *ContextNode;

					/* Obtain the current chunk info. */

				if(ContextNode = CurrentChunk(ClipHandle))
				{
						/* Did we find a text chunk? */

					if(ContextNode -> cn_Type == ID_FTXT)
					{
						LONG Size;

							/* Determine number of bytes to read. */

						ClipSize	= ContextNode -> cn_Size;
						Size		= MIN(ClipSize,CLIP_LENGTH);

							/* Read the data. */

						if(ReadChunkRecords(ClipHandle,ClipBuffer,Size,1) < 1)
							return(-1);
						else
						{
								/* Set up the data. */

							ClipSize	-= Size;
							ClipLength	 = Size;
							ClipIndex	 = ClipBuffer;
						}
					}
					else
						return(-1);
				}
				else
					return(-1);
			}
			else
				return(-1);
		}
	}

		/* The following loop processes the contents of
		 * the clipboard buffer read. Line feeds will be
		 * converted into carriage returns and non-printable
		 * characters will be filtered out.
		 */

	while(ClipLength && BytesRead < Len)
	{
		switch(*ClipIndex)
		{
				/* Convert line feed,
				 * use carriage return
				 * verbatim, drop out
				 * immediately.
				 */

			case '\r':
			case '\n':	*Buffer = '\r';

					BytesRead++;

						/* Return number of bytes read. */

					return(BytesRead);

				/* Process the rest, discard
				 * non-printable characters.
				 */

			default:	if(*ClipIndex >= ' ' && *ClipIndex <= '~')
					{
						*Buffer++ = *ClipIndex;

						BytesRead++;
					}

					break;
		}

			/* Skip to the next byte. */

		ClipIndex++;
		ClipLength--;
	}

		/* Return number of bytes read. */

	return(BytesRead);
}

	/* ClipOpen():
	 *
	 *	Open the clipboard for sequential reading.
	 */

Bool
ClipOpen()
{
		/* Close any open handle. */

	ClipClose();

		/* Allocate new buffer. */

	if(ClipBuffer = (STRPTR)AllocVec(CLIP_LENGTH,MEMF_ANY))
	{
			/* Allocate iff handle. */

		if(ClipHandle = AllocIFF())
		{
				/* Open the primary clipboard buffer for reading. */

			if(ClipHandle -> iff_Stream = (ULONG)OpenClipboard(PRIMARY_CLIP))
			{
					/* Make it known as a clipboard handle. */

				InitIFFasClip(ClipHandle);

					/* Open the handle for reading. */

				if(!OpenIFF(ClipHandle,IFFF_READ))
				{
						/* Stop within FTXT chunks at
						 * the boundaries of CHRS data.
						 */

					if(!StopChunk(ClipHandle,ID_FTXT,ID_CHRS))
					{
							/* Parse the stream, looking
							 * for a chunk...
							 */

						if(!ParseIFF(ClipHandle,IFFPARSE_SCAN))
						{
							struct ContextNode *ContextNode;

								/* Obtain current chunk information. */

							ContextNode = CurrentChunk(ClipHandle);

								/* Did we find what we were looking for? */

							if(ContextNode -> cn_Type == ID_FTXT)
							{
									/* Set up the data. */

								ClipSize	= ContextNode -> cn_Size;
								ClipLength	= 0;

									/* Change input source. */

								ClipInput = TRUE;

									/* Return success. */

								return(TRUE);
							}
						}
					}
				}
			}
		}
	}

		/* Clean up the remaining resources. */

	ClipClose();

		/* Return failure. */

	return(FALSE);
}
