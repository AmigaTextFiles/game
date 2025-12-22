typedef signed char   COLOUR;   /* 8-bit signed   */
typedef unsigned char SCANCODE; /* 8-bit unsigned */

#define EWINIT
#define EWUNINIT

struct MMD0
{   unsigned long a; // dummy declaration
};

#define EXPORT                /* global (project-scope)                       */

#if defined(__MORPHOS__) || defined(__amigaos4__)
    #define chip
#endif
#ifndef __amigaos4__
    #define ZERO              (BPTR) NULL
#endif
#ifdef __AROS__
    #define USHORT            unsigned short
    #define BASE_PAR_DECL

    struct hostent
    {   char*          h_name;
        char**         h_aliases;
        int            h_addrtype;
        int            h_length;
        char**         h_addr_list;
    };
#endif

#define DEFAULTSET             "PROGDIR:WormWars.lset"
#define DEPTH                      4
#define FONTY                      8
#define HISCOREDISTANCE           16
#define SQUAREX                   12
#define SQUAREY                   12
#define SCREENXPIXEL             640
#define SCREENYPIXEL             512
#define STARTXPIXEL              (83 + xoffset)
#define STARTYPIXEL              (16 + TBSIZE + yoffset)
#define FIELDCENTREXPIXEL  (STARTXPIXEL + ((ENDXPIXEL - STARTXPIXEL) / 2))
#define FIELDCENTREYPIXEL  (STARTYPIXEL + ((ENDYPIXEL - STARTYPIXEL) / 2))
#define INTROTILEX         (FIELDCENTREXPIXEL - 149)
#define INTROTEXTX         (FIELDCENTREXPIXEL - 129)
#define INTROY             (FIELDCENTREYPIXEL -  32)

#define MORERT                   (morphos ? 2 : 0)
#define MOREDN                   (morphos ? 2 : 0)
#define ABOUTDEPTH                 4
#define ABOUTDEPTHMASK          0x0F

#define BGWIDTH                   32 // in pixels
#define BGWORDWIDTH                2 // in words
#define BGHEIGHT                  32 // in pixels
#define SMLBGWIDTH                 8 // in pixels
#define SMLBGWORDWIDTH             1 // in words
#define SMLBGHEIGHT                8 // in pixels
#define BGPLANES                   1

#define CENTREXPIXEL (WindowWidth  / 2)
#define CENTREYPIXEL (WindowHeight / 2)
#define YSTART       (CENTREYPIXEL - 200)

#ifdef __amigaos4__
    #define execver SysBase->lib_Version
    #define execrev SysBase->lib_Revision
#else
    #define execver SysBase->LibNode.lib_Version
    #define execrev SysBase->LibNode.lib_Revision
#endif

/* colours */

#define BLACK      0
#define LIGHTGREY  1 // Ideally white should be the 2nd colour. This
                     // enables the titlebar to render correctly.
#define DARKGREEN  2
#define DARKYELLOW 3
#define MEDIUMGREY 4
#define DARKBLUE   5
#define BLUE       6
#define GREEN      7
#define DARKRED    8
// brown is 9
#define RED       10
#define YELLOW    11
#define DARKGREY  12
#define ORANGE    13
#define PURPLE    14
#define WHITE     15

#define TBSIZE    11 // for Amiga only

// menus

#define INDEX_PROJECT          0
#define INDEX_NEW              1
#define INDEX_OPEN             2
#define INDEX_REVERT           3
// ---                         4
#define INDEX_SAVE             5
#define INDEX_SAVEAS           6
// ---                         7
#define INDEX_PROJECTDELETE    8
// ---                         9
#define INDEX_QUITTITLE       10
#define INDEX_QUITDOS         11
#define INDEX_EDIT            12
#define INDEX_CUT             13
#define INDEX_COPY            14
#define INDEX_PASTE           15
// ---                        16
#define INDEX_ERASE           17
#define INDEX_EDITDELETE      18
#define INDEX_INSERT          19
#define INDEX_APPEND          20
// ---                        21
#define INDEX_CLEARHS         22
#define INDEX_VIEW            23
#define INDEX_PREVIOUS        24
#define INDEX_NEXT            25
// ---                        26
#define INDEX_VIEWPOINTER     27
#define INDEX_VIEWTITLEBAR    28
#define INDEX_SETTINGS        29
#define INDEX_ANIMATIONS      30
#define INDEX_AUTOSAVE        31
#define INDEX_CREATEICONS     32
#define INDEX_ENGRAVEDSQUARES 33
#define INDEX_HELP            34
#define INDEX_CREATURES       35
#define INDEX_OBJECTS         36
#define INDEX_FRUITS          37
// ---                        38
#define INDEX_MANUAL          39
// ---                        40
#define INDEX_UPDATE          41
// ---                        42
#define INDEX_ABOUT           43

