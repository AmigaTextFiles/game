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

#ifndef CONTAINER_H
#define CONTAINER_H

#include "Widget.h"
#include <misc/RobustList.h>

#include <iostream>

/// The abstract base class for container widgets
class Container : public Widget {
public:
	friend class Widget;

	/// default constructor
	Container() : Widget() {
		pActiveChildWidget = NULL;
		EnableResizing(true,true);
	}

	/// destructor
	virtual ~Container() {
		while(ContainedWidgets.begin() != ContainedWidgets.end()) {
			Widget* curWidget = *(ContainedWidgets.begin());
			curWidget->Destroy();
		}
	}

	/**
		This method removes a widget from this container. Everything
		will be resized afterwards.
		\param pChildWidget	Widget to remove
	*/
	virtual void RemoveChildWidget(Widget* pChildWidget) {
		ContainedWidgets.remove(pChildWidget);
		pChildWidget->SetParent(NULL);
		ResizeAll();
	}

	/**
		This method adds a new widget to this container.
		\param newWidget	Widget to add
	*/
	virtual void AddWidget(Widget* newWidget) {
		if(newWidget != NULL) {
			ContainedWidgets.push_back(newWidget);
			newWidget->SetParent(this);
			Widget::ResizeAll();
		}
	}

	/**
		Handles a mouse movement.
		\param	x x-coordinate (relative to the left top corner of the container)
		\param	y y-coordinate (relative to the left top corner of the container)
	*/
	virtual void HandleMouseMovement(Sint32 x, Sint32 y) {

		WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Point pos = GetPosition(curWidget);
			curWidget->HandleMouseMovement(x - pos.x, y - pos.y);
		}
	}

	/**
		Handles a left mouse click.
		\param	x x-coordinate (relative to the left top corner of the container)
		\param	y y-coordinate (relative to the left top corner of the container)
		\param	pressed	true = mouse button pressed, false = mouse button released
		\return	true = click was processed by the container, false = click was not processed by the container
	*/
	virtual bool HandleMouseLeft(Sint32 x, Sint32 y, bool pressed) {
		if((IsEnabled() == false) || (IsVisible() == false)) {
			return true;
		}

		bool WidgetFound = false;
		WidgetList::const_iterator iter = ContainedWidgets.begin();
		while(iter != ContainedWidgets.end()) {
			Widget* curWidget = *iter;
			++iter;
			Point pos = GetPosition(curWidget);
			WidgetFound |= curWidget->HandleMouseLeft(x - pos.x, y - pos.y, pressed);
		}
		return WidgetFound;
	}

	/**
		Handles a right mouse click.
		\param	x x-coordinate (relative to the left top corner of the container)
		\param	y y-coordinate (relative to the left top corner of the container)
		\param	pressed	true = mouse button pressed, false = mouse button released
		\return	true = click was processed by the container, false = click was not processed by the container
	*/
	virtual bool HandleMouseRight(Sint32 x, Sint32 y, bool pressed) {
		if((IsEnabled() == false) || (IsVisible() == false)) {
			return true;
		}

		bool WidgetFound = false;
		WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Point pos = GetPosition(curWidget);
			WidgetFound |= curWidget->HandleMouseRight(x - pos.x, y - pos.y, pressed);
		}
		return WidgetFound;
	}

	/**
		Handles a key stroke.
		\param	key the key that was pressed or released.
		\return	true = key stroke was processed by the container, false = key stroke was not processed by the container
	*/
	virtual bool HandleKeyPress(SDL_KeyboardEvent& key) {
		if((IsEnabled() == false) || (IsVisible() == false) || (IsActive() == false)) {
			return true;
		}

		if(pActiveChildWidget != NULL) {
			return pActiveChildWidget->HandleKeyPress(key);
		} else {
			if(key.keysym.sym == SDLK_TAB) {
				ActivateFirstActivatableWidget();
				if(dynamic_cast<Container*>(pActiveChildWidget) != NULL) {
					pActiveChildWidget->HandleKeyPress(key);
				}
			}
			return true;
		}
	}

	/**
		Draws this container and it's children to screen. This method is called before DrawOverlay().
		\param	screen	Surface to draw on
		\param	Position	Position to draw the container to
	*/
	virtual void Draw(SDL_Surface* screen, Point Position) {
		if(IsVisible() == false) {
			return;
		}

		WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Point pos = GetPosition(curWidget);
			curWidget->Draw(screen,Position+pos);
		}
	}

	/**
		This method draws the parts of this container that must be drawn after all the other
		widgets are drawn (e.g. tooltips). This method is called after Draw().
		\param	screen	Surface to draw on
		\param	Position	Position to draw the container to
	*/
	virtual void DrawOverlay(SDL_Surface* screen, Point Position) {
		if(IsVisible() == false) {
			return;
		}

		WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Point pos = GetPosition(curWidget);
			curWidget->DrawOverlay(screen,Position+pos);
		}
	}

	/**
		This method resized the container to width and height. This method should only be
		called if the new size is a valid size for this container (See GetMinumumSize).
		\param	width	the new width of this container
		\param	height	the new height of this container
	*/
	virtual void Resize(Uint32 width, Uint32 height) {
		Widget::Resize(width,height);
	}

	/**
		Sets this container and it's children active. The parent widgets are also activated and the
		currently widget is set to inactive.
	*/
	virtual void SetActive() {
		if(pActiveChildWidget == NULL) {
			if(!ContainedWidgets.empty()) {
				pActiveChildWidget = ContainedWidgets.front();
				pActiveChildWidget->SetActive(true);
			}
		}

		Widget::SetActive();
	}

	/**
		Sets this container and it's children inactive. The next activatable widget is activated.
	*/
	virtual void SetInactive() {
		if(pActiveChildWidget != NULL) {
			pActiveChildWidget->SetActive(false);
			pActiveChildWidget = NULL;
		}

		Widget::SetInactive();
	}

	/**
		Returns whether one of this container's children can be set active.
		\return	true = activatable, false = not activatable
	*/
	virtual inline bool IsActivatable() const {
		WidgetList::const_iterator iter = ContainedWidgets.begin();
		while(iter != ContainedWidgets.end()) {
			if((*iter)->IsActivatable() == true) {
				return true;
			}
			++iter;
		}
		return false;
	}

