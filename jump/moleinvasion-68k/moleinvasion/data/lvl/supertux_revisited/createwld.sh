#!/bin/sh

#entete
cat > world.wld << EOF 
<NAME=Supertux Revisited>
<NEXT=unused.lvl>
<MUSIC=music/07-La_lune_eclaire_mes_pas.ogg>
<IMAGE=gfx/ihm/taupiniere.png>

<LEVELS_DESC>

EOF
#

XINIT=50
YINIT=60

XINC=80
YINC=40

I=1
X=$XINIT
Y=$YINIT
for lvl in world1*.lvl bonus1*.lvl bonus2*.lvl
do
	cat >> world.wld << EOF
<LEVEL>
<ID=$I>
<FILE=lvl/supertux_revisited/$lvl>
<POSX=$X>
<POSY=$Y>
<MOVEUP=$(( $I - 1 ))>
<MOVEDOWN=$(( $I + 1 ))>
<MOVELEFT=$(( $I + 2 ))>
<MOVERIGHT=$(( $I + 3 ))>
</LEVEL>

EOF
	I=$(( $I + 1 ))
	Y=$(( $Y + $YINC ))
	if [ "$Y" -gt 490 ]
	then
		X=$(( $X + $XINC ))
		Y=$YINIT
	fi
done
