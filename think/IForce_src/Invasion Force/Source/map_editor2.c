/*
   map_editor2.c -- map editor module for Invasion Force
   This module provides the Invasion Force map editor.
   This source code is free.  You may make as many copies as you like.
*/

// standard header for all program modules
#include "global.h"
#include "gadgets_protos.h"

int myctr[] = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};




void do_stats_window()
{  // everything for the stats window
   struct Window *stats_window = NULL;
   struct Gadget *context, *ok_gad;
   struct NewGadget generic = {
      515,25,      // leftedge, topedge
      66,16,   // width, height
      "Okay",  // text label
      NULL,    // font
      3,       // gadget ID
      NULL,NULL,NULL
   };
   int tot_hex, ctr, ctx, cty;
   static int z, pcx, pcz;
   static float pcy; 
   
   int myctr[] = {
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   };
    
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);

   // create the gadgets
   if (!CreateContext(&context))
      clean_exit(1,"Unable to create context gadget!");
   generic.ng_VisualInfo = vi;
   generic.ng_TextAttr = &topaz11bold;
   generic.ng_LeftEdge += 5;
   generic.ng_GadgetText = "OK";
   ok_gad = CreateGadget(BUTTON_KIND,context,&generic,TAG_END);

   // do the window itself
   stats_window = OpenWindowTags(NULL,
      WA_Gadgets,context,
      WA_Title,"Map Statistics",
      WA_Top,90,    WA_Left,7,
      WA_Width,612,  WA_Height,300,
      WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_CLOSEWINDOW|IDCMP_MOUSEBUTTONS|IDCMP_GADGETUP,
      WA_Flags,NOCAREREFRESH|WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
      WA_CustomScreen,map_screen,
      TAG_END );
   if (stats_window==NULL)
      clean_exit(1,"ERROR: Unable to open stats window!");
   rast_port = stats_window->RPort;

   tot_hex = width * height; 
   sprintf(foo,"Total number of hexes: %ld",tot_hex);
   plot_text(5+15,16,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   sprintf(foo,"Total of each terrain type:");
   plot_text(5+130,28,foo,WHITE,LT_GRAY,JAM2,&topaz11);
    
   for (ctr = 0; ctr<=15; ctr++) {
       SetAPen(rast_port,BLACK);
       if (terrain_index[ctr]<9) {
           px_outline_hex(5+30,40+32*ctr);
           px_plot_hex(5+30,40+32*ctr,terrain_index[ctr]);
       FI
       if (terrain_index[ctr]>=9 && terrain_index[ctr] <16) {
           px_outline_hex(5+260,40+32*(ctr-8)); 
           px_plot_hex(5+260,40+32*(ctr-8),terrain_index[ctr]);
       FI
   OD
   // blit in the city
   px_outline_hex(5+260,264);
   px_plot_hex(5+260,264,HEX_PLAINS);
   px_plot_city(272,272);

   bevel_box(70,40,190,255,TRUE);
   bevel_box(300,40,190,255,TRUE);

   for (ctx = 0; ctx<=width; ctx++) {
       for (cty = 0; cty<=height; cty++) {
           switch (get(t_grid,ctx-1,cty-1)) {
                case HEX_FORBID:
                    myctr[0]++;
                    break;
                case HEX_PLAINS:
                    myctr[1]++;
                    break;
                case HEX_DESERT:
                    myctr[2]++;
                    break;
                case HEX_BRUSH:
                    myctr[3]++;
                    break;
                case HEX_FOREST:
                    myctr[4]++;
                    break;
                case HEX_JUNGLE:
                    myctr[5]++;
                    break;
                case HEX_RUGGED:
                    myctr[6]++;
                    break;
                case HEX_HILLS:
                    myctr[7]++;
                    break;
                case HEX_MOUNTAINS:
                    myctr[8]++;
                    break;
                case HEX_PEAKS:
                    myctr[9]++;
                    break;
                case HEX_SWAMP:
                    myctr[10]++;
                    break;
                case HEX_SHALLOWS:
                    myctr[11]++;
                    break;
                case HEX_OCEAN:
                    myctr[12]++;
                    break;
                case HEX_DEPTH:
                    myctr[13]++;
                    break;
                case HEX_ICE:
                    myctr[14]++;
           }         
           if (city_hereP(ctx,cty))
                myctr[15]++;
       OD
   OD
        
   sprintf(foo,"%ld",myctr[0]);
   plot_text(5+70,52,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[0]) / z;
   pcy = (100 * myctr[0]) % z;
   pcz = pcx + pcy;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,52,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[1]);
   plot_text(5+70,85,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[1]) / z;
   //pct += (100 * myctr[1]) % z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,85,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[2]);
   plot_text(5+70,118,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[2]) / z;
   //pct += (100 * myctr[2]) % z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,118,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[3]);
   plot_text(5+70,150,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[3]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,150,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[4]);
   plot_text(5+70,182,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[4]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,182,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[5]);
   plot_text(5+70,214,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[5]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,214,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[6]);
   plot_text(5+70,246,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[6]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,246,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[7]);
   plot_text(5+70,279,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[7]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+110,279,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[8]);
   plot_text(5+300,52,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[8]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,52,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[9]);
   plot_text(5+300,85,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[9]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,85,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[10]);
   plot_text(5+300,118,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[10]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,118,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[11]);
   plot_text(5+300,150,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[11]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,150,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[12]);
   plot_text(5+300,182,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[12]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,182,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[13]);
   plot_text(5+300,214,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[13]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,214,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[14]);
   plot_text(5+300,246,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[14]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,246,foo,WHITE,LT_GRAY,JAM2,&topaz11); 
   sprintf(foo,"%ld",myctr[15]);
   plot_text(5+300,279,foo,BLACK,LT_GRAY,JAM2,&topaz11);
   z = width * height;
   pcx = (100 * myctr[15]) / z;
   sprintf(foo,"%ld",pcx);
   strcat(foo,"%");
   plot_text(5+340,279,foo,WHITE,LT_GRAY,JAM2,&topaz11); 

       
   {  // handle the user actions here
      struct IntuiMessage *message; // the message the IDCMP sends us
      //struct MenuItem *item;
      //int ctr;

      // useful for interpreting IDCMP messages
      UWORD code;
      ULONG class;
      APTR object;

      while (TRUE) {
         WaitPort(stats_window->UserPort);
         while (message = GT_GetIMsg(stats_window->UserPort)) {
            code = message->Code;  // MENUNUM
            object = message->IAddress;  // Gadget
            class = message->Class;
            GT_ReplyIMsg(message);
            //if (class==MOUSEBUTTONS && code==SELECTDOWN)
            //   new_terrain(message->MouseX,message->MouseY);
            if (class==GADGETUP) {
               if (object==ok_gad)
                  goto exit_stats_window;
            FI
            if (class==IDCMP_VANILLAKEY && code==13) {
               goto exit_stats_window;
            FI
            if (class==CLOSEWINDOW)
               goto exit_stats_window;
         OD
      OD
   }
   exit_stats_window:


   // now clean everything up and leave
       rast_port = map_window->RPort;
       CloseWindow(stats_window);
       stats_window = NULL;
       FreeGadgets(context);
       ClearPointer(map_window);
       ModifyIDCMP(map_window,IDCMP_MAPEDIT);
}

void do_connect()
{
        struct rtHandlerInfo *handle;
        //int flag=0;
        int ctx, cty;
        int x1=0;
        int y1=0;
        int x2=0;
        int y2=0;
        
   // make sure user doesn't play with the map window now
   SetPointer(map_window,BUSY_POINTER);
   ModifyIDCMP(map_window,NULL);


   sprintf(foo,"Connecting Cities.\nPlease wait...");
   handle = post_it(foo);      

   for (ctx = 0; ctx<=width; ctx++) {
       for (cty = 0; cty<=height; cty++) {
           if (city_hereP(ctx-1,cty-1)) {
                    if(x1==0 && y1==0) {
                        x1 = ctx-1;
                        y1 = cty-1;
                        continue;
                    FI
                    if(x2==0 && y2==0) {
                        x2 = ctx-1;
                        y2 = cty-1;
                        Calc_Path(x1,y1,x2,y2);
                        x1=0;
                        y1=0;
                        x2=0;
                        y2=0;                                       
                    FI                                
           FI
       OD
   OD

//   for (ctx = 0; ctx<=height; ctx++) {
//       for (cty = 0; cty<=width; cty++) {
//           if (city_hereP(ctx-1,cty-1)) {
//                    if(x1==0 && y1==0) {
//                        x1 = ctx-1;
//                        y1 = cty-1;
//                        continue;
//                    FI
//                    if(x2==0 && y2==0) {
//                        x2 = ctx-1;
//                        y2 = cty-1;
//                    FI
//                    draw_road(x1,y1,x2,y2);
//                    x1=y1=x2=y2=0;    
//           FI                                       
//       OD
//   OD


   exit_do_connect:
        ClearPointer(map_window);
        ModifyIDCMP(map_window,IDCMP_MAPEDIT);
        unpost_it(handle);

}

/***************************************************************
***** Path Finding Routines  (modified for connect cities) *****
***************************************************************/
#define REVERSE_DIRECTION(num)  ((num+3)%6)
void  Calc_Path (short orgx, short orgy, short destx, short desty)
{
  int                flag=0;
  int                i, rigor;
  short              Destx, Desty;
  short              targx, targy;
  int                Pickdir, PathCost;
  long               NewCost;
  struct PathNode*   PNode = NULL;
  struct PathNode*   PNode2 = NULL;
  struct PathNode*   WalkNode;
  int                Found;
  // First, we initialize some stuff and check for input errors
  // Set up the globals
  //Type = type;  // One less push and pop on the stack for getting cost
  //PathDiv = rigor;  // Dial up the precision required - 1 to 10
  //if (rigor < 1) rigor = 1;
  //if (rigor > 10) rigor = 10;
  rigor = 1;
  Destx = destx;
  Desty = desty;
  // Clear the return values
  for( i=0; i<MAX_PATH; i++ )  Path[i] = -1;
  // Check for bad inputs
  if( (orgx >= width)||(orgx < 0)||(orgy >= height)||(orgy < 0) ) return;
  if( (destx >= width)||(destx < 0)||(desty >= height)||(desty < 0) ) return;
  // Now, check the direction map
  if( !PathMap ) {
    // Must be the first time this has been called
    // Allocate PathMap, set PathMapX and PathMapY, initialize the
    //    lists.
    PathMap = (int*) malloc( sizeof(int) * width * height );
    if( !PathMap ) return;  // Abort this!
    PathMapX = width;
    PathMapY = height;
    for(i=0; i< (width*height); i++)  PathMap[i] = -1;
  }
  if( (PathMapX != width) || (PathMapY != height) ) {
    // We have started a new game without exitting - the map changed
    PathMap = (int*) malloc( sizeof(int) * width * height );
    if( !PathMap ) return;  // Abort this!
    PathMapX = width;
    PathMapY = height;
    for(i=0; i< (width*height); i++)  PathMap[i] = -1;
  }
  // Initialize both lists, just to be sure we're starting good.
  NewList ((struct List*)&OpenList);
  NewList ((struct List*)&DoneList);
  
   // To begin, insert the starting node into the OpenList
  PNode = AllocVec( (long)sizeof(*PNode ), MEMF_CLEAR );
  if( !PNode ) return; // Abort!  Can't get memory!
  // We will start from the destination, so recording the path after
  //   will be easier.
  PNode->x = destx;
  PNode->y = desty;
  PNode->cost = 0; 
  // Here we use the rigor to define how well to search for paths
  // Underestimating is best - makes us check more possible paths 
  //   but it is slower.  Rigor goes from 1 to 10, with 1 being the
  //   most rigorous and 10 the least (it will settle on less optimal
  //   paths).
  PNode->eta = AI5_GetDist( orgx, orgy, destx, desty ) * 10 * rigor;
  AddHead((struct List *)&OpenList,(struct Node *)PNode);
  // Now, enter the while loop until we are done
  while( !emptylistP( &OpenList ) ) {
    // Change - make a new routine to get the best bet out of OpenList
    PNode = AI5_OpenListGetBest();
    // Put it in the DoneList - we are visiting it now
    AddTail((struct List*)&DoneList,(struct Node*)PNode);
    // Check for destination
    if( (PNode->x == orgx) && (PNode->y == orgy) )  break; 
    // Not there yet, so let's look at the hexes around it
    // Pick a random direction to start with
    Pickdir = RangeRand( 6L ); // Gets us 0-5
    i = Pickdir; // To start us off on Pickdir
    do {
      // Get the hex in that direction
      if( AI1_calc_dir (i, PNode->x, PNode->y, &targx, &targy) != -1 ) {
	    // Find the cost to get to the new hex
	    NewCost = AI5_GetCost( PNode->x, PNode->y);
	    // Can we even go here?
	    if( NewCost < 0 ) {
          i++;
          if( i > 5 ) i=0;         
          continue;
        }

	    PNode2 = AllocVec( (long)sizeof(*PNode2 ), MEMF_CLEAR );
	    // On memory problem, get out
	    if( !PNode2 ) {
          i++;
          if( i > 5 ) i=0;
          continue;
        }
	    PNode2->x = targx;
	    PNode2->y = targy;
	    PNode2->cost = PNode->cost + NewCost;
	    // We use the *60 here to estimate that we will spend 60/hex
	    PNode2->eta = AI5_GetDist( targx, targy, orgx, orgy )*10*rigor;

	    // If not marked on the map already, mark it and place it in OpenList
	    if( PathMap[ targy * width + targx ] == -1 ) {
	      PathMap[ targy * width + targx ] = REVERSE_DIRECTION(i);
              AddTail( (struct List*)&OpenList, (struct Node*)PNode2 );
	    }
	    // else, try to find it in the OpenList, and replace it ifs cost
	    //    is greater (took more to get there) and mark it again.
	    else {
	      Found = FALSE;
	      WalkNode = (struct PathNode*)OpenList.mlh_Head;
	      for(; WalkNode->pnode.mln_Succ; WalkNode = 
		    (struct PathNode*)WalkNode->pnode.mln_Succ) {
	        if( (WalkNode->x == PNode2->x) && (WalkNode->y == PNode2->y) ) {
	          // found the matching node
	          if( WalkNode->cost > PNode2->cost ) {
		        // replace it - classic extraction from a double linked list
    		    Remove( (struct Node*)WalkNode );
		        FreeVec( WalkNode );
                WalkNode = NULL; // Just to make sure
    		    Found = TRUE;
		        AddTail( (struct List*)&OpenList, (struct Node*)PNode2 );
		        // Mark the spot
    		    PathMap[ targy * width + targx ] = REVERSE_DIRECTION(i);
                  }
	        }
	      } // End for loop
	      // if we didn't find it, forget it.
	      if( Found == FALSE ) FreeVec( PNode2 );
          PNode2 = NULL; // Just to make sure.
	    } // End else was already marked
      } // End if there is a hex in this direction
      // increment our direction
      i++;
      if( i > 5 ) i=0;
    } while( i != Pickdir); // End do-while loop of directions 
  } // End while OpenList not empty

  PathLength = 0;
  PathCost = -1;
  // OK, now check that we have a path
  if( (PNode->x == orgx) && (PNode->y == orgy) && 
    (PNode->cost > 0) && (PNode->eta == 0) ) {
    // we found a path!
    // Record it.
    targx = orgx;
    targy = orgy;
    for(i=0; i<MAX_PATH; i++) {
      // Record the first steps
      Path[i] = PathMap[ targy * width + targx ];
      PathLength++;
      // Look!  This routine even works on its own parameters!
      if( AI1_calc_dir (Path[i], targx, targy, &targx, &targy) == -1 ) {
	     break;
      }
      flag = flag | ROAD;     // add road to this hex
      put_flags(t_grid,targy,targx,flag);  
      ME_draw_roads(targy,targx);
      if( (targx == destx) && (targy == desty) ) {
        // we made it! exit!
        break;
      }
    }
    // And record the total cost of moving along the path
    //PathCost = PNode->cost;
  }
  // else nothing - we already cleared the path to nothing

  // Erase the marked up map for the next person
  for( WalkNode = (struct PathNode*)OpenList.mlh_Head; WalkNode->pnode.mln_Succ; 
       WalkNode = (struct PathNode*)WalkNode->pnode.mln_Succ ) {
    PathMap[ WalkNode->y * width + WalkNode->x ] = -1;
  }
  // For debugging / timing count the nodes here - easier to see
  i = count_nodes( &OpenList );
  for( WalkNode = (struct PathNode*)DoneList.mlh_Head; WalkNode->pnode.mln_Succ; 
       WalkNode = (struct PathNode*)WalkNode->pnode.mln_Succ ) {
    PathMap[ WalkNode->y * width + WalkNode->x ] = -1;
  }

  // Cleanup both lists
  nuke_list( &OpenList );
  nuke_list( &DoneList );


  return;
}




/**************************\
|   END OF MAP_EDITOR2.C   |
\**************************/

