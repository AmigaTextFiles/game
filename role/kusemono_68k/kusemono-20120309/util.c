#include <stdio.h>
/* malloc */
#include <stdlib.h>
/* strlen, strcpy */
#include <string.h>
/* errno */
#include <errno.h>
/* INT_MIN, INT_MAX */
#include <limits.h>
/* va_start, va_arg, va_end */
#include <stdarg.h>

#include "util.h"

char *
concat_string(int num_string, ...)
{
  va_list ap;
  int i;
  int result_length;
  char *result = NULL;
  char *head = NULL;
  const char *s = NULL;

  if (num_string < 0)
  {
    fprintf(stderr, "concat_string: num_string is NULL\n");
    return NULL;
  }

  result_length = 0;
  va_start(ap, num_string);
  for (i = 0; i < num_string; i++)
  {
    s = va_arg(ap, const char *);
    if (s != NULL)
      result_length += strlen(s);
  }
  va_end(ap);

  if (result_length < 0)
  {
    fprintf(stderr, "concat_string: result_length overflowed\n");
    return NULL;
  }

  /* +1 is for the trailing '\0' */
  result = (char *) malloc(sizeof(char) * (result_length + 1));
  if (result == NULL)
  {
    fprintf(stderr, "concat_string: malloc failed\n");
    return NULL;
  }

  head = result;
  va_start(ap, num_string);
  for (i = 0; i < num_string; i++)
  {
    s = va_arg(ap, const char *);
    if (s != NULL)
    {
      strcpy(head, s);
      head += strlen(s);
    }
  }
  va_end(ap);

  *head = '\0';
  return result;
}

/* convert string (arg 2) to a number and store it to value (arg 1)
 * return 0 on success, 1 on error
 */
int
str_to_int(int *value, const char *string, int quiet)
{
  long int temp;
  char *tail;

  if (value == NULL)
  {
    fprintf(stderr, "str_to_int: value is NULL\n");
    return 1;
  }
  if (string == NULL)
  {
    fprintf(stderr, "str_to_int: string is NULL\n");
    return 1;
  }

  /* to detect overflow */
  errno = 0;
  temp = strtol(string, &tail, 0);
  if (tail[0] != '\0')
  {
    if (!quiet)
      fprintf(stderr, "str_to_int: string is not a number\n");
    return 1;
  }
  if (errno != 0)
  {
    if (!quiet)
      fprintf(stderr, "str_to_int: number overflowed\n");
    return 1;
  }
  if ((temp <= INT_MIN) || (temp >= INT_MAX))
  {
    if (!quiet)
      fprintf(stderr, "str_to_int: too big or small integer\n");
    return 1;
  }

  *value = (int) temp;
  return 0;
}
