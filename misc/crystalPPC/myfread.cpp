
#include <clib/dos_protos.h>

long myfread(char *fname,char *ptr,long filesize)
{
   BPTR file=Open(fname,MODE_OLDFILE);
   if(file==0) return 1;
   LONG count=Read(file,ptr,filesize);
   if(count!=filesize) {Close(file);return 1;}
   Close(file);
   return 0;
}
