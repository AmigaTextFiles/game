#include <unistd.h>
#include <Fl/fl_ask.h>
#include <Fl/Fl_Help_Dialog.h>

Fl_Help_Dialog Help_Window;

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include "mainwindow.h"
#include "cards.h"

int order[52];
int state[52];
int ondesk[52];
int ondesksel[52];
int ondesknr;
int mine[3];
int your[3];
int minesel[3];
int yoursel[3];
int minenr,yournr;
int score[4];
int gamestate=0;
int player=1;
int last;
int nrace[2];

int drawpos;
int conversion[52];
int finished;

Fl_GIF_Image *cards[52];
Fl_GIF_Image *deck;

// ----====

Fl_Box *boxes[12];

void set_box_to(int pos,int v)
{
    if (v) boxes[pos]->color(FL_RED);
      else boxes[pos]->color(FL_WHITE);
    boxes[pos]->redraw();
}

// ----====

int init_cards(const char *path)
{
    int rndseed=time(0);
    char buff[256];
//    printf("rndseed=%d\n",rndseed);
    srand(rndseed);
    for(int i=0;i<52;i++){
        sprintf(buff,"%s%d.gif",path,i+1);
        cards[i]=new Fl_GIF_Image(buff);
        if (i<4) conversion[i]=i; else {
            int nr=i/4;
            int tp=i%4;
            conversion[i]=(13-nr)*4+tp;
        }
    }
    sprintf(buff,"%s%s.gif",path,"deck");
    deck=new Fl_GIF_Image(buff);
    return 1;
}

void init_boxes()
{
    boxes[0]=P0A0;boxes[6]=P1A0;
    boxes[1]=P0A1;boxes[7]=P1A1;
    boxes[2]=P0A2;boxes[8]=P1A2;
    boxes[3]=P0A3;boxes[9]=P1A3;
    boxes[4]=P010;boxes[10]=P110;
    boxes[5]=P02 ;boxes[11]=P12;
}

// ----====

#define value_of(card) (((card)/4)+1)
#define colour_of(card) ((card)%4)

void my_sleep(int usec)
{
    Fl::redraw();
    Fl::check();
//    usleep(usec);
    int start=clock();
    int clks=usec*CLOCKS_PER_SEC/1000000;
    int end=start+clks;
    while (1){
        int ctime=clock();
        if (ctime>end) break;
    }
//    fl_message("OK ?");
}

void show_scores()
{
    char buff[8];
    sprintf(buff,"%d",score[0]);
    MeOut->value(buff);
    MeOut->redraw();
    sprintf(buff,"%d",score[1]);
    YouOut->value(buff);
    YouOut->redraw();
}

void set_player(int np)
{
    player=np;
    if (player==0){
        MeOut->labelcolor(FL_GREEN);
        YouOut->labelcolor(FL_BLACK);
    } else {
        MeOut->labelcolor(FL_BLACK);
        YouOut->labelcolor(FL_GREEN);
    }
}

int next_card()
{
    return order[drawpos++];
}

int draw()
{
    minenr=yournr=0;
    if (drawpos==52) return 0; // end
    for(int i=0;i<3;i++){
        mine[i]=next_card();
        minenr++;
        my_sleep(100000);
        your[i]=next_card();
        yournr++;
        my_sleep(100000);
        minesel[i]=yoursel[i]=0;
    }
    Progress->minimum(4);
    Progress->maximum(52);
    Progress->value(drawpos);
    Progress->redraw();
    return 1;
}

void mixcards()
{
    int used[52];
    for(int i=0;i<52;i++) used[i]=0;
    for(int i=0;i<52;i++){
        int card;
        do{
            card=rand()%52;
        } while (used[card]);
        used[card]=1;
        order[i]=card;
        ondesksel[i]=0;
        state[i]=0;
    }
/*
    order[0]=0;
    order[1]=12;
    order[2]=24;
    order[5]=17;
    order[7]=25;
*/
/*
    order[0]=0;
    order[1]=1;
    order[2]=2;
    order[3]=51;
    order[4]=8;
    order[6]=25;
    order[7]=33;
*/
    drawpos=0;
    ondesknr=0;
    for(int i=0;i<4;i++){
        ondesk[i]=next_card();
        ondesknr++;
        my_sleep(100000);
    }
    draw();
}

