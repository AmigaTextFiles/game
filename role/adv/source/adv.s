;********************************

		include "ram:makros_2"
start:
		sys_init			;Screen oeffnen + Plane Adressen
						;sichern
start2:
		get_mem #50000,#$30001
		cmp.l #0,d0
		beq end_error3
		move.l d0,pic			;farben
		add.l #100,d0
		move.l d0,ele			;da fangen elemente an

		get_mem #62600*2,#$30001
		cmp.l #0,d0
		beq end_error2
		move.l d0,dungeon		;Oberwelt
		move.l d0,d1
		add.l #62600,d1
		move.l d1,dungeon2		;Dungeon
		add.l #25,d0
		add.l #2500+5+5+25*250+1,d0
		move.l d0,dun_start
		add.l #5+1250,d0
		move.l d0,hier

		get_mem #30000,#Chip_Ram
		cmp.l #0,d0
		beq end_error1
		move.l d0,bobs
		add.l #15000,d0
		move.l d0,bobs2

		get_mem #10000,#$30001
		cmp.l #0,d0
		beq end_error0
		move.l d0,char_set
		add.l #5000,d0
		move.l d0,window_txt
		add.l #700,d0
		move.l d0,icon_bar
		add.l #412,d0
		move.l d0,stat
		add.l #492,d0
		move.l d0,stat1

		get_mem #11000,#$30001
		cmp.l #0,d0
		beq end_error0a
		move.l d0,city

		open_buffer #500
		;loadb "ram:ober",pic,#49100
		loadb "adv:elemente/ober",pic,#49100
		color #0,#0,#0,#0
		set_pal pic			;Farben setzen
		loadb "adv:grafik/dchar",char_set,#5000
		loadb "adv:grafik/dwin",window_txt,#5000
		loadb "adv:grafik/dicon",icon_bar,#5000
		loadb "adv:grafik/dstat0",stat,#5000
		loadb "adv:grafik/dstat1",stat1,#5000
		set_charset char_set

		loadb "adv:dungeons/ober",dungeon,#62600
		;loadb "ram:ober2",dungeon,#62600
		loadb "adv:dungeons/down",dungeon2,#62600
		bsr init_dun
		back
		set_charb #22,#0,window_txt
		set_charb #0,#176,icon_bar
		set_charb #20,#160,stat
		print #0,#3,#176,"______________"
		ptext #102,#7,#176,dungeon
		bsr draw_map

		print #101,#21,#189,"KR:"
		print #101,#21,#205,"GS:"
		print #101,#21,#221,"FD:"
		print #101,#21,#237,"GO:"
		print #101,#32,#221,"EX:"
		print #101,#29,#189,"WF:"
		print #101,#29,#205,"RS:"

		print #101,#23,#168,"HU:"
		print #101,#23,#176,"MU:"
		print #101,#34,#237,"INV"

		loadb "adv:bobs/mon.bob",bobs,#15000
		loadb "adv:bobs/waff.bob",bobs2,#15000

		move.b #17,jahr			;Es geschah am
		move.b #11,monat		;07.05.17
		move.b #7,day

		move.b monat,d0
		and.l #255,d0
		sub.l #1,d0
		lea temp_monat,a0
		move.b (a0,d0),temperatur

		move.b #0,regen
		move.b #0,tag
		move.b #10,stunde
		move.b #1,minute
		move.b #1,sekunde
		move.b #0,ticks
		move.b #3,wie_viel_sek		;10
		move.b #0,sleep			;person ist wach
		move.b #0,anim
		move.b #0,pause
		move.l #100,kraft
		move.l #100,max_kraft
		move.l #100,gesund
		move.l #200,essen
		move.l #1005,geld
		move.l #1,exper
		move.b #0,muede
		move.l #2350,konto0
		move.l #9991,konto1
		move.l #0,hunger
		move.l #4,gewicht
		move.b #0,hgesagt
		move.b #0,inv
		move.l #0,sprite
		move.b #0,licht
		move.b #0,unten			;Person ist "oben"
		bsr werte
		set_block_2 #80,#80,bobs,sprite	;Spieler Sprite

		flip_page
		equ_screen

		set_int #interupt	;Interupt initialisieren
loop:
		cmp.b #1,regen
		beq.s loop0
		rnd16
		and.w #$fff0,d6
		cmp.w #0,d6
		bne.s loop00
		move.b #1,regen
loop0:
		rnd
		cmp.b #1,d0
		beq.s loop00
		move.b 0,regen
loop00:
		;bsr wellen
		bsr draw_map
		bsr uhr
		bsr print_text
		set_block_2 #80,#80,bobs,sprite	;Spieler Sprite
		bsr werte
		bsr hunger_print
		flip_page
		cmp.b #90,muede
		bgt tot2
		bra tot
loop1:
		key
		cmp.b #96,d0			;ESC = Exit
		beq end
		cmp.b #28,d0
		beq up
		cmp.b #29,d0
		beq down
		cmp.b #31,d0
		beq links
		cmp.b #30,d0
		beq rechts
		cmp.b #"P",d0
		beq Bild_schoner
		cmp.b #"E",d0
		beq eat
		cmp.b #"B",d0
		beq betreten
		cmp.b #"S",d0
		beq schlaf
		cmp.b #"I",d0
		beq inventory
		cmp.b #"L",d0
		beq leucht
		btst #6,$bfe001
		bne loop
		bsr maus

		lea tablel(pc),a0
		lea keyl(pc),a1
		bra ongoto_b

keyl:		dc.l 1193,1194,1195,1196,1197
		dc.l 1198,1233,1234,1235,1236
		dc.l 1237,1238
		dc.l 867,868,869,907,908,909,947,948,949
		dc.l 875,876,877,915,916,917,955,956,957
		dc.l 1028,1029,1030,1068,1069,1070,1108,1109,1110
		dc.l 1032,1033,1034,1072,1073,1074,1112,1113,1114
		dc.l 1036,1037,1038,1076,1077,1078,1116,1117,1118
		dc.l 937,938,977,978
		dc.l 1044,1045,1084,1085
		dc.l 924,925,964,965
		dc.l 1164,1165,1204,1205
		dc.l 1041,1042,1081,1082
		dc.l 1047,1048,1087,1088
		dc.l 1171,1172,1211,1212
		dc.l 1054,1055,1094,1095
		dc.l 0

tablel:		dc.l inventory,inventory,inventory,inventory,inventory
		dc.l inventory,inventory,inventory,inventory,inventory
		dc.l inventory,inventory
		dc.l h_l,h_l,h_l,h_l,h_l,h_l,h_l,h_l,h_l
		dc.l h_r,h_r,h_r,h_r,h_r,h_r,h_r,h_r,h_r
		dc.l ta_0,ta_0,ta_0,ta_0,ta_0,ta_0,ta_0,ta_0,ta_0
		dc.l ta_1,ta_1,ta_1,ta_1,ta_1,ta_1,ta_1,ta_1,ta_1
		dc.l ta_2,ta_2,ta_2,ta_2,ta_2,ta_2,ta_2,ta_2,ta_2
		dc.l schlaf,schlaf,schlaf,schlaf
		dc.l betreten,betreten,betreten,betreten
		dc.l up,up,up,up
		dc.l down,down,down,down
		dc.l links,links,links,links
		dc.l rechts,rechts,rechts,rechts
		dc.l eat,eat,eat,eat
		dc.l leucht,leucht,leucht,leucht
		dc.l loop
leucht:
		cmp.b #1,licht
		beq leucht_aus
		lea hand_links,a0
		move.l (a0),a0
		move.l 26(a0),d0
		cmp.l #255,d0
		beq leucht2
		lea hand_rechts,a0
		move.l (a0),a0
		move.l 26(a0),d0
		cmp.l #255,d0
		beq leucht2
		bsr text_up
		move.l #pr_nix_licht,zeile_10
		bsr text_up
		move.l #pr_nix_licht2,zeile_10
		bra loop
leucht2:
		lea lampe,a0
		move.l #10,30(a0)
		bsr text_up
		move.l #pr_licht,zeile_10
		move.b #1,licht
		move.b #1,inv
		bra inventory2
leucht_aus:
		lea lampe,a0
		move.l #9,30(a0)
		move.b #0,licht
		bsr text_up
		move.l #pr_licht2,zeile_10
		move.b #1,inv
		bra inventory2
maus:
		print #0,#33,#190,"______"
		get_xy
		lsr.l #3,d0
		lsr.l #3,d1
		mulu #40,d1
		add.l d1,d0
		and.l #$FFFF,d0
		zahlr #101,#33,#190,d0
		rts
ongoto_b:
		moveq #0,d2
		moveq #0,d1
ongotob2:
		move.l (a1)+,d1
		cmp.l d0,d1
		beq.s ongotob3
		cmp.l #0,d1
		beq.s ongotob3
		addq #1,d2
		bra ongotob2
ongotob3:
		lsl #2,d2
		move.l 0(a0,d2),a0
		jmp (a0)
h_l:
		front
		equ_screen
		back
		cmp.b #0,inv
		beq loop
		lea hand_links(pc),a0
		bra wo_anders
h_r:
		front
		equ_screen
		back
		cmp.b #0,inv
		beq loop
		lea hand_rechts(pc),a0
		bra wo_anders
ta_0:
		front
		equ_screen
		back
		cmp.b #0,inv
		beq loop
		lea tasche0(pc),a0
		bra wo_anders
ta_1:
		front
		equ_screen
		back
		cmp.b #0,inv
		beq loop
		lea tasche1(pc),a0
		bra wo_anders
ta_2:
		front
		equ_screen
		back
		cmp.b #0,inv
		beq loop
		lea tasche2(pc),a0
		bra wo_anders

w_sprite:	dc.l 0			;das ist es
x_sprite:	dc.w 0			;alte Sprite Pos
y_sprite:	dc.w 0

wo_anders:
		move.l a0,welcher_shop1		;daher kommt der Gegenstand
		move.l (a0),a0
		move.l 30(a0),d5
		cmp.l #0,d5			;kein Gegenstand
		beq loop			;und bye
		move.l a0,welcher_shop2		;Gegenstand sichern

		move.l d5,w_sprite		;Sprite Nummer sichern

		front
		equ_screen
		clr_pointer
		get_xy
		move.w d0,x_sprite
		move.w d1,y_sprite
		sprite x_sprite,y_sprite,bobs2,w_sprite,#4
wo_anders2:
		wait_vblb
		sprite x_sprite,y_sprite,bobs2,w_sprite,#0
		get_xy
		move.w d0,x_sprite
		move.w d1,y_sprite
		btst #6,$bfe001
		bne wo_anders2

		bsr maus
		lea tablel2(pc),a0
		lea keyl2(pc),a1
		bra ongoto_b

keyl2:
		dc.l 867,868,869,907,908,909,947,948,949
		dc.l 875,876,877,915,916,917,955,956,957
		dc.l 1028,1029,1030,1068,1069,1070,1108,1109,1110
		dc.l 1032,1033,1034,1072,1073,1074,1112,1113,1114
		dc.l 1036,1037,1038,1076,1077,1078,1116,1117,1118
		dc.l 0

tablel2:
		dc.l h_lb,h_lb,h_lb,h_lb,h_lb,h_lb,h_lb,h_lb,h_lb
		dc.l h_rb,h_rb,h_rb,h_rb,h_rb,h_rb,h_rb,h_rb,h_rb
		dc.l ta_0b,ta_0b,ta_0b,ta_0b,ta_0b,ta_0b,ta_0b,ta_0b,ta_0b
		dc.l ta_1b,ta_1b,ta_1b,ta_1b,ta_1b,ta_1b,ta_1b,ta_1b,ta_1b
		dc.l ta_2b,ta_2b,ta_2b,ta_2b,ta_2b,ta_2b,ta_2b,ta_2b,ta_2b
		dc.l wo_anders2

h_lb:
		equ_screen
		back
		set_pointer #0
		lea hand_links(pc),a0
		move.l welcher_shop1,a1
		move.l (a0),(a1)
		move.l welcher_shop2,(a0)
		bra inventory2
h_rb:
		equ_screen
		back
		set_pointer #0
		lea hand_rechts(pc),a0
		move.l welcher_shop1,a1
		move.l (a0),(a1)
		move.l welcher_shop2,(a0)
		bra inventory2
ta_0b:
		equ_screen
		back
		set_pointer #0
		lea tasche0(pc),a0
		move.l welcher_shop1,a1
		move.l (a0),(a1)
		move.l welcher_shop2,(a0)
		bra inventory2
ta_1b:
		equ_screen
		back
		set_pointer #0
		lea tasche1(pc),a0
		move.l welcher_shop1,a1
		move.l (a0),(a1)
		move.l welcher_shop2,(a0)
		bra inventory2
ta_2b:
		equ_screen
		back
		set_pointer #0
		lea tasche2(pc),a0
		move.l welcher_shop1,a1
		move.l (a0),(a1)
		move.l welcher_shop2,(a0)
		bra inventory2

inventory:
		front
		equ_screen
		back
		eor.b #1,inv
		cmp.b #1,inv
		beq inventory2
		bsr inventory1b
		bra loop
inventory1b:
		set_charb #20,#160,stat
		print #101,#21,#189,"KR:"
		print #101,#21,#205,"GS:"
		print #101,#21,#221,"FD:"
		print #101,#21,#237,"GO:"
		print #101,#32,#221,"EX:"
		print #101,#29,#189,"WF:"
		print #101,#29,#205,"RS:"
		print #101,#23,#168,"HU:"
		print #101,#23,#176,"MU:"
		print #101,#34,#237,"INV"
		bsr draw_map
		;set_block_2 #80,#80,bobs,sprite	;Spieler Sprite
		flip_page
		equ_screen
		rts
inventory2:
		bsr inventory3
		bra loop
inventory3:
		cmp.b #1,licht
		beq licht_test
inventory4:
		set_charb #20,#160,stat1
		print #101,#23,#170,"Hand"
		print #101,#23,#180,"link"

		print #101,#31,#170,"Hand"
		print #101,#31,#180,"rech"

		print #101,#34,#237,"INV"
		print #101,#21,#202,"Tasche"
		print #101,#21,#211,"1_-_3"
		cmp.b #1,sleep
		beq invent4b
		bsr draw_map
invent4b:	lea hand_rechts(pc),a0
		move.l (a0),a0
		move.l 30(a0),d5
		set_block_2 #284,#172,bobs2,d5

		lea hand_links(pc),a0
		move.l (a0),a0
		move.l 30(a0),d5
		set_block_2 #220,#172,bobs2,d5

		lea tasche0(pc),a0
		move.l (a0),a0
		move.l 30(a0),d5
		cmp.b #10,d5
		bne.s inv5
		moveq #9,d5
inv5:		set_block_2 #228,#204,bobs2,d5

		lea tasche1(pc),a0
		move.l (a0),a0
		move.l 30(a0),d5
		cmp.b #10,d5
		bne.s inv6
		moveq #9,d5
inv6:		set_block_2 #258,#204,bobs2,d5

		lea tasche2(pc),a0
		move.l (a0),a0
		move.l 30(a0),d5
		cmp.b #10,d5
		bne.s inv7
		moveq #9,d5
inv7:		set_block_2 #290,#204,bobs2,d5

		print #101,#21,#237,"GO:"
		print #0,#25,#237,"_____"
		zahl #2,#25,#237,geld
		print #2,#21,#228,"Gew"
		print #0,#25,#228,"_____"
		zahl #2,#25,#228,gewicht
		cmp.b #1,sleep
		beq invent7b
		bsr draw_map
		;set_block_2 #80,#80,bobs,sprite	;Spieler Sprite
invent7b:	flip_page
		equ_screen
		rts

licht_test:
		lea hand_rechts(pc),a0
		move.l (a0),a0
		move.l 26(a0),d0
		cmp.l #255,d0
		beq inventory4
		lea hand_links(pc),a0
		move.l (a0),a0
		move.l 26(a0),d0
		cmp.l #255,d0
		beq inventory4
		lea lampe(pc),a0
		move.l #9,30(a0)
		move.b #0,licht
		bra inventory4

