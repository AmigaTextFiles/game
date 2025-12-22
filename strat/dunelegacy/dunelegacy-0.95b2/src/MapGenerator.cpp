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

#include <MapGenerator.h>

#include <globals.h>

#include <MapClass.h>
#include <PlayerClass.h>
#include <GameClass.h>

#include <ObjectClass.h>
#include <structures/WallClass.h>
#include <structures/TurretClass.h>
#include <units/UnitClass.h>
#include <units/TankClass.h>

/**
    Sets the whole map to one tile type
    \param tile the tile to set
    \param type the type of this tile
*/
void clear_terrain(int tile, int type) {
	for (int i = 0; i < currentGameMap->sizeX; i++) {
		for (int j = 0; j < currentGameMap->sizeY; j++) {
			currentGameMap->cell[i][j].setType(type);
			currentGameMap->cell[i][j].setTile(tile);
		}
	}
}

/**
    Fixes one wall at position (xPos, yPos). The choosen wall tile is based on the 8 surounding tiles.
    \param xPos x-coordinate in tile coordinates
    \param yPos y-coordinate in tile coordinates
*/
void fixWall(int xPos, int yPos) {
	if(currentGameMap->cell[xPos][yPos].hasAGroundObject() && currentGameMap->cell[xPos][yPos].getGroundObject()->getItemID() == Structure_Wall) {
		int up, down, left, right;
		int i = xPos, j = yPos,
			maketile = Structure_w8;

		// Walls
		up = (!currentGameMap->cellExists(i, j-1) || (currentGameMap->cell[i][j-1].hasAGroundObject()
			&& (currentGameMap->cell[i][j-1].getGroundObject()->getItemID() == Structure_Wall)));

		down = (!currentGameMap->cellExists(i, j+1) || (currentGameMap->cell[i][j+1].hasAGroundObject()
			&& (currentGameMap->cell[i][j+1].getGroundObject()->getItemID() == Structure_Wall)));

		left = (!currentGameMap->cellExists(i-1, j) || (currentGameMap->cell[i-1][j].hasAGroundObject()
			&& (currentGameMap->cell[i-1][j].getGroundObject()->getItemID() == Structure_Wall)));

		right = (!currentGameMap->cellExists(i+1, j) || (currentGameMap->cell[i+1][j].hasAGroundObject()
			&& (currentGameMap->cell[i+1][j].getGroundObject()->getItemID() == Structure_Wall)));

		// Now perform the test
		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Structure_w7; //solid wall
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Structure_w2; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Structure_w3; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Structure_w4; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Structure_w5; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Structure_w1; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Structure_w11; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Structure_w9; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Structure_w10; //missing bottom left edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Structure_w8; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Structure_w8; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Structure_w6; //only up
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Structure_w6; //only down
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Structure_w8; //missing above and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Structure_w6; //missing left and right

	///////
		((WallClass*)currentGameMap->cell[i][j].getGroundObject())->setTile(maketile);
	}
}

/**
    Fixes the wall at (xPos,yPos) and their surounding walls
    \param xPos x-coordinate in tile coordinates
    \param yPos y-coordinate in tile coordinates
*/
void fixWalls(int xPos, int yPos) {
	fixWall(xPos, yPos);

	if (currentGameMap->cellExists(xPos, yPos-1))
		fixWall(xPos, yPos-1);

	if (currentGameMap->cellExists(xPos, yPos+1))
		fixWall(xPos, yPos+1);

	if (currentGameMap->cellExists(xPos-1, yPos))
		fixWall(xPos-1, yPos);

	if (currentGameMap->cellExists(xPos+1, yPos))
		fixWall(xPos+1, yPos);
}

/**
    Checks if the tile to the left of (cellX,cellY) is of type tile
    \param cellX x-coordinate in tile coordinates
    \param cellY y-coordinate in tile coordinates
    \param tile  the tile type to check
    \return 1 if of type tile, 0 if not
*/
int on_left(int cellX, int cellY, int tile) {
	cellX--;
	fix_cell(cellX, cellY);

	if (currentGameMap->cell[cellX][cellY].getType() == tile)
		return 1;

	return 0;
}

/**
    Checks if the tile to the right of (cellX,cellY) is of type tile
    \param cellX x-coordinate in tile coordinates
    \param cellY y-coordinate in tile coordinates
    \param tile  the tile type to check
    \return 1 if of type tile, 0 if not
*/
int on_right(int cellX, int cellY, int tile) {
	cellX++;
	fix_cell(cellX, cellY);

	if (currentGameMap->cell[cellX][cellY].getType() == tile)
		return 1;

	return 0;
}

