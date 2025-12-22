/*  compstub.c-- Stubs for routines defined in agil but   */
/*    refered to elsewhere.                               */
/*  This also contains some os-dependent things           */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */
/*
  Aside from stubs for the various output functions,
  and a few other things expected by the AGT/AGX core, this 
  contains reporterror(). 
  */ 

extern void patch_08(void);

#include <ctype.h>

#include "agility.h"
#include "comp.h"


#ifdef force16
#undef int
#endif

#ifdef UNIX_IO
#include <fcntl.h>
#ifdef MSDOS
#include <io.h>
#endif
#endif

#ifdef force16
#define int short
#endif


void debugout(const char *s)
{
  fputs(s,stdout);
}

void writestr(const char *s)
{
  fputs(s,stdout);
}

void writeln(const char *s)
{
  printf("%s\n",s);
}

void agil_option(int optnum,char *optstr[], rbool setflag, rbool lastpass)
{
  /* By only complaining during the first pass, we can avoid giving
     this error message when parsing <gamename>.CFG file (which
     may legitimatly contain platform specific options) */
  reporterror(1,E_WARN,"Unrecognized configuration option.",
	      optstr[0]);
}

void close_interface(void)
{
}

descr_line *agt_read_descr(long start,long len)
{
  return NULL;
}

/* #define DEBUG_ERROR*/


static char *srcname;  /* File context of current source file */

static char * errhead[]={"Note","Warning","Error","Fatal Error"};

/* epass: pass to report the error on (but fatal errors are
 always reported) */
void reporterror(int epass,int elev, const char *fmt, const char *s)
{
  FILE *efile;

  if (err_to_stdout) efile=stdout;
  else efile=stderr;

  /* if (elev==E_NOTE) return;*/
#ifndef DEBUG_ERROR
  if (epass!=pass && elev!=E_FATAL) return;
#endif
  e_cnt[elev]++;
  if (srcname!=NULL)
    fprintf(efile,"%s in %s line %ld: ",errhead[elev], srcname, lineno);
  else fprintf(efile,"%s: ",errhead[elev]);
  fprintf(efile,fmt,s); fprintf(efile,"\n");
  if (litline!=NULL) fprintf(efile," >> %s\n",litline);
  if (elev==E_FATAL) {
    if (opened_agx) 
      agx_wabort();
    exit(EXIT_FAILURE);
  }
}


/* ------------------------------------------------------------------- */
/* File I/O Routines 0:  Input Buffering                               */
/* ------------------------------------------------------------------- */
/* These routines manage the multiple levels of include files and 
   could be rewritten to do file buffering.  I haven't done it because 
   it doesn't make sense for either of the ports I maintain personally:
   Unix already does sufficient buffering at the library and OS level and
   DOS (which _would_ benefit from buffering) can't afford the memory. */

typedef struct {
  genfile f;  /* The file */
  int lineno;  /* Line number position in the file. */
  char *name;  /* Reference name of file */
  fc_type fc;  /* File context associated with file. */
#ifndef OPEN_AS_TEXT
  uchar *buff;  /* Associated buffer and its related variables */
  int bp; 
  long buffend;
#endif
} filerec;


static int fileptr=0; 
/* static genfile *filestack=NULL; */
static filerec filestack[FILE_DEPTH];
static genfile currfile;

#ifndef OPEN_AS_TEXT
static uchar *filebuff;
static int bp;
static long buffend;
#endif

rbool pushfile(fc_type fc, filetype ext)
{
  genfile f;
  char *errstr;

  if (fileptr>=FILE_DEPTH) 
    reporterror(1,E_FATAL,"Too many nested include files.",NULL);
  if (fileptr>0) { /* Save old state */
    filestack[fileptr-1].lineno=lineno;
#ifndef OPEN_AS_TEXT
    filestack[fileptr-1].bp=bp;
    filestack[fileptr-1].buffend=buffend;
#endif    
  }
  f=readopen(fc,ext,&errstr);
  rfree(errstr);
  if (!filevalid(f,ext))
    return 0;
  fileptr++;
  /*  filestack=rrealloc(filestack,fileptr*sizeof(filerec));*/
  currfile=filestack[fileptr-1].f=f;
  srcname=filestack[fileptr-1].name=formal_name(fc,ext);
  filestack[fileptr-1].fc=fc;
#ifndef OPEN_AS_TEXT
  bp=INBUFF_SIZE-1;
  filebuff=filestack[fileptr-1].buff=rmalloc(INBUFF_SIZE);
  buffend=INBUFF_SIZE;
#endif
  lineno=0;
  return 1;
}


/* Return true if there is another file below the one we just popped */
/* This automatically frees the associated file context unless
   it is the last entry on the stack. */
rbool popfile(void)
{
  if (fileptr==0) fatal("INTERNAL ERROR: File stack underflow.");
  readclose(currfile);
  rfree(srcname);
#ifndef OPEN_AS_TEXT
  rfree(filebuff);
#endif
  fileptr--;
  /* filestack=rrealloc(filestack,fileptr*sizeof(srcfile)); */
  if (fileptr==0) 
    return 0;
  rfree(filestack[fileptr].fc); /* _only_ if fileptr>0 */
  currfile=filestack[fileptr-1].f;
  srcname=filestack[fileptr-1].name;
  lineno=filestack[fileptr-1].lineno;
#ifndef OPEN_AS_TEXT
  bp=filestack[fileptr-1].bp;
  buffend=filestack[fileptr-1].buffend;
  filebuff=filestack[fileptr-1].buff;
#endif
  return 1;
}


