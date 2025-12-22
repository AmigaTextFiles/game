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

#include "headers.h"

Engine::Engine()
{
	for (int i = 0 ; i < 350 ; i++)
		keyState[i] = 0;
		
	strcpy(lastInput, "");

	// Mouse stuff
	mouseLeft = mouseRight = mouseMiddle = 0;
	mouseWheelUp = mouseWheelDown = 0;

	strcpy(lastKeyPressed, "");

	#if USEPAK
		fullScreen = 1;
	#else
		fullScreen = 0;
	#endif

	useAudio = 2;

	highlightedWidget = NULL;

	// Default Language is English
	strcpy(language, "en");

	dataBuffer = NULL;
	binaryBuffer = NULL;

	// Timer
	time1 = time2 = 0;
	timeDifference = 0;
	
	pak.setPakFile(PAKFULLPATH);
	
	defineList.clear();
	
	allowQuit = false;
}

void Engine::destroy()
{
	debug(("engine: free locale\n"));
	freeLocaleInfo();
	debug(("engine: free widgets\n"));
	deleteWidgets();

	debug(("engine: free databuffer\n"));
	delete dataBuffer;
	debug(("engine: free binarybuffer\n"));
	delete binaryBuffer;

	debug(("Clearing Define List...\n"));
	defineList.clear();
}

void Engine::addKeyEvent()
{
	char line[50];
	strcpy(line, lastInput);
	int size = strlen(line);

	if (strlen(lastKeyPressed) == 1)
	{
		if (size < 20)
		{
			strcat(line, lastKeyPressed);
			if ((keyState[SDLK_LSHIFT]) || (keyState[SDLK_RSHIFT]))
			{
				if ((line[size] >= 97) && (line[size] <= 122))
					line[size] -= (97 - 65);
			}
		}
	}
	else
	{
		if (strcmp(lastKeyPressed, "backspace") == 0)
		{
			if (size > 0)
				line[size - 1] = '\0';
		}
		else if (strcmp(lastKeyPressed, "space") == 0)
		{
			if (size < 20)
				strcat(line, " ");
		}
	}

	strcpy(lastInput, line);
}

void Engine::getInput()
{
	SDL_GetMouseState(&mouseX, &mouseY);

	if (SDL_PollEvent(&event))
	{
		switch (event.type)
		{
			case SDL_QUIT:
				if (allowQuit)
					exit(0);
				break;

			case SDL_MOUSEBUTTONDOWN:
				if (event.button.button == SDL_BUTTON_LEFT) mouseLeft = 1;
				if (event.button.button == SDL_BUTTON_RIGHT) mouseRight = 1;
				if (event.button.button == SDL_BUTTON_MIDDLE) mouseMiddle = 1;
				break;

			case SDL_MOUSEBUTTONUP:
				if (event.button.button == SDL_BUTTON_LEFT) mouseLeft = 0;
				if (event.button.button == SDL_BUTTON_RIGHT) mouseRight = 0;
				break;

			case SDL_KEYDOWN:
				keyState[event.key.keysym.sym] = 1;
				strcpy(lastKeyPressed, SDL_GetKeyName(event.key.keysym.sym));
				addKeyEvent();
				break;

			case SDL_KEYUP:
				keyState[event.key.keysym.sym] = 0;
				break;

			case SDL_JOYAXISMOTION:
				if (event.jaxis.axis == 0)
				{
					if (event.jaxis.value == 0)
					{
						keyState[SDLK_LEFT] = keyState[SDLK_RIGHT] = 0;
					}
					else if (event.jaxis.value < 0)
					{
						keyState[SDLK_LEFT] = 1;
					}
					else if (event.jaxis.value > 0)
					{
						keyState[SDLK_RIGHT] = 1;
					}
				}
				else if (event.jaxis.axis == 1)
				{
					if (event.jaxis.value == 0)
					{
						keyState[SDLK_UP] = keyState[SDLK_DOWN] = 0;
					}
					else if (event.jaxis.value < 0)
					{
						keyState[SDLK_UP] = 1;
					}
					else if (event.jaxis.value > 0)
					{
						keyState[SDLK_DOWN] = 1;
					}
				}
				break;

			case SDL_JOYBUTTONDOWN:
				if (event.jbutton.button == 1)
				{
					keyState[SDLK_LCTRL] = 1;
				}
				else if (event.jbutton.button == 0)
				{
					keyState[SDLK_UP] = 1;
				}
				break;

			case SDL_JOYBUTTONUP:
				if (event.jbutton.button == 1)
				{
					keyState[SDLK_LCTRL] = 0;
				}
				else if (event.jbutton.button == 0)
				{
					keyState[SDLK_UP] = 0;
				}
				break;

			default:
				break;
		}
	}
}

