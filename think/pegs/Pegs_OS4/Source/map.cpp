// map.cpp
// 04 03 28, Av: Fredrik Stridh 

#include "map.h"
#include <iostream>
#include <fstream>

using namespace std;


map::map()
{
	map_sizeX = 100;
    map_sizeY = 100;

    map_data = new int[map_sizeX * map_sizeY];

    cout << "Map object created\n";
    cout << "Map_sizeX: " << map_sizeX << "\n";
    cout << "Map_sizeY: " << map_sizeY << "\n";	
}  


map::map(int sizeX, int sizeY)
{
	map_sizeX = sizeX;  
    map_sizeY = sizeY;
   
    map_data = new int[map_sizeX * map_sizeY];  
   
    cout << "Map object created\n";
	cout << "Map_sizeX: " << map_sizeX << "\n";
    cout << "Map_sizeY: " << map_sizeY << "\n";
}


map::~map()
{
	delete [] map_data;	

    cout << "Map object deleted\n"; 
}


void map::set_tilenr(int pos_x, int pos_y, int tilenr)
{
	map_data[pos_y * map_sizeX + pos_x] = tilenr;
}
   

int map::get_tilenr(int pos_x, int pos_y)
{
	return map_data[pos_y * map_sizeX + pos_x];
}


void map::clear_map(int tilenr)
{
   for (int y = 0; y < map_sizeY; y++)
      {
         for (int x = 0; x < map_sizeX; x++)
	    {
	       map_data[y * map_sizeX + x] = tilenr;
	    }  
      }     
}     


int map::get_mapsizeX()
{
	return map_sizeX;
}


int map::get_mapsizeY()
{
	return map_sizeY;
}


void map::smap(char *filename)
{
	cout << "Saving map " << filename << "\n";

    ofstream fout(filename);

    fout << map_sizeX << "\n";
    fout << map_sizeY << "\n";

	for (int a = 0; a < map_sizeX * map_sizeY;a++)
	{
		fout << map_data[a] << "\n"; 
	}
     
	fout.close();
}     

void map::lmap(char *filename)
{
	cout << "Loading map " << filename << "\n";
 
	ifstream infile(filename);
  
	infile >> map_sizeX;
	infile >> map_sizeY;
  
	int temp;
  
	for (int a = 0; a < map_sizeX * map_sizeY;a++)
	{
		infile >> temp;
		map_data[a] = temp;
	}

    infile.close();
}
