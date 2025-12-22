// INCLUDES---------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>
// #include <assert.h>
#include <string.h>
#include <ctype.h>

#ifdef WIN32
    #include "winsock2.h"
#endif
#ifdef AMIGA
    #include <exec/types.h>
    #include <proto/dos.h> // for CreateDir()

    #if defined(__SASC) || defined(__VBCC__)
        #define BASE_PAR_DECL

        struct hostent* gethostbyname(const UBYTE* name);
        LONG            recv(LONG s, UBYTE* buf, LONG len, LONG flags); /* V3 */
        LONG            closesocket(LONG d);
        LONG            connect(LONG s, const struct sockaddr* name, LONG namelen);
        LONG            send(LONG s, const UBYTE* msg, LONG len, LONG flags);
        LONG            socket(LONG domain, LONG type, LONG protocol);
        LONG            bind(LONG s, const struct sockaddr* name, LONG namelen);
        LONG            listen(LONG s, LONG backlog);
        LONG            accept(LONG s, struct sockaddr* addr, LONG* addrlen);
        LONG            ioctlsocket(BASE_PAR_DECL LONG d, ULONG request, char* argp);
        LONG            gethostname(STRPTR hostname, LONG size); /* V3 */
        char*           inet_ntoa(struct in_addr in);
        ULONG           inet_addr(char* cp);

        #pragma libcall SocketBase socket         1E  21003
        #pragma libcall SocketBase bind           24  18003
        #pragma libcall SocketBase listen         2A   1002
        #pragma libcall SocketBase accept         30  98003
        #pragma libcall SocketBase connect        36  18003
        #pragma libcall SocketBase send           42 218004
        #pragma libcall SocketBase recv           4E 218004
        #pragma libcall SocketBase ioctlsocket    72  81003
        #pragma libcall SocketBase closesocket    78      1
        #pragma libcall SocketBase inet_ntoa      AE      1
        #pragma libcall SocketBase gethostbyname  D2    801
        #pragma libcall SocketBase gethostname   11A    802
        #pragma libcall SocketBase inet_addr      B4    801

        #define htonl(x)   (x)
        #define htons(x)   (x)

        struct in_addr
        {   ULONG          s_addr;
        };
        struct sockaddr_in
        {   UBYTE          sin_len;
            UBYTE          sin_family;
            USHORT         sin_port;
            struct in_addr sin_addr;
            char           sin_zero[8];
        };
        struct hostent
        {   char*          h_name;
            char**         h_aliases;
            int            h_addrtype;
            int            h_length;
            char**         h_addr_list;
    #define h_addr         h_addr_list[0] /* address, for backward compatiblity */
        };
    #endif

    #define SOCK_STREAM               1 /* stream socket */
    #define AF_INET                   2 /* internetwork: UDP, TCP, etc. */
    #define _IOC(inout,group,num,len) (inout | ((len & IOCPARM_MASK) << 16) | ((group) << 8) | (num))
    #define _IOW(g,n,t)               _IOC(IOC_IN, (g), (n), sizeof(t))
    #define FIONBIO                   _IOW('f', 126, long) /* set/clear non-blocking i/o */
//  #define EAGAIN                    35        /* Resource temporarily unavailable */
    #define EWOULDBLOCK               EAGAIN        /* Operation would block */
    #define WSAEWOULDBLOCK            EWOULDBLOCK
    #if defined(__SASC) || defined(__VBCC__)
        typedef unsigned long         u_long;
    #endif
    typedef u_long                    n_long; /* long as received from the net */
    #ifndef INADDR_ANY
        #define INADDR_ANY            (u_long)0x00000000
    #endif
    #define IOCPARM_MASK              0x1fff /* parameter length, at most 13 bits */
    #define IOC_IN                    0x80000000 /* copy in parameters */
#endif

#include "tnt.h"

// DEFINES----------------------------------------------------------------

// #define SUPERHERO
// enable this for Thorgon to be really powerful (eg. to have awesome
// weapons)

// #define HERO
// enable this for Thorgon to have his real adventuring history/items
// rather than a "vanilla" history/items

// #define AUTORESURRECT
// whether dead characters get restored to full health when loaded in

// #define SHOWSTATS
// whether to show statistical info about how many paragraphs have
// unimplemented text in them

// #define SHOWSPARES
// whether to show unused characters

#define COLUMNIZE
// whether to put item info into columnar format

// #define ANYKEYACTIONS
// whether enterkey(TRUE) should allow changing armour, using items, etc.

#define FUZZYTHRESHOLD   2
#define RB_WEAPONDESCS 140
#define NUMERICABILITY(a) ((a >= 124 && a <= 126) ? TRUE : FALSE)
#define ANSISCREENS     12

#include "tables.h"
#include "items.h"
#include "monsters.h"

// EXPORTED VARIABLES-----------------------------------------------------

EXPORT       int             armour,
                             arms, legs, head, chest,
                             bankcp,
                             been[MOST_ROOMS + 1],
                             column            = 0,
                             level             = 0,
                             xp,
                             st,      owed_st  = 0, healable_st  = 0, max_st,
                             iq,      owed_iq  = 0, healable_iq  = 0, iq_langs,
                             lk,      owed_lk  = 0,
                             con = 0, owed_con = 0, healable_con = 0, max_con,
                             dex,     owed_dex = 0, healable_dex = 0,
                             chr,     owed_chr = 0,
                             spd,     owed_spd = 0,
                             good_attacktotal,
                             good_damagetaken,
                             good_shocktotal,
                             good_spitetotal,
                             good_hitstaken,
                             evil_hitstaken,
                             evil_attacktotal,
                             evil_damagetaken,
                             evil_shocktotal,
                             evil_spitetotal,
                             gp, sp, cp, rt, lt, both,
                             age, height, weight, sex, race, class,
                             killcount[RACES],
                             target, thethrow,
                             minsave       = 5,
                             missileammo,
                             missileweapon,
                             module        = MODULE_RB,
                             owed_cp, owed_sp, owed_gp,
                             percent_sell  = 100,
                             poisoning,
                             room, prevroom,
                             theround, // round() is reserved under C99
                             row           = 0,
                             scaling,
                             sixes,
                             sheet_chosen  = -1,
                             spellchosen,
                             spellcost,
                             spelllevel,
                             spellpower,
                             spitedamage,
                             minutes,
                             more          = 0,
                             textcolour    = TEXTPEN_LIGHTGREY,
                             whichpic      = -1,
                             winx          = -1,
                             winy          = -1,
                             winwidth      = -1,
                             winheight     = -1,
                             wordwrap      = 78;
EXPORT       FLAG            ansiable      = FALSE,
                             ask           = TRUE,
                             avail_armour  = FALSE,
                             avail_cast    = FALSE,
                             avail_drop    = FALSE,
                             avail_fight   = FALSE,
                             avail_get     = FALSE,
                             avail_hands   = FALSE,
                             avail_look    = FALSE,
                             avail_options = FALSE,
                             avail_proceed = FALSE,
                             avail_random  = FALSE,
                                                         avail_autofight = FALSE,
                             avail_use     = FALSE,
                             avail_view    = FALSE,
                             autodice      = TRUE,
                             colours       = TRUE,
                             exploded,
                             fresh         = FALSE,
                             gotman        = FALSE,
                             inmatrix      = FALSE,
                             instructions  = FALSE,
                             logconsole    = FALSE,
                             onekey        = TRUE,
                             plus10mr      = TRUE,
                             rawmode       = FALSE,
                             showunimp     = FALSE,
                             usedweapons,
                             wantansi      = TRUE;
EXPORT       UBYTE           gfx           = 2; // means all
EXPORT       TEXT            ck_filename[MAX_PATH + 1],
                             name[80 + 1],
                             pathname[MAX_PATH + 1],
                             imagename[MAX_PATH + 1] = "",
                             oldpictitle[60 + 1],
                             pictitle[60 + 1]        = "",
                             specialopt_long[8][20 + 1],
                             specialopt_short[8][10 + 1],
                             userstring[40 + 1]      = "",
                             vanillascreen[65536 + 1];
EXPORT       STRPTR          pix[MOST_ROOMS],
                             rank;
EXPORT const STRPTR         *descs[MODULES],
                            *treasures[MODULES],
                            *wanders[MODULES];
EXPORT       SWORD*          exits;
EXPORT       FILE*           LogfileHandle = NULL;
EXPORT       TEXT*           ANSIBuffer[ANSISCREENS];

USED const STRPTR verstag = VERSIONSTRING;

EXPORT struct NPCStruct      npc[MAX_MONSTERS];
EXPORT const STRPTR          table_classes[4] =
{ "Warrior",
  "Wizard",
  "Warrior-Wizard",
  "Rogue"
}, table_sex[3] =
{ "Male",
  "Female",
  "Thing"
}, table_pronouns[3] =
{ "him",
  "her",
  "it"
};

// MODULE VARIABLES-------------------------------------------------------

MODULE       int             cp_here,
                             curpos,
                             sp_here,
                             gp_here,
                             echomode      = 0,
                             globalnumber,
                             moduledone[MODULES],
                             mount         = -1, // initializer is needed to avoid wrong gadget contents at startup
                             numdice,
                             numwpnadds,
                             offset,
                             oldroom,
                             spellduration,
                             spelleffect;
MODULE       FLAG            autofight     = FALSE,
                             berserk       = FALSE,
                             berserkable   = TRUE,
                             cheat         = FALSE,
                             confirm       = FALSE,
                             encumber      = TRUE,
                             globalrandomable = TRUE,
                                                         incombat      = FALSE,
                             itemmode      = FALSE,
                             logfile       = FALSE,
                             multimonster  = FALSE,
                             newthrow      = FALSE,
                             patient       = TRUE,
                             shown[MISCPIX],
                             spite         = FALSE,
                             verbose       = TRUE,
                             wpnreq        = TRUE;
MODULE       UBYTE           therolls[1000];
MODULE       FILE*           FileHandle    = NULL;
MODULE       TEXT*           ansiless[ANSISCREENS];
MODULE       char            vanillatext[8192];

MODULE const struct
{   const STRPTR filename;
    const int    height;
    const FLAG   cls,
                 lf;
} ansi[ANSISCREENS] = {
#ifdef AMIGA
{ "PROGDIR:ANSI/Guild.ans"  , 21, TRUE , TRUE  }, //  0
{ "PROGDIR:ANSI/City.ans"   , 21, TRUE , TRUE  }, //  1
{ "PROGDIR:ANSI/Title.ans"  , 22, TRUE , TRUE  }, //  2
{ "PROGDIR:ANSI/Buy.ans"    , 21, TRUE , TRUE  }, //  3
{ "PROGDIR:ANSI/Combat.ans" , 12, FALSE, FALSE }, //  4
{ "PROGDIR:ANSI/Death.ans"  , 15, FALSE, TRUE  }, //  5
{ "PROGDIR:ANSI/Play.ans"   , 10, TRUE , FALSE }, //  6
{ "PROGDIR:ANSI/Arena.ans"  , 22, TRUE , TRUE  }, //  7
{ "PROGDIR:ANSI/Victory.ans", 22, FALSE, TRUE  }, //  8
{ "PROGDIR:ANSI/TC0.ans"    , 22, TRUE , TRUE  }, //  9
{ "PROGDIR:ANSI/CA0.ans"    , 22, TRUE , TRUE  }, // 10
{ "PROGDIR:ANSI/DT18.ans"   , 23, TRUE , TRUE  }, // 11
#endif
#ifdef WIN32
{ "ANSI/Guild.ans"  , 21, TRUE , TRUE  }, //  0
{ "ANSI/City.ans"   , 21, TRUE , TRUE  }, //  1
{ "ANSI/Title.ans"  , 22, TRUE , TRUE  }, //  2
{ "ANSI/Buy.ans"    , 21, TRUE , TRUE  }, //  3
{ "ANSI/Combat.ans" , 12, FALSE, TRUE  }, //  4
{ "ANSI/Death.ans"  , 15, FALSE, TRUE  }, //  5
{ "ANSI/Play.ans"   ,  8, TRUE , TRUE  }, //  6
{ "ANSI/Arena.ans"  , 22, TRUE , TRUE  }, //  7
{ "ANSI/Victory.ans", 22, FALSE, TRUE  }, //  8
{ "ANSI/TC0.ans"    , 22, TRUE , TRUE  }, //  9
{ "ANSI/CA0.ans"    , 22, TRUE , TRUE  }, // 10
{ "ANSI/DT18.ans"   , 23, TRUE , TRUE  }, // 11
#endif
};
MODULE const STRPTR rangestring[] = { "point blank", "near", "far", "extreme" },
                     sizestring[] = { "tiny", "very small", "small", "average", "large", "larger", "very large", "huge" };

// IMPORTED VARIABLES-----------------------------------------------------

IMPORT       FLAG            cd_inside[CD_ROOMS],
                             inmatrix,
                             ok_inwander,
                             reactable,
                             wanderer;
IMPORT       int             alarum,
                             ak_fights, ak_won,
                             scaling;
IMPORT const STRPTR          so_diseasetext[11];
IMPORT       TEXT            colourscreen[65536 + 1],
                             userinput[MAX_PATH + 80 + 1];
IMPORT       char**          theargv;
#ifdef AMIGA
    IMPORT   APTR            TextFieldBase; // struct Library* really
    IMPORT   struct Library* SocketBase;
    IMPORT   struct Window  *AboutWindowPtr,
                            *MainWindowPtr;
#endif
#ifdef WIN32
    IMPORT   FLAG            bigwin;
    IMPORT   TEXT            ProgDir[MAX_PATH + 1];
    IMPORT   HWND            SheetWindowPtr;
#endif

EXPORT FLAG (* enterroom) (void);

// MODULE FUNCTIONS-------------------------------------------------------

MODULE void generate(void);
MODULE UBYTE readbyte(void);
MODULE UWORD readword(void);
MODULE ULONG readlong(void);
MODULE void writebyte(UBYTE value);
MODULE void writeword(UWORD value);
MODULE void writelong(ULONG value);
MODULE FLAG load_man(void);
MODULE void runmodule(void);
MODULE void listspells(FLAG full);
MODULE FLAG autogenerate(void);
MODULE void calc_age(void);
// MODULE FLAG export(void);
MODULE FLAG import(void);
MODULE void module_loop(FLAG between);
MODULE void rb_wandering(void);
MODULE void city(void);
MODULE void sayround(void);
MODULE FLAG appropriate(int mode, int which);
MODULE void showhands(void);
MODULE void printiteminfo(int whichitem, FLAG numberit);
MODULE void printiteminfo_table(int whichitem, int percent);
MODULE int calc_attack(int rt, int lt, int both, FLAG you);
MODULE FLAG meleeweapon(int whichitem);
MODULE FLAG showornot(int whichitem, TEXT whichletter);
MODULE void saylight(void);
MODULE FLAG askitem(int which);
MODULE FLAG askitems(int which, int amount);
MODULE FLAG eligible(int whichmodule);
MODULE FLAG sure(int whichmodule);
MODULE void extendspell(int whichspell, int spellpower, int extend);
MODULE void learnracespells(void);
MODULE void hands(void);
MODULE int stneeded_armour(void);
MODULE int stneeded_weapons(void);
MODULE int dexneeded_weapons(void);
MODULE void givespells(void);
MODULE void open_logfile(void);
MODULE void close_logfile(void);
MODULE int fuzzystrcmp(STRPTR s, STRPTR t);
MODULE FLAG droppable(int whichitem);
MODULE void bank_deposit(void);
MODULE void bank_withdraw(void);
MODULE void clear_man(void);
MODULE void do_letters(void);
MODULE void showarmour(void);
MODULE void domore(void);
MODULE int calcmissilehits(int target);
MODULE void instruct(int which);
MODULE FLAG meleeing(void);
MODULE void checkpoison(int which);
MODULE void envenom(int whichpoison, int whichweapon, int doses);
MODULE int poisoneffect(int damage);
MODULE void showracespic(void);
// MODULE int feet_to_range(int feet);
MODULE FLAG usecharge(int whichitem);
MODULE void emitcode(int whichcolour);
MODULE void flushtext(void);
MODULE FLAG project_load(void);
MODULE void look(void);
MODULE void fight2(void);
MODULE void resurrect(void);
MODULE void project_delete(void);

// CODE-------------------------------------------------------------------

EXPORT void engine_init(void)
{   int i;

    for (i = 0; i < MONSTERS; i++)
    {   monsters[i].created = 0;
    }
    for (i = 0; i < MISCPIX; i++)
    {   shown[i] = FALSE;
    }
    for (i = 0; i < ANSISCREENS; i++)
    {   ANSIBuffer[i] = ansiless[i] = NULL;
    }
    colourscreen[0] = vanillascreen[0] = EOS;

    ab_preinit();
    as_preinit();
    ak_preinit();
    bs_preinit();
    bw_preinit();
    bf_preinit();
    bc_preinit();
    cd_preinit();
    ca_preinit();
    ci_preinit();
    ct_preinit();
    dd_preinit();
    dt_preinit();
    de_preinit();
    el_preinit();
    gk_preinit();
    gl_preinit();
    hh_preinit();
    ic_preinit();
    la_preinit();
    mw_preinit();
    nd_preinit();
    ns_preinit();
    ok_preinit();
    rc_preinit();
    sm_preinit();
    so_preinit();
    ss_preinit();
    sh_preinit();
    tc_preinit();
    ww_preinit();
    wc_preinit();
}

EXPORT void engine_main(void)
{   int    i, j, k, l, m,
           spaces,
           thesize;
    TEXT   newcolour, oldcolour,
           tempstring[80 + 1],
           theansi[20 + 1];
    FILE*  LocalFileHandle /* = NULL */ ;
#ifdef SHOWSTATS
    int    found,
           total;
#endif
#ifdef SHOWSPARES
    FLAG   used[256];
#endif

    lt = rt = armour = head = chest = arms = legs = EMPTY;

    srand((unsigned int) time(NULL));

    ansiable = TRUE;
    if (userstring[0])
    {   verbose = FALSE;
        more = 24;
        sprintf(tempstring, "PROGDIR:%s/TnT.cfg", userstring);
    } else
    {   strcpy(tempstring, "TnT.cfg");
    }
#ifdef WIN32
    if (!bigwin)
    {   wantansi = FALSE;
    }
#endif

    if ((FileHandle = fopen(tempstring, "rb")))
    {   if
        (   readbyte() == 8 // magic byte
         && readbyte() == VERSIONBYTE
        )
        {   verbose    = readbyte() ? TRUE : FALSE;
            colours    = readbyte() ? TRUE : FALSE;
            patient    = readbyte() ? TRUE : FALSE;
            spite      = readbyte() ? TRUE : FALSE;
            encumber   = readbyte() ? TRUE : FALSE;
            wpnreq     = readbyte() ? TRUE : FALSE;
            cheat      = readbyte() ? TRUE : FALSE;
            logfile    = readbyte() ? TRUE : FALSE;
            logconsole = readbyte() ? TRUE : FALSE;
#ifdef AMIGA
            if (!TextFieldBase)
            {   logconsole = TRUE;
            }
#endif
            gfx          = readbyte();
            showunimp    = readbyte() ? TRUE : FALSE;
            more         = readbyte();
            wordwrap     = readbyte();
            onekey       = readbyte() ? TRUE : FALSE;
            autodice     = readbyte() ? TRUE : FALSE;
            wantansi     = readbyte() ? TRUE : FALSE;
            plus10mr     = readbyte() ? TRUE : FALSE;
            instructions = readbyte() ? TRUE : FALSE;
            berserkable  = readbyte() ? TRUE : FALSE;
            confirm      = readbyte() ? TRUE : FALSE;
            percent_sell = readbyte();
            minsave      = readbyte();
            winx         = (readbyte() * 256) + readbyte();
            if (winx      == 65535) winx      = -1;
            winy         = (readbyte() * 256) + readbyte();
            if (winy      == 65535) winy      = -1;
            winwidth     = (readbyte() * 256) + readbyte();
            if (winwidth  == 65535) winwidth  = -1;
            winheight    = (readbyte() * 256) + readbyte();
            if (winheight == 65535) winheight = -1;
        }
        fclose(FileHandle);
        FileHandle = NULL;
    }

    open_sheet();

    if (logfile)
    {   open_logfile();
    }

    if (ansiable)
    {
#ifdef SHOWSPARES
        for (i = 0; i < 256; i++)
        {   used[i] = FALSE;
        }
#endif

        for (i = 0; i < ANSISCREENS; i++)
        {   thesize = getsize(ansi[i].filename);
            if (thesize && (LocalFileHandle = fopen(ansi[i].filename, "rb")))
            {   ANSIBuffer[i] = malloc(thesize + 1); // should check return code of this
                ansiless[i]   = malloc(thesize + 1); // should check return code of this
                if (fread(ANSIBuffer[i], thesize, 1, LocalFileHandle) != 1)
                {   fclose(LocalFileHandle);
                    // LocalFileHandle = NULL;
                    ansiable = FALSE;
                    aprintf("ðCan't read from \"%s\"!\n", ansi[i].filename);
                    goto DONE;
                }
                fclose(LocalFileHandle);
                // LocalFileHandle = NULL;
                ANSIBuffer[i][thesize] = EOS;

#ifdef SHOWSPARES
                for (j = 0; j < thesize; j++)
                {   used[ANSIBuffer[i][j]] = TRUE;
                }
#endif

                k = 0;
                newcolour = (TEXT) '¶';
                for (j = 0; j <= thesize; j++) // <= so that ansiless[][] gets an EOS
                {   if (ANSIBuffer[i][j] == 0x9B || (ANSIBuffer[i][j] == 0x1B && ANSIBuffer[i][j + 1] == '['))
                    {   if (ANSIBuffer[i][j] == 0x9B) j++; else j += 2;
                        l = 0;
                        do
                        {   theansi[l++] = ANSIBuffer[i][j];
                            j++;
                        } while (ANSIBuffer[i][j] < '@' || ANSIBuffer[i][j] > 'z');
                        theansi[l++] = ANSIBuffer[i][j];
                        theansi[l] = EOS;
                        oldcolour = newcolour;
                        if   (!strcmp(theansi, "0;1m" )                                                                                             ) newcolour = (TEXT) '¢'; // this is correct
                        elif (!strcmp(theansi, "0;30m") || !strcmp(theansi, "30;40m" ) || !strcmp(theansi, "40;30m") || !strcmp(theansi, "0;40;30m")) newcolour = (TEXT) '®'; // BLACK
                        elif (!strcmp(theansi, "0;31m") || !strcmp(theansi, "31;40m" ) || !strcmp(theansi, "40;31m") || !strcmp(theansi, "0;40;31m")) newcolour = (TEXT) '§'; // DARKRED
                        elif (!strcmp(theansi, "0;32m") || !strcmp(theansi, "32;40m" ) || !strcmp(theansi, "40;32m") || !strcmp(theansi, "0;40;32m")) newcolour = (TEXT) 'ç'; // DARKGREEN
                        elif (!strcmp(theansi, "0;33m") || !strcmp(theansi, "33;40m" ) || !strcmp(theansi, "40;33m") || !strcmp(theansi, "0;40;33m")) newcolour = (TEXT) '¹'; // BROWN
                        elif (!strcmp(theansi, "0;34m") || !strcmp(theansi, "34;40m" ) || !strcmp(theansi, "40;34m") || !strcmp(theansi, "0;40;34m")) newcolour = (TEXT) 'Ø'; // DARKBLUE
                        elif (!strcmp(theansi, "0;35m") || !strcmp(theansi, "35;40m" ) || !strcmp(theansi, "40;35m") || !strcmp(theansi, "0;40;35m")) newcolour = (TEXT) 'Þ'; // DARKPURPLE
                        elif (!strcmp(theansi, "0;36m") || !strcmp(theansi, "36;40m" ) || !strcmp(theansi, "40;36m") || !strcmp(theansi, "0;40;36m")) newcolour = (TEXT) '¿'; // DARKCYAN
                        elif (!strcmp(theansi, "0;37m") || !strcmp(theansi, "37;40m" ) || !strcmp(theansi, "40;37m") || !strcmp(theansi, "0;40;37m")) newcolour = (TEXT) '¶'; // LIGHTGREY
                        elif (!strcmp(theansi, "1;30m") || !strcmp(theansi, "0;1;30m") || !strcmp(theansi, "0;1;40;30m")                            ) newcolour = (TEXT) 'þ'; // DARKGREY
                        elif (!strcmp(theansi, "1;31m") || !strcmp(theansi, "0;1;31m") || !strcmp(theansi, "0;1;40;31m")                            ) newcolour = (TEXT) 'ð'; // PINK
                        elif (!strcmp(theansi, "1;32m") || !strcmp(theansi, "0;1;32m") || !strcmp(theansi, "0;1;40;32m")                            ) newcolour = (TEXT) '³'; // GREEN
                        elif (!strcmp(theansi, "1;33m") || !strcmp(theansi, "0;1;33m") || !strcmp(theansi, "0;1;40;33m")                            ) newcolour = (TEXT) 'æ'; // YELLOW
                        elif (!strcmp(theansi, "1;34m") || !strcmp(theansi, "0;1;34m") || !strcmp(theansi, "0;1;40;34m")                            ) newcolour = (TEXT) '¥'; // BLUE
                        elif (!strcmp(theansi, "1;35m") || !strcmp(theansi, "0;1;35m") || !strcmp(theansi, "0;1;40;35m")                            ) newcolour = (TEXT) '²'; // PURPLE
                        elif (!strcmp(theansi, "1;36m") || !strcmp(theansi, "0;1;36m") || !strcmp(theansi, "0;1;40;36m")                            ) newcolour = (TEXT) 'ø'; // CYAN
                        elif (!strcmp(theansi, "1;37m") || !strcmp(theansi, "0;1;37m") || !strcmp(theansi, "0;1;40;37m")                            ) newcolour = (TEXT) '¢'; // WHITE
                        elif (!strcmp(theansi, "0m"      )                                                                                          ) newcolour = (TEXT) '¶'; // LIGHTGREY (City.ans expects to go from BLUE to LIGHTGREY with this code)
                        elif (!strcmp(theansi, "30;46m"  )                                                                                          ) newcolour = (TEXT) 'ü'; // BLACKONDARKCYAN
                        elif (!strcmp(theansi, "1;44;33m")                                                                                          ) newcolour = (TEXT) 'û'; // YELLOWONDARKBLUE
                        elif (!strcmp(theansi, "41;30m"  )                                                                                          ) newcolour = (TEXT) 'ý'; // BLACKONDARKRED
                        elif (!strcmp(theansi, "1m"))
                        {   switch (newcolour)
                            {
                            acase (TEXT) '®': newcolour = (TEXT) 'þ';
                            acase (TEXT) '§': newcolour = (TEXT) 'ð';
                            acase (TEXT) 'ç': newcolour = (TEXT) '³';
                            acase (TEXT) '¹': newcolour = (TEXT) 'æ';
                            acase (TEXT) 'Ø': newcolour = (TEXT) '¥';
                            acase (TEXT) 'Þ': newcolour = (TEXT) '²';
                            acase (TEXT) '¿': newcolour = (TEXT) 'ø';
                            acase (TEXT) '¶': newcolour = (TEXT) '¢';
                        }   }
                        elif (!strcmp(theansi, "30m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) 'þ'; else newcolour = (TEXT) '®'; // blacks
                        elif (!strcmp(theansi, "31m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) 'ð'; else newcolour = (TEXT) '§'; // reds
                        elif (!strcmp(theansi, "32m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) '³'; else newcolour = (TEXT) 'ç'; // greens
                        elif (!strcmp(theansi, "33m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) 'æ'; else newcolour = (TEXT) '¹'; // yellows
                        elif (!strcmp(theansi, "34m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) '¥'; else newcolour = (TEXT) 'Ø'; // blues
                        elif (!strcmp(theansi, "35m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) '²'; else newcolour = (TEXT) 'Þ'; // purples
                        elif (!strcmp(theansi, "36m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) 'ø'; else newcolour = (TEXT) '¿'; // cyans
                        elif (!strcmp(theansi, "37m"  )) if (code_to_colour(newcolour) >= 8) newcolour = (TEXT) '¢'; else newcolour = (TEXT) '¶'; // whites
                        elif (!strcmp(theansi, "40m"  )    // black background
                         ||   !strcmp(theansi, "2J"   )    // CLS
                         ||   !strcmp(theansi, "?7h"  )    // undocumented
                         ||   !strcmp(theansi, "255D" )) ; // cursor left (only used at end of file)
                        elif
                        (     theansi[l - 3] == ';'
                         &&   theansi[l - 2] == '1'
                         &&  (theansi[l - 1] == 'H' || theansi[l - 1] == 'f')
                        ) // ![r;cH or ![r;cf where r is row and c is column
                        {   ansiless[i][k++] = '\n'; // they always happen to be to column 1 of the next row
                        } elif (theansi[l - 1] == 'C') // spaces
                        {   spaces = atoi(theansi);
                            for (m = 0; m < spaces; m++)
                            {   ansiless[i][k++] = ' '; // buffer overflow is possible but not likely
                        }   }
                        else
                        {   aprintf("Unknown ANSI code in %s: %s\n", ansi[i].filename, theansi);
                        }
                        if (newcolour != oldcolour)
                        {   ansiless[i][k++] = newcolour;
                    }   }
                    elif (ANSIBuffer[i][j] == CR && ANSIBuffer[i][j + 1] == LF)
                    {   ansiless[i][k++] = LF;
                        j++; // and j++ is incremented again by the for loop
                    } else
                    {
#ifdef WIN32
                        if (ANSIBuffer[i][j] == 0xAF) // overscore
                        {   ansiless[i][k] = '©';
                        } else
                        {   ansiless[i][k] = istrouble(ANSIBuffer[i][j]) ? '!' : ANSIBuffer[i][j]; // rich edit gadget chokes on these and switches fonts
                        }
#endif
#ifdef AMIGA
                        ansiless[i][k] = ANSIBuffer[i][j];
#endif
                        k++;
            }   }   }
            else
            {   ansiable = FALSE;
                aprintf("ðCan't open \"%s\"!\n", ansi[i].filename);
                enterkey(TRUE);
                goto DONE;
        }   }

#ifdef SHOWSPARES
        for (i = 0; i < 256; i++)
        {   if (used[i] && code_to_colour(i) != -1)
            {   aprintf("$%02X is used by artwork and also as a colour code!\n", i);
            } elif (!used[i] && code_to_colour(i) == -1 && istrouble(i)) // because we'd prefer to use ones that don't print properly as colour codes
            {   aprintf("$%02X is spare.\n", i);
        }   }
        enterkey(FALSE);
#endif
        if (wantansi)
        {   DISCARD showansi(2);
            enterkey(FALSE);
    }   }

DONE:
    if (name[0])
    {   sprintf(pathname, "%s.tnt", name);
        if (!load_man())
        {   aprintf("ðCan't load \"%s\"!\n", name);
            quit(EXIT_FAILURE);
    }   }

#ifdef SHOWSTATS
    found = total = 0;
    for (i = 1; i < MODULES; i++)
    {   for (j = 0; j < moduleinfo[i].rooms; j++)
        {   total++;
            k = 0;
            while (descs[i][j][k] != EOS)
            {   if (descs[i][j][k] == '[')
                {   found++;
                    break;
                }
                k++;
    }   }   }
    aprintf("¢Found %d of %d unimplemented paragraphs.\n\n", found, total);
#endif

    if (con <= 0)
    {   guild();
    }
    city();
}

EXPORT void guild(void)
{   TRANSIENT TEXT letter;
    PERSIST   TEXT tempstring[MAX_PATH + 1],
                   tempstring2[MAX_PATH + 1];

    for (;;)
    {   if (!showansi(0))
        {   aprintf
                (   "¢GUILD:\n\n" \
                "(øA¢) Autogenerate\n" \
                "(øC¢) City\n" \
                "(øD¢) Delete\n" \
                "(øG¢) Generate\n" \
                "(øI¢) Import\n" \
                "(øL¢) Load\n" \
                "(øO¢) Options\n" \
                "(øR¢) Rename\n" \
                "(øV¢) View\n\n"
            );
        }
        avail_options =
        avail_view    = TRUE;
        if (con >= 1)
        {   letter = getletter("Which", "ACDGILORV", "Autogenerate", "City", "Delete", "Generate", "Import", "Load", "Rename", "",     'C');
        } else
        {   letter = getletter("Which", "ACDGILORV", "Autogenerate", "City", "Delete", "Generate", "Import", "Load", "Rename", "",     'G');
        }
        avail_options =
        avail_view    = FALSE;
        switch (letter)
        {
        acase 'A':
            if (autogenerate())
            {   return;
            }
        acase 'C':
            if (con < 1)
            {   aprintf("You need a living character!\n");
                enterkey(TRUE);
            } else return;
        acase 'D':
            project_delete();
/*      acase 'E':
            if (export())
            {   return;
            } */
        acase 'G':
            generate();
            return;
        acase 'I':
            if (import() && con >= 1)
            {   return;
            }
        acase 'L':
            if (project_load() && con >= 1)
            {   return;
            }
        acase 'O':
            options();
        acase 'R':
            showfiles();
            aprintf("Rename which character?\n");
            show_output();
            loop(FALSE);
            if (userinput[0] != EOS)
            {   userinput[0] = toupper(userinput[0]);
                if (userstring[0])
                {   sprintf(tempstring, "PROGDIR:%s/%s.tnt", userstring, userinput);
                } else
                {   sprintf(tempstring,            "%s.tnt",             userinput);
                }
                aprintf("What is the new name?\n");
                show_output();
                loop(FALSE);
                if (userinput[0] != EOS)
                {   userinput[0] = toupper(userinput[0]);
                    if (userstring[0])
                    {   sprintf(tempstring2, "PROGDIR:%s/%s.tnt", userstring, userinput);
                    } else
                    {   sprintf(tempstring2,            "%s.tnt",             userinput);
                    }
                    if (rename(tempstring, tempstring2))
                    {   aprintf("ðCouldn't rename \"%s\" as \"%s\"!\n", tempstring, tempstring2);
                    } else
                    {   aprintf("Renamed \"%s\" as \"%s\".\n", tempstring, tempstring2);
            }   }   }
        acase 'V':
            if (gotman)
            {   view_man();
            } else
            {   aprintf("No character is loaded!\n");
                enterkey(TRUE);
}   }   }   }

MODULE void city(void)
{   TEXT letter;
    int  choice,
         i,
         minutes1,
         minutes2;

    module = MODULE_RB;
    room = 0;
    for (i = 0; i < ITEMS; i++)
    {   items[i].here = 0;
    }
    cp_here = sp_here = gp_here = 0;

    for (;;)
    {   encumbrance();

        for (i = 0; i < SPELLS; i++)
        {   if (spell[i].active)
            {   aprintf
                (   "Your %s spell is active for the next %d minutes.\n",
                    spell[i].corginame,
                    spell[i].active
                );
        }   }

        if (!showansi(1))
        {   aprintf
            (   "¢CITY:\n\n" \
                "(øA¢) Armour (wear/unwear)\n" \
                "(øB¢) Buy\n" \
                "(øC¢) Cast spell\n" \
                "(øD¢) Drop (deposit to bank)\n" \
                "(øE¢) arEna\n" \
                "(øG¢) Get (withdraw from bank)\n" \
                "(øH¢) Hands (wield/unwield)\n" \
                "(øL¢) guiLd\n" \
                "(øN¢) advaNce\n" \
                "(øO¢) Options\n" \
                "(øP¢) Play\n" \
                "(øS¢) Sell\n" \
                "(øU¢) Use item\n" \
                "(øV¢) View character\n" \
                "(øW¢) Wait (heal)\n\n"
            );
        }
        enable_items(TRUE);
        enable_spells(TRUE);
        avail_armour  =
        avail_cast    =
        avail_drop    =
        avail_get     =
        avail_hands   =
        avail_options =
        avail_proceed =
        avail_use     =
        avail_view    = TRUE;
                globalrandomable = FALSE;
        letter = getletter("Which", "ABCDEGHLNOPSUVW", "Buy", "arEna", "guiLd", "advaNce", "Play", "Sell", "Wait", "", 'P');
                globalrandomable = TRUE;
        avail_armour  =
        avail_cast    =
        avail_drop    =
        avail_get     =
        avail_hands   =
        avail_options =
        avail_proceed =
        avail_use     =
        avail_view    = FALSE;
        enable_items(FALSE);
        enable_spells(FALSE);
        switch (letter)
        {
        case 'A':
            weararmour(EMPTY);
        acase 'B':
            while (shop_buy(100, 'X') != -1);
        acase 'C':
            DISCARD castspell(-1, TRUE);
        acase 'E':
            rb_wandering();
        acase 'L':
            save_man();
            guild();
        acase 'H':
            hands();
        acase 'D':
            bank_deposit();
        acase 'G':
            bank_withdraw();
        acase 'N':
            advance(TRUE);
        acase 'O':
            options();
        acase 'P':
            for (;;)
            {   choice = getmodule
                (   "PLAY:                        Level   Adds  Class   Height  Race\n" \
                    "--- ------------------------ ----- ------  ------- ------- ----\n" \
//  $2              "øAB¢: Abyss                      Any    Any  Any     Any     Any\n"
/* #20  */          "øAS¢: Amulet of the Salkti     <=  8 <=  33  Any     Any     Any\n" \
/* #12  */          "øAK¢: Arena of Khazan            Any    Any  Any     Any     Any\n" \
/*  #8  */          "øBS¢: Beyond the Silvered Pane   Any    Any  Any     Any     Any\n" \
/* #18  */          "øBW¢: Beyond the Wall of Tears   Any    Any  Any     Any     Any\n" \
/* #15  */          "øBF¢: Blue Frog Tavern           Any <=  15  Any     Any     Any\n" \
/*  #1  */          "øBC¢: Buffalo Castle           <=  1    Any  Warrior Any     Any\n" \
/* #19  */          "øCD¢: Captif d'Yvoire          <=  4 <=  80  Any     3'-7½'  No ogres/trolls\n" \
/* #22  */          "øCA¢: Caravan to Tiern           Any <=  72  Any     Any     Any\n" \
/*  $3  */          "øCI¢: Circle of Ice            <=  4 <=  70  Any     Any     Any\n" \
/*  #9  */          "øCT¢: City of Terrors            Any <= 225  Any     Any     Humanoid\n" \
/*  #5  */          "øDD¢: Dargon's Dungeon         <=  3 <=  90  Any     Any     Any\n" \
/* #23  */          "øDT¢: Dark Temple                Any  10-75  Any     Any     Any\n" \
/*  #2  */          "øDE¢: Deathtrap Equalizer      <=  5 <=  70  Any     <= 7'   Any\n" \
/* #27 or #25  */   "øEL¢: Elven Lords                Any <=  60  Any     Any     Any\n" \
/* #17  */          "øGK¢: Gamesmen of Kasar          Any <= 110  Any     Any     Any\n" \
/*  $1  */          "øGL¢: Goblin Lake              <=  1    Any  Any     <= 6'   Any\n" \
/* n/a  */          "øHH¢: Hela's House               Any    Any  Any     <= 100' Any\n" \
/* #26 or #24c */   "øIC¢: Intellectually Challenged  Any    Any  Any     Any     Any\n" \
/*  #3  */          "øLA¢: Labyrinth                <=  2    Any  Warrior Any     Human\n" \
/* #16  */          "øMW¢: Mistywood                  Any <= 110  Any     Any     Any\n" \
/*  #4  */          "øND¢: Naked Doom               <=  2    Any  Warrior Any     Hu/Dw/El/Ho\n" \
/* #25 or #24b */   "øNS¢: New Sorcerer Solitaire   <=  3 <=  30  Wizard  Any     Any\n" \
/* #10  */          "øOS¢: Old Sorcerer Solitaire   <=  3    Any  Wizard  Any     Any\n" \
/*  #7  */          "øOK¢: Overkill                 <= 12    Any  Any     Any     Any\n" \
/* #21  */          "øRC¢: Red Circle                 Any <=  60  Any     Any     Humanoid\n" \
/* #14  */          "øSM¢: Sea of Mystery             Any <=  45  Any     Any     Hu/Dw/El/Ho/Fa/Le\n" \
/* #13  */          "øSO¢: Sewers of Oblivion       <=  7 <= 425  Any     <= 10'  Humanoid\n" \
/* #11  */          "øSH¢: Sword for Hire           <=  3    Any  Any     Any     Any\n" \
/* n/a  */          "øTC¢: Trollstone Caverns       <=  2    Any  Any     Any     Any\n" \
/*  #6  */          "øWW¢: Weirdworld               <=  2    Any  Any     Any     Any\n" \
/* #24 or #24a */   "øWC¢: When the Cat's Away      <=  3 <=  30  Wizard  Any     Any\n" \
                    "\nWhich adventure (øR¢ for random, øENTER¢ key for none)"
                );
                if (choice == 0)
                {   break;
                } // implied else

                if
                (   (eligible(choice) || getyn("Enter anyway"))
                 && sure(choice)
                )
                {   module = choice;
                    room = 0;
                    runmodule();
                    break;
            }   }
            module = MODULE_RB;
            room = 0;
        acase 'S':
            shop_sell(percent_sell, 100);
        acase 'U':
            use(-1);
        acase 'V':
            view_man();
        acase 'W':
            if (getyn("Wait until healed"))
            {   minutes1 =      10 * (max_st  - st );
                minutes2 = ONE_DAY * (max_con - con);
                if (minutes1 >= minutes2)
                {   elapse(minutes1, TRUE);
                } else
                {   elapse(minutes2, TRUE);
            }   }
            else
            {   minutes1 = getnumber("Wait how many minutes?", 0, 1000000); // 1 million is about 694 days, 2 billion is about 3835 years
                elapse(minutes1, TRUE);
            }
        acase '&':
            if (gp == 0) give_gp(100);
            dt_gamble();
            room = 0;
        acase '*':
            if (gp == 0) give_gp(100);
            ct_poker();
            room = 0;
}   }   }

MODULE void runmodule(void)
{   int i, j,
        oldmodule;

    DISCARD showansi(6);

    aprintf("*** %s ***\n", moduleinfo[module].longname);
    if (verbose && moduleinfo[module].desc[0])
    {   aprintf("\n%s\n", moduleinfo[module].desc);
    }

    prevroom =
    oldroom  = 0;

    for (i = 0; i < ITEMS; i++)
    {   items[i].borrowed = 0;
    }
    owed_gp = owed_sp = owed_cp = 0;

    while (module != MODULE_RB)
    {   // set up adventure
        for (i = 0; i < MAX_MONSTERS; i++)
        {   npc[i].con =
            npc[i].mr  = 0;
        }
        for (i = 0; i <= MOST_ROOMS; i++)
        {   been[i] = 0;
        }
        if (room != oldroom)
        {   cp_here = sp_here = gp_here = 0;
            for (i = 0; i < ITEMS; i++)
            {   items[i].here = 0;
        }   }

        switch (module)
        {
        case  MODULE_AB: ab_init();
        acase MODULE_AS: as_init();
        acase MODULE_AK: ak_init();
        acase MODULE_BS: bs_init();
        acase MODULE_BW: bw_init();
        acase MODULE_BF: bf_init();
        acase MODULE_BC: bc_init();
        acase MODULE_CD: cd_init();
        acase MODULE_CA: ca_init();
        acase MODULE_CI: ci_init();
        acase MODULE_CT: ct_init();
        acase MODULE_DD: dd_init();
        acase MODULE_DT: dt_init();
        acase MODULE_DE: de_init();
        acase MODULE_EL: el_init();
        acase MODULE_HH: hh_init();
        acase MODULE_GK: gk_init();
        acase MODULE_GL: gl_init();
        acase MODULE_IC: ic_init();
        acase MODULE_LA: la_init();
        acase MODULE_MW: mw_init();
        acase MODULE_ND: nd_init();
        acase MODULE_NS: ns_init();
        acase MODULE_OK: ok_init();
        acase MODULE_RC: rc_init();
        acase MODULE_SM: sm_init();
        acase MODULE_SO: so_init();
        acase MODULE_SS: ss_init();
        acase MODULE_SH: sh_init();
        acase MODULE_TC: tc_init();
        acase MODULE_WW: ww_init();
        acase MODULE_WC: wc_init();
        }

        for (;;)
        {   encumbrance();
            if (ability[46].known)
            {   templose_con(1);
            }
            if (module == MODULE_CI)
            {   templose_con(1);
            }

            for (i = 0; i < MAX_MONSTERS; i++)
            {   if (npc[i].con)
                {   aprintf
                    (   "%d: %s (CON: %d).\n",
                        i + 1,
                        npc[i].name,
                        npc[i].con
                    );
                } elif (npc[i].mr)
                {   aprintf
                    (   "%d: %s (MR: %d).\n",
                        i + 1,
                        npc[i].name,
                        npc[i].mr
                    );
            }   }

            aprintf
            (   "¢\n%s§%d¢ (%02d:%02d on day %d):\n",
                moduleinfo[module].name,
                room,
                HOURNOW,
                 minutes % 60,
                (minutes / ONE_DAY) + 1
            );
            aprintf("¹%s\n\n¢", descs[module][room]);

            j = 0;
            for (i = 0; i < ITEMS; i++)
            {   j += items[i].here;
            }
            if (gp_here || sp_here || cp_here || j)
            {   aprintf("On the floor are %d gp, %d sp, %d cp and %d item(s).\n", gp_here, sp_here, cp_here, j);
            }

            for (i = 0; i < SPELLS; i++)
            {   if (spell[i].active)
                {   aprintf
                    (   "Your %s spell is active for the next %d minutes.\n",
                        spell[i].corginame,
                        spell[i].active
                    );
            }   }
            oldroom = room;
            oldmodule = module;
            whichpic = -1;
            autoshowpic();
            enterroom();
            prevroom = oldroom;
            been[oldroom]++;
            if (con <= 0)
            {   return;
            } // implied else
            if (module != oldmodule)
            {   break;
            } // implied else
            if (room == oldroom)
            {   if (exits[(room * EXITS) + 0] != -1 && exits[(room * EXITS) + 1] == -1) // if only one exit
                {   room = exits[(room * EXITS) + 0]; // only one exit they can take
                    if (patient)
                    {   module_loop(TRUE);
                }   }
                else
                {   module_loop(FALSE); // a choice for the user to make
            }   }
            else // the game logic has changed their room already
            {   if (patient)
                {   module_loop(TRUE);
            }   }
            if (room != oldroom)
            {   cp_here = sp_here = gp_here = 0;
                for (i = 0; i < ITEMS; i++)
                {   items[i].here = 0;
            }   }
            elapse(10, TRUE);
        }

        endofmodule();
}   }

MODULE void generate(void)
{   FLAG ok;
    int  i, j,
         result;
    TEXT letter,
         tempstring[MAX_PATH + 1];

    clear_man();

    do
    {   st  = max_st  = dice(3);
        iq  = dice(3);
        lk  = dice(3);
        con = max_con = dice(3);
        dex = dice(3);
        chr = dice(3);
        spd = dice(3);
        aprintf("Strength:      %d\n", st );
        aprintf("Intelligence:  %d\n", iq );
        aprintf("Luck:          %d\n", lk );
        aprintf("Dexterity:     %d\n", dex);
        aprintf("Constitution:  %d\n", con);
        aprintf("Charisma:      %d\n", chr);
        aprintf("Speed:         %d\n", spd);
    } while (!getyn("OK"));

    if (getletter("øM¢ale/øF¢emale", "MF", "Male", "Female", "", "", "", "", "", "", 'M') == 'M')
    {   sex = MALE;
    } else
    {   sex = FEMALE;
    }

    height = heighttable[dice(3) - 3];
    weight = weighttable[dice(3) - 3];
    if (sex == FEMALE)
    {   height -=   2;
        weight -= 100;
    }

    if (st >= 12 && iq >= 12 && lk >= 12 && dex >= 12 && con >= 12 && chr >= 12)
    {   letter = getletter("øW¢arrior/øR¢ogue/wøI¢zard/wøA¢rrior-wizard", "WRIA", "Warrior", "Rogue", "wIzard", "wAr-wiz", "", "", "", "", 'A');
    } elif (iq >= 10 && dex >= 8)
    {   letter = getletter("øW¢arrior/øR¢ogue/wøI¢zard",                  "WRI" , "Warrior", "Rogue", "wIzard", "",        "", "", "", "", 'W');
    } else
    {   letter = getletter("øW¢arrior/øR¢ogue",                           "WR"  , "Warrior", "Rogue", "",       "",        "", "", "", "", 'W');
    }
    switch (letter)
    {
    case 'W':
        class = WARRIOR;
    acase 'R':
        class = ROGUE;
    acase 'I':
        class = WIZARD;
    acase 'A':
        class = WARRIORWIZARD;
    }

    if (class != WARRIOR)
    {   for (i = 0; i < SPELLS; i++)
        {   if (spell[i].level == 1)
            {   spell[i].known = TRUE;
    }   }   }

    showracespic();

    if (class == WIZARD)
    {   letter = getletter("høU¢man/øD¢warf/øE¢lf/øF¢airy/øG¢oblin/øH¢obbit/øT¢roll/øL¢eprechaun", "UDEFGHTL", "hUman", "Dwarf", "Elf", "Fairy", "Goblin", "Hobbit", "Troll", "Leprechaun", 'U');
    } else
    {   letter = getletter("høU¢man/øD¢warf/øE¢lf/øF¢airy/øG¢oblin/øH¢obbit/øT¢roll",              "UDEFGHT" , "hUman", "Dwarf", "Elf", "Fairy", "Goblin", "Hobbit", "Troll", "",           'U');
    }
    switch (letter)
    {
    case  'U': race = HUMAN;
    acase 'D': race = DWARF;
    acase 'E': race = ELF;
    acase 'F': race = FAIRY;
    acase 'G': race = GOBLIN;
    acase 'H': race = WHITEHOBBIT;
    acase 'T': race = TROLL;
    acase 'L': race = LEPRECHAUN;
    }
    calc_age();
    changerace();

    close_gfx(TRUE);

    if (iq > 12)
    {   for (i = 13; i <= iq; i++)
        {   result = anydice(1, 100);
            for (j = 0; j < LANGUAGES; j++)
            {   if (result <= language[j].freq)
                {   set_language(j, 2);
                    break;
    }   }   }   }
    iq_langs = iq;

    max_st  = st;
    max_con = con;
    rt = lt = both = armour = EMPTY;

    gp = dice(3) * 10;

    do
    {   aprintf("Name?\n");
        show_output();
        loop(FALSE);
        if (userinput[0])
        {   strcpy(name, userinput);
            name[0] = toupper(name[0]);
        } else
        {   strcpy(name, "Unnamed");
        }

        if (userstring[0])
        {   sprintf(tempstring, "PROGDIR:%s/%s.tnt", userstring, name);
        } else
        {   sprintf(tempstring,            "%s.tnt",             name);
        }
        if (Exists(tempstring))
        {   ok = getyn("That character already exists; overwrite it");
        } else
        {   ok = TRUE;
    }   }
    while (!ok);

    gotman = TRUE;
    save_man();
}

EXPORT void lefthand(void)
{   int i,
        needed;

    if (ability[18].known)
    {   aprintf("You are missing your left hand!\n");
        return;
    }
    if (ability[87].known)
    {   aprintf("Your left shoulder is fractured!\n");
        return;
    }

    if (both != EMPTY)
    {   aprintf("Unequipped %s from both hands.\n", items[both].name);
        both = EMPTY;
    }
    if (lt != EMPTY)
    {   aprintf("Unequipped %s from left hand.\n", items[lt].name);
        lt = EMPTY;
    }

    for (;;)
    {   for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && items[i].hands == 1
             && (rt != i || items[i].owned >= 2)
             && (class != WIZARD || items[i].dice <= 2)
            )
            {   printiteminfo(i, TRUE);
        }   }
        i = getnumber("Equip which in left hand (ø0¢ for none)", 0, ITEMS) - 1;
        if (i == EMPTY)
        {   lt = EMPTY;
            return;
        }
        if (!items[i].owned)
        {   aprintf("You don't have a %s.\n", items[i].name);
        } elif (items[i].hands != 1)
        {   aprintf("%s is a 2-handed weapon.\n", items[i].name);
        } elif (rt == i && items[i].owned == 1)
        {   aprintf("Your only %s is already in your right hand.\n", items[i].name);
        } elif (class == WIZARD && items[i].dice > 2)
        {   aprintf("Wizards may only use 2-dice weapons.\n");
        } elif
        (   (i == TOR || i == LAN) // ITEM_BS_UWTORCH doesn't need to be lit
         && !can_makefire()
        )
        {   aprintf
            (   "Can't light %s (need %s or %s)!\n",
                items[i].name,
                items[PRO].name,
                items[DEP].name
            );
        } else
        {   lt = i;
            needed = dexneeded_weapons();
            if (dex < needed)
            {   aprintf("Not dextrous enough for these weapons (your DEX is %d, DEX required is %d)!\n", dex, needed);
            } else
            {   needed = stneeded_weapons();
                if (st < needed)
                {   aprintf("Warning: You aren't strong enough for these weapons (your ST is %d, ST required is %d)!\n", st, needed);
                }
                return;
}   }   }   }

EXPORT void righthand(void)
{   int i,
        needed;

    if (ability[70].known)
    {   aprintf("You are missing your right hand!\n");
        return;
    }

    if (both != EMPTY)
    {   aprintf("Unequipped %s from both hands.\n", items[both].name);
        both = EMPTY;
    }
    if (rt != EMPTY)
    {   aprintf("Unequipped %s from right hand.\n", items[rt].name);
        rt = EMPTY;
    }

    for (;;)
    {   for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && items[i].hands == 1
             && (lt != i || items[i].owned >= 2)
             && (class != WIZARD || items[i].dice <= 2)
            )
            {   printiteminfo(i, TRUE);
        }   }
        i = getnumber("Equip which in right hand (ø0¢ for none)", 0, ITEMS) - 1;
        if (i == EMPTY)
        {   rt = EMPTY;
            return;
        }
        if (!items[i].owned)
        {   aprintf("You don't have a %s.\n", items[i].name);
        } elif (items[i].hands != 1)
        {   aprintf("%s is a 2-handed weapon.\n", items[i].name);
        } elif (lt == i && items[i].owned == 1)
        {   aprintf("Your only %s is already in your left hand.\n", items[i].name);
        } elif (class == WIZARD && items[i].dice > 2)
        {   aprintf("Wizards may only use 2-dice weapons.\n");
        } elif
        (   (i == TOR || i == LAN) // ITEM_BS_UWTORCH doesn't need to be lit
         && !can_makefire()
        )
        {   aprintf
            (   "Can't light %s (need %s or %s)!\n",
                items[i].name,
                items[PRO].name,
                items[DEP].name
            );
        } else
        {   rt = i;
            needed = dexneeded_weapons();
            if (dex < needed)
            {   aprintf("Not dextrous enough for these weapons (your DEX is %d, DEX required is %d)!\n", dex, needed);
            } else
            {   needed = stneeded_weapons();
                if (st < needed)
                {   aprintf("Warning: You aren't strong enough for these weapons (your ST is %d, ST required is %d)!\n", st, needed);
                }
                return;
}   }   }   }

EXPORT void bothhands(void)
{   int i,
        needed;

    if (ability[70].known)
    {   aprintf("You are missing your right hand!\n");
        return;
    }
    if (ability[18].known)
    {   aprintf("You are missing your left hand!\n");
        return;
    }
    if (ability[87].known)
    {   aprintf("Your left shoulder is fractured!\n");
        return;
    }

    if (both != EMPTY)
    {   aprintf("Unequipped %s from both hands.\n", items[both].name);
        both = EMPTY;
    }
    if (rt != EMPTY)
    {   aprintf("Unequipped %s from right hand.\n", items[rt].name);
        rt = EMPTY;
    }
    if (lt != EMPTY)
    {   aprintf("Unequipped %s from left hand.\n", items[lt].name);
        lt = EMPTY;
    }

    for (;;)
    {   for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && items[i].hands == 2
             && (class != WIZARD || items[i].dice <= 2)
             && (items[i].type != WEAPON_BOW || !ability[14].known)
            )
            {   printiteminfo(i, TRUE);
        }   }
        i = getnumber("Equip which in both hands (ø0¢ for none)", 0, ITEMS) - 1;
        if (i == EMPTY)
        {   both = EMPTY;
            return;
        }
        if (!items[i].owned)
        {   aprintf("You don't have a %s.\n", items[i].name);
        } elif (items[i].hands != 2)
        {   aprintf("%s is a 1-handed weapon.\n", items[i].name);
        } elif (class == WIZARD && items[i].dice > 2)
        {   aprintf("Wizards may only use 2-dice weapons.\n");
        } elif (items[i].type == WEAPON_BOW && ability[14].known) // %%: what about crossbows?
        {   aprintf("Your hands are broken!\n");
        } else
        {   both = i;
            needed = dexneeded_weapons();
            if (dex < needed)
            {   aprintf("Not dextrous enough for this weapon (your DEX is %d, DEX required is %d)!\n", dex, needed);
            } else
            {   needed = stneeded_weapons();
                if (st < needed)
                {   aprintf("Warning: You aren't strong enough for this weapon (your ST is %d, ST required is %d)!\n", st, needed);
                }
                return;
}   }   }   }

EXPORT void weararmour(int choice)
{   int i;

START:
    while (choice == EMPTY)
    {   if (!reactable)
        {   showarmour();
            aprintf("³Inventory:¢\n");
        }
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && (   items[i].type == ARMOUR_COMPLETE
                 || items[i].type == ARMOUR_HEAD
                 || items[i].type == ARMOUR_ARMS
                 || items[i].type == ARMOUR_CHEST
                 || items[i].type == ARMOUR_LEGS
            )   )
            {   aprintf("%d: %s\n", i + 1, items[i].name);
        }   }
        choice = getnumber("Wear/unwear which (ø0¢ for none)", 0, ITEMS) - 1;
        if (choice == EMPTY)
        {   goto DONE;
        }
        if (!items[choice].owned)
        {   aprintf("You don't have that!\n");
            choice = -1;
    }   }

    switch (items[choice].type)
    {
    case ARMOUR_COMPLETE:
        if (armour == choice)
        {   aprintf("Removed %s from body.\n", items[choice].name);
            armour = EMPTY;
        } else
        {   armour = choice;
            aprintf("Wearing %s on body.\n", items[choice].name);
            head   =
            arms   =
            chest  =
            legs   = EMPTY;
        }
    acase ARMOUR_HEAD:
        if (head == choice)
        {   aprintf("Removed %s from head.\n", items[choice].name);
            head = EMPTY;
        } else
        {   head   = choice;
            aprintf("Wearing %s on head.\n", items[choice].name);
            armour = EMPTY;
        }
    acase ARMOUR_ARMS:
        if (arms == choice)
        {   aprintf("Removed %s from arms.\n", items[choice].name);
            arms = EMPTY;
        } else
        {   arms   = choice;
            aprintf("Wearing %s on arms.\n", items[choice].name);
            armour = EMPTY;
        }
    acase ARMOUR_CHEST:
        if (chest == choice)
        {   aprintf("Removed %s from chest.\n", items[choice].name);
            chest = EMPTY;
        } else
        {   chest  = choice;
            aprintf("Wearing %s on chest.\n", items[choice].name);
            armour = EMPTY;
        }
    acase ARMOUR_LEGS:
        if (legs == choice)
        {   aprintf("Removed %s from legs.\n", items[choice].name);
            legs = EMPTY;
        } else
        {   legs   = choice;
            aprintf("Wearing %s on legs.\n", items[choice].name);
            armour = EMPTY;
        }
    adefault:
        aprintf("That is not armour!\n");
    }

DONE:
    if (st < stneeded_armour())
    {   aprintf("Not strong enough for this armour!\n");
        choice = EMPTY;
        goto START;
}   }

EXPORT int dice(int number)
{   int i,
        theroll,
        total = 0;

    sixes = 0;

    if (number == 0)
    {   return 0;
    }

    if (!autodice)
    {   aprintf("About to roll %d %s...\n", number, number == 1 ? "die" : "dice");
        enterkey(FALSE);
    }
    for (i = 0; i < number; i++)
    {   theroll = (rand() % 6) + 1;
        total += theroll;
        if (theroll == 6)
        {   sixes++;
    }   }
    if (number == 1)
    {   aprintf("Rolled 1 die; result is %d.\n", total);
    } else
    {   aprintf("Rolled %d dice; total is %d.\n", number, total);
    }

    return total;
}

MODULE int rememberdice(int number, int startfrom)
{   int i,
        theroll,
        total = 0;

    sixes = 0;

    if (number == 0)
    {   return 0;
    }

    if (!autodice)
    {   aprintf("About to roll %d %s...\n", number, number == 1 ? "die" : "dice");
        enterkey(FALSE);
    }
    for (i = 0; i < number; i++)
    {   theroll = (rand() % 6) + 1;
        if (startfrom + i < 1000)
        {   therolls[startfrom + i] = theroll;
        }
        total += theroll;
        if (theroll == 6)
        {   sixes++;
    }   }
    if (number == 1)
    {   aprintf("Rolled 1 die. Number is %d.\n", therolls[startfrom]);
    } else
    {   aprintf("Rolled %d dice. Numbers are %d", number, therolls[startfrom]);
        for (i = 1; i < number; i++)
        {   aprintf(", %d", therolls[startfrom + i]);
        }
        aprintf(". Total is %d.\n", total);
    }

    return total;
}

EXPORT int anydice(int number, int dicetype)
{   int i,
        total = number;

    if (!autodice)
    {   aprintf("About to roll %dd%d...\n", number, dicetype);
        enterkey(FALSE);
    }
    for (i = 0; i < number; i++)
    {   total += (rand() % dicetype);
    }
    aprintf("Rolled %dd%d. Total is %d.\n", number, dicetype, total);

    return total;
}

MODULE UBYTE readbyte(void)
{   UBYTE value;

    DISCARD fread(&value, 1, 1, FileHandle);
    offset++;

    return value;
}
MODULE UWORD readword(void)
{   UWORD value;
    UBYTE IOBuffer[2];

    DISCARD fread(IOBuffer, 2, 1, FileHandle);
    offset += 2;

    value = (IOBuffer[0] * 256)
          +  IOBuffer[1];
    return value;
}
MODULE ULONG readlong(void)
{   ULONG value;
    UBYTE IOBuffer[4];

    DISCARD fread(IOBuffer, 4, 1, FileHandle);
    offset += 4;

    value = (IOBuffer[0] * 16777216)
          + (IOBuffer[1] * 65536   )
          + (IOBuffer[2] * 256     )
          +  IOBuffer[3];
    return value;
}
MODULE void writebyte(UBYTE value)
{   DISCARD fwrite(&value, 1, 1, FileHandle);
}
MODULE void writeword(UWORD value)
{   UBYTE IOBuffer[2];

    IOBuffer[0] = (UBYTE) (value / 256);
    IOBuffer[1] = (UBYTE) (value % 256);
    DISCARD fwrite(IOBuffer, 2, 1, FileHandle);
}
MODULE void writelong(ULONG value)
{   UBYTE IOBuffer[4];

    IOBuffer[0] = (UBYTE) ((value / 65536) / 256);
    IOBuffer[1] = (UBYTE) ((value / 65536) % 256);
    IOBuffer[2] = (UBYTE) ((value % 65536) / 256);
    IOBuffer[3] = (UBYTE) ((value % 65536) % 256);
    DISCARD fwrite(IOBuffer, 4, 1, FileHandle);
}

MODULE FLAG load_man(void)
{   int i;

    // pathname and name are expected to be already set up

    offset = 0;

    if
    (   !(FileHandle = fopen(pathname, "rb"))
     || readbyte() != 7           // byte 0 (magic byte)
     || readbyte() != VERSIONBYTE // byte 1
    )
    {   return FALSE;
    }

    max_st   = readword(); // bytes  2.. 3
    max_con  = readword(); // bytes  4.. 5
    st       = readword(); // bytes  6.. 7
    iq       = readword(); // bytes  8.. 9
    lk       = readword(); // bytes 10..11
    dex      = readword(); // bytes 12..13
    con      = readword(); // bytes 14..15
    chr      = readword(); // bytes 16..17
    spd      = readword(); // bytes 18..19
    height   = readword(); // bytes 20..21
    weight   = readword(); // bytes 22..23
    sex      = readbyte(); // byte  24
    race     = readword(); // bytes 25..26
    class    = readbyte(); // byte  27
    level    = readbyte(); // byte  28
    xp       = readlong(); // bytes 29..32
    gp       = readlong();
    sp       = readlong();
    cp       = readlong();
    rt       = readword(); if (rt     == (UWORD) -1) rt     = EMPTY;
    lt       = readword(); if (lt     == (UWORD) -1) lt     = EMPTY;
    both     = readword(); if (both   == (UWORD) -1) both   = EMPTY;
    armour   = readword(); if (armour == (UWORD) -1) armour = EMPTY;
    head     = readword(); if (head   == (UWORD) -1) head   = EMPTY;
    arms     = readword(); if (arms   == (UWORD) -1) arms   = EMPTY;
    chest    = readword(); if (chest  == (UWORD) -1) chest  = EMPTY;
    legs     = readword(); if (legs   == (UWORD) -1) legs   = EMPTY;
    iq_langs = readword();
    age      = readword();
    mount    = readword(); if (mount  == (UWORD) -1) mount  = EMPTY;
    minutes  = readlong();
    bankcp   = readlong();

    for (i = 0; i < MODULES; i++)
    {   moduledone[i] = readbyte();
    }

    for (i = 0; i < ABILITIES; i++)
    {   ability[i].known = readbyte();
        ability[i].st    = readword();
        ability[i].iq    = readword();
        ability[i].lk    = readword();
        ability[i].con   = readword();
        ability[i].dex   = readword();
        ability[i].chr   = readword();
        ability[i].spd   = readword();
    }
    for (i = 0; i < ITEMS; i++)
    {   items[i].owned       = readword();
        items[i].banked      = readword();
        items[i].inuse       = readbyte();
        items[i].poisontype  = readword(); // not readbyte()!
        items[i].poisondoses = readword();
        items[i].charges     = readword();
    }
    for (i = 0; i < SPELLS; i++)
    {   spell[i].known  = readbyte();
        spell[i].active = readword();
        spell[i].power  = readword();
    }
    for (i = 0; i < LANGUAGES; i++)
    {   language[i].fluency = readbyte();
    }

    for (i = 0; i < RACES; i++)
    {   killcount[i] = readlong();
    }
    ak_fights = readlong();
    ak_won    = readlong();

    DISCARD fclose(FileHandle);
    FileHandle = NULL;

    aprintf("Loaded %s.\n", name);

#ifdef AUTORESURRECT
    resurrect();
#endif

    gotman = TRUE;

    return TRUE;
}

EXPORT void save_man(void)
{   TEXT tempstring[MAX_PATH + 1];
    int  i;
#ifdef AMIGA
    BPTR LockPtr /* = ZERO */ ;
#endif

    if (!gotman)
    {   return;
    }

#ifdef AMIGA
    if (userstring[0])
    {   sprintf(tempstring, "PROGDIR:%s", userstring);
        if (!Exists(tempstring))
        {   if ((LockPtr = CreateDir(tempstring)))
            {   UnLock(LockPtr);
                // LockPtr = ZERO;
        }   }
        sprintf(tempstring, "PROGDIR:%s/%s.tnt", userstring, name);
    } else
#endif
        sprintf(tempstring,            "%s.tnt",             name);

    if (!(FileHandle = fopen(tempstring, "wb")))
    {   return;
    }

    writebyte(7); // magic byte
    writebyte(VERSIONBYTE);

    writeword((UWORD) max_st);
    writeword((UWORD) max_con);
    writeword((UWORD) st);
    writeword((UWORD) iq);
    writeword((UWORD) lk);
    writeword((UWORD) dex);
    writeword((UWORD) con);
    writeword((UWORD) chr);
    writeword((UWORD) spd);
    writeword((UWORD) height);
    writeword((UWORD) weight);
    writebyte((UBYTE) sex);
    writeword((UWORD) race);
    writebyte((UBYTE) class);
    writebyte((UBYTE) level);
    writelong(xp);
    writelong(gp);
    writelong(sp);
    writelong(cp);
    writeword((UWORD) rt);
    writeword((UWORD) lt);
    writeword((UWORD) both);
    writeword((UWORD) armour);
    writeword((UWORD) head);
    writeword((UWORD) arms);
    writeword((UWORD) chest);
    writeword((UWORD) legs);
    writeword((UWORD) iq_langs);
    writeword((UWORD) age);
    writeword((UWORD) mount);
    writelong(minutes);
    writelong(bankcp);

    for (i = 0; i < MODULES; i++)
    {   writebyte((UBYTE) moduledone[i]);
    }
    for (i = 0; i < ABILITIES; i++)
    {   writebyte(ability[i].known);
        writeword(ability[i].st);
        writeword(ability[i].iq);
        writeword(ability[i].lk);
        writeword(ability[i].con);
        writeword(ability[i].dex);
        writeword(ability[i].chr);
        writeword(ability[i].spd);
    }
    for (i = 0; i < ITEMS; i++)
    {   writeword((UWORD) items[i].owned);
        writeword((UWORD) items[i].banked);
        writebyte((UBYTE) items[i].inuse);
        writeword((UWORD) items[i].poisontype); // not UBYTE!
        writeword((UWORD) items[i].poisondoses);
        writeword((UWORD) items[i].charges);
    }
    for (i = 0; i < SPELLS; i++)
    {   writebyte((UBYTE) spell[i].known);
        writeword((UBYTE) spell[i].active);
        writeword((UBYTE) spell[i].power);
    }
    for (i = 0; i < LANGUAGES; i++)
    {   writebyte((UBYTE) language[i].fluency);
    }
    for (i = 0; i < RACES; i++)
    {   writelong(killcount[i]);
    }
    writelong(ak_fights);
    writelong(ak_won);

    DISCARD fclose(FileHandle);
    FileHandle = NULL;

    aprintf("Saved %s.\n", name);
}

EXPORT void view_man(void)
{   int  fromst,
         fromlk,
         fromdex,
         i,
         index,
         limit,
         result;
    FLAG done;

PERSIST STRPTR portrait[16][9] = { {
"þ.¶-------¢----.", // HUMAN MALE
"þ|Ø-¥-Ø- ¹___ Ø-¥-Ø-¢|",
"þ|Ø- ¹,(((((, Ø-¢|",
"þ|Ø- ¹)'\"\"\"') Ø-¶|",
"þ|Ø- þ|¶`·þ,¶·'| Ø-¶|",
"þ|Ø- þ`. - ¶.' Ø-¶|",
"þ|Ø--þ_!·-¶·!þ_Ø--¶|",
"þ¦¿-`--ø--.þ`¿¯ø¯¿'¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // HUMAN FEMALE
"þ|Ø-¥-Ø- ¹___ Ø-¥-Ø-¢|",
"þ|Ø- ¹,:lll:, Ø-¢|",
"þ|Ø-¹.)'' `'),Ø-¶|",
"þ|Ø-¹(þY¶`·þ,¶·'Y¹.Ø-¶|",
"þ|Ø- þ`. §- ¶.'¹)Ø-¶|",
"þ|Ø-¹.'þ!·-¶·!¹.'Ø-¶|",
"þ¦¿-`--ø--.þ`¿¯ø¯¿'¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // DWARF MALE
"þ|Þ-²---Þ---²---Þ-¢|",
"þ|Þ-²-Þ- ¹___ Þ-²-Þ-¢|",
"þ|Þ- ¹,(((((, Þ-¶|",
"þ|Þ- ¹('_,_`) Þ-¶|",
"þ|Þ- þ|¶`·þ,¶·'¦ Þ-¶|",
"þ|Þ- þ`¹:···:¶' Þ-¶|",
"þ¦-¶-'¹!:::!¶`-þ-¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // DWARF FEMALE
"þ|Þ-²---Þ---²---Þ-¢|",
"þ|Þ-²-Þ- ¹___ Þ-²-Þ-¢|",
"þ|Þ- ¹,(((((, -¶|",
"þ|Þ- ¹('),)`) -¶|",
"þ|Þ- ¹,) þ,¶·'; -¶|",
"þ|Þ- ¹(þ. §- ¶.  -¶|",
"þ¦-¶-' þ·-· ¶`-þ-¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // ELF MALE
"þ|ç-³-ç- ¹_æ__ ç-³-ç-¢|",
"þ|ç- ¹.`  æ¬'. ç-¢|",
"þ| þ|¹``\"\"æ\"''¢1 ¶|",
"þ| `|¶`·þ,¶·'¢|' ¶|",
"þ| ¹¦þ`. - ¶.'æ¦ ¶|",
"þ| ¹;ç_þ!·-¶·!ç_æl ¶|",
"þ¦ç`¯¬\\---/¬³¯'¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // ELF FEMALE
"þ|ç-³-ç- ¹_æ__ ç-³-ç-¢|",
"þ|ç- ¹.`  æ¬'. ç-¢|",
"þ| þ!¹``\"\"æ\"''¢! ¶|",
"þ| ¹¦þY`·þ,¶·'¢Yæ¦ ¶|",
"þ| ¹|þ`. §- ¢.'æ| ¶|",
"þ| ¹;ç_þ!·-¶·!ç_æl ¶|",
"þ¦ç`¯¬\\---/¬³¯'¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // FAIRY MALE
"þ|ð\\ç-³-ç- æ_ ç-³-ç-ð/¢|",
#ifdef WIN32
"þ|æ°ð\\ç-æ,'²!æ',ç-ð/°¢|",
#else
"þ|æ°ð\\ç-æ,'²ºæ',ç-ð/°¢|",
#endif
"þ| ³°ð\\ø|¥- -ø|ð/²° ¶|",
"þ|æ° ²oø`¿.þ-¿.ø'æo °¶|",
"þ|ð\\¿.-ø-¿'¯`ø-¿-.ð/¶|",
"þ| ¿|       | ¶|",
#ifdef WIN32
"þ¦ ø! ¿|   | ø! ¶¦",
#else
"þ¦ ø! ¿Ì   Í ø! ¶¦",
#endif
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // FAIRY FEMALE
"þ|²\\ç-³-ç- æ_ ç-³-ç-²/¢|",
"þ|æ°²\\ç-æ.)²±æ(.ç-²/ð°¢|",
"þ| ø°²\\æ)¥o oæ(²/ø° ¶|",
"þ|ð° ³o¿`.§-¿.'æo °¶|",
"þ|²\\¿.--'¯`--.²/¶|",
"þ|ø/ ¹.-þ-.-¹-. ø\\¶|",
"þ¦ ¿/¹`.   .'¿\\ ¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // GOBLIN MALE
"þ|Þ¯¯¯¯¯¯¯¯¯¯Þ¯¢|",
"þ|Þ¯ç. .--³-. .Þ¯¢|",
"þ| ç|\\ . ³. ç/³| ¶|",
"þ|Þ_ç`Y §- - ³Yç³'Þ_¶|",
"þ|Þ__ç`.¶+-+³.'Þ__¶|",
"þ|ç___!·-³·!ç_³_ç_¶|",
"þ¦ç¬¯  _._   ¬¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // GOBLIN FEMALE
"þ|Þ¯¯¯¯¯¯¯¯¯¯Þ¯¢|",
"þ|Þ¯ç. .--³-. .Þ¯¢|",
"þ| ç|\\ . ³. ç/³| ¶|",
"þ|Þ_ç`Y §- - ³Yç³'Þ_¶|",
"þ|Þ__ç`.¶+-+³.'Þ__¶|",
"þ| ç_¹_ç!·-³·!æ_³_ ¶|",
"þ¦ç`¯¹`.   æ.'³¬ç'¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // HOBBIT MALE
"þ|Ø-¥---Ø---¥---Ø-¢|",
"þ|Ø-¥-Ø- ¹___ Ø-¥-Ø-¢|",
"þ|Ø- ¹,(((((, Ø-¢|",
"þ|Ø- ¹)'\"\"\"') Ø-¢|",
"þ|Ø- þ|¶`·þ,¶·'| Ø-¢|",
"þ|Ø- þ`. - ¶.' Ø-¢|",
"þ¦ç.³-ç-þ'--¶-þ`ç-³-ç.¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // HOBBIT FEMALE
"þ|Ø-¥---Ø---¥---Ø-¢|",
"þ|Ø-¥-Ø- ¹___ Ø-¥-Ø-¢|",
"þ|Ø- ¹,:lll:, Ø-¢|",
"þ|Ø-¹.)'' `'),Ø-¢|",
"þ|Ø-¹(þY¶`·þ,¶·'Y¹,Ø-¢|",
"þ|Ø- þ`. §- ¶.'¹)Ø-¢|",
"þ¦ç.³-ç-þ'--¶-þ`¹(³-ç.¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // LEPRECHAUN MALE
"þ|Þ- çT¯¯¯³¯¯T Þ-¢|",
"þ|Þ-ç_! ¶[¯] ³!_Þ-¢|",
"þ|ç(_`__³___'_)¶|",
"þ| ¹.ç¯¯¯¯¯³¯¯¹. ¶|",
"þ|Þ_¹`|¶`·þ,¶·'¹|'Þ_¶|",
"þ|Þ_ ¹`::þ-¹::' Þ_¶|",
"þ¦¿-ø-¿·¹`:::'¿·ø-¿-¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // LEPRECHAUN FEMALE
"þ|Þ- çT¯¯¯³¯¯T Þ-¢|",
"þ|Þ-ç_! ¶[¯] ³!_Þ-¢|",
"þ|ç(_`__³___'_)¶|",
"þ| ¹.ç¯¯¯¯¯³¯¯¹. ¶|",
"þ|Þ_¹('¶`·þ,¶·'¹`)Þ_¶|",
"þ|Þ_ ¹)`.§-¶.'¹( Þ_¶|",
"þ¦¿.ø-¿-' þ¯ ¿`-ø-.¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // TROLL MALE
"þ|ç_³_ ç.--³-. ç_³_¢|",
"þ|ç\\.`þ.   ³.'ç.³/¢|",
"þ| çY`§.þ`ç_þ'§.³'Y ¶|",
"þ| ç| ¯`þ\"³'¬ 1 ¶|",
"þ| ç|§`V¶vv§vV¶'³| ¶|",
"þ| ç`.§·._¶.§!³.' ¶|",
"þ¦ç-' '§Yç-§Yç` ³`-¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
}, {
"þ.¶-------¢----.", // TROLL FEMALE
"þ|ç_³_ ç.--³-. ç_³_¢|",
"þ|ç\\.`þ.   ³.'ç.³/¢|",
"þ| çY`§.þ`ç_þ'§.³'Y ¶|",
"þ| ç| ¯`þ\"³'¬ 1 ¶|",
"þ| ç!§`V¶vv§vV¶'ç! ¶|",
"þ|  ç'.§._¶.§!ç`  ¶|",
"þ¦ç--' ·-§Y ç`--¶¦",
"þ ¯¯¯¯¯¯¯¯¯¯¯",
} };

    if (race > TROLL)
    {   index = TROLL * 2;
    } else index = race * 2;
    if (sex == FEMALE)
    {   index++;
    }

    rawmode = TRUE;

    aprintf("  %s\n", portrait[index][0]);
    aprintf("  %s\n", portrait[index][1]);
    aprintf("  %s  ", portrait[index][2]);
    getrank();
    aprintf
    (   "¢%s%s (%s %s %s)\n",
        rank,
        name,
        table_sex[sex],
        races[race].singular,
        table_classes[class]
    );

    aprintf("  %s\n", portrait[index][3]);
    aprintf("  %s  " , portrait[index][4]);
    aprintf("³Level:¢          %d (AP: %d)\n", level, xp);

    aprintf("  %s  " , portrait[index][5]);
    aprintf("³Age:¢            %d\n", AGENOW);

    aprintf("  %s  " , portrait[index][6]);
    if (height >= 12)
    {   aprintf
        (   "³Height, Weight:¢ %d\" (%d' %d\"), %d.%d#\n",
            height,
            height / 12,
            height % 12,
            weight / 10,
            weight % 10
        );
    } else
    {   aprintf
        (   "³Height, Weight:¢ %d\", %d.%d#\n",
            height,
            weight / 10,
            weight % 10
        );
    }

    aprintf("  %s\n", portrait[index][7]);
    aprintf("  %s\n", portrait[index][8]);

    rawmode = FALSE;

    limit = getlimit() / 10;
    aprintf("³Strength:        ¢%d of %d (%d.%d# of %d# carried)\n", st, max_st, carrying() / 10, carrying() % 10, limit);
    aprintf("                 (ST of %d needed for weapons, ST of %d needed for armour)\n", stneeded_weapons(), stneeded_armour());
    aprintf("³Intelligence:    ¢%d\n", iq );
    aprintf("³Luck:            ¢%d\n", lk );
    aprintf("³Constitution:    ¢%d of %d\n", con, max_con);
    aprintf("³Dexterity:       ¢%d (DEX of %d needed for weapons)\n", dex, dexneeded_weapons());
    aprintf("³Charisma:        ¢%d\n", chr);
    if (verbose)
    {   if   (chr <   0) aprintf("Monstrous.");
        elif (chr ==  0) aprintf("Social outcast.");
        elif (chr <=  2) aprintf("Positively unlikeable and probably will be driven off or barely tolerated. Positively unwelcome.");
        elif (chr <=  6) aprintf("Unappreciated in human society.");
        elif (chr ==  7) aprintf("Unlikeable but tolerable.");
        elif (chr <= 13) aprintf("Average - has nothing going for or against.");
        elif (chr <= 25) aprintf("Visibly good-looking and somewhat influential.");
        elif (chr <= 50) aprintf("Sparkling personality. Influential and definitely popular.");
        else             aprintf("Visible leadership ability, very influential if the effects are exercised.");
    }
    aprintf("\n³Speed:           ¢%d\n", spd);
    if (st  < 9) fromst  = st  - 9; elif (st  > 12) fromst  = st  - 12; else fromst  = 0;
    if (lk  < 9) fromlk  = lk  - 9; elif (lk  > 12) fromlk  = lk  - 12; else fromlk  = 0;
    if (dex < 9) fromdex = dex - 9; elif (dex > 12) fromdex = dex - 12; else fromdex = 0;
    aprintf("³Personal Adds:\n");
    aprintf(" Melee:          ¢%+d (%+d from ST, %+d from LK, %+d from DEX)\n", calc_personaladds(st, lk, dex), fromst, fromlk, fromdex);
    aprintf(" ³Missiles:       ¢%+d (%+d from ST, %+d from LK, %+d from DEX)\n\n", calc_missileadds( st, lk, dex), fromst, fromlk, fromdex * 2);

    showhands();
    showarmour();
    saylight();

    aprintf("³Location:        ¢%s%d\n", moduleinfo[module].name, room);

    aprintf("³Modules done:    ¢");
    done = FALSE;
    for (i = 1; i < MODULES; i++)
    {   if (moduledone[i])
        {   if (done)
            {   aprintf(", ");
            }
            aprintf("%s", moduleinfo[i].name);
            done = TRUE;
    }   }
    if (!done)
    {   aprintf("None");
    }
    aprintf
    (   "\n³Coins carried:¢   %d gp (%d.%d#), %d sp (%d.%d#), %d cp (%d.%d#)\n",
        gp,
        gp / 10,
        gp % 10,
        sp,
        sp / 10,
        sp % 10,
        cp,
        cp / 10,
        cp % 10
    );
    result = 0;
    for (i = 0; i < ITEMS; i++)
    {   result += items[i].banked;
    }

    if   (bankcp % 100 == 0) aprintf("³Bank account:¢    %d gp, %d items\n", bankcp / 100, result);
    elif (bankcp %  10 == 0) aprintf("³Bank account:¢    %d sp, %d items\n", bankcp / 10,  result);
    else                     aprintf("³Bank account:¢    %d cp, %d items\n", bankcp,       result);
    if (mount != -1)
    {   aprintf("³Riding:¢          %s (carries #%d)\n", items[mount].name, limit / 10);
    }
    aprintf("\n³Items:\n");
    listitems(FALSE, TRUE, 100, 100);
    aprintf("\n³Spells:\n");
    listspells(verbose);
    aprintf("³Active spell effects:²\n");
    done = FALSE;
    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].active > 0)
        {   done = TRUE;
            aprintf("%s (%dx normal power) (for next %d minutes)\n", spell[i].corginame, spell[i].power, spell[i].active);
    }   }
    if (!done)
    {   aprintf("None\n");
    }
    aprintf("\n³Languages:²\n");
    for (i = 0; i < LANGUAGES; i++)
    {   if (language[i].fluency == 2)
        {   aprintf("%s (fluent)\n", language[i].name);
        } elif (language[i].fluency == 1)
        {   aprintf("%s (pidgin)\n", language[i].name);
    }   }
    aprintf("\n³Abilities and impairments:\n");
    done = FALSE;
    if (berserk)
    {   aprintf("Berserk\n");
    }
    for (i = 0; i < ABILITIES; i++)
    {   if (ability[i].known)
        {   if (ability[i].module == MODULE_RB)
            {   aprintf("²%s\n", ability[i].text);
            } else
            {   aprintf("²%s (%s", ability[i].text, moduleinfo[ability[i].module].name);
                if (ability[i].room >= 1000)
                {   aprintf(" DC"); // Disease Chart
                } elif (ability[i].room != -1)
                {   aprintf("%d", ability[i].room);
                }
                aprintf(")\n");
            }
            if (verbose && ability[i].module != MODULE_RB)
            {   if (ability[i].room >= 2000)
                {   aprintf("%s\n", treasures[ability[i].room - 2000]);
                } elif (ability[i].room >= 1000)
                {   aprintf("%s\n", wanders[ability[i].room - 1000]);
                } elif (ability[i].room != -1)
                {   aprintf("%s\n", descs[ability[i].module][ability[i].room]);
            }   }
            done = TRUE;
    }   }
    if (!done)
    {   aprintf("²None\n");
    }
    result = 0;
    for (i = 0; i < RACES; i++)
    {   result += killcount[i];
    }
    aprintf("\n³Monsters killed:¢ ");
    aprintf("%d\n", result);
    for (i = 0; i < RACES; i++)
    {   if (killcount[i])
        {   aprintf("²%d %s\n", killcount[i], (killcount[i] == 1) ? races[i].singular : races[i].plural);
            if (verbose && races[i].desc[0])
            {   aprintf("¹%s\n", races[i].desc);
    }   }   }

    ak_viewman();
    switch (module)
    {
    case  MODULE_AS: as_viewman();
    acase MODULE_CD: cd_viewman();
    acase MODULE_SM: sm_viewman();
    }

    aprintf("¢\n");
}

EXPORT void encumbrance(void)
{   int limit;

    limit = getlimit();
    while (carrying() > limit) // both values are in coin weights
    {   aprintf("You are encumbered.\n");
        drop_or_get(FALSE, FALSE);
        limit = getlimit();
}   }

EXPORT int carrying(void)
{   int i,
        result;

    if (!encumber)
    {   return 0;
    }

    result = gp + sp + cp;
    for (i = 0; i < ITEMS; i++)
    {   result += items[i].weight * items[i].owned;
    }

    return result;
}

EXPORT FLAG madeit(int throwlevel, int stat)
{   if (madeitby(throwlevel, stat) >= 1)
    {   aprintf("Successful L%d-SR (roll of %d, needed %d).\n", throwlevel, thethrow, target);
        return TRUE;
    } else
    {   aprintf("Failed L%d-SR (roll of %d, needed %d).\n", throwlevel, thethrow, target);
        return FALSE;
}   }

EXPORT int madeitby(int throwlevel, int stat)
{   if (cheat) return 1000;

    if (throwlevel < 0)
    {   throwlevel = 0;
    }
    if (throwlevel == 0) // see GK0
    {   target = minsave;
    } else
    {   target = 15 + (throwlevel * 5) - stat;
        if (target < minsave)
        {   target = minsave;
    }   }
    if (ability[127].known && target < 7)
    {   target = 7;
    }

    if (newthrow)
    {   award(throwlevel * thethrow);
        newthrow = FALSE;
    }

    if (ability[126].known)
    {   if (fresh)
        {   fresh = FALSE;
            lose_numeric_abilities(126, 1);
        }
        if (thethrow < target)
        {   thethrow = target;
    }   }

    return thethrow - target;
}

EXPORT int misseditby(int throwlevel, int stat)
{   return -(madeitby(throwlevel, stat));
}

EXPORT void getsavingthrow(FLAG you)
{   int  die1, die2;
    FLAG first = TRUE;

    if (you)
    {   fresh = TRUE;
        if (cheat)
        {   thethrow = 1000;
            return;
        }
        if (ability[17].known) // poisoned
        {   templose_con(1);
    }   }
    else
    {   fresh = FALSE;
    }

    thethrow = 0;
    do
    {   die1 = dice(1);
        die2 = dice(1);
        if (die1 == 1 && die2 == 1 && first)
        {   exploded = TRUE;
        } else
        {   exploded = FALSE;
        }
        first = FALSE;
        thethrow += die1 + die2;
        if (die1 == die2)
        {   aprintf("Double %d adds on and rolls over.\n", die1);
    }   }
    while (die1 == die2);
    if (ability[38].known)
    {   thethrow--;
    }

    aprintf("Saving throw result is %d.\n", thethrow);
    if (you)
    {   newthrow = TRUE;
}   }

EXPORT FLAG give(int which)
{   if (ask && !askitem(which))
    {   return FALSE;
    }

    if (items[which].owned == 0)
    {   items[which].inuse = FALSE;
    }
    items[which].owned++;
    items[which].charges = items[which].defcharges;

    if (items[which].cp % 100 == 0)
    {   aprintf
        (   "Acquired %s (%d gp) (%d.%d#).\n",
            items[which].name,
            items[which].cp / 100,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } elif (items[which].cp % 10 == 0)
    {   aprintf
        (   "Acquired %s (%d sp) (%d.%d#).\n",
            items[which].name,
            items[which].cp / 10,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } else
    {   aprintf
        (   "Acquired %s (%d cp) (%d.%d#).\n",
            items[which].name,
            items[which].cp,
            items[which].weight / 10,
            items[which].weight % 10
        );
    }

    if (which == DEL && items[ITEM_NS_HOMUNCULUS].owned) // %%: what about variant kinds of deluxe staff?
    {   dropitem(ITEM_NS_HOMUNCULUS);
        give(840);
    }

    encumbrance();
    if (!items[which].owned) // ie. if we were forced to drop it due to encumbrance
    {   return FALSE;
    }

    instruct(which);
    return TRUE;
}

MODULE void instruct(int which)
{   TEXT tempstring[80 + 1];

    switch (which)
    {
    case 803: // TC0 map
    case 804: // CA0 map
    case 877: // DT18 map
        aprintf("\"U\"se the map to look at it.\n");
    }

    switch (items[which].type)
    {
    case ARMOUR:
        if (armour != which)
        {   aprintf("Currently wearing: %s (%d hits)\n", (armour == EMPTY) ? (const STRPTR) "Nothing" : items[armour].name, (armour == EMPTY) ? 0 : items[armour].hits);
            sprintf(tempstring, "Wear %s (%d hits)", items[which].name, items[which].hits);
            if (getyn(tempstring))
            {   armour = which;
        }   }
    acase POTION:
        aprintf("Use the %s to drink it.\n", items[which].name);
    acase POISON:
        aprintf("Use the %s to coat a weapon with it.\n", items[which].name);
    acase SHIELD:
        aprintf("Equip the %s in a hand if you want to bear it.\n", items[which].name);
    adefault:
        if
        (   isweapon(which)
         && items[which].type != WEAPON_ARROW
         && items[which].type != WEAPON_STONE
         && items[which].type != WEAPON_QUARREL
         && items[which].type != WEAPON_THROWN
         && items[which].type != WEAPON_POWDER
         && items[which].type != WEAPON_DART
        )
        {   if (items[which].hands == 2)
            {   aprintf("Equip the %s in both hands if you want to wield it.\n", items[which].name);
            } else
            {   // assert(items[which].hands == 1);
                aprintf("Equip the %s in a hand if you want to wield it.\n", items[which].name);
}   }   }   }

EXPORT void give_multi(int which, int amount)
{   if (amount <= 0)
    {   return;
    } elif (amount == 1)
    {   give(which);
        return;
    }

    if (!askitems(which, amount))
    {   return;
    }

    give_multi_always(which, amount);
}

EXPORT void give_multi_always(int which, int amount)
{   if (items[which].owned == 0)
    {   items[which].inuse = FALSE;
    }
    items[which].owned += amount;
    items[which].charges = items[which].defcharges;

    if (items[which].cp % 100 == 0)
    {   aprintf
        (   "Acquired %d %s(s/es) (%d gp each) (%d.%d# each).\n",
            amount,
            items[which].name,
            items[which].cp / 100,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } elif (items[which].cp % 10 == 0)
    {   aprintf
        (   "Acquired %d %s(s/es) (%d sp each) (%d.%d# each).\n",
            amount,
            items[which].name,
            items[which].cp / 10,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } else
    {   aprintf
        (   "Acquired %d %s(s/es) (%d cp each) (%d.%d# each).\n",
            amount,
            items[which].name,
            items[which].cp,
            items[which].weight / 10,
            items[which].weight % 10
        );
    }

    encumbrance();
    if (!items[which].owned) // ie. if we were forced to drop it due to encumbrance
    {   return;
    }

    instruct(which);
}

EXPORT void award(int value)
{   if (module == MODULE_DT && been[237])
    {   value *= 2;
    }

    xp += value;
    if (xp < 0)
    {   xp = 0;
    }
    if (value >= 0)
    {   aprintf("Awarded %d APs. You now have %d APs.\n", value, xp);
    } else
    {   aprintf("Lost %d APs. You now have %d APs.\n", -value, xp);
}   }

EXPORT void use(int choice)
{   FLAG ok;
    int  i,
         result;

    if (sheet_chosen != -1)
    {   i = sheet_chosen;
        sheet_chosen = -1;
#ifdef AMIGA
        choice = i;
#endif
#ifdef WIN32
        choice = items[i].lookup;
#endif
    }

    if (choice == -1)
    {   for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned)
            {   aprintf("#%d: %d %s\n", i + 1, items[i].owned, items[i].name);
        }   }
        choice = getnumber("Use which item (ø0¢ for none)", 0, ITEMS) - 1;
        if (choice == -1)
        {   return;
    }   }
    if (!items[choice].owned)
    {   aprintf("You don't have %s!\n", items[choice].name);
        return;
    }

    if (items[choice].type == SLAVE)
    {   if
        (   ((choice == 178 || choice == 395 || choice == 649 || choice == 666 || choice == 821) && sex == MALE   && getyn("Fuck her"))
         || ((choice == 179 || choice == 774                                                   ) && sex == FEMALE && getyn("Fuck him"))
        )
        {   lose_flag_ability(88); // %%: no faggotry or bestiality is allowed, one would hope!
        }

        /* if (getyn("Ride"))
        {   aprintf("You are now riding %s.\n", items[choice].name);
            mount = choice;
        } */

        return;
    }

    switch (choice)
    {
    case 73:
        dropitem(73);
        gain_flag_ability(1);
    acase 167:
        dropitem(167);
        change_iq(iq * 2);
    acase 183:
        give(183);
    acase 200:
        dropitem(200);
        heal_con(dice(1));
    acase 210:
        dropitem(210);
        gain_st(max_st);
    acase 246:
        dropitem(246);
        healall_con();
    acase 257:
        if (usecharge(257))
        {   heal_con(1);
        }
    acase 318:
        dropitem(318);
        healall_con();
    acase 330:
        dropitem(330);
        gain_st(1);
        gain_iq(1);
        gain_lk(1);
        gain_dex(1);
        gain_con(1);
        gain_chr(1);
        gain_spd(1);
    acase 331:
        dropitem(331);
        heal_st(10);
    acase CUR: // curare
    case  SPI: // spider venom
    case  DRA: // dragon's venom
    case  JUI: // hellfire juice
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && isweapon(i))
            {   aprintf("#%d: %d %s\n", i + 1, items[i].owned, items[i].name);
        }   }
        result = getnumber("Apply poison to which weapon (ø0¢ for none)", 0, ITEMS) - 1;
        if (result == -1)
        {   return;
        }
        if (!items[result].owned)
        {   aprintf("You don't have %s!\n", items[result].name);
            return;
        }
        if (!isweapon(result))
        {   aprintf("%s is not a weapon!\n", items[result].name);
            return;
        }

        switch (items[result].type)
        {
        case WEAPON_DART:
            envenom(choice, result, 30);
        acase WEAPON_ARROW:
            envenom(choice, result, 24);
        acase WEAPON_QUARREL:
            envenom(choice, result, 10);
        adefault:
            if (choice == SPI || choice == JUI || isedged(result)) // %%: it doesn't say whether spider venom will work on blunt weapons; we assume it will.
            {   dropitem(choice);
                items[result].poisondoses = 3;
                items[result].poisontype  = choice;
            } else
            {   aprintf("%s is not an edged weapon!\n", items[result].name);
                return;
        }   }
        aprintf("OK.\n");
    acase 399:
        dropitem(399);
        if (items[414].inuse)
        {   aprintf("When you try to eat the egg, it falls through spaces between your bones and cracks on the floor.\n");
        } else
        {   if (saved(2, (iq + con) / 2))
            {   gain_st(4);
        }   }
    acase 409:
        dropitem(409);
        if (items[411].owned)
        {   dropitem(411);
            give(447);
        }
    acase 414:
    case 430:
        if (items[choice].inuse)
        {   items[choice].inuse = FALSE;
            aprintf("Unequipped %s.\n", items[choice].name);
        } else
        {   items[choice].inuse = TRUE;
            aprintf("Equipped %s.\n", items[choice].name);
        }
    acase 442:
    case 446:
        die();
    acase 448:
        if (usecharge(448))
        {   healall_con();
        }
    acase 482:
        if (usecharge(482))
        {   dropitem(482);
            if (dice(1) <= 3)
            {   templose_con(1);
                give(499);
            } else
            {   heal_con(1);
                give(495);
        }   }
    acase 484:
        dropitem(484);
        healall_con();
    acase 495:
        if (usecharge(495))
        {   heal_con(1);
        }
    acase 499:
        if (usecharge(499))
        {   templose_con(1);
        }
    acase 501:
        if (usecharge(501))
        {   heal_con(dice(1));
        }
    acase 564:
        dropitem(564);
        heal_con(1);
    acase 596:
        dropitem(596);
        heal_con(10);
    acase 788:
        dropitem(788);
        room = prevroom;
    acase 803:
        if (!userstring[0])
        {
#ifdef WIN32
            manualshowpic("%s\\Images\\TC\\TC0.gif", items[803].name);
#endif
#ifdef AMIGA
            manualshowpic("PROGDIR:Images/TC/TC0.gif", items[803].name);
#endif
        }
        if (showansi(9))
        {   enterkey(FALSE);
        }
    acase 804:
        if (!userstring[0])
        {
#ifdef WIN32
            manualshowpic("%s\\Images\\CA\\CA0.gif", items[804].name);
#endif
#ifdef AMIGA
            manualshowpic("PROGDIR:Images/CA/CA0.gif", items[804].name);
#endif
        }
        if (showansi(10))
        {   enterkey(FALSE);
        }
    acase 844:
        if (race != TROLL)
        {   gain_iq(1);
            dropitem(844);
        } else
        {   aprintf("This doesn't work on trolls!\n");
        }
    acase 864:
        ok = FALSE;
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && (   items[i].type == WEAPON_DAGGER
                 || items[i].type == WEAPON_STONE
            )   )
            {   ok = TRUE;
                break; // for speed
        }   }
        if (ok)
        {   dropitem(864);
            healall_con();
        } else
        {   aprintf("You need a dagger or stone!\n");
        }
    acase 877:
        if (!userstring[0])
        {
#ifdef WIN32
            manualshowpic("%s\\Images\\DT\\DT18.gif", items[877].name);
#endif
#ifdef AMIGA
            manualshowpic("PROGDIR:Images/DT/DT18.gif", items[877].name);
#endif
        }
        if (showansi(11))
        {   enterkey(FALSE);
        }
    acase 878:
        dropitem(878);
        if (getyn("Drink (otherwise put on wound)"))
        {   spell_tt();
        } else
        {   heal_con(5);
        }
    acase 905:
        dropitem(905);
        if (getyn("Remove curses (otherwise cure diseases)"))
        {   spell_cf(99);
        } else
        {   spell_hf();
        }
    acase 913:
        dropitem(913);
        spell_cf(99);
    acase 916:
        spell_cf(99);
    acase 936:
        if (dice(1) == 1 && dice(1) == 1)
        {   templose_con(dice(5));
        }
    acase TOR: // 153
    case LAN: // 156
    case ITEM_BS_UWTORCH: // 187
    case ITEM_CI_CRYSTAL: // 796
        aprintf("Use H (Hands) then L (Left) or R (Right) to hold %s!\n", items[choice].name);
    adefault:
        if (items[choice].type == ARMOUR)
        {   weararmour(choice);
        } elif (items[choice].type == SHIELD || isweapon(choice))
        {   if (items[choice].hands == 2)
            {   aprintf("Use H (Hands) then B (Both) to wield %s!\n", items[choice].name);
            } elif (items[choice].hands == 1)
            {   aprintf("Use H (Hands) then L (Left) or R (Right) to wield %s!\n", items[choice].name);
            } else
            {   aprintf("Can't use/equip %s!\n", items[choice].name);
        }   }
        else
        {   aprintf("Can't use/equip %s!\n", items[choice].name);
}   }   }

MODULE void envenom(int whichpoison, int whichweapon, int doses)
{   dropitem(whichpoison);
    if (items[whichweapon].poisontype != whichpoison)
    {   items[whichweapon].poisontype = whichpoison;
        items[whichweapon].poisondoses = 0;
    }
    items[whichweapon].poisondoses += doses;
}

EXPORT void victory(int bonus)
{   int i,
        result;

    enterkey(FALSE);
    DISCARD showansi(8);
    aprintf("Module successfully completed!\n");

    lose_flag_ability(154);
    lose_flag_ability(155);
    if (module == MODULE_DT && been[349])
    {   aprintf("#349:\n%s\n\n", descs[MODULE_DT][349]);
        gain_flag_ability(122);
    }

    award(bonus);
    if (module == MODULE_GK)
    {   result = 0;
        for (i = 0; i < GK_ROOMS; i++)
        {   if (been[i])
            {   result += 10;
        }   }
        award(result); // %%: arguably, we should do this as we go through the adventure rather than at the end
    }
    moduledone[module] = TRUE;
    module = MODULE_RB;
    room = 0;
}

EXPORT void failmodule(void)
{   int i,
        result;

    aprintf("Module failed!\n");

    if (module == MODULE_GK)
    {   result = 0;
        for (i = 0; i < GK_ROOMS; i++)
        {   if (been[i])
            {   result += 10;
        }   }
        award(result); // %%: arguably, we should do this as we go through the adventure rather than at the end
    }
    moduledone[module] = TRUE;
    module = MODULE_RB;
    room = 0;
}

EXPORT void advance(FLAG learnable)
{   int choice,
        i, j,
        needed,
        result;

    needed = (level < 20) ? apreq[level + 1] : (16000000 * (level - 18));
    if (xp < needed)
    {   aprintf("You still need %d more adventure points to reach level %d.\n", needed - xp, level + 1);
    } elif (getyn("Advance to next level"))
    {   level++;
        aprintf
        (   "%s has reached experience level %d!\n",
            name,
            level
        );
        if (!reactable)
        {   aprintf("ST: %d of %d, IQ: %d, LK: %d, CON: %d of %d. DEX: %d. CHR: %d. SPD: %d.\n", st, max_st, iq, lk, con, max_con, dex, chr, spd);
        }
        aprintf
        (   "(1) Add %d to ST\n"         \
            "(2) Add %d to CON\n"        \
            "(3) Add %d to ST and CON\n" \
            "(4) Add %d to IQ\n"         \
            "(5) Add %d to DEX\n"        \
            "(6) Add %d to CHR\n"        \
            "(7) Add %d to LK\n",
            level,
            level,
            level / 2,
            level / 2,
            level / 2,
            level / 2,
            level * 2
        );
        choice = getnumber("Which", 1, 7);
        switch (choice)
        {
        case 1:
            gain_st( level    );
        acase 2:
            gain_con(level    );
        acase 3:
            gain_st( level / 2);
            gain_con(level / 2);
        acase 4:
            gain_iq( level / 2);
        acase 5:
            gain_dex(level / 2);
        acase 6:
            gain_chr(level / 2);
        acase 7:
            gain_lk( level * 2);
        }
        // showstats();
    }

    if (iq > iq_langs)
    {   aprintf("You can learn %d new languages.\n", iq - iq_langs);
        for (i = iq_langs; i < iq; i++)
        {   while (getyn("Learn a language"))
            {   iq_langs++;
                result = anydice(1, 100);
                for (j = 0; j < LANGUAGES; j++)
                {   if (result <= language[j].freq)
                    {   break;
                }   }
                aprintf("Language is %s.\n", language[j].name);
                if (getyn("Become fluent (takes 1 year)"))
                {   elapse(ONE_YEAR, TRUE);
                    set_language(j, 2);
                } else
                {   set_language(j, 1);
    }   }   }   }
    else
    {   aprintf("You can't learn any new languages.\n");
}   }

EXPORT FLAG castspell(int maxlevel, int takeeffect)
{   int i;

    if (ability[23].known) // manacled
    {   aprintf("You can't cast spells because of manacles!\n");
        return FALSE;
    }

    if (sheet_chosen != -1)
    {   i = sheet_chosen;
        sheet_chosen = -1;
#ifdef WIN32
        i = spell[i].lookup;
#endif
        return cast(i, takeeffect);
    }

    i = getspell("Cast which spell (øENTER¢ key for none, ø?¢ for list)");
    if
    (   i == -1
     || (maxlevel != -1 && spell[i].level > maxlevel)
    )
    {   spellchosen = -1;
        return FALSE;
    } else
    {   return cast(i, takeeffect);
}   }

EXPORT void gain_st(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    // The maximum and current values are both raised by the amount specified.
    st     += amount;
    max_st += amount;
    aprintf("Gained %d ST. ST is now %d of %d.\n", amount, st, max_st);
}
EXPORT void gain_iq(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    iq     += amount;
    aprintf("Gained %d IQ. IQ is now %d.\n", amount, iq);
}
EXPORT void gain_lk(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    lk     += amount;
    aprintf("Gained %d LK. LK is now %d.\n", amount, lk);
}
EXPORT void gain_dex(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    dex     += amount;
    aprintf("Gained %d DEX. DEX is now %d.\n", amount, dex);
}
EXPORT void gain_con(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    // The maximum and current values are both raised by the amount specified.
    con     += amount;
    max_con += amount;
    aprintf("Gained %d CON. CON is now %d of %d.\n", amount, con, max_con);
}
EXPORT void gain_chr(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    chr     += amount;
    aprintf("Gained %d CHR. CHR is now %d.\n", amount, chr);
}
EXPORT void gain_spd(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    spd     += amount;
    aprintf("Gained %d SPD. SPD is now %d.\n", amount, spd);
}
EXPORT void heal_st(int amount)
{   // The current value is raised by the amount specified, but limited by the maximum.
    if (st == max_st)
    {   return;
    } // implied else
    st     += amount;
    if (st > max_st)
    {   st = max_st;
    }
    aprintf("Healed %d ST. ST is now %d of %d.\n", amount, st, max_st);
}
EXPORT void heal_con(int amount)
{   // The current value is raised by the amount specified, but limited by the maximum.
    if (con == max_con)
    {   return;
    } // implied else
    con    += amount;
    if (con > max_con)
    {   con = max_con;
    }
    aprintf("Healed %d CON. CON is now %d of %d.\n", amount, con, max_con);
}
EXPORT void healall_st(void)
{   if (st == max_st)
    {   return;
    } // implied else
    st = max_st;
    aprintf("Healed all ST. ST is now %d of %d.\n", st, max_st);
}
EXPORT void healall_con(void)
{   if (con == max_con)
    {   return;
    } // implied else
    con = max_con;
    aprintf("Healed all CON. CON is now %d of %d.\n", con, max_con);
}
EXPORT void permlose_st(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    st     -= amount;
    max_st -= amount;
    aprintf("Permanently lost %d ST. ST is now %d of %d.\n", amount, st, max_st);
    if (st <= 0)
    {   die();
    } else
    {   encumbrance();
}   }
EXPORT void lose_iq(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    iq     -= amount;
    aprintf("Lost %d IQ. IQ is now %d.\n", amount, iq);
    if (iq <= 0)
    {   die();
}   }
EXPORT void lose_lk(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    lk     -= amount;
    aprintf("Lost %d LK. LK is now %d.\n", amount, lk);
    if (lk <= 0)
    {   die();
}   }
EXPORT void lose_dex(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    dex     -= amount;
    aprintf("Lost %d DEX. DEX is now %d.\n", amount, dex);
    if (dex <= 0)
    {   die();
}   }
EXPORT void permlose_con(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    con     -= amount;
    max_con -= amount;
    aprintf("Permanently lost %d CON. CON is now %d of %d.\n", amount, con, max_con);
    if (con <= 0)
    {   die();
}   }
EXPORT void lose_chr(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    chr     -= amount;
    aprintf("Lost %d CHR. CHR is now %d.\n", amount, chr);
    // "Charisma is the only attribute which can fall to 0, or even go negative, without resulting in death." - RB13.
}
EXPORT void lose_spd(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    spd     -= amount;
    aprintf("Lost %d SPD, SPD is now %d.\n", amount, spd);
    if (spd <= 0)
    {   die();
}   }
EXPORT void templose_st(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    st     -= amount;
    aprintf("Temporarily lost %d ST. ST is now %d of %d.\n", amount, st, max_st);
    if (st <= 0)
    {   die();
    } else
    {   encumbrance();
}   }
EXPORT void templose_con(int amount)
{   if (amount == 0)
    {   return;
    } // implied else
    con    -= amount;
    aprintf("Temporarily lost %d CON. CON is now %d of %d.\n", amount, con, max_con);

    if (con <= 0)
    {   die();
}   }
EXPORT void permchange_st(int amount)
{   if (st == amount && max_st == amount)
    {   return;
    } // implied else
    st     = amount;
    max_st = amount;
    aprintf("Permanently changed ST to %d.\n", amount);
    if (st <= 0)
    {   die();
    } else
    {   encumbrance();
}   }
EXPORT void change_iq(int amount)
{   if (iq == amount)
    {   return;
    } // implied else
    aprintf("Changed Intelligence from %d to %d.\n", iq, amount);
    iq     = amount;
    if (iq <= 0)
    {   die();
}   }
EXPORT void change_lk(int amount)
{   if (lk == amount)
    {   return;
    } // implied else
    aprintf("Changed Luck from %d to %d.\n", lk, amount);
    lk     = amount;
    if (lk <= 0)
    {   die();
}   }
EXPORT void change_dex(int amount)
{   if (dex == amount)
    {   return;
    } // implied else
    aprintf("Changed Dexterity from %d to %d.\n", dex, amount);
    dex    = amount;
    if (dex <= 0)
    {   die();
}   }
EXPORT void permchange_con(int amount)
{   if (con == amount && max_con == amount)
    {   return;
    } // implied else
    con     = amount;
    max_con = amount;
    aprintf("Permanently changed Constitution to %d.\n", amount);
    if (con <= 0)
    {   die();
}   }
EXPORT void change_chr(int amount)
{   if (chr == amount)
    {   return;
    } // implied else
    aprintf("Changed Charisma from %d to %d.\n", chr, amount);
    chr     = amount;
    // "Charisma is the only attribute which can fall to 0, or even go negative, without resulting in death." - RB13.
}
EXPORT void change_spd(int amount)
{   if (spd == amount)
    {   return;
    } // implied else
    spd     = amount;
    aprintf("Changed Speed from %d to %d.\n", spd, amount);
    if (spd <= 0)
    {   die();
}   }
EXPORT void tempchange_st(int amount)
{   if (st == amount)
    {   return;
    } // implied else
    st     = amount;
    aprintf("Temporarily changed ST to %d.\n", amount);
    if (st <= 0)
    {   die();
    } else
    {   encumbrance();
}   }
EXPORT void tempchange_con(int amount)
{   if (con == amount)
    {   return;
    } // implied else
    con    = amount;
    aprintf("Temporarily changed CON to %d.\n", amount);
    if (con <= 0)
    {   die();
}   }

EXPORT void give_money(int amount)
{   give_gp( amount / 100);
    give_sp((amount % 100) / 10);
    give_cp( amount %  10);
}
EXPORT void give_cp(int amount)
{   cp += amount;
    aprintf("Received %d cp. You now have %d gp, %d sp, %d cp.\n", amount, gp, sp, cp);
    encumbrance();
}
EXPORT void give_sp(int amount)
{   sp += amount;
    aprintf("Received %d sp. You now have %d gp, %d sp, %d cp.\n", amount, gp, sp, cp);
    encumbrance();
}
EXPORT void give_gp(int amount)
{   gp += amount;
    aprintf("Received %d gp. You now have %d gp, %d sp, %d cp.\n", amount, gp, sp, cp);
    encumbrance();
}

EXPORT void rb_treasure(int generosity)
{   int result;

    /* Generosity of 0 = coins only
                     1 = coins and jewels only
                     2 = coins, jewels and jewelled items (jewelled items are not yet implemented) */

    if (generosity == 0)
    {   rb_givecoins();
    } else
    {   result = dice(2);
        if (result != 2)
        {   rb_givecoins();
        }
        if (result == 2 || result == 12)
        {   rb_givejewel(-1, -1, generosity);
}   }   }

EXPORT void rb_givecoins(void)
{   int result1, result2;

    result1 = (dice(3) * 10);
    result2 = dice(1);
    switch (result2)
    {
    case 1:
        give_cp(result1);
    acase 2:
    case 3:
    case 4:
        give_sp(result1);
    acase 5:
    case 6:
        give_gp(result1);
}   }

EXPORT void rb_givejewels(int type, int size, int generosity, int howmany)
{   int i;

    for (i = 1; i <= howmany; i++)
    {   rb_givejewel(type, size, generosity);
}   }

EXPORT void rb_givejewel(int type, int size, int generosity)
{   int result;

    /* %%: Most modules are not specific when they say "gems" (eg. CD146)
           as to whether jewelled items are considered to be in that
           category. We assume not. */

    // assert(generosity >= 1);

    if (size == -1)
    {   do
        {   result = dice(1);
            switch (result)
            {
            case 1:
                size = SIZE_SMALL;
            acase 2:
                size = SIZE_AVERAGE;
            acase 3:
                size = SIZE_LARGE;
            acase 4:
                size = SIZE_LARGER;
            acase 5:
                size = SIZE_HUGE;
            acase 6:
                if (generosity == 1)
                {   rb_givecoins();
                } else
                {   // assert(generosity == 2);
                    rb_givejewelleditem(-1);
                    return;
        }   }   }
        while (result == 6);
    }
    if (type == -1)
    {   type = ((dice(1) - 1) * 3) + ((dice(1) - 1) / 2);
    }
    give(677 + (type * 5) + size);
}

EXPORT void die(void)
{   DISCARD showansi(5);

    con = 0;
    if (module != MODULE_AB && !moduledone[MODULE_AB])
    {   aprintf("%s has died!\n", name);
    } else
    {   aprintf("%s has died forever!\n", name);
    }
    wanderer = FALSE;
    dispose_npcs();

    if (items[ITEM_NS_HOMUNCULUS].owned)
    {   destroy(ITEM_NS_HOMUNCULUS);
    }

    save_man();

    if (module != MODULE_AB && !moduledone[MODULE_AB] && getyn("Enter the Abyss"))
    {   resurrect();
        module = MODULE_AB;
        room = 0;
        runmodule();
        save_man();
    }

    guild();
    city();
}

EXPORT void quit(SBYTE rc)
{   int  i;
    TEXT tempstring[40 + 1];
#ifdef AMIGA
    BPTR LockPtr /* = ZERO */ ;
#endif

    // assert(!FileHandle);

    if (rc == EXIT_SUCCESS && confirm && !confirmed())
    {   return;
    }

    system_die1();

    if (gotman)
    {   save_man();
    }

    close_logfile();
    close_sheet();
    close_gfx(TRUE);

    for (i = 0; i < ANSISCREENS; i++)
    {   if (ANSIBuffer[i])
        {   free(ANSIBuffer[i]);
            // ANSIBuffer[i] = NULL;
        }
        if (ansiless[i])
        {   free(ansiless[i]);
            // ansiless[i] = NULL;
    }   }

#ifdef AMIGA
    if (userstring[0])
    {   sprintf(tempstring, "PROGDIR:%s", userstring);
        if (!Exists(tempstring))
        {   if ((LockPtr = CreateDir(tempstring)))
            {   UnLock(LockPtr);
                // LockPtr = ZERO;
        }   }
        sprintf(tempstring, "PROGDIR:%s/TnT.cfg", userstring);
    } else
#endif
        strcpy(tempstring, "TnT.cfg");

    if ((FileHandle = fopen(tempstring, "wb")))
    {   writebyte(8); // magic byte
        writebyte(VERSIONBYTE);
        writebyte((UBYTE) verbose);
        writebyte((UBYTE) colours);
        writebyte((UBYTE) patient);
        writebyte((UBYTE) spite);
        writebyte((UBYTE) encumber);
        writebyte((UBYTE) wpnreq);
        writebyte((UBYTE) cheat);
        writebyte((UBYTE) logfile);
        writebyte((UBYTE) logconsole);
        writebyte((UBYTE) gfx);
        writebyte((UBYTE) showunimp);
        writebyte((UBYTE) more);
        writebyte((UBYTE) wordwrap);
        writebyte((UBYTE) onekey);
        writebyte((UBYTE) autodice);
        writebyte((UBYTE) wantansi);
        writebyte((UBYTE) plus10mr);
        writebyte((UBYTE) instructions);
        writebyte((UBYTE) berserkable);
        writebyte((UBYTE) confirm);
        writebyte((UBYTE) percent_sell);
        writebyte((UBYTE) minsave);
        if (winx == -1)
        {   writebyte(255);
            writebyte(255);
        } else
        {   writebyte((UBYTE) (winx / 256));
            writebyte((UBYTE) (winx % 256));
        }
        if (winy == -1)
        {   writebyte(255);
            writebyte(255);
        } else
        {   writebyte((UBYTE) (winy / 256));
            writebyte((UBYTE) (winy % 256));
        }
        if (winwidth == -1)
        {   writebyte(255);
            writebyte(255);
        } else
        {   writebyte((UBYTE) (winwidth / 256));
            writebyte((UBYTE) (winwidth % 256));
        }
        if (winheight == -1)
        {   writebyte(255);
            writebyte(255);
        } else
        {   writebyte((UBYTE) (winheight / 256));
            writebyte((UBYTE) (winheight % 256));
        }

        fclose(FileHandle);
        FileHandle = NULL;
    }

    system_die2();

    exit(rc);
}

EXPORT void hourofday(int hour)
{   // Waits 0..24 hours until a specified hour of the day.

    if (HOURNOW < hour)
    {   elapse((     (hour - HOURNOW)) * 60, TRUE);
    } elif (HOURNOW > hour)
    {   elapse((24 + (hour - HOURNOW)) * 60, TRUE);
}   }

EXPORT void thewait(int turns)
{   int i;

    for (i = 0; i < turns; i++)
    {   elapse(10, TRUE);
    }
    aprintf("Waited %d turns.\n", turns);
}
EXPORT void destroy(int which)
{   if (droppable(which))
    {   if (items[which].owned)
        {   items[which].owned--;
        }
        aprintf("Destroyed one %s.\n", items[which].name);
        checkpoison(which);
        checkhands();
}   }

EXPORT void checkhands(void)
{   if
    (   rt != EMPTY
     && rt == lt
     && items[rt].owned == 1
    )
    {   lt = EMPTY;
    } else
    {   if (both != EMPTY && items[both].owned == 0)
        {   both = EMPTY;
        }
        if (rt != EMPTY && items[rt].owned == 0)
        {   rt = EMPTY;
        }
        if (lt != EMPTY && items[lt].owned == 0)
        {   lt = EMPTY;
}   }   }

EXPORT void create_monsters(int which, int howmany)
{   int i;

    if (howmany <= 0)
    {   return;
    }

    if (howmany >= 2)
    {   multimonster = TRUE;
    }
    for (i = 1; i <= howmany; i++)
    {   create_monster(which);
    }
    multimonster = FALSE;

    ok_inwander = FALSE;
}

EXPORT int create_monster(int which)
{   int i;

    if (!countfoes())
    {   theround = 0;
        autofight = FALSE;
    }

    ok_inwander = FALSE;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con == 0 && npc[i].mr == 0)
        {   npc[i].max_st    =
            npc[i].st        = monsters[which].st;
            npc[i].iq        = monsters[which].iq;
            npc[i].max_con   =
            npc[i].con       = monsters[which].con;
            npc[i].dex       = monsters[which].dex;
            npc[i].lk        = monsters[which].lk;
            npc[i].chr       = monsters[which].chr;
            npc[i].spd       = monsters[which].spd;
            npc[i].mr        = monsters[which].mr;
            if (module == MODULE_BC && !plus10mr && npc[i].mr)
            {   // assert(npc[i].mr > 10);
                npc[i].mr -= 10;
            }
            npc[i].dice      = monsters[which].dice;
            npc[i].adds      = monsters[which].adds;
            if (monsters[which].height == 0)
            {   npc[i].height = 72; // 6'
            } else
            {   npc[i].height = monsters[which].height;
            }
            if (monsters[which].rt != EMPTY && items[monsters[which].rt].hands == 2)
            {   // assert(monsters[which].lt < 0);
                npc[i].both  = monsters[which].rt;
                npc[i].rt    =
                npc[i].lt    = EMPTY;
            } else
            {   npc[i].both  = EMPTY;
                npc[i].rt    = monsters[which].rt;
                npc[i].lt    = monsters[which].lt;
            }
            npc[i].armour    = monsters[which].armour;
            npc[i].skin      = monsters[which].skin;
            npc[i].flags     = monsters[which].flags;
            npc[i].level     = monsters[which].level;
         // npc[i].reference = monsters[which].reference;
            npc[i].race      = monsters[which].race;
            npc[i].module    = module;
            npc[i].who       = which;
            monsters[which].created++;
            if (!multimonster && monsters[which].created == 1)
            {   strcpy(npc[i].name, monsters[which].name);
            } else
            {   sprintf(npc[i].name, "%s #%d", monsters[which].name, monsters[which].created);
            }

            if (npc[i].con && !npc[i].mr)
            {   if (npc[i].st  == 0) npc[i].st  = 12;
                if (npc[i].iq  == 0) npc[i].iq  = 12;
                if (npc[i].lk  == 0) npc[i].lk  = 12;
                if (npc[i].dex == 0) npc[i].dex = 12;
                if (npc[i].chr == 0) npc[i].chr = 12;
                if (npc[i].spd == 0) npc[i].spd = 12;
            }

            recalc_ap(i);

            return i;
    }   }

    // assert(0);
    return -1;
}

EXPORT void recalc_ap(int which)
{   if (npc[which].flags & CALC_AP)
    {   if (npc[which].mr)
        {   npc[which].ap = npc[which].mr;
        } else
        {   npc[which].ap = npc[which].iq + npc[which].con + npc[which].st;
    }   }
    else
    {   npc[which].ap = monsters[npc[which].who].ap;
}   }

EXPORT void fight(void)
{   theround       =
    good_hitstaken =
    evil_hitstaken = 0;

    for (;;)
    {   if (con < 1 || !countfoes())
        {   return;
        }
        oneround();
}   }

EXPORT void oneround(void)
{   TRANSIENT int  damage,
                   extradamage,
                   foes,
                   i;
    PERSIST   FLAG fired = FALSE;

    if (!countfoes())
    {   return;
    }

    sayround();
    good_attacktotal =
    good_shocktotal  =
    good_spitetotal  = 0;

    if (theround == 1 && module != MODULE_AK && module != MODULE_DT && !meleeing())
    {   fired = TRUE;
        if (shot(RANGE_POINTBLANK, races[npc[target].race].size, FALSE))
        {   good_attacktotal = calcmissilehits(target);
            good_shocktotal  = good_attacktotal;
    }   }
    else
    {   if (theround == 2 && module != MODULE_AK && module != MODULE_DT && fired)
        {   aprintf("Do you want to change what you are holding?\n");
            hands();
        }
        goodattack();
        fired = FALSE;
    }

    evilattack();
    aprintf
    (   "%s's Hit Point Total is %d, including %d shock.\n",
        name,
        good_attacktotal,
        good_shocktotal
    );
    aprintf
    (   "Enemy Hit Point Total is %d, including %d shock.\n",
        evil_attacktotal,
        evil_shocktotal
    );

    if (good_spitetotal || evil_spitetotal)
    {   aprintf("Applying spite damage...\n");

        if (good_spitetotal)
        {   foes = countfoes();
            // assert(foes);
            extradamage = good_spitetotal % foes;
            damage      = good_spitetotal / foes;
            for (i = 0; i < MAX_MONSTERS; i++)
            {   if (npc[i].con || npc[i].mr)
                {   if (i < extradamage)
                    {   npc_templose_hp(i, damage + 1);
                    } elif (damage >= 1)
                    {   npc_templose_hp(i, damage);
        }   }   }   }

        if (evil_spitetotal)
        {   templose_con(evil_spitetotal);
    }   }

    if (good_attacktotal > evil_attacktotal)
    {   damage = good_attacktotal - evil_attacktotal;
        aprintf("You won by %d.\n", damage);

        if (damage < good_shocktotal)
        {   damage = good_shocktotal;
        }
        damage -= good_spitetotal;
        if (damage >= 1)
        {   damage = poisoneffect(damage);
            damage_enemies(damage);
        }
        evil_shocktotal -= evil_spitetotal;
        if (evil_shocktotal >= 1)
        {   good_takehits(evil_shocktotal, TRUE);
    }   }
    elif (good_attacktotal < evil_attacktotal)
    {   damage = evil_attacktotal - good_attacktotal;
        aprintf("You lost by %d.\n", damage);

        if (damage < evil_shocktotal)
        {   damage = evil_shocktotal;
        }
        damage -= evil_spitetotal;
        if (damage >= 1)
        {   good_takehits(damage, TRUE);
        }

        good_shocktotal -= good_spitetotal;
        if (good_shocktotal >= 1)
        {   damage_enemies(good_shocktotal);
    }   }
    else
    {   aprintf("A draw!\n");

        good_shocktotal -= good_spitetotal;
        evil_shocktotal -= evil_spitetotal;
        if (good_shocktotal >= 1)
        {   damage_enemies(good_shocktotal);
        }
        if (evil_shocktotal >= 1)
        {   good_takehits(evil_shocktotal, TRUE);
}   }   }

MODULE int poisoneffect(int damage)
{   switch (poisoning)
    {
    case CUR:
        damage *= 2;
        aprintf("Damage is doubled (to %d) from curare.\n", damage);
 // acase SPI: ;
    acase DRA:
        damage *= 4;
        aprintf("Damage is quadrupled (to %d) from dragon's venom.\n", damage);
    acase JUI:
        damage = damage * 3 / 2;
        aprintf("Damage is 1½x (to %d) from hellfire juice.\n", damage);
    }

    return damage;
}

MODULE void sayround(void)
{   int i;

    theround++;
    if (theround == 1)
    {   DISCARD showansi(4);
    }

    aprintf
    (   "%s§%d¢ (%02d:%02d on day %d):\nCombat Round %d. You are fighting:\n",
        moduleinfo[module].name,
        room,
        HOURNOW,
         minutes % 60,
        (minutes / ONE_DAY) + 1,
        theround
    );

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con)
        {   aprintf
            (   " %s (ST: %d, IQ: %d, LK: %d, CON: %d, DEX: %d, CHR: %d, SPD: %d) (%s).\n",
                npc[i].name,
                npc[i].st,
                npc[i].iq,
                npc[i].lk,
                npc[i].con,
                npc[i].dex,
                npc[i].chr,
                npc[i].spd,
                sizestring[races[npc[i].race].size]
            );
        } elif (npc[i].mr)
        {   aprintf
            (   " %s (MR: %d) (%s).\n",
                npc[i].name,
                npc[i].mr,
                sizestring[races[npc[i].race].size]
            );
        }

        if ((npc[i].con || npc[i].mr))
        {   if (npc[i].rt != EMPTY || npc[i].lt != EMPTY)
            {   aprintf("  Right hand:     ");
                printiteminfo(npc[i].rt,   FALSE);
                aprintf("  Left  hand:     ");
                printiteminfo(npc[i].lt,   FALSE);
            } else
            {   aprintf("  Both hands:     ");
                printiteminfo(npc[i].both, FALSE);
            }
            aprintf("  Armour:         ");

            if (npc[i].armour == EMPTY)
            {   if (npc[i].skin)
                {   aprintf("Skin (%d hits)\n", npc[i].skin);
                } else
                {   aprintf("None\n");
            }   }
            else
            {   if (npc[i].skin)
                {   aprintf("%s (%d hits) + skin (%d hits)\n", items[npc[i].armour].name, items[npc[i].armour].hits, npc[i].skin);
                } else
                {   aprintf("%s (%d hits)\n", items[npc[i].armour].name, items[npc[i].armour].hits);
    }   }   }   }

    if (!reactable)
    {   aprintf("You: ST: %d of %d, IQ: %d, LK: %d, CON: %d of %d. DEX: %d. CHR: %d. SPD: %d.\n", st, max_st, iq, lk, con, max_con, dex, chr, spd);
    }

    elapse(2, FALSE); // RB94: "No recovery takes place during combat itself."
}

EXPORT void good_freeattack(void)
{   sayround();
    goodattack();
    damage_enemies(good_attacktotal);
}

EXPORT void evil_freeattack(void)
{   sayround();
    evilattack();
    good_takehits(evil_attacktotal, TRUE);
}

EXPORT int countfoes(void)
{   int foes = 0,
        i;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con)
        {   foes++;
        } elif (npc[i].mr)
        {   foes++;
    }   }

    if (!foes)
    {   ok_inwander = FALSE;
        if (berserk)
        {   berserk = FALSE;
            aprintf("%s calms down.\n", name);
    }   }

    return foes;
}

EXPORT void dispose_npcs(void)
{   int i;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   npc[i].con =
        npc[i].mr  = 0;
    }

    ok_inwander = FALSE;
    if (berserk)
    {   berserk = FALSE;
        aprintf("%s calms down.\n", name);
}   }

EXPORT void drop_all(void)
{   int i;

    pay_cp_only(cp);
    pay_sp_only(sp);
    pay_gp_only(gp);
    for (i = 0; i < ITEMS; i++)
    {   dropitems(i, items[i].owned);
}   }

EXPORT void goodattack(void)
{   TRANSIENT TEXT letter;
    TRANSIENT int  tempmodule,
                   temproom;
    PERSIST   int  autoend = 0;

    good_attacktotal =
    good_shocktotal  =
    good_spitetotal  = 0;

    for (;;)
    {   if (autofight && !spite && getyn("Turn on spite damage"))
        {   spite = TRUE;
        }
        if (autofight && theround != autoend)
        {   letter = 'F';
        } else
        {   autofight = FALSE;
            enable_items(TRUE);
            enable_spells(TRUE);
            avail_armour  =
            avail_cast    =
            avail_fight   =
            avail_hands   =
            avail_options =
            avail_autofight =
            avail_use     =
            avail_view    = TRUE;
            letter = getletter("øA¢rmour/øC¢ast/øF¢ight/øH¢ands/øO¢ptions/auøT¢ofight/øU¢se/øV¢iew", "ACFHOTUV", "", "", "", "", "", "", "", "", 'F'); // or perhaps 'T' would be better
            enable_items(FALSE);
            enable_spells(FALSE);
            avail_armour  =
            avail_cast    =
            avail_fight   =
            avail_hands   =
            avail_options =
            avail_autofight =
            avail_use     =
            avail_view    = FALSE;
            if (letter == 'T')
            {   autofight = TRUE;
                autoend = theround + 50;
                letter = 'F';
            } else
            {   autofight = FALSE;
        }   }

        switch (letter)
        {
        case 'A':
            weararmour(EMPTY);
        acase 'C':
            incombat = TRUE;
            if (castspell(-1, 2))
            {   usedweapons = FALSE;
                incombat = FALSE;
                return;
            } else
            {   incombat = FALSE;
                aprintf("No spell cast.\n");
            }
        acase 'F':
            fight2();
            return;
        acase 'H':
            hands();
        acase 'O':
            temproom   = room;
            tempmodule = module;
            options();
            if (temproom != room || tempmodule != module)
            {   dispose_npcs();
                return;
            }
        acase 'U':
            use(-1);
        acase 'V':
            view_man();
}   }   }

EXPORT void evilattack(void)
{   int i,
        evil_spitedamage,
        thisattack;

    aprintf("Calculating enemy attack(s)...\n");

    evil_attacktotal =
    evil_spitetotal  = 0;
    evil_shocktotal  = 0;

    if (cheat)
    {   return;
    } // implied else

    for (i = 0; i < MAX_MONSTERS; i++)
    {   thisattack       =
        evil_spitedamage = 0;
        if (npc[i].mr)
        {   thisattack += dice((npc[i].mr / 10) + 1);
            evil_spitedamage = sixes;
            if (module == MODULE_AB || module == MODULE_BW)
            {   thisattack *= scaling;
            }

            thisattack += (npc[i].mr / 2);
            if (npc[i].mr % 2)
            {   thisattack++; // to round up
            }
            if ((module == MODULE_AB || module == MODULE_BW) && scaling >= 2)
            {   aprintf
                (   "%s's %d dice (×%d) and %d adds generated %d hits.\n",
                    npc[i].name,
                    (npc[i].mr / 10) + 1,
                    scaling,
                    (npc[i].mr % 2) ? ((npc[i].mr / 2) + 1) : (npc[i].mr / 2),
                    thisattack
                );
            } else
            {   aprintf
                (   "%s's %d dice and %d adds generated %d hits.\n",
                    npc[i].name,
                    (npc[i].mr / 10) + 1,
                    (npc[i].mr % 2) ? ((npc[i].mr / 2) + 1) : (npc[i].mr / 2),
                    thisattack
                );
        }   }
        elif (npc[i].con)
        {   if (npc[i].flags & CALC_DICE)
            {   thisattack += calc_attack(npc[i].rt, npc[i].lt, npc[i].both, FALSE);
                evil_spitedamage = spitedamage;
            } else
            {   thisattack += dice(npc[i].dice);
                evil_spitedamage = sixes;
                numdice = npc[i].dice;
                numwpnadds = 0;
            }
            if (spell[SPELL_WY].active) // %%: it's ambiguous exactly what "weapon attack die roll" means. We assume it means just the weapon dice, not any adds.
            {   thisattack /= 3;
            }
            if (npc[i].flags & CALC_ADDS)
            {   thisattack += calc_personaladds(npc[i].st, npc[i].lk, npc[i].dex);
            } else
            {   thisattack += npc[i].adds;
            }
            aprintf
            (   "%s's %d dice and %d adds generated %d hits.\n",
                npc[i].name,
                numdice,
                numwpnadds + ((npc[i].flags & CALC_ADDS) ? calc_personaladds(npc[i].st, npc[i].lk, npc[i].dex) : npc[i].adds),
                thisattack
            );
        }
        if (!spite)
        {   evil_spitedamage = 0;
        }
        if (evil_spitedamage)
        {   aprintf
            (   "%s also generated %d spite damage.\n",
                npc[i].name,
                evil_spitedamage
            );
        }

        if (thisattack < 0)
        {   thisattack = 0;
        }
        evil_attacktotal += thisattack;
        evil_spitetotal  += evil_spitedamage;
}   }

EXPORT void good_takehits(int damage, FLAG doublable)
{   int hitstaken;

    if (damage < 0)
    {   damage = 0;
    }
    good_hitstaken += damage;

    if (armour != EMPTY)
    {   if (doublable && class == WARRIOR)
        {   hitstaken = items[armour].hits * 2;
        } elif (doublable && class == WARRIORWIZARD)
        {   hitstaken = items[armour].hits + 1;
        } else
        {   hitstaken = items[armour].hits;
        }
        aprintf("Your %s absorbed %d hits.\n", items[armour].name, hitstaken);
        damage -= hitstaken;
    } else
    {   if (head != EMPTY)
        {   if (doublable && class == WARRIOR)
            {   hitstaken = items[head].hits * 2;
            } else
            {   hitstaken = items[head].hits;
            }
            aprintf("Your %s absorbed %d hits.\n", items[head].name, hitstaken);
            damage -= hitstaken;
        }
        if (arms != EMPTY)
        {   if (doublable && class == WARRIOR)
            {   hitstaken = items[arms].hits * 2;
            } else
            {   hitstaken = items[arms].hits;
            }
            aprintf("Your %s absorbed %d hits.\n", items[arms].name, hitstaken);
            damage -= hitstaken;
        }
        if (chest != EMPTY)
        {   if (doublable && class == WARRIOR)
            {   hitstaken = items[chest].hits * 2;
            } else
            {   hitstaken = items[chest].hits;
            }
            aprintf("Your %s absorbed %d hits.\n", items[chest].name, hitstaken);
            damage -= hitstaken;
        }
        if (legs != EMPTY)
        {   if (doublable && class == WARRIOR)
            {   hitstaken = items[legs].hits * 2;
            } else
            {   hitstaken = items[legs].hits;
            }
            aprintf("Your %s absorbed %d hits.\n", items[legs].name, hitstaken);
            damage -= hitstaken;
    }   }

    if (both != EMPTY && items[both].hits >= 1)
    {   if (items[both].type == SHIELD && class == WARRIOR)
        {   damage -= items[both].hits * 2;
            aprintf("Your %s absorbed %d hits.\n", items[both  ].name, items[both  ].hits * 2);
        } elif (items[both].type == SHIELD && class == WARRIORWIZARD)
        {   damage -= items[both].hits + 1;
            aprintf("Your %s absorbed %d hits.\n", items[both  ].name, items[both  ].hits + 1);
        } else
        {   damage -= items[both].hits;
            aprintf("Your %s absorbed %d hits.\n", items[both  ].name, items[both  ].hits    );
    }   }

    if (rt != EMPTY && items[rt].hits >= 1)
    {   if (items[rt].type == SHIELD && class == WARRIOR)
        {   damage -= items[rt].hits * 2;
            aprintf("Your %s absorbed %d hits.\n", items[rt    ].name, items[rt    ].hits * 2);
        } elif (items[rt].type == SHIELD && class == WARRIORWIZARD)
        {   damage -= items[rt].hits + 1;
            aprintf("Your %s absorbed %d hits.\n", items[rt    ].name, items[rt    ].hits + 1);
        } else
        {   damage -= items[rt].hits;
            aprintf("Your %s absorbed %d hits.\n", items[rt    ].name, items[rt    ].hits    );
    }   }

    if (lt != EMPTY && items[lt].hits >= 1)
    {   if (items[lt].type == SHIELD && class == WARRIOR)
        {   damage -= items[lt].hits * 2;
            aprintf("Your %s absorbed %d hits.\n", items[lt    ].name, items[lt    ].hits * 2);
        } elif (items[lt].type == SHIELD && class == WARRIORWIZARD)
        {   damage -= items[lt].hits + 1;
            aprintf("Your %s absorbed %d hits.\n", items[lt    ].name, items[lt    ].hits + 1);
        } else
        {   damage -= items[lt].hits;
            aprintf("Your %s absorbed %d hits.\n", items[lt    ].name, items[lt    ].hits    );
    }   }

    if (ability[149].known)
    {   aprintf("Your skin absorbed 1 hit.\n");
        damage--;
    }

    if (damage < 0)
    {   damage = 0;
    }
    good_damagetaken = damage;
    aprintf("You suffered %d actual damage.\n", damage);

    templose_con(damage);
}

MODULE int calcmissilehits(int target)
{   int damage;

    // Note that for thrown weapons, the player has already "dropped" it, so items[missileammo].owned can be validly 0

    if (items[missileammo].dice || items[missileammo].adds)
    {   damage = dice(items[missileammo  ].dice) + items[missileammo  ].adds + calc_missileadds(st, lk, dex);
    } else
    {   damage = dice(items[missileweapon].dice) + items[missileweapon].adds + calc_missileadds(st, lk, dex);
    }
    if (missileammo == ITEM_CI_SLINGSTONE)
    {   aprintf("Damage is tripled.\n");
        damage *= 3;
    }
    damage = poisoneffect(damage);
    if (!npc[target].mr && npc[target].lk && items[missileweapon].type == WEAPON_GUNNE)
    {   getsavingthrow(FALSE);
        damage -= madeitby(1, npc[target].lk);
    }
    if (damage < 0)
    {   damage = 0;
    }

    return damage;
}

EXPORT void evil_takemissilehits(int target)
{   evil_takehits(target, calcmissilehits(target));
}

EXPORT void evil_takehits(int which, int damage)
{   if (damage < 0)
    {   damage = 0;
    }
    evil_hitstaken += damage;

    if (npc[which].armour != EMPTY)
    {   damage -= items[npc[which].armour].hits;
        aprintf("%s's %s absorbed %d hits.\n", npc[which].name, items[npc[which].armour].name, items[npc[which].armour].hits);
    }
    if (npc[which].skin)
    {   damage -= npc[which].skin;
        aprintf("%s's skin absorbed %d hits.\n", npc[which].name, npc[which].skin);
    }
    if (npc[which].both != EMPTY && items[npc[which].both].hits >= 1)
    {   damage -= items[npc[which].both].hits;
        aprintf("%s's %s absorbed %d hits.\n", npc[which].name, items[npc[which].both].name,   items[npc[which].both  ].hits);
    }
    if (npc[which].rt != EMPTY && items[npc[which].rt].hits >= 1)
    {   damage -= items[npc[which].rt].hits;
        aprintf("%s's %s absorbed %d hits.\n", npc[which].name, items[npc[which].rt].name,     items[npc[which].rt    ].hits);
    }
    if (npc[which].lt != EMPTY && items[npc[which].lt].hits >= 1)
    {   damage -= items[npc[which].lt].hits;
        aprintf("%s's %s absorbed %d hits.\n", npc[which].name, items[npc[which].lt].name,     items[npc[which].lt    ].hits);
    }
    if (damage < 0)
    {   damage = 0;
    }
    evil_damagetaken = damage;

    if
    (   ((rt == 194 || lt == 194) && races[npc[which].race].undead )
     || ((rt == 939 || lt == 939) &&       npc[which].race == DEMON)
    )
    {   aprintf("Your weapon inflicted infinite damage on the %s!\n", damage, npc[which].name);
        kill_npc(which);
    } else
    {   if (npc[which].con) // For creatures with both CONs and MRs (eg. BW95), damage comes off CON.
        {   aprintf("You inflicted %d actual damage on %s", damage, npc[which].name);
            npc[which].con -= damage;
            if (npc[which].con <= 0)
            {   aprintf(", killing %s!\n", table_pronouns[monsters[npc[which].who].sex]);
                kill_npc(which);
            } else
            {   aprintf(".\n");
        }   }
        elif (npc[which].mr)
        {   aprintf("You inflicted %d actual damage on the %s", damage, npc[which].name);
            npc[which].mr -= damage;
            if (npc[which].mr <= 0)
            {   aprintf(", killing %s!\n", table_pronouns[monsters[npc[which].who].sex]);
                kill_npc(which);
            } else
            {   aprintf(".\n");
}   }   }   }

EXPORT void kill_npc(int which)
{   if (npc[which].con == 0 && npc[which].mr == 0)
    {   return;
    }

    killcount[npc[which].race]++;
    if (npc[which].ap >= 1)
    {   award(npc[which].ap);
    }
    aprintf("Killed %s.\n", npc[which].name);
    npc[which].con =
    npc[which].mr  = 0;
    if (npc[which].both != EMPTY)
    {   give(npc[which].both);
    }
    if (npc[which].rt != EMPTY)
    {   give(npc[which].rt);
    }
    if (npc[which].lt != EMPTY)
    {   give(npc[which].lt);
    }
    if (npc[which].armour != EMPTY)
    {   give(npc[which].armour);
    }
    if (!countfoes())
    {   ok_inwander = FALSE;
        if (berserk)
        {   berserk = FALSE;
            aprintf("%s calms down.\n", name);
}   }   }

EXPORT void damage_enemies(int damage)
{   int extradamage,
        foes,
        i;

    if (damage <= 0)
    {   return;
    }
    foes = countfoes();
    if (foes == 0)
    {   return;
    }

    extradamage =  damage % foes;
    damage      /= foes;
    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con || npc[i].mr)
        {   if (i < extradamage)
            {   evil_takehits(i, damage + 1);
            } else
            {   evil_takehits(i, damage);
}   }   }   }

EXPORT int calc_personaladds(int st, int lk, int dex)
{   int adds = 0;

    if (st < 9)
    {   adds -=   9 - st;
    } elif (st > 12)
    {   adds +=  st - 12;
    }
    if (lk < 9)
    {   adds -=   9 - lk;
    } elif (lk > 12)
    {   adds +=  lk - 12;
    }
    if (dex < 9)
    {   adds -=   9 - dex;
    } elif (dex > 12)
    {   adds += dex - 12;
    }

    return adds;
}

EXPORT int calc_missileadds(int st, int lk, int dex)
{   int adds = 0;

    if (st < 9)
    {   adds -=    9 - st;
    } elif (st > 12)
    {   adds +=   st - 12;
    }
    if (lk < 9)
    {   adds -=    9 - lk;
    } elif (lk > 12)
    {   adds +=   lk - 12;
    }
    if (dex < 9)
    {   adds -= (  9 - dex) * 2;
    } elif (dex > 12)
    {   adds += (dex -  12) * 2;
    }

    return adds;
}

EXPORT void kill_npcs(void)
{   int i;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con || npc[i].mr)
        {   kill_npc(i);
}   }   }

EXPORT int gettarget(void)
{   int i,
        target;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].con)
        {   aprintf
            (   "%d: %s (CON: %d).\n",
                i + 1,
                npc[i].name,
                npc[i].con
            );
        } elif (npc[i].mr)
        {   aprintf
            (   "%d: %s (MR: %d).\n",
                i + 1,
                npc[i].name,
                npc[i].mr
            );
    }   }

    for (;;)
    {   target = getnumber("Target which monster (ø0¢ for none)", 0, MAX_MONSTERS) - 1;
        if (target == -1)
        {   return -1;
        } elif (!npc[target].con && !npc[target].mr)
        {   aprintf("No such monster!\n");
        } else
        {   sayround();
            return target;
}   }   }

EXPORT FLAG cast(int which, int takeeffect)
{   int  j;
    TEXT tempstring[160 + 1];

    spellchosen = -1;

    if (!spell[which].known)
    {   aprintf("You don't know %s!\n", spell[which].corginame);
        return FALSE;
    }
    if (ability[23].known)
    {   aprintf("You can't cast %s because of manacles!\n", spell[which].corginame);
        return FALSE;
    }

    listspell(which, TRUE);

    sprintf(tempstring, "Cast %s", spell[which].corginame);
    if (!getyn(tempstring))
    {   return FALSE;
    }
    if (iq < spellinfo[spell[which].level].iq)
    {   aprintf("Not enough IQ to cast level %d spells!\n", spell[which].level);
        return FALSE;
    }
    if (dex < spellinfo[spell[which].level].dex)
    {   aprintf("Not enough DEX to cast level %d spells!\n", spell[which].level);
        return FALSE;
    }
 /* if (!spell[which].flags.combat && countfoes())
    {   aprintf("That is not a combat spell!\n");
        return FALSE;
    } %%: eg. CD185 expects a SPELL_CC to be able to be cast in the presence of foes */

    spellchosen = which;
    spellcost = spell[which].st;
    switch (which)
    {
    case SPELL_DM: // Detect Magic
        if (class == ROGUE)
        {   spellcost = 1;
        } // else spellcost = 0;
    acase SPELL_RS: // Restoration
        spellcost = getnumber("Expend how many ST points (2 ST expended per 1 CON healed)", 0, 9999);
        spelleffect = spellcost / 2;
    acase SPELL_CY: // Curse You
        spellcost = level * 2;
        spelleffect = level;
/*  SPELL_MF: 1 per round
    SPELL_OE: 1 per round
    SPELL_EX: MR or total attributes of victim
    SPELL_SH: double the total attributes of victim
    SPELL_SR: costs 5 per attribute point */
    }

    if ((spell[which].flags & SPELL_CIRCLE) && (spell[which].flags & SPELL_TRIANGLE))
    {   aprintf("%s may be raised for effect or duration (but not both).\n", spell[which].corginame);
    } elif (spell[which].flags & SPELL_CIRCLE)
    {   aprintf("%s may be raised for effect only.\n", spell[which].corginame);
    } elif (spell[which].flags & SPELL_TRIANGLE)
    {   aprintf("%s may be raised for duration only.\n", spell[which].corginame);
    }
    if (spell[which].flags & SPELL_CIRCLE)
    {   sprintf(tempstring, "Cast %s at which level for effect", spell[which].corginame);
        j = getnumber(tempstring, spell[which].level, level);
        spelllevel = j;
        spellcost *= j - spell[which].level + 1;
        if (which == SPELL_TF)
        {   spelleffect = j;
        } else
        {   spelleffect = 1 << (j - spell[which].level);
    }   }
    else
    {   spelleffect =
        spelllevel  = 1;
    }
    if (spelleffect == 1 && (spell[which].flags & SPELL_TRIANGLE))
    {   sprintf(tempstring, "Cast %s at which level (%d-%d) for duration", spell[which].corginame, spell[which].level, level);
        j = getnumber(tempstring, spell[which].level, level);
        spelllevel = j;
        spellcost *= j - spell[which].level + 1;
        spellduration = 1 << (j - spell[which].level);
    } else
    {   spellduration =
        spelllevel    = 1;
    }

    // proficiency
    if (spell[which].level > level)
    {   spellcost += spell[which].level - level;
    } elif (spell[which].level < level)
    {   if (class == WIZARD)
        {   spellcost -= level - spell[which].level;
        } elif (class == WARRIORWIZARD)
        {   spellcost -= (level - spell[which].level) / 2;
    }   }

    // staves
    if (class == WIZARD || class == WARRIORWIZARD)
    {   if (items[ITEM_AS_SDELUXE].owned)
        {   spellcost /= 2;
            aprintf("Special deluxe magic staff cuts ST cost in half.\n");
        } elif (items[ITEM_GK_CDELUXE].owned)
        {   spellcost += level;
            aprintf("Cursed deluxe magic staff raises ST cost by %d.\n", level);
        } elif
        (   items[ORD].owned
         || items[ORQ].owned
         || items[MAK].owned
         || items[DEL].owned
         || items[ITEM_BW_DELUXEI].owned
         || items[ITEM_OK_DELUXER].owned
         || items[ITEM_NS_HOMUNCULUS].owned
         || items[923].owned
        )
        {   spellcost -= level;
            aprintf("Magic staff lowers ST cost by %d.\n", level);
    }   }

    if (spellcost < 1)
    {   if (which == SPELL_DM && class != ROGUE)
        {   spellcost = 0;
        } else
        {   spellcost = 1;
    }   }

    if (spellcost >= st)
    {   aprintf("Your ST is only %d and the spell will cost %d ST, so you will die.\n", st, spellcost);
        if (!getyn("Really cast it"))
        {   return FALSE; // we should probably allow them to cast it at a lower level instead
    }   }
    // If their ST was exactly equal to the spell cost, the spell is supposed to take effect as they die.
    // We don't support that.

    templose_st(spellcost);
    award(spellcost);

    switch (which)
    {
    case SPELL_TF:
        spellpower = spelleffect * iq;
    acase SPELL_BP:
    case SPELL_IF:
        spellpower = level + calc_personaladds(st, lk, dex);
    acase SPELL_PA:
        spellpower = iq + lk + chr;
    acase SPELL_RS:
    case SPELL_CY:
        spellpower = spelleffect;
    acase SPELL_DW:
        spellpower = st + iq + chr;
    acase SPELL_FM:
        spellpower = spelleffect * level * iq;
    acase SPELL_FA:
        spellpower = iq * 10;
    acase SPELL_OW:
        permlose_st(st / 2);
    acase SPELL_FI:
        spellpower = spelleffect + dice(2);
    acase SPELL_FF:
        spellpower = anydice(1, 2);
    }

    aprintf("You cast %s.\n", spell[which].corginame);

    if (wanderer)
    {   if (takeeffect == 2)
        {   payload(FALSE);
        } elif (takeeffect)
        {   payload(TRUE);
    }   }
    else
    {   switch (module)
        {
        case MODULE_AB:
            ab_magicmatrix();
        acase MODULE_AS:
            if (!inmatrix)
            {   as_magicmatrix();
            }
        acase MODULE_AK:
            ak_magicmatrix();
        acase MODULE_BW:
            bw_magicmatrix();
        acase MODULE_CD:
            cd_magicmatrix();
        acase MODULE_CA:
            ca_magicmatrix();
        acase MODULE_CI:
            if (!inmatrix)
            {   ci_magicmatrix();
            }
        acase MODULE_DD:
            if (!inmatrix)
            {   dd_magicmatrix();
            }
        acase MODULE_NS:
            ns_magicmatrix();
        acase MODULE_OK:
            ok_magicmatrix();
        acase MODULE_SM:
            sm_magicmatrix();
        acase MODULE_WC:
            wc_magicmatrix();
        adefault:
            if (takeeffect == 2)
            {   payload(FALSE);
            } elif (takeeffect)
            {   payload(TRUE);
    }   }   }

    return TRUE;
}

EXPORT void payload(FLAG now)
{   int choice,
        extend,
        i;

    /* %%:
    Regarding EH and VB:
     Does EH affect only the basic dice (like VB), or the dice and adds?
     EH is probably meant to be specifically applied to a certain weapon,
      whereas we just apply it to whatever weapon(s) they are using (as
      with VB).
     These spells (and most others) are only implemented for the player,
      ie. enemies can't make use of them yet.
     What should happen when both spells are active? (We are just doing
      the EH and not the VB in that case.)
     If we cast a spell while it is already active, the extra duration
      is tacked onto the end, which might not be the correct thing to do.
      And, we change the power for the entire period (instead of different
      parts of the period having potentially different powers).
    Regarding DE and SF:
     What if both are active? We are allowing them to stack together.
     Maybe we should do the extra rounds as proper ones, eg. let you cast
      other spells, change weapons, etc.
     If using DE, each combat round should arguably be 4 minutes (or
      more), not 2.
    */

    good_attacktotal =
    good_shocktotal  = 0;

    extend = spell[spellchosen].duration * spellduration;

    switch (spellchosen)
    {
    case SPELL_BA:
        lose_flag_ability(2); // CT3
    acase SPELL_BN:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if
            (   alive(i)
             && (npc[i].race == DEMON || npc[i].race == DAEMON1 || npc[i].race == DAEMON2 || npc[i].race == IMP || npc[i].race == SUCCUBUS)
            )
            {   kill_npc(i); // %%: it doesn't say whether it affect just one or all, we assume all
        }   }
    acase SPELL_BP:
    case SPELL_IF:
    case SPELL_FM:
    case SPELL_FA:
    case SPELL_FI:
    case SPELL_FF:
        good_attacktotal += spellpower;
        good_shocktotal  += spellpower;
        if (now)
        {   damage_enemies(good_shocktotal);
        }
    acase SPELL_CF:
        spell_cf(spelllevel);
    acase SPELL_CR:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if
            (   (npc[i].con || (npc[i].mr && npc[i].mr < iq * level)) // %%: what about undead with attributes instead of MR? We assume they are always affected.
             && (races[npc[i].race].undead || npc[i].race == DEMON || npc[i].race == DAEMON1 || npc[i].race == DAEMON2)) // %%: it's ambiguous about exactly what is affected
            {   kill_npc(i);
        }   }
    acase SPELL_CU: // %%: rather ambiguous about exactly how this spell works
        i = gettarget();
        if (i == -1) break;
        if (npc[i].dex)
        {   getsavingthrow(FALSE);
            if (madeit(level, npc[i].dex))
            {   getsavingthrow(TRUE);
                if (madeit(level + 1, dex))
                {   npc_lose_dex(i, npc[i].dex - 1);
                } else
                {   change_dex(1);
            }   }
            else
            {   npc_lose_dex(i, npc[i].dex - 1);
        }   }
    acase SPELL_CY:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].mr)
        {   npc_permlose_hp(i, spellpower);
        } else
        {   choice = getnumber
            (   "1 = Strength\n" \
                "2 = Intelligence\n" \
                "3 = Luck\n" \
                "4 = Constitution\n" \
                "5 = Dexterity\n" \
                "6 = Charisma\n" \
                "7 = Speed\n" \
            "Which", 1, 7);
            switch (choice)
            {
            case 1:
                npc_permlose_st(i, spellpower);
            acase 2:
                npc_lose_iq(i, spellpower);
            acase 3:
                npc_lose_lk(i, spellpower);
            acase 4:
                npc_permlose_hp(i, spellpower);
            acase 5:
                npc_lose_dex(i, spellpower);
            acase 6:
                npc_lose_chr(i, spellpower);
            acase 7:
                npc_lose_spd(i, spellpower);
        }   }
    acase SPELL_D2:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].chr > 4)
        {   npc_lose_chr(i, npc[i].chr - 4);
        }
    acase SPELL_D9:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].lk) // %%: what if they have a MR instead?
        {   getsavingthrow(FALSE);
            if (!madeit(9, npc[i].lk))
            {   kill_npc(i);
        }   }
    acase SPELL_DB:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].race == DEMON)
            {   if
                (   (npc[i].mr  && npc[i].mr <= level * iq)
                 || (npc[i].con && npc[i].iq <=         iq)
                )
                {   kill_npc(i);
                    break;
        }   }   }
    acase SPELL_DN:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if
            (   alive(i)
             && (npc[i].race == DEMON || npc[i].race == DAEMON1 || npc[i].race == DAEMON2 || npc[i].race == IMP || npc[i].race == SUCCUBUS)
             && ((npc[i].con && npc[i].iq <= iq) || (npc[i].mr && npc[i].mr <= iq * level))
            )
            {   kill_npc(i); // %%: it doesn't say whether it affect just one or all, we assume all
        }   }
    acase SPELL_DS:
        // %%: probably we should require casting a separate DS spell for each dispelling, rather than one casting dispelling all magicks
        if (spelllevel >=  4)
        {   if (ability[145].known)
            {   lose_flag_ability(145);
            }
            if (ability[146].known)
            {   lose_flag_ability(146);
        }   }
        if (spelllevel >=  5 && ability[144].known)
        {   lose_flag_ability(144);
        }
        if (spelllevel >= 12 && items[198].owned)
        {   items[700].owned += items[198].owned;
            items[198].owned = 0;
        }
        if (spelllevel >= 17 && items[275].owned)
        {   items[275].owned = 0;
        }
    acase SPELL_DT:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].iq)
        {   getsavingthrow(FALSE);
            if (!madeit(1, npc[i].iq))
            {   aprintf("Words to say?\n");
                show_output();
                loop(FALSE);
                if (userinput[0])
                {   aprintf("%s says: %s\n", npc[i].name, userinput);
        }   }   }
    acase SPELL_DW:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if
            (   npc[i].mr  > 0 && spellpower > npc[i].mr
             || npc[i].con > 0 && spellpower > npc[i].st + npc[i].iq + npc[i].chr
            )
            {   // Strictly speaking, they should be asleep (for 1-6 turns), not dead. We assume the player kills them.
                kill_npc(i);
        }   }
    acase SPELL_EX:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].mr)
        {   templose_st(npc[i].mr);
        } elif (npc[i].con)
        {   templose_st(npc[i].st + npc[i].iq + npc[i].lk + npc[i].con + npc[i].dex + npc[i].chr + npc[i].spd); // %%: it doesn't say whether SPD is considered to be an attribute. We assume so.
        }
        // We are doing the strength loss now instead of at cast() time, because we need a target to calculate the cost.
        // Unfortunately, this means things like staves, high character level, etc. won't affect the casting cost.
        if (races[npc[i].race].undead)
        {   kill_npc(i);
        }
    acase SPELL_GH:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if ((npc[i].mr || npc[i].con) && npc[i].race == GHOST)
            {   kill_npc(i);
                break;
        }   }
    acase SPELL_HB:
        kill_npcs();
    acase SPELL_HF:
        spell_hf();
    acase SPELL_HP:
        // %%: We assume there is a piece of wood lying around.
        // Maybe we should require them to expend a club or something?
        // Or have a "stick" item that they can "buy" for free (or 1 cp) from the shop?
        if (saved(1, lk))
        {   give(MAK);
        } else
        {   aprintf("The wood was unsuitable!\n");
        }
    acase SPELL_IU:
        i = gettarget();
        if (i == -1) break;
        good_attacktotal += dice(2) * 10; // 20..120
    acase SPELL_KR:
        i = gettarget();
        if (i == -1) break;
        if
        (   (npc[i].mr  && iq >= npc[i].mr  / 2)
         || (npc[i].con && iq >= npc[i].con / 2)
        )
        {   good_attacktotal += dice(3);
        }
    acase SPELL_OE:
        if (items[498].owned)
        {   aprintf("%s%d:\n%s\n\n", moduleinfo[MODULE_GK].name, 183, descs[MODULE_GK][183]);
        }
    acase SPELL_MM:
        lose_flag_ability(47);
    acase SPELL_PA:
        // %%: does this affect a single target or many? We are assuming many.
        // %%: what about monsters with CON instead of MR? We handle it as if it were CON, based on DT313.
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if
            (   (npc[i].mr  > 0 && spellpower > npc[i].mr)
             || (npc[i].con > 0 && spellpower > npc[i].con)
            )
            {   // Strictly speaking, they should run away instead of dying.
                kill_npc(i);
            } // else "[The monster chases the magic-user to the exclusion of his or her comrades.]"
        }
    acase SPELL_RB:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].con && npc[i].st + npc[i].lk + npc[i]. iq < st + lk + iq)
        {   kill_npc(i);
        } elif (npc[i].st + npc[i].lk + npc[i]. iq > st + lk + iq)
        {   die();
        }
    acase SPELL_RS:
        heal_con(spellpower);
    acase SPELL_SG:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].mr)
            {   npc_templose_hp(i, npc[i].mr  / 2);
            } elif (npc[i].con)
            {   npc_templose_hp(i, npc[i].con / 2);
        }   }
    acase SPELL_SR:
        i = gettarget();
        if (i == -1) break;
        if (npc[i].mr)
        {   choice = getnumber
            (   "1 = Strength\n" \
                "2 = Constitution\n" \
            "Which", 1, 2);
            npc_permlose_hp(i, spellpower);
            switch (choice)
            {
            case 1:
                gain_st(spellpower);
            acase 2:
                gain_con(spellpower);
        }   }
        elif (npc[i].con)
        {   choice = getnumber
            (   "1 = Strength\n" \
                "2 = Intelligence\n" \
                "3 = Luck\n" \
                "4 = Constitution\n" \
                "5 = Dexterity\n" \
                "6 = Charisma\n" \
                "7 = Speed\n" \
            "Which", 1, 7);
            switch (choice)
            {
            case 1:
                npc_permlose_st(i, spellpower);
                gain_st(spellpower);
            acase 2:
                npc_lose_iq(i, spellpower);
                gain_iq(spellpower);
            acase 3:
                npc_lose_lk(i, spellpower);
                gain_lk(spellpower);
            acase 4:
                npc_permlose_hp(i, spellpower);
                gain_con(spellpower);
            acase 5:
                npc_lose_dex(i, spellpower);
                gain_dex(spellpower);
            acase 6:
                npc_lose_chr(i, spellpower);
                gain_chr(spellpower);
            acase 7:
                npc_lose_spd(i, spellpower);
                gain_spd(spellpower);
        }   }
    acase SPELL_SW:
        extend *= dice(1);
    acase SPELL_TF:
        good_attacktotal += spellpower;
        good_shocktotal  += spellpower;
        if (now) // really we should support gettarget() even if not "now"
        {   i = gettarget();
            if (i != -1)
            {   evil_takehits(i, good_shocktotal);
        }   }
    acase SPELL_TM:
        extend *= dice(1);
    acase SPELL_TT:
        spell_tt();
    acase SPELL_W7:
        i = gettarget();
        if (i == -1) break;
        kill_npc(i);
    acase SPELL_WL:
        i = gettarget();
        if (i == -1) break;
        npc[i].iq = 3;
    acase SPELL_WZ:
        if (items[868].owned)
        {   for (i = 0; i < SPELLS; i++)
            {   if (spell[i].level <= 11 && spell[i].level <= level)
                {   learnspell(i);
        }   }   }
    acase SPELL_ZA:
    case SPELL_ZP:
        extend *= dice(1);
    acase SPELL_ZX:
        i = gettarget();
        if (i == -1) break;
        spellpower = level + calc_missileadds(st, lk, dex);
        good_attacktotal += spellpower;
        good_shocktotal  += spellpower; // %%: we assume this spell generate shock damage
    }

    if (extend)
    {   extendspell(spellchosen, spelleffect, extend);
}   }

EXPORT void rebound(FLAG quiet)
{   int result;

    if (!quiet)
    {   aprintf("The spell rebounds; superior magic sends your spell back at you. You must absorb its effects.\n");
    }

    // It would be good to at least do the rebound()s of DE, EH, MF, SF, VB.

    switch (spellchosen)
    {
    case SPELL_BP:
    case SPELL_IF:
        good_takehits(spellpower, TRUE);
    acase SPELL_CY:
        result = anydice(1, 7);
        switch (result)
        {
        case 1:
            permlose_st(spellpower);
        acase 2:
            lose_iq(spellpower);
        acase 3:
            lose_lk(spellpower);
        acase 4:
            permlose_con(spellpower);
        acase 5:
            lose_dex(spellpower);
        acase 6:
            lose_chr(spellpower);
        acase 7:
            lose_spd(spellpower);
        }
    acase SPELL_D2:
        if (chr > 4)
        {   change_chr(4);
        }
    acase SPELL_D9:
        if (!saved(9, lk))
        {   die();
        }
    acase SPELL_DW:
        if (spellpower > st + iq + chr)
        {   // Strictly speaking, they should be asleep (for 1-6 turns), not dead
            die();
        }
    acase SPELL_HB:
        die();
    acase SPELL_PA:
        ; // %%: CD48 Magic Matrix makes SPELL_PA rebound, but we are immune because we don't have a MR!
    acase SPELL_TF:
        good_takehits(spellpower, TRUE);
    acase SPELL_WL:
        change_iq(3);
}   }

EXPORT void drop_or_get(FLAG getting, FLAG dropanything)
{   TEXT letter;
    FLAG done = FALSE;
    int  i, j;

    if (module == MODULE_RB)
    {   if (getting) // should never happen
        {   bank_withdraw();
        } else
        {   bank_deposit();
        }
        return;
    }

    do
    {   aprintf("You are now carrying %d.%d# of %d#.\n", carrying() / 10, carrying() % 10, st * 10);

        j = 0;
        for (i = 0; i < ITEMS; i++)
        {   j += items[i].here;
        }
        aprintf("On the floor are %d gp, %d sp, %d cp and %d item(s).\n", gp_here, sp_here, cp_here, j);

        aprintf(getting ? "Get from floor:\n" : "Drop to floor:\n");
        avail_options = TRUE;
        if (carrying() > (st * 100) + (items[856].owned * 50))
        {   // assert(!getting);
            letter = getletter("øC¢)opper pieces\nøG¢)old pieces\nøI¢)tems\nøO¢)ptions\nøS¢)ilver pieces\nWhich?",          "CGIOS",  "Copper", "Gold", "Items", "Silver", "",     "", "", "", 'I');
        } else
        {   letter = getletter("øC¢)opper pieces\nøG¢)old pieces\nøI¢)tems\nøO¢)ptions\nøS¢)ilver pieces\nøD¢)one\nWhich?", "CDGIOS", "Copper", "Gold", "Items", "Silver", "Done", "", "", "", 'D');
        }
        avail_options = FALSE;
        switch (letter)
        {
        case 'C':
            if (getting)
            {   i = getnumber("Get how many cp", 0, cp_here);
                cp_here -= i;
                give_cp(i);
            } else
            {   i = getnumber("Drop how many cp", 0, cp);
                pay_cp_only(i);
                cp_here += i;
            }
        acase 'S':
            if (getting)
            {   i = getnumber("Get how many sp", 0, sp_here);
                sp_here -= i;
                give_sp(i);
            } else
            {   i = getnumber("Drop how many sp", 0, sp);
                pay_sp_only(i);
                sp_here += i;
            }
        acase 'G':
            if (getting)
            {   i = getnumber("Get how many gp", 0, gp_here);
                gp_here -= i;
                give_gp(i);
            } else
            {   i = getnumber("Drop how many gp", 0, gp);
                pay_gp_only(i);
                gp_here += i;
            }
        acase 'I':
            if (getting)
            {   for (i = 0; i < ITEMS; i++)
                {   if (items[i].here == 1)
                    {   aprintf
                        (   "%d: %d %s(s)\n",
                            i + 1,
                            items[i].here,
                            items[i].name
                        );
                }   }
                i = getnumber("Get which (ø0¢ for none)", 0, ITEMS) - 1;
                if (i >= 0)
                {   if (items[i].here)
                    {   if (items[i].here == 1)
                        {   j = 1;
                        } else
                        {   j = getnumber("Get how many", 0, items[i].here);
                        }
                        if (j)
                        {   items[i].here -= j;
                            give_multi(i, j);
            }   }   }   }
            else
            {   listitems(TRUE, TRUE, 100, 100);
                i = getnumber("Drop which (ø0¢ for none)", 0, ITEMS) - 1;
                if (i >= 0 && items[i].owned >= 1)
                {   if (!dropanything && !droppable(i))
                    {   aprintf("That item is cursed!\n");
                    } elif (items[i].owned == 1)
                    {   dropitem(i);
                        items[i].here++;
                    } elif (items[i].owned >= 2)
                    {   j = getnumber("Drop how many", 0, items[i].owned);
                        dropitems(i, j);
                        items[i].here += j;
            }   }   }
        acase 'O':
            options();
        acase 'D':
            done = TRUE;
    }   }
    while (!done);
}

EXPORT int getnumber(STRPTR prompt, int min, int max)
{   FLAG randomable;
    int  i,
         value = -1;

    // assert(prompt);
    // assert(min <= max);

    if (max - min < 32768)
        {   randomable = TRUE;
        } else
        {   randomable = FALSE;
        }

    for (;;)
    {   if (randomable)
            {   aprintf("¢%s (ø%d¢-ø%d¢/øR¢andom)?\n", prompt, min, max);
                } else
            {   aprintf("¢%s (ø%d¢-ø%d¢)?\n", prompt, min, max);
                }
                if (min == max)
        {   aprintf(">%d\n", min);
            return min;
        }
        show_output();

        if (max - min <= 7)
        {   if (max - min >= 0) sprintf(specialopt_long[0], "%d", min    );
            if (max - min >= 1) sprintf(specialopt_long[1], "%d", min + 1);
            if (max - min >= 2) sprintf(specialopt_long[2], "%d", min + 2);
            if (max - min >= 3) sprintf(specialopt_long[3], "%d", min + 3);
            if (max - min >= 4) sprintf(specialopt_long[4], "%d", min + 4);
            if (max - min >= 5) sprintf(specialopt_long[5], "%d", min + 5);
            if (max - min >= 6) sprintf(specialopt_long[6], "%d", min + 6);
            if (max - min >= 7) sprintf(specialopt_long[7], "%d", min + 7);
            for (i = 0; i < 8; i++)
            {   strcpy(specialopt_short[i], specialopt_long[i]);
        }   }
                avail_random = TRUE;
        do_opts();
        loop(/* (min <= 9 && max <= 9) ? TRUE : */ FALSE);
                avail_random = FALSE;
        undo_opts();

        if (userinput[0] == EOS)
        {   echomode = 2;
            if (reactable)
            {   aprintf(">%d\n", min);
            } else
            {   aprintf("(%d)\n", min);
            }
            echomode = 0;
            value = min;
        } else
        {   FLAG ok     = TRUE;
            int  length = strlen(userinput);

            echomode = 1; aprintf(">%s\n", userinput); echomode = 0;
            if (randomable && (userinput[0] == 'R' || userinput[0] == 'r') && userinput[1] == EOS)
                        {   value = min + (rand() % (max + 1 - min));
                aprintf("Random number is %d.\n", value);
                enterkey(TRUE);
                        } else
                        {   for (i = 0; i < length; i++)
                {   if (userinput[i] < '0' || userinput[i] > '9')
                    {   ok = FALSE;
                        break; // for speed
                }   }
                if (ok)
                {   value = atoi(userinput);
                    /* if (value == 0)
                    {   value = -1;
                    } */
                }   }   }
        if (value >= min && value <= max)
        {   return value;
        }

        aprintf("ðValid range is %d-%d!\n", min, max);
        enterkey(TRUE);
}   }

EXPORT TEXT getletter(STRPTR prompt, STRPTR allowed, STRPTR opt_0, STRPTR opt_1, STRPTR opt_2, STRPTR opt_3, STRPTR opt_4, STRPTR opt_5, STRPTR opt_6, STRPTR opt_7, TEXT defletter)
{   FLAG randomable;
    TEXT tempstring[80 + 1];
    int  i,
         numopts;

    // assert(prompt);
    // assert(defletter);

    numopts = strlen(allowed);
    if (globalrandomable && numopts >= 2)
        {   randomable = TRUE;
            for (i = 0; i < numopts; i++)
            {   if (allowed[i] == 'R')
                {   randomable = FALSE;
                    break; // for speed
        }   }   }
        else
        {   randomable = FALSE;
        }

    for (;;)
    {   if (reactable || !onekey)
        {   if (defletter)
            {   if (randomable)
                {   aprintf("¢%s (øR¢=Random, ENTER=ø%c¢)?\n", prompt, defletter);
                                } else
                    {   aprintf("¢%s (ENTER=ø%c¢)?\n", prompt, defletter);
                        }       }
            else
            {   if (randomable)
                    {   aprintf("¢%s (øR¢=Random)?\n", prompt);
                                } else
                    {   aprintf("¢%s?\n", prompt);
                }   }   }
        else
        {   if (defletter)
            {   if (randomable)
                    {   aprintf("¢%s (øR¢=Random, ENTER=ø%c¢)? (ENTER not required)\n", prompt, defletter);
                                } else
                    {   aprintf("¢%s (ENTER=ø%c¢)? (ENTER not required)\n", prompt, defletter);
                        }   }
                    else
            {   if (randomable)
                    {   aprintf("¢%s (øR¢=Random)? (ENTER not required)\n", prompt);
                                } else
                    {   aprintf("¢%s? (ENTER not required)\n", prompt);
                }   }   }
        show_output();

        if (opt_0[0]) strcpy(specialopt_long[0], opt_0); else strcpy(specialopt_long[0], "-");
        if (opt_1[0]) strcpy(specialopt_long[1], opt_1); else strcpy(specialopt_long[1], "-");
        if (opt_2[0]) strcpy(specialopt_long[2], opt_2); else strcpy(specialopt_long[2], "-");
        if (opt_3[0]) strcpy(specialopt_long[3], opt_3); else strcpy(specialopt_long[3], "-");
        if (opt_4[0]) strcpy(specialopt_long[4], opt_4); else strcpy(specialopt_long[4], "-");
        if (opt_5[0]) strcpy(specialopt_long[5], opt_5); else strcpy(specialopt_long[5], "-");
        if (opt_6[0]) strcpy(specialopt_long[6], opt_6); else strcpy(specialopt_long[6], "-");
        if (opt_7[0]) strcpy(specialopt_long[7], opt_7); else strcpy(specialopt_long[7], "-");
        do_letters();
                avail_random = randomable;
        do_opts();
        loop(TRUE);
        avail_random = FALSE;
                undo_opts();

        if (userinput[0] == EOS && defletter)
        {   echomode = 2;
            if (reactable)
            {   aprintf(">%c\n", defletter);
            } else
            {   aprintf("(%c)\n", defletter);
            }
            echomode = 0;
            return defletter;
        }
        userinput[0] = toupper(userinput[0]);
        echomode = 1; aprintf(">%c\n", userinput[0]); echomode = 0;

        for (i = 0; i < (int) strlen(allowed); i++)
        {   if (userinput[0] == allowed[i])
            {   return userinput[0];
        }   }
        if
        (   (module == MODULE_RB && (userinput[0] == '&' || userinput[0] == '*'))
      /* || (avail_armour    && userinput[0] == 'A')
         || (avail_cast      && userinput[0] == 'C')
         || (avail_drop      && userinput[0] == 'D')
         || (avail_fight     && userinput[0] == 'F')
         || (avail_get       && userinput[0] == 'G')
         || (avail_hands     && userinput[0] == 'H')
         || (avail_look      && userinput[0] == 'L')
         || (avail_options   && userinput[0] == 'O')
         || (avail_proceed   && userinput[0] == 'P')
         || (avail_autofight && userinput[0] == 'T')
         || (avail_use       && userinput[0] == 'U')
         || (avail_view      && userinput[0] == 'V') */
        )
        {   return userinput[0];
        }

        if (randomable && userinput[0] == 'R' && userinput[1] == EOS)
                {   i = rand() % numopts;
                    aprintf("Random letter is %c.\n", allowed[i]);
            enterkey(TRUE);
            return allowed[i];
                }

        if (userinput[0] != 'Q' || userinput[1] != EOS)
        {   strcpy(tempstring, "Illegal input! Valid inputs are ");
            for (i = 0; i < (int) strlen(allowed); i++)
            {   if (i >= 1)
                {   strcat(tempstring, "/");
                }
                sprintf(&tempstring[strlen(tempstring)], "%c", allowed[i]);
            }
            aprintf("%s.\n", tempstring);
}   }   }

EXPORT TEXT getletterornumber(STRPTR allowed, TEXT defletter)
{   int i;

    for (;;)
    {   loop(FALSE);

        if (userinput[0] == EOS)
        {   globalnumber = 0;
            echomode = 2;
            if (reactable)
            {   aprintf(">%c\n", defletter);
            } else
            {   aprintf("(%c)\n", defletter);
            }
            echomode = 0;
            return defletter;
        } // implied else
        echomode = 1;
        aprintf(">%s\n", userinput);
        echomode = 0;

        userinput[0] = toupper(userinput[0]);
        for (i = 0; i < (int) strlen(allowed); i++)
        {   if (userinput[0] == allowed[i])
            {   return userinput[0];
        }   }
        globalnumber = atoi(userinput);
        return '#';
}   }

EXPORT int getyn(STRPTR prompt)
{   if (getletter(prompt, "YN", "Yes", "No", "", "", "", "", "", "", 'Y') == 'Y')
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT int getspell(STRPTR prompt)
{   int bestmatch =   -1, // initialized to avoid a spurious SAS/C compiler warning
        fuzziness = 1000,
        i;

    for (;;)
    {   aprintf("¢%s?\n", prompt);
        show_output();

        undo_opts();
        loop(FALSE);
        if (userinput[0] == EOS || userinput[0] == '-')
        {   echomode = 2;
            if (reactable)
            {   aprintf(">-\n");
            } else
            {   aprintf("(-)\n");
            }
            aprintf(">-\n");
            echomode = 0;
            return -1;
        } // implied else
        echomode = 1; aprintf(">%s\n", userinput); echomode = 0;
        if (userinput[0] == '?')
        {   listspells(TRUE);
            show_output();
        } else
        {   for (i = 0; i < SPELLS; i++)
            {   if (fuzzystrcmp(userinput, spell[i].corginame) < fuzziness)
                {   fuzziness = fuzzystrcmp(userinput, spell[i].corginame);
                    bestmatch = i;
                }
                if (fuzzystrcmp(userinput, spell[i].fbname   ) < fuzziness)
                {   fuzziness = fuzzystrcmp(userinput, spell[i].fbname);
                    bestmatch = i;
                }
                if (!stricmp(userinput, spell[i].abbrev))
                {   fuzziness = 0;
                    bestmatch = i;
            }   }
            if (fuzziness <= FUZZYTHRESHOLD)
            {   return bestmatch;
            } else
            {   aprintf("No such spell!\n");
                enterkey(TRUE);
}   }   }   }

EXPORT int getmodule(STRPTR prompt)
{   int i;

    for (;;)
    {   aprintf("¢%s?\n", prompt);
        show_output();
                avail_random = TRUE;
        do_opts();
        loop(FALSE);
        avail_random = FALSE;
        undo_opts();

        if (userinput[0] == EOS || userinput[0] == '-')
        {   echomode = 2;
            if (reactable)
            {   aprintf(">-\n");
            } else
            {   aprintf("(-)\n");
            }
            echomode = 0;
            return 0;
        } // implied else
        echomode = 1; aprintf(">%s\n", userinput); echomode = 0;

        DISCARD strupr(userinput);
                if (userinput[0] == 'R' && userinput[1] == EOS)
                {   return 1 + (rand() % (MODULES - 1));
                } // implied else
                for (i = 1; i < MODULES; i++)
        {   if (!stricmp(userinput, moduleinfo[i].name))
            {   return i;
            } elif (fuzzystrcmp(userinput, moduleinfo[i].longname) <= FUZZYTHRESHOLD)
            {   return i;
        }   }

        aprintf("No such adventure!\n");
        enterkey(TRUE);
}   }

EXPORT void endofmodule(void)
{   int i;

    healall_st();
    gain_st(owed_st);
    owed_st = 0;

    gain_iq(owed_iq);
    owed_iq = 0;

    gain_lk(owed_lk);
    owed_lk = 0;

    healall_con();
    gain_con(owed_con);
    owed_con = 0;

    gain_dex(owed_dex);
    owed_dex = 0;

    gain_chr(owed_chr);
    owed_chr = 0;

    gain_spd(owed_spd);
    owed_spd = 0;

    lose_flag_ability(63); // have a bath

    to_cp();
    to_gp();
    healall_st();
    healall_con();

    lose_flag_ability(21);
    lose_flag_ability(38);
    lose_flag_ability(44);
    lose_flag_ability(63);
    lose_flag_ability(66);
    lose_flag_ability(69);
    lose_flag_ability(91);
    lose_flag_ability(92);
    lose_flag_ability(153);

    if (ability[154].known) // failed DT module (DT40)
    {   lose_flag_ability(154);
        lose_chr(5);
    }
    if (ability[155].known) // failed DT module (DT48)
    {   lose_flag_ability(155);
        lose_chr(5);
    }

    for (i = 0; i < ITEMS; i++)
    {   items[i].here = 0;
    }
    cp_here = sp_here = gp_here = 0;

    save_man();
}

EXPORT void changerace(void)
{   st      = st     * races[race].st1  / races[race].st2;
    if (races[race].iq2)
    {   iq  = iq     * races[race].iq1  / races[race].iq2;
    } elif (iq > races[race].iq1)
    {   iq  = races[race].iq1;
    }
    if (races[race].lk2)
    {   lk  = iq     * races[race].lk1  / races[race].lk2;
    } elif (lk > races[race].lk1)
    {   lk  = races[race].lk1;
    }
    con     = con    * races[race].con1 / races[race].con2;
    if (races[race].dex2)
    {   dex = dex    * races[race].dex1 / races[race].dex2;
    } elif (dex > races[race].dex1)
    {   dex = races[race].dex1;
    }
    chr     = chr    * races[race].chr1 / races[race].chr2;
    spd     = spd    * races[race].spd1 / races[race].spd2;

    if (race == GOBLIN)
    {   // ST is ?
        iq = best3of4(); // %%: RB tables say 3d6, GL says best 3 of 4 dice
        lk = dice(4);    // %%: RB tables say 3d6, GL says 4d6
        // CON is ?
        // DEX is 3/2
        chr = dice(2);   // %%: RB tables say (3d6)/2, GL says 2 dice
    }

    if (races[race].ht1 && races[race].ht2)
    {   height = height * races[race].ht1 / races[race].ht2;
    }
    if (races[race].wt1 && races[race].wt2)
    {   weight = weight * races[race].wt1 / races[race].wt2;
    }
    if (weight == 0)
    {   weight = 1;
    }

    learnracespells();
}

MODULE void learnracespells(void)
{   int whichspell;

    for (whichspell = 0; whichspell < SPELLS; whichspell++)
    {   if (race == spell[whichspell].race)
        {   learnspell(whichspell);
    }   }
    // %%: Perhaps we should also "forget" spells which are specific to other races (eg. for when changing race via magical means)
}

/* MODULE int feet_to_range(int feet)
{   if   (feet <=  15) return RANGE_POINTBLANK;
    elif (feet <= 150) return RANGE_NEAR;
    elif (feet <= 300) return RANGE_FAR;
    else               return RANGE_EXTREME;
} */

EXPORT void evil_missileattack(int range, int who)
{   int adds = 0,
        tohit,
        size;

    switch (range)
    {
    case  RANGE_POINTBLANK: tohit = 1;
    acase RANGE_NEAR:       tohit = 2;
    acase RANGE_FAR:        tohit = 3;
    acase RANGE_EXTREME:    tohit = 4;
    adefault:               tohit = 1;
                            aprintf("Illegal range! Please send a bug report to amigansoftware@gmail.com!\n");
    }

    if (height < 24)
    {   size = 4;
    } elif (height < 60)
    {   size = 3;
    } elif (height < 180)
    {   size = 2;
    } else
    {   size = 1;
    }
    tohit *= size;

    if (npc[who].st > 12)
    {   adds += npc[who].st - 12;
    } elif (npc[who].st < 9)
    {   adds -=  9 - npc[who].st;
    }
    if (npc[who].lk > 12)
    {   adds += npc[who].lk - 12;
    } elif (npc[who].lk < 9)
    {   adds -=  9 - npc[who].lk;
    }
    // double DEX adds for missile combat
    if (npc[who].dex > 12)
    {   adds += (npc[who].dex - 12) * 2;
    } elif (npc[who].dex < 9)
    {   adds -= ( 9 - npc[who].dex) * 2;
    }

    aprintf("%s is doing a missile attack with %s...\n", npc[who].name, items[npc[who].rt].name);
    getsavingthrow(FALSE);
    if (madeit(tohit, npc[who].dex))
    {   aprintf
        (   "You are hit by %s's %s (%d dice + %d adds, + %d personal missile adds)!\n",
            npc[who].name,
            items[npc[who].rt].name,
            items[npc[who].rt].dice,
            items[npc[who].rt].adds,
            adds
        );
        evil_attacktotal = dice(items[npc[who].rt].dice);
        if (spell[SPELL_WY].active) // %%: it's ambiguous exactly what "weapon attack die roll" means. We assume it means just the weapon dice, not any adds.
        {   evil_attacktotal /= 3;
        }
        evil_attacktotal += items[npc[who].rt].adds + adds;
        if (evil_attacktotal < 0)
        {   evil_attacktotal = 0;
        }
        good_takehits(evil_attacktotal, TRUE);
    } else
    {   aprintf("%s missed!\n", npc[who].name);
        evil_attacktotal = 0;
}   }

MODULE void flushtext(void)
{   if (curpos)
    {   vanillatext[curpos] = EOS;
        if (logconsole || !reactable)
        {   printf("%s", vanillatext);
        }
        if (echomode == 0)
        {   strcat(vanillascreen, vanillatext);
        }
        if (LogfileHandle)
        {   DISCARD fwrite(vanillatext, curpos, 1, LogfileHandle);
    }   }
    curpos = 0;
}

EXPORT void aprintf(const char* format, ...)
{   TRANSIENT int     i, j,
                      newlength,
                      screenlength;
    TRANSIENT va_list list;
    PERSIST   char    newtext[8192]; // PERSISTent for speed and so as not to blow the stack
    PERSIST   FLAG    inunimp = FALSE;

    // Be aware that this function isn't callable recursively
    // (due to the use of persistent variables).

    if (echomode == 1 && userstring[0])
    {   return;
    }

    va_start(list, format);
    DISCARD vsprintf((char*) newtext, format, list);
    va_end(list);

    if (!rawmode)
    {   i = j = 0;
        for (;;)
        {   switch (newtext[i])
            {
            case  '{':
                newtext[j++] = '§';
            acase '}':
                newtext[j++] = inunimp ? '¿' : '¹';
            acase '[':
                if (showunimp)
                {   inunimp = TRUE;
                    newtext[j++] = '¿';
                } else
                {   do
                    {   i++;
                    } while (newtext[i] != ']'); // not very robust
                }
            acase ']':
                inunimp = FALSE;
                if (showunimp)
                {   newtext[j++] = '¹';
                }
            acase '`': // start of instructions
                if (!instructions && !itemmode)
                {   do
                    {   i++;
                    } while (newtext[i] != '~'); // not very robust
                }
            acase '±': // start of non-item text
                if (itemmode)
                {   do
                    {   i++;
                    } while (newtext[i] != 'ç'); // not very robust
                }
            acase '~': // end of instructions
            case  'ç': // end of non-item text
                ;
            acase EOS:
                newtext[j] = EOS;
                goto DONE;
            adefault:
                newtext[j++] = newtext[i];
            }
            i++;
    }   }

DONE:
    newlength = strlen(newtext);

    if (echomode == 0)
    {   screenlength = strlen(colourscreen);
        if (screenlength + newlength >= 65535) // could happen when eg. autofighting
        {   return;
        } else
        {   strcpy(&colourscreen[screenlength], newtext);
    }   }

    wrappass(newtext, wordwrap);

    if (logconsole)
    {   OC;
    }

    curpos = 0;
    for (i = 0; i < newlength; i++)
    {   switch (newtext[i])
        {
        // Don't cast these colour codes!
        case  '®': flushtext(); setconcolour(TEXTPEN_BLACK      );
        acase '§': flushtext(); setconcolour(TEXTPEN_DARKRED    );
        acase 'ç': flushtext(); setconcolour(TEXTPEN_DARKGREEN  );
        acase '¹': flushtext(); setconcolour(TEXTPEN_BROWN      );
        acase 'Ø': flushtext(); setconcolour(TEXTPEN_DARKBLUE   );
        acase 'Þ': flushtext(); setconcolour(TEXTPEN_DARKPURPLE );
        acase '¿': flushtext(); setconcolour(TEXTPEN_DARKCYAN   );
        acase '¶': flushtext(); setconcolour(TEXTPEN_LIGHTGREY  );
        acase 'þ': flushtext(); setconcolour(TEXTPEN_DARKGREY   );
        acase 'ð': flushtext(); setconcolour(TEXTPEN_PINK       );
        acase '³': flushtext(); setconcolour(TEXTPEN_GREEN      );
        acase 'æ': flushtext(); setconcolour(TEXTPEN_YELLOW     );
        acase '¥': flushtext(); setconcolour(TEXTPEN_BLUE       );
        acase '²': flushtext(); setconcolour(TEXTPEN_PURPLE     );
        acase 'ø': flushtext(); setconcolour(TEXTPEN_CYAN       );
        acase '¢': flushtext(); setconcolour(TEXTPEN_WHITE      );
        acase 'ü': flushtext(); setconcolour(TEXTPEN_BLACKONDARKCYAN);
        acase 'û': flushtext(); setconcolour(TEXTPEN_YELLOWONDARKBLUE);
        acase 'ý': flushtext(); setconcolour(TEXTPEN_BLACKONDARKRED);
        acase LF:
            vanillatext[curpos++] = newtext[i];
            column = 0;
            flushtext();
            row++;
            domore();
        adefault:
            column++;
            vanillatext[curpos++] = newtext[i];
    }   }
    flushtext();

    if (row >= more)
    {   domore();
}   }

EXPORT void listitems(FLAG numbered, FLAG showall, int percent_standard, int percent_treasure)
{   TRANSIENT FLAG found = FALSE;
    TRANSIENT int  cost,
                   i,
                   spaces;
    PERSIST   TEXT tempstring[256 + 1];

    spaces = 1;
    for (i = 0; i < ITEMS; i++)
    {   if (items[i].owned >= 1000)
        {   spaces = 4;
            break;
        } elif (items[i].owned >= 100 && spaces < 3)
        {   spaces = 3;
        } elif (items[i].owned >=  10 && spaces < 2)
        {   spaces = 2;
    }   }

    for (i = 0; i < ITEMS; i++)
    {   if (items[i].module == MODULE_RB)
        {   cost = items[i].cp * percent_standard / 100;
        } else
        {   cost = items[i].cp * percent_treasure / 100;
        }
        if (items[i].owned && (showall || cost))
        {   aprintf("²");
            found = TRUE;

            if (numbered)
            {   sprintf(tempstring, "%3d: ", i + 1);
            } else
            {   tempstring[0] = EOS;
            }

            switch (spaces)
            {
            case  1: sprintf(&tempstring[strlen(tempstring)], "%1d(%c)%s", items[i].owned, getsymbol(i), items[i].name);
            acase 2: sprintf(&tempstring[strlen(tempstring)], "%2d(%c)%s", items[i].owned, getsymbol(i), items[i].name);
            acase 3: sprintf(&tempstring[strlen(tempstring)], "%3d(%c)%s", items[i].owned, getsymbol(i), items[i].name);
            acase 4: sprintf(&tempstring[strlen(tempstring)], "%4d(%c)%s", items[i].owned, getsymbol(i), items[i].name);
            }
            if (items[i].dice || items[i].adds)
            {   sprintf(&tempstring[strlen(tempstring)], " (%d dice + %d adds)", items[i].dice, items[i].adds);
            }
            if (items[i].hits)
            {   sprintf(&tempstring[strlen(tempstring)], " (%d hits)", items[i].hits);
            }
            if (items[i].weight)
            {   sprintf(&tempstring[strlen(tempstring)], " (%d.%d#)", (items[i].owned * items[i].weight) / 10, (items[i].owned * items[i].weight) % 10);
            }
            if (cost || items[i].module == MODULE_RB)
            {   if (cost == 0)
                {   sprintf(&tempstring[strlen(tempstring)], " (%d gp", cost / 100);
                } elif (cost % 10 == 0)
                {   sprintf(&tempstring[strlen(tempstring)], " (%d sp", cost /  10);
                } else
                {   sprintf(&tempstring[strlen(tempstring)], " (%d cp", cost      );
                }
                if (items[i].owned >= 2)
                {   strcat(tempstring, " each)");
                } else
                {   strcat(tempstring, ")");
            }   }
            if (items[i].str || items[i].dex)
            {   sprintf(ENDOF(tempstring), " (ST: %d, DEX: %d)", items[i].str, items[i].dex);
            }
            if (items[i].poisondoses)
            {   sprintf(ENDOF(tempstring), " (%dx ", items[i].poisondoses);
                switch (items[i].poisontype)
                {
                case  CUR: strcat(tempstring, "curare)");
                acase SPI: strcat(tempstring, "spider venom)");
                acase DRA: strcat(tempstring, "dragon's venom)");
                acase JUI: strcat(tempstring, "hellfire juice)");
            }   }
            if (items[i].defcharges)
            {   sprintf(ENDOF(tempstring), " (%d of %d charges)", items[i].charges, items[i].defcharges);
            }

            if (items[i].module != MODULE_RB)
            {   if (items[i].room1 >= 0 && items[i].room1 < 1000)
                {   sprintf(&tempstring[strlen(tempstring)], " (%s%d", moduleinfo[items[i].module].name, items[i].room1);
                    if (items[i].room2 >= 0 && items[i].room2 < 1000)
                    {   sprintf(&tempstring[strlen(tempstring)], "/%d", items[i].room2);
                    }
                    strcat(tempstring, ")");
                } else
                {   // assert(items[i].room2 == -1);
                    sprintf(&tempstring[strlen(tempstring)], " (%s)", moduleinfo[items[i].module].name);
            }   }
            aprintf("%s\n", tempstring);

            if (verbose)
            {   itemmode = TRUE;
                if (items[i].module == MODULE_RB)
                {   if (items[i].room1 != -1)
                    {   aprintf("¹%s\n", rb_weapondesc[items[i].room1]);
                }   }
                else
                {   if (items[i].room1 >= 2000)
                    {   aprintf("¹%s\n", treasures[items[i].module][items[i].room1 - 2000]);
                    } elif (items[i].room1 >= 1000)
                    {   aprintf("¹%s\n", wanders[items[i].module][items[i].room1 - 1000]);
                    } elif (items[i].room1 >= 0)
                    {   aprintf("¹%s\n", descs[items[i].module][items[i].room1]);
                    }
                    if (items[i].room2 >= 2000)
                    {   aprintf("¹%s\n", treasures[items[i].module][items[i].room2 - 2000]);
                    } elif (items[i].room2 >= 1000)
                    {   aprintf("¹%s\n", wanders[items[i].module][items[i].room2 - 1000]);
                    } elif (items[i].room2 >= 0)
                    {   aprintf("¹%s\n", descs[items[i].module][items[i].room2]);
                }   }
                itemmode = FALSE;
    }   }   }

    if (!found)
    {   aprintf("²None\n");
}   }

EXPORT FLAG saved(int throwlevel, int stat)
{   getsavingthrow(TRUE);
    return madeit(throwlevel, stat);
}

EXPORT int lightsource(void)
{   if (module == MODULE_SS && room == 57)
    {   return LIGHT_NONE;
    } elif (ability[0].known || ability[147].known || items[ITEM_DE_PEARL].owned || items[ITEM_NS_HOMUNCULUS].owned || items[946].owned || spell[SPELL_CE].active)
    {   return LIGHT_CE;
    } elif (lt == ITEM_CI_CRYSTAL || rt == ITEM_CI_CRYSTAL || items[896].owned)
    {   return LIGHT_CRYSTAL;
    } elif (lt == LAN || rt == LAN || lt == ITEM_IC_LANTERN || rt == ITEM_IC_LANTERN)
    {   return LIGHT_LANTERN;
    } elif (spell[SPELL_WO].active || spell[SPELL_S1].active || items[845].owned || items[909].owned)
    {   return LIGHT_WO;
    } elif (ability[27].known || items[ITEM_HH_DIRK].owned)
    {   return LIGHT_CRYSTAL;
    } elif (module == MODULE_CI && (room == 35 || room == 39))
    {   return LIGHT_NONE;
    } elif (lt == ITEM_BS_UWTORCH || rt == ITEM_BS_UWTORCH)
    {   return LIGHT_UWTORCH;
    } elif (lt == TOR || rt == TOR || ability[169].known)
    {   return LIGHT_TORCH;
    } else
    {   return LIGHT_NONE;
}   }

EXPORT int makelight(void)
{   FLAG done;
    TEXT letter;

    saylight();

    done = FALSE;
    do
    {   avail_cast  =
        avail_hands = TRUE;
        letter = getletter("øC¢ast/øH¢ands/øD¢one", "CDH", "Done", "", "", "", "", "", "", "", 'D');
        avail_cast  =
        avail_hands = FALSE;
        switch (letter)
        {
        case 'C':
            if (!cast(SPELL_CE, TRUE))
            {   DISCARD cast(SPELL_WO, TRUE);
            }
        acase 'D':
            done = TRUE;
        acase 'H':
            hands();
        // If there are ever, in the future, any light sources that need
        // to be "used" (rather than held in hands or simply carried), we
        // will need to add that as an option.
    }   }
    while (!done);

    return lightsource();
}

MODULE FLAG autogenerate(void)
{   int choice,
        i, j,
        result;

    aprintf(
/* RB */ " ø1¢: Fang the Delectable    (L1 Male   Human    Warrior       )\n" \
/* RB */ " ø2¢: Higley the Westerner   (L2 Male   Human    Warrior       )\n" \
/* RB */ " ø3¢: Myrmar Oldface         (L1 Male   Elf      Wizard        )\n" \
/* RB */ " ø4¢: Rethe Tigerclaw        (L4 Female Elf      Rogue         )\n" \
/* BC */ " ø5¢: BC-Generic             (L1 Male   Human    Warrior       )\n" \
/* -- */ " ø6¢: Thorgon                (L3 Male   Elf      Warrior-Wizard)\n" \
/* SM */ " ø7¢: SM-Generic             (L2 Male   Human    Rogue         )\n" \
/* CT */ " ø8¢: Mingor Diamondfist     (L8 Male   Human    Warrior       )\n" \
/* CT */ " ø9¢: Inram the Wizard       (L9 Male   Human    Wizard        )\n" \
/* CA */ "ø10¢: Sharnalene             (L1 Female Human    Warrior       )\n" \
/* CD */ "ø11¢: Vuissane Testoniere    (L1 Male   Human    Warrior       )\n" \
/* MM */ "ø12¢: Ignatz the Despoiler   (L1 Male   Ogre     Warrior       )\n" \
/* CB */ "ø13¢: Bjorni oso-Medved      (L6 Male   Werebear Warrior-Wizard)\n" \
/* BD */ "ø14¢: Marek the Master Rogue (L8 Male   Human    Rogue         )\n" \
/* -- */ "ø15¢: Random                 (L1 Random Random   Random        )\n\n"
    );
    // "Generic" are as described at http://www.flyingbuffalo.com/bcintro.htm (BC) or SM.
    // Thorgon is one of mine :-)
    // Mingor and Inram are Wandering People from CT.
    // Sharnelene is from CA61.
    // Vuissane is a Wandering Person from CD.
    // Ignatz is an example from MM.
    // Bjorni is from CB (Catacombs of the Bear Cult).
    // Marek (as used for autogenerated characters) is from BD (Black Dragon Tavern).
    // All others are from the T&T Rulebook (RB).
    // We could also do Sith Starrunner (RB170), but we only know his DEX.
    if (!(choice = getnumber("Generate which character (ø0¢ for none)", 0, 15)))
    {   return FALSE;
    }

REDO:
    clear_man();

    height =
    weight =
    age    = 0;

    switch (choice)
    {
    case 1:
        strcpy(name, "Fang");
        level  =  1;
        sex    = MALE;
        race   = HUMAN;
        class  = WARRIOR;
        st     = 13;
        iq     = 16;
        lk     = 10;
        con    = 13;
        dex    =  6;
        chr    = 12;
        spd    = 10; // RB121
        height = 68;
        weight = 1600;
        items[CLO].owned    =
        items[PRO].owned    =   1;
        items[TOR].owned    =  10;
        items[ROP].owned    =  40;
        rt                  = SSB;
        lt                  = BUC;
        set_language(LANG_ELF, 2);
        set_language(LANG_ORC, 2);
    acase 2:
        strcpy(name, "Higley");
        level  =   2;
        sex    = MALE;
        race   = HUMAN;
        class  = WARRIOR;
        st     =  17;
        iq     =  10;
        lk     =  20;
        con    =  15;
        dex    =  16;
        chr    =   9;
        items[SCI].owned =
        items[VIK].owned = 1;
        rt     =
        lt     = EMPTY;
        both   = HEM;
        armour = LEA;
    acase 3:
        strcpy(name, "Myrmar");
        level  = 1;
        sex    = MALE;
        race   = ELF;
        class  = WIZARD;
        st     =  12;
        iq     =  25;
        lk     =  10;
        con    =  10;
        dex    =   9;
        chr    =  10;
        rt     = ORQ;
        armour = QUI;
        givespells();
    acase 4:
        strcpy(name, "Rethe");
        level  = 4;
        sex    = FEMALE;
        race   = ELF;
        class  = ROGUE;
        st     = 26;
        iq     = 24;
        lk     = 17;
        con    = 18;
        dex    = 20;
        chr    = 24;
        rt                    = GLA;
        lt                    = DRK;
        armour                = LEA;
        spell[SPELL_TF].known = TRUE;
    acase 5:
        strcpy(name, "BC-Generic");
        level  =   1; // not actually specified
        sex    = MALE; // not actually specified
        race   = HUMAN; // not actually specified
        class  = WARRIOR;
        st     =
        iq     =
        lk     =
        con    =
        dex    =
        chr    =  12;
        rt     = SCI;
        armour = LEA;
    acase 6:
        strcpy(name, "Thorgon");
        sex    = MALE;
        race   = ELF;
        class  = WARRIORWIZARD;
        height =   69;
        weight = 1050;
        items[HAN].owned =
        items[CRO].owned =
        items[TOW].owned =
        items[CLO].owned =
        items[LAN].owned =
        items[OIL].owned =  1;
        items[QUR].owned =
        items[ROP].owned = 50;
#ifdef SUPERHERO
        level  =   20;
        st     =
        iq     =
        lk     =
        dex    =
        con    =
        chr    =
        spd    = 5001;
        rt     =  347; // Bronze Bodkin
        lt     =  168; // Hopeless Sword
        armour =  368; // Robes of Tuchmi K'nott
        items[358].owned++; // Trollbow
#else
        level  =    3;
        st     =   29;
        iq     =   26;
        lk     =   20;
        dex    =   29;
        con    =   23;
        chr    =   32;
        spd    =   18;
        rt     =
        lt     = EMPTY;
        both   =  DOU;
        armour =  PLA;
#endif
#ifdef HERO
        items[204].owned =    1;
        gp               =  778;
        xp               = 3785;
        moduledone[MODULE_CD] =
        moduledone[MODULE_ND] =
        moduledone[MODULE_SH] = TRUE;
        give(448);          // ruby amulet
        give_multi(449, 8); // 8 red poppies
        give(455);          // Grey Elf cloak
        give(458);          // magic piggy bank
        armour = 459;       // Blue Elf armour
        give(758);          // average diamond
        give(690);          // larger topaz
        rb_givejewels(-1, -1, 1, 5);
#endif
        givespells();
    acase 7:
        strcpy(name, "SM-Generic");
        level  =    2;
        sex    = MALE; // not actually specified
        race   = HUMAN;
        class  = ROGUE;
        st     =   20;
        iq     =   21;
        lk     =   25;
        con    =   26;
        dex    =   22;
        chr    =   22;
        spd    =   23;
        rt     =  BRO;
        lt     =  DRK;
        gp     =   60;
        items[CLO].owned =
        items[PRO].owned = 1;
        // waterskins are not supported
        // no spells are known by this rogue
        // %%: "You can only use one weapon at a time" (SM)...since when!? Compare against RB101, where Rethe is using two weapons.
    acase 8:
        strcpy(name, "Mingor");
        level  =    8;
        sex    = MALE;
        race   = HUMAN; // not actually specified;
        class  = WARRIOR; // not actually specified
        st     =   60;
        iq     =   20;
        lk     =  106;
        con    =   20;
        dex    =   20;
        chr    =   20;
        rt     =  PIL;
        armour =  MAI;
        ability[27].known = 1;
        moduledone[MODULE_DE] = TRUE;
    acase 9:
        strcpy(name, "Inram");
        level  =    9;
        sex    = MALE;
        race   = HUMAN; // not actually specified;
        class  = WIZARD;
        st     =   40;
        iq     =   42;
        lk     =   30;
        con    =    8;
        dex    =   16;
        chr    =   12;
     // rt     =  DEL;
        givespells();
    acase 10:
        strcpy(name, "Sharnalene");
        level  =    1;
        sex    = FEMALE;
        race   = HUMAN;
        class  = WARRIOR;
        st     =   15; // %%: see CA errata/ambiguities
        iq     =   12;
        lk     =   19;
        con    =   25;
        dex    =   22;
        chr    =   12;
        spd    =   12;
        rt     = SAX;
        // %%: she is too weak to wield her grand shamsheer
        armour = LEA;
        height =   74;
        items[SAX].owned =
        items[GRA].owned =
        items[CRA].owned =  1;
        items[QUR].owned = 24; // %%: this isn't stated anywhere
    acase 11:
        strcpy(name, "Vuissane");
        level  =    1;
        sex    = MALE;
        race   = HUMAN;
        class  = WARRIOR;
        st     = 33;
        iq     = 22;
        lk     = 27;
        con    = 24;
        dex    = 35;
        chr    = 27;
        spd    = 12;
        rt     = RAP;
        lt     = DRK;
        both   = EMPTY;
        armour = LAM;
        items[LSB].owned = // light self-bow
        items[DRK].owned = 1;
        items[ARR].owned = 24; // %%: this isn't stated anywhere
    acase 12:
        strcpy(name, "Ignatz");
        level  =    1;
        sex    = MALE;
        race   = OGRE;
        class  = WARRIOR;
        height =  186; // 15' 6"
        weight = 3500; // 350#
        st     =   26;
        iq     =    7;
        lk     =    8;
        con    =   32;
        dex    =    9;
        chr    =  -15;
        rt     =  CLU; // %%: MM says it is worth 6 dice, RB says it is worth 3 dice
    acase 13:
        strcpy(name, "Bjorni");
        level  =  6;
        sex    = MALE;
        race   = WEREBEAR;
        class  = WARRIORWIZARD;
        height = 72; // 6'
        st     = 42;
        iq     = 22;
        lk     = 25;
        con    = 15;
        dex    = 18;
        chr    = 15;
        givespells();
    acase 14:
        strcpy(name, "Marek");
        level  =    8;
        sex    = MALE;
        race   = HUMAN;
        class  = ROGUE;
        height =   71; // 5' 11"
        weight = 1750; // 175#
        st     =   72;
        iq     =   24;
        lk     =   60;
        con    =
        dex    =   48;
        chr    =   16;
        rt     =  RAP;
        lt     =  PON;
        items[PON].owned = 2;
        spell[SPELL_TF].known =
        spell[SPELL_KK].known =
        spell[SPELL_CC].known =
        spell[SPELL_MI].known =
        spell[SPELL_CE].known =
        spell[SPELL_RS].known =
        spell[SPELL_WL].known =
        spell[SPELL_BP].known =
        spell[SPELL_PP].known =
        spell[SPELL_MP].known =
        spell[SPELL_WT].known =
        spell[SPELL_WW].known = TRUE;
    acase 15:
        strcpy(name, "Random");
        level  =  1;
        st  = max_st  = dice(3);
        iq  = dice(3);
        lk  = dice(3);
        con = max_con = dice(3);
        dex = dice(3);
        chr = dice(3);
        spd = dice(3);
        sex = (dice(1) <= 3) ? MALE : FEMALE;
        if (st >= 12 && iq >= 12 && lk >= 12 && dex >= 12 && con >= 12 && chr >= 12)
        {   class = WARRIORWIZARD;
        } else
        {   result = dice(1);
            if (iq >= 10 && dex >= 8)
            {   if (result <= 2) class = WARRIOR; elif (result <= 4) class = ROGUE; else class = WIZARD;
            } else
            {   if (result <= 3) class = WARRIOR; else               class = ROGUE;
        }   }
        if (class == WIZARD)
        {   result = anydice(1, 8);
        } else
        {   result = anydice(1, 7);
        }
        switch (result)
        {
        case  1: race = HUMAN;
        acase 2: race = DWARF;
        acase 3: race = ELF;
        acase 4: race = FAIRY;
        acase 5: race = GOBLIN;
        acase 6: race = WHITEHOBBIT;
        acase 7: race = TROLL;
        acase 8: race = LEPRECHAUN;
        }
        if (class != WARRIOR)
        {   for (i = 0; i < SPELLS; i++)
            {   if (spell[i].level == 1)
                {   spell[i].known = TRUE;
        }   }   }
        gp = dice(3) * 10;
    }

    if (both != EMPTY)
    {   items[both].owned++;
    }
    if (rt != EMPTY)
    {   items[rt].owned++;
    }
    if (lt != EMPTY)
    {   items[lt].owned++;
    }
    if (armour != EMPTY)
    {   items[armour].owned++;
    }

    if (spd == 0)
    {   spd = dice(3);
    }
    if (xp == 0)
    {   xp = apreq[level];
    }
    if (age == 0)
    {   calc_age(); // this does racial languages too
    }
    if (choice == 19)
    {   changerace();
    }
    if (height == 0)
    {   height = heighttable[dice(3) - 3] -   2;
        if (sex == FEMALE)
        {   height -=   2;
        }
        height  = height * races[race].ht1  / races[race].ht2;
    }
    if (weight == 0)
    {   weight = weighttable[dice(3) - 3] - 100;
        if (sex == FEMALE)
        {   weight -= 100;
        }
        weight  = weight * races[race].wt1  / races[race].wt2;
        if (weight == 0)
        {   weight = 1;
    }   }

    max_st  = st;
    max_con = con;

    if (choice != 1 && iq > 12)
    {   for (i = 13; i <= iq; i++)
        {   result = anydice(1, 100);
            for (j = 0; j < LANGUAGES; j++)
            {   if (result <= language[j].freq)
                {   set_language(j, 2);
                    break;
    }   }   }   }
    iq_langs = iq;

    learnracespells();

    gotman = TRUE;

    if (choice == 19 && !getyn("OK"))
    {   goto REDO;
    }

    save_man();

    return TRUE;
}

MODULE void calc_age(void)
{   switch (race)
    {
    case DWARF:
        set_language(LANG_DWARF, 2);
        age    =  dice(3) + 50;
    acase ELF:
    case FAIRY:
        set_language(LANG_ELF, 2);
        age    =  dice(3) + 50;
    acase WHITEHOBBIT:
    case BLACKHOBBIT:
        set_language(LANG_HOBBIT, 2);
        age    =  dice(3) + 30;
    acase TROLL:
        set_language(LANG_TROLL, 2);
        age    =  dice(3) + 10;
    acase LEPRECHAUN:
        set_language(LANG_GREMLIN, 2);
        age    =  dice(3) + 30;
    acase OGRE:
        set_language(LANG_OGRE, 2);
        age    =  dice(3) + 30; // %%: We assume the same aging as for humans.
    acase GOBLIN:
        set_language(LANG_GOBLIN, 2);
        age    =  dice(3) + 30; // %%: We assume the same aging as for humans.
    adefault: // eg. HUMAN
        age    =  dice(3) + 10;
}   }

EXPORT FLAG pay_cp(int bill)
{   if (money >= bill)
    {   to_cp();
        cp -= bill;
        to_gp();
        if (bill % 100)
        {   aprintf("Paid %d cp. You now have %d gp, %d sp, %d cp.\n", bill      , gp, sp, cp);
        } else
        {   aprintf("Paid %d gp. You now have %d gp, %d sp, %d cp.\n", bill / 100, gp, sp, cp);
        }
        return TRUE;
    } else
    {   if (bill % 100)
        {   aprintf("Can't pay %d cp! You only have %d gp, %d sp, %d cp.\n", bill      , gp, sp, cp);
        } else
        {   aprintf("Can't pay %d gp! You only have %d gp, %d sp, %d cp.\n", bill / 100, gp, sp, cp);
        }
        return FALSE;
}   }

EXPORT void to_cp(void)
{   cp = (gp * 100)
       + (sp *  10)
       +  cp;
    sp =
    gp = 0;
}
EXPORT void to_gp(void)
{   gp =  cp / 100;
    sp = (cp % 100) / 10;
    cp =  cp %  10;
}
EXPORT FLAG pay_gp(int bill)
{   return pay_cp(bill * 100);
}

EXPORT FLAG pay_cp_only(int bill)
{   if (cp < bill)
    {   aprintf("Can't pay %d cp as copper pieces! You only have %d cp.\n", bill, cp);
        return FALSE;
    } else
    {   cp -= bill;
        aprintf("Paid/lost %d cp. You now have %d cp.\n", bill, cp);
        return TRUE;
}   }
EXPORT FLAG pay_sp_only(int bill)
{   if (sp < bill)
    {   aprintf("Can't pay %d sp as silver pieces! You only have %d sp.\n", bill, sp);
        return FALSE;
    } else
    {   sp -= bill;
        aprintf("Paid/lost %d sp. You now have %d sp.\n", bill, sp);
        return TRUE;
}   }
EXPORT FLAG pay_gp_only(int bill)
{   if (gp < bill)
    {   aprintf("Can't pay %d gp as gold pieces! You only have %d gp.\n", bill, gp);
        return FALSE;
    } else
    {   gp -= bill;
        aprintf("Paid/lost %d gp. You now have %d gp.\n", bill, gp);
        return TRUE;
}   }

EXPORT void rb_givejewelleditem(int itemtype) // not yet implemented
{   rb_givecoins();
}

EXPORT void gain_numeric_abilities(int which, int howmany)
{   // assert(NUMERICABILITY(which));

    ability[which].known += howmany;
    aprintf("You now have %d %s.\n", ability[which].known, ability[which].text);

    switch (which)
    {
    case 124:
        templose_con(dice(1));
}   }

EXPORT void gain_flag_ability(int which)
{   int result;

    // assert(!NUMERICABILITY(which));

    if
    (   ability[which].known
     || (ability[106].known && (which == 18 || which == 41 || which == 70 || which == 71))
    )
    {   return;
    }

    ability[which].known = 1;
    aprintf("Gained %s.\n", ability[which].text);

    ability[which].st  =
    ability[which].iq  =
    ability[which].lk  =
    ability[which].con =
    ability[which].dex =
    ability[which].chr =
    ability[which].spd = 0;

    switch (which)
    {
    case 15:
        ability[which].dex = -(dex / 2);
    acase 18:
        lt   =
        both = EMPTY;
    acase 87:
        if (module == MODULE_CT)
        {   // assert(room == 160);
            ability[which].dex = -3;
        } // else assert(module == MODULE_WW && room == 153);
        lt   =
        both = EMPTY;
    acase 29:
        ability[which].chr = -3;
    acase 44:
        ability[which].st  = // %%: it doesn't say whether we roll once or twice, we assume once
        ability[which].con = -dice(1);
    acase 47:
        ability[which].chr = -5;
    acase 48:
        ability[which].chr = -(chr - 1);
    acase 49:
        ability[which].st  = -(st  / 2);
        ability[which].iq  = -(iq  / 2);
        ability[which].lk  = -(lk  / 2);
        ability[which].con = -(con / 2);
        ability[which].dex = -(dex / 2);
        ability[which].chr = -(chr / 2);
        ability[which].spd = -(spd / 2);
    acase 50:
        ability[which].st  = -(st  / 2);
    acase 52:
        ability[which].st  =
        ability[which].dex = -3;
    acase 53:
        ability[which].st  = -(st  / 4); // %%: it doesn't say how permanent these are
        ability[which].con = -(con / 4);
    acase 54:
        ability[which].dex = -5;
    acase 55:
        ability[which].chr = -1;
    acase 56:
        ability[which].chr = -dice(1);
    acase 58:
        ability[which].chr = (dice(1) <= 3) ? (-1) : (-2);
    acase 62:
    case 63:
        ability[which].chr = -(chr - 3);
    acase 66:
        ability[which].st  =  2;
        ability[which].iq  = -2;
        ability[which].dex = -2;
    acase 69:
        ability[which].chr = -(chr / 2);
    acase 70:
        rt   =
        both = EMPTY;
        ability[which].dex = -(dex / 2);
    acase 71:
        ability[which].dex = -3;
    acase 80:
        ability[which].known--;
        result = dice(1);
        switch (result)
        {
        case 1:
        case 2:
            gain_flag_ability(139);
        acase 3:
        case 4:
            gain_flag_ability(140);
        acase 5:
            gain_flag_ability(141);
        acase 6:
            gain_flag_ability(124);
        }
    acase 91:
        ability[which].con = -(con / 2);
        ability[which].dex = -(dex / 2);
        ability[which].lk  =   lk  / 2;
    acase 92:
        ability[which].chr = -3;
    acase 123:
        weight *= 3;
        if (max_st < weight / 100)
        {   ability[which].st = (weight / 100) - st;
        }
    acase 124:
        ability[which].iq  = -((iq  / 4) * 3);
        ability[which].dex = -(dex  / 4);
    acase 139:
        ability[which].dex = -(dex /  2);
        ability[which].spd = -(spd / 10);
    acase 140:
        ability[which].dex = -(dex /  4);
    acase 141:
        ability[which].con = -((con / 4) * 3);
    acase 142:
        ability[which].chr = 3;
    acase 147:
        ability[which].dex = 3;
        ability[which].chr = -2;
    acase 148:
        ability[which].chr = -5;
    acase 149:
        ability[which].chr = -3;
    acase 153:
        ability[which].chr = -(chr / 2);
    acase 154: // not 155!
        ability[which].chr = -2;
    acase 156:
        ability[which].st  =
        ability[which].iq  =
        ability[which].lk  =
        ability[which].con =
        ability[which].dex =
        ability[which].chr =
        ability[which].spd = -7;
    acase 160:
        ability[which].dex =
        ability[which].spd = -2;
    acase 161:
        ability[which].lk  = -5;
    acase 162:
        ability[which].st  = -5;
    acase 163:
        ability[which].chr = -(chr / 2);
        ability[which].spd = -5;
    acase 170:
        ability[which].chr = 2;
    }

    if (ability[which].st  > 0) gain_st( ability[which].st ); elif (ability[which].st  < 0) permlose_st( -ability[which].st );
    if (ability[which].iq  > 0) gain_iq( ability[which].iq ); elif (ability[which].iq  < 0)     lose_iq( -ability[which].iq );
    if (ability[which].lk  > 0) gain_lk( ability[which].lk ); elif (ability[which].lk  < 0)     lose_lk( -ability[which].lk );
    if (ability[which].con > 0) gain_con(ability[which].con); elif (ability[which].con < 0) permlose_con(-ability[which].con);
    if (ability[which].dex > 0) gain_dex(ability[which].dex); elif (ability[which].dex < 0)     lose_dex(-ability[which].dex);
    if (ability[which].chr > 0) gain_chr(ability[which].chr); elif (ability[which].chr < 0)     lose_chr(-ability[which].chr);
    if (ability[which].spd > 0) gain_spd(ability[which].spd); elif (ability[which].spd < 0)     lose_spd(-ability[which].spd);
}

EXPORT void lose_numeric_abilities(int which, int howmany)
{   // assert(NUMERICABILITY(which));

    ability[which].known -= howmany;
    aprintf("Lost %d %s.\n", howmany, ability[which].text);
}

EXPORT void lose_flag_ability(int which)
{   // assert(!NUMERICABILITY(which));

    if (!ability[which].known)
    {   return;
    }

    ability[which].known = 0;
    aprintf("Lost %s.\n", ability[which].text);

    if (ability[which].st  > 0) permlose_st( ability[which].st ); elif (ability[which].st  < 0) gain_st( -ability[which].st );
    if (ability[which].iq  > 0)     lose_iq( ability[which].iq ); elif (ability[which].iq  < 0) gain_iq( -ability[which].iq );
    if (ability[which].lk  > 0)     lose_lk( ability[which].lk ); elif (ability[which].lk  < 0) gain_lk( -ability[which].lk );
    if (ability[which].con > 0) permlose_con(ability[which].con); elif (ability[which].con < 0) gain_con(-ability[which].con);
    if (ability[which].dex > 0)     lose_dex(ability[which].dex); elif (ability[which].dex < 0) gain_dex(-ability[which].dex);
    if (ability[which].chr > 0)     lose_chr(ability[which].chr); elif (ability[which].chr < 0) gain_chr(-ability[which].chr);
    if (ability[which].spd > 0)     lose_spd(ability[which].spd); elif (ability[which].spd < 0) gain_spd(-ability[which].spd);

    switch (which)
    {
    acase 123:
        weight /= 3;
}   }

EXPORT void learnspell(int which)
{   if (spell[which].known)
    {   return;
    }

    spell[which].known = TRUE;
    aprintf("Learned %s.\n", spell[which].corginame);
}

EXPORT void elapse(int amount, FLAG healable)
{   int crossed,
        i,
        oldminutes;

    oldminutes = minutes;
    minutes += amount;

    if (amount % ONE_YEAR == 0)
    {   aprintf("%d year%s ha%s elapsed.\n",   amount / ONE_YEAR, (amount / ONE_YEAR == 1) ? "" : "s", (amount / ONE_YEAR == 1) ? "s" : "ve");
    } elif (amount % ONE_DAY == 0)
    {   aprintf("%d day%s ha%s elapsed.\n",    amount / ONE_DAY , (amount / ONE_DAY  == 1) ? "" : "s", (amount / ONE_DAY  == 1) ? "s" : "ve");
    } else
    {   aprintf("%d minute%s ha%s elapsed.\n", amount           , (amount            == 1) ? "" : "s", (amount            == 1) ? "s" : "ve");
    }

    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].active > 0)
        {   spell[i].active -= amount;
            if (spell[i].active <= 0)
            {   aprintf("Your %s spell has expired.\n", spell[i].corginame);
                spell[i].active = 0;
    }   }   }

    crossed = (minutes / 10) - ((minutes - amount) / 10);
    if (crossed)
    {   for (i = 0; i < crossed; i++)
        {   if (healable)
            {   if (healable_dex >= 1)
                {   gain_dex(1);
                    healable_dex--;
                    owed_dex--;
                }
                if (module == MODULE_CD && !cd_inside[room])
                {   if (healable_st >= 1)
                    {   gain_st(1);
                        healable_st--;
                        owed_st--;
                    }
                    if (healable_iq >= 1)
                    {   gain_iq(1);
                        healable_iq--;
                        owed_iq--;
                    }
                    if (healable_con >= 1)
                    {   gain_con(1);
                        healable_con--;
                        owed_con--;
                }   }

                heal_st(1);

                if (items[587].owned)
                {   heal_con(1);
                }
                if (items[818].owned)
                {   heal_con(1);
            }   }

            if (module == MODULE_CD && alarum >= 1)
            {   alarum--;
                if (alarum == 0)
                {   aprintf("The alarum has now been raised!\n");
            }   }

            if (ability[21].known) // bitten by gargoyle
            {   getsavingthrow(TRUE);
                if (!madeit(3, st))
                {   templose_st(misseditby(3, st));
            }   }

            if (ability[124].known)
            {   templose_con(ability[124].known);
    }   }   }

    if (items[184].owned) // only supports one dawn purse
    {   if (oldminutes % ONE_DAY < (6 * 60) && minutes % ONE_DAY >= (6 * 60)) // doesn't support multi-day intervals
        {   give_gp(5);
    }   }

    crossed = (minutes / 10) - (oldminutes / 10);
    if (crossed)
    {   for (i = 0; i < crossed; i++)
        {   if (healable)
            {   if (healable_dex >= 1)
                {   gain_dex(1);
                    healable_dex--;
                    owed_dex--;
                }
                if (module == MODULE_CD && !cd_inside[room])
                {   if (healable_st >= 1)
                    {   gain_st(1);
                        healable_st--;
                        owed_st--;
                    }
                    if (healable_iq >= 1)
                    {   gain_iq(1);
                        healable_iq--;
                        owed_iq--;
                    }
                    if (healable_con >= 1)
                    {   gain_con(1);
                        healable_con--;
                        owed_con--;
                }   }

                heal_st(1);

                if (items[587].owned)
                {   heal_con(1);
                }
                if (items[818].owned)
                {   heal_con(1);
            }   }

            if (module == MODULE_CD && alarum >= 1)
            {   alarum--;
                if (alarum == 0)
                {   aprintf("The alarum has now been raised!\n");
            }   }

            if (ability[21].known) // bitten by gargoyle
            {   getsavingthrow(TRUE);
                if (!madeit(3, st))
                {   templose_st(misseditby(3, st));
            }   }

            if (ability[124].known)
            {   templose_con(ability[124].known);
    }   }   }

    if (module == MODULE_RB)
    {   crossed = (minutes / ONE_DAY) - ((minutes - amount) / ONE_DAY);
        if (crossed)
        {   for (i = 0; i < crossed; i++)
            {   if (healable)
                {   heal_con(1);
    }   }   }   }

    if
    (   (AGENOW >= 200 && (race == DWARF || race == ELF || race == FAIRY))
     || (AGENOW >= 100 && (race == WHITEHOBBIT || race == LEPRECHAUN    ))
     || (AGENOW >=  70 &&  race == HUMAN                                 )
    ) // %%: what about other races?
    {   aprintf("%s has died of old age!\n", name);
        die();
}   }

EXPORT void waitforever(void)
{   if (st < max_st)
    {   elapse((max_st - st) * 10, TRUE);
}   }

EXPORT void owe_st(int amount)
{   st      -= amount;
    max_st  -= amount;
    owed_st += amount;
    aprintf("Semi-permanently lost %d ST. ST is now %d of %d.\n", amount, st, max_st);
    if (st <= 0)
    {   die();
    } else
    {   encumbrance();
}   }
EXPORT void owe_iq(int amount)
{   iq      -= amount;
    owed_iq += amount;
    aprintf("Semi-permanently lost %d IQ. IQ is now %d.\n", amount, iq);
    if (iq <= 0)
    {   die();
}   }
EXPORT void owe_lk(int amount)
{   lk      -= amount;
    owed_lk += amount;
    aprintf("Semi-permanently lost %d LK. LK is now %d.\n", amount, lk);
    if (lk <= 0)
    {   die();
}   }
EXPORT void owe_dex(int amount)
{   dex      -= amount;
    owed_dex += amount;
    aprintf("Semi-permanently lost %d DEX. DEX is now %d.\n", amount, dex);
    if (dex <= 0)
    {   die();
}   }
EXPORT void owe_con(int amount)
{   con      -= amount;
    max_con  -= amount;
    owed_con += amount;
    aprintf("Semi-permanently lost %d CON. CON is now %d of %d.\n", amount, con, max_con);
    if (con <= 0)
    {   die();
}   }
EXPORT void owe_chr(int amount)
{   chr     -= amount;
    owed_chr += amount;
    aprintf("Semi-permanently lost %d CHR. CHR is now %d.\n", amount, chr);
}
EXPORT void owe_spd(int amount)
{   spd      -= amount;
    owed_spd += amount;
    aprintf("Semi-permanently lost %d SPD. SPD is now %d.\n", amount, spd);
    if (spd <= 0)
    {   die();
}   }

EXPORT void options(void)
{   int   choice,
          i, j,
          number1,
          number2;
    FLAG  oldlogconsole;
    TEXT  letter;
    UBYTE oldgfx;

    do
    {   aprintf
        (   "ø 0¢) Done\n" \
            "ø 1¢) Edit character\n" \
            "ø 2¢) Print text\n" \
            "ø 3¢) Check for updates\n" \
            "ø 4¢) View manual\n" \
            "ø 5¢) View artwork\n" \
            "ø 6¢) About T&T\n" \
            "ø 7¢) Dice roller\n" \
            "ø 8¢) Toggle verbose                 (currently o%s)\n" \
            "ø 9¢) Toggle colourfulness           (currently o%s)\n" \
            "ø10¢) Toggle patience                (currently o%s)\n" \
            "ø11¢) Toggle spite damage            (currently o%s)\n" \
            "ø12¢) Toggle encumbrance             (currently o%s)\n" \
            "ø13¢) Toggle weapon/armour min attrs (currently o%s)\n" \
            "ø14¢) Toggle cheat mode              (currently o%s)\n" \
            "ø15¢) Toggle logging to file         (currently o%s)\n" \
            "ø16¢) Toggle logging to console      (currently o%s)\n" \
            "ø17¢) Adjust graphics                (currently %s)\n"  \
            "ø18¢) Toggle unimplemented text      (currently o%s)\n" \
            "ø19¢) Change screen height           (currently %d)\n"  \
            "ø20¢) Change word wrapping           (currently %d)\n"  \
            "ø21¢) Toggle one-key input           (currently o%s)\n" \
            "ø22¢) Toggle automatic dice rolling  (currently o%s)\n" \
            "ø23¢) Toggle ANSI artwork            (currently o%s)\n" \
            "ø24¢) Toggle +10 MR in BC            (currently o%s)\n" \
            "ø25¢) Toggle instructions            (currently o%s)\n" \
            "ø26¢) Toggle berserking              (currently o%s)\n" \
            "ø27¢) Toggle confirm on quit         (currently o%s)\n" \
            "ø28¢) Adjust city selling prices:    (currently %d%%)\n" \
            "ø29¢) Adjust saving throw minimum:   (currently %d)\n",
            verbose      ? "n" : "ff",
            colours      ? "n" : "ff",
            patient      ? "n" : "ff",
            spite        ? "n" : "ff",
            encumber     ? "n" : "ff",
            wpnreq       ? "n" : "ff",
            cheat        ? "n" : "ff",
            logfile      ? "n" : "ff",
            logconsole   ? "n" : "ff",
            (gfx == 2)   ? "all" : ((gfx == 1) ? "some" : "none"),
            showunimp    ? "n" : "ff",
            more,
            wordwrap,
            onekey       ? "n" : "ff",
            autodice     ? "n" : "ff",
            wantansi     ? "n" : "ff",
            plus10mr     ? "n" : "ff",
            instructions ? "n" : "ff",
            berserkable  ? "n" : "ff",
            confirm      ? "n" : "ff",
            percent_sell,
            minsave
        );
            globalrandomable = FALSE;
        choice = getnumber("Which", 0, 29);
            globalrandomable = TRUE;
        switch (choice)
        {
        case 1:
            if (userstring[0] && stricmp(name, "Tester"))
            {   aprintf("ðThis feature is not available in BBS door mode!\n");
                enterkey(TRUE);
            } else edit_man();
        acase 2:
            if (userstring[0])
            {   aprintf("ðThis feature is not available in BBS door mode!\n");
                enterkey(TRUE);
            } else
            {   oldlogconsole = logconsole;
                logconsole = TRUE;
                echomode = 2;
                if (module == MODULE_RB)
                {   aprintf("³Weapons/armour:\n\n");
                    for (i = 0; i < RB_WEAPONDESCS; i++)
                    {   for (j = 0; j < ITEMS; j++)
                        {   if ((items[j].room1 == i /* || items[j].room2 == i */) && items[j].module == MODULE_RB)
                            {   aprintf("²%s\n", items[j].name);
                                aprintf("¹%s\n\n", rb_weapondesc[i]);
                    }   }   }
                    aprintf("³Spells:\n\n²");
                    for (i = 0; i < SPELLS; i++)
                    {   listspell(i, TRUE);
                        aprintf("\n");
                    }
                    aprintf("³Races:\n\n");
                    for (i = 0; i < RACES; i++)
                    {   if (races[i].desc[0])
                        {   aprintf("²%s:\n", races[i].plural);
                            aprintf("¹%s\n\n", races[i].desc);
                }   }   }
                else
                {   aprintf("¢*** %s ***\n\n", moduleinfo[module].longname);
                    if (moduleinfo[module].desc[0])
                    {   aprintf("³Blurb:\n\n");
                        aprintf("¹%s\n\n", moduleinfo[module].desc);
                    }
                    aprintf("³Paragraphs:\n\n");
                    for (i = 0; i < moduleinfo[module].rooms; i++)
                    {   aprintf("§#%d:\n", i);
                        aprintf("¹%s\n\n", descs[module][i]);
                    }
                    if (moduleinfo[module].wanderers)
                    {   aprintf("³Wandering monsters:\n\n");
                        for (i = 0; i < moduleinfo[module].wanderers; i++)
                        {   aprintf("³Wandering Monster %d:\n", i + 1);
                            aprintf("¹%s\n\n", wanders[module][i]);
                    }   }
                    if (moduleinfo[module].treasures)
                    {   aprintf("³Treasures:\n\n");
                        for (i = 0; i < moduleinfo[module].treasures; i++)
                        {   aprintf("³Treasure %d:\n", i + 1);
                            aprintf("¹%s\n\n", treasures[module][i]);
                }   }   }
                aprintf("¢");
                echomode = 0;
                logconsole = oldlogconsole;
            }
        acase 3:
            if (userstring[0])
            {   aprintf("ðThis feature is not available in BBS door mode!\n");
                enterkey(TRUE);
            } else
            {   help_update();
            }
        acase 4:
            if (userstring[0])
            {   aprintf("The manual is in the Library/Game Guides (on Absinthe BBS; other BBSes may differ).\n");
                enterkey(TRUE);
            } else
            {   help_manual();
            }
        acase 5:
            if (ansiable)
            {   for (i = 0; i < ANSISCREENS; i++)
                {   DISCARD showansi(i);
                    enterkey(FALSE);
            }   }
            else
            {   aprintf("ðThis feature is not available because the artwork was not loaded successfully!\n");
                enterkey(TRUE);
            }
        acase 6:
#ifdef AMIGA
            if (AboutWindowPtr)
            {   close_about();
            } else
#endif
            help_about();
        acase 7:
            do
            {   choice = getnumber("0) Done\n1) Normal\n2) DARO\n3) TARO\n4) Play dice\n5) Play poker\nWhich", 0, 5);
                switch (choice)
                {
                case 1:
                    number1 = getnumber("How many dice"    , 1, 9999);
                    number2 = getnumber("Of what type (d#)", 1,  100);
                    DISCARD anydice(number1, number2); // this prints the result
                acase 2:
                    aprintf("Result is %d.\n", daro());
                acase 3:
                    aprintf("Result is %d.\n", taro());
                acase 4:
                    if (userstring[0])
                    {   aprintf("ðThis feature is not available in BBS door mode!\n");
                        enterkey(TRUE);
                    } elif (con <= 1)
                    {   aprintf("You need a living character!\n");
                        enterkey(TRUE);
                    } else
                    {   if (gp == 0) give_gp(100);
                        dt_gamble();
                    }
                acase 5:
                    if (userstring[0])
                    {   aprintf("ðThis feature is not available in BBS door mode!\n");
                        enterkey(TRUE);
                    } elif (con <= 1)
                    {   aprintf("You need a living character!\n");
                        enterkey(TRUE);
                    } else
                    {   if (gp == 0) give_gp(100);
                        ct_poker();
            }   }   }
            while (choice);
        acase  8: verbose  = verbose  ? FALSE : TRUE;
        acase  9: colours  = colours  ? FALSE : TRUE;
        acase 10: patient  = patient  ? FALSE : TRUE;
        acase 11: spite    = spite    ? FALSE : TRUE;
        acase 12: encumber = encumber ? FALSE : TRUE;
        acase 13: wpnreq   = wpnreq   ? FALSE : TRUE;
        acase 14:
            if (userstring[0])
            {   // assert(!cheat);
                aprintf("ðYou must leave this off in BBS door mode!\n");
                enterkey(TRUE);
            } else
            {   cheat = cheat   ? FALSE : TRUE;
            }
        acase 15:
            if (userstring[0])
            {   // assert(!logfile);
                aprintf("ðYou must leave this off in BBS door mode!\n");
                enterkey(TRUE);
            } else
            {   if (logfile)
                {   logfile = FALSE;
                    close_logfile();
                } else
                {   logfile = TRUE;
                    open_logfile();
            }   }
        acase 16:
#ifdef AMIGA
            if
            (   !TextFieldBase
             || userstring[0]
            )
            {   aprintf("ðYou can't toggle this in the current mode!\n");
                enterkey(TRUE);
            } else
#endif
                logconsole = logconsole ? FALSE : TRUE;
        acase 17:
            oldgfx = gfx;
            letter = getletter("øA¢ll/øS¢ome/øN¢one", "ASN", "All", "Some", "None", "", "", "", "", "", 'A');
            switch (letter)
            {
            case 'A':
                gfx = 2;
            acase 'S':
                gfx = 1;
            acase 'N':
                gfx = 0;
            }
            if (gfx < oldgfx)
            {   close_gfx(TRUE);
            } elif (gfx > oldgfx)
            {   open_gfx();
            }
        acase 18:
            showunimp = showunimp ? FALSE : TRUE;
        acase 19:
            more = getnumber("Enter height (0 or 1 to disable)", 0, 255);
            if (more == 1) more = 0;
        acase 20: wordwrap     = getnumber("Enter width (0 to disable)", 0, 255);
        acase 21: onekey       = onekey       ? FALSE : TRUE;
        acase 22: autodice     = autodice     ? FALSE : TRUE;
        acase 23: wantansi     = wantansi     ? FALSE : TRUE;
        acase 24: plus10mr     = plus10mr     ? FALSE : TRUE;
        acase 25: instructions = instructions ? FALSE : TRUE;
        acase 26: berserkable  = berserkable  ? FALSE : TRUE;
        acase 27: confirm      = confirm      ? FALSE : TRUE;
        acase 28: percent_sell = getnumber("Enter new percentage",                     0, 100);
        acase 29: minsave      = getnumber("Enter new minimum"   , userstring[0] ? 4 : 3,   5);
    }   }
    while (choice);
}

EXPORT void dropitems(int which, int howmany)
{   if (howmany > items[which].owned)
    {   howmany = items[which].owned;
    }
    if (howmany == 0)
    {   return;
    }

    // aprintf("Dropped %d %s.\n", howmany, items[which].name);
    aprintf("Destroyed %d %s.\n", howmany, items[which].name);
    items[which].owned -= howmany;
    // items[which].here += howmany;
    checkpoison(which);
    checkhands();
}

MODULE void checkpoison(int which)
{   if (items[which].owned == 0)
    {   items[which].inuse = FALSE;
        items[which].poisondoses = 0;
        items[which].poisontype = EMPTY;
        if (armour == which)
        {   armour = EMPTY;
    }   }
    if
    (   items[which].type == WEAPON_THROWN
     || items[which].type == WEAPON_ARROW
     || items[which].type == WEAPON_QUARREL
     || items[which].type == WEAPON_STONE
     || items[which].type == WEAPON_POWDER
     || items[which].type == WEAPON_DART
    )
    {   if (items[which].poisondoses > items[which].owned)
        {   items[which].poisondoses = items[which].owned;
}   }   }

EXPORT void dropitem(int which)
{   if (items[which].owned == 0)
    {   return;
    }

    aprintf("Dropped %s.\n", items[which].name);
    items[which].owned--;
    // items[which].here++;
    checkpoison(which);
    checkhands();
}

EXPORT void makeclone(int which)
{   npc[which].st      = st;
    npc[which].iq      = iq;
    npc[which].lk      = lk;
    npc[which].con     = con;
    npc[which].dex     = dex;
    npc[which].chr     = chr;
    npc[which].spd     = spd;
    npc[which].level   = level;
    npc[which].rt      = rt;
    npc[which].lt      = lt;
    npc[which].both    = both;
    npc[which].armour  = armour;
    npc[which].skin    = 0;
    npc[which].flags   = CALC_DICE | CALC_ADDS | CALC_AP;
    npc[which].race    = race;
    npc[which].module  = module;
    npc[which].who     = -1;
    sprintf(npc[which].name, "Clone of %s", name);
}

MODULE FLAG import(void)
{   TRANSIENT int   i, j,
                    result,
                    temp;
    TRANSIENT UBYTE IOBuffer[512];
    TRANSIENT FILE* LocalFileHandle /* = NULL */ ;
    PERSIST   TEXT  tempstring[9 + 1];

/* Tunnels & Trolls: Crusaders of Khazan (CROS.?, 22,528 bytes)-----------

where ? is in the range 1..5.
512 bytes per character * 44 characters = 22,528 bytes.
CROS.? files are checksummed; see below.

$00:      Roster number (starting from 0)?
$01..$08: First name (padded with NULs) - 8 chars max.
           The nybbles are reversed.
$09..$0B: $000000
$0C..$13: Last name (padded with NULs) - 8 chars max.
           The nybbles are reversed.
$14..$16: $000000
$17:      ?
$18:      Level
$19:      Race:
           $00 = Human
           $01 = Elf
           $02 = Dwarf
           $03 = Hobbit
$1A:      Class:
           $00 = Warrior
           $01 = Rogue
           $02 = Wizard
$1B:      Sex:
           $00 = Male
           $01 = Female
$1C..$1F: ?
$20..$23: Gold pieces (little-endian)
$24..$27: Silver pieces (little-endian)
$28..$2B: Copper pieces (little-endian)
$2C..$2F: Experience points (little-endian)
$30..$31: Food (little-endian)
$32..$33: Age (little-endian)
$36..$37: Maximum ST
$38..$39: Maximum IQ
$3A..$3B: Maximum LK
$3C..$3D: Maximum CON
$3E..$3F: Maximum DEX
$40..$41: Maximum CHR
$42..$43: Maximum SPD
$44..$45: Current ST
$46..$47: Current IQ
$48..$49: Current LK
$4A..$4B: Current CON
$4C..$4D: Current DEX
$4E..$4F: Current CHR
$50..$51: Current SPD
$52:      ?
$53:      Languages known:
           bit 7: Common
               6: Elvish
               5: Dwarvish
               4: Hobbit
               3: Orcish
               2: Foulspeak
               1: Gobble
               0: Nekros
$54:       bit 7: Primus
               6: Barbar
               5: Elysian
               4: Pteran
               3: Serpentine
               2: Insectoid
               1: Blood Speech
               0: Herdspeak
$55:       bit 7: Ursian
               6: Simian
               5: Low Tongue
               4: unused?
               3: unused?
               2: unused?
               1: unused?
               0: unused?
$56:      Spells known:
           bit 7: Darkest Hour? (must be zero!)
               6: Detect Magic        (L1)
               5: Double Trouble? (must be zero!)
               4: Knock Knock         (L1)
               3: Lock Tight          (L1)
               2: Oh-Go-Away          (L1)
               1: Take That You Fiend (L1)
               0: Teacher             (L1)
$57:       bit 7: Vorpal Blade        (L1)
               6: Will-o-Wisp         (L1)
               5: Arrow Arrow? (must be zero!)
               4: Cateyes             (L2)
               3: Curse You           (L2)
               2: Finagle's Demons    (L2)
               1: Glue-You            (L2)
               0: Hidey Hole          (L2)
$58:       bit 7: Little Feets        (L2)
               6: Omnipotent Eye      (L2)
               5: Poor Baby           (L2)
               4: Whammy              (L2)
               3: Blasting Power      (L3)
               2: Dis-Spell           (L3)
               1: Freeze Pleeze       (L3)
               0: Fly Me              (L3)
$59:       bit 7: Healing Feeling     (L3)
               6: Oh There It Is      (L3)
               5: Slush Yuck          (L3)
               4: Waterspout          (L3)
               3: Curses Foiled       (L4)
               2: Dum Dum             (L4)
               1: Hard Stuff          (L4)
               0: Rock-A-Bye          (L4)
$5A:       bit 7: Smog                (L4)
               6: Too-Bad Toxin       (L4)
               5: Twine Time          (L4)
               4: Upsidaisy           (L4)
               3: Breaker Breaker     (L5)
               2: Double-Double       (L5)
               1: Mind Pox            (L5)
               0: Protective Pentagram (L5)
$5B:       bit 7: Second Sight        (L5)
               6: Thunderbolt         (L5)
               5: Wall of Thorns      (L5)
               4: Wink-Wing           (L5)
               3: Elemental Earth     (L6)
               2: Mirage              (L6)
               1: Wall of Stone       (L6)
               0: Zapparmour          (L6)
$5C:       bit 7: Zappathingum        (L6)
               6: Elemental Air       (L7)
               5: Invisible Wall      (L7)
               4: Wall of Iron        (L7)
               3: Wall of Water       (L7)
               2: Wizard Speech       (L7)
               1: Death Spell #9      (L8)
               0: Elemental Water     (L8)
$5D:       bit 7: Wall of Fire        (L8)
               6: Wall of Ice         (L8)
               5: Elemental Fire      (L9)
               4: Hellbomb Bursts     (L9)
               3: Invisible Fiend     (L10)
               2: Slyway Robbery      (L10)
               1: Born Again          (L11)
               0: unused
$5E..$AF: ?
$B0:      Checksum
           There is a separate checksum for each 256-byte record.
           Stored in inverted format (ie. increasing values in rest of
            file cause decreasing checksum).
           The swapped nybbles (in the character's name) are decrypted
            before doing the checksum.
           Everything (including checksum) must add up to $8C (140).
           Only one byte is used; any overflow is ignored.
           Eg. if adding up the rest of the 256 bytes (swapping name
            nybbles first) gives 612 ($264): first get rid of the high
            byte (ie. modulo 256), so we have 100 ($64). Then to get it to
            add up to 140 ($8C), we would need to add 40 ($28). Therefore,
            the checksum byte must be 40 ($28).
$B1..$1FF: ?

Unknown locations/encodings:
 Portrait
 Inventory
 Hits taken
 Condition
 Date/time (this is probably in a different file) */

    if (userstring[0])
    {   aprintf("ðNot available in BBS door mode!\n");
        enterkey(TRUE);
        return FALSE;
    }

    if (!asl_import())
    {   return FALSE;
    }

    if (!(LocalFileHandle = fopen(ck_filename, "rb")))
    {   aprintf("ðCan't open \"%s\"!\n", ck_filename);
        enterkey(TRUE);
        return FALSE;
    }

    for (i = 0; i < 44; i++)
    {   if (fread(IOBuffer, 512, 1, LocalFileHandle) != 1)
        {   fclose(LocalFileHandle);
            aprintf("ðCan't read from file \"%s\"!\n", ck_filename);
            enterkey(TRUE);
            return FALSE;
        }
        if (IOBuffer[0] == i)
        {   for (j = 0; j < 9; j++)
            {   tempstring[j] = ((IOBuffer[1 + j] & 0x0F) << 4)
                              | ((IOBuffer[1 + j] & 0xF0) >> 4);
                tempstring[9] = EOS;
            }
            aprintf("%d: %s\n", i + 1, tempstring);
    }   }

    result = getnumber("Which character slot (ø0¢ for none)", 0, 44) - 1;
    if (result == -1)
    {   return FALSE;
    }
    if (fseek(LocalFileHandle, result * 512, SEEK_SET) != 0)
    {   fclose(LocalFileHandle);
        aprintf("ðCan't seek into file \"%s\"!\n", ck_filename);
        enterkey(TRUE);
        return FALSE;
    }
    if (fread(IOBuffer, 512, 1, LocalFileHandle) != 1)
    {   fclose(LocalFileHandle);
        aprintf("ðCan't read from file \"%s\"!\n", ck_filename);
        enterkey(TRUE);
        return FALSE;
    }
    fclose(LocalFileHandle);
 // LocalFileHandle = NULL;

    clear_man();

    for (i = 0; i < 9; i++)
    {   name[i] = ((IOBuffer[i + 1] & 0x0F) << 4)
                | ((IOBuffer[i + 1] & 0xF0) >> 4);
    }

    level = IOBuffer[0x18];
    switch (IOBuffer[0x19])
    {
    case 0:
        race = HUMAN;
    acase 1:
        race = ELF;
    acase 2:
        race = DWARF;
    acase 3:
        race = WHITEHOBBIT;
    }
    switch (IOBuffer[0x1A])
    {
    case 0:
        class = WARRIOR;
    acase 1:
        class = ROGUE;
    acase 2:
        class = WIZARD;
    }
    if (IOBuffer[0x1B] == 1)
    {   sex = FEMALE;
    } else
    {   sex = MALE;
    }
    gp =  IOBuffer[0x20]
       + (IOBuffer[0x21] *      256)
       + (IOBuffer[0x22] *    65536)
       + (IOBuffer[0x23] * 16777216);
    sp =  IOBuffer[0x24]
       + (IOBuffer[0x25] *      256)
       + (IOBuffer[0x26] *    65536)
       + (IOBuffer[0x27] * 16777216);
    cp =  IOBuffer[0x28]
       + (IOBuffer[0x29] *      256)
       + (IOBuffer[0x2A] *    65536)
       + (IOBuffer[0x2B] * 16777216);
    xp =  IOBuffer[0x2C]
       + (IOBuffer[0x2D] *      256)
       + (IOBuffer[0x2E] *    65536)
       + (IOBuffer[0x2F] * 16777216);
    temp    =  IOBuffer[0x30]
            + (IOBuffer[0x31] * 256);
    items[PRO].owned = temp;
    age     =  IOBuffer[0x32]
            + (IOBuffer[0x33] * 256);
    max_st  =  IOBuffer[0x36]
            + (IOBuffer[0x37] * 256);
    iq      =  IOBuffer[0x38]
            + (IOBuffer[0x39] * 256);
    lk      =  IOBuffer[0x3A]
            + (IOBuffer[0x3B] * 256);
    dex     =  IOBuffer[0x3C]
            + (IOBuffer[0x3D] * 256);
    max_con =  IOBuffer[0x3E]
            + (IOBuffer[0x3F] * 256);
    chr     =  IOBuffer[0x40]
            + (IOBuffer[0x41] * 256);
    spd     =  IOBuffer[0x42]
            + (IOBuffer[0x43] * 256);
    st  = max_st;
    con = max_con;

    if (IOBuffer[0x53] & 0x80) language[ 0].fluency                                              = 2;
    if (IOBuffer[0x53] & 0x40) language[ 1].fluency                                              = 2;
    if (IOBuffer[0x53] & 0x20) language[ 2].fluency                                              = 2;
    if (IOBuffer[0x53] & 0x10) language[ 5].fluency                                              = 2;
    if (IOBuffer[0x53] & 0x08) language[ 4].fluency                                              = 2;
    if (IOBuffer[0x53] & 0x04) language[ 3].fluency = language[ 8].fluency                       = 2; // Foulspeak = Trollish + Ogrish
    if (IOBuffer[0x53] & 0x02) language[ 9].fluency = language[10].fluency                       = 2; // Gobble    = Goblin   + Hobgoblin + Gremlin
 // if (IOBuffer[0x53] & 0x01) ;                                                                      // Nekros    = Undead, Ghosts, Ghouls
    if (IOBuffer[0x54] & 0x80) language[11].fluency = language[ 6].fluency = language[7].fluency = 2; // Primus    = Dragons, Giants, Demon-types, Elementals
 // if (IOBuffer[0x54] & 0x40) ;                                                                      // Barbar    = Gargoyles, Golems, Gorgons, Harpies, Kelpies, Swamp-Fiends, Toad Warriors
 // if (IOBuffer[0x54] & 0x20) ;                                                                      // Elysian   = Merfolk, Centaurs, Hippogryphs, Gryphs, Sphinx, Lamia/Naga, Minotaurs, Chimera, Hydra, Manticore
    if (IOBuffer[0x54] & 0x10) language[11].fluency = language[16].fluency                       = 2; // Pteran    = All flying beasts
    if (IOBuffer[0x54] & 0x08) language[15].fluency                                              = 2;
 // if (IOBuffer[0x54] & 0x04) ;                                                                      // Insectoid    = Insects, Arachnids
    if (IOBuffer[0x54] & 0x02) language[13].fluency = language[14].fluency                       = 2; // Blood Speech = Canines, Felines
    if (IOBuffer[0x54] & 0x01) language[23].fluency = language[24].fluency                       = 2; // Herdspeak    = Elephants, Pigs, Hippos, Unicorns
    if (IOBuffer[0x55] & 0x80) language[17].fluency                                              = 2;
    if (IOBuffer[0x55] & 0x40) language[20].fluency                                              = 2;
    if (IOBuffer[0x55] & 0x3F) language[26].fluency                                              = 2;

    if (IOBuffer[0x56] & 0x80) spell[SPELL_DH].known = TRUE;
    if (IOBuffer[0x56] & 0x40) spell[SPELL_DM].known = TRUE;
    if (IOBuffer[0x56] & 0x20) spell[SPELL_D1].known = TRUE;
    if (IOBuffer[0x56] & 0x10) spell[SPELL_KK].known = TRUE;
    if (IOBuffer[0x56] & 0x08) spell[SPELL_LT].known = TRUE;
    if (IOBuffer[0x56] & 0x04) spell[SPELL_PA].known = TRUE;
    if (IOBuffer[0x56] & 0x02) spell[SPELL_TF].known = TRUE;
    if (IOBuffer[0x56] & 0x01) spell[SPELL_TE].known = TRUE;
    if (IOBuffer[0x57] & 0x80) spell[SPELL_VB].known = TRUE;
    if (IOBuffer[0x57] & 0x40) spell[SPELL_WO].known = TRUE;
    if (IOBuffer[0x57] & 0x20) spell[SPELL_AR].known = TRUE;
    if (IOBuffer[0x57] & 0x10) spell[SPELL_CE].known = TRUE;
    if (IOBuffer[0x57] & 0x08) spell[SPELL_CY].known = TRUE;
    if (IOBuffer[0x57] & 0x04) spell[SPELL_FD].known = TRUE;
    if (IOBuffer[0x57] & 0x02) spell[SPELL_DE].known = TRUE;
    if (IOBuffer[0x57] & 0x01) spell[SPELL_CC].known = TRUE;
    if (IOBuffer[0x58] & 0x80) spell[SPELL_SF].known = TRUE;
    if (IOBuffer[0x58] & 0x40) spell[SPELL_OE].known = TRUE;
    if (IOBuffer[0x58] & 0x20) spell[SPELL_RS].known = TRUE;
    if (IOBuffer[0x58] & 0x10) spell[SPELL_EH].known = TRUE;
    if (IOBuffer[0x58] & 0x08) spell[SPELL_BP].known = TRUE;
    if (IOBuffer[0x58] & 0x04) spell[SPELL_DS].known = TRUE;
    if (IOBuffer[0x58] & 0x02) spell[SPELL_IF].known = TRUE;
    if (IOBuffer[0x58] & 0x01) spell[SPELL_WI].known = TRUE;
    if (IOBuffer[0x59] & 0x80) spell[SPELL_HF].known = TRUE;
    if (IOBuffer[0x59] & 0x40) spell[SPELL_RE].known = TRUE;
    if (IOBuffer[0x59] & 0x20) spell[SPELL_BM].known = TRUE;
    if (IOBuffer[0x59] & 0x10) spell[SPELL_W6].known = TRUE;
    if (IOBuffer[0x59] & 0x08) spell[SPELL_CF].known = TRUE;
    if (IOBuffer[0x59] & 0x04) spell[SPELL_WL].known = TRUE;
    if (IOBuffer[0x59] & 0x02) spell[SPELL_HA].known = TRUE;
    if (IOBuffer[0x59] & 0x01) spell[SPELL_DW].known = TRUE;
    if (IOBuffer[0x5A] & 0x80) spell[SPELL_SG].known = TRUE;
    if (IOBuffer[0x5A] & 0x40) spell[SPELL_TT].known = TRUE;
    if (IOBuffer[0x5A] & 0x20) spell[SPELL_T1].known = TRUE;
    if (IOBuffer[0x5A] & 0x10) spell[SPELL_UP].known = TRUE;
    if (IOBuffer[0x5A] & 0x08) spell[SPELL_FR].known = TRUE;
    if (IOBuffer[0x5A] & 0x04) spell[SPELL_DD].known = TRUE;
    if (IOBuffer[0x5A] & 0x02) spell[SPELL_MP].known = TRUE;
    if (IOBuffer[0x5A] & 0x01) spell[SPELL_PP].known = TRUE;
    if (IOBuffer[0x5B] & 0x80) spell[SPELL_SE].known = TRUE;
    if (IOBuffer[0x5B] & 0x40) spell[SPELL_T2].known = TRUE;
    if (IOBuffer[0x5B] & 0x20) spell[SPELL_WT].known = TRUE;
    if (IOBuffer[0x5B] & 0x10) spell[SPELL_WG].known = TRUE;
    if (IOBuffer[0x5B] & 0x08) spell[SPELL_E1].known = TRUE;
    if (IOBuffer[0x5B] & 0x04) spell[SPELL_MI].known = TRUE;
    if (IOBuffer[0x5B] & 0x02) spell[SPELL_WS].known = TRUE;
    if (IOBuffer[0x5B] & 0x01) spell[SPELL_ZP].known = TRUE;
    if (IOBuffer[0x5C] & 0x80) spell[SPELL_ZA].known = TRUE;
    if (IOBuffer[0x5C] & 0x40) spell[SPELL_E2].known = TRUE;
    if (IOBuffer[0x5C] & 0x20) spell[SPELL_IW].known = TRUE;
    if (IOBuffer[0x5C] & 0x10) spell[SPELL_WN].known = TRUE;
    if (IOBuffer[0x5C] & 0x08) spell[SPELL_W3].known = TRUE;
    if (IOBuffer[0x5C] & 0x04) spell[SPELL_WZ].known = TRUE;
    if (IOBuffer[0x5C] & 0x02) spell[SPELL_D9].known = TRUE;
    if (IOBuffer[0x5C] & 0x01) spell[SPELL_EW].known = TRUE;
    if (IOBuffer[0x5D] & 0x80) spell[SPELL_WF].known = TRUE;
    if (IOBuffer[0x5D] & 0x40) spell[SPELL_WA].known = TRUE;
    if (IOBuffer[0x5D] & 0x20) spell[SPELL_E3].known = TRUE;
    if (IOBuffer[0x5D] & 0x10) spell[SPELL_HB].known = TRUE;
    if (IOBuffer[0x5D] & 0x08) spell[SPELL_IN].known = TRUE;
    if (IOBuffer[0x5D] & 0x04) spell[SPELL_SR].known = TRUE;
    if (IOBuffer[0x5D] & 0x02) spell[SPELL_BA].known = TRUE;

    height = heighttable[dice(3) - 3];
    weight = weighttable[dice(3) - 3];
    if (sex == FEMALE)
    {   height -=   2;
        weight -= 100;
    }
    if (races[race].ht1 && races[race].ht2)
    {   height = height * races[race].ht1 / races[race].ht2;
    }
    if (races[race].wt1 && races[race].wt2)
    {   weight = weight * races[race].wt1 / races[race].wt2;
    }
    if (weight == 0)
    {   weight = 1;
    }

    gotman = TRUE;
    save_man();

    return TRUE;
}

/* MODULE FLAG export(void)
{   TRANSIENT UBYTE IOBuffer[512],
                    t;
    TRANSIENT int   i,
                    result;
    TRANSIENT FILE* LocalFileHandle;
    PERSIST   TEXT  filename[MAX_PATH + 1];

    result = getnumber("Which file number (ø0¢ for none)", 0, 5);
    if (result == 0)
    {   return FALSE;
    }
    sprintf(filename, "CROS.%d", result);
    result = getnumber("Which character slot (ø0¢ for none)", 0, 44) - 1;
    if (result == -1)
    {   return FALSE;
    }

    for (i = 0; i < 512; i++)
    {   IOBuffer[i] = 0;
    }

    IOBuffer[0] = result;
    for (i = 0; i < 9; i++)
    {   IOBuffer[1 + i] = name[i];
    }

    IOBuffer[0x18] = level;
    switch (race)
    {
    case ELF:
    case DARKELF:
    case SYLVANELF:
    case HALFELF:
        IOBuffer[0x19] = 1;
    acase DWARF:
        IOBuffer[0x19] = 2;
    acase WHITEHOBBIT:
    case BLACKHOBBIT:
        IOBuffer[0x19] = 3;
    adefault:
        IOBuffer[0x19] = 0; // human
    }
    switch (class)
    {
    case WARRIOR:
        IOBuffer[0x1A] = 0;
    acase ROGUE:
    case WARRIORWIZARD:
        IOBuffer[0x1A] = 1;
    acase WIZARD:
        IOBuffer[0x1A] = 2;
    }
    IOBuffer[0x1B] = ((sex == FEMALE) ? 1 : 0);

    IOBuffer[0x23] = (gp / 16777216);
    IOBuffer[0x22] = (gp % 16777216) / 65536;
    IOBuffer[0x21] = (gp %    65536) /   256;
    IOBuffer[0x20] = (gp %      256);
    IOBuffer[0x27] = (sp / 16777216);
    IOBuffer[0x26] = (sp % 16777216) / 65536;
    IOBuffer[0x25] = (sp %    65536) /   256;
    IOBuffer[0x24] = (sp %      256);
    IOBuffer[0x2B] = (cp / 16777216);
    IOBuffer[0x2A] = (cp % 16777216) / 65536;
    IOBuffer[0x29] = (cp %    65536) /   256;
    IOBuffer[0x28] = (cp %      256);
    IOBuffer[0x2F] = (xp / 16777216);
    IOBuffer[0x2E] = (xp % 16777216) / 65536;
    IOBuffer[0x2D] = (xp %    65536) /   256;
    IOBuffer[0x2C] = (xp %      256);

    IOBuffer[0x30] = items[PRO].owned % 256;
    IOBuffer[0x31] = items[PRO].owned / 256;
    IOBuffer[0x32] = age              % 256;
    IOBuffer[0x33] = age              / 256;
    IOBuffer[0x36] = max_st           % 256;
    IOBuffer[0x37] = max_st           / 256;
    IOBuffer[0x38] = iq               % 256;
    IOBuffer[0x39] = iq               / 256;
    IOBuffer[0x3A] = lk               % 256;
    IOBuffer[0x3B] = lk               / 256;
    IOBuffer[0x3C] = max_con          % 256;
    IOBuffer[0x3D] = max_con          / 256;
    IOBuffer[0x3E] = dex              % 256;
    IOBuffer[0x3F] = dex              / 256;
    IOBuffer[0x40] = chr              % 256;
    IOBuffer[0x41] = chr              / 256;
    IOBuffer[0x42] = spd              % 256;
    IOBuffer[0x43] = spd              / 256;
    IOBuffer[0x44] = st               % 256;
    IOBuffer[0x45] = st               / 256;
    IOBuffer[0x46] = iq               % 256;
    IOBuffer[0x47] = iq               / 256;
    IOBuffer[0x48] = lk               % 256;
    IOBuffer[0x49] = lk               / 256;
    IOBuffer[0x4A] = con              % 256;
    IOBuffer[0x4B] = con              / 256;
    IOBuffer[0x4C] = dex              % 256;
    IOBuffer[0x4D] = dex              / 256;
    IOBuffer[0x4E] = chr              % 256;
    IOBuffer[0x4F] = chr              / 256;
    IOBuffer[0x50] = spd              % 256;
    IOBuffer[0x51] = spd              / 256;

                                                                             IOBuffer[0x53] =  0; // needed to avoid a SAS/C warning
    if (language[ 0].fluency                                               ) IOBuffer[0x53] |= 0x80;
    if (language[ 1].fluency                                               ) IOBuffer[0x53] |= 0x40;
    if (language[ 2].fluency                                               ) IOBuffer[0x53] |= 0x20;
    if (language[ 5].fluency                                               ) IOBuffer[0x53] |= 0x10;
    if (language[ 4].fluency                                               ) IOBuffer[0x53] |= 0x08;
    if (language[ 3].fluency || language[ 8].fluency                       ) IOBuffer[0x53] |= 0x04; // Foulspeak
    if (language[ 9].fluency || language[10].fluency                       ) IOBuffer[0x53] |= 0x02; // Gobble
                                                                             IOBuffer[0x54] =  0; // needed to avoid a SAS/C warning
    if (language[11].fluency || language[ 6].fluency || language[7].fluency) IOBuffer[0x54] |= 0x80; // Primus
    if (language[11].fluency || language[16].fluency                       ) IOBuffer[0x54] |= 0x10; // Pteran
    if (language[15].fluency                                               ) IOBuffer[0x54] |= 0x08;
    if (language[13].fluency || language[14].fluency                       ) IOBuffer[0x54] |= 0x02; // Blood Speech
    if (language[23].fluency || language[24].fluency                       ) IOBuffer[0x54] |= 0x01; // Herdspeak
                                                                             IOBuffer[0x55] =  0; // needed to avoid a SAS/C warning
    if (language[17].fluency                                               ) IOBuffer[0x55] |= 0x80;
    if (language[20].fluency                                               ) IOBuffer[0x55] |= 0x40;
    if (language[26].fluency                                               ) IOBuffer[0x55] |= 0x3F;

                               IOBuffer[0x56] =  0; // needed to avoid a SAS/C warning
 // if (spell[SPELL_DH].known) IOBuffer[0x56] |= 0x80; // must be zero!
    if (spell[SPELL_DM].known) IOBuffer[0x56] |= 0x40;
 // if (spell[SPELL_D1].known) IOBuffer[0x56] |= 0x20; // must be zero!
    if (spell[SPELL_KK].known) IOBuffer[0x56] |= 0x10;
    if (spell[SPELL_LT].known) IOBuffer[0x56] |= 0x08;
    if (spell[SPELL_PA].known) IOBuffer[0x56] |= 0x04;
    if (spell[SPELL_TF].known) IOBuffer[0x56] |= 0x02;
    if (spell[SPELL_TE].known) IOBuffer[0x56] |= 0x01;
                               IOBuffer[0x57] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_VB].known) IOBuffer[0x57] |= 0x80;
    if (spell[SPELL_WO].known) IOBuffer[0x57] |= 0x40;
 // if (spell[SPELL_AR].known) IOBuffer[0x57] |= 0x20; // must be zero!
    if (spell[SPELL_CE].known) IOBuffer[0x57] |= 0x10;
    if (spell[SPELL_CY].known) IOBuffer[0x57] |= 0x08;
    if (spell[SPELL_FD].known) IOBuffer[0x57] |= 0x04;
    if (spell[SPELL_DE].known) IOBuffer[0x57] |= 0x02;
    if (spell[SPELL_CC].known) IOBuffer[0x57] |= 0x01;
                               IOBuffer[0x58] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_SF].known) IOBuffer[0x58] |= 0x80;
    if (spell[SPELL_OE].known) IOBuffer[0x58] |= 0x40;
    if (spell[SPELL_RS].known) IOBuffer[0x58] |= 0x20;
    if (spell[SPELL_EH].known) IOBuffer[0x58] |= 0x10;
    if (spell[SPELL_BP].known) IOBuffer[0x58] |= 0x08;
    if (spell[SPELL_DS].known) IOBuffer[0x58] |= 0x04;
    if (spell[SPELL_IF].known) IOBuffer[0x58] |= 0x02;
    if (spell[SPELL_WI].known) IOBuffer[0x58] |= 0x01;
                               IOBuffer[0x59] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_HF].known) IOBuffer[0x59] |= 0x80;
    if (spell[SPELL_RE].known) IOBuffer[0x59] |= 0x40;
    if (spell[SPELL_BM].known) IOBuffer[0x59] |= 0x20;
    if (spell[SPELL_W6].known) IOBuffer[0x59] |= 0x10;
    if (spell[SPELL_CF].known) IOBuffer[0x59] |= 0x08;
    if (spell[SPELL_WL].known) IOBuffer[0x59] |= 0x04;
    if (spell[SPELL_HA].known) IOBuffer[0x59] |= 0x02;
    if (spell[SPELL_DW].known) IOBuffer[0x59] |= 0x01;
                               IOBuffer[0x5A] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_SG].known) IOBuffer[0x5A] |= 0x80;
    if (spell[SPELL_TT].known) IOBuffer[0x5A] |= 0x40;
    if (spell[SPELL_T1].known) IOBuffer[0x5A] |= 0x20;
    if (spell[SPELL_UP].known) IOBuffer[0x5A] |= 0x10;
    if (spell[SPELL_FR].known) IOBuffer[0x5A] |= 0x08;
    if (spell[SPELL_DD].known) IOBuffer[0x5A] |= 0x04;
    if (spell[SPELL_MP].known) IOBuffer[0x5A] |= 0x02;
    if (spell[SPELL_PP].known) IOBuffer[0x5A] |= 0x01;
                               IOBuffer[0x5B] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_SE].known) IOBuffer[0x5B] |= 0x80;
    if (spell[SPELL_T2].known) IOBuffer[0x5B] |= 0x40;
    if (spell[SPELL_WT].known) IOBuffer[0x5B] |= 0x20;
    if (spell[SPELL_WG].known) IOBuffer[0x5B] |= 0x10;
    if (spell[SPELL_E1].known) IOBuffer[0x5B] |= 0x08;
    if (spell[SPELL_MI].known) IOBuffer[0x5B] |= 0x04;
    if (spell[SPELL_WS].known) IOBuffer[0x5B] |= 0x02;
    if (spell[SPELL_ZP].known) IOBuffer[0x5B] |= 0x01;
                               IOBuffer[0x5C] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_ZA].known) IOBuffer[0x5C] |= 0x80;
    if (spell[SPELL_E2].known) IOBuffer[0x5C] |= 0x40;
    if (spell[SPELL_IW].known) IOBuffer[0x5C] |= 0x20;
    if (spell[SPELL_WN].known) IOBuffer[0x5C] |= 0x10;
    if (spell[SPELL_W3].known) IOBuffer[0x5C] |= 0x08;
    if (spell[SPELL_WZ].known) IOBuffer[0x5C] |= 0x04;
    if (spell[SPELL_D9].known) IOBuffer[0x5C] |= 0x02;
    if (spell[SPELL_EW].known) IOBuffer[0x5C] |= 0x01;
                               IOBuffer[0x5D] =  0; // needed to avoid a SAS/C warning
    if (spell[SPELL_WF].known) IOBuffer[0x5D] |= 0x80;
    if (spell[SPELL_WA].known) IOBuffer[0x5D] |= 0x40;
    if (spell[SPELL_E3].known) IOBuffer[0x5D] |= 0x20;
    if (spell[SPELL_HB].known) IOBuffer[0x5D] |= 0x10;
    if (spell[SPELL_IN].known) IOBuffer[0x5D] |= 0x08;
    if (spell[SPELL_SR].known) IOBuffer[0x5D] |= 0x04;
    if (spell[SPELL_BA].known) IOBuffer[0x5D] |= 0x02;

    t = 0;
    for (i = 0; i < 256; i++)
    {   t += IOBuffer[i]; // overflow is OK
    }
    if (t == 140)
    {   t = 0;
    } elif (t < 140)
    {   t = (140 - t);
    } else
    {   // assert(t > 140);
        t = (396 - t);
    }
    IOBuffer[0xB0] = t;

    for (i = 0; i < 9; i++)
    {   IOBuffer[1 + i] = ((name[i] & 0x0F) << 4)
                        | ((name[i] & 0xF0) >> 4);
    }

    if (!(LocalFileHandle = fopen(filename, "r+b")))
    {   aprintf("ðCan't open \"%s\"!\n", filename);
        enterkey(TRUE);
        return FALSE;
    }
    if (fseek(LocalFileHandle, result * 512, SEEK_SET) != 0)
    {   fclose(LocalFileHandle);
        aprintf("ðCan't seek into file \"%s\"!\n", filename);
        enterkey(TRUE);
        return FALSE;
    }
    if (fwrite(IOBuffer, 512, 1, LocalFileHandle) != 1)
    {   fclose(LocalFileHandle);
        aprintf("ðCan't write to file \"%s\"!\n", filename);
        enterkey(TRUE);
        return FALSE;
    }
    fclose(LocalFileHandle);

    return TRUE;
} */

EXPORT void npc_templose_hp(int which, int amount)
{   if (npc[which].mr)
    {   npc[which].mr -= amount;
        aprintf("%s lost %d MR.\n", npc[which].name, amount);
        if (npc[which].mr <= 0)
        {   kill_npc(which);
    }   }
    elif (npc[which].con)
    {   npc[which].con -= amount;
        aprintf("%s temporarily lost %d CON.\n", npc[which].name, amount);
        if (npc[which].con <= 0)
        {   kill_npc(which);
}   }   }
EXPORT void npc_permlose_hp(int which, int amount)
{   if (npc[which].mr)
    {   npc[which].mr -= amount;
        aprintf("%s lost %d MR.\n", npc[which].name, amount);
        // We don't have a concept of (ie. we don't maintain a distinction between) maximum vs. current MR.
        if (npc[which].mr <= 0)
        {   kill_npc(which);
    }   }
    elif (npc[which].con)
    {   npc[which].con -= amount;
        npc[which].max_con -= amount;
        aprintf("%s permanently lost %d CON.\n", npc[which].name, amount);
        if (npc[which].con <= 0)
        {   kill_npc(which);
}   }   }

EXPORT void npc_templose_st(int which, int amount)
{   npc[which].st -= amount;
    aprintf("%s temporarily lost %d ST.\n", npc[which].name, amount);
    if (npc[which].st <= 0)
    {   kill_npc(which);
}   }
EXPORT void npc_permlose_st(int which, int amount)
{   npc[which].st -= amount;
    npc[which].max_st -= amount;
    aprintf("%s permanently lost %d ST.\n", npc[which].name, amount);
    if (npc[which].st <= 0)
    {   kill_npc(which);
}   }
EXPORT void npc_lose_iq(int which, int amount)
{   npc[which].iq -= amount;
    aprintf("%s lost %d IQ.\n", npc[which].name, amount);
    if (npc[which].iq <= 0)
    {   kill_npc(which);
}   }
EXPORT void npc_lose_lk(int which, int amount)
{   npc[which].lk -= amount;
    aprintf("%s lost %d IQ.\n", npc[which].name, amount);
    if (npc[which].lk <= 0)
    {   kill_npc(which);
}   }
EXPORT void npc_lose_dex(int which, int amount)
{   npc[which].dex -= amount;
    aprintf("%s lost %d DEX.\n", npc[which].name, amount);
    if (npc[which].dex <= 0)
    {   kill_npc(which);
}   }
EXPORT void npc_lose_chr(int which, int amount)
{   npc[which].chr -= amount;
    aprintf("%s lost %d CHR.\n", npc[which].name, amount);
}
EXPORT void npc_lose_spd(int which, int amount)
{   npc[which].spd -= amount;
    aprintf("%s lost %d SPD.\n", npc[which].name, amount);
    if (npc[which].spd <= 0)
    {   kill_npc(which);
}   }

EXPORT int best3of4(void)
{   int result1,
        result2,
        result3,
        result4;

    result1 = dice(1);
    result2 = dice(1);
    result3 = dice(1);
    result4 = dice(1);

    if     (result1 <= result2 && result1 <= result3 && result1 <= result4)
    {   return result2 + result3 + result4;
    } elif (result2 <= result1 && result2 <= result3 && result2 <= result4)
    {   return result1 + result3 + result4;
    } elif (result3 <= result1 && result3 <= result2 && result3 <= result4)
    {   return result1 + result2 + result4;
    } else
    {   return result1 + result2 + result3;
}   }

MODULE void module_loop(FLAG between)
{   int    numexits,
           i,
           newroom,
           tempmodule,
           temproom;
    TEXT   letter,
           theprompt[160 + 1];
    STRPTR allowed;

    numexits = 0;
        if (module != MODULE_RB)
        {   for (i = 0; i < EXITS; i++)
        {   if (exits[(room * EXITS) + i] != -1)
            {   numexits++;
            } else
                {   break; // for speed
        }   }   }

    if (between)
    {   // assert(patient);
        newroom = room;
        room = oldroom;
        aprintf("You are going to paragraph §%d¢.\n", newroom);
        if (moduleinfo[module].castable)
        {   sprintf(theprompt, "øA¢rmour/øC¢ast/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øP¢roceed/øU¢se/øV¢iew/§%d¢", newroom);
        } else
        {   sprintf(theprompt, "øA¢rmour/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øP¢roceed/øU¢se/øV¢iew/§%d¢", newroom);
    }   }
    else
    {   if (moduleinfo[module].castable)
        {   if (numexits >= 2)
                {   strcpy(theprompt, "øA¢rmour/øC¢ast/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øR¢andom/øU¢se/øV¢iew");
                        } else
                {   strcpy(theprompt, "øA¢rmour/øC¢ast/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øU¢se/øV¢iew");
                }   }
            else
        {   if (numexits >= 2)
                {   strcpy(theprompt, "øA¢rmour/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øR¢andom/øU¢se/øV¢iew");
                        } else
                {   strcpy(theprompt, "øA¢rmour/øD¢rop/øG¢et/øH¢ands/øL¢ook/øO¢ptions/øU¢se/øV¢iew");
                }       }
        for (i = 0; i < EXITS; i++)
        {   if (exits[(room * EXITS) + i] != -1)
            {   sprintf
                (   ENDOF(theprompt),
                    "/§%d¢",
                    exits[(room * EXITS) + i]
                );
    }   }   }

    aprintf("¢%s?\n", theprompt);
    show_output();

    for (;;)
    {   if (between)
        {   if (moduleinfo[module].castable)
            {   allowed = "ACDGHLOPUV";
            } else
            {   allowed = "ADGHLOPUV";
            }
            avail_proceed = TRUE;
            sprintf(specialopt_long[0], "%d", newroom);
            strcpy(specialopt_short[0], specialopt_long[0]);
            for (i = 1; i < 8; i++)
            {   strcpy(specialopt_long[i],  "-");
        }   }
        else
        {   for (i = 0; i < EXITS; i++)
            {   if (module != MODULE_RB && exits[(room * EXITS) + i] != -1)
                {   sprintf(specialopt_long[i], "%d", exits[(room * EXITS) + i]);
                    strcpy(specialopt_short[i], specialopt_long[i]);
                } else
                {   strcpy(specialopt_long[i], "-");
            }   }
                        if (moduleinfo[module].castable)
            {   if (numexits >= 2)
                            {   allowed = "ACDGHLORUV";
                                } else
                            {   allowed = "ACDGHLOUV";
                        }   }
                        else
            {   if (numexits >= 2)
                            {   allowed = "ADGHLORUV";
                                } else
                            {   allowed = "ADGHLOUV";
                }   }   }

        enable_items(TRUE);
        avail_cast    = (moduleinfo[module].castable) ? TRUE : FALSE;
        avail_armour  =
        avail_drop    =
        avail_get     =
        avail_hands   =
        avail_look    =
        avail_options =
        avail_use     =
        avail_view    = TRUE;
                if (numexits >= 2)
                {   avail_random = TRUE;
                }
        do_opts();
        letter = getletterornumber(allowed, 'P');
        enable_items(FALSE);
        avail_armour  =
        avail_cast    =
        avail_drop    =
        avail_get     =
        avail_hands   =
        avail_look    =
        avail_options =
        avail_proceed =
        avail_random  =
                avail_use     =
        avail_view    = FALSE;
        undo_opts();

        switch (letter)
        {
        case 'A':
            weararmour(EMPTY);
        acase 'C':
            castspell(-1, TRUE);
        acase 'D':
            drop_or_get(FALSE, FALSE);
        acase 'G':
            drop_or_get(TRUE, FALSE);
        acase 'H':
            hands();
        acase 'L':
            look();
            aprintf("¢%s?\n", theprompt);
            show_output();
        acase 'O':
            temproom   = room;
            tempmodule = module;
            options();
            if (temproom != room || tempmodule != module)
            {   dispose_npcs();
                return;
            }
            look();
            aprintf("¢%s?\n", theprompt);
            show_output();
        acase 'U':
            use(-1);
        acase 'V':
            view_man();
            aprintf("¢%s?\n", theprompt);
            show_output();
        acase 'P':
                case 'R':
                case '#':
            if (letter == 'P')
            {   if (between)
                {   room = newroom;
                    return;
                } else
                {   globalnumber = -2;
            }   }
                        elif (letter == 'R')
                        {   // assert(numexits >= 2);
                            globalnumber = exits[(room * EXITS) + (rand() % numexits)];
                        }

            if (globalnumber == -1)
            {   return;
            }

            if (between)
            {   if (globalnumber == newroom)
                {   room = newroom;
                    return;
                } else
                {   aprintf("Illegal input!\n");
                    look();
                    aprintf("¢%s?\n", theprompt);
                    show_output();
            }   }
            else
            {   for (i = 0; i < EXITS; i++)
                {   if (exits[(room * EXITS) + i] == globalnumber)
                    {   room = globalnumber;
                        return;
                }   }
                if (exits[(room * EXITS) + 0] == -1)
                {   aprintf("ðThere are no valid moves! Please send a bug report to amigansoftware@gmail.com!\n");
                    enterkey(TRUE);
                } else
                {   aprintf("Illegal input!\n");
                    look();
                    aprintf("¢%s?\n", theprompt);
                    show_output();
}   }   }   }   }

EXPORT void savedrooms(int throwlevel, int stat, int yesroom, int noroom)
{   if (saved(throwlevel, stat))
    {   if (yesroom == -1)
        {   die();
        } else
        {   room = yesroom;
    }   }
    else
    {   if (noroom == -1)
        {   die();
        } else
        {   room = noroom;
}   }   }

EXPORT FLAG shooting(void)
{   if (getyn("Shoot") && getmissileweapon() != -1 && useammo() != -1)
    {   return TRUE;
    } else
    {   return FALSE;
}   }
MODULE FLAG meleeing(void)
{   if (getyn("Melee") || getmissileweapon() == -1 || useammo() == -1)
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT int getmissileweapon(void)
{   TEXT letter;

    aprintf("Do you want to change what you are holding?\n");
    hands();

    aprintf("Use missile weapon in which hand?\n");
    missileweapon = EMPTY;
    do
    {   showhands();
        letter = getletter("øB¢oth/øL¢eft/øR¢ight/øN¢either", "BLRN", "Both", "Left", "Right", "Neither", "", "", "", "", 'N');
        switch (letter)
        {
        case 'B':
            if (both != EMPTY && items[both].range)
            {   missileweapon = both;
            } else
            {   aprintf("No missile weapon in both hands!\n");
                enterkey(TRUE);
            }
        acase 'L':
            if (lt != EMPTY && items[lt].range)
            {   missileweapon = lt;
            } else
            {   aprintf("No missile weapon in left hand!\n");
                enterkey(TRUE);
            }
        acase 'R':
            if (rt != EMPTY && items[rt].range)
            {   missileweapon = rt;
            } else
            {   aprintf("No missile weapon in right hand!\n");
                enterkey(TRUE);
            }
        acase 'N':
            missileweapon = EMPTY;
    }   }
    while (letter != 'N' && missileweapon == EMPTY);

    if (missileweapon == EMPTY)
    {   aprintf("Not using a missile weapon.\n");
    } else
    {   aprintf("Missile weapon is %s.\n", items[missileweapon].name);
    }

    return missileweapon;
}

EXPORT int useammo(void)
{   int ammotype,
        found,
        foundat = -1, // initialized to avoid a spurious SAS/C optimizer warning
        i;

    missileammo = poisoning = EMPTY;
    if (missileweapon == EMPTY || items[missileweapon].range == 0 || items[missileweapon].owned == 0)
    {   return EMPTY;
    }

    if
    (   items[missileweapon].type != WEAPON_BOW
     && items[missileweapon].type != WEAPON_XBOW
     && items[missileweapon].type != WEAPON_GUNNE
     && items[missileweapon].type != WEAPON_SLING
    )
    {   if (items[missileweapon].poisondoses)
        {   items[missileweapon].poisondoses--;
            poisoning = items[missileweapon].poisontype;
        }
        dropitem(missileweapon);
        missileammo = missileweapon;
        aprintf("Throwing a %s.\n", items[missileammo].name);
        return missileammo;
    }

    if   (items[missileweapon].type == WEAPON_BOW     ) ammotype = WEAPON_ARROW;
    elif (      missileweapon       == PRD            ) ammotype = WEAPON_STONE;
    elif (items[missileweapon].type == WEAPON_XBOW    ) ammotype = WEAPON_QUARREL;
    elif (items[missileweapon].type == WEAPON_GUNNE   ) ammotype = WEAPON_POWDER;
    elif (items[missileweapon].type == WEAPON_SLING   ) ammotype = WEAPON_STONE;
    elif (items[missileweapon].type == WEAPON_BLOWPIPE) ammotype = WEAPON_DART;
    else                                                return EMPTY;

    for (;;)
    {   found = 0;
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == ammotype)
            {   found++;
                foundat = i;
        }   }

        if (found == 0)
        {   aprintf("You have no ammunition for %s!\n", items[missileweapon].name);
            return EMPTY;
        } elif (found == 1)
        {   missileammo = foundat;
            aprintf("Ammunition is %s.\n", items[missileammo].name);
        } else
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].type == ammotype)
                {   aprintf("%d: %d %s\n", i + 1, items[i].owned, items[i].name);
            }   }
            missileammo = getnumber("Use which ammunition (ø0¢ for none)", 0, ITEMS) - 1;
        }

        if (missileammo == EMPTY)
        {   return EMPTY;
        } // implied else
        if (items[missileammo].owned && items[missileammo].type == ammotype)
        {   if (items[missileammo].poisondoses)
            {   items[missileammo].poisondoses--;
                poisoning = items[missileammo].poisontype;
            }
            dropitem(missileammo);
            return missileammo;
}   }   }

MODULE void rb_wandering(void)
{   int  fought,
         i,
         mr,
         result;
    FLAG ok,
         treasure;

    if (level > 6)
    {   aprintf("This is for level 1-6 characters only!\n");
        return;
    }

    if (showansi(7))
    {   enterkey(FALSE);
    }

    do
    {   do
        {   result = anydice(1, 20);
            if
            (   level >= 4
             && (   (result >=  2 && result <= 5)
                 ||  result ==  9
                 ||  result == 11
                 ||  result == 15
                 ||  result == 16
                 ||  result == 18
            )   )
            {   ok = FALSE;
            } else
            {   ok = TRUE;
        }   }
        while (!ok);

        create_monster(165 + result - 1);
        /* It's supposed to be the following, but that is far too deadly!
        switch (result)
        {
        case 2: // hobbit
            create_monsters(165 + result - 1, dice(3) + 2   ); // %%: it doesn't say how the 3..20 range is generated
        acase 3: // centaur
        case 17: // troll
            create_monsters(165 + result - 1, anydice(1,  3));
        acase 6: // flame demon
            create_monsters(165 + result - 1, anydice(1,  5));
        acase 7: // ghoul
        case 8: // goblin
        case 9: // spider
        case 10: // half-orc
        case 14: // orc
            create_monsters(165 + result - 1, anydice(1, 10));
        acase 11: // bird
        case 12: // ogre
        case 13: // leopard
        case 19: // vampire
        case 20: // werewolf
            create_monsters(165 + result - 1, dice(1)       );
        acase 15: // rat
            create_monsters(165 + result - 1, anydice(1, 14));
        adefault: // eg. 1 (balrog), 4/5 (dragon), 16 (tiger), 18 (unicorn)
            create_monster( 165 + result - 1                );
        } */

        if (npc[0].race == ANIMAL || npc[0].race == SPIDER)
        {   treasure = FALSE;
        } else
        {   treasure = TRUE;
        }

        mr = npc[0].mr;
        switch (result)
        {
        case 1:
        case 2:
        case 4:
        case 6:
        case 12:
        case 18:
        case 19:
            mr *= level;
        acase 5:
        case 9:
        case 13:
        case 15:
        case 16:
        case 20:
            mr *= (1 << (level - 1));
        adefault:
            if   (result ==  3) { if (level == 2) mr =  49; elif (level == 3) mr = 106; }
            elif (result ==  7) { if (level == 2) mr =  42; elif (level == 3) mr =  56; elif (level == 4) mr =  64; elif (level == 5) mr =  74; elif (level == 6) mr =   87; }
            elif (result ==  8) { if (level == 2) mr =  45; elif (level == 3) mr =  60; elif (level == 4) mr =  75; elif (level == 5) mr =  90; elif (level == 6) mr =  106; }
            elif (result == 11) { if (level == 2) mr =  72; elif (level == 3) mr =  98; }
            elif (result == 14) { mr = 20 + level; }
            elif (result == 17) { if (level == 2) mr = 100; elif (level == 3) mr = 200; elif (level == 4) mr = 400; elif (level == 5) mr = 650; elif (level == 6) mr = 1000; }
        }

        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].mr)
            {   npc[i].mr = mr;
            }
            recalc_ap(i);
        }
        fought = countfoes();

        if (verbose && races[npc[0].race].desc[0])
        {   aprintf("%s\n%s\n", races[npc[0].race].singular, races[npc[0].race].desc);
        } else
        {   aprintf("%s\n", races[npc[0].race].singular);
        }

        if (mr >= 50 * level)
        {   aprintf("%s's Monster Rating is %d!\n", npc[0].name, mr);
            if (getyn("Run away"))
            {   dispose_npcs();
                return;
        }   }

        fight();

        if (treasure)
        {   result = dice(1);
            switch (result)
            {
            case 1:
            case 2:
                give_cp(anydice(fought, 100) * level);
            acase 3:
            case 4:
                give_sp(anydice(fought, 100) * level);
            acase 5:
                give_gp(anydice(fought, 100) * level);
            acase 6:
                rb_givejewel(-1, -1, 2);
    }   }   }
    while (getyn("Fight again"));
}

EXPORT int highesthp(void)
{   int highest = 0,
        i;

    for (i = 0; i < MAX_MONSTERS; i++)
    {   if (npc[i].mr > highest)
        {   highest = npc[i].mr;
        } elif (npc[i].con > highest)
        {   highest = npc[i].con;
    }   }

    return highest;
}

EXPORT int daro(void)
{   int result1,
        result2,
        total = 0;

    do
    {   result1 =  dice(1);
        result2 =  dice(1);
        total   += result1 + result2;
        if (result1 == result2)
        {   aprintf("Double %d adds on and rolls over.\n", result1);
    }   }
    while (result1 == result2);

    return total;
}

EXPORT int taro(void)
{   int result1,
        result2,
        result3,
        total = 0;

    do
    {   result1 =  dice(1);
        result2 =  dice(1);
        result3 =  dice(1);
        total   += result1 + result2 + result3;
        if (result1 == result2 && result1 == result3)
        {   aprintf("Triple %d adds on and rolls over!\n", result1);
    }   }
    while (result1 == result2 && result1 == result3);

    return total;
}

EXPORT FLAG enchanted_melee(void)
{   if
    (   (rt >= 0 && (items[rt].dice || items[rt].adds) && items[rt].magical)
     || (lt >= 0 && (items[lt].dice || items[lt].adds) && items[lt].magical)
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG enchantedorsilver_melee(void)
{   if
    (   (rt >= 0 && (items[rt].dice || items[rt].adds) && (items[rt].magical || rt == 356))
     || (lt >= 0 && (items[lt].dice || items[lt].adds) && (items[lt].magical || lt == 356))
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG enchanted_missile(void)
{   if
    (   missileweapon >= 0
     && (   items[missileweapon].magical // there are no silver bows
         || (missileammo >= 0 && items[missileammo].magical)
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG enchantedorsilver_missile(void)
{   if
    (   missileweapon >= 0
     && (   items[missileweapon].magical // there are no silver bows
         || (missileammo >= 0 && (items[missileammo].magical || missileammo == 356))
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG armed(void)
{   if
    (   (rt >= 0 && (items[rt].dice || items[rt].adds))
     || (lt >= 0 && (items[lt].dice || items[lt].adds))
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT int damageof(int which)
{   return (dice(items[which].dice) + items[which].adds);
}

EXPORT void shop(void)
{   TEXT letter;

    for (;;)
    {   letter = getletter("øB¢uy/øS¢ell/øD¢one", "BSD", "Buy", "Sell", "Done", "", "", "", "", "", 'D');
        switch (letter)
        {
        case 'B':
            while (shop_buy(100, 'X') != -1);
        acase 'S':
            shop_sell(percent_sell, 100);
        acase 'D':
            return;
}   }   }

EXPORT int shop_give(int mode)
{   int choice,
        i,
        quantity;

/* Modes are:
 !  0=any things (OK34, RC81)
 .  1=any non-gunne weapon (AK190)
 !  2=any weapons (BS158, SO91, OK48, RC24/187)
 !  3=any swords/daggers/bows (CD60)
 .  4=any sword (OK56)
 .  5=any dagger (OK56)
 !  6=any non-weapons/armours/shields (SH36/SH150/DT275)
 !  7=any non-armours/poisons (BF147)
 .  8=any armour (OK7/29/104/108)
 .  9=any shield (OK108)
 . 10=any weapon (CD27, CT32, OK49/108, DT225/240/264/285)
 . 11=any thing (DT281)
 ! 12=any armour/shields/weapons (ND64 as currently implemented)
   . means just one item allowed, ! means multiple items
   %%: We are assuming they don't allow you to take jewels. */

    for (i = 0; i < ITEMS; i++)
    {   if (appropriate(mode, i))
        {   aprintf
            (   "%d: %s\n",
                i + 1,
                items[i].name
            );
    }   }
    for (;;)
    {   choice = getnumber("Take which item (ø0¢ for none)", 0, ITEMS) - 1;
        if (choice == -1)
        {   return -1;
        } elif (appropriate(mode, choice))
        {   if
            (   mode ==  0
             || mode ==  2
             || mode ==  3
             || mode ==  6
             || mode ==  7
             || mode == 12
            )
            {   quantity = getnumber("Take how many", 0, 9999);
            } else
            {   /* assert
                (   mode ==  1
                 || mode ==  4
                 || mode ==  5
                 || mode ==  8
                 || mode ==  9
                 || mode == 10
                 || mode == 11
                ); */
                quantity = 1;
            }
            if (quantity)
            {   give_multi_always(choice, quantity);
                return choice;
        }   }
        else
        {   aprintf("Not allowed!\n");
}   }   }

EXPORT int shop_buy(int percent, TEXT letter)
{   int  available,
         cost,
         i,
         quantity;
    FLAG ok;
    TEXT newletter;

/* Percentages are:
     75=3/4 price, any weapon/armour (AS129)
    100=normal (eg. RB0, AK169/190, BS1, DE1, SM141)
    110=10% surcharge (AS8)
   1000=10x normal price (HH47)
*/

    newletter = letter;

SHOP:
    if (letter == 'X')
    {   if (showansi(3) || class == WARRIOR)
        {   newletter = getletter("BUY: øA¢rmour/øJ¢ewel/øM¢isc/øN¢one/øS¢pell/øW¢eapon", "AJMNSW", "Armour", "Jewel", "Misc", "None", "Spell", "Weapon", "", "",     'M');
        } else
        {   newletter = getletter("BUY: øA¢rmour/øJ¢ewel/øM¢isc/øN¢one/"      "øW¢eapon", "AJMNW",  "Armour", "Jewel", "Misc", "None",          "Weapon", "", "", "", 'M');
        }
        switch (newletter)
        {
        case 'N':
            return -1;
        acase 'S':
            if (module != MODULE_RB)
            {   aprintf("There is no spell shop here!\n");
                enterkey(TRUE);
            } elif (class == WARRIOR)
            {   aprintf("Warriors can't buy spells!\n");
                enterkey(TRUE);
            } else
            {   buy_spells(0, money / 100);
    }   }   }

    switch (newletter)
    {
    case 'A':
        newletter = getletter("øA¢ll/øC¢hest/øH¢elmet/øL¢egs/comøP¢lete/aøR¢ms/øS¢hield/øN¢one", "ACHLPRSN", "All", "Chest", "Helmet", "Legs", "Complete", "Arms", "Shield", "None", 'A');
        if (newletter == 'N')
        {   return -1;
        }
        if (newletter == 'R')
        {   newletter = 'Z';
        }
    acase 'W':
        newletter = getletter("øA¢ll/ø1¢-handed/ø2¢-handed/ammøO¢/øR¢anged/øN¢one", "A12ORN", "All", "1-handed", "2-handed", "Ammo", "Ranged", "None", "", "", 'A');
        if (newletter == 'N')
        {   return -1;
        }
        if (newletter == 'A')
        {   newletter = 'W';
    }   }

    aprintf(" No. Name                              Cost Weight Dice+Adds Hits Range ST DEX\n");
    aprintf("---- ---------------------------- --------- ------ --------- ---- ----- -- ---\n");

    ok = FALSE;
    for (i = 0; i < ITEMS; i++)
    {   cost = items[i].cp * percent / 100;

        if
        (   items[i].module == MODULE_RB
         && cost <= money
         && (module != MODULE_AS || room != 129 || isweapon(i) || items[i].type == ARMOUR)
         && showornot(i, newletter)
     //  && i != MAK
        )
        {   printiteminfo_table(i, percent);
            ok = TRUE;
    }   }
    if (!ok)
    {   aprintf("     (None)\n");
    }
    aprintf("\n");

    for (;;)
    {   if (!reactable)
        {   aprintf("You have %d gp, %d sp, %d cp (value is %d cp).\n", gp, sp, cp, (gp * 100) + (sp * 10) + cp);
        }
        i = getnumber("Buy which item (ø0¢ for none)", 0, ITEMS) - 1;
        if (i == -1)
        {   if (letter == 'A' || letter == 'W')
            {   newletter = letter;
                goto SHOP;
            } // implied else
            if (letter == 'X')
            {   goto SHOP;
            } // implied else
            return -1;
        } // implied else
        cost = items[i].cp * percent / 100;
        showitempic(i);
        if
        (   items[i].module == MODULE_RB
         && (module != MODULE_AS || room != 129 || isweapon(i) || items[i].type == ARMOUR)
         && cost <= money
         && showornot(i, newletter)
     //  && i != MAK
        )
        {   if (items[i].module == MODULE_RB && items[i].room1 != -1)
            {   aprintf("¹%s\n", rb_weapondesc[items[i].room1]);
            }
            if (cost)
            {   available = money / cost;
                quantity = getnumber("Buy how many", 0, available);
                pay_cp(cost * quantity);
            } else
            {   quantity = 1;
            }
            ask = FALSE;
            give_multi_always(i, quantity);
            ask = TRUE;
            return i;
        } else
        {   aprintf("You can't buy %s!\n", items[i].name);
}   }   }

EXPORT void shop_sell(int percent_standard, int percent_treasure)
{   int choice,
        quantity;

    listitems(TRUE, FALSE, percent_standard, percent_treasure);
    choice = getnumber("Sell which (ø0¢ for none)", 0, ITEMS) - 1;
    if (choice == -1)
    {   return;
    } elif (!items[choice].owned)
    {   aprintf("You don't have that item!\n");
    } elif (!items[choice].cp)
    {   aprintf("That item is worthless!\n");
    } elif (!droppable(choice))
    {   aprintf("That item is cursed!\n");
    } else
    {   if (items[choice].owned >= 2)
        {   quantity = getnumber("Sell how many", 0, items[choice].owned);
        } else
        {   quantity = 1;
        }
        dropitems(choice, quantity);
        if (items[choice].module == MODULE_RB)
        {   give_money(items[choice].cp * quantity * percent_standard / 100);
        } else
        {   give_money(items[choice].cp * quantity * percent_treasure / 100);
}   }   }

EXPORT FLAG isarmour(int which)
{   if
    (   which >= 0
     && (   items[which].type == ARMOUR_COMPLETE
         || items[which].type == ARMOUR_ARMS
         || items[which].type == ARMOUR_HEAD
         || items[which].type == ARMOUR_LEGS
         || items[which].type == ARMOUR_CHEST
         || items[which].type == SHIELD
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG isweapon(int which)
{   // %%: does poison count as a weapon? We assume not.

    if
    (   which >= 0
     && (   items[which].dice
         || items[which].adds
         || (items[which].type >= FIRSTWEAPON && items[which].type <= LASTWEAPON)
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void victory_level(int amount)
{   int needed;

    needed = (level < 20) ? apreq[level + 1] : (16000000 * (level - 18));
    if (xp + amount >= needed)
    {   victory(amount);
    } else
    {   victory(needed - xp);
}   }

EXPORT void buy_spells(int mode, int amount)
{   int  i;
    FLAG ok = FALSE;

/* 0 = normal (RB) (Wizard's Guild)
   1 = free gp (AS)
   2 = half price (AS)
   3 = free levels (AS)
*/

    if (amount == 0)
    {   aprintf("You can't afford any spells!\n");
        return;
    }

    while (amount > 0)
    {   if (!verbose)
        {   aprintf
            (   " No. Level Name                       Cost Range    Duration\n" \
                "---- ----- ----------------------- ------- ----- -----------\n"
            );
        }
        for (i = 0; i < SPELLS; i++)
        {   if
            (   (mode != 0 || level >= spell[i].level)
             && spell[i].level >= 1
             && !spell[i].known
             && (   (mode != 3 && amount >= spellinfo[spell[i].level].gp)
                 || (mode == 3 && amount >= spell[i].level)
            )   )
            {   ok = TRUE;
                if (verbose)
                {   aprintf
                    (   "²%d: L%d: %s (%d gp)\n",
                        i + 1,
                        spell[i].level,
                        spell[i].corginame,
                        (mode == 2) ? (spellinfo[spell[i].level].gp / 2) : spellinfo[spell[i].level].gp
                    );
                    aprintf("%s", spell[i].desc);
                    if (spell[i].range)
                    {   aprintf(" (%d')", spell[i].range);
                    }
                    if (spell[i].duration)
                    {   aprintf(" (%d mins)", spell[i].duration);
                    }
                    aprintf("\n");
                } else
                {   aprintf
                    (   "²%3d: %5d %-23s %4d gp %4d' %6d mins\n",
                        i + 1,
                        spell[i].level,     // highest level is 20
                        spell[i].corginame, // longest name is 23
                        (mode == 2) ? (spellinfo[spell[i].level].gp / 2) : spellinfo[spell[i].level].gp, // highest cost is 9500 gp
                        spell[i].range,     // highest range is 500'
                        spell[i].duration   // longest duration is 527040 mins
                    );
        }   }   }

        if (!ok)
        {   aprintf("No more learnable spells!\n");
            return;
        }

        if (!reactable)
        {   aprintf("You have %d gp, %d sp, %d cp (value is %d cp).\n", gp, sp, cp, (gp * 100) + (sp * 10) + cp);
        }
        i = getnumber("Buy which spell (ø0¢ for none)", 0, SPELLS) - 1;
        if (i == -1)
        {   return;
        } elif (spell[i].known)
        {   aprintf("You already know %s!\n", spell[i].corginame);
        } elif (class == ROGUE && spell[i].level > 7)
        {   aprintf("Rogue's can't learn spells beyond level 7!\n");
        } elif (mode == 0 && level < spell[i].level)
        {   aprintf("You can't learn %s until level %d!\n", spell[i].corginame, spell[i].level);
        } elif (amount < spellinfo[spell[i].level].gp)
        {   aprintf("You can't afford %s!\n", spell[i].corginame);
        } else
        {   switch (mode)
            {
            case 0:
                amount -= spellinfo[spell[i].level].gp;
                pay_gp(spellinfo[spell[i].level].gp);
            acase 1:
                amount -= spellinfo[spell[i].level].gp;
            acase 2:
                amount -= spellinfo[spell[i].level].gp / 2;
                pay_gp(spellinfo[spell[i].level].gp / 2);
            acase 3:
                amount -= spell[i].level;
            }
            learnspell(i);
}   }   }

EXPORT FLAG gotrope(int length)
{   if
    (   items[195].owned
     || (    items[SIL].owned
          +  items[ROP].owned
          + (items[463].owned * 30)
          + (items[669].owned * 40)
          >= length // we are letting the player tie the ropes together
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG canfly(FLAG askspell)
{   if
    (   race == DRAGON
     || race == FAIRY
     || race == GAUNT
     || race == GRIFFIN
     || race == HARPY
     || race == WYVERN
     || race == PHOENIX
     || ability[13].known
     || ability[135].known
     || ability[169].known
     || items[461].owned
     || spell[SPELL_WI].active
     || spell[SPELL_BG].active
     || spell[SPELL_UP].active
     || (askspell && cast(SPELL_WI, FALSE))
     || (askspell && cast(SPELL_BG, FALSE))
     || (askspell && cast(SPELL_UP, FALSE)) // levitation only! (good enough for DT138, at least)
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG can_breathewater(FLAG askspell)
{   if
    (   race == MERMAN
     || ability[7].known
     || ability[101].known
     || items[572].owned
     || items[947].owned
     || items[948].owned
     || spell[SPELL_GF].active
     || (askspell && cast(SPELL_GF, FALSE))
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void edit_man(void)
{   int  i,
         result, result1, result2;
    TEXT letter;

    if (!gotman)
    {   aprintf("No man has been loaded/created yet!\n");
        return;
    }

    for (;;)
    {   globalrandomable = FALSE;
            result = getnumber
              ("ø 0¢) Done                   ø12¢) Change attribute\n" \
               "ø 1¢) View character         ø13¢) Change items\n" \
               "ø 2¢) Change race            ø14¢) Change languages\n" \
               "ø 3¢) Change class           ø15¢) Change location\n" \
               "ø 4¢) Change level           ø16¢) Change monsters killed\n" \
               "ø 5¢) Change APs             ø17¢) Change ability\n" \
               "ø 6¢) Change age/time        ø18¢) Toggle spell\n" \
               "ø 7¢) Change height          ø19¢) Toggle modules done\n" \
               "ø 8¢) Change weight          ø20¢) Toggle sex\n" \
               "ø 9¢) Change GPs             ø21¢) Kill all enemies\n" \
               "ø10¢) Change SPs             ø22¢) Learn all spells\n" \
               "ø11¢) Change CPs             ø23¢) Resurrect\n\n" \
               "Which", 0, 23);
        globalrandomable = TRUE;
            switch (result)
        {
        case 0:
            return;
        acase 1:
            view_man();
        acase 2:
            race   = getnumber("New race"       ,      0, RACES - 1);
        acase 3:
            class  = getnumber("New class"      ,      0, CLASSES - 1);
        acase 4:
            level  = getnumber("New level"      ,      1, 2000000000);
        acase 5:
            xp     = getnumber("New APs"        ,      0, 2000000000);
        acase 6:
            age     = getnumber("New age"        ,     0,      32000);
            aprintf("Time elapsed is %d minutes.\n", minutes);
            minutes = getnumber("New minutes elapsed", 0, 2000000000);
        acase 7:
            height = getnumber("New height"     ,      0,      32000);
        acase 8:
            weight = getnumber("New weight"     ,      0,      32000);
        acase 9:
            gp     = getnumber("New GPs"        ,      0, 2000000000);
        acase 10:
            sp     = getnumber("New SPs"        ,      0, 2000000000);
        acase 11:
            cp     = getnumber("New CPs"        ,      0, 2000000000);
        acase 12:
            letter = getletter("øS¢t/øI¢q/øL¢k/øC¢on/øD¢ex/cøH¢r/søP¢d", "SILCDHP", "St", "Iq", "Lk", "Con", "Dex", "cHr", "sPd", "", FALSE);
            result = getnumber("New value", 1, 32000);
            switch (letter)
            {
            case 'S':
                if (getyn("Adjust maximum ST only (otherwise adjust current ST)"))
                {   max_st = result;
                } else
                {   st = result;
                    if (max_st < st) max_st = st;
                }
            acase 'I':
                iq = result;
            acase 'L':
                lk = result;
            acase 'C':
                if (getyn("Adjust maximum CON only (otherwise adjust current CON)"))
                {   max_con = result;
                } else
                {   con = result;
                    if (max_con < con) max_con = con;
                }
            acase 'D':
                dex = result;
            acase 'H':
                chr = result; // we really should allow CHRs as low as -32000
            acase 'P':
                spd = result;
            }
        acase 13:
            for (i = 0; i < ITEMS; i++)
            {   aprintf
                (   "%d: %s\n",
                    i + 1,
                    items[i].name
                );
            }
            result1 = getnumber("Which item (ø0¢ for none)", 0, ITEMS) - 1;
            if (result1 >= 0)
            {   dropitems(result1, items[result1].owned);
                result2 = getnumber("How many", 0, 2000000000);
                give_multi(result1, result2);
            }
        acase 14:
            for (i = 0; i < LANGUAGES; i++)
            {   aprintf
                (   "%d: %s\n",
                    i + 1,
                    language[i].name
                );
            }
            result1 = getnumber("Which language (ø0¢ for none)", 0, LANGUAGES) - 1;
            if (result1 >= 0)
            {   result2 = getnumber("1) Unknown\n2) Pidgin\n3) Fluent\nWhich", 1, 3);
                set_language(result1, result2 - 1);
            }
        acase 15:
            room = getnumber("Which paragraph", 0, moduleinfo[module].rooms - 1);
        acase 16:
            for (i = 0; i < RACES; i++)
            {   aprintf("%d: %s\n", i + 1, races[i].plural);
            }
            result1 = getnumber("Which race (ø0¢ for none)", 0, RACES) - 1;
            if (result1 != -1)
            {   result2 = getnumber("How many", 0, 2000000000);
                killcount[result1] = result2;
            }
        acase 17:
            for (i = 0; i < ABILITIES; i++)
            {   aprintf("%d: %s\n", i + 1, ability[i].text);
            }
            result = getnumber("Change which ability (ø0¢ for none)", 0, ABILITIES) - 1;
            if (result != -1)
            {   if (NUMERICABILITY(result))
                {   if (getyn("Increase (otherwise decrease)?"))
                    {   result2 = getnumber("By how many", 0, 32767);
                        gain_numeric_abilities(result, result2);
                    } else
                    {   result2 = getnumber("By how many", 0, 32767);
                        lose_numeric_abilities(result, result2);
                }   }
                else
                {   if (ability[result].known)
                    {   lose_flag_ability(result);
                    } else
                    {   gain_flag_ability(result);
            }   }   }
        acase 18:
            result = getspell("Toggle which spell (øENTER¢ key for none, ø?¢ for list)");
            if (result != -1)
            {   if (spell[result].known)
                {   spell[result].known = FALSE;
                } else
                {   learnspell(result);
            }   }
        acase 19:
            if ((result = getmodule("Which adventure (øENTER¢ key for none)")))
            {   if (moduledone[result])
                {   moduledone[result] = FALSE;
                } else
                {   moduledone[result] = TRUE;
            }   }
        acase 20:
            if (sex == MALE) sex = FEMALE; else sex = MALE;
        acase 21:
            kill_npcs();
        acase 22:
            for (i = 0; i < SPELLS; i++)
            {   learnspell(i);
            }
        acase 23:
            resurrect();
}   }   }

MODULE FLAG droppable(int whichitem)
{   if
    (   whichitem == 198
     || whichitem == 221
     || whichitem == 275
     || whichitem == ITEM_GK_CDELUXE
     || whichitem == 790
     || whichitem == 833
    )
    {   return FALSE;
    } // implied else
    return TRUE;
}

EXPORT void borrow_all(void)
{   int i;

    owed_cp += cp;
    pay_cp_only(cp);
    owed_sp += sp;
    pay_sp_only(sp);
    owed_gp += gp;
    pay_gp_only(gp);
    for (i = 0; i < ITEMS; i++)
    {   if (droppable(i))
        {   items[i].borrowed += items[i].owned;
            dropitems(i, items[i].owned);
}   }   }
EXPORT void borrow_weaponsandarmour(void)
{   int i;

    for (i = 0; i < ITEMS; i++)
    {   if (droppable(i) && (isweapon(i) || items[i].type == ARMOUR))
        {   items[i].borrowed += items[i].owned;
            dropitems(i, items[i].owned);
}   }   }

EXPORT void return_all(void)
{   int i;

    give_cp(owed_cp);
    owed_cp = 0;
    give_sp(owed_sp);
    owed_sp = 0;
    give_gp(owed_gp);
    owed_gp = 0;
    for (i = 0; i < ITEMS; i++)
    {   give_multi(i, items[i].borrowed);
        items[i].borrowed = 0;
}   }

MODULE void bank(void)
{   TEXT letter;
    int  i,
         result;

    for (;;)
    {   result = 0;
        for (i = 0; i < ITEMS; i++)
        {   result += items[i].banked;
        }
        aprintf("Your balance is %d cp and %d item(s). You are carrying %d gp, %d sp, %d cp.\n", bankcp, result, gp, sp, cp);
        letter = getletter("øC¢ity/øD¢eposit/øW¢ithdraw", "CDW", "City", "Deposit", "Withdraw", "", "", "", "", "", 'C');
        switch (letter)
        {
        case  'C':
            return;
        acase 'D':
            bank_deposit();
        acase 'W':
            bank_withdraw();
}   }   }

MODULE void bank_deposit(void)
{   int  i,
         result;
    TEXT letter;

    result = 0;
    for (i = 0; i < ITEMS; i++)
    {   result += items[i].banked;
    }
    aprintf("Your balance is %d cp and %d item(s). You are carrying %d gp, %d sp, %d cp.\n", bankcp, result, gp, sp, cp);

    letter = getletter("DEPOSIT: øA¢ll/øC¢opper/øI¢tems/øS¢ilver/øG¢old/øN¢one", "ACISGN", "All", "Copper", "Items", "Silver", "Gold", "None", "", "", 'A');
    switch (letter)
    {
    case 'A':
        bankcp += cp;
        pay_cp_only(cp);
        bankcp += sp * 10;
        pay_sp_only(sp);
        bankcp += gp * 100;
        pay_gp_only(gp);
        for (i = 0; i < ITEMS; i++)
        {   if (droppable(i))
            {   items[i].banked += items[i].owned;
                dropitems(i, items[i].owned);
        }   }
    acase 'C':
        result = getnumber("Deposit how many cp", 0, cp);
        pay_cp_only(result);
        bankcp += result;
    acase 'I':
        listitems(TRUE, FALSE, 100, 100);
        do
        {   i = getnumber("Deposit which item (ø0¢ for none)", 0, ITEMS) - 1;
        } while (i != -1 && !items[i].owned);
        if (i != -1 && items[i].owned >= 1)
        {   if (!droppable(i))
            {   aprintf("That item is cursed!\n");
            } else
            {   if (items[i].owned == 1)
                {   result = 1;
                } else
                {   result = getnumber("Deposit how many", 0, items[i].owned);
                }
                if (result)
                {   items[i].banked += result;
                    dropitems(i, result);
        }   }   }
    acase 'S':
        result = getnumber("Deposit how many sp", 0, sp);
        pay_sp_only(result);
        bankcp += result * 10;
    acase 'G':
        result = getnumber("Deposit how many gp", 0, gp);
        pay_gp_only(result);
        bankcp += result * 100;
}   }

MODULE void bank_withdraw(void)
{   int  i,
         result;
    TEXT letter;

    result = 0;
    for (i = 0; i < ITEMS; i++)
    {   result += items[i].banked;
    }
    aprintf("Your balance is %d cp and %d item(s). You are carrying %d gp, %d sp, %d cp.\n", bankcp, result, gp, sp, cp);

    ask = FALSE;
    letter = getletter("WITHDRAW: øA¢ll/øC¢opper/øI¢tems/øS¢ilver/øG¢old/øN¢one", "ACISGN", "All", "Copper", "Items", "Silver", "Gold", "None", "", "", 'A');
    switch (letter)
    {
    case 'A':
        give_gp(bankcp / 100);
        bankcp %= 100;
        give_sp(bankcp /  10);
        bankcp %=  10;
        give_cp(bankcp      );
        bankcp = 0;
        for (i = 0; i < ITEMS; i++)
        {   give_multi(i, items[i].banked);
            items[i].banked = 0;
        }
    acase 'C':
        result = getnumber("Withdraw how many cp", 0, bankcp);
        bankcp -= result;
        give_cp(result);
    acase 'I':
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].banked)
            {   aprintf("%d: %d %s\n", i + 1, items[i].banked, items[i].name);
        }   }
        do
        {   i = getnumber("Withdraw which item (ø0¢ for none)", 0, ITEMS) - 1;
        } while (i != -1 && !items[i].banked);
        if (i != -1)
        {   if (items[i].banked == 1)
            {   result = 1;
            } else
            {   result = getnumber("Withdraw how many", 0, items[i].banked);
            }
            if (result)
            {   items[i].banked -= result;
                give_multi(i, result);
        }   }
    acase 'S':
        result = getnumber("Withdraw how many sp", 0, bankcp / 10);
        bankcp -= result * 10;
        give_sp(result);
    acase 'G':
        result = getnumber("Withdraw how many gp", 0, bankcp / 100);
        bankcp -= result * 100;
        give_gp(result);
    }
    ask = TRUE;
}

EXPORT void noeffect(void)
{   aprintf("The spell does not work; no effect.\n");
    if (module == MODULE_CD && room == 126)
    {   room = 113;
    } elif (module == MODULE_CD && room == 171)
    {   room = 80;
}   }
EXPORT void halfeffect(void)
{   aprintf("Your spell only had half effect.\n");
    spellpower /= 2;
    payload((FLAG) (incombat ? FALSE : TRUE));
}
EXPORT void fulleffect(void)
{   aprintf("Your spell takes effect.\n");
    payload((FLAG) (incombat ? FALSE : TRUE));
}
EXPORT void doublecost(void)
{   aprintf("Your spell takes 2 times more Strength to cast.\n");
    templose_st(spellcost);
    payload((FLAG) (incombat ? FALSE : TRUE));
}
EXPORT void triplecost(void)
{   aprintf("Your spell takes 3 times more Strength to cast.\n");
    templose_st(spellcost * 2);
    payload((FLAG) (incombat ? FALSE : TRUE));
}
EXPORT void doubleeffect(void)
{   aprintf("Your spell took double effect.\n");
    spellpower *= 2;
    payload((FLAG) (incombat ? FALSE : TRUE));
}
EXPORT void thresholdeffect(void)
{   aprintf("First level spells work on a roll of 1-2; second, 1-3; third, 1-4; fourth, 1-5; and spells of fifth level and above work.\n");
    if (spelllevel >= 5 || dice(1) <= spelllevel + 1)
    {   fulleffect();
    } else
    {   noeffect();
}   }
EXPORT void maybeeffect(int chance)
{   aprintf("Your spell will work on a roll of 1-%d.\n", chance);
    if (dice(1) <= chance)
    {   fulleffect();
    } else
    {   noeffect();
}   }
EXPORT void powereffect(int power)
{   aprintf("Your spell will work if at least %d power.\n", power);
    if (spellpower >= power)
    {   fulleffect();
    } else
    {   noeffect();
}   }
EXPORT void halfpowereffect(int power)
{   aprintf("Your spell took half effect, if cast at %d or more power.\n", power);
    if (spellpower >= power)
    {   halfeffect();
}   }
EXPORT void doublepowereffect(int power)
{   aprintf("Your spell took double effect, if cast at %d or more power.\n", power);
    if (spellpower >= power)
    {   doubleeffect();
}   }
EXPORT void maybepowereffect(int chance, int power)
{   aprintf("Your spell will work on a roll of 1-%d, if cast at %d or more power.\n", chance, power);
    if (dice(1) <= chance && spellpower >= power)
    {   fulleffect();
    } else
    {   noeffect();
}   }
EXPORT void leveleffect(int minlevel)
{   aprintf("Your spell will work if cast at level %d or higher.\n", minlevel);
    if (spelllevel >= minlevel)
    {   fulleffect();
    } else
    {   noeffect();
}   }

EXPORT void spell_tt(void)
{   lose_flag_ability(17);
    lose_flag_ability(46);
    lose_flag_ability(52);
    lose_flag_ability(54);
    lose_flag_ability(94);
    lose_flag_ability(95);
}

EXPORT void spell_hf(void)
{   int i;

    lose_flag_ability(15);
    lose_flag_ability(44);
    lose_flag_ability(50);
    lose_flag_ability(51);
    lose_flag_ability(53);
    for (i = 75; i <= 85; i++)
    {   lose_flag_ability(i);
    }
    lose_flag_ability(124);
    for (i = 139; i <= 141; i++)
    {   lose_flag_ability(i);
}   }

EXPORT void spell_cf(int effectlevel)
{   int i;

    // %%: probably we should require casting a separate CF spell for each curse, rather than one casting removing all curses
    if (effectlevel > 9)
    {   for (i = 4; i <= 13; i++)
        {   lose_flag_ability(i);
    }   }
    lose_flag_ability(62);
    if (effectlevel >= 12)
    {   lose_flag_ability(151);
    }
    if (effectlevel > 7)
    {   lose_flag_ability(154);
        lose_flag_ability(155); // %%: we assume DT48 curse is 7th level, same as DT40 one is
        lose_flag_ability(156);
    }
    if (effectlevel > 5)
    {   lose_flag_ability(161);
        lose_flag_ability(162);
    }

    // %%: maybe we shouldn't automatically destroy these items as soon as the curse is lifted
    if (items[ITEM_GK_CDELUXE].owned)
    {   items[ITEM_GK_CDELUXE].owned = 0;
    }
    if (items[833].owned)
    {   items[833].owned = 0;
}   }

EXPORT int evil_getneeded(int range)
{   switch (races[race].size)
    {
    case SIZE_TINY:
        if   (range == RANGE_POINTBLANK) return 5;
        elif (range == RANGE_NEAR      ) return 10;
        elif (range == RANGE_FAR       ) return 15;
        elif (range == RANGE_EXTREME   ) return 20;
    acase SIZE_VSMALL:
        if   (range == RANGE_POINTBLANK) return 4;
        elif (range == RANGE_NEAR      ) return 8;
        elif (range == RANGE_FAR       ) return 12;
        elif (range == RANGE_EXTREME   ) return 16;
    acase SIZE_SMALL:
        if   (range == RANGE_POINTBLANK) return 3;
        elif (range == RANGE_NEAR      ) return 6;
        elif (range == RANGE_FAR       ) return 9;
        elif (range == RANGE_EXTREME   ) return 12;
    acase SIZE_LARGE:
        if   (range == RANGE_POINTBLANK) return 2;
        elif (range == RANGE_NEAR      ) return 4;
        elif (range == RANGE_FAR       ) return 6;
        elif (range == RANGE_EXTREME   ) return 8;
    acase SIZE_HUGE:
        if   (range == RANGE_POINTBLANK) return 1;
        elif (range == RANGE_NEAR      ) return 2;
        elif (range == RANGE_FAR       ) return 3;
        elif (range == RANGE_EXTREME   ) return 4;
    }

    return 0; // should never happen

    // %%: Perhaps this should be based on height rather than on race.
}

EXPORT FLAG can_makefire(void)
{   // We always return TRUE because otherwise if you can't light a torch at WC132 and can't cast a spell you get stuck in an endless loop

    return TRUE; // return ((FLAG) (items[PRO].owned || items[DEP].owned));
    // What if they are willing to cast a spell, eg. SPELL_TF?
}

EXPORT void become_warrior(void)
{   int i;

    class = WARRIOR;
    // %%: some paragraphs (eg. WW130) don't explicitly say we should lose our spells.
    for (i = 0; i < SPELLS; i++)
    {   spell[i].known = FALSE;
}   }

EXPORT int throwcoin(void)
{   TEXT letter;

    if (!gp && !sp && !cp);
    {   aprintf("You don't have any coins to throw!\n");
        return 0;
    }

    for (;;)
    {   aprintf("You have %d gp, %d sp, %d cp.\nThrow which type of coin?\n", gp, sp, cp);
        letter = getletter("øC¢opper/øS¢ilver/øG¢old/øN¢one", "CSGN", "Copper", "Silver", "Gold", "None", "", "", "", "", 'N');
        switch (letter)
        {
        acase 'C':
            if (pay_cp_only(1))
            {   return 1;
            } else
            {   aprintf("You don't have any copper pieces!\n");
            }
        acase 'S':
            if (pay_sp_only(1))
            {   return 2;
            } else
            {   aprintf("You don't have any silver pieces!\n");
            }
        acase 'G':
            if (pay_gp_only(1))
            {   return 3;
            } else
            {   aprintf("You don't have any gold pieces!\n");
            }
        adefault: // eg. 'N'
            return 0;
}   }   }

MODULE void listspells(FLAG full)
{   int  i;
    FLAG done = FALSE;

    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].known)
        {   aprintf("²");
            listspell(i, full);
            done = TRUE;
    }   }
    if (!done)
    {   aprintf("²None\n");
}   }

EXPORT void listspell(int whichspell, FLAG full)
{   TEXT tempstring[256 + 1];

    sprintf
    (   tempstring,
        "²%s: %s (L%d) (ST %d)",
        spell[whichspell].abbrev,
        spell[whichspell].corginame,
        spell[whichspell].level,
        spell[whichspell].st
    );
    if (spell[whichspell].range)
    {   sprintf
        (   &tempstring[strlen(tempstring)],
            " (%d')",
            spell[whichspell].range
        );
    }
    if (spell[whichspell].duration)
    {   sprintf
        (   &tempstring[strlen(tempstring)],
            " (%d mins)",
            spell[whichspell].duration
        );
    }
    switch (spell[whichspell].flags)
    {
    case SPELL_CIRCLE:
        strcat(tempstring, " (O)");
    acase SPELL_TRIANGLE:
        strcat(tempstring, " (A)");
    acase SPELL_BOTH:
        strcat(tempstring, " (OA)");
    }
    aprintf("%s\n", tempstring);
    if (full && (showunimp || (spell[whichspell].desc[0] != '[' || spell[whichspell].desc[strlen(spell[whichspell].desc) - 1] != ']')))
    {   aprintf("¹%s\n", spell[whichspell].desc);
}   }

MODULE FLAG appropriate(int mode, int which)
{   if
    (   items[which].module == MODULE_RB
     && items[which].type   != JEWEL
     && which               != MAK
     && (    mode ==  0
         || (mode ==  1 && isweapon(which) && items[which].type != WEAPON_GUNNE)
         || (mode ==  2 && isweapon(which))
         || (mode ==  3 && (items[which].type == WEAPON_SWORD || items[which].type == WEAPON_DAGGER || items[which].type == WEAPON_BOW))
         || (mode ==  6 && !isweapon(which) && items[which].type != ARMOUR && items[which].type != SHIELD)
         || (mode ==  7 && items[which].type != POISON && items[which].type != ARMOUR && items[which].type != SHIELD)
         || (mode ==  8 && items[which].type == ARMOUR)
         || (mode ==  9 && items[which].type == SHIELD)
         || (mode == 10 && isweapon(which))
         ||  mode == 11
         || (mode == 12 && (isweapon(which) || items[which].type == ARMOUR || items[which].type == SHIELD))
    )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG immune_hb(void)
{   if (items[624].owned)
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG immune_poison(void)
{   if (ability[1].known || items[768].owned)
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT FLAG immune_fire(void)
{   if (ability[97].known || items[114].owned)
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void set_language(int which, int fluency)
{   PERSIST const STRPTR fluencyname[3] = { "None", "Pidgin", "Fluent" };

    if (1) // (language[which].fluency != fluency)
    {   language[which].fluency = fluency;
        aprintf("%s fluency is now %s.\n", language[which].name, fluencyname[fluency]);
}   }

EXPORT FLAG maybespend(int price, STRPTR question)
{   TEXT prompt[80 + 1];

    if (money >= price * 100)
    {   sprintf(prompt, "%s (%d gp)", question, price);
        if (getyn(question))
        {   pay_gp(price);
            return TRUE;
    }   }
    return FALSE;
}

EXPORT void dicerooms(int first, int second, int third, int fourth, int fifth, int sixth)
{   int result;

    result = dice(1);
    switch (result)
    {
    case  1: if (first  == -1) die(); else room = first;
    acase 2: if (second == -1) die(); else room = second;
    acase 3: if (third  == -1) die(); else room = third;
    acase 4: if (fourth == -1) die(); else room = fourth;
    acase 5: if (fifth  == -1) die(); else room = fifth;
    acase 6: if (sixth  == -1) die(); else room = sixth;
}   }

EXPORT void oddeven(int odd, int even)
{   if (dice(1) % 2)
    {   room = odd;
    } else
    {   room = even;
}   }

EXPORT void drop_weapons(void)
{   int i;

    for (i = 0; i < ITEMS; i++)
    {   if (items[i].owned && isweapon(i))
        {   dropitems(i, items[i].owned);
}   }   }

EXPORT void drop_clothing(void)
{   int i;

    for (i = 0; i < ITEMS; i++)
    {   if (items[i].owned && (i == CLO || isarmour(i))) // very probably there are other items that this would apply to
        {   dropitems(i, items[i].owned);
}   }   }

EXPORT void drop_armour(void)
{   int i;

    for (i = 0; i < ITEMS; i++)
    {   if (items[i].owned && isarmour(i))
        {   dropitems(i, items[i].owned);
}   }   }

MODULE void showhands(void)
{   if (lt != EMPTY || rt != EMPTY)
    {   // assert(both == EMPTY);
        aprintf("³Right hand:      ¢");
        printiteminfo(rt,   FALSE);
        aprintf("³Left  hand:      ¢");
        printiteminfo(lt,   FALSE);
    } else
    {   aprintf("³Both hands:      ¢");
        printiteminfo(both, FALSE);
}   }

EXPORT TEXT getsymbol(int whichitem)
{   // assert(whichitem != -1);

    if (items[whichitem].inuse)
    {   return 'U';
    } elif (armour == whichitem)
    {   return 'A';
    } elif (head == whichitem)
    {   return 'H';
    } elif (arms == whichitem)
    {   return 'M';
    } elif (chest == whichitem)
    {   return 'C';
    } elif (legs == whichitem)
    {   return 'G';
    } elif (both == whichitem)
    {   return 'B';
    } elif (rt == whichitem && lt == whichitem)
    {   return 'E';
    } elif (rt == whichitem)
    {   return 'R';
    } elif (lt == whichitem)
    {   return 'L';
    } else
    {
#ifdef WIN32
        return '.';
#else
        return (TEXT) '·';
#endif
}   }

MODULE void printiteminfo(int whichitem, FLAG numberit)
{   if (whichitem == EMPTY)
    {   aprintf("None\n");
        return;
    }
    if (numberit)
    {   aprintf("%d: ", whichitem + 1);
    }
    aprintf("%s", items[whichitem].name);
    if (items[whichitem].cp)
    {   if (items[whichitem].cp % 100 == 0)
        {   aprintf(" (%d gp)", items[whichitem].cp     / 100);
        } elif (items[whichitem].cp % 10 == 0)
        {   aprintf(" (%d sp)", items[whichitem].cp     /  10);
        } else
        {   aprintf(" (%d cp)", items[whichitem].cp          );
    }   }
    if (items[whichitem].weight)
    {   if (items[whichitem].weight % 10 == 0)
        {   aprintf(" (%d#)",   items[whichitem].weight /  10);
        } else
        {   aprintf
            (   " (%d.%d#)",
                items[whichitem].weight / 10,
                items[whichitem].weight % 10
            );
    }   }
    if (items[whichitem].dice || items[whichitem].adds)
    {   aprintf(" (%dd+%d)", items[whichitem].dice, items[whichitem].adds);
    }
    if (items[whichitem].hits)
    {   aprintf(" (%d hits)", items[whichitem].hits);
    }
    if (items[whichitem].range)
    {   aprintf(" (%d')", items[whichitem].range);
    }
    if (items[whichitem].str || items[whichitem].dex)
    {   aprintf(" (%d ST, %d DEX)", items[whichitem].str, items[whichitem].dex);
    }
    aprintf("\n");
}

MODULE int calc_attack(int rt, int lt, int both, FLAG you)
{   int diceresult,
        startfrom,
        total = 0;

    spitedamage = 0;

    if (both == EMPTY)
    {   if (!meleeweapon(rt) && !meleeweapon(lt))
        {   if (ability[27].known)
            {   numdice = 4; // %%: probably you should be able punch with your diamond hand and swing a weapon in the other hand, but we don't support that
            } else
            {   numdice =  spell[SPELL_HG].active ? 2 : 1;
            }
            if (ability[150].known)
            {   numdice++;
            }
            numwpnadds  =  0;
            total       += rememberdice(numdice, 0); // barehanded attack
            spitedamage += sixes;
        } else
        {   numdice    =
            numwpnadds =
            startfrom  = 0;
            if (meleeweapon(rt))
            {   numdice     += items[rt].dice;
                numwpnadds  += items[rt].adds;
                diceresult  =  rememberdice(items[rt].dice, startfrom);
                total       += diceresult + items[rt].adds;
                startfrom   += items[rt].dice;
                if (you)
                {   if (spell[SPELL_EH].active > 0)
                    {   total   += diceresult * 2;
                        aprintf("Your Enhance spell tripled the %d hits for right hand dice.\n", diceresult);
                    } elif (spell[SPELL_VB].active > 0 && (items[rt].type == WEAPON_SWORD || items[rt].type == WEAPON_DAGGER))
                    {   total   += diceresult;
                        aprintf("Your Vorpal Blade doubled the %d hits for right hand dice.\n", diceresult);
                }   }
                spitedamage += sixes;
            }
            if (meleeweapon(lt))
            {   numdice     += items[lt].dice;
                numwpnadds  += items[lt].adds;
                diceresult  =  rememberdice(items[lt].dice, startfrom);
                total       += diceresult + items[lt].adds;
             // startfrom   += items[rt].dice;
                if (you)
                {   if (spell[SPELL_EH].active > 0)
                    {   total   += diceresult * 2;
                        aprintf("Your Enhance spell tripled the %d hits for left hand dice.\n", diceresult);
                    } elif (spell[SPELL_VB].active > 0 && (items[rt].type == WEAPON_SWORD || items[rt].type == WEAPON_DAGGER))
                    {   total   += diceresult;
                        aprintf("Your Vorpal Blade doubled the %d hits for left hand dice.\n", diceresult);
                }   }
                spitedamage += sixes;
    }   }   }
    else
    {   if (meleeweapon(both))
        {   numdice    =  items[both].dice;
            numwpnadds =  items[both].adds;
            diceresult =  rememberdice(items[both].dice, 0);
            total      += diceresult + items[both].adds;
            if (you)
            {   if (spell[SPELL_EH].active > 0)
                {   total   += diceresult * 2;
                    aprintf("Your Enhance spell tripled the %d hits for both hands dice.\n", diceresult);
                } elif (spell[SPELL_VB].active > 0 && (items[rt].type == WEAPON_SWORD || items[rt].type == WEAPON_DAGGER))
                {   total   += diceresult;
                    aprintf("Your Vorpal Blade doubled the %d hits for both hands dice.\n", diceresult);
            }   }
            spitedamage = sixes;
        } else
        {   numdice     =  ability[123].known ? 3 : 1;
            numwpnadds  =  0;
            total       += rememberdice(numdice, 0); // barehanded attack
            spitedamage =  sixes;
    }   }

    if (!spite)
    {   spitedamage = 0;
    }
    return total;
}

MODULE FLAG meleeweapon(int whichitem)
{   if
    (   whichitem == EMPTY
     || (items[whichitem].dice == 0 && items[whichitem].adds == 0)
     || items[whichitem].type == WEAPON_BOW
     || items[whichitem].type == WEAPON_XBOW
     || items[whichitem].type == WEAPON_SLING
     || items[whichitem].type == WEAPON_THROWN
     || items[whichitem].type == WEAPON_GUNNE
    )
    {   return FALSE;
    } else
    {   return TRUE;
}   }

MODULE FLAG showornot(int whichitem, TEXT whichletter)
{   switch (whichletter)
    {
    case '1':
        if
        (   items[whichitem].type >= FIRSTWEAPON
         && items[whichitem].type <= LASTWEAPON
         && items[whichitem].hands == 1
         && (   items[whichitem].range == 0
             || items[whichitem].type == WEAPON_DAGGER
             || items[whichitem].type == WEAPON_SPEAR
        )   )
        {   return TRUE;
        }
    acase '2':
        if
        (   items[whichitem].type >= FIRSTWEAPON
         && items[whichitem].type <= LASTWEAPON
         && items[whichitem].hands == 2
         && items[whichitem].range == 0
        )
        {   return TRUE;
        }
    acase 'A': // all armour
        if
        (   items[whichitem].type == ARMOUR_COMPLETE
         || items[whichitem].type == ARMOUR_HEAD
         || items[whichitem].type == ARMOUR_ARMS
         || items[whichitem].type == ARMOUR_CHEST
         || items[whichitem].type == ARMOUR_LEGS
        )
        {   return TRUE;
        }
    acase 'C':
        if (items[whichitem].type == ARMOUR_CHEST)
        {   return TRUE;
        }
    acase 'H':
        if (items[whichitem].type == ARMOUR_HEAD)
        {   return TRUE;
        }
    acase 'L':
        if (items[whichitem].type == ARMOUR_LEGS)
        {   return TRUE;
        }
    acase 'M':
        if
        (   items[whichitem].type == NONWEAPON
         || items[whichitem].type == POTION
         || items[whichitem].type == RING
         || items[whichitem].type == SLAVE
         || items[whichitem].type == POISON
        )
        {   return TRUE;
        }
    acase 'J':
        if (items[whichitem].type == JEWEL)
        {   return TRUE;
        }
    acase 'O':
        if
        (   items[whichitem].type == WEAPON_ARROW
         || items[whichitem].type == WEAPON_DART
         || items[whichitem].type == WEAPON_POWDER
         || items[whichitem].type == WEAPON_QUARREL
         || items[whichitem].type == WEAPON_STONE
        )
        {   return TRUE;
        }
    acase 'P':
        if (items[whichitem].type == ARMOUR_COMPLETE)
        {   return TRUE;
        }
    acase 'R':
        if
        (   items[whichitem].type >= FIRSTWEAPON
         && items[whichitem].type <= LASTWEAPON
         && items[whichitem].range != 0
        )
        {   return TRUE;
        }
    acase 'S':
        if (items[whichitem].type == SHIELD)
        {   return TRUE;
        }
    acase 'W': // all weapons
        if
        (   items[whichitem].type >= FIRSTWEAPON
         && items[whichitem].type <= LASTWEAPON
        )
        {   return TRUE;
        }
    acase 'Z': // arms
        if (items[whichitem].type == ARMOUR_ARMS)
        {   return TRUE;
    }   }

    return FALSE;
}

MODULE void saylight(void)
{   aprintf("³Light source:    ¢");

    switch (lightsource())
    {
    case LIGHT_TORCH:
        aprintf("Normal torch\n");
    acase LIGHT_LANTERN:
        aprintf("Lantern\n");
    acase LIGHT_CRYSTAL:
        aprintf("Crystal\n");
    acase LIGHT_CE:
        if (spell[SPELL_CE].active > 0)
        {   aprintf("Cateyes spell (for next %d minutes)\n", spell[SPELL_CE].active);
        } else
        {   aprintf("Cateyes spell (indefinitely)\n");
        }
    acase LIGHT_WO:
        if (spell[SPELL_WO].active > 0)
        {   aprintf("Will-o-wisp or Sparkler spell (for next %d minutes)\n", spell[SPELL_WO].active);
        } else
        {   aprintf("Will-o-wisp or Sparkler spell (indefinitely)\n");
        }
    acase LIGHT_UWTORCH:
        aprintf("Underwater torch\n");
    acase LIGHT_NONE:
        aprintf("None\n");
}   }

MODULE FLAG askitem(int which)
{   PERSIST TEXT promptstring[256 + 1];

    showitempic(which);

    if (items[which].dice || items[which].adds)
    {   aprintf
        (   "%s gets %d dice and %d adds.\n",
            items[which].name,
            items[which].dice,
            items[which].adds
        );
    }
    if (items[which].hits)
    {   aprintf
        (   "%s can take %d hits.\n",
            items[which].name,
            items[which].hits
        );
    }

    if (!droppable(which))
    {   sprintf
        (   promptstring,
            "You must take %s (%d cp, %d.%d#)!",
            items[which].name,
            items[which].cp,
            items[which].weight / 10,
            items[which].weight % 10
        );
        return TRUE;
    } // implied else

    if (items[which].cp % 100 == 0)
    {   sprintf
        (   promptstring,
            "Do you want %s (%d gp, %d.%d#)",
            items[which].name,
            items[which].cp / 100,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } elif (items[which].cp % 10 == 0)
    {   sprintf
        (   promptstring,
            "Do you want %s (%d sp, %d.%d#)",
            items[which].name,
            items[which].cp / 10,
            items[which].weight / 10,
            items[which].weight % 10
        );
    } else
    {   sprintf
        (   promptstring,
            "Do you want %s (%d cp, %d.%d#)",
            items[which].name,
            items[which].cp,
            items[which].weight / 10,
            items[which].weight % 10
        );
    }

    return (FLAG) getyn(promptstring);
}

MODULE FLAG askitems(int which, int amount)
{   PERSIST   TEXT promptstring[256 + 1];
    TRANSIENT int  cost;

    if (amount == 0)
    {   return FALSE;
    } elif (amount == 1)
    {   return askitem(which);
    }

    showitempic(which);

    if (items[which].dice || items[which].adds)
    {   aprintf
        (   "%s(s) get %d dice and %d adds each.\n",
            items[which].name,
            items[which].dice,
            items[which].adds
        );
    }
    if (items[which].hits)
    {   aprintf
        (   "%s(s) can take %d hits each.\n",
            items[which].name,
            items[which].hits
        );
    }

    cost = items[which].cp * amount;
    if (cost % 100 == 0)
    {   sprintf
        (   promptstring,
            "Do you want %d %s(s) (%d gp total, %d.%d# total)",
            amount,
            items[which].name,
            cost / 100,
            (items[which].weight * amount) /  10,
            (items[which].weight * amount) %  10
        );
    } elif (cost % 10 == 0)
    {   sprintf
        (   promptstring,
            "Do you want %d %s(s) (%d sp total, %d.%d# total)",
            amount,
            items[which].name,
            cost / 10,
            (items[which].weight * amount) /  10,
            (items[which].weight * amount) %  10
        );
    } else
    {   sprintf
        (   promptstring,
            "Do you want %d %s(s) (%d cp total, %d.%d# total)",
            amount,
            items[which].name,
            cost,
            (items[which].weight * amount) / 10,
            (items[which].weight * amount) % 10
        );
    }

    return (FLAG) getyn(promptstring);
}

EXPORT FLAG shot(int range, int size, FLAG doubled)
{   int  needed = 0; // initialized to avoid a spurious SAS/C optimizer warning
    FLAG ok;

    switch (range)
    {
    case  RANGE_POINTBLANK: needed = 1;
    acase RANGE_NEAR:       needed = 2;
    acase RANGE_FAR:        needed = 3;
    acase RANGE_EXTREME:    needed = 4;
 // adefault:               assert(0);
    }
    switch (size)
    {
    case  SIZE_TINY:        needed *= 5;
    acase SIZE_VSMALL:      needed *= 4;
    acase SIZE_SMALL:       needed *= 3;
    acase SIZE_LARGE:       needed *= 2;
 // acase SIZE_HUGE:        needed *= 1;
    }

    aprintf
    (   "Attempting to shoot a %s target at %s range with %s...\n",
        sizestring[size],
        rangestring[range],
        items[missileweapon].name
    );

    if (missileweapon >= 782 && missileweapon <= 785) // rifles
    {   if (range == RANGE_NEAR) // %%: we assume this is what they mean by "medium range"
        {   needed--;
        } elif (range == RANGE_FAR)
        {   needed -= 2;
    }   }

    if (doubled)
    {   needed *= 2;
    }

    if (missileweapon == 949)
    {   ok = saved(needed, dex + dice(2));
    } else
    {   ok = saved(needed, dex);
    }
    if (exploded && items[missileweapon].type == WEAPON_GUNNE)
    /* %%: It's ambiguous about whether explosion-detection is a separate
    roll or part of the main roll (we assume it's part of the main roll). */
    {   aprintf("%s exploded in your hand!\n", items[missileweapon].name);
        good_takehits
        (   dice(items[missileweapon].dice)
          + items[missileweapon].adds
          + calc_missileadds(st, lk, dex),
            TRUE
        ); // %%: Does armour help? We assume so.
        ok = FALSE;
    }

    return ok;
}

EXPORT void manualshowpic(STRPTR thepathname, STRPTR newtitlestring)
{   TEXT newimagename[MAX_PATH + 1];

    if (gfx >= 1)
    {
#ifdef WIN32
        sprintf
        (   newimagename,
            thepathname,
            ProgDir
        );
#endif
#ifdef AMIGA
        strcpy
        (   newimagename,
            thepathname
        );
#endif
        if (stricmp(imagename, newimagename) && Exists(newimagename))
        {   close_gfx(TRUE);
            strcpy(imagename, newimagename);
            strcpy(pictitle, newtitlestring);
            open_gfx();
}   }   }

EXPORT void autoshowpic(void)
{   TRANSIENT int  i;
    TRANSIENT TEXT newimagename[MAX_PATH + 1];
    PERSIST   int  numshown = 0;

    if (gfx >= 1 && pix[room][0] != EOS)
    {
#ifdef WIN32
        sprintf
        (   newimagename,
            "%s\\Images\\%s\\%s.gif",
            ProgDir,
            moduleinfo[module].name,
            pix[room]
        );
#endif
#ifdef AMIGA
        sprintf
        (   newimagename,
            "PROGDIR:Images/%s/%s.gif",
            moduleinfo[module].name,
            pix[room]
        );
#endif
        sprintf(pictitle, "%s%d", moduleinfo[module].name, room);
    } elif (gfx >= 2)
    {   if (numshown >= MISCPIX)
        {   numshown = 0;
            for (i = 0; i < MISCPIX; i++)
            {   shown[i] = FALSE;
        }   }
        do
        {   i = rand() % MISCPIX;
        } while (shown[i]);
        shown[i] = TRUE;
        numshown++;

#ifdef WIN32
        sprintf
        (   newimagename,
            "%s\\Images\\misc\\%02d.gif",
            ProgDir,
            i + 1
        );
#endif
#ifdef AMIGA
        sprintf
        (   newimagename,
            "PROGDIR:Images/misc/%02d.gif",
            i + 1
        );
#endif
        sprintf(pictitle, "Incidental #%d", i + 1);
    }

    if (stricmp(imagename, newimagename) && Exists(newimagename))
    {   close_gfx(TRUE);
        strcpy(imagename, newimagename);
        open_gfx();
}   }

EXPORT void showitempic(int whichitem)
{   TEXT newimagename[MAX_PATH + 1];

    if (gfx < 1)
    {   return;
    }

    strcpy(oldpictitle, pictitle);
    strcpy(pictitle, items[whichitem].name); // must precede the code below
    if     (whichitem >=  91 && whichitem <= 109)
    {   whichitem =  90; // self-bow
    } elif (whichitem == 111 || whichitem == 112)
    {   whichitem = 110; // longbow
    } elif (whichitem == 127)
    {   whichitem = 126; // caltrop
    }

#ifdef WIN32
    sprintf
    (   newimagename,
        "%s\\Images\\weapons\\%d.gif",
        ProgDir,
        whichitem
    );
#endif
#ifdef AMIGA
    sprintf
    (   newimagename,
        "PROGDIR:Images/weapons/%d.gif",
        whichitem
    );
#endif

    if (stricmp(imagename, newimagename) && Exists(newimagename))
    {   close_gfx(TRUE);
        strcpy(imagename, newimagename);
        open_gfx();
    } else
    {   strcpy(pictitle, oldpictitle);
}   }

MODULE void showracespic(void)
{   TEXT newimagename[MAX_PATH + 1];

    if (gfx < 1)
    {   return;
    }

    strcpy(oldpictitle, pictitle);
    strcpy(pictitle, "Choose Race"); // must precede the code below

#ifdef WIN32
    sprintf
    (   newimagename,
        "%s\\Images\\races.gif",
        ProgDir
    );
#endif
#ifdef AMIGA
    strcpy(newimagename, "PROGDIR:Images/races.gif");
#endif

    if (stricmp(imagename, newimagename) && Exists(newimagename))
    {   close_gfx(TRUE);
        strcpy(imagename, newimagename);
        open_gfx();
    } else
    {   strcpy(pictitle, oldpictitle);
}   }

MODULE FLAG eligible(int whichmodule)
{   // assert(whichmodule != MODULE_RB);

    if
    (   whichmodule != MODULE_AK
     && whichmodule != MODULE_EL
     && whichmodule != MODULE_HH
     && moduledone[whichmodule]
    )
    {   aprintf("%s has already completed that module!\n", name);
        return FALSE;
    }

    switch (whichmodule)
    {
    case MODULE_AB:
        aprintf("AB entry requirements: Character must be dead.\n");
        return FALSE;
    acase MODULE_AS:
        if (!(level <= 8 && calc_personaladds(max_st, lk, dex) <= 33))
        {   aprintf("AS entry requirements: Level of 8 or below. Personal adds of 33 or below.\n");
            return FALSE;
        }
    acase MODULE_BF:
        if (!(calc_personaladds(max_st, lk, dex) <= 15))
        {   aprintf("BF entry requirements: Personal adds of 15 or below.\n");
            return FALSE;
        }
    acase MODULE_BC:
        if (!(level <= 1 && class == WARRIOR))
        {   aprintf("BC entry requirements: Level of 1. Class of warrior.\n");
            return FALSE;
        }
    acase MODULE_CD:
        if
        (  !(   level                              <=  4
             && calc_personaladds(max_st, lk, dex) <= 80
             && height                             >= 36
             && height                             <= 90
             && race                               != TROLL
             && race                               != OGRE
        )   )
        {   aprintf("CD entry requirements: Level of 4 or below. Personal adds of 80 or below. Height of 36\"-90\". No ogres or trolls.\n");
            return FALSE;
        }
    acase MODULE_CA:
        if (!(calc_personaladds(max_st, lk, dex) <= 72))
        {   aprintf("CA entry requirements: Personal adds of 72 or below.\n");
            return FALSE;
        }
    acase MODULE_CI:
        if (!(level <= 4 && calc_personaladds(max_st, lk, dex) <= 70))
        {   aprintf("CI entry requirements: Level of 4 or below. Personal adds of 70 or below.\n");
            return FALSE;
        }
    acase MODULE_CT:
        if (!(calc_personaladds(max_st, lk, dex) <= 275 && races[race].humanoid))
        {   aprintf("CT entry requirements: Personal adds of 275 or below. Humanoid.\n");
            return FALSE;
        }
    acase MODULE_DD:
        if (!(level <= 3 && calc_personaladds(max_st, lk, dex) <= 90))
        {   aprintf("DD entry requirements: Level of 3 or below. Personal adds of 90 or below.\n");
            return FALSE;
        }
    acase MODULE_DT:
        if (calc_personaladds(max_st, lk, dex) < 10 || calc_personaladds(max_st, lk, dex) > 75)
        {   aprintf("DT entry requirements: Personal adds of 10-75.\n");
            return FALSE;
        }
    acase MODULE_DE:
        if (!(level <= 5 && calc_personaladds(max_st, lk, dex) <= 70 && height <= 84))
        {   aprintf("DE entry requirements: Level of 5 or below. Personal adds of 70 or below. Height of 7' or less.\n");
            return FALSE;
        }
    acase MODULE_EL:
        if (!(calc_personaladds(max_st, lk, dex) <= 60))
        {   aprintf("EL entry requirements: Personal adds of 60 or below.\n");
            return FALSE;
        }
    acase MODULE_GK:
        if (!(calc_personaladds(max_st, lk, dex) <= 110))
        {   aprintf("GK entry requirements: Personal adds of 110 or below.\n");
            return FALSE;
        }
    acase MODULE_GL:
        if (!(level <= 1 && height <= 72))
        {   aprintf("GL entry requirements: Level of 1. Height of 6' or less.\n");
            return FALSE;
        }
    acase MODULE_HH:
        if (!(height <= 1200))
        {   aprintf("HH entry requirements: Height of 100' or less.\n");
            return FALSE;
        }
    acase MODULE_LA:
        if (!(level <= 2 && class == WARRIOR && race == HUMAN))
        {   aprintf("LA entry requirements: Level of 2 or below. Class of warrior. Race of human.\n");
            return FALSE;
        }
    acase MODULE_MW:
        if (!(calc_personaladds(max_st, lk, dex) <= 110))
        {   aprintf("MW entry requirements: Personal adds of 110 or below.\n");
            return FALSE;
        }
    acase MODULE_ND:
        if
        (  !(   level <=  2
             && (race == DWARF || race == ELF || race == WHITEHOBBIT || race == HUMAN)
             && class == WARRIOR
        )   ) // these requirements are only mentioned in the FB version
        {   aprintf("ND entry requirements: Level of 2 or below. Race of dwarf/elf/hobbit/human. Class of warrior.\n");
            return FALSE;
        }
    acase MODULE_NS:
        if (level > 3 || class != WIZARD || calc_personaladds(max_st, lk, dex) > 30)
        {   aprintf("NS entry requirements: Level of 3 or below. Class of wizard. Personal adds of 30 or below.\n");
            return FALSE;
        }
    acase MODULE_OK:
        if (!(level <= 12))
        {   aprintf("OK entry requirements: Level of 12 or below.\n");
            return FALSE;
        }
    acase MODULE_RC:
        if (!(calc_personaladds(max_st, lk, dex) <= 60 && races[race].humanoid))
        {   aprintf("RC entry requirements: Personal adds of 60 or below. Humanoid.\n");
            return FALSE;
        }
    acase MODULE_SM:
        if
        (  !(   calc_personaladds(max_st, lk, dex) <= 45
             && (race == HUMAN || race == DWARF || race == ELF || race == WHITEHOBBIT || race == FAIRY || race == LEPRECHAUN)
        )   )
        {   aprintf("SM entry requirements: Personal adds of 45 or below. Race of human/dwarf/elf/hobbit/fairy/leprechaun.\n");
            return FALSE;
        }
    acase MODULE_SO:
        if (!(level <= 7 && calc_personaladds(max_st, lk, dex) <= 425 && height <= 120 && races[race].humanoid))
        {   aprintf("SO entry requirements: Level of 7 or below. Personal adds of 425 or below. Height of 10' or less. Humanoid.\n");
            return FALSE;
        }
    acase MODULE_OS:
        if (!(level <= 3 && class == WIZARD))
        {   aprintf("OS entry requirements: Level of 3 or below. Class of wizard.\n");
            return FALSE;
        }
    acase MODULE_SH:
        if (!(level <= 3))
        {   aprintf("SH entry requirements: Level of 3 or below.\n");
            return FALSE;
        }
    acase MODULE_TC:
        if (0) // (!(level <= 2))
        {   aprintf("TC entry requirements: Level of 2 or below.\n");
            return FALSE;
        }
    acase MODULE_WW:
        if (!(level <= 2))
        {   aprintf("WW entry requirements: Level of 2 or below.\n");
            return FALSE;
        }
    acase MODULE_WC:
        if (level > 3 || class != WIZARD || calc_personaladds(max_st, lk, dex) > 30)
        {   aprintf("WC entry requirements: Level of 3 or below. Class of wizard. Personal adds of 30 or below.\n");
            return FALSE;
    }   }

    return TRUE;
}

MODULE FLAG sure(int whichmodule)
{   switch (whichmodule)
    {
    case MODULE_AK:
        if (getyn("Visit bank first (because you may lose all your possessions)?"))
        {   bank();
        }
    acase MODULE_CD:
    case MODULE_IC:
    case MODULE_ND:
        if (getyn("Visit bank first (because you will lose all your possessions)?"))
        {   bank();
    }   }

    return TRUE;
}

MODULE void extendspell(int whichspell, int spellpower, int extend)
{   spell[whichspell].active += extend;
    spell[whichspell].power  =  spellpower;
    aprintf
    (   "%s will be in effect at %dx normal power for %d minutes.\n",
        spell[whichspell].corginame,
        spell[whichspell].power,
        spell[whichspell].active
    );
}

MODULE void hands(void)
{   TEXT letter;

    for (;;)
    {   showhands();
        letter = getletter("øB¢oth/øL¢eft/øR¢ight/øD¢one", "BLRD", "Both", "Left", "Right", "Done", "", "", "", "", 'D');
        switch (letter)
        {
        case 'D':
            return;
        acase 'B':
            bothhands();
        acase 'L':
            lefthand();
        acase 'R':
            righthand();
}   }   }

MODULE int stneeded_armour(void)
{   int stneeded;

    if (!wpnreq)
    {   return 0;
    }

    if (armour != EMPTY)
    {   stneeded = items[armour].str;
    } else
    {   stneeded = 0;
        if (head != EMPTY)
        {   stneeded += items[head ].str;
        }
        if (arms != EMPTY)
        {   stneeded += items[arms ].str;
        }
        if (chest != EMPTY)
        {   stneeded += items[chest].str;
        }
        if (legs != EMPTY)
        {   stneeded += items[legs ].str;
    }   }
    if (rt != EMPTY && items[rt].type == SHIELD)
    {   stneeded += items[rt].str;
    }
    if (lt != EMPTY && items[lt].type == SHIELD)
    {   stneeded += items[lt].str;
    }

    return stneeded;
}

MODULE int stneeded_weapons(void)
{   int stneeded = 0;

    if (!wpnreq)
    {   return 0;
    }

    if (both == EMPTY)
    {   if (rt != EMPTY && items[rt].type != SHIELD) stneeded += items[rt].str;
        if (lt != EMPTY && items[lt].type != SHIELD) stneeded += items[lt].str;
    } else
    {   // assert(items[both].type != SHIELD); (there are no 2-handed shields)
        stneeded += items[both].str;
    }

    return stneeded;
}

MODULE int dexneeded_weapons(void)
{   int dexneeded = 0;

    if (!wpnreq)
    {   return 0;
    }

    if (both == EMPTY)
    {   if (rt != EMPTY) dexneeded += items[rt].dex;
        if (lt != EMPTY) dexneeded += items[lt].dex;
    } else
    {   dexneeded += items[both].dex;
    }

    return dexneeded;
}

EXPORT int divide_roundup(int value1, int value2)
{   // assert(value2 != 0);

    if (value1 % value2)
    {   return (value1 / value2) + 1;
    } else
    {   return  value1 / value2;
}   }

EXPORT FLAG alive(int whichnpc)
{   if (npc[whichnpc].mr || npc[whichnpc].con)
    {   return TRUE;
    }
    return FALSE;
}

MODULE void givespells(void)
{   int i;

    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].level >= 1 && spell[i].level <= level)
        {   spell[i].known = TRUE;
}   }   }

MODULE void open_logfile(void)
{   // assert(!LogfileHandle);

    if ((LogfileHandle = fopen("TNT.LOG", "a")))
    {   aprintf("Opened TNT.LOG for appending.\n");
    } else
    {   logfile = FALSE;
        aprintf("ðCan't open TNT.LOG for appending!\n");
}   }

MODULE void close_logfile(void)
{   if (LogfileHandle)
    {   aprintf("Closed TNT.LOG.\n");
        fclose(LogfileHandle);
        LogfileHandle = NULL;
}   }

MODULE int fuzzystrcmp(STRPTR s, STRPTR t)
{   // for all i and j, d[i][j] will hold the Levenshtein distance between
    // the first i characters of s and the first j characters of t;
    // note that d has (m + 1) * (n + 1) values.

    PERSIST int cost,
                d[80 + 1][80 + 1],
                deletion,
                i, j,
                insertion,
                m, n,
                substitution; // all PERSISTent for speed

    m = strlen(s);
    n = strlen(t);
    if (m > 80 || n > 80)
    {   return 255;
    }
    s--;
    t--;

    for (i = 1; i <= m; i++)
    {   d[i][0] = i; // the distance of any first string to an empty second string
    }
    for (j = 1; j <= n; j++)
    {   d[0][j] = j; // the distance of any second string to an empty first string
    }

    for (j = 1; j <= n; j++)
    {   for (i = 1; i <= m; i++)
        {   if (toupper(s[i]) == toupper(t[j]))
            {   cost         = 0;
            } else
            {   cost         = 1;
            }
            deletion     = d[i - 1][j    ] + 1;
            insertion    = d[i    ][j - 1] + 1;
            substitution = d[i - 1][j - 1] + cost;
            if (deletion <= insertion && deletion <= substitution)
            {   d[i][j] = deletion;
            } elif (insertion <= deletion && insertion <= substitution)
            {   d[i][j] = insertion;
            } else
            {   d[i][j] = substitution;
            }
            if
            (   i > 1
             && j > 1
             && toupper(s[i    ]) == toupper(t[j - 1])
             && toupper(s[i - 1]) == toupper(t[j    ])
             && d[i][j]  >  d[i - 2][j - 2] + cost
            )
            {   d[i][j]  =  d[i - 2][j - 2] + cost; // transposition
    }   }   }

    return d[m][n];
}

MODULE void clear_man(void)
{   int i;

    gotman = FALSE;

    st = max_st = iq = lk = con = max_con = dex = chr = spd = 0;
    module = MODULE_RB;
    room = minutes = bankcp = 0;
    level  = 1;
    xp     = 0;
    rt     =
    lt     =
    both   =
    armour =
    arms   =
    legs   =
    head   =
    chest  = EMPTY;
    ak_fights = ak_won = 0;
    mount  = -1;

    for (i = 0; i < ABILITIES; i++)
    {   ability[i].known = 0;
        ability[i].st    =
        ability[i].iq    =
        ability[i].lk    =
        ability[i].con   =
        ability[i].dex   =
        ability[i].chr   =
        ability[i].spd   = 0;
    }
    ability[88].known = 1;
    for (i = 0; i < SPELLS; i++)
    {   spell[i].known  = FALSE;
        spell[i].active = 0;
    }
    for (i = 0; i < LANGUAGES; i++)
    {   language[i].fluency = 0;
    }
    set_language(LANG_COMMON, 2); // Common
    for (i = 0; i < ITEMS; i++)
    {   items[i].owned  =
        items[i].banked = 0;
        items[i].inuse  = FALSE;
        items[i].poisontype = EMPTY;
        items[i].poisondoses =
        items[i].charges = 0;
    }

    gp = sp = cp = 0;

    for (i = 0; i < MODULES; i++)
    {   moduledone[i] = FALSE;
    }
    for (i = 0; i < RACES; i++)
    {   killcount[i] = 0;
    }

    // sex, height, weight, class, race, name aren't changed
}

EXPORT void help_update(void)
{   TRANSIENT double             oldver,
                                 newver;
    TRANSIENT STRPTR             message;
    TRANSIENT int                hSocket,
                                 i, j,
                                 length;
    TRANSIENT char               ip[15 + 1]; // enough for "208.115.246.164"
    TRANSIENT struct sockaddr_in INetSocketAddr;
    TRANSIENT struct hostent*    HostAddr;
    TRANSIENT struct in_addr**   addr_list;
    PERSIST   TEXT               replystring[1000]; // PERSISTent so as not to blow the stack

#ifdef AMIGA
    // assert(SocketBase);
#endif

    busypointer();

    if ((HostAddr = gethostbyname("amigan.1emu.net")))
    {   // Cast the h_addr_list to in_addr, since h_addr_list also has the IP address in long format only
        addr_list = (struct in_addr**) HostAddr->h_addr_list;
        for (i = 0; addr_list[i] != NULL; i++)
        {   strcpy(ip, (char*) inet_ntoa(*addr_list[i]));
    }   }
    else
    {   strcpy(ip, "208.115.246.164");
    }

#ifdef VERBOSE
    aprintf("Checking for update at %s...\n", ip);
#endif

    hSocket = (int) socket(AF_INET, SOCK_STREAM, 0);
    if (hSocket == -1)
    {   normalpointer();
        aprintf("ðSocket allocation failed!\n");
        enterkey(TRUE);
        return;
    }

    INetSocketAddr.sin_family      = AF_INET;
#ifdef WIN32
    INetSocketAddr.sin_port        = htons(80); // HTTP
#endif
#ifdef AMIGA
    INetSocketAddr.sin_len         = 16; // sizeof(INetSocketAddr)
    INetSocketAddr.sin_port        = 80; // HTTP
#endif
    INetSocketAddr.sin_addr.s_addr = inet_addr(ip);
    for (i = 0; i < 8; i++)
    {   INetSocketAddr.sin_zero[i] = 0;
    }

    if (connect(hSocket, (const struct sockaddr*) &INetSocketAddr, 16) == -1)
    {   DISCARD closesocket(hSocket);
        normalpointer();
        aprintf("ðSocket connection failed!\n");
        enterkey(TRUE);
        return;
    }

#ifdef WIN32
    message = "GET /releases/tnt-ibm.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
#endif
#ifdef AMIGA
    message = "GET /releases/tnt-os3.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
#endif

    if (send(hSocket, message, strlen(message), 0) < 0)
    {   DISCARD closesocket(hSocket);
        normalpointer();
        aprintf("ðCan't send query to server!\n");
        enterkey(TRUE);
        return;
    }

    length = (int) recv(hSocket, replystring, 1000, 0);
    if (length < 0)
    {   DISCARD closesocket(hSocket);
        normalpointer();
        aprintf("ðCan't receive response from server!\n");
        enterkey(TRUE);
        return;
    } else
    {   replystring[length] = EOS;
    }

    // assert(SocketBase);
    // assert(hSocket != -1);
    DISCARD closesocket(hSocket);
    // hSocket = -1;

    length = strlen(replystring);
    i = length - 4;
    j = length;
    while (i >= 0)
    {   if (replystring[i] == CR && replystring[i + 1] == LF && replystring[i + 2] == CR && replystring[i + 3] == LF)
        {   j = i + 4;
            break;
        } else
        {   i--;
    }   }

    if (j == length)
    {   normalpointer();
        aprintf("ðInvalid response from server!\n");
        enterkey(TRUE);
        return;
    } elif (replystring[j] == 239 && replystring[j + 1] == 187 && replystring[j + 2] == 191) // because sometimes it is prepended with "ï²¿"
    {   j += 3; // skip crap
    }

    if (replystring[j] < '0' || replystring[j] > '9')
    {   normalpointer();
        aprintf("ðCan't download update file!\n");
        enterkey(TRUE);
        return;
    }

    normalpointer();

#ifdef WIN32
    oldver = zatof(DECIMALVERSION);
    newver = zatof(&replystring[j]);
#endif
#ifdef AMIGA
    oldver = atof(DECIMALVERSION);
    newver = atof(&replystring[j]);
#endif

#ifdef VERBOSE
    aprintf("V%.2f vs. V%.2f...\n", (float) oldver, (float) newver);
#endif
    if (newver > oldver)
    {   aprintf("T&T %.2f %s is available!\n", (float) newver); // we would prefer eg. 25.0 instead of 25.00
#ifdef WIN32
        openurl("https://archive.org/download/tunnelsandtrolls");
#endif
#ifdef AMIGA
        openurl("http://aminet.net/package/game/role/TunnelsAndTrolls");
#endif
        enterkey(TRUE);
    }
    else
    {   aprintf("You are up to date.\n");
        enterkey(TRUE);
}   }

// For some fucked up reason, sscanf() with %f and atof() crash on
// Windows 7 and 8.1 (at least).
EXPORT double zatof(STRPTR inputstr)
{   int    decpoint = 0,
           i, j,
           length,
           start,
           temp;
    double result   = 0.0;

    if (inputstr[0] == '-')
    {   start = 1;
    } else
    {   start = 0;
    }

    length = strlen(inputstr);
    for (i = start; i < length; i++)
    {   if (inputstr[i] == '.')
        {   decpoint = i;
            break; // for speed
    }   }

    j = 1;
    for (i = decpoint - 1; i >= start; i--)
    {   temp = inputstr[i] - '0';
        result += (double) (temp * j);
        j *= 10;
    }

    j = 10;
    for (i = decpoint + 1; i < length; i++)
    {   if (inputstr[i] < '0' || inputstr[i] > '9') // eg. CR
        {   break;
        }
        temp = inputstr[i] - '0';
        result += (double) (((double) temp) / j);
        j *= 10;
    }

    if (start == 1)
    {   result = -result;
    }

    return result;
}

MODULE void do_letters(void)
{   int i, j,
        length;

    for (i = 0; i < 8; i++)
    {   length = strlen(specialopt_long[i]);
        if (length)
        {   for (j = 0; j < length; j++)
            {   if (isupper(specialopt_long[i][j]))
                {   specialopt_short[i][0] = specialopt_long[i][j];
                    specialopt_short[i][1] = EOS;
                    break; // for speed
}   }   }   }   }

MODULE void showarmour(void)
{   int total1, total2;

    if (armour == EMPTY)
    {   if (head == EMPTY)
        {   aprintf("³Head armour:     ¢None\n");
        } else
        {   aprintf("³Head armour:     ¢%s (%d hits) (%d ST)\n", items[head  ].name, items[head  ].hits, items[head].str);
        }
        if (arms == EMPTY)
        {   aprintf("³Arm armour:      ¢None\n");
        } else
        {   aprintf("³Arm armour:      ¢%s (%d hits) (%d ST)\n", items[arms  ].name, items[arms  ].hits, items[arms].str);
        }
        if (chest == EMPTY)
        {   aprintf("³Chest armour:    ¢None\n");
        } else
        {   aprintf("³Chest armour:    ¢%s (%d hits) (%d ST)\n", items[chest ].name, items[chest ].hits, items[chest].str);
        }
        if (legs == EMPTY)
        {   aprintf("³Leg armour:      ¢None\n");
        } else
        {   aprintf("³Leg armour:      ¢%s (%d hits) (%d ST)\n", items[legs  ].name, items[legs  ].hits, items[legs].str);
        }
        total1 = ((head  == EMPTY) ? 0 : items[head ].hits)
               + ((arms  == EMPTY) ? 0 : items[arms ].hits)
               + ((chest == EMPTY) ? 0 : items[chest].hits)
               + ((legs  == EMPTY) ? 0 : items[legs ].hits);
        total2 = ((head  == EMPTY) ? 0 : items[head ].str )
               + ((arms  == EMPTY) ? 0 : items[arms ].str )
               + ((chest == EMPTY) ? 0 : items[chest].str )
               + ((legs  == EMPTY) ? 0 : items[legs ].str );
        aprintf(    "³Total:           ¢%d hits (%d ST)\n", total1, total2);
    } else
    {   aprintf(    "³Complete armour: ¢%s (%d hits) (%d ST)\n", items[armour].name, items[armour].hits, items[armour].str);
    }
    // Note that it doesn't take class bonuses into account here
}

EXPORT FLAG showansi(int which)
{   int oldwordwrap;

    if (!ansiable || !wantansi)
    {   return FALSE;
    }

    if (userstring[0])
    {   if (ansi[which].cls && which != 2 && row != 0)
        {   enterkey(FALSE);
        }
        if (ansi[which].lf)
        {   printf("%s\n", ANSIBuffer[which]); // not aprintf(), ANSI sequences need to be printed together!
        } else
        {   printf("%s"  , ANSIBuffer[which]); // not aprintf(), ANSI sequences need to be printed together!
        }
        column = 0;
        if (ansi[which].cls)
        {   row = 0;
        } else
        {   domore();
    }   }
    else
    {   if (ansi[which].cls && logconsole)
        {   cls();
        }
        oldwordwrap = wordwrap;
        wordwrap = 0;
        rawmode = TRUE;
        if (ansi[which].lf)
        {   aprintf("%s\n", ansiless[which]);
        } else
        {   aprintf("%s"  , ansiless[which]);
        }
        rawmode = FALSE;
        wordwrap = oldwordwrap;
        aprintf("¢");
    }

    return TRUE;
}

MODULE void domore(void)
{   TRANSIENT int  oldcolour;
    PERSIST   TEXT inputstring[80 + 1];

    if (!reactable && more && row >= more)
    {   row = 0;
        oldcolour = textcolour;
        aprintf("¥");
        printf("-- More (ENTER) --"); // not aprintf()!
        emitcode(oldcolour);
        fflush(stdin);
        update_sheet();
        sheet_chosen = -1;
        if
        (   !gets(inputstring)              // Amiga window close gadget
         || !stricmp(userinput, "###PANIC") // dropped carrier
        )
        {   aprintf("\n");
            quit(EXIT_SUCCESS);
        }
        column = 0;
        setconcolour(oldcolour);
}   }

EXPORT void enterkey(FLAG force)
{   TEXT letter;
    int  tempmodule,
         temproom;

    if (!force && (!ansiable || !wantansi))
    {   show_output();
        return;
    }

    for (;;)
    {
#ifdef ANYKEYACTIONS
        enable_items(TRUE);
        avail_cast    = (moduleinfo[module].castable) ? TRUE : FALSE;
        if (avail_cast)
        {   enable_spells(TRUE);
        }
        avail_armour    =
        avail_drop      =
        avail_get       =
        avail_hands     =
        avail_use       = TRUE;
#endif
        avail_look      =
        avail_options   =
        avail_proceed   =
        avail_view      = TRUE;
        avail_autofight =
        avail_fight     = FALSE;
        do_opts();
        globalrandomable = FALSE;
#ifdef ANYKEYACTIONS
        if (avail_cast)
        {   letter = getletter("Press ENTER to continue", "ACDGHLOPUV", "", "", "", "", "", "", "", "", 'P');
        } else
        {   letter = getletter("Press ENTER to continue", "ADGHLOPUV" , "", "", "", "", "", "", "", "", 'P');
        }
                enable_items(FALSE);
        enable_spells(FALSE);
        avail_armour  =
        avail_cast    =
        avail_drop    =
        avail_get     =
        avail_hands   =
        avail_use     = FALSE;
#else
        letter     = getletter("Press ENTER to continue", "LOPV"      , "", "", "", "", "", "", "", "", 'P');
#endif
        avail_look    =
        avail_options =
        avail_proceed =
        avail_view    = FALSE;
        undo_opts();
        globalrandomable = TRUE;

        switch (letter)
        {
        case 'L':
            look();
        acase 'O':
            temproom   = room;
            tempmodule = module;
            options();
            if (temproom != room || tempmodule != module)
            {   dispose_npcs();
            }
            return;
        acase 'P':
            return;
        acase 'V':
            view_man();
#ifdef ANYKEYACTIONS
        acase 'A':
            weararmour(EMPTY);
        acase 'C':
            castspell(-1, TRUE);
        acase 'D':
            drop_or_get(FALSE, FALSE);
        acase 'G':
            drop_or_get(TRUE, FALSE);
        acase 'H':
            hands();
        acase 'U':
            use(-1);
#endif
}   }   }

EXPORT void wrappass(STRPTR inputbuffer, int wraplength)
{   int i,
        column,
        lastcolumn,
        lastgap;

    if (wraplength == 0)
    {   return;
    }

    i = lastgap = lastcolumn = column = 0;
    for (;;)
    {   switch (inputbuffer[i])
        {
        case LF:
            if (column > wraplength)
            {   if (lastgap)
                {   inputbuffer[lastgap] = LF;
            }   }
            column = lastcolumn = 0;
            lastgap = i;
        acase ' ':
            if (column > wraplength)
            {   if (lastgap)
                {   inputbuffer[lastgap] = LF;
                }
                column -= lastcolumn;
            } else
            {   lastgap = i;
                lastcolumn = column;
            }
            column++;
        acase EOS:
            return;
        adefault:
            if (code_to_colour(inputbuffer[i]) == -1)
            {   column++;
        }   }

        i++;
}   }

#define NAMEAREA 28
MODULE void printiteminfo_table(int whichitem, int percent)
{   TEXT tempstring[33 + 1];
    int  cost;

    if (whichitem == EMPTY)
    {   aprintf("None\n");
        return;
    }

    strcpy(tempstring, items[whichitem].name);
    if (strlen(tempstring) > NAMEAREA)
    {   tempstring[NAMEAREA - 3] =
        tempstring[NAMEAREA - 2] =
        tempstring[NAMEAREA - 1] = '.';
        tempstring[NAMEAREA    ] = EOS;
    }

    aprintf("%3d: ", whichitem + 1);
    // assert(NAMEAREA == 28);
    aprintf("%-28s ", tempstring); // longest is 33 (but we truncate to NAMEAREA)
    cost = items[whichitem].cp * percent / 100;
    if (cost % 100 == 0)
    {   aprintf("%6d g", cost / 100); // highest is 50,000,000 cp (500,000    gp)
    } else
    {   aprintf("%6d c", cost      ); // highest is     20,250 cp (    202.50 gp)
    }
    aprintf
    (   "p %3d.%d# %4d+%4d %4d %4d' %2d %3d\n",
        items[whichitem].weight / 10, // highest weight is 1200 (120.0#)
        items[whichitem].weight % 10,
        items[whichitem].dice,  // highest is 66
        items[whichitem].adds,  // highest is 200
        items[whichitem].hits,  // highest is 200
        items[whichitem].range, // highest is 1760'
        items[whichitem].str,   // highest is 48
        items[whichitem].dex    // highest is 20
    );
}

EXPORT FLAG isedged(int which)
{   switch (items[which].type)
    {
    case WEAPON_SWORD:
    case WEAPON_POLE:
    case WEAPON_SPEAR:
    case WEAPON_DAGGER:
    case WEAPON_ARROW:
    case WEAPON_QUARREL:
    case WEAPON_DART:
        return TRUE;
    case WEAPON_HAFTED:
        if (which >= 34 && which <= 43)
        {   return FALSE;
        }
        return TRUE;
    case WEAPON_THROWN:
        if (which == 121 || which == 122)
        {   return FALSE;
        }
        return TRUE;
    default:
        return FALSE;
}   }

EXPORT void getrank(void)
{   if   (ability[112].known || ability[158].known                      ) rank = "General ";
    elif (ability[108].known                                            ) rank = "Sub-General ";
    elif (ability[111].known                                            ) rank = "Hawk-Colonel ";
    elif (ability[109].known                                            ) rank = "Major ";
    elif (ability[ 74].known || ability[157].known || ability[159].known) rank = "Captain ";
    elif (ability[110].known                                            ) rank = "Sub-Captain ";
    elif (ability[122].known || ability[168].known || ability[167].known) rank = ((sex == FEMALE) ? "Dame " : "Sir ");
    else                                                                  rank = "";
}

EXPORT int getlimit(void)
{   int limit;

    // This function operates with coin weights (0.1#).

    limit = (st * 100) + (items[856].owned * 50);

    if (mount == -1)
    {   ;
    } elif (items[mount].str)
    {   limit += items[mount].str * 100;
    } else
    {   limit += 1000; // assuming ST of 10, based on DT WMT B.7
    }

    return limit;
}

MODULE FLAG usecharge(int whichitem)
{   if (items[whichitem].charges >= 1)
    {   items[whichitem].charges--;
        aprintf("%s now has %d of %d charges left.\n", items[whichitem].name, items[whichitem].charges, items[whichitem].defcharges);
        return TRUE;
    } else
    {   aprintf("%s has no charges left!\n", items[whichitem].name);
        return FALSE;
}   }

MODULE void emitcode(int whichcolour)
{   switch (whichcolour)
    {
    case  TEXTPEN_BLACK:            aprintf("®"); // $AE
    acase TEXTPEN_DARKRED:          aprintf("§"); // $A7
    acase TEXTPEN_DARKGREEN:        aprintf("ç"); // $E7
    acase TEXTPEN_BROWN:            aprintf("¹"); // $B9
    acase TEXTPEN_DARKBLUE:         aprintf("Ø"); // $D8
    acase TEXTPEN_DARKPURPLE:       aprintf("Þ"); // $DE
    acase TEXTPEN_DARKCYAN:         aprintf("¿"); // $BF
    acase TEXTPEN_LIGHTGREY:        aprintf("¶"); // $B6
    acase TEXTPEN_DARKGREY:         aprintf("þ"); // $FE
    acase TEXTPEN_PINK:             aprintf("ð"); // $F0
    acase TEXTPEN_GREEN:            aprintf("³"); // $B3
    acase TEXTPEN_YELLOW:           aprintf("æ"); // $E6
    acase TEXTPEN_BLUE:             aprintf("¥"); // $A5
    acase TEXTPEN_PURPLE:           aprintf("²"); // $B2
    acase TEXTPEN_CYAN:             aprintf("ø"); // $F8
    acase TEXTPEN_WHITE:            aprintf("¢"); // $A2
    acase TEXTPEN_BLACKONDARKCYAN:  aprintf("ü"); // $FC
    acase TEXTPEN_YELLOWONDARKBLUE: aprintf("û"); // $FB
    acase TEXTPEN_BLACKONDARKRED:   aprintf("ý"); // $FD
}   }

EXPORT int code_to_colour(TEXT thechar)
{   switch (thechar)
    {
    case (TEXT) '®': return TEXTPEN_BLACK;
    case (TEXT) '§': return TEXTPEN_DARKRED;
    case (TEXT) 'ç': return TEXTPEN_DARKGREEN;
    case (TEXT) '¹': return TEXTPEN_BROWN;
    case (TEXT) 'Ø': return TEXTPEN_DARKBLUE;
    case (TEXT) 'Þ': return TEXTPEN_DARKPURPLE;
    case (TEXT) '¿': return TEXTPEN_DARKCYAN;
    case (TEXT) '¶': return TEXTPEN_LIGHTGREY;
    case (TEXT) 'þ': return TEXTPEN_DARKGREY;
    case (TEXT) 'ð': return TEXTPEN_PINK;
    case (TEXT) '³': return TEXTPEN_GREEN;
    case (TEXT) 'æ': return TEXTPEN_YELLOW;
    case (TEXT) '¥': return TEXTPEN_BLUE;
    case (TEXT) '²': return TEXTPEN_PURPLE;
    case (TEXT) 'ø': return TEXTPEN_CYAN;
    case (TEXT) '¢': return TEXTPEN_WHITE;
    case (TEXT) 'ü': return TEXTPEN_BLACKONDARKCYAN;
    case (TEXT) 'û': return TEXTPEN_YELLOWONDARKBLUE;
    case (TEXT) 'ý': return TEXTPEN_BLACKONDARKRED;
    default:         return -1;
}   }

EXPORT void zstrncpy(char* to, const char* from, size_t n)
{   DISCARD strncpy(to, from, n);
    to[n] = EOS;
}

MODULE FLAG project_load(void)
{   if (asl_load())
    {   if (load_man())
        {   return TRUE;
        } else
        {   aprintf("ðCan't load \"%s\"!\n", name);
    }   }

    return FALSE;
}

MODULE void project_delete(void)
{   if (asl_delete())
    {
#ifdef WIN32
        if (!DeleteFile(ck_filename))
#else
        if (remove(ck_filename))
#endif
        {   aprintf("ðCan't delete \"%s\"!\n", ck_filename);
        } else
        {   aprintf("Deleted \"%s\".\n", ck_filename);
        }
        enterkey(TRUE);
}   }

MODULE void look(void)
{   int i, j;

    aprintf
    (   "¢%s§%d¢ (%02d:%02d on day %d):\n",
        moduleinfo[module].name,
        room,
        HOURNOW,
        minutes % 60,
        (minutes / ONE_DAY) + 1
    );

    if (module == MODULE_RB)
    {   aprintf("¹You are in the city.¢\n");
    } else
    {   aprintf("¹%s\n\n¢", descs[module][room]);
    }

    j = 0;
    for (i = 0; i < ITEMS; i++)
    {   j += items[i].here;
    }
    if (gp_here || sp_here || cp_here || j)
    {   aprintf("On the floor are %d gp, %d sp, %d cp and %d item(s).\n", gp_here, sp_here, cp_here, j);
    }

    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].active)
        {   aprintf
            (   "Your %s spell is active for the next %d minutes.\n",
                spell[i].corginame,
                spell[i].active
            );
}   }   }

MODULE void fight2(void)
{   FLAG done,
         ok;
    int  amount,
         berserktotal,
         count,
         i, j,
         lowerpos,
         lowerval,
      // lowestpos,
         lowestval,
         numattacks = 1,
         pos,
         thisattack,
         thisspite;

    aprintf("Calculating %s's attack(s)...\n", name);
    if (spell[SPELL_SF].active > 0)
    {   numattacks = 2;
    }
    if (spell[SPELL_DE].active > 0)
    {   numattacks *= 2 * spell[SPELL_DE].power;
    }
    if (numattacks != 1)
    {   aprintf("You get %d attacks this round.\n", numattacks);
    }
    good_spitetotal = 0;
    for (i = 0; i < numattacks; i++)
    {   thisattack = calc_attack(rt, lt, both, TRUE) + calc_personaladds(st, lk, dex);
        thisspite  = spitedamage;
        aprintf
        (   "Your %d dice and %d adds generated %d hits.\n",
            numdice,
            numwpnadds + calc_personaladds(st, lk, dex),
            thisattack
        );
        if (thisspite)
        {   aprintf
            (   "You also generated %d spite damage.\n",
                thisspite
            );
        }

        if (ability[116].known && getyn("Breathe flame"))
        {   templose_st(1); // %%: at what point does this loss occur? (ie. before or after calculating adds?)
            thisattack += dice(level);
        }
        if (ability[169].known /* && getyn("Invoke flames") */ )
        {   thisattack += dice(3);
        }

        if (thisattack < 0)
        {   thisattack = 0;
        }
        good_attacktotal += thisattack;
        good_spitetotal  += thisspite;
    }

/* %%: Ambiguous berserking rules:
 Do berserkers lose *all* their adds (including personal adds) or just
  their weapon adds? We assume it is all their adds.
 What is the minimum number of dice needed for berserking (1..3)? "Bare
  berserker hands" implies 1 die is enough, but doubles are impossible
  with 1 die. It says "Characters using 3- (or more) dice weapons may go
  berserk..." but then later says "A 2- (or more) dice fighter...will...
  allow berserk fighting." We assume 2.
 Is any distinction made between left and right hands? We are not making
  any distinction.
 When we lower the second lowest die to match the lowest die, does that
  affect the Combat Point Total? We assume so, and it demonstrates it in
  an example.
 Is berserking per-attack, or just considered with regard to the whole
  round's attack? We assume the latter. */

    if (!berserkable)
    {   if (berserk)
        {   berserk = FALSE;
            aprintf("%s calms down.\n", name);
    }   }
    elif (berserk)
    {   if (st <= 5)
        {   berserk = FALSE;
            aprintf("%s is exhausted.\n", name);
        } elif (numdice >= 2 && iq < 16)
        {   ok = FALSE;
            for (i = 0; i < numdice; i++)
            {   for (j = 0; j < numdice; j++)
                {   if (i != j && therolls[i] == therolls[j])
                    {   ok = TRUE;
                        break; // for speed
            }   }   }
            if (ok)
            {   if (iq <= 8 || getyn("Stay berserk"))
                {   ; // berserk = TRUE;
                } else
                {   berserk = FALSE;
            }   }
            else
            {   // find the lowest
                for (i = 1; i <= 6; i++)
                {   for (j = 0; j < numdice; j++)
                    {   if (i == therolls[j])
                        {   lowestval = i;
                         // lowestpos = j;
                            break; // for speed
                }   }   }
                for (i = lowestval + 1; i <= 6; i++)
                {   for (j = 0; j < numdice; j++)
                    {   if (i == therolls[j])
                        {   lowerval = i;
                            lowerpos = j;
                            break; // for speed
                }   }   }
                aprintf("Lowering die #%d from %d to %d to allow berserking.\n", lowerpos + 1, lowerval, lowestval);
                good_attacktotal -= (lowerval - lowestval);
                therolls[lowerpos] = lowestval;
                if (iq <= 8 || getyn("Stay berserk"))
                {   ; // berserk = TRUE;
                } else
                {   berserk = FALSE;
                    aprintf("%s calms down.\n", name);
        }   }   }
        else
        {   berserk = FALSE;
            aprintf("%s calms down.\n", name);
    }   }
    elif (st > 5)
    {   if (numdice >= 2 && iq < 16)
        {   ok = FALSE;
            for (i = 0; i < numdice; i++)
            {   for (j = 0; j < numdice; j++)
                {   if (i != j && therolls[i] == therolls[j])
                    {   ok = TRUE;
                        break; // for speed
            }   }   }
            if (ok && (iq <= 8 || getyn("Go berserk")))
            {   berserk = TRUE;
                aprintf("%s is going berserk!\n", name);
    }   }   }

    if (berserk)
    {   if (numwpnadds + calc_personaladds(st, lk, dex) >= 1)
        {   aprintf("You lose your %d adds.\n", numwpnadds + calc_personaladds(st, lk, dex));
        } elif (numwpnadds + calc_personaladds(st, lk, dex) <= -1)
        {   aprintf("You lose your %d subtracts.\n", -(numwpnadds + calc_personaladds(st, lk, dex)));
        }
        good_attacktotal -= (numwpnadds + calc_personaladds(st, lk, dex));

        if
        (   both != EMPTY && items[both].type == SHIELD
         || rt   != EMPTY && items[rt  ].type == SHIELD
         || lt   != EMPTY && items[lt  ].type == SHIELD
        )
        {   berserktotal = 5;
            aprintf("You chewed on your shield for 5 points.\n");
        } else
        {   berserktotal = 0;
        }

        do
        {   // zero out any single dice
            for (i = 1; i <= 6; i++)
            {   count = 0;
                for (j = 0; j < numdice; j++)
                {   if (therolls[j] == i)
                    {   count++;
                        pos = j;
                }   }
                if (count == 1)
                {   therolls[pos] = 0;
            }   }

            // reroll the non-single dice and add them to Hit Point Total
            done = TRUE;
            for (i = 0; i < numdice; i++)
            {   if (therolls[i])
                {   done = FALSE;
                    therolls[i] = dice(1);
                    berserktotal += therolls[i];
        }   }   }
        while (!done);

        aprintf("Total bonus of %d from berserking.\n"); // not considering the lack of adds, nor the lowering of a die to make berserking possible
        good_attacktotal += berserktotal;
        templose_st(2);
    }

    usedweapons = TRUE;
    poisoning = EMPTY;
    if (both != EMPTY)
    {   if (items[both].poisondoses)
        {   items[both].poisondoses--;
            poisoning = items[both].poisontype;
    }   }
    elif (lt != EMPTY && rt != EMPTY && items[lt].poisondoses && items[rt].poisondoses && items[lt].poisontype != items[rt].poisontype)
    {   ; // two weapons with different types of poison. We just act for now as if there is no poison
    } else
    {   // what if one weapon is poisoned and the other is not? We just act for now as if both are poisoned
        if (lt != EMPTY)
        {   if (items[lt].poisondoses)
            {   items[lt].poisondoses--;
                poisoning = items[lt].poisontype;
        }   }
        if (rt != EMPTY)
        {   if (items[rt].poisondoses)
            {   items[rt].poisondoses--;
                poisoning = items[rt].poisontype;
    }   }   }

    amount = stneeded_weapons() - st;
    if (amount >= 1)
    {   aprintf("Your weapons were too heavy by %d points.\n", amount);
        if (amount <= st - 1)
        {   templose_st(amount);
        } else
        {   amount -= (st - 1);
            templose_st(st - 1);
            templose_con(amount);
}   }   }

MODULE void resurrect(void)
{   if (max_st  < 1) max_st  = 1;
    if (    iq  < 1)     iq  = 1;
    if (    lk  < 1)     lk  = 1;
    if (max_con < 1) max_con = 1;
    if (    dex < 1)     dex = 1;
    // Zero and negative charismas are allowed
    if (    spd < 1)     spd = 1;

    if (st  < max_st ) st  = max_st;
    if (con < max_con) con = max_con;

    aprintf("Resurrected %s.\n", name);
}
