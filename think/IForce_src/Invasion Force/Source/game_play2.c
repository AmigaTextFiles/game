/*
   game_play2.c -- game play module for Empire II

   This module handles game play: loading and saving games, getting orders
   from the user, moving units, handling combat, and presenting various
   menus for branching to the status reports, message system, etc.

   This source code is free.  You may make as many copies as you like.
*/

#include "global.h"
#include <proto/layers.h>

#define CLEAR_WINDOW() SetRast(rast_port,0);zero_scrollers();display=0;

#define EXIT_GAME 1     // kluge values for flow control
#define GAME_OVER 2
#define UNIT_DONE 3     // I mainly use these to break out of nested functions
#define UNIT_LOST 4
#define GO_SURVEY 5
#define EXIT_SURVEY   6
#define GO_MOVEMENT   7
#define END_TURN      8
#define GAME_RESTORED 9
#define GO_PRODUCTION 10
#define CE_RESTART -17

#define INVISIBLE 0
#define VISIBLE 1       // flag values, purely for more readable code



void survey_mode(current_unit)
struct Unit **current_unit;
{
   /*
      This is similar in many respects to movement_mode()
      As we enter this function, the global values cursx and cursy should
      already have been set, indicating the current cursor location.
      However, if cursx,cursy is not visible, it is permissible to reset
      the cursor to someplace on the screen rather than scroll to it.
   */
   struct IntuiMessage *message; // the message the IDCMP sends us
   unsigned int ticks = 1;
   BOOL blink_on = TRUE;

   // useful for interpreting IDCMP messages
   UWORD code;
   ULONG class;
   APTR object;

   if (display==FALSE) {
      set_display_offsets(cursx,cursy);
      GP_draw_map();
   } else if (need_to_scrollP(cursx,cursy)) {
      /*
      int ox=xoffs, oy=yoffs;

      set_display_offsets(cursx,cursy);
      GP_smart_scroll(ox,oy);
      */
      cursx = xoffs+disp_wd/2;
      cursy = yoffs+disp_ht/2;
   FI

   save_hex_graphics(cursx,cursy,0);
   hex_status_bar(cursx,cursy);

   // activate IDCMP event input
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);

   // attach the menu to my window
   SetMenuStrip(map_window,vey_menu_strip);

   // enable menus
   OnMenu(map_window,FULLMENUNUM(0,-1,0));
   OnMenu(map_window,FULLMENUNUM(1,-1,0));
   OnMenu(map_window,FULLMENUNUM(2,-1,0));
   OnMenu(map_window,FULLMENUNUM(3,-1,0));
   OnMenu(map_window,FULLMENUNUM(4,-1,0));

   control_flag = 0;    // flag lets me know when player is done

   /*
      This is another important user input loop where
      I let the user scroll around, look at units, cities,
      select various options from the drop-down menus, etc.
   */

