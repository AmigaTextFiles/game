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
 
#include "FileLoadSaveBox.h"

FileLoadSaveBox::FileLoadSaveBox(SDL_Surface* screen, Callback1Base<const char*>& clickEvent,  FileLoadSaveType type, const char* filename) : Window(screen)
{
	
	char * simpleFilename = NULL;
	
	this->type = type;
	this->clickEvent = clickEvent.clone();
	
	// reset the directory
	this->directory[0] = 0;
	
	// Check if there are any directory listing on the filename passed in
	if (filename != NULL)
	{
		char* lastdir = strrchr(filename, '/');
		if (lastdir == NULL)
		{
			lastdir = strrchr(filename, '\\');
		}
		
		// If we have found a directory then split it up 
		if (lastdir != NULL)
		{
			strcpy(this->directory, filename);
			this->directory[lastdir - filename] = 0;
			this->directory[strlen(filename)+1] = 0;
			simpleFilename = &this->directory[lastdir - filename + 1];
		}
		else
		{
			// No directory information just copy the filename
			simpleFilename = (char*)filename;
		}
	}
	
	// If the directory hasn't been set then default to the current one
	if (this->directory[0] == 0)
		getcwd(this->directory, 255);
	
	// Default the window to zero until we have set the size
	int winWidth = 500;
	int winHeight = 400;
	int buttonWidth = 80;
	int buttonHeight = 20;
	int controlGap = 5;
	int startPosx = (int)(APP_WIDTH - winWidth) / 2;
	int startPosy = (int)(APP_HEIGHT - winHeight) / 2;
	Rect windowSize(startPosx, startPosy, startPosx + winWidth, startPosy + winHeight);
	Window::setSize(windowSize);
	
	// Colours
	Uint32 activeColour 	= SDL_MapRGB(screen->format, 0x33, 0x33, 0x33);
	Uint32 inActiveColour 	= SDL_MapRGB(screen->format, 0x99, 0x99, 0x99);
	Uint32 buttonColour 	= SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE);
	Uint32 windowColour		= SDL_MapRGB(screen->format, 0x9A, 0x35, 0x68);

	// Add a label to tell what the hell is going on in here.
    Label* textLabel = new Label(Point(controlGap, controlGap), Point(winWidth - 2 * controlGap, 2 * controlGap));
    if (this->type == LST_LOAD)
	    textLabel->setLabelText("Enter filename to load");
	else
	    textLabel->setLabelText("Enter filename to save to");
    Window::addControl(textLabel);
    
    // Add a list box
    Callback0<FileLoadSaveBox> listDoubleClickCallBack(*this,&FileLoadSaveBox::listDoubleClick);
	
	Rect rList(controlGap, 25 , winWidth - controlGap, winHeight - 2 * buttonHeight - 3 * controlGap);
	this->listFiles = new ListBox(rList);
	FileLoadSaveBox::refreshFileList();
	this->listFiles->addDoubleClickEvent(listDoubleClickCallBack);
	this->listFiles->setActiveColour(activeColour);
	this->listFiles->setHighLightColour(inActiveColour);
	Window::addControl(this->listFiles);
	
	// Add the controls we need for the text box.
	Rect rtextBox(controlGap, rList.bottomRight.y + controlGap, winWidth - controlGap, rList.bottomRight.y + controlGap + 15);
    this->txtFile = new TextBox(rtextBox);
    this->txtFile->setText(simpleFilename);
    this->txtFile->setTextLimit(100);
    this->txtFile->setActiveColour(activeColour);
    this->txtFile->setInActiveColour(activeColour);
    this->txtFile->setActive(true);
    Window::addControl(this->txtFile);
    
	// Add a button for the cancel
	Rect rbuttonCancel(rtextBox.bottomRight.x - buttonWidth, rtextBox.bottomRight.y + controlGap , rtextBox.bottomRight.x, rtextBox.bottomRight.y + controlGap + buttonHeight);
	Callback0<FileLoadSaveBox> cancelCallBack(*this,&FileLoadSaveBox::cancel);
    Button* buttonCancel = new Button(cancelCallBack, "Cancel", rbuttonCancel);
    buttonCancel->setAccessKey(SDLK_ESCAPE);
    buttonCancel->setActiveColour(buttonColour);
    Window::addControl(buttonCancel);

	// Add a button for the ok
	Rect rbuttonOK(rbuttonCancel.topLeft.x - controlGap - buttonWidth, rbuttonCancel.topLeft.y, rbuttonCancel.topLeft.x - controlGap, rbuttonCancel.bottomRight.y);
	Callback0<FileLoadSaveBox> addScoreCallBack(*this,&FileLoadSaveBox::load);
    Button* button1 = new Button(addScoreCallBack, "Ok", rbuttonOK);
    button1->setAccessKey(SDLK_RETURN);
    button1->setActiveColour(buttonColour);
    Window::addControl(button1);
    
    // Add a label to report error messages to
    this->lblMsg = new Label(Point(controlGap, rbuttonOK.topLeft.y), Point(rbuttonOK.topLeft.x - controlGap, rbuttonOK.topLeft.y + 10));
    this->lblMsg->setLabelText("");
    Window::addControl(this->lblMsg);
    
    // Set the background colour to the red
   	Window::setBackgroundColour(windowColour);
   	Window::setInnerBevel(true);
	Window::setBorderThickness(2);
}

