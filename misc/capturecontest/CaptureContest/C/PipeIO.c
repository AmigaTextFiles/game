
/*##########*/
/* PipeIO.c */          /* 16.1.2011 */
/*##########*/

/*Copyright (C) 2010 Thomas Breeden, All Rights Reserved.
                   Aglet Software
                   PO Box 99
                   Free Union, VA 22940

Permission to use, copy, modify and distribute this software and its
documentation for any purpose and without fee is hereby granted, provided that
the above copyright notice appear in all copies and that both the copyright
notice and this permission notice appear in supporting documentation.
Thomas Breeden makes no representations about the suitability of this software
for any purpose. It is provided "as is" without express or implied warranty.
*/

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <proto/dos.h>
#include <proto/utility.h>

#include "PipeIO.h"

/*
gcc -c PipeIO.c
*/

#define LF  '\n'

/* NOTE:
    see docs under queue-handler, not pipe-handler
*/

/*---------------------*/
 static boolean TstBreak(void)
/*---------------------*/
{

return (IDOS->CheckSignal(SIGBREAKF_CTRL_C) != 0);

}

/*-------------------------------------*/
 static void Assert(boolean b, char msg[])
/*-------------------------------------*/
{

if (!b) {
   fprintf(stderr, "%s\n", msg);
   assert(0);
}

}

/*--------------------*/
 static void StrCap(char s[])
/*--------------------*/
{
int i,
    len;

len = strlen(s);

for (i = 0; i < len; i++) {
   s[i] = toupper(s[i]);
}

}

/*-----------------------------------------*/
 static void DoClose(PipeFile* f, boolean fhAlso)
/*-----------------------------------------*/

{
int  iRes;

if (*f != NULL) {

   if (fhAlso) {
      iRes = IDOS->Close((BPTR)((*f)->pfFile));
   }

   free(*f);
   *f = NULL;
}

}

/*==========================*/
 PipeFile InvalidPipe(void)
/*==========================*/

{

return NULL;

}

/*============================================*/
 struct FileHandle* RevealPipeFH(PipeFile f)
/*============================================*/
      /* this does not close the PipeFile */

{
struct FileHandle*  ret;

ret = f->pfFile;

return ret;

}

/*===========================================*/
 struct FileHandle* ServePipeFH(PipeFile f)
/*===========================================*/
      /* for passing off the pipe to another process (eg, input/output redirection */
      /* this also closes the M2 PipeFile, but not the DOS pipe fh itself */

{
struct FileHandle*  ret;

ret = f->pfFile;

DoClose(&f, F/*fhAlso*/);

return ret;

}

/*=====================================================================*/
 PipeFile OpenPipe(char pipeNam[], OpenModes omode, OpenResults* res)
/*=====================================================================*/

{
PipeFile            file;
char                fn[134];
struct FileHandle*  handle;
int                 Amode;
int                 iRes;


handle = NULL;
file   = NULL;
*res = otherProblem;

if (omode ==  PipeModeRead) {
   Amode = MODE_OLDFILE;
} else {
   Amode = MODE_NEWFILE;
}

strcpy(fn, "PIPE:");
strncat(fn, pipeNam, 132-5);
StrCap(fn);

printf("%s\n", fn);
handle = (struct FileHandle*)IDOS->Open(fn, Amode);

if (handle != NULL) {

   file = malloc(sizeof(struct PipeFileRec));

   if (file != NULL) {

      file->pfFile = handle;
      strncpy(file->pfFileName, fn, (sizeof file->pfFileName)-1);
      file->pfBufPos = 0;
      file->pfReadCnt = 0;
      file->pfNeedRead = T;

      if (omode == PipeModeRead) {                         /* read pipe to be blocking */
         file->pfReadMode = T;
      } else {
         file->pfReadMode = F;                             /* write pipe to be blocking */  
      }

      *res = opened;

   } else {

      iRes = IDOS->Close((BPTR)handle);
      iRes = IDOS->SetIoErr(ERROR_NO_FREE_STORE);

   }

}

return file;         /* will be NULL if the Open() failed */

}

/*=========================*/
 void FlushPipe(PipeFile f)
