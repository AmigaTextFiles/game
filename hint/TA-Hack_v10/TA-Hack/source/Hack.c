#include "FindTaskExt.h"

UBYTE *LIVES[2];
ULONG *MONEY[2];

ULONG len[5];
ULONG AGAlen[5] = {243624, 292168, 12564, 497192, 526544};
ULONG ECSlen[5] = {199084, 313548, 20120, 430200,  72284};
ULONG *addrs[5];

BYTE found=0; /* 0=nothing, 1=AGA, 2=ECS, 3=5 hunks, 4=min 2nd hunk, 5=more than 5 hunks */

#define b2c(bptr,type) ( (type) ((ULONG)(bptr) << 2))

static char *findTA(void){
	ULONG type = FT_PROCESS | FT_COMMAND;
	struct Process *TA = (struct Process *)FindTaskExt("AB",FALSE,&type);
	ULONG *segs;
	UBYTE *bseg;
	char i;

	if(!TA)
		return("Could´nt find TowerAssault in memory.");
	if(type == FT_PROCESS){
		segs = (ULONG *)(TA->pr_SegList << 2);
		if(!segs)
			return("Could´nt find SegList.");
		segs = (ULONG *)(segs[3] << 2);
	}else{ // type == FT_COMMAND
	   segs = b2c(b2c(TA->pr_CLI, struct CommandLineInterface *)->cli_Module, ULONG *);
	}
	for(i=0; i<5; i++){
		if(!segs){
			sprintf(err,"Could´nt find %s hunk.",i==0?"1st":(i==1?"2nd":(i==2?"3rd":(i==3?"4th":"5th"))));
			if(i>=2 && len[1]>=0x1570)
				found = 4;
			return(err);
		}
		len[i] = segs[-1];
		addrs[i] = segs+1;
		segs = (ULONG *)(segs[0] << 2);
	}
	if(segs){
		found = 5;
		return("Found 6th hunk, what sould I do?");
	}
	segs = addrs[1];
	bseg = (UBYTE *)segs;
	LIVES[0] = &bseg[0x12ed];
	MONEY[0] = &segs[0x136c/4];
	LIVES[1] = &bseg[0x14ed];
	MONEY[1] = &segs[0x156c/4];
	for(i=0; i<5 && len[i]==AGAlen[i]; i++);
	if(i==5){
		found = 1;
		return("Found TowerAssault AGA.");
	}else{
		for(i=0; i<5 && len[i]==ECSlen[i]; i++);
		if(i==5){
			found = 2;
			return("Found TowerAssault ECS.");
		}
	}
	found=3;
	return("Found a programm, unidentified.");
}

static ULONG dummy;

void setlives(int plr, APTR str_lives){
	get(str_lives, MUIA_String_Integer, &dummy);
	*LIVES[plr] = dummy;
}

void setmoney(int plr, APTR str_money){
	get(str_money, MUIA_String_Integer, &dummy);
	if(*MONEY[0] == *MONEY[1])
		*MONEY[1-plr] = dummy;
	*MONEY[plr] = dummy;
}
