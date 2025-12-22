/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "GameState.hpp"

// some stuff needed for compiling with newer GNU C compiler version, due to the restructuring of c++ headers
#ifdef __GNUC__
#include <string.h>
#include <cstdlib>
#include <cstring>
#endif

// macro for quick log access
#define LOG(logMsgType,logMessage) if(pLogfile!=NULL) pLogfile->Writeline(true, logMsgType, logMessage);

// expected file names for bitmaps to load (same order as in the enumeration gfxResources)
static const char* bitmapFileNames[] = { "ARMORBAR.PCX", "EXPL0.PCX", "EXPL1.PCX", "EXPL2.PCX", "EXPL3.PCX",
                                  "EXPL4.PCX", "EXPL5.PCX", "EXPL6.PCX", "EXPL7.PCX", "GTANKB.PCX",
                                  "GTANKG.PCX", "HEATBAR.PCX", "LAMP0.PCX", "LAMP1.PCX", "LEVER0.PCX",
                                  "LEVER1.PCX", "LEVER2.PCX", "MUZZLE.PCX", "ROCK0.PCX", "ROCK1.PCX",
                                  "ROCK2.PCX", "ROCK3.PCX", "ROCK4.PCX", "ROCK5.PCX", "RTANKB.PCX",
                                  "RTANKG.PCX", "SHOT.PCX", "STATUS.PCX", "TIME.PCX", "ROCKSOLID.PCX", 
                                  "PATTERN.PCX", "PATTERN2.PCX", "PATTERN3.PCX", "PATTERN4.PCX", "PATTERN5.PCX",
                                  "TANKTRACK.PCX" };

// expected file names for samples to load (same order as in the enumeration sfxResources)                                  
// (the track sounds are loaded multiple times, so different copies of them can be manipulated during playback
//  according to each tanks individual status)
static const char* waveFileNames[] = { "alarm.wav", "boom.wav", "c1ready.wav", "c2ready.wav", "phroooo.wav",
                                       "switch.wav", "trackbase.wav", "trackdamaged2.wav", "trackdamaged.wav",
                                                     "trackbase.wav", "trackdamaged2.wav", "trackdamaged.wav",
                                                     "tracksrotate.wav", "tracksrotate.wav" };

// local inline class for handling keyboard input more conveniently than with vanilla Allegro key array
namespace kb
{
  enum keyEvents
  {
    keyUndefined = 0,
    keyPressed = 1,
    keyUp = 2,
    keyDown = 3
  };
}

class KeyState
{
  private:
    bool prevState; // state as of the last time that Update method was called
    bool currentState; // state as of the current time that Update method was called
    int alKey; // Allegro keyboard constant
  
  public:
    KeyState(int alKey) { this->alKey = alKey; prevState = false; currentState = false; };
    ~KeyState() { /* nothing to do */ };
    
    // updates currentState and prevState 
    // (returns 1 if key is pressed, returns 2 if key went from pressed to not pressed
    //  return 3 if key went from not pressed to pressed, return 0 if none of that is true)
    // (also note that there are three extra methods to check that, after calling this one)
    int Update()
    {
      this->prevState = this->currentState;
      this->currentState = key[alKey];
      if(this->KeyDown())
        return kb::keyDown;
      if(this->KeyUp())        
        return kb::keyUp;
      if(this->KeyPressed())
        return kb::keyPressed;
      else
        return kb::keyUndefined;
    }
    
    void Reset() { this->prevState = false; this->currentState = false; }
    
    // methods to check what happened in Update
    bool KeyDown() { return (!this->prevState && this->currentState); }
    bool KeyUp() { return (this->prevState && !this->currentState); }
    bool KeyPressed() { return this->currentState; }
    
    // this static function only needs to be called once each cycle, not for every key to check
    static void UpdateKeyboard() 
    { 
      if(keyboard_needs_poll()) 
        poll_keyboard(); 
    }
};
// end of local inline class for handling keyboard input


GameState::GameState()
{
  this->init();
}

GameState::~GameState()
{
  this->shut();
}

void GameState::init()
{
  this->pLogfile = NULL;
  this->pLogfile = new (std::nothrow) Logfile("errorLog.txt", "TankGame"); // create new logfile object
  
  this->runLevel = 0;
  
  // set all bitmap pointers to NULL
  for(int i=0; i<gfx::TOTALNUMBEROFBITMAPSEXPECTED; i++)
    this->pBitmap[i] = NULL;
    
  // set all sample pointers to NULL
  for(int i=0; i<sfx::TOTALNUMBEROFWAVSEXPECTED; i++)
    this->pSample[i] = NULL;
  
  this->soundAvailable = false;
  this->reverseStereo = false;
	
  // set player references to nothing (these will be set first in 'gatherPlayers')
  this->playerOneName.assign("error");
  this->playerTwoName.assign("error");
  
  // reset battleArena
  this->battleArena.ResetAndClear();
  
  // set arenaFileName to NULL
  this->arenaFileName = NULL;
  this->numMaps = 0;
  this->currentMap = 0;
}

void GameState::shut()
{
  if(pLogfile != NULL) // free logfile object
    delete (this->pLogfile);
	
  // player pointers don't need to be freed, because
  // they are already freed in Scoreboard
  
  // battleArena does not need to be freed, because
  // it is freed in destructor
  
  // free arenaFileNames
  if(this->arenaFileName != NULL)
    delete [] this->arenaFileName;
  
  this->numMaps = 0;
  this->currentMap = 0;
}

int GameState::StartupAl()
{
  static bool firstRun = true;
  if(!firstRun) // disallow starting up multiple times
    return -1;
  firstRun = false;

  this->runLevel = 0;
  
  LOG(Logging::logProgress, "GameState starting up...")
  
  // initialize allegro
  set_uformat(U_ASCII); // use ASCII with Allegro
  LOG(Logging::logProgress, "allegro_init()...")
  if(allegro_init())
  {
    LOG(Logging::logProgressError, "allegro_init() failed.")
    return 1;
  }
  else
  {
    LOG(Logging::logProgressOk, "allegro_init() succeeded.")
    this->runLevel = 1;
  }
  
  // set color depth
  int colorDepth = preferredColorDepth;
  char cDepthString[8];
  memset((void*)&cDepthString[0], 0, sizeof(char)*8);
  sprintf(&cDepthString[0], "%i", colorDepth);
  
  // set graphics mode
  set_color_depth(colorDepth);

  // set mode based on constant   
  int mode = this->preferFullscreen ? GFX_AUTODETECT_FULLSCREEN : GFX_AUTODETECT_WINDOWED;

  if(mode == GFX_AUTODETECT_FULLSCREEN)
  {
    LOG(Logging::logProgress, "set_gfx_mode(GFX_AUTODETECT_FULLSCREEN, 800, 600, 0, 0)...")  
  }
  else
  {
    LOG(Logging::logProgress, "set_gfx_mode(GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0)...")    
  }
      
  if(set_gfx_mode(mode, 800, 600, 0, 0) != 0)
  {
    LOG(Logging::logProgressError, "set_gfx_mode() failed.")
	
	// try windowed mode now, if previous mode set (for fullscreen) failed
	if(mode == GFX_AUTODETECT_FULLSCREEN)
	{
	  LOG(Logging::logProgress, "alternative set_gfx_mode(GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0)...")
      if(set_gfx_mode(GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0) != 0)
	  {
	    LOG(Logging::logProgressError, "alternative set_gfx_mode() failed as well.")
		return 2;
	  }
	  else
	  {
	    LOG(Logging::logProgressOk, "alternative set_gfx_mode() succeeded.")
		this->runLevel = 2;
	  }
	}
  }
  else
  {
    LOG(Logging::logProgressOk, "set_gfx_mode() succeeded.")
    this->runLevel = 2;
  }
  
  // create the backbuffer (used for flicker-free rendering)
  backbuffer = NULL;
  LOG(Logging::logProgress, "creating 800x600x"+string(cDepthString)+" backbuffer...")
  backbuffer = create_bitmap_ex(colorDepth, 800, 600);
  if(backbuffer == NULL)
  {
    LOG(Logging::logProgressError, "creating 800x600x"+string(cDepthString)+" backbuffer failed.")
    return 2;
  }
  else
  {
    LOG(Logging::logProgressOk, "creating 800x600x"+string(cDepthString)+" backbuffer succeeded.")
    set_clip_rect(this->backbuffer, 0, 0, 799, 599);
    this->runLevel = 2;
  }
  
  // set window title
  set_window_title("TankGame 1.0e, Build: 4th Jan 2010");
  
  // initialize keyboard handler
  LOG(Logging::logProgress, "install_keyboard()...")
  if(install_keyboard() != 0)
  {
    LOG(Logging::logProgressError, "install_keyboard() failed.")
    return 3;
  }
  else
  {
    LOG(Logging::logProgressOk, "install_keyboard() succeeded.")
    this->runLevel = 3;
  }
  
  // initialize mouse handler
  LOG(Logging::logProgress, "install_mouse()...")
  if(install_mouse() == -1)
  {
    LOG(Logging::logProgressError, "install_mouse() failed.")
    return 4;
  }
  else
  {
    LOG(Logging::logProgressOk, "install_mouse() succeeded.")
    this->runLevel = 4;
  }
  
  // initialize timer handler
  LOG(Logging::logProgress, "install_timer()...")
  if(install_timer() != 0)
  {
    LOG(Logging::logProgressError, "install_timer() failed.")
    return 5;
  }
  else
  {
    LOG(Logging::logProgressOk, "install_timer() succeeded.")
    this->runLevel = 5;
  }
  
  // initialize sound subsystem
  LOG(Logging::logProgress, "install_sound()...")
  if(install_sound(DIGI_AUTODETECT, MIDI_NONE, "") != 0)
  {
    LOG(Logging::logProgressError, "install_sound() failed. Sound output disabled.")
    this->soundAvailable = false;
  }
  else
  {
    LOG(Logging::logProgressOk, "install_sound() succeeded. Sound enabled.")
    this->soundAvailable = true;
  }
    
  LOG(Logging::logProgressOk, "GameState started up.")
  
  return 0;
}

void GameState::ShutdownAl()
{
  LOG(Logging::logProgressOk, "GameState shutting down...")

  if(this->soundAvailable)
  {
    remove_sound();
    this->soundAvailable = false;
  }

  if(this->runLevel >= 5)
  {
    LOG(Logging::logProgress, "remove_timer()...")
    remove_timer();
    LOG(Logging::logProgressOk, "remove_timer() succeeded.")
  }

  if(this->runLevel >= 4)
  {
    LOG(Logging::logProgress, "remove_mouse()...")
    remove_mouse();
    LOG(Logging::logProgressOk, "remove_mouse() succeeded.")
  }

  if(this->runLevel >= 3)
  {
    LOG(Logging::logProgress, "remove_keyboard()...")
    remove_keyboard();
    LOG(Logging::logProgressOk, "remove_keyboard() succeeded.")
  }

  if(this->runLevel >= 2)
  {
    if(backbuffer != NULL)
    { 
      LOG(Logging::logProgress, "releasing backbuffer...")
      destroy_bitmap(backbuffer);
      LOG(Logging::logProgressOk, "backbuffer released.")
    }
  
    LOG(Logging::logProgress, "set_gfx_mode(GFX_TEXT, 80, 25, 0, 0)...")
    set_gfx_mode(GFX_TEXT, 80, 25, 0, 0);
    LOG(Logging::logProgressOk, "set_gfx_mode() succeeded.")
  }

  if(this->runLevel >= 1)
  {
    LOG(Logging::logProgress, "allegro_exit()...");
    allegro_exit();
    LOG(Logging::logProgressOk, "allegro_exit() succeeded.")
  }
  
  LOG(Logging::logProgressOk, "GameState shut down.")
}

int GameState::loadGfxResources()
{
  // fixes color problem in Windows7 hicolor modes (hopefully)
  set_color_conversion(COLORCONV_8_TO_15 |
                       COLORCONV_8_TO_16 |
                       COLORCONV_8_TO_24 |
                       COLORCONV_8_TO_32 |
                       COLORCONV_KEEP_TRANS);

  int i = 0;
  PALETTE p; // for holding color data from the loaded graphics (overwritten on each loaded image)
  bool paletteSet = false;
  
  while(i < gfx::TOTALNUMBEROFBITMAPSEXPECTED)
  {
    BITMAP* nextBitmap = NULL;
    
    // prepare bitmap filename
    std::string fName;
    fName.assign("./gfx/");
    fName.append(bitmapFileNames[i]);
    
    // try to load bitmap file
    LOG(Logging::logProgress, "loading bitmap resource: "+fName)
    nextBitmap = load_pcx(fName.c_str(), p);
    if(nextBitmap == NULL)
    {
      LOG(Logging::logProgressError, "failed to load a needed bitmap resource: "+fName)
      break;
    }
    else
    {
      if(!paletteSet) // set global palette to that of first successfully loaded bitmap resource
      {
        set_palette(p);
        
        // set color constants (depend on palette, so they must be set here, after the palette is loaded)
        this->color[gfx::transparent] = -1;
        this->color[gfx::white] = makecol(255,255,255);
        this->color[gfx::gray0] = makecol(192,192,192);
        this->color[gfx::gray1] = makecol(128,128,128);
        this->color[gfx::gray2] = makecol(64,64,64);
        this->color[gfx::black] = makecol(0,0,0);
        this->color[gfx::lightred] = makecol(255,162,128);
        this->color[gfx::red] = makecol(192,64,64);
        this->color[gfx::magenta] = makecol(115,29,115);
        this->color[gfx::lightgreen] = makecol(128,255,148);
        this->color[gfx::green] = makecol(32,192,32);
        this->color[gfx::darkcyan] = makecol(29,115,115);
        this->color[gfx::yellow] = makecol(255,255,0);
        if(get_color_depth() == 8)
          this->color[gfx::backgroundcolor] = 0;
        else
          this->color[gfx::backgroundcolor] = makecol(162,81,24);
        
        paletteSet = true;
      }
      
      LOG(Logging::logProgressOk, "bitmap resource loaded: "+fName)
      
      // store bitmap pointer in bitmap resources array
      pBitmap[i] = nextBitmap; // memory will be freed later in freeGfxResources()
    }
    
    i++;
  }
  // if all bitmaps were loaded, i is now equal to TOTALNUMBEROFBITMAPSEXPECTED
  
  return i;
}

void GameState::freeGfxResources()
{
  LOG(Logging::logProgress, "releasing all graphic resources...")
  for(int i=0; i<gfx::TOTALNUMBEROFBITMAPSEXPECTED; i++)
  {
    if(pBitmap[i] != NULL)
      destroy_bitmap(pBitmap[i]);
  }
  LOG(Logging::logProgressOk, "all graphic resources released.")
}

int GameState::loadSfxResources()
{
  if(soundAvailable)
  {
    int i = 0;
    
    while(i < sfx::TOTALNUMBEROFWAVSEXPECTED)
    {
      if(i == sfx::trackbaseRed)
        LOG(Logging::logMsg, "loading individual copies of track sounds for second player")
    
      SAMPLE* nextSample = NULL;
      
      // prepare sample filename
      std::string fName;
      fName.assign("./sfx/");
      fName.append(waveFileNames[i]);
      
      // try to load sample file
      LOG(Logging::logProgress, "loading sample resource: "+fName)
      
      nextSample = load_wav(fName.c_str());
      if(nextSample == NULL)
      {
        LOG(Logging::logProgressError, "failed to load a needed sample resource: "+fName)
        break;
      }
      else
      {
        LOG(Logging::logProgressOk, "sample resource loaded: "+fName)
        
        // store sample pointer in sample resources array
        pSample[i] = nextSample; // memory will be freed later in freeSfxResources()
      }
      
      i++;
    }
    // if all samples were loaded, i is now equal to TOTALNUMBEROFWAVSEXPECTED
    
    return i;
  }
  else
    return 0;
}

void GameState::freeSfxResources()
{
  if(soundAvailable)
  {
    LOG(Logging::logProgress, "releasing all sample resources...")
    for(int i=0; i<sfx::TOTALNUMBEROFWAVSEXPECTED; i++)
    {
      if(pSample[i] != NULL)
        destroy_sample(pSample[i]);
    }
    LOG(Logging::logProgressOk, "all sample resources released.")
  }
}

