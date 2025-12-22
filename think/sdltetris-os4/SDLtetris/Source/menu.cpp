#include <SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <cstdio>
#include <stdlib.h>
#include <vector>
#include <string>
#include <fstream>

#include "menu.h"
#include "namedv.h"
#include "prefs_file.h"

using namespace std;

string menu::runMenu (void)
{
	ls.first = true;
	int x, y;
	SDL_GetMouseState(&x, &y);
	handleMouseMove(x, y);
	screen = SDL_GetVideoSurface();
	ls.blit(screen);
	SDL_Flip(screen);
	SDL_Event event;
	while (SDL_WaitEvent(&event) != 0)
	{
		if (event.type == SDL_MOUSEBUTTONDOWN)
		{
			for (unsigned int i = 0; i < button_rects.size(); i++)
			{
				SDL_MouseButtonEvent temp = event.button;
				if (temp.x > button_rects[i].x && temp.x < button_rects[i].x+button_rects[i].w && temp.y > button_rects[i].y && temp.y < button_rects[i].y+button_rects[i].h)
				{
					string tmp = menuInfo[string("button")+strInt(i+1)+string("_return")];
					if (tmp != "") return (tmp);
				}
			}
		} else if (event.type == SDL_MOUSEMOTION) {
			SDL_MouseMotionEvent mEvent = event.motion;
			bool udWin = false;
			udWin = handleMouseMove(mEvent.x, mEvent.y);
			if (udWin)
			{
				ls.blit(screen);
				SDL_Flip(screen);
			}
		} else if (event.type == SDL_QUIT) {
			return("quit");
		}
	}
	return ("");
}

bool menu::handleMouseMove(int x, int y)
{
	int num_buttons = menuInfo.geti("num_buttons");
	bool result = false;
	for (int i = 1; i <= num_buttons; i++)
	{
		string temp1 = string("button")+strInt(i);
		if (menuInfo[temp1+string("_surf_over")] != "" && surfs[menuInfo[temp1+string("_surf_over")]] != NULL)
		{
			layer *l = &(ls.layers[i]);
			if (hitTest(x, y, &(button_rects[i-1])))
			{
				if (l->surf != surfs[menuInfo[temp1+string("_surf_over")]])
				{
					l->surf = surfs[menuInfo[temp1+string("_surf_over")]];
					l->changed = true;
					result = true;
				}
			} else {
				if (l->surf != surfs[menuInfo[temp1+string("_surf")]])
				{
					l->surf = surfs[menuInfo[temp1+string("_surf")]];
					l->changed = true;
					result = true;
				}
			}
		}
	}
	return(result);
}

bool menu::hitTest (int x, int y, SDL_Rect *rect)
{
	if (x >= rect->x && x <= rect->x+rect->w && y >= rect->y && y <= rect->y+rect->h)
	{
		return true;
	} else {
		return false;
	}
}

