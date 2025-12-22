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

#ifndef SCROLLBAR_H
#define SCROLLBAR_H

#include "Widget.h"
#include "PictureButton.h"
#include "TextButton.h"

/// A class for a scroll bar
class ScrollBar : public Widget {
public:
	/// default constructor
	ScrollBar();

	/// destructor
	virtual ~ScrollBar();

	/**
		Handles a mouse movement. This method is for example needed for the tooltip.
		\param	x x-coordinate (relative to the left top corner of the widget)
		\param	y y-coordinate (relative to the left top corner of the widget)
	*/
	virtual void HandleMouseMovement(Sint32 x, Sint32 y);

	/**
		Handles a left mouse click.
		\param	x x-coordinate (relative to the left top corner of the widget)
		\param	y y-coordinate (relative to the left top corner of the widget)
		\param	pressed	true = mouse button pressed, false = mouse button released
		\return	true = click was processed by the widget, false = click was not processed by the widget
	*/
	virtual bool HandleMouseLeft(Sint32 x, Sint32 y, bool pressed);

	/**
		Handles a key stroke. This method is neccessary for controlling an application
		without a mouse.
		\param	key the key that was pressed or released.
		\return	true = key stroke was processed by the widget, false = key stroke was not processed by the widget
	*/
	virtual bool HandleKeyPress(SDL_KeyboardEvent& key);

	/**
		Draws this scroll bar to screen. This method is called before DrawOverlay().
		\param	screen	Surface to draw on
		\param	Position	Position to draw the scroll bar to
	*/
	virtual void Draw(SDL_Surface* screen, Point Position);

	/**
		This method resized the scroll bar to width and height. This method should only
		called if the new size is a valid size for this scroll bar (See GetMinumumSize).
		\param	width	the new width of this scroll bar
		\param	height	the new height of this scroll bar
	*/
	virtual void Resize(Uint32 width, Uint32 height);

	/**
		Returns the minimum size of this scroll bar. The scroll bar should not
		resized to a size smaller than this.
		\return the minimum size of this scroll bar
	*/
	virtual Point GetMinimumSize() const {
		Point tmp = GUIStyle::GetInstance().GetMinimumScrollBarArrowButtonSize();
		tmp.y = tmp.y * 3;
		return tmp;
	}

	/**
		Sets the range of this ScrollBar.
		\param	MinValue	the minimum value
		\param	MaxValue	the maximum value
	*/
	void SetRange(int MinValue, int MaxValue) {
		if(MinValue > MaxValue) {
			return;
		}

		this->MinValue = MinValue;
		this->MaxValue = MaxValue;

		if(CurrentValue < MinValue) {
			CurrentValue = MinValue;
		} else if(CurrentValue > MaxValue) {
			CurrentValue = MaxValue;
		}

		UpdateSliderButton();
	}

	/**
		Returns the current position
		\return	the current value
	*/
	int GetCurrentValue() {
		return CurrentValue;
	}

	/**
		Sets the current position. Should be in range
		\param the new position
	*/
	void SetCurrentValue(int NewValue) {
		CurrentValue = NewValue;
		if(CurrentValue < MinValue) {
			CurrentValue = MinValue;
		} else if(CurrentValue > MaxValue) {
			CurrentValue = MaxValue;
		}

		UpdateSliderButton();

		pOnChange();
	}

	/**
		Sets the method that should be called when this scroll bar changes its position.
		\param	pMethod	A pointer to this method
	*/
	inline void SetOnChangeMethod(MethodPointer pMethod) {
		pOnChange = pMethod;
	}

private:
	void UpdateSliderButton();

	void OnArrow1() {
		SetCurrentValue(CurrentValue-1);
	}

	void OnArrow2() {
		SetCurrentValue(CurrentValue+1);
	}

	SDL_Surface* pBackground;
	PictureButton Arrow1;
	PictureButton Arrow2;
	TextButton SliderButton;

	MethodPointer pOnChange;				///< method that is called when this scrollbar changes its position

	int CurrentValue;
	int MinValue;
	int MaxValue;
	Point SliderPosition;
};

#endif // SCROLLBAR_H
