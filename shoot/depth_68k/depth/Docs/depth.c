#include "CEG2.h"
#include "CEGex.h"
/*

depth

*/
enum{
	ID_NONE=0,
	ID_ME,
	ID_ENEMY,
	ID_MY_BULLET,
	ID_ENEMY_BULLET,
	ID_DECOY,
	
	ID_WEAPON_UP,
	ID_SPEED_UP,
	ID_DECOY_PLUS,
	ID_BULLETS_PLUS,
	
};
#define MAXBULLETS	8
#define MAX_SPEED	3
#define MAX_DECOY	10
#define MAX_WEAPON_LV	4
#define INITIALBULLETS	4
typedef struct{
	CTaskPrivate private;
	CSpriteTaskPublic public;
	int bullet_left;
	CSpriteTask *show_bullets[MAXBULLETS];
	CSpriteTask *show_decoy[MAX_DECOY];
	CSpriteTask *show_speed[MAX_SPEED];
	
	int speed;
	int weapon_lv;
	int now_bullets;
	
	int decoy_left;
	int decoy_on;
	
}MyTask;

typedef struct{
	CTaskPrivate private;
	CSpriteTaskPublic public;
}MyBullet;

typedef struct{
	CTaskPrivate private;
	CSpriteTaskPublic public;
	int aim_left;
	int aim_interval;
	int aim_interval_left;
	int speed;
	int aim_angle;
}EnemyBullet;

enum{
	ENEMY_LEFT=0,
	ENEMY_RIGHT,
};
typedef struct{
	CTaskPrivate private;
	CSpriteTaskPublic public;
	int direction;
	int point;
	int depth_lv;
	CSpriteTask*	radar;
	int color;
}Enemy;


typedef struct{
	char name[4];
	int score;
}TScore;


typedef struct{
	CBmps *number;
	CBmps *chara;
	MyTask *mytask;
	
	TScore highscore[5];
	int score;
	int killed;
	
	int radar_on;
	
	int item_ready[4];
	
}Test;



typedef struct{
	int x;
	int y;
	int index;
	int sub_index;
	int show;
}Tsp_spec;


void* GetDecoySprite(CEG *eg){
	void *backup;
	CSpriteTask *task;
	TSprite *sp;
	
	backup=CEGGetCurrentTask(eg);
	CEGTaskRewind(eg);
	task=CEGGetTaskByID(eg,ID_DECOY);
	CEGSetCurrentTask(eg,backup);
	if(!task)return NULL;
	sp=CSpriteTaskGetSprite(task);
	return sp;
}
void* GetMyTask(CEG *eg){
	void *backup;
	MyTask *mytask;
	backup=CEGGetCurrentTask(eg);
	CEGTaskRewind(eg);
	mytask=CEGGetTaskByID(eg,ID_ME);
	CEGSetCurrentTask(eg,backup);
	return mytask;
}
void* GetMySprite(CEG *eg){
	TSprite *sp;
	MyTask *mytask;
	
	mytask=GetMyTask(eg);
	if(!mytask)return NULL;
	sp=CSpriteTaskGetSprite(mytask);
	return sp;
}

CSpriteTask* sp_bmps_setter(CEG *eg,CBmps *bmps,Tsp_spec *spec){
	TSprite *sp;
	CSpriteTask *sptask;
	
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(spec->x,spec->y));
	TSpriteSetBmps(sp,bmps,spec->index,spec->sub_index);
	if(spec->show)TSpriteShow(sp);
	
	return sptask;
}

void item_check(CEG *eg,CSpriteTask *task){
	TSprite *mysp,*sp;
	MyTask *mytask;
	Test *test;
	TVec *vec;
	int i;
	test=CEGGetUserData(eg);
	mysp=GetMySprite(eg);
	mytask=GetMyTask(eg);
	if(!mysp)return;
	sp=CSpriteTaskGetSprite(task);
	vec=TSpriteGetPosition(sp);
	if(vec->y==40)TSpriteMoveByAngle(sp,0,0);
	if(TSpriteCollision(sp,mysp)>250){
		
		switch(CTaskGetID(task)){
			case ID_WEAPON_UP:{
				mytask->weapon_lv++;
				if(mytask->weapon_lv>MAX_WEAPON_LV)mytask->weapon_lv=MAX_WEAPON_LV;
				
	for(i=0;i<MAXBULLETS;++i){
		sp=CSpriteTaskGetSprite(mytask->show_bullets[i]);
		TSpriteSetBmps(sp,test->chara,mytask->weapon_lv+30,0);
	}
				
				
				
			}break;
			case ID_SPEED_UP:{
				mytask->speed++;
				if(mytask->speed>=MAX_SPEED)mytask->speed=MAX_SPEED;
			}break;
			case ID_DECOY_PLUS:{
				mytask->decoy_left+=3;
				if(mytask->decoy_left>=MAX_DECOY)mytask->decoy_left=MAX_DECOY;
			}break;
			case ID_BULLETS_PLUS:{
				if(mytask->now_bullets<MAXBULLETS){
					mytask->now_bullets++;
					mytask->bullet_left++;
				}
			}break;
		}
		CEGDeleteTask(eg,task);
		test->score+=10;
	}
	
}

