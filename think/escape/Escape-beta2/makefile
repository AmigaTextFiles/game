
# you may need to "export LINUX" or "export OSX" before you type make.
ifndef LINUX
ifndef OSX
# makefile for windows. Windows is weird.

# normally use these
ZLIBDIR = ..\SDL_image_1.2.4\lib
ZINCDIR = ..\SDL_image_1.2.4\include
PLIBDIR = ZLIBDIR
PINCDIR = ZINCDIR

# Or maybe these if you compile zlib and libpng yourself
# ZLIBDIR = ..\zlib
# ZINCDIR = ..\zlib
# PLIBDIR = ..\libpng
# PINCDIR = ..\libpng

default : escape.exe replace.exe

COMPILE=cl /nologo /MDd /W3 /GX /Od /I "..\SDL-1.2.8\include" /I "..\SDL_image-1.2.4\include" /I "..\SDL_net-1.2.5\include" /I "..\SDL_mixer-1.2.6\include" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /FD /GZ /c /I ${ZINCDIR} /I ${PINCDIR}

COMPILECMDLINE=cl /nologo /MDd /W3 /GX /Od /I "..\SDL-1.2.8\include" /I "..\SDL_image-1.2.4\include" /I "..\SDL_net-1.2.5\include" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /FD /GZ /c /I "..\libpng" /D "_CONSOLE"  /I ${ZINCDIR} /I ${PINCDIR}


# don't need?
# most recently..
# odbc32.lib odbccp32.lib
# probably could remove more, haven't tried... (does it even matter?)

LINK=link oldnames.lib "..\SDL-1.2.8\lib\SDL.lib" "..\SDL_image-1.2.4\lib\SDL_image.lib" "..\SDL_net-1.2.5\lib\SDL_net.lib" "..\SDL_mixer-1.2.6\lib\SDL_mixer.lib" libcpmt.lib msvcrt.lib msvcprt.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib uuid.lib /nologo /subsystem:windows /pdb:none /debug /machine:I386 /nodefaultlib /libpath:"..\SDL-1.2.8\lib" /libpath:"..\SDL_net-1.2.5\lib" /libpath:"..\SDL_mixer-1.2.6\lib"  /libpath:"..\SDL_image-1.2.4\lib" /libpath:${ZLIBDIR} /libpath:${PLIBDIR}

# for command line apps. no need for net or mixer.
LINKCMDLINE=link oldnames.lib "..\SDL-1.2.8\lib\SDL.lib" "..\SDL_image-1.2.4\lib\SDL_image.lib" libcpmt.lib msvcrt.lib msvcprt.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib uuid.lib /nologo /subsystem:console /pdb:none /debug /machine:I386 /nodefaultlib /libpath:"..\SDL-1.2.8\lib" /libpath:"..\SDL_image-1.2.4\lib"  /libpath:${ZLIBDIR} /libpath:${PLIBDIR}

.dummy :

version : .dummy
	cl /nologo /D "WIN32" /GX version.cpp
	version.exe > version.h
	make clean
	make default

wc :
	wc -l *.cpp *.h

RELEASEFILES=escape.exe replace.exe font.png fontsmall.png tiles.png tileutil.png title.png icon.png escape.txt SDL.dll SDL_image.dll SDL_net.dll jpeg.dll libpng13.dll zlib1.dll COPYING changelog animation.png SDL_mixer.dll splash.png

zip : .dummy ${RELEASEFILES}
	rm -rf escape-beta
	mkdir escape-beta
	cp -a triage escape-beta
	cp -a ${RELEASEFILES} escape-beta
	mkdir escape-beta\mylevels
	cp -a official escape-beta
	rm -rf escape-beta/official/CVS escape-beta/triage/CVS
	cp mylevels/index.esi escape-beta/mylevels/
	rm -f escape-beta.zip
	echo "=============================="
	echo "now zip escape-beta to release"
	echo "escape-beta.zip is already gone"
	echo "then do make zipup"
	echo "=============================="

releasefiles.win32 : makefile
	echo ${RELEASEFILES} > releasefiles.win32

