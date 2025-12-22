/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/main/mission.c,v $
 * $Revision: 1.3 $
 * $Author: tfrieden $
 * $Date: 1998/04/03 14:00:59 $
 * 
 * Code to handle multiple missions
 * 
 * $Log: mission.c,v $
 * Revision 1.3  1998/04/03 14:00:59  tfrieden
 * Now supports *.MSN AND *.msn
 *
 * Revision 1.2  1998/04/02 13:44:11  tfrieden
 * Now also reads *.MSN files
 *
 * Revision 1.1.1.1  1998/03/03 15:12:24  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:59  hfrieden
 * Initial Import
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: mission.c,v 1.3 1998/04/03 14:00:59 tfrieden Exp $";
#pragma on (unreferenced)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <glob.h>

#include "cfile.h"

#include "inferno.h"
#include "mission.h"
#include "gameseq.h"
#include "titles.h"
#include "mono.h"
#include "error.h"

mle Mission_list[MAX_MISSIONS];

int Current_mission_num;
char *Current_mission_filename,*Current_mission_longname;

//this stuff should get defined elsewhere

char Level_names[MAX_LEVELS_PER_MISSION][13];
char Secret_level_names[MAX_SECRET_LEVELS_PER_MISSION][13];

//strips damn newline from end of line
char *mfgets(char *s,int n,FILE *f)
{
	char *r;

	r = fgets(s,n,f);
	if (r && s[strlen(s)-1] == '\n')
		s[strlen(s)-1] = 0;

	return r;
}

//compare a string for a token. returns true if match
int istok(char *buf,char *tok)
{
	return strnicmp(buf,tok,strlen(tok)) == 0;

}

//adds a terminating 0 after a string at the first white space
add_term(char *s)
{
	while (*s && !isspace(*s)) s++;

	*s = 0;     //terminate!
}

//returns ptr to string after '=' & white space, or NULL if no '='
//adds 0 after parm at first white space
char *get_value(char *buf)
{
	char *t;

	t = strchr(buf,'=')+1;

	if (t) {
		while (*t && isspace(*t)) t++;

		if (*t)
			return t;
	}

	return NULL;        //error!
}

//reads a line, returns ptr to value of passed parm.  returns NULL if none
char *get_parm_value(char *parm,FILE *f)
{
	static char buf[80];
	
	if (!mfgets(buf,80,f))
		return NULL;

	if (istok(buf,parm))
		return get_value(buf);
	else
		return NULL;
}

ml_sort_func(mle *e0,mle *e1)
{
	return strcmp(e0->mission_name,e1->mission_name);

}


