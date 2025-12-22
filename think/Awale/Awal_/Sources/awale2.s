* Fichier auxiliaire pour le programme awale.c	St-Vaury le 24 Février 1991

* Déclarations devant figurer dans le fichier source C :
* extern COURT __asm aleatoire ( registre __d1 COURT );
* extern vide  __asm echanger  ( registre __a0 COURT *, registre __a1 COURT *);
* extern COURT __asm somme_graines ( registre __d1 COURT, registre __a0 COURT[12]);
* extern COURT __asm case_suivante ( registre __d0 COURT);
* extern COURT __asm semi ( registre __a0 COURT *, registre __d1 COURT );
* extern vide  __asm copie_tableau (registre __a0 COURT *, registre __a1 COURT *)

	SECTION text,code

	XDEF	_Stccpy,_echanger,_aleatoire	 ;Déclaration des points d'entrées
	XDEF	_somme_graines,_case_suivante,_semi,_copie_tableau

* Copie d'une chaîne de caractères de n caractères maxi (plus le zéro terminal)
* En entrée : adresse source dans a0, adresse destination dans a1
*	      nombre maximal de caractères dans d0
_Stccpy subq	#1,d0
00$	move.b	(a0)+,(a1)+
	dbeq	d0,00$
	clr.b	(a1)
	rts

_echanger move.w (a0),d0        ;Echange de deux mots courts
	move.w	(a1),(a0)
	move.w	d0,(a1)
	rts

* Recopie d'un tableau de graines dans un autre (optimisé)
* En entrée: adresse source dans a0, adresse destination dans a1
_copie_tableau move.l (a0)+,(a1)+   ;Copie des graines du joueur A
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+     ;Copie des graines du joueur B
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	rts

* En entrée: case dans d0, en sortie: case suivante dans d0
_case_suivante			; renvoie 0 si case == 11 sinon ++case
	cmpi.w	#11,d0
	beq.s	00$
	addq.b	#1,d0
	rts
00$	moveq	#0,d0
	rts

* détermination de la quantité des graines appartenant à l'un des joueurs
* en entrée: indice dans d1 (0 -> joueur 0, 12 -> joueur 1)
*	     adresse du tableau dans a0
_somme_graines
	move.w	d2,-(sp)    ;Sauvegarde de d2
	moveq	#5,d2	    ;Nombre de cases où a lieu le comptage
	moveq	#0,d0	    ;Init du résultat
00$	add.w	0(a0,d1.w),d0
	addq.w	#2,d1
	dbra	d2,00$
	move.w	(sp)+,d2
	rts

* Générateur de nombres aléatoires (Idée originale Léo Schwab  Amigan #7) **
* En entrée nombre maximum dans d1
* Si nombre négatif initialisation du générateur
* En sortie nombre renvoyé dans d0 (de 0 à d1-1)

_aleatoire lea	rndseed(pc),a0  ;Adresse du nombre
	tst.w	d1		;Test du nombre demandé
	ble.s	01$		;Initialisation du générateur si négatif

	move.w	(a0),d0         ;Lecture du nombre courant
	add.w	$DFF006,d0
	bhi.s	00$
	eori.w	#$5871,d0

00$	andi.l	#$FFFF,d0	;Transformation en entier court
	move.w	d0,(a0)         ;Sauvegarde du nouveau résultat
	divu	d1,d0		;Division par le nombre demandé
	swap	d0		;Garde le reste de la division
	andi.l	#$FFFF,d0	;Suppression du poids fort
	rts

01$	neg.w	d1		;Changement du signe
	move.w	d1,(a0)         ;Rangement
	moveq	#0,d0
	rts

* routine permettant le semi des graines d'une case dans le jeu
* En entrée: adresse du tableau de graines dans a0, case jouée dans d1
* En sortie: nombre de prises réalisées dans d0
_semi	move.l	d2,-(sp)        ;Sauvegarde du registre utilisé
	add.w	d1,d1		;Indice réel tableau dans d1
	move.w	d1,d2		;Case suivante dans d2
	move.w	0(a0,d1.w),d0   ;Lecture nbre de graines dans la case jouée
	beq.s	07$		;Fin de la distribution si aucune graine
	clr.w	0(a0,d1.w)      ;RAZ du nombre de graines dans la case jouée
;Distribution des graines dans les autres cases
01$	addq.b	#2,d2		;Détermination de la case suivante
	cmpi.b	#24,d2		;Dernière case dépassée ?
	bne.s	00$
	moveq	#0,d2
00$	cmp.b	d2,d1		;Case = case_jouée ?
	beq.s	01$		;Sauter la case jouée
	addq.w	#1,0(a0,d2.w)   ;Ajouter une graine à la case qui suit
	subq.w	#1,d0		;Une graine de moins à distribuer
	bne.s	01$		;Continuer tant qu'il en reste
;Détermination des prises éventuelles
;d0 est maintenant nul, il servira maintenant à compter les prises
	cmpi.b	#12,d1		;Quel est le joueur qui a joué ?
	bge.s	04$		;C'est le joueur B -> 04$
03$	cmpi.b	#10,d2		;Calcul des prises du joueur A
	ble.s	07$		;La case est au joueur lui-même !
	move.w	0(a0,d2.w),d1   ;Lecture du nombre de graines
	cmpi.b	#2,d1		;Il y a t'il 2 graines ?
	beq.s	02$		;Oui, on les prend
	cmpi.b	#3,d1		;Sinon il y en a t'il 3 ?
	bne.s	07$		;Si non, c'est terminé
02$	add.w	d1,d0		;Ajouter ces graines aux prises
	clr.w	0(a0,d2.w)      ;Les enlever du jeu
	subq.w	#2,d2		;Calcul case précédente
	bra.s	03$
04$	cmpi.b	#12,d2		;Calcul des prises du joueur B
	bge.s	07$		;La case destination lui appartient
06$	move.w	0(a0,d2.w),d1   ;Lecture du nombre de graines
	cmpi.b	#2,d1		;Il y a t'il 2 graines ?
	beq.s	05$		;Oui, on les prend
	cmpi.b	#3,d1		;Sinon il y en a t'il 3 ?
	bne.s	07$		;Si non, c'est terminé
05$	add.w	d1,d0		;Ajouter ces graines aux prises
	clr.w	0(a0,d2.w)      ;Les enlever du jeu
	subq.w	#2,d2		;Calcul case précédente
	bcc.s	06$
07$	move.l	(sp)+,d2        ;Récupérer le registre utilisé
	rts

rndseed dc.w	0	    ; variable utilisée par le générateur aléatoire

	END
