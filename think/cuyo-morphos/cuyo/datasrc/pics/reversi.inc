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

#declare Dreifachlicht = 1;
#declare Hintergrund = 1;
#declare AnzahlFarben = 5;
#ifndef(Breite) #declare Breite = Breite1*AnzahlFarben; #end

#include "cuyopov.inc"



#declare Eins=<1,1,1>;

#declare Farbe = array[AnzahlFarben]
  {<1,1/3,4/5>, <1,1,1/4>, <1/3,4/5,1>, Eins*0, Eins*1/2};

#declare WirdzuFarbe = array[AnzahlFarben] {1,2,0,3,4};

#macro Stein(Oben,Unten)
  sphere {
    0 0.8
    scale <1,1,1/3>
    Textur(texture{
      pigment {
        gradient z
        colour_map {
          [0 rgb Farbe[Unten]]
          [1/2 rgb Farbe[Unten]]
          [1/2 rgb Farbe[Oben]]
          [1 rgb Farbe[Oben]]
        }
      }
      finish {
        specular 1/3
        ambient 1/3
      }})
  }
#end

