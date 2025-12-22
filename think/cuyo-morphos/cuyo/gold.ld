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

Gold={
  name="Gold"
  author="Mark Weyer"
  description[1]="Yes, it CAN be completed"
  description[2]="Yes, it CAN be completed\n...cooperatively"
  description[1,de]="Ja, es ist möglich"
  description[2,de]="Ja, es ist möglich\n...wenn man zusammenarbeitet"
  numexplode=10
  chaingrass=0
  bgcolor=0,0,0
  topcolor=255,255,255
  textcolor=255,0,0
  toptime=200
  startpic=gold
  startdist="AA..AA..AA","AA..AA..AA","AA..AA..AA"
  neighbours=<neighbours_knight>
  randomgreys=200

  gold = {
    pics = mgsGold.xpm
    colourprob = 1
    greyprob = 1
    <<
      default inhibit = DIR_UUL+DIR_DDL+DIR_DDR+DIR_UUR;
      default behaviour = goalblob+calculate_size+explodes_on_size;

      gold = {
        *;
        B;
        if kind@(-2,1)==gold -> {qu=Q_BR; @(-1,0)*; qu=Q_TL; *@(-1,1);};
        if kind@( 2,1)==gold -> {qu=Q_BL; @(1,0)*; qu=Q_TR; *@( 1,1);};
      };
    >>
  }

}


