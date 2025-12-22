/*
**  $VER: openurl.h 6.4 (27.7.2005)
**  Includes Release 6.4
**
**  openurl.library - universal URL display and browser
**  launcher library
**
**  Written by Troels Walsted Hansen <troels@thule.no>
**  Placed in the public domain.
**
**  Developed by:
**  - Alfonso Ranieri <alforan@tin.it>
**  - Stefan Kost <ensonic@sonicpulse.de>
**
*/

#ifndef EXEC_TYPES_H
    #include <exec/types.h>
#endif
#ifndef EXEC_LISTS_H
   #include <exec/lists.h>
#endif
#ifndef EXEC_NODES_H
   #include <exec/nodes.h>
#endif
#ifndef UTILITY_TAGITEM_H
    #include <utility/tagitem.h>
#endif

#if defined(__PPC__)
  #if defined(__GNUC__)
    #pragma pack(2)
  #elif defined(__VBCC__)
    #pragma amiga-align
  #endif
#endif

/**************************************************************************/
/*
** Names
*/

#define OPENURLNAME "openurl.library"
#define OPENURLVER  6
#define OPENURLREV  4

/**************************************************************************/
/*
** Tags
*/

#define URL_Tagbase                  ((int)0x81480000)
#define URL_Show                     (URL_Tagbase +  1)
#define URL_BringToFront             (URL_Tagbase +  2)
#define URL_NewWindow                (URL_Tagbase +  3)
#define URL_Launch                   (URL_Tagbase +  4)
#define URL_PubScreenName            (URL_Tagbase +  5)
#define URL_GetPrefs_Mode            (URL_Tagbase + 20)
#define URL_GetPrefs_FallBack        (URL_Tagbase + 21)
#define URL_SetPrefs_Save            (URL_Tagbase + 30)
#define URL_GetAttr_Version          (URL_Tagbase + 60)
#define URL_GetAttr_Revision         (URL_Tagbase + 61)
#define URL_GetAttr_VerString        (URL_Tagbase + 62)
#define URL_GetAttr_PrefsVer         (URL_Tagbase + 63)

enum
{
    URL_GetPrefs_Mode_Env,
    URL_GetPrefs_Mode_Envarc,
    URL_GetPrefs_Mode_Default,
    URL_GetPrefs_Mode_InUse,
};

/**************************************************************************/

#define REXX_CMD_LEN       64
#define NAME_LEN           32
#define PATH_LEN          256
#define PORT_LEN           32

#define SHOWCMD_LEN       REXX_CMD_LEN
#define TOFRONTCMD_LEN    REXX_CMD_LEN
#define OPENURLCMD_LEN    REXX_CMD_LEN
#define OPENURLWCMD_LEN   REXX_CMD_LEN
#define WRITEMAILCMD_LEN  (REXX_CMD_LEN*2)

/**************************************************************************/
/*
** Version 4 Prefs
*/

#define PREFS_VERSION ((UBYTE) 4)

struct URL_Prefs
{
    UBYTE          up_Version;
    struct MinList up_BrowserList;
    struct MinList up_MailerList;
    struct MinList up_FTPList;
    ULONG          up_Flags;
    ULONG          up_DefShow;
    ULONG          up_DefBringToFront;
    ULONG          up_DefNewWindow;
    ULONG          up_DefLaunch;
};

/* up_Flags */
enum
{
    UPF_ISDEFAULTS  = 1<<0, /* structure contains the default settings */
    UPF_PREPENDHTTP = 1<<1, /* prepend "http://" to URLs w/o scheme */
    UPF_DOMAILTO    = 1<<2, /* mailto: URLs get special treatment */
    UPF_DOFTP       = 1<<3, /* ftp:// URLs get special treatment */
};

/**************************************************************************/
/*
** Common #?_Flags values
*/

enum
{
    UNF_DISABLED = 1<<1,  /* The entry is disabled */
    UNF_NEW      = 1<<16, /* Reserved for OpenURL preferences application */
    UNF_NTALLOC  = 1<<17, /* Reserved for OpenURL preferences application */
};

/**************************************************************************/
/*
** Browsers
*/

