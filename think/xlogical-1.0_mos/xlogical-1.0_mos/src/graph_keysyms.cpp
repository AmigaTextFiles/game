//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////



#include "graph_keysyms.h"

char
keysym_to_char( keysyms aKeysym )
{
	switch( aKeysym )
	{
		case eA:
			return( 'A' );
		case eB:
			return( 'B' );
		case eC:
			return( 'C' );
		case eD:
			return( 'D' );
		case eE:
			return( 'E' );
		case eF:
			return( 'F' );
		case eG:
			return( 'G' );
		case eH:
			return( 'H' );
		case eI:
			return( 'I' );
		case eJ:
			return( 'J' );
		case eK:
			return( 'K' );
		case eL:
			return( 'L' );
		case eM:
			return( 'M' );
		case eN:
			return( 'N' );
		case eO:
			return( 'O' );
		case eP:
			return( 'P' );
		case eQ:
			return( 'Q' );
		case eR:
			return( 'R' );
		case eS:
			return( 'S' );
		case eT:
			return( 'T' );
		case eU:
			return( 'U' );
		case eV:
			return( 'V' );
		case eW:
			return( 'W' );
		case eX:
			return( 'X' );
		case eY:
			return( 'Y' );
		case eZ:
			return( 'Z' );
		case e0:
			return( '0' );
		case e1:
			return( '1' );
		case e2:
			return( '2' );
		case e3:
			return( '3' );
		case e4:
			return( '4' );
		case e5:
			return( '5' );
		case e6:
			return( '6' );
		case e7:
			return( '7' );
		case e8:
			return( '8' );
		case e9:
			return( '9' );
		case eSpace:
			return( ' ' );
		default:
			return( '*' );
	}
}
