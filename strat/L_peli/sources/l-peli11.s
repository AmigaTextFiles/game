
;**************************************************************************
;*                                                                        *
;*                                                                        *
;*                              L-Peli                            	  *
;*                              ------                                    *
;*					 				  *
;*                             Versio 1.1				  *
;*									  *
;*                          27. Elokuuta 94				  *
;*									  *
;*       	       Copyright © 1994 Esa Piiril‰ 			  *
;*									  *
;**************************************************************************
;*									  *
;*	Uusittua sitten version 1.0					  *
;*									  *
;*	1.1	- nappula on nyt siirett‰v‰ uuteen paikkaan (!)		  *
;*		- Vinkki‰ ei saa en‰‰ menun aikana (aiheutti sekoilua)	  *
;*		- muutama pienempi korjaus				  *
;*									  *
;**************************************************************************
;*                                                                        *
;*	  Tutustu paketissa 'LPELI10E.LHA' olevaan dokumenttiin           *
;*	  'lueminut'. T‰m‰ ohjelma on k‰‰nnetty Devpacin (3.04)		  *
;*	  assemblerilla. Ohjelmaa on testattu seuraavissa koneissa:	  *
;*        A500/1.2, B2000/1.3, A3000/030 ja A4000/040                     *
;*                                                                        *
;*	  T‰t‰ ei ole kirjoitettu miksik‰‰n koodauksen oppikirjaksi.	 †*
;*	  Joten en juurikaan suosittele, ett‰ hirve‰sti ottaisit	  *
;*	  t‰st‰ mallia, sill‰ parempiakin esimerkkej‰ t‰ytyy lˆyty‰.	  *
;*									  *
;*	  Ohjelmakoodia ei ole ehditty kovinkaan paljon optimoida 	  *
;*	  tai siisti‰ aina niin yll‰tt‰v‰n aikaisen deadlinen takia.	  *
;*                      (aika on aina k‰yp‰ tekosyy...)	        	  *
;*                                                                        *
;**************************************************************************


;**************************************************************************
;*                                                                        *
;*        Ohjelman yleinen rakenne koostuu kahdesta p‰‰rutiinista	  *
;*	  (test ja int), joista kutsutaan tarvittaessa muita rutiineja,   *
;*	  jonne varsinainen likainen tyˆ on piilotettu.                   *
;*									  *
;*	  Test rutiinissa odotellaan ohjelman p‰‰tt‰mist‰ tai siirtojen	  *
;*	  laskemispyyntˆ‰ (mbr), jolloin k‰yd‰‰n laskemassa mahdolliset	  *
;*	  siirrot taulukossa 'board' olevasta tilanteesta.		  *
;*									  *
;*	  Int rutiinissa hoidetaan kaikki kontrolli (joystick, n‰ppis ja  *
;*	  hiiri). Sielt‰ kutsutaan myˆs grafiikan p‰ivitysrutiinit, menu  *
;*	  ja jne. Int pyˆrii vertical blankin aikana, siirtojen		  *
;*	  laskemin  on siirretty t‰m‰n ulkopuolelle, koska sen verran	  *
;*	  aikaa viev‰mpi operaatio.					  *
;*									  *
;*	  Joitakin t‰rkeimpi‰ taulukoita:				  *
;*									  *
;*          board		sis‰lt‰‰ t‰m‰n hetkisen tilanteen,        *
;*			        siit‰ suodatetaan piirron j‰lkeen     	  *    
;*	 			siirtovuorossa oleva nappula pois.	  *
;*									  *
;*	    board_r		todellinen tilanne, jossa on kaikki	  *
;*				nappulat tallella.			  *
;*								 	  *
;*	    init_board		sis‰lt‰‰ pelin alkutilanteen		  *
;*									  *
;*          board*		sis‰lt‰v‰t tyˆkopioita pelitilanteesta    *
;*	    								  *
;*	    taulukko_c		Taulukko siirtojen hyvyydest‰. Sis‰lt‰‰	  *
;*				koneen aivot.				  *
;*	    								  *
;*	    taulukot board* koostuvat 36 tavusta (esim. alkutilanne):	  *
;*									  *
;*			444444						  *
;*			432234						  *
;*			401204						  *
;*			401204						  *
;*		        401134						  *
;*			444444						  *
;*									  *
;*		miss‰ 1 on koneen nappula (tai toisen pelaajan)		  *
;*		      2 on oma nappula (sininen)			  *
;*		      3 ovat puolueettomia nappuloita			  *
;*	              4 muodostavat turvavyˆhykkeen, yksinkertaistaa	  *
;*			siirtojentutkimisfunktioita.			  *
;*									  *
;*	  Joitakin pelin aikana k‰ytettyj‰ yhden tavun muuttujia:	  *
;*									  *
;*		ending		pelin p‰‰tt‰minen			  *
;*		done		siirto on tehty				  *
;*		undo		peruutuspyyntˆ				  *
;*		hint		on pyydetty siirtovinkki‰		  *
;*		game_over	peli on p‰‰ttynyt			  *
;*		meny		ollaan menu valikossa			  *
;*		nappula		siirtovuorossa oleva nappula		  *
;*									  *
;*	  T‰rkeimpi‰ aliohjelmia:					  *
;*									  *
;*									  *
;*	  calc_board 	laskee laudasta (board4) tilannenumeron.	  *
;*			Kirjoittaa sen talteen muuttujaan sit_num.	  *
;*			Tilannenumero on luku v‰lill‰ 0-65535, joka 	  *
;*			kertoo yksik‰sitteisesti laudalla olevan	  *
;*			tilanteen, poistaen kuitenkin symmetriset	  *
;*			tapaukset (tuottavat saman arvon).		  *
;*									  *
;*	  make_move	Tekee muuttujan nappula osoittaman pelaajan	  *
;*			siirron. Lasketaan ensin kaikki mahdolliset       *
;*			siirrot (calc_moves) ja sitten valitaan           *
;*			niist‰ yksi kappale vaikeusasteen mukaisesti.     *
;*			Helpoimmilla vaikeusasteilla on mukana enemm‰n    *
;*			satunnaisuutta, eik‰ tilanteiden arvotus vastaa   *
;*			vaikeinta tasoa.                                  *    
;*									  *
;*	  rand		Arpoo satunnaisluvun rekisteriss‰ d1 annetaan	  *
;*			kutsu hetkell‰ haluttu vaihteluv‰li.		  *
;*									  *
;*	  new_train	Generoi uuden harjoitusteht‰v‰n, valitsee	  *
;*			valmiista taulukosta yhden ja sitten viel‰	  *
;*			pyˆrittelee ja peilaa sit‰ satunnaisesti.	  *
;*									  *
;**************************************************************************



; *** K‰‰nt‰j‰n optioita†***
 
;		opt     c-,l-,o1+,o2+,ow-


; *** Tarvittavat Includet ja mist‰ ne lˆytyy (tod.n‰k joudut	      ***
; *** muuttamaan hakemiston).                                         ***


;		incdir	"dh0:include/"

		incdir	"dh0:inc/"
		include	dos/dosextens.i
		include	exec/execbase.i
		include	graphics/gfxbase.i
		include	exec/exec_lib.i
		include	graphics/graphics_lib.i


AllocMem	equ	-198
FreeMem		equ	-210
Forbid		equ	-132
Permit		equ	-138
game

; *** T‰m‰ on ns. wbstartup, joka mahdollistaa ohjelman k‰ynnist‰misen ***
; *** ikonista. Hyvin pitk‰lle kuin devpacista lˆytyv‰ iconstartup.i   ***

		section	startup,code

		movem.l	d0/a0,-(sp)
		clr.l	WBenchMsg
		sub.l	a1,a1
		move.l	$4.w,a6
		jsr	_LVOFindTask(a6)	;selvitet‰‰n taskin numero
		move.l	d0,a4
		tst.l	pr_CLI(a4)		;k‰ynnistettiinkˆ WB:st‰
		beq.s	_WB		
		movem.l	(sp)+,d0/a0
		bra.s	_run			
_WB		lea	pr_MsgPort(a4),a0
		move.l	$4.w,a6
		jsr	_LVOWaitPort(a6)
		lea	pr_MsgPort(a4),a0
		move.l	$4.w,a6
		jsr	_LVOGetMsg(a6)
		move.l	d0,WBenchMsg
		movem.l	(sp)+,d0/a0
_run		jsr	Main			;k‰ynnistet‰‰n itse peli
		move.l	d0,-(sp)
		tst.l	WBenchMsg
		beq.s	_Exit
		move.l	$4.w,a6
		jsr	 _LVOForbid(a6)
		move.l	WBenchMsg,a1
		move.l	$4.w,a6
		jsr 	_LVOReplyMsg(a6)	;vastataan viestiin
_Exit		move.l	(sp)+,d0
		rts

; *** T‰st‰ alkaa varsinainen ohjelma (johon hyp‰t‰‰n wbstartupista)    ***


		section	main,code

Main

	movem.l	d0-d7/a0-a6,-(sp)

	move.l	$4.w,a6
	lea	gfx_name,a1
	jsr	_LVOOldOpenLibrary(a6)		;avataan graphics kirjasto
	tst.l	d0
	beq.w	error
	move.l	d0,gfx_base
	move.l	d0,a6
	move.l	gb_LOFlist(a6),loflist		;otetaan talteen, jotta
	move.l	gb_copinit(a6),copinit		;n‰yttˆ voitaisiin palauttaa
	move.l	gb_ActiView(a6),view		;ohjelman j‰lkeen ennalleen.

	sub.l	a1,a1
	jsr	_LVOLoadView(a6)		;LoadView (null)
	jsr	_LVOWaitTOF(a6)
	jsr	_LVOWaitTOF(a6)

	move.l	$04.w,a6
	jsr	Forbid(a6)		;Nyt pelataan, eik‰ meinata!

	lea	$dff000,a0
	move.l	#copperlist,$80(a0)	;alustetaan copperlista
	move.w	#0,$88(a0)

	move.l	$04.w,a6
	moveq	#0,d0
	bsr	vbrcode			;pakotetaan VBR lˆytym‰‰n nollasta
	move.l	d0,oldvbr

	bsr	reserve_memory		;k‰yd‰ varaamassa muistia
	tst.l	d0
	bne.w	error2			;poistutaan jos ei lˆytynyt	

	move.l	plane_add,a0		;tyhjennet‰‰n varattu grafiikka
	move	#13000,d7		;alue
.pcl1
	move.l	#0,(a0)+
	dbf	d7,.pcl1
	
	move.l	plane_add,a0		;kopioidaan lauta n‰ytˆlle
	lea	plane1c,a1
	move	#10240+15,d7
.pcl
	move.l	(a1)+,(a0)+
	dbf	d7,.pcl
		
	move.b	#0,ending
	move.b	#1,meny
	move.b	#0,mbr
	move.b	#2,nappula

	bsr	init			;alustetaan mm. pelilauta

	move.l	plane_add,a0		;kopiodaan v‰ripaletti
					;copperlistaan
	move.w	(a0)+,color0
	move.w	(a0)+,color1
	move.w	(a0)+,color2
	move.w	(a0)+,color3
	move.w	(a0)+,color4
	move.w	(a0)+,color5
	move.w	(a0)+,color6
	move.w	(a0)+,color7
	move.w	(a0)+,color8
	move.w	(a0)+,color9
	move.w	(a0)+,color10
	move.w	(a0)+,color11
	move.w	(a0)+,color12
	move.w	(a0)+,color13
	move.w	(a0)+,color13
	move.w	(a0)+,color14
	move.w	(a0)+,color15
					;ja v‰h‰n s‰‰det‰‰n 
	move.w	#$0a00,color7
	move.w	#$000a,color13
	move.w	#$0aaa,color3
	move.w	#$0888,color4
	move.w	#$0555,color5
	move.w	#$0009,color6

	move.w	#$0ee0,color14
	move.w	#$0fd0,color15
	move.w	#$0222,color1
	move.w	colorb1,color25	
	move.w	colorb1,color29	
	move.w	color8,color16
	move.w	color8,color24	


; *** Asetaan bitplane pointerit ***

	move.l	plane_add,d1	
	add.l	#64,d1
	move.l	d1,d0
	
	move.l	d1,d0

	move.w	d0,bp1l
	swap	d0
	move.w	d0,bp1h

	move.l	d1,d0
	add.l	#1*10240,d0
	move.w	d0,bp2l
	swap	d0
	move.w	d0,bp2h

	move.l	d1,d0
	add.l	#2*10240,d0
	move.w	d0,bp3l
	swap	d0
	move.w	d0,bp3h

	move.l	d1,d0
	add.l	#3*10240,d0
	move.w	d0,bp4l
	swap	d0
	move.w	d0,bp4h

	move.l	d1,d0
	add.l	#4*10240,d0
	move.w	d0,bp5l
	swap	d0
	move.w	d0,bp5h

	lea	$dff000,a0
	move.w	#$8380,$96(a0)
	move.w	#$5200,bpl_con			;ruutu n‰kyv‰ksi

	lea	$bfd000,a2
	move.b	#$81,$100(a2)			;levari hiljaiseksi
	st	$100(a2)

	move	#$200c,$9a(a0)
	lea	int,a0
	move.l	$6c,o6c				;uuden vertical blankin
	move.l	a0,$6c				;osoite


; *** T‰ss‰ loopissa ohjelma pyˆrii suurimman osan ajastaan, silloin   ***
; *** kun ei olla vertical blank rutiinissa.                           ***

test:
	add.l	#1,ra2				;lis‰t‰‰n siemenlukua
	
	cmp.b	#1,mbr				;pit‰iskˆ laskea siirtoja?
	beq.w	bor
tast
	cmp.b	#1,ending			;vai onko lopun aika?
	bne.s	test				;jos ei niin odotellaan

qu

; *** Vapautetaan varatut muistialueet ***

	move.l	$4.w,a6
	move.l	plane_add,a1			
	move.l	#53200,d0
	jsr	FreeMem(a6)

	move.l	$4.w,a6
	move.l	taulukko_add,a1		
	move.l	#66000+8000+4000,d0
	jsr	FreeMem(a6)

	move.l	o6c,$6c			;palautetaan keskeytys osoite
	move.l	$4.w,a6
	move.l	oldvbr,d0			
	bsr	vbrcode			;palautetaan VBR oikeaan arvoonsa

	move	#$a00c,$dff09a

error2

; *** Palautetaan n‰yttˆ alkuper‰isen kaltaiseksi ***


	move.l	gfx_base,a6
	move.l	view,a1
	jsr	_LVOLoadView(a6)
	lea	$dff000,a0
	move.l	gfx_base,a6
	move.l	loflist,$084(a0)
	move.l	copinit,$080(a0)
	move.w	#0,$088(a0)

	move.l	a6,a1
	move.l	$04.w,a6
	jsr	_LVOCloseLibrary(a6)	;suljetaan graphics kirjasto

	move.l	$04.w,a6
	jsr	Permit(a6)		;sallitaan taas muukin k‰yttˆ

error
	moveq	#0,d0
	movem.l	(sp)+,d0-d7/a0-a6

	rts				;takaisin wbstaruppiin


; *** bor hoitaa siirtojen laskemisen ***

bor
	tst.b	game_over
	bne.w	.back
	tst.b	hint			;pyydettiinkˆ vinkki‰?
	bne.w	.hi

	bsr	find_pos
	bsr	conv_bxy2pos
	
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old

	bsr	make_cursor

	move.l	#0,clock
	bsr	make_move
.wat1
	cmp.l	#20,clock		;odotellaan hetken aikaa
	bcs.s	.wat1

	bsr	find_pos

; *** muuntaa lautaan viittaavan osoitteen koordinaateiksi (piece_xp/yp) ***

	move.l	#board+7,d0
	move.l	bxy,d1
	sub.l	d0,d1
	divu	#6,d1
	move.l	d1,d0
	and.l	#$ffff,d1
	swap	d0
	and.l	#$ffff,d0
	lsl.l	#4,d1
	add.l	#120,d1
	lsl.l	#3,d0
	add.l	#128,d0
	move.l	d0,grid_x
	move.l	d1,grid_y
	
	move.l	#0,clock
.wat1b	
	cmp.l	#3,clock
	bcs.s	.wat1b	
.wat1c
	cmp.w	#1,moving
	beq.s	.wat1c

	move.l	#0,clock
.wat1d	
	cmp.l	#10,clock
	bcs.s	.wat1d	
	move.b	suunta_old,suunta
	move.l	#0,clock
.wat1o	
	cmp.l	#30,clock
	bcs.s	.wat1o	

	bsr	make_board
	
	move.l	#0,clock
.wat1m	
	cmp.l	#20,clock
	bcs.s	.wat1m	
.back
	move.b	#0,mbr
	move.b	#1,done	
	bra.w	test
.hi
	
	bsr	make_move

	lea	board,a1
	lea	board_w,a0
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	
	moveq	#0,d1
	lea	board+7,a0
	lea	board_r+7,a1
	move	#35-7,d7
.pyp
	cmp.b	#3,(a0)
	bne.s	.ns
	cmp.b	#3,(a1)
	beq.s	.ns
	
	divu	#6,d1
	move.l	d1,d0
	and.l	#$ffff,d1
	swap	d0
	and.l	#$ffff,d0
	lsl.l	#4,d1
	add.l	#120,d1
	lsl.l	#3,d0
	add.l	#128,d0
	move.l	d0,piece_xp
	move.l	d1,piece_yp
;	move.b	suunta,suunta_old
	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old
	move.b	#2,shint
	bra.s	.fp
	
.ns
	addq.l	#1,d1
	addq.l	#1,a0
	addq.l	#1,a1

	dbf	d7,.pyp

	move.b	#1,shint
	
.fp
	bsr	make_board

	move.b	#3,nelio
	move.l	#0,clock
	move.l	#0,color_cycle_delay
	move.l	#0,color_cycle_pointer
	
