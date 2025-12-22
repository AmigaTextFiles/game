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
  * A reusable log class for logging errors, information or debugging info. 
  * 
  * produced using the singleton
  * 
  */
 
#ifndef ERROR_H
#define ERROR_H

// System Includes
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

// Game includes
#include "General.h"

// Define a severity for an error
enum Severity 
{
	SV_FATALERROR,
	SV_ERROR,
	SV_WARNING,
	SV_INFORMATION,
	SV_DEBUG
};

// Define where the item should be logged
enum LogLevel
{
	LOG_NONE,
	LOG_SCREEN,
	LOG_FILE	
};

class Log 
{

private:
	LogLevel _logLevel;
	static Log* _instance;

protected:
	Log();

public:	
	static Log* Instance();
	void setLogLevel(LogLevel logLevel);
	void log(char* msg , ...);
	void log(Severity threshold, Severity severity, char* msg , ...);
	void die(int exitCode, Severity severity, char* msg, ...);
};

#endif
