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

#ifndef DECODE_H
#define DECODE_H

/// This class implements decode40 and decode80 methods
/**
	This class is used as a base-class for the various Dune2 Filetypes (*.shp,*.cps,*.wsa).
	It implements the decoding stuff needed by all this classes.
*/
class Decode
{
public:
	Decode();
	~Decode();

protected:

	void memcpy_overlap(unsigned char *dst, unsigned char *src, unsigned cnt);
	int decode40(unsigned char *image_in, unsigned char *image_out);
	int decode80(unsigned char *image_in, unsigned char *image_out,unsigned checksum);
};

#endif // DECODE_H