#ifndef OPEN_AS_TEXT

int nextchar(void)
{
  char *errstr;
  bp++;
  if (bp==buffend) {
    bp=0;
    buffend=varread(currfile,filebuff,1,INBUFF_SIZE,&errstr);
    rfree(errstr);
    if (buffend==0 || buffend==-1) {
      bp=-1;
      return EOF;
    }
  }
  return filebuff[bp];
}

/* If the next character in the stream is c, it is skipped over.
   Otherwise, do nothing. */
void killchar(uchar c)
{
  uchar newc;
  newc=nextchar();
  if (newc==c) return; /* ...skipping that character */
  bp--;  /* Back up */
}

/* This marks the end of file with character c.
   (The next character read should be c; no other characters 
   will be read.) */
void markeof(uchar c)
{
  bp=-1;buffend=1;
  filebuff[0]=c;
  return;
}






#else /* OPEN_AS_TEXT case */
/* See above for documentation of these functions */
int nextchar(void)
{
  return textgetc(currfile);
}
void killchar(uchar c)
{
  char newc;
  newc=textgetc(currfile);
  if (newc!=c) textungetc(currfile,newc);
}
void markeof(uchar c)
{
  textungetc(currfile,c); /* This does more than needed. */
}
#endif


/* ------------------------------------------------------------------- */
/* Program startup and command-line parsing                            */
/* ------------------------------------------------------------------- */

static rbool end_cmd_options;
static fc_type out_fc; /* Name of output file */


static void helpmsg(void)
{
  rprintf("Syntax: magx <options> <game name>\n");
  rprintf("Options:\n");
  rprintf("(most of these can be turned off by putting a - after the "
	 "option)\n");
  rprintf("-h  Print this help message.\n");
  rprintf("-o <filename>  Specify base name for output file.\n");
  rprintf("-d Compile with debugging enabled.\n"); 
  rprintf("-e Send error messages to stderr instead of stdout.\n");
#if 0
  rprintf("-s Dump symbol table after first pass.\n");
  rprintf("-k Report keyword hash collision\n");
  rprintf("\n");
  rprintf("-m Create AGiliTy 0.8 compatible files.\n");
  rprintf("    (Use only if absolutely neccessary; this disables some\n");
  rprintf("    features.)\n");
#endif
}


static rbool setarg(char **optptr)
{
  if ( (*optptr)[1]=='+') {(*optptr)++;return 1;}
  if ( (*optptr)[1]=='-') {(*optptr)++;return 0;}
  return 1;
}

int parse_options(char *opt,char *next)
{
  if (opt[0]=='-' && opt[1]==0)   /* -- */
    {end_cmd_options=1;return 0;}
  for(;*opt!=0;opt++)
    switch(tolower(*opt))
      {
      case '?': case 'h':
	helpmsg();
	exit(0);
      case 'd': debug_mode=setarg(&opt);break;
      case 'k': REPORT_COLLISION=setarg(&opt);break;
      case 's': sym_dumpflag=setarg(&opt);break;
      case 'e': err_to_stdout=!setarg(&opt);break;
      case 'i': DIAG=setarg(&opt);break;
      case 'o':
	if (opt[1]!=0 || next!=NULL) {
	  if (opt[1]!=0) out_fc=init_file_context(opt+1,fAGX);
	  else out_fc=init_file_context(next,fAGX);
	  return (opt[1]==0); /* Skip next argument if opt[1]==0 */
	} else {
	  rprintf("-o requires a file name\n");
	  exit(EXIT_FAILURE);
	} 
      case 'm': patch_08(); break;
      default:rprintf("Do not recognize option %c\n",*opt);
	helpmsg();
	exit(EXIT_FAILURE);
      }
  return 0;
}

int main(int argc,char *argv[])
{
  int i;
  fc_type fc;

  rprintf("Magx: Make AGX, an AGT-Compatible Adventure Game Compiler\n");
  rprintf("Version 0.6.5 (beta)\n");
  rprintf("  Copyright 1996-99,2001 Robert Masenten\n");
  rprintf("[%s]\n",portstr);
  writeln("");

  end_cmd_options=0;
  set_defaults();

  /* Parse command line for options and to get the file names */
  out_fc=fc=NULL;
  for(i=1;i<argc;i++)
    if (argv[i][0]=='-' && !end_cmd_options)
      i+=parse_options(argv[i]+1,argv[i+1]);
    else if (fc==NULL)
      fc=init_file_context(argv[i],fAGT);
    else {helpmsg();exit(1);}
  if (fc==NULL)
    {helpmsg();exit(1);}
  if (out_fc==NULL)
    out_fc=convert_file_context(fc,fAGX,NULL); 
  /* By default use gamefile name for output name */

  compile_game(fc,out_fc);

  return EXIT_SUCCESS;
}


