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

Pfeile={
  name="Arrows"
  name[de]="Pfeile"
  author="Immi"
  numexplode=4
  numexplode[1]=7
  numexplode[1,easy]=5
  chaingrass=0
  pics=ipHoch,ipRechts,ipRunter,ipLinks,ipHochRunter,ipLinksRechts
  toptime=50
  toppic="ipOben.xpm"
  topoverlap=41
  topcolor=255,0,0
  startpic=ipStart.xpm
  #startdist[1]="....++....","...++++...","..++AF++..",".++BCDE++.","++GHIJKL++","++MNOPQR++","SSSTUVWXXX"
  startdist="....AF....","...BCDE...","..GHIJKL..","..MNOPQR..","SSSTUVWXXX"
  greypic=ipGrau.xpm
  description="Arrows can be turned"
  description[de]="Pfeile kann man drehen..."



  <<
  pfeil=switch {
    turn==1 -> E*;
    turn==2 -> F*;
    -> schema4;
  };
  
  ipHoch=pfeil;
  ipRechts=pfeil;
  ipRunter=pfeil;
  ipLinks=pfeil;
  ipHochRunter=pfeil;
  ipLinksRechts=pfeil;

  ipHoch.turn=kind=ipRechts;
  ipRechts.turn=kind=ipRunter;
  ipRunter.turn=kind=ipLinks;
  ipLinks.turn=kind=ipHoch;
  ipHochRunter.turn=kind=ipLinksRechts;
  ipLinksRechts.turn=kind=ipHochRunter;

  >>

  ipHoch={
    pics="ipHoch.xpm"
  }
  ipRechts={
    pics=ipRechts.xpm
  }
  ipRunter={
    pics=ipRunter.xpm
  }
  ipLinks={
    pics=ipLinks.xpm
  }
  ipHochRunter={
    pics=ipHochRunter.xpm
  }
  ipLinksRechts={
    pics=ipLinksRechts.xpm
  }
}

