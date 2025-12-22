/* Compile.c:  The core of the AGT compiler               */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

/* This is a two-pass compiler. The passes have the following
      restrictions: 
    Pass 1: Create symbol table and dictionary.  No
       object numbers should be stored here since they are subject to
       change, but we do need to create the object arrays to hold
       dictionary information about them.  Verb synonym information is
       also built up during this pass.  
    Pass 2: Finish creating objects and compile metacommands.  In general,
       as many things have been moved to pass 2 as possible.  Usually
       something is only put in Pass 1 if its results are needed during 
       this pass.
*/

/* 
   This is a simple recursive-descent compiler. Routines beginning with "p_" 
   are parsing routines, responsible for parsing a particular type of 
   object and leaving the input pointer pointing to the next character
   after it. (p_ routines for things that always take up the rest of the
   line aren't required to set the input pointer to the end of line; they
   can assume that the next thing done at the higher level will be to read
   a new line, making the input pointer moot.)

   *Parsing routines for high level objects appear in this module.  
   *Room, noun, and creature declarations are handled in objcomp.c
   *Metacommands (both the headers and the individual tokens) are handled
     by command.c. 
   *Label, number, and other low-level parsing routines are in symbol.c. 
   *File input, the prepreproccessor, and '#' directives are all implemented
     in preproc.c.

   If you are trying to understand the structure of this compiler, 
   I recommend starting with p_game() and working down from there
   (p_game is called twice, once for each pass).
*/


#define global
#include <assert.h>
#include <ctype.h>
#include <stddef.h>

#include "agility.h"
#include "comp.h"


typedef enum {T_ROOM, T_HELP, T_SPECIAL,
      T_NOUN, T_PUSH, T_PLAY, T_PULL, T_TURN, T_TEXT,
      T_CREAT, T_TALK, T_ASK } text_spec;

static char *desc_name[]={"room_descr","help","special",
		 "noun_descr","push","play","pull","turn","text",
		 "creature_descr","talk","ask"};

static descr_ptr **desc_array[]={&room_ptr,&help_ptr,&special_ptr,
		  &noun_ptr,&push_ptr,&play_ptr,&pull_ptr,&turn_ptr,&text_ptr,
		  &creat_ptr,&talk_ptr,&ask_ptr};    


/* ------------------------------------------------------------------- */
/* Parsing of general arguments: Descriptions, options, etc.           */
/* ------------------------------------------------------------------- */

void p_descr(descr_ptr *dptr,char *keyword)
     /* Reads the remaining text as a description, ending with
	END_<keyword>; writes it to description block and 
	sets dptr appropriatly */
{
  descr_line *dline;
  long dl; /* Description line pointer */

  dl=0; dline=NULL;
  if (pass==2) {
    dline=rmalloc(sizeof(descr_line));
    dline[0]=NULL;  
  }
  set_section_class(1);
  for(;;) {
    if (!nextline(1,keyword)) {
      if (pass==2) {
	int i;
	if (dptr!=NULL)
	  put_descr(dptr,dline);  /* Save description to file and set dptr */
	for(i=0;i<dl;i++)
	  rfree(dline[i]);
	rfree(dline);
      }
      return;
    }
    if (pass==2) {
      dline[dl++]=expand_descr(line);
      dline=rrealloc(dline,(dl+1)*sizeof(descr_line));
      dline[dl]=NULL;
    }
  }
}


static descr_ptr *descindex(descr_ptr *dptr, integer index)
{
  if (index>=0 && pass==2) {
    if (dptr[index].size>0) { 
      if (dptr==err_ptr) { 
	/* STANDARD messages are a special case since you might want
	   to override a specific one. */ 
	reporterror(2,E_WARN,"Duplicate STANDARD Message.",NULL);
	return NULL;
      }
      reporterror(2,E_ERR,"Duplicate description.",NULL);
    }
    return dptr+index;
  }
  return NULL;
}

/* This handles descriptions that could be either one line
   or multiple-line */
/* lineptr needs to have moved passed any earlier tokens on the line */
void p_gendescr(descr_ptr *dptr,char *keyword)
{
  char *s;

  if (!p_descline(dptr,0)) {
    s=NULL;
    if (isupper(*keyword)) {  /* Lowercase keyword if not already lowercase */
      /* (Because of the cases in which this is called, we can assume
	 anything with its first letter lower-case will be all lower-case.)
	 */
      keyword=rstrdup(keyword);
      for(s=keyword;*s!=0;s++) *s=tolower(*s);
      s=keyword;
    }      
    p_descr(dptr,keyword);
    if (s!=NULL) rfree(keyword);
  }
}


/* This parses "property" lines... i.e. lines of the form
   KEYWORD <number> ... and returns the number */
/* dtype is in the same form as for opcodes */
/* Field is the name of the keyword, used for printing error messages */

long p_prop(int dtype, char *field)
{
  if (pass==1) return 0; 
  return p_label(dtype);
}


/* This is like p_prop, but it reads in a nonnegative number that
   is <=range. (If range is -1, it is treated as infinity)*/
long p_option(integer range, char *field)
{
  int val;

  if (pass==1) return 0;  
  val=p_label(AGT_NUM);
  if (val<0) {
    reporterror(2,E_ERR,"Negative argument to option '%s'.",field);
    return 0;
  } else if (range>=0 && val>range) {
    reporterror(2,E_ERR,"Argument to option '%s' is too big.",field);
    return 0;
  }
  return val;
}


/* ------------------------------------------------------------------- */
/*  VERSION routines                                                   */
/* ------------------------------------------------------------------- */

