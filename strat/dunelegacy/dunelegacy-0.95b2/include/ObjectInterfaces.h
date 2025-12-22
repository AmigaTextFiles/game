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

#ifndef OBJECTINTERFACES_H
#define OBJECTINTERFACES_H

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <FileClasses/FontManager.h>

#include <GUI/Container.h>
#include <GUI/PictureLabel.h>
#include <GUI/TextButton.h>
#include <GUI/ProgressBar.h>
#include <GUI/dune/BuilderList.h>

#include <GameClass.h>
#include <PlayerClass.h>

#include <ObjectClass.h>
#include <units/UnitClass.h>
#include <units/MCVClass.h>
#include <units/DevastatorClass.h>
#include <structures/StructureClass.h>
#include <structures/BuilderClass.h>
#include <structures/RepairYardClass.h>
#include <structures/PalaceClass.h>

#include <sand.h>
#include <DataTypes.h>

class ObjectInterface : public StaticContainer {
public:
		ObjectInterface() : StaticContainer() { ; };

		virtual ~ObjectInterface() { ; };

		/**
			This method updates the object interface.
			If the object doesn't exists anymore then update returns false.
			\return true = everything ok, false = the object container should be removed
		*/
		virtual bool update() = 0;
};

class DefaultObjectInterface : public ObjectInterface {
public:
	static DefaultObjectInterface* Create(int ObjectID) {
		DefaultObjectInterface* tmp = new DefaultObjectInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	DefaultObjectInterface(int ObjectID) : ObjectInterface() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			fprintf(stderr,"DefaultObjectInterface::DefaultObjectInterface(): Cannot resolve ObjectID %d!\n",ObjectID);
			exit(EXIT_FAILURE);
		}

		this->ObjectID = ObjectID;
		ItemID = pObject->getItemID();

		AddWidget(&TopBox,Point(0,0),Point(GAMEBARWIDTH - 25,100));

		AddWidget(&Main_HBox,Point(0,80),Point(GAMEBARWIDTH - 25,screen->h - 80 - 148));

		TopBox.AddWidget(&TopBox_HBox,Point(0,22),Point(GAMEBARWIDTH - 25,100));

		TopBox_HBox.AddWidget(Spacer::Create());
		TopBox_HBox.AddWidget(&ObjPicture);
		ObjPicture.SetSurface(resolveItemPicture(ItemID),false);

		TopBox_HBox.AddWidget(Spacer::Create());
	};

	virtual ~DefaultObjectInterface() { ; };

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		return (pObject != NULL);
	}

	int				ObjectID;
	int 			ItemID;

	StaticContainer	TopBox;
	HBox			TopBox_HBox;
	HBox			Main_HBox;
	PictureLabel	ObjPicture;
};

