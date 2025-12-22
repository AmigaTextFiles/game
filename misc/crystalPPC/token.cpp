#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

//---------------------------------------------------------------------------

char* spaces = "                                                                                  ";

float get_token_float (char** buf)
{
  char* t = get_token (buf);
  if (!((*t >= '0' && *t <= '9') || *t == '-' || *t == '.'))
  {
    printf ("Expected a floating point number! Got '%s' instead!\n", t);
    exit (0);
  }
  float rc;
  sscanf (t, "%f", &rc);
  return rc;
}

int get_token_int (char** buf)
{
  char* t = get_token (buf);
  if (!((*t >= '0' && *t <= '9') || *t == '-'))
  {
    printf ("Expected an integer number! Got '%s' instead!\n", t);
    exit (0);
  }
  int rc;
  sscanf (t, "%d", &rc);
  return rc;
}

char* get_token (char** buf)
{
  static char token[100];
  char* b = *buf, * t = token;
  while (TRUE)
  {
    while (*b && (*b == ' ' || *b == '\n' || *b == 13 || *b == 10 || *b == '\t')) b++;
    if (*b == ';')
      while (*b && *b != '\n' && *b != 13 && *b != 10) b++;
    else break;
  }

  if (*b == '\'')
  {
    b++;
    while (*b && *b != '\'') { *t++ = *b++; }
    *t++ = 0;
    if (*b == '\'') b++;
  }
  else if (*b == '(' || *b == ')' || *b == '=' || *b == ',' || *b == '[' || *b == ']' ||
        *b == '%' || *b == ':' || *b == '{' || *b == '}')
  {
    *t++ = *b++;
    *t++ = 0;
  }
  else if ((*b >= '0' && *b <= '9') || *b == '.' || *b == '-')
  {
    while (*b && ((*b >= '0' && *b <= '9') || *b == '.' || *b == '-')) { *t++ = *b++; }
    *t++ = 0;
  }
  else if ((*b >= 'A' && *b <= 'Z') || (*b >= 'a' && *b <= 'z') || *b == '_')
  {
    while (*b && ((*b >= 'A' && *b <= 'Z') || (*b >= 'a' && *b <= 'z') || *b == '_')) { *t++ = *b++; }
    *t++ = 0;
  }
  else if (*b == 0)
  {
    *buf = b;
    return NULL;
  }
  else printf ("Que (%c%c%c%c%c...)?\n", *b, *(b+1), *(b+2), *(b+3), *(b+4));

  *buf = b;
  return token;
}
//vonmir
//#ifdef COMP_WCC

//ersatzlos gestrichen
//

void skip_token (char** buf, char* tok){skip_token (buf, tok, NULL);}
void skip_token (char** buf, char* tok, char* msg)

//vonmir
//#else
//void skip_token (char** buf, char* tok, char* msg = NULL)
//#endif

//ersatzlos gestrichen
//
{
  char* t = get_token (buf);
  if (strcmp (t, tok))
    if (msg) printf (msg, tok, t);
    else printf ("Expected '%s' instead of '%s'!\n", tok, t);
}

//---------------------------------------------------------------------------