FileLoadSaveBox::~FileLoadSaveBox()
{
	
}

void FileLoadSaveBox::refreshFileList()
{
	struct dirent *entryp = NULL;
	struct stat fileStat;
	DIR *dp = NULL;
	int max_items = 1024;
	char* dirs[max_items];
	char* files[max_items];
	int dirCount = 0;
	int fileCount = 0;
	char fileBuffer[255];
	int loop;
	
	if ((dp = opendir(directory)) == NULL)
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "FileLoadSaveBox:: Failed to open %s directory for reading game files", this->directory);	
	
	// Find all of the files / directories in the current directory
	while ((entryp = readdir(dp)) != NULL)
	{
		// Ignore . we don't really need it.
		if (strcmp(entryp->d_name,".") == 0 )
			continue;
		
		// Add .. without checking because we can't get any stats for these.
		if (strcmp(entryp->d_name,"..") == 0)
		{
			if (dirCount < max_items)
				dirs[dirCount++] = strdup(entryp->d_name);
			else
				Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Found dir - but ran out of space");	
			continue;
		}
		
		sprintf(fileBuffer, "%s/%s", this->directory, entryp->d_name);
		
		// Find the details for the entry i.e. if a file or directory
		if ( -1 ==  stat (fileBuffer, &fileStat))
		{
			// Couldn't find the stats so default as a file.
	    	if (fileCount < max_items)
				files[fileCount++] = strdup(entryp->d_name);
			else
				Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Found file - but ran out of space");	

			continue;
		}
		
		// figure out what type the entry is.
		if (S_ISDIR(fileStat.st_mode))
		{
			if (dirCount < max_items)
				dirs[dirCount++] = strdup(entryp->d_name);
			else
				Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Found dir - but ran out of space");	
		}
		else if (S_ISREG(fileStat.st_mode))
		{
			if (fileCount < max_items)
				files[fileCount++] = strdup(entryp->d_name);
			else
				Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Found file - but ran out of space");	
		}
	}
	closedir(dp);
	
	this->listFiles->clearList();
	
	Log::Instance()->log("Dirs before sort");
	for (loop = 0; loop < dirCount; loop++)
	{
		Log::Instance()->log(SV_DEBUG, SV_DEBUG, "%d, %s",loop , dirs[loop]);
	}
	
	// Sort both lists before adding to the listbox
	qsort (dirs, dirCount, sizeof(int), compareChars);
	qsort (files, fileCount, sizeof(int), compareChars);
	
	Log::Instance()->log("Dirs after sort");

	
	// Add all of the directories into the list box
	// Build up the directory entries first
	for (loop = 0; loop < dirCount; loop++)
	{
		Log::Instance()->log("%d, %s",loop , dirs[loop]);
		this->listFiles->addItem(dirs[loop],dirs[loop]);
	}
	
	// Do the same for the files
	for (loop = 0; loop < fileCount; loop++)
		this->listFiles->addItem(files[loop],files[loop]);
	
	// Make sure we clean up the any items
	for (loop = 0; loop < dirCount; loop++)
		delete dirs[loop];
	
	for (loop = 0; loop < fileCount; loop++)
		delete files[loop];
}

void FileLoadSaveBox::listDoubleClick()
{
	const char* value = this->listFiles->getSelectedValue();

	// Move up one directory
	if (strcmp(value, "..") == 0)
	{
		char* lastdir = strrchr(this->directory, '/');
		if (lastdir == NULL)
		{
			lastdir = strrchr(this->directory, '\\');
		}
		
		// if we have found the correct node then set it to null	
		if (lastdir != NULL)
			*lastdir = 0;

		FileLoadSaveBox::refreshFileList();
		return;
	}

	// For now assume that anything without a . is a directory and try to change into it.
	// Might want to add a check for the directory and if not then don't change and do
	// the one below
	if (strchr(value, '.') == NULL)
	{
		strcat(directory, "/");
		strcat(directory, value);
		FileLoadSaveBox::refreshFileList();
	}
	else
	{
		this->txtFile->setText((char *)value);
	}
}

void FileLoadSaveBox::load()
{
	// Clear out the error messages
	this->lblMsg->setLabelText("");
			
	// Check the filename is valid and if so then call the clickEvent
	// otherwise prompt a message to say that the file doesn't exist etc.
	const char* filename = this->txtFile->getText();
	
	// Prepend the direcotory onto the filename;
	char fullFilename[512];
	sprintf(fullFilename, "%s/%s", this->directory, filename);
	
	if (this->type == LST_LOAD)
	{
		// Check that there is text in the filename
		if (!strcmp(filename, ""))
		{	
			this->lblMsg->setLabelText("Please enter a file");
			return;
		}
			
		// Also check the disk to see if the file exists
		if (!fileExist(fullFilename))
		{	
			this->lblMsg->setLabelText("File not found");
			return;
		}
	}
	
	
	// Fire the filename chosen back to the calling code
	if (this->clickEvent)
		(*this->clickEvent)(fullFilename);
		
	FileLoadSaveBox::cancel();
}

void FileLoadSaveBox::cancel()
{
	WindowManager::Instance()->remove(this);
}

