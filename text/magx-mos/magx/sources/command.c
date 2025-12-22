/* Command.c:  Routines to compile AGT Metacommands       */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

#define PDEBUG2 0

#include <assert.h>
#include <ctype.h>
#include "agility.h"
#include "comp.h"


typedef enum{wthe,wmy,wa,wan,wthen,wp,wsc,wand,wc,wits,wall,wundo,
	       wpick,wgo,wexits,wtalk,wtake,wdoor,wagain,wbut,wexcept,
	       wscene,weverything,wlistexit,wlistexits,wclose,
	       wdverb,wdnoun,wdadjective,wdprep,wdobject,wdname,
	       wstep,wafter,
	       whe,wshe,wit,wthey,whim,wher,wthem,wis,ware,woops,
	       win,wout,winto,wat,wto,wacross,winside,wwith,wnear,wfor,
	       wof,wbehind,wbeside,won,woff,wunder,wfrom, wthrough,
	       wtoward, wtowards, wbetween, waround, wupon, wthru,
	       wby, wover, wup, wdown,
	       wabout} wtype;
static const char *ext_voc[]={
  "the","my","a","an",  /* These 4 are ignored in canonical AGT */
  "then",".",";","and", "," , "its", "all","undo",
  "pick","go","exits","talk","take","door","again","but","except",
  "scene","everything","listexit","listexits","close",
  "verb","noun","adjective","prep","object","name","step",
  "after",
  "he","she","it","they","him","her","them","is","are","oops",
  /* Everything between 'in' and 'about' should be a preposition */
  "in","out", "into","at","to","across","inside","with","near","for",
  "of","behind", "beside", "on", "off", "under", "from","through",
  "toward", "towards", "between", "around", "upon", "thru", 
  "by", "over", "up", "down", 
  "about"};
/* 'about' must be the last element of this list */

static word ext_code[wabout+1];


#define START_PSUEDO 8000
#define MAX_PSUEDO 8007

/* Here is the opinfo record for the "next" and "prev" psuedo-tokens */
static const opdef psuedo_def[]={
  {"next",1,AGT_NUM,0},
  {"prev",1,AGT_NUM,0},
  {"set",2,AGT_LVAL,AGT_NUM},  /* 8002 */
  {"add",2,AGT_LVAL,AGT_NUM},
  {"subtract",2,AGT_LVAL,AGT_NUM},
  {"multiply",2,AGT_LVAL,AGT_NUM},
  {"divide",2,AGT_LVAL,AGT_NUM},
  {"remainder",2,AGT_LVAL,AGT_NUM}  /* 8007 */
};

/* This the compiler's wrapper around get_opdef, to handle
   psuedo-ops like PREV/NEXT */
static const opdef *magx_get_opdef(integer op)
{
  if (op>=START_PSUEDO && op<=MAX_PSUEDO)
    return &psuedo_def[op-START_PSUEDO];
  return get_opdef(op);		 
}



/* ------------------------------------------------------------------- */
/*  Commands to parse the metacommand headers                          */
/* ------------------------------------------------------------------- */

static rbool is_prep(word w)
{
  int i;
  for(i=0;i<num_prep;i++) 
    if (w==syntbl[userprep[i]]) return 1;
  for(i=win;i<=wabout;i++)
    if (w==ext_code[i]) return 1;
  return 0;
}




void compiler_ext_dict(void)
{
  wtype i;
  for(i=wthe;i<=wabout;i++)
    ext_code[i]=add_dict(ext_voc[i]);
}


/* The next few routines parse the COMMAND header.
   They do essentially the same thing as the game parser (although
   their task is much simplified).  We can't use the game parser
   itself here because we don't have the whole dictionary (and don't
   really want it); this makes the whole process below much more ad
   hoc (and slower) than AGiliTy's command parser. */

static void p_cmdspace(void)
{
  while(isspace(*lineptr)) lineptr++;
}


/* This routine assumes we've already lowercased everything */
rbool noise_word(word w)
{
  if (w==ext_code[wthe] || w==ext_code[wa] || w==ext_code[wan]
      || w==ext_code[wmy]) return 1;
  if (verflag==v_183 && w==ext_code[wis]) return 1;
  return 0;
}

static char *oldword1, *oldword2;

static void pushback_word(char *s)
{
  assert(oldword2==NULL);
  oldword2=oldword1;
  oldword1=s;
}


static char *p_nextword(void)
{
  char *t;

  if (oldword1!=NULL) { /* We've backtracked... */
    t=oldword1;
    oldword1=oldword2;
    oldword2=NULL;
    return t;
  }
  do {
    p_cmdspace();
    t=lineptr;
    for(;*lineptr!=0 && !isspace(*lineptr);lineptr++)
      if (*lineptr==fake_space && enable_fakespace) 
	*lineptr=' ';
      else *lineptr=tolower(*lineptr);
    if(*lineptr!=0) 
      *(lineptr++)=0;
  } while (*t!=0 && noise_word(search_dict(t)));
   if (PDEBUG2) rprintf("[%s] ",t);
  return t;
}


/* Parse SUBROUTINEnn */
static word p_sub_verb(void)
{
  char *s, buff[20];
  int n;
  char c;
  word w;
  char *oldptr;

  s=lineptr+10; 
  if (*s==start_label) {
    oldptr=lineptr;
    lineptr+=10;
    n=label_val(&lineptr,AGT_SUB);
    sprintf(buff,"subroutine%d",n);
    w=search_dict(buff);
    if (w<0) lineptr=oldptr; /* Back up */
    return w; /* If there was an error, scan_label should have caught it */
  } else { /* digit */
    assert(isdigit(*s));
    while(isdigit(*s)) s++;
    c=*s; *s=0;
    w=search_dict(lineptr);
    if (w<=0) 
      reporterror(1,E_ERR,"Invalid subroutine name %s.",lineptr);
    *s=c;
    lineptr=s;
    return w;
  }
}


/* This returns the first object with an adjective match */
/*  (or the first creature if iscreat is set) */
static integer first_adj(word w, rbool iscreat)
{
  int i;
  if (PDEBUG2) rprintf("Scanning %s",dict[w]);
  if (!iscreat) 
    for(i=first_noun;i<=maxnoun;i++)
      if (noun[i-first_noun].adj==w) return i;
  if (PDEBUG2) rprintf("...creatures");
  for(i=first_creat;i<=maxcreat;i++)
    if (creature[i-first_creat].adj==w) return i;
  if (PDEBUG2) rprintf("...fail; ");
  return 0;
}


