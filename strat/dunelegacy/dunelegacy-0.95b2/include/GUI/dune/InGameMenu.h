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

#ifndef INGAMEMENU_H
#define INGAMEMENU_H

#include <GUI/Window.h>
#include <GUI/Container.h>
#include <GUI/TextButton.h>
#include <GUI/Spacer.h>

class InGameMenu : public Window
{
public:
	InGameMenu();
	~InGameMenu();

	/**
		Handles a key stroke.
		\param	key the key that was pressed or released.
		\return	true = key stroke was processed by the window, false = key stroke was not processed by the window
	*/
	virtual bool HandleKeyPress(SDL_KeyboardEvent& key);


	/**
		This method is called, when the child window is about to be closed.
		This child window will be closed after this method returns.
		\param	pChildWindow	The child window that will be closed
	*/
	virtual void OnChildWindowClose(Window* pChildWindow);


	void OnResume();
	void OnSettings();
	void OnLoad();
	void OnSave();
	void OnRestart();
	void OnQuit();

private:
	HBox	Main_HBox;
	VBox	Main_VBox;

	TextButton	Button_Resume;
	TextButton	Button_GameSettings;
	TextButton	Button_RestartGame;
	TextButton	Button_SaveGame;
	TextButton	Button_LoadGame;
	TextButton	Button_Quit;
};


#endif // INGAMEMENU_H
