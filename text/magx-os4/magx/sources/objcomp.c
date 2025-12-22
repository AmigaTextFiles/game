/* objcomp.c: Compile room, noun, and creature definitions */
/*  This also contains some os-dependent things           */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */


#include <assert.h>
#include <ctype.h>
#include <stddef.h>

#include "agility.h"
#include "comp.h"



/* This is used for NOUNs and CREATUREs declaring themselves
   to be flag nouns */
static int p_flagnum(void)
{
  int n;

  if (pass==1) return 0;  /* This is to save time */
  n=p_dyndeclare(AGT_ROOMFLAG);
  if (n>=0 && n<=MAX_FLAG_NOUN) return n;
  else {
    reporterror(2,E_ERR,"FLAG value out of range.",NULL);
    return 0;
  }
}



/* ------------------------------------------------------------------- */
/*  Setting and clearing attributes for ROOMs, NOUNs, and CREATUREs.   */
/* ------------------------------------------------------------------- */

typedef struct {
	key_type keyyes, keyno; /* Keywords to turn it off and on. */
	rbool default_val;
	size_t offset;
} attr_map;


static void set_attr(void *obj, size_t offset, rbool val)
{
  *(rbool*)((char*)obj+offset)=val;
}

/* Return true if keyword matched one of the entries in attrlist. */
/* (In which case we will have set or cleared the relevant byte in *obj) */
/* The attrlist end is marked by IllKey */
static rbool scan_attr(key_type keyword, attr_map *attrlist, void *obj)
{
  while (attrlist->keyyes!=IllKey) { /* IllKey marks the end of the list */
    if (keyword==attrlist->keyyes) 
      {set_attr(obj,attrlist->offset,1);return 1;}
    else if (keyword==attrlist->keyno)
      {set_attr(obj,attrlist->offset,0);return 1;}
    attrlist++;
  }
  return 0;
}

static void set_default_attr(attr_map *attrlist, void *obj)
{
  while(attrlist->keyyes!=IllKey) {
    set_attr(obj,attrlist->offset,attrlist->default_val);
    attrlist++;
  }
}





/* ------------------------------------------------------------------- */
/*  Parsing of objects: ROOM, NOUN, CREATURE                           */
/* ------------------------------------------------------------------- */

/* These hold the default values of the records */
static room_rec default_room;
static noun_rec default_noun;
static creat_rec default_creat;

/* Default objprops and objflags */
static long *default_objprop, *def0_objprop;
static uchar *default_objflag, *def0_objflag;

typedef struct {
  void* const def;
  void* const def0; /* Defaults */
  integer* const first;
  const size_t size;
} objtypeinfo;

static const objtypeinfo typedata[]={
  {(void*)&default_room,(void*)&default0_room,&first_room,sizeof(room_rec)},
  {(void*)&default_noun,(void*)&default0_noun,&first_noun,sizeof(noun_rec)},
  {(void*)&default_creat,(void*)&default0_creat,&first_creat,
   sizeof(creat_rec)}};


static void setrecord(void *rref,int tindex, void *rval)
{
  switch(tindex) 
    {
    case 0: *(room_rec**)rref=(room_rec*)rval; break;
    case 1: *(noun_rec**)rref=(noun_rec*)rval; break;
    case 2: *(creat_rec**)rref=(creat_rec*)rval; break;
  }
}


/* Set user-defined flags and properties to point at the right
   place.  
   curr=an object number, or -1 for default, or -2 for "def0" default */
/* tindex= 0 for room, 1 for noun, 2 for creature */
   
static void setoattr(uchar **oflag, long **oprop, int tindex, int curr)
{
  int fbase,pbase, n;
  
  fbase=pbase=0;
  if (tindex>0) {
    if (curr>=0) n=maxroom-first_room+1; else n=1;
    fbase+=num_rflags*n;
    pbase+=num_rprops*n;
  }
  if (tindex>1) {
    if (curr>=0) n=maxnoun-first_noun+1; else n=1;
    fbase+=num_nflags*n;
    pbase+=num_nprops*n;
  }
  if (curr==-2) {
    *oflag=def0_objflag; *oprop=def0_objprop;
  } else if (curr==-1) {
    *oflag=default_objflag; *oprop=default_objprop;
  } else switch (tindex) 
    {
    case 0: 
      *oflag=objflag+(curr-first_room)*num_rflags;
      *oprop=objprop+(curr-first_room)*num_rprops;
      break;
    case 1: 
      *oflag=objflag+(curr-first_noun)*num_nflags;
      *oprop=objprop+(curr-first_noun)*num_nprops;
      break;
    case 2: 
      *oflag=objflag+(curr-first_creat)*num_cflags;
      *oprop=objprop+(curr-first_creat)*num_cprops;
      break;
    }
  *oflag+=fbase;
  *oprop+=pbase;
}