static rbool synmatch(slist syns, word w)
{
  slist i;
  for(i=syns;syntbl[i]!=0 && syntbl[i]!=w;i++);
  if (PDEBUG2) rprintf("{%s}",dict[syntbl[i]]);
  return(syntbl[i]==w);
}

static rbool adjmatch(word pat, word adj)
{
  if (pat==0) return 1;
  if (pat<0) return (adj!=-pat); 
  return (adj==pat); 
}


#define nmatch(name,w,stage,syns) (stage==0?name==w:synmatch(syns,w))


/* This returns the first object >= adjnum that matches both adj and noun. 
   (if iscreat is set, we return the first creature instead) */
/* If w1 is 0, match anything; if w1 is negative, match anything
   OTHER than -w1. */
integer adjnoun(integer adjnum, word w1, word w2, rbool iscreat)
{
  int i, k;
  
  if (PDEBUG2) rprintf("Scanning %s %s from %d",dict[w1],dict[w2],adjnum);
  for(k=0;k<2;k++) {
    i=adjnum;
    if (i<first_noun) i=first_noun;
    if (!iscreat) 
      for(;i<=maxnoun;i++)
	if (  nmatch(noun[i-first_noun].name,w2,k,noun[i-first_noun].syns)
	      && adjmatch(w1,noun[i-first_noun].adj ))
	  return i;
    if (PDEBUG2) rprintf("...creatures");
    if (i<first_creat) i=first_creat;
    for(;i<=maxcreat;i++) 
      if ( nmatch(creature[i-first_creat].name,w2,k,
		  creature[i-first_creat].syns)
	   && adjmatch(w1,creature[i-first_creat].adj) )
	return i;    
  }
  if (PDEBUG2) rprintf("...fail");
  return 0;  /* Failure */
}


static rbool is_a_number(const char *s)
{
  char *err;

  strtol(s,&err,10);
  return (*err=='\0');
}





/* Objects are allowed to be described by either NOUN or ADJ NOUN */
/* If iscreat is set, we expect an actor; first_obj indicates
   this is the first object in a possible list;
   redir indicates this a RedirectTo line */
/* RETURN: */
/*   Returns 0 for ANY/ANYBODY; returns -1 for error; 
       return 0 or -1 for blank, depending on nomatch settings. */
/*   has_adj is set if the object has an explicit adjective;
       it is also set for explicit objects (see next line) */
/*   explicit_obj is set to 1 if we have an explicit object
       (e.g. [green ball]) rather than an ADJ/NOUN */

static integer p_obj(rbool iscreat, rbool first_obj, rbool redir, 
		     rbool report_error, rbool *has_adj, 
		     rbool *explicit_obj)
{
  char *s;
  word w1, w2;
  int adjnum, nounnum;
  int i;
  rbool w1_is_number;

  if (has_adj!=NULL) *has_adj=0;
  if (explicit_obj!=NULL) *explicit_obj=0;

  s=p_nextword();

  /* ---------  Found Nothing -------------- */
  if (*s==0) {  
    if (iscreat) {
      if (report_error) {
	reporterror(2,E_WARN,"Unexpected comma in COMMAND.",NULL);
	return 1; /* Player: i.e. no actor after all */
      } 
      else {pushback_word(s);return -1;}      
    }
    if (nomatch_active) return -1;
    else return 0; /* ANY */
  } 

  /* ---------  Label (Explicit Object) -------------- */
  if (verflag==v_agx && s[0]==start_label) {  
    /* Explicit object label */
    nounnum=label_val(&s,AGT_ITEM|AGT_CREAT);
    if (explicit_obj!=NULL) *explicit_obj=1;
    if (has_adj!=NULL) *has_adj=1;
    return nounnum;
  }

  /* --------- Redirection '$' code -------------- */
  if (s[0]=='$') { /* Redirection code */
    if (!redir) {
      if (report_error) {
	reporterror(1,E_ERR,"'%s' only allowed in RedirecTo.",s);
	return 0;
      }
      else {pushback_word(s);return -1;}
    }
    s++;
    i=strlen(s);
    if (i==0) {
      if (report_error) {
	reporterror(1,E_ERR,"Expected word after '$'.",NULL);
	return 0;
      } 
      else {pushback_word(s);return -1;}
    }
    i--;
    if (s[i]=='$') s[i]=0;
    w1=search_dict(s);
    if (w1>0) {
      return -w1;
    }
    if (report_error) {
      reporterror(1,E_ERR,"$%s$ not a valid substitution.",s);
      return 0;
    } 
    else {pushback_word(s);return -1;}
  } /* End $ redirect handling */

  /* --------- ANY/ANYBODY ------------------------ */
  if (iscreat && strcmp(s,"anybody")==0) return 0;

  if (strcmp(s,"any")==0) {
    if (iscreat && report_error)
      reporterror(2,E_WARN,"Use of ANY where ANYBODY is expected.",NULL);
    return 0;
  }

  /* --------- Look it up in dictionary  ------------------------ */

  /* For future reference, check to see if s refers to a number */
  w1_is_number=is_a_number(s);

  w1=search_dict(s);


  /* --------- Number ------------------------ */
  if (w1<=0) {
    if (w1_is_number && !iscreat) 
      /* If number, add it to dictionary */
      /* Since it wasn't arleady in dictionary, may as well return it now--
	 it's obviously not going to match any of the objects */
      return -add_dict(s);
    if (first_obj) /* Maybe it's a preposition */
      pushback_word(s);
    else 
      if (report_error)
	reporterror(2,E_ERR,"Unrecognized word '%s'.",s);
      else {pushback_word(s);return -1;}
    return 0;
  }
  
  /* --------- Special words w/o objects ------------------------ */
  if (!iscreat) {
    if (w1==ext_code[wall])   /* Check for ALL */
      return -w1;
    for(i=0;i<numglobal;i++)  /* Scan global nouns */
      if (w1==globalnoun[i]) return -w1;
    for(i=0;i<flag_noun_cnt;i++)  /* Check flag nouns */
      if (w1==flag_noun[i]) return -w1;
    for(i=0;i<maxpix;i++)  /* Check RoomPIXs */
      if (w1==pix_name[i]) return -w1;
    if (w1==ext_code[wdoor] && verflag!=v_agx) return -w1;
  }

  /* --------- Look for object names: Adjectives -------------------- */

  adjnum=first_adj(w1,iscreat); /* Finds first object this word is adjective
			   for, or 0 if none */
  if (PDEBUG2) rprintf("-><%d:%d> ",w1,adjnum);

  if (adjnum!=0) { /* It _can_ be parsed as an adjective */
    s=p_nextword();
    w2=search_dict(s);
    if (w2>0) {  /* Is the second word in the dicitonary... */
      /*   ...and does it fit with the first one? */
      nounnum=adjnoun(adjnum,w1,w2,iscreat);             
      if (nounnum!=0) {
	if (adjnoun(nounnum+1,-w1,w2,iscreat))  /* Ambiguity */
	  if (report_error && verflag!=v_agx)
	    reporterror(2,E_NOTE,"Adjective '%s' will be ignored.",
			dict[w1]);	
	if (has_adj!=NULL) *has_adj=1;
	return nounnum;
      }
    }
    /* No, it doesn't fit with the first word. */
    pushback_word(s);  /* Push it back */
  }

  /* --------- Look for object names: Nouns  -------------------- */

  /* Okay, so w1 isn't an adjective in this case, even if in general it could 
     be; let's try reading it as a noun */ 
  nounnum=adjnoun(0,0,w1,iscreat);
  if (nounnum!=0)  /*okay, we can read it as a noun */
    return nounnum;

  /* Okay, it's neither a noun nor an adjective. Check to see if it
     is perhaps a number */
  if (w1_is_number)
    return -w1;


  /* ---- Failed; check to see if it could be another part of speech ---- */

  /* We have now failed; it isn't describing an object. */
  if (!iscreat && first_obj &&  /* _could_ be a preposition */
      (is_prep(w1)) )
    pushback_word(s);
  else if (!report_error) {
    pushback_word(s);
    return -1;
  } else 
    reporterror(2,E_ERR,"Do not recognize object '%s'.",s);
  return 0;
}



