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

class Sprite : public GameObject {

	public:

		char name[50];

		SDL_Surface *image[10];
		unsigned char frameLength[10];

		unsigned char currentFrame;
		float currentTime;
		unsigned char maxFrames;

		bool randomFrames;

	Sprite();
	virtual ~Sprite();
	void setFrame(int i, SDL_Surface *shape, int time);
	void animate(float amount);
	void getNextFrame(unsigned char *frame, unsigned char *time);
	SDL_Surface *getCurrentFrame();
	void free();
	void destroy();

};