int GameState::LoadResources()
{
  int gfxLoadResult = this->loadGfxResources();
  
  LOG(Logging::logProgress, "loading graphic resources...")
  if(gfxLoadResult != gfx::TOTALNUMBEROFBITMAPSEXPECTED)
  {
    LOG(Logging::logProgressError, "failed to load graphic resources.")
    return -1;
  }
  LOG(Logging::logProgressOk, "graphic resources successfully loaded.")
  
  
  if(this->soundAvailable)
  {
    int sfxLoadResult = this->loadSfxResources();
    LOG(Logging::logProgress, "loading sample resources...")
    if(sfxLoadResult != sfx::TOTALNUMBEROFWAVSEXPECTED)
    {
      LOG(Logging::logProgressError, "failed to load sample resources.")
      return 0; // even if a sample is missing, let's still allow the game to run
    }
    LOG(Logging::logProgressOk, "sample resources successfully loaded.")
  }
  
  return 0;
}

void GameState::FreeAllResources()
{
  this->freeGfxResources();
  this->freeSfxResources();
}

void GameState::resetConstants()
{
  LOG(Logging::logMsg, "resetting constants to hardcoded values")

  this->preferFullscreen = false;
  this->preferredColorDepth = 32;
  this->reverseStereo = false;
  this->logicUpdatesPerSecond = 30;
  this->framesPerSecond = 30;
  this->logicFramesPerMatch = logicUpdatesPerSecond*60*5; // five minutes
  this->reloadDelay = 45; // delay is in number of logic cycles needed
  this->maxShots = 100;
  this->maxParticles = 400;
  this->heatGainPerShot = 20.0f;
  this->heatGainPerHit = 40.0f;
  this->heatFalloff = 0.2f;
  this->damagePerHit = 20.0f;
  this->maxHeat = 100.0f;
  this->maxArmor = 100.0f;
  this->maxSpeed = 1.75f;
  this->maxSpeedRubble = 0.90f;
  this->acceleration = 0.0725f;
  this->shotSpeed = 3.5f;
  this->gunRotationSpeed = 1.8f;
  this->bodyRotationSpeed = 1.25f;
}

void GameState::validateConstants()
{
  if(this->preferredColorDepth != 8 && this->preferredColorDepth != 16
     && this->preferredColorDepth != 24 && this->preferredColorDepth != 32)
     this->preferredColorDepth = 8;
  if(this->logicUpdatesPerSecond <= 0)
    this->logicUpdatesPerSecond = 30;
  if(this->framesPerSecond <= 0)
    this->framesPerSecond = 30;
  if(this->logicFramesPerMatch < this->logicUpdatesPerSecond * 60)
    this->logicFramesPerMatch = this->logicUpdatesPerSecond * 60;  // at least one minute
  if(this->reloadDelay < 1)
    this->reloadDelay = 1;
  if(this->maxShots < 50)
    this->maxShots = 50;
  if(this->maxParticles < 0)
    this->maxParticles = 50;
  if(this->heatGainPerShot < 0.0f) // disallow negative heatGain
    this->heatGainPerShot = 0.0f;
  if(this->heatGainPerHit < 0.0f)
    this->heatGainPerHit = 0.0f;
  if(this->heatFalloff < 0.0f) // disallow negative heatFalloff
    this->heatFalloff = 0.0f;
  if(this->damagePerHit < 0.0f) // disallow negative damage
    this->damagePerHit = 0.0f;
  if(this->maxHeat <= 0.0f) // disallow non-positive maxHeat
    this->maxHeat = 100.0f;
  if(this->maxArmor <= 0.0f) // disallow non-positive maxDamage
    this->maxArmor = 100.0f;
  if(this->maxSpeed <= 0.0f) // disallow negative maxSpeed
    this->maxSpeed = 0.5f;
  if(this->maxSpeedRubble <= 0.0f)
    this->maxSpeedRubble = this->maxSpeed / 2.0f;
  if(this->acceleration <= 0.0f) // disallow non-positive acceleration
    this->acceleration = this->maxSpeed / 10.0f;
  if(this->shotSpeed <= 0.0f) // disallow stationary shots
    this->shotSpeed = this->maxSpeed * 3.0f;
  if(this->gunRotationSpeed <= 0.0f)
    this->gunRotationSpeed = this->maxSpeed * 6.0f;
  if(this->bodyRotationSpeed <= 0.0f)
    this->bodyRotationSpeed = this->gunRotationSpeed / 3.0f;
}

