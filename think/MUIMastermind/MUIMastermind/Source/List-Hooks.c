/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 02.11.98 18:50                               */
/************************************************/

/* Mastermind */
#include "GUI.h"
#include "Locale.h"

/* stormamiga.lib */
/*
#ifdef __STORM__
   #define STORMAMIGA
   #define STORMAMIGA_INLINE
   #include <stormamiga.h>
#endif
*/
/* Ansi */
#include <string.h>

/* Functions */
APTR  SAVEDS ConstructFunc(REG(a0) struct Hook *hook, REG(a2) APTR Pool   , REG(a1) struct AusgabefeldNode *an);
void  SAVEDS DestructFunc (REG(a0) struct Hook *hook, REG(a2) APTR Pool   , REG(a1) struct AusgabefeldNode *an);
ULONG SAVEDS DisplayFunc  (REG(a0) struct Hook *hook, REG(a2) char **Array, REG(a1) struct AusgabefeldNode *an);

extern STRPTR AppStrings[];


APTR SAVEDS ConstructFunc(REG(a0) struct Hook *hook, REG(a2) APTR Pool, REG(a1) struct AusgabefeldNode *an)
{
   struct AusgabefeldNode *Neu;

   if (Neu = AllocPooled(Pool, sizeof(struct AusgabefeldNode)))
      memcpy(Neu, an, sizeof(struct AusgabefeldNode));

   return(Neu);
}

void SAVEDS DestructFunc(REG(a0) struct Hook *hook, REG(a2) APTR Pool, REG(a1) struct AusgabefeldNode *an)
{
   FreePooled(Pool, an, sizeof(struct AusgabefeldNode));
}

ULONG SAVEDS DisplayFunc(REG(a0) struct Hook *hook, REG(a2) char **Array, REG(a1) struct AusgabefeldNode *an)
{
   if(an)
      {
         *Array++ = an->Zug;
         *Array++ = an->Symbole;
         *Array   = an->Bewertung;
      }
   else
      {
         *Array++ = GetString(LBL_ZUG);
         *Array++ = GetString(LBL_LSYMBOLE);
         *Array   = GetString(LBL_BEWERTUNG);
      }

   return(0);
}