static void p_objname(rbool first_obj, rbool redir, word *adjword, 
		      word *nounword, integer *obj)
{
  integer objnum;
  rbool has_adj;
  rbool explicit_obj;
  
  assert(adjword!=NULL && nounword!=NULL && obj!=NULL);
  *adjword=0; *nounword=0; *obj=0;

  objnum=p_obj(0,first_obj,redir,1,&has_adj,&explicit_obj);

  if (explicit_obj) *obj=objnum;
  /* Even with an explicit object, we continue processing
     to get the appropriate noun and adjective entries */

  if (objnum==-1) {  /* Error or blank */
    if (verflag==v_agx) /* In earlier versions, mark errors by ANY(0) */
      *adjword=*nounword=-1;
    return;
  }
  else if (objnum<0) { /* that is, a bare word w/o an object attached */
    *nounword=-objnum;
    return;
  } else if (objnum==0) {  /* ANY */
    return;
  }
  else if (objnum>=first_noun && objnum<=maxnoun) {
    *nounword=noun[objnum-first_noun].name;
    if (has_adj && verflag==v_agx) 
      *adjword=noun[objnum-first_noun].adj;
    return;
  }
  if (objnum>=first_creat && objnum<=maxcreat) {
    *nounword=creature[objnum-first_creat].name;
    if (has_adj && verflag==v_agx)
      *adjword=creature[objnum-first_creat].adj;
    return;
  }
  rprintf("Internal Error: Invalid object number %d returned from "
	 "Parse Object.\n",objnum);
  rprintf(">>%s\n",litline);
  return;
}


static word p_multiprep(word w)
{
  int i;
  char *s;
  word w2;

  /* Catch user defined prepositions */
  /* Like user-defined multi-verbs, these must uses the
     fake-space character if more than one word. */
  for(i=0;i<num_prep;i++) 
    if (w==syntbl[userprep[i]]) return w;

  if (w==ext_code[win] || w==ext_code[wout]) {
    s=p_nextword();
    w2=search_dict(s);
    if (w==ext_code[win] && w2==ext_code[wto])
      return ext_code[winto];
    if (w==ext_code[wout] && w2==ext_code[wof])
      return ext_code[wfrom];
    pushback_word(s);
    return w;
  }
  else 
    if (is_prep(w)) return w;
  return 0;
}



static int p_multiverb(int vb)
{
  char *s;

  if (vb==39) {  /* LIST */
    s=p_nextword();
    if (strcmp(s,"exit")==0 || strcmp(s,"exits")==0)
      return 42;
    pushback_word(s);
  }
  if (vb==31) { /* TELL/TALK */
    s=p_nextword();
    if (strcmp(s,"to")!=0 && strcmp(s,"with")!=0)
      pushback_word(s);
  }
  return vb;
}


/* This parses a single word: a verb or a preposition */
/* Wordtype=0 for verb, 1=prep */
/* report_error is false if we shouldn't print error messages 
   (only used for verbs) and should push back unrecognized words */

static word p_cmdword(rbool wordtype, rbool report_error)
{
  char *s;
  word w;
  int vb;

  p_cmdspace();
  if (wordtype==0 && strncasecmp(lineptr,"subroutine",10)==0
      && (isdigit(lineptr[10]) || lineptr[10]==start_label))
    return p_sub_verb();
  s=p_nextword();
  if (strcasecmp(s,"any")==0) return 0; /* An important special case */
  if (strcasecmp(s,"$verb$")==0) {
    if (wordtype!=0) 
      reporterror(2,E_ERR,"Use of $verb$ as preposition.",NULL);
    return ext_code[wdverb];
  }
  if (strcasecmp(s,"$prep$")==0) {
    if (wordtype!=1) 
      reporterror(2,E_ERR,"Use of $prep$ as verb.",NULL);
    return ext_code[wdprep];
  }
  if (*s==0) {
    if (wordtype==0) {
      reporterror(2,E_WARN,"Command without verb; assuming ANY.",NULL);
      return 0;
    }
    return (nomatch_active ? -1 : 0);
  }
  w=search_dict(s);
  if (wordtype==1) {/* prep */
    w=p_multiprep(w);
    if (w>0) return w;
    reporterror(2,E_ERR,"Unrecognized preposition '%s'; ignoring.",s);
    return 0;
  }
  if (w>0) vb=lookup_verb(w,0,report_error); else vb=0;
  vb=p_multiverb(vb); /* Make sure we don't have multiple-word verb */ 
  if (vb!=0) /* We've got a verb */
    return csyntbl[auxsyn[vb]]; /* Return canonical form */
  if (report_error) {
    reporterror(2,E_ERR,"Unrecognized verb '%s'.",s);
    return 0;
  } else {
    pushback_word(s);
    return -1; /* Don't recognize word */
  }
}



