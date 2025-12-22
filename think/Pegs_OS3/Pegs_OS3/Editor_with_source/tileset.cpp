// tileset.cpp
// 03 11 09, av: Fredrik Stridh
// Uppdaterad 050331

#include "tileset.h"
#include <iostream>

using namespace std;

tileset::tileset()
{
   tile_widht = 32;
   tile_height = 32;
   
   tile_file_widht = 640;
   tile_file_height = 480;
   tile_file_number_tiles = 1;
}


tileset::tileset(int widht, int height, unsigned int numberTiles)
{
   tile_widht = widht;
   tile_height = height;
   
   tile_file_widht = 640;
   tile_file_height = 480;
   tile_file_number_tiles = numberTiles;
}


tileset::~tileset()
{

}
