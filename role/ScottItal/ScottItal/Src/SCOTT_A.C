/*
 *  ScottFree Revision 1.14b
 *
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version
 *  2 of the License, or (at your option) any later version.
 *
 *
 *  You must have an ANSI C compiler to build this program.
 *
 *  ===================================================================
 *
 *  Version History AMIGA:
 *  Ver ,     Date,     Author, Comment
 *  -------------------------------------------------------------------
 *  1.0 , 28/07/96, Andreas Aumayr, First public release
 *  1.1 , 30/08/96, Andreas Aumayr, Minor changes for new amiga.c
 *  1.2 , 30/10/02, Betori Alessandro, piccoli cambiamenti per
 *  il corretto rilascio della memoria 
 * 
 *  ___________________________________________________________________
 */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>

#include "Scott.h"
#include "ansi.c"
#include "protos.h"
#include "amiga6.c"

int OutputPos=0;

void *indirizzo_puntatore[1024];//Betori


void Fatal(char *x)
{
    sprintf(str_buf,"\n\n%s!\n",x);
    WriteCON(str_buf);
    Delay(200);
    close_all();
    exit(1);
}

void put_choice(void)
{
    if (RESTART) {
        OutBuf("\nVuoi (R)icaricare, ri(C)ominciare or (F)inire il gioco? ");
        Speak("Vuoi (R)icaricare, ri(C)ominciare or (F)inire il gioco?");
    }
    else {
        OutBuf("\nVuoi (R)icaricare o (F)inire il gioco? ");
        Speak("Vuoi (R)icaricare o (F)inire il gioco?");
    }
    cursor(TRUE);
}

int RandomPercent(int n)
{
    unsigned int rv=rand()<<6;
    rv=rv%100;
    if(rv<n)
        return(1);
    return(0);
}

int CountCarried()
{
    int ct=0;
    int n=0;
    while(ct<=GameHeader.NumItems)
    {
        if(Items[ct].Location==CARRIED)
            n++;
        ct++;
    }
    return(n);
}

char *MapSynonym(char *word)
{
    int n=1;
    char *tp;
    static char lastword[16];   /* Last non synonym */
    while(n<=GameHeader.NumWords)
    {
        tp=Nouns[n];
        if(*tp=='*')
            tp++;
        else
            strcpy(lastword,tp);
        if(Strnicmp(word,tp,GameHeader.WordLength)==0)
            return(lastword);
        n++;
    }
    return(NULL);
}

int MatchUpItem(char *text, int loc)
{
    char *word=MapSynonym(text);
    int ct=0;

        if(word==NULL)
        word=text;

    while(ct<=GameHeader.NumItems)
    {
        if(Items[ct].AutoGet && Items[ct].Location==loc &&
            Strnicmp(Items[ct].AutoGet,word,GameHeader.WordLength)==0)
            return(ct);
        ct++;
    }
    return(-1);
}

char *ReadString(FILE *f)
{
    char tmp[1024];
    
    char *t;
    int c,nc;
    int ct=0;
oops:   do
    {
        c=fgetc(f);
    }
    while(c!=EOF && isspace(c));
    if(c!='"')
    {
        Fatal("Iniziale apicetto atteso");
    }
    do
    {
        c=fgetc(f);
        if(c==EOF)
            Fatal("EOF nella stringa");
        if(c=='"')
        {
            nc=fgetc(f);
            if(nc!='"')
            {
                ungetc(nc,f);
                break;
            }
        }
        if(c==0x60)
            c='"'; /* pdd */
        tmp[ct++]=c;
    }
    while(1);
    tmp[ct]=0;
    t=MemAlloc(ct+1);// Alloca Memoria
    memcpy(t,tmp,ct+1);
    return(t);
}

void NextLine()
{
    WriteCON("\n");
    OutputPos = 0;
    //OutReset();
}

