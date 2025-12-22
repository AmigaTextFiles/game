/*
   status.c -- status report and examine city functions for Invasion Force

   This module creates a dialog box (or "requester window") allowing the
   player to examine a city and set the production.
   It also provides the status report, ship report, world view functions, etc.

   This source code is free.  You may make as many copies as you like.
*/

#include "global.h"

char *lv_text[11];        // text strings for my listview gadget
int high_text, now_text;   // highest number string in gadget; selected string



void draw_listview()
{
   int ctr = 0;

   // create embossed frame
   DrawBevelBox(rast_port,10,94,270,135,GT_VisualInfo,vi,TAG_END);

   // render in the text from my data structures
   for (ctr=0; ctr<=high_text; ctr++)
      if (ctr==now_text)
         plot_text(13,96+ctr*12,lv_text[ctr],WHITE,BLACK,JAM2,&topaz11);
      else
         plot_text(13,96+ctr*12,lv_text[ctr],BLACK,LT_GRAY,JAM2,&topaz11);

}


void update_listview(new_text)
int new_text;
{
   if (new_text!=now_text) {
      // deselect the old text
      plot_text(13,96+now_text*12,lv_text[now_text],BLACK,LT_GRAY,JAM2,&topaz11);
      // select the new
      plot_text(13,96+new_text*12,lv_text[new_text],WHITE,BLACK,JAM2,&topaz11);
      now_text = new_text;
   }
}


// this function will show the relevant data for a city, and allow
// the owner to change the production or anything else in it

void examine_city(metro)
struct City *metro;
{
   // now I must delve into a lot of that Intuition junk
   // take a deep breath -- I should be used to it by now...
   int ctr;
   struct Window *city_window = NULL;
   struct Gadget *context, *okay_gad, *cancel_gad;
   struct NewGadget button = {
      62,245,  // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   };

   // This table will help me look up which unit type the user has selected
   // from the current list.
   int lookup[13], index;

   // I won't mess with the actual production until I leave this window,
   // so I will store the new value in new_product until then.
   int new_product = metro->unit_type;
   int old_product = metro->unit_type;

   if (metro->unit_type==-1)
      new_product = RIFLE;    // default for newly captured cities

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the [Okay] and [Cancel] buttons
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);
   button.ng_LeftEdge = 166;
   button.ng_GadgetText = "Cancel";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   cancel_gad = CreateGadget(BUTTON_KIND,okay_gad,&button,TAG_END);

