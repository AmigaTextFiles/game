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

#include <FileClasses/Animation.h>

#include <misc/draw_util.h>

#include <stdio.h>
#include <stdlib.h>

Animation::Animation() {
	CurFrameStartTime = SDL_GetTicks();
	FrameDurationTime = 1;
	NumFrames = 0;
	curFrame = 0;
	Frame = NULL;
}

Animation::~Animation() {
	if(Frame != NULL) {
		for(int i=0; i < NumFrames; i++) {
			SDL_FreeSurface(Frame[i]);
			Frame[i] = NULL;
		}
		free(Frame);
	}
}

SDL_Surface* Animation::getFrame() {
	if(Frame == NULL) {
		return NULL;
	}

	if((SDL_GetTicks() - CurFrameStartTime) > FrameDurationTime) {
		CurFrameStartTime = SDL_GetTicks();
		curFrame++;
		if(curFrame >= NumFrames) {
			curFrame = 0;
		}
	}
	return Frame[curFrame];
}

void Animation::addFrame(SDL_Surface* newFrame, bool DoublePic,bool SetColorKey) {
	if((Frame = (SDL_Surface**) realloc(Frame,sizeof(SDL_Surface*) * (NumFrames+1))) == NULL) {
		perror("Animation::addFrame()");
		exit(EXIT_FAILURE);
	}

	if(DoublePic == true) {
		Frame[NumFrames] = DoublePicture(newFrame);
	} else {
		Frame[NumFrames] = newFrame;
	}

	if(SetColorKey == true) {
		SDL_SetColorKey(Frame[NumFrames], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}
	NumFrames++;
}
