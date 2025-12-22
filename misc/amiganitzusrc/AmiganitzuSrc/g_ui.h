/* g_ui.h */

#ifndef G_UI_H
#define G_UI_H


struct menu_element_struct
{
	char	str[48];
	int		enabled;
};

struct menu_screen_struct
{
	int			x, y;
	int			pixel_height;
	int			num_elements;
	int			cur_element;
	int			update_items;
	int			update_selector;
	int			update_background;
	int			elements[16];
	char		title[48];
};

void draw_menu_screen(int);
void draw_menu(int);

#endif