/* Set up version defaults for our current verflag setting */
static void version_defaults(void)
{
  bold_mode=0;
  strict_type=0;
  ignore_extra_text=1;
  intro_first=0;
  max_lives=3;
  PURE_ANSWER=1;
  PURE_PROSUB=PURE_DUMMY=PURE_SUBNAME=0;
  PURE_AND=2;
  PURE_METAVERB=2;
  PURE_ALL=PURE_DISAMBIG=2;
  PURE_HOSTILE=1;
  PURE_GETHOSTILE=1;
  PURE_GRAMMAR=1;
  PURE_AFTER=1;
  TWO_CYCLE=implicit_two_cycle;
  start_time=1200;
  delta_time=5;
  nomatch_active=0;
  if (verflag>=v_default) { /* ME / Default / AGX common settings */
      box_title=1;    
      PURE_ROOMTITLE=0;
  } else {  /* 1.83/Classic common settings */
    box_title=0;
    PURE_ROOMTITLE=2;
  }

  switch(verflag) 
    {
    case v_gags: 
      aver=AGT10;
      default0_noun.open=1;
      break;
    case v_class:
      aver=AGT135;
      break;
    case v_183:
      bold_mode=1;
      intro_first=1;
      max_lives=1;
      start_time=0;
      delta_time=0;
      aver=AGT183;
      TWO_CYCLE=1;
      PURE_AFTER=0;
      break;
    case v_master: 
      aver=AGTMAST;
      break;
    case v_default:
      aver=AGTMAST;
      box_title=2;
      PURE_ROOMTITLE=2;
      break;
    case v_agx:
      aver=AGX00;
      PURE_ANSWER=0;
      PURE_AND=0;
      PURE_METAVERB=0;
      PURE_PROSUB=0;
      PURE_ALL=PURE_DISAMBIG=0;
      PURE_GRAMMAR=0;
      PURE_AFTER=0;
      max_lives=1;
      strict_type=1;
      ignore_extra_text=0;
      nomatch_active=1;
#if 0
      PURE_HOSTILE=0;
      PURE_GETHOSTILE=0;
#endif
      break;
    default: rprintf("INT ERR: Invalid verflag.\n");
      return;
    }
}



static void p_version(void)
{
  if (verflag!=v_default)
    reporterror(1,E_WARN,"VERSION redefined.",NULL);
  p_space();
  if (keymatch("magx"))
    verflag=v_agx;
  else if (keymatch("classic"))
    verflag=v_class;
  else if (keymatch("gags"))
    verflag=v_gags;
  else if (keymatch("masters"))
    verflag=v_master;
  else if (keymatch("1.83"))
    verflag=v_183;
  else {
    reporterror(1,E_WARN,"Invalid VERSION %s; ignoring.",lineptr);
    return;
  }

  /* Now to set the defaults for our newly chosen version */
  version_defaults();
}


/* ------------------------------------------------------------------- */
/*  Parsing of minor top level structures                              */
/* ------------------------------------------------------------------- */

static void p_config(void)
{
  for(;;) {  /* loop until we hit END_CONFIG */
    if (!nextline(0,"config")) return;
    if (!parse_config_line(lineptr,1))
      reporterror(1,E_WARN,"Too many words on configurtion line.",NULL);
  }
}


static void p_objdesc(text_spec desctype)
     /* Declarations of description text associated with objects */
{
  int dtype;
  int objnum;
  descr_ptr *obj_ptr;

  if (desctype<=T_SPECIAL) dtype=AGT_ROOM;
  else if (desctype<=T_TEXT) dtype=AGT_ITEM;
  else dtype=AGT_CREAT;

  if (pass==2) {
    objnum=p_prop(dtype,desc_name[desctype]);
    switch(dtype) 
      {
      case AGT_ROOM: objnum-=first_room;break;
      case AGT_ITEM: objnum-=first_noun;break;
      case AGT_CREAT: objnum-=first_creat;break;
      }    
  } else 
    objnum=-1;

  obj_ptr=*(desc_array[desctype]);
  
  p_descr(descindex(obj_ptr,objnum),desc_name[desctype]);
}


static void p_message(void)
{
  int msgnum;

  msgnum=p_declare(AGT_MSG);
  p_descr(descindex(msg_ptr,msgnum-1),"message");
}

static void p_errmsg(void)
{
  int errnum;

  errnum=p_declare(AGT_ERR);
  p_descr(descindex(err_ptr,errnum-1),"standard");
}

static void p_question(void)
{
  int qnum;

  qnum=p_declare(AGT_QUEST);
  p_descline(descindex(quest_ptr,qnum-1),1);
}


static void p_answer(void)
{
  int qnum;

  if (pass==2)
    qnum=p_prop(AGT_QUEST,"Answer");
  else qnum=-1;

  p_descline(descindex(ans_ptr,qnum-1),1);
}


static rbool multiword_ustr;

static char *p_string(int dtype)
{
  char *s;

  while(isspace(*lineptr)) lineptr++;
  if (multiword_ustr && dtype==AGT_STR) return lineptr;
  /* User string; use the rest of line */ 
  s=lineptr;
  for(;*lineptr!=0 && !isspace(*lineptr);lineptr++); /* Find end of word */
  if (*lineptr!=0) *(lineptr++)=0;
  return s;
}


/* This parses [label] string lists.
   dtype can be AGT_SOUNDS/PIC/PIX/FONT/STR */
