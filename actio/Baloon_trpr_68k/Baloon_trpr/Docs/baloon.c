#include "CEG2.h"
#include "CEGex.h"


void GameStart(CEG *eg,CTask *task);
void GameOver(CEG *eg,CTask *task);

enum {
	ID_NONE=0,
	ID_BALOON,
	ID_ELEC,
	ID_BALOONMAN,
};	


/*
number display
*/

#define ORDER	7
typedef struct{
	CTaskPrivate private;
	CSpriteTask *sp[ORDER];
	int num;
	
}NumberDisplay;
void NumberDisplaySetNum(CEG *eg,NumberDisplay *n,int num);

/**
game data
**/
typedef struct{
	CBmps *bitmap;
	NumberDisplay *dscore;
	NumberDisplay *dhighscore;
	int score,highscore;
	int isGameOver;
}UserData;
/*
baloon man 
*/
typedef struct{
	CTaskPrivate private;
	int x_velocity;// -4 .. +4
	CSpriteTask *sp;
	int dir;//0 --left 1--right
	int animecount;
	int electricity;
}BaloonMan;

void AddScore(CEG *eg,int point){
	UserData *udata;
	udata=CEGGetUserData(eg);
	udata->score+=point;
	NumberDisplaySetNum(eg,udata->dscore,udata->score);
	if(udata->highscore<udata->score){
		udata->highscore=udata->score;
		NumberDisplaySetNum(eg,udata->dhighscore,udata->highscore);
	}
}







/*
baloon , elec maker
*/

void balooncheck(CEG *eg,CSpriteTask *sptask){
	TSprite *sp;
	TVec *vec;
	UserData *udata;
	BaloonMan *man;
	TSprite *mansp;
	
	sp=CSpriteTaskGetSprite(sptask);
	
	udata=CEGGetUserData(eg);
	if(udata->isGameOver){
		TSpriteStop(sp);
		return;
	}
	man=CEGGetTaskByID(eg,ID_BALOONMAN);
	mansp=CSpriteTaskGetSprite(man->sp);
	if(TSpriteCollision(sp,mansp)>50){
		CEGDeleteTask(eg,sptask);
		AddScore(eg,300);
		return;
	}
	vec=TSpriteGetPosition(sp);
	if(vec->x>320)CEGDeleteTask(eg,sptask);
}
void eleccheck(CEG *eg,CSpriteTask *sptask){
	TSprite *sp;
	TVec *vec;
	UserData *udata;
	BaloonMan *man;
	TSprite *mansp;
	
	sp=CSpriteTaskGetSprite(sptask);
	
	udata=CEGGetUserData(eg);
	if(udata->isGameOver){
		TSpriteStop(sp);
		return;
	}
	
	man=CEGGetTaskByID(eg,ID_BALOONMAN);
	mansp=CSpriteTaskGetSprite(man->sp);
	if(man->electricity!=1 && TSpriteCollision(sp,mansp)
		>99){
		TSpriteStop(mansp);
		TSpriteSetGravity(mansp,64,64);
		man->electricity=1;
	}
	
	vec=TSpriteGetPosition(sp);
	if(vec->x>320)CEGDeleteTask(eg,sptask);
}

#define SCROLL_SPEED	256
typedef struct{
	CTaskPrivate private;
	int frame;
}ObstacleMaker;
void MakeBaloon(CEG *eg,ObstacleMaker *task){
	CSpriteTask *sptask;
	TSprite *sp;
	UserData *udata;
	
	udata=CEGGetUserData(eg);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),balooncheck);
	CTaskSetID(sptask,ID_BALOON);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(-24,RANDOM(240-24)));
	TSpriteSetBmps(sp,udata->bitmap,21,0);
	TSpriteShow(sp);
	TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
}

void MakeElec(CEG *eg,ObstacleMaker *task,int type){
	CSpriteTask *sptask;
	TSprite *sp;
	UserData *udata;
	
	udata=CEGGetUserData(eg);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),eleccheck);
	CTaskSetID(sptask,ID_ELEC);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(-24,RANDOM(240-24)));
	TSpriteSetBmpsAnime(sp,udata->bitmap,24);
	TSpriteShow(sp);
	TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
}


