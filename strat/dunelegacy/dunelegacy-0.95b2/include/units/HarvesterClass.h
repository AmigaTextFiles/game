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

#ifndef HARVESTERCLASS_H
#define HARVESTERCLASS_H

#include <units/TrackedUnit.h>

class HarvesterClass : public TrackedUnit
{
public:

	HarvesterClass(PlayerClass* newOwner);
	HarvesterClass(Stream& stream);
	void init();
	~HarvesterClass();

	virtual void save(Stream& stream) const;

	void blitToScreen();

	void checkPos();
	virtual void deploy(const Coord& newLocation);
	void destroy();
	virtual void drawSelectionBox();
	void handleDamage(int damage, Uint32 damagerID);
	void harvesterReturn();

	void move();
	void setAmountOfSpice(double newSpice);
	void setReturned();

	void setDestination(int newX, int newY);
	void setTarget(ObjectClass* newTarget);

	bool canAttack(const ObjectClass* object) const;
	double extractSpice();

	inline void setHarvesting() { harvesting = true; }
	inline double getAmountOfSpice() { return spice; }
	inline bool isReturning() { return returningToRefinery; }
	inline void setReturning(bool returning) { returningToRefinery = returning; };

private:
    // harvester state
	bool	harvesting;             ///< currently harvesting
    bool    returningToRefinery;    ///< currently on the way back to the refinery
	double  spice;                  ///< loaded spice
};

#endif // HARVESTERCLASS_H
