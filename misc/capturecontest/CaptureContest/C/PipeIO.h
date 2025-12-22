
/*###########*/
/* PipeIO.h  */       /*  (8.1.2011) */
/*###########*/

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

#ifndef PipeIO_h
#define PipeIO_h

#include <proto/dos.h>

#include "MyTypes.h"

#define ReadBufSize 1024

struct PipeFileRec {struct FileHandle*  pfFile;
                    int                 pfBufPos;
                    int                 pfReadCnt;
                    char                pfFileName[82];
                    char                pfLineBuffer[ReadBufSize+1];
                    boolean             pfNeedRead;
                    boolean             pfReadMode;
                   };

typedef struct PipeFileRec* PipeFile;

typedef enum {PipeModeRead, PipeModeWrite} OpenModes;
typedef enum {opened, otherProblem} OpenResults;

 PipeFile InvalidPipe(void);

 PipeFile OpenPipe(char pipeNam[], OpenModes omode, OpenResults* res);
 void ClosePipe(PipeFile* f);

 struct FileHandle* RevealPipeFH(PipeFile f);

 struct FileHandle* ServePipeFH(PipeFile f);
      /* for passing off the pipe to another process (eg, input/output redirection */
      /* this closes the PipeFile, but not the PIPE: FileHandle */

 boolean ReadPipe(PipeFile f, char* ch);
 boolean ReadPipeLine(PipeFile f, char s[]);
   /* don't come back until a LF is read, LF not included in the returned string */
 /*boolean dReadPipeLine(PipeFile f, VAR ds:DynStr)*/

 boolean WritePipe(PipeFile f, char ch);
 boolean WriteStringPipe(PipeFile f, char s[]);
 boolean WriteBufferPipe(PipeFile f, char buf[], int num);

 void FlushPipe(PipeFile f);

#endif


