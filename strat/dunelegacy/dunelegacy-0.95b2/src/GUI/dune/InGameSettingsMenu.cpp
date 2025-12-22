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

#include <GUI/dune/InGameSettingsMenu.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <GameClass.h>
#include <PlayerClass.h>
#include <SoundPlayer.h>

#include <GUI/Spacer.h>


InGameSettingsMenu::InGameSettingsMenu() : Window(0,0,0,0)
{
	// set up window
	SDL_Surface *surf,*surfPressed;
	surf = pDataManager->getUIGraphic(UI_OptionsMenu);

	SetBackground(surf,false);

	int xpos = std::max(0,(screen->w - surf->w)/2);
	int ypos = std::max(0,(screen->h - surf->h)/2);

	SetCurrentPosition(xpos,ypos,surf->w,surf->h);

	SetWindowWidget(&Main_VBox);

	Main_VBox.AddWidget(VSpacer::Create(52));

	// Game speed
	GameSpeed_HBox.AddWidget(HSpacer::Create(3));

	surf = pDataManager->getUIGraphic(UI_Minus);
	surfPressed = pDataManager->getUIGraphic(UI_Minus_Pressed);
	GameSpeedMinus.SetSurfaces(surf,false,surfPressed,false);
	GameSpeedMinus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnGameSpeedMinus)));
	GameSpeed_HBox.AddWidget(&GameSpeedMinus);

	GameSpeedBar.SetColor(houseColour[thisPlayer->getHouse()]);
	GameSpeed_HBox.AddWidget(&GameSpeedBar);

	surf = pDataManager->getUIGraphic(UI_Plus);
	surfPressed = pDataManager->getUIGraphic(UI_Plus_Pressed);
	GameSpeedPlus.SetSurfaces(surf,false,surfPressed,false);
	GameSpeedPlus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnGameSpeedPlus)));
	GameSpeed_HBox.AddWidget(&GameSpeedPlus);

	GameSpeed_HBox.AddWidget(HSpacer::Create(3));

	Main_VBox.AddWidget(&GameSpeed_HBox);

	Main_VBox.AddWidget(VSpacer::Create(18));

	// Volume
	Volume_HBox.AddWidget(HSpacer::Create(3));

	surf = pDataManager->getUIGraphic(UI_Minus);
	surfPressed = pDataManager->getUIGraphic(UI_Minus_Pressed);
	VolumeMinus.SetSurfaces(surf,false,surfPressed,false);
	VolumeMinus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnVolumeMinus)));
	Volume_HBox.AddWidget(&VolumeMinus);

	VolumeBar.SetColor(houseColour[thisPlayer->getHouse()]);
	Volume_HBox.AddWidget(&VolumeBar);

	surf = pDataManager->getUIGraphic(UI_Plus);
	surfPressed = pDataManager->getUIGraphic(UI_Plus_Pressed);
	VolumePlus.SetSurfaces(surf,false,surfPressed,false);
	VolumePlus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnVolumePlus)));
	Volume_HBox.AddWidget(&VolumePlus);

	Volume_HBox.AddWidget(HSpacer::Create(3));

	Main_VBox.AddWidget(&Volume_HBox);

	Main_VBox.AddWidget(VSpacer::Create(18));

	// Scroll speed
	ScrollSpeed_HBox.AddWidget(HSpacer::Create(3));

	surf = pDataManager->getUIGraphic(UI_Minus);
	surfPressed = pDataManager->getUIGraphic(UI_Minus_Pressed);
	ScrollSpeedMinus.SetSurfaces(surf,false,surfPressed,false);
	ScrollSpeedMinus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnScrollSpeedMinus)));
	ScrollSpeedMinus.SetEnabled(false);
	ScrollSpeed_HBox.AddWidget(&ScrollSpeedMinus);

	ScrollSpeedBar.SetColor(houseColour[thisPlayer->getHouse()]);
	ScrollSpeed_HBox.AddWidget(&ScrollSpeedBar);

	surf = pDataManager->getUIGraphic(UI_Plus);
	surfPressed = pDataManager->getUIGraphic(UI_Plus_Pressed);
	ScrollSpeedPlus.SetSurfaces(surf,false,surfPressed,false);
	ScrollSpeedPlus.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnScrollSpeedPlus)));
	ScrollSpeedPlus.SetEnabled(false);
	ScrollSpeed_HBox.AddWidget(&ScrollSpeedPlus);

	ScrollSpeed_HBox.AddWidget(HSpacer::Create(3));

	Main_VBox.AddWidget(&ScrollSpeed_HBox);

	Main_VBox.AddWidget(VSpacer::Create(10));

	// buttons
	Button_HBox.AddWidget(HSpacer::Create(10));

	Button_OK.SetText("OK");
	Button_OK.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnOK)));
	Button_HBox.AddWidget(&Button_OK);

	Button_HBox.AddWidget(HSpacer::Create(10));

	Button_Cancel.SetText("CANCEL");
	Button_Cancel.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&InGameSettingsMenu::OnCancel)));
	Button_HBox.AddWidget(&Button_Cancel);

	Button_HBox.AddWidget(HSpacer::Create(10));

	Main_VBox.AddWidget(&Button_HBox);

	Main_VBox.AddWidget(VSpacer::Create(8));


	Update();
}

InGameSettingsMenu::~InGameSettingsMenu()
{
	;
}

void InGameSettingsMenu::Update()
{
	newGamespeed = currentGame->gamespeed;
	GameSpeedBar.SetProgress(100 - ((newGamespeed-GAMESPEED_MIN)*100)/(GAMESPEED_MAX - GAMESPEED_MIN));

	Volume = soundPlayer->GetSfxVolume();
	VolumeBar.SetProgress((100*Volume)/MIX_MAX_VOLUME);

	ScrollSpeedBar.SetProgress(50.0);
}

void InGameSettingsMenu::OnCancel()
{
	Window* pParentWindow = dynamic_cast<Window*>(GetParent());
	if(pParentWindow != NULL) {
		pParentWindow->CloseChildWindow();
	}
}

void InGameSettingsMenu::OnOK()
{
	currentGame->gamespeed = newGamespeed;
	soundPlayer->SetSfxVolume(Volume);

	Window* pParentWindow = dynamic_cast<Window*>(GetParent());
	if(pParentWindow != NULL) {
		pParentWindow->CloseChildWindow();
	}
}

void InGameSettingsMenu::OnGameSpeedPlus()
{
	if(newGamespeed > GAMESPEED_MIN)
		newGamespeed -= 1;

	GameSpeedBar.SetProgress(100 - ((newGamespeed-GAMESPEED_MIN)*100)/(GAMESPEED_MAX - GAMESPEED_MIN));
}

void InGameSettingsMenu::OnGameSpeedMinus()
{
	if(newGamespeed < GAMESPEED_MAX)
		newGamespeed += 1;

	GameSpeedBar.SetProgress(100 - ((newGamespeed-GAMESPEED_MIN)*100)/(GAMESPEED_MAX - GAMESPEED_MIN));
}

void InGameSettingsMenu::OnVolumePlus()
{
	if(Volume <= MIX_MAX_VOLUME - 4) {
		Volume += 4;
		VolumeBar.SetProgress((100*Volume)/MIX_MAX_VOLUME);
	}
}

void InGameSettingsMenu::OnVolumeMinus()
{
	if(Volume >= 4) {
		Volume -= 4;
		VolumeBar.SetProgress((100*Volume)/MIX_MAX_VOLUME);
	}
}

void InGameSettingsMenu::OnScrollSpeedPlus()
{

}

void InGameSettingsMenu::OnScrollSpeedMinus()
{

}
