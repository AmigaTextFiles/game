#include <stdio.h>
/* malloc */
#include <stdlib.h>
/* errno */
#include <errno.h>
/* strerror */
#include <string.h>

#include "util.h"

#include "int-loader.h"

int_loader *
int_loader_new(const char *file_name)
{
  int length;
  char *buf = NULL;
  int_loader *p = NULL;

  p = (int_loader *) malloc(sizeof(int_loader));
  if (p == NULL)
  {
    fprintf(stderr, "int_loader_new: malloc(p) failed\n");
    return NULL;
  }

  p->fp = NULL;
  p->line_number = 0;
  p->error_found = 0;
  p->error_message = NULL;
  p->buffer = NULL;
  p->buffer_length = 0;

  length = 128;
  buf = (char *) malloc(sizeof(char) * length);
  if (buf == NULL)
  {
    fprintf(stderr, "int_loader_new: malloc(buf) failed\n");
    int_loader_delete(p);
    p = NULL;
    return NULL;
  }
  p->buffer = buf;
  p->buffer_length = length;

  errno = 0;
  p->fp = fopen(file_name, "r");
  if (p->fp == NULL)
  {
    p->error_found = 1;
    if (p->error_message == NULL)
    {
      if (errno != 0)
        p->error_message = concat_string(1, strerror(errno));
      else
        p->error_message = concat_string(1, "unknown fopen error");
    }
    return p;
  }

  return p;
}

void
int_loader_delete(int_loader *p)
{
  if (p == NULL)
    return;

  if (p->fp != NULL)
  {
    errno = 0;
    if (fclose(p->fp) != 0)
    { 
      fprintf(stderr, "int_loader_delete: fclose failed");
      if (errno != 0)
        fprintf(stderr, " (%s)", strerror(errno));
      fprintf(stderr, "\n");
    }
    p->fp = NULL;
  }
  if (p->error_message != NULL)
  {
    free(p->error_message);
    p->error_message = NULL;
  }
  if (p->buffer != NULL)
  {
    free(p->buffer);
    p->buffer = NULL;
  }
  free(p);
  p = NULL;
}

int
int_loader_get(int_loader *p)
{
  int c;
  int n;
  int length;
  int value;
  char *buf = NULL;

  if (p == NULL)
  {
    fprintf(stderr, "int_loader_get: p is NULL\n");
    return 0;
  }

  if (p->error_found != 0)
    return 0;

  if (p->fp == NULL)
  {
    p->error_found = 1;
    if (p->error_message == NULL)
      p->error_message = concat_string(1, "fp is NULL");
    return 0;
  }
  if (p->buffer == NULL)
  {
    p->error_found = 1;
    if (p->error_message == NULL)
      p->error_message = concat_string(1, "buffer is NULL");
    return 0;
  }

  do
  {    
    n = 0;
    p->line_number++;
    while (1 == 1)
    {
      errno = 0;
      c = getc(p->fp);
      if (errno != 0)
      {
        p->error_found = 1;
        if (p->error_message == NULL)
          p->error_message = concat_string(1, strerror(errno));
        return 0;
      }
      if (c == EOF)
      {
        p->error_found = 1;
        if (p->error_message == NULL)
          p->error_message = concat_string(1, "end of file reached");
        return 0;
      }
      if (c == '\n')
        break;
      p->buffer[n] = c;
      n++;
      if (n >= p->buffer_length)
      {
        length = p->buffer_length * 2;
        if (length <= 0)
        {
          p->error_found = 1;
          if (p->error_message == NULL)
            p->error_message = concat_string(1, "buffer_length overflowed");
          return 0;
        }
        buf = (char *) realloc(p->buffer, sizeof(char) * length);
        if (buf == NULL)
        {
          p->error_found = 1;
          if (p->error_message == NULL)
            p->error_message = concat_string(1, "realloc failed");
          return 0;
        }
        p->buffer = buf;
      }
    }
    p->buffer[n] = '\0';
  } while ((p->buffer[0] == '#') || (p->buffer[0] == '\0'));

  if (str_to_int(&value, p->buffer, 1) != 0)
  {
    p->error_found = 1;
    if (p->error_message == NULL)
      p->error_message = concat_string(1, "str_to_int failed");
    return 0;
  }

  return value;
}
