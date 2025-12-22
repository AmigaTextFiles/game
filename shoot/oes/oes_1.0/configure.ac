# Process this file with autoconf to produce a configure script.
AC_INIT(orbital_eunuchs_sniper, 1.29, zakk@timedoctor.org)
AC_CANONICAL_SYSTEM
AM_INIT_AUTOMAKE(orbital_eunuchs_sniper, 1.29)
AC_CONFIG_SRCDIR([src/snipe2d.cpp])
AM_CONFIG_HEADER([config.h])

#This requires Autoconf 2.50 or later.  2.13 or earlier not supported.
AC_PREREQ(2.50)

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S


# Checks for libraries.
AC_PATH_XTRA
AC_CHECK_LIB([SDL], [SDL_Init])
AC_CHECK_LIB([SDL_image], [IMG_Load])
AC_CHECK_LIB([SDL_mixer], [Mix_OpenAudio])
AC_CHECK_LIB([HeartOfGold],[tea])


#This is needed for IRIX (why?).
#AC_CHECK_LIB([gen], [main])


# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([fcntl.h stdlib.h string.h unistd.h])
AC_CHECK_HEADERS([SDL/SDL.h])
AC_CHECK_HEADERS([SDL/SDL_image.h])
AC_CHECK_HEADERS([SDL/SDL_mixer.h])


# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST


# Checks for library functions.
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([atexit floor memset mkdir sqrt strdup])



#Package hackage.  Ask autoconf team to include --gamedir as standard option?
AC_ARG_WITH(games-dir,
 [  --with-games-dir=path   Set path to games directory (default PREFIX/games)],
 ,dnl default action of assigning shell value
 with_games_dir='${prefix}/games'
)

[datadir="$with_games_dir"]

#These should be automagically determined somehow.
#CPU Instruction Set.  Should be automagic.
AC_SUBST(CPU_IS,x86)


echo $ac_n "ordering crap from http://www.amazon.com/exec/obidos/wishlist/296ST2NHEBO0Z $ac_c" 1>&6
sleep 1
echo $ac_n ".$ac_c" 1>&6
sleep 1
echo $ac_n ".$ac_c" 1>&6
sleep 1
echo $ac_n ".$ac_c" 1>&6
sleep 1
echo $ac_n ".$ac_c" 1>&6
sleep 1
AC_MSG_RESULT([ complete!])

AC_CONFIG_FILES([Makefile src/Makefile bin/Makefile src/snipe2d])
AC_OUTPUT