void item_create(CEG *eg,TVec *vec,int kind){
	TSprite *sp;
	CSpriteTask *sptask;
	Test *test;
	int item_slot;
	int id;
	
	test=CEGGetUserData(eg);
	switch(kind){
		case 0:{item_slot=0;id=ID_WEAPON_UP;}break;
		case 4:{item_slot=1;id=ID_SPEED_UP;}break;
		case 1:{item_slot=2;id=ID_DECOY_PLUS;}break;
		case 6:{item_slot=3;id=ID_BULLETS_PLUS;}break;
		default: return;
	}
	if(test->item_ready[item_slot]<2)return;
	test->item_ready[item_slot]=0;
	
	
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),item_check);
	CTaskSetID(sptask,id);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(vec->x+12,vec->y+0));
	TSpriteSetBmps(sp,test->chara,item_slot+16,0);
	TSpriteShow(sp);
#define ITEM_CARRY_SPEED	192
	TSpriteMoveByAngle(sp,192,ITEM_CARRY_SPEED);
}



int title_set(CEG *eg);

int ranking(CEG *eg){
	Test *test;
	int i,j;
	test=CEGGetUserData(eg);
	for(i=0;i<5;++i){
		if(test->highscore[i].score<=test->score)break;
	}
	if(i==5)return 5;
	for(j=3;j>=i;--j){
		test->highscore[j+1]=test->highscore[j];
	}
	test->highscore[i].score=test->score;
	strcpy(test->highscore[i].name,"AAA");
	return i;
}

void nameentry_set(CEG *eg,int rank);
void gameover_keycheck(CEG *eg,CTask *task){
	int rank;
	if(eg->input->button[BUTTON_0]){
		CEGClearTask(eg);
		rank=ranking(eg);
		if(rank==5)
			title_set(eg);
		else
			nameentry_set(eg,rank);
	}
}
void gameover_set(CEG *eg){
	CTask *task;
	Test *test;
	Tsp_spec spec={60,90,27,0,1};
	test=CEGGetUserData(eg);
	task=CTaskInit(gameover_keycheck,sizeof(CTask));
	CTaskSetDelay(task,30*3);
	
	CEGSetSpLayer(eg,2);
	sp_bmps_setter(eg,test->chara,&spec);
	CEGSetSpLayer(eg,1);
	
	CEGAddTask(eg,task);
	test->killed=0;
}

void set_expl(CEG *eg,int x,int y){
	TSprite *sp;
	CSpriteTask *sptask;
	Test *test;
	CBmps *bmps;
	
	test=CEGGetUserData(eg);
	bmps=test->chara;
	sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),CEGDeleteTask);
	sp=CSpriteTaskGetSprite(sptask);
	TSpriteSetPosition(sp,toVec(x,y));
	TSpriteSetBmpsAnime(sp,bmps,15);
	TSpriteShow(sp);
	CTaskSetDelay(sptask,3*5);
	
}

