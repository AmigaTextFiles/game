#include <pragma/all_lib.h>

#include "SCOTT_A.c"
void choice(void)
{
    BYTE key;

    put_choice();
    while (1) {
        key = KeyInput();
        //printf("Key: %c\n",key);
        if (tolower(key) == 'f') {
            close_all();
            exit(0);
        }
        if (tolower(key) == 'r') {
            cursor(FALSE);
            WriteCON("Ricarica\n");
            Speak("Ricarica");
            OutReset();
            if (RestoreGame() == FALSE) {
                Look();
                break;
            }
            else put_choice();
        }
        if ((tolower(key) == 'c') && RESTART) {
            cursor(FALSE);
            WriteCON("Ricomincia\n");
            Speak("Ricomincia");
            OutReset();
            if ((LoadRestart() == FALSE) && RESTART) {
                Restart();
                break;
            }
            else put_choice();
        }
    }
}

void SaveBody(FILE *f)
{
    int ct;

    for(ct=0;ct<16;ct++)
    {
        fprintf(f,"%d %d\n",Counters[ct],RoomSaved[ct]);
    }
    fprintf(f,"%ld %d %hd %d %d %hd\n",BitFlags, (BitFlags&(1L<<DARKBIT))?1:0,
        MyLoc,CurrentCounter,SavedRoom,GameHeader.LightTime);
    for(ct=0;ct<=GameHeader.NumItems;ct++)
        fprintf(f,"%hd\n",(short)Items[ct].Location);
    fclose(f);
}

void LoadBody(FILE *f)
{
    int ct;
    short lo;
    short DarkFlag;

    for(ct=0;ct<16;ct++)
    {
        fscanf(f,"%d %d\n",&Counters[ct],&RoomSaved[ct]);
    }
    fscanf(f,"%ld %d %hd %d %d %hd\n",
        &BitFlags,&DarkFlag,&MyLoc,&CurrentCounter,&SavedRoom,
        &GameHeader.LightTime);
    /* Backward compatibility */
    if(DarkFlag)
        BitFlags|=(1L<<15);
    for(ct=0;ct<=GameHeader.NumItems;ct++)
    {
        fscanf(f,"%hd\n",&lo);
        Items[ct].Location=(unsigned char)lo;
    }
    fclose(f);
}

BOOL SaveRestart()
{
    FILE *f;

    f = fopen(restart_file,"w");
    if (f==NULL) return(TRUE);
    SaveBody(f);
    //SetProtection(restart_file,128);
    restart_lock = Lock(restart_file,SHARED_LOCK);
    return(FALSE);
}

BOOL LoadRestart()
{
    FILE *f=

    f = fopen(restart_file,"r");
    if (f==NULL) return(TRUE);
    LoadBody(f);
    return(FALSE);
}

