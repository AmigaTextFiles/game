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
 
#include "FastestTimeText.h"

FastestTimeText::FastestTimeText(SDL_Surface* screen, const char* game, int level, int score) : Window(screen)
{
	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "Loading fastest time screen");
			
	// Default the window to zero until we have set the size
	// Make the window 300x150 and centred
	int winWidth = 300;
	int winHeight = 90;
	int border = 12;
	int startPosx = (int)(APP_WIDTH - winWidth) / 2;
	int startPosy = (int)(APP_HEIGHT - winHeight) / 2;
	Rect windowSize(startPosx, startPosy, startPosx + winWidth, startPosy + winHeight);
	Window::setSize(windowSize);

	// Set the score/level
	this->score = score;
	this->level = level;
	this->game = strdup(game);
	
	// Add a label to tell what the hell is going on in here.
    Label* FastestTimeLabel = new Label(Point(border, border), Point(winWidth - 2 * border, 2* border));
    FastestTimeLabel->setLabelText("Please enter your name below:");
    Window::addControl(FastestTimeLabel);
	
	// Add the controls we need for the text box.
	Rect rtextBox(border, 2*border + 5 , winWidth - border, 2*border + 20);
    this->txtName = new TextBox(rtextBox);
    this->txtName->setText("");
    this->txtName->setTextLimit(30);
    this->txtName->setActive(true);
    this->txtName->setActiveColour(SDL_MapRGB(screen->format, 0x33, 0x33, 0x33));
    this->txtName->setInActiveColour(SDL_MapRGB(screen->format, 0x99, 0x99, 0x99));
    Window::addControl(this->txtName);

	// Add a button for the enter highest score bit
	int buttonWidth = 80;
	int buttonHeight = 20;
	Rect rbutton1(winWidth - buttonWidth - border, rtextBox.bottomRight.y + border, winWidth - border, rtextBox.bottomRight.y + buttonHeight + border );
	Callback0<FastestTimeText> addScoreCallBack(*this,&FastestTimeText::addScore);
    Button* button1 = new Button(addScoreCallBack, "Ok", rbutton1);
    button1->setAccessKey(SDLK_RETURN);
    button1->setActiveColour(SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE));
    Window::addControl(button1);
    
    // Set the background colour to the red
   	Window::setBackgroundColour(SDL_MapRGB(screen->format, 0x9A, 0x35, 0x68));
   	Window::setInnerBevel(true);
	Window::setBorderThickness(2);
   	
	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "Loading fastest time screen END");
}

FastestTimeText::~FastestTimeText()
{
	delete[] this->game;
}


void FastestTimeText::addScore()
{
	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "Adding score Start");
	
	// Check if the name is blank and then either set an error message or default
	// to nothing for now
	const char* txtname = this->txtName->getText();
	char* name = NULL;
	if (strcmp(txtname, "") == 0)
		name = strdup("Anonymous Coward");
	else
		name = strdup(txtname);

	// Add the new high score
	FastestTime::Instance()->addHS(name, this->game, this->level, this->score);
	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "I've added the score");
	
	WindowManager::Instance()->remove(this);
	// Need to display the high score table now to make everything cool.
	WindowManager::Instance()->push(new FastestTimeScreen(SDL_GetVideoSurface()));

	delete name;

	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "Adding score End");
	
}