void enemy_bullet_check(CEG *eg,EnemyBullet *task){
	TSprite *sp,*mysp;
	TVec mev,enemyv;
	MyTask *mytask;
	mytask=GetMyTask(eg);
	if(!mytask)return;
	mysp=GetMySprite(eg);
	sp=CSpriteTaskGetSprite(task);
	if(TSpriteCollision(sp,mysp)>250){
		mev=*TSpriteGetPosition(mysp);
		set_expl(eg,mev.x-8,mev.y-16);
		CEGDeleteTask(eg,mytask);
		gameover_set(eg);
	}
}
void enemy_missle_check(CEG *eg,EnemyBullet *task){
	TSprite *sp,*mysp;
	Test *test;
	int chara;
	TVec mev,enemyv;
	int angle=0;
	int diff,diff2;
	MyTask *mytask;
	
	mytask=GetMyTask(eg);
	if(!mytask)return;
	
	enemy_bullet_check(eg,task);
	
	test=CEGGetUserData(eg);
	if(task->aim_left>0){
		if(task->aim_interval_left>0){
			task->aim_interval_left--;
		}else{
			task->aim_interval_left=task->aim_interval;
			
			if(mytask->decoy_on) mysp=GetDecoySprite(eg); else mysp=GetMySprite(eg);
			
			if(!mysp)return;
			sp=CSpriteTaskGetSprite(task);
			
			mev=*(TSpriteGetCenter(mysp));
			enemyv=*(TSpriteGetCenter(sp));
			angle=TSpriteGetAngle(&enemyv,&mev);
			diff=angle-task->aim_angle;
			diff2=task->aim_angle-angle;
#define MAX_HOMING	8
			if(diff>-MAX_HOMING && diff < MAX_HOMING)task->aim_angle=angle;
			else{
				if(diff<-128 || (diff > 0 && diff < 128)){
					task->aim_angle+=MAX_HOMING;
					task->aim_angle%=256;
				}else{
					task->aim_angle+=256-MAX_HOMING;
					task->aim_angle%=256;
				}
			}
			
			TSpriteMoveByAngle(sp,task->aim_angle,task->speed);
			TSpriteSetBmps(sp,test->chara,61,((task->aim_angle+8)%256)/16);
			task->aim_left--;
		}
	}
}

void enemy_bullet_create(CEG *eg,Enemy *enemy){
	EnemyBullet *enemybullet;TSprite *sp,*enemysp,*mysp;Test *test;
	TVec *vec;
	int speed=128;
	int chara;
	int missile=0;
	int interval=1;
	int graphic=60;
	int left=30;
	int angle=192;
	void *func=enemy_bullet_check;

	
	test=CEGGetUserData(eg);
	
	if(test->killed<3)return;
	
	mysp=GetMySprite(eg);
	if(!mysp)return;
	
	if(RANDOM(4)<3 && enemy->depth_lv>3){
		missile=1;
		func=enemy_missle_check;
		graphic=61;
		speed=384 + test->killed*3 ;
	}
	
	enemybullet=CSpriteTaskCreate(eg,sizeof(EnemyBullet),func);
	CTaskSetID(enemybullet,ID_ENEMY_BULLET);
	sp=CSpriteTaskGetSprite(enemybullet);
	enemysp=CSpriteTaskGetSprite(enemy);
	vec=TSpriteGetCenter(enemysp);
	TSpriteSetPosition(sp,vec);
	CSpriteTaskSetScreenout(enemybullet);
	TSpriteShow(sp);
	
	if(missile==1){
		TSpriteMoveByAngle(sp,enemy->direction*128,speed);
	}else{
		TSpriteMoveByAngle(sp,192,speed);
	}
	if(missile!=1)chara=0;else{chara=enemy->direction*8;}
	TSpriteSetBmps(sp,test->chara,graphic,chara);
	enemybullet->aim_interval=interval;
	enemybullet->aim_interval_left=interval;
	enemybullet->aim_left=left;
	enemybullet->speed=speed;
	if(missile==1)
	enemybullet->aim_angle=enemy->direction*128;
	else
	enemybullet->aim_angle=192;
}

void enemy_check(CEG *eg,Enemy *task){
	TSprite *sp;
	int x;TVec *vec;
	Test *test;
	int perc;
	
	test=CEGGetUserData(eg);
	sp=CSpriteTaskGetSprite(task);
	vec=TSpriteGetPosition(sp);
	if(vec->x<-100||vec->x>320+100){
		if(task->radar)CEGDeleteTask(eg,task->radar);
		CEGDeleteTask(eg,task);
		return;
	}
	perc=300-test->killed*5;
	if(perc<50)perc=50;
	if(RANDOM(perc)==0 && vec->x>0 && vec->x<320){
		enemy_bullet_create(eg,task);
		
	}
	
}

