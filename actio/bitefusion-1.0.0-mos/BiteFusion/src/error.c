#if WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "error.h"

void info(const char* format, ...)
{
  va_list args;

  va_start(args, format);

  vfprintf(stderr, format, args);
  fwrite("\n", 1, 1, stderr);
}

void fatal_error(const char* format, ...)
{
  va_list args;

  va_start(args, format);

#if WIN32
  char buf[512];

  vsnprintf(buf, sizeof(buf), format, args);
  buf[sizeof(buf) - 1] = 0;

  MessageBox(0, buf, "Fatal Error", MB_OK | MB_ICONEXCLAMATION);
#else
  vfprintf(stderr, format, args);
  fwrite("\n", 1, 1, stderr);
#endif

  exit(EXIT_FAILURE);
}
