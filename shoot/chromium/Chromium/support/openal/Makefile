all: linux

include ../../config.mak

linux: FORCE
	mkdir -p ./lib
	cd linux; sh autogen.sh; $(OPENAL_CONFIG_OPTS); $(MAKE)
	cp ./linux/src/libopenal.a ./lib

clean:
	-rm -f ./linux/config.cache
	-rm -f ./linux/config.log
	-rm -f ./linux/config.status
	-rm -f ./lib/libopenal.a
	-rm -f *.bck
	( cd linux ; $(MAKE) distclean )

FORCE:
