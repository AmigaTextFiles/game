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
 
#include "LevelEditor.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_DEBUG

LevelEditor::LevelEditor(SDL_Surface* screen) : Window(screen, Rect(0,0,screen->w, screen->h))
{
	// Make sure we are using the default theme for the correct fonts etc.
	Theme::Instance()->load("", "default");
	Theme::Instance()->stopMusic();
	
	this->filename = NULL;
	this->dirty = false;
	this->state	= LES_NORMAL;

	// Colours
	this->activeColour		= SDL_MapRGB(screen->format, 0x33, 0x33, 0x33);
	this->inActiveColour	= SDL_MapRGB(screen->format, 0x99, 0x99, 0x99);
	this->propertyWinColour	= SDL_MapRGB(screen->format, 0x7c, 0x7c, 0x7c);
	this->windowColour		= SDL_MapRGB(screen->format, 0x99, 0x99, 0x99);

	// Grid options
	this->xGridSpace = 20;
	this->yGridSpace = 20;
	this->gridColour = SDL_MapRGB(screen->format, 0x99, 0x66, 0x66);
	this->displayGrid = true;

	// Set the background colour but disable the drawing of the background in the winodw
	// class because we want to control the drawing order.
	Window::setBackgroundColour(this->windowColour);
	Window::setModal(false);
	Window::setEnabledBackground(false);
	
	// Create a label for error / feedback messages - positioned at top left of the screen
	this->testlabel = new Label(Point(1,1), Point(screen->w - 2, 10));
	this->testlabel->setLabelText("");
	Window::addControl(this->testlabel);

	// Create each of the property windows
	LevelEditor::intialiseMainPropWindow(screen);
	LevelEditor::intialiseTrackPropWindow(screen);
	LevelEditor::intialiseTrainPropWindow(screen);
	LevelEditor::intialiseCannonPropWindow(screen);
	LevelEditor::intialiseLinePropWindow(screen);
	LevelEditor::intialiseArcPropWindow(screen);
	LevelEditor::intialiseSpiralPropWindow(screen);
	LevelEditor::intialiseGridPropWindow(screen);
	
	// Intialise track lists
	this->trains.DeleteAndRemove();
	this->currentTrain = this->trains.GetIterator();
	LevelEditor::newTrack();
}

LevelEditor::~LevelEditor()
{

}

bool LevelEditor::mouseDown(int x, int y)
{
	// If none of the property windows were clicked then it must 
	// have been clicked on the back ground
	if (!Window::mouseDown(x, y) && this->state != LES_NORMAL)
	{
		this->clickPoints.Append(Point(x,y));
		LevelEditor::addTrackSection();
	}
	return true;
}

void LevelEditor::draw(SDL_Surface* screenDest)
{
	// Make sure all of the drawing in this window is drawn onto the parents
	// window screen. The window blits this window screen onto the screenDest.
	// If we don't draw on window screen then we don't clear out the background
	// properly.
	
	// Reset the background
	SDL_FillRect(Window::windowScreen, NULL, Window::getBackgroundColour());

	// Fill in the grid for the background	
	if (this->displayGrid)
		LevelEditor::drawGrid(Window::windowScreen);
	
	// Now draw the custom click no the screen for now.
	DListIterator<Point> pIter = this->clickPoints.GetIterator();
	pIter.Start();
	while (pIter.Valid())
	{
		Theme::Instance()->drawArc(Window::windowScreen, this->activeColour, pIter.Item(), 2*M_PI, 0.0, 3, ROT_CLOCKWISE);
		pIter.Forth();
	}
		
	// Draw the list of tracks
	DListIterator< LETrain* > tIter = this->trains.GetIterator();
	tIter.Start();
	while (tIter.Valid())
	{
		DListIterator<TrackSection*> tsIter = tIter.Item()->tracks.GetIterator();
		tsIter.Start();
		while (tsIter.Valid())
		{
			tsIter.Item()->draw(Window::windowScreen);
			tsIter.Forth();
		}
		// Draw the start end circles
		if (tIter.Item()->tracks.Size() > 0)
		{
			// If the current track then draw discs otherwise draw circles
			if (tIter.Item() == this->currentTrain.Item())
			{
				Theme::Instance()->drawDisc(Window::windowScreen, SDL_MapRGB(screenDest->format, 0, 0xff ,0), tIter.Item()->tracks.m_head->m_data->getStartPosition(), 3);
				Theme::Instance()->drawDisc(Window::windowScreen, SDL_MapRGB(screenDest->format, 0xff, 0 ,0), tIter.Item()->tracks.m_tail->m_data->getEndPosition(), 3);
			}
			else
			{
				Theme::Instance()->drawCircle(Window::windowScreen, SDL_MapRGB(screenDest->format, 0, 0xff ,0), tIter.Item()->tracks.m_head->m_data->getStartPosition(), 3);
				Theme::Instance()->drawCircle(Window::windowScreen, SDL_MapRGB(screenDest->format, 0xff, 0 ,0), tIter.Item()->tracks.m_tail->m_data->getEndPosition(), 3);
			}
		}
		tIter.Forth();
	}
	
	// Draw all property windows / controls
	// Note this will also blit this current window screen across
	Window::draw(screenDest);
	
	
}

// When ever there is a mouse down on the background then 
// check if we are adding a new track section and use the list of 
// points to create the next item.
// If the train is empty then it requires two otherwise it appends onto the end
// of the train.
void LevelEditor::addTrackSection()
{
	bool addTrack = false;
			
	switch(this->state)
	{
		case LES_ADD_LINE:
		{
			Point startPos;
			// Make it append the line to the end of the previous track section
			if (this->clickPoints.Size() == 1 and this->currentTrain.Item()->tracks.Size() > 0)
			{
				addTrack = true;
				startPos = this->currentTrain.Item()->tracks.m_tail->m_data->getEndPosition();
			}
			else if (this->clickPoints.Size() == 2)
			{
				addTrack = true;
				startPos = this->clickPoints.m_head->m_data;
			}
			
			if (addTrack)
			{
				this->currentTrain.Item()->tracks.Append(new TrackLine(startPos, this->clickPoints.m_tail->m_data));
				this->clickPoints.RemoveAll();
				if (!this->stickyTrackButtons)
				{
					this->state = LES_NORMAL;
					this->btnAddLine->setActive(false);
				}
			}
				
			break;
		}
		case LES_ADD_ARC:
		{
			Point startPos;
			
			// Make it append the arc to the end of the previous track section
			if (this->clickPoints.Size() == 1 and this->currentTrain.Item()->tracks.Size() > 0)
			{
				addTrack = true;
				startPos = this->currentTrain.Item()->tracks.m_tail->m_data->getEndPosition();
			}
			else if (this->clickPoints.Size() == 2)
			{
				addTrack = true;
				startPos = this->clickPoints.m_head->m_data;
			}
			
			if (addTrack)
			{
				// Make the radius of the arc 1/2 the distance between the two points
				Point endPos = this->clickPoints.m_tail->m_data;
				double dist  = endPos.distanceFrom(startPos);
				
				this->currentTrain.Item()->tracks.Append(new TrackArc(startPos, endPos, dist / 2, ROT_CLOCKWISE));
				this->clickPoints.RemoveAll();
				if (!this->stickyTrackButtons)
				{
					this->state = LES_NORMAL;
					this->btnAddArc->setActive(false);
				}
			}
			break;
		}
		case LES_ADD_SPIRAL:
		{
			Point startPos;
			
			// Make it append the spiral to the end of the previous track section
			if (this->clickPoints.Size() == 1 and this->currentTrain.Item()->tracks.Size() > 0)
			{
				addTrack = true;
				startPos = this->currentTrain.Item()->tracks.m_tail->m_data->getEndPosition();
			}
			else if (this->clickPoints.Size() == 2)
			{
				addTrack = true;
				startPos = this->clickPoints.m_head->m_data;
			}
			
			if (addTrack)
			{
				Point centrePos = this->clickPoints.m_tail->m_data;
				
				// Create a new arc with the default settings 
				this->currentTrain.Item()->tracks.Append(new TrackSpiral(startPos, centrePos, 1.5, ROT_CLOCKWISE));
				
				this->clickPoints.RemoveAll();
				if (!this->stickyTrackButtons)
				{
					this->state = LES_NORMAL;
					this->btnAddSpiral->setActive(false);
				}
			}
			break;
		}
		default:
			break;	
	}
	
	// Set the colour of the current item back to black before setting
	// the new item as the current one.
	if (addTrack)
	{
		LevelEditor::resetTrackSectionColour();
		this->currentTrackSection.End();
		LevelEditor::highlightTrackSection();
	}
}

//-------------------------------------------------------
// Line Property Window
//-------------------------------------------------------
	
// Line Load
void LevelEditor::intialiseLinePropWindow(SDL_Surface* screen)
{
	int mainWidth = 145;
	int mainHeight = 80;
	Point mainPos(screen->w - mainWidth - 1 ,screen->h - mainHeight - 1);
	
	this->linePropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	
	this->linePropWindow->setModal(false);
	this->linePropWindow->setBackgroundColour(this->propertyWinColour);
	this->linePropWindow->setInnerBevel(true);
	this->linePropWindow->setVisible(false);
		
	// Spacing for controls
	int left 		= 0;
	int top 		= 5;
	int txtWidth 	= 28;
	int txtHeight 	= 14;
	int hozSpace 	= 35;
	int vertSpace	= 23;
	int controlLeft = 70;
	int textLeft	= 5;

	left = textLeft;

	// Property title
	Label* linelabel = new Label(Point(left, top), Point(mainWidth - left * 2, top + 10));
	linelabel->setLabelText("LINE");
	this->linePropWindow->addControl(linelabel);
	
	top += vertSpace;
	
	// Start position x and y
	// -----------------------
	Label* startlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	startlabel->setLabelText("Start X,Y:");
	this->linePropWindow->addControl(startlabel);

	left = controlLeft;

	// start x position
	Callback0<LevelEditor> startPosCallBack(*this, &LevelEditor::updateLineStartPos);
	Rect rtxtXPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosStartLine = new TextBox(rtxtXPosStart);
	this->txtXPosStartLine->setText("");
	this->txtXPosStartLine->setTextLimit(3);
	this->txtXPosStartLine->addChangeEvent(startPosCallBack);
	this->txtXPosStartLine->setActiveColour(this->activeColour);
	this->txtXPosStartLine->setInActiveColour(this->inActiveColour);
	this->linePropWindow->addControl(this->txtXPosStartLine);

	left += hozSpace;

	// start y position
	Rect rtxtYPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosStartLine = new TextBox(rtxtYPosStart);
	this->txtYPosStartLine->setText("");
	this->txtYPosStartLine->setTextLimit(3);
	this->txtYPosStartLine->addChangeEvent(startPosCallBack);
	this->txtYPosStartLine->setActiveColour(this->activeColour);
	this->txtYPosStartLine->setInActiveColour(this->inActiveColour);
	this->linePropWindow->addControl(this->txtYPosStartLine);

	left = textLeft;
	top += vertSpace;

	// End position x and y
	// -----------------------
	Label* endlabel = new Label(Point(left, top), Point(70, top + 10));
	endlabel->setLabelText("End X,Y:");
	this->linePropWindow->addControl(endlabel);

	left = controlLeft;

	// end x position
	Callback0<LevelEditor> endPosCallBack(*this, &LevelEditor::updateLineEndPos);
	Rect rtxtXPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosEndLine = new TextBox(rtxtXPosEnd);
	this->txtXPosEndLine->setText("");
	this->txtXPosEndLine->setTextLimit(3);
	this->txtXPosEndLine->addChangeEvent(endPosCallBack);
	this->txtXPosEndLine->setActiveColour(this->activeColour);
	this->txtXPosEndLine->setInActiveColour(this->inActiveColour);
	this->linePropWindow->addControl(this->txtXPosEndLine);

	left += hozSpace;

	// end y position
	Rect rtxtYPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosEndLine = new TextBox(rtxtYPosEnd);
	this->txtYPosEndLine->setText("");
	this->txtYPosEndLine->setTextLimit(3);
	this->txtYPosEndLine->addChangeEvent(endPosCallBack);
	this->txtYPosEndLine->setActiveColour(this->activeColour);
	this->txtYPosEndLine->setInActiveColour(this->inActiveColour);
	this->linePropWindow->addControl(this->txtYPosEndLine);

	Window::addControl(this->linePropWindow);
}

