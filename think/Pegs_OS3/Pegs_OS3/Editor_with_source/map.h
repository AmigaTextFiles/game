// map.h - Headerfil med klassdefiniton
// 04 03 28, Av: Fredrik Stridh 

#ifndef _map_h_
#define _map_h_

class map
{
private:
   int *map_data;
   int map_sizeX;
   int map_sizeY;

public:
   map();
   map(int sizeX, int sizeY);
   ~map();
   void set_tilenr(int pos_x, int pos_y, int tilenr);
   int get_tilenr(int pos_x, int pos_y);
   void clear_map(int tilenr);
   int get_mapsizeX();
   int get_mapsizeY();
   void smap(char *filename);
   void lmap(char *filename);
};

#endif
