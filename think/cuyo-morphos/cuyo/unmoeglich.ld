#
#   Copyright 2002,2005 by Mark Weyer
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

Unmoeglich={
  name="impossible"
  name[de]="unmöglich"
  author="Mark Weyer"
  numexplode=7
  numexplode[easy]=5
  pics=Sorte * 3
  toppic=m6Top.xpm
  topoverlap=0
  topcolor=170,170,170
  toptime=200
  bgpic=m6Hintergrund.xpm
  startpic=m6Gras.xpm
  startdist="I.....A...","J.A...BEI.","J.BEI.CFJ.","J.CFJ.CGJ.",
            "J.CGJ.CGJ.","K.DHK.DHK."
  greypic=m6Grau.xpm
  textcolor=200,200,200
  bgcolor=0,0,0
  neighbours=<neighbours_hex6>
  randomgreys[1]=150
  randomgreys[1,easy]=-1

  Sorte={
    pics=m6Dick.xpm,m6Duenn.xpm,m6Ganzduenn.xpm
    << Sorte = {file=kind-Sorte; schemaHex8;}; >>
  }
}

