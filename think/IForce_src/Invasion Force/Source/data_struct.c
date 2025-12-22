/*
   data_struct.c -- universal data structures for Invasion Force
   This module defines and declares major global data structures.
   This source code is free.  You may make as many copies as you like.
*/

#include "global.h"

// *** following are globals used by both the map editor and the game
int width, height; // current map size
int xoffs, yoffs;  // current map offsets
BOOL wrap;           // flag for wrap-around map
UBYTE *t_grid = NULL;   // grid storage for basic terrain map
UBYTE *me_grid = NULL;
struct MinList city_list;  // the universal city list

char default_city_name[] = "Metropolis";

// this array holds a list of hexagon coordinates for use by
// functions like adjacent() and such
struct Hex_Coords hexlist[64];


char *terrain_name_table[] = {
   "Unexplored",
   "Plains",
   "Desert",
   "Forbidden",
   "Scrubland",
   "Forest",
   "Jungle",
   "Rugged",
   "Hills",
   "Mountains",
   "Mountain Peaks",
   "Swamp",
   "Shallow Waters",
   "Ocean",
   "Deep Ocean",
   "Packed Ice",
   "City",
   "Roads"
};


/*
   The movement_cost[] chart holds the movement cost for each type of
   unit on each type of terrain.  This will allow me to customize the
   movement characteristics of each unit type however I desire!
*/

short movement_cost_table[12][16] = {
   /* RIFLE */
   { 75, 60, 60, -1, 60, 70, 90, 60, 70, 80, -1, 90, -1, -1, -1, -1 },
   /* ARMOR */
   { 90, 60, 60, -1, 60, 90, 150,70, 90, -1, -1, -1, -1, -1, -1, -1 },
   /* AIRCAV */
   { 60, 60, 60, -1, 60, 60, 60, 60, 60, 60, -1, 60, 60, 60, 60, 60 },
   /* BOMBER */
   { 60, 60, 60, -1, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 },
   /* FIGHTER */
   { 60, 60, 60, -1, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 },
   /* TRANSPORT */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* SUB */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* DESTROYER */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* CRUISER */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* BATTLESHIP */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* CARRIER */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 80, 60, 60, -1 },
   /* AIRBASE */
   { 70, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }
};



struct UnitTemplate wishbook[] = {
      {RIFLE,250,-1,60,1,TRUE,FALSE,"Infantry"},
      {ARMOR,500,-1,120,2,FALSE,FALSE,"Armor"},
      {AIRCAV,700,12,180,1,FALSE,FALSE,"Air Cavalry"},
      {BOMBER,500,24,240,1,FALSE,FALSE,"Bomber"},
      {FIGHTER,500,18,360,1,TRUE,FALSE,"Fighter"},
      {TRANSPORT,1250,-1,120,3,TRUE,TRUE,"Transport"},
      {SUB,1000,-1,120,2,TRUE,TRUE,"Submarine"},
      {DESTROYER,1000,-1,180,3,TRUE,TRUE,"Destroyer"},
      {CRUISER,1500,-1,120,8,TRUE,TRUE,"Cruiser"},
      {BATTLESHIP,2500,-1,120,12,TRUE,TRUE,"Battleship"},
      {CARRIER,2000,-1,120,8,TRUE,TRUE,"Carrier"},
      {AIRBASE,100000,-1,0,1,TRUE,FALSE,"Airbase"}
};

struct InfoTemplate infostatus[] = {
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
      {FALSE},
};


/*
   Because of the way the game evolved historically, it stores map data in
   a rather odd format.  The terrain is stored in a grid, one nybble per
   hex.  The flag data (roads, mines, etc.) follows immedately in a second
   grid of the same size, again one nybble per hex.  Thus, to access the
   flags for a given hex, it must first calculate the size of the whole
   terrain data area and skip over that.  This process should be invisible
   to the rest of the program, as long as it accesses all the map data
   through these functions.
*/


