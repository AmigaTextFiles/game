/* Awalé.c     (c) R.Florac Saint-Vaury, le 9 mars 1991  v1.00
   Adaptation SAS C 6.0 : 21 février 1993, Saint-James
   Adaptation SAS C 6.5 :  4 juin 1995, Chez Corbin (suppression utilisation arp.library)
   Adaptation SAS C 6.58: 27 mars 1999, Chez Corbin (modification gestion appel Workbench) Version 1.2
   Traduction source en anglais: 22 février 2001
*************************************************************/

#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <libraries/asl.h>
#include <libraries/iff.h>
#include <clib/asl_protos.h>
#include <proto/dos.h>
#include <proto/intuition.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/diskfont.h>
#include <proto/icon.h>

#define SetOPen(w,c)    { (w)->AOlPen = c;  (w)->Flags |= AREAOUTLINE; }

/* Définition des constantes */
#define HUMAIN	0
#define MICRO	1

#define PROBLEME -4
#define ABANDONNER -5
#define ANNULATION -6
#define QUITTER -7
#define FIN_DE_PARTIE -8
#define ECHANGER_JEUX -9
#define LIRE_PARTIE -10
#define OUI 1
#define NON 0

#define MAUVE 31
#define BLEU_VIOLACE 30
#define BLEU_FONCE 29
#define BLEU_CIEL 28
#define GRIS_FONCE 27
#define VERT_SALE 26
#define VERT_2 25
#define VERT 24
#define VERT_JAUNE 23
#define JAUNE 22
#define PAILLE 21
#define GRIS_CLAIR 20
#define BEIGE 19
#define MARRON 18
#define ORANGE 17
#define NOIR 16
#define ROSE 15
#define VERT_CLAIR 14
#define VERT_FONCE 13
#define BLEU_CLAIR 12
#define BLANC 11
#define VERT_CLAIR_2 10
#define ROUGE 9
#define VIOLET 8
#define JAUNE_PALE 7
#define VERT_PALE 6

/* Prototypes des routines assembleur */
extern void  __asm echanger (register __a0 short int *, register __a1 short int *);
extern void  __asm copie_tableau (register __a0 short int *, register __a1 short int *);
extern short int __asm aleatoire (register __d1 short int);
extern short int __asm somme_graines (register __d1 short int, register __a0 short int *);
extern short int __asm case_suivante (register __d0 short int);
extern short int __asm semi (register __a0 short int *, register __d1 short int);
extern void __asm Stccpy (register __a1 UBYTE *, register __a0 UBYTE *, register __d0 short int);

/* Variables globales */
struct GfxBase * GfxBase;
struct IntuitionBase * IntuitionBase;
struct Library * DiskfontBase, * IFFBase, *IconBase, * AslBase;
UWORD colortable[128];

/* variables utilisées pour les remplissages */
PLANEPTR Pointeur = 0;	    /* pointeur sur la bitmap */
struct TmpRas StructTmpRas;
short int buffer[20];	    /* buffer nécessaire au tracé de 4 points (3 suffiraient ?) */
struct AreaInfo AreaInfo;

/* image utilisée quand le micro réfléchit */
UWORD chip pointeur_souris[] =
{   0x0000, 0x0000, 0x3FF0, 0x3FF0, 0x7FF8, 0x6018, 0x63F8, 0x5C08, 0x7A38,
    0x45C8, 0x77B8, 0x4848, 0x6F78, 0x5088, 0x62F8, 0x5D08, 0x7E38, 0x41C8,
    0x7FF8, 0x6018, 0x3FF0, 0x3FF0, 0x0000, 0x0000, 0xFFFC, 0xFFFC, 0xFFFC,
    0xBF84, 0xFFFC, 0xFF84, 0xFFFC, 0xFFFC, 0x0000, 0x0000
};

USHORT chip pointeur_B[] =
{	0x0000, 0x0000, 0xFE00, 0xFE00, 0xE700, 0xFF00, 0xE300, 0xF380,
	0xE300, 0xF380, 0xE300, 0xF380, 0xE700, 0xF780, 0xFF00, 0xFF80,
	0xE380, 0xFF80, 0xE380, 0xF3C0, 0xE380, 0xF3C0, 0xE380, 0xF3C0,
	0xE380, 0xF3C0, 0xFF00, 0xFFC0, 0x0000, 0x7F80, 0x0000, 0x0000
};

USHORT chip pointeur_A[] =
{	0x0000, 0x0000, 0x7F00, 0x7F00, 0xE380, 0xFF80, 0xE380, 0xF3C0,
	0xE380, 0xF3C0, 0xE380, 0xF3C0, 0xE380, 0xF3C0, 0xFF80, 0xFFC0,
	0xE380, 0xFFC0, 0xE380, 0xF3C0, 0xE380, 0xF3C0, 0xE380, 0xF3C0,
	0xE380, 0xF3C0, 0xE380, 0xF3C0, 0x0000, 0x71C0, 0x0000, 0x0000
};

UWORD chip microData[75] =
{   0x0000, 0x1FE0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x1FE0,
    0x0000, 0x0000, 0xFFFC, 0xBF84, 0xFF84, 0xFFFC,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
    0x0000, 0x0000, 0xFFFC, 0xFFFC, 0xFFFC, 0xFFFC,
    0x3FF0, 0x7FF8, 0x7CF8, 0x7878, 0x7338, 0x6798, 0x6018, 0x6798, 0x7FF8,
    0x3FF0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
    0x0000, 0x1FE0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x3FF0, 0x1FE0,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
    0x3FF0, 0x7FF8, 0x7CF8, 0x7878, 0x7338, 0x6798, 0x6018, 0x6798, 0x7FF8,
    0x3FF0, 0x0000, 0xFFFC, 0xFFFC, 0xFFFC, 0xFFFC
};

UWORD chip mainData[80] =
{   0x0780, 0x0840, 0x1020, 0x1020, 0x1010, 0x2010, 0x2010, 0x2010, 0x2010,
    0x3490, 0x1490, 0x1490, 0x0E90, 0x0090, 0x0090, 0x0060,
    0x0000, 0x0780, 0x1F80, 0x1FC0, 0x1FE0, 0x1FE0, 0x1FE0, 0x3FE0, 0x1FE0,
    0x0B60, 0x0B60, 0x0B60, 0x0060, 0x0060, 0x0060, 0x0000,
    0x0780, 0x0840, 0x1060, 0x1020, 0x1010, 0x2010, 0x2010, 0x2010, 0x2010,
    0x3490, 0x1490, 0x1490, 0x0F90, 0x0090, 0x0090, 0x0060,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
    0x0780, 0x0840, 0x0060, 0x0020, 0x0010, 0x2010, 0x2010, 0x0010, 0x2010,
    0x3490, 0x1490, 0x1490, 0x0F90, 0x0090, 0x0090, 0x0060
};

UWORD chip humainData[75] =
{   0x0000, 0x0100, 0x1B80, 0x3FC0, 0x7FE0, 0x7770, 0xE670, 0xF9F0, 0x70E0,
    0x70E0, 0x7FC0, 0x3FC0, 0x3F80, 0x1F80, 0x0F00,
    0x3FC0, 0x7FE0, 0xFFF0, 0xFFF0, 0xFFF8, 0xE678, 0xE678, 0xFFF0, 0x7FE0,
    0x7FE0, 0x7FC0, 0x30C0, 0x3980, 0x1F80, 0x0F00,
    0x0000, 0x0000, 0x0100, 0x39C0, 0x7FE0, 0x7FE0, 0x7FE0, 0x79E0, 0x30C0,
    0x30C0, 0x3F80, 0x1080, 0x1900, 0x0F00, 0x0000,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1980, 0x1980, 0x0000, 0x0000,
    0x0000, 0x0000, 0x0900, 0x0600, 0x0000, 0x0000,
    0x3FC0, 0x7EE0, 0xE470, 0xC030, 0x8018, 0x1998, 0x9998, 0x8010, 0x4020,
    0x4020, 0x4040, 0x2640, 0x2080, 0x1080, 0x0F00
};

UWORD chip perdantData[75] =
{   0x0000, 0x0100, 0x1B80, 0x3FC0, 0x7FE0, 0x6670, 0xEF70, 0xFFF0, 0x79E0,
    0x76E0, 0x7FC0, 0x3FC0, 0x3F80, 0x1F80, 0x0F00,
    0x3FC0, 0x7FE0, 0xFFF0, 0xFFF0, 0xFFF8, 0xE678, 0xE678, 0xFFF0, 0x7FE0,
    0x76E0, 0x7FC0, 0x3FC0, 0x3980, 0x1F80, 0x0F00,
    0x0000, 0x0000, 0x0100, 0x39C0, 0x7FE0, 0x7FE0, 0x7FE0, 0x7FE0, 0x39C0,
    0x36C0, 0x3F80, 0x1F80, 0x1900, 0x0F00, 0x0000,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1980, 0x1980, 0x0000, 0x0000,
    0x0000, 0x0000, 0x0000, 0x0600, 0x0000, 0x0000,
    0x3FC0, 0x7EE0, 0xE470, 0xC030, 0x8018, 0x1998, 0x9998, 0x8010, 0x4020,
    0x4920, 0x4040, 0x2040, 0x2080, 0x1080, 0x0F00
};

UWORD chip gagnantData[75] =
{   0x0000, 0x0100, 0x1B80, 0x3FC0, 0x7FE0, 0x7770, 0xE670, 0xFFF0, 0x79F0,
    0x7FE0, 0x7FE0, 0x3FC0, 0x3FC0, 0x1F80, 0x0F00,
    0x3FC0, 0x7FE0, 0xFFF0, 0xFFF0, 0xFFF8, 0xE678, 0xE678, 0xFFF0, 0x7FF0,
    0x7FE0, 0x79E0, 0x36C0, 0x39C0, 0x1F80, 0x0F00,
    0x0000, 0x0000, 0x0100, 0x39C0, 0x7FE0, 0x7FE0, 0x7FE0, 0x7FE0, 0x39E0,
    0x3FC0, 0x39C0, 0x1080, 0x1980, 0x0F00, 0x0000,
    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1980, 0x1980, 0x0000, 0x0000,
    0x0000, 0x0600, 0x0F00, 0x0600, 0x0000, 0x0000,
    0x3FC0, 0x7EE0, 0xE470, 0xC030, 0x8018, 0x1998, 0x9998, 0x8010, 0x4610,
    0x4020, 0x4020, 0x2040, 0x2040, 0x1080, 0x0F00
};

struct Image perdantImage = { 0, 0, 14, 15, 5, &perdantData[0], 0x1F, 0, 0 };
struct Image gagnantImage = { 0, 0, 14, 15, 5, &gagnantData[0], 0x1F, 0, 0 };
struct Image humainImage = { 0, 0, 14, 15, 5, &humainData[0], 0x1F, 0, 0 };
struct Image microImage  = { 0, 0, 14, 15, 5, &microData[0],  0x1F, 0, 0 };
struct Image mainImage =
{   0, 0,	    /* LeftEdge, TopEdge */
    12, 16, 5,	    /* Width, Height, Depth */
    &mainData[0],   /* ImageData */
    0x1F, 0x00,     /* PlanePick, PlaneOnOff */
    NULL	    /* NextImage */
};

struct TextAttr topaz = {   "topaz.font", 8, 0, FPF_ROMFONT    };

