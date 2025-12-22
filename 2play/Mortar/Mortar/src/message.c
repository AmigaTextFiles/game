/* 
 * MORTAR
 * 
 * -- language file loading and message printing
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"

#define DEF_LANG  "english"
#define DEF_WARN  "language '%s' is not supported, defaulting to '%s'.\n"
#define DEF_ERROR "language file loading failed!\n"

static char *String[ALL_STRINGS];


/* load and parse language file
 */
int msg_language(char *lang)
{
  char *src, **dst;
  int size, count;
  struct stat st;
  FILE *fp;

  if (lang) {
    if (stat(lang, &st)) {
      fprintf(stderr, DEF_WARN, lang, DEF_LANG);
      lang = NULL;
    }
  }
  if (!lang) {
    lang = DEF_LANG;
    if (stat(lang, &st)) {
      fprintf(stderr, "'%s' not found. %s\n", lang, DEF_ERROR);
      return 0;
    }
  }

  if (!st.st_size) {
    fprintf(stderr, "'%s' file empty. %s\n", lang, DEF_ERROR);
    return 0;
  }

  fp = fopen(lang, "rb");
  if (!fp) {
    fprintf(stderr, "file '%s' open failed. '%s'\n", lang, DEF_ERROR);
    return 0;
  }

  if (String[0]) {
    free(String[0]);
  }

  size = st.st_size;
  src = malloc(size+1);
  if (!src) {
    fprintf(stderr, "alloc failed: '%s' %s\n", lang, DEF_ERROR);
    fclose(fp);
    return 0;
  }
  size = fread(src, 1, size, fp);
  src[size] = 0;
  fclose(fp);

  if (size != st.st_size) {
    fprintf(stderr, "read failed: '%s' %s\n", lang, DEF_ERROR);
    free(src);
    return 0;
  }

  dst = String;
  count = ALL_STRINGS-1;
  while (--count >= 0) {

    *dst++ = src;
    /* search next line */
    while (size-- > 0 && *src++ != '\n')
      ;

    if (size <= 0) {
      fprintf(stderr, "'%s' file too short: %s\n", lang, DEF_ERROR);
      String[0] = NULL;
      free(src);
      return 0;
    }
    /* terminate C string */
    *(src-1) = 0;
  }
  /* multiline usage string */
  *dst++ = src;

  dst = String;
  count = USER_TYPES;
  while (--count >= 0) {
    /* clip type names to acceptable lenght */
    if (strlen(*dst) > MAX_TYPELEN) {
      (*dst)[MAX_TYPELEN] = '\0';
    }
    dst++;
  }

  msg_print(MSG_LANGUAGE);
  return 1;
}


m_uchar *msg_string(int msg)
{
#ifdef DEBUG
  if (!IS_STRING(msg)) {
fprintf(stderr, "mortar: message.c/msg_string() called with an illegal argument!\n");
    return NULL;
  }
#endif
  return String[msg];
}


void msg_print(int msg)
{
#ifdef DEBUG
  if (!(IS_ERROR(msg) || IS_MESSAGE(msg))) {
fprintf(stderr, "mortar: message.c/msg_print() called with an illegal value!\n");
    return;
  }
#endif

  if (IS_ERROR(msg)) {
    fprintf(stderr, "\n%s: %s.\n",
      String[ERR_FATAL],
      String[msg]);
  } else {
    /* these are printed as is */
    fprintf(stdout, "%s\n", String[msg]);
    fflush(stdout);
  }
}