/* This does various processing on the command to parallel things
   the parser will do. */
static void translate_cmd(cmd_rec *cmd)
{
  word tmp;

  /* TURN ON/OFF <xxx> ==> TURN <xxx> ON/OFF */  
  if ((cmd->verbcmd==csyntbl[auxsyn[35]]) 
      && (cmd->prep==ext_code[won] || cmd->prep==ext_code[woff])
      && cmd->nouncmd==0) {
    cmd->noun_adj=cmd->obj_adj; cmd->obj_adj=0;
    cmd->nouncmd=cmd->objcmd; cmd->objcmd=0;
    cmd->noun_obj=cmd->obj_obj; cmd->obj_obj=0;
  }

 /* Next we check to convert SHOOT <noun> AT <object> to 
    SHOOT <object> WITH <noun> */
  if (cmd->verbcmd==csyntbl[auxsyn[49]] && cmd->prep==ext_code[wat]) {
    tmp=cmd->objcmd; cmd->objcmd=cmd->nouncmd; cmd->nouncmd=tmp;
    tmp=cmd->obj_adj; cmd->obj_adj=cmd->noun_adj; cmd->noun_adj=tmp;
    cmd->prep=ext_code[wwith];
  }

}




static int nextcmd; /* Points to next unused command */
     
/* Returns command number */
static int p_cmdhead(rbool is_redir)
{
  char *s;
  
  oldword1=oldword2=NULL;  /* Clear out pushback storage */
  command[nextcmd].verbcmd=-1;
  if (PDEBUG2) rprintf("\n");

  enable_fakespace=1;
  /* Scan for comma */
  for(s=lineptr;*s!=0 && *s!=',';s++);
  if (*s==',') {  /* We have an actor construction */
    *s=0;
    command[nextcmd].actor=p_obj(1,0,0,1,NULL,NULL);
    if (command[nextcmd].actor==0) 
      command[nextcmd].actor=2; /* ANYBODY */
    *s=',';
    lineptr=++s;
    for(;*s!=0 && *s!=',';s++); /* Make sure there are no more commas */
    if (*s==',') 
      reporterror(2,E_WARN,"Extra comma ignored.",NULL);
  } else {
    command[nextcmd].actor=1; /* The player */

    /* First attempt to parse verb, in case where there is apparently no
       actor */
    
    command[nextcmd].verbcmd=p_cmdword(0,0);
    if (command[nextcmd].verbcmd==-1) {  
      /* Not a verb, maybe actor? */      
      /* Try parsing as actor (but with report_error=0) */
      command[nextcmd].actor=p_obj(1,0,0,0,NULL,NULL);
      if (command[nextcmd].actor==0)  /* ANYBODY-->2 */
	command[nextcmd].actor=2;
      else if (command[nextcmd].actor==-1) /* Not actor after all */
	command[nextcmd].actor=1;  
    }
  }
  

  /* If we have an actor, or our first attempt to parse the verb failed,
     the try parsing the verb */
  if (command[nextcmd].verbcmd==-1) { /* Report errors this time */
    command[nextcmd].verbcmd=p_cmdword(0,1); 
  }


  /* ---------------------------------------- */
  /* Now we parse the NOUN, PREP, and OBJECT */

  p_objname(1,is_redir,&command[nextcmd].noun_adj,
	    &command[nextcmd].nouncmd,&command[nextcmd].noun_obj);
  command[nextcmd].prep=p_cmdword(1,1);
  p_objname(0,is_redir,&command[nextcmd].obj_adj,
	    &command[nextcmd].objcmd,&command[nextcmd].obj_obj);

  /* Do various processing to match things the real parser will do */
  translate_cmd(&command[nextcmd]);

  if (is_redir) {
    command[nextcmd].data=NULL;
    command[nextcmd].cmdsize=0;
  }
  if (is_redir) command[nextcmd].actor=-command[nextcmd].actor;
  enable_fakespace=0;
  return nextcmd++;
}






/* ------------------------------------------------------------------- */
/*  Write assembled instructions                                       */
/* ------------------------------------------------------------------- */

static void enlarge_cmdsize(cmd_rec *cmd, long n)
{  
  cmd->cmdsize+=n;
  if (pass==2) {
    cmd->data=rrealloc(cmd->data,cmd->cmdsize*sizeof(integer));
  }
}

/* This writes a metatoken at the given address, and returns
   the new value of ip */
static int write_metatoken(integer op, int argnum, int optype,
			   int arg1, int arg2,
			   cmd_rec *cmd, int ip)
{
  if ( op==143 || op==1161 ) 
    if (min_ver<3) min_ver=3;

  cmd->data[ip++]=op + optype*2048;
  if (argnum>=1) {
    if (!(optype&8))   /* First argument into place */
      cmd->data[ip++]=arg1;
    else cmd->cmdsize--;	
    /* optype&8 means we have NOUN or OBJECT which take no space */
  }
  if (argnum>=2) { /* Second argument into place */
    if (!(optype&2)) 
      cmd->data[ip++]=arg2;
    else cmd->cmdsize--;	
    /* optype&2 means we have NOUN or OBJECT which take no space */
  }
  return ip;
}


/* ------------------------------------------------------------------- */
/*  Parse arguments to metacommands                                    */
/* ------------------------------------------------------------------- */


/* Actually parse a normal label argument; also deal with
   proprefs */
/* This parses the '.' operator as being left-associative. */
/* IF '*lip' is not NULL, it will be set to the ip value for the 
   last Push operation. (so that it can be converted to Pop if we
   are dealing with an lvalue) */
/* ref_type = 0 normally; for commands whose second argument
   is some sort of property or attribute, it can be
   AGT_OBJPROP, AGT_OBJFLAG, AGT_PROP, or AGT_ATTR.
   This indicates that we may have a command of the form
   "Push [object].[prop]" ==> "PushProp [object] [prop] */