void enemy_create(CEG *eg,CTask *task){
	Enemy *enemy;TSprite *sp;Test *test;
	
	int direction=ENEMY_LEFT;
	int x;
	int kind;
	int speed;
	int interval;
	int depth_lv_y;
	int depth_lv;
	int angle;
	test=CEGGetUserData(eg);
	
	
	
	if(RANDOM(2)==1)direction=ENEMY_RIGHT;
	x=320+100;
	if(direction==ENEMY_RIGHT)x=-100;
	kind=RANDOM(7);
	speed=RANDOM(384)+128;
	
	depth_lv=RANDOM(6);
	depth_lv_y=depth_lv*20+100;
	
	enemy=CSpriteTaskCreate(eg,sizeof(Enemy),enemy_check);
	CTaskSetID(enemy,ID_ENEMY);
	enemy->point=(depth_lv+1)*speed/64;
	enemy->depth_lv=depth_lv;
	
	enemy->color=kind;

	
	sp=CSpriteTaskGetSprite(enemy);
	
	TSpriteSetPosition(sp,toVec(x,depth_lv_y));
	TSpriteSetBmps(sp,test->chara,50+kind,direction
	);
	TSpriteShow(sp);
	if(direction==ENEMY_LEFT)angle=128;else angle=0;
	TSpriteMoveByAngle(sp,angle,speed);
	
	if(test->radar_on){
		CEGSetSpLayer(eg,5);
		enemy->radar=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(enemy->radar);
		TSpriteSetPosition(sp,toVec(110+(x+100)/5,170+depth_lv_y/5));
		TSpriteSetBmps(sp,test->chara,42,0);
		TSpriteMoveByAngle(sp,angle,speed/5);
		TSpriteShow(sp);
		CEGSetSpLayer(eg,1);
	}
	
	interval=RANDOM(60)+60;
	CTaskSetDelay(task,interval);
}

void recover_bullet(CEG *eg){
	void *backup;
	MyTask *mytask;
	mytask=GetMyTask(eg);
	if(!mytask)return;
	if(mytask)mytask->bullet_left++;
}

void my_bullet_check(CEG *eg,MyBullet *bullet){
	TSprite *sp1,*sp2;
	Enemy *task;
	int bingo=0;
	TVec *enemy_vec;
	void *backup;
	int point=0;
	CList *list;
	int i;
	Test *test;
	backup=CEGGetCurrentTask(eg);
	test=CEGGetUserData(eg);
	sp1=CSpriteTaskGetSprite(bullet);
	
	if(TSpriteManagerOutOfScreen(eg->man,sp1)){
		recover_bullet(eg);
		CEGDeleteTask(eg,bullet);
	}
	
	CEGTaskRewind(eg);
	list=CEGGetTaskList(eg);
	do{
		task=CEGGetTask(eg);
		if(!task)break;
		if(CTaskGetID(task)!=ID_ENEMY)continue;
		sp2=CSpriteTaskGetSprite(task);
		
		if(TSpriteCollision(sp1,sp2)>128){
			bingo=1;
			enemy_vec=TSpriteGetPosition(sp2);
			set_expl(eg,enemy_vec->x-8,enemy_vec->y-16);
			point+=task->point;
			
			switch(task->color){
				case 0:{test->item_ready[0]++;}break;
				case 4:{test->item_ready[1]++;}break;
				case 1:{test->item_ready[2]++;}break;
				case 6:{test->item_ready[3]++;}break;
			}
			item_create(eg,enemy_vec,task->color);
			
			if(task->radar)CEGDeleteTask(eg,task->radar);
			CEGDeleteTask(eg,task);
		}
		
	}while(1);
	
	if(bingo){
		void *backup;
		Test *test;
		MyTask *mytask;
		test=CEGGetUserData(eg);
		test->score+=point;
		
		mytask=GetMyTask(eg);
		if(mytask){
			if(mytask->weapon_lv!=4){
				recover_bullet(eg);
				CEGDeleteTask(eg,bullet);
			}
		}
		test->killed++;
	}
	CEGSetCurrentTask(eg,backup);
}
void my_decoy_check(CEG *eg,CSpriteTask *task){
	MyTask *mytask;
	TSprite *sp;
	TVec *vec;
	mytask=GetMyTask(eg);
	if(!mytask)return;
	sp=CSpriteTaskGetSprite(task);
	vec=TSpriteGetPosition(sp);
	if(vec->y>240){
		mytask->decoy_on=0;
		CEGDeleteTask(eg,task);
	}
}

