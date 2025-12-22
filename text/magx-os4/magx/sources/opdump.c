/*  opdump.c-- Program to output all of the metacommand tokens */
/* Copyright (C) 1996-1999,2001  Robert Masenten          */
/* This program may be redistributed under the terms of the
   GNU General Public License, version 2; see agility.h for details. */
/*                                                       */
/* This is part of the source for the Magx adventure game compiler */

/* This program simply dumps the contents of cond_def[] and act_def[]
     (both defined in agtdata.c) to stdout. */
/* This is only really of use to somebody trying to modify the
     interpreter or to understand the structure of the AGT game file. */
/* (AGT game authors could also use it to get a complete list of metacommand 
     tokens; be warned, however, that no single version of AGT supports all 
     of the listed tokens) */

#include <stdio.h>
#include <stdlib.h>

#define global
#include "agility.h"

#define SHORT_FORM 0
#define SGML 0
#define PRINT_NUMARGS 0

int i;

char tstr[][20]= {
  "Num","Flag","Q","Msg","Str","Cnt","Dir",
  "Subr","Pic","PIX","Font","Song","RmFlg","Time", 
  "StdMsg","ObjFlag","ObjProp","Exit","RmFlag/Pix",
  "ObjProp/Flag","LVal","Attr","Prop"
};

char obstr[][6]={"0","SELF","WORN","Room","Noun","Creat"};


/* These are just place holders */

descr_line *agt_read_descr(long start,long size)
{
  return NULL;
}

descr_line *agx_read_descr(long start,long size)
{
  return NULL;
}



void typeout(int arg)
{
  char prev;
  rbool wasvar; /* Is it a variable? */
  int i;

  if (arg&AGT_VAR) {
    printf("Var");
    wasvar=1;
    arg&=~AGT_VAR; /* Turn off variable bit. */
    if (arg==0) return; /* Untyped variable */
    printf("[");
  } else wasvar=0;

  if (arg>=128) printf(tstr[arg-128]);
  else if (arg==0) printf("???");
  else {
    prev=0;
    for(i=0;i<6;i++)
      if (arg&(1<<i)) {
	if (prev) printf("/");
	printf("%s",obstr[i]);
	prev=1;
      }
  }
  if (wasvar) printf("]");
}


void print_opcode(const opdef *p)
{
  if (!SHORT_FORM && PRINT_NUMARGS) printf("@%d  ",p->argnum);
  if (SGML) 
    printf("<funcdef/%s",p->opcode);
  else printf("%s",p->opcode);
  if (p->argnum>=1) 
    {
      if (!SHORT_FORM)
	printf("(");
      else if (SGML)
	printf(" <var/");
      else printf(" {");
      typeout(p->arg1);
      if (SGML) printf("/");
      if (p->argnum==2) {
	if (!SHORT_FORM) printf(",");
	else if (SGML)
	  printf(" <var/");
	else printf("} {");
	typeout(p->arg2);
	if (SGML) printf("/");
      }
      if (!SHORT_FORM) printf(")");
      else if (!SGML) printf("}");
    }
  if (SGML)
    printf("/");
  /*  if (SGML) printf("<index id=%s>",p->opcode);*/
  printf("\n");
}


int main(int argc,char *argv[])
{
  printf("CONDITIONS\n");
  for(i=0;i<=MAX_COND;i++) {
    if (!SHORT_FORM) printf(" %4d: ",i);
    print_opcode(cond_def+i);
  }
  printf("\n\nACTIONS\n");
  for(i=0;i<=PREWIN_ACT-START_ACT;i++) {
    if (!SHORT_FORM) printf(" %4d: ",i+1000);
    print_opcode(act_def+i);
  }
  for(i=0;i<=MAX_ACT-WIN_ACT;i++) {
    if (!SHORT_FORM) printf(" %4d: ",i+2000);
    print_opcode(end_def+i);
  }
  return 0;
}

