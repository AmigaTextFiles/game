/* config.h for MOS.  Modified by HAK/2007-08-15.  */

/* Include pthread support for binary relocation? */
#undef BR_PTHREAD

/* Define to Datadir used */
#define DATADIR "Progdir:data"

/* Use binary relocation? */
#undef ENABLE_BINRELOC

/* Define to 1 if you have the `pthread' library (-lpthread). */
#undef HAVE_LIBPTHREAD

/* Set to 1 if you are compiling on a GP2X host. */
#undef IS_GP2X_HOST

/* Set to 1 if you are compiling on a MOS host. */
#define IS_MOS_HOST 1

/* Set to 1 if you are compiling on an OS X host. */
#undef IS_OSX_HOST

/* Set to 1 if you are compiling on a Windows host. */
#undef IS_WIN32_HOST

/* Set to 1 if you are compiling on a Windows CE host. */
#undef IS_WINCE_HOST

/* Name of package */
#undef PACKAGE

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "hak@nakama.at"

/* Define to the full name of this package. */
#define PACKAGE_NAME "Amoebax"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "Amoebax-0.2.0"

/* Define to the one symbol short name of this package. */
#undef PACKAGE_TARNAME

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.2.0"

/* Version number of package */
#define VERSION "0.2.0"
