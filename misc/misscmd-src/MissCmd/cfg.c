#include "main.h"

int CFGBoolean (char * attr) {
	char * val;
	val = FindToolType(global->icon->do_ToolTypes, attr);
	if (!val) return FALSE;
	if (!stricmp(val, "no") || !stricmp(val, "false") || !stricmp(val, "off")) return FALSE;
	return TRUE;
}

int32 CFGInteger (char * attr, int32 def) {
	char * val;
	val = FindToolType(global->icon->do_ToolTypes, attr);
	return val ? atol(val) : def;
}

char *CFGString (char * attr, char * def) {
	char * val;
	val = FindToolType(global->icon->do_ToolTypes, attr);
	return val ? val : def;
}