void mymove(
	CEG *eg
//	,CSpriteTask  *mytask
	,MyTask  *mytask
	){
	TSprite *sp;
	Test *test;
	int x,i;
	TVec *vec;
	
	test=CEGGetUserData(eg);
	
#define SPEED 512
	sp=CSpriteTaskGetSprite(mytask);
	vec=TSpriteGetPosition(sp);
	if(eg->input->button[BUTTON_RIGHT] && vec->x < 320-64 ){
		TSpriteMoveByAngle(sp,0,SPEED+mytask->speed*100);
	}else
	if(eg->input->button[BUTTON_LEFT] && vec->x > 16 ){
		TSpriteMoveByAngle(sp,128,SPEED+mytask->speed*100);
	}else{
		TSpriteMoveByAngle(sp,128,0);
	}
	
	if(mytask->bullet_left>0)
	if(eg->input->button[BUTTON_0]||eg->input->button[BUTTON_1]){
		MyBullet *sptask;
		static TMotionSpec tama0[]={
			{64,256,1024},
			{0,0,0},
		};
		static TMotionSpec tama1[]={
			{64,384,1024},
			{0,0,0},
		};
		static TMotionSpec tama2[]={
			{120,384,5},
			{105,384,4},
			{90,384,4},
			{64,384,3},
			{31,384,4},
			{15,384,4},
			{7,384,5},
			{15,384,4},
			{31,384,4},
			{64,384,3},
			{90,384,4},
			{105,384,4},
			{0,0,0},
		};
		static TMotionSpec tama3[]={
			{120,512,5},
			{105,512,4},
			{90,512,4},
			{64,512,3},
			{31,512,4},
			{15,512,4},
			{7,512,5},
			{15,512,4},
			{31,512,4},
			{64,512,3},
			{90,512,4},
			{105,512,4},
			{0,0,0},
		};
		static TMotionSpec *tama_table[]={tama0,tama1,tama2,tama3,tama3};
		TMotionSpec *tama;
		TSprite *sp_tama;
		int tmspeed=256;
		int bitmap;
		
		sptask=CSpriteTaskCreate(eg,sizeof(MyBullet),my_bullet_check);
		//CSpriteTaskSetDestroy(sptask,recover_bullet);
		sp_tama=CSpriteTaskGetSprite(sptask);
		vec=TSpriteGetPosition(sp);
		if(eg->input->button[BUTTON_0])
			x=vec->x-8;
			else
			x=vec->x+48;
			
//		if(mytask->weapon_lv>=1)tmspeed+=128;
//		if(mytask->weapon_lv>=3)tmspeed+=128;
		bitmap=11;
		if(mytask->weapon_lv>0)bitmap=30+mytask->weapon_lv;
		
		TSpriteSetPosition(sp_tama,toVec(x,34+8));
		TSpriteSetBmpsAnime(sp_tama,test->chara,bitmap);
//		TSpriteMoveByAngle(sp_tama,64,tmspeed);
		tama=tama_table[mytask->weapon_lv];
		CSpriteTaskSetMotion(eg,sptask,tama);
		TSpriteShow(sp_tama);
		
		mytask->bullet_left--;
		
	}
	//decoy
	if(
		eg->input->button[BUTTON_2]
		&&
		mytask->decoy_on==0
		&&
		mytask->decoy_left>0){
		
		CSpriteTask *decoytask;
		TSprite *sp_decoy;
		
		decoytask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),my_decoy_check);
		CTaskSetID(decoytask,ID_DECOY);
		sp_decoy=CSpriteTaskGetSprite(decoytask);
		vec=TSpriteGetPosition(sp);
		TSpriteSetPosition(sp_decoy,toVec(vec->x+24-8,34+8));
		TSpriteSetBmps(sp_decoy,test->chara,12,0);
		TSpriteMoveByAngle(sp_decoy,64,1000);
		TSpriteShow(sp_decoy);
		
		mytask->decoy_left--;
		mytask->decoy_on=1;
	}
	
	for(i=0;i<MAXBULLETS;++i){
		sp=CSpriteTaskGetSprite(mytask->show_bullets[i]);
		if(i<mytask->bullet_left){
			TSpriteShow(sp);
		}else{
			TSpriteHide(sp);
		}
	}
	for(i=0;i<MAX_SPEED;++i){
		sp=CSpriteTaskGetSprite(mytask->show_speed[i]);
		if(i<mytask->speed){
			TSpriteSetBmps(sp,test->chara,45,0);
		}else{
			TSpriteSetBmps(sp,test->chara,44,0);
		}
	}
	for(i=0;i<MAX_DECOY;++i){
		sp=CSpriteTaskGetSprite(mytask->show_decoy[i]);
		if(i<mytask->decoy_left){
			TSpriteSetBmps(sp,test->chara,47,0);
		}else{
			TSpriteSetBmps(sp,test->chara,46,0);
		}
	}
	

}


