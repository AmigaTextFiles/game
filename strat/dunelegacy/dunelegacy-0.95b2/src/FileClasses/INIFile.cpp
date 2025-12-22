/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <FileClasses/INIFile.h>

#include <fstream>
#include <iostream>
#include <cctype>
#include <algorithm>
#include <stdio.h>

// public methods

/// Constructor for reading the INI-File from a file.
/**
	This constructor reads the INI-File from the file specified by filename. The file opened in readonly-mode. After
	reading the file is closed immediately. If the file does not exist, it is treated as empty.
	\param	filename	The file to be opened.
*/
INIFile::INIFile(std::string filename)
{
	FirstLine = NULL;
	SectionRoot = NULL;
	SDL_RWops * file;

	// open file
	if((file = SDL_RWFromFile(filename.c_str(),"r")) != NULL) {
			readfile(file);
			SDL_RWclose(file);
	} else {
		if((SectionRoot = new SectionEntry("",0,0)) == NULL) {
			std::cerr << "INIFile: Cannot allocate memory for a new section!" << std::endl;
			exit(EXIT_FAILURE);
		}
	}
}

/// Constructor for reading the INI-File from a SDL_RWops.
/**
	This constructor reads the INI-File from RWopsFile. The RWopsFile can be readonly.
	\param	RWopsFile	Pointer to RWopsFile (can be readonly)
*/
INIFile::INIFile(SDL_RWops * RWopsFile)
{
	FirstLine = NULL;
	SectionRoot = NULL;

	if(RWopsFile == NULL) {
		std::cerr << "INIFile: RWopsFile == NULL!" << std::endl;
		exit(EXIT_FAILURE);
	}

	readfile(RWopsFile);
}

///	Destructor.
/**
	This is the destructor. Changes to the INI-Files are not automaticly saved. Call INIFile::SaveChangesTo() for that purpose.
*/
INIFile::~INIFile()
{
	CommentEntry* curEntry = FirstLine;
	CommentEntry* tmp;
	while(curEntry != NULL) {
		tmp = curEntry;
		curEntry = curEntry->nextEntry;
		delete tmp;
	}

	// now we have to delete the "" section
	delete SectionRoot;
}


/// Reads the string that is adressed by the section/key pair.
/**
	Returns the value that is adressed by the section/key pair as a string. If the key could not be found in
	this section defaultValue is returned. If no defaultValue is specified then "" is returned.
	\param	section			sectionname
	\param	key				keyname
	\param	defaultValue	default value for defaultValue is ""
	\return	The read value or default
*/
std::string INIFile::getStringValue(std::string section, std::string key, std::string defaultValue)
{
	SectionEntry* curSection = getSection(section);
	if(curSection == NULL) {
		return defaultValue;
	}

	KeyEntry* curKey = getKey(curSection,key);
	if(curKey == NULL) {
		return defaultValue;
	}

	return curKey->CompleteLine.substr(curKey->ValueStringBegin,curKey->ValueStringLength);
}


/// Reads the int that is adressed by the section/key pair.
/**
	Returns the value that is adressed by the section/key pair as a int. If the key could not be found in
	this section defaultValue is returned. If no defaultValue is specified then 0 is returned. If the value
	could not be converted to an int 0 is returned.
	\param	section			sectionname
	\param	key				keyname
	\param	defaultValue	default value for defaultValue is 0
	\return	The read number, defaultValue or 0
*/
int INIFile::getIntValue(std::string section, std::string key, int defaultValue )
{
	std::string value = getStringValue(section,key,"");
	if(value.size() == 0) {
		return defaultValue;
	}

	long ret;
	if(value.at(0) == '-') {
		ret = -(atol(value.c_str()+1));
	} else if (value.at(0) == '+') {
		ret = atol(value.c_str()+1);
	} else {
		ret = atol(value.c_str());
	}

	return ret;
}