void Look()
{
    static char *ExitNames[6]=
    {
        "Nord","Sud","Est","Ovest","Alto","Basso"
    };
    Room *r;
    int ct,f;
    int pos;

    CON_handle = env_hdl;
    clrscr();

    if ((BitFlags&(1L<<DARKBIT)) && Items[LIGHT_SOURCE].Location!= CARRIED
       && Items[LIGHT_SOURCE].Location!= MyLoc) {
        if (Options&YOUARE) {
            WriteCON("Non puoi vedere. E' buio!\n");
            Speak("Non puoi vedere. E' buio!");
        }
        else {
            WriteCON("Non posso vedere.E' buio!\n");
            Speak("Non posso vedere. E' buio!");
        }
        if (Options & TRS80_STYLE) WriteCON(TRS80_LINE);

        if (GFX && last_pic) {
            if (LDP) Draw_Pic(0,0);
            else Open_Pic(0,PIC);
        }

        CON_handle = act_hdl;
        return;
    }

    r=&Rooms[MyLoc];
    if(*r->Text=='*') {
        sprintf(str_buf,"%s\n",r->Text+1);
        OutBuf(str_buf);
        Speak(str_buf);
    }
    else
    {
        if(Options&YOUARE) {
            sprintf(str_buf,"Luogo: %s\n",r->Text);
            OutBuf(str_buf);
            Speak(str_buf);
        }
        else {
            sprintf(str_buf,"Luogo: %s\n",r->Text);
            OutBuf(str_buf);
            Speak(str_buf);
        }
    }
    ct=0;
    f=0;
    WriteCON("\nDirezioni ovvie: ");
    Speak("Direzioni ovvie:");
    while(ct<6)
    {
        if(r->Exits[ct]!=0)
        {
            if(f==0)
                f=1;
            else
                WriteCON(", ");
            WriteCON(ExitNames[ct]);
            Speak(ExitNames[ct]);
        }
        ct++;
    }
    if(f==0) {
        WriteCON("nessuna");
        Speak("nessuna");
    }
    WriteCON(".\n");
    ct=0;
    f=0;
    pos=0;
    while(ct<=GameHeader.NumItems)
    {
        if(Items[ct].Location==MyLoc)
        {
            //printf("Item %d is in Room\n",ct);
            if(f==0)
            {
                if(Options&YOUARE) {
                    WriteCON("\nPuoi anche vedere: ");
                    Speak("Puoi anche vedere:");
                }
                else {
                    WriteCON("\nPosso anche vedere: ");
                    Speak("Posso anche vedere:");
                }
                pos=16;
                f++;
            }
            else if (!(Options & TRS80_STYLE))
            {
                WriteCON(" - ");
                pos+=3;
            }
            if(pos+strlen(Items[ct].Text)>(Width-10))
            {
                pos=0;
                WriteCON("\n");
            }
            WriteCON(Items[ct].Text);
            Speak(Items[ct].Text);
            pos += strlen(Items[ct].Text);
            if (Options & TRS80_STYLE)
            {
                WriteCON(". ");
                pos+=2;
            }
        }
        ct++;
    }
    if (Options & TRS80_STYLE) WriteCON(TRS80_LINE);
    if (GFX) Handle_Pic(MyLoc);
    CON_handle = act_hdl;
}