struct IntuiText text_10 =
{ VERT_SALE,   /* FrontPen, black. */
  0,		/* BackPen, not used since JAM1. */
  JAM1, 	/* DrawMode, do not change the background. */
  CHECKWIDTH,	/* LeftEdge, CHECKWIDTH amount of pixels out. */
  1,		/* TopEdge, 1 line down. */
  &topaz,	/* TextAttr, default font. */
  "7",          /* IText, the string. */
  NULL		/* NextItem, no link to other IntuiText structures. */
};
struct IntuiText text_11 = { VERT_FONCE,0,JAM1,CHECKWIDTH,1,&topaz,"8",NULL };
struct IntuiText text_9 = { VERT_2,0, JAM1,CHECKWIDTH, 1, &topaz, "6", NULL };
struct IntuiText text_8 = { VERT, 0, JAM1, CHECKWIDTH, 1, &topaz, "5", NULL };
struct IntuiText text_7 = { VERT_CLAIR_2,0, JAM1,CHECKWIDTH, 1, &topaz,"4",NULL };
struct IntuiText text_6 = { VERT_PALE,0,JAM1,CHECKWIDTH,1,&topaz,"3",NULL };
struct IntuiText text_5 = { VERT_CLAIR, 0,JAM1,CHECKWIDTH, 1,&topaz,"2",NULL };
struct IntuiText text_4 = { VERT_JAUNE, 0,JAM1,CHECKWIDTH, 1,&topaz,"1",NULL };

struct IntuiText text_refaire = { VIOLET, 0, JAM1, 2, 1, &topaz, "Refaire", 0 };
struct IntuiText text_arret = { VIOLET, 0, JAM1, 2, 1, &topaz, "Arrêter", 0 };
struct IntuiText text_explications = { VIOLET,0,JAM1,2,1,&topaz,"Explications",0};
struct IntuiText text_tempo  = { VERT_SALE, 0,JAM1,2,1,&topaz,"  Délai ",0 };
struct IntuiText text_ignore = { BLEU_FONCE,0,JAM1,2,1,&topaz,"  Ignore",0 };
struct IntuiText text_souris = { GRIS_FONCE, 0,JAM1,2,1,&topaz,"  Souris",0 };
struct IntuiText text_quitter = { ROUGE, 0, JAM1, 2, 1, &topaz, "Quitter", 0 };
struct IntuiText text_dernier = { BLEU_VIOLACE,0,JAM1,2,1,&topaz,"Dernier coup",0 };
struct IntuiText text_annuler = { VERT_SALE,0,JAM1,2,1,&topaz,"Annulation",0 };
struct IntuiText text_rappel = { VERT_FONCE,0,JAM1,2,1,&topaz,"Rappel",0 };
struct IntuiText text_jeu_micro = { MAUVE, 0,JAM1,2, 1, &topaz, "Jeu Amiga",0 };
struct IntuiText text_conseil = { VERT, 0, JAM1, 2, 1, &topaz, "Conseil", 0 };
struct IntuiText text_echange = { VIOLET, 0,JAM1,2, 1, &topaz, "Echange jeux",0 };
struct IntuiText text_abandon = { NOIR, 0, JAM1, 2, 1, &topaz, "Abandon", 0 };
struct IntuiText text_3 = { 6, 0,  JAM1, 2, 1, &topaz, " Amiga -Humain", 0 };
struct IntuiText text_2 = { ROSE, 0, JAM1, 2, 1, &topaz, " Humain-Amiga ", 0 };
struct IntuiText text_1 = { VERT_FONCE,0, JAM1, 2, 1, &topaz, " Humain-Humain", 0 };
struct IntuiText text_0 = { VERT_SALE,0, JAM1, 2, 1, &topaz, "Début partie", 0 };
struct IntuiText texte_probleme = { MAUVE,0,JAM1,2,1, &topaz, " Problème", 0 };
struct IntuiText text_sauvegarde = { MAUVE, 0,JAM1,2, 1, &topaz, "Sauvegarde",0 };
struct IntuiText text_lecture = { VIOLET, 0,JAM1,2, 1, &topaz, "Lecture",0 };

struct MenuItem menu_sauvegarde = { 0, 2,11, 112,10, COMMSEQ|ITEMTEXT|
    HIGHCOMP, 0, (APTR) &text_sauvegarde, 0, 'W', 0, 0 };
struct MenuItem menu_lecture = { &menu_sauvegarde, 2,1, 112,10, COMMSEQ|ITEMTEXT|ITEMENABLED|
    HIGHCOMP, 0, (APTR) &text_lecture, 0, 'L', 0, 0 };

struct MenuItem menu_2_8 = { 0, 0, 70, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFF7F, (APTR) &text_11, 0, '8', 0, MENUNULL };
struct MenuItem menu_2_7 = { &menu_2_8, 0, 60, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFBF, (APTR) &text_10, 0, '7', 0, MENUNULL };
struct MenuItem menu_2_6 = { &menu_2_7, 0, 50, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFDF, (APTR) &text_9, 0, '6', 0, MENUNULL };
struct MenuItem menu_2_5 = { &menu_2_6, 0, 40, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFEF, (APTR) &text_8, 0, '5', 0, MENUNULL };
struct MenuItem menu_2_4 = { &menu_2_5, 0, 30, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| CHECKED| HIGHCOMP, 0xFFFFFFF7, (APTR) &text_7, 0, '4', 0, MENUNULL   };
struct MenuItem menu_2_3 = { &menu_2_4, 0, 20, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFFB, (APTR) &text_6, 0, '3', 0, MENUNULL };
struct MenuItem menu_2_2 = { &menu_2_3, 0, 10, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFFD, (APTR) &text_5, 0, '2', 0, MENUNULL };
struct MenuItem menu_2_1 = { &menu_2_2, 0, 0, 60, 10, COMMSEQ| ITEMTEXT| ITEMENABLED|
    CHECKIT| HIGHCOMP, 0xFFFFFFFE, (APTR) &text_4, 0, '1', 0, MENUNULL };

struct MenuItem sous_menu_11 = { 0, 104,11,110,10,COMMSEQ|ITEMTEXT|HIGHCOMP
    , 0, (APTR) &text_annuler, 0, 'N', 0, MENUNULL };
struct MenuItem sous_menu_10 = { &sous_menu_11, 104,1,110,10,COMMSEQ|ITEMTEXT
    | HIGHCOMP, 0, (APTR) &text_rappel, 0, 'R',0, MENUNULL };
struct MenuItem sous_menu_3 = { 0,102,21,95,10,COMMSEQ| ITEMTEXT| CHECKED |
    ITEMENABLED | CHECKIT | HIGHCOMP, 0x3, (APTR) &text_tempo, 0,'D',0,MENUNULL };
struct MenuItem sous_menu_2 = { &sous_menu_3,102,11,95,10,COMMSEQ | ITEMTEXT|
    ITEMENABLED | CHECKIT | HIGHCOMP, 0x5, (APTR) &text_souris, 0,'S',0,MENUNULL };
struct MenuItem sous_menu_1 = { &sous_menu_2,102,1,95,10,COMMSEQ|ITEMTEXT|
    ITEMENABLED | CHECKIT | HIGHCOMP, 0x6, (APTR) &text_ignore, 0,'I',0,MENUNULL };

struct MenuItem menu_1_10 =
{   NULL, 2, 70, 130, 10, COMMSEQ| ITEMTEXT| ITEMENABLED| HIGHCOMP, 0,
    (APTR) &text_quitter, 0, 'Q', 0, MENUNULL   };
struct MenuItem menu_1_9 =
{   &menu_1_10, 2, 60, 130, 10, COMMSEQ| ITEMTEXT| ITEMENABLED| HIGHCOMP, 0,
    (APTR) &text_explications, 0, 'X', 0, MENUNULL      };
struct MenuItem menu_1_8 =
{   &menu_1_9, 2, 50, 130, 10, ITEMTEXT| HIGHCOMP| ITEMENABLED,
    0, (APTR) &text_jeu_micro, 0, 0, &sous_menu_1, 0    };
struct MenuItem menu_1_7 =
{   &menu_1_8, 2, 40, 130, 10, ITEMTEXT| HIGHCOMP| ITEMENABLED , 0,
    (APTR) &text_dernier, 0, 0, &sous_menu_10, 0   };
struct MenuItem menu_1_6 =
{   &menu_1_7, 2, 30, 130, 10, ITEMTEXT| HIGHCOMP| COMMSEQ, 0,
    (APTR) &text_echange, 0, 'E', 0, 0    };
struct MenuItem menu_1_5 =
{   &menu_1_6, 2, 20, 130, 10, ITEMTEXT| HIGHCOMP | COMMSEQ, 0,
    (APTR) &text_abandon, 0, 'A', 0, 0  };
struct MenuItem menu_1_4 =
{   &menu_1_5, 2, 10, 130, 10, COMMSEQ| ITEMTEXT| HIGHCOMP, 0,
    (APTR) &text_conseil, 0, 'C', 0, MENUNULL   };

struct MenuItem menu_probleme =
{   0, 107,32, 140, 10, COMMSEQ|ITEMTEXT|ITEMENABLED|HIGHCOMP|CHECKIT, 7,
    (APTR) &texte_probleme, 0, 'P', 0, MENUNULL     };
struct MenuItem menu_1_3 =
{   &menu_probleme, 107, 22, 140, 10, COMMSEQ| ITEMTEXT| ITEMENABLED| HIGHCOMP| CHECKIT,
    11, (APTR) &text_3, NULL, 'M', NULL, MENUNULL    };
struct MenuItem menu_1_2 =
{   &menu_1_3, 107, 12, 140, 10, COMMSEQ| ITEMTEXT| ITEMENABLED| HIGHCOMP| CHECKIT,
    13, (APTR) &text_2, NULL, 'B', NULL, MENUNULL,   };
struct MenuItem menu_1_1 =
{ &menu_1_2,
  107,		    /* LeftEdge */
  2,		    /* TopEdge */
  140,		    /* Width  */
  10,		    /* Height */
  COMMSEQ| ITEMTEXT| ITEMENABLED| HIGHCOMP| CHECKIT, /* Flags */
  14,		    /* MutualExclude */
  (APTR) &text_1,   /* ItemFill */
  NULL, 	    /* SelectFill */
  'H',              /* Command */
  NULL, 	    /* SubItem */
  MENUNULL,	    /* NextSelect */
};

struct MenuItem menu_1_0 =
{   &menu_1_4, 2,0,130,10,ITEMTEXT|ITEMENABLED|HIGHCOMP,0,(APTR) &text_0,
    0,0, &menu_1_1, 0
};

struct Menu menu_disque = { 0, 120, 0, 50, 0, MENUENABLED, "Disque", &menu_lecture };
struct Menu menu_2 = { &menu_disque, 60, 0, 50, 0, MENUENABLED, "Niveau", &menu_2_1 };
struct Menu menu =
{ &menu_2,	/* NextMenu */
  0,		/* LeftEdge */
  0,		/* TopEdge  */
  52,		/* Width    */
  0,		/* Height   */
  MENUENABLED,	/* Flags    */
  "Projet",     /* MenuName */
  &menu_1_0	/* FirstItem */
};