/// Reads the boolean that is adressed by the section/key pair.
/**
	Returns the value that is adressed by the section/key pair as a boolean. If the key could not be found in
	this section defaultValue is returned. If no defaultValue is specified then false is returned. If the value
	is one of "true", "enabled", "on" or "1" then true is returned; if it is one of "false", "disabled", "off" or
	"0" than false is returned; otherwise defaultValue is returned.
	\param	section			sectionname
	\param	key				keyname
	\param	defaultValue	default value for defaultValue is 0
	\return	true for "true", "enabled", "on" and "1"<br>false for "false", "disabled", "off" and "0"
*/
bool INIFile::getBoolValue(std::string section, std::string key, bool defaultValue)
{
	std::string value = getStringValue(section,key,"");
	if(value.size() == 0) {
		return defaultValue;
	}

	// convert string to lower case
	transform(value.begin(),value.end(), value.begin(), (int(*)(int)) tolower);

	if((value == "true") || (value == "enabled") || (value == "on") || (value == "1")) {
		return true;
	} else if((value == "false") || (value == "disabled") || (value == "off") || (value == "0")) {
		return false;
	} else {
		return defaultValue;
	}
}

/// Reads the double that is adressed by the section/key pair.
/**
	Returns the value that is adressed by the section/key pair as a double. If the key could not be found in
	this section defaultValue is returned. If no defaultValue is specified then 0.0 is returned. If the value
	could not be converted to an double 0.0 is returned.
	\param	section			sectionname
	\param	key				keyname
	\param	defaultValue	default value for defaultValue is 0.0
	\return	The read number, defaultValue or 0.0
*/
double INIFile::getDoubleValue(std::string section, std::string key, double defaultValue )
{
	std::string value = getStringValue(section,key,"");
	if(value.size() == 0) {
		return defaultValue;
	}

	double ret;
	ret = atof(value.c_str());

	return ret;
}

