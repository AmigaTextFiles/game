CLEAR,22000&:CLEAR,64000&

SCREEN 1,320,256,4,1
WINDOW 1,"Bois=1 Lance=10 Charrue=75 Ha.planté=1",,16,1

debut:

PALETTE 0,0,0,0
PALETTE 1,1,1,1
PALETTE 2,.86,0,0
PALETTE 3,0,.86,0
PALETTE 4,0,.46,0
PALETTE 5,.80,.66,.26
PALETTE 6,.33,.33,0
PALETTE 7,.20,.46,0
PALETTE 8,.45,.40,.13
PALETTE 9,0,0,0
PALETTE 10,0,0,.73
PALETTE 11,.86,.86,.86
PALETTE 12,.40,.40,.40
PALETTE 13,1,.93,.26
PALETTE 14,1,.40,0
PALETTE 15,1,.46,.93

GOSUB presentation
GOSUB pause

RANDOMIZE TIMER

CLOSE 1
DIM tb%(19523)
OPEN "DT01" FOR INPUT AS 1
FOR q=0 TO 19523
tb%(q)=CVI(INPUT$(2,1))
NEXT
CLOSE 1
DIM d%(62,9)
OPEN "DT02" FOR INPUT AS 1
FOR k=1 TO 9
FOR q=0 TO 62
d%(q,k)=CVI(INPUT$(2,1))
NEXT q,k
CLOSE 1
DIM vege%(14,14)
OPEN "DT03" FOR INPUT AS 1
FOR y=1 TO 14
FOR x=1 TO 14
vege%(x,y)=CVI(INPUT$(2,1))
NEXT x,y
CLOSE 1
DIM prop%(14,14)
OPEN "DT04" FOR INPUT AS 1
FOR y=1 TO 14
FOR x=1 TO 14
prop%(x,y)=CVI(INPUT$(2,1))
NEXT x,y
CLOSE 1
DIM vd%(194)
OPEN "DT05" FOR INPUT AS 1
FOR q=0 TO 194
vd%(q)=CVI(INPUT$(2,1))
NEXT
CLOSE 1
PUT(0,0),tb%,PSET
ERASE tb%
DIM j&(4,15)
FOR q=1 TO 4
j&(q,1)=10+INT(RND*41)
j&(q,3)=30+INT(RND*21)
j&(q,6)=j&(q,3)
j&(q,5)=INT(RND*11)
j&(q,12)=INT(RND*3)
READ x1%(q),x2%(q),y1%(q),y2%(q),pasx%(q),pasy%(q),vdx(q),vdy(q),j&(q,2)
NEXT

DATA 1,14,1,14,1,1,11,10,31,14,1,1,14,-1,1,191,10,32
DATA 14,1,14,1,-1,-1,191,190,32,1,14,14,1,1,-1,11,190,27

nombrejoueur:

COLOR 1,10:LOCATE 29,2:INPUT"Combien de joueurs (1 à 4) ";nj
GOSUB videligne
IF nj<1 OR nj>4 THEN GOTO nombrejoueur
FOR q=1 TO nj:j&(q,0)=1:NEXT

debutjeu:

FOR q=1 TO 4
IF j&(q,3)=0 THEN finjeu
IF j&(q,0)=0 THEN GOSUB machinejoue:GOTO finexpedition
COLOR 1,2:LOCATE 2,38:PRINT CHR$(48+q)
GOSUB arge:GOSUB surf:GOSUB habi:GOSUB bois:GOSUB lanc:GOSUB char
GOSUB inac:GOSUB buch:GOSUB pays:GOSUB gard:GOSUB guer

ventebois:
IF j&(q,4)=0 THEN achatcharrues
COLOR 1,10:LOCATE 29,2:INPUT"Combien vendez vous de bois ";rp
GOSUB videligne
IF rp<0 OR rp>j&(q,4) THEN ventebois
j&(q,4)=j&(q,4)-rp:GOSUB bois
j&(q,1)=j&(q,1)+rp:GOSUB arge

achatcharrues:

