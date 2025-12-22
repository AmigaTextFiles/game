/* config.h.  Generated automatically by configure.  */
/* config.h.in.  Generated automatically from configure.in by autoheader.  */
#ifndef CONFIG_H
#define CONFIG_H
#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7)
#define RCSID(X) \
 static char *rcsid __attribute__ ((unused)) =X
#elif __GNUC__ == 2
#define RCSID(X) \
 static char *rcsid = X; \
 static void *use_rcsid=(&use_rcsid, (void *)&rcsid)
#else
#define RCSID(X) \
 static char *rcsid = X
#endif


/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
#define HAVE_SYS_WAIT_H 1

/* Define as __inline if that's what the C compiler calls it.  */
/* #undef inline */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you have the getenv function.  */
#define HAVE_GETENV 1

/* Define if you have the setenv function.  */
#define HAVE_SETENV 1

/* Define if you have the strdup function.  */
#define HAVE_STRDUP 1

/* Define if you have the strerror function.  */
#define HAVE_STRERROR 1

/* Define if you have the strtol function.  */
#define HAVE_STRTOL 1

/* Define if you have the syslog function.  */
/* #undef HAVE_SYSLOG */

/* Define if you have the <SDL/SDL_mixer.h> header file.  */
#define HAVE_SDL_SDL_MIXER_H 1

/* Define if you have the <SDL_mixer.h> header file.  */
#define HAVE_SDL_MIXER_H 1

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <limits.h> header file.  */
#define HAVE_LIMITS_H 1

/* Define if you have the <sys/ioctl.h> header file.  */
#define HAVE_SYS_IOCTL_H 1

/* Define if you have the <sys/time.h> header file.  */
#define HAVE_SYS_TIME_H 1

/* Define if you have the <syslog.h> header file.  */
#define HAVE_SYSLOG_H 1

/* Define if you have the <unistd.h> header file.  */
#define HAVE_UNISTD_H 1

/* Define if you have the <windows.h> header file.  */
/* #undef HAVE_WINDOWS_H */

/* Define if you have the SDL_mixer library (-lSDL_mixer).  */
/* #undef HAVE_LIBSDL_MIXER */

/* Define if you have the m library (-lm).  */
#define HAVE_LIBM 1

/* Name of package */
#define PACKAGE "sdlroids"

/* Version number of package */
#define VERSION "1.3.4"

#endif