/// Sets the string that is adressed by the section/key pair.
/**
	Sets the string that is adressed by the section/key pair to value. If the section and/or the key does not exist it will
	be created. A valid sectionname/keyname is not allowed to contain '[',']',';' or '#' and can not start or end with
	whitespaces (' ' or '\\t').
	\param	section			sectionname
	\param	key				keyname
	\param	value			value that should be set
*/
void INIFile::setStringValue(std::string section, std::string key, std::string value)
{
	CommentEntry* curEntry = NULL;
	SectionEntry* curSection = getSection(section);

	if(curSection == NULL) {
		// create new section

		// test for valid section name
		bool NonNormalCharFound = false;
		for(unsigned int i = 0; i < section.size(); i++) {
			if( (!isNormalChar(section[i])) && (!isWhitespace(section[i])) ) {
				NonNormalCharFound = true;
			}
		}

		if(isWhitespace(section[0]) || isWhitespace(section[section.size()-1])) {
			NonNormalCharFound = true;
		}

		if(NonNormalCharFound == true) {
			std::cerr << "INIFile: Cannot create section with name " << section << "!" << std::endl;
			return;
		}

		std::string completeLine = "[" + section + "]";
		if((curSection = new SectionEntry(completeLine,1,section.size())) == NULL) {
			std::cerr << "INIFile: Cannot allocate memory for new section line!" << std::endl;
			exit(EXIT_FAILURE);
		}

		if(FirstLine == NULL) {
			FirstLine = curSection;
		} else {
			curEntry = FirstLine;
			while(curEntry->nextEntry != NULL) {
				curEntry = curEntry->nextEntry;
			}

			curEntry->nextEntry = curSection;
			curSection->prevEntry = curEntry;
			curEntry = curSection;
		}

		InsertSection(curSection);
	}

	KeyEntry* curKey = getKey(curSection,key);
	if(curKey == NULL) {
		// create new key

		// test for valid key name
		bool NonNormalCharFound = false;
		for(unsigned int i = 0; i < key.size(); i++) {
			if( (!isNormalChar(key[i])) && (!isWhitespace(key[i])) ) {
				NonNormalCharFound = true;
			}
		}

		if(isWhitespace(key[0]) || isWhitespace(key[key.size()-1])) {
			NonNormalCharFound = true;
		}

		if(NonNormalCharFound == true) {
			std::cerr << "INIFile: Cannot create key with name " << key << "!" << std::endl;
			return;
		}

		std::string completeLine;
		int KeyStringStart;
		int KeyStringLength;
		int ValueStringStart;
		int ValueStringLength;
		if(value == "") {
			completeLine = key + " = \"" + value + "\"" ;
			KeyStringStart = 0;
			KeyStringLength = key.size();
			ValueStringStart = key.size()+4;
			ValueStringLength = value.size();
		} else {

			// test for non normal char
			NonNormalCharFound = false;
			for(unsigned int i = 0; i < value.size(); i++) {
				if(!isNormalChar(value[i])) {
					NonNormalCharFound = true;
				}
			}

			if(NonNormalCharFound == true) {
				completeLine = key + " = \"" + value + "\"" ;
				KeyStringStart = 0;
				KeyStringLength = key.size();
				ValueStringStart = key.size()+4;
				ValueStringLength = value.size();
			} else {
				completeLine = key + " = " + value;
				KeyStringStart = 0;
				KeyStringLength = key.size();
				ValueStringStart = key.size()+3;
				ValueStringLength = value.size();
			}
		}
		if((curKey = new KeyEntry(completeLine,KeyStringStart,KeyStringLength,ValueStringStart,ValueStringLength)) == NULL) {
			std::cerr << "INIFile: Cannot allocate memory for new key/value line!" << std::endl;
			exit(EXIT_FAILURE);
		}

		if(curEntry != NULL) {
			curEntry->nextEntry = curKey;
			curKey->prevEntry = curEntry;
		} else {
			KeyEntry* pKey = curSection->KeyRoot;
			if(pKey == NULL) {
				// Section has no key yet
				if(curSection->nextEntry == NULL) {
					// no line after this section declaration
					curSection->nextEntry = curKey;
					curKey->prevEntry = curSection;
				} else {
					// lines after this section declaration
					curSection->nextEntry->prevEntry = curKey;
					curKey->nextEntry = curSection->nextEntry;
					curSection->nextEntry = curKey;
					curKey->prevEntry = curSection;
				}
			} else {
				// Section already has some keys
				while(pKey->nextKey != NULL) {
					pKey = pKey->nextKey;
				}

				if(pKey->nextEntry == NULL) {
					// no line after this key
					pKey->nextEntry = curKey;
					curKey->prevEntry = pKey;
				} else {
					// lines after this section declaration
					pKey->nextEntry->prevEntry = curKey;
					curKey->nextEntry = pKey->nextEntry;
					pKey->nextEntry = curKey;
					curKey->prevEntry = pKey;
				}
			}

		}

		InsertKey(curSection,curKey);
	} else {
		curKey->CompleteLine.replace(curKey->ValueStringBegin,curKey->ValueStringLength,value);
	}
}

/// Sets the int that is adressed by the section/key pair.
/**
	Sets the int that is adressed by the section/key pair to value. If the section and/or the key does not exist it will
	be created. A valid sectionname/keyname is not allowed to contain '[',']',';' or '#' and can not start or end with
	whitespaces (' ' or '\\t').
	\param	section			sectionname
	\param	key				keyname
	\param	value			value that should be set
*/
void INIFile::setIntValue(std::string section, std::string key, int value)
{
	char tmp[20];
	sprintf(tmp,"%d",value);
	setStringValue(section, key, tmp);
}

/// Sets the boolean that is adressed by the section/key pair.
/**
	Sets the boolean that is adressed by the section/key pair to value. If the section and/or the key does not exist it will
	be created. A valid sectionname/keyname is not allowed to contain '[',']',';' or '#' and can not start or end with
	whitespaces (' ' or '\\t').
	\param	section			sectionname
	\param	key				keyname
	\param	value			value that should be set
*/
void INIFile::setBoolValue(std::string section, std::string key, bool value)
{
	if(value == true) {
		setStringValue(section, key, "true");
	} else {
		setStringValue(section, key, "false");
	}
}