IF j&(q,1)<75 THEN deboisement
COLOR 1,10:LOCATE 29,2:INPUT"Combien achetez vous de charrue ";rp
GOSUB videligne
IF rp<0 OR rp*75>j&(q,1) THEN achatcharrues
j&(q,12)=j&(q,12)+rp:GOSUB char
j&(q,1)=j&(q,1)-rp*75:GOSUB arge

deboisement:
COLOR 1,10:LOCATE 29,2:INPUT"Combien d'Ha déboisez vous ";rp
GOSUB videligne
IF rp<0 THEN deboisement
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF rp=0 OR j&(q,6)<1 THEN cultures
IF prop%(x,y)=q THEN
  IF vege%(x,y)<7 THEN
      px=vege%(x,y)
      vege%(x,y)=7:PUT(x*15-9,y*15-9),d%(0,7),PSET
      j&(q,6)=j&(q,6)-1:GOSUB inac
      j&(q,7)=j&(q,7)+1:GOSUB buch
      j&(q,4)=j&(q,4)+px:GOSUB bois
      rp=rp-1
    END IF
END IF
NEXT x,y

cultures:
IF j&(q,1)=0 OR j&(q,6)=0 THEN achatlance
COLOR 1,10:LOCATE 29,2:INPUT"Combien d'Ha plantez vous ";rp
GOSUB videligne
IF rp<0 THEN cultures
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF rp=0 OR j&(q,6)<1 OR j&(q,1)<1 THEN achatlance
IF prop%(x,y)=q THEN
  IF vege%(x,y)=7 OR vege%(x,y)=8 THEN
      vege%(x,y)=9:PUT(x*15-9,y*15-9),d%(0,9),PSET
      j&(q,6)=j&(q,6)-1:GOSUB inac
      j&(q,8)=j&(q,8)+1:GOSUB pays
      j&(q,1)=j&(q,1)-1:GOSUB arge
      rp=rp-1
    END IF
END IF
NEXT x,y

achatlance:

IF j&(q,1)<10 THEN gardiennage
COLOR 1,10:LOCATE 29,2:INPUT"Combien achetez vous de lance ";rp
GOSUB videligne
IF rp<0 OR rp*10>j&(q,1) THEN achatlance
j&(q,5)=j&(q,5)+rp:GOSUB lanc
j&(q,1)=j&(q,1)-rp*10:GOSUB arge

gardiennage:
IF j&(q,6)=0 OR j&(q,5)=0 THEN guerriers
COLOR 1,10:LOCATE 29,2:INPUT"Combien de gardiens ";rp
GOSUB videligne
IF rp<0 OR rp>j&(q,6) OR rp>j&(q,5) THEN gardiennage
IF rp>0 THEN
      j&(q,6)=j&(q,6)-rp:GOSUB inac
      j&(q,9)=j&(q,9)+rp:GOSUB gard
      j&(q,5)=j&(q,5)-rp:GOSUB lanc
      j&(q,13)=j&(q,13)+rp
END IF

guerriers:

IF j&(q,6)=0 OR j&(q,5)=0 THEN finexpedition
COLOR 1,10:LOCATE 29,2:INPUT"Combien de guerriers ";rp
GOSUB videligne
IF rp<0 OR rp>j&(q,6) OR rp>j&(q,5) THEN guerriers
IF rp>0 THEN
      j&(q,6)=j&(q,6)-rp:GOSUB inac
      j&(q,10)=j&(q,10)+rp:GOSUB guer
      j&(q,5)=j&(q,5)-rp:GOSUB lanc
      j&(q,13)=j&(q,13)+rp
END IF

expedition:
IF j&(q,10)=0 THEN finexpedition
COLOR 1,10:LOCATE 29,2:INPUT"Quel village attaquez vous ";rp
GOSUB videligne
IF rp<0 OR rp>4 OR rp=q THEN expedition
IF rp>0 THEN
      j&(q,11)=rp
END IF
finexpedition:
finjeu:
GOSUB videligne
NEXT q

combats:

