/* symbol.c: Symbol table and label routines              */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

#include <assert.h>
#include <ctype.h>
#include "agility.h"
#include "comp.h"


static long rangecheck(long val, int dtype,rbool is_label);
static long p_lookup_label(int dtype, rbool is_declare);


/* This needs to agree with the enum in comp.h */
char *keyword_list[]={
  "",  /* EOL */

  /* Now come the top-level keywords */
  "ask_descr", "answer", "command", "creature", "creature_descr", "counter",
  "flag", "flag_nouns", "fonts", "global_nouns", "help", "after",
  "intro", "introduction", "instructions", "message", "noun", 
  "noun_descr", "push_descr", "pull_descr", "play_descr", "pictures",
  "question", "room", "room_descr", "special", "subroutines", "sounds",
  "strings", "turn_descr", "text", "talk_descr", "title", "variable", "verb",
  "verbs","vocabulary","rem", "preposition", "prep",
  "freeze", "max_lives", "maximum_score", "resurrection_room", "starting_room",
  "score_option", "status_option", "starting_time", "delta_time",
  "treasure_room", "no_debug", "long_string", "room_pix", "standard",
  "synonyms", "objflag", "prop",
  "status_line", "hours", "minutes", "am_time", "pm_time", "military_time",
  "random_time", 
  "intro_first", "title_box", "no_title_box", "version", "config", "label",

  /* ROOM keywords */
  "north", "south", "east", "west", "northeast", "northwest",
  "southeast", "southwest", "up", "down", "enter", "exit",
  "n", "s", "e", "w", "ne", "nw", "se", "sw", "u", "d", "in", "out",
  "game_end", "game_win", "not_game_end", "not_game_win",
  "key", "light", "locked_door", "points","score",
  "player_dead", "killplayer", "no_player_dead", "no_killplayer",
  "picture", "room_synonyms", "room_synonym",
  "flags", "pix", "initial", "autoexec", "not",

  /* NOUN keywords */
  "location", "size", "weight", "unmovable", "readable", "closable", "open",
  "lockable", "locked", "edible", "drinkable", "poisonous", "on", "off",
  "closed", "movable", "unlocked", "unlockable", "unclosable", "uncloseable",
  "pushable", "pullable", "playable", "turnable", "is_light", "can_shoot", 
  "num_shots", "wearable", "position", "singular", "noun_synonyms", 
  "noun_synonym", "plural", "related_name", "closeable", "openable",
  "unopenable", "inedible", "undrinkable", "nonpoisonous", 
  "not_pushable", "not_playable", "not_pullable", "not_turnable",
  "not_is_light", "not_can_shoot", "moveable", "unreadable", "unwearable", 
  "unmoveable",  "class", "global", "not_global",

  /* CREATURE keywords */
  "weapon", "hostile", "friendly", "threshold", "threshhold", "time_thresh", 
  "time_thres", "timethresh", "groupmember", "not_groupmember", "gender", 
  "creature_synonyms", "creature_synonym", "thing", "man", "woman", 
  "male", "female", "proper", "not_proper",

  /* Preprocessor directives, with leading '#' removed */
  "comment", "define", "include", "options",

  "UNRECOGNIZED KEYWORD" /* This shouldn't be hashed */
};
 
#define KEYBIT 8
#define KEYHASHSIZE (1<<KEYBIT)
#define KEYMASK (KEYHASHSIZE-1)


key_type keytable[KEYHASHSIZE];


/* This relies on '_' being the smallest character to appear in
   a keyword after downcasing */
/* This returns the hash value of the first string on the line */
long keyfunc(char *s)
{
  long val;
  
  val=0;
  for( ; isalpha(*s) || *s=='_' ; s++) {
    val=(val<<1)+(tolower(*s)-'_'); 
    val=(val^(val>>KEYBIT))&KEYMASK;
  }
  if (val<0) val=0;  /* Could happen if not all characters are alphabetic */
  return val;
}


void build_keyhash(void)
{
  long i, n;

  for(i=0;i<KEYHASHSIZE;i++) keytable[i]=IllKey;
  for(i=kEOL;i<IllKey;i++) {
    n=keyfunc(keyword_list[i]);
    if (keytable[n]==IllKey) keytable[n]=i;
    else { /* A collision */
      if (REPORT_COLLISION) 
	rprintf("Collision(%d): %s <--> %s\n",n,keyword_list[i],
	       keyword_list[keytable[n]]);      
      while(keytable[n]!=IllKey) n=(n+1)&KEYMASK;
      keytable[n]=i;
    }
  }
}


/* This is used to match keywords to the beginnings of lines */
rbool keymatch(const char *key)
{
  long i;

  for(i=0;key[i]!=0;i++)
    if (tolower(lineptr[i])!=tolower(key[i])) return 0;
  /* Matched up to the end of key; check that src is followed by 
     whitespace, a digit, or punctuation */
  if (isalpha(lineptr[i]) || lineptr[i]=='_') return 0; /* Fail */
  lineptr+=i; /* Put lineptr pointing after it */
  return 1; /* Match */
}

  /* This function looks up the next string in the line in the key table */
key_type p_key(void)
{
  long n;

  p_space();
  n=keyfunc(lineptr);

  while(keytable[n]!=IllKey && !keymatch(keyword_list[keytable[n]]))
    n=(n+1)&KEYMASK;
  if (PDEBUG) rprintf("<%s>",keyword_list[keytable[n]]);
  return keytable[n];  /* This may be IllKey */
}






/* ------------------------------------------------------------------- */

#define SYMHASHBITS 12

#define SYMHASHSIZE (1<<SYMHASHBITS)
#define SYMHASHMASK (SYMHASHSIZE-1)

static long hashfunc(const char *s)
{
  unsigned long n, i;
  rbool lastspace, currspace;

  n=0;
  lastspace=1;
  for(;*s!=0;s++) {
    currspace=isspace(*s);
    if (!currspace || !lastspace || !label_whitespace) {
      n+=(n<<2)+(uchar)tolower(*s);
      i=n & ~SYMHASHMASK;
      if (i)
	n=(n^(i>>SYMHASHBITS))&SYMHASHMASK; 
    }
    lastspace=currspace;
  }
  return (n & SYMHASHMASK);
}


rbool labelcmp(const char *sym_name, const char *s)
{
  rbool lastspace, currspace;
  lastspace=1;
  for(;*s!=0;s++) {
    currspace=isspace(*s);
    if(!currspace||!lastspace||!label_whitespace) {
      if (label_case) {
	if ((uchar)*sym_name!=(uchar)tolower(*s)) return 0;
      } else 
	if ((uchar)*sym_name!=(uchar)(*s)) return 0;
      sym_name++;
    }
    lastspace=currspace;
  }
  return (*sym_name==0);
}


/* This duplicates a label, doing neccessary processing */
/* We want to lowercase everything and kill extra whitespace */
char *labeldup(const char *s)
{
  char *t, *c;
  rbool lastspace, currspace;

  t=rmalloc(strlen(s)+1);
  c=t;
  lastspace=1;
  for(;*s!=0;s++) {
    currspace=isspace(*s);
    if(!currspace||!lastspace||!label_whitespace) {
      if (label_case)
	*c++=tolower(*s);
      else 
	*c++=*s;
    }
    lastspace=currspace;
  }
  *c=0;
  return t;
}



/* ------------------------------------------------------------------- */
/* Symbol Table routines                                               */
/* ------------------------------------------------------------------- */

typedef union {
  char *s; /* #define String */
  long n;   /* Symbol Value */
} symvalue;

typedef struct symbol_struct {
  char *name; 
  struct symbol_struct *next;  /* Next symbol on this hash chain */
  symvalue value; /* What is it's value? */
  int dtype; /* What is it's data type? */
  long usecnt; /* How many times has it been referenced? */
} symbol_def;


static long symsize;  /* Size of symbol table. */
static symbol_def* hashsym[SYMHASHSIZE];
        /* The symbol hash table: array of pointers */

/* This keeps track of whether individual data types are being
   allocated by us or by the author */
static char categ_type[AGT_GENFLAG-AGT_NUM+3];


void init_symbol(void)
{
  long i;

  symsize=0;
  for(i=0;i<SYMHASHSIZE;i++) hashsym[i]=NULL;
  for(i=0;i<AGT_GENFLAG-AGT_NUM+3;i++)
    categ_type[i]=2; /* Mark as indeterminate */
}

symbol_def *symsearch(char *name)
{
  symbol_def *p;

  /* rprintf("Searching %s...",name);*/
  for( p=hashsym[hashfunc(name)];
       p!=NULL && !labelcmp(p->name,name);
       p=p->next);
  /* if (p==NULL) rprintf("FAIL");*/
  return p;
}

void add_symbol(symbol_def *newsym)
{
  long n;
  symbol_def *conflict;
  conflict=symsearch(newsym->name);
  if (conflict!=NULL) {
    reporterror(2,E_ERR,"Label [%s] defined twice.",newsym->name);
    rfree(newsym);
    return;
  }
  n=hashfunc(newsym->name);  
  newsym->next=hashsym[n];
  hashsym[n]=newsym;
}


/* This is for debugging; it prints out the symbol table */
void dump_symbol(void)
{
  long n;
  symbol_def *sym;

  rprintf("Symbol table:\n");
  for(n=0;n<SYMHASHSIZE;n++) 
    if (hashsym[n]!=NULL) {
      rprintf("%5ld: ",n);
      for(sym=hashsym[n];sym!=NULL;sym=sym->next) {
	rprintf("%s",sym->name);
	if (sym->dtype!=AGT_DEFINE) 
	  rprintf("(%ld), ",sym->value.n);
	else rprintf("{%s}, ",sym->value.s);
      }
      rprintf("\n");
    }
}