static void p_stringlist(int dtype)
{
  char *sectstr;
  int val;
  char *s;
  word w;

  switch(dtype) 
    {
    case AGT_STR: sectstr="strings";break;
    case AGT_PIX: sectstr="room_pix"; break;
    case AGT_PIC: sectstr="pictures";break;
    case AGT_FONT: sectstr="fonts";break;
    case AGT_SONG: sectstr="sounds";break;
    default: fatal("INT ERROR: invalid string-list type.");
      sectstr=NULL; /* Get rid of compiler warnings */
    }
  w=0; 
  for(;;) {
    if (!nextline(0,sectstr)) return;
    val=p_declare(dtype);
    s=p_string(dtype);
    if (dtype==AGT_PIX) w=p_dict();
    if (dtype!=AGT_STR) {
      s=new_string(s);
      if (pass==2)
	switch(dtype) 
	  {
	  case AGT_PIC: pictlist[val-1]=s;break;
	  case AGT_PIX: {
	    if (val<1 || val>MAX_PIX) {
	      reporterror(1,E_ERR,"RoomPIX out of range.",NULL);
	      break;
	    }
	    pixlist[val-1]=s;
	    pix_name[val-1]=w;
	    break;
	  }
	  case AGT_FONT: fontlist[val-1]=s;break;
	  case AGT_SONG: songlist[val-1]=s;break;
	  default: fatal("INT ERROR: invalid string-list type.");
	  }
    } else 
      if (pass==2) {
	if (strlen(s)>80) {
	  assert(val>=1 && val<=MAX_USTR);
	  s[80]=0;
	  reporterror(2,E_WARN,"User string longer than 80 characters; "
		      "truncated.",NULL);
	}
	strcpy(userstr[val-1],s);
      }
  }
}


int lookup_verb(word w, rbool decl, rbool add_word)
     /* Given a word w, searches auxsyn and returns the verb id */
     /* decl is true if we are calling from p_verb, false otherwise */
     /* add_verb indicates we should add the verb to the dictionary
	if it isn't already there */
{
  int i;
  long j;
  char *s, *t;

  /* Check game-specific synonyms first */
  /* Scan in reverse so later synonyms will override earlier ones */
  if (!decl)
    for(i=TOTAL_VERB-1;i>0;i--)  
      for(j=synlist[i];syntbl[j]!=0;j++)
	if (w==syntbl[j]) return i;

/* Check built in verbs; it _should_ be here  */
  for(i=1;i<TOTAL_VERB;i++)
    for(j=auxsyn[i];csyntbl[j]!=0;j++)
      if (csyntbl[j]==w) return i;

  /* Now check to see if it has the form of a dummy_verb */
  /* If so, create a new dummy verb */
  if (strncmp(dict[w],"dummy_verb",10)==0) {
    t=s=dict[w]+10;
    while(isdigit(*t)) t++;
    j=strtol(s,NULL,0);
    if (*t==0 && j>DVERB && add_word) {  /* Yes-- a new dummy verb. */
      creat_dverb(j);
      return BASE_VERB+j-1;
    }
  }

#ifdef ALLOW_DOUBLE_VERBSYN
  /* For p_verb, check game-specific synonyms now, but only look at first */
  /*   entries */ 
  /* This is in case the player is defining a second set of synonyms */
  /*  for a verb they defined earlier. */
  if (decl)
    for(i=0;i<TOTAL_VERB;i++)  
      if (w==syntbl[synlist[i]]) return 0;
#endif

  if (!add_word) return 0; /* Failure */

 /* Failed to find a match.  Create a new dummy_verb. */
  /* For p_verb, need to .... */
  i=BASE_VERB+DVERB;
  creat_dverb(DVERB+1);
  synlist[i]=synptr;
  addsyn(w);
  if (!decl) {
    addsyn(-1);  /* p_verb will want to add more */
    reporterror(2,E_NOTE,"Created new verb '%s'.",dict[w]);
  }
  if (decl) return -i;  /* So p_verb will know what happened. */
  return i;
}


#ifdef ALLOW_DOUBLE_VERBSYN /* doesn't work */
/* This moves the synlist pointed to by sl to the *end* of syntbl,
   moves up the rest of syntbl, returns the "new" sl, and moves
   all of synlist[] to point at their new locations. For this reason,
   it should only be called during pass 1 (since it assumes no one but
   synlist[], noun[].syns, and creature[].syns is pointing into syntbl... 
   which may not be true  during pass 2) */
static slist move_syn(slist sl)
{
  slist i, newsl, oldsl;
  int j, delta;

  newsl=synptr; oldsl=sl;
  for(i=sl;syntbl[i]!=0;i++) addsyn(i); /* We _don't_ add the end marker */
  
  /* -- Compact syntbl here, remembering to fix newsl -- */
  i++;  /* Skip end marker */
  while(i<synptr) syntbl[sl++]=syntbl[i++];
  delta=i-sl;
  synptr-=delta;

  /* Now correct everything that points at it */
  newsl-=delta;
  for(j=0;j<TOTAL_VERB;j++) 
    if (synlist[j]>=oldsl) synlist[j]-=delta;
  for(j=0;j<maxnoun-first_noun+1;j++)
    if (noun[j].syns>=oldsl) noun[j].syns-=delta;
  for(j=0;j<maxcreat-first_creat+1;j++)
    if (creature[j].syns>=oldsl) creature[j].syns-=delta;
  return newsl;
}
#endif 



