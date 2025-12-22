/*
Copyright (C) 2003 Parallel Realities

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

class Engine {

	private:

		SDL_Event event;
		int mouseX, mouseY;

	public:

		char keyState[350];
		char mouseLeft, mouseRight;

		char language[5];

		bool paused;

		char userHomeDirectory[PATH_MAX];

		int useAudio;
		int fullScreen;

		SDL_RWops *sdlrw;

		char *binaryBuffer; // used for unzipping
		char *dataBuffer; // used for unzipping
		
		List widgetList;

		Widget *highlightedWidget;
		
		List defineList;

	Engine();
	void destroy();
	void getInput();
	int getMouseX();
	int getMouseY();
	void setMouse(int x, int y);
	bool userAccepts();
	void doPause();
	void flushInput();
	void clearInput();
	void setUserHome(char *path);
	bool unpack(char *filename, int fileType);
	bool loadData(char *filename);
	void reportFontFailure();
	void freeLocaleInfo();
	bool getLocaleInformation(char *section);
	char *translate(char *key);
	void deleteWidgets();
	void addWidget(Widget *widget);
	bool loadWidgets(char *filename);
	Widget *getWidgetByName(char *name);
	void showWidgetGroup(char *groupName, bool show);
	void enableWidgetGroup(char *groupName, bool show);
	void showWidget(char *name, bool show);
	void enableWidget(char *name, bool enable);
	void setWidgetVariable(char *name, int *variable);
	bool widgetChanged(char *name);
	void highlightWidget(int dir);
	void highlightWidget(char *name);
	int checkMouseWidgetCollisions();
	int processWidgets();
	bool loadDefines();
	int getValueOfDefine(char *word);
	int getValueOfFlagTokens(char *line);

};