int Engine::getMouseX()
{
	return mouseX;
}

int Engine::getMouseY()
{
	return mouseY;
}

void Engine::setMouse(int x, int y)
{
	SDL_WarpMouse(x, y);
}

bool Engine::userAccepts()
{
	if ((keyState[SDLK_SPACE]) || (keyState[SDLK_ESCAPE]) || (keyState[SDLK_LCTRL]) || (keyState[SDLK_RCTRL]) || (keyState[SDLK_RETURN]))
		return true;

	return false;
}

void Engine::doPause()
{
	if (keyState[SDLK_p])
	{
		paused = !paused;
		keyState[SDLK_p] = 0;
	}
}

void Engine::flushInput()
{
	while (SDL_PollEvent(&event)){}
}

void Engine::clearInput()
{
	for (int i = 0 ; i < 350 ; i++)
		keyState[i] = 0;

	mouseLeft = mouseRight = 0;
	mouseWheelUp = mouseWheelDown = 0;
}

void Engine::setUserHome(char *path)
{
	strcpy(userHomeDirectory, path);
	debug(("User Home = %s\n", path));
}

/*
Searches the pak file for the required data. When
it is found, the data is read into a character buffer.
In the case of music, the data music be written to a temporary directory
since SDL currently provides no means to load music directly from memory
*/
bool Engine::unpack(char *filename, int fileType)
{
	if (fileType == PAK_DATA)
	{
		if (dataBuffer != NULL)
			delete[] dataBuffer;

		dataBuffer = NULL;
	}
	else
	{
		if (binaryBuffer != NULL)
			delete[] binaryBuffer;

		binaryBuffer = NULL;
	}

	if (fileType != PAK_DATA)
	{
		if (!pak.unpack(filename, &binaryBuffer))
		{
			return false;
		}
	}
	else
	{
		if (!pak.unpack(filename, &dataBuffer))
		{
			return false;
		}
	}

	if ((fileType == PAK_IMG) || (fileType == PAK_SOUND))
	{
		sdlrw = SDL_RWFromMem(binaryBuffer, pak.getUncompressedSize());
		if (!sdlrw)
		{
			printf("Fatal Error: SDL_RWops allocation failed\n");
			exit(1);
		}
	}

	if ((fileType == PAK_MUSIC) || (fileType == PAK_FONT))
	{
		char tempPath[PATH_MAX];
		
		FILE *fp = NULL;

		if (fileType == PAK_MUSIC)
		{
			sprintf(tempPath, "%smusic.mod", userHomeDirectory);
			fp = fopen(tempPath, "wb");
		}

		if (fileType == PAK_FONT)
		{
			sprintf(tempPath, "%sfont.ttf", userHomeDirectory);
			fp = fopen(tempPath, "wb");
		}

		if (!fp)
		{
			return false;
		}

		fwrite(binaryBuffer, 1, pak.getUncompressedSize(), fp);
		fclose(fp);
	}

	debug(("unpack() : Loaded %s (%d)\n", filename, pak.getUncompressedSize()));

	return true;
}

bool Engine::loadData(char *filename)
{
	if (dataBuffer != NULL)
	{
		delete[] dataBuffer;
		dataBuffer = NULL;
	}
	
	#if USEPAK
		return unpack(filename, PAK_DATA);
	#endif

	FILE *fp;
	fp = fopen(filename, "rb");
	if (fp == NULL)
		return false;

	fseek(fp, 0, SEEK_END);

	int fSize = ftell(fp);

	rewind(fp);

	dataBuffer = new unsigned char[fSize];

	fread(dataBuffer, 1, fSize, fp);

	fclose(fp);

	debug(("loadData() : Loaded %s (%d)\n", filename, fSize));

	return true;
}

void Engine::reportFontFailure()
{
	printf("\nUnable to load font. The game cannot continue without it.\n");
	printf("Please confirm that the game and all required SDL libraries are installed\n");
	printf("The following information may be useful to you,\n\n");
	printf("Expected location of PAK file: %s\n", PAKFULLPATH);
	printf("Location of TMP directory: %s\n", userHomeDirectory);
	printf("\nAlso try checking http://www.parallelrealities.co.uk/virusKiller.php for updates\n\n");
	exit(1);
}

