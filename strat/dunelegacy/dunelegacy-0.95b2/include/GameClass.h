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

#ifndef GAMECLASS_H
#define GAMECLASS_H

#include <GUI/CallbackTarget.h>

#include <misc/Random.h>
#include <misc/RobustList.h>
#include <ObjectData.h>
#include <ObjectManager.h>
#include <CommandManager.h>
#include <GameInterface.h>

#include <DataTypes.h>

#include <SDL.h>
#include <stdarg.h>
#include <string>
#include <map>

// forward declarations
class GameInitClass;
class ObjectClass;
class InGameMenu;
class MentatHelp;
class RadarView;
class ObjectManager;
class PlayerClass;
class Explosion;


#define END_WAIT_TIMER				100

#define GAME_NOTHING			-1
#define	GAME_RETURN_TO_MENU		0
#define GAME_NEXTMISSION		1
#define	GAME_LOAD				2
#define GAME_DEBRIEFING_WIN		3
#define	GAME_DEBRIEFING_LOST	4


class GameClass : public CallbackTarget
{
public:
	GameClass();
	~GameClass();

	void ProcessObjects();
	void drawScreen();
	void doInput();

    /**
        Returns the current game cycle number.
        \return the current game cycle
    */
	Uint32 GetGameCycleCount() { return GameCycleCount; };

    /**
        Get the command manager of this game
        \return the command manager
    */
	CommandManager& GetCommandManager() { return CmdManager; };

	/**
        Get the explosion list.
        \return the explosion list
	*/
	RobustList<Explosion*>& getExplosionList() { return explosionList; };

	void drawCursor();
	void setupView();

	bool InitReplay(std::string filename);
	bool InitGame(GameInitClass *init);

	bool loadINIMap(std::string mapname);
	bool loadSaveGame(std::string filename);
	bool saveGame(std::string filename);
	void startGame();
	inline void quit_Game() { bQuitGame = true;};
	void ResumeGame();

	void addPlayer(PLAYERHOUSE House, bool ai,int team);

	void SaveObject(Stream& stream, ObjectClass* obj);
	ObjectClass* LoadObject(Stream& stream, Uint32 ObjectID);
	inline ObjectManager& getObjectManager() { return objectManager; };
	inline GameInterface& getGameInterface() { return *pInterface; };

	GameInitClass * getNextGameInitClass();
	int whatNext();

	void OnOptions();
	void OnMentat();

	void selectAll(std::set<Uint32>& aList);
	void unselectAll(std::set<Uint32>& aList);

    /**
        Returns a list of all currently selected objects.
        \return list of currently selected units/structures
    */
	std::set<Uint32>& getSelectedList() { return selectedList; };

	/**
        Returns one of the 10 saved units lists
        \param  i   which list should be returned
        \return the i-th list.
	*/
	std::set<Uint32>& getGroupList(int i) { return selectedLists[i]; };

    /**
        Adds a new message to the news ticker.
        \param  text    the text to add
    */
	void AddToNewsTicker(const std::string& text) {
		if(pInterface != NULL) {
			pInterface->AddToNewsTicker(text);
		}
	}

    /**
        Adds an urgent message to the news ticker.
        \param  text    the text to add
    */
	void AddUrgentMessageToNewsTicker(const std::string& text) {
		if(pInterface != NULL) {
			pInterface->AddUrgentMessageToNewsTicker(text);
		}
	}

public:
	GAMETYPE	gameType;
	int			maxPathSearch;
	int			techLevel;
	bool		concreteRequired;
	int			winFlags;

	PlayerClass*	player[MAX_PLAYERS];
	DIFFICULTYTYPE	playerDifficulty[MAX_PLAYERS];
	bool	won;
	bool	finished;

	bool	placingMode;

	GameInitClass*	InitSettings;
	GameInitClass*	NextGameInitSettings;

	int		gamespeed;
	bool	shift;

	int		maxPlayers;
	char	playerName[MAX_PLAYERS][MAX_NAMELENGTH];

	Random  RandomGen;              ///< This is the random number generator for this game
	ObjectData  objectData;         ///< This contains all the unit/structure data
	RadarView*  radarView;          ///< This is the minimap/radar in the game bar

	SDL_Surface* fogSurf;           ///< fog surface

private:

	char	localPlayerName[MAX_NAMELENGTH];
	char	mapFilename[MAX_LINE];

	int		numPlayers;
	int		campaignLevel;

	bool	attackMoveMode;
	bool	builderSelectMode;
	bool	groupCreateMode;
	bool	messageMode;
	bool	moveDownMode, moveLeftMode, moveRightMode, moveUpMode;

	bool	radarMode;
	bool	selectionMode;

	int		whatNextParam;

//	CURSORTYPE cursorFrame;

//	int drawnMouseX, drawnMouseY;


	Uint32 indicatorFrame;
	int	indicatorTime;
	int	indicatorTimer;

	Coord indicatorPosition;

	double fps;
	int frameTimer;

	Uint32 GameCycleCount;

	Uint32 SkipToGameCycle;     ///< skip to this game cycle

	SDL_Rect	powerIndicatorPos;
	SDL_Rect	spiceIndicatorPos;
	SDL_Rect	topBarPos;

//	GAMESTATETYPE gameState;

	//game interfaces
	int		saveGameSpot;


	////////////////////

	ObjectManager   objectManager;	    ///< This manages all the object and maps object ids to the actual objects

	CommandManager CmdManager;			///< This is the manager for all the game commands

	bool	bQuitGame;					///< Should the game be quited after this game tick
	bool	bPause;						///< Is the game currently halted
	bool	bReplay;					///< Is this game actually a replay

	bool	bShowFPS;					///< Show the FPS

	GameInterface*	pInterface;			///< This is the whole interface (top bar and side bar)
	InGameMenu*		pInGameMenu;		///< This is the menu that is opened by the option button
	MentatHelp*		pInGameMentat;		///< This is the mentat dialog opened by the mentat button

	std::set<Uint32> selectedList;      ///< A set of all selected units/structures
    std::set<Uint32> selectedLists[NUMSELECTEDLISTS];   ///< Sets of all the different groups on key 1 to 9


    RobustList<Explosion*> explosionList; ///< A list containing all the explosions that must be drawn



	///////////////////////



	SDL_Surface		*gamebarSurface;
	SDL_Surface		*topBarSurface;

	int	endTimer;
	bool finishedLevel;

//	MapClass		*map;

	//hidden surface
	SDL_Surface* hiddenSurf;

	/*fog pixelmap for alphablending neighbours of fogged terrain*/
	Uint32 fogMAP[256][16];

//	char	messageBuffer[MESSAGE_BUFFER_SIZE][MAX_LINE];
	char	typingMessage[MAX_MSGLENGTH - 3];
//	int		messageTimer[MESSAGE_BUFFER_SIZE];
};

#endif // GAMECLASS_H