static long p_normarg(int dtype, int *optype, 
		      cmd_rec *cmd, int *rip, int *lip, 
		      int ref_type)
{
  int arg, pref;
  int temptype;
  char *backtrack;
  rbool builtin_prop; /* True if property number is builtin property */
  
  temptype=0;
  if (lip!=NULL) *lip=0;
  arg=p_operand(dtype,&temptype,0,NULL);
  if ( (dtype&AGT_VAR) && find_propref(1)) {
    reporterror(2,E_WARN,"Expected variable, not object property.",NULL);
  }
  while(find_propref(1)) {
    temptype<<=2;
    backtrack=lineptr;
    pref=p_operand(AGT_GENPROP, &temptype, 
		   ref_type ? ref_type : AGT_GENPROP, &builtin_prop );
    if (ref_type && !find_propref(1)) { /* terminal objprop/objflag id */
      /* Need to backup; this is actually the *next* argument */
      /* That is, "PushProp [obj].[prop]" is the same 
	 as "PushProp [obj] [prop]" */
      lineptr=backtrack;
      temptype>>=2;
      break;     /* We're done */
    }
    enlarge_cmdsize(cmd,3);
    if (lip!=NULL) *lip=*rip;
    /* Insert PushProp or PushObjProp command */
    *rip=write_metatoken(builtin_prop ? 1147 : 1159,  
			 2,temptype,arg,pref,cmd,*rip);
    arg=-1; temptype=1;  /* TOS */
  }
  *optype|=temptype;
  return arg; 
}
 
static long p_arg(int op, int argnum, int dtype, int *optype, char *opname,
	   cmd_rec *cmd, int *rip, int *lip)
     /* Parses the argument to a metacommand */
     /* op==opcode, argnum=argument number(1 or 2); dtype=data type of arg */
     /* optype==data type of operand (variable, immediate, etc.)-- set
	by this routine */
     /* Opname: Name of operand, used for END_*** purposes 
	(e.g. End_PrintMessage) */
     /* cmd is a pointer to the current command block, and ip
	is the pointer to the current assembly-point.  These are needed
	if p_arg runs into a compound argument that requires assembly */
     /* If *lip is nonnull and we end up constructing a set of stack-commands,
	then it will point to the ip of the last opcode in these commands
	(so that this opcode can be converted to a Pop) */
     /* Most of this information is for error checking. */
     /* While mainly a wrapper for p_label, this handles a few special cases */
{
  int attr_ref;

  /* By default, we leave optype alone. */
  while(*lineptr!=0 && *lineptr!=start_label 
	&& *lineptr!=start_quote
	&& !isalnum(*lineptr)) 
    lineptr++;

  if (dtype==AGT_MSG && op!=1063)  /* 1063: RandomMessage */
    /* This handles message "shortcuts"; if not being used, 
     fall through to the regular code */
    if (*lineptr==0 || *lineptr==start_quote)
      return p_genmsg(opname);
  /* p_genmsg can handle every case but labels, a number, or
     NOUN/OBJECT/etc.
     the problem with labels is they could really be variables. 
     Numbers could be the start of an "object.property" reference.
     This isn't a problem if we are dealing with pre-AGX code */
 
  if (pass==1) return 0;

  /* For the built-in tokens to handle objflags and properties: */
  /*  These handle the "Pop [object].[prop]" type commands
      that need to be translated into "PopProp [object] [prop]" */
  /* These indicate the data type of the second argument for those
     particular commands.  For all other commands, attr_ref should
     be zero. */

  attr_ref=0; 
  if (argnum==1) {
    if ( op==141 || op==142 || (op>=1156 && op<=1158)) 
      attr_ref=AGT_OBJFLAG;
    else if (op==1159 || op==1160) attr_ref=AGT_OBJPROP;
    else if (op==125 || op==1145 || op==1146) attr_ref=AGT_ATTR;
    else if (op==1147 || op==1148) attr_ref=AGT_PROP;
  }

  return p_normarg(dtype,optype,cmd,rip,lip,attr_ref);
}


/* ------------------------------------------------------------------- */
/*  Parse l-value psuedotokens                                         */
/* ------------------------------------------------------------------- */

typedef struct {
  int size;   /* 0 if passing a variable */
  int varnum;  /* only valid if size==0 */
  integer *data; /* only valid if size>0 */
  integer fixip; /* ip offset to change to a Pop */
} lval_rec;
 
/* Parse argument as l-value */
static lval_rec *p_lval(void)
{
  int arg, optype, ip, lip;
  cmd_rec tmp;  
  lval_rec *lval;

  lval=rmalloc(sizeof(lval_rec));
  tmp.cmdsize=0; tmp.data=NULL;
  ip=0;  
  arg=p_arg(8002,1,AGT_NUM,&optype,"",&tmp,&ip,&lip);
  if (!(optype&3)==1) { /* Not variable or TOS */
    optype= (optype & ~3) | 1;  /* Treat as variable id */
    tmp.cmdsize=0;
    reporterror(2,E_WARN,
		"First argument must be variable or object property.",NULL);
  }
  lval->size=tmp.cmdsize;
  lval->data=tmp.data;
  lval->varnum=arg;
  lval->fixip=lip;
  return lval;
}



static integer var_op[]={1097,1098,1099,1118,1119,1120};

static int p_arith(cmd_rec *cmd, int ip, int op)
     /* op=0 for Set, 1 for Add, 2 for Sub, 3 for Mul, 4 for Div
	  5 for Rem */
{
  lval_rec *lval;
  int arg2, optype;

  optype=0;
  lval=p_lval();
  arg2=p_arg(op,2,AGT_NUM,&optype,"",cmd,&ip,NULL);
  if (lval->size==0) /* Variable */
    ip=write_metatoken(var_op[op-8002],2,optype,lval->varnum,arg2,cmd,ip);    
  else {
    if (arg2!=-1 || !(optype&1)) {  /* arg2 not TOS */
      enlarge_cmdsize(cmd,2);
      optype<<=2;
      ip=write_metatoken(1135,1,optype,arg2,0,cmd,ip); /* PushStack <arg2> */
    }
    if (op!=8002) { /* Not SET */      
      enlarge_cmdsize(cmd,2*lval->size-2);     /* Make space */
      /* Write lval-data */     
      memcpy(cmd->data+ip,lval->data,lval->size*sizeof(integer));   
      ip+=lval->size;
      ip=write_metatoken(op-8003+1137,0,0,0,0,cmd,ip); /* Do operation */      
    } else 
      enlarge_cmdsize(cmd,lval->size-3); /* Make space for SET */
    /* Write lval-data a second time, to give us a storage address */
    memcpy(cmd->data+ip,lval->data,lval->size*sizeof(integer));
    cmd->data[ip+lval->fixip]+=1;  /* Convert last PushProp into PopProp */    
    ip+=lval->size;
    rfree(lval->data);
  }
  assert(lval->data==NULL);
  rfree(lval);
  return ip;
}