void LevelEditor::populateLinePropWindow()
{
	// Take the current track section and if it is a line then populate
	// the line edit property window with it's values
	
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_LINE)
		return;
		
	char buffer[5];
	sprintf (buffer, "%d", (int)this->currentTrackSection.Item()->getStartPosition().x); 		
	this->txtXPosStartLine->setText(buffer);
	sprintf (buffer, "%d", (int)this->currentTrackSection.Item()->getStartPosition().y); 		
	this->txtYPosStartLine->setText(buffer);
	
	sprintf (buffer, "%d", (int)this->currentTrackSection.Item()->getEndPosition().x); 		
	this->txtXPosEndLine->setText(buffer);
	sprintf (buffer, "%d", (int)this->currentTrackSection.Item()->getEndPosition().y); 		
	this->txtYPosEndLine->setText(buffer);
}

// Main events
void LevelEditor::updateLineStartPos()
{
	// The start position has changed in the edit window so update
	// the position in the line section
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_LINE)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosStartLine->getText());
	y = atoi(this->txtYPosStartLine->getText());
	Point pos(x,y);
	this->currentTrackSection.Item()->setStartPosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updatePreviousEndPos(pos);

}

void LevelEditor::updateLineEndPos()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_LINE)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosEndLine->getText());
	y = atoi(this->txtYPosEndLine->getText());
	Point pos(x,y);
	this->currentTrackSection.Item()->setEndPosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updateNextStartPos(pos);
}

//-------------------------------------------------------
// Arc Property Window
//-------------------------------------------------------
	
// Arc Load
void LevelEditor::intialiseArcPropWindow(SDL_Surface* screen)
{
	int mainWidth = 145;
	int mainHeight = 135;
	Point mainPos(screen->w - mainWidth - 1 ,screen->h - mainHeight - 1);
	
	this->arcPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	
	this->arcPropWindow->setModal(false);
	this->arcPropWindow->setBackgroundColour(this->propertyWinColour);
	this->arcPropWindow->setInnerBevel(true);
	this->arcPropWindow->setVisible(false);
		
	// Control Spacing
	int left 		= 5;
	int top 		= 5;
	int txtWidth 	= 28;
	int txtHeight 	= 14;
	int hozSpace 	= 35;
	int vertSpace	= 23;
	int controlLeft = 70;
	int textLeft	= 5;
	int checkboxLeft= 100;

	// Arc property title
	Label* arclabel = new Label(Point(left, top), Point(mainWidth - 2 * left, top + 10));
	arclabel->setLabelText("ARC");
	this->arcPropWindow->addControl(arclabel);
	
	top += vertSpace;

	// Start position x and y
	// -----------------------
	Label* startlabel = new Label(Point(left, top),	Point(controlLeft, top + 10));
	startlabel->setLabelText("Start X,Y:");
	this->arcPropWindow->addControl(startlabel);

	left = controlLeft;
	
	// Start x component
	Callback0<LevelEditor> startPosCallBack(*this, &LevelEditor::updateArcStartPos);
	Rect rtxtXPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosStartArc = new TextBox(rtxtXPosStart);
	this->txtXPosStartArc->setText("");
	this->txtXPosStartArc->setTextLimit(3);
	this->txtXPosStartArc->addChangeEvent(startPosCallBack);
	this->txtXPosStartArc->setActiveColour(this->activeColour);
	this->txtXPosStartArc->setInActiveColour(this->inActiveColour);
	this->arcPropWindow->addControl(this->txtXPosStartArc);

	left += hozSpace;

	// Start y component
	Rect rtxtYPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosStartArc = new TextBox(rtxtYPosStart);
	this->txtYPosStartArc->setText("");
	this->txtYPosStartArc->setTextLimit(3);
	this->txtYPosStartArc->addChangeEvent(startPosCallBack);
	this->txtYPosStartArc->setActiveColour(this->activeColour);
	this->txtYPosStartArc->setInActiveColour(this->inActiveColour);
	this->arcPropWindow->addControl(this->txtYPosStartArc);

	left = textLeft;
	top += vertSpace;

	// End position x and y
	// -----------------------
	Label* endlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	endlabel->setLabelText("End X,Y:");
	this->arcPropWindow->addControl(endlabel);

	left = controlLeft;
	
	// End x component
	Callback0<LevelEditor> endPosCallBack(*this, &LevelEditor::updateArcEndPos);
	Rect rtxtXPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosEndArc = new TextBox(rtxtXPosEnd);
	this->txtXPosEndArc->setText("");
	this->txtXPosEndArc->setTextLimit(3);
	this->txtXPosEndArc->addChangeEvent(endPosCallBack);
	this->txtXPosEndArc->setActiveColour(this->activeColour);
	this->txtXPosEndArc->setInActiveColour(this->inActiveColour);
	this->arcPropWindow->addControl(this->txtXPosEndArc);

	left += hozSpace;
	
	// End y component
	Rect rtxtYPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosEndArc = new TextBox(rtxtYPosEnd);
	this->txtYPosEndArc->setText("");
	this->txtYPosEndArc->setTextLimit(3);
	this->txtYPosEndArc->addChangeEvent(endPosCallBack);
	this->txtYPosEndArc->setActiveColour(this->activeColour);
	this->txtYPosEndArc->setInActiveColour(this->inActiveColour);
	this->arcPropWindow->addControl(this->txtYPosEndArc);

	left = textLeft;
	top += vertSpace;

	// Radius of arc
	// -----------------------
	Label* centrelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	centrelabel->setLabelText("Radius:");
	this->arcPropWindow->addControl(centrelabel);

	left = controlLeft;
	
	// Radius text component
	Callback0<LevelEditor> centrePosCallBack(*this, &LevelEditor::updateArcRadius);
	Rect rtxtXPosCentre(left, top, left + txtWidth, top + txtHeight);
	this->txtRadiusArc = new TextBox(rtxtXPosCentre);
	this->txtRadiusArc->setText("");
	this->txtRadiusArc->setTextLimit(3);
	this->txtRadiusArc->addChangeEvent(centrePosCallBack);
	this->txtRadiusArc->setActiveColour(this->activeColour);
	this->txtRadiusArc->setInActiveColour(this->inActiveColour);
	this->arcPropWindow->addControl(this->txtRadiusArc);
	
	left = textLeft;
	top += vertSpace;

	// Arc rotation
	// -----------------------
	Label* rotlabel = new Label(Point(left, top), Point(checkboxLeft, top + 10));
	rotlabel->setLabelText("Rotation (CW):");
	this->arcPropWindow->addControl(rotlabel);

	left = checkboxLeft;

	// Rotation component
	Callback0<LevelEditor> rotPosCallBack(*this, &LevelEditor::updateArcRotation);
	this->chkRotationArc = new CheckBox(Point(left, top));
	this->chkRotationArc->addChangeEvent(rotPosCallBack);
	this->chkRotationArc->setActiveColour(this->activeColour);
	this->chkRotationArc->setInActiveColour(this->inActiveColour);
	this->chkRotationArc->setBevelType(BEV_INNER);
	this->arcPropWindow->addControl(this->chkRotationArc);

	left = textLeft;
	top += vertSpace;

	// Arc flip - flip the centre of the arc from one side to the other
	// -----------------------
	Label* fliplabel = new Label(Point(left, top), Point(checkboxLeft, top + 10));
	fliplabel->setLabelText("Flip:");
	this->arcPropWindow->addControl(fliplabel);

	left = checkboxLeft;

	// Flip component
	Callback0<LevelEditor> flipCallBack(*this, &LevelEditor::updateArcFlip);
	this->chkFlipArc = new CheckBox(Point(left, top));
	this->chkFlipArc->addChangeEvent(flipCallBack);
	this->chkFlipArc->setActiveColour(this->activeColour);
	this->chkFlipArc->setInActiveColour(this->inActiveColour);
	this->chkFlipArc->setBevelType(BEV_INNER);
	this->arcPropWindow->addControl(this->chkFlipArc);  

	Window::addControl(this->arcPropWindow);
}

void LevelEditor::populateArcPropWindow()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
		
	TrackArc* arc = (TrackArc*)this->currentTrackSection.Item();
	char buffer[5];
	sprintf (buffer, "%d", (int)arc->getStartPosition().x); 		
	this->txtXPosStartArc->setText(buffer);
	sprintf (buffer, "%d", (int)arc->getStartPosition().y); 		
	this->txtYPosStartArc->setText(buffer);
	
	sprintf (buffer, "%d", (int)arc->getEndPosition().x); 		
	this->txtXPosEndArc->setText(buffer);
	sprintf (buffer, "%d", (int)arc->getEndPosition().y); 		
	this->txtYPosEndArc->setText(buffer);
	
	sprintf (buffer, "%d", (int)arc->getRadius()); 		
	this->txtRadiusArc->setText(buffer);
	
	this->chkRotationArc->setChecked(arc->getRotation() == ROT_CLOCKWISE);

	this->chkFlipArc->setChecked(arc->getFlip());

}

// Main events
void LevelEditor::updateArcStartPos()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosStartArc->getText());
	y = atoi(this->txtYPosStartArc->getText());
	Point pos(x,y);
	this->currentTrackSection.Item()->setStartPosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updatePreviousEndPos(pos);

}

void LevelEditor::updateArcEndPos()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosEndArc->getText());
	y = atoi(this->txtYPosEndArc->getText());
	Point pos(x,y);
	this->currentTrackSection.Item()->setEndPosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updateNextStartPos(pos);
}

void LevelEditor::updateArcRadius()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
	
	TrackArc* arc = (TrackArc*)this->currentTrackSection.Item();
	
	int r = atoi(this->txtRadiusArc->getText());
	arc->setRadius(r);
}

void LevelEditor::updateArcRotation()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
	
	TrackArc* arc = (TrackArc*)this->currentTrackSection.Item();
	if (this->chkRotationArc->getChecked())
		arc->setRotation(ROT_CLOCKWISE);
	else
		arc->setRotation(ROT_ANTI_CLOCKWISE);
}

void LevelEditor::updateArcFlip()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_ARC)
		return;
	
	TrackArc* arc = (TrackArc*)this->currentTrackSection.Item();
	arc->setFlip(this->chkFlipArc->getChecked());

	char buffer[5];
	sprintf (buffer, "%d", (int)arc->getRadius()); 		
	this->txtRadiusArc->setText(buffer);
}

