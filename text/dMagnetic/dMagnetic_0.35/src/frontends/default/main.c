/*

Copyright 2023, dettus@dettus.net

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation 
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


*/
//#define	EXPERIMENTAL_IFI
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "version.h"
#include "configuration.h"
#include "vm68k.h"
#include "linea.h"

#ifdef	EXPERIMENTAL_IFI
#include "ifi_callbacks.h"
#else
#include "default_callbacks.h"
#endif
#include "maggfxloader.h"
#include "helpscreens.h"
#include "pathnames.h"
#include "dMagnetic.h"
#define	MAXMAGSIZE	(1<<20)
#define	MAXGFXSIZE	(1<<22)

int init(int argc,char** argv,FILE *f_inifile,
int *pNodoc,
eBinType* pBinType,char* magfilename,char* gfxfilename,char* binfilename)
{
	
	int gamenamegiven;
	int retval;

	*pNodoc=0;
	*pBinType=BINTYPE_NONE;

	retval=0;
	magfilename[0]=gfxfilename[0]=binfilename[0]=0;
	gamenamegiven=0;
	if ((retrievefromcommandline(argc,argv,"pawn",NULL,0))
			|| (retrievefromcommandline(argc,argv,"guild",NULL,0))
			|| (retrievefromcommandline(argc,argv,"jinxter",NULL,0))
			|| (retrievefromcommandline(argc,argv,"corruption",NULL,0))
			|| (retrievefromcommandline(argc,argv,"fish",NULL,0))
			|| (retrievefromcommandline(argc,argv,"myth",NULL,0))
			|| (retrievefromcommandline(argc,argv,"wonderland",NULL,0))
			|| (retrievefromcommandline(argc,argv,"wonder",NULL,0)))
	{
		gamenamegiven=1;
	}
	if (!f_inifile && gamenamegiven) 
	{
		fprintf(stderr,"Game name was given, but no suitable .ini file found\n");
		fprintf(stderr,"please run %s -helpini for more help\n",argv[0]);
		return 1;
	}
	{
		int i;
		char* gameprefix[]={"pawn","guild","jinxter","corruption","fish","myth","wonderland","wonder"};
		char magname[32];
		char gfxname[32];
		char tworscname[32];
		char msdosname[32];
		char d64name[32];
		char amstradcpcname[32];
		char spectrumname[32];
		char archimedesname[32];
		char atarixlname[32];
		char appleiiname[32];

		for (i=0;i<8;i++)
		{
			snprintf(magname,32,"%smag",gameprefix[i]);
			snprintf(gfxname,32,"%sgfx",gameprefix[i]);
			snprintf(tworscname,32,"%stworsc",gameprefix[i]);
			snprintf(msdosname,32,"%smsdos",gameprefix[i]);
			snprintf(d64name,32,"%sd64",gameprefix[i]);
			snprintf(amstradcpcname,32,"%samstradcpc",gameprefix[i]);
			snprintf(spectrumname,32,"%sspectrum",gameprefix[i]);
			snprintf(archimedesname,32,"%sarchimedes",gameprefix[i]);
			snprintf(atarixlname,32,"%satarixl",gameprefix[i]);
			snprintf(appleiiname,32,"%sappleii",gameprefix[i]);

			if (retrievefromcommandline(argc,argv,gameprefix[i],NULL,0))
			{
				magfilename[0]=gfxfilename[0]=0;
				if (retrievefromini(f_inifile,"[FILES]",magname,magfilename,MAXFILENAMESIZE)&&
						retrievefromini(f_inifile,"[FILES]",gfxname,gfxfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_MAGGFX;
				}
				else if (retrievefromini(f_inifile,"[FILES]",tworscname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_TWORSC;
				}
				else if (retrievefromini(f_inifile,"[FILES]",msdosname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_MSDOS;
				}
				else if (retrievefromini(f_inifile,"[FILES]",d64name,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_D64;
				}
				else if (retrievefromini(f_inifile,"[FILES]",amstradcpcname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_AMSTRADCPC;
				}
				else if (retrievefromini(f_inifile,"[FILES]",spectrumname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_SPECTRUM;
				}
				else if (retrievefromini(f_inifile,"[FILES]",archimedesname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_ARCHIMEDES;
				}
				else if (retrievefromini(f_inifile,"[FILES]",atarixlname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_ATARIXL;
				}
				else if (retrievefromini(f_inifile,"[FILES]",appleiiname,binfilename,MAXFILENAMESIZE))
				{
					*pBinType=BINTYPE_APPLEII;
				}
			}
		}
	}
	if (retrievefromcommandline(argc,argv,"-mag",magfilename,MAXFILENAMESIZE))
	{
		gfxfilename[0]=0;
		binfilename[0]=0;
		*pBinType=BINTYPE_MAGGFX;
	}
	if (retrievefromcommandline(argc,argv,"-gfx",gfxfilename,MAXFILENAMESIZE))
	{
		binfilename[0]=0;
		*pBinType=BINTYPE_MAGGFX;
	}
	if (retrievefromcommandline(argc,argv,"-msdosdir",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_MSDOS;
	}
	if (retrievefromcommandline(argc,argv,"-tworsc",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_TWORSC;
	}
	if (retrievefromcommandline(argc,argv,"-d64",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_D64;
	}
	if (retrievefromcommandline(argc,argv,"-amstradcpc",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_AMSTRADCPC;
	}
	if (retrievefromcommandline(argc,argv,"-spectrum",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_SPECTRUM;
	}
	if (retrievefromcommandline(argc,argv,"-archimedes",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_ARCHIMEDES;
	}
	if (retrievefromcommandline(argc,argv,"-atarixl",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_ATARIXL;
	}
	if (retrievefromcommandline(argc,argv,"-appleii",binfilename,MAXFILENAMESIZE))
	{
		*pBinType=BINTYPE_APPLEII;
	}
	{
		char result[64];
		*pNodoc=0;
		if (retrievefromini(f_inifile,"[GAMEPLAY]","nodoc",result,sizeof(result)))
		{
			if (result[0]=='y' || result[0]=='Y') *pNodoc=1;	// "yes","Yes" --> 1. otherwise 0

		}
		if (retrievefromcommandline(argc,argv,"-nodoc",NULL,0))
		{
			*pNodoc=1;
		}
	}
	if (magfilename[0]==0 && gfxfilename[0]==0 && binfilename[0]==0) retval=-1;
	return retval;
}
int dumpmaggfx(int argc,char** argv,char* magbuf,int magsize,char* gfxbuf,int gfxsize)
{
	FILE *f;
	int finish;
	finish=0;
	char filename[MAXFILENAMESIZE];
	if (retrievefromcommandline(argc,argv,"-dumpmag",filename,MAXFILENAMESIZE))
	{
		finish=1;
		printf("Writing new .mag file [%s]\n",filename);
		f=fopen(filename,"wb");
		if (!f)
		{
			fprintf(stderr,"unable to open [%s]\n",filename);
		}
		fwrite(magbuf,sizeof(char),magsize,f);
		fclose(f);
	}
	if (retrievefromcommandline(argc,argv,"-dumpgfx",filename,MAXFILENAMESIZE))
	{
		finish=1;
		printf("Writing new .gfx file [%s]\n",filename);
		f=fopen(filename,"wb");
		if (!f)
		{
			fprintf(stderr,"unable to open [%s]\n",filename);
		}
		fwrite(gfxbuf,sizeof(char),gfxsize,f);
		fclose(f);
	}
	if (finish)
	{
		printf("finishing now\n");
		exit(0);
	}
	return 0;
}


int main(int argc,char** argv)
{
	int i;
	char inifilename[1024];
	int retval;
	FILE *f_inifile=NULL;

	void* hGUI;
	int sizeGUI;

	void *hEngine;
	char *homedir;
	char random_mode;
	unsigned int random_seed;
	int egamode;
	int dumppics;
	char* magbuf;	
	char* gfxbuf;


	eBinType binType;
	char magfilename[MAXFILENAMESIZE];
	char gfxfilename[MAXFILENAMESIZE];
	char binfilename[MAXFILENAMESIZE];
	int nodoc;
	int handlesize;

	


	// figure out the location of the inifile.
	if (!(retrievefromcommandline(argc,argv,"--version",NULL,0)))
	{
		helpscreens_header();
#define	LOCNUM	16
		const char *locations[LOCNUM]={
			PATH_ETC,
			PATH_USR_LOCAL_SHARE,
			PATH_USR_LOCAL_SHARE_GAMES,
			PATH_USR_LOCAL_SHARE"dMagnetic/",
			PATH_USR_LOCAL_SHARE_GAMES"dMagnetic/",
			PATH_USR_LOCAL_GAMES,
			PATH_USR_LOCAL_GAMES"dMagnetic/",
			PATH_USR_SHARE,
			PATH_USR_SHARE_GAMES,
			PATH_USR_SHARE_GAMES"dMagnetic/",
			PATH_USR_SHARE"dMagnetic/",
			PATH_USR_GAMES,
			PATH_USR_GAMES"dMagnetic/",
			PATH_USR_SHARE"doc/dmagnetic/",
			PATH_USR_PKG_SHARE"doc/dMagnetic/",
			"./"};	// this should always be the last one.

		f_inifile=NULL;
		if (f_inifile==NULL)
		{
			homedir=getenv("HOME");
			snprintf(inifilename,1023,"%s/dMagnetic.ini",homedir);
			f_inifile=fopen(inifilename,"rb");
		}
		if (f_inifile==NULL)
		{
			homedir=getenv("HOME");
			snprintf(inifilename,1023,"%s/.dMagnetic.ini",homedir);
			f_inifile=fopen(inifilename,"rb");
		}
		for (i=0;i<LOCNUM;i++)
		{
			if (f_inifile==NULL)
			{
				snprintf(inifilename,1023,"%sdMagnetic.ini",locations[i]);
				f_inifile=fopen(inifilename,"rb");
			}
		}

		if (f_inifile) 
		{
			fclose(f_inifile);
		}
	}	
	if (argc<2)
	{
		helpscreens_loaderfailed(argv[0]);
		return 1;
	}
	if ((retrievefromcommandline(argc,argv,"--version",NULL,0))
		|| (retrievefromcommandline(argc,argv,"-version",NULL,0))
		|| (retrievefromcommandline(argc,argv,"-v",NULL,0)))
	{
		printf("%d.%d%d\n",VERSION_MAJOR,VERSION_MINOR,VERSION_REVISION);
		return 0;
	}
	if (retrievefromcommandline(argc,argv,"-bsd",NULL,0))
	{
		helpscreens_license();
		return 0;


	}
	if ((retrievefromcommandline(argc,argv,"--help",NULL,0))
	||  (retrievefromcommandline(argc,argv,"-help",NULL,0)))
	{
		helpscreens_help(argv[0]);
		return 0;
	}
	if ((retrievefromcommandline(argc,argv,"--helpini",NULL,0))
	||  (retrievefromcommandline(argc,argv,"-helpini",NULL,0)))
	{
		helpscreens_helpini();
		return 0;
	}
	if (retrievefromcommandline(argc,argv,"-ini",inifilename,sizeof(inifilename))) 
	{
	}
	fprintf(stderr,"Using .ini file: %s\n",inifilename);		
	f_inifile=fopen(inifilename,"rb");
	retval=default_getsize(&sizeGUI);
	if (retval)
	{
		fprintf(stderr,"ERROR. default_getsize returned %d\n",retval);
		return 1;
	}
	hGUI=malloc(sizeGUI);
	if (hGUI==NULL)
	{
		fprintf(stderr,"ERROR: unable to locate memory for the GUI\n");
		return 1;
	}
	retval=default_open(hGUI,f_inifile,argc,argv);
	if (retval)
	{
		fprintf(stderr,"ERROR: opening the GUI failed\n");
		return 1;
	}
//////////////////////////////////////////////// random
	random_mode=0;
	random_seed=12345;
	if (f_inifile)
	{
		char result[64];

		if (retrievefromini(f_inifile,"[RANDOM]","mode",result,sizeof(result)))
		{
			if (result[0]=='p') random_mode=0;
			else if (result[0]=='r') random_mode=1;
			else {
				printf("illegal random mode in inifile. please use one of ");
				printf("pseudo ");
				printf("real ");
				return 1;
			}
		}
		if (retrievefromini(f_inifile,"[RANDOM]","seed",result,sizeof(result)))
		{
			random_seed=atoi(result);
			if (random_seed<1 || random_seed>0x7fffffff)
			{
				printf("illegal random seed. please use a value between %d and %d\n",1,0x7fffffff);
				return 1;
			}
		}
	}
		

	if (argc)
	{
		char result[64];
		if (retrievefromcommandline(argc,argv,"-rmode",result,sizeof(result)))
		{
			if (result[0]=='p') random_mode=0;
			else if (result[0]=='r') random_mode=1;
			else {
				printf("illegal parameter for -rmode. please use one of ");
				printf("pseudo ");
				printf("real ");
				printf("\n");
				return 1;
			}
		}
		if (retrievefromcommandline(argc,argv,"-rseed",result,sizeof(result)))
		{
			random_seed=atoi(result);
			if (random_seed<1 || random_seed>0x7fffffff)
			{
				printf("illegal parameter for -rseed. please use a value between %d and %d\n",1,0x7fffffff);
				return 1;
			}
		}
	}	
	egamode=0;
	if (f_inifile)
	{
		char result[64];
		if (retrievefromcommandline(argc,argv,"-ega",result,sizeof(result)))
		{
			egamode=1;
		}
	}

	dumppics=0;
	if (f_inifile)
	{
		char result[64];
		if (retrievefromcommandline(argc,argv,"-dumppics",result,sizeof(result)))
		{
			dumppics=1;
		}
	}


	if (f_inifile) fclose(f_inifile);
	magbuf=malloc(MAXMAGSIZE);
	gfxbuf=malloc(MAXGFXSIZE);
	if (magbuf==NULL || gfxbuf==NULL) 
	{
		fprintf(stderr,"ERROR: unable to allocate memory for the data files\n");
		return -1;
	}

	// this is the main loop.
	f_inifile=fopen(inifilename,"rb");
	if (init(argc,argv,f_inifile,&nodoc,&binType,magfilename,gfxfilename,binfilename))
	{
		helpscreens_loaderfailed(argv[0]);
		return 1;
	}
	retval=dMagnetic_getsize(&handlesize,64);
	hEngine=malloc(handlesize);
	default_setEngine(hGUI,hEngine);
	do
	{
		int magsize;
		int gfxsize;

		magsize=MAXMAGSIZE;
		gfxsize=MAXGFXSIZE;

		if (maggfxloader(magbuf,&magsize,gfxbuf,&gfxsize,nodoc,binType,magfilename,gfxfilename,binfilename))	// reload everything.
		{
			helpscreens_loaderfailed(argv[0]);
			return 1;
		}
		if (dumpmaggfx(argc,argv,magbuf,magsize,gfxbuf,gfxsize))	// this needs to be called after the magbuffer and gfx buffer have been filled
		{
			helpscreens_loaderfailed(argv[0]);
			return 1;
		}

		dMagnetic_init(hEngine,64,magbuf,magsize,gfxbuf,gfxsize);	// the buffer have been filled. 
	
		if (dumppics)
		{
			retval=dMagnetic_dumppics(hEngine);
			return retval;
		}
		
		retval=0;
		// configure after the reinit
		retval|=dMagnetic_configrandom(hEngine,random_mode,random_seed);	
		retval|=dMagnetic_setEGAMode(hEngine,egamode);				
		// set the call back hooks for this GUI

		retval|=dMagnetic_setCBoutputChar(hEngine,default_cbOutputChar,	hGUI);
		retval|=dMagnetic_setCBoutputString(hEngine,default_cbOutputString,	hGUI);
		retval|=dMagnetic_setCBinputString(hEngine,default_cbInputString,	hGUI);
		retval|=dMagnetic_setCBDrawPicture(hEngine,default_cbDrawPicture,	hGUI);
		retval|=dMagnetic_setCBLoadGame(hEngine,default_cbLoadGame,		hGUI);
		retval|=dMagnetic_setCBSaveGame(hEngine,default_cbSaveGame,		hGUI);

		if (retval)
		{
			fprintf(stderr,"ERROR: setting the API hooks failed\n");
			return 1;
		}

		// final warning! ;) 
		{
			int version;
			retval=dMagnetic_getGameVersion(hEngine,&version);
			if (version==4)
			{
				fprintf(stderr,"\n");
				fprintf(stderr,"---------------------------------------\n");
				fprintf(stderr,"- Version 4 of the VM requires you to -\n");
				fprintf(stderr,"- activate the graphics manually. Use -\n");
				fprintf(stderr,"- the command       GRAPHICS      now -\n");
				fprintf(stderr,"---------------------------------------\n");
				fprintf(stderr,"\n");
			}
		}

		// here we go!
		retval=dMagnetic_run(hEngine);
		if (retval==DMAGNETIC_NOK_UNKNOWN_INSTRUCTION)
		{
			unsigned int aregs[8];
			unsigned int dregs[8];
			unsigned int pcr;
			unsigned int sr;
			unsigned short lastOpcode;
			int i;


			dMagnetic_getVMstate(hEngine,aregs,dregs,&pcr,&sr,&lastOpcode);
			fprintf(stderr,"Unknown opcode %04X \n",((unsigned int)lastOpcode)&0xffff);
			fprintf(stderr,"PCR=0x%08X SR=0x%X %c%c%c%c%c\n",pcr,sr,
				(sr&0x10)?'X':'x',
				(sr&0x08)?'N':'n',
				(sr&0x04)?'Z':'z',
				(sr&0x02)?'V':'v',
				(sr&0x01)?'C':'c'
				);//cvznx
			for (i=0;i<8;i++)
			{
				fprintf(stderr,"A%d=0x%08X  D%d=0x%08X\n",i,aregs[i],i,dregs[i]);
			}
		}


	} while (retval==LINEA_OK_RESTART);
	free(hEngine);
	free(gfxbuf);
	free(magbuf);
	// this concludes the main loop

	free(hGUI);
	return 0;
}
