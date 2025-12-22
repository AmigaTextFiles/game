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

#include <Menu/MapChoice.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <FileClasses/INIFile.h>

#include <sand.h>

MapChoice::MapChoice(int newHouse, unsigned int LastMission) {
	DisableQuiting(true);
	selectedRegion = -1;
	MapChoiceState = MAPCHOICESTATE_BLENDING;
	curHouse2Blit = 0;
	curRegion2Blit = 0;
	curBlendBlitter = NULL;
	LastScenario = (LastMission + 1)/3 + 1;
	house = newHouse;

	// set up window
	SDL_Surface *surf;
	surf = pDataManager->getUIGraphic(UI_MapChoiceScreen,house);

	SetBackground(surf,false);

	int xpos = std::max(0,(screen->w - surf->w)/2);
	int ypos = std::max(0,(screen->h - surf->h)/2);

	SetCurrentPosition(xpos,ypos,surf->w,surf->h);

	// load all data from ini
	LoadINI();

	PrepareMapSurface();
}

MapChoice::~MapChoice() {
	if(curBlendBlitter != NULL) {
		delete curBlendBlitter;
		curBlendBlitter = NULL;
	}

	if(MapSurface != NULL) {
		SDL_FreeSurface(MapSurface);
		MapSurface = NULL;
	}
}

void MapChoice::DrawSpecificStuff() {
	SDL_Rect dest1 = {GetPosition().x,GetPosition().y,GetSize().x,GetSize().y};
	SDL_BlitSurface(MapSurface,NULL,screen,&dest1);

	switch(MapChoiceState) {
	case MAPCHOICESTATE_BLENDING:
	case MAPCHOICESTATE_FASTBLENDING:
	{
		if(curBlendBlitter == NULL) {
			while(	(curHouse2Blit < NUM_HOUSES) &&
					(curRegion2Blit >= Group[LastScenario].newRegion[curHouse2Blit].size())) {
					curRegion2Blit = 0;
					curHouse2Blit++;
			}

			if((curHouse2Blit < NUM_HOUSES)&&(curRegion2Blit < Group[LastScenario].newRegion[curHouse2Blit].size())) {
				// there is still some region to blend in
				int PieceNum = (Group[LastScenario].newRegion[curHouse2Blit])[curRegion2Blit];
				SDL_Surface* PieceSurface = pDataManager->getMapChoicePiece(PieceNum,curHouse2Blit);
				SDL_Rect dest = {	PiecePosition[PieceNum].x,PiecePosition[PieceNum].y,
									PieceSurface->w, PieceSurface->h};
				curBlendBlitter = new BlendBlitter(PieceSurface,MapSurface,dest);
				curRegion2Blit++;
			} else {
				MapChoiceState = MAPCHOICESTATE_ARROWS;
			}
		}

		if(curBlendBlitter != NULL) {
			int numSteps = 1;
			if(MapChoiceState == MAPCHOICESTATE_FASTBLENDING) {
				numSteps = 8;
			}

			for(int i = 0; i < numSteps; i++) {
				if(curBlendBlitter->nextStep() == 0) {
					delete curBlendBlitter;
					curBlendBlitter = NULL;
					break;
				}
			}
		}
	} break;

	case MAPCHOICESTATE_ARROWS:
	{
		// Draw arrows
		for(int i = 0; i < 4; i++) {
			if(Group[LastScenario].AttackRegion[i].RegionNum == 0) {
				continue;
			}

			SDL_Surface* arrow = pDataManager->getMapChoiceArrow(Group[LastScenario].AttackRegion[i].ArrowNum);
			SDL_Rect dest = {	Group[LastScenario].AttackRegion[i].ArrowPosition.x + GetPosition().x,
								Group[LastScenario].AttackRegion[i].ArrowPosition.y + GetPosition().y,
								arrow->w,arrow->h};

			SDL_BlitSurface(arrow,NULL,screen,&dest);
		}
	} break;

	case MAPCHOICESTATE_BLINKING:
	{
		if(((SDL_GetTicks() - selectionTime) % 900) < 450) {
			SDL_Surface* PieceSurface = pDataManager->getMapChoicePiece(selectedRegion,house);
			SDL_Rect dest = {	PiecePosition[selectedRegion].x + GetPosition().x,
								PiecePosition[selectedRegion].y + GetPosition().y,
								PieceSurface->w, PieceSurface->h};
			SDL_BlitSurface(PieceSurface,NULL,screen,&dest);
		}

		if((SDL_GetTicks() - selectionTime) > 2000) {
			int RegionIndex;
			for(RegionIndex = 0; RegionIndex < 4; RegionIndex++) {
				if(Group[LastScenario].AttackRegion[RegionIndex].RegionNum == selectedRegion) {
					break;
				}
			}

			int newMission;
			if(LastScenario < 7) {
				newMission = (((LastScenario - 1) * 3) + 1) + ((RegionIndex % 3) + 1);
			} else if(LastScenario == 7) {
				newMission = (((LastScenario - 1) * 3) + 1) + ((RegionIndex % 2) + 1);
			} else if(LastScenario == 8) {
				newMission = 22;
			} else {
				fprintf(stdout,"MapChoice::DrawSpecificStuff(): LastScenario (%d) is no valid scenario!\n",LastScenario);
				exit(EXIT_FAILURE);
			}

			quit(newMission);
		}
	} break;

	}
}

