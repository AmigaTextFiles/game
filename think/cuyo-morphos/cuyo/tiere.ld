#
#   Copyright <=2004 by Immanuel Halupczok
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


Tiere = {

  name="Tiling Animals"
  author="Immi"
  
  numexplode=6
  chaingrass=1
  
  neighbours=2
  pics=blau,gelb,gruen
  greypic=grau
  startpic=gras
  startdist="AAAAAAAAAA","AAAAAAAAAA"
  randomgreys[1]=100

  bgcolor=0,0,0
  
  bgpic=itHintergrund.xpm

  <<
  
  var po;
  
  nicht_tier = {
    po = 0;
    if loc_x % 2 == 0 -> po += 2;
    po += ((loc_y + 3 + (loc_x % 2)) % 3) * 10;
    pos = po + 1; *@(0,-1);
    pos = po + 0; [qu=Q_BR_TR] *@(-1,-0.5);
    pos = po + 5; [qu=Q_TR_BR] *@(-1,-0.5);
    pos = po + 6; *;
    pos = po + 2; [qu=Q_BL_TL] *@(1,-0.5);
    pos = po + 7; [qu=Q_TL_BL] *@(1,-0.5);
  };
  
  tier = {
    if falling -> {
	[qu = Q_BL_TL] H*;
	[qu = Q_BR_TR] H*;
	[qu = Q_TL_BL] M*;
	[qu = Q_TR_BR] M*;
    }
    else nicht_tier;
  };
  
  >>

  blau = {
    pics=itBlau.xpm
    <<
    blau=tier;
    >>    
  }

  gelb = {
    pics=itGelb.xpm
    <<
    gelb=tier;
    >>    
  }

  gruen = {
    pics=itGruen.xpm
    <<
    gruen=tier;
    >>    
  }

  grau = {
    pics=itGrau.xpm
    <<
    grau=nicht_tier;
    >>    
  }
  
  gras = {
    pics=itGras.xpm
    <<
    gras=nicht_tier;
#    gras={
#      4;
#      switch {
#        1??1?? -> switch {
#	    x % 3 == 0 -> C*;
#            -> D*;
#	  
#	loc_x % 2 == 1 -> B*;
#	-> {
#	  [qu=Q_BL_TL] A*;
#	  [qu=Q_BR_TR] A*;
#	  [qu=Q_TL_BL] C*;
#	  [qu=Q_TR_BR] C*;
#	};
#      };
#      raender;
#    };
    >>    
  }

}