/* This computes the address of the curr'th element of the 
   array by hand */
static rbool setref(void *rref,int tindex,int curr)
{
  curr-=*(typedata[tindex].first);
  if (curr<0) {
    setrecord(rref,tindex,NULL);
    return 0;
  }
  if (pass==1 && tindex==0) {
    setrecord(rref,tindex,NULL);
    return 1;
  }
  switch(tindex)
    {
    case 0: *(room_rec**)rref=&room[curr];break;
    case 1: *(noun_rec**)rref=&noun[curr]; break;
    case 2: *(creat_rec**)rref=&creature[curr]; break;
    }
  return 1;
}
  

/* This sets cobj and defrec and returns the "LIKE" class */
/* If this is declared to be of type CLASS, then the LIKE class is
   inverted (converted to -1 if zero). */
/* cobj may be set to NULL (if the label is bad) but defrec will
   also be set to something valid, even if only the last default. */
/* oflag/oprop are the pointers to this objects user-defined attribute
   blocks;  doflag and doprop are the corresponding default pointers. */
/* *ris_a is set true if we are dealing with an IS-A construction */
static int p_objdeclare(int otype,void *rcobj,void *rdefrec, 
			uchar **oflag, long **oprop,
			uchar **doflag, long **doprop,
			rbool *ris_a)
{
  int tindex; /* Type index, 0, 1, or 2. */
  int curr;
  rbool isclass; /* Is there a CLASS declaration? */

  tindex=0;

  switch(otype)
    {
    case AGT_ROOM:tindex=0;break;
    case AGT_ITEM:tindex=1;break;
    case AGT_CREAT:tindex=2;break;
    default: fatal("INTERNAL ERROR: Invalid otype in p_objdeclare().");
    }

  p_space();

  isclass=0;
  *ris_a=0;
  if (strncasecmp(lineptr,"default",7)==0) {
    setrecord(rcobj,tindex,typedata[tindex].def);
    setoattr(oflag,oprop,tindex,-1);
    lineptr+=7;
  } else {
    if (strncasecmp(lineptr,"class",5)==0) {
      /* Mark this as a class somehow */
      isclass=1;
      lineptr+=5;
    }
    curr=p_declare(otype);
    setref(rcobj,tindex,curr); /* i.e. "array[curr]" */
    setoattr(oflag,oprop,tindex,curr);
  }

  if (pass==1) return (isclass?-1:1);

  p_space();
  if (strncasecmp(lineptr,"like",4)==0 
      || strncasecmp(lineptr,"is-a",4)==0) {    
    *ris_a=(lineptr[0]=='i' || lineptr[0]=='I');
    lineptr+=4;
    curr=p_prop(otype,*ris_a ? "is-a" : "like");
    if (setref(rdefrec,tindex,curr)) {
      setoattr(doflag,doprop,tindex,curr);
    } else {  /* Failed to set reference; falll back to normal default */
      setrecord(rdefrec,tindex,typedata[tindex].def);
      setoattr(doflag,doprop,tindex,-1);
      return (isclass?-1:1);
    }    
    return (isclass?-curr:curr);  /* So caller can deal with classes */
  } else if (strncasecmp(lineptr,"clear",5)==0) {
    setrecord(rdefrec,tindex,typedata[tindex].def0); /* Use original default */
    setoattr(oflag,oprop,tindex,-2);
  } else { /* Use normal default */
    setrecord(rdefrec,tindex,typedata[tindex].def);
    setoattr(doflag,doprop,tindex,-1);
  }
  
  return (isclass?-1:1);
}


/* This function exists solely to print out a warning
   if the last "non-keyword" line of a room/noun/creature defintion
   looks like it has a keyword (indicating that a line might have
   been forgotten). */
