/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

/*
 * A load / save dialog box. This window displays the contents of the directory
 * which the user can browse and double click or enter the name of the file they 
 * would like to load or save to. If the user double clicks on a directory then
 * the directory is changed, of if a file is clicked then enter the file in the 
 * botton textbox.
 * 
 * When the load / save button is clicked callback to the calling method with the 
 * file the user entered.
 */
 
#ifndef FILELOADSAVEBOX_H
#define FILELOADSAVEBOX_H

// System includes
#include <dirent.h>			// Read the information about the directory contents
#include <sys/stat.h>		// Check the type of item found in the directory i.e. file / folder
#include <unistd.h>


// Game includes
#include "General.h"
#include "CallBack.h"
#include "Window.h"
#include "WindowManager.h"

// Defines if the window is a load or a save dialog box
enum FileLoadSaveType
{
	LST_LOAD,
	LST_SAVE
};

class FileLoadSaveBox : public Window
{
private:

	FileLoadSaveType type;	// Type of dialog the window is representing i.e. load / save

	Label* lblMsg;			// The label at the top of the window - changed depending on type of window
	TextBox* txtFile;		// The file the user whats to save / load to / from				
	ListBox* listFiles;		// List box of the 
	
	char directory[255];	// Stores what the current directory is
	
	Callback1Base<const char*>* clickEvent;
	
	void refreshFileList();
	
	// Events
	void listDoubleClick();
	void load();
	void cancel();
		
public:

	FileLoadSaveBox(SDL_Surface* screen, Callback1Base<const char*>& clickEvent, FileLoadSaveType type, const char* filename);
	virtual ~FileLoadSaveBox();

};

#endif // FILELOADSAVEBOX_H
