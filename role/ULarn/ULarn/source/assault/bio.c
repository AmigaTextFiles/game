#include "bio.h"

#include <stdio.h>
#include <string.h>
#include <functions.h>
#include <exec/memory.h>

#define MIN(x,y) ((x < y) ? (x) : (y))

#define BUFFER_SIZE 16384L


struct BFile *BOpen(char *name, long accessMode)
{
  BPTR dos_file;
  struct BFile *buffered_file;

  if ( (dos_file = Open(name, accessMode)) == NULL)
  {
    return NULL;
  }

  buffered_file =
    (struct BFile *) AllocMem((long) sizeof(struct BFile), MEMF_CLEAR);

  if (buffered_file == NULL)
  {
    Close(dos_file);
    return NULL;
  }

  buffered_file->buffer =
    (UBYTE *) AllocMem(BUFFER_SIZE, MEMF_CLEAR);
  if (buffered_file->buffer == NULL)
  {
    FreeMem(buffered_file, (long) sizeof(struct BFile));
    Close(dos_file);
    return NULL;
  }

  buffered_file->file = dos_file;
  buffered_file->file_offset = 0L;

  buffered_file->buffer_size = -1L;        /* never read anything */
  buffered_file->in_buffer_count = 0L;
  buffered_file->out_buffer_count = 0L;

  return buffered_file;
}


void BClose(struct BFile *file)
{
  /* Flush the output buffer if necessary */
  if (file->out_buffer_count > 0L)
  {
    Write(file->file, file->buffer, file->out_buffer_count);
    file->out_buffer_count = 0L;
    file->in_buffer_count = 0L;
    file->buffer_size = -1L;
  }

  Close(file->file);
  FreeMem(file->buffer, BUFFER_SIZE);

  FreeMem(file, (long) sizeof(struct BFile));
}


long BRead(struct BFile *file, UBYTE *buffer, long length)
{
  long bytes_read;
  long bytes_left;
  long bytes_to_copy;

  bytes_read = 0L;

  /* Flush the output buffer if necessary */
  if (file->out_buffer_count > 0L)
  {
    Write(file->file, file->buffer, file->out_buffer_count);
    file->out_buffer_count = 0L;
    file->in_buffer_count = 0L;
    file->buffer_size = -1L;
  }

  bytes_left = file->buffer_size - file->in_buffer_count;
  bytes_to_copy = MIN(bytes_left, length);
  if (bytes_to_copy > 0L)
  {
    memcpy(buffer, &(file->buffer[file->in_buffer_count]), bytes_to_copy);

    file->in_buffer_count += bytes_to_copy;
    bytes_read += bytes_to_copy;
  }

  bytes_to_copy = length - bytes_read;
  if (bytes_to_copy != 0L)
  {
    if ( bytes_to_copy > BUFFER_SIZE)
    {
      bytes_read += Read(file->file, &buffer[bytes_read], bytes_to_copy);

      if (bytes_read < length)
      {
        file->buffer_size = 0L;        /* end of file has been reached */
        file->in_buffer_count = 0L;
      }
      else
      {
        file->buffer_size = -1L;       /* no data in buffer */
        file->in_buffer_count = 0L;
      }
    }
    else
    {
      file->buffer_size = Read(file->file, file->buffer, BUFFER_SIZE);
      file->in_buffer_count = 0L;

      bytes_to_copy = MIN(bytes_to_copy, file->buffer_size);
      memcpy(&buffer[bytes_read], file->buffer, bytes_to_copy);

      file->in_buffer_count += bytes_to_copy;
      bytes_read += bytes_to_copy;
    }
  }

  file->file_offset += bytes_read;

  return bytes_read;
}


long BSeek(struct BFile *file, long position, long mode)
{
  long current_pos;
  long new_pos;
  long buff_start;
  long buff_end;

  /* Flush the output buffer if necessary */
  if (file->out_buffer_count > 0L)
  {
    Write(file->file, file->buffer, file->out_buffer_count);
    file->out_buffer_count = 0L;
  }

  if (mode == OFFSET_CURRENT)
  {
    if (file->buffer_size <= 0L)
    {
      /* seek the position directly
         (input buffer empty -> file_offset matches physical location) */

      Seek(file->file, position, OFFSET_CURRENT);
    }
    else
    {
      current_pos = file->file_offset;
      new_pos = current_pos + position;
      buff_start = current_pos - file->in_buffer_count;
      buff_end = buff_start + file->buffer_size;

      if ((new_pos >= buff_start) && (new_pos < buff_end))
      {
        /* the seek position is within the buffer */

        file->in_buffer_count = new_pos - buff_start;
        file->file_offset = new_pos;
      }
      else
      {
        Seek(file->file, new_pos, OFFSET_BEGINNING);
        file->file_offset = new_pos;
        file->buffer_size = -1L;
        file->in_buffer_count = 0L;
      }
    }
  }
  else
  {
    current_pos = file->file_offset;
    Seek(file->file, position, mode);
    file->file_offset = Seek(file->file, 0L, OFFSET_CURRENT);
    file->buffer_size = -1L;
    file->in_buffer_count = 0L;
  }

  return current_pos;
}


long BWrite(struct BFile *file, UBYTE *buffer, long length)
{
  long bytes_written;
  long bytes_left;
  long bytes_to_copy;

  file->buffer_size = -1L;
  file->in_buffer_count = 0L;

  if (length >= BUFFER_SIZE)
  {
    if (file->out_buffer_count > 0L)
    {
      Write(file->file, file->buffer, file->out_buffer_count);
      file->out_buffer_count = 0L;
    }

    bytes_written = Write(file->file, buffer, length);
  }
  else
  {
    bytes_left = BUFFER_SIZE - file->out_buffer_count;
    bytes_to_copy = MIN(bytes_left, length);
    memcpy(&(file->buffer[file->out_buffer_count]),buffer, bytes_to_copy);

    file->out_buffer_count += bytes_to_copy;
    bytes_written += bytes_to_copy;

    if (file->out_buffer_count == BUFFER_SIZE)
    {
      Write(file->file, file->buffer, BUFFER_SIZE);
      file->out_buffer_count = 0L;

      if (bytes_written < length)
      {
        bytes_to_copy = length - bytes_written;
        memcpy(file->buffer, &buffer[bytes_written], bytes_to_copy);

        file->out_buffer_count += bytes_to_copy;
        bytes_written += bytes_to_copy;
      }
    }

  }

  file->file_offset += bytes_written;
  return bytes_written;
}