void check_for_key(int otype)
{
  int key;
  rbool iskey;

  key=p_key();
  if (key==IllKey) return;
  iskey=0;
  if (otype==AGT_ROOM)
    if ( (key>=kNorth && key<=kAutoexec) || key==kSpecial || key==kClass
	 || key==kRem) iskey=1;
  if (otype==AGT_ITEM)
    if ( (key>=kLocation && key<=kClass) || key==kKey || key==kInitial
	 || key==kScore || key==kPoints || key==kGameWin || key==kRem
	 || key==kPicture) iskey=1;
  if (otype==AGT_CREAT)
    if ( (key>=kWeapon && key<=kFemale) || key==kInitial
	 || key==kScore || key==kPoints ||  key==kRem 
	 || key==kNounSynonym || key==kNounSynonyms || key==kLocation
	 || key==kPicture || key==kClass) iskey=1;

  if (iskey) {   /* Issue warning message */
    if (otype==AGT_ROOM) {
#if 0
      reporterror(1,E_NOTE,"Suspicious room name.",NULL);
#endif
    } else
      reporterror(1,E_NOTE,"Suspicious short description.",NULL);
  }
}



/* This handles flag nouns and room pix flags */
static void p_roomflag(int32 *nounflag, int32 *pixflag)
{
  int fnum;
  char *oldptr;

  oldptr=NULL;
  p_skipjunk(1,1);
  while(*lineptr!=0) {
    oldptr=lineptr;
    fnum=p_label(nounflag==NULL ? AGT_PIX : AGT_GENFLAG)-1; 
        /* Room pix flags have 32 added */
    if (nounflag==NULL) fnum+=32;
    if (fnum<64 && fnum>=0) {
      if (fnum>=32)  /* PIX */
	*pixflag|=1L<<(fnum-32);
      else if (nounflag!=NULL) 
	*nounflag|=1L<<fnum;
    }
    if (oldptr==lineptr) 
      p_skiplabel();
    p_skipjunk(1,1);
  }
}


static void copy_room(room_rec *dest, uchar *dflag, long *dprop,
		      room_rec *src, uchar *sflag, long *sprop)
{
  memcpy(dest,src,sizeof(room_rec));
  memcpy(dflag,sflag,sizeof(uchar)*num_rflags);
  memcpy(dprop,sprop,sizeof(long)*num_rprops);
}


attr_map am_room[]={
  {kGameEnd,kNotGameEnd,0,offsetof(room_rec,end)},
  {kGameWin,kNotGameWin,0,offsetof(room_rec,win)},
  {kKillplayer,kNotKillplayer,0,offsetof(room_rec,killplayer)},
  {kPlayerDead,kNotPlayerDead,0,offsetof(room_rec,killplayer)},
  {IllKey,0,0,0}};

/* room/noun/creature data structures are all initialized *before* the
   beginning of pass 2, so we can skip it here */

/* Note: Unlike nouns and creatures, we shouldn't set any of the
   fields of room[] on the first pass; they won't be preserved in
   general and might end up associated w/ a different room if 
   first_room changes. */
