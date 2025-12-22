#! /bin/sh

# Gibt alle Namen von Bilddateien aus, in im
# Verzeichnis $1/pics liegen und in einer der Dateien
# aus $2 erwähnt werden.
# Gibt außerdem ein paar Systembildchen aus.
# Beispiel: used_images cuyo/data "summary.ld bla.ld"

cd $1/pics

# .xpm-Dateien
for i in *.xpm
do 
   if test `cd ..;cat $2 | grep -c $i` != 0
     then echo $1/pics/$i
     else echo "Not included:" $1/pics/$i >&2
   fi
done

# .xpm.gz-Dateien
for igz in *.xpm.gz
do 
   i=`echo $igz | sed 's/\\.gz\$//'`
   if test `cd ..;cat $2 | grep -c $i` != 0
     then echo $1/pics/$igz
     else echo "Not included:" $1/pics/$igz >&2
   fi
done

echo pics/font-big.xpm.gz
echo pics/explosion.xpm.gz
echo pics/dbgZiffern.xpm.gz
echo pics/pause.xpm.gz
echo pics/pktZiffern.xpm.gz
echo pics/pktZiffern2.xpm.gz
echo pics/titel.xpm.gz
echo pics/highlight.xpm.gz
echo pics/scroll.xpm.gz
echo pics/menupics.xpm.gz
echo pics/semiglobal

