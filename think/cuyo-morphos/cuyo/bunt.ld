#
#   Copyright 2005 by Mark Weyer
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

Bunt={
  name = "Gaudy balls"
  name[de] = "Bunte Kugeln"
  author = "Mark Weyer"
  maxbasis = 16
  basis = <maxbasis>
  basis[easy] = <maxbasis/2>
  pics = unbunt * <basis>, bunt * <(basis*(basis+1))/2>, schmelz
  startpic = mbUnbunt.xpm
  startdist="----------","QQQQQQQQQQ"
  toptime=200
  topcolor=200,200,200
  numexplode=2
  neighbours=<neighbours_hex6>

  <<

    var farbe1,farbe2,unten;

    unbunt = {
      if (kind@(0,-1) == unbunt..unbunt+basis-1)
          && !(kind@(0,1) == unbunt..unbunt+basis-1) -> {
        kind@(0,0)=schmelz;
        farbe1@(0,0) = kind-unbunt;
        farbe2@(0,0) = kind@(0,-1)-unbunt;
        unten@(0,0) = 1;
        kind@(0,-1)=schmelz;
        farbe1@(0,-1) = kind-unbunt;
        farbe2@(0,-1) = kind@(0,-1)-unbunt;
        unten@(0,-1) = 0;
      };
      pos=kind-unbunt; *;
    };

    bunt = {pos=kind-bunt; *;};

    schmelz = {
      pos=farbe1+unten*maxbasis+farbe2*2*maxbasis;
      {0,1,2,{
        3;
        if unten ->
          if farbe1<=farbe2 ->
            kind@(0,0)=bunt+(farbe2*(farbe2+1))/2+farbe1
          else
            kind@(0,0)=bunt+(farbe1*(farbe1+1))/2+farbe2
        else
          kind@(0,0)=nothing;
      }};
      *;
    };

  >>

  unbunt = {
    pics = mbUnbunt.xpm
    neighbours=<neighbours_none>
    greyprob=1
  }

  bunt = {
    pics = mbBunt.xpm
    colourprob=0
  }

  schmelz = {
    pics = mbSchmelz1.xpm,mbSchmelz2.xpm,mbSchmelz3.xpm,mbSchmelz4.xpm
    neighbours=<neighbours_none>
    colourprob=0
  }
}