void p_room(void) 
{
  key_type kword;
  int likeobj;
  char *s;
  room_rec *croom, *defroom; /* Current room and 'default' room */
  uchar *rflag, *drflag; /* Pointers to the room flag and property fields */
  long *rprop, *drprop;  /* The d... versions are defaults */
  rbool is_a;

  if (PDEBUG) rprintf("**>Room");
  likeobj=p_objdeclare(AGT_ROOM,(void*)&croom,(void*)&defroom,
		       &rflag,&rprop,&drflag,&drprop,&is_a);

  if (pass==2 && croom!=NULL) {
    if (croom->name!=NULL) 
      reporterror(2,E_ERR,"Duplicate ROOM definition.",NULL);
    else 
      copy_room(croom,rflag,rprop,defroom,drflag,drprop);

    if (abs(likeobj)>1) {
      if (defroom->name==NULL)
	reporterror(2,E_ERR,"%s may only reference previous objects.",
		    is_a?"IS-A":"LIKE");
      else if (defroom->oclass<0 || is_a) 
	/* I.e. LIKE refers to a class, or we have an IS-A construction */
	croom->oclass=likeobj;
      else if (likeobj<0)
	croom->oclass=-defroom->oclass;
    }
  }

  if (croom!=&default_room) {
      /* i.e. not creating a DEFAULT and not an invalid label */

    if (!nextline(1,"room")) {
      reporterror(1,E_ERR,"Empty room description.",NULL);
      return;}

    s=new_string(line); /* We need to call new_string on both passes */
    if (pass==1)
      check_for_key(AGT_ROOM);
    if (pass==2 && croom!=NULL) {
      croom->name=s;     /* Add next line as string */
      croom->unused=0;   /* Mark this room as used. */
    }
  }

  for(;;) {
    if (!nextline(0,"room")) return;
    if (p_objattr(0,rflag,rprop,0)) continue;
    kword=p_key();      
    if (pass==1 || croom==NULL) {
      if (kword==kInitial)  p_genmsg("initial"); /* Skip over it */
      continue;
    }
    if (scan_attr(kword, am_room, croom)) continue;
    switch(kword) 
      {
      case kNorth: case kSouth: case kEast: case kWest:
      case kNortheast: case kNorthwest: case kSoutheast: case kSouthwest:
      case kUp: case kDown: case kEnter: case kExit:
	croom->path[kword-kNorth]=p_exit(keyword_list[kword]);
	break;
      case kN: case kS: case kE: case kW: case kU: case kD:
      case kNE: case kNW: case kSE: case kSW: case kIn: case kOut:
	croom->path[kword-kN]=p_exit(keyword_list[kword]);
	break;
      case kSpecial: 
	croom->path[12]=p_exit("special");
	break;
      case kClass:
	croom->oclass=p_prop(AGT_NONE|AGT_ROOM,"class");
	break;
      case kInitial:
	croom->initdesc=p_genmsg("initial");
	break;
      case kRem: continue;  /* The unofficial AGT comment statement */
      case kNot: p_objattr(0,rflag,rprop,1); break;
      case kKey:
	croom->key=p_prop(AGT_ITEM|AGT_CREAT|AGT_NONE,"key");
	break;
      case kLight:
	  croom->light=p_prop(AGT_ITEM|AGT_CREAT|AGT_NONE|AGT_SELF,
				  "light");
	  break;
      case kLockedDoor:
	if (verflag==v_agx)
	  reporterror(2,E_WARN,
		 "LOCKED_DOOR option is ignored for VERSION MAGX.",NULL);
	else croom->locked_door=1;
	break;
      case kScore:
      case kPoints:croom->points=p_prop(AGT_NUM,"points");break;
      case kAutoexec: croom->autoverb=p_dictline();
	if (croom->autoverb==0) 
	  reporterror(2,E_ERR,"Expected verb, found nothing.",NULL);
	if (croom->autoverb>0 && !lookup_verb(croom->autoverb,0,0)) 
	  reporterror(2,E_ERR,"Expected verb, found '%s'.",
		      dict[croom->autoverb]);
	break;
      case kPicture:croom->pict=p_prop(AGT_PIC,"picture");break;
      case kPix: p_roomflag(NULL, &croom->PIX_bits); break;
      case kFlags: 
	  p_roomflag(&croom->flag_noun_bits, 
		      &croom->PIX_bits);
	break;
      case kRoomSynonym:
      case kRoomSynonyms: {
	int vb;
	croom->replace_word=p_dict();
	vb=lookup_verb(croom->replace_word,0,0);
	if (vb<=0) 
	  reporterror(2,E_ERR,"Invalid initial verb in ROOM_SYNONYM.",NULL);
	croom->replacing_word=p_syns();
	break;
      }
      /* case kEOL: continue;*/ /* Skip blank lines */
      case IllKey:reporterror(2,E_WARN,"Unrecognized keyword.",NULL);break;
      default:reporterror(2,E_WARN,"Invalid keyword in ROOM structure.",NULL);
	break;
      }      
  }
}


/* This is careful to preserve the fields that are set in the first
   pass. */
static void copy_noun(noun_rec *dest, uchar *dflag, long *dprop,
		      noun_rec *src, uchar *sflag, long *sprop)
{
  word name, adj;
  slist syns;

  if (src==NULL) return;
  name=dest->name; adj=dest->adj; syns=dest->syns;
  memcpy(dest,src,sizeof(noun_rec));
  dest->name=name; dest->adj=adj; dest->syns=syns;
  memcpy(dflag,sflag,sizeof(uchar)*num_nflags);
  memcpy(dprop,sprop,sizeof(long)*num_nprops);
}

