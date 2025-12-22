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


DreiD={
  name="3D"
  author="Immi"
  description="Well, just a little bit 3D."
  neighbours=6
  greypic=Kugel
  startpic=Gitter
  pics=Quadrat,Dreieck,Kreis,Stern
  emptypic=leer
  numexplode=8
  startdist[1]="AA......AA",
               "AA......AA",
               "AA......AA",
               "AA......AA",
               "AA......AA",
               "AAAAAAAAAA"
  startdist="AA......AA",
            "AA......AA",
            "AA......AA",
            "AA......AA",
            "AAAAAAAAAA"
  bgcolor=30,30,30
  textcolor=50,50,50
  #bgpic=i3Boden.xpm
  chaingrass=1
  chaingrass[easy]=0
  
  <<
  
  # Malt einen Schatten auf ein hinteres Feld.
  malSchatten={
    if kind@(0,-1) >= Quadrat || kind@(0,-1) == Kugel -> 0E*;
  };
  
  # Malt eine vordere Stange (auf ein hinteres Feld)
  malStangeV={
    if kind@(-1,0.5) >= Gitter -> {
      switch {
        kind@(-1,0.5) == kind@(1,0.5) -> 0A*;
	# Kleiner Rand vom vorderen Objekt
	#                              -> 0F*;
      };
    };
  };
  
  # Malt eine hintere Stange (auf ein vorderes Feld). Und einen Schatten.
  malStangeH={
    # Schattenstück von Objekt in der Nähe
    if kind@(-1,-0.5) >= Quadrat || kind@(-1,-0.5) == Kugel -> 0D*;
    
    # Schwacher Schatten von Objekt weiter weg
    #switch {
    #  kind@(-2,-1) != nothing && kind@(-2,-1) != outside -> 0E*;
    #};
    
    # Stange
    if (kind@(-1,-0.5) == kind@(1,-0.5) && (kind@(1,-0.5) >= Gitter)) -> {
      if (kind@(-1,-1.5) == kind@(-2,-1) && kind@(-2,-1) >= Quadrat) -> C
      else                                                           -> B;
      0*;
    };
  };
  
  
  
  malStange={
    if loc_x % 2 -> malStangeV
    else         -> malStangeH;
  };
  
  Objekt={
    switch {
      falling -> { # Fallend
        switch {
          loc_x % 2 -> 1L*;
                    -> 1K*;
        };  
      };
      
      
      loc_x % 2 -> { # Klotz hinten, Stange vorne
        malSchatten;
      
        # Klotz:
	1;
        # Wenn Gitter, dann Schattensonderbehandlung
        if kind == Gitter -> {
          if (kind@(-2,0) == kind) -> K*;
          if (kind@(0,-1) == kind) -> L*;
        };
        # Linke Seite
        switch {
          kind@(-2,0) == kind -> {
              [qu = Q_TL] switch { 1????? -> H*; -> D*; };
              [qu = Q_BL] switch { ???1?? -> D*; -> H*; };
            };
          -> {
              [qu = Q_TL] switch { 1????? -> G*; -> C*; };
              [qu = Q_BL] switch { ???1?? -> C*; -> G*; };
            };
        };
        # Rechte Seite
        switch {
          kind@(2,0) == kind -> {
              [qu = Q_TR] switch { 1????? -> G*; -> C*; };
              [qu = Q_BR] switch { ???1?? -> C*; -> G*; };
            };
          -> {
              [qu = Q_TR] switch { 1????? -> H*; -> D*; };
              [qu = Q_BR] switch { ???1?? -> D*; -> H*; };
            };
        };

        # Vor dem Klotz:
        switch { ????1? -> [qu=Q_TL_BL] 1J*; };
        malStangeV;
      };
      
      -> { # Klotz vorne, Stange hinten
      
        # Hinter dem Klotz:
        malStangeH;
        switch { ?1???? -> 1I*; };

        # Klotz:
	1;
        # Linke Seite
        switch {
          kind@(-2,0) == kind -> {
              [qu = Q_TL] switch { 1????? -> F*; -> B*; };
              [qu = Q_BL] switch { ???1?? -> B*; -> F*; };
            };
          -> {
              [qu = Q_TL] switch { 1????? -> E*; -> A*; };
              [qu = Q_BL] switch { ???1?? -> A*; -> E*; };
            };
        };
        # Rechte Seite
        switch {
          kind@(2,0) == kind -> {
              [qu = Q_TR] switch { 1????? -> E*; -> A*; };
              [qu = Q_BR] switch { ???1?? -> A*; -> E*; };
            };
          -> {
              [qu = Q_TR] switch { 1????? -> F*; -> B*; };
              [qu = Q_BR] switch { ???1?? -> B*; -> F*; };
            };
        };


      }; # Nicht fallend
    }; # switch
  
  }; # Objekt


  EinzelObjekt={
    switch {
      loc_x % 2 -> { malSchatten; 1B*; malStangeV};
                -> { malStangeH; 1A*};
    };
  };
  >>
  
  
  leer={
    pics=i3Stange.xpm
    <<
    leer = switch {
      !????11 -> malStange;
    };
    >>
  }
  
  Kugel={
    pics=i3Stange.xpm,i3Kugel.xpm
    << Kugel=EinzelObjekt; >>
  }
  
  Gitter={
    pics=i3Stange.xpm,i3Gitter.xpm
    << Gitter=Objekt; >>
  }
  
  Quadrat={
    pics=i3Stange.xpm,i3Quadrat.xpm
    << Quadrat=Objekt; >>
  }

  Kreis={
    pics=i3Stange.xpm,i3Kreis.xpm
    << Kreis=Objekt; >>
  }
  
  Dreieck={
    pics=i3Stange.xpm,i3Dreieck.xpm
    << Dreieck=Objekt; >>
  }
  
  Stern={
    pics=i3Stange.xpm,i3Stern.xpm
    << Stern=Objekt; >>
  }
  
}