/* This corrects labels for rooms, nouns, and creatures
   after first_room, first_noun, and first_creature have been set up */
/* This should only be called if these objects are using labels. */
void update_symtable(void)
{
  long n;
  symbol_def *sym;

  for(n=0;n<SYMHASHSIZE;n++) 
    for(sym=hashsym[n];sym!=NULL;sym=sym->next) 
      if (sym->usecnt==0)  
	/* If not 0, this was created by LABEL, so shouldn't be changed */
	switch(sym->dtype) 
	  {
	  case AGT_ROOM:sym->value.n+=first_room;break;
	  case AGT_ITEM:sym->value.n+=first_noun;break;
	  case AGT_CREAT:sym->value.n+=first_creat;break;	  
	  default: break;
	  }
}


/* This prints out errors about labels that were declared and not used */
void verify_label_use(void)
{
  long n;
  symbol_def *sym;

  for(n=0;n<SYMHASHSIZE;n++) 
    for(sym=hashsym[n];sym!=NULL;sym=sym->next) {
      if (sym->dtype==AGT_QUEST) sym->usecnt--; 
      if (sym->usecnt<=1) 
	reporterror(2,E_NOTE,"Label [%s] declared but not used.",
		    sym->name);
    }
}

/* Returns a pointer to the name of a given datatype */
static const char *typenametable[]=
{"number","flag","question","message","user string","counter","direction",
 "subroutine","picture","room pix","font","song","roomflag",
 "time","standard message","objflag","objprop","attribute","property",
 "exit","room flag/pix","property/objprop","lval"};

const char *typename(int dtype)
{
  if (dtype&AGT_VAR) return "variable";
  if (dtype<AGT_VAR) return "object";
  if (dtype>=AGT_NUM && dtype<=AGT_GENFLAG) 
    return typenametable[dtype-AGT_NUM];
  return "<unknown>";
}

/* Need to define this here because the objprop/objflag routines
   call it. */
static symbol_def *scan_label(char **ptr, rbool report_error);


/* ------------------------------------------------------------------- */
/*  Final routines to create new properties and objflags               */
/* ------------------------------------------------------------------- */

static int userattr_base[3][2];  
static int userattr_bit[3];
static int base0[4][2];
/* 0=room,  1=noun, 2=creat ;; 0=flag, 1=prop */


void init_userattr(void)
{
  int i,j;

  for(i=0;i<3;i++) {
    for (j=0;j<2;j++)
      userattr_base[i][j]=0;  
    userattr_bit[i]=0;
  }
}

static void attrboost(long *base, long boost)
{
  if (*base!=-1) *base+=boost;
}

void recalc_userattr(void)
{
  int i;

  for(i=0;i<3;i++)   /* Round up flags to the next whole byte */
    if (userattr_bit[i]>0)
      userattr_base[i][0]++;

  num_rprops=userattr_base[0][1];
  num_nprops=userattr_base[1][1];
  num_cprops=userattr_base[2][1];
  num_rflags=userattr_base[0][0];
  num_nflags=userattr_base[1][0];
  num_cflags=userattr_base[2][0];

  for(i=0;i<2;i++) { /* Calculate bases for each type of object */
    base0[0][i]=0;
    base0[1][i]=userattr_base[0][i]*(maxroom-first_room+1);
    base0[2][i]=base0[1][i]+userattr_base[1][i]*(maxnoun-first_noun+1);
    base0[3][i]=base0[2][i]+userattr_base[2][i]*(maxcreat-first_creat+1);
  }

  for(i=0;i<oflag_cnt;i++) {
    attrboost(&attrtable[i].r,base0[0][0]);
    attrboost(&attrtable[i].n,base0[1][0]);
    attrboost(&attrtable[i].c,base0[2][0]);
  }
  for(i=0;i<oprop_cnt;i++) {
    attrboost(&proptable[i].r,base0[0][1]);
    attrboost(&proptable[i].n,base0[1][1]);
    attrboost(&proptable[i].c,base0[2][1]);
  }
}

static void getbase(int ot, long *base, char *bit)
  /* ot=0 for room, 1 for noun, 2 for creature */
{
  int i;

  if (bit==NULL) i=1; else i=0;
  *base=userattr_base[ot][i];
  if (bit==NULL) 
    userattr_base[ot][1]++;
  else {
    *bit=userattr_bit[ot]++;
    if (userattr_bit[ot]==8) {
      userattr_bit[ot]=0;
      userattr_base[ot][0]++;
    }
  }
}


void alloc_userattr(int n,int mask, int t)
     /* t=AGT_OBJPROP or AGT_OBJFLAG */
     /* mask = 1 for rooms, 2 for nouns, 4 for creatures or a mix */
     /* n = entry in appropriate flag/prop lookup table */
{
  if (t==AGT_OBJFLAG) {
    if (mask&1)
      getbase(0,&attrtable[n].r,&attrtable[n].rbit);
    if (mask&2)
      getbase(1,&attrtable[n].n,&attrtable[n].nbit);
    if (mask&4)
      getbase(2,&attrtable[n].c,&attrtable[n].cbit);
  }
  if (t==AGT_OBJPROP) {
    if (mask&1)
      getbase(0,&proptable[n].r,NULL);
    if (mask&2)
      getbase(1,&proptable[n].n,NULL);
    if (mask&4)
      getbase(2,&proptable[n].c,NULL);
  }
}


static const char *objattr_errstr[2][3]=
{{"OBJFLAG [%s] not allowed in ROOM declaration.",
  "OBJFLAG [%s] not allowed in NOUN declaration.",
  "OBJFLAG [%s] not allowed in CREATURE declaration."},
 {"PROP [%s] not allowed in ROOM declaration.",
  "PROP [%s] not allowed in NOUN declaration.",
  "PROP [%s] not allowed in CREATURE declaration."}};


/* This parses objflag and objprop references in nouns, rooms, and
   creatures */
/* Returning false will cause the calling routines to try parsing
   this in other ways */
rbool p_objattr(int t, uchar *oflag, long *oprop, rbool notflag)
{
  symbol_def *sym;
  char ofs;
  int n, base;

  p_space();
  if (lineptr[0]!=start_label) {
    if (notflag) 
      reporterror(2,E_WARN,"Expected OBJFLAG label.",NULL);
    return notflag; /* Not a label */
  }
  if (pass==1) return 1;  /* Skip it until next pass */
  sym=scan_label(&lineptr,1);
  if (sym==NULL) return 1;
  n=sym->value.n;
  if (sym->dtype==AGT_OBJFLAG) {
    base=lookup_objflag(n,t,&ofs);
    if (base==-1)
      reporterror(2,E_ERR,objattr_errstr[0][t],sym->name);
    else {
      base-=base0[t][0];
      op_simpflag(&oflag[base],ofs,!notflag);
    }
  } else if (sym->dtype==AGT_OBJPROP && !notflag) {
    base=lookup_objprop(n,t);
    if (base==-1)
      reporterror(2,E_ERR,objattr_errstr[1][t],sym->name);
    else {
      base-=base0[t][1];
      oprop[base]=p_label(AGT_NUM);
    }
  } else if (notflag) reporterror(2,E_WARN,"Expected OBJFLAG label.",NULL);
  else reporterror(2,E_WARN,"Expected OBJFLAG or PROP label.",NULL);
  return 1;
}


/* ------------------------------------------------------------------- */
/*  Routines to create new objects, messages, verbs, etc.              */
/* ------------------------------------------------------------------- */

/* This sets a given category to be either number or label */
/* (i.e. managed by the game author or by the compiler) */
/*  It generates a fatal error if the two are mixed.  */
/* If it returns false-- which can only happend
   for a few data types-- discard the new object */

static rbool set_category_type(int dtype, rbool is_label)
{
  int tindex;

  assert(dtype!=AGT_NUM && dtype!=AGT_TIME && dtype!=AGT_GENFLAG
	 && dtype!=AGT_EXIT);
  if (dtype<AGT_VAR) tindex=0;
  else if (dtype&AGT_VAR) tindex=1;
  else tindex=dtype-AGT_NUM+2;
  assert(tindex>=0 && tindex<AGT_GENFLAG-AGT_NUM+3);
  if (categ_type[tindex]==2) { /* Indeterminate */
    categ_type[tindex]=is_label;
    if (is_label)  /* EXIT == ROOM && MSG */
      if ( (dtype==AGT_ROOM && categ_type[AGT_MSG-AGT_NUM+2])
	   || (dtype==AGT_MSG && categ_type[0]))
	categ_type[AGT_EXIT-AGT_NUM+2]=1; 
    return 1;
  }
  if (categ_type[tindex]!=is_label) { 
    if (dtype==AGT_FLAG || dtype==AGT_CNT || dtype==AGT_VAR)
      return 0;  /* These three are declared w/ p_declare_seq */
    reporterror(1,E_FATAL,"Mixing numbers and labels for %ss.",
		typename(dtype));
  }
  return 1;
}