void ObstacleMakerControl(CEG *eg,ObstacleMaker *task){
	CSpriteTask *sptask;
	UserData *udata;
	
	static int level=0;
	int elecp;
	
	udata=CEGGetUserData(eg);
	if(udata->isGameOver)return;
	
	if(RANDOM(80)==0)MakeBaloon(eg,task);
	
	elecp=50-level/3;
	if(elecp<25)elecp=25;
	if(RANDOM(elecp)==0){
		level++;
		MakeElec(eg,task,0);
	}
	
/*	task->frame++;
	task->frame%=24;
	if(task->frame==0){
		
		AddScore(eg,10);
		
		
	}
	if(task->frame%4==0){
		MakeStar(eg,task);
	}
*/
}




void NumberDisplaySetNum(CEG *eg,NumberDisplay *n,int num){
	int i;
	TSprite *sp;
	UserData *udata;

	udata=CEGGetUserData(eg);
	n->num=num;
	for(i=0;i<ORDER;++i){
		int number;
		number=num%10;
		num/=10;
		sp=CSpriteTaskGetSprite(n->sp[i]);
		TSpriteSetBmps(sp,udata->bitmap,33,0+number);
	}
}
void NumberDisplayDestroy(CEG *eg,NumberDisplay *task){
	int i;
	for(i=0;i<ORDER;++i){
		CEGDeleteTask(eg,task->sp[i]);
	}
	
}
void NumberDisplaySetPosition(CEG *eg,NumberDisplay *task,TVec *v){
	int i;
	TSprite *sp;
	for(i=0;i<ORDER;++i){
		sp=CSpriteTaskGetSprite(task->sp[i]);
		TSpriteSynthPos(sp,v);
	}
	
}
void NumberDisplayControl(CEG *eg,NumberDisplay *n){}
NumberDisplay *NumberDisplayCreate(CEG *eg,CTask *task){
	NumberDisplay*n;
	UserData *udata;
	int i;
	TSprite *sp;
	udata=CEGGetUserData(eg);
	n=CTaskInit(NumberDisplayControl,sizeof(NumberDisplay));
	CEGAddTask(eg,n);
	CTaskSetAtDestroy(n,NumberDisplayDestroy);
	for(i=0;i<ORDER;++i){
		n->sp[i]=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(n->sp[i]);
		TSpriteSetPosition(sp,toVec(-i*12,0));
		TSpriteSetBmps(sp,udata->bitmap,33,0);
		TSpriteShow(sp);
		
	}
	return n;
}


/*
title
*/
typedef struct{
	CTaskPrivate private;
	CSpriteTask *sp;
	int y;
}Title;

void TitleControl(CEG *eg,Title *me){
	CSpriteTask *sptask;
	TSprite *sp;
	CInput *input;
	UserData *udata;
	
	
	udata=CEGGetUserData(eg);
	input=eg->input;
	sptask=me->sp;
	sp=CSpriteTaskGetSprite(sptask);
	
	if(input->button[BUTTON_UP] && me->y>0){
		me->y--;
	}
	if(input->button[BUTTON_DOWN] && me->y<1){
		me->y++;
	}
	if(input->button[BUTTON_0]){
		CTask *task;
		CEGClearTask(eg);
		if(me->y==0){
			task=CTaskInit(GameStart,sizeof(CTask));
			CEGAddTask(eg,task);
			return;
		}else{
			CEGEnd(eg);
		}
		return;
	}
	switch(me->y){
		case 0:{
			TSpriteSetPosition(sp,toVec(40-16,150));
		}break;
		case 1:{
			TSpriteSetPosition(sp,toVec(40-16,150+25));
		}break;
	}
}

void TitleStart(CEG *eg,CTask *task){
	Title *title;
	TSprite *sp;
	UserData *udata;
	CSpriteTask *sptask;
	
	udata=CEGGetUserData(eg);
	CEGSetSpLayer(eg,1);
	
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(0,0));
	TSpriteSetBmps(sp,udata->bitmap,31,0);
	TSpriteShow(sp);
	
	CEGSetSpLayer(eg,3);
	
	title=CTaskInit(TitleControl,sizeof(Title));
	CEGAddTask(eg,title);
	title->sp=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(title->sp);
	TSpriteSetPosition(sp,toVec(40-16,150));
	TSpriteSetBmps(sp,udata->bitmap,21,0);
	TSpriteShow(sp);
	
	CEGDeleteTask(eg,task);
	
}


/*
umi creation
*/