//fills in the global list of missions.  Returns the number of missions
//in the list.  If anarchy_mode set, don't include non-anarchy levels.
//if there is only one mission, this function will call load_mission on it.
int build_mission_list(int anarchy_mode)
{
	int count=0;
	glob_t glob_ret;
	// struct find_t find;

	//fill in built-in level

#ifndef DEST_SAT
		strcpy(Mission_list[0].filename,"");        //no filename for builtin
		strcpy(Mission_list[0].mission_name,"Descent: First Strike");
		count = 1;
#endif


	//now search for levels on disk
	glob_ret.gl_offs=0; 
	if (   !glob("*.[mM][sS][nN]",0,NULL,&glob_ret)
		&& glob_ret.gl_pathc) {
		int j;
		for (j=0;j<glob_ret.gl_pathc&&count<MAX_MISSIONS;j++) {
			FILE *mfile;
			int is_anarchy;
			char temp[13],*t;

			strcpy(temp,glob_ret.gl_pathv[j]);
			if ((t = strchr(temp,'.')) == NULL)
				continue;
			*t = 0;         //kill extension

			strncpy( Mission_list[count].filename, temp, 9 );
			Mission_list[count].anarchy_only_flag = is_anarchy = 0;

			mfile = fopen(glob_ret.gl_pathv[j],"rt");

			if (mfile) {
				char *p;

				p = get_parm_value("name",mfile);

				if (p) {
					char *t;
					if ((t=strchr(p,';'))!=NULL)
						*t=0;
					t = p + strlen(p)-1;
					while (isspace(*t)) t--;
					strncpy(Mission_list[count].mission_name,p,MISSION_NAME_LEN);
				}
				else {
					fclose(mfile);
					continue;           //abort this mission file
				}

				p = get_parm_value("type",mfile);

				//get mission type 
				if (p)
					Mission_list[count].anarchy_only_flag = is_anarchy = istok(p,"anarchy");

				fclose(mfile);

				if (!anarchy_mode && is_anarchy)
					continue;       //skip this mission

				count++;
			}

		}
	}

#ifdef USE_CD
	if ( strlen(destsat_cdpath) )   {
		int i;
		char temp_spec[128];
		strcpy( temp_spec, destsat_cdpath );
		strcat( temp_spec, "*.MSN" );
		if( !_dos_findfirst( temp_spec, 0, &find ) )    {
			do  {
				FILE *mfile;
				int is_anarchy;
				char temp[13],*t;
	
				strcpy(temp,find.name);
				if ((t = strchr(temp,'.')) == NULL)
					continue;
				*t = 0;         //kill extension

				for (i=0; i<count; i++ )    {
					if (!stricmp( Mission_list[i].filename, temp))
						break;
				}
				if ( i < count ) continue;      // Don't use same mission twice!
		
				strncpy( Mission_list[count].filename, temp, 9 );
				Mission_list[count].anarchy_only_flag = is_anarchy = 0;
	
				mfile = fopen(find.name,"rt");
				if (!mfile) {
					strcpy( temp_spec, destsat_cdpath );
					strcat( temp_spec, find.name );
					mfile = fopen(temp_spec,"rt");
				}
				if (mfile) {
					char *p;
	
					p = get_parm_value("name",mfile);
	
					if (p) {
						char *t;
						if ((t=strchr(p,';'))!=NULL)
							*t=0;
						t = p + strlen(p)-1;
						while (isspace(*t)) t--;
						strncpy(Mission_list[count].mission_name,p,MISSION_NAME_LEN);
					}
					else {
						fclose(mfile);
						continue;           //abort this mission file
					}
	
					p = get_parm_value("type",mfile);
	
					//get mission type 
					if (p)
						Mission_list[count].anarchy_only_flag = is_anarchy = istok(p,"anarchy");
	
					fclose(mfile);
	
					if (!anarchy_mode && is_anarchy)
						continue;       //skip this mission
	
					count++;
				}
	
			} while( !_dos_findnext( &find ) && count<MAX_MISSIONS);
		}
	}
#endif

	if (count>1)
		qsort(&Mission_list[1],count-1,sizeof(*Mission_list),ml_sort_func);

	load_mission(0);            //set built-in mission as default

	return count;
}

//values for built-in mission

#define BIM_LAST_LEVEL          27
#define BIM_LAST_SECRET_LEVEL   -3
#define BIM_BRIEFING_FILE       "briefing.tex"
#define BIM_ENDING_FILE         "endreg.tex"

