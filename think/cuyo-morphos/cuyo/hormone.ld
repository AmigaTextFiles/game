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

Hormone={
  name="Hormones"
  name[de]="Hormone"
  author="Immi"
  numexplode=4
  numexplode[1]=6
  chaingrass=1
  pics=ihRot.xpm,ihGruen.xpm,ihBlau.xpm
  pics[1]=ihRot.xpm,ihGruen.xpm,ihBlau.xpm,ihLila.xpm
  toptime=50
  startpic="ihBunt.xpm"
  greypic="ihGrau.xpm"
  neighbours=1
  startdist[1]="++++++++++","----------","++++++++++","AAAAAAAAAA"
  startdist="AAAAAAAAAA"
  bgcolor=0,0,0
  textcolor=255,255,255
  description="When do the \"hormones\" connect?"
  description[de]="Wann verbinden sich die \"Hormone\"?"

  <<
  ihRot=schemaDiag2;
  ihGruen=schemaDiag2;
  ihBlau=schemaDiag2;
  ihLila=schemaDiag2;
  >>
}
