#include "main.h"
#include "player.h"
#include "strings.h"
#include "texture.h"

#ifndef __scene_h_
#define __scene_h_

#define _SECTOR_ZERRO_        0
#define _SECTOR_WALL_         1
#define _SECTOR_FLOOR_        2
#define _SECTOR_BOX_          3
#define _SECTOR_POINT_        4
#define _SECTOR_POINT_BOX_    5
#define _SECTOR_PLAYER_       6
#define _SECTOR_POINT_PLAYER_ 7

#define _SCENE_SCALE_ 1.0f

class class_scene
{
   private:

   #define _AMOUNT_TEXTURES_ 6

   struct struct_map
   {
      unsigned int **data;
      unsigned int i, j;
   };

   struct_map map;

   struct struct_levelsList
   {
      type_string *list;
      unsigned int size;
   };
   
   struct_levelsList levels;
   unsigned int numberPresentLevel;

   struct struct_player
   {
      unsigned int i, j;
   };

   struct_player player, box;
   unsigned int points, pointsFilling;
   class_texture texture[_AMOUNT_TEXTURES_];

   class_player *modelPlayer;

   int fileExist (char *);
   int loadLevelIndex (char *);
   int loadMap (char *);
   int loadTexture (char *);
   int delLevel ();
   int drawBox ();
   int drawFloor ();

   public:

   class_scene ();
   ~class_scene ();
   int loadLevel (char *);
   int loadModel (char *);
   int action (unsigned int);
   int draw ();
   int level (int);
   bool levelWin ();
};

#endif
