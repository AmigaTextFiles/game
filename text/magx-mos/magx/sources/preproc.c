/* preproc.c:  The preprocessor and file functions        */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

/* The routines in this module handle the low level mechanics 
   of reading in files, dealing with #INCLUDE and #DEFINE,
   stripping out comments, etc. */


#include <assert.h>
#include <ctype.h>
#include "agility.h"
#include "comp.h"

char start_quote='"',end_quote='"', start_label='[',end_label=']';
char start_keyword='#';




/* ------------------------------------------------------------------- */
/*  Routines to parse preprocessor directives                          */
/* ------------------------------------------------------------------- */

void p_delim(int delim) /* delim=1 for lables, 2 for msgs, 9 for dictspace */
{
  while(isspace(*lineptr)) lineptr++;
  if (*lineptr==0) {
    reporterror(1,E_ERR,"Invalid delimiter in #OPTIONS.",NULL);
    return;}
  if (delim==1) start_label=*lineptr; 
  else if (delim==2) start_quote=*lineptr;
  else if (delim==3) start_keyword=*lineptr;
  else if (delim==9) fake_space=*lineptr;
  if (delim==3 || delim==9) return;
  lineptr++;
  if (*lineptr==0 || isspace(*lineptr)) lineptr--;     
  if (delim==1) end_label=*lineptr; 
  else if (delim==2) end_quote=*lineptr;
}


static rbool save_optflag[]={1,0,1,1};
static const char *optname[]={"CaseSensitive","Whitespace",
			      "Warn_ExtraText","Warn_Number",
			      "INTERNAL ERROR", "Assume_Any"};
static const rbool opton[]={0,1,0,1,0,0};


void setflagopt(char c, rbool *b, int opt)
{
  switch(c) 
    {
    case '+': *b=opton[opt-5]; return;
    case '-': *b=!opton[opt-5]; return;
    case '/': *b=!*b; return;
    case ':': save_optflag[opt-5]=*b; return;
    case '=': *b=save_optflag[opt-5]; return;
    case ';': 
      rprintf("OPTION %s is %s\n",optname[opt-4],
	     *b==opton[opt-5] ? "ON" : "OFF");
      return;
    default: return;
    }
}


/* opt=1 lables, 2 messages, 3 warnings, 4 warnings, 
   5 casesensitive, 6 whitespace, 7 warn_extratext  8 warn_number 
   9 fake_space    10 assume_any */
void setoption(int opt,char c)
{
  if (opt==3) return; /* warnings */
  switch(opt) 
    {
    case 1: case 2: case 3: case 9: /* labels and messages */
      if (c=='/' || isalnum(c)) p_delim(opt);
      else reporterror(1,E_WARN,
		       "Invalid command character for option.",NULL);
      break;
    case 4: return; /* Warnings; we ignore this */
    case 5: /* setflagopt(c,&label_case,opt); */ break;
    case 6: setflagopt(c,&label_whitespace,opt); break;
    case 7: setflagopt(c,&ignore_extra_text,opt); break;
    case 8: return; /* warn_number */
    case 10: setflagopt(c,&nomatch_active,opt);break;
    default: rprintf("INTERNAL ERROR: Invalid option id."); return;
  }
}



#define ctrlchar(c) ((c)=='/' || (c)=='=' || (c)=='-' || (c)=='+' || (c)==':')

void p_options(void) /* Parse #options */
{
  char *ctrlstr;
  rbool supress_error;
  int optnum;

  supress_error=0;
  for(;;) {
    while(!ctrlchar(*lineptr) && !isalnum(*lineptr) && *lineptr!=0) 
      lineptr++;
    if (*lineptr==0) return;
    ctrlstr=lineptr;
    while (ctrlchar(*lineptr)) lineptr++;
    if (!isalnum(*lineptr)) {
      if (*lineptr) lineptr++;
      if (!supress_error)
	reporterror(1,E_WARN,"Expected option.",NULL);
      supress_error=1;
      continue;
    }
    if (keymatch("labels") || keymatch("labeldelimiters"))
      {p_delim(1); continue;}
    else if (keymatch("messages") || keymatch("messagedelimiters")) 
      {p_delim(2);continue;}
    else if (keymatch("dictspace"))
      {p_delim(9);continue;}
#if 0
    else if (keymatch("keyworddelimiter")) {p_delim(3); continue;}
    else if (keymatch("casesensitive")) optnum=5;
#endif
    else if (keymatch("warnings")) optnum=4;
    else if (keymatch("whitespace")) optnum=6;
    else if (keymatch("warn_extratext")) optnum=7;
    else if (keymatch("warn_number")) optnum=8;
    else if (keymatch("assume_any")) optnum=10;
    else {
      char *s, c;
      for(s=lineptr;*s!=0 && !isspace(*s);s++);
      c=*s;*s=0;
      reporterror(1,E_WARN,"Invalid option '%s' in #OPTIONS.",lineptr);
      *s=c;
      lineptr=s;
      optnum=0;
      continue;
    }
    for(;ctrlchar(*ctrlstr);ctrlstr++)
      setoption(optnum,*ctrlstr);
  }
}


