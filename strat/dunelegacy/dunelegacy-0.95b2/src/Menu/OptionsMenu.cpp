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

#include <Menu/OptionsMenu.h>

#include <globals.h>

#include <main.h>

#include <FileClasses/DataManager.h>
#include <FileClasses/INIFile.h>

#include <string.h>

OptionsMenu::OptionsMenu() : MenuClass()
{
	// set up window
	SDL_Surface *surf;
	surf = pDataManager->getUIGraphic(UI_MenuBackground);

	SetBackground(surf,false);
	Resize(surf->w,surf->h);

	SetWindowWidget(&WindowWidget);

	newConcreteRequired = settings.General.ConcreteRequired;
	newDoubleBuffered = settings.Video.DoubleBuffered;
	newFullscreen = settings.Video.Fullscreen;
	newWidth = settings.Video.Width;
	newHeight = settings.Video.Height;
	newIntro = settings.General.PlayIntro;
	newLanguage = settings.General.Language;

	WindowWidget.AddWidget(&MainVBox, Point(70,70), Point(GetSize().x - 140,GetSize().y - 140));

	TextBox_Name.SetText(settings.General.PlayerName.c_str());
	MainVBox.AddWidget(&TextBox_Name);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_Concrete.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsConcrete)));
	MainVBox.AddWidget(&Button_Concrete);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_Intro.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsIntro)));
	MainVBox.AddWidget(&Button_Intro);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_Language.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsLanguage)));
	MainVBox.AddWidget(&Button_Language);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_Res.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsRes)));
	MainVBox.AddWidget(&Button_Res);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_FullScreen.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsFullscreen)));
	MainVBox.AddWidget(&Button_FullScreen);

	MainVBox.AddWidget(VSpacer::Create(5));

	Button_DoubleBuffered.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsDoubleBuffered)));
	MainVBox.AddWidget(&Button_DoubleBuffered);

	MainVBox.AddWidget(VSpacer::Create(5));

	OkCancel_HBox.AddWidget(Spacer::Create());

	Button_Cancel.SetText("Cancel");
	Button_Cancel.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsCancel)));
	OkCancel_HBox.AddWidget(&Button_Cancel);

	OkCancel_HBox.AddWidget(Spacer::Create());

	Button_Ok.SetText("Ok");
	Button_Ok.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&OptionsMenu::OnOptionsOK)));
	OkCancel_HBox.AddWidget(&Button_Ok);

	OkCancel_HBox.AddWidget(Spacer::Create());

	MainVBox.AddWidget(&OkCancel_HBox);

	UpdateButtonCaptions();
}

OptionsMenu::~OptionsMenu()
{
	;
}

void OptionsMenu::OnOptionsConcrete() {
	newConcreteRequired = !newConcreteRequired;
	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsIntro() {
	newIntro = !newIntro;
	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsLanguage() {
	if(newLanguage == LNG_ENG) {
		newLanguage = LNG_GER;
	} else {
		newLanguage = LNG_ENG;
	}
	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsRes() {
	switch(newWidth) {
		case 640:
		{
			newWidth = 800;
			newHeight = 600;
		} break;

		case 800:
		{
			newWidth = 1024;
			newHeight = 768;
		} break;

		case 1024:
		default:
		{
			newWidth = 640;
			newHeight = 480;
		} break;
	}

	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsFullscreen() {
	newFullscreen = !newFullscreen;
	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsDoubleBuffered() {
	newDoubleBuffered = !newDoubleBuffered;
	UpdateButtonCaptions();
}

void OptionsMenu::OnOptionsOK() {
	settings.General.ConcreteRequired = newConcreteRequired;
	settings.General.PlayIntro = newIntro;
	settings.Video.DoubleBuffered = newDoubleBuffered;
	settings.Video.Fullscreen = newFullscreen;
	settings.General.PlayerName = TextBox_Name.GetText();
	settings.Video.Width = newWidth;
	settings.Video.Height = newHeight;
	settings.General.setLanguage(newLanguage);

	SaveConfiguration2File();

	quit(1);
}

void OptionsMenu::OnOptionsCancel() {
	quit();
}

void OptionsMenu::UpdateButtonCaptions() {
	if(newConcreteRequired == true) {
		Button_Concrete.SetText("Concrete Required");
	} else {
		Button_Concrete.SetText("Concrete Not Required");
	}

	if(newFullscreen == true) {
		Button_FullScreen.SetText("Full Screen");
	} else {
		Button_FullScreen.SetText("Windowed");
	}

	if(newDoubleBuffered == true) {
		Button_DoubleBuffered.SetText("Double Buffered");
	} else {
		Button_DoubleBuffered.SetText("Single Buffered");
	}

	if(newIntro == true) {
		Button_Intro.SetText("Play Intro");
	} else {
		Button_Intro.SetText("Don't play Intro");
	}

	if(newLanguage == LNG_ENG) {
		Button_Language.SetText("English");
	} else {
		Button_Language.SetText("German");
	}

	char temp[20];
	sprintf(temp,"%dx%d",newWidth,newHeight);
	Button_Res.SetText(temp);
}

void OptionsMenu::SaveConfiguration2File() {
	INIFile myINIFile(CheckAndGetConfigFile());

	myINIFile.setBoolValue("General","Concrete Required",settings.General.ConcreteRequired);
	myINIFile.setBoolValue("General","Play Intro",settings.General.PlayIntro);
	myINIFile.setIntValue("Video","Width",settings.Video.Width);
	myINIFile.setIntValue("Video","Height",settings.Video.Height);
	myINIFile.setBoolValue("Video","Fullscreen",settings.Video.Fullscreen);
	myINIFile.setBoolValue("Video","Double Buffered",settings.Video.DoubleBuffered);
	myINIFile.setStringValue("General","Player Name",settings.General.PlayerName);
	myINIFile.setStringValue("General","Language",settings.General.getLanguageString());

	myINIFile.SaveChangesTo(CheckAndGetConfigFile());
}
