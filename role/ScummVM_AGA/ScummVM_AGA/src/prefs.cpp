/*

 Prefs.cpp: loads and saves AmigaOS ModeID to file 'ScummAGA.ModeID'

*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "prefs.h"

unsigned long readmodeid(void)
{
    unsigned long mode=0;
    FILE *prefs;
    if (prefs=fopen("ScummAGA.ModeID","rb"))
    {
        fread(&mode,sizeof(unsigned long),1,prefs);
        fclose(prefs);
        return(mode);
    } else return(0);
}

int storemodeid(unsigned long modeid)
{
    FILE *prefs;
    if (prefs=fopen("ScummAGA.ModeID","wb"))
    {
        fwrite(&modeid,sizeof(unsigned long),1,prefs);
        fclose(prefs);
        return(1);
    } else return(0);


}
/*unsigned long readmodeid(void)
{
   char mode[10];
   if (readprefs("[Prefs]","Screenmode",mode))
   return((unsigned long)(atoi(mode)));
   else return(0);
}

int storemodeid(unsigned long modeid)
{
   char mode[10];
   sprintf(mode,"%d",modeid);
   return((writeprefs("[Prefs]","Screenmode",mode)));
} */

