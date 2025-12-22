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

#declare Animationsschritte = 4;
#declare Breite1 = 2;
#declare Hoehe = 2*Animationsschritte;

#include "reversi.inc"

#local I=0;
#while (I<AnzahlFarben)
  #local J=0;
  #while (J<Animationsschritte)
    object {
      Stein(I,WirdzuFarbe[I])
      rotate 45*J*x
      rotate 60*z
      translate (2*I+1-AnzahlFarben)*x
      translate (Animationsschritte-1-2*J)*y
    }
    #local J=J+1;
  #end
  #local I=I+1;
#end