class UnitInterface : public DefaultObjectInterface {
public:
	static UnitInterface* Create(int ObjectID) {
		UnitInterface* tmp = new UnitInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	UnitInterface(int ObjectID) : DefaultObjectInterface(ObjectID) {
		Main_HBox.AddWidget(HSpacer::Create(5));

		Button_Aggressive.SetText("Aggressive");
		Button_Aggressive.SetTooltipText("Unit will engage any unit within guard range");
		Button_Aggressive.SetToggleButton(true);
		Button_Aggressive.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnAggressive)));
		Button_VBox.AddWidget(&Button_Aggressive);

		Button_VBox.AddWidget(VSpacer::Create(6));

		Button_Defensive.SetText("Defensive");
		Button_Defensive.SetTooltipText("Unit will remain in approximate location");
		Button_Defensive.SetToggleButton(true);
		Button_Defensive.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnDefensive)));
		Button_VBox.AddWidget(&Button_Defensive);

		Button_VBox.AddWidget(VSpacer::Create(6));

		Button_StandGround.SetText("Stand ground");
		Button_StandGround.SetTooltipText("Unit will not move from location");
		Button_StandGround.SetToggleButton(true);
		Button_StandGround.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnStandGround)));
		Button_VBox.AddWidget(&Button_StandGround);

		Button_VBox.AddWidget(VSpacer::Create(6));

		Button_Scout.SetText("Scout");
		Button_Scout.SetTooltipText("Unit will not move, nor attack");
		Button_Scout.SetToggleButton(true);
		Button_Scout.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnScout)));
		Button_VBox.AddWidget(&Button_Scout);

		Button_VBox.AddWidget(VSpacer::Create(6));

		Button_Deploy.SetText("Deploy");
		Button_Deploy.SetVisible(ItemID == Unit_MCV ? true : false);
		Button_Deploy.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnDeploy)));
		Button_VBox.AddWidget(&Button_Deploy);

		Button_VBox.AddWidget(VSpacer::Create(6));

		Button_Destruct.SetText("Destruct");
		Button_Destruct.SetVisible(ItemID == Unit_Devastator ? true : false);
		Button_Destruct.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&UnitInterface::OnDestruct)));
		Button_VBox.AddWidget(&Button_Destruct);

		Button_VBox.AddWidget(VSpacer::Create(30));

		Main_HBox.AddWidget(&Button_VBox);
		Main_HBox.AddWidget(HSpacer::Create(5));
	}

	void OnAggressive() {
		SetAttackMode(AGGRESSIVE);
	}

	void OnDefensive() {
		SetAttackMode(DEFENSIVE);
	}

	void OnStandGround() {
		SetAttackMode(STANDGROUND);
	}

	void OnScout() {
		SetAttackMode(SCOUT);
	}

	void OnDeploy() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		MCVClass* pMCV = dynamic_cast<MCVClass*>(pObject);
		if(pMCV != NULL) {
			pMCV->HandleDeployClick();
		}
	}

	void OnDestruct() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		DevastatorClass* pDevastator = dynamic_cast<DevastatorClass*>(pObject);
		if(pDevastator != NULL) {
			pDevastator->HandleStartDevastateClick();
		}
	}

	void SetAttackMode(ATTACKTYPE NewAttackMode) {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		UnitClass* pUnit = dynamic_cast<UnitClass*>(pObject);

		if(pUnit != NULL) {
			pUnit->HandleSetAttackModeClick(NewAttackMode);
			pUnit->playConfirmSound();

			update();
		}
	}

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return false;
		}

		UnitClass* pUnit = dynamic_cast<UnitClass*>(pObject);
		if(pUnit != NULL) {
			ATTACKTYPE AttackMode = pUnit->getAttackMode();

			Button_Aggressive.SetToggleState( AttackMode == AGGRESSIVE );
			Button_Defensive.SetToggleState( AttackMode == DEFENSIVE );
			Button_StandGround.SetToggleState( AttackMode == STANDGROUND );
			Button_Scout.SetToggleState( AttackMode == SCOUT );

		}

		return true;
	}

	HBox		Button_HBox;
	VBox		Button_VBox;
	TextButton	Button_Aggressive;
	TextButton	Button_Defensive;
	TextButton	Button_StandGround;
	TextButton	Button_Scout;
	TextButton	Button_Deploy;
	TextButton	Button_Destruct;
};


class DefaultStructureInterface : public DefaultObjectInterface {
public:
	static DefaultStructureInterface* Create(int ObjectID) {
		DefaultStructureInterface* tmp = new DefaultStructureInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	DefaultStructureInterface(int ObjectID) : DefaultObjectInterface(ObjectID) {
		SDL_Surface* surf, *surfPressed;

		surf = pDataManager->getUIGraphic(UI_Repair);
		surfPressed = pDataManager->getUIGraphic(UI_Repair_Pressed);

		Button_Repair.SetSurfaces(surf, false, surfPressed,false);
		Button_Repair.SetToggleButton(true);
		Button_Repair.SetVisible(false);
		Button_Repair.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&DefaultStructureInterface::OnRepair)));

		TopBox.AddWidget(&Button_Repair,Point(2,2),Point(surf->w,surf->h));
	}

	void OnRepair() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		StructureClass* pStructure = dynamic_cast<StructureClass*>(pObject);
		if(pStructure != NULL) {
			pStructure->HandleRepairClick();
		}
	}

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return false;
		}

		StructureClass* pStructure = dynamic_cast<StructureClass*>(pObject);
		if(pStructure != NULL) {
			if(pStructure->getHealth() >= pStructure->getMaxHealth()) {
				Button_Repair.SetVisible(false);
			} else {
				Button_Repair.SetVisible(true);
				Button_Repair.SetToggleState(pStructure->IsRepairing());
			}
		}

		return true;
	}

	PictureButton	Button_Repair;
};