int PerformLine(int ct)
{
    int continuation=0;
    int param[5],pptr=0;
    int act[4];
    int cc=0;

    while(cc<5)
    {
        int cv,dv;
        cv=Actions[ct].Condition[cc];
        dv=cv/20;
        cv=cv%20;
        //cv%=20;
        switch(cv)
        {
            case 0:
                param[pptr++]=dv;
                break;
            case 1://si ha l'oggetto
                if(Items[dv].Location!=CARRIED)
                    return(0);
                break;
            case 2:
                if(Items[dv].Location!=MyLoc)
                    return(0);
                break;
            case 3:
                if(Items[dv].Location!=CARRIED&&
                    Items[dv].Location!=MyLoc)
                    return(0);
                break;
            case 4:// si identifica dv come stanza
                if(MyLoc!=dv)
                    return(0);
                break;
            case 5:
                if(Items[dv].Location==MyLoc)
                    return(0);
                break;
            case 6:
                if(Items[dv].Location==CARRIED)
                    return(0);
                break;
            case 7:
                if(MyLoc==dv)
                    return(0);
                break;
            case 8:
                if((BitFlags&(1L<<dv))==0)
                    return(0);
                break;
            case 9:
                if(BitFlags&(1L<<dv))
                    return(0);
                break;
            case 10:
                if(CountCarried()==0)
                    return(0);
                break;
            case 11:
                if(CountCarried())
                    return(0);
                break;
            case 12:
                if(Items[dv].Location==CARRIED||Items[dv].Location==MyLoc)
                    return(0);
                break;
            case 13:
                if(Items[dv].Location==0)
                    return(0);
                break;
            case 14:
                if(Items[dv].Location)
                    return(0);
                break;
            case 15:
                if(CurrentCounter>dv)
                    return(0);
                break;
            case 16:
                if(CurrentCounter<=dv)
                    return(0);
                break;
            case 17:
                if(Items[dv].Location!=Items[dv].InitialLoc)
                    return(0);
                break;
            case 18:
                if(Items[dv].Location==Items[dv].InitialLoc)
                    return(0);
                break;
            case 19: /* Only seen in Brian Howarth games so far */
                if(CurrentCounter!=dv)
                    return(0);
                break;
        }
        cc++;
    }
    /* Actions */
    act[0]=Actions[ct].Action[0];
    act[2]=Actions[ct].Action[1];
    act[1]=act[0]%150;
    act[3]=act[2]%150;
    act[0]/=150;
    act[2]/=150;
    cc=0;
    pptr=0;
    while(cc<4)
    {
        //printf("Action: %d\n",act[cc]);
        if(act[cc]>=1 && act[cc]<52)
        {
            OutputScott(Messages[act[cc]]);
            Speak(Messages[act[cc]]);
            OutputScott("\n");
        }
        else if(act[cc]>101)
        {
            OutputScott(Messages[act[cc]-50]);
            Speak(Messages[act[cc]-50]);
            OutputScott("\n");
        }
        else switch(act[cc])
        {
            case 0: /* NOP */
                break;
            case 52:
                if(CountCarried()==GameHeader.MaxCarry)
                {
                    if(Options&YOUARE) {
                        OutputScott("Sei troppo carico.\n");
                        Speak("Sei troppo carico.");
                    }
                    else {
                        OutputScott("Sono troppo carico !\n");
                        Speak("Sono troppo carico !");
                    }
                    break;
                }
                if(Items[param[pptr]].Location==MyLoc)
                    Redraw=1;
                Items[param[pptr++]].Location= CARRIED;
                break;
            case 53:
                Redraw=1;
                Items[param[pptr++]].Location=MyLoc;
                break;
            case 54:
                Redraw=1;
                MyLoc=param[pptr++];
                break;
            case 55:
                if(Items[param[pptr]].Location==MyLoc)
                    Redraw=1;
                Items[param[pptr++]].Location=0;
                break;
            case 56:
                BitFlags|=1L<<DARKBIT;
                break;
            case 57:
                BitFlags&=~(1L<<DARKBIT);
                break;
            case 58:
                BitFlags|=(1L<<param[pptr++]);
                break;
            case 59:
                if(Items[param[pptr]].Location==MyLoc)
                    Redraw=1;
                Items[param[pptr++]].Location=0;
                break;
            case 60:
                BitFlags&=~(1L<<param[pptr++]);
                break;
            case 61:
                if(Options&YOUARE) {
                    OutputScott("Sei morto.\n");
                    Speak("Sei morto");
                }
                else {
                    OutputScott("Sono morto.\n");
                    Speak("Sono morto");
                }
                BitFlags&=~(1L<<DARKBIT);
                MyLoc=GameHeader.NumRooms; /* It seems to be what the code says! */
                Look();
                break;
            case 62:
            {
                /* Bug fix for some systems - before it could get parameters wrong */
                int i=param[pptr++];
                Items[i].Location=param[pptr++];
                Redraw=1;
                break;
            }
            case 63:
doneit:         OutBuf("Il gioco e' finito!\n");
                Speak("Il gioco e' finito");
                choice();
                break;
            case 64:
                Look();
                break;
            case 65:
            {
                int ct=0;
                int n=0;
                while(ct<=GameHeader.NumItems)
                {
                    if(Items[ct].Location==GameHeader.TreasureRoom &&
                      *Items[ct].Text=='*')
                        n++;
                    ct++;
                }
                if(Options&YOUARE) {
                    OutputScott("Hai accumulato ");
                    Speak("Hai accumulato");
                }
                else {
                    OutputScott("Ho accumulato ");
                    Speak("Ho accumulato");
                }
                OutputNumber(n);
                SpeakNum(n);
                OutputScott("tesori.\nSu una scala da 0 a 100, il tuo punteggio e' ");
                Speak("tesori.\nSu una scala da 0 a 100, il tuo punteggio e' ");
                OutputNumber((n*100)/GameHeader.Treasures);
                SpeakNum((n*100)/GameHeader.Treasures);
                OutputScott("punti.\n");
                Speak("punti");
                if(n==GameHeader.Treasures)
                {
                    OutputScott("Ben fatto.\n");
                    Speak("Ben fatto");
                    goto doneit;
                }
                break;
            }
            case 66:
            {
                int ct=0;
                int f=0;
                if(Options&YOUARE) {
                    OutputScott("Hai con te:\n");
                    Speak("Hai con te:");
                }
                else {
                    OutputScott("Ho con me:\n");
                    Speak("Ho con me:");
                }
                while(ct<=GameHeader.NumItems)
                {
                    if(Items[ct].Location==CARRIED)
                    {
                        if(f==1)
                        {
                            if (Options & TRS80_STYLE)
                                OutputScott(". ");
                            else
                                OutputScott(" - ");
                        }
                        f=1;
                        OutputScott(Items[ct].Text);
                        Speak(Items[ct].Text);
                    }
                    ct++;
                }
                if(f==0) {
                    OutputScott("Niente");
                    Speak("Niente");
                }
                OutputScott(".\n");
                break;
            }
            case 67:
                BitFlags|=(1L<<0);
                break;
            case 68:
                BitFlags&=~(1L<<0);
                break;
            case 69:
                GameHeader.LightTime=LightRefill;
                if(Items[LIGHT_SOURCE].Location==MyLoc)
                    Redraw=1;
                Items[LIGHT_SOURCE].Location=CARRIED;
                BitFlags&=~(1L<<LIGHTOUTBIT);
                break;
            case 70:
                clrscr(); /* pdd. */
                OutReset();
                break;
            case 71:
                SaveGame();
                break;
            case 72:
            {
                int i1=param[pptr++];
                int i2=param[pptr++];
                int t=Items[i1].Location;
                if(t==MyLoc || Items[i2].Location==MyLoc)
                    Redraw=1;
                Items[i1].Location=Items[i2].Location;
                Items[i2].Location=t;
                break;
            }
            case 73:
                continuation=1;
                break;
            case 74:
                if(Items[param[pptr]].Location==MyLoc)
                    Redraw=1;
                Items[param[pptr++]].Location= CARRIED;
                break;
            case 75:
            {
                int i1,i2;
                i1=param[pptr++];
                i2=param[pptr++];
                if(Items[i1].Location==MyLoc)
                    Redraw=1;
                Items[i1].Location=Items[i2].Location;
                if(Items[i2].Location==MyLoc)
                    Redraw=1;
                break;
            }
            case 76:    /* Looking at adventure .. */
                Look();
                break;
            case 77:
                if(CurrentCounter>=0)
                    CurrentCounter--;
                break;
            case 78:
                OutputNumber(CurrentCounter);
                SpeakNum(CurrentCounter);
                break;
            case 79:
                CurrentCounter=param[pptr++];
                break;
            case 80:
            {
                int t=MyLoc;
                MyLoc=SavedRoom;
                SavedRoom=t;
                Redraw=1;
                break;
            }
            case 81:
            {
                /* This is somewhat guessed. Claymorgue always
                   seems to do select counter n, thing, select counter n,
                   but uses one value that always seems to exist. Trying
                   a few options I found this gave sane results on ageing */
                int t=param[pptr++];
                int c1=CurrentCounter;
                CurrentCounter=Counters[t];
                Counters[t]=c1;
                break;
            }
            case 82:
                CurrentCounter+=param[pptr++];
                break;
            case 83:
                CurrentCounter-=param[pptr++];
                if(CurrentCounter< -1)
                    CurrentCounter= -1;
                /* Note: This seems to be needed. I don't yet
                   know if there is a maximum value to limit too */
                break;
            case 84:
                OutputScott(NounText);
                break;
            case 85:
                OutputScott(NounText);
                OutputScott("\n");
                break;
            case 86:
                OutputScott("\n");
                break;
            case 87:
            {
                /* Changed this to swap location<->roomflag[x]
                   not roomflag 0 and x */
                int p=param[pptr++];
                int sr=MyLoc;
                MyLoc=RoomSaved[p];
                RoomSaved[p]=sr;
                Redraw=1;
                break;
            }
            case 88:
                Delay(100); /* DOC's say 2 seconds. Spectrum times at 1.5 */
                break;
            case 89:
                //printf("A89->Param: %d\n",param[pptr]);
                if (GFX) {
                    if (Handle_Pic(nroom + param[pptr++])) {
                        WriteCON("\n <Premi Return>\n");
                        while (KeyInput() != 13) ;
                        Handle_Pic(MyLoc);
                    }
                }
                else pptr++;
                /* SAGA draw picture n */
                /* Spectrum Seas of Blood - start combat ? */
                /* Poking this into older spectrum games causes a crash */
                break;
            default:
                fprintf(stderr,"Sconosciuta azione %d [Parametro comincia %d %d]\n",
                    act[cc],param[pptr],param[pptr+1]);
                break;
        }
        cc++;
    }
    return(1+continuation);
}


