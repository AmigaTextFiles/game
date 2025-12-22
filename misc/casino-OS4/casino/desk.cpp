#include <Fl/Fl.h>
#include <Fl/fl_draw.h>

#include "desk.h"
#include "cards.h"

int MINE_X,MINE_Y,YOUR_X,YOUR_Y,DESK_X,DESK_Y,DESK_LIM;

void init_xy(int w,int h){
    MINE_X=(w-3*80)/2;
    MINE_Y=4;
    YOUR_X=MINE_X;
    YOUR_Y=h-96-4;
    DESK_X=10;
    DESK_Y=(h-96)/2;
    DESK_LIM=(w-20)/80;
}

Desk::Desk(int x,int y,int w,int h,const char *l)
  :Fl_Widget(x,y,w,h,l)
{
}

Desk::~Desk()
{
}

void draw_card(int x,int y,int card,int sel)
{
    if (sel){
        fl_color(FL_BLACK);
        fl_rectf(x-4,y-4,72+8,96+8);
    }
    if (card==-1)
        deck->draw(x,y);
    else
        cards[conversion[card]]->draw(x,y);
}

void draw_mine(int x,int y)
{
    for(int i=0;i<minenr;i++){
        int card=(minesel[i])?mine[i]:-1;
        draw_card(x+i*80,y,card,minesel[i]);
    }
}

void draw_your(int x,int y)
{
    for(int i=0;i<yournr;i++)
        draw_card(x+i*80,y,your[i],yoursel[i]);
}

void draw_desk(int x,int y,int w)
{
    int delta=80;
    if (ondesknr>DESK_LIM)
        delta=(w-(2*DESK_X)-72)/(ondesknr-1);
    for(int i=0;i<ondesknr;i++)
        draw_card(x+i*delta,y,ondesk[i],ondesksel[i]);
}

void Desk::draw()
{
    draw_box();
    if (gamestate){
        init_xy(w(),h());
        draw_mine(x()+MINE_X,y()+MINE_Y);
        draw_your(x()+YOUR_X,y()+YOUR_Y);
        draw_desk(x()+DESK_X,y()+DESK_Y,w());
    } else {
        draw_label();
    }
}

void clicked_at(int mx,int my,int w)
{
    if (my>=DESK_Y&&my<DESK_Y+96){
        int delta=80;
        if (ondesknr>DESK_LIM)
            delta=(w-(2*DESK_X)-72)/(ondesknr-1);
        for(int i=ondesknr-1;i>=0;i--)
            if (mx>=DESK_X+i*delta&&mx<DESK_X+i*delta+72){
                // clicked on a card on the desktop
                ondesksel[i]=!ondesksel[i];
                Fl::redraw();
                break;
            }
    } else
    if (my>=YOUR_Y&&my<YOUR_Y+96){
        for(int i=0;i<yournr;i++)
            if (mx>=YOUR_X+i*80&&mx<YOUR_X+i*80+72){
                // clicked on his card
                yoursel[i]=!yoursel[i];
                Fl::redraw();
                break;
            }
    }
}

int Desk::handle(int act)
{
    if (player!=1||gamestate!=1) return 0;
    int mx=Fl::event_x()-x();
    int my=Fl::event_y()-y();
    init_xy(w(),h());
    switch (act){
        case FL_PUSH:
            clicked_at(mx,my,w());
            return 1;
    }
    return 0;
}
