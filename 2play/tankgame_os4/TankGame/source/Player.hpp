/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include <stdio.h>
#include <string>

#if !defined(_Player_HEAD_INCLUDED)
#define _Player_HEAD_INCLUDED

class Player;
typedef Player* ptrPlayer;

// class to handle player information
class Player
{
  private:
    std::string name; // player name for ingame display and scoreboard
    unsigned int gamesWon; // number of games won
    unsigned int gamesWonFlawless; // number of games won without taking damage 
    unsigned int gamesPlayed; // total number of games played

    void init();
    void init(std::string name, unsigned int gW, unsigned int gWF, unsigned int gP);

  public:
    // constructors
    Player();
    Player(std::string name, unsigned int gW, unsigned int gWF, unsigned int gP);
    // destructor
    ~Player();

    // accessors
    void IncreaseWin(bool flawless); // also increases gamesPlayed
    void IncreaseGamesPlayed();

    std::string GetName() { return this->name; }
    unsigned int GetGamesWon() { return this->gamesWon; }
    unsigned int GetGamesWonFlawless() { return this->gamesWonFlawless; }
    unsigned int GetGamesPlayed() { return this->gamesPlayed; }

    // read/write from/to FILE
    // return true on success
    bool Write(FILE* targetFile);
    bool Read(FILE* sourceFile);
    
    // returns true, if the first player has higher score than the second
    // (used for ranking in Scoreboard)
    static bool compareScores(ptrPlayer pA, ptrPlayer pB);  
    
    // returns true, if the first player comes first in lexicographic sorting
    // (used for sorted roster from scoreboard)
    static bool compareNames(ptrPlayer pA, ptrPlayer pB);
};

#endif // #if !defined(_Player_HEAD_INCLUDED)
