/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "servconf.h"

#include <string.h>
#include <stdio.h>
#include <iostream>

#include "variable.h"

using namespace std;

#ifdef WIN32
#define strcasecmp stricmp
#endif

servconf::servconf(){
}
servconf::~servconf(){
}

void servconf::reset() {
	strcpy (infoline, "BadConfig");
	gametime=-1;
	port=8550;
	timeout=5000;
	newblocktime=350;
	noshoottime=3000;
	noshootboost=6000;
	pingtimerate=500;
	timeupdaterate=300;
	lightning=0;
	contactmetaserver=0;
	killcode=0;
}

bool servconf::same(char *a, char *b) {
	if ( strcasecmp(a, b) == 0) return 1;
	else return 0;
}

void servconf::load(char *filename) {

	FILE *conffile = fopen(filename, "r");
	if (conffile==NULL) {
		cout << "File "<<filename<<" not found!\n";
		exit(4);
	}

	int linenumber=0;

	int y=0, u=0;
	bool lastgo=false;
	char muuttuja[200], arvo[200], rivi[200] = {0};

	while (1) {
		linenumber++;
		if ( fgets(rivi, 200, conffile) == NULL ) lastgo=true;

		if (rivi[strlen(rivi)-1]!='\n' && rivi[strlen(rivi)-1]!=EOF) {
			cout << "Line "<<linenumber+1<<" too long!\n";
			exit(3);
		}

		if (rivi[0] != '#' && rivi[0] != '\n' && rivi[0] != '\r') {

			for (y=0, u=0; y<(int)strlen(rivi); y++) {
				if (rivi[y]!=' ' && rivi[y] != '=') muuttuja[u++]=rivi[y];
				if (rivi[y]=='=') break;
			}
			muuttuja[u]='\0';
			y++;
			for (u=0; y<(int)strlen(rivi); y++) {
				/*if (rivi[y]!=' ') arvo[u++]=rivi[y];
				else*/ if (rivi[y]!=' ') break;
			}
			for (; y<(int)strlen(rivi); y++) {
				if (rivi[y]!='\n') arvo[u++]=rivi[y];
			}
			arvo[u]='\0';

			// Dodih. It was this easy :)
			// Now to analyze these.
			
			if (same(muuttuja, "infoline") ) strncpy (infoline, arvo, MAXINFOLINELENGTH);
			else if (same(muuttuja, "gametime") ) {
				gametime = variable::Str2Int(arvo, 0);
				if (gametime < 1 || gametime > 60 ) {
					cout << filename<<":"<<linenumber<<": gametime must be between 1 and 60\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "port") ) {
				port = variable::Str2Int(arvo, 0);
				if (port < 0 || port > 65535 ) {
					cout << filename<<":"<<linenumber<<": port must be between 0 and 65535\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "contactmetaserver") ) {
				contactmetaserver = variable::Str2Int(arvo, 0);
				if (contactmetaserver < 0 || contactmetaserver > 1 ) {
					cout << filename<<":"<<linenumber<<": contactmetaserver must be either 0 or 1\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "newblocktime") ) {
				newblocktime = variable::Str2Int(arvo, 0);
				if (newblocktime < 0 || newblocktime > 6000 ) {
					cout << filename<<":"<<linenumber<<": newblocktime must be between 0 and 6000\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "timeout") ) {
				timeout = variable::Str2Int(arvo, 0);
				if (timeout < 500 || timeout > 30000 ) {
					cout << filename<<":"<<linenumber<<": timeout must be between 500 and 30000\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "noshoottime") ) {
				noshoottime = variable::Str2Int(arvo, 0);
				if (noshoottime < 500 || noshoottime > 60000 ) {
					cout << filename<<":"<<linenumber<<": noshoottime must be between 500 and 60000\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "noshootboost") ) {
				noshootboost = variable::Str2Int(arvo, 0);
				if (noshootboost < 1) {
					cout << filename<<":"<<linenumber<<": noshootboost must be 1 or above\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "pingtimerate") ) {
				pingtimerate = variable::Str2Int(arvo, 0);
				if (pingtimerate < 1) {
					cout << filename<<":"<<linenumber<<": pingtimerate must be 1 or above\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "timeupdaterate") ) {
				timeupdaterate = variable::Str2Int(arvo, 0);
				if (timeupdaterate < 1) {
					cout << filename<<":"<<linenumber<<": timeupdaterate must be 1 or above\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "lightning") ) {
				lightning = variable::Str2Int(arvo, 0);
				if (lightning != 0 && lightning !=1) {
					cout << filename<<":"<<linenumber<<": lightning must be either 0 or 1\n";
					exit(3);
				}
			}
			else if (same(muuttuja, "killcode") ) {
				killcode = variable::Str2Int(arvo, 0);
			}

			else {
				cout << "Error in "<<filename<<" line " << linenumber << ".\n";
				exit(3);
			}

		}

		if (lastgo) break;
	}
}



