xfddecrunch Crazy_Sue.exe cs.bin

;what	mod1	mod2	mod3	mod4	mod5	mod6	mod7	mod8	samps
;offset	$25d00	$2a13c	$2c578	$2edb4	$30df0	$34a2c	$38a68	$3a6a4	$3aee0
;length	17468	9276	10300	8252	15420	16444	7228	2108	40982

cut cs.bin mod1 154880 17468
cut cs.bin mod2 172348 9276
cut cs.bin mod3 181624 10300
cut cs.bin mod4 191924 8252
cut cs.bin mod5 200176 15420
cut cs.bin mod6 215596 16444
cut cs.bin mod7 232040 7228
cut cs.bin mod8 239268 2108 
cut cs.bin smps 241376 40982

set a "mod.hop'n'run"
set b "by DJ Braincrack, from ***"Crazy Sue***" game"

join mod1 smps as $a-1
join mod2 smps as $a-2
join mod3 smps as $a-3
join mod4 smps as $a-4
join mod5 smps as $a-5
join mod6 smps as $a-6
join mod7 smps as $a-7
join mod8 smps as $a-8

delete mod[1-8] smps cs.bin

filenote $a-1 "$b - titles / stage 1 / 7 outside"
filenote $a-2 "$b - stage 2"
filenote $a-3 "$b - stage 8"
filenote $a-4 "$b - stage 4"
filenote $a-5 "$b - stage 5 / stage 4 secret / ending"
filenote $a-6 "$b - stage 7 inside"
filenote $a-7 "$b - stage 3"
filenote $a-8 "$b - stage 9"