/// Sets the double that is adressed by the section/key pair.
/**
	Sets the double that is adressed by the section/key pair to value. If the section and/or the key does not exist it will
	be created. A valid sectionname/keyname is not allowed to contain '[',']',';' or '#' and can not start or end with
	whitespaces (' ' or '\\t').
	\param	section			sectionname
	\param	key				keyname
	\param	value			value that should be set
*/
void INIFile::setDoubleValue(std::string section, std::string key, double value)
{
	char tmp[30];
	sprintf(tmp,"%f",value);
	setStringValue(section, key, tmp);
}

/// Returns a list of all section names
/**
    This method returns a list containing the names of all sections in this INI-File
    \return a list with names of all sections in this INI-File
*/
std::list<std::string> INIFile::getSectionList()
{
    std::list<std::string> sectionList;

	SectionEntry* curSection = SectionRoot;

	while(curSection != NULL) {
	    sectionList.push_back( curSection->CompleteLine.substr( curSection->SectionStringBegin,
                                                                curSection->SectionStringLength ) );
		curSection = curSection->nextSection;
	}

    return sectionList;
}

/// Opens a INIFile::KeyListHandle.
/**
	A INIFile::KeyListHandle can be used to list all keys of one section. This method opens the #INIFile::KeyListHandle.
	To iterate all keys use KeyList_GetNextKey(). #INIFile::KeyListHandle should be closed by KeyList_Close().
	If the section is empty INIFile::KeyList_EOF on the returned handle of INIFile::KeyList_Open(sectionname) is true.<br>
	<br>
	Example:<br>
	&nbsp;&nbsp;INIFile::KeyListHandle myHandle;<br>
	&nbsp;&nbsp;myHandle = myINIFile.KeyList_Open("Section1");<br>
	<br>
	&nbsp;&nbsp;while(!myINIFile.KeyList_EOF(myHandle)) {<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cout << myINIFile.KeyList_GetNextKey(&myHandle) << std::endl;<br>
	&nbsp;&nbsp;}<br>
	<br>
	&nbsp;&nbsp;myINIFile.KeyList_Close(&myHandle);
	\param	sectionname	The name of the section
	\return	handle to this section
	\see	KeyList_Close, KeyList_GetNextKey, KeyList_EOF
*/
INIFile::KeyListHandle INIFile::KeyList_Open(std::string sectionname) {
	SectionEntry* curSection = getSection(sectionname);
	if(curSection == NULL) {
		return NULL;
	} else {
		return curSection->KeyRoot;
	}
}

/// Tests if handle is at the end of the KeyList.
/**
	Tests if handle is at the end of the KeyList. If the section is empty INIFile::KeyList_EOF on the returned
	handle of INIFile::KeyList_Open(sectionname) is true.
	\param	handle	The handle to the KeyList
	\return	true if the handle is at the end of the list, otherwise false
	\see	KeyList_Open
*/
bool INIFile::KeyList_EOF(KeyListHandle handle) {
	if(handle == NULL) {
		return true;
	} else {
		return false;
	}
}

/// Returns the keyname of the next key in the KeyList.
/**
	Returns the keyname of the next key in the KeyList. If the iteration through the KeyList is finished "" is returned.
	\param	handle	Pointer to the handle to the KeyList
	\return	The keyname or "" if the list is empty
	\see	KeyList_Open, KeyList_EOF
*/
std::string INIFile::KeyList_GetNextKey(KeyListHandle* handle) {
	if(handle == NULL) {
		return "";
	} else {
		std::string ret = (*handle)->CompleteLine.substr((*handle)->KeyStringBegin,(*handle)->KeyStringLength);
		*handle = (*handle)->nextKey;
		return ret;
	}
}

/// Closes the KeyList.
/**
	Closes the KeyList.
	\param	handle	Pointer to the handle to the KeyList
	\see	KeyList_Open
*/
void INIFile::KeyList_Close(KeyListHandle* handle) {
	if(handle != NULL)
		*handle = NULL;
}