void put(grid,x,y,value)
UBYTE *grid;
int x, y, value;
{  // put a 4-bit value (0-15) into a map grid position
   int twd;
   UBYTE *bptr;

   wrap_coords(&x,&y);

   twd = (width+width%2)/2;            // true byte-width of the map
   bptr = grid+y*twd+(int)((x+1)/2);   // find the relevent byte

   if (x%2)
      *bptr = (*bptr & 0xF0) | value;  // clear and store low nybble
   else
      *bptr = (*bptr & 0x0F) | (value<<4);   // clear and store high nybble
}


void put_flags(grid,x,y,value)
UBYTE *grid;
int x, y, value;
{  // put a 4-bit flags value (0-15) into a map grid position
   int twd;
   UBYTE *bptr;

   wrap_coords(&x,&y);

   twd = (width+width%2)/2;            // true byte-width of the map
   bptr = (grid+y*twd+(int)((x+1)/2))+GRID_SIZE;   // find the relevent byte

   if (x%2)
      *bptr = (*bptr & 0xF0) | value;  // clear and store low nybble
   else
      *bptr = (*bptr & 0x0F) | (value<<4);   // clear and store high nybble
}


// get a 4-bit value (0-15) from a map position

int get(grid,x,y)
UBYTE *grid;
int x, y;
{
   int twd;
   UBYTE *bptr;

   if (!VALID_HEX(x,y))
      return HEX_UNEXPLORED;
   twd = (width+width%2)/2;   // true byte-width of the map
   bptr = grid+y*twd+(int)((x+1)/2);   // find the relevent byte
   if (x%2)
      return (*bptr & 0x0F);  // get low nybble
   else
      return ((*bptr & 0xF0)>>4);      // get high nybble
}


// get a 4-bit flags value (0-15) from a map position

int get_flags(grid,x,y)
UBYTE *grid;
int x, y;
{
   int twd;
   UBYTE *bptr;

   if (!VALID_HEX(x,y))
      return HEX_UNEXPLORED;
   twd = (width+width%2)/2;   // true byte-width of the map
   bptr = (grid+y*twd+(int)((x+1)/2))+GRID_SIZE;   // find the relevent byte
   if (x%2)
      return (*bptr & 0x0F);  // get low nybble
   else
      return ((*bptr & 0xF0)>>4);      // get high nybble
}


/*
   free_map() checks to see if the given map grid is active (i.e. non-zero),
   and, if so, will free the RAM and zero the grid pointer

   I tried to do this differently, so I didn't have to give free_map() a pointer
   to a pointer, but it turned out to be an awful lot of work.  These functions
   [both free_map() and alloc_map()] are smart functions.  Leave the smarts in
   them.  Smart is good.
*/