schlaf:
		cmp.b #6,muede
		blt schlaf4
		move.b #5,wie_viel_sek		;die Zeit soll 4 mal schneller
						;vergehen
		move.b #0,sekunde
		move.b #1,sleep			;Flag für das Schlafen
		bsr text_up
		move.l #pr_schlaf,zeile_10
		bsr hunger_print
		rectfill #0,#0,#0,#175,#175	;im Schlaf sieht man nichts
		print #1,#0,#10,"Chip_Ram:"
		get_fre #Chip_Ram
		zahlr #1,#17,#10,d0
		print #1,#0,#20,"Fast_Ram:"
		get_fre #Fast_Ram
		zahlr #1,#17,#20,d0
		flip_page
		front
		equ_screen
		back
schlaf2:
		bsr uhr
		bsr print_text
		bsr werte
		cmp.b #1,muede
		blt aufwachen
		key
		cmp.b #0,d0
		bne.s aufwachen2
		flip_page
		rnd16
		and.l #255,d0
		cmp.l #1,d0
		beq dieb
		bra schlaf2
aufwachen:
		move.b #0,muede
		move.b #0,sleep
		move.b #10,wie_viel_sek
		bsr text_up
		move.l #pr_wach,zeile_10
		bra loop
aufwachen2:
		cmp.b #1,muede
		bgt aufwachen3
		move.b #0,muede
aufwachen3:
		move.b #0,sleep
		move.b #10,wie_viel_sek
		bsr text_up
		move.l #pr_wach,zeile_10
		bra loop

schlaf4:
		bsr text_up
		move.l #pr_wach2,zeile_10
		bra loop
dieb:
		rnd
		cmp.b #1,d0
		bne schlaf2
		rnd
		cmp.b #1,d0
		bne dieb2
dieb_b:		rnd
		sub.l #1,d0
		and.l #255,d0
		cmp.l #4,d0
		bgt dieb_b
		lsl.l #2,d0
		lea hand_rechts(pc),a0
		add.l d0,a0
		lea nichts(pc),a1
		move.l a1,(a0)
		move.b #1,inv
		bsr welches_gewicht
		bsr inventory3
		move.b #0,inv
		delay #100
		bsr inventory1b
		bsr werte
		bra schlaf2
dieb2:
		cmp.l #0,geld
		beq schlaf2
		move.l #0,geld			;geld gestohlen
		move.b #0,inv
		bsr inventory1b
		bsr werte
		bra schlaf2
tot:
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		bra loop1
tot2:
end:
		kill_int			;Interupt entfernen
		close_buffer
		fre_mem #11000,city
		fre_mem #10000,char_set
		fre_mem #30000,bobs
		fre_mem #62600*2,dungeon
		fre_mem #50000,pic
		sys_exit
		moveq #0,d0			;alles okay
		rts
end_error0a:
		fre_mem #11000,city
end_error0:
		fre_mem #30000,bobs
end_error1:
		fre_mem #62600*2,dungeon
end_error2:
		fre_mem #50000,pic
end_error3:	sys_exit
		move.l #103,d0			;nicht genug Speicher
		rts
betreten:
		move.l hier,a0
		move.b (a0),d0
		lea table(pc),a0
		lea key(pc),a1
		jmp ongoto

table:		dc.l bank0,bank1,leer,f_shop0,f_shop0,f_shop0,f_shop0,f_shop0
		dc.l leer,arzt0,arzt1,kneipe0,kneipe1,cas0
		dc.l hotel,hotel,hotel,hotel
		dc.l waffen,waffen,waffen,waffen
		dc.l verkauf,leiter_up,leiter_down
		dc.l burg,burg,burg,burg,burg
		dc.l loop

key:		dc.b 235,236,234,215,216,217,218,219
		dc.b 230,220,221,241,242,233
		dc.b 237,238,239,240
		dc.b 222,223,224,225
		dc.b 232,208,209
		dc.b 210,211,212,213,214
		dc.b 0

		even

leiter_up:
		add.b #1,unten
		move.l dungeon2,a0
		move.l dun_start,a1
		sub.l a0,a1
		move.l dungeon,a0
		add.l a1,a0
		move.l a0,dun_start
		add.l #5+1250,a0
		move.l a0,hier
		front
		print #0,#3,#176,"______________"
		ptext #102,#7,#176,dungeon
		equ_screen
		back
		bra loop
leiter_down:
		sub.b #1,unten
		move.l dungeon,a0
		move.l dun_start,a1
		sub.l a0,a1
		move.l dungeon2,a0
		add.l a1,a0
		move.l a0,dun_start
		add.l #5+1250,a0
		move.l a0,hier
		front
		print #0,#3,#176,"______________"
		ptext #102,#7,#176,dungeon2
		equ_screen
		back
		bra loop
burg:
		move.l dun_start,dun_start2
		move.l hier,hier2
		move.l hier,a0
		move.b (a0),d0
		and.l #255,d0
		sub.l #210,d0
		mulu #18,d0
		lea Burg0(pc),a0
		add.l d0,a0
		load a0,city,#11000

		move.l city,a0
		move.b 13(a0),size_x
		move.b 14(a0),size_y

;*************** Eintrittspunkt finden **************
burg2:
		add.l #25,a0
		move.l #10000,d0
burg3:
		cmp.b #115,(a0)+
		dbeq d0,burg3
		sub.l #1,a0
		move.l a0,hier
		move.b size_x,d0
		and.l #255,d0
		mulu #5,d0
		add.l #5,d0
		sub.l d0,a0
		move.l a0,dun_start
		front
		print #0,#3,#176,"______________"
		ptext #102,#7,#176,city
		equ_screen
		back
		bra loop

Burg0:		dc.b "adv:dungeons/kin0",0
		dc.b "adv:dungeons/kin1",0
		dc.b "adv:dungeons/kin2",0
		dc.b "adv:dungeons/kin3",0
		dc.b "adv:dungeons/kin4",0

		even

verkauf:
		cmp.b #0,tag			;Bediehnung nur am Tag
		bne f_shop_zu
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
verkauf1:
		bsr test_verk
		cmp.l #0,d0
		bne nix_verkauf
		move.b #1,inv
		bsr welches_gewicht
		bsr inventory3
		move.l #pr_verk0,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_verk1,zeile_3
		move.l #pr_verk2,zeile_4
		move.l #pr_verk3,zeile_5
		move.l #pr_verk4,zeile_6
		move.l #pr_verk5,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
verkauf2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq verkauf3
		btst #6,$bfe001
		bne verkauf2
		bsr maus
		lea tablel666(pc),a0
		lea keyl666(pc),a1
		bra ongoto_b

keyl666:	dc.l 666,672
		dc.l 0

tablel666:	dc.l verkauf3,bank_exit
		dc.l verkauf2

verkauf3:
		bsr kein_platz3
		bsr welches_gewicht
		bsr inventory3
		bra verkauf1
test_verk:
		lea hand_rechts(pc),a0
		move.l (a0),a0
		move.l 18(a0),d0
		cmp.b #0,d0
		bne test_ver_ok
		lea hand_links(pc),a0
		move.l (a0),a0
		move.l 18(a0),d0
		cmp.b #0,d0
		bne test_ver_ok
		lea tasche0(pc),a0
		move.l (a0),a0
		move.l 18(a0),d0
		cmp.b #0,d0
		bne test_ver_ok
		lea tasche1(pc),a0
		move.l (a0),a0
		move.l 18(a0),d0
		cmp.b #0,d0
		bne test_ver_ok
		lea tasche2(pc),a0
		move.l (a0),a0
		move.l 18(a0),d0
		cmp.b #0,d0
		bne test_ver_ok
		moveq #1,d0
		rts
test_ver_ok:
		moveq #0,d0
		rts
nix_verkauf:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_nix_verk0,zeile_3
		move.l #pr_nix_verk1,zeile_4
		move.l #pr_nix_verk2,zeile_5
		move.l #pr_nix_verk3,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr print_text
		bsr werte
		flip_page
		equ_screen
		delay #200
		bra bank_exit
waffen:
		cmp.b #0,tag			;Bediehnung nur am Tag
		bne f_shop_zu
		move.b #1,inv
		bsr inventory3
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l hier,a0			;Zeiger auf Struktur berechnen
		move.b (a0),d0
		and.l #255,d0
		sub.l #222,d0
		mulu #84,d0
		lea waffen_dat0(pc),a0
		add.l d0,a0
		move.l a0,welcher_shop1
waffen1:
		move.l welcher_shop1,a0
		move.l (a0),zeile_0
		move.l #pr_leer,zeile_1
		move.l welcher_shop1,a0
		add.l #12,a0
		move.l (a0),zeile_2
		add.l #4,a0
		move.l (a0),zeile_3
		add.l #4,a0
		move.l (a0),zeile_4
		add.l #4,a0
		move.l (a0),zeile_5
		add.l #4,a0
		move.l (a0),zeile_6
		add.l #4,a0
		move.l (a0),zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
waffen2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq waffen3
		btst #6,$bfe001
		bne waffen2
		bsr maus
		lea tablel600(pc),a0
		lea keyl600(pc),a1
		bra ongoto_b

keyl600:	dc.l 666,672
		dc.l 0

tablel600:	dc.l waffen3,bank_exit
		dc.l waffen2
waffen3:
		bsr welches_gewicht
		bsr inventory3
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_waff_menu,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_waff_menu1,zeile_4
		move.l #pr_waff_menu2,zeile_5
		move.l #pr_waff_menu3,zeile_6
		move.l #pr_waff_menu4,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
waffen4:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq bank_exit
		cmp.b #"A",d0
		beq waffen_waff
		cmp.b #"B",d0
		beq waffen_ruest
		cmp.b #"C",d0
		beq waffen_gem
		btst #6,$bfe001
		bne waffen4
		bsr maus
		lea tablel601(pc),a0
		lea keyl601(pc),a1
		bra ongoto_b

keyl601:	dc.l 465,505,545,585
		dc.l 0

tablel601:	dc.l waffen_waff,waffen_ruest,waffen_gem,bank_exit
		dc.l waffen4
waffen_waff:
		move.l #pr_waff_menu,zeile_1
		move.l #pr_leer,zeile_2
		move.l welcher_shop1,a0
		add.l #36,a0
		move.l (a0),zeile_3
		add.l #4,a0
		move.l (a0),zeile_4
		add.l #4,a0
		move.l (a0),zeile_5
		add.l #4,a0
		move.l (a0),zeile_6
		add.l #4,a0
		move.l (a0),zeile_7
		add.l #4,a0
		move.l (a0),zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_waff_menu4,zeile_10
waffen_waff1:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq waffen3
		cmp.b #"A",d0
		beq waffe_a
		cmp.b #"B",d0
		beq waffe_b
		cmp.b #"C",d0
		beq waffe_c
		cmp.b #"D",d0
		beq waffe_d
		cmp.b #"E",d0
		beq waffe_e
		cmp.b #"F",d0
		beq waffe_f
		btst #6,$bfe001
		bne waffen_waff1
		bsr maus
		lea tablel602(pc),a0
		lea keyl602(pc),a1
		bra ongoto_b

keyl602:	dc.l 424,464,504,544,584,624,705
		dc.l 0

tablel602:	dc.l waffe_a,waffe_b,waffe_c,waffe_d,waffe_e,waffe_f,waffen3
		dc.l waffen_waff1
waffe_a:
		move.l welcher_shop1,a0
		add.l #36,a0
		bsr waffe_ok
		bra waffen3
waffe_b:
		move.l welcher_shop1,a0
		add.l #40,a0
		bsr waffe_ok
		bra waffen3
waffe_c:
		move.l welcher_shop1,a0
		add.l #44,a0
		bsr waffe_ok
		bra waffen3
waffe_d:
		move.l welcher_shop1,a0
		add.l #48,a0
		bsr waffe_ok
		bra waffen3
waffe_e:
		move.l welcher_shop1,a0
		add.l #52,a0
		bsr waffe_ok
		bra waffen3
waffe_f:
		move.l welcher_shop1,a0
		add.l #56,a0
		bsr waffe_ok
		bra waffen3
