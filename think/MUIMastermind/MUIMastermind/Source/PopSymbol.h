/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 30.09.98 16:23                               */
/************************************************/

#define PopSymbolObject NewObject(App->CL_PopSymbol->mcc_Class, NULL

#define MUIA_PopSymbol_PaletteID  0x80430000

#define MUIM_PopSymbol_NeuesBT    0x80430005

struct PopSymbol_Data
{
   LONG PaletteID;
   APTR POP_Popup;
};

