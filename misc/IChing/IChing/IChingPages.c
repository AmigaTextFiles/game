/******************************************************
**    ICHINGPAGES.C     Page definitions for the
**                      I Ching program.
**
**    LAST CHANGED:     9/9/88
**
*******************************************************/

#include "IChing.h"
#include "IChingStructs.h"
#include "IChingImages.c"

static struct  IntuiText   T_Attr = { 1, 0, JAM1, 100, 13, NULL,

      " NAME   ATTRIBUTE   ANIMAL  BODY  FAMILY     OBJECT", NULL };

struct   IntuiText   *Attr = &T_Attr;

/* ------------------------ Trigram Text: ---------------------------- */

static struct  IntuiText   T_Chientxt = { 1, 0, JAM1, 0, 0, NULL,

      " Ch'ien  strength    horse   head  Father    Heaven", NULL };

static struct  IntuiText   T_Kuntxt = { 1, 0, JAM1, 0, 0, NULL,

      " K'un    docility     ox    belly Mother     Earth", NULL };

static struct  IntuiText   NxtChentxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                   Son", NULL };

static struct  IntuiText   T_Chentxt = { 1, 0, JAM1, 0, 0, NULL,

      " Chen   movement    dragon  foot  eldest     thunder", &NxtChentxt };

static struct  IntuiText   NxtSuntxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                  Daughter   & wind", NULL };

static struct  IntuiText   T_Suntxt = { 1, 0, JAM1, 0, 0, NULL,

      " Sun   penetration  fowl   thigh  eldest     wood", &NxtSuntxt };

static struct  IntuiText   NxtKantxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                   Son       & moon", NULL };

static struct  IntuiText   T_Kantxt = { 1, 0, JAM1, 0, 0, NULL,

      " K'an     danger     pig    ear   second     water", &NxtKantxt };

static struct  IntuiText   NxtLitxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                  Daughter   & sun", NULL };

static struct  IntuiText   T_Litxt = { 1, 0, JAM1, 0, 0, NULL,

      "  Li   brightness    hen    eye   second     fire", &NxtLitxt };

static struct  IntuiText   NxtKentxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                   Son", NULL };

static struct  IntuiText   T_Kentxt = { 1, 0, JAM1, 0, 0, NULL,

      " Ken   stand-still   dog    hand  youngest   mountain", &NxtKentxt };

static struct  IntuiText   NxtTuitxt = { 1, 0, JAM1, 0, 10, NULL,

      "                                  Daughter", NULL };

static struct  IntuiText   T_Tuitxt = { 1, 0, JAM1, 0, 0, NULL,

      " Tui    pleasure    sheep  mouth  youngest   marsh", &NxtTuitxt };

/* ------------------------- The Trigram structures: -------------------- */

static struct  TRIGRAM Trigrams[] = {
   { { &T_Kuntxt },   { &Tri1 } },
   { { &T_Chentxt },  { &Tri2 } },
   { { &T_Kantxt },   { &Tri4 } },
   { { &T_Tuitxt },   { &Tri7 } },
   { { &T_Kentxt },   { &Tri6 } },
   { { &T_Litxt },    { &Tri5 } },
   { { &T_Suntxt },   { &Tri3 } },
   { { &T_Chientxt }, { &Tri0 } }
   };

/* ---------------------- Hexname structures: ------------------------ */

static struct IntuiText    Name[] = {