/* This is the compiler's internal version of addsyn, used to manipulate */
/*   csyntbl synonyms: namely, those that would go in auxsyn          */
/*   (canonical forms of dummy verbs and subroutine names)    */
/* Adds w to dynamically grown synonym list */
void caddsyn(word w)
{
  if (w==0) return;
  if (w==-1) w=0;
  csynptr++;
  csyntbl=rrealloc(csyntbl,((long)csynptr)*sizeof(word)); 
  csyntbl[csynptr-1]=w;
}


void creat_dverb(int newdverb)
{
  int olddverb, i;
  char buff[20];

  olddverb=DVERB;
  DVERB=newdverb;
  synlist=rrealloc(synlist,(BASE_VERB+DVERB+MAX_SUB)*sizeof(slist));
  auxsyn=rrealloc(auxsyn,(BASE_VERB+DVERB+MAX_SUB)*sizeof(slist));
  
  for(i=MAX_SUB-1;i>=0;i--) {  /* Move subroutines up to make room */
    auxsyn[i+BASE_VERB+DVERB]=auxsyn[i+BASE_VERB+olddverb];
    synlist[i+BASE_VERB+DVERB]=synlist[i+BASE_VERB+olddverb];    
  }

  for(i=olddverb;i<DVERB;i++) 
    {  /* Initialize new dummy verbs */
      synlist[BASE_VERB+i]=0;
      sprintf(buff,"dummy_verb%d",i+1);
      auxsyn[BASE_VERB+i]=csynptr;
      caddsyn(add_dict(buff)); 
      caddsyn(-1);
    }
}


static void create_sub(int newsub)
{
  int oldsub,i;
  char buff[20];

  oldsub=MAX_SUB;
  MAX_SUB=newsub;
  synlist=rrealloc(synlist,(BASE_VERB+DVERB+MAX_SUB)*sizeof(slist));
  auxsyn=rrealloc(auxsyn,(BASE_VERB+DVERB+MAX_SUB)*sizeof(slist));
  sub_name=rrealloc(sub_name,MAX_SUB*sizeof(word));

  for(i=oldsub;i<newsub;i++) {
    synlist[BASE_VERB+DVERB+i]=0;
    sprintf(buff,"subroutine%d",i+1);
    auxsyn[i+BASE_VERB+DVERB]=csynptr;
    caddsyn( sub_name[i]=add_dict(buff) ); 
    caddsyn(-1);
  }
}

static void create_var(int newvar)
{
  int oldvar, i;

  oldvar=VAR_NUM;
  VAR_NUM=newvar;  
  vartable=rrealloc(vartable,sizeof(vardef_rec)*(VAR_NUM+1));
  for(i=oldvar+1;i<=VAR_NUM;i++)
    vartable[i].str_cnt=0;
}

void create_flag(int newflag)
{
  int oldflag, i;

  oldflag=FLAG_NUM;
  FLAG_NUM=newflag;  
  flagtable=rrealloc(flagtable,sizeof(flagdef_rec)*(FLAG_NUM+1));
  for(i=oldflag+1;i<=FLAG_NUM;i++)
    flagtable[i].ystr=flagtable[i].nstr=NULL;
}

/* This is used to create short messages during pass 2 */
/* By this point, all of the 'real' messages will have already been
   created, so we can freely add on to the end */
integer create_message(descr_ptr *dptr)
{
  if (pass==1) return 0;
  last_message++;
  msg_ptr=rrealloc(msg_ptr,last_message*sizeof(descr_ptr));
  msg_ptr[last_message-1].start=dptr->start;
  msg_ptr[last_message-1].size=dptr->size;
  return last_message;
}



void update_firstnoun(int newfirst,int oldfirst)
{
  if (oldfirst>maxnoun)  /* We just created the first one */
    return;
  memmove(noun+oldfirst-newfirst,noun,
	  sizeof(noun_rec)*(maxnoun-oldfirst+1));
}


void init_newitem(int oldfirst,int oldlast)
{
  int i;

  if (oldfirst>maxnoun) oldfirst=first_noun+1;
  if (oldlast<first_noun) oldlast=maxnoun-1;

  for(i=first_noun;i<oldfirst;i++)
    memcpy(&noun[i-first_noun],&default0_noun,sizeof(noun_rec));
  for(i=oldlast+1;i<=maxnoun;i++) 
    memcpy(&noun[i-first_noun],&default0_noun,sizeof(noun_rec));
}



void update_firstcreat(int newfirst,int oldfirst)
{
  if (oldfirst>maxcreat)  /* We just created the first one */
    return;
  memmove(creature+oldfirst-newfirst,creature,
	  sizeof(creat_rec)*(maxcreat-oldfirst+1));
}

void init_newcreat(int oldfirst,int oldlast)
{
  int i;

  if (oldfirst>maxcreat) oldfirst=first_creat+1;
  if (oldlast<first_creat) oldlast=maxcreat-1;

  for(i=first_creat;i<oldfirst;i++) 
    memcpy(&creature[i-first_creat],&default0_creat,sizeof(creat_rec));
  for(i=oldlast+1;i<=maxcreat;i++) 
    memcpy(&creature[i-first_creat],&default0_creat,sizeof(creat_rec));
}



/* Changes the game limits to include objnum of type <dtype> and
   checks for error conditions */
/* Should type-check this some more */
static integer make_obj(long objnum, int dtype)
{
  integer old_first, old_last;

  /* This checks that we aren't mixing numbers and labels. */
  /* Only the command parser calls us during pass 2,
     to create new variables, flags, and counters...
     and we shouldn't interfere with it. */
  if (pass==1)  
    set_category_type(dtype,0);


  if (objnum<1) 
    if (objnum<0 || (dtype!=AGT_FLAG && dtype!=AGT_VAR && dtype!=AGT_CNT)) 
      {
	reporterror(1,E_ERR,"Negative %s number found.",typename(dtype));
	return 0;
      }
  if (objnum>0x7FFF) {
    reporterror(1,E_ERR,"Number for %s is too large.",typename(dtype));
    return 0;
  }
  if (dtype&AGT_VAR) dtype=AGT_VAR;

  switch(dtype) 
    {
    case AGT_ROOM:
      old_first=first_room; old_last=maxroom;
      if (objnum<first_room) first_room=objnum;
      if (objnum>maxroom) maxroom=objnum;
#if 0
      room=rrealloc(room,(maxroom-first_room+1)*sizeof(room_rec));
      if (first_room!=old_first) 
	update_firstroom(first_room,old_first);
      init_newroom(old_first,old_last);
#endif
      break;
    case AGT_ITEM:
      old_first=first_noun; old_last=maxnoun;
      if (objnum<first_noun) first_noun=objnum;
      if (objnum>maxnoun) maxnoun=objnum;
      noun=rrealloc(noun,(maxnoun-first_noun+1)*sizeof(noun_rec));
      if (first_noun!=old_first) 
	update_firstnoun(first_noun,old_first);
      init_newitem(old_first,old_last);
      break;
    case AGT_CREAT:
      old_first=first_creat; old_last=maxcreat;
      if (objnum<first_creat) first_creat=objnum;
      if (objnum>maxcreat) maxcreat=objnum;
      creature=rrealloc(creature,(maxcreat-first_creat+1)*sizeof(creat_rec));
      if (first_creat!=old_first) 
	update_firstcreat(first_creat,old_first);
      init_newcreat(old_first,old_last);
      break;
    case AGT_QUEST:
      if (objnum>MaxQuestion) MaxQuestion=objnum;
      break;
    case AGT_MSG:
      if (objnum>last_message) last_message=objnum;
      break;
    case AGT_ERR:
      if (objnum>NUM_ERR) NUM_ERR=objnum;
      break;
    case AGT_PIC:
      if (objnum>maxpict) maxpict=objnum;
      break;
    case AGT_FONT:
      if (objnum>maxfont) maxfont=objnum;
      break;     
    case AGT_SONG:
      if (objnum>maxsong) maxsong=objnum;
      break;     
    case AGT_ROOMFLAG:
    case AGT_PIX:
      break;
    case AGT_SUB: 
      if (objnum>MAX_SUB) create_sub(objnum);
      break;
    case AGT_VAR:
      if (objnum>VAR_NUM) create_var(objnum);
      break;
    case AGT_FLAG:
      if (objnum>FLAG_NUM) create_flag(objnum);
      break;
    case AGT_CNT:
      if (objnum>CNT_NUM) CNT_NUM=objnum;
      break;
    case AGT_STR:
      if (objnum>MAX_USTR) MAX_USTR=objnum;
      break;
    default: rprintf("INT ERR: make_obj(), unexpected dtype.\n");
    }
  return objnum;
}

/* This does label allocation of room, nouns, and creatures */
integer alloc_objectnum(integer *firstobj, integer *maxobj)
{
  if (*firstobj>*maxobj) {   /* Create the first object */
    *firstobj=*maxobj=0;
  } else
    (*maxobj)++;
  if (*firstobj!=0)
    reporterror(1,E_FATAL,
		"Labels and numbers both used for objects.",NULL);
  return *maxobj;
}