static void p_verb(void)
  /* This parses synlists and builds synlist[], dynamically enlarging
   it as neccessary. */
{
  word w1; /* First word on the line */
  int v1;  /* Verb we are creating synonyms for */

  if (verflag==v_agx) enable_fakespace=1;
  for(;;) {  /* loop until we hit END_VERB */
    if (!nextline(0,"verb")) break;
    if (pass==2) continue;

    /* parse line as a list of synonyms, starting with "canon" form */
    w1=p_dict();
    v1=lookup_verb(w1,1,1);
    if (v1<0)  /* lookup_verb created a new verb */
      p_syns(); /* Add the rest of the synonyms */
    else if (synlist[v1]==0) synlist[v1]=p_syns();  /* The standard case */
    else {  /* <sigh> We already have synonyms for this verb. */
      reporterror(1,E_WARN,
		  "Multiple sets of synonyms for the verb '%s' ignored.",
		  dict[csyntbl[auxsyn[v1]]]);
#ifdef ALLOW_DOUBLE_VERBSYB /* doesn't work */
      synlist[v1]=move_syn(synlist[v1]); /* Moves it to end */
      p_syns();    /* Append remain synonyms */
#endif
    }
  }
  enable_fakespace=0;
}





static void p_sublist(void)
  /* This is just a list of labels, declaring subroutines */
{
  int n;
  char buff[20];

  for(;;) {
    if (!nextline(0,"subroutine")) return;
    n=p_declare(AGT_SUB);
    sprintf(buff,"subroutine%d",n);
    add_dict(buff);
  }
}


static int p_objtype(void)
{
  switch (p_key()) 
    {
    case kRoom: return 1;
    case kNoun: return 2;
    case kCreature: return 4;
    case kEOL: return 0;
    default: return 0;
    }
}


static void p_userattr(int t)
     /* List of object flags */
{
  int mask,tmp;  /* 1=room, 2=noun, 4=creature */

  if (min_ver<1) min_ver=1;  /* Need 0.8.8 to use objflags and objprops */
  mask=0;
  do {
    tmp=p_objtype();
    mask|=tmp;
  } while (tmp!=0);
  p_declare_seq(t,t==AGT_OBJFLAG ? "objflag" : "prop",mask);
}


static void p_vocab(void)
{
  for(;;) {
    if (!nextline(0,"vocabulary")) return;
    if (pass==2) add_verbrec(lineptr,0);
  }
}


static void p_globalnoun(void)
{
  for(;;) {
    if (!nextline(0,"global_nouns")) return;
    if (pass==2) continue;
    numglobal++;
    globalnoun=rrealloc(globalnoun,numglobal*sizeof(word));
    globalnoun[numglobal-1]=p_dictline();
  }
}


static void p_flagnoun(void)
{
  int n;

  for(;;) {
    if (!nextline(0,"flag_nouns")) return;
    if (pass==2) continue;
    n=p_declare(AGT_ROOMFLAG);
    if (n>=1 && n<=MAX_FLAG_NOUN)
      flag_noun[n-1]=p_dictline();    
    else 
      reporterror(1,E_ERR,"RoomFLAG value out of range.",NULL);
  }
}

static void p_preplist(void)
{
  int w;

  if (pass==2) return;
  while(*lineptr!=0) {
    p_space();
    if (verflag==v_agx) enable_fakespace=1;
    w=p_dict();
    enable_fakespace=0;
    if (w!=0) {
      num_prep++;
      userprep=rrealloc(userprep,num_prep*sizeof(slist));
      userprep[num_prep-1]=add_multi_word(w);  
      if (userprep[num_prep-1]==0) { 
	/* w really is just one word-- no spaces */
	userprep[num_prep-1]=synptr;
	addsyn(w);  /* Add it twice: w -> w */
	addsyn(w);
	addsyn(-1);
      }
    }  
  }
}




/* ------------------------------------------------------------------- */
/* Parse game                                                          */ 
/* ------------------------------------------------------------------- */

static void set_183_time(int part,int val)
     /* part: 0=min, 1=hrs, 2=am/pm */
{
  int hr, min, am;

  min=start_time%100;
  hr=(start_time/100)%12;
  am=start_time/1200;
  switch(part) 
    {
    case 0: min=val; break;
    case 1: hr=val; break;
    case 2: am=val; break;
    }
  start_time=min+100*hr+1200*am;
}


/* Convert from 1.83 STATUS_LINE to STATUS_OPTION */
int convert_183_status[]={0x40,0,4,3,1};
/* In 1.83, 0 is illegal. */

