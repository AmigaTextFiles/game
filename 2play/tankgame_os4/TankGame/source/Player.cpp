/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Player.hpp"

// some stuff needed for compiling with newer GNU C compiler version, due to the restructuring of c++ headers
#ifdef __GNUC__
#include <string.h>
#include <cstdlib>
#include <cstring>
#endif

Player::Player()
{
  this->init();
}

Player::Player(std::string name, unsigned int gW, unsigned int gWF, unsigned int gP)
{
  this->init(name, gW, gWF, gP);
}

Player::~Player()
{
  // nothing to do
}

void Player::init()
{
  this->gamesWon = 0;
  this->gamesWonFlawless = 0;
  this->gamesPlayed = 0;
  this->name.assign("1234567890123456");
}

void Player::init(std::string name, unsigned int gW, unsigned int gWF, unsigned int gP)
{
  this->gamesWon = gW;
  this->gamesWonFlawless = gWF;
  this->gamesPlayed = gP;
  
  // truncate leading and trailing spaces
  int firstToCopy = name.find_first_not_of(' ');
  int lastToCopy = name.find_last_not_of(' ');
  if(lastToCopy >= firstToCopy && firstToCopy != -1 && lastToCopy != -1)
  {
    this->name.assign(name.substr(firstToCopy, (lastToCopy - firstToCopy)+1));
  }
  else
    this->name.assign("empty name");
}

void Player::IncreaseWin(bool flawless)
{
  if(gamesPlayed + 1 <= 1000000) // each player is allowed to play one million games
  {
    this->gamesPlayed++;
    this->gamesWon++;
    if(flawless)
      this->gamesWonFlawless++;
  }
}

void Player::IncreaseGamesPlayed()
{
  if(gamesPlayed + 1 <= 1000000)
    this->gamesPlayed++;
}


bool Player::Write(FILE* targetFile)
{
  bool retVal = true;
  if(targetFile != NULL)
  {
    std::string namecopy;
    namecopy.assign(this->name);

    // replace whitespace in player namecopy with dots
    for(int i=0; i<(int)namecopy.length(); i++)
    {
      if(namecopy[i] == ' ')
        namecopy.replace(i,1,".");
    }

    // write player data to file as formatted string
    int charsWritten = fprintf(targetFile, "%u %u %u %-16.16s\n",
      this->gamesWon, this->gamesWonFlawless, this->gamesPlayed,
      namecopy.c_str());

    if(charsWritten < 0) // error?
      retVal = false;
  }
  else
    retVal = false;

  return retVal;
}

bool Player::Read(FILE* sourceFile)
{
   bool retVal = true;
   if(sourceFile != NULL)
   {
     unsigned int gW = 0;
     unsigned int gWF = 0;
     unsigned int gP = 0;
     char n[20];
     memset((void*)&n[0], 0, sizeof(char)*20);

     // read player data from file as formatted string
     int itemsRead = fscanf(sourceFile, "%u %u %u %16s\n",
       &gW, &gWF, &gP, n);

     if(itemsRead == EOF || itemsRead < 4) // error?
       retVal=false;
     else
     {
       std::string tmpName;
       tmpName.assign(n);

       // replace dots in tmpName with spaces
       for(int i=0; i<(int)tmpName.length(); i++)
       {
         if(tmpName[i] == '.')
           tmpName.replace(i,1," ");
       }

       // set player data
       this->name.assign(tmpName);
       this->gamesWon = gW;
       this->gamesWonFlawless = gWF;
       this->gamesPlayed = gP;
     }
   }
   else 
     retVal = false;

   return retVal;
}

// static function
// returns true, if the first player has higher score than the second
// (used for ranking in Scoreboard)
bool Player::compareScores(ptrPlayer pA, ptrPlayer pB)
{
  unsigned int pointsA = 0;
  unsigned int pointsB = 0;
  
  if(pA != NULL)
  {
    pointsA += pA->GetGamesWon(); // 1 point per victory
    pointsA += pA->GetGamesWonFlawless()*2; // 2 points per flawless victory
  }
  
  if(pB != NULL)
  {
    pointsB += pB->GetGamesWon(); // 1 point per victory
    pointsB += pB->GetGamesWonFlawless()*2; // 2 points per flawless victory
  }
  
  if(pointsA == pointsB) // if points are equal, use lexicographic sorting
    return Player::compareNames(pA, pB);
  else
    return (pointsA > pointsB);
}

 // returns true, if the first player comes first in lexicographic sorting
 // (used for sorted roster from scoreboard)
 bool Player::compareNames(ptrPlayer pA, ptrPlayer pB)
 { 
   if(pA == NULL || pB == NULL)
     return false;
   else
     return (strcmp(pA->GetName().c_str(),  pB->GetName().c_str()) < 0);
 }