.wat
	cmp.l	#50,clock
	bcs.s	.wat
	lea	board,a0
	lea	board_r,a1
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	sub.b	#1,nappula
	eor.b	#1,nappula
	add.b	#1,nappula
	
	move.b	#0,shint
	move.b	#0,hint
	move.b	#1,done
	move.b	#1,undo
	move.b	#0,mbr
	move.b	#0,nelio
	bra.w	test

;--------------------------------------------------------------------
; clear_screen tyhjent‰‰ plane5:n (=menu)
;--------------------------------------------------------------------

clear_screen
	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	move.w	#2559,d7
.tl
	move.l	#0,(a0)+
	dbf	d7,.tl	
	rts
	
;--------------------------------------------------------------------
; P‰ivitt‰‰ menun (vaikeusasteen, pelaajien lkm ja peli/harjoitus)
;--------------------------------------------------------------------

update_menu
	lea	menu_text+191,a0
	move.b	players,d0
	add.b	#'0',d0
	move.b	d0,(a0)
	
	lea	menu_text+148,a1

	cmp.l	#0,level
	beq.s	.0
	cmp.l	#1,level
	beq.s	.1
	cmp.l	#2,level
	beq.s	.2
	cmp.l	#3,level
	beq.s	.3
	cmp.l	#4,level
	beq.s	.4

	lea	level_5_text,a0
	bra.s	.x
.0	
	lea	level_0_text,a0
	bra.s	.x
.1	
	lea	level_1_text,a0
	bra.s	.x
.2	
	lea	level_2_text,a0
	bra.s	.x
.3	
	lea	level_3_text,a0
	bra.s	.x
.4	
	lea	level_4_text,a0
	bra.w	.x
.x
	moveq	#8,d7
.lo	
	move.b	(a0)+,(a1)+
	dbf	d7,.lo	

	lea	menu_text+79,a1

	lea	text_peli,a0
	tst.b	train
	beq.s	.notr
	lea	text_harj,a0
.notr
	moveq	#8,d7
.lw	
	move.b	(a0)+,(a1)+
	dbf	d7,.lw	
	
	rts	

;--------------------------------------------------------------------
; Tulosta menun (menu_text) bitplanelle 5 
;--------------------------------------------------------------------

write_screen

	bsr	update_menu

	lea	menu_text,a0
	move.l	plane_add,a6
	add.l	#4*10240+64,a6	
	move.l	a6,a4

	lea	fonts,a3		;valitaan fontit
	moveq	#32,d4
	move.l	#40*8,d7

	moveq	#30,d6
.loop2
	moveq	#39,d5
	move.l	a4,a1
.loop
	moveq	#0,d1
	move.b	(a0)+,d1
	cmp.b	#$a,d1			;oliko enter?
	beq.s	.ret
	sub.b	d4,d1
	asl.w	#3,d1
	move.l	a3,a2
	add.l	d1,a2			

	move.b	(a2)+,(a1)+

	move.b	(a2)+,39(a1)
	move.b	(a2)+,79(a1)
	move.b	(a2)+,119(a1)
	move.b	(a2)+,159(a1)
	move.b	(a2)+,199(a1)
	move.b	(a2)+,239(a1)
	move.b	(a2)+,279(a1)

	dbf	d5,.loop
.ret
	add.l	d7,a4

	dbf	d6,.loop2

	rts

;--------------------------------------------------------------------
; Varaa muistit (taulukoille ja n‰yttˆ‰ varten)
;--------------------------------------------------------------------

reserve_memory

	move.l	$4.w,a6
	move.l	#53200,d0
	move.l	#$10002,d1
	jsr	AllocMem(a6)			;varataan graffaa varten
	tst.l	d0
	beq	.err
	move.l	d0,plane_add

	move.l	#66000+8000+4000,d0
	moveq	#0,d1
	jsr	AllocMem(a6)
	tst.l	d0				;saatiinko tilaa 
	beq	.err2				;taulukoita varten?
	move.l	d0,taulukko_add
	
	moveq	#0,d0
	rts
.err
	moveq	#-1,d0				;palautetaan virhekoodi
	rts
.err2
		
	move.l	$4.w,a6
	move.l	plane_add,a1
	move.l	#53200,d0
	jsr	FreeMem(a6)			;vapautetaan graffa
	moveq	#-1,d0
	rts

;--------------------------------------------------------------------
; Nollaa VBR:n
;--------------------------------------------------------------------

		;thanx spiv
vbrcode:	movem.l	d2/a5/a6,-(sp)
		move.l	d0,d2
		move	AttnFlags(a6),d0	; Execbase->AttnFlags
		lsr	#1,d0
		bcc.s	.exitvbr
		lea	.vbrcode(pc),a5
		jsr	_LVOSupervisor(a6)
.exitvbr:	move.l	d2,d0
		movem.l	(sp)+,d2/a5/a6
		rts

.vbrcode:	dc.l	$4e7a1801		* movec	VBR,d1
		moveq	#-1,d0
		cmp.l	d0,d2
		beq.s	.justread
		dc.l	$4e7b2801		* movec	d2,VBR
.justread:	move.l	d1,d2
		rte

;-----------------------------------------------------------------------
; Print (tulostaa tekstin ruudulle haluttuun kohtaan valitulla v‰rill‰)
;
; a0=tekstin alkuosoite
; a6=plane1
; d2=v‰ri	(0-15)
;------------------------------------------------------------------------

print
	move.l	a6,a4

	lea	fonts,a3
	moveq	#32,d4
	move.l	#40*8,d7

	moveq	#25,d6
.loop2
	moveq	#39,d5
	move.l	a4,a1
.loop
	moveq	#0,d1
	move.b	(a0)+,d1
	tst.b	d1
	beq.w	.xt
	sub.b	d4,d1
	asl.w	#3,d1
	move.l	a3,a2
	add.l	d1,a2			

	btst	#0,d2
	beq.s	.b0

	move.b	(a2)+,0*10240(a1)
	move.b	(a2)+,0*10240+40(a1)
	move.b	(a2)+,0*10240+80(a1)
	move.b	(a2)+,0*10240+120(a1)
	move.b	(a2)+,0*10240+160(a1)
	move.b	(a2)+,0*10240+200(a1)
	move.b	(a2)+,0*10240+240(a1)
	move.b	(a2)+,0*10240+280(a1)
	subq.l	#8,a2
.b0
	btst	#1,d2
	beq.s	.b1
	
	move.b	(a2)+,1*10240(a1)
	move.b	(a2)+,1*10240+40(a1)
	move.b	(a2)+,1*10240+80(a1)
	move.b	(a2)+,1*10240+120(a1)
	move.b	(a2)+,1*10240+160(a1)
	move.b	(a2)+,1*10240+200(a1)
	move.b	(a2)+,1*10240+240(a1)
	move.b	(a2)+,1*10240+280(a1)
	subq.l	#8,a2
	
.b1
	btst	#2,d2
	beq.s	.b2
	move.b	(a2)+,2*10240(a1)
	move.b	(a2)+,2*10240+40(a1)
	move.b	(a2)+,2*10240+80(a1)
	move.b	(a2)+,2*10240+120(a1)
	move.b	(a2)+,2*10240+160(a1)
	move.b	(a2)+,2*10240+200(a1)
	move.b	(a2)+,2*10240+240(a1)
	move.b	(a2)+,2*10240+280(a1)
	subq.l	#8,a2
	
.b2
	btst	#3,d2
	beq.s	.bx
	move.b	(a2)+,3*10240(a1)
	move.b	(a2)+,3*10240+40(a1)
	move.b	(a2)+,3*10240+80(a1)
	move.b	(a2)+,3*10240+120(a1)
	move.b	(a2)+,3*10240+160(a1)
	move.b	(a2)+,3*10240+200(a1)
	move.b	(a2)+,3*10240+240(a1)
	move.b	(a2)+,3*10240+280(a1)
	subq.l	#8,a2
.bx
	addq.l	#8,a2
	addq.l	#1,a1	
	dbf	d5,.loop
.ret
	add.l	d7,a4

	dbf	d6,.loop2
.xt
	rts

;--------------------------------------------------------------------
; Nollaa pisteet ja arpoo uuden aloittajan
;--------------------------------------------------------------------

clear_scores
	move.b	#0,score1
	move.b	#0,score2
	moveq	#2,d1
	jsr	rand				;k‰y arpomassa
	move.b	d3,peleja
	bsr	update_scores			;p‰ivitet‰‰n tulokset
	rts

;--------------------------------------------------------------------
; Muuttaa pelaajien lukum‰‰r‰‰
;--------------------------------------------------------------------

change_plkm

	tst.b	train				;oliko harjoitus?
	bne.s	.ov

	add.b	#1,players
	cmp.b	#3,players
	bne.s	.ok
	move.b	#0,players
.ok
	move.b	players,menud_players		;talleta uusi oletusarvo
.ov
	move.l	#0,history_counter		;nollaa undo puskuri
	bsr	update_scores
	bsr	write_screen
	rts

;--------------------------------------------------------------------
; Uuden pelin aloitus (F1)
;--------------------------------------------------------------------

new_game

	move.b	players,menud_players
	move.b	train,menud_train
	move.l	#0,history_counter
	tst.b	train				;harjoittelu?
	bne.s	.training

; *** Alustaa laudan alkutilanteen mukaiseksi ***

	lea	init_board,a0
	lea	board,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

; *** Selvitt‰‰ kumman vuoro on siirt‰‰ ensimm‰iseksi ***

	add.b	#1,peleja
	move.b	peleja,d0
	and.b	#1,d0
	add.b	#1,d0
	move.b	d0,nappula
.nb
; *** Kopioi viel‰ laudan talteen ***

	lea	board,a0
	lea	board_r,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	bsr	make_board			;k‰y piirt‰m‰ss‰ laudan
	rts

.training
	bsr	new_train
	move.b	#2,nappula			;pelaaja aloittaa aina
	bra.s	.nb				;harjoittelun

	
;--------------------------------------------------------------------
; Uuden harjoitusteht‰v‰n aloitus
;--------------------------------------------------------------------
	
new_train

; *** Arpoo jonkun motitusteht‰vien perustyypeist‰.  	  *** 
; *** N‰ist‰ 768 perustyypist‰ saadaan pyˆrittelem‰ll‰    ***
; *** kaikki 6144(768*8) erilaista teht‰v‰‰.              ***

	lea	mot,a0			 
	move.l	#768,d1
	bsr	rand
	lsl.l	#4,d3
	add.l	d3,a0

; *** Generoi sen pelin ymm‰rt‰m‰‰n muotoon ***

	lea	board,a1
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+
	move.b	#4,(a1)+

; *** Perustyyppi pyˆr‰ytet‰‰n satunnaiseen asentoon    ***
; *** Ensin arvotaan kuinka monta kierrosta pyˆritet‰‰n ***

	moveq	#4,d1
	bsr	rand

	lea	board,a0
	bra.s	.le
.ls
	bsr	rotate
.le
	dbf	d3,.ls	

; *** Arvotaan viel‰ peilataanko tilanne ***

	moveq	#2,d1
	bsr	rand
	tst.b	d3
	beq.s	.nomir

	lea	board,a0
	bsr	mirror	
.nomir
	rts

;--------------------------------------------------------------------
; Vaikeustason vaihtaminen
;--------------------------------------------------------------------

change_level
	move.b	#0,train
	add.l	#1,level
	cmp.l	#6,level
	bne.s	.ok
	move.l	#0,level
.ok
	cmp.l	#5,level
	bne.s	.notr
	move.b	#1,train			;kuudes vaikeustaso on
	move.b	#1,players			;harjoittelu
	bra.s	.tr
	
.notr
	move.b	menud_players,players
.tr
	bsr	update_scores
	bsr	update_menu
	bsr	write_screen
	rts	

;--------------------------------------------------------------------
; Pisteiden sek‰ nimien p‰ivitt‰minen
;--------------------------------------------------------------------

update_scores

	move.b	score1,d0
	and.b	#%1111,d0
	add.b	#'0',d0
	lea	text_score1,a0
	move.b	d0,1(a0)
	move.b	score1,d0
	rol.b	#4,d0
	and.b	#%1111,d0
	tst.b	d0
	bne.s	.z1
	move.b	#' '-'0',d0
.z1
	add.b	#'0',d0
	move.b	d0,(a0)

	move.b	score2,d0
	and.b	#%1111,d0
	add.b	#'0',d0
	lea	text_score2,a0
	move.b	d0,1(a0)
	move.b	score2,d0
	rol.b	#4,d0
	and.b	#%1111,d0
	tst.b	d0
	bne.s	.z2
	move.b	#' '-'0',d0
.z2
	add.b	#'0',d0
	move.b	d0,(a0)

	tst.b	train
	bne.s	.training

; *** Pelaajien nimien asettaminen tilannetta vastaavaksi ***

	cmp.b	#0,players
	beq.s	.demo
	cmp.b	#2,players
	beq.s	.duel
	
	lea	text_human,a0
	lea	text_pelaaja1,a1
	lea	text_amiga,a2
	lea	text_pelaaja2,a3
	bra.s	.px
.training
	lea	text_human,a0			;harjoittelu
	lea	text_pelaaja1,a1
	lea	text_vastustaja,a2
	lea	text_pelaaja2,a3
	bra.s	.px	

.demo
	lea	text_amiga1,a0			;demo
	lea	text_pelaaja1,a1
	lea	text_amiga2,a2
	lea	text_pelaaja2,a3
	bra.s	.px
.duel
	lea	text_human1,a0			;ihminen - ihminen
	lea	text_pelaaja1,a1
	lea	text_human2,a2
	lea	text_pelaaja2,a3

.px
	move	#10,d7
.l3
	move.b	(a0)+,(a1)+
	move.b	(a2)+,(a3)+
	dbf	d7,.l3

; *** Tulostaa pisteet ja pelaajien nimet ruudulle ***

	lea	text_pelaaja1,a0
	move.l	plane_add,a6
	add.l	#64+4+4*8*40,a6
	moveq	#14,d2
	bsr	print
	
	lea	text_score1,a0
	move.l	plane_add,a6
	add.l	#64+7+6*8*40,a6
	moveq	#14,d2
	bsr	print

	lea	text_pelaaja2,a0
	move.l	plane_add,a6
	add.l	#64+28+4*8*40,a6
	moveq	#15,d2
	bsr	print

	lea	text_score2,a0
	move.l	plane_add,a6
	add.l	#64+31+6*8*40,a6
	moveq	#15,d2
	bsr	print
	
	rts
	
;--------------------------------------------------------------------
; Vertical Blank rutiini, jossa varsinainen peli tapahtuu
;--------------------------------------------------------------------

int:
	movem.l	d0-d7/a0-a6,-(sp)

	add.l	#1,clock			;lis‰t‰‰n aikalaskuria

	cmp.b	#1,mbr
	beq.w	wmbr

	cmp.b	#1,game_over
	beq.w	go				;p‰‰ttyikˆ peli?

	tst.b	meny
	bne.w	menu

	bsr	round_handler

	bsr	do_cycle
	bsr	calc_bxy

	bsr	control_hand

	cmp.w	#1,moving
	beq.w	.mov

	tst.b	human
	bne.w	.hm

	bsr	do_nix
	move.b	#1,mbr
	bra.s	mc
.hm	
	bsr	do_move1
.mov
	bsr	do_move2

	bsr	do_mask

	bsr	check_button

	bsr	make_cursor

	bsr	check_rotate

	bsr	check_undo
		
mc
	move.b	$dff00a,old_y			;hiiren laskurit talteen
	move.b	$dff00b,old_x

	move.w	#$20,$dff09c			;VB suoritettu
	movem.l	(sp)+,d0-d7/a0-a6

	rte

;----------------------------------------------------------------------
; Wmbr on rutiini, johon hyp‰t‰‰n VB:st‰ niin kauan kun odottellaan 
; siirtojen laskemista ja kunnes on saanut tehty‰ siirtonsa.
;----------------------------------------------------------------------

wmbr
	bsr	do_cycle
	tst.b	hint
	bne.s	.nm
	bsr	do_move2
.nm
	bsr	do_mask
	bsr	make_cursor
	bsr	control_hand	
	bra.s	mc

;----------------------------------------------------------------------
; Wmbr on rutiini, johon hyp‰t‰‰n VB:st‰ kun peli on p‰‰ttynyt
;----------------------------------------------------------------------

go
	move.b	#0,nelio
	bsr	do_cycle	
	bsr	do_mask
	bsr	calc_bxy

	bsr	do_mask

	bsr	make_cursor

	bsr	control_hand
	cmp.w	#2,control2			;painettiinko nappia?
	beq.s	.ov
	cmp.w	#4,control2
	beq.s	.ov
	tst.b	undo				;peruttiinko siirto?
	bne.w	.und
	bra.s	mc
.ov

; *** Aika siirty‰ seuraavaan peliin/harjoitukseen ***


	tst.b	train				;harjoittelu?
	bne.s	.tra

; *** Lauta alkutilanteeseen

	lea	init_board,a0
	lea	board,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
.ovc
	move.l	#0,history_counter		;nollataan undo puskuri

	cmp.b	#1,nappula			;kumpi voitti pelin?
	beq.s	.n2


; *** Lis‰t‰‰n pelaajan 2:n pisteit‰ ***

	moveq	#1,d1
	move.b	score2,d0
	abcd.b	d1,d0
	move.b	d0,score2
	bra.s	.nx

.tra
	bsr	new_train			;uusi harjoitus
	bra.s	.ovc
	
.n2

; *** Lis‰t‰‰n pelaajan 1:n pisteit‰ ***

	moveq	#1,d1
	move.b	score1,d0
	abcd.b	d1,d0
	move.b	d0,score1
.nx

; *** Selvitet‰‰n seuraavan pelin aloittaja ***
; *** (harjoittelussa se on aina ihminen)   ***

	add.b	#1,peleja
	move.b	peleja,d0
	and.b	#1,d0
	add.b	#1,d0
	move.b	d0,nappula
	tst.b	train
	beq.s	.und
	move.b	#0,peleja
	move.b	#2,nappula
.und
	tst.b	human
	bne.s	.nu
	add.l	#36,history_counter
	bsr	check_undo
.nu
	move.b	#0,done
	move.b	#0,game_over
	move.b	#0,meny