void go_ai_go();

void init_1game()
{
    score[0]=score[1]=nrace[0]=nrace[1]=0;
    minenr=yournr=0;
    for(int i=0;i<12;i++)
        set_box_to(i,0);
    finished=0;
    mixcards();
    show_scores();
    Fl::redraw();
    if (player==0)
        go_ai_go();
}

static int lock_init_game=0;

void init_game()
{
    if (lock_init_game) return;
    lock_init_game=1;
    set_player(1);
    last=-1;
//    set_player(0);
    score[2]=score[3]=0;
    gamestate=1;
    ScoreBoard->clear();
    init_1game();
    lock_init_game=0;
}

void delete_card(int cards[],int &nr,int pos)
{
    nr--;
    for(int i=pos;i<nr;i++)
        cards[i]=cards[i+1];
    Fl::redraw();
}

void add_card(int card)
{
    ondesk[ondesknr++]=card;
    Fl::redraw();
}

void next_player()
{
    for(int i=0;i<3;i++){
        minesel[i]=yoursel[i]=0;
    }
    for(int i=0;i<52;i++)
        ondesksel[i]=0;
    Fl::redraw();
    set_player(1-player);
    check_game();
}

void cb_opt(Fl_Button*,void*)
{
}

void cb_new(Fl_Button*,void*)
{
    init_game();
}

void cb_help(Fl_Button*,void*)
{
    Help_Window.load("help.htm");
    Help_Window.show();
}

void cb_exit(Fl_Button*b,void*)
{
    b->window()->hide();
}

int poss[14][10];
int possnr[14];

void init_poss()
{
    for(int i=0;i<14;i++) possnr[i]=0;
}

void add_to_poss(int w,int v)
{
    poss[w][possnr[w]++]=v;
}

void copy_poss(int f,int t)
{
    for(int i=0;i<possnr[f];i++)
        add_to_poss(t,poss[f][i]);
}

void new_nr_to_poss(int v)
{
    for(int i=13-v;i>0;i--)
        if ((possnr[i+v]==0)&&(possnr[i]!=0)){
            copy_poss(i,i+v);
            add_to_poss(i+v,v);
        }
    if (possnr[v]==0) add_to_poss(v,v);
}

int make_sum(int cards[],int &nr,int sum)
{
    for(int i=0;i<nr;i++){
        new_nr_to_poss(cards[i]);
        if (possnr[sum]) return 1;
    }
    return 0;
}

void del_from(int *cards,int &nr,int card)
{
    for(int i=0;i<nr;i++)
        if (cards[i]==card){
            delete_card(cards,nr,i);
            break;
        }
}

int used[10],usednr;

int check_psum(int *cards,int &nr,int sum,int pcards[],int psel[],int pnr)
{
    usednr=0;
    for(int i=0;i<possnr[sum];i++){
        int card=poss[sum][i];
        used[usednr++]=card;
        del_from(cards,nr,card);
    }
    init_poss();
    for(int i=0;i<usednr;i++)
        new_nr_to_poss(used[i]);
    for(int i=0;i<pnr;i++)
      if (psel[i]){
        int nsum=sum-value_of(pcards[i]);
        if (possnr[nsum]) return 0;
      }
    return 1;
}

int check_sum(int cards[],int &nr,int sum,int pcards[],int psel[],int pnr)
{
    int good=0;
    while (nr){
        init_poss();
        if (!make_sum(cards,nr,sum)) return 0;
        if (check_psum(cards,nr,sum,pcards,psel,pnr))
            good++;
    }
    if (good) return 1; else return 2;
}

int check_sums(int cards[],int sel[],int &nr,int sum)
{
    int sels[52],selnr=0;
    for(int i=0;i<ondesknr;i++){
        if (ondesksel[i])
            sels[selnr++]=value_of(ondesk[i]);
    }
    return check_sum(sels,selnr,sum,cards,sel,nr);
}

void player_got(int card,int p)
{
    state[card]=2+p;
    switch(card){
        case 0:case 1:case 2:case 3: // ace
            score[p]++;
            set_box_to(p*6+nrace[p],1);
            nrace[p]++;
            show_scores();
          break;
        case ROMB10:
            score[p]+=2;
            set_box_to(p*6+4,1);
            show_scores();
          break;
        case PIKK2:
            score[p]+=1;
            set_box_to(p*6+5,1);
            show_scores();
          break;
    }
}

