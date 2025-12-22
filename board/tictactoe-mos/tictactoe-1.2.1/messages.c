#include <stdio.h>
#include <stdarg.h>
#include <unistd.h>
#include "messages.h"

char debug=0;

void print_debug(const char *fmt, ...) {
	va_list args;

	if(debug) {
		fprintf(stderr, "Debug: ");
		va_start(args, fmt);
		vfprintf(stderr, fmt, args);
		va_end(args);
		fprintf(stderr, "\n");
	}
}

void print_error(const char *str) {
	fprintf(stderr, "Error: %s\n", str);
}

void print_msg(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	if(isatty(1))
		vfprintf(stdout, fmt, args);
	else
		vfprintf(stderr, fmt, args);
	va_end(args);
}

