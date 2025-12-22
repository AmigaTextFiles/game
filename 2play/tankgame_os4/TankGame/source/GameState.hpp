/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include <allegro.h> // platform independent Allegro library

#include "Player.hpp"
#include "Scoreboard.hpp"
#include "myMath.hpp"
#include "Shot.hpp"
#include "Tank.hpp"
#include "Arena.hpp"
#include "Particles.hpp"

#include "logfile.hpp"

#include <stdio.h>
#include <string>

#if !defined(_GameState_HEAD_INCLUDED)
#define _GameState_HEAD_INCLUDED

namespace gfx
{
  enum gfxResources // index positions for bitmap array
  {
    ARMORBAR = 0,
    EXPL0 = 1,
    EXPL1 = 2,
    EXPL2 = 3,
    EXPL3 = 4,
    EXPL4 = 5,
    EXPL5 = 6,
    EXPL6 = 7,
    EXPL7 = 8,
    GTANKB = 9,
    GTANKG = 10,
    HEATBAR = 11,
    LAMP0 = 12,
    LAMP1 = 13,
    LEVER0 = 14,
    LEVER1 = 15,
    LEVER2 = 16,
    MUZZLE = 17,
    ROCK0 = 18,
    ROCK1 = 19,
    ROCK2 = 20,
    ROCK3 = 21,
    ROCK4 = 22,
    ROCK5 = 23,
    RTANKB = 24,
    RTANKG = 25,
    SHOT = 26,
    STATUS = 27,
    TIME = 28,
    ROCKSOLID = 29,
    PATTERN = 30,
    PATTERN2 = 31,
    PATTERN3 = 32,
    PATTERN4 = 33,
    PATTERN5 = 34,
    TANKTRACK = 35,
    TOTALNUMBEROFBITMAPSEXPECTED
  };
  
  enum gfxColors // index positions for color array
  {
    transparent = 0,
    white = 1,
    gray0 = 2,
    gray1 = 3,
    gray2 = 4,
    black = 5,
    lightred = 6,
    red = 7,
    magenta = 8,
    lightgreen = 9,
    green = 10,
    darkcyan = 11,
    yellow = 12,
    backgroundcolor = 13,
    NUMCOLORS
  };
}

namespace sfx
{
  enum sfxResources // index positions for sample array
  {
    alarm = 0,
    shoot = 1,
    c1ready = 2,
    c2ready = 3,
    explosion = 4,
    leverclick = 5,
    trackbaseGreen = 6,
    trackdmgMediumGreen = 7,
    trackdmgHugeGreen = 8,
    trackbaseRed = 9,
    trackdmgMediumRed = 10,
    trackdmgHugeRed = 11,
    trackRotateGreen = 12,
    trackRotateRed = 13,
    TOTALNUMBEROFWAVSEXPECTED
  };
}

// array to translate tile numbers from Arena.hpp to indices in gfxResources
// index position is the same as the value of the enumeration 'arenaTile' in Arena.hpp
// -1, means there is no gfxResource assigned to that tile
static const int tileToGfx[] = { -1, gfx::ROCK0, gfx::ROCK1, gfx::ROCK2, gfx::ROCK3, gfx::ROCK4,
                                 gfx::ROCK5, gfx::ROCKSOLID, -1, -1 };


enum menuState
{
  MainMenu = 0, // allow state change to all other states from this state
  ChoosePlayers = 1,  // allow state change to MainMenu from this state
  ViewScoreboard = 2, // allow state change to MainMenu from this state
  ViewManual = 3, // allow state change to MainMenu from this state
  InGame = 4 // allow state change to MainMenu from this state
};


class GameState;
typedef GameState* ptrGameState;

// this class handles everything related to input/game logic/update and display logic
// it also handles initialization/deinitialization of everything
class GameState
{
  private:
    // CONSTANTS (not defined as constants, because they will be read from configuration file
    // or set to default values elsewhere if no config file is found)
    bool preferFullscreen;
    int preferredColorDepth;
    int logicUpdatesPerSecond;
    int framesPerSecond;
    int logicFramesPerMatch;
    int reloadDelay;
    int maxShots;
    int maxParticles;
    float heatGainPerShot;
    float heatGainPerHit;
    float heatFalloff;
    float damagePerHit;
    float maxHeat;
    float maxArmor;
    float maxSpeed;
    float maxSpeedRubble;
    float acceleration;
    float shotSpeed;
    float gunRotationSpeed;
    float bodyRotationSpeed;
    
    // for logging
    ptrLogfile pLogfile;
    
    // for gfx resources
    BITMAP* pBitmap[gfx::TOTALNUMBEROFBITMAPSEXPECTED];
    // backbuffer for flicker-free rendering
    BITMAP* backbuffer;
    
    // for sfx resources
    SAMPLE* pSample[sfx::TOTALNUMBEROFWAVSEXPECTED];
    bool soundAvailable;
    bool reverseStereo;
    
    // some color constants (set after loading the palette)
    int color[gfx::NUMCOLORS];
    
	  // for keeping in-game objects
	  std::string playerOneName; // references player in scores, currently assigned to green tank
	  std::string playerTwoName; // references player in scores, currently assigned to red tank
  	
	  Tank tankGreen; // for green tank (player ones tank)
	  Tank tankRed; // for red tank (player twos tank)
  	