menu::menu (const char *filename, namedv *data)
{
	if (prefs_file::read(filename, &menuInfo) != 0)
	{
		printf("couldn't load menu file: %s\n", filename);
		exit(1);
	}
	background = IMG_Load(menuInfo["background"].c_str());
	if (background == NULL)
	{
		printf("couldn't load menu background: %s\n", menuInfo["background"].c_str());
		exit(1);
	}
	background = SDL_DisplayFormat(background);
	if (background == NULL)
	{
		printf("couldn't convert menu background to display format\n");
		exit(1);
	}
	ls.add(layer("background", background, 0, 0));
	int num_surfs = menuInfo.geti("num_surfs");
	for (int i = 1; i <= num_surfs; i++)
	{
		string key = menuInfo[string("surf")+strInt(i)+string("_name")];
		string path = menuInfo[string("surf")+strInt(i)+string("_path")];
		string alpha = menuInfo[string("surf")+strInt(i)+string("_alpha")];
		if (surfs[key] == NULL)
		{
			SDL_Surface *temp = IMG_Load(path.c_str());
			if (temp == NULL)
			{
				printf("couldn't load menu image %s: %s\n", key.c_str(), path.c_str());
			} else {
				if (alpha == "true")
				{
					surfs[key] = SDL_DisplayFormatAlpha(temp);
					if (alpha == "true")
					SDL_SetAlpha(surfs[key], SDL_SRCALPHA | SDL_RLEACCEL, 0);
				} else {
					surfs[key] = SDL_DisplayFormat(temp);
				}
				SDL_FreeSurface(temp);
				if (surfs[key] == NULL)
				{
					printf("couln't convert %s to display format\n", key.c_str());
				}
			}
		}
	}
	
	int num_fonts = menuInfo.geti("num_fonts");
	if (num_fonts > 0) init_ttf();
	for (int i = 1; i <= num_fonts; i++)
	{
		string key = menuInfo[string("font")+strInt(i)+string("_name")];
		string path = menuInfo[string("font")+strInt(i)+string("_path")];
		int size = menuInfo.geti(string("font")+strInt(i)+string("_size"));
		if (ifstream(path.c_str()).rdstate() == 0 && fonts[key] == 0)
		{
			fonts[key] = TTF_OpenFont(path.c_str(), size);
			if (fonts[key] == NULL)
			{
				printf("couldn't load font \"%s\" from file \"%s\"\n", key.c_str(), path.c_str());
			}
		}
	}
	
	int num_tsurfs = menuInfo.geti("num_tsurfs");
	for (int i = 1; i <= num_tsurfs; i++)
	{
		string key = menuInfo[string("tsurf")+strInt(i)+string("_name")];
		string text = addVars(menuInfo[string("tsurf")+strInt(i)+string("_text")], data);
		string font = menuInfo[string("tsurf")+strInt(i)+string("_font")];
		string color = menuInfo[string("tsurf")+strInt(i)+string("_color")];
		if (surfs[key] == NULL && fonts[font] != NULL)
		{
			surfs[key] = TTF_RenderText_Blended(fonts[font],  text.c_str(), makeColor(color));
		}
	}
	
	int num_buttons = menuInfo.geti("num_buttons");
	for (int i = 1; i <= num_buttons; i++)
	{
		string rectStr = menuInfo[string("button")+strInt(i)+string("_rect")];
		SDL_Rect rect;
		if (rectStr != "")
		{
			int start;
			rect.x = atoi(prefs_file::readUntil(rectStr, &start, ',').c_str());
			rectStr = rectStr.substr(start, rectStr.size());
			rect.y = atoi(prefs_file::readUntil(rectStr, &start, ',').c_str());
			rectStr = rectStr.substr(start, rectStr.size());
			rect.w = atoi(prefs_file::readUntil(rectStr, &start, ',').c_str());
			rectStr = rectStr.substr(start, rectStr.size());
			rect.h = atoi(rectStr.c_str());
		} else {
			if (surfs[menuInfo[string("button")+strInt(i)+string("_surf")]] != NULL)
			{
				SDL_GetClipRect(surfs[menuInfo[string("button")+strInt(i)+string("_surf")]], &rect);
			}
		}
		string temp = string("button")+strInt(i);
		rect.x += menuInfo.geti(temp+string("_x"));
		rect.y += menuInfo.geti(temp+string("_y"));
		button_rects.push_back(rect);
		ls.add(layer(temp, surfs[menuInfo[temp+string("_surf")]], menuInfo.geti(temp+string("_x")), menuInfo.geti(temp+string("_y"))));
	}
}

string menu::addVars (string str, namedv *data)
{
	if (data != NULL)
	{
		string newstr;
		unsigned int index = 0;
		unsigned int oldindex = 0;
		bool type = 0;
		while ( (index = str.find('%', oldindex)) != string::npos)
		{
			index++;
			if (type == 0)
			{
				newstr += str.substr(oldindex, index-oldindex-1);
			} else {
				newstr += (*data)[str.substr(oldindex, index-oldindex-1)];
			}
			oldindex = index;
			type ? type = 0 : type = 1;
		}
		newstr += str.substr(oldindex);
		return(newstr);
	} else {
		return(str);
	}
}

menu::~menu (void)
{
	for (map<string, SDL_Surface*>::iterator itor = surfs.begin(); itor != surfs.end(); ++itor)
	{
		if (itor->second != NULL) SDL_FreeSurface(itor->second);
	}
	SDL_FreeSurface(background);
	
	for (map<string, TTF_Font*>::iterator itor = fonts.begin(); itor != fonts.end(); ++itor)
	{
		if (itor->second != NULL) TTF_CloseFont(itor->second);
	}
}

void menu::init_ttf (void)
{
	if (!TTF_WasInit())
	{
		if (TTF_Init() == -1)
		{
			printf("Oh no! we can't render text! i asked, but all they said was: %s - those bastards!\n", TTF_GetError());
			exit(1);
		} else {
			atexit(TTF_Quit);
		}
	}
}

SDL_Color menu::makeColor (string str)
{
	if (str.length() >= 6)
	{
		Uint8 color[3];
		for (int i = 0; i < 6; i+=2)
		{
			color[i/2] = (char)strtol(str.substr(i, 2).c_str(), NULL, 16);
		}
		SDL_Color result = {color[0], color[1], color[2], 0};
		return (result);
	} else {
		SDL_Color result = {0, 0, 0, 0};
		return (result);
	}
}

string menu::strInt (int n)
{
	char chr[sizeof(int)*8+1];
	sprintf(chr, "%i", n);
	return(string(chr));
}