attr_map am_noun[]={
  {kMovable,kUnmovable,1,offsetof(noun_rec,movable)},
  {kMoveable,kUnmoveable,1,offsetof(noun_rec,movable)},
  {kReadable,kUnreadable,0,offsetof(noun_rec,readable)},
  {kCloseable,kUncloseable,0,offsetof(noun_rec,closable)},
  {kClosable,kUnclosable,0,offsetof(noun_rec,closable)},
  {kOpenable, kUnopenable,0,offsetof(noun_rec,closable)},
  {kOpen,kClosed,0,offsetof(noun_rec,open)},
  {kLockable,kUnlockable,0,offsetof(noun_rec,lockable)},  
  {kLocked,kUnlocked,0,offsetof(noun_rec,locked)},
  {kEdible,kInedible,0,offsetof(noun_rec,edible)},
  {kDrinkable,kUndrinkable,0,offsetof(noun_rec,drinkable)},
  {kPoisonous,kNonpoisonous,0,offsetof(noun_rec,poisonous)},
  {kOn,kOff,0,offsetof(noun_rec,on)},
  {kPushable,kNotPushable,0,offsetof(noun_rec,pushable)},
  {kPullable,kNotPullable,0,offsetof(noun_rec,pullable)},
  {kPlayable,kNotPlayable,0,offsetof(noun_rec,playable)},
  {kTurnable,kNotTurnable,0,offsetof(noun_rec,turnable)},
  {kIsLight,kNotIsLight,0,offsetof(noun_rec,light)},
  {kGameWin,kNotGameWin,0,offsetof(noun_rec,win)},
  {kCanShoot,kNotCanShoot,0,offsetof(noun_rec,shootable)},
  {kWearable,kUnwearable,0,offsetof(noun_rec,wearable)},
  {kPlural,kSingular,0,offsetof(noun_rec,plural)},
  {kProper,kNotProper,0,offsetof(noun_rec,proper)},
  {IllKey,0,0,0}};


void p_noun(void) 
{
  char *s;
  char *savename;
  key_type kword;
  noun_rec *cnoun, *defnoun;
  int likeobj;
  uchar *nflag, *dnflag; /* Pointers to the room flag and property fields */
  long *nprop, *dnprop; /*  The d... fields are defaults */
  rbool is_a;

  savename=NULL;

  if (PDEBUG) rprintf("**>Noun");
  likeobj=p_objdeclare(AGT_ITEM,(void*)&cnoun,(void*)&defnoun,
		       &nflag,&nprop,&dnflag,&dnprop,&is_a);

  if (pass==2 && cnoun!=NULL) {
    if (cnoun->shortdesc!=NULL)
      reporterror(2,E_ERR,"Duplicate NOUN definition.",NULL);
    else
      copy_noun(cnoun,nflag,nprop,defnoun,dnflag,dnprop);

    if (abs(likeobj)>1) {
      if (defnoun->shortdesc==NULL)
	reporterror(2,E_ERR,"LIKE may only reference previous objects.",NULL);
      else if (defnoun->oclass<0 || is_a)	
	/* I.e. LIKE refers to a class, or we have an IS-A construction */
	cnoun->oclass=likeobj;
      else if (likeobj<0)  /*  This object is a class; mark it so. */
	cnoun->oclass=-defnoun->oclass;
    } else
      cnoun->oclass=likeobj;
  }

  if (cnoun!=&default_noun && cnoun!=NULL) {
    cnoun->unused=0;
    if (!nextline(2,"noun")) {
      reporterror(1,E_ERR,"Empty noun description.",NULL);
      return;}
    if (pass==1) {
      savename=rstrdup(lineptr);
      cnoun->name=p_dictline();     /* Add next line as string */
    }

    if (!nextline(2,"noun")) {
      reporterror(1,E_ERR,
		  "NOUN missing adjective and short description.",NULL);
      rfree(savename);
      return;
    }
    if (pass==1)
      cnoun->adj=p_dictline();
  
    if (!nextline(1,"noun")) {  /* Short desc is read in raw mode */
      reporterror(1,E_ERR,"NOUN missing short description.",NULL);return;}
    s=new_string(line); /* We need to call new_string on both passes */
    if (pass==1) 
      check_for_key(AGT_ITEM);
    if (pass==2) 
      cnoun->shortdesc=s;     /* Add next line as string */
  }

  for(;;) {
    if (!nextline(0,"noun")) break;
    if (p_objattr(1,nflag,nprop,0)) continue;
    kword=p_key();
    if (cnoun==NULL) {
      if (kword==kInitial) p_genmsg("initial");
      continue;
    }
    if (pass==1) {
      if (kword==kNounSynonyms || kword==kNounSynonym)
	cnoun->syns=p_syns_2(savename,cnoun->name);
      else if (kword==kPosition) {
	p_space();
	new_string(lineptr);
      } else if (kword==kInitial) 
	p_genmsg("initial");
      continue;
    }
    if (scan_attr(kword, am_noun, cnoun)) continue;
    switch(kword) 
      {
      case kLocation:
	cnoun->location=
	  p_prop(AGT_ROOM|AGT_ITEM|AGT_NONE|AGT_CREAT|AGT_WORN|AGT_SELF,
		 "location");
	break;
      case kKey:
	cnoun->key=p_prop(AGT_ITEM|AGT_NONE|AGT_CREAT,"key");
	break;
      case kInitial:
	cnoun->initdesc=p_genmsg("initial");
	break;
      case kClass:
	cnoun->oclass=p_prop(AGT_ITEM|AGT_NONE|AGT_CREAT,"class");
	break;
      case kFlag:
	cnoun->flagnum=p_flagnum();
	break;
      case kSize:cnoun->size=p_option(-1,"size");break;
      case kWeight:cnoun->weight=p_option(-1,"weight");break;
      case kScore:
      case kPoints:cnoun->points=p_option(-1,"points");break;
      case kNumShots:cnoun->num_shots=p_option(-1,"num_shots");break;
      case kGlobal:cnoun->isglobal=1; cnoun->movable=0; break;
      case kNotGlobal:cnoun->isglobal=0;break;
      case kNounSynonym:
      case kNounSynonyms: cnoun->has_syns=1; break; /* Handled above */
      case kRelatedName: cnoun->related_name=p_dictline(); break;
      case kRem: continue;  /* The unofficial AGT comment statement */
      case kNot: p_objattr(1,nflag,nprop,1); break;
      case kPosition: 
	p_space();
	cnoun->position=new_string(lineptr);
	break;
      case kPicture:cnoun->pict=p_prop(AGT_PIC,"picture");break;
	/* case kEOL: continue;*/  /* Skip blank lines */
      case IllKey:reporterror(2,E_WARN,"Unrecognized keyword.",NULL);break;
      default:
	reporterror(2,E_WARN,"Invalid keyword in NOUN structure.",NULL);
      }
  }
  if (cnoun!=NULL && cnoun->syns==0)
    cnoun->syns=default_syns(savename,cnoun->name);
  rfree(savename);
}      