escapesetup.exe : .dummy ${RELEASEFILES} escape.nsi
	makensis escape.nsi

installer : escapesetup.exe

zipup : escape-beta.zip
	pscp escape-beta.zip tom@spacebar.org:/Y/escape/

installerup : escapesetup.exe
	pscp escapesetup.exe tom@spacebar.org:/Y/escape/

# some rules for making objects, etc.

# how to compile object files
%.obj : %.cpp selector.h extent.h
	${COMPILE} $<

animation_load.h : animation.pack
	make packpng.exe
	packpng.exe animation.pack animation
	rm -f animation.better
	pngcrush -e .better animation.png
	rm -f animation.png
	mv animation.better animation.png

sound_load.h : sound.pack packsound.cpp
	make packsound.exe
	packsound.exe sound.pack sound

sound.obj : sound.cpp sound_load.h sound.h
	${COMPILE} $<

level.obj : level.cpp move.h 
	${COMPILE} $<

animation.obj : animation.cpp animation.h animation_load.h animation_decs.h animation_defs.h
	${COMPILE} $< 

# it has to be different for the console =(
%-console.obj : %.cpp
	${COMPILECMDLINE} $^ /Fo$@

sdlutil-console.obj : sdlutil.cpp
	${COMPILECMDLINE} -DUSE_DISPLAY_FORMAT=0 $^ /Fo$@

escape.res : escape.rc escape.ico
	rc /r /fo escape.res escape.rc

escape.exe : main.obj level.obj sdlutil.obj play.obj font.obj dirent.obj load.obj util.obj md5.obj player.obj playerdb.obj prompt.obj draw.obj edit.obj editai.obj mainmenu.obj upgrade.obj http.obj textscroll.obj message.obj update.obj dircache.obj upper.obj registration.obj upload.obj rating.obj menu.obj prefs.obj escape.res chunks.obj dirindex.obj textbox.obj analysis.obj generator.obj prime.obj commenting.obj cleanup.obj mainshow.obj handhold.obj animation.obj dirt.obj sound.obj base64.obj winmain.obj optimize.obj smanage.obj
	${LINK} /out:"escape.exe" $^

# other executables that need to be built:

replace.exe : replace-console.obj util-console.obj
	${LINKCMDLINE} /out:$@ $^ user32.lib

convert.exe : convert-console.obj level-console.obj util-console.obj dirent-console.obj
	${LINKCMDLINE} /out:$@ $^

packpng.exe : util-console.obj font-console.obj level-console.obj sdlutil-console.obj packpng-console.obj pngsave-console.obj winmain-console.obj
	${LINKCMDLINE} /out:$@ $^ libpng13.lib

packsound.exe : util-console.obj packsound-console.obj winmain-console.obj
	${LINKCMDLINE} /out:$@ $^

mkupgrade.exe : mkupgrade-console.obj md5-console.obj
	${LINKCMDLINE} /out:$@ $^

UPGRADE : .dummy mkupgrade.exe releasefiles.win32 deletefiles.win32 symlinks.win32
	mkupgrade.exe releasefiles.win32 symlinks.win32 deletefiles.win32 > UPGRADE

CURRENT : .dummy mkupgrade.exe
	mkupgrade.exe -v > CURRENT

release : UPGRADE CURRENT
	pscp -C ${RELEASEFILES} UPGRADE CURRENT tom@escape.spacebar.org:/Y/escape/win32/
	rm -f UPGRADE CURRENT mkupgrade.exe

clean :
	rm -f *.obj convert.exe escape.exe *.tmp *.delme *.pdb *.ilk *.o *.idb *.plg *.opt replace.exe *.ncb *.aps packpng.exe screenshot.exe replace.exe mkupgrade.exe version.exe 
	touch mv_is_dumb~
	touch .\#mv_is_dumb
	mv -f *~ .\#* attic

# end windows makefile
endif
endif



# -------------------------------------------------------------------

