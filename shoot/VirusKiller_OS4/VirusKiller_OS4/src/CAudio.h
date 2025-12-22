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

class Audio {

	private:

		Engine *engine;

		Mix_Chunk *sound[MAX_SOUNDS];

		int musicVolume;
		int soundVolume;

	public:

		int useAudio;
		bool useSound, useMusic;
		
		Mix_Music *music;

	Audio();
	void setSoundVolume(int soundVolume);
	void setMusicVolume(int musicVolume);
	void registerEngine(Engine *engine);
	bool loadSound(int i, char *filename);
	bool loadMusic(char *filename);
	void playSound(int snd, int channel);
	void playSound(int snd, int channel, int loops);
	void playMusic();
	int playMenuSound(int sound);
	void pause();
	void resume();
	void stopMusic();
	void fadeMusic();
	void free();
	void destroy();

};