void umipartscheck(CEG *eg,CSpriteTask *sptask){
	TSprite *sp;
	TVec *vec;
	UserData *udata;
	
	sp=CSpriteTaskGetSprite(sptask);
	
	udata=CEGGetUserData(eg);
	if(udata->isGameOver){
		TSpriteStop(sp);
		return;
	}
	
	vec=TSpriteGetPosition(sp);
	if(vec->x>320)CEGDeleteTask(eg,sptask);
}
typedef struct{
	CTaskPrivate private;
	int frame;
}UmiMaker;
void MakeUmi(CEG *eg,UmiMaker *task){
	CSpriteTask *sptask;
	TSprite *sp;
	UserData *udata;
	
	udata=CEGGetUserData(eg);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),umipartscheck);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(-24,240-24));
	TSpriteSetBmps(sp,udata->bitmap,22,0);
	TSpriteShow(sp);
	TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
}
void MakeStar(CEG *eg,UmiMaker *task){
	CSpriteTask *sptask;
	TSprite *sp;
	UserData *udata;
	
	udata=CEGGetUserData(eg);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),umipartscheck);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(-1,RANDOM(240-24)));
	TSpriteSetBmps(sp,udata->bitmap,23,0);
	TSpriteShow(sp);
	TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
}
void MakeUmiControl(CEG *eg,UmiMaker *task){
	CSpriteTask *sptask;
	UserData *udata;
	
	
	udata=CEGGetUserData(eg);
	if(udata->isGameOver)return;
	task->frame++;
	task->frame%=24;
	if(task->frame==0){
		MakeUmi(eg,task);
		
		AddScore(eg,10);
		
		
	}
	if(task->frame%4==0){
		MakeStar(eg,task);
	}
}








void BaloonManControl(CEG *eg,BaloonMan *me){
	CSpriteTask *sptask;
	TSprite *sp;
	CInput *input;
	UserData *udata;
	int left_on=0,right_on=0;
	int anime=0;
	TVec *vec;
	
	udata=CEGGetUserData(eg);
	input=eg->input;
	sptask=me->sp;
	sp=CSpriteTaskGetSprite(sptask);
	
	if(udata->isGameOver)return;
	
	if(!me->electricity){
	
	if(input->button[BUTTON_LEFT]){
		left_on=1;
	}
	if(input->button[BUTTON_RIGHT]){
		right_on=1;
	}
	
#define VERTICAL	512
#define HORIZONTAL	256
#define ANIME_INTERVAL	2
	if(input->button[BUTTON_0]){
		me->animecount=ANIME_INTERVAL;
		if(right_on||left_on){
			TSpriteSynthVelocity(sp,192,VERTICAL/2);
		}else{
			TSpriteSynthVelocity(sp,192,VERTICAL);
		}
		if(left_on && me->x_velocity>-4){
			me->dir=0;
			me->x_velocity--;
			TSpriteSynthVelocity(sp,128,HORIZONTAL);
		}
		if(right_on && me->x_velocity<4){
			me->x_velocity++;
			me->dir=1;
			TSpriteSynthVelocity(sp,0,HORIZONTAL);
		}
	}
	if(me->animecount>0){
		anime=1;
		me->animecount--;
	}
	TSpriteSetBmps(sp,udata->bitmap,11+me->dir*2+anime,0);
	}//!electricity
	else{
		int anime=0;
		me->animecount++;
		if((me->animecount/2)%2==0){
			anime=1;
		}
		TSpriteSetBmps(sp,udata->bitmap,17+anime,0);
	}
	
	vec=TSpriteGetPosition(sp);
	if(
	vec->x<0 && TSpriteVelXisNegative(sp) 
	||
	vec->x>320-24 && TSpriteVelXisPositive(sp)
	){
		TSpriteReverseVelX(sp);
		me->x_velocity=-me->x_velocity;
	}
	if(vec->y<0 && TSpriteVelYisNegative(sp)){
		TSpriteReverseVelY(sp);
	}
	if(vec->y>240){
		udata->isGameOver=1;
		GameOver(eg,NULL);
		return;
	}
	


}

void MakeInitialUmi(CEG *eg){
	CSpriteTask *sptask;
	TSprite *sp;
	UserData *udata;
	int i;
	udata=CEGGetUserData(eg);
	
	for(i=0;i<320/4;++i){
		sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),umipartscheck);
		sp=CSpriteTaskGetSprite(sptask);
		TSpriteSetPosition(sp,toVec(i*4,RANDOM(240-24)));
		TSpriteSetBmps(sp,udata->bitmap,23,0);
		TSpriteShow(sp);
		TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
	}
	for(i=-1;i<320/24;++i){
		sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),umipartscheck);
		sp=CSpriteTaskGetSprite(sptask);
		TSpriteSetPosition(sp,toVec(i*24,240-24));
		TSpriteSetBmps(sp,udata->bitmap,22,0);
		TSpriteShow(sp);
		TSpriteMoveByAngle(sp,0,SCROLL_SPEED);
	}
}


