/*
    Copyright 2005 by Mark Weyer

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#declare Breite = 2*Anzahl;
#declare Hoehe = 2*Anzahl;

#include "breakout.inc"

#declare Abstand = 2+1/Anzahl;
#declare Offset = (1-Anzahl)*Abstand/2;

#macro Ball(X,Y)
  sphere {
    <X,-Y,0> 2/(2+Anzahl)
    Textur(texture {
      pigment {rgb 1}
      finish {ambient 1/2}
    })
  }
#end

#local I=0;
#while (I<Anzahl)
  #local J=0;
  #while (J<Anzahl)
    Ball(Offset+I*Abstand,Offset+J*Abstand)
    #local J=J+1;
  #end
  #local I=I+1;
#end

