
#ifndef CONFIG_UNIX_H
#define CONFIG_UNIX_H

/* Directory where the UQM game data is located */
#define CONTENTDIR "/PROGDIR/content"

/* Directory where game data will be stored */
#define USERDIR "/PROGDIR/userdata"

/* Directory where config files will be stored */
#define CONFIGDIR USERDIR

/* Directory where supermelee teams will be stored */
#define MELEEDIR CONFIGDIR"/teams"

/* Directory where save games will be stored */
#define SAVEDIR CONFIGDIR"/save"

/* Defined if words are stored with the most significant byte first */
#define WORDS_BIGENDIAN 1

/* Defined if your system has readdir_r of its own */
/* #define HAVE_READDIR_R 1 */

/* Defined if your system has setenv of its own */
#define HAVE_SETENV 1

/* Defined if your system has strupr of its own */
#define HAVE_STRUPR 1

/* Defined if your system has strcasecmp of its own */
#define HAVE_STRCASECMP_UQM 1

/* Defined if your system has stricmp of its own */
#define HAVE_STRICMP 1

/* Defined if your system has getopt_long */
#define HAVE_GETOPT_LONG 1

/* Defined if your system has iswgraph of its own*/
#define HAVE_ISWGRAPH 1

/* Defined if your system has wchar_t of its own */
#define HAVE_WCHAR_T 1

/* Defined if your system has wint_t of its own */
#define HAVE_WINT_T 1

/* Defined if your system has _Bool of its own */
#define HAVE__BOOL 1

#endif