/* ------------------------------------------------------------------- */
/*  String scanning utilities                                          */
/* ------------------------------------------------------------------- */

rbool blankline(char *s)
{
  for(;*s!=0;s++) 
    if (!isspace(*s)) return 0;
  return 1;
}


/* This moves the line pointer over whitespace */
/* Note that almost all punctuation except for start_quote and start_label
   count as 'whitespace' for our purposes */
/* We recognize _ because it occurs in some keywords;  - because it
   could start a negative number */

char *skip_space(char *s)
{
  while(!isalnum(*s) && *s!=0 && *s!='_' && *s!='-' 
	&& *s!=start_quote && *s!=start_label)
    s++;
  return s;
}

void p_space(void)
{
  lineptr=skip_space(lineptr);
}


/* This parses one-line descriptions, returning 1 if there was one,
 0 otherwise */
rbool p_descline(descr_ptr *dptr, rbool no_quote) 
 {
  descr_line txt[2];
  
  p_space();
  if (no_quote || lineptr[0]==start_quote) {
    if (pass==2) { /* Actually build description */
      int i;
      txt[0]=expand_descr(lineptr + (no_quote?0:1) ); 
         /* Skip beginning quote */
      txt[1]=NULL; /* Only one-line description */
      if (!no_quote) {
	i=strlen(txt[0]);
	while(i>0 && txt[0][i]!=end_quote) i--;
	if (i==0) reporterror(2,E_ERR,"No end-quote found.",NULL); 
	txt[0][i]=0;
      }
      put_descr(dptr,txt);
      rfree(txt[0]);
    }
    return 1;
  }
  else return 0;
}






/* ------------------------------------------------------------------- */
/* File I/O Routines  II                                               */
/* ------------------------------------------------------------------- */


static int whichfile;  /* 0=AGT, 1=DAT, 2=CMD, 3=MSG */
static fc_type game_fc; 


static void p_include(void)
{
  char *s;
  fc_type newfc;

  /* Need to open include file */
  /* but save state of previous file */
  
  p_space();
  for(s=lineptr;*s!=0 && !isspace(*s);s++); /* Extract file name */
  *s=0;
  
  /* This fc will be automatically freed by popfile() */
  newfc=convert_file_context(game_fc,fAGT,lineptr);
  if (!pushfile(newfc,fNONE))
    reporterror(1,E_FATAL,"Couldn't open include file %s.",lineptr);
}



void opensrc(fc_type fc)
{
  filetype ext;
  rbool succ;

  start_quote='"';
  end_quote='"';
  start_label='[';
  end_label=']';
  start_keyword='#';
  
  save_optflag[0]=save_optflag[2]=save_optflag[3]=1;
  save_optflag[1]=0;

  whichfile=0;
  ext=fAGT;
  succ=pushfile(fc,fAGT);
  if (!succ) {
    whichfile=1;ext=fDAT;
    succ=pushfile(fc,fDAT);
  }
  if (!succ) {
    whichfile=0;
    ext=fNONE;
    succ=pushfile(fc,fNONE);
  }
  if (!succ) 
    fatal("Could not open source file.");
  game_fc=fc;
  line=litline=NULL;
}

/* This moves on to the next source file, returing false if 
   it can't */
