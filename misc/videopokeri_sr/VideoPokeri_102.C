
/********************************************************************
 *                                                                  *
 * Program      : Project VideoPokeri                               *
 *                                                                  *
 * Version      : 1.02      (06.11.1991)    (03.02.1995)            *
 *                                                                  *
 * Description  : RAY:n videopokerin kaltainen peli.                *
 *                mm. tuplaus, pihistys, äänet, levylista ym. ym.   *
 *                                                                  *
 *                                                                  *
 * CLI-usage    : [run] VideoPokeri [s] [1|2|3]                     *
 *                  parametrit:   s = silencio = ei ladata soundeja *
 *                                1 = SUOMI                         *
 *                                2 = ENGLISH                       *
 *                                3 = SVENSKA                       *
 *                                                                  *
 * Distribution : (C) Janne & Aki                                   *
 *                                                                  *
 * Bugs         : ?                                                 *
 *                                                                  *
 * Author       : Janne Kantola & Aki Löytynoja                     *
 *                92100  RAAHE ,  FINLAND                           *
 *                                                                  *
 *  E-mail       : janta@ratol.fi                                   *
 *                                                                  *
 ********************************************************************/


/************** ALUSTUSTIEDOSTOT *********************/

#include <proto/all.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <devices/audio.h>
#include <intuition/intuition.h>
#include <libraries/dos.h>
#include <libraries/dosextens.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int CXBRK(void)  {return(0);}

/********************** KONFIGURAATIO-VIVUT ************************/

/* #define NOT_ENGLISH_GIFTWARE */
/* When this is defined, About-window exists and default language
   is Finnish */

/**************************** VAKIOT *******************************/

#define ALKUMARKAT 50           /* PELIMARKKOJA ALUSSA 50 KPL   */
#define ALKUPANOS   4           /* ALKUPANOS ON 5 MK            */
#define VIIVE      25           /* DELAY-VIIVE                  */
#define SOUND_MAX  11           /* Soundien lukumäärä           */

const   UBYTE VERSIO[] = "$VER: VideoPokeri 1.02 (13.04.94) JanTAki";

/******************** OMAT HEADER-TIEDOSTOT ************************/

#include "Poker.h/Screen.h"     /* Näyttömääritelyt  */
#include "Poker.h/Window.h"     /* Ikkunamäärittelyt */
#include "Poker.h/Graphics.h"   /* Grafiikat         */
#include "Poker.h/Gadgets.h"    /* Gadgetit          */
#include "Poker.h/Sheets.h"     /* Taulukot, tekstit */


/************************* ULKOISET FUNKTIOT ****************************/

extern  VOID AvaaSoundit(VOID);
extern  VOID VaraaKanavat(VOID);
extern  VOID Sound(SHORT, SHORT, SHORT);
extern  UBYTE *sbase[];
extern  ULONG ssize[];


/************************ FUNKTIOMÄÄRITTELYT ***************************/

VOID  OpenAll(VOID);
VOID  Initialize(VOID);
VOID  ColorSquare(struct RastPort *, SHORT, SHORT, SHORT, SHORT, SHORT);
VOID  ShadowText(struct RastPort *, SHORT, SHORT, SHORT, SHORT, BYTE *);
VOID  PlainText(struct RastPort *, SHORT, SHORT, SHORT, SHORT, BYTE *);
VOID  TextText(struct RastPort *, SHORT, SHORT, SHORT, BYTE *);
VOID  cleanExit (SHORT);
SHORT HandleUGad(struct IntuiMessage *);
VOID  HandleDGad(struct IntuiMessage *);
VOID  Jako(VOID);
VOID  PiirraPakka(VOID);
VOID  JaaAlkuKortit(VOID);
VOID  JaaLoputKortit(VOID);
VOID  OtaPoisJokeri(VOID);
SHORT Satunnaisluku(SHORT, SHORT);
VOID  DeKoodaa(VOID);
SHORT TarkistaVoitot(VOID);
VOID  GadgetitKondixeen(VOID);
VOID  KatsoRahaTilanne(VOID);
VOID  GameOver(VOID);
VOID  VahennaRahaa(VOID);
VOID  PrinttaaPanos(VOID);
VOID  PrinttaaPelitVoitot(VOID);
VOID  TekstiPelitVoitot(UBYTE);
VOID  TulostaVoittoluokat(VOID);
VOID  VaritRuutuun(SHORT);
VOID  Valauta(VOID);
VOID  PuhdistaAlapalkki(VOID);
VOID  KortinGrafiikka(SHORT);
VOID  KortinGrafiikkaTalteen(SHORT);
VOID  TaustaKortit(VOID);
VOID  TulostaKortit(VOID);
VOID  TulostaKortit2(VOID);
VOID  KortitPois(VOID);
VOID  KortitKasaan(VOID);
VOID  KortitPakkaan(VOID);
VOID  KilistysAAYY(VOID);
VOID  KilistysAY(VOID);
VOID  KilistysYA(VOID);
VOID  KilistysYY(VOID);
#if defined FEA_NOT_ENGLISH_GIFTWARE
VOID  Aboutti(VOID);
#endif
VOID  MuutaKielta(UBYTE);


/******** SYSTEEMIMUUTTUJAT ****************************/

struct IntuitionBase *IntuitionBase = NULL;
struct Library       *DiskfontBase  = NULL;
struct GfxBase       *GfxBase       = NULL;
struct Screen        *screen        = NULL;
struct Window        *window        = NULL;
struct RastPort      *RP            = NULL;
struct RastPort      cardRP;
struct FileHandle    *infile        = NULL;
struct IOAudio       *AIOptr1       = NULL;
struct IOAudio       *AIOptr2       = NULL;
struct MsgPort       *port1         = NULL;
struct MsgPort       *port2         = NULL;
struct TextFont      *textFont;
struct TextFont      *oldTextFont;
struct BitMap        bitMap;
struct BitMap        cardbitMap;
struct TextAttr      textAttr;
ULONG  device1                      = 0;
ULONG  device2                      = 0;


/******** GLOBAALIT MUUTTUJAT ****************************/

UBYTE   stringi[255];
UBYTE   BON[]  = {'\x1B', '[', '1', 'm', '\x0' };
UBYTE   OFF[]  = {'\x1B', '[', '3', '1', ';', '0', 'm', '\x0' };
UBYTE   COL1[] = {'\x1B', '[', '3', '2', 'm', '\x0' };
UBYTE   COL2[] = {'\x1B', '[', '3', '3', 'm', '\x0' };

SHORT  jokerimukana  =   (ALKUPANOS>1)?1:0; /* ONKO JOKERI MUKANA       */
LONG   voitot        =   0;                 /* VOITTORAHAA YLÄKULMASSA  */
SHORT  pelit         =   ALKUMARKAT;        /* PELIRAHAA JÄLJELLÄ       */
SHORT  pelitilanne   =   1;                 /* MISSÄ VAIHEESSA MENNÄÄN  */
SHORT  tyhjennys     =   1;                 /* ONKO PÖYTÄ TYHJÄ         */
SHORT  valittu[]     =   {0,0,0,0,0};       /* KORTTIEN VALINNAT        */
SHORT  panokset[]    =   {1,2,3,4,5};       /* PANOKSEN SUURUUDET       */
SHORT  nytpanos      =   ALKUPANOS;         /* 4. ALKIO --> 5 mk        */
SHORT  nytvoitto     =   8;                 /* MIKÄ VOITTO (8=EI TULLU) */
SHORT  voittosumma   =   0;                 /* VOITTOSUMMA              */
SHORT  tuplavoitto   =   0;                 /* VOITTO TUPLAUKSEN JÄLKEEN*/
APTR   mypointer     =   0;                 /* POINTTERI MUISTIIN       */
UBYTE  *muistinalku;                        /* POINTTERI MUISTIIN       */
UBYTE  stringi[255];                        /* VARATTU TILA STRINGEILLE */
UBYTE  lista[15][30];                   /* HIGHSCORE-LISTAN MUUTTUJAT   */
USHORT tulos[15];                       /* HIGHSCORE-LISTAN TULOKSET    */
USHORT sijoitus;                            /* SIJOITUS LISTALLA        */
ULONG  clock;                               /* KELLOTAAJUUS             */
UBYTE  SS            =   1;                 /* 1. VAI 2. KANAVA         */
UBYTE  KIELI;                               /* KIELI PELIN AIKANA       */
UBYTE  ALOITUSKIELI;                        /* ALOITUSKIELI             */
UBYTE  FromWB        =   FALSE;             /* KÄYNNISTYS IKONISTA?     */
UBYTE  SOUNDS        =   0;     /* 0=PÄÄLLÄ, 1=POIS, 2=POIS:EI PÄÄLLE!! */




/***** PÄÄOHJELMA VENAA 'WAIT'ISSA JA OTTAA VASTAAN INTUITION-VIESTEJÄ **/

