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

ColorShape =
{
  #------------------------------------#
  # Allgemeine Beschreibung des Levels #
  #------------------------------------#

  name     = "Shape and Color"
  name[de] = "Form und Farbe"
  author   = "Berni"
  description     = "An explosion changes the way, they connect..."
  description[de] = "Explosionen wechseln die Art des Verbindens..."

  pics = All,All,All,All

  greypic   = Grey
  startpic  = Start
  emptypic  = Empty
  startdist = "A.........","A.........","A.........","A........A",
	      "AA.......A","AA.......A","AAA....AAA",
	      "AAAA.AAAAA"
  startdist[1] = "A.........","A.........","A.........","A........A","A........A",
	         "AA.......A","AA.......A","AA.......A","AAA....AAA",
	         "AAAA..AAAA","AAAA.AAAAA"

  numexplode = 4
  chaingrass = 1

  bgcolor    = 0,0,0
  topcolor   = 0,0,0
  topoverlap = 0
  toptime    = 80
  textcolor  = 200,200,200

  randomgreys[1] = 40

  <<
    var farbe, form;

    var modusl = 0,
	modusr = 0,
	wechsell = 0,
	wechselr = 0,
	explobuml = 0,
	explobumr = 0,
	counterl = 0,
	counterr = 0;
	
    global = 
      {
	wechsell=0;
	switch {
	  explobuml==1 -> 
	   {
	     counterl=10;
	     explobuml=0;
	   };
	  counterl > 0 -> 
	    { 
	      switch {
		counterl == 10 -> 
	   	  {
	     	    modusl=1-modusl;
	     	    wechsell=1;
	   	  };
	      };
	      counterl-=1;
	    };
	};

	wechselr=0;
	switch {
	  explobumr==1 -> 
	   {
	     counterr=10;
	     explobumr=0;
	   };
	  counterr > 0 -> 
	    { 
	      switch {
		counterr == 10 -> 
	   	  {
	     	    modusr=1-modusr;
	     	    wechselr=1;
	   	  };
	      };
	      counterr-=1;
	    };
	};
      };

    bg = {
	if !falling && loc_x == 0..9 && loc_y == 0..19 ->
	    {
	      switch {
	        loc_p == 1 -> file = modusl@;
	        loc_p == 2 -> file = modusr@;
	      };
	      pos = loc_x+10*loc_y;*;
	    };
    };
  >>

  Start =
  {
    pics = bcEmpty1.xpm,bcEmpty2.xpm,bcOrange.xpm

    <<
      Start =
	{
	  bg;
	  2;schema5;
	};
    >>
  }

  Grey =
  {
    pics = bcEmpty1.xpm,bcEmpty2.xpm,bcBack.xpm,bcSechseck.xpm

    <<
      Grey =
	{
	  bg;
	  2;schema5;
	  3A*;
	};
    >>
  }

  Empty =
  {
    pics = bcEmpty1.xpm,bcEmpty2.xpm

    <<
      Empty = 
        {
	  bg;
	};
    >>
  }

  All = 
  {
    pics = bcEmpty1.xpm,bcEmpty2.xpm,bcBack.xpm,bcShapes.xpm

    <<    
      All.init = { 
        switch {
	loc_p == 1 ->
	  switch {
	    modusl@ == 0 -> {farbe = kind; form = rnd(4)};
	    modusl@ == 1 -> {farbe = rnd(4); form = kind};
	  };
	loc_p == 2 ->
          switch {
	    modusr@ == 0 -> {farbe = kind; form = rnd(4)};
	    modusr@ == 1 -> {farbe = rnd(4); form = kind};
	  };
	};
      };

      All.changeside = {
	  switch {
          loc_p == 1 ->
	    switch {
	      modusl@==0 -> kind=farbe;
	      modusl@==1 -> kind=form;    
            };
          loc_p == 2 ->
	    switch {
	      modusr@==0 -> kind=farbe;
	      modusr@==1 -> kind=form;    
            };
	  };
      };

      All = 
        {
          bg;

	  if size>=4 -> 
	    switch {
	      loc_p == 1 -> explobuml@ = 1;
	      loc_p == 2 -> explobumr@ = 1;
	    };

	  switch {
          loc_p == 1 ->
	    if wechsell@==1 ->
	      switch {
	        modusl@==0 -> kind=farbe;
	        modusl@==1 -> kind=form;    
              };
          loc_p == 2 ->
	    if wechselr@==1 ->
	      switch {
	        modusr@==0 -> kind=farbe;
	        modusr@==1 -> kind=form;    
              };
	  };

	  2;schema5;
	  3;pos=4*form+farbe;*;

	};
    >>
      
  }
} # End of ColorShape