/*=========================*/
                                  /* only on read pipes for now */
{
char    ch;
int     oldMode,
        iRes;
boolean bRes;

if (f != NULL) {

   if (f->pfReadMode) {

      oldMode = IDOS->SetBlockingMode((BPTR)(f->pfFile), SBM_NON_BLOCKING);
      Assert(oldMode != 0, "SetBlockingMode FAIL");

      do {

         iRes = IDOS->Read((BPTR)(f->pfFile), &ch, 1);   /*  PIPE: will return 0 only before -1 */
                                                 /* 0 returned means no writers exist now (ie, data will never be there */
                                                 /* otherwise, -1 is returned for a read in non-blocking mode if not data is there */
         if (iRes != 1) {
            if (oldMode != SBM_NON_BLOCKING) {
               oldMode = IDOS->SetBlockingMode((BPTR)(f->pfFile), SBM_BLOCKING);
               Assert(oldMode != 0, "SetBlockingMode FAIL");
            }
            return;   /* could return 0 or -1, depending on whether all the writers are closed */
         }

      } while (T);

   }

}

}

/*============================*/
 void ClosePipe(PipeFile* f)
/*============================*/

{

FlushPipe(*f);

DoClose(f, T/*fhAlso*/);

}

/*---------------------------*/
 static int ReadBuffered(PipeFile f)
/*---------------------------*/
   /* ReadCnt zero indicates end-of-file == all writers have closed and -1 will be returned on the next read */

{
int      oldMode,
         ReadCnt,
         iRes0,
         iRes;

Assert(IDOS->WaitForChar((BPTR)(f->pfFile), 200000) != DOSFALSE , "PipeIO:read timeout");       /* 0.2 sec */
ReadCnt = IDOS->Read((BPTR)(f->pfFile), f->pfLineBuffer, ReadBufSize);       /*  PIPE: will return 0 only before -1 */

if (ReadCnt < 0) {       /* ie, non-blocking pipe has no writers still open */    /* Could use 0 */

   fprintf(stderr, "ReadBuffered: reopen kludge %i", ReadCnt);
   Assert(F, "NYI");
   /* all writers have closed on us */
   /*
   if (DEBUG) { fprintf(stderr, "ReadBuffered: close and reopen pipe %i", 0); }
   iRes = IDOS->Close(f->pfFile);
   f->pfFile = IDOS->Open(f->pfFileName, ModeOldFile);
   Assert(f->pfFile != CAST(FileHandle, NULL) , "Re-Open for read FAIL");

   TagsUtils.AsgTag(Tags, FHBufferMode, BufFull);
   iRes0 = IDOS->SetFileHandleAttr(f->pfFile, Tags);        
   */

} else if ( ReadCnt == 0) {

   /*if (DEBUG) { fprintf(stderr, "ReadBuffered: ReadCnt 0 %i", 0); } */

} else {

   f->pfNeedRead = F;
   f->pfBufPos = 0;

}

return ReadCnt;

}

/*==========================================*/
 boolean ReadPipeLine(PipeFile f, char s[])
/*==========================================*/
  /* don't come back until a LF is read, LF not included in the returned string */

{
boolean  LFfound;
int      i, j;
int      sLen;
char     ch;
 

if (!f->pfReadMode) {
   fprintf(stderr, "NOT ReadMode %i", 0);
}
Assert(f->pfReadMode, "ReadPipeLine called on WriteMode pipe");

s[0] = '\0';
sLen = 0;

do {

   if (TstBreak()) {                                     
      fprintf(stderr, "ReadPipeLine: TstBreak true %i", 0);
      f->pfReadCnt = 0;
      break;
   }

   if (f->pfNeedRead) {
      f->pfReadCnt = ReadBuffered(f);
   }

   if (f->pfReadCnt > 0) {

      LFfound = F;
      while (!LFfound && !f->pfNeedRead) {

         ch = f->pfLineBuffer[f->pfBufPos];

         f->pfBufPos++;
         if (f->pfBufPos >= f->pfReadCnt) {
            f->pfNeedRead = T;
         }

         if (ch != LF) {
            s[sLen] = ch;
            sLen++;
         } else {
            LFfound = T;
         }
      }

      if (LFfound) {

        s[sLen] = '\0';
        break;

      } else { /* need more */

        /*f->pfBufPos = sLen-1;*/
        /*f->pfNeedRead = T;*/

      }

   }

} while (T);

return LFfound; 

}