static rbool nextfile(void)
{
  filetype ext;
  rbool succ;

  /* We have already done popfile() by this point */
  rfree(line);rfree(litline);

  /* Whichfile:  0=AGT, 1=DAT, 2=CMD, 3=MSG, 4=STD */

  for(;;) {
    if (whichfile==0 || whichfile==3) 
      whichfile=4;
    else if (whichfile>=4) 
      return 0;
    else whichfile++;
    if (whichfile==2) ext=fCMD;
    else if (whichfile==3) ext=fMSG;
    else ext=fSTD;
    
    succ=pushfile(game_fc,ext);
    if (!succ && whichfile==4) {
      succ=pushfile(game_fc,fAGT_STD);
      if (succ) return 1;
    } else if (succ) return 1;
  }
}




static rbool comment_mode; /* Are we parsing a multi-line comment? */

static rbool p_preproc(void)
/* #define, #include, #options, #comment, #end_comment */
{
  lineptr++; /* Skip '#' sign */
  if (comment_mode) {
    if (keymatch("end_comment")) comment_mode=0;
    return 1;
  }
  switch(p_key())
    {
    case kComment:
      if (blankline(lineptr)) /* Multi-line comment */
	comment_mode=1;
      return 1;
    case kDefine: p_define();return 1;
    case kInclude: p_include();return 1;
    case kOptions: p_options();return 1;
    default:reporterror(1,E_WARN,"Unrecognized compiler directive.",NULL);
      return 0;
    }
}
  



/* ------------------------------------------------------------------- */
/* File I/O Routines  I                                                */
/* ------------------------------------------------------------------- */


/* These routines get the next line, killing leading whitespace
   It skips lines that are all spaces and also deals with comments,
     preproccessor directives, and #defines.
   If raw==1, then it _doesn't_ do this processing (except for substituting
      in the #defines)
   sectname is the name of the current section; if the routine
     hits 'end_<sectname>' it returns false, otherwise it returns true.
     The routine will only cross file boundaries of sectname==NULL
     (implying we are at top level), otherwise it prints an error message
   For sectname==NULL, a return of 0 indicates end-of-all-files.
   These routines also handle #include and #define*/ 

#define READLN_GRAIN 128 /* Granularity of readln() rrealloc requests 
			    this needs to be at least the size of a tab 
			    character */
#define DOS_EOF 26    /* Ctrl-Z is the DOS end-of-file marker */


/* This returns the format code corresponding to a given format string */
#define FMT_CODE_CNT 14
char *fmt_code[FMT_CODE_CNT]={"nobf","bf","black","blue","green","cyan",
			      "red","magenta","brown","normal","blink",
			      "white","fixed","nofixed"};

char static format_code(char *fstr)
{
  int i;
  for(i=0;i<FMT_CODE_CNT;i++)
    if (strcasecmp(fstr,fmt_code[i])==0) return i+1;
  if (strcasecmp(fstr,"bold")==0) return 2;
  if (strcasecmp(fstr,"nobold")==0) return 1;
  reporterror(1,E_WARN,"Unrecognized format code \\%s\\.",fstr);
  return 0;
}

/* This is modified from a routine in rmem.c */

/* This routine reads in a line from a 'text' file; it's designed to work
   regardless of the EOL conventions of the platform, at least up to a point. 
   It should work with files that have \n, \r, or \r\n termined lines.  */
/* It also expands #define labels and deals with formatting codes. */

/* litline holds the literal line, used for printing out error messages
     and not much else. */
/* line holds the line that will be used for processing, with #define's
   expanded and slash codes converted */
/* nextline handles #includes and final elimination of comments that
   escape us here (because of ambiguous quotes) and also zaps any
   formmating codes that turn out to *not* be in quotes. */

#define MISC_MODE 0    /* Any other mode */
#define LABEL_MODE 1   /* We're in a label */
#define KEY_MODE 2    /* Line starting with # */
#define WHITE_MODE 3  /* We've only seen whitespace on the line */