bool GameState::readConstants(FILE* configFile)
{
  bool retVal = true;
  
  // initialize and clear buffers for reading configuration lines
  char description[255];
  char value[255];
  memset((void*)&description[0], 0, sizeof(char)*255);
  memset((void*)&value[0], 0, sizeof(char)*255);
  
  this->resetConstants(); // set default constants first
  
  // now overwrite all constants with those that are found in the file
  while(!feof(configFile) && retVal) // still stuff to read?
  {    
	  int valuesRead = fscanf(configFile, "%s = %s\n", description, value);
  	
	  if(ferror(configFile) != 0) // error?
	    retVal = false;
  	
	  if(valuesRead == 2 && valuesRead != EOF) // found a valid config line?
	  {	
		  // evaluate found description and set constant accordingly
		  if(strcmp(description, "preferFullscreen") == 0)
		  {
		    this->preferFullscreen = (atoi(value) >= 1);
		    LOG(Logging::logMsg, "preferFullscreen read from configfile as "+std::string(value))
		  }
		  
		  if(strcmp(description, "reverseStereo") == 0)
		  {
		    this->reverseStereo = (atoi(value) >= 1);
		    LOG(Logging::logMsg, "reverseStereo read from configfile as "+std::string(value))
		  }
		  
		  if(strcmp(description, "preferredColorDepth") == 0)
		  {
		    this->preferredColorDepth = atoi(value);
		    LOG(Logging::logMsg, "preferredColorDepth read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "logicUpdatesPerSecond") == 0)
		  {
		    this->logicUpdatesPerSecond = atoi(value);
		    LOG(Logging::logMsg, "logicUpdatesPerSecond read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "framesPerSecond") == 0)
		  {
		    this->framesPerSecond = atoi(value);
		    LOG(Logging::logMsg, "framesPerSecond read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "logicFramesPerMatch") == 0)
		  {
		    this->logicFramesPerMatch = atoi(value);
		    LOG(Logging::logMsg, "logicFramesPerMatch read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "reloadDelay") == 0)
		  {
		    this->reloadDelay = atoi(value);
		    LOG(Logging::logMsg, "reloadDelay read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "maxShots") == 0)
		  {
		    this->maxShots = atoi(value);
		    LOG(Logging::logMsg, "maxShots read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "maxParticles") == 0)
		  {
		    this->maxParticles = atoi(value);
		    LOG(Logging::logMsg, "maxParticles read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "heatGainPerShot") == 0)
		  {
		    this->heatGainPerShot = atof(value);
		    LOG(Logging::logMsg, "heatGainPerShot read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "heatGainPerHit") == 0)
		  {
		    this->heatGainPerHit = atof(value);
		    LOG(Logging::logMsg, "heatGainPerHit read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "heatFalloff") == 0)
		  {
		    this->heatFalloff = atof(value);
		    LOG(Logging::logMsg, "heatFalloff read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "damagePerHit") == 0)
		  {
		    this->damagePerHit = atof(value);
		    LOG(Logging::logMsg, "damagePerHit read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "maxHeat") == 0)
		  {
		    this->maxHeat = atof(value);
		    LOG(Logging::logMsg, "maxHeat read from configfile as = "+std::string(value))
		  }
  		
		  if(strcmp(description, "maxArmor") == 0)
		  {
		    this->maxArmor = atof(value);
		    LOG(Logging::logMsg, "maxArmor read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "maxSpeed") == 0)
		  {
		    this->maxSpeed = atof(value);
		    LOG(Logging::logMsg, "maxSpeed read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "maxSpeedRubble") == 0)
		  {
		    this->maxSpeedRubble = atof(value);
		    LOG(Logging::logMsg, "maxSpeedRubble read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "acceleration") == 0)
		  {
		    this->acceleration = atof(value);
		    LOG(Logging::logMsg, "acceleration read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "shotSpeed") == 0)
		  {
		    this->shotSpeed = atof(value);
		    LOG(Logging::logMsg, "shotSpeed read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "gunRotationSpeed") == 0)
		  {
		    this->gunRotationSpeed = atof(value);
		    LOG(Logging::logMsg, "gunRotationSpeed read from configfile as = "+std::string(value))
		  }
		  
		  if(strcmp(description, "bodyRotationSpeed") == 0)
		  {
		    this->bodyRotationSpeed = atof(value);
		    LOG(Logging::logMsg, "bodyRotationSpeed read from configfile as = "+std::string(value))
		  }	 
		} // ..if(valuesRead == 2 && valuesRead != EOF)
  } //..while(!feof(configFile) && retVal)
  
  return retVal;
}

bool GameState::writeConstants(FILE* configFile)
{
  bool retVal = true;
  
  // write information line at start of file (is not needed but looks nicer in file)
  retVal = fprintf(configFile, "#tankgame configuration file (editing this may break the game, be careful (delete this file to have the game create a fresh one))\n");
  
  // write all constants consecutively to the file, until an error occurs
  
  // game logic cycle and display constants
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "preferFullscreen", (this->preferFullscreen ? 1 : 0)) > 0;
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "preferredColorDepth", this->preferredColorDepth) > 0;
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "reverseStereo", (this->reverseStereo ? 1 : 0)) > 0;
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "logicUpdatesPerSecond", this->logicUpdatesPerSecond) > 0;
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "framesPerSecond", this->framesPerSecond) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %i\n", "logicFramesPerMatch", this->logicFramesPerMatch) > 0;
  
  // tank reload delay
  if(retVal)
	  retVal = fprintf(configFile, "%s = %i\n", "reloadDelay", this->reloadDelay) > 0;
  
  // game object counts
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "maxShots", this->maxShots) > 0;
  if(retVal)
    retVal = fprintf(configFile, "%s = %i\n", "maxParticles", this->maxParticles) > 0;
  
  // heat and armor constants
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "heatGainPerShot", this->heatGainPerShot) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "heatGainPerHit", this->heatGainPerHit) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "heatFalloff", this->heatFalloff) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "damagePerHit", this->damagePerHit) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "maxHeat", this->maxHeat) > 0;
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "maxArmor", this->maxArmor) > 0;
	
	// speeds and acceleration
	if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "maxSpeed", this->maxSpeed) > 0;
	if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "maxSpeedRubble", this->maxSpeedRubble) > 0;
	if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "acceleration", this->acceleration) > 0;  
	if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "shotSpeed", this->shotSpeed) > 0;
	if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "gunRotationSpeed", this->gunRotationSpeed) > 0;  
  if(retVal)
	  retVal = fprintf(configFile, "%s = %f\n", "bodyRotationSpeed", this->bodyRotationSpeed) > 0;    
	  
  return retVal;
}

void GameState::saveScoreboard()
{
  if(this->scores.Write("./players.tgs"))
  {
    LOG(Logging::logMsg, "Scoreboard saved to \"players.tgs\" after changes.")
  }
  else
  {
    this->renderErrorMessage("! - error saving scoreboard changes to file - !");
    LOG(Logging::logError, "Failed to save Scoreboard to \"players.tgs\" after changes.")
  }
}

int GameState::LoadConfiguration(char* configFileName)
{
  int retVal = 0;
  bool readError = false;
  
  // try reading configuration file
  LOG(Logging::logProgress, "reading configuration file: "+std::string(configFileName))
  
  FILE* configFile = fopen(configFileName, "r"); // open file for reading
  if(configFile != NULL) // opened successfully?
  {
    readError = !this->readConstants(configFile); // let other method read the config data  
	  
	  // close file
    fclose(configFile);
  }
  else
  {
    readError = true;
  }
  
  if(readError)  // error opening or reading?
  {
    LOG(Logging::logProgressError, "failed to read configuration file.")
    
    this->resetConstants(); // set constants to default values
  
    // try writing a standard configuration file
    LOG(Logging::logProgress, "writing configuration file: "+std::string(configFileName))
	  
	  FILE* targetFile = fopen(configFileName, "w"); // open file for writing
	  if(targetFile != NULL)
	  {
      if(this->writeConstants(targetFile)) // let other method write the config data
      {
	      retVal = 1;
	      LOG(Logging::logProgressOk, "configuration file written successfully.")
	    }
	    else
	    {
	      retVal = -1; 
	      LOG(Logging::logProgressError, "failed to write configuration file.")
	    }
  	
	    // close file
	    fclose(targetFile);
    }
  }
  else
  {
    LOG(Logging::logProgressOk, "configuration file read successfully.")
    retVal = 0;
  }
  
  this->validateConstants();
  
  return retVal;
}

// <non_member_function>
// for programme exit control (needed to handle exit button on window)
static volatile bool exitProgramme;
// will be called by Allegro, when the close button of the window is pressed
void closeButtonHandler()
{
  exitProgramme = true;
}
// </non_member_function>


int GameState::gatherMaps()
{
  // first free current map file names, if there are any
  if(this->arenaFileName != NULL)
    delete [] this->arenaFileName;

  // go into maps folder and look for .txt files and count them
  this->numMaps = 0;
  
  al_ffblk fileInfo;
  memset((void*)&fileInfo, 0, sizeof(fileInfo));
  if(al_findfirst("./maps/*.txt", &fileInfo, FA_ALL) == 0) // find first file
  {
    this->numMaps++;
    while(al_findnext(&fileInfo) == 0) // while there are still files found
      this->numMaps++;
  }
  // maps are now counted

  if(this->numMaps > 0) // found at least one map file?
  {
    // reserve arenaFileName array memory
    this->arenaFileName = new (std::nothrow) std::string[this->numMaps];
    
    // collect filenames into arenaFileName array
    memset((void*)&fileInfo, 0, sizeof(fileInfo));
    al_findfirst("./maps/*.txt", &fileInfo, FA_ALL);
    this->arenaFileName[0].assign(fileInfo.name);
    for(int i=1; i<this->numMaps; i++)
    {
      if(al_findnext(&fileInfo) == 0)
        this->arenaFileName[i].assign(fileInfo.name);
      else
        break;      
    }
  }  
  else // no files found?
  {
    // set safe default values for arenaFileName array
    this->numMaps = 1;
    
    // reserve arenaFileName array memory
    this->arenaFileName = new (std::nothrow) std::string[this->numMaps];
    
    // set safe default name for arenaFileName
    this->arenaFileName[0] = "!default";
  }
  
  // set current map to first found map file
  this->currentMap = 0;
  this->selectMap(0);
  
  return this->numMaps;
}

void GameState::selectMap(int offsetToCurrent)
{
  int mapToLoad = this->currentMap + offsetToCurrent;
  if(mapToLoad < 0)
    mapToLoad = this->numMaps + mapToLoad;
  else
    mapToLoad = mapToLoad % this->numMaps;
  
  // try loading previous map
  if(!this->battleArena.Read((char*)(std::string("./maps/")+arenaFileName[mapToLoad]).c_str())) // error?
  {
    // reload current map
    if(!this->battleArena.Read((char*)(std::string("./maps/")+arenaFileName[mapToLoad]).c_str())) // error?
    {
      // set default (hardcoded empty) map
      this->battleArena.ResetAndClear();
      this->battleArena.SetTile(5,10,playerAstart);
      this->battleArena.SetTile(20,10, playerBstart);
      
      this->currentMap = 0;
    }
  }
  else // success?
  {
    this->currentMap = mapToLoad;
  }
  
  // set initial tank positions
  flPoint2D posGreen;
  posGreen.x = 32.0f * ((float)this->battleArena.GetXcolumn()) + 16.0f;
  posGreen.y = 32.0f * ((float)this->battleArena.GetXline()) + 16.0f;
  this->tankGreen.Reset(posGreen, 0.0f, 0.0f, 0.0f, this->maxArmor);
  
  flPoint2D posRed;
  posRed.x = 32.0f * ((float)this->battleArena.GetYcolumn()) + 16.0f;
  posRed.y = 32.0f * ((float)this->battleArena.GetYline()) + 16.0f;
  this->tankRed.Reset(posRed, 180.0f, 180.0f, 0.0f, this->maxArmor);
}


void GameState::gatherPlayers()
{
  // try to load players file
  LOG(Logging::logMsg, "trying to read Scoreboard from file: \"players.tgs\"...")
  bool playersOk = this->scores.Read("./players.tgs");
  if(playersOk)
    LOG(Logging::logMsg, "Scoreboard file successfully read.")
  
  if(!playersOk) // error loading players?
  {
    LOG(Logging::logError, "error reading expected Scoreboard file: \"players.tgs\"")
  
    LOG(Logging::logProgress, "creating default players...")
    
    // reset scoreboard
    this->scores.Reset();
    
    // register two default players
    playersOk = this->scores.RegisterPlayer("Player One");
    if(playersOk)
      playersOk = this->scores.RegisterPlayer("Player Two");
    
    // try to save the new default players
    bool saveOk = false;
    if(playersOk)
    {
      LOG(Logging::logProgressOk, "default players successfully created.")
      
      LOG(Logging::logProgress, "saving default players to \"players.tgs\"...")
      saveOk = this->scores.Write("./players.tgs");
      if(saveOk)
      {
        LOG(Logging::logProgressOk, "default players successfully saved.")
      }
      else
      {
        LOG(Logging::logProgressError, "default players could not be saved but I will use players in memory.")
      }
    }
    else
    {
      LOG(Logging::logProgressError, "creating default players failed.")
      exitProgramme = true;
    }
    
  }
  // no else here, because of trickery in above block (creating default players)
  
  bool changedSomething = false;
  
  if(playersOk) // (note: playersOk could have been changed in the last block)
  {  
    // ensure that there are at least two players
    int numberOfPlayers = this->scores.GetSortedNames().size();
    
    // create additional players (max two)
    if(numberOfPlayers < 2) // need another player?
    {
      LOG(Logging::logProgress, "there were not at least two players available, creating additional players...")
      this->scores.RegisterPlayer("Player One"); // this is allowed to fail
    }
      
    numberOfPlayers = this->scores.GetSortedNames().size();
    
    if(numberOfPlayers < 2 && playersOk) // need yet another player and created previous one successfully?
    {
      playersOk = this->scores.RegisterPlayer("Player Two"); // this is not allowed to fail
      numberOfPlayers = this->scores.GetSortedNames().size();
      if(numberOfPlayers >= 2)
      {
        changedSomething = true;
        LOG(Logging::logProgressOk, "additionally needed players(s) created successfully.")
      }  
    }
    
    if(!playersOk || numberOfPlayers < 2) // failed to create minimum number of players required?
    {
      LOG(Logging::logProgressError, "giving up on trying to create players. sorry. goodbye.")
      exitProgramme = true;
    }
    else
    {
      if(changedSomething)
      {
        LOG(Logging::logProgress, "saving fixed players file...")
        if(this->scores.Write("./players.tgs"))
        {
          LOG(Logging::logProgressOk, "fixed players file saved.")
        }
        else
        {
          LOG(Logging::logProgressOk, "failed to save fixed players file.")
        } 
      }
    } 
  }
  
  if(playersOk) // now, if this is true here, we have at least two players
  {
    // select the first two players by default
    this->currentRanking = this->scores.GetSortedNames();
    std::list<ptrPlayer>::iterator plyIt = this->currentRanking.begin();
    this->playerOneName.assign( (*plyIt)->GetName() );
    plyIt++;
    this->playerTwoName.assign( (*plyIt)->GetName() );
  }
}


void GameState::controlMainMenu()
{
  exitProgramme = false;
  set_close_button_callback(closeButtonHandler);

  std::string menuItems[] = { std::string("Start Game"), 
                              std::string("Choose Players"), 
                              //std::string("Configure Controls"),
                              std::string("View Scores"),
                              std::string("View Manual"),
                              std::string("Exit Game") };
  int numItems = 5; // change this, if you add stuff to the above array                              
  int selectedItem = 0;
  int previousItem = -1; // for deciding when to redraw (-1 to redraw in first iteration of the loop below)
  bool arenaChanged = false; // also for deciding when to redraw
  bool forceRedraw = false; // for forcing redraw after returning from submenu
  
  // keys to use in main menu
  KeyState keyEscape(KEY_ESC);
  KeyState keyEnter(KEY_ENTER);
  KeyState keyLeft(KEY_LEFT);
  KeyState keyRight(KEY_RIGHT);
  KeyState keyDown(KEY_DOWN);
  KeyState keyUp(KEY_UP);
  
  // needed to ignore keystates from previous iteration after returning from submenus
  #define RESET_KEYSTATES_IN_THIS_FUNC keyEscape.Reset();keyEnter.Reset();keyLeft.Reset();keyRight.Reset();keyDown.Reset();keyUp.Reset();
  // for improved readability in loop below
  #define UPDATE_KEYSTATES_IN_THIS_FUNC keyEscape.Update();keyEnter.Update();keyLeft.Update();keyRight.Update();keyDown.Update();keyUp.Update();

  while(!exitProgramme) // while user does not want to exit
  {
    KeyState::UpdateKeyboard(); // updates Allegro key states
    
    // gather input states
    UPDATE_KEYSTATES_IN_THIS_FUNC
    
    // evaluate input states and react to changes
    if(keyUp.KeyDown())
      selectedItem--;
    if(keyDown.KeyDown())
      selectedItem++;
    
    if(selectedItem < 0) // need to wrap selection around on upper end?
      selectedItem = numItems + selectedItem;
    else // normalize selectedItem to number of items
      selectedItem = selectedItem % numItems;
    
    if(keyEnter.KeyUp())
    {
      // evaluate selectedItem and fire follow-up action accordingly
      switch(selectedItem)
      {
        case 4: // "Exit Game"
          exitProgramme = true;
        break;
		
        case 3: // "View Manual"
          this->controlManual();
          RESET_KEYSTATES_IN_THIS_FUNC
          forceRedraw = true;
        break;
        
        case 2: // "View Scores"
          this->controlScoreboard();
          RESET_KEYSTATES_IN_THIS_FUNC
          forceRedraw = true;
        break;
        
        //case 2: // "Configure Controls"
        //  // TODO
        //  RESET_KEYSTATES_IN_THIS_FUNC
        //  forceRedraw = true;
        //break;
        
        case 1: // "Choose Players"
          this->controlPlayerSelection();
          RESET_KEYSTATES_IN_THIS_FUNC
          forceRedraw = true;
        break;
        
        case 0: // "Start Game"
          this->controlInGameAction();
          RESET_KEYSTATES_IN_THIS_FUNC
          forceRedraw = true;
        break;
        
        default: // do nothing
        break;
      }
    }
    #undef RESET_KEYSTATES_IN_THIS_FUNC
    #undef UPDATE_KEYSTATES_IN_THIS_FUNC
    
    if(keyLeft.KeyDown())  // select next map
    {
      this->selectMap(-1);
      arenaChanged = true;
    }
    
    if(keyRight.KeyDown()) // select previous map
    {
      this->selectMap(1);
      arenaChanged = true;
    }
    
    if(keyEscape.KeyUp()) // user wants to exit?
    {
      exitProgramme = true;
    }
    
    // update display if anything has changed
    if(selectedItem != previousItem || arenaChanged || forceRedraw)
    {
      this->renderMainMenu(menuItems, numItems, selectedItem);
      forceRedraw = false;
    }
    
    previousItem = selectedItem;  
    rest(10); // wait a bit, so that the CPU is not used up to 100%
  }
}


void GameState::controlPlayerSelection()
{
  std::string highlightedName; // currently highlighted player name
  highlightedName.assign(this->playerOneName);
  
  bool exitPlayerSelection = false;
  bool forceRedraw = false;
  bool enteringNewPlayer = false;
  bool madeAnyChanges = false; // to control saving of Scoreboard on exit of this method
  int cursorPos = -1; // cursor position while entering new player name (-1, means, enteringNewPlayer is false, so that the render method knows what to show/hide)
  std::string newPlayerName; // for entering new player name
  
  this->currentRanking = this->scores.GetSortedNames(); // get player names
  
  // determine number of players
  int numPlayers = this->currentRanking.size();
  if(numPlayers <= 0)
  {
    exitPlayerSelection = true; // nothing to select, so exit immediately
  }
  
  if(exitPlayerSelection)
  {
    // log and show an error message
    LOG(Logging::logError, "error entering player selection: nothing to select from")
    this->renderErrorMessage("! - error entering player selection: nothing to select from - !");
  }
  
  // keys to use in player selector
  KeyState keyEscape(KEY_ESC);
  KeyState keyEnter(KEY_ENTER);
  KeyState keyDown(KEY_DOWN);
  KeyState keyUp(KEY_UP);
  KeyState keyPageUp(KEY_PGUP);
  KeyState keyPageDown(KEY_PGDN);
  KeyState keyPos1(KEY_HOME);
  KeyState keyEnd(KEY_END);
  KeyState keyLeft(KEY_LEFT);
  KeyState keyRight(KEY_RIGHT);
  KeyState keyDel(KEY_DEL);
  
  #define UPDATE_KEYSTATES_IN_THIS_FUNC keyEscape.Update();keyEnter.Update();keyDown.Update();keyUp.Update();keyPageUp.Update();keyPageDown.Update();keyPos1.Update();keyEnd.Update();keyLeft.Update(); keyRight.Update();keyDel.Update();
  
  // init iterator for going back and forth in player list
  std::list<ptrPlayer>::iterator currentPlayerIt = this->currentRanking.begin();
  std::list<ptrPlayer>::iterator previousPlayerIt = this->currentRanking.end();
  
  while(!exitProgramme && !exitPlayerSelection)
  {
    KeyState::UpdateKeyboard(); // updates Allegro key states
  
    // gather input states
    UPDATE_KEYSTATES_IN_THIS_FUNC
    
    // evaluate keys that are only active outside of registering new player logic
    if(!enteringNewPlayer)
    {
      // evaluate input states and react to changes
      if(keyEscape.KeyUp())
        exitPlayerSelection = true;
    
      // deleting players
      if(keyDel.KeyUp())
      {
        // check if deleting player is allowed
        if(this->currentRanking.size() > 2) // only delete if there are more than two players
        {
          // remember deleted player to be able to check if one of the players needs to be reselected from remaining players
          std::string deletedPlayerName;
          deletedPlayerName.assign((*currentPlayerIt)->GetName());
          
          if(!this->scores.RemovePlayer(deletedPlayerName))
          {
            LOG(Logging::logError, "failed to remove player from Scoreboard")
            this->renderErrorMessage("! - an error occured while trying to delete the player - !");
          }
          else
          {
            madeAnyChanges = true;
            //this->renderErrorMessage("Player '"+deletedPlayerName+"' has been deleted.");
            // rebuild list and reset highlighted player
            this->currentRanking = this->scores.GetSortedNames();
            currentPlayerIt = this->currentRanking.begin();
            previousPlayerIt = this->currentRanking.begin();
            
            std::string fPlyName = (*this->currentRanking.begin())->GetName(); // first name in list
            std::string sPlyName = (*(++(this->currentRanking.begin())))->GetName(); // second name in list
            
            // reselect players if either of them was just deleted (both at the same time is not possibly)
            if(deletedPlayerName == this->playerOneName)
            {
              if(fPlyName == this->playerTwoName)
                this->playerOneName.assign(sPlyName);
              else
                this->playerOneName.assign(fPlyName);
            }
            if(deletedPlayerName == this->playerTwoName)
            {
              if(fPlyName == this->playerOneName)
                this->playerTwoName.assign(sPlyName);
              else
                this->playerTwoName.assign(fPlyName);
            }
          }
        }        
        else // can not delete any more players
        {
          this->renderErrorMessage("! - you need to keep a minimum of two players - !");
        }
        forceRedraw = true;
        keyDel.Reset();
      }
    
      // selecting players
      if(keyLeft.KeyDown())
      {
        // assign currently highlighted player to green tank (if possible)
        if((*currentPlayerIt)->GetName() != this->playerTwoName)
        {
          this->playerOneName.assign((*currentPlayerIt)->GetName());
        }
        else // switch players
        {
          std::string tmpName;
          tmpName.assign(this->playerOneName);
          this->playerOneName.assign(this->playerTwoName);
          this->playerTwoName.assign(tmpName);
        }
        forceRedraw = true;
      }
      
      if(keyRight.KeyDown())
      {
        // assign currently highlighted player to red tank
        if((*currentPlayerIt)->GetName() != this->playerOneName)
        {
          this->playerTwoName.assign((*currentPlayerIt)->GetName());
        }
        else // switch players
        {
          std::string tmpName;
          tmpName.assign(this->playerOneName);
          this->playerOneName.assign(this->playerTwoName);
          this->playerTwoName.assign(tmpName);
        }
        forceRedraw = true;
      }
    
      // scrolling item by item
      if(keyDown.KeyUp())
        currentPlayerIt++;
      
      if(keyUp.KeyUp())
      {
        if(currentPlayerIt == this->currentRanking.begin()) // need wrap arount at top?
          currentPlayerIt = (this->currentRanking.end()); // go to item after last item (to enter register new player logic)
        else
          currentPlayerIt--;
      }
      
      // scrolling to top, to end
      if(keyPos1.KeyDown())
        currentPlayerIt = this->currentRanking.begin(); // go to first item in list
      if(keyEnd.KeyDown())
        currentPlayerIt = --(this->currentRanking.end()); // go to last item in list
      
      // scrolling page by page
      if(keyPageDown.KeyDown())
      {
        int count = 0;
        // advance the iterator by nine items
        while(currentPlayerIt != this->currentRanking.end() && count < 9)
        {
          currentPlayerIt++;
          count++;
        }
      }
      
      if(keyPageUp.KeyDown())
      {
        int count = 0;
        // rewind the iterator by nine items
        while(currentPlayerIt != this->currentRanking.begin() && count < 9)
        {
          currentPlayerIt--;
          count++;
        }
      }
    }
     
    // enter registering new player logic, if item past last item is set
    if(currentPlayerIt == this->currentRanking.end() && !enteringNewPlayer)
    {
      // reset selection
      currentPlayerIt = this->currentRanking.begin();
      
      // init enter new player name variables
      cursorPos = 0;
      newPlayerName.assign("                "); // 16 spaces are the default name
      
      enteringNewPlayer = true;  
      
      keyEscape.Reset();
      keyDown.Reset();
      keyUp.Reset();
      clear_keybuf(); // remove any keys in queue to prevent sideeffects
    }
    
    bool keyTreated;
    if(enteringNewPlayer) // evaluate keys that are active inside registering new player logic
    {
      keyTreated = false;
      
      if(keyEscape.KeyUp() || keyDown.KeyUp() || keyUp.KeyUp()) // cancel enter new player?
      {
        enteringNewPlayer = false;
        cursorPos = -1;
        if(keyUp.KeyUp()) // select last player if entry was cancelled by cursor up
          currentPlayerIt = --(this->currentRanking.end());
        keyEscape.Reset();
        keyDown.Reset();
      }
      
      if(keyEnter.KeyDown()) // confirm enter new player?
      {
        bool okRegistered = this->scores.RegisterPlayer(newPlayerName);
        if(!okRegistered)
        {
          this->renderErrorMessage("! - error, player probably already exists - !");
        }
        else // new player entered ok
        {
          // leave mode, update listing and highlight first player
          madeAnyChanges = true;
          enteringNewPlayer = false;
          cursorPos = -1;
          this->currentRanking = this->scores.GetSortedNames();
          currentPlayerIt = this->currentRanking.begin();
          previousPlayerIt = this->currentRanking.begin();
        }
        keyEnter.Reset();
        keyTreated = true;
        forceRedraw = true;
      }
      
      // check for any entered letters
      char c = '#';
      if(keypressed() && !keyTreated)
      {
        int value = readkey();
        c = (value & 0xff); // get ASCII code of pressed key from lower byte of the result from readkey()
        int scanCode = (value >> 8); // get SCANCODE of pressed key from higher byte of the result from readkey()
        
        if(scanCode == KEY_BACKSPACE)
        {
          newPlayerName.replace(cursorPos, 1, 1, ' ');
          cursorPos--;
          keyTreated = true;
        }
        if(scanCode == KEY_DEL)
        {
          newPlayerName.replace(cursorPos, 1, 1, ' ');
          keyTreated = true;
        }
        if(scanCode == KEY_HOME)
        {
          cursorPos = 0;
          keyTreated = true;
        }
        if(scanCode == KEY_END)
        {
          cursorPos = 15;
          keyTreated = true;
        }
        if(scanCode == KEY_LEFT)
        {
          cursorPos--;
          keyTreated = true;
        }
        if(scanCode == KEY_RIGHT)
        {
          cursorPos++;
          keyTreated = true;
        }
        
        if(!keyTreated)
        {
          if(c >= 32) // is a printable character?
          {
            newPlayerName.replace(cursorPos, 1, 1, c); // put character into string at cursor pos
            cursorPos++;
            keyTreated = true;
          }
        }
        
        // make sure cursorPos is within bounds
        if(cursorPos < 0)
          cursorPos = 0;
        if(cursorPos > 15)
          cursorPos = 15;
        
      }
      
      forceRedraw = true;
    }
    
    // redraw if necessary
    if(currentPlayerIt != previousPlayerIt || forceRedraw)
    {
      this->renderPlayerSelection((*currentPlayerIt)->GetName(), cursorPos, newPlayerName);
      forceRedraw = false;
    }
     
    previousPlayerIt = currentPlayerIt;  
    rest(10); // wait a bit, so that the CPU is not used up to 100%
  }

  // save new Scoreboard, if necessary
  if(madeAnyChanges)
  {
    this->saveScoreboard();
  }


  #undef UPDATE_KEYSTATES_IN_THIS_FUNC
}


void GameState::controlScoreboard()
{
  int firstIndex = 0; // to remember scroll position for scoreboard
  int previousIndex = -1; // to determine, when to redraw (-1 to redraw on first iteration of loop below)
  bool exitScoreboard = false;
  
  // load scoreboard
  if(!this->scores.Read("./players.tgs")) // tgs = tank game scores
    exitScoreboard = true; // do not execute loop below, if scores failed to read
  
  this->currentRanking = this->scores.GetRanking(); // sort scores and store ranking
  
  int numPlayers = this->currentRanking.size();
  if(!exitScoreboard)
  {
    if(numPlayers <= 0)
      exitScoreboard = true; // nothing to show, no players registered
  }
  
  if(exitScoreboard) 
  {
    // log and show an error message
    LOG(Logging::logError, "error reading expected Scoreboard file: \"players.tgs\"")
    this->renderErrorMessage("! - error reading expected Scoreboard file: \"players.tgs\" - !");
  }
  
  // keys to use in scoreboard menu
  KeyState keyEscape(KEY_ESC);
  KeyState keyDown(KEY_DOWN);
  KeyState keyUp(KEY_UP);
  KeyState keyPageUp(KEY_PGUP);
  KeyState keyPageDown(KEY_PGDN);
  KeyState keyPos1(KEY_HOME);
  KeyState keyEnd(KEY_END);
  
  #define UPDATE_KEYSTATES_IN_THIS_FUNC keyEscape.Update();keyDown.Update();keyUp.Update();keyPageUp.Update();keyPageDown.Update();keyPos1.Update();keyEnd.Update();
  
  while(!exitProgramme && !exitScoreboard)
  {
    KeyState::UpdateKeyboard(); // updates Allegro key states
  
    // gather input states
    UPDATE_KEYSTATES_IN_THIS_FUNC
    
    // evaluate input states and react to changes
    if(keyEscape.KeyUp())
      exitScoreboard = true;
  
    // for scrolling scores
    if(keyUp.KeyDown())
      firstIndex--;
    if(keyDown.KeyDown())
      firstIndex++;
    if(keyPageUp.KeyDown())
      firstIndex-=9;
    if(keyPageDown.KeyDown())
      firstIndex+=9;
    if(keyPos1.KeyDown())
      firstIndex=0;
    if(keyEnd.KeyDown())
      firstIndex = numPlayers-10;
    
    // normalize scroll position (wrap around)
    if(firstIndex < 0)
      firstIndex = (numPlayers + firstIndex)%numPlayers;
    else
      firstIndex = firstIndex % numPlayers;
    
    // redraw if necessary
    if(previousIndex != firstIndex)
    {
      this->renderScoreboard(firstIndex);
    }
     
    previousIndex = firstIndex;  
    rest(10); // wait a bit, so that the CPU is not used up to 100%
  }
  
  #undef UPDATE_KEYSTATES_IN_THIS_FUNC
}

void GameState::controlManual()
{
  // this->renderErrorMessage("! - this is not implemented yet (see 'readme.txt' for now) - !");
  
  bool exitManual = false;
  bool forceRedraw = true;
  
  // list for keeping manual lines in memory
  std::list<std::string> linesList;
  linesList.clear();
  
  // try to load readme.txt into a list of string
  FILE* readmeFile = NULL;
  readmeFile = fopen("./readme.txt", "r"); // open for reading
  if(readmeFile != NULL)
  {
    char line[255]; // line buffer
    memset((void*)&line[0], 0, sizeof(char)*255);
    
    while(!feof(readmeFile)) // while there are still lines to read
    {
      if(fgets(line, 250, readmeFile) != NULL)
      {
        // put the just read line into the list (but leave out newline characters)
        std::string nextLine;
        nextLine.assign(line);
        linesList.push_back(nextLine.substr(0, 1+nextLine.find_last_not_of("\n\r\f")));
      }
      else
        linesList.push_back(string(" ")); // empty line
    }
    fclose(readmeFile); // close readme file
    
    if(linesList.size() <= 0) // unknown error, no lines read
    {
      exitManual = true;
      LOG(Logging::logError, "error reading \"readme.txt\" (no lines?)!")
    }
  }
  else
  {
    exitManual = true;
    LOG(Logging::logError, "error reading \"readme.txt\"!")
  }
  
  // keys to use in manual
  KeyState keyEscape(KEY_ESC);
  KeyState keyDown(KEY_DOWN);
  KeyState keyUp(KEY_UP);
  KeyState keyPageUp(KEY_PGUP);
  KeyState keyPageDown(KEY_PGDN);
  KeyState keyPos1(KEY_HOME);
  KeyState keyEnd(KEY_END);
  
  #define UPDATE_KEYSTATES_IN_THIS_FUNC keyEscape.Update();keyDown.Update();keyUp.Update();keyPageUp.Update();keyPageDown.Update();keyPos1.Update();keyEnd.Update();
  
  std::list<std::string>::iterator currentIt = linesList.begin();
  std::list<std::string>::iterator previousIt = linesList.begin();
  
  int pageLines = 45;
  
  while(!exitProgramme && !exitManual)
  {
    KeyState::UpdateKeyboard(); // updates Allegro key states
  
    // gather input states
    UPDATE_KEYSTATES_IN_THIS_FUNC
   
     // evaluate input states and react to changes
    if(keyEscape.KeyUp())
      exitManual = true;
     
    // scroll line by line 
    if(keyDown.KeyPressed())
    {
      if(currentIt != linesList.end())
        currentIt++;
    }
    if(keyUp.KeyPressed())
    {
      if(currentIt != linesList.begin())
        currentIt--;
    }
    
    // scroll page by page
    if(keyPageDown.KeyDown())
    {
      int count = 0;
      while(currentIt != linesList.end() && count < pageLines)
      {
        currentIt++;
        count++;
      }
    }
    if(keyPageUp.KeyDown())
    {
      int count = 0;
      while(currentIt != linesList.begin() && count < pageLines)
      {
        currentIt--;
        count++;
      }
    }
    
    // scroll to start/end
    if(keyEnd.KeyDown())
    {
      currentIt = --(linesList.end());
    }
    if(keyPos1.KeyDown())
    {
      currentIt = linesList.begin();
    }
   
    if(currentIt == linesList.end()) // prevent scrolling too far
      currentIt--;
      
    // prevent scrolling too far into the void
    std::list<std::string>::iterator fLineIt = currentIt;
    int linesToEnd = 0;
    while(fLineIt != linesList.end())
    {
      linesToEnd++;
      fLineIt++;
    }
    // go back a few lines, if necessary
    if(linesToEnd < pageLines)
    {
      fLineIt = linesList.end();
      int count = 0;
      while(count < pageLines && fLineIt != linesList.begin())
      {
        fLineIt--;
        count++;
      }
      currentIt = fLineIt;
    }
   
    if(forceRedraw || currentIt != previousIt ) // need to render manual?
    {
      this->renderManual(linesList, currentIt);
      
      forceRedraw = false;
    }
   
    previousIt = currentIt; // remember previous scroll position 
   
    rest(10); // // wait a bit, so that the CPU is not used up to 100% 
  }
  
  linesList.clear();
  
  #undef UPDATE_KEYSTATES_IN_THIS_FUNC
}

bool GameState::initShotArray()
{
  // reserve memory for shots
  this->pShotArray = NULL;
  this->pShotArray = new (std::nothrow) Shot[this->maxShots];
  this->nextShotToReuse = 0;
  
  return this->pShotArray != NULL;
}

void GameState::freeShotArray()
{
  // release memory occupied by shots
  if(this->pShotArray != NULL)
  {
    delete [] (this->pShotArray);
  }
  this->pShotArray = NULL;
}

bool GameState::spawnShot(flPoint2D pos, float angle, float speed, int owner)
{
  if(this->pShotArray != NULL)
  {
    pShotArray[nextShotToReuse].Reset(pos, angle, speed, owner);
    this->playSound(sfx::shoot, pos.x);
    this->nextShotToReuse++;
    this->nextShotToReuse = this->nextShotToReuse % this->maxShots; // wrap around at end, and reuse first shot
    return true;
  }
  else
    return false;
}


bool GameState::initParticleArray()
{
  // reserve memory for particles
  this->pParticleArray = NULL;
  this->pParticleArray = new (std::nothrow) Particle[this->maxParticles];
  this->nextParticleToReuse = 0;
  
  return this->pParticleArray != NULL;
}

void GameState::freeParticleArray()
{
  // release memory occupied by particles
  if(this->pParticleArray != NULL)
  {
    delete [] (this->pParticleArray);
  }
  this->pParticleArray = NULL;
}

void GameState::spawnParticle(particleTypes::ParticleType id, ptrFlPoint2D startPos, float angle, float size, int ttl)
{
  if(this->pParticleArray != NULL)
  {
    // disallow certain particles to override other particles
    particleTypes::ParticleType typeToOverride = this->pParticleArray[nextParticleToReuse].GetId();
    bool dontOverride = false;
    dontOverride = (id == particleTypes::tankTrail || id == particleTypes::shotTrail) && ( 
                    (typeToOverride == particleTypes::explosion) || 
                    (typeToOverride == particleTypes::smoke) || 
                    (typeToOverride == particleTypes::fire)
                   ); // trails are less important than some other particles
    
    if(!dontOverride)
      this->pParticleArray[nextParticleToReuse].Reset(id, startPos, angle, size, ttl);
      
    this->nextParticleToReuse++;
    this->nextParticleToReuse = this->nextParticleToReuse % this->maxParticles; // wrap around at end, and reuse first particle
  }
}


// returns tileNumber, if a given position collides with any hittable tile
// or negative number if no collision is detected (-2 if the tile underneath is rubble)
// if adjustTileNumber is set to true, this also changes the tile that was hit, to
// increase its level of destruction
int GameState::positionCollidesWithTile(ptrFlPoint2D pPos, bool adjustTileNumber)
{
  if(pPos != NULL)
  {    
    // get coordinates as whole pixels
    int px = (int)pPos->x;
    int py = (int)pPos->y;
  
    if(px >= 0 && px <= SCREEN_W-1 && py >= 0 && py <= SCREEN_H-1) // is on screen?
    {
      // find map tile it is on
      int column = px / 32;
      int line = py / 32;
      
      // get and check tile
      arenaTile tileNumber = this->battleArena.GetTile(line, column);
      
      if(tileNumber >= rock0 && tileNumber <= indestructible) // if tile can be hit
      {
        // calculate position in the coordinates system of the map tile
        int pxRelativeToTile = px - column * 32;
        if(this->battleArena.IsFlipped(line, column))
          pxRelativeToTile = 31 - pxRelativeToTile;
        int pyRelativeToTile = py - line * 32;
        
        // check the pixel at that position in the tile and if it is set
        // to a non-transparent color, confirm the hit
        if(getpixel(this->pBitmap[tileToGfx[(int)tileNumber]],
           pxRelativeToTile, pyRelativeToTile) != 0)
        {
          if(adjustTileNumber) // fancy destroying it a bit?
          {
            if(tileNumber != indestructible && tileNumber != rock0)
              this->battleArena.SetTile(line, column, (arenaTile)(tileNumber-1)); // decrease tile number
          }
        
          if(tileNumber != rock0)
            return (int)tileNumber;
          else
            return -2; // so, the caller knows, the position is on rubble (rock0)
        }
        else
          return -1;
      }
      else
        return -1;
    }
    else
      return -1;
  }
  else
    return -1;
}

// returns true if a given position would collide with a rotated tank at another position
bool GameState::positionCollidesWithTank(ptrFlPoint2D pos, ptrFlPoint2D tankPos, float tAngle)
{
  // simple radius inclusion check first, if that already fails, nothing else need to be checked anymore
  flPoint2D vec = Cartesian::vector(pos, tankPos);
  float vecLen = Cartesian::vectorLength(&vec);
  
  if(vecLen <= 20.0f) // if point is within radius of a circle that fully includes the tank
  {
    // now check if the point translated into the tanks coordinate system is within
    // the tanks rectangle
    float vecAngle = Cartesian::vectorAngleCW(&vec);
    
    // translate into tanks orientation
    vecAngle -= tAngle;
    vec = Cartesian::vectorFromPolarCW(vecLen, vecAngle);
    
    // vec is now in coordinate space of tank, with tankPos being the center
    
    // perform simple rectangle inclusion check now (more precise than the bounding circle)
    if(vec.x <= -15.0f || vec.x >= +15.0f || vec.y <= -15.0f || vec.x >= +15.0f)
      return false;
    else
      return true;
  }
  else
    return false;
}

// ALL LOGIC UPDATES AND COLLISION DETECTION IS IN HERE
// PARAMETERS ARE:
/*
   tgGd, tank green gun direction (-1.0f, 0.0f or 1.0f, depending how the green player wants to rotate the gun)
   tgBd, tank green body direction (same as above but for green tank body)
   trGd and trBd, same as the two above but for red tank
   
   gwtf, green wants to fire / true if green would like to fire a shot
   gwte, green wants toggle engine
   
   rwtf, rwte, same as the two above but for red tank
   
   the parameters for rotation will be changed, if a tank hits an object
*/
void GameState::controlInGameObjects(float& tgGd, float& tgBd, float& trGd, float& trBd, bool gwtf, bool gwte, bool rwtf, bool rwte)
{
  bool greenIsAlive = !this->tankGreen.IsDestroyed();
  bool redIsAlive = !this->tankRed.IsDestroyed();

  // for variables, that only serve for checking, whether to spawn some tank track particles later
  float gtbabc = this->tankGreen.GetBodyAngle(); // green tank body angle before changes
  float rtbabc = this->tankGreen.GetBodyAngle(); // same for red tank
  flPoint2D gtpbc = *this->tankGreen.GetPosPtr(); // green tank pos before changes
  flPoint2D rtpbc = *this->tankRed.GetPosPtr(); // same for red tank

  bool greenTooHot = this->tankGreen.GetHeat() >= this->maxHeat * 0.75f;
  bool redTooHot = this->tankRed.GetHeat() >= this->maxHeat * 0.75f;

  // easy things first, rotation of guns is always allowed and does not need any collision checks
  if(greenIsAlive)
  {
    this->tankGreen.RotateGun(tgGd * this->gunRotationSpeed);
    if(this->tankGreen.UpdateReload(greenTooHot))
      this->playSound(sfx::c1ready, 90.0f);
    this->tankGreen.UpdateHeat(-1.0f * this->heatFalloff, this->maxHeat);
  }
  
  if(redIsAlive)
  {
    this->tankRed.RotateGun(trGd * this->gunRotationSpeed);
    if(this->tankRed.UpdateReload(redTooHot))
      this->playSound(sfx::c2ready, 550.0f);
    this->tankRed.UpdateHeat(-1.0f * this->heatFalloff, this->maxHeat);
  }
  
  // changing the engine direction is also always allowed
  if(gwte && greenIsAlive)
  {
    this->tankGreen.ToggleEngineStatus();
    this->playSound(sfx::leverclick, 36.0f);
  }
  if(rwte && redIsAlive)
  {
    this->tankRed.ToggleEngineStatus();
    this->playSound(sfx::leverclick, 604.0f);
  }
  
  // update engine sounds for green player (ugly hack)
  static float prevGreenSpeed = 0.0f;
  float greenSpeed = (float)fabs(this->tankGreen.GetSpeed());
  
  // select appropriate sound
  static sfx::sfxResources prevGreenSound = sfx::trackbaseGreen;
  sfx::sfxResources greenSound = sfx::trackbaseGreen;
  float greenSoundSpeed = greenSpeed / this->maxSpeed;
  float dmgLevelGreen = this->tankGreen.GetArmor() / this->maxArmor;
  if(dmgLevelGreen <= 0.7f)
  {
    greenSound = sfx::trackdmgMediumGreen;
    greenSoundSpeed = greenSoundSpeed * 1.5f;
  }
  if(dmgLevelGreen <= 0.3f)
  {
    greenSound = sfx::trackdmgHugeGreen;
    greenSoundSpeed = greenSoundSpeed * 2.5f;
  }
  
  if((greenSpeed == 0.0f && prevGreenSpeed == 0.0f)
     || prevGreenSound != greenSound)
  {
    // stop all green engine sounds
    this->stopSound(sfx::trackbaseGreen);
    this->stopSound(sfx::trackdmgMediumGreen);
    this->stopSound(sfx::trackdmgHugeGreen);
  }
  
  // initialize or adjust green engine sounds accordingly
  if((greenSpeed != 0.0f && prevGreenSpeed == 0.0f)
     || prevGreenSound != greenSound)
  {
    this->playSound(greenSound, this->tankGreen.GetPosPtr()->x,
                                         this->tankGreen.GetPosPtr()->y,
                                         greenSoundSpeed, 1);
  }
  else
  {
    this->adjustSound(greenSound, this->tankGreen.GetPosPtr()->x,
                                           this->tankGreen.GetPosPtr()->y,
                                           greenSoundSpeed, 1);
  }
  prevGreenSpeed = greenSpeed;
  prevGreenSound = greenSound;
  // end of engine sound update for green player
  
  
  // update engine sounds  for red player(ugly hack)
  static float prevRedSpeed = 0.0f;
  float redSpeed = (float)fabs(this->tankRed.GetSpeed());
  
  // select appropriate sound
  static sfx::sfxResources prevRedSound = sfx::trackbaseRed;
  sfx::sfxResources redSound = sfx::trackbaseRed;
  float redSoundSpeed = redSpeed / this->maxSpeed;
  float dmgLevelRed = this->tankRed.GetArmor() / this->maxArmor;
  if(dmgLevelRed <= 0.7f)
  {
    redSound = sfx::trackdmgMediumRed;
    redSoundSpeed = redSoundSpeed * 1.5f;
  }
  if(dmgLevelRed <= 0.3f)
  {
    redSound = sfx::trackdmgHugeRed;
    redSoundSpeed = redSoundSpeed * 2.5f;
  }
  
  if((redSpeed == 0.0f && prevRedSpeed == 0.0f)
     || prevRedSound != redSound)
  {
    // stop all red engine sounds
    this->stopSound(sfx::trackbaseRed);
    this->stopSound(sfx::trackdmgMediumRed);
    this->stopSound(sfx::trackdmgHugeRed);
  }
  
  // initialize or adjust red engine sounds accordingly
  if((redSpeed != 0.0f && prevRedSpeed == 0.0f)
     || prevRedSound != redSound)
  {
    this->playSound(redSound, this->tankRed.GetPosPtr()->x,
                                         this->tankRed.GetPosPtr()->y,
                                         redSoundSpeed, 1);
  }
  else
  {
    this->adjustSound(redSound, this->tankRed.GetPosPtr()->x,
                                           this->tankRed.GetPosPtr()->y,
                                           redSoundSpeed, 1);
  }
  prevRedSpeed = redSpeed;
  prevRedSound = redSound;
  // end of engine sound update for red player
  
  
  // update the particles, if there are any
  if(this->particlesAvailable)
  {
    int frame = 0;
    for(int i=0; i<this->maxParticles; i++)
    {
      frame = this->pParticleArray[i].UpdateAndGetAnimationFrame();
      if(this->pParticleArray[i].GetId() == particleTypes::explosion)
      {
        if(this->logicFramesLeft % (this->logicUpdatesPerSecond / 2) == 0 && frame != -1)
        {
          this->spawnParticle(particleTypes::smoke, this->pParticleArray[i].GetPosPtr(), 
                              0.0f, 0.15f, this->logicUpdatesPerSecond * 4);
        }
      }
    }
  }

  // move shots and perform shot to map and shot to tanks collision detections
  int owner = -1;
  for(int i=0; i<this->maxShots; i++)
  {
    owner = this->pShotArray[i].GetOwner();
    if(owner != -1) // if shot is active
    {
      // move the shot
      ptrFlPoint2D p = this->pShotArray[i].GetPosPtr();
      ptrFlPoint2D m = this->pShotArray[i].GetSpeedPtr();
      this->pShotArray[i].SetPos(Cartesian::vectorSum(p, m));
      
      p = this->pShotArray[i].GetPosPtr();
      
      // check if shot hit a tank
      if(owner == 0) // if shot was shot by green tank
      {
        // check if it hit the red tank
        if(this->positionCollidesWithTank(p, this->tankRed.GetPosPtr(), this->tankRed.GetBodyAngle()))
        {
          this->pShotArray[i].Deactivate(); // deactivate shot
          // damage and heat up red tank
          this->tankRed.TakeDamage(this->damagePerHit);
          this->tankRed.UpdateHeat(this->heatGainPerHit, this->maxHeat);
          
          // push red tank away a little
          flPoint2D vec = Cartesian::vector(p, this->tankRed.GetPosPtr());
          vec = Cartesian::unitVector(&vec);
          this->tankRed.GetPosPtr()->x += vec.x * 5.0f;
          this->tankRed.GetPosPtr()->y += vec.y * 5.0f;
          
          // spawn particles and explosion at last position
          this->spawnParticle(particleTypes::explosion, p, 0.0f, 1.0f, particleTypes::maxTLL);
          this->playSound(sfx::explosion, p->x);
          
          continue;
        }
      }
      if(owner == 1) // if shot was shot by red tank
      {
        // check if it hit the green tank
        if(this->positionCollidesWithTank(p, this->tankGreen.GetPosPtr(), this->tankGreen.GetBodyAngle()))
        {
          this->pShotArray[i].Deactivate(); // deactivate shot
          // damage and heat up green tank
          this->tankGreen.TakeDamage(this->damagePerHit);
          this->tankGreen.UpdateHeat(this->heatGainPerHit, this->maxHeat);
          
          // push green tank away a little
          flPoint2D vec = Cartesian::vector(p, this->tankGreen.GetPosPtr());
          vec = Cartesian::unitVector(&vec);
          this->tankGreen.GetPosPtr()->x += vec.x * 5.0f;
          this->tankGreen.GetPosPtr()->y += vec.y * 5.0f;
          
          // spawn particles and explosion at last position
          this->spawnParticle(particleTypes::explosion, p, 0.0f, 1.0f, particleTypes::maxTLL);
          this->playSound(sfx::explosion, p->x);
          
          continue;
        }
      }
      
      // check if shot hit anything on the map
      // check if it is out of bounds (with a little tolerance so that it may fly out of screen, before disappearing
      float borderTolerance = 20.f;
      if(p->x < -1.0f * borderTolerance || p->x > borderTolerance + (float)SCREEN_W || p->y < -1.0f * borderTolerance || p->y > borderTolerance + (float)SCREEN_H)
      {
        this->pShotArray[i].Deactivate(); // deactive shot if its outside
      }
      else // shot might have hit something on the map (only if it is within actual screen bounds though)
      {
        int collTile = this->positionCollidesWithTile(p, true); // perform hit detection and destruction
        if(collTile >= 0) // did hit something?
        {
          // deactivate shot 
          this->pShotArray[i].Deactivate();
          
          // spawn particles and explosion at last position
          this->spawnParticle(particleTypes::explosion, p, 0.0f, 1.0f, particleTypes::maxTLL);
          this->playSound(sfx::explosion, p->x);
          
          continue;
        }
      }
      
      // if shot is still active
      // spawn shotTrail particles every once in a while
      if(this->logicFramesLeft % (this->logicUpdatesPerSecond*3/30) == 0)
        this->spawnParticle(particleTypes::shotTrail, p, 0.0f, 0.0f, this->logicUpdatesPerSecond); 
    }
  }
  
  // perform rotation collision detection and rotate tanks, if possible
  
  // calculate the predicted four corners of green tank in screen coordinates
  // and for each one, check if the tank can go there
  bool canRotateGreen = true;
  flPoint2D tankGreenCorner[4]; // from center, the tanks corners
  float tgAngle = this->tankGreen.GetBodyAngle() + tgBd * this->bodyRotationSpeed;
  for(int i=0; i < 4; i++)
  {
    tankGreenCorner[i] = Cartesian::vectorFromPolarCW(18.0f, tgAngle + 45.0f + (float)i * 90.0f);
    tankGreenCorner[i] = Cartesian::vectorSum(this->tankGreen.GetPosPtr(), &tankGreenCorner[i]);
    // /*for DEBUG*/ putpixel(screen, (int)tankGreenCorner[i].x, (int)tankGreenCorner[i].y, this->color[gfx::black]);
    
    if(this->positionCollidesWithTile(&tankGreenCorner[i], false) >= 0 ||
       this->positionCollidesWithTank(&tankGreenCorner[i], this->tankRed.GetPosPtr(), this->tankRed.GetBodyAngle())) // disallow rotation
    {
      canRotateGreen = false;
      tgBd = 0.0f; // stop rotating (this is less irritating for player)
    }
  }
  
  // calculate the predicted four corner of the red tank in screen coordinates
  // and for each one, check if the tank can go there
  bool canRotateRed = true;
  flPoint2D tankRedCorner[4]; // from center, the tanks corners
  float trAngle = this->tankRed.GetBodyAngle() + trBd * this->bodyRotationSpeed;
  for(int i=0; i < 4; i++)
  {
    tankRedCorner[i] = Cartesian::vectorFromPolarCW(18.0f, trAngle + 45.0f + (float)i * 90.0f);
    tankRedCorner[i] = Cartesian::vectorSum(this->tankRed.GetPosPtr(), &tankRedCorner[i]);
    // /*for DEBUG*/ putpixel(screen, (int)tankRedCorner[i].x, (int)tankRedCorner[i].y, this->color[gfx::black]);
    
    if(this->positionCollidesWithTile(&tankRedCorner[i], false) >= 0 ||
       this->positionCollidesWithTank(&tankRedCorner[i], this->tankGreen.GetPosPtr(), this->tankGreen.GetBodyAngle())) // disallow rotation
    {
      canRotateRed = false;
      trBd = 0.0f; // stop rotating (this is less irritating for player)
    }
  }
    
  // now rotate the tanks if there predicted rotation was possible and not blocked by anything
  static int prevGreenRotateVoice = -1;
  if(greenIsAlive && canRotateGreen && tgBd != 0.0f)
  {
    this->tankGreen.RotateBody(tgBd * this->bodyRotationSpeed);
    
    // play sound on rotation
    if(prevGreenRotateVoice == -1)
      prevGreenRotateVoice = this->playSound(sfx::trackRotateGreen, this->tankGreen.GetPosPtr()->x,
                                             this->tankGreen.GetPosPtr()->y,
                                             1.0f, 1);
    else
      this->adjustVoice(prevGreenRotateVoice, this->tankGreen.GetPosPtr()->x,
                                              this->tankGreen.GetPosPtr()->y);
  }
  else
  {
    // stop rotation sound
    if(prevGreenRotateVoice != -1)
    {
      voice_stop(prevGreenRotateVoice);
      prevGreenRotateVoice = -1;
    }
  }
  
  
  static int prevRedRotateVoice = -1;
  if(redIsAlive && canRotateRed && trBd != 0.0f)
  {
    this->tankRed.RotateBody(trBd * this->bodyRotationSpeed);
    
    // play sound on rotation
    if(prevRedRotateVoice == -1)
      prevRedRotateVoice = this->playSound(sfx::trackRotateRed, this->tankRed.GetPosPtr()->x,
                                             this->tankRed.GetPosPtr()->y,
                                             1.0f, 1);
    else
      this->adjustVoice(prevRedRotateVoice, this->tankRed.GetPosPtr()->x,
                                              this->tankRed.GetPosPtr()->y);
  }
  else
  {
    // stop rotation sound
    if(prevRedRotateVoice != -1)
    {
      voice_stop(prevRedRotateVoice);
      prevRedRotateVoice = -1;
    }
  }

  // update tank speeds (and also adjust maxSpeed based on damage taken)
  this->tankGreen.UpdateSpeed(this->acceleration, this->maxSpeed * (this->tankGreen.GetArmor() / this->maxArmor));
  this->tankRed.UpdateSpeed(this->acceleration, this->maxSpeed * (this->tankRed.GetArmor() / this->maxArmor)); 

  // perform movement collision detection and move tanks, if possible
  // further predict corner positions of green tank
  bool canMoveGreen = true;
  float maxGreenSpeed = this->maxSpeed;
  ptrFlPoint2D pGreenMov = this->tankGreen.GetMovPtr();
  for(int i=0; i<4; i++)
  {
    tankGreenCorner[i] = Cartesian::vectorSum(&tankGreenCorner[i], pGreenMov);
    int collTile = this->positionCollidesWithTile(&tankGreenCorner[i], false);
    if(collTile >= 0)
    {
      canMoveGreen = false; 
      // push tank back a little
      flPoint2D vec = Cartesian::vector(this->tankGreen.GetPosPtr(), &tankGreenCorner[i]);
      vec = Cartesian::unitVector(&vec);
      this->tankGreen.GetPosPtr()->x -= vec.x / 2.0f;
      this->tankGreen.GetPosPtr()->y -= vec.y / 2.0f;
    }
    else if(collTile == -2) // on rubble?
      maxGreenSpeed = this->maxSpeedRubble;
  }
  
  // further predict corner positions of red tank
  bool canMoveRed = true;
  float maxRedSpeed = this->maxSpeed;
  ptrFlPoint2D pRedMov = this->tankRed.GetMovPtr();
  for(int i=0; i<4; i++)
  {
    tankRedCorner[i] = Cartesian::vectorSum(&tankRedCorner[i], pRedMov);
    int collTile = this->positionCollidesWithTile(&tankRedCorner[i], false);
    if(collTile >= 0)
    {
      canMoveRed = false;
      // push tank back a little
      flPoint2D vec = Cartesian::vector(this->tankRed.GetPosPtr(), &tankRedCorner[i]);
      vec = Cartesian::unitVector(&vec);
      this->tankRed.GetPosPtr()->x -= vec.x / 2.0f;
      this->tankRed.GetPosPtr()->y -= vec.y / 2.0f;
    }
    else if(collTile == -2) // on rubble?
      maxRedSpeed = this->maxSpeedRubble;
  }
  
  // now update tank speeds again, to respect surface speed limit (for rubble)
  this->tankGreen.UpdateSpeed(0.0f, maxGreenSpeed);
  this->tankRed.UpdateSpeed(0.0f, maxRedSpeed);
  
  // disallow moving outside of screen
  flPoint2D tgCenter = Cartesian::vectorSum(this->tankGreen.GetPosPtr(), this->tankGreen.GetMovPtr());
  if(tgCenter.x < 0.0f || tgCenter.x >= (float)SCREEN_W ||
     tgCenter.y < 0.0f || tgCenter.y >= (float)SCREEN_H)
    canMoveGreen = false;
  
  flPoint2D trCenter = Cartesian::vectorSum(this->tankRed.GetPosPtr(), this->tankRed.GetMovPtr());
  if(trCenter.x < 0.0f || trCenter.x >= (float)SCREEN_W ||
     trCenter.y < 0.0f || trCenter.y >= (float)SCREEN_H)
    canMoveRed = false;
  
  // push tanks away a little from each other if they collide with each other
  for(int i=0; i<4; i++)
  {
    if(this->positionCollidesWithTank(&tankGreenCorner[i], this->tankRed.GetPosPtr(), this->tankRed.GetBodyAngle()) ||
       this->positionCollidesWithTank(&tankRedCorner[i], this->tankGreen.GetPosPtr(), this->tankGreen.GetBodyAngle()))
    {
      flPoint2D vec = Cartesian::vector(&tgCenter, &trCenter);
      vec = Cartesian::unitVector(&vec);
      this->tankGreen.GetPosPtr()->x -= vec.x;
      this->tankGreen.GetPosPtr()->y -= vec.y;
      this->tankRed.GetPosPtr()->x += vec.x;
      this->tankRed.GetPosPtr()->y += vec.y;
      break;
    }
  }
  
  // now move the tanks
  if(greenIsAlive && canMoveGreen)
    this->tankGreen.UpdatePos();

  if(redIsAlive && canMoveRed)
    this->tankRed.UpdatePos();
    
  // spawn tank tracks at corners
  for(int i=0; i<4; i++)
  {
    if(this->logicFramesLeft % (i+4)*4 == 0)
    {
      if(gtbabc != this->tankGreen.GetBodyAngle() || 
         gtpbc.x != this->tankGreen.GetPosPtr()->x || 
         gtpbc.y != this->tankGreen.GetPosPtr()->y)
        this->spawnParticle(particleTypes::tankTrail, &tankGreenCorner[i], this->tankGreen.GetBodyAngle(), 1.0f, this->logicUpdatesPerSecond * 20);
      if(rtbabc != this->tankRed.GetBodyAngle() || 
         rtpbc.x != this->tankRed.GetPosPtr()->x || 
         rtpbc.y != this->tankRed.GetPosPtr()->y)
        this->spawnParticle(particleTypes::tankTrail, &tankRedCorner[i], this->tankRed.GetBodyAngle(), 1.0f, this->logicUpdatesPerSecond * 20);
    } 
  }
    
  // spawn smoke on tanks (the lower the armor, the higher the probability)
  if(rand()%85 >= (this->tankGreen.GetArmor() / this->maxArmor) * 100)
    this->spawnParticle(particleTypes::smoke, this->tankGreen.GetPosPtr(), 0.0f, 0.0f, this->logicUpdatesPerSecond*3);
  if(rand()%85 >= (this->tankRed.GetArmor() / this->maxArmor) * 100)
    this->spawnParticle(particleTypes::smoke, this->tankRed.GetPosPtr(), 0.0f, 0.0f, this->logicUpdatesPerSecond*3);
  
  // check if players want to fire and spawn shots accordingly
  if(gwtf && greenIsAlive) // green wants to fire?
  {
    if(this->tankGreen.IsReadyToFire())
    {
      // check heat and update heat
      if(!greenTooHot)
      {
        flPoint2D gunVector = Cartesian::vectorFromPolarCW(20.0f, this->tankGreen.GetGunAngle());
        flPoint2D spawnPos = Cartesian::vectorSum(this->tankGreen.GetPosPtr(),
                                                  &gunVector);
        
        this->spawnShot(spawnPos, this->tankGreen.GetGunAngle(), this->shotSpeed, 0);
        
        // spawn muzzle particle and some smoke
        this->spawnParticle(particleTypes::muzzle, &spawnPos, this->tankGreen.GetGunAngle(), 1.5f, this->logicUpdatesPerSecond / 3);
        for(int j=0; j<4; j++)
        { 
          spawnPos.x += (rand()%3);
          spawnPos.y += (rand()%3);
          this->spawnParticle(particleTypes::smoke, &spawnPos, 0.0f, 1.0f - 0.25f*j, this->logicUpdatesPerSecond * (j+1)*2);
        }
        
        this->tankGreen.SetReloading(this->reloadDelay);
        this->tankGreen.UpdateHeat(this->heatGainPerShot, this->maxHeat);
      }
    }
  }
  if(greenTooHot && this->tankGreen.IsReadyToFire())
    this->tankGreen.SetReloading(1); // so that while heat is too high, tank can't fire
  
  if(rwtf && redIsAlive) // red wants to fire?
  {
    if(this->tankRed.IsReadyToFire())
    {
      if(!redTooHot)
      {
        flPoint2D gunVector = Cartesian::vectorFromPolarCW(20.0f, this->tankRed.GetGunAngle());
        flPoint2D spawnPos = Cartesian::vectorSum(this->tankRed.GetPosPtr(),
                                                  &gunVector);
        this->spawnShot(spawnPos, this->tankRed.GetGunAngle(), this->shotSpeed, 1);
        
        // spawn muzzle particle and some smoke
        this->spawnParticle(particleTypes::muzzle, &spawnPos, this->tankRed.GetGunAngle(), 1.5f, this->logicUpdatesPerSecond / 3);
        for(int j=0; j<4; j++)
        { 
          spawnPos.x += (rand()%3);
          spawnPos.y += (rand()%3);
          this->spawnParticle(particleTypes::smoke, &spawnPos, 0.0f, 1.0f - 0.25f*j, this->logicUpdatesPerSecond * (j+1)*2);
        }
        
        this->tankRed.SetReloading(this->reloadDelay);
        this->tankRed.UpdateHeat(this->heatGainPerShot, this->maxHeat);
      }
    }
  }
  if(redTooHot && this->tankRed.IsReadyToFire())
    this->tankRed.SetReloading(1); // so that while heat is too high, tank can't fire

  
  // make sure a tank can't be pushed off the map
  if(this->tankGreen.GetPosPtr()->x < 0.0f)
    this->tankGreen.GetPosPtr()->x = 1.0f;
  if(this->tankGreen.GetPosPtr()->x >= (float)SCREEN_W)
    this->tankGreen.GetPosPtr()->x = (float)SCREEN_W - 1.0f;
  if(this->tankGreen.GetPosPtr()->y < 0.0f)
    this->tankGreen.GetPosPtr()->y = 1.0f;
  if(this->tankGreen.GetPosPtr()->y >= (float)SCREEN_H)
    this->tankGreen.GetPosPtr()->y = (float)SCREEN_H - 1.0f;
    
  if(this->tankRed.GetPosPtr()->x < 0.0f)
    this->tankRed.GetPosPtr()->x = 1.0f;
  if(this->tankRed.GetPosPtr()->x >= (float)SCREEN_W)
    this->tankRed.GetPosPtr()->x = (float)SCREEN_W - 1.0f;
  if(this->tankRed.GetPosPtr()->y < 0.0f)
    this->tankRed.GetPosPtr()->y = 1.0f;
  if(this->tankRed.GetPosPtr()->y >= (float)SCREEN_H)
    this->tankRed.GetPosPtr()->y = (float)SCREEN_H - 1.0f; 
}

// <non_member_function>  // for game timing
volatile int gameTicks;
void tickTimerHandler() // this is called "logicUpdatesPerSecond" times per second from a separate thread
{
  gameTicks++;
}
END_OF_FUNCTION(tickTimerHandler) // Allegro macro to make timer magic work
// </non_member_function>


void GameState::controlInGameAction()
{
  // initialize match variables
  this->logicFramesLeft = logicFramesPerMatch;
  gameTicks = 0;
  
  bool cancelMatch = false;  // true, if escape is pressed in game
  bool matchEndedRegularly = false; // true, if time ran out or if one of the players has won
  bool interruptHandlerInstalled = false;
  
  // flags to send to rendering method               
  bool timeOut = false;
  int winner = -1; // -1 draw game, 0 player one, 1 player two
  
  int endOfMatchDelay = this->logicUpdatesPerSecond * 10; // to wait a bit after match over, before returning to main menu

  // validate map parameters (make sure tanks have start positions)
  if( battleArena.GetXline() == -1 || battleArena.GetXcolumn() == -1 ||
      battleArena.GetYline() == -1 || battleArena.GetYcolumn() == -1 )
  {
    LOG(Logging::logError, "the map files\"" + arenaFileName[currentMap] + "\" is missing at least one tank start position!")
    this->renderErrorMessage("The selected battle arena is missing start position(s)!");
    cancelMatch = true;
  }
  
  // initialize shot memory
  if(!this->initShotArray())
  {
    LOG(Logging::logError, "could not start match, not enough memory for shots.")
    this->renderErrorMessage("! - Error allocating memory for shots. Sorry. - !");
    cancelMatch = true;
  }
  
  // initialize non critical particle memory
  this->particlesAvailable = this->initParticleArray();
  if(!particlesAvailable) // no memory for eye-candy? :'(
  {
    // log an error, but don't quit, as the particles are not critical to the game logic
    LOG(Logging::logError, "not enough memory for particles, try reducing maxParticles in 'constants.cfg'")
  }
  
  if(!cancelMatch) // install game timer handler
  {
    LOCK_VARIABLE(gameTicks); // magic Allegro macro for timer handler
    LOCK_FUNCTION(tickTimerHandler); // another magic Allegro macro for timer handler
    
    // let Allegro call the tickTimerHandler, "logicUpdatesPerSecond" per second
    if( install_int_ex(tickTimerHandler, BPS_TO_TIMER(this->logicUpdatesPerSecond)) == 0)
    {
      interruptHandlerInstalled = true;
    }
    else
    {
      interruptHandlerInstalled = false;
      LOG(Logging::logError, "can't start match, interrupt handler failed.")
      cancelMatch = true;
    }
  }
  
  // Keys to use in main game loop
  KeyState keyEscape(KEY_ESC); // for cancel match control
  
  // for green tank controls
  KeyState keyTankGreenGunLeft(KEY_Q);
  KeyState keyTankGreenGunRight(KEY_W);
  KeyState keyTankGreenBodyLeft(KEY_A);
  KeyState keyTankGreenBodyRight(KEY_S);
  KeyState keyTankGreenFire(KEY_E);
  KeyState keyTankGreenToggleEngine(KEY_D);
  
  // for red tank controls
  KeyState keyTankRedGunLeft(KEY_7_PAD);
  KeyState keyTankRedGunRight(KEY_8_PAD);
  KeyState keyTankRedBodyLeft(KEY_4_PAD);
  KeyState keyTankRedBodyRight(KEY_5_PAD);
  KeyState keyTankRedFire(KEY_9_PAD);
  KeyState keyTankRedToggleEngine(KEY_6_PAD);
  
  // for alternative red tank controls (on keyboard without the number pad)
  KeyState keyTankRedGunLeftB(KEY_U);
  KeyState keyTankRedGunRightB(KEY_I);
  KeyState keyTankRedBodyLeftB(KEY_J);
  KeyState keyTankRedBodyRightB(KEY_K);
  KeyState keyTankRedFireB(KEY_O);
  KeyState keyTankRedToggleEngineB(KEY_L);
  
  
  #define UPDATE_KEYSTATES_IN_THIS_FUNC keyEscape.Update();\
                                        keyTankGreenGunLeft.Update();\
                                        keyTankGreenGunRight.Update();\
                                        keyTankGreenBodyLeft.Update();\
                                        keyTankGreenBodyRight.Update();\
                                        keyTankGreenFire.Update();\
                                        keyTankGreenToggleEngine.Update();\
                                        keyTankRedGunLeft.Update();\
                                        keyTankRedGunRight.Update();\
                                        keyTankRedBodyLeft.Update();\
                                        keyTankRedBodyRight.Update();\
                                        keyTankRedFire.Update();\
                                        keyTankRedToggleEngine.Update();\
                                        keyTankRedGunLeftB.Update();\
                                        keyTankRedGunRightB.Update();\
                                        keyTankRedBodyLeftB.Update();\
                                        keyTankRedBodyRightB.Update();\
                                        keyTankRedFireB.Update();\
                                        keyTankRedToggleEngineB.Update();\
             
  // for controlling rotation behaviour on keypresses
  // (allows not having to keep keys pressed, hitting a key once starts rotation,
  //  hitting it again, stops rotation)
  float tgGd = 0.0f; // tank green gun direction (-1.0 rotating left, 0.0 stopped, +1.0 rotating right
  float tgBd = 0.0f; // same as above for body of green tank
  float trGd = 0.0f; // gun direction for red tank
  float trBd = 0.0f; // body direction for red tank
  
  // for controlling the tanks behaviour in the method that controls all game object updates
  bool greenWantsToFire = false;
  bool greenWantsToToggleEngine = false;
  bool redWantsToFire = false;
  bool redWantsToToggleEngine = false;
  
                                          
  while(!cancelMatch && !exitProgramme && endOfMatchDelay > 0)
  {
    bool redraw = false;
    
    while(gameTicks > 0) // since gameTicks is increased "logicUpdatesPerSecond" times per second elsewhere, this ensures that before each redrawn frame, these updates are made correctly
    {
      // update control states
      KeyState::UpdateKeyboard(); // update Allegro key states
      
      // gather input states
      UPDATE_KEYSTATES_IN_THIS_FUNC
      
      // evalute input
      if(keyEscape.KeyUp())
        cancelMatch = true;
      
      if(!matchEndedRegularly) // allow input only during actual match time
      {
        // check if Player One wants to change anything about his/her tank  
          if(keyTankGreenGunLeft.KeyDown()) // start/stop rotating green gun left ?
            tgGd = (tgGd < 0.0f) ? 0.0f : -1.0f;
          if(keyTankGreenGunRight.KeyDown()) // start/stop rotating green gun right ?
            tgGd = (tgGd > 0.0f) ? 0.0f : +1.0f;
          if(keyTankGreenBodyLeft.KeyDown()) // start/stop rotating green body left ?
            tgBd = (tgBd < 0.0f) ? 0.0f : -1.0f;
          if(keyTankGreenBodyRight.KeyDown()) // start/stop rotating green body right ?
            tgBd = (tgBd > 0.0f) ? 0.0f : +1.0f;
          greenWantsToFire = keyTankGreenFire.KeyPressed();
          greenWantsToToggleEngine = keyTankGreenToggleEngine.KeyDown();
        
        // check if Player Two wants to change anything about his/her tank
          if(keyTankRedGunLeft.KeyDown() || keyTankRedGunLeftB.KeyDown()) // start/stop rotating red gun left ?
            trGd = (trGd < 0.0f) ? 0.0f : -1.0f;
          if(keyTankRedGunRight.KeyDown() || keyTankRedGunRightB.KeyDown()) // start/stop rotating red gun right ?
            trGd = (trGd > 0.0f) ? 0.0f : +1.0f;
          if(keyTankRedBodyLeft.KeyDown() || keyTankRedBodyLeftB.KeyDown()) // start/stop rotating red body left ?
            trBd = (trBd < 0.0f) ? 0.0f : -1.0f;
          if(keyTankRedBodyRight.KeyDown() || keyTankRedBodyRightB.KeyDown()) // start/stop rotating red body right ?
            trBd = (trBd > 0.0f) ? 0.0f : +1.0f;
          redWantsToFire = keyTankRedFire.KeyPressed() || keyTankRedFireB.KeyPressed();
          redWantsToToggleEngine = keyTankRedToggleEngine.KeyDown() || keyTankRedToggleEngineB.KeyDown();
        
        // TODO: _ADD_AI_ (if I ever get to adding AI, insert it here, to let the AI decide for one of the tanks)
      }
      
      // update game objects and do collision detection
      this->controlInGameObjects(tgGd, tgBd, trGd, trBd, 
                                 greenWantsToFire, greenWantsToToggleEngine,
                                 redWantsToFire, redWantsToToggleEngine);
    
      // check match ending/winning conditions
      if(this->logicFramesLeft == 0) // match time over?
      {
        matchEndedRegularly = true;
        timeOut = true;
        
        // check who won the match
        if(this->tankGreen.GetArmor() > this->tankRed.GetArmor())
          winner = 0; // green wins
        else
          winner = 1; // red wins..
          
        // ..unless both have equal amounts of armor left..
        if(this->tankGreen.GetArmor() == this->tankRed.GetArmor())
          winner = -1; // ..so nobody wins.
      }
      
      // check if either of the tanks is destroyed while the match hasn't ended
      if(this->tankGreen.GetArmor() <= 0.0f ||
         this->tankRed.GetArmor() <= 0.0f)
      {
        matchEndedRegularly = true;
        
        if(!timeOut) 
        {
          // while there is still time left, a draw is still possible, as there might
          // still be shots flying around that might kill of the other tank as well
          // so keep checking who won the match in this case
          
          if(this->tankGreen.GetArmor() > this->tankRed.GetArmor())
            winner = 0; // green wins
          else
            winner = 1; // red wins..
            
          // ..unless both have equal amounts of armor left..
          if(this->tankGreen.GetArmor() == this->tankRed.GetArmor())
            winner = -1; // ..so nobody wins.
        }
      }
    
      gameTicks--;
      this->logicFramesLeft--;
      
      if(matchEndedRegularly)
      {
        endOfMatchDelay--;
      }
      if(cancelMatch)
        break;
        
      redraw = true;
    }
  
    rest(0); // yield to play friendly with other processes
  
    // redraw ingame action..
    if(redraw)
    {
      this->renderInGameAction(matchEndedRegularly, timeOut, winner);
      redraw = false;
    }
  }
  
  // stop all sounds
  for(int i=0; i<sfx::TOTALNUMBEROFWAVSEXPECTED; i++)
    this->stopSound((sfx::sfxResources)i);
  
  // remove timer handler, if necessary
  if(interruptHandlerInstalled)
    remove_int(tickTimerHandler);
  
  if(matchEndedRegularly)
  {
    // get player pointers in scoreboard
    ptrPlayer pOne = this->scores.GetPtrPlayer(this->playerOneName);
    ptrPlayer pTwo = this->scores.GetPtrPlayer(this->playerTwoName);
    
    // evalute variables and see who won and updates scores
    if(winner == -1)
    {
      if(pOne != NULL)
        pOne->IncreaseGamesPlayed();
      if(pTwo != NULL)
        pTwo->IncreaseGamesPlayed();
    }
    if(winner == 0)
    {
      if(pOne != NULL)
        pOne->IncreaseWin(this->tankGreen.GetArmor() == this->maxArmor);
      if(pTwo != NULL)
        pTwo->IncreaseGamesPlayed();
    }
    if(winner == 1)
    {
      if(pOne != NULL)
        pOne->IncreaseGamesPlayed();
      if(pTwo != NULL)
        pTwo->IncreaseWin(this->tankRed.GetArmor() == this->maxArmor);
    }
    
    // saves scores
    this->saveScoreboard();
  }
  
  if(!exitProgramme)
  {
    // reload map, to reset map state
    this->selectMap(0);
  }
  
  // release memory for shots
  this->freeShotArray();
  
  // release memory for particles
  this->freeParticleArray();
  
  #undef UPDATE_KEYSTATES_IN_THIS_FUNC
}


void inline GameState::backbufferToScreen()
{
  blit(this->backbuffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
}

void GameState::renderErrorMessage(std::string message)
{
  int h = 30; // height of message box
  int bH = 5; // height of border for message box
  
  // render error box
  solid_mode();
  rectfill(this->backbuffer, 0, SCREEN_H / 2 - h / 2, SCREEN_W, SCREEN_H / 2 + h / 2, this->color[gfx::black]); // box
  rectfill(this->backbuffer, 0, SCREEN_H / 2 - h / 2, SCREEN_W, SCREEN_H / 2 - h / 2 + bH, this->color[gfx::white]); // upper border
  rectfill(this->backbuffer, 0, SCREEN_H / 2 + h / 2 - bH, SCREEN_W, SCREEN_H / 2 + h / 2, this->color[gfx::white]); // lower border

  // render text
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - 4, this->color[gfx::white], -1,
   (char*)message.c_str());  
  
  // blit message box to frontbuffer
  blit(this->backbuffer, screen, 0, SCREEN_H / 2 - h / 2, 0, SCREEN_H / 2 - h / 2, SCREEN_W, h+1);
  
  // wait a second
  rest(1000);
}

void GameState::renderMenuBox(int cx, int cy, int hW, int hH, int borderColor, int bgColor)
{
  // render background
  drawing_mode(DRAW_MODE_MASKED_PATTERN, this->pBitmap[gfx::PATTERN], 0,0);
  rectfill(this->backbuffer, cx - hW, cy - hH, cx + hW, cy + hH, bgColor);
  
  // render border
  solid_mode();
  rect(this->backbuffer, cx - hW, cy - hH, cx + hW, cy + hH, borderColor);
}

void GameState::renderHint(std::string hintA, std::string hintB)
{
  // render containing box
  this->renderMenuBox(SCREEN_W / 2, SCREEN_H - 28, (SCREEN_W -40) / 2, 27, this->color[gfx::white] , this->color[gfx::gray1]); 
  
  // render tooltip text
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W/2, SCREEN_H - 50, this->color[gfx::yellow], -1, 
    (char*)hintA.c_str());
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W/2, SCREEN_H - 40, this->color[gfx::yellow], -1, 
    (char*)hintB.c_str());
  
  // render copyright note
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W/2, SCREEN_H - 10, this->color[gfx::yellow], -1, 
    "--- TankGame v1.0e (C)2009-2010 by Dennis Busch, http://www.dennisbusch.de ---");
}

void GameState::renderMainMenu(std::string items[], int numItems, int selectedItem)
{
  clear_to_color(this->backbuffer, this->color[gfx::backgroundcolor]);
  
  // render the currently loaded battle arena in the background
  this->renderCurrentMap();
  
  // render status display (without match time display)
  this->renderStatusDisplay(false);
  
  // render tanks
  this->renderTanks(this->tankGreen.GetPosPtr(), this->tankRed.GetPosPtr());

  // render the menu area
  this->renderMenuBox(SCREEN_W / 2, SCREEN_H / 2, 80, 40, this->color[gfx::white], this->color[gfx::gray1]);
   
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W/2, SCREEN_H/2 - 38, this->color[gfx::white], -1, "--- TankGame ---");
   
  // render the menu items
  for(int i=0; i<numItems; i++)
  {
    // determine color (so that selected item is highlighted)
    int color = (i==selectedItem) ? this->color[gfx::yellow] : this->color[gfx::black];
  
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W/2, (SCREEN_H/2) - (10*numItems/2) + i*10 + 9, color, -1, items[i].c_str());
  }
 
  // render navigation help text
  this->renderHint("(use up and down cursor keys to navigate menu and enter key to select highlighted entry)",
                   "(use left and right cursor keys to change battle arena)");
    
  // blit everything to the frontbuffer (the screen)
  this->backbufferToScreen();
}


void GameState::renderPlayerSelection(std::string highlightedPlayerName,int cursorPos, std::string newPlayerName)
{
  clear_to_color(this->backbuffer, this->color[gfx::backgroundcolor]);
  
  // render the currently loaded battle arena in the background
  this->renderCurrentMap();
  
  // render status display (without match time display)
  this->renderStatusDisplay(false);
  
  // render tanks
  this->renderTanks(this->tankGreen.GetPosPtr(), this->tankRed.GetPosPtr());
  
  // render player names area and heading line
  int hH = 70;
  this->renderMenuBox(SCREEN_W/2, SCREEN_H/2, 160, hH, this->color[gfx::white], this->color[gfx::gray1]);
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 4, this->color[gfx::yellow], -1,
    "--- CHOOSE PLAYERS ---");
  
  if(cursorPos != -1) // currently entering a new player name?
  {
    int wH = text_length(font, newPlayerName.c_str()) / 2;
    int offSetX = SCREEN_W / 2 - wH;
    textout_ex(this->backbuffer, font, "Name:", offSetX - text_length(font, "Name:"), SCREEN_H / 2 - hH + 24, this->color[gfx::black], -1);
    for(int i=0; i<16; i++) // render current name and cursor
    {
      int bgColor = (i==cursorPos) ? this->color[gfx::white] : -1;
      textprintf_ex(this->backbuffer, font, offSetX, SCREEN_H / 2 - hH + 24, this->color[gfx::black], bgColor, "%c", newPlayerName[i]);
      offSetX+=8;
    }
  }
  else
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 24, this->color[gfx::black], -1,
      "- register new player -");
  
  
  // render the player names (in lexicographic sorting) and highlight appropriately
  
  // find first item to display (by going back from current item)
  std::list<ptrPlayer>::iterator findIt = this->currentRanking.begin();
  while((*findIt)->GetName() != highlightedPlayerName)
  {
    findIt++;
  }
  // findIt is now on highlighted player, now go back, a maximum of 9 times
  int count = 0;
  while(count < 9 && findIt != this->currentRanking.begin())
  {
    findIt--;
    count++;
  }
  // findIt is now on the first item to display
  
  // display player names now
  int yOffset = 0;
  count = 0;
  while(count < 10 && findIt != this->currentRanking.end())
  {
    int bgColor = -1;
    if((*findIt)->GetName() == this->playerOneName)
      bgColor = this->color[gfx::green];
    if((*findIt)->GetName() == this->playerTwoName)
      bgColor = this->color[gfx::red];
    if((*findIt)->GetName() == highlightedPlayerName && cursorPos == -1)
      bgColor = this->color[gfx::white];
  
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 34 + yOffset, this->color[gfx::black], bgColor,
      (*findIt)->GetName().c_str());
    
    findIt++;
    yOffset+=10;
    count++;
  }
    
  // render navigation help text
  if(cursorPos != -1)
    this->renderHint("(enter new player name(max 16 chars) and confirm with enter)",
                     "(press escape or cursor up/down to cancel entry)");
  else
    this->renderHint("(use up/down cursor keys to navigate through players, escape to go back, del to remove player)",
                     "(use left/right cursor keys to assign highlighted player to green/red tank)");
    
  // blit everything to the frontbuffer (the screen)
  this->backbufferToScreen();  
}


void GameState::renderScoreboard(int firstIndex)
{
  clear_to_color(this->backbuffer, this->color[gfx::backgroundcolor]);
  
  // render the currently loaded battle arena in the background
  this->renderCurrentMap();
  
  // render status display without match time
  this->renderStatusDisplay(false);
  
  // render tanks
  this->renderTanks(this->tankGreen.GetPosPtr(), this->tankRed.GetPosPtr());
  
  // render scoreboard area and heading line
  int hW = 320; // half the width of the scoreboard area
  int hH = 70; // half the height of the scoreboard area
  this->renderMenuBox(SCREEN_W / 2, SCREEN_H / 2, hW, hH, this->color[gfx::white], this->color[gfx::gray1]);
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 4, this->color[gfx::yellow], -1,
    "--- SCORES ---");
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 24, this->color[gfx::yellow], -1,
    "Rank     Name              Games-Won      Flawless-Victories    Games-Played");
  // 1234567891234567890123456781234567891234561234567890123456781234123456789012
  //     9           18            9       6          18          4        12 
  
  // render scoreboard items
  std::list<ptrPlayer>::iterator rankIt = this->currentRanking.begin();
  // determine first scoreboard item to draw
  for(int i=0; i<firstIndex; i++)
  {
    rankIt++;
    if(rankIt == this->currentRanking.end()) // hit unexpected end of items?
      break;
  }
  
  // now draw up to 10 scoreboard items, by going through the ranking list
  if(rankIt != this->currentRanking.end())
  {
    int i = 0;
    int yOffset = 0;
    while(i < 10 && rankIt != this->currentRanking.end())
    {
      int position = (firstIndex + i) + 1; // ranking in list
      textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 34 + yOffset, this->color[gfx::white], -1,
        "%4i%c     %-18s%-9i      %-18i    %-12i", position, '.',
                                              (*rankIt)->GetName().c_str(),
                                              (*rankIt)->GetGamesWon(),
                                              (*rankIt)->GetGamesWonFlawless(),
                                              (*rankIt)->GetGamesPlayed());
      rankIt++;
      i++;
      yOffset+=10;
    }
  }
  
  // render navigation help text
  this->renderHint("(use up and down cursor keys and page up/page down to scroll through positions)",
                   "(use escape key to go back to main menu)");
                   
  // blit everything to the frontbuffer (the screen)
  this->backbufferToScreen();
}

void GameState::renderManual(std::list<std::string>& lineList, std::list<std::string>::iterator topLine)
{
  clear_to_color(this->backbuffer, this->color[gfx::backgroundcolor]);
   
  // render the currently loaded battle arena in the background
  this->renderCurrentMap();
  
  // render status display without match time
  this->renderStatusDisplay(false);
  
  // render tanks
  this->renderTanks(this->tankGreen.GetPosPtr(), this->tankRed.GetPosPtr());
  
  // render manual area and heading line
  int hW = 330; // half the width of the manual area
  int hH = 240; // half the height of the manual area
  this->renderMenuBox(SCREEN_W/2, SCREEN_H/2, hW, hH, this->color[gfx::white], this->color[gfx::gray1]);
  textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, SCREEN_H / 2 - hH + 4, this->color[gfx::yellow], -1,
    "--- TANKGAME MANUAL ---");
  
  // render the manual lines
  int pageLines = 45;
  // go back a maximum of pageLines lines back from current line (if it's the last one)
  std::list<std::string>::iterator fLineIt = topLine;
  
  // fLineIt is now on first line to render
  
  // render up to as many lines that are still following the first line
  int yOffset = 0;
  for(int i=0; i<pageLines; i++)
  {
    textprintf_ex(this->backbuffer, font, SCREEN_W / 2 - hW + 5, SCREEN_H / 2 - hH + 24 + yOffset, this->color[gfx::white], -1,
      (*fLineIt).c_str());
      
    yOffset += 10;
    fLineIt++;  
      
    if(fLineIt == lineList.end())
      break;
  }
  
  // render navigation help text
  this->renderHint("(use up/down cursor keys and page up/page down and home/end to scroll the text)",
                   "(use escape key to go back to main menu)");
    
  // blit everything to the frontbuffer (the screen)
  this->backbufferToScreen();
}

void GameState::renderCurrentMap()
{
  // draw all graphic tiles on backbuffer
  int destX = 0;
  int destY = 0;
  int bitmapIndex = 0;
  for(int line=0; line < 19; line++) // for each line of tiles
  {
    destX = 0;
    for(int column=0; column < 25; column++) // for each tile in the line
    {
      // look up graphic resource for that tile in constant tileToGfx array
      bitmapIndex = tileToGfx[(int)this->battleArena.GetTile(line, column)];
      if(bitmapIndex >= 0) // if there is a graphic resource attached to that tile
      {
        BITMAP* pTileGfx = this->pBitmap[bitmapIndex]; // get pointer to that graphic
        
        // blit it to the backbuffer, at destX, destY
        if(is_memory_bitmap(pTileGfx)) // according to Allegro docs, draw_sprite_v_flip can only be used with memory bitmaps
        {
          if(this->battleArena.IsFlipped(line, column)) // flip?
            draw_sprite_h_flip(backbuffer, pTileGfx, destX, destY);
          else // don't flip
            draw_sprite(backbuffer, pTileGfx, destX, destY);
        }
        else // ignore the flipping, as its not safe to call
          masked_blit(pTileGfx, this->backbuffer, 0, 0, destX, destY, pTileGfx->w, pTileGfx->h);
      }
      destX += 32; // this should be changed, if the tile size ever changes
    }
    destY += 32; // this should be changed, if the tile size ever changes
  }
}


void GameState::renderTanks(ptrFlPoint2D pGreenTankPos, ptrFlPoint2D pRedTankPos)
{
  // convert angles to 0.0 to 256.0(full circle) format (needed for pivot_sprite)
  float radAngleTankGreen = MConst::fromDegTo256 * this->tankGreen.GetBodyAngle();
  float radAngleTankGreenGun = MConst::fromDegTo256 * this->tankGreen.GetGunAngle();
  float radAngleTankRed = MConst::fromDegTo256 * this->tankRed.GetBodyAngle();
  float radAngleTankRedGun = MConst::fromDegTo256 * this->tankRed.GetGunAngle();
 
  // render green tank
  pivot_sprite(this->backbuffer, this->pBitmap[gfx::GTANKB], 
               (int)pGreenTankPos->x, (int)pGreenTankPos->y,
               15, 15, ftofix(radAngleTankGreen)); // rotated body
  pivot_sprite(this->backbuffer, this->pBitmap[gfx::GTANKG],
               (int)pGreenTankPos->x, (int)pGreenTankPos->y,
               6, 4, ftofix(radAngleTankGreenGun)); // rotated gun
               
  // render red tank
  pivot_sprite(this->backbuffer, this->pBitmap[gfx::RTANKB], 
               (int)pRedTankPos->x, (int)pRedTankPos->y,
               15, 15, ftofix(radAngleTankRed)); // rotated body
  pivot_sprite(this->backbuffer, this->pBitmap[gfx::RTANKG],
               (int)pRedTankPos->x, (int)pRedTankPos->y,
               6, 4, ftofix(radAngleTankRedGun)); // rotated gun
}

void GameState::renderStatusDisplay(bool displayTimer)
{
  // render status display for player one
  draw_sprite(this->backbuffer, this->pBitmap[gfx::STATUS], 0, 0);
  
    // render player name
    textprintf_centre_ex(this->backbuffer, font, 76, 9, this->color[gfx::white], -1,
      (char*)this->playerOneName.c_str());
    
    // render left heatbar
      // create a sub-bitmap, since I don't want to draw the whole bar
      BITMAP* subHeat = NULL;
      int sy = (int)this->tankGreen.GetHeat();
      float height =  (float)this->pBitmap[gfx::HEATBAR]->h;
      // calculate start y of sub-bitmap
      sy = (int)(height - ( ((float)sy/this->maxHeat) * height ));
      // calculate height of sub-bitmap
      int subH = ((int)height - sy);
      if(subH > 0) // don't do anything if the height of the subbitmap is <= 0
      {
        subHeat = create_sub_bitmap(this->pBitmap[gfx::HEATBAR], 0, sy, this->pBitmap[gfx::HEATBAR]->w, subH);
        if(subHeat !=NULL)
        {
          // draw it at calculated position
          int dy = 35 + sy;
          draw_sprite(this->backbuffer, subHeat, 72, dy);
          
          // remove sub-bitmap
          destroy_bitmap(subHeat);
          subHeat = NULL;
        }
      }
    
    // render left armorbar
      // create a sub-bitmap, since I don't want to draw the whole bar
      BITMAP* subArmor = NULL;
      sy = (int)this->tankGreen.GetArmor();
      height =  (float)this->pBitmap[gfx::ARMORBAR]->h;
      // calculate start y of sub-bitmap
      sy = (int)(height - ( ((float)sy/this->maxArmor) * height ));
      // calculate height of sub-bitmap
      subH = ((int)height - sy);
      if(subH > 0) // don't do anything if the height of the subbitmap is <= 0
      {
        subArmor = create_sub_bitmap(this->pBitmap[gfx::ARMORBAR], 0, sy, this->pBitmap[gfx::ARMORBAR]->w, subH);
        if(subArmor !=NULL)
        {
          // draw it at calculated position
          int dy = 35 + sy;
          draw_sprite(this->backbuffer, subArmor, 104, dy);
          
          // remove sub-bitmap
          destroy_bitmap(subArmor);
          subArmor = NULL;
        }
      }
      
    
    // render left engine status
    float greenEngineStatus = this->tankGreen.GetEngineStatus();
    if(greenEngineStatus == 1.0f)
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LEVER0], 32, 114);
    if(greenEngineStatus == 0.0f)
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LEVER1], 32, 114);
    if(greenEngineStatus == -1.0f)
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LEVER2], 32, 114);
        
    // render left gun status
    if(!this->tankGreen.IsReadyToFire())
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LAMP0], 82, 123);
    else
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LAMP1], 82, 123);
      
  
  // render status display for player two
  draw_sprite_h_flip(this->backbuffer, this->pBitmap[gfx::STATUS], SCREEN_W - this->pBitmap[gfx::STATUS]->w, 0);

    // render player name
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W - 74, 9, this->color[gfx::white], -1,
      (char*)this->playerTwoName.c_str());
    
    // render right heatbar
      // create a sub-bitmap, since I don't want to draw the whole bar
      subHeat = NULL;
      sy = (int)this->tankRed.GetHeat();
      height =  (float)this->pBitmap[gfx::HEATBAR]->h;
      // calculate start y of sub-bitmap
      sy = (int)(height - ( ((float)sy/this->maxHeat) * height ));
      // calculate height of sub-bitmap
      subH = ((int)height - sy);
      if(subH > 0) // don't do anything if the height of the subbitmap is <= 0
      {
        subHeat = create_sub_bitmap(this->pBitmap[gfx::HEATBAR], 0, sy, this->pBitmap[gfx::HEATBAR]->w, subH);
        if(subHeat !=NULL)
        {
          // draw it at calculated position
          int dy = 35 + sy;
          draw_sprite_h_flip(this->backbuffer, subHeat, 693, dy);
          
          // remove sub-bitmap
          destroy_bitmap(subHeat);
          subHeat = NULL;
        }
      }
    
    // render right armorbar
      // create a sub-bitmap, since I don't want to draw the whole bar
      subArmor = NULL;
      sy = (int)this->tankRed.GetArmor();
      height =  (float)this->pBitmap[gfx::ARMORBAR]->h;
      // calculate start y of sub-bitmap
      sy = (int)(height - ( ((float)sy/this->maxArmor) * height ));
      // calculate height of sub-bitmap
      subH = ((int)height - sy);
      if(subH > 0) // don't do anything if the height of the subbitmap is <= 0
      {
        subArmor = create_sub_bitmap(this->pBitmap[gfx::ARMORBAR], 0, sy, this->pBitmap[gfx::ARMORBAR]->w, subH);
        if(subArmor !=NULL)
        {
          // draw it at calculated position
          int dy = 35 + sy;
          draw_sprite_h_flip(this->backbuffer, subArmor, 661, dy);
          
          // remove sub-bitmap
          destroy_bitmap(subArmor);
          subArmor = NULL;
        }
      }
    
    // render right engine status
    float redEngineStatus = this->tankRed.GetEngineStatus();
    if(redEngineStatus == 1.0f)
      draw_sprite_h_flip(this->backbuffer, this->pBitmap[gfx::LEVER0], 749, 114);
    if(redEngineStatus == 0.0f)
      draw_sprite_h_flip(this->backbuffer, this->pBitmap[gfx::LEVER1], 749, 114);
    if(redEngineStatus == -1.0f)
      draw_sprite_h_flip(this->backbuffer, this->pBitmap[gfx::LEVER2], 749, 114);
        
    // render right gun status
    if(!this->tankRed.IsReadyToFire())
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LAMP0], 703, 123);
    else
      draw_sprite(this->backbuffer, this->pBitmap[gfx::LAMP1], 703, 123);
  
  // render copies of tanks into status displays
  flPoint2D ldcc; // left display circle center
  ldcc.x = 42.0f;
  ldcc.y = 67.0f;
  flPoint2D rdcc; // right display circle center
  rdcc.x = (float)SCREEN_W - 42.0f;
  rdcc.y = 67.0f;
  this->renderTanks(&ldcc, &rdcc);
  
  // render targetting help circles into status displays
  // use trigonometry and analytical geometry to calculate circle position for red circle
  flPoint2D towardsRedTank = Cartesian::vector(this->tankGreen.GetPosPtr(), this->tankRed.GetPosPtr());
  float angleToRedTank = Cartesian::vectorAngleCW(&towardsRedTank);
  towardsRedTank = Cartesian::vectorFromPolarCW(28.0f, angleToRedTank);
  flPoint2D posRedCircle = Cartesian::vectorSum(&ldcc, &towardsRedTank);
  
  // use trigonometry and analytical geometry to calculate circle position for green circle
  flPoint2D towardsGreenTank = Cartesian::vector(this->tankRed.GetPosPtr(), this->tankGreen.GetPosPtr());
  float angleToGreenTank = Cartesian::vectorAngleCW(&towardsGreenTank);
  towardsGreenTank = Cartesian::vectorFromPolarCW(28.0f, angleToGreenTank);
  flPoint2D posGreenCircle = Cartesian::vectorSum(&rdcc, &towardsGreenTank);
  
  solid_mode();
  circlefill(this->backbuffer, (int)posRedCircle.x, (int)posRedCircle.y, 2, this->color[gfx::red]);
  circlefill(this->backbuffer, (int)posGreenCircle.x, (int)posGreenCircle.y, 2, this->color[gfx::green]);
    
  if(displayTimer)
  {
    // calculate remaining match time in minutes and seconds
    int minutes = (int)(floor((float)this->logicFramesLeft / (float)this->logicUpdatesPerSecond) / 60);
    int seconds = (this->logicFramesLeft - (minutes * 60 * this->logicUpdatesPerSecond)) / this->logicUpdatesPerSecond;
    static int previousSeconds = -1;
  
    if(this->logicFramesLeft < 0)
    {
      minutes = 0;
      seconds = 0;
    }
  
    // render time display for remaining match time
    draw_sprite(this->backbuffer, this->pBitmap[gfx::TIME], SCREEN_W / 2 - this->pBitmap[gfx::TIME]->w / 2, 0);
    int bgCol = -1;
    int fgCol = this->color[gfx::white];
    if(minutes == 0 && seconds <=30) // for flashing, if remaining time is less than 30 seconds
    {
      if(seconds % 2 == 0)
      {
        fgCol = this->color[gfx::black];
        bgCol = this->color[gfx::red];
        
        if(seconds != previousSeconds)
          this->playSound(sfx::alarm, 320.0f);
          
        previousSeconds = seconds;
      }
      else
        fgCol = this->color[gfx::red];
    }
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2 + 1, 12, fgCol, bgCol, 
       "%02u:%02u", minutes, seconds);
  }
}

