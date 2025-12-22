srcdir = .
top_dir = "./"
top_srcdir = .
need_data = yes

all: textures models sound language/.tag arenas config/.tag var version.h infiles .gdbinit
	chmod 755 batch/*
	touch src/dep
	${MAKE} -kC src/tron
	if [ "`$(CXX) -v  2>&1 | grep mingw`x" != "x" ] ; then \
          ln -sf src/tron/armagetron armagetron.exe;\
        else\
	  ${MAKE} -kC src/network master;\
	  ${MAKE} -kC src/network astat;\
          test -r armagetron || ln -sf src/tron/armagetron armagetron;\
          test -r master || ln -sf src/network/master master;\
          test -r astat || ln -sf src/network/astat  astat;\
	fi

.gdbinit:
	 echo "break st_Breakpoint" > .gdbinit

version.h: ${srcdir}/major_version ${srcdir}/minor_version
	echo \"` cat ${srcdir}/major_version `.` cat ${srcdir}/minor_version `\" > version.h

textures:
	ln -sf ${srcdir}/textures textures	

#language: 
#	ln -sf ${srcdir}/language language

language/.tag: ${srcdir}/language/*.txt
	test "${srcdir}" = "." || cp ${srcdir}/language/*.txt language
	echo "x" > $@

config/.tag: ${srcdir}/config/*.cfg ${srcdir}/config/*.srv
	test "${srcdir}" = "." || cp ${srcdir}/config/*.cfg config
	test "${srcdir}" = "." || cp ${srcdir}/config/*.srv config
	echo "x" > $@

sound: 
	ln -sf ${srcdir}/sound sound	

var:
	mkdir var

models: 
	ln -sf ${srcdir}/models models	

arenas: 
	ln -sf ${srcdir}/models arenas

 include Makefile.global



EDITEXTRA = Makefile.global.in
CLEANEXTRA= config.cache bindist

#		if  test -r ${srcdir}/doc/commands.txt ; then \
#			cp ${srcdir}/doc/commands.txt doc; \
#		else \
#			${MAKE} all; \
#			 ./armagetron --doc >> ${srcdir}/doc/commands.txt ||  rm ${srcdir}/doc/commands.txt; \
#			cp ${srcdir}/doc/commands.txt doc; \
#		fi ; \

# build documentation from M4 sources or just copy it
documentation:
	if test -r ${srcdir}/doc/index.html.m4 ; then \
		if  ! test -r ${srcdir}/doc/commands.txt ; then \
			${MAKE} all; \
			 ./armagetron --doc >> ${srcdir}/doc/commands.txt ||  rm ${srcdir}/doc/commands.txt; \
		fi ; \
		${MAKE} -C doc || echo Documentation build failed;  \
		${MAKE} -C doc/net || echo Documentation build failed; \
		rm -rf doc/commands.txt;\
	else \
		test ${srcdir} = . || cp -r ${srcdir}/doc/* doc; \
	fi

distclean: besenrein
	find -name "screen*.bmp" -exec rm -f \{\} \;
	find -name Makefile -exec rm -f \{\} \;
	find -name Makefile.global -exec rm -f \{\} \;
	find -name .nfs* -exec rm -f \{\} \;
	find -name gmon.out -exec rm -f \{\} \;
	find -name "*~" -exec rm -f \{\} \;
	find -name "*.o" -exec rm \{\} \;
	find -name "*.a" -exec rm \{\} \;
	find -name "*.ghost" -exec rm -f \{\} \;
	find -name makelog -exec rm -f \{\} \;
	find -name ".m4.dep" -exec rm -f \{\} \;
	find -name "*.ncb" -exec rm -f \{\} \;
	find -name "*.opt" -exec rm -f \{\} \;
	find -name "*.plg" -exec rm -f \{\} \;
	find -name "*.bmp" -exec rm -f \{\} \;
	find -name "leak.log" -exec rm -f \{\} \;
	find -name "memprofile*.txt" -exec rm -f \{\} \;
	find -name ".#*" -exec rm -f \{\} \;
	find -name "#*#" -exec rm -f \{\} \;
	find -name "ml" -exec rm -f \{\} \;
	rm -f config.cache config.status config.log config.h armagetron
	rm -rf bindist
	rm -rf src/prototye.*
	rm -rf src/textures
	rm -rf src/models
	rm -rf src/sound
	rm -rf src/music
	rm -rf log/*
	rm -f batch/starter batch/uninstall batch/install
	rm -f language/languages.txt
	rm -f a.out
	rm -f config/aiplayers.cfg
	rm -f astat master armagetron


bindist: all
	rm -rf bindist/* armagetron
	mkdir -p bindist
	cp ${srcdir}/COPYING.txt bindist

	find . -name "*~" -exec rm \{\} \;

	if [ "`$(CXX) -v 2>&1 | grep mingw`x" != "x" ] ; then \
	  cp ${srcdir}/tron.ico bindist;\
	  recode lat1..ibmpc bindist/*.txt;\
	  cp src/tron/armagetron bindist/armagetron.exe;\
	  cp `sdl-config --prefix`/lib/SDL.dll bindist/SDL.DLL;\
        else\
          cp src/tron/armagetron bindist/armagetron;\
        fi    

	mkdir bindist/bin

	mkdir bindist/log
	cp -r ${srcdir}/config bindist
	cp -r ${srcdir}/language bindist

	cp -r batch/*	       bindist/bin

	if test ${need_data} = yes ; then       \
	  cp -r ${srcdir}/arenas   bindist ;  \
	  cp -r ${srcdir}/textures bindist ;  \
	  cp -r ${srcdir}/sound bindist    ;  \
	  cp -r ${srcdir}/music bindist    ;  \
	  cp -r ${srcdir}/models bindist   ;  \
	  rm bindist/bin/masterstarter ; \
	  rm bindist/bin/serverstarter ; \
	else \
	  cp master bindist/bin ; \
	fi

	cp astat bindist/bin

# overwrite with local configuration
	cp -r language         bindist
	cp -r config   	       bindist
#	cp -rL bindist/doc .

#compose documentation
	${MAKE} documentation

	cp -r doc bindist/doc

	find ./bindist/doc    -name ".m4.dep" -exec rm -f \{\} \;
	find ./bindist/doc    -name "*.m4" -exec rm \{\} \;
	find ./bindist/doc    -name "Makefile*" -exec rm \{\} \;
	find ./bindist/doc    -name "*.ghost" -exec rm \{\} \;
	find ./bindist        -name "makelog" -exec rm \{\} \;
	find ./bindist        -name "*~" -exec rm \{\} \;
	find ./bindist -depth -name "CVS" -exec rm -rf \{\} \;
	find ./bindist        -name ".cvsignore" -exec rm -f \{\} \;
	find ./bindist -depth -name "*.in" -exec rm -rf \{\} \;
	find ./bindist        -name "ml" -exec rm -f \{\} \;

	chmod 755 bindist/bin/*

	if test ${need_data} = no ; then \
		mv bindist/bin/serverstarter bindist/bin/serverstarter-armagetron ;\
		mv bindist/bin/masterstarter bindist/bin/masterstarter-armagetron ;\
		mkdir bindist/rc.d						      ;\
		mv bindist/bin/rcd_server bindist/rc.d/armagetron		      ;\
		mv bindist/bin/rcd_master bindist/rc.d/armagetron-master	      ;\
	fi

	mv bindist/armagetron bindist/bin
	mv bindist/bin/install bindist/

install: bindist
	cd bindist ; ./install

install_force: bindist
	cd bindist ; ./install -f

update: bindist
	cd bindist ; ./install -u

uninstall: bindist
	./bindist/bin/uninstall

#*********************************************************
#                  Autoconf:                             *
#*********************************************************


include ${srcdir}/.infiles

${srcdir}/.infiles: ${srcdir}/configure.in
	echo "infiles: \\" > ${srcdir}/.infiles
	find ${srcdir} -name "*.in" | grep -v configure | grep -v macosx | sed -e "s|${srcdir}/||" -e "s|\.in| \\\|" >> ${srcdir}/.infiles
	echo "" >> ${srcdir}/.infiles
	chmod 666 ${srcdir}/.infiles

%: ${srcdir}/%.in config.status
	./config.status $@

src/%: ${srcdir}/src/%.in config.status
	./config.status $@

doc/%: ${srcdir}/doc/%.in config.status
	./config.status $@

config/%: ${srcdir}/config/%.in config.status
	./config.status $@

language/%: ${srcdir}/language/%.in config.status
	./config.status $@

batch/%: ${srcdir}/batch/%.in config.status
	./config.status $@

config.h: config.h.stamp

config.h.stamp: ${srcdir}/config.h.in config.status
	./config.status config.h
	echo timestamp > config.h.stamp

config.status: ${srcdir}/configure
	./config.status --recheck
	./config.status
	echo timestamp > config.h.stamp

${srcdir}/configure: ${srcdir}/configure.in #${srcdir}/aclocal.m4
	cd ${srcdir} && autoconf
	chmod 777 ${srcdir}/configure

# autoheader might not change config.h.in, so touch a stamp file.
#${srcdir}/config.h.in: ${srcdir}/stamp-h.in
#${srcdir}/stamp-h.in: ${srcdir}/configure.in ${srcdir}/aclocal.m4 ${srcdir}/acconfig.h \
#	${srcdir}/config.h.top ${srcdir}/config.h.bot
#	cd ${srcdir} && autoheader
#	echo timestamp > ${srcdir}/stamp-h.in

#config.h: stamp-h
#stamp-h: ${srcdir}/config.h.in config.status
#	./config.status

