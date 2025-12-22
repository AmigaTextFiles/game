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
  * Allow the player to edit / create new levels for them to play
  */

#ifndef LEVELEDITOR_H
#define LEVELEDITOR_H

#include "List.h"
#include "Window.h"
#include "WindowManager.h"
#include "MainMenu.h"
#include "Callback.h"
#include "TrackSection.h"
#include "FileLoadSaveBox.h"

#define LE_IMG_LOCATION "../gfx/leveleditor/"		// Relative location for the graphics

// Define the state for the level editor
enum LevelEditorState
{
	LES_NORMAL,		
	LES_ADD_LINE,
	LES_ADD_ARC,
	LES_ADD_SPIRAL,
	LES_TEST
};

// Holds all of the basic information about the cannon. e.g. the colours, 
// special carriages, speed, refresh rate etc
struct CannonProperties
{
	int numOfColours;			// number of colours the cannon magazine can produce
	double speed;				// speed at which bullets travel
	int refreshRate;			// Amount of time msec that it takes to reload a bullet
	int bulletSFXRainbow;		// Number of each special type of bubble
	int bulletSFXSpeed;
	int bulletSFXBomb;
	int bulletSFXColBomb;

	CannonProperties()
	{
		reset();
	}	
	
	inline void reset()
	{
		this->numOfColours	 	= 3;
		this->refreshRate 		= 600;
		this->speed 			= 10.0;
		this->bulletSFXRainbow 	= 0;
		this->bulletSFXSpeed 	= 0;
		this->bulletSFXBomb 	= 0;
		this->bulletSFXColBomb 	= 0;
	}

};

// Holds all of the basic information about a train. e.g. the colours, 
// special carriages
struct TrainCarriageProperties
{
	int numOfCarriages;			// Number of carriages for this train.
	int numOfColours;			// Number of colours the carriage factory can produce
	double speed;				// Speed of the train in pixels per second 1-2
	int carriageRainbow;		// Number of the special type of bullet
	int carriageSpeed;			
	Uint8 colR;					// Colour components for the track colour
	Uint8 colG;
	Uint8 colB;
	Uint32 colour;

	TrainCarriageProperties()
	{
		this->numOfCarriages 	= 10;
		this->numOfColours 		= 3;
		this->speed 			= 1.0;
		this->carriageRainbow 	= 0;
		this->carriageSpeed 	= 0;
		this->colR				= 0x1;
		this->colG				= 0x1;
		this->colB				= 0x1;
		this->colour			= SDL_MapRGB(SDL_GetVideoSurface()->format, colR, colG, colB);
	}	

};

// Holds all of the information about the track / train etc.
struct LETrain
{
	List<TrackSection*> tracks;
	TrainCarriageProperties trainProperties;
	
	LETrain()
	{
		
	}
	
	~LETrain()
	{
		this->tracks.DeleteAndRemove();	
	}
};


class LevelEditor : public Window
{
private:
	char* filename;
	bool dirty;
	Label* testlabel;
	
	LevelEditorState state;
	CannonProperties cannonProp;
	
	// Colours
	Uint32 activeColour;
	Uint32 inActiveColour;
	Uint32 propertyWinColour;
	Uint32 windowColour;
	
	//-----------------------------------------------------
	// Track Sections
	//-----------------------------------------------------
	//List<TrackSection*> trackSections;
	List<LETrain*> trains;
	DListIterator<LETrain*> currentTrain;
	DListIterator<TrackSection*> currentTrackSection;
	
	void addTrackSection();
	
	//------------------------------------------------------
	// Click Events
	//------------------------------------------------------
	List<Point> clickPoints;
	
	//-------------------------------------------------------
	// Line Property Window
	//-------------------------------------------------------
	Window* linePropWindow;
	TextBox* txtXPosStartLine;
	TextBox* txtYPosStartLine;	
	TextBox* txtXPosEndLine;
	TextBox* txtYPosEndLine;
	
	// Main Load
	void intialiseLinePropWindow(SDL_Surface* screen);
	void populateLinePropWindow();
	
	// Main events
	void updateLineStartPos();
	void updateLineEndPos();
		
	//-------------------------------------------------------
	// Arc Property Window
	//-------------------------------------------------------
	Window* arcPropWindow;
	TextBox* txtXPosStartArc;
	TextBox* txtYPosStartArc;	
	TextBox* txtXPosEndArc;
	TextBox* txtYPosEndArc;
	TextBox* txtRadiusArc;
	CheckBox* chkRotationArc;
	CheckBox* chkFlipArc;
	
	// Main Load
	void intialiseArcPropWindow(SDL_Surface* screen);
	void populateArcPropWindow();
	
	// Main events
	void updateArcStartPos();
	void updateArcEndPos();
	void updateArcRadius();
	void updateArcRotation();
	void updateArcFlip();
	
