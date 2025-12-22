/*
  Block Rage - the arcade game
  Copyright (C) 1999-2005 Jiri Svoboda

  This file is part of Block Rage.

  Block Rage is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  Block Rage is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Block Rage; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

  Jiri Svoboda
  jirik.svoboda@seznam.cz
*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include "global.h"
#include "main.h"

long fload_len;
int file_error;

/* adds a trailing slash to a path string, if not present */
void add_trailing_slash(char *s) {
  if(s[strlen(s)-1]!='/') strcat(s,"/");
}

void cat_with_slash(char *buf, char *file) {
  add_trailing_slash(buf);
  strcat(buf,file);
}

FILE *file_open(char *name, char *mode) {
  char fname[200];
 
  strcpy(fname,datadir);
  cat_with_slash(fname,dataset);
  cat_with_slash(fname,name);
  
  return fopen(fname,mode);
}


unsigned char *file_load(char *name) {
  FILE *f;
  struct stat buf;
  unsigned char *tmp;
  char fname[200];
 
  strcpy(fname,datadir);
  cat_with_slash(fname,dataset);
  cat_with_slash(fname,name);
  
  if(stat(fname,&buf)!=0) {
    fprintf(stderr,"blockrage/file_load: file %s not found\n",fname);
    return NULL;
  }
  tmp=malloc(buf.st_size);
  if(tmp==NULL) return NULL;
  
  f=fopen(fname,"rb");
  if(f==NULL) return NULL;
  fread(tmp,1,buf.st_size,f);
  fload_len=buf.st_size;
  fclose(f);
  
  return tmp;
}

unsigned fget_u8(FILE *f) {
  unsigned char res;
  
  file_error = file_error | (fread(&res,1,1,f)<1);
  return res;
}

unsigned fget_u16l(FILE *f) {
  unsigned res;
  
  res = fget_u8(f);
  res = res | (fget_u8(f)<<8);
  return res;
}

void fput_u8(FILE *f, unsigned val) {
  unsigned char tmp;
  
  tmp = val;
  file_error = file_error | (fwrite(&tmp,1,1,f)<1);
}

void fput_u16l(FILE *f, unsigned val) {
  fput_u8(f,val&0xff);
  fput_u8(f,val>>8);
}
