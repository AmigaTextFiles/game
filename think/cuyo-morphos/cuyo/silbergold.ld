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

SilberGold={
  name="Silver and Gold"
  name[de]="Silber und Gold"
  author="Mark Weyer"
  numexplode=4
  numexplode[easy]=3
  chaingrass=0
  pics=silber,gold,silbergold,goldsilber
  bgcolor=0,0,0
  topcolor=255,255,255
  textcolor=255,0,0
  toptime=200
  startpic=mgsWeiss.xpm
  startdist=".AA.AA.AA.","AAAAAAAAAA","AAAAAAAAAA"
  startdist[easy]=".AA.AA.AA.","AAAAAAAAAA"
  neighbours=<neighbours_knight>
  falling_speed[easy]=3

  silber = {
    pics = mgsSilber.xpm
    greyprob=1
    <<
      default inhibit = DIR_LLU+DIR_LLD+DIR_RRD+DIR_RRU : reapply;

      silber = {
        *;
        B;
        if kind@(-1,2)==silber -> {qu=Q_TL; @(0,1)*; qu=Q_BR; *@(-1,1);};
        if kind@( 1,2)==silber -> {qu=Q_TR; @(0,1)*; qu=Q_BL; *@( 1,1);};
      };
    >>
  }

  gold = {
    pics = mgsGold.xpm
    greyprob=1
    <<
      default inhibit = DIR_UUL+DIR_DDL+DIR_DDR+DIR_UUR : reapply;

      gold = {
        *;
        B;
        if kind@(-2,1)==gold -> {qu=Q_BR; @(-1,0)*; qu=Q_TL; *@(-1,1);};
        if kind@( 2,1)==gold -> {qu=Q_BL; @(1,0)*; qu=Q_TR; *@( 1,1);};
      };
    >>
  }

  silbergold = {
    pics = mgsSilberGold.xpm
    greyprob=1
    <<
      default inhibit = DIR_UUL+DIR_LLD+DIR_DDR+DIR_RRU : reapply;

      silbergold = {
        *;
	B;
        if kind@(-1,2)==silbergold -> {qu=Q_TL; @(0,1)*; qu=Q_BR; *@(-1,1);};
        if kind@( 2,1)==silbergold -> {qu=Q_BL; @(1,0)*; qu=Q_TR; *@( 1,1);};
      };
    >>
  }

  goldsilber = {
    pics = mgsGoldSilber.xpm
    greyprob=1
    <<
      default inhibit = DIR_LLU+DIR_DDL+DIR_RRD+DIR_UUR : reapply;

      goldsilber = {
        *;
        B;
        if kind@(-2,1)==goldsilber -> {qu=Q_BR; @(-1,0)*; qu=Q_TL; *@(-1,1);};
        if kind@( 1,2)==goldsilber -> {qu=Q_TR; @(0,1)*; qu=Q_BL; *@( 1,1);};
      };
    >>
  }

}

