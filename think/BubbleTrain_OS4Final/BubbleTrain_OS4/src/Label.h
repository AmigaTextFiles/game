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
 
 /*
  * A label control to display text to the screen clip the text if it goes outside
  * of the bounding box.
  */
 
#ifndef LABEL_H
#define LABEL_H

#include "IWidget.h"
#include "Theme.h"

#define MAX_LABEL_CHARS 1024		// Set the maximum number of characters in the label

class Label : public IWidget
{

private:

	Point bottomRight;				// Define the bottom right point for the label. The top left is held in IWidget

	FontRes font;					// Define the font to use when drawing
	char text[MAX_LABEL_CHARS];		// The contents of the label
	 
	
public:

	Label(Rect size);
	Label(Point topLeft, Point bottomRight);
	virtual ~Label();
	
	// Accessor methods
	void setLabelText(const char* text);
	const char* getLabelText();
	void setFont(FontRes font);
	double getWidth();
	void setWidth(double w);
	
	// IWidget methods
	virtual void draw(SDL_Surface* screenDest);

};

#endif // LABEL_H
