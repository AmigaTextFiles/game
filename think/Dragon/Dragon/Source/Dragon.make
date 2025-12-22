; Make file for my custom make utility.
; Basically assemble DragStart.s, compile *.c with SCOPTIONS
; (I've used GST's for speed here) and link the lot together.

FOR  OBJS:DragStart.o
DO   genam INCDIR INCLUDE: ALINK DragStart.s TO OBJS:DragStart.o
WHEN DragStart.s Dragon.make

FOR  OBJS:Dragon.gst
DO   sc makegst=OBJS:Dragon.gst Dragon.c
WHEN Dragon.h DragonDefs.h Dragon.make

FOR  OBJS:Dragon.o
DO   sc Dragon.c
WHEN Dragon.c Dragon.make

FOR  OBJS:DragDisp.o
DO   sc DragDisp.c
WHEN DragDisp.c Dragon.make

FOR  Dragon
DO   slink with Dragon.link
WHEN OBJS:DragStart.o OBJS:Dragon.o OBJS:DragDisp.o Dragon.link

