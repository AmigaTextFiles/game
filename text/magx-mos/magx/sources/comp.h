/* comp.h:  Header for compiler-specific things           */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

#ifndef global    /* Don't touch this */
#define global extern
#define global_defined_agtread
#endif


#define FILE_DEPTH 6  /* Depth of include etc. files */

#define PDEBUG 0
#define PDEBUG3 0
#define PDEBUG4 1

/* #define DEBUG_ERROR */  
/* Cause error messages to be printed out on both passes */

/* ------------------------------------------------------------------- */

typedef enum {
  /* First a couple of symbols to pass back error conditions */
  kEOL, /* EOL=End of Line */

  /* Now come the top-level keywords */
  kAskDescr, kAnswer, kCommand, kCreature, kCreatureDescr, kCounter,
  kFlag, kFlagNouns, kFonts, kGlobalNouns, kHelp, kAfter,
  kIntro, kIntroduction, kInstructions, kMessage, kNoun, 
  kNounDescr, kPushDescr, kPullDescr, kPlayDescr, kPictures,
  kQuestion, kRoom, kRoomDescr, kSpecial, kSubroutines, kSounds,
  kStrings, kTurnDescr, kText, kTalkDescr, kTitle, kVariable, kVerb,
  kVerbs, kVocabulary,kRem, kPreposition, kPrep,
  kFreeze, kMaxLives, kMaximumScore, kResurrectionRoom, kStartingRoom,
  kScoreOption, kStatusOption, kStartingTime, kDeltaTime,
  kTreasureRoom, kNoDebug, kLongString, kRoomPix, kStandard,
  kSynonyms, kObjflag, kProp,
  /* 1.83 Options */
  kStatusLine, kHours, kMinutes, kAmTime, kPmTime, kMilitaryTime,
  kRandomTime, 
  kIntroFirst, kTitleBox, kNoTitleBox, kVersion, kConfig, kLabel,

  /* Next are ROOM keywords, starting with kNorth and ending with 
     kRoomSynonyms. The directions _must_ be together and in this order */
  kNorth,kSouth,kEast,kWest,kNortheast,kNorthwest,
  kSoutheast,kSouthwest,kUp,kDown,kEnter,kExit,
  kN,kS,kE,kW,kNE,kNW,kSE,kSW,kU,kD,kIn,kOut,
  kGameEnd, kGameWin, kNotGameEnd, kNotGameWin, 
  kKey, kLight, kLockedDoor, kPoints, kScore,
  kPlayerDead, kKillplayer, kNotPlayerDead, kNotKillplayer,
  kPicture, kRoomSynonyms, kRoomSynonym,
  kFlags, kPix, kInitial, kAutoexec, kNot,

  /* Next NOUN keywords: kLocation..kPicture */
  kLocation, kSize, kWeight, kUnmovable, kReadable, kClosable, kOpen,
  kLockable, kLocked, kEdible, kDrinkable, kPoisonous, kOn, kOff, 
  kClosed, kMovable, kUnlocked, kUnlockable, kUnclosable, kUncloseable,
  kPushable, kPullable, kPlayable, kTurnable, kIsLight, kCanShoot, 
  kNumShots, kWearable, kPosition, kSingular, kNounSynonyms, 
  kNounSynonym, kPlural, kRelatedName, kCloseable, kOpenable,
  kUnopenable, kInedible, kUndrinkable, kNonpoisonous, 
  kNotPushable, kNotPlayable, kNotPullable, kNotTurnable,
  kNotIsLight, kNotCanShoot, kMoveable, kUnreadable, kUnwearable, 
  kUnmoveable, kClass, kGlobal, kNotGlobal,

  /* CREATURE keywords */
  kWeapon, kHostile, kFriendly, kThreshold, kThreshhold, kTimeThresh, 
  kTimeThres, kTimethresh, kGroupmember, kNotGroupmember, kGender, 
  kCreatureSynonyms, kCreatureSynonym, kThing, kMan, kWoman,
  kMale, kFemale, kProper, kNotProper,

  /* Preprocessor directives (with the leading '#' removed) */
  kComment, kDefine, kInclude, kOptions,

  IllKey /* Used to return no match */
} key_type;


extern char *keyword_list[]; /* Associate the above with the actual strings. */



/* ------------------------------------------------------------------- */

global int flag_noun_cnt;

global int pass;  /* Which compiler pass are we on? */

global long lineno;  /* Line number, used for printing out error message */

global char *line; /* Pointer to current line of source */
global char *lineptr; /* Pointer into line, up to where we've processed */
global char *litline; /* Literal line, unprocessed */

/* These are used to hold build-in verb synonyms */
global word *csyntbl;  /* Synonym list space */
global slist csynptr; /* Points to end of used space */

extern char start_quote, start_label, end_quote, end_label;

/* Which flavor of AGT are we compiling? */
typedef enum {v_gags, v_class, v_183, v_default, v_master, v_agx} version_id;
global version_id verflag;

