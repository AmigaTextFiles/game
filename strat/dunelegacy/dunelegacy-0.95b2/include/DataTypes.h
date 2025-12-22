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

#ifndef DATATYPES_H
#define DATATYPES_H

#include <Definitions.h>

// Libraries
#include <SDL.h>
#include <string>


class Coord {
public:
	Coord() {
		x = y = 0;
	}

	Coord(int x,int y) {
		this->x = x;
		this->y = y;
	}

	inline bool operator==(const Coord& c) const {
        return (x == c.x && y == c.y);
	}

	inline bool operator!=(const Coord& c) const {
        return !operator==(c);
	}

    inline Coord operator+(const Coord& c) const {
        return Coord(x+c.x, y+c.y);
	}


	inline Coord operator-(const Coord& c) const {
        return Coord(x-c.x, y-c.y);
	}

    inline Coord operator*(short c) const {
        return Coord(x*c, y*c);
	}


	inline Coord operator/(short c) const {
        return Coord(x/c, y/c);
	}

	int	x,y;
};

typedef enum {
	CURSOR_NORMAL,
	CURSOR_UP,
	CURSOR_RIGHT,
	CURSOR_DOWN,
	CURSOR_LEFT,
	CURSOR_TARGET,
	CURSOR_SELECTION,
	NUM_CURSORS
} CURSORTYPE;

typedef enum {SCOUT, STANDGROUND, DEFENSIVE, AGGRESSIVE} ATTACKTYPE;
typedef enum {NOTBLOCKED, COMBLOCKED, MOUNTAIN, INFANTRY} BLOCKEDTYPE;
typedef enum {EASY, MEDIUM, HARD/*, IMPOSSIBLE*/} DIFFICULTYTYPE;
typedef enum {START, LOADING, BEGUN} GAMESTATETYPE;
typedef enum {CUSTOM, MULTIPLAYER, ORIGINAL, RANDOMMAP, SKIRMISH} GAMETYPE;
typedef enum {ATREIDES, ORDOS, HARKONNEN, SARDAUKAR, FREMEN, MERCENERY} PLAYERHOUSE;


class SettingsClass
{
public:
	class SettingsClass_GeneralClass {
	public:
		bool		PlayIntro;
		bool		ConcreteRequired;
		std::string	PlayerName;
		int			Language;
		std::string	LanguageExt;

		void setLanguage(int newLanguage) {
			switch(newLanguage) {
				case LNG_ENG:
					Language = LNG_ENG;
					LanguageExt = "ENG";
					break;
				case LNG_GER:
					Language = LNG_GER;
					LanguageExt = "GER";
					break;
				default:
					return;
			}
		}

		std::string getLanguageString() {
			switch(Language) {
				case LNG_ENG:
					return "en";
				case LNG_GER:
					return "de";
				default:
					return "";
			}
		}
	} General;

	class SettingsClass_VideoClass {
	public:
		bool	DoubleBuffered;
		bool	Fullscreen;
		int		Width;
		int		Height;
        bool	FrameLimit;
	} Video;

	class SettingsClass_AudioClass {
	public:
		std::string MusicType;
	} Audio;

	bool	finished,
			isHuman[MAX_PLAYERS],
			update,
			won;

	DIFFICULTYTYPE	playerDifficulty[MAX_PLAYERS];
};

typedef enum
{
	HOUSE_ATREIDES,		//house definitions
	HOUSE_ORDOS,
	HOUSE_HARKONNEN,
	HOUSE_SARDAUKAR,
	HOUSE_FREMEN,
	HOUSE_MERCENARY,
	NUM_HOUSES
} HOUSETYPE;

#endif //DATATYPES_H
