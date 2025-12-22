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

#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include <string>
#include <list>

/**
	This function finds all the files in the specified directory with the specified
	extension.
	\param	directory	the directory name
	\param	extension	the extension to search for
	\param	IgnoreCase	true = extension comparison is case insensitive
	\return	a list of all the files with the specified extension
*/
std::list<std::string> GetFileNames(std::string directory, std::string extension, bool IgnoreCase = false);


/**
	This function tests if a file exists
	\param path	path to the file
	\return true if it exists, false if not
*/
bool ExistsFile(std::string path);

#endif //FILESYSTEM_H
