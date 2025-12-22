/*  The Blue Mango Quest : Mango Peeler
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#define N_THUMBS 12
#define N_BONUS 20
#define N_SPECIAL 20

#define SHX_INC_1 0
#define SHX_INC_10 10
#define SHX_DEC_1 1
#define SHX_DEC_10 11

// this is just a number I bump when a change in the save code makes
// the old maps no longer usable.
// The number itself has no importance.
#define READ_COMPAT_NUMBER 1
#define WRITE_COMPAT_NUMBER 2

enum CODE_RETOUR { ARGH, OK };
SDL_Surface *charge_image(const char *chemin);
SDL_Surface *chargeStretch(const char *chemin, int xVoulu, int yVoulu);