/* score display*/
void SetScore(CEG *eg,CStringTask *task){
	char buf[100];
	
	void *backup;
	MyTask *mytask;
	Test *test;
//	backup=CEGGetCurrentTask(eg);
//	CEGTaskRewind(eg);
//	mytask=CEGGetTaskByID(eg,ID_ME);
//	CEGSetCurrentTask(eg,backup);
//	mytask=GetMyTask(eg);
	test=CEGGetUserData(eg);
	
	sprintf(buf,"SCORE %7d0 pts."
		,test->score
//		,mytask->bullet_left
		);
	CStringTaskSetString(task,buf);
	
}
void CreateScoreDisplayString(CEG *eg){
	Test *user_data;
	CStringTask *task;
	
	user_data=CEGGetUserData(eg);
	task=CStringTaskCreate(eg,sizeof(CStringTask),SetScore,40);
	CStringTaskSetResource(task,user_data->number,20);
	CStringTaskSetPos(task,toVec(0,0));
	CStringTaskSetString(task,"");
}

/**/
void StringCheck1(CEG *eg,CStringTask *task){
	char buf[100];
	
	sprintf(buf,"FPS(%3d) TASK(%4d)"
		,CEGGetFPS(eg)
		,CListGetElementNumber(eg->task_list)
		);
	CStringTaskSetString(task,buf);
	
}
void CreateString(CEG *eg){
	Test *user_data;
	CStringTask *task;
	
	user_data=CEGGetUserData(eg);
	task=CStringTaskCreate(eg,sizeof(CStringTask),StringCheck1,40);
	CStringTaskSetResource(task,user_data->number,20);
	CStringTaskSetPos(task,toVec(0,224));
	CStringTaskSetString(task,"");
}



void game_initialize(CEG *eg){
	Test *test;
	MyTask *mytask;
	TSprite *sp;
	Tsp_spec sp_spec={0,0,30,0,1};
	CSpriteTask *sptask;
	CTask *enemy_create_task;
	int i;
	
	
	CEGSetSpLayer(eg,0);
	
	
	test=CEGGetUserData(eg);
	test->score=0;
	test->killed=0;
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec);
	memset(&test->item_ready,0,sizeof(test->item_ready));
	
	
	CEGSetSpLayer(eg,1);
	
	mytask=CSpriteTaskCreate(eg,sizeof(MyTask),mymove);
	CTaskSetID(mytask,ID_ME);
//	mytask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),mymove);
	sp=CSpriteTaskGetSprite(mytask);
	TSpriteSetPosition(sp,toVec(160-24,34));
	TSpriteSetBmps(sp,test->chara,10,0);
	TSpriteShow(sp);
	mytask->bullet_left=INITIALBULLETS;
	mytask->now_bullets=INITIALBULLETS;
	mytask->decoy_on=0;
	mytask->decoy_left=0;
	mytask->speed=0;
	
	for(i=0;i<MAXBULLETS;++i){
		mytask->show_bullets[i]=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(mytask->show_bullets[i]);
		TSpriteSetPosition(sp,toVec(i*8+160-8*4,20));
		TSpriteSetBmps(sp,test->chara,11,0);
	}
	for(i=0;i<MAX_DECOY;++i){
		mytask->show_decoy[i]=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(mytask->show_decoy[i]);
		TSpriteSetPosition(sp,toVec(i*8+220,20));
		TSpriteSetBmps(sp,test->chara,46,0);
		TSpriteShow(sp);
	}
	for(i=0;i<MAX_SPEED;++i){
		mytask->show_speed[i]=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(mytask->show_speed[i]);
		TSpriteSetPosition(sp,toVec(i*12,20));
		TSpriteSetBmps(sp,test->chara,44,0);
		TSpriteShow(sp);
	}
	
	enemy_create_task=CTaskInit(enemy_create,sizeof(CTask));
	CEGAddTask(eg,enemy_create_task);
	
//	if(test->radar_on){
		CEGSetSpLayer(eg,4);
		sptask=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(sptask);
		TSpriteSetPosition(sp,toVec(110,170));
		TSpriteSetBmps(sp,test->chara,40,0);
		TSpriteShow(sp);
		CEGSetSpLayer(eg,1);
//	}
	test->radar_on=1;
	
	
//	CreateString(eg);
	CreateScoreDisplayString(eg);

}

/*****************************************************************/
/* title operation task */


int highscore_set(CEG *eg);


typedef struct{
	CTaskPrivate private;
	int selected;
	CSpriteTask* items[3];
}TitleSelect;

