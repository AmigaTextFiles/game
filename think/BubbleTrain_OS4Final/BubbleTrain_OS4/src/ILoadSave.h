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
  * Interface for loading and saving data to and from xml
  */
  
#ifndef ILoadSave_H
#define ILoadSave_H

// System includes
#include <libxml/parser.h>

class ILoadSave
{
public:
	virtual void load(const char* path, const char* filename){};	
	virtual void load(xmlDocPtr doc, xmlNodePtr cur){};
	virtual void save(const char* path, const char* filename){};
	virtual void save(xmlDocPtr doc, xmlNodePtr cur) {};
};

#endif