/**
    Checks if the tile above (cellX,cellY) is of type tile
    \param cellX x-coordinate in tile coordinates
    \param cellY y-coordinate in tile coordinates
    \param tile  the tile type to check
    \return 1 if of type tile, 0 if not
*/
int on_up(int cellX, int cellY, int tile) {
	cellY--;
	fix_cell(cellX, cellY);

	if (currentGameMap->cell[cellX][cellY].getType() == tile)
		return 1;

	return 0;
}

/**
    Checks if the tile below (cellX,cellY) is of type tile
    \param cellX x-coordinate in tile coordinates
    \param cellY y-coordinate in tile coordinates
    \param tile  the tile type to check
    \return 1 if of type tile, 0 if not
*/
int on_down(int cellX, int cellY, int tile) {
	cellY++;
	fix_cell(cellX, cellY);

	if (currentGameMap->cell[cellX][cellY].getType() == tile)
		return 1;

	return 0;
}

/**
    Count how many tiles around (cellX,cellY) are of type tile
    \param cellX x-coordinate in tile coordinates
    \param cellY y-coordinate in tile coordinates
    \param tile  the tile type to check
    \return number of surounding tiles of type tile (0 to 4)
*/
int side4(int cellX, int cellY, int tile) {
	// Check at 4 sides for 'tile'
	int flag = 0;

	if (on_left(cellX, cellY, tile))
		flag++;

	if (on_right(cellX, cellY, tile))
		flag++;

	if (on_up(cellX, cellY, tile))
		flag++;

	if (on_down(cellX, cellY, tile))
		flag++;

	return flag;
}

