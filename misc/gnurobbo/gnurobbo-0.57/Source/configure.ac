dnl Process this file with autoconf to produce a configure script.

AC_INIT(game.c)
AM_INIT_AUTOMAKE(gnurobbo, 0.57)
AM_CONFIG_HEADER(config.h)

dnl Checks for programs.
AC_PROG_AWK
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S
AC_HEADER_STDC

dnl Checks for libraries.
dnl Replace `main' with a function in -lSDL:
AC_CHECK_LIB(SDL, main)
dnl Replace `main' with a function in -lSDL_ttf:
AC_CHECK_LIB(SDL_ttf, main)
dnl Replace `main' with a function in -lpthread:
AC_CHECK_LIB(pthread, main)

if test "x${prefix}" = "xNONE"; then

AC_DEFINE_UNQUOTED([PACKAGE_DATA_DIR],"${ac_default_prefix}/share/${PACKAGE}/",[data])
else
  AC_DEFINE_UNQUOTED([PACKAGE_DATA_DIR], "${prefix}/share/${PACKAGE}/",[data])
fi

dnl Checks for header files.

dnl Checks for typedefs, structures, and compiler characteristics.

dnl Checks for library functions.
AC_CHECK_FUNCS([atexit])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