void title_select_check(CEG *eg,TitleSelect *title_select){
	int i;
	TSprite *sp;
	Test *test;
	
	test=CEGGetUserData(eg);
	
	
	if(eg->input->button[BUTTON_UP] && title_select->selected>0 ){
		title_select->selected--;
	}else
	if(eg->input->button[BUTTON_DOWN] && title_select->selected<2 ){
		title_select->selected++;
	}else
	if(eg->input->button[BUTTON_0]){
		CInputUnholdArrows(eg->input);
		switch(title_select->selected){
			case 0:{
				CEGClearTask(eg);
				game_initialize(eg);
				return;
			}break;
			case 1:{
				CEGClearTask(eg);
				highscore_set(eg);
				return;
			}break;
			case 2:{
				CEGEnd(eg);
				
			}
		}
		
	}
	for(i=0;i<3;++i){
		sp=CSpriteTaskGetSprite(title_select->items[i]);
		if(i==title_select->selected)
			TSpriteSetBmps(sp,test->chara,21+i,1);
		else
			TSpriteSetBmps(sp,test->chara,21+i,0);
	}
}


int title_set(CEG *eg){
	TitleSelect *title_select;
	Tsp_spec sp_spec={0,0,30,0,1};
	Tsp_spec sp_spec2={0,0,20,0,1};//for title
	TSprite *sp;
	CSpriteTask *sptask;
	int i;
	Test *test;
	CTask *task;
	
	CEGSetSpLayer(eg,0);
	test=CEGGetUserData(eg);
	//title
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec2);
	//back sea
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec);
	
	CEGSetSpLayer(eg,2);
	
	title_select=CTaskInit(title_select_check,sizeof(TitleSelect));
	for(i=0;i<3;++i){
		title_select->items[i]=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
		sp=CSpriteTaskGetSprite(title_select->items[i]);
		TSpriteSetPosition(sp,toVec(110,i*40+110));
		TSpriteSetBmps(sp,test->chara,21+i,0);
		TSpriteShow(sp);
		
	}
	title_select->selected=0;
	CEGAddTask(eg,(CTask *)title_select);
	
	CEGSetSpLayer(eg,1);
	test->radar_on=0;
	task=CTaskInit(enemy_create,sizeof(CTask));
	CEGAddTask(eg,task);
	
	CInputHoldArrows(eg->input);
	
}


/******************************************************************/
/** high score**/
typedef struct{
	CTaskPrivate private;
	int selected;
	CStringTask* items[5];
}HighScore;

void highscore_check(CEG *eg,HighScore *task){
	if(eg->input->button[BUTTON_0]){
		CInputUnholdArrows(eg->input);
		CEGClearTask(eg);
		title_set(eg);
	}
}

int highscore_set(CEG *eg){
	HighScore *high_score;
	Tsp_spec sp_spec={0,0,30,0,1};
	Tsp_spec sp_spec2={60,20,24,0,1};
	TSprite *sp;
	CSpriteTask *sptask;
	int i;
	Test *test;
	char buf[20];
	
	CEGSetSpLayer(eg,0);
	test=CEGGetUserData(eg);
	//highscore
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec2);
	//back sea
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec);
	CEGSetSpLayer(eg,1);
	
	high_score=CTaskInit(highscore_check,sizeof(HighScore));
	for(i=0;i<5;++i){
	
		high_score->items[i]=CStringTaskCreate(eg,sizeof(CStringTask),NULL,40);
		CStringTaskSetResource(high_score->items[i],test->number,20);
		CStringTaskSetPos(high_score->items[i],toVec(0,i*24+60));
		sprintf(buf," %3s %7d0 pts.",test->highscore[i].name,test->highscore[i].score);
		CStringTaskSetString(high_score->items[i],buf);
		
	}
		

	
	CEGAddTask(eg,(CTask *)high_score);
	
	
	
	CInputHoldArrows(eg->input);
	
}

int set_initial_highscore(CEG *eg){
	Test *test;
	static TScore initial_score[5]={
		{"M.N",1000},
		{"Z.T",500},
		{"K.K",300},
		{"TKF",200},
		{"ZNA",100},
	};
	int i;
	test=CEGGetUserData(eg);
	for(i=0;i<5;++i){
		
		test->highscore[i]=initial_score[i];
		
	}
	return;
}

/******************************************************************/
/** name entry**/
typedef struct{
	CTaskPrivate private;
	int selected;
	int x;
	TScore *score;
//	char name[4];
	CStringTask* entry;
	CSpriteTask *cursor;
}NameEntry;