ifdef LINUX
# makefile for linux

  OFILES = main.o level.o sdlutil.o load.o font.o play.o util.o md5.o player.o playerdb.o prompt.o draw.o edit.o mainmenu.o upgrade.o http.o textscroll.o message.o update.o editai.o dircache.o upper.o registration.o upload.o rating.o menu.o prefs.o chunks.o dirindex.o textbox.o analysis.o generator.o prime.o commenting.o cleanup.o mainshow.o handhold.o animation.o dirt.o sound.o base64.o optimize.o smanage.o

default : escape.exe

PROF =
# PROF = -pg

# to distribute dynamic: sdl-config --prefix=.
# then ldd escape.exe
# and upload the .so files with the thingy

LINKFLAGS =
#  LINKFLAGS = -lefence

CPPFLAGS = `sdl-config --cflags` -g -Wall -O ${PROF}

escape.exe : ${OFILES}
	g++ ${PROF} -o escape.exe $^ -lSDL_image -Wl,-rpath=. -lSDL_net -lSDL_mixer `sdl-config --libs` -ltiff -lpng -ljpeg -lz -lvorbisfile -lvorbis -logg ${LINKFLAGS}


default : escape.exe

%-console.o : %.cpp
	g++ ${CPPFLAGS} -DUSE_DISPLAY_FORMAT=0 $^ -c -o $@

# but this should be static
screenshot.exe : draw-console.o pngsave-console.o level-console.o font-console.o util-console.o sdlutil-console.o screenshot-console.o animation-console.o
	g++ -static -o screenshot.exe $^ -lSDL_image `sdl-config --static-libs` -ltiff -lpng -ljpeg -lz -lvorbisfile -lvorbis -logg 
	strip screenshot.exe

# XX deprecated
convert : convert.o level.o util.o
	g++ -static -lSDL_image -lSDL_net -lSDL_mixer `sdl-config --libs` -ltiff -lpng -ljpeg -lz -lvorbisfile -lvorbis -logg $^ -o convert

.dummy :

version : .dummy
	g++ version.cpp -o version.exe
	./version.exe > version.h
	make clean
	make escape.exe

LIBFILES=libjpeg.so.62 libogg.so.0 libpng.so.2 libSDL-1.2.so.0 libSDL_net-1.2.so.0 libtiff.so.3 libvorbisfile.so.3 libvorbis.so.0 libz.so.1 libartsc.so.0 libesd.so.0
RELEASEFILES=escape.exe font.png fontsmall.png tiles.png tileutil.png title.png icon.png escape.txt COPYING changelog animation.png splash.png ${LIBFILES}

releasefiles.linux : ${RELEASEFILES}
	echo ${RELEASEFILES} > releasefiles.linux

mkupgrade.exe : mkupgrade.cpp md5.cpp
	g++ -DLINUX mkupgrade.cpp md5.cpp -o mkupgrade.exe

UPGRADE : .dummy escape.exe releasefiles.linux symlinks.linux deletefiles.linux mkupgrade.exe
	strip escape.exe
	./mkupgrade.exe releasefiles.linux symlinks.linux deletefiles.linux > UPGRADE
	./mkupgrade.exe -v > CURRENT

release : UPGRADE
	scp -C ${RELEASEFILES} UPGRADE CURRENT tom@escape.spacebar.org:/Y/escape/linux/
	rm -f UPGRADE CURRENT mkupgrade.exe

zip : escape-beta.tar.gz

escape-beta.tar.gz : escape.exe
	rm -rf /tmp/escape
	rm -f /tmp/escape-beta.tar
	rm -f /tmp/escape-beta.tar.gz
	rm -f escape-beta.tar.gz
	mkdir /tmp/escape
	strip escape.exe
	cp ${RELEASEFILES} /tmp/escape
	cp -a triage /tmp/escape
	cp -a official /tmp/escape
	mkdir /tmp/escape/mylevels
	cp mylevels/index.esi /tmp/escape/mylevels/
	cd /tmp && tar -c escape > escape-beta.tar && gzip escape-beta.tar
	mv /tmp/escape-beta.tar.gz .

zipup : escape-beta.tar.gz
	scp escape-beta.tar.gz tom@escape.spacebar.org:/Y/escape/