void GameState::renderParticle(ptrParticle pParticle)
{
  particleTypes::ParticleType id = pParticle->GetId();
  
  if(id == particleTypes::inactive) // do nothing for inactive particles
    return;
  
  int frameNumber = 0;
  BITMAP* sprite = NULL;
  int x = (int)pParticle->GetPosPtr()->x;
  int y = (int)pParticle->GetPosPtr()->y;
  float size = pParticle->GetSize();
  int pSize = (int)size;
  int color = 0;
  int patternNumber = 0;
  switch(id)
  {
    case particleTypes::inactive: // do nothing
    break;
  
    case particleTypes::explosion: // render an explosion
      frameNumber = pParticle->GetFrame();
      sprite = this->pBitmap[(int)gfx::EXPL0 + frameNumber];
      draw_sprite(this->backbuffer, sprite,
                  x - sprite->w / 2,
                  y - sprite->h / 2);
    break;
    
    case particleTypes::shotTrail: // render a shot trail
      solid_mode();
      circle(this->backbuffer, x, y, pSize, this->color[gfx::white]);
    break;
    
    case particleTypes::tankTrail: // render a tank track piece
      pivot_sprite(this->backbuffer, this->pBitmap[gfx::TANKTRACK], x, y, 0, 2,
                   ftofix(MConst::fromDegTo256 * pParticle->GetAngle()));
    break;
    
    case particleTypes::muzzle: // render a gun muzzle
      pivot_scaled_sprite(this->backbuffer, this->pBitmap[gfx::MUZZLE], x, y, 0,5,
                   ftofix(MConst::fromDegTo256 * pParticle->GetAngle()), 
                   ftofix(pParticle->GetSize()));
    break;
  
    case particleTypes::smoke: // render smoke
      patternNumber = 0;
      patternNumber = (int)(floor(size / 5.0f));
      if(patternNumber >= 4)
        patternNumber = 4;
      if(patternNumber > 0)
        drawing_mode(DRAW_MODE_MASKED_PATTERN, this->pBitmap[(int)gfx::PATTERN + patternNumber -1], 0, 0);
      else
        solid_mode();
    
      color = this->color[gfx::black];
      if(pSize > 5)
        color = this->color[gfx::gray2];
      if(pSize > 10)
        color = this->color[gfx::gray1];
      
      circlefill(this->backbuffer, x, y, pSize, color);
    break;
  
    case particleTypes::fire: // [TODO]
    break;
  }
}

