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

#ifndef INIFILE_H
#define INIFILE_H

#include <string>
#include <list>
#include <SDL_rwops.h>
#include <SDL.h>


//!  A class for reading and writing *.ini configuration files.
/*!
	This class can be used to read or write to a *.ini file. An ini-File has a very simple format.<br>
	Example:<br>
		<br>
		; Comments start with ; or #<br>
		; start of the first section with name ""<br>
		key1 = value1<br>
		key2 = value2<br>
		; start of a section with name "Section1"<br>
		[Section1]<br>
		key3 = value3<br>
		key4 = value4<br>
*/
class INIFile
{
private:
	//\cond
	class CommentEntry;
	class SectionEntry;
	class KeyEntry;

	class CommentEntry
	{
	public:
		CommentEntry(std::string completeLine) {
			CompleteLine = completeLine;
			nextEntry = NULL;
			prevEntry = NULL;
		};

		std::string CompleteLine;
		CommentEntry* nextEntry;
		CommentEntry* prevEntry;
	};


	class SectionEntry : public CommentEntry
	{
	public:
		SectionEntry(std::string completeLine, int sectionstringbegin, int sectionstringlength)
		: CommentEntry(completeLine) {
			nextSection = NULL;
			prevSection = NULL;
			KeyRoot = NULL;
			SectionStringBegin = sectionstringbegin;
			SectionStringLength = sectionstringlength;
		};

		int SectionStringBegin;
		int SectionStringLength;
		SectionEntry* nextSection;
		SectionEntry* prevSection;
		KeyEntry* KeyRoot;
	};


	class KeyEntry : public CommentEntry
	{
	public:
		KeyEntry(std::string completeLine, int keystringbegin, int keystringlength, int valuestringbegin, int valuestringlength)
		: CommentEntry(completeLine) {
			nextKey = NULL;
			prevKey = NULL;
			KeyStringBegin = keystringbegin;
			KeyStringLength = keystringlength;
			ValueStringBegin = valuestringbegin;
			ValueStringLength = valuestringlength;
		};

		int KeyStringBegin;
		int KeyStringLength;
		int ValueStringBegin;
		int ValueStringLength;
		KeyEntry* nextKey;
		KeyEntry* prevKey;
	};
	//\endcond

public:
	typedef INIFile::KeyEntry* KeyListHandle;		///< A handle to a KeyList opened with KeyList_Open().

	INIFile(std::string filename);
	INIFile(SDL_RWops * RWopsFile);
	~INIFile();

	std::string getStringValue(std::string section, std::string key, std::string defaultValue = "");
	int getIntValue(std::string section, std::string key, int defaultValue = 0);
	bool getBoolValue(std::string section, std::string key, bool defaultValue = false);
	double getDoubleValue(std::string section, std::string key, double defaultValue = 0.0);

	void setStringValue(std::string section, std::string key, std::string value);
	void setIntValue(std::string section, std::string key, int value);
	void setBoolValue(std::string section, std::string key, bool value);
	void setDoubleValue(std::string section, std::string key, double value);

	std::list<std::string> getSectionList();

	KeyListHandle KeyList_Open(std::string sectionname);
	bool KeyList_EOF(KeyListHandle handle);
	std::string KeyList_GetNextKey(KeyListHandle* handle);
	void KeyList_Close(KeyListHandle* handle);

	bool SaveChangesTo(std::string filename);
	bool SaveChangesTo(SDL_RWops * file);


private:
	CommentEntry* FirstLine;
	SectionEntry* SectionRoot;

	void flush();
	void readfile(SDL_RWops * file);

	void InsertSection(SectionEntry* newSection);
	void InsertKey(SectionEntry* section, KeyEntry* newKeyEntry);

	SectionEntry* getSection(std::string sectionname);
	KeyEntry* getKey(SectionEntry* sectionentry, std::string keyname);

	int getNextChar(const unsigned char* line, int startpos);
	int skipName(const unsigned char* line,int startpos);
	int skipValue(const unsigned char* line,int startpos);
	int skipKey(const unsigned char* line,int startpos);
	int getNextQuote(const unsigned char* line,int startpos);

	bool isWhitespace(unsigned char s);
	bool isNormalChar(unsigned char s);
};

#endif // INIFILE_H

