/* Load.c - loadGfxs and closes files */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <dos/dos.h>

#include <clib/dos_protos.h>
#include <clib/alib_protos.h>

#include "load.h"

extern char *logo;          // Flashback Logo
extern char *sprites;
extern ULONG palette2[770]; // Blank Palette
extern ULONG palette3[770]; // Flash Logo Palette
extern ULONG palette4[770]; // Sprites palette

BOOL LoadPalette(STRPTR name,ULONG palette[770])
{
    BOOL success;
    BPTR file;
    if (file=Open(name,MODE_OLDFILE))
     {
        if (Read(file,palette,3080)>=0)
            success=TRUE;
        Close(file);
     }
     else
        success=FALSE;
     return(success);
}





BOOL LoadGfx(void)
{
    BPTR file1;
    BOOL success=FALSE;

    if (file1=Open((STRPTR)"gfx/sprites.raw",MODE_OLDFILE))
    {
        if (Seek(file1,17+(256*3),OFFSET_CURRENT)>=0)  // We skip the Header&Palette Info
        {
            if (Read(file1,sprites,64000)>=0)
            {
                BPTR file2;
                if (file2=Open((STRPTR)"gfx/sprites.pal",MODE_OLDFILE))
                {
                    if (Read(file2,palette4,3080)>=0)
                    {
                        BPTR file3;
                        if (file3=Open((STRPTR)"gfx/blank.pal",MODE_OLDFILE))
                        {
                            if (Read(file3,palette2,3080)>=0)
                            {
                                BPTR file4;
                                if (file4=Open((STRPTR)"gfx/drewlogo.raw",MODE_OLDFILE))
                                {
                                    if (Seek(file4,17+(256*3),OFFSET_CURRENT)>=0) // We skip the Header&Palette Info
                                    {
                                        if (Read(file4,logo,64000)>=0)
                                        {
                                            BPTR file5;
                                            if (file5=Open((STRPTR)"gfx/drewlogo.pal",MODE_OLDFILE))
                                            {
                                                if (Read(file5,palette3,3080)>=0)
                                                    success=TRUE;

                                                Close(file5);
                                            }
                                        }
                                    }
                                    Close(file4);
                                }
                            }
                            Close(file3);
                        }
                    }
                    Close(file2);
                }
            }
        }
        Close(file1);
    }
    
    return success;
}