/* This allocates the next object of a given type */
integer get_next_obj(int dtype) 
{
  integer v;

  set_category_type(dtype,1);
  switch(dtype) 
    {
    case AGT_ROOM:
      v=alloc_objectnum(&first_room,&maxroom);
#if 0
      room=rrealloc(room,(maxroom+1)*sizeof(room_rec));
      init_newroom(0,maxroom-1);
#endif
      return v;
    case AGT_ITEM:
      v=alloc_objectnum(&first_noun,&maxnoun);
      noun=rrealloc(noun,(maxnoun+1)*sizeof(noun_rec));
      init_newitem(0,maxnoun-1);
      return v;      
    case AGT_CREAT:
      v=alloc_objectnum(&first_creat,&maxcreat);
      creature=rrealloc(creature,(maxcreat+1)*sizeof(creat_rec));
      init_newcreat(0,maxcreat-1);
      return v; 
    case AGT_OBJFLAG:
      v=oflag_cnt++;
      attrtable=rrealloc(attrtable,oflag_cnt*sizeof(attrdef_rec));
      attrtable[v].r=attrtable[v].n=attrtable[v].c=-1;
      attrtable[v].ystr=attrtable[v].nstr=NULL;
      return v;
    case AGT_OBJPROP:
      v=oprop_cnt++;
      proptable=rrealloc(proptable,oprop_cnt*sizeof(propdef_rec));
      proptable[v].r=proptable[v].n=proptable[v].c=-1;
      proptable[v].str_cnt=0; proptable[v].str_list=-1;
      return v;
    case AGT_QUEST:
      return ++MaxQuestion;
    case AGT_MSG:
      return ++last_message;
    case AGT_ERR:
      return ++NUM_ERR;
    case AGT_PIC:
      return ++maxpict;
    case AGT_PIX:
      if (maxpix>=MAX_PIX) {
	reporterror(1,E_ERR,"Too many RoomPIXs defined.",NULL);
	return 0;
      }
      return ++maxpix;
    case AGT_ROOMFLAG:
      if (flag_noun_cnt>=MAX_FLAG_NOUN) {
	reporterror(1,E_ERR,"Too many flag nouns defined.",NULL);
	return 0;
      }
      return ++flag_noun_cnt;
    case AGT_FONT:
      return ++maxfont;
    case AGT_SONG:
      return ++maxsong;
    case AGT_SUB: 
	create_sub(MAX_SUB+1); /* This will increment MAX_SUB */
	return MAX_SUB; 
    case AGT_VAR:
      create_var(VAR_NUM+1);
      return VAR_NUM;
    case AGT_FLAG:
      create_flag(FLAG_NUM+1);
      return FLAG_NUM;
    case AGT_CNT:
      return ++CNT_NUM;
    case AGT_STR:
      return ++MAX_USTR;
    default: rprintf("INT ERR: get_next_object(), unexpected dtype.\n");
    }
  return 0;
}



/* ------------------------------------------------------------------- */
/* Routines to do the grunt work of parsing labels  */
/* ------------------------------------------------------------------- */


static symbol_def *scan_label(char **ptr, rbool report_error)
{
  char *s, c;
  symbol_def *sym;

  for(s=(*ptr)+1;*s!=0 && *s!=end_label;s++);
  if (*s==0) {
    if (report_error)
      reporterror(2,E_ERR,"Label [%s] without end brace.",*ptr+1);
    return NULL;
  }
  c=*s;*s=0;
  sym=symsearch(*ptr+1); /* Skip '[' */
  if (sym==NULL) {
    if (report_error) {
      char *tmp;
      tmp=rstrdup(*ptr+1);
      *s=c;
      reporterror(2,E_ERR,"Undefined label [%s].",tmp);
      rfree(tmp);
    }
    *s=c;
    return NULL;
  }
  *s=c;
  if (pass==2) sym->usecnt++;
  *ptr=s;
  if (c!=0) (*ptr)++;
  return sym;
}




/* ------------------------------------------------------------------- */
/*  Routines to declare and look up labels and to do type checking     */
/* ------------------------------------------------------------------- */

/* This parses and creates a label and returns a pointer to its 
   symbol entry. lineptr should point to the starting brace */
symbol_def *p_new_symbol(void)
{
  symbol_def *sym;
  char *s, c;

  for(s=lineptr+1;*s!=0 && *s!=end_label;s++);
  if (*s==0) 
    reporterror(1,E_ERR,"Label '%s' without end brace.",lineptr+1);
  c=*s;*s=0;
  lineptr++;
  sym=rmalloc(sizeof(symbol_def));
  sym->name=labeldup(lineptr);
  sym->usecnt=0;
  add_symbol(sym);
  *s=c;
  lineptr=s;
  if (c!=0) lineptr++; /* skip end label */
  return sym;
}

/* Used to create the compiler's internally-generated symbols,
   such as [magx:first room] */
static void magx_symbol(char *name,int val,int dtype)
{
  symbol_def *sym;

  sym=rmalloc(sizeof(symbol_def));
  sym->name=rstrdup(name);
  sym->usecnt=2; /* Don't complain about them being unused */
  sym->value.n=val;
  sym->dtype=dtype;
  add_symbol(sym);  
}


/* This creates [Magx:...] compiler-defined labels; it should
 run between the first and second pass, after object ranges
 have been assigned. */
/* Note: All of these should be in lowercase with no extra
   whitespace, since magx_symbol() does no processing. */
void make_special_labels(void)
{
  if (verflag!=v_agx) return;
  magx_symbol("magx:first room",first_room,AGT_ROOM);
  magx_symbol("magx:last room",maxroom,AGT_ROOM);
  magx_symbol("magx:first noun",first_noun,AGT_ITEM);
  magx_symbol("magx:last noun",maxnoun,AGT_ITEM);
  magx_symbol("magx:first creature",first_creat,AGT_CREAT);
  magx_symbol("magx:last creature",maxcreat,AGT_CREAT);
  magx_symbol("magx:exit message base",exitmsg_base,AGT_NUM);
}


void p_skipjunk(char digitok,int epass)
     /* Digitok==0 label start only
	       ==1 digits accepted as well as a label start
	       ==2 quote also accepted 
	       ==3 digits and letters okay */
{
  rbool founderr; /* This is to prevent printing of multiple error messages */

  founderr=0;
  while(*lineptr!=0 && *lineptr!=start_label  
	&& (digitok<1 || !isdigit(*lineptr)) 
	&& (digitok<2 || *lineptr!=start_quote)
	&& (digitok<3 || !isalpha(*lineptr)))
    {
      if (!founderr && !ignore_extra_text
	  && ( isalnum(*lineptr) || *lineptr==start_quote ) ) {
	reporterror(epass,E_WARN,"Ignoring extra text on line: \"%s\".",
		    lineptr);
	founderr=1;
      }
      lineptr++;
    }
}






/* This creates a label with name <label> and type <dtype>, */
/*  allocating the next free object of that type */
/* (For the most part, final object allocation isn't done until the
   end of the first pass, although there are a few exceptions) */


/* This handles a single token */
static long p_basic_declare(int dtype)
{
  long val;
  symbol_def *sym;

#if 0
  /* These types are *only* declared as labels, so we skip digits */
  if (dtype==AGT_VAR || dtype==AGT_CNT || dtype==AGT_FLAG
      || dtype==AGT_OBJFLAG || dtype==AGT_OBJPROP)
    p_skipjunk(0,1);
  else
#endif
    p_skipjunk(1,1);
  if (lineptr[0]==start_label) { /* It's a label */
    sym=p_new_symbol();
    val=get_next_obj(dtype);
    if (val<0)  /* Failure */
      val=0;
    sym->value.n=val;
    sym->dtype=dtype;
    return val;
  } else if (isdigit(lineptr[0])) { /* It's a number */
    val=make_obj(strtol(lineptr,NULL,10),dtype);
    while(isalnum(*lineptr)) 
      lineptr++;
    return val;
  } 
  /* We've hit the end of the line. */
  assert(*lineptr==0);
  reporterror(1,E_ERR,"Expected label or number, found nothing.",NULL);
  return 0;
}

long p_declare(int dtype)
{
  if (pass==2) 
    return p_lookup_label(dtype,0);
  if (PDEBUG) rprintf(" declare");

  return p_basic_declare(dtype);
}


/* This parses a number */
long p_number(void)
{
  char *s,c;
  long val;
  
  s=lineptr;  /* Save old value of lineptr */
  while(isdigit(*lineptr)) lineptr++;
  c=*lineptr;*lineptr=0;
  val=strtol(s,NULL,10);
  *lineptr=c;
  return val;
}


static const char *declare_types[]={
  "object","room","noun","creature","variable",
  "number","flag","question","message","string",
  "counter","direction","subroutine","picture",
  "pix","font","song","roomflag","time",
  "stdmsg","objflag","objprop","attribute","property",
  "exit",NULL};

/* This handles LABEL statements, which are #DEFINE's with type 
   checking :-).  */
/* declare <label> <type> <value> */
void p_declaration(void)
{
  int i;
  long val;
  symbol_def *sym;
  int dtype;

  if (pass==2) return;
  p_skipjunk(0,1); /* Find beginning of label */
  if (*lineptr!=start_label) {
    reporterror(1,E_ERR,"Expected label, found nothing.",NULL);
    return;
  }
  sym=p_new_symbol();
  p_space();
  for(i=0;declare_types[i]!=NULL;i++)
    if (keymatch(declare_types[i])) break;
  if (declare_types[i]==NULL) {
    reporterror(1,E_ERR,"Unrecognized type in '%s....'",lineptr);
    return;
  }
  p_skipjunk(1,1);
  if (!isdigit(*lineptr)) {
    reporterror(1,E_ERR,"Expected number, found '%s'.",lineptr);
    val=0;
  } 
  else 
    val=p_number();

  switch(i) 
    {
    case 0: 
      if (val==0) dtype=AGT_NONE;
      else if (val==1) dtype=AGT_SELF;
      else if (val==1000) dtype=AGT_WORN;
      else {
	reporterror(1,E_ERR,"Only 0, 1 and 1000 are allowed here.",NULL);
	dtype=AGT_NUM;
      }
      break;
    case 1:dtype=AGT_ROOM;break;
    case 2:dtype=AGT_ITEM;break;
    case 3:dtype=AGT_CREAT;break;
    case 4:dtype=AGT_VAR;break;
    default:dtype=i-5+AGT_NUM;break;
    }
  if (i!=0 && dtype!=AGT_DIR && dtype!=AGT_NUM && dtype!=AGT_PROP 
      && dtype!=AGT_ATTR && (dtype!=AGT_FLAG || val!=0)) 
    reporterror(1,E_NOTE,"LABEL does not create new objects.",NULL);
  sym->dtype=dtype;
  sym->value.n=val;
  sym->usecnt=2; /* Prevent "Declared but not used" messages. */ 
}