void Engine::freeLocaleInfo()
{
	localeList.clear();
}

bool Engine::getLocaleInformation(char *section)
{
	return true;
}

char *Engine::translate(char *key)
{
	if (strcmp(language, "en") == 0)
		return key;

	Data *data = (Data*)localeList.getHead();

	while (data->next != NULL)
	{
		data = (Data*)data->next;

		if (strcmp(data->key, key) == 0)
			return data->value;
	}

	printf("WARNING : No %s language entry for %s\n", language, key);

	return key;
}

void Engine::doTimeDifference()
{
	int td = (time2 - time1);
	if (td != 0)
		timeDifference =  td / 10.0;
	time1 = time2;
	time2 = SDL_GetTicks();
}

float Engine::getTimeDifference()
{
	return timeDifference;
}

void Engine::resetTimeDifference()
{
	time1 = time2 = SDL_GetTicks();
}

void Engine::deleteWidgets()
{
	widgetList.clear();

	highlightedWidget = NULL;
}

void Engine::addWidget(Widget *widget)
{
	widget->previous = (Widget*)widgetList.getTail();
	widgetList.add(widget);
}

bool Engine::loadWidgets(char *filename)
{
	deleteWidgets();

	if (!loadData(filename))
		return false;

	bool mustTranslate = false;
	if (strcmp(language, "en") != 0)
		mustTranslate = true;

	char token[50], name[50], groupName[50], label[50], options[100], *line;
	int x, y, min, max;

	int i;

	Widget *widget;

	line = strtok((char*)dataBuffer, "\n");

	while (true)
	{
		sscanf(line, "%s", token);

		if (strcmp(token, "END") == 0)
			break;

		sscanf(line, "%*s %s %s %*c %[^\"] %*c %*c %[^\"] %*c %d %d %d %d", name, groupName, label, options, &x, &y, &min, &max);

		widget = new Widget;

		i = 0;

		while (true)
		{
			if (strcmp(token, widgetName[i]) == 0)
				widget->type = i;

			if (strcmp("-1", widgetName[i]) == 0)
				break;

			i++;
		}

		if (mustTranslate)
			strcpy(label, translate(label));

		widget->setProperties(name, groupName, label, options, x, y, min, max);

		addWidget(widget);


		if ((line = strtok(NULL, "\n")) == NULL)
			break;
	}

	highlightedWidget = (Widget*)widgetList.getHead()->next;

	return true;
}

Widget *Engine::getWidgetByName(char *name)
{
	Widget *widget = (Widget*)widgetList.getHead();

	while (widget->next != NULL)
	{
		widget = (Widget*)widget->next;

		if (strcmp(widget->name, name) == 0)
			return widget;
	}

	debug(("No such widget '%s'\n", name));

	return NULL;
}

void Engine::showWidgetGroup(char *groupName, bool show)
{
	bool found = false;

	Widget *widget = (Widget*)widgetList.getHead();

	while (widget->next != NULL)
	{
		widget = (Widget*)widget->next;

		if (strcmp(widget->groupName, groupName) == 0)
		{
			widget->visible = show;
			widget->redraw();
			found = true;
		}
	}

	if (!found)
		debug(("Group '%s' does not exist\n", groupName));
}

void Engine::enableWidgetGroup(char *groupName, bool show)
{
	bool found = false;

	Widget *widget = (Widget*)widgetList.getHead();

	while (widget->next != NULL)
	{
		widget = (Widget*)widget->next;

		if (strcmp(widget->groupName, groupName) == 0)
		{
			widget->enabled = show;
			widget->redraw();
			found = true;
		}
	}

	if (!found)
		debug(("Group '%s' does not exist\n", groupName));
}

void Engine::showWidget(char *name, bool show)
{
	Widget *widget = getWidgetByName(name);
	if (widget != NULL)
	{
		widget->visible = show;
		widget->redraw();
	}
}

void Engine::enableWidget(char *name, bool enable)
{
	Widget *widget = getWidgetByName(name);
	if (widget != NULL)
	{
		widget->enabled = enable;
		widget->redraw();
	}
}

void Engine::setWidgetVariable(char *name, int *variable)
{
	Widget *widget = getWidgetByName(name);
	if (widget != NULL)
		widget->setValue(variable);
}