struct URL_BrowserNode
{
    struct MinNode ubn_Node;
    ULONG          ubn_Flags;
    UBYTE          ubn_Name[NAME_LEN];
    UBYTE          ubn_Path[PATH_LEN];
    UBYTE          ubn_Port[PORT_LEN];
    UBYTE          ubn_ShowCmd[SHOWCMD_LEN];
    UBYTE          ubn_ToFrontCmd[TOFRONTCMD_LEN];
    UBYTE          ubn_OpenURLCmd[OPENURLCMD_LEN];
    UBYTE          ubn_OpenURLWCmd[OPENURLWCMD_LEN];
};

/**************************************************************************/
/*
** Mailers
*/

struct URL_MailerNode
{
    struct MinNode umn_Node;
    ULONG          umn_Flags;                          /* flags, none defined              */
    UBYTE          umn_Name[NAME_LEN];                 /* name of mailer                   */
    UBYTE          umn_Path[PATH_LEN];                 /* complete path to mailer          */
    UBYTE          umn_Port[PORT_LEN];                 /* mailer arexx port                */
    UBYTE          umn_ShowCmd[SHOWCMD_LEN];           /* command to show/uniconify mailer */
    UBYTE          umn_ToFrontCmd[TOFRONTCMD_LEN];     /* command to bring mailer to front */
    UBYTE          umn_WriteMailCmd[WRITEMAILCMD_LEN]; /* command to write mail            */
};

/**************************************************************************/
/*
** FTPs
*/

struct URL_FTPNode
{
    struct MinNode ufn_Node;
    ULONG          ufn_Flags;                        /* flags, see below                     */
    UBYTE          ufn_Name[NAME_LEN];               /* name of ftp client                   */
    UBYTE          ufn_Path[PATH_LEN];               /* complete path to ftp client          */
    UBYTE          ufn_Port[PORT_LEN];               /* webbrowser arexx port                */
    UBYTE          ufn_ShowCmd[SHOWCMD_LEN];         /* command to show/uniconify ftp client */
    UBYTE          ufn_ToFrontCmd[TOFRONTCMD_LEN];   /* command to bring ftp client to front */
    UBYTE          ufn_OpenURLCmd[OPENURLCMD_LEN];   /* command to open url                  */
    UBYTE          ufn_OpenURLWCmd[OPENURLWCMD_LEN]; /* command to open url in new window    */
};

/* ufn_Flags */
enum
{
    /* If set, ftp:// is removed from the URL */
    UFNF_REMOVEFTP = 1<<0,
};

/**************************************************************************/

#if defined(__PPC__)
  #if defined(__GNUC__)
    #pragma pack()
  #elif defined(__VBCC__)
    #pragma default-align
  #endif
#endif

ULONG             URL_OpenA(STRPTR, struct TagItem *);
struct URL_Prefs* URL_GetPrefsA(struct TagItem *);
void              URL_FreePrefsA(struct URL_Prefs *,struct TagItem *);
ULONG             URL_SetPrefsA(struct URL_Prefs *,struct TagItem *);
ULONG             URL_LaunchPrefsAppA(struct TagItem *);
ULONG             URL_GetAttr(ULONG attr,ULONG *storage);

#ifdef __SASC
ULONG             URL_Open(STRPTR, ...);
struct URL_Prefs* URL_GetPrefs(...);
void              URL_FreePrefs(struct URL_Prefs *,...);
ULONG             URL_SetPrefs(struct URL_Prefs *,...);
ULONG             URL_LaunchPrefsApp(...);

#pragma  libcall OpenURLBase URL_OpenA              01e 9802
// #pragma  libcall OpenURLBase DoFunction             042 801
#pragma  libcall OpenURLBase URL_GetPrefsA          048 801
#pragma  libcall OpenURLBase URL_FreePrefsA         04e 9802
#pragma  libcall OpenURLBase URL_SetPrefsA          054 9802
#pragma  libcall OpenURLBase URL_LaunchPrefsAppA    05a 801
#pragma  libcall OpenURLBase URL_GetAttr            060 8002
#endif

#ifdef __SASC_60
#pragma  tagcall OpenURLBase URL_Open               01e 9802
#pragma  tagcall OpenURLBase URL_GetPrefs           048 801
#pragma  tagcall OpenURLBase URL_FreePrefs          04e 9802
#pragma  tagcall OpenURLBase URL_SetPrefs           054 9802
#pragma  tagcall OpenURLBase URL_LaunchPrefsApp     05a 801
#endif
