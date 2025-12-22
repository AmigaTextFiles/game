#
#   Copyright 2006 by Mark Weyer
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

Kacheln_azyklisch = {
  name = "Tiling IV"
  name[de] = "Parkettierung IV"
  description = "Random aperiodic tiling"
  description[de] = "Eine aperiodische Parkettierung"
  author = "Mark Weyer"

  sorten = 5
  pics = Kachel*<sorten+2>
  emptypic = Leer
  greypic = Grau
  startpic = Gras
  startdist = "AAAAAAAAAA","AAAAAAAAAA","AA++++++AA","AA++++++AA",
    "AA++++++AA","AA++++++AA","AA++++++AA","AAAAAAAAAA","AAAAAAAAAA",
    "..........","..........","..........","..........","..........",
    "..........","..........","..........","..........",".........."
  numexplode = 6
  numexplode[easy] = 4
  neighbours = <neighbours_hex6>

  <<
    var xx,yy,zz,naehe,schicht,art;
    var kante1,kante2,kante3,kante4,kante5;

    # Basiskoordinaten:
    # bx = loc_y+loc_x/2;
    # by = loc_y-(loc_x+1)/2;
    #
    # schicht = (x*x@+y*y@) / schicht@
    # x = bx-schicht
    # y = by-schicht
    # z = -schicht

    var verschiebung;

    global.init = {
      xx = rnd(10000)+3000;
      yy = rnd(10000)+3000;
      zz = rnd(10000)+3000;
      schicht = xx+yy+zz;
      verschiebung@@(;<) = 100+rnd(100);
      verschiebung@@(;>) = 100+rnd(100);
    };

    global.row_up1 = {verschiebung@@(;<)+=1;};
    global.row_down1 = {verschiebung@@(;<)-=1;};
    global.row_up2 = {verschiebung@@(;>)+=1;};
    global.row_down2 = {verschiebung@@(;>)-=1;};

    rahmen = {
      kante1 = art==2..3 || art@(-1,0.5)==2 || art@(-1,-0.5)==3;
      kante2 = art==1 || art==3 || art@(1,-0.5)==1 || art@(0,-1)==3;
      kante3 = art==1..2 || art@(1,0.5)==1 || art@(0,1)==2;
      # TL
      kante4 = art@(-1,-0.5)==1..2 || art==1 || art@(-1,-1.5)==2;
      kante5 = art@(0,-1)==1..2 || art@(1,-0.5)==1 || art==2;
      switch {
        kante1 && kante2 -> {qu=Q_BL_TL; F*;};
        kante2 -> {qu=Q_TL; C*;};
        kante1 && kante5 -> {qu=Q_BL_TL; D*;};
        kante1 -> {qu=Q_BL_TL; B*;};
        kante4 && kante5 -> {qu=Q_TL; A*;};
        kante4 -> {qu=Q_TL; E*;};
        kante5 -> {qu=Q_TL; G*;};
        art@(-1,-1.5)==3 -> {qu=Q_BL_TL; H*;};
      };
      # TR
      kante4 = art@(1,-0.5)==2..3 || art==2 || art@(0,-1)==3;
      kante5 = art@(1,-0.5)==1..2 || art@(2,0)==1 || art@(1,0.5)==2;
      switch {
        kante4 && kante2 -> {qu=Q_TR; C*;};
        kante2 -> {qu=Q_BR_TR; F*;};
        kante4 && kante3 -> {qu=Q_TR; E*;};
        kante4 -> {qu=Q_TR; G*;};
        kante5 && kante3 -> {qu=Q_BR_TR; H*;};
        kante5 -> {qu=Q_BR_TR; D*;};
        kante3 -> {qu=Q_BR_TR; B*;};
        art@(1,0.5)==3 -> {qu=Q_TR; A*;};
      };
      # BL
      kante4 =
        art@(-1,0.5)==1 || art@(-1,0.5)==3 || art==1 || art@(-1,-0.5)==3;
      kante5 = art@(0,1)==1 || art@(0,1)==3 || art@(1,0.5)==1 || art==3;
      switch {
        kante1 && kante3 -> {qu=Q_TL_BL; D*;};
        kante3 -> {qu=Q_BL; E*;};
        kante1 && kante5 -> {qu=Q_TL_BL; F*;};
        kante1 -> {qu=Q_TL_BL; H*;};
        kante4 && kante5 -> {qu=Q_BL; G*;};
        kante4 -> {qu=Q_BL; C*;};
        kante5 -> {qu=Q_BL; A*;};
        art@(-1,1.5)==2 -> {qu=Q_TL_BL; B*;};
      };
      # BR
      kante4 = art@(1,0.5)==2..3 || art@(0,1)==2 || art==3;
      kante5 =
        art@(1,0.5)==1 || art@(1,0.5)==3 || art@(2,0)==1 || art@(1,-0.5)==3;
      switch {
        kante4 && kante3 -> {qu=Q_BR; E*;};
        kante3 -> {qu=Q_TR_BR; D*;};
        kante4 && kante2 -> {qu=Q_BR; C*;};
        kante4 -> {qu=Q_BR; A*;};
        kante5 && kante2 -> {qu=Q_TR_BR; B*;};
        kante5 -> {qu=Q_TR_BR; F*;};
        kante2 -> {qu=Q_TR_BR; H*;};
        art@(1,-0.5)==2 -> {qu=Q_BR; G*;};
      };
    };

    berechne = {
      xx = loc_y+verschiebung@@+loc_x/2;
      yy = loc_y+verschiebung@@-(loc_x+1)/2;
      naehe = (xx*xx@ + yy*yy@) % schicht@;
      schicht = (xx*xx@ + yy*yy@) / schicht@;
      xx -= schicht;
      yy -= schicht;
      zz = -schicht;

      switch {
        kind@(0,1)==nothing -> art=0;
        naehe-zz@<0 -> art=1;
        naehe+xx@>=schicht@ -> art=2;
        -> art=3;
      };
    };
  >>

  Grau = {<< Grau.init = {
    kind=Kachel+sorten;
    behaviour=explodes_on_explosion+explodes_on_chain_reaction;
  }; >>}

  Gras = {<< Gras.init = {
    kind=Kachel+sorten+1;
    behaviour=explodes_on_explosion+explodes_on_chain_reaction+goalblob;
  }; >>}

  Leer = {
    pics = mkaRhombusRahmen.xpm
    <<
      Leer = {
        if ????1??? -> art=0 else berechne;
        rahmen;
      };
    >>
  }

  Kachel = {
    pics = mkaRhombusKacheln.xpm, mkaRhombusRahmen.xpm, mkaViereckFall.xpm

    <<

      Kachel.init = {
        kind=Kachel+rnd(sorten);
      };

      Kachel = {
        if falling -> {file=2; pos=kind-Kachel; *;}
        else {
          file=1;
          rahmen;

          qu=Q_ALL;
          file=0;
          pos=6*(kind-Kachel);
          switch {
            art==0 -> {file=2; pos/=6; *;};
            art==1 -> {
              [qu=Q_TL_BL] *@(-1,-0.5); [qu=Q_TR_BR] *@(-1,-0.5);
              [qu=Q_BL_TL] *@(-1,0.5); [qu=Q_BR_TR] *@(-1,0.5);
              pos+=1; *;
            };
            art==2 -> {
              pos+=3; *@(0,-1);
              pos+=2; *;
            };
            art==3 -> {
              pos+=2; *;
              pos+=2; *@(0,1);
            };
          };

          switch {
            art==0 -> inhibit = DIR_U+DIR_UR+DIR_DR+DIR_D+DIR_DL+DIR_UL;
            art==1 -> {
              inhibit = 0;
              if art@(0,-1)!=3 -> inhibit+=DIR_U;
              if art@(1,-0.5)!=1 -> inhibit+=DIR_UR;
              if art@(1,0.5)!=1 -> inhibit+=DIR_DR;
              if art@(0,1)!=2 -> inhibit+=DIR_D;
            };
            art==2 -> {
              inhibit = 0;
              if art@(1,0.5)!=1 -> inhibit+=DIR_DR;
              if art@(0,1)!=2 -> inhibit+=DIR_D;
              if art@(-1,0.5)!=2 -> inhibit+=DIR_DL;
              if art@(-1,-0.5)!=3 -> inhibit+=DIR_UL;
            };
            art==3 -> {
              inhibit = 0;
              if art@(0,-1)!=3 -> inhibit+=DIR_U;
              if art@(1,-0.5)!=1 -> inhibit+=DIR_UR;
              if art@(-1,0.5)!=2 -> inhibit+=DIR_DL;
              if art@(-1,-0.5)!=3 -> inhibit+=DIR_UL;
            };
          };

          berechne;
        };
      };
    >>
  }

}