//-------------------------------------------------------
// Spiral Property Window
//-------------------------------------------------------
// Main Load
void LevelEditor::intialiseSpiralPropWindow(SDL_Surface* screen)
{
	int mainWidth = 145;
	int mainHeight = 135;
	Point mainPos(screen->w - mainWidth - 1 ,screen->h - mainHeight - 1);
	
	this->spiralPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	
	this->spiralPropWindow->setModal(false);
	this->spiralPropWindow->setBackgroundColour(this->propertyWinColour);
	this->spiralPropWindow->setInnerBevel(true);
	this->spiralPropWindow->setVisible(false);

	// Control spacing
	int left 	= 5;
	int top 	= 5;
	int txtWidth 	= 28;
	int txtHeight 	= 14;
	int hozSpace 	= 35;
	int vertSpace	= 23;
	int controlLeft = 70;
	int textLeft	= 5;
	int checkBoxLeft= 100;

	// Spiral property title
	Label* spirallabel = new Label(Point(left, top), Point(mainWidth - 2 * left, top + 10));
	spirallabel->setLabelText("SPIRAL");
	this->spiralPropWindow->addControl(spirallabel);
	
	top += vertSpace;

	// Start position x and y
	// -----------------------
	Label* startlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	startlabel->setLabelText("Start X,Y:");
	this->spiralPropWindow->addControl(startlabel);

	left = controlLeft;

	// Start x component
	Callback0<LevelEditor> startPosCallBack(*this, &LevelEditor::updateSpiralStartPos);
	Rect rtxtXPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosStartSpiral = new TextBox(rtxtXPosStart);
	this->txtXPosStartSpiral->setText("");
	this->txtXPosStartSpiral->setTextLimit(3);
	this->txtXPosStartSpiral->addChangeEvent(startPosCallBack);
	this->txtXPosStartSpiral->setActiveColour(this->activeColour);
	this->txtXPosStartSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtXPosStartSpiral);

	left += hozSpace;

	// Start y component
	Rect rtxtYPosStart(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosStartSpiral = new TextBox(rtxtYPosStart);
	this->txtYPosStartSpiral->setText("");
	this->txtYPosStartSpiral->setTextLimit(3);
	this->txtYPosStartSpiral->addChangeEvent(startPosCallBack);
	this->txtYPosStartSpiral->setActiveColour(this->activeColour);
	this->txtYPosStartSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtYPosStartSpiral);

	left = textLeft;
	top += vertSpace;
	
	// Centre position x and y
	// -----------------------
	Label* endlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	endlabel->setLabelText("Centre X,Y:");
	this->spiralPropWindow->addControl(endlabel);

	left = controlLeft;

	// Centre x component
	Callback0<LevelEditor> endPosCallBack(*this, &LevelEditor::updateSpiralCentrePos);
	Rect rtxtXPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtXPosCentreSpiral = new TextBox(rtxtXPosEnd);
	this->txtXPosCentreSpiral->setText("");
	this->txtXPosCentreSpiral->setTextLimit(3);
	this->txtXPosCentreSpiral->addChangeEvent(endPosCallBack);
	this->txtXPosCentreSpiral->setActiveColour(this->activeColour);
	this->txtXPosCentreSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtXPosCentreSpiral);

	left += hozSpace;

	// Centre y component
	Rect rtxtYPosEnd(left, top, left + txtWidth, top + txtHeight);
	this->txtYPosCentreSpiral = new TextBox(rtxtYPosEnd);
	this->txtYPosCentreSpiral->setText("");
	this->txtYPosCentreSpiral->setTextLimit(3);
	this->txtYPosCentreSpiral->addChangeEvent(endPosCallBack);
	this->txtYPosCentreSpiral->setActiveColour(this->activeColour);
	this->txtYPosCentreSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtYPosCentreSpiral);

	left = textLeft;
	top += vertSpace;

	// Number of turns in the spiral
	// -----------------------
	Label* turnslabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	turnslabel->setLabelText("Turns:");
	this->spiralPropWindow->addControl(turnslabel);

	left = controlLeft;

	// Spiral component
	Callback0<LevelEditor> turnsCallBack(*this, &LevelEditor::updateSpiralNumOfTurns);
	Rect rtxtTurns(left, top, left + 2 * txtWidth, top + txtHeight);
	this->txtNumOfTurnsSpiral = new TextBox(rtxtTurns);
	this->txtNumOfTurnsSpiral->setText("");
	this->txtNumOfTurnsSpiral->setTextLimit(5);
	this->txtNumOfTurnsSpiral->addChangeEvent(turnsCallBack);
	this->txtNumOfTurnsSpiral->setActiveColour(this->activeColour);
	this->txtNumOfTurnsSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtNumOfTurnsSpiral);

	left = textLeft;
	top += vertSpace;
	
	// Spiral radius of the start point
	// -----------------------
	Label* centrelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	centrelabel->setLabelText("Radius:");
	this->spiralPropWindow->addControl(centrelabel);

	left = controlLeft;
	
	// Radius component
	Callback0<LevelEditor> centrePosCallBack(*this, &LevelEditor::updateSpiralRadius);
	Rect rtxtXPosCentre(left, top, left + txtWidth, top + txtHeight);
	this->txtRadiusSpiral = new TextBox(rtxtXPosCentre);
	this->txtRadiusSpiral->setText("");
	this->txtRadiusSpiral->setTextLimit(3);
	this->txtRadiusSpiral->addChangeEvent(centrePosCallBack);
	this->txtRadiusSpiral->setActiveColour(this->activeColour);
	this->txtRadiusSpiral->setInActiveColour(this->inActiveColour);
	this->spiralPropWindow->addControl(this->txtRadiusSpiral);

	left = textLeft;
	top += vertSpace;

	// Rotation
	// -----------------------
	Label* rotlabel = new Label(Point(left, top), Point(checkBoxLeft, top + 10));
	rotlabel->setLabelText("Rotation (CW):");
	this->spiralPropWindow->addControl(rotlabel);

	left = checkBoxLeft;

	// Rotation component
	Callback0<LevelEditor> rotPosCallBack(*this, &LevelEditor::updateSpiralRotation);
	this->chkRotationSpiral = new CheckBox(Point(left, top));
	this->chkRotationSpiral->addChangeEvent(rotPosCallBack);
	this->chkRotationSpiral->setActiveColour(this->activeColour);
	this->chkRotationSpiral->setInActiveColour(this->inActiveColour);
	this->chkRotationSpiral->setBevelType(BEV_INNER);
	this->spiralPropWindow->addControl(this->chkRotationSpiral);
	
	Window::addControl(this->spiralPropWindow);
}

void LevelEditor::populateSpiralPropWindow()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_SPIRAL)
		return;
		
	TrackSpiral* spiral = (TrackSpiral*)this->currentTrackSection.Item();
	char buffer[5];
	
	// Start Pos Coordinates
	sprintf (buffer, "%d", (int)spiral->getStartPosition().x); 
	this->txtXPosStartSpiral->setText(buffer);
	sprintf (buffer, "%d", (int)spiral->getStartPosition().y); 
	this->txtYPosStartSpiral->setText(buffer);
	
	// End Pos Coordinates
	sprintf (buffer, "%d", (int)spiral->getCentrePosition().x);
	this->txtXPosCentreSpiral->setText(buffer);
	sprintf (buffer, "%d", (int)spiral->getCentrePosition().y); 
	this->txtYPosCentreSpiral->setText(buffer);
	
	// Num of turns
	sprintf (buffer, "%.2f", spiral->getNumberOfTurns()); 
	this->txtNumOfTurnsSpiral->setText(buffer);
	
	// Radius
	sprintf (buffer, "%d", (int)spiral->getRadius());
	this->txtRadiusSpiral->setText(buffer);
	
	// Rotation
	this->chkRotationSpiral->setChecked(spiral->getRotation() == ROT_CLOCKWISE);
}

// Main events
void LevelEditor::updateSpiralStartPos()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_SPIRAL)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosStartSpiral->getText());
	y = atoi(this->txtYPosStartSpiral->getText());
	Point pos(x,y);
	this->currentTrackSection.Item()->setStartPosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updatePreviousEndPos(pos);
	
}

void LevelEditor::updateSpiralCentrePos()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_SPIRAL)
		return;
	
	int x,y;
	
	x = atoi(this->txtXPosCentreSpiral->getText());
	y = atoi(this->txtYPosCentreSpiral->getText());
	Point pos(x,y);
	
	TrackSpiral* spiral = (TrackSpiral*)this->currentTrackSection.Item();
	spiral->setCentrePosition(pos);
	
	// Update the end position of the item before us
	LevelEditor::updateNextStartPos(pos);
	
}

void LevelEditor::updateSpiralNumOfTurns()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_SPIRAL)
		return;
	
	double turns;
	
	turns = atof(this->txtNumOfTurnsSpiral->getText());
	TrackSpiral* spiral = (TrackSpiral*)this->currentTrackSection.Item();
	
	spiral->setNumberOfTurns(turns);
	
	// Update the start position of the item a after us
	LevelEditor::updateNextStartPos(spiral->getEndPosition());
	
}	

void LevelEditor::updateSpiralRadius()
{
	
}

void LevelEditor::updateSpiralRotation()
{
	if (!this->currentTrackSection.Valid())
		return;
	
	if (this->currentTrackSection.Item()->getType() != TT_SPIRAL)
		return;
	
	TrackSpiral* spiral = (TrackSpiral*)this->currentTrackSection.Item();
	if (this->chkRotationSpiral->getChecked())
		spiral->setRotation(ROT_CLOCKWISE);
	else
		spiral->setRotation(ROT_ANTI_CLOCKWISE);
}

//-------------------------------------------------------
// Cannon Properties
//-------------------------------------------------------


// Main Load
void LevelEditor::intialiseCannonPropWindow(SDL_Surface* screen)
{
	int mainWidth = 160;
	int mainHeight = 190;
	Point mainPos(screen->w - mainWidth - 1 , 190);
	
	this->cannonPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	this->cannonPropWindow->setModal(false);
	this->cannonPropWindow->setBackgroundColour(this->propertyWinColour);
	this->cannonPropWindow->setInnerBevel(true);
	this->cannonPropWindow->setVisible(true);

	// Control spacing
	int left 	= 5;
	int top 	= 5;
	int txtWidth 	= 35;
	int txtHeight 	= 14;
	int vertSpace	= 23;
	int controlLeft = 120;
	int textLeft	= 5;

	// Cannon property title
	Label* trainlabel = new Label(Point(left, top), Point(mainWidth - 2 * left, top + 10));
	trainlabel->setLabelText("CANNON PROPERTIES");
	this->cannonPropWindow->addControl(trainlabel);

	// Get all of the properties to use the same update event
	Callback0<LevelEditor> cannonPropCallBack(*this, &LevelEditor::updateCannonProps);
	
	top += vertSpace;

	// Number of colours being fired from the cannon
	// -----------------------
	Label* colNumlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	colNumlabel->setLabelText("Num of Colours:");
	this->cannonPropWindow->addControl(colNumlabel);

	left = controlLeft;

	// Number of colours component
	Rect rtxtNumColours(left, top, left + txtWidth, top + txtHeight);
	this->txtnumOfColoursCannon = new TextBox(rtxtNumColours);
	this->txtnumOfColoursCannon->setText("");
	this->txtnumOfColoursCannon->setTextLimit(3);
	this->txtnumOfColoursCannon->addChangeEvent(cannonPropCallBack);
	this->txtnumOfColoursCannon->setActiveColour(this->activeColour);
	this->txtnumOfColoursCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtnumOfColoursCannon);

	left = textLeft;
	top += vertSpace;

	// Speed bullets are fired from the cannon
	// -----------------------
	Label* speedlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	speedlabel->setLabelText("Speed:");
	this->cannonPropWindow->addControl(speedlabel);

	left = controlLeft;

	// Speed component
	Rect rtxtSpeed(left, top, left + txtWidth, top + txtHeight);
	this->txtspeedCannon = new TextBox(rtxtSpeed);
	this->txtspeedCannon->setText("");
	this->txtspeedCannon->setTextLimit(5);
	this->txtspeedCannon->addChangeEvent(cannonPropCallBack);
	this->txtspeedCannon->setActiveColour(this->activeColour);
	this->txtspeedCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtspeedCannon);

	left = textLeft;
	top += vertSpace;

	// The time between bullet reloads
	// -----------------------
	Label* refreshRatelabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	refreshRatelabel->setLabelText("Refresh Rate(ms):");
	this->cannonPropWindow->addControl(refreshRatelabel);

	left = controlLeft;

	// Refresh rate component
	Rect rtxtRefreshRate(left, top, left + txtWidth, top + txtHeight);
	this->txtrefreshRateCannon = new TextBox(rtxtRefreshRate);
	this->txtrefreshRateCannon->setText("");
	this->txtrefreshRateCannon->setTextLimit(4);
	this->txtrefreshRateCannon->addChangeEvent(cannonPropCallBack);
	this->txtrefreshRateCannon->setActiveColour(this->activeColour);
	this->txtrefreshRateCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtrefreshRateCannon);

	left = textLeft;
	top += vertSpace;

	// Number of rainbow bullets from the cannon
	// -----------------------
	Label* rainbowlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	rainbowlabel->setLabelText("SFX Rainbow:");
	this->cannonPropWindow->addControl(rainbowlabel);

	left = controlLeft;

	// Rainbow component
	Rect rtxtRainbow(left, top, left + txtWidth, top + txtHeight);
	this->txtbulletSFXRainbowCannon = new TextBox(rtxtRainbow);
	this->txtbulletSFXRainbowCannon->setText("");
	this->txtbulletSFXRainbowCannon->setTextLimit(3);
	this->txtbulletSFXRainbowCannon->addChangeEvent(cannonPropCallBack);
	this->txtbulletSFXRainbowCannon->setActiveColour(this->activeColour);
	this->txtbulletSFXRainbowCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtbulletSFXRainbowCannon);

	left = textLeft;
	top += vertSpace;

	// Number of speed bullets from the cannon
	// -----------------------
	Label* SFXSpeedlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	SFXSpeedlabel->setLabelText("SFX Speed:");
	this->cannonPropWindow->addControl(SFXSpeedlabel);

	left = controlLeft;

	// Speed component
	Rect rtxtSFXSpeed(left, top, left + txtWidth, top + txtHeight);
	this->txtbulletSFXSpeedCannon = new TextBox(rtxtSFXSpeed);
	this->txtbulletSFXSpeedCannon->setText("");
	this->txtbulletSFXSpeedCannon->setTextLimit(3);
	this->txtbulletSFXSpeedCannon->addChangeEvent(cannonPropCallBack);
	this->txtbulletSFXSpeedCannon->setActiveColour(this->activeColour);
	this->txtbulletSFXSpeedCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtbulletSFXSpeedCannon);

	left = textLeft;
	top += vertSpace;

	// Number of bomb bullets from the cannon
	// -----------------------
	Label* bomblabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	bomblabel->setLabelText("SFX Bomb:");
	this->cannonPropWindow->addControl(bomblabel);

	left = controlLeft;

	// Bomb component
	Rect rtxtBomb(left, top, left + txtWidth, top + txtHeight);
	this->txtbulletSFXBombCannon = new TextBox(rtxtBomb);
	this->txtbulletSFXBombCannon->setText("");
	this->txtbulletSFXBombCannon->setTextLimit(3);
	this->txtbulletSFXBombCannon->addChangeEvent(cannonPropCallBack);
	this->txtbulletSFXBombCannon->setActiveColour(this->activeColour);
	this->txtbulletSFXBombCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtbulletSFXBombCannon);
	
	left = textLeft;
	top += vertSpace;
	
	// Number of colour bombs bullets from the cannon
	// -----------------------
	Label* colBomblabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	colBomblabel->setLabelText("SFX Colour Bomb:");
	this->cannonPropWindow->addControl(colBomblabel);

	left = controlLeft;

	// Colour bomb component
	Rect rtxtColBomb(left, top, left + txtWidth, top + txtHeight);
	this->txtbulletSFXColBombCannon = new TextBox(rtxtColBomb);
	this->txtbulletSFXColBombCannon->setText("");
	this->txtbulletSFXColBombCannon->setTextLimit(3);
	this->txtbulletSFXColBombCannon->addChangeEvent(cannonPropCallBack);
	this->txtbulletSFXColBombCannon->setActiveColour(this->activeColour);
	this->txtbulletSFXColBombCannon->setInActiveColour(this->inActiveColour);
	this->cannonPropWindow->addControl(this->txtbulletSFXColBombCannon);

	LevelEditor::populateCannonPropWindow();

	Window::addControl(this->cannonPropWindow);
}

