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
#include "reversi.inc"


#declare Balken_rad = 1/6;
#declare Balken_hoch = (1/2-Balken_rad)*sqrt(4/3);

#declare Balken =
sphere_sweep {
  linear_spline  2
  <1,-Balken_hoch,0> Balken_rad
  <1,Balken_hoch,0> Balken_rad
  Textur(texture{
    pigment {rgb 0}
    finish {specular 1}})
}

#macro Drehbar() object{Balken} #end

FallDreh()

