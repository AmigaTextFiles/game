
#ifndef __DIRCACHE_H
#define __DIRCACHE_H

#include "player.h"
#include "dirindex.h"

#define IGNOREFILE ".escignore"

/* abstract interface */
struct dircache {
  
  virtual void destroy () = 0;
  static dircache * create(player * p);
  virtual ~dircache();

  virtual int get(string dir, dirindex *& idx, int & tot, int & sol,
		  void (*progress)(void * d, int n, int total, 
				   const string & subdir) = 0,
		  void * pd = 0) = 0;

};

#endif
