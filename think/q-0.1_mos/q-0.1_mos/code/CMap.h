/*
Copyright (C) 2003 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

class Map {

	private:
	
		Engine *engine;
		unsigned long lastTime;

	public:
	
		Sprite *ballSprite[4];

		char data[MAPWIDTH][MAPHEIGHT];
		unsigned int hours, minutes, seconds;
		unsigned int mapNumber;
		unsigned int moves;
		
		int arrowX[4], arrowY[4];

		Ball ball[MAX_BALLS];

	Map();
	void clear();
	void registerEngine(Engine *engine);
	void resetMapStats();
	void incrementTime();
	void clearArrows();
	void setArrow(int i, int x, int y);
	void setArrows(Ball *ball);
	int getBallType(char *ballType);
	void addBall(int ballType, int x, int y);
	void removeBallAt(int x, int y);
	bool saveMap();
	bool loadMap();
	bool loadNextMap();
	bool loadPreviousMap();

};
