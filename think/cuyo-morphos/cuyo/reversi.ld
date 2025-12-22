#
#   Copyright 2005 by Mark Weyer
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

Reversi={
  name = "Triversi"
  author = "Mark Weyer"
  pics = Bunt * 3, Dreh
  greypic = Grau
  startpic = mrAlle.xpm
  startdist = "DDDDDDDDDD","DDDDDDDDDD"
  numexplode = 13

  # Bits für die Richtungen. ra: alle
  ro = 1
  ror = 2
  rr = 4
  rur = 8
  ru = 16
  rul = 32
  rl = 64
  rol = 128
  ra = 255    # Faulheit

  # Bits für die Farboffsets. oa: alle
  o1 = 1
  o2 = 256
  o3 = 65536
  oa = <o1+o2+o3>

  <<
    var fa; # Ausrichtung der fallenden: 0-links 1-oben 2-rechts 3-unten
    var wr, wdx, wdy, ws, as, ns, dr;
      # Welle Richtung (Bit+Vektor), Welle Sorte, alte Sorte,
      # neue Sorte, Drehrichtung
      # Sorten: von Bunt aus
      # Drehrichtung: true=vorwärts, false=rückwärts
    var moeglich = 0:reapply, offset;
      # moeglich: In welche Richtungen sind Wellen möglich?

    initoffset = {
      switch {
        kind==Bunt   -> offset=o1;
        kind==Bunt+1 -> offset=o2;
        kind==Bunt+2 -> offset=o3;
      };
    };

    init = {
      if loc_x==4 -> fa=0 else fa=2;
      initoffset;
    };


      versuche_welle = {
          # Wird beim Landen mehrfach benutzt.
          # Rein: wr,wdx,wdy
        if moeglich@(wdx,wdy).(wr*offset) -> {
          wr@(wdx,wdy)=wr;
          wdx@(wdx,wdy)=wdx;
          wdy@(wdx,wdy)=wdy;
          ws@(wdx,wdy)=kind
        };
      };

  >>

  Bunt = {
    pics = mrAlle.xpm, mrTrenn.xpm
    <<
      Bunt = {
        pos=kind-Bunt;
        *;
        moeglich =
          (moeglich@( 0,-1) & (ro *oa)) .+
          (moeglich@( 1,-1) & (ror*oa)) .+
          (moeglich@( 1, 0) & (rr *oa)) .+
          (moeglich@( 1, 1) & (rur*oa)) .+
          (moeglich@( 0, 1) & (ru *oa)) .+
          (moeglich@(-1, 1) & (rul*oa)) .+
          (moeglich@(-1, 0) & (rl *oa)) .+
          (moeglich@(-1, 1) & (rol*oa)) .+
          (offset*ra);
        if wr!=0 -> {
          if kind!=ws -> {
            wr@(wdx,wdy)=wr;
            wdx@(wdx,wdy)=wdx;
            wdy@(wdx,wdy)=wdy;
            ws@(wdx,wdy)=ws;
            as=kind-Bunt;
            ns=((Bunt-kind)+(Bunt-ws))%3; # Die dritte Sorte:
                                          # weder kind noch ws
            dr=(ns-as)%3==1;
            kind=Dreh;
          };
          wr=0;
        };
        if falling -> {1;pos=fa+4*turn;*;};
      };

      Bunt.land = {
        if fa!=0 -> {
                       wr=rr;  wdx= 1; wdy= 0; versuche_welle;
          if fa!=1 -> {wr=rur; wdx= 1; wdy= 1; versuche_welle;};
          if fa!=3 -> {wr=ror; wdx= 1; wdy=-1; versuche_welle;};
        };
        if fa!=1 ->   {wr=ru;  wdx= 0; wdy= 1; versuche_welle;};
        if fa!=2 -> {
                       wr=rl;  wdx=-1; wdy= 0; versuche_welle;
          if fa!=1 -> {wr=rul; wdx=-1; wdy= 1; versuche_welle;};
          if fa!=3 -> {wr=rol; wdx=-1; wdy=-1; versuche_welle;};
        };
        if fa!=1 ->   {wr=ro;  wdx= 0; wdy=-1; versuche_welle;};
        wr=0;
      };

      Bunt.init = init;

      Bunt.turn = {fa=(fa+1)%4;};
    >>
  }

  Dreh = {
    neighbours = <neighbours_none>
    pics = mrAlle.xpm
    <<
      Dreh.init = {kind = Bunt+rnd(3); init;};

      Dreh = {
        {A,B,{C;kind=Bunt+ns;initoffset}}; # pos = bisherige Animationsschritte
        if dr
          -> pos = as+5+5*pos
          else pos = ns+15-5*pos;
        *;
      };
    >>
  }

  Grau = {
    pics = mrAlle.xpm
    << Grau = {E*}; >>
  }

}