class BuilderInterface : public DefaultStructureInterface {
public:
	static BuilderInterface* Create(int ObjectID) {
		BuilderInterface* tmp = new BuilderInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	BuilderInterface(int ObjectID) : DefaultStructureInterface(ObjectID) {
		Button_Upgrade.SetText("Upgrade");
		Button_Upgrade.SetVisible(false);
		Button_Upgrade.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&BuilderInterface::OnUpgrade)));

		ProgressBar_Upgrade.SetText("Upgrade");
		ProgressBar_Upgrade.SetVisible(false);
		TopBox.AddWidget(&Button_Upgrade,Point(26,2),Point(64,18));
		TopBox.AddWidget(&ProgressBar_Upgrade,Point(26,2),Point(64,18));

		Main_HBox.AddWidget(Spacer::Create());

		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		BuilderClass* pBuilder = dynamic_cast<BuilderClass*>(pObject);
		pBuilderList = BuilderList::Create(pBuilder->getObjectID());
		Main_HBox.AddWidget(pBuilderList);

		Main_HBox.AddWidget(Spacer::Create());
	}


	void OnUpgrade() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		BuilderClass* pBuilder = dynamic_cast<BuilderClass*>(pObject);
		if(pBuilder != NULL) {
			pBuilder->HandleUpgradeClick();
		}
	}

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return false;
		}

		BuilderClass* pBuilder = dynamic_cast<BuilderClass*>(pObject);
		if(pBuilder != NULL) {
			ProgressBar_Upgrade.SetVisible(pBuilder->IsUpgrading());
			Button_Upgrade.SetVisible(!pBuilder->IsUpgrading());

			if(pBuilder->AllowedToUpgrade() == true) {
				ProgressBar_Upgrade.SetProgress((pBuilder->GetUpgradeProgress() * 100)/pBuilder->GetUpgradeCost());
			}

			if(pBuilder->getHealth() >= pBuilder->getMaxHealth()) {
				Button_Repair.SetVisible(false);
				if((pBuilder->AllowedToUpgrade() == true)
					&& (pBuilder->CurrentUpgradeLevel() < pBuilder->MaxUpgradeLevel())) {
					Button_Upgrade.SetVisible(true);
				} else {
					Button_Upgrade.SetVisible(false);
				}
			} else {
				Button_Repair.SetVisible(true);
				Button_Upgrade.SetVisible(false);
				Button_Repair.SetToggleState(pBuilder->IsRepairing());
			}
		}

		return true;
	}

	TextButton		Button_Upgrade;
	TextProgressBar	ProgressBar_Upgrade;
	BuilderList*	pBuilderList;
};

class RepairYardInterface : public DefaultStructureInterface {
public:
	static RepairYardInterface* Create(int ObjectID) {
		RepairYardInterface* tmp = new RepairYardInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	RepairYardInterface(int ObjectID) : DefaultStructureInterface(ObjectID) {
		Main_HBox.AddWidget(Spacer::Create());
		Main_HBox.AddWidget(&RepairUnit);
		Main_HBox.AddWidget(Spacer::Create());
	}

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return false;
		}

		RepairYardClass* pRepairYard = dynamic_cast<RepairYardClass*>(pObject);