void gets_player(int p)
{
    int *cards=(p)?your:mine;
    int &cnr=(p)?yournr:minenr;
    int *csel=(p)?yoursel:minesel;
    for(int i=cnr-1;i>=0;i--)
        if (csel[i]){
            int card=cards[i];
            delete_card(cards,cnr,i);
            player_got(card,p);
        }
    for(int i=ondesknr-1;i>=0;i--)
        if (ondesksel[i]){
            int card=ondesk[i];
            delete_card(ondesk,ondesknr,i);
            player_got(card,p);
        }
    if (ondesknr==0&&!finished){
        score[p]++;
        show_scores();
    }
    last=p;
}

void cb_get(Fl_Button*,void*)
{
    if (player!=1||gamestate!=1) return;
    int count=0,sum=0;
    for(int i=0;i<yournr;i++)
        if (yoursel[i]){
            count++;
            sum+=value_of(your[i]);
        }
    if (sum>13){
        fl_alert("The maximum sum is 13!");
        return;
    }
    if (count==0){
       fl_alert("Please choose at least one card from you!");
       return;
    }
    int dcount=0,dsum=0;
    for(int i=0;i<ondesknr;i++)
        if (ondesksel[i]){
            dcount++;
            dsum+=value_of(ondesk[i]);
        }
    if (dcount==0){
        fl_alert("Please choose at least one card from the desk!");
        return;
    }
    if (dsum%sum!=0){
        fl_alert("Invalid sum !");
        return;
    }
    switch (check_sums(your,yoursel,yournr,sum)){
        case 0:
          fl_alert("You can\'t do that !");
          return;
        case 2:
          fl_alert("You can do this only in two steps!");
          return;
    }
    gets_player(1);
    next_player();
}

void cb_drop(Fl_Button*,void*)
{
    if (player!=1||gamestate!=1) return;
    int count=0,sel=-1;
    for(int i=0;i<yournr;i++)
        if (yoursel[i]){
            count++;
            sel=i;
        }
    if (count!=1){
        fl_alert("You have to select exactly one card to drop!");
        return;
    }
    int card=your[sel];
    delete_card(your,yournr,sel);
    add_card(card);
    next_player();
}

void end_game()
{
    finished=1;
    // the last player gets the rest on the desk
    for(int i=0;i<ondesknr;i++)
        ondesksel[i]=1;
    if (last!=-1)
        gets_player(last);
    // now calculate the number of cards
    int nr[2]={0,0},nrp[2]={0,0};
    for(int i=0;i<52;i++){
        int p=state[i]-2;
        if (p!=0&&p!=1){
            fl_alert("Internal error: card whithout owner: %d",i);
        }
        nr[p]++;
        if (colour_of(i)==PIKK)
            nrp[p]++;
    }
    for(int i=0;i<2;i++){
        if (nr[i]>26)
            score[i]+=2;
        if (nrp[i]>6)
            score[i]+=1;
    }
    if (score[0]>score[1])
        fl_message("I won ! (%d:%d)",score[0],score[1]);
    else
    if (score[0]<score[1])
        fl_message("You won ! (%d:%d)",score[0],score[1]);
    else
        fl_message("Equality ! (%d:%d)",score[0],score[1]);
    score[2]+=score[0];
    score[3]+=score[1];
    char buff[32];
    sprintf(buff,"%4d | %4d",score[2],score[3]);
    ScoreBoard->add(buff);
    show_scores();
    init_1game();
}

void check_game()
{
    if (minenr==0&&yournr==0){
        if (!draw()){
            // end game
            end_game();
            return;
        }
    }
    if (player==1&&yournr==0)
        next_player();
    else
    if (player==0)
        go_ai_go();
}


// ----====
int *pcard_,*pcard_sel,pcard_nr;

int best_g_value;
int best_g_desk[52];
int best_g_hand[3];
int best_d_value;
int best_d_desk[52];
int best_d_hand[3];

int card_value(int card)
{
    int val=1;
    if (card<4) val+=1000;
    if (colour_of(card)==PIKK) val+=4;
    if (card==ROMB10) val+=2000;
    if (card==PIKK2) val+=1000;
    return val;
}