#define MN_PROJECT         0
#define MN_EDIT            1
#define MN_VIEW            2
#define MN_SETTINGS        3
#define MN_HELP            4

// project menu
#define IN_NEW             0
#define IN_OPEN            1
#define IN_REVERT          2
// ----------------------- 3
#define IN_SAVE            4
#define IN_SAVEAS          5
// ----------------------- 6
#define IN_PROJECTDELETE   7
// ----------------------- 8
#define IN_QUITTITLE       9
#define IN_QUITDOS        10

// edit menu
#define IN_CUT             0
#define IN_COPY            1
#define IN_PASTE           2
// ----------------------- 3
#define IN_ERASE           4
#define IN_EDITDELETE      5
#define IN_INSERT          6
#define IN_APPEND          7
// ----------------------- 8
#define IN_CLEARHISCORES   9

// view menu
#define IN_PREVIOUS        0
#define IN_NEXT            1
// ----------------------- 2
#define IN_VIEWPOINTER     3
#define IN_VIEWTITLEBAR    4

// settings menu
#define IN_ANIMATIONS      0
#define IN_AUTOSAVE        1
#define IN_CREATEICONS     2
#define IN_ENGRAVEDSQUARES 3

// help menu
#define IN_CREATURES       0
#define IN_OBJECTS         1
#define IN_FRUIT           2
// ----------------------- 3
#define IN_MANUAL          4
// ----------------------- 5
#define IN_UPDATE          6
// ----------------------- 7
#define IN_ABOUT           8

#ifdef __MORPHOS__
    #if EXIT_FAILURE == 1
        #undef  EXIT_FAILURE
        #define EXIT_FAILURE 20
    #endif
#else
    #define EXIT_SUCCESS  0
    #define EXIT_FAILURE 20
#endif

#if defined(__SASC) || defined(__VBCC__)
    #define BASE_PAR_DECL
#endif

#define SOCK_STREAM   1 /* stream socket */
#define AF_INET       2 /* internetwork: UDP, TCP, etc. */

#ifdef __MORPHOS__
    #include <netdb.h>
#else
    typedef unsigned char u_char;
    typedef unsigned int  u_int;
    typedef unsigned long u_long;
    typedef u_long        n_long; /* long as received from the net */

    #if !defined(__amigaos4__) && !defined(__AROS)
        typedef void*         caddr_t;
        #define h_addr h_addr_list[0] // address, for backward compatability
        struct in_addr
        {   ULONG s_addr;
        };
        struct sockaddr
        {   UBYTE sa_len;      /* total length */
            UBYTE sa_family;   /* address family */
            char  sa_data[14]; /* actually longer; address value */
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
        };
        struct msghdr
        {   caddr_t       msg_name;       /* optional address          */
            unsigned int  msg_namelen;    /* size of address           */
            struct iovec* msg_iov;        /* scatter/gather array      */
            unsigned int  msg_iovlen;     /* # elements in msg_iov     */
            caddr_t       msg_control;    /* ancillary data, see below */
            unsigned int  msg_controllen; /* ancillary data buffer len */
            int           msg_flags;      /* flags on received message */
        };

        struct hostent* gethostbyname(const UBYTE* name);
        LONG  recv(LONG s, UBYTE* buf, LONG len, LONG flags); /* V3 */
        LONG  CloseSocket(LONG d);
        LONG  connect(LONG s, const struct sockaddr* name, LONG namelen);
        LONG  send(LONG s, const UBYTE* msg, LONG len, LONG flags);
        LONG  socket(LONG domain, LONG type, LONG protocol);
        LONG  shutdown(LONG s, LONG how);
        char* inet_ntoa(struct in_addr in);
        ULONG inet_addr(char* cp);
        LONG  bind(LONG s, const struct sockaddr* name, LONG namelen);
        LONG  listen(LONG s, LONG backlog);
        LONG  accept(LONG s, struct sockaddr* addr, LONG* addrlen);
        LONG  ioctlsocket(BASE_PAR_DECL LONG d, ULONG request, char* argp);
        LONG  gethostname(STRPTR hostname, LONG size); /* V3 */
    #endif

    #ifndef __amigaos4__
        #pragma libcall SocketBase gethostbyname D2 801
        #pragma libcall SocketBase recv 4E 218004
        #pragma libcall SocketBase CloseSocket 78 001
        #pragma libcall SocketBase connect 36 18003
        #pragma libcall SocketBase send 42 218004
        #pragma libcall SocketBase socket 1E 21003
        #pragma libcall SocketBase shutdown 54 1002
        #pragma libcall SocketBase inet_ntoa AE 001
        #pragma libcall SocketBase inet_addr B4 801
    #endif
#endif