static void p_game(void)
{
  rbool just_started;

  just_started=1;
  verflag=v_default;  /* Reset default version for each pass so the two
			 passes will agree with each other. */
  fake_space='.';
  enable_fakespace=0;

  /* (Re)set defaults for rooms, nouns, and creatures. */
  set_obj_defaults();
  set_istr_defaults();

  if (PDEBUG) rprintf("**>Game");
  do {
    if (pass==2 && game_sig>=0x10000)
      game_sig=-game_sig;
    if (!nextline(0,NULL)) return;
    if (PDEBUG) {writeln("");rprintf("  ");}
    /* Note: using continue instead of break below prevents 
       just_started from being cleared; it should be done for any
       directive that should be allowed to come before VERSION */
    switch(p_key()) 
      {
      case kVersion:
	if (!just_started)
	  reporterror(1,E_WARN,"VERSION should be the first directive in "
		      "the file.",NULL);
	p_version();
	break;
      case kLabel: p_declaration(); break;
      case kConfig: p_config(); break;
      case kAskDescr:p_objdesc(T_ASK);break;
      case kAnswer: p_answer();break;
      case kCommand:p_command(0);break;
      case kAfter:
	if (verflag<v_agx) {
	  reporterror(1,E_WARN,"AFTER requires VERSION MAGX.",NULL);
	  break;
	}
	implicit_two_cycle=1;
	p_command(1);
	break;
      case kCreature:p_creat();break;
      case kCreatureDescr:p_objdesc(T_CREAT);break;
      case kCounter:p_declare_seq(AGT_CNT,"counter",0);break;
      case kFlag:p_declare_seq(AGT_FLAG,"flag",0);break;
      case kFlagNouns:p_flagnoun();break;
      case kFonts:p_stringlist(AGT_FONT);break;
      case kRoomPix: p_stringlist(AGT_PIX);break;
      case kGlobalNouns:p_globalnoun();break;
      case kHelp:p_objdesc(T_HELP);break;
      case kIntro:
	if (verflag==v_master) {
	  p_descr(&intro_ptr,"intro");
	  break;
	}  
	/* Otherwise treat as INTRODUCTION and fall through... */
      case kIntroduction:
	p_descr(&intro_ptr,"intro");break;
      case kInstructions:p_descr(&ins_ptr,"instructions");break;
      case kMessage:p_message();break;
      case kStandard:p_errmsg();break;
      case kNoun:p_noun();break;
      case kNounDescr:p_objdesc(T_NOUN);break;
      case kPushDescr:p_objdesc(T_PUSH);break;
      case kPullDescr:p_objdesc(T_PULL);break;
      case kPlayDescr:p_objdesc(T_PLAY);break;
      case kPictures:p_stringlist(AGT_PIC);break;
      case kObjflag: p_userattr(AGT_OBJFLAG);break;
      case kProp: p_userattr(AGT_OBJPROP);break;
      case kQuestion:p_question();break;
      case kRoom:p_room();break;
      case kRoomDescr:p_objdesc(T_ROOM);break;
      case kSpecial:p_objdesc(T_SPECIAL);break;
      case kSubroutines:p_sublist();break;
      case kSounds:p_stringlist(AGT_SONG);break;
      case kStrings:p_stringlist(AGT_STR);break;
      case kTurnDescr:p_objdesc(T_TURN);break;
      case kText:p_objdesc(T_TEXT);break;
      case kTalkDescr:p_objdesc(T_TALK);break;
      case kTitle:p_descr(&title_ptr,"title");break;
      case kVariable:p_declare_seq(AGT_VAR,"variable",0);break;
      case kVerbs: /* Fall through ... */
      case kSynonyms:
      case kVerb:p_verb();break;
      case kVocabulary:p_vocab();break;
      case kPrep: case kPreposition: p_preplist(); break;
	
	/* Now the simple one-line directives */
      case kRem: continue;  /* The unofficial AGT comment statement */
      case kFreeze: freeze_mode=1; continue; 
      case kMaxLives:max_lives=p_option(-1,"Max Lives");break;
      case kMaximumScore:max_score=p_option(-1,"Max Score");break;
      case kLongString:multiword_ustr=1;break;
      case kResurrectionRoom:
	resurrect_room=p_prop(AGT_ROOM,"Resurrection_Room");
	break;
      case kStartingRoom:
	start_room=p_prop(AGT_ROOM,"Starting_Room");
	break;
      case kScoreOption:score_mode=p_option(8,"Score_Option");break;
      case kStatusOption:statusmode=p_option(5,"Status_Option");break;
      case kStatusLine: 
	statusmode=convert_183_status[p_option(4,"Status_Line(1.83)")];
	if (statusmode==0x40) {
	  reporterror(2,E_ERR,"Invalid 1.83 STATUS_LINE option.",NULL);
	  statusmode=0;
	}
	break;
      case kStartingTime:
	start_time=p_prop(AGT_TIME,"Starting_Time");
	break;
      case kHours:
	set_183_time(1,p_prop(AGT_NUM,"Hours"));
	break;
      case kMinutes:
	set_183_time(0,p_prop(AGT_NUM,"Minutes"));
	break;
      case kAmTime: set_183_time(2,0); break;
      case kPmTime: set_183_time(2,1); break;
      case kMilitaryTime: milltime_mode=1; break;
      case kIntroFirst:
	intro_first=1;
	break;
      case kTitleBox:	
	box_title=1;
	break;
      case kNoTitleBox:
	box_title=0;
	break;
      case kRandomTime: 
      case kDeltaTime:delta_time=p_prop(AGT_TIME,"Delta_Time");break;
      case kNoDebug: debug_mode=0; break;
      case kTreasureRoom:
	treas_room=p_prop(AGT_ROOM,"Treasure_Room");
	break;
      case kEOL: continue; /* Just skip empty lines */
      case IllKey: reporterror(2,E_WARN,"Unrecognized directive.",NULL);
	continue;
      default: 
	reporterror(2,E_WARN,"Unexpected directive at top-level.",
			   NULL);
	continue;
    }
    just_started=0;
  } while (1);
}




/* ------------------------------------------------------------------- */
/*  Initialization of key data structures.                             */
/* ------------------------------------------------------------------- */
static descr_ptr *init_dp(long numrec)
{
  long i;
  descr_ptr *tmp;

  if (numrec<=0) return NULL;
  tmp=rmalloc(numrec*sizeof(descr_ptr));
  for(i=0;i<numrec;i++) {
    tmp[i].size=0;tmp[i].start=0;
  }
  return tmp;
}


/* ------------------------------------------------------------------- */

static void fix_comblist(void)
{
  int vb, i, ptr;

  for(vb=0;vb<TOTAL_VERB;vb++) 
    for(i=synlist[vb];syntbl[i]!=0;i++) {
      ptr=add_multi_word(syntbl[i]);
      if (ptr!=0) {
	num_comb++;
	comblist=rrealloc(comblist,num_comb*sizeof(slist));
	comblist[num_comb-1]=ptr;
      }
    }
}