VOID main ( argc,argv)
int argc;
char *argv[];
{
struct IntuiMessage *msg = NULL;    /* VIESTIPOINTTERI              */
SHORT  flagi;                       /* FALSE, KUN PELI LOPPUU       */
ULONG  code;                        /* INTUITIONVIESTIN LUKUARVO    */
SHORT  i;                           /* INDEKSILASKURI               */

if ( argc == 0 )    FromWB = TRUE;  /* KÄYNNISTYS WORKBENCHISTÄ     */

#if defined FEA_NOT_ENGLISH_GIFTWARE
    ALOITUSKIELI = 0;                       /* ALOITUSKIELI = SUOMI */
#else
    ALOITUSKIELI = 1;                    /* ALOITUSKIELI = ENGLANTI */
#endif

if ( argc > 0 )               /* ANNETTU PARAMETREJÄ KOMENTORIVILTÄ */
    {
    if (argv[1][0] == 's' || argv[1][0] == 'S' ||
        argv[2][0] == 's' || argv[2][0] == 'S' )
        {
        SOUNDS = 2;                                /* SOUNDS ON/OFF */
        }

    if (argv[1][0] > '0' && argv[1][0] < '3' )           /* KIELI ? */
        {
        ALOITUSKIELI = argv[1][0]-49;
        }
    if (argv[2][0] > '0' && argv[2][0] < '3' )
        {
        ALOITUSKIELI = argv[2][0]-49;
        }
    }

AIOptr1     = 0L;                   /* NOLLATAAN MUUTTUJAT, JOTTA   */
AIOptr2     = 0L;                   /* TIEDETÄÄN SULKEAKO NE VAI EI */
port1       = 0L;
port2       = 0L;
device1     = 1L;
device2     = 1L;

for (i=0; i<SOUND_MAX; i++)         /* SAMOIN SAMPLEPOINTTERIT      */
        {
        sbase[i] = 0L;
        }

OpenAll();                          /* AVATAAN KIRJASTOT JA GRAFIIKAT */
RP = window->RPort;                 /* POINTTERI IKKUNAN RASTPORTTIIN */
Initialize();                       /* ALUSTETAAN PELIKENTTÄ        */

if (SOUNDS == 0)                    /* SOUNDEJA EI OLE KIELLETTY    */
    {
    AvaaSoundit();                  /* LATAA SAMPLET LEVYLTÄ        */
    VaraaKanavat();                 /* VARAA SOITTOKANAVAT          */
    }

flagi=TRUE;
while(flagi)                        /* KUNNES flagi == FALSE (LOPPUU) */
    {
    Wait ( 1L << window->UserPort->mp_SigBit); /* ODOTETAAN INT. VIESTIÄ */
    while (msg=(struct IntuiMessage *)GetMsg(window->UserPort))
        {                           /* LUETAAN VIESTEJÄ, KUNNES LOPPUVAT */
        code=msg->Code;             /* VIESTIN KOODIARVO */
        switch(msg->Class)
            {
            case MOUSEBUTTONS:
                if ( code == MENUDOWN )  /* JAKO HIIREN OIKEALLA NAPILLA */
                    {
                    Jako();
                    }
                break;
            case RAWKEY:
                if (pelitilanne == 1 && code < 3 && code > 0) 
                    {
                    MuutaKielta( (UBYTE)(code-1) );  /* 1, 2 tai 3    */
                    }
                if ( code == 33 && SOUNDS == 0)      /* SOUNDS -> ON  */
                    {
                    SOUNDS = 1;
                    }
                else if ( code == 33 && SOUNDS == 1) /* SOUNDS -> OFF  */
                    {
                    SOUNDS = 0;
                    }
                if ( code == 16 )           /* Q - LOPETUS             */
                    {
                    flagi = FALSE;
                    }
#if defined FEA_NOT_ENGLISH_GIFTWARE
                if ( code == 95 )           /* HELP - TEKIJÖISTÄ       */
                    {
                    Aboutti();                  
                    }
#endif
                break;
            case GADGETDOWN:                /* KÄSITELLÄÄN GADGET-ALAS */
                HandleDGad(msg);
                break;
            case GADGETUP:                  /* KÄSITELLÄÄN GADGET-YLÖS */
                flagi=HandleUGad(msg);
                break;
            default: break;
            }
        ReplyMsg((struct Message *)msg);    /* VASTATAAN VIESTEIHIN    */
        }
    }
cleanExit(0);                               /* OHJELMAN NORMAALI LOPPU */
}

/* END OF MAIN PROGRAM */




/******* TÄMÄ FUNKTIO KÄSITTELEE GADGET-ALAS-TAPAUKSET ************/

VOID HandleDGad(m)
struct IntuiMessage *m;
{
struct Gadget *g;           /* TÄHÄN SAADAAN SELVILLE GADGETIN TIEDOT */
USHORT id;                  /* VARSINAINEN ID-MUUTTUJA */
SHORT i, x, xx;

g  = (struct Gadget *)m->IAddress;              /* GAGETIN TIEDOT  */
id = g->GadgetID;                               /* GAGETIN ID      */


/**************************** PANOKSEN MUUTOS **************************/

if ( (id==50) || (id==13) )                     /* PANOKSEN MUUTOS */
    {
    if (tyhjennys==4)                           /* LISTA RUUDULLA  */
        {
        SetAPen(RP, 0);
        RectFill(RP, 5, 32, 315, 198);          /* OTETAAN POIS    */
        tyhjennys=1;
        }
    nytpanos++;                                 /* PANOS KASVAA    */
    if ( (panokset[nytpanos] > (pelit+voitot)) || nytpanos==5)
        {
        nytpanos=0;                             /* ---> 1 mk       */
        }
    Sound(2, 175-nytpanos*15, 3);
    PrinttaaPanos();                            /* PÄIVITÄ NÄYTTÖ  */
    }


/**************************** KORTTI PAINETTU **************************/

if ( id<6 )                                     /* KORTTI PAINETTU */
    {
    SetBPen(RP, 1);
    xx=KORTTIX-2+(id)*KORTTIL+(id)*KORTTIVALI;
    if (valittu[id]==0)
        {
        valittu[id]=1;
        }
    else 
        {
        valittu[id]=0;
        }

    i=5;
    x=0;
    while(i--)
    {
    if (valittu[i] == 1)    /* VÄHINTÄÄN YKSI KORTTI VALITTU */
        {
        x=1;
        }
    }
    if ( (x==1) && (pelitilanne == 2) )     /* JAKO-NAPPULA KÄYTÖSSÄ */
        {
        pelitilanne = 3;
        GadgetitKondixeen();
        }
    if ( (x==0) && (pelitilanne == 3) )     /* JAKO-NAPPULA EI KÄYTÖSSÄ */
        {
        pelitilanne = 2;
        GadgetitKondixeen();
        }

    if (valittu[id]==1)             /* KORTTI EI OLLUT VALITTU */
        {
        Sound(0, 100, 3);
        for (x=0; x<21; x+=2)                       
            {
            WaitTOF();
            BltBitMapRastPort(&bitMap, 264, KIELI*25+104-x, RP, xx+2, 199, 49, x+1, 0xC0);
            }
        }
    else                            /* KORTTI OLI VALITTU */
        {
        Sound(1, 120, 3);
        for(x=0; x<21; x+=2)
            {
            WaitTOF();
            ScrollRaster(RP, 0, -2, xx+2, 203, xx+50, 223); 
            }
        }
    SetBPen(RP, 0);
    }

}   /* END OF HandleDGad() */




/*********** TÄMÄ FUNKTIO KÄSITTELEE GADGET-YLÖS-TAPAUKSET ***************/