protected:
	/**
		This method is called by other containers to enable this container or disable this container explicitly.
		It is the responsibility of the calling container to take care that there is only one active
		widget.
		\param	bActive	true = activate this widget, false = deactiviate this widget
	*/
	virtual void SetActive(bool bActive) {
		if(pActiveChildWidget != NULL) {
			pActiveChildWidget->SetActive(bActive);
		}
		Widget::SetActive(bActive);
	}

	/**
		This method activates or deactivates one specific widget in this container. It is mainly used
		by widgets that are activated/deactivated and have to inform their parent container.
		\param	active	true = activate, false = deactivate
		\param	childWidget	the widget to activate/deactivate
	*/
	virtual void SetActiveChildWidget(bool active, Widget* childWidget) {
		if(childWidget == NULL) {
			return;
		}

		if(active == true) {
			// deactivate current active widget
			if((pActiveChildWidget != NULL) && (pActiveChildWidget != childWidget)) {
				pActiveChildWidget->SetActive(false);
				pActiveChildWidget = childWidget;
			} else {
				pActiveChildWidget = childWidget;

				// activate this container and upper containers
				Widget::SetActive();
			}
		} else {
			if(childWidget != pActiveChildWidget) {
				return;
			}

			// deactivate current active widget
			if(pActiveChildWidget != NULL) {
				pActiveChildWidget->SetActive(false);
			}

			// find childWidget in the widget list
			WidgetList::const_iterator iter = ContainedWidgets.begin();
			while((iter != ContainedWidgets.end()) && (*iter != childWidget)) {
				++iter;
			}

			++iter;

			while(iter != ContainedWidgets.end()) {
				if((*iter)->IsActivatable() == true) {
					// activate next widget
					pActiveChildWidget = *iter;
					pActiveChildWidget->SetActive();
					return;
				}
				++iter;
			}

			// we are at the end of the list
			if(dynamic_cast<Container*>(GetParent()) != NULL) {
				pActiveChildWidget = NULL;
				SetInactive();
			} else {
				ActivateFirstActivatableWidget();
				SetActive();
			}
		}
	}

	/**
		This method activates the first activatable widget in this container.
	*/
	void ActivateFirstActivatableWidget() {
		WidgetList::const_iterator iter = ContainedWidgets.begin();
		while(iter != ContainedWidgets.end()) {
			if((*iter)->IsActivatable() == true) {
				// activate next widget
				pActiveChildWidget = *iter;
				pActiveChildWidget->SetActive();
				return;
			}
			++iter;
		}
		pActiveChildWidget = NULL;
	}

	/**
		This method must be overwritten by all container classes. It should return
		the position of the specified widget.
		\param pWidget	Widget to return position of.
		\return The position of the left upper corner
	*/
	virtual Point GetPosition(Widget* pWidget) = 0;

	typedef RobustList<Widget*> WidgetList;
	WidgetList ContainedWidgets;				///< List of widgets
	Widget* pActiveChildWidget;					///< currently active widget
};