struct MenuItem menu_quitter =
{   0, 2,22, 96,10, COMMSEQ | ITEMTEXT | ITEMENABLED | HIGHCOMP, 0,
    (APTR) &text_quitter, 0, 'Q', 0, 0
};
struct MenuItem menu_refaire =
{   &menu_quitter, 2,12, 96,10, COMMSEQ |ITEMTEXT | ITEMENABLED | HIGHCOMP, 0,
    (APTR) &text_refaire, 0, 'R', 0, 0
};
struct MenuItem menu_arret =
{   &menu_refaire, 2,2, 96,10, COMMSEQ | ITEMTEXT | ITEMENABLED | HIGHCOMP, 0,
    (APTR) &text_arret, 0, 'S', 0, 0
};
struct Menu menu_saisie =
{   0, 0, 0, 100, 0, MENUENABLED, "Distribution", &menu_arret };

UWORD chip ouiData[225] =
{   0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0xC000,
    0xC1C3,0x33F1,0xC000, 0xC363,0x30C1,0xC000, 0xC633,0x30C1,0xC000,
    0xC633,0x30C1,0xC000, 0xC633,0x30C1,0xC000, 0xC363,0x30C1,0xC000,
    0xC1C1,0xF3F1,0xC000, 0xC000,0x0001,0xC000, 0xC000,0x0001,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0x3FFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000,
    0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000, 0x3FFF,0xFFFE,0x0000,
    0x3E3C,0xCC0E,0x0000, 0x3C1C,0x4606,0x0000, 0x384C,0x471E,0x0000,
    0x38C4,0x471E,0x0000, 0x38C4,0x471E,0x0000, 0x3C84,0x471E,0x0000,
    0x3E0E,0x040E,0x0000, 0x3F1F,0x0606,0x0000, 0x3FFF,0xFFFE,0x0000,
    0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFF7F,0x76C7,0x8000, 0xFE7F,0x77DF,0x8000,
    0xFEF7,0x77DF,0x8000, 0xFEF7,0x77DF,0x8000, 0xFFE7,0x77DF,0x8000,
    0xFFCF,0xF7FF,0x8000, 0xFF1F,0x0607,0x8000, 0xFFFF,0xFFFF,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC080,0x8939,0x8000, 0xC180,0x8821,0x8000,
    0xC108,0x8821,0x8000, 0xC108,0x8821,0x8000, 0xC018,0x8821,0x8000,
    0xC030,0x0801,0x8000, 0xC0E0,0xF9F9,0x8000, 0xC000,0x0001,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000
};

UWORD chip nonData[225] =
{   0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0xC000,
    0xC631,0xC631,0xC000, 0xC733,0x6731,0xC000, 0xC7B6,0x37B1,0xC000,
    0xC6F6,0x36F1,0xC000, 0xC676,0x3671,0xC000, 0xC633,0x6631,0xC000,
    0xC631,0xC631,0xC000, 0xC000,0x0001,0xC000, 0xC000,0x0001,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0x3FFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000, 0xC000,0x0001,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000,
    0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000, 0x3FFF,0xFFFE,0x0000,
    0x39CE,0x39CE,0x0000, 0x38C4,0x18C6,0x0000, 0x3840,0xC846,0x0000,
    0x3800,0xC006,0x0000, 0x3880,0xC086,0x0000, 0x38C4,0x80C6,0x0000,
    0x38C6,0x08C6,0x0000, 0x3CE7,0x1CE6,0x0000, 0x3FFF,0xFFFE,0x0000,
    0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000, 0x0000,0x0000,0x0000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFF7,0x7FF7,0x8000, 0xFFF6,0xFFF7,0x8000,
    0xFEF6,0xF6F7,0x8000, 0xFEF6,0xF6F7,0x8000, 0xFEF7,0xE6F7,0x8000,
    0xFEF7,0xCEF7,0x8000, 0xFCE7,0x1CE7,0x8000, 0xFFFF,0xFFFF,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xC000,0x0001,0x8000,
    0xC000,0x0001,0x8000, 0xC008,0x8009,0x8000, 0xC009,0x0009,0x8000,
    0xC109,0x0909,0x8000, 0xC109,0x0909,0x8000, 0xC108,0x1909,0x8000,
    0xC108,0x3109,0x8000, 0xC318,0xE319,0x8000, 0xC000,0x0001,0x8000,
    0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0x0000,0x0000,0x0000
};

UWORD chip Masque[] =
{   0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0x8000, 0xFFFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000,
    0xFFFF,0xFFFF,0xC000, 0xFFFF,0xFFFF,0xC000, 0x3FFF,0xFFFF,0xC000
};

struct Image ImageNon = { 0, 0, 34, 15, 5, &nonData[0], 0x1F, 0x00, NULL  };
struct Image ImageOui = { 0, 0, 34, 15, 5, &ouiData[0], 0x1F, 0x00, NULL };

struct BoolInfo masque = { BOOLMASK, Masque, 0 };

struct Gadget gadget_oui =
{   0, 16,130, 34,15, GADGIMAGE|GADGHCOMP, RELVERIFY|BOOLEXTEND, BOOLGADGET,
    (APTR) &ImageOui, 0, 0, 0, (APTR) &masque, OUI, 0
};
struct Gadget gadget_non =
{   &gadget_oui, 271,130, 34,15, GADGIMAGE|GADGHCOMP, RELVERIFY|BOOLEXTEND, BOOLGADGET,
    (APTR) &ImageNon, 0, 0, 0, (APTR) &masque, NON, 0
};

UWORD chip Image_INT[120] =
{   0x0000,0x0000, 0x7FFF,0xFFFC, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD,
    0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD,
    0x0000,0x0003, 0x3FFF,0xFFFE,
    0x0000,0x0000, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC,
    0x7FFF,0xFFFC, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC, 0x7FFF,0xFFFC,
    0x0000,0x0000, 0x0000,0x0000,
    0x7FFF,0xFFFC, 0x8000,0x0002, 0x8000,0x0003, 0x8000,0x0003, 0x8000,0x0003,
    0x8000,0x0003, 0x8000,0x0003, 0x8000,0x0003, 0x8000,0x0003, 0x8000,0x0003,
    0x7FFF,0xFFFF, 0x3FFF,0xFFFE,
    0x7FFF,0xFFFC, 0xFFFF,0xFFFE, 0xFFFF,0xFFFF, 0xFFFF,0xFFFF, 0xFFFF,0xFFFF,
    0xFFFF,0xFFFF, 0xFFFF,0xFFFF, 0xFFFF,0xFFFF, 0xFFFF,0xFFFF, 0xFFFF,0xFFFF,
    0x7FFF,0xFFFF, 0x3FFF,0xFFFE,
    0x0000,0x0000, 0x7FFF,0xFFFC, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD,
    0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD, 0x7FFF,0xFFFD,
    0x0000,0x0003, 0x3FFF,0xFFFE
};
struct Image ImageINT = { -3,-2, 32,12, 5, &Image_INT[0], 0x1F, 0x00, NULL };

