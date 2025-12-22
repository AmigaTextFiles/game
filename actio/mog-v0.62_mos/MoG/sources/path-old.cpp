#ifdef _WIN32
#include "windows.h"
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* Paths: */ 

extern char **g_paths;
extern int n_g_paths,act_g_path;
extern char *g_path;
extern char **s_paths;
extern int n_s_paths,act_s_path;
extern char *s_path;


#ifdef _WIN32
void init_paths(void)
{

	if (g_paths==NULL) {

		WIN32_FIND_DATA finfo;
		HANDLE h;
		int i,j;
		char **tmp_g_paths; 

		n_g_paths=0;
		h=FindFirstFile("graphics\\*.*",&finfo);
		if (h!=INVALID_HANDLE_VALUE) {
			if (strcmp(finfo.cFileName,".")!=0 &&
				strcmp(finfo.cFileName,"..")!=0) {
				i=0;
				n_g_paths=1;
				g_paths=new char *[1];
				g_paths[i]=new char[256];
				sprintf(g_paths[i++],"graphics\\%s\\",strupr(finfo.cFileName));
			} /* if */ 

			while(FindNextFile(h,&finfo)==TRUE) {

				if (strcmp(finfo.cFileName,".")!=0 &&
					strcmp(finfo.cFileName,"..")!=0) {
					if (n_g_paths==0) {
						i=0;
						n_g_paths=1;
						g_paths=new char *[1];
						g_paths[i]=new char[256];
						sprintf(g_paths[i++],"graphics\\%s\\",strupr(finfo.cFileName));
					} else {
						tmp_g_paths=g_paths;
						n_g_paths++;
						g_paths=new char *[i+1];
						for(j=0;j<i;j++) {
							g_paths[j]=tmp_g_paths[j];
						} /* for */ 
						delete tmp_g_paths;
						g_paths[i]=new char[256];
						sprintf(g_paths[i++],"graphics\\%s\\",strupr(finfo.cFileName));
					} /* if */ 
				} /* if */ 
			} /* while */ 
		} else {
			g_paths=new char *[2];
			g_paths[0]=new char[256];
			g_paths[1]=new char[256];
			strcpy(g_paths[0],"graphics\\original\\");
			strcpy(g_paths[1],"graphics\\alternate\\");
		} /* if */ 

		act_g_path=0;
		g_path=g_paths[act_g_path];

	} /* if */ 


	if (s_paths==NULL) {

		WIN32_FIND_DATA finfo;
		HANDLE h;
		int i,j;
		char **tmp_s_paths; 

		n_s_paths=0;
		h=FindFirstFile("sound\\*.*",&finfo);
		if (h!=INVALID_HANDLE_VALUE) {
			if (strcmp(finfo.cFileName,".")!=0 &&
				strcmp(finfo.cFileName,"..")!=0) {
				i=0;
				n_s_paths=1;
				s_paths=new char *[1];
				s_paths[i]=new char[256];
				sprintf(s_paths[i++],"sound\\%s\\",strupr(finfo.cFileName));
			} /* if */ 

			while(FindNextFile(h,&finfo)==TRUE) {

				if (strcmp(finfo.cFileName,".")!=0 &&
					strcmp(finfo.cFileName,"..")!=0) {
					if (n_s_paths==0) {
						i=0;
						n_s_paths=1;
						s_paths=new char *[1];
						s_paths[i]=new char[256];
						sprintf(s_paths[i++],"sound\\%s\\",strupr(finfo.cFileName));
					} else {
						tmp_s_paths=s_paths;
						n_s_paths++;
						s_paths=new char *[i+1];
						for(j=0;j<i;j++) {
							s_paths[j]=tmp_s_paths[j];
						} /* for */ 
						delete tmp_s_paths;
						s_paths[i]=new char[256];
						sprintf(s_paths[i++],"sound\\%s\\",strupr(finfo.cFileName));
					} /* if */ 
				} /* if */ 
			} /* while */ 
		} else {
			s_paths=new char *[2];
			s_paths[0]=new char[256];
			s_paths[1]=new char[256];
			strcpy(s_paths[0],"sound\\original\\");
			strcpy(s_paths[1],"sound\\alternate\\");
		} /* if */ 

		act_s_path=0;
		s_path=s_paths[act_s_path];
	} /* if */ 
} /* init_paths */ 
#else
void init_paths(void)
{
	if (g_paths == NULL)
	{
		g_paths=new char *[2];
		g_paths[0]=new char[256];
		g_paths[1]=new char[256];
		strcpy(g_paths[0],"graphics/original/");
		strcpy(g_paths[1],"graphics/alternate/");
		n_g_paths=2;
		s_paths=new char *[2];
		s_paths[0]=new char[256];
		s_paths[1]=new char[256];
		strcpy(s_paths[0],"sound/original/");
		strcpy(s_paths[1],"sound/alternate/");
		n_s_paths=2;
		act_g_path=0;
		g_path=g_paths[act_g_path];
		act_s_path=0;
		s_path=s_paths[act_s_path];
	}
}
#endif
