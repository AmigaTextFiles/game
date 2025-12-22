#ifndef INKOMPATIBEL_H
#define INKOMPATIBEL_H

/* Sollte immer das erste sein, was included wird (falls irgendwelche
   bools oder so definiert werden). */
#include <config.h>



#ifndef HAVE_LIBZ
#define HAVE_LIBZ 0
#endif


#ifdef WIN32
/* Ob das folgende die beste Lösung für Windows ist, weiß ich nicht.
   Aber es ist eine. */s
#ifndef PKGDATADIR
#define PKGDATADIR (PACKAGE"-"VERSION"\\data")
#endif

/* Windows: Default hat kein getopt */
#ifndef HAVE_GETOPT
#define HAVE_GETOPT 0
#endif

#else
/* Nicht Windows: Default hat getopt */
#ifndef HAVE_GETOPT
#define HAVE_GETOPT 1
#endif

#endif



#endif