void LevelEditor::populateCannonPropWindow()
{
	char buffer[5];
	
	// Colour Num
	sprintf (buffer, "%d", this->cannonProp.numOfColours); 
	this->txtnumOfColoursCannon->setText(buffer);
	
	// Bullet Speed
	sprintf (buffer, "%.2f", this->cannonProp.speed); 
	this->txtspeedCannon->setText(buffer);
	
	// Refresh Rate
	sprintf (buffer, "%d", this->cannonProp.refreshRate); 
	this->txtrefreshRateCannon->setText(buffer);
	
	// Num of Rainbows bullets
	sprintf (buffer, "%d", this->cannonProp.bulletSFXRainbow); 
	this->txtbulletSFXRainbowCannon->setText(buffer);

	// Num of Speed bullets
	sprintf (buffer, "%d", this->cannonProp.bulletSFXSpeed); 
	this->txtbulletSFXSpeedCannon->setText(buffer);
	
	// Num of Rainbows bullets
	sprintf (buffer, "%d", this->cannonProp.bulletSFXBomb); 
	this->txtbulletSFXBombCannon->setText(buffer);
	
	// Num of Rainbows bullets
	sprintf (buffer, "%d", this->cannonProp.bulletSFXColBomb);
	this->txtbulletSFXColBombCannon->setText(buffer);
}

void LevelEditor::updateCannonProps()
{
	// Colour Num
	int colNum = atoi(this->txtnumOfColoursCannon->getText());
	if (colNum < 2)
		colNum = 2;
	else if (colNum > MAX_COLOUR)
		colNum = MAX_COLOUR;
	this->cannonProp.numOfColours = colNum;
	
	// Bullet Speed
	double bulSpd = atof(this->txtspeedCannon->getText());
	if (bulSpd < 0)
		bulSpd = 1.0;
	else if (bulSpd > 50)
		bulSpd = 50;
	this->cannonProp.speed = bulSpd;
	
	// Refresh Rate
	int refreshRate = atoi(this->txtrefreshRateCannon->getText());
	if (refreshRate < 0)
		refreshRate = 0;
	this->cannonProp.refreshRate = refreshRate;
	
	// Num of Rainbows bullets
	int rainbow = atoi(this->txtbulletSFXRainbowCannon->getText());
	if (rainbow < 0)
		rainbow = 0;
	this->cannonProp.bulletSFXRainbow = rainbow;

	// Num of Speed bullets
	int speed = atoi(this->txtbulletSFXSpeedCannon->getText());
	if (speed < 0)
		speed = 0;
	this->cannonProp.bulletSFXSpeed = speed;
	
	// Num of Rainbows bullets
	int bomb = atoi(this->txtbulletSFXBombCannon->getText());
	if (bomb < 0)
		bomb = 0;
	this->cannonProp.bulletSFXBomb = bomb;
	
	// Num of Rainbows bullets
	int colBomb = atoi(this->txtbulletSFXColBombCannon->getText());
	if (colBomb < 0)
		colBomb = 0;
	this->cannonProp.bulletSFXColBomb = colBomb;
	
}

//-------------------------------------------------------
// Train Controls
//-------------------------------------------------------
void LevelEditor::intialiseTrainPropWindow(SDL_Surface* screen)
{
	int mainWidth = 160;
	int mainHeight = 190;
	Point mainPos(screen->w - mainWidth - 1 , 0);
	
	this->trainPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	this->trainPropWindow->setModal(false);
	this->trainPropWindow->setBackgroundColour(this->propertyWinColour);
	this->trainPropWindow->setInnerBevel(true);
	this->trainPropWindow->setVisible(true);

	// Control spacing
	int left 	= 5;
	int top 	= 5;
	int txtWidth 	= 35;
	int txtHeight 	= 14;
	int hozSpace	= 38;
	int vertSpace	= 23;
	int controlLeft = 120;
	int textLeft	= 5;

	// Train property title
	Label* trainlabel = new Label(Point(left, top), Point(mainWidth - 2 * left, top + 10));
	trainlabel->setLabelText("TRAIN PROPERTIES");
	this->trainPropWindow->addControl(trainlabel);

	// Get all of the properties to use the same update event
	Callback0<LevelEditor> trainPropCallBack(*this, &LevelEditor::updateTrainProps);

	top += vertSpace;

	// Number of carriage in the train
	// -----------------------
	Label* carNumlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	carNumlabel->setLabelText("Carriage Num:");
	this->trainPropWindow->addControl(carNumlabel);

	left = controlLeft;

	// Carriage number component
	Rect rtxtNumCarriages(left, top, left + txtWidth, top + txtHeight);
	this->txtnumOfCarriagesTrain = new TextBox(rtxtNumCarriages);
	this->txtnumOfCarriagesTrain->setText("");
	this->txtnumOfCarriagesTrain->setTextLimit(3);
	this->txtnumOfCarriagesTrain->addChangeEvent(trainPropCallBack);
	this->txtnumOfCarriagesTrain->setActiveColour(this->activeColour);
	this->txtnumOfCarriagesTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtnumOfCarriagesTrain);

	left = textLeft;
	top += vertSpace;

	// Number of different colour carriages in the train
	// -----------------------
	Label* colNumlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	colNumlabel->setLabelText("Num of Colours:");
	this->trainPropWindow->addControl(colNumlabel);

	left = controlLeft;

	// Number of colours component
	Rect rtxtColourNum(left, top, left + txtWidth, top + txtHeight);
	this->txtnumOfColoursTrain = new TextBox(rtxtColourNum);
	this->txtnumOfColoursTrain->setText("");
	this->txtnumOfColoursTrain->setTextLimit(3);
	this->txtnumOfColoursTrain->addChangeEvent(trainPropCallBack);
	this->txtnumOfColoursTrain->setActiveColour(this->activeColour);
	this->txtnumOfColoursTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtnumOfColoursTrain);

	left = textLeft;
	top += vertSpace;

	// Speed of the train
	// -----------------------
	Label* speedlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	speedlabel->setLabelText("Speed:");
	this->trainPropWindow->addControl(speedlabel);

	left = controlLeft;

	// Train speed component
	Rect rtxtSpeed(left, top, left + txtWidth, top + txtHeight);
	this->txtspeedTrain = new TextBox(rtxtSpeed);
	this->txtspeedTrain->setText("");
	this->txtspeedTrain->setTextLimit(5);
	this->txtspeedTrain->addChangeEvent(trainPropCallBack);
	this->txtspeedTrain->setActiveColour(this->activeColour);
	this->txtspeedTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtspeedTrain);

	left = textLeft;
	top += vertSpace;

	// Colour of the track
	// -----------------------
	Label* collabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	collabel->setLabelText("Colour (R,G,B):");
	this->trainPropWindow->addControl(collabel);

	// Draw the colours boxes backwards so the first one is blue at the same 
	// position as all of the others and then move each box back 
	top += vertSpace;
	left = controlLeft;

	 // Have a different update event for the colours
	Callback0<LevelEditor> trainColourCallBack(*this, &LevelEditor::updateTrainColour);

	// Blue track colour
	Rect rtxtColourBlue(left, top, left + txtWidth, top + txtHeight);
	this->txtColourBlueTrain = new TextBox(rtxtColourBlue);
	this->txtColourBlueTrain->setText("");
	this->txtColourBlueTrain->setTextLimit(5);
	this->txtColourBlueTrain->addChangeEvent(trainColourCallBack);
	this->txtColourBlueTrain->setActiveColour(this->activeColour);
	this->txtColourBlueTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtColourBlueTrain);

	left -= hozSpace;

	// Green track colour
	Rect rtxtColourGreen(left, top, left + txtWidth, top + txtHeight);
	this->txtColourGreenTrain = new TextBox(rtxtColourGreen);
	this->txtColourGreenTrain->setText("");
	this->txtColourGreenTrain->setTextLimit(5);
	this->txtColourGreenTrain->addChangeEvent(trainColourCallBack);
	this->txtColourGreenTrain->setActiveColour(this->activeColour);
	this->txtColourGreenTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtColourGreenTrain);
 
	left -= hozSpace;
 
	// Red track colour
	Rect rtxtColourRed(left, top, left + txtWidth, top + txtHeight);
	this->txtColourRedTrain = new TextBox(rtxtColourRed);
	this->txtColourRedTrain->setText("");
	this->txtColourRedTrain->setTextLimit(5);
	this->txtColourRedTrain->addChangeEvent(trainColourCallBack);
	this->txtColourRedTrain->setActiveColour(this->activeColour);
	this->txtColourRedTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtColourRedTrain);

	left = textLeft;
	top += vertSpace;

	// Number of rainbow carriages in the train
	// -----------------------
	Label* rainbowlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	rainbowlabel->setLabelText("SFX Rainbow:");
	this->trainPropWindow->addControl(rainbowlabel);

	left = controlLeft;

	// Rainbow carriages
	Rect rtxtRainbow(left, top, left + txtWidth, top + txtHeight);
	this->txtcarriageRainbowTrain = new TextBox(rtxtRainbow);
	this->txtcarriageRainbowTrain->setText("");
	this->txtcarriageRainbowTrain->setTextLimit(3);
	this->txtcarriageRainbowTrain->addChangeEvent(trainPropCallBack);
	this->txtcarriageRainbowTrain->setActiveColour(this->activeColour);
	this->txtcarriageRainbowTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtcarriageRainbowTrain);

	left = textLeft;
	top += vertSpace;

	// Number of speed carriage in the train
	// -----------------------
	Label* SFXSpeedlabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	SFXSpeedlabel->setLabelText("SFX Speed:");
	this->trainPropWindow->addControl(SFXSpeedlabel);

	left = controlLeft;

	// Speed component
	Rect rtxtSFXSpeed(left, top, left + txtWidth, top + txtHeight);
	this->txtcarriageSpeedTrain = new TextBox(rtxtSFXSpeed);
	this->txtcarriageSpeedTrain->setText("");
	this->txtcarriageSpeedTrain->setTextLimit(3);
	this->txtcarriageSpeedTrain->addChangeEvent(trainPropCallBack);
	this->txtcarriageSpeedTrain->setActiveColour(this->activeColour);
	this->txtcarriageSpeedTrain->setInActiveColour(this->inActiveColour);
	this->trainPropWindow->addControl(this->txtcarriageSpeedTrain);

	Window::addControl(this->trainPropWindow);
}