rbool read_next_line(void)
     /* If it reaches EOF, it will return false */
     /* This routine recognizes lines terminated by \n, \r, or \r\n */
{
  int c;
  int i, j, k;
  int buffsize; /* Current size of buffer litline */
  int linesize; /* Current size of buffer line */
  rbool slash_white;   /* Have we seen a possible end-of-line slash? */
  rbool whitescan; /* Are we looking for non-whitespace?  
		   True if slash_white or readmode=WHITEMODE */
  int last_slash;  /* Where the last unmatched slash was; -1 if none */
  int last_label;  /* Where last unmatched label starter was; -1 if none. */
  char readmode;



  litline=rrealloc(litline,READLN_GRAIN*sizeof(char));
  line=rrealloc(line,READLN_GRAIN*sizeof(char));
  linesize=buffsize=READLN_GRAIN;  

  i=j=0;
  last_slash=last_label=-1;
  slash_white=0;
  readmode=WHITE_MODE; whitescan=1;
  for(;;) {
    c=nextchar();

    if (c==EOF || c==DOS_EOF) break;
    if (c=='\n' || c=='\r') {
      lineno++;  /* Increment line number even if spliced */   
      if (!slash_white) break;
      else { /* We have a backslash + whitespace; splice lines */
	if (c=='\r')  /* Catch DOS \r\n convention */
	  killchar('\n'); 
	litline[i++]='\n';
	j=last_slash;
	last_slash=-1;
	continue;
      }
    }

    /* Assume worst case scenario, with c expanding to a tab */
    if (i+5>=buffsize-5) {
      buffsize+=READLN_GRAIN;
      litline=rrealloc(litline,buffsize*sizeof(char));
    }
    if (j+5>=linesize-5) {
      linesize+=READLN_GRAIN;
      line=rrealloc(line,linesize*sizeof(char));
    }
    
    if (whitescan) {
      if (c==start_keyword && readmode==WHITE_MODE && !slash_white)  
	readmode=KEY_MODE;
      if (!isspace(c) 
	  && (c!='\\' || verflag!=v_agx || bold_mode)) {
	/* Note that all_white remains clear for one slash */
	slash_white=0;  
	if (readmode==WHITE_MODE) readmode=MISC_MODE;
	whitescan=0;
      }
    }

    switch(c) 
      {
      case 0: case 0xFF:
	litline[i++]=' ';
	line[j++]='\r';
	if (c==0) line[j++]=3;
	else line[j++]=(char)0xFF;
	break;
      case '\t': 
	for(k=0;k<5;k++) litline[i++]=line[j++]=' ';
	break;
      case '\\': 
	if (bold_mode) {
	  litline[i++]='\\';
	  line[j++]=(char)FORMAT_CODE;
	  break;
	} else if (verflag==v_agx) {
	  if (last_slash!=-1) {
	    slash_white=0;
	    litline[i++]=c;
	    if (readmode==WHITE_MODE) readmode=MISC_MODE;
	    if (j==last_slash+1) 
	      { /* \\ ==> \ -- no need to do anything */ }
	    else {   	/* process format code */
	      litline[i]=0; /* So we can print out error messages */
	      line[j]=0;
	      j=last_slash;
	      line[j++]='\r'; /* Format code marker */
	      c=format_code(line+last_slash+1);
	      if (c==0) j=last_slash; /* Ignore bad format code */
	      else line[j++]=c;
	    }
	    last_slash=-1;
	    continue;       
	  } else {  /* ==> last_slash==-1 */
	    last_slash=j;
	    slash_white=1;
	    whitescan=1;
	    /* ... and fall through to default case, below */
	  }
	}
	/* otherwise, fall through... */
      default: 
	litline[i++]=line[j++]=c;
    } 

    /* We can't exit the loop if i>n since we still need to discard
       the rest of the line */
  } 

  litline[i]=line[j]=0; 

  if (last_slash!=-1 && verflag==v_agx) 
    reporterror(1,E_WARN,"Unmatched '\\'.",NULL);

  if (c=='\r')  /* Check for \r\n DOS-style newline  */
    killchar('\n');
  else if (c==DOS_EOF)  /* Ctrl-Z is the DOS EOF marker */
    markeof(c);    /* So it will be the first character we see next time */

  if (i==0 && (c==EOF || c==DOS_EOF)) {/* We've hit the end of the file */
    rfree(line);
    rfree(litline);
    return 0;
  }

  /* Shrink litline and line to the correct size */
  litline=rrealloc(litline,i+1);
  line=rrealloc(line,j+1);

  return 1;
}


/* The following function is used to let section end with more than
   one 'end_' directive-- in particular, for messages */
/* n==1 for message. */

int section_code=0;

void set_section_class(int n)
{
  assert(n==1);
  section_code=1;
}

static rbool match_section_class(char *s)
{
  if (section_code!=1) return 0;
  return (strncasecmp(s,"message",7)==0 
	  || strcasecmp(s,"descr") );
}


