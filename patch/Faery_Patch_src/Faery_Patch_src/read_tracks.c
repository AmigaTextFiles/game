/*
* This file is part of Faery Tale Adventure Patch.
* Copyright (C) 1997 Peter McGavin
* 
* Faery Tale Adventure Patch is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Faery Tale Adventure Patch is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Faery Tale Adventure Patch.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <stdio.h>

#include <exec/exec.h>
#include <dos/dos.h>
#include <devices/trackdisk.h>
#include <utility/tagitem.h>

#include <proto/dos.h>
#include <proto/exec.h>

static char buf[11 * 512];
static struct MsgPort *track_mp = NULL;
static struct IOExtTD *track_io = NULL;
static BOOL track_is_open = FALSE;

void _STDcleanup (void)
{
  if (track_is_open) {
    track_io->iotd_Req.io_Length = 0;
    track_io->iotd_Req.io_Command = TD_MOTOR;
    DoIO ((struct IORequest *)track_io);
    CloseDevice ((struct IORequest *)track_io);
  }
  if (track_io != NULL)
    DeleteExtIO ((struct IORequest *)track_io);
  if (track_mp != NULL)
    DeletePort (track_mp);
}

int main (int argc, char *argv[])
{
  FILE *f;
  int i;
  char *programname;

  if (argc == 0)
    programname = "read_tracks";
  else
    programname = argv[0];

  if (argc != 2) {
    fprintf (stderr, "Usage: %s outputfile\n", programname);
    return 10;
  }

  if ((track_mp = CreatePort (0, 0)) != NULL &&
      (track_io = (struct IOExtTD *)CreateExtIO (track_mp, sizeof(struct IOExtTD))) != NULL &&
      OpenDevice (TD_NAME, 0, (struct IORequest *)track_io, 0) == 0) {
    track_is_open = TRUE;

    if ((f = fopen (argv[1], "wb")) != NULL) {

      for (i = 0; i < 160; i++) {
        track_io->iotd_Req.io_Length = (11 * 512);
        track_io->iotd_Req.io_Data = buf;
        track_io->iotd_Req.io_Offset = i * (11 * 512);
        track_io->iotd_Req.io_Command = CMD_READ;
        if (DoIO ((struct IORequest *)track_io) != 0)
          fprintf (stderr, "Error %d reading track %d from diskette\n",
                   track_io->iotd_Req.io_Error, i);
        if (fwrite (buf, 1, 11 * 512, f) != 11 * 512)
          fprintf (stderr, "Error writing track %d to %s\n", i, argv[1]);
      }

      fclose (f);
    }
  }

  return 0;
}
