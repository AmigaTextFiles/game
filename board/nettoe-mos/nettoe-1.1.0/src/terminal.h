/* netToe Version 1.1.0
 * Release date: 22 July 2001
 * Copyright 2000,2001 Gabriele Giorgetti <g.gabriele@europe.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


enum {
	ATTRIB_RESET, ATTRIB_BRIGHT, ATTRIB_DIM, ATTRIB_UNDERLINE,
	ATTRIB_BLINK, ATTRIB_REVERSE, ATTRIB_HIDDEN
};

enum {
	COLOR_BLACK, COLOR_RED, COLOR_GREEN,
	COLOR_YELLOW, COLOR_BLUE, COLOR_MAGENTA,
	COLOR_CYAN, COLOR_WHITE
};

void nettoe_term_clear (void);
void nettoe_term_set_color (int fg, int bg, int attrib);
void nettoe_term_set_default_color (void);
void nettoe_term_reset_color (void);

