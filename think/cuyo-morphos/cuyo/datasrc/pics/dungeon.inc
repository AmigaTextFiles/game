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

#include "dungeon_boden.inc"

#declare Eigenes_Licht = 1;

#ifdef(Version)
  #declare Eigene_Kamera = 1;
#else
  #ifndef(Breite)
    #declare Breite = 6;
    #declare Hoehe = 2;
  #end
#end

#declare Hintergrund = 0;

#include "cuyopov.inc"

#declare Hoehe = 3;
#declare Ueberlappung = 0.03;

#declare N = array[12] {
  1, 2,  3, 2,  3, 2, 2,  5, 4,  5, 3, 3
};
#declare X = array[12][5] {
  {0,0,0,0,0}, {-1,1,0,0,0},
  {-2,0,2,0,0}, {-1,1,0,0,0},
  {-3,0,3,0,0}, {-2,1,0,0,0}, {-1,2,0,0,0},
  {-4,-2,0,2,4}, {-3,-1,1,3,0},
  {-5,-2,0,2,5}, {-4,-1,3,0,0}, {-3,1,4,0,0}
};
#declare Z = array[12] {
  1, 1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5
};

#declare G = array[13] {  // Der letzte Eintrag ist ein Dummy für den Boden
  4,4,4,4,3,3,3,3,3,2,2,2,0
};

#macro BlockAusWand(Wand)
  union {
    object {Wand}
    object {Wand rotate 90*y translate z}
    object {Wand rotate 180*y translate x+z}
    object {Wand rotate 270*y translate x}
  }
#end

#macro SetzBlock(X,Z)
  object {Block translate <X,0,Z> no_shadow}
#end

#macro Setze()
  #ifdef (Version)
    #local i=0;
    #while (i<N[Version])
      SetzBlock(X[Version][i],Z[Version])
      #local i=i+1;
    #end
  #else
    union {
      object {Boden translate <-1,0,-1>}
      SetzBlock(-3,0) SetzBlock(-3,-1) SetzBlock(2,0) SetzBlock(2,-1)
      union {
        SetzBlock(-1,0) SetzBlock(0,0)
        clipped_by {box {-1 1+Hoehe*y}}
      }
      rotate -90*x
    }
  #end
#end


#ifdef (Version)

  camera {
    location <1/2,Hoehe*2/3,1/2>
    right 2*x
    #switch (G[Version])
      #case (4) #local hoch=1; #local runter=1; #break
      #case (3) #local hoch=1/2; #local runter=1; #break
      #case (2) #local hoch=1/2; #local runter=1/2; #break
      #case (0) #local hoch=0; #local runter=1; #break
    #end
    up (hoch+runter)*y
    direction (hoch-runter)/2*y+z
  }

  light_source {   // Fackel in der rechten Hand
    <3/4,Hoehe*3/4,1/2>
    2
    fade_distance 2
    fade_power 2
  }

#else

  light_source {
    <-1,1,-2>*10000 2
  }

#end

