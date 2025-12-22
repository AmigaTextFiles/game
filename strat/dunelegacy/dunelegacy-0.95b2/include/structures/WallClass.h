/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef WALLCLASS_H
#define WALLCLASS_H

#include <structures/StructureClass.h>
#include <terrainData.h>

class WallClass : public StructureClass
{
public:
	WallClass(PlayerClass* newOwner);
	WallClass(Stream& stream);
	void init();
	~WallClass();

	void checkSelf();
	void doSpecificStuff();

	inline void setTile(int newTile) {
		switch(newTile) {
			case Structure_w1:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 5;
				break;
			case Structure_w2:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 6;
				break;
			case Structure_w3:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 10;
				break;
			case Structure_w4:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 11;
				break;
			case Structure_w5:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 8;
				break;
			case Structure_w6:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 4;
				break;
			case Structure_w7:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 12;
				break;
			case Structure_w8:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 2;
				break;
			case Structure_w9:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 9;
				break;
			case Structure_w10:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 3;
				break;
			case Structure_w11:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 7;
				break;
			default:
				curAnimFrame = FirstAnimFrame = LastAnimFrame = 2;
				break;
		}
	}
};

#endif //WALLCLASS_H
