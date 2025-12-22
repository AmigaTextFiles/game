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

#declare Breite=8;
#declare Hoehe=2;

#include "breakout.inc"

#declare Rad = 1/4;
#declare Ecke = 1-Rad;

#macro Stein(X,Farbe)
  union{
    sphere_sweep {
      linear_spline 5
      < Ecke, Ecke,0> Rad
      < Ecke,-Ecke,0> Rad
      <-Ecke,-Ecke,0> Rad
      <-Ecke, Ecke,0> Rad
      < Ecke, Ecke,0> Rad
    }
    box {<-Ecke,-Ecke,-Rad> <Ecke,Ecke,1>}
    translate (X*2-3)*x
    Textur(texture {
      pigment {rgb Farbe}
      finish {ambient 1/2}
    })
  }
#end

Stein(1,y+z)
Stein(2,x+y)
Stein(3,1)

