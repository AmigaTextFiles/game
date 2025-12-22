/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Arena.hpp"

// some stuff needed for compiling with newer GNU C compiler version, due to the restructuring of c++ headers
#ifdef __GNUC__
#include <string.h>
#include <cstdlib>
#include <cstring>
#endif

Arena::Arena()
{
  init();
}

Arena::~Arena()
{
  // nothing to do
}

void Arena::init()
{
  // clear grid
  for(int l=0; l<19; l++)
    for(int c=0; c<25; c++)
    {
      this->SetTile(l,c, notBlocked);
      this->flip[l][c] = false;
    }
  
  // set player positions to invalid values
  this->xLine = -1;
  this->xColumn = -1;
  this->yLine = -1;
  this->yColumn = -1;
}

void Arena::ResetAndClear()
{
  this->init();
}

void Arena::SetTile(int line, int column, arenaTile tile)
{
  // set tile if it is within bounds
  if(line >= 0 && line < 19 && column >=0 && column < 25)
  {
    if(tile==totalNumberOfTiles || tile==notBlocked || tile==playerAstart || tile==playerBstart)
      this->grid[line][column] = notBlocked;
    else
      this->grid[line][column] = tile;
    
    if(tile==playerAstart) // found start position for player one?
    {
      this->xLine = line;
      this->xColumn = column;  
    }
    
    if(tile==playerBstart) // found start position for player two?
    {
      this->yLine = line;
      this->yColumn = column; 
    }
  }
}

arenaTile Arena::GetTile(int line, int column)
{
  // return tile if it is within bounds or return notblocked, if the coordinates are invalid
  if(line >= 0 && line < 19 && column >=0 && column < 25)
    return this->grid[line][column];
  else
    return notBlocked;
}

bool Arena::IsFlipped(int line, int column)
{
  if(line >= 0 && line < 19 && column >=0 && column < 25)
    return this->flip[line][column];
  else
    return false;
}

void Arena::HitTile(int line, int column)
{
  arenaTile tile = this->GetTile(line, column);
  if(tile >= rock1 && tile <= rock5) // tile is destructible rock?
    this->SetTile(line, column, (arenaTile)(tile-1));
}

bool Arena::read(FILE *sourceFile)
{
  bool error = false;
  
  // buffer for read operations
  char buffer[30];
  memset((void*)&(buffer[0]), 0, sizeof(char)*30);
  
  // read and validate level header (first line of file)
  char* currentLine = fgets(&(buffer[0]), 29, sourceFile);
  if(currentLine != NULL)
  {
    if(strstr(buffer, "#tankgamemap") == NULL)
      error = true;
  }
  else
    error = true;
  
  // read level data
  int line=0;
  if(!error)
    do
    {
      fgets(&(buffer[0]), 29, sourceFile); // read next line of map file
      
      error = (ferror(sourceFile) != 0); // check for errors
      
      if(!error && strlen(buffer) >= 25) // no errors and at least expected number of chars read?
      {
        // evaluate line and set tilemap accordingly
        for(int c=0; c<25; c++)
        {
          char foundTileChar = toupper(buffer[c]);
          
          // translate character to tilemap
          int t=0;
          for(t=0; t<totalNumberOfTiles; t++)
          {
            if(arenaTranslation[t] == foundTileChar)
              break;
          }
          // t is now the index of the arenaTile that was found (or totalNumberOfTiles if no valid tile was found)
          
          this->SetTile(line, c, (arenaTile)t);
          
          // decide randomly whether tile should be flipped
          if(rand()%100 < 50)
            this->flip[line][c] = true;
          else
            this->flip[line][c] = false;
          
        }// ..end of loop that iterates through each column of the current line  
        
        line++;
      }
    }
    while(line < 19 && !error);
  // level data is now read (provided error is false)
    
  return !error;
}

bool Arena::Read(char *fileName)
{
  bool error = false;
  
  FILE* sourceFile = fopen(fileName, "r"); // open file for reading
  if(sourceFile == NULL)
    error = true;
  else
    error = !this->read(sourceFile); // let other method read the leveldata
  
  // close file  
  if(sourceFile != NULL)
    fclose(sourceFile);
    
  return !error;
}