	//-------------------------------------------------------
	// Spiral Property Window
	//-------------------------------------------------------
	Window* spiralPropWindow;
	TextBox* txtXPosStartSpiral;
	TextBox* txtYPosStartSpiral;	
	TextBox* txtXPosCentreSpiral;
	TextBox* txtYPosCentreSpiral;
	TextBox* txtRadiusSpiral;
	TextBox* txtNumOfTurnsSpiral;	
	CheckBox* chkRotationSpiral;
	
	// Main Load
	void intialiseSpiralPropWindow(SDL_Surface* screen);
	void populateSpiralPropWindow();
	
	// Main events
	void updateSpiralStartPos();
	void updateSpiralCentrePos();
	void updateSpiralNumOfTurns();
	void updateSpiralRadius();
	void updateSpiralRotation();
	
	//-------------------------------------------------------
	// Cannon Properties
	//-------------------------------------------------------
	Window* cannonPropWindow;
	TextBox* txtnumOfColoursCannon;
	TextBox* txtspeedCannon;
	TextBox* txtrefreshRateCannon;
	TextBox* txtbulletSFXRainbowCannon;
	TextBox* txtbulletSFXSpeedCannon;
	TextBox* txtbulletSFXBombCannon;
	TextBox* txtbulletSFXColBombCannon;
	
	// Main Load
	void intialiseCannonPropWindow(SDL_Surface* screen);
	void populateCannonPropWindow();
	
	void updateCannonProps();
	
	//-------------------------------------------------------
	// Train Controls
	//-------------------------------------------------------
	Window* trainPropWindow;
	TextBox* txtnumOfCarriagesTrain;
	TextBox* txtnumOfColoursTrain;	
	TextBox* txtspeedTrain;
	TextBox* txtcarriageRainbowTrain;
	TextBox* txtcarriageSpeedTrain;
	TextBox* txtColourRedTrain;
	TextBox* txtColourGreenTrain;
	TextBox* txtColourBlueTrain;
	
	// Main Load
	void intialiseTrainPropWindow(SDL_Surface* screen);
	void populateTrainPropWindow();
	
	void updateTrainProps();
	void updateTrainColour();
			
	//-------------------------------------------------------
	// Track Controls
	//-------------------------------------------------------
	// Main controls Window
	Window* trackPropWindow;
	Button* btnAddLine;
	Button* btnAddArc;
	Button* btnAddSpiral;
	bool stickyTrackButtons;
	
	// Track Load
	void intialiseTrackPropWindow(SDL_Surface* screen);
	
	// Track events
	void addLine();
	void addArc();
	void addSpiral();
	void removeTrackSection();
	void previousTrackSection();
	void nextTrackSection();
	void newTrack();
	void removeTrack();
	void previousTrack();
	void nextTrack();
	void toggleTrainProps();
	void toggleCannonProps();
	void toggleGridProps();
	
	void resetTrackSectionColour();
	void highlightTrackSection();
	
	void updatePreviousEndPos(Point endPos);
	void updateNextStartPos(Point startPos);
		
	//-------------------------------------------------------
	// Main Controls
	//-------------------------------------------------------
	// Main controls Window
	Window* mainPropWindow;
	
	// Main Load
	void intialiseMainPropWindow(SDL_Surface* screen);
	
	// Main events
	void load();
	void loadLevel(const char* filename);
	void loadCannon(xmlDocPtr doc, xmlNodePtr cur);
	void loadTrain(xmlDocPtr doc, xmlNodePtr cur, LETrain* train);
	void save();
	void saveLevel(const char* filename);
	void saveCannon(xmlDocPtr doc, xmlNodePtr cur);
	void saveSFXBubble(xmlDocPtr doc, xmlNodePtr cur, const char* elementName, const char* type, bool special, int number);
	void saveTrain(xmlDocPtr doc, xmlNodePtr cur, LETrain& train);
	void quit();
	
	void resetMainButtons();
	
	//-------------------------------------------------------
	// Grid Property Window
	//-------------------------------------------------------
	// Drawing methods / attributes
	int xGridSpace;
	int yGridSpace;
	Uint32 gridColour;
	bool displayGrid;
	
	// Grid edit controls
	Window* gridPropWindow;
	TextBox* txtXGridSpace;
	TextBox* txtYGridSpace;	
	CheckBox* chkGridDisplay;
	
	// Main Load
	void intialiseGridPropWindow(SDL_Surface* screen);
	void populateGridPropWindow();
	
	// Main events
	void updateGrid();
	
	// Draw
	void drawGrid(SDL_Surface* screen);
	

public:

	LevelEditor(SDL_Surface* screen);
	virtual ~LevelEditor();
	
	// IWidget methods
	virtual bool mouseDown(int x, int y);
	virtual void draw(SDL_Surface* screenDest);
	
};

#endif // LEVELEDITOR_H
