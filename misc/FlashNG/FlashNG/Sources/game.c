/* Game.c v0.2 - Problem with Score fixed */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <dos/dos.h>

#include <clib/dos_protos.h>
#include <clib/alib_protos.h>

#include "game.h"

extern int speed, bug, bug2;

extern void MoveShape (LONG x, long y, long width, long height, long destx, long desty);
extern void MoveBall  (LONG x, long y, long width, long height, long destx, long desty);
extern void FillScreen (short x,short y,short width, short height, UBYTE color);
extern void LineH (long x,long y,long x2);

void LoadScore(struct score *score1,int rank)
{
    BPTR file;
    file=Open((STRPTR)"dat/score.dat", MODE_READWRITE);
    if (rank>1)
        Seek(file,(sizeof(struct score)*(rank-1)), OFFSET_BEGINNING);
    Read(file,(char *)score1,sizeof(struct score));
    Close(file);

}

void SaveScore(struct score *score1,int rank)
{
    BPTR file;
    file=Open((STRPTR)"dat/score.dat", MODE_READWRITE);
    if (rank>1)
        Seek(file,(sizeof(struct score)*(rank-1)), OFFSET_BEGINNING);
    Write(file,(char *)score1,sizeof(struct score));
    Close(file);

}

void DisplayGrid(struct grid *grid1)
{
    int a,b,n;
    n=0;
    for (b=0;b<=6;b++)
    {
        for (a=0;a<=10;a++)
        {
            switch(grid1->tab[a][b].colour)
            {
                case 1:MoveShape(1,5,26,14,1+a*26,4+b*14);
                       n++;
                       break;
                case 2:MoveShape(79,5,26,14,1+a*26,4+b*14);
                       n++;
                       break;
                case 3:MoveShape(105,18,26,14,1+a*26,4+b*14);
                       n++;
                       break;
                case 4:MoveShape(157,18,26,14,1+a*26,4+b*14);
                       n++;
                       //MoveShape(157,18,26,14,1+a*26,4+b*14);
                       break;
                case 5:MoveShape(1,18,26,14,1+a*26,4+b*14);
                       break;
            }
        }
    }
    grid1->taille=n;
}

void Lives(int a)
{
    int y=162, b;

    for (b=155; b<=199; b++)
        LineH(301, b, 311);

    for (b=1; b<=(a-1); b++)
    {
         MoveShape(129,124,10,9,301,y);
         y=y+10;
    }
}


void GameOver(struct score *player) //;var f:scorefile);
{
    int x,c,e;
    ULONG a,b;
    //struct score player2;

    a=10000;x=140;
    b=player->value;
    FillScreen(0,0,319,199,0);
    MoveShape(50,58,200,40,60,40);
    MoveShape(150,100,68,30,75,95);

    for (c=1;c<6;c++)
    {
        e=(b/a);
        b=b-(e*a);
        switch(e)
        {
            case 0: MoveShape(24,106,18,20,x,99);
                    break;
            case 1: MoveShape(40,106,18,20,x,99);
                    break;
            case 2: MoveShape(58,106,18,20,x,99);
                    break;
            case 3: MoveShape(76,106,18,20,x,99);
                    break;
            case 4: MoveShape(93,106,18,20,x,99);
                    break;
            case 5: MoveShape(109,106,18,20,x,99);
                    break;
            case 6: MoveShape(153,130,18,20,x,99);
                    break;
            case 7: MoveShape(171,130,18,20,x,99);
                    break;
            case 8: MoveShape(189,130,18,20,x,99);
                    break;
            case 9: MoveShape(207,130,18,20,x,99);
                    break;
        }
        x=x+16;
        a=(a/10);
    }

   /*   ==> plus Tard...
    c=1;

    repeat

         loadscore(c,player2,f);
         if player.value>player2.value then
         begin
              SaveScore(c,player,f);
              OK:=true;
         end;
         c:=c+1;
    until (OK) or (c=6);
 */
}

