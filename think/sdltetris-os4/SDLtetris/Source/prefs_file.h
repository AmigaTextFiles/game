#ifndef PREFS_FILE_H
#define PREFS_FILE_H

#include <string>

#include "namedv.h"

using namespace std;

namespace prefs_file
{
	int read (const char *filename, namedv *nv);
	bool save (const char *filename, namedv *nv);
	string readUntil (string str, int *end, char until);
};

#endif