/* ------------------------------------------------------------------- */
/*  AGATE command structure                                            */
/* ------------------------------------------------------------------- */

typedef struct {
  int id;  /* The id associated with this element. */
  int targ; /* The offset at which to backpatch. */
} backpatch_elt;

static backpatch_elt *agate_stack, *agate_nextlist;
static int agate_sp, agate_nextcnt; /* Stack size and number of NEXT records */
static int agate_nextjunk; /* Number of 'empty' NEXT records. */

/* Clear out old NEXT records */
static void cleannext(void)
{
  int i, j;
  for(i=0,j=0;j<agate_nextcnt;j++) {
    if (agate_nextlist[j].id!=-1) {
      memcpy(agate_nextlist+i,agate_nextlist+j,sizeof(backpatch_elt));
      i++;
    }
  }
  agate_nextcnt=i;
  agate_nextjunk=0;
  agate_nextlist=rrealloc(agate_nextlist,agate_nextcnt*sizeof(backpatch_elt));
}

static void agate_backpatch(int id, int ip,integer *instr)
{
  int i;
  /* We need to find <id> on the stack, plug in the value of 
     <ip> at the backpatch target, and then set the target to the <ip>,
     poping all higher elements off the stack. */
  if (id<=0) {
    reporterror(2,E_ERR,"Token sequence id must be positive.",NULL);
    return;
  }
  for(i=0;i<agate_sp;i++)
    if (agate_stack[i].id==id) { /* Found it */
      int j;
      /* Set all more deeply nested elements pointing at this one. */
      for(j=i;j<agate_sp;j++) 
	instr[agate_stack[j].targ]=ip;
      for (j=0;j<agate_nextcnt;j++) /* Backpatch NEXTs */
	if (agate_nextlist[j].id==id) {
	  instr[agate_nextlist[j].targ]=ip;
	  agate_nextlist[j].id=0; /* Mark unused */
	  agate_nextjunk++;
	}
      if (agate_nextjunk>25) cleannext();
      agate_sp=i+1; /* Pop all more-deeply-nested elements off the stack */
      agate_stack[i].targ=ip+1;  /* Set this as new backpatch target */
      return;
    }
	   
  /* <id> wasn't on the stack; need to add it. */
  /*  In this case, we don't need to backpatch, but do need to set
      ourselves up as the next backpatch target */
  if (agate_sp>0 && id<agate_stack[agate_sp-1].id) 
    reporterror(2,E_WARN,"Token sequence id out of numerical order.",NULL);
  agate_sp++;
  agate_stack=rrealloc(agate_stack,agate_sp*sizeof(backpatch_elt));
  agate_stack[agate_sp-1].id=id;
  agate_stack[agate_sp-1].targ=ip+1; 
}

/* This routine needs to clean up all remaining backpatch targets
   (pointing them beyond the end of the instruction stream) 
   and free up agate_stack */
static void agate_finish(integer *instr, integer endaddr)
{
  int i;
  for(i=0;i<agate_sp;i++) 
    instr[agate_stack[i].targ]=endaddr;
  for(i=0;i<agate_nextcnt;i++)
    if (agate_nextlist[i].id!=0) {
      char *s;
      s=rmalloc(50);
      sprintf(s,"%d",agate_nextlist[i].id);
      reporterror(2,E_ERR,"NEXT %s without target.",s);
      rfree(s);      
    }
  rfree(agate_stack);
  rfree(agate_nextlist);
}


static int p_jumparg(void)
{
  long id;
  p_space();
  if (!isdigit(*lineptr)) {
    reporterror(2,E_ERR,"Invalid argument to NEXT.",NULL);
    return -1;
  }
  id=p_number();
  if (id<0) {
    reporterror(2,E_ERR,"Token sequence ID must be positive.",NULL);
    return -1;
  }
  if (id>9999) {
    reporterror(2,E_ERR,"Token sequence ID too large.",NULL);
    return -1;
  }
  return id;
}



/* This compiles the NEXT (psuedo-)instruction */
/* It assumes that space has already been made for two tokens */
static void p_opnext(integer *instr,integer ip)
{
  int id;
 
  id=p_jumparg();
  if (pass!=2) return;
  if (id==-1) return; /* Error */
  instr[ip]=1149; /* Goto */
  if (id==0) {  /* Jump off the edge of the world */
    instr[ip+1]=32000; 
    return;
  }
  agate_nextcnt++;
  agate_nextlist=rrealloc(agate_nextlist,agate_nextcnt*sizeof(backpatch_elt));
  agate_nextlist[agate_nextcnt-1].id=id;
  agate_nextlist[agate_nextcnt-1].targ=ip+1;
}

/* This compiles the PREV psuedo-token. This is easier than NEXT since
   we don't need to backpatch-- the labels are already there. */
/* It assumes that space has already been made for two tokens */
static void p_opprev(integer *instr,integer ip)
{
  int id,i;

  id=p_jumparg();
  if (id==-1) return;
  if (pass!=2) return;
  instr[ip]=1149;  /* goto */
  if (id==0) {  /* Jump back to the beginning of this metacommand */
    instr[ip+1]=0;
    return;
  }
  for(i=0;i<agate_sp && agate_stack[i].id!=id;i++);
  if (i==agate_sp) {
    char *s;
    s=rmalloc(50);
    sprintf(s,"%d",id);
    reporterror(2,E_ERR,"PREV %s without target.",s);
    rfree(s);          
    return;
  }  
  instr[ip+1]=agate_stack[i].targ-1;
  /* We subtract 1 because targ actually points to the argument of the
     previous OnFailGoto, not the opcode itself. */
}