attaquant=INT(RND*4)+1
IF j&(attaquant,11)>0 THEN
      defenseurs=j&(attaquant,11)
      mortdefenseurs=INT(RND*j&(attaquant,10))
      mortattaquant=INT(RND*j&(defenseurs,9))
      j&(defenseurs,9)=j&(defenseurs,9)-mortdefenseurs
      IF j&(defenseurs,9)<0 THEN j&(defenseurs,9)=0
      j&(attaquant,10)=j&(attaquant,10)-mortattaquant
      IF j&(attaquant,10)<0 THEN j&(attaquant,10)=0
      j&(attaquant,14)=1:j&(defenseurs,15)=1
      IF j&(attaquant,10)>j&(defenseurs,9) THEN GOSUB invasion
      j&(attaquant,11)=0
END IF
FOR q=1 TO 4
IF j&(q,11)>0 THEN combats
NEXT q

recoltes:

an=an+1
WINDOW 3," INVASIONS",(223,131)-(306,214),0,1
FOR y=1 TO 14
FOR x=1 TO 14
IF prop%(x,y)<5 THEN LINE (x*6-6,y*6-6)-STEP(4,4),prop%(x,y)+11,bf
IF prop%(x,y)=50 THEN LINE (x*6-6,y*6-6)-STEP(4,4),6,bf
IF prop%(x,y)=60 THEN LINE (x*6-6,y*6-6)-STEP(4,4),10,bf
IF prop%(x,y)>9 AND prop%(x,y)<50 THEN LINE (x*6-6,y*6-6)-STEP(4,4),prop%(x,y)/10+11,bf
NEXT x,y
WINDOW OUTPUT 1
FOR q=1 TO 4
IF j&(q,3)<1 THEN finrecoltes
catastrophe:
hz=INT(RND*100):IF hz>30 THEN fincatastrophe
WINDOW 4,,(12,24)-(210,104),0,1
PRINT
COLOR 2,0:PRINT "     * CATASTROPHE *":PRINT
hz=1+INT(RND*5)
cata=0:aieaie=1
ON hz GOTO peste,sauterelles,termites,innondations,rongeurs
peste:
PRINT "la fievre jaune frappe":PRINT
PRINT "de nombreux habitants":PRINT
PRINT "du village N°";q:PRINT
FOR k=6 TO 10
mortcata=INT(RND*j&(q,k))
j&(q,k)=j&(q,k)-mortcata:cata=cata+mortcata
NEXT k
PRINT "On déplore"cata"mort";:IF cata>1 THEN PRINT "s"
GOTO fincatastrophe
sauterelles:
PRINT "Un nuage de sauterelles":PRINT
PRINT "dévore les champs de blé":PRINT
PRINT "du village N°";q:PRINT
FOR y=1 TO 14
FOR x=1 TO 14
hz=INT(RND*100)
IF vege%(x,y)=9 AND hz<50 AND prop%(x,y)=q THEN
  WINDOW OUTPUT 1
  vege%(x,y)=8:PUT(x*15-9,y*15-9),d%(0,8),PSET:cata=cata+1
END IF
NEXT x,y
WINDOW OUTPUT 4
PRINT "Il y a"cata"Ha de détruit";:IF cata>1 THEN PRINT "s"
GOTO fincatastrophe
termites:
PRINT "Les termites envahissent":PRINT
PRINT "les stock de bois":PRINT
PRINT "du village N°";q:PRINT
cata=INT(RND*j&(q,4))
j&(q,4)=j&(q,4)-cata
PRINT "On compte"cata"m³ envolé";:IF cata>1 THEN PRINT "s"
GOTO fincatastrophe
innondations:
PRINT "La riviere envahit":PRINT
PRINT "les petites maisons":PRINT
PRINT "du village N°";q:PRINT
cata=INT(RND*j&(q,12))
j&(q,12)=j&(q,12)-cata
PRINT "On perd"cata"charrue";:IF cata>1 THEN PRINT "s"
GOTO fincatastrophe
rongeurs:
PRINT "Les rats envahissent":PRINT
PRINT "les réserves de grains":PRINT
PRINT "du village N°";q:PRINT
cata=INT(RND*j&(q,1))
j&(q,1)=j&(q,1)-cata
PRINT "Perte estimée à"cata"P.O"
fincatastrophe:
j&(q,5)=j&(q,5)+j&(q,10)+j&(q,9)
j&(q,3)=0
mortcombat%=j&(q,13)-j&(q,10)-j&(q,9):j&(q,13)=0
FOR k=6 TO 10
j&(q,3)=j&(q,3)+j&(q,k):j&(q,k)=0
NEXT k
j&(q,6)=j&(q,3)
WINDOW OUTPUT 1
COLOR 1,2:LOCATE 2,38:PRINT CHR$(48+q)
GOSUB arge:GOSUB surf:GOSUB habi:GOSUB bois:GOSUB lanc:GOSUB char
GOSUB inac:GOSUB buch:GOSUB pays:GOSUB gard:GOSUB guer
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF prop%(x,y)=q THEN
   IF vege%(x,y)=9 THEN
      re%=15+INT(RND*j&(q,12))
      recolte%=recolte%+re%
      j&(q,1)=j&(q,1)+re%:GOSUB arge
    END IF