/// Saves the changes made in the INI-File to a file.
/**
	Saves the changes made in the INI-File to a file specified by filename.
	If something goes wrong false is returned otherwise true.
	\param	filename	Filename of the file. This file is opened for writing.
	\return	true on success otherwise false.
*/
bool INIFile::SaveChangesTo(std::string filename) {
	SDL_RWops * file;
	if((file = SDL_RWFromFile(filename.c_str(),"w")) == NULL) {
		return false;
	}

	bool ret = SaveChangesTo(file);
	SDL_RWclose(file);
	return ret;
}

/// Saves the changes made in the INI-File to a RWop.
/**
	Saves the changes made in the INI-File to a RWop specified by file.
	If something goes wrong false is returned otherwise true.
	\param	file	SDL_RWops that is used for writing. (Cannot be readonly)
	\return	true on success otherwise false.
*/
bool INIFile::SaveChangesTo(SDL_RWops * file) {
	CommentEntry* curEntry = FirstLine;

	bool error = false;
	unsigned int written;
	while(curEntry != NULL) {
		written = SDL_RWwrite(file, curEntry->CompleteLine.c_str(), 1, curEntry->CompleteLine.size());
		if(written != curEntry->CompleteLine.size()) {
			std::cout << SDL_GetError() << std::endl;
			error = true;
		}
		if((written = SDL_RWwrite(file,"\n",1,1)) != 1) {
			error = true;
		}
		curEntry = curEntry->nextEntry;
	}

	return !error;
}

// private methods

void INIFile::flush()
{

	std::cout << "Flush:" << std::endl;
	CommentEntry* curEntry = FirstLine;

	while(curEntry != NULL) {
		std::cout << curEntry->CompleteLine << std::endl;
		curEntry = curEntry->nextEntry;
	}

}