/* This is used if we get stuck */
void p_skiplabel(void)
{
  p_skipjunk(1,1);
  for(;*lineptr!=0 && *lineptr!=end_label;lineptr++);
  if (*lineptr==end_label) lineptr++;
}




/* This routine does nothing on pass 1 except skip over a label.
   On pass 2, it
     i) Looks up a label if it can
     ii) Creates a new label if (i) fails.
   Currently, it is only used for roomflags that are declared
   by nouns or creatures */

long p_dyndeclare(int dtype)
{
  return p_lookup_label(dtype,1);
}




/* Looks for "" string; leaves pointer just after it. */
static rbool p_quotestr(const char **ps)
{
  char *s, c, *qstr;

  *ps=NULL;
  p_skipjunk(2,1);
  if (*lineptr!=start_quote) return 0;
  lineptr++;
  for(s=lineptr;*s && *s!=end_quote;s++);
  if (!*s) 
    reporterror(1,E_WARN,"Unterminated quotation.",NULL);
  c=*s; *s=0;
  qstr=new_string(lineptr);
  *s=c;
  lineptr=s;
  if (c) lineptr++;
  *ps=qstr;
  return 1;
}


static void new_propstr(const char *s)
{
  if (pass==1)
    propstr_size++;
  else
    propstr[prop_ptr++]=s;
}


attrdef_rec default_attr;
flagdef_rec default_flag;
propdef_rec default_prop;
vardef_rec default_var;

void set_istr_defaults(void)
{
  default_attr.ystr=default_flag.ystr=new_string("yes");
  default_attr.nstr=default_flag.nstr=new_string("no");
  default_prop.str_cnt=default_var.str_cnt=0;
  default_prop.str_list=default_var.str_list=0;
}


/* Parse LIKE [xxx] for vars/flags/objflags/props */
static void p_like(int *idp, int *pdtype,int base_dtype)
{
  symbol_def *sym;

  *pdtype=0;
  p_skipjunk(3,1);
  if (strncasecmp(lineptr,"like",4)==0) {
    lineptr+=4;
    p_skipjunk(1,1);
    if (*lineptr==start_label) {
      sym=scan_label(&lineptr,pass==2);
      if (sym==NULL) {
	p_skiplabel();
	*pdtype=AGT_NUM; /* Used to indicate a problem */
	*idp=0;
	return;
      }
      *pdtype=sym->dtype;
      if (sym->dtype!=AGT_DEFINE)
	*idp=sym->value.n;
    } else if (isdigit(*lineptr)) {
      *pdtype=base_dtype;
      *idp=p_number();
    } else {
      reporterror(1,E_ERR,"Expected label or number after LIKE.",NULL);
      return;
    }
    if (pass==2)
      *idp=rangecheck(*idp,*pdtype,1);
  }
}



static void p_flagstr(const char **pystr, const char **pnstr,
		      const char *def_ystr, const char *def_nstr,
		      rbool isdef, int dtype)
{
  int id, liketype;

  p_like(&id,&liketype,dtype); /* This also does range checks */
  if (liketype) { /* LIKE */
    if (pass==1) return;
    if (liketype==AGT_FLAG) {
      *pystr=flagtable[id].ystr;
      *pnstr=flagtable[id].nstr;
    } else if (liketype==AGT_OBJFLAG) {
      *pystr=attrtable[id].ystr;
      *pnstr=attrtable[id].nstr;
    } else if (liketype!=AGT_NUM) {
      reporterror(2,E_ERR,"LIKE given invalid type.",NULL); 
      return;
    }
    if (*pystr==NULL && *pnstr==NULL)
      reporterror(2,E_ERR,"LIKE requires label to be defined before use.",
		  NULL);      
  } else { /* Normal case */
    p_quotestr(pystr);
    p_quotestr(pnstr);
    if (pass==2 && *pystr==NULL && *pnstr==NULL && !isdef) {
      *pystr=def_ystr;
      *pnstr=def_nstr;
    }
  }
}


static void p_propstr(long *plist, long *pcnt, long def_list, long def_cnt,
		      rbool isdef,int dtype)
{
  const char *s;
  int id, liketype;

  p_like(&id,&liketype,dtype); /* This also does range checks */
  if (liketype) { /* LIKE */
    if (pass==1) return;
    if (liketype==AGT_VAR) {
      *plist=vartable[id].str_list;
      *pcnt=vartable[id].str_cnt;
    } else if (liketype==AGT_OBJPROP) {
      *plist=proptable[id].str_list;
      *pcnt=proptable[id].str_cnt;
    } else if (liketype!=AGT_NUM) {
      reporterror(1,E_ERR,"LIKE given invalid type.",NULL);
      return;
    }
    if (*plist==-1)
      reporterror(2,E_ERR,"LIKE requires label to be defined before use.",
		  NULL);      
  } else { /* Normal case */
    if (pass==1) *plist=propstr_size;
    while(p_quotestr(&s)) {
      if (pass==1) (*pcnt)++;
      new_propstr(s);
    }
    if (*pcnt==0 && !isdef) {
      *plist=def_list;
      *pcnt=def_cnt;
    }
  }
}


static void p_itemization_strings(int dtype, attrdef_rec *arec,  
				  flagdef_rec *frec, propdef_rec *prec,
				  vardef_rec *vrec, rbool isdef)
{
  switch(dtype) 
    {
    case AGT_OBJFLAG: 
      p_flagstr(&arec->ystr,&arec->nstr,
		default_attr.ystr,default_attr.nstr,isdef,dtype);
      break;
    case AGT_FLAG:
      p_flagstr(&frec->ystr,&frec->nstr,
		default_flag.ystr,default_flag.nstr,isdef,dtype);
      break;
    case AGT_OBJPROP:
      p_propstr(&prec->str_list,&prec->str_cnt,
		default_prop.str_list,default_prop.str_cnt,isdef,dtype);
      break;
    case AGT_VAR:
      p_propstr(&vrec->str_list,&vrec->str_cnt,
		default_var.str_list,default_var.str_cnt,isdef,dtype);
      break;
    default:
      /* AGT_CNT doesn't support itemization */
      break;
    }
}

/* Declare a sequence of labels */
/* Mask is only used for props and objflags; it indicates
   which types of objects (room/noun/creature) the prop/objflag
   applies to */
void p_declare_seq(int dtype, const char *endname, int mask)
{
  rbool multiline; /* Multiline form? (or single-line form?) */
  rbool reported_error;
  int n;
  char *oldptr;
  rbool is_attrprop;

  is_attrprop=(dtype==AGT_OBJFLAG||AGT_PROP);
  p_skipjunk(3,1); 
  multiline=(*lineptr==0);
  reported_error=0;

  for(;;) {
    while(*lineptr==0) {
      if (!multiline || !nextline(0,endname)) return;
      p_skipjunk(1,1);
    }
    oldptr=lineptr;
    if (strncasecmp(lineptr,"default",7)==0) {  
      /* DEFAULT case */
      lineptr+=7;
      p_itemization_strings(dtype,&default_attr,&default_flag,
			    &default_prop,&default_var,1);
    } else { /* Normal case */
      if ((dtype==AGT_OBJFLAG || dtype==AGT_OBJPROP) 
	  && mask==0 && !reported_error) {
	reporterror(1,E_ERR,"ROOM, NOUN, or CREATURE expected.",NULL);
	reported_error=1; /* Keep it from being printed out multiple times */
      }
      n=p_declare(dtype);           /* Read in label */
      if (oldptr==lineptr)          /* Failure */
	{p_skiplabel(); continue;}
      if (pass==1 && is_attrprop)
	alloc_userattr(n,mask,dtype);
      p_itemization_strings(dtype,attrtable+n,flagtable+n,
			    proptable+n,vartable+n,0);
    }
    p_skipjunk(1,1); /* Skip over everything but digits and labels */
  }
}





/* This reports type checking errors */

static rbool typematch(int dtype1, int sym_dtype)
{
  /* This will do for the moment, but it should really be replaced
     with something more intelligent */

  if (dtype1&AGT_VAR) dtype1=AGT_VAR;

  if (dtype1==AGT_NUM) return 1;

  if ( (dtype1<AGT_NUM && (dtype1&sym_dtype))
       || dtype1==sym_dtype)
    return 1;

  if (dtype1==AGT_GENFLAG && 
      (sym_dtype==AGT_ROOMFLAG || sym_dtype==AGT_PIX))
    return 1;

  if (dtype1==AGT_GENPROP &&
      (sym_dtype==AGT_PROP || sym_dtype==AGT_OBJPROP))
    return 1; 
		    		  
  if (dtype1==AGT_EXIT) {
    if (sym_dtype==AGT_ROOM || sym_dtype==AGT_MSG || sym_dtype==AGT_NONE) 
      return 1;
  }

  return 0;
}

