# this makefile is for Aztec 3.6 only.

# this makes the final no-debug version:

ram\:Tripppin : trip.o board.o event.o menu.o jrdobbs.o
	ln +q -o ram:Tripppin trip.o menu.o board.o event.o jrdobbs.o -lc
	@dr -l ram:trip\#?

trip.o : trip.c trip.h
	cc +iw:II trip

menu.o : menu.c trip.h
	cc +iw:II +iw:INTU menu

board.o : board.c trip.h
	cc +iw:II board

event.o : event.c trip.h
	cc +iw:II +iw:INTU event

jrdobbs.o : jrdobbs.c trip.h
	cc +iw:II +iw:INTU jrdobbs


# this is for debugging with SDB or DB:

P = -dprivate

s : ram:strip

ram\:strip : dtrip.o dboard.o devent.o dmenu.o djrdobbs.o
	ln +q -w -g -o ram:strip dtrip.o dmenu.o dboard.o devent.o djrdobbs.o -lc
	@dr -l ram:strip\#?

dtrip.o : trip.c trip.h
	cc -n -o dtrip.o +iw:II $P trip

dmenu.o : menu.c trip.h
	cc -n -o dmenu.o +iw:II +iw:INTU $P menu

dboard.o : board.c trip.h
	cc -n -o dboard.o +iw:II $P board

devent.o : event.c trip.h
	cc -n -o devent.o +iw:II +iw:INTU $P event

djrdobbs.o : jrdobbs.c trip.h
	cc -n -o djrdobbs.o +iw:II +iw:INTU $P jrdobbs
