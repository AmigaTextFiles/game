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

#include <Menu/SinglePlayerMenu.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <misc/fnkdat.h>

#include <Menu/SinglePlayerSkirmishMenu.h>
#include <Menu/HouseChoiceMenu.h>

#include <GUI/dune/LoadSaveWindow.h>

#include <GameInitClass.h>
#include <sand.h>

SinglePlayerMenu::SinglePlayerMenu() : MenuClass()
{
	// set up window
	SDL_Surface *surf;
	surf = pDataManager->getUIGraphic(UI_MenuBackground);

	SetBackground(surf,false);
	Resize(surf->w,surf->h);

	SetWindowWidget(&WindowWidget);

	// set up pictures in the background
	surf = pDataManager->getUIGraphic(UI_PlanetBackground);
	PlanetPicture.SetSurface(surf,false);
	WindowWidget.AddWidget(&PlanetPicture,
							Point((screen->w - surf->w)/2,screen->h/2 - surf->h + 10),
							Point(surf->w,surf->h));

	surf = pDataManager->getUIGraphic(UI_DuneLegacy);
	DuneLegacy.SetSurface(surf,false);
	WindowWidget.AddWidget(&DuneLegacy,
							Point((screen->w - surf->w)/2, screen->h/2 + 28),
							Point(surf->w,surf->h));

	surf = pDataManager->getUIGraphic(UI_MenuButtonBorder);
	ButtonBorder.SetSurface(surf,false);
	WindowWidget.AddWidget(&ButtonBorder,
							Point((screen->w - surf->w)/2, screen->h/2 + 59),
							Point(surf->w,surf->h));

	// set up menu buttons
	WindowWidget.AddWidget(&MenuButtons,Point((screen->w - 160)/2,screen->h/2 + 64),
										Point(160,111));

	Button_Campaign.SetText("CAMPAIGN");
	Button_Campaign.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnCampaign)));
	MenuButtons.AddWidget(&Button_Campaign);
	Button_Campaign.SetActive();

	MenuButtons.AddWidget(VSpacer::Create(3));

	Button_Custom.SetText("CUSTOM GAME");
	Button_Custom.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnCustom)));
	Button_Custom.SetEnabled(false);
	MenuButtons.AddWidget(&Button_Custom);

	MenuButtons.AddWidget(VSpacer::Create(3));

	Button_Skirmish.SetText("SKIRMISH");
	Button_Skirmish.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnSkirmish)));
	MenuButtons.AddWidget(&Button_Skirmish);

	MenuButtons.AddWidget(VSpacer::Create(3));

	Button_LoadSavegame.SetText("LOAD GAME");
	Button_LoadSavegame.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnLoadSavegame)));
	MenuButtons.AddWidget(&Button_LoadSavegame);

	MenuButtons.AddWidget(VSpacer::Create(3));

	// here is one button space left
	Button_LoadReplay.SetText("LOAD REPLAY");
	Button_LoadReplay.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnLoadReplay)));
	MenuButtons.AddWidget(&Button_LoadReplay);

	MenuButtons.AddWidget(VSpacer::Create(3));

	Button_Cancel.SetText("CANCEL");
	Button_Cancel.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnCancel)));
	MenuButtons.AddWidget(&Button_Cancel);


	// Difficulty Button
	surf = pDataManager->getUIGraphic(UI_Difficulty);
	Picture_Difficulty.SetSurface(surf,false);
	WindowWidget.AddWidget(	&Picture_Difficulty,
							Point((screen->w-160)/4 - surf->w/2,screen->h/2 + 64),
							Point(surf->w,surf->h));

	surf = pDataManager->getUIGraphic(UI_Dif_Medium);
	Button_Difficulty.SetSurfaces(surf,false);
	Button_Difficulty.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&SinglePlayerMenu::OnDifficulty)));
	WindowWidget.AddWidget(	&Button_Difficulty,
							Point((screen->w-160)/4 - surf->w/2 - 1,screen->h/2 + 104),
							Point(surf->w,surf->h));

	UpdateDifficulty();
}

