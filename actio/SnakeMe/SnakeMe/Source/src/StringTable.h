/*

	SnakeMe 1.0 GPL
	Copyright (C) 2000 Stephane Magnenat/Ysagoon

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/


#ifndef __STRINGTABLE_H
#define __STRINGTABLE_H

typedef struct OneStringToken
{
	char *name;
	char **data;
} OneStringToken;

class StringTable
{
public:
	StringTable();
	~StringTable();
	void SetLang(int l) { actlang=l; }
	bool Load(char *filename);
	char *GetString(char *stringname);
private:
	int actlang;
	int numberoflanguages;
	int numberofstrings;
	OneStringToken *strings;
};

#endif
