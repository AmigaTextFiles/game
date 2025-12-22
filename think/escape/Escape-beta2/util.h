
#ifndef __UTIL_H
#define __UTIL_H

#include <stdio.h>
#include <string>
using namespace std;

#define ATTIC_DIR "attic"

#ifdef WIN32
#   define DIRSEP  "\\"
#   define DIRSEPC '\\'
#else
#   define DIRSEP  "/"
#   define DIRSEPC '/'
#endif

#define UTIL_PI 3.141592653589f

string readfile(string);
/* only read if the file begins with the magic string */
bool hasmagic(string, string magic);
string readfilemagic(string, string magic);

bool writefile(string fn, string s);

string itos(int i);
int stoi(string s);

bool isdir(string s);

int shout(int, string, unsigned int &);
string shint(int b, int i);
/* converts int to byte string that represents it */
string sizes(int i);

template <class T>
struct vallist {
  T head;
  vallist<T> * next;
  vallist<T>(T h, vallist<T> * n) : head(h), next(n) {}
  static void push(vallist<T> *& sl, T h) {
    sl = new vallist<T>(h, sl);
  }

  static T pop(vallist<T> *& sl, T u) {
    if (sl) {
      vallist<T> * tmp = sl;
      T t = tmp->head;
      sl = sl->next;
      delete tmp;
      return t;
    } else return u;
  }

  /* ie, destroy */
  static void diminish(vallist<T> *& sl) {
    T dummy;
    while (sl) pop(sl, dummy);
  }

  int length() {
    int res = 0;
    vallist<T> * tmp = this;
    while (tmp) {
      tmp = tmp -> next;
      res ++;
    }
    return res;
  }

  static vallist<T> * copy(vallist<T> * sl) {
    if (sl) {
      return new vallist<T>(sl->head, 
			    copy(sl->next));
    } else return 0;
  }

};

typedef vallist<string> stringlist;
inline string stringpop(stringlist *& sl) {
  return stringlist::pop(sl, "");
}

/* might this be merged with vallist above? pointers
   are values */
template <class P>
struct ptrlist {
  P * head;
  ptrlist<P> * next;
  ptrlist<P>(P * h, ptrlist<P> * n) : head(h), next(n) {}

  static void push(ptrlist<P> *& sl, P * h) {
    sl = new ptrlist<P>(h, sl);
  }

  static P * pop(ptrlist<P> *& sl) {
    if (sl) {
      ptrlist<P> * tmp = sl;
      P * t = tmp->head;
      sl = sl->next;
      delete tmp;
      return t;
    } else return 0;
  }

  /* ie, destroy. does not destroy the
     heads! */
  static void diminish(ptrlist<P> *& pl) {
    while (pl) pop(pl);
  }

  int length() {
    int res = 0;
    ptrlist<P> * tmp = this;
    while (tmp) {
      tmp = tmp -> next;
      res ++;
    }
    return res;
  }

  static ptrlist<P> * copy(ptrlist<P> * sl) {
    if (sl) {
      return new ptrlist<P>(sl->head, 
			    copy(sl->next));
    } else return 0;
  }
  
  /* XXX this seems to be broken -- see chunks */
  /* merge sort the list in place. 
     not tuned for speed, but still worst case O(n lg n) */
  static void sort(int compare(P * a, P * b), ptrlist <P> *& pl) {
    /* if empty or a singleton, we're done. */
    if (!pl || !pl->next) return;

    int num = pl->length() >> 1;
    ptrlist<P> * left = 0;
    ptrlist<P> * right = copy(pl);

    /* empty out pl */
    diminish(pl);

    /* copy floor(n/2) items into left, removing them from right */
    while(num--) push(left, pop(right));

    sort(compare, left);
    sort(compare, right);

    ptrlist<P> * out = 0;

    while(left || right) {
      if (left) {

	if (right) {
	  int ord = compare(left->head, right->head);
	  
	  if (ord < 0) { /* left < right */
	    push(out, pop(left));
	  } else if (ord > 0) { /* left > right */
	    push(out, pop(right));
	  } else {
	    /* equal */
	    push(out, pop(left));
	    push(out, pop(right));
	  }
	} else {
	  push(out, pop(left));
	}

      } else {
	push(out, pop(right));
      }
    }

    rev(out);
    pl = out;

  }