void evaluate()
{
    int v=0;
    for(int i=0;i<pcard_nr;i++){
        if(pcard_sel[i])
            v+=card_value(pcard_[i]);
    }
    for(int i=0;i<ondesknr;i++){
        if(ondesksel[i])
            v+=card_value(ondesk[i]);
    }
    if (v>best_g_value){
        best_g_value=v;
        for(int i=0;i<ondesknr;i++)
            best_g_desk[i]=ondesksel[i];
        for(int i=0;i<pcard_nr;i++)
            best_g_hand[i]=pcard_sel[i];
    }
}

int ai_got_desk(int dsum,int hsum)
{
    if (dsum<hsum) return 0;
    if (dsum%hsum!=0) return 0;
    // now we have both a configuration of the hand and of the desk
    int ret=check_sums(pcard_,pcard_sel,pcard_nr,hsum);
    if (ret!=1) return 0;
    // well, we have a good configartion
    // lets evaluate it
    evaluate();
    return 0;
}

int ai_rec_desk(int step,int csum,int hsum)
{
    if (step>=ondesknr) return ai_got_desk(csum,hsum);
    int cv=value_of(ondesk[step]);
    ondesksel[step]=0;
    if (ai_rec_desk(step+1,csum,hsum)) return 1;
    ondesksel[step]=1;
    if (ai_rec_desk(step+1,csum+cv,hsum)) return 1;
    return 0;
}

int ai_got_hand(int hsum)
{
    if (hsum==0) return 0;
    // now we have a selection in the hand
    // and now try each configuartion of the desk
    return ai_rec_desk(0,0,hsum);
}

int ai_rec_hand(int step,int csum)
{
    if (step>=pcard_nr) return ai_got_hand(csum);
    int cv=value_of(pcard_[step]);
    pcard_sel[step]=0;
    if (ai_rec_hand(step+1,csum)) return 1;
    if (csum+cv<=13){
        pcard_sel[step]=1;
        if (ai_rec_hand(step+1,csum+cv)) return 1;
    }
    return 0;
}

int ai_try_get_(){
    if (pcard_nr>0&&ondesknr>0){
        best_g_value=best_d_value-1;
        ai_rec_hand(0,0);
        if (best_g_value>0){
            // we have out choice
            for(int i=0;i<ondesknr;i++)
                ondesksel[i]=best_g_desk[i];
            for(int i=0;i<pcard_nr;i++)
                pcard_sel[i]=best_g_hand[i];
            return 1;
        }
    }
    for(int i=0;i<ondesknr;ondesksel[i++]=0);
    for(int i=0;i<pcard_nr;pcard_sel[i++]=0);
    return 0;
}

int ai_try_get(){
    int ret=ai_try_get_();
    if (ret){
       my_sleep(1000000);
       gets_player(0);
    }
    return ret;
}

int ai_try_drop_()
{
    if (pcard_nr==0) return -1;
    int min=pcard_[0],minpos=0;
    for(int i=1;i<pcard_nr;i++)
        if (pcard_[i]<min){
            min=pcard_[i];
            minpos=i;
        }
    int card=pcard_[minpos];
    pcard_sel[minpos]=1;
    return minpos;
}

int ai_try_drop()
{
    int minpos=ai_try_drop_();
    int ret=(minpos>=0);
    if (ret){
        my_sleep(1000000);
        int card=mine[minpos];
        delete_card(mine,minenr,minpos);
        add_card(card);
    }
    return ret;
}
    

void go_ai_go()
{
    pcard_=mine;
    pcard_sel=minesel;
    pcard_nr=minenr;
    if (!ai_try_get())
    ai_try_drop();
    next_player();
}

void cb_hint(Fl_Button*,void*)
{
    pcard_=your;
    pcard_sel=yoursel;
    pcard_nr=yournr;
    for(int i=0;i<ondesknr;ondesksel[i++]=0);
    for(int i=0;i<pcard_nr;pcard_sel[i++]=0);
    if (!ai_try_get_()){
      int sel=ai_try_drop_();
      if (sel>=0)
          yoursel[sel]=1;
    }
    Fl::redraw();
}


