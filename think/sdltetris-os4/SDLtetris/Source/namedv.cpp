#include "namedv.h"
#include <map>
#include <string>
#include <stdlib.h>

using namespace std;

int namedv::geti (string name)
{
	return(atoi(m[name].c_str()));
}

string &namedv::operator[](string key)
{
	return(m[key]);
}
