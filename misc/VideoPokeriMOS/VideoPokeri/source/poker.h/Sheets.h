
/***********************************************************************
 *                                                                     *
 *  Headerfile   : sheets.h                                            *
 *                                                                     *
 *  Program      : VideoPokeri                                         *
 *                                                                     *
 *  Version      : 1.02      (06.11.1991)   (03.02.1995)               *
 *                                                                     *
 *  Author       : JanTAki                                             *
 *                 92100  RAAHE ,  FINLAND                             *
 *                                                                     *
 *  E-mail       : janta@ratol.fi                                      *
 *                                                                     *
 ***********************************************************************/


/* sheets.h */

STATIC CONST USHORT XPointer[] =
    {
    0x0000, 0x0000,     /*  control bytes        */

    0x06c0, 0x0000,     /*  1st line of sprite 0 */
    0x0fe0, 0x0000,     /*  2st line of sprite 0 */
    0x0fe0, 0x0000,     /*  3st line of sprite 0 */
    0x0fe0, 0x0000,     /*  4st line of sprite 0 */
    0x77dc, 0x0000,     /*  5st line of sprite 0 */
    0xfbbe, 0x0000,     /*  6st line of sprite 0 */
    0xfd7e, 0x0000,     /*  7st line of sprite 0 */
    0x7efc, 0x0000,     /*  8st line of sprite 0 */
    0xfd7e, 0x0000,     /*  9st line of sprite 0 */
    0xfbbe, 0x0000,     /* 10st line of sprite 0 */
    0x77dc, 0x0000,     /* 11st line of sprite 0 */
    0x1fe0, 0x0000,     /* 12st line of sprite 0 */
    0x2fe0, 0x0000,     /* 13st line of sprite 0 */
    0x6fe0, 0x0000,     /* 14st line of sprite 0 */
    0x66c0, 0x0000,     /* 15st line of sprite 0 */

    0x0000, 0x0000      /* reserved for system   */
    };

STATIC CONST USHORT voittosummat[8][8]=  /* 1. luku = panos ja 2. luku = voitto */
                            {
                /*  1mk */  {    0,   30,  15,  10,   5,   4,   3,   3},
                /*  2mk */  {    0,   60,  30,  20,  10,   8,   6,   6},
                /*  3mk */  {  120,   90,  45,  30,  15,  12,   6,   6},
                /*  4mk */  {  160,  120,  60,  40,  20,  16,   8,   8},
                /*  5mk */  {  200,  150,  75,  50,  25,  20,  10,  10},
                /* 10mk     {  400,  300, 150, 100,  50,  40,  20,  20}, */
                /* 25mk     { 1000,  750, 375, 250, 125, 100,  50,  50}, */
                /* 50mk     { 2000, 1500, 750, 500, 250, 200, 100, 100}, */
                            };

STATIC CONST UBYTE *voittonimet[]=       { "VIITOSET    ",
                              "VÄRISUORA   ",
                              "NELOSET     ",
                              "TÄYSKÄSI    ",
                              "VÄRI        ",
                              "SUORA       ",
                              "KOLMOSET    ",
                              "KAKSI PARIA ",

                              "5 OF A KIND ",
                              "ROYAL FLUSH ",
                              "4 OF A KIND ",
                              "FULLHOUSE   ",
                              "FLUSH       ",
                              "STRAIGHT    ",
                              "3 OF A KIND ",
                              "TWO PAIRS   "
                            };

STATIC CONST UBYTE *Peitot[]=    { "PELIT  ",
                      "VOITOT ",

                      "CREDITS",
                      "WINS   "
                    };

STATIC CONST BYTE *SekaTextit[]=
                    { "** PARHAIMMAT MENEVÄT LISTALLE ! **",
                      "* THE BEST PLAYERS LIVE FOREVER ! *",
                      "*** (SVENSKT TEKST FÖR SEGRARE) ***",
                      "KIRJOITA NIMESI:",
                      "WRITE YOUR NAME:",
                      "SKRIV DITT NAMN:",
                      "** VIDEOPOKERI HIGHSCORE-LISTA ***",
                      "*** VIDEOPOKERI HIGHSCORE-LIST ***",
                      " ",
                      " PANOS        PIENI / SUURI",
                      "   BET        SMALL / BIG  ",
                      " ANDEL        LITEN / STOR ",
                      "VOITIT        TUPLAATKO ?",
                      "  WINS        DOUBLE ?",
                      "  VINS        DUBBEL ?",
                      "VOITIT",
                      "  WINS",
                      "  VINS",
                      "VIRHE !",        /* SekaTextit[18+KIELI] */
                      "ERROR !",
                      "FEL !"
                      };


STATIC UBYTE kortit[75] =
                   {0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
    /* RUUTU */     0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D,

    /* RISTI */     0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
                    0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D,

    /* HERTTA */    0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
                    0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D,

    /* PATA */      0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
                    0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D,

                    0xFF,
                    0x00, 0x00,
                    0x00, 0x00, 0x00, 0x00, 0x00,
                    0x00, 0x00, 0x00, 0x00, 0x00,
                    0x00, 0x00, 0x00, 0x00, 0x00
                   };

