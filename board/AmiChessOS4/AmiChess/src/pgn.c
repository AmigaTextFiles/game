#include <clib/alib_protos.h>
#include <proto/dos.h>
#include <proto/utility.h>
#include <proto/muimaster.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "common.h"
#include "book.h"

void PGNSaveToFile(const char *file,const char *resultstr)
{
FILE *fp;
char s[100];
int len;
char *p;
int i;
struct DateStamp ds;
struct ClockData cd;
if(!(fp=fopen(file,"a")))
	{
	sprintf(s,"Cannot write to file %s.",file);
	DoMethod(mui_app,MUIM_Chess_ShowThinking,s);
	return;
	}
fprintf(fp,"[Event \"\"]\n");
fprintf(fp,"[Site \"\"]\n");
DateStamp(&ds);
Amiga2Date(ds.ds_Days*86400+ds.ds_Minute*60+ds.ds_Tick/50,&cd);
fprintf(fp,"[Date \"%4d.%02d.%02d\"]\n",cd.year,cd.month,cd.mday);
fprintf(fp,"[Round \"\"]\n");
if(computerplays==white)  fprintf(fp,"[White \"GNUChess 5.05\"]\n");
else fprintf(fp,"[White \"%s\"]\n",name);
if(computerplays==black) fprintf(fp,"[Black \"GNUChess 5.05\"]\n");
else fprintf(fp,"[Black \"%s\"]\n",name);
fprintf(fp,"[WhiteELO \"%d\"]\n",computer==white?myrating:opprating);
fprintf(fp,"[BlackELO \"%d\"]\n",computer==white?opprating:myrating);
len=strcspn(resultstr," {");
fprintf(fp,"[Result \"%.*s\"]\n\n",len,resultstr);
s[0]=0;
for(i=0;i<=GameCnt;i+=2)
	{
	if(i==GameCnt) sprintf(s,"%s%d. %s ",s,i/2+1,Game[i].SANmv);
	else sprintf(s,"%s%d. %s %s ",s,i/2+1,Game[i].SANmv,Game[i+1].SANmv);
	if(strlen(s)>80)
		{
		p=s+79;
		while(*p--!=' ');
		*++p=0;
		fprintf(fp,"%s\n",s);
		strcpy(s,p+1);
		}
	}
fprintf(fp,"%s%s\n\n",s,resultstr);
fclose(fp);
}

void PGNReadFromFile(const char *file)
{
FILE *fp;
char s[100],c,wmv[8],bmv[8],text[100];
int moveno;
leaf *p;
if(!(fp=fopen(file,"r")))
	{
	sprintf(text,"Cannot open file %s.",file);
	DoMethod(mui_app,MUIM_Chess_ShowThinking,text);
	return;
	}
DoMethod(mui_app,MUIM_Chess_ClearList);
do
	{
	if((c=fgetc(fp))=='[') fgets(s,100,fp);
	}
while(c=='[');
ungetc(c,fp);
InitVars();
while(!feof(fp))
	{
	int res;
	c=fgetc(fp);
	if(c=='*') break;
	ungetc(c,fp);
	wmv[0]=0;
	bmv[0]=0;
	res=fscanf(fp,"%d. %s %s ",&moveno,wmv,bmv);
	if(isdigit(wmv[0])) break;
	if(!(p=ValidateMove(wmv)))
		{
		sprintf(text,"Illegal move %d. %s",moveno,wmv);
		DoMethod(mui_app,MUIM_Chess_ShowThinking,text);
		DoMethod(mui_app,MUIM_Chess_ShowBoard);
		DoMethod(mui_app,MUIM_Chess_Side);
		break;
		}
	MakeMove(white,&p->move);
	strcpy(Game[GameCnt].SANmv,wmv);
	sprintf(text,"%d: %-5s",moveno,wmv);
	DoMethod(mui_app,MUIM_Chess_AddMove,white,text);
	if(res==2||bmv[0]==(char)'*'||bmv[0]==(char)-1) break;
	if(isdigit(bmv[0])) break;
	if(!(p=ValidateMove(bmv)))
		{
		sprintf(text,"Illegal move %d. ... %s",moveno,bmv);
		DoMethod(mui_app,MUIM_Chess_ShowThinking,text);
		DoMethod(mui_app,MUIM_Chess_ShowBoard);
		DoMethod(mui_app,MUIM_Chess_Side);
		break;
		}
	MakeMove(black,&p->move);
	strcpy(Game[GameCnt].SANmv,bmv);
	sprintf(text,"%d: %-5s",moveno,bmv);
	DoMethod(mui_app,MUIM_Chess_AddMove,black,text);
	}
fclose(fp);
DoMethod(mui_app,MUIM_Chess_ShowBoard);
DoMethod(mui_app,MUIM_Chess_Side);
TTClear();
}