END IF
NEXT x,y

revenu=j&(q,3)*5
exedent=j&(q,1)-revenu
j&(q,1)=j&(q,1)-revenu:IF j&(q,1)<0 THEN j&(q,1)=0
GOSUB arge
IF exedent<-4 THEN
      mortfaim%=ABS(exedent/5)
      IF mortfaim%>j&(q,3) THEN mortfaim%=j&(q,3)
      GOSUB videligne:COLOR 1,10
      LOCATE 29,9:PRINT "AN"an;
      IF an<10 THEN PRINT " ";
      PRINT " C'est la famine !!!"
      j&(q,3)=j&(q,3)-mortfaim%
      GOSUB habi
      j&(q,6)=j&(q,6)-mortfaim%
      GOSUB inac
END IF
IF exedent>9 THEN
      arrivant%=exedent/10:j&(q,6)=j&(q,6)+arrivant%
      j&(q,3)=j&(q,3)+arrivant%
      GOSUB videligne:COLOR 1,10
      LOCATE 29,9:PRINT "AN"an;
      IF an<10 THEN PRINT " ";
      PRINT " Tout va bien !!!"
      GOSUB inac
      GOSUB habi
END IF

IF exedent>-10 AND exedent<10 THEN
      GOSUB videligne:COLOR 1,10
      LOCATE 29,9:PRINT "AN"an;
      IF an<10 THEN PRINT " ";
      PRINT " Ca peut aller !!!"
END IF
suite:
IF j&(q,3)<1 THEN j&(q,3)=0:PUT(vdx(q),vdy(q)),vd%,PSET
GOSUB resultat
GOSUB pause
IF aieaie=1 THEN
   WINDOW CLOSE 4
   aieaie=0
END IF
WINDOW CLOSE 2:GOSUB videligne
finrecoltes:
NEXT q
WINDOW CLOSE 3
FOR y=1 TO 14
FOR x=1 TO 14
  IF vege%(x,y)=7 THEN
      hz=1+INT(RND*6)
      vege%(x,y)=hz:PUT(x*15-9,y*15-9),d%(0,hz),PSET
    END IF
IF vege%(x,y)=8 THEN vege%(x,y)=7:PUT(x*15-9,y*15-9),d%(0,7),PSET
IF vege%(x,y)=9 THEN vege%(x,y)=8:PUT(x*15-9,y*15-9),d%(0,8),PSET
NEXT x,y
GOTO debutjeu

END

invasion:

q=attaquant:k=defenseurs
j&(q,14)=j&(q,14)+1:j&(k,15)=j&(k,15)+1
rp=1+INT(RND*(j&(q,10)-j&(k,9)))
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF prop%(x,y)=k THEN prop%(x,y)=q:rp=rp-1:j&(q,2)=j&(q,2)+1:j&(k,2)=j&(k,2)-1
IF rp=0 THEN pillage
NEXT x,y
pillage:
orpris=INT(RND*j&(k,1))
j&(k,1)=j&(k,1)-orpris
j&(q,1)=j&(q,1)+orpris
charpris=INT(RND*j&(k,12))
j&(k,12)=j&(k,12)-charpris
j&(q,12)=j&(q,12)+charpris
boispris=INT(RND*j&(k,4))
j&(k,4)=j&(k,4)-boispris
j&(q,4)=j&(q,4)+boispris
RETURN

videligne:
COLOR 1,10:LOCATE 29,2:PRINT STRING$(37," ")
RETURN

