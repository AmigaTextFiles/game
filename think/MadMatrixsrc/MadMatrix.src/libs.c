#include <stdio.h>
#include <stdlib.h>

#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/exec.h>

#include <libraries/mui.h>

#include "libs.h"

struct IntuitionBase *IntuitionBase=NULL;
struct GfxBase  *GfxBase=NULL;
struct Library  *MUIMasterBase=NULL;
struct Library  *UtilityBase=NULL;



int Ouvrir_Libs(void )
{
  if ( !(IntuitionBase=(struct IntuitionBase *) OpenLibrary((UBYTE *)"intuition.library",39)) )
    return(0);

  if ( !(GfxBase=(struct GfxBase *) OpenLibrary((UBYTE *)"graphics.library",0)) )
  {
    Fermer_Libs();
    return(0);
  }


  if ( !(MUIMasterBase=OpenLibrary((UBYTE *)MUIMASTER_NAME,19)) )
  {
    Fermer_Libs();
    return(0);
  }

  if ( !(UtilityBase=OpenLibrary("utility.library",0)) )
  {
    Fermer_Libs();
    return(0);
  }


  return(1);
}

void Fermer_Libs(void )
{
  if ( IntuitionBase )
    CloseLibrary((struct Library *)IntuitionBase);

  if ( GfxBase )
    CloseLibrary((struct Library *)GfxBase);

  if ( MUIMasterBase )
    CloseLibrary(MUIMasterBase);

  if ( UtilityBase )
    CloseLibrary((struct Library *)UtilityBase);

}


