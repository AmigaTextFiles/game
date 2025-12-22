/*	Map Info: Parse entity and texture info from Quake 2 map files.
	Copyright 2010 C.D. Reimer (Email: webmaster@cdreimer-associates.com)
	
	Quake 2 is owned by Id Software LLC.  Other than glancing at the map
	file to determine parsing pattern, Map Info does not incoporate any
	code written by Id Software under the GNU General Public License.
	http://www.idsoftware.com/business/idtech2/

	This file is part of Map Info.

    Map Info is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Map Info is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Map Info.  If not, see <http://www.gnu.org/licenses/>.
    
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "mapinfo.h"


/* parse line to extract entity into line buffer */
void ParseEntity(char *line, char *buffer) {

	/* skips over text at beginning of line to find first space character */
	while (!isspace((int)*line++))
		;
	
	/* advance by one to avoid first quote mark  */
	line++;

	/* output classname to line buffer until second quote is found */
	while (*line != '\"')
		*buffer++ = *line++;

}


/* parse line to extract texture name into line buffer */
void ParseTexture(char *line, char *buffer)
{

	/* skips over text at beginning of line to find first alpha character */
	while (!isalpha((int)*line++))
		;
	
	/* subtract by one to recover alpha character lost in previous loop */
	line--;

	/* output texture name to line buffer until next space is found */
	while (!isspace((int)*line))
			*buffer++ = *line++;

}