   // This block examines a city (metro) and builds a list detailing the
   // items that can be produced there, and how long it will take to make each
   // of them.  The resulting list is intended for use with the LISTVIEW gadget
   // when viewing city information.
   {
      int industry, prod_time, under_const, ctr;
      char pad[] = " ------------------";
      BOOL seaport = port_cityP(metro);

      // factoring in both player production efficiency and city production
      // efficiency gives us a final industry output value from 2 to 200.
      industry = (PLAYER.prod*metro->industry)/50;

      // initialize the data for my improvised listview gadget
      high_text = -1;
      now_text = 0;

      // use this loop to hit each unit type from the wishbook
      for (ctr=0, index=0; ctr<=10; ctr++)
         if (wishbook[ctr].enabled) {

            // skip over ships if this is not a port city
            if (seaport==FALSE && wishbook[ctr].ship_flag==TRUE)
               continue;

            // build my lookup table
            lookup[index++] = ctr;

            // basic time to produce
            prod_time = wishbook[ctr].build/industry;

            // now see if we are already building this type unit
            if (metro->unit_type==wishbook[ctr].type) {
               prod_time -= metro->unit_wip/industry;
               now_text = index-1;
            } else
               prod_time += prod_time/5;     // startup penalty

            // count number of such units already in production
            {
               struct City *metro = (struct City *)city_list.mlh_Head;
               for (under_const=0; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ)
                  if (metro->owner==player && metro->unit_type==ctr)
                     under_const++;
            }

            // generate the string
            strcpy(foo," ");
            strcat(foo,wishbook[ctr].name);
            strncat(foo,pad,18-strlen(foo));
            sprintf(bar," %3ld ------ %2ld ",prod_time,under_const);
            strcat(foo,bar);

            // generate the listview text strings
            lv_text[++high_text] = AllocVec((ULONG)(strlen(foo)+1),MEMF_CLEAR);
            strcpy(lv_text[high_text],foo);
         FI
   }

   // do the window itself
   {
      // I am trying to position the window so it does not
      // obscure the city itself.
      int mx, my;
      int left_edge, top_edge;

      log_to_abs(metro->col,metro->row,&mx,&my);
      if ((metro->col-xoffs)<(disp_wd/2))
         left_edge = mx+46;
      else
         left_edge = mx-305;
      top_edge = my-10;

      city_window = OpenWindowTags(NULL,
         WA_Gadgets,context,
         WA_Title,         "City Information",
         WA_CustomScreen,  map_screen,
         WA_Top,top_edge,  WA_Left,left_edge,
         WA_Height,267,    WA_Width,291,
         WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY|IDCMP_RAWKEY|IDCMP_MOUSEBUTTONS,
         WA_Flags,         WFLG_SMART_REFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
         TAG_END );
      if (city_window==NULL)
         clean_exit(1,"ERROR: Unable to open city information window!");
      GT_RefreshWindow(city_window,NULL);
   }

   // call to render in my improvised listview gadget
   rast_port = city_window->RPort;
   draw_listview();

   // print some text
   sprintf(foo,"NAME: %-19s",metro->name);
   plot_text(11,18,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"OWNER: %-25s",roster[metro->owner].name);
   plot_text(11,31,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"INDUSTRY: %ld",metro->industry);
   plot_text(11,44,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"LOCATION: %ld, %ld",metro->col,metro->row);
   plot_text(11,55,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"CURRENTLY PRODUCING: %s",wishbook[new_product].name);
   plot_text(11,231,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   plot_text(149,72," Prod     Under",BLACK,LT_GRAY,JAM2,&topaz8);
   plot_text(149,82," Time     Const",BLACK,LT_GRAY,JAM2,&topaz8);

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(city_window->UserPort);
         while (message = GT_GetIMsg(city_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  // left-Amiga V or RETURN are defaults for "Okay"
                  case 'v':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                  case 13:    // RETURN/ENTER
                     // show the button depressed
                     show_depress(okay_gad,city_window->RPort);
                     Delay(10L);
                     metro->unit_type = new_product;
                     goto exit_city_window;
                  // left-Amiga B is default for "Cancel"
                  case 'b':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                     show_depress(cancel_gad,city_window->RPort);
                     Delay(10L);
                     goto exit_city_window;
               }
            FI
            if (class==IDCMP_RAWKEY) {
               switch ((int)code) {
                  case 76:    // up cursor
                     if (now_text>0) {
                        update_listview(now_text-1);
                        new_product = lookup[now_text];
                     }
                     break;
                  case 77:    // down cursor
                     if (now_text<high_text) {
                        update_listview(now_text+1);
                        new_product = lookup[now_text];
                     }
               }
            FI
            if (class==IDCMP_MOUSEBUTTONS && code==SELECTDOWN) {
               int new_text;
               int x=message->MouseX, y=message->MouseY;

               // define the hit area for this pseudo-gadget
               if (x<11 || x>(10+270-1) || y<94 || y>(94+135-1))
                  break;

               // I have to find out what part of the gadget (i.e. which
               // text string) was hit and then figure out which unit type
               // it is referring to.  Fortunately, I have prepared a table
               // for that purpose.
               new_text = (y-95)/12;
               if (new_text>high_text)
                  break;

               update_listview(new_text);
               new_product = lookup[now_text];
            FI
            if (class==IDCMP_GADGETUP) {
               if (object==okay_gad) {
                  metro->unit_type = new_product;
                  goto exit_city_window;
               FI
               if (object==cancel_gad)
                  goto exit_city_window;
            FI
         OD
      OD
   }
   exit_city_window:

   // adjust WIP value to account for startup of a new product
   if (old_product!=new_product)
      metro->unit_wip = -wishbook[new_product].build/5;

   // in case this city was just taken (no prior production) and the
   // user selected CANCEL, so it gets the default value of RIFLE
   if (metro->unit_type==-1)  metro->unit_type=RIFLE;

   // now close up everything with the mapsize_window
   CloseWindow(city_window);
   FreeGadgets(context);

   // so that survey mode can pick up in the same spot
   cursx = metro->col;
   cursy = metro->row;

   // wipe out the listview text and clear the other data
   for (ctr=0; ctr<=high_text; ctr++) {
      FreeVec(lv_text[ctr]);
      lv_text[ctr] = NULL;
   OD

   rast_port = map_window->RPort;
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}


void status_report(player)
int player;
{
   struct Window *status_window = NULL;
   struct Gadget *context, *okay_gad;
   int wd=543, ht=246;
   int left_edge, top_edge;

   struct NewGadget button = {
      460,21,  // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   };

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);

   left_edge = (map_screen->Width-wd)/2;
   top_edge = (map_screen->Height-ht)/2;

   status_window = OpenWindowTags(NULL,
      WA_Gadgets,       context,
      WA_Title,         "War Report",
      WA_CustomScreen,  map_screen,
      WA_Top,           top_edge,
      WA_Left,          left_edge,
      WA_Height,        ht,
      WA_Width,         wd,
      WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY,
      WA_Flags,         WFLG_SMART_REFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
      TAG_END );
   if (status_window==NULL)
      clean_exit(1,"ERROR: Unable to open status report window!");
   GT_RefreshWindow(status_window,NULL);
   rast_port = status_window->RPort;

   // this section is where I calculate and print the report info
   {
      struct City *metro;
      struct Unit *unit;
      int ctr, x, y, explored, all_cities=0, my_cities=0,
         uuc[11],    // units under construction
         usc[11],    // units soonest completion
         uic[11];    // unit in combat

      for (ctr=0; ctr<11; ctr++) {
         uuc[ctr] = 0;
         usc[ctr] = -1;
         uic[ctr] = 0;
      }

      metro = (struct City *)city_list.mlh_Head;
      for (; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ) {
         all_cities++;
         if (metro->owner==player) {
            int industry, prod_time, utype=metro->unit_type;
            my_cities++;
            uuc[utype]++;
            industry = (PLAYER.prod*metro->industry)/50;
            prod_time = wishbook[utype].build/industry-metro->unit_wip/industry;
            if (prod_time<usc[utype] || usc[utype]<0)
               usc[utype] = prod_time;
         }
      }

      unit =  (struct Unit *)unit_list.mlh_Head;
      for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player)
            uic[unit->type]++;

      explored = 0;
      for (x=0; x<width; x++)
         for (y=0; y<height; y++)
            if (get(PLAYER.map,x,y)!=HEX_UNEXPLORED)
               explored++;

      // print some text
      sprintf(foo,"Turn #%ld    Player #%ld    %s",turn,player,PLAYER.name);
      plot_text(11,18,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      plot_text(11,36,
         "                                   World",
         BLACK,LT_GRAY,JAM2,&topaz11);
      plot_text(11,48,
         "         Captured   Exist         Explored",
         BLACK,LT_GRAY,JAM2,&topaz11);
      sprintf(foo,"CITIES    %3ld       %3ld            %3ld",
         my_cities, all_cities, (explored*100)/(width*height));
      strcat(foo,"%");
      plot_text(11,60,foo,BLACK,LT_GRAY,JAM2,&topaz11);

      plot_text(116,84,"    Under      Soonest    Are In    We've    We've",
         BLACK,LT_GRAY,JAM2,&topaz11);
      plot_text(116,96,"Construction  Completion  Combat  Destroyed   Lost",
         BLACK,LT_GRAY,JAM2,&topaz11);

      for (ctr=0;ctr<11;ctr++) {
         if (usc[ctr]>=0)
            sprintf(foo,"%-11s      %3ld          %3ld       %3ld       %3ld      %3ld",
               wishbook[ctr].name,
               uuc[ctr],usc[ctr],uic[ctr],PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         else
            sprintf(foo,"%-11s      %3ld          N/A       %3ld       %3ld      %3ld",
               wishbook[ctr].name,
               uuc[ctr],uic[ctr],PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         if (wishbook[ctr].enabled==FALSE)
            sprintf(foo,"%-11s      N/A          N/A       %3ld       %3ld      %3ld",
               wishbook[ctr].name,
               uic[ctr],PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         plot_text(12,108+ctr*12,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      OD

      // draw the black frame around this area
      SetAPen(rast_port,BLACK);
      Move(rast_port,107,81);
      Draw(rast_port,530,81);
      Draw(rast_port,530,239);
      Draw(rast_port,107,239);
      Draw(rast_port,107,81);
      Move(rast_port,220,81);    Draw(rast_port,220,239);
      Move(rast_port,316,81);    Draw(rast_port,316,239);
      Move(rast_port,378,81);    Draw(rast_port,378,239);
      Move(rast_port,467,81);    Draw(rast_port,467,239);
   }

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(status_window->UserPort);
         while (message = GT_GetIMsg(status_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  // left-Amiga V or RETURN are defaults for "Okay"
                  case 'v':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                  case 13:    // RETURN/ENTER
                     // show the button depressed
                     show_depress(okay_gad,status_window->RPort);
                     Delay(10L);
                     goto exit_status_window;
               }
            FI
            if (class==IDCMP_GADGETUP)
               if (object==okay_gad)
                  goto exit_status_window;
         OD
      OD
   }

 exit_status_window:
   // now close up everything with the status_window
   CloseWindow(status_window);
   FreeGadgets(context);

   // reset everything for map window
   rast_port = map_window->RPort;
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}

void end_of_player(player)
int player;
{
   struct Window *eop_window = NULL;
   struct Gadget *context, *okay_gad;
   int wd=543, ht=246;
   int left_edge, top_edge;
   int music;
   
   struct NewGadget button = {
      460,21,  // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   };

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);

   left_edge = (map_screen->Width-wd)/2;
   top_edge = (map_screen->Height-ht)/2;

   eop_window = OpenWindowTags(NULL,
      WA_Gadgets,       context,
      WA_Title,         "End Of Player Report - You're DEAD!",
      WA_CustomScreen,  map_screen,
      WA_Top,           top_edge,
      WA_Left,          left_edge,
      WA_Height,        ht,
      WA_Width,         wd,
      WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY,
      WA_Flags,         WFLG_SMART_REFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
      TAG_END );
   if (eop_window==NULL)
      clean_exit(1,"ERROR: Unable to open eop report window!");
   GT_RefreshWindow(eop_window,NULL);
   rast_port = eop_window->RPort;

   // End Of Game tunes
   music = GetPlayer(0);
   if (music != 0)
       clean_exit(1,"ERROR: Unable to open music player!");
        
   PlayModule(LoadModule("PROGDIR:Data/Music/afterwar.med"));
   //SetTempo(33);     

   // this section is where I calculate and print the report info
   {
      struct City *metro;
      struct Unit *unit;
      int ctr, x, y, explored, all_cities=0, my_cities=0,
         uuc[11],    // units under construction
         usc[11],    // units soonest completion
         uic[11];    // unit in combat

      for (ctr=0; ctr<11; ctr++) {
         uuc[ctr] = 0;
         usc[ctr] = -1;
         uic[ctr] = 0;
      }

      metro = (struct City *)city_list.mlh_Head;
      for (; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ) {
         all_cities++;
         if (metro->owner==player) {
            int industry, prod_time, utype=metro->unit_type;
            my_cities++;
            uuc[utype]++;
            industry = (PLAYER.prod*metro->industry)/50;
            prod_time = wishbook[utype].build/industry-metro->unit_wip/industry;
            if (prod_time<usc[utype] || usc[utype]<0)
               usc[utype] = prod_time;
         }
      }

      unit =  (struct Unit *)unit_list.mlh_Head;
      for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player)
            uic[unit->type]++;

      explored = 0;
      for (x=0; x<width; x++)
         for (y=0; y<height; y++)
            if (get(PLAYER.map,x,y)!=HEX_UNEXPLORED)
               explored++;

      // print some text
      sprintf(foo,"Turns %ld    Player #%ld    %s",turn,player,PLAYER.name);
      plot_text(11,18,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      plot_text(11,36,
         "                                   World",
         BLACK,LT_GRAY,JAM2,&topaz11);
      plot_text(11,48,
         "         Captured   Exist         Explored",
         BLACK,LT_GRAY,JAM2,&topaz11);
      sprintf(foo,"CITIES    %3ld       %3ld            %3ld",
         my_cities, all_cities, (explored*100)/(width*height));
      strcat(foo,"%");
      plot_text(11,60,foo,BLACK,LT_GRAY,JAM2,&topaz11);

      plot_text(116,84,"      We          We",
         BLACK,LT_GRAY,JAM2,&topaz11); 
      plot_text(116,96,"  Destroyed      Lost",
         BLACK,LT_GRAY,JAM2,&topaz11);

      for (ctr=0;ctr<11;ctr++) {
         if (usc[ctr]>=0)
            sprintf(foo,"%-11s     %3ld          %3ld",
               wishbook[ctr].name,PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         else
            sprintf(foo,"%-11s     %3ld          %3ld",
               wishbook[ctr].name,PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         if (wishbook[ctr].enabled==FALSE)
            sprintf(foo,"%-11s     %3ld          %3ld",
               wishbook[ctr].name,PLAYER.eud[ctr],PLAYER.ulc[ctr]);
         plot_text(12,108+ctr*12,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      OD

      // draw the black frame around this area
      SetAPen(rast_port,BLACK);
      Move(rast_port,107,81);
      Draw(rast_port,530,81);
      Draw(rast_port,530,239);
      Draw(rast_port,107,239);
      Draw(rast_port,107,81);
      Move(rast_port,220,81);    Draw(rast_port,220,239);
      Move(rast_port,316,81);    Draw(rast_port,316,239);
      Move(rast_port,378,81);    Draw(rast_port,378,239);
      Move(rast_port,467,81);    Draw(rast_port,467,239);
   }

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(eop_window->UserPort);
         while (message = GT_GetIMsg(eop_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  // left-Amiga V or RETURN are defaults for "Okay"
                  case 'v':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                  case 13:    // RETURN/ENTER
                     // show the button depressed
                     show_depress(okay_gad,eop_window->RPort);
                     Delay(10L);
                     goto exit_eop_window;
               }
            FI
            if (class==IDCMP_GADGETUP)
               if (object==okay_gad)
                  goto exit_eop_window;
         OD
      OD
   }

 exit_eop_window:
   // now close up everything with the status_window
   CloseWindow(eop_window);
   FreeGadgets(context);
   UnLoadModule(0);
   FreePlayer();

   // reset everything for map window
   rast_port = map_window->RPort;
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}


/*
   context_sound() is used to decide when and how loudly sound effects
   should be played, based on the player's status.  I put it here instead
   of in sound.c so it's easier to access all my defined values.  So sue me!
*/

void context_sound(snum)
int snum;
{
   int volume=PLAYER.snd_vol;

   // I am going to decide whether the sound is played by a culling process
   if (PLAYER.show&SHOW_SND==0)     // this bit enables the sounds for a player
      return;
   if (PLAYER.soundfx==SOUND_NONE || volume==0)
      return;     // the player has turned his sounds off
   if (PLAYER.soundfx==SOUND_BATTLE)
      return;     // he only wants to hear the battles
   /* now there's nothing left for it but to play the sound */
   playSound(snum,volume);
}



// Here's a function where I tell the player news of some game event.
// Each player has his own time delay setting for messages.

void tell_player(news)
char *news;
{
// TLB v0.13
   SetWindowTitles(map_window,news,(UBYTE *)~0);
   prop_delay(25,player,FALSE);
//   strcpy(win_title,"Game in progress...");
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
}

               
/*
   The player can call up a dialog box to set all his game preferences,
   including sound, battle and message delays, show fighter & army
   construction, automatic battle reports, and anything else I think of.
*/
void player_preferences()
{
   struct Window *prefs_window = NULL;
   struct Gadget *context, *okay_gad, *cancel_gad;
   struct Gadget *btl_delay_slide, *msg_delay_slide, *snd_vol_slide;
   struct Gadget *autodsp_check, *autorpt_check;
   struct Gadget *soundfx_rollo;
   int wd=509, ht=144;
   int left_edge, top_edge;
   BOOL cancel=FALSE;
   struct NewGadget button = {
      75,232,  // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   };
   struct NewGadget slider = {
      11,33,
      232,13,
      NULL,
      &topaz11,
      5,
      NULL,
      NULL,NULL
   };
   struct NewGadget check = {
      11,54,
      26,11,
      "Display non-ship unit construction?",
      &topaz11,
      8,
      PLACETEXT_RIGHT,
      NULL,NULL
   };
   struct NewGadget rollo = {
      11,96, // leftedge, topedge
      130,14, // width, height
      "Sound Effects",     // text label
      &topaz11,   // font
      2,          // gadget ID
      PLACETEXT_RIGHT,
      NULL,NULL      // visual info, user data
   };

   int new_msg_delay=PLAYER.msg_delay, new_battle_delay=PLAYER.battle_delay;
   int new_snd_vol=PLAYER.snd_vol;
   enum SoundFX new_soundfx=PLAYER.soundfx;

   // make sure he can't turn on the sound if the sound channels
   // weren't successfully opened!
   //if (device_open==FALSE) {
   //   new_soundfx = SOUND_NONE;
   //   new_snd_vol = 0;
   //}

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   button.ng_TopEdge = ht-24;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);
   button.ng_LeftEdge += 250;
   button.ng_TextAttr = &topaz11;
   button.ng_GadgetText = "Cancel";
   cancel_gad = CreateGadget(BUTTON_KIND,okay_gad,&button,TAG_END);
   
   // create the slider gadgets
   slider.ng_VisualInfo = vi;
   btl_delay_slide = CreateGadget(SLIDER_KIND,cancel_gad,&slider,
      GTSL_Min,   1,
      GTSL_Max,   100,
      GTSL_Level, new_battle_delay,
      GA_RelVerify, TRUE,
      TAG_END);
   slider.ng_LeftEdge = 266;
   msg_delay_slide = CreateGadget(SLIDER_KIND,btl_delay_slide,&slider,
      GTSL_Min,   1,
      GTSL_Max,   100,
      GTSL_Level, new_msg_delay,
      GA_RelVerify, TRUE,
      TAG_END);
   slider.ng_TopEdge = 96;
   snd_vol_slide = CreateGadget(SLIDER_KIND,msg_delay_slide,&slider,
      GTSL_Min,   0,
      GTSL_Max,   64,
      GTSL_Level, new_snd_vol,
      GA_Disabled,  FALSE,
      GA_RelVerify, TRUE,
      TAG_END);

   // create the checkmark gadgets
   check.ng_VisualInfo = vi;
   autodsp_check = CreateGadget(CHECKBOX_KIND,snd_vol_slide,&check,
      GT_Underscore, '_',
      GTCB_Checked, PLAYER.show_production,
      TAG_END);
   check.ng_TopEdge += 20;
   check.ng_GadgetText = "Automatic combat reports?";
   autorpt_check = CreateGadget(CHECKBOX_KIND,autodsp_check,&check,
      GT_Underscore, '_',
      GTCB_Checked, PLAYER.autorpt,
      TAG_END);

   // create the rollo gadget
   {
      static char *soundfx_strings[] = {"All","Battle Only","None",NULL };
      rollo.ng_VisualInfo = vi;
      soundfx_rollo = CreateGadget(CYCLE_KIND,autorpt_check,&rollo,
         GTCY_Labels, soundfx_strings,
         GTCY_Active, (int)new_soundfx,
         GA_Disabled,  FALSE,
         TAG_END );
   }

   left_edge = (map_screen->Width-wd)/2;
   top_edge = (map_screen->Height-ht)/2;

   prefs_window = OpenWindowTags(NULL,
      WA_Gadgets,       context,
      WA_Title,         "Player Preferences",
      WA_CustomScreen,  map_screen,
      WA_Top,           top_edge,
      WA_Left,          left_edge,
      WA_Height,        ht,
      WA_Width,         wd,
      WA_IDCMP,         IDCMP_GADGETUP|IDCMP_VANILLAKEY,
      WA_Flags,         WFLG_SMART_REFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
      TAG_END );
   if (prefs_window==NULL)
      clean_exit(1,"ERROR: Unable to open player prefs window!");
   GT_RefreshWindow(prefs_window,NULL);
   rast_port = prefs_window->RPort;

   plot_text(11,21,"Battle Delay",BLACK,LT_GRAY,JAM2,&topaz11);
   plot_text(266,21,"Message Delay",BLACK,LT_GRAY,JAM2,&topaz11);
   plot_text(266,84,"Sound Volume",BLACK,LT_GRAY,JAM2,&topaz11);

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(prefs_window->UserPort);
         while (message = GT_GetIMsg(prefs_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               if (code==13) {
                  // show the button depressed
                  show_depress(okay_gad,prefs_window->RPort);
                  Delay(10L);
                  goto exit_prefs_window;
               FI
            FI
            if (class==IDCMP_GADGETUP) {
               if (object==okay_gad)
                  goto exit_prefs_window;
               if (object==cancel_gad) {
                  cancel = TRUE;
                  goto exit_prefs_window;
               FI
               if (object==btl_delay_slide)
                  new_battle_delay = code;
               if (object==msg_delay_slide)
                  new_msg_delay = code;
               if (object==snd_vol_slide)
                  new_snd_vol = code;
               if (object==soundfx_rollo)
                  new_soundfx = (enum SoundFX)code;
            FI
         OD
      OD
   }

 exit_prefs_window:
   // if the user didn't cancel, copy all the new values
   if (cancel==FALSE) {
      PLAYER.msg_delay        = new_msg_delay;
      PLAYER.battle_delay     = new_battle_delay;
      PLAYER.soundfx          = new_soundfx;
      PLAYER.snd_vol          = new_snd_vol;
      PLAYER.autorpt          = (autorpt_check->Flags & GFLG_SELECTED)!=NULL;
      PLAYER.show_production  = (autodsp_check->Flags & GFLG_SELECTED)!=NULL;
   FI

   // now close up everything with the prefs_window
   CloseWindow(prefs_window);
   FreeGadgets(context);

   // reset everything for map window
   rast_port = map_window->RPort;
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}


/*
   prop_delay() creates a delay for messages which is proportional based
   on the current player's pref settings and the type of message (battle
   or other) using a provided base value (length)
*/

void prop_delay(length,player,bflag)
int length, player;
BOOL bflag;
{
   long final;

   if (bflag)
      final = length*PLAYER.battle_delay/50;
   else
      final = length*PLAYER.msg_delay/50;
   Delay(final);
}


/*
   tell the user about some event with an optional sound effect and
   a delay controlled by battle_flag
*/

void tell_user(text,battle_flag,sound)
char *text;
BOOL battle_flag;
int sound;
{
   SetWindowTitles(map_window,text,(UBYTE *)~0);
//   if( (PLAYER.soundfx == SOUND_ALL) && (sound>=0) )
//      playSound(sound,PLAYER.snd_vol);
   prop_delay(100,player,battle_flag);
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
}

void tell_user2(text,battle_flag,sound)
char *text;
BOOL battle_flag;
int sound;
{
   SetWindowTitles(map_window,text,(UBYTE *)~0);
   if( (PLAYER.soundfx == SOUND_ALL) )
      playSound(sound,PLAYER.snd_vol);
   prop_delay(100,player,battle_flag);
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
}

/*
   show_battle() displays an individual battle action to the player with
   graphics and sound -- the battle information is found in my usual "battle"
   data structure -- no checking is done to determine whether this battle
   should be visible to the current player, so don't call it unless you
   already know
*/
void show_battle()
{
   int xa=battle.att_x, ya=battle.att_y;  // for brevity
   int xd=battle.def_x, yd=battle.def_y;
   int ctr, def_color;
   ULONG mask;
   char tbar[80];

   // show the individual battle to the player
   unsigned int num_blows, bit_blows;

   // store the window title for later
   strncpy(tbar,win_title,79L);

   // get the map to the right part of the display
   if (!display) {
      create_player_display(xd,yd);
   } else if (need_to_scrollP(xd,yd)) {
      int ox=xoffs, oy=yoffs;

      set_display_offsets(xd,yd);
      GP_smart_scroll(ox,oy);
   FI

   // save the background of both hexes (attacker & defender)
   save_hex_graphics(xa,ya,1);   // buffer 1 for attacker
   save_hex_graphics(xd,yd,2);  // buffer 2 for defender

   // redraw the hex background terrain just to make sure there are no
   // "edges" of other icons protruding where they shouldn't be -- only
   // the combatants should be visible
   plot_hex(xa,ya,get(t_grid,xa,ya));
   if (get_flags(t_grid,xa,ya)&ROAD)
      GP_draw_roads(xa,ya);
   plot_hex(xd,yd,get(t_grid,xd,yd));
   if (get_flags(t_grid,xd,yd)&ROAD)
      GP_draw_roads(xd,yd);


   /*
      If the defending unit is a militia, it's shown in white,
      no matter who it actually belongs to.
   */
   def_color = roster[battle.def_owner].color;
   if (battle.white_icon)
      def_color=WHITE;

   // draw the attacker and defender into their positions
   // for now I'll just draw right over whatever was there before
   plot_icon(battle.att_type,xa,ya,
      roster[battle.att_owner].color,0L,FALSE);
   plot_icon(battle.def_type,xd,yd,
      def_color,0L,FALSE);

   // set the title bar to explain what's happening
   if (battle.def_owner==player)
      sprintf(win_title,"%s's %s attacking your %s!",
         roster[battle.att_owner].name,
         wishbook[battle.att_type].name,
         wishbook[battle.def_type].name);
   else if (city_hereP(xd,yd))
      sprintf(win_title,"%s's %s attacking %s!",
         roster[battle.att_owner].name,
         wishbook[battle.att_type].name,
         city_hereP(xd,yd)->name);
   else
      sprintf(win_title,"%s's %s attacking %s's %s!",
         roster[battle.att_owner].name,
         wishbook[battle.att_type].name,
         roster[battle.def_owner].name,
         wishbook[battle.def_type].name);
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);

   prop_delay(45,player,TRUE);

   // draw the explosions for trading blows
   num_blows = (0xFF000000 & battle.blows)>>24;
   bit_blows = (0x00FFFFFF & battle.blows);
   mask = 1L<<(num_blows-1);
   for (ctr=0; ctr<num_blows; ctr++) {
      int target = bit_blows & mask;
      prop_delay(20,player,TRUE);
      mask >>= 1;    // move mask to next bit
      if (target!=0) { // attacker landed a blow on defender
         // draw explosion onto defender hex
         plot_mapobject(xd,yd,154,30);
         // wait time delay
         context_sound(BOOM_SOUND);
         prop_delay(35,player,TRUE);
         // erase explosion (i.e. redraw defender)
         plot_icon(battle.def_type,xd,yd,
            def_color,0L,FALSE);
      } else {
         // draw explosion onto attacker hex
         plot_mapobject(xa,ya,154,30);
         // wait time delay
         context_sound(BOOM_SOUND);
         prop_delay(35,player,TRUE);
         // erase explosion (i.e. redraw attacker)
         plot_icon(battle.att_type,xa,ya,
            roster[battle.att_owner].color,0L,FALSE);
      FI
   OD
   // play an appropriate sound effect
   if (battle.winner==player)
      context_sound(YEAH_SOUND);
   else
      context_sound(DIE_SOUND);

   if (battle.winner==battle.att_owner && battle.bombardment==FALSE) {
      struct Unit flarp;

      flarp.owner = battle.att_owner;
      flarp.type = battle.att_type;
      anim_move(&flarp,xa,ya,xd,yd);
      GP_update_at_hex(xd,yd);
   } else
      Delay(15L);

   // restore the original graphics for this hex
   restore_hex_graphics(xa,ya,1);
   restore_hex_graphics(xd,yd,2);
   strcpy(win_title,tbar);  // restore window title to former value
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
}


void show_combat_report(avto)
BOOL avto;
{  // show the current player his combat report
   BPTR infile;
   ULONG length;
   int ctr, incidence=0;
   char tbar[80];

   strcpy(foo,prefix);
   strcat(foo,id_filetag);
   strcat(foo,".CR");
   if ((length=FLength(foo))<=0)
      goto no_report;
   if (length>=sizeof(battle))
      infile = Open(foo,MODE_OLDFILE);
   if (!infile)
      return;  // add error alert here later
   strncpy(tbar,win_title,79L);  // store the window title for later
   for (ctr=0; ctr<(length/sizeof(battle)); ctr++) {
      Read(infile,&battle,sizeof(battle));
      if (battle.seen_by & mask(player)) {
         show_battle();
         incidence++;
      FI
   OD
   Close(infile);
   strcpy(win_title,tbar);  // restore window title to former value
   SetWindowTitles(map_window,win_title,(UBYTE *)~0);
 no_report:
   // we never throw this requester if the report is done avtomatically
   if (incidence==0 && avto==FALSE)
      (void)rtEZRequestTags("There are no battles to report!","Okay",
         NULL,NULL,
         RT_Window,        map_window,
         RT_ReqPos,        REQPOS_CENTERSCR,
         RT_LockWindow,    TRUE,
         RT_ShareIDCMP,    TRUE,
         RTEZ_Flags,       EZREQF_CENTERTEXT,
         TAG_END);
}


// display a global world view of the terrain

void ME_world_view()
{
   int x, y;    // loop counters
   int fatness = 6;   // fat pixel size
   int wv_height, wv_width, wv_left, wv_top;
   struct Window *wv_window;

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // pixelly math to size and center the window
   while (TRUE) {
      wv_height = height*fatness+16;
      wv_width = width*fatness+fatness/2+8;
      if (wv_height>map_screen->Height || wv_width>map_screen->Width)
         fatness -= 2;
      else
         break;
   }
   wv_left = (map_screen->Width-wv_width)/2;
   wv_top = (map_screen->Height-wv_height)/2;

   wv_window = OpenWindowTags(NULL,
      WA_CustomScreen, map_screen,
      WA_Width,   wv_width,
      WA_Height,  wv_height,
      WA_Left,    wv_left,
      WA_Top,     wv_top,
      WA_Title, "World View",
      WA_IDCMP, IDCMP_CLOSEWINDOW,
      WA_Flags, WFLG_ACTIVATE|NOCAREREFRESH|WFLG_CLOSEGADGET|WFLG_DRAGBAR,
      TAG_END);
   if (wv_window==NULL) {
      DisplayBeep(NULL);
      ClearPointer(map_window);
      ModifyIDCMP(map_window,IDCMP_MAPEDIT);
      return;
   FI
   rast_port = wv_window->RPort;

   for (y = 0; y<height; y++) {
      int indent = (y%2)*(fatness/2);
      for (x = 0; x<width; x++) {
         int terra = get(t_grid,x,y);
         int color;

         // here I translate my hexes to the appropriate colors
         switch (terra) {
            case HEX_PLAINS:
            case HEX_BRUSH:
               color = LT_GREEN;
               break;
            case HEX_FOREST:
               color = GREEN;
               break;
            case HEX_JUNGLE:
               color = DK_GREEN;
               break;
            case HEX_SWAMP:
               color = PURPLE;
               break;
            case HEX_ICE:
               color = WHITE;
               break;
            case HEX_DESERT:
               color = TAN;
               break;
            case HEX_RUGGED:
               color = BROWN;
               break;
            case HEX_HILLS:
               color = GRAY;
               break;
            case HEX_MOUNTAINS:
               color = DK_GRAY;
               break;
            case HEX_PEAKS:
            case HEX_FORBID:
               color = BLACK;
               break;
            case HEX_SHALLOWS:
               color = LT_BLUE;
               break;
            case HEX_OCEAN:
               color = BLUE;
               break;
            case HEX_DEPTH:
               color = DK_BLUE;
               break;
         }
         SetAPen(wv_window->RPort,color);
         fat_plot(wv_window->RPort,x*fatness+indent+4,y*fatness+14,fatness);
      OD
   OD

   // display the cities
   {
      struct City *metro = (struct City *)city_list.mlh_Head;
      SetAPen(wv_window->RPort,ORANGE);
      for ( ; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ) {
         int col = metro->col, row = metro->row;
         int indent = (row%2)*(fatness/2);
         fat_plot(wv_window->RPort,col*fatness+indent+5,row*fatness+15,fatness-2);
      OD
   }

   // draw the frame showing the current main window position
   {
      int x, y, w, h;

      SetDrMd(rast_port,COMPLEMENT);
      x = xoffs*fatness+5;
      w = disp_wd*fatness;
      y = yoffs*fatness+14;
      h = disp_ht*fatness;
      box(x,y,w,h,BLACK);
   }

   {  // wait for the close window message
      struct IntuiMessage *message; // the message the IDCMP sends us
      ULONG class;

      while (TRUE) {
         WaitPort(wv_window->UserPort);
         while (message = GT_GetIMsg(wv_window->UserPort)) {
            class = message->Class;
            GT_ReplyIMsg(message);
            if (class==IDCMP_CLOSEWINDOW)
               goto exit_worldview;
         OD
      OD
   }
 exit_worldview:
   rast_port = map_window->RPort;
   CloseWindow(wv_window);
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_MAPEDIT);
}


void GP_world_view()
{
   int x, y;    // loop counters
   int fatness = 6;   // fat pixel size
   int wv_height, wv_width, wv_left, wv_top;
   struct Window *wv_window;

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // pixelly math to size and center the window
   while (TRUE) {
      wv_height = height*fatness+16;
      wv_width = width*fatness+fatness/2+8;
      if (wv_height>map_screen->Height || wv_width>map_screen->Width)
         fatness -= 2;
      else
         break;
   }
   wv_left = (map_screen->Width-wv_width)/2;
   wv_top = (map_screen->Height-wv_height)/2;

   wv_window = OpenWindowTags(NULL,
      WA_CustomScreen, map_screen,
      WA_Width,   wv_width,
      WA_Height,  wv_height,
      WA_Left,    wv_left,
      WA_Top,     wv_top,
      WA_Title,   "World View",
      WA_IDCMP,   IDCMP_CLOSEWINDOW,
      WA_Flags,   WFLG_ACTIVATE|NOCAREREFRESH|WFLG_CLOSEGADGET|WFLG_DRAGBAR,
      TAG_END);
   if (wv_window==NULL) {
      DisplayBeep(NULL);
      ClearPointer(map_window);
      ModifyIDCMP(map_window,IDCMP_MAPEDIT);
      return;
   FI
   rast_port = wv_window->RPort;

   for (y = 0; y<height; y++) {
      int indent = (y%2)*(fatness/2);
      for (x = 0; x<width; x++) {
         int terra = get(PLAYER.map,x,y);
         int color;

         // Here I translate my hexes to the appropriate colors.
         // I must use as few colors as possible, so I will have some
         // left for the units.  In practice, that means one color for
         // water and another for land.
         color = BLACK;
         switch (terra) {
            case HEX_PLAINS:
            case HEX_BRUSH:
            case HEX_FOREST:
            case HEX_JUNGLE:
            case HEX_SWAMP:
            case HEX_ICE:
            case HEX_DESERT:
            case HEX_RUGGED:
            case HEX_HILLS:
            case HEX_MOUNTAINS:
               color = DK_GREEN;
               break;
            case HEX_UNEXPLORED:
               color = DK_GRAY;
               break;
            case HEX_PEAKS:
            case HEX_FORBID:
               color = BLACK;
               break;
            case HEX_SHALLOWS:
            case HEX_OCEAN:
            case HEX_DEPTH:
               color = DK_BLUE;
         }
         SetAPen(wv_window->RPort,color);
         fat_plot(wv_window->RPort,x*fatness+indent+4,y*fatness+14,fatness);
      OD
   OD

   // display the icons
   {
      struct MapIcon *piece=(struct MapIcon *)PLAYER.icons.mlh_Head;

      for (; piece->inode.mln_Succ; piece=(struct MapIcon *)piece->inode.mln_Succ) {
         int col=piece->col, row=piece->row;
         int indent = (row%2)*(fatness/2);
         SetAPen(wv_window->RPort,roster[piece->owner].color);
         fat_plot(wv_window->RPort,col*fatness+indent+5,row*fatness+15,fatness-2);
      OD
   }

   // draw the frame showing the current main window position
   {
      int x, y, w, h;

      SetDrMd(rast_port,COMPLEMENT);
      x = xoffs*fatness+5;
      w = disp_wd*fatness;
      y = yoffs*fatness+14;
      h = disp_ht*fatness;
      box(x,y,w,h,BLACK);
   }

   {  // wait for the close window message
      struct IntuiMessage *message; // the message the IDCMP sends us
      ULONG class;

      while (TRUE) {
         WaitPort(wv_window->UserPort);
         while (message = GT_GetIMsg(wv_window->UserPort)) {
            class = message->Class;
            GT_ReplyIMsg(message);
            if (class==IDCMP_CLOSEWINDOW)
               goto exit_worldview;
         OD
      OD
   }
 exit_worldview:
   rast_port = map_window->RPort;
   CloseWindow(wv_window);
   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}


/*
   sector_survey() is where I give the player everything he could possibly
   want to know about a given hex on his map; this likely means that he was
   in survey mode and asked for hex info, but could possibly come up under
   other conditions as well
*/

void sector_survey(col,row)
int col, row;
{
   struct Window *ss_window;
   int ss_height, ss_width, ss_left, ss_top;
   int terrain_type;
   struct MapIcon *city_icon=NULL;

   struct Gadget *context, *cont_gad, *city_gad, *units_gad;
   struct NewGadget button = {
      22,129,  // leftedge, topedge
      85,14,   // width, height
      "Continue",  // text label
      NULL,    // font
      1,       // gadget ID
      NULL,NULL,NULL
   };

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

// TLB v0.13
   // do this so the user can see which city he is looking at
   save_hex_graphics(col,row,0);    // blit the background to a safe place
   plot_mapobject(col,row,MAP_MARKER);


// TLB v0.13
   // new pixelly math to size and position the window
   // it should be near, but not on top of, the specified hex
   {
      int mx, my;
      log_to_abs(col,row,&mx,&my);

      ss_height = 149;
      ss_width = 387;
//      ss_left = (map_screen->Width-ss_width)/2;
      ss_left = mx-10;
      if (row-yoffs<(disp_ht/2))
         ss_top = (my+46);
      else
         ss_top = (my-ss_height);

//      ss_top = (map_screen->Height-ss_height)/2;
   }

   // create gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   cont_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);
   button.ng_LeftEdge = 115;
   button.ng_Width = 134;
   button.ng_GadgetText = "City Production";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   {
      BOOL disabled=TRUE;
      struct City *nerble=city_hereP(col,row);

      if (nerble)
         if (nerble->owner==player)
            disabled = FALSE;
      city_gad = CreateGadget(BUTTON_KIND,cont_gad,&button,
         GA_Disabled, disabled, TAG_END);
   }
   button.ng_LeftEdge = 256;
   button.ng_Width = 105;
   button.ng_GadgetText = "Unit Survey";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   units_gad = CreateGadget(BUTTON_KIND,city_gad,&button,
      GA_Disabled, FALSE, TAG_END);

   ss_window = OpenWindowTags(NULL,
      WA_CustomScreen, map_screen,
      WA_Width,   ss_width,
      WA_Height,  ss_height,
      WA_Left,    ss_left,
      WA_Top,     ss_top,
      WA_Title,   "Sector Survey",
      WA_Gadgets, context,
      WA_IDCMP,   IDCMP_GADGETUP,
      WA_Flags,   WFLG_ACTIVATE|NOCAREREFRESH|WFLG_DRAGBAR,
      TAG_END);
   if (ss_window==NULL) {
      DisplayBeep(NULL);
      ClearPointer(map_window);
      ModifyIDCMP(map_window,IDCMP_PLAYGAME);
      return;
   FI
   rast_port = ss_window->RPort;

   // Here's where all the info rendering will happen.
   bevel_box(9,61,368,3,FALSE);
   bevel_box(9,122,368,3,FALSE);
   terrain_type = get(PLAYER.map,col,row);
   SetAPen(rast_port,BLACK);
   px_outline_hex(9,22);
   px_plot_hex(9,22,terrain_type);
   plot_text(48,23,terrain_name_table[terrain_type],
      BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"ROW %ld",row);
   plot_text(168,23,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"COLUMN %ld",col);
   plot_text(168,35,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   // Figure out who apparently controls the specified hex,
   // based on information from the map of the current player
   {
      struct MapIcon *icon;
      int controller = 0;
      for (icon=(struct MapIcon *)PLAYER.icons.mlh_Head; icon->inode.mln_Succ; icon=(struct MapIcon *)icon->inode.mln_Succ)
         if (icon->col==col && icon->row==row) {
            controller = icon->owner;
            if (icon->type==CITY)
               city_icon = icon;
         FI
      if (controller!=0 && terrain_type!=HEX_UNEXPLORED) {
         sprintf(foo,"Controlled by: %s",roster[controller].name);
         outline_text(48,47,foo,roster[controller].color,&topaz11);
      } else {
         if (controller==0)
            if (city_hereP(col,row))
               strcpy(foo,"Controlled by: NEUTRAL");
            else
               strcpy(foo,"Controlled by: NONE");
         if (terrain_type==HEX_UNEXPLORED)
            strcpy(foo,"Controlled by: UNKNOWN");
         plot_text(48,47,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      FI
   }
   // if there is a known city here, we do more info
   if (city_icon) {
      struct City *metro=city_hereP(col,row);
      // plot the icon picture of the city
      px_plot_city_complete(15,72,roster[city_icon->owner].color,FALSE);
      plot_text(48,70,metro->name,BLACK,LT_GRAY,JAM2,&topaz11);
      if (metro->owner==player) {
         px_plot_icon(metro->unit_type,14,98,roster[city_icon->owner].color,0,FALSE);
         sprintf(foo,"Producing %s",wishbook[metro->unit_type].name);
         plot_text(48,103,foo,BLACK,LT_GRAY,JAM2,&topaz11);
      } else {
         if (metro->recon[player]!=CITY) {
            px_plot_icon(metro->recon[player],14,98,roster[city_icon->owner].color,0,FALSE);
            sprintf(foo,"Producing %s",wishbook[metro->recon[player]].name);
            plot_text(48,103,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         } else {
            bevel_box(14,98,20,16,FALSE);
            plot_text(48,103,"Production Unknown",BLACK,LT_GRAY,JAM2,&topaz11);
         FI
      FI
   FI

   // Here is the familiar user input loop...
   {
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(ss_window->UserPort);
         while (message = GT_GetIMsg(ss_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_GADGETUP) {
               if (object==cont_gad)
                  goto exit_sector_survey;
               if (object==units_gad) {
                  unit_survey(col,row);
                  break;
               FI
               if (object==city_gad) {
                  struct City *nerble=city_hereP(col,row);
                  if (nerble)
                     if (nerble->owner==player) {
                        // first disable the window
                        SetPointer(ss_window,BUSY_POINTER);
                        ModifyIDCMP(ss_window,NULL);
                        examine_city(nerble);
                        // then re-enable the windows
                        ClearPointer(ss_window);
                        ModifyIDCMP(ss_window,IDCMP_GADGETUP);
                     FI
               FI
            FI
         OD
      OD
   }

 exit_sector_survey:
   rast_port = map_window->RPort;
   CloseWindow(ss_window);
   FreeGadgets(context);

// TLB v0.13
   // clear the sector marker from the map display
   restore_hex_graphics(col,row,0);

   ClearPointer(map_window);
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);
}


/*
   unit_survey() is supposed to provide a survey of the units currently in a
   given hex sector.  This is supposedly called when the user has asked for
   the info on a hex he controls, but the same techniques could be applied
   to generate other kinds of reports.  Our goal is to create a temporary
   text file and then call MultiView to display it.
*/

void unit_survey(col,row)
int col, row;
{
   struct Unit *unit=(struct Unit *)unit_list.mlh_Head;
   char *filepath="t:unit_report.txt";
   char foo[128], bar[40];
   BPTR outfile;

   /* open the temporary file */
   outfile = Open(filepath,MODE_NEWFILE);
   if (outfile==NULL) return;

   for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
      if (unit->col==col && unit->row==row) {
         sprintf(foo,"%s \"%s\"",wishbook[unit->type].name,unit->name);
         if (unit->cargo>0) {
            /* I have to generate a string showing what kind of cargo is on board. */
            struct Unit *cargo=(struct Unit *)unit_list.mlh_Head;
            int fi=0, in=0, ar=0, bo=0;
            BOOL comma=FALSE;
            for (; cargo->unode.mln_Succ; cargo=(struct Unit *)cargo->unode.mln_Succ)
               if (cargo->ship==unit)
                  switch (cargo->type) {
                     case FIGHTER:
                        fi++;
                        break;
                     case BOMBER:
                        bo++;
                        break;
                     case RIFLE:
                        in++;
                        break;
                     case ARMOR:
                        ar++;
                  }
            strcat(foo,"[");
            if (fi) {
               sprintf(bar,"%ld FI");
               strcat(foo,bar);
               comma = TRUE;
            }
            if (bo) {
               if (comma)
                  strcat(foo,",");
               sprintf(bar,"%ld BO");
               strcat(foo,bar);
               comma = TRUE;
            }
            if (in) {
               if (comma)
                  strcat(foo,",");
               sprintf(bar,"%ld IN");
               strcat(foo,bar);
               comma = TRUE;
            }
            if (ar) {
               if (comma)
                  strcat(foo,",");
               sprintf(bar,"%ld AR");
               strcat(foo,bar);
            }
            strcat(foo,"]");
         }
         strcat(foo,", ");
         if (wishbook[unit->type].hitpoints>1) {
            sprintf(bar,"Hits: %ld/%ld, ",unit->damage,wishbook[unit->type].hitpoints);
            strcat(foo,bar);
         }
         if (wishbook[unit->type].range>0)
            sprintf(bar,"Rng: %ld/%ld, ",unit->move/60,unit->fuel);
         else
            sprintf(bar,"Rng: %ld, ",(unit->move+20)/60);
         strcat(foo,bar);
         strcat(foo,"Ord: \n");

         Write(outfile,foo,(long)strlen(foo));
      }
   Close(outfile);
}


// end of listing