; *** Tyhjennet‰‰n tekstit laudan alapuolelta  ***

	lea	text_blank_line,a0
	move.l	plane_add,a6
	add.l	#64+9+20*8*40,a6
	moveq	#7,d2
	bsr	print
	lea	text_blank_line,a0
	move.l	plane_add,a6
	add.l	#64+9+21*8*40,a6
	moveq	#7,d2
	bsr	print

	bsr	find_pos
	bsr	conv_bxy2pos
	
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old

	bsr	make_cursor
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x
	bsr	filter_board
	bsr	make_board
	bsr	copy_bto

	bsr	update_scores
	bra.w	mc

;----------------------------------------------------------------------
; T‰ss‰ rutiinissa pyˆrit‰‰n, kun ruudulla on menu
;----------------------------------------------------------------------

menu

; *** Tutkitaan, mik‰ vaihe on menossa ***
; *** (tekstin h‰ivytys jne.)          ***

	cmp.b	#2,meny
	beq.w	.1
	cmp.b	#3,meny
	beq.w	.1
	cmp.b	#4,meny
	beq.w	.1	
	cmp.b	#5,meny
	beq.w	.xmenu

	lea	board,a0

; *** Kopioidaan lauta talteen ***

	lea	board_w,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

; *** Kopioidaan tallesta lauta piirrett‰v‰ksi ***

	lea	board_r,a0
	lea	board,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

	bsr	make_board			;tehd‰‰n lauta ruudulle
	
	move.l	#0,color_cycle_pointer		;nollataan v‰rin kierr‰tys
	move.l	#2,color_cycle_delay	
	move.b	#2,meny
	move.b	players,menud_players		;talletaan uudet
	move.b	train,menud_train		;oletusarvot

	bsr	do_cycle

; *** Kadottaa ik‰v‰n v‰l‰yksen ***

 	lea	color_cycle_colours_b,a0
	cmp.b	#2,nappula
	beq.s	.bp
	lea	color_cycle_colours_r,a0
.bp
	add.l	color_cycle_pointer,a0
	move.w	(a0),color25
	move.w	(a0),color29
	
	bsr	clear_screen
	bsr	write_screen
	move.b	#1,nelio
	move.l	#0,color_cycle_pointer
	move.l	#2,color_cycle_delay	
.1
	cmp.b	#$51,key			;F2?
	bne.s	.ncs
	bsr	clear_scores
.ncs
	cmp.b	#$53,key			;F4?
	bne.s	.ncp
	bsr	change_plkm	
.ncp	
	cmp.b	#$59,key			;F10?
	bne.s	.nex
	move.b	#1,ending
.nex
	cmp.b	#$52,key			;F3?
	bne.s	.ncl
	bsr	change_level
.ncl
	cmp.b	#$50,key			;F1?
	bne.s	.nng
	bsr	new_game
.nng

	bsr	make_cursor
	bsr	do_cycle
	bsr	control_hand

	bra.w	mc		

; *** Menusta poistuminen ***
		
.xmenu

; *** Tutkitaan tarvitaanko tehd‰ uusi harjoitus ***

	tst.b	train
	beq.s	.rok
	move.b	menud_train,d0
	cmp.b	train,d0
	beq.s	.rok
	
	bsr	new_game
.rok

	move.b	#0,nelio
	move.b	#0,meny
	bsr	clear_screen
	move.l	plane_add,a0
	add.l	#4*10240+64,a0		
	move	#2559,d7
.cl
	move.l	#0,(a0)+
	dbf	d7,.cl	

	lea	board,a1
	lea	board_r,a0
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

	bsr	update_scores
	move.b	#0,nelio
	move.l	#0,color_cycle_pointer
	move.l	#2,color_cycle_delay
	bsr	do_cycle
	bsr	make_cursor

	bsr	find_pos
	bsr	conv_bxy2pos
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old
	move.b	suunta,suunta_old

	bsr	make_cursor

	bsr	update_scores

.nh
	bsr	make_board
	bsr	filter_board
	bsr	copy_bto
	bsr	make_board
.hx	

	move.b	#0,done

	bra.w	mc


;----------------------------------------------------------------------
; T‰m‰ rutiini visualisoi taulukossa board oleven laudan n‰ytˆlle
;----------------------------------------------------------------------

make_board

	move.l	plane_add,a0
	lea	board+7,a4
	moveq	#3,d5
	moveq	#0,d4
.ggl
	move	#3,d6

.gl

; *** Selvitet‰‰n mik‰ nappula on kyseess‰ ***

	tst.b	(a4)
	beq.w	.emp
	cmp.b	#1,(a4)
	beq.w	.pala1
	cmp.b	#2,(a4)
	beq.w	.pala2
	lea	ball,a2
	lea	maskb,a1
	bra.w	.nx
.pala2

; *** Sininen nappula ***

	lea	pala2,a2
	cmp.b	#2,-1(a4)
	beq.s	.2o
	cmp.b	#2,6(a4)
	beq.s	.2a
	lea	mask1,a1
	bra.s	.nx
.2a
	lea	mask1a,a1
	bra.s	.nx
.2o
	cmp.b	#2,6(a4)
	beq.s	.2av
	lea	mask1v,a1
	bra.s	.nx
.2av
	lea	mask1av,a1
	bra.w	.nx

; *** Punainen nappula ***

.pala1
	lea	pala1,a2
	cmp.b	#1,-1(a4)
	beq.s	.1o
	cmp.b	#1,6(a4)
	beq.s	.1a
	lea	mask1,a1
	bra.s	.nx
.1a
	lea	mask1a,a1
	bra.s	.nx
.1o
	cmp.b	#1,6(a4)
	beq.s	.1av
	lea	mask1v,a1
	bra.s	.nx
.1av
	lea	mask1av,a1
	bra.w	.nx

.emp
	lea	mask1e,a1
	lea	empty,a2
	
.nx

; *** Tyhj‰ ruutu ***

	move.l	plane_add,a0
	add.l	#64+77*40+16,a0
	lea	plane1c+64+77*40+16,a3
	add.l	d4,a0	
	add.l	d4,a3
                    
	moveq	#15,d7
.mal	
	move.w	(a1)+,d3
	moveq	#0,d2

	move.w	d3,d0
	move.w	d0,d2
	not.w	d2
		
;		           	        _
; *** Tekee ns. cookie-cut funktion (AB+AC) ***
; *** nappulan, graffan ja maskin kanssa    ***


	move.w	30720(a3),30720(a0)
	move.w	(a2)+,d1
	and.w	d0,d1
	and.w	d2,30720(a0)
	or.w	d1,30720(a0)

	move.w	20480(a3),20480(a0)
	move.w	(a2)+,d1
	and.w	d0,d1
	and.w	d2,20480(a0)	
	or.w	d1,20480(a0)

	move.w	10240(a3),10240(a0)
	move.w	(a2)+,d1
	and.w	d0,d1
	and.w	d2,10240(a0)	
	or.w	d1,10240(a0)
		
	move.w	(a3),(a0)
	move.w	(a2)+,d1
	and.w	d0,d1
	and.w	d2,(a0)	
	or.w	d1,(a0)

	add.l	#40,a0
	add.l	#40,a3
	dbf	d7,.mal	

.nh
	addq.l	#1,a4
	addq.l	#2,d4
	dbf	d6,.gl
	add.l	#32+15*40,d4		
	addq.l	#2,a4
	dbf	d5,.ggl	
	rts

;----------------------------------------------------------------------
; Kierr‰tys on muotia. Nyt kyseess‰ on v‰rien pyˆritt‰minen.
; T‰m‰ rutiini on vastuussa paletin manipuloinnista pelin aikana.
;---------------------------------------------------------------------
	
do_cycle

;cycling

	tst.b	meny
	bne.w	.menuc
	cmp.b	#3,nelio
	beq.w	.pallo
.bc
	add.l	#1,color_cycle_delay
	cmp.l	#3,color_cycle_delay
	bcs.w	.nocycle

	move.l	#0,color_cycle_delay

	cmp.b	#1,nelio
	beq.w	.nelio

	lea	savyja,a0
	lea	color16,a1
	move	#15,d7
.lo	
	move.w	(a0)+,(a1)
	addq.l	#4,a1
	dbf	d7,.lo
	cmp.b	#3,nelio
	bne.s	.n3

	move.w	#$0444,color29
	move.w	#$0222,color30
	move.w	#$0777,color31
	bra.w	.nocycle
.n3
	lea	color_cycle_colours_b,a0
	cmp.b	#2,nappula
	beq.s	.bp
	lea	color_cycle_colours_r,a0
.bp
	add.l	color_cycle_pointer,a0
	move.w	(a0),color25
	move.w	(a0),color29
	cmp.b	#1,game_over
	beq.s	.nocycle

	add.l	#2,color_cycle_pointer
	cmp.l	#16,color_cycle_pointer
	bcs.s	.nocycle
	move.l	#0,color_cycle_pointer
	bra.s	.nocycle
.nelio
	move.w	#$0009,color6
	move.w	#$0a00,color7
	lea	savytys,a0
	add.l	color_cycle_pointer,a0
	move	#15,d7
	lea	color16,a1
.savl
	move.w	(a0)+,(a1)
	add.l	#4,a1
	dbf	d7,.savl

	add.l	#32,color_cycle_pointer
	cmp.l	#32*20,color_cycle_pointer
	bcs.s	.nocycle
	move.l	#0,color_cycle_pointer
.nocycle
	cmp.b	#1,nappula
	beq.s	.1
	move.w	#$000a,color14
	move.w	#$0ec0,color15
	rts
.1
	move.w	#$0cc0,color14
	move.w	#$0a00,color15
.rt
	rts
.menuc
	cmp.b	#1,meny
	beq.w	.bc
	cmp.b	#3,meny
	beq.s	.rt

;	add.l	#1,color_cycle_delay
;	cmp.l	#20,color_cycle_delay
;	bne.w	.rt

	move.l	#0,color_cycle_delay

	lea	colors_menu,a0
	add.l	color_cycle_pointer,a0
	move	#31,d7
	lea	color0,a1
.mel
	move.w	(a0)+,(a1)
	add.l	#4,a1
	dbf	d7,.mel

	cmp.b	#4,meny
	beq.s	.4

	add.l	#64,color_cycle_pointer
	cmp.l	#64*39,color_cycle_pointer
	bcs.w	.rt
	move.b	#3,meny
	rts
.4
	sub.l	#64,color_cycle_pointer
	cmp.l	#-64,color_cycle_pointer
	bne.w	.rt
	move.b	#5,meny
	rts
.pallo
	add.l	#1,color_cycle_delay
	cmp.l	#3,color_cycle_delay
	bcs.w	.px

	move.l	#0,color_cycle_delay
	add.l	#32,color_cycle_pointer
	cmp.l	#10*32,color_cycle_pointer
	bcs.w	.px
	move.l	#0,color_cycle_pointer
.px

	lea	hues,a0
	lea	color16,a1
	add.l	color_cycle_pointer,a0
	move	#15,d7
.plo	
	move.w	(a0)+,(a1)
	addq.l	#4,a1
	dbf	d7,.plo

	tst.b	shint
	beq.w	.novilk
	lea	color16,a1
	lea	color6,a2
	move.w	(a1),d0
	cmp.b	#2,nappula
	beq.s	.nr
	rol.w	#8,d0
	lea	color7,a2
.nr	
	move.w	d0,(a2)

	rts

.novilk
	move.w	#$0009,color6
	move.w	#$0a00,color7
	bra.w	.nocycle

	
;----------------------------------------------------------------------
; T‰m‰ pit‰‰ huolta siirtovuoron vaihtumisesta ja selvitt‰ onko
; siirtovuorossa kone vai ihminen
;----------------------------------------------------------------------

round_handler
	cmp.b	#1,done
	bne.w	.x

	bsr	control_hand

	cmp.b	#1,nappula
	beq.s	.1
	move.b	#1,nappula
	bra.s	.xx
.1
	move.b	#2,nappula
.xx
	move.l	#0,color_cycle_pointer
	move.l	#2,color_cycle_delay
	move.b	#0,nelio
	
; *** Jos oli ihmisen vuoro, niin tallettaa sen undo puskuriin ***

	cmp.b	#1,human
	bne.s	.eihm
	tst.b	undo
	bne.s	.eihm
	cmp.l	#36*99,history_counter
	beq.s	.eihm
	move.l	taulukko_add,a0
	add.l	#74000,a0
	add.l	history_counter,a0
	add.l	#36,history_counter
	lea	board_r,a1
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+

.eihm
	move.b	#0,undo
	bsr	check_victory				;voitto?

	bsr	find_pos
	bsr	conv_bxy2pos
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old

	bsr	make_cursor
	move.l	#0,color_cycle_pointer
	move.l	#2,color_cycle_delay
	bsr	do_cycle

	bsr	update_scores

.nh
	bsr	make_board
	bsr	filter_board
	bsr	copy_bto
	bsr	make_board
.hx
	move.b	#0,nelio
	move.l	#0,color_cycle_pointer
	move.b	#0,done	
.x
	move.b	#0,human
	cmp.b	#1,players
	beq.s	.p1
	cmp.b	#2,players
	beq.s	.p2
	bra.s	.px
.p1
	cmp.b	#2,nappula
	bne.s	.px
.p2
	move.b	#1,human
.px
	rts


;----------------------------------------------------------------------
; Selvitt‰‰ johtiko tehty siirto voittoon (tai harjoitusteht‰v‰n 
; ratkaisuun). K‰ytt‰‰ apuna taulukkoa, jossa arvotettu pelitilanteet.
;----------------------------------------------------------------------

check_victory
	
	lea	board,a0
	lea	board4,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

	cmp.b	#1,nappula
	bne.s	.1
	bsr	inv_board
.1	
	bsr	calc_board
	moveq	#0,d0
	move.w	sit_num,d0
	move.l	taulukko_add,a0
	add.l	d0,a0
	
	tst.b	train
	bne.w	.tra
.cvi
	cmp.b	#4,(a0)
	bne.w	.nv
.cvi2

	tst.b	train
	bne.w	.training

	cmp.b	#1,nappula
	beq.w	.n2

	tst.b	players
	beq.w	.nx

; *** Tulostaa pelin lopputekstit ***
	
	lea	text_pelaaja1,a0
	move.l	plane_add,a6
	add.l	#64+9+20*8*40,a6
	moveq	#6,d2
	bsr	print

	lea	text_siirtoa,a0
	move.l	plane_add,a6
	add.l	#64+19+20*8*40,a6
	moveq	#1,d2
	bsr	print

	lea	text_pelaaja2,a0
	move.l	plane_add,a6
	add.l	#64+9+21*8*40,a6
	moveq	#7,d2
	bsr	print

	lea	text_voittanut,a0
	move.l	plane_add,a6
	add.l	#64+19+21*8*40,a6
	moveq	#1,d2
	bsr	print
	move.b	#1,game_over

	bra.w	.nv
.n2
	tst.b	players					;demo?
	beq.w	.nx

	lea	text_pelaaja2,a0
	move.l	plane_add,a6
	add.l	#64+9+20*8*40,a6
	moveq	#7,d2
	bsr	print

	lea	text_siirtoa,a0
	move.l	plane_add,a6
	add.l	#64+19+20*8*40,a6
	moveq	#1,d2
	bsr	print

	lea	text_pelaaja1,a0
	move.l	plane_add,a6
	add.l	#64+9+21*8*40,a6
	moveq	#6,d2
	bsr	print

	lea	text_voittanut,a0
	move.l	plane_add,a6
	add.l	#64+19+21*8*40,a6
	moveq	#1,d2
	bsr	print
	move.b	#1,game_over
	bra.s	.nv
.nx

; *** Demossa ei tulostella mit‰‰n tekstej‰, vaan ***
; *** siirryt‰‰n heti seuraavaan peliin 	  ***

	cmp.b	#1,nappula				;kumpi voitti?
	beq.s	.n22

	moveq	#1,d1
	move.b	score2,d0
	abcd.b	d1,d0
	move.b	d0,score2
	bra.s	.nxx
.n22
	moveq	#1,d1
	move.b	score1,d0
	abcd.b	d1,d0
	move.b	d0,score1
.nxx
	lea	init_board,a0
	lea	board,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.b	#2,nappula
.nv
	rts
.tra

; *** Tutkitaan onnistuiko harjoitusteht‰v‰n ratkaisu ***

	cmp.b	#2,nappula
	bne.w	.cvi
	cmp.b	#0,(a0)
	beq.s	.nv
	bra.w	.t2		

.training
	cmp.b	#2,nappula
	beq.s	.t2

	lea	text_ratkaisit1,a0
	move.l	plane_add,a6
	add.l	#64+9+20*8*40,a6
	moveq	#6,d2
	bsr	print
	lea	text_ratkaisit2,a0
	move.l	plane_add,a6
	add.l	#64+9+21*8*40,a6
	moveq	#6,d2
	bsr	print
	move.b	#1,game_over
	rts
.t2
	lea	text_etrat1,a0
	move.l	plane_add,a6
	add.l	#64+9+20*8*40,a6
	moveq	#7,d2
	bsr	print
	lea	text_etrat2,a0
	move.l	plane_add,a6
	add.l	#64+9+21*8*40,a6
	moveq	#7,d2
	bsr	print
	
	move.b	#1,game_over
	rts

;----------------------------------------------------------------------
; Tarkistaa undo pyynnˆn ja tarvittaessa palauttaa aikaisemman til.
;----------------------------------------------------------------------

check_undo

	cmp.b	#1,undo
	bne.w	.r
	
	sub.l	#36,history_counter
	move.l	taulukko_add,a0
	add.l	#74000,a0
	add.l	history_counter,a0
	lea	board,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.b	#1,done		
	move.b	#0,game_over
	cmp.b	#2,players
	beq.s	.r
	sub.b	#1,nappula
	eor.b	#1,nappula
	add.b	#1,nappula
.r
	rts

;----------------------------------------------------------------------
; Hoitaa kaikkien kontrollin tutkimisen (joystick, n‰ppis, hiiri)
;----------------------------------------------------------------------
		
