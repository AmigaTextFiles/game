
#ifndef __PLAYER_H
#define __PLAYER_H

#include "level.h"
#include "hashtable.h"
#include "rating.h"
#include "util.h"
#include "chunks.h"

/* Database for a single player.
   Stores his solutions, mainly.
   Also now stores his ratings.
*/

struct namedsolution {
  string name;
  solution * sol;
  string author;
  int date;
  namedsolution(solution * s, string na = "Untitled", 
		string au = "Unknown", int da = 0);
  string tostring();
  static namedsolution * fromstring(string);
  void destroy();
  static int compare(namedsolution *, namedsolution *);
  namedsolution(); /* needed for selector */
};

/* interface only */
struct player {
  string fname;
  string name;

  /* online stuff : not used yet */
  /* Unique id online */
  int webid;
  /* secrets */
  int webseqh;
  int webseql;

  virtual void destroy () = 0;

  static player * create(string n);
  static player * fromfile(string file);

  /* returns the chunk structure for this
     player. After making any changes
     (insertions, modifications), call
     writefile to save them. Don't free
     the chunks */
  virtual chunks * getchunks() = 0;

  /* get the solution (if any) for the map
     whose md5 representation is "md5".
     don't free the solution! */
  virtual solution * getsol(string md5) = 0;

  virtual rating * getrating(string md5) = 0;
  
  /* add solution to the database.
     if a solution already exists, overwrite
     it if this one is shorter.
     (in any case, take ownership of sol pointer)

     true if there was a change to the player db.

     Since we now support multiple solutions, this will
     overwrite the "default" solution, if one exists.
     XXX need a mechanism for *adding* a new solution
     to the solution set, and listing them, etc.
  */
  virtual bool putsol(string md5, solution * sol, bool append = false) = 0;

  /* ditto, always overwriting an existing rating. 
     there is just one rating per level. */
  virtual void putrating(string md5, rating * rat) = 0;

  /* record a change on disk. this will also manage
     backups of the player file. */
  virtual bool writefile() = 0;

  virtual int num_solutions() = 0;
  virtual int num_ratings() = 0;

  /* for solution recovery; get every solution in
     the player, regardless of the level it is for */
  virtual ptrlist<solution> * all_solutions() = 0;

  /* return the solution set (perhaps empty) for the level indicated.
     the list remains owned by the player */
  virtual ptrlist<namedsolution> * solutionset(string md5) = 0;
  /* frees anything that it overwrites, including the solutions. So
     calling setsolutionset on the set returned from solutionset
     without cloning the solutions first will prematurely free them */
  virtual void setsolutionset(string md5, ptrlist<namedsolution> *) = 0;

  virtual ~player() {};

};

#endif