/// A container class of explicit placed widgets
class StaticContainer : public Container {
public:
	class WidgetGeometry {
	public:
		WidgetGeometry() {
			pWidget = NULL;
			Position = Point(0,0);
			Size = Point(0,0);
		}

		WidgetGeometry(Widget* pWidget, Point Position, Point Size) {
			this->pWidget = pWidget;
			this->Position = Position;
			this->Size = Size;
		}

		Widget* pWidget;
		Point Position;
		Point Size;

		inline bool operator==(const WidgetGeometry& op) {
			return (pWidget == op.pWidget) && (Position == op.Position) && (Size == op.Size);
		}
	};

	/// default constructor
	StaticContainer() : Container() {
		;
	}

	/// default destructor
	virtual ~StaticContainer() {
		while(ContainedWidgets.begin() != ContainedWidgets.end()) {
			Widget* curWidget = *(ContainedWidgets.begin());
			curWidget->Destroy();
		}
	}

	/**
		This method removes a widget from this container. Everything
		will be resized afterwards.
		\param pChildWidget	Widget to remove
	*/
	virtual void RemoveChildWidget(Widget* pChildWidget) {
		WidgetGeometry pWidgetGeometry = getWidgetGeometry(pChildWidget);
		if(pWidgetGeometry.pWidget != NULL) {
			WidgetGeometries.remove(pWidgetGeometry);
			Container::RemoveChildWidget(pChildWidget);
		} else {
			fprintf(stderr,"StaticContainer::RemoveChildWidget: Widget not found!\n");
		}
	}

	/**
		This method will add the widget to this container at position (0,0) and with size (0,0).
		For normal widgets the other AddWidget-Method is more appropriate.
		\param newWidget	Widget to add
	*/
	virtual void AddWidget(Widget* newWidget) {
		AddWidget(newWidget,Point(0,0),Point(0,0));
	}

	/**
		This method adds a new widget to this container.
		\param newWidget	Widget to add
		\param position		Position of the new Widget
		\param size			Size of the new widget
	*/
	virtual void AddWidget(Widget* newWidget, Point position, Point size) {
		if(newWidget != NULL) {
			ContainedWidgets.push_back(newWidget);
			WidgetGeometries.push_back(WidgetGeometry(newWidget,position,size));
			newWidget->Resize(size.x, size.y);
			newWidget->SetParent(this);
			Widget::ResizeAll();
		}
	}

	/**
		This method changes the geometry of a child widget.
		\param pChildWidget	Widget to change geometry
		\param position		Position of the Widget
		\param size			Size of the widget
	*/
	virtual void SetWidgetGeometry(Widget* pChildWidget, Point position, Point size) {
		StaticContainer::WidgetGeometryList::iterator iter;
		for(iter = WidgetGeometries.begin(); iter != WidgetGeometries.end(); ++iter) {
			if(iter->pWidget == pChildWidget) {
				iter->Position = position;
				iter->Size = size;
				return;
			}
		}
	}

	/**
		Returns the minimum size of this container. The container should not
		resized to a size smaller than this. If the container is not resizeable
		in a direction this method returns the size in that direction.
		\return the minimum size of this container
	*/
	virtual Point GetMinimumSize() const {
		Point p(0,0);
		StaticContainer::WidgetGeometryList::const_iterator iter;
		for(iter = WidgetGeometries.begin(); iter != WidgetGeometries.end(); ++iter) {
			const WidgetGeometry curWidgetGeometry = *iter;
			p.x = std::max(p.x , curWidgetGeometry.Position.x + curWidgetGeometry.Size.x);
			p.y = std::max(p.y , curWidgetGeometry.Position.y + curWidgetGeometry.Size.y);
		}
		return p;
	}

