#include <stdio.h>
#include "error.h"

extern int Int3_error_verbose;

void error_int3(char *s, int l) {

	if (Int3_error_verbose == 0) return;

	printf("Int3 error in line %d of %s\n", l, s);
}

