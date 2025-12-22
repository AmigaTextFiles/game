NAME	= SolidGold
CC	= vc
COPTS	= -O1
AS	= vasmm68k_mot
ASOBJ	= -Fvobj
ASBIN	= -Fbin
#ASOPTS	= -quiet -x -DCOPPERBACK -DBOOTLOGO -DKILLOS -DTDFORMAT -DDEBUG
ASOPTS	= -quiet -x -DCOPPERBACK -DBOOTLOGO -DKILLOS -DTDFORMAT
ASINC	= -I :SDK/NDK_3.9/Include/include_i
LD	= vlink
LDOPTL	= -brawbin1 -minalign 2
LDOPTG	= -brawseg -q -minalign 2
RM	= delete force quiet
CAT	= join AS $@
DO_AS	= $(AS) $(ASOBJ) $(ASOPTS) $(ASINC) -o $@ $<

include make.common