	/**
		This method resized the container to width and height. This method should only be
		called if the new size is a valid size for this container (See ResizingXAllowed,
		ResizingYAllowed, GetMinumumSize). It also resizes all child widgets.
		\param	width	the new width of this container
		\param	height	the new height of this container
	*/
	virtual void Resize(Uint32 width, Uint32 height) {
		StaticContainer::WidgetGeometryList::const_iterator iter;
		for(iter = WidgetGeometries.begin(); iter != WidgetGeometries.end(); ++iter) {
			const WidgetGeometry curWidgetGeometry = *iter;
			curWidgetGeometry.pWidget->Resize(curWidgetGeometry.Size.x,curWidgetGeometry.Size.y);
		}
		Container::Resize(width,height);
	}

protected:
	/**
		Returns the WidgetGeometry that is associated with the specified widget.
		If there is no Geometry associated with pWidget then a dummy WidgetGeometry is returned
		with WidgetGeometry::pWidget = NULL, WidgetGeometry::Position = Point(0,0) and
		WidgetGeometry::Size = Point(0,0)
		\param	pWidget	Widget to look for
		\return	the WidgetGeometry of pWidget.
	*/
	WidgetGeometry getWidgetGeometry(Widget* pWidget) {
		StaticContainer::WidgetGeometryList::iterator iter;
		for(iter = WidgetGeometries.begin(); iter != WidgetGeometries.end(); ++iter) {
			WidgetGeometry curWidgetGeometry = *iter;
			if(curWidgetGeometry.pWidget == pWidget) {
				return curWidgetGeometry;
			}
		}

		return WidgetGeometry(NULL,Point(0,0),Point(0,0));
	}


	/**
		This method returns the position of the specified widget.
		\param pWidget	Widget to return position of.
		\return The position of the left upper corner
	*/
	virtual Point GetPosition(Widget* pWidget) {
		return getWidgetGeometry(pWidget).Position;
	}

private:
	typedef RobustList<WidgetGeometry> WidgetGeometryList;
	WidgetGeometryList WidgetGeometries;
};


/// A container class for horizontal aligned widgets.
class HBox : public Container {
public:
	/// default constructor
	HBox() : Container() {
		;
	}

	/// destructor
	virtual ~HBox() {
		;
	}

	/**
		Returns the minimum size of this container. The container should not
		resized to a size smaller than this. If the container is not resizeable
		in a direction this method returns the size in that direction.
		\return the minimum size of this container
	*/
	virtual Point GetMinimumSize() const {
		Point p(0,0);
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			p.x += curWidget->GetMinimumSize().x;
			p.y = std::max(p.y,curWidget->GetMinimumSize().y);
		}
		return p;
	}

	/**
		This method resized the container to width and height. This method should only be
		called if the new size is a valid size for this container (See ResizingXAllowed,
		ResizingYAllowed, GetMinumumSize). It also resizes all child widgets.
		\param	width	the new width of this container
		\param	height	the new height of this container
	*/
	virtual void Resize(Uint32 width, Uint32 height) {
		Sint32 AvailableWidth = width;

		int RemainingWidgets = ContainedWidgets.size();

		// Find objects that are not allowed to be resized
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(curWidget->ResizingXAllowed() == false) {
				AvailableWidth = AvailableWidth - curWidget->GetSize().x;
				RemainingWidgets--;
			}
		}

		Sint32 AverageWidth = 0;

		if(RemainingWidgets == 0) {
			AverageWidth = AvailableWidth;
		} else {
			AverageWidth = AvailableWidth / RemainingWidgets;
		}

		// Find objects that have a minimum size that is bigger than the average size
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(curWidget->ResizingXAllowed() == true) {
				if(curWidget->GetMinimumSize().x > AverageWidth) {
					AvailableWidth -= curWidget->GetMinimumSize().x;
					RemainingWidgets--;
				}
			}
		}

		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Sint32 WidgetHeight;
			if(curWidget->ResizingYAllowed() == true) {
				WidgetHeight = height;
			} else {
				WidgetHeight = curWidget->GetMinimumSize().y;
			}

			if(curWidget->ResizingXAllowed() == true) {
				Sint32 WidgetWidth = 0;
				if(RemainingWidgets == 0) {
					WidgetWidth = AvailableWidth;
				} else {
					WidgetWidth = AvailableWidth/RemainingWidgets;
				}

				if(WidgetWidth < curWidget->GetMinimumSize().x) {
					WidgetWidth = curWidget->GetMinimumSize().x;
					curWidget->Resize(WidgetWidth,WidgetHeight);
				} else {
					curWidget->Resize(WidgetWidth,WidgetHeight);
					AvailableWidth = AvailableWidth - WidgetWidth;
					RemainingWidgets--;
				}
			} else {
				curWidget->Resize(curWidget->GetSize().x,WidgetHeight);
			}
		}

		Container::Resize(width,height);
	}