control_hand

	move.b	#0,key
	moveq	#0,d2
	move.w	#0,control2
	move.b	#1,ending2

; *** N‰pp‰imistˆn tutkiminen **
	
	btst	#3,$bfed01
	beq.w	.jm
	bset	#6,$bfee01
	moveq	#127,d0					;pieni waitti
.wait	nop
	dbf	d0,.wait
	bclr	#6,$bfee01

	moveq	#0,d0
	move.b	$bfec01,d0
	move	#$0008,$dff09c
	not.b	d0
	ror.b	#1,d0
	cmp.b	#$4e,d0
	bne.s	.ka
	bset	#1,d2
.ka
	cmp.b	#$4f,d0
	bne.s	.kb
	bset	#2,d2
.kb
	cmp.b	#$4d,d0
	bne.s	.kc
	bset	#3,d2
.kc
	cmp.b	#$4c,d0
	bne.s	.kd
	bset	#4,d2
.kd
	cmp.b	#$44,d0
	bne.s	.ke
	move.w	#2,control2
.ke
	cmp.b	#$13,d0
	bne.s	.kf
	move.w	#3,control2
.kf
	cmp.b	#$46,d0
	bne.s	.kg
	cmp.l	#36*99,history_counter
	beq.s	.kg
	tst.l	history_counter
	beq.s	.kg
	move.b	#1,undo
.kg
	cmp.b	#$45,d0
	bne.s	.kh
	cmp.b	#3,meny
	beq.s	.km3
	tst.b	meny
	bne.s	.kh
	move.b	#1,meny
	bra.s	.kh
.km3
	move.b	#4,meny
.kh	
	cmp.b	#$40,d0
	bne.s	.ki
	move.w	#4,control2
.ki
	cmp.b	#$5f,d0
	bne.s	.kj
	tst.b	game_over
	bne.s	.kj
	tst.b	players
	beq.s	.kj
	tst.b	meny
	bne.s	.kj
	move.b 	#1,mbr
	move.b	#1,hint
	move.b	#0,shint
.kj

	move.b	d0,key	
.jm

; *** Joystickin tutkiminen ***

	move.w	$dff00c,d0
	move.w	d0,d1
	ror.w	#1,d1
	btst	#1,d0
	beq.w	.sa
	bset	#1,d2
.sa	
	btst	#9,d0
	beq.s	.sb
	bset	#2,d2
.sb
	eor.w	d1,d0
	btst	#0,d0
	beq.w	.sc
	bset	#3,d2
.sc	
	btst	#8,d0
	beq.s	.sd
	bset	#4,d2
.sd

; *** Hiiren tutkiminen ***

	moveq	#0,d0
	move.b	$dff00b,d0
	sub.b	old_x,d0
	cmp.b	#7,d0
	blt.s	.sf
	bset	#1,d2
.sf
	
	cmp.b	#-7,d0
	bgt.s	.sg
	bset	#2,d2
.sg
	moveq	#0,d0
	move.b	$dff00a,d0
	sub.b	old_y,d0
	cmp.b	#7,d0
	blt.s	.sh
	bset	#3,d2
		
.sh
	cmp.b	#-7,d0
	bgt.s	.si
	bset	#4,d2
.si
	move.w	d2,control
	btst	#2,$dff016
	bne.w	.n
	move.w	#1,control2
	
.n
	btst	#7,$bfe001
	beq.s	.ni
	btst	#6,$bfe001
	bne.s	.n2
.ni
	tst.b	button
	bne.s	.bu
	move.b	#1,button
.bu
	tst.w	control
	beq.s	.n4
	move.w	#1,control2
	move.w	#0,control
	move.b	#3,button
	bra.s	.n4
.n2
	cmp.b	#1,button
	bne.s	.n3
	move.w	#2,control2
.n3
	move.b	#0,button
.n4	

	rts
	
;----------------------------------------------------------------------
; Tutkii painettiinko jotain kontrollia ja mit‰ se aiheuttaa
;----------------------------------------------------------------------

check_button

	cmp.w	#4,control2
	beq.w	.done

	cmp.w	#2,control2
	bne.w	.cok

	tst.b	nelio
	beq.w	.nel

	cmp.b	#3,nelio
	beq.w	.n3

	move.l	bxy,a0
	cmp.b	#3,(a0)
	beq.w	.wa
	tst.b	(a0)
	beq.s	.vom
	move.b	nappula,d0
	cmp.b	(a0),d0
	bne.w	.cok
.nelii
	cmp.b	#1,nelio
	bne.w	.cok
.c	
	bsr	copy_bfo
	move.b	#0,nelio
	move.l	#0,color_cycle_pointer
	
	bsr	do_block
	bsr	make_board

	bra.w	.cok
.vom
	move.b	#1,done
	bra.w	.cok
.wa	

	move.l	bxy,d0
	sub.l	#board,d0
	lea	board_old2,a0
	add.l	d0,a0
	cmp.b	#3,(a0)
	bne.s	.ntc

	bsr	copy_bfo2
.ntc
	move.l	bxy,a0
	move.b	#0,(a0)
	bsr	make_board
	move.b	#3,nelio
	move.l	#0,color_cycle_pointer
	bra.s	.cok

.n3
	move.l	bxy,a0
	tst.b	(a0)
	bne.s	.cok
	move.b	#3,(a0)
	bsr	make_board
	move.b	#1,nelio
	move.l	#0,color_cycle_pointer
	bra.s	.cok
.nel
	move.l	piece_xp_old,d0
	cmp.l	piece_xp,d0
	bne.s	.nelok
	move.l	piece_yp_old,d0
	cmp.l	piece_yp,d0
	bne.s	.nelok
	move.b	suunta_old,d0
	cmp.b	suunta,d0
	beq.s	.cok
.nelok

	bsr	drop_block
	tst.b	d0
	beq.s	.cok
	move.b	#1,nelio
	move.l	#0,color_cycle_pointer

	bsr	copy_bto2

	bsr	make_board
.cok
	rts
.done
	cmp.b	#1,nelio
	bne.s	.cok
	move.b	#1,done
	bra.s	.cok	

;-----------------------------------------------------------------------
; Tarkistaa kontrollien k‰‰ntelyn ja tarvittaessa muuttaa koordinaatteja
;-----------------------------------------------------------------------


do_move1	
	cmp.w	#16,control
	bne.w	.nc
	cmp.l	#120,piece_yp
	beq.s	.nc
	sub.l	#16,grid_y
.nc
	cmp.w	#8,control
	bne.s	.nc2
	cmp.l	#168,piece_yp
	beq.s	.nc2
	add.l	#16,grid_y
.nc2	
	cmp.w	#2,control
	bne.s	.nc3
	cmp.l	#152,piece_xp
	beq.s	.nc3
	add.l	#8,grid_x
.nc3
	cmp.w	#4,control
	bne.s	.nc4
	cmp.l	#128,piece_xp
	beq.s	.nc4
	sub.l	#8,grid_x
.nc4	
	rts

;-------------------------------------------------------------------------
; Tutkii pit‰‰kˆ nappulaa siirt‰‰ uuteen paikkaa
;-------------------------------------------------------------------------

do_move2

	move.l	grid_x,d0
	cmp.l	piece_xp,d0
	bhi.s	.1
	bcs.s	.2
	move.l	grid_y,d0
	cmp.l	piece_yp,d0
	bhi.s	.3
	bcs.s	.4
	bra.s	.5
.1
	add.l	#1,piece_xp
	bra.s	.5
.2
	sub.l	#1,piece_xp
	bra.s	.5
.3
	add.l	#2,piece_yp
	bra.s	.5
.4		
	sub.l	#2,piece_yp	
	bra.w	.5
.5
	move.w	#1,moving
	move.l	piece_xp,d0
	cmp.l	grid_x,d0
	bne.s	.6
	move.l	piece_yp,d0
	cmp.l	grid_y,d0
	bne.s	.6
	move.w	#0,moving
.6
	rts

;-----------------------------------------------------------------------
; Tekee ohjattavan olion
;-----------------------------------------------------------------------
	
make_cursor

	move.l	piece_xp,d0
	sub.l	#104,d0
	move.l	d0,d1
	asr.l	#2,d1
	move.l	d1,shp
	move.l	piece_yp,d2
	mulu	#40,d2
	add.l	d2,shp

	asl.l	#2,d1
	sub.l	d1,d0
	add.l	d0,d0
	move.l	d0,shpl
	sub.l	#75*40+30,shp

	cmp.b	#1,shint
	beq.s	.nix
	tst.b	nelio
	beq.s	.bl		

	cmp.b	#1,nelio
	beq.s	.nix
	bsr	do_ball
	bra.s	.nt
.bl
	bsr	do_block
	bra.s	.nt
.nix
	bsr	do_nix
.nt
	rts
	

;-----------------------------------------------------------------------
; Generoi tarvittavan maskin (varjon tai kursorin)
;-----------------------------------------------------------------------

do_mask

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp_old,a0
	sub.l	#4,a0
	move	#69+16,d7
.hg
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+

	add.l	#27+2,a0	
	dbf	d7,.hg

	cmp.b	#3,nelio
	beq.w	.nom


	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	
	lea	shpm,a1
	move.l	shpl,d0
	add.l	d0,d0
	move.w	(a1,d0.w),d0
	move.w	d0,d1
	rol.w	#8,d1
	move.w	d0,d2
	not.w	d2
	move.w	d2,d3
	rol.w	#8,d3

	cmp.b	#1,nelio
	bne.s	.nnel

	lea	shpm2,a1
	move.l	shpl,d0
	move.b	(a1,d0.w),d0
	move.b	d0,d1
	not.b	d1
	tst.l	shpl
	bne.w	.nh
	and.l	#%01111111,d1
.nh
	add.l	#33*40,a0
	move	#14,d7
.glna		
	move.b	d0,(a0)
	move.b	#-1,1(a0)
	move.b	d1,2(a0)
	
	add.l	#40,a0
	dbf	d7,.glna
	bra.w	.x
	
.nnel


	cmp.b	#2,suunta
	beq.w	.2	
	cmp.b	#3,suunta
	beq.w	.3	
	cmp.b	#4,suunta
	beq.w	.4	
	cmp.b	#5,suunta
	beq.w	.5	
	cmp.b	#6,suunta
	beq.w	.6	
	cmp.b	#7,suunta
	beq.w	.7	
	cmp.b	#8,suunta
	beq.w	.8	
.1
	add.l	#36*40+1,a0
	move	#16,d7
.gl1a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	#-1,4(a0)
	move.b	d3,5(a0)
	move.b	d2,6(a0)
	
	add.l	#40,a0
	dbf	d7,.gl1a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#53*40,a0		
	move	#15,d7
.gl1b		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl1b
	bra.w	.x

.2
	add.l	#36*40,a0
	move	#15,d7
.gl2a		
 	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	d3,4(a0)
	move.b	d2,5(a0)
	
	add.l	#40,a0
	dbf	d7,.gl2a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	
	add.l	shp,a0
	add.l	#4*40,a0		
	move	#27,d7
.gl2b		
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl2b
	bra.w	.x
.3
	add.l	#36*40-4,a0
	move	#15,d7
.gl3a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	#-1,4(a0)
	move.b	#-1,5(a0)
	move.b	d3,6(a0)
	move.b	d2,7(a0)
	
	add.l	#40,a0
	dbf	d7,.gl3a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#20*40+1,a0		
	move	#27,d7
.gl3b		
	move.b	d3,1(a0)
	move.b	d2,2(a0)

	add.l	#40,a0
	dbf	d7,.gl3b
	bra.w	.x

.4
	add.l	#36*40,a0		
	move	#47,d7
.gl4a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl4a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#48*40-2,a0
	move	#3,d7
.gl4b		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	d3,2(a0)	
	move.b	d2,3(a0)	
	add.l	#40,a0
	dbf	d7,.gl4b

	bra.w	.x
.5
	add.l	#36*40,a0		
	move	#47,d7
.gl5a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl5a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#36*40+1,a0
	move	#15,d7
.gl5b		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	d3,3(a0)	
	move.b	d2,4(a0)	
	add.l	#40,a0
	dbf	d7,.gl5b

	bra.w	.x
.6
	add.l	#36*40,a0
	move	#15,d7
.gl6a		
 	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	#-1,4(a0)
	move.b	#-1,5(a0)
	move.b	d3,6(a0)
	move.b	d2,7(a0)
	
	add.l	#40,a0
	dbf	d7,.gl6a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#20*40,a0		
	move	#27,d7
.gl6b		
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl6b
	bra.w	.x
.7
	add.l	#32*40-2,a0
	move	#19,d7
.gl7a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	d3,4(a0)
	move.b	d2,5(a0)
	
	add.l	#40,a0
	dbf	d7,.gl7a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#4*40+1,a0		
	move	#27,d7
.gl7b		
	move.b	d3,1(a0)
	move.b	d2,2(a0)

	add.l	#40,a0
	dbf	d7,.gl7b
	bra.w	.x
.8
	add.l	#36*40,a0		
	move	#31,d7
.gl8a		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	d3,2(a0)
	move.b	d2,3(a0)

	add.l	#40,a0
	dbf	d7,.gl8a

	move.l	plane_add,a0
	add.l	#4*10240+64,a0
	add.l	shp,a0
	add.l	#48*40-4,a0
	move	#3,d7
.gl8b		
	move.b	d1,(a0)
	move.b	d0,1(a0)
	move.b	#-1,2(a0)
	move.b	#-1,3(a0)
	move.b	d3,4(a0)	
	move.b	d2,5(a0)	
	add.l	#40,a0
	dbf	d7,.gl8b

	bra.w	.x

.x
.nom
	move.l	shp,shp_old
	rts
	
;-----------------------------------------------------------------------
; Koostaa palikan kolmesta spritest‰
;-----------------------------------------------------------------------

do_block

suu
	cmp.b	#1,suunta
	beq.s	.1
	cmp.b	#2,suunta
	beq.w	.2
	cmp.b	#3,suunta
	beq.w	.3
	cmp.b	#4,suunta
	beq.w	.4
	cmp.b	#5,suunta
	beq.w	.5
	cmp.b	#6,suunta
	beq.w	.6
	cmp.b	#7,suunta
	beq.w	.7
	cmp.b	#8,suunta
	beq.w	.8
	
.1	
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	add.l	#16,d0
	move.l	d0,piece_xp1
	sub.l	#8,d0
	move.l	d0,piece_xp2
	sub.l	#8,d0
	move.l	d0,piece_xp3
	bra.w	.xs
.2	
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	sub.l	#32,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp3
	move.l	d0,piece_xp2
	add.l	#8,d0
	move.l	d0,piece_xp1
	bra.w	.xs
.3	
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	sub.l	#16,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp3
	sub.l	#8,d0
	move.l	d0,piece_xp2
	sub.l	#8,d0
	move.l	d0,piece_xp1
	bra.w	.xs
.4
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	add.l	#16,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	sub.l	#8,d0
	move.l	d0,piece_xp1
	add.l	#8,d0
	move.l	d0,piece_xp2
	move.l	d0,piece_xp3
	bra.w	.xs
.5
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	add.l	#16,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp1
	move.l	d0,piece_xp3
	add.l	#8,d0
	move.l	d0,piece_xp2
	bra.w	.xs

.6
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	sub.l	#16,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp3
	add.l	#8,d0
	move.l	d0,piece_xp2
	add.l	#8,d0
	move.l	d0,piece_xp1
	bra.w	.xs

.7
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	sub.l	#32,d0
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp3
	move.l	d0,piece_xp2
	sub.l	#8,d0
	move.l	d0,piece_xp1
	bra.w	.xs
.8
	move.l	piece_yp,d0
	move.l	d0,piece_yp1
	move.l	d0,piece_yp2
	move.l	d0,piece_yp3

	move.l	piece_xp,d0
	move.l	d0,piece_xp3
	sub.l	#8,d0
	move.l	d0,piece_xp2
	sub.l	#8,d0
	move.l	d0,piece_xp1
	bra.w	.xs
	

.xs
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.l	#0,a0
	move.l	#0,a1
	move.l	#0,a2

	move.l	#piece1a,pointer1a
	move.l	#piece1b,pointer1b
	move.l	#piece1c,pointer1c

	move.l	piece_yp1,d0
	move.l	piece_yp2,d1
	move.l	piece_yp3,d2

	lea	piece1a,a0
	lea	piece1b,a1
	lea	piece1c,a2

	move.b	d0,(a0)
	move.b	d1,(a1)
	move.b	d2,(a2)
			
	add.b	#16,d0
	add.b	#16,d1
	add.b	#32,d2
	move.b	d0,2(a0)
	move.b	d1,2(a1)
	move.b	d2,2(a2)

	
	move.l	piece_xp1,d0
	move.l	piece_xp2,d1
	move.l	piece_xp3,d2
	
	move.b	d0,1(a0)
	move.b	d1,1(a1)
	move.b	d2,1(a2)

	move.l	pointer1a,d0
	move	d0,sp5l
	swap	d0
	move	d0,sp5h
	move.l	pointer1b,d0
	move	d0,sp6l
	swap	d0
	move	d0,sp6h
	move.l	pointer1c,d0
	move	d0,sp7l
	swap	d0
	move	d0,sp7h
	rts
	
;-----------------------------------------------------------------------
; Generoi spriteen puolueettoman nappulan
;-----------------------------------------------------------------------

do_ball

	move.l	#piece4,pointer1a
	move.l	#piece4,pointer1b
	move.l	#spriteb,pointer1c

	move.l	piece_yp,d0
	add.l	#3,d0

	lea	spriteb,a0

	move.b	d0,(a0)
			
	add.b	#16,d0
	move.b	d0,2(a0)

	
	move.l	piece_xp,d0
	add.l	#1,d0
	
	move.b	d0,1(a0)

	move.l	pointer1a,d0
	move	d0,sp5l
	swap	d0
	move	d0,sp5h
	move.l	pointer1b,d0
	move	d0,sp6l
	swap	d0
	move	d0,sp6h
	move.l	pointer1c,d0
	move	d0,sp7l
	swap	d0
	move	d0,sp7h
	rts
	