bool MapChoice::doInput(SDL_Event &event) {
	if((event.type == SDL_MOUSEBUTTONUP) && (event.button.button == SDL_BUTTON_LEFT)) {
		switch(MapChoiceState) {
			case MAPCHOICESTATE_BLENDING:
			{
				MapChoiceState = MAPCHOICESTATE_FASTBLENDING;
			} break;

			case MAPCHOICESTATE_ARROWS:
			{
				int x = event.button.x-GetPosition().x;
				int y = event.button.y-GetPosition().y;

				if((x > 0) && (x < GetSize().x) && (y > 0) && (y < GetSize().y)) {
					SDL_Surface* clickmap = pDataManager->getUIGraphic(UI_MapChoiceClickMap);

					if(SDL_LockSurface(clickmap) != 0) {
						fprintf(stdout,"MapChoice::doInput(): Cannot lock image!\n");
						exit(EXIT_FAILURE);
					}

					Uint8 RegionNum = ((Uint8*)clickmap->pixels)[y * clickmap->pitch + x];

					SDL_UnlockSurface(clickmap);

					if(RegionNum != 0) {
						for(int i = 0; i < 4; i++) {
							if(Group[LastScenario].AttackRegion[i].RegionNum == RegionNum) {
								MapChoiceState = MAPCHOICESTATE_BLINKING;
								selectedRegion = RegionNum;
								selectionTime = SDL_GetTicks();
								break;
							}
						}
					}
				}
			} break;
		}
	}
	return MenuClass::doInput(event);
}

void MapChoice::PrepareMapSurface() {
	// Load map surface
	MapSurface = copySurface(pDataManager->getUIGraphic(UI_MapChoiceMap));

	for(unsigned int s = 1; s < LastScenario; s++) {
		for(unsigned int h = 0; h < NUM_HOUSES; h++) {
			for(unsigned int p = 0; p < Group[s].newRegion[h].size(); p++) {
				int PieceNum = (Group[s].newRegion[h])[p];
				SDL_Surface* PieceSurface = pDataManager->getMapChoicePiece(PieceNum,h);
				SDL_Rect dest = {	PiecePosition[PieceNum].x,PiecePosition[PieceNum].y,
									PieceSurface->w, PieceSurface->h};
				SDL_BlitSurface(PieceSurface,NULL,MapSurface,&dest);
			}
		}
	}
}

