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



BreakOut = {
  name="Breakout"
  author="Mark Weyer"
  numexplode=2
  chaingrass=1
  neighbours=<neighbours_none>   # Verbindungen? Wer braucht Verbindungen?
  mirror=1
  pics = schlaeger, stuetze
  greypic = inGelb.xpm
  startpic = gras
  startdist = "B........B","BB......BB","BBB....BBB","AAA....AAA","BBBB..BBBB","BBBB..BBBB","BBBB..BBBB","AAAA..AAAA","CCCC..CCCC","CCCC..CCCC","CCCC..CCCC","BBBBBBBBBB","BDDDDDDDDB","BDDDDDDDDB","BDDDDDDDDB","BBBBBBBBBB"
  bgcolor = 0,0,0
  textcolor = 255,255,0
  toptime = 10000

  pixel_gitter = 1
  blop_gitter = <32*pixel_gitter>
  ball_pro_blop = 4
  ball_pro_blop[hard] = 2
  ball_gitter = <blop_gitter/ball_pro_blop>


#
# Koordinatensysteme (alles durcheinander wegen mirror=1):
#
# loc_x/loc_y im Feld:       Ursprung rechts oben
#
# loc_x/loc_y im Schläger:   Ursprung links unten
# loc_xx/loc_yy im Schläger: Ursprung links unten, linke untere Ecke des Blops
# @@(x,y):                   Ursprung links unten
#
# @(x,y):                    nach rechts unten (entspricht Ursprung links oben)
#
#
# Level-intern:              Ursprung links unten
#
# ball_x/ball_y: in (1/ballpro_blop) Blops
# xx/yy:         in Pixeln
#
# ball_richt:    in 30-Grad-Schritten im Uhrzeigersinn, 1=nach oben
#
# spiegel_richt: in 15-Grad-Schritten im Uhrzeigersinn, 0=Normale nach oben,
#                also ball_richt=7 wird zu ball_richt=1
#
# schlaeger_richt: im Fall: welcher Teil (0-links, 1-oben 2-rechts, 3-unten)
#                  in semiglobal: wie spiegel_richt,
#                  bezieht sich auf die Kante 1-2 von schlaeger_xn/schlaeger_yn
#


  <<
    var ball_x,ball_y,ball_richt;
               # Richtung: 1=nach oben und dann in Zwölfteln im Uhrzeigersinn
               #           0: Ball ist draußen
    var schlaeger_richt;
               # Ausrichtung: 0=nach rechts, dann im Uhrzeigersinn
               #   (gibt den Teil des Falls an)
               # Im semiglobal-blop: nur 0 oder 1
               #   (Äquivalenzklassen waagerecht/senkrecht)
    var straf_x = -1;
    var schlaeger_da = 0;
    var schlaeger_x1, schlaeger_y1, schlaeger_x2, schlaeger_y2,
        schlaeger_x3, schlaeger_y3, schlaeger_x4, schlaeger_y4,
        schlaeger_xx, schlaeger_yy, schlaeger_xx_alt, schlaeger_yy_alt,
        schlaeger_xx_zaehler, schlaeger_yy_zaehler, schlaeger_xxyy_nenner,
        schlaeger_dxx, schlaeger_dyy,
        spiegel_xx0_zaehler, spiegel_yy0_zaehler, spiegel_xxyy0_nenner,
        spiegel_dxx, spiegel_dyy,
        spiegel_richt, spiegel_schlaeger, spiegel_stein,
        spiegel_stein_x, spiegel_stein_y,
        ball_xx_zaehler, ball_yy_zaehler, ball_xxyy_nenner, ball_dxx, ball_dyy,
        t_max_zaehler, t_max_nenner,
        t_zaehler, t_nenner, u_zaehler, u_nenner,
        erstes_t_zaehler, erstes_t_nenner,
        erstes_richt, erstes_schlaeger, erstes_stein,
        erstes_stein_x, erstes_stein_y;
               # *_richt*: In 15 Grad Schritten im Uhrzeigersinn,
               #   dabei 0: waagerecht, mit Innerem unten
               # *_stein: Stein in der Umgebung: 1=oben, dann im Uhrzeigersinn
    var mal_x, mal_y;
    var frei=1:reapply, farbe;
    var getroffen;  # Wurde Gras/Schläger vom Ball getroffen
                    # Im semiglobal: war der Schläger gerade eben schon dran?
                    #   (Bei Rundungsfehlern zwischen zwei Zeitschritten
                    #   könnte es passieren, daß der Ball im Innern des
                    #   grad-eben-noch vorhandenen Schlägers starten.
                    #   Deshalb sind zwei aufeinanderfolgende Schläger-
                    #   Berührungen ohne Balllaufzeit verboten.)
    var rueckpass;
        # Wie oft hintereinander war der Ball am Schläger und sonst nirgends??
    var ggT;
    var hilf1,hilf2;

  >>

  semiglobal = {
    pics = mbrBall4.xpm
    pics[hard] = mbrBall2.xpm
    <<

      spiegel = {
        # rein-Argumente:
        #   ball_xx, ball_yy : Koordinaten des Balls
        #   ball_dxx, ball_dyy : Differenz bis zum Ende der Bewegung
        #       Da ist ggf. schon die Korrektur
        #       schlaeger_xxyy_alt-schlaeger_xxyy
        #       für bewegliche Spiegel drin
        #   t_max_zaehler, t_max_nenner : als Bruch die restliche
        #       Laufzeit des Balls im aktuellen Zeitschritt
        #   spiegel_xx0, spiegel_yy0 : Koordinaten eines Endes des Spiegels
        #   spiegel_dxx, spiegel_dyy : Differenz zum anderen Ende
        #   spiegel_richt
        #   spiegel_schlaeger : ist der Spiegel Teil des Schlägers?
        #   spiegel_stein : ist der Spiegel Teil eines Steins?
        #   spiegel_stein_x, spiegel_stein_y : wenn ja, welches
        #
        # rein-und-raus-Argumente:
        #   erstes_t_zaehler, erstes_t_nenner: als Bruch das kleinste t,
        #       so daß der Ball nach Anteil t von ball_dxxyy einen Spiegel trifft
        #   erstes_richt: spiegel_richt dieses Spiegels
        #   erstes_schlaeger: spiegel_schlaeger dieses Spiegels
        #   erstes_stein, erstes_stein_x, erstes_stein_y: entsprechend


        # Wir rechnen t und u so aus, daß
        #   ball_xxyy + t*ball_dxxyy = spiegel_xxyy0 + u*spiegel_dxxyy
        # Das sind die Schnittparameter von Ball-Bahn und Spiegel-Linie

        # Genauer: t*D = (spiegel_yy0-ball_yy) * spiegel_dxx
        #              - (spiegel_xx0-ball_xx) * spiegel_dyy
        #          u*D = (spiegel_yy0-ball_yy) * ball_dxx
        #              - (spiegel_xx0-ball_xx) * ball_dyy
        #      mit   D = ball_dyy*spiegel_dxx - ball_dxx*spiegel_dyy

        if (!spiegel_stein || (!frei@@(spiegel_stein_x,spiegel_stein_y) &&
            spiegel_stein_x == 0..9 && spiegel_stein_y == 0..19))
          # Ein Stein spiegelt nur, wenn er auch da ist
            && ball_dxx*spiegel_dyy-ball_dyy*spiegel_dxx > 0
          # Bewegt sich Ball auf Spiegel zu?
            -> {

          hilf1 = spiegel_yy0_zaehler*ball_xxyy_nenner
            - ball_yy_zaehler*spiegel_xxyy0_nenner;
          hilf2 = spiegel_xx0_zaehler*ball_xxyy_nenner
            - ball_xx_zaehler*spiegel_xxyy0_nenner;

          ggT = gcd(spiegel_dxx,spiegel_dyy);
          t_zaehler = hilf1*(spiegel_dxx/ggT) - hilf2*(spiegel_dyy/ggT);
          t_nenner = (ball_dyy*(spiegel_dxx/ggT) - ball_dxx*(spiegel_dyy/ggT))
            * ball_xxyy_nenner * spiegel_xxyy0_nenner;
          ggT = gcd(t_zaehler,t_nenner);
          t_zaehler /= ggT;
          t_nenner /= ggT;
          if t_nenner<0 -> {
            t_zaehler = -t_zaehler;
            t_nenner = -t_nenner;
          };

          ggT = gcd(ball_dxx,ball_dyy);
          u_zaehler = hilf1*(ball_dxx/ggT) - hilf2*(ball_dyy/ggT);
          u_nenner = ((ball_dyy/ggT)*spiegel_dxx-(ball_dxx/ggT)*spiegel_dyy)
            * ball_xxyy_nenner * spiegel_xxyy0_nenner;
          ggT = gcd(u_zaehler,u_nenner);
          u_zaehler /= ggT;
          u_nenner /= ggT;
          if u_nenner<0 -> {
            u_zaehler = -u_zaehler;
            u_nenner = -u_nenner;
          };

          if 0 < t_zaehler
              && t_zaehler*t_max_nenner <= t_max_zaehler*t_nenner
              && u_zaehler == 0..u_nenner
              && t_zaehler*erstes_t_nenner <= erstes_t_zaehler*t_nenner
              # Übersetzung: 0<t<=t_max, 0<=u<1, t<=erstes_t
              -> {
            erstes_t_zaehler = t_zaehler;
            erstes_t_nenner = t_nenner;
            erstes_richt = spiegel_richt;
            erstes_schlaeger = spiegel_schlaeger;
            erstes_stein = spiegel_stein;
            erstes_stein_x = spiegel_stein_x;
            erstes_stein_y = spiegel_stein_y;
          };
        };
      };


      ball_richtung = {
        switch {
          ball_richt==1 ->  {ball_dxx=0;  ball_dyy=2};
          ball_richt==2 ->  {ball_dxx=1;  ball_dyy=2};
          ball_richt==3 ->  {ball_dxx=2;  ball_dyy=1};
          ball_richt==4 ->  {ball_dxx=2;  ball_dyy=0};
          ball_richt==5 ->  {ball_dxx=2;  ball_dyy=-1};
          ball_richt==6 ->  {ball_dxx=1;  ball_dyy=-2};
          ball_richt==7 ->  {ball_dxx=0;  ball_dyy=-2};
          ball_richt==8 ->  {ball_dxx=-1; ball_dyy=-2};
          ball_richt==9 ->  {ball_dxx=-2; ball_dyy=-1};
          ball_richt==10 -> {ball_dxx=-2; ball_dyy=0};
          ball_richt==11 -> {ball_dxx=-2; ball_dyy=1};
          ball_richt==12 -> {ball_dxx=-1; ball_dyy=2};
        };
        ball_dxx *= ball_gitter;
        ball_dyy *= ball_gitter;
      };


      kein_spiegel = {
        erstes_t_zaehler = t_max_zaehler;
        erstes_t_nenner = t_max_nenner;
      };


      spiegel_alle = {
        erstes_t_zaehler = 2;
        erstes_t_nenner = 1;
        erstes_richt = -1;

        ## Globale Wände

        spiegel_schlaeger = 0;
        spiegel_stein = 0;
        spiegel_xxyy0_nenner = 1;

        spiegel_xx0_zaehler = 10*blop_gitter;
        spiegel_yy0_zaehler = 0;
        spiegel_dxx = 0;
        spiegel_dyy = 20*blop_gitter;
        spiegel_richt = 18;
        spiegel;

        spiegel_xx0_zaehler = 10*blop_gitter;
        spiegel_yy0_zaehler = 20*blop_gitter;
        spiegel_dxx = -10*blop_gitter;
        spiegel_dyy = 0;
        spiegel_richt = 12;
        spiegel;

        spiegel_xx0_zaehler = 0;
        spiegel_yy0_zaehler = 20*blop_gitter;
        spiegel_dxx = 0;
        spiegel_dyy = -20*blop_gitter;
        spiegel_richt = 6;
        spiegel;



        ## Steine

        spiegel_stein=1;
        spiegel_stein_x = ball_x/ball_pro_blop+1;
        spiegel_stein_y = ball_y/ball_pro_blop-1;
        spiegel_xx0_zaehler = spiegel_stein_x*blop_gitter;
        spiegel_yy0_zaehler = (spiegel_stein_y+1)*blop_gitter;

        # unten
        spiegel_dxx = blop_gitter;
        spiegel_dyy = 0;
        spiegel_richt = 0;

        spiegel;
        spiegel_stein_x-=1;
        spiegel_xx0_zaehler-=blop_gitter;
        spiegel;
        spiegel_stein_x-=1;
        spiegel_xx0_zaehler-=blop_gitter;
        spiegel;

        # links
        spiegel_xx0_zaehler+=blop_gitter;
        spiegel_dxx = 0;
        spiegel_dyy = -blop_gitter;
        spiegel_richt = 6;

        spiegel;
        spiegel_stein_y+=1;
        spiegel_yy0_zaehler+=blop_gitter;
        spiegel;
        spiegel_stein_y+=1;
        spiegel_yy0_zaehler+=blop_gitter;
        spiegel;

        # oben
        spiegel_yy0_zaehler-=blop_gitter;
        spiegel_dxx = -blop_gitter;
        spiegel_dyy = 0;
        spiegel_richt = 12;

        spiegel;
        spiegel_stein_x+=1;
        spiegel_xx0_zaehler+=blop_gitter;
        spiegel;
        spiegel_stein_x+=1;
        spiegel_xx0_zaehler+=blop_gitter;
        spiegel;

        # rechts
        spiegel_xx0_zaehler-=blop_gitter;
        spiegel_dxx = 0;
        spiegel_dyy = blop_gitter;
        spiegel_richt = 18;

        spiegel;
        spiegel_stein_y-=1;
        spiegel_yy0_zaehler-=blop_gitter;
        spiegel;
        spiegel_stein_y-=1;
        spiegel_yy0_zaehler-=blop_gitter;
        spiegel;

        spiegel_stein=0;



        ## Schläger

        if schlaeger_da && !getroffen -> {

          # Der Schläger bewegt sich auch - daher brauchen wir einen
          # Korrekturterm für ball_dxxyy und spiegel_xxyy0

          spiegel_schlaeger = 1;
          ball_dxx -= schlaeger_dxx;
          ball_dyy -= schlaeger_dyy;
          spiegel_xxyy0_nenner = schlaeger_xxyy_nenner;

          if ball_dxx!=0 || ball_dyy!=0 -> {
            spiegel_xx0_zaehler = schlaeger_xx_zaehler +
              (schlaeger_x1-schlaeger_xx)*schlaeger_xxyy_nenner;
            spiegel_yy0_zaehler = schlaeger_yy_zaehler +
              (schlaeger_y1-schlaeger_yy)*schlaeger_xxyy_nenner;
            spiegel_dxx = schlaeger_x2-schlaeger_x1;
            spiegel_dyy = schlaeger_y2-schlaeger_y1;
            spiegel_richt = schlaeger_richt;
            spiegel;

            spiegel_xx0_zaehler = schlaeger_xx_zaehler +
              (schlaeger_x2-schlaeger_xx)*schlaeger_xxyy_nenner;
            spiegel_yy0_zaehler = schlaeger_yy_zaehler +
              (schlaeger_y2-schlaeger_yy)*schlaeger_xxyy_nenner;
            spiegel_dxx = schlaeger_x3-schlaeger_x2;
            spiegel_dyy = schlaeger_y3-schlaeger_y2;
            spiegel_richt = schlaeger_richt+2;
            spiegel;

            spiegel_xx0_zaehler = schlaeger_xx_zaehler +
              (schlaeger_x3-schlaeger_xx)*schlaeger_xxyy_nenner;
            spiegel_yy0_zaehler = schlaeger_yy_zaehler +
              (schlaeger_y3-schlaeger_yy)*schlaeger_xxyy_nenner;
            spiegel_dxx = schlaeger_x4-schlaeger_x3;
            spiegel_dyy = schlaeger_y4-schlaeger_y3;
            spiegel_richt = schlaeger_richt+12;
            spiegel;

            spiegel_xx0_zaehler = schlaeger_xx_zaehler +
              (schlaeger_x4-schlaeger_xx)*schlaeger_xxyy_nenner;
            spiegel_yy0_zaehler = schlaeger_yy_zaehler +
              (schlaeger_y4-schlaeger_yy)*schlaeger_xxyy_nenner;
            spiegel_dxx = schlaeger_x1-schlaeger_x4;
            spiegel_dyy = schlaeger_y1-schlaeger_y4;
            spiegel_richt = schlaeger_richt+14;
            spiegel;
          };

          ball_dxx += schlaeger_dxx;
          ball_dyy += schlaeger_dyy;
        };
        getroffen=0;


        if erstes_richt==-1 -> kein_spiegel
        else {
          ball_richt = (erstes_richt-ball_richt+7)%12+1;
          if erstes_stein -> getroffen@@(erstes_stein_x,erstes_stein_y)=1;
          if erstes_schlaeger -> {
            bonus(1);
            if turn@@0!=0 -> {bonus(2); message("Angeschnitten!");};
            rueckpass@@0 = rueckpass + 1;
            rueckpass@@1 = rueckpass + 1;
            getroffen@@0=1;
            getroffen@@1=1;
            getroffen=1;
          }
          else
            rueckpass=0;
        };
      };


      bewege_ball = {
        # Der Ball wird bis erstes_t, also bis zum ersten Spiegel, den er trifft,
        # weiterbewegt.
        # Genauer: ball_xx += ball_dxx*erstes_t, entsprechend ball_yy,
        #     t_max -= erstes_t
        #     schlaeger_xxyy += schlaeger_dxxyy*erstes_t

        ggT = gcd(ball_xxyy_nenner,erstes_t_nenner);
        ball_xx_zaehler = ball_xx_zaehler*(erstes_t_nenner/ggT)
            + ball_dxx*erstes_t_zaehler*(ball_xxyy_nenner/ggT);
        ball_yy_zaehler = ball_yy_zaehler*(erstes_t_nenner/ggT)
            + ball_dyy*erstes_t_zaehler*(ball_xxyy_nenner/ggT);
        ball_xxyy_nenner *= erstes_t_nenner/ggT;
        ggT = gcd(gcd(ball_xx_zaehler,ball_yy_zaehler),ball_xxyy_nenner);
        ball_xx_zaehler /= ggT;
        ball_yy_zaehler /= ggT;
        ball_xxyy_nenner /= ggT;

        ggT = gcd(t_max_nenner,erstes_t_nenner);
        t_max_zaehler = t_max_zaehler*(erstes_t_nenner/ggT)
            - erstes_t_zaehler*(t_max_nenner/ggT);
        t_max_nenner *= erstes_t_nenner/ggT;
        ggT = gcd(t_max_zaehler,t_max_nenner);
        t_max_zaehler /= ggT;
        t_max_nenner /= ggT;

        ggT = gcd(schlaeger_xxyy_nenner,erstes_t_nenner);
        schlaeger_xx_zaehler = schlaeger_xx_zaehler*(erstes_t_nenner/ggT)
          + schlaeger_dxx*erstes_t_zaehler*(schlaeger_xxyy_nenner/ggT);
        schlaeger_yy_zaehler = schlaeger_yy_zaehler*(erstes_t_nenner/ggT)
          + schlaeger_dyy*erstes_t_zaehler*(schlaeger_xxyy_nenner/ggT);
        schlaeger_xxyy_nenner *= (erstes_t_nenner/ggT);
        ggT = gcd(gcd(schlaeger_xx_zaehler,schlaeger_yy_zaehler),
          schlaeger_xxyy_nenner);
        schlaeger_xx_zaehler /= ggT;
        schlaeger_yy_zaehler /= ggT;
        schlaeger_xxyy_nenner /= ggT;
      };




      semiglobal.init = {
        ball_x = (10*ball_pro_blop-rnd(2))/2;
        ball_y = 9*ball_pro_blop;
      };

      semiglobal = {
        if !(ball_x == 0..10*ball_pro_blop-1)
            || !(ball_y == 0..20*ball_pro_blop-1) -> {
                                     # Ball ist raus: Wird bestraft
          straf_x = rnd(10);
          kind@@(straf_x,0)=gras;
          farbe@@(straf_x,0)=1+rnd(3);
          ball_richt=0;
          semiglobal.init;
          rueckpass = 0;
        };
        if ball_richt==0 -> {     # Ball ist raus: soll vielleicht wieder rein
          if schlaeger_da ->      # soll rein
            ball_richt = rnd(5)+5;
          schlaeger_xx_alt = -1;
        }
        else {

          #
          # Bewegen und kollidieren mit Schläger
          #

          schlaeger_xx = (loc_xx@@0+loc_xx@@1)/2;
          schlaeger_yy = (loc_yy@@0+loc_yy@@1)/2;

          if schlaeger_da -> {

            if schlaeger_xx_alt == -1 -> {
              schlaeger_xx_alt = schlaeger_xx;
              schlaeger_yy_alt = schlaeger_yy;
            };

            if (schlaeger_richt@@0 % 2)==0 # Schläger ist waagerecht
              -> switch {
                turn@@0 == 0 -> {
                  schlaeger_x1 = schlaeger_xx-15*pixel_gitter;
                  schlaeger_y1 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_x2 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+26*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+47*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_x4 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y4 = schlaeger_yy+ 6*pixel_gitter;
                  schlaeger_richt = 23;
                };
                turn@@0 == 1 -> {
                  schlaeger_x1 = schlaeger_xx;
                  schlaeger_y1 = schlaeger_yy-11*pixel_gitter;
                  schlaeger_x2 = schlaeger_xx+ 8*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+32*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy+39*pixel_gitter;
                  schlaeger_x4 = schlaeger_xx+24*pixel_gitter;
                  schlaeger_y4 = schlaeger_yy+12*pixel_gitter;
                  schlaeger_richt = 20;
                };
                turn@@0 == 2 -> {
                  schlaeger_x1 = schlaeger_xx-11*pixel_gitter;
                  schlaeger_y1 = schlaeger_yy;
                  schlaeger_x2 = schlaeger_xx+12*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+24*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+39*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy+32*pixel_gitter;
                  schlaeger_x4 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y4 = schlaeger_yy+ 8*pixel_gitter;
                  schlaeger_richt = 22;
                };
              }
              else switch {
                turn@@0 == 0 -> {
                  schlaeger_x1 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y1 = schlaeger_yy+47*pixel_gitter;
                  schlaeger_x2 = schlaeger_xx+26*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy-15*pixel_gitter;
                  schlaeger_x4 = schlaeger_xx+ 6*pixel_gitter;
                  schlaeger_y4 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_richt = 5;
                };
                turn@@0 == 1 -> {
                  schlaeger_x1 = schlaeger_xx-11*pixel_gitter;
                  schlaeger_y1 = schlaeger_yy+32*pixel_gitter;
                  schlaeger_x2 = schlaeger_xx+16*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+24*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+39*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy;
                  schlaeger_x4 = schlaeger_xx+12*pixel_gitter;
                  schlaeger_y4 = schlaeger_yy+ 8*pixel_gitter;;
                  schlaeger_richt = 2;
                };
                turn@@0 == 2 -> {
                  schlaeger_x1 = schlaeger_xx;
                  schlaeger_y1 = schlaeger_yy+39*pixel_gitter;
                  schlaeger_x2 = schlaeger_xx+24*pixel_gitter;
                  schlaeger_y2 = schlaeger_yy+16*pixel_gitter;
                  schlaeger_x3 = schlaeger_xx+32*pixel_gitter;
                  schlaeger_y3 = schlaeger_yy-11*pixel_gitter;
                  schlaeger_x4 = schlaeger_xx+ 8*pixel_gitter;;
                  schlaeger_y4 = schlaeger_yy+12*pixel_gitter;
                  schlaeger_richt = 4;
                };
              };
          }
          else -> schlaeger_xx = -1;   # Damit schlaeger_xx_alt -1 wird

          schlaeger_dxx = schlaeger_xx-schlaeger_xx_alt;
          schlaeger_dyy = schlaeger_yy-schlaeger_yy_alt;
          schlaeger_xx_zaehler = schlaeger_xx_alt;
          schlaeger_yy_zaehler = schlaeger_yy_alt;
          schlaeger_xxyy_nenner = 1;
          ball_xx_zaehler = ball_x*ball_gitter+ball_gitter/2;
          ball_yy_zaehler = ball_y*ball_gitter+ball_gitter/2;
          ball_xxyy_nenner = 1;
          t_max_zaehler = 1;
          t_max_nenner = 1;

          ball_richtung;
          spiegel_alle;
          bewege_ball;
          ball_richtung;
          spiegel_alle;
          bewege_ball;
          ball_richtung;
          spiegel_alle;
          bewege_ball;
          ball_richtung;
          kein_spiegel;
          bewege_ball;

          ball_x = ball_xx_zaehler/(ball_gitter*ball_xxyy_nenner);
          ball_y = ball_yy_zaehler/(ball_gitter*ball_xxyy_nenner);

          schlaeger_xx_alt=schlaeger_xx;
          schlaeger_yy_alt=schlaeger_yy;
        };

        #
        # Malen
        #

        mal_x = ball_x-ball_pro_blop/2;
        mal_y = ball_y+ball_pro_blop/2;
        pos = 4*ball_pro_blop*(ball_pro_blop-1)
          + 2*(mal_x%ball_pro_blop)
          - 4*ball_pro_blop*(mal_y%ball_pro_blop);
        mal_x /= ball_pro_blop;
        mal_y /= ball_pro_blop;

        *@@(mal_x,mal_y);
        pos+=1;
        *@@(mal_x+1,mal_y);
        pos+=2*ball_pro_blop-1;
        *@@(mal_x,mal_y-1);
        pos+=1;
        *@@(mal_x+1,mal_y-1);
      };
    >>
  }

  gras = {
    pics = mbrStein.xpm
    <<
      default frei=0:reapply;

      gras = {
        if getroffen -> {farbe-=1; getroffen=0;};
        pos=farbe; *;
        if farbe==0 -> {kind=stuetze;};
      };

      gras.init = {farbe=version};
    >>
  }

  stuetze = {
    colourprob=0
    <<
      stuetze = {
        if kind@(0,1)==nothing || kind@(0,1)==outside -> kind=nothing;
      };
    >>
  }

  schlaeger = {
    numexplode=2
    pics = mbrSchlaeger.xpm
    <<
      schlaeger = {
        if falling -> {
          pos=schlaeger_richt+4*turn; *;
          if getroffen -> {
            if loc_y>=2 && kind@@(loc_x,loc_y-1)==nothing
              -> kind@@(loc_x,loc_y-1)=stuetze;
            if loc_y>=1 && kind@@(loc_x,loc_y)==nothing
              -> kind@@(loc_x,loc_y)=stuetze;
            if loc_y>=0 && kind@@(loc_x,loc_y+1)==nothing
              -> kind@@(loc_x,loc_y+1)=stuetze;
          };
        };
      };

      schlaeger.land = {
        if rueckpass>1
          -> {bonus(rueckpass*5); message("Rückpass!")};
        rueckpass@@ = rueckpass;
        schlaeger_da@@=0;
        kind = stuetze;
      };

      schlaeger.init = {
        schlaeger_da@@=1;
        if loc_x==4
          -> schlaeger_richt=0
          else schlaeger_richt=2;
      };

      schlaeger.turn = {
        schlaeger_richt=(schlaeger_richt+1)%4;
      };
    >>
  }

}