void GameState::renderParticles(int layer)
{
  if(!particlesAvailable) // do nothing, if no particles are available
    return;

  bool forward = layer == 2 ? false : true;

  for(int i=(forward ? 0 : this->maxParticles-1); i<this->maxParticles && i>=0; (forward ? i++ : i--)) // for all particles
  {
    bool render = false;
    particleTypes::ParticleType id = this->pParticleArray[i].GetId();
    
    // determine whether the particles should be rendered
    if(layer == -1)
    {
      render = (id == particleTypes::tankTrail);
    }
    if(layer == 0)
    {
      render = (id == particleTypes::shotTrail);
    }
    if(layer == 1)
    {
      render = (id == particleTypes::fire || id == particleTypes::muzzle);
    }
    if(layer == 2)
    {
      render = (id == particleTypes::explosion || id == particleTypes::smoke);
    }
    
    if(render)
      this->renderParticle(&this->pParticleArray[i]);
  }
}


void GameState::renderInGameAction(bool matchEndedRegularly, bool timeOut, int winner)
{
  clear_to_color(this->backbuffer, this->color[gfx::backgroundcolor]);
  
  // render tankTrails
  this->renderParticles(-1);
  
  this->renderCurrentMap(); // ..the map..
    
  // render shotTrails
  this->renderParticles(0); 
    
  this->renderTanks(tankGreen.GetPosPtr(), tankRed.GetPosPtr()); // ..the tanks in the game..
  
  // render active shots
  for(int i=0; i<this->maxShots; i++)
  {
    if(this->pShotArray[i].GetOwner() != -1)
    {
      pivot_sprite(this->backbuffer, this->pBitmap[gfx::SHOT],
                   (int)this->pShotArray[i].GetPosPtr()->x, 
                   (int)this->pShotArray[i].GetPosPtr()->y,
                   7, 3, ftofix(MConst::fromDegTo256 * (this->pShotArray[i].GetAngle()))); // rotated shot
    }
  }
  
  // render fires, muzzles, explosion and smoke particles
  this->renderParticles(1);
  this->renderParticles(2);
    
  this->renderStatusDisplay(true); // ..the status displays at the top..
    
  // render messages (use parameters to control what to display accordingly)
  if(matchEndedRegularly)
  {
    std::string winnerString;
    switch(winner)
    {
      case -1: // draw game
        winnerString.assign("Well fought, but neither of you is victorious!");
      break;
       
      case 0: // player one wins
        winnerString.assign(this->playerOneName + " wins this round");
        if(tankGreen.GetArmor() == this->maxArmor) // flawless?
          winnerString.append("(flawless)!");
        else 
          winnerString.append("!");
      break;
      
      case 1: // player two wins
        winnerString.assign(this->playerTwoName + " wins this round");
        if(tankRed.GetArmor() == this->maxArmor) // flawless?
          winnerString.append("(flawless)!");
        else 
          winnerString.append("!");
      break;
    }
    
    // render box for text display
    this->renderMenuBox(SCREEN_W/2 , 60, 200, 12, this->color[gfx::white], this->color[gfx::gray1]);  
      
    // render winnerString
    textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, 60, this->color[gfx::white], -1,
                         winnerString.c_str());

    // render timeOut message                            
    if(timeOut)
    {
      textprintf_centre_ex(this->backbuffer, font, SCREEN_W / 2, 50, this->color[gfx::white], -1,
                           "Time is up! (press escape or wait)");
    }
  }
    
  // ..blit everything to screen
  this->backbufferToScreen();
}