void nameentry_check(CEG *eg,NameEntry *task){
	TSprite *sp;
	static char *char_sheet="ABCDEFGHIJKLMNOPQRSTUVWXYZ.";
	TVec vec;
	Test *test;
	char buf[40];
	
	test=CEGGetUserData(eg);
	
	if(eg->input->button[BUTTON_0]){
		CInputUnholdArrows(eg->input);
		CEGClearTask(eg);
		highscore_set(eg);
		return;
	}
	sp=CSpriteTaskGetSprite(task->cursor);
	if(!TSpriteIsMoving(sp)){
		if(eg->input->button[BUTTON_DOWN]){
			task->selected=(task->selected+27-1)%27;
		}
		if(eg->input->button[BUTTON_UP]){
			task->selected=(task->selected+1)%27;
		}
		if(eg->input->button[BUTTON_LEFT] && task->x>0){
			vec=*TSpriteGetPosition(sp);
			vec.x-=16;
			TSpriteMoveTo(sp,&vec,5);
			task->x--;
			task->selected=task->score->name[task->x]-'A';
			if(task->selected<0)task->selected=26;
		}
		if(eg->input->button[BUTTON_RIGHT] && task->x<2){
			vec=*TSpriteGetPosition(sp);
			vec.x+=16;
			TSpriteMoveTo(sp,&vec,5);
			task->x++;
			task->selected=task->score->name[task->x]-'A';
			if(task->selected<0)task->selected=26;
		}
	}
	task->score->name[task->x]=char_sheet[task->selected];
	sprintf(buf," %3s %7d0 pts.",task->score->name,test->score);
	CStringTaskSetString(task->entry,buf);

}

void nameentry_set(CEG *eg,int rank){
	NameEntry *name_entry;
	Tsp_spec sp_spec={0,0,30,0,1};
	Tsp_spec sp_spec2={60,20,25,0,1};
	TSprite *sp;
	CSpriteTask *sptask;
	int i;
	Test *test;
	CStringTask *str_task;
	char buf[40];

	CEGSetSpLayer(eg,0);

	test=CEGGetUserData(eg);
	//highscore
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec2);
	//back sea
	sptask=sp_bmps_setter(eg,test->chara,&sp_spec);
	CEGSetSpLayer(eg,1);
	
	name_entry=CTaskInit(nameentry_check,sizeof(NameEntry));
	name_entry->entry=CStringTaskCreate(eg,sizeof(CStringTask),NULL,40);
	str_task=name_entry->entry;
	CStringTaskSetResource(str_task,test->number,20);
		CStringTaskSetPos(str_task,toVec(0,100));
		sprintf(buf," AAA %7d0 pts.",test->score);
		CStringTaskSetString(str_task,buf);
		
	
	name_entry->cursor=CSpriteTaskCreate(eg,sizeof(CSpriteTask),NULL);
	sp=CSpriteTaskGetSprite(name_entry->cursor);
	TSpriteSetPosition(sp,toVec(8,100-8));
	TSpriteSetBmps(sp,test->chara,26,0);
	TSpriteShow(sp);
	
	name_entry->score=&test->highscore[rank];
	CEGAddTask(eg,(CTask *)name_entry);
	
	CInputHoldArrows(eg->input);
	
}
/*

	initialization task

*/

void Fin(CEG *eg,CTask *task){
	Test *test;
	test=CEGGetUserData(eg);
	CBmpsFree(test->number);
	CBmpsFree(test->chara);
}
void Init(CEG* eg,CTask* me){
	int i;
	static Test test;
	CTask *task;
	memset(&test,0,sizeof(Test));
	
	test.number=CBmpsInit(128);
	CBmpsLoadFromFileDir(test.number,"./num2/");
	CBmpsConvert(test.number);
	
	test.chara=CBmpsInit(128);
	CBmpsLoadFromFileDir(test.chara,"./depthbmp/");
	CBmpsConvert(test.chara);
	
	CEGSetUserData(eg,&test);
	
	task=CTaskInit(Fin,sizeof(CTask));
	CEGAddTask(eg,task);
	CTaskSetDelay(task,TASKDELAY_ATEXIT);
	
	set_initial_highscore(eg);
	//game_initialize(eg);
	title_set(eg);
	
	CEGDeleteTask(eg,me);
}



int main(int argc,char *argv[]){

	CEG* eg;
	CEGSpec spec={
		320,240,32,SDL_SWSURFACE|SDL_ANYFORMAT|SDL_FULLSCREEN,1,0,30,
		"Depth ver 0.01"
	};
	
	eg=CEGInit();
	if(CEGSetup(eg,&spec)){
		CEGFree(eg);
		exit (1);
	}
	
	CEGStart(eg,Init);
	
	CEGFree(eg);
}

