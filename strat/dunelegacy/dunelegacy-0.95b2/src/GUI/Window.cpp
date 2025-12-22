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

#include <GUI/Window.h>
#include <GUI/GUIStyle.h>

#include <iostream>

Window::Window(Uint32 x, Uint32 y, Uint32 w, Uint32 h) : Widget() {
	pChildWindow = NULL;
	pWindowWidget = NULL;

	bTransparentBackground = false;
	pBackground = NULL;
	bFreeBackground = false;
	bSelfGeneratedBackground = true;

	Position = Point(x,y);
	Widget::Resize(w,h);
}

Window::~Window() {
	if(pChildWindow != NULL) {
		pChildWindow->Destroy();
	}

	if(pWindowWidget != NULL) {
		pWindowWidget->Destroy();
	}

	if(((bSelfGeneratedBackground == true) || (bFreeBackground == true)) && (pBackground != NULL)) {
		SDL_FreeSurface(pBackground);
		pBackground = NULL;
	}
}

void Window::OpenWindow(Window* pChildWindow) {
	this->pChildWindow = pChildWindow;
	if(this->pChildWindow != NULL) {
		this->pChildWindow->SetParent(this);
	}
}

void Window::CloseChildWindow() {
	OnChildWindowClose(pChildWindow);
	pChildWindow->Destroy();
	pChildWindow = NULL;
}

void Window::SetCurrentPosition(Uint32 x, Uint32 y, Uint32 w, Uint32 h) {
	Position.x = x; Position.y = y;
	Resize(w,h);
}

void Window::HandleInput(SDL_Event& event) {
	if(pChildWindow != NULL) {
		pChildWindow->HandleInput(event);
		return;
	}

	switch(event.type) {
		case SDL_KEYDOWN: {
			HandleKeyPress(event.key);
		} break;

		case SDL_MOUSEMOTION: {
			HandleMouseMovement(event.motion.x,event.motion.y);
		} break;

		case SDL_MOUSEBUTTONDOWN: {
			switch(event.button.button) {
				case SDL_BUTTON_LEFT: {
					HandleMouseLeft(event.button.x,event.button.y,true);
				} break;

				case SDL_BUTTON_RIGHT: {
					HandleMouseRight(event.button.x,event.button.y,true);
				} break;

			}
		} break;

		case SDL_MOUSEBUTTONUP: {
			switch(event.button.button) {
				case SDL_BUTTON_LEFT: {
					HandleMouseLeft(event.button.x,event.button.y,false);
				} break;

				case SDL_BUTTON_RIGHT: {
					HandleMouseRight(event.button.x,event.button.y,false);
				} break;

			}
		} break;
	}
}

void Window::HandleMouseMovement(Sint32 x, Sint32 y) {
	if(pChildWindow != NULL) {
		pChildWindow->HandleMouseMovement(x, y);
		return;
	}

	if(IsEnabled() && (pWindowWidget != NULL)) {
		pWindowWidget->HandleMouseMovement(x - GetPosition().x, y - GetPosition().y);
	}
}

bool Window::HandleMouseLeft(Sint32 x, Sint32 y, bool pressed) {
	if(pChildWindow != NULL) {
		bool ret = pChildWindow->HandleMouseLeft(x, y, pressed);
		return ret;
	}

	if(IsEnabled() && (pWindowWidget != NULL)) {
		return pWindowWidget->HandleMouseLeft(x - GetPosition().x, y - GetPosition().y, pressed);
	} else {
		return false;
	}
}

bool Window::HandleMouseRight(Sint32 x, Sint32 y, bool pressed) {
	if(pChildWindow != NULL) {
		bool ret = pChildWindow->HandleMouseRight(x, y, pressed);
		return ret;
	}

	if(IsEnabled() && (pWindowWidget != NULL)) {
		return pWindowWidget->HandleMouseRight(x - GetPosition().x, y - GetPosition().y, pressed);
	} else {
		return false;
	}
}

bool Window::HandleKeyPress(SDL_KeyboardEvent& key) {
	if(pChildWindow != NULL) {
		bool ret = pChildWindow->HandleKeyPress(key);
		return ret;
	}

	if(IsEnabled() && (pWindowWidget != NULL)) {
		return pWindowWidget->HandleKeyPress(key);
	} else {
		return false;
	}
}

void Window::Draw(SDL_Surface* screen, Point Position) {
	if(IsVisible()) {
		if(bTransparentBackground == false) {

			if((bSelfGeneratedBackground == true) && (pBackground == NULL)) {
				pBackground = GUIStyle::GetInstance().CreateBackground(GetSize().x,GetSize().y);

			}

			if(pBackground != NULL) {
				// Draw background
				SDL_Rect RectScreen;
				RectScreen.x = GetPosition().x + (GetSize().x - pBackground->w)/2;
				RectScreen.y = GetPosition().y + (GetSize().y - pBackground->h)/2;;
				RectScreen.w = pBackground->w;
				RectScreen.h = pBackground->h;

				SDL_Rect RectBackground;
				RectBackground.x = RectBackground.y = 0;
				RectBackground.w = RectScreen.w;
				RectBackground.h = RectScreen.h;

				SDL_BlitSurface(pBackground,&RectBackground,screen,&RectScreen);
			}
		}

		if(pWindowWidget != NULL) {
			pWindowWidget->Draw(screen, Point(Position.x+GetPosition().x,Position.y+GetPosition().y));
		}
	}

	if(pChildWindow != NULL) {
		pChildWindow->Draw(screen);
	}
}

void Window::DrawOverlay(SDL_Surface* screen, Point Position) {
	if(pChildWindow != NULL) {
		pChildWindow->DrawOverlay(screen);
	} else if(IsVisible() && (pWindowWidget != NULL)) {
		pWindowWidget->DrawOverlay(screen, Point(Position.x+GetPosition().x,Position.y+GetPosition().y));
	}
}

void Window::Resize(Uint32 width, Uint32 height) {
	Widget::Resize(width,height);
	if(pWindowWidget != NULL) {
		pWindowWidget->Resize(width,height);
	}

	if(bSelfGeneratedBackground == true) {
		if(pBackground != NULL) {
			SDL_FreeSurface(pBackground);
			pBackground = NULL;
		}

		// the new background is created when the window is drawn next time
	}
}

void Window::SetBackground(SDL_Surface* pBackground, bool bFreeBackground) {
	if(((bSelfGeneratedBackground == true) || (this->bFreeBackground == true)) && (this->pBackground != NULL)) {
		SDL_FreeSurface(this->pBackground);
		this->pBackground = NULL;
	}

	if(pBackground == NULL) {
		bSelfGeneratedBackground = true;
		this->bFreeBackground = false;
		this->pBackground = NULL;
	} else {
		bSelfGeneratedBackground = false;
		this->pBackground = pBackground;
		this->bFreeBackground = bFreeBackground;
	}
}

void Window::SetTransparentBackground(bool bTransparent) {
	bTransparentBackground = bTransparent;
}
