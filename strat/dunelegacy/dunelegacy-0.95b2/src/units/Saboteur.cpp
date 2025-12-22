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

#include <units/Saboteur.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <PlayerClass.h>
#include <MapClass.h>


Saboteur::Saboteur(PlayerClass* newOwner) : InfantryClass(newOwner)
{
    Saboteur::init();

    health = getMaxHealth();

	setVisible(VIS_ALL, false);
	setVisible(getOwner()->getTeam(), true);
    attackMode = SCOUT;
}

Saboteur::Saboteur(Stream& stream) : InfantryClass(stream)
{
    Saboteur::init();
}

void Saboteur::init()
{
	itemID = Unit_Saboteur;
	owner->incrementUnits(itemID);

	GraphicID = ObjPic_Saboteur;
	graphic = pDataManager->getObjPic(GraphicID,getOwner()->getColour());

	imageW = graphic->w/4;
	imageH = graphic->h/3;

	numWeapons = 0;
}

Saboteur::~Saboteur()
{
}


void Saboteur::checkPos()
{
	bool	canBeSeen[MAX_PLAYERS+1];
	int		i, j;


	InfantryClass::checkPos();
	if(active) {
		for(i = 1; i <= MAX_PLAYERS; i++)
			canBeSeen[i] = false;


		for(i = location.x - 2; (i <= location.x + 2); i++)
			for(j = location.y - 2; (j <= location.y + 2); j++)
				if (currentGameMap->cellExists(i, j) && currentGameMap->getCell(i, j)->hasAnObject())
					canBeSeen[currentGameMap->getCell(i, j)->getObject()->getOwner()->getTeam()] = true;


		for(i = 1; i <= MAX_PLAYERS; i++)
			setVisible(i, canBeSeen[i]);


		setVisible(getOwner()->getTeam(), true);	//owner team can always see it
		//setVisible(thisPlayer->getTeam(), true);
	}
}

bool Saboteur::update() {
	if(active) {
		if (moving == false) {
			//check to osee if close enough to blow up target
			if (target && target.getObjPointer()->isAStructure()
				&& (getOwner()->getTeam() != target.getObjPointer()->getOwner()->getTeam()))
			{
				Coord	closestPoint;
				closestPoint = target.getObjPointer()->getClosestPoint(location);


				if (blockDistance(location, closestPoint) <= 1.5)	{
					target.getObjPointer()->destroy();
					destroy();
					return false;
				}
			}
		}
	}

	return UnitClass::update();
}

void Saboteur::deploy(const Coord& newLocation)
{
	UnitClass::deploy(newLocation);

	setVisible(VIS_ALL, false);
	setVisible(getOwner()->getTeam(), true);
}


bool Saboteur::canAttack(const ObjectClass* object) const
{
	if ((object != NULL) && object->isAStructure()
		&& (object->getOwner()->getTeam() != owner->getTeam())
		&& object->isVisible(getOwner()->getTeam()))
		return true;
	else
		return false;
}
