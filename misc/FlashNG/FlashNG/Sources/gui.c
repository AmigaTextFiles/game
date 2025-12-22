// Uncomment to debug
//#define DEBUG

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/displayinfo.h>
#include <dos/dos.h>
#include <graphics/gfx.h>
#include <gtlayout.h>

#ifdef __SASC_60
#include <pragmas/gtlayout_pragmas.h>
#endif

#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/gtlayout_protos.h>

#include "version.h"
#include "gui.h"    
#include "game.h" // For LoadScore() and SaveScore()

enum {BUT_SCORE=1, BUT_QUIT, BUT_SAVE, BUT_PLAY, BUT_ABOUT, INT_LIVES, INT_LEVEL, CHKBOX_SOUND, STR_NAME};

extern struct Library *GTLayoutBase;

//struct Prefs settings;

void LoadPrefs(struct Prefs *sets)
{
   //long resultat;
   //struct EasyStruct MyStruct;

    BPTR file;
    //long result;
    sets->sound=FALSE;
    sets->lives=3;
    sets->status=0;
    sets->startlevel=1;
    file=Open("ENVARC:FlashNG.prefs",MODE_OLDFILE);
    if (!file)
        SavePrefs(sets);
    else
    {
        Read(file,(char *)sets,sizeof(struct Prefs));
        Close(file);
    }
}

void SavePrefs(struct Prefs *sets)
{
    long resultat;
    struct EasyStruct MyStruct;
    BPTR file;

    file=Open("ENVARC:FlashNG.prefs",MODE_READWRITE);
    if (!file)
    {
        MyStruct.es_Title=FLASHNGVERSION" Warning";
        MyStruct.es_TextFormat="Cannot access the file\nENVARC:FlashNG.prefs ";
        MyStruct.es_GadgetFormat="Ohh ;(";
        resultat=EasyRequestArgs(NULL,&MyStruct,NULL,NULL);
    }
    else
    {
        Write(file,(char *)sets,sizeof(struct Prefs));
        Close(file);
    }
}

