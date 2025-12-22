/* OES Preferences, S-Expressions */

#include <string.h>
#include <pwd.h>

#include "config.h"
#include "snipe2d.h"
#include "sexpr/sexp.h"
#include "binds.h"

/* default web browser. */
#define WWWBROWSER "IBROWSE:ibrowse"

extern PREFS gPrefs;
struct passwd *pw_ent = 0;

const char *PATHSEP = "/";
const char *dotdir = ".oes";
const char *confname = "prefs.cfg";
const char *scorename = "scores.bin";
const char *bindname = "binds.cfg";
const char *keysname = "keys.cfg";


#define PAIRP(se) ((se)->ty == SEXP_LIST)
#define ATOMP(se) ((se)->ty == SEXP_VALUE)
#define CAR(se) (ATOMP(se) ? se : hd_sexp(se))
#define CDR(se) (ATOMP(se) ? next_sexp(se) : tl_sexp(se))


sexp_t *
assoc_sexp (sexp_t *alist, const char *key)
{
  char buf[1024];
  sexp_t *pair, *temp1;

  if ((alist->ty == SEXP_LIST) && (alist->next == NULL))
      alist = alist->list;
  while (alist)
    {
//print_sexp(buf, sizeof(buf), alist);
//printf("alist = %s\n", buf);
      if (alist->ty == SEXP_LIST)
        {
          /* pair */
          pair = hd_sexp(alist);
//print_sexp(buf, sizeof(buf), CAR(pair));
//printf("(car pair) = %s\n", buf);
//print_sexp(buf, sizeof(buf), CDR(pair));
//printf("(cdr pair) = %s\n", buf);
          if (0 == strcasecmp(key, CAR(pair)->val))
              return pair;
        }
      /* else ignore */
      alist = next_sexp(alist);
    }
  return NULL;
}


int alist_get_int (sexp_t *se, const char *key)
{
  sexp_t *pair;
  int n;

  pair = assoc_sexp(se, key);
  if (!pair) return 0;
  n = strtol(CAR(CDR(pair))->val, NULL, 0);
  return n;
}

float alist_get_float (sexp_t *se, const char *key)
{
  sexp_t *pair;
  float f;

  pair = assoc_sexp(se, key);
  if (!pair) return 0;
  f = atof(CAR(CDR(pair))->val);
  return f;
}

const char * alist_get_string (sexp_t *se, const char *key)
{
  sexp_t *pair;
  const char *s;

  pair = assoc_sexp(se, key);
  if (!pair) return 0;
  s = pair->next->val;
  return s;
}

void prefs_save_stub()
{
  prefs_save(&gPrefs);
}


/* initialise paths and defaults. */
PREFS *
prefs_init (PREFS *self)
{
  int homedirlen, datadirlen, cfgpathlen, scorelen, keyslen, bindlen;

  if (!self)
      self = (PREFS*)malloc(sizeof(PREFS));
  memset(self, 0, sizeof(*self));
  if (!pw_ent)
      pw_ent = getpwuid(geteuid());
  self->fullscreen = 0;
  self->audio = 1;
  self->verbose = 2;
  self->difficulty = 2;
  self->wwwbrowser = WWWBROWSER;
#ifdef __amigaos4__
  homedirlen = strlen("PROGDIR:.oes") + 1;
  datadirlen = homedirlen + 1;
#else
  homedirlen = strlen(pw_ent->pw_dir) + 1;
  datadirlen = homedirlen + strlen(dotdir) + strlen(PATHSEP) + 1;
#endif
  bindlen = datadirlen + strlen(bindname) + strlen(PATHSEP) + 1;
  cfgpathlen = datadirlen + strlen(confname) + strlen(PATHSEP) + 1;
  scorelen = datadirlen + strlen(scorename) + strlen(PATHSEP) + 1;
  keyslen = datadirlen + strlen(keysname) + strlen(PATHSEP) + 1;
  self->homedir = (char*)malloc(homedirlen);
  self->datadir = (char*)malloc(datadirlen);
  self->bindpath = (char*)malloc(bindlen);
  self->scorepath = (char*)malloc(scorelen);
  self->cfgpath = (char*)malloc(cfgpathlen);
  self->keyspath = (char*)malloc(keyslen);

#ifdef __amigaos4__
  sprintf(self->homedir,  "PROGDIR:.oes");
  snprintf(self->datadir,  datadirlen,"%s", self->homedir);
  snprintf(self->scorepath,scorelen,  "%s%s%s", self->datadir, PATHSEP, scorename);
  snprintf(self->cfgpath,  cfgpathlen,"%s%s%s", self->datadir, PATHSEP, confname);
  snprintf(self->bindpath, bindlen,   "%s%s%s", self->datadir, PATHSEP, bindname);
#else
  snprintf(self->homedir,  homedirlen,"%s", pw_ent->pw_dir);
  snprintf(self->datadir,  datadirlen,"%s%s%s", self->homedir, PATHSEP, dotdir);
  snprintf(self->scorepath,scorelen,  "%s%s%s", self->datadir, PATHSEP, scorename);
  snprintf(self->cfgpath,  cfgpathlen,"%s%s%s", self->datadir, PATHSEP, confname);
  snprintf(self->bindpath, bindlen,   "%s%s%s", self->datadir, PATHSEP, bindname);
#endif

//  snprintf(self->keyspath, keyslen, "%s%s%s", self->datadir, PATHSEP, keysname);
  snprintf(self->keyspath, keyslen, "%s", keysname);
//printf("Test on datadir '%s' => %d\n", self->datadir, access(self->datadir, W_OK|R_OK|X_OK));
  return self;
}


