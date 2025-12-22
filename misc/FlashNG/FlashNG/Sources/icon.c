/* Icon.c - Part of FlashNG - © 2001 Nogfx. */

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/wb.h>
#include <proto/icon.h>

#include <exec/types.h>
#include <exec/ports.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "icon.h"

extern struct Library *IconBase;


char *GetTool(struct DiskObject *diskobj)
{
    char *modeid;
    
    if (modeid=FindToolType(diskobj->do_ToolTypes, "SCREENMODE"))
        return modeid;
    else
        return NULL; // SCREENMODE Tooltype Not found
}


char *InitToolTypes(void)
{
    char *toolval=NULL; // If there's no icon, return NULL

    if (IconBase=OpenLibrary("icon.library",0))
    {
        struct DiskObject *diskobj=NULL;

        if (diskobj=GetDiskObject("FlashNG"))
        {
            toolval=GetTool(diskobj);
            FreeDiskObject(diskobj);
        }

        CloseLibrary(IconBase);
    }

    return(toolval);
}