BOOL GUI(struct Prefs *settings)
{
    struct TagItem GoOFF[]={GTCB_Checked,FALSE,TAG_DONE};
    long resultat;
    //char *Name="Nogfx"; // Player Nick
    char *Scores="";    // ScoreTable Text
    char *Scores1="";
    struct score player1;
    struct EasyStruct MyStruct;  // Misc requesters
    struct EasyStruct ScoreReq;  // ScoreTable Requester

    MyStruct.es_StructSize=sizeof(struct EasyStruct);
    MyStruct.es_Flags=0;

    ScoreReq.es_StructSize=sizeof(struct EasyStruct);
    ScoreReq.es_Flags=0;

    if (GTLayoutBase=OpenLibrary("gtlayout.library", 0))
    {
        struct LayoutHandle *Handle;
        #ifdef DEBUG
        puts("gtlayout.library opened");
        #endif
        if (Handle = LT_CreateHandleTags(NULL, LAHN_AutoActivate, TRUE, TAG_DONE))
        {
            struct Window *Win;
            #ifdef DEBUG
            puts("Handle created");
            #endif
            LT_New(Handle, LA_Type, VERTICAL_KIND,  /* A vertical group. */
                           LAGR_SameWidth,TRUE,
                           TAG_DONE);

            LT_New(Handle, LA_Type, VERTICAL_KIND,  /* A vertical group. */
                           LA_LabelText, "Prefs",   /* Group title text. */
                           TAG_DONE);

            LT_New(Handle, LA_Type,CHECKBOX_KIND,
                           LA_LabelText,"Sound:",
                           LA_Chars,10,
                           LA_ID,CHKBOX_SOUND,
                           TAG_DONE);


            LT_New(Handle, LA_Type,INTEGER_KIND,
                           LA_LabelText,"Start Level:",
                           LA_Chars,4,
                           LAIN_Max,4,
                           LAIN_Min,1,
                           LA_ID,INT_LEVEL,
                           TAG_DONE);

            LT_New(Handle, LA_Type,INTEGER_KIND,
                           LA_LabelText,"Total Lives:",
                           LA_Chars,4,
                           LAIN_Max,3,
                           LAIN_Min,1,
                           LA_ID,INT_LIVES,
                           TAG_DONE);

            /*LT_New(Handle, LA_Type,STRING_KIND,
                           LA_LabelText,"Your Name:",
                           LA_Chars,4,
                           LAIN_Max,3,
                           LAIN_Min,1,
                           LA_ID,STR_NAME,
                           TAG_DONE); */

            LT_New(Handle, LA_Type, END_KIND,    /* This ends the current group. */
                           TAG_DONE);

            LT_New(Handle, LA_Type, XBAR_KIND,   /* A separator bar. */
                           TAG_DONE);

            LT_New(Handle, LA_Type, BUTTON_KIND, /* A plain button. */
                           LA_LabelText, "See Best Scores",
                           LA_ID,        BUT_SCORE,
                           TAG_DONE);

            LT_New(Handle, LA_Type, BUTTON_KIND, /* A plain button. */
                           LA_LabelText, "About",
                           LA_ID, BUT_ABOUT,
                           TAG_DONE);

            LT_New(Handle, LA_Type, BUTTON_KIND, /* A plain button. */
                           LA_LabelText, "Play !",
                           LA_ID, BUT_PLAY,
                           TAG_DONE);

            LT_New(Handle, LA_Type, HORIZONTAL_KIND,
                           TAG_DONE);

            LT_New(Handle, LA_Type, BUTTON_KIND, /* A plain button. */
                           LA_LabelText, "Save",
                           LA_ID, BUT_SAVE,
                           TAG_DONE);

            LT_New(Handle, LA_Type, BUTTON_KIND, /* A plain button. */
                           LA_LabelText, "Quit...",
                           LA_ID, BUT_QUIT,
                           TAG_DONE);

            LT_New(Handle, LA_Type, END_KIND,
                           TAG_DONE);

            LT_New(Handle, LA_Type, END_KIND,    /* This ends the current group. */
                           TAG_DONE);


            if(Win=LT_Build(Handle, LAWN_Title,     FLASHNGVERSION,
                                    LAWN_IDCMP,     IDCMP_CLOSEWINDOW,
                                    WA_CloseGadget, TRUE,
                                    TAG_DONE))
            {
                int a,i,taille;
                struct IntuiMessage *Message;
                ULONG MsgQualifier, MsgClass;
                UWORD MsgCode;
                struct Gadget *MsgGadget;

                BOOL Done=FALSE;
                #ifdef DEBUG
                puts("Loading prefs...");
                #endif
                LoadPrefs(settings);
                #ifdef DEBUG
                puts("Prefs loaded");
                #endif

                // Scores
                #ifdef DEBUG
                puts("Loading score table...");
                #endif
                Scores1=AllocVec(600,0);
                //Scores=AllocVec(100,0);
                taille=0;
                for (i=1;i<=10;i++)
                {
                    LoadScore(&player1,i);
                    sprintf(Scores,"%d-%s ............ %d (%d Bricks)\n",i,player1.player,player1.value,player1.bricks);
                    //printf("%d-%s ............ %d (%d Bricks)\n",i,player1.player,player1.value,player1.bricks);
                    strcpy(&Scores1[taille],Scores);
                    taille=taille+strlen(Scores);
                    //strcat(Scores1,Scores);

                }
                #ifdef DEBUG
                puts("Score table loaded");
                #endif

                LT_SetAttributes(Handle,INT_LIVES,GTIN_Number,settings->lives);
                LT_SetAttributes(Handle,INT_LEVEL,GTIN_Number,settings->startlevel);
                //printf("Vies: %d\n",settings->lives);
                //printf("Start: %d\n",settings->startlevel);

                do
                {
                    Message=(struct IntuiMessage *)WaitPort(Win -> UserPort);

                    while(Message=LT_GetIMsg(Handle))
                    {
                        MsgClass     = Message->Class;
                        MsgCode      = Message->Code;
                        MsgQualifier = Message->Qualifier;
                        MsgGadget    = Message->IAddress;

                        LT_ReplyIMsg(Message);

                        LT_HandleInput(Handle,MsgQualifier,&MsgClass,&MsgCode,&MsgGadget);

                        switch(MsgClass)
                        {
                            case IDCMP_CLOSEWINDOW:
                                Done = TRUE;
                                break;

                            case IDCMP_GADGETUP:
                                switch(MsgGadget -> GadgetID)
                                {
                                    case BUT_QUIT:  //printf("Quit\n");
                                                    MyStruct.es_Title="Question";
                                                    MyStruct.es_TextFormat="Really wanna quit ?";
                                                    MyStruct.es_GadgetFormat="Yes, NOW!|Ooops no!";
                                                    resultat=EasyRequestArgs(NULL,&MyStruct,NULL,NULL);
                                                    if (resultat==1)
                                                        Done=TRUE;
                                                    //printf("Résultat: %d\n",resultat);
                                                    break;
                                    case BUT_PLAY:
                                                    settings->status=10;
                                                    Done=TRUE;
                                                    break;
                                    case BUT_SCORE: //printf("Scores\n");
                                                    
                                                    //printf("1-%s ............ %d (%d Bricks)\n",player1.player,player1.value,player1.bricks);
                                                    ScoreReq.es_Title=FLASHNGVERSION" - Score Table";
                                                    ScoreReq.es_TextFormat=Scores1;
                                                    ScoreReq.es_GadgetFormat="Okay!";
                                                    resultat=EasyRequestArgs(NULL,&ScoreReq,NULL,NULL);
                                                    break;

                                    case BUT_ABOUT: //printf("About\n");
                                                    MyStruct.es_Title=FLASHNGVERSION" info";
                                                    MyStruct.es_TextFormat="FlashNG © 2001 Nogfx.\nEmail: NicoEFE@ifrance.com\na GPL Arkanoid Clone ";
                                                    MyStruct.es_GadgetFormat="Okay!";
                                                    resultat=EasyRequestArgs(NULL,&MyStruct,NULL,NULL);
                                                    break;
                                    case BUT_SAVE:
                                                    SavePrefs(settings);
                                                    break;
                                    case INT_LIVES:
                                                    a=LT_GetAttributes(Handle,INT_LIVES);
                                                    settings->lives=a;
                                                    //printf("Nouveau truc: %d\n",a);
                                                    break;
                                    /*case STR_NAME:
                                                    Name=LT_GetString(Handle,STR_NAME);
                                                    break;*/


                                    case INT_LEVEL:
                                                    a=LT_GetAttributes(Handle,INT_LEVEL);
                                                    settings->startlevel=a;
                                                    //printf("Nouveau truc: %d\n",a);
                                                    break;
                                    case CHKBOX_SOUND:
                                                    //printf("Son !\n");
                                                    LT_SetAttributesA(Handle,CHKBOX_SOUND,GoOFF);
                                                    MyStruct.es_Title=FLASHNGVERSION" info";
                                                    MyStruct.es_TextFormat="Not implemented yet!";
                                                    MyStruct.es_GadgetFormat="Okay!";
                                                    resultat=EasyRequestArgs(NULL,&MyStruct,NULL,NULL);
                                                    break;
                                }
                                break;
                        } // switch(MsgClass)
                    } // while(Message=LT_GetIMsg(Handle))
                }    
                while(!Done);
            } // if (Win=LT_Build(...))

            LT_DeleteHandle(Handle);
        } // if (Handle=LT_CreateHandleTags(...))
        CloseLibrary(GTLayoutBase);
        #ifdef DEBUG
        puts("gtlayout.library closed");
        #endif
        GTLayoutBase=NULL;
        //FreeVec(Scores);
        FreeVec(Scores1);
        return(TRUE);
    } // if (GTLayoutBase=OpenLibrary(...))
    else
    {
        #ifdef DEBUG
        puts("Can't open gtlayout.library");
        #endif
        return(FALSE);
    }
}