static void typecheck(int dtype1, int sym_dtype, long sym_val, char *symname)
{
  if (!typematch(dtype1,sym_dtype))
      reporterror(2,E_WARN,"Label [%s] has wrong type.",symname);  
}


void label_err_msg(long val,int dtype)
{
  if (!strict_type) {  /* The special cases */
    if (dtype<AGT_VAR) {
      if (dtype&AGT_NONE && val==0) return;
      if (dtype&AGT_SELF && val==1) return;
      if (dtype&AGT_WORN && val==1000) return;
    }
    if (dtype==AGT_FLAG && val==0) return;
    if (dtype==AGT_DIR) return;
    if (dtype==AGT_EXIT && val>exitmsg_base) return;
  }
  assert(dtype!=AGT_NUM && dtype!=AGT_TIME && dtype!=AGT_GENFLAG);
  reporterror(2,E_WARN,"Expect labels instead of numbers for %ss.",
	      typename(dtype));
}


static rbool obj_rangecheck(long val, int dtype)
{
  if (pass==1) return 1; /* Can't analyse ranges on first pass */

  if (val==0) return (dtype&AGT_NONE);
  if (val==1) return (dtype&AGT_SELF);
  if (val==1000) return (dtype&AGT_WORN);
  if (val>=first_room && val<=maxroom) 
    return (dtype&AGT_ROOM);
  if (val>=first_noun && val<=maxnoun)
    return (dtype&AGT_ITEM);
  if (val>=first_creat && val<=maxcreat)
    return (dtype&AGT_CREAT);
  return 0;
}

static rbool misc_rangecheck(long val, int dtype)
{
  switch(dtype) 
    {
    case AGT_VAR: return (val>=0 && val<=VAR_NUM);
    case AGT_NUM:return 1;
    case AGT_DIR:return (val>=1 && val<=12);
    case AGT_FLAG:return (val>=0 && val<=FLAG_NUM);
    case AGT_CNT:return (val>=0 && val<=CNT_NUM);
    case AGT_QUEST:return (val>=1 && val<=MaxQuestion);
    case AGT_OBJFLAG: return (val>=0 && val<oflag_cnt);
    case AGT_OBJPROP: return (val>=0 && val<oprop_cnt);
    case AGT_MSG:return (val>=1 && val<=last_message);
    case AGT_ERR:return (val>=1 && val<=NUM_ERR);
    case AGT_STR:return (val>=1 && val<=MAX_USTR);
    case AGT_SUB:return (val>=1 && val<=MAX_SUB);
    case AGT_PIC:return (val>=0 && val<=maxpict); /* [None] is legal */
    case AGT_PIX:return (val>=1 && val<=maxpix);
    case AGT_FONT:return (val>=1 && val<=maxfont);
    case AGT_SONG:return (val>=1 && val<=maxsong);
    case AGT_ROOMFLAG:return (val>=1 && val<=32);
    case AGT_EXIT: return (obj_rangecheck(val,AGT_ROOM|AGT_NONE)
			   || misc_rangecheck(val-exitmsg_base+1,AGT_MSG));
    case AGT_GENFLAG: return (val>=1 && val<=64);
    case AGT_TIME: return (val>=0 && val<=2400);
    case AGT_ATTR: return (val>=0 && val<NUM_ATTR);
    case AGT_PROP: return (val>=0 && val<NUM_PROP);
    default:writeln("INTERNAL ERROR:Unrecognized type specifier.");
    }
  return 0;
}

/* This checks to see if a value is within the correct range */
/* This should only be used for numeric id's; it's not intended
   to be used for labels */
static long rangecheck(long val, int dtype,rbool is_label)
{
  int tindex;

  if (dtype&AGT_VAR) dtype=AGT_VAR;
  if (dtype==AGT_NUM) return val;

  if (dtype<AGT_VAR) tindex=0;
  else if (dtype&AGT_VAR) tindex=1;
  else tindex=dtype-AGT_NUM+2;
  assert(tindex>=0 && tindex<AGT_GENFLAG-AGT_NUM+3);
  if ((!is_label) && 1==categ_type[tindex]) /* Labeled category */
    label_err_msg(val,dtype);

  if (dtype<AGT_VAR) {
    if (obj_rangecheck(val,dtype)) return val;
  }
  else if (misc_rangecheck(val,dtype)) return val;
  reporterror(2,E_WARN,"Value out of range for %s.",typename(dtype));
  if (dtype<64 && pass!=1) {
    if (dtype&AGT_ROOM) return first_room;
    if (dtype&AGT_ITEM) return first_noun;
    if (dtype&AGT_CREAT) return first_creat;
  }
  return 0;
}


/* This scans a [...] form, leaves ptr pointing after it, and returns
   its value. */
static int symbol_val(symbol_def *sym, int dtype)
{
  long val;

  if (sym==NULL) return 0;  /* Error message will have already been printed */
  typecheck(dtype,sym->dtype,sym->value.n,sym->name);
  if (sym->dtype==AGT_DEFINE) return 0;
  val=sym->value.n;
  if (dtype==AGT_GENFLAG && sym->dtype==AGT_PIX)
    val+=32;
  if (dtype==AGT_EXIT && sym->dtype==AGT_MSG)       
    val+=exitmsg_base;
  val=rangecheck(val,dtype,1);
  return val;
}

int label_val(char **ptr, int dtype)
{
  symbol_def *sym;

  sym=scan_label(ptr,1);
  return symbol_val(sym,dtype);
}


/* This looks up tokens (usually) without declaring them */
/*   (do_declare will cause it to declare labels on pass 2) */
static long p_lookup_label(int dtype, rbool do_declare)
{
  long val;
  symbol_def *sym;
  
  p_skipjunk(1,2);
  if (*lineptr==0) {
    reporterror(2,E_ERR,"Expected label or number, found nothing.",NULL);
    return 0;
  } else if (lineptr[0]==start_label) { /* It's a label */
    sym=scan_label(&lineptr,!do_declare);
    if (do_declare && sym==NULL) {
      /* Rare case, so we can afford to be a little inefficient
         (such as using scan_label above) */
      if (pass==1) return 0;
      return p_basic_declare(dtype);
    }
    val=symbol_val(sym,dtype);
    if (PDEBUG) rprintf("[%ld]",val);
  } else if (isdigit(*lineptr)) { /* It's a number */
    val=p_number();
    if (dtype&AGT_VAR || dtype==AGT_FLAG || dtype==AGT_CNT) 
      make_obj(val,dtype);
    val=rangecheck(val,dtype,0);
    if (PDEBUG) rprintf("(%ld)",val);
  } else {
    if (PDEBUG) rprintf("(?)");
    val=0;
  }
  game_sig+=abs(val)&0xFFFF;
  return val;
}

long p_label(int dtype)
{
  if (PDEBUG) rprintf(" label");
  if (pass==1) return 0;
  return p_lookup_label(dtype,0);
}

/* Look for a '.' indicating a property reference. */
rbool find_propref(rbool accept_propref)
{
  /* Pre-Magx versions don't support properties in the first place */
  if (verflag!=v_agx || !accept_propref) return 0;

  while(isspace(*lineptr)) lineptr++;
  return (*lineptr=='.');
}


/* optype: 0=immediate, 1=variable, 2=NOUN, 3=OBJECT */
/* We need to OR the optype, not just overwrite. */
/* errstr is set to be an error message in the case that
   we have an apparent type mismatch that would be resolved
   if it is actually a property reference. */
/* term_type is zero unless we in the middle of parsing a
   ...[prop].[prop]... chain, in which case it indicates the expected
   type of the *last* element in the chain. This will always be
   AGT_ATTR, AGT_OBJFLAG, AGT_PROP, AGT_OBJPROP, or AGT_GENPROP.
   The last of these (AGT_GENPROP) is the most common. */
/*   If term_type!=0, dtype will *always* be AGT_GENPROP, indicating
     the expected intermediate type (a user-define or built-in 
     property) */
/* This routine sets builtin_prop to true for AGT_PROP, false for
   AGT_OBJPROP and left untouched for other types; it is used to
   distinguish between the two AGT_GENPROP datatypes. */

