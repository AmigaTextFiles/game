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
#declare Hoehe=6;

#declare eps = 1e-6;

#macro FallDreh()
  #local I=0;
  #while (I<3)
    #local J=0;
    #while (J<4)
      intersection {
        object {
          Drehbar()
          rotate -I*30*z
          #if (I!=0) rotate 90*z #end
          rotate -J*90*z
        }
        box {eps-1 1-eps}
        translate (2*J-3)*x
        translate (2-2*I)*y
      }
      #local J=J+1;
    #end
    #local I=I+1;
  #end
#end

