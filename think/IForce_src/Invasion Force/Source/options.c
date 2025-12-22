/*
   options.c -- options editor module for Invasion Force
   This module allows the user to edit the game options.
   This source code is free.  You may make as many copies as you like.
*/

#include "global.h"

int high_player;      // i.e. the number of players

BOOL fmail = FALSE;
BOOL modem = FALSE;

struct Window *opt_window;
struct Gadget *minus_gad, *plus_gad, *pgads[9];
struct Gadget *namefield, *rol_ptype;
struct Gadget *mapfile_button, *mapfile_field;

// the slider gadgets
struct Gadget *prod_slide, *att_slide, *def_slide, *aggr_slide;

// the integer gadgets
struct Gadget *prod_int, *att_int, *def_int, *aggr_int;

// global game options
struct Opt opt;

/*
   The following debugging function should print the player information,
   a good way to see if it was really retrieved from the Intuition gadgets
   properly, and whether the program keeps it straight.
*/

void show_player(pnum)
int pnum;
{  // print play information
   if (roster[pnum].type == NOPLAYER) {
      sprintf(foo,"Player %d does not exist!\n");  print(foo);
      return;
   FI
   sprintf(foo,"Info for player %d:\n",pnum);   print(foo);
   sprintf(foo,"   Name: %s\n",roster[pnum].name);  print(foo);
   switch (roster[pnum].type) {
      case HUMAN:
         sprintf(foo,"   Type: HUMAN\n");
      case COMPUTER:
         sprintf(foo,"   Type: COMPUTER\n");
   }
   print(foo);
}


void init_players()
{  // set default player names and other values
   int ctr = 0;
   char *dflt_names[] = {
      "NEUTRAL",
      "General Havoc",
      "Major Damage",
      "Colonel Mustard",
      "Sergeant Pepper",
      "Commander McBragg",
      "Flex Crush",
      "Max Force",
      "Hun Dread"
   };
   int color_table[] = {
      WHITE, RED, LT_BLUE, ORANGE, GREEN, BROWN, PURPLE, GRAY, TAN
   };

   for (; ctr<=8; ctr++) {
      int ctr2;

      strcpy(roster[ctr].name,dflt_names[ctr]);
      roster[ctr].type = HUMAN;
      roster[ctr].status = ACTIVE;
      roster[ctr].show = SHOW_ALL;
      roster[ctr].color = color_table[ctr];
      roster[ctr].prod = 50;
      roster[ctr].def = roster[ctr].att = 0;
      roster[ctr].aggr = 5;
      roster[ctr].snd_vol = 45;
      roster[ctr].msg_delay = 25;
      roster[ctr].battle_delay = 50;
      roster[ctr].soundfx = SOUND_ALL;
      roster[ctr].autorpt = TRUE;
      roster[ctr].show_production = TRUE;
      roster[ctr].map = NULL;
      NewList((struct List *)&roster[ctr].icons);
      for (ctr2=0; ctr2<11; ctr2++) {
         roster[ctr].eud[ctr2] = 0;
         roster[ctr].ulc[ctr2] = 0;
      OD
   OD
   roster[0].type = NOPLAYER;

   // while I'm here, I'll initialize all the OPT values as well
   opt.gametype = 0;
   opt.wrap = FALSE;
   opt.defend_cities = FALSE;
   opt.fortification = FALSE;
   opt.stacking = FALSE;
   opt.landmines = FALSE;
   opt.seamines = FALSE;
}


/********************************************************************
Cities have a maximum output of 100 industrial units (IU) per turn,
assuming they are at 100% production efficiency.  So, at the default
50% efficiency they produce 50 IU per turn.  In this case a rifle unit
would take five turns, or a total of 250 IU.  When a city is captured or
its production is reset to another unit type, the work in progress (WIP)
value is set to a negative number.  WIP = 0-(unit requirement)*0.2

In the default case, with a newly captured city producing rifles at 50%
efficiency, it begins with a WIP of -50.  Thus, it will take six turns
(and 300 IU) to produce the first rifle, five for each additional.

If the same city were turned over to cruisers (requiring 1500 IU), then
it would begin at -300 WIP and take 36 turns for the first one, 30 for
further cruisers.
********************************************************************/


void change_ptype(code)
int code;
{  // user has change the type of player
   PLAYER.type = (code ? COMPUTER : HUMAN);

   // if player is HUMAN, then disable computer aggressiveness gadgets
   GT_SetGadgetAttrs(aggr_slide,opt_window,NULL,
      GA_Disabled, !code,
      TAG_END );
   GT_SetGadgetAttrs(aggr_int,opt_window,NULL,
      GA_Disabled, !code,
      TAG_END);
}

void change_gametype(code)
int code;
{  // user has changed the type of game
   opt.gametype = (code ? 1 : 2);

   if(opt.gametype==1)
        fmail = TRUE;
   if(opt.gametype==2)
        modem = TRUE;
}

// take a new slider value and update everything that needs it

void read_slider(id_code,new_value)
int id_code;
UWORD new_value;
{
   struct Gadget *dest_integer;

   switch (id_code) {
      case 0:
         dest_integer = prod_int;
         break;
      case 1:
         dest_integer = att_int;
         break;
      case 2:
         dest_integer = def_int;
         break;
      case 3:
      default:
         dest_integer = aggr_int;
   }
   GT_SetGadgetAttrs(dest_integer,opt_window,NULL,
      GTIN_Number, (WORD)new_value,
      TAG_END);
}


// read a value from an integer gadget and
// update everything that needs it

void read_integer(id_code)
int id_code;
{
   long new_value;
   long max_value=100L, min_value=1L;
   struct Gadget *source, *dest;

   switch (id_code) {
      case 0:
         source = prod_int;
         dest = prod_slide;
         break;
      case 1:
         source = att_int;
         dest = att_slide;
         min_value = -8L;
         max_value = 8L;
         break;
      case 2:
         source = def_int;
         dest = def_slide;
         min_value = -8L;
         max_value = 8L;
         break;
      case 3:
      default:
         source = aggr_int;
         dest = aggr_slide;
         min_value = 1L;
         max_value = 10L;
   }
   new_value = ((struct StringInfo *)source->SpecialInfo)->LongInt;
   if (new_value>max_value) {
      new_value = max_value;
      GT_SetGadgetAttrs(source,opt_window,NULL,
         GTIN_Number, new_value,
         TAG_END);
   FI
   if (new_value<min_value) {
      new_value = min_value;
      GT_SetGadgetAttrs(source,opt_window,NULL,
         GTIN_Number, new_value,
         TAG_END);
   FI
   GT_SetGadgetAttrs(dest,opt_window,NULL,
      GTSL_Level, new_value,
      TAG_END);
}


/*
   update_player() updates all the player info gadgets with data
   taken from the player data structures -- critical when the user
   wants to edit or look at a different player
*/

void update_player()
{  // update player gadgets to current values

   // first the player's name
   GT_SetGadgetAttrs(namefield,opt_window,NULL,
      GTST_String, PLAYER.name,
      TAG_END );

   // player type: HUMAN or COMPUTER
   GT_SetGadgetAttrs(rol_ptype,opt_window,NULL,
      GTCY_Active, ((PLAYER.type==COMPUTER) ? 1:0),
      TAG_END );

   // all the integer gadgets
   GT_SetGadgetAttrs(prod_int,opt_window,NULL,
      GTIN_Number, PLAYER.prod,
      TAG_END);
   GT_SetGadgetAttrs(att_int,opt_window,NULL,
      GTIN_Number, PLAYER.att,
      TAG_END);
   GT_SetGadgetAttrs(def_int,opt_window,NULL,
      GTIN_Number, PLAYER.def,
      TAG_END);
   GT_SetGadgetAttrs(aggr_int,opt_window,NULL,
      GTIN_Number, PLAYER.aggr,
      TAG_END);

   // all the slider gadgets
   GT_SetGadgetAttrs(prod_slide,opt_window,NULL,
      GTSL_Level, PLAYER.prod,
      TAG_END);
   GT_SetGadgetAttrs(att_slide,opt_window,NULL,
      GTSL_Level, PLAYER.att,
      TAG_END);
   GT_SetGadgetAttrs(def_slide,opt_window,NULL,
      GTSL_Level, PLAYER.def,
      TAG_END);
   GT_SetGadgetAttrs(aggr_slide,opt_window,NULL,
      GTSL_Level, PLAYER.aggr,
      TAG_END);

   // if player is HUMAN, then disable computer aggressiveness gadgets
   GT_SetGadgetAttrs(aggr_slide,opt_window,NULL,
      GA_Disabled, ((PLAYER.type==COMPUTER) ? 0:1),
      TAG_END );
   GT_SetGadgetAttrs(aggr_int,opt_window,NULL,
      GA_Disabled, ((PLAYER.type==COMPUTER) ? 0:1),
      TAG_END);

   // render the color indicator icon
   px_plot_icon(RIFLE,260,72,PLAYER.color,ORDER_NONE,FALSE);
}


/*
   store_player() substantially reverses the function of update_player(),
   extracting data from the player gadgets and storing it in the
   player's data structure
*/

void store_player()
{  // store data from player gadgets into structure
   // player name
   strcpy(PLAYER.name,
      ((struct StringInfo *)namefield->SpecialInfo)->Buffer);
   /*
      NOTE: no need to update player type, as this is kept up
      to date in the main gadget-handling functions
      production efficiency.  However, the "show" value is derived
      from it and should be updated.
   */
   if (ISHUMAN(PLAYER.type))
      PLAYER.show = SHOW_ALL;
   else
      PLAYER.show = SHOW_NON;
   PLAYER.prod = ((struct StringInfo *)prod_int->SpecialInfo)->LongInt;
   // attack modifier
   PLAYER.att = ((struct StringInfo *)att_int->SpecialInfo)->LongInt;
   // defense modifier
   PLAYER.def = ((struct StringInfo *)def_int->SpecialInfo)->LongInt;
   // computer aggressiveness
   PLAYER.aggr = ((struct StringInfo *)aggr_int->SpecialInfo)->LongInt;
}


/*
   toggle_pgad() handles the choice of a certain player for the user
   to edit or view -- it fiddles with the number-gadget image and then
   updates the other player gadgets
*/

void toggle_pgad(hit_gad)
UWORD hit_gad;
{
   short ctr;

   if (hit_gad <1 || hit_gad>8)
      return;
   for (ctr=1; ctr<=8; ctr++) {
      if (ctr==hit_gad)
         select(pgads[ctr]);
      else
         unselect(pgads[ctr]);
   OD
   ZapGList(pgads[1],opt_window,8);
   RefreshGList(pgads[1],opt_window,NULL,8);
   show_depress(pgads[hit_gad],opt_window->RPort);
   store_player();
   player = hit_gad;
   update_player();
}


// add_player() is the function associated with the [+] button

void add_player()
{  // increment the number of players
   high_player++;
   // if we are at the maximum number, then disable the plus gadget
   if (high_player>=8) {
      disable(plus_gad);
      ZapGList(plus_gad,opt_window,1);
      RefreshGList(plus_gad,opt_window,NULL,1);
   FI
   // if the minus gadget is disabled, then enable it
   if (disabled(minus_gad)) {
      enable(minus_gad);
      ZapGList(minus_gad,opt_window,1);
      RefreshGList(minus_gad,opt_window,NULL,1);
   FI
   enable(pgads[high_player]);
   ZapGList(pgads[1],opt_window,8);
   RefreshGList(pgads[1],opt_window,NULL,8);
   show_depress(pgads[player],opt_window->RPort);
}


// subtract_player is the function associated with the [-] button

void subtract_player()
{  // decrement the number of players
   disable(pgads[high_player]);
   high_player--;
   // if the currently selected player is being removed, then
   // deselect him and select the next lower player
   if (player > high_player) {
       unselect(pgads[player]);
       store_player();
       player--;
       select(pgads[player]);
       update_player();
   FI
   // if we now have the minimum number of players, then
   // disable the minus gadget
   if (high_player<=2) {
      disable(minus_gad);
      ZapGList(minus_gad,opt_window,1);
      RefreshGList(minus_gad,opt_window,NULL,1);
   FI
   // if the plus gadget is disabled, then enable it
   if (disabled(plus_gad)) {
      enable(plus_gad);
      ZapGList(plus_gad,opt_window,1);
      RefreshGList(plus_gad,opt_window,NULL,1);
   FI
   ZapGList(pgads[1],opt_window,8);
   RefreshGList(pgads[1],opt_window,NULL,8);
   show_depress(pgads[player],opt_window->RPort);
}


void av_update_gadget(av_button)
struct Gadget *av_button;
{
   int color, destx, desty;
   int av_icon = av_button->GadgetID;

   destx = av_button->LeftEdge+1;
   desty = av_button->TopEdge+1;

   switch (av_icon) {
      case ARMOR:
         color = GREEN;
         break;
      case AIRCAV:
      case BOMBER:
      case FIGHTER:
         color = LT_BLUE;
         break;
      case DESTROYER:
      case CRUISER:
      case BATTLESHIP:
      case CARRIER:
      case SUB:
         color = DK_BLUE;
         break;
      case LANDMINE:
         bevel_box(destx-1,desty-1,21,17,opt.landmines);
         SetAPen(rast_port,GREEN);  SetDrMd(rast_port,JAM1);
         RectFill(rast_port,destx,desty,destx+18,desty+14);
         px_plot_landmine(destx+3,desty+4);
         if (!opt.landmines) {   // stamp down the "banned" icon
            SetAPen(rast_port,RED);
            BltPattern(rast_port,(PLANEPTR)banned_mask,destx+1,desty+1,destx+17,desty+13,4);
         FI
         return;
      case SEAMINE:
         bevel_box(destx-1,desty-1,21,17,opt.seamines);
         SetAPen(rast_port,DK_BLUE);  SetDrMd(rast_port,JAM1);
         RectFill(rast_port,destx,desty,destx+18,desty+14);
         px_plot_seamine(destx+5,desty+3);
         if (!opt.seamines) {   // stamp down the "banned" icon
            SetAPen(rast_port,RED);
            BltPattern(rast_port,(PLANEPTR)banned_mask,destx+1,desty+1,destx+17,desty+13,4);
         FI
         return;
      default:
         return;
   };
   // for military units only -- not mines
   px_plot_icon(av_icon,destx,desty,color,ORDER_NONE,FALSE);
   if (wishbook[av_icon].enabled)
      bevel_box(destx-1,desty-1,21,17,TRUE);    // show depressed
   else {
      SetAPen(rast_port,RED);    // blit on the red "banned" symbol
      BltPattern(rast_port,(PLANEPTR)banned_mask,destx+1,desty+1,destx+17,desty+13,4);
   FI
}


// edit_options() is the big, monster function in this program module
// it's mostly window and gadget-handling stuff

BOOL edit_options()
{
   int ctr;
   BOOL success;

   // structures for gadtools
   struct Gadget *context, *okay_gad, *cancel_gad;
   struct Gadget *rol_gametype; // , *rol_stacking;
   struct Gadget *defend_cities, *allow_fortify, *use_stacking;
   struct Gadget *av_armor, *av_aircav, *av_bomber, *av_fighter, *av_destroyer,
                 *av_cruiser, *av_battleship, *av_carrier, *av_sub, *av_landmine,
                 *av_seamine;
   struct NewGadget generic = {
      0,32,
      18,13,
      NULL,NULL,
      0,
      NULL,NULL,NULL
   };
   struct NewGadget button = {
      159,219, // leftedge, topedge
      85,14,   // width, height
      "Continue",    // text label
      &topaz11bold,  // font
      1,             // gadget ID
      PLACETEXT_IN,  // flags
      NULL,NULL   // visual info, user data
   };
   struct NewGadget rollo = {
      416,34, // leftedge, topedge
      108,14, // width, height
      "Game Play:",     // text label
      &topaz11,   // font
      2,          // gadget ID
      PLACETEXT_LEFT,
      NULL,NULL      // visual info, user data
   };
   struct NewGadget check = {
      335,52,
      26,11,
      "Use _Stacking Rules?",
      &topaz11,
      3,
      PLACETEXT_RIGHT,
      NULL,NULL
   };
   struct NewGadget stringfield = {
      77,50,
      217,15,
      "_Name:",
      &topaz11,
      4,
      PLACETEXT_LEFT,
      NULL,NULL
   };
   struct NewGadget slider = {
      34,103,
      205,13,
      NULL,
      &topaz11,
      5,
      NULL,
      NULL,NULL
   };
   struct NewGadget intfield = {
      250,102,
      44,15,
      NULL, // "%",
      NULL, // &topaz11,
      6,
      PLACETEXT_RIGHT,
      NULL,NULL
   };
   struct NewGadget av_button = {   // unit AVailability buttons
      372,157,    // location of first active button (ARMOR)
      21,17,      // standard height and width of AO buttons
      NULL,       // no text
      NULL,       // no font
      ARMOR,      // gadget ID
      NULL,       // ng_Flags (no text, so NULL it)
      NULL,       // ng_VisualInfo (must be initialized dynamically)
      NULL,       // ng_UserData
   };

   init_players();

   high_player = 2;
   player = 1;

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the [Continue] and [Abort Game] buttons
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);
   button.ng_LeftEdge = 325;
   button.ng_Width = 100;
   button.ng_GadgetText = "Abort Game";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   cancel_gad = CreateGadget(BUTTON_KIND,okay_gad,&button,TAG_END);

   // the [Map] requester button
   button.ng_LeftEdge = 327;
   button.ng_TopEdge = 116;
   button.ng_Width = 38;
   button.ng_Height = 15;
   button.ng_GadgetText = "Map";
   mapfile_button = CreateGadget(BUTTON_KIND,cancel_gad,&button,TAG_END);

   // create the MANY player buttons
   {
      static struct IntuiText pgad_itext[10];
      static char *numbers[] = { "-","1","2","3","4","5","6","7","8","+" };
      static WORD blackvecs[] = { 1,12, 17,12, 17,0, 16,11, 16,1 };
      static WORD whitevecs[] = { 16,0, 0,0, 0,12, 1,1, 1,11 };
      static struct Border blackside = {
         0,0,           // initial offsets from the origin
         BLACK,GRAY,    // frontpen, backpen
         JAM1,          // drawmode
         5,             // number of vectors
         blackvecs,     // black line vectors
         NULL
      };
      static struct Border whiteside = {
         0,0,           // initial offsets from the origin
         WHITE,GRAY,    // frontpen, backpen
         JAM1,          // drawmode
         5,             // number of vectors
         whitevecs,     // white line vectors
         &blackside     // link to other border struct
      };

      generic.ng_VisualInfo = vi;

      // create the minus player button
      generic.ng_LeftEdge = 64;
      pgad_itext[0].FrontPen = 1;
      pgad_itext[0].BackPen = 0;
      pgad_itext[0].DrawMode = JAM2,
      pgad_itext[0].LeftEdge = 4,
      pgad_itext[0].TopEdge = 3;
      pgad_itext[0].ITextFont = &topaz9;
      pgad_itext[0].IText = "-";
      pgad_itext[0].NextText = NULL;
      minus_gad = CreateGadget(GENERIC_KIND,mapfile_button,&generic,
         TAG_END);
      minus_gad->GadgetText = &pgad_itext[0];
      minus_gad->GadgetType |= GTYP_BOOLGADGET;
      minus_gad->Activation = GACT_IMMEDIATE | GACT_TOGGLESELECT;
      minus_gad->Flags = GFLG_LABELITEXT | GFLG_GADGHNONE | GFLG_DISABLED;
      minus_gad->GadgetRender = &whiteside;
      minus_gad->GadgetID = 16;

      // create the plus player button
      generic.ng_LeftEdge = 238;
      pgad_itext[9].FrontPen = 1;
      pgad_itext[9].BackPen = 0;
      pgad_itext[9].DrawMode = JAM2,
      pgad_itext[9].LeftEdge = 4,
      pgad_itext[9].TopEdge = 3;
      pgad_itext[9].ITextFont = &topaz9;
      pgad_itext[9].IText = "+";
      pgad_itext[9].NextText = NULL;
      plus_gad = CreateGadget(GENERIC_KIND,minus_gad,&generic,
         TAG_END);
      plus_gad->GadgetText = &pgad_itext[9];
      plus_gad->GadgetType |= GTYP_BOOLGADGET;
      plus_gad->Activation = GACT_IMMEDIATE | GACT_TOGGLESELECT;
      plus_gad->Flags = GFLG_LABELITEXT | GFLG_GADGHNONE;
      plus_gad->GadgetRender = &whiteside;
      plus_gad->GadgetID = 25;

      generic.ng_LeftEdge = 88;
      pgads[0] = plus_gad;
      for (ctr = 1; ctr<=8; ctr++) {
         pgad_itext[ctr].FrontPen = 1;
         pgad_itext[ctr].BackPen = 0;
         pgad_itext[ctr].DrawMode = JAM2,
         pgad_itext[ctr].LeftEdge = 5,
         pgad_itext[ctr].TopEdge = 3;
         pgad_itext[ctr].ITextFont = &topaz9;
         pgad_itext[ctr].IText = numbers[ctr];
         pgad_itext[ctr].NextText = NULL;

         pgads[ctr] = CreateGadget(GENERIC_KIND,pgads[ctr-1],&generic,
            TAG_END);
         pgads[ctr]->GadgetText = &pgad_itext[ctr];
         pgads[ctr]->GadgetType |= GTYP_BOOLGADGET;
         pgads[ctr]->Activation = GACT_IMMEDIATE | GACT_TOGGLESELECT;
         pgads[ctr]->Flags = GFLG_LABELITEXT | GFLG_GADGHNONE;
         if (ctr>high_player)
            pgads[ctr]->Flags |= GFLG_DISABLED;
         pgads[ctr]->GadgetRender = &whiteside;
         pgads[ctr]->GadgetID = 16+ctr;
         generic.ng_LeftEdge += generic.ng_Width;
      OD
      select(pgads[1]);
   }

   // create rollo gadgets
   {
      static char *gametype_strings[] = { "Normal","File-Mail","Modem",NULL };
//      static char *stacking_strings[] = { "None","Movement Only","Full",NULL };
      static char *type_strings[] = { "Human", "Computer", NULL };

      rollo.ng_VisualInfo = vi;
      rol_gametype = CreateGadget(CYCLE_KIND,pgads[8],&rollo,
         GTCY_Labels, gametype_strings,
         TAG_END );
//      rollo.ng_TopEdge = 56;
//      rollo.ng_Width = 140;
//      rollo.ng_GadgetText = "Stacking:";
//      rol_stacking = CreateGadget(CYCLE_KIND,rol_gametype,&rollo,
//         GTCY_Labels, stacking_strings,
//         TAG_END );
      rollo.ng_LeftEdge = 76;
      rollo.ng_TopEdge = 70;
      rollo.ng_Width = 100;
      rollo.ng_GadgetText = "_Type:";
      rol_ptype = CreateGadget(CYCLE_KIND,rol_gametype,&rollo,
         GTCY_Labels, type_strings,
         GT_Underscore, '_',
         TAG_END );
   }

   // create checkmark gadgets
   check.ng_VisualInfo = vi;
   use_stacking = CreateGadget(CHECKBOX_KIND,rol_ptype,&check,
         GT_Underscore, '_',
         TAG_END);
   check.ng_TopEdge += 13;
   check.ng_GadgetText = "_Defend Cities?";
   defend_cities = CreateGadget(CHECKBOX_KIND,use_stacking,&check,
         GT_Underscore, '_',
         TAG_END);
   check.ng_TopEdge += 13;
   check.ng_GadgetText = "Allow _Fortification?";
   allow_fortify = CreateGadget(CHECKBOX_KIND,defend_cities,&check,
         GT_Underscore, '_',
         TAG_END);

   // creating string gadget for player's name
   stringfield.ng_VisualInfo = vi;
   namefield = CreateGadget(STRING_KIND,allow_fortify,&stringfield,
      GTST_String, roster[1].name,
      GTST_MaxChars, 40L,
      STRINGA_Justification, GACT_STRINGCENTER,
      GT_Underscore, '_',
      TAG_END);

   // create the slider gadgets
   slider.ng_VisualInfo = vi;
   prod_slide = CreateGadget(SLIDER_KIND,namefield,&slider,
      GTSL_Min,   1,
      GTSL_Max,   100,
      GTSL_Level, 50,
      GA_RelVerify, TRUE,
      TAG_END);
   prod_slide->GadgetID = 30;
   slider.ng_TopEdge += 30;
   att_slide = CreateGadget(SLIDER_KIND,prod_slide,&slider,
      GTSL_Min,   -8,
      GTSL_Max,   8,
      GTSL_Level, 0,
      GA_RelVerify, TRUE,
      TAG_END);
   att_slide->GadgetID = 31;
   slider.ng_TopEdge += 30;
   def_slide = CreateGadget(SLIDER_KIND,att_slide,&slider,
      GTSL_Min,   -8,
      GTSL_Max,   8,
      GTSL_Level, 0,
      GA_RelVerify, TRUE,
      TAG_END);
   def_slide->GadgetID = 32;
   slider.ng_TopEdge += 30;
   aggr_slide = CreateGadget(SLIDER_KIND,def_slide,&slider,
      GTSL_Min,   1,
      GTSL_Max,   10,
      GTSL_Level, 5,
      GA_RelVerify, TRUE,
      GA_Disabled, TRUE,
      TAG_END);
   aggr_slide->GadgetID = 33;

   // create the integer gadgets
   intfield.ng_VisualInfo = vi;
   prod_int = CreateGadget(INTEGER_KIND,aggr_slide,&intfield,
      GTIN_Number, 50,
      GTIN_MaxChars, 3,
      GA_TabCycle, TRUE,
      TAG_END);
   prod_int->GadgetID = 40;
   intfield.ng_TopEdge += 30;
   att_int = CreateGadget(INTEGER_KIND,prod_int,&intfield,
      GTIN_Number, 0,
      GTIN_MaxChars, 3,
      GA_TabCycle, TRUE,
      TAG_END);
   att_int->GadgetID = 41;
   intfield.ng_TopEdge += 30;
   def_int = CreateGadget(INTEGER_KIND,att_int,&intfield,
      GTIN_Number, 0,
      GTIN_MaxChars, 3,
      GA_TabCycle, TRUE,
      TAG_END);
   def_int->GadgetID = 42;
   intfield.ng_TopEdge += 30;
   aggr_int = CreateGadget(INTEGER_KIND,def_int,&intfield,
      GTIN_Number, 5,
      GTIN_MaxChars, 3,
      GA_TabCycle, TRUE,
      GA_Disabled, TRUE,
      TAG_END);
   aggr_int->GadgetID = 43;

   // create string gadget for map filename
   stringfield.ng_LeftEdge = 374;
   stringfield.ng_TopEdge = 116;
   stringfield.ng_Width = 207;
   stringfield.ng_Height = 15;
   stringfield.ng_GadgetText = NULL;
   strcpy(foo,map_filepath);
   if (strlen(foo))
      if (map_filepath[strlen(foo)-1]!='/' && map_filepath[strlen(foo)-1]!=':')
            strcat(foo,"/");
   strcat(foo,map_filename);
   mapfile_field = CreateGadget(STRING_KIND,aggr_int,&stringfield,
      GTST_String,   foo,
      GTST_MaxChars, 128L,
      STRINGA_Justification, GACT_STRINGCENTER,
      TAG_END);

   /*
      Create the ua_button gadgets, beginning with armor.
      NOTE: The RIFLE and TRANSPORT buttons are not real.  They are only here
      for decoration, since those units must always be available in the game.
      By default, the FIGHTER, DESTROYER, CRUISER, BATTLESHIP, SUB, and CARRIER
      are enabled -- units which were available in the original Empire game.
      New units default to disabled: ARMOR, AIRCAV, BOMBER and mines.

      This is where it's tempting to build some kind of loop -- but probably
      not worth the effort.  I'll just go down the list instead.
   */
   av_button.ng_VisualInfo = vi;
   av_armor = CreateGadget(GENERIC_KIND,mapfile_field,&av_button,TAG_END);
   av_armor->Flags |= GFLG_GADGHCOMP;
   av_armor->Activation |= GACT_RELVERIFY;
   wishbook[ARMOR].enabled = FALSE;

   av_button.ng_LeftEdge = 408;
   av_button.ng_GadgetID = AIRCAV;
   av_aircav = CreateGadget(GENERIC_KIND,av_armor,&av_button,TAG_END);
   av_aircav->Flags |= GFLG_GADGHCOMP;
   av_aircav->Activation |= GACT_RELVERIFY;
   wishbook[AIRCAV].enabled = FALSE;

   av_button.ng_LeftEdge = 444;
   av_button.ng_GadgetID = BOMBER;
   av_bomber = CreateGadget(GENERIC_KIND,av_aircav,&av_button,TAG_END);
   av_bomber->Flags |= GFLG_GADGHCOMP;
   av_bomber->Activation |= GACT_RELVERIFY;
   wishbook[BOMBER].enabled = FALSE;

   av_button.ng_LeftEdge = 480;
   av_button.ng_GadgetID = FIGHTER;
   av_fighter = CreateGadget(GENERIC_KIND,av_bomber,&av_button,TAG_END);
   av_fighter->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_fighter->Activation |= GACT_RELVERIFY;
   wishbook[FIGHTER].enabled = TRUE;

   av_button.ng_LeftEdge = 552;
   av_button.ng_GadgetID = LANDMINE;
   av_landmine = CreateGadget(GENERIC_KIND,av_fighter,&av_button,TAG_END);
   av_landmine->Flags |= GFLG_GADGHCOMP;
   av_landmine->Activation |= GACT_RELVERIFY;
   opt.landmines = FALSE;

   av_button.ng_LeftEdge = 372;     av_button.ng_TopEdge = 185;
   av_button.ng_GadgetID = DESTROYER;
   av_destroyer = CreateGadget(GENERIC_KIND,av_landmine,&av_button,TAG_END);
   av_destroyer->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_destroyer->Activation |= GACT_RELVERIFY;
   wishbook[DESTROYER].enabled = TRUE;

   av_button.ng_LeftEdge = 408;
   av_button.ng_GadgetID = CRUISER;
   av_cruiser = CreateGadget(GENERIC_KIND,av_destroyer,&av_button,TAG_END);
   av_cruiser->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_cruiser->Activation |= GACT_RELVERIFY;
   wishbook[CRUISER].enabled = TRUE;

   av_button.ng_LeftEdge = 444;
   av_button.ng_GadgetID = BATTLESHIP;
   av_battleship = CreateGadget(GENERIC_KIND,av_cruiser,&av_button,TAG_END);
   av_battleship->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_battleship->Activation |= GACT_RELVERIFY;
   wishbook[BATTLESHIP].enabled = TRUE;

   av_button.ng_LeftEdge = 480;
   av_button.ng_GadgetID = CARRIER;
   av_carrier = CreateGadget(GENERIC_KIND,av_battleship,&av_button,TAG_END);
   av_carrier->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_carrier->Activation |= GACT_RELVERIFY;
   wishbook[CARRIER].enabled = TRUE;

   av_button.ng_LeftEdge = 516;
   av_button.ng_GadgetID = SUB;
   av_sub = CreateGadget(GENERIC_KIND,av_carrier,&av_button,TAG_END);
   av_sub->Flags |= GFLG_GADGHCOMP|GFLG_SELECTED;
   av_sub->Activation |= GACT_RELVERIFY;
   wishbook[SUB].enabled = TRUE;

   av_button.ng_LeftEdge = 552;
   av_button.ng_GadgetID = SEAMINE;
   av_seamine = CreateGadget(GENERIC_KIND,av_sub,&av_button,TAG_END);
   av_seamine->Flags |= GFLG_GADGHCOMP;
   av_seamine->Activation |= GACT_RELVERIFY;
   opt.seamines = FALSE;

   {
      int watop, waleft;
      #define WAWIDTH 607
      #define WAHEIGHT 239

      watop = (map_screen->Height-WAHEIGHT)/2;
      waleft = (map_screen->Width-WAWIDTH)/2;

      opt_window = OpenWindowTags(NULL,
         WA_Gadgets,context,
         WA_Title,"Starting a New Game",
         WA_CustomScreen,map_screen,
         WA_Top,watop,        WA_Left,waleft,
         WA_Height,WAHEIGHT,  WA_Width,WAWIDTH,
         WA_IDCMP,IDCMP_GADGETUP|IDCMP_GADGETDOWN|IDCMP_VANILLAKEY,
         WA_Flags,NOCAREREFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
         TAG_END );
      if (opt_window==NULL)
         clean_exit(1,"ERROR: Unable to open options window!");
      #undef WAWIDTH
      #undef WAHEIGHT
   }

   // render frames and text here
   rast_port = opt_window->RPort;
   frame(17,22,286,191,TRUE);
   frame(316,22,276,191,TRUE);
   plot_text(79,18," Player Information ",BLACK,LT_GRAY,JAM2,&topaz11);
   plot_text(402,18," Game Options ",BLACK,LT_GRAY,JAM2,&topaz11);
   plot_text(328,138,"Units Available:",BLACK,LT_GRAY,JAM1,&topaz11);
   plot_text(28,90,"Production Efficiency:",BLACK,LT_GRAY,JAM1,&topaz11);
   plot_text(29,120,"Attack Modifier:",BLACK,LT_GRAY,JAM1,&topaz11);
   plot_text(29,150,"Defense Modifier:",BLACK,LT_GRAY,JAM1,&topaz11);
   plot_text(28,180,"Computer Aggressiveness:",BLACK,LT_GRAY,JAM1,&topaz11);

   // render the color indicator icon
   plot_text(201,74,"Color:",BLACK,LT_GRAY,JAM1,&topaz11);
   px_plot_icon(RIFLE,260,72,PLAYER.color,ORDER_NONE,FALSE);
   bevel_box(257,69,25,21,TRUE);

   // render the unit icons
   // first the FAKE ones, just for decoration
   px_plot_icon(RIFLE,337,158,GREEN,ORDER_NONE,FALSE);
   bevel_box(336,157,21,17,TRUE);   // show depressed
   bevel_frame(332,154,29,23,TRUE);
   px_plot_icon(TRANSPORT,337,186,DK_BLUE,ORDER_NONE,FALSE);
   bevel_box(336,185,21,17,TRUE);   // show depressed
   bevel_frame(332,182,29,23,TRUE);

   // next I start on my av_button imagery, using the same function
   // that updates them when the user messes with them
   av_update_gadget(av_armor);
   bevel_frame(368,154,29,23,FALSE);
   av_update_gadget(av_aircav);
   bevel_frame(404,154,29,23,FALSE);
   av_update_gadget(av_bomber);
   bevel_frame(440,154,29,23,FALSE);
   av_update_gadget(av_fighter);
   bevel_frame(476,154,29,23,FALSE);

   // THIS SPACE INTENTIALLY LEFT BLANK
   bevel_box(512,154,29,23,TRUE);

   av_update_gadget(av_destroyer);
   bevel_frame(368,182,29,23,FALSE);
   av_update_gadget(av_cruiser);
   bevel_frame(404,182,29,23,FALSE);
   av_update_gadget(av_battleship);
   bevel_frame(440,182,29,23,FALSE);
   av_update_gadget(av_carrier);
   bevel_frame(476,182,29,23,FALSE);
   av_update_gadget(av_sub);
   bevel_frame(512,182,29,23,FALSE);

   // next two spaces reserved for mines
   av_update_gadget(av_landmine);
   bevel_frame(548,154,29,23,FALSE);
   av_update_gadget(av_seamine);
   bevel_frame(548,182,29,23,FALSE);

   // select the current player's gadget
   show_depress(pgads[1],opt_window->RPort);

   begin_message_loop:
   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      struct Gadget *mygad;

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(opt_window->UserPort);
         while (message = GT_GetIMsg(opt_window->UserPort)) {
            code = message->Code;  // MENUNUM
            mygad = object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  case 'v':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                  case 'n':
                     ActivateGadget(namefield,opt_window,NULL);
                     break;
                  case 't':
                     // toggle the current player type HUMAN/COMPUTER
                     GT_SetGadgetAttrs(rol_ptype,opt_window,NULL,
                        GTCY_Active, ((PLAYER.type==COMPUTER) ? 0:1),
                        TAG_END);
                     change_ptype((PLAYER.type==COMPUTER) ? 0:1);
                     break;
                  case 'd':
                     // toggle the DEFEND CITIES gadget
                     setselect(defend_cities,!selected(defend_cities));
                     RefreshGList(defend_cities,opt_window,NULL,1);
                     break;
                  case 's':
                     // toggle the STACKING RULES gadget
                     setselect(use_stacking,!selected(use_stacking));
                     RefreshGList(use_stacking,opt_window,NULL,1);
                     break;
                  case 'f':
                     // toggle the FORTIFICATION gadget
                     setselect(allow_fortify,!selected(allow_fortify));
                     RefreshGList(allow_fortify,opt_window,NULL,1);
                     break;
                  case 13:
                     // show the button depressed
                     show_depress(okay_gad,opt_window->RPort);
                     Delay(10L);
                     success = TRUE;
                     goto exit_opt_window;
                  case 'b':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                     show_depress(cancel_gad,opt_window->RPort);
                     Delay(10L);
                     success = FALSE;
                     goto exit_opt_window;
                  case '-':
                     if (disabled(minus_gad))
                        break;
                     show_depress(minus_gad,opt_window->RPort);
                     Delay(10L);
                     show_depress(minus_gad,opt_window->RPort);
                     subtract_player();
                     break;
                  case '+':
                     if (disabled(plus_gad))
                        break;
                     show_depress(plus_gad,opt_window->RPort);
                     Delay(10L);
                     show_depress(plus_gad,opt_window->RPort);
                     add_player();
                     break;
               }
               if ((char)code>=49 && (char)code<=56) {
                  int pnum = code-48;
                  if (pnum>high_player)
                     continue;
                  toggle_pgad(pnum);
               FI
            FI
            if (class==IDCMP_GADGETDOWN)
               if (mygad->GadgetID>=17 && mygad->GadgetID<=24)
                  toggle_pgad(mygad->GadgetID-16);
               if (mygad==minus_gad || mygad==plus_gad) {
                  show_depress((struct Gadget *)mygad,opt_window->RPort);
                  Delay(10L);
                  show_depress((struct Gadget *)mygad,opt_window->RPort);
                  if (object==plus_gad)
                     add_player();
                  if (object==minus_gad)
                     subtract_player();
               FI
            if (class==IDCMP_GADGETUP) {
               if (mygad->GadgetID>=30 && mygad->GadgetID<=33)
                  read_slider(mygad->GadgetID-30,code);
               if (mygad->GadgetID>=30 && mygad->GadgetID<=43)
                  read_integer(mygad->GadgetID-40);
               if (object==okay_gad) {
                  success = TRUE;
                  goto exit_opt_window;
               FI
               if (object==cancel_gad) {
                  success = FALSE;
                  goto exit_opt_window;
               FI
               if (object==rol_ptype)
                  change_ptype(code);
               if (object==rol_gametype)
                  change_gametype(code);
               if (object==mapfile_button) {
                  // call the ReqTools file requester for a map filename
                  struct rtFileRequester *req = NULL;
                  char pan[216];  // pan = Path And Name
                  BOOL chosen;

                  req = rtAllocRequestA(RT_FILEREQ,NULL);
                  if (req==NULL) {
                     alert(map_window,NULL,"Failed to allocate ReqTools file requester.","Drat!");
                     continue;
                  FI

                  rtChangeReqAttr(req,
                     RTFI_Dir,map_filepath,
                     RTFI_MatchPat,"#?.MAP",
                     TAG_END);
                  strcpy(pan,map_filename);
                  chosen = (BOOL)rtFileRequest(req,map_filename,"Select Map",
                     RTFI_Flags, FREQF_PATGAD,
                     RT_DEFAULT, TAG_END);
                  if (chosen) {
                     int dirlen = strlen(req->Dir);
                     strcpy(map_filepath,req->Dir);
                     strcpy(pan,map_filepath);
                     if (dirlen)
                        if (map_filepath[dirlen-1]!='/' && map_filepath[dirlen-1]!=':')
                           strcat(pan,"/");
                     strcat(pan,map_filename);
                     // copy pan into the string gadget
                     GT_SetGadgetAttrs(mapfile_field,opt_window,NULL,
                        GTST_String,   pan,
                        TAG_DONE);
                  FI
                  rtFreeRequest(req);
               FI

               if (object==av_armor) {
                  wishbook[ARMOR].enabled = !wishbook[ARMOR].enabled;
                  av_update_gadget(av_armor);
               FI
               if (object==av_aircav) {
                  wishbook[AIRCAV].enabled = !wishbook[AIRCAV].enabled;
                  av_update_gadget(av_aircav);
               FI
               if (object==av_bomber) {
                  wishbook[BOMBER].enabled = !wishbook[BOMBER].enabled;
                  av_update_gadget(av_bomber);
               FI
               if (object==av_fighter) {
                  wishbook[FIGHTER].enabled = !wishbook[FIGHTER].enabled;
                  av_update_gadget(av_fighter);
               FI
               if (object==av_destroyer) {
                  wishbook[DESTROYER].enabled = !wishbook[DESTROYER].enabled;
                  av_update_gadget(av_destroyer);
               FI
               if (object==av_cruiser) {
                  wishbook[CRUISER].enabled = !wishbook[CRUISER].enabled;
                  av_update_gadget(av_cruiser);
               FI
               if (object==av_battleship) {
                  wishbook[BATTLESHIP].enabled = !wishbook[BATTLESHIP].enabled;
                  av_update_gadget(av_battleship);
               FI
               if (object==av_carrier) {
                  wishbook[CARRIER].enabled = !wishbook[CARRIER].enabled;
                  av_update_gadget(av_carrier);
               FI
               if (object==av_sub) {
                  wishbook[SUB].enabled = !wishbook[SUB].enabled;
                  av_update_gadget(av_sub);
               FI
               if (object==av_landmine) {
                  opt.landmines = !opt.landmines;
                  av_update_gadget(av_landmine);
               FI
               if (object==av_seamine) {
                  opt.seamines = !opt.seamines;
                  av_update_gadget(av_seamine);
               FI
            FI
         OD
      OD
   }
   exit_opt_window:

   // flag the unused players
   for (ctr = high_player+1; ctr<=8; ctr++)
      roster[ctr].type = NOPLAYER;

   // store the active player's data
   store_player();

   // extract game option info from requester

   opt.defend_cities = selected(defend_cities);
   opt.fortification = selected(allow_fortify);
   opt.stacking = selected(use_stacking);

   // attempt to load the map
   if (success) {   // i.e. the user didn't cancel
      char *requested_fname;

      requested_fname = ((struct StringInfo *)mapfile_field->SpecialInfo)->Buffer;
      if (FLength(requested_fname)>0)
         success = load_map(requested_fname);
      else {
         int l;

         strcpy(foo,map_filepath);
         l = strlen(foo);
         if (l)
            if (map_filepath[l-1]!='/' && map_filepath[l-1]!=':')
               strcat(foo,"/");
         strcat(foo,map_filename);
         success = load_map(foo);
      FI
      // Now we need to test that the map selected has enough cities for
      //   all the players
      if( count_nodes(&city_list) < high_player ) {
         // Tell the user the bad news and put him back in the loop
         (void)rtEZRequestTags("Error! Map has too few cities.",
            "Okay",           NULL,              NULL,
            RT_Window,        map_window,
            RT_ReqPos,        REQPOS_CENTERSCR,
            RT_LockWindow,    TRUE,
            RTEZ_Flags,       EZREQF_CENTERTEXT,
            TAG_DONE );
         goto begin_message_loop;
      }
   }

   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_MENUPICK);

   CloseWindow(opt_window);
   opt_window = NULL;
   rast_port = map_window->RPort;
   FreeGadgets(context);
   return success;
}

// end of listing
