# Amiga Specific Stuff Makefile
#
# $Revision: 1.13 $
# $Author: nobody $
# $Log: Makefile,v $
# Revision 1.13  1998/09/26 15:06:38  nobody
# Added Warp3D support
#
# Revision 1.12  1998/08/08 15:52:50  nobody
# Activated the Editor
#
# Revision 1.11  1998/04/13 17:46:34  tfrieden
# *** empty log message ***
#
# Revision 1.10  1998/04/11 22:18:00  hfrieden
# Added amiga_serial.c
#
# Revision 1.9  1998/04/09 16:51:35  hfrieden
# Added CPU specific virge stuff
#
# Revision 1.8  1998/04/09 16:08:27  tfrieden
# Added error hanlder
#
# Revision 1.7  1998/04/05 01:53:47  tfrieden
# *** empty log message ***
#
# Revision 1.6  1998/03/30 18:31:54  hfrieden
# asmdraw.o added to libami.a
#
# Revision 1.5  1998/03/27 00:53:04  tfrieden
# *** empty log message ***
#
# Revision 1.4  1998/03/22 16:24:20  hfrieden
# WBArg.c added to Makefile
#
# Revision 1.3  1998/03/22 16:22:31  tfrieden
# Fixpoint stuff added
#
# Revision 1.2  1998/03/15 18:47:12  hfrieden
# Added Hunk2tobj calls
#
# Revision 1.1.1.1  1998/03/03 15:12:41  nobody
# reimport after crash from backup
#
# Revision 1.3  1998/02/28 00:50:40  tfrieden
# C2P stuff
#
# Revision 1.2  1998/02/27 20:11:22  hfrieden
# Initial Checkin
#
# Revision 1.1  1998/02/25 21:16:41  hfrieden
# Initial Checkin
#
#
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libami.a
LIB_OBJS = \
	$(OBJDIR)/JoyDriv.o $(OBJDIR)/VBRtn.o $(OBJDIR)/c2p_8_040.o $(OBJDIR)/VirgeTexture.o \
	$(OBJDIR)/fix_int_asm.o $(OBJDIR)/fix_fpu_asm.o $(OBJDIR)/WBArg.o $(OBJDIR)/asmdraw.o \
	$(OBJDIR)/amiga_median.o $(OBJDIR)/c2p_6_040.o $(OBJDIR)/gr_kludge.o \
	$(OBJDIR)/amiga_sega.o $(OBJDIR)/Int3_Error.o $(OBJDIR)/amiga_serial.o \
	$(OBJDIR)/virge_fpu.o $(OBJDIR)/virge_int.o $(OBJDIR)/amiga_socket.o \
	$(OBJDIR)/Warp3D.o

all: $(LIB) #$(OBJDIR)/VBRtn.o

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/virge_fpu.o: virge_fpu.c
	gcc -m68060 -m68881 -g  -O3 -fexpensive-optimizations -DVIRGIN -DVIRGIN_DBUF $(INCLUDES) -o $(OBJDIR)/virge_fpu.o -c virge_fpu.c -fbaserel32 -fomit-frame-pointer


$(OBJDIR)/gr_kludge.o: gr_kludge.c
	sc cpu=020 gr_kludge.c nostkchk ObjectName kludge.o
	hunk2tobj kludge.o
	mv t:obj.o $(OBJDIR)/gr_kludge.o
	rm kludge.o

$(OBJDIR)/fix_int_asm.o: fix.a
	SC CPU=68020 fix.a ObjectName fix_int_asm.o
	hunk2tobj fix_int_asm.o
	mv t:obj.o $(OBJDIR)/fix_int_asm.o
	rm fix_int_asm.o

$(OBJDIR)/amiga_sega.o: amiga_sega.s
	SC CPU=68020 amiga_sega.s
	hunk2tobj amiga_sega.o
	mv t:obj.o $(OBJDIR)/amiga_sega.o
	rm amiga_sega.o

$(OBJDIR)/fix_fpu_asm.o: fix_fpu.s
	sc cpu=020 math=8 fix_fpu.s ObjectName fix_fpu_asm.o
	hunk2tobj fix_fpu_asm.o
	mv t:obj.o $(OBJDIR)/fix_fpu_asm.o
	rm fix_fpu_asm.o

$(OBJDIR)/VBRtn.o: VBRtn.asm
	SC VBRtn.asm ObjectName VBRtn.o
	hunk2tobj VBRtn.o
	mv t:obj.o $(OBJDIR)/VBRtn.o
	rm VBRtn.o

$(OBJDIR)/asmdraw.o: asmdraw.s
	SC asmdraw.s ObjectName asmdraw.o
	hunk2tobj asmdraw.o
	mv t:obj.o $(OBJDIR)/asmdraw.o
	rm asmdraw.o

$(OBJDIR)/c2p_8_040.o: c2p_040.s
	SC c2p_040.s ObjectName c2p_8_040.o
	hunk2tobj c2p_8_040.o
	mv t:obj.o $(OBJDIR)c2p_8_040.o
	rm c2p_8_040.o

$(OBJDIR)/c2p_6_040.o: c2p_040.s
	SC c2p_040.s ObjectName c2p_6_040.o
	hunk2tobj c2p_6_040.o
	mv t:obj.o $(OBJDIR)c2p_6_040.o
	rm c2p_6_040.o



$(OBJDIR)/%.o: %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