global rbool label_whitespace; /* Skip whitespace in labels? */
global rbool label_case;    /* Labels case insensitive? */
global rbool REPORT_COLLISION;

global rbool err_to_stdout; /* Send error messages to stdout instead
			      of stderr */
global rbool supress_err; /* Turn off printing of non-fatal errors */
global int e_cnt[4]; /* Counts each of the four types of error */
global rbool ignore_extra_text; /* Supress "extra text on line" warning */
global rbool strict_type;  /* Strict type checking */

global rbool opened_agx; /* True if we've opened the AGX file */
global rbool sym_dumpflag;

global char fake_space; /* Character to be converted to space in verbs 
			   and prepositions */
global rbool enable_fakespace; /* True if fake_space should be converted.
				 (i.e. in verbs and prepositions) */

global rbool implicit_two_cycle;  
  /* Set true if we are using implicit two-cycle processing,
     in which case the compiler inserts BeforeCommand and AfterCommand
     tokens at the start of metacommands, without the user being
     aware of it. */

global rbool nomatch_active;   /* True if we are using NOMATCH 
				  extension. (Where -1 in command
				  record indicates <NONE>) */


global int prop_ptr; /* Used during second pass; points into the
		      propstr[] array */

/* These hold the base defaults for each type of object. */
global room_rec default0_room;
global noun_rec default0_noun;
global creat_rec default0_creat;

/* ------------------------------------------------------------------- */
#define E_NOTE 0
#define E_WARN 1
#define E_ERR 2
#define E_FATAL 3

/* ------------------------------------------------------------------- */
/* In COMPILE.C                                                        */
/* ------------------------------------------------------------------- */

void compile_game(fc_type fc, fc_type out_fc);

void p_gendescr(descr_ptr *dptr,char *keyword);
int lookup_verb(word w, rbool decl, rbool add_word);
void set_defaults(void);

long p_prop(int dtype, char *field);
long p_option(integer range, char *field);



/* ------------------------------------------------------------------- */
/* In COMMAND.C                                                       */
/* ------------------------------------------------------------------- */
void p_command(rbool is_after); 
void build_ophash(void);
void compiler_ext_dict(void);

/* ------------------------------------------------------------------- */
/* In OBJCOMP.C                                                        */
/* ------------------------------------------------------------------- */
void init_room(long numrec);
void set_obj_defaults(void);
void init_def_obj(void);
void  set_userattr_defaults(void);

void p_room(void);
void p_noun(void);
void p_creat(void);


/* ------------------------------------------------------------------- */
/* In PREPROC.C                                                       */
/* ------------------------------------------------------------------- */

rbool p_descline(descr_ptr *dptr,rbool no_quote);

void opensrc(fc_type fc);
rbool nextline(int raw, const char *sectname); 

rbool blankline(char *s);
void p_space(void); /* Skip over whitespace */
char *skip_space(char *s); /* Skip over whitespace in string, returning 
			      new pointer */

void set_section_class(int n);


/* ------------------------------------------------------------------- */
/* In COMPSTUB.C                                                       */
/* ------------------------------------------------------------------- */

void reporterror(int epass,int elev, const char *fmt, const char *s);

rbool pushfile(fc_type fc, filetype ext);

rbool popfile(void);
/* This automatically frees the associated file context unless
   it is the last entry on the stack. */

int nextchar(void);
void killchar(uchar c);
void markeof(uchar c);

/* ------------------------------------------------------------------- */
/* In SYMBOL.C                                                       */
/* ------------------------------------------------------------------- */

char *new_string(char *s);

word p_dict(void);
word p_dictline(void);

slist p_syns(void);
slist p_syns_2(char *savename,word skipword);
slist default_syns(char *savename,word skipword);

void build_keyhash(void);
key_type p_key(void);
rbool keymatch(const char *key);

void init_userattr(void);
void recalc_userattr(void);
void alloc_userattr(int n,int mask, int t);
rbool p_objattr(int t, uchar *oflag, long *oprop, rbool notflag);

void make_special_labels(void);
void init_symbol(void);
void update_symtable(void);
void dump_symbol(void);
int label_val(char **ptr, int dtype);

void create_flag(int newflag);

long p_label(int dtype);
long p_operand(int dtype, int *optype,int term_type,rbool *builtin_prop);
rbool find_propref(rbool accept_propref);
void set_istr_defaults(void);
long p_declare(int dtype);
void p_declare_seq(int dtype,const char *endname,int mask);
long p_dyndeclare(int dtype);  /* Only used for AGT_ROOMFLAG right now. */

long p_number(void);
integer create_message(descr_ptr *dptr);
void creat_dverb(int newdverb);
void verify_label_use(void);
void p_declaration(void);

char *expand_descr(const char *s);
char *get_define(char *s);
char *expand_line(char *src,int depth);
void p_define(void);
long p_genmsg(char *sectname);

void p_skiplabel(void);
void p_skipjunk(char digitok,int epass);
long p_exit(char *field);

/* Wrapper for write_descr */
void put_descr(descr_ptr *dptr,descr_line *txt);

