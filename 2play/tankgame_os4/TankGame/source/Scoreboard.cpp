/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Scoreboard.hpp"

Scoreboard::Scoreboard()
{
  this->init();
}

Scoreboard::~Scoreboard()
{
  this->clear();
}

void Scoreboard::init()
{
  this->roster.clear();
}

void Scoreboard::clear()
{
  // first free memory from each player in roster
  std::map<std::string, ptrPlayer>::iterator rosterIt;
  
  for(rosterIt=roster.begin(); rosterIt != roster.end(); rosterIt++)
  {
    ptrPlayer pToDelete = NULL;
    pToDelete = rosterIt->second; // second value of iterator is pointer to player
    if(pToDelete != NULL)
      delete pToDelete; // free memory
  }

  // now removes all pointers from roster
  this->roster.clear();
  
  // clear ranking
  this->ranking.clear();
  
  // clear names list
  this->playersByName.clear();
}

bool Scoreboard::addPlayer(ptrPlayer pPlayer)
{
  if(pPlayer != NULL)
  {
    std::string newKeyName = pPlayer->GetName();
    
    if(!this->PlayerExists(newKeyName)) // only insert if it's not already there
    {
      try
      {
        this->roster[newKeyName] = pPlayer;
        return true;
      }
      catch(...)
      {
        return false;
      }
    }
    else
      return false;
  }
  else
    return false;
}

bool Scoreboard::RegisterPlayer(std::string name)
{
  ptrPlayer newPlayer = new(std::nothrow) Player(name, 0, 0, 0); // create new player object
  
  bool retVal = this->addPlayer(newPlayer); // try adding new player
  
  if(!retVal)
    delete newPlayer; // free memory immediately, if new player was not added
    // (otherwise, player objects will be deleted later in the destructor)
  
  return retVal;
}

bool Scoreboard::RemovePlayer(std::string name)
{
  ptrPlayer pPlayer = this->GetPtrPlayer(name);
  if(pPlayer != NULL)
  {
    delete pPlayer; // free memory of this player..
    if(this->roster.erase(name) != 0) // ..and then remove pointer from roster
      return true;
  } 
  
  return false;
}

bool Scoreboard::PlayerExists(std::string name)
{
  std::map<std::string, ptrPlayer>::iterator rosterIt = this->roster.find(name);
  if(rosterIt != roster.end()) // found player?
    return true;
  else
    return false;
}

ptrPlayer Scoreboard::GetPtrPlayer(std::string name)
{
  std::map<std::string, ptrPlayer>::iterator rosterIt = this->roster.find(name);
  if(rosterIt != roster.end()) // found player?
    return rosterIt->second; // iterator is of type pair; pair has first and second members which in this case are the key and the value
  else
    return NULL;
}

// returns a list of player pointers ordered by score (higher scores first)
std::list<ptrPlayer> Scoreboard::GetRanking()
{
  this->ranking.clear();
  std::map<std::string, ptrPlayer>::iterator rosterIt;
  for(rosterIt=roster.begin(); rosterIt != roster.end(); rosterIt++)
  {
    this->ranking.push_front(rosterIt->second); // add pointer of player from roster to list
  }
  
  this->ranking.sort(Player::compareScores); // sort list, using static score comparer from Player
  return this->ranking;
}

// returns a list of player pointers ordered by name (lexicographic sorting)
std::list<ptrPlayer> Scoreboard::GetSortedNames()
{
  this->playersByName.clear();
  std::map<std::string, ptrPlayer>::iterator rosterIt;
  for(rosterIt=roster.begin(); rosterIt != roster.end(); rosterIt++)
  {
    this->playersByName.push_front(rosterIt->second); // add pointer of player from roster to list
  }
  
  this->playersByName.sort(Player::compareNames); // sort list, using static name comparer from Player
  return this->playersByName;
}


bool Scoreboard::read(FILE* sourceFile)
{
  this->clear();
  
  bool error = false;
  
  if(sourceFile != NULL)
  { 
    while(!feof(sourceFile) && !error) // if there is still stuff left to read and no erros occured
    {
      ptrPlayer pNewPlayer = new Player(); // create new player in memory
      error = !pNewPlayer->Read(sourceFile); // try reading another player from the file
      if(!error)
      {
        this->addPlayer(pNewPlayer); // memory will be freed later in destructor
      }
      else
        delete pNewPlayer; // free memory immediately on error
    }
  }
  else 
    error = true;
  
  return !error;
}


bool Scoreboard::Read(char *fullSourceFileName)
{
  bool error = false;
  
  FILE* sourceFile = fopen(fullSourceFileName, "r"); // open file for reading
  if(sourceFile == NULL)
    error = true;
  else
    error = !this->read(sourceFile); // let other method read the players from the file
  
  // close file  
  if(sourceFile != NULL)
    fclose(sourceFile);
    
  return !error;
}


bool Scoreboard::write(FILE *targetFile)
{
  bool error = false;
  
  if(targetFile != NULL)
  {
    std::list<ptrPlayer> ranks = this->GetRanking();
    // write all players into file
    for(std::list<ptrPlayer>::iterator listItem=ranks.begin(); listItem != ranks.end(); listItem++)
    {
      error = !(*listItem)->Write(targetFile); // write player to file
      if(error)
        break;
    }    
  }
  else
    error = true;
 
  return !error;
}


bool Scoreboard::Write(char *fullTargetFileName)
{
  bool error = false;
  
  FILE* targetFile = fopen(fullTargetFileName, "w"); // open file for writing
  if(targetFile == NULL)
    error = true;
  else
    error = !this->write(targetFile); // let other method write the players to the file
  
  // close file  
  if(targetFile != NULL)
    fclose(targetFile);
    
  return !error;
}