/**
    This smoothes the spot at (i,j).
    \param  i   x-coordinate in tile coordinates
    \param  j   y-coordinate in tile coordinates
*/
void smooth_spot(int i, int j) {
	int left = 0;
	int right = 0;
	int up = 0;
	int down = 0;
	int maketile;

	if(currentGameMap->cell[i][j].getType() == Terrain_Dunes) {

        maketile = Terrain_DunesFull;                   // solid Dunes
        up = on_up(i, j, Terrain_Dunes);
        down = on_down(i, j, Terrain_Dunes);
        left = on_left(i, j, Terrain_Dunes);
        right = on_right(i, j, Terrain_Dunes);
		// Now perform the test

		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_DunesFull; //solid rock
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_DunesNotLeft; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Terrain_DunesNotRight; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_DunesNotUp; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_DunesNotDown; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_DunesDownRight; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_DunesUpLeft; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_DunesDownLeft; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_DunesUpRight; //missing bottom left edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_DunesLeftRight; //missing above and below
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_DunesLeft; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_DunesRight; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_DunesUp; //
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_DunesDown; //
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Terrain_DunesUpDown; //missing left and right
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_DunesIsland; //missing all edges
///////
		currentGameMap->cell[i][j].setTile(maketile);

	} else if (currentGameMap->cell[i][j].getType() == Terrain_Mountain) {

        maketile = Terrain_MountainFull;                   // solid mountain
        up = on_up(i, j, Terrain_Mountain);
        down = on_down(i, j, Terrain_Mountain);
        left = on_left(i, j, Terrain_Mountain);
        right = on_right(i, j, Terrain_Mountain);

		// Now perform the test
		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_MountainFull; //solid rock
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_MountainNotLeft; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Terrain_MountainNotRight; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_MountainNotUp; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_MountainNotDown; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_MountainDownRight; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_MountainUpLeft; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_MountainDownLeft; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_MountainUpRight; //missing bottom left edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_MountainLeftRight; //missing above and below
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_MountainLeft; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_MountainRight; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_MountainUp; //
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_MountainDown; //
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Terrain_MountainUpDown; //missing left and right
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_MountainIsland; //missing all edges
///////
		currentGameMap->cell[i][j].setTile(maketile);
	} else if (currentGameMap->cell[i][j].getType() == Terrain_Rock) {

		maketile = Terrain_t1;                   // Standard we have a solid rock plateau
		up = on_up(i, j, Terrain_Rock) || on_up(i, j, Terrain_Slab1) || on_up(i, j, Structure_Wall) || on_up(i, j, Terrain_Mountain);
		down = on_down(i, j, Terrain_Rock) || on_down(i, j, Terrain_Slab1) || on_down(i, j, Structure_Wall) || on_down(i, j, Terrain_Mountain);
		left = on_left(i, j, Terrain_Rock) || on_left(i, j, Terrain_Slab1) || on_left(i, j, Structure_Wall) || on_left(i, j, Terrain_Mountain);
		right = on_right(i, j, Terrain_Rock) || on_right(i, j, Terrain_Slab1) || on_right(i, j, Structure_Wall) || on_right(i, j, Terrain_Mountain);
		// Now perform the test

		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_t1; //solid rock
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_t2; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Terrain_t3; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_t4; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_t5; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_t6; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_t7; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_t8; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_t9; //missing bottom left edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_t11; //missing above and below
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_t12; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_t13; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_t14; //sand not up
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_t15; //sand not down
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Terrain_t16; //missing left and right
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_t10; //missing all edges
	///////
		currentGameMap->cell[i][j].setTile(maketile);

	} else if (currentGameMap->cell[i][j].getType() == Terrain_Spice) {

		maketile = Terrain_s1;                  // Standard we have a solid spice
		up = on_up(i, j, Terrain_Spice) || on_up(i, j, Terrain_ThickSpice);
		down = on_down(i, j, Terrain_Spice) || on_down(i, j, Terrain_ThickSpice);
		left = on_left(i, j, Terrain_Spice) || on_left(i, j, Terrain_ThickSpice);
		right = on_right(i, j, Terrain_Spice) || on_right(i, j, Terrain_ThickSpice);
		// Now perform the test
		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_s1; //solid spice
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_s2; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Terrain_s3; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_s4; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_s5; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_s6; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_s7; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_s8; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_s9; //missing bottom left edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_s11; //missing above and below
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_s12; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_s13; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_s14; //sand not up
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_s15; //sand not down
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Terrain_s16; //missing left and right
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_s10; //no edges

		///////
		currentGameMap->cell[i][j].setTile(maketile);

	} else if (currentGameMap->cell[i][j].getType() == Terrain_ThickSpice) {

        maketile = Terrain_ThickSpiceFull;                   // solid ThickSpice
        up = on_up(i, j, Terrain_ThickSpice);
        down = on_down(i, j, Terrain_ThickSpice);
        left = on_left(i, j, Terrain_ThickSpice);
        right = on_right(i, j, Terrain_ThickSpice);

		// Now perform the test
		if ((left == 1) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_ThickSpiceFull; //solid rock
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 1))
			maketile = Terrain_ThickSpiceNotLeft; //missing left edge
		else if ((left == 1) && (right == 0)&& (up == 1) && (down == 1))
			maketile = Terrain_ThickSpiceNotRight; //missing right edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_ThickSpiceNotUp; //missing top edge
		else if ((left == 1) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_ThickSpiceNotDown; //missing bottom edge
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 1))
			maketile = Terrain_ThickSpiceDownRight; //missing top left edge
		else if ((left == 1) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_ThickSpiceUpLeft; //missing bottom right edge
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_ThickSpiceDownLeft; //missing top right edge
		else if ((left == 0) && (right == 1) && (up == 1) && (down == 0))
			maketile = Terrain_ThickSpiceUpRight; //missing bottom left edge
		else if ((left == 1) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_ThickSpiceLeftRight; //missing above and below
		else if ((left == 1) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_ThickSpiceLeft; //missing above, right and below
		else if ((left == 0) && (right == 1) && (up == 0) && (down == 0))
			maketile = Terrain_ThickSpiceRight; //missing above, left and below
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 0))
			maketile = Terrain_ThickSpiceUp; //
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 1))
			maketile = Terrain_ThickSpiceDown; //
		else if ((left == 0) && (right == 0) && (up == 1) && (down == 1))
			maketile = Terrain_ThickSpiceUpDown; //missing left and right
		else if ((left == 0) && (right == 0) && (up == 0) && (down == 0))
			maketile = Terrain_ThickSpiceIsland; //missing all edges

		///////
		currentGameMap->cell[i][j].setTile(maketile);

	} else if (currentGameMap->cell[i][j].getType() == Terrain_Sand) {

		if((currentGameMap->cell[i][j].getTile() != Terrain_a2) && (currentGameMap->cell[i][j].getTile() != Terrain_a3)) {
			currentGameMap->cell[i][j].setTile(Terrain_a1);
		}
	}
}

/**
    Smooth the darn terrain
*/
void smooth_terrain() {
	for (int i = 0; i < currentGameMap->sizeX; i++) {
		for (int j = 0; j < currentGameMap->sizeY; j++) {
			 smooth_spot(i, j);
		}
	}
}


