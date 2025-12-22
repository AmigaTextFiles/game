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

#include <misc/FileSystem.h>

#include <stdio.h>

#ifdef _WIN32
#include <io.h>
#include <direct.h>
#else
#include <dirent.h>
#include <errno.h>
#endif

std::list<std::string> GetFileNames(std::string directory, std::string extension, bool IgnoreCase)
{

	std::list<std::string> Files;

	if(IgnoreCase == true) {
		std::transform(extension.begin(), extension.end(), extension.begin(), tolower);
	}

#ifdef _WIN32

	long hFile;

	_finddata_t fdata;

	std::string searchString = directory + "*";

	if ((hFile = (long)_findfirst(searchString.c_str(), &fdata)) != -1L) {
		while(_findnext(hFile, &fdata) == 0) {
			std::string Filename = fdata.name;
			unsigned int dotposition = Filename.find_last_of('.');

			if(dotposition == std::string::npos) {
				continue;
			}

			std::string ext = Filename.substr(dotposition+1);

			if(IgnoreCase == true) {
				std::transform(ext.begin(), ext.end(), ext.begin(), tolower);
			}

			if(ext == extension) {
				Files.push_back(Filename);
			}
		}

		_findclose(hFile);
	}

#else

	DIR * dir = opendir(directory.c_str());
	dirent *curEntry;

	if(dir == NULL) {
		return Files;
	}

	errno = 0;
	while((curEntry = readdir(dir)) != NULL) {
			std::string Filename = curEntry->d_name;
			size_t dotposition = Filename.find_last_of('.');

			if(dotposition == std::string::npos) {
				continue;
			}

			std::string ext = Filename.substr(dotposition+1);

			if(IgnoreCase == true) {
				std::transform(ext.begin(), ext.end(), ext.begin(), tolower);
			}

			if(ext == extension) {
				Files.push_back(Filename);
			}
	}

	if(errno != 0) {
		perror("readdir()");
	}

	closedir(dir);

#endif

	return Files;

}

bool ExistsFile(std::string path)
{
	// try opening the file
	FILE* fp = fopen(path.c_str(),"r");

	if(fp == NULL) {
		return false;
	}

	fclose(fp);
	return true;
}