source : escape-src.tar.bz2

escape-src.tar.bz2 :
	cd /usr0/src/escape-src && cvs up -dP
	rm -rf /usr0/src/escape-src/web /usr0/src/escape-src/*.es{p,d}
	cd /usr0/src && tar -c escape-src > /tmp/escape-src.tar
	cd /tmp && bzip2 escape-src.tar
	mv /tmp/escape-src.tar.bz2 .

sourceup : source
	scp escape-src.tar.bz2 tom@escape.spacebar.org:/Y/escape/source/


wc :
	wc -l *.cpp *.h

clean :
	rm -f *.o escape.exe core core.[0-9]* gmon.out escape-src.tar.bz2 escape-beta.tar.gz

# end linux makefile
endif

# -------------------------------------------------------------------

ifdef OSX
# makefile for OSX


default : escape.exe

# Change this to wherever you put Frameworks directory.
# Frameworks are just glorified shared libraries--they include headers, 
# documentation, graphics resources, whatever else programs want to share.
FRAMEWORKS=OSX_build/Frameworks/

# sound is disabled to give people time to upgrade the upgrader
# to add it, remove -DNOSOUND and add
# -I${FRAMEWORKS}/SDL_mixer.framework/Versions/Current/Headers
# to CPPFLAGS and add 
#  -framework SDL_mixer
# to the g++ line linking below

# don't want to compile with sourceforge's SDL

# sound is disabled until I can get an SDL_mixer Framework 
CPPFLAGS = -I/usr/local/include -I${FRAMEWORKS}/SDL.framework/Versions/Current/Headers -I${FRAMEWORKS}/SDL_net.framework/Versions/Current/Headers -I${FRAMEWORKS}/SDL_mixer.framework/Versions/Current/Headers -I${FRAMEWORKS}/SDL_image.framework/Versions/Current/Headers -D_THREAD_SAFE -DOSX

# where is this used??
LINK = g++ `sdl-config --libs` -lSDL_image -lpng

escape.exe : main.o level.o sdlutil.o load.o font.o play.o util.o md5.o player.o playerdb.o prompt.o draw.o edit.o mainmenu.o upgrade.o http.o textscroll.o message.o update.o editai.o dircache.o upper.o registration.o upload.o rating.o sdlmain.o menu.o prefs.o chunks.o dirindex.o textbox.o analysis.o generator.o prime.o commenting.o cleanup.o mainshow.o handhold.o animation.o dirt.o sound.o base64.o optimize.o smanage.o
	g++ -F${FRAMEWORKS} -framework SDL_net -framework SDL_image -L/usr/local/lib -framework SDL -framework OpenGL -framework AGL -framework IOKit -framework Carbon -framework Cocoa -framework SDL_mixer $^ -o escape.exe

convert : convert.o level.o util.o
	g++ `sdl-config --libs` $^ -o convert

.dummy :

version : .dummy
	g++ version.cpp -o version.exe
	./version.exe > version.h
	make clean
	make escape.exe

RELEASEFILES=escape.exe font.png fontsmall.png tiles.png tileutil.png title.png icon.png escape.txt COPYING changelog animation.png splash.png

mkupgrade.exe : mkupgrade.cpp md5.cpp
	g++ -DOSX mkupgrade.cpp md5.cpp -o mkupgrade.exe

releasefiles.osx :
	echo ${RELEASEFILES} > releasefiles.osx
	echo OSX_build/Frameworks/SDL_mixer.framework/SDL_mixer >> releasefiles.osx
	echo OSX_build/Frameworks/SDL_mixer.framework/Resources/Info.plist >> releasefiles.osx
	echo OSX_build/Frameworks/SDL_mixer.framework/Resources/pbdevelopment.plist >> releasefiles.osx

UPGRADE : .dummy mkupgrade.exe releasefiles.osx symlinks.osx deletefiles.osx
	strip escape.exe
	./mkupgrade.exe releasefiles.osx symlinks.osx deletefiles.osx > UPGRADE
	./mkupgrade.exe -v > CURRENT

release : UPGRADE
	rm -rf ../release
	mkdir ../release
	cp ${RELEASEFILES} CURRENT UPGRADE ../release/
	cp OSX_build/Frameworks/SDL_mixer.framework/SDL_mixer ../release/OSX_build_Frameworks_SDL_mixer.framework_SDL_mixer
	cp OSX_build/Frameworks/SDL_mixer.framework/Resources/Info.plist ../release/OSX_build_Frameworks_SDL_mixer.framework_Resources_Info.plist
	cp OSX_build/Frameworks/SDL_mixer.framework/Resources/pbdevelopment.plist ../release/OSX_build_Frameworks_SDL_mixer.framework_Resources_pbdevelopment.plist
	rm -f UPGRADE CURRENT mkupgrade.exe

zip : escape-beta-osx.zip

# OSX_build goes inside an otherwise empty folder called
# Escape.app. The folder should be renamed to Contents.
# inside Contents/MacOS goes all of the regularly distributed
# files.
# the folder Escape.app is zipped to produce the result

# for some reason frameworks need some redundance built with symlinks
# XXX give this deps so it knows when to run
framelinks :
	cd OSX_build/Frameworks/SDL.framework/Versions/A && ln -s ../../SDL SDL && ln -s ../../Headers Headers && ln -s ../../Resources Resources && cd .. && ln -s A Current
	cd OSX_build/Frameworks/SDL_net.framework/Versions/A && ln -s ../../SDL_net SDL_net && ln -s ../../Headers Headers && ln -s ../../Resources Resources && cd .. && ln -s A Current	
	cd OSX_build/Frameworks/SDL_image.framework/Versions/A && ln -s ../../SDL_image SDL_image && ln -s ../../Headers Headers && ln -s ../../Resources Resources && cd .. && ln -s A Current
	cd OSX_build/Frameworks/SDL_mixer.framework/Versions/A && ln -s ../../SDL_mixer SDL_mixer && ln -s ../../Headers Headers && ln -s ../../Resources Resources && cd .. && ln -s A Current

escape-beta-osx.zip : escape.exe
	rm -rf /tmp/Escape.app
	rm -f /tmp/escape-beta-osx.zip
	rm -f escape-beta-osx.zip
	mkdir /tmp/Escape.app
	cp -a OSX_build /tmp/Escape.app/Contents
	cp ${RELEASEFILES} /tmp/Escape.app/Contents/MacOS
	cp -a triage /tmp/Escape.app/Contents/MacOS/
	cp -a official /tmp/Escape.app/Contents/MacOS/
	mkdir /tmp/Escape.app/Contents/MacOS/mylevels
	cp mylevels/index.esi /tmp/Escape.app/Contents/MacOS/mylevels/
	mkdir /tmp/Escape.app/Contents/MacOS/OSX_build
	mkdir /tmp/Escape.app/Contents/MacOS/OSX_build/Frameworks
	ln -s ../MacOS/OSX_build/Frameworks/SDL_mixer.framework /tmp/Escape.app/Contents/Frameworks/SDL_mixer.framework  
	cp -a OSX_build/Frameworks/SDL_mixer.framework /tmp/Escape.app/Contents/MacOS/OSX_build/Frameworks/
	rm -f /tmp/Escape.app/Contents/Frameworks/SDL.framework/Headers/*.h
	rm -f /tmp/Escape.app/Contents/Frameworks/SDL_image.framework/Headers/*.h
	rm -f /tmp/Escape.app/Contents/Frameworks/SDL_net.framework/Headers/*.h
	rm -f /tmp/Escape.app/Contents/MacOS/OSX_build/SDL_mixer.framework/Headers/*.h
	rm -rf `find /tmp/Escape.app -name CVS`
	rm -rf `find /tmp/Escape.app -name .DS_Store`
	cd /tmp && zip -r -9 -y escape-beta-osx.zip Escape.app
	mv /tmp/escape-beta-osx.zip .

wc :
	wc -l *.cpp *.h

clean :
	rm -f *.o escape.exe core core.[0-9]* .DS_Store


# end OSX makefile
endif