void GameOverControl(CEG *eg,CTask *task){
	CInput *input;
	UserData *udata;
	
	udata=CEGGetUserData(eg);
	input=eg->input;
	
	if(input->button[BUTTON_0]){
		CTask *_task;
		CEGClearTask(eg);
		_task=CTaskInit(TitleStart,sizeof(CTask));
		CEGAddTask(eg,_task);
		return;
	}
	
}
void GameOver(CEG *eg,CTask *task){
	CSpriteTask *sptask;
	CTask *_task;
	TSprite *sp;
	UserData *udata;
	int i;
	udata=CEGGetUserData(eg);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(60,240));
	TSpriteSetBmps(sp,udata->bitmap,34,0);
	TSpriteShow(sp);
	TSpriteMoveTo(sp,toVec(60,100),10);
	
	_task=CTaskInit(GameOverControl,sizeof(CTask));
	CEGAddTask(eg,_task);
}

void GameStart(CEG *eg,CTask *task){
	BaloonMan *man;
	TSprite *sp;
	UserData *udata;
	UmiMaker *umi;
	int i;
	CSpriteTask *sptask;
	ObstacleMaker *obs;
	
	udata=CEGGetUserData(eg);
	
	CEGSetSpLayer(eg,7);
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(0,0));
	TSpriteSetBmps(sp,udata->bitmap,32,0);
	TSpriteShow(sp);
	
	CEGSetSpLayer(eg,3);
	man=CTaskInit(BaloonManControl,sizeof(BaloonMan));
	CTaskSetID(man,ID_BALOONMAN);
	CEGAddTask(eg,man);
	man->sp=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(man->sp);
	TSpriteSetPosition(sp,toVec(250,100));
	TSpriteMoveByAngle(sp,192,256);
	TSpriteSetBmps(sp,udata->bitmap,11,0);
	TSpriteShow(sp);
#define DEF_GRAVITY	32
	TSpriteSetGravity(sp,64,DEF_GRAVITY);
	
	
	umi=CTaskInit(MakeUmiControl,sizeof(UmiMaker));
	CEGAddTask(eg,umi);
	
	udata->dscore=NumberDisplayCreate(eg,NULL);
	NumberDisplaySetPosition(eg,udata->dscore,toVec(300,0));
	udata->score=0;
	NumberDisplaySetNum(eg,udata->dscore,udata->score);

	udata->dhighscore=NumberDisplayCreate(eg,NULL);
	NumberDisplaySetPosition(eg,udata->dhighscore,toVec(140,0));
//	udata->highscore=0;
	NumberDisplaySetNum(eg,udata->dhighscore,udata->highscore);
	
	obs=CTaskInit(ObstacleMakerControl,sizeof(ObstacleMaker));
	CEGAddTask(eg,obs);
	
	
	MakeInitialUmi(eg);
	
	CEGDeleteTask(eg,task);
	
	udata->isGameOver=0;
}


void Fin(CEG *eg,CTask *task){
	UserData *udata;
	udata=CEGGetUserData(eg);
	
	CBmpsFree(udata->bitmap);
	
}
void Init(CEG* eg,CTask* me){
	static UserData udata;
	CTask *task;
	
	memset(&udata,0,sizeof(UserData));
	eg->user_data=&udata;
	
	udata.bitmap=CBmpsInit(128);
	CBmpsLoadFromFileDir(udata.bitmap,"./btbmp/");
	CBmpsConvert(udata.bitmap);
	
	udata.highscore=5000;
	
	task=CTaskInit(TitleStart,sizeof(CTask));
	CEGAddTask(eg,task);
	
	CEGDeleteTask(eg,me);
}
int main(int argc,char *argv[]){

	CEG* eg;
	CEGSpec spec={
		320,240,32,SDL_SWSURFACE|SDL_ANYFORMAT|SDL_FULLSCREEN,1,0,30,
		"Baloon Tripper REAL"
	};
	
	eg=CEGInit();
	if(CEGSetup(eg,&spec)){
		CEGFree(eg);
		exit (1);
	}
	
	CEGStart(eg,Init);
	
	CEGFree(eg);
}