void GameState::playSound(sfx::sfxResources toPlay, float px)
{
  this->playSound(toPlay, px, 240.0f, 1.0f, 0);
}

int GameState::playSound(sfx::sfxResources toPlay, float px, float py, float speed, int loop)
{
  if(this->soundAvailable && this->pSample[toPlay] != NULL)
  {
    int pan = int(floor((px / 640.0f) * 255.0f));
    int volume = 255;
    float volDecrease = (float)fabs(240.0f - py) * 0.5f;
    volume = volume - int(volDecrease);
    
    if(reverseStereo)
      pan = 255 - pan;
    
    int freq = int(1000.0f * speed);
    
    //if(toPlay == sfx::alarm)
    //  freq = 1500;
    
    return play_sample(this->pSample[toPlay], volume, pan, freq, loop);
  }
  else
    return -1;
}

void GameState::adjustSound(sfx::sfxResources toAdjust, float px, float py, float speed, int loop)
{
  if(this->soundAvailable && this->pSample[toAdjust] != NULL)
  {
    int pan = int(floor((px / 640.0f) * 255.0f));
    int volume = 255;
    float volDecrease = (float)fabs(240.0f - py) * 0.5f;
    volume = volume - int(volDecrease);
    
    if(reverseStereo)
      pan = 255 - pan;
    
    int freq = int(1000.0f * speed);
    
    adjust_sample(this->pSample[toAdjust], volume, pan, freq, loop);
  }
}

