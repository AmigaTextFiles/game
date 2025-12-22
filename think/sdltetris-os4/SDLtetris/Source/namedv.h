#ifndef NAMEDV_H
#define NAMEDV_H

#include <map>
#include <vector>
#include <string>

using namespace std;

class namedv
{
	public:
	map<string, string> m;
	vector<string> format;
	int geti (string name);
	string &operator[](string key);
};

#endif