SHORT HandleUGad(m)
struct IntuiMessage *m;
{
struct Gadget *g;           /* TÄHÄN SAADAAN SELVILLE GADGETIN TIEDOT */
USHORT id;                  /* VARSINAINEN ID-MUUTTUJA  */
SHORT  retval = TRUE;       /* PALUUARVO                */
SHORT  i;                   /* LASKURI                  */
LONG   kirjoitettuja;       /* TIEDOSTOMERKKIEN LASKURI */

g  = (struct Gadget *)m->IAddress;    /* GAGETIN TIEDOT */
id = g->GadgetID;                     /* GAGETIN ID     */


/******************************* LOPETUS ********************************/

if ( id == 99 )                         /* LOPETUS !!! */
    {
    retval = FALSE;
    }


/*********************** JAKO-NAPPULA NOSTETTU ***************************/

if (id == 11)                   /* JAKO */
    {
    Jako(); 
    }


/***************** VOITONMAKSU-NAPPULA NOSTETTU * pelitilanne == 1 ******/

if ( ( (id==12) || (id==51) ) && (pelitilanne==1) )
    {
    if (tyhjennys==3)
        {
        PuhdistaAlapalkki();                    /* PALKKI PUNAINEN   */
        }
    if (tyhjennys!=4)                           /* LISTA EI RUUDUSSA */
        {
        SetAPen(RP, 0);
        RectFill(RP, 10, 32, 310, 198);
        }
    if (voitot>tulos[14])                       /* HIGHSCORE-LISTA   */
        {
        pelitilanne = 7;
        GadgetitKondixeen();
        ShadowText(RP, 22, 47, 5, 4, SekaTextit[KIELI]);
        i=0;
        while(tulos[i]>=voitot)     /* KO. TULOKSEEN SAAKKA */
            {
            sprintf(stringi, "%s%d.  %s", (i<9) ? " " : "", i+1, lista[i]);
            ShadowText(RP, 22, (SHORT)(63+i*9), 10, 8, stringi);
            i++;
            }
        sprintf(stringi, "%s%d.                          %5d",
             (i<9) ? " " : "", i+1, voitot);
        ShadowText(RP, 22, (SHORT)(63+i*9), 16, 5, stringi);
        sijoitus=i+1;
        i++;
        while(i<15)                 /* KO. TULOKSESTA ETEENPÄIN */
            {
            sprintf(stringi, "%s%d.  %s", (i<9) ? " " : "", i+1, lista[i-1]);
            ShadowText(RP, 22, (SHORT)(63+i*9), 10, 8, stringi);
            i++;
            }

        i=14;
        while(i>(sijoitus-1))       /* ETSITÄÄN TULOKSEN KOHTA */
            {
            strcpy(lista[i], lista[i-1]);
            tulos[i]=tulos[i-1];
            i--;
            }

        ColorSquare(RP, 144, 203, 161, 16, 8);      /* NIMILOOTA */
        SetAPen(RP, 0);
        RectFill(RP, 147, 206, 302, 216); 
        ShadowText(RP, 12, 215, 9, 4, SekaTextit[3+KIELI]);
        ActivateGadget(&Jono, window, NULL);
        }
    else
        {
        if (tyhjennys!=4)
            {
            ShadowText(RP, 22, 47, 28, 26, SekaTextit[6+KIELI]);
            for (i=0; i<15; i++)
                {
                sprintf(stringi, "%s%d.  %s", (i<9) ? " " : "", i+1, lista[i]);
                ShadowText(RP, 22, (SHORT)(63+i*9), 16, 5, stringi);
                }
            tyhjennys=4;
            }
        }
    }


/*********** VOITONMAKSU-NAPPULA NOSTETTU * pelitilanne == 5 ************/

if ( ( (id==12) || (id==51) ) && (pelitilanne==5) )
    {
    sprintf(stringi, "%5ld", voitot);
    TextText(RP, 260, 19, 4, stringi );
    if (tyhjennys==2)
        {
        sprintf(stringi, "%s  %4d", voittonimet[8*KIELI+nytvoitto], voittosumma);
        PlainText(RP, 147, (SHORT)(45+nytvoitto*9), 7, 0, stringi );
        }
    KilistysAAYY();
    if (tuplavoitto==voittosumma)
        {
        tyhjennys = 2;
        }
    else
        {
        tyhjennys = 3;
        }
    PuhdistaAlapalkki();
    pelitilanne = 1;
    GadgetitKondixeen();
    KatsoRahaTilanne();
    }


/******************* PELIT-LAATIKKOA PAINETTU ***************************/

if (id==49)                             /* PELIT */
    {
    pelit = ALKUMARKAT;
    nytpanos = ALKUPANOS;
    KatsoRahaTilanne();
    TulostaVoittoluokat();
    PrinttaaPanos();
    PrinttaaPelitVoitot();
    VaritRuutuun(0);                    /* NORMAALIT VÄRIT */
    pelitilanne = 1;        
    GadgetitKondixeen();
    }


/********************* TUPLAUS-NAPPULA NOSTETTU *************************/

if ( id==16 && pelitilanne==5 )     /* TUPLAUS */
    {
    pelitilanne = 6;                /* TUPLAUSGADGETTI POIS PÄÄLTÄ */
    GadgetitKondixeen();

    if (tyhjennys==3)               /* VAIN YKSI KORTTI PÖYDÄLLÄ */
        {
        KortitPakkaan();
        }
    else                            /* VIISI KORTTIA PÖYDÄLLÄ */
        {
        valittu[0]=0;
        valittu[1]=0;
        valittu[2]=0;
        valittu[3]=0;
        valittu[4]=0;       
        KortitKasaan();
        }
    SetAPen(RP, 0);
    RectFill(RP, KORTTIX-1, KORTTIY-1, 315, KORTTIY+KORTTIK+1); 
    BltBitMapRastPort(&bitMap, 263, 161, RP, KORTTIX+2*KORTTIVALI+2*KORTTIL-1, KORTTIY-1, 51, 79, 0xC0);

    SetAPen(RP, 3);
    RectFill(RP, 0, 199, 319, 223);             /* ALAPALKKI PUNAISEKSI */
    tuplavoitto *= 2;
    ColorSquare(RP, 70, 202, 36, 18, 8);        /* ALALOOTA */
    sprintf(stringi, SekaTextit[9+KIELI]);      /* SUURI / PIENI */
    ShadowText(RP,  16, 215, 1, 4, stringi );
    KilistysAY();

    if (tuplavoitto > 100)
        {
        Sound(9, 100, 3);
        Delay(100);
        }

    i = Satunnaisluku(0, (SHORT)(51+jokerimukana) );        /* ARVONTA */
    kortit[57] = kortit[i];
    DeKoodaa();
    }


/**************** PIENI- / SUURI-NAPPULA NOSTETTU *********************/

if ( (id==15 || id==14) && pelitilanne == 6 )       /* PIENI / SUURI */
    {
    DeKoodaa();                 
    KortinGrafiikkaTalteen(2);
    KortinGrafiikka(2);     
    tyhjennys=3;

    /* ARVAUS OSUI OIKEAAN!!!!!!!!!!!!!!!! */
    if ( ( (id==15) && kortit[67]<7 ) || ( (id==14) && kortit[67]>7 ) || kortit[67]==15 )
        {
        /***** VOITTO TARPEEKSI SUURI -> YLÖS ******/
        if (tuplavoitto>100)
            {
            Delay(10);
            Sound(10, 100, 3);
            Delay(127);
            KilistysAAYY();
            PuhdistaAlapalkki();
            pelitilanne = 1;
            GadgetitKondixeen();
            }
        else    /* VOITTO EI HÄIKÄISSYT SUURUUDELLAAN -> TUPLAUS */
            {
            pelitilanne = 5;
            GadgetitKondixeen();
            SetAPen(RP, 3);
            RectFill(RP, 0, 199, 319, 223); /* ALAPALKKI PUNAISEKSI */
            ColorSquare(RP, 70, 202, 36, 18, 8);        /* ALALOOTA */
            sprintf(stringi, SekaTextit[12+KIELI]);
            ShadowText(RP,  16, 215, 1, 4, stringi );
            Sound(4, 100, 3);
            sprintf(stringi, "%3d", tuplavoitto);
            TextText(RP, 77, 215, 4, stringi );
            }
        }   /* if nytpanos ... */

    else                        /* ARVAUS EPÄONNISTUI -> PELITILANNE = 1 */
        {
        SetAPen(RP, 3);
        RectFill(RP, 0, 199, 319, 223);         /* ALAPALKKI PUNAISEKSI */
        ColorSquare(RP, 70, 202, 36, 18, 8);        /* ALALOOTA */
        ShadowText(RP,  16, 215, 1, 4, SekaTextit[15+KIELI] );
        TextText(RP, 77, 215, 4, "  0" );
        Sound(5, 100, 3);
        pelitilanne = 1;
        GadgetitKondixeen();
        KatsoRahaTilanne();
        }
    }       /* if id== ...     */


/******************* STRING-GADGET KUITATTU ENTERILLÄ *******************/

if (id==20)
    {
    strcpy(stringi, JonoPuskuri);
    for (i=strlen(stringi); i<23; i++)
        {
        stringi[i]=' ';
        }
    stringi[i]='\0';
    tulos[sijoitus-1]=voitot;
    sprintf(lista[sijoitus-1], "%s %5d", stringi, voitot);
    sprintf(stringi, "%s%d.  %s", (sijoitus<10) ? " " : "", sijoitus, lista[sijoitus-1]);
    ShadowText(RP, 22, (SHORT)(63+(sijoitus-1)*9), 16, 5, stringi);     
    voitot=0;

    infile = (struct FileHandle *)Open("POKERI.HIGHSCORE", MODE_OLDFILE);
    if ( infile != 0)
        {
        for(i=0; i<15; i++)
            {
            kirjoitettuja=Write((BPTR)infile, lista[i], 30);
            }
        Close((BPTR)infile);
        }
    else if ((infile = (struct FileHandle *)
            Open("POKERI.HIGHSCORE", MODE_NEWFILE)) != 0)
        {
        for(i=0; i<15; i++)
            {
            kirjoitettuja=Write((BPTR)infile, lista[i], 30);
            }
        Close((BPTR)infile);
        }

    PuhdistaAlapalkki();
    pelitilanne = 1;
    GadgetitKondixeen();
    tyhjennys=4;
    PrinttaaPelitVoitot();
    KatsoRahaTilanne();
    }

return(retval);

}   /* END OF HandleUGad() */




/****** FUNKTIO PIIRTÄÄ LAATIKON KOLMELLA VÄRILLÄ, MYÖS SISÄKEHYKSEN ******/
/*  x ja y = laatikon vasemman yläkulman koordinaatit
    width  = laatikon leveys    
    height = laatikon korkeus
    vari   = ensimmäisen palettivärin numero (eli vaalein savy) */

VOID ColorSquare(rp, x, y, width, height, vari)
struct RastPort *rp;
SHORT  x, y, width, height, vari;
{
UBYTE oldapen;

oldapen = rp->FgPen;
SetAPen (rp, vari);             /* VASEN- JA YLÄREUNA VAALEALLA */
Move    (rp, x+width, y);
Draw    (rp, x, y);
Draw    (rp, x, y+height);

SetAPen (rp, vari+1);           /* SISUSTA KESKIVÄRILLÄ */
RectFill(rp, x+1, y+1, x+width-1, y+height-1 );

SetAPen (rp, vari);             /* KEHYS VAALEALLA */
RectFill(rp, x+2, y+2, x+width-2, y+height-2 );

SetAPen (rp, vari+1);           /* SISUSTA KESKIVÄRILLÄ */
RectFill(rp, x+3, y+3, x+width-3, y+height-3 );
    
SetAPen (rp, vari+2);           /* OIKEA- JA ALAREUNA TUMMALLA */
Move    (rp, x+1, y+height);
Draw    (rp, x+width, y+height);
Draw    (rp, x+width, y);

SetAPen (rp, oldapen);
}




/************* PUHDISTAA ALAPALKIN JA TYHJÄÄ VALINNAT **************/

VOID PuhdistaAlapalkki()
{
SHORT i, x;

SetBPen(RP, 1);
for(i=0; i<5; i++)
    {
    valittu[i] = 0;
    }

for(x=0; x<25; x++)
    {
    WaitTOF();
    ScrollRaster(RP, 0, -1, 0, 199, 319, 223); 
    }
}




/************** FUNKTIO TULOSTAA VARJOSTETTUA TEKSTIÄ ***************/
/*  x ja y = tekstin vasemman yläkulman koordinaatit
    vari1  = pohjaväri
    vari2  = piirtoväri
    text   = tekstin osoite */

VOID ShadowText(rp, x, y, vari1, vari2, text)
struct RastPort *rp;
SHORT  x, y, vari1, vari2;
BYTE *text;
{
UBYTE oldapen;

oldapen = rp->FgPen;
SetAPen (rp, vari1);                /* ASETTAA PIIRTOVARIN */
Move    (rp, x, y);                 /* SIIRTÄÄ KYNÄÄ       */ 
Text    (rp, text, strlen(text));   /* TULOSTAA  TEKSTIN   */
SetAPen (rp, vari2);
Move    (rp, x-1, y-1);
Text    (rp, text, strlen(text));   
SetAPen (rp, oldapen);
}




