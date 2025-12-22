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

#include <Menu/MentatMenu.h>

#include <globals.h>

#include <FileClasses/DataManager.h>

MentatMenu::MentatMenu(int newHouse) : MenuClass()
{
	Animation* anim;

	DisableQuiting(true);
	house = newHouse;

	// set up window
	SDL_Surface *surf;
	surf = pDataManager->getUIGraphic(UI_MentatBackground,house);

	SetBackground(surf,false);

	int xpos = std::max(0,(screen->w - surf->w)/2);
	int ypos = std::max(0,(screen->h - surf->h)/2);

	SetCurrentPosition(xpos,ypos,surf->w,surf->h);

	SetWindowWidget(&WindowWidget);

	switch(house) {
		case HOUSE_ATREIDES:
		case HOUSE_FREMEN:
			anim = pDataManager->getAnimation(Anim_AtreidesEyes);
			eyesAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&eyesAnim,Point(80,160),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_AtreidesMouth);
			mouthAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&mouthAnim,Point(80,192),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_AtreidesBook);
			specialAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&specialAnim,Point(145,305),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_AtreidesShoulder);
			shoulderAnim.SetAnimation(anim);
			// don't add shoulderAnim, draw it in DrawSpecificStuff
			break;
		case HOUSE_ORDOS:
		case HOUSE_MERCENARY:
			anim = pDataManager->getAnimation(Anim_OrdosEyes);
			eyesAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&eyesAnim,Point(32,160),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_OrdosMouth);
			mouthAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&mouthAnim,Point(32,192),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_OrdosRing);
			specialAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&specialAnim,Point(178,289),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_OrdosShoulder);
			shoulderAnim.SetAnimation(anim);
			// don't add shoulderAnim, draw it in DrawSpecificStuff
			break;
		case HOUSE_HARKONNEN:
		case HOUSE_SARDAUKAR:
		default:
			anim = pDataManager->getAnimation(Anim_HarkonnenEyes);
			eyesAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&eyesAnim,Point(64,176),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_HarkonnenMouth);
			mouthAnim.SetAnimation(anim);
			WindowWidget.AddWidget(&mouthAnim,Point(64,208),Point(anim->getFrame()->w,anim->getFrame()->h));

			anim = pDataManager->getAnimation(Anim_HarkonnenShoulder);
			shoulderAnim.SetAnimation(anim);
			// don't add shoulderAnim, draw it in DrawSpecificStuff
			break;
	}

	TextLabel.SetTextColor(255);
	TextLabel.SetVisible(false);
}

MentatMenu::~MentatMenu() {
}

void MentatMenu::DrawSpecificStuff() {
	Point shoulderPos;
	switch(house) {
		case HOUSE_ATREIDES:
		case HOUSE_FREMEN: {
			shoulderPos = Point(256,257) + GetPosition();
		} break;
		case HOUSE_ORDOS:
		case HOUSE_MERCENARY: {
			shoulderPos = Point(256,257) + GetPosition();
		} break;
		case HOUSE_HARKONNEN:
		case HOUSE_SARDAUKAR:
		default: {
			shoulderPos = Point(256,209) + GetPosition();
		} break;
	}

	shoulderAnim.Draw(screen,shoulderPos);
	TextLabel.Draw(screen,Point(10,5) + GetPosition());
}
