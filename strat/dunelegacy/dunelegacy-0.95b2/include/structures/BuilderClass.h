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

#ifndef BUILDERCLASS_H
#define BUILDERCLASS_H

#include <structures/StructureClass.h>

#include <data.h>

#include <list>
#include <string>

class BuildItem {
public:
	BuildItem() {
		ItemID = ItemID_Invalid;
		price = 0;
		num = 0;
		name = "Unknown Item";
	}

	BuildItem(	int ItemID, int price, std::string name) {
		this->ItemID = ItemID;
		this->price = price;
		this->name = name;
		num = 0;
	}

	void save(Stream& stream) const {
		stream.writeUint32(ItemID);
		stream.writeUint32(price);
		stream.writeUint32(num);
		stream.writeString(name);
	}

	void load(Stream& stream) {
		ItemID = stream.readUint32();
		price = stream.readUint32();
		num = stream.readUint32();
		name = stream.readString();
	}

	Uint32 ItemID;
	Uint32 price;
	Uint32 num;
	std::string name;
};


class BuilderClass : public StructureClass
{
public:
	BuilderClass(PlayerClass* newOwner);
    BuilderClass(Stream& stream);
	void init();
	~BuilderClass();

	virtual void save(Stream& stream) const;

	virtual ObjectInterface* GetInterfaceContainer();

	void setOwner(PlayerClass *no);

	void checkMinMaxSelection();
	virtual void checkSelectionList() { ; };	//goes and sees what should be in its list

	void setWaitingToPlace();
	void unSetWaitingToPlace();

	int getNumSelections() { return BuildList.size();} ;

	int getNumItemsToBuild() { return CurrentProductionList.size(); };

	/**
        Updates this builder.
        \return true if this object still exists, false if it was destroyed
	*/
	virtual bool update();

	void HandleUpgradeClick();
	void HandleProduceItemClick(Uint32 ItemID, bool multipleMode = false);
	void HandleCancelItemClick(Uint32 ItemID, bool multipleMode = false);
	void HandleSetOnHoldClick(bool OnHold);

	virtual void DoUpgrade();
	virtual void DoProduceItem(Uint32 ItemID, bool multipleMode = false);
	virtual void DoCancelItem(Uint32 ItemID, bool multipleMode = false);
	inline void DoSetOnHold(bool OnHold) { CurrentItemOnHold = OnHold; };


	inline bool IsUpgrading() { return upgrading; };
	inline bool AllowedToUpgrade() { return allowedToUpgrade; };
	inline int CurrentUpgradeLevel() { return curUpgradeLev; };
	inline int MaxUpgradeLevel() { return upgradeLevels; };
	inline int GetUpgradeCost() { return upgradeCost; };
	inline double GetUpgradeProgress() { return upgradeProgress; };

	inline Uint32 GetCurrentProducedItem() { return CurrentProducedItem; };
	inline bool IsOnHold() { return CurrentItemOnHold; };
	bool IsWaitingToPlace();
	inline double GetProductionProgress() { return ProductionProgress; };
	inline std::list<BuildItem>& GetBuildList() { return BuildList; };
	virtual void InsertItem(std::list<BuildItem>& List, std::list<BuildItem>::iterator& iter, Uint32 itemID, int price=-1);
	void RemoveItem(std::list<BuildItem>& List, std::list<BuildItem>::iterator& iter, Uint32 itemID);

	virtual void buildRandom();

	virtual void buildUpdate();

protected:
	BuildItem* GetBuildItem(Uint32 ItemID) {
		std::list<BuildItem>::iterator iter;
		for(iter = BuildList.begin(); iter != BuildList.end(); ++iter) {
			if(iter->ItemID == ItemID) {
				return &(*iter);
			}
		}
		return NULL;
	}

	void ProduceNextAvailableItem();

    // constant for all builders of the same type
    bool    allowedToUpgrade;       ///< Is this structure an upgradeable structure?
    int     upgradeCost;            ///< How much is the upgrade?
    Uint8   upgradeLevels;          ///< How many upgrade levels are possible (depends on tech level)

    // structure state
    bool    upgrading;              ///< Currently upgrading?
	double  upgradeProgress;        ///< The current state of the upgrade progress (measured in money spent)
	Uint8   curUpgradeLev;          ///< Current upgrade level

	bool    CurrentItemOnHold;      ///< Is the currently produced item on hold?
	Uint32  CurrentProducedItem;    ///< The ItemID of the currently produced item
	double  ProductionProgress;     ///< The current state of the production progress (measured in money spent)

	std::list<Uint32>       CurrentProductionList;      ///< This list is the production queue (It contains the item IDs of the units/structures to produce)
	std::list<BuildItem>    BuildList;                  ///< This list contains all the things that can be produced by this builder
};

#endif //BUILDERCLASS_H
