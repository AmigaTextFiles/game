/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 30.09.98 17:23                               */
/************************************************/

#define EinstellungenObject NewObject(App->CL_Einstellungen->mcc_Class, NULL

#define MUIM_Einstellungen_Benutzen  0x80430030

#define MUIA_Einstellungen_Zugzahl   0x80430031

struct Einstellungen_Data
{
   APTR SL_Zugzahl;
   LONG Zugzahl;
};

