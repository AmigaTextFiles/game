#
#   Copyright 2006 by Bernhard Seckinger
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

# Status: (M=Muss, S=Soll, K=Kann, F=Feature, B=Bugs)
#
# Fertig.
#
# FK Blumenbild wird nicht mehr "zitiert".

Memory={
  name="Memory"
  author="Berni"
  numexplode=2
  chaingrass=0
  pics=bmC,bmD,bmE,bmF,bmG,bmH,bmI,bmJ,bmK,bmL,bmM,bmN,bmO
  bgcolor=255,255,255
  topcolor=0,0,0
  toptime=50
  startpic=bmTisch.xpm
  startdist[1]="++++++++++","AAAAAAAAAA"
  startdist="AAAAAAAAAA"
  greypic=bmLeer
  textcolor=90,90,90
  description="Well, memory."
  description[de]="Memory halt"
  
  <<
  var zuklappen=1;
  
  ll=;
  ii=;
  
  karte={
    switch {
      falling -> {
        # Am fallen
        *
      };
      zuklappen &&
        kind@(-1,0) != outside && kind@(-1,0) != nothing &&
	kind@(-1,0) != bmTisch &&
	zuklappen@(-1,0) -> {
        # Wir sollen zuklappen, aber links von uns ist eine Karte,
	# die auch noch nicht damit angefangen. Dann warten wir noch...
        # (Lustiger Rüberklapp-effekt.)
        *
      };
      zuklappen => {
        # Grade aufgekommen oder so was.
        # Aber erst noch ein Bildchen lang normal, weil sonst die
        # Start-Karten schon beim ersten Bild leicht umklappen.
        {zuklappen=0;*}, {pos+=15;*}, 1A*, P*
      };
      1:500 => {
        # Kurz aufklappen
        P*, 1A*, {pos+=15;*},
        *,*,*,*,*,*,*,*,*,*,*,*,*,*,
        {pos+=15;*}, 1A*, P*
      };
      -> A*; # zugeklappt
    };
  };
  >>

  bmLeer={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmLeer={B;karte}; bmLeer.init=ii; bmLeer.land=ll; >>
  }
  bmC={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmC={C;karte}; bmC.init=ii; bmC.land=ll; >>
  }
  bmD={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmD={D;karte}; bmD.init=ii; bmD.land=ll; >>
  }
  bmE={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmE={E;karte}; bmE.init=ii; bmE.land=ll; >>
  }
  bmF={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmF={F;karte}; bmF.init=ii; bmF.land=ll; >>
  }
  bmG={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmG={G;karte}; bmG.init=ii; bmG.land=ll; >>
  }
  bmH={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmH={H;karte}; bmH.init=ii; bmH.land=ll; >>
  }
  bmI={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmI={I;karte}; bmI.init=ii; bmI.land=ll; >>
  }
  bmJ={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmJ={J;karte}; bmJ.init=ii; bmJ.land=ll; >>
  }
  bmK={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmK={K;karte}; bmK.init=ii; bmK.land=ll; >>
  }
  bmL={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmL={L;karte}; bmL.init=ii; bmL.land=ll; >>
  }
  bmM={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmM={M;karte}; bmM.init=ii; bmM.land=ll; >>
  }
  bmN={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmN={N;karte}; bmN.init=ii; bmN.land=ll; >>
  }
  bmO={
    pics=bmKarten.xpm,bmStrich.xpm
    << bmO={O;karte}; bmO.init=ii; bmO.land=ll; >>
  }
}
