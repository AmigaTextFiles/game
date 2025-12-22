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
 
/**
 *  Log Util
 *  Uses singleton design pattern
 * 
 */
  
#include "Log.h"

Log* Log::_instance = (Log*)NULL; /// initialize static instance pointer

Log::Log()
{
	this->_logLevel = LOG_FILE;
	
	FILE* pFile;
	// open the log file for append
	if ((pFile = fopen("log.txt", "w+")) == NULL)
	fclose(pFile);
		
}

Log* Log::Instance()
{
	if (_instance == NULL)
	{
		_instance = new Log();	
	}
	return _instance;	
}

void Log::setLogLevel(LogLevel logLevel)
{
	this->_logLevel = logLevel;
} 

void Log::log(char* msg , ...)
{
	char message[1024];
	
	va_list argList;
	va_start(argList, msg);
	vsprintf(message, msg, argList);
	log(SV_INFORMATION, SV_INFORMATION, message);
	va_end(argList);	
}

void Log::log(Severity threshold, Severity severity, char* msg , ...)
{
	if (threshold < severity)
		return;
	
	va_list argList;
	FILE *pFile = NULL;
	
	switch (this->_logLevel)
	{
	case LOG_NONE:
		return;
	case LOG_FILE:
	
		// open the log file for append
		if ((pFile = fopen("log.txt", "a+")) == NULL)
			pFile = stderr;
	    
	    break;
	    
	case LOG_SCREEN:
	
		switch (severity)
		{
			case SV_INFORMATION:
			case SV_DEBUG:
				pFile = stdout;
				break;
			case SV_WARNING:
			case SV_ERROR:
			case SV_FATALERROR:
				pFile = stderr;
				break;
		}

		break;
	}
	
	// initialize variable argument list
	va_start(argList, msg);
	
	// write the text and a newline
	vfprintf(pFile, msg, argList);
	putc('\n', pFile);

	if (this->_logLevel == LOG_FILE)
		// close the file
    	fclose(pFile);
    else
    	fflush(pFile);
    va_end(argList);
}

void Log::die(int exitCode, Severity severity, char* msg, ...)
{
	char message[1024];
	
	va_list argList;
	va_start(argList, msg);
	vsprintf(message, msg, argList);
	log(SV_INFORMATION, SV_INFORMATION, message);
	va_end(argList);
	
	exit(exitCode);
}
