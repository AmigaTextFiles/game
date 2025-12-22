/*
 Copyright (C) 2007 by Ben Anderman <ben@happyspork.com>
 Part of Sporktris http://www.happyspork.com/games
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY.
 
 See the License.txt file for more details.
 */

#include <SDL.h>
#include <stdlib.h>
#include <string>
#include <unistd.h>
//#include <iostream>

#include "namedv.h"
#include "common_funcs.h"
#include "prefs_file.h"
#include "menu.h"
#include "highscores.h"
#include "sporktris.h"

#define PREFS_FILE "prefs.txt"
#define VERSION "1.1"
#ifndef INSTALL_DIR
#define INSTALL_DIR "."
#endif
#ifndef INSTALL_PREFIX
#define INSTALL_PREFIX "_"
#endif

#ifdef WIN32
#include <windows.h>
#define chdir(str) SetCurrentDirectory(str)
#endif

using namespace std;

#ifdef IS_BUNDLE
#include <CoreFoundation/CoreFoundation.h>
string get_resources_path ();
#endif

bool run_prefs_menu (Namedv *prefs, Namedv *user_prefs);

int main (int argc, char *argv[])
{
	#ifdef IS_BUNDLE
	string path = get_resources_path();
	chdir(path.c_str());
	#endif
	if (SDL_Init(SDL_INIT_VIDEO) != 0)
	{
		printf("Unable to initialize SDL: %s\n", SDL_GetError());
		return 0;
	}
	atexit(SDL_Quit);
	
	if (argc > 1)
	{
		chdir(argv[1]);
	} else {
		chdir(DATA_DIR);
	}
	Namedv prefs;
	prefs_file::read(PREFS_FILE, &prefs);
	prefs["install_prefix"] = funcs::expand_path(INSTALL_DIR)+"/"+INSTALL_PREFIX;
	prefs["version"] = VERSION;
	
	Namedv user_prefs;
	prefs_file::read(prefs["user_prefs"].c_str(), &user_prefs);
	prefs_file::read((prefs["install_prefix"]+prefs["user_prefs"]).c_str(), &user_prefs);
	
	Namedv game_config;
	prefs_file::read(prefs["game_config"].c_str(), &game_config);
	
	SDL_Surface *screen = SDL_SetVideoMode(prefs.geti("window_w"), prefs.geti("window_h"), 0, SDL_DOUBLEBUF | SDL_HWSURFACE);
	if (screen == NULL)
	{
		printf("couldn't make a window: %s\n", SDL_GetError());
		return 0;
	}
	SDL_WM_SetCaption("Sporktris", "Sporktris");
		
	Menu main_menu(prefs["main_menu"].c_str(), &prefs);
	Menu donate_menu(prefs["donate_menu"].c_str(), &prefs);
	Sporktris the_game(&game_config, &user_prefs);
	highscores hs(&prefs);
	bool exit = false;
	string result;
	while (exit != true && (result = main_menu.hit_test()) != "quit")
	{
		if (result == "play")
		{
			exit = the_game.game_loop();
			if (!exit)
			{
				exit = hs.add_score(the_game.points, the_game.level, the_game.cleared_lines);
				the_game.reset();
			}
		} else if (result == "settings") {
			exit = run_prefs_menu(&prefs, &user_prefs);
		} else if (result == "high scores") {
			exit = hs.show_scores();
		} else if (result == "donate") {
			exit = (donate_menu.hit_test() == "quit");
		}
	}
	return 0;
}

#ifdef IS_BUNDLE
string get_resources_path ()
{
	CFBundleRef main_bundle = CFBundleGetMainBundle();
	if (main_bundle == NULL) return "";
	CFURLRef resources_url = CFBundleCopyResourcesDirectoryURL(main_bundle);
	if (resources_url == NULL) return "";
	unsigned char *buf = NULL;
	unsigned int size = PATH_MAX;
	do
	{
		size *= 2;
		if (buf != NULL) free(buf);
		buf = (unsigned char*)malloc(size);
	} while (!CFURLGetFileSystemRepresentation(resources_url, true, (UInt8*)buf, size));
	string str((char*)buf);
	free(buf);
	CFRelease(resources_url);
	return(str);
}
#endif