#define commentchar(c) (c=='!' || c==';' || c=='*' || c=='>')

rbool nextline(int raw, const char *sectname) 
     /* raw=0:  not raw (fully processed)
	raw=1:  raw data (not processed: comments not stripped, etc.)
	raw=2:  not raw, but preserve blank lines
	*/
{
  char *p;
  rbool labelmode; /* Are we scanning over label? */

  for(;;) {  /* Loop until we actually read a line we can return to 
		our caller */

    if (!read_next_line()) { /* EOF */
      if (sectname!=NULL || comment_mode)  /* ...in the middle of a section */
	reporterror(1,E_FATAL,"Section %s continues past end of file.",
		    comment_mode?"#COMMENT":sectname);
      else if (popfile())  /* End of include file */	
	continue;	/* fc automatically freed in this case */
      else  /* At the top level; try going to the next file */
	if (nextfile()) continue;
	else return 0;
    }

    for(lineptr=litline;isspace(*lineptr);lineptr++);/* Skip leading 
							whitespace */

    /* if (raw==1)  break; */

    if (raw==0 && *lineptr==0) continue; /* Empty line; skip it */
    if (*lineptr==start_keyword && p_preproc()) continue;
    if (comment_mode) continue;
    if (raw==1 || *lineptr==start_label) {/* break */}
    else if (commentchar(*lineptr)) continue; /* Comment */

    /* break;*/   /* If we reach here, we're okay */
    /* } */

    if (sectname!=NULL && tolower(lineptr[0])=='e' && 
	tolower(lineptr[1])=='n' && tolower(lineptr[2])=='d' && 
	tolower(lineptr[3])=='_') 
      {
	if (strncasecmp(sectname,lineptr+4,strlen(sectname))!=0 &&
	    !match_section_class(lineptr+4))
	  reporterror(1,E_WARN,"Nonstandard section end directive '%s'.",
		      lineptr);
	section_code=0;
	return 0; /* End of section */
      }
    
#ifndef EARLY_MACRO_EXPAND  
    lineptr=expand_line(line,0);
    rfree(line);
    p=line=lineptr;
#else
    p=lineptr=line;
#endif

    /* We will be copying from lineptr to p */
    
    if (raw==1) return 1; /* No further processing */

    /* Strip out comments and inappropriate format codes */
    labelmode=0;
    while(*lineptr!=0) {
      if (labelmode) { /* This prevents quotes and comments */
	if (*lineptr==end_label) labelmode=0;
      }
      else if (*lineptr==start_quote) { /* Copy quote */
	char *endptr;
	endptr=lineptr+strlen(lineptr);
	while(endptr>lineptr && *endptr!=end_quote) endptr--;
	if (endptr==lineptr) 
	  endptr=lineptr+strlen(lineptr); /* All of line */
	while(lineptr<endptr) *p++=*lineptr++;
	if (*lineptr==0) break;
      }
      else if (*lineptr==start_label)
	labelmode=1;
      else if (lineptr[0]=='(' && lineptr[1]=='*') { /* Skip comment */
	while(*lineptr!=0 && !(lineptr[0]=='*' && lineptr[1]==')'))
	  lineptr++;
	if (*lineptr=='*') 
	  lineptr+=2;
	else 
	  reporterror(1,E_WARN,"Unterminated comment.",NULL);
	*p++=' '; /* Comments condense to whitespace */
	continue;
      } else if (commentchar(*lineptr)) break; /* Rest of line is comment */
      if (*lineptr=='\r') { 	/* Format code outside of quote */
	if ( *((uchar*)(lineptr+1))==0xFF)  {
	  lineptr++;  /* Drop the \r protection byte in this case */
	  continue;
	}
	reporterror(1,E_ERR,"Format code found outside of quote.",NULL);
	if (*(++lineptr)) lineptr++; /* Skip it */	
	*p++=' ';  /* Convert to whitespace */
	continue;
      }
      *(p++)=*(lineptr++);
    }
    *p=0;  /* Mark end of string */
  
    for(p=line;isspace(*p);p++);
    if (*p==0 && raw==0) 
      continue; /* Skip blank line: could occur if all that 
		   is on the line is a comment */

    line=rrealloc(line,strlen(line)+1);
    lineptr=line; /* Move lineptr to start of line */
    return 1;  /* If we reach here, we've read in a line */
  }  /* end of for(;;) loop */
}