    { 1, 0, JAM1, 0, 0, NULL, " 2: Khwan",    NULL },      /* page 1 */
    { 1, 0, JAM1, 0, 0, NULL, "24: Fu",       NULL },      /* page 2 */
    { 1, 0, JAM1, 0, 0, NULL, " 7: Sze",      NULL },      /* page 3 */
    { 1, 0, JAM1, 0, 0, NULL, "19: Lin",      NULL },      /* page 4 */
    { 1, 0, JAM1, 0, 0, NULL, "15: Khien",    NULL },      /* page 5 */
    { 1, 0, JAM1, 0, 0, NULL, "36: Ming I",   NULL },      /* page 6 */
    { 1, 0, JAM1, 0, 0, NULL, "46: Shang",    NULL },      /* page 7 */
    { 1, 0, JAM1, 0, 0, NULL, "11: Thai",     NULL },      /* page 8 */
    { 1, 0, JAM1, 0, 0, NULL, "16: Yu",       NULL },      /* page 9 */
    { 1, 0, JAM1, 0, 0, NULL, "51: Kan",      NULL },      /* page 10 */
    { 1, 0, JAM1, 0, 0, NULL, "40: Kieh",     NULL },      /* page 11 */
    { 1, 0, JAM1, 0, 0, NULL, "54: Kwei Mei", NULL },      /* page 12 */
    { 1, 0, JAM1, 0, 0, NULL, "62: Hsiao Kwo",NULL },      /* page 13 */
    { 1, 0, JAM1, 0, 0, NULL, "55: Fang",     NULL },      /* page 14 */
    { 1, 0, JAM1, 0, 0, NULL, "32: Hang",     NULL },      /* page 15 */
    { 1, 0, JAM1, 0, 0, NULL, "34: Ta Kwang", NULL },      /* page 16 */
    { 1, 0, JAM1, 0, 0, NULL, " 8: Pi",       NULL },      /* page 17 */
    { 1, 0, JAM1, 0, 0, NULL, " 3: Kun",      NULL },      /* page 18 */
    { 1, 0, JAM1, 0, 0, NULL, "29: Khan",     NULL },      /* page 19 */
    { 1, 0, JAM1, 0, 0, NULL, "60: Kieh",     NULL },      /* page 20 */
    { 1, 0, JAM1, 0, 0, NULL, "39: Kien",     NULL },      /* page 21 */
    { 1, 0, JAM1, 0, 0, NULL, "63: Ki Chi",   NULL },      /* page 22 */
    { 1, 0, JAM1, 0, 0, NULL, "48: Ching",    NULL },      /* page 23 */
    { 1, 0, JAM1, 0, 0, NULL, " 5: Hsu",      NULL },      /* page 24 */
    { 1, 0, JAM1, 0, 0, NULL, "45: Chhui",    NULL },      /* page 25 */
    { 1, 0, JAM1, 0, 0, NULL, "17: Sui",      NULL },      /* page 26 */
    { 1, 0, JAM1, 0, 0, NULL, "47: Khwan",    NULL },      /* page 27 */
    { 1, 0, JAM1, 0, 0, NULL, "58: Tui",      NULL },      /* page 28 */
    { 1, 0, JAM1, 0, 0, NULL, "31: Hsien",    NULL },      /* page 29 */
    { 1, 0, JAM1, 0, 0, NULL, "49: Ko",       NULL },      /* page 30 */
    { 1, 0, JAM1, 0, 0, NULL, "28: Ta Kwo",   NULL },      /* page 31 */
    { 1, 0, JAM1, 0, 0, NULL, "43: Kwai",     NULL },      /* page 32 */
    { 1, 0, JAM1, 0, 0, NULL, "23: Po",       NULL },      /* page 33 */
    { 1, 0, JAM1, 0, 0, NULL, "27: I",        NULL },      /* page 34 */
    { 1, 0, JAM1, 0, 0, NULL, " 4: Mang",     NULL },      /* page 35 */
    { 1, 0, JAM1, 0, 0, NULL, "41: Sun",      NULL },      /* page 36 */
    { 1, 0, JAM1, 0, 0, NULL, "52: Kan",      NULL },      /* page 37 */
    { 1, 0, JAM1, 0, 0, NULL, "22: Pi",       NULL },      /* page 38 */
    { 1, 0, JAM1, 0, 0, NULL, "18: Ku",       NULL },      /* page 39 */
    { 1, 0, JAM1, 0, 0, NULL, "26: Ta Khu",   NULL },      /* page 40 */
    { 1, 0, JAM1, 0, 0, NULL, "35: Chin",     NULL },      /* page 41 */
    { 1, 0, JAM1, 0, 0, NULL, "21: Shih Ho",  NULL },      /* page 42 */
    { 1, 0, JAM1, 0, 0, NULL, "64: Wei Chi",  NULL },      /* page 43 */
    { 1, 0, JAM1, 0, 0, NULL, "38: Khwei",    NULL },      /* page 44 */
    { 1, 0, JAM1, 0, 0, NULL, "56: Lu",       NULL },      /* page 45 */
    { 1, 0, JAM1, 0, 0, NULL, "30: Li",       NULL },      /* page 46 */
    { 1, 0, JAM1, 0, 0, NULL, "50: Ting",     NULL },      /* page 47 */
    { 1, 0, JAM1, 0, 0, NULL, "14: Ta Yu",    NULL },      /* page 48 */
    { 1, 0, JAM1, 0, 0, NULL, "20: Kwan",     NULL },      /* page 49 */
    { 1, 0, JAM1, 0, 0, NULL, "42: Yi",       NULL },      /* page 50 */
    { 1, 0, JAM1, 0, 0, NULL, "59: Hwan",     NULL },      /* page 51 */
    { 1, 0, JAM1, 0, 0, NULL, "61: Kung Fu",  NULL },      /* page 52 */
    { 1, 0, JAM1, 0, 0, NULL, "53: Kien",     NULL },      /* page 53 */
    { 1, 0, JAM1, 0, 0, NULL, "37: Kia Zan",  NULL },      /* page 54 */
    { 1, 0, JAM1, 0, 0, NULL, "57: Sun",      NULL },      /* page 55 */
    { 1, 0, JAM1, 0, 0, NULL, " 9: Hsiao Khu",NULL },      /* page 56 */
    { 1, 0, JAM1, 0, 0, NULL, "12: Phi",      NULL },      /* page 57 */
    { 1, 0, JAM1, 0, 0, NULL, "25: Wu Wang",  NULL },      /* page 58 */
    { 1, 0, JAM1, 0, 0, NULL, " 6: Sung",     NULL },      /* page 59 */
    { 1, 0, JAM1, 0, 0, NULL, "10: Li",       NULL },      /* page 60 */
    { 1, 0, JAM1, 0, 0, NULL, "33: Thun",     NULL },      /* page 61 */
    { 1, 0, JAM1, 0, 0, NULL, "13: Thung Zan",NULL },      /* page 62 */
    { 1, 0, JAM1, 0, 0, NULL, "44: Kau",      NULL },      /* page 63 */
    { 1, 0, JAM1, 0, 0, NULL, " 1: Khien",    NULL }       /* page 64 */
   };
