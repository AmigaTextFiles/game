/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include <stdio.h>
#include <string>
#include <math.h>

#if !defined(_Arena_HEAD_INCLUDED)
#define _Arena_HEAD_INCLUDED

// possible tiles for arena tilemap (indices for translation)
// (map file format, see end of this file)
enum arenaTile
{
  notBlocked = 0, // tank can move here
  rock0 = 1,      // tank can move here too (at slower speed though)
  rock1 = 2,
  rock2 = 3,
  rock3 = 4,
  rock4 = 5,
  rock5 = 6,
  indestructible = 7,
  playerAstart = 8, // converted to 0 on loading
  playerBstart = 9,  // converted to 0 on loading
  totalNumberOfTiles
};

// tile representations as characters in mapfile (index
// positions tell which arenaTile a given char represents)
// (e.g. 'B' is at index seven, so it translates to 'indestructible')
static const char arenaTranslation[] = { '.', '0', '1', '2', '3', '4', '5',
                                  'B', 'X', 'Y' };


class Arena;
typedef Arena* ptrArena;

// a class to handle the battle arena
class Arena
{
  private:
    arenaTile grid[19][25]; // the fixed size tilemap
    bool flip[19][25]; // on loading for each tile it is decided randomly, whether it should be flipped on drawing (that information will be stored here)

    // stores player one start position on load
    int xLine;  
    int xColumn;
    
    // stores player two start position on load
    int yLine;
    int yColumn;

    void init();
    bool read(FILE* sourceFile); // read map from file (returns true on success)

  public:
    // constructor/destructor
    Arena();
    ~Arena();

    // accessors
    void ResetAndClear(); // calls init()
    
    void SetTile(int line, int column, arenaTile tile);
    arenaTile GetTile(int line, int column);
    bool IsFlipped(int line, int column);
    void HitTile(int line, int column); // manipulates destructible tiles
    
    // get player start positions
    int GetXline() { return xLine; }
    int GetXcolumn() { return xColumn; }
    int GetYline() { return yLine; }
    int GetYcolumn() { return yColumn; }

    // read from file
    bool Read(char* fileName); // returns true on success
};

// map file format (textfile, 21 lines, 25 columns, first/last line fixed)
// Legend: B indestructible, 5 to 0 rocks, . notblocked, 
// X start green tank, Y start red tank
/* example file:
#tankgamemap
......BB.........BB......
.....BB...........BB.....
....BB.............BB....
...BB......555......BB...
BBBB...55555555555...BBBB
BBB....55..555..55....BBB
.........................
.........................
...........555...........
...........555...........
...........555...........
.........................
....5555.........5555....
....5555.........5555....
.X...55...........55...Y.
.....55....555....55.....
......5....555....5......
B..........555..........B
BB.........555.........BB
#end
*/

#endif // #if !defined(_Arena_HEAD_INCLUDED)
