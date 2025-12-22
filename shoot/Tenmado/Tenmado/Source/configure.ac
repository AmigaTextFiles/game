# configure.ac for tenmado
# $Id: configure.ac,v 1.49 2004/02/15 14:41:45 oohara Exp $
# Process this file with autoconf to produce a configure script.
# autoconf 2.52 or later is required
AC_INIT([tenmado], [0.7], [oohara@libra.interq.or.jp])
AC_PREREQ([2.52])
AC_REVISION([$Revision: 1.49 $])
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([main.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
# Makefile.in will use awk
AC_PROG_AWK
AC_PROG_CC
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AM_PROG_LEX
AC_PROG_YACC

# Checks for libraries.
AC_CHECK_LIB([m], [sin])

# we use AC_CHECK_LIB here because we don't usually need -L for libdb3
# AC_CHECK_LIB should handle the HAVE_ macro
AC_ARG_WITH([libdb3],
  AC_HELP_STRING([--without-libdb3],
                 [don't use Berkeley DB version 3 for high score lists]),
  [if test x$withval = xyes; then
    AC_CHECK_LIB([db3], [db_create])
    AC_CHECK_LIB([db-3], [db_create])
   fi],
  [AC_CHECK_LIB([db3], [db_create])
    AC_CHECK_LIB([db-3], [db_create])])

AC_ARG_WITH([posix],
  AC_HELP_STRING([--without-posix],
                 [don't use (most of) POSIX features (DANGEROUS)]),
  [if test x$withval = xno; then
    AC_DEFINE([NOT_HAVE_POSIX], [1],
              [Define to 1 if your system does not have POSIX features.])
   fi],
  [])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h])
AC_CHECK_HEADERS([string.h])
AC_CHECK_HEADERS([unistd.h])
AC_CHECK_HEADERS([stddef.h])
AC_CHECK_HEADERS([limits.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_UID_T
AC_STRUCT_TM
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([atexit])
AC_CHECK_FUNCS([sqrt])
AC_CHECK_FUNCS([strdup])
AC_CHECK_FUNCS([memset])
AC_CHECK_FUNCS([strtol])

AC_CONFIG_FILES([Makefile
happy-L/Makefile
happy-L/default/Makefile
happy-L/image/Makefile
libbac/Makefile
libtenm/Makefile
save/Makefile])
AC_OUTPUT