void MapChoice::LoadINI() {
	std::string filename = "REGION";
	switch(house) {
		case HOUSE_ATREIDES:
			filename += "A";
			break;
		case HOUSE_ORDOS:
			filename += "O";
			break;
		case HOUSE_HARKONNEN:
			filename += "H";
			break;
		default:
			fprintf(stdout,"MapChoice::LoadINI(): There exists no map for this house (house number: %d)!\n",house);
			exit(EXIT_FAILURE);
	}
	filename += ".INI";

	SDL_RWops* file;
	if((file = pFileManager->OpenFile(filename)) == NULL) {
		fprintf(stdout,"MapChoice::LoadINI(): Cannot open %s!\n",filename.c_str());
		exit(EXIT_FAILURE);
	}

	INIFile RegionINI(file);
	SDL_RWclose(file);


	PiecePosition[0].x = 0;
	PiecePosition[0].y = 0;

	// read [PIECES]
	for(int i=1; i < 28; i++) {
		char tmp[3];
		sprintf(tmp,"%d",i);
		std::string entry = RegionINI.getStringValue("PIECES",tmp);

		std::string StrXPos;
		std::string StrYPos;

		if(SplitString(entry,2,&StrXPos,&StrYPos) == false) {
			fprintf(stdout,"MapChoice::LoadINI(): File %s is invalid!\n",filename.c_str());
			exit(EXIT_FAILURE);
		}

		PiecePosition[i].x = atol(StrXPos.c_str());
		PiecePosition[i].y = atol(StrYPos.c_str());
		PiecePosition[i].x += 8;
		PiecePosition[i].y += 24;
		PiecePosition[i].x *= 2;
		PiecePosition[i].y *= 2;
	}

	for(int i=1; i<=8; i++) {
		char StrSection[8];
		sprintf(StrSection,"GROUP%d",i);

		// read new regions
		for(int h = 0; h < NUM_HOUSES; h++) {
			std::string key;
			switch(h) {
				case HOUSE_ATREIDES:	key = "ATR"; break;
				case HOUSE_ORDOS:		key = "ORD"; break;
				case HOUSE_HARKONNEN:	key = "HAR"; break;
				case HOUSE_SARDAUKAR:	key = "SAR"; break;
				case HOUSE_FREMEN:		key = "FRE"; break;
				case HOUSE_MERCENARY:	key = "MER"; break;
			}

			std::string	StrValue = RegionINI.getStringValue(StrSection,key);
			if(StrValue != "") {
				std::vector<std::string> StrRegions = SplitString(StrValue);

				for(unsigned int r = 0; r < StrRegions.size(); r++) {
					Group[i].newRegion[h].push_back(atol(StrRegions[r].c_str()));
				}
			}
		}

		// read AttackRegion (REG1, REG2, REG3)
		for(int a = 0; a < 4; a++) {
			char StrKey[5];
			sprintf(StrKey,"REG%d",a+1);

			std::string tmp = RegionINI.getStringValue(StrSection,StrKey);
			if(tmp == "") {
				Group[i].AttackRegion[a].RegionNum = 0;
				Group[i].AttackRegion[a].ArrowNum = 0;
				Group[i].AttackRegion[a].ArrowPosition.x = 0;
				Group[i].AttackRegion[a].ArrowPosition.y = 0;
			} else {
				std::vector<std::string> StrAttackRegion = SplitString(tmp);

				if(StrAttackRegion.size() < 4) {
					fprintf(stdout,"MapChoice::LoadINI(): %s:[%s]/%s has to have 4 numbers!\n",filename.c_str(),StrSection,StrKey);
					exit(EXIT_FAILURE);
				}

				Group[i].AttackRegion[a].RegionNum = atol(StrAttackRegion[0].c_str());
				Group[i].AttackRegion[a].ArrowNum = atol(StrAttackRegion[1].c_str());
				Group[i].AttackRegion[a].ArrowPosition.x = atol(StrAttackRegion[2].c_str());
				Group[i].AttackRegion[a].ArrowPosition.y = atol(StrAttackRegion[3].c_str());
				Group[i].AttackRegion[a].ArrowPosition.x *= 2;
				Group[i].AttackRegion[a].ArrowPosition.y *= 2;
			}
		}

		// read text
		for(int j = 1; j < 28; j++) {
			char Key[10];
			sprintf(Key,"%sTXT%d",settings.General.LanguageExt.c_str(),j);

			std::string str = RegionINI.getStringValue(StrSection,Key);
			if(str != "") {
				TGroup::TText tmp;
				tmp.Message = str;
				tmp.Region = j;
				Group[i].Text.push_back(tmp);
			}
		}
	}
}