/************** FUNKTIO TULOSTAA TAVALLISTA TEKSTIÄ ***************/
/*  x ja y = tekstin vasemman yläkulman koordinaatit
    vari2  = piirtoväri
    text   = tekstin osoite */

VOID PlainText(rp, x, y, vari1, vari2, text)
struct RastPort *rp;
SHORT x, y, vari1, vari2;
BYTE *text;
{
UBYTE oldapen;
UBYTE oldbpen;

oldapen = rp->FgPen;
oldbpen = rp->BgPen;
SetDrMd (rp, JAM2);                 /* ASETTAA PIIRTOMOODIN */
SetAPen (rp, vari1);                /* ASETTAA PIIRTOVARIN  */
SetBPen (rp, vari2);                /* ASETTAA TAUSTAVÄRIN  */
Move    (rp, x-1, y-1);             /* SIIRTÄÄ KYNÄÄ        */ 
Text    (rp, text, strlen(text));   /* TULOSTAA  TEKSTIN    */
SetDrMd (rp, JAM1);                 /* PALAUTTAA PIIRTOMOODIN */
SetAPen (rp, oldapen);
SetBPen (rp, oldbpen);
}




/*********** TULOSTAA TEKSTIÄ, SINISELLE POHJALLE JAM2:LLA **********/
/*  x ja y = tekstin vasemman yläkulman koordinaatit
    vari   = piirtoväri
    text   = tekstin osoite */

VOID TextText(rp, x, y, vari, text)
struct RastPort *rp;
SHORT x, y, vari;
BYTE *text;
{
UBYTE oldapen;
UBYTE oldbpen;

oldapen = rp->FgPen;                    /* VANHA PIIRTOVÄRI       */
oldbpen = rp->BgPen;                    /* VANHA TAUSTAVÄRI       */
SetFont (rp, textFont);                 /* ASETTAA PIIRTOFONTIN   */
SetBPen (rp, 9);                        /* ASETTAA TAUSTAVÄRIN    */
SetDrMd (rp, JAM2);                     /* ASETTAA PIIRTOMOODIN   */
SetAPen (rp, vari);                     /* ASETTAA PIIRTOVÄRIN    */
Move    (rp, x, y);                     /* SIIRTÄÄ KYNÄN          */
Text    (rp, text, strlen(text));       /* TULOSTAA TEKSTIN       */
SetBPen (rp, 0);                        /* PALAUTTAA TAUSTAVÄRIN  */
SetDrMd (rp, JAM1);                     /* PALAUTTAA PIIRTOMOODIN */
SetFont (rp, oldTextFont);              /* PALAUTTAA PIIRTOFONTIN */
SetAPen (rp, oldapen);                  /* PALAUTTAA PIIRTOVÄRIN  */
SetBPen (rp, oldbpen);                  /* PALAUTTAA TAUSTAVÄRIN  */
}




/*********** TULOSTAA PELIT JA VOITOT KULLOISELLA KIELELLÄ **************/

VOID  TekstiPelitVoitot(kieli)
UBYTE kieli;
{
UBYTE oldapen;

oldapen = RP->FgPen;
SetAPen(RP, 9);
RectFill(RP, 19, 10, 87, 20);
ShadowText(RP, 21, 19, 1, 4, Peitot[KIELI*2]);      /* PELIT */
SetAPen(RP, 9);
RectFill(RP, 198, 10, 255, 20);
ShadowText(RP, 200, 19, 1, 4, Peitot[KIELI*2+1]);   /* VOITOT */
SetAPen(RP, oldapen);
}




/********* TULOSTAA KORTIT PÖYTÄÄN *************************/

VOID TulostaKortit()
{
SHORT i;

SetAPen(RP, 0);                     /* POISTETAAN PAKKA JA TEKSTIT */
RectFill(RP, 10, 33, 300, KORTTIY-2);

DeKoodaa();                         /* DEKOODATAAN KORTIT */

i=0;
while(i<5)                          /* PIIRRETÄÄN VIISI KORTTIA */
    {
    WaitTOF();
    Sound(7, 90, 3);
    BltBitMapRastPort(&bitMap, 263, 161,
        RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1, 35, 51, 79, 0xC0);
    Delay(5);

    WaitTOF();
    BltBitMapRastPort(&bitMap, 263, 161,
        RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1, 51, 79, 0xC0);
    Delay(8);

    SetAPen(RP, 0);
    RectFill(RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1,
        35, KORTTIX+i*KORTTIVALI+i*KORTTIL+KORTTIL-1, KORTTIY-2);
    i++;
    }

i=0;
while(i<5)                          /* KÄÄNNETÄÄN VIISI KORTTIA */
    {
    Sound(7, 90, 3);
    KortinGrafiikkaTalteen(i);
    KortinGrafiikka(i);
    Delay(1);
    i++;
    }

PiirraPakka();
TulostaVoittoluokat();
}   




/************ TULOSTAA KORTIT PÖYTÄÄN JA KÄÄNTÄÄ NE HETI **************/

VOID TulostaKortit2()
{
SHORT i, x, y;
SHORT index;

SetAPen(RP, 0);                     /* POISTETAAN PAKKA JA TEKSTIT */
RectFill(RP, 10, 33, 300, KORTTIY-2);

DeKoodaa();                         /* DEKOODATAAN KORTIT */

i=5;
x=0;
index=0;
while(i--)
    {
    if(valittu[i]==1)
        {
        x++;        /* VALITTUJEN LUKUMÄÄRÄ */
        }
    }
i=0;
while(i<5)                          /* PIIRRETÄÄN VIISI KORTTIA */
    {
    if (valittu[i]==0)              /* PIIRRETÄÄNKÖ KORTTI? */
        {
        WaitTOF();
        Sound(7, 90, 3);
        BltBitMapRastPort(&bitMap, 263, 161,
            RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1, 35, 51, 79, 0xC0);
        Delay(5);
        WaitTOF();
        BltBitMapRastPort(&bitMap, 263, 161,
            RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1, 51, 79, 0xC0);
        Delay(8);
        index++;
        SetAPen(RP, 0);
        RectFill(RP, KORTTIX+i*KORTTIVALI+i*KORTTIL-1,
            35, KORTTIX+i*KORTTIVALI+i*KORTTIL+KORTTIL-1, KORTTIY-2);
        KortinGrafiikkaTalteen(i);
        if ( index == 5-x )
            {
            PiirraPakka();

/*          SetAPen(RP, 0);
            for (y=0; y<240; y+=4)
                {
                WaitTOF();
                BltBitMapRastPort(&bitMap, 243, 161, RP,
                    4+y, 35, 71, 79, 0xC0);
                Delay(1);
                }
*/
            for (y=1; y<4; y++)                 /* PIHISTETÄÄN!! */
                {
                WaitTOF();
                BltBitMapRastPort(&bitMap, 263, 161, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y,51,79,0xC0);
                BltBitMapRastPort(&cardbitMap, 0, y-1, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y-1,51,1,0xC0);
                Delay(8);
                }
            for (y=4; y<15; y++)
                {
                WaitTOF();
                BltBitMapRastPort(&bitMap, 263, 161, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y,51,82-y,0xC0);
                BltBitMapRastPort(&cardbitMap, 0, y-1, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y-1,51,1,0xC0);
                Delay(8);
                }
            for (y=15; y<29; y++)
                {
                WaitTOF();
                BltBitMapRastPort(&bitMap, 263, 161, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y,51,82-y,0xC0);
                BltBitMapRastPort(&cardbitMap, 0, y-1, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y-1,51,1,0xC0);
                }
            for (y=29; y<82; y+=2)
                {
                WaitTOF();
                BltBitMapRastPort(&bitMap, 263, 161, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y,51,82-y,0xC0);
                BltBitMapRastPort(&cardbitMap, 0, y-1, RP,
                  KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1+y-1,51,2,0xC0);
                }
            }
        else
            {
            KortinGrafiikka(i);
            }
        }
    i++;
    }

if ( x == 5 )
    {
    PiirraPakka();
    }

TulostaVoittoluokat();
}   




/**************** KÄÄNTÄÄ VALITSEMATTOMAT KORTIT NURIN ******************/

VOID TaustaKortit()
{
SHORT i;

i=0;
while(i<5)
    {
    WaitTOF();
    if (valittu[i]==0)      /* KÄÄNNETÄÄNKÖ KORTTI? */
        {
        BltBitMapRastPort(&bitMap, 263, 161, RP,
            KORTTIX+i*KORTTIVALI+i*KORTTIL-1, KORTTIY-1, 51, 79, 0xC0);
        }
    i++;
    }
}   




/*************** POISTAA VALITSEMATTOMAT KORTIT PÖYDÄLTÄ ***************/

VOID KortitPois()
{
SHORT i, j;

TaustaKortit();
Delay(5);

for (i=0; i<5; i++)
    {
    WaitTOF();
    if (valittu[i]==0)          /* POISTETAANKO KORTTI? */
        {
        Sound(6, 100, 3);
        for (j=0; j<21; j++)
            {
            ScrollRaster(RP, 0, -4, KORTTIX+i*KORTTIVALI+i*KORTTIL-1,
                KORTTIY-1, KORTTIX+i*KORTTIVALI+i*KORTTIL+49, KORTTIY+80); 
            WaitTOF();
            }
        }
    }
}   




/************* KERÄÄ PÖYDÄLLÄ LOJUVAT KORTIT KESKELLE KASAAN ************/

VOID KortitKasaan()
{
SHORT i;

TaustaKortit();     /* KÄÄNNETÄÄN ENSIN */
Delay(5);

i=0;
while(i<12)         /* KERÄTÄÄN */
    {
    WaitTOF();
    ClipBlit(RP, KORTTIX-KORTTIVALI-3+i*KORTTIVALI, KORTTIY-1, RP,
        KORTTIX-3+i*KORTTIVALI, KORTTIY-1, 64, 79, 0xC0);
    WaitTOF();
    ClipBlit(RP, 256-KORTTIVALI*i, KORTTIY-1, RP,
        246-KORTTIVALI*i, KORTTIY-1, 61, 79, 0xC0);
    i++;
    }
KortitPakkaan();    /* JA YLÖS PAKKAAN */
}   




