/*
Copyright (C) 2004 Parallel Realities

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

class GameData {

	private:
	
		unsigned int maxDirectories, maxFiles;

	public:

		bool shownTitles;

		int gamma, soundVolume, musicVolume, fullscreen;

		char directorySearchPath[PATH_MAX];

		List virusList;
		List directoryList;
		List particleList;
		List itemList;

		char map[5][5];

		Base base[4];

		HighScore highScore[5][10];
		
		int nightmareCount;
		
		unsigned char skill;

		int score;
		unsigned int activeViruses;
		unsigned int activeDirs;
		unsigned int level;

		unsigned int virusesKilled;
		unsigned int roundVirusesKilled;

		unsigned int filesLost;
		unsigned int roundFilesLost;

		unsigned int dirsLost;
		unsigned int roundDirsLost;

		unsigned int biggestChain;
		unsigned int roundBiggestChain;

		float lastVirusKilled;

		unsigned int currentChain;

		float kernelPower;
		float threadStopTimer;
		unsigned char threadStops;

		unsigned int roundItemsCollected;


	GameData();
	~GameData();
	void clear();
	void resetForNextRound();
	void destroy();

	Directory *addDirectory(char *name);
	void addVirus(Virus *virus);
	void addParticle(Particle *particle);
	void addItem(Item *item);

	void removeEmptyDirectories();

	Directory *getRandomDirectory(bool active);
	void buildActiveDirList(int amount);

};
