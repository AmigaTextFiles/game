/*
Copyright (C) 2004 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "filesAndDirectories.h"

void setFileImage(File *file)
{
	char string[1024];
	char *realName, *previousName;

	strcpy(string, file->name);

	realName = strtok(string, ".");
	previousName = realName;

	while (realName != NULL)
	{
		previousName = realName;
		realName = strtok(NULL, ".");
	}

	strcpy(string, previousName);
	
	char *spriteName = engine.getProperty(string);

	if (spriteName)
		file->sprite = graphics.getSprite(spriteName, true);
}

void informDirSetup(char *name)
{
	graphics.clearScreen(graphics.black);
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	graphics.setFontSize(2);
	graphics.drawString(400, 250, TXT_CENTERED, graphics.screen, "Setting up directories...");
	graphics.setFontSize(0);
	graphics.drawString(400, 280, TXT_CENTERED, graphics.screen, name);

	graphics.updateScreen();

}

void buildFileList(char *dirName, int depth)
{
	Sprite *dirSprite[6];

	dirSprite[0] = graphics.getSprite("BlueDirectory", true);
	dirSprite[1] = graphics.getSprite("GreenDirectory", true);
	dirSprite[2] = graphics.getSprite("RedDirectory", true);
	dirSprite[3] = graphics.getSprite("YellowDirectory", true);
	dirSprite[4] = graphics.getSprite("VioletDirectory", true);
	dirSprite[5] = graphics.getSprite("GreyDirectory", true);

	Sprite *fileSprite = graphics.getSprite("Binary", true);

	depth++;
	if (depth > 3)
		return;

	DIR *dirp, *dirp2;
	dirent *dfile;
	char filename[PATH_MAX];

	File *file;

	dirp = opendir(dirName);

	if (dirp == NULL)
	{
		debug(("%s: Directory does not exist or is not accessable\n", dirName));
		return;
	}
	
	informDirSetup(dirName);

	Directory *homeDirectory = gameData.addDirectory(dirName);

	while ((dfile = readdir(dirp)))
	{
		if (dfile->d_name[0] == '.')
			continue;

#ifndef __MORPHOS__
		sprintf(filename, "%s/%s", dirName, dfile->d_name);
#else
		sprintf(filename, "%s%s", dirName, dfile->d_name);
#endif

		dirp2 = opendir(filename);

		if (dirp2)
		{
			closedir(dirp2);
			buildFileList(filename, depth);
		}
		else
		{
			file = new File();
			strncpy(file->name, dfile->d_name, 49);
			file->homeDirectory = homeDirectory;
			file->sprite = fileSprite;
			setFileImage(file);
			if (!file->homeDirectory->addFile(file))
				break;
		}
	}

	closedir(dirp);

	homeDirectory->sprite = dirSprite[rand() % 6];
}

void setupActiveDirectories(int number)
{
	gameData.buildActiveDirList(number);

	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

	Directory *dir = (Directory*)gameData.directoryList.getHead();

	int x, y;

	while (dir->next != NULL)
	{
		dir = (Directory*)dir->next;

		if ((dir->active) && (dir->x == -1))
		{
			dir->reset();

			File *file = (File*)dir->fileList.getHead();

			while (file->next != NULL)
			{
				file = (File*)file->next;
				file->stolen = false;
			}
			
			while (true)
			{
				x = Math::rrand(2, 3);
				y = Math::rrand(2, 3);

				if (gameData.map[x][y] == 0)
				{
					gameData.map[x][y] = 1;

					dir->x = x * 160;
					dir->y = y * 120;

					graphics.setFontSize(0);
					graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

					if (dir->fileCount <= 10)
						graphics.setFontColor(0xff, 0xff, 0x00, 0x00, 0x00, 0x00);
					if (dir->fileCount <= 5)
						graphics.setFontColor(0xff, 0x00, 0x00, 0x00, 0x00, 0x00);

					dir->label = graphics.getString(false, " %s (%d)", dir->name, dir->fileCount);
					break;
				}
			}
		}
	}
}

void doDirectories()
{
	gameData.activeDirs = 0;

	Directory *dir = (Directory*)gameData.directoryList.getHead();

	while (dir->next != NULL)
	{
		dir = (Directory*)dir->next;

		if (dir->label == NULL)
		{
			graphics.setFontSize(0);
			graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

			if (dir->fileCount <= 10)
				graphics.setFontColor(0xff, 0xff, 0x00, 0x00, 0x00, 0x00);
			if (dir->fileCount <= 5)
				graphics.setFontColor(0xff, 0x00, 0x00, 0x00, 0x00, 0x00);
			dir->label = graphics.getString(false, " %s (%d)", dir->name, dir->fileCount);
		}

		if (dir->active)
		{
			gameData.activeDirs++;

			graphics.blit(dir->sprite->getCurrentFrame(), dir->x, dir->y, graphics.screen, true);
			graphics.blit(dir->label, dir->x, dir->y + 35, graphics.screen, true);
			
			if (dir->fileCount == 0)
			{
				for (int i = 0 ; i < 10 ; i++)
					addDirectoryDeathParticles(dir->x + Math::rrand(-25, 25), dir->y + Math::rrand(-25, 25));
				dir->active = false;
				gameData.score -= 5000;
				gameData.dirsLost++;
				gameData.roundDirsLost++;
				audio.playSound(SND_DIRDESTROYED1 + rand() % 6, 1);
				gameData.map[dir->x / 160][dir->y / 120] = 0;
				dir->x = dir->y = -1;
			}
		}
	}
}