/* Populate PREFS with settings from game. */
int
prefs_update (PREFS *self)
{
  self->verbose = Game.verbosity;
  return 0;
}


/* Load preferences from saved file. */
PREFS *
prefs_load (PREFS *self)
{
  char buf[1024];
  FILE *preffile;
  sexp_t *se, *a;
  sexp_iowrap_t *io;
  char *s;
  const char *sym;
  int i;
  float f;

  if (!self)
      self = prefs_init(self);
//  if (!prefs_init()) return 0;
//printf("Prefs Style 2\n");
  if (!(preffile = fopen(self->cfgpath, "r")))
    {
      /* Maybe first time ever running.  Create prefs. */
      prefs_create(self);
      if (!(preffile = fopen(self->cfgpath, "r")))
        {
          /* still can't open it. */
          printf("Could not load from '%s'\n", self->cfgpath);
          return 0;
        }
    }

  io = init_iowrap(fileno(preffile));
  se = read_one_sexp(io);

  s = CAR(CDR(assoc_sexp(se, "package")))->val;
//printf("Detected pref package: %s\n", s);
  i = alist_get_int(se, "version");
//printf("Detected pref version: %d\n", i);
  i = alist_get_int(se, "fullscreen");
//printf("Fullscreen=%d\n", i);
  self->fullscreen = i;
  i = alist_get_int(se, "audio");
//printf("Audio=%d\n", i);
  self->audio = i;
  i = alist_get_int(se, "verbose");
//printf("Verbosity=%d\n", i);
  self->verbose = i;
  i = alist_get_int(se, "difficulty");
//printf("Difficulty=%d\n", i);
  self->difficulty = i;
  i = alist_get_int(se, "joystick");
//printf("Joystick=%d\n", i);
  self->joystick = i;
  sym = alist_get_string(se, "wwwbrowser");
  if (sym)
    {
      self->wwwbrowser = strdup(sym);
    }

  destroy_iowrap(io);
  fclose(preffile);

  atexit (prefs_save_stub); /* XXX: hrm. */

  return self;
}


/* Save preferences to file. */
PREFS *
prefs_save (PREFS *self)
{
  FILE *preffile;

  if (!self) return 0;
  if (!self->cfgpath) return 0;

  prefs_update(self);

  if (!(preffile = fopen(self->cfgpath, "w")))
    {
      printf("Could not save to '%s'\n", self->cfgpath);
      return 0;
    }

  fprintf(preffile, "; OES Preferences\n");
  fprintf(preffile, "\n");
  fprintf(preffile, "(prefs\n");
  fprintf(preffile, " (package \"%s\")\n", PACKAGE);
  fprintf(preffile, " (version %d)\n", 1);
  fprintf(preffile, " (fullscreen %d)\n", self->fullscreen);
  fprintf(preffile, " (audio %d)\n", self->audio);
  fprintf(preffile, " (verbose %d)\n", self->verbose);
  fprintf(preffile, " (difficulty %d)\n", self->difficulty);
  fprintf(preffile, " (joystick %d)\n", self->joystick);
  fprintf(preffile, " (wwwbrowser \"%s\")\n", self->wwwbrowser);
  fprintf(preffile, ")\n");

  fclose(preffile);

  return self;
}


/* Ensure necessary files exist. */
PREFS *
prefs_create (PREFS *self)
{
  if (!self)
      self = prefs_init(self);
  if (access(self->datadir, W_OK | R_OK | X_OK))
    {
      /* problem accessing directory.  Assume missing. */
      mkdir(self->datadir, 0755);
      if (access(self->datadir, W_OK | R_OK | X_OK))
        {
          /* still problem. */
          fprintf(stderr, "Unable to create pref directory '%s'\n", self->datadir);
          exit(1);
        }
    }
  /* 0 == read-write-search OK */

  /* Check for the conf file itself. */
//printf("Test on cfgpath '%s' => %d\n", self->cfgpath, access(self->cfgpath, W_OK|R_OK));
  if (access(self->cfgpath, W_OK | R_OK))
    {
      /* error.  assume missing. */
      prefs_save(self);
      if (access(self->cfgpath, R_OK))
        {
          /* still error.  bad. */
          fprintf(stderr, "Unable to create prefs file '%s'\n", self->cfgpath);
          exit(1);
        }
    }
  /* 0 == read-write OK */

  return self;
}


PREFS *
prefs_destroy (PREFS *self)
{
  if (!self) return 0;
  prefs_save(self);
  free(self->cfgpath); self->cfgpath = NULL;
  free(self->scorepath); self->scorepath = NULL;
  free(self->datadir); self->datadir = NULL;
  free(self->homedir); self->homedir = NULL;
  return self;
}

void
prefs_delete (PREFS *self)
{
  if (!self) return;
  prefs_destroy (self);
  free(self);
}


#if 0
/* dummy function. */
void prefs()
{
}
#endif /* 0 */