UBYTE buffer_nombre14[3];
UBYTE buffer_nombre13[3];
UBYTE buffer_nombre12[3];
UBYTE buffer_nombre11[3];
UBYTE buffer_nombre10[3];
UBYTE buffer_nombre9[3];
UBYTE buffer_nombre8[3];
UBYTE buffer_nombre7[3];
UBYTE buffer_nombre6[3];
UBYTE buffer_nombre5[3];
UBYTE buffer_nombre4[3];
UBYTE buffer_nombre3[3];
UBYTE buffer_nombre2[3];
UBYTE buffer_nombre1[3];
UBYTE undo_buffer[3];
struct StringInfo string_info_14 =
{   buffer_nombre14, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_13 =
{   buffer_nombre13, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_12 =
{   buffer_nombre12, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_11 =
{   buffer_nombre11, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_10 =
{   buffer_nombre10, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_9 =
{   buffer_nombre9, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_8 =
{   buffer_nombre8, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_7 =
{   buffer_nombre7, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_6 =
{   buffer_nombre6, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_5 =
{   buffer_nombre5, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_4 =
{   buffer_nombre4, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_3 =
{   buffer_nombre3, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_2 =
{   buffer_nombre2, undo_buffer, 0, 3, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL,  };
struct StringInfo string_info_1 =
{   buffer_nombre1, /* Buffer, pointer to a null-terminated string. */
    undo_buffer,    /* UndoBuffer, pointer to a null-terminated string. */
    0,	    /* BufferPos */
    3,	    /* MaxChars  */
    0,	    /* DispPos	 */
    0,	    /* UndoPos	 */
    0,	    /* NumChars  */
    0,	    /* DispCount */
    0, 0,   /* CLeft, CTop */
    NULL,   /* LayerPtr  */
    NULL,   /* LongInt	 */
    NULL,   /* AltKeyMap */
};

struct Gadget gadget_14 = { 0, 282,28,30,8,GADGIMAGE, RELVERIFY| LONGINT,
    STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_14,
    13, NULL };
struct Gadget gadget_13 = { &gadget_14, 282,240,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL,0,NULL,(APTR) &string_info_13,
    12, NULL };
struct Gadget gadget_12 = { &gadget_13, 21,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_12,
    11, NULL };
struct Gadget gadget_11 = { &gadget_12, 71,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_11,
    10, NULL };
struct Gadget gadget_10 = { &gadget_11, 121,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_10,
    9, NULL };
struct Gadget gadget_9 = { &gadget_10, 171,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_9,
    8, NULL };
struct Gadget gadget_8 = { &gadget_9, 221,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_8,
    7, NULL };
struct Gadget gadget_7 = { &gadget_8, 271,51,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_7,
    6, NULL };
struct Gadget gadget_6 = { &gadget_7, 271,157,30,8,GADGIMAGE,RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_6,
    5, NULL };
struct Gadget gadget_5 = { &gadget_6, 221,157,30,8,GADGIMAGE,GADGIMMEDIATE|RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_5,
    4, NULL };
struct Gadget gadget_4 = { &gadget_5, 171,157,30,8,GADGIMAGE,GADGIMMEDIATE|RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_4,
    3, NULL };
struct Gadget gadget_3 = { &gadget_4, 121,157,30,8,GADGIMAGE,GADGIMMEDIATE|RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_3,
    2, NULL };
struct Gadget gadget_2 = { &gadget_3, 71,157,30,8,GADGIMAGE,GADGIMMEDIATE|RELVERIFY|
    LONGINT, STRGADGET, (APTR) &ImageINT, NULL, 0, NULL, (APTR) &string_info_2,
    1, NULL };
struct Gadget gadget_1 =
{   &gadget_2,				    /* NextGadget */
    21, 				    /* LeftEdge */
    157,				    /* TopEdge	*/
    30, 				    /* Width	*/
    8,					    /* Height	*/
    GADGIMAGE,				    /* Flags */
    GADGIMMEDIATE| RELVERIFY| LONGINT,	    /* An Integer gadget. */
    STRGADGET,				    /* GadgetType, a String gadget. */
    (APTR) &ImageINT,                       /* GadgetRender */
    NULL,				    /* SelectRender */
    0,					    /* GadgetText   */
    NULL,				    /* MutualExclude */
    (APTR) &string_info_1,                  /* SpecialInfo */
    0,					    /* GadgetID */
    NULL				    /* UserData */
};

struct NewScreen newscreen =
{   0, 0, 0, 0, 0, 0, 0, NULL, CUSTOMSCREEN, &topaz, (STRPTR)"Awalé", NULL, NULL
};

struct NewWindow newwindow =
{   0,0,320,256,MARRON,BLANC, GADGETUP | MOUSEBUTTONS | MENUPICK, ACTIVATE | BORDERLESS,
    0,0,0,0,0,0,0,0,0,CUSTOMSCREEN
};

struct NewWindow fenetre_explications =
{   0,0,320,256,1,0,CLOSEWINDOW,RMBTRAP|ACTIVATE|WINDOWCLOSE | BORDERLESS,
    0,0,0,0,0,0,0,0,0,CUSTOMSCREEN
};

struct Screen * screen = NULL;
struct Window * win = NULL;
struct RastPort * rastport;
IFFL_HANDLE fichier_IFF = NULL;

void  __regargs ajouter_graine(short int,short int);
void  __regargs init_graines(short int);
short int __regargs coup_suivant(short int *,short int,short int,short int);

short int graines[12], presence_main=-1, indication_jeu=2;
short int gains[2] = { 0,0 }, dernier_coup=-1, couleur[12][48], prise[2][48];
short int graines_jouees[100][12], coups_joues[100], nbre_coups_joues=0, joueurs=-1;
short int coups_enregistres, partie=0, niveau;

struct FileRequester * fichier;

BOOL __regargs ChoixFichier (UBYTE * titre, UBYTE * nom)
{
    STATIC struct TagItem tag[]  = { /* ASL_File, 0, ASL_Dir, 0, */ ASL_Height, 192, ASL_TopEdge, 5, ASL_LeftEdge, 0, TAG_DONE };
    STATIC struct TagItem tags[] = { ASL_Hail, 0, ASL_Window, 0, ASL_FuncFlags, 0, ASL_OKText, (LONG) "VALIDE", ASL_CancelText, (LONG) "ANNULE", ASLFR_Flags2, FRF_REJECTICONS, TAG_DONE };

    if (fichier == 0)
    {	fichier = AllocAslRequest (ASL_FileRequest, tag);
	if (fichier == 0)
	    return 0;
    }
    tags[0].ti_Data = (LONG) titre;
    tags[1].ti_Data = (LONG) win;
    ClearPointer (win);
    if (*titre == 'S')
	tags[2].ti_Data = FILF_SAVE | FILF_PATGAD;
    else
	tags[2].ti_Data = FILF_PATGAD;
    if (AslRequest (fichier, tags))
    {	Stccpy (nom, fichier->fr_Drawer, 128);  AddPart (nom, fichier->fr_File, 128);
	return 1;
    }
    return 0;
}

void __regargs affichage (char * texte, unsigned short int couleur)
{
    unsigned short int longueur_texte = TextLength (rastport, texte, strlen(texte));

    SetAPen (rastport,0);
    SetOPen (rastport,0);
    RectFill (rastport, 13, 129, 306, 145);     /* vide la fenêtre */
    SetDrMd (rastport, JAM1);
    Move (rastport, 161-(longueur_texte/2), 142);
    SetAPen (rastport,NOIR);
    Text (rastport, texte, strlen(texte));
    Move (rastport, 160-(longueur_texte/2), 141);
    SetAPen (rastport, couleur);
    Text (rastport, texte, strlen(texte));
    SetDrMd (rastport, JAM2);
}

void MemCleanup (void) {}

short int __regargs enregistrement (short int coup, short int coup_joue)
{
    short int i,  j;

    coups_joues[coup] = coup_joue;
    for (i = 0;  i < 12;  i++)
	graines_jouees[coup][i] = graines[i];
    if (++coup > 99)
    {	for (i=0; i<99; i++)
	{   coups_joues[i] = coups_joues[i+1];
	    for (j=0; j<12; j++)
		graines_jouees[i][j] = graines_jouees[i+1][j];
	}
	coup--;
    }
    return coup;
}

void __regargs affichage_gagnant (short int joueur)
{
    if (joueurs == HUMAIN  ||  joueur == HUMAIN)
    {	DrawImage (rastport, &gagnantImage, 35, 130);
	DrawImage (rastport, &gagnantImage, 270, 130);
	return;
    }
    DrawImage (rastport, &microImage, 270, 130);
    if (joueur == MICRO)
	DrawImage (rastport, &microImage, 35, 130);
    else
	DrawImage (rastport, &gagnantImage, 35, 130);
}

void __regargs determination_emplacement (short int Case, short int graine, short int * x, short int * y)
{
    if (Case > 5)
    {	*x = (11 - Case);   *y = 115;   }
    else
    {	*x = Case;	    *y = 221;	}
    *x = (*x * 50) + 22 + (graine & 3)*8;
    *y -= (graine/4)*8;
}

LONG détermination_niveau (void)
{
    struct MenuItem *menu = &menu_2_1;
    short int i, cases_occupees=0, graines_restantes=48-gains[0]-gains[1], j=0;

    for (i = 6;  i < 12;  i++)
	if (graines[i])
	    cases_occupees++;
    if (cases_occupees < 2)
	return 0;
    for (i = 0;  i < 6;  i++)
	if (graines[i])
	    cases_occupees++;
    if (cases_occupees < 6) j++;
    if (graines_restantes < 20) j++;
    if (graines_restantes < 10) j++;
    if (graines_restantes < 5) j++;
    i=0;
    do
    {	if (menu->Flags & CHECKED)
	{   niveau=i;	return i+j; }
	menu = menu->NextItem;	i++;
    }
    while (menu);
    return 0;
}

void __regargs sauvegarde_partie (short int joueur)
{   char nom_fichier[300], entete[]="Awalé1.0";
    BOOL reponse;
    BPTR fichier;
    short int octets_ecrits;
    affichage ("Sauvegarde de la partie", BLEU_VIOLACE);
    ClearMenuStrip (win);
    reponse = ChoixFichier ("Sauvegarde partie en cours", nom_fichier);
    if (reponse  &&  *nom_fichier)
    {	fichier = Open (nom_fichier, MODE_NEWFILE);
	if (fichier)
	{   détermination_niveau();
	    if ((octets_ecrits = Write (fichier,entete,8)) == 8)
	    if ((octets_ecrits += Write (fichier,&joueurs,2)) == 10)
	    if ((octets_ecrits += Write (fichier,&joueur,2)) == 12)
	    if ((octets_ecrits += Write (fichier,&gains,4)) == 16)
	    if ((octets_ecrits += Write (fichier,&graines,24)) == 40)
	    if ((octets_ecrits += Write (fichier,&dernier_coup,2)) == 42)
	    if ((octets_ecrits += Write (fichier,&couleur,1152)) ==1194)
	    if ((octets_ecrits += Write (fichier,&prise,192)) == 1386)
	    if ((octets_ecrits += Write (fichier,&graines_jouees,2400))==3786)
	    if ((octets_ecrits += Write (fichier,&coups_joues,200)) == 3986)
	    if ((octets_ecrits += Write (fichier,&partie,2)) == 3988)
	    if ((octets_ecrits += Write (fichier,&coups_enregistres,2)) == 3990)
	    if ((octets_ecrits += Write (fichier,&niveau,2)) == 3992)
	    if ((octets_ecrits += Write (fichier,&indication_jeu,2)) == 3994)
		octets_ecrits  += Write (fichier,&nbre_coups_joues,2);
	    Close (fichier);
	}
	if (octets_ecrits == 3996)
	    affichage ("Partie sauvegardée", VERT_2);
	else
	    affichage ("Erreur sauvegarde", ROUGE);
    }
    else
	affichage ("Opération annulée", VERT);
    SetMenuStrip (win, &menu);
}

void __regargs mise_a_jour_mode (long indice)
{
    long i;
    struct MenuItem * menu = &sous_menu_1;

    for (i = 0;  i < 3;  i++)
    {	if (i == indice)
	{   menu->Flags |= CHECKED;
	    indication_jeu = i;
	}
	else
	    menu->Flags &= ~CHECKED;
	menu = menu->NextItem;
    }
}

short int calcul_nbre_graines (void)
{
    register short int nbre_graines=0, Case;

    for (Case = 0;  Case < 12;  Case++)
	nbre_graines += graines[Case];
    nbre_graines += gains[0];
    nbre_graines += gains[1];
    return nbre_graines;
}

short int __regargs lecture_partie (short int * joueur)
{
    char nom_fichier[300], entete[9];
    BOOL reponse;
    short int i, octets_lus;
    BPTR fichier;
    struct MenuItem *menu = &menu_2_1;

    affichage ("Lecture partie sur disque", BLEU_VIOLACE);
    ClearMenuStrip (win);
    reponse = ChoixFichier ("Lecture partie Awalé", nom_fichier);
    if (reponse  &&  *nom_fichier)
    {  // mise_en_forme (nom_fichier);
	fichier = Open (nom_fichier, MODE_OLDFILE);
	if (fichier)
	{   octets_lus = Read (fichier,entete,8);
	    *(entete+8)=0;
	    if (octets_lus!=8  ||  strcmp(entete,"Awalé1.0")!=0)
	    {	affichage ("Mauvais type de fichier",ROUGE);
		Close (fichier);
		return 0;
	    }
	    else
	    {	init_graines (0);
		if ((octets_lus += Read (fichier,&joueurs,2))==10)
		if ((octets_lus += Read (fichier,&i,2))== 12)
		if ((octets_lus += Read (fichier,&gains,4)) == 16)
		if ((octets_lus += Read (fichier,&graines,24)) == 40)
		if ((octets_lus += Read (fichier,&dernier_coup,2)) == 42)
		if ((octets_lus += Read (fichier,&couleur,1152)) == 1194)
		if ((octets_lus += Read (fichier,&prise,192)) == 1386)
		if ((octets_lus += Read (fichier,&graines_jouees,2400))==3786)
		if ((octets_lus += Read (fichier,&coups_joues,200)) == 3986)
		if ((octets_lus += Read (fichier,&partie,2)) == 3988)
		if ((octets_lus += Read (fichier,&coups_enregistres,2)) == 3990)
		if ((octets_lus += Read (fichier,&niveau,2)) == 3992)
		if ((octets_lus += Read (fichier,&indication_jeu,2)) == 3994)
		    octets_lus	+= Read (fichier,&nbre_coups_joues,2);
		Close (fichier);
	    }
	}
	else
	{   affichage ("Erreur ouverture fichier", ROUGE);
	    return 0;
	}
    }
    else
    {	affichage ("Erreur choix fichier", ROUGE);
	return 0;
    }
    *joueur = i;
    i = calcul_nbre_graines();
    if (octets_lus == 3996  &&  i < 49  &&  i > 0)
    {	i=0;
	while (menu)            /* Mise à jour niveau */
	{   if ((i++) == niveau)
		menu->Flags |= CHECKED;
	    else
		menu->Flags &= ~CHECKED;
	    menu = menu->NextItem;
	}
	mise_a_jour_mode (indication_jeu);
	return 1;
    }
    else
    {	affichage ("Erreur lecture fichier",ROUGE);
	return -1;
    }
}

void __regargs explications (void)
{   short int i;
    unsigned short int longueur_phrase;
    char *texte[] = {
    "L'awalé est un jeu africain",
    "Ce jeu se pratique à deux. Chacun",
    "des joueurs possède 6 cases",
    "dans lesquelles se trouvent 4 graines.",
    "Les règles sont les suivantes:",
    "- le jeu se déroule dans le sens inverse",
    "des aiguilles d'une montre.",
    "- les adversaires jouent à tour de rôle:",
    "les graines de la case jouée sont semées",
    "une par une dans le sens indiqué",
    "Si la case jouée contient plus de onze",
    "graines, un second tour est effectué en",
    "sautant cependant la case d'origine.",
    "- si la dernière graine est déposée dans",
    "une case contenant 1 ou 2 graines du",
    "camp adverse, ces graines ainsi que",
    "celles des cases précédentes dans le",
    "même cas reviennent au joueur (gains).",
    "Le premier qui a ainsi gagné plus de",
    "24 graines a gagné la partie.",
    "Si à un moment donné l'un des joueurs",
    "n'a plus de graines dans son camp,",
    "son adversaire est dans l'obligation",
    "de lui en donner, si cela n'est pas",
    "possible, la partie est terminée." };
    short int couleur[] = { BLEU_CIEL, PAILLE, PAILLE, PAILLE, ROUGE, VERT_CLAIR,
    VERT_CLAIR,BLEU_CLAIR,BLEU_CLAIR,BLEU_CLAIR,BLEU_CIEL,BLEU_CIEL,BLEU_CIEL,
    VERT,VERT,VERT,VERT,VERT,ROUGE,ROUGE,BEIGE,BEIGE,BEIGE,BEIGE,BEIGE };
    struct Window * win;
    struct IntuiMessage *message;
    if ((win = OpenWindow (&fenetre_explications)) == 0)
	return;
    for (i=0;i<25;i++)
    {	longueur_phrase = TextLength (win->RPort, texte[i], strlen(texte[i]));
	SetAPen (win->RPort, couleur[i]);
	Move (win->RPort, 160 - (longueur_phrase/2), (i+1) * 10 - 3);
	Text (win->RPort, texte[i], strlen(texte[i]));
    }
    Wait (1L << win->UserPort->mp_SigBit);
    message = (struct IntuiMessage *) GetMsg(win->UserPort);
    if (message)
	ReplyMsg ((struct Message *) message);
    CloseWindow (win);
}

LONG __regargs adversaire (short int joueur)
{
    return joueur ? 0 : 1;
}

void __regargs mise_a_jour_partie (short int rang)
{   struct MenuItem * menu = &menu_1_1;
    short int i = 0;
    do
    {	if (rang == i)
	    menu -> Flags |= CHECKED;
	else
	    menu -> Flags &= ~CHECKED;
	++i;
	menu = menu -> NextItem;
    }
    while (menu);
}

static void __regargs choix_niveau (char * level)
{
    struct MenuItem * menu = &menu_2_1;
    long i, n;

    if (* level)
    {
	n = atoi (level);
	if (n > 0  &&  n < 9)
	    for (i = 1;  i < 9;  i++)
	    {	if (i == n)
		    menu->Flags |= CHECKED;
		else
		    menu->Flags &= ~CHECKED;
		menu = menu->NextItem;
	    }
    }
}

void __regargs init_pointeur (short int joueur)
{
    if (joueur == 1)
	if (joueurs == HUMAIN)
	    SetPointer (win, pointeur_B, 14L, 10L, -5, -6);
	else
	    SetPointer (win, pointeur_souris, 15L, 14L, NULL, NULL);
    else
	SetPointer (win, pointeur_A, 14L, 10L, -5, -6);
}

void effacer_main (void)
{
    short int x, y;

    if (presence_main >= 0)
    {
	determination_emplacement (presence_main, 0, &x, &y);
	SetAPen (rastport, 0);
	RectFill (rastport, x+8, y-67, x+19, y-52);
	presence_main = -1;
    }
}

void __regargs afficher_joueur (short int x, short int y, short int joueur)
{
    if (gains[joueur] > gains[adversaire(joueur)])
	DrawImage (rastport, &gagnantImage, x, y);
    else if (gains[joueur] == gains[adversaire(joueur)])
	DrawImage (rastport, &humainImage, x, y);
    else
	DrawImage (rastport, &perdantImage, x, y);
}

void __regargs affichage_joueur (short int joueur)
{
    SetAPen (rastport, 0);
    SetOPen (rastport, 0);
    if (gains[1] < 36)
	RectFill (rastport, 294, 236, 307, 250);
    if (gains[0] < 36)
	RectFill (rastport, 294, 24, 307, 38);
    init_pointeur (joueur);
    effacer_main();
    if (joueur == 1)    /* C'est au joueur B de joueur */
    {	if (joueurs == HUMAIN)
	{   affichage ("C'est au joueur B de jouer", 14);
	    SetPointer (win,pointeur_B, 14L, 10L, -5, -6);
	    if (gains[1] < 36)
		afficher_joueur (294, 24, 1);
	}
	else if (gains[1]<36)
	    DrawImage (rastport, &microImage, 294, 24);
    }
    if (joueur == 0)    /* C'est au tour du joueur A */
    {	if (joueurs == HUMAIN)
	    affichage ("C'est au joueur A de jouer",14);
	else
	    affichage ("C'est à vous de jouer",14);
	SetPointer (win, pointeur_A, 14L, 10L, -5, -6);
	if (gains[0] < 36)
	    afficher_joueur (294, 236, 0);
    }
    if (joueur == 2)    /* Il faut afficher les deux */
    {	afficher_joueur (294, 236, 0);
	if (joueurs == HUMAIN)
	{   if (gains[1]<36)
		afficher_joueur (294, 24, 1);
	}
	else if (gains[1] < 36)
	    DrawImage (rastport, &microImage, 294, 24);
    }
}

void __regargs affichage_graine (short int x, short int y, short int couleur)
{
    SetAPen (rastport, couleur);
    SetOPen (rastport, couleur);
    AreaMove (rastport, x, y);
    AreaDraw (rastport, x, y);
    AreaEllipse (rastport, x, y, 3, 3);
    AreaEnd (rastport);
}

void __regargs dessiner (short int Case, short int graine, short int couleur_graine)
{   short int colonne,ligne;
    determination_emplacement (Case, graine, &colonne, &ligne);
    affichage_graine (colonne, ligne, couleur_graine);
    couleur[Case][graine]=couleur_graine;
}

void __regargs effacer (short int Case, short int graine)
{
    dessiner (Case, graine, 0);
}

void __regargs vider (short int Case)
{
    short int nbre_graines = graines[Case];

    while (nbre_graines > 0)
	effacer (Case,--nbre_graines);
    graines[Case] = 0;
}

void affichage_des_graines (void)
{
    short int Case, graine;

    for (Case = 0;  Case < 12;  Case++)
	for (graine = 0;  graine < graines[Case];  graine++)
	    dessiner (Case, graine, couleur[Case][graine]);
    graine = gains[0];	gains[0]=0;
    while (gains[0] < graine)
	ajouter_graine (0, prise[0][gains[0]]);
    graine = gains[1];	gains[1]=0;
    while (gains[1] < graine)
	ajouter_graine (1, prise[1][gains[1]]);
}

void __regargs enlever_graine (short int joueur)
{
    short int prises, colonne=11, ligne;

    prises = --gains[joueur];
    colonne += (8 * prises);
    if (joueur == 0)
	ligne = 243;
    else
	ligne = 31;
    affichage_graine (colonne, ligne, 0);
}

void __regargs init_graines (short int temoin)      /* initialisation du nombre de graines par case */
{
    short int Case, graine;

    /* effacement éventuel des graines déjà présentes */
    for (Case = 0;  Case < 12;  Case++)
    {	vider (Case);
	if (temoin)
	{   graines[Case]=4;	graines_jouees[0][Case]=4;  }
    }

    /* suppression des gains éventuels */
    while (gains[0] > 0)
	enlever_graine (0);
    while (gains[1] > 0)
	enlever_graine (1);

    /* affichage des graines */
    if (temoin)
	for (Case = 0;  Case < 12;  Case++)
	   for (graine = 0;  graine < 4;  graine++)
		dessiner (Case, graine, 20+Case);

    enregistrement (0, 0);
    dernier_coup = -1;
}

void __regargs inversion_jeux (void)
{
    short int i;

    for (i = 0;  i < 6;  i++)
	echanger (&graines[i], &graines[i+6]);
}

void __regargs ajouter_graine (short int joueur, short int couleur)
{
    short int prises,colonne=11,ligne;

    prise[joueur][gains[joueur]] = couleur;
    prises = gains[joueur]++;
    if (prises == 36)
    {	SetAPen (rastport, 0);
	SetOPen (rastport, 0);
	if (joueur == 1)
	    RectFill (rastport, 294, 236, 307, 250);
	else
	    RectFill (rastport, 294, 24, 307, 38);
    }
    colonne += (8 * prises);
    if (joueur == 0)
	ligne=243;
    else
	ligne=31;
    affichage_graine (colonne, ligne, couleur);
}

short int __regargs echange_jeux (short int coups)
{
    short int i, graine, Case, couleur_graine;

    dernier_coup = coups_joues[coups-1];
    /* inversion des graines dans le jeu, effacement à l'écran */
    for (Case = 0;  Case < 6;  Case++)
	for (graine = 0;  graine < graines[Case]  ||  graine < graines[Case+6];  graine++)
	{   couleur_graine = couleur[Case][graine];
	    effacer (Case,graine);
	    couleur [Case][graine] = couleur [6+Case][graine];
	    effacer (Case+6,graine);
	    couleur [6+Case][graine] = couleur_graine;
	}
    /* inversion des prises */
    if (gains[0] > gains[1])
	graine = gains[0];
    else
	graine = gains[1];
    Case=gains[0];
    couleur_graine=gains[1];
    for ( ;graine > 0;  graine--)
    {	echanger (&prise[0][graine-1], &prise[1][graine-1]);
	if (graine <= gains[0])
	    enlever_graine(0);
	if (graine <= gains[1])
	    enlever_graine(1);
    }
    while (gains[0] < couleur_graine)
	ajouter_graine (0, prise[0][gains[0]]);
    while (gains[1] < Case)
	ajouter_graine (1, prise[1][gains[1]]);
    /* remise à jour des tableaux permettant l'annulation des coups précédents */
    for (i = 0;  i < coups;  i++)
    {	for (Case = 0;  Case < 6;  Case++)
	    echanger (&graines_jouees[i][Case], &graines_jouees[i][Case+6]);
	if (coups_joues[i] < 6)
	    coups_joues[i]+=6;
	else
	    coups_joues[i]-=6;
    }
    /* réaffichage des graines à l'écran */
    inversion_jeux();
    for (Case = 0;  Case < 12;  Case++)
	for (graine=0;  graine < graines[Case];  graine++)
	    dessiner (Case, graine, couleur[Case][graine]);
    if (dernier_coup < 6)
	return (short) (dernier_coup + 6);
    else
	return (short) (dernier_coup - 6);
}

/* transfert d'une graine parmi les gains d'un des joueurs (prise) */
void __regargs transferer (short int Case, short int joueur)
{
    short int couleur_graine;

    while (graines[Case] > 0)
    {	couleur_graine = couleur[Case][--graines[Case]];
	effacer (Case, graines[Case]);
	ajouter_graine (joueur, couleur_graine);
	Delay (10);
    }
}

void __regargs distribution (short int case_jouee)
{
    short int couleur_graine, nbre_graines=graines[case_jouee], Case=case_jouee;

    if (case_jouee<0  ||  case_jouee>11)
	return;

    /* semi des graines */
    while (nbre_graines>0)
    {	couleur_graine = couleur[case_jouee][--nbre_graines];
	effacer(case_jouee,nbre_graines);
	do
	    Case = case_suivante(Case);
	while (Case == case_jouee);
	dessiner (Case, graines[Case], couleur_graine);
	graines[Case]++;
	graines[case_jouee]--;
    }
    if (case_jouee < 6)     /* Détermination des prises éventuelles */
    {
	while (Case > 5  &&  Case < 12)
	    if (graines[Case] == 2  ||  graines[Case] == 3)
		transferer (Case--, 0);
	    else
		Case = 12;
    }
    else
    {
	while (Case >= 0  &&  Case < 6)
	    if (graines[Case] == 2  ||  graines[Case] == 3)
		transferer (Case--, 1);
	    else
		Case = 12;
    }
}

short int __regargs reponse (short int tableau[12], short int niveau, short int gains_joueur, short int gains_micro)
{
    short int i, case_testee, note[6], nbre_graines[12], prises, meilleure_note;

    for (case_testee = 0;  case_testee < 6;  case_testee++)
    {	if (tableau[case_testee] == 0)
	    note[case_testee] = -25000;
	else
	{   if (somme_graines (12, nbre_graines) == 0  &&  tableau[case_testee] < 6-case_testee)
	    /* le joueur doit donner à manger, case non jouable */
		note[case_testee] = -25000;
	    else
	    {	copie_tableau (tableau, nbre_graines);
		prises = semi (nbre_graines, case_testee);
		if (prises + gains_joueur > 24) /* coup perdant pour le micro */
		{   note[case_testee] = 10000+prises;
		    niveau = 0;
		}
		else
		if (somme_graines (12, nbre_graines))
		{   note[case_testee] = prises * (15+niveau);
		    if (niveau > 0)
			note[case_testee] -= coup_suivant (nbre_graines, niveau-1, gains_joueur+prises, gains_micro);
		}
		else
		    note[case_testee] = -25000;
	    }
	}
    }
    /* détermination de la meilleure note,choix d'une case */
    meilleure_note = -30000;
    for (i = 0;  i < 6;  i++)
	if (note[i] > meilleure_note)
	    meilleure_note = note[i];
    if (meilleure_note > -25000)
	return meilleure_note;
    else
    if (gains_joueur > gains_micro)
	return 8000;
    if (gains_joueur == gains_micro)
	return 0;
    return -8000;
}

short int __regargs coup_suivant (short int tableau[12], short int niveau, short int gains_joueur, short int gains_micro)
{   short int i,case_testee,note[12],nbre_graines[12],prises,meilleure_note;
    for (case_testee = 6;  case_testee < 12;  case_testee++)
    {	if (tableau[case_testee] == 0)
	    note[case_testee] = -25000; 	/* case vide */
	else
	{   if (somme_graines (0, tableau) == 0  &&  tableau[case_testee] < 12-case_testee)
		note[case_testee] = -25000;	/* il faut donner à manger */
	    else
	    {	copie_tableau (tableau, nbre_graines);
		prises = semi (nbre_graines, case_testee);
		if (somme_graines (0, nbre_graines))
		{   note[case_testee] = prises * (15+niveau);
		    if (gains_micro + prises > 24)
		    {	note[case_testee] += 10000;
			niveau = 0;
		    }
		    else
		    if (niveau > 0)
			note[case_testee] -= reponse (nbre_graines, niveau-1, gains_joueur, gains_micro + prises);
		}
		else
		    note[case_testee] = -25000;
	    }
	}
    }
    /* détermination de la meilleure note,choix d'une case */
    meilleure_note = -30000;
    for (i=6;i<12;i++)
	if (note[i] > meilleure_note)
	    meilleure_note = note[i];
    if (meilleure_note > -25000)
	return meilleure_note;
    if (gains_joueur < gains_micro)
	return 8000;
    if (gains_joueur == gains_micro)
	return 0;
    return -8000;
}

short int __regargs jeu_amiga (short int tableau[12], short int niveau)
{
    register short int case_testee, prises, nbre_graines[12];
    short int note[12], meilleure_note, case_choisie;

    if (nbre_coups_joues == 0)
	return (short) (aleatoire(6) + 6);
    for (case_testee = 6;  case_testee < 12;  case_testee++)
    {	if (tableau[case_testee] == 0)      /* la case est vide, donc injouable */
	    note[case_testee] = -25000;
	else
	{   copie_tableau (tableau,nbre_graines);
	    if (somme_graines (0, nbre_graines) == 0  &&  nbre_graines[case_testee] < 12-case_testee)
		/* impossible de jouer cette case: il faut donner à manger */
		note[case_testee] = -25000;
	    else
	    {	prises = semi (nbre_graines, case_testee);
		if (gains[MICRO]+prises > 24)
		{   note[case_testee] = 25000+prises;	    /* coup gagnant */
		    niveau = 0;
		}
		else
		{   if (somme_graines (0, nbre_graines) == 0)
			/* case déconseillée (reste aucune graine au joueur) */
			note[case_testee] = -25000;
		    else
		    {	note[case_testee] = prises * (15+niveau);
			if (niveau > 0)
			    note[case_testee] -= reponse (nbre_graines, niveau-1, gains[HUMAIN], gains[MICRO]+prises);
		    }
		}
	    }
	}
    }
    /* détermination de la meilleure note,choix d'une case */
    meilleure_note = -30000;
    for (case_testee = 6;  case_testee < 12;  case_testee++)
    {	copie_tableau (tableau,nbre_graines);
	if (note[case_testee]  >  meilleure_note)
	{   meilleure_note = note[case_testee];
	    case_choisie = case_testee;
	    prises = semi (nbre_graines, case_testee);
	}
	else if (note[case_testee] == meilleure_note)
	{   if (gains[MICRO] > gains[HUMAIN])
	    {	if (semi (nbre_graines, case_testee)  >  prises)
		{   prises = semi (nbre_graines, case_testee);
		    case_choisie = case_testee;
		    continue;
		}
		else
		if (semi (nbre_graines, case_testee)  <  prises)
		    continue;
	    }
	    else
	    if (gains[MICRO] < gains[HUMAIN])
	    {	if (semi (nbre_graines, case_testee)  <  prises)
		{   prises = semi (nbre_graines, case_testee);
		    case_choisie = case_testee;
		    continue;
		}
		else
		if (semi (nbre_graines, case_testee)  >  prises)
		    continue;
	    }
	    if (tableau[case_testee] < tableau[case_choisie])
	    {	prises = semi (nbre_graines, case_testee);
		case_choisie = case_testee;
	    }
	    else
	    if (tableau[case_testee] == tableau[case_choisie]  &&  (aleatoire(10)>4))
	    {	prises = semi(nbre_graines,case_testee);
		case_choisie = case_testee;
	    }
	}
    }
    return case_choisie;
}

short int __regargs controle (short int coup, short int joueur)
{
    short int nbre_graines[12], mini, maxi, adversaire;

    if (coup == 12)
    {	affichage ("Cliquez au centre d'une case S.V.P.",17);
	Delay(75);  return -1;
    }
    if (joueur == 0)
    {	mini = 0;   maxi = 5;	adversaire = 12; }
    else
    {	mini =6;    maxi = 11;	adversaire = 0; }
    if (coup < mini  ||  coup > maxi)
    {	affichage ("Choisissez une case dans votre camp",17);
	Delay (75); return -1;
    }
    if (graines[coup] == 0)
    {	affichage ("Cette case est vide !",9);
	Delay (75);
	return -1;
    }
    copie_tableau (graines, nbre_graines);
    semi (nbre_graines, coup);
    if (somme_graines (adversaire, nbre_graines) == 0)
    {	if (graines[coup] + coup  >  5 + joueur*6)
	{   affichage ("Cette case ne peut être jouée", BLEU_CIEL);
	    Delay (45);
	    affichage ("vous reprenez TOUTES les graines", BLEU_CIEL);
	    Delay (45);
	}
	affichage ("Vous devez donner à manger !",9);
	Delay (75);
	return -1;
    }
    return coup;
}

struct IntuiMessage * __regargs elimination_messages (void)
{
    struct IntuiMessage *message;

    do
    {	message = (struct IntuiMessage *) GetMsg (win->UserPort);
	if (message)
	{
	    if (message->Class == MENUPICK)
		return message;
	    ReplyMsg ((struct Message *) (message));
	}
    }
    while (message);
    return 0;
}

static struct IntuiMessage * __regargs attente_message (void)
{
    Wait (1L << win->UserPort->mp_SigBit);
    return (struct IntuiMessage *) GetMsg (win->UserPort);
}

short int __regargs jeu_micro (short int joueur)
{   short int coup_joue;
    ClearMenuStrip (win);
    SetPointer (win, pointeur_souris, 15L, 14L, NULL, NULL);
    if (joueur == MICRO)
	affichage ("Je réfléchis...", 25);
    else
	affichage ("Je cherche...", VERT_2);
    coup_joue = jeu_amiga (graines, détermination_niveau());
    SetMenuStrip (win, &menu);
    ClearPointer (win);
    return coup_joue;
}

void __regargs affichage_main (short int Case)
{
    short int x,y;

    effacer_main();
    determination_emplacement (Case, 0, &x, &y);
    DrawImage (rastport, &mainImage, x+8, y-67);
    presence_main = Case;
}

void __regargs attente_clic_souris (void)
{
    struct IntuiMessage * message;

    ClearMenuStrip (win);
    if (message = attente_message())
	ReplyMsg ((struct Message *) message);
    SetMenuStrip (win, &menu);
}

void __regargs rappel (void)
{
    affichage_main (dernier_coup);
    affichage ("C'est cette case qui a été jouée", MAUVE);
}

short int __regargs aide (short int joueur)
{
    short int coup_conseille;

    effacer_main();
    if (joueur == 0)
    {	inversion_jeux();   echanger(&gains[0],&gains[1]);
	coup_conseille = jeu_micro(HUMAIN)-6;
	inversion_jeux();   echanger(&gains[0],&gains[1]);
    }
    else
	coup_conseille = jeu_micro(HUMAIN);
    affichage_main (coup_conseille);
    affichage ("Vous pouvez jouer cette case",GRIS_CLAIR);
    return coup_conseille;
}

static short int __regargs traitement_menu (struct IntuiMessage * message, short int joueur)
{
    LONG classe;
    unsigned short int code, menu_choisi;

    classe = message->Class;
    code = message->Code;
    ReplyMsg ((struct Message *) message);

    if (classe == MENUPICK)     /* un menu a été sélectionné */
    {	menu_choisi = code;
	if ( menu_choisi != MENUNULL )
	{   switch (MENUNUM(menu_choisi))
	    {	case 0:
		    switch (ITEMNUM(menu_choisi))
		    {	case 0:
			    if (SUBNUM(menu_choisi) != NOSUB)
				return	(short) (-1-SUBNUM(menu_choisi));
			    break;
			case 1: aide(joueur);   return 1;
			case 2: return ABANDONNER;
			case 3: return ECHANGER_JEUX;
			case 4:
			switch (SUBNUM(menu_choisi))
			{   case 0: rappel();   return 1;
			    case 1: /* annulation dernier coup joué */
				return ANNULATION;
			}   break;
			case 5:
			    if (SUBNUM(menu_choisi) != NOSUB)
				indication_jeu = SUBNUM(menu_choisi);
			    return 0;
			case 6: explications(); return 1;
			case 7: return QUITTER;
		    } break;

		case 2:     /* menu disque */
		    switch (ITEMNUM(menu_choisi))
		    {	case 0: return LIRE_PARTIE;
			case 1: sauvegarde_partie (joueur);
		    }
	    }
	}
    }
    return 0;
}

void __regargs annulation (short int coup)
{
    short int i, j, case2, Case=coups_joues[coup], nbre_graines, joueur, nbre_tours;

    if (Case < 6)
	joueur = 0;
    else
	joueur = 1;
    case2 = case_suivante (Case);
    nbre_graines = graines_jouees[coup-1][Case] - 1;
    nbre_tours = nbre_graines/11;
    i=0;    /* compteur de boucle */
    while (graines[Case]  <  graines_jouees[coup-1][Case])
    {	if (graines_jouees[coup][case2])
	{   j=graines[case2]-graines_jouees[coup-1][case2]-1;
	    do
	    {	dessiner (Case, nbre_graines-(j*11)-i, couleur[case2][--graines[case2]]);
		effacer (case2, graines[case2]);
		graines[Case]++;
	    }
	    while (--j >= 0);
	}
	else   /* les graines avaient été prises */
	{   while (graines[case2]  <  graines_jouees[coup-1][case2])
	    {	dessiner (case2, graines[case2]++, prise[joueur][gains[joueur]-1]);
		enlever_graine (joueur);
	    }
	    j=0;
	    do
	    {	dessiner (Case, nbre_graines-(j*11)-i, prise[joueur][gains[joueur]-1]);
		enlever_graine (joueur);
		graines[Case]++;
	    }
	    while (++j <= nbre_tours);
	}
	do
	    case2 = case_suivante (case2);
	while (case2 == Case);
	i++;
    }
}

short int __regargs annuler (short int coups, short int * joueur)
{
    short int coups_annules;

    if (coups < 2) return 0;
    annulation(--coups);
    coups_annules=1;
    *joueur = adversaire (*joueur);
    if (joueurs == HUMAIN+MICRO  &&  *joueur==MICRO  &&  coups>1)
    {	annulation(--coups);    /* annulation du coup du micro */
	coups_annules=2;    *joueur=HUMAIN;
    }
    dernier_coup = coups_joues[coups];
    return coups_annules;
}

short int __regargs case_choisie (short int x, short int y)
{
    short int couleur, colonne;

    if (y < 48)
	return 12;
    if (y > 226)
	return 12;
    if (y > 120  &&  y < 154)
	return 12;
    if (x < 14  ||  x > 304)
	return 12;
    couleur = ReadPixel (rastport, x, y);
    if (couleur > 0  &&  couleur < 20)
	return 12;
    colonne = ((x - 15) / 50);
    if (y > 128)
	return colonne;
    return (short) (11 - colonne);
}

short int __regargs attente_jeu_joueur (short int joueur, short int jeu)
{
    struct IntuiMessage * message;
    short int Case = 12, code, selection;
    LONG classe;

    do
    {	if ((message = elimination_messages()) == 0)
	    message = attente_message();            /* Attente appui bouton */
	if (message)
	{   classe = message->Class;	code=message->Code;
	    if (classe == MOUSEBUTTONS)
	    {	if (code  ==  IECODE_LBUTTON)       /* appui bouton gauche */
		    Case = case_choisie (message->MouseX, message->MouseY);
		else
		if (code == (IECODE_UP_PREFIX | IECODE_LBUTTON))
		{   if (Case  !=  case_choisie (message->MouseX, message->MouseY))
			code=0;
		}
		ReplyMsg ( (struct Message *) message );
	    }
	    else
	    {	selection = traitement_menu (message, joueur);
		if (selection < 0)
		    return selection;
		if (jeu)
		    init_pointeur (joueur);
	    }
	}
    }
    while (code != (IECODE_UP_PREFIX | IECODE_LBUTTON));
    if (jeu)
	effacer_main();
    return Case;
}

static short int __regargs gestion_jeu (short int jeu, short int joueur)
{
    short int coup_joue;

    if (jeu)
    {	affichage_joueur (joueur);
	if (joueur == 0  ||  joueurs == HUMAIN)
	    return attente_jeu_joueur (joueur, jeu);
	else
	{   coup_joue = jeu_micro (MICRO);
	    if (indication_jeu)
	    {	affichage_main (coup_joue);
		if (indication_jeu == 1)
		{   affichage ("Cliquez pour continuer", PAILLE);
		    attente_clic_souris();
		}
		else
		{   affichage ("Je joue cette case", BEIGE);
		    Delay (75);
		}
		effacer_main();
	    }
	    return coup_joue;
	}
    }
    return attente_jeu_joueur (joueur, jeu);
}

short int __regargs test_jeu_possible (short int joueur)
{
    short int i, coup_joue, nbre_graines[12];

    if (somme_graines (0, graines) + somme_graines (12, graines)  ==  2)
    {	if (somme_graines (0, graines) == 1)
	for (i = 0;  i < 6;  i++)
	    if (graines[i])
		coup_joue = i;
	for (;  i < 12;  i++)
	    if (graines[i]  &&  coup_joue == i-6)
	    {	affichage ("Prises impossibles", PAILLE);
		Delay (75);
		return FIN_DE_PARTIE;
	    }
    }
    if (joueur == 0)
    {	for (coup_joue = 0;  coup_joue < 6;  coup_joue++)
	{   copie_tableau (graines, nbre_graines);
	    if (nbre_graines[coup_joue])
	    {	semi (nbre_graines, coup_joue);
		if (somme_graines (12, nbre_graines))
		    break;
	    }
	}
	if (coup_joue == 6)
	{   if (joueurs == HUMAIN)
		affichage ("Le joueur A ne peut plus jouer", ROSE);
	    else
		affichage ("Vous ne pouvez plus jouer", MAUVE);
	    Delay (75);
	    return FIN_DE_PARTIE;
	}
    }
    else
    {	for (coup_joue = 6;  coup_joue < 12;  coup_joue++)
	{   copie_tableau (graines, nbre_graines);
	    if (nbre_graines[coup_joue])
	    {	semi (nbre_graines, coup_joue);
		if (somme_graines (0, nbre_graines))
		    break;
	    }
	}
	if (coup_joue  ==  12)
	{   if (joueurs == HUMAIN)
		affichage ("Le joueur B ne peut plus jouer", ROSE);
	    else
		affichage ("Je ne peux plus jouer", MAUVE);
	    Delay (75);
	    return FIN_DE_PARTIE;
	}
    }
    return 1;
}

void __regargs test_jeu_amiga (char * chaine)
{
    char * temoin[] = { "IGNORE", "SOURIS", "DELAI" };
    short int i;

    for (i = 0;  i < 3;  i++)
	if (MatchToolValue (chaine, temoin[i]))
	    mise_a_jour_mode (i);
}

short int __regargs affichage_message_fin (short int gains_joueur_0, short int gains_joueur_1)
{
    if (gains_joueur_1  >  gains_joueur_0)
    {	if (joueurs == HUMAIN+MICRO)
	    affichage ("J'ai gagné !!!",19);
	else
	    affichage ("Le joueur B a gagné",19);
	affichage_gagnant (1);
    }
    else if (gains_joueur_0  >  gains_joueur_1)
    {	if (joueurs == HUMAIN+MICRO)
	    affichage ("Vous avez gagné...",20);
	else
	    affichage ("Le joueur A a gagné",20);
	affichage_gagnant (0);
    }
    else
    {	affichage ("Match nul", 21);
	affichage_gagnant (2);
    }
    return 0;
}

void effacement_gadgets (void)
{
    short int Case;

    SetAPen (rastport, 0);
    SetOPen (rastport, 0);
    for (Case = 0;  Case < 6;  Case++)
    {	RectFill (rastport, 18+Case*50, 49, 50+Case*50, 60);
	RectFill (rastport, 18+Case*50, 155, 50+Case*50, 166);
    }
    RectFill (rastport, 278, 236, 310, 250);
    RectFill (rastport, 278, 24, 310, 38);
}

short int affichage_quantite_graines (void)
{   short int dizaine,graines = calcul_nbre_graines();
    static char message[] = "   graines sont distribuées\000";
    dizaine = graines/10;
    if (dizaine)
	*message = 0x30 + dizaine;
    else
	*message = ' ';
    *(message+1) = 0x30 + graines - 10 * dizaine;
    affichage (message,PAILLE);
    return graines;
}

short int saisie_nombre_graines (void)
{   struct IntuiMessage *message;
    LONG classe;
    short int Case,graine,gadget_selectionne,nbre_graines=0,joueur;
    struct Gadget *gadget;
    struct StringInfo *string_info;
    effacer_main();     ClearPointer (win);
    ClearMenuStrip (win);
    SetMenuStrip (win, &menu_saisie);
    AddGList (win, &gadget_1, 0, -1, 0);
    SetAPen (rastport, 0);
    SetOPen (rastport, 0);
    RectFill (rastport, 294, 236, 307, 250);
    RectFill (rastport, 294, 24, 307, 38);
    RefreshGList (&gadget_1, win, 0, -1);
    ActivateGadget (&gadget_1, win, 0);
    while (nbre_graines < 48)
    {	message = attente_message();
	if (message)
	{   classe = message->Class;
	    if (classe == GADGETUP)
	    {	gadget = (struct Gadget *) message->IAddress;
		gadget_selectionne = gadget->GadgetID;
		string_info = (struct StringInfo *) gadget->SpecialInfo;
		nbre_graines = string_info->LongInt;
		if (gadget_selectionne < 12)
		{   Case = gadget_selectionne;
		    if (nbre_graines<29  &&  calcul_nbre_graines()+nbre_graines-graines[Case] < 49)
		    {	vider (Case);
			for (graine=0;graine < nbre_graines;graine++)
			{   dessiner(Case,graine,20+(calcul_nbre_graines()/4));
			    ++graines[Case];
			}
			if (affichage_quantite_graines() < 48)
			{   if (gadget->NextGadget)
				ActivateGadget (gadget->NextGadget, win, 0);
			    else
				ActivateGadget (&gadget_1, win, 0);
			}
		    }
		    else
		    {	if (nbre_graines > 28)
			    affichage ("28 graines maxi par case S.V.P.",VERT_2);
			else
			    affichage ("48 graines maxi au total S.V.P.",VERT);
			ActivateGadget (gadget, win, 0);
		    }
		}
		else
		{   joueur = gadget_selectionne - 12;
		    if (nbre_graines < 25  &&  calcul_nbre_graines()+nbre_graines-gains[joueur] < 49)
		    {	while (gains[joueur]>0) enlever_graine(joueur);
			while (gains[joueur] < nbre_graines)
			    ajouter_graine(joueur,20+(calcul_nbre_graines()/4));
			if (affichage_quantite_graines() < 48)
			{   if (gadget->NextGadget)
				ActivateGadget (gadget->NextGadget, win, 0);
			    else
				ActivateGadget (&gadget_1, win, 0);
			}
		    }
		    else
		    {	if (nbre_graines > 24)
			    affichage ("Pas plus de 24 graines gagnées!",VERT_JAUNE);
			else
			    affichage ("48 graines maxi au total S.V.P.",VERT);
			ActivateGadget (gadget, win, 0);
		    }
		}
		/* détermination du nombre de graines déjà distribué */
		nbre_graines = calcul_nbre_graines();
	    }
	    else
	    if (classe == MENUPICK  &&  MENUNUM(message->Code) == 0)
	    {	switch ITEMNUM(message->Code)
		{   case 0:	/* arrêt distribution */
		    {	nbre_graines = calcul_nbre_graines();
			if (nbre_graines < 48)
			{   affichage("Attention: il manque des graines",VERT_SALE);
			    Delay (75);
			}
			nbre_graines = 48;  break;
		    }
		    case 2:	/* quitter */
		    {	init_graines(0);    nbre_graines = 49;
			break;
		    }
		    case 1:	/* recommencer */
		    {	init_graines(0);
			affichage_quantite_graines();
			ActivateGadget (&gadget_1, win, 0);
			break;
		    }
		}
	    }
	    ReplyMsg( (struct Message *) message );
	}
    }
    RemoveGList (win, &gadget_1, -1);
    ClearMenuStrip (win);
    SetMenuStrip (win, &menu);
    effacement_gadgets();
    if (nbre_graines < 49)
    {	graine = test_jeu_possible(0);
	joueur = test_jeu_possible(1);
	if (graine == FIN_DE_PARTIE  &&  joueur == FIN_DE_PARTIE)
	    return -1;
	if (graine == FIN_DE_PARTIE)
	    return 1;
	if (joueur == FIN_DE_PARTIE)
	    return 0;
	return 2;
    }
    return -1;
}

short int __regargs verification (char * texte)
{   struct IntuiMessage *message;
    LONG classe;
    short int gadget_selectionne=-1;
    effacer_main();     affichage (texte,BEIGE);
    ClearMenuStrip (win);
    AddGList (win, &gadget_non, 0, -1, 0);
    RefreshGList (&gadget_non, win, 0, -1);
    while (gadget_selectionne < 0)
    {	message = attente_message();
	if (message)
	{   classe = message->Class;
	    if (classe == GADGETUP)
		gadget_selectionne = ((struct Gadget *) message->IAddress)->GadgetID;
	    ReplyMsg( (struct Message *) message );
	}
    }
    RemoveGList (win, &gadget_non, -1);
    SetMenuStrip (win, &menu);
    return gadget_selectionne;
}

void main (long argc, char ** argv)
{
    short int coup_joue, i, jeu=0, joueur=0;
    struct IFFL_BMHD *bmhd;
    struct TextAttr diamond = { "diamond.font", 12, FS_NORMAL, FPF_DISKFONT };
    struct TextFont * fonte;
    struct DiskObject * diskobj;
    char * chaine;

    /* ouverture des bibliothèques */
    if ((IntuitionBase = (struct IntuitionBase *) OpenLibrary ("intuition.library", 36)))
    {
	if ((GfxBase = (struct GfxBase *) OpenLibrary ("graphics.library", 36)))
	{
	    if ((DiskfontBase = OldOpenLibrary ("diskfont.library")))
	    {
		if ((IFFBase = OpenLibrary (IFFNAME,IFFVERSION)))
		{
		    if ((IconBase = OldOpenLibrary ("icon.library")))
		    {
			if ((AslBase = OpenLibrary ("asl.library", 37)))
			{
			    /* chargement de l'écran de jeu */
			    if ( ! (fichier_IFF = IFFL_OpenIFF ("Awalé.pic", IFFL_MODE_READ)))
				goto fermeture_bibliothèques;

			    if (!(bmhd = IFFL_GetBMHD (fichier_IFF)))
				goto fin_3;

			    newscreen.Width	= bmhd->w;
			    newscreen.Height	= bmhd->h;
			    newscreen.Depth	= bmhd->nPlanes;
			    newscreen.ViewModes = IFFL_GetViewModes (fichier_IFF);

			    /* ouverture de l'ecran et de la fenetre */
			    if (!(screen = OpenScreen (&newscreen)))
				goto fin_3;

			    fenetre_explications.Screen = newwindow.Screen = screen;
			    if (!(win = OpenWindow (&newwindow)))
				goto fin_4;

			    if (IFFL_GetColorTab (fichier_IFF, (WORD *) colortable)  !=  32)
				goto fin_5;

			    LoadRGB4 (&(screen->ViewPort), colortable, 32);

			    if (! (IFFL_DecodePic (fichier_IFF, &(screen->BitMap))))
				goto fin_5;

			    if ((Pointeur = (PLANEPTR) AllocRaster (320, 256)) == 0)
				goto fin_5;
			    rastport = win->RPort;
			    InitArea (&AreaInfo, buffer, 4);
			    rastport->AreaInfo = &AreaInfo;
			    rastport->TmpRas = InitTmpRas (&StructTmpRas, Pointeur, RASSIZE(320,256));
			    SetDrMd (rastport, JAM2);

			    if (argc == 0)      /* démarrage depuis le Workbench */
			    {
				struct WBStartup * argmsg = (struct WBStartup *) argv;
				struct WBArg * wb_arg = argmsg->sm_ArgList;

				if (diskobj = GetDiskObject (wb_arg->wa_Name))
				{   if (chaine = FindToolType (diskobj->do_ToolTypes, "NIVEAU"))
					choix_niveau (chaine);
				    if (chaine = FindToolType (diskobj->do_ToolTypes, "JEU_AMIGA"))
					test_jeu_amiga (chaine);
				    FreeDiskObject (diskobj);
				}
			    }
			    else if (argc > 1)
				choix_niveau (argv[1]);             /* démarrage depuis le CLI */

			    /* chargement de la fonte de caractères */
			    if (fonte = OpenDiskFont (&diamond))
				SetFont (rastport, fonte);

			    SetMenuStrip (win, &menu);

			    while (jeu != QUITTER)
			    {	coup_joue = gestion_jeu (jeu, joueur);
				if (coup_joue < 0)  /* un menu a été sélectionné */
				{   switch (coup_joue)
				    {	case -1:
					    if (jeu == 0  ||  verification("Nouvelle partie ?") == OUI)
					    {	joueurs = HUMAIN; init_graines(1);
						joueur = partie = nbre_coups_joues=0;
						coups_enregistres = jeu = 1;
					    }
					    else
						mise_a_jour_partie (partie);
					    break;

					case -2:
					    if (jeu == 0  ||  verification("Nouvelle partie ?") == OUI)
					    {	joueurs = HUMAIN + MICRO;
						init_graines (1);
						joueur = nbre_coups_joues = 0;
						coups_enregistres = jeu = partie = 1;
					    }
					    else
						mise_a_jour_partie (partie);
					    break;

					case -3:
					    if (jeu == 0  ||  verification("Nouvelle partie ?") == OUI)
					    {	joueurs = HUMAIN + MICRO;
						init_graines (1);
						nbre_coups_joues = 0;
						jeu = joueur = coups_enregistres = 1;
						partie = 2;
					    }
					    else
						mise_a_jour_partie (partie);
					    break;

					case PROBLEME:
					    if (jeu == 0  ||  verification("Abandon partie ?") == OUI)
					    {	init_graines(0);
						affichage ("Nombre de graines par case ?",MAUVE);
						if ((joueur = saisie_nombre_graines()) >= 0)
						{   enregistrement (0, 0);
						    if (verification ("Vous jouez contre moi ?"))
							joueurs = HUMAIN+MICRO;
						    else
							joueurs = HUMAIN;
						    if (joueur == 2)
							if (verification ("Voulez-vous débuter (A) ?"))
							    joueur = 0;
							else
							    joueur = 1;
						    nbre_coups_joues = coups_enregistres = jeu=1;
						    partie = 3;
						}
						else
						{   nbre_coups_joues = coups_enregistres = jeu=0;
						    affichage ("Partie nulle", VERT_2);
						}
						dernier_coup = -1;
						effacement_gadgets();    /* au cas où... */
					    }
					    else
						mise_a_jour_partie (partie);
					    break;

					case LIRE_PARTIE:
					    if (jeu == 0  ||  verification ("Abandon partie ?") == OUI)
					    {	i = lecture_partie (&joueur);
						ScreenToFront (screen);
						SetMenuStrip (win, &menu);
						if (i)
						{   if (i == -1)    /* erreur lecture */
						    {	jeu = 0;    dernier_coup=-1;	Delay (80);
						    }
						    else
						    {	jeu = 1;
							mise_a_jour_partie (partie);
							affichage_des_graines();
						    }
						}
						else
						    Delay (80);
					    }
					    break;

					case ABANDONNER:
					    jeu = FIN_DE_PARTIE;
					    break;

					case QUITTER:
					    if (jeu == 1)
					    {	if (verification ("Vous voulez arrêter ?"))
						    jeu = QUITTER;
					    }
					    else
						jeu = QUITTER;
					    break;

					case ANNULATION:
					    if (i = annuler (coups_enregistres, &joueur))
					    {	coups_enregistres -= i;
						nbre_coups_joues  -= i;
					    }
					    jeu = 1;
					    break;

					case ECHANGER_JEUX:
					    if (coups_enregistres)
					    {	dernier_coup = echange_jeux (coups_enregistres);
						joueur = adversaire (joueur);
					    }
					    break;
				    }
				}
				else
				if (jeu)
				{   if (joueur==0  ||  joueurs==HUMAIN)
					coup_joue = controle (coup_joue, joueur);
				    if (coup_joue >= 0)
				    {	distribution (coup_joue);
					dernier_coup = coup_joue;
					++nbre_coups_joues;
					coups_enregistres = enregistrement (coups_enregistres, coup_joue);
					if (gains[joueur] > 24)
					{   jeu = FIN_DE_PARTIE;
					    joueur = adversaire (joueur);
					}
					else
					{   joueur = adversaire (joueur);
					    jeu = test_jeu_possible (joueur);
					}
				    }
				}
				if (jeu == FIN_DE_PARTIE)
				{   affichage_joueur (2);
				    ClearPointer (win);
				    jeu = affichage_message_fin (gains[0], gains[1]);
				}
				if (jeu == 1)               /* traitement menus abandon, sauvegarde, échange, conseil */
				{   OnMenu (win, 0x40);
				    OnMenu (win, 0x22);
				    OnMenu (win, 0x60);
				    OnMenu (win, 0x20);
				}
				else
				{   OffMenu (win, 0x40);
				    OffMenu (win, 0x22);
				    OffMenu (win, 0x60);
				    OffMenu (win, 0x20);
				}
				if (coups_enregistres > 1)  /* traitement menu annulation */
				    OnMenu (win, 0x880);
				else
				    OffMenu (win, 0x880);
				if (dernier_coup >= 0)      /* traitement menu rappel */
				    OnMenu (win, 0x80);
				else
				    OffMenu (win, 0x80);
			    }

			    ClearMenuStrip (win);
			    if (fonte)
				CloseFont (fonte);
			    FreeRaster ((PLANEPTR) Pointeur, 320, 256);
			    FreeAslRequest (fichier);

		    fin_5:
			    CloseWindow (win);
		    fin_4:
			    CloseScreen (screen);
		    fin_3:
			    IFFL_CloseIFF (fichier_IFF);
			}
		    }
		}
	    }
	}
    }
fermeture_bibliothèques:
    CloseLibrary (AslBase);
    CloseLibrary (IconBase);
    CloseLibrary (IFFBase);
    CloseLibrary (DiskfontBase);
    CloseLibrary ((struct Library *) GfxBase);
    CloseLibrary ((struct Library *) IntuitionBase);
}
