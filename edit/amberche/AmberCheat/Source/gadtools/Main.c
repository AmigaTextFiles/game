/*************************************************************************/
/*                                                                       */
/*   GUI designed with GUICreator V1.4 - © 1995 by Markus Hillenbrand    */
/*                                                                       */
/*************************************************************************/

char *V="$VER: AmberCheat 1.1gt (21.12.97)";


/*************************************************************************/
/*                                                                       */
/*   Includes                                                            */
/*                                                                       */
/*************************************************************************/

#include  <exec/execbase.h>
#include  <proto/exec.h>

/*************************************************************************/
/*                                                                       */
/*   Variables and Structures                                            */
/*                                                                       */
/*************************************************************************/

struct IntuitionBase *IntuitionBase = NULL;
struct UtilityBase   *UtilityBase   = NULL;
struct GfxBase       *GfxBase       = NULL;
struct Library *GadToolsBase  = NULL;
struct Library *AslBase       = NULL;

/*************************************************************************/
/*                                                                       */
/*   Variabled                                                           */
/*                                                                       */
/*************************************************************************/


/*************************************************************************/
/*                                                                       */
/*   main()                                                              */
/*                                                                       */
/*************************************************************************/

int main ( void )
{
		IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",37);
		UtilityBase  =(struct UtilityBase   *)OpenLibrary("utility.library"  ,37);
		GfxBase      =(struct GfxBase       *)OpenLibrary("graphics.library" ,37);
		GadToolsBase =OpenLibrary("gadtools.library" ,37);
		AslBase      =OpenLibrary("asl.library"      ,37);

		if (IntuitionBase && GadToolsBase && GfxBase && AslBase && UtilityBase )
			{
			struct Screen *screen;
			screen=LockPubScreen(NULL);
			if (screen)
				{
				HandleAmberCheat(screen,-1,-1,NULL);
				UnlockPubScreen(NULL,screen);
				}
			else printf("Cannot lock screen\n");
			}
		else printf("Cannot open the following libraries:\n");

		if (AslBase)       CloseLibrary(AslBase);       else printf("- Asl.library       v39\n");
		if (GadToolsBase)  CloseLibrary(GadToolsBase);  else printf("- Gadtools.library  v39\n");
		if (GfxBase)       CloseLibrary((struct Library *)GfxBase);       else printf("- Graphics.library  v39\n");
		if (UtilityBase)   CloseLibrary((struct Library *)UtilityBase);   else printf("- Utility.library   v39\n");
		if (IntuitionBase) CloseLibrary((struct Library *)IntuitionBase); else printf("- Intuition.library v39\n");

		exit(RETURN_OK);
}
