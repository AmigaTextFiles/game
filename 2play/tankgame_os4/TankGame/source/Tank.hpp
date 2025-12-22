/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include <cmath>
#include "myMath.hpp"

#if !defined(_Tank_HEAD_INCLUDED)
#define _Tank_HEAD_INCLUDED

class Tank;
typedef Tank* ptrTank;

// a class to handle a tank
class Tank
{
  private:
    float bodyAngle; // orientation of tank body
    float gunAngle; // orientation of tank gun
    float heat; // heat (has influence on gun)
    float armor; // armor (has influence on movement speed)

    flPoint2D pos; // position
    flPoint2D mov; // movement vector
    float speed; // movement speed
    float engineStatus; // -1.0 reverse, 0.0 stop, 1.0 forward)
    float previousDirection; // to determine which status is next if current status is 0.0

    int reloading; // gun is ready to fire at 0

    void init();
    void init(flPoint2D pos, float bAngle, float gAngle, float heat, float armor);

  public:
    // constructors
    Tank();
    Tank(flPoint2D pos, float bAngle, float gAngle, float heat, float armor);
    // destructor
    ~Tank();

    // accessors
    void Reset(flPoint2D pos, float bAngle, float gAngle, float heat, float armor);

    float GetBodyAngle() { return bodyAngle; }
    float GetGunAngle() { return gunAngle; }
    float GetHeat() { return heat; }
    float GetArmor() { return armor; }

    ptrFlPoint2D GetPosPtr() { return &(this->pos); }
    ptrFlPoint2D GetMovPtr() { this->mov = Cartesian::vectorFromPolarCW(this->speed, this->bodyAngle); return &(this->mov); }
    void UpdatePos() { this->pos = Cartesian::vectorSum(GetPosPtr(), GetMovPtr()); }  // update pos without doing any checks
    float GetSpeed() { return this->speed; }
    float GetEngineStatus() { return this->engineStatus; }

    void ToggleEngineStatus(); // toggles between forward, stop, reverse, stop,...
    bool UpdateReload(bool tooHot); // decreases reload counter (returns true if the counter just reached zero)
    void UpdateHeat(float value, float maxHeat); // increases/decreases heat
    void TakeDamage(float amount); // decreases armor by amount
    
    void UpdateSpeed(float acceleration, float maxSpeed); // accelerate/slowdown tank
    
    bool IsReadyToFire() { return (reloading == 0); }
    bool IsDestroyed() { return (armor <= 0.0f); }

    // sets the reload time given as delay in logic cycles
    void SetReloading(int delay) { reloading = delay; }

    void RotateBody(float degrees); // positive values for clockwise rotation
    void RotateGun(float degrees); // positive values for clockwise rotation
};

#endif // #if !defined(_Tank_HEAD_INCLUDED)
