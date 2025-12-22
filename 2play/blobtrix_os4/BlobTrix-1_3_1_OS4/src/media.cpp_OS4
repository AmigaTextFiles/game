/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "media.h"

#include "config.h"

#include "files.h"

media::media() {
#ifndef NOSOUND
	gamemusic=0;
	browseclick=0;
	rotate=0;
	launch=0;
	select=0;
	fossil=0;
#endif
}

media::~media() {

#ifndef NOSOUND
	if (gamemusic!=0) sound::FreeMusic(gamemusic);
	if (browseclick!=0) sound::FreeChunk(browseclick);
	if (rotate!=0) sound::FreeChunk(rotate);
	if (launch!=0) sound::FreeChunk(launch);
	if (select!=0) sound::FreeChunk(select);
	if (fossil!=0) sound::FreeChunk(fossil);
	if (win!=0) sound::FreeChunk(win);
	if (lose!=0) sound::FreeChunk(lose);
	if (notalone!=0) sound::FreeChunk(notalone);
#endif

}

void media::LoadStuff() {
#ifndef NOSOUND
	gamemusic = sound::LoadMusic("data/llydian.ogg");
	browseclick = sound::LoadWAV(DATA_BROWSECLICK_WAV);
	rotate = sound::LoadWAV(DATA_ROTATE_WAV);
	launch = sound::LoadWAV(DATA_LAUNCH_WAV);
	select = sound::LoadWAV(DATA_SELECT_WAV);
	fossil = sound::LoadWAV(DATA_FOSSIL_WAV);

	win = sound::LoadWAV(DATA_WIN_WAV);
	lose = sound::LoadWAV(DATA_LOSE_WAV);

	notalone = sound::LoadWAV(DATA_NOTALONE_WAV);
#endif
}

