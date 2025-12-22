# Amiga Descent Makefile
#
# $Revision: 1.12 $
# $Log: Makefile,v $
# Revision 1.12  1999/03/10 23:26:36  nobody
# Warp3D V2 adaption
#
# Revision 1.11  1999/02/23 23:50:26  nobody
# *** empty log message ***
#
# Revision 1.10  1998/12/21 17:12:13  nobody
# *** empty log message ***
#
# Revision 1.9  1998/09/26 14:59:42  nobody
# Added Warp3D support
#
# Revision 1.8  1998/08/11 14:39:03  nobody
# Moved editor to root
#
# Revision 1.7  1998/08/08 15:51:09  nobody
# Activated the Editor
#
# Revision 1.6  1998/04/13 14:33:08  tfrieden
# Added kali
#
# Revision 1.5  1998/04/09 16:08:06  tfrieden
# Added more switches for optimization
#
# Revision 1.4  1998/04/02 13:41:31  tfrieden
# *** empty log message ***
#
# Revision 1.3  1998/03/25 22:49:55  tfrieden
# *** empty log message ***
#
# Revision 1.1.1.1  1998/03/03 15:11:45  nobody
# reimport after crash from backup
#
# Revision 1.3  1998/02/25 21:18:15  hfrieden
# Added 'Amiga' directory
#

DIRS = kali Amiga 2d 3d bios cfile fix iff mem misc texmap vecmat main # editor ui pslib main
CC = gcc
CPU20 = -m68020 -Wa,-mno-68882 -Wa,-mno-68881
CPU40 = -m68040
CPU60 = -m68060
EDITOR = -DEDITOR
WARP = -DWARP3D
OPTIONS = $(CPU60) $(WARP) -DWANT_IPX -DWANT_KALI# -DWANT_FPU
CFLAGS=-g -gstabs $(OPTIONS) -O2 -Drand=myrand -fstrength-reduce -msmall-code -fomit-frame-pointer -fbaserel32
INCLUDES=-I../includes

all: subdirs

subdirs:
	-rm adescent
	set -e; for i in $(DIRS); do $(MAKE) -C $$i CFLAGS="$(CFLAGS)" INCLUDES=$(INCLUDES); done

clean:
	rm  objects/*.o
	rm -f lib/*.a
	rm -f adescent
