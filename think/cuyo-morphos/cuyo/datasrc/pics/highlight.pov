/*
    Copyright 2006 by Mark Weyer

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

#declare HighlightRad = 16;       // Immer an blatt.h anpassen :-(
#declare Farbe1 = <30,30,70>/255;   // Immer an blatt.cpp anpassen :-(
#declare Farbe2 = <50,50,120>/255;  // Immer an menueintrag.cpp anpassen :-(

#declare Rad1 = 1/2;
#declare Rad2 = HighlightRad/32;

#declare Hintergrund=0;
#declare Eigenes_Licht=1;
#declare Breite=3;
#declare Hoehe=3;

#include "cuyopov.inc"

plane {
  -z 0
  texture {pigment {
    function {min(
      sqrt(pow(max(0,abs(x)-Rad1),2)+pow(max(0,abs(y)-Rad1),2)),
      Rad2) / Rad2}
    colour_map {[1/3 rgb Farbe2] [1 rgb Farbe1]}
  }}
  finish {ambient 1}
}