;-----------------------------------------------------------------------
; Nollaa sprite osoittimet
;-----------------------------------------------------------------------

do_nix
	
	move.l	#piece4,pointer1a
	move.l	#piece4,pointer1b
	move.l	#piece4,pointer1c

	move.l	pointer1a,d0
	move	d0,sp5l
	swap	d0
	move	d0,sp5h
	move.l	pointer1b,d0
	move	d0,sp6l
	swap	d0
	move	d0,sp6h
	move.l	pointer1c,d0
	move	d0,sp7l
	swap	d0
	move	d0,sp7h
	rts
	
;-----------------------------------------------------------------------
; Tarkistaa haluttiinko pyˆr‰ytt‰‰ nappulaa
;-----------------------------------------------------------------------

check_rotate

	cmp.w	#1,moving
	beq.w	.nn

	tst.w	control2
	beq.s	.n

	cmp.w	#3,control2
	beq.s	.dor
	add.l	#1,wait
	cmp.l	#8,wait
	bne.w	.nn	
.dor
	move.l	sn,d0
	add.l	#1,d0
	cmp.l	#16,d0
	bne.s	.on
	moveq	#0,d0
.on		
	bsr	do_rotate

.n
	move.l	#0,wait
.nn	
	rts

;-----------------------------------------------------------------------
; Tutkii millainen pyˆr‰ytt‰minen t‰ss‰ kohtaa voidaan nappulalle tehd‰
;-----------------------------------------------------------------------

do_rotate

	move.l	bxy,a0

	moveq	#0,d0
	tst.b	(a0)
	bne.w	.10
	tst.b	-1(a0)
	beq.s	.ok1
	tst.b	1(a0)
	bne.w	.10
.ok1
	tst.b	-6(a0)
	beq.w	.ok2
	tst.b	6(a0)
	bne.w	.10
.ok2
	cmp.b	#1,suunta
	beq.w	.2
	cmp.b	#2,suunta
	beq.w	.3
	cmp.b	#3,suunta
	beq.w	.4
	cmp.b	#4,suunta
	beq.w	.5
	cmp.b	#5,suunta
	beq.w	.6
	cmp.b	#6,suunta
	beq.w	.7
	cmp.b	#7,suunta
	beq.w	.8
	cmp.b	#8,suunta
	beq.w	.1

.1
	cmp.b	#1,suunta
	beq.w	.10
	
	tst.b	1(a0)
	bne.s	.2
	tst.b	2(a0)
	bne.s	.2
	tst.b	6(a0)
	bne.s	.2
	move.b	#1,suunta
	bra.w	.10
.2
	cmp.b	#2,suunta
	beq.w	.10
	tst.b	1(a0)
	bne.s	.3
	tst.b	-6(a0)
	bne.s	.3
	tst.b	-12(a0)
	bne.s	.3
	move.b	#2,suunta
	bra.w	.10

.3
	cmp.b	#3,suunta
	beq.w	.10
	tst.b	-1(a0)
	bne.s	.4
	tst.b	-2(a0)
	bne.s	.4
	tst.b	-6(a0)
	bne.s	.4
	move.b	#3,suunta
	bra.w	.10
.4
	cmp.b	#4,suunta
	beq.w	.10
	tst.b	-1(a0)
	bne.s	.5
	tst.b	6(a0)
	bne.s	.5
	tst.b	12(a0)
	bne.s	.5
	move.b	#4,suunta
	bra.w	.10
.5
	cmp.b	#5,suunta
	beq.w	.10
	tst.b	1(a0)
	bne.s	.6
	tst.b	6(a0)
	bne.s	.6
	tst.b	12(a0)
	bne.s	.6
	move.b	#5,suunta
	bra.w	.10
.6
	cmp.b	#6,suunta
	beq.s	.10
	tst.b	-6(a0)
	bne.s	.7
	tst.b	1(a0)
	bne.s	.7
	tst.b	2(a0)
	bne.s	.7
	move.b	#6,suunta
	bra.s	.10
.7
	cmp.b	#7,suunta
	beq.s	.10
	tst.b	-1(a0)
	bne.s	.8
	tst.b	-6(a0)
	bne.s	.8
	tst.b	-12(a0)
	bne.s	.8
	move.b	#7,suunta
	bra.s	.10
.8
	cmp.b	#8,suunta
	beq.s	.10
	tst.b	6(a0)
	bne.s	.9
	tst.b	-1(a0)
	bne.s	.9
	tst.b	-2(a0)
	bne.s	.9
	move.b	#8,suunta
	bra.s	.10
.9
	bra.w	.1
.10
	rts

;-----------------------------------------------------------------------
; Muuntaa nappulan/kursorin koordinaatit osoitteeksi
;-----------------------------------------------------------------------

calc_bxy

	lea	board,a0
	cmp.l	#120,piece_yp
	bne.s	.w1
	moveq	#7,d0
	bra.s	.wa
.w1
	cmp.l	#136,piece_yp
	bne.s	.w2
	moveq	#7+6,d0
	bra.s	.wa
.w2
	cmp.l	#152,piece_yp
	bne.s	.w3
	moveq	#7+6+6,d0
	bra.s	.wa
.w3
	moveq	#7+6+6+6,d0
.wa
	cmp.l	#152,piece_xp
	bne.s	.v1
	addq.l	#3,d0
	bra.s	.v3
.v1
	cmp.l	#144,piece_xp
	bne.s	.v2
	addq.l	#2,d0
	bra.s	.v3
.v2	cmp.l	#136,piece_xp
	bne.s	.v3
	addq.l	#1,d0
.v3	
	add.l	d0,a0
	move.l	a0,bxy
	rts
	
;-----------------------------------------------------------------------
; Tiputa L-nappula t‰h‰n (bxy) kohtaan
;-----------------------------------------------------------------------

drop_block

	move.l	bxy,a0

	moveq	#0,d0
	tst.b	(a0)
	bne.w	.out
	tst.b	-1(a0)
	beq.s	.ok1
	tst.b	1(a0)
	bne.w	.out
.ok1
	tst.b	-6(a0)
	beq.w	.ok2
	tst.b	6(a0)
	bne.w	.out
.ok2
	move.b	nappula,d2
	cmp.b	#8,suunta
	beq.w	.8
	cmp.b	#2,suunta
	beq.w	.2
	cmp.b	#3,suunta
	beq.w	.3
	cmp.b	#4,suunta
	beq.w	.4
	cmp.b	#5,suunta
	beq.w	.5
	cmp.b	#6,suunta
	beq.w	.6
	cmp.b	#7,suunta
	beq.w	.7

;1
	tst.b	1(a0)
	bne.w	.9
	tst.b	2(a0)
	bne.w	.9
	tst.b	6(a0)
	bne.w	.9
.o1	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,1(a0)
	move.b	d2,2(a0)
	move.b	d2,6(a0)
	bra.w	.9	
.2
	tst.b	1(a0)
	bne.w	.9
	tst.b	-6(a0)
	bne.w	.9
	tst.b	-12(a0)
	bne.w	.9

.o2	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,1(a0)
	move.b	d2,-6(a0)
	move.b	d2,-12(a0)
	bra.w	.9	
.3
	tst.b	-1(a0)
	bne.w	.9
	tst.b	-2(a0)
	bne.w	.9
	tst.b	-6(a0)
	bne.w	.9
.o3	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,-1(a0)
	move.b	d2,-2(a0)
	move.b	d2,-6(a0)
	bra.w	.9	
.4
	tst.b	-1(a0)
	bne.w	.9
	tst.b	6(a0)
	bne.w	.9
	tst.b	12(a0)
	bne.w	.9
.o4	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,-1(a0)
	move.b	d2,6(a0)
	move.b	d2,12(a0)
	bra.w	.9	
.5
	tst.b	1(a0)
	bne.w	.9
	tst.b	6(a0)
	bne.w	.9
	tst.b	12(a0)
	bne.w	.9
.o5	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,1(a0)
	move.b	d2,6(a0)
	move.b	d2,12(a0)
	bra.w	.9	
.6
	tst.b	-6(a0)
	bne.w	.9
	tst.b	1(a0)
	bne.w	.9
	tst.b	2(a0)
	bne.w	.9
.o6	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,-6(a0)
	move.b	d2,1(a0)
	move.b	d2,2(a0)
	bra.s	.9	
.7
	tst.b	-1(a0)
	bne.s	.9
	tst.b	-6(a0)
	bne.s	.9
	tst.b	-12(a0)
	bne.s	.9
.o7	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,-1(a0)
	move.b	d2,-6(a0)
	move.b	d2,-12(a0)
	bra.s	.9	
.8
	tst.b	6(a0)
	bne.s	.9
	tst.b	-1(a0)
	bne.s	.9
	tst.b	-2(a0)
	bne.s	.9
.o8	
	addq	#1,d0
	move.b	d2,(a0)
	move.b	d2,6(a0)
	move.b	d2,-1(a0)
	move.b	d2,-2(a0)
.9
.out
	rts

;-----------------------------------------------------------------------
; Selvitt‰‰ laudasta (board), miss‰ kohtaa L-nappula on ja miss‰ 
; asennossa
;-----------------------------------------------------------------------

find_pos

	lea	board+7,a0
	move.b	nappula,d4
	move	#27,d7
.lo
	bsr	 .c
	tst.b	d0
	bne.s	.o
	addq.l	#1,a0
	dbf	d7,.lo	
	bra.s	.oo
.o
	move.l	a0,bxy
	tst.b	mbr
	bne.s	.oo
.ol	
	move.b	d0,suunta
	move.b	d0,suunta_old
	rts
.oo
	move.b	d0,suunta_old
	rts
.c
	moveq	#0,d0
	cmp.b	(a0),d4
	bne.w	.out
	cmp.b	-1(a0),d4
	beq.s	.ok1
	cmp.b	1(a0),d4
	bne.w	.out
.ok1
	cmp.b	-6(a0),d4
	beq.w	.ok2
	cmp.b	6(a0),d4
	bne.w	.out
.ok2
;1
	cmp.b	1(a0),d4
	bne.s	.2
	cmp.b	2(a0),d4
	bne.s	.2
	cmp.b	6(a0),d4
	bne.s	.2
	moveq	#1,d0

.2
	cmp.b	1(a0),d4
	bne.s	.3
	cmp.b	-6(a0),d4
	bne.s	.3
	cmp.b	-12(a0),d4
	bne.s	.3
	moveq	#2,d0

.3
	cmp.b	-1(a0),d4
	bne.s	.4
	cmp.b	-2(a0),d4
	bne.s	.4
	cmp.b	-6(a0),d4
	bne.s	.4
	moveq	#3,d0

.4
	cmp.b	-1(a0),d4
	bne.s	.5
	cmp.b	6(a0),d4
	bne.s	.5
	cmp.b	12(a0),d4
	bne.s	.5
	moveq	#4,d0
.5
	cmp.b	1(a0),d4
	bne.s	.6
	cmp.b	6(a0),d4
	bne.s	.6
	cmp.b	12(a0),d4
	bne.s	.6
	moveq	#5,d0
.6
	cmp.b	-6(a0),d4
	bne.s	.7
	cmp.b	1(a0),d4
	bne.s	.7
	cmp.b	2(a0),d4
	bne.s	.7
	moveq	#6,d0
.7
	cmp.b	-1(a0),d4
	bne.s	.8
	cmp.b	-6(a0),d4
	bne.s	.8
	cmp.b	-12(a0),d4
	bne.s	.8
	moveq	#7,d0
.8
	cmp.b	6(a0),d4
	bne.s	.9
	cmp.b	-1(a0),d4
	bne.s	.9
	cmp.b	-2(a0),d4
	bne.s	.9
	moveq	#8,d0

.9
.out
	rts

;-----------------------------------------------------------------------
; Muuntaa osoitteen (bxy) nappulan koordinaateiksi (piece_xp ja
; piece_yp)
;-----------------------------------------------------------------------

conv_bxy2pos
	move.l	#board+7,d0
	move.l	bxy,d1
	sub.l	d0,d1
	divu	#6,d1
	move.l	d1,d0
	and.l	#$ffff,d1
	swap	d0
	and.l	#$ffff,d0
	lsl.l	#4,d1
	add.l	#120,d1
	lsl.l	#3,d0
	add.l	#128,d0
	move.l	d0,piece_xp
	move.l	d1,piece_yp
	move.b	suunta,suunta_old
	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old
	rts

;-----------------------------------------------------------------------
; Suodattaa laudalta pois muuttujan 'nappula' osoittaman nappulan pois.
; Kopioi samalla alkuper‰isen tilanteen taulukkoon board_r
;-----------------------------------------------------------------------

filter_board

	lea	board,a0
	lea	board_r,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+

	move.b	nappula,d4
	lea	board,a0
	move	#35,d7
.lo
	cmp.b	(a0)+,d4
	bne.s	.x
	move.b	#0,-1(a0)
.x
	dbf	d7,.lo	
	rts

;-----------------------------------------------------------------------
; Ottaa kopion laudasta
;-----------------------------------------------------------------------

copy_bfo

	lea	board_old,a0
	lea	board,a1
	move	#8,d7
.lo	
	move.l	(a0)+,(a1)+
	dbf	d7,.lo
	rts	

;-----------------------------------------------------------------------
; Palautaa kopion
;-----------------------------------------------------------------------

copy_bto

	lea	board_old,a1
	lea	board,a0
	move	#8,d7
.lo	
	move.l	(a0)+,(a1)+
	dbf	d7,.lo
	rts	

;--------------------------------------------------------------------
; Tekee muuttujan 'nappula' nappulalla siirron valitun vaikeusasteen
; mukaisesti
;--------------------------------------------------------------------

make_move

	move.l	#0,tal_pt
	move.l	#0,pt2
	move.l	#0,mlkm
	bsr	calc_moves
	cmp.l	#0,mlkm
	beq.w	.r
	
	move.l	#0,best

; *** Otetaan huomioon vaikeusaste ***

	tst.b	train
	bne.w	.l4
	tst.b	hint
	bne.s	.l4
	
	tst.l	level
	beq.s	.l0
	cmp.l	#1,level
	beq.s	.l1
	cmp.l	#2,level
	beq.s	.l2
	cmp.l	#3,level
	beq.s	.l3
	cmp.l	#4,level
	beq.s	.l4
.l0
	lea	level_0,a0
	tst.b	players
	bne.s	.nd
	lea	level_0d,a0
.nd
	move.l	#900,d1
	bra.s	.lx
.l1
	lea	level_1,a0
	move.l	#800,d1
	bra.s	.lx
.l2
	lea	level_2,a0
	move.l	#800,d1
	bra.s	.lx
.l3
	lea	level_3,a0
	move.l	#800,d1
	bra.s	.lx
.l4
	lea	level_4,a0
	move.l	#1000,d1
.lx
	move.l	a0,level_base
	move.l	d1,level_rand

; *** valitaan ensimm‰isen tutkittavan siirron alkuosoite, ***
; *** josta niit‰ aletaan k‰ym‰‰n j‰rjestyksess‰ l‰pi.     ***
; *** N‰in saadaan tasaisemmin jakautumaan eri             ***
; *** siirtovaihtoehdot

	move.l	mlkm,d1
	subq.l	#3,d1
	bsr	rand
	
	move.l	d3,mlkma
	addq.l	#1,d3
	move.l	d3,mlkml
.ml
	move.l	taulukko_add,a0
	add.l	#66000,a0
	move.l	mlkml,d3
	mulu	#36,d3
	add.l	d3,a0

	lea	board4,a1

	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	
; *** Arvioidaan siirto ***

	cmp.b	#1,nappula
	beq.s	.noinv
	bsr	inv_board
.noinv
	bsr	calc_board

	moveq	#0,d3
	moveq	#0,d0
	move.w	sit_num,d0
	move.l	taulukko_add,a0
	add.l	d0,a0
	moveq	#0,d0
	move.b	(a0),d0

.df

	move.l	level_base,a0
	move.l	level_rand,d1
	lsl.l	#2,d0
	add.l	d0,a0
	move.l	(a0),d0
	
	bsr	rand					;satunnaisuutta
	add.l	d0,d3					;soppaan
	
	cmp.l	best,d3					;oliko parempi
	blt.s	.u					;kuin aikaisemmat?

	move.l	d3,best
	move.w	sit_num,sit_best
	move.l	taulukko_add,a0
	add.l	#66000,a0
	move.l	mlkml,d3
	mulu	#36,d3
	add.l	d3,a0
 	lea	board,a1
	move	#9,d7
.ll
	move.l	(a0)+,(a1)+
	dbf	d7,.ll

.u
	move.l	mlkml,d1
	cmp.l	mlkma,d1
	beq.s	.r

	add.l	#1,mlkml
	move.l	mlkml,d1
	cmp.l	mlkm,d1
	bne.w	.ml
	move.l	#0,mlkml

	bra.w	.ml
	
.r
	rts

;--------------------------------------------------------------------
; Laskee kaikki mahdolliset siirrot (tilanteet joihin voidaan p‰‰st‰)
; laudasta board_r. 
;--------------------------------------------------------------------

calc_moves

; *** Tutkitaan puolueettomien nappuloiden paikat ***

	moveq	#0,d7
	move.l	#0,ball1
	move.l	#0,ball2
	move.l	#0,ball1r
	move.l	#0,ball2r
	
	lea	board_r,a0
	moveq	#0,d0
.al	cmp.b	#3,(a0)+
	bne.s	.ab
	tst.l	ball1r
	bne.s	.ae
	move.l	d0,ball1r
.ae
	move.l	d0,ball2r	
.ab
	addq.l	#1,d0
	cmp.l	#29,d0
	bne.s	.al

	lea	board_r,a0
	lea	board2,a1
	lea	board3,a2
	move	#34,d6
.loop_a
	move.b	(a0)+,d0
	cmp.b	nappula,d0
	bne.s	.f
	moveq	#0,d0
	bne.w	.f
.f
	move.b	d0,(a1)+
	move.b	d0,(a2)+
	dbf	d6,.loop_a

	lea	board2+7,a0