/**
    Removes holes in rock and spice
    \param tpe  the type to remove holes from
*/
void thick_spots(int tpe) {
    for (int i = 0; i < currentGameMap->sizeX; i++) {
        for (int j = 0; j < currentGameMap->sizeY; j++) {
            if (currentGameMap->cell[i][j].getType() != tpe) {
                // Found something else than what thickining
				if (side4(i, j, tpe) >= 3)
					currentGameMap->cell[i][j].setType(tpe);                // Seems enough of the type around it so make this rock

				if (side4(i, j, tpe) == 2) {
                    // Gamble, fifty fifty... rock or not?
					if (getRandomInt(0,1) == 1)
						currentGameMap->cell[i][j].setType(tpe);
				}
			}
		}
    }
}

/**
    This function creates a spot of type tpy.
    \param cellX    the x coordinate in tile coordinates to start making the spot
    \param cellY    the y coordinate in tile coordinates to start making the spot
    \param tpe      type of the spot
*/
void make_spot(int cellX, int cellY, int tpe) {
	int dir;		// Direction
	int j;			// Loop control

	for(j = 0; j < 1000; j++) {
		dir = getRandomInt(0,3);	// Random Dir

		switch(dir) {
			case 0 : cellX--; break;
			case 1 : cellX++; break;
			case 2 : cellY--; break;
			case 3 : cellY++; break;
		}

		fix_cell(cellX, cellY);

		if(tpe == Terrain_Spice) {
			if (currentGameMap->cell[cellX][cellY].getType() == Terrain_Rock)
                continue;		// Do not place the spice spot, priority is ROCK!
		}

		currentGameMap->cell[cellX][cellY].setTile(1);
		currentGameMap->cell[cellX][cellY].setType(tpe);
	}
}


/**
    Adds amount number of rock tiles to the map
    \param amount the number of rock tiles to add
*/
void add_rock_bits(int amount) {
	int spotX, spotY;
	int done = 0;
	while (done < amount) {
		spotX = getRandomInt(0, currentGameMap->sizeX-1);
		spotY = getRandomInt(0, currentGameMap->sizeY-1);

		if(currentGameMap->cell[spotX][spotY].getType() == Terrain_Sand) {
			currentGameMap->cell[spotX][spotY].setTile(Terrain_t10);      // Rock bit
			currentGameMap->cell[spotX][spotY].setType(Terrain_Rock);
            done++;
		}
	}
}

/**
    Adds amount number of spice blooms to the map
    \param amount the number of spice blooms to add
*/
void add_blooms(int amount) {
	int spotX, spotY;
	int done = 0;
	while(done < amount) {
		spotX = getRandomInt(0, currentGameMap->sizeX-1);
		spotY = getRandomInt(0, currentGameMap->sizeY-1);
		if (currentGameMap->cell[spotX][spotY].getType() == Terrain_Sand && currentGameMap->cell[spotX][spotY].getTile() == Terrain_a1) {
			currentGameMap->cell[spotX][spotY].setTile(getRandomInt(Terrain_a2,Terrain_a3));      // Spice bloom
            done++;
        }
	}
}

/**
    Creates a random map
    \param sizeX width of the new map (in tiles)
    \param sizeY height of the new map (in tiles)
*/
void make_random_map(int sizeX, int sizeY) {
    int i, count;
    int spots = ROCKFIELDS;
    int fields = SPICEFIELDS;
    int spotX, spotY;

	currentGameMap = new MapClass(sizeX, sizeY);

    clear_terrain(Terrain_a1, Terrain_Sand);

    for (i = 0; i < spots; i++) {
        spotX = getRandomInt(0, currentGameMap->sizeX-1);
        spotY = getRandomInt(0, currentGameMap->sizeY-1);

        make_spot(spotX, spotY, Terrain_Rock);
    }

    // Spice fields
    for (i = 0; i < fields; i++) {
        spotX = getRandomInt(0, currentGameMap->sizeX-1);
        spotY = getRandomInt(0, currentGameMap->sizeY-1);

        make_spot(spotX, spotY, Terrain_Spice);
    }

    for(count = 0; count < ROCKFILLER; count++) {
        thick_spots(Terrain_Rock); //SPOT ROCK
    }

    for(count = 0; count < SPICEFILLER; count++) {
        thick_spots(Terrain_Spice);
    }

 	add_rock_bits(getRandomInt(0,9));
	add_blooms(getRandomInt(0,9));

	smooth_terrain();
}
