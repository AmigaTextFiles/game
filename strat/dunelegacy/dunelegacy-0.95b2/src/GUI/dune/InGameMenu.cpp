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

#include <GUI/dune/InGameMenu.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <misc/fnkdat.h>
#include <GameClass.h>
#include <GameInitClass.h>

#include <GUI/dune/InGameSettingsMenu.h>
#include <GUI/dune/LoadSaveWindow.h>


InGameMenu::InGameMenu() : Window(0,0,0,0)
{
	// set up window
	SDL_Surface *surf;
	surf = pDataManager->getUIGraphic(UI_GameMenu);

	SetBackground(surf,false);

	int xpos = std::max(0,(screen->w - surf->w)/2);
	int ypos = std::max(0,(screen->h - surf->h)/2);

	SetCurrentPosition(xpos,ypos,surf->w,surf->h);

	SetWindowWidget(&Main_HBox);

	Main_HBox.AddWidget(HSpacer::Create(22));
	Main_HBox.AddWidget(&Main_VBox);
	Main_HBox.AddWidget(HSpacer::Create(22));


	Main_VBox.AddWidget(VSpacer::Create(34));

	Button_Resume.SetText("RESUME GAME");
	Button_Resume.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnResume)));
	Main_VBox.AddWidget(&Button_Resume);

	Main_VBox.AddWidget(VSpacer::Create(3));

	Button_GameSettings.SetText("GAME SETTINGS");
	Button_GameSettings.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnSettings)));
	Main_VBox.AddWidget(&Button_GameSettings);

	Main_VBox.AddWidget(VSpacer::Create(3));

	Button_SaveGame.SetText("SAVE GAME");
	Button_SaveGame.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnSave)));
	Main_VBox.AddWidget(&Button_SaveGame);

	Main_VBox.AddWidget(VSpacer::Create(3));

	Button_LoadGame.SetText("LOAD GAME");
	Button_LoadGame.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnLoad)));
	Main_VBox.AddWidget(&Button_LoadGame);

	Main_VBox.AddWidget(VSpacer::Create(3));

	Button_RestartGame.SetText("RESTART GAME");
	Button_RestartGame.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnRestart)));
	Main_VBox.AddWidget(&Button_RestartGame);

	Main_VBox.AddWidget(VSpacer::Create(3));

	Button_Quit.SetText("QUIT TO MENU");
	Button_Quit.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameMenu::OnQuit)));
	Main_VBox.AddWidget(&Button_Quit);

	Main_VBox.AddWidget(VSpacer::Create(6));
}

InGameMenu::~InGameMenu()
{
	;
}

bool InGameMenu::HandleKeyPress(SDL_KeyboardEvent& key) {
	switch( key.keysym.sym ) {
		case SDLK_ESCAPE:
		{
			currentGame->ResumeGame();
		} break;

		default:
			break;
	}

	return Window::HandleKeyPress(key);
}

void InGameMenu::OnChildWindowClose(Window* pChildWindow) {
	LoadSaveWindow* loadsave = dynamic_cast<LoadSaveWindow*>(pChildWindow);

	if(loadsave != NULL) {

		if(loadsave->SaveWindow() == false) {
			// load window
			std::string FileName = loadsave->GetFilename();

			if(FileName != "") {

				GameInitClass * init = new GameInitClass();
				init->setloadFile(FileName);

				currentGame->NextGameInitSettings = init;

				currentGame->ResumeGame();
				currentGame->quit_Game();
			}
		} else {
			// save window
			std::string FileName = loadsave->GetFilename();
			if(FileName != "") {
				currentGame->saveGame(FileName);

				currentGame->ResumeGame();
			}

		}
	}
}

void InGameMenu::OnResume()
{
	currentGame->ResumeGame();
}

void InGameMenu::OnSettings()
{
	OpenWindow(InGameSettingsMenu::Create());
}

void InGameMenu::OnSave()
{
	char tmp[FILENAME_MAX];
	fnkdat("save/", tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
	std::string savepath(tmp);
	OpenWindow(LoadSaveWindow::Create(true, "Save Game", savepath, "dls"));
}

void InGameMenu::OnLoad()
{
	char tmp[FILENAME_MAX];
	fnkdat("save/", tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
	std::string savepath(tmp);
	OpenWindow(LoadSaveWindow::Create(false, "Load Game", savepath, "dls"));
}

void InGameMenu::OnRestart()
{
	// copy old init class
	GameInitClass * init = new GameInitClass();
	*init = *(currentGame->InitSettings);

	// set new init class for next game
	currentGame->NextGameInitSettings = init;

	// quit current game
	currentGame->ResumeGame();
	currentGame->quit_Game();
}

void InGameMenu::OnQuit()
{
	currentGame->quit_Game();
}
