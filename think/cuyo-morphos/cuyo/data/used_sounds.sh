#! /bin/sh

# Gibt alle Namen von Dateien aus, in im
# Verzeichnis $1/sounds liegen und in einer der Dateien
# aus $2 erwähnt werden.
# Gibt außerdem ein paar Systemsounds aus.
# Beispiel: used_sounds cuyo/sounds "summary.ld bla.ld"

cd $1/sounds

for i in *.wav *.it
do 
   if test `cd ..;cat $2 | grep -c $i` != 0
     then echo $1/sounds/$i
     else echo "Not included:" $1/sounds/$i >&2
   fi
done

echo sounds/down.wav
echo sounds/explode.wav
echo sounds/land.wav
echo sounds/leftright.wav
echo sounds/levelloose.wav
echo sounds/levelwin.wav
echo sounds/menuclick.wav
echo sounds/menuscroll.wav
echo sounds/turn.wav
echo sounds/cuyo.it

