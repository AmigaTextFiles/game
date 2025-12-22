/* 
 * MORTAR
 * 
 * -- configuration file parsing
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mortar.h"


/* max. configuration file line lenght */
#define MAX_LINELEN 256

/* list item containing a (variable,value) pair from the W toolkit user
 * configuration file.
 */
typedef struct _variable_t {
  struct _variable_t *next;
  char *variable;
  char *value;
} variable_t;


/* configuration variable / value pairs */
static variable_t *Variables;


/* read given configuration file
 *
 * search and allocate a list of configuration (variable, value) pairs and
 * set global options according to them or link them to Variables list.
 */
int read_config(char *config)
{
  char c, *line, *value, buffer[MAX_LINELEN];
  int idx, eq;
  variable_t *ptr;
  FILE *fp;

  if(!(fp = fopen(config, "r"))) {
    /* no configuration file */
    return 0;
  }

  /* read configuration variables */
  while (fgets(buffer, MAX_LINELEN, fp)) {

    line = buffer;
    /* search variable start */
    while(*line && *line <= 32) {
      line++;
    }

    eq = 0;
    for (idx = 0; idx < MAX_LINELEN && line[idx]; idx++) {
      c = line[idx];
      /* search value end */
      if ((c < 32 && c != '\t') || c == '#') {
        break;
      }
      if (c == '=') {
        /* variable end / value start */
        eq = idx;
      }
    }
    if (!eq) {
      continue;
    }

    /* remove white space at the end and start of the value */
    while(--idx > eq && line[idx] < 32)
      ;
    line[++idx] = 0;
    value = line + eq;
    while(*++value && *value <= 32)
      ;

    /* remove white space at the end of variable name */
    while(line[--eq] <= 32)
      ;
    line[++eq] = 0;

    idx = (line + idx) - value;
    /* 'eq' got now variable and 'idx' value lenght */


    /* link into variables list */

    ptr = malloc(sizeof(variable_t)  + eq + idx + 2);
    ptr->variable = (char *)ptr + sizeof(variable_t);
    ptr->value = ptr->variable + eq + 1;

    strcpy(ptr->variable, line);
    strcpy(ptr->value, value);

    ptr->next = Variables;
    Variables = ptr;
  }
  fclose(fp);
  return 1;
}


/* search the variable list for given variable and return it's value
 * string or NULL
 */
char *get_string(char *id)
{
  variable_t *ptr = Variables;

  while(ptr) {
    if (!strcmp(id, ptr->variable)) {
      fprintf(stdout, "%s = %s\n", id, ptr->value);
      return ptr->value;
    }
    ptr = ptr->next;
  }
  fprintf(stderr, "%s = *?*\n", id);
  return NULL;
}

int get_value(char *id)
{
  char *value;

  value = get_string(id);
  if (value) {
    return atoi(value);
  }
  return 0;
}

float get_float(char *id)
{
  char *value;

  value = get_string(id);
  if (value) {
    return atof(value);
  }
  return 0;
}
