// Utils.C - general purpose utility functions

#include <dos.h>
#include <proto/dos.h>

#include <exec/memory.h>
#include <proto/exec.h>

#include <string.h>
#include "Utils_protos.h"

// extern long Console;

   // Print to the console: used mainly for error reports & debugging.
void Print(string)
char *string;
{
   ULONG con = Output();

   if (con)
      Write(con,string,strlen(string));
}

short LeftButton()  // returns TRUE if left mouse button is down
{
   char *pra = (char *)0xBFE001;  // CIA-A port register A

   if ( (*pra & 0x40)==0 )
      return TRUE;
   else
      return FALSE;
}


void wait_for_click()  // Wait for a click of the left mouse button.
{
   while ( !LeftButton() )  // wait for click
      ;
}


ULONG FLength(filename)
char *filename;
{
   // FLength() returns the length of the file "filename".  If the file
   // cannot be found, it will return a length of -1.

   struct FileLock *flock;
   struct FileInfoBlock *info;
   ULONG result;

   flock = (struct FileLock *)Lock(filename, ACCESS_READ);  // get a lock
   if (!flock)
      return -1L;  // file not found

   // NOTE: RAM for the FileInfoBlock must be allocated dynamically to make
   //       sure it is on an even boundary.

   info = (struct FileInfoBlock *)AllocMem(sizeof(*info),MEMF_CLEAR);
   if (!info)
      return -1L;  // some kind of memory problem
   Examine((BPTR)flock, info);
   result = info->fib_Size;      // get the file size
   FreeMem(info,(long)sizeof(*info));  // free the ram
   UnLock((BPTR)flock);  // release the lock
   return result;
}


void FJoin(Source1,Source2,Dest)
char *Source1, *Source2, *Dest;
{
   char *Buffer;
   long File,
        Size1 = FLength(Source1),
        Size2 = FLength(Source2);

   if (Size1<0 || Size2<0)
      return;

   Buffer = (char *)AllocMem(Size1+Size2,0L);
   if (Buffer == NULL)
      return;

   File = Open(Source1,MODE_OLDFILE);
   Read(File,Buffer,Size1);
   Close(File);

   File = Open(Source2,MODE_OLDFILE);
   Read(File,Buffer+Size1,Size2);
   Close(File);

   File = Open(Dest,MODE_NEWFILE);
   Write(File,Buffer,Size1+Size2);
   Close(File);

   FreeMem(Buffer,Size1+Size2);
}


void FCopy(Source,Dest)
char *Source, *Dest;
{
   char *Buffer;
   long File;
   long Size = FLength(Source);

   if (Size<1)
      return;

   Buffer = (char *)AllocMem(Size,0L);
   if (Buffer == NULL)
      return;

   File = Open(Source,MODE_OLDFILE);
   if (File == NULL)
      return;
   Read(File,Buffer,Size);
   Close(File);

   File = Open(Dest,MODE_NEWFILE);
   if (File == NULL)
      return;
   Write(File,Buffer,Size);
   Close(File);

   FreeMem(Buffer,Size);
}

// end of listing