/* This is careful to preserve the fields that are set in the first
   pass. */
static void copy_creat(creat_rec *dest, uchar *dflag, long *dprop,
		      creat_rec *src, uchar *sflag, long *sprop)
{
  word name, adj;
  slist syns;

  if (src==NULL) return;
  name=dest->name; adj=dest->adj; syns=dest->syns;
  memcpy(dest,src,sizeof(creat_rec));
  dest->name=name; dest->adj=adj; dest->syns=syns;
  memcpy(dflag,sflag,sizeof(uchar)*num_cflags);
  memcpy(dprop,sprop,sizeof(long)*num_cprops);
}

attr_map am_creat[]={
  {kHostile,kFriendly,0,offsetof(creat_rec,hostile)},
  {kGroupmember,kNotGroupmember,0,offsetof(creat_rec,groupmemb)},
  {kGlobal,kNotGlobal,0,offsetof(creat_rec,isglobal)},
  {kProper,kNotProper,0,offsetof(creat_rec,proper)},
  {IllKey,0,0,0}};


void p_creat(void)
{
  char *s, *savename;
  key_type kword;
  creat_rec *ccreat, *defcreat;
  int likeobj;
  /* Pointers to the creature's flag and property fields; d... are defaults */
  uchar *cflag, *dcflag; 
  long *cprop, *dcprop; 
  rbool is_a;

  savename=NULL;

  if (PDEBUG) rprintf("**>Creature");
  likeobj=p_objdeclare(AGT_CREAT,(void*)&ccreat,(void*)&defcreat,
		       &cflag,&cprop,&dcflag,&dcprop,&is_a);

  if (pass==2 && ccreat!=NULL) {
    if (ccreat->shortdesc!=NULL)
      reporterror(2,E_ERR,"Duplicate CREATURE definition.",NULL);
    else 
      copy_creat(ccreat,cflag,cprop,defcreat,dcflag,dcprop);      

    if (abs(likeobj)>1) {
      if (defcreat->shortdesc==NULL)
	reporterror(2,E_ERR,"LIKE may only reference previous objects.",NULL);
      else if (defcreat->oclass<0 || is_a) 
	/* I.e. LIKE refers to a class, or we have an IS-A construction */
	ccreat->oclass=likeobj;
      else if (likeobj<0)  /*  This object is a class; mark it so. */
	ccreat->oclass=-defcreat->oclass;
    }
  }

  if (ccreat!=&default_creat && ccreat!=NULL) {
    ccreat->unused=0;
    if (!nextline(2,"creature")) {
      reporterror(1,E_ERR,"Empty creature description.",NULL);
      return;}
    if (pass==1) {
      savename=rstrdup(lineptr);
      ccreat->name=p_dictline();     /* Add next line as string */
    }
    
    if (!nextline(2,"creature")) {
      reporterror(1,E_ERR,"CREATURE missing adjective and short description",
		  NULL);
      rfree(savename);
      return;}
    if (pass==1)
      ccreat->adj=p_dictline();
  
    if (!nextline(1,"creature")) {
      reporterror(1,E_ERR,"CREATURE missing short description",NULL);return;}
    s=new_string(line); /* We need to call new_string on both passes */
    if (pass==1)
      check_for_key(AGT_CREAT);
    if (pass==2) 
      ccreat->shortdesc=s;  /* Add next line as string */
  }


  for(;;) {
    if (!nextline(0,"creature")) break;
    if (p_objattr(2,cflag,cprop,0)) continue;
    kword=p_key();
    if (pass==1) {
      if (kword==kNounSynonyms || kword==kCreatureSynonyms
	  || kword==kNounSynonym || kword==kCreatureSynonym)
	ccreat->syns=p_syns_2(savename,ccreat->name);
      else if (kword==kInitial) 
	p_genmsg("initial");
      continue; 
    }
    if (scan_attr(kword, am_creat, ccreat)) continue;
    switch(kword) 
      {
      case kLocation:
	ccreat->location=
	  p_prop(AGT_ROOM|AGT_ITEM|AGT_NONE|AGT_CREAT|AGT_WORN|AGT_SELF,
		 "location");
	break;
      case kWeapon:
	ccreat->weapon=p_prop(AGT_ITEM|AGT_NONE,"location");break;
      case kClass:
	ccreat->oclass=p_prop(AGT_ITEM|AGT_NONE|AGT_CREAT,"class");
	break;
      case kGender:
	switch(p_key()) 
	  {
	  case kThing: ccreat->gender=0;break;
	  case kFemale:
	  case kWoman: ccreat->gender=1;break;
	  case kMale:
	  case kMan: ccreat->gender=2;break;
	  default:
	    reporterror(2,E_WARN,"Invalid GENDER.",NULL);
	  }
	break;
      case kThing: ccreat->gender=0;break;
      case kFemale:
      case kWoman: ccreat->gender=1;break;
      case kMale:
      case kMan: ccreat->gender=2;break;
      case kInitial:
	ccreat->initdesc=p_genmsg("initial");
	break;
      case kNounSynonym: /* Fall through */
      case kCreatureSynonym:
      case kNounSynonyms:	
      case kCreatureSynonyms: ccreat->has_syns=1; break;
	/* handled above */
      case kThreshhold: 
      case kThreshold:
	ccreat->threshold=p_prop(AGT_NUM,"threshold");
	break;	
      case kTimeThresh: case kTimeThres: case kTimethresh:
	ccreat->timethresh=p_prop(AGT_NUM,"time_thresh");
	break;
      case kScore:
      case kPoints:ccreat->points=p_option(-1,"points");break;
      case kPicture:ccreat->pict=p_prop(AGT_PIC,"picture");break;
      case kFlag:
	ccreat->flagnum=p_flagnum();
	break;
      case kRem: continue;  /* The unofficial AGT comment statement */
      case kNot: p_objattr(2,cflag,cprop,1); break;
      case IllKey:reporterror(2,E_WARN,"Unrecognized keyword.",NULL);break;
	/* case kEOL: continue;*/ /* Skip blank lines */
      default:
	reporterror(2,E_WARN,"Invalid keyword in CREATURE structure.",NULL);
      }
  }
  if (ccreat!=NULL && ccreat->syns==0)
    ccreat->syns=default_syns(savename,ccreat->name);
  rfree(savename);
}



