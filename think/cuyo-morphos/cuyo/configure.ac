dnl Muss immer am Anfang stehen.
dnl Die angegebene Datei ist irgend eine; und nur dazu da, um an deren
dnl Existenz rausfinden zu können, ob's das richtige Verzeichnis ist.
AC_INIT(src/cuyo.cpp)
dnl these here make AM_PATH_SDL_CUYO less noisy
AC_ARG_PROGRAM

dnl Wird von automake benötigt. Package-Name und -Version. Werden auch in
dnl defines geschrieben
AM_INIT_AUTOMAKE(cuyo,[2.~-1.1])

dnl Bernhard will das: (damit kaputte Automakes nix kaputt machen)
AM_MAINTAINER_MODE

dnl Sorgt dafür, dass defines nicht mit -D übergeben werden, sondern in
dnl config.h geschrieben werden. (Dazu muss vorher autoheader aufgerufen
dnl werden, um config.h.in zu erzeugen.) Wenn man Automake benutzt, muss
dnl man die AM_-Version dieses Makros verwenden. (Warum auch immer.)
AM_CONFIG_HEADER(config.h)

dnl This is a C++ program, no need to test the C compiler
AC_LANG(C++)

dnl -------------------------------------------------------------------------
dnl debug
dnl -------------------------------------------------------------------------

dnl Auskommentiert:

dnl Hier kann man zur ./configure - zeit noch ein --enable-debug angeben.
dnl AC_ARG_ENABLE(debug, [  --enable-debug          compile with debugging symbols and without optimisation if no CFLAGS is given],
dnl	[CXXDBGFLAGS="-g"], [CXXDBGFLAGS="-O2"])

dnl -------------------------------------------------------------------------
dnl Basic g++ stuff
dnl -------------------------------------------------------------------------

if test "${CXXFLAGS+set}" != set ; then
	CXXFLAGS="-Wall -W -ansi $CXXDBGFLAGS"
fi

dnl g++:
AC_PROG_CXX
dnl Das Programm, mit dem installiert wird:
AC_PROG_INSTALL

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST


dnl -------------------------------------------------------------------------
dnl Lex & Yacc
dnl -------------------------------------------------------------------------


AM_PROG_LEX
dnl AM_PROG_LEX scheint einen Bug zu haben: Da taucht die Zeile
dnl test -n "$LEX" || LEX=""$missing_dir/missing flex""
dnl im configure-skript auf. Also mit zu vielen Anführungszeichen.
dnl Aber die info-page von automake sagt sowieso, dass, wenn man
dnl %noyywrap verwendet, man statt AM_PROG_LEX aufzurufen folgendes
dnl tun soll:
dnl AC_PROG_LEX
dnl if test "$LEX" != flex; then
dnl   LEX="$SHELL $missing_dir/missing flex"
dnl   AC_SUBST(LEX_OUTPUT_ROOT, lex.yy)
dnl   AC_SUBST(LEXLIB, '')
dnl fi

AC_PROG_YACC

dnl Wohin werden Level und Bilder installiert?
dnl AC_DEFINE_DIR(DATADIR, datadir)


dnl -------------------------------------------------------------------------
dnl libz
dnl -------------------------------------------------------------------------


dnl Gibt's die LibZ? Wenn ja, kann Cuyo komprimierte Bilddateien
dnl laden. Wenn's die Lib gibt, wird:
dnl - "-lz" an gcc übergeben (genauer: vor die autoconf-Variable @LIBS@ gehängt)
dnl - In config.h wird "#define HAVE_LIBZ 1" geschrieben
dnl - Das "if HASLIBZ" in den Makefile.am ausgeführt
dnl AC_CHECK_LIB(z, gzopen)
AC_CHECK_LIB(z, gzopen, [
  dnl "#define HAVE_LIBZ 1" in config.h schreiben (siehe auch acconfig.h)
  AC_DEFINE_UNQUOTED(HAVE_LIBZ, 1, [Define this to enable reading of .xpm.gz files. Needs libz.])
  LIBS="-lz $LIBS"
  HASLIBZ=true
])
AM_CONDITIONAL(HASLIBZ, test a$HASLIBZ = atrue)


dnl -------------------------------------------------------------------------
dnl SDL
dnl -------------------------------------------------------------------------

AM_PATH_SDL_CUYO(1.2.0)
if test -z "$SDL_LIBS"; then AC_MSG_ERROR([SDL is required to compile Cuyo])
fi

AC_CHECK_LIB(SDL_image,IMG_Load,[SDL_LIBS="$SDL_LIBS -lSDL_image"],
		[AC_MSG_ERROR([SDL_image is required to compile Cuyo])],
		[$SDL_LIBS])
AC_CHECK_LIB(SDL_mixer,Mix_OpenAudio,[SDL_LIBS="$SDL_LIBS -lSDL_mixer"],
		[AC_MSG_ERROR([SDL_mixer is required to compile Cuyo])],
                [$SDL_LIBS])

save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="$CPPFLAGS $SDL_CFLAGS"
AC_CHECK_HEADER(SDL_image.h,,[AC_MSG_ERROR([SDL_image.h is required to compile Cuyo])])
AC_CHECK_HEADER(SDL_mixer.h,,[AC_MSG_ERROR([SDL_mixer.h is required to compile Cuyo])])
CPPFLAGS="$save_CPPFLAGS"

AC_SUBST(SDL_LIBS)
AC_SUBST(SDL_CFLAGS)


dnl -------------------------------------------------------------------------
dnl datasrc-maintainer-mode
dnl -------------------------------------------------------------------------


AC_ARG_ENABLE(datasrc-maintainer-mode, [  --enable-datasrc-maintainer-mode          rebuild file lists in the datasrc directory, if necessary; needs ocaml],
	[DATASRC_MAINTAINER_MODE=true], [DATASRC_MAINTAINER_MODE=false])
AC_SUBST(DATASRC_MAINTAINER_MODE)



dnl -------------------------------------------------------------------------
dnl Create makefiles
dnl -------------------------------------------------------------------------


dnl Makefiles erzeugen...
AC_OUTPUT(Makefile src/Makefile data/Makefile docs/Makefile icons/Makefile)
