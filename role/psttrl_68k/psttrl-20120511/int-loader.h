#ifndef __KSMN_INT_LOADER_H__
#define __KSMN_INT_LOADER_H__

/* FILE */
#include <stdio.h>

struct _int_loader
{
  FILE *fp;
  int line_number;
  int error_found;
  char *error_message;
  char *buffer;
  int buffer_length;
};
typedef struct _int_loader int_loader;

int_loader *int_loader_new(const char *file_name);
void int_loader_delete(int_loader *p);
int int_loader_get(int_loader *p);

#endif /* not __KSMN_INT_LOADER_H__ */