/*=======================================*/
 boolean ReadPipe(PipeFile f, char* ch)
/*=======================================*/

{
/*TagItem  Tags[10];*/
int      oldMode,
         ioerr,
         iRes0,
         iRes;

iRes = -2;  /* dummy initial value */

if (!f->pfReadMode) {
   fprintf(stderr, "NOT ReadMode %i", 0);
}
Assert(f->pfReadMode, "ReadPipe called on WriteMode pipe");

do {

   if (TstBreak()) {                                     
      fprintf(stderr, "ReadPipe: TstBreak true %i", 0);
      iRes = 0;
      break;
   }

   if (iRes != 0) {

      Assert(IDOS->WaitForChar((BPTR)(f->pfFile), 200000) != DOSFALSE, "PipeIO:read timeout");       /* 0.2 sec */
      iRes = IDOS->Read((BPTR)(f->pfFile), &ch, 1);         /*  PIPE: will return 0 only before -1 */

      /*ioerr = IDOS->IoErr();*/

      if (iRes < 0) {        /* ie, non-blocking pipe has no writers still open */

         fprintf(stderr, "ReadPipe() reopen kludge %i", iRes);
         Assert(0, "NYI");
         /*if (ioerr != ErrorWouldBlock) {*/
            /* all writers have closed on us */

            /*if (DEBUG) { fprintf(stderr, "ReadPipe: close and reopen pipe %i", 0); }*/
            /*iRes = IDOS->Close(f->pfFile);*/
            /*f->pfFile = IDOS->Open(f->pfFileName, ModeOldFile);*/
            /*Assert(f->pfFile != CAST(FileHandle, NULL), "Re-Open for read FAIL");*/

            /*oldMode = IDOS->SetBlockingMode((BPTR)(f->pfFile), SbmNonBlocking);*/
            /*Assert(oldMode != 0, "SetBlockingMode FAIL");*/

            /*TagsUtils.AsgTag(Tags, FHBufferMode, BufFull);*/   /* pipe: otherwise will do a BufFull, and BufLine does not seem to work */
            /*iRes0 = IDOS->SetFileHandleAttr(f->pfFile, Tags);*/         /* must be called before any file io */

         /*}*/
      } else if (iRes == 1) {
         break;
      }

   }

} while (1);

return iRes == 1;

}

/*======================================*/
 boolean WritePipe(PipeFile f, char ch)
/*======================================*/

{
int ioerr,
    iRes;

iRes = 0;

if (!TstBreak()) {

   iRes = IDOS->Write((BPTR)(f->pfFile), &ch, 1);

   if (iRes != 1) {                    /* should not happen with a blocking pipe (unless all readers close) */
      ioerr = IDOS->IoErr();
      fprintf(stderr, "WritePipe: iRes not 1 %i", iRes);
      fprintf(stderr, "ioerr %i", ioerr);        /* "BROKEN_PIPE" */
   }

}

return iRes == 1;

}

/*=========================================================*/
 boolean WriteBufferPipe(PipeFile f, char buf[], int num)
/*=========================================================*/

{
int ioerr,
    iRes;

iRes = 0;

if (!TstBreak()) {

   iRes = IDOS->Write((BPTR)(f->pfFile), buf, num);

}

if (iRes != num) {                           /* should not happen with a blocking pipe (unless reader closes?) */
   ioerr = IDOS->IoErr();
   fprintf(stderr, "WriteBufferPipe: Write blocked or FAIL %i", iRes);
   fprintf(stderr, "IoErr %i", ioerr);
}

return iRes == num;

}

/*==============================================*/
 boolean WriteStringPipe(PipeFile f, char s[])
/*==============================================*/

{
int  num,
     iRes;

iRes = 0;

if (!TstBreak()) {

   num = strlen(s);
   iRes = IDOS->Write((BPTR)(f->pfFile), s, num);

}

if (iRes != num) {                           /* should not happen with a blocking pipe (unless reader closes?) */
   fprintf(stderr, "WriteStringPipe: Write blocked or FAIL %i", iRes);
}

return iRes == num;

}

