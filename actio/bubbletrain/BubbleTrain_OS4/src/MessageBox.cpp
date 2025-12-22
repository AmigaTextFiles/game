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
 
#include "MessageBox.h"

MessageBox::MessageBox(SDL_Surface* screen, const char* message, ...) : Window(screen)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Loading message box");
	
	char string[1024];          // Temporary string
	
	va_list ap;               	// Pointer To List Of Arguments
	va_start(ap, message);         // Parses The String For Variables
	vsprintf(string, message, ap); // Converts Symbols To Actual Numbers
	va_end(ap);               	// Results Are Stored In Text
	
	
	// Default the window to zero until we have set the size
	// Make the window 300x150 and centred
	Uint32 width = 300;
	Uint32 height = 150;
	Uint32 margin = 20;
	// find out the size of the text for the message box
	Theme::Instance()->textSize(FONT_MENU, &width, &height, string);
	
	int startPosx = (int)(APP_WIDTH - width - 2 * margin) / 2;
	int startPosy = (int)(APP_HEIGHT - height - 2 * margin) / 2;
	Rect windowSize(startPosx, startPosy, startPosx + width + 2 * margin, startPosy + height + 2 * margin);
	Window::setSize(windowSize);
	
	// Add a background button so it can hide when finished
	Callback0<MessageBox> addScoreCallBack(*this,&MessageBox::exit);
    Button* button1 = new Button(addScoreCallBack, "", windowSize);
    button1->setAccessKey(ANY_KEY);
    Window::addControl(button1);
    
    // Add a label to tell what the hell is going on in here.
    Label* textLabel = new Label(Point(margin, margin), Point(width + margin, height + margin));
    textLabel->setLabelText(string);
    textLabel->setFont(FONT_MENU);
    Window::addControl(textLabel);
    
    // Set the background colour to the red
   	Window::setBackgroundColour(SDL_MapRGB(screen->format, 0x9A, 0x35, 0x68));
   	Window::setInnerBevel(true);
   	Window::setBorderThickness(2);
   	
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Loading message box END");	
}

MessageBox::~MessageBox()
{
	
}

void MessageBox::exit()
{
	WindowManager::Instance()->remove(this);
}