.lop
	bsr	check_dir
.no_moves
	addq.l	#1,a0
	addq.l	#1,d7
	cmp.l	#36-7-7,d7
	bne.w	.lop

	rts

;--------------------------------------------------------------------
; Varioidaan kaikki tilanteet (13), jotka saadaan aikaan jompaa kumpaa
; (tai ei kumpaakaan) puolueettomasta nappulasta siirt‰m‰ll‰.
;--------------------------------------------------------------------

var_balls

	movem.l	d2/a1,-(sp)
	lea	board2,a1
	move	#35,d6
.loop_a
	cmp.b	#3,(a1)+
	bne.s	.f
	move.b	#0,-1(a1)
	bne.w	.f
.f
	dbf	d6,.loop_a

	lea	board2,a1
	move.l	#6,ball1
	move.l	#6,ball2
.loop
	move.l	ball1,d0
	move.l	ball2,d1
	cmp.l	d1,d0
	beq.w	.o
	cmp.l	ball1r,d0
	beq.s	.ok1
	cmp.l	ball2r,d1
	bne.s	.o
.ok1
	tst.b	(a1,d0.w)
	bne.s	.o
	tst.b	(a1,d1.w)
	bne.s	.o
	move.b	#3,(a1,d0.w)
	move.b	#3,(a1,d1.w)
	lea	board2,a1
	move.l	taulukko_add,a2
	add.l	#66000,a2
	add.l	pt2,a2
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	add.l	#1,mlkm
	add.l	#36,pt2	
	lea	board2,a1
	move.l	ball1,d1
	move.b	#0,(a1,d1.w)
	move.l	ball2,d1
	move.b	#0,(a1,d1.w)
.o
		
	add.l	#1,ball1
	cmp.l	#29,ball1
	bls.w	.loop
	move.l	#7,ball1
	add.l	#1,ball2
	cmp.l	#29,ball2
	bls.w	.loop

	lea	board2,a2
	lea	board3,a1
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+

	movem.l	(sp)+,d2/a1
	rts

;--------------------------------------------------------------------
; Tutkii voitaiisinko a0:lla osoittamaan kohtaan laudalla sijoitaa
; nappula johonkin asentoon
;--------------------------------------------------------------------


check_dir

	moveq	#0,d0
	tst.b	(a0)
	bne.w	.out
	tst.b	-1(a0)
	beq.s	.ok1
	tst.b	1(a0)
	bne.w	.out
.ok1
	tst.b	-6(a0)
	beq.w	.ok2
	tst.b	6(a0)
	bne.w	.out
.ok2
	move.l	a0,d1
	move.l	#board2,d2
	sub.l	d2,d1
	lea	board_r,a1
	add.l	d1,a1
	move.b	nappula,d2

;1
	tst.b	1(a0)
	bne.s	.2
	tst.b	2(a0)
	bne.s	.2
	tst.b	6(a0)
	bne.s	.2

	cmp.b	1(a1),d2
	bne.s	.o1
	cmp.b	2(a1),d2
	bne.s	.o1
	cmp.b	6(a1),d2
	beq.s	.2
.o1	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,1(a0)
	move.b	nappula,2(a0)
	move.b	nappula,6(a0)
	bsr	var_balls
	
.2
	tst.b	1(a0)
	bne.s	.3
	tst.b	-6(a0)
	bne.s	.3
	tst.b	-12(a0)
	bne.s	.3
	cmp.b	1(a1),d2
	bne.s	.o2
	cmp.b	-6(a1),d2
	bne.s	.o2
	cmp.b	-12(a1),d2
	beq.s	.3
.o2	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,1(a0)
	move.b	nappula,-6(a0)
	move.b	nappula,-12(a0)
	bsr	var_balls

.3
	tst.b	-1(a0)
	bne.s	.4
	tst.b	-2(a0)
	bne.s	.4
	tst.b	-6(a0)
	bne.s	.4
	cmp.b	-1(a1),d2
	bne.s	.o3
	cmp.b	-2(a1),d2
	bne.s	.o3
	cmp.b	-6(a1),d2
	beq.s	.4
.o3	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,-1(a0)
	move.b	nappula,-2(a0)
	move.b	nappula,-6(a0)
	bsr	var_balls
.4
	tst.b	-1(a0)
	bne.s	.5
	tst.b	6(a0)
	bne.s	.5
	tst.b	12(a0)
	bne.s	.5
	cmp.b	-1(a1),d2
	bne.s	.o4
	cmp.b	6(a1),d2
	bne.s	.o4
	cmp.b	12(a1),d2
	beq.s	.5
.o4	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,-1(a0)
	move.b	nappula,6(a0)
	move.b	nappula,12(a0)
	bsr	var_balls
.5
	tst.b	1(a0)
	bne.s	.6
	tst.b	6(a0)
	bne.s	.6
	tst.b	12(a0)
	bne.s	.6
	cmp.b	1(a1),d2
	bne.s	.o5
	cmp.b	6(a1),d2
	bne.s	.o5
	cmp.b	12(a1),d2
	beq.s	.6
.o5	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,1(a0)
	move.b	nappula,6(a0)
	move.b	nappula,12(a0)
	bsr	var_balls
.6
	tst.b	-6(a0)
	bne.s	.7
	tst.b	1(a0)
	bne.s	.7
	tst.b	2(a0)
	bne.s	.7
	cmp.b	-6(a1),d2
	bne.s	.o6
	cmp.b	1(a1),d2
	bne.s	.o6
	cmp.b	2(a1),d2
	beq.s	.7
.o6	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,-6(a0)
	move.b	nappula,1(a0)
	move.b	nappula,2(a0)
	bsr	var_balls
.7
	tst.b	-1(a0)
	bne.s	.8
	tst.b	-6(a0)
	bne.s	.8
	tst.b	-12(a0)
	bne.s	.8
	cmp.b	-1(a1),d2
	bne.s	.o7
	cmp.b	-6(a1),d2
	bne.s	.o7
	cmp.b	-12(a1),d2
	beq.s	.8
.o7	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,-1(a0)
	move.b	nappula,-6(a0)
	move.b	nappula,-12(a0)
	bsr	var_balls
.8
	tst.b	6(a0)
	bne.s	.9
	tst.b	-1(a0)
	bne.s	.9
	tst.b	-2(a0)
	bne.s	.9
	cmp.b	6(a1),d2
	bne.s	.o8
	cmp.b	-1(a1),d2
	bne.s	.o8
	cmp.b	-2(a1),d2
	beq.s	.9
.o8	
	addq	#1,d0
	move.b	nappula,(a0)
	move.b	nappula,6(a0)
	move.b	nappula,-1(a0)
	move.b	nappula,-2(a0)
	bsr	var_balls
.9
.out
	rts
	
;--------------------------------------------------------------------
; Tekee tarvittavat alustukset ennen peli‰
;--------------------------------------------------------------------

init
	bsr	update_scores

	move.b	$dff00b,old_x
	move.b	$dff00a,old_y
	
	bsr	rand_init
	bsr	pura_taulukko_c

	bsr	find_pos
	bsr	conv_bxy2pos

	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	move.l	piece_xp,piece_xp_old
	move.l	piece_yp,piece_yp_old
	move.b	suunta,suunta_old

	bsr	make_cursor
	
	move.l	piece_yp,grid_y
	move.l	piece_xp,grid_x

	bsr	filter_board
	
	bsr	make_board
	bsr	copy_bto

	rts

;----------------------------------------------------------------------
; Muuntaa taulukko.c nopeampi hakuiseen muotoon (=vie enemm‰n tilaa) 
;----------------------------------------------------------------------

pura_taulukko_c

	lea	taulukko_c,a0
	move.l	taulukko_add,a1
	
	move	#2295,d7
.lo	
	moveq	#0,d0
	moveq	#0,d1
	move.b	(a0)+,d0
	rol.w	#8,d0
	move.b	(a0)+,d0
	move.b	(a0)+,d1
	move.b	d1,(a1,d0.l)
	dbf	d7,.lo
	rts

;----------------------------------------------------------------------
; Alustaa satunnaisluku generaattorin siemenluvut
; lis‰ksi siemenlukua ra2 p‰ivitet‰‰n jatkuvasti, joten k‰ytt‰j‰n
; toiminnasta saadaan _aitoja_ satunnaislukuja
;----------------------------------------------------------------------

rand_init

	move.l	#63,ra1
	move.l	#23483,ra2
	move.l	#9844,ra3
	move.l	#28323,ra4
	move.b	$bfe801,d0
	add.b	d0,ra3
	move.b	$bfe901,d0
	add.b	d0,ra4
	
	rts

;----------------------------------------------------------------------
; Hyvin heuristinen arvontarutiini, mutta k‰ytt‰ytyy aika kivasti
; kun arvontaalueena on nollasta joihinkin satoihin. L‰p‰isi jopa
; yleisempi‰ testej‰.
; 
; D1:ss‰ annetaan milt‰ v‰lilt‰ halutaan satunnaisluku (0-65535)
; D3:ss‰ palautuu satunnainen arvo halutulta v‰lilt‰
;----------------------------------------------------------------------

rand
	add.l	#1,rlaskuri
	movem.l	d0-d1,-(sp)
	move.l	ra1,d0
	move.l	ra2,d2
	move.l	ra3,d3
	move.l	ra4,d4	

	mulu	#1847,d0
	add.l	d0,d2
	mulu	#2311,d2
	add.l	d3,d2
	ror.l	#5,d2
	add.l	#39139,d3
	move.l	d4,d6
	divu	#23231,d6
	swap	d6
	rol.l	#2,d6
	eor.b	d6,d2
	addq.l	#1,d0
	ror.l	#1,d0
	add.l	#213143,d4
			
	move.l	d4,ra4
	move.l	d3,ra3
	move.l	d2,ra2
	move.l	d0,ra1	

	and.l	#$ffff,d2	
	tst.w	d1
	beq.s	.sk
	divu	d1,d2
	swap	d2
	moveq	#0,d3
	move.w	d2,d3
.az
	movem.l	(sp)+,d0-d1
	rts
.sk
	moveq	#0,d3
	bra.s	.az

;----------------------------------------------------------------------
; Laskee a0:ssa olevasta laudasta tilannenumeron (0-65535) ja sijoittaa
; sen muuttujaan sit_num. K‰ytt‰‰ apunaan taulukoita board4 ja board5
;----------------------------------------------------------------------

calc_board:
	
	movem.l	d0-d7/a0-a6,-(sp)
	lea	board4,a0

; ** Etsit‰‰n ykkˆsnappulan paikka ***

	moveq	#0,d0
	moveq	#1,d2
	moveq	#0,d3

	moveq	#1,d5
.loop_m1
	moveq	#3,d6
.loop_m2
	bsr	check
	tst.b	d0
	bne.s	.ok
	bsr	rotate
	dbf	d6,.loop_m2
	bsr	mirror
	dbf	d5,.loop_m1	

.ok
	move.l	d0,d4

; *** Kakkosen paikka ***

	moveq	#0,d0
	moveq	#2,d2
	moveq	#0,d3

	moveq	#1,d5
.loop_m3
	moveq	#3,d6
.loop_m4
	bsr	check
	tst.b	d0
	bne.s	.ok2
	bsr	rotate
	dbf	d6,.loop_m4
	bsr	mirror
	dbf	d5,.loop_m3	

.ok2
	rol.l	#6,d4
	add.l	d3,d4
	
; *** Laskee pallojen paikat ***

	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2

.loop_ba
	
	tst.b	(a0,d0.w)
	beq.s	.blank
	cmp.b	#3,(a0,d0.w)
	beq.s	.ball
	addq	#1,d0
	bra.s	.nx	
.ball
	tst.b	d2
	bne.s	.ed
	rol.l	#3,d1
	moveq	#1,d2
	addq	#1,d0
	bra.s	.nx
.ed
	rol.l	#6,d4
	add.l	d1,d4
	moveq	#0,d0
	bra.s	.en
	rts	
	
.blank
	addq	#1,d0
	addq	#1,d1
.nx
	cmp.l	#36,d0
	bne.s	.loop_ba
;h

.error
.en
	move.w	d4,sit_num
	movem.l	(sp)+,d0-d7/a0-a6
	rts	

;----------------------------------------------------------------------
; Peilaa a0:ssa olevan laudan
;----------------------------------------------------------------------

mirror
	lea	board5,a1
	move	#35,d7
.loop_b
	move.b	(a0)+,(a1)+
	dbf	d7,.loop_b
	sub.l	#36,a0
	sub.l	#36,a1

	move.b	10(a1),7(a0)	
	move.b	9(a1),8(a0)	
	move.b	8(a1),9(a0)
	move.b	7(a1),10(a0)	
	move.b	16(a1),13(a0)	
	move.b	15(a1),14(a0)	
	move.b	14(a1),15(a0)	
	move.b	13(a1),16(a0)	
	move.b	22(a1),19(a0)	
	move.b	21(a1),20(a0)	
	move.b	20(a1),21(a0)	
	move.b	19(a1),22(a0)	
	move.b	28(a1),25(a0)	
	move.b	27(a1),26(a0)	
	move.b	26(a1),27(a0)	
	move.b	25(a1),28(a0)	
	rts

;----------------------------------------------------------------------
; Pyˆr‰ytt‰‰ a0:ssa olevaan lautaa 90∞ astetta
;----------------------------------------------------------------------

rotate
	lea	board5,a1
	move	#35,d7
.loop_a
	move.b	(a0)+,(a1)+
	dbf	d7,.loop_a
	sub.l	#36,a0
	sub.l	#36,a1

	move.b	10(a1),7(a0)	
	move.b	16(a1),8(a0)	
	move.b	22(a1),9(a0)	
	move.b	28(a1),10(a0)	
	move.b	9(a1),13(a0)	
	move.b	15(a1),14(a0)	
	move.b	21(a1),15(a0)	
	move.b	27(a1),16(a0)	
	move.b	8(a1),19(a0)	
	move.b	14(a1),20(a0)	
	move.b	20(a1),21(a0)	
	move.b	26(a1),22(a0)	
	move.b	7(a1),25(a0)
	move.b	13(a1),26(a0)	
	move.b	19(a1),27(a0)	
	move.b	25(a1),28(a0)	
	rts

;----------------------------------------------------------------------
; Tutkii lˆytyykˆ nappulaa d2 laudalta (a0) asennossa: 	  #
;							  #
;							###
;----------------------------------------------------------------------
	
check

	cmp.b	16(a0),d2
	bne.s	.2
	cmp.b	22(a0),d2
	bne.s	.2
	cmp.b	28(a0),d2
	bne.s	.2
	cmp.b	27(a0),d2
	bne.s	.2
	moveq	#1,d0
	rts
.2	
	addq	#1,d3
	cmp.b	15(a0),d2
	bne.s	.3
	cmp.b	21(a0),d2
	bne.s	.3
	cmp.b	27(a0),d2
	bne.s	.3
	cmp.b	26(a0),d2
	bne.s	.3
	moveq	#2,d0
	rts
.3
	addq	#1,d3
	cmp.b	9(a0),d2
	bne.s	.4
	cmp.b	15(a0),d2
	bne.s	.4
	cmp.b	21(a0),d2
	bne.s	.4
	cmp.b	20(a0),d2
	bne.s	.4
	moveq	#3,d0
	rts
.4
	addq	#1,d3
	cmp.b	8(a0),d2
	bne.s	.5
	cmp.b	14(a0),d2
	bne.s	.5
	cmp.b	20(a0),d2
	bne.s	.5
	cmp.b	19(a0),d2
	bne.s	.5
	moveq	#4,d0
	rts
.5
	addq	#1,d3
	cmp.b	10(a0),d2
	bne.s	.6
	cmp.b	16(a0),d2
	bne.s	.6
	cmp.b	22(a0),d2
	bne.s	.6
	cmp.b	21(a0),d2
	bne.s	.6
	moveq	#5,d0
	rts
.6
	addq	#1,d3
	cmp.b	14(a0),d2
	bne.s	.7
	cmp.b	20(a0),d2
	bne.s	.7
	cmp.b	26(a0),d2
	bne.s	.7
	cmp.b	25(a0),d2
	bne.s	.7
	moveq	#6,d0
	rts
.7
	addq	#1,d3
	rts

;----------------------------------------------------------------------
; Vaihtaa 1:n ja 2:n nappulat laudalla kesken‰‰n (board4)
;----------------------------------------------------------------------

inv_board
	lea	board4+7,a0
	move	#29,d7
.loop
	cmp.b	#1,(a0)
	bne.s	.k
	move.b	#2,(a0)
	bra.s	.o
.k		
	cmp.b	#2,(a0)
	bne.s	.o
	move.b	#1,(a0)
.o
	addq.l	#1,a0
	dbf	d7,.loop
	rts

;----------------------------------------------------------------------
; Ota kopio 2)
;----------------------------------------------------------------------

copy_bfo2

	lea	board_old2,a0
	lea	board,a1
	move	#8,d7
.lo	
	move.l	(a0)+,(a1)+
	dbf	d7,.lo
	rts	

;----------------------------------------------------------------------
; Palauta kopio 2
;----------------------------------------------------------------------

copy_bto2

	lea	board_old2,a1
	lea	board,a0
	move	#8,d7
.lo	
	move.l	(a0)+,(a1)+
	dbf	d7,.lo
	rts	

;----------------------------------------------------------------------

	
	section	tietoja,data

ppoint1
	dc.l	0

priority
	dc.b	2
	even
piece1nr
	dc.b	4
piece2nr
	dc.b	1
suunta
	dc.b	1
	even	
wait
	dc.l	0
sn
	dc.l	0
shp
	dc.l	$6f6
shpl
	dc.l	0
shp_old
	dc.l	$6f6
shpl_old
	dc.l	0
	dc.l	0
shpm
	dc.b	%00001111,%11111111 
	dc.b	%00000111,%11111111
	dc.b	%00000011,%11111111
	dc.b	%00000001,%11111111
	dc.b	%00000000,%11111111
	dc.b	%00000000,%01111111
	dc.b	%00000000,%00111111
	dc.b	%00000000,%00011111
