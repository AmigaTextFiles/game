#
#   Copyright 2005,2006 by Mark Weyer
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

Rechnen = {
  name = "Calculations"
  name[de] = "Rechnen"
  author = "Mark Weyer"
  pics = zahl*3
  greypic = grau
  startpic = mreGrasgrau.xpm
  startdist = "BBBBBBBBBB"
  chaingrass[hard] = 1

  zahl = {
    pics = mreZahl1.xpm,mreZahl2.xpm,mreZahl3.xpm
    <<
      var operator,operatorart;

      zahl.init = {
        if 1:3
          -> {operator = 1; operatorart=rnd(2); weight=0;}
          else {weight = rnd(11)};
      };

      zahl = {
        if operator -> {
          if ??1???1? && !operator@(1,0) && !operator@(-1,0) -> {
            kind@(1,0)=nothing;
            kind@(-1,0)=nothing;
            operator=0;
            if operatorart==0 # Addition
              -> weight=weight@(1,0)+weight@(-1,0)
              else weight=weight@(1,0)*weight@(-1,0);
          }
          else if 1???1??? && !operator@(0,1) && !operator@(0,-1) -> {
            kind@(0,1)=nothing;
            kind@(0,-1)=nothing;
            operator=0;
            if operatorart==0 # Addition
              -> weight=weight@(0,1)+weight@(0,-1)
              else weight=weight@(0,1)*weight@(0,-1);
          };
        };
        file=kind-zahl;
        switch {
          operator -> {pos=operatorart+20; *;};
          weight<10 -> {pos=1+2*weight; *;};
                    -> {
                         pos=2*((weight/10)%10); qu=Q_TL; *; qu=Q_BL; *;
                         pos=2*(weight%10);      qu=Q_TR; *; qu=Q_BR; *;
                       };
        };
      };
    >>
    numexplode = 100
  }

  grau = {
    pics=mreGrasgrau.xpm
    << grau=*; >>
  }

}
