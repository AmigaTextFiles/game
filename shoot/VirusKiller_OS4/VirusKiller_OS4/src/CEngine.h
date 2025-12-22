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

class Engine {

	private:

		SDL_Event event;
		signed char frameLoop;
		int mouseX, mouseY;

		// Time Difference
		unsigned int time1;
		unsigned int time2;
		float timeDifference;

		char lastKeyPressed[25];

	public:

		char keyState[350];
		char mouseLeft, mouseRight, mouseMiddle;
		char mouseWheelUp, mouseWheelDown;
		
		char lastInput[50];

		char language[5];
		
		bool allowQuit;

		bool paused;

		char userHomeDirectory[PATH_MAX];

		int useAudio;
		int fullScreen;
		int skill;

		SDL_RWops *sdlrw;

		unsigned char *binaryBuffer; // used for unzipping
		unsigned char *dataBuffer; // used for unzipping
		
		List widgetList;
		List localeList;

		Widget *highlightedWidget;
		
		Pak pak;
		
		List defineList;

	Engine();
	void destroy();
	void getInput();
	int getMouseX();
	int getMouseY();
	void setMouse(int x, int y);
	bool userAccepts();
	void doPause();
	void clearCheatVars();
	bool compareLastKeyInputs();
	void addKeyEvent();
	void flushInput();
	void clearInput();
	void setUserHome(char *path);
	bool unpack(char *filename, int fileType);
	bool loadData(char *filename);
	void reportFontFailure();
	void setLocale(char *language);
	void setLocaleTranslationPath(char *path);
	void freeLocaleInfo();
	bool getLocaleInformation(char *section);
	char *translate(char *key);
	void setPlayerPosition(int x, int y, int limitLeft, int limitRight, int limitUp, int limitDown);
	int getFrameLoop();
	void doFrameLoop();
	void doTimeDifference();
	float getTimeDifference();
	void resetTimeDifference();
	void setInfoMessage(char *message, int priority, int type);
	void deleteWidgets();
	void addWidget(Widget *widget);
	bool loadWidgets(char *filename);
	Widget *getWidgetByName(char *name);
	void showWidgetGroup(char *groupName, bool show);
	void enableWidgetGroup(char *groupName, bool show);
	void showWidget(char *name, bool show);
	void enableWidget(char *name, bool enable);
	void setWidgetVariable(char *name, int *variable);
	void setWidgetVariable(char *name, char *variable);
	bool widgetChanged(char *name);
	void highlightNextInputWidget();
	void highlightWidget(int dir);
	void highlightWidget(char *name);
	int processWidgets();
	bool loadDefines();
	int getValueOfDefine(char *word);
	char *getProperty(char *word);
	int getValueOfFlagTokens(char *line);

};