		if(pRepairYard != NULL) {
			UnitClass* pUnit = pRepairYard->getRepairUnit();

			if(pUnit != NULL) {
				RepairUnit.SetVisible(true);
				RepairUnit.SetSurface(resolveItemPicture(pUnit->getItemID()),false);
				RepairUnit.SetProgress((pUnit->getHealth()*100)/pUnit->getMaxHealth());
			} else {
				RepairUnit.SetVisible(false);
			}
		}

		return DefaultStructureInterface::update();
	}

private:
	PictureProgressBar	RepairUnit;
};

class PalaceInterface : public DefaultStructureInterface {
public:
	static PalaceInterface* Create(int ObjectID) {
		PalaceInterface* tmp = new PalaceInterface(ObjectID);
		tmp->pAllocated = true;
		return tmp;
	}

protected:
	PalaceInterface(int ObjectID) : DefaultStructureInterface(ObjectID) {
		Main_HBox.AddWidget(&WeaponBox);

		SDL_Surface* pSurface = pDataManager->getSmallDetailPic(Picture_DeathHand);
		WeaponBox.AddWidget(&Weapon,Point((GAMEBARWIDTH - 25 - pSurface->w)/2,0),
									Point(pSurface->w, pSurface->h));

		WeaponBox.AddWidget(&WeaponSelect,Point((GAMEBARWIDTH - 25 - pSurface->w)/2,0),
									Point(pSurface->w, pSurface->h));

		SDL_Surface* pText = pFontManager->createSurfaceWithText("READY", COLOUR_WHITE, FONT_STD10);


		SDL_Surface* pReady = SDL_CreateRGBSurface(SDL_HWSURFACE,pSurface->w,pSurface->h,8,0,0,0,0);
		SDL_SetColors(pReady, palette->colors, 0, palette->ncolors);
		SDL_SetColorKey(pReady, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

		SDL_Rect dest = { (pReady->w - pText->w)/2,(pReady->h - pText->h)/2, pText->w, pText->h };
		SDL_BlitSurface(pText, NULL, pReady, &dest);

		SDL_FreeSurface(pText);
		WeaponSelect.SetSurfaces(pReady,true);
		WeaponSelect.SetVisible(false);

		WeaponSelect.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&PalaceInterface::OnSpecial)));
	}

	/**
		This method updates the object interface.
		If the object doesn't exists anymore then update returns false.
		\return true = everything ok, false = the object container should be removed
	*/
	virtual bool update() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return false;
		}

		PalaceClass* pPalace = dynamic_cast<PalaceClass*>(pObject);

		if(pPalace != NULL) {
			int picID;

			switch (pPalace->getOwner()->getHouse())
			{
				case(HOUSE_ATREIDES): case(HOUSE_FREMEN):
					picID = Picture_Fremen;
					break;
				case(HOUSE_ORDOS): case(HOUSE_MERCENARY):
					picID = Picture_Saboteur;
					break;
				case(HOUSE_HARKONNEN): case(HOUSE_SARDAUKAR):
					picID = Picture_DeathHand;
					break;
				default:
					picID = Picture_Fremen;
					break;
			}

			Weapon.SetSurface(pDataManager->getSmallDetailPic(picID),false);
			Weapon.SetProgress(pPalace->getPercentComplete());

			WeaponSelect.SetVisible(pPalace->specialReady());
		}

		return DefaultStructureInterface::update();
	}

private:
	void OnSpecial() {
		ObjectClass* pObject = currentGame->getObjectManager().getObject(ObjectID);
		if(pObject == NULL) {
			return;
		}

		PalaceClass* pPalace = dynamic_cast<PalaceClass*>(pObject);

		if(pPalace != NULL) {
			pPalace->HandleSpecialClick();
		}
	};

	StaticContainer		WeaponBox;
	PictureProgressBar	Weapon;
	PictureButton		WeaponSelect;
};

#endif //OBJECTINTERFACES_H
