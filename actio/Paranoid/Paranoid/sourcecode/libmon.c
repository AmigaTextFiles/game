#include <exec/types.h>
#include <exec/execbase.h>
struct ExecBase *eb;
char *OpenLibrary();
main()
{
 UBYTE *button=(UBYTE *) 0xbfe001;
 struct Library *lib;
 struct Node *np;
 if (!(eb=(struct ExecBase *) OpenLibrary ("exec.library",0l)))
 exit (FALSE); lib=&(eb->LibNode);
 np=&(lib->lib_Node);
 while ((np->ln_Succ)!=NULL) 
 {
  lib=(struct Library *) np;
  clear();
  printf ("--------------------------------\n");
  printf ("library:  %s\n",np->ln_Name);
  printf ("comment:  %s\n",lib->lib_IdString);
  printf ("version:  %u\n",lib->lib_Version);
  printf ("revision: %u\n",lib->lib_Revision);
  printf ("opencnt:  %u\n",lib->lib_OpenCnt);
  printf ("address:  $%lx\n",(long) np);
  printf ("--------------------------------\n");
  printf ("\n\npress mouse button!\n");
  while (*button & (UBYTE) 64);
  np=np->ln_Succ;
 } 
 CloseLibrary (eb);
}
clear()
{
printf ("\f");
printf ("\nLibMon by Felix Wente\n");
printf ("This Program is Public Domain!\n\n\n");
}