  static void rev(ptrlist<P> *& pl) {
    ptrlist<P> * out = 0;
    while(pl) push(out, pop(pl));
    pl = out;
  }

};

/* drawing lines with Bresenham's algorithm */
struct line {
  static line * create(int x0, int y0, int x1, int y1);
  virtual void destroy() = 0;
  virtual bool next(int & x, int & y) = 0;
  virtual ~line() {};
};

/* union find structure, n.b. union is a keyword */
struct onionfind {
  int * arr;

  int find(int);
  void onion(int,int);

  onionfind(int);
  ~onionfind () { delete [] arr; }

  private:
  
  onionfind(const onionfind &) { abort (); }
};

/* treats strings as buffers of bits */
struct bitbuffer {
  /* read n bits from the string s from bit offset idx.
     (high bits first)
     write that to output and return true.
     if an error occurs (such as going beyond the end of the string),
     then return false, perhaps destroying idx and output */
  static bool nbits(string s, int n, int & idx, unsigned int & output);

  /* create a new empty bit buffer */
  bitbuffer() : data(0), size(0), bits(0) { }

  /* appends bits to the bit buffer */
  void writebits(int width, unsigned int thebits);

  /* get the contents of the buffer as a string, 
     padded at the end if necessary */
  string getstring();

  /* give the number of bytes needed to store n bits */
  static int ceil(int bits);


  ~bitbuffer() { free(data); }

  private:
  unsigned char * data;
  int size;
  int bits;
};

struct util {
  static unsigned int hash(string s);
  /* give /home/tom/ of /home/tom/.bashrc */
  static string pathof(string s);
  static string fileof(string s);

  static string ensureext(string f, string ext);
  static string lcase(string in);
  static string ucase(string in);

  static bool existsfile(string);

  /* An ordering on strings that gives a more "natural" sort:
     Tutorial 1, ..., Tutorial 9, Tutorial 10, Tutorial 11, ...
     rather than
     Tutorial 1, Tutorial 10, Tutorial 11, ..., Tutorial 2, Tutorial 20, ...
  */
  static int natural_compare(const string & l, const string & r);

  /* Same as above, but ignore 'the' at the beginning */
  static int library_compare(const string & l, const string & r);

  /* Is string s alphabetized under char k? */
  static bool library_matches(char k, const string & s);

  /* open a new file. if it exists, return 0 */
  static FILE * open_new(string s);
  static int changedir(string s);
  static int random();
  /* random in 0.0 .. 1.0 */
  static float randfrac();
  static int getpid();
  /* anything ending with \n. ignores \r.
     modifies str. */
  static string getline(string & str);
  /* same, for open file. */
  static string fgetline(FILE * f);

  /* chop the first token (ignoring whitespace) off
     of line, modifying line. */
  static string chop(string & line);

  /* number of entries (not . or ..) in dir d */
  static int dirsize(string d);

  /* mylevels/good_tricky   to
     mylevels               to
     . */
  static string cdup(const string & dir);

  /* true iff big ends with small */
  static bool endswith(string big_, string small_);
  /* starts */
  static bool startswith(string big_, string small_);

  /* split the string up to the first
     occurrence of character c. The character
     is deleted from both the returned string and
     the line */
  static string chopto(char c, string & line);

  /* erase any whitespace up to the first 
     non-whitespace char. */
  static string losewhitel(const string & s);

  /* try to remove the file. If it
     doesn't exist or is successfully
     removed, then return true. */
  static bool remove(string f);
  
  /* move a file from src to dst. Return
     true on success. */
  static bool move(string src, string dst);

  /* make a copy by reading/writing */
  static bool copy(string src, string dst);

  static string tempfile(string suffix);

  /* same as isdir */
  static bool existsdir(string);

  static bool makedir(string);

  /* creates directories for f */
  static void createpathfor(string f);

  /* open, creating directories if necessary */
  static FILE * fopenp(string f, string mode);

  /* move a file into an 'attic' backup dir */
  static void toattic(string f);

  /* replace all occurrences of 'findme' with 'replacewith' in 'src' */
  static string replace(string src, string findme, string replacewith);

  /* called minimum, maximum because some includes
     define these with macros, ugh */
  static int minimum(int a, int b) {
    if (a < b) return a;
    else return b;
  }

  static int maximum(int a, int b) {
    if (a > b) return a;
    else return b;
  }
};


#endif
