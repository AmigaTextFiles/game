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

#ifndef STRUCTURECLASS_H
#define STRUCTURECLASS_H

#define ANIMATIONTIMER 25
#define ANIMMOVETIMER 50

#include <ObjectClass.h>

class StructureClass : public ObjectClass
{
public:
	StructureClass(PlayerClass* newOwner);
	StructureClass(Stream& stream);
	void init();
	virtual ~StructureClass();

	virtual void save(Stream& stream) const;

	void assignToMap(const Coord& pos);
	void blitToScreen();

	virtual ObjectInterface* GetInterfaceContainer();

	void destroy();
	virtual void drawSelectionBox();

	virtual Coord getCenterPoint() const;
	virtual Coord getClosestCenterPoint(const Coord& objectLocation) const;
	void setDestination(int newX, int newY);
	void setJustPlaced();
	void setFogged(bool bFogged){fogged = bFogged;};

	int getDrawnX() const;
	int getDrawnY() const;

	void playConfirmSound() { ; };
	void playSelectSound() { ; };

	/**
		This method is called when a structure is ordered by a right click
		\param	xPos	the x position on the map
		\param	yPos	the y position on the map
	*/
	virtual void HandleActionClick(int xPos, int yPos);

	/**
		This method is called when the user clicks on the repair button for this building
	*/
	virtual void HandleRepairClick();


	virtual void DoSetDeployPosition(int xPos, int yPos);

	void DoRepair();

	/**
        Updates this object.
        \return true if this object still exists, false if it was destroyed
	*/
	virtual bool update();

	virtual void doSpecificStuff() = 0;

	bool IsRepairing() { return repairing; }

	virtual Coord getClosestPoint(const Coord& objectLocation) const;

	inline short getStructureSizeX() const { return structureSize.x; }
	inline short getStructureSizeY() const { return structureSize.y; }
	inline const Coord& getStructureSize() const { return structureSize; }
	inline int getOriginalHouse() const { return origHouse; }
	inline void setOriginalHouse(int i) { origHouse = i; }

protected:
	// constant for all structures of the same type
    Coord	structureSize;      ///< The size of this structure in tile coordinates (e.g. (3,2) for a refinery)

    // structure state
	bool    repairing;          ///< currently repairing?
    int		origHouse;          ///< for takeover, we still want to keep track of what the original owner was

    // TODO: fogging is currently broken
	bool        fogged;         ///< Currently fogged?
	SDL_Rect    lastVisible;    ///< store picture drawn before fogged

    // drawing information
    int		JustPlacedTimer;    ///< When the structure is justed placed, we draw some special graphic

	int		FirstAnimFrame;     ///< First frame of the current animation
	int		LastAnimFrame;      ///< Last frame of the current animation
	int		curAnimFrame;       ///< The current frame of the current animation
	int     animationCounter;   ///< When to show the next animation frame?
};

#endif //STRUCTURECLASS_H