waffe_ok:
		move.l (a0),a0
		move.l 18(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt.s waff_zu_teuer
		bsr tasche_frei
		cmp.l #1,d2
		beq kein_platz
		sub.l d0,geld
		move.l a0,(a2)
		bsr inventory3
		rts
waff_zu_teuer:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_cas5,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		equ_screen
		delay #100
		rts
kein_platz:
		move.l #pr_waff_pl0,zeile_0
		move.l #pr_waff_pl1,zeile_1
		move.l #pr_waff_pl2,zeile_2
		move.l #pr_waff_pl3,zeile_3
		move.l #pr_waff_pl4,zeile_4
		move.l #pr_waff_pl5,zeile_5
		move.l #pr_waff_pl6,zeile_6
		move.l #pr_waff_pl7,zeile_7
		move.l #pr_waff_pl8,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_bank14,zeile_10
kein_platz2:
		bsr uhr
		bsr print_text
		flip_page
		key
		cmp.b #"J",d0
		beq kein_platz3
		cmp.b #"N",d0
		beq kein_platz_b
		btst #6,$bfe001
		bne kein_platz2
		bsr maus
		lea tablel603(pc),a0
		lea keyl603(pc),a1
		bra ongoto_b

keyl603:	dc.l 706,712
		dc.l 0

tablel603:	dc.l kein_platz3,kein_platz_b
		dc.l kein_platz2
kein_platz_b:
		rts
kein_platz3:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_waff_pl9,zeile_3
		move.l #pr_waff_pl10,zeile_4
		move.l #pr_waff_pl11,zeile_5
		move.l #pr_waff_pl12,zeile_6
		move.l #pr_waff_pl13,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
kein_platz4:
		bsr uhr
		bsr print_text
		flip_page
		btst #6,$bfe001
		bne.s kein_platz4
		bsr maus

		lea tablel55(pc),a0
		lea keyl55(pc),a1
		bra ongoto_b

keyl55:
		dc.l 867,868,869,907,908,909,947,948,949
		dc.l 875,876,877,915,916,917,955,956,957
		dc.l 1028,1029,1030,1068,1069,1070,1108,1109,1110
		dc.l 1032,1033,1034,1072,1073,1074,1112,1113,1114
		dc.l 1036,1037,1038,1076,1077,1078,1116,1117,1118
		dc.l 0

tablel55:
		dc.l h_l0,h_l0,h_l0,h_l0,h_l0,h_l0,h_l0,h_l0,h_l0
		dc.l h_r0,h_r0,h_r0,h_r0,h_r0,h_r0,h_r0,h_r0,h_r0
		dc.l ta_00,ta_00,ta_00,ta_00,ta_00,ta_00,ta_00,ta_00,ta_00
		dc.l ta_10,ta_10,ta_10,ta_10,ta_10,ta_10,ta_10,ta_10,ta_10
		dc.l ta_20,ta_20,ta_20,ta_20,ta_20,ta_20,ta_20,ta_20,ta_20
		dc.l kein_platz4
h_l0:
		lea hand_links(pc),a0
		move.l a0,hand
		move.l (a0),a1
		cmp.l #0,18(a1)
		beq kein_platz4
		move.l a1,gegenstand
		bra kein_platz5
h_r0:
		lea hand_rechts(pc),a0
		move.l a0,hand
		move.l (a0),a1
		cmp.l #0,18(a1)
		beq kein_platz4
		move.l a1,gegenstand
		bra kein_platz5
ta_00:
		lea tasche0(pc),a0
		move.l a0,hand
		move.l (a0),a1
		cmp.l #0,18(a1)
		beq kein_platz4
		move.l a1,gegenstand
		bra kein_platz5
ta_10:
		lea tasche1(pc),a0
		move.l a0,hand
		move.l (a0),a1
		cmp.l #0,18(a1)
		beq kein_platz4
		move.l a1,gegenstand
		bra kein_platz5
ta_20:
		lea tasche2(pc),a0
		move.l a0,hand
		move.l (a0),a1
		cmp.l #0,18(a1)
		beq kein_platz4
		move.l a1,gegenstand
		bra kein_platz5
kein_platz5:
		move.l 18(a1),d0		;preis hohlen
		move.l d0,d1
		lsr.l #1,d0			;/ 2
		lsr.l #2,d1			;/ 4
		add.l d1,d0
		move.l d0,preis
		jsr _zstring
		lea _z,a1
		lea pr_waff_pl17(pc),a0
		add.l #12,a0
		move.b #32,(a0)
		move.b #32,1(a0)
		move.b #32,2(a0)
kein_platz5b:
		move.b (a1)+,d0
		cmp.b #0,d0
		beq.s kein_platz6
		move.b d0,(a0)+
		bra.s kein_platz5b
kein_platz6:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_waff_pl14,zeile_2
		move.l #pr_waff_pl15,zeile_3
		move.l #pr_waff_pl16,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_waff_pl17,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
kein_platz7:
		bsr uhr
		bsr print_text
		flip_page
		key
		cmp.b #"J",d0
		beq kein_platz20
		cmp.b #"N",d0
		beq kein_platz8
		btst #6,$bfe001
		bne.s kein_platz7
		bsr maus
		lea tablel604(pc),a0
		lea keyl604(pc),a1
		bra ongoto_b

keyl604:	dc.l 666,672
		dc.l 0

tablel604:	dc.l kein_platz20,kein_platz8
		dc.l kein_platz7
kein_platz8:
		rts

kein_platz20:
		move.l preis,d0
		add.l d0,geld
		lea nichts(pc),a0
		move.l hand,a1
		move.l a0,(a1)
		rts

hand:		dc.l 0
gegenstand:	dc.l 0
preis:		dc.l 0				;das bietet er für Gegenstand

tasche_frei:
		moveq #0,d2
		lea hand_rechts(pc),a2
		move.l (a2),a1
		cmp.l #0,18(a1)
		beq tasche_frei2
		lea hand_links(pc),a2
		move.l (a2),a1
		cmp.l #0,18(a1)
		beq tasche_frei2
		lea tasche0(pc),a2
		move.l (a2),a1
		cmp.l #0,18(a1)
		beq tasche_frei2
		lea tasche1(pc),a2
		move.l (a2),a1
		cmp.l #0,18(a1)
		beq tasche_frei2
		lea tasche2(pc),a2
		move.l (a2),a1
		cmp.l #0,18(a1)
		beq tasche_frei2
		moveq #1,d2			;kein Platz
tasche_frei2:					;a2 zeiger auf Tasche
						;d2=0 Tasche frei
		rts
welches_gewicht:
		move.l #4,gewicht
		lea hand_links(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		lea hand_rechts(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		lea tasche0(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		lea tasche1(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		lea tasche2(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		lea ruest(pc),a0
		move.l (a0),a0
		move.l 22(a0),d0
		add.l d0,gewicht
		rts
waffen_ruest:
		move.l #pr_waff_menu,zeile_1
		move.l #pr_leer,zeile_2
		move.l welcher_shop1,a0
		add.l #60,a0
		move.l (a0),zeile_3
		add.l #4,a0
		move.l (a0),zeile_4
		add.l #4,a0
		move.l (a0),zeile_5
		add.l #4,a0
		move.l (a0),zeile_6
		add.l #4,a0
		move.l (a0),zeile_7
		add.l #4,a0
		move.l (a0),zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_waff_menu4,zeile_10
waffen_ruest1:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq waffen3
		cmp.b #"A",d0
		beq ruest_a
		cmp.b #"B",d0
		beq ruest_b
		cmp.b #"C",d0
		beq ruest_c
		cmp.b #"D",d0
		beq ruest_d
		cmp.b #"E",d0
		beq ruest_e
		cmp.b #"F",d0
		beq ruest_f
		btst #6,$bfe001
		bne waffen_ruest1
		bsr maus
		lea tablel702(pc),a0
		lea keyl702(pc),a1
		bra ongoto_b

keyl702:	dc.l 424,464,504,544,584,624,705
		dc.l 0

tablel702:	dc.l ruest_a,ruest_b,ruest_c,ruest_d,ruest_e,ruest_f,waffen3
		dc.l waffen_ruest1
ruest_a:
		move.l welcher_shop1,a0
		add.l #60,a0
		move.l (a0),gegenstand
		bra ruest_2
ruest_b:
		move.l welcher_shop1,a0
		add.l #64,a0
		move.l (a0),gegenstand
		bra ruest_2
ruest_c:
		move.l welcher_shop1,a0
		add.l #68,a0
		move.l (a0),gegenstand
		bra ruest_2
ruest_d:
		move.l welcher_shop1,a0
		add.l #72,a0
		move.l (a0),gegenstand
		bra ruest_2
ruest_e:
		move.l welcher_shop1,a0
		add.l #76,a0
		move.l (a0),gegenstand
		bra ruest_2
ruest_f:
		move.l welcher_shop1,a0
		add.l #80,a0
		move.l (a0),gegenstand
ruest_2:
		move.l (a0),a0
		move.l 18(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		bgt ruest_2b
		bsr waff_zu_teuer
		bra waffen3
ruest_2b:
		lea ruest(pc),a0
		move.l (a0),a0
		cmp.l #0,18(a0)
		beq ruest_3

		move.l 18(a0),d0		;preis hohlen
		move.l d0,d1
		lsr.l #1,d0			;/ 2
		lsr.l #2,d1			;/ 4
		add.l d1,d0
		move.l d0,preis
		jsr _zstring
		lea _z(pc),a1
		lea pr_waff_pl17(pc),a0
		add.l #12,a0
		move.b #32,(a0)
		move.b #32,1(a0)
		move.b #32,2(a0)
ruest_2bb:
		move.b (a1)+,d0
		cmp.b #0,d0
		beq.s ruest_2bba
		move.b d0,(a0)+
		bra.s ruest_2bb
ruest_2bba:
		move.l #pr_leer,zeile_0
		move.l #pr_ruest_0,zeile_1
		move.l #pr_ruest_1,zeile_2
		move.l #pr_ruest_2,zeile_3
		move.l #pr_ruest_3,zeile_4
		move.l #pr_ruest_4,zeile_5
		move.l #pr_ruest_5,zeile_6
		move.l #pr_waff_pl17,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
ruest2c:
		bsr uhr
		bsr print_text
		flip_page
		key
		cmp.b #"J",d0
		beq ruest2d
		cmp.b #"N",d0
		beq waffen3
		btst #6,$bfe001
		bne.s ruest2c
		bsr maus
		lea tablel704(pc),a0
		lea keyl704(pc),a1
		bra ongoto_b

keyl704:	dc.l 666,672
		dc.l 0

tablel704:	dc.l ruest2d,waffen3
		dc.l ruest2c
ruest2d:
		move.l preis,d0
		add.l d0,geld
		lea nichts(pc),a0
		move.l a0,ruest
		move.l #0,sprite
		bra waffen3
ruest_3:
		move.l gegenstand,a0
		move.l a0,ruest
		move.l 18(a0),d0
		sub.l d0,geld
		move.l 30(a0),sprite
		bra waffen3
waffen_gem:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #lampe,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_f_sh_4,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
waffen_gem2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq waffen3
		cmp.b #"A",d0
		beq waffen_gem3
		btst #6,$bfe001
		bne waffen_gem2
		bsr maus
		lea tablel910(pc),a0
		lea keyl910(pc),a1
		bra ongoto_b

keyl910:	dc.l 464,544
		dc.l 0

tablel910:	dc.l waffen_gem3,waffen3
		dc.l waffen_gem2
waffen_gem3:
		lea lampe(pc),a0
		move.l 18(a0),d0
		move.l geld,d1
		cmp.l d1,d0
		blt.s waffen_gem4
		bsr waff_zu_teuer
		bra waffen3
waffen_gem4:
		bsr tasche_frei
		cmp.l #1,d2
		bne.s waffen_gem5
		bsr kein_platz
		bra waffen3
waffen_gem5:
		sub.l d0,geld
		move.l a0,(a2)
		bsr inventory3
		bra waffen3
hotel:
		cmp.b #6,muede
		blt schlaf4
		cmp.l #50,geld			;Genug Geld für
		blt cas_geld0			;eine Übernachtung ?
		move.l hier,a0
		move.b (a0),d0
		and.l #255,d0
		sub.l #237,d0			;Hotel 0 - 4
		lsl.l #4,d0			; mal 16
		lea hotel_dat0(pc),a0
		add.l d0,a0
		move.l a0,welcher_shop1
		move.l (a0),welcher_shop2
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l #pr_leer,zeile_0
		move.l welcher_shop2,zeile_1
		move.l #pr_leer,zeile_2
		rnd
		cmp.b #5,d0
		blt hotel1
		lea pr_hotel1(pc),a0
		move.l a0,welcher_shop2
		move.l #pr_hotel0,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_hotel1,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_bank14,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bra hotel2
hotel1:
		lea pr_hotel4(pc),a0
		move.l a0,welcher_shop2
		move.l #pr_hotel2,zeile_3
		move.l #pr_hotel3,zeile_4
		move.l #pr_hotel4,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_bank14,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
hotel2:
		move.l welcher_shop2,a0
		move.b #32,13(a0)
		move.b #32,14(a0)
		move.b #32,15(a0)
		move.l welcher_shop1,a0
		move.l 4(a0),d0			;der Preis fuer Übernachtung
		jsr _zstring
		move.l welcher_shop2,a0
		lea _z(pc),a1
		move.b (a1)+,13(a0)
		move.b (a1),14(a0)
hotel3:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq hotel_sleep
		btst #6,$bfe001
		bne hotel3
		bsr maus

		lea tablel3(pc),a0
		lea keyl3(pc),a1
		bra ongoto_b

keyl3:		dc.l 626,632
		dc.l 0

tablel3:	dc.l hotel_sleep,bank_exit
		dc.l hotel3

hotel_sleep:
		move.l welcher_shop1,a0
		move.l 4(a0),d0			;der Preis fuer Übernachtung
		sub.l d0,geld
		move.b #5,wie_viel_sek		;die Zeit soll 4 mal schneller
						;vergehen
		move.b #0,sekunde
		move.b #1,sleep			;Flag für das Schlafen
hotel_schlaf2:
		bsr uhr
		bsr print_text
		rectfill #0,#0,#0,#175,#175	;im Schlaf sieht man nichts
		bsr werte
		bsr hunger_print
		cmp.b #1,muede
		blt aufwachen
		key
		cmp.b #0,d0
		bne aufwachen2
		flip_page
		bra hotel_schlaf2
cas0:
		cmp.l #100,geld
		blt cas_geld0
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_cas0,zeile_2
		move.l #pr_cas1,zeile_3
		move.l #pr_cas2,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_cas3,zeile_6
		move.l #pr_cas4,zeile_7
		move.l #pr_f_sh_4,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
cas1:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq bank_exit
		cmp.b #"A",d0
		beq play_schwampf
		cmp.b #"B",d0
		beq play_pnunf
		btst #6,$bfe001
		bne cas1
		bsr maus
		lea tablel30(pc),a0
		lea keyl30(pc),a1
		bra ongoto_b

keyl30:		dc.l 544,584,624
		dc.l 0

tablel30:	dc.l play_schwampf,play_pnunf,bank_exit
		dc.l cas1

play_schwampf:
		cmp.l #100,geld
		blt cas_geld0
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_cas6,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_cas7,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_cas8,zeile_6
		move.l #pr_kneipe_50,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
play_schwampf2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq cas0
		cmp.b #"A",d0
		beq play_schwampf_3
		btst #6,$bfe001
		bne play_schwampf2
		bsr maus
		lea tablel31(pc),a0
		lea keyl31(pc),a1
		bra ongoto_b

keyl31:		dc.l 545,585
		dc.l 0

tablel31:	dc.l play_schwampf_3,cas0
		dc.l play_schwampf2

play_pnunf:
		cmp.l #100,geld
		blt cas_geld0
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_cas9,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_cas10,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_cas8,zeile_6
		move.l #pr_kneipe_50,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
play_pnunf2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq cas0
		cmp.b #"A",d0
		beq play_pnunf_3
		btst #6,$bfe001
		bne play_pnunf2
		bsr maus
		lea tablel32(pc),a0
		lea keyl32(pc),a1
		bra ongoto_b

keyl32:		dc.l 545,585
		dc.l 0

tablel32:	dc.l play_pnunf_3,cas0
		dc.l play_pnunf2
play_pnunf_3:
		rnd
		and.l #3,d0
		add.l #1,d0
		move.l d0,welcher_shop1		;Zahl sichern
		cmp.l #4,d0
		beq play_pnunf_3
		move.l #pr_leer,zeile_0
		move.l #pr_cas9,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_cas_pn1,zeile_3
		move.l #pr_cas_pn2,zeile_4
		move.l #pr_cas_pn3,zeile_5
		move.l #pr_cas_pn4,zeile_6
		move.l #pr_cas_pn5,zeile_7
		move.l #pr_cas_pn6,zeile_8
		move.l #pr_cas_pn7,zeile_9
		move.l #pr_leer,zeile_10
play_pnunf_4:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"1",d0
		beq wahl_1
		cmp.b #"2",d0
		beq wahl_2
		cmp.b #"3",d0
		beq wahl_3
		btst #6,$bfe001
		bne play_pnunf_4
		bsr maus
		lea tablel33(pc),a0
		lea keyl33(pc),a1
		bra ongoto_b

keyl33:		dc.l 551,591,631
		dc.l 0

tablel33:	dc.l wahl_1,wahl_2,wahl_3
		dc.l play_pnunf_4
wahl_1:
		cmp.l #1,welcher_shop1
		beq gewonnen_pn
		bra verloren_pn
wahl_2:
		cmp.l #2,welcher_shop1
		beq gewonnen_pn
		bra verloren_pn
wahl_3:
		cmp.l #3,welcher_shop1
		beq gewonnen_pn
		bra verloren_pn
gewonnen_pn:
		add.l #5,geld
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_cas_win,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		delay #50
		bra play_pnunf
verloren_pn:
		sub.l #5,geld
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_cas_los,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		delay #50
		bra play_pnunf
play_schwampf_3:
		rnd16
		and.l #15,d0
		add.l #1,d0
		cmp.l #1,d0
		beq play_schwampf_3
		move.l d0,welcher_shop1
		lea pr_cas_pn0(pc),a0
		add.l #14,a0
		move.b #32,(a0)+
		move.b #32,(a0)+
		jsr _zstring
		lea _z(pc),a0
		lea pr_cas_pn0(pc),a1
		add.l #14,a1
play_sw_4:
		move.b (a0)+,d0
		cmp.b #0,d0
		beq.s play_sw_4b
		move.b d0,(a1)+
		bra play_sw_4
play_sw_4b:
		rnd16
		and.l #15,d0
		add.l #1,d0
		cmp.l #1,d0
		beq play_sw_4b
		move.l welcher_shop1,d1
		cmp.l d0,d1
		beq play_sw_4b
		move.l d0,welcher_shop2
		move.l #pr_leer,zeile_0
		move.l #pr_cas6,zeile_1
		move.l #pr_cas_pn0,zeile_2
		move.l #pr_cas_pn1,zeile_3
		move.l #pr_cas_scw2,zeile_4
		move.l #pr_cas_scw3,zeile_5
		move.l #pr_cas_scw4,zeile_6
		move.l #pr_cas_scw5,zeile_7
		move.l #pr_cas_scw6,zeile_8
		move.l #pr_cas_scw7,zeile_9
		move.l #pr_leer,zeile_10
play_sw_5:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"K",d0
		beq play_l
		cmp.b #"G",d0
		beq play_h
		btst #6,$bfe001
		bne play_sw_5
		bsr maus
		lea tablel34(pc),a0
		lea keyl34(pc),a1
		bra ongoto_b

keyl34:		dc.l 547,627
		dc.l 0

tablel34:	dc.l play_l,play_h
		dc.l play_sw_5

play_h:
		move.l welcher_shop1,d1
		move.l welcher_shop2,d2
		cmp.l d1,d2
		bgt play_win
		bra play_loose
play_l:
		move.l welcher_shop1,d1
		move.l welcher_shop2,d2
		cmp.l d1,d2
		blt play_win
		bra play_loose
play_win:
		add.l #5,geld
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_cas_win,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		delay #50
		bra play_schwampf
play_loose:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_cas_los,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		delay #50
		sub.l #10,geld
		bra play_schwampf
cas_geld0:
		bsr text_up
		move.l #pr_cas5,zeile_10
		bra loop
kneipe0:
		lea kneipe_dat0(pc),a0
		move.l a0,welcher_shop1
		bra kneipe
kneipe1:
		lea kneipe_dat1(pc),a0
		move.l a0,welcher_shop1
kneipe:
		cmp.b #22,stunde
		bgt f_shop_zu
		cmp.b #12,stunde
		blt f_shop_zu
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l welcher_shop1,a0
		move.l (a0),welcher_shop2
		rnd
		and.l #3,d0
		cmp.b #1,d0
		beq kneipe_1
		cmp.b #2,d0
		beq kneipe_2
		move.l #pr_f_shop0,zeile_4
		bra kneipe_3
kneipe_1:
		move.l #pr_f_shop1,zeile_4
		bra kneipe_3
kneipe_2:
		move.l #pr_f_shop2,zeile_4
		bra kneipe_3
kneipe_3:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l welcher_shop2,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_5
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		rnd
		and.l #3,d0
		cmp.b #1,d0
		beq kneipe_10
		cmp.b #2,d0
		beq kneipe_20
		move.l #pr_kneipe_00,zeile_6
		bra kneipe_30
kneipe_10:
		move.l #pr_kneipe_10,zeile_6
		bra kneipe_30
kneipe_20:
		move.l #pr_kneipe_20,zeile_6
		bra kneipe_30
kneipe_30:

		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
kneipe_40:
		cmp.b #22,stunde
		bgt bank_zu2
		cmp.b #12,stunde
		blt bank_zu2
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq kneipe_50
		btst #6,$bfe001
		bne kneipe_40
		bsr maus
		lea tablel7(pc),a0
		lea keyl7(pc),a1
		bra ongoto_b

keyl7:		dc.l 666,672
		dc.l 0

tablel7:	dc.l kneipe_50,bank_exit
		dc.l kneipe_40

kneipe_50:
		cmp.l #0,geld
		beq f_shop_geld0
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_kneipe_30,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_kneipe_40,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_kneipe_50,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #22,stunde
		bgt bank_zu2
		cmp.b #12,stunde
		blt bank_zu2
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"E",d0
		beq kneipe_ess
		cmp.b #"T",d0
		beq kneipe_tr
		cmp.b #"X",d0
		beq bank_exit
		btst #6,$bfe001
		bne kneipe_50
		bsr maus
		lea tablel8(pc),a0
		lea keyl8(pc),a1
		bra ongoto_b

keyl8:		dc.l 425,505,585
		dc.l 0

tablel8:	dc.l kneipe_ess,kneipe_tr,bank_exit
		dc.l kneipe_50

kneipe_ess:
		bsr clr_artikel
		move.l welcher_shop1,a0
		lea pr_f_artikel0(pc),a2
		move.l #8,d1
		move.l #12,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel1(pc),a2
		move.l #16,d1
		move.l #20,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel2(pc),a2
		move.l #24,d1
		move.l #28,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel3(pc),a2
		move.l #32,d1
		move.l #36,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel4(pc),a2
		move.l #40,d1
		move.l #44,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel5(pc),a2
		move.l #48,d1
		move.l #52,d2
		bsr get_name_price
		bsr print_menu
kneipe_ess1:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #22,stunde
		bgt bank_zu2
		cmp.b #12,stunde
		blt bank_zu2
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq kneipe_50
		cmp.b #"A",d0
		beq essen_a
		cmp.b #"B",d0
		beq essen_b
		cmp.b #"C",d0
		beq essen_c
		cmp.b #"D",d0
		beq essen_d
		cmp.b #"E",d0
		beq essen_e
		cmp.b #"F",d0
		beq essen_f
		btst #6,$bfe001
		bne kneipe_ess1
		bsr maus

		lea tablel9(pc),a0
		lea keyl9(pc),a1
		bra ongoto_b

keyl9:		dc.l 424,464,504,544,584,624,664
		dc.l 0

tablel9:	dc.l essen_a,essen_b,essen_c,essen_d,essen_e,essen_f
		dc.l kneipe_50,kneipe_ess1
essen_a:
		move.l welcher_shop1,a0
		move.l 12(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_b:
		move.l welcher_shop1,a0
		move.l 20(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_c:
		move.l welcher_shop1,a0
		move.l 28(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_d:
		move.l welcher_shop1,a0
		move.l 36(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_e:
		move.l welcher_shop1,a0
		move.l 44(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_f:
		move.l welcher_shop1,a0
		move.l 52(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt essen_0
		sub.l d0,geld
		move.l #0,hunger
		bsr plus_gesund
		bsr plus_kraft
		bra kneipe_50
essen_0:
		alert
		bra kneipe_ess1
plus_gesund:
		cmp.l #100,gesund
		beq plus_gesund_rts
		cmp.l #78,gesund
		bgt plus_gesund_rts
		add.l #22,gesund
		rts

plus_gesund_rts:
		move.l #100,gesund
		rts
plus_kraft:
		move.l max_kraft,d0
		move.l kraft,d1
		cmp.l d0,d1
		beq plus_kraft_rts
		cmp.l d1,d0
		bgt plus_kraft_2
		rts
plus_kraft_2:
		move.l max_kraft,kraft
		rts
plus_kraft_rts:
		rts


kneipe_tr:
		bsr clr_artikel
		move.l welcher_shop1,a0
		lea pr_f_artikel0(pc),a2
		move.l #56,d1
		move.l #60,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel1(pc),a2
		move.l #64,d1
		move.l #68,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel2(pc),a2
		move.l #72,d1
		move.l #76,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel3(pc),a2
		move.l #80,d1
		move.l #84,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel4(pc),a2
		move.l #88,d1
		move.l #92,d2
		bsr get_name_price

		move.l welcher_shop1,a0
		lea pr_f_artikel5(pc),a2
		move.l #96,d1
		move.l #100,d2
		bsr get_name_price
		bsr print_menu
kneipe_tr1:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #22,stunde
		bgt bank_zu2
		cmp.b #12,stunde
		blt bank_zu2
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"X",d0
		beq kneipe_50
		cmp.b #"A",d0
		beq trinken_a
		cmp.b #"B",d0
		beq trinken_b
		cmp.b #"C",d0
		beq trinken_c
		cmp.b #"D",d0
		beq trinken_d
		cmp.b #"E",d0
		beq trinken_e
		cmp.b #"F",d0
		beq trinken_f

		btst #6,$bfe001
		bne kneipe_tr1
		bsr maus

		lea tablel10(pc),a0
		lea keyl10(pc),a1
		bra ongoto_b

keyl10:		dc.l 424,464,504,544,584,624,664
		dc.l 0

tablel10:	dc.l trinken_a,trinken_b,trinken_c,trinken_d,trinken_e,trinken_f
		dc.l kneipe_50,kneipe_tr1
trinken_a:
		move.l welcher_shop1,a0
		move.l 60(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_b:
		move.l welcher_shop1,a0
		move.l 68(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_c:
		move.l welcher_shop1,a0
		move.l 76(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_d:
		move.l welcher_shop1,a0
		move.l 84(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt.s trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_e:
		move.l welcher_shop1,a0
		move.l 92(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt.s trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_f:
		move.l welcher_shop1,a0
		move.l 100(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt.s trinken_0
		sub.l d0,geld
		bsr minus_hunger
		bsr plus_gesund2
		bsr plus_kraft_t
		bra kneipe_50
trinken_0:
		alert
		bra kneipe_tr1
plus_kraft_t:
		add.l #8,kraft
		move.l kraft,d0
		move.l max_kraft,d1
		cmp.l d1,d0
		bgt plus_kraft_t2
		rts
plus_kraft_t2:
		move.l max_kraft,kraft
		rts
plus_gesund2:
		cmp.l #100,gesund
		beq plus_gesund_rts2
		cmp.l #90,gesund
		bgt plus_gesund_rts2
		add.l #9,gesund
		rts

plus_gesund_rts2:
		move.l #100,gesund
		rts
minus_hunger:
		sub.l #500,hunger
		cmp.l #1,hunger
		blt minus_hunger_2
		rts
minus_hunger_2:
		move.l #0,hunger
		rts
arzt0:
		lea pr_arzt00(pc),a0
		move.l a0,welche_bank
		bra.s arzt
arzt1:
		lea pr_arzt10(pc),a0
		move.l a0,welche_bank
arzt:
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l #pr_leer,zeile_0
		move.l welche_bank,zeile_1
		add.l #17,welche_bank
		move.l welche_bank,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_4
		add.l #17,welche_bank
		move.l welche_bank,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		add.l #17,welche_bank
		move.l welche_bank,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		sub.l #51,welche_bank
arzt2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq arzt3
		btst #6,$bfe001
		bne arzt2
		bsr maus
		lea tablel11(pc),a0
		lea keyl11(pc),a1
		bra ongoto_b

keyl11:		dc.l 626,632
		dc.l 0

tablel11:	dc.l arzt3,bank_exit
		dc.l arzt2
arzt3:
		cmp.l #100,gesund
		beq arzt_gesund
		cmp.l #100,geld
		blt f_shop_geld0
		move.l #pr_leer,zeile_0
		move.l #pr_arzt_w0,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_arzt_w1,zeile_3
		move.l #pr_arzt_w2,zeile_4
		move.l #pr_arzt_w3,zeile_5
		move.l #pr_arzt_w4,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		key
		cmp.b #"A",d0
		beq arzt_100
		cmp.b #"B",d0
		beq arzt_75
		cmp.b #"C",d0
		beq arzt_50
		cmp.b #"X",d0
		beq bank_exit
		btst #6,$bfe001
		bne arzt3
		bsr maus
		lea tablel12(pc),a0
		lea keyl12(pc),a1
		bra ongoto_b

keyl12:		dc.l 424,464,504,544
		dc.l 0

tablel12:	dc.l arzt_100,arzt_75,arzt_50,bank_exit
		dc.l arzt3
arzt_100:
		cmp.l #500,geld
		blt arzt_75
		move.l #0,hunger
		sub.l #500,geld
		move.l #100,gesund
		move.l max_kraft,kraft
		bra arzt3
arzt_75:
		cmp.l #350,geld
		blt arzt_50
		sub.l #350,geld
		move.l max_kraft,kraft
		move.l gesund,d0
		cmp.l #75,d0
		bgt arzt_75b
		add.l #25,gesund
		bra arzt3
arzt_75b:
		move.l #100,gesund
		bra arzt3
arzt_50:
		cmp.l #250,geld
		blt arzt_25
		sub.l #250,geld
		cmp.l #80,gesund
		bgt arzt_50b
		add.l #10,gesund
		bra arzt_50c
arzt_50b:
		move.l #100,gesund
arzt_50c:
		move.l max_kraft,d0
		move.l kraft,d1
		sub.l #5,d0
		cmp.l d0,d1
		bgt arzt3
		add.l #5,kraft
		bra arzt3
arzt_25:
		move.l #0,geld
		cmp.l #94,gesund
		bgt arzt_25b
		add.l #5,gesund
		bra arzt3
arzt_25b:
		move.l #100,gesund
		bra arzt3

arzt_gesund:
		bsr text_up
		move.l #pr_arzt_gesund,zeile_10
		bra bank_exit
f_shop0:
		cmp.b #0,tag
		bne f_shop_zu
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		move.l hier,a0
		move.b (a0),d0
		and.l #255,d0
		sub.l #215,d0
		mulu #72,d0		;Adresse der Shop Struktur ermitteln
		lea food_dat0(pc),a0
		add.l d0,a0
		move.l a0,welcher_shop1
		move.l (a0),welcher_shop2
		rnd
		and.l #3,d0
		cmp.b #1,d0
		beq f_shop1
		cmp.b #2,d0
		beq f_shop2
		move.l #pr_f_shop0,zeile_4
		bra f_shop3
f_shop1:
		move.l #pr_f_shop1,zeile_4
		bra f_shop3
f_shop2:
		move.l #pr_f_shop2,zeile_4
		bra f_shop3
f_shop3:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l welcher_shop2,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_leer,zeile_5
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		rnd
		and.l #3,d0
		cmp.b #1,d0
		beq f_shop10
		cmp.b #2,d0
		beq f_shop20
		move.l #pr_f_shop00,zeile_6
		bra f_shop30
f_shop10:
		move.l #pr_f_shop10,zeile_6
		bra f_shop30
f_shop20:
		move.l #pr_f_shop20,zeile_6
		bra f_shop30
f_shop30:

		move.l #pr_bank14,zeile_9
		move.l #pr_leer,zeile_10
f_shop40:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		cmp.b #0,tag
		bne bank_zu2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq f_shop50
		btst #6,$bfe001
		bne f_shop40
		bsr maus
		lea tablel13(pc),a0
		lea keyl13(pc),a1
		bra ongoto_b

keyl13:		dc.l 666,672
		dc.l 0

tablel13:	dc.l f_shop50,bank_exit
		dc.l f_shop40
f_shop50:
		cmp.l #0,geld
		beq f_shop_geld0
		bsr clr_artikel
		move.l welcher_shop1,a0
		cmp.l #0,28(a0)
		beq f_shop51
		lea pr_f_artikel0(pc),a2
		move.l 8(a0),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 28(a0),d0
		move.l a2,welcher_shop2

		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
f_shop51:
		move.l welcher_shop1,a0
		cmp.l #0,36(a0)
		beq f_shop52
		lea pr_f_artikel1(pc),a2
		move.l 12(a0),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 36(a0),d0
		move.l a2,welcher_shop2

		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
f_shop52:
		move.l welcher_shop1,a0
		cmp.l #0,44(a0)
		beq f_shop53
		lea pr_f_artikel2(pc),a2
		move.l 16(a0),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 44(a0),d0
		move.l a2,welcher_shop2

		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
f_shop53:
		move.l welcher_shop1,a0
		cmp.l #0,52(a0)
		beq f_shop54
		lea pr_f_artikel3(pc),a2
		move.l 20(a0),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 52(a0),d0
		move.l a2,welcher_shop2

		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
f_shop54
		move.l welcher_shop1,a0
		cmp.l #0,60(a0)
		beq f_shop60
		lea pr_f_artikel4(pc),a2
		move.l 24(a0),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 60(a0),d0
		move.l a2,welcher_shop2

		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
f_shop60:
		move.l #pr_leer,zeile_0
		move.l #pr_f_shop_wahl,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_f_artikel0,zeile_3
		move.l #pr_f_artikel1,zeile_4
		move.l #pr_f_artikel2,zeile_5
		move.l #pr_f_artikel3,zeile_6
		move.l #pr_f_artikel4,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_f_sh_4,zeile_9
		move.l #pr_leer,zeile_10
f_shop61:
		cmp.l #0,geld
		beq f_shop_geld0
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		cmp.b #0,tag
		bne bank_zu2
		key
		cmp.b #"X",d0
		beq bank_exit
		cmp.b #"A",d0
		beq nahrung_A
		cmp.b #"B",d0
		beq nahrung_B
		cmp.b #"C",d0
		beq nahrung_C
		cmp.b #"D",d0
		beq nahrung_D
		cmp.b #"E",d0
		beq nahrung_E

		btst #6,$bfe001
		bne f_shop61
		bsr maus
		lea tablel15(pc),a0
		lea keyl15(pc),a1
		bra ongoto_b

keyl15:		dc.l 424,464,504,544,584,664
		dc.l 0

tablel15:	dc.l nahrung_A,nahrung_B,nahrung_C,nahrung_D
		dc.l nahrung_E,bank_exit
		dc.l f_shop61
f_shop_zu:
		bsr text_up
		move.l #pr_f_shop_zu,zeile_10
		bra loop
nahrung_A:
		move.l welcher_shop1,a0
		move.l 28(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt nicht_genug
		sub.l d0,d1
		move.l d1,geld
		move.l 32(a0),d0
		add.l d0,essen
		cmp.l #500,essen
		bgt minus_essen
		bra f_shop61
nahrung_B:
		move.l welcher_shop1,a0
		move.l 36(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt nicht_genug
		sub.l d0,d1
		move.l d1,geld
		move.l 40(a0),d0
		add.l d0,essen
		cmp.l #500,essen
		bgt minus_essen
		bra f_shop61
nahrung_C:
		move.l welcher_shop1,a0
		move.l 44(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt nicht_genug
		sub.l d0,d1
		move.l d1,geld
		move.l 48(a0),d0
		add.l d0,essen
		cmp.l #500,essen
		bgt minus_essen
		bra f_shop61
nahrung_D:
		move.l welcher_shop1,a0
		move.l 52(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt nicht_genug
		sub.l d0,d1
		move.l d1,geld
		move.l 56(a0),d0
		add.l d0,essen
		cmp.l #500,essen
		bgt minus_essen
		bra f_shop61
nahrung_E:
		move.l welcher_shop1,a0
		move.l 60(a0),d0
		move.l geld,d1
		cmp.l d0,d1
		blt nicht_genug
		sub.l d0,d1
		move.l d1,geld
		move.l 64(a0),d0
		add.l d0,essen
		cmp.l #500,essen
		bgt minus_essen
		bra f_shop61
minus_essen:
		move.l #500,essen
		bra f_shop61
nicht_genug:
		alert
		bra f_shop61
f_shop_geld0:
		rnd
		and.l #3,d0
		cmp.l #1,d0
		beq f_shop_geld1
		cmp.l #2,d0
		beq f_shop_geld2
		bsr text_up
		move.l #pr_f_shop_g0,zeile_10
		bra loop
f_shop_geld1:
		bsr text_up
		move.l #pr_f_shop_g1,zeile_10
		bra loop
f_shop_geld2:
		bsr text_up
		move.l #pr_f_shop_g2,zeile_10
		bsr text_up
		move.l #pr_f_shop_g2b,zeile_10
		bra loop
leer:
		bsr text_up
		move.l #pr_haus_leer,zeile_10
		bra loop
bank0:
		lea konto0(pc),a0
		move.b #0,w_bank
		bra bank
bank1:
		move.b #1,w_bank
		lea konto1(pc),a0
bank:
		cmp.b #0,tag
		bne bank_zu
		move.l a0,welche_bank
		bsr draw_map
		bsr uhr
		bsr werte
		flip_page
		front
		equ_screen
		back
		cmp.b #0,w_bank
		bne bank01
		move.l #pr_leer,zeile_0
		move.l #pr_bank00,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_bank01,zeile_4
		move.l #pr_bank02,zeile_5
		move.l #pr_bank03,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_bank14,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bra bank2
bank01:
		move.l #pr_leer,zeile_0
		move.l #pr_bank10,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_leer,zeile_3
		move.l #pr_bank11,zeile_4
		move.l #pr_bank12,zeile_5
		move.l #pr_bank13,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_bank14,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
bank2:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		cmp.b #0,tag
		bne bank_zu2
		key
		cmp.b #"N",d0
		beq bank_exit
		cmp.b #"J",d0
		beq bank3
		btst #6,$bfe001
		bne bank2
		bsr maus
		lea tablel4(pc),a0
		lea keyl4(pc),a1
		bra ongoto_b

keyl4:		dc.l 626,632
		dc.l 0

tablel4:	dc.l bank3,bank_exit
		dc.l bank2
bank3:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_bank_0,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_bank_1,zeile_5
		move.l #pr_bank_2,zeile_6
		move.l #pr_bank_3,zeile_7
		move.l #pr_f_sh_4,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		cmp.b #0,tag
		bne bank_zu2
		key
		cmp.b #"X",d0
		beq bank_exit
		cmp.b #"A",d0
		beq bank_konto_stand
		cmp.b #"B",d0
		beq bank_abheben
		cmp.b #"C",d0
		beq bank_einzahlen

		btst #6,$bfe001
		bne bank3
		bsr maus
		lea tablel5(pc),a0
		lea keyl5(pc),a1
		bra ongoto_b

keyl5:		dc.l 504,544,584,624
		dc.l 0

tablel5:	dc.l bank_konto_stand,bank_abheben,bank_einzahlen,bank_exit
		dc.l bank3

bank_konto_stand:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_konto_st,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_konto_geld,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_konto_st2,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		lea pr_konto_geld(pc),a0
		moveq #15,d0
bank_konto_st2:
		move.b #32,(a0)+
		dbra d0,bank_konto_st2
		move.l welche_bank,a0
		move.l (a0),d0
		jsr _rbuendig
		jsr _zstring
		lea _z(pc),a0
		lea pr_konto_geld(pc),a1
		add.l #6,a1
bank_konto_st3:
		move.b (a0)+,d0
		cmp.b #0,d0
		beq.s bank_konto_st4
		move.b d0,(a1)+
		bra bank_konto_st3
bank_konto_st4:
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		cmp.b #90,muede
		bgt tot2
		cmp.l #1,kraft
		blt tot2
		cmp.l #1,gesund
		blt tot2
		cmp.b #0,tag
		bne bank_zu2
		key
		cmp.b #"W",d0
		beq bank3
		btst #6,$bfe001
		bne bank_konto_stand
		bsr maus
		lea tablel6(pc),a0
		lea keyl6(pc),a1
		bra ongoto_b

keyl6:		dc.l 587
		dc.l 0

tablel6:	dc.l bank3
		dc.l bank_konto_stand

bank_abheben:
		move.l welche_bank,a0
		move.l (a0),d1
		cmp.l #0,d1
		beq bank_abheben0
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_abheben1,zeile_2
		move.l #pr_abheben2,zeile_3
		move.l #pr_abheben3,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		front
		equ_screen
		lea nummer(pc),a0
		move.l #0,(a0)+
		move.l #0,(a0)+
		
		zinput #101,#25,#95,nummer,#6
		get_number nummer
		move.l welche_bank,a0
		move.l (a0),d1
		cmp.l d0,d1
		blt bank_viel
		sub.l d0,d1
		move.l d1,(a0)
		add.l d0,geld
		back
		bra bank3
bank_viel:
		back
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_viel1,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_viel2,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_viel3,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		flip_page
		delay #200
		bra bank3
bank_abheben0:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_nviel1,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_nviel2,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_nviel3,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		flip_page
		delay #200
		bra bank3
bank_einzahlen:
		move.l geld,d0
		cmp.l #0,d0
		beq bank_geld0
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_abheben1,zeile_2
		move.l #pr_abheben2,zeile_3
		move.l #pr_einzahlen3,zeile_4
		move.l #pr_leer,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_leer,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		bsr werte
		flip_page
		front
		equ_screen
		lea nummer(pc),a0
		move.l #0,(a0)+
		move.l #0,(a0)+
		
		zinput #101,#25,#95,nummer,#6
		get_number nummer
		move.l geld,d1
		cmp.l d0,d1
		blt bank_viel_2
		sub.l d0,geld
		move.l welche_bank,a0
		add.l d0,(a0)
		back
		bra bank3
bank_geld0:
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_nviel10,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_nviel20,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_nviel30,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		flip_page
		delay #200
		bra bank3
bank_viel_2:
		back
		move.l #pr_leer,zeile_0
		move.l #pr_leer,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_viel1,zeile_3
		move.l #pr_leer,zeile_4
		move.l #pr_viel2,zeile_5
		move.l #pr_leer,zeile_6
		move.l #pr_viel30,zeile_7
		move.l #pr_leer,zeile_8
		move.l #pr_leer,zeile_9
		move.l #pr_leer,zeile_10
		bsr uhr
		bsr print_text
		flip_page
		delay #200
		bra bank3

bank_exit:
		bsr text_up
		rnd
		and.l #255,d0
		cmp.b #1,d0
		beq bank_exit1
		cmp.b #2,d0
		beq bank_exit2
		move.l #pr_bank_bye,zeile_10
		bra loop
bank_exit1:
		move.l #pr_bank_bye1,zeile_10
		bra loop
bank_exit2:
		move.l #pr_bank_bye2,zeile_10
		bra loop
bank_zu:
		bsr text_up
		move.l #pr_bank_zu,zeile_10
		bra loop
bank_zu2:
		bsr text_up
		move.l #pr_bank_zu1,zeile_10
		bsr text_up
		move.l #pr_bank_zu2,zeile_10
		bra loop
clr_artikel:
		lea pr_f_artikel0(pc),a0
		lea pr_f_artikel1(pc),a1
		lea pr_f_artikel2(pc),a2
		lea pr_f_artikel3(pc),a3
		lea pr_f_artikel4(pc),a4
		lea pr_f_artikel5(pc),a5
		lea pr_f_artikel6(pc),a6
		moveq #15,d0
clr_artikel0:
		move.b #32,(a0)+
		move.b #32,(a1)+
		move.b #32,(a2)+
		move.b #32,(a3)+
		move.b #32,(a4)+
		move.b #32,(a5)+
		move.b #32,(a6)+
		dbra d0,clr_artikel0
		rts
get_name_price:
		move.l 0(a0,d1),a0
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l (a0)+,(a2)+
		move.l welcher_shop1,a0
		move.l 0(a0,d2),d0
		move.l a2,welcher_shop2
		jsr _zstring
		lea _z(pc),a0
		move.l welcher_shop2,a2
		add.l #1,a2
		bsr f_shopa
		rts

f_shopa:
		move.b (a0)+,d0
		move.b d0,(a2)+
		cmp.b #0,d0
		bne.s f_shopa
		move.b #32,-1(a2)
		rts
print_menu:
		move.l #pr_leer,zeile_0
		move.l #pr_f_shop_wahl,zeile_1
		move.l #pr_leer,zeile_2
		move.l #pr_f_artikel0,zeile_3
		move.l #pr_f_artikel1,zeile_4
		move.l #pr_f_artikel2,zeile_5
		move.l #pr_f_artikel3,zeile_6
		move.l #pr_f_artikel4,zeile_7
		move.l #pr_f_artikel5,zeile_8
		move.l #pr_f_sh_4,zeile_9
		move.l #pr_leer,zeile_10
		rts
werte:
		cmp.b #1,inv
		beq werte_rts
		cmp.l #800,hunger
		bgt werte_4
		move.l #19,balken_farbe
		bra werte2
werte_4:
		cmp.l #2000,hunger
		bgt werte_21
		move.l #4,balken_farbe
		bra werte2
werte_21:
		cmp.l #2600,hunger
		bgt werte_26
		move.l #21,balken_farbe
		bra werte2
werte_26:
		cmp.l #3000,hunger
		bgt werte_10
		move.l #26,balken_farbe
		bra werte2
werte_10:
		move.l #10,balken_farbe
werte2:
		rectfill #0,#209,#170,#309,#181
		move.l hunger,d5
		lsr.l #5,d5
		cmp.l #99,d5
		blt werte3
		move.l #99,d5
werte3:
		add.l #209,d5
		rectfill balken_farbe,#209,#170,d5,#175
		move.b muede,d5
		cmp.b #97,d5
		bls.s werte4
		moveq #96,d5
werte4:
		and.l #255,d5
		add.l #209,d5
		rectfill #10,#209,#176,d5,#181
		print #0,#25,#189,"___"
		print #0,#25,#205,"___"
		print #0,#25,#221,"___"
		print #0,#25,#237,"_____"
		print #0,#36,#221,"__"
		zahlr #101,#27,#189,kraft
		zahlr #101,#27,#205,gesund
		zahlr #101,#27,#221,essen
		zahlr #101,#29,#237,geld
		zahlr #101,#37,#221,exper
		rts
werte_rts:
		print #0,#25,#237,"_____"
		zahl #2,#25,#237,geld
		print #0,#25,#228,"_____"
		zahl #2,#25,#228,gewicht
		rts

balken_farbe:	dc.l 0

hunger_print:
		cmp.l #3000,hunger
		blt hunger_print2
		cmp.b #0,hgesagt
		bne.s hunger_print2
		bsr text_up
		move.l #pr_hunger,zeile_10
		move.b #1,hgesagt
hunger_print2:
		rts

eat:
		cmp.l #0,essen
		beq eat_end
		sub.l #1,essen
		move.l hunger,d0
		cmp.l #500,d0
		blt.s eat2
		sub.l #500,hunger
		move.l #100,gesund
		move.l max_kraft,d0
		move.l kraft,d1
		cmp.l d0,d1
		bgt.s eat_end0
		add.l #5,kraft
		move.b #0,hgesagt
		bra eat_end0
eat2:
		cmp.l #50,hunger
		blt.s eat_3
		move.l #0,hunger
		move.l #100,gesund
		move.l max_kraft,d0
		move.l kraft,d1
		cmp.l d0,d1
		bgt.s eat_end0
		add.l #5,kraft
		move.b #0,hgesagt
eat_end0:
		bra loop
eat_end:
		bsr text_up
		move.l #pr_no_eat,zeile_10
		bra loop
eat_3:
		bsr text_up
		move.l #pr_no_hunger,zeile_10
		bra loop
Bild_schoner:
		front
		equ_screen
		cls
		clr_pointer
		move.b #1,pause
		wait_km
		flip_page
		equ_screen
		back
		set_pointer #0
		move.b #0,pause
		bra loop
up:
		move.l gewicht,d0
		lsr #1,d0
		add.l d0,hunger
		move.l hier,a0
		move.b size_x,d0
		and.l #255,d0
		sub.l d0,a0
		cmp.b #81,(a0)
		bls dong
		cmp.b #106,(a0)
		bhi up2
		rnd
		and.b #3,d0
		cmp.b #1,d0
		beq morast
up2:
		move.b size_x,d0
		and.l #255,d0
		sub.l d0,dun_start
		sub.l d0,hier
		bsr text_up
		move.l #pr_nord,zeile_10
		move.l hier,a0
		cmp.b #114,(a0)
		beq init_dun2
		bra loop
down:
		move.l gewicht,d0
		lsr #1,d0
		add.l d0,hunger
		move.l hier,a0
		move.b size_x,d0
		and.l #255,d0
		add.l d0,a0
		cmp.b #81,(a0)
		bls dong
		cmp.b #106,(a0)
		bhi down2
		rnd
		and.b #3,d0
		cmp.b #1,d0
		beq morast
down2:
		move.b size_x,d0
		and.l #255,d0
		add.l d0,dun_start
		add.l d0,hier
		bsr text_up
		move.l #pr_sued,zeile_10
		move.l hier,a0
		cmp.b #114,(a0)
		beq init_dun2
		bra loop
links:
		move.l gewicht,d0
		lsr #1,d0
		add.l d0,hunger
		move.l hier,a0
		sub.l #1,a0
		cmp.b #81,(a0)
		bls dong
		cmp.b #106,(a0)
		bhi links2
		rnd
		and.b #3,d0
		cmp.b #1,d0
		beq morast
links2:
		sub.l #1,dun_start
		sub.l #1,hier
		bsr text_up
		move.l #pr_west,zeile_10
		move.l hier,a0
		cmp.b #114,(a0)
		beq init_dun2
		bra loop
rechts:
		move.l gewicht,d0
		lsr #1,d0
		add.l d0,hunger
		move.l hier,a0
		add.l #1,a0
		cmp.b #81,(a0)
		bls dong
		cmp.b #106,(a0)
		bhi rechts2
		rnd
		and.b #3,d0
		cmp.b #1,d0
		beq morast
rechts2:
		add.l #1,dun_start
		add.l #1,hier
		bsr text_up
		move.l #pr_ost,zeile_10
		move.l hier,a0
		cmp.b #114,(a0)
		beq init_dun2
		bra loop
dong:
		rnd
		and.l #3,d0
		sub.l #1,d0
		sub.l d0,kraft
		sub.l #1,gesund
		bsr text_up
		rnd
		and.b #3,d0
		cmp.b #3,d0
		beq.s dong1
		cmp.b #2,d0
		beq.s dong2
dong0:
		move.l #pr_block1,zeile_10
		bra loop
dong1:
		move.l #pr_block2,zeile_10
		bra loop
dong2:
		move.l #pr_block3,zeile_10
		bra loop

morast:
		bsr text_up
		rnd
		and.b #3,d0
		cmp.b #3,d0
		beq.s morast3
		cmp.b #2,d0
		beq.s morast2
morast1:
		move.l #pr_morast1,zeile_10
		bra loop
morast2:
		move.l #pr_morast2,zeile_10
		bra loop
morast3:
		move.l #pr_morast3,zeile_10
		bra loop

init_dun:
		move.l dungeon,a0
		move.b 13(a0),size_x
		move.b 14(a0),size_y
		rts
init_dun2:
		move.l dungeon,a0
		move.b 13(a0),size_x
		move.b 14(a0),size_y
		move.l dun_start2,dun_start
		move.l hier2,hier
		front
		print #0,#3,#176,"______________"
		ptext #102,#7,#176,dungeon
		equ_screen
		back
		bra loop

uhr:
		print #0,#23,#10,"________________"
		move.b stunde,d0
		and.l #255,d0
		zahl #101,#23,#10,d0
		move.b minute,d0
		and.l #255,d0
		zahl #101,#26,#10,d0
		move.b tag,d0
		and.l #255,d0
		zahl #101,#29,#10,d0
		move.l hier,a0
		move.b (a0),d0
		and.l #255,d0
		zahl #101,#32,#10,d0

		print #0,#23,#20,"________________"
		move.b day,d0
		and.l #255,d0
		zahl #101,#23,#20,d0
		move.b monat,d0
		and.l #255,d0
		zahl #101,#26,#20,d0
		move.b jahr,d0
		and.l #255,d0
		zahl #101,#29,#20,d0

		print #101,#23,#30,"TEMP:"
		print #0,#29,#30,"____"
		move.b temperatur,d0
		ext.w d0
		ext.l d0
		zahl #101,#29,#30,d0
		rts

;***************************************
; Wasser Animation
wellen:
		cmp.b #0,anim
		bne gegner
		move.b #1,anim
		move.l ele,a1
		move.l #192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		lea puffer(pc),a0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192,d0
		add.l d0,a0
		move.l #192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192,d0
		add.l d0,a0
		move.l #192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192,d0
		add.l d0,a0
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		lea puffer(pc),a1
		move.l #95,d0
wellen_loop:
		move.w (a1)+,(a0)+
		dbra d0,wellen_loop
		rts
gegner:
		cmp.b #1,anim
		bne wellen2
		move.b #2,anim
		move.l ele,a1
		move.l #46*192,d0
		add.l d0,a1
		move.l #95,d0
		lea puffer(pc),a0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #46*192,d0
		add.l d0,a0
		move.l #46*192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #46*192+192,d0
		add.l d0,a0
		move.l #46*192+192*2,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		lea puffer,a1
		move.l ele,a0
		move.l #46*192+192*2,d0
		add.l d0,a0
		move.l #95,d0
		bsr wellen_loop


		move.l ele,a1
		move.l #46*192+192*3,d0
		add.l d0,a1
		lea puffer,a0
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #46*192+192*4,d0
		add.l d0,a1
		move.l #46*192+192*3,d0
		add.l d0,a0
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #46*192+192*5,d0
		add.l d0,a1
		move.l #46*192+192*4,d0
		add.l d0,a0
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l #46*192+192*5,d0
		add.l d0,a0
		lea puffer,a1
		move.l #95,d0
		bsr wellen_loop
		rts

wellen2:
		move.b #0,anim
		move.l ele,a1
		move.l #192+192+192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		lea puffer(pc),a0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192+192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l #192+192+192+192+192+192,d0
		add.l d0,a0
		lea puffer(pc),a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a1
		move.l #192+192+192+192+192+192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		lea puffer(pc),a0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192+192+192+192+192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192+192+192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l a0,a1
		move.l #192+192+192+192+192+192+192+192+192+192,d0
		add.l d0,a0
		move.l #192+192+192+192+192+192+192+192+192,d0
		add.l d0,a1
		move.l #95,d0
		bsr wellen_loop

		move.l ele,a0
		move.l #192+192+192+192+192+192+192+192+192,d0
		add.l d0,a0
		lea puffer(pc),a1
		move.l #95,d0
		bsr wellen_loop
		rts

draw_map:
		cmp.b #1,sleep
		bne.s draw_map1
		rts
draw_map1:
		bsr ist_feuer
		moveq #31,d0
		lea sicht(pc),a0
draw_map2:
		move.l #$ffffffff,(a0)+
		dbra d0,draw_map2
		cmp.b #1,d1
		beq draw_alles
		cmp.b #0,unten
		blt draw_alles_4
		cmp.b #0,tag
		beq draw_alles
		cmp.b #1,tag
		beq draw_alles_1
		cmp.b #2,tag
		beq draw_alles_2
		cmp.b #3,tag
		beq.s draw_alles_3

draw_alles_4:
		cmp.b #1,licht
		beq draw_alles_3a
		move.l hier,a0
		move.b (a0),sicht+60
		bra draw_it
draw_alles_3:
		cmp.b #1,licht
		beq draw_alles_2a
draw_alles_3a:
		move.b size_x,d1
		and.l #255,d1
		move.l dun_start,a0
		add.l d1,a0
		add.l d1,a0
		add.l d1,a0
		lea sicht(pc),a1
		add.l #11,a1
		add.l #11,a1
		add.l #11,a1
		moveq #4,d0
draw_alles_3b:
		move.b 3(a0),3(a1)
		move.b 4(a0),4(a1)
		move.b 5(a0),5(a1)
		move.b 6(a0),6(a1)
		move.b 7(a0),7(a1)
		add.l #11,a1
		add.l d1,a0
		dbra d0,draw_alles_3b
		bra draw_it
draw_alles_2:
		cmp.b #1,licht
		beq draw_alles_1a
draw_alles_2a:
		move.b size_x,d1
		and.l #255,d1
		move.l dun_start,a0
		add.l d1,a0
		add.l d1,a0
		lea sicht(pc),a1
		add.l #22,a1
		moveq #6,d0
draw_alles_2b:
		move.b 2(a0),2(a1)
		move.b 3(a0),3(a1)
		move.b 4(a0),4(a1)
		move.b 5(a0),5(a1)
		move.b 6(a0),6(a1)
		move.b 7(a0),7(a1)
		move.b 8(a0),8(a1)
		add.l #11,a1
		add.l d1,a0
		dbra d0,draw_alles_2b
		bra draw_it
draw_alles_1:
		cmp.b #1,licht
		beq draw_alles
draw_alles_1a:
		move.b size_x,d1
		and.l #255,d1
		move.l dun_start,a0
		add.l d1,a0
		lea sicht(pc),a1
		add.l #11,a1
		moveq #8,d0
draw_alles_1b:
		move.b 1(a0),1(a1)
		move.b 2(a0),2(a1)
		move.b 3(a0),3(a1)
		move.b 4(a0),4(a1)
		move.b 5(a0),5(a1)
		move.b 6(a0),6(a1)
		move.b 7(a0),7(a1)
		move.b 8(a0),8(a1)
		move.b 9(a0),9(a1)
		add.l #11,a1
		add.l d1,a0
		dbra d0,draw_alles_1b
		bra draw_it
draw_alles:
		move.b size_x,d1
		and.l #255,d1
		move.l dun_start,a0
		lea sicht(pc),a1
		moveq #10,d0
draw_alles_b:
		move.b (a0),(a1)
		move.b 1(a0),1(a1)
		move.b 2(a0),2(a1)
		move.b 3(a0),3(a1)
		move.b 4(a0),4(a1)
		move.b 5(a0),5(a1)
		move.b 6(a0),6(a1)
		move.b 7(a0),7(a1)
		move.b 8(a0),8(a1)
		move.b 9(a0),9(a1)
		move.b 10(a0),10(a1)
		add.l #11,a1
		add.l d1,a0
		dbra d0,draw_alles_b

draw_it:
		eor.w #1,regen_timer
		move.l plane0,a0
		move.l plane1,a1
		move.l plane2,a2
		move.l plane3,a3
		move.l plane4,a4
		move.l plane5,a5
		lea sicht(pc),a6
		move.l a6,d4
		move.l ele,d5
		moveq #10,d3
		moveq #0,d1		;offset
draw_it1:
		moveq #10,d2
draw_it2:
		move.l d4,a6
		move.b (a6)+,d0
		move.l a6,d4

		move.l d5,a6
		and.l #255,d0
		move.l d0,d6
		lsl.l #7,d0
		lsl.l #6,d6
		add.l d6,d0
		add.l d0,a6

		cmp.b #0,regen
		beq.s draw_it3
		cmp.w #1,regen_timer
		bne.s draw_it3
		move.l d5,sd5
		bsr pr_regen
		move.l sd5,d5
		bra.s draw_it4
draw_it3:
		bsr.s pr_ele
draw_it4:
		sub.l #638,d1
		dbra d2,draw_it2
		add.l #618,d1
		dbra d3,draw_it1
		rts

sd5:		dc.l 0
;*************************************************
;brennt eine Fackel oder ein Feuer in der Nähe ?  (46-51)
ist_feuer:
		move.l dun_start,a0
		move.b size_x,d0
		and.l #255,d0
		moveq #10,d1
ist_feuer1:
		moveq #10,d2
ist_feuer2:
		cmp.b #46,(a0)
		beq.s ist_feuer4
		cmp.b #47,(a0)
		beq.s ist_feuer4
		cmp.b #48,(a0)
		beq.s ist_feuer4
		cmp.b #49,(a0)
		beq.s ist_feuer4
		cmp.b #50,(a0)
		beq.s ist_feuer4
		cmp.b #51,(a0)+
		beq.s ist_feuer4
		dbra d2,ist_feuer2
		moveq #10,d2
		add.l d0,a0
		sub.l #11,a0
		dbra d1,ist_feuer2
		move.b #0,d1
		rts
ist_feuer4:
		move.b #1,d1
		rts
;**************************************************
; Element anzeigen
; 1 Element ist 192 Bytes lang
; 2 Bytes breit, 16 Zeilen hoch und 6 Bitplanes tief

pr_ele:
		moveq #15,d0			;16 Zeilen
pr_ele2:
		move.w (a6),0(a0,d1)
		move.w 32(a6),0(a1,d1)
		move.w 64(a6),0(a2,d1)
		move.w 96(a6),0(a3,d1)
		move.w 128(a6),0(a4,d1)
		move.w 160(a6),0(a5,d1)
		add.l #2,a6
		add.l #40,d1
		dbra d0,pr_ele2
		rts
pr_regen:
		move.w #1,d6
		moveq #15,d0
		cmp.b #1,temperatur
		blt pr_schnee2
pr_regen2:
		move.w (a6),d7
		eor.w #$ffff,d6
		and.w d6,d7
		move.w d7,0(a0,d1)
		move.w 32(a6),d7
		eor.w #$ffff,d6
		or.w d6,d7
		move.w d7,0(a1,d1)
		move.w 64(a6),d7
		or.w d6,d7
		move.w d7,0(a2,d1)
		eor.w #$ffff,d6
		move.w 96(a6),d7
		and.w d6,d7
		move.w d7,0(a3,d1)
		move.w 128(a6),d7
		and.w d6,d7
		move.w d7,0(a4,d1)
		move.w 160(a6),d7
		and.w d6,d7
		move.w d7,0(a5,d1)
		add.l #2,a6
		add.l #40,d1
		eor.w #$ffff,d6
		move.b $bfe801,d7
		move.b $dff006,d5
		eor.b d5,d7
		ror.w d7,d6
		dbra d0,pr_regen2
		rts

pr_schnee2:
		move.w (a6),d7
		or.w d6,d7
		move.w d7,0(a0,d1)
		move.w 32(a6),d7
		or.w d6,d7
		move.w d7,0(a1,d1)
		move.w 64(a6),d7
		or.w d6,d7
		move.w d7,0(a2,d1)
		eor.w #$ffff,d6
		move.w 96(a6),d7
		and.w d6,d7
		move.w d7,0(a3,d1)
		move.w 128(a6),d7
		and.w d6,d7
		move.w d7,0(a4,d1)
		move.w 160(a6),d7
		and.w d6,d7
		move.w d7,0(a5,d1)
		add.l #2,a6
		add.l #40,d1
		eor.w #$ffff,d6
		move.b $bfe801,d7
		move.b $dff006,d5
		eor.b d5,d7
		ror.w d7,d6
		dbra d0,pr_schnee2
		rts

regen_timer:	dc.w 0,0

interupt:
		movem.l d1-d7/a1-a6,-(a7)
		cmp.b #1,pause
		beq leave_inter
		cmp.b #1,sleep
		beq.s inter_2
		cmp.l #3200,hunger
		blt.s inter_2
		sub.l #4,kraft
		sub.l #4,gesund
		move.l gesund,d0
		add.l kraft,d0
		lsl.l #2,d0
		sub.l d0,hunger
		move.b #0,hgesagt
inter_2:
		add.b #1,ticks
		cmp.b #4,ticks
		beq inter_s
		bra leave_inter
inter_s:
		bsr wellen
		move.b #0,ticks
		add.b #1,sekunde
		move.b sekunde,d0
		move.b wie_viel_sek,d1
		cmp.b d0,d1
		beq inter_m
		bra leave_inter
inter_m:
		move.b #0,sekunde
		add.b #1,minute
		cmp.b #60,minute
		beq inter_h
		bra leave_inter
inter_h:
		cmp.b #1,sleep
		beq.s inter_h2
		add.b #4,muede
		move.l gewicht,d0
		lsl.l #3,d0
		add.l d0,hunger
		bra.s inter_h3
inter_h2:
		sub.b #10,muede
inter_h3:
		move.b #0,minute
		add.b #1,stunde
		cmp.b #24,stunde
		beq inter_h0
		cmp.b #19,stunde
		beq inter_nacht1
		cmp.b #20,stunde
		beq inter_nacht2
		cmp.b #21,stunde
		beq inter_nacht3
		cmp.b #22,stunde
		beq inter_nacht4

		cmp.b #4,stunde
		beq inter_tag1
		cmp.b #5,stunde
		beq inter_tag2
		cmp.b #6,stunde
		beq inter_tag3
		cmp.b #7,stunde
		beq inter_tag4
		cmp.b #10,stunde
		beq inter_tag10
		cmp.b #11,stunde
		beq inter_tag10
		cmp.b #12,stunde
		beq inter_tag10
		bra leave_inter
inter_tag10:
		add.b #2,temperatur
		bra leave_inter
inter_tag1:
		move.b #3,tag
		bra leave_inter
inter_tag2:
		move.b #2,tag
		bra leave_inter
inter_tag3:
		move.b #1,tag
		bra leave_inter
inter_tag4:
		add.b #2,temperatur
		move.b #0,tag
		move.l konto0,d0
		move.l konto1,d1
		lsr.l #6,d0
		lsr.l #7,d1
		add.l d0,konto0
		add.l d1,konto1
		bra leave_inter
inter_nacht1:
		sub.b #2,temperatur
		move.b #1,tag
		bra leave_inter
inter_nacht2:
		sub.b #2,temperatur
		move.b #2,tag
		bra leave_inter
inter_nacht3:
		sub.b #2,temperatur
		move.b #3,tag
		bra leave_inter
inter_nacht4:
		sub.b #2,temperatur
		move.b #4,tag
		bra leave_inter
inter_h0:
		move.b #0,stunde
		cmp.b #31,day
		beq.s inter_day
		add.b #1,day
		bra.s leave_inter
inter_day:
		move.b #1,day
		cmp.b #12,monat
		beq.s inter_monat
		add.b #1,monat
		move.b monat,d0
		and.l #255,d0
		sub.l #1,d0
		lea temp_monat,a0
		move.b (a0,d0),temperatur
		sub.b #8,temperatur
		bra.s leave_inter
inter_monat:
		move.b #1,monat
		move.b monat,d0
		and.l #255,d0
		sub.l #1,d0
		lea temp_monat,a0
		move.b (a0,d0),temperatur
		sub.b #8,temperatur
		add.b #1,jahr
leave_inter:
		movem.l (a7)+,d1-d7/a1-a6
		moveq #0,d0		;muß sein
		lea $dff000,a0		;dito
		rts

;**********************************************
;******** TEXTE

text_up:
		move.l zeile_1,zeile_0
		move.l zeile_2,zeile_1
		move.l zeile_3,zeile_2
		move.l zeile_4,zeile_3
		move.l zeile_5,zeile_4
		move.l zeile_6,zeile_5
		move.l zeile_7,zeile_6
		move.l zeile_8,zeile_7
		move.l zeile_9,zeile_8
		move.l zeile_10,zeile_9
		rts
print_text:
		ptext #101,#23,#55,zeile_0
		ptext #101,#23,#63,zeile_1
		ptext #101,#23,#71,zeile_2
		ptext #101,#23,#79,zeile_3
		ptext #101,#23,#87,zeile_4
		ptext #101,#23,#95,zeile_5
		ptext #101,#23,#103,zeile_6
		ptext #101,#23,#111,zeile_7
		ptext #101,#23,#119,zeile_8
		ptext #101,#23,#127,zeile_9
		ptext #101,#23,#135,zeile_10
		rts

pr_leer:	dc.b "                ",0
pr_nord:	dc.b "Norden          ",0
pr_sued:	dc.b "Sueden          ",0
pr_west:	dc.b "Westen          ",0
pr_ost:		dc.b "Osten           ",0
pr_block1:	dc.b "Blockiert       ",0
pr_block2:	dc.b "Doing           ",0
pr_block3:	dc.b "kein Weg        ",0
pr_morast1:	dc.b "schlechter Weg  ",0
pr_morast2:	dc.b "blieb stecken   ",0
pr_morast3:	dc.b "eingesumpft     ",0
pr_no_eat:	dc.b "Kein Proviant   ",0
pr_hunger:	dc.b "Ich habe Hunger ",0
pr_bank00:	dc.b "  CO Bank AG    ",0
pr_bank01:	dc.b "   Willkommen   ",0
pr_bank02:	dc.b "  koennen wir   ",0
pr_bank03:	dc.b " Ihnen helfen ? ",0
pr_bank10:	dc.b "   Rush Bank    ",0
pr_bank11:	dc.b " Hallo, koennen ",0
pr_bank12:	dc.b "wir Ihnen unsere",0
pr_bank13:	dc.b "Hilfe anbieten ?",0
pr_bank14:	dc.b "  (J)a  (N)ein  ",0
pr_bank_zu:	dc.b "Bank geschlossen",0
pr_bank_zu1:	dc.b "Tut mir leid,wir",0
pr_bank_zu2:	dc.b "schliessen jetzt",0
pr_bank_bye:	dc.b "Auf wiedersehen ",0
pr_bank_bye1:	dc.b "    Good Bye    ",0
pr_bank_bye2:	dc.b "    bis bald    ",0
pr_bank_0:	dc.b "  Waehlen Sie   ",0
pr_bank_1:	dc.b "(A) Konto Stand ",0
pr_bank_2:	dc.b "(B) Abheben     ",0
pr_bank_3:	dc.b "(C) Einzahlen   ",0
pr_f_sh_4:	dc.b "(X) Verlassen   ",0
pr_konto_st:	dc.b "   Kontostand   ",0
pr_konto_geld:	dc.b "                ",0
pr_konto_st2:	dc.b "   (W)eiter     ",0
pr_abheben1:	dc.b "Geben Sie ein,  ",0
pr_abheben2:	dc.b " wieviel Sie    ",0
pr_abheben3:	dc.b "abheben wollen !",0
pr_viel1:	dc.b "  Soviel Geld   ",0
pr_viel2:	dc.b "haben Sie nicht ",0
pr_viel3:	dc.b "auf Ihrem Konto ",0
pr_nviel1:	dc.b "  Ihr Konto ist ",0
pr_nviel2:	dc.b "leider momentan ",0
pr_nviel3:	dc.b "nicht gedeckt ! ",0
pr_einzahlen3:	dc.b "einzahlen wollen",0
pr_nviel10:	dc.b " Sie haben kein ",0
pr_nviel20:	dc.b "  Geld, um es   ",0
pr_nviel30:	dc.b "hier einzuzahlen",0
pr_viel30:	dc.b "     Dabei !    ",0
pr_haus_leer:	dc.b "  Haus ist leer ",0
pr_f_shop0:	dc.b "   Willkommen   ",0
pr_f_shop1:	dc.b "      Hallo     ",0
pr_f_shop2:	dc.b "  Guten Tag !   ",0
pr_f_shop00:	dc.b "Kann ich helfen ",0
pr_f_shop10:	dc.b "Etwas Proviant ?",0
pr_f_shop20:	dc.b "    Kaufen ?    ",0
pr_f_shop_zu:	dc.b "  Geschlossen   ",0
pr_f_shop_wahl: dc.b "   Ihre Wahl    ",0
pr_f_shop_g0:	dc.b " Du bist pleite ",0 
pr_f_shop_g1:	dc.b "nichts ohne Geld",0 
pr_f_shop_g2:	dc.b "Du kannst nicht ",0
pr_f_shop_g2b:	dc.b "    bezahlen    ",0
pr_no_hunger:	dc.b "Habe kein Hunger",0
pr_arzt00:	dc.b "  Kayden Gerth  ",0
pr_arzt01:	dc.b "    Hospital    ",0
pr_arzt02:	dc.b "Sie sind Krank ?",0
pr_arzt03:	dc.b "  (J)a  (N)ein  ",0
pr_arzt10:	dc.b "  Prospert Kont ",0
pr_arzt11:	dc.b "     Klinik     ",0
pr_arzt12:	dc.b "Soll ich helfen ",0
pr_arzt13:	dc.b "  (J)a  (N)ein  ",0
pr_arzt_gesund:	dc.b "Sie sind gesund ",0
pr_arzt_w0:	dc.b "   Ihre Wahl !  ",0
pr_arzt_w1:	dc.b "(A) 100 %  (500)",0
pr_arzt_w2:	dc.b "(B)  75 %  (350)",0
pr_arzt_w3:	dc.b "(C)  50 %  (250)",0
pr_arzt_w4:	dc.b "(X) Verlassen   ",0
pr_kneipe_20:	dc.b "    Hunger ?    ",0
pr_kneipe_10:	dc.b " Etwas essen ?  ",0
pr_kneipe_00:	dc.b "Wollen Sie essen",0
pr_kneipe_30:	dc.b " (E)essen ?     ",0
pr_kneipe_40:	dc.b " (T)rinken ?    ",0
pr_kneipe_50:   dc.b " (X) verlassen  ",0
pr_cas0:	dc.b "     Spielen    ",0
pr_cas1:	dc.b "       und      ",0
pr_cas2:	dc.b "     Gewinnen   ",0
pr_cas3:	dc.b "(A) Schwamf     ",0
pr_cas4:	dc.b "(B) Pnunf       ",0
pr_cas5:	dc.b "Nicht genug Geld",0
pr_cas6:	dc.b "    Schwamf     ",0
pr_cas7:	dc.b "Einsatz: 10     ",0
pr_cas8:	dc.b " (A) Spielen    ",0
pr_cas9:	dc.b "     Pnunf      ",0
pr_cas10:	dc.b "Einsatz: 5      ",0
pr_cas_pn0:	dc.b "Gezogen(1-16):  ",0
pr_cas_pn1:	dc.b " Raten Sie......",0
pr_cas_pn2:	dc.b "Ob die folgende ",0
pr_cas_pn3:	dc.b "      Zahl      ",0
pr_cas_pn4:	dc.b "       (1)      ",0
pr_cas_pn5:	dc.b "       (2)      ",0
pr_cas_pn6:	dc.b "       (3)      ",0
pr_cas_pn7:	dc.b "     heisst     ",0
pr_cas_scw2:	dc.b "Ob die folgende ",0
pr_cas_scw3:	dc.b "      Zahl      ",0
pr_cas_scw4:	dc.b "   (G)roesser   ",0
pr_cas_scw5:	dc.b "     oder       ",0
pr_cas_scw6:	dc.b "   (K)leiner    ",0
pr_cas_scw7:	dc.b "      ist       ",0
pr_cas_win:	dc.b " Gewonnen !!!!! ",0
pr_cas_los:	dc.b "Leider verloren ",0
pr_wach:	dc.b "Ich bin wach !! ",0
pr_wach2:	dc.b "bin nicht muede ",0
pr_schlaf:	dc.b "Ich schlafe ein ",0
pr_hotel0:	dc.b "Ein Nachtlager ?",0
pr_hotel1:	dc.b "Es Kostet :     ",0
pr_hotel2:	dc.b "Wollen Sie Hier ",0
pr_hotel3:	dc.b "uebernachten ?  ",0
pr_hotel4:	dc.b "fuer nur  :     ",0
pr_waff0:	dc.b "  Willkomen in  ",0
pr_waff1:	dc.b "meiner Schmiede ",0
pr_waff2:	dc.b "Ich erzeuge die ",0
pr_waff3:	dc.b "besten Waffen !!",0
pr_waff4:	dc.b " Wollen Sie bei ",0
pr_waff5:	dc.b "  mir kaufen ?  ",0
pr_waff0a:	dc.b "Bei Felix sind  ",0
pr_waff1a:	dc.b "Waffen und Ruest",0
pr_waff2a:	dc.b "  guenstig zu   ",0
pr_waff3a:	dc.b "   zu kaufen    ",0
pr_waff4a:	dc.b " Ein wenig Metal",0
pr_waff5a:	dc.b "     Kaufen?    ",0
pr_waff0b:	dc.b " Ich biete alle ",0
pr_waff1b:	dc.b "Waren guenstiger",0
pr_waff2b:	dc.b "  an als meine  ",0
pr_waff3b:	dc.b "   Konkurenz !  ",0
pr_waff4b:	dc.b " Haben Sie Lust ",0
pr_waff5b:	dc.b "  zu Kaufen?    ",0
pr_waff0c:	dc.b "Beste Schwerter ",0
pr_waff1c:	dc.b "Gute Ruestungen ",0
pr_waff2c:	dc.b " und sehr guter ",0
pr_waff3c:	dc.b "    Service !   ",0
pr_waff4c:	dc.b "  Wuenschen Sie ",0
pr_waff5c:	dc.b "     etwas ?    ",0
pr_waff_menu:	dc.b " Waehlen Sie !  ",0
pr_waff_menu1:	dc.b " (A) Waffen     ",0
pr_waff_menu2:	dc.b " (B) Ruestungen ",0
pr_waff_menu3:	dc.b " (C) Gemischtes ",0
pr_waff_menu4:	dc.b " (X) verlassen  ",0
pr_waff_pl0:	dc.b " Sie haben kein ",0
pr_waff_pl1:	dc.b " Platz mehr um  ",0
pr_waff_pl2:	dc.b "dies zu tragen !",0
pr_waff_pl3:	dc.b "Wollen Sie etwas",0
pr_waff_pl4:	dc.b "von ihren Sachen",0
pr_waff_pl5:	dc.b "verkaufen ,damit",0
pr_waff_pl6:	dc.b "Sie denoch den  ",0
pr_waff_pl7:	dc.b "   Gegenstand   ",0
pr_waff_pl8:	dc.b "kaufen koennen ?",0
pr_waff_pl9:	dc.b " Markieren Sie  ",0
pr_waff_pl10:	dc.b " den Gegenstand ",0
pr_waff_pl11:	dc.b "  mit der Maus  ",0
pr_waff_pl12:	dc.b "   welchen Sie  ",0
pr_waff_pl13:	dc.b "verkaufen wollen",0
pr_waff_pl14:	dc.b "     Diesen     ",0
pr_waff_pl15:	dc.b "   Gegenstand   ",0
pr_waff_pl16:	dc.b "   verkaufen ?  ",0
pr_waff_pl17:	dc.b "Ich biete:      ",0
pr_ruest_0:	dc.b "Sie haben schon ",0
pr_ruest_1:	dc.b "eine Ruestung...",0
pr_ruest_2:	dc.b "Wollen Sie diese",0
pr_ruest_3:	dc.b "verkaufen, damit",0
pr_ruest_4:	dc.b " Sie eine neue  ",0
pr_ruest_5:	dc.b "kaufen koennen ?",0
pr_nix_licht:	dc.b "Habe Keine Lampe",0
pr_nix_licht2:	dc.b " in der Hand !! ",0
pr_licht:	dc.b "Es werde Licht  ",0
pr_licht2:	dc.b "Lampe aus...    ",0
pr_verk0:	dc.b "   Dextrox AG   ",0
pr_verk1:	dc.b "     Ankauf     ",0
pr_verk2:	dc.b "von gebrauchten ",0
pr_verk3:	dc.b "Sachen aller Art",0
pr_verk4:	dc.b "Haben Sie etwas ",0
pr_verk5:	dc.b " zu verkaufen ? ",0
pr_nix_verk0:	dc.b "Sie haben nichts",0
pr_nix_verk1:	dc.b "  was Sie mir   ",0
pr_nix_verk2:	dc.b "   verkaufen    ",0
pr_nix_verk3:	dc.b "  koennten !!   ",0
		even

pr_f_artikel0:	dc.b "                ",0,0
pr_f_artikel1:	dc.b "                ",0,0
pr_f_artikel2:	dc.b "                ",0,0
pr_f_artikel3:	dc.b "                ",0,0
pr_f_artikel4:	dc.b "                ",0,0
pr_f_artikel5:	dc.b "                ",0,0
pr_f_artikel6:	dc.b "                ",0,0

		even

zeile_0:	dc.l pr_leer
zeile_1:	dc.l pr_leer
zeile_2:	dc.l pr_leer
zeile_3:	dc.l pr_leer
zeile_4:	dc.l pr_leer
zeile_5:	dc.l pr_leer
zeile_6:	dc.l pr_leer
zeile_7:	dc.l pr_leer
zeile_8:	dc.l pr_leer
zeile_9:	dc.l pr_leer
zeile_10:	dc.l pr_leer

char_set:	dc.l 0			;Zeichensatz
window_txt:	dc.l 0			;Text Fenster
icon_bar:	dc.l 0
stat:		dc.l 0
stat1:		dc.l 0
pic:		dc.l 0
ele:		dc.l 0
dungeon:	dc.l 0			;Oberwelt  250 x 250
dungeon2:	dc.l 0			;Dungeon   250 x 250 unter Oberwelt
dun_start:	dc.l 0
dun_start2:	dc.l 0			;siehe hier2
hier:		dc.l 0			;hier steht der Spieler
hier2:		dc.l 0			;für betreten und talk
city:		dc.l 0			;Speicherplatz für Städte u. Burgen

sprite:		dc.l 0			;Nummer des Spieler Sprites
hunger:		dc.l 0			;wenn hunger voll ist muß mann essen
max_kraft:	dc.l 0
kraft:		dc.l 0
gesund:		dc.l 0
geld:		dc.l 0
essen:		dc.l 0
exper:		dc.l 0
konto0:		dc.l 0
konto1:		dc.l 0
gewicht:	dc.l 0			;Gewicht das die Figur trägt
					;je mehr Gewicht desto höher Energieverbrauch

ruest:		dc.l nichts		;Zeiger auf die Rüstung
hand_rechts:	dc.l nichts
hand_links:	dc.l nichts
tasche0:	dc.l nichts
tasche1:	dc.l nichts
tasche2:	dc.l nichts

welche_bank:	dc.l 0			;Zeiger auf das Konto

bobs:		dc.l 0			;Adresse der Sprites
bobs2:		dc.l 0			;Adresse der Gegenstände (Grafiken)

welcher_shop1:	dc.l 0			;Zeiger auf Laden Struktur
welcher_shop2:	dc.l 0

food_dat0:	dc.l name_shop0		;zeiger auf Namen des Shops
		dc.l food_graf0		;zeigre auf Grafik (laden)
		dc.l name_ess0		;zeiger auf  Namen Lebensmittel 0
		dc.l name_ess1		;zeiger auf  Namen Lebensmittel 1
		dc.l name_ess2		;zeiger auf  Namen Lebensmittel 2
		dc.l name_ess3		;zeiger auf  Namen Lebensmittel 3
		dc.l name_ess4		;zeiger auf  Namen Lebensmittel 4

;wenn Preis = 0 dann ist Lebensmittel nicht verfügbar
		dc.l 7,1		;Preis Lebensmittel0 + essen
		dc.l 10,4		;Preis Lebensmittel1 + essen
		dc.l 4,1		;Preis Lebensmittel2 + essen
		dc.l 7,2		;Preis Lebensmittel3 + essen
		dc.l 5,2		;Preis Lebensmittel4 + essen
		dc.l 0			;Anim Tab für Grafik

food_dat1:	dc.l name_shop1
		dc.l food_graf1
		dc.l name_ess0b
		dc.l name_ess1b
		dc.l name_ess2b
		dc.l name_ess3b
		dc.l name_ess4b
		dc.l 4,1
		dc.l 8,4
		dc.l 9,1
		dc.l 5,2
		dc.l 6,2
		dc.l 0

food_dat2:	dc.l name_shop2
		dc.l food_graf2
		dc.l name_ess0b
		dc.l name_ess1
		dc.l name_ess2b
		dc.l name_ess3
		dc.l name_ess4b
		dc.l 7,1
		dc.l 12,4
		dc.l 15,1
		dc.l 10,2
		dc.l 11,2
		dc.l 0

food_dat3:	dc.l name_shop3
		dc.l food_graf3
		dc.l name_ess0
		dc.l name_ess1b
		dc.l name_ess2
		dc.l name_ess3
		dc.l name_ess4b
		dc.l 4,1
		dc.l 6,4
		dc.l 8,1
		dc.l 4,2
		dc.l 5,2
		dc.l 0

food_dat4:	dc.l name_shop4
		dc.l food_graf4
		dc.l name_ess0
		dc.l name_ess1
		dc.l name_ess2
		dc.l name_ess3b
		dc.l name_ess4
		dc.l 6,1
		dc.l 9,4
		dc.l 1,1
		dc.l 3,2
		dc.l 4,2
		dc.l 0

kneipe_dat0:	dc.l name_kneipe0
		dc.l kneip_graf0
		dc.l essen_1,10
		dc.l essen_2,22
		dc.l essen_3,11
		dc.l essen_4,33
		dc.l essen_5,44
		dc.l essen_6,76
		dc.l drink1,1
		dc.l drink2,2
		dc.l drink3,5
		dc.l drink4,7
		dc.l drink5,8
		dc.l drink6,10
		dc.l 0				;Anim Tab

kneipe_dat1:	dc.l name_kneipe1
		dc.l kneip_graf1
		dc.l essen_1a,16
		dc.l essen_2b,21
		dc.l essen_3c,32
		dc.l essen_4d,14
		dc.l essen_5e,81
		dc.l essen_6f,41
		dc.l drink1a,1
		dc.l drink2a,4
		dc.l drink3a,7
		dc.l drink4a,9
		dc.l drink5a,11
		dc.l drink6a,13
		dc.l 0

hotel_dat0:
		dc.l name_hotel0		;Name des Hotels
		dc.l 48				;Preis für eine Übernachtung
		dc.l 0				;Zeiger auf Grafik
		dc.l 0				;Zeiger auf Anim Tab
hotel_dat1:
		dc.l name_hotel1
		dc.l 40
		dc.l 0
		dc.l 0
hotel_dat2:
		dc.l name_hotel2
		dc.l 45
		dc.l 0
		dc.l 0
hotel_dat3:
		dc.l name_hotel3
		dc.l 49
		dc.l 0
		dc.l 0

waffen_dat0:
		dc.l name_waffen0		;Name des Waffenladens
		dc.l 0				;Grafik
		dc.l 0				;Anim Tab
		dc.l pr_waff0			;Text
		dc.l pr_waff1			;Text
		dc.l pr_waff2
		dc.l pr_waff3
		dc.l pr_waff4
		dc.l pr_waff5
		dc.l waffe0			;Name der Waffe
		dc.l waffe1
		dc.l waffe2
		dc.l waffe3
		dc.l waffe4
		dc.l waffe5
		dc.l ruest0			;Name der Ruestung
		dc.l ruest1
		dc.l ruest2
		dc.l ruest3
		dc.l ruest4
		dc.l ruest5
waffen_dat1:
		dc.l name_waffen1		;Name des Waffenladens
		dc.l 0				;Grafik
		dc.l 0				;Anim Tab
		dc.l pr_waff0a			;Text
		dc.l pr_waff1a			;Text
		dc.l pr_waff2a
		dc.l pr_waff3a
		dc.l pr_waff4a
		dc.l pr_waff5a
		dc.l waffe0a			;Name der Waffe
		dc.l waffe1a
		dc.l waffe2a
		dc.l waffe3a
		dc.l waffe4a
		dc.l waffe5a
		dc.l ruest0a			;Name der Ruestung
		dc.l ruest1a
		dc.l ruest2a
		dc.l ruest3a
		dc.l ruest4a
		dc.l ruest5a
waffen_dat2:
		dc.l name_waffen2		;Name des Waffenladens
		dc.l 0				;Grafik
		dc.l 0				;Anim Tab
		dc.l pr_waff0b			;Text
		dc.l pr_waff1b			;Text
		dc.l pr_waff2b
		dc.l pr_waff3b
		dc.l pr_waff4b
		dc.l pr_waff5b
		dc.l waffe0b			;Name der Waffe
		dc.l waffe1b
		dc.l waffe2b
		dc.l waffe3b
		dc.l waffe4b
		dc.l waffe5b
		dc.l ruest0b			;Name der Ruestung
		dc.l ruest1b
		dc.l ruest2b
		dc.l ruest3b
		dc.l ruest4b
		dc.l ruest5b
waffen_dat3:
		dc.l name_waffen3		;Name des Waffenladens
		dc.l 0				;Grafik
		dc.l 0				;Anim Tab
		dc.l pr_waff0c			;Text
		dc.l pr_waff1c			;Text
		dc.l pr_waff2c
		dc.l pr_waff3c
		dc.l pr_waff4c
		dc.l pr_waff5c
		dc.l waffe0			;Name der Waffe
		dc.l waffe1a
		dc.l waffe2b
		dc.l waffe3
		dc.l waffe4a
		dc.l waffe5b
		dc.l ruest0			;Name der Ruestung
		dc.l ruest1a
		dc.l ruest2b
		dc.l ruest3
		dc.l ruest4a
		dc.l ruest5b

lampe:		dc.b "(A) Lampe: 25   ",0,0
		dc.l 25,1,255,9

nichts:		dc.b "                ",0,0
		dc.l 0,0,0,0

waffe0:		dc.b "(A) Dolch :   40",0,0
		dc.l 40,2,1,1			;Preis,Gewicht,Power;Sprite
waffe1:		dc.b "(B) Keule :   82",0,0
		dc.l 82,6,3,4
waffe2:		dc.b "(C) Bogen :   90",0,0
		dc.l 90,4,3,8
waffe3:		dc.b "(D) Axt   :  122",0,0
		dc.l 122,8,5,3
waffe4:		dc.b "(E) Schwert: 182",0,0
		dc.l 182,9,7,2
waffe5:		dc.b "(F) Lanze :  172",0,0
		dc.l 172,5,5,6

waffe0a:	dc.b "(A) Messer:   42",0,0
		dc.l 42,2,1,1
waffe1a:	dc.b "(B) Knueppel: 80",0,0
		dc.l 80,6,3,4
waffe2a:	dc.b "(C) Speer :  120",0,0
		dc.l 120,4,3,6
waffe3a:	dc.b "(D) Beil  :  112",0,0
		dc.l 112,8,5,3
waffe4a:	dc.b "(E) Degen :  132",0,0
		dc.l 132,5,6,2
waffe5a:	dc.b "(F) Morgenst:192",0,0
		dc.l 192,8,8,5

waffe0b:	dc.b "(A) Dolch :   32",0,0
		dc.l 32,2,1,1
waffe1b:	dc.b "(B) Keule :   87",0,0
		dc.l 87,6,3,4
waffe2b:	dc.b "(C) Bogen :   95",0,0
		dc.l 95,4,3,8
waffe3b:	dc.b "(D) Hammer:  100",0,0
		dc.l 100,8,4,11
waffe4b:	dc.b "(E) Schwert: 162",0,0
		dc.l 162,9,7,2
waffe5b:	dc.b "(F) Lanze :  192",0,0
		dc.l 192,5,5,6

ruest0:		dc.b "(A) Stoff  :  22",0,0
		dc.l 22,1,1,0			;Preis,Gewicht,Schutz,Sprite
ruest1:		dc.b "(B) Stroh  :  35",0,0
		dc.l 35,2,2,0
ruest2:		dc.b "(C) Leder  :  57",0,0
		dc.l 57,4,4,1
ruest3:		dc.b "(D) Kupfer :  87",0,0
		dc.l 87,8,9,3
ruest4:		dc.b "(E) Eisen  : 160",0,0
		dc.l 160,12,9,2
ruest5:		dc.b "(F) Silber : 165",0,0
		dc.l 165,11,9,2

ruest0a:	dc.b "(A) Stoff  :  22",0,0
		dc.l 22,1,1,0			;Preis,Gewicht,Schutz,Sprite
ruest1a:	dc.b "(B) Stroh  :  35",0,0
		dc.l 35,2,2,0
ruest2a:	dc.b "(C) Schuppen: 67",0,0
		dc.l 67,4,4,2
ruest3a:	dc.b "(D) Blech  :  77",0,0
		dc.l 77,8,9,2
ruest4a:	dc.b "(E) Eisen  : 150",0,0
		dc.l 150,12,9,2
ruest5a:	dc.b "(F) Titan  : 365",0,0
		dc.l 365,6,10,4

ruest0b:	dc.b "(A) Leinen :  20",0,0
		dc.l 20,1,1,0
ruest1b:	dc.b "(B) Stroh  :  32",0,0
		dc.l 32,2,2,0
ruest2b:	dc.b "(C) Leder  :  59",0,0
		dc.l 59,4,4,1
ruest3b:	dc.b "(D) Silber : 170",0,0
		dc.l 170,8,9,2
ruest4b:	dc.b "(E) Eisen  : 160",0,0
		dc.l 160,12,9,2
ruest5b:	dc.b "(F) Gold   : 265",0,0
		dc.l 265,10,9,3

name_waffen0:	dc.b "Haro der Schmied",0
name_waffen1:	dc.b "Felix Eisenwaren",0
name_waffen2:	dc.b "  Eisenbeisser  ",0
name_waffen3:	dc.b "   Hardware     ",0
name_hotel0:	dc.b "  Rotes Schaf   ",0
name_hotel1:	dc.b "Kayden Garth In ",0
name_hotel2:	dc.b "  Maritim Hotel ",0
name_hotel3:	dc.b "Ableietert Hotel",0

name_kneipe0:	dc.b "   Kaftkas In   ",0
name_kneipe1:	dc.b "    Hibernia    ",0

name_ess0:	dc.b "(A) Hierse :",0,0,0,0
name_ess1:	dc.b "(B) Kador  :",0,0,0,0
name_ess2:	dc.b "(C) Brot   :",0,0,0,0
name_ess3:	dc.b "(D) Fleisch:",0,0,0,0
name_ess4:	dc.b "(E) Fisch  :",0,0,0,0
name_ess0b:	dc.b "(A) Hafer  :",0,0,0,0
name_ess1b:	dc.b "(B) Banane :",0,0,0,0
name_ess2b:	dc.b "(C) Tomate :",0,0,0,0
name_ess3b:	dc.b "(D) Wurst  :",0,0,0,0
name_ess4b:	dc.b "(E) Apfel  :",0,0,0,0

essen_1:	dc.b "(A) Suppe  :",0,0,0,0
essen_2:	dc.b "(B) Fisch  :",0,0,0,0
essen_3:	dc.b "(C) Toasat :",0,0,0,0
essen_4:	dc.b "(D) Huhn   :",0,0,0,0
essen_5:	dc.b "(E) Beef   :",0,0,0,0
essen_6:	dc.b "(F) Kaviar :",0,0,0,0
essen_1a:	dc.b "(A) Pizza  :",0,0,0,0
essen_2b:	dc.b "(B) Frikase:",0,0,0,0
essen_3c:	dc.b "(C) Bagette:",0,0,0,0
essen_4d:	dc.b "(D) Pommes :",0,0,0,0
essen_5e:	dc.b "(E) Ente   :",0,0,0,0
essen_6f:	dc.b "(F) Lasagne:",0,0,0,0
drink1:		dc.b "(A) Wasser :",0,0,0,0
drink2:		dc.b "(B) O Saft :",0,0,0,0
drink3:		dc.b "(C) C Saft :",0,0,0,0
drink4:		dc.b "(D) Limo   :",0,0,0,0
drink5:		dc.b "(E) Bier   :",0,0,0,0
drink6:		dc.b "(F) Wein   :",0,0,0,0
drink1a:	dc.b "(A) Wasser :",0,0,0,0
drink2a:	dc.b "(B) Fnata  :",0,0,0,0
drink3a:	dc.b "(C) Fola   :",0,0,0,0
drink4a:	dc.b "(D) O Saft :",0,0,0,0
drink5a:	dc.b "(E) Sekt   :",0,0,0,0
drink6a:	dc.b "(F) Bogole :",0,0,0,0


name_shop0:	dc.b "    Baldi       ",0
name_shop1:	dc.b "    Wedeka      ",0
name_shop2:	dc.b "   Sauf das     ",0
name_shop3:	dc.b "   MC Ronald    ",0
name_shop4:	dc.b "   Hoffmanns    ",0
food_graf0:	dc.b "adv:Grafik/f0",0
food_graf1:	dc.b "adv:Grafik/f1",0
food_graf2:	dc.b "adv:Grafik/f2",0
food_graf3:	dc.b "adv:Grafik/f3",0
food_graf4:	dc.b "adv:Grafik/f4",0
kneip_graf0:	dc.b "adv:Grafik/k0",0
kneip_graf1:	dc.b "adv:Grafik/k1",0

size_x:		dc.b 0			;X Ausdehnung des Dungeons
size_y:		dc.b 0			;Y Ausdehnung des Dungeons
pause:		dc.b 0			;wenn pause=1 dann Uhr aus
anim:		dc.b 0

jahr:		dc.b 0			;Jahr
monat:		dc.b 0			;Monat 1-12
day:		dc.b 0			;Tag 1-31

temperatur:	dc.b 0
regen:		dc.b 0			;1 = Regen (Winter Schnee)
tag:		dc.b 0
stunde:		dc.b 0
minute:		dc.b 0
sekunde:	dc.b 0
ticks:		dc.b 0
w_bank:		dc.b 0			;in welcher Bank ist er
hgesagt:	dc.b 0			;hat gesagt das er Hunger hat
muede:		dc.b 0			;jede Stunde +1 wenn 24 ereicht
					;dann Spieler tot
wie_viel_sek:	dc.b 0			;Wieviel Sekunden
sleep:		dc.b 0			;1 = Person schläft
inv:		dc.b 0			;0 = Status Anzeige
					;1 = Gegenstände
licht:		dc.b 0
unten:		dc.b 0			;ist Person im Dungeon ? (1)

temp_monat:	dc.b -8,-6,-1,10	;Temperaturwerte der Monate
		dc.b 15,20,23,23
		dc.b 18,12,8,-5



nummer:		dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

		even
puffer:		ds.b 200
sicht:		ds.b 200

		even

		include "ram:befehle"
