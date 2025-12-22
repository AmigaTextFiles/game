
#include "player.h"

#include "extent.h"
#include "chunks.h"
#include "checkfile.h"
#include "prefs.h"
#include "dirent.h"

#include "base64.h"
#include "md5.h"

#ifdef WIN32
# include <time.h>
#endif

#define HASHSIZE 512

#define PLAYER_MAGIC "ESXP"
#define PLAYERTEXT_MAGIC "ESPt"
#define PLAYER_MAGICS_LENGTH 4
#define SOLMARKER "-- solutions"
#define RATMARKER "-- ratings"
#define PREFMARKER "-- prefs"

/* give some leeway for future expansion */
#define IGNORED_FIELDS 8

namedsolution::namedsolution() {
  name = "";
  sol = 0;
  author = "";
  date = 0;
}

namedsolution::namedsolution(solution * s, string na, 
			     string au, int da) {
  name = na;
  sol = s;
  author = au;
  date = da;
}

string namedsolution::tostring () {
  string solstring = sol->tostring ();
  return
    sizes(date) +
    sizes(name.length()) + name +
    sizes(author.length()) + author +
    sizes(solstring.length()) + solstring;
}

namedsolution * namedsolution::fromstring (string s) {
  unsigned int idx = 0;
  if (idx + 4 > s.length()) return 0; int d = shout(4, s, idx);
  
  if (idx + 4 > s.length()) return 0; int nl = shout(4, s, idx);
  if (idx + nl > s.length()) return 0;
  string na = s.substr(idx, nl);
  idx += nl;
  
  if (idx + 4 > s.length()) return 0; int dl = shout(4, s, idx);
  if (idx + dl > s.length()) return 0;
  string de = s.substr(idx, dl);
  idx += dl;
  
  if (idx + 4 > s.length()) return 0; int sl = shout(4, s, idx);
  if (idx + sl > s.length()) return 0;
  string ss = s.substr(idx, sl);
  idx += sl;
  
  solution * so = solution::fromstring(ss);
  if (!so) return 0;
  
  return new namedsolution(so, na, de, d);
}

void namedsolution::destroy () {
  sol->destroy ();
}

int namedsolution::compare(namedsolution * l, namedsolution * r) {
  /* PERF */
  return l->tostring().compare(r->tostring());
}

typedef ptrlist<namedsolution> nslist;

struct hashsolsetentry {
  string md5;
  nslist * solset;
  static unsigned int hash(string k);
  string key() { return md5; }
  void destroy() { 
    while (solset) nslist::pop(solset)->destroy();
    delete this; 
  }
  hashsolsetentry(string m, nslist * s) : md5(m), solset(s) {}
  static int compare(hashsolsetentry * l, hashsolsetentry * r) {
    return l->md5.compare(r->md5);
  }
};

struct hashratentry {
  string md5;
  rating * rat;
  static unsigned int hash(string k);
  string key() { return md5; }
  void destroy() { rat->destroy(); delete this; }
  hashratentry(string m, rating * r) : md5(m), rat(r) {}
  static int compare(hashratentry * l, hashratentry * r) {
    return l->md5.compare(r->md5);
  }
};


struct playerreal : public player {

  void destroy ();

  static playerreal * create(string n);

  chunks * getchunks() { return ch; }

  solution * getsol(string md5);

  rating * getrating(string md5);
  
  bool putsol(string md5, solution * sol, bool append = false);

  void putrating(string md5, rating * rat);

  bool writefile();

  static playerreal * fromfile(string file);
  /* call with file already open with cursor
     after the player magic. (Also pass filename
     since the player remembers this.)
     caller will close checkfile */
  static playerreal * fromfile_text(string fname, checkfile *);
  static playerreal * fromfile_bin(string, checkfile *);

  /* XX this one is wrong now; it returns "levels solved"
     not total number of solutions */
  int num_solutions() { return sotable->items; }
  int num_ratings() { return ratable->items; }

  ptrlist<solution> * all_solutions();

  virtual ~playerreal() {};

  private:

  void deleteoldbackups();
  static string backupfile(string fname, int epoch);
  bool writef(string);
  bool writef_binary(string);
  bool writef_text(string);

