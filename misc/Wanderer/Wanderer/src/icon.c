#include "wand_head.h"

#ifdef AMIGA
#include "pw.images.h"		/* AMIGA image bitmaps */
#endif

void draw_symbol(x,y,ch)        /* this is where the pretty graphics are */
				/* all defined - change them if you want.. */
int  x,y;
char ch;
{
#ifdef AMIGA
    /* show graphics images on the AMIGA */
    struct Image *image;
    switch(ch)
    {
    case ' ':                    /*  space  */
	image = &grassimage;
        break;
    case '#':                   /*  rock  */
	image = &rockimage;
        break;
    case '<':                   /*  arrows  */
	image = &leftarrowimage;
        break;
    case '>':
	image = &rightarrowimage;
        break;
    case 'O':                    /* boulder  */
	image = &boulderimage;
        break;
    case ':':                    /*  earth  */
	image = &earthimage;
        break;
    case '/':                    /*  slopes */
	image = &leftslopeimage;
        break;
    case '\\':
	image = &rightslopeimage;
        break;
    case '*':                     /*  diamond  */
	image = &diamondimage;
        break;
    case '=':                     /*  rock  */
	image = &rock2image;
        break;
    case '@':                     /*  YOU!!! */
	image = &youimage;
        break;
    case 'T':                   /*  teleport  */
	image = &teleportimage;
        break;
    case 'X':                    /*  exits  */
	image = &exitimage;
        break;
    case '!':                    /*  landmine  */
	image = &bang1image;
        break;
    case 'M':                     /* big monster  */
	image = &monsterimage;
        break;
    case 'S':                     /* baby monster */
	image = &babymonsterimage;
        break;
    case '^':			 /* balloon */
	image = &balloonimage;
        break;
    case 'C':                    /* time capsule */
	image = &timecapsuleimage;
        break;
    case '+':                    /* cage */
	image = &cageimage;
        break;
    default:                         /* this is what it uses if it doesnt */
				     /* recognise the character  */
	image = &unknownimage;
        break;
    }
    DrawImage(R, image, x*8 + 8, y*8 + 8);

#else
    char icon[2][4],
         (*iconrow)[4] = icon;

    switch(ch)
    {
    case ' ':                    /*  space  */
        strcpy(*iconrow++,"   ");
        strcpy(*iconrow,  "   ");
        break;
    case '#':                   /*  rock  */
        strcpy(*iconrow++,"###");
        strcpy(*iconrow,  "###");
        break;
    case '<':                   /*  arrows  */
        strcpy(*iconrow++,"<--");
        strcpy(*iconrow,  "<--");
        break;
    case '>':
        strcpy(*iconrow++,"-->");
        strcpy(*iconrow,  "-->");
        break;
    case 'O':                    /* boulder  */
        strcpy(*iconrow++,"/^\\");
        strcpy(*iconrow,  "\\_/");
        break;
    case ':':                    /*  earth  */
        strcpy(*iconrow++,". .");
        strcpy(*iconrow,  " . ");
        break;
    case '/':                    /*  slopes */
        strcpy(*iconrow++," _/");
        strcpy(*iconrow,  "/  ");
        break;
    case '\\':
        strcpy(*iconrow++,"\\_ ");
        strcpy(*iconrow,  "  \\");
        break;
    case '*':                     /*  diamond  */
        strcpy(*iconrow++,"/$\\");
        strcpy(*iconrow,  "\\$/");
        break;
    case '=':                     /*  rock  */
        strcpy(*iconrow++,"=-=");
        strcpy(*iconrow,  "-=-");
        break;
    case '@':                     /*  YOU!!! */
        strcpy(*iconrow++," o ");
        strcpy(*iconrow,  "<|>");
        break;
    case 'T':                   /*  teleport  */
        strcpy(*iconrow++,"(*)");
        strcpy(*iconrow,  "(*)");
        break;
    case 'X':                    /*  exits  */
        strcpy(*iconrow++,"Way");
        strcpy(*iconrow,  "Out");
        break;
    case '!':                    /*  landmine  */
        strcpy(*iconrow++," I ");
        strcpy(*iconrow,  " o ");
        break;
    case 'M':                     /* big monster  */
        strcpy(*iconrow++,"}o{");
        strcpy(*iconrow,  "/^\\");
        break;
    case 'S':                     /* baby monster */
        strcpy(*iconrow++,"-o-");
        strcpy(*iconrow,  "/*\\");
        break;
    case '^':			 /* balloon */
        strcpy(*iconrow++,"/~\\");
        strcpy(*iconrow,  "\\_X");
        break;
    case 'C':                    /* time capsule */
        strcpy(*iconrow++,"   ");
        strcpy(*iconrow,  "<O>");
        break;
    case '+':                    /* cage */
        strcpy(*iconrow++,"TTT");
        strcpy(*iconrow,  "III");
        break;
    default:                         /* this is what it uses if it doesnt */
				     /* recognise the character  */
        strcpy(*iconrow++,"OOO");
        strcpy(*iconrow,  "OOO");
        break;
    };
    move(y+1,x+1);
    iconrow--;
    addstr(*iconrow++);
    move(y+2,x+1);
    addstr(*iconrow);
#endif
}