void Engine::setWidgetVariable(char *name, char *variable)
{
	//Widget *widget = getWidgetByName(name);
	//if (widget != NULL)
		//widget->setValue(variable);
}

bool Engine::widgetChanged(char *name)
{
	Widget *widget = getWidgetByName(name);
	if (widget != NULL)
		return widget->changed;

	return false;
}

void Engine::highlightNextInputWidget()
{
	highlightedWidget->redraw();

	while (true)
	{
		if (highlightedWidget->next != NULL)
		{
			highlightedWidget = (Widget*)highlightedWidget->next;
		}
		else
		{
			highlightedWidget = (Widget*)widgetList.getHead();
		}

		if ((highlightedWidget->enabled) && (highlightedWidget->visible) && (highlightedWidget->type == WG_INPUT))
			break;
	}

	highlightedWidget->redraw();
}

void Engine::highlightWidget(int dir)
{
	highlightedWidget->redraw();

	if (dir == 1)
	{
		while (true)
		{
			if (highlightedWidget->next != NULL)
			{
				highlightedWidget = (Widget*)highlightedWidget->next;
			}
			else
			{
				highlightedWidget = (Widget*)widgetList.getHead();
			}

			if (highlightedWidget->type == 4)
				continue;

			if ((highlightedWidget->enabled) && (highlightedWidget->visible))
				break;
		}
	}

	if (dir == -1)
	{
		while (true)
		{
			if ((highlightedWidget->previous != NULL) && (highlightedWidget->previous != (Widget*)widgetList.getHead()))
			{
				highlightedWidget = highlightedWidget->previous;
			}
			else
			{
				highlightedWidget = (Widget*)widgetList.getTail();
			}

			if (highlightedWidget->type == WG_LABEL)
				continue;

			if ((highlightedWidget->enabled) && (highlightedWidget->visible))
				break;
		}
	}

	highlightedWidget->redraw();
}

void Engine::highlightWidget(char *name)
{
	highlightedWidget = getWidgetByName(name);
}

int Engine::processWidgets()
{
	int update = 0;
	
	if (highlightedWidget->changed)
		return 3;

	if (keyState[SDLK_UP])
	{
		highlightWidget(-1);
		update = 1;
		clearInput();
	}

	if (keyState[SDLK_DOWN])
	{
		highlightWidget(1);
		update = 1;
		clearInput();
	}

	if (keyState[SDLK_LEFT])
	{
		SDL_Delay(1);

		if (highlightedWidget->type != WG_INPUT)
		{
			if (*highlightedWidget->value > highlightedWidget->min)
			{
				*highlightedWidget->value = *highlightedWidget->value - 1;
				update = 3;
				if ((highlightedWidget->type == WG_RADIO) || (highlightedWidget->type == WG_SLIDER))
					update = 1;
				highlightedWidget->changed = true;
			}

			if ((highlightedWidget->type == WG_RADIO) || (highlightedWidget->type == WG_SLIDER))
				clearInput();
		}
	}

	if (keyState[SDLK_RIGHT])
	{
		SDL_Delay(1);

		if (highlightedWidget->type != WG_INPUT)
		{
			if (*highlightedWidget->value < highlightedWidget->max)
			{
				*highlightedWidget->value = *highlightedWidget->value + 1;
				update = 3;
				if ((highlightedWidget->type == WG_RADIO) || (highlightedWidget->type == WG_SLIDER))
					update = 1;
				highlightedWidget->changed = true;
			}

			if ((highlightedWidget->type == WG_RADIO) || (highlightedWidget->type == WG_SLIDER))
				clearInput();
		}
	}

	if ((keyState[SDLK_RETURN]) || (keyState[SDLK_SPACE]))
	{
		if (highlightedWidget->value == NULL)
		{
			debug(("%s has not been implemented!\n", highlightedWidget->name));
		}
		else
		{
			if (highlightedWidget->type == WG_BUTTON)
			{
				*highlightedWidget->value = 1;
				highlightedWidget->changed = true;
			}
		}
		
		update = 2;

		flushInput();
		clearInput();
	}
	
	if (keyState[SDLK_TAB])
	{
		if (highlightedWidget->type == WG_INPUT)
		{
			highlightNextInputWidget();
			clearInput();
			update = 2;
		}
	}

	return update;
}

