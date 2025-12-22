/* g_ui.c */
#include <graphics/gfx.h>
#include <clib/graphics_protos.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "g_video.h"
#include "g_ui.h"
#include "g_headers.h"

extern struct RastPort rp_menu;
extern struct BitMap tile_bm[NUMBER_OF_TILE_BITMAPS];
extern struct menu_element_struct m_elements[10];
extern struct menu_screen_struct m_screens[6];


void draw_menu_screen(int m)
{
	int i, y, length;

	SetAPen(&rp_menu, 1);
	// title
	Move(&rp_menu, m_screens[m].x, m_screens[m].y - 24);
	length = strlen(m_screens[m].title);
	Text(&rp_menu, m_screens[m].title, length);
	// elements
	y = m_screens[m].y;
	for(i = 0; i < m_screens[m].num_elements; i++) {
		if(m_elements[m_screens[m].elements[i]].enabled) {
			Move(&rp_menu, m_screens[m].x, y);
			length = strlen(m_elements[m_screens[m].elements[i]].str);
			if(m_screens[m].update_items) Text(&rp_menu, m_elements[m_screens[m].elements[i]].str, length);
			if(i == m_screens[m].cur_element) {
				if(m_screens[m].update_selector) {
					// arrow selector
					SetAPen(&rp_menu, 0);
					BltPattern(&rp_menu, NULL, m_screens[m].x - 12, m_screens[m].y - 7, m_screens[m].x - 4, 199, 0);
					SetAPen(&rp_menu, 1);
					Move(&rp_menu, m_screens[m].x - 12, y);
					Text(&rp_menu, ">", 1);
				}
			}
			y+=m_screens[m].pixel_height;
		}
	}
}

void draw_menu(int m)
{
	if(m_screens[m].update_background) {
		SetAPen(&rp_menu, 0);
		BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);
	}
	draw_menu_screen(m);

	SetAPen(&rp_menu, 0);

	m_screens[m].update_items = 0;
	m_screens[m].update_selector = 0;
	m_screens[m].update_background = 0;
}
