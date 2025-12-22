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

#ifndef GUISTYLE_H
#define GUISTYLE_H

#include <stdlib.h>
#include <stdio.h>

#include <SDL.h>
#include <string>
#include <list>

#include "Widget.h"

typedef enum {
	Alignment_Center,
	Alignment_Left,
	Alignment_Right
} Alignment_Enum;

class GUIStyle {
public:
	/// default constructor
	GUIStyle();

	/// destructor
	virtual ~GUIStyle();

	static void SetGUIStyle(GUIStyle* newGUIStyle) {
		currentGUIStyle = newGUIStyle;
	}

	static void DestroyGUIStyle() {
		if(currentGUIStyle != NULL) {
			delete currentGUIStyle;
			currentGUIStyle = NULL;
		}
	}

	static GUIStyle& GetInstance() {
		if(currentGUIStyle == NULL) {
			fprintf(stderr,"GUIStyle::GetInstance(): currentGUIStyle == NULL. Call CreateGUIStyle before using getInstance()!\n");
		}
		return *currentGUIStyle;
	}




	/**
		Returns the minumum size of a label with this text
		\param	text	The text for the label
		\return	the mimimum size of this label
	*/
	virtual Point GetMinimumLabelSize(std::string text) = 0;

	/**
		Creates the surface for a label with TextLines as content.
		\param	width		the width of the label
		\param	height		the height of the label
		\param	TextLines	a list of text lines for this label
		\param	alignment	the alignment for this label
		\param	color		the color of the text (-1 = default color for this style)
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateLabelSurface(Uint32 width, Uint32 height, std::list<std::string> TextLines, Alignment_Enum alignment = Alignment_Center, int color = -1) = 0;




	/**
		Returns the minumum size of a button with this text
		\param	text	The text for the button
		\return	the mimimum size of this button
	*/
	virtual Point GetMinimumButtonSize(std::string text) = 0;

	/**
		Creates the surface for a button with text as content.
		\param	width		the width of the button
		\param	height		the height of the button
		\param	text		the text for this button
		\param	pressed		true if the button should be pressed
		\param	activated	true if the button is activated (e.g. mouse hover)
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateButtonSurface(Uint32 width, Uint32 height, std::string text, bool pressed, bool activated) = 0;




	/**
		Returns the minumum size of a text box
		\return	the mimimum size of a text box
	*/
	virtual Point GetMinimumTextBoxSize() = 0;

	/**
		Creates the surface for a text box with text as content.
		\param	width		the width of the text box
		\param	height		the height of the text box
		\param	text		the text for this text box
		\param	carret		true if a carret should be shown
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateTextBoxSurface(Uint32 width, Uint32 height, std::string text, bool carret) = 0;




	/**
		Returns the minumum size of a scroll bar arrow button.
		\return	the mimimum size of a scroll bar arrow
	*/
	virtual Point GetMinimumScrollBarArrowButtonSize() = 0;

	/**
		Creates the surface for a scroll bar arrow button.
		\param	down		true = downward arrow, false = upward arrow
		\param	pressed		true if the button should be pressed
		\param	activated	true if the button is activated (e.g. mouse hover)
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateScrollBarArrowButton(bool down, bool pressed, bool activated) = 0;




	/**
		Returns the minumum height of a list box entry.
		\return	the mimimum height of a list box entry
	*/
	virtual Uint32 GetListBoxEntryHeight() = 0;

	/**
		Creates the surface for a list box entry with text as content.
		\param	width		the width of the entry
		\param	text		the text for this entry
		\param	selected	true if a entry should be highlighted
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateListBoxEntry(Uint32 width, std::string text, bool selected) = 0;




	/**
		Creates the overlay surface for a progress bar widget. This surface is then drawn
		above the progress bar widget.
		\param	width		the width of the progress bar
		\param	height		the height of the progress bar
		\param	percent		a value between 0.0 and 100.0
		\param	color		the color of the overlay
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateProgressBarOverlay(Uint32 width, Uint32 height, double percent, int color = -1) = 0;

	/**
		Creates a tool tip surface.
		\param	text		the tool tip text
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateToolTip(std::string text) = 0;

	/**
		Creates a simple background for e.g. a window
		\param	width		the width of the surface
		\param	height		the height of the surface
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateBackground(Uint32 width, Uint32 height) = 0;

	/**
		Creates a simple background for widgets
		\param	width		the width of the surface
		\param	height		the height of the surface
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateWidgetBackground(Uint32 width, Uint32 height) = 0;

	/**
		Creates an empty surface. This surface is transparent or black.
		\param	width		the width of the surface
		\param	height		the height of the surface
		\param	transparent	true = transparent surface, false = black
		\return	the new surface (has to be freed by the caller)
	*/
	virtual SDL_Surface* CreateEmptySurface(Uint32 width, Uint32 height, bool transparent);

private:
	static GUIStyle* currentGUIStyle;
};

#endif //GUISTYLE_H
