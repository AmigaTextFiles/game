/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
#include "MainMenu.h"

MainMenu::MainMenu(SDL_Surface* screen) : Window(screen, Rect(0,0,screen->w,screen->h))
{
	// Make sure we are using all of the default fonts etc
	Theme::Instance()->load("", "default");

	Theme::Instance()->playMusic("../snd/mainmenu_music.wav");
	
	Window::loadBackgroundImage("../gfx/menu.png");
    
    int left 	= 80;
    int top 	= 100;
    int width 	= 260;
    int height 	= 65;
  	int vertSpace = 70;
 
    Rect rbNewGame(left, top, left + width, top + height);
    Callback0<MainMenu> newGameCallback(*this, &MainMenu::newGame);
    Button* bNewGame = new Button(newGameCallback, "New Game", rbNewGame);
    bNewGame->loadBackgroundImage("../gfx/menubutton.png");
    bNewGame->setAccessKey(SDLK_n);
    bNewGame->setFont(FONT_MENU);
    Window::addControl(bNewGame);
    
    top += vertSpace;
   
    Rect rbFastestTime(left, top, left + width, top + height);
   	Callback0<MainMenu> FastestTimeCallback(*this, &MainMenu::FastestTime);
    Button* bFastestTime = new Button(FastestTimeCallback, "Fastest Times", rbFastestTime);
	bFastestTime->loadBackgroundImage("../gfx/menubutton.png");
    bFastestTime->setAccessKey(SDLK_h);
    bFastestTime->setFont(FONT_MENU);
    Window::addControl(bFastestTime);
    
    top += vertSpace;

    Rect rbOptions(left, top, left + width, top + height);
   	Callback0<MainMenu> optionsCallback(*this, &MainMenu::options);
    Button* bOptions = new Button(optionsCallback, "Options", rbOptions);
    bOptions->loadBackgroundImage("../gfx/menubutton.png");
    bOptions->setAccessKey(SDLK_o);
    bOptions->setFont(FONT_MENU);
    Window::addControl(bOptions);
    
    top += vertSpace;
            
    Rect rbLevelEditor(left, top, left + width, top + height);
    Callback0<MainMenu> levelEditorCallback(*this, &MainMenu::levelEditor);
    Button* bLevelEditor = new Button(levelEditorCallback, "Level Editor", rbLevelEditor);
    bLevelEditor->loadBackgroundImage("../gfx/menubutton.png");
    bLevelEditor->setAccessKey(SDLK_l);
    bLevelEditor->setFont(FONT_MENU);
    Window::addControl(bLevelEditor);
    
    top += vertSpace;
        
    Rect rbAboutUs(left, top, left + width, top + height);
    Callback0<MainMenu> aboutUsCallback(*this, &MainMenu::aboutUs);
    Button* bAboutUs = new Button(aboutUsCallback, "About Us", rbAboutUs);
    bAboutUs->loadBackgroundImage("../gfx/menubutton.png");
    bAboutUs->setAccessKey(SDLK_a);
    bAboutUs->setFont(FONT_MENU);
    Window::addControl(bAboutUs);
    
    top += vertSpace;
        
    Rect rbQuit(left, top, left + width, top + height);
    Callback0<MainMenu> quitCallback(*this, &MainMenu::quit);
    Button* bQuit = new Button(quitCallback, "Quit", rbQuit);
    bQuit->loadBackgroundImage("../gfx/menubutton.png");
    bQuit->setAccessKey(SDLK_q);
    bQuit->setFont(FONT_MENU);
    Window::addControl(bQuit);
}

MainMenu::~MainMenu()
{

}



//-------------------------------------------
// Private functions
//-------------------------------------------

void MainMenu::newGame ()
{
	WindowManager::Instance()->push(new GameSelect(Window::rootScreen));
}

void MainMenu::FastestTime()
{
	WindowManager::Instance()->push(new FastestTimeScreen(Window::rootScreen));
}

void MainMenu::options()
{
	WindowManager::Instance()->push(new OptionsScreen(Window::rootScreen));
}

void MainMenu::levelEditor()
{
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(new LevelEditor(Window::rootScreen));
}

void MainMenu::aboutUs()
{
	WindowManager::Instance()->push(new AboutUs(Window::rootScreen));
}	

void MainMenu::quit ()
{
	WindowManager::Instance()->clear();
	Log::Instance()->die(0, SV_INFORMATION, "Quitting nicely");
}
