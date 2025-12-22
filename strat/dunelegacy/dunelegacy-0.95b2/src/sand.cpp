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

#include <sand.h>

#include <globals.h>

#include <FileClasses/DataManager.h>

#include <Menu/BriefingMenu.h>

#include <GameClass.h>
#include <GameInitClass.h>
#include <data.h>

#include <algorithm>


/**
    This function draws the cursor to the screen. The coordinate is read from
    the two global variables drawnMouseX and drawnMouseY.
*/
void drawCursor()
{
	SDL_Rect dest, src;
	SDL_Surface* surface = pDataManager->getUIGraphic(UI_CursorShape);

	dest.x = drawnMouseX;
	dest.y = drawnMouseY;
	dest.w = src.w = surface->w/NUM_CURSORS;
	dest.h = src.h = surface->h;
	src.x = src.w * cursorFrame;
	src.y = 0;

	//reposition image so pointing on right spot
	if (cursorFrame == CURSOR_RIGHT)
		dest.x -= dest.w/2;
	else if (cursorFrame == CURSOR_DOWN)
		dest.y -= dest.h/2;
	if ((cursorFrame == CURSOR_TARGET) || (cursorFrame == CURSOR_SELECTION))
	{
		dest.x -= dest.w/2;
		dest.y -= dest.h/2;
	}

	SDL_BlitSurface(surface, &src, screen, &dest);
}

/**
    This function resolves the picture corresponding to one item id.
    \param itemID   the id of the item to resolve (e.g. Unit_Quad)
    \return the surface corresponding. This surface should not be freed or modified. NULL on error.
*/
SDL_Surface* resolveItemPicture(int itemID)
{
	int newPicID;

	switch(itemID) {
		case Unit_Carryall:			        newPicID = Picture_Carryall;		    break;
		case Unit_Devastator:		       	newPicID = Picture_Devastator;		    break;
		case Unit_Deviator:			        newPicID = Picture_Deviator;	    	break;
		case Unit_Harvester:		    	newPicID = Picture_Harvester;		    break;
		case Unit_Launcher:			        newPicID = Picture_Launcher;	    	break;
		case Unit_MCV:			            newPicID = Picture_MCV;		            break;
		case Unit_Ornithopter:			    newPicID = Picture_Ornithopter;		    break;
		case Unit_Quad:		            	newPicID = Picture_Quad;		        break;
		case Unit_Raider:			        newPicID = Picture_Raider;		        break;
		case Unit_SiegeTank:		    	newPicID = Picture_SiegeTank;	    	break;
		case Unit_SonicTank:		    	newPicID = Picture_SonicTank;	    	break;
		case Unit_Tank:			            newPicID = Picture_Tank;		        break;
		case Unit_Trike:		        	newPicID = Picture_Trike;		        break;
		case Unit_Soldier:			        newPicID = Picture_Soldier;	        	break;
		case Unit_Trooper:			        newPicID = Picture_Trooper;		        break;
		case Unit_Saboteur:			        newPicID = Picture_Saboteur;	    	break;
		case Unit_Fremen:			        newPicID = Picture_Fremen;	            break;
		case Unit_Sardaukar:                newPicID = Picture_Sardaukar;		    break;
		case Structure_Barracks:            newPicID = Picture_Barracks;		    break;
		case Structure_ConstructionYard:    newPicID = Picture_ConstructionYard;	break;
		case Structure_GunTurret:			newPicID = Picture_GunTurret;		    break;
		case Structure_HeavyFactory:		newPicID = Picture_HeavyFactory;		break;
		case Structure_HighTechFactory:		newPicID = Picture_HighTechFactory;		break;
		case Structure_IX:			        newPicID = Picture_IX;		            break;
		case Structure_LightFactory:		newPicID = Picture_LightFactory;		break;
		case Structure_Palace:			    newPicID = Picture_Palace;		        break;
		case Structure_Radar:			    newPicID = Picture_Radar;		        break;
		case Structure_Refinery:			newPicID = Picture_Refinery;	       	break;
		case Structure_RepairYard:			newPicID = Picture_RepairYard;		    break;
		case Structure_RocketTurret:		newPicID = Picture_RocketTurret;		break;
		case Structure_Silo:			    newPicID = Picture_Silo;		        break;
		case Structure_StarPort:			newPicID = Picture_StarPort;	    	break;
		case Structure_Slab1:			    newPicID = Picture_Slab1;               break;
		case Structure_Slab4:			    newPicID = Picture_Slab4;		        break;
		case Structure_Wall:			    newPicID = Picture_Wall;	        	break;
		case Structure_WindTrap:		   	newPicID = Picture_WindTrap;	    	break;
		case Structure_WOR:			        newPicID = Picture_WOR;		            break;

		default:    return NULL;    break;
    }

    return pDataManager->getSmallDetailPic(newPicID);
}

