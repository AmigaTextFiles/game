pkgdata_PROGRAMS = snipe2d.@CPU_IS@.dynamic snipe2d.@CPU_IS@.static
BUILT_SOURCES = snipe2d
bin_SCRIPTS = snipe2d
snipe2d_common = \
 ai.cpp \
 binds.cpp \
 binds.h \
 gameover.cpp \
 highscores.cpp \
 logoscreen.cpp \
 petopt.cpp \
 petopt.h \
 prefs.cpp \
 prints.cpp \
 render_ai.cpp \
 snipe2d.cpp \
 snipe2d.h \
 target.cpp \
 ui.cpp \
 ui.h \
 zooms.cpp \
 sexpr/faststack.h \
 sexpr/sexp.c \
 sexpr/sexp.h \
 sexpr/sexp_ops.c \
 sexpr/sexp_ops.h \
 sexpr/faststack.c \
 sexpr/io.c \
 sexpr/parser.c

snipe2d_@CPU_IS@_dynamic_SOURCES = $(snipe2d_common)

#snipe2d_@CPU_IS@_static_LDFLAGS = -static
snipe2d_@CPU_IS@_static_SOURCES = $(snipe2d_common)

#Hardcore on the .static
snipe2d.@CPU_IS@.static$(EXEEXT): $(snipe2d_@CPU_IS@_static_OBJECTS) $(snipe2d_@CPU_IS@_static_DEPENDENCIES)
	@rm -f snipe2d.@CPU_IS@.static$(EXEEXT)
#	$(CXXLINK) $(snipe2d_@CPU_IS@_static_LDFLAGS) $(snipe2d_@CPU_IS@_static_OBJECTS) $(snipe2d_@CPU_IS@_static_LDADD) -Xlinker -static -Xlinker -lSDL -Xlinker -lSDL_image -Xlinker -shared -shared
#	$(CXXLINK) $(snipe2d_@CPU_IS@_static_LDFLAGS) $(snipe2d_@CPU_IS@_static_OBJECTS) $(snipe2d_@CPU_IS@_static_LDADD) -Xlinker -static -Xlinker -lSDL -Xlinker -lSDL_image -Xlinker -shared -shared
	touch $@
#I give up.  Can't figure out partial static.  --phaethon