STATIC CONST CONST_STRPTR virhetekstit[]=  
                        {
                        { " " },
                        { " " },
                        { " " },
                        { " " },
                        { " " },
                        { " " },
                        { "Bittikarttaa ei voi avata" },
                        { "Can't open BitMap" },
                        { "Kan inte öppna BitMap" },
                        { "Intuition.library ei aukea" },
                        { "Can't open Intuition.library" },
                        { "Kan inte öppna Intuition.library" },
                        { "Diskfont.library ei aukea" },
                        { "Can't open Diskfont.library" },
                        { "Kan inte öppna Diskfont.library" },
                        { "Graphics.library ei aukea" },
                        { "Can't open Graphics.library" },
                        { "Kan inte öppna Graphics.library" },
                        { "Näyttö ei aukea" },
                        { "Can't open Screen" },
                        { "Kan inte öppna Screen" },
                        { "Ikkuna ei aukea" },
                        { "Can't open Window" },
                        { "Kan inte öppna fönster" },
                        { "Grafiikka-tiedostoa ei löydy" },
                        { "Can't find Graphics-file" },
                        { "Kan inte finna Grafik-filen" },
                        { "Chip-muistia ei ole riittävästi vapaana" },
                        { "Not enough free Chip-memory" },
                        { "Inte tillräckligt Chip-minne" },
                        { "Topaz.font (koko 11) ei löydy" },
                        { "Can't find Topaz.font, size 11" },
                        { "Kan inte finna Topaz.font, storlek 11" },
                        { "Soundi-tiedosto ei aukea" },
                        { "Can't find all soundfiles" },
                        { "Kan inte finna alla ljud-filorna" },
                        { "Kaikki soundit eivät ole IFF-muodossa" },
                        { "All sounds are not in IFF-format" },
                        { "Alla ljud-filorna är inte i IFF-formen" },
                        { "Viestiportti ei aukea" },
                        { "Can't open MessagePort" },
                        { "Kan inte öppna MesssagePort" },
                        { "Äänikanavien varaus epäonnistui" },
                        { "Can't allocate audiochannels" },
                        { "Kan inte reserva ljud-kanaler" }
                        };

#if defined FEA_NOT_ENGLISH_GIFTWARE
STATIC CONST UBYTE *abouttext[]= {
                    { "VideoPokeri v1.02 © JanTAki -94" },
                    { " " },
                    { "Tämä peli on palautettu Raahen" },
                    { "tietokonealan oppilaitoksessa" },
                    { "C-kielen harjoitustyönä tam-" },
                    { "mikuussa -92.  Palautettaessa" },
                    { "versionumero oli 0.85!!  Sen" },
                    { "jälkeen on tullut mm. äänet." },
                    { "Pelin käyttömukavuuden paran-" },
                    { "taminen jatkuu yhä..." },
                    { " " },
                    { "Lue VideoPokeri.doc saadaksesi" },
                    { "lisää tietoa pelistä ja sieltä" },
                    { "peliohjeetkin selviävät." },
                    { " " },
                    { "Janne 'JanTa' Kantola" },
                    { "Aki Löytynoja" }
                    };
#endif
                    
STATIC CONST USHORT varit[] =
                 {          /* NORMAALI   */
     0,  0,  5,             /* TAUSTA     */
     9,  9,  9,             /* HARMAA     */
     9,  9,  9,             /* JOKERIKORTIN VÄLIVÄRI! */
    12,  5,  7,             /* MARJAPUURO */
    15, 15, 15,             /* VALKOINEN  */
    14,  0,  0,             /* PUNAINEN   */
    15, 14, 10,             /* KERMA      */
    15, 15,  0,             /* KELTAINEN  */
     0, 10, 15,
     0,  6, 15,
     0,  4, 11,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    12,  5,  7,
     7,  7,  7, 
     0,  0,  0,             /* MUSTA */
     0, 10, 15,
     0,  7, 14,
     0,  4, 11,
    15, 15, 11,
    12, 12,  0,
     8,  8,  0,
     0, 14,  0,
     0, 11,  0,
     0,  8,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,

     0,  0,  3,         /* PUNAINEN */
     9,  1,  7,
     9,  1,  7,
    12,  0,  5,
    15,  7, 13,
    14,  0,  0,
    15,  6,  8,
    15,  7,  0,
     0,  2, 13,
     0,  0, 13,
     0,  0,  9,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    12,  5,  7,     /* HIIRI */
     7,  0,  5, 
     0,  0,  0,
     0, 10, 15,
     0,  7, 14,
     0,  4, 11,
    15, 15, 11,
    12, 12,  0,
     8,  8,  0,
     0, 14,  0,
     0, 11,  0,
     0,  8,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,

     0,  0,  0,     /* VIHREÄ ; TAUSTA */
     3,  6,  0,     /* VÄLIVÄRI */
     7,  3,  0,     /* HARMAA   */
     4,  0,  0,     /* MARJAPUURO */
     7, 10,  1,
     6,  0,  0,
     7,  9,  0,
     7, 10,  0,
     0,  5,  1,
     0,  1,  1,
     0,  0,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0,
    12,  5,  7,
     2,  5,  0, 
     0,  0,  0,
     0, 10, 15,
     0,  7, 14,
     0,  4, 11,
    15, 15, 11,
    12, 12,  0,
     8,  8,  0,
     0, 14,  0,
     0, 11,  0,
     0,  8,  0,
    15,  8,  0,
    13,  6,  2,
     7,  3,  0
    };

static int varitila [32];

/* end of sheets.h */