SinglePlayerMenu::~SinglePlayerMenu()
{
}

void SinglePlayerMenu::OnCampaign()
{
	GameInitClass * init;
	int player;

	HouseChoiceMenu* myHouseChoiceMenu = new HouseChoiceMenu();
	if(myHouseChoiceMenu == NULL) {
		perror("SinglePlayerMenu::OnCampaign()");
		exit(EXIT_FAILURE);
	}
	player = myHouseChoiceMenu->showMenu();
	delete myHouseChoiceMenu;

	if(player < 0) {
		return;
	}

	init = new GameInitClass();

	init->setCampaign((PLAYERHOUSE) player,1,settings.playerDifficulty[0]);

	startSinglePlayerGame(init);

	quit();
}

void SinglePlayerMenu::OnCustom()
{
	; //You should first enable this Button :)
}

void SinglePlayerMenu::OnSkirmish()
{

	SinglePlayerSkirmishMenu* mySkirmish = new SinglePlayerSkirmishMenu();
	if(mySkirmish == NULL) {
		perror("SinglePlayerMenu::OnSkirmish()");
		exit(EXIT_FAILURE);
	}
	mySkirmish->showMenu();
	delete mySkirmish;

	// Submenu might have changed difficulty
	UpdateDifficulty();
}

void SinglePlayerMenu::OnLoadSavegame()
{
	char tmp[FILENAME_MAX];
	fnkdat("save/", tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
	std::string savepath(tmp);
	OpenWindow(LoadSaveWindow::Create(false, "Load Game", savepath, "dls"));
}

void SinglePlayerMenu::OnLoadReplay()
{
	char tmp[FILENAME_MAX];
	fnkdat("replay/", tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
	std::string replaypath(tmp);
	OpenWindow(LoadSaveWindow::Create(false, "Load Replay", replaypath, "rpl"));
}

void SinglePlayerMenu::OnCancel()
{
	quit();
}

void SinglePlayerMenu::OnDifficulty()
{
	DIFFICULTYTYPE	newDif = settings.playerDifficulty[0];

	switch(newDif) {
		case EASY:
			newDif = MEDIUM;
			break;
		case MEDIUM:
			newDif = HARD;
			break;
		case HARD:
		default:
			newDif = EASY;
			break;
	}

	for (int i = 0; i < MAX_PLAYERS; i++) {
		settings.playerDifficulty[i] = newDif;
	}

	UpdateDifficulty();
}


void SinglePlayerMenu::UpdateDifficulty()
{
	if (settings.playerDifficulty[0] == EASY) {
		Button_Difficulty.SetSurfaces(pDataManager->getUIGraphic(UI_Dif_Easy), false);
	} else if (settings.playerDifficulty[0] == MEDIUM)	{
		Button_Difficulty.SetSurfaces(pDataManager->getUIGraphic(UI_Dif_Medium), false);
	} else {
		Button_Difficulty.SetSurfaces(pDataManager->getUIGraphic(UI_Dif_Hard), false);
	}
}


void SinglePlayerMenu::CloseChildWindow() {
	std::string filename = "";
	std::string extension = "";
	LoadSaveWindow* pLoadSaveWindow = dynamic_cast<LoadSaveWindow*>(pChildWindow);
	if(pLoadSaveWindow != NULL) {
		filename = pLoadSaveWindow->GetFilename();
		extension = pLoadSaveWindow->GetExtension();
	}

	MenuClass::CloseChildWindow();

	if(filename != "") {
		if(extension == "dls") {
			GameInitClass * init = new GameInitClass();
			init->setloadFile(filename.c_str());

			startSinglePlayerGame(init);
		} else if(extension == "rpl") {
			startReplay(filename);
		}
	}
}
