#
#   Copyright 2005,2006 by Mark Weyer
#
#   Partly based on code by (in alphabetical order) Berni, Immi, and Jela
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

Labskaus = {
  name = "Potpourri"
  name[de] = "Labskaus"
  author = "Mark Weyer (editor)"
  author[de] = "Mark Weyer (Hrsg.)"
  description = "Made of 100% recycled graphics"
  description[de] = "Das ist alles nur gek(l)aut"
  pics = ivElephant, bmG, jjJahr, Baelle, mbBunt, mpAlle
  startpic = inGras
  startdist = "**********"
  chaingrass = 1
  nogreyprob = 12
  nogreyprob[hard] = 14 # Da ist noch Gras drin

  <<
    var zeit, zeit2;    # Für jjJahr
    var drehpos;        # Für Baelle
  >>

  global = {
    <<
      global={
        zeit = (zeit + 1) % 512; # 32*4*4
        zeit2 = zeit / 32;

        drehpos = (drehpos + 1) % 12;
      };
    >>
  }

  semiglobal = {
    pics=jhBallons.xpm

    <<
      var ballon, ballon_x, ballon_y;

      semiglobal = {
        if ballon -> {
          @@(ballon_x,ballon_y)*;
          ballon_y-=1;
          ballon = ballon_y>=0;
        }
        else ->
          if 1:30 -> {ballon=1; ballon_x=rnd(10); ballon_y=20};
      };
    >>
  }

  ivElephant = {
    numexplode[1] = 9
    numexplode[2] = 6
    pics=ivElefant.xpm
    greyprob = 1

    <<
      ivElephant={
        switch {
          0?0?0?0? -> {{A,Y,a};*;};
          0?1?0?0? -> {{B,U,W};*;};
          1?1?1?0? -> {{J,R,T};*;};
          1?0?0?0? -> {{M,Q,S};*;};
          1?1?0?1? -> {{O,V,X};*;};
          -> schema16;
        };
      };
    >>
  }

  bmG = {
    numexplode = 2
    pics=bmKarten.xpm,bmStrich.xpm
    greyprob = 1

    <<
      var zuklappen=1;

      bmG={
        switch {
          falling -> G*;
          zuklappen => {
            # Grade aufgekommen oder so was.
            # Aber erst noch ein Bildchen lang normal, weil sonst die
            # Start-Karten schon beim ersten Bild leicht umklappen.
            {zuklappen=0;G*}, V*, 1A*, P*
          };
          1:70 => {
            # Kurz aufklappen
            P*, 1A*, V*,
            G*,G*,G*,G*,G*,G*,G*,G*,G*,G*,G*,G*,G*,G*,
            V*, 1A*, P*
          };
          -> A*; # zugeklappt
        };
      };
    >>
  }

  jjJahr = {
    numexplode[1] = 7
    numexplode[2] = 4
    pics=jjWinter1.xpm,jjWinter2.xpm,jjWinter3.xpm,jjWinter4.xpm,
         jjFruehling1.xpm,jjFruehling2.xpm,jjFruehling3.xpm,jjFruehling4.xpm,
         jjSommer1.xpm,jjSommer2.xpm,jjSommer3.xpm,jjSommer4.xpm,
         jjHerbst1.xpm,jjHerbst2.xpm,jjHerbst3.xpm,jjHerbst4.xpm
    greyprob = 1

    <<
      jjJahr={file=zeit2@;schema16;};
    >>
  }

  Baelle = {
    numexplode = 4
    pics=ibBaelle.xpm,ibBaelle2.xpm
    greyprob = 1

    <<
      Baelle={schema16;pos=drehpos@;1*};
    >>    
  }

  mbBunt = {
    numexplode=2
    pics=mbBunt.xpm
    greyprob = 1

    <<
      mbBunt={pos=37;*};
    >>
  }

  mpAlle = {
    pics = mpAlle.xpm
    numexplode = 9
    greyprob = 1

    <<mpAlle = schema5;>>
  }

  inGras = {
    pics="inGras.xpm"
    greyprob[hard] = 1
    colourprob[hard] = 1
    versions = 4

    <<
      var li, re;
    
      inGras={
        li = ??????1? || loc_x == 0;
        re = ??1????? || loc_x == 9;
        switch {
          li && re -> {pos=version + 1; *; pos=version+7; @(0,1)*};
          re -> {A*; G@(0,1)*;};
          li -> {F*; L@(0,1)*;};
          -> {
            [qu=Q_TL] A*;
            [qu=Q_BL] A*;
            [qu=Q_TL] G@(0,1)*;
            [qu=Q_TR] F*;
            [qu=Q_BR] F*;
            [qu=Q_TR] L@(0,1)*;
          };
        }
      };
    >>
  }

}