arge:
COLOR 13,2
LOCATE 4,32:PRINT STRING$(6," ")
LOCATE 4,32:PRINT USING"######";j&(q,1)
RETURN

surf:
COLOR 1,2
LOCATE 6,34:PRINT STRING$(4," ")
LOCATE 6,34:PRINT USING"####";j&(q,2)
RETURN

habi:
COLOR 1,2
LOCATE 8,34:PRINT STRING$(4," ")
LOCATE 8,34:PRINT USING"####";j&(q,3)
RETURN

bois:
COLOR 1,2
LOCATE 10,34:PRINT STRING$(4," ")
LOCATE 10,34:PRINT USING"####";j&(q,4)
RETURN

lanc:
COLOR 1,2
LOCATE 12,34:PRINT STRING$(4," ")
LOCATE 12,34:PRINT USING"####";j&(q,5)
RETURN

char:
COLOR 1,2
LOCATE 14,34:PRINT STRING$(4," ")
LOCATE 14,34:PRINT USING"####";j&(q,12)
RETURN

inac:
COLOR 15,2
LOCATE 17,34:PRINT STRING$(4," ")
LOCATE 17,34:PRINT USING"####";j&(q,6)
RETURN

buch:
COLOR 1,2
LOCATE 20,34:PRINT STRING$(4," ")
LOCATE 20,34:PRINT USING"####";j&(q,7)
RETURN

pays:
COLOR 1,2
LOCATE 22,34:PRINT STRING$(4," ")
LOCATE 22,34:PRINT USING"####";j&(q,8)
RETURN

gard:
COLOR 1,2
LOCATE 24,34:PRINT STRING$(4," ")
LOCATE 24,34:PRINT USING"####";j&(q,9)
RETURN

guer:
COLOR 1,2
LOCATE 26,34:PRINT STRING$(4," ")
LOCATE 26,34:PRINT USING"####";j&(q,10)
RETURN

resultat:
WINDOW 2,,(12,126)-(210,206),0,1
PRINT
IF j&(q,14)=1 THEN PRINT "Votre attaque a échoué":PRINT
IF j&(q,14)=2 THEN PRINT "Votre attaque a réussi":PRINT
IF j&(q,15)=1 THEN PRINT "Les envahisseurs ont fui":PRINT
IF j&(q,15)=2 THEN PRINT "Votre village a été pillé":PRINT
j&(q,14)=0:j&(q,15)=0
IF mortcombat%>0 THEN PRINT "Morts au combat   :"mortcombat%:PRINT
PRINT "Récoltes          :"recolte%:PRINT
IF mortfaim%>0 THEN PRINT "Morts de faim     :"mortfaim%
IF arrivant%>0 THEN PRINT "Nouveaux arrivants:"arrivant%
mortcombat%=0:mortfaim%=0:recolte%=0:arrivant%=0:j&(q,13)=0
RETURN

machinejoue:

COLOR 1,2:LOCATE 2,38:PRINT CHR$(48+q)
GOSUB arge:GOSUB surf:GOSUB habi:GOSUB bois:GOSUB lanc:GOSUB char
GOSUB inac:GOSUB buch:GOSUB pays:GOSUB gard:GOSUB guer
COLOR 1,10:LOCATE 29,10:PRINT "La tribu n°"q"joue !!!"
ventebois1:
IF j&(q,4)=0 THEN achatcharrues1
rp=1+INT(RND*j&(q,4))
j&(q,4)=j&(q,4)-rp:GOSUB bois
j&(q,1)=j&(q,1)+rp:GOSUB arge
achatcharrues1:
IF j&(q,1)<95 THEN deboisement1
j&(q,12)=j&(q,12)+1:GOSUB char
j&(q,1)=j&(q,1)-75:GOSUB arge
deboisement1:
rp=INT(j&(q,6)/2.5)
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF rp=0 OR j&(q,6)<1 THEN cultures1
IF prop%(x,y)=q THEN
  IF vege%(x,y)<7 THEN
      px=vege%(x,y)
      vege%(x,y)=8:PUT(x*15-9,y*15-9),d%(0,7),PSET
      j&(q,6)=j&(q,6)-1:GOSUB inac
      j&(q,7)=j&(q,7)+1:GOSUB buch
      j&(q,4)=j&(q,4)+px:GOSUB bois
      rp=rp-1
    END IF
