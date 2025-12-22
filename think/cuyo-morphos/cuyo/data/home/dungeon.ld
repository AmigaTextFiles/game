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



Dungeon = {

  farben = 5           # Zählt nur die normalen Farben
  rand = <farben>
  gold = <farben+1>
  dateien = 12         # Genauer: Dateien pro Farbe
  linksoben = 1
  rechtsoben = 2
  linksunten = 4
  rechtsunten = 8

  name = "Dungeon"
  name[de] = "Dungeon"
  author = "Mark Weyer"
  pics = Wand * <farben>
  greypic = Gold
  emptypic = Leer
  startpic = Bildschirm
  startdist = "...AAAA...","...AAAA...","...AAAA...","...AAAA..."
  numexplode = 5
  neighbours = <neighbours_eight>
  randomgreys[1] = 300
  falling_speed = 3

  bgcolor = 0,0,0
  top_color = 32,32,32

  <<
    var farbe=rand;
    var besetzt=15;         # Bitfeld mit Mauerinformation
    var xp,yp,xv,yv,xr,yr;  # p: Position.
                            # v und r: Vektor nach vorne und nach rechts

    besetzt_test = {
      # Rein: xp und yp
      # Raus: besetzt.
      # Semantik: ist diese Position besetzt?
      besetzt = besetzt@@(xp/2,yp/2).((1+(xp%2))*(1+3*(yp%2)));
    };

    besetzt_gold_test = {
      besetzt_test;
      if besetzt && farbe@@(xp/2,yp/2)==gold -> {
        # Wir können doch hin und wir räumen das Gold ab
        besetzt = 0;
        besetzt@@(xp/2,yp/2) = 0;
        bonus(20);
      };
    };

    semiglobal.init = {xp=5; yp=39; xv=0; yv=-1; xr=1; yr=0;};

    semiglobal.keyleft = {xv@@=-xr; yv@@=-yr; xr@@=xv; yr@@=yv;};
    semiglobal.keyright = {xv@@=xr; yv@@=yr; xr@@=-xv; yr@@=-yv;};

    semiglobal.keyturn = {
      xp+=xv; yp+=yv; besetzt_gold_test;
      if besetzt -> {xp-=xv; yp-=yv;};
    };

    semiglobal.keyfall = {
      xp-=xv; yp-=yv; besetzt_gold_test;
      if besetzt -> {xp+=xv; yp+=yv;};
    };
  >>

  Wand = {
    pics = mdZiegel.xpm, mdStein.xpm, mdHolz.xpm, mdFels.xpm, mdEisen.xpm
    versions = 3

    <<
      Wand.init = {
        farbe = kind-Wand;
        switch {
          version==0 -> {
            besetzt = linksoben+linksunten;
            inhibit = DIR_R+DIR_UR+DIR_DR;
          };
          version==1 -> {
            besetzt = linksoben+rechtsoben;
            inhibit = DIR_D+DIR_DR+DIR_DL;
          };
          version==2 -> {
            besetzt = rechtsoben+rechtsunten;
            inhibit = DIR_L+DIR_UL+DIR_DL;
          };
        };
      };

      Wand = {
        file = kind-Wand;
        pos = version;
        *;
      };
    >>
  }

  Gold = {
    pics = mdGold.xpm
    versions = 4
    <<
      Gold.init = {
        farbe = gold;
        switch {
          version==0 -> {besetzt = linksoben;};
          version==1 -> {besetzt = rechtsoben;};
          version==2 -> {besetzt = linksunten;};
          version==3 -> {besetzt = rechtsunten;};
        };
      };

      Gold = {
        if besetzt!=0 -> {pos=version;*;}
        else -> if loc_x!=xp@@/2 -> kind=Leer;
      };
    >>    
  }

  Leer = {<< default besetzt=0:reapply; >>}

  Bildschirm = {
    pics = mdPlastik.xpm,
      mdZiegel00.xpm, mdZiegel01.xpm, mdZiegel02.xpm, mdZiegel03.xpm,
      mdZiegel04.xpm, mdZiegel05.xpm, mdZiegel06.xpm, mdZiegel07.xpm,
      mdZiegel08.xpm, mdZiegel09.xpm, mdZiegel10.xpm, mdZiegel11.xpm,

      mdStein00.xpm, mdStein01.xpm, mdStein02.xpm, mdStein03.xpm,
      mdStein04.xpm, mdStein05.xpm, mdStein06.xpm, mdStein07.xpm,
      mdStein08.xpm, mdStein09.xpm, mdStein10.xpm, mdStein11.xpm,

      mdHolz00.xpm, mdHolz01.xpm, mdHolz02.xpm, mdHolz03.xpm,
      mdHolz04.xpm, mdHolz05.xpm, mdHolz06.xpm, mdHolz07.xpm,
      mdHolz08.xpm, mdHolz09.xpm, mdHolz10.xpm, mdHolz11.xpm,

      mdFels00.xpm, mdFels01.xpm, mdFels02.xpm, mdFels03.xpm,
      mdFels04.xpm, mdFels05.xpm, mdFels06.xpm, mdFels07.xpm,
      mdFels08.xpm, mdFels09.xpm, mdFels10.xpm, mdFels11.xpm,

      mdEisen00.xpm, mdEisen01.xpm, mdEisen02.xpm, mdEisen03.xpm,
      mdEisen04.xpm, mdEisen05.xpm, mdEisen06.xpm, mdEisen07.xpm,
      mdEisen08.xpm, mdEisen09.xpm, mdEisen10.xpm, mdEisen11.xpm,

      mdPlastik00.xpm, mdPlastik01.xpm, mdPlastik02.xpm, mdPlastik03.xpm,
      mdPlastik04.xpm, mdPlastik05.xpm, mdPlastik06.xpm, mdPlastik07.xpm,
      mdPlastik08.xpm, mdPlastik09.xpm, mdPlastik10.xpm, mdPlastik11.xpm,

      mdGold00.xpm, mdGold01.xpm, mdGold02.xpm, mdGold03.xpm,
      mdGold04.xpm, mdGold05.xpm, mdGold06.xpm, mdGold07.xpm,
      mdGold08.xpm, mdGold09.xpm, mdGold10.xpm, mdGold11.xpm,

      mdBoden00.xpm, mdBoden01.xpm, mdBoden02.xpm, mdBoden03.xpm,
      mdBoden04.xpm, mdBoden05.xpm, mdBoden06.xpm, mdBoden07.xpm,
      mdBoden08.xpm, mdBoden09.xpm, mdBoden10.xpm, mdBoden11.xpm,
      mdBoden12.xpm, mdBoden13.xpm, mdBoden14.xpm, mdBoden15.xpm
    <<
      var xx,yy;

      Bildschirm = {
        xx = (loc_x-3)%4;
        yy = loc_y%4;
        if yy>=2 -> {
          pos = xx+4*yy-8;
          file = 5+(farben+2)*dateien + xp@@%2 - 2*(yp@@%2)
            + 2*(xv@@-xr@@) + 8*(xv@@!=0);
          *;
        };
        if yy>=1 -> {
          pos=xx+4*yy-4;
          if yy<3 -> switch { # Reihe 5
            xx==0 -> {
              xp=xp@@+xv@@*5-xr@@*5; yp=yp@@+yv@@*5-yr@@*5; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+11;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+12;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
            };
            xx==1 -> {
              xp=xp@@+xv@@*5-xr@@*2; yp=yp@@+yv@@*5-yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+11;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
            };
            xx==2 -> {
              xp=xp@@+xv@@*5+xr@@*2; yp=yp@@+yv@@*5+yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+12;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
            };
            xx==3 -> {
              xp=xp@@+xv@@*5+xr@@*5; yp=yp@@+yv@@*5+yr@@*5; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+12;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+11;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+10;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
            };
          };

          switch { # Reihen 4 und 3
            xx==0 -> {
              xp=xp@@+xv@@*4-xr@@*4; yp=yp@@+yv@@*4-yr@@*4; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+9;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };

              xp=xp@@+xv@@*3-xr@@*3; yp=yp@@+yv@@*3-yr@@*3; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+5;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+6;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+7;
                *;
              };
            };
            xx==1 -> {
              xp=xp@@+xv@@*4-xr@@*2; yp=yp@@+yv@@*4-yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+9;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };

              xp=xp@@+xv@@*3-xr@@*2; yp=yp@@+yv@@*3-yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+6;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+7;
                *;
              };
              xp+=xr@@; yp+=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+5;
                *;
              };
            };
            xx==2 -> {
              xp=xp@@+xv@@*4+xr@@*2; yp=yp@@+yv@@*4+yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+9;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };

              xp=xp@@+xv@@*3+xr@@*2; yp=yp@@+yv@@*3+yr@@*2; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+7;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+6;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+5;
                *;
              };
            };
            xx==3 -> {
              xp=xp@@+xv@@*4+xr@@*4; yp=yp@@+yv@@*4+yr@@*4; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TR] *; [qu=Q_BR] *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+9;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+8;
                [qu=Q_TL] *; [qu=Q_BL] *;
              };

              xp=xp@@+xv@@*3+xr@@*3; yp=yp@@+yv@@*3+yr@@*3; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+5;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+7;
                *;
              };
              xp-=xr@@; yp-=yr@@; besetzt_test;
              if besetzt -> {
                file=farbe@@(xp/2,yp/2)*dateien+6;
                *;
              };
            };
          };
        };

        pos=xx+4*yy;
        switch { # Reihen 2 und 1
          xx==0 -> {
            xp=xp@@+xv@@*2-xr@@*2; yp=yp@@+yv@@*2-yr@@*2; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+3;
              *;
            };
            xp+=xr@@; yp+=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+4;
              *;
            };

            xp=xp@@+xv@@-xr@@; yp=yp@@+yv@@-yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+2;
              *;
            };
            xp+=xr@@; yp+=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+1;
              *;
            };
          };
          xx==1 -> {
            xp=xp@@+xv@@*2-xr@@; yp=yp@@+yv@@*2-yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+4;
              *;
            };
            xp+=xr@@; yp+=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+3;
              *;
            };

            xp=xp@@+xv@@-xr@@; yp=yp@@+yv@@-yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+2;
              *;
            };
            xp+=xr@@; yp+=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+1;
              *;
            };
          };
          xx==2 -> {
            xp=xp@@+xv@@*2+xr@@; yp=yp@@+yv@@*2+yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+4;
              *;
            };
            xp-=xr@@; yp-=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+3;
              *;
            };

            xp=xp@@+xv@@+xr@@; yp=yp@@+yv@@+yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+2;
              *;
            };
            xp-=xr@@; yp-=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+1;
              *;
            };
          };
          xx==3 -> {
            xp=xp@@+xv@@*2+xr@@*2; yp=yp@@+yv@@*2+yr@@*2; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+3;
              *;
            };
            xp-=xr@@; yp-=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+4;
              *;
            };

            xp=xp@@+xv@@+xr@@; yp=yp@@+yv@@+yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+2;
              *;
            };
            xp-=xr@@; yp-=yr@@; besetzt_test;
            if besetzt -> {
              file=farbe@@(xp/2,yp/2)*dateien+1;
              *;
            };
          };
        };

        besetzt = 15;

        # Rahmen malen
        file=0;
        qu=Q_TL;
        if kind@(-1,0)==kind
        -> if kind@(0,-1)==kind
          -> {if kind@(-1,-1)!=kind -> D*;}
          else B*
        else if kind@(0,-1)==kind
          -> C*
          else A*;
        qu=Q_TR;
        if kind@(1,0)==kind
        -> if kind@(0,-1)==kind
          -> {if kind@(1,-1)!=kind -> C*;}
          else A*
        else if kind@(0,-1)==kind
          -> D*
          else B*;
        qu=Q_BL;
        if kind@(-1,0)==kind
        -> if kind@(0,1)==kind
          -> {if kind@(-1,1)!=kind -> B*;}
          else D*
        else if kind@(0,1)==kind
          -> A*
          else C*;
        qu=Q_BR;
        if kind@(1,0)==kind
        -> if kind@(0,1)==kind
          -> {if kind@(1,1)!=kind -> A*;}
          else C*
        else if kind@(0,1)==kind
          -> B*
          else D*;
      };
    >>
  }

}

