/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 19.10.98 15:17                               */
/************************************************/

/* Ansi */
#include <string.h>
#include <stdio.h>

/* Mastermind */
#include "GUI.h"
#include "Locale.h"

/* Macros */
#define NICHT_GEWERTET 0
#define GEWERTET 1

/* stormamiga.lib */
#ifdef __STORM__
   #define STORMAMIGA
   #include <stormamiga.h>
   #define sprintf SPRINTF
#endif

/* Global Variables */
extern LONG a[4], I[4], Zug;
extern STRPTR AppStrings[];

/* Functions */
INLINE void sAntwort(LONG *as);
INLINE void wAntwort(LONG *aw);
       void Bewerten(struct Mastermind_Data *Data, Object *obj);


INLINE void sAntwort(LONG *as)
{
   int i;

   *as = 0;
   for (i = 0; i <= 3; i++)
      if (a[i] == I[i])
         *as = *as + 1;
}

INLINE void wAntwort(LONG *aw)
{
   int i, j, gefunden, m[4];

   *aw = 0;
   for (i = 0; i <= 3; i++)
      m[i] = NICHT_GEWERTET;
   for (i = 0; i <= 3; i++)
      {
         gefunden = FALSE;
         j = 0;
         do
         {
            if (m[j] == NICHT_GEWERTET)
               {
                  if (a[i] == I[j])
                     {
                        m[j] = GEWERTET;
                        gefunden = TRUE;
                        *aw = *aw + 1;
                     }
               }
            j++;
         } while (!(j == 4 || gefunden));
      }
}

void Bewerten(struct Mastermind_Data *Data, Object *obj)
{
   LONG as, aw;

   struct AusgabefeldNode Ausgabe;
   extern struct ObjApp *App;     /* Application object */

   get(Data->POP_Eingabe[0], MUIA_PopSymbol_PaletteID, &I[0]);
   get(Data->POP_Eingabe[1], MUIA_PopSymbol_PaletteID, &I[1]);
   get(Data->POP_Eingabe[2], MUIA_PopSymbol_PaletteID, &I[2]);
   get(Data->POP_Eingabe[3], MUIA_PopSymbol_PaletteID, &I[3]);

   sAntwort(&as);
   wAntwort(&aw);
   Zug++;

   if (as == 4)
      {
         strcpy(Ausgabe.Zug, GetString(MSG_GEWONNEN));
         sprintf(Ausgabe.Symbole, "\33I[%s] \33I[%s] \33I[%s] \33I[%s]",
                 App->STR_SymbolBild[I[0]], App->STR_SymbolBild[I[1]],
                 App->STR_SymbolBild[I[2]], App->STR_SymbolBild[I[3]]
                );
         strcpy(Ausgabe.Bewertung, App->STR_BewertungS[4]);

         DoMethod(Data->LV_Ausgabefeld,
                  MUIM_List_InsertSingle,
                  &Ausgabe,
                  MUIV_List_Insert_Bottom
                 );

         set(obj, MUIA_Mastermind_SpielLaeuft, FALSE);
      }
   else
      {
         aw -= as;

         sprintf(Ausgabe.Zug, "%ld", Zug);
         sprintf(Ausgabe.Symbole, "\33I[%s] \33I[%s] \33I[%s] \33I[%s]",
                 App->STR_SymbolBild[I[0]], App->STR_SymbolBild[I[1]],
                 App->STR_SymbolBild[I[2]], App->STR_SymbolBild[I[3]]
                );
         if (as == 0)
            strcpy(Ausgabe.Bewertung, App->STR_BewertungW[aw]);
         else
            sprintf(Ausgabe.Bewertung, "%s %s",
                    App->STR_BewertungS[as], App->STR_BewertungW[aw]
                   );

         DoMethod(Data->LV_Ausgabefeld,
                  MUIM_List_InsertSingle,
                  &Ausgabe,
                  MUIV_List_Insert_Bottom
                 );
      }

   if (Zug >= Data->Zugzahl && as != 4)
      {
         strcpy(Ausgabe.Zug, GetString(MSG_LOESUNG));
         sprintf(Ausgabe.Symbole, "\33I[%s] \33I[%s] \33I[%s] \33I[%s]",
                 App->STR_SymbolBild[a[0]], App->STR_SymbolBild[a[1]],
                 App->STR_SymbolBild[a[2]], App->STR_SymbolBild[a[3]]
                );
         strcpy(Ausgabe.Bewertung, "");

         DoMethod(Data->LV_Ausgabefeld,
                  MUIM_List_InsertSingle,
                  &Ausgabe,
                  MUIV_List_Insert_Bottom
                 );

         set(obj, MUIA_Mastermind_SpielLaeuft, FALSE);
      }

   set(Data->LV_Ausgabefeld, MUIA_List_Active, MUIV_List_Active_Bottom);
}