void DisplayScore(struct grid *player) //;var f:scorefile);
{
    int x,c,e;
    ULONG a,b;
    //struct score player2;

    a=1000;x=296;
    b=player->scoretotal;
    //FillScreen(0,0,319,199,0);
    //MoveShape(50,58,200,40,60,40);
    //MoveShape(150,100,68,30,75,95);
    for (c=1;c<5;c++)
    {
        e=(b/a);
        b=b-(e*a);
        switch(e)
        {
            case 0: MoveShape(2,49,4,8,x,113);
                    break;
            case 1: MoveShape(7,49,4,8,x,113);
                    break;
            case 2: MoveShape(12,49,4,8,x,113);
                    break;
            case 3: MoveShape(17,49,4,8,x,113);
                    break;
            case 4: MoveShape(22,49,4,8,x,113);
                    break;
            case 5: MoveShape(27,49,4,8,x,113);
                    break;
            case 6: MoveShape(32,49,4,8,x,113);
                    break;
            case 7: MoveShape(37,49,4,8,x,113);
                    break;
            case 8: MoveShape(42,49,4,8,x,113);
                    break;
            case 9: MoveShape(47,49,4,8,x,113);
                    break;
        }
        x=x+5;
        a=(a/10);
    }

}

void DisplayLevel(int levelnumber) //;var f:scorefile);
{
    int x,c,e;
    ULONG a,b;
    //struct score player2;

    a=10;x=301;
    b=levelnumber;
    //FillScreen(0,0,319,199,0);
    //MoveShape(50,58,200,40,60,40);
    //MoveShape(150,100,68,30,75,95);
    for (c=1;c<3;c++)
    {
        e=(b/a);
        b=b-(e*a);
        switch(e)
        {
            case 0: MoveShape(2,39,4,8,x,136);
                    break;
            case 1: MoveShape(7,39,4,8,x,136);
                    break;
            case 2: MoveShape(12,39,4,8,x,136);
                    break;
            case 3: MoveShape(17,39,4,8,x,136);
                    break;
            case 4: MoveShape(22,39,4,8,x,136);
                    break;
            case 5: MoveShape(27,39,4,8,x,136);
                    break;
            case 6: MoveShape(32,39,4,8,x,136);
                    break;
            case 7: MoveShape(37,39,4,8,x,136);
                    break;
            case 8: MoveShape(42,39,4,8,x,136);
                    break;
            case 9: MoveShape(47,39,4,8,x,136);
                    break;
        }
        x=x+5;
        a=(a/10);
    }

}

void LimitMUR(struct ball *ball1,struct coords *step)
{
    if (step->x>0)
    {


        if (ball1->coin[2].x>=285)
        {
            step->x=-step->x;
            //if (son) then lucAudioPlay(smp2);
        }

        if (ball1->coin[2].y<=5)
        {
            step->y=-step->y;
            //if (son) then lucAudioPlay(smp2);
        }
        //end;
        //(* Du With *)
    }
    else
    {
        //with ball1 do
        //begin
        if (ball1->coin[1].x<=1)
        {
            //if (son) then lucAudioPlay(smp2);
            step->x=-step->x;
        }

        if (ball1->coin[1].y<=5)
        {
            step->y=-step->y;
        }
        //end; (* Du With *)
    }
}

BOOL LimitY(struct ball *ball1,int posi,struct coords *step)
{
    BOOL LimY;
    //with ball1 do
    //begin
    if ((ball1->coin[2].x>posi) && (ball1->coin[1].x<posi+48))
    {
       //if (son) then lucAudioPlay(smp);
       LimY=FALSE;
        if ((ball1->coin[2].x<=posi+12) || (ball1->coin[1].x>=posi+38))
        {

            if (step->x>0)
            {
                if (ball1->coin[2].x<=posi+12)
                {
                    if (step->x==1)
                        step->x=-2*step->x;
                    else
                        step->x=-step->x;
                }
                step->y=-step->y;
                step->z=FALSE;
            }
            else
            {
                if (ball1->coin[1].x>=posi+38)
                {
                    if (step->x==-1)
                        step->x=-2*step->x;
                    else
                        step->x=-step->x;
                }
                step->y=-step->y;
                step->z=FALSE;
            }
        }
        else
        {
            step->z=TRUE;
            if (step->x>0)
            {
                if (ball1->coin[2].x<posi+22)
                    step->x=-step->x;

                step->y=-step->y;

                if ((step->x==2) || (step->x==-2))
                    step->x=(step->x/2);
            }
            else
            {
                if (ball1->coin[1].x>posi+24)
                    step->x=-step->x;

                step->y=-step->y;

                if ((step->x==-2) || (step->x==2))
                    step->x=(step->x/2);
            }
        }
    }
    else
        LimY=TRUE;

    return(LimY);
}

