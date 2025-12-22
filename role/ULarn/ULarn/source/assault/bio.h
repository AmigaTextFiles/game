/*
** FILENAME:    bio.h
**
** DESCRIPTION:
**
** Buffered I/O package.
**
** Allows multiple small reads and writes to be handled efficiently.
** Probably not so good for large reads/writes.
** Excellent for reading IFF pictures though.
**
** Duplicates the Amiga DOS functions and are used in exactly the same
** way as their counterparts as described in the Amiga technical reference
** Manual (Libraries and devices).
**
** ------------------------------------------------------------------------
*/

#ifndef __BIO_H
#define __BIO_H

#include <libraries/dos.h>
#include <libraries/dosextens.h>

/*
** NOTE : The buffer is used for either input out output at any one time.
**        Any read after a write, or write after a read will cause the
**        buffer to be flushed.
**        The seek operation will also cause the buffer to be flushed.
*/

struct BFile {
  BPTR file;                   /* Pointer to a DOS file handle         */
  UBYTE *buffer;               /* Pointer to Input/Output buffer       */
  long file_offset;            /* Current position in buffered file    */
  long buffer_size;            /* Number of bytes read into the buffer */
  long in_buffer_count;        /* Position in the buffer for input     */
  long out_buffer_count;       /* Position in the buffer for output    */
};

/* functions available */

struct BFile *BOpen(char *name, long accessMode);

void BClose(struct BFile *file);

long BRead(struct BFile *file, UBYTE *buff, long length);

long BSeek(struct BFile *file, long position, long mod);

long BWrite(struct BFile *file, UBYTE *buff, long length);

#endif