void LevelEditor::populateTrainPropWindow()
{
	if (!this->currentTrain.Valid())
		return;
		
	char buffer[5];
	
	// Carriage Num
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.numOfCarriages); 		
	this->txtnumOfCarriagesTrain->setText(buffer);
	
	// Colour Num
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.numOfColours); 		
	this->txtnumOfColoursTrain->setText(buffer);
	
	// Train Speed
	sprintf (buffer, "%.2f", this->currentTrain.Item()->trainProperties.speed); 		
	this->txtspeedTrain->setText(buffer);
	
	// Train Colour Red
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.colR); 		
	this->txtColourRedTrain->setText(buffer);

	// Train Colour Green
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.colG); 		
	this->txtColourGreenTrain->setText(buffer);
	
	// Train Colour Blue
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.colB); 		
	this->txtColourBlueTrain->setText(buffer);		
	
	// Num of Rainbows carriages
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.carriageRainbow); 		
	this->txtcarriageRainbowTrain->setText(buffer);
	
	// Num of speed carriages;
	sprintf (buffer, "%d", (int)this->currentTrain.Item()->trainProperties.carriageSpeed); 		
	this->txtcarriageSpeedTrain->setText(buffer);
}

void LevelEditor::updateTrainProps()
{
	if (!this->currentTrain.Valid())
		return;
		
	// Carriage Num
	this->currentTrain.Item()->trainProperties.numOfCarriages = atoi(this->txtnumOfCarriagesTrain->getText());
	
	// Colour Num
	this->currentTrain.Item()->trainProperties.numOfColours = atoi(this->txtnumOfColoursTrain->getText());
	
	// Train Speed
	this->currentTrain.Item()->trainProperties.speed = atof(this->txtspeedTrain->getText());
	
	// Num of Rainbows carriages
	this->currentTrain.Item()->trainProperties.carriageRainbow = atoi(this->txtcarriageRainbowTrain->getText());
	
	// Num of speed carriages;
	this->currentTrain.Item()->trainProperties.carriageSpeed = atoi(this->txtcarriageSpeedTrain->getText());
	
}

void LevelEditor::updateTrainColour()
{
	if (!this->currentTrain.Valid())
		return;
	
	int r,g,b;
	// colours
	r = atoi(this->txtColourRedTrain->getText());
	g = atoi(this->txtColourGreenTrain->getText());
	b = atoi(this->txtColourBlueTrain->getText());
	
	// Check to make sure the items are in range
	if (r < 1)
		r = 1;
	else if (r > 255)
		r = 255;
	
	if (g < 1)
		g = 1;
	else if (g > 255)
		g = 255;
	
	if (b < 1)
		b = 1;
	else if (b > 255)
		b = 255;
		
	this->currentTrain.Item()->trainProperties.colR = r;
	this->currentTrain.Item()->trainProperties.colG = g;
	this->currentTrain.Item()->trainProperties.colB = b;
	
	this->currentTrain.Item()->trainProperties.colour = SDL_MapRGB(SDL_GetVideoSurface()->format, 
			this->currentTrain.Item()->trainProperties.colR, 
			this->currentTrain.Item()->trainProperties.colG, 
			this->currentTrain.Item()->trainProperties.colB);
	
	// Go through the current list of items and update their colour except
	// for the currently selected item.
	DListIterator<TrackSection*> iter = this->currentTrain.Item()->tracks.GetIterator();
	iter.Start();
	while(iter.Valid())
	{
		if (iter.Item() != this->currentTrackSection.Item())
			iter.Item()->setColour(this->currentTrain.Item()->trainProperties.colour);
		iter.Forth();
	}
}
	
	
//-------------------------------------------------------
// Track Controls
//-------------------------------------------------------
// Track Load
void LevelEditor::intialiseTrackPropWindow(SDL_Surface* screen)
{
	int mainWidth = 500;
	int mainHeight = 38;
	int mainPropWidth = 110; // This is the size of the main property window
	Point mainPos(mainPropWidth + 5 , screen->h - mainHeight);
	
	this->trackPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	
	this->trackPropWindow->setBackgroundColour(this->propertyWinColour);
	this->trackPropWindow->setModal(false);
	this->trackPropWindow->setInnerBevel(true);
	
	// Add each of the buttons
	int left 	= 5;
	int top 	= 5;
	int width 	= 28;
	int height 	= 28;
	int hozSpace = 35;

	// Line
	Rect rbLine(left, top, left + width, top + height);
	Callback0<LevelEditor> lineCallback(*this, &LevelEditor::addLine);
	btnAddLine = new Button(lineCallback, "", rbLine);
	btnAddLine->loadBackgroundImage(LE_IMG_LOCATION "line.png");
	btnAddLine->loadActiveBackgroundImage(LE_IMG_LOCATION "line-a.png");
	this->trackPropWindow->addControl(btnAddLine);

	left += hozSpace;

	// Arc
	Rect rbArc(left, top, left + width, top + height);
	Callback0<LevelEditor> arcCallback(*this, &LevelEditor::addArc);
	btnAddArc = new Button(arcCallback, "", rbArc);
	btnAddArc->loadBackgroundImage(LE_IMG_LOCATION "arc.png");
	btnAddArc->loadActiveBackgroundImage(LE_IMG_LOCATION "arc-a.png");
	this->trackPropWindow->addControl(btnAddArc);

	left += hozSpace;

	// Sprial
	Rect rbSpiral(left, top, left + width, top + height);
	Callback0<LevelEditor> spiralCallback(*this, &LevelEditor::addSpiral);
	btnAddSpiral = new Button(spiralCallback, "", rbSpiral);
	btnAddSpiral->loadBackgroundImage(LE_IMG_LOCATION "spiral.png");
	btnAddSpiral->loadActiveBackgroundImage(LE_IMG_LOCATION "spiral-a.png");
	this->trackPropWindow->addControl(btnAddSpiral);

	left += hozSpace + 10;

	// Remove Track section
	Rect rbRemoveTrackSect(left, top, left + width, top + height);
	Callback0<LevelEditor> removeTrackSectCallback(*this, &LevelEditor::removeTrackSection);
	Button* bRemoveTrackSect = new Button(removeTrackSectCallback, "", rbRemoveTrackSect);
	bRemoveTrackSect->loadBackgroundImage(LE_IMG_LOCATION "removetracksection.png");
	this->trackPropWindow->addControl(bRemoveTrackSect);

	left += hozSpace + 10;

	// Previous Track section
	Rect rbPreTrackSect(left, top, left + width, top + height);
	Callback0<LevelEditor> preTrackSectCallback(*this, &LevelEditor::previousTrackSection);
	Button* bPreTrackSect = new Button(preTrackSectCallback, "", rbPreTrackSect);
	bPreTrackSect->loadBackgroundImage(LE_IMG_LOCATION "previoustracksection.png");
	this->trackPropWindow->addControl(bPreTrackSect);

	left += hozSpace;

	// Next Track section
	Rect rbNextTrackSect(left, top, left + width, top + height);
	Callback0<LevelEditor> nextTrackSectCallback(*this, &LevelEditor::nextTrackSection);
	Button* bNextTrackSect = new Button(nextTrackSectCallback, "", rbNextTrackSect);
	bNextTrackSect->loadBackgroundImage(LE_IMG_LOCATION "nexttracksection.png");
	this->trackPropWindow->addControl(bNextTrackSect);

	left += hozSpace + 10;

	// New Track
	Rect rbNewTrack(left, top, left + width, top + height);
	Callback0<LevelEditor> newTrackCallback(*this, &LevelEditor::newTrack);
	Button* bNewTrack = new Button(newTrackCallback, "", rbNewTrack);
	bNewTrack->loadBackgroundImage(LE_IMG_LOCATION "newtrack.png");
	this->trackPropWindow->addControl(bNewTrack);

	left += hozSpace;

	// Remove Track
	Rect rbRemoveTrack(left, top, left + width, top + height);
	Callback0<LevelEditor> removeTrackCallback(*this, &LevelEditor::removeTrack);
	Button* bRemoveTrack = new Button(removeTrackCallback, "", rbRemoveTrack);
	bRemoveTrack->loadBackgroundImage(LE_IMG_LOCATION "removetrack.png");
	this->trackPropWindow->addControl(bRemoveTrack);

	left += hozSpace;

	// Previous Track
	Rect rbPreTrack(left, top, left + width, top + height);
	Callback0<LevelEditor> preTrackCallback(*this, &LevelEditor::previousTrack);
	Button* bPreTrack = new Button(preTrackCallback, "", rbPreTrack);
	bPreTrack->loadBackgroundImage(LE_IMG_LOCATION "previoustrack.png");
	this->trackPropWindow->addControl(bPreTrack);

	left += hozSpace;

	// Next Track
	Rect rbNextTrack(left, top, left + width, top + height);
	Callback0<LevelEditor> nextTrackCallback(*this, &LevelEditor::nextTrack);
	Button* bNextTrack = new Button(nextTrackCallback, "", rbNextTrack);
	bNextTrack->loadBackgroundImage(LE_IMG_LOCATION "nexttrack.png");
	this->trackPropWindow->addControl(bNextTrack);

	left += hozSpace + 10;

	// Toggle Train Props
	Rect rbTrainProps(left, top, left + width, top + height);
	Callback0<LevelEditor> trainPropCallback(*this, &LevelEditor::toggleTrainProps);
	Button* bTrainProps = new Button(trainPropCallback, "", rbTrainProps);
	bTrainProps->loadBackgroundImage(LE_IMG_LOCATION "trainprops.png");
	this->trackPropWindow->addControl(bTrainProps);

	left += hozSpace;

	// Toggle Cannon Props
	Rect rbCannonProps(left, top, left + width, top + height);
	Callback0<LevelEditor> cannonPropCallback(*this, &LevelEditor::toggleCannonProps);
	Button* bCannonProps = new Button(cannonPropCallback, "", rbCannonProps);
	bCannonProps->loadBackgroundImage(LE_IMG_LOCATION "cannonprops.png");
	this->trackPropWindow->addControl(bCannonProps);

	left += hozSpace;
	
	// Toggle Cannon Props
	Rect rbGridProps(left, top, left + width, top + height);
	Callback0<LevelEditor> gridPropCallback(*this, &LevelEditor::toggleGridProps);
	Button* bGridProps = new Button(gridPropCallback, "", rbGridProps);
	bGridProps->loadBackgroundImage(LE_IMG_LOCATION "gridprops.png");
	this->trackPropWindow->addControl(bGridProps);

	Window::addControl(this->trackPropWindow);
}

// Event Handlers 
void LevelEditor::addLine()
{
	if (this->state == LES_ADD_LINE)
	{
		if (!this->stickyTrackButtons)
		{
			this->stickyTrackButtons = true;
			return;
		}
		else
		{	// Toggle the sticky keys
			LevelEditor::resetMainButtons();
			return;
		}
	}	
	LevelEditor::resetMainButtons();
	btnAddLine->setActive(true);
	this->state = LES_ADD_LINE;
	this->clickPoints.RemoveAll();
}