shpm2
	dc.b	%01111111
	dc.b	%00111111
	dc.b	%00011111
	dc.b	%00001111
	dc.b	%00000011
	dc.b	%00000001
	dc.b	%00000000			 		
		
	even
piece_yp
	dc.l	136
piece_yp1
	dc.l	0
piece_yp2
	dc.l	0
piece_yp3
	dc.l	0

piece_xp
	dc.l	152
piece_xp1
	dc.l	0
piece_xp2
	dc.l	0
piece_xp3
	dc.l	0
	

pointer1a
	dc.l	0
pointer1b
	dc.l	0
pointer1c
	dc.l	0
pointer2a
	dc.l	0
pointer2b
	dc.l	0
pointer2c
	dc.l	0
pointer3
	dc.l	0
pointer4
	dc.l	0
control
	dc.w	0
control2
	dc.w	0
grid_x
	dc.l	160
grid_y
	dc.l	136	
bxy
	dc.l	0
piece_xp_old
	dc.l	0
piece_yp_old
	dc.l	0
suunta_old
	dc.b	0
	even	
moving
	dc.w	0	
old_x
	dc.b	0
old_y
	dc.b	0	
nelio
	dc.b	0
button
	dc.b	0
nappula
	dc.b	2
done
	dc.b	0
mbr
	dc.b	0
train
	dc.b	0
hint
	dc.b	0
shint
	dc.b	0
human
	dc.b	1
players
	dc.b	1
game_over
	dc.b	0
peleja
	dc.b	0
menud_players
	dc.b	0
menud_train
	dc.b	0	

	even
ball1r
	dc.l	0
ball2r
	dc.l	0
ball1
	dc.l	0
ball2
	dc.l	0
pt2
	dc.l	0	
mlkm
	dc.l	0
mlkml
	dc.l	0
mlkma
	dc.l	0
mlkmb	
	dc.l	0
ra1
	dc.l	0
ra2
	dc.l	0
ra3
	dc.l	0
ra4
	dc.l	0
ra5
	dc.l	0
rlaskuri
	dc.l	0
clock
	dc.l	0

color_cycle_pointer
	dc.l	0
color_cycle_delay
	dc.l	0
color_cycle_colours_b
	dc.w	$000c
	dc.w	$000c
	dc.w	$000d
	dc.w	$000e
	dc.w	$000e
	dc.w	$000e
	dc.w	$000d
	dc.w	$000c
color_cycle_colours_r
	dc.w	$0b00
	dc.w	$0b00
	dc.w	$0c00
	dc.w	$0d00
	dc.w	$0d00
	dc.w	$0d00
	dc.w	$0c00
	dc.w	$0b00


gfx_name
	dc.b	"graphics.library",0
	even
o6c
	dc.l	0
WBenchMsg
	dc.l	1
gfx_base
	dc.l	0
dosbase	
	dc.l	0
loflist
	dc.l	0
copinit
	dc.l	0
view
	dc.l	0
oldvbr
	dc.l	0

graflib:dc.b	'graphics.library',0
		even
	
plane_add
	dc.l	0

plane1c
	incbin	"lauta.gfx"
fonts
	incbin	"fonts.gfx"
mot
	incbin	"motitus"
	even
text
	dc.b	'   Pelaaja #1               Pelaaja #2',0
	dc.b	0
	even

text_vastustaja
	dc.b	'Vastustaja ',0
text_human1
	dc.b	'Pelaaja 1  ',0
text_human2
	dc.b	'Pelaaja 2   ',0
text_human
	dc.b	' Pelaaja    ',0
	

text_amiga1
	dc.b	'  Amiga      ',0
text_amiga2
	dc.b	'  Amigo      ',0
text_amiga
	dc.b	'  Amiga      ',0

text_pelaaja1
	dc.b	'              ',0
	
text_pelaaja2
	dc.b	'              ',0
	even		
text_siirtoa
	dc.b	'ei voi siirt',123,123,0
text_voittanut
	dc.b	'on voittanut',0

text_ratkaisit1
	dc.b	'       Ratkaisit ',0
text_ratkaisit2
	dc.b	'    siirtoteht',123,'v',123,'n!',0
text_etrat1
	dc.b	'     Et ratkaissut ',0
text_etrat2
	dc.b	'       teht',123,'v',123,123,'!',0	
text_score1
	dc.b	' 0',0
text_score2
	dc.b	' 0',0
text_blank_line
	dc.b	'                                                  ',0
	even	
score1
	dc.b	0
score2
	dc.b	0
	even		
menu_text

	dc.b	$a
	dc.b	$a
	dc.b	$a

	dc.b	'                 L-Peli',$a
	dc.b	'                 ------',$a
	dc.b	$a
	dc.b	$a
	dc.b	'         F1 = Aloita uusi peli      ',$a
	dc.b	$a 
	dc.b	'         F2 = Nollaa pisteet',$a
	dc.b	$a
	dc.b	'         F3 = Vaikeusaste: 1           ',$a
	dc.b	$a				          
	dc.b	'         F4 = Pelaajien lkm: 2',$a
	dc.b	$a
	dc.b	$a
	dc.b	'        F10 = Poistuminen ohjelmasta',$a
	dc.b	$a
	dc.b	'     --------------------------------',$a
	dc.b	$a
	dc.b	'          ',$a
	dc.b	'         DEL  = Siirron peruutus',$a
	dc.b	'         HELP = Vinkki',$a
	dc.b	'         ESC  = T',123,'m',123,' valikko',$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	'          This game is freeware',$a
	dc.b	'       Copyright 1994 Esa Piiril',123,$a 
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

	even

mask1
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$0000

mask1a
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff
	dc.w	$7fff

mask1v
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$0000

mask1av
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff



pala1

	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
	dc.w	$0000,$ffff,$ffff,$ffff
pala2

	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000
	dc.w	$0000,$ffff,$ffff,$0000

empty
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000

mask1e
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
	dc.w	$0000
			

ball
;	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$02,$20,$00,$00,$03,$E0
	DC.B	$00,$00,$00,$80,$00,$00,$07,$70
	DC.B	$00,$00,$08,$88,$01,$00,$0F,$78
	DC.B	$00,$00,$03,$84,$00,$00,$0C,$F8
	DC.B	$00,$00,$00,$04,$00,$00,$0F,$F8
	DC.B	$00,$00,$00,$04,$00,$00,$0F,$F8
	DC.B	$00,$00,$08,$0C,$00,$00,$0F,$F8
	DC.B	$00,$00,$00,$0C,$00,$00,$07,$F0
	DC.B	$00,$00,$02,$38,$00,$00,$03,$E0
	DC.B	$00,$00,$00,$F0,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00


;	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$03,$E0,$01,$C0,$02,$20
	DC.B	$00,$00,$07,$F0,$07,$70,$00,$00
	DC.B	$00,$00,$0E,$F8,$07,$70,$09,$08
	DC.B	$00,$00,$0F,$FC,$0C,$78,$00,$80
	DC.B	$00,$00,$0F,$FC,$0F,$F8,$00,$00
	DC.B	$00,$00,$0F,$FC,$0F,$F8,$00,$00
	DC.B	$00,$00,$0F,$FC,$07,$F0,$08,$08
	DC.B	$00,$00,$07,$FC,$07,$F0,$00,$00
	DC.B	$00,$00,$03,$F8,$01,$C0,$02,$20
	DC.B	$00,$00,$00,$F0,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00

maskb
;	DC.B	$00,$00
	DC.B	$00,$00,$00,$00,$00,$00
	DC.B	$03,$E0,$07,$F0,$0F,$F8,$0F,$FC
	DC.B	$0F,$FC,$0F,$FC,$0F,$FC,$07,$FC
	DC.B	$03,$F8,$00,$F0,$00,$00,$00,$00
	DC.B	$00,$00
	
savytys

;4
	DC.B	$0F,$F3,$05,$55,$0C,$C3,$0D,$DD
	DC.B	$0B,$BB,$08,$88,$03,$3C,$0D,$33
	DC.B	$0B,$B3,$0F,$DB,$0F,$F3,$0F,$F3
	DC.B	$0F,$F3,$03,$3D,$0F,$F5,$09,$53
;5
	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F6,$0A,$64

;6
	DC.B	$0F,$F5,$07,$77,$0E,$E5,$0F,$FF
	DC.B	$0D,$DD,$0A,$AA,$05,$5E,$0F,$55
	DC.B	$0D,$D5,$0F,$FD,$0F,$F5,$0F,$F5
	DC.B	$0F,$F5,$05,$5F,$0F,$F7,$0B,$75

;7

	DC.B	$0F,$F6,$08,$88,$0F,$F6,$0F,$FF
	DC.B	$0E,$EE,$0B,$BB,$06,$6F,$0F,$66
	DC.B	$0E,$E6,$0F,$FE,$0F,$F6,$0F,$F6
	DC.B	$0F,$F6,$06,$6F,$0F,$F8,$0C,$86

;8
	DC.B	$0F,$F7,$09,$99,$0F,$F7,$0F,$FF
	DC.B	$0F,$FF,$0C,$CC,$07,$7F,$0F,$77
	DC.B	$0F,$F7,$0F,$FF,$0F,$F7,$0F,$F7
	DC.B	$0F,$F7,$07,$7F,$0F,$F9,$0D,$97

;9
	DC.B	$0F,$F8,$0A,$AA,$0F,$F8,$0F,$FF
	DC.B	$0F,$FF,$0D,$DD,$08,$8F,$0F,$88
	DC.B	$0F,$F8,$0F,$FF,$0F,$F8,$0F,$F8
	DC.B	$0F,$F8,$08,$8F,$0F,$FA,$0E,$A8
;10
	DC.B	$0F,$F9,$0B,$BB,$0F,$F9,$0F,$FF
	DC.B	$0F,$FF,$0E,$EE,$09,$9F,$0F,$99
	DC.B	$0F,$F9,$0F,$FF,$0F,$F9,$0F,$F9
	DC.B	$0F,$F9,$09,$9F,$0F,$FB,$0F,$B9

;11
	DC.B	$0F,$FA,$0C,$CC,$0F,$FA,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0A,$AF,$0F,$AA
	DC.B	$0F,$FA,$0F,$FF,$0F,$FA,$0F,$FA
	DC.B	$0F,$FA,$0A,$AF,$0F,$FC,$0F,$CA
;12
	DC.B	$0F,$FB,$0D,$DD,$0F,$FB,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0B,$BF,$0F,$BB
	DC.B	$0F,$FB,$0F,$FF,$0F,$FB,$0F,$FB
	DC.B	$0F,$FB,$0B,$BF,$0F,$FD,$0F,$DB
;13

	DC.B	$0F,$FC,$0E,$EE,$0F,$FC,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0C,$CF,$0F,$CC
	DC.B	$0F,$FC,$0F,$FF,$0F,$FC,$0F,$FC
	DC.B	$0F,$FC,$0C,$CF,$0F,$FE,$0F,$EC

;13

	DC.B	$0F,$FC,$0E,$EE,$0F,$FC,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0C,$CF,$0F,$CC
	DC.B	$0F,$FC,$0F,$FF,$0F,$FC,$0F,$FC
	DC.B	$0F,$FC,$0C,$CF,$0F,$FE,$0F,$EC
;12
	DC.B	$0F,$FB,$0D,$DD,$0F,$FB,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0B,$BF,$0F,$BB
	DC.B	$0F,$FB,$0F,$FF,$0F,$FB,$0F,$FB
	DC.B	$0F,$FB,$0B,$BF,$0F,$FD,$0F,$DB
;11
	DC.B	$0F,$FA,$0C,$CC,$0F,$FA,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0A,$AF,$0F,$AA
	DC.B	$0F,$FA,$0F,$FF,$0F,$FA,$0F,$FA
	DC.B	$0F,$FA,$0A,$AF,$0F,$FC,$0F,$CA
;10
	DC.B	$0F,$F9,$0B,$BB,$0F,$F9,$0F,$FF
	DC.B	$0F,$FF,$0E,$EE,$09,$9F,$0F,$99
	DC.B	$0F,$F9,$0F,$FF,$0F,$F9,$0F,$F9
	DC.B	$0F,$F9,$09,$9F,$0F,$FB,$0F,$B9
;9
	DC.B	$0F,$F8,$0A,$AA,$0F,$F8,$0F,$FF
	DC.B	$0F,$FF,$0D,$DD,$08,$8F,$0F,$88
	DC.B	$0F,$F8,$0F,$FF,$0F,$F8,$0F,$F8
	DC.B	$0F,$F8,$08,$8F,$0F,$FA,$0E,$A8
;8
	DC.B	$0F,$F7,$09,$99,$0F,$F7,$0F,$FF
	DC.B	$0F,$FF,$0C,$CC,$07,$7F,$0F,$77
	DC.B	$0F,$F7,$0F,$FF,$0F,$F7,$0F,$F7
	DC.B	$0F,$F7,$07,$7F,$0F,$F9,$0D,$97

;7

	DC.B	$0F,$F6,$08,$88,$0F,$F6,$0F,$FF
	DC.B	$0E,$EE,$0B,$BB,$06,$6F,$0F,$66
	DC.B	$0E,$E6,$0F,$FE,$0F,$F6,$0F,$F6
	DC.B	$0F,$F6,$06,$6F,$0F,$F8,$0C,$86
;6
	DC.B	$0F,$F5,$07,$77,$0E,$E5,$0F,$FF
	DC.B	$0D,$DD,$0A,$AA,$05,$5E,$0F,$55
	DC.B	$0D,$D5,$0F,$FD,$0F,$F5,$0F,$F5
	DC.B	$0F,$F5,$05,$5F,$0F,$F7,$0B,$75

;5
	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F6,$0A,$64

;4
	DC.B	$0F,$F3,$05,$55,$0C,$C3,$0D,$DD
	DC.B	$0B,$BB,$08,$88,$03,$3C,$0D,$33
	DC.B	$0B,$B3,$0F,$DB,$0F,$F3,$0F,$F3
	DC.B	$0F,$F3,$03,$3D,$0F,$F5,$09,$53

savyja
	DC.B	$08,$80,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$00,$06,$0B,$B0,$02,$00

;10
	DC.B	$0F,$F9,$0B,$BB,$0F,$F9,$0F,$FF
	DC.B	$0F,$FF,$0E,$EE,$09,$9F,$0F,$99
	DC.B	$0F,$F9,$0F,$FF,$0F,$F9,$0F,$F9
	DC.B	$0F,$F9,$09,$9F,$0F,$FB,$0F,$B9

;11
	DC.B	$0F,$FA,$0C,$CC,$0F,$FA,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0A,$AF,$0F,$AA
	DC.B	$0F,$FA,$0F,$FF,$0F,$FA,$0F,$FA
	DC.B	$0F,$FA,$0A,$AF,$0F,$FC,$0F,$CA
;13

	DC.B	$0F,$FC,$0E,$EE,$0F,$FC,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0C,$CF,$0F,$CC
	DC.B	$0F,$FC,$0F,$FF,$0F,$FC,$0F,$FC
	DC.B	$0F,$FC,$0C,$CF,$0F,$FE,$0F,$EC
;12
	DC.B	$0F,$FB,$0D,$DD,$0F,$FB,$0F,$FF
	DC.B	$0F,$FF,$0F,$FF,$0B,$BF,$0F,$BB
	DC.B	$0F,$FB,$0F,$FF,$0F,$FB,$0F,$FB
	DC.B	$0F,$FB,$0B,$BF,$0F,$FD,$0F,$DB

;4
	DC.B	$0F,$F3,$05,$55,$0C,$C3,$0D,$DD
	DC.B	$0B,$BB,$08,$88,$03,$3C,$0D,$33
	DC.B	$0B,$B3,$0F,$DB,$0F,$F3,$0F,$F3
	DC.B	$0F,$F3,$03,$3D,$0F,$F5,$09,$53


hues
	DC.B	$00,$07,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$04,$44,$02,$22,$07,$77

	DC.B	$00,$0e,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$05,$55,$03,$33,$08,$88

	DC.B	$00,$07,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$06,$66,$04,$44,$09,$99

	DC.B	$00,$0e,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$07,$77,$05,$55,$0a,$aa

	DC.B	$00,$07,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$08,$88,$06,$66,$0b,$bb

	DC.B	$00,$0e,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$07,$77,$05,$55,$0a,$aa

	DC.B	$00,$07,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$08,$88,$06,$66,$0b,$bb

	DC.B	$00,$0e,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$06,$66,$04,$44,$09,$99

	DC.B	$00,$07,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$04,$44,$02,$22,$07,$77

	DC.B	$00,$0e,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$08,$80,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$05,$55,$03,$33,$08,$88

board
	dc.b	4,4,4,4,4,4
	dc.b	4,3,1,1,0,4
	dc.b	4,0,2,1,0,4
	dc.b	4,0,2,1,0,4
	dc.b	4,0,2,2,3,4
	dc.b	4,4,4,4,4,4
init_board
	dc.b	4,4,4,4,4,4
	dc.b	4,3,1,1,0,4
	dc.b	4,0,2,1,0,4
	dc.b	4,0,2,1,0,4
	dc.b	4,0,2,2,3,4
	dc.b	4,4,4,4,4,4
board_r
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
board_w
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board2
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board3
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board4
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board5
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board6
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board_old
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0

board_old2
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	dc.b	0,0,0,0,0,0
	
talle
	dc.l	0
sit_num
	dc.l	0
best
	dc.l	0
	even

taulukko_c
	incbin	"aivot"
taulukko_add
	dc.l	0
tal_pt
	dc.l	0
sit_best
	dc.l	0
level	
	dc.l	2
level_0
	dc.l	610,620,600,570,590
level_0d
	dc.l	500,500,500,500,700
level_1
	dc.l	505,600,500,500,600
level_2
	dc.l	450,500,500,510,700
level_3
	dc.l	100,510,500,570,700
level_4
	dc.l	0,20000,30000,40000,50000
level_base
	dc.l	0
level_rand
	dc.l	0	
level_0_text
	dc.b	'1 Helppo     ',0