void INIFile::readfile(SDL_RWops * file)
{
	if((SectionRoot = new SectionEntry("",0,0)) == NULL) {
		std::cerr << "INIFile: Cannot allocate memory for a new section!" << std::endl;
		exit(EXIT_FAILURE);
	}

	SectionEntry* curSectionEntry = SectionRoot;

	std::string completeLine;
	int lineNum = 0;
	bool SyntaxError = false;
	CommentEntry* curEntry = NULL;
	CommentEntry* newCommentEntry;
	SectionEntry* newSectionEntry;
	KeyEntry* newKeyEntry;

	bool readfinished = false;

	while(!readfinished) {
		lineNum++;

		completeLine = "";
		unsigned char tmp;
		int readbytes;

		while(1) {
			readbytes = SDL_RWread(file,&tmp,1,1);
			if(readbytes <= 0) {
				readfinished = true;
				break;
			} else if(tmp == '\n') {
				break;
			} else if(tmp != '\r') {
				completeLine += tmp;
			}
		}

		const unsigned char* line = (const unsigned char*) completeLine.c_str();
		SyntaxError = false;
		int ret;

		ret = getNextChar(line,0);

		if(ret == -1) {
			// empty line or comment
			if((newCommentEntry = new CommentEntry(completeLine)) == NULL) {
				std::cerr << "INIFile: Cannot allocate memory for new comment line!" << std::endl;
				exit(EXIT_FAILURE);
			}

			if(curEntry == NULL) {
				FirstLine = newCommentEntry;
				curEntry = newCommentEntry;
			} else {
				curEntry->nextEntry = newCommentEntry;
				newCommentEntry->prevEntry = curEntry;
				curEntry = newCommentEntry;
			}
		} else {

			if(line[ret] == '[') {
				// section line
				int sectionstart = ret+1;
				int sectionend = skipName(line,ret+1);

				if((line[sectionend] != ']') ||	(getNextChar(line,sectionend+1) != -1)) {
					SyntaxError = true;
				} else {
					// valid section line
					if((newSectionEntry = new SectionEntry(completeLine,sectionstart,sectionend-sectionstart)) == NULL) {
						std::cerr << "INIFile: Cannot allocate memory for new section line!" << std::endl;
						exit(EXIT_FAILURE);
					}

					if(curEntry == NULL) {
						FirstLine = newSectionEntry;
						curEntry = newSectionEntry;
					} else {
						curEntry->nextEntry = newSectionEntry;
						newSectionEntry->prevEntry = curEntry;
						curEntry = newSectionEntry;
					}

					InsertSection(newSectionEntry);
					curSectionEntry = newSectionEntry;
				}
			} else {

				// might be key/value line
				int keystart = ret;
				int keyend = skipKey(line,keystart);

				if(keystart == keyend) {
					SyntaxError = true;
				} else {
					ret = getNextChar(line,keyend);
					if((ret == -1) ||(line[ret] != '=')) {
						SyntaxError = true;
					} else {
						int valuestart = getNextChar(line,ret+1);
						int valueend;
						if(valuestart == -1) {
							SyntaxError = true;
						} else {
							if(line[valuestart] == '"') {
								// now get the next '"'

								valueend = getNextQuote(line,valuestart+1);

								if((valueend == -1) || (getNextChar(line,valueend+1) != -1)) {
									SyntaxError = true;
								} else {
									// valid key/value line
									if((newKeyEntry = new KeyEntry(completeLine,keystart,keyend-keystart,valuestart+1,valueend-valuestart-1)) == NULL) {
										std::cerr << "INIFile: Cannot allocate memory for new key/value line!" << std::endl;
										exit(EXIT_FAILURE);
									}

									if(FirstLine == NULL) {
										FirstLine = newKeyEntry;
										curEntry = newKeyEntry;
									} else {
										curEntry->nextEntry = newKeyEntry;
										newKeyEntry->prevEntry = curEntry;
										curEntry = newKeyEntry;
									}

									InsertKey(curSectionEntry,newKeyEntry);
								}

							} else {
								valueend = skipValue(line,valuestart);

								if(getNextChar(line,valueend) != -1) {
									SyntaxError = true;
								} else {
									// valid key/value line
									if((newKeyEntry = new KeyEntry(completeLine,keystart,keyend-keystart,valuestart,valueend-valuestart)) == NULL) {
										std::cerr << "INIFile: Cannot allocate memory for new key/value line!" << std::endl;
										exit(EXIT_FAILURE);
									}

									if(FirstLine == NULL) {
										FirstLine = newKeyEntry;
										curEntry = newKeyEntry;
									} else {
										curEntry->nextEntry = newKeyEntry;
										newKeyEntry->prevEntry = curEntry;
										curEntry = newKeyEntry;
									}

									InsertKey(curSectionEntry,newKeyEntry);
								}
							}
						}
					}
				}

			}
		}

		if(SyntaxError == true) {
			if(completeLine.size() < 100) {
				// there are some buggy ini-files which have a lot of waste at the end of the file
				// and it makes no sense to print all this stuff out. just skip it
				std::cerr << "INIFile: Syntax-Error in line " << lineNum << ":" << completeLine << " !" << std::endl;
			}
			// save this line as a comment
			if((newCommentEntry = new CommentEntry(completeLine)) == NULL) {
				std::cerr << "INIFile: Cannot allocate memory for new comment line!" << std::endl;
				exit(EXIT_FAILURE);
			}

			if(curEntry == NULL) {
				FirstLine = newCommentEntry;
				curEntry = newCommentEntry;
			} else {
				curEntry->nextEntry = newCommentEntry;
				newCommentEntry->prevEntry = curEntry;
				curEntry = newCommentEntry;
			}
		}



	}
}

void INIFile::InsertSection(SectionEntry* newSection) {
	if(SectionRoot == NULL) {
		// New root element
		SectionRoot = newSection;
	} else {
		// insert into list
		SectionEntry* curSection = SectionRoot;
		while(curSection->nextSection != NULL) {
			curSection = curSection->nextSection;
		}

		curSection->nextSection = newSection;
		newSection->prevSection = curSection;
	}
}

