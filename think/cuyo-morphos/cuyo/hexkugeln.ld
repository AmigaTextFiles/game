#
#   Copyright <=2004 by Immanuel Halupczok
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

HexKugeln={
  name="Balls & Rods"
  name[de]="Kugeln und Stangen"
  author="Immi"
  numexplode=5
  chaingrass=1
  pics=i6Weiss.xpm,i6Gelb.xpm,i6Rot.xpm,i6Blau.xpm,i6Lila.xpm
  bgcolor=200,200,155
  bgpic=i6Hintergrund.xpm
  topcolor=0,0,0
  toppic=i6Oben.xpm
  topoverlap=13
  toptime=50
  startpic=i6Gross
  startdist="..B.ABC...",".ABCABC...",".ABC-B-..."
  startdist[1]="..........","C.........","C.B.ABC.B.","-ABCABCABC","-ABC-B-ABC"
  greypic=i6Grau.xpm
  textcolor=0,100,0
  neighbours=2
  randomgreys[1]=100
  description="Most dense packing of spheres"
  description[de]="Dichteste Kugelpackung"
  <<
  i6Weiss=schemaHex8;
  i6Gelb=schemaHex8;
  i6Rot=schemaHex8;
  i6Blau=schemaHex8;
  i6Lila=schemaHex8;
  i6Gross={file=version;switch {
    0??1??->A;
    1??1??->B;
    1??0??->C;
    0??0??->D;
  };*};
  >>
  i6Gross={
    pics=i6Gross1.xpm,i6Gross2.xpm,i6Gross3.xpm
  }
}

