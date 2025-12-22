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

Go={
  name="Go"
  author="Immi"
  #numexplode[1]=4
  numexplode=3
  chaingrass=1
  pics   = stein*2
  pics[1]= stein*3
  # *4
  startpic=igGo.xpm
  #startdist="AAAAAAAAAA"
  #startdist="A........A","A........A","A........A","A........A","A........A","A........A","A........A","A........A"
  startdist="A........A","AA......AA","AAA....AAA","AAAA..AAAA"
  greypic=igBrett.xpm
  toptime=80
  emptypic=igRand
  #randomgreys[1]=200
  description="A group with three territory points explodes. (Territory points appear, when a stone is completely surrounded by other stones of the same color.)"
  description[de]="Eine Gruppe mit drei Gebietspunkten explodiert. (Gebietspunkte entstehen, wenn ein Stein komplett von Steinen der gleichen Farbe umzingelt wird.)"

  <<
  stein={
    weight =
      (kind@(0, 1)==kind || kind@(0, 1)==outside) &&
      (kind@(0,-1)==kind || kind@(0,-1)==outside) &&
      (kind@( 1,0)==kind || kind@( 1,0)==outside) &&
      (kind@(-1,0)==kind || kind@(-1,0)==outside);
    switch {
      falling -> C;
      weight  -> B;
      -> A;
    };
    file=kind-stein;*
  };
  >>

  igRand={
    pics="igRand.xpm"
    <<
    igRand={
      switch {
        11111111 -> A;
        1?111111 -> C;
        111?1111 -> I;
        11111?11 -> E;
        1111111? -> B;
        111?111? -> J;
        1?111?11 -> G;
        ??11111? -> D;
        1???1111 -> K;
        111???11 -> M;
        11111??? -> F;
        ????111? -> L;
        1?????11 -> O;
        111????? -> N;
        ??111??? -> H;
        ???????? -> P;
      };
      0*
    };
    >>
  }
  stein={
    pics=igSchwarz.xpm,igWeiss.xpm,igGrau.xpm,
      igDreieckWeiss.xpm,igDreieckSchwarz.xpm
  }
}