/* ------------------- The pages of structures: ---------------------- */

static struct   PAGE  page[] = {

   { { &Name[0] }, { &Trigrams[ T_KUN ] },    /* page 1 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[1] }, { &Trigrams[ T_KUN ] },    /* page 2 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[2] }, { &Trigrams[ T_KUN ] },    /* page 3 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[3] }, { &Trigrams[ T_KUN ] },    /* page 4 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[4] }, { &Trigrams[ T_KUN ] },    /* page 5 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[5] }, { &Trigrams[ T_KUN ] },    /* page 6 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[6] }, { &Trigrams[ T_KUN ] },    /* page 7 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[7] }, { &Trigrams[ T_KUN ] },    /* page 8 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[8] }, { &Trigrams[ T_CHEN ] },   /* page 9 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[9] }, { &Trigrams[ T_CHEN ] },   /* page 10 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[10] }, { &Trigrams[ T_CHEN ] },  /* page 11 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[11] }, { &Trigrams[ T_CHEN ] },  /* page 12 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[12] }, { &Trigrams[ T_CHEN ] },  /* page 13 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[13] }, { &Trigrams[ T_CHEN ] },  /* page 14 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[14] }, { &Trigrams[ T_CHEN ] },  /* page 15 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[15] }, { &Trigrams[ T_CHEN ] },  /* page 16 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[16] }, { &Trigrams[ T_KAN ] },   /* page 17 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[17] }, { &Trigrams[ T_KAN ] },   /* page 18 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[18] }, { &Trigrams[ T_KAN ] },   /* page 19 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[19] }, { &Trigrams[ T_KAN ] },   /* page 20 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[20] }, { &Trigrams[ T_KAN ] },   /* page 21 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[21] }, { &Trigrams[ T_KAN ] },   /* page 22 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[22] }, { &Trigrams[ T_KAN ] },   /* page 23 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[23] }, { &Trigrams[ T_KAN ] },   /* page 24 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[24] }, { &Trigrams[ T_TUI ] },   /* page 25 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[25] }, { &Trigrams[ T_TUI ] },   /* page 26 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[26] }, { &Trigrams[ T_TUI ] },   /* page 27 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[27] }, { &Trigrams[ T_TUI ] },   /* page 28 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[28] }, { &Trigrams[ T_TUI ] },   /* page 29 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[29] }, { &Trigrams[ T_TUI ] },   /* page 30 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[30] }, { &Trigrams[ T_TUI ] },   /* page 31 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[31] }, { &Trigrams[ T_TUI ] },   /* page 32 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[32] }, { &Trigrams[ T_KEN ] },   /* page 33 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[33] }, { &Trigrams[ T_KEN ] },   /* page 34 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[34] }, { &Trigrams[ T_KEN ] },   /* page 35 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[35] }, { &Trigrams[ T_KEN ] },   /* page 36 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[36] }, { &Trigrams[ T_KEN ] },   /* page 37 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[37] }, { &Trigrams[ T_KEN ] },   /* page 38 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[38] }, { &Trigrams[ T_KEN ] },   /* page 39 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[39] }, { &Trigrams[ T_KEN ] },   /* page 40 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[40] }, { &Trigrams[ T_LI ] },    /* page 41 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[41] }, { &Trigrams[ T_LI ] },    /* page 42 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[42] }, { &Trigrams[ T_LI ] },    /* page 43 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[43] }, { &Trigrams[ T_LI ] },    /* page 44 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[44] }, { &Trigrams[ T_LI ] },    /* page 45 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[45] }, { &Trigrams[ T_LI ] },    /* page 46 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[46] }, { &Trigrams[ T_LI ] },    /* page 47 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[47] }, { &Trigrams[ T_LI ] },    /* page 48 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[48] }, { &Trigrams[ T_SUN ] },   /* page 49 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[49] }, { &Trigrams[ T_SUN ] },   /* page 50 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[50] }, { &Trigrams[ T_SUN ] },   /* page 51 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[51] }, { &Trigrams[ T_SUN ] },   /* page 52 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[52] }, { &Trigrams[ T_SUN ] },   /* page 53 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[53] }, { &Trigrams[ T_SUN ] },   /* page 54 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[54] }, { &Trigrams[ T_SUN ] },   /* page 55 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[55] }, { &Trigrams[ T_SUN ] },   /* page 56 */
     { &Trigrams[ T_CHIEN ] }
   },
   { { &Name[56] }, { &Trigrams[ T_CHIEN ] }, /* page 57 */
     { &Trigrams[ T_KUN ] }
   },
   { { &Name[57] }, { &Trigrams[ T_CHIEN ] }, /* page 58 */
     { &Trigrams[ T_CHEN ] }
   },
   { { &Name[58] }, { &Trigrams[ T_CHIEN ] }, /* page 59 */
     { &Trigrams[ T_KAN ] }
   },
   { { &Name[59] }, { &Trigrams[ T_CHIEN ] }, /* page 60 */
     { &Trigrams[ T_TUI ] }
   },
   { { &Name[60] }, { &Trigrams[ T_CHIEN ] }, /* page 61 */
     { &Trigrams[ T_KEN ] }
   },
   { { &Name[61] }, { &Trigrams[ T_CHIEN ] }, /* page 62 */
     { &Trigrams[ T_LI ] }
   },
   { { &Name[62] }, { &Trigrams[ T_CHIEN ] }, /* page 63 */
     { &Trigrams[ T_SUN ] }
   },
   { { &Name[63] }, { &Trigrams[ T_CHIEN ] }, /* page 64 */
     { &Trigrams[ T_CHIEN ] }
   }
  };

struct   PAGE  *FirstPage = &page[0];

/* ----------------------- End of IChingPages.c ----------------------- */