bool run_prefs_menu (Namedv *prefs, Namedv *user_prefs)
{
	string result;
	static string which_menu("controls_menu");
	while (1)
	{
		Menu menu((*prefs)[which_menu].c_str(), user_prefs);
		result = menu.hit_test();
		if (result == "back")
		{
			return(false);
		} else if (result == "quit") {
			return(true);
		} else if (result == "controls_menu" || result == "prefs_menu" || result == "raccoon_menu") {
			which_menu = result;
		} else if (result == "outline") {
			if ((*user_prefs)["block_outline"] == "black")
			{
				(*user_prefs)["block_outline"] = "white";
			} else if ((*user_prefs)["block_outline"] == "white") {
				(*user_prefs)["block_outline"] = "off";
			} else {
				(*user_prefs)["block_outline"] = "black";
			}
			if (prefs_file::save(((*prefs)["install_prefix"]+(*prefs)["user_prefs"]).c_str(), user_prefs) == false)
			{
				printf("couldn't save preferences to: %s\n", PREFS_FILE);
			}
		} else if (result == "start_level") {
			int slevel = user_prefs->geti("start_level");
			slevel++;
			if (slevel > 10) slevel = 1;
			(*user_prefs)["start_level"] = funcs::str_int(slevel);
			if (prefs_file::save(((*prefs)["install_prefix"]+(*prefs)["user_prefs"]).c_str(), user_prefs) == false)
			{
				printf("couldn't save preferences to: %s\n", PREFS_FILE);
			}
		} else if (result == "garbage") {
			int garbage = user_prefs->geti("garbage_lines");
			garbage += 3;
			if (garbage > 12) garbage = 0;
			(*user_prefs)["garbage_lines"] = funcs::str_int(garbage);
			if (prefs_file::save(((*prefs)["install_prefix"]+(*prefs)["user_prefs"]).c_str(), user_prefs) == false)
			{
				printf("couldn't save preferences to: %s\n", PREFS_FILE);
			}
		} else if (result == "rmode") {
			(*user_prefs)["rmode"] = (*user_prefs)["rmode"] == "off" ? "on" : "off";
			if ((*user_prefs)["rmode"] == "on" && (*user_prefs)["block_outline"] == "off")
				(*user_prefs)["block_outline"] = "white";
			if (prefs_file::save(((*prefs)["install_prefix"]+(*prefs)["user_prefs"]).c_str(), user_prefs) == false)
			{
				printf("couldn't save preferences to: %s\n", PREFS_FILE);
			}
		} else {
			SDL_Surface *key_prompt = funcs::load_surf((*prefs)["key_prompt_img"], 2, "key prompt image");
			SDL_Surface *bg = funcs::load_surf(prefs->geti("window_w"), prefs->geti("window_h"), "key prompt bg");
			SDL_FillRect(bg, NULL, SDL_MapRGBA(bg->format, 255, 255, 255, 64));
			SDL_Surface *screen = SDL_GetVideoSurface();
			SDL_Rect src_rect, dest_rect;
			SDL_GetClipRect(screen, &dest_rect);
			SDL_BlitSurface(bg, &dest_rect, screen, &dest_rect);
			SDL_GetClipRect(key_prompt, &src_rect);
			dest_rect.x = dest_rect.w/2 - src_rect.w/2;
			dest_rect.y = dest_rect.h/2 - src_rect.h/2;
			SDL_BlitSurface(key_prompt, &src_rect, screen, &dest_rect);
			SDL_Flip(screen);
			SDL_FreeSurface(key_prompt);
			SDL_FreeSurface(bg);
			
			SDL_Event event;
			bool done = false;
			while (SDL_WaitEvent(&event) != 0 && done != true)
			{
				if (event.type == SDL_KEYDOWN)
				{
					(*user_prefs)[result] = SDL_GetKeyName(event.key.keysym.sym);
					done = true;
					if (prefs_file::save(((*prefs)["install_prefix"]+(*prefs)["user_prefs"]).c_str(), user_prefs) == false)
					{
						printf("couldn't save preferences to: %s\n", PREFS_FILE);
					}
				} else if (event.type == SDL_QUIT) {
					return(true);
				}
			}
		}
	}
}
