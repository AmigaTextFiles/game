CC = pgcc -V 2.95.2 -warpup
CXX = pg++ -V 2.95.2 -warpup
LD = /ade/ppc-amigaos-bin/ld
RANLIB = /ade/bin/ppc-amigaos-ranlib
NM = /ade/bin/ppc-amigaos-nm
OBJDUMP = /ade/bin/pobjdump
AR = /ade/bin/ppc-amigaos-ar
AS = /ade/bin/ppc-amigaos-as
STRIP = /ade/bin/ppc-amigaos-strip

# Set these two variables accordingly.
# BASEPATH is the location of the quake2 source directory, including this directory itself
# INSTALLDIR is where the binaries should be copied to.
BASEPATH = work:q2max
INSTALLDIR = work:q2max

BASECFLAGS = -I$(BASEPATH) -I$(BASEPATH)/game -I$(BASEPATH)/amiga -I$(BASEPATH)/client \
	     -I$(BASEPATH)/ctf -I$(BASEPATH)/qcommon -I$(BASEPATH)/server -I$(BASEPATH)/ref_soft \
	     -DAMIGA -D_inline="static __inline" -D__int64="long long" -DQ2MAX \
	     -D__stdcall= -DENDIAN_INLINE \
	     -D_DEVEL 

OPTIMIZE = -O3
DEBUG = -g

CFLAGS = $(BASECFLAGS) $(OPTIMIZE) $(LOCAL_CFLAGS) $(DEBUG)

LIBS = -ldllppc -lppcamiga -ldebug

$(PRODUCT): $(OBJ) $(EXTRA_DEPS)
	$(CC) -o $(PRODUCT) $(OBJ) $(LIBS) $(EXTRA_LIBS)

clean:
	-rm $(OBJ) $(PRODUCT)

install:
	cp $(PRODUCT) $(INSTALLDIR)/$(INSTLOCATION)$(PRODUCT)