/****************** HEITTÄÄ KORTIT KESKELTÄ PAKKAAN **********************/

VOID KortitPakkaan()
{
SHORT i;
SHORT x=135, y=118;

SetAPen (RP, 0);                    /* ENSIN ESISIIRTO KESKELLÄ */
RectFill(RP, 145, 33, 300, 116);
WaitTOF();
BltBitMapRastPort(&bitMap, 263, 161, RP,
    KORTTIX+2*KORTTIVALI+2*KORTTIL-1, KORTTIY-1, 51, 79, 0xC0);
ClipBlit(RP, x, y, RP, x-2, y-4, 55, 80, 0xC0);
RectFill(RP, x-2, y+71, x+60, y+80);

x=133;                              /* VARSINAINEN SIIRTO */
y=112;  
Sound(7, 100, 3);
for(i=0; i<10; i++)
    {
    WaitTOF();
    ClipBlit(RP, x-i*12, y-i*8, RP, (x-12)-i*12, (y-8)-i*8, 63, 87, 0xC0);
    }

PiirraPakka();                      /* PAKKA YLHÄÄLLÄ KUNTOON */
}   




/******************* TULOSTAA VOITTOLUOKAT JA VOITOT **********************/

VOID TulostaVoittoluokat()
{
SHORT i;

SetAPen(RP, 0);
if (tyhjennys==4)
    {
    RectFill(RP, 5, 32, 317, 197);      /* RUUTU TYHJÄKSI */
    }

if (nytpanos>1)             /* MUKANA 'VIITOSET' */
    {
    sprintf(stringi, "%s  %4d", voittonimet[KIELI*8],
        voittosummat[nytpanos][0]);
    PlainText(RP, 147, 45, 7, 0, stringi );
    }
else 
    {
    RectFill(RP, 145, 37, 300, 45); 
    }

for (i=1; i<8; i++)         /* TULOSTETAAN VOITOT */
    {
    sprintf(stringi, "%s  %4d", voittonimet[i+KIELI*8],
        voittosummat[nytpanos][i]);
    PlainText(RP, 147, (SHORT)(45+i*9), 7, 0, stringi );
    }
}




/******* HAKEE KORTIN GRAFIIKAN BITTIKARTASTA MÄÄRÄTTYYN PAIKKAAN *******/
/*  i = numero 0..4 maskeeraa kortin paikkaa näytöllä */ 

VOID KortinGrafiikka(i)
SHORT i;
{

BltBitMapRastPort(&cardbitMap, 0, 0, RP,
    (SHORT)(KORTTIX+i*KORTTIVALI+i*KORTTIL-1), KORTTIY-1, 51, 79, 0xC0 );
}




/************* TULOSTAA KORTIN GRAFIIKAN PIILOBITTIKARTTAAN **************/

VOID KortinGrafiikkaTalteen(i)
SHORT i;
{
SHORT kkk, maa;

SetAPen(&cardRP, 4);
RectFill(&cardRP, 0, 0, KORTTIL, KORTTIK );

if(kortit[55+i]==255)
    {
    BltBitMapRastPort(&bitMap, 263, 3, &cardRP, 0, 0, 51, 79, 0xC0 );
    }
else
    {
    if(kortit[60+i]==128)       /* PATA */
        maa=0;
    if(kortit[60+i]==64)        /* HERTTA */
        maa=1;
    if(kortit[60+i]==32)        /* RISTI */
        maa=2;
    if(kortit[60+i]==16)        /* RUUTU */
        maa=3;

    kkk = kortit[65+i]-1;
    BltBitMapRastPort(&bitMap, 3+kkk*11, ((maa==0)||(maa==2))?1:12,
        &cardRP, 2, 2, 10, 11, 0xC0 );
    BltBitMapRastPort(&bitMap, 220+maa*10,  4, &cardRP, 1, 13, 11, 12, 0xC0 );
    BltBitMapRastPort(&bitMap, 220+maa*10, 15, &cardRP, 39, 54, 11, 12, 0xC0 );
    BltBitMapRastPort(&bitMap, 3+kkk*11, ((maa==0)||(maa==2))?23:35,
        &cardRP, 39, 65, 10, 11, 0xC0 );

    if (kkk<10)
        {
        BltBitMapRastPort(&bitMap, 2+kkk*24, 51+maa*50, &cardRP, 13, 14, 25, 51, 0xC0);
        }
    else
        {
        BltBitMapRastPort(&bitMap, 146+(kkk-10)*24, 1, &cardRP, 13, 14, 25, 51, 0xC0);
        }
    }   /* else kortit ... */
}




/*********************** PRINTTAA PANOKSEN KONDIKSEEN ****************/ 

VOID PrinttaaPanos()
{

SetAPen(RP, 7);
sprintf(stringi, "%d", panokset[nytpanos]);
RectFill(RP, 140, 10, 153, 19);
ShadowText(RP, (SHORT)((strlen(stringi)==2)?140:144), 18, 18, 19, stringi);
        
if (nytpanos>1)                         /* ONKO PANOS >= 3 mk ? */
    {
    jokerimukana = 1;
    }
else                                    /* PANOS == 1 tai 2     */
    {
    OtaPoisJokeri();
    }

TulostaVoittoluokat();
}




/***************** TÄMÄ ALIOHJELMA TARKISTAA VOITOT *******************/

SHORT TarkistaVoitot()
{
SHORT i, j, voittonumero=8;
UBYTE apusuora1=0, apusuora2=0, apusuora3=0, jokeri=0, pari=0;
UBYTE kolmoset=0, apuvari=0, vari=0, suora=0; 

/* LAJITELLAAN TAULUKON kortit[54-59] ALKIOT, PIENIN ENSIN */

for (i=55; i<59; i++)
    {
    for (j=i+1; j<60; j++)
        {
        if ( kortit[j] < kortit[i] )
            {
            apusuora1 = kortit[j];
            kortit[j] = kortit[i];
            kortit[i] = apusuora1;
            }
        }
    }

DeKoodaa();

/* LAJITELLAAN TAULUKON kortit[64-69] ALKIOT, PIENIN ENSIN */

for (i=65; i<69; i++)
    {
    for (j=i+1; j<70; j++)
        {
        if ( kortit[j] < kortit[i] )
            {
            apusuora1 = kortit[j];
            kortit[j] = kortit[i];
            kortit[i] = apusuora1;
            }
        }
    }

apusuora1=0;

    
/******************************* S U O R A *************************/   

if ( (kortit[69]-kortit[65]) ==4)
    apusuora1=1;
if ( ( (kortit[68]-kortit[65]) ==3) && (kortit[69]==15) )
    apusuora2=1;
if ( ( (kortit[68]-kortit[65]) ==4) && (kortit[69]==15) )
    apusuora3=1;
if ( (kortit[65]==1) && (kortit[66]==10) && (kortit[67]==11) && (kortit[68]==12) && (kortit[69]==13) )
    {
    voittonumero=5;
    suora=1;
    }
if ( (kortit[65]==1) && (kortit[66]==10) && (kortit[67]==11) && (kortit[68]==12) && (kortit[69]==15) )
    {
    voittonumero=5;
    suora=1;
    }
if ( (kortit[65]==1) && (kortit[66]==10) && (kortit[67]==12) && (kortit[68]==13) && (kortit[69]==15) )
    {
    voittonumero=5;
    suora=1;
    }
if ( (kortit[65]==1) && (kortit[66]==10) && (kortit[67]==11) && (kortit[68]==13) && (kortit[69]==15) )
    {
    voittonumero=5;
    suora=1;
    }
if ( (kortit[65]==1) && (kortit[66]==11) && (kortit[67]==12) && (kortit[68]==13) && (kortit[69]==15) )
    {
    voittonumero=5;
    suora=1;
    }
if ( kortit[69]==15 ) jokeri=1;             /* JOKERI MUKANA */


/******************************* P A R I T *************************/   

for (i=65; i<69; i++)
    if (kortit[i]==kortit[i+1]) pari++;


/**************************** K O L M O S E T **********************/   

for (i=65; i<68; i++)
    if ( (kortit[i]==kortit[i+1]) && (kortit[i+1]==kortit[i+2]) ) kolmoset++;


/*******************************************************************/   

if ( (kortit[60]==kortit[61]) && (kortit[61]==kortit[62]) && (kortit[62]==kortit[63]) )   apuvari=1;


/******************************* S U O R A *************************/   

if ( (pari==0) && (apusuora1 || apusuora2 || apusuora3) )
    {
    voittonumero=5;
    suora=1;
    }


/******************************** V Ä R I **************************/   

if ( apuvari && ( (kortit[64]==kortit[63]) || jokeri ) ) 
    {
    voittonumero=4;
    vari=1;
    }   


/******************************* R E E T I *************************/   

if ( vari && suora ) 
    voittonumero=1;


/************************* K A K S I  P A R I A ********************/   

if ( pari==2 && kolmoset==0)
    voittonumero=7;


/*************************** K O L M I L U K U *********************/   

if ( kolmoset==1 || ( (pari==1) && jokeri ) )
    voittonumero=6;


/**************************** T Ä Y S K Ä S I **********************/   

if ( ( (pari==2) && jokeri && kolmoset==0 ) || ( (pari==3) && (kolmoset==1) ) )
    voittonumero=3;
 

/**************************** N E L I L U K U **********************/   

if ( (kolmoset==2) || ( kolmoset==1 && jokeri ) )
    voittonumero=2;


/**************************** V I I T O S E T **********************/   

if ( (kolmoset==2) && jokeri )
    voittonumero=0;

return (voittonumero); 
}




/****** TÄMÄ FUNKTIO VÄHENTÄÄ PANOKSEN VERRAN PELISTÄ/VOITOISTA *******/

VOID VahennaRahaa()
{
pelit -= panokset[nytpanos];        /* PÄIVITETÄÄN HINNAT    */
if (pelit<0)                        /* PELIRAHA EI RIITTÄNYT */
    {
    voitot += pelit;                /* -> OTETAAN VOITOISTA  */
    pelit = 0;
    }
PrinttaaPelitVoitot();
}




/********  TÄMÄ FUNKTIO PRINTTAA PELIT JA VOITOT KONDIKSEEN **********/

VOID PrinttaaPelitVoitot()
{

sprintf(stringi, "%5ld", voitot);
TextText(RP, 260, 19, 4, stringi );

sprintf(stringi, "%2ld", pelit);
TextText(RP, 88, 19, 4, stringi );
}




/******** TÄMÄ FUNKTIO TARKISTAA RAHATILANTEEN, VÄHENTÄÄ YMS. *********/

VOID KatsoRahaTilanne()
{
SHORT panos=nytpanos;

if( (pelit+voitot) <= 0)
    {
    nytpanos = 0;
    PrinttaaPanos();
    GameOver();
    }
else
    {
    while( (pelit+voitot) < panokset[nytpanos] )
        nytpanos--;

    if ( nytpanos<2 )
        OtaPoisJokeri();

    if (panos!=nytpanos)
        PrinttaaPanos();
    }
}




/****************** TÄMÄ FUNKTIO VÄLÄYTTÄÄ PUNAISTA ******************/

VOID Valauta()
{
if ( voitot >= 50 )
    {
    VaritRuutuun(32);       /* PUNASÄVYINEN PALETTI */
    Delay(17);
    VaritRuutuun(0);        /* VÄRIT NORMAALIKSI */
    }
}




/********* TÄMÄ FUNKTIO PÄIVITTÄÄ GADGETIT ja nyt MYÖS VÄRIT *********/

VOID GadgetitKondixeen()
{
USHORT i;
    
RemoveGList(window, &Painike[5], -1);
AddGadget(window, &Eexit, -1);

if (pelitilanne == 1)                               /* PERUSTILANNE */
    {
    AddGadget(window, &Panos, -1);
    AddGadget(window, &Painike[3], -1);                 /* PANOS */
    SetRGB4(&screen->ViewPort, 20,  4, 12, 15);
        varitila[20]=1;
    SetRGB4(&screen->ViewPort, 21,  0, 10, 15);
        varitila[21]=1;
    SetRGB4(&screen->ViewPort, 22,  0,  7, 14);
        varitila[22]=1;
    AddGadget(window, &Painike[5], -1);                 /* JAKO  */
    SetRGB4(&screen->ViewPort, 26,  8, 15,  8);
        varitila[26]=1;
    SetRGB4(&screen->ViewPort, 27,  0, 14,  0);
        varitila[27]=1;
    SetRGB4(&screen->ViewPort, 28,  0, 11,  0);
        varitila[28]=1;
    AddGadget(window, &Voitot, -1);                 /* VOITOT YLHÄÄLLÄ */
    if (voitot>0)                                   /* VOITONMAKSU */
        {
        AddGadget(window, &Painike[4], -1);             /* VOITONM */
        SetRGB4(&screen->ViewPort, 23, 15, 15, 13);     
            varitila[23]=1;
        SetRGB4(&screen->ViewPort, 24, 15, 15,  5);     
            varitila[24]=1;
        SetRGB4(&screen->ViewPort, 25, 12, 12,  0);     
            varitila[25]=1;
        }
    }
if (pelitilanne == 2)                               /* EI 'VALITTU'JA */
    {
    AddGadget(window, &KorttiPohja[0], -1);         /* KORTIT */
    AddGadget(window, &KorttiPohja[1], -1);
    AddGadget(window, &KorttiPohja[2], -1);
    AddGadget(window, &KorttiPohja[3], -1);
    AddGadget(window, &KorttiPohja[4], -1);
    }
if (pelitilanne == 3)                               /* ON 'VALITTU'JA */
    {
    AddGadget(window, &KorttiPohja[0], -1);         /* KORTIT */
    AddGadget(window, &KorttiPohja[1], -1);
    AddGadget(window, &KorttiPohja[2], -1);
    AddGadget(window, &KorttiPohja[3], -1);
    AddGadget(window, &KorttiPohja[4], -1);
    AddGadget(window, &Painike[5], -1);             /* JAKO  */
    SetRGB4(&screen->ViewPort, 26,  8, 15,  8);
        varitila[26]=1;
    SetRGB4(&screen->ViewPort, 27,  0, 14,  0);
        varitila[27]=1;
    SetRGB4(&screen->ViewPort, 28,  0, 11,  0);
        varitila[28]=1;
    }
if (pelitilanne == 4)                               /* GADGETIT POIS */
    {
    AddGadget(window, &Pelit, -1);
    }
if (pelitilanne == 5)                       /* TUPLAUS / VOITONMAKSU */
    {
    AddGadget(window, &Voitot, -1);                 /* VOITOT YLHÄÄLLÄ */
    AddGadget(window, &Painike[0], -1);             /* TUPLAUS */
    SetRGB4(&screen->ViewPort, 11, 15, 11,  5);
        varitila[11]=1;
    SetRGB4(&screen->ViewPort, 12, 15,  9,  0);
        varitila[12]=1;
    SetRGB4(&screen->ViewPort, 13, 13,  6,  3);
        varitila[13]=1;
    AddGadget(window, &Painike[4], -1);             /* VOITONMAKSU */
    SetRGB4(&screen->ViewPort, 23, 15, 15, 13);     
        varitila[23]=1;
    SetRGB4(&screen->ViewPort, 24, 15, 15,  5);     
        varitila[24]=1;
    SetRGB4(&screen->ViewPort, 25, 12, 12,  0);     
        varitila[25]=1;
    }
if (pelitilanne == 6)                               /* PIENI / SUURI */
    {
    AddGadget(window, &Painike[1], -1);             /* PIENI */
    SetRGB4(&screen->ViewPort, 14, 15, 11,  5);
        varitila[14]=1;
    SetRGB4(&screen->ViewPort, 15, 15,  9,  0);
        varitila[15]=1;
    SetRGB4(&screen->ViewPort, 16, 13,  6,  3);
        varitila[16]=1;
    AddGadget(window, &Painike[2], -1);             /* SUURI */
    SetRGB4(&screen->ViewPort, 29, 15, 11,  5);
        varitila[29]=1;
    SetRGB4(&screen->ViewPort, 30, 15,  9,  0);
        varitila[30]=1;
    SetRGB4(&screen->ViewPort, 31, 13,  6,  3);
        varitila[31]=1;
    }
if (pelitilanne == 7)                               /* LISTALLA */
    {
    AddGadget(window, &Jono, -1);                   /* PIENI */
    }
if (pelitilanne == 11)                              /* GAME OVER */
    {
    AddGadget(window, &Pelit, -1);                  /* PELIT */
    }

for (i=11; i<32; i++)
    {
    if (varitila[i]==0)
        SetRGB4(&screen->ViewPort, i, varit[i*3], varit[i*3+1], varit[i*3+2]);
    varitila[i]=0;
    }

RefreshGList(&Painike[5], window, NULL, -1);    /* GADGETIT KEHIIN */
}




/**************************** PIIRTÄÄ PAKAN ****************************/

VOID PiirraPakka()
{
/*
SHORT i=3;

while(i--)
    {
    BltBitMapRastPort(&bitMap, 263, 161, RP, KORTTIX+i*2-4, 33+i*2, 51, 79, 0xC0);
    SetAPen(RP, 0);
    Move(RP, KORTTIX+i*2-3+KORTTIL, 33+i*2);
    Draw(RP, KORTTIX+i*2-3+KORTTIL, 33+i*2+KORTTIK+1);
    Draw(RP, KORTTIX+i*2-3, 33+i*2+KORTTIK+1);
    }
*/
SetAPen(RP, 0);
RectFill(RP, 10, 32, 70, 115); 
BltBitMapRastPort(&bitMap, 263, 161, RP, KORTTIX-1, 35, 51, 79, 0xC0);
}




/******* TÄMÄ FUNKTIO OTTAA PAKASTA VIISI ENSIMMÄISTÄ KORTTIA ********/

VOID JaaAlkuKortit()
{
SHORT i=5;
SHORT ko;

while(i--)
    {
    ko= Satunnaisluku((SHORT)(4-i), (SHORT)(51+jokerimukana) ); 
    kortit[55+i] = kortit[ko];
    kortit[ko]   = kortit[4-i]; 
    kortit[4-i]  = kortit[55+i];
    }
}




/******************* TÄMÄ FUNKTIO OTTAA LOPUT KORTIT ******************/

VOID JaaLoputKortit()
{
SHORT x=0, i=5;
SHORT ko;

while(i--)
    {
    if(valittu[i]==0)
        {
        ko= Satunnaisluku( (SHORT)(5+x), (SHORT)(51+jokerimukana) ); 
        x++;
        kortit[55+i] = kortit[ko];
        kortit[ko]   = kortit[4+x]; 
        kortit[4+x]  = kortit[55+i];
        }
    }
}




/********** TÄMÄ FUNKTIO ANTAA SATUUNAISLUVUN VÄLILTÄ [A,B] **********/
/*   a = alin kokonaisluku, joka saa tulla arvonnassa
     b = ylin kokonaisluku, joka saa tulla arvonnassa */

SHORT Satunnaisluku(a, b)
SHORT a, b;
{
FLOAT satu;
USHORT luku;
    
luku = rand() ;
satu = luku / 1.0;
satu *= 1.52588693065;
satu /= 100000;
    
return ((SHORT)(satu*(b-a+1)+a));

}




/***************** DEKOODAA KORTIN MAAN JA NUMERON ******************/

VOID DeKoodaa()
{
SHORT i=5;

while(i--)
    {
    kortit[60+i] = kortit[55+i]&'\xf0' ;            /* MAA    */
    kortit[65+i] = kortit[55+i]&'\x0f' ;            /* NUMERO */
    }
}