void set_obj_defaults(void)
{
  memcpy(&default_room,&default0_room,sizeof(room_rec));
  memcpy(&default_noun,&default0_noun,sizeof(noun_rec));
  memcpy(&default_creat,&default0_creat,sizeof(creat_rec));
}

void  set_userattr_defaults(void)
{
  int i,n;

  recalc_userattr();
  
  n=objextsize(0);
  objflag=rmalloc( sizeof(char) * n);
  for(i=0;i<n;i++) objflag[i]=0;

  n=num_rflags+num_nflags+num_cflags;
  default_objflag=rmalloc(sizeof(char)*n);
  def0_objflag=rmalloc(sizeof(char)*n);
  for(i=0;i<n;i++) default_objflag[i]=def0_objflag[i]=0;

  n=objextsize(1);
  objprop=rmalloc( sizeof(long) * n);
  for(i=0;i<n;i++) objprop[i]=0;

  n=num_rprops+num_nprops+num_cprops;
  default_objprop=rmalloc( sizeof(long) * n);
  def0_objprop=rmalloc( sizeof(long) * n);
  for(i=0;i<n;i++) default_objprop[i]=def0_objprop[i]=0;
}


void init_room(long numrec)
{
  int i;

  assert(room==NULL);
  room=rmalloc(numrec*sizeof(room_rec));
  for(i=0;i<numrec;i++)
    memcpy(room+i,&default0_room,sizeof(room_rec));
}