long p_operand(int dtype, int *optype,int term_type,rbool *builtin_prop)
{
  symbol_def *sym;
  int expected_type;

  assert( term_type==0 || (dtype==AGT_GENPROP && builtin_prop!=NULL) );

  p_skipjunk(verflag==v_agx?3:1,2);
  if (*lineptr==0) {
    reporterror(2,E_WARN,"Expected number or label, found nothing.",NULL);
    return 0;
  }
  if (keymatch("noun")) {
    if (!typematch(dtype,AGT_ITEM|AGT_CREAT) && !find_propref(term_type==0))
      reporterror(2,E_ERR,"NOUN not of the correct type.",NULL);
    *optype|=2;
    return 0;
  }
  if (keymatch("object")) {
    if (!typematch(dtype,AGT_ITEM|AGT_CREAT) && !find_propref(term_type==0))
      reporterror(2,E_ERR,"OBJECT not of the correct type.",NULL);
    *optype|=3;
    return 0;
  }
  if (keymatch("name")) {
    /* This is encoded as a direct type with argument -1 */
   if (!typematch(dtype,AGT_ITEM|AGT_CREAT) && !find_propref(term_type==0)) 
      reporterror(2,E_ERR,"NAME not of the correct type.",NULL);
    /* We leave optype alone */
    return -1;
  }
  if (keymatch("tos")) {  /* "Top of Stack" */
    /* This is encoded as a variable type with argument -1 */
    *optype|=1; /* Variable type */
    return -1;
  } 
  
  p_skipjunk(1,2);
  if (isdigit(*lineptr)) return p_label(dtype);
  if (*lineptr==start_label) {
    sym=scan_label(&lineptr,1);
    if (sym==NULL) return 0;
    if ((dtype&AGT_VAR)==0 && sym->dtype==AGT_VAR) {
      /* We have a variable being used in place of something else */
      *optype|=1;      
      return sym->value.n;
    }
    /* We have an immediate type */    

    if (term_type!=0) /* We are in a ...[prop].[prop]... list */
      if (find_propref(1)) expected_type=AGT_GENPROP;
      else expected_type=term_type; /* End of list */
    else if (find_propref(1))
      expected_type=AGT_ROOM|AGT_ITEM|AGT_CREAT;
    else expected_type=dtype;

    typecheck(expected_type,sym->dtype,sym->value.n,sym->name);

    /* Distinguish between the two AGT_GENPROP types */
    if (dtype==AGT_GENPROP && expected_type==AGT_GENPROP)
      *builtin_prop=(sym->dtype==AGT_PROP);

    if (sym->dtype==AGT_DEFINE) return  0;

    return sym->value.n;
  }

  reporterror(2,E_ERR,"Do not recognize operand '%s'.",lineptr);
  return 0;
}



/* Parses exit, which can be either a room or a message */
long p_exit(char *field)
{
  descr_ptr tmp;
  char *backup;

  if (pass==1) return 0;
  p_space();
  if (verflag==v_agx  && *lineptr!=start_quote 
      && *lineptr!=start_label && !isdigit(*lineptr)) {
    word w;
    backup=lineptr;
    w=p_dictline();
    if (w==0 || !lookup_verb(w,0,0))
      lineptr=backup;
    else
      return -w;    
  }
  p_skipjunk(2,2); /* Look for label, digit, or quote */
  if ( *lineptr==start_quote
       || (*lineptr==0)) {
    p_gendescr(&tmp,field);    
    return create_message(&tmp)+exitmsg_base;    
  }
  return p_label(AGT_EXIT);
}

/* We need to be carefule if we're called during the first pass
   since we can't actually call create_message until pass 2 */
long p_genmsg(char *sectname)
{
  descr_ptr tmp;
  char *newname;

  p_skipjunk(2,2);
  if (*lineptr==0 || *lineptr==start_quote) {
    newname=rstrdup(sectname);
    p_gendescr(&tmp,newname);
    if (pass==2) return create_message(&tmp);
  }
  if (pass==2) return p_label(AGT_MSG);
  return 0;
}



/* ------------------------------------------------------------------- */
/*  Routines to handle #DEFINEs                                        */
/* ------------------------------------------------------------------- */



/* Look up DEFINE label pointed at by *ptr, moving it after label and
 returning the value of the label */
static char *expand_label(char **ptr, int depth)
{
  symbol_def *sym;
  char *saveptr;

  if (depth>50)
    reporterror(1,E_FATAL,"#DEFINE expansion depth exceeded.",NULL);
  if (**ptr==0) return NULL;
  saveptr=*ptr;
  sym=scan_label(ptr,0);
  if (sym==NULL || sym->dtype!=AGT_DEFINE
    || (sym->usecnt==0 && pass>1) ) {
    /* The usecnt check makes sure the label has actually been defined
       on this pass, to maintain consistancy between passes */
    *ptr=saveptr; /* Back up */
    return NULL;
  }
  return expand_line(sym->value.s,depth);
}

/* Scan src and return a line with labels inserted */
char *expand_line(char *src, int depth)
{
  char *p, *dest, *repl, *oldrepl;
  const char *oldptr;
  long linesize, n;

  linesize=strlen(src)+1;
  dest=p=rmalloc(linesize);

  /* dest will point the to start of our new string;
     p will point to the part of the new string we are currently writing 
     src will be advanced to point at the part of the old string we are 
     currently reading */

  while(*src!=0) {
    if (*src==start_label) 
      {
	/* Do subsitution; need to deal with case where it makes line 
	   longer */
	oldptr=src;  /* Save so we know how long label is */
	oldrepl=repl=expand_label(&src,depth+1);
	if (repl!=NULL) { /* Is it a define? */
	  n=p-dest;    /* Save the offset of p, which we're about to move */
	  linesize=linesize+strlen(repl)-(src-oldptr);
	  dest=rrealloc(dest,linesize);  /* Enlarge our line */
	  p=dest+n;
	  while(*repl!=0)     	  /* Do the substitution */
	    *(p++)=*(repl++); 
	  rfree(oldrepl);
	  continue;
	}       
      }
    *(p++)=*(src++);    
  }
  *p=0;
  return dest;
}


/* This routine returns the expanded #DEFINE label pointed at by s */
char *get_define(char *s)
{
  return expand_label(&s,0);
}     






void p_define(void)
{
  char *oldlineptr;
  symbol_def *sym;

  p_skipjunk(0,1);
  if (*lineptr==0) { 
    reporterror(1,E_ERR,"Unexpected end of line while reading #DEFINE.",
		NULL);
    return;
  }
  oldlineptr=lineptr;
  if (pass!=1) {  /* Indicate that it has been defined */
    sym=scan_label(&lineptr,0);
    if (sym==NULL || sym->dtype!=AGT_DEFINE) 
      {lineptr=oldlineptr;return;}
    sym->usecnt=2; /* Prevent "Declared but not used" messages */
    return; 
  }
  sym=p_new_symbol();
  if (sym==NULL) {
    lineptr=oldlineptr;
    return;
  }
  lineptr++; 
  sym->value.s=rstrdup(lineptr);
  sym->dtype=AGT_DEFINE;
  sym->usecnt=0; 
}


/* ------------------------------------------------------------------- */
/* Description expansion                        */
/* ------------------------------------------------------------------- */

static void mismatch_error(char c)
{
  char buff[2];

  buff[0]=c; buff[1]=0;
  reporterror(2,E_WARN,"Ignoring mismatched '%s'.",buff);
}


/* The following handle # and $ replacement forms, such as
   #VARnn#, $STRnn$, etc.  */
/*  Support for FLAG, ON, OPEN, and LOCKED added by Mitch Mlinar */

typedef enum { sub_none=0, sub_str, sub_open, sub_on, sub_locked, sub_flag,
	       sub_var, sub_svar, sub_cnt, sub_attr, sub_prop, sub_sprop,
	       sub_attrnoun, sub_propnoun, sub_spropnoun
} repstr_type;

char repstr_term[]={0,'$','$','$','$','$',
		    '#','$','#','$','#','$',
		    '$','#','$'};
int repstr_arg[]={0, AGT_STR, AGT_ITEM, AGT_ITEM, AGT_ITEM, AGT_FLAG,
		  AGT_VAR, AGT_VAR, AGT_CNT, AGT_ATTR, AGT_PROP, AGT_PROP,
		  AGT_ATTR, AGT_PROP, AGT_PROP};


static repstr_type match_replacecode(const char **pstr)
{
  switch(tolower((*pstr)[1]))
    {
    case 'a': 
      if (match_str(pstr,"$ATTR")) {
	if (match_str(pstr,"NOUN.")) return sub_attrnoun;
	else return sub_attr;
      };
      break;
    case 'c': if ( match_str(pstr,"#CNT") || match_str(pstr,"#CTR") ) 
      return sub_cnt; break;
    case 'f': if (match_str(pstr,"$FLAG")) return sub_flag; break;
    case 'l': if (match_str(pstr,"$LOCKED")) return sub_locked; break;
    case 'o': 
      if (match_str(pstr,"$ON")) return sub_on; 
      else if (match_str(pstr,"$OPEN")) return sub_open; 
      break;
    case 'p': 
      if (match_str(pstr,"#PROP"))
	if (match_str(pstr,"NOUN.")) return sub_propnoun;
	else return sub_prop;
      else if (match_str(pstr,"$PROP")) {
	if (match_str(pstr,"NOUN.")) return sub_spropnoun;
        else return sub_sprop;}
      break;
    case 's': if (match_str(pstr,"$STR")) return sub_str; break;
    case 'v': 
      if (match_str(pstr,"#VAR")) return sub_var; 
      else if (match_str(pstr,"$VAR")) return sub_svar;
      break;
    default: break;
    }
  return sub_none;
}

/* Verify that the number following a replace code is in the right
   range (or that a label is of the correct type) */
