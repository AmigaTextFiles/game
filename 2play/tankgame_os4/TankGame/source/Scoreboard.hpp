/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Player.hpp"
#include <string>
#include <vector>
#include <map>
#include <list>
#include <stdio.h>

#if !defined(_Scoreboard_HEAD_INCLUDED)
#define _Scoreboard_HEAD_INCLUDED

class Scoreboard;
typedef Scoreboard* ptrScoreboard;

// a class to handle the scores for the players
class Scoreboard
{
  private:
    std::map<std::string, ptrPlayer> roster; // will hold player data for each player
    std::list<ptrPlayer> ranking; // used for sorting and ranking
    std::list<ptrPlayer> playersByName; // used for sorting
  
    void init();
    void clear(); // removes all players from roster and frees used memory

    bool addPlayer(ptrPlayer pPlayer);

    bool read(FILE* sourceFile); // returns true on success
    bool write(FILE* targetFile); // returns true on success
    
  public:
    // constructor/destructor
    Scoreboard();
    ~Scoreboard();
    
    // accessors
    void Reset() { this->clear(); }
    bool RegisterPlayer(std::string name); // returns true on success
    bool RemovePlayer(std::string name); // returns true, if successfully removed
    
    bool PlayerExists(std::string name); // returns true, if a player with the given name exists
    ptrPlayer GetPtrPlayer(std::string name); // returns NULL if player does not exist or a pointer to a player object

    // returns a list of player pointers ordered by score (higher scores first)
    std::list<ptrPlayer> GetRanking();
    
    // returns a list of player pointers ordered by name (lexicographic sorting)
    std::list<ptrPlayer> GetSortedNames();

    // read/write roster from/to file (return true on success)
    bool Read(char* fullSourceFileName);
    bool Write(char* fullTargetFileName);
};

#endif // #if !defined(_Scoreboard_HEAD_INCLUDED)