void LevelEditor::addArc()
{
	if (this->state == LES_ADD_ARC)
	{
		if (!this->stickyTrackButtons)
		{
			this->stickyTrackButtons = true;
			return;
		}
		else
		{
			// Toggle the sticky keys
			LevelEditor::resetMainButtons();
			return;
		}
	}
	LevelEditor::resetMainButtons();
	btnAddArc->setActive(true);
	this->state = LES_ADD_ARC;
	this->clickPoints.RemoveAll();
}

void LevelEditor::addSpiral()
{
	if (this->state == LES_ADD_SPIRAL)
	{
		if (!this->stickyTrackButtons)
		{
			this->stickyTrackButtons = true;
			return;
		}
		else
		{
			// Toggle the sticky keys
			LevelEditor::resetMainButtons();
			return;
		}
	}
	LevelEditor::resetMainButtons();
	btnAddSpiral->setActive(true);
	this->state = LES_ADD_SPIRAL;
	this->clickPoints.RemoveAll();
}

void LevelEditor::removeTrackSection()
{
	// Reset the current track section colour just incase it 
	// isn't pointing to the tail of the list
	LevelEditor::resetTrackSectionColour();
	
	// Only allow items to be deleted from the end of the track
	this->currentTrain.Item()->tracks.RemoveTail();

	// Always reset the track to the tail.
	this->currentTrackSection.End();

	LevelEditor::highlightTrackSection();
}

void LevelEditor::previousTrackSection()
{
	LevelEditor::resetTrackSectionColour();
	
	// move to the previous track section	
	this->currentTrackSection.Back();
	
	// If we have lost the plot then reset it back to the start of the list
	if (!this->currentTrackSection.Valid())
		this->currentTrackSection.Start();
		
	LevelEditor::highlightTrackSection();
}

void LevelEditor::nextTrackSection()
{
	LevelEditor::resetTrackSectionColour();
	
	// move to the next track section
	this->currentTrackSection.Forth();
	
	// If we have lost the plot then reset it to the end of the list
	if (!this->currentTrackSection.Valid())
		this->currentTrackSection.End();

	LevelEditor::highlightTrackSection();

}

void LevelEditor::newTrack()
{
	// Make sure at least one track exists before we try to reset the colour
	if (this->trains.Size() > 0)
		LevelEditor::resetTrackSectionColour();
	
	// Create a new container with a random colour for the track.
	LETrain* leTrain = new LETrain();
	/*
	Uint8 r = random(6) * 0x33;
	Uint8 g = random(6) * 0x33;
	Uint8 b = random(6) * 0x33;
	leTrain->trainProperties.colour = SDL_MapRGB(Window::rootScreen->format, r, g, b);
	*/
	this->trains.Append(leTrain);
	this->currentTrain.End();
	if (this->currentTrain.Valid())
	{
		// Reset the track section list iterator
		this->currentTrackSection = this->currentTrain.Item()->tracks.GetIterator();
		this->currentTrackSection.Start();
		LevelEditor::highlightTrackSection();
		LevelEditor::populateTrainPropWindow();
	}
}

void LevelEditor::removeTrack()
{
	if (!this->currentTrain.Valid())
		return;
		
	this->trains.Remove(this->currentTrain);
	
	if (this->trains.Size() == 0)
	{
		LevelEditor::newTrack();
		return;
	}
	if (!this->currentTrain.Valid())
		this->currentTrain.Start();
	
	this->currentTrackSection = this->currentTrain.Item()->tracks.GetIterator();
	this->currentTrackSection.Start();
	LevelEditor::highlightTrackSection();
	LevelEditor::populateTrainPropWindow();
}

void LevelEditor::previousTrack()
{
	LevelEditor::resetTrackSectionColour();
	
	this->currentTrain.Back();
		
	// If gone off the end of the list then reset to the start
	if (!this->currentTrain.Valid())
		this->currentTrain.Start();

	LevelEditor::populateTrainPropWindow();
	
	// Reset the track section list
	this->currentTrackSection = this->currentTrain.Item()->tracks.GetIterator();
	this->currentTrackSection.Start();
	LevelEditor::highlightTrackSection();
	LevelEditor::populateTrainPropWindow();
}

void LevelEditor::nextTrack()
{
	LevelEditor::resetTrackSectionColour();
	
	this->currentTrain.Forth();
	
	if (!this->currentTrain.Valid())
		this->currentTrain.End();

	LevelEditor::populateTrainPropWindow();
	
	this->currentTrackSection = this->currentTrain.Item()->tracks.GetIterator();
	this->currentTrackSection.Start();
	LevelEditor::highlightTrackSection();
	LevelEditor::populateTrainPropWindow();
}

void LevelEditor::toggleTrainProps()
{
	this->trainPropWindow->setVisible(!this->trainPropWindow->getVisible());
}

void LevelEditor::toggleCannonProps()
{
	this->cannonPropWindow->setVisible(!this->cannonPropWindow->getVisible());
}

void LevelEditor::toggleGridProps()
{
	this->gridPropWindow->setVisible(!this->gridPropWindow->getVisible());	
}

void LevelEditor::resetTrackSectionColour()
{
	// Reset the colour of the current track section
	if (this->currentTrackSection.Valid())
		this->currentTrackSection.Item()->setColour(this->currentTrain.Item()->trainProperties.colour);	
}

void LevelEditor::highlightTrackSection()
{
	
	// Hide all of the property windows
	this->linePropWindow->setVisible(false);
	this->arcPropWindow->setVisible(false);
	this->spiralPropWindow->setVisible(false);

	// Set the colour of the new track section to yellow to show it is highlighted
	if (this->currentTrackSection.Valid())
	{
		this->currentTrackSection.Item()->setColour(SDL_MapRGB(Window::rootScreen->format, 0xcc, 0xcc, 0x0));	

		// Show the correct window
		switch(this->currentTrackSection.Item()->getType())
		{
			case TT_LINE:
				LevelEditor::populateLinePropWindow();
				this->linePropWindow->setVisible(true);
				break;
			case TT_ARC:
				LevelEditor::populateArcPropWindow();
				this->arcPropWindow->setVisible(true);
				break;
			case TT_SPIRAL:
				LevelEditor::populateSpiralPropWindow();
				this->spiralPropWindow->setVisible(true);
				break;
		}
	}
}

//-------------------------------------------------------
// Main Controls
//-------------------------------------------------------


// Main Load
void LevelEditor::intialiseMainPropWindow(SDL_Surface* screen)
{
	int mainWidth = 110;
	int mainHeight = 38;
	Point mainPos(0,screen->h - mainHeight);

	this->mainPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));

	this->mainPropWindow->setBackgroundColour(this->propertyWinColour);
	this->mainPropWindow->setInnerBevel(true);
	this->mainPropWindow->setModal(false);
	
	// Add each of the buttons
	int left 	= 5;
	int top 	= 5;
	int width 	= 28;
	int height 	= 28;
	int hozSpace 	= 35;

	char buffer[255];
	getcwd(buffer, 255);

	// Load
	Rect rbLoad(left, top, left + width, top + height);
	Callback0<LevelEditor> loadCallback(*this, &LevelEditor::load);
	Button* bLoad = new Button(loadCallback, "", rbLoad);
	bLoad->loadBackgroundImage(LE_IMG_LOCATION "load.png");
	this->mainPropWindow->addControl(bLoad);

	left += hozSpace;

	// Save
	Rect rbSave(left, top, left + width, top + height);
	Callback0<LevelEditor> saveCallback(*this, &LevelEditor::save);
	Button* bSave = new Button(saveCallback, "", rbSave);
	bSave->loadBackgroundImage(LE_IMG_LOCATION "save.png");
	this->mainPropWindow->addControl(bSave);

	left += hozSpace;

	// Quit
	Rect rbQuit(left, top, left + width, top + height);
	Callback0<LevelEditor> quitCallback(*this, &LevelEditor::quit);
	Button* bQuit = new Button(quitCallback, "", rbQuit);
	bQuit->loadBackgroundImage(LE_IMG_LOCATION "quit.png");
	this->mainPropWindow->addControl(bQuit);

	Window::addControl(this->mainPropWindow);
}


void LevelEditor::load()
{
	Callback1<const char*, LevelEditor> loadLevel(*this, &LevelEditor::loadLevel);
	WindowManager::Instance()->push(new FileLoadSaveBox(SDL_GetVideoSurface(), loadLevel, LST_LOAD, NULL));
}

void LevelEditor::loadLevel(const char* loadFilename)
{
	char buffer[512];
	sprintf(buffer, "Load Level %s", loadFilename);
	this->testlabel->setLabelText(buffer);
	
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "LevelEditor::loadLevel");
	
	xmlDocPtr doc;
	xmlNodePtr root;
	
	// Clean up the current track list ready for the load
	this->trains.DeleteAndRemove();
	
	// Load the new document and make sure that it exists
	doc = loadXMLDocument(loadFilename);
	if (doc == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to load file %s", loadFilename)	;
		sprintf(buffer, "Failed to load %s", loadFilename);
		this->testlabel->setLabelText(buffer);
		return;
	}
	
	// Check the root node is what we expect
	if (!checkRootNode(doc, "level"))
	{
		xmlFreeDoc(doc);
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to load file %s", loadFilename)	;
		sprintf(buffer, "Failed to load %s", loadFilename);
		this->testlabel->setLabelText(buffer);
		return;
		//Log::Instance()->die(1, SV_ERROR, "Level load failed loading file %s [root node not level]", filename);
	}

	root = xmlDocGetRootElement(doc);
	if (root == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Level load failed loading file %s [Empty Document]", filename);
		xmlFreeDoc(doc);
		return;
	}

	// Load up the cannon details.
	// This only supports one cannon at the moment
	// Load in the tracks
	xmlXPathObjectPtr xpathObj = searchDocXpath(doc, root, "//cannon");
	
	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
	{
		LevelEditor::loadCannon(doc, xpathObj->nodesetval->nodeTab[0]);
	}
	else
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to find any cannons defaulting");
		this->cannonProp.reset();
	}

	xmlXPathFreeObject(xpathObj);

	// Load in the tracks
	xpathObj = searchDocXpath(doc, root, "//train");

	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
	{
		for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
		{
			LETrain* newTrain = new LETrain();
			LevelEditor::loadTrain(doc, xpathObj->nodesetval->nodeTab[i], newTrain);
			this->trains.Append(newTrain);
		}

		// Initialise the track and tractsection pointers
		this->currentTrain.Start();
		this->currentTrackSection = this->currentTrain.Item()->tracks.GetIterator();
		this->currentTrackSection.Start();
		LevelEditor::highlightTrackSection();
		LevelEditor::populateTrainPropWindow();
	}
	else
	{
		// Raise an error if we have a problem
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to load file %s", loadFilename)	;
		sprintf(buffer, "Failed to load %s", loadFilename);
		this->testlabel->setLabelText(buffer);
		return;	
	}
	
	xmlXPathFreeObject(xpathObj);
	
	// If there weren't any tracks loaded then add a new one
	if (this->trains.Size() == 0)
	{
		LevelEditor::newTrack();
	}
	
	// Keep a record of the file we just loaded.
	this->filename = strdup(loadFilename);
	
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "LevelEditor::end loadLevel");
	
}