void GameState::adjustVoice(int voice, float px, float py)
{
  if(this->soundAvailable && voice != -1)
  {
    int pan = int(floor((px / 640.0f) * 255.0f));
    int volume = 255;
    float volDecrease = (float)fabs(240.0f - py) * 0.5f;
    volume = volume - int(volDecrease);
    
    if(reverseStereo)
      pan = 255 - pan;
      
    voice_set_volume(voice, volume);
    voice_set_pan(voice, pan);
  }
}

void GameState::stopSound(sfx::sfxResources toStop)
{
  if(this->soundAvailable && this->pSample[toStop] != NULL)
  {
    stop_sample(this->pSample[toStop]);
  }
}

void GameState::RunMainMenu()
{
  // load players and make sure there are at least two of them
  this->gatherPlayers();
  
  // gather map files
  if(!exitProgramme)
    this->gatherMaps();
  
  // start main menu loop
  if(!exitProgramme)
    this->controlMainMenu();
}

// for DEBUG, just a self test that displays all graphic resources
void GameState::__DisplayGraphics()
{
  if(this->backbuffer != NULL)
  {
    // clear_bitmap(this->backbuffer);
    for(int i=0; i < gfx::TOTALNUMBEROFBITMAPSEXPECTED; i++)
    {
      if(this->pBitmap[i] != NULL)
      {
        masked_blit(this->pBitmap[i], this->backbuffer, 0,0, 0+i*12, 0+i*12, this->pBitmap[i]->w, this->pBitmap[i]->h);
      }
    }
    // blit(this->backbuffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
  }
}

#undef LOG