void INIFile::InsertKey(SectionEntry* section, KeyEntry* newKeyEntry) {
	if(section->KeyRoot == NULL) {
		// New root element
		section->KeyRoot = newKeyEntry;
	} else {
		// insert into list
		KeyEntry* curKey = section->KeyRoot;
		while(curKey->nextKey != NULL) {
			curKey = curKey->nextKey;
		}

		curKey->nextKey = newKeyEntry;
		newKeyEntry->prevKey = curKey;
	}
}


INIFile::SectionEntry* INIFile::getSection(std::string sectionname) {
	SectionEntry* curSection = SectionRoot;
	int sectionnameSize = sectionname.size();

	while(curSection != NULL) {
		if(curSection->SectionStringLength == sectionnameSize) {
				if(strncmp(sectionname.c_str(), curSection->CompleteLine.c_str()+curSection->SectionStringBegin, sectionnameSize) == 0) {
					return curSection;
				}
		}

		curSection = curSection->nextSection;
	}

	return NULL;
}

INIFile::KeyEntry* INIFile::getKey(SectionEntry* sectionentry, std::string keyname) {
	KeyEntry* curKey = sectionentry->KeyRoot;
	int keynameSize = keyname.size();

	while(curKey != NULL) {
		if(curKey->KeyStringLength == keynameSize) {
				if(strncmp(keyname.c_str(), curKey->CompleteLine.c_str()+curKey->KeyStringBegin, keynameSize) == 0) {
					return curKey;
				}
		}

		curKey = curKey->nextKey;
	}

	return NULL;
}


int INIFile::getNextChar(const unsigned char* line, int startpos) {
	while(line[startpos] != '\0') {
		if((line[startpos] == ';') || (line[startpos] == '#')) {
			// comment
			return -1;
		} else if(!isWhitespace(line[startpos])) {
			return startpos;
		}
		startpos++;
	}
	return -1;
}

int INIFile::skipName(const unsigned char* line,int startpos) {
	while(line[startpos] != '\0') {
		if(isNormalChar(line[startpos]) || (line[startpos] == ' ')) {
			startpos++;
		} else {
			return startpos;
		}
	}
	return startpos;
}

int INIFile::skipValue(const unsigned char* line,int startpos) {
	int i = startpos;
	while(line[i] != '\0') {
		if(isNormalChar(line[i]) || isWhitespace(line[i])) {
			i++;
		} else if((line[i] == ';') || (line[i] == '#')) {
			// begin of a comment
			break;
		} else {
			// some invalid character
			return i;
		}
	}

	// now we go backwards
	while(i >= startpos) {
		if(isNormalChar(line[i])) {
			return i+1;
		}
		i--;
	}
	return startpos+1;
}

int INIFile::skipKey(const unsigned char* line,int startpos) {
	int i = startpos;
	while(line[i] != '\0') {
		if(isNormalChar(line[i]) || isWhitespace(line[i])) {
			i++;
		} else if((line[i] == ';') || (line[i] == '#') || (line[i] == '=')) {
			// begin of a comment or '='
			break;
		} else {
			// some invalid character
			return i;
		}
	}

	// now we go backwards
	while(i >= startpos) {
		if(isNormalChar(line[i])) {
			return i+1;
		}
		i--;
	}
	return startpos+1;
}

int INIFile::getNextQuote(const unsigned char* line,int startpos) {
	while(line[startpos] != '\0') {
		if(line[startpos] != '"') {
			startpos++;
		} else {
			return startpos;
		}
	}
	return -1;
}

bool INIFile::isWhitespace(unsigned char s) {
	if((s == ' ') || (s == '\t') || (s == '\n') || (s == '\r')) {
		return true;
	} else {
		return false;
	}
}

bool INIFile::isNormalChar(unsigned char s) {
	if((!isWhitespace(s)) && (s >= 33) && (s != '"') && (s != ';') && (s != '#') && (s != '[') && (s != ']') && (s != '=')) {
		return true;
	} else {
		return false;
	}
}