/**
    This function returns the size of the specified item.
    \param ItemID   the id of the item (e.g. Structure_HeavyFactory)
    \return a Coord containg the size (e.g. (3,2) ). Returns (0,0) on error.
*/
Coord getStructureSize(int ItemID) {

	switch(ItemID) {
		case Structure_Barracks:			return Coord(2,2); break;
		case Structure_ConstructionYard:	return Coord(2,2); break;
		case Structure_GunTurret: 			return Coord(1,1); break;
		case Structure_HeavyFactory: 		return Coord(3,2); break;
		case Structure_HighTechFactory:		return Coord(3,2); break;
		case Structure_IX:					return Coord(2,2); break;
		case Structure_LightFactory:		return Coord(2,2); break;
		case Structure_Palace:				return Coord(3,3); break;
		case Structure_Radar:				return Coord(2,2); break;
		case Structure_Refinery:			return Coord(3,2); break;
		case Structure_RepairYard:			return Coord(3,2); break;
		case Structure_RocketTurret:		return Coord(1,1); break;
		case Structure_Silo:				return Coord(2,2); break;
		case Structure_StarPort:			return Coord(3,3); break;
		case Structure_Slab1:				return Coord(1,1); break;
		case Structure_Slab4:				return Coord(2,2); break;
		case Structure_Wall:				return Coord(1,1); break;
		case Structure_WindTrap:			return Coord(2,2); break;
		case Structure_WOR:					return Coord(2,2); break;
		default:							return Coord(0,0); break;
	}

	return Coord(0,0);
}

/**
    This function return the item id of an item specified by name. There may be multiple names for
    one item. The case of the name is ignored.
    \param name the name of the item (e.g. "rocket-turret" or "r-turret".
    \return the id of the item (e.g. Structure_RocketTurret)
*/
Uint32  getItemIDByName(std::string name) {
    // convert to lower case
    std::transform(name.begin(), name.end(), name.begin(), (int(*)(int)) tolower);

    if(name == "barracks")                                              return Structure_Barracks;
    else if((name == "const yard") || (name == "construction yard"))    return Structure_ConstructionYard;
    else if((name == "r-turret") || (name == "rocket-turret"))          return Structure_RocketTurret;
    else if((name == "turret") || (name == "gun-turret"))               return Structure_GunTurret;
    else if((name == "heavy fctry") || (name == "heavy factory"))       return Structure_HeavyFactory;
	else if((name == "hi-tech") || (name == "hightech factory"))        return Structure_HighTechFactory;
	else if((name == "ix") || (name == "house ix"))                     return Structure_IX;
    else if((name == "light fctry") || (name == "light factory"))       return Structure_LightFactory;
	else if(name == "palace")                                           return Structure_Palace;
    else if((name == "outpost") || (name == "radar"))                   return Structure_Radar;
	else if(name == "refinery")                                         return Structure_Refinery;
    else if((name == "repair") || (name == "repair yard"))              return Structure_RepairYard;
	else if((name == "spice silo") || (name == "silo"))                 return Structure_Silo;
	else if((name == "concrete") || (name == "slab1"))                  return Structure_Slab1;
	else if(name == "slab4")                                            return Structure_Slab4;
    else if((name == "star port") || (name == "starport"))              return Structure_StarPort;
    else if(name == "wall")                                             return Structure_Wall;
    else if(name == "windtrap")                                         return Structure_WindTrap;
    else if(name == "wor")                                              return Structure_WOR;
    else if((name == "carryall") || (name == "carry-all"))              return Unit_Carryall;
	else if(name == "devastator")                                       return Unit_Devastator;
    else if(name == "deviator")                                         return Unit_Deviator;
    else if(name == "fremen")                                           return Unit_Fremen;
    else if(name == "frigate")                                          return Unit_Frigate;
	else if(name == "harvester")                                        return Unit_Harvester;
	else if(name == "soldier")                                          return Unit_Soldier;
	else if(name == "launcher")                                         return Unit_Launcher;
	else if(name == "mcv")                                              return Unit_MCV;
	else if((name == "thopters") || (name == "'thopters")
                                 || (name == "ornithopter"))            return Unit_Ornithopter;
	else if(name == "quad")                                             return Unit_Quad;
	else if(name == "saboteur")                                         return Unit_Saboteur;
    else if(name == "sandworm")                                         return Unit_Sandworm;
    else if(name == "sardaukar")                                        return Unit_Sardaukar;
    else if(name == "siege tank")                                       return Unit_SiegeTank;
	else if((name == "sonic tank") || (name == "sonictank"))            return Unit_SonicTank;
	else if(name == "tank")                                             return Unit_Tank;
    else if(name == "trike")                                            return Unit_Trike;
    else if((name == "raider trike") || (name == "raider"))             return Unit_Raider;
	else if(name == "trooper")                                          return Unit_Trooper;
	else                                                                return ItemID_Invalid;
}