level_1_text
	dc.b	'2 Norm.      ',0
level_2_text
	dc.b	'3 Hyv',123,'    ',0
level_3_text
	dc.b	'4 Vaikea     ',0
level_4_text
	dc.b	'5 Paras      ',0
level_5_text
	dc.b	'Harj.      ',0
text_peli
	dc.b	'peli           ',0
text_harj
	dc.b	'harjoitus      ',0
	

	even	

ending
	dc.b	0
ending2
	dc.b	0
key
	dc.b	0
undo
	dc.b	0
meny	
	dc.b	0
	even

history_counter
	dc.l	0
colorb1
	dc.w	$000b
colorb2
	dc.w	$0f00
colorb3
	dc.w	$0ffc
colorp1
	dc.w	$00f0
colorp2
	dc.w	$00ff
colorp3
	dc.w	$0fff

colors_menu



;----

	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F1,$02,$23,$09,$91,$0A,$AB
	DC.B	$08,$89,$05,$56,$00,$0A,$0A,$01
	DC.B	$08,$81,$0F,$A9,$0C,$C1,$0D,$D1
	DC.B	$0E,$E1,$00,$0B,$0E,$E1,$0F,$D1
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F1,$02,$33,$09,$A1,$0A,$BB
	DC.B	$08,$99,$05,$66,$00,$1A,$0A,$11
	DC.B	$08,$91,$0F,$B9,$0C,$D1,$0D,$E1
	DC.B	$0E,$F1,$00,$1B,$0E,$F1,$0F,$E1
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F1,$03,$33,$0A,$A1,$0B,$BB
	DC.B	$09,$99,$06,$66,$01,$1A,$0B,$11
	DC.B	$09,$91,$0F,$B9,$0D,$D1,$0E,$E1
	DC.B	$0F,$F1,$01,$1B,$0F,$F1,$0F,$E1
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F2,$03,$34,$0A,$A2,$0B,$BC
	DC.B	$09,$9A,$06,$67,$01,$1B,$0B,$12
	DC.B	$09,$92,$0F,$BA,$0D,$D2,$0E,$E2
	DC.B	$0F,$F2,$01,$1C,$0F,$F2,$0F,$E2
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F2,$03,$44,$0A,$B2,$0B,$CC
	DC.B	$09,$AA,$06,$77,$01,$2B,$0B,$22
	DC.B	$09,$A2,$0F,$CA,$0D,$E2,$0E,$F2
	DC.B	$0F,$F2,$01,$2C,$0F,$F2,$0F,$F2
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F2,$04,$44,$0B,$B2,$0C,$CC
	DC.B	$0A,$AA,$07,$77,$02,$2B,$0C,$22
	DC.B	$0A,$A2,$0F,$CA,$0E,$E2,$0F,$F2
	DC.B	$0F,$F2,$02,$2C,$0F,$F2,$0F,$F2
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F3,$04,$45,$0B,$B3,$0C,$CD
	DC.B	$0A,$AB,$07,$78,$02,$2C,$0C,$23
	DC.B	$0A,$A3,$0F,$CB,$0E,$E3,$0F,$F3
	DC.B	$0F,$F3,$02,$2D,$0F,$F3,$0F,$F3
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F3,$04,$55,$0B,$C3,$0C,$DD
	DC.B	$0A,$BB,$07,$88,$02,$3C,$0C,$33
	DC.B	$0A,$B3,$0F,$DB,$0E,$F3,$0F,$F3
	DC.B	$0F,$F3,$02,$3D,$0F,$F3,$0F,$F3
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F3,$05,$55,$0C,$C3,$0D,$DD
	DC.B	$0B,$BB,$08,$88,$03,$3C,$0D,$33
	DC.B	$0B,$B3,$0F,$DB,$0F,$F3,$0F,$F3
	DC.B	$0F,$F3,$03,$3D,$0F,$F3,$0F,$F3
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F4,$05,$56,$0C,$C4,$0D,$DE
	DC.B	$0B,$BC,$08,$89,$03,$3D,$0D,$34
	DC.B	$0B,$B4,$0F,$DC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$03,$3E,$0F,$F4,$0F,$F4
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F4,$05,$66,$0C,$D4,$0D,$EE
	DC.B	$0B,$CC,$08,$99,$03,$4D,$0D,$44
	DC.B	$0B,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$03,$4E,$0F,$F4,$0F,$F4
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0F,$F0,$02,$22,$09,$90,$0A,$AA
	DC.B	$08,$88,$05,$55,$00,$09,$0A,$00
	DC.B	$08,$80,$0F,$A8,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$0A,$0E,$E0,$0F,$D0

;endofback

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0F,$F0,$02,$21,$09,$90,$0A,$A9
	DC.B	$08,$87,$05,$54,$00,$08,$0A,$00
	DC.B	$08,$80,$0F,$A7,$0C,$C0,$0D,$D0
	DC.B	$0E,$E0,$00,$09,$0E,$E0,$0F,$D0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0E,$F0,$01,$21,$08,$90,$09,$A9
	DC.B	$07,$87,$04,$54,$00,$08,$09,$00
	DC.B	$07,$80,$0E,$A7,$0B,$C0,$0C,$D0
	DC.B	$0D,$E0,$00,$09,$0D,$E0,$0E,$D0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0E,$E0,$01,$11,$08,$80,$09,$99
	DC.B	$07,$77,$04,$44,$00,$08,$09,$00
	DC.B	$07,$70,$0E,$97,$0B,$B0,$0C,$C0
	DC.B	$0D,$D0,$00,$09,$0D,$D0,$0E,$C0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0E,$E0,$01,$10,$08,$80,$09,$98
	DC.B	$07,$76,$04,$43,$00,$07,$09,$00
	DC.B	$07,$70,$0E,$96,$0B,$B0,$0C,$C0
	DC.B	$0D,$D0,$00,$08,$0D,$D0,$0E,$C0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0D,$E0,$00,$10,$07,$80,$08,$98
	DC.B	$06,$76,$03,$43,$00,$07,$08,$00
	DC.B	$06,$70,$0D,$96,$0A,$B0,$0B,$C0
	DC.B	$0C,$D0,$00,$08,$0C,$D0,$0D,$C0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0D,$D0,$00,$00,$07,$70,$08,$88
	DC.B	$06,$66,$03,$33,$00,$07,$08,$00
	DC.B	$06,$60,$0D,$86,$0A,$A0,$0B,$B0
	DC.B	$0C,$C0,$00,$08,$0C,$C0,$0D,$B0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0D,$D0,$00,$00,$07,$70,$08,$87
	DC.B	$06,$65,$03,$32,$00,$06,$08,$00
	DC.B	$06,$60,$0D,$85,$0A,$A0,$0B,$B0
	DC.B	$0C,$C0,$00,$07,$0C,$C0,$0D,$B0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0C,$D0,$00,$00,$06,$70,$07,$87
	DC.B	$05,$65,$02,$32,$00,$06,$07,$00
	DC.B	$05,$60,$0C,$85,$09,$A0,$0A,$B0
	DC.B	$0B,$C0,$00,$07,$0B,$C0,$0C,$B0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0C,$C0,$00,$00,$06,$60,$07,$77
	DC.B	$05,$55,$02,$22,$00,$06,$07,$00
	DC.B	$05,$50,$0C,$75,$09,$90,$0A,$A0
	DC.B	$0B,$B0,$00,$07,$0B,$B0,$0C,$A0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0C,$C0,$00,$00,$06,$60,$07,$76
	DC.B	$05,$54,$02,$21,$00,$05,$07,$00
	DC.B	$05,$50,$0C,$74,$09,$90,$0A,$A0
	DC.B	$0B,$B0,$00,$06,$0B,$B0,$0C,$A0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0B,$C0,$00,$00,$05,$60,$06,$76
	DC.B	$04,$54,$01,$21,$00,$05,$06,$00
	DC.B	$04,$50,$0B,$74,$08,$90,$09,$A0
	DC.B	$0A,$B0,$00,$06,$0A,$B0,$0B,$A0

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0B,$B0,$00,$00,$05,$50,$06,$66
	DC.B	$04,$44,$01,$11,$00,$05,$06,$00
	DC.B	$04,$40,$0B,$64,$08,$80,$09,$90
	DC.B	$0A,$A0,$00,$06,$0A,$A0,$0B,$90

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0B,$B0,$00,$00,$05,$50,$06,$65
	DC.B	$04,$43,$01,$10,$00,$04,$06,$00
	DC.B	$04,$40,$0B,$63,$08,$80,$09,$90
	DC.B	$0A,$A0,$00,$05,$0A,$A0,$0B,$90

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0A,$A0,$00,$00,$04,$40,$05,$55
	DC.B	$03,$33,$00,$00,$00,$04,$05,$00
	DC.B	$03,$30,$0A,$53,$07,$70,$08,$80
	DC.B	$09,$90,$00,$05,$09,$90,$0A,$80

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$0A,$A0,$00,$00,$04,$40,$05,$54
	DC.B	$03,$32,$00,$00,$00,$03,$05,$00
	DC.B	$03,$30,$0A,$52,$07,$70,$08,$80
	DC.B	$09,$90,$00,$04,$09,$90,$0A,$80

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$09,$90,$00,$00,$03,$30,$04,$44
	DC.B	$02,$22,$00,$00,$00,$03,$04,$00
	DC.B	$02,$20,$09,$42,$06,$60,$07,$70
	DC.B	$08,$80,$00,$04,$08,$80,$09,$70

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$08,$80,$00,$00,$02,$20,$03,$33
	DC.B	$01,$11,$00,$00,$00,$02,$03,$00
	DC.B	$01,$10,$08,$31,$05,$50,$06,$60
	DC.B	$07,$70,$00,$03,$07,$70,$08,$60

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$07,$70,$00,$00,$01,$10,$02,$22
	DC.B	$00,$00,$00,$00,$00,$01,$02,$00
	DC.B	$00,$00,$07,$20,$04,$40,$05,$50
	DC.B	$06,$60,$00,$02,$06,$60,$07,$50

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$06,$60,$00,$00,$00,$00,$01,$11
	DC.B	$00,$00,$00,$00,$00,$00,$01,$00
	DC.B	$00,$00,$06,$10,$03,$30,$04,$40
	DC.B	$05,$50,$00,$01,$05,$50,$06,$40

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$05,$50,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$05,$00,$02,$20,$03,$30
	DC.B	$04,$40,$00,$00,$04,$40,$05,$30

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$04,$40,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$04,$00,$01,$10,$02,$20
	DC.B	$03,$30,$00,$00,$03,$30,$04,$20

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$03,$30,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$03,$00,$00,$00,$01,$10
	DC.B	$02,$20,$00,$00,$02,$20,$03,$10

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$02,$20,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$02,$00,$00,$00,$00,$00
	DC.B	$01,$10,$00,$00,$01,$10,$02,$00

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$01,$10,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$00,$00
	DC.B	$00,$00,$01,$00,$00,$00,$00,$00
	DC.B	$00,$00,$00,$00,$00,$00,$01,$00

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$00,$02,$00,$02,$00,$02,$00,$02
	DC.B	$00,$02,$00,$02,$00,$02,$00,$02
	DC.B	$00,$02,$00,$02,$00,$02,$00,$02
	DC.B	$00,$02,$00,$02,$00,$02,$00,$02

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03

	DC.B	$0F,$F4,$06,$66,$0D,$D4,$0E,$EE
	DC.B	$0C,$CC,$09,$99,$04,$4D,$0E,$44
	DC.B	$0C,$C4,$0F,$EC,$0F,$F4,$0F,$F4
	DC.B	$0F,$F4,$04,$4E,$0F,$F4,$0F,$F4
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03
	DC.B	$00,$03,$00,$03,$00,$03,$00,$03

	section	cop,data_c

copperlist:	

	dc.w	$1501,$fffe
	
	dc.w	$0100,$0000
	dc.w	$0104,$0024
	dc.w	$0102,$0000
	
	dc.w	$008e,$2c81		;diwstart
	dc.w	$0090,$2cc1		;diwstop
	dc.w	$0092,$0038		;ddfstart
	dc.w	$0094,$00d0		;ddfstop
	
	dc.w	$0106,$0c00	
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$010c,$0011
	dc.w	$01fc,$0000

	dc.w	$00a8,$0000
	dc.w	$00b8,$0000
	dc.w	$00c8,$0000
	dc.w	$00d8,$0000
	

	dc.w	$0120
sp1h	dc.w	0
	dc.w	$0122
sp1l	dc.w	0
	dc.w	$0124
sp2h	dc.w	0
	dc.w	$0126
sp2l	dc.w	0
	dc.w	$0128
sp3h	dc.w	0
	dc.w	$012a
sp3l	dc.w	0
	dc.w	$012c
sp4h	dc.w	0
	dc.w	$012e
sp4l	dc.w	0
	dc.w	$0130
sp5h	dc.w	0
	dc.w	$0132
sp5l	dc.w	0
	dc.w	$0134
sp6h	dc.w	0
	dc.w	$0136
sp6l	dc.w	0
	dc.w	$0138
sp7h	dc.w	0
	dc.w	$013a
sp7l	dc.w	0
	dc.w	$013c
sp8h	dc.w	0
	dc.w	$013e
sp8l	dc.w	0

	dc.w	$0180
color0
	dc.w	$0000
	dc.w	$0182
color1
	dc.w	$0000
	dc.w	$0184
color2
	dc.w	$0000
	dc.w	$0186
color3
	dc.w	$0000
	dc.w	$0188
color4
	dc.w	$0000
	dc.w	$018a
color5
	dc.w	$0000
	dc.w	$018c
color6
	dc.w	$0000
	dc.w	$018e
color7
	dc.w	$0000
	dc.w	$0190
color8
	dc.w	$0000
	dc.w	$0192
color9
	dc.w	$0000
	dc.w	$0194
color10
	dc.w	$0000
	dc.w	$0196
color11
	dc.w	$0000
	dc.w	$0198
color12
	dc.w	$0000
	dc.w	$019a
color13
	dc.w	$0000
	dc.w	$019c
color14
	dc.w	$0000
	dc.w	$019e
color15
	dc.w	$0000

	dc.w	$01a0
color16
	dc.w	$0000
	dc.w	$01a2
color17
	dc.w	$0000
	dc.w	$01a4
color18
	dc.w	$0000
	dc.w	$01a6
color19
	dc.w	$0000
	dc.w	$01a8
color20
	dc.w	$0000	
	dc.w	$01aa
color21
	dc.w	$0000
	dc.w	$01ac
color22
	dc.w	$0000
	dc.w	$01ae
color23
	dc.w	$0000
	dc.w	$01b0
color24
	dc.w	$0000	
	dc.w	$01b2
color25
	dc.w	$0000
	dc.w	$01b4
color26
	dc.w	$0000
	dc.w	$01b6
color27
	dc.w	$0000
	dc.w	$01b8
color28
	dc.w	$0000	
	dc.w	$01ba
color29
	dc.w	$0000
	dc.w	$01bc
color30
	dc.w	$0000
	dc.w	$01be
color31
	dc.w	$0000

	dc.w	$00e0
bp1h	dc.w	$0000
	dc.w	$00e2
bp1l	dc.w	$0000

	dc.w	$00e4
bp2h	dc.w	$0000
	dc.w	$00e6
bp2l	dc.w	$0000

	dc.w	$00e8
bp3h	dc.w	$0000
	dc.w	$00ea
bp3l	dc.w	$0000

	dc.w	$00ec
bp4h	dc.w	$0000
	dc.w	$00ee
bp4l	dc.w	$0000

	dc.w	$00f0
bp5h	dc.w	$0000
	dc.w	$00f2
bp5l	dc.w	$0000

	dc.w	$0100
bpl_con
	dc.w	$0000

	dc.w	$ffff,$fffe
	dc.w	$ffff,$fffe

	CNOP 0,8
piece4
piece2b
piece2c
piece3

sprited
	dc.b	0

	dc.b	0

	dc.b	1
	dc.b	0
	dc.w	$0000,$0000
	dc.w	$0000,$0000

	dc.l	0,0,0,0,0,0,0,0
	even

piece1a
spritey
	dc.b	100
spritex
	dc.b	120
spritesr
	dc.b	117
	dc.b	0

	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000

	dc.l	0,0,0,0,0,0,0,0
	
	CNOP 0,8
piece1b

sprite2y
	dc.b	100
sprite2x
	dc.b	128
sprite2s
	dc.b	117
	dc.b	0
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000

	dc.l	0,0,0,0,0,0,0,0,0,0

	CNOP	0,8
piece1c
sprite3y
	dc.b	100
sprite3x
	dc.b	136
sprite3s
	dc.b	134
	dc.b	0

	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000

	dc.l	0,0,0,0,0,0,0,0,0

	CNOP	0,8
spriteb
	dc.b	100
	dc.b	136
	dc.b	134
	dc.b	0
	dc.b	%00000000,%00000000
	dc.b	%00000000,%00000000

	dc.b	%00001000,%10000000
	dc.b	%00000111,%00000000

	dc.b	%00000010,%00000000
	dc.b	%00011111,%11000000

	dc.b	%00100110,%00100000
	dc.b	%00011111,%11000000

	dc.b	%00001110,%00010000
	dc.b	%00111101,%11110000

	dc.b	%00000000,%00010000
	dc.b	%00111111,%11110000

	dc.b	%00000000,%00010000
	dc.b	%00111111,%11110000

	dc.b	%00100000,%00110000
	dc.b	%00011111,%11010000

	dc.b	%00000000,%00100000
	dc.b	%00011111,%11100000

	dc.b	%00001000,%11000000
	dc.b	%00000111,%01000000

	dc.b	%00000011,%10000000
	dc.b	%00000011,%10000000

	dc.l	0,0,0,0,0,0,0,0
	
	CNOP	0,8
piece2a
spri
	dc.b	104
sprit
	dc.b	120
sprite
	dc.b	110
	dc.b	0
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000
	dc.w	$ffff,$0000

	dc.l	0,0,0,0,0,0,0,0


; Loppu hyvin - kaikki loppu