/* Since the default records are static variables and since nearly 
   everything is initialized to 0, we could in principal get away
   with not explicitly initializing these; but if this were ever
   compiled on a not-quite-ANSI compiler, the bugs would be very
   hard to track down. */

static void init_def_room(void)
{
  int j;

  default0_room.name=NULL;
  default0_room.contents=0; 
  
  default0_room.flag_noun_bits=default0_room.PIX_bits=0;
  default0_room.replacing_word=0;
  default0_room.replace_word=0;
  default0_room.autoverb=0;
  for(j=0;j<13;j++) 
    default0_room.path[j]=0;
  default0_room.key=0;  
  default0_room.unused=1;
  default0_room.oclass=1; /* This will be cleared to 0 later. */
  default0_room.points=0; default0_room.light=0; 
  default0_room.pict=default0_room.initdesc=0;
  default0_room.seen=default0_room.locked_door=0;

  set_default_attr(am_room,&default0_room);
}

static void init_def_noun(void)
{
  default0_noun.shortdesc=NULL;
  default0_noun.position=NULL;
  default0_noun.contents=default0_noun.next=0;
  
  default0_noun.syns=0;
  default0_noun.name=default0_noun.adj=0;
  default0_noun.pos_prep=default0_noun.pos_name=0;
  default0_noun.nearby_noun=0;
  default0_noun.unused=0;
  default0_noun.num_shots=default0_noun.points=0;
  default0_noun.weight=default0_noun.size=10;
  default0_noun.key=default0_noun.initdesc=default0_noun.pict=0;
  default0_noun.location=0;
  default0_noun.oclass=1; /* This will be cleared to 0 later. */
  default0_noun.something_pos_near_noun=0;  /* Anybody behind us? */
  
  default0_noun.has_syns=0;

  default0_noun.isglobal=0;
  default0_noun.flagnum=0;

  set_default_attr(am_noun,&default0_noun);
}


static void init_def_creat(void)
{
    default0_creat.shortdesc=NULL; /* tline */
    default0_creat.contents=default0_creat.next=0;

    default0_creat.syns=0;
    default0_creat.name=default0_creat.adj=0;
    default0_creat.location=0;
    default0_creat.oclass=1; /* This will be cleared to 0 later. */ 
    default0_creat.weapon=default0_creat.points=0;
    default0_creat.counter=0;
    default0_creat.threshold=3;
    default0_creat.timecounter=0;
    default0_creat.timethresh=-1;
    default0_creat.pict=default0_creat.initdesc=0;
    default0_creat.has_syns=0;
    default0_creat.gender=0;
    default0_creat.flagnum=0;
    default0_creat.unused=0;

    set_default_attr(am_creat,&default0_creat);
}


void init_def_obj(void)
{
  default_objflag=def0_objflag=NULL; 
  default_objprop=def0_objprop=NULL;  
  init_def_room();
  init_def_noun();
  init_def_creat();
}