   while (TRUE) {
      WaitPort(map_window->UserPort);
      while (message = GT_GetIMsg(map_window->UserPort)) {
         ClearMenuStrip(map_window);
         code = message->Code;  // MENUNUM
         object = message->IAddress;  // Gadget
         class = message->Class;
         GT_ReplyIMsg(message);
         if ( class == MENUPICK ) { // MenuItems
            switch (MENUNUM(code)) {
               case 0:  // Project menu
                  switch (ITEMNUM(code)) {
                     case 0:  // save game
                        {
                           char pan[216];
                           build_pan(pan,game_filepath,game_filename);
                           save_game(pan);
                        }
                        break;
                     case 1:  // save as...
                        (void)rt_loadsave_game(TRUE);
                        break;
                     case 3:  // exit game
                        if (alert(map_window,"Exit this game.","Are you sure you want to abandon this game now?","Exit|Cancel")) {
                           control_flag = EXIT_GAME;
                           goto exit_surveymode;
                        FI
                        break;
                     case 4:  // quit program
                        if (alert(map_window,"Exit Invasion Force.","You have a game in progress.\nAre you sure you want to leave Invasion Force now?","Exit|Cancel"))
                           clean_exit(0,NULL);
                        break;
                     default:
                        class = IDCMP_VANILLAKEY;
                        code = 200;
                  };
                  break;
               case 1:  // Reports menu
                  switch (ITEMNUM(code)) {
                     case 0:  // World Map
                        GP_world_view();
                        break;
                     case 1:  // Status report
                        status_report(player);
                        break;
                     case 2:  // Combat Report
                        show_combat_report(FALSE);
                        break;
                     case 3:  // Hex Info
                        class = IDCMP_VANILLAKEY;
                        code = '\r';
                        break;
                     case 4:  // Production Map
                        control_flag = GO_PRODUCTION;
                        goto exit_surveymode;
                        break;
                     default:
                        class = IDCMP_VANILLAKEY;
                        code = 200;
                  }
                  break;
               case 2:  // Orders menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Clear Orders
                        class = IDCMP_VANILLAKEY;
                        code = 'o';
                        break;
                     case 1:  // Cycle Stack
                        class = IDCMP_VANILLAKEY;
                        code = '5';
                        break;
                     case 2:  // Activate
                        class = IDCMP_VANILLAKEY;
                        code = 'a';
                        break;
                     default:
                        class = IDCMP_VANILLAKEY;
                        code = 200;
                  }
                  break;
               case 3:  // Commands menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Move Mode
                        class = IDCMP_VANILLAKEY;
                        code = 'm';
                        break;
                     case 3:  // Center Screen
                        class = IDCMP_VANILLAKEY;
                        code = 'c';
                        break;
                     default:
                        class = IDCMP_VANILLAKEY;
                        code = 200;
                  }
                  break;
               case 4:  // Other menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Prefs
                        player_preferences();
                        break;
                     default:
                        code = 200;
                        class = IDCMP_VANILLAKEY;
                  }
            }  // end of drop-down menus
         FI
         // following are key commands available in survey mode
         if (class==IDCMP_VANILLAKEY) {
            switch (code) {
               int direction;
               case 'q':
                  // Magic Q function - change the level of AI displays
                  ToggleAIDataFlag();
                  break;
               case '\r':
               case ' ':
                  if (blink_on) {   // remove the cursor if it's visible
                     blink_on=FALSE;
                     restore_hex_graphics(cursx,cursy,0);
                  FI
                  // survey_hex(cursx,cursy);
                  sector_survey(cursx,cursy);

                  break;
               case 'a':   // activate unit at this location
                  {
                     struct Unit *unit=(struct Unit *)unit_list.mlh_Head;

                     for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
                        if (unit->col==cursx && unit->row==cursy && unit->owner==player)
                           if (Bool(unit_readiness(unit)&UNIT_READY) && unit->ship==NULL) {
                              clear_orders(unit);
                              *current_unit = unit;
                              control_flag = EXIT_SURVEY;
                              break;
                           FI
                  }
                  break;
               case 'c':
                  {  // center the display on the current hex cell
                     int ox = xoffs, oy = yoffs;

                     restore_hex_graphics(cursx,cursy,0);
                     set_display_offsets(cursx,cursy);
                     GP_smart_scroll(ox,oy);
                     if (blink_on)
                        plot_cursor(cursx,cursy);
                  }
                  break;
               case 'm':   // to movement mode
                  control_flag = EXIT_SURVEY;
                  break;
               case 'o':   // clear orders
                  {  // go down the list of units for ones in this hex
                     struct Unit *unit=(struct Unit *)unit_list.mlh_Head;

                     for (;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
                        if (unit->col==cursx && unit->row==cursy && unit->owner==player)
                           clear_orders(unit);
                     /*** TLB ***/
                     // update both the hex display and the window title
                     blink_on=FALSE;
                     explore_hex(player,cursx,cursy,VISIBLE,TRUE);
                     save_hex_graphics(cursx,cursy,0);
                     hex_status_bar(cursx,cursy);

                   }
                 break;
               case '5':   // shuffle stack
                  {  // search for top unit in this hex
                     struct Unit *topunit=(struct Unit *)unit_list.mlh_Head, *newunit;

                     for (;topunit->unode.mln_Succ;topunit=(struct Unit *)topunit->unode.mln_Succ)
                        if (topunit->col==cursx && topunit->row==cursy && topunit->owner==player) {
                           newunit = shuffle_units(topunit,TRUE);
                           if (newunit!=topunit) {
                              // update display to match
                              explore_hex(player,cursx,cursy,VISIBLE,TRUE);
                              save_hex_graphics(cursx,cursy,0);
                              hex_status_bar(cursx,cursy);
                              break;
                           FI
                        FI
                     break;
                  }
               // following is a sort of movement table, translates
               // keypad numbers into movement directions
               case '6':
                  direction = EAST;
                  goto sm_moving;
               case '4':
                  direction = WEST;
                  goto sm_moving;
               case '7':
                  direction = NORTHWEST;
                  goto sm_moving;
               case '9':
                  direction = NORTHEAST;
                  goto sm_moving;
               case '1':
                  direction = SOUTHWEST;
                  goto sm_moving;
               case '3':
                  direction = SOUTHEAST;
               sm_moving:
                  restore_hex_graphics(cursx,cursy,0);
                  move_cursor_dir(direction);
                  if (need_to_scrollP(cursx,cursy)) {
                     int ox = xoffs, oy = yoffs;

                     set_display_offsets(cursx,cursy);
                     GP_smart_scroll(ox,oy);
                  FI
                  save_hex_graphics(cursx,cursy,0);
                  if (blink_on)
                     plot_cursor(cursx,cursy);
                  hex_status_bar(cursx,cursy);
                  break;
               case 200:
                  (void)rtEZRequestTags("That function is not yot implemented.","Drat!",NULL,NULL,
                     RT_DEFAULT,TAG_END);
                  break;
               default:
                  (void)rtEZRequestTags("That key has no defined function.\nPlease try one of the many other keys.",
                     "Okay",NULL,NULL,
                     RT_Window,        map_window,
                     RT_ReqPos,        REQPOS_CENTERSCR,
                     RT_LockWindow,    TRUE,
                     RTEZ_Flags,       EZREQF_CENTERTEXT,
                     TAG_DONE );
            } // end switch
         FI
         if (class==IDCMP_MOUSEBUTTONS && code==SELECTDOWN) {
            int x, y;

            abs_to_log(message->MouseX,message->MouseY,&x,&y);
            restore_hex_graphics(cursx,cursy,0);
            cursx = x;     cursy = y;
            if (need_to_scrollP(cursx,cursy)) {
               int ox = xoffs, oy = yoffs;

               set_display_offsets(cursx,cursy);
               GP_smart_scroll(ox,oy);
            FI
            hex_status_bar(cursx,cursy);
            save_hex_graphics(cursx,cursy,0);
            if (blink_on)
               plot_cursor(cursx,cursy);
         FI
         if (class==IDCMP_GADGETUP) {
            int ox = xoffs, oy = yoffs;

            restore_hex_graphics(cursx,cursy,0);
            if (scrolly(object,code)) {
               GP_smart_scroll(ox,oy);
            FI
            if (blink_on)
               plot_cursor(cursx,cursy);
         FI
         if (class == IDCMP_INTUITICKS)  // intuiticks control blinking
            if ((++ticks % 5) == 0) {
               blink_on = !blink_on;
               if (blink_on)
                  plot_cursor(cursx,cursy);
               else
                  restore_hex_graphics(cursx,cursy,0);
            FI
         ResetMenuStrip(map_window,vey_menu_strip);

         if (control_flag==EXIT_SURVEY) {
            restore_hex_graphics(cursx,cursy,0);
            goto exit_surveymode;
         FI
      OD
   OD
 exit_surveymode:
   // deactivate IDCMP event input
   ModifyIDCMP(map_window,NULL);

   // return to my "generic" title bar, so no outdated information is
   // seen when it shouldn't be -- especially by the next player!
   clear_movebar();
   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);
}


void production_mode()
{
   /*
      This is similar in many respects to survey_mode(), but much simpler.
      As we enter this function, the global values cursx and cursy should
      already have been set, indicating the current cursor location.
      However, if cursx,cursy is not visible, it is permissible to reset
      the cursor to someplace on the screen rather than scroll to it.
   */
   struct IntuiMessage *message; // the message the IDCMP sends us
   unsigned int ticks = 1;
   BOOL blink_on = TRUE;

   // useful for interpreting IDCMP messages
   UWORD code;
   ULONG class;
   APTR object;

   if (need_to_scrollP(cursx,cursy)) {
      cursx = xoffs+disp_wd/2;
      cursy = yoffs+disp_ht/2;
   FI
   PM_draw_map();

   save_hex_graphics(cursx,cursy,0);
   hex_status_bar(cursx,cursy);

   // activate IDCMP event input
   ModifyIDCMP(map_window,IDCMP_PLAYGAME);

   // attach the menu to my window
   SetMenuStrip(map_window,prod_menu_strip);

   // enable menu
   OnMenu(map_window,FULLMENUNUM(0,-1,0));
   OnMenu(map_window,FULLMENUNUM(1,-1,0));
   OnMenu(map_window,FULLMENUNUM(2,-1,0));
   OnMenu(map_window,FULLMENUNUM(3,-1,0));

   control_flag = 0;    // flag lets me know when player is done

   /*
      I let the user scroll around, look at cities, reset their
      production, and select the return to survey or movement mode.
   */
   while (TRUE) {
      WaitPort(map_window->UserPort);
      while (message = GT_GetIMsg(map_window->UserPort)) {
         ClearMenuStrip(map_window);
         code = message->Code;  // MENUNUM
         object = message->IAddress;  // Gadget
         class = message->Class;
         GT_ReplyIMsg(message);
         if (class==MENUPICK) { // MenuItems
            switch (MENUNUM(code)) {
               case 0:  // Project menu
                  switch (ITEMNUM(code)) {
                     case 0:  // save game
                        {
                           char pan[216];
                           build_pan(pan,game_filepath,game_filename);
                           save_game(pan);
                        }
                        break;
                     case 1:  // save as...
                        (void)rt_loadsave_game(TRUE);
                        break;
                     case 3:  // exit game
                        if (alert(map_window,"Exit this game.","Are you sure you want to abandon this game now?","Exit|Cancel")) {
                           control_flag = EXIT_GAME;
                           goto exit_productionmode;
                        FI
                        break;
                     case 4:  // quit program
                        if (alert(map_window,"Exit Invasion Force.","You have a game in progress.\nAre you sure you want to leave Invasion Force now?","Exit|Cancel"))
                           clean_exit(0,NULL);
                        break;
                     default:
                        code = 200;
                        class = IDCMP_VANILLAKEY;
                  };
                  break;
               case 1:  // Reports menu
                  switch (ITEMNUM(code)) {
                     case 0:  // World Map
                        GP_world_view();
                        break;
                     case 1:  // Status report
                        status_report(player);
                        break;
                     default:
                        code = 200;
                        class = IDCMP_VANILLAKEY;
                  }
                  break;
               case 2:  // Commands menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Examine City
                        code = '\r';
                        class = IDCMP_VANILLAKEY;
                        break;
                     case 1:  // Movement Mode
                        code = 'm';
                        class = IDCMP_VANILLAKEY;
                        break;
                     case 2:  // Survey Mode
                        code = 'v';
                        class = IDCMP_VANILLAKEY;
                        break;
                     case 3:  // Center Screen
                        code = 'c';
                        class = IDCMP_VANILLAKEY;
                        break;
                     default:
                        code = 200;
                        class = IDCMP_VANILLAKEY;
                  }
                  break;
               case 3:  // Other menu
                  switch (ITEMNUM(code)) {
                     case 0:  // Prefs
                        player_preferences();
                        break;
                     default:
                        code = 200;
                        class = IDCMP_VANILLAKEY;
                  }
            }  // end of drop-down menus
         FI
         // following are key commands available in survey mode
         if (class==IDCMP_VANILLAKEY) {
            switch (code) {
               struct City *metro;
               int direction;
               case '\r':
               case ' ':
                  if (metro = city_hereP(cursx,cursy)) {
                     if (metro->owner==player) {
                        if (blink_on) {   // remove the cursor if it's visible
                           blink_on=FALSE;
                           restore_hex_graphics(cursx,cursy,0);
                        FI
                        examine_city(metro);
                        PM_update_hex(metro->col,metro->row);
                        save_hex_graphics(metro->col,metro->row,0);
                     } else
                        (void)alert(map_window,"Information...","That city doesn't belong to you!","Cancel");
                  } else
                     playSound(DONK_SOUND,PLAYER.snd_vol);
                  break;
               case 'c':
                  {  // center the display on the current hex cell
                     int ox = xoffs, oy = yoffs;

                     restore_hex_graphics(cursx,cursy,0);
                     set_display_offsets(cursx,cursy);
                     PM_smart_scroll(ox,oy);
                     if (blink_on)
                        plot_cursor(cursx,cursy);
                  }
                  break;
               case 'm':   // to movement mode
                  control_flag = GO_MOVEMENT;
                  goto exit_productionmode;
               case 'v':   // to survey mode
                  control_flag = GO_SURVEY;
                  goto exit_productionmode;
               // following is a sort of movement table, translates
               // keypad numbers into movement directions
               case '6':
                  direction = EAST;
                  goto pm_moving;
               case '4':
                  direction = WEST;
                  goto pm_moving;
               case '7':
                  direction = NORTHWEST;
                  goto pm_moving;
               case '9':
                  direction = NORTHEAST;
                  goto pm_moving;
               case '1':
                  direction = SOUTHWEST;
                  goto pm_moving;
               case '3':
                  direction = SOUTHEAST;
               pm_moving:
                  restore_hex_graphics(cursx,cursy,0);
                  move_cursor_dir(direction);
                  if (need_to_scrollP(cursx,cursy)) {
                     int ox = xoffs, oy = yoffs;

                     set_display_offsets(cursx,cursy);
                     PM_smart_scroll(ox,oy);
                  }
                  save_hex_graphics(cursx,cursy,0);
                  if (blink_on)
                     plot_cursor(cursx,cursy);
                  hex_status_bar(cursx,cursy);
                  break;
               case 200:   // undefined drop-down menu function
                  (void)rtEZRequestTags("That function is not yot implemented.","Drat!",NULL,NULL,
                     RT_DEFAULT,TAG_END);
                  break;
               default:
                  (void)rtEZRequestTags("That key has no defined function.\nPlease try one of the many other keys.",
                     "Okay",NULL,NULL,
                     RT_Window,        map_window,
                     RT_ReqPos,        REQPOS_CENTERSCR,
                     RT_LockWindow,    TRUE,
                     RTEZ_Flags,       EZREQF_CENTERTEXT,
                     TAG_DONE );
            } // end switch
         FI
         if (class==IDCMP_MOUSEBUTTONS && code==SELECTDOWN) {
            int x, y;

            abs_to_log(message->MouseX,message->MouseY,&x,&y);
            restore_hex_graphics(cursx,cursy,0);
            if (cursx==x && cursy==y) {
               struct City *metro=city_hereP(x,y);

               if (metro)
                  if (metro->owner==player) {
                     examine_city(metro);
                     PM_update_hex(cursx,cursy);
                     save_hex_graphics(cursx,cursy,0);
                  FI
            } else {
               cursx = x;     cursy = y;
               if (need_to_scrollP(cursx,cursy)) {
                  int ox = xoffs, oy = yoffs;

                  set_display_offsets(cursx,cursy);
                  PM_smart_scroll(ox,oy);
               FI
               hex_status_bar(cursx,cursy);
               save_hex_graphics(cursx,cursy,0);
               if (blink_on)
                  plot_cursor(cursx,cursy);
            FI
         FI
         if (class==IDCMP_GADGETUP) {
            int ox = xoffs, oy = yoffs;

            restore_hex_graphics(cursx,cursy,0);
            if (scrolly(object,code)) {
               PM_smart_scroll(ox,oy);
            FI
            if (blink_on)
               plot_cursor(cursx,cursy);
         FI
         if (class == IDCMP_INTUITICKS)  // intuiticks control blinking
            if ((++ticks % 5) == 0) {
               blink_on = !blink_on;
               if (blink_on)
                  plot_cursor(cursx,cursy);
               else
                  restore_hex_graphics(cursx,cursy,0);
            FI
         ResetMenuStrip(map_window,prod_menu_strip);
      OD
   OD
 exit_productionmode:
   // deactivate IDCMP event input
   ModifyIDCMP(map_window,NULL);

   // return to my "generic" title bar
   clear_movebar();
   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);
}


// give user information about the specified hex
// this is a simple function which will be replaced later
// by something much more advanced

void survey_hex(col,row)
{
   struct MapIcon *icon;
   struct Unit *unit;
   struct City *metro;
   int terrain, controller=-1;

   // get my terrain and see if it's explored
   terrain = get(PLAYER.map,col,row);

   if (terrain==HEX_UNEXPLORED) {
      alert(map_window,NULL,"That area is unexplored.","Okay");
      return;
   } else {
      sprintf(foo,"The terrain is type \"%s\".",terrain_name_table[terrain]);
      alert(map_window,NULL,foo,"Okay");
   FI

   // see if there is a city, and who it belongs to
   if (metro=city_hereP(col,row)) {
      if (metro->owner==player) {
         controller = player;
         // do this so the user can see which city he is looking at
         save_hex_graphics(metro->col,metro->row,0);    // blit the background to a safe place
         plot_mapobject(metro->col,metro->row,MAP_MARKER);
         examine_city(metro);
         // unmark the city on screen
         restore_hex_graphics(metro->col,metro->row,0);
      } else {
         controller = metro->owner;
         sprintf(foo,"CITY: %s\nOWNER: %s\nPRODUCING: ",
            metro->name, roster[controller].name);
         if (metro->owner==0)
            strcat(foo,"none");
         else
            if (metro->recon[player]==CITY)
               strcat(foo,"unknown");
            else
               strcat(foo,wishbook[metro->recon[player]].name);
         alert(map_window,NULL,foo,"Okay");
      FI
   FI

   // determine who controls this hex, if we don't already know
   if (controller<0)
      // see if the current player has any units in this hex
      for (unit=(struct Unit *)unit_list.mlh_Head; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player) {
            controller = player;
            break;
         }
      // see if there are any enemy units displayed on this map hex
      for (icon = (struct MapIcon *)PLAYER.icons.mlh_Head; icon->inode.mln_Succ; icon=(struct MapIcon *)icon->inode.mln_Succ) {
         if (icon->col==col && icon->row==row) {
            controller = icon->owner;
            break;
         FI

      // if we still haven't found anything...
      if (controller<0)
         controller=0;
   FI

   // if the current player controls it, show all his units here
   if (controller==player) {
      for (unit=(struct Unit *)unit_list.mlh_Head; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player && unit->col==col && unit->row==row) {
            sprintf(foo,"UNIT TYPE: %s\nNAME: %s\nOWNER: %s\nROW: %ld, COL: %ld",
               wishbook[unit->type].name,unit->name,PLAYER.name,row,col);
            alert(map_window,NULL,foo,"Okay");
         FI
   FI

   // if another player controls it, review all the icons
   // {not yet implemented}
}


/*
   The following function determines which of a player's pieces should be moved
   next (or handled by the order manager) by default.  It will use several
   factors to determine this, such as position of various units on the map, their
   order in the list, etc.  It returns a pointer to the unit it settled on.
   If a suitable unit is not found, the function returns NULL.
*/

struct Unit *choose_default_unit(exclude)
struct Unit *exclude;
{
   struct Unit *unit, *chosen_unit=NULL;
   BOOL unit_found=FALSE;
   int ready;
   /*
      Go down the list of active units...

      This is a tricky proposition, since we need to process all the units
      belonging to the current player, but he may change the order in which
      they are moved.  Units can also be destroyed!  So, we can't just blindly
      go down the list.

      A better approach is to build a loop where each iteration seeks out
      the first suitable unit and processes it.  It continues until it
      fails to find any units that need processing.

      I use an extra loop to take screen position into account, attempting to
      exhaust the units on the visible part of the map first, to reduce the
      amount of scrolling needed.

      I will try to avoid using the "exclude" unit, if one has been named.
      This is so I can implement the "next unit" command and skip over a
      specified unit that the user wants to deal with later.
   */
   // first loop searches for units visible on the current map display
   for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
      if (easily_visibleP(unit->col,unit->row) && unit!=exclude) {
         ready = unit_readiness(unit);
         if (((ready&UNIT_READY)!=0) && ((ready&UNIT_PROCESSED)==0)) {
            unit_found = TRUE;
            break;
         FI
      FI

   if (!unit_found)  // do second loop only if first one turned up nothing
      for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit!=exclude) {    // skip the excluded unit
            ready = unit_readiness(unit);
            if (((ready&UNIT_READY)!=0) && ((ready&UNIT_PROCESSED)==0)) {
               unit_found = TRUE;
               break;
            FI
         FI

   if (unit_found)  // we've found our unit!
      chosen_unit = unit;
   if (exclude!=NULL && unit_found==FALSE)
      chosen_unit = choose_default_unit(NULL);
   return chosen_unit;
}


/*
   unit_readiness() can return four different bit flags for the status of the
   unit specified: UNIT_UNREADY, meaning the unit is invalid (NULL), does
   not belong to the current player, or has expended its movement this turn,
   or cannot move for some other reason; UNIT_READY, meaning the unit is
   ready to move and awaiting orders; UNIT_ENGAGED, meaning the unit has
   pending orders such as sentry duty, loading units, or moving to a specified
   location (such activities can be interrupted by the player); UNIT_PROCESSED,
   meaning it has orders but they have already been processed for this turn.
   These flags are not mutually exclusive: a unit could be both UNIT_UNREADY
   and UNIT_PROCESSED, for example.
*/

int unit_readiness(unit)
struct Unit *unit;
{
   int status = UNIT_READY;

   if (unit==NULL)
      return UNIT_UNREADY;

   if (unit->owner!=player || unit->move<10)
      status = UNIT_UNREADY;

   if (unit->orders) {
      if (unit->orders->processed)
         status |= UNIT_PROCESSED;
      else
         status |= UNIT_ENGAGED;
   FI
   return status;
}


/*
   The order_manager() function handles units that have standing orders to
   be executed.  It sorts them by order type and carries out the appropriate
   functions for them.
*/

void order_manager(unit)
struct Unit *unit;
{
   short type=unit->orders->type;

   // If there is no map display, this is the right time to create one.
   if (type!=ORDER_SENTRY)
      create_player_display(unit->col,unit->row);

   if (PLAYER.show&SHOW_GRP && type!=ORDER_SENTRY)
      if (need_to_scrollP(unit->col,unit->row)) {
         int ox=xoffs, oy=yoffs;

         set_display_offsets(unit->col,unit->row);
         GP_smart_scroll(ox,oy);
      }

   unit->orders->processed = TRUE;
   if (type==ORDER_LOAD)
      load_ship(unit);
   if (type==ORDER_GOTO)
      do_goto(unit);
   if (type==ORDER_AIRBASE)
      build_airbase(unit);
}


void build_airbase(unit)
struct Unit *unit;
{
   // The purpose being to transform "unit" into an airbase, if possible.

   int time;   // controlling how long the construction will take

   /*
      If the unit already has orders for something other than building an
      airbase, we should clear them.  Actually, build_airbase() shouldn't
      ever be called in a situation like that, but it doesn't hurt to make
      sure and make it robust.
   */
   if (unit->orders)
      if (unit->orders->type!=ORDER_AIRBASE) {
         FreeVec(unit->orders);
         unit->orders = NULL;
      FI

   /*
      Terrain!
      An airbase can't be built in a city, and only on certain types
      of terrain.  The type of terrain will also influence the amount of
      time required to build it.
   */
   {
      int terrain = get(t_grid,unit->col,unit->row);
      int invalid;
      struct Unit *scan;

      time = 1;
      switch (terrain) {
         case HEX_JUNGLE:
         case HEX_HILLS:
            time++;
         case HEX_FOREST:
         case HEX_RUGGED:
            time++;
         case HEX_BRUSH:
         case HEX_PLAINS:
         case HEX_DESERT:
            invalid = FALSE;
            break;
         default:
            invalid = TRUE;
      }
      if (invalid) {
         if (PLAYER.show&SHOW_REQ) {
            playSound(DONK_SOUND,PLAYER.snd_vol);
            alert(map_window,"Information...","You can't build an airbase\non that kind of terrain.","Okay");
         FI
      FI

      if (city_hereP(unit->col,unit->row)) {
         if (PLAYER.show&SHOW_REQ) {
            playSound(DONK_SOUND,PLAYER.snd_vol);
            alert(map_window,"Information...","You can't build an airbase on a city.","Okay");
         FI
         invalid = TRUE;
      FI

      // airbases can't be stacked
      for (scan=(struct Unit *)unit_list.mlh_Head;scan->unode.mln_Succ;scan=(struct Unit *)scan->unode.mln_Succ)
         if (scan->col==unit->col && scan->row==unit->row)
            if (scan->type==AIRBASE) {
               if (PLAYER.show&SHOW_REQ) {
                  playSound(DONK_SOUND,PLAYER.snd_vol);
                  alert(map_window,"Information...","That sector already has an airbase.","Okay");
               FI
               invalid = TRUE;
            FI

      /*
         It is theoretically possible, under exotic conditions, for construction of
         an airstrip to begin, but for the locaton to become invalid before it is
         completed.  In this case, the orders must be cleared and we abort.
      */
      if (invalid==TRUE && unit->orders!=NULL) {
         FreeVec(unit->orders);
         unit->orders = NULL;
         return;
      FI
   }

   /*
      If the unit is already working on an airbase, we'll process the order
      for this turn.  Otherwise we will issue the order to it.
   */
   if (unit->orders) {
      if (unit->orders->etc<=turn) {
         struct Unit *scan;
         long count = 0;

         FreeVec(unit->orders);
         unit->orders = NULL;
         unit->type = AIRBASE;
         unit->move = 0;
         unit->cargo = 0;
         unit->weight = 0;

         // If there are aircraft already in the sector, I should land them.
         for (scan=(struct Unit *)unit_list.mlh_Head;scan->unode.mln_Succ;scan=(struct Unit *)scan->unode.mln_Succ) {
            if (scan->col==unit->col && scan->row==unit->row)
               if (wishbook[scan->type].range>0) {      // identify aircraft
                  board_ship(scan,scan->col,scan->row);
                  if (scan->ship)
                     count++;    // count how many boarded successfully
               FI
         OD
         if (count>0 && PLAYER.show&SHOW_REQ) {
            sprintf(foo,"%ld aircraft landed on new airbase.",count);
            playSound(DONK_SOUND,PLAYER.snd_vol);
            alert(map_window,"Information...",foo,"Okay");
         FI
      FI
   } else {
      if (unit->type==RIFLE)
         give_orders(unit,ORDER_AIRBASE,0,0,turn+time);
      else if (PLAYER.show&SHOW_REQ) {
         playSound(DONK_SOUND,PLAYER.snd_vol);
         alert(map_window,"Information...","Only infantry can construct an airbase.","Okay");
      FI
   FI
}



/*
   The mode_manager() function handles the switching between survey mode,
   movement mode, and any other user modes that I might add later.  In fact,
   it now handles the human player's entire turn, replacing the older
   human_player_moves() function.
*/

void mode_manager()
{
   int unit_count = 0, new_units;
   struct Unit *current_unit = NULL;
   struct Unit *unit = (struct Unit *)unit_list.mlh_Head;

   /*
      add the movement points on all the player's units, so they are ready
      to move for this turn -- also "explore" around each unit, thus
      updating the map to account for enemy movements

      NOTE: if the game has just been restored from disk, we skip right into the
      player's turn -- no movement refresh or city production
   */
   if (control_flag!=GAME_RESTORED) {
      for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
         if (unit->owner==player) {
            unit->move = unit_speed(unit);
            unit->attacks = 0;
            explore_at_hex(player,unit->col,unit->row,INVISIBLE,FALSE);
            if (unit->orders) {
               unit->orders->processed = FALSE;
               if (unit->orders->type==ORDER_SENTRY)
                  continue;  // don't count sentried units
            FI
            unit_count++;
         FI

      // do the movement/survey mode thing

      // update his production for this turn
      new_units = do_cities_production();

      if (unit_count+new_units<1) {
         // even if the player has no active units, he may still see the
         // automatic combat report
         if (PLAYER.autorpt)
            show_combat_report(TRUE);
         return;     // there was nothing for him to do
      FI
   FI

   if (PLAYER.autorpt)
      show_combat_report(TRUE);

   control_flag = NULL;
   FOREVER {
      int ready;
      switch (control_flag) {
         case GO_SURVEY:
            survey_mode(&current_unit);
            break;
         case GO_PRODUCTION:
            production_mode();
            if (control_flag==GO_MOVEMENT && Bool(current_unit))
               set_display_offsets(current_unit->col,current_unit->row);
            GP_draw_map();    // redraw the map for use of movement or survey mode!
            break;
         case EXIT_GAME:
         case GAME_OVER:
         case END_TURN:
            goto eot_cleanup;
         default:
            ready = unit_readiness(current_unit);
            if (ready&(UNIT_UNREADY|UNIT_PROCESSED))
               current_unit = choose_default_unit(NULL);
            ready = unit_readiness(current_unit);
            if (ready&UNIT_ENGAGED)
               order_manager(current_unit);
            else
               movement_mode(&current_unit);
            if (control_flag==UNIT_LOST)
               current_unit=NULL;
      }
   OD

 eot_cleanup:     // do some housekeeping at end of turn
   // here I want to check for any ships that need repair
   {
      struct Unit *unit=(struct Unit *)unit_list.mlh_Head;
      for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
         if (unit->damage>0 && unit->move>50)
            if (unit->owner==player && city_hereP(unit->col,unit->row))
               unit->damage--;
   }


   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);
}

//UBYTE *get_password()
//{
// struct Window *PwordWindow;
// short player = Opt.CurrentPlayer;
// struct IntuiMessage *message; // the message the IDCMP sends us
// short quit_flag = FALSE;
//
// strcpy(PWordIText53.IText,Roster[player].Name);
//
// PWordNewWindowStructure7.Screen = MapScreen;
// PwordWindow = OpenWindow(&PWordNewWindowStructure7);
// if (PwordWindow==NULL) {
//    Print("Unable to open password window!\n");
//    clean_exit();
// FI
// SetPointer(MapWindow,BUSY_POINTER);
//
// PrintIText(PwordWindow->RPort,&PWordIText53,0,0);
//
// do {
//    WaitPort(PwordWindow->UserPort);
//       while( (message = (struct IntuiMessage *)\
//          GetMsg(PwordWindow->UserPort) ) != NULL)
//       {
//          code = message->Code;  // MENUNUM
//          object = message->IAddress;  // Gadget
//          class = message->Class;
//          ReplyMsg(message);
//          if ( class == CLOSEWINDOW )
//             (quit_flag = TRUE);
//       OD
// } while (quit_flag == FALSE);
// CloseWindow(PwordWindow);
// PwordWindow = NULL;
// ClearPointer(MapWindow);
//
// return PWordPWordPWordSIBuff;
//}

/*
   This gets a password from the user and combines it with his name
   to create a unique passlock string.  This will be used for filemail
   security checks.  NOTE: This is a really quick-and-dirty approach
   offering _minimal_ security for the users.  To be perfectly honest,
   I am just too lazy to sit down and implement real serious security
   for this game.  If you can't trust the other guy, why are you playing
   with him anyway?
*/

/*void create_passlock()
{
   char *password = get_password();
   short ctr = 0, pw_index = 0, nm_index = 0;

   for (; ctr<=40; ctr++) {
      PASSLOCK[ctr] = password[pw_index++] ^ NAME[nm_index++];
      if (password[pw_index]=='\0')
         pw_index=0;
      if (NAME[nm_index]=='\0')
         nm_index=0;
   OD

   // erase the password itself
   for (ctr=0; ctr<=40; ctr++)
      password[ctr] = '\0';
}
*/

/*
   Here is where I get the password and compare it with the user's
   passlock string, which was created earlier.
*/

/*int verify_password()
{
   char *password = get_password(), newlock[41];
   short ctr = 0, pw_index = 0, nm_index = 0;

   for (; ctr<=40; ctr++) {
      newlock[ctr] = password[pw_index++] ^ NAME[nm_index++];
      if (password[pw_index]=='\0')
         pw_index=0;
      if (NAME[nm_index]=='\0')
         nm_index=0;
   OD
   if (strncmp(newlock,PASSLOCK,40L)==0)
      return TRUE;
   else
      return FALSE;
}

void show_report()
{
   long file;
   short ctr;

   if (Opt.FMailMode) {
      sprintf(report,"Movement and battle report for turn %ld.",\
      Opt.CurrentTurn);
      tell_user(report,NULL);
   } else
      tell_user("All commanders report for movement and battle phase!",NULL);
   clear_map();
   draw_mapgrid();
   DisplayBeep(MapScreen);
   SetPointer(MapWindow,WAIT_POINTER);
   wait_for_click();
   SetPointer(MapWindow,BUSY_POINTER);

   file = Open("T:RPT.CC",MODE_OLDFILE);
   if (file==NULL)
      return;
   for (ctr=1; ctr<=(FLength("T:RPT.CC")/sizeof(struct ReportRecord)); ctr++) {
      Read(file,&MBReport,(long)sizeof(MBReport));
      show_entry(&MBReport);
   OD
   Close(file);

   SetPointer(MapWindow,WAIT_POINTER);
   tell_user("Click to continue...",NULL);
   wait_for_click();
   ClearPointer(MapWindow);
}
*/

/*
   Next function returns the speed of a unit.  I can't use a simple table
   here because the speed of some units vary, such as ships when damaged.
*/

int unit_speed(unit)
struct Unit *unit;
{
   int speed = wishbook[unit->type].speed;  // base speed of each unit type

   /*
      Note that speed in Invasion Force is measured by 60ths of a hex.
      Thus, a RIFLE unit with speed 60 can generally move one hex across
      open (HEX_PLAINS) terrain.  A SUB with speed 120 will usually move
      two hexes through open ocean (HEX_OCEAN).  The final result will
      vary depending on various factors: terrain, combat, ship damage, etc.
   */

   // compensate for ship damage here...
   switch (unit->type) {
      case ARMOR:
         if (unit->damage>=1)
            speed -= 60;
         break;
      case DESTROYER:
         if (unit->damage>=2)
            speed -= 120;
         break;
      case TRANSPORT:
         if (unit->damage>=2)
            speed -= 60;
         break;
      case SUB:
         if (unit->damage>=1)
            speed -= 60;
         break;
      case CRUISER:
      case CARRIER:
         if (unit->damage>=4)
            speed -= 60;
         break;
      case BATTLESHIP:
         if (unit->damage>=6)
            speed -= 60;
   }
   return speed;
}


/*
   The following function calls the player to the computer (presumably because
   it's his turn) and generates his map display, centered on (row,col),
   presumably because some event has happened there.  This is what I call when
   jumpstarting a player, or when his first unit is produced on a turn, or
   when he needs to move his first unit on a turn when nothing was produced.
   The function is aware of the current player's ".show" value, so you don't
   need to check it before calling.
*/

void create_player_display(col,row)
int col,row;
{
   // Do nothing if there is already a map display.
   if (display==TRUE) return;

   // first, call the player over here
   if (PLAYER.show&SHOW_REQ) {
      sprintf(foo,"Turn %ld.  Player %ld up.\n%s report for duty!",turn,player,PLAYER.name);
      (void)rtEZRequestTags(foo,"I'm Here",NULL,NULL,
         RTEZ_ReqTitle,NULL,
         RTEZ_Flags,EZREQF_CENTERTEXT,
         RT_Window,map_window,
         RT_ReqPos,REQPOS_CENTERWIN,
         RT_LockWindow, TRUE,
         TAG_END );
   FI

   // now create the display
   if (PLAYER.show&SHOW_GRP) {
      set_display_offsets(col,row);
      GP_draw_map();
      // set the display flag, so the program will know he's already got a
      // map, and won't needlessly call the player and draw the map again
      display = TRUE;
   FI
}


void weed_combat_report()
{  // weed old messages out of the combat report file
   BPTR oldfile, newfile;
   ULONG length;
   int ctr, kill;

   strcpy(foo,prefix);
   strcat(foo,id_filetag);
   strcat(foo,".CR");   // CR = Combat Report
   if ((length=FLength(foo))<1)
      return;  // no combat report to work with
   oldfile = Open(foo,MODE_OLDFILE);
   strcpy(bar,foo);
   strcat(bar,"2");
   newfile = Open(bar,MODE_NEWFILE);
   for (ctr=0; ctr<(length/sizeof(battle)); ctr++) {
      Read(oldfile,&battle,sizeof(battle));
      kill = FALSE;
      if (battle.turn<turn-1)
         kill = TRUE;
      if (battle.turn==turn-1 && battle.att_owner<player)
         kill = TRUE;
      if (!kill)
         Write(newfile,&battle,sizeof(battle));
   OD
   Close(oldfile);
   Close(newfile);
   DeleteFile(foo);  // delete old combat report file
   Rename(bar,foo);  // rename new file to replace old one
}


BOOL save_game(filename)
char *filename;
{
   struct rtHandlerInfo *handle;
   BPTR file;
   int ctr;
   char err[80];

   sprintf(foo,"Save game to file:\n   `%s'",filename);
   handle = post_it(foo);
   SetPointer(map_window,BUSY_POINTER);

   file = Open(filename,MODE_NEWFILE);
   if (file==NULL) {
      strcpy(err,"Unable to open output file!");
      goto save_error;
   FI

   // the basic header information
   Write(file,"EMP2GAME",8L);    // magic identifies my saved games
   Write(file,&revision,2L);     // identify revision of Invasion Force
   Write(file,id_filetag,4L);    // the ID tag used for temporary filenames

   // the game status
   Write(file,&opt,(long)sizeof(opt));        // game options
   Write(file,&turn,(long)sizeof(turn));      // current turn
   Write(file,&player,(long)sizeof(player));  // current player
   Write(file,wishbook,(long)sizeof(wishbook));   // the unit definitions

   // the game map
   Write(file,&wrap,(long)sizeof(wrap));
   Write(file,&width,(long)sizeof(width));
   Write(file,&height,(long)sizeof(height));
   Write(file,t_grid,GRID_SIZE*2);

   // the city list
   {
      struct City *metro=(struct City *)city_list.mlh_Head;
      int num_cities=count_nodes(&city_list);

      Write(file,&num_cities,(long)sizeof(num_cities));
      for (; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ)
         Write(file,&metro->col,(long)(sizeof(*metro)-sizeof(metro->cnode)));
   }

   // the unit list
   /*
      When writing a unit, unlike cities or mapicons, I must also save the
      address.  This will allow cargo units to be re-linked with their ships
      when loading them from disk.  I also must save the subordinate data such
      as orders or a name, if present.
   */
   {
      struct Unit *unit=(struct Unit *)unit_list.mlh_Head;
      int num_units=count_nodes(&unit_list);

      Write(file,&num_units,(long)sizeof(num_units));
      for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ) {
         if (unit->cargo>0)
            unit->ship = unit;
         Write(file,&unit->col,(long)(sizeof(*unit)-sizeof(unit->unode)));
         if (unit->cargo>0)
            unit->ship = NULL;
         if (unit->orders)
            Write(file,unit->orders,sizeof(*unit->orders));
         if (unit->name) {
            short size=strlen(unit->name)+1;
            Write(file,&size,2L);               // length of unit name
            Write(file,unit->name,(long)size);  // the name itself
         FI
      OD
   }

   // the roster of players
   Write(file,roster,(long)sizeof(roster));

   // save the map data for each player
   for (ctr=1; ctr<=8; ctr++)
      if (roster[ctr].type!=NOPLAYER)
         Write(file,roster[ctr].map,GRID_SIZE*2);

   // save the map icon list for each player
   for (ctr=1; ctr<=8; ctr++)
      if (roster[ctr].type!=NOPLAYER) {
         struct MapIcon *icon=(struct MapIcon *)roster[ctr].icons.mlh_Head;
         int num_icons=count_nodes(&roster[ctr].icons);

         Write(file,&num_icons,(long)sizeof(num_icons));
         for (; icon->inode.mln_Succ; icon=(struct MapIcon *)icon->inode.mln_Succ)
            Write(file,&icon->col,(long)(sizeof(*icon)-sizeof(icon->inode)));
      FI

   // save the combat report
   {
      BPTR infile;
      ULONG length;

      strcpy(foo,prefix);
      strcat(foo,id_filetag);
      strcat(foo,".CR");
      length=FLength(foo);
      Write(file,&length,(long)sizeof(length));
      if (length>=sizeof(battle)) {
         infile = Open(foo,MODE_OLDFILE);
         if (infile) {
            for (ctr=0; ctr<(length/sizeof(battle)); ctr++) {
               Read(infile,&battle,(long)sizeof(battle));
               Write(file,&battle,(long)sizeof(battle));
            OD
            Close(infile);
         FI
      FI
   }

   // save the specialized AI players' data
   if( SaveAIPlayers( file, err ) ) goto save_error;

   Close(file);

   // set the filenote
   SetComment(filename,"Invasion Force -- saved game.");

   ClearPointer(map_window);
   alert(map_window,NULL,"Game saved!","Okay");
   unpost_it(handle);
   return TRUE;

save_error:
   // to handle any errors that occur when attempting to save the game
   if (file)
      Close(file);
   DisplayBeep(map_screen);
   sprintf(foo,"Error saving game file `%s'.\n%s",filename,err);
   alert(map_window,NULL,foo,"Drat!");
   unpost_it(handle);
   ClearPointer(map_window);
   return FALSE;
}


BOOL load_game(filename)
char *filename;
{
   struct rtHandlerInfo *handle;
   BPTR file;
   int ctr;
   short revcheck;
   char err[80];

   strcpy(err,"The file seems to be incomplete.");    // default error message

   sprintf(foo,"Load game from file:\n   `%s'",filename);
   handle = post_it(foo);
   SetPointer(map_window,BUSY_POINTER);

   if ((file=Open(filename,MODE_OLDFILE))==NULL) {
      strcpy(err,"The file could not be opened.");
      goto load_error;
   FI

   // the basic header information
   (void)Read(file,foo,8L);
   if (strncmp(foo,"EMP2GAME",8)) {
      strcpy(err,"That does not seem to be an Invasion Force game.");
      goto load_error;  // not a saved game
   FI
   (void)Read(file,&revcheck,2L);
   if (revcheck<6 || revcheck>revision) {

      sprintf(err,"That is not an Invasion Force 0.06--0.%d map file!", revision);
      goto load_error;
   FI
   if (revcheck<revision) {
      (void)rtEZRequestTags(\
         "WARNING!\nThat appears to be an older revision file.\nYou should re-save it for future compatibility.",
         "Duly Noted",NULL,NULL,
         RT_Window,        map_window,
         RT_ReqPos,        REQPOS_CENTERSCR,
         RT_LockWindow,    TRUE,
         RTEZ_Flags,       EZREQF_CENTERTEXT,
         TAG_DONE );
   FI

   (void)Read(file,id_filetag,4L);

   // the game status
   (void)Read(file,&opt,sizeof(opt));           // option settings
   (void)Read(file,&turn,sizeof(turn));         // current turn
   (void)Read(file,&player,sizeof(player));     // current player
   if (revcheck>6)
      if (revcheck>16)
         (void)Read(file,wishbook,sizeof(wishbook));
      else
         (void)Read(file,wishbook,sizeof(struct UnitTemplate)*11L);

   // the game map
   (void)Read(file,&wrap,sizeof(wrap));
   (void)Read(file,&width,sizeof(width));
   if (Read(file,&height,sizeof(height))<sizeof(height))
      goto load_error;

   if (alloc_map(&t_grid)==FALSE) {
      strcpy(err,"Unable to allocate RAM for terrain.");
      goto load_error;
   FI
   if (revcheck<13) {
      if (Read(file,t_grid,GRID_SIZE)<GRID_SIZE)
         goto load_error;
   } else {
      if (Read(file,t_grid,GRID_SIZE*2)<GRID_SIZE*2)
         goto load_error;
   }

   // convert the old ARCTIC terrain to plains
   if (revcheck<13) {
      int cx, cy, terra;
      for (cx=0; cx<width; cx++)
         for (cy=0; cy<height; cy++) {
            terra = get(t_grid,cx,cy);
            if (terra==HEX_ARCTIC) {
               terra = HEX_PLAINS;
               put(t_grid,cx,cy,terra);
            FI
         OD
   FI

   // the city list
   {
      int num_cities;

      (void)Read(file,&num_cities,sizeof(num_cities));
      if (num_cities>0) {
         struct City *metro;

         for (ctr=1; ctr<=num_cities; ctr++) {
            metro = AllocVec(sizeof(*metro),MEMF_CLEAR);
            if (metro==NULL) {
               strcpy(err,"Unable to allocate RAM for cities.");
               goto load_error;
            FI
            if (revcheck<9) {
               struct OldCity oldmetro;
               int ctr2;

               (void)Read(file,&metro->col,sizeof(oldmetro)-sizeof(oldmetro.cnode));
               for (ctr2=0;ctr2<9;ctr2++)
                  metro->recon[ctr2] = CITY;   // no recon info
            } else
               (void)Read(file,&metro->col,sizeof(*metro)-sizeof(metro->cnode));
            if (revcheck<10)
               metro->specialty = CITY;
            AddTail((struct List *)&city_list,(struct Node *)metro);
         OD
      FI
   }

   // the unit list
   /*
      Loading in the units is complex because of the sub-items "orders"
      and "name" and even more importantly because of the linking between
      ships and the units they carry.  I must build a table of ships with
      their orginal addresses so that the units on board can find them and
      relink to the new addresses.  Although this makes loading complex, it
      is worthwhile for the simplicity of handing ship cargo in the game.

      The original address of the ship (in the previous session) has been
      stored in its unit->ship field.
   */
   {
      int num_units;

      if (Read(file,&num_units,sizeof(num_units))<sizeof(num_units))
         goto load_error;

      if (num_units>0) {
         int num_ships=0;
         APTR shiptab[100][2];    // table for re-linking cargo ships
         struct Unit *unit;

         for (ctr=1; ctr<=num_units; ctr++) {
            if ((unit=AllocVec(sizeof(*unit),MEMF_CLEAR))==NULL) {
               strcpy(err,"Unable to allocate RAM for units.");
               goto load_error;
            FI
            if (revcheck<14) {
               struct OldUnit compat;
               long ldsz = sizeof(compat)-sizeof(compat.unode);

               if (Read(file,&compat.col,ldsz)<ldsz) {
                  unit->col = compat.col;
                  unit->row = compat.row;
                  unit->owner = compat.owner;
                  unit->type = compat.type;
                  unit->damage = compat.damage;
                  unit->attacks = compat.attacks;
                  unit->cargo = compat.cargo;
                  unit->weight = compat.cargo;
                  unit->move = compat.move;
                  unit->fuel = compat.fuel;
                  unit->ship = compat.ship;
                  unit->orders = compat.orders;
                  unit->name = compat.name;
               } else
                  goto load_error;
            } else
               if (Read(file,&unit->col,sizeof(*unit)-sizeof(unit->unode))<sizeof(*unit)-sizeof(unit->unode)) {
                  FreeVec(unit);
                  goto load_error;
               FI

            // record table data for relinking ships and cargo
            if (unit->cargo>0) {
               shiptab[num_ships][0] = unit->ship;
               shiptab[num_ships++][1] = unit;
               unit->ship = NULL;
            FI

            AddTail((struct List *)&unit_list,(struct Node *)unit);
            if (unit->orders) {   // load in the orders
               unit->orders = AllocVec((long)sizeof(*unit->orders),MEMF_CLEAR);
               if (unit->orders==NULL) {
                  strcpy(err,"Unable to allocate RAM for unit orders.");
                  goto load_error;
               FI
               if (revcheck<8) {
                  struct OldOrder compat;

                  (void)Read(file,&compat,sizeof(compat));
                  unit->orders->type = compat.type;
                  unit->orders->orgx = compat.orgx;
                  unit->orders->orgy = compat.orgy;
                  unit->orders->destx = compat.destx;
                  unit->orders->desty = compat.desty;
                  unit->orders->etc = compat.etc;
                  unit->orders->dest_unit = compat.dest_unit;
                  unit->orders->processed = TRUE;
               } else
                  (void)Read(file,unit->orders,sizeof(*unit->orders));
            FI
            if (unit->name) {
               short size;
               if (Read(file,&size,2L)<2L)
                  goto load_error;

               if (Read(file,foo,(long)size)<(long)size)
                  goto load_error;

               unit->name = NULL;   // so name_unit() doesn't destruct
               name_unit(unit,foo);
            FI
         OD

         // run through the whole list to relink cargo units to their ships
         unit=(struct Unit *)unit_list.mlh_Head;
         for (; unit->unode.mln_Succ; unit=(struct Unit *)unit->unode.mln_Succ)
            if (unit->ship) {
               APTR shipid=unit->ship;

               unit->ship = NULL;
               for (ctr=0; ctr<num_ships; ctr++)
                  if (shiptab[ctr][0]==shipid) {
                     unit->ship = shiptab[ctr][1];
                     break;
                  FI
            FI
      FI
   }

   // the roster of players
   if (revcheck>=8)
      if (Read(file,roster,sizeof(roster))<sizeof(roster))
         goto load_error;
   // conversion of percentage-based attack and defense modifiers
   if (revcheck<13)
      for (ctr=0; ctr<9; ctr++) {
         roster[ctr].att = roster[ctr].att*16/100-8;
         roster[ctr].def = roster[ctr].def*16/100-8;
      }

   if (revcheck<8) {    // conversion for old files
      int ctr, ctr2;
      struct OldPLayer compat[9];
      if (Read(file,compat,sizeof(compat))<sizeof(compat))
         goto load_error;
      for (ctr=0; ctr<9; ctr++) {
         strcpy(roster[ctr].name,compat[ctr].name);
         roster[ctr].type   = compat[ctr].type;
         roster[ctr].status = compat[ctr].status;
         roster[ctr].color  = compat[ctr].color;
         roster[ctr].prod   = compat[ctr].prod;
         roster[ctr].att    = compat[ctr].att;
         roster[ctr].def    = compat[ctr].def;
         roster[ctr].aggr   = compat[ctr].aggr;
         roster[ctr].msg_delay    = compat[ctr].msg_delay;
         roster[ctr].battle_delay = compat[ctr].battle_delay;
         roster[ctr].soundfx      = compat[ctr].soundfx;
         roster[ctr].autorpt      = compat[ctr].autorpt;
         roster[ctr].show_production = compat[ctr].show_production;
         for (ctr2=0; ctr2<11; ctr2++) {
            roster[ctr].eud[ctr2] = compat[ctr].eud[ctr2];
            roster[ctr].ulc[ctr2] = compat[ctr].ulc[ctr2];
         OD
         roster[ctr].show = SHOW_ALL;
      OD
   FI

   // read the map data for each player
   for (ctr=1; ctr<=8; ctr++) {
      if (roster[ctr].type!=NOPLAYER) {
         roster[ctr].map = NULL;    // so alloc_map() doesn't try to destruct
         if (!alloc_map(&roster[ctr].map)) {
            strcpy(err,"Unable to allocate RAM for player maps!");
            goto load_error;
         FI
         if (revcheck<13)
            (void)Read(file,roster[ctr].map,GRID_SIZE);
         else
            (void)Read(file,roster[ctr].map,GRID_SIZE*2);

         // convert the old ARCTIC terrain to plains
         if (revcheck<13) {
            int cx, cy, terra;
            for (cx=0; cx<width; cx++)
               for (cy=0; cy<height; cy++) {
                  terra = get(roster[ctr].map,cx,cy);
                  if (terra==HEX_ARCTIC) {
                     terra = HEX_PLAINS;
                     put(roster[ctr].map,cx,cy,terra);
                  FI
               OD
         FI
      FI
   }

   // read the map icon list for each player
   for (ctr=1; ctr<=8; ctr++)
      if (roster[ctr].type!=NOPLAYER) {
         int num_icons, n;
         struct MapIcon *icon;

         if (Read(file,&num_icons,sizeof(num_icons))<sizeof(num_icons))
            goto load_error;
         NewList((struct List *)&roster[ctr].icons);  // new icon list
         for (n=0; n<num_icons; n++) {
            icon = AllocVec(sizeof(*icon),MEMF_CLEAR);
            if (icon==NULL) {
               strcpy(err,"Unable to allocate RAM for player map icons!");
               goto load_error;
            FI
            if (revcheck>=10)
               if (Read(file,&icon->col,sizeof(*icon)-sizeof(icon->inode))<(sizeof(*icon)-sizeof(icon->inode)))
                  goto load_error;
            if (revcheck<10) {
               struct OldMapIcon omi;

               if (Read(file,&omi.col,sizeof(omi)-sizeof(omi.inode))<(sizeof(omi)-sizeof(omi.inode)))
                  goto load_error;
               icon->col = omi.col;
               icon->row = omi.row;
               icon->type = omi.type;
               icon->owner = omi.owner;
               icon->token = omi.token;
               icon->turn = turn;
               icon->stacked = omi.stacked;
            FI
            // value of MILITIA and CITY changed in release 0.13
            if (revcheck<13)
               if (icon->type==11 || icon->type==12)
                  icon->type += 9;

            AddTail((struct List *)&roster[ctr].icons,(struct Node *)icon);
         OD
      FI

   // restore the combat report
   {
      BPTR outfile;
      ULONG length;

      strcpy(foo,prefix);
      strcat(foo,id_filetag);
      strcat(foo,".CR");
      if (Read(file,&length,sizeof(length))<sizeof(length))
         goto load_error;
      outfile = Open(foo,MODE_NEWFILE);
      if (outfile==NULL) {
         strcpy(err,"Unable to create new combat report file!");
         goto load_error;
      FI
      if (length>=sizeof(battle))
         for (ctr=0; ctr<(length/sizeof(battle)); ctr++) {
            if (Read(file,&battle,(long)sizeof(battle))<sizeof(battle)) {
               Close(outfile);
               DeleteFile(foo);
               goto load_error;
            FI
            Write(outfile,&battle,(long)sizeof(battle));
         OD
      Close(outfile);
   }

   // And now, load up the AI players' data from the save file
   if( revcheck > 10 ) {
       // Older revisions than 11 don't have AI players data in them
       if( LoadAIPlayers( file, err ) )  goto load_error;
   }

   Close(file);
   ClearPointer(map_window);
   alert(map_window,NULL,"Game loaded!","Okay");
   unpost_it(handle);
   return TRUE;

load_error:
   /*
      This part of the function handles anything that might go wrong during
      the load process.  It allows me to abort and clean up any mess that
      might have been created.  An error text should be found in the string
      variable "err" to inform the user.
   */

   // alert the user that something went wrong
   DisplayBeep(map_screen);
   sprintf(foo,"Error loading game file `%s'.\n%s",filename,err);
   alert(map_window,NULL,foo,"Drat!");
   unpost_it(handle);

   // clean up any messes that may have been left from the load process
   if (file)
      Close(file);
   cleanup_game();
   ClearPointer(map_window);

   return FALSE;
}


/*
   the cryptically named function build_pan() actually accepts a path
   and a filename and builds them into a supposedly valid "path and name"
   (or PAN) in a single string
*/

void build_pan(string,path,file)
char *string, *path, *file;
{
   int dirlen=strlen(path);

   strcpy(string,path);
   if (dirlen)
      if (string[dirlen-1]!='/' && string[dirlen-1]!=':')
         strcat(string,"/");
   strcat(string,file);
}


BOOL rt_loadsave_game(save)
int save;
{  // load or save using the ReqTools file requester
   struct rtFileRequester *req = NULL;
   char pan[216];  // pan = Path And Name
   BOOL chosen;

   req = rtAllocRequestA(RT_FILEREQ,NULL);
   if (req==NULL) {
      alert(map_window,NULL,"Failed to allocate ReqTools file requester.","Drat!");
      return FALSE;
   FI
   rtChangeReqAttr(req,
      RTFI_Dir,game_filepath,
      RTFI_MatchPat,"#?.IF",
      TAG_END);
   chosen = (BOOL)rtFileRequest(req,game_filename,(save ? "Save Map" : "Load Map"),
      RTFI_Flags, (save ? FREQF_SAVE : NULL) | FREQF_PATGAD,
      RT_DEFAULT, TAG_END);
   if (chosen) {
      strcpy(game_filepath,req->Dir);
      build_pan(pan,game_filepath,game_filename);
   } else {
      rtFreeRequest(req);
      return FALSE;
   FI
   rtFreeRequest(req);
   if (save)
      return save_game(pan);
   else
      return load_game(pan);
}


void execute_game_turns()
{
   char outbuf[40];
   int  i;

   if (control_flag!=GAME_RESTORED) {
      /*
         We want to give the players a city to work from
         before starting each player - that way
         player #1 is not surprised by player #8
         showing up next to him (and not seeing
         him when selecting initial city production)
      */
      for (; player<=8; player++) {
         if( PLAYER.status == ACTIVE && PLAYER.type != NOPLAYER) {
            if (NONHUMAN(PLAYER.type))
               PLAYER.soundfx = SOUND_NONE;
            if (PLAYER.map == NULL)
               create_initial_city();
         }
      }
      player = 1;
   }

   FOREVER {
      for (; player<=8; player++) {
         clear_movebar();
         weed_combat_report();
         if (PLAYER.status == ACTIVE && PLAYER.type != NOPLAYER) {
            CLEAR_WINDOW();
            if (PLAYER.map == NULL)
               jumpstart_player();
            if (ISHUMAN(PLAYER.type))
               mode_manager();
            if (control_flag==EXIT_GAME) goto end_of_game;
            if (NONHUMAN(PLAYER.type))
               computer_player_moves();
         FI
         CLEAR_WINDOW();
         if((PLAYER.status == ACTIVE) &&
            (PLAYER.type != NOPLAYER) && ( !player_still_in_game() )) {
            PLAYER.status = CRUSHED;
            sprintf( outbuf, "Player %ld has been crushed.", player );
            (void)rtEZRequestTags
              ( outbuf,"Hooray!",NULL,NULL,RT_DEFAULT,TAG_END);
            end_of_player(player);
         FI
      OD
      if (game_overP()) {
       for( i=1; i<9; i++ ) {
         if((roster[i].status == ACTIVE)&&(roster[i].type != NOPLAYER)) {
        sprintf( outbuf, "Player %ld has won the game!", i );
        (void)rtEZRequestTags
            ( outbuf,"Congratulations!",NULL,NULL,RT_DEFAULT,
         TAG_END);
         }
       }
       goto end_of_game;
      }
//      if (rtEZRequestTags("Exit test mode?","Yes|No",NULL,NULL,
//         RTEZ_Flags,EZREQF_CENTERTEXT,
//         RT_Window,map_window,
//         RT_ReqPos,REQPOS_CENTERWIN,
//         RT_LockWindow, TRUE,
//         TAG_END )) goto end_of_game;
      if( !human_still_in_game() ) {
     /* Let the humans know they have been eliminated */
     (void)rtEZRequestTags
         ( "All humans have been eliminated. Long live the machines!",
      "Hooray!",NULL,NULL,RT_DEFAULT,TAG_END);
     goto end_of_game;
      }
      turn++;
      player = 1;
   OD
end_of_game:
   cleanup_game();
}


BOOL game_overP()
{
    int i;
    int in_game = 0;

    for( i=1; i<9; i++) {
   if (roster[i].status == ACTIVE && roster[i].type != NOPLAYER) {
       in_game++;
   }
    }
    if( in_game > 1 ) return FALSE;
    return TRUE;
}


BOOL human_still_in_game()
{
    int i;
    for( i=1; i<9; i++) {
   if(( roster[i].status == ACTIVE ) &&
      ( roster[i].type == HUMAN ))
       return TRUE;
    }
    return FALSE;
}


BOOL player_still_in_game()
{
   struct Unit* unit = (struct Unit*)unit_list.mlh_Head;
   struct City* metro= (struct City*)city_list.mlh_Head;

   // If a player owns a single unit, he is still in the game
   for( ;unit->unode.mln_Succ; unit=(struct Unit*)unit->unode.mln_Succ)
      if( unit->owner == player ) return TRUE;

   // Or if a single city is owned, he is also still in the game
   for( ;metro->cnode.mln_Succ; metro=(struct City*)metro->cnode.mln_Succ)
      if( metro->owner == player ) return TRUE;

   return FALSE;
}


void cleanup_game()
{
   int ctr;

   // delete the temporary combat report file, if it's there
   strcpy(foo,prefix);
   strcat(foo,id_filetag);
   strcat(foo,".CR");   // CR = Combat Report
   if (FLength(foo)>=0)
      DeleteFile(foo);

   // eradicate each player
   for (ctr=1; ctr<=8; ctr++) {
      if (roster[ctr].type!=NOPLAYER) {
         nuke_list(&roster[ctr].icons);
         free_map(&roster[ctr].map);
         if (NONHUMAN(roster[ctr].type))  cleanup_computer ();
      FI
      roster[ctr].type = NOPLAYER;
   OD
   nuke_list(&city_list);
   nuke_units(&unit_list);
   free_map(&t_grid);
   clear_movebar();
   // reset PAN
   strcpy(game_filepath,"ProgDir:Games/");
   strcpy(game_filename,"Game.IF");
}


void play_game()
{
   int ctr, retry, abort=FALSE;
   BPTR file;

   // deactivate IDCMP event input
   ModifyIDCMP(map_window,NULL);

   // having just arrived here from the main program module,
   // first thing is detach the main menu strip
   ClearMenuStrip(map_window);
   // change the title so the user knows where he is
   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);

   if (!move_menu_strip)
      build_move_menu();      // prepare the drop-down menus for use
   if (!vey_menu_strip)
      build_survey_menu();
   if (!prod_menu_strip)
      build_production_menu();

   turn = 1;   player = 1;
   // chose my random filename tag for this game
   strcpy(foo,"XXXX");
   for (ctr=0; ctr<4; ctr++)
      foo[ctr] = (char)('A'+RangeRand(26));
   strcpy(id_filetag,foo);

   // create a file for storing combat reports
   strcpy(foo,prefix);
   strcat(foo,id_filetag);
   strcat(foo,".CR");
   do {
      retry = FALSE;
      file = Open(foo,MODE_NEWFILE);
      if (file)
         Close(file);
      else {
         int choice;

         sprintf(bar,"Unable to create file %s on T: device.",foo);
         choice = rtEZRequestTags(
            bar,"Try Again|Abort Game",NULL,NULL,
            RT_Window,        map_window,
            RT_ReqPos,        REQPOS_CENTERWIN,
            RT_LockWindow,    TRUE,
            TAG_DONE );
         abort = (choice==0);
         retry = !abort;
      FI
   } while (retry);

   control_flag = 0;
   if (!abort)
      execute_game_turns();

   // clear window
   Move(rast_port,0,0);    ClearScreen(rast_port);
   zero_scrollers();

   // reset the title for the main module
   SetWindowTitles(map_window,"Top Level",(UBYTE *)~0);
   // remove the gameplay drop-down menus
   ClearMenuStrip(map_window);
   // re-attach the main menu strip before returning to the main module
   ResetMenuStrip(map_window,main_menu_strip);
   ModifyIDCMP(map_window,IDCMP_MENUPICK);

   // free the menus that will no longer be needed
   if (move_menu_strip) {
      FreeMenus(move_menu_strip);
      move_menu_strip = NULL;
   FI
   if (vey_menu_strip) {
      FreeMenus(vey_menu_strip);
      vey_menu_strip = NULL;
   FI
}


void restore_game()
{     // same as play_game() except no initilization -- game was loaded from disk
   // deactivate IDCMP event input
   ModifyIDCMP(map_window,NULL);

   // having just arrived here from the main program module,
   // first thing is detach the main menu strip
   ClearMenuStrip(map_window);
   // change the title so the user knows where he is
   SetWindowTitles(map_window,"Game in progress...",(UBYTE *)~0);

   if (!move_menu_strip)
      build_move_menu();      // prepare the drop-down menus for use
   if (!vey_menu_strip)
      build_survey_menu();
   if (!prod_menu_strip)
      build_production_menu();

   control_flag = GAME_RESTORED;    // special instruction to avoid production phase
   execute_game_turns();

   // clear window
   Move(rast_port,0,0);    ClearScreen(rast_port);
   zero_scrollers();

   // reset the title for the main module
   SetWindowTitles(map_window,"Top Level",(UBYTE *)~0);
   // remove the gameplay drop-down menus
   ClearMenuStrip(map_window);
   // re-attach the main menu strip before returning to the main module
   ResetMenuStrip(map_window,main_menu_strip);
   ModifyIDCMP(map_window,IDCMP_MENUPICK);

   // free the menus
   if (move_menu_strip) {
      FreeMenus(move_menu_strip);
      move_menu_strip = NULL;
   FI
   if (vey_menu_strip) {
      FreeMenus(vey_menu_strip);
      vey_menu_strip = NULL;
   FI
}

void ToggleAIDataFlag()
{
  AIDataFlag++;
  if( AIDataFlag > AI_DATA_FLAG_LIMIT )  {
    AIDataFlag = 0;
  }
  sprintf( foo, "AI Information at level %ld", AIDataFlag );
  tell_user2( foo, FALSE, DONK_SOUND );
}



// end of listing