/* ------------------------------------------------------------------- */

static void init(void)
{
  int i;

  build_trans_ascii();
  build_fixchar();
  build_keyhash();
  build_ophash();

  exitmsg_base=1000;  
  multiword_ustr=0;  /* Don't allow user strings to be more than one word */
  ignore_extra_text=1; /* Supress "extra text on line" warning */
  strict_type=0;  /* Strict type checking off by default */
  implicit_two_cycle=0;
  min_ver=0;  /* Unless we explicitly use a higher-level feature,
		 the game can run on AGiliTy 1.0 */

  init_symbol();
  freeze_mode=0;
  FLAG_NUM=-1; CNT_NUM=-1; VAR_NUM=-1;
  flagtable=NULL; vartable=NULL;
  create_flag(0); /* Sets FLAG_NUM to 0 and create flag0 */
  MAX_USTR=MAX_SUB=0;
  DVERB=0;
  MaxQuestion=0;
  last_message=last_cmd=NUM_ERR=0;
  numglobal=0;
  maxpict=maxpix=maxfont=maxsong=0;
  flag_noun_cnt=0;
  for(i=0;i<MAX_FLAG_NOUN;i++)
    flag_noun[i]=0;

  first_room=first_noun=first_creat=0x7FFF;
  maxroom=maxnoun=maxcreat=0;
  room=NULL;
  noun=NULL;
  creature=NULL;

  init_userattr();
  num_rflags=num_nflags=num_cflags=0;
  num_rprops=num_nprops=num_cprops=0;
  objflag=NULL;
  objprop=NULL;
  propstr_size=prop_ptr=0; propstr=NULL;

  oflag_cnt=oprop_cnt=0;
  attrtable=NULL;
  proptable=NULL;

  for(i=0;i<E_FATAL;i++)
    e_cnt[i]=0;

  start_room=treas_room=2;
  statusmode=0;
  score_mode=0;
  resurrect_room=1000; /* Will be changed to starting room if still 1000
			  at end */
  max_lives=3;
  max_score=0;
  start_time=1200; delta_time=5;
  ver=3; aver=AGX00;
  verflag=v_default;
  version_defaults();
  game_sig=0;
  vm_size=0;
  static_str=NULL; ss_size=ss_end=0;
  sub_name=NULL;
 

  agx_file=0;
  no_auxsyn=0; /*  We need the auxsyn table for our own use... */
  init_dict();
  reinit_dict();
  compiler_ext_dict(); /* Add key built-in words */

  /* ... but we don't want the auxsyn table to be included in the
     file we're creating */
  /* So we steal it and clear out the main syntbl. */
  csyntbl=rrealloc(syntbl,synptr*sizeof(word)); 
  csynptr=synptr;
  syntbl=NULL; synptr=syntbl_size=0;
 
  /* This ensures a slist of 0 always gives the empty list */
  addsyn(-1);

  synlist=rmalloc(sizeof(slist)*BASE_VERB);
  for(i=0;i<BASE_VERB;i++)
    synlist[i]=0; /* point them all at empty list to begin with */

  init_verbrec();

  /* Set up base object defaults */
  init_def_obj();
}


/* This initializes game data structures; it can't be run
   until after the first pass */
