#include <string>
#include <fstream>

#include "prefs_file.h"
#include "namedv.h"

using namespace std;

int prefs_file::read (const char *filename, namedv *nv)
{
	ifstream file(filename);
	if (!file.bad())
	{
		string line;
		while (getline(file, line) != 0)
		{
			if (line != "")
			{
				int start;
				string key = readUntil(line, &start, ':');
				if (line[start] == ' ') start++;
				(*nv)[key] = line.substr(start, line.size());
				nv->format.push_back(key);
			} else {
				nv->format.push_back("");
			}
		}
		return 0;
	} else {
		return 1;
	}
}

bool prefs_file::save (const char *filename, namedv *nv)
{
	ofstream file(filename);
	if (!file.bad())
	{
		map<string, bool> saved;
		for (unsigned int i = 0; i < nv->format.size(); i++)
		{
			if (nv->format[i] != "")
			{
				string key = nv->format[i];
				file << key << ": " << (*nv)[key];
				saved[key] = true;
			}
			file << "\n";
		}
		for (map<string, string>::iterator iter = nv->m.begin(); iter != nv->m.end(); ++iter)
		{
			if (saved[iter->first] != true)
			{
				file << iter->first << ": " << iter->second << "\n";
			}
		}
		return(true);
	} else {
		return(false);
	}
}

string prefs_file::readUntil (string str, int *end, char until)
{
	for (unsigned int i = 0; i < str.size(); i++)
	{
		if (str[i] == until)
		{
			*end = i+1;
			return(str.substr(0, i));
		}
	}
	*end = str.size();
	return(string(""));
}
