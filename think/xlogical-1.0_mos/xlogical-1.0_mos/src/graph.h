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



#ifndef GRAPH_H
#define GRAPH_H

#include "defs.h"
#include "graph_images.h"
#include "graph_keysyms.h"

typedef void(*void_func)(						void);
typedef void(*click_func_t)(					int, int, int );
typedef void(*loop_func_t)(						void );
typedef void(*key_press_func_t)(				keysyms );

class Cgraph
{
public:
	virtual int graph_setup(					int *, char ***, int, int )=0;
	virtual void graph_set_loop_func(			loop_func_t )=0;
	virtual void graph_set_click_func(			click_func_t )=0;
	virtual void graph_set_key_press_func(		key_press_func_t )=0;
	virtual void graph_set_reload_func(			void_func )=0;
	virtual ulong graph_get_time(				void )=0;
	virtual void graph_delay(					long )=0;
	virtual void graph_refresh(					void )=0;
	virtual void graph_reload(					void )=0;
	virtual void graph_start(					void )=0;
	virtual void graph_clear(					void )=0;
	virtual void graph_clear_rect(				int, int, int, int )=0;
	virtual void graph_clear_rect_perm(			int, int, int, int )=0;
	virtual void graph_erase_rect(				int, int, int, int )=0;
	virtual void graph_erase_pixmap(			int, int, int )=0;
	virtual void graph_draw(					int, int, int ) = 0;
	virtual void graph_set_background(			int )=0;
	virtual void graph_draw_perm(				int, int, int, int, 
														int, int, int )=0;
	virtual void graph_draw_pixmap(				int, int, int, int, 
													int, int, int, long )=0;
	virtual void graph_draw_rect(				int, int, int, int )=0;
	virtual void graph_copy_area(				int, int, int, int, 
													int, int )=0;
	virtual void graph_shutdown(				void )=0;
	virtual int graph_main_height(				void )=0;
	virtual int graph_main_width(				void )=0;
	virtual class CText * graph_lo_font(		void )=0;
	virtual class CText * graph_hi_font(		void )=0;

};
extern Cgraph *graphDriver;

#endif
// $Id: graph.h,v 1.7 2001/07/31 20:54:54 tom Exp $
//
// $Log: graph.h,v $
// Revision 1.7  2001/07/31 20:54:54  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.6  2001/03/15 09:40:44  tom
// added new callback that is called after video driver has been reloaded
//
// Revision 1.5  2001/02/16 20:59:55  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2000/10/06 19:29:06  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.3  2000/10/01 19:35:54  brown
// Background fixes
//
// Revision 1.2  2000/10/01 19:28:01  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.14  2000/02/12 22:54:51  tom
// Did a bunch of menu fixing up... and got rid of menu stuff in graph_gtk.
//
// Revision 1.13  2000/01/01 21:51:19  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.12  1999/12/25 08:18:34  tom
// Added "Id" and "Log" CVS keywords to source code.
//
