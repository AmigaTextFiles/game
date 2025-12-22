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

#include <Menu/BriefingMenu.h>

#include <globals.h>

#include <FileClasses/DataManager.h>

#include <stdlib.h>

BriefingMenu::BriefingMenu(int newHouse,int mission,int type) : MentatMenu(newHouse) {
	this->mission = mission;

	Animation* anim = NULL;

	SDL_Surface* surf;
	SDL_Surface* surfPressed;

	surf = pDataManager->getUIGraphic(UI_MentatProcced);
	surfPressed = pDataManager->getUIGraphic(UI_MentatProcced_Pressed);
	ProccedButton.SetSurfaces(surf,false,surfPressed,false);
	ProccedButton.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&BriefingMenu::OnProcced)));
	WindowWidget.AddWidget(&ProccedButton,Point(500,340),Point(surf->w,surf->h));

	int missionnumber;
	if(mission != 22) {
		missionnumber = ((mission+1)/3)+1;
	} else {
		missionnumber = 9;
	}

	switch(type) {
		case DEBRIEFING_WIN:
			anim = pDataManager->getAnimation((rand() % 2 == 0) ? Anim_Win1 : Anim_Win2);
			setText(pDataManager->GetBriefingText(missionnumber,MISSION_WIN,house));
			break;
		case DEBRIEFING_LOST:
			anim = pDataManager->getAnimation((rand() % 2 == 0) ? Anim_Lose1 : Anim_Lose2);
			setText(pDataManager->GetBriefingText(missionnumber,MISSION_LOSE,house));
			break;
		default:
		case BRIEFING:
		{
			switch(missionnumber) {
				case 1:
					anim = pDataManager->getAnimation(Anim_Harvester);
					break;
				case 2:
					anim = pDataManager->getAnimation(Anim_Radar);
					break;
				case 3:
					anim = pDataManager->getAnimation(Anim_Quad);
					break;
				case 4:
					anim = pDataManager->getAnimation(Anim_Tank);
					break;
				case 5:
					anim = pDataManager->getAnimation(Anim_RepairYard);
					break;
				case 6:
					anim = pDataManager->getAnimation(Anim_StarPort);
					break;
				case 7:
					anim = pDataManager->getAnimation(Anim_IX);
					break;
				case 8:
					anim = pDataManager->getAnimation(Anim_Palace);
					break;
				default:
					anim = pDataManager->getAnimation(Anim_ConstructionYard);
					break;
			}
			setText(pDataManager->GetBriefingText(missionnumber,MISSION_DESCRIPTION,house));
		} break;
	}
	Anim.SetAnimation(anim);
	WindowWidget.AddWidget(&Anim,Point(257,97),Point(anim->getFrame()->w,anim->getFrame()->h));
}

BriefingMenu::~BriefingMenu() {
}

void BriefingMenu::OnRepeat() {

}

void BriefingMenu::OnProcced() {
	quit(0);
}