void ReactTOUCHE(int cote, int x, int y,struct ball *ball1,struct coords *step,struct grid *grid1)
{
    int x2;
    BOOL angle;

    angle=FALSE;

    //with ball1 do
    //begin
    if ((step->x>0) && (x>0) && (grid1->tab[x][y].colour!=5))
    {
        switch(cote)
        {
             case 1:
                  x2=((ball1->coin[1].x)/26);
                  if (x2<x)
                      angle=TRUE;
                  break;
             case 2:
                  x2=((ball1->coin[4].x)/26);
                  if (x2<x)
                      angle=TRUE;
             break;
        }
    }
    else
    {
        switch(cote)
        {
             case 1:
                  x2=((ball1->coin[2].x)/26);
                  if (x2<x)
                      angle=TRUE;
                  break;
             case 3:
                  x2=((ball1->coin[2].x)/26);
                  if (x2<x)
                      angle=TRUE;
                  break;
        }
    }


    // End; With
    if (angle)
    {
        if ((bug2==5) && (bug==6))
        {
            bug2=0;
            bug=0;
            step->x=-step->x;
            step->y=-step->y;
        }
    }
    else
    {
        switch(cote)
        {
             case 1:
             case 3:
               if (bug==6)
               {
                   step->y=-step->y;
                   bug=2;
               }
               break;
             case 2:
             case 4:
               if (bug2==5)
               {
                   step->x=-step->x;
                   bug2=2;
               }
               break;
        }
    }

    //with grid1.tab[x,y] do
    //begin
    switch(grid1->tab[x][y].colour)
    {
        case 1:
             //if (son) then lucAudioPlay(smp3);
             for (x2=(5+y*14); x2<=(17+y*14);x2++)
                  LineH((x*26),x2,25+x*26);
             grid1->tab[x][y].colour=0;
             grid1->score=grid1->score+100;
             grid1->scoretotal=grid1->scoretotal+100;
             (grid1->taille)--;
             DisplayScore(grid1);
             break;
        case 2:
             //if (son) then lucAudioPlay(smp3);
             for (x2=(5+y*14); x2<=(17+y*14);x2++)
                  LineH((x*26),x2,25+x*26);
             grid1->tab[x][y].colour=0;
             grid1->score=grid1->score+100;
             grid1->scoretotal=grid1->scoretotal+100;
             (grid1->taille)--;
             DisplayScore(grid1);
             break;
        case 3:
             //if (son) then lucAudioPlay(smp3);
             for (x2=(5+y*14); x2<=(17+y*14);x2++)
                  LineH((x*26),x2,25+x*26);
             grid1->tab[x][y].colour=0;
             grid1->score=grid1->score+100;
             grid1->scoretotal=grid1->scoretotal+100;
             (grid1->taille)--;
             DisplayScore(grid1);
             break;
        case 4:
             //if (son) then lucAudioPlay(smp3);
             (grid1->tab[x][y].colour)--;
             grid1->score=grid1->score+100;
             grid1->scoretotal=grid1->scoretotal+100;
             MoveShape(157,5,26,14,1+x*26,4+y*14);
             DisplayScore(grid1);
             break;
        case 5:
             //if (son) then lucAudioPlay(smp2);
             break;
    } // case/Switch
    // End With

    if ((grid1->score/500)>=1)
        speed=90;

    if ((grid1->score/1000)>=1)
        speed=70;

    if ((grid1->score>1500)>=1)
        speed=45;
}