static void gameinit(void)
{
  long i;

  if (implicit_two_cycle) TWO_CYCLE=1;

  exitmsg_base=1000;

  if (first_room==0 || first_noun==0 || first_creat==0) { /* Using labels */

    if (verflag==v_default) {
      if (PURE_ROOMTITLE==2) 
	PURE_ROOMTITLE=0;
      if (box_title==2)
	box_title=1;
      aver=AGTMAST;
    }

    if (first_room==0x7FFF) {first_room=0;maxroom=-1;}
    if (first_noun==0x7FFF) {first_noun=0;maxnoun=-1;}    
    if (first_creat==0x7FFF) {first_creat=0;maxcreat=-1;}
 
    if (first_room!=0 || first_noun!=0 || first_creat!=0) {
      reporterror(1,E_FATAL,"Labels and numbers both used for objects.",NULL);
      exit(EXIT_FAILURE);
    }
 
    /* Use Master's Edition labeling if possible */
    if ( (maxroom<300-2) && (maxnoun<500-300) 
	 && (maxcreat<1000-500)) {
      first_room=2;
      first_noun=300;
      first_creat=500;
      maxroom+=first_room;
      maxnoun+=first_noun;
      maxcreat+=first_creat;
    } else {
      if (verflag==v_master)
      	reporterror(1,E_WARN,"Too many objects for Master's Edition.",NULL);
      if (maxroom<998)   /* Must avoid 1000 */
	first_room=2;
      else 
	first_room=1001;
      maxroom+=first_room;
      first_noun=maxroom+1; 
      if (first_noun<=1000 && first_noun+maxnoun>=1000) 
	first_noun=1001;
      maxnoun+=first_noun;
      first_creat=maxnoun+1;
      if (first_creat<=1000 && first_creat+maxcreat>=1000) 
	first_creat=1001;
      maxcreat+=first_creat;
    }
    last_obj=maxcreat;
    
    /* Need to patch object synbol entries now */
    update_symtable();

  } else { /* Using numbers for objects */
    int nextstart;

    /* First deal with cases when there aren't *any* objects in a give
       category */
    if (first_room==0x7FFF) {
      first_room=2;maxroom=1;nextstart=3;
    } else nextstart=maxroom+1;
    if (nextstart==1000) nextstart++;
    if (first_noun==0x7FFF) {
      first_noun=nextstart;maxnoun=first_noun-1;}
    else nextstart=maxnoun+1;
    if (first_creat==0x7FFF) { 
      first_creat=nextstart;maxcreat=first_creat-1;}

    /* Now do error checking */
    if (first_room<=1) 
      reporterror(1,E_ERR,"Found room number smaller than 2.",NULL);
    if (first_noun<=2) 
      reporterror(1,E_ERR,"Found noun number less than 3.",NULL);
    if (first_creat<=2)
      reporterror(1,E_ERR,"Found creature number less than 3.",NULL);
    if (first_noun<=maxroom)
      reporterror(1,E_ERR,"All room numbers must be smaller than all"
		  " noun numbers.",NULL);
    if (first_creat<=maxnoun)
      reporterror(1,E_ERR,"All noun numbers must be smaller than all"
		  " creature numbers.",NULL);
    if ((first_room<=1000 && maxroom>=1000))
      reporterror(1,E_ERR,"Room range may not contain 1000.",NULL);
    if ((first_noun<=1000 && maxnoun>=1000))
      reporterror(1,E_ERR,"Noun range may not contain 1000.",NULL);
    if ((first_creat<=1000 && maxcreat>=1000))

      reporterror(1,E_ERR,"Creature range may not contain 1000.",NULL);

    /* Finally, if VERSION undeclared, set a few defaults for Classic */
    if (verflag==v_default) {
      if (PURE_ROOMTITLE==2) 
	PURE_ROOMTITLE=1;
      if (box_title==2)
	box_title=0;
      aver=AGT135;
    }
  }

  if (maxroom>1000) {
    exitmsg_base=maxroom+1;
    reporterror(1,E_NOTE,"More than 998 rooms; "
		"base for illegal direction messages shifted.",NULL);
  } 
  while ( (long)exitmsg_base+(long)last_message>=0x8000L ) 
    if (exitmsg_base>maxroom+1) exitmsg_base=maxroom+1;
    else {
      reporterror(1,E_FATAL,"Too many rooms and messages.",NULL);
    }
  

  writeln("");writeln("");
  rprintf("First Pass completed; ranges assigned:\n");
  rprintf("  Rooms:    %3d..%3d (%3d)\n",first_room,maxroom,
	 maxroom-first_room+1);
  rprintf("  Nouns:    %3d..%3d (%3d)\n",first_noun,maxnoun,
	 maxnoun-first_noun+1);
  rprintf("  Creatures:%3d..%3d (%3d)\n",first_creat,maxcreat,
	 maxcreat-first_creat+1);
  rprintf("\n");

  make_special_labels();
  if (sym_dumpflag) dump_symbol();

  ss_size+=1;
  static_str=rmalloc(ss_size);
  static_str[0]=0; /* So we can get an empty string
		      by just pointing at static_str */
  ss_end=1;

  quest_ptr=init_dp(MaxQuestion);
  ans_ptr=init_dp(MaxQuestion);

  msg_ptr=init_dp(last_message);
  err_ptr=init_dp(NUM_ERR);

  if (maxroom>=first_room) {
    init_room(maxroom-first_room+1);
    room_ptr=init_dp(maxroom-first_room+1);
    help_ptr=init_dp(maxroom-first_room+1);
    special_ptr=init_dp(maxroom-first_room+1);
  }
    
  if (maxnoun>=first_noun) {
    noun_ptr=init_dp(maxnoun-first_noun+1);
    push_ptr=init_dp(maxnoun-first_noun+1);
    pull_ptr=init_dp(maxnoun-first_noun+1);
    text_ptr=init_dp(maxnoun-first_noun+1);
    turn_ptr=init_dp(maxnoun-first_noun+1);
    play_ptr=init_dp(maxnoun-first_noun+1);
  }

  if (maxcreat>=first_creat) {
    creat_ptr=init_dp(maxcreat-first_creat+1);
    ask_ptr=init_dp(maxcreat-first_creat+1);
    talk_ptr=init_dp(maxcreat-first_creat+1);
  }

  userstr=rmalloc(MAX_USTR*sizeof(tline));
  for(i=0;i<MAX_USTR;i++)
    userstr[i][0]=0;
  command=rmalloc(sizeof(cmd_rec)*last_cmd);
  cmd_ptr=0;

  pictlist=rmalloc(maxpict*sizeof(filename*));
  pixlist=rmalloc(maxpix*sizeof(filename*));
  fontlist=rmalloc(maxfont*sizeof(filename*));
  songlist=rmalloc(maxsong*sizeof(filename*));

  propstr=rmalloc(sizeof(char*)*propstr_size);
  prop_ptr=0;
  
  set_userattr_defaults();
}

/* This reads in INS, VOC, and TTL, if neccessary */
static void read_auxfile(fc_type fc)
{
  descr_line *txt;

  if (ins_ptr.size==0) { 
    txt=read_ins(fc);
    if (txt!=NULL) {
      put_descr(&ins_ptr,txt);
      free_ins(txt);
    }
  }
  if (title_ptr.size==0) {
    txt=read_ttl(fc);
    if (txt!=NULL) {
      put_descr(&title_ptr,txt);
      free_descr(txt);
    }
  }
  if (verbinfo==NULL) 
    read_voc(fc);
}