void LoadDatabase(FILE *f, int loud)
{
   
    char buf[32];
    int ni,na,nw,nr,mc,pr,tr,wl,lt,mn,trm;
    int ct;
    short lo;
    Action *ap;
    Room *rp;
    Item *ip;
  

/* Load the header */

    if(fscanf(f,"%*d %d %d %d %d %d %d %d %d %d %d %d",
        &ni,&na,&nw,&nr,&mc,&pr,&tr,&wl,&lt,&mn,&trm,&ct)<10)
        Fatal("File di avventura non valido (cattivo header)");
    GameHeader.NumItems=ni;
    Items=(Item *)MemAlloc(sizeof(Item)*(ni+1));
    GameHeader.NumActions=na;
    Actions=(Action *)MemAlloc(sizeof(Action)*(na+1));
    GameHeader.NumWords=nw;
    GameHeader.WordLength=wl;
    Verbs=(char **)MemAlloc(sizeof(char *)*(nw+1));
    Nouns=(char **)MemAlloc(sizeof(char *)*(nw+1));
    GameHeader.NumRooms=nr;
    Rooms=(Room *)MemAlloc(sizeof(Room)*(nr+1));
    GameHeader.MaxCarry=mc;
    GameHeader.PlayerRoom=pr;
    GameHeader.Treasures=tr;
    GameHeader.LightTime=lt;
    LightRefill=lt;
    GameHeader.NumMessages=mn;
    Messages=(char **)MemAlloc(sizeof(char *)*(mn+1));
    GameHeader.TreasureRoom=trm;
	
/* Load the actions */

    ct=0;
    ap=Actions;
    if(loud)
        printf("Leggendo %d azioni.\n",na);
    sprintf(buf,"Azioni:   %d\n",na);
    strcat(GameInfoStr,buf);
    while(ct<na+1)
    {
        if(fscanf(f,"%hd %hd %hd %hd %hd %hd %hd %hd",
            &ap->Vocab,
            &ap->Condition[0],
            &ap->Condition[1],
            &ap->Condition[2],
            &ap->Condition[3],
            &ap->Condition[4],
            &ap->Action[0],
            &ap->Action[1])!=8)
        {
            printf("Cattiva azione alla linea (%d)\n",ct);
            exit(1);
        }
        ap++;
        ct++;
    }
    ct=0;
    if(loud)
        printf("Leggendo %d paia di parole.\n",nw);
    sprintf(buf,"Paia di parole: %d\n",nw);
    strcat(GameInfoStr,buf);
    while(ct<nw+1)
    {
        Verbs[ct]=ReadString(f);
        Nouns[ct]=ReadString(f);
        ct++;
    }
    ct=0;
    rp=Rooms;
    if(loud)
        printf("Leggendo %d stanze.\n",nr);
    sprintf(buf,"Stanze:      %d\n",nr);
    strcat(GameInfoStr,buf);
    while(ct<nr+1)
    {
        fscanf(f,"%hd %hd %hd %hd %hd %hd",
            &rp->Exits[0],&rp->Exits[1],&rp->Exits[2],
            &rp->Exits[3],&rp->Exits[4],&rp->Exits[5]);
        rp->Text=ReadString(f);
        ct++;
        rp++;
    }
    ct=0;
    if(loud)
        printf("Leggendo %d messaggi.\n",mn);
    sprintf(buf,"Messaggi:   %d\n",mn);
    strcat(GameInfoStr,buf);
    while(ct<mn+1)
    {
        Messages[ct]=ReadString(f);
        ct++;
    }
    ct=0;
    if(loud)
        printf("Leggendo %d oggetti.\n",ni);
    sprintf(buf,"Oggetti:      %d\n",ni);
    strcat(GameInfoStr,buf);
    ip=Items;
    while(ct<ni+1)
    {
        ip->Text=ReadString(f);
        ip->AutoGet=strchr(ip->Text,'/');
        /* Some games use // to mean no auto get/drop word! */
        if(ip->AutoGet && strcmp(ip->AutoGet,"//") && strcmp(ip->AutoGet,"/*"))
        {
            char *t;
            *ip->AutoGet++=0;
            t=strchr(ip->AutoGet,'/');
            if(t!=NULL)
                *t=0;
        }
        fscanf(f,"%hd",&lo);
        ip->Location=(unsigned char)lo;
        ip->InitialLoc=ip->Location;
        ip++;
        ct++;
    }
    ct=0;
    /* Discard Comment Strings */
    while(ct<na+1)
    {
        ReadString(f);
        ct++;
    }
    fscanf(f,"%d",&ct);
    if(loud)
        printf("Versione %d.%02d di Adventure ",ct/100,ct%100);
    sprintf(buf,"Versione:  %d.%02d\n",ct/100,ct%100);
    strcat(GameInfoStr,buf);
    fscanf(f,"%d",&ct);
    if(loud)
        printf("%d.\nCaricamento completato.\n\n",ct);
    sprintf(buf,"Game Nr.:   %2d",ct);
    strcat(GameInfoStr,buf);
}

void OutReset()
{
    OutputPos=0;
    gotoxy(1,BottomHeight);
    clreol();
}

void OutBuf(char *buffer)
{
    char word[80];
    int wp,len;

    len = strlen(buffer);
    while(*buffer)
    {
        if(OutputPos==0)
        {
            while(*buffer && isspace(*buffer))
            {
                if (*buffer=='\n') NextLine();
                buffer++;
            }
        }
        if(*buffer==0) {
            return;
        }
        wp=0;
        while(*buffer && ((!isspace(*buffer)) || (*(buffer-1) == '*') || (*(buffer+1) == '*')))
        {
            word[wp++]=*buffer++;
        }
        word[wp]=0;

        //printf("Parola '%s' a %d\n",word,OutputPos);

        if (LINEWRAP) {
            if ((OutputPos + strlen(word) > Width - 2)  && (*word != '.')) NextLine();
            OutputPos += strlen(word);
        }
        else {
            if (((OutputPos + strlen(word) > Width - 2)  && (*word != '.') && (len <= Width)) || (OutputPos == Width)) NextLine();
            OutputPos += strlen(word);
            if (OutputPos >= Width) OutputPos -= Width;
        }

        WriteCON(word);
        
        if(*buffer==0) {
            return;
        }

        if (*buffer=='\n') NextLine();
        else
        {
            OutputPos++;
            if(OutputPos < (Width-1))
                WriteCON(" ");
        }
        buffer++;
    }
}