	  Arena battleArena; // holds the current battleArena
    std::string* arenaFileName; // holds filenames found in maps folder
    int numMaps; // holds number of filenames found in maps folder
    int currentMap; // holds index of currently loaded map
	  Scoreboard scores; // holds the full roster of players and their scores
	  std::list<ptrPlayer> currentRanking; // holds a copy of player rankings
	  
	  // for match time control
	  int logicFramesLeft;
	  
    int runLevel; // for Allegro startup/shutdown control
    
    void init();
    void shut();
    
    void resetConstants(); // sets constants to default values
    void validateConstants(); // checks for nonsensical values and sets safe values instead
    bool readConstants(FILE* configFile); // returns true on success
	  bool writeConstants(FILE* configFile); // returns true on success
  
    void saveScoreboard();
  
    int loadGfxResources(); // returns TOTALNUMBEROFBITMAPSEXPECTED on success or the first bitmap index that failed loading
    void freeGfxResources(); // frees memory used by bitmap resources

    int loadSfxResources(); // returns TOTALNUMBEROFWAVSEXPECTED on success or the first sample index that failed loading    
    void freeSfxResources(); // frees memory used by sample resources
    
// VIEW LOGIC 
    // for displaying various states of the game
    void backbufferToScreen();
    void renderErrorMessage(std::string message);
    void renderMenuBox(int cx, int cy, int hW, int hH, int borderColor, int bgColor);
    void renderHint(std::string hintA, std::string hintB);
    void renderMainMenu(std::string items[], int numItems, int selectedItem);
    void renderPlayerSelection(std::string highlightedPlayerName, int cursorPos, std::string newPlayerName);
    void renderScoreboard(int firstIndex);
    void renderManual(std::list<std::string>& lineList, std::list<std::string>::iterator topLine);
    void renderCurrentMap();
    void renderTanks(ptrFlPoint2D pGreenTankPos, ptrFlPoint2D pRedTankPos);
    void renderStatusDisplay(bool displayTimer);
    void renderParticle(ptrParticle pParticle); // renders a single particle
    void renderParticles(int layer); // renders all particles of a certain group
    void renderInGameAction(bool matchEndedRegularly, bool timeout, int winner);
    void playSound(sfx::sfxResources toPlay, float px);
    int playSound(sfx::sfxResources toPlay, float px, float py, float speed, int loop);
    void adjustSound(sfx::sfxResources toAdjust, float px, float py, float speed, int loop);
    void stopSound(sfx::sfxResources toStop);
    void adjustVoice(int voice, float px, float py);
// END OF VIEW LOGIC


// CONTROLLER LOGIC  
    ptrShot pShotArray; // dynamic array for in game shots
  	int nextShotToReuse; // shots are simply reused after cycling through the array
  	bool initShotArray(); // reserves shots memory
  	void freeShotArray(); // frees shots memory
  	bool spawnShot(flPoint2D pos, float angle, float speed, int owner); // spawns a new shot (returns true on success)
  	
  	ptrParticle pParticleArray; // dynamic array for eye candy effects
  	int nextParticleToReuse; // particles are reused after cycling through the array
  	bool particlesAvailable;
  	bool initParticleArray(); // reserve memory for particles (returns true, if particles can be spawned)
  	void freeParticleArray(); // free particle memory
  	void spawnParticle(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl); // spawns a new particles
    // particles are really just for eye candy and not critical to the game logic,
    // so "spawnParticle" does not return anything about success or failure)  	
  	
  	// returns tileNumber, if a given position collides with any hittable tile or a
  	// negative number if no collision is detected (-2 if the tile underneath is rubble)
  	// if adjustTileNumber is set to true, this also changes the tile that was hit, to
    // increase its level of destruction
  	int positionCollidesWithTile(ptrFlPoint2D pPos, bool adjustTileNumber);
  	
  	// returns true if a given position would collide with a rotated tank at another position
  	bool positionCollidesWithTank(ptrFlPoint2D pos, ptrFlPoint2D tankPos, float tAngle);
    
    
    int gatherMaps(); // fills array with filenames from map folder and returns number of found files
    void selectMap(int offsetToCurrent); // loads a different map
    
    void gatherPlayers(); // loads players at startup and takes care that there are at least two players
    
    void controlMainMenu();
    void controlPlayerSelection();
    void controlScoreboard();
    void controlManual();
    void controlInGameObjects(float& tgGd, float& tgBd, float& trGd, float& trBd, bool gwtf, bool gwte, bool rwtf, bool rwte); // performs logic updates/and collision detection
    void controlInGameAction();
// END OF CONTROLLER LOGIC
    
  public:
    // constructor/destructor
    GameState();
    ~GameState();
    
    // methods
    int StartupAl(); // initializes Allegro, graphics mode, input handlers, etc. (returns 0 on success)
    void ShutdownAl(); // deinitializes Allegro
    
    int LoadResources(); // loads all resources (returns 0 on success)
    void FreeAllResources(); // frees memory used by resources
	
	  // tries to load constants from configuration file 
	  // (or creates that file with default values, if it does not exist)
	  // returns 0 if configuration was loaded successfully
	  // returns 1 if configuration was created successfully
	  // returns -1 if configuration was set but could not be created
	  int LoadConfiguration(char* configFileName);	  
      
    // runs the actual game (starting at the initial state, which is the main menu)
    void RunMainMenu();
      
    // for DEBUG (just displays all loaded bitmaps as a test and waits a few seconds)
    void __DisplayGraphics();
};

#endif // #if !defined(_GameState_HEAD_INCLUDED)
