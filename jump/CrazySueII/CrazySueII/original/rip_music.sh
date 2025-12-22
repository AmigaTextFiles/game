xfddecrunch Crazy_Sue_II.exe cs2.bin

cut cs2.bin songs.dat 206872 18876
cut cs2.bin samps.dat 245348 56754

phxass rip_music quiet
rip_music

delete songs.dat samps.dat rip_music cs2.bin

set a "mod.crazy-sue2"
set b "by DJ Braincrack, from ***"Crazy Sue II***" game"

filenote $a.1 "$b - level 4"
filenote $a.2 "$b - level 1 indoors"
filenote $a.3 "$b - level 2"
filenote $a.4 "$b - level 3"
filenote $a.5 "$b - title / level 1"
filenote $a.6 "$b - finale"