/******************* RAHAT LOPPU ---->>  GAMEOVER ********************/

VOID GameOver()
{
PuhdistaAlapalkki();
pelitilanne = 11;
GadgetitKondixeen();
VaritRuutuun(64);               /* VÄRIT VIHREÄNSÄVYISIKSI */
Sound(8, 100, 3);
}




/************** TÄMÄ FUNKTIO OTTAA JOKERIN POIS PAKASTA **************/

VOID OtaPoisJokeri()
{
SHORT i=0;

while(kortit[i++] != 0xFF)
    {
        ;
    }
    kortit[i-1] = kortit[52];
    kortit[52] = 0xFF;
    jokerimukana = 0;
}




/****************** KILISTETÄÄN RAHAA ALHAALTA YLÖS ********************/

VOID KilistysAAYY()
{
SHORT i;

for(i=panokset[nytpanos]; i<(tuplavoitto+1); i+=panokset[nytpanos])
    {
    sprintf(stringi, "%5ld", i+voitot);
    TextText(RP, 260, 19, 4, stringi); 
    sprintf(stringi, "%3ld", tuplavoitto-i);
    TextText(RP, 77, 215, 4, stringi); 
    Sound(3, 100, 0);
    Delay( (LONG)((TICKS_PER_SECOND*panokset[nytpanos]) / tuplavoitto) );
    }
voitot += tuplavoitto;
Valauta();
}




/***************** KILISTETÄÄN RAHAA ALHAALLA YLÖSPÄIN ******************/

VOID KilistysAY()
{
SHORT i;

for(i=(tuplavoitto==voittosumma)?panokset[nytpanos]:
            tuplavoitto/2+panokset[nytpanos];
            i<(tuplavoitto+1); i+=panokset[nytpanos])
    {
    sprintf(stringi, "%3ld", i);
    TextText(RP, 77, 215, 4, stringi); 
    Sound(3, 100, 1);
    Delay( (LONG)((TICKS_PER_SECOND*panokset[nytpanos]) / tuplavoitto) );
    }
}




/***************** KILISTETÄÄN RAHAA YLHÄÄLLÄ YLÖSPÄIN ******************/

VOID KilistysYY()
{
SHORT i;

for(i=voitot+panokset[nytpanos]; i<(voitot+tuplavoitto+1);
            i+=panokset[nytpanos])
    {
    sprintf(stringi, "%5ld", i);
    TextText(RP, 260, 19, 4, stringi); 
    Sound(3, 100, 2);
    Delay( (LONG)((TICKS_PER_SECOND*panokset[nytpanos]) / tuplavoitto) );
    }
voitot += tuplavoitto;
Valauta();
}




/********* TULOSTETAAN RUUDUN VÄRIT TAULUKOSTA KOHDASTA taulu ***********/

VOID VaritRuutuun(taulu)        /* taulu VOI SAADA ARVOJA 0, 32, 64, 96 */
SHORT taulu;
{
USHORT i;

for (i=0; i<11; i++)
    {
    SetRGB4(&screen->ViewPort, i, varit[(i+taulu)*3], varit[(i+taulu)*3+1], varit[(i+taulu)*3+2]);
    }
SetRGB4(&screen->ViewPort, 18, varit[(18+taulu)*3], varit[(18+taulu)*3+1], varit[(18+taulu)*3+2]);
SetRGB4(&screen->ViewPort, 19, varit[(19+taulu)*3], varit[(19+taulu)*3+1], varit[(19+taulu)*3+2]);

}




/*********************** JAKO-NAPPULA NOSTETTU ***************************/

VOID Jako()
{
if(pelitilanne==1)          /* 1. JAKO */
    {
    if (ReadPixel(RP, 2, 202) == 3L)        /* ALAPALKKI ON PUNAINEN */
        PuhdistaAlapalkki();
    pelitilanne = 2;
    GadgetitKondixeen();
    VahennaRahaa();
    JaaAlkuKortit();
    if (tyhjennys==1)       /* PELIKENTTÄ ON TYHJÄ */
        {
        TulostaKortit();
        }
    else if (tyhjennys==2)  /* VIISI KORTTIA */
        {
        KortitKasaan();
        Delay(VIIVE);
        TulostaKortit();
        }
    else if (tyhjennys==3)  /* YKSI KORTTI KESKELLÄ */
        {
        KortitPakkaan();
        Delay(VIIVE);
        TulostaKortit();
        }
    else                    /* LISTA NÄKYVISSÄ */
        {
        SetAPen(RP, 0);
        RectFill(RP, 5, 32, 319, 197);      /* RUUTU TYHJÄKSI */
        tyhjennys=2;
        TulostaKortit();
        }
    tyhjennys = 2;          /* NYT PÖYDÄLLÄ VIISI KORTTIA */
    }
if(pelitilanne==3)          /* 2. JAKO */
    {
    pelitilanne = 4;        /* GADGETIT POIS PÄÄLTÄ */
    GadgetitKondixeen();
    JaaLoputKortit();
    KortitPois();
    Delay(VIIVE);
    TulostaKortit2();
    nytvoitto = TarkistaVoitot();
    if (nytvoitto <8)       /* VOITTO TULI!! */
        {
        voittosumma = voittosummat[nytpanos][nytvoitto];
        tuplavoitto = voittosumma;

        /***** VOITTO TARPEEKSI SUURI -> YLÖS ******/
        if (voittosumma>100)
            {
            sprintf(stringi, "%s %4d MK", voittonimet[8*KIELI+nytvoitto], voittosumma);
            PlainText(RP, 147, (SHORT)(45+nytvoitto*9), 3, 0, stringi );
            KilistysYY();               
            PuhdistaAlapalkki();
            pelitilanne = 1;
            GadgetitKondixeen();
            tyhjennys=2;
            sprintf(stringi, "%s  %4d", voittonimet[8*KIELI+nytvoitto], voittosumma);
            PlainText(RP, 147, (SHORT)(45+nytvoitto*9), 7, 0, stringi );
            }
        else    /* VOITTO EI OLLUT LIIAN SUURI -> TUPLAUS */
            {
            PuhdistaAlapalkki();
            pelitilanne = 5;        /* TUPLAUS / VOITONMAKSU */
            GadgetitKondixeen();
            SetAPen(RP, 3);
            RectFill(RP, 0, 199, 319, 223); /* ALAPALKKI PUNAISEKSI */
            sprintf(stringi, "%s  %4d", voittonimet[8*KIELI+nytvoitto], voittosumma);
            PlainText(RP, 147, (SHORT)(45+nytvoitto*9), 3, 0, stringi );

            ColorSquare(RP, 70, 202, 36, 18, 8);        /* ALALOOTA */

            sprintf(stringi, SekaTextit[12+KIELI]);
            ShadowText(RP,  16, 215, 1, 4, stringi );
            KilistysAY();       /* RAHAA ALAPALKKIIN */
            }
        }
    else                        /* VOITTOA EI HERUNUT */
        {
        PuhdistaAlapalkki();
        pelitilanne = 1;
        GadgetitKondixeen();
        KatsoRahaTilanne();
        tyhjennys=2;
        }
    }       /* if (pelitilanne == 3) */
}           /* end of Jako()         */




/**************************** MUUTA KIELTÄ ******************************/

VOID MuutaKielta(kieli) /* kieli == 0 => SUOMI, 1 = ENGLANTI, 2 = RUOTSI */
UBYTE kieli;
{
SHORT i;

if (kieli == 0 && KIELI != 0)   /* SUOMEKSI */
    {
    for (i=0; i<6; i++)
        {
        Painike[5-i].GadgetRender = (APTR)&PainikeImage[i*2];
        Painike[5-i].SelectRender = (APTR)&PainikeImage[i*2+1];
        }
    KIELI = 0;
    TekstiPelitVoitot(KIELI);
    }

if (kieli == 1 && KIELI != 1)   /* ENGLANNIKSI */
    {
    for (i=0; i<6; i++)
        {
        Painike[5-i].GadgetRender = (APTR)&PainikeImage[12+i*2];
        Painike[5-i].SelectRender = (APTR)&PainikeImage[13+i*2];
        }
    KIELI = 1;
    TekstiPelitVoitot(KIELI);
    }

if (kieli == 2 && KIELI != 2)   /* RUOTSIKSI */
    {
/*  KIELI = 2; */
    }

RemoveGList(window, &Painike[5], -1);
AddGadget(window, &Painike[5], -1);
RefreshGadgets(&Painike[5], window, NULL);
AddGadget(window, &Painike[4], -1);
RefreshGadgets(&Painike[4], window, NULL);
AddGadget(window, &Painike[3], -1);
RefreshGadgets(&Painike[3], window, NULL);
AddGadget(window, &Painike[2], -1);
RefreshGadgets(&Painike[2], window, NULL);
AddGadget(window, &Painike[1], -1);
RefreshGadgets(&Painike[1], window, NULL);
AddGadget(window, &Painike[0], -1);
RefreshGadgets(&Painike[0], window, NULL);
GadgetitKondixeen();
TulostaVoittoluokat();
}




/******************************** ABOUT *********************************/