static void finish_game(void)
{
  int i;
  rbool used;

  rfree(csyntbl); /* Free up our copy of the syntbl */

  if (box_title==2) {
    box_title=0;
  }

  if (verbinfo!=NULL)
    finish_verbrec(); /* This needs to be called AFTER read_auxfile */

  /* Make sure mandatory blocks exist */
  assert(ss_end==ss_size);
  if (ss_size==0) {  /* Just in case */
    static_str=rrealloc(static_str,1);
    static_str[0]=0;
    ss_end=ss_size=1;
  }
  
  /* Make sure all static strings are initialized */
  /* Also clean up classes, getting rid of sign information 
     (since we don't need to know which objects are classes anymore)
     and convert 1s to 0s. */
  for(i=0;i<maxroom-first_room+1;i++) {
    if (room[i].name==NULL) room[i].name=static_str;
    room[i].oclass=abs(room[i].oclass);
    if (room[i].oclass==1) room[i].oclass=0;
  }
  for(i=0;i<maxnoun-first_noun+1;i++) {
        if (noun[i].shortdesc==NULL) noun[i].shortdesc=static_str;
	if (noun[i].position==NULL) noun[i].position=static_str;
	noun[i].oclass=abs(noun[i].oclass);
	if (noun[i].oclass==1) noun[i].oclass=0;
  }
  for(i=0;i<maxcreat-first_creat+1;i++) {
        if (creature[i].shortdesc==NULL)
	  creature[i].shortdesc=static_str;
	creature[i].oclass=abs(creature[i].oclass);
	if (creature[i].oclass==1) creature[i].oclass=0;
  }

  /* Check to see of flagtable, vartable are being used */
  /*  If not, get rid of them */
  used=0;
  if (vartable)
    for(i=0;i<=VAR_NUM && !used;i++)
      if (vartable[i].str_cnt>0) used=1;
  if (flagtable)
    for(i=0;i<=FLAG_NUM && !used;i++)
      if (flagtable[i].ystr!=NULL 
	  || flagtable[i].nstr!=NULL) used=1;    
  if (!used) {
    /* Free them and set them to NULL */
    rfree(vartable); 
    rfree(flagtable);
  }

  /* Make sure starting room is legal */
  if (start_room<first_room || start_room>maxroom) {
    start_room=first_room;
    if (maxroom>=start_room) 
      reporterror(2,E_WARN,
		  "Invalid value for STARTING_ROOM; set to first room.",
		  NULL);
  }

  /* If resurrection room not set, make it equal to starting room */
  if (resurrect_room==1000) resurrect_room=start_room;


  /* Compute maxscore if it hasn't been set explicitly */
  if (max_score==0) {
    for(i=0;i<maxroom-first_room+1;i++)
      max_score+=room[i].points;
    for(i=0;i<maxnoun-first_noun+1;i++)
      max_score+=noun[i].points;
    for(i=0;i<maxcreat-first_creat+1;i++)
      max_score+=creature[i].points;
  }

  /* Normalize game_sig */
  while(game_sig<0) game_sig+=0x10000;
  game_sig=game_sig&0xFFFF;

  /* Make sure that have_meta is set correctly */
  if (last_cmd>0) 
    have_meta=1;
  else have_meta=0;

  fix_comblist(); /* Set-up comblist from verb synonyms */

  /* Complain about unused objects */
  verify_label_use();

  /* Sort metacommands for faster execution */
  no_auxsyn=1; /* Indicate we don't have auxsyn set up, at least no
		  as usual (since we've moved it from syntbl to csyntlb) */
  sort_cmd();

  writeln("");
  rprintf("Compilation Complete.\n");
  rprintf("\tNotes:   %3d\n",e_cnt[E_NOTE]);
  rprintf("\tWarnings:%3d\n",e_cnt[E_WARN]);
  rprintf("\tErrors:  %3d\n",e_cnt[E_ERR]);
  /* Fatal errors will always be 0, since they halt compilation before
     reaching this point */
  rprintf("\n");
}




void compile_game(fc_type fc, fc_type fc_out) 
{
  pass=1;
  init();
  opened_agx=0;

  rprintf("First pass: Building symbol table and dictionary...\n");
  opensrc(fc);
  p_game();
  gameinit();

  rprintf("Second pass: Compiling game...\n");
  pass=2;
  if (e_cnt[E_ERR]+e_cnt[E_FATAL]==0) {
    agx_create(fc_out); 
    opened_agx=1;
  }
  opensrc(fc);
  p_game();
  read_auxfile(fc);

  rprintf("Finishing up...\n");
  finish_game();
  if (e_cnt[E_ERR]+e_cnt[E_FATAL]==0) {
    rprintf("Writing game data file...");
    agx_write(); 
    agx_wclose();
    rprintf("done.\n");
  } else {
    if (opened_agx)
      agx_wabort();
    rprintf("Errors found; no game file created.\n");
  }
  writeln("");
}



/* ------------------------------------------------------------------- */



void set_defaults(void)
{

  init_flags();

  sym_dumpflag=0;
  REPORT_COLLISION=0;
  label_whitespace=0;
  label_case=1;
  err_to_stdout=1;

  no_auxsyn=1;
  fix_ascii_flag=0;  /* We don't want to translate the character
			set when we're converting files */
  debug_mode=1;

  /* Mark all of the purity settings as "undecided" */
  PURE_ANSWER=PURE_TIME=PURE_ROOMTITLE=2;
  PURE_AND=PURE_METAVERB=PURE_SYN=PURE_NOUN=PURE_ADJ=2;
  PURE_DUMMY=PURE_SUBNAME=PURE_PROSUB=PURE_HOSTILE=2;
  PURE_GETHOSTILE=PURE_DISAMBIG=PURE_ALL=2;
  PURE_GRAMMAR=2;
  irun_mode=verboseflag=2;
}



/* #options, standard, vocabulary, colors */

