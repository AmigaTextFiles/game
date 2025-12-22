changequote([,])
define(GROUP, Amusements/Games/Action/Race)
dnl define(DED_REQUIRES,[libc.so.6, libg++-libc6.2-2.so.3])
dnl define(REQUIRES,[DED_REQUIRES, SDL_image >= 1.2.0, SDL >= 1.2.0, libpng.so.2])

#
# PREAMBLE
#

Summary: A tron lightcycle game in 3D
Name: PACKAGENAME
Version: VERSION
Release: RELEASE
Copyright: GPL
Group: GROUP
Source: PACKAGENAMEBASE[-]VERSION.tar.bz2
URL: http://armagetron.sf.net
Distribution: None
Vendor: Z-Man
Packager: PACKAGER
BuildRoot: RPMBUILDROOT
dnl Requires: REQUIRES
Provides: PACKAGENAME[-]data
dnl AutoReqProv: no

# requirements

# Note: automatic determining of dependencies can be tricky because of platform specific extra
# libraries ( i.e. on my system, libGL.so.1 depends on libGLcore.so.x which is not available
# everywhere and not registered in any RPM ); my personal solution was to hack those things 
# away in my local dependency generation script.

%description
In this game you ride a lightcycle; that is a sort of motorbike that
cannot be stopped and leaves a wall behind it. The main goal of the game
is to make your opponents' lightcycles crash into a wall while avoiding
the same fate.
The focus of the game lies on the multiplayer mode, but it provides
challanging AI opponents for a quick training match.

#
# PREP
#

%prep
%setup

%build
progtitle=PROGNAME
progname=PACKAGENAME
export progtitle
export progname

#optimize
CXXFLAGS="%optflags $CXXFLAGS"
export CXXFLAGS

#build dedicated server
./configure CONFIGURE_OPTIONS --prefix=PREFIX --disable-glout
make bindist
mv bindist bindist-dedicated

#build client
./configure CONFIGURE_OPTIONS --prefix=PREFIX
make bindist

%install
cd bindist-dedicated
./install -f

cd ..
cd bindist
./install -f
rm -rf $RPM_BUILD_ROOT/etc/PACKAGENAME/.orig
rm -rf $RPM_BUILD_ROOT/etc/PACKAGENAME/.user

CLIENTPATH=RPMBUILDROOT[]PREFIX/games/PACKAGENAME/
SERVERPATH=RPMBUILDROOT[]PREFIX/games/PACKAGENAME[-]dedicated/

#rm $CLIENTPATH/bin/uninstall
#rm $CLIENTPATH/bin/masterstarter[-]PACKAGENAME
#rm $CLIENTPATH/bin/serverstarter[-]PACKAGENAME
#rm $SERVERPATH/bin/uninstall

%clean
rm -rf $RPM_BUILD_ROOT

define(DATAFILES,[
%attr(-,root,root) 		PREFIX/games/$1/models
dnl %attr(-,root,root) 		PREFIX/games/$1/music
%attr(-,root,root) 		PREFIX/games/$1/sound
%attr(-,root,root) 		PREFIX/games/$1/textures
%attr(-,root,root) 		PREFIX/games/$1/arenas
])

define(BASEFILES,[
%attr(-,root,root) 		PREFIX/games/$1/COPYING.txt
%attr(-,root,root) 		PREFIX/games/$1/bin
%attr(-,root,root) %config 	CONFIG
%attr(-,root,root) 		PREFIX/games/$1/language
%attr(-,root,root) 		PREFIX/games/$1/log
%attr(-,root,root) %doc 	PREFIX/games/$1/doc
%attr(-,root,root) 		PREFIX/bin/$1
])

define(EXEFILES,[
BASEFILES($1)
%attr(-,root,root) 		PREFIX/bin/$1[-]stat
])

define(DEDFILES,[
BASEFILES($1)
%attr(-,root,root) 		PREFIX/games/$1/rc.d
dnl %attr(-,root,root) %doc 	bindist-dedicated/doc
dnl %attr(-,root,root) 		PREFIX/bin/$1[-]stat
])

#full package
%files
DATAFILES(PACKAGENAME)
EXEFILES(PACKAGENAME)

#data files specification
%package data
Summary: Data for PROGNAME
Group: GROUP
Provides: PACKAGENAME[-]data

%Description data
This is the data for PROGNAME. It is distributed seperately
to avoid multiple downloads.

%files data
DATAFILES(PACKAGENAME)

#dedicated server specification
%package dedicated
Summary: Dedicated server for PROGNAME
Group: GROUP
dnl Requires: DED_REQUIRES
dnl AutoReqProv: no

%Description dedicated
This is a special lightweight server for PROGNAME; it can
be run on a low-spec machine and await connections from
the internet and/or the LAN.

%files dedicated
DEDFILES(PACKAGENAME[-]dedicated)

#main package
%package executable
Summary: A tron lightcycle game in 3D
Group: GROUP
Requires: PACKAGENAME[-]data
dnl Requires: PACKAGENAME[-]data REQUIRES
dnl AutoReqProv: no

%Description executable
In this game you ride a lightcycle; that is a sort of motorbike that
cannot be stopped and leaves a wall behind it. The main goal of the game
is to make your opponents' lightcycles crash into a wall while avoiding
the same fate.
The focus of the game lies on the multiplayer mode, but it provides
challanging AI opponents for a quick training match.

%files executable
EXEFILES(PACKAGENAME)

ifelse(,,
#movie pack specification
%package moviepack
Summary: Additional data for PROGNAME
Group: GROUP
Requires: PACKAGENAME
dnl AutoReqProv: no

%Description moviepack
This is the additional data for PROGNAME, making it look more like the movie.

%files moviepack
PREFIX/games/PACKAGENAME/moviepack
)

%changelog
* Sat Jul  18 2003 Z-Man <z-man@users.sf.net>
- Disabled automatic dependencies

* Sat Jul  12 2003 Z-Man <z-man@users.sf.net>
- Started Changelog, added manual dependencies
