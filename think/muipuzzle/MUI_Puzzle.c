/*************************************************
**     Yet Another Magic MUI Puzzle Game X      **
**     -----------------------------------      **
**          Written on 15. April 1994           **
**                     by                       **
**                Michael Bauer                 **
** EMail: bauermichael@student.uni-tuebingen.de **
**************************************************/

/// "includes & defines"
#include <muidef.h> /* You could also use the demo.h include in the mui */
                    /* distribution                                     */

#define RAND(min,max) ((rand()%(int)(((max)+1)-(min)))+(min))

#define BUTTON      42
#define ABOUT       43
#define SHUFFLE     44
#define CRSRUP      45
#define CRSRDOWN    46
#define CRSRLEFT    47
#define CRSRRIGHT   48
#define SCRSRUP     49
#define SCRSRDOWN   50
#define SCRSRLEFT   51
#define SCRSRRIGHT  52

APTR app,window,about_gad,shuffle_gad,text,b[16];

int con[16] = { 
    1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,-1 
};

int moves = 0;
int actobj = 0;
///

/// "main"
int main(int argc,char *argv[])
{
    ULONG signals;
    BOOL running = TRUE;
    int i;
    LONG button_nr;

    char about_text[] =
"\33c© April 1994 by Michael Bauer\n\n\
MuiPuzzle is Mailware. You may spread it to your friends for free\n\
as long as you don't charge more than the price Fred Fish takes\n\
for his disks. It may be put in PD-series or on Fileservers. For\n\
the rules refer to the documents.\n\n\
The usage of this program by persons who support violence against\n\
foreign people is strictly prohibited.\n\n\
bauermichael@student.uni-tuebingen.de\n\
Gutgolf@IRC\n\
Gutgolf@Nightfall (134.2.62.161 4242)\n";

    init();

    app = ApplicationObject,
        MUIA_Application_Title      , "MUI Puzzle",
        MUIA_Application_Version    , "$VER: MUIpuzzle 1.0 (26.4.94)",
        MUIA_Application_Copyright  , "©1994 Michael Bauer",
        MUIA_Application_Author     , "Michael Bauer",
        MUIA_Application_Description, "A small puzzle game",
        MUIA_Application_Base       , "MUIPUZZLE",

        SubWindow, window = WindowObject,
            MUIA_Window_Title, "MUI Puzzle",
            MUIA_Window_ID   , MAKE_ID('P','U','Z','Z'),

            WindowContents, VGroup,
                Child, text = TextObject, TextFrame,
                    MUIA_Text_Contents, "Moves: 0",
                End,
                Child, VGroup, GroupFrame,
                    MUIA_Group_VertSpacing,0,
                    Child, HGroup,
                        MUIA_Group_SameSize, TRUE,
                        MUIA_Group_HorizSpacing,0,
                        Child,  b[0] = SimpleButton("1"),
                        Child,  b[1] = SimpleButton("2"),
                        Child,  b[2] = SimpleButton("3"),
                        Child,  b[3] = SimpleButton("4"),
                    End,
                    Child, HGroup,
                        MUIA_Group_SameSize, TRUE,
                        MUIA_Group_HorizSpacing,0,
                        Child,  b[4] = SimpleButton("5"),
                        Child,  b[5] = SimpleButton("6"),
                        Child,  b[6] = SimpleButton("7"),
                        Child,  b[7] = SimpleButton("8"),
                    End,
                    Child, HGroup,
                        MUIA_Group_SameSize, TRUE,
                        MUIA_Group_HorizSpacing,0,
                        Child,  b[8] = SimpleButton("9"),
                        Child,  b[9] = SimpleButton("10"),
                        Child,  b[10] = SimpleButton("11"),
                        Child,  b[11] = SimpleButton("12"),
                    End,
                    Child, HGroup,
                        MUIA_Group_SameSize, TRUE,
                        MUIA_Group_HorizSpacing,0,
                        Child,  b[12] = SimpleButton("13"),
                        Child,  b[13] = SimpleButton("14"),
                        Child,  b[14] = SimpleButton("15"),
                        Child,  b[15] = SimpleButton(" "),
                    End,
                End,
                Child, HGroup, GroupFrame,
                    MUIA_Group_SameSize, TRUE,
                    Child, about_gad = KeyButton("About",'a'),
                    Child, shuffle_gad = KeyButton("Shuffle",'s'),
                End,
            End,
        End,
    End;

    if (!app)
        fail(app,"Failed to create Application.");

    set(window,MUIA_Window_Open,TRUE);

    shuffle();

    DoMethod(window,MUIM_Notify,MUIA_Window_CloseRequest,MUIV_EveryTime,app,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit);

    /* Fill the number of a pressed button in the MUIA_UserField */
    for (i=0; i<=15; i++) {
        DoMethod(b[i],MUIM_Notify,MUIA_Pressed,FALSE,window,3,MUIM_Set,MUIA_UserData,i);
    }

    /* Send an ReturnID to the application every time the value in the */
    /* MUIA_UserField changes                                          */
    DoMethod(window,MUIM_Notify,MUIA_UserData,MUIV_EveryTime,app,2,MUIM_Application_ReturnID,BUTTON);

    /* Setup a small cycle chain */
    DoMethod(window,MUIM_Window_SetCycleChain,b[0],b[1],b[2],b[3],b[4],b[5],
             b[6],b[7],b[8],b[9],b[10],b[11],b[12],b[13],b[14],b[15],NULL);

    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"up",app,2,MUIM_Application_ReturnID,CRSRUP);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"down",app,2,MUIM_Application_ReturnID,CRSRDOWN);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"left",app,2,MUIM_Application_ReturnID,CRSRLEFT);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"right",app,2,MUIM_Application_ReturnID,CRSRRIGHT);
    
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"shift up",app,2,MUIM_Application_ReturnID,SCRSRUP);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"shift down",app,2,MUIM_Application_ReturnID,SCRSRDOWN);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"shift left",app,2,MUIM_Application_ReturnID,SCRSRLEFT);
    DoMethod(window,MUIM_Notify,MUIA_Window_InputEvent,"shift right",app,2,MUIM_Application_ReturnID,SCRSRRIGHT);

    DoMethod(about_gad,MUIM_Notify,MUIA_Pressed,FALSE,app,2,MUIM_Application_ReturnID,ABOUT);
    DoMethod(shuffle_gad,MUIM_Notify,MUIA_Pressed,FALSE,app,2,MUIM_Application_ReturnID,SHUFFLE);

    set (window,MUIA_Window_ActiveObject, b[0]);

    while (running)
    {
        switch (DoMethod(app,MUIM_Application_Input,&signals))
        {
                case MUIV_Application_ReturnID_Quit:
                        running = FALSE;
                        break;
                case BUTTON:
                    get(window,MUIA_UserData,&button_nr);
                    moveb((int)button_nr);
                    break;
                case ABOUT:
                    MUI_RequestA(app,window,0,"MUI Puzzle","*OK",about_text,NULL);
                    break;
                case SHUFFLE:
                    shuffle();
                    break;

                case SCRSRDOWN:
                    while (actobj < 12 ) {
                        actobj += 4;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case CRSRDOWN:
                    actobj += 4;
                    if (actobj > 15)
                        actobj -= 16;
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case SCRSRUP:
                    while (actobj > 3) {
                        actobj -= 4;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case CRSRUP:
                    actobj -= 4;
                    if (actobj < 0)
                        actobj += 16;
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case SCRSRLEFT:
                    while (actobj != 0 && actobj != 4 && actobj != 8 && actobj != 12) {
                        actobj -= 1;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case CRSRLEFT:
                    actobj -= 1;
                    switch (actobj) {
                        case -1:
                        case  3:
                        case  7:
                        case 11:
                            actobj += 4;
                            break;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case SCRSRRIGHT:
                    while (actobj != 3 && actobj != 7 && actobj != 11 && actobj != 15) {
                        actobj += 1;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;

                case CRSRRIGHT:
                    actobj += 1;
                    switch(actobj) {
                        case  4:
                        case  8:
                        case 12:
                        case 16:
                            actobj -= 4;
                            break;
                    }
                    set(window,MUIA_Window_ActiveObject,b[actobj]);
                    break;
        }

        if (running && signals) Wait(signals);
    }

    set(window,MUIA_Window_Open,FALSE);

    fail(app,NULL);
}
///

/// "shuffle"
int shuffle()
{
    int i,x,y,x1,y1,dummy;

    /* Set the array to it's original (sorted) state */
    for (i=0;i<15;i++)
        con[i]=i+1;
    con[15] = -1;

    /* Start position of the hole */
    x = 3; y = 3;

    /* Random swapping of the hole and one of it's neighbours */
    for (i=0;i<150;i++) {
        x1 = -1; y1 = -1;
        switch( RAND(1,4) ) {
            case 1: x1 = x-1;
                    if (x1 < 0)
                        x1 += 2;
                    y1 = y;
                    break;
            case 2: x1 = x+1;
                    if (x1 > 3)
                        x1 -= 2;
                    y1 = y;
                    break;
            case 3: y1 = y-1;
                    if (y1 < 0)
                        y1 += 2;
                    x1 = x;
                    break;
            case 4: y1 = y+1;
                    if (y1 > 3)
                        y1 -= 2;
                    x1 = x;
                    break;
        }
        dummy = con[x+y*4];
        con[x+y*4] = con[x1+y1*4];
        con[x1+y1*4] = dummy;
        x=x1; y=y1;
    }

    draw_field();

    /* Reset the counter */
    moves = 0;
    set (text,MUIA_Text_Contents,"Moves: 0");

    return;
}
///

/// "moveb"
int moveb(int n)
{
    int test = 0;
    int xc,yc,xe,ye,i;

    if (n<0 || n>15)
        return;

    /* Get the coordinates of the clicked button */
    yc = (int)(n/4);
    xc = (int)(n-yc*4);

    /* Get the coordinates of the empty field */
    for (i=0; i<=15; i++) {
        if (con[i] == -1) {
            ye = (int)(i/4);
            xe = (int)(i-ye*4);
        }
    }

    /* If the player tries to click on the empty field nothing happens */
    /* If the button can't be moved because the empty field doesn't    */
    /* sit in the same row or column return too.                       */
    if ((xe == xc && ye == yc) || (xe != xc && ye != yc))
        return (0);

    if (ye == yc) { /* horizontal */
        if (xe < xc) { /* move left */
            for (i=xe; i<xc; i++) {
                con[ye*4+i] = con[ye*4+i+1];
                DoMethod(b[ye*4+i],MUIM_SetAsString,MUIA_Text_Contents,"%ld",con[ye*4+i]);
            }
            con[yc*4+xc] = -1;
        }
        else { /* move right */
            for (i=xe; i>xc; i--) {
                con[ye*4+i] = con[ye*4+i-1];
                DoMethod(b[ye*4+i],MUIM_SetAsString,MUIA_Text_Contents,"%ld",con[ye*4+i-1]);
            }
            con[yc*4+xc] = -1;
        }
        set(b[yc*4+xc],MUIA_Text_Contents," ");
    }
    else { /* vertical */
        if (ye < yc) { /* move up */
            for (i=ye; i<yc; i++) {
                con[xc+i*4] = con[xc+(i+1)*4];
                DoMethod(b[xc+i*4],MUIM_SetAsString,MUIA_Text_Contents,"%ld",con[xc+(i+1)*4]);
            }
            con[yc*4+xc] = -1;
        }
        else { /* move down */
            for (i=ye; i>yc; i--) {
                con[xc+i*4] = con[xc+(i-1)*4];
                DoMethod(b[xc+i*4],MUIM_SetAsString,MUIA_Text_Contents,"%ld",con[xc+(i-1)*4]);
            }
            con[yc*4+xc] = -1;
        }
        set(b[yc*4+xc],MUIA_Text_Contents," ");
    }

    moves++;
    DoMethod(text,MUIM_SetAsString,MUIA_Text_Contents,"Moves: %ld",moves);

    /* Check if all buttons have the right value, i.e they're sorted */
    for (i=0; i<15; i++) {
        if (con[i] == i+1)
            test++;
    }

    /* If the buttons are sorted then popup the requester and reshuffle */
    if (test == 15) {
        MUI_RequestA(app,window,0,"MUI Puzzle","*OK","CONGRATULATIONS",NULL);
        shuffle();
    }

    return (0);
}
///

/// "draw_field"
draw_field() {
    int i;

    /* Set the new values to MUIA_Text_Contents, if value == -1 set */
    /* this button to <SPACE>                                       */
    for (i=0; i<=15; ++i) {
        if (con[i] == -1)
            set(b[i],MUIA_Text_Contents," ");
        else
            DoMethod(b[i],MUIM_SetAsString,MUIA_Text_Contents,"%ld",con[i]);
    }
}
///
