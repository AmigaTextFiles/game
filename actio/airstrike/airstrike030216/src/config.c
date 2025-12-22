#include <string.h>
#include <stdlib.h>
#include <SDL.h>
#include "config.h"
#include "names.h"

static struct names *config_user = 0;
static char *datapath;

int config_setup()
{
FILE *cfile;
char cbuf[1024]; /* stupid, really */
int got_file = 0;
   
datapath="data/";
got_file = 1;
return 0;
}

float cfgnum(char *name, float defaul)
{
FILE *fp;
float f;

if( ( fp = fopen( "PROGDIR:airstrikerc","r" ) ) != NULL){
  char buffer[1000];
  while( EOF != fscanf( fp, "%s", buffer ) ){
  if( 0 == strcmp( name, buffer ) ){
    if( EOF == fscanf( fp, "%f", &f ) ) break;
    }
  if( buffer[0] == '#' ) fgets( buffer, 1000, fp );
  }

  fclose( fp );
}else{
  f=defaul;
  }

  return f;
}

char *cfgstr(char *name, char *defaul)
{
  char *s = (char *) nget(config_user,name);
  if (s)
    return s;
  else
    return defaul;
}

char *path_to_data(char *file)
{
  static char path[512];
  sprintf(path,"%s/%s",datapath,file);
  return path;
}
