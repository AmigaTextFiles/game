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

#ifndef OBJECTCLASS_H
#define OBJECTCLASS_H

#include <ObjectPointer.h>

#include <Definitions.h>
#include <DataTypes.h>
#include <mmath.h>

#include <algorithm>

#include <SDL.h>


#if !defined(lround)
#define lround(x) (int)(x+(x<0? -0.5 : 0.5)) 
#endif


// forward declarations
class PlayerClass;
class Stream;
class ObjectInterface;
class Coord;
class Container;

#define VIS_ALL -1

/*!
	Class from which all structure and unit classes are derived
*/
class ObjectClass
{
public:

	ObjectClass(PlayerClass* newOwner);
	ObjectClass(Stream& stream);
	void init();
	virtual ~ObjectClass();

	virtual void save(Stream& stream) const;

	virtual ObjectInterface* GetInterfaceContainer();

	virtual void assignToMap(const Coord& pos) = 0;
	virtual void blitToScreen() = 0;

    virtual void drawSelectionBox() { ; };

	virtual void destroy() = 0;

	void drawSmoke(int x, int y);

	virtual Coord getClosestCenterPoint(const Coord& objectLocation) const;

	virtual bool canAttack(const ObjectClass* object) const;
	virtual int getDrawnX() const = 0;
	virtual int getDrawnY() const = 0;

	virtual Coord getCenterPoint() const;

	virtual void handleDamage(int damage, Uint32 damagerID);

	/**
		This method is called when an object is ordered by a right click
		\param	xPos	the x position on the map
		\param	yPos	the y position on the map
	*/
	virtual void HandleActionClick(int xPos, int yPos) = 0;

	virtual void DoRepair() = 0;

	virtual void HandleInterfaceEvent(SDL_Event* event);

	virtual void playSelectSound() = 0;
	virtual void playConfirmSound() = 0;

	void removeFromSelectionLists();

	virtual void setDestination(int newX, int newY);
	void setHealth(int newHealth);

	virtual void setLocation(int xPos, int yPos);

	void setObjectID(int newObjectID);

	virtual void setTarget(ObjectClass* newTarget);
	void setVisible(int team, bool status);

	/**
        Updates this object.
        \return true if this object still exists, false if it was destroyed
	*/
	virtual bool update() = 0;

	void unassignFromMap(const Coord& location);

	bool isOnScreen() const;
	bool isVisible(int team) const;
	bool isVisible() const;
	int getHealthColour() const;

	virtual Coord getClosestPoint(const Coord& objectLocation) const;

	static ObjectClass* findClosestTargetStructure(ObjectClass* object);
	static ObjectClass* findClosestTargetUnit(ObjectClass* object);

	virtual ObjectClass* findTarget();

	inline void addHealth() { if (health < getMaxHealth()) health+= 1.0; }
	inline void setActive(bool status) { active = status; }
	inline void setForced(bool status) { forced = status; }
	inline void setRespondable(bool status) { respondable = status; }
	inline void setSelected(bool value) { selected = value; }
	inline void setDestination(const Coord& location) { setDestination(location.x, location.y); }
	inline void setLocation(const Coord& location) { setLocation(location.x, location.y); }
	inline bool canAttack() const { return canAttackStuff; }
	inline bool hasATarget() const { return (target); }
	inline bool hasObjectID(Uint32 id) const { return (objectID == id); }
	inline bool isActive() const { return active; }
	inline bool isAFlyingUnit() const { return aFlyingUnit; }
	inline bool isAGroundUnit() const { return aGroundUnit; }
	inline bool isAStructure() const { return aStructure; }
	inline bool isABuilder() const { return aBuilder; }
	inline bool isInfantry() const { return infantry; }
	inline bool isAUnit() const { return aUnit; }
	inline bool isRespondable() const { return respondable; }
	inline bool isSelected() const { return selected; }
	inline bool wasForced() const { return forced; }
	inline int getItemID() const { return itemID; }
	inline int getX() const { return location.x; }
	inline int getY() const { return location.y; }
	inline int getGuardRange() const {
	    // small hack for first mission (otherwise all infantry units would attack the player)
        return std::min(DEFAULT_GUARDRANGE,3*getViewRange());
    }
	inline int getHealth() const { return lround(health); }
	inline int getImageW() const { return imageW; }
	inline int getImageH() const { return imageH; }
	int getMaxHealth() const;
	inline Uint32 getObjectID() const { return objectID; }


	int getRadius() const;
	int getViewRange() const;

	inline double getRealX() const { return realX; }
	inline double getRealY() const { return realY; }
	inline const Coord& getLocation() const { return location; }
	inline const Coord& getDestination() const { return destination; }
	inline ObjectClass* getTarget() { return target.getObjPointer(); }

	inline PlayerClass* getOwner() { return owner; }
	inline const PlayerClass* getOwner() const { return owner; }

	inline void setOwner(PlayerClass* no) { owner = no; }

	static ObjectClass* createObject(int ItemID,PlayerClass* Owner, Uint32 ObjectID = NONE);
	static ObjectClass* loadObject(Stream& stream, int ItemID, Uint32 ObjectID);

protected:
	bool targetInWeaponRange() const;

	// constant for all objects of the same type
    Uint32  itemID;                 ///< The ItemID of this object.
    int     radius;                 ///< The radius of this object

    bool    aStructure;             ///< Is this a structure?
    bool    aBuilder;               ///< Is this a builder?

    bool    aUnit;                  ///< Is this a unit?
	bool    aFlyingUnit;            ///< Is this a flying unit?
	bool    aGroundUnit;            ///< Is this a ground unit?
	bool    infantry;	            ///< Is this an infantry unit?

	bool    canAttackStuff;         ///< Can this unit/structure attack?

    // object state/properties
	Uint32      objectID;           ///< The unique object ID of this object
	PlayerClass *owner;	            ///< The owner of this object

	double  health;                 ///< The health of this object
    bool	badlyDamaged;           ///< Is the health below 50%?

    Coord   location;               ///< The current position of this object in tile coordinates
    Coord   oldLocation;            ///< The previous position of this object in tile coordinates (used when moving from one tile to the next tile)
    Coord   destination;            ///< The destination tile
    double  realX;                  ///< The x-coordinate of this object in world coordinates
    double  realY;                  ///< The y-coordinate of this object in world coordinates

    double  angle;                  ///< The current angle of this unit/structure
    Sint8   drawnAngle;             ///< The angle this unit/structure is drawn with. (e.g. 0 to 7)

	bool	active;                 ///< Is this unit/structure active?
	bool    respondable;            ///< Is this unit/structure respondable to commands?
	bool    selected;               ///< Is this object currently selected?

    bool            forced;         ///< Is this unit/structure forced to do what it currently does or did the micro-AI decide to do that?
	ObjectPointer   target;         ///< The target to attack or move to
    bool            targetFriendly; ///< Is the current target a friendly unit/structure to follow/move to instead to attack?
	ATTACKTYPE      attackMode;     ///< The attack mode of this unit/structure

    bool    visible[MAX_PLAYERS];   ///< To which players is this unit visible?

    // drawing information
    SDL_Surface *graphic;           ///< The graphic for this object
	int         GraphicID;          ///< The id of the graphic (needed if we want to reload the graphic, e.g. when a unit is deviated)
	int         imageW;             ///< The width of the currently used object picture
    int         imageH;             ///< The height of the currently used object picture

    int         smokeCounter;       ///< When to show the next smoke frame?
	int         smokeFrame;         ///< Current smoke frame
};



#endif // OBJECTCLASS_H
