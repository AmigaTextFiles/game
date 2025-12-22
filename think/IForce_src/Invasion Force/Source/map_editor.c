/*
   map_editor.c -- map editor module for Invasion Force
   This module provides the Invasion Force map editor.
   This source code is free.  You may make as many copies as you like.
*/

// standard header for all program modules
#include "global.h"
#include "gadgets_protos.h"

struct Menu *editor_menu_strip = NULL;

// globals for the map editor
BOOL MEdit = FALSE;
BOOL INFO = FALSE;
BOOL terminated = FALSE;
BOOL mapgen = FALSE;
BOOL mycity = FALSE;
int brush = HEX_PLAINS;
int tot = 0;
int totP = 0;
int figctr[] = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};
int infoctr[] = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};


/*
   This section is devoted to loading and saving the map files.
*/

int map_safe;      // Is it safe to leave without saving my map?

char map_filepath[108] = "ProgDir:Maps/", map_filename[108] = "Earth.MAP";


void save_map(filename)
char *filename;

{
   struct rtHandlerInfo *handle;
   BPTR file;

   sprintf(foo,"Saving map file:\n   `%s'",filename);
   handle = post_it(foo);
   SetPointer(map_window,BUSY_POINTER);

   file = Open(filename,MODE_NEWFILE);
   if (file == NULL) {
      DisplayBeep(map_screen);
      alert(map_window,NULL,"Unable to open file!\nMap not saved.","Drat!");
      unpost_it(handle);
      ClearPointer(map_window);
      return;
   FI

   Write(file,"EMP2MAP\0",8L);  // magic identifies my saved maps
   Write(file,&revision,2L);     // current revision of Invasion Force
   Write(file,&wrap,sizeof(wrap));
   Write(file,&width,sizeof(width));
   Write(file,&height,sizeof(height));
   Write(file,t_grid,GRID_SIZE*2);

   {  // save the cities!
      struct City *metro = (struct City *)city_list.mlh_Head;
      int num_cities = count_nodes(&city_list);

      Write(file,&num_cities,sizeof(num_cities));
      for ( ; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ)
         Write(file,&metro->col,(long)(sizeof(*metro)-sizeof(metro->cnode)));
   }
   Close(file);

   // Set the filenote.
   SetComment(filename,"Invasion Force -- saved map");

   ClearPointer(map_window);
   alert(map_window,NULL,"Map saved!","Okay");
   unpost_it(handle);
}


BOOL load_map(filename)
char *filename;
{
   BPTR file;
   BOOL new_wrap;
   int new_width, new_height;
   short revcheck;

   file = Open(filename,MODE_OLDFILE);
   if (file == NULL) {
      DisplayBeep(map_screen);
      alert(map_window,NULL,"Unable to open file!\nMap not loaded.","Drat!");
      return FALSE;
   FI

   Read(file,foo,8L);
   if (strncmp(foo,"EMP2MAP",8)) {
      Close(file);
      sprintf(foo,"[%s] is not a valid map file!",filename);
      alert(map_window,NULL,foo,"Oops!");
      return FALSE;
   FI
   Read(file,&revcheck,2L);
   if (revcheck<6 || revcheck>revision) {
      Close(file);
      sprintf(foo,"That is not an Invasion Force 0.06--0.%d map file!", revision);
      alert(map_window,NULL,foo,"Oops!");
      return FALSE;
   }

   if (revcheck<revision) {
      (void)rtEZRequestTags(\
         "WARNING!\nThat map is from an older revision of Invasion Force.\nYou should re-save it for future compatibility.",
         "Duly Noted",NULL,NULL,
         RT_Window,        map_window,
         RT_ReqPos,        REQPOS_CENTERSCR,
         RT_LockWindow,    TRUE,
         RTEZ_Flags,       EZREQF_CENTERTEXT,
         TAG_DONE );
   FI

   Read(file,&new_wrap,(long)sizeof(new_wrap));
   Read(file,&new_width,(long)sizeof(new_width));
   Read(file,&new_height,(long)sizeof(new_height));
   // sanity check
   if (new_width<MIN_WD || new_height<MIN_HT) {
      Close(file);
      alert(map_window,NULL,"That is not a valid map file!","Oops!");
      return FALSE;
   FI
   wrap = new_wrap;  width = new_width;   height = new_height;
   nuke_list(&city_list);  // wipe out all the old cities
   if (alloc_map(&t_grid)==FALSE) {
      Close(file);
      alert(map_window,NULL,"There's not enough RAM for that map!","Drat!");
      width = disp_wd; height = disp_ht;
      if (alloc_map(&t_grid)==FALSE)
         clean_exit(2,"ERROR: Fatal RAM allocation disaster!");
      ClearPointer(map_window);
      flood_map(t_grid,HEX_OCEAN);
      return FALSE;
   FI
   if (revcheck<13)
      Read(file,t_grid,GRID_SIZE);
   else
      Read(file,t_grid,GRID_SIZE*2);

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

   {  // load the cities, if there are any
      int num_cities;

      Read(file,&num_cities,(long)sizeof(num_cities));
      if (num_cities>0) {
         int ctr;
         struct City *flarp;

         for (ctr=1; ctr<=num_cities; ctr++) {
            flarp = AllocVec((int)sizeof(*flarp),MEMF_CLEAR);
            if (revcheck<9) {
               struct OldCity *foozle;
               int ctr2;

               Read(file,&flarp->col,(long)(sizeof(*foozle)-sizeof(flarp->cnode)));
               for (ctr2=0;ctr2<9;ctr2++)
                  flarp->recon[ctr2] = CITY;
            } else
               Read(file,&flarp->col,(long)(sizeof(*flarp)-sizeof(flarp->cnode)));
            if (revcheck<10)
               flarp->specialty = CITY;
            AddTail((struct List *)&city_list,(struct Node *)flarp);
         OD
      FI
   }
   Close(file);
   return TRUE;
}


// This handles loading a map file for the editor.

void ME_load_map(filename)
char *filename;
{
   struct rtHandlerInfo *handle;

   sprintf(foo,"Loading map file:\n   `%s'",filename);
   handle = post_it(foo);
   SetPointer(map_window,BUSY_POINTER);

   if (load_map(filename))
      alert(map_window,NULL,"Map loaded!","Okay");

   ClearPointer(map_window);
   unpost_it(handle);

   // update the display for the new map
   xoffs = yoffs = 0;
   update_scrollers();
   ME_draw_map();
}

#define LOAD 0
#define SAVE -1

void rt_loadsave_map(save)
int save;
{  // load or save using the ReqTools file requester
   struct rtFileRequester *req = NULL;
   char pan[216];  // pan = Path And Name
   BOOL chosen;

   req = rtAllocRequestA(RT_FILEREQ,NULL);
   if (req==NULL) {
      alert(map_window,NULL,"Failed to allocate ReqTools file requester.","Drat!");
      return;
   FI

   rtChangeReqAttr(req,
      RTFI_Dir,map_filepath,
      RTFI_MatchPat,"#?.MAP",
      TAG_END);
   
   
   chosen = (BOOL)rtFileRequest(req,map_filename,(save ? "Save Map" : "Load Map"),
      RTFI_Flags, (save ? FREQF_SAVE : NULL) | FREQF_PATGAD,
      RT_DEFAULT, TAG_END);
   if (chosen) {
      int dirlen = strlen(req->Dir);
      strcpy(map_filepath,req->Dir);
      strcpy(pan,map_filepath);
      if (dirlen)
         if (map_filepath[dirlen-1]!='/' && map_filepath[dirlen-1]!=':')
            strcat(pan,"/");
      strcat(pan,map_filename);
   } else {
      rtFreeRequest(req);
      return;
   FI
   rtFreeRequest(req);

   if (save)
      save_map(pan);
   else
      ME_load_map(pan);
   map_safe = TRUE;
}

/*
   This section is devoted to the map size window, where the user
   sets the map width, height and the wrap-around option.
*/

void try_map_resize(new_width,new_height)
int new_width,new_height;
{  // attempt to resize the map to these dimensions
   int old_width = width, old_height = height;

   if (new_width==old_width && new_height==old_height)
      return;

   if (new_width<MIN_WD || new_height<MIN_HT) {
      sprintf(foo,"The minimum size for maps is %ld wide, %ld high.",MIN_WD,MIN_HT);
      alert(map_window,NULL,foo,"Oops!");
      return;
   FI

   if (new_height%2) {
      alert(map_window,NULL,"The map height must be an even value!","Oops!");
      return;
   FI

   map_safe = TRUE;
   width = new_width;      height = new_height;
   if (alloc_map(&t_grid)==FALSE) {
      alert(map_window,NULL,"I can't create a map of that size!\n    Perhaps you need more RAM?","Drat!");
      width = old_width;   height = old_height;
      if (alloc_map(&t_grid)==FALSE)
         clean_exit(2,"ERROR: Fatal RAM allocation disaster!");
   FI

   xoffs = yoffs = 0; // reset the scrolly gadgets
   update_scrollers();
   flood_map(t_grid,HEX_OCEAN);     // default starting conditions
}


void map_size_request()
{
   BOOL resize_flag = FALSE;
   struct Window *mapsize_window = NULL;

   struct Gadget *context, *width_gad, *height_gad, *wrap_gad, *okay_gad, *cancel_gad;
   struct NewGadget button = {
      98,64,      // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      4,       // gadget ID
      NULL,NULL,NULL
   }, intfield = {
      90,41,      // leftedge, topedge
      72,16,   // width, height
      "_Height:", // text label
      NULL,    // font
      5,       // gadget ID
      PLACETEXT_LEFT,
      NULL,NULL
   }, toggle = {
      178,32,     // leftedge, topedge
      24,24,   // width, height
      "W_rap-Around Map",  // text label
      NULL,    // font
      6,       // gadget ID
      PLACETEXT_RIGHT,
      NULL,NULL
   };

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the [Okay] and [Cancel] buttons
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   button.ng_VisualInfo = vi;
   button.ng_TextAttr = &topaz11bold;
   okay_gad = CreateGadget(BUTTON_KIND,context,&button,TAG_END);
   button.ng_LeftEdge = 193;
   button.ng_GadgetText = "Cancel";
   button.ng_TextAttr = &topaz11;
   button.ng_Flags = NULL;
   cancel_gad = CreateGadget(BUTTON_KIND,okay_gad,&button,TAG_END);

   // create the Height and Width fields
   intfield.ng_VisualInfo = vi;
   intfield.ng_TextAttr = &topaz11;
   height_gad = CreateGadget(INTEGER_KIND,cancel_gad,&intfield,
      GTIN_Number, height,
      GT_Underscore, '_',
      GTIN_MaxChars, 6, TAG_END);
   intfield.ng_GadgetText = "_Width:";
   intfield.ng_TopEdge = 20;
   width_gad = CreateGadget(INTEGER_KIND,height_gad,&intfield,
      GTIN_Number, width,
      GT_Underscore, '_',
      GTIN_MaxChars, 6, TAG_END);

   // create the Wrap gadget
   toggle.ng_VisualInfo = vi;
   toggle.ng_TextAttr = &topaz11;
   wrap_gad = CreateGadget(CHECKBOX_KIND,width_gad,&toggle,
      GTCB_Checked, wrap,
      GT_Underscore, '_',
      TAG_END);

   // do the window itself
   mapsize_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Map Size",
      WA_CustomScreen,map_screen,
      WA_Top,155,    WA_Left,141,
      WA_Height,88,  WA_Width,357,
      WA_IDCMP,IDCMP_GADGETUP|IDCMP_VANILLAKEY,
      WA_Flags,NOCAREREFRESH|WFLG_DRAGBAR|WFLG_ACTIVATE,
      TAG_END );
   if (mapsize_window==NULL)
      clean_exit(1,"ERROR: Unable to open map size window!");

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;
      UWORD qualifier;

      FOREVER {
         WaitPort(mapsize_window->UserPort);
         while (message = GT_GetIMsg(mapsize_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            qualifier = message->Qualifier;
            GT_ReplyIMsg(message);
            if (class==IDCMP_VANILLAKEY) {
               switch ((char)code) {
                  case 'w':
                     ActivateGadget(width_gad,mapsize_window,NULL);
                     break;
                  case 'h':
                     ActivateGadget(height_gad,mapsize_window,NULL);
                     break;
                  case 'r':
                     // toggle the wrap gadget
                     setselect(wrap_gad,!selected(wrap_gad));
                     RefreshGList(wrap_gad,mapsize_window,NULL,1);
                     break;
                  case 'v':   // default for OKAY
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                  case 13:    // default for OKAY
                     // show the button depressed
                     show_depress(okay_gad,mapsize_window->RPort);
                     Delay(10L);
                     resize_flag = TRUE;
                     goto exit_mapsize_window;
                  case 'b':
                     if ((qualifier & IEQUALIFIER_LCOMMAND)==0)
                        break;
                     show_depress(cancel_gad,mapsize_window->RPort);
                     Delay(10L);
                     goto exit_mapsize_window;
               }
            FI
            if (class==IDCMP_GADGETUP) {
               if (object==okay_gad) {
                  resize_flag = TRUE;
                  goto exit_mapsize_window;
               FI
               if (object==cancel_gad)
                  goto exit_mapsize_window;
            FI
         OD
      OD
   }
   exit_mapsize_window:

   {
      // fetch new width, height, wrap values from the gadgets
      LONG nwd = ((struct StringInfo *)(width_gad->SpecialInfo))->LongInt,
           nht = ((struct StringInfo *)(height_gad->SpecialInfo))->LongInt;

      if (resize_flag)
         wrap = (wrap_gad->Flags & GFLG_SELECTED);

      // now close up everything with the mapsize_window
      CloseWindow(mapsize_window);
      mapsize_window = NULL;
      FreeGadgets(context);
      ClearPointer(map_window);
      ModifyIDCMP(map_window,IDCMP_MAPEDIT);

      if (resize_flag) {
         try_map_resize(nwd,nht);
         xoffs = yoffs = 0;
         update_scrollers();
         ME_draw_map();
      FI
   }
}

/*
   This section is devoted to the terrain selection window, where the
   user picks the kind of terrain he wants to draw with.
*/

int new_brush;

int terrain_index[] = {
   HEX_PLAINS, HEX_DESERT, HEX_FORBID,
   HEX_BRUSH, HEX_FOREST, HEX_JUNGLE,
   HEX_RUGGED, HEX_HILLS, HEX_MOUNTAINS,
   HEX_PEAKS, HEX_SWAMP, HEX_SHALLOWS,
   HEX_OCEAN, HEX_DEPTH, HEX_ICE, HEX_CITY,
   HEX_ROADS
};

void new_terrain(x,y)
int x,y;
{  // activate the user's selection from the terrain_window
   int col, row, newer_brush;

   row = (y-19)/24;
   col = ((x-5)-(row%2)*15)/30;
   newer_brush = terrain_index[row*8+col];

   highlight_terrain(new_brush,BLACK);
   highlight_terrain(newer_brush,WHITE);
   new_brush = newer_brush;
   brush = new_brush;
}

void highlight_terrain(terrain,color)
int terrain, color;
{  // outline the specified terrain type
   int ctr;

   SetAPen(rast_port,color);
   for (ctr = 0; ctr<=16; ctr++)
      if (terrain==terrain_index[ctr])
        px_outline_hex(5+30*ctr,15);
}

void do_terrain_window()
{  // everything for the terrain selection/info window
  
   struct Window *terrain_window = NULL;
   struct Gadget *context, *info_gad, *ok_gad;
   struct NewGadget generic = {
      515,18,      // leftedge, topedge
      66,12,   // width, height
      "Okay",  // text label
      NULL,    // font
      3,       // gadget ID
      NULL,NULL,NULL
   };

   new_brush = brush;   // initial new_brush value
   
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   generic.ng_VisualInfo = vi;
   generic.ng_TextAttr = &topaz11;
   generic.ng_LeftEdge += 5;
   generic.ng_GadgetText = "Info";
   info_gad = CreateGadget(BUTTON_KIND,context,&generic,TAG_END);
   generic.ng_TopEdge += 13;
   generic.ng_GadgetText = "Ok";
   ok_gad = CreateGadget(BUTTON_KIND,info_gad,&generic,TAG_END);
   
   // do the window itself
   terrain_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Terrain",
      WA_Top,335,    WA_Left,7,
      WA_Width,612,  WA_Height,50,
      WA_IDCMP,IDCMP_CLOSEWINDOW|IDCMP_MOUSEBUTTONS|IDCMP_VANILLAKEY
              |IDCMP_GADGETUP,
      WA_Flags,NOCAREREFRESH|WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
      WA_CustomScreen,map_screen,
      TAG_END );
   
   if (terrain_window==NULL)
      clean_exit(1,"ERROR: Unable to open terrain window!");
   
   INFO = FALSE;
   
   rast_port = terrain_window->RPort;

   {  // render the terrain hexes
      int ctr;
      
      for (ctr = 0; ctr<=16; ctr++) {
         SetAPen(rast_port,BLACK);
         px_outline_hex(5+30*ctr,15);
         if (terrain_index[ctr]<16)
             px_plot_hex(5+30*ctr,15,terrain_index[ctr]);
         else
             px_plot_hex(5+30*ctr,15,HEX_PLAINS);
         if (terrain_index[ctr]==17)
             px_plot_hex(5+30*ctr,15,HEX_PLAINS);
      OD
     
      // blit in the city
      px_plot_city(463,24);
      px_plot_roads(493,24);
      
      // highlight the current terrain
      highlight_terrain(brush,WHITE);
   }
    

   {
   
      // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      //struct MenuItem *item;
      //int ctr;

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;

      while (TRUE) {
         WaitPort(terrain_window->UserPort);
         while (message = GT_GetIMsg(terrain_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            GT_ReplyIMsg(message);
            if (class==MOUSEBUTTONS && code==SELECTDOWN)
               new_terrain(message->MouseX,message->MouseY);
            if (class==MOUSEBUTTONS && code==MIDDLEDOWN)
               goto exit_terrain_window;
            if (class==CLOSEWINDOW)
               goto exit_terrain_window;
            if (class==GADGETUP) {
               if (object==info_gad) {
                  //print("Found [INFO] button!\n");
                  INFO = TRUE;
                  goto exit_terrain_window;
               FI
               if (object==ok_gad) 
                  goto exit_terrain_window;
            FI
            if (class==IDCMP_VANILLAKEY && code=='i'){
               INFO = TRUE;
               goto exit_terrain_window;
            FI
            if (class==IDCMP_VANILLAKEY && code==' ') {
               //code = ' ';
               goto exit_terrain_window;
            FI
               
         OD
      OD
   }
   exit_terrain_window:

   {  // set the MX menu items to reflect this change
      struct MenuItem *item;
      int ctr;

      item = ItemAddress(editor_menu_strip,FULLMENUNUM(1,2,0));
      for (ctr = 1; ctr<=17; ctr++) {
         if (ctr==brush)
            item->Flags |= CHECKED;
         else
            item->Flags &= ~CHECKED;
         item = item->NextItem;
      OD
   }

   // now clean everything up and leave
       rast_port = map_window->RPort;
       CloseWindow(terrain_window);
       terrain_window = NULL;
       FreeGadgets(context);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);       
}

void info_update_gadget(info_button)
struct Gadget *info_button;
{
       int color, destx, desty;
       int info_icon = info_button->GadgetID;
       
       destx = info_button->LeftEdge+1;
       desty = info_button->TopEdge+1;
       
       switch (info_icon) {
            case RIFLE:
            case ARMOR:
                color = GREEN;
                break;
            case AIRCAV:
            case BOMBER:
            case FIGHTER:
                color = LT_BLUE;
                break;
            case TRANSPORT:
            case SUB:
            case DESTROYER:
            case CRUISER:
            case BATTLESHIP:
            case CARRIER:
                color = DK_BLUE;
                break;
            default:
                return;
       };
       px_plot_icon(info_icon,destx,desty,color,ORDER_NONE,FALSE);
       if (infostatus[info_icon].enabled)
            bevel_box(destx-1, desty-1, 21, 17,TRUE);
       else {
            SetAPen(rast_port,RED);
            BltPattern(rast_port,(PLANEPTR)banned_mask,destx+1,desty+1,
                destx+17,desty+13,4);
       FI
}         

void do_info_window()
{  // everything for the terrain info window
   struct Window *info_window = NULL;
  
   struct Gadget *context, *info_inf, *info_arm, *info_cav, *info_bom, *info_ftr,
                 *info_trn, *info_sub, *info_des, *info_cru, *info_bat,
                 *info_car;
   struct Gadget *ok_gad; 
   struct NewGadget generic = {
      515,25,      // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      3,       // gadget ID
      NULL,NULL,NULL
   };
   struct NewGadget info_button = {
      150,45,
      21,17,
      NULL,
      NULL,
      RIFLE,
      NULL,
      NULL,
      NULL,
   }; 

   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   info_button.ng_VisualInfo = vi;
   info_inf = CreateGadget(GENERIC_KIND,context,&info_button,TAG_END);
   info_inf->Flags |= GFLG_GADGHCOMP;
   info_inf->Activation |= GACT_RELVERIFY;
   
   info_button.ng_LeftEdge = 180;
   info_button.ng_GadgetID = ARMOR;
   info_arm = CreateGadget(GENERIC_KIND,info_inf,&info_button,TAG_END);
   info_arm->Flags |= GFLG_GADGHCOMP;
   info_arm->Activation |= GACT_RELVERIFY;
   
   info_button.ng_LeftEdge = 210;
   info_button.ng_GadgetID = AIRCAV;
   info_cav = CreateGadget(GENERIC_KIND,info_arm,&info_button,TAG_END);
   info_cav->Flags |= GFLG_GADGHCOMP;
   info_cav->Activation |= GACT_RELVERIFY;

   info_button.ng_LeftEdge = 240;
   info_button.ng_GadgetID = BOMBER;
   info_bom = CreateGadget(GENERIC_KIND,info_cav,&info_button,TAG_END);
   info_bom->Flags |= GFLG_GADGHCOMP;
   info_bom->Activation |= GACT_RELVERIFY;
     
   info_button.ng_LeftEdge = 270;
   info_button.ng_GadgetID = FIGHTER;
   info_ftr = CreateGadget(GENERIC_KIND,info_bom,&info_button,TAG_END);
   info_ftr->Flags |= GFLG_GADGHCOMP;
   info_ftr->Activation |= GACT_RELVERIFY;
      
   info_button.ng_LeftEdge = 300;
   info_button.ng_GadgetID = TRANSPORT;
   info_trn = CreateGadget(GENERIC_KIND,info_ftr,&info_button,TAG_END);
   info_trn->Flags |= GFLG_GADGHCOMP;
   info_trn->Activation |= GACT_RELVERIFY;
       
   info_button.ng_LeftEdge = 330;
   info_button.ng_GadgetID = SUB;
   info_sub = CreateGadget(GENERIC_KIND,info_trn,&info_button,TAG_END);
   info_sub->Flags |= GFLG_GADGHCOMP;
   info_sub->Activation |= GACT_RELVERIFY;
        
   info_button.ng_LeftEdge = 360;
   info_button.ng_GadgetID = DESTROYER;
   info_des = CreateGadget(GENERIC_KIND,info_sub,&info_button,TAG_END);
   info_des->Flags |= GFLG_GADGHCOMP;
   info_des->Activation |= GACT_RELVERIFY;
         
   info_button.ng_LeftEdge = 390;
   info_button.ng_GadgetID = CRUISER;
   info_cru = CreateGadget(GENERIC_KIND,info_des,&info_button,TAG_END);
   info_cru->Flags |= GFLG_GADGHCOMP;
   info_cru->Activation |= GACT_RELVERIFY;
          
   info_button.ng_LeftEdge = 420;
   info_button.ng_GadgetID = BATTLESHIP;
   info_bat = CreateGadget(GENERIC_KIND,info_cru,&info_button,TAG_END);
   info_bat->Flags |= GFLG_GADGHCOMP;
   info_bat->Activation |= GACT_RELVERIFY;
           
   info_button.ng_LeftEdge = 450;
   info_button.ng_GadgetID = CARRIER;
   info_car = CreateGadget(GENERIC_KIND,info_bat,&info_button,TAG_END);
   info_car->Flags |= GFLG_GADGHCOMP;
   info_car->Activation |= GACT_RELVERIFY;
   generic.ng_VisualInfo = vi;
   generic.ng_TextAttr = &topaz11;
   generic.ng_LeftEdge += 25;
   generic.ng_GadgetText = "OK";
   ok_gad = CreateGadget(BUTTON_KIND,info_car,&generic,TAG_END);

           
 
   // do the window itself
   info_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Terrain Info",
      WA_Top,100,    WA_Left,7,
      WA_Width,612,  WA_Height,225,
      WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_CLOSEWINDOW|IDCMP_MOUSEBUTTONS|IDCMP_GADGETUP|IDCMP_GADGETDOWN,
      WA_Flags,NOCAREREFRESH|WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
      WA_CustomScreen,map_screen,
      TAG_END );
   if (info_window==NULL)
      clean_exit(1,"ERROR: Unable to open info window!");
   rast_port = info_window->RPort;

   {  // render the terrain hex
      int ctr;
      static int strength[] = { 1, 1, 1, 2, 1, 1, 3, 1, 2, 3, 1, 1 };
      new_brush = brush;  
      
      if (new_brush != HEX_CITY) {
         SetAPen(rast_port,BLACK);
         px_outline_hex(5+25,15);
         px_plot_hex(5+25,15,new_brush);
      FI
      // blit in the city
      if (new_brush == HEX_CITY) {
         SetAPen(rast_port,BLACK);
         px_outline_hex(5+25,15);
         px_plot_hex(5+25,15,HEX_PLAINS);
         px_plot_city(37,23);
      FI
      
      infostatus[RIFLE].enabled = FALSE;
      info_update_gadget(info_inf);
      //bevel_frame(176,46,29,23,FALSE);
      infostatus[ARMOR].enabled = FALSE;
      info_update_gadget(info_arm);
      //bevel_frame(212,46,29,23,FALSE);
      infostatus[AIRCAV].enabled = FALSE;
      info_update_gadget(info_cav);
      //bevel_frame(248,46,29,23,FALSE);
      infostatus[BOMBER].enabled = FALSE;
      info_update_gadget(info_bom);
      //bevel_frame(284,46,29,23,FALSE);
      infostatus[FIGHTER].enabled = FALSE;
      info_update_gadget(info_ftr);
      //bevel_frame(320,46,29,23,FALSE);
      infostatus[TRANSPORT].enabled = FALSE;
      info_update_gadget(info_trn);
      //bevel_frame(356,46,29,23,FALSE);
      infostatus[SUB].enabled = FALSE;
      info_update_gadget(info_sub);
      //bevel_frame(392,46,29,23,FALSE);
      infostatus[DESTROYER].enabled = FALSE;
      info_update_gadget(info_des);
      //bevel_frame(428,46,29,23,FALSE);
      infostatus[CRUISER].enabled = FALSE;
      info_update_gadget(info_cru);
      //bevel_frame(464,46,29,23,FALSE);
      infostatus[BATTLESHIP].enabled = FALSE;
      info_update_gadget(info_bat);
      //bevel_frame(500,46,29,23,FALSE);
      infostatus[CARRIER].enabled = FALSE;
      info_update_gadget(info_car);
      //bevel_frame(536,46,29,23,FALSE);
                
      // render in some text and unit icons        
         sprintf(foo,"Units able to traverse this terrain:");
         plot_text(5+65,26,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         sprintf(foo,"Movement Costs:");
         plot_text(5+5,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         bevel_box(138,67,370,36,FALSE);
         bevel_box(138,105,370,111,TRUE);
         sprintf(foo,"Defense Factors:");
         plot_text(5+5,90,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         sprintf(foo,"Movement Range:");
         plot_text(5+5,110,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         sprintf(foo,"Movement Speed:");
         plot_text(5+5,130,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         sprintf(foo,"Hitpoints:");
         plot_text(5+5,150,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         sprintf(foo,"Strength:");
         plot_text(5+5,170,foo,BLACK,LT_GRAY,JAM2,&topaz11);
         
         if (new_brush == HEX_FORBID) {
            SetWindowTitles(info_window,"Forbidden Zone",(UBYTE *)~0);
            //for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                //sprintf(foo,"%ld",movement_cost_table[ctr][3]);
                //if (movement_cost_table[ctr][3] == -1)
                //    sprintf(foo," - ");
                //plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                //if (wishbook[ctr].range == -1) 
                //    sprintf(foo," - ");
                //else
                //    sprintf(foo,"%ld",wishbook[ctr].range);
                //plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                //sprintf(foo,"%ld",wishbook[ctr].speed);
                //plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                //sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                //plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                //sprintf(foo,"%ld",strength[ctr]);
                //plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            //OD
         FI

         if (new_brush == HEX_PLAINS) { 
            SetWindowTitles(info_window,"Plains",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][2]);
                if (movement_cost_table[ctr][2] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_DESERT) {
            SetWindowTitles(info_window,"Desert",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][3]);
                if (movement_cost_table[ctr][3] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);            
            OD
         FI
         if (new_brush == HEX_BRUSH) {
            SetWindowTitles(info_window,"Scrubland",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][4]);
                if (movement_cost_table[ctr][4] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_FOREST) {
            SetWindowTitles(info_window,"Forest",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][5]);
                if (movement_cost_table[ctr][5] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_JUNGLE) {
            SetWindowTitles(info_window,"Jungle",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][6]);
                if (movement_cost_table[ctr][6] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_RUGGED) {
            SetWindowTitles(info_window,"Rugged",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][7]);
                if (movement_cost_table[ctr][7] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_HILLS) {
            SetWindowTitles(info_window,"Hills",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][8]);
                if (movement_cost_table[ctr][8] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_MOUNTAINS) {
            SetWindowTitles(info_window,"Mountains",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][9]);
                if (movement_cost_table[ctr][9] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_PEAKS) {
            SetWindowTitles(info_window,"Mountain Peaks",(UBYTE *)~0);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][10]);
                if (movement_cost_table[ctr][10] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                if (ctr==2)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         if (new_brush == HEX_SWAMP) {
            SetWindowTitles(info_window,"Swamp",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][11]);
                if (movement_cost_table[ctr][11] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         
         if (new_brush == HEX_SHALLOWS) {
            SetWindowTitles(info_window,"Shallow Waters",(UBYTE *)~0);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            infostatus[TRANSPORT].enabled = TRUE;
            info_update_gadget(info_trn);
            infostatus[SUB].enabled = TRUE;
            info_update_gadget(info_sub);
            infostatus[DESTROYER].enabled = TRUE;
            info_update_gadget(info_des);
            infostatus[CRUISER].enabled = TRUE;
            info_update_gadget(info_cru);
            infostatus[BATTLESHIP].enabled = TRUE;
            info_update_gadget(info_bat);
            infostatus[CARRIER].enabled = TRUE;
            info_update_gadget(info_car);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][12]);
                if (movement_cost_table[ctr][12] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         
         if (new_brush == HEX_OCEAN) {
            SetWindowTitles(info_window,"Ocean",(UBYTE *)~0);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            infostatus[TRANSPORT].enabled = TRUE;
            info_update_gadget(info_trn);
            infostatus[SUB].enabled = TRUE;
            info_update_gadget(info_sub);
            infostatus[DESTROYER].enabled = TRUE;
            info_update_gadget(info_des);
            infostatus[CRUISER].enabled = TRUE;
            info_update_gadget(info_cru);
            infostatus[BATTLESHIP].enabled = TRUE;
            info_update_gadget(info_bat);
            infostatus[CARRIER].enabled = TRUE;
            info_update_gadget(info_car);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][13]);
                if (movement_cost_table[ctr][13] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         
         if (new_brush == HEX_DEPTH) {
            SetWindowTitles(info_window,"Deep Ocean",(UBYTE *)~0);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            infostatus[TRANSPORT].enabled = TRUE;
            info_update_gadget(info_trn);
            infostatus[SUB].enabled = TRUE;
            info_update_gadget(info_sub);
            infostatus[DESTROYER].enabled = TRUE;
            info_update_gadget(info_des);
            infostatus[CRUISER].enabled = TRUE;
            info_update_gadget(info_cru);
            infostatus[BATTLESHIP].enabled = TRUE;
            info_update_gadget(info_bat);
            infostatus[CARRIER].enabled = TRUE;
            info_update_gadget(info_car);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][14]);
                if (movement_cost_table[ctr][14] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         
         if (new_brush == HEX_ICE) {
            SetWindowTitles(info_window,"Packed Ice",(UBYTE *)~0);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo,"%ld",movement_cost_table[ctr][15]);
                if (movement_cost_table[ctr][15] == -1)
                    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
         
         if (new_brush == HEX_CITY) {
            SetWindowTitles(info_window,"City",(UBYTE *)~0);
            infostatus[RIFLE].enabled = TRUE;
            info_update_gadget(info_inf);
            infostatus[ARMOR].enabled = TRUE;
            info_update_gadget(info_arm);
            infostatus[AIRCAV].enabled = TRUE;
            info_update_gadget(info_cav);
            infostatus[BOMBER].enabled = TRUE;
            info_update_gadget(info_bom);
            infostatus[FIGHTER].enabled = TRUE;
            info_update_gadget(info_ftr);
            infostatus[TRANSPORT].enabled = TRUE;
            info_update_gadget(info_trn);
            infostatus[SUB].enabled = TRUE;
            info_update_gadget(info_sub);
            infostatus[DESTROYER].enabled = TRUE;
            info_update_gadget(info_des);
            infostatus[CRUISER].enabled = TRUE;
            info_update_gadget(info_cru);
            infostatus[BATTLESHIP].enabled = TRUE;
            info_update_gadget(info_bat);
            infostatus[CARRIER].enabled = TRUE;
            info_update_gadget(info_car);

            for (ctr=0; ctr <=10; ctr++) { 
                //px_plot_icon(ctr,150+30*ctr,50,BLACK,0,FALSE);
                sprintf(foo," 10");
                //if (movement_cost_table[ctr][1] == -1)
                //    sprintf(foo," - ");
                plot_text(150+30*ctr,70,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                if (wishbook[ctr].range == -1) 
                    sprintf(foo," - ");
                else
                    sprintf(foo,"%ld",wishbook[ctr].range);
                plot_text(150+30*ctr,110,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",wishbook[ctr].speed);
                plot_text(150+30*ctr,130,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                
                sprintf(foo,"%ld",wishbook[ctr].hitpoints);
                plot_text(150+30*ctr,150,foo,BLUE,LT_GRAY,JAM2,&topaz11);
                sprintf(foo,"%ld",strength[ctr]);
                plot_text(150+30*ctr,170,foo,BLUE,LT_GRAY,JAM2,&topaz11);
            OD
         FI
               
   }

   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      
      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;

      while (TRUE) {
         WaitPort(info_window->UserPort);
         while (message = GT_GetIMsg(info_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            GT_ReplyIMsg(message);
            if (class==GADGETUP) {
               if (object==ok_gad) {
                  INFO = FALSE;
                  goto exit_info_window;
               FI 
               if (object==info_inf) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_arm) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_cav) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_bom) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_ftr) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_trn) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_sub) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_des) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_cru) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_bat) 
                  alert(info_window,NULL,"For future use.","Okay");
               if (object==info_car) 
                  alert(info_window,NULL,"For future use.","Okay");
        
            FI
            if (class==CLOSEWINDOW) {
               INFO = FALSE; 
               goto exit_info_window;
            FI
            if (class==IDCMP_VANILLAKEY && code==13) {
               INFO = FALSE;
               goto exit_info_window;
            FI
         OD
      OD
   }
   exit_info_window:


   // now clean everything up and leave
       rast_port = map_window->RPort;
       CloseWindow(info_window);
       info_window = NULL;
       FreeGadgets(context);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);
}

#define MYGAD_SLIDER    (0)
#define MYGAD_SLIDER2   (1)
#define MYGAD_SLIDER3   (2)
#define MYGAD_SLIDER4   (3)
#define MYGAD_SLIDER5   (4)
#define MYGAD_SLIDER6   (5)
#define MYGAD_SLIDER7   (6)
#define MYGAD_SLIDER8   (7)
#define MYGAD_SLIDER9   (8)
#define MYGAD_SLIDER10  (9)
#define MYGAD_SLIDER11  (10)
#define MYGAD_SLIDER12  (11)
#define MYGAD_SLIDER13  (12)
#define MYGAD_SLIDER14  (13)
#define MYGAD_SLIDER15  (14)
#define MYGAD_SLIDER16  (15)
#define MYGAD_BUTTON    (16)
#define MYGAD_BUTTON2   (17)
#define MYGAD_BUTTON3   (18)
    
#define SLIDER_MIN  (0)
#define SLIDER_MAX  (100)


VOID handleGadgetEvent(struct Window *mywin, struct Gadget *gad, UWORD code,
    WORD *slider_level, struct Gadget *my_gads[])
{
    
    int ctr;

    terminated = FALSE;
                                   
        switch (gad->GadgetID)
        {
            //static int tot_hex;
           
                case MYGAD_SLIDER:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+5,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[0] = code;
                    break;
                case MYGAD_SLIDER2:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+35,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[1] = code;
                    break;
                case MYGAD_SLIDER3:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+65,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[2] = code;
                    break;
                case MYGAD_SLIDER4:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+95,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[3] = code;
                    break;
                case MYGAD_SLIDER5:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+125,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[4] = code;
                    break;
                case MYGAD_SLIDER6:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+155,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[5] = code;
                    break;
                case MYGAD_SLIDER7:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+185,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[6] = code;
                    break;
                case MYGAD_SLIDER8:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+215,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[7] = code;
                    break;
                case MYGAD_SLIDER9:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+245,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[8] = code;
                    break;
                case MYGAD_SLIDER10:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+275,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[9] = code;
                    break;
                case MYGAD_SLIDER11:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+305,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[10] = code;
                    break;
                case MYGAD_SLIDER12:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+335,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[11] = code;
                    break;
                case MYGAD_SLIDER13:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+365,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[12] = code;
                    break;
                case MYGAD_SLIDER14:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+395,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[13] = code;
                    break;
                case MYGAD_SLIDER15:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    plot_text(5+425,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[14] = code;
                    break;
                case MYGAD_SLIDER16:
                    *slider_level = code;
                    sprintf(foo,"%ld ",code);
                    //plot_text(5+425,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                    figctr[15] = code;
                    break;
                case MYGAD_BUTTON:                   
                    //printf("Found Help Button.\n");
                    sprintf(foo,"The terrain sliders select the approximate\npercentage of terrain to be generated.\n\n");
                    strcat(foo,"The Generate button will generate the map\nand ask to sprinkle cities.\n\n");
                    strcat(foo,"The Presets button will create various\nenvironments.\n\n");
                    strcat(foo,"Closing the window cancels this option.");
                    alert(mywin,NULL,foo,"Okay");
                    for (ctr = 0; ctr<=14; ctr++) {
                        SetAPen(rast_port,BLACK);
                        px_outline_hex(5+30*ctr,15);
                        if (terrain_index[ctr]<16)
                            px_plot_hex(5+30*ctr,15,terrain_index[ctr]);
                    OD
                    
                    break;                     
                case MYGAD_BUTTON2:
                    //printf("Found Generate Button.\n");
                    if (tot > 100) {
                        alert(mywin,NULL,"Map Terrain can't be over 100%! Please Adjust.","Okay");
                        //tot = 100;
                        frame(510,70,80,30,TRUE);
                        sprintf(foo,"TOTAL");
                        plot_text(530,66,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                        break;
                    FI

                    terminated = TRUE;
                    mapgen = TRUE;
                    break;
                case MYGAD_BUTTON3:
                    //printf("Found Presets Button.\n");
                    //alert(mywin,NULL,"Not implemented yet!","RATS!");
                    do_presets(); 
                    rast_port = mywin->RPort;
                    for (ctr = 0; ctr<=14; ctr++) {
                        SetAPen(rast_port,BLACK);
                        px_outline_hex(5+30*ctr,15);
                        if (terrain_index[ctr]<16)
                            px_plot_hex(5+30*ctr,15,terrain_index[ctr]);
                    OD

        }
    
    if (terminated == FALSE) {
        tot = figctr[0]+figctr[1]+figctr[2]+figctr[3]+figctr[4]+figctr[5]+
            figctr[6]+figctr[7]+figctr[8]+figctr[9]+figctr[10]+
            figctr[11]+figctr[12]+figctr[13]+figctr[14];
  
        sprintf(foo,"%ld ",tot);
        plot_text(540,85,foo,BLUE,LT_GRAY,JAM2,&topaz11);
    FI
}


struct Gadget *createAllGadgets(struct Gadget **glistptr, void *vi,
    WORD slider_level, struct Gadget *my_gads[])
{
        struct NewGadget ng;
        struct Gadget *gad;
        
        gad = CreateContext(glistptr);
        
        ng.ng_LeftEdge  = 14;
        ng.ng_TopEdge   = 60;
        ng.ng_Width     = 15;
        ng.ng_Height    = 150;
        ng.ng_GadgetText = NULL;
        ng.ng_TextAttr  = &topaz11;
        ng.ng_VisualInfo = vi;
        ng.ng_GadgetID  = MYGAD_SLIDER;
        ng.ng_Flags     = NG_HIGHLABEL;
                            
        my_gads[MYGAD_SLIDER] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER2;
        my_gads[MYGAD_SLIDER2] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);        
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER3;
        my_gads[MYGAD_SLIDER3] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER4;
        my_gads[MYGAD_SLIDER4] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER5;
        my_gads[MYGAD_SLIDER5] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER6;
        my_gads[MYGAD_SLIDER6] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER7;
        my_gads[MYGAD_SLIDER7] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);    
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER8;
        my_gads[MYGAD_SLIDER8] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);        
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER9;
        my_gads[MYGAD_SLIDER9] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);        
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER10;
        my_gads[MYGAD_SLIDER10] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);         
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER11;
        my_gads[MYGAD_SLIDER11] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);         
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER12;
        my_gads[MYGAD_SLIDER12] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);        
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER13;
        my_gads[MYGAD_SLIDER13] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);         
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER14;
        my_gads[MYGAD_SLIDER14] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);         
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER15;
        my_gads[MYGAD_SLIDER15] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);         
        ng.ng_LeftEdge   += 30;
        ng.ng_GadgetID   = MYGAD_SLIDER16;
        my_gads[MYGAD_SLIDER16] = gad = CreateGadget(SLIDER_KIND, gad, &ng,
            GTSL_Min,   SLIDER_MIN,
            GTSL_Max,   SLIDER_MAX,
            GTSL_Level, slider_level,
            GTSL_LevelFormat, "%21d",
            //GTSL_MaxLevelLen, 3,
            GA_RelVerify, TRUE,
            PGA_Freedom, LORIENT_VERT,
            TAG_END);  
        ng.ng_LeftEdge  = 510;
        ng.ng_TopEdge   = 160;
        ng.ng_Width     = 95;
        ng.ng_Height    = 15;
        ng.ng_GadgetText= "HELP!";
        ng.ng_GadgetID  = MYGAD_BUTTON;
        ng.ng_Flags     = 0;
        my_gads[MYGAD_BUTTON] = gad = CreateGadget(BUTTON_KIND, gad, &ng, TAG_END);
        ng.ng_TopEdge   = 190;
        ng.ng_Width     = 95;
        ng.ng_Height    = 15;
        ng.ng_GadgetText= "Generate";
        ng.ng_GadgetID  = MYGAD_BUTTON2;
        ng.ng_Flags     = 0;
        my_gads[MYGAD_BUTTON2] = gad = CreateGadget(BUTTON_KIND, gad, &ng,TAG_END);
        ng.ng_TopEdge   = 220;
        ng.ng_Width     = 95;
        ng.ng_Height    = 15;
        ng.ng_GadgetText= "Presets";
        ng.ng_GadgetID  = MYGAD_BUTTON3;
        ng.ng_Flags     = 0;
        gad = CreateGadget(BUTTON_KIND, gad, &ng,TAG_END);
return(gad);
}

void process_window_events(struct Window *mywin,
        WORD *slider_level, struct Gadget *my_gads[])
{        
        struct IntuiMessage *imsg;
        ULONG imsgClass;
        UWORD imsgCode;
        struct Gadget *gad;
        
                      
        while (!terminated)
        {
                Wait (1 << mywin->UserPort->mp_SigBit);
                while ((!terminated) &&
                    (imsg = GT_GetIMsg(mywin->UserPort)))
                {
                        gad = (struct Gadget *)imsg->IAddress;
                        
                        imsgClass = imsg->Class;
                        imsgCode = imsg->Code;
                        
                        GT_ReplyIMsg(imsg);
                                             
                        switch (imsgClass)
                        {
               
                                case IDCMP_CLOSEWINDOW:
                                    rast_port = mywin->RPort;
                                    terminated = TRUE;
                                    break;
                                case IDCMP_GADGETDOWN:
                                case IDCMP_MOUSEMOVE:
                                case IDCMP_GADGETUP:
                                    handleGadgetEvent(mywin, gad,
                                        imsgCode, slider_level, my_gads);
                                    break;
                                case IDCMP_REFRESHWINDOW:
                                    GT_BeginRefresh(mywin);
                                    GT_EndRefresh(mywin, TRUE);
                                    GT_RefreshWindow(mywin, NULL);

                                    //BeginRefresh(mywin);
                                    //EndRefresh(mywin, TRUE);
                                    break;
                                
                        }
               }
        }
//terminated = FALSE;
}

void Random_Window()
{  // everything for the stats window
        struct Window   *mywin;
        struct Gadget   *glist, *my_gads[19];
        void            *vi;
        WORD            slider_level = 0;
        UWORD           topborder;
        int             ctr;
        int             tot = 0;
        static int x, y, z, ctx, cty, spot;
        static int maxx;
        static int maxy;
        struct rtHandlerInfo *handle;
        //static char *a, *b;
                
        //int figctr[] = {
        //    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        //};
                    
   //for (ctr=0; ctr<=14; ctr++) {
   //     figctr[ctr] = slider_level;
   //OD 

   terminated = FALSE;
   mapgen = FALSE;
    
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
        vi = GetVisualInfo(map_screen, TAG_END);
        
        topborder = map_screen->WBorTop + (map_screen->Font->ta_YSize + 1);
         
       createAllGadgets(&glist, vi, slider_level, my_gads);
            //clean_exit(1,"createAllGadgets() failed");
 

   // do the window itself
        mywin = OpenWindowTags(NULL,
                      WA_Gadgets, glist, WA_AutoAdjust, TRUE,
                      WA_Title,"Random Map Generator",
                      WA_Top,100,    WA_Left,7,
                      WA_Width,612,  WA_Height,250,
                      WA_SimpleRefresh, TRUE,  
                      WA_IDCMP,IDCMP_CLOSEWINDOW|IDCMP_MOUSEBUTTONS
                        |IDCMP_GADGETUP|IDCMP_REFRESHWINDOW|SLIDERIDCMP
                        |BUTTONIDCMP,
                      WA_Flags,ACTIVATE|WFLG_DRAGBAR|WFLG_SMART_REFRESH
                        |WFLG_CLOSEGADGET,
                      WA_CustomScreen,map_screen,
                      TAG_END);

       if (mywin==NULL)
          clean_exit(1,"ERROR: Unable to open random window!");

       rast_port = mywin->RPort;

       for (ctr = 0; ctr<=14; ctr++) {
         SetAPen(rast_port,BLACK);
         px_outline_hex(5+30*ctr,15);
         if (terrain_index[ctr]<16)
             px_plot_hex(5+30*ctr,15,terrain_index[ctr]);
       OD
     
       for (ctr=0; ctr <=14; ctr++) {
           sprintf(foo,"%ld ",slider_level);
           plot_text(10+30*ctr,220,foo,BLACK,LT_GRAY,JAM2,&topaz11);
       OD



       frame(510,70,80,30,TRUE);
       sprintf(foo,"TOTAL");
       plot_text(530,66,foo,BLACK,LT_GRAY,JAM2,&topaz11);
       sprintf(foo,"0 ");
       plot_text(540,85,foo,BLUE,LT_GRAY,JAM2,&topaz11);


       GT_RefreshWindow(mywin, NULL);
                 
       process_window_events(mywin, &slider_level, my_gads);
                     
       // now clean everything up and leave
       
       rast_port = map_window->RPort;
       CloseWindow(mywin);
       mywin = NULL;
       FreeGadgets(glist);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);
       
       
       if (mapgen) {
           sprintf(foo,"Clearing current map and\nGenerating Random map.\nPlease wait...");
           handle = post_it(foo);      
           if (alloc_map(&me_grid)==FALSE)
                clean_exit(2,"ERROR: Fatal RAM allocation disaster!");
           int_grid(me_grid,HEX_UNEXPLORED);
           flood_map(t_grid,HEX_OCEAN);
           ME_draw_map();
           maxx = map_window->Width-map_window->BorderRight-16;
           maxy = map_window->Height-map_window->BorderBottom-12;
           z = width * height;
           cty = 0;
                    
           for (ctx=0; ctx<=14; ctx++) {    
                cty = 0;
                brush = terrain_index[ctx];
                if (figctr[ctx] == 0)
                     continue;
                spot = z * figctr[ctx] / 100;
                //sprintf(foo,"%ld",spot);
                //alert(map_window,NULL,foo,"Okay");
                while (cty<spot) {        
                     x = RangeRand(width);
                     y = RangeRand(height); 
                     
                     
                     while (x>=width || y>=height) {
                        x-=1;
                        y-=1;
                     OD
                     
                     while (get(me_grid,x,y)!=HEX_UNEXPLORED) {
                         x-=1;
                         y-=1;
                         if (x<=0 || y<=0) {
                             x = RangeRand(width);
                             y = RangeRand(height);
                             if (x>=width || y>=height) {
                                x = RangeRand(width);
                                y = RangeRand(height);
                             FI
                         FI
                     OD
                     
                     map_safe = FALSE;

                     // plot in and adjacent to a given hex
                     if(get(me_grid,x,y) == HEX_UNEXPLORED) {
                        //sprintf(bar,"*........");
                        //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                        put(t_grid,x,y,terrain_index[ctx]);
                        put(me_grid,x,y,terrain_index[ctx]);
                        cty++;
                        if (visibleP(x,y))
                            plot_hex(x,y,terrain_index[ctx]);
                     FI
                     if(x-1<=0)
                        continue;
                     if((cty<spot) && get(me_grid,x-1,y) == HEX_UNEXPLORED) {       
                        //sprintf(bar,".*.......");
                        //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                        put(t_grid,x-1,y,terrain_index[ctx]);
                        put(me_grid,x-1,y,terrain_index[ctx]);
                        cty++;
                        if (visibleP(x-1,y))
                            plot_hex(x-1,y,terrain_index[ctx]);
                     FI
                     if(x+1>=width)
                        continue;
                     if((cty<spot) && get(me_grid,x+1,y) == HEX_UNEXPLORED) {
                        //sprintf(bar,"..*......");
                        //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                        put(t_grid,x+1,y,terrain_index[ctx]);
                        put(me_grid,x+1,y,terrain_index[ctx]);
                        cty++;
                        if (visibleP(x+1,y))
                            plot_hex(x+1,y,terrain_index[ctx]);
                     FI
                     if(y-1<=0)
                        continue;
                     if((cty<spot) && get(me_grid,x,y-1) == HEX_UNEXPLORED) {
                        //sprintf(bar,"...*.....");
                        //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                        put(t_grid,x,y-1,terrain_index[ctx]);
                        put(me_grid,x,y-1,terrain_index[ctx]);
                        cty++;
                        if (visibleP(x,y-1))
                            plot_hex(x,y-1,terrain_index[ctx]);
                     FI
                     if(y+1>=height)
                        continue;
                     if((cty<spot) && get(me_grid,x,y+1) == HEX_UNEXPLORED) {
                        //sprintf(bar,"....*....");
                        //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                        put(t_grid,x,y+1,terrain_index[ctx]);
                        put(me_grid,x,y+1,terrain_index[ctx]);
                        cty++;
                        if (visibleP(x,y+1))
                            plot_hex(x,y+1,terrain_index[ctx]);
                     FI
                     if (y%2) {  /* i.e. if it's an odd-numbered column */
                        if(x+1>=width || y-1<=0)
                            continue;
                        if((cty<spot) && get(me_grid,x+1,y-1) == HEX_UNEXPLORED) {
                            //sprintf(bar,".....*...");
                            //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                            put(t_grid,x+1,y-1,terrain_index[ctx]);
                            put(me_grid,x+1,y-1,terrain_index[ctx]);
                            cty++;
                            if (visibleP(x+1,y-1))
                                plot_hex(x+1,y-1,terrain_index[ctx]);
                        FI
                        if(x+1>=width || y+1>=height)
                            continue;
                        if((cty<spot) && get(me_grid,x+1,y+1) == HEX_UNEXPLORED) {
                            //sprintf(bar,"......*..");
                            //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                            put(t_grid,x+1,y+1,terrain_index[ctx]);
                            put(me_grid,x+1,y+1,terrain_index[ctx]);
                            cty++;
                            if (visibleP(x+1,y+1))
                                plot_hex(x+1,y+1,terrain_index[ctx]);
                        FI
                     } else {
                        if(x-1<=0 || y-1<=0)
                            continue;
                        if((cty<spot) && get(me_grid,x-1,y-1) == HEX_UNEXPLORED) {
                            //sprintf(bar,".......*.");
                            //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                            put(t_grid,x-1,y-1,terrain_index[ctx]);
                            put(me_grid,x-1,y-1,terrain_index[ctx]);
                            cty++;
                            if (visibleP(x-1,y-1))
                                plot_hex(x-1,y-1,terrain_index[ctx]);
                        FI
                        if(x-1<=0 || y+1>=height)
                            continue;
                        if((cty<spot) && get(me_grid,x-1,y+1) == HEX_UNEXPLORED) {
                            //sprintf(bar,"........*");
                            //plot_text(540,20,bar,LT_BLUE,BLACK,JAM2,&topaz11);
                            put(t_grid,x-1,y+1,terrain_index[ctx]);
                            put(me_grid,x-1,y+1,terrain_index[ctx]);
                            cty++;
                            if (visibleP(x-1,y+1))
                                plot_hex(x-1,y+1,terrain_index[ctx]);
                        FI
                     FI
                    
                     
                     
                          
                OD
                        
                //tot_hex -= figctr[ctx];
                //figctr[ctx] -= 1;
           OD                           
                        
                
             
             
             brush = HEX_PLAINS;
             {  // set the MX menu items to reflect this change
                struct MenuItem *item;
                int ctr;

                item = ItemAddress(editor_menu_strip,FULLMENUNUM(1,2,0));
                for (ctr = 1; ctr<=16; ctr++) {
                   if (ctr==brush)
                       item->Flags |= CHECKED;
                   else
                       item->Flags &= ~CHECKED;
                   item = item->NextItem;
                OD
             }

                
             for (ctr=0; ctr<=14; ctr++) {
                figctr[ctr] = 0;
                   
             OD
             
                          
             tot=0;
             alert(map_window,NULL,"Map Generated!","Okay");
             do_city(); 
             unpost_it(handle);
       FI
       mapgen = FALSE;
}

void do_presets()
{
   struct Window *presets_window = NULL;
   struct Gadget *context, *map_slide, *ok_gad, *help_gad, *cancel_gad;
   struct Gadget *s1_gad, *s2_gad, *s3_gad;
   struct NewGadget generic = {
      6,30,      // leftedge, topedge
      57,15,   // width, height
      "Okay",  // text label
      &topaz11bold,    // font
      3,       // gadget ID
      NULL,NULL,NULL
   };
   struct NewGadget slider = {
      40,20,
      125,13,
      NULL,
      &topaz11,
      5,
      NULL,
      NULL, NULL
   };
   
    
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   slider.ng_VisualInfo = vi;
   map_slide = CreateGadget(SLIDER_KIND,context,&slider,
      GTSL_Min, 0,
      GTSL_Max, 100,
      GTSL_Level, 0,
      GA_RelVerify, TRUE,
      TAG_END);
   generic.ng_VisualInfo = vi;
   generic.ng_TextAttr = &topaz11;
   generic.ng_TopEdge += 17;
   generic.ng_GadgetText = "Desert";
   s1_gad = CreateGadget(BUTTON_KIND,map_slide,&generic,TAG_END);
   generic.ng_TopEdge += 17;
   generic.ng_GadgetText = "Jungle";
   s2_gad = CreateGadget(BUTTON_KIND,s1_gad,&generic,TAG_END);
   generic.ng_TopEdge += 17;
   generic.ng_GadgetText = "Water";
   s3_gad = CreateGadget(BUTTON_KIND,s2_gad,&generic,TAG_END);
   generic.ng_TopEdge += 17;
   generic.ng_TextAttr = &topaz11bold;
   generic.ng_GadgetText = "OK";
   ok_gad = CreateGadget(BUTTON_KIND,s3_gad,&generic,TAG_END);
   generic.ng_LeftEdge += 66;
   generic.ng_TextAttr = &topaz11;
   generic.ng_GadgetText = "HELP!";
   help_gad = CreateGadget(BUTTON_KIND,ok_gad,&generic,TAG_END);
   generic.ng_LeftEdge += 66;
   generic.ng_GadgetText = "Cancel";
   cancel_gad = CreateGadget(BUTTON_KIND,help_gad,&generic,TAG_END);
 
   // do the window itself
   presets_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Map Presets Creator",
      WA_Top,100,    WA_Left,200,
      WA_Width,212,  WA_Height,125,
      WA_IDCMP,IDCMP_CLOSEWINDOW|IDCMP_VANILLAKEY|IDCMP_MOUSEBUTTONS|IDCMP_GADGETUP,
      WA_Flags,NOCAREREFRESH|WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
      WA_CustomScreen,map_screen,
      TAG_END );
   if (presets_window==NULL)
      clean_exit(1,"ERROR: Unable to open presets window!");
   rast_port = presets_window->RPort;

   sprintf(foo,"0");
   plot_text(5+95,50,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   
   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      //struct MenuItem *item;
      //int ctr;
            
      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;

      while (TRUE) {
         WaitPort(presets_window->UserPort);
         while (message = GT_GetIMsg(presets_window->UserPort)) {
            code = message->Code;  
            object = message->IAddress;  
            class = message->Class;
            GT_ReplyIMsg(message);
            //if (class==MOUSEBUTTONS && code==SELECTDOWN)
            //   new_terrain(message->MouseX,message->MouseY);
            if (class==IDCMP_VANILLAKEY && code==13) {
                mycity = TRUE;
                goto exit_presets_window;
            FI
            if (class==GADGETUP) {
               if (object==map_slide) {
                 GT_SetGadgetAttrs(NULL, presets_window,NULL,
                    GTIN_Number, code,
                    TAG_END);
                 tot = code;
                 sprintf(foo,"%ld ",tot);
                 plot_text(5+95,50,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                 if (tot >= 1)
                    mycity = TRUE; 
               FI   
               if (object==s1_gad) 
                  alert(presets_window,NULL,"Not implemented yet!","RATS!"); 
               if (object==s2_gad)
                  alert(presets_window,NULL,"Not implemented yet!","RATS!");
               if (object==s3_gad)
                  alert(presets_window,NULL,"Not implemented yet!","RATS!");
               if (object==ok_gad) {
                  mycity = TRUE;
                  goto exit_presets_window;
               FI             
               if (object==help_gad) {
                  sprintf(foo,"Slider selects terrain amount.\n\n");
                  strcat(foo,"Ok button will create Preset.\n\n");
                  strcat(foo,"Cancel button will cancel this option.");
                  alert(presets_window,NULL,foo,"Okay");
               FI       
               if (object==cancel_gad) {
                  mycity = FALSE;
                  goto exit_presets_window;
               FI 
            FI
            if (class==CLOSEWINDOW) {
               mycity = FALSE;
               goto exit_presets_window;
            FI
         OD
      OD
   }
   exit_presets_window:


   // now clean everything up and leave
       rast_port = map_window->RPort;
       CloseWindow(presets_window);
       presets_window = NULL;
       FreeGadgets(context);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);
   
}

void do_city()
{
   struct Window *mycity_window = NULL;
   struct Gadget *context, *city_string, *cityport_string, *plus_gad, *minus_gad, *plusport_gad, *minusport_gad, *ok_gad, *help_gad, *cancel_gad;
   struct NewGadget generic = {
      6,100,      // leftedge, topedge
      15,15,   // width, height
      "Okay",  // text label
      &topaz11bold,    // font
      3,       // gadget ID
      NULL,NULL,NULL
   };
   struct NewGadget stringfield = {
      40,20,
      125,16,
      NULL,
      &topaz11,
      2,
      PLACETEXT_LEFT,
      NULL,NULL
   };
   static int x, y, zot;
   static int maxx, maxy;
   
   tot = 0;
   totP = 0;
    
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   stringfield.ng_VisualInfo = vi;
   strcpy(foo,"0");
   city_string = CreateGadget(STRING_KIND,context,&stringfield,
      GTST_String, foo,
      GTST_MaxChars, 128L,
      STRINGA_Justification, GACT_STRINGCENTER,
      TAG_END);
   stringfield.ng_TopEdge +=40;
   strcpy(foo,"0");
   cityport_string = CreateGadget(STRING_KIND,city_string,&stringfield,
      GTST_String, foo,
      GTST_MaxChars, 128L,
      STRINGA_Justification, GACT_STRINGCENTER,
      TAG_END);
   generic.ng_VisualInfo = vi;
   generic.ng_TextAttr = &topaz11;
   generic.ng_LeftEdge = 24;
   generic.ng_TopEdge = 20;
   generic.ng_GadgetText = "-";
   minus_gad = CreateGadget(BUTTON_KIND,cityport_string,&generic,TAG_END);
   generic.ng_LeftEdge = 165;
   generic.ng_TopEdge = 20;
   generic.ng_GadgetText = "+";
   plus_gad = CreateGadget(BUTTON_KIND,minus_gad,&generic,TAG_END);
   generic.ng_LeftEdge = 24;
   generic.ng_TopEdge += 40;
   generic.ng_GadgetText = "-";
   minusport_gad = CreateGadget(BUTTON_KIND,plus_gad,&generic,TAG_END);
   generic.ng_LeftEdge = 165;
   generic.ng_GadgetText = "+";
   plusport_gad = CreateGadget(BUTTON_KIND,minusport_gad,&generic,TAG_END);
   generic.ng_LeftEdge = 11;
   generic.ng_TopEdge = 100;
   generic.ng_Width = 57;
   generic.ng_GadgetText = "OK";
   ok_gad = CreateGadget(BUTTON_KIND,plusport_gad,&generic,TAG_END);
   generic.ng_LeftEdge += 66;
   generic.ng_GadgetText = "HELP!";
   help_gad = CreateGadget(BUTTON_KIND,ok_gad,&generic,TAG_END);
   generic.ng_LeftEdge += 66;
   generic.ng_GadgetText = "Cancel";
   cancel_gad = CreateGadget(BUTTON_KIND,help_gad,&generic,TAG_END);
 
   // do the window itself
   mycity_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Sprinkle Cities",
      WA_Top,100,    WA_Left,200,
      WA_Width,212,  WA_Height,125,
      WA_IDCMP,IDCMP_CLOSEWINDOW|IDCMP_VANILLAKEY|IDCMP_MOUSEBUTTONS|IDCMP_GADGETUP,
      WA_Flags,NOCAREREFRESH|WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
      WA_CustomScreen,map_screen,
      TAG_END );
   if (mycity_window==NULL)
      clean_exit(1,"ERROR: Unable to open city window!");
   rast_port = mycity_window->RPort;

   //sprintf(foo,"0");
   //plot_text(5+95,50,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"Number of LAND Cities");
   plot_text(5+15,40,foo,BLUE,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"Number of PORT Cities");
   plot_text(5+15,80,foo,BLUE,LT_GRAY,JAM2,&topaz11);
   
   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      //struct MenuItem *item;
      //int ctr;
            
      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;

      while (TRUE) {
         WaitPort(mycity_window->UserPort);
         while (message = GT_GetIMsg(mycity_window->UserPort)) {
            code = message->Code;  
            object = message->IAddress;  
            class = message->Class;
            GT_ReplyIMsg(message);
            //if (class==MOUSEBUTTONS && code==SELECTDOWN)
            //   new_terrain(message->MouseX,message->MouseY);
            if (class==IDCMP_VANILLAKEY && code==13) {
                mycity = TRUE;
                goto exit_mycity_window;
            FI
            if (class==GADGETUP) {
               if (object==city_string) {
               //  GT_SetGadgetAttrs(city_string, mycity_window,NULL,
               //     GTST_String, code,
               //     TAG_END);
                 tot = atoi(((struct StringInfo *)city_string->SpecialInfo)->Buffer);
               //  tot = atoi(foo);
               //  sprintf(foo,"%ld ",tot);
               //  plot_text(5+95,50,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                 if (tot >= 1)
                    mycity = TRUE; 
               FI   
               if (object==cityport_string) {
               //  GT_SetGadgetAttrs(cityport_string, mycity_window,NULL,
               //     GTST_String, code,
               //     TAG_END);
                 totP = atoi(((struct StringInfo *)cityport_string->SpecialInfo)->Buffer);
               //  totP = atoi(foo);
               //  sprintf(foo,"%ld ",totP);
               //  plot_text(5+95,50,foo,BLACK,LT_GRAY,JAM2,&topaz11);
                 if (totP >= 1)
                    mycity = TRUE; 
               FI   
               if (object==minus_gad) {
                  tot -= 1;
                  if (tot < 0)
                        tot = 0;
                  sprintf(foo,"%ld",tot);
                  GT_SetGadgetAttrs(city_string,mycity_window,NULL,
                        GTST_String, foo,
                        TAG_DONE);
               FI
               if (object==plus_gad) {
                  tot += 1;
                  if (tot < 0)
                        tot = 0;
                  sprintf(foo,"%ld",tot);
                  GT_SetGadgetAttrs(city_string,mycity_window,NULL,
                        GTST_String, foo,
                        TAG_DONE);
                  mycity = TRUE;
               FI
               if (object==minusport_gad) {
                  totP -= 1;
                  if (totP < 0)
                        totP = 0;
                  sprintf(foo,"%ld",totP);
                  GT_SetGadgetAttrs(cityport_string,mycity_window,NULL,
                        GTST_String, foo,
                        TAG_DONE);
               FI
               if (object==plusport_gad) {
                  totP += 1;
                  if (totP < 0)
                        totP = 0;
                  sprintf(foo,"%ld",totP);
                  GT_SetGadgetAttrs(cityport_string,mycity_window,NULL,
                        GTST_String, foo,
                        TAG_DONE);
                  mycity = TRUE;
               FI
               if (object==ok_gad) {
                  mycity = TRUE;
                  goto exit_mycity_window;
               FI             
               if (object==help_gad) {
                  sprintf(foo,"Slider selects number \nof cities to sprinkle.\n\n");
                  strcat(foo,"Ok button will sprinkle cities.\n\n");
                  strcat(foo,"Cancel button will cancel this option.");
                  alert(mycity_window,NULL,foo,"Okay");
               FI       
               if (object==cancel_gad) {
                  mycity = FALSE;
                  goto exit_mycity_window;
               FI 
            FI
            if (class==CLOSEWINDOW) {
               mycity = FALSE;
               goto exit_mycity_window;
            FI
         OD
      OD
   }
   exit_mycity_window:


   // now clean everything up and leave
       rast_port = map_window->RPort;
       CloseWindow(mycity_window);
       mycity_window = NULL;
       FreeGadgets(context);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);
   
   if(mycity) {
       int num_hexes = 0;
       int ctr=0;
      
       
       maxx = map_window->Width-map_window->BorderRight-16;
       maxy = map_window->Height-map_window->BorderBottom-12;
   
       for (zot=0; zot<tot; zot++) {
         Top:
           x = RangeRand(width);
           y = RangeRand(height);
             
           //while (x>=width || y>=height) {
           //    x = RangeRand(width);
           //    y = RangeRand(height);
           //OD
           
           while (get(t_grid,x,y) >= HEX_PEAKS && get(t_grid,x,y) <= HEX_CITY) {
               x = RangeRand(width);
               y = RangeRand(height);
           OD  
           num_hexes = adjacent(x,y);
           for (; ctr<num_hexes; ctr++)
                switch (get(t_grid,hexlist[ctr].col,hexlist[ctr].row)) {
                        case HEX_PLAINS:
                        case HEX_DESERT:
                        case HEX_BRUSH:
                        case HEX_FOREST:
                        case HEX_JUNGLE:
                        case HEX_RUGGED:
                        case HEX_HILLS:
                        case HEX_MOUNTAINS:
                                goto Build_me;
                OD
              
           Build_me:                                                              
                create_city(x,y);
                plot_city(x,y,WHITE,FALSE);
                map_safe = FALSE;
                if (!city_hereP(x,y)) 
                      goto Top;
       OD 
                                                                                
       for (zot=0; zot<totP; zot++) {
         Top2:
           x = RangeRand(width);
           y = RangeRand(height);
             
           //while (x>=width || y>=height) {
           //    x = RangeRand(width);
           //    y = RangeRand(height);
           //OD
           
           while (get(t_grid,x,y) >= HEX_PEAKS && get(t_grid,x,y) <= HEX_CITY) {
               x = RangeRand(width);
               y = RangeRand(height);
           OD  
           num_hexes = adjacent(x,y);
           for (; ctr<num_hexes; ctr++)
                switch (get(t_grid,hexlist[ctr].col,hexlist[ctr].row)) {
                        case HEX_SHALLOWS:
                        case HEX_OCEAN:
                        case HEX_DEPTH:
                                goto Build_me2;
                OD
              
           Build_me2:                                                              
                create_city(x,y);
                plot_city(x,y,WHITE,FALSE);
                map_safe = FALSE;
                if (!city_hereP(x,y)) 
                      goto Top2;
       OD 
        
   mycity = FALSE;     
   tot = 0;
   totP = 0;
   alert(map_window,NULL,"Cities Sprinkled!","Okay");
   FI 
}



void menu_select_terrain()
{  // handle terrain selection directly from the MX menu items
   struct MenuItem *item;
   int ctr;

   item = ItemAddress(editor_menu_strip,FULLMENUNUM(1,2,0));
   for (ctr = 1; ctr<=17; ctr++) {
      if ((item->Flags & CHECKED)!=NULL)
         brush = ctr;
      item = item->NextItem;
   OD
}

// end of the terrain selection area

void build_editor_menu()
{
   struct NewMenu new_menu_strip[]  = {
      { NM_TITLE, "Project", NULL, 0, NULL, NULL },
      { NM_ITEM, "Load Map...", "L", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Save Map...", "S", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Resize Map...", "R", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Clear Map", "C", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Exit Map Editor", "X", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Quit Program", "Q", ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Terrain", NULL, 0, NULL, NULL },
      { NM_ITEM, "Toolbar   [SPC]", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "PLAINS", NULL, CHECKIT|MENUTOGGLE|CHECKED,~4, NULL },
      { NM_ITEM, "DESERT", NULL, CHECKIT|MENUTOGGLE,~8, NULL },
      { NM_ITEM, "FORBID", NULL, CHECKIT|MENUTOGGLE,~16, NULL },
      { NM_ITEM, "BRUSH", NULL, CHECKIT|MENUTOGGLE,~32, NULL },
      { NM_ITEM, "FOREST", NULL, CHECKIT|MENUTOGGLE,~64, NULL },
      { NM_ITEM, "JUNGLE", NULL, CHECKIT|MENUTOGGLE,~128, NULL },
      { NM_ITEM, "RUGGED", NULL, CHECKIT|MENUTOGGLE,~256, NULL },
      { NM_ITEM, "HILLS", NULL, CHECKIT|MENUTOGGLE,~512, NULL },
      { NM_ITEM, "MOUNTAINS", NULL, CHECKIT|MENUTOGGLE,~1024, NULL },
      { NM_ITEM, "PEAKS", NULL, CHECKIT|MENUTOGGLE,~2048, NULL },
      { NM_ITEM, "SWAMP", NULL, CHECKIT|MENUTOGGLE,~4096, NULL },
      { NM_ITEM, "SHALLOWS", NULL, CHECKIT|MENUTOGGLE,~8192, NULL },
      { NM_ITEM, "OCEAN", NULL, CHECKIT|MENUTOGGLE,~16384, NULL },
      { NM_ITEM, "DEPTHS", NULL, CHECKIT|MENUTOGGLE,~32768, NULL },
      { NM_ITEM, "ICE", NULL, CHECKIT|MENUTOGGLE,~65536, NULL },
      { NM_ITEM, "CITY", NULL, CHECKIT|MENUTOGGLE,~131072, NULL },
      { NM_ITEM, "ROAD", NULL, CHECKIT|MENUTOGGLE,~262144, NULL },
      { NM_ITEM, NM_BARLABEL, NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Info         I ", NULL, ITEMTEXT, NULL, NULL },
      { NM_TITLE, "Other", NULL, 0, NULL, NULL },
      { NM_ITEM, "World View     ", NULL, ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Random Map     ", "M", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Statistics     ", "I", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Sprinkle Cities", "K", ITEMTEXT, NULL, NULL },
      { NM_ITEM, "Connect Cities ", "T", ITEMTEXT, NULL, NULL },
      { NM_END, NULL, NULL, NULL, NULL, NULL }
   };

   if (!(editor_menu_strip = CreateMenus(new_menu_strip,GTMN_FrontPen,BLACK,TAG_END)))
      clean_exit(1,"ERROR: Unable to create map editor menu strip!");

   if (!(LayoutMenus(editor_menu_strip,vi,TAG_END)))
      clean_exit(1,"ERROR: Unable to layout map editor menus!");
}

BOOL user_plopcity(col,row)
int col, row;
{  // look out map, here come city!
   int locale = get(t_grid,col,row);
   struct City *metro;

   switch (locale) {
      case HEX_FORBID:  
      case HEX_PEAKS:
      case HEX_SWAMP:
      case HEX_SHALLOWS:
      case HEX_OCEAN:
      case HEX_DEPTH:
      case HEX_ICE:
         playSound(DONK_SOUND,64);
         (void)rtEZRequestTags("You cannot build a city on that terrain.",
            "Cancel",NULL,NULL,
            RT_Window,        map_window,
            RT_ReqPos,        REQPOS_CENTERSCR,
            RT_LockWindow,    TRUE,
            RTEZ_Flags,       EZREQF_CENTERTEXT,
            TAG_DONE );
         return FALSE;
      default:
         if (metro = city_hereP(col,row)) {
            ULONG result;
            char buffer[20];

            outline_hex(col,row,WHITE);
            sprintf(foo,"Row: %ld  Column: %ld",metro->row,metro->col);
            (void)strcpy(buffer,metro->name);
            result = rtGetString(buffer,19,"City Information",NULL,
               RTGS_TextFmt, foo,
               RT_DEFAULT, TAG_END);
            if (result) {
               (void)strcpy(metro->name,buffer);
               map_safe = FALSE;
            FI
            outline_hex(col,row,BLACK);
            return FALSE;
         } else {
            create_city(col,row);
            plot_city(col,row,WHITE,FALSE);
            map_safe = FALSE;
            return TRUE;
         FI
   }
}

void user_plot(x,y,qual)
int x,y;
UWORD qual;
{  // the user plots a terrain hex with his mouse
   int col, row;
   int maxx = map_window->Width-map_window->BorderRight-16;
   int maxy = map_window->Height-map_window->BorderBottom-12;
   int lbrush = brush;  // local brush for this function only

   if (x>=maxx || y>=maxy)
      return;
   /*
      The behavior of this function will vary depening on whether the current
      brush is a city.  Then the editor is in "city mode" as opposed to "terrain"
      mode.  In city mode the cursor can create cities (or with SHIFT delete them),
      while leaving terrain undisturbed.  But when in terrain mode the cursor can
      draw the current terrain (or with SHIFT draw ocean) while not molesting the
      cities.
   */
   abs_to_log(x,y,&col,&row);
   if (!visibleP(col,row))
      return;

   /*
      This is quick-hack code for creating roads, just so I can see how they
      look, graphically.  The user is holding down CONTROL, so it pops a road
      flag into the specified hex.
   */

   //if (qual & IEQUALIFIER_CONTROL) {
   if (lbrush==HEX_ROADS) {
      int flag = get_flags(t_grid,col,row);
      struct City *metro=city_hereP(col,row);

      if (flag) {
         flag = flag & (~ROAD);  // remove road from this hex
         put_flags(t_grid,col,row,flag);
         plot_hex(col,row,get(t_grid,col,row));
         if (metro) {
            plot_city(col,row,0,FALSE);
            Remove((APTR)metro);
            AddTail((APTR)&city_list,(APTR)metro);
         }
      } else {
         flag = flag | ROAD;     // add road to this hex
         put_flags(t_grid,col,row,flag);
         ME_draw_roads(col,row);
         if (metro) {
            plot_city(col,row,0,FALSE);
            Remove((APTR)metro);
            AddHead((APTR)&city_list,(APTR)metro);
         }
      FI
      Delay(10L);    // key de-bounce
      return;
   }


   if (lbrush==HEX_CITY) {           // this means the editor is in "city mode"
      if (city_hereP(col,row) && (qual & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))) {
            map_safe = FALSE;
            remove_city(col,row);
            plot_hex(col,row,get(t_grid,col,row));
      } else
         (void)user_plopcity(col,row);
   } else {                        // terrain mode
      if (qual & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
         lbrush = HEX_OCEAN;  // can change this and not worry
      if (lbrush!=get(t_grid,col,row)) {
         if (city_hereP(col,row) && lbrush>HEX_MOUNTAINS) {
            // it sure looks like the user is trying to slip an invalid
            // hex type underneath an already existing city
            playSound(DONK_SOUND,64);
            if (rtEZRequestTags("You cannot put that kind of terrain\nunderneath a city.",
               "  Abort  |Kill City",NULL,NULL,
               RT_Window,        map_window,
               RT_ReqPos,        REQPOS_CENTERSCR,
               RT_LockWindow,    TRUE,
               RTEZ_Flags,       EZREQF_CENTERTEXT,
               TAG_DONE ))
               return;
            else
               remove_city(col,row);
         FI
         map_safe = FALSE;
         put(t_grid,col,row,lbrush);
         plot_hex(col,row,lbrush);
         if (city_hereP(col,row))
            plot_city(col,row,WHITE,FALSE);
      FI
   FI
}


void initialize_editor()
{
   if (!editor_menu_strip)
      build_editor_menu();    // prepare the drop-down menus for use

   // initialize some map stuff
   wrap = FALSE;
   width = MIN_WD;
   height = MIN_HT;
   if (alloc_map(&t_grid)==FALSE)
      clean_exit(2,"ERROR: Fatal RAM allocation disaster!");
   Move(rast_port,0,0);    ClearScreen(rast_port);
   flood_map(t_grid,HEX_OCEAN);     // default starting conditions
   xoffs = yoffs = 0;
   update_scrollers();
   ME_draw_map();
   map_safe = TRUE;
}


void editor_menu()
{
   struct IntuiMessage *message; // the message the IDCMP sends us
   static int col, row;
        
   // useful for interpreting IDCMP messages
   UWORD code;
   ULONG class;
   APTR object;
   UWORD qualifier;

   // attach the menu to my window
   SetMenuStrip(map_window,editor_menu_strip);

   // Enable menus one and two.
   OnMenu(map_window,FULLMENUNUM(0,-1,0));
   OnMenu(map_window,FULLMENUNUM(1,-1,0));
   OnMenu(map_window,FULLMENUNUM(2,-1,0));

   OffMenu(map_window,FULLMENUNUM(2,4,0));

   while (TRUE) {
      WaitPort(map_window->UserPort);
      while (message = GT_GetIMsg(map_window->UserPort)) {
         code = message->Code;  // MENUNUM
         object = message->IAddress;  // Gadget
         class = message->Class;
         qualifier = message->Qualifier;
         GT_ReplyIMsg(message);
         if (class==IDCMP_GADGETUP) {
            int ox = xoffs, oy = yoffs;

            if (scrolly(object,code))
               ME_smart_scroll(ox,oy);
         FI
         if (class==IDCMP_RAWKEY) {
            int ox = xoffs, oy = yoffs;
            int wo = (wrap ? WRAP_OVERLAP : 0);

            switch (code) {
               case 0x4C:  // up cursor
                  yoffs--;
                  if (qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
                     yoffs -= disp_ht;
                  if (qualifier & IEQUALIFIER_CONTROL)
                     yoffs = -wo;
                  if (yoffs < -wo)
                     yoffs = -wo;
                  break;
               case 0x4D:  // down cursor
                  yoffs++;
                  if (qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
                     yoffs += disp_ht;
                  if (qualifier & IEQUALIFIER_CONTROL)
                     yoffs = height-(disp_ht-wo);
                  if (yoffs>height-(disp_ht-wo))
                     yoffs = height-(disp_ht-wo);
                  break;
               case 0x4F:  // left cursor
                  xoffs--;
                  if (qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
                     xoffs -= disp_wd;
                  if (qualifier & IEQUALIFIER_CONTROL)
                     xoffs = -wo;
                  if (xoffs < -wo)
                     xoffs = -wo;
                  break;
               case 0x4E:  // right cursor
                  xoffs++;
                  if (qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT))
                     xoffs += disp_wd;
                  if (qualifier & IEQUALIFIER_CONTROL)
                     xoffs = width-(disp_wd-wo);
                  if (xoffs>width-(disp_wd-wo))
                     xoffs = width-(disp_wd-wo);
            }
            update_scrollers();
            ME_smart_scroll(ox,oy);
         FI
         if (class==IDCMP_MOUSEMOVE) {
            abs_to_log(message->MouseX,message->MouseY,&col,&row);
            sprintf(bar,"Map Editor v5.9d                                      Hex Coords: %ld / %ld",col+1,row+1);
            //plot_text(250,15,"         ",WHITE,NULL,JAM1,&topaz11);
            //plot_text(250,15,foo,WHITE,NULL,JAM1,&topaz11);
            SetWindowTitles(map_window,bar, (UBYTE *)~0);
            
         FI
         if (class==IDCMP_MOUSEBUTTONS && code==SELECTDOWN)
            if (qualifier & IEQUALIFIER_CONTROL) {
               int storebrush = brush;
               brush = HEX_CITY;
               user_plot(message->MouseX,message->MouseY,qualifier);  // plot city
               brush = storebrush;
            } else
               user_plot(message->MouseX,message->MouseY,qualifier);
         if (class==IDCMP_MOUSEMOVE && brush!=HEX_CITY && left_buttonP())
            if (object != vert_scroller && object != horz_scroller)    
                user_plot(message->MouseX,message->MouseY,qualifier);
         if (class==IDCMP_VANILLAKEY && code==' ') {
                //code = ' ';
                do_terrain_window();
                while (INFO) {
                    do_info_window();
                    do_terrain_window();
                    continue;
                OD
         FI
         if (class==MOUSEBUTTONS && code==MIDDLEDOWN) {
                do_terrain_window();
                while (INFO) {
                    do_info_window();
                    do_terrain_window();
                    continue;
                OD
         FI
         
         if (class==IDCMP_VANILLAKEY && code=='i') 
                do_info_window();
         if (class==IDCMP_MENUPICK) {  // MenuItems
            OffMenu(map_window,FULLMENUNUM(0,-1,0));
            OffMenu(map_window,FULLMENUNUM(1,-1,0));
            switch (MENUNUM(code)) {
               case 0:  // [Project] menu
                  switch (ITEMNUM(code)) {
                     case 0:  // load map...
                        MEdit = TRUE;
                        if (!map_safe)
                                if (alert(map_window,"Load Map","Your map is not saved!\nAre you sure you want to Load another?","Cancel|Load"))
                                        break;
                        strcpy(map_filename,"");
                        rt_loadsave_map(LOAD);
                        break;
                     case 1:  // save map...
                        MEdit = TRUE;
                        strcpy(map_filename,"Untitled.MAP");
                        rt_loadsave_map(SAVE);
                        break;
                     case 2:  // resize map...
                        map_size_request();
                        break;
                     case 3:  // clear map
                        if (brush==HEX_CITY || HEX_ROADS) {
                           playSound(DONK_SOUND,64);
                           (void)alert(map_window,NULL,"I can't flood the map with that terrain!","Cancel");
                        } else {
                           flood_map(t_grid,brush);
                           ME_draw_map();
                          map_safe = TRUE;
                        FI
                        break;
                     case 4:  // Exit Map Editor
                        if (map_safe)
                           return;
                        if (alert(map_window,"Exit Map Editor","Your map is not saved!\nAre you sure you want to leave the editor?","Exit|Cancel"))
                           return;
                        break;
                     case 5:  // Quit
                        if (map_safe)
                            quit_program();
                        else
                            if (alert(map_window,"Exit Map Editor","Your map is not saved!\nAre you sure you want to QUIT the program?","Quit|Cancel"))
                               clean_exit(0,NULL);

                  }
                  break;
               case 1:  // [Terrain] menu
                  if (ITEMNUM(code)==0) {
                      //class = IDCMP_VANILLAKEY;
                      //code = ' ';
                      do_terrain_window();
                      while (INFO) {
                         do_info_window();
                         do_terrain_window();
                         continue;
                      OD
                  FI
                  if (ITEMNUM(code)>1)
                      menu_select_terrain();
                  if (ITEMNUM(code)>=18)
                      do_info_window();
                  break;
               case 2:  // [Other] menu
                  if (ITEMNUM(code)==0)
                     ME_world_view();
                  if (ITEMNUM(code)==1)
                     Random_Window();
                  if (ITEMNUM(code)==2)
                     do_stats_window();
                  if (ITEMNUM(code)==3)
                     do_city();
                  if (ITEMNUM(code)==4)
                     do_connect();
            }
            // editor_menu_strip->Flags = MENUENABLED;
            OnMenu(map_window,FULLMENUNUM(0,-1,0));
            OnMenu(map_window,FULLMENUNUM(1,-1,0));
            OnMenu(map_window,FULLMENUNUM(2,-1,0));
         FI
      OD
   OD
}


void map_editor()
{
   // having just arrived here from the main program module,
   // first thing is detach the main menu strip
   ClearMenuStrip(map_window);
   // change the title so the user knows where he is
   SetWindowTitles(map_window,"Map Editor v5.9d",(UBYTE *)~0);
   ModifyIDCMP(map_window,IDCMP_MAPEDIT);
   ReportMouse(TRUE,map_window);
   MEdit = TRUE;
   initialize_editor();
   editor_menu();

   // wipe out the map
   nuke_list(&city_list);
   free_map(&t_grid);
   free_map(&me_grid);
   Move(rast_port,0,0);    ClearScreen(rast_port);
   wrap = FALSE;
   MEdit = FALSE;
   zero_scrollers();
   // reset the title for the main module
   SetWindowTitles(map_window,"Top Level",(UBYTE *)~0);
   ReportMouse(FALSE,map_window);
   ModifyIDCMP(map_window,IDCMP_MENUPICK);
   // remove the map editor drop-down menus
   ClearMenuStrip(map_window);
   // re-attach the main menu strip before returning to the main module
   ResetMenuStrip(map_window,main_menu_strip);

   // free the menus which are no longer needed
   if (editor_menu_strip) {
      FreeMenus(editor_menu_strip);
      editor_menu_strip = NULL;
   FI
}

// end of listing