int PerformActions(int vb,int no)
{
    static int disable_sysfunc=0;   /* Recursion lock */
    int d=BitFlags&(1L<<DARKBIT);

    int ct=0;
    int fl;
    int doagain=0;
    if(vb==1 && no == -1 )
    {//vb=1 indica 'go'
        OutputScott("Dai anche una direzione.\n");
        Speak("Dai anche una direzione.");
        return(0);
    }
    if(vb==1 && no>=1 && no<=6)
    {
        int nl;
        if(Items[LIGHT_SOURCE].Location==MyLoc ||
           Items[LIGHT_SOURCE].Location==CARRIED)
            d=0;//se ho la luce accesa o e' accesa nella stanza posso vedere
        if(d) {
            OutputScott("E' pericoloso muoversi nel buio!\n");
            Speak("E' pericoloso muoversi nel buio!");
        }
        nl=Rooms[MyLoc].Exits[no-1];
        if(nl!=0)//il valore 0 indica un'uscita non valida
        {
            MyLoc=nl;
            OutputScott("O.K.\n");
            Speak("O.K.");
            Look();
            return(0);
        }
        if(d)// se mi muovo nel buio e vado verso un'uscita non valida muoio
        {
            if (Options&YOUARE) {
                OutputScott("Scivoli e ti rompi il collo.\n");
                Speak("Scivoli e ti rompi il collo.");
            }
            else {
                OutputScott("Scivolo e mi rompo il collo.\n");
                Speak("Scivolo e mi rompo il collo.");
            }
            choice();
        }
        if(Options&YOUARE) {//mi muovo verso un'uscita non valida
            OutputScott("Non puoi andare in quella direzione.\n");
            Speak("Non puoi andare in quella direzione.");
        }
        else {
            OutputScott("Non posso andare in quella direzione.\n");
            Speak("Non posso andare in quella direzione.");
        }
        return(0);
    }
    fl= -1;
    while(ct<=GameHeader.NumActions)
    {
        int vv,nv;
        vv=Actions[ct].Vocab;
        /* Think this is now right. If a line we run has an action73
           run all following lines with vocab of 0,0 */
        if(vb!=0 && (doagain&&vv!=0))
            break;
        /* Oops.. added this minor cockup fix 1.11 */
        if(vb!=0 && !doagain && fl== 0)
            break;
        nv=vv%150;
        vv/=150;
        if((vv==vb)||(doagain&&Actions[ct].Vocab==0))
        {
            if((vv==0 && RandomPercent(nv))||doagain||
                (vv!=0 && (nv==no||nv==0)))
            {
                int f2;
                if(fl== -1)
                    fl= -2;
                if((f2=PerformLine(ct))>0)
                {
                    /* ahah finally figured it out ! */
                    fl=0;
                    if(f2==2)
                        doagain=1;
                    if(vb!=0 && doagain==0)
                        return(0);
                }
            }
        }
        ct++;
        if(Actions[ct].Vocab!=0)
            doagain=0;
    }
    if(fl!=0 && disable_sysfunc==0)
    {
        int i;
        if(Items[LIGHT_SOURCE].Location==MyLoc ||
           Items[LIGHT_SOURCE].Location==CARRIED)
            d=0;
        if(vb==10 || vb==18)
        {
            /* Yes they really _are_ hardcoded values */
            if(vb==10)// prendi
            {
                if(stricmp(NounText,"TUTTO")==0)
                {
                    int ct=0;
                    int f=0;

                    if(d) {
                        OutputScott("E' buio.\n");
                        Speak("E' buio.");
                        return 0;
                    }
                    while(ct<=GameHeader.NumItems)
                    {
                        if(Items[ct].Location==MyLoc && Items[ct].AutoGet!=NULL && Items[ct].AutoGet[0]!='*')
                        {
                            no=WhichWord(Items[ct].AutoGet,Nouns);
                            disable_sysfunc=1;  /* Don't recurse into auto get ! */
                            PerformActions(vb,no);  /* Recursively check each items table code */
                            disable_sysfunc=0;
                            if(CountCarried()==GameHeader.MaxCarry)
                            {
                                if(Options&YOUARE) {
                                    OutputScott("Stai portando troppe cose.\n");
                                    Speak("Stai portando troppe cose.");
                                }
                                else {
                                    OutputScott("Sto portando troppe cose.\n");
                                    Speak("Sto portando troppe cose.");
                                }
                                return(0);
                            }
                            Items[ct].Location= CARRIED;
                            Redraw=1;
                            OutBuf(Items[ct].Text);
                            Speak(Items[ct].Text);
                            OutputScott(": O.K.\n");
                            Speak("O.K.");
                            f=1;
                        }
                        ct++;
                    }
                    if(f==0) {
                        OutputScott("Non c'e' nulla da prendere.\n");
                        Speak("Non c'e' nulla da prendere.");
                    }
                    return(0);
                }
                if(no==-1)
                {
                    OutputScott("Prendo cosa ?\n");
                    Speak("Prendo cosa ?");
                    return(0);
                }
                if(CountCarried()==GameHeader.MaxCarry)
                {
                    if(Options&YOUARE) {
                        OutputScott("Stai portando troppe cose\n");
                        Speak("Stai portando troppe cose.");
                    }
                    else {
                        OutputScott("Sto portando troppe cose.\n");
                        Speak("Sto portando troppe cose.");
                    }
                    return(0);
                }
                i=MatchUpItem(NounText,MyLoc);
                if(i==-1)
                {
                    if(Options&YOUARE) {
                        OutputScott("Ti e' impossibile fare questo.\n");
                        Speak("Ti e' impossibile fare questo.");
                    }
                    else {
                        OutputScott("Mi e' impossibile fare questo.\n");
                        Speak("Mi e' impossibile fare questo.");
                    }
                    return(0);
                }
                Items[i].Location= CARRIED;
                OutputScott("O.K.\n");
                Speak("O.K.");
                Redraw=1;
                return(0);
            }
            if(vb==18)//posa
            {
                if(stricmp(NounText,"TUTTO")==0)
                {
                    int ct=0;
                    int f=0;
                    while(ct<=GameHeader.NumItems)
                    {
                        if(Items[ct].Location==CARRIED && Items[ct].AutoGet && Items[ct].AutoGet[0]!='*')
                        {
                            no=WhichWord(Items[ct].AutoGet,Nouns);
                            disable_sysfunc=1;
                            PerformActions(vb,no);
                            disable_sysfunc=0;
                            Items[ct].Location=MyLoc;
                            OutBuf(Items[ct].Text);
                            Speak(Items[ct].Text);
                            OutputScott(": O.K.\n");
                            Speak("O.K.");
                            Redraw=1;
                            f=1;
                        }
                        ct++;
                    }
                    if(f==0) {
                        OutputScott("Niente da lasciare.\n");
                        Speak("Niente da lasciare.");
                    }
                    return(0);
                }
                if(no==-1)
                {
                    OutputScott("Lascio cosa ?\n");
                    Speak("Lascio cosa ?");
                    return(0);
                }
                i=MatchUpItem(NounText,CARRIED);
                if(i==-1)
                {
                    if(Options&YOUARE) {
                        OutputScott("E' per te impossibile fare questo.\n");
                        Speak("E' per te impossibile fare questo.");
                    }
                    else {
                        OutputScott("E' per me impossibile fare questo.\n");
                        Speak("E' per me impossibile fare questo.");
                    }
                    return(0);
                }
                Items[i].Location=MyLoc;
                OutputScott("O.K.\n");
                Speak("O.K.");
                Redraw=1;
                return(0);
            }
        }
    }
    return(fl);
}

