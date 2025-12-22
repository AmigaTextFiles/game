#include <exec/exec.h>
#include <dos/dos.h>
#include <clib/dos_protos.h>
#include "power.h"

void *PLoadFile(char *name,unsigned int req)
{
        BPTR file;
        int length;
        APTR p;
        if(!(file=Open(name,MODE_OLDFILE)))
                return 0L;
        Seek(file,0,OFFSET_END);
        length=Seek(file,0,OFFSET_BEGINNING);
        if(!(p=PAllocMem(length,req)))
        {
                Close(file);
                return 0L;
        }
        Read(file,p,length);
        Close(file);
        return p;
}
