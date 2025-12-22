#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#include <intuition/intuition.h>

// Defined by AmigaOS are: IMPORT, UBYTE, UWORD, ULONG.

#define TRANSIENT    auto
#define EXPORT               /* global (project-scope) */
#define MODULE       static  /* external static (file-scope) */
#define PERSIST      static  /* internal static (function-scope) */
typedef signed char  FLAG;   /* 8-bit signed quantity (replaces BOOL) */
typedef signed char  SBYTE;  /* 8-bit signed quantity (replaces Amiga BYTE) */
typedef signed short SWORD;  /* 16-bit signed quantity (replaces Amiga WORD) */
typedef signed long  SLONG;  /* 32-bit signed quantity (same as LONG) */
#define elif         else if
#define acase        break; case
#define adefault     break; default
#define DISCARD      (void)
#define EOS          0       // end of string
#if defined(__AROS__) || defined(__MORPHOS__) || defined(__amigaos4__)
    #define chip
    #define fast
#endif
#ifndef __amigaos4__
    #define USED
#endif

#define ONE_BILLION  1000000000

#ifdef __amigaos4__
    #define execver SysBase->lib_Version
    #define execrev SysBase->lib_Revision
#else
    #define execver SysBase->LibNode.lib_Version
    #define execrev SysBase->LibNode.lib_Revision
#endif

#define SCAN_A1               1
#define SCAN_A2               2
#define SCAN_A3               3
#define SCAN_A4               4
#define SCAN_A5               5
#define SCAN_A6               6
#define SCAN_A7               7
#define SCAN_A8               8
#define SCAN_A9               9
#define SCAN_A0              10
#define SCAN_N0              15
#define SCAN_Q               16
#define SCAN_W               17
#define SCAN_E               18
#define SCAN_R               19
#define SCAN_T               20
#define SCAN_Y               21
#define SCAN_U               22
#define SCAN_I               23
#define SCAN_O               24
#define SCAN_P               25
#define SCAN_N1              29
#define SCAN_N2              30
#define SCAN_N3              31
#define SCAN_A               32
#define SCAN_S               33
#define SCAN_D               34
#define SCAN_F               35
#define SCAN_J               38
#define SCAN_K               39
#define SCAN_N4              45
#define SCAN_N5              46
#define SCAN_N6              47
#define SCAN_Z               49
#define SCAN_X               50
#define SCAN_C               51
#define SCAN_V               52
#define SCAN_B               53
#define SCAN_N               54
#define SCAN_M               55
#define SCAN_NUMERICDOT      60
#define SCAN_N7              61
#define SCAN_N8              62
#define SCAN_N9              63
#define SCAN_SPACEBAR        64
#define SCAN_BACKSPACE       65
#define SCAN_TAB             66
#define SCAN_ENTER           67
#define SCAN_RETURN          68
#define SCAN_ESCAPE          69
#define SCAN_DEL             70
#define SCAN_NUMERICMINUS    74
#define SCAN_UP              76
#define SCAN_DOWN            77
#define SCAN_RIGHT           78
#define SCAN_LEFT            79
#define SCAN_F1              80
#define SCAN_F2              81
#define SCAN_F3              82
#define SCAN_F4              83
#define SCAN_F5              84
#define SCAN_F6              85
#define SCAN_F7              86
#define SCAN_F8              87
#define SCAN_F9              88
#define SCAN_F10             89
#define SCAN_NUMERICOPEN     90
#define SCAN_NUMERICCLOSE    91
#define SCAN_NUMERICSLASH    92
#define SCAN_NUMERICASTERISK 93
#define SCAN_NUMERICPLUS     94
#define SCAN_HELP            95
#define FIRSTQUALIFIER       96
#define LASTQUALIFIER       103
#ifndef NM_WHEEL_UP
    #define NM_WHEEL_UP     122
#endif
#ifndef NM_WHEEL_DOWN
    #define NM_WHEEL_DOWN   123
#endif
#define KEYUP               128 /* key release */

#define OS_ANY                0
#define OS_12                33
#define OS_13                34
#define OS_20                36
#define OS_204               37
#define OS_21                38
#define OS_30                39
#define OS_31                40
#define OS_32                43 // eg. Walker
#define OS_35                44
#define OS_39                45
#define OS_40                51
#define OS_41                53

#define ABOUTXPIXEL         296
#define ABOUTYPIXEL         195
#define SCREENXPIXEL        640
#define SCREENYPIXEL        512
#define LEFTGAP             (((DisplayWidth  - SCREENXPIXEL) / 2) + xoffset)
#define TOPGAP              (((DisplayHeight - SCREENYPIXEL) / 2) + yoffset)

#define MAX_PATH            512 // OS3 supports about 255 chars for each of path and filename

#ifndef EXIT_SUCCESS
    #define EXIT_SUCCESS      0
#endif
#if EXIT_FAILURE == 1
    #undef  EXIT_FAILURE
#endif
#ifndef EXIT_FAILURE
    #define EXIT_FAILURE     20
#endif

#ifdef __amigaos4__
    #define LLL(a,b) (STRPTR) GetCatalogStr(   CatalogPtr, a, b)
#else
    #define LLL(a,b)          GetCatalogStr(   CatalogPtr, a, b)
#endif

// shared.c
EXPORT void help_about(void);
EXPORT void openurl(STRPTR command);
EXPORT void rq(STRPTR text);
EXPORT void shadowtext(struct RastPort* RastPortPtr, STRPTR text, UBYTE colour, SWORD x, SWORD y);
EXPORT void InitHook(struct Hook* hook, ULONG (*func)(), void* data);
EXPORT ULONG HookFunc(struct Hook* h, VOID* requester, VOID* screenmode);
EXPORT void msg(void);
EXPORT void help_manual(void);
EXPORT FLAG Exists(STRPTR name);
EXPORT void clearkybd_normal(struct Window* WindowPtr);
EXPORT void clearkybd_gt(struct Window* WindowPtr);
EXPORT void getscreenmode(void);
EXPORT void lockscreen(void);
EXPORT void unlockscreen(void);
EXPORT void zstrncpy(char* to, const char* from, size_t n);
#ifdef __amigaos4__
    EXPORT int handle_applibport(FLAG loadable);
    EXPORT void registerapp(void);
#endif
#if defined(__AROS__) && (AROS_BIG_ENDIAN == 0)
    EXPORT void swap_byteorder(UWORD* imagedata, ULONG size);
#endif
#ifndef __SASC
    EXPORT int stcl_d(char* out, long lvalue);
#endif