/*
Loads key-value defines into a linked list, comments are ignored. The defines.h file is used by the
game at compile time and run time, so everything is syncronised. This technique has the advantage of
allowing the game's data to be human readable and easy to maintain.
*/
bool Engine::loadDefines()
{
	char string[2][1024];

	if (!loadData("data/defines.h"))
		return false;

	char *token = strtok((char*)dataBuffer, "\n");

	Data *data;

	while (true)
	{
		token = strtok(NULL, "\n");
		if (!token)
			break;

		if (!strstr(token, "/*"))
		{
			sscanf(token, "%*s %s %[^\n]", string[0], string[1]);
			data = new Data();
			data->set(string[0], string[1], true);
			defineList.add(data);
		}
	}
	
	return true;
}

/*
Returns the value of a #defined value... ACTIVE is declared as 1 so it will
traverse the list and return 1 when it encounters ACTIVE. This has two advantages.
1) It makes the game data human readable and 2) It means if I change a #define in
the code, I don't have to change all the data entries too. You probably already
thought of that though... :)
*/
int Engine::getValueOfDefine(char *word)
{
	int rtn = 0;

	Data *data = (Data*)defineList.getHead();

	while (data->next != NULL)
	{
		data = (Data*)data->next;

		if (strcmp(data->key, word) == 0)
		{
			rtn = atoi(data->value);
			debug(("getValueOfDefine() : %s = %d\n", word, rtn));
			return rtn;
		}
	}

	debug(("getValueOfDefine() : %s is not defined!\n", word));
	exit(1);
}

char *Engine::getProperty(char *word)
{
	Data *data = (Data*)defineList.getHead();

	while (data->next != NULL)
	{
		data = (Data*)data->next;

		if (strcmp(data->key, word) == 0)
			return data->value;
	}

	debug(("getProperty() : %s is not defined!\n", word));
	
	return NULL;
}

#if !UNIX
char *strtok_r(char *in, char *delim, char **nextPos)
{
	char* rtnBuf;
	char* testChar;

	// Set start point, based on input pointer
	if (in != NULL)
	{
		rtnBuf = testChar = in;
	}
	else
	{
		rtnBuf = testChar = (*nextPos);
	}

	// If previous parse hit end of string instead of the delimiter,
	// this time we return null
	if (!testChar)
	{
		return NULL;
	}

	// Look for delimiter until end of string or found
	while (true)
	{
		// If current char is delimiter
		if (*testChar == *delim)
		{
			// Replace delimiter with end of string
			*testChar = 0;

			// Set position for next parse
			*nextPos = testChar + 1;

			// Return original start position
			return rtnBuf;
		}

		// If found end of string
		else if (!*testChar)
		{
			// Set null for nextPos, so subsequent parse ends it
			*nextPos = NULL;

			// Return original start
			return rtnBuf;
		}
		else
		{
			// Bump pointer
			++testChar;
		}
	}
}
#endif

/*
I like this function. It receives a list of flags declared by their #define name... like
the function above, delimited with plus signs. So ENT_FLIES+ENT_AIMS. It then works out the
flags (in a bit of a half arsed manner because of my lazy (2 << 25) declarations, adds all
the values together and then returns them... phew! Makes data files human readable though :)
*/
int Engine::getValueOfFlagTokens(char *realLine)
{
	if (strcmp(realLine, "0") == 0)
		return 0;

	char *store;
	char line[1024];
	bool found;
	int value;
	strcpy(line, realLine);

	int flags = 0;

	char *word = strtok_r(line, "+", &store);

	if (!word)
	{
		debug(("getValueOfFlagTokens() : NULL Pointer!\n"));
		exit(1);
	}

	Data *data;

	while (true)
	{
		data = (Data*)defineList.getHead();
		found = false;

		while (data->next != NULL)
		{
			data = (Data*)data->next;

			if (strcmp(data->key, word) == 0)
			{
				value = -1;
				sscanf(data->value, "%d", &value);

				if (value == -1)
				{
					sscanf(data->value, "%*s %*d %*s %d", &value);
					value = 2 << value;
				}

				flags += value;
				found = true;
				break;
			}
		}
		
		if (!found)
		{
			printf("getValueOfFlagTokens() : Illegal Token %s\n", word);
			exit(1);
		}

		word = strtok_r(NULL, "+", &store);
		if (!word)
			break;
	}

	debug(("getValueOfFlagTokens(): Returning %d\n", flags));
	return flags;
}
