//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////



#ifndef IMLIB2_GRAPH_H
#define IMLIB2_GRAPH_H

#include <SDL.h>
#include <SDL_image.h>
#include "text.h"
#include "graph.h"

#ifdef WIN32
using namespace std;
#endif

typedef void(*void_func)(void);

class Csdl_graph : public Cgraph
{
public:
	int graph_setup(					int *, char ***, int, int );
	void graph_set_loop_func(			loop_func_t );
	void graph_set_click_func(			click_func_t );
	void graph_set_key_press_func(		key_press_func_t );
	void graph_set_reload_func(         void_func );
	ulong graph_get_time(				void );
	void graph_delay(					long );
	void graph_refresh(					void );
	void graph_reload(					void );
	void graph_start(					void );
	void graph_clear(					void );
	void graph_clear_rect(				int, int, int, int );
	void graph_clear_rect_perm(			int, int, int, int );
	void graph_draw(					int, int, int );
	void graph_draw_perm(				int, int, int, int, 
											int, int, int );
	void graph_draw_pixmap(				int, int, int, int, 
											int, int, int, long );
	void graph_draw_rect(				int, int, int, int );
	void graph_copy_area(				int, int, int, int, 
											int, int );
	void graph_erase_rect(				int, int, int, int );
	void graph_erase_pixmap(			int, int, int );
	void graph_shutdown(				void );
	int graph_main_height(				void );
	int graph_main_width(				void );
	void graph_set_background(			int );
	class CText * graph_lo_font(		void );
	class CText * graph_hi_font(		void );
	Csdl_graph(							void );
	void game_loop(						void );
private:
	
	void draw_background(				void );
	void get_std_resolution(			int, int, int&, int& );

	// Main canvas size
	int reqWidth;
	int reqHeight;
	int mainWidth;
	int mainHeight;
	int mainXOffset;
	int mainYOffset;

	click_func_t clickFunc;
	key_press_func_t keyPressFunc;
	loop_func_t loopFunc;
	void_func reloadFunc;

	CText *fLoFont;
	CText *fHiFont;

};
#endif
