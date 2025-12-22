// tileset.h - headerfil med klassdefinition
// 03 11 09, av: Fredrik Stridh
// Uppdaterad 05 03 31

#ifndef _tileset_h_
#define _tileset_h_

class tileset
{
private:
  
public:
   int tile_widht;
   int tile_height;

   int tile_file_widht;
   int tile_file_height;
   unsigned int tile_file_number_tiles;
   
   tileset();
   tileset(int tile_widht, int tile_height, unsigned int numberTiles);
   ~tileset();
};	

#endif
