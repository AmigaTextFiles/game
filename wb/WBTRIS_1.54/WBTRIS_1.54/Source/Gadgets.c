#include "WBTRIS.h"

extern struct TextAttr helvetica13;
extern struct TextAttr topaz8;
extern APTR            VisualInfo;
extern struct Gadget  *TetrisGList;
extern struct Gadget  *TetrisGadgets[9];
extern UBYTE          *CYCLELabels[2];
extern BOOL            UseLace;

struct Gadget *CreateAllGadgets(struct Screen *myscreen)
{
    struct Gadget    *gad = NULL;
    struct NewGadget  ng;

    gad = CreateContext(&TetrisGList);
    if (UseLace) {
       ng.ng_TextAttr   = &helvetica13;
       ng.ng_LeftEdge   = 75;
       ng.ng_TopEdge    = 7 + 4*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
    } else {
       ng.ng_TopEdge    = 7 + 3*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &topaz8;
       ng.ng_LeftEdge   = 195;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_Width      = 50;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Hiscore:";
    ng.ng_GadgetID   = GD_HighscoreGadget;
    ng.ng_Flags      = PLACETEXT_LEFT;
    TetrisGadgets[0] = gad = CreateGadget(NUMBER_KIND, gad, &ng, GTNM_Border, TRUE, TAG_END);

    if (UseLace) {
       ng.ng_TopEdge    = 7 + 5*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &helvetica13;
       ng.ng_LeftEdge   = 75;
    } else {
       ng.ng_TopEdge    = 7 + 4*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_LeftEdge   = 195;
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_Width      = 50;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Score:";
    ng.ng_GadgetID   = GD_ScoreGadget;
    ng.ng_Flags      = PLACETEXT_LEFT;
    TetrisGadgets[1] = gad = CreateGadget(NUMBER_KIND, gad, &ng, GTNM_Border, TRUE, TAG_END);

    if (UseLace) {
       ng.ng_LeftEdge   = 75;
       ng.ng_TopEdge    = 7 + 6*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_LeftEdge   = 195;
       ng.ng_TopEdge    = 7 + 5*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_Width      = 50;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Level:";
    ng.ng_GadgetID   = GD_LevelGadget;
    ng.ng_Flags      = PLACETEXT_LEFT;
    TetrisGadgets[2] = gad = CreateGadget(NUMBER_KIND, gad, &ng, GTNM_Border, TRUE, TAG_END);

    if (UseLace) {
       ng.ng_LeftEdge   = 75;
       ng.ng_TopEdge    = 7 + 7*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_LeftEdge   = 195;
       ng.ng_TopEdge    = 7 + 6*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_Width      = 50;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Lines:";
    ng.ng_GadgetID   = GD_LineGadget;
    ng.ng_Flags      = PLACETEXT_LEFT;
    TetrisGadgets[3] = gad = CreateGadget(NUMBER_KIND, gad, &ng, GTNM_Border, TRUE, TAG_END);

    if (UseLace) {
       ng.ng_LeftEdge   = 30;
       ng.ng_TopEdge    = 7 + 9*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_LeftEdge   = 160;
       ng.ng_TopEdge    = 7 + 8*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_Width      = 75;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = NULL;
    ng.ng_GadgetID   = GD_PauseGadget;
    ng.ng_Flags      = 0;
    TetrisGadgets[4] = gad = CreateGadget(CYCLE_KIND, gad, &ng, GTCY_Labels, (ULONG)&CYCLELabels[0], TAG_END);

    if (UseLace) {
       ng.ng_TopEdge    = 7 + 10*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 75;
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_TopEdge    = 7 + 5*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 85;
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_LeftEdge   = 30;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Statistic";
    ng.ng_GadgetID   = GD_StatGadget;
    ng.ng_Flags      = 0;
    TetrisGadgets[5] = gad = CreateGadget(BUTTON_KIND, gad, &ng, GA_Disabled, FALSE, TAG_END);

    if (UseLace) {
       ng.ng_TopEdge    = 7 + 11*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 75;
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_TopEdge    = 7 + 6*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 85;
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_LeftEdge   = 30;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Options";
    ng.ng_GadgetID   = GD_OptGadget;
    ng.ng_Flags      = 0;
    TetrisGadgets[6] = gad = CreateGadget(BUTTON_KIND, gad, &ng, GA_Disabled, FALSE, TAG_END);

    if (UseLace) {
       ng.ng_TopEdge    = 7 + 12*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 75;
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_TopEdge    = 7 + 7*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 85;
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_LeftEdge   = 30;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "New Game";
    ng.ng_GadgetID   = GD_NewGadget;
    ng.ng_Flags      = 0;
    TetrisGadgets[7] = gad = CreateGadget(BUTTON_KIND, gad, &ng, TAG_END);

    if (UseLace) {
       ng.ng_TopEdge    = 7 + 13*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 75;
       ng.ng_TextAttr   = &helvetica13;
    } else {
       ng.ng_TopEdge    = 7 + 8*21 + myscreen->WBorTop + (myscreen->Font->ta_YSize + 1);
       ng.ng_Width      = 85;
       ng.ng_TextAttr   = &topaz8;
    }
    ng.ng_VisualInfo = VisualInfo;
    ng.ng_LeftEdge   = 30;
    ng.ng_Height     = 17;
    ng.ng_GadgetText = "Hiscore";
    ng.ng_GadgetID   = GD_ShowScoreGadget;
    ng.ng_Flags      = 0;
    TetrisGadgets[8] = gad = CreateGadget(BUTTON_KIND, gad, &ng, TAG_END);

    return(gad);
}
