pt2.3bV6_replay.o:  extSource/pt2.3bV6_replay.s include/global.i
 /PhxAss/bin/PhxAss from extSource/pt2.3bV6_replay.s to pt2.3bV6_replay.o NOEXE OPT nrqbtlp
spod: main.s os.s pt2.3bV6_replay.o include/global.i
 /PhxAss/bin/PhxAss from main.s to main.o DS NOEXE OPT nrqbtlp
 /PhxLnk/OS2.x/PhxLnk from main.o pt2.3bV6_replay.o KICK1 to spod
 delete main.o 
#pt2.3bV6_replay.o:  extSource/pt2.3bV6_replay.s include/global.i
# /vasm/vasmm68k_mot extSource/pt2.3bV6_replay.s -o pt2.3bV6_replay.o -Fhunk -kick1hunks -opt-speed
#spod: main.s os.s pt2.3bV6_replay.o include/global.i
# /vasm/vasmm68k_mot main.s -o main.o -Fhunk -opt-speed -kick1hunks 
# /vasm/vlink -s main.o pt2.3bV6_replay.o -bamigahunk -o spod
# delete main.o   
