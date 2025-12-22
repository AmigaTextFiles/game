#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

#define UWORD unsigned short int

#define HISBETTER 0
#define YOUBETTER 1
#define THESAME   2

#define TRACKSNUMBER 12

struct timeS
	{
	 char name[32];
         char player[4];
	 UWORD time;
	};

struct  timeS time1;
struct  timeS time2;
int CheckTime(int m,int s,int ss,int m1,int s1,int ss1);

void main(int argc,char **argv)
{
int i,a,b;
FILE *fp;
FILE *fp1;
char tmpS[255];
int same=0;

printf("XtremeRacing LapTime Viewer\n");
printf("Written by Sebastian Jedruszkiewicz (B.J.Sebo / Venus Art)\n");
  if(argc<2)
    {
  	printf("No parametters\n");
  	printf("Usage: XTRTimes '.mylaptimes' <.otherlaptime>\n");
	exit(0);
    }

  if(argc>2)
   {
    fp=fopen(argv[1],"rb");
    fp1=fopen(argv[2],"rb");
        printf("Track name           player time     player1  time1\n");
     for(i=0;i<TRACKSNUMBER;i++)
       {
	fread(&time1,1,sizeof(struct timeS),fp);
	strcpy(tmpS,time1.name);
	a=strlen(tmpS);
	for(b=a;b<21;b++) tmpS[b]=' ';
	strcpy(tmpS+21,time1.player);

	for(same=0;same<TRACKSNUMBER;same++)
   	  {
		fread(&time2,1,sizeof(struct timeS),fp1);
		if(!strcmp(time1.name,time2.name)) break;
	  }
	fseek(fp1,0,SEEK_SET);
	printf("%s    %d:%d:%d",tmpS,time1.time/10000,(time1.time/100)-(time1.time/10000),time1.time-((time1.time/100)*100)-((time1.time/10000)*10000));
	printf("  %s",time2.player);
	printf("      %d:%d:%d",time2.time/10000,(time2.time/100)-(time2.time/10000),time2.time-((time2.time/100)*100)-((time2.time/10000)*10000));

	switch(CheckTime(time1.time/10000,(time1.time/100)-(time1.time/10000),time1.time-((time1.time/100)*100)-((time1.time/10000)*10000),
			 time2.time/10000,(time2.time/100)-(time2.time/10000),time2.time-((time2.time/100)*100)-((time2.time/10000)*10000)))
		{
		case YOUBETTER : printf(" You are better!\n");break;
		case HISBETTER : printf(" He's better!;-(\n");break;
		case THESAME   : printf(" Wow!The same time!\n");break;
		default	       : break;
		}

       }
    fclose(fp);	
    fclose(fp1);
    exit(0);
   }

  if(argc=2)
   {
    fp=fopen(argv[1],"rb");
        printf("Track name         player   time\n");
     for(i=0;i<12;i++)
       {
	fread(&time1,1,sizeof(struct timeS),fp);
	strcpy(tmpS,time1.name);
	a=strlen(tmpS);
	for(b=a;b<21;b++) tmpS[b]=' ';
	strcpy(tmpS+21,time1.player);
	printf("%s    %d:%d:%d\n",tmpS,time1.time/10000,(time1.time/100)-(time1.time/10000),time1.time-((time1.time/100)*100)-((time1.time/10000)*10000));
       }
    fclose(fp);	
    exit(0);
   }

}

int CheckTime(int m,int s,int ss,int m1,int s1,int ss1)
{
   if(m<m1) return YOUBETTER;
   if(m>m1) return HISBETTER;

   if(s<s1) return YOUBETTER;
   if(s>s1) return HISBETTER;

   if(ss<ss1) return YOUBETTER;
   if(ss>ss1) return HISBETTER;

   return THESAME; 
}