//loads the specfied mission from the mission list.  build_mission_list()
//must have been called.  If build_mission_list() returns 0, this function
//does not need to be called.  Returns true if mission loaded ok, else false.
int load_mission(int mission_num)
{
	Current_mission_num = mission_num;

	mprintf(( 0, "Loading mission %d\n", mission_num ));

#ifndef DEST_SAT
	if (mission_num == 0) {     //built-in mission
		int i;

#ifdef ROCKWELL_CODE
		Last_level = 7;
		Last_secret_level = 0;

		//build level names
		for (i=0;i<Last_level;i++)
			sprintf(Level_names[i], "LEVEL%02d.RDL", i+1);
#else
		Last_level = BIM_LAST_LEVEL;
		Last_secret_level = BIM_LAST_SECRET_LEVEL;

		//build level names
		for (i=0;i<Last_level;i++)
			sprintf(Level_names[i], "LEVEL%02d.RDL", i+1);
		for (i=0;i<-Last_secret_level;i++)
			sprintf(Secret_level_names[i], "LEVELS%1d.RDL", i+1);

		Secret_level_table[0] = 10;
		Secret_level_table[1] = 21;
		Secret_level_table[2] = 24;
#endif
		strcpy(Briefing_text_filename,BIM_BRIEFING_FILE);
		strcpy(Ending_text_filename,BIM_ENDING_FILE);
		cfile_use_alternate_hogfile(NULL);      //disable alternate
	} else 
#endif
	{        //NOTE LINK TO ABOVE IF!!!!!
			//read mission from file 
		FILE *mfile;
		char buf[80], tmp[80], *v;

		strcpy(buf,Mission_list[mission_num].filename);
		strcat(buf,".MSN");

		strcpy(tmp,Mission_list[mission_num].filename);
		strcat(tmp,".HOG");
		cfile_use_alternate_hogfile(tmp);

		mfile = fopen(buf,"rt");
#ifdef USE_CD
		if (mfile == NULL) {
			if ( strlen(destsat_cdpath) )   {
				char temp_spec[128];
				strcpy( temp_spec, destsat_cdpath );
				strcat( temp_spec, buf );
				mfile = fopen( temp_spec, "rt" );
			}
		}
#endif
		if (mfile == NULL) {
			Current_mission_num = -1;
			return 0;       //error!
		}

		//init vars
		Last_level =        0;
		Last_secret_level = 0;
		Briefing_text_filename[0] = 0;
		Ending_text_filename[0] = 0;
	
#ifdef DEST_SAT
		if (!stricmp(Mission_list[mission_num].filename, "DESTSAT")) {      //  Destination Saturn.
			strcpy(Briefing_text_filename,"briefsat.tex");
			strcpy(Ending_text_filename,"endsat.tex");
		}
#endif

		while (mfgets(buf,80,mfile)) {

			if (istok(buf,"name"))
				continue;                       //already have name, go to next line
			else if (istok(buf,"type"))
				continue;                       //already have name, go to next line                
			else if (istok(buf,"hog")) {
				char    *bufp = buf;

				while (*(bufp++) != '=')
					;

				if (*bufp == ' ')
					while (*(++bufp) == ' ')
						;

				cfile_use_alternate_hogfile(bufp);
				mprintf((0, "Hog file override = [%s]\n", bufp));
			} else if (istok(buf,"briefing")) {
				if ((v = get_value(buf)) != NULL) {
					add_term(v);
					if (strlen(v) < 13)
						strcpy(Briefing_text_filename,v);
				}
			}
			else if (istok(buf,"ending")) {
				if ((v = get_value(buf)) != NULL) {
					add_term(v);
					if (strlen(v) < 13)
						strcpy(Ending_text_filename,v);
				}
			}
			else if (istok(buf,"num_levels")) {

				if ((v=get_value(buf))!=NULL) {
					int n_levels,i;

					n_levels = atoi(v);

					for (i=0;i<n_levels && mfgets(buf,80,mfile);i++) {

						add_term(buf);
						if (strlen(buf) <= 12) {
							strcpy(Level_names[i],buf);
							Last_level++;
						}
						else
							break;
					}

				}
			}
			else if (istok(buf,"num_secrets")) {
				if ((v=get_value(buf))!=NULL) {
					int n_secret_levels,i;

					n_secret_levels = atoi(v);

					for (i=0;i<n_secret_levels && mfgets(buf,80,mfile);i++) {
						char *t;

						
						if ((t=strchr(buf,','))!=NULL) *t++=0;
						else
							break;

						add_term(buf);
						if (strlen(buf) <= 12) {
							strcpy(Secret_level_names[i],buf);
							Secret_level_table[i] = atoi(t);
							if (Secret_level_table[i]<1 || Secret_level_table[i]>Last_level)
								break;
							Last_secret_level--;
						}
						else
							break;
					}

				}
			}

		}

		fclose(mfile);

		if (Last_level <= 0) {
			Current_mission_num = -1;       //no valid mission loaded 
			return 0;
		}
	}

	Current_mission_filename = Mission_list[Current_mission_num].filename;
	Current_mission_longname = Mission_list[Current_mission_num].mission_name;

	return 1;
}

//loads the named mission if exists.
//Returns true if mission loaded ok, else false.
int load_mission_by_name(char *mission_name)
{
	int n,i;

	n = build_mission_list(1);

	for (i=0;i<n;i++)
		if (!stricmp(mission_name,Mission_list[i].filename))
			return load_mission(i);

	return 0;       //couldn't find mission
}

