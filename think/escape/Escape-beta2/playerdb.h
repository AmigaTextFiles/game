
#ifndef __PLAYERDB_H
#define __PLAYERDB_H

#include "player.h"
#include <string>
#include "selector.h"


using namespace std;

/* abstract interface */
struct playerdb {

  static playerdb * fromstring(string);
  virtual string tostring() = 0;

  /* make db with one player, 'Default' */
  static playerdb * create();

  virtual void destroy() = 0;

  virtual player * chooseplayer() = 0;

  virtual ~playerdb () {}

};

#endif

