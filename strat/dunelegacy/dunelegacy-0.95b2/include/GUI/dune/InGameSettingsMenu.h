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

#ifndef INGAMESETTINGSMENU
#define INGAMESETTINGSMENU

#include <GUI/Window.h>
#include <GUI/Container.h>
#include <GUI/TextButton.h>
#include <GUI/PictureButton.h>
#include <GUI/ProgressBar.h>
#include "Definitions.h"

class InGameSettingsMenu : public Window
{
public:
	InGameSettingsMenu();
	~InGameSettingsMenu();

	void Update();

	/**
		This static method creates a dynamic settings menu object.
		The idea behind this method is to simply create a new dialog on the fly and
		add it as a child window of some other window. If the window gets closed it will be freed.
		\return	The new dialog box (will be automatically destroyed when it's closed)
	*/
	static InGameSettingsMenu* Create() {
		InGameSettingsMenu* dlg = new InGameSettingsMenu();
		dlg->pAllocated = true;
		return dlg;
	}

private:
	void OnOK();
	void OnCancel();

	void OnGameSpeedPlus();
	void OnGameSpeedMinus();

	void OnVolumePlus();
	void OnVolumeMinus();

	void OnScrollSpeedPlus();
	void OnScrollSpeedMinus();

	VBox			Main_VBox;

	HBox			Button_HBox;
	TextButton		Button_Cancel;
	TextButton		Button_OK;

	HBox			GameSpeed_HBox;
	PictureButton	GameSpeedPlus;
	PictureButton	GameSpeedMinus;
	ProgressBar		GameSpeedBar;

	HBox			Volume_HBox;
	PictureButton	VolumePlus;
	PictureButton	VolumeMinus;
	ProgressBar		VolumeBar;

	HBox			ScrollSpeed_HBox;
	PictureButton	ScrollSpeedPlus;
	PictureButton	ScrollSpeedMinus;
	ProgressBar		ScrollSpeedBar;

	int		newGamespeed;
	int		Volume;
};

#endif // INGAMESETTINGSMENU
