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

#include <GUI/ScrollBar.h>
#include <cmath>


#if !defined(lround)
#define lround(x) (int)(x+(x<0? -0.5 : 0.5)) 
#endif


ScrollBar::ScrollBar() : Widget() {
	MinValue = 1;
	MaxValue = 1;
	CurrentValue = 1;

	EnableResizing(false,true);
	Arrow1.SetSurfaces(	GUIStyle::GetInstance().CreateScrollBarArrowButton(false,false,false), true,
				GUIStyle::GetInstance().CreateScrollBarArrowButton(false,true,true), true,
				GUIStyle::GetInstance().CreateScrollBarArrowButton(false,false,true), true);
	Arrow1.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&ScrollBar::OnArrow1)));


	Arrow2.SetSurfaces(	GUIStyle::GetInstance().CreateScrollBarArrowButton(true,false,false), true,
				GUIStyle::GetInstance().CreateScrollBarArrowButton(true,true,true), true,
				GUIStyle::GetInstance().CreateScrollBarArrowButton(true,false,true), true);
	Arrow2.SetOnClickMethod(MethodPointer(this,(WidgetCallbackWithNoParameter) (&ScrollBar::OnArrow2)));

	pBackground = NULL;

	Resize(GetMinimumSize().x,GetMinimumSize().y);
}

ScrollBar::~ScrollBar() {
	if(pBackground != NULL) {
		SDL_FreeSurface(pBackground);
	}
}

void ScrollBar::HandleMouseMovement(Sint32 x, Sint32 y) {
	Arrow1.HandleMouseMovement(x,y);
	Arrow2.HandleMouseMovement(x,y - GetSize().y + Arrow2.GetSize().y);
}

bool ScrollBar::HandleMouseLeft(Sint32 x, Sint32 y, bool pressed) {
	Arrow1.HandleMouseLeft(x, y, pressed);
	Arrow2.HandleMouseLeft(x, y - GetSize().y + Arrow2.GetSize().y, pressed);
	return true;
}

bool ScrollBar::HandleKeyPress(SDL_KeyboardEvent& key) {
	return true;
}

void ScrollBar::Draw(SDL_Surface* screen, Point Position) {
	if(IsVisible() == false) {
		return;
	}

	if(pBackground != NULL) {
		SDL_Rect dest;
		dest.x = Position.x;
		dest.y = Position.y;
		dest.w = pBackground->w;
		dest.h = pBackground->h;

		SDL_BlitSurface(pBackground,NULL,screen,&dest);
	}

	Arrow1.Draw(screen,Position);
	Point p = Position;
	p.y = p.y + GetSize().y - Arrow2.GetSize().y;
	Arrow2.Draw(screen,p);
	SliderButton.Draw(screen,Position+SliderPosition);
}

void ScrollBar::Resize(Uint32 width, Uint32 height) {
	Widget::Resize(width,height);

	if(pBackground != NULL) {
		SDL_FreeSurface(pBackground);
	}

	pBackground = GUIStyle::GetInstance().CreateWidgetBackground(width, height);

	UpdateSliderButton();
}

void ScrollBar::UpdateSliderButton() {
	double Range = (double) (MaxValue - MinValue + 1);
	int ArrowHeight = GUIStyle::GetInstance().GetMinimumScrollBarArrowButtonSize().y;
	double SliderAreaHeight = (double) (GetSize().y - 2*ArrowHeight);

	double SliderButtonHeight;
	double OneTickHeight;

	if(Range <= 1) {
		SliderButtonHeight = SliderAreaHeight;
		OneTickHeight = 0;
	} else {
		SliderButtonHeight = (SliderAreaHeight*2.5) / (Range+1);
		if(SliderButtonHeight <= 5) {
			SliderButtonHeight = 5;
		}
		OneTickHeight = (SliderAreaHeight - SliderButtonHeight)/(Range-1);
	}

	SliderButton.Resize(GetSize().x, lround(SliderButtonHeight));
	SliderPosition.x = 0;
	SliderPosition.y = ArrowHeight +  lround((CurrentValue - MinValue)*OneTickHeight);
}