/**
    This function returns the number of each house providing the house name as a string. The comparison is
    done case-insensitive.
    \param name the name of the house (e.g."Atreides")
    \return the number of the house (e.g. HOUSE_ATREIDES). INVALID is returned on error.
*/
int getHouseByName(std::string name)
{
    // convert to lower case
    transform(name.begin(), name.end(), name.begin(), (int(*)(int)) tolower);

    if(name == "atreides")          return HOUSE_ATREIDES;
    else if(name == "ordos")        return HOUSE_ORDOS;
    else if(name == "harkonnen")    return HOUSE_HARKONNEN;
    else if(name == "fremen")       return HOUSE_FREMEN;
	else if(name == "sardaukar")    return HOUSE_SARDAUKAR;
	else if(name == "mercenary")    return HOUSE_MERCENARY;
    else                            return INVALID;
}

/**
	Starts a game replay
	\param	filename	the filename of the replay file
*/
void startReplay(std::string filename) {

		currentGame = new GameClass();
		if(currentGame == NULL) {
			fprintf(stdout,"startReplay(): Cannot create new GameClass-Object\n");
			fflush(stdout);
			exit(EXIT_FAILURE);
		}

		printf("Initing Replay:\n");
		fflush(stdout);
		currentGame->InitReplay(filename);

		printf("Initialization finished!\n");
		fflush(stdout);

		currentGame->startGame();

		delete currentGame;
}


/**
	Starts a new game. If this game is quit it might start another game. This other game is also started from
	this function. This is done until there is no more game to be started.
	\param init	contains all the information to start the game
*/
void startSinglePlayerGame(GameInitClass * init)
{

	while(1) {

		currentGame = new GameClass();
		if(currentGame == NULL) {
			fprintf(stdout,"startSinglePlayerGame(): Cannot create new GameClass-Object\n");
			fflush(stdout);
			exit(EXIT_FAILURE);
		}

		printf("Initing Game:\n");
		fflush(stdout);
		currentGame->InitGame(init);

		printf("Initialization finished!\n");
		fflush(stdout);

		currentGame->startGame();

		bool bGetNext = true;
		while(bGetNext) {
			switch(currentGame->whatNext())
			{
				case GAME_DEBRIEFING_WIN:
				{
					fprintf(stdout,"Debriefing...");
					fflush(stdout);
					BriefingMenu* pBriefing = new BriefingMenu(init->House,init->mission, DEBRIEFING_WIN);
					pBriefing->showMenu();
					delete pBriefing;
					fprintf(stdout,"\t\t\tfinished\n");
					fflush(stdout);
				} break;

				case GAME_DEBRIEFING_LOST:
				{
					fprintf(stdout,"Debriefing...");
					fflush(stdout);
					BriefingMenu* pBriefing = new BriefingMenu(init->House,init->mission, DEBRIEFING_LOST);
					pBriefing->showMenu();
					delete pBriefing;
					fprintf(stdout,"\t\t\tfinished\n");
					fflush(stdout);
				} break;

				case GAME_LOAD:
				case GAME_NEXTMISSION:
				{
					init = currentGame->getNextGameInitClass();
					delete currentGame;
					bGetNext = false;
				} break;

				case GAME_RETURN_TO_MENU:
				default:
				{
					delete currentGame;
					return;
				} break;
			}
		}


	}
}

/**
	Splits a string into several substrings. This strings are separated with ','.
        Example:<br>
        String first, second;<br>
        SplitString("abc,xyz",2,&first, &second);<br>
	\param ParseString  the string to parse
	\param NumStringPointers    the number of pointers to strings following after this parameter
	\return true if successful, false otherwise.
*/
bool SplitString(std::string ParseString, unsigned int NumStringPointers, ...) {
	va_list arg_ptr;
	va_start(arg_ptr, NumStringPointers);

	std::string** pStr;

	if(NumStringPointers == 0)
		return false;

	if((pStr = (std::string**) malloc(sizeof(std::string*) * NumStringPointers)) == NULL) {
		fprintf(stdout,"SplitString: Cannot allocate memory!\n");
		exit(EXIT_FAILURE);
	}

	for(unsigned int i = 0; i < NumStringPointers; i++) {
		pStr[i] = va_arg(arg_ptr, std::string* );
	}
	va_end(arg_ptr);

	int startpos = 0;
	unsigned int index = 0;

	for(unsigned int i = 0; i < ParseString.size(); i++) {
		if(ParseString[i] == ',') {
			*(pStr[index]) = ParseString.substr(startpos,i-startpos);
			startpos = i + 1;
			index++;
			if(index >= NumStringPointers) {
				free(pStr);
				return false;
			}
		}
	}

	*(pStr[index]) = ParseString.substr(startpos,ParseString.size()-startpos);
	free(pStr);
	return true;
}

/*
	Splits a string into several substrings. This strings are separated with ','.
*/
std::vector<std::string> SplitString(std::string ParseString) {
	std::vector<std::string> retVector;
	int startpos = 0;

	for(unsigned int i = 0; i < ParseString.size(); i++) {
		if(ParseString[i] == ',') {
			retVector.push_back(ParseString.substr(startpos,i-startpos));
			startpos = i + 1;
		}
	}

	retVector.push_back(ParseString.substr(startpos,ParseString.size()-startpos));
	return retVector;
}
