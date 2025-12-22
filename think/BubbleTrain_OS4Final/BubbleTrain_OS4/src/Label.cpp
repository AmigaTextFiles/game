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
 
#include "Label.h"


Label::Label(Rect size) : IWidget(size.topLeft)
{
	this->bottomRight = size.bottomRight;
	this->font = FONT_DIALOG;
}

Label::Label(Point topLeft, Point bottomRight) : IWidget(topLeft)
{
	this->bottomRight = bottomRight;
	this->font = FONT_DIALOG;
}


Label::~Label()
{
	
}

void Label::setLabelText(const char* text)
{
	// If the text is greater than the array then only copy the items we can
	if (strlen(text) > MAX_LABEL_CHARS)
	{
		strncpy(this->text, text, MAX_LABEL_CHARS - 1);
		this->text[MAX_LABEL_CHARS] = 0;
	}
	else
		strcpy(this->text, text);	
}

const char* Label::getLabelText()
{
	return this->text;	
}

void Label::setFont(FontRes font)
{
	this->font = font;	
}

double Label::getWidth()
{
	return this->bottomRight.x - this->point.x;
}

void Label::setWidth(double w)
{
	this->bottomRight.x = this->point.x + w;
}

void Label::draw(SDL_Surface* screenDest)
{
	// Draw out the text with a 2 pixel border
	Rect textSize(this->point.x, this->point.y, this->bottomRight.x, this->bottomRight.y);
	Theme::Instance()->drawText(screenDest, this->font, textSize, Top, Left, "%s", this->text);
}

