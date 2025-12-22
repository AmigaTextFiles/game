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

# Status: (M=Muss, S=Soll, K=Kann, F=Feature, B=Bugs)
#
# Keine bekannten Bugs

Kunst={
  name            = "Modern Art"
  name[de]        = "Moderne Kunst"
  author          = "Berni & Immi"
  numexplode      = 5
  numexplode[1]   = 9
  chaingrass      = 1
  pics            = motiv * 5
  bgcolor         = 160,160,160
  topcolor        = 255,196,0
  toptime         = 50
  startpic        = frame
  startdist       = "ABBBBBBBBC"
  greypic         = spot
  textcolor       = 255,255,0
  description     = "Beware of ink!"
  description[de] = "Vorsicht Tinte!"
  randomgreys[1]  = 200

  <<
    var ink = 0;               # Tintenmenge auf dem Blob
    var internal_kind = -1;    # Aussehen der Blobs, bestimmt das Verbinden (nicht für Rahmen)
    var pattern = 0;           # Hilfsvariable für Nachbarverbindungen
    var offset1 = 0;           # Für Wolken.
    var offset2 = 0;           # Für Wolken.

    global.row_up1 = { offset1+=1; };
    global.row_up2 = { offset2+=1; };
    global.row_down1 = { offset1-=1; };
    global.row_down2 = { offset2-=1; };
    
    # Malt den Tintenfleck
    
    paint_ink = {
        if ink>0 => {
          if ink<3 => { pos = ink; *; }
          else     => {{C*;ink@(0,0)=2;};D*,{E*;I*@(0,1);},{F*;J*@(0,1);},{G*;K*@(0,1);ink@(0,1)+=1;};};
        };
    };

    # Berechnet das Nachbarschaftspattern
    
    calculate_neighbours = {
      pattern = 0;
      if !falling ->
      {
        if (internal_kind@(0,0)==internal_kind@( 0,-1)) -> pattern+=1;
        if (internal_kind@(0,0)==internal_kind@( 0, 1)) -> pattern+=2;
        if (internal_kind@(0,0)==internal_kind@(-1, 0)) -> pattern+=4;
        if (internal_kind@(0,0)==internal_kind@( 1, 0)) -> pattern+=8;
      };
    };

    schema16 = {
      switch {
        pattern == 0  -> A;
        pattern == 1  -> M;
        pattern == 2  -> E;
        pattern == 3  -> I;
        pattern == 4  -> D;
        pattern == 5  -> P;
        pattern == 6  -> H;
        pattern == 7  -> L;
        pattern == 8  -> B;
        pattern == 9  -> N;
        pattern == 10 -> F;
        pattern == 11 -> J;
        pattern == 12 -> C;
        pattern == 13 -> O;
        pattern == 14 -> G;
        pattern == 15 -> K;
      };
      *
    };

    # Schneidet bei Bunt und bei Wolkig die Ecken ab, damit diese besser zu
    # den anderen Arten passen. Zuvor muss file und pos gesetzt werden.
    
    cut_corners = {
      5;
      if !falling && (pattern&5) == 0 -> { qu = Q_TL;*; };
      if !falling && (pattern&6) == 0 -> { qu = Q_BL;*; };
      if !falling && (pattern&9) == 0 -> { qu = Q_TR;*; };
      if !falling && (pattern&10) == 0 -> { qu = Q_BR;*; };
      qu = Q_ALL;
    };

    # Zeichnet einen Blob samt Tinte, sofern notwendig

    paint_all = {
    
      # Motiv malen
      file = internal_kind;
      calculate_neighbours;
      
      if falling -> {
        if internal_kind==0 || internal_kind==4 -> Q 
        else -> A;
        *;
      }
      else -> {
        if internal_kind == 4 -> { 
            if loc_p==1 ->
              pos = (loc_x + 2) % 4 + 4 * ((loc_y+offset1@) % 4)
            else
              pos = (loc_x    ) % 4 + 4 * ((loc_y+offset2@) % 4);
            *;
          }
        else
          schema16;
      };
        
      # Ecken abrunden
      if internal_kind==0 -> {A;cut_corners;};
      if internal_kind==4 -> {B;cut_corners;};

      # Fleck malen, sofern vorhanden
      6; paint_ink;
      
      if exploding==8 -> internal_kind@(0,0)=-1; # Variablen werden nicht
                                                 # automatisch gelöscht,
                                                 # also von Hand... 
    };

  >>

  frame = {
    pics = "ibkRahmen.xpm","ibkTintenfleck.xpm"
    <<
      frame = {
      
        # Rahmen Zeichnen
        default2g;
        
        # Tinte Zeichnen
        1;paint_ink;
        
      };
    >>
  }

  motiv = {
    pics = "ibkBunt.xpm","ibkGruen.xpm","ibkRot.xpm","ibkSchnecken.xpm","ibkWolkig.xpm",
           "ibkBG.xpm","ibkTintenfleck.xpm"
    <<
      motiv.init = {
        internal_kind = kind-motiv;
      };
      
      motiv = {
        paint_all;
      };
    >>
  }

  spot = {
    pics = "ibkBunt.xpm","ibkGruen.xpm","ibkRot.xpm","ibkSchnecken.xpm","ibkWolkig.xpm",
           "ibkBG.xpm","ibkTintenfleck.xpm"
    <<
      spot.init = {
        internal_kind = -1;          # -1 = fallender Tropfen
        ink = 1;
      };
      spot = {
        if internal_kind==-1 ->
          {
            6A*;

            # In den nachfolgenden Zeilen wird internal_kind auf -2 gesetzt,
            # damit die entsprechenden Blobs nicht beim Nachbarschaft
            # berechnen stören.

            switch {
              # Tinte tropft unten raus
              kind@(0,1)==outside 
                -> { 
                  kind@(0,0) = nothing; 
                  internal_kind@(0,0)=-2; 
                };

              # Tinte tropft auf einen nichtleeren Blob
              (kind@(0,1)==spot && internal_kind@(0,1)!=-1) 
                || kind@(0,1)==frame 
                || kind@(0,1)==0..4
                -> { 
                  if kind@(0,1)!=frame ->
                    kind@(0,1) = spot; 
                  ink@(0,1)+=1; 
                  kind@(0,0) = nothing; 
                  internal_kind@(0,0)=-2; 
                };
            };
          }
        else =>
          paint_all;
      };
    >>
  }
  
}