void LevelEditor::loadCannon(xmlDocPtr doc, xmlNodePtr cur)
{
	
	//<cannon type="rotation" pos="400,575" bulletreloadtime="1000" bulletspeed="8">
	//	<bullets random="1" colour-num="2"/>
	//</cannon>
	
	// Default all of the properties
	this->cannonProp.reset();
	
	// Make sure this is a cannon node
	if (strcmp((const char*)cur->name, "cannon"))
		Log::Instance()->die(1,SV_ERROR,"LevelEditor: node trying to load is not cannon but %s\n", (const char*)cur->name);
	
	// Find the position of the cannon - don't worry with the position yet
/*	char* posText = (char*)xmlGetProp(cur, (const xmlChar*)"pos");
	if (posText != NULL or !strcmp(posText, ""))
		this->position.set(posText);
	else
		Log::Instance()->die(1,SV_ERROR,"LevelEditor: position not found\n");
	*/
	
	// Find the bullet speed px/frame of the cannon
	char* speedText = (char*)xmlGetProp(cur, (const xmlChar*)"bulletspeed");
	if (speedText != NULL && strcmp(speedText, "") != 0)
		this->cannonProp.speed = atof(speedText);
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"LevelEditor: bulletspeed found but not correct.");	
	
	// Find the bullet rate of the cannon firing in ms between reloads
	char* reloadText = (char*)xmlGetProp(cur, (const xmlChar*)"bulletreloadtime");
	if (reloadText != NULL && strcmp(reloadText, "") != 0)
		this->cannonProp.refreshRate = atoi(reloadText);
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"LevelEditor: bulletrate found but not correct defaulting");	

	// Bullet information
	xmlNodePtr bulletsNode = NULL;
	
	// Load in the tracks
	xmlXPathObjectPtr xpathObj = searchDocXpath(doc, cur, "bullets");
	
	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
		bulletsNode = xpathObj->nodesetval->nodeTab[0];
	else
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to load file");
		return;
	}
	xmlXPathFreeObject(xpathObj);
	
	
	// Find the number of colours to use for bulletes
	char* colNumText = (char*)xmlGetProp(bulletsNode, (const xmlChar*)"colour-num");
	if (colNumText != NULL && strcmp(colNumText, "") != 0)
		this->cannonProp.numOfColours = atoi(colNumText);
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"LevelEditor: colournum found but not correct defaulting");	

	// Load in the sfx bullet
	xpathObj = searchDocXpath(doc, bulletsNode, "bullet[@special='true']");
	
	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
	{
		for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
		{
			int num = 0;
			char* typeText = (char*)xmlGetProp(xpathObj->nodesetval->nodeTab[i], (const xmlChar*)"type");
			char* numText = (char*)xmlGetProp(xpathObj->nodesetval->nodeTab[i], (const xmlChar*)"number");
			if (numText != NULL or !strcmp(numText, ""))
				num = atoi(numText);
			
			if (!strcmp(typeText, "SFX_RAINBOW"))
				this->cannonProp.bulletSFXRainbow = num;
			else if (!strcmp(typeText, "SFX_SPEED"))
				this->cannonProp.bulletSFXSpeed = num;
			else if (!strcmp(typeText, "SFX_BOMB"))
				this->cannonProp.bulletSFXBomb = num;
			else if (!strcmp(typeText, "SFX_COLOUR_BOMB"))
				this->cannonProp.bulletSFXColBomb = num;
		}
	}

	xmlXPathFreeObject(xpathObj);
	
	LevelEditor::populateCannonPropWindow();

}

void LevelEditor::loadTrain(xmlDocPtr doc, xmlNodePtr cur, LETrain* train)
{
	/*
	 * <train speed="1.5">
			<track colour="#12ff32">
			  <line startpos="147,84" endpos="445,176"/>
			  <line startpos="445,176" endpos="174,268"/>
			  <line startpos="174,268" endpos="438,383"/>
			  <line startpos="438,383" endpos="703,275"/>
			  <line startpos="703,275" endpos="697,84"/>
			  <line startpos="697,84" endpos="194,35"/>
			</track>
			<carriages random="1" colour-num="3" carriage-num="15"/>
				<carriage type="SFX_RAINBOW" special="true" number="3" />
			</carriages>
	</train>
	*/

	// Load a track
	xmlXPathObjectPtr xpathObj;
	TrackSection* trackSect;
	xmlNodePtr curTrack;
	
	// The current node should be a train
	// Load speed
	char* speedText = (char*)xmlGetProp(cur, (const xmlChar*)"speed");
	if (speedText != NULL && strcmp(speedText, "") != 0)
		train->trainProperties.speed = atof(speedText);
	
	// Load in the carriage details
	xmlNodePtr trackNode = NULL;
	xpathObj = searchDocXpath(doc, cur, "track");
	
	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
		trackNode = xpathObj->nodesetval->nodeTab[0];
	else
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to find track");
		return;	
	}
	xmlXPathFreeObject(xpathObj);
	
	// Find the track colour
	char* colourText = (char*)xmlGetProp(trackNode, (const xmlChar*)"colour");
	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "Track colour %s", colourText);
	if (colourText != NULL && strlen(colourText) == 7)
	{
		Log::Instance()->log(SV_DEBUG, SV_DEBUG, "changing track colour");
		char buffer[5] = "0x00";
		buffer[2] = colourText[1];
		buffer[3] = colourText[2];
		train->trainProperties.colR = (Uint8)strtol (buffer, NULL, 16);
		buffer[2] = colourText[3];
		buffer[3] = colourText[4];
		train->trainProperties.colG = (Uint8)strtol (buffer, NULL, 16);
		buffer[2] = colourText[5];
		buffer[3] = colourText[6];
		train->trainProperties.colB = (Uint8)strtol (buffer, NULL, 16);
		
		train->trainProperties.colour = SDL_MapRGB(SDL_GetVideoSurface()->format, train->trainProperties.colR, train->trainProperties.colG, train->trainProperties.colB);
	}
	
	// Load in the track details
	xpathObj = searchDocXpath(doc, trackNode, "*");
	if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr == 0)
		Log::Instance()->die(1,SV_ERROR,"Track: Need at least one track section for a track\n");

	for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
	{
		if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
			continue;

		trackSect = NULL;
		curTrack = xpathObj->nodesetval->nodeTab[i];
		if (!strcmp((const char*)curTrack->name, "line"))
			trackSect = new TrackLine();
		else if (!strcmp((const char*)curTrack->name, "arc"))
			trackSect = new TrackArc();
		else if	(!strcmp((const char*)curTrack->name, "spiral"))
			trackSect = new TrackSpiral();

		if (trackSect != NULL)
		{
			trackSect->load(doc, curTrack);
			trackSect->setColour(train->trainProperties.colour);
			train->tracks.Append(trackSect);
		}
	}

	// Load in the carriage details
	xmlNodePtr carraigesNode = NULL;
	xpathObj = searchDocXpath(doc, cur, "carriages");

	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
	carraigesNode = xpathObj->nodesetval->nodeTab[0];
	else
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Failed to find carriages");
		return;	
	}
	xmlXPathFreeObject(xpathObj);

	// colour num
	char* colNumText = (char*)xmlGetProp(carraigesNode, (const xmlChar*)"colour-num");
	if (colNumText != NULL && strcmp(colNumText, "") != 0)
		train->trainProperties.numOfColours = atoi(colNumText);
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"LevelEditor: colournum found but not correct defaulting");	

	// carriage num
	char* carriageNumText = (char*)xmlGetProp(carraigesNode, (const xmlChar*)"carriage-num");
	if (carriageNumText != NULL && strcmp(carriageNumText, "") != 0)
		train->trainProperties.numOfCarriages = atoi(carriageNumText);
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"LevelEditor: carriage-num found but not correct defaulting");	

	// Load in the sfx carraiges
	xpathObj = searchDocXpath(doc, carraigesNode, "carriage[@special='true']");

	if (xpathObj != NULL && xpathObj->nodesetval != NULL && xpathObj->nodesetval->nodeNr > 0)
	{
		for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
		{
			int num = 0;
			char* typeText = (char*)xmlGetProp(xpathObj->nodesetval->nodeTab[i], (const xmlChar*)"type");
			char* numText = (char*)xmlGetProp(xpathObj->nodesetval->nodeTab[i], (const xmlChar*)"number");
			if (numText != NULL or !strcmp(numText, ""))
				num = atoi(numText);
			
			if (!strcmp(typeText, "SFX_RAINBOW"))
				train->trainProperties.carriageRainbow = num;
			else if (!strcmp(typeText, "SFX_SPEED"))
				train->trainProperties.carriageSpeed = num;
		}
	}

	xmlXPathFreeObject(xpathObj);

}

void LevelEditor::save()
{
	Callback1<const char*, LevelEditor> loadLevel(*this, &LevelEditor::saveLevel);
	WindowManager::Instance()->push(new FileLoadSaveBox(SDL_GetVideoSurface(), loadLevel, LST_SAVE, this->filename));
}

void LevelEditor::saveLevel(const char* saveFilename)
{
	char buffer[512];
	sprintf(buffer, "Save Level to (%s)", saveFilename);
	this->testlabel->setLabelText(buffer);
	
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "LevelEditor::saveLevel");	
	
	xmlDocPtr doc = NULL;
	xmlNodePtr rootNode = NULL;
	xmlNodePtr trainstatNode = NULL;

	LIBXML_TEST_VERSION;

	if (fileExist(saveFilename))
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "The file %s already exists we are overwriting OK", saveFilename);
		if (remove(saveFilename) != 0)
			Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Problem deleting file %s", saveFilename);
	}

	// Creates a new document, a node and set it as a root node
	doc = xmlNewDoc(BAD_CAST "1.0");
	rootNode = xmlNewNode(NULL, BAD_CAST "level");
	xmlDocSetRootElement(doc, rootNode);

	// Cannon
	LevelEditor::saveCannon(doc, rootNode);

	// Trainstations    
	trainstatNode = xmlNewChild(rootNode, NULL, BAD_CAST "trainstations", NULL);
	if (!trainstatNode)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Problem saving trackstation[Failed to create node]");
		this->testlabel->setLabelText("Problem saving level");
		// free the document
		xmlFreeDoc(doc);
		return;
	}
	// Save the list of tracks
	DListIterator< LETrain* > tIter = this->trains.GetIterator();
	tIter.Start();
	while (tIter.Valid())
	{
		LevelEditor::saveTrain(doc, trainstatNode, *(tIter.Item()));
		tIter.Forth();
	}

	// Save as utf-8 and indented
	if (xmlSaveFormatFileEnc(saveFilename,doc, "UTF-8", 1) == -1)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Problem saving level [Failed to save file %s]", saveFilename);
		this->testlabel->setLabelText("Problem saving level");
		// free the document
		xmlFreeDoc(doc);
		return;
	}

	// free the document
	xmlFreeDoc(doc);

	this->filename = strdup(saveFilename);

	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "LevelEditor::end saveLevel");
}

void LevelEditor::saveCannon(xmlDocPtr doc, xmlNodePtr cur)
{
	// Save the cannon details out with the following
	/*
		<cannons>
			<cannon type="rotation" pos="400,575" bulletreloadtime="500" bulletspeed="12">
				<bullets random="1" colour-num="3">
					<bullet type="SFX_SPEED" special="true" number="10"/>
				</bullets>
			</cannon>
		</cannons>
	*/
	
	char buffer[16];
	
	// Cannons
	xmlNodePtr cannonsNode = xmlNewChild(cur, NULL, BAD_CAST "cannons", NULL);
	if (!cannonsNode)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving cannons[Failed to create node]");

	// Cannon
	xmlNodePtr cannonNode = xmlNewChild(cannonsNode, NULL, BAD_CAST "cannon", NULL);
	if (!cannonNode)
		Log::Instance()->die(1, SV_ERROR, "Problem saving cannon[Failed to create node]");

	// Rotation Type - default this to rotation because we don't have any other sort
	xmlNewProp(cannonNode, BAD_CAST "type", BAD_CAST "rotation");
	
	// Pos - hard encode this because we can't change it at the moment
	xmlNewProp(cannonNode, BAD_CAST "pos", BAD_CAST "400,575");
	
	// Reload Time
	sprintf (buffer, "%d", this->cannonProp.refreshRate); 		
	xmlNewProp(cannonNode, BAD_CAST "bulletreloadtime", BAD_CAST buffer);
	
	// Bullet Speed
	sprintf (buffer, "%.2f", this->cannonProp.speed); 		
	xmlNewProp(cannonNode, BAD_CAST "bulletspeed", BAD_CAST buffer);
	
	// Bullets
	xmlNodePtr bulletsNode = xmlNewChild(cannonNode, NULL, BAD_CAST "bullets", NULL);
	if (!bulletsNode)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving bullets[Failed to create node]");
	
	// random - hand encode because that is all we can cope with
	xmlNewProp(bulletsNode, BAD_CAST "random", BAD_CAST "1");
	
	// Bullet colour num
	sprintf (buffer, "%d", this->cannonProp.numOfColours); 		
	xmlNewProp(bulletsNode, BAD_CAST "colour-num", BAD_CAST buffer);
	
	// Rainbow
	if (this->cannonProp.bulletSFXRainbow > 0)
		LevelEditor::saveSFXBubble(doc, bulletsNode, "bullet", "SFX_RAINBOW", true, this->cannonProp.bulletSFXRainbow);
	
	// Speed
	if (this->cannonProp.bulletSFXSpeed > 0)
		LevelEditor::saveSFXBubble(doc, bulletsNode, "bullet", "SFX_SPEED", true, this->cannonProp.bulletSFXSpeed);
	
	// Bomb
	if (this->cannonProp.bulletSFXBomb > 0)
		LevelEditor::saveSFXBubble(doc, bulletsNode, "bullet", "SFX_BOMB", true, this->cannonProp.bulletSFXBomb);

	// Colour Bomb
	if (this->cannonProp.bulletSFXColBomb > 0)
		LevelEditor::saveSFXBubble(doc, bulletsNode, "bullet", "SFX_COLOUR_BOMB", true, this->cannonProp.bulletSFXColBomb);
}