VOID free_map(grid)
UBYTE **grid;  // location of a pointer to a map grid
{
   if (*grid) {         // if *grid is non-zero, I assume it's been allocated
      FreeVec(*grid);   // so I de-allocate it
      *grid = NULL;     // when free_map() exits, *grid will always be NULL
   FI
}


/*
   alloc_map() takes the specified map grid, zeroes and clears it if necessary
   [using free_map()], then allocates a new map grid, calculating the size of the
   required RAM block based on the current map size values  [see additional
   comments with free_map()]
*/

BOOL alloc_map(grid)
UBYTE **grid;
{
   UBYTE *newgrid;

   free_map(grid);   // clear and zero any old map grid from this space
   newgrid = AllocVec(GRID_SIZE*2,MEMF_CLEAR);
   if (newgrid) {
      *grid = newgrid;
      return TRUE;
   } else {    // assume a non-fatal error,
      // though the calling function can still do a fatality if it wants to
      alarm("Insufficient RAM for map!\n");
      return FALSE;
   FI
}


// flood the map with a single value (terrain type)

void flood_map(grid,value)
UBYTE *grid;
int value;
{
   int flag = 0;
   int xc, yc;

   for (yc=0; yc<height; yc++)
      for (xc=0; xc<width; xc++) {
         flag = get_flags(grid,xc,yc);
         if (flag) {
                flag = flag & (~ROAD);  // remove roads
                put_flags(grid,xc,yc,flag);
         FI
         put(grid,xc,yc,value);
      }
      nuke_list(&city_list);
}

void int_grid(grid,value)
UBYTE *grid;
int value;
{
   int xc, yc;

   for (yc=0; yc<height; yc++)
      for (xc=0; xc<width; xc++)
         put(grid,xc,yc,value);
}

void clear_orders(unit)
struct Unit *unit;
{
   if (unit->orders)
      FreeVec(unit->orders);
   unit->orders = NULL;
}


void destruct_unit(unit)
struct Unit *unit;
{  // destroy a unit, freeing all RAM associated with it
   if (unit->orders)
      FreeVec(unit->orders);
   if (unit->name)
      FreeVec(unit->name);
   FreeVec(unit);
}


char *random_name(utype)
int utype;  // the type of unit we are naming
{
   static char name[20];
   BOOL ship=wishbook[utype].ship_flag;
   int ctr=0;
   struct Unit *unit;
   BOOL found;

   strcpy(name,"UNNAMED");
   if (ship) {
      /*
         filename = name of the data file I'm reading names from
         flen = length of the data file
         nrecs = number of records in the file
         chosen = number of the record I have chosen randomly
         rsz = record size (currently 20)
      */
      char filename[128];
      BPTR infile;
      int flen, nrecs, chosen;
      long rsz=20L;  // record size

      strcpy(filename,"progdir:data/NAMES.");
      strcat(filename,wishbook[utype].name);
      flen = FLength(filename);
      if (flen<rsz)
         return name;
      nrecs = flen/rsz;
      do {
         // chose a name randomly and read it
         chosen = RangeRand(nrecs);
         infile = Open(filename,MODE_OLDFILE);
         if (infile==NULL)
            return name;
         Seek(infile,chosen*rsz,OFFSET_BEGINNING);
         Read(infile,name,rsz);
         Close(infile);
         name[19]='\0'; // just in case the name is 19 characters long
         ctr++;

         // see if this name has already been used
         found = FALSE;
         for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
            if (unit->name)
               if (strcmp(name,unit->name)==0) {
                  found = TRUE;
                  break;
               FI
      } while (found && ctr<=10);
   } else {    // it's not a ship, so we must generate a name
      int number;
      char template[8];

      do {
         // random name
         strcpy(template,"%ldth");
         number = RangeRand(999)+1;    // range from 1-999
         if (number<4 || number>20)
            switch(number%10) {
               case 1:
                  strcpy(template,"%ldst");
                  break;
               case 2:
                  strcpy(template,"%ldnd");
                  break;
               case 3:
                  strcpy(template,"%ldrd");
                  break;
            }
         sprintf(name,template,number);

         // see if this name has already been used
         // it only counts as a dupe if it's the same type and same owner
         found = FALSE;
         for (unit=(struct Unit *)unit_list.mlh_Head;unit->unode.mln_Succ;unit=(struct Unit *)unit->unode.mln_Succ)
            if (unit->name)
               if (strcmp(name,unit->name)==0 && unit->type==utype && unit->owner==player) {
                     found = TRUE;
                     break;
               FI
      } while (found && ctr<=10);
   FI
   return name;
}


// set the name of a unit to a specified string value
void name_unit(unit,name)
struct Unit *unit;
char *name;
{
   if (unit->name)   // destruct any name it might already have
      FreeVec(unit->name);

   // allocate memory for name and copy new text into it
   unit->name = AllocVec(strlen(name)+1,MEMF_CLEAR);
   if (unit->name)
      strcpy(unit->name,name);
}


// *** following are list functions
//     they are all designed to work with MinList and MinNode structures

BOOL emptylistP(the_list)
struct MinList *the_list;
{  // is this list empty?
   return (BOOL)(the_list->mlh_TailPred==(struct MinNode *)the_list);
}

void nuke_list(ground_zero)
struct MinList *ground_zero;
{  // wipe out contents of list, free all memory
   struct MinNode *casualty;

   // the list may never have been initialized
   if (ground_zero->mlh_Head==NULL)
      return;

   // de-allocate each node using FreeVec()
   // This way we can destroy large structures
   // without even knowing what they are!
   while (!emptylistP(ground_zero)) {
      casualty = ground_zero->mlh_Head;
      RemHead((struct List *)ground_zero);   // decapitated!!
      FreeVec(casualty);   // now dispose of the body
   }
}


void nuke_units(ground_zero)
struct MinList *ground_zero;
{  // wipe out contents of unit list, free all memory
   struct Unit *casualty;

   // the list may never have been initialized
   if (ground_zero->mlh_Head==NULL)
      return;

   // de-allocate each node and subitems using FreeVec()
   while (!emptylistP(ground_zero)) {
      casualty = (struct Unit *)ground_zero->mlh_Head;
      RemHead((struct List *)ground_zero);
      if (casualty->name)
         FreeVec(casualty->name);
      if (casualty->orders)
         FreeVec(casualty->orders);
      FreeVec(casualty);
   OD
}


int count_nodes(list)
struct MinList *list;
{  // count nodes in the list, natch
   struct MinNode *node = list->mlh_Head;
   int ctr = 0;

   for ( ; node->mln_Succ; node = node->mln_Succ)
      ctr++;
   return ctr;
}


// *** following are city handling functions

struct City *city_hereP(col,row)
int col, row;
{  // is there a city here?  return the address
   struct City *metro = (struct City *)city_list.mlh_Head;

   wrap_coords(&col,&row);

   for ( ; metro->cnode.mln_Succ; metro = (struct City *)metro->cnode.mln_Succ)
      if (metro->col==col && metro->row==row)
         return metro;
   return NULL;
}


void create_city(col,row)
int col, row;
{  // attempt to make a city at the specified location
   struct City *tcity = AllocVec((long)sizeof(*tcity),MEMF_CLEAR);
   int ctr;

   wrap_coords(&col,&row);

   if (tcity) {
      tcity->col = col;
      tcity->row = row;
      tcity->industry = 50;
      tcity->specialty = CITY;   // by default, no specialty
      strncpy(tcity->name,default_city_name,19);
      for (ctr=0;ctr<9;ctr++)
         tcity->recon[ctr] = CITY;
      AddTail((struct List *)&city_list,(struct Node *)tcity);
   FI
}

void remove_city(col,row)
int col, row;
{
   struct City *metro = (struct City *)city_list.mlh_Head;

   wrap_coords(&col,&row);

   for ( ; metro->cnode.mln_Succ; metro=(struct City *)metro->cnode.mln_Succ)
      if (metro->col==col && metro->row==row) {
         Remove((struct Node *)metro);
         FreeVec(metro);
         remove_city(col,row);  // in case there are more of them!
         break;
      FI
}


/*
   This function, adjacent(), accepts the coordinates of a hex, then fills
   the global array hexlist[] with coordinates of hexes ajacent to the original.
   This makes dealing with the hexagon based map much easier.  It returns
   the number of adjacent hexes actually found (usually six, sometimes less).
*/

int adjacent(col,row)
int col, row;
{
   int even_offsets[12] = {-1,0, 1,0,  0,-1, -1,-1, 0,1, -1,1},
       odd_offsets[12]  = {-1,0, 1,0,  1,-1, 0,-1,  1,1, 0,1};
   int *table = (row%2) ? odd_offsets : even_offsets;
   int x, y, ctr=0, index=0;

   // first zero out my global hexlist[] array
   // actually, I'll use -1 instead of 0, because 0,0 might be valid
   for (; ctr<8; ctr++) {
      hexlist[ctr].col = -1;
      hexlist[ctr].row = -1;
   OD

   for (ctr=0; ctr<6; ctr++) {
      x = col+table[ctr*2];   y = row+table[ctr*2+1];
      wrap_coords(&x,&y);
      if (x>=0 && x<width && y>=0 && y<height) {
         hexlist[index].col = x;
         hexlist[index++].row = y;
      FI
   OD
   return index;
}


// This will tell me if it's a port city, so I can build ships there.

BOOL port_cityP(metro)
struct City *metro;
{
   int num_hexes = adjacent(metro->col,metro->row);
   int ctr=0;

   for (; ctr<num_hexes; ctr++)
      switch (get(t_grid,hexlist[ctr].col,hexlist[ctr].row)) {
         case HEX_SHALLOWS:
         case HEX_OCEAN:
         case HEX_DEPTH:
            return TRUE;
      }
   return FALSE;
}

// end of listing