void LimitBricks(struct ball *ball1,struct coords *step,struct grid *grid1)
{
    int cote,a,x,y,x2,y2;
    int touche;
    if (bug<6) bug=bug+1;
    if (bug2<5) bug2=bug2+1;
    touche=0;a=1;cote=0;
    // 1ere etape: pour CHAQUE coin: Calcul de la case ds grid1

    //with ball1 do
    //begin
    while((touche==0)&&(a!=5))
    {
        switch (a)
        {
            case 1:
                x=((ball1->coin[a].x-2)/26);
                y=((ball1->coin[a].y-5)/14);
                x2=((ball1->coin[a+1].x-2)/26);
                y2=((ball1->coin[a].y-5)/14);
                cote=1;
                break;
            case 2:
                x=((ball1->coin[a].x-1)/26);
                y=((ball1->coin[a].y-2)/14);
                x2=((ball1->coin[a].x-1)/26);
                y2=((ball1->coin[a+1].y-5)/14);
                cote=2;
                break;
            case 3:
                x=((ball1->coin[a].x-3)/26);
                y=((ball1->coin[a].y-3)/14);
                x2=((ball1->coin[a+1].x+1)/26);
                y2=((ball1->coin[a].y-3)/14);
                cote=3;
                break;
            case 4:
                x=((ball1->coin[a].x-2)/26);
                y=((ball1->coin[a].y-6)/14);
                x2=((ball1->coin[a].x-4)/26);
                y2=((ball1->coin[a-3].y-4)/14);
                cote=4;
                break;
        }

        if (grid1->tab[x][y].colour!=0) touche=1;
        if (grid1->tab[x2][y2].colour!=0) touche=2;

        a++;
    }//until (touche<>0) or (a=5);
    if (touche==2)
        ReactTOUCHE(cote,x2,y2,ball1,step,grid1);
    else if (touche==1)
        ReactTOUCHE(cote,x,y,ball1,step,grid1);

     //end; With
}

BOOL Game_MoveBall(struct ball *ball1,int posi,struct coords *step,struct grid *grid1)
{
     BOOL DeplacB;
     int a;
     //with ball1 do
     //begin
     for (a=1;a<=4;a++)
     {
          ball1->coin[a].x=ball1->coin[a].x+step->x;
          ball1->coin[a].y=ball1->coin[a].y+step->y;
     }

     if (step->z==FALSE)
         MoveShape(140,133,10,8,ball1->coin[1].x-step->x,ball1->coin[1].y-step->y);

     {
         //FillScreen(ball1->coin[1].x-step->x,ball1->coin[1].y-step->y,10,8,0);
     }

     MoveBall(129,124,10,9,ball1->coin[1].x,ball1->coin[1].y);
     //Shape
     //end; With
     DeplacB=FALSE;

     // Les 3 tests maintenant...

     //************** Walls Tests ***************
     LimitMUR(ball1,step);
     //************** End Wall ****************

     //************** Bar Test **********
     //with ball1 do
     if (ball1->coin[3].y>=180)
     {
          //test:=TRUE;
          DeplacB=LimitY(ball1,posi,step);
     }
     //************** End Bar ************

     //************** Bricks Test  ************
     //with ball1 do
     if (ball1->coin[1].y<160)
         LimitBricks(ball1,step,grid1);
     //************** End Bricks *************
     return(DeplacB);
}

void LoadLevel(int levelnumber, struct grid *level, STRPTR filename)
{
    BPTR file;
    file=Open(filename, MODE_READWRITE);
    if (levelnumber>1)
        Seek(file,(sizeof(struct grid)*(levelnumber-1)), OFFSET_BEGINNING);
    Read(file,(char *)level,sizeof(struct grid));
    Close(file);
    //seek(f,level-1);
    //read(f,LoadLevel);
}

void SaveLevel(int levelnumber, struct grid *level, STRPTR filename)
{
    BPTR file;
    file=Open(filename, MODE_READWRITE);
    if (levelnumber>1)
        Seek(file,(sizeof(struct grid)*(levelnumber-1)), OFFSET_BEGINNING);
    Write(file,(char *)level,sizeof(struct grid));
    Close(file);
    //write(f,level);
    //SaveLevel:=0;
}