void OutputScott(char *a)
{
    char block[512];
    strcpy(block,a);
    OutBuf(block);
}

void OutputNumber(int a)
{
    char buf[16];
    sprintf(buf,"%d ",a);
    OutBuf(buf);
}

void GetInput(int *vb, int *no)
{
    char buf[256];
    char verb[10],noun[10];
    int vc,nc;
    int num;

    do
    {
        do
        {
            OutputScott("Cosa devo fare ? ");
            Speak("Cosa devo fare?");
            cursor(TRUE);
            LineInput2(buf);
            Speak(buf);
            cursor(FALSE);
            OutReset();
            num=sscanf(buf,"%9s %9s",verb,noun);
        }
        while(num==0||*buf=='\n'||*buf==0);
        //printf("%d, %s, %s\n",num,verb,noun);
        if(num==1)
            *noun=0;
        if(*noun==0 && strlen(verb)==1)
        {
            switch(isupper(*verb)?tolower(*verb):*verb)
            {
                case 'n':strcpy(verb,"NORD");break;
                case 'e':strcpy(verb,"EST");break;
                case 's':strcpy(verb,"SUD");break;
                case 'o':strcpy(verb,"OVEST");break;
                case 'a':strcpy(verb,"ALTO");break;
                case 'b':strcpy(verb,"BASSO");break;
                /* Brian Howarth interpreter also supports this */
                case 'i':strcpy(verb,"INVENTARIO");break;
                /* AMIGA interpreter extension */
                case 'g':strcpy(verb,"GUARDA");break;
            }
        }
        nc=WhichWord(verb,Nouns);
        /* The Scott Adams system has a hack to avoid typing 'go' */
        if(nc>=1 && nc <=6)
        {
            vc=1;
        }
        else
        {
            vc=WhichWord(verb,Verbs);
            nc=WhichWord(noun,Nouns);
        }
        *vb=vc;
        *no=nc;
        if(vc==-1)
        {
            OutputScott("\"");
            OutputScott(verb);
            Speak(verb);
            OutputScott("\" è una parola che non conosco... spiacente!\n");
            Speak("\" è una parola che non conosco. Spiacente!");
        }
    }
    while(vc==-1);
    strcpy(NounText,noun);  /* Needed by GET/DROP hack */
}

void SaveGame(void)
{
    FILE *f;

    if (Open_ASL(save_game,save_dir,1) == FALSE) {
        OutputScott("Save game cancellato.\n");
        Speak("Save game cancellato.");
        return;
    }
    Make_FFP(save_game,save_dir);
    f=fopen(FFP,"w");
    if(f==NULL)
    {
        sprintf(str_buf,"Impossibile creare il file di salvataggio '%s'.\n",FFP);
        OutputScott(str_buf);
        Speak("Impossibile creare il file di salvataggio ");
        return;
    }
    SaveBody(f);
    sprintf(str_buf,"Gioco salvato '%s'.\n",FFP);
    OutputScott(str_buf);
    Speak("Gioco salvato.");
    return;
}

BOOL LoadGame(char *name)
{
    FILE *f=fopen(name,"r");

    if(f==NULL)
    {
        sprintf(str_buf,"Impossibile ricaricare il gioco '%s'.\n\n",name);
        OutputScott(str_buf);
        Speak("Impossibile ricaricare il gioco.");
        return(TRUE);
    }
    LoadBody(f);
    sprintf(str_buf,"Gioco ricaricato '%s'.\n",name);
    OutputScott(str_buf);
    Speak("Gioco ricaricato.");
    return(FALSE);
}

BOOL RestoreGame()
{
    if (Open_ASL(save_game,save_dir,0) == FALSE) return(TRUE);
    Make_FFP(save_game,save_dir);
    return(LoadGame(FFP));
}

int WhichWord(char *word, char **list)
{
    int n=1;
    int ne=1;
    char *tp;

    /* quick & dirty workaround for missing feature 'RESTORE'
       no more need for quit/restart game. */
    if(Strnicmp(word,"!RICARICA",GameHeader.WordLength)==0) {
        RestoreGame();
        strcpy(word,"GUARDA");
        Redraw = 1;
    }

    while(ne<=GameHeader.NumWords)
    {
        tp=list[ne];
        if(*tp=='*')
            tp++;
        else
            n=ne;
        if(Strnicmp(word,tp,GameHeader.WordLength)==0)
            return(n);
        ne++;
    }
    return(-1);
}

