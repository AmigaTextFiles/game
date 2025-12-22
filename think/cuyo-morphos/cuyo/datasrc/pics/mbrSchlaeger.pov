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

#include "fall_dreh.inc"
#include "breakout.inc"



#declare Schlaeger_lang = 2-1/8;
#declare Schlaeger_hoch = Schlaeger_lang*tan(pi/12);
#declare Schlaeger_Kante_rad = 1/12;

#declare Schlaeger =
  union {
    sphere_sweep {
      linear_spline 5
      <-Schlaeger_lang,0,0> Schlaeger_Kante_rad
      <0,-Schlaeger_hoch,0> Schlaeger_Kante_rad
      <Schlaeger_lang,0,0> Schlaeger_Kante_rad
      <0,Schlaeger_hoch,0> Schlaeger_Kante_rad
      <-Schlaeger_lang,0,0> Schlaeger_Kante_rad
    }
    box {
      -1 1
      scale <1/sqrt(2),1/sqrt(2),1>
      rotate 45*z
      scale <Schlaeger_lang,Schlaeger_hoch,Schlaeger_Kante_rad>
    }
    translate x
    Textur(texture {
      pigment {rgb 1}
      finish {ambient 1/2}
    })
  }

#macro Drehbar() object{Schlaeger} #end

FallDreh()