protected:
	/**
		This method returns the position of the specified widget.
		\param pWidget	Widget to return position of.
		\return The position of the left upper corner
	*/
	virtual Point GetPosition(Widget* pWidget) {
		Point p(0,0);
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(pWidget == curWidget) {
				return p;
			} else {
				p.x = p.x + curWidget->GetSize().x;
			}
		}
		//should not happen
		return Point(0,0);
	}
};




/// A container class for vertical aligned widgets.
class VBox : public Container {
public:
	/// default constructor
	VBox() : Container() {
		;
	}

	/// destructor
	virtual ~VBox() {
		;
	}

	/**
		Returns the minimum size of this container. The container should not
		resized to a size smaller than this. If the container is not resizeable
		in a direction this method returns the size in that direction.
		\return the minimum size of this container
	*/
	virtual Point GetMinimumSize() const {
		Point p(0,0);
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			p.x = std::max(p.x,curWidget->GetMinimumSize().x);
			p.y += curWidget->GetMinimumSize().y;
		}
		return p;
	}

	/**
		This method resized the container to width and height. This method should only be
		called if the new size is a valid size for this container (See ResizingXAllowed,
		ResizingYAllowed, GetMinumumSize). It also resizes all child widgets.
		\param	width	the new width of this container
		\param	height	the new height of this container
	*/
	virtual void Resize(Uint32 width, Uint32 height) {
		Sint32 AvailableHeight = height;

		int RemainingWidgets = ContainedWidgets.size();

		// Find objects that are not allowed to be resized
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(curWidget->ResizingYAllowed() == false) {
				AvailableHeight = AvailableHeight - curWidget->GetSize().y;
				RemainingWidgets--;
			}
		}

		Sint32 AverageHeight = 0;
		if(RemainingWidgets == 0) {
			AverageHeight = AvailableHeight;
		} else {
			AverageHeight = AvailableHeight / RemainingWidgets;
		}

		// Find objects that have a minimum size that is bigger than the average size
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(curWidget->ResizingYAllowed() == true) {
				if(curWidget->GetMinimumSize().y > AverageHeight) {
					AvailableHeight -= curWidget->GetMinimumSize().y;
					RemainingWidgets--;
				}
			}
		}

		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			Sint32 WidgetWidth;
			if(curWidget->ResizingXAllowed() == true) {
				WidgetWidth = width;
			} else {
				WidgetWidth = curWidget->GetMinimumSize().x;
			}

			if(curWidget->ResizingYAllowed() == true) {
				Sint32 WidgetHeight = 0;
				if(RemainingWidgets == 0) {
					WidgetHeight = AvailableHeight;
				} else {
					WidgetHeight = AvailableHeight/RemainingWidgets;
				}

				if(WidgetHeight < curWidget->GetMinimumSize().y) {
					WidgetHeight = curWidget->GetMinimumSize().y;
					curWidget->Resize(WidgetWidth,WidgetHeight);
				} else {
					curWidget->Resize(WidgetWidth,WidgetHeight);
					AvailableHeight = AvailableHeight - WidgetHeight;
					RemainingWidgets--;
				}
			} else {
				curWidget->Resize(WidgetWidth,curWidget->GetSize().y);
			}
		}

		Container::Resize(width,height);
	}

protected:
	/**
		This method returns the position of the specified widget.
		\param pWidget	Widget to return position of.
		\return The position of the left upper corner
	*/
	virtual Point GetPosition(Widget* pWidget) {
		Point p(0,0);
		Container::WidgetList::const_iterator iter;
		for(iter = ContainedWidgets.begin(); iter != ContainedWidgets.end(); ++iter) {
			Widget* curWidget = *iter;
			if(pWidget == curWidget) {
				return p;
			} else {
				p.y = p.y + curWidget->GetSize().y;
			}
		}
		//should not happen
		return Point(0,0);
	}
};

#endif // CONTAINER_H