void LevelEditor::saveSFXBubble(xmlDocPtr doc, xmlNodePtr cur, const char* elementName, const char* type, bool special, int number)
{
	/*
		<bullet type="SFX_SPEED" special="true" number="10"/>
		or
		<carriage type="SFX_SPEED" special="true" number="10"/>
	*/
	
	// Bullets
	xmlNodePtr bulletNode = xmlNewChild(cur, NULL, BAD_CAST elementName, NULL);
	if (!bulletNode)
		Log::Instance()->die(1, SV_ERROR, "Problem saving %s[Failed to create node]", elementName);
	
	// type
	xmlNewProp(bulletNode, BAD_CAST "type", BAD_CAST type);
	
	// special type
	if (special)
		xmlNewProp(bulletNode, BAD_CAST "special", BAD_CAST "true");
	
	// num
	char buffer[6];
	sprintf (buffer, "%d", number);
	xmlNewProp(bulletNode, BAD_CAST "number", BAD_CAST buffer);
}

void LevelEditor::saveTrain(xmlDocPtr doc, xmlNodePtr cur, LETrain& train)
{
	/*
	 * <train speed="1.5">
			<track colour="#12ff32">
			  <line startpos="147,84" endpos="445,176"/>
			  <line startpos="445,176" endpos="174,268"/>
			  <line startpos="174,268" endpos="438,383"/>
			  <line startpos="438,383" endpos="703,275"/>
			  <line startpos="703,275" endpos="697,84"/>
			  <line startpos="697,84" endpos="194,35"/>
			</track>
			<carriages random="1" colour-num="3" carriage-num="15"/>
		</train>
	*/

	char buffer[32];
	
	// Train
	xmlNodePtr trainNode = xmlNewChild(cur, NULL, BAD_CAST "train", NULL);
	if (!trainNode)
		Log::Instance()->die(1, SV_ERROR, "Problem saving train[Failed to create node]");

	// Speed
	sprintf (buffer, "%.2f", train.trainProperties.speed);
	xmlNewProp(trainNode, BAD_CAST "speed", BAD_CAST buffer);

	// Track
	xmlNodePtr trackNode = xmlNewChild(trainNode, NULL, BAD_CAST "track", NULL);
	if (!trackNode)
		Log::Instance()->die(1, SV_ERROR, "Problem saving trackstation[Failed to create node]");

	// Track Colour
	// Don't bother if the track colour is black
	if (train.trainProperties.colR != 0 ||
	train.trainProperties.colG != 0 || 
	train.trainProperties.colB != 0)
	{
		sprintf (buffer, "#%02X%02X%02X", train.trainProperties.colR, train.trainProperties.colG, train.trainProperties.colB);
		xmlNewProp(trackNode, BAD_CAST "colour", BAD_CAST buffer);
	}

	// Output all of the track sections
	DListIterator<TrackSection*> tsIter = train.tracks.GetIterator();
	tsIter.Start();
	while (tsIter.Valid())
	{
		tsIter.Item()->save(doc, trackNode);
		tsIter.Forth();
	}
	
	// Carriage properties
	xmlNodePtr carriagesNode = xmlNewChild(trainNode, NULL, BAD_CAST "carriages", NULL);
	if (!carriagesNode)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving carriages[Failed to create node]");
	
	// random - hand encode because that is all we can cope with
	xmlNewProp(carriagesNode, BAD_CAST "random", BAD_CAST "1");

	// Colour num
	sprintf (buffer, "%d", train.trainProperties.numOfColours); 		
	xmlNewProp(carriagesNode, BAD_CAST "colour-num", BAD_CAST buffer);

	// Carraige num
	sprintf (buffer, "%d", train.trainProperties.numOfCarriages); 		
	xmlNewProp(carriagesNode, BAD_CAST "carriage-num", BAD_CAST buffer);

	// Rainbow
	if (train.trainProperties.carriageRainbow > 0)
		LevelEditor::saveSFXBubble(doc, carriagesNode, "carriage", "SFX_RAINBOW", true, train.trainProperties.carriageRainbow);

	// Speed
	if (train.trainProperties.carriageSpeed > 0)
		LevelEditor::saveSFXBubble(doc, carriagesNode, "carriage", "SFX_SPEED", true, train.trainProperties.carriageSpeed);

}

void LevelEditor::quit()
{
	WindowManager::Instance()->clear();
	// Display the main menu.
	WindowManager::Instance()->push(new MainMenu(SDL_GetVideoSurface()));
}


void LevelEditor::resetMainButtons()
{
	this->btnAddLine->setActive(false);
	this->btnAddArc->setActive(false);
	this->btnAddSpiral->setActive(false);
	this->state = LES_NORMAL;
	this->stickyTrackButtons = false;
}

//-------------------------------------------------------
// Grid Property Window
//-------------------------------------------------------

// Main Load
void LevelEditor::intialiseGridPropWindow(SDL_Surface* screen)
{
	int mainWidth = 160;
	int mainHeight = 95;
//	Point mainPos(screen->w - mainWidth - 1 , 370);
	Point mainPos(0 , 0);
	
	this->gridPropWindow = new Window(screen, Rect(mainPos.x, mainPos.y, mainPos.x + mainWidth, mainPos.y + mainHeight));
	this->gridPropWindow->setModal(false);
	this->gridPropWindow->setBackgroundColour(this->propertyWinColour);
	this->gridPropWindow->setInnerBevel(true);
	this->gridPropWindow->setVisible(false);

	// Add each of the text boxes
	int left 	= 5;
	int top 	= 5;
	int txtWidth 	= 35;
	int txtHeight 	= 14;
	int vertSpace	= 23;
	int controlLeft = 120;
	int textLeft	= 5;

	// Property grid title
	Label* gridlabel = new Label(Point(left, top), Point(mainWidth - 2 * left, top + 10));
	gridlabel->setLabelText("GRID PROPERTIES");
	this->gridPropWindow->addControl(gridlabel);

	// Get all of the properties to use the same update event
	Callback0<LevelEditor> gridPropCallBack(*this, &LevelEditor::updateGrid);
	
	top += vertSpace;

	// Display Grid
	// -----------------------
	Label* dispGridLabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	dispGridLabel->setLabelText("Display Grid:");
	this->gridPropWindow->addControl(dispGridLabel);

	left = controlLeft;

	this->chkGridDisplay = new CheckBox(Point(left, top));
	this->chkGridDisplay->addChangeEvent(gridPropCallBack);
	this->chkGridDisplay->setActiveColour(this->activeColour);
	this->chkGridDisplay->setInActiveColour(this->inActiveColour);
	this->chkGridDisplay->setBevelType(BEV_INNER);
	this->gridPropWindow->addControl(this->chkGridDisplay);

	left = textLeft;
	top += vertSpace;

	// X Spacing
	// -----------------------
	Label* xSpacinglabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	xSpacinglabel->setLabelText("X Spacing:");
	this->gridPropWindow->addControl(xSpacinglabel);

	left = controlLeft;

	Rect rtxtXSpacing(left, top, left + txtWidth, top + txtHeight);
	this->txtXGridSpace = new TextBox(rtxtXSpacing);
	this->txtXGridSpace->setText("");
	this->txtXGridSpace->setTextLimit(5);
	this->txtXGridSpace->addChangeEvent(gridPropCallBack);
	this->txtXGridSpace->setActiveColour(this->activeColour);
	this->txtXGridSpace->setInActiveColour(this->inActiveColour);
	this->gridPropWindow->addControl(this->txtXGridSpace);

	left = textLeft;
	top += vertSpace;

	// Y Spacing
	// -----------------------
	Label* ySpacinglabel = new Label(Point(left, top), Point(controlLeft, top + 10));
	ySpacinglabel->setLabelText("Y Spacing:");
	this->gridPropWindow->addControl(ySpacinglabel);

	left = controlLeft;

	Rect rtxtYSpacing(left, top, left + txtWidth, top + txtHeight);
	this->txtYGridSpace = new TextBox(rtxtYSpacing);
	this->txtYGridSpace->setText("");
	this->txtYGridSpace->setTextLimit(5);
	this->txtYGridSpace->addChangeEvent(gridPropCallBack);
	this->txtYGridSpace->setActiveColour(this->activeColour);
	this->txtYGridSpace->setInActiveColour(this->inActiveColour);
	this->gridPropWindow->addControl(this->txtYGridSpace);

	LevelEditor::populateGridPropWindow();
	
	Window::addControl(this->gridPropWindow);
}

void LevelEditor::populateGridPropWindow()
{
	char buffer[10];

	// Display grid
	this->chkGridDisplay->setChecked(this->displayGrid);

	// X spacing
	sprintf(buffer, "%d", this->xGridSpace);
	this->txtXGridSpace->setText(buffer);

	// Y Spacing
	sprintf(buffer, "%d", this->yGridSpace);
	this->txtYGridSpace->setText(buffer);
}

// Main events
void LevelEditor::updateGrid()
{
	// Display grid
	this->displayGrid = this->chkGridDisplay->getChecked();

	// X spacing
	this->xGridSpace = atoi (this->txtXGridSpace->getText());

	if (this->xGridSpace < 1)
		this->xGridSpace = 1;
	else if (this->xGridSpace > 200)
		this->xGridSpace = 200;

	// Y Spacing
	this->yGridSpace = atoi (this->txtYGridSpace->getText());

	if (this->yGridSpace < 1)
		this->yGridSpace = 1;
	else if (this->yGridSpace > 200)
		this->yGridSpace = 200;

}

// Draw methods
void LevelEditor::drawGrid(SDL_Surface* screen)
{
	int xPos = this->xGridSpace;
	int yPos = this->yGridSpace;
	// Vertical lines
	while (xPos < screen->w)
	{
		Theme::Instance()->drawLine(screen, this->gridColour, xPos, 1, xPos, screen->h-1);
		xPos += this->xGridSpace;
	}
	// Horizontal lines
	while (yPos < screen->h)
	{
		Theme::Instance()->drawLine(screen, this->gridColour, 1, yPos, screen->w-1, yPos);
		yPos += this->yGridSpace;
	}
}



void LevelEditor::updatePreviousEndPos(Point endPos)
{
	// We need to move the end position of the track section before the 
	// current item
	this->currentTrackSection.Back();
	if (this->currentTrackSection.Valid())
	{
		this->currentTrackSection.Item()->setEndPosition(endPos);
		this->currentTrackSection.Forth();
	}
	else
	{
		this->currentTrackSection.Start();	
	}
}

void LevelEditor::updateNextStartPos(Point startPos)
{
	// We need to move the start position of the track section after the 
	// current item
	this->currentTrackSection.Forth();
	if (this->currentTrackSection.Valid())
	{
		this->currentTrackSection.Item()->setStartPosition(startPos);
		this->currentTrackSection.Back();
	}
	else
	{
		this->currentTrackSection.End();	
	}
}
