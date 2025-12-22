/* config.h.in.  Generated automatically from configure.in by autoheader.  */

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
#undef HAVE_SYS_WAIT_H

/* Define if you need to in order for stat and other things to work.  */
#undef _POSIX_SOURCE

/* Define as the return type of signal handlers (int or void).  */
#if defined(_DCC)
#define RETSIGTYPE __sigfunc
#elif defined(__GNUC__)
#define RETSIGTYPE void
#elif defined(__SASC)
#define RETSIGTYPE void
#endif

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
#define TIME_WITH_SYS_TIME 1

/* Define if lex declares yytext as a char * by default, not a char[].  */
#define YYTEXT_POINTER

#define FIRST_PTY_LETTER 'p'

#define HAVE_FCNTL_H 1

#define HAVE_GETHOSTNAME 0

#define HAVE_GETTIMEOFDAY 1

#define HAVE_RANDOM 1

#define HAVE_SYS_SOCKET_H 0

#undef IBMRTAIX

#define LAST_PTY_LETTER 'q'

#define PATCHLEVEL "0"

#define PRODUCT "xboard"

#define PTY_ITERATION

#define PTY_NAME_SPRINTF

#define PTY_TTY_NAME_SPRINTF

#define REMOTE_SHELL "rsh"

#undef RTU

#undef UNIPLUS

#define USE_PTYS 0

#define VERSION "x.y"

#undef X_WCHAR

#undef ZIPPY

/* Define if you have the _getpty function.  */
#undef HAVE__GETPTY

/* Define if you have the ftime function.  */
#undef HAVE_FTIME

/* Define if you have the grantpt function.  */
#undef HAVE_GRANTPT

/* Define if you have the rand48 function.  */
#undef HAVE_RAND48

/* Define if you have the sysinfo function.  */
#undef HAVE_SYSINFO

/* Define if you have the <lan/socket.h> header file.  */
#undef HAVE_LAN_SOCKET_H

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <stropts.h> header file.  */
#undef HAVE_STROPTS_H

/* Define if you have the <sys/fcntl.h> header file.  */
#undef HAVE_SYS_FCNTL_H

/* Define if you have the <sys/systeminfo.h> header file.  */
#undef HAVE_SYS_SYSTEMINFO_H

/* Define if you have the <sys/time.h> header file.  */
#undef HAVE_SYS_TIME_H

/* Define if you have the <unistd.h> header file.  */
#if defined(_DCC)
#undef HAVE_UNISTD_H
#else
#define HAVE_UNISTD_H 1
#endif

/* Define if you have the i library (-li).  */
#undef HAVE_LIBI

/* Define if you have the seq library (-lseq).  */
#undef HAVE_LIBSEQ