void BookPGNReadFromFile(const char *file)
{
FILE *fp;
char s[100],wmv[8],bmv[8];
int c;
unsigned int i;
char header[2000];
int moveno,result,ngames=0;
leaf *p;
time_t t1,t2;
double et;
int examinecolor,playerfound[2];

const char *const player[]={
"Alekhine",
"Adams",
"Anand",
"Anderssen",
"Andersson",
"Aronin",
"Averbakh",
"Balashov",
"Beliavsky",
"Benko",
"Bernstein",
"Bird",
"Bogoljubow",
"Bolbochan",
"Boleslavsky",
"Byrne",
"Botvinnik",
"Bronstein",
"Browne",
"Capablanca",
"Chigorin",
"Christiansen",
"De Firmian",
"Deep Blue",
"Deep Thought",
"Deep Junior",
"Donner",
"Dreev",
"Duras",
"Euwe",
"Evans",
"Filip",
"Fine",
"Fischer",
"Flohr",
"Furman",
"Gelfand",
"Geller",
"Gereben",
"Glek",
"Gligoric",
"GNU",
"Golombek",
"Gruenfeld",
"Guimard",
"Hodgson",
"Ivanchuk",
"Ivkov",
"Janowsky",
"Kamsky",
"Kan",
"Karpov",
"Kasparov",
"Keres",
"Korchnoi",
"Kortschnoj",
"Kotov",
"Kramnik",
"Kupreich",
"Lasker",
"Lautier",
"Letelier",
"Lilienthal",
"Ljubojevic",
"Marshall",
"Maroczy",
"Mieses",
"Miles",
"Morphy",
"Mueller",
"Nimzowitsch",
"Nunn",
"Opocensky",
"Pachman",
"Petrosian",
"Piket",
"Pilnik",
"Pirc",
"Polgar",
"Portisch",
"Psakhis",
"Ragozin",
"Reshevsky",
"Reti",
"Romanish",
"Rubinstein",
"Saemisch",
"Seirawan",
"Shirov",
"Short",
"Silman",
"Smyslov",
"Sokolsky",
"Spassky",
"Sveshnikov",
"Stahlberg",
"Steinitz",
"Tal",
"Tarjan",
"Tartakower",
"Timman",
"Topalov",
"Torre",
"Vidmar"
};

et=0;
t1=time(0);
result=-1;
if(!(fp=fopen(file,"r")))
	{
	sprintf(s,"Cannot open file %s.",file);
	DoMethod(mui_app,MUIM_Chess_ShowThinking,s);
	return;
	}
if(BookBuilderOpen()!=BOOK_SUCCESS) return;
newpos=existpos=0;

nextgame:
header[0]=0;
InitVars();
NewPosition();
myrating=opprating=0;
playerfound[black]=playerfound[white]=0;
while((c=fgetc(fp))!=EOF)
	{
	if(c!=' '&&c!='\t'&&c!='\n'&&c!='\r')
		{
		ungetc(c,fp);
		break;
		}
	}
while((c=fgetc(fp))=='[')
	{
	ungetc(c,fp);
	fgets(s,100,fp);
	strcat(header,s);
	if(!strncmp(s+1,"White ",6))
		{
		examinecolor=white;
		ngames++;
		}
	else if(!strncmp(s+1,"Black ",6)) examinecolor=black;
	else if(!strncmp(s+1,"Result",6))
		{
		if(!strncmp(s+7," \"1-0",5)) result=R_WHITE_WINS;
		else if(!strncmp(s+7," \"0-1",5)) result=R_BLACK_WINS;
		else if(!strncmp(s+7," \"1/2-1/2",9)) result=R_DRAW;
		else result=R_NORESULT;
		continue;
		}
	else continue;
	for(i=0;i<(sizeof(player)/sizeof(*player));i++)
		{
		if(strstr(s+7,player[i])!=NULL) playerfound[examinecolor]=1;
		}
	}
ungetc(c,fp);
while(1)
	{
	if(fscanf(fp,"%d. %7s ",&moveno,wmv)<2) break;
	if(wmv[0]=='1'||wmv[0]=='['||wmv[0]=='*'||strcmp(wmv,"0-1")==0) break;
	if(!(p=ValidateMove(wmv)))
		{
/*
		DoMethod(mui_app,MUIM_Chess_ShowBoard);
		sprintf(s,"Illegal move %d. %s\n",moveno,wmv);
		DoMethod(mui_app,MUIM_Chess_ShowThinking,s);
*/
		break;
		}
	MakeMove(white,&p->move);
	if(playerfound[white])
		{
		if(BookBuilder(result,white)!=BOOK_SUCCESS) break;
		}
	strcpy(Game[GameCnt].SANmv,wmv);
	if(fscanf(fp,"%7s ",bmv)<1) break;
	if(bmv[0]=='1'||bmv[0]=='['||bmv[0]=='*'||strcmp(bmv,"0-1")==0) break;
	if(!(p=ValidateMove(bmv)))
		{
/*
		DoMethod(mui_app,MUIM_Chess_ShowBoard);
		sprintf(s,"Illegal move %d. ... %s\n",moveno,wmv);
		DoMethod(mui_app,MUIM_Chess_ShowThinking,s);
*/
		break;
		}
	MakeMove(black,&p->move);
	if(playerfound[black])
		{
		if(BookBuilder(result,black)!=BOOK_SUCCESS) break;
		}
	strcpy(Game[GameCnt].SANmv,bmv);
	}
while(!feof(fp))
	{
	fgets(s,100,fp);
	if(s[0]=='\n') break;
	}
if(!feof(fp))
	{
	if(!(ngames%10))
		{
		sprintf(s,"%d games",ngames);
		DoMethod(mui_app,MUIM_Chess_ShowThinking,s);
		}
	goto nextgame;
	}
fclose(fp);
if(BookBuilderClose()!=BOOK_SUCCESS) DoMethod(mui_app,MUIM_Chess_ShowThinking,"Error writing opening book.");
header[0]=0;
InitVars();
NewPosition();
myrating=opprating=0;
t2=time(0);
//et+=difftime(t2,t1);
if(et<0.5) et=1.0;

sprintf(s,"Finished. %d positions added.",newpos);
DoMethod(mui_app,MUIM_Chess_ShowThinking,s);

/*
printf("Time = %.0f seconds\n",et);
printf("Games compiled: %d\n",ngames);
printf("Games per second: %f\n",ngames/et);
printf("Positions scanned: %d\n",newpos+existpos);
printf("Positions per second: %f\n",(newpos+existpos)/et);
printf("New & unique added: %d positions\n",newpos);
printf("Duplicates not added: %d positions\n",existpos);
*/
}