#if defined FEA_NOT_ENGLISH_GIFTWARE
VOID Aboutti()
{
struct Window *aboutwindow;
struct IntuiMessage *mssg = NULL;   /* VIESTIPOINTTERI              */
SHORT  lippu;                       /* FALSE, KUN ABOUTTI LOPPUU    */
ULONG  luokka;                      /* INTUITIONVIESTIN LUOKITUS    */
SHORT  i;

aboutWindow.Screen = screen;

if ( aboutwindow = (struct Window *)OpenWindow(&aboutWindow) )
    {
    SetPointer(aboutwindow, XPointer, 15, 16, -8, -9);  /* OMA POINTTERI */

    RemoveGList(window, &Painike[5], -1);
    AddGList(aboutwindow, &About, 0, -1, NULL);
    RefreshGList(&About, aboutwindow, NULL, -1);

    ColorSquare(aboutwindow->RPort,   0,   0, 259, 213, 26);
    ColorSquare(aboutwindow->RPort, 201, 184,  48,  18, 20);

    PlainText(aboutwindow->RPort,  216, 197, 4, 21, "OK!" );

    for (i=0; i<17; i++)
        {
        PlainText(aboutwindow->RPort, 131-TextLength(aboutwindow->RPort,
        abouttext[i], strlen(abouttext[i]))/2, i*10+20, 22, 27, abouttext[i] );
        }

    lippu=TRUE;
    while(lippu)                    /* KUNNES lippu == FALSE (LOPPUU) */
        {
        Wait ( 1L << aboutwindow->UserPort->mp_SigBit);
        while (mssg=(struct IntuiMessage *)GetMsg(aboutwindow->UserPort))
            {
            luokka=mssg->Class;         /* VIESTILUOKKA */
            switch(luokka)
                {
                case RAWKEY:
                    if ( mssg->Code == 95 )     /* HELP = TAKAISIN */
                        {
                        lippu = FALSE;
                        }
                    break;
                case GADGETUP:          /* KÄSITELLÄÄN GADGET-YLÖS */
                    lippu = FALSE;
                    break;
                default:
                    break;
                }
            ReplyMsg((struct Message *)mssg);   /* VASTATAAN VIESTEIHIN */
            }
        }

    RemoveGList(aboutwindow, &About, -1);
    AddGList(window, &Painike[5], 0, -1, NULL);
    RefreshGList(&Painike[5], window, NULL, -1);
    CloseWindow(aboutwindow);
    PrinttaaPanos();                    /* PÄIVITÄ PELIMARKKA */
    }
}
#endif



/********** FUNKTIO ALUSTAA GRAFIIKAT, GADGETIT JA TEKSTIT ***********/

VOID Initialize(VOID)
{
SHORT i;
SHORT depth;
ULONG sekunnit, mikrot;
 
oldTextFont = RP->Font;
textAttr.ta_Name  = "Topaz.font";
textAttr.ta_YSize = 11;
textAttr.ta_Style = FS_NORMAL;
textAttr.ta_Flags = FPF_DESIGNED | FPF_DISKFONT;

if (!(textFont = (struct TextFont *)OpenDiskFont(&textAttr)))
    {
    cleanExit(10);
    }

VaritRuutuun(0);                    /* NORMAALIVÄRIT */

/* OTETAAN BITTIKARTTA KÄYTTÖÖN (SUURI GRAFIIKKARUUTU) */

InitBitMap(&bitMap, 5, 320, 256);

for(depth=0; depth<5; depth++)
    {
    bitMap.Planes[depth] = (UBYTE *)(muistinalku+depth*10240);
    }

/* BITTIKARTTA OSOITTAA NYT muistinalku:un JA VOIDAAN KÄYTTÄÄ 
        MUUTTUJAA &bitMap VIITTAAMAAN TÄHÄN KARTTAAN            */

/* OTETAAN BITTIKARTTA KÄYTTÖÖN (TILA YHDELLE KORTILLE) */

InitBitMap(&cardbitMap, 5, 56, 88);     /* KORTIN KOKO */

for(depth=0; depth<5; depth++)
    {
    cardbitMap.Planes[depth] = NULL;
    }

for(depth=0; depth<5; depth++)
    {
    cardbitMap.Planes[depth] = (PLANEPTR)AllocRaster(56, 88);
    if (cardbitMap.Planes[depth] == NULL)
        {
        cleanExit(2);
        }
    }

/* MUUTTUJAA &cardbitMap VOIDAAN KÄYTTÄÄ VIITTAAMAAN TÄHÄN
   KARTTAAN, JOHON VOIDAAN PIIRTÄÄ YKSI KORTTI */

InitRastPort(&cardRP);              /* LINKATAAN KORTIN BITTIKARTTA */
cardRP.BitMap = &cardbitMap;        /* RASTPORTTIIN, JOTTA VOIDAAN  */
                                        /* KÄYTTÄÄ PIIRTORUTIINEJA YMS. */

SetAPen(&cardRP, 0);
RectFill(&cardRP, 0, 0, 56, 84 );

SetDrMd (RP, JAM1);                     /* ASETTAA PIIRTOMOODIN */

SetAPen(RP, 1);
RectFill( RP, 0, 0, 319, 30 );      /* YLÄPALKKI */

AddGList(window, &Painike[5], 0, -1, NULL);
RefreshGList(&Painike[5], window, NULL, -1);

GadgetitKondixeen();

RectFill( RP, 0, 199, 319, 223 );       /* ALAPALKKI */

ColorSquare(RP, 14, 6, 95, 18, 8);          /* PELIT-boxi */
ColorSquare(RP, 193, 6, 112, 18, 8);        /* VOITOT-boxi */
PrinttaaPelitVoitot();

TekstiPelitVoitot(KIELI);
    
if (nytpanos>1)
    {
    sprintf(stringi, "%s  %4d", voittonimet[8*KIELI], voittosummat[nytpanos][0]);
    PlainText(RP, 147, 45, 7, 0, stringi );
    }

for (i=1; i<8; i++)
    {
    sprintf(stringi, "%s  %4d", voittonimet[8*KIELI+i], voittosummat[nytpanos][i]);
    PlainText(RP, 147, (SHORT)(45+i*9), 7, 0, stringi );
    }

PiirraPakka();      /* PAKAN PIIRTO */

SetPointer(window, XPointer, 15, 16, -8, -9);   /* OMA POINTTERI */
        
/* PANOKSEN PRINTTAUS */

sprintf(stringi, "%d", panokset[nytpanos]);
ShadowText(RP, (SHORT)((strlen(stringi)==2)?140:144), 18, 18, 19, stringi);

MuutaKielta(ALOITUSKIELI);

ScreenToFront(screen);              /* PELINÄYTTÖ ESIIN */

for (i=0; i<32; i++)
    {
    varitila[i]=0;                  /* NOLLATAAN MUUTETUT VÄRITILAT */
    }

CurrentTime(&sekunnit, &mikrot);
srand((USHORT)(mikrot/16)); 
}




/** FUNKTIO AVAA KAIKKI KIRJASTOT, NÄYTÖN, IKKUNAT, GRAFIIKAN JA FONTIN **/

VOID OpenAll(VOID)
{
LONG luettuja = 0;
SHORT i;

if (!(IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library",33L)))
    {
    cleanExit(3);
    }
else if (!(DiskfontBase = OpenLibrary("diskfont.library", 33L)))
    {
    cleanExit(4);
    }
else if (!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",33L)))
    {
    cleanExit(5);
    }

if (GfxBase->DisplayFlags & PAL )
    {
    clock = 3546895L;
    }
else
    {
    clock = 3579545L;
    }

fullLORES.DefaultTitle = "VideoPokeri 1.02 © 1992-1994 JanTAki";

if (!(screen = (struct Screen *)OpenScreen(&fullLORES)))
    {
    cleanExit(6);
    }

graniteWindow.Screen = screen;

if (!(window = (struct Window *)OpenWindow(&graniteWindow)))
    {
    cleanExit(7);
    }

infile = (struct FileHandle *)Open("POKERI.RAW", MODE_OLDFILE);
if ( infile == 0)
    {
    cleanExit(8);
    }
else
    {
    mypointer = (APTR)AllocMem(51202, MEMF_CHIP);
    if (!mypointer)
        {
        Close((BPTR)infile);
        cleanExit(9);
        }

    luettuja = Read((BPTR)infile, mypointer, 51202);
    muistinalku = (UBYTE *)mypointer;
    Close((BPTR)infile);
    }

infile = (struct FileHandle *)Open("POKERI.HIGHSCORE", MODE_OLDFILE);
if ( infile == 0)
    {
    for(i=0; i<15; i++)
        {
        sprintf(lista[i],"Commodore 13.07.1994        %3d", 300-i*20);
        tulos[i] = 300-i*20;
        }
    }
else
    {
    for(i=0; i<15; i++)
        {
        luettuja=Read((BPTR)infile, lista[i], 30);
        lista[i][29]='\0';
        tulos[i]=atoi(&lista[i][25]);
        }
    Close((BPTR)infile);
    }
}





/******* FUNKTIO SULKEE KAIKKI AVATUT JUTUT JA POISTUU OHJELMASTA *******/

VOID cleanExit (returnValue)
SHORT returnValue;
{
SHORT i;

for(i=0; i<SOUND_MAX; i++)
    {
    if (sbase[i])
        {
        FreeMem(sbase[i], ssize[i]);
        }
    }
for(i=0; i<5; i++)
    {
    if (cardbitMap.Planes[i])
        {
        FreeRaster(cardbitMap.Planes[i], 56, 88);
        }
    }

if (device1  == 0)  CloseDevice( (struct IORequest *)AIOptr1);
if (device2  == 0)  CloseDevice( (struct IORequest *)AIOptr2);
if (port1)          DeletePort(port1);
if (port2)          DeletePort(port2);
if (AIOptr1)        FreeMem(AIOptr1, sizeof(struct IOAudio) );
if (AIOptr2)        FreeMem(AIOptr2, sizeof(struct IOAudio) );
if (mypointer)      FreeMem(mypointer, 51202);
if (textFont)       CloseFont(textFont);
if (window)         CloseWindow(window);
if (screen)         CloseScreen(screen);
if (DiskfontBase)   CloseLibrary( ( struct Library *) DiskfontBase);
if (IntuitionBase)  CloseLibrary( ( struct Library *) IntuitionBase);

if (returnValue!=0)
    {
    printf("\nVideoPokeri: %s\n%s!\n\n", SekaTextit[18+KIELI],
                           virhetekstit[KIELI+3*returnValue]);
    }
if ( FromWB == TRUE )
    {
    Delay(200);
    }
exit (returnValue>0?RETURN_ERROR:RETURN_OK);
}

/* END OF .C FILE */