/* ------------------------------------------------------------------- */
/*  Parse the command tokens themselves                                */
/* ------------------------------------------------------------------- */

#define OPBIT 10
#define OPHASHSIZE (1<<OPBIT)
#define OPMASK (OPHASHSIZE-1)

int ophash[OPHASHSIZE];


/* This relies on '_' being the smallest character to appear in
   a keyword after downcasing */
/* This returns the hash value of the first string on the line */
static long ophashfunc(char *s)
{
  long val;
  
  val=0;
  for( ; isalpha(*s) || *s=='_' ; s++) {
    val=(val<<1)+(tolower(*s)-'_'); 
    val=(val^(val>>OPBIT))&OPMASK;
  }
  if (val<0) val=0;  /* Could happen if not all characters are alphabetic */
  return val;
}


static int coll_count; 

static void add_to_ophash(char *s,int op)
{
  int n;
  n=ophashfunc(s);
  while(ophash[n]!=3000) {
    coll_count++;
    n=(n+1)&OPMASK;
  }
  ophash[n]=op;
}

void build_ophash(void)
{
  int i;

  nextcmd=0;
  coll_count=0;
  for(i=0;i<OPHASHSIZE;i++) ophash[i]=3000;
  for(i=0;i<=MAX_COND;i++)
    add_to_ophash(cond_def[i].opcode,i);
  for(i=0;i<=PREWIN_ACT-START_ACT;i++)
    add_to_ophash(act_def[i].opcode,i+START_ACT);
  for(i=0;i<=MAX_ACT-WIN_ACT;i++)
    add_to_ophash(end_def[i].opcode,i+WIN_ACT);
  for(i=0;i<=MAX_PSUEDO-START_PSUEDO;i++) 
    add_to_ophash(psuedo_def[i].opcode,i+START_PSUEDO);
  if (REPORT_COLLISION && coll_count>0) 
    rprintf("Opcode collisions: %d\n",coll_count);
}


/* This parses metacommand tokens, returning the opcode */
/* -1=unrecognized, -2=blank. */
static integer p_metatoken(void)
{
  char *s,c;
  int n;

  p_space();
  if (*lineptr==0) /* No token on line */
    return -2;
  if (*lineptr==start_label) { /* Special alternative FLAG syntax */
    return 66; /* FlagOn-- and leave lineptr pointing at the same
		  place */
  }
  n=ophashfunc(lineptr);
  while(ophash[n]!=3000 && !keymatch(magx_get_opdef(ophash[n])->opcode))
    n=(n+1)&OPMASK;
  if (ophash[n]!=3000) {
    int op;
    op=ophash[n];
    if (verflag!=v_183) {
      if (op>=1106 && op<=1113)
	reporterror(2,E_WARN,"This time command is 1.83-specific, but "
		    "you are not compiling it as a 1.83 game.",NULL);
      if (op==110 || op==111) {
	if (verflag==v_default) {
	  reporterror(2,E_NOTE,"Found %s; switching to VERSION 1.83.",
		      op==110 ? "BeforeCommand":"AfterCommand");
	  verflag=v_183;
	  TWO_CYCLE=1;
	} else 
	  reporterror(2,E_WARN,"BeforeCommand and AfterCommand require "
			"VERSION 1.83 in order to work.",NULL);	
      }
    }
    else if (verflag==v_183 && 
	     ( (op>=1114 && op<=1116) || (op>=1032 && op<=1036) ) )
      reporterror(2,E_WARN,"This time command may not work in a 1.83 game.",
		  NULL);
    if (op==123 && PURE_AND!=0) {
      if (PURE_AND==2) {
	reporterror(2,E_NOTE,"OncePerTurn found; turning on FIX_MULTINOUN.",
		    NULL);
	PURE_AND=0;
      } else 
	reporterror(2,E_WARN,"OncePerTurn requires FIX_MULTINOUN to be set ("
		    "in the CONFIG section).",NULL);
    }
    return ophash[n];

  }
  for(s=lineptr;isalnum(*s);s++);
  c=*s;*s=0;
  reporterror(2,E_ERR,"Invalid metacommand token '%s'.",lineptr);
  *s=c;
  return -1;
}



/* ------------------------------------------------------------------- */
/*  Parse metacommands                                                 */
/* ------------------------------------------------------------------- */

/* Parse metacommands */
/* is_after is true if the keyword is actually AFTER, instead of
   COMMAND */