void main(int argc, char *argv[])
{
    //FILE *f;
    int vb,no,i;
    char prog_name[32];

    //{ Betori
    for (i=0;i<1024;i++){
         indirizzo_puntatore[i]=NULL;
      }
    contatore=0;
    //}
    strcpy(prog_name,argv[0]);
    while(argv[1])
    {
        if(*argv[1]!='-')
            break;
        switch(argv[1][1])
        {
            case 'y':
                Options|=YOUARE;
                break;
            case 'i':
                Options&=~YOUARE;
                break;
            case 'd':
                Options|=DEBUGGING;
                break;
            case 's':
                Options|=SCOTTLIGHT;
                break;
            case 't':
                Options|=TRS80_STYLE;
                break;
            case 'p':
                Options|=PREHISTORIC_LAMP;
                break;
            case 'h':
            default:
                fprintf(stderr,"%s: [-h] [-y] [-s] [-i] [-t] [-d] [-p] <gamename> [savedgame].\n",
                        argv[0]);
                exit(1);
        }
        if(argv[1][2]!=0) {
            fprintf(stderr,"%s: opzione -%c non prende un parametro.\n",argv[0],argv[1][1]);
            exit(1);
        }
        argv++;
        argc--;
    }

    //printf("%d, %s, %s, %s\n",argc,argv[0],argv[1],argv[2]);
    if (argc == 0) {
        WBSTART = TRUE;
        WBMessage = (struct WBStartup *) argv;
        Init(WBMessage->sm_ArgList->wa_Name,"","");
    }
    else Init(prog_name,((argc<2)?"":argv[1]),((argc<3)?"":argv[2]));

    srand(time(NULL));
    Look();
    while(1)
    {
        if(Redraw!=0)
        {
            Look();
            Redraw=0;
        }
        PerformActions(0,0);
        if(Redraw!=0)
        {
            Look();
            Redraw=0;
        }
        GetInput(&vb,&no);
        switch(PerformActions(vb,no))
        {
            case -1:
                OutputScott("Non capisco il tuo comando.\n");
                Speak("Non capisco il tuo comando.");
                break;
            case -2:
                OutputScott("Non posso fare questo ancora.\n");
                Speak("Non posso fare questo ancora.");
                break;
        }
        /* Brian Howarth games seem to use -1 for forever */
        if(Items[LIGHT_SOURCE].Location/*==-1*/!=DESTROYED && GameHeader.LightTime!= -1)
        {
            GameHeader.LightTime--;
            if(GameHeader.LightTime<1)
            {
                BitFlags|=(1L<<LIGHTOUTBIT);
                if(Items[LIGHT_SOURCE].Location==CARRIED ||
                    Items[LIGHT_SOURCE].Location==MyLoc)
                {
                    if(Options&SCOTTLIGHT) {
                        OutputScott("La luce si estingue !\n");
                        Speak("La luce si estingue !");
                    }
                    else {
                        OutputScott("Non hai piu' luce !\n");
                        Speak("Non hai piu' luce !");
                    }

                }
                if(Options&PREHISTORIC_LAMP){
                  Items[LIGHT_SOURCE].Location=DESTROYED;
                }
            }
            else if(GameHeader.LightTime<25)
            {
                if(Items[LIGHT_SOURCE].Location==CARRIED ||
                    Items[LIGHT_SOURCE].Location==MyLoc)
                {

                    if(Options&SCOTTLIGHT)
                    {
                        OutputScott("La luce si estinguera' in\n");
                        Speak("La luce si estinguera' in ");
                        OutputNumber(GameHeader.LightTime);
                        SpeakNum(GameHeader.LightTime);
                        OutputScott(" mosse. ");
                        Speak(" mosse.");
                    }
                    else
                    {
                        if(GameHeader.LightTime%5==0) {
                            OutputScott("La luce si affievolisce.\n");
                            Speak("La luce si affievolisce.");
                        }
                    }
                }
            }
        }
    }
}

