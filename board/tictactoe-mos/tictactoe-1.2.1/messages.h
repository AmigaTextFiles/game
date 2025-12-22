#ifndef __MESSAGES__H__
#define __MESSAGES__H__
void print_debug(const char *fmt, ...);
void print_error(const char *str);
void print_msg(const char *fmt, ...);

extern char debug;
#endif