  hashtable<hashsolsetentry, string> * sotable;
  hashtable<hashratentry, string> * ratable;

  virtual ptrlist<namedsolution> * solutionset(string md5);
  virtual void setsolutionset(string md5, ptrlist<namedsolution> *);

  chunks * ch;

};

ptrlist<solution> * playerreal::all_solutions() {
  ptrlist<solution> * l = 0;

  for(int i = 0; i < sotable->allocated; i ++) {
    ptrlist<hashsolsetentry> * col = sotable->data[i];
    while(col) {
      nslist * these = col->head->solset;
      while (these) {
	l = new ptrlist<solution>(these->head->sol, l);
	these = these -> next;
      }
      col = col -> next;
    }
  }
  return l;
}

/* XXX these two should be in some general util file ... */
/* endianness doesn't matter here */
unsigned int hashsolsetentry::hash(string k) {
  return *(unsigned int*)(k.c_str());
}

unsigned int hashratentry::hash(string k) {
  return *(unsigned int*)(k.c_str());
}

void playerreal::destroy() {
  sotable->destroy();
  ratable->destroy();
  if (ch) ch->destroy();
  delete this;
}

player * player::create(string n) {
  return playerreal::create(n);
}

playerreal * playerreal::create(string n) {
  playerreal * p = new playerreal();
  if (!p) return 0;
  extent<playerreal> e(p);
  
  p->name = n;
  
  p->sotable = hashtable<hashsolsetentry,string>::create(HASHSIZE);
  p->ratable = hashtable<hashratentry,string>::create(HASHSIZE);

  p->ch = chunks::create();

  p->webid = 0;
  p->webseqh = 0;
  p->webseql = 0;

  if (!p->sotable) return 0;
  if (!p->ratable) return 0;
  if (!p->ch) return 0;

  /* set default preferences */
  prefs::defaults(p);

  e.release();
  return p;
}

solution * playerreal::getsol(string md5) {
  nslist * l = solutionset(md5);
  if (!l) return 0;
  else return l->head->sol;
}

nslist * playerreal::solutionset(string md5) {
  hashsolsetentry * he = sotable->lookup(md5);

  if (he) return he->solset;
  else return 0;
}

void playerreal::setsolutionset(string md5, nslist * ss) {
  hashsolsetentry * he = sotable->lookup(md5);

  if (he) {
    nslist * old = he->solset;
    he->solset = ss;
    /* delete old */
    while (old) nslist::pop(old)->destroy();
  } else {
    sotable->insert(new hashsolsetentry(md5, ss));
  }
}


rating * playerreal::getrating(string md5) {
  hashratentry * re = ratable->lookup(md5);
  
  if (re) return re->rat;
  else return 0;
}

bool playerreal::putsol(string md5, solution * sol, bool append) {

  hashsolsetentry * he = sotable->lookup(md5);

  if (he && he->solset) {

    namedsolution * headsol = he->solset->head;

    /* always add, even if it's worse */
    if (append) {
      int date = time(0);

      namedsolution * ns = new namedsolution(sol, "Untitled", name, date);

      /* prepend to list (becomes new default) */
      he->solset = new nslist(ns, he->solset);
      return 1;
    } else if (sol->length < headsol->sol->length) {
      /* replace */
      headsol->sol->destroy ();
      headsol->sol = sol;
      headsol->name = "Untitled";
      headsol->author = name; /* me! */
      headsol->date = (int)time(0);
      return 1;
    } else {
      /* discard this solution */
      sol->destroy ();
      return 0;
    }

  } else {
    /* there's no solution set; create a new one. */
    namedsolution * ns = new namedsolution(sol, "Untitled", name, (int)time(0));
    nslist * l = new nslist(ns, 0);

    sotable->insert(new hashsolsetentry(md5, l));
    return 1;
  }

}

void playerreal::putrating(string md5, rating * rat) {

  hashratentry * re = ratable->lookup(md5);

  if (re && re->rat) {
    /* overwrite */
    re->rat->destroy();
    re->rat = rat;
  } else ratable->insert(new hashratentry(md5, rat));

}


