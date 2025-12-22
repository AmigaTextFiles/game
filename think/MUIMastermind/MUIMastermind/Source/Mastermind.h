/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 30.09.98 16:58                               */
/************************************************/

#define MastermindObject NewObject(App->CL_Mastermind->mcc_Class, NULL

#define MUIA_Mastermind_SpielLaeuft    0x80430010
#define MUIA_Mastermind_Zugzahl        0x80430011

#define MUIM_Mastermind_Bewerten       0x80430020
#define MUIM_Mastermind_NeuesSpiel     0x80430021
#define MUIM_Mastermind_ZeigeAbout     0x80430022
#define MUIM_Mastermind_Einstellungen  0x80430023

struct Mastermind_Data
{
   LONG SpielLaeuft;
   LONG Zugzahl;
   APTR LV_Ausgabefeld;
   APTR POP_Eingabe[4];
   APTR GR_Eingabe;
   APTR BT_Bewerten;
};

struct AusgabefeldNode
{
   TEXT Zug[20];
   TEXT Symbole[200];
   TEXT Bewertung[100];
};

