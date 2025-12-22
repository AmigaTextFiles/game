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
 * 
 * The main entity for the game, this is used to capture information about the colour/type
 * of a bubble. It is housed in either a bullet or a carriage which aid in the movement.
 * This also animates some of the special types of bubbles like timers etc.
 * 
 */
 
#ifndef BUBBLE_H
#define BUBBLE_H

#include "General.h"
#include "Theme.h"

#define BUBBLE_RAD 15		
#define BUBBLE_SIZE BUBBLE_RAD * 2

class Bubble
{

protected:
  Colour colour;
  Point position;
  
private: 
  
  SFX effectType;			// Defines the type of special bubble
  double speedMultiplier;	// Used for speed bubbles where 1 is the normal and anything else is used to adjust the speed of the train.
  int	maxColours;			// Defines the maximum number of colours used in the current level.
  int	endTime;			// This is the time which special bubbles like speed should change back into a normal bubble
  int	effectLife;			// The time remaining before the special bubble changes back into a normal bubble.
  bool 	timerEnabled;		// Determines if the timer is running or not. So can create a special bubble which depends on time
							//				but the timer doesn't need to start until it has reached the train.
  
  void initialise();
  
public:

  // Constructors - note the default copy constructor is also used, because 
  // 				we don't have pointers
  Bubble(Colour colour);
  Bubble(SFX type);
  Bubble(Colour colour, Point position);
  virtual ~Bubble();
  
  // Accessor methods
  Colour getColour();
  Point getPosition();
  SFX getType();
  void setType(SFX type);
  double getSpeedMultiplier();
  void setPosition(Point position);
  void setMaxColour(int maxCol);
  void resetToNormal();
  void startTimer();
  
  // Iwidget items
  bool onScreen(Rect range, bool allInRange);
  void animate();
  void draw(SDL_Surface* screen);
  void draw(SDL_Surface* screen, Point pos);

};

#endif
