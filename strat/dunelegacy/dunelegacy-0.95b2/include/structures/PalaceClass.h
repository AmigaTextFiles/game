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

#ifndef PALACECLASS_H
#define PALACECLASS_H

#include <structures/StructureClass.h>

class PalaceClass : public StructureClass
{
public:
	PalaceClass(PlayerClass* newOwner);
    PalaceClass(Stream& stream);
	void init();
	~PalaceClass();

	virtual void save(Stream& stream) const;

	virtual ObjectInterface* GetInterfaceContainer();

	void HandleSpecialClick();
	void DoSpecialWeapon();
	static void netDoSpecial(void* voidPalace);
	void doSpecificStuff();
	void setSpecialTimer(int time);
	bool callFremen();
	bool launchDeathhand();
	bool spawnSaboteur();
	double getPercentComplete();

	inline bool specialReady() { return (specialTimer == 0); }
	inline int getSpecialTimer() { return specialTimer; }

private:
	Sint32  specialTimer;       ///< When is the special weapon ready?
};

#endif // PALACECLASS_H