END IF
NEXT x,y
cultures1:
IF j&(q,1)=0 OR j&(q,6)=0 THEN achatlance1
rp=INT(j&(q,6)/1.5)
IF j&(q,7)=0 THEN rp=INT((j&(q,2)-9)*.75)
FOR y=y1%(q) TO y2%(q) STEP pasy%(q)
FOR x=x1%(q) TO x2%(q) STEP pasx%(q)
IF rp=0 OR j&(q,6)<1 OR j&(q,1)<1 THEN achatlance1
IF prop%(x,y)=q THEN
  IF vege%(x,y)=7 OR vege%(x,y)=8 THEN
      vege%(x,y)=9:PUT(x*15-9,y*15-9),d%(0,9),PSET
      j&(q,6)=j&(q,6)-1:GOSUB inac
      j&(q,8)=j&(q,8)+1:GOSUB pays
      j&(q,1)=j&(q,1)-1:GOSUB arge
      rp=rp-1
    END IF
END IF
NEXT x,y
achatlance1:
rap=j&(q,6)-j&(q,5)
IF rap<1 THEN gardiennage1
FOR k=rap TO 1 STEP-1
IF j&(q,1)<10 THEN gardiennage1
j&(q,5)=j&(q,5)+1:GOSUB lanc
j&(q,1)=j&(q,1)-10:GOSUB arge
NEXT
gardiennage1:
IF j&(q,6)<1 OR j&(q,5)<1 THEN guerriers1
rp=INT(j&(q,6)/2)
IF rp>=j&(q,5) THEN rp=INT(j&(q,5)/2)
IF rp>0 THEN
      j&(q,6)=j&(q,6)-rp:GOSUB inac
      j&(q,9)=j&(q,9)+rp:GOSUB gard
      j&(q,5)=j&(q,5)-rp:GOSUB lanc
      j&(q,13)=j&(q,13)+rp
END IF
guerriers1:
IF j&(q,6)=0 OR j&(q,5)=0 THEN finexpedition1
rp=j&(q,6)
IF  rp>j&(q,5) THEN rp=j&(q,5)
IF rp>0 THEN
      j&(q,6)=j&(q,6)-rp:GOSUB inac
      j&(q,10)=j&(q,10)+rp:GOSUB guer
      j&(q,5)=j&(q,5)-rp:GOSUB lanc
      j&(q,13)=j&(q,13)+rp
END IF
expedition1:
IF j&(q,10)=0 THEN finexpedition1
rp=INT(RND*5):IF rp=q THEN expedition1
IF rp>0 AND j&(rp,2)>9 THEN j&(q,11)=rp:GOTO finexpedition1
j&(q,9)=j&(q,9)+j&(q,10):j&(q,10)=0
GOSUB gard:GOSUB guer
finexpedition1:
GOSUB pause
GOSUB videligne
RETURN

pause:

WHILE INKEY$=""
WEND
RETURN

presentation:

PAINT(0,0),7,1
COLOR 2,7
PRINT
PRINT "                TRIBUS"
PRINT "                ------"
PRINT
COLOR 13,7
PRINT "Vous êtes à la tête d'une petite tribu":PRINT
PRINT "que vous devez faire vivre...         ":PRINT
PRINT
PRINT "1 bûcheron coupera 1 hectare de forêts":PRINT
PRINT "Avec 1 piece d'or, un paysan cultivera":PRINT
PRINT "1 hectare de champ...                 ":PRINT
PRINT "L'utilisation de charrues les aidera à":PRINT
PRINT "augmenter le rendement des cultures...":PRINT
PRINT
PRINT "Voici les prix du commerçant du coin :":PRINT
PRINT "          - Bois       1 P.O":PRINT
PRINT "          - Lance     10 P.O":PRINT
PRINT "          - Charrue   75 P.O":PRINT
COLOR 0,7
PRINT "          (c) A Bonney  1988";
RETURN

REM     Terminé le lundi 28-11-88 à 1h24

REM         (c) 1988   Alain BONNEY

