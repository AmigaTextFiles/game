/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "GameState.hpp"

// programme entry point
int main(void)
{
  GameState tankgame; // main gamestate/input/logic/output/resources manager

// FORDEBUG
/*
Scoreboard sc;
char buf[255];
srand(time(NULL));
for(int i=0; i<100; i++)
{
  sprintf(buf, "Test%i", rand()%10000);
  sc.RegisterPlayer(buf);
  int wins = rand()%100;
  for(int j=0; j<wins; j++)
  {
    (sc.GetPtrPlayer(buf))->IncreaseWin( (rand()%50 < 25) );
  }
}
sc.Write("./players.tgs");//*/
// END OF FORDEBUG

  int exitCode = 0; // will be used as exitCode for calling environment

  // try to load game constants from configuration file
  tankgame.LoadConfiguration("constants.cfg");
  
  // init Allegro and all hardware handlers
  int initResult = tankgame.StartupAl();
  if(initResult != 0)
    exitCode = -1;

  if(initResult == 0) // initialization was ok, so continue
  {
    // load resources
    if(tankgame.LoadResources() == 0)
    {
      // tankgame.__DisplayGraphics(); // run graphics self test (for DEBUGGING)
      
      // run the main menu (does not return until game exits)
      tankgame.RunMainMenu();
    }
    else
      exitCode = -2;
  }
  
  // release all used resources
  tankgame.FreeAllResources();
  
  // deinit Allegro and all hardware handlers
  tankgame.ShutdownAl();

  return exitCode;
}
END_OF_MAIN() // magic Allegro macro that inserts platform specific programme entry point, which calls main
