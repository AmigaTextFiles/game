#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.57)
AC_INIT
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([mindless], [0.9.0], [matbr@home.se])
AC_CONFIG_SRCDIR([src/mindless.cc])
AM_CONFIG_HEADER(config.h)

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC

# Checks for libraries.

dnl Check for SDL
SDL_VERSION=1.2.0
AM_PATH_SDL($SDL_VERSION,:,AC_MSG_ERROR([*** SDL version $SDL_VERSION not found!]))
CFLAGS="$CFLAGS $SDL_CFLAGS"
LIBS="$LIBS $SDL_LIBS"

dnl Check for SDL_ttf
AC_CHECK_LIB(SDL_ttf,main,,[AC_MSG_ERROR([need SDL_ttf. See http://www.libsdl.org])])

dnl Check for SDL_image
AC_CHECK_LIB(SDL_image,main,,[AC_MSG_ERROR([need SDL_image. See http://www.libsdl.org])])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

# LIBS = /usr/lib/libSDL_image.a /usr/lib/libSDL_ttf.a -L/usr/lib -Wl,-rpath,/usr/lib -lSDL -lpthread -lfreetype /usr/lib/libpng.a -ltiff

AC_CONFIG_FILES([Makefile
                 src/Makefile
				 share/Makefile
				 share/fonts/Makefile
				 share/images/Makefile
				 share/icons/Makefile])
AC_OUTPUT