#if 0 /* no more binary formats */
static void wri(FILE * f, int i) {
  char c[4];
  c[0] = 255 & (i >> 24);
  c[1] = 255 & (i >> 16);
  c[2] = 255 & (i >> 8);
  c[3] = 255 & i;
  fwrite(&c, 4, 1, f);
}
#endif

/* in seconds */
#define BACKUP_FREQ ((24 * (60 * (60 /* minutes */) /* hours */) /* days */) * 5)
#define N_BACKUPS 4

string playerreal::backupfile(string fname, int epoch) {
  return fname + ".~" + itos(epoch);
}

/* get rid of old backups, if any */
void playerreal::deleteoldbackups() {
  DIR * dir = opendir(".");
  if (!dir) return;

  /* XX must agree with backupfile */
  string basename = 
#   ifdef WIN32
        util::lcase(
#   else
	(
#   endif
	  fname + ".~");

  dirent * de;
  int n = 0;
  int oldest = (time(0) / BACKUP_FREQ) + 1 ;
  while ((de = readdir(dir))) {
    string f = 
#     ifdef WIN32
        util::lcase(
#     else
	(
#     endif
      de->d_name);

	if (f.substr(0, basename.length()) ==
	    basename) {
	  int age = atoi(f.substr(basename.length(),
				  f.length() - basename.length())
			 .c_str());

	  /* printf ("saw '%s' with age %d\n", f.c_str(), age); */
	  
	  if (age) {
	    n ++;
	    if (age < oldest) oldest = age;
	  }
	}
  } /* while */

  closedir(dir);

  if (n > N_BACKUPS) {
    
    if (util::remove(basename + itos(oldest))) {
      /* try deleting again */
      /* printf ("deleted backup #%d\n", oldest); */
      deleteoldbackups();
    }
  }
}

bool playerreal::writefile() {

  /* Back up the player file. */
  if (prefs::getbool(this, PREF_BACKUP_PLAYER)) {
    int epoch = time(0) / BACKUP_FREQ;
    
    /* did we already back up in this epoch? */
    string tf = backupfile(fname, epoch);
    if (!util::existsfile(tf)) {
      writef(tf);
 
    }
    deleteoldbackups();
  }

  /* anyway, always write the real file */
  return writef(fname);
}

/* now always write as text file */
bool playerreal::writef(string file) {
  return writef_text(file);
}

bool playerreal::writef_text(string file) {
  FILE * f = fopen(file.c_str(), "wb");

  if (!f) return 0;

  fprintf(f, "%s\n", PLAYERTEXT_MAGIC);
  fprintf(f,
	  "%d\n"
	  "%d\n"
	  "%d\n", webid, webseqh, webseql);

  /* write ignored fields; for later expansion... */
  for(int u = 0 ; u < IGNORED_FIELDS; u ++) fprintf(f, "0\n");
  
  fprintf(f, "%s\n", name.c_str());

  fprintf(f, SOLMARKER "\n");
  /* fprintf(f, "%d\n", sotable->items); */

  {
  for(int i = 0; i < sotable->allocated; i ++) {
    ptrlist<hashsolsetentry>::sort(hashsolsetentry::compare, sotable->data[i]);
    for(ptrlist<hashsolsetentry> * tmp = sotable->data[i]; 
	tmp; 
	tmp = tmp -> next) {
      fprintf(f, "%s * %s\n", md5::ascii(tmp->head->md5).c_str(),
	      /* assume at least one solution */
	      base64::encode(tmp->head->solset->head->tostring()).c_str());
      /* followed by perhaps more solutions marked with @ */
      /* sort them first, in place */
      nslist::sort(namedsolution::compare, tmp->head->solset->next);

      for(nslist * rest = tmp->head->solset->next;
	  rest;
	  rest = rest -> next) {
	fprintf(f, "  %s\n", 
		base64::encode(rest->head->tostring()).c_str());
      }
      /* end it (makes parsing easier) */
      fprintf(f, "!\n");
    }
  }
  }

  fprintf(f, RATMARKER "\n");
  /* fprintf(f, "%d\n", ratable->items); */

  /* ditto... */

  {
  for(int ii = 0; ii < ratable->allocated; ii ++) {
    ptrlist<hashratentry>::sort(hashratentry::compare, ratable->data[ii]);
    for(ptrlist<hashratentry> * tmp = ratable->data[ii]; 
	tmp; 
	tmp = tmp -> next) {
      fprintf(f, "%s %s\n",
	      md5::ascii(tmp->head->md5).c_str(),
	      base64::encode(tmp->head->rat->tostring()).c_str());
    }
  }
  }
  fprintf(f, PREFMARKER "\n");

  /* write chunks */
  /* ch->tostring() */
  fprintf(f, "%s\n", base64::encode(ch->tostring()).c_str());


  fclose(f);
  return 1;
}

#if 0
/* XXX obsolete -- we use text format now always */
bool playerreal::writef_binary(string file) {
  FILE * f = fopen(file.c_str(), "wb");

  if (!f) return 0;

  fwrite(PLAYER_MAGIC, ((string)PLAYER_MAGIC).length(), 1, f);
  wri(f, webid);
  wri(f, webseqh);
  wri(f, webseql);

  /* write ignored fields; for later expansion... */
  for(int u = 0 ; u < IGNORED_FIELDS; u ++) wri(f, 0);
  
  wri(f, name.length());
  
  fwrite(name.c_str(), name.length(), 1, f);

  wri(f, sotable->items);

  /* XXX nice if this process were in hashtable instead
     of here. */

  for(int i = 0; i < sotable->allocated; i ++) {
    for(ptrlist<hashsolentry> * tmp = sotable->data[i]; 
	tmp; 
	tmp = tmp -> next) {
      fwrite(tmp->head->md5.c_str(), 16, 1, f);
      string s = tmp->head->sol->tostring();
      wri(f, s.length());
      fwrite(s.c_str(), s.length(), 1, f);
    }
  }

  wri(f, ratable->items);

  /* ditto... */

  for(int ii = 0; ii < ratable->allocated; ii ++) {
    for(ptrlist<hashratentry> * tmp = ratable->data[ii]; 
	tmp; 
	tmp = tmp -> next) {
      fwrite(tmp->head->md5.c_str(), 16, 1, f);
      string s = tmp->head->rat->tostring();
      /* assert s.length() = RATINGBYTES */
      fwrite(s.c_str(), s.length(), 1, f);
    }
  }

  /* write chunks */
  string chs = ch->tostring();
  wri(f, chs.length());
  fwrite(chs.c_str(), chs.length(), 1, f);

  fclose(f);
  return 1;
}
#endif

player * player::fromfile(string file) {
  return playerreal::fromfile(file);
}

playerreal * playerreal::fromfile_text(string fname, checkfile * cf) {

  playerreal * p = playerreal::create("");
  if (!p) return 0;
  p->fname = fname;
  extent<playerreal> ep(p);

  string s;

  /* strip newline after magic */
  if (!(cf->getline(s) && s == "")) return 0;

  if (!cf->getline(s)) return 0; p->webid = stoi(s);
  if (!cf->getline(s)) return 0; p->webseqh = stoi(s);
  if (!cf->getline(s)) return 0; p->webseql = stoi(s);

  /* ignored fields for now */
  for(int z = 0; z < IGNORED_FIELDS; z++) {
    if (!cf->getline(s)) return 0;
  }

  if (!cf->getline(p->name)) return 0;

  /* expect solution marker now */
  if (!cf->getline(s) || s != SOLMARKER) return 0;

  /* now read solutions until -- ratings */

  for( ;; ) {
    string l;
    if (!cf->getline(l)) return 0;
    
    /* maybe this is the end? */
    if (l == RATMARKER) break;
    
    string md = util::chop(l);
    if (!md5::unascii(md, md)) return 0;

    string next = util::chop(l);
    
    if (next == "*") {
      /* default first */
      string solstring = base64::decode(util::chop(l));
      namedsolution * ns = namedsolution::fromstring(solstring);
      if (!ns) return 0;

      nslist * solset = new nslist(ns, 0);
      nslist ** etail = &solset->next;
      
      /* now, any number of other solutions */
      for(;;) {
	if (!cf->getline(l)) return 0;
	string tok = util::chop(l);
	if (tok == "!") break;
	else {
	  namedsolution * ns = namedsolution::fromstring(base64::decode(tok));
	  if (!ns) return 0;
	  /* and append it */
	  *etail = new nslist(ns, 0);
	  etail = &((*etail)->next);
	}
      }
      
      /* add a whole solution set */
      p->sotable->insert(new hashsolsetentry(md, solset));

    } else {
      /* old style singleton solutions */
      string solstring = base64::decode(next);
      solution * sol = solution::fromstring(solstring);
      if (!sol) return 0;
      p->putsol(md, sol);
    }
  }

  /* already read rating marker */

  for( ;; ) {
    string l;
    if (!cf->getline(l)) return 0;

    if (l == PREFMARKER) break;

    string md = util::chop(l);
    if (!md5::unascii(md, md)) return 0;

    string ratstring = base64::decode(util::chop(l));
    rating * rat = rating::fromstring(ratstring);

    if (!rat) return 0;

    /* ignore rest of line */
    p->putrating(md, rat);
  }

  /* already read pref marker */

  string cs; 
  if (!cf->getline(cs)) return 0;
  p->ch = chunks::fromstring(base64::decode(cs));

  if (!p->ch) return 0;


  ep.release();
  return p;
}


playerreal * playerreal::fromfile(string file) {

  checkfile * cf = checkfile::create(file);
  if (!cf) return 0;
  extent<checkfile> ecf(cf);

  string s;
  if (!cf->read(PLAYER_MAGICS_LENGTH, s)) return 0;
  
  /* binary or text format? */
  if (s == PLAYER_MAGIC) return fromfile_bin(file, cf);
  else if (s == PLAYERTEXT_MAGIC) return fromfile_text(file, cf);
  else return 0;
}  

/* XXX obsolete -- eventually deprecate and disable this */
playerreal * playerreal::fromfile_bin(string fname, checkfile * cf) {

  playerreal * p = playerreal::create("");
  if (!p) return 0;
  p->fname = fname;
  extent<playerreal> ep(p);

  string s;
  int i;

  if (!cf->readint(p->webid)) return 0;
  if (!cf->readint(p->webseqh)) return 0;
  if (!cf->readint(p->webseql)) return 0;

  /* ignored fields for now */
  for(int z = 0; z < IGNORED_FIELDS; z++) {
    if (!cf->readint(i)) return 0;
  }
  
  if (!cf->readint(i)) return 0;
  if (!cf->read(i, p->name)) return 0;
  if (!cf->readint(i)) return 0;


  /* i holds number of solutions */
  while(i--) {
    string md5;
    int sollen;
    string solstring;
    if (!cf->read(16, md5)) return 0;
    if (!cf->readint(sollen)) return 0;
    if (!cf->read(sollen, solstring)) return 0;

    solution * sol = solution::fromstring(solstring);

    if (!sol) return 0;

    p->putsol(md5, sol);
  }

  /* here allow old player files with no ratings
     at all. perhaps obsolete this some day. */
  if (!cf->readint(i)) {
    if (p->ch) p->ch->destroy();
    p->ch = chunks::create();
    ep.release();
    return p;
  }

  /* otherwise; new format: i is number of ratings */
  while(i--) {
    string md5;
    string rastring;
    if (!cf->read(16, md5)) return 0;
    if (!cf->read(RATINGBYTES,rastring)) return 0;
    rating * rat = rating::fromstring(rastring);

    if (!rat) return 0;
    p->putrating(md5, rat);
  }

  /* here allow old player files with no chunks
     at all. Caller should be calling prefs::defaults
     to fill in the missing prefs. */

  if (!cf->readint(i)) {
    ep.release();
    if (p->ch) p->ch->destroy();
    p->ch = chunks::create();
    return p;
  }

  /* otherwise, read the table */

  string cs; 
  if (!cf->read(i, cs)) return 0;
  chunks * cc = chunks::fromstring(cs);

  if (cc) {
    if (p->ch) p->ch->destroy();
    p->ch = cc;
  } else return 0;

  ep.release();
  return p;
}