/* <first>: First label in group? */
/* <dot>: Is it followed by a dot? */
static rbool validate_replacecode(repstr_type repl, symbol_def *sym,
				  rbool first, rbool dot)
{
  rbool pass;

  if (repl<sub_attr) {
    if (sym->dtype!=repstr_arg[repl]) {
      reporterror(2,E_WARN,"[%s] is not of the correct type.",sym->name);
      return 0;
    }
    if (repl==sub_svar && vartable[sym->value.n].str_cnt==0)
      reporterror(2,E_ERR,"$VAR used for numeric variable.",NULL);
    else if (repl==sub_var && vartable[sym->value.n].str_cnt>0)
      reporterror(2,E_NOTE,"#VAR used for itemized variable.",NULL);
    return 1;
  }
  /* Now deal with proplist case */
  if (repl>=sub_attrnoun) first=0;
  if (first) 
    pass=(sym->dtype==AGT_ROOM || sym->dtype==AGT_ITEM
	  || sym->dtype==AGT_CREAT);
  else if (dot || repstr_arg[repl]==AGT_PROP)
    pass=(sym->dtype==AGT_PROP || sym->dtype==AGT_OBJPROP);
  else 
    pass=(sym->dtype==AGT_ATTR || sym->dtype==AGT_OBJFLAG);
  if (!pass)
    reporterror(2,E_WARN,"[%s] is not of the correct type.",sym->name);
  else if (!dot && repstr_arg[repl]==AGT_PROP) {
    if (repl==sub_prop || repl==sub_propnoun) {/* #PROP case */
      if (sym->dtype==AGT_OBJPROP && proptable[sym->value.n].str_cnt>0) 
	reporterror(2,E_NOTE,"#PROP used for itemized property.",NULL);
    } else { /* $PROP case */
      if (sym->dtype!=AGT_OBJPROP || proptable[sym->value.n].str_cnt==0) 
	reporterror(2,E_ERR,"$PROP used for numeric property.",NULL);
    }
  }
  return pass;
}



/* This skips over constant property references; it returns 1 if
   it actually skipped over anything other than whitespace */
/* This skips over things of the form " 1234. 4334 . 434 " */
static rbool skip_proprefs(char **pdest, const char **pstr)
{
  rbool foundany;
  char *d;
  const char *s;

  if (pdest) d=*pdest; else d=NULL;
  s=*pstr;
  foundany=0;
  for(;;) {
    while(isspace(*s)) s++;
    if (!isdigit(*s)) break;
    foundany=1;
    while(isdigit(*s)) {
      if (d) *(d++)=*s;
      s++;
    }
    while(isspace(**pstr)) s++;
    if (*s!='.') break;
    if (d) *(d++)=*s;
    s++;
  }
  if (pdest) *pdest=d;
  *pstr=s;
  return foundany;
}


/* This attempts to parse a replacement string. If it succeeds,
   it leaves psrc pointing after it and copies the results into pdest.
   (except for the terminating character)
   If it fails, it leaves both *pdest and *psrc unchanged */
/* start points just beyond the $WORD that began this. */

static void parse_repl(repstr_type repl, char **pdest, const char **psrc,
			      const char *start)
{
  char *t;
  symbol_def *sym;
  rbool first; /* First label (for proplists) */

  first=1;
  if (repl<sub_attr) 
    while (isspace(*start)) start++; /* Skip whitespace */
  else
    first=!skip_proprefs(NULL,&start);
  if (start!=*psrc) return;
  do {
    t=*psrc;
    sym=scan_label(&t,1);
    if (sym==NULL) return;
    if ( repstr_term[repl]!=*t && (repl<sub_attr || *t!='.') ) {
      /* Missing final '#' or '$' or '.' */
      mismatch_error(repstr_term[repl]);
      return;
    }
    if (!validate_replacecode(repl,sym,first,*t=='.'))
      return;
    /* Okay, we have a legitimate label */
    *psrc=t;  /* Point s after it, at the trailing # or $ */
    assert(**psrc!=0);
    assert(sym->value.n>=0 && sym->value.n<0x7FFF);
    if (sym->dtype==AGT_ATTR || sym->dtype==AGT_PROP) /* Built in types */
      *(*pdest++)='-';
    sprintf(*pdest,"%d",(short)sym->value.n);
    *pdest+=strlen(*pdest);
    first=0;
    if (repl>=sub_attr) {
      if (**psrc=='.') *((*pdest)++)=*((*psrc)++);
      skip_proprefs(pdest,psrc);
      if (**psrc==repstr_term[repl]) return;
      if (**psrc!=start_label) {
	rprintf("XXX: %c :\n",**psrc);
	mismatch_error(repstr_term[repl]);
	return;
      }
    }
  } while(*t=='.');
}



/* This works like rstrdup, but also expands string and variable labels */
char *expand_descr(const char *s)
{
  char *newstr, *p;
  const char *t, *q;
  long linesize;
  const char *subs; /* Points to last # or $ we've run into */
  rbool have_label;
  repstr_type repl;

  linesize=0;
  have_label=0;
  for(q=s;*q!=0;q++) {
    if (*q==start_label) {
      linesize+=6-2; /* Assume numbers not more than six characters long */
      have_label=1;
    }
    else linesize++;
  }
  p=newstr=rmalloc(linesize+1);
  subs=NULL;
  if (!have_label) {  /* Don't need to fool with this */
    strcpy(newstr,s);
    return newstr;
  }
  while(*s!=0) {
    if (subs && *s==start_label) {
      /*...only if we are in $STRn$ or #VARn#, etc. */
      t=subs;
      repl=match_replacecode(&t);
      if (repl) parse_repl(repl,&p,&s,t); /* Which may not do anything */
      subs=NULL;
    } else if (*s=='$' || *s=='#') subs=s;
    *p++=*s++;
  }
  *p=0;
  return newstr;
}




/* ------------------------------------------------------------------- */
/*  Routines to add to dynamic data blocks                             */
/* ------------------------------------------------------------------- */

/* Create static string; this MUST be called on both passes since
 it uses the first pass to figure out how big to make the string space */
char *new_string(char *s)
{
  char *p;

  /* rprintf("New string: %s-->",s); */
  if (pass==1) {
    ss_size+=strlen(s)+1;
    /* rprintf("%ld\n",ss_size);*/
    return NULL;
  }
  p=static_str+ss_end;
  ss_end+=strlen(s)+1;
  /* rprintf("%ld\n",ss_end);*/
  assert(ss_end<=ss_size);
  strcpy(p,s);
  return p;
}



/* Returns dictionary index of first word on line, adding it to the
   dictionary if neccessary. Stores the length it moved in keyleng */
word p_dict(void)
{
  word w;
  char *s,  c;
  char *p;
  int psize, i;

  p_space();
  if (enable_fakespace) {
    p=rmalloc(25); psize=25; 
    i=0;
    for(s=lineptr;*s!=0 && !isspace(*s);s++) {
      if (*s==fake_space) p[i++]=' ';
      else p[i++]=*s;  
      if(i>=psize) {
	psize+=10;
	p=rrealloc(p,psize);
      }
    } 
    p[i]=0;
    w=add_dict(p);
    rfree(p);
  } else {
    for(s=lineptr;*s!=0 && !isspace(*s);s++);
    c=*s;
    *s=0;
    w=add_dict(lineptr);
    *s=c;
  }
  lineptr=s;
  return w;
}

static void check_internal_space(char *s)
{
  while(*s!=0 && !isspace(*s)) s++;
  if (*s!=0)
    reporterror(1,E_WARN,"Multiple words treated as one word.",
		NULL);
}

/* This adds the rest of the line as a word, trimming external whitespace
 (and issuing warnings if we have "multiple words"-- but still
 adding the multiple-word to the dictionary) */
word p_dictline(void)
{
  word w;
  char *s,  c;

  p_space();
  s=lineptr+strlen(lineptr);
  while( s>lineptr && isspace(*(s-1)) ) s--;
  c=*s;
  *s=0;
  check_internal_space(lineptr);
  w=add_dict(lineptr);
  *s=c;
  lineptr=s;
  return w;
}


/* This parses s as a list of synonyms, skipping skipword if it occurs */
/* It *doesn't* add the end-marker since we may want to append something
   else to the list under certain circumstances. */
/* It doesn't check for fake_space and so shouldn't be use for
   parsing verb or prep synlists  */

static slist parse_synstr(char **s, word skipword)
{
  slist n;
  word w;
  char *p,c; /* Moves forward to mark end of current word */

  n=synptr; /* Point to beginning of the list we are about to make */
  *s=skip_space(*s);
  while(**s!=0) {
    for(p=*s;*p!=0 && !isspace(*p);p++); /* Find the end of this word */
    c=*p; *p=0;
    w=add_dict(*s);
    if (w!=skipword) addsyn(w);
    *p=c; 
    *s=p;
    *s=skip_space(*s);
  }
  return n;
}


/* Parse list of words into a synlist and return index to it */
slist p_syns(void)
{
  slist n;
  word w;

  n=synptr;
  while(*lineptr!=0) {
    p_space();
    w=p_dict();
    addsyn(w);
  }
  addsyn(-1); /* Mark the end of the list */
  return n;
}

/* This shouldn't be called for verb or prep parsing as it
   doesn't check for fake_space */
slist p_syns_2(char *savename,word skipword)
{
  slist n;

  n=parse_synstr(&savename,skipword);
  parse_synstr(&lineptr,skipword);
  addsyn(-1);
  return n;
}

/* This shouldn't be called for verb or prep parsing as it
   doesn't check for fake_space */
slist default_syns(char *savename,word skipword)
{
  slist n;

  if (savename!=NULL)
    n=parse_synstr(&savename,skipword);
  else n=synptr;
  addsyn(-1);
  return n;
}


void put_descr(descr_ptr *dptr,descr_line *txt)
{
  if (e_cnt[E_ERR]+e_cnt[E_FATAL]==0)
    write_descr(dptr,txt);
  else { 
    /* We do this to clearly mark the description ptr as being used */
    dptr->size=1;
    dptr->start=0;
  }
}
