/***************************************************************************
                        stringzeug.h  -  description
                             -------------------
    begin                : Mon Mar 20 2006
    copyright            : (C) 2006 by Mark Weyer
    email                : cuyo-devel@nongnu.org
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include "stringzeug.h"
#include "fehler.h"

#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>



Str::Str(const std::string & s) : inhalt(s) {}
Str::Str() : inhalt("") {}
Str::Str(const char * inhalt_) : inhalt(inhalt_) {CASSERT(inhalt_);}
Str::Str(const Str & s) : inhalt(s.inhalt) {}

bool Str::isEmpty() const {return inhalt.empty();}
int Str::length() const {return inhalt.length();}
char Str::operator [] (int i) const {
  CASSERT(i>=0);
  CASSERT((unsigned int) i<inhalt.length());
  return inhalt[i];
}
char & Str::operator [] (int i) {
  CASSERT(i>=0);
  CASSERT((unsigned int) i<inhalt.length());
  return inhalt[i];
}

const char * Str::data() const {return inhalt.c_str();}

Str Str::left(int l) const {return inhalt.substr(0,l);}
Str Str::mid(int s, int l) const {return inhalt.substr(s,l);}
Str Str::right(int s) const {return inhalt.substr(s);}

void Str::operator += (char c) {inhalt+=c;}
void Str::operator += (const Str & s) {inhalt += s.inhalt;}

bool Str::operator == (const Str & s) const {
  return inhalt == s.inhalt;
}

bool Str::operator < (const Str & s) const {
  return inhalt < s.inhalt;
}

bool Str::operator != (const Str & s) const {
  return inhalt != s.inhalt;
}

bool Str::operator != (const char * s) const {
  CASSERT(s);
  return inhalt != s;
}




Str operator + (const Str & s1, const Str & s2) {
  return s1.inhalt + s2.inhalt;
}

Str operator + (const Str & s1, const char * s2) {
  CASSERT(s2);
  return s1.inhalt + s2;
}

Str operator + (const Str & s, char c) {
  return s.inhalt + c;
}

Str operator + (char c, const Str & s) {
  return c + s.inhalt;
}

Str _sprintf(const char * format, ...) {
  va_list ap;
  va_start(ap, format);
  Str ret = _vsprintf(format, ap);
  va_end(ap);
  return ret;
}



/* Ab jetzt arbeiten wir auf _vsprintf hin. */

inline void grossgenug(char * & puffer, size_t & groesse, size_t pos) {
  /* Macht puffer, der die Größe groesse hat, notfalls länger,
     so daß hinterher groesse>pos.
     groesse und pos sind in Zellen, also nicht offiziell in byte. */
  if (groesse<=pos) {
    /* Mindestens verdoppeln und mindestens ziel. */
    size_t neue_groesse = 2*groesse;
    if (neue_groesse<=pos) neue_groesse=pos+1;
    CASSERT(neue_groesse);
    puffer = (char*) realloc((void*) puffer, neue_groesse*sizeof(char));
    CASSERT(puffer);
    groesse = neue_groesse;
  }
}

inline void schreib_char(char * & puffer, size_t & groesse, size_t & pos,
			 char c) {
  grossgenug(puffer,groesse,pos);
  puffer[pos++]=c;
}

void schreib_int_intern(char * & puffer, size_t & groesse, size_t & pos,
			unsigned long i) {
  /* Bei i=0 wird nichts ausgegeben. */
  if (i>0) {
    schreib_int_intern(puffer,groesse,pos,i/10);
    schreib_char(puffer,groesse,pos,'0'+i%10);
  }
}

void schreib_int(char * & puffer, size_t & groesse, size_t & pos, long i) {
  if (i<0) {
    schreib_char(puffer,groesse,pos, '-');
    i = -i;
  }
  if (i==0)
    schreib_char(puffer,groesse,pos, '0');
  else
    schreib_int_intern(puffer,groesse,pos, i);
}

inline void schreib_string(char * & puffer, size_t & groesse, size_t & pos,
			   const char * quelle, size_t quellgroesse) {
  if (quellgroesse>0) {
    grossgenug(puffer,groesse,pos+quellgroesse-1);
    memcpy((void*) (puffer+pos), (void*) quelle, quellgroesse*sizeof(char));
    pos+=quellgroesse;
  }
}

Str _vsprintf(const char * format, va_list ap) {
  size_t groesse = 100;
  char * puffer = (char*) malloc(groesse*sizeof(char));
  CASSERT(puffer);
  size_t pos = 0;
  int i=0;   // Aktuelle Position in format
  int von=0; // Erste noch nicht kopierte Position in format

  for (; format[i]; i++)
    if (format[i]=='%') {
      schreib_string(puffer,groesse,pos, format+von, i-von);
      i++;
      switch (format[i]) {
        case 'c':
	  schreib_char(puffer,groesse,pos, (char) va_arg(ap,int));
	  break;
        case 'd':
	  schreib_int(puffer,groesse,pos, va_arg(ap,int));
	  break;
        case 'l':
	  i++;
	  switch (format[i])
	    case 'd': {
	      schreib_int(puffer,groesse,pos, va_arg(ap,long));
	      break;
 	    default:
	      throw iFehler("Internal error in _vsprintf: \"%cl%c\" in format strings können wir (noch) nicht.",
			    '%',format[i]);
	      break;
	  }
	  break;
        case 's': {
	  const char * s = va_arg(ap,const char *);
	  int l=0;
	  for (; s[l]; l++) {}
	  schreib_string(puffer,groesse,pos, s,l);
	  break;
	}
        default:
	  throw iFehler(
            "Internal error in _vsprintf: \"%c%c\" in format strings können wir (noch) nicht.",
	    '%',format[i]);
	  break;
      }
      von=i+1;  // i wird durch die Schleife gleich noch mal erhöht.
    }

  schreib_string(puffer,groesse,pos, format+von, i-von+1);
    // Einschließlich der 0 am Ende

  Str ret = puffer;
  free((void*) puffer);
  return ret;
}


//Str _vsprintf(const char * format, va_list ap) {
//  /* Copied from the sprintf man page (and adapted): */
//  /* Guess we need no more than 100 bytes. */
//  int n, size = 100;
//  char *p;
//  CASSERT(p = (char *) malloc(size));
//
//  while (1) {
//    /* Try to print in the allocated space. */
//    n = vsnprintf(p, size, format, ap);
//    /* If that worked, return the string. */
//    if (n > -1 && n < size)
//       break;
//    /* Else try again with more space. */
//    if (n > -1)    /* glibc 2.1 */
//       size = n+1; /* precisely what is needed */
//    else           /* glibc 2.0 */
//       size *= 2;  /* twice the old size */
//    CASSERT(p = (char *) realloc(p, size));
//  }
//  
//  Str ret = p;
//  free(p);
//  return ret;
//}