void p_command(rbool is_after)
{
  int cmdnum, ip, optype;
  integer op, arg1, arg2; 
  const opdef *opinfo;
  uchar endop;  /* Have we reached a terminal opcode? 2=redirect */
  rbool or_state;  /* Have we just seen an OR? */
  rbool pending_not; /* Is there a pending NOT command? */
  rbool lastcond;  /* Was last token a conditional token? */
  rbool orblock;  /* Are we parsing an orblock? */
  rbool supress_error; 
  rbool agate_prefix; /* True if the line has an AGATE prefix
			(A number, '&', or '-') as required for all
			conditional tokens under strict AGATE rules */
  int redir_cnt;   /* Number of RedirectTos in this command so far;
		      if more than one, need to use XRedirect */

  cmdnum=0;opinfo=NULL; /* Silence compiler warnings */

  if (pass==1)
    last_cmd++;

  if (pass==2) {
    cmdnum=p_cmdhead(0);
    command[cmdnum].cmdsize=0;
    command[cmdnum].data=NULL;
  }

  endop=0; ip=0; op=0; 
  redir_cnt=0;
  supress_error=0;
  lastcond=0;
  orblock=0;
  agate_prefix=0;
  pending_not=0; or_state=0;

  agate_stack=agate_nextlist=NULL;
  agate_sp=0; agate_nextcnt=agate_nextjunk=0;

  if (pass==2 && implicit_two_cycle 
      && command[cmdnum].verbcmd!=ext_code[wafter]) {
    /* Insert Before/AfterCommand at start of code */
    enlarge_cmdsize(&command[cmdnum],1);
    command[cmdnum].data[0]= is_after ? 111  : 110;
    ip++;
  }

  for(;;) {

    /* First of all, the finishing up code */

    if (!nextline(0,is_after?"after":"command")) {
      if (pass==1 && (pending_not || or_state)) {
	reporterror(1,E_ERR,"NOT not followed by conditional token.",NULL);
      }
      if (pass==2) {
	enlarge_cmdsize(&command[cmdnum],0);
	agate_finish(command[cmdnum].data,command[cmdnum].cmdsize);
	/* AGiliTy doesn't require EndCommand, so we don't insert it  */
      }
      return;
    }

    /* Check for AGATE level id. */
    if (verflag==v_agx) {
      p_space();    
      if (isdigit(*lineptr)) {  /* We have an AGATE-id */
	int id; /* Label id */
	id=p_number();
	endop=0;
	if (pass==2) {
	  enlarge_cmdsize(&command[cmdnum],2);
	  command[cmdnum].data[ip]=1150; /* OnFailGoto */
	  agate_backpatch(id,ip,command[cmdnum].data);
	} 
	ip+=2;
	agate_prefix=1;
      } else 
	if (*lineptr=='-' || *lineptr=='&') {
	  lineptr++;
	  agate_prefix=1;
	} else agate_prefix=0; /* We don't clear it until _after_ we 
				  know that there isn't another one. */
    }

    /* Token never reached code -- this must come _after_ the 
       AGATE code, since AGATE jumps can change reachability. */
    if (pass!=1 && endop && op!=2004) { /* 2004=DoneWithTurn */
      if (!supress_error) 
	reporterror(2, E_WARN,  
		    "Metacommand token never reached.",NULL);
      supress_error=1;
      continue;
    }

    do {  /* Loop to deal with possibility of OR or NOT on line with
	     another token */

      op=p_metatoken();

      if (op==-1) break; /* Unrecognized; skip this line */	
      if (op==-2) break;  /* Blank; skip to next line. */
      if (op>=END_ACT && op<START_PSUEDO) endop=1;

      opinfo=magx_get_opdef(op);

      if (op>=1128 && op<=1131) /* FailMessage group */
	reporterror(2,E_ERR,
		    "Token '%s' is no longer supported.",
		    opinfo->opcode);

      /* Set up basic information */
      if (pass==2) { 	
	if (op==1062 && redir_cnt>=1) 
	  command[cmdnum].cmdsize++;
	enlarge_cmdsize(&command[cmdnum],1+opinfo->argnum);
      }

      if (pass==1 && op==1132 && !orblock) { 
	/* AND should only follow OR block */
	reporterror(1,E_WARN,"AND not needed.",NULL);
	lastcond=orblock=pending_not=or_state=0;
	continue;
      }

      /* Check that OR, NOT, and Fail* are attached to conditional tokens */
      if (pass==1) {
	if (op==109 && !lastcond) 
	  reporterror(1,E_WARN,"OR follows action token.",NULL);
	if (!lastcond && op>=1128 && op<=1131)
	  reporterror(1,E_ERR,"%s must come after conditional token.",
		      opinfo->opcode);
	lastcond=(op<=MAX_COND);
	orblock=orblock&&lastcond;
	if (op==109) orblock=1;
	
	if (op>MAX_COND) {
	  if (pending_not)
	    reporterror(1,E_ERR,"NOT applied to action token.",NULL);
	  else if (or_state && op>MAX_COND) 
	    reporterror(1,E_ERR,"OR applied to action token.",NULL);	
	}
      }

      optype=0; /* By default, both arguments are immediate */
      arg1=arg2=0;

      /* Do computations for various special cases: */
      /*   RedirectTo, XRedirect, Next, Prev */
      if (op==1062) { /* RedirectTo */      
	if (pass==1) 
	  last_cmd++;
	else 
	  p_cmdhead(1);
	endop=2;
	redir_cnt++;
	if (redir_cnt>1) {  /* Need to use XRedirect */
	  op=1152;
	  arg1=redir_cnt;
	}
      } else if (op==8000) {  /* Handle NEXT */
	p_opnext( (pass==1 ? NULL : command[cmdnum].data) , ip);
	ip+=2;
	endop=1;
	continue;
      }
      else if (op==8001) { /* PREV */
	p_opprev( (pass==1 ? NULL : command[cmdnum].data) , ip);
	ip+=2;
	endop=1;
	continue;
      } else if (op>=8002 && op<=8007) { /* SET, ADD, SUBTRACT, ... */       
	if (pass==2)
	  ip=p_arith(&command[cmdnum],ip,op);
	continue;
      } else if (op==108) { /* NOT */
	if (pending_not) {
	  reporterror(1,E_WARN,"Double NOT found.",NULL);
	  pending_not=0;	
	}
	if (pass==2)
	  command[cmdnum].cmdsize--; /* Avoid double-counting */
	pending_not=1;	
	continue;
      } else { 
	/* Not RedirectTo, XRedirect, Next, Prev */
	/* Compute args in general case */

	/* First argument */
	if (opinfo->argnum>=1) 
	  arg1=p_arg(op,1,opinfo->arg1,&optype,opinfo->opcode,
		     &command[cmdnum],&ip,NULL);

	optype<<=2; /* To make room for second argument */

	/* Second argument */
	if (opinfo->argnum>=2)
	  arg2=p_arg(op,2,opinfo->arg2,&optype,opinfo->opcode,
		     &command[cmdnum],&ip,NULL);
      }
   
      if (pass==2) {  /* Now write the actual command */
	if (pending_not) {
	  enlarge_cmdsize(&command[cmdnum],1);
	  ip=write_metatoken(108,0,0,0,0,&command[cmdnum],ip);
	  pending_not=0;
	}
	ip=write_metatoken(op,opinfo->argnum,optype,arg1,arg2,
			&command[cmdnum],ip);
      
	/* For opcodes in which the two arguments define a range,
	   verify that the first one is <= the second one. */
	if (optype==0
	    && (op==7 || op==1001 || op==1020 || op==1063 || op==1086))
	  if (command[cmdnum].data[ip-2] > command[cmdnum].data[ip-1])
	    reporterror(2,E_ERR,"First argument of range should be"
			" smaller than second.",NULL);    
      }

      /* Check that OR and NOT are not combined in odd ways. */
      if (pass==1 && op==109) {
	  if (pending_not || or_state) 
	    reporterror(1,E_ERR,"Spurious OR found.",NULL);
	  or_state=1;
	} else or_state=0;  
      if (op!=108) pending_not=0;
      p_space();
      if (*lineptr==0) break;
    } while (op==108 || op==109); /* OR or NOT can appear on same
				   line as other tokens */
  }
}
