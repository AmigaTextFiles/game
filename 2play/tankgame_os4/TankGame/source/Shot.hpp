/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "myMath.hpp"

#if !defined(_Shot_HEAD_INCLUDED)
#define _Shot_HEAD_INCLUDED

class Shot;
typedef Shot* ptrShot;

// class to handle a single shot
class Shot
{
  private: 
    flPoint2D pos; // position
    flPoint2D mov; // movement vector
    float angle;   // direction (0.0 is facing right, rotation is clockwise)
    float speed;   // movement speed
    int owner;     // 0 player1, 1 player2, -1 n.d. (inactive)

    void init();
    void init(flPoint2D pos, float angle, float speed, int owner);
  
  public:
    // constructors
    Shot();
    Shot(flPoint2D pos, float angle, float speed, int owner);
    // destructor
    ~Shot();

    // accessors
    ptrFlPoint2D GetPosPtr() { return &(this->pos); }
    ptrFlPoint2D GetSpeedPtr() { return &(this->mov); }
    float GetAngle() { return angle; }
    float GetSpeed() { return speed; }
    int GetOwner() { return owner; }

    void Deactivate() { this->owner = -1; }
    void SetPos(flPoint2D pos) { this->pos = pos; }
    void Reset(flPoint2D pos, float angle, float speed, int owner) { this->init(pos, angle, speed, owner); }
};

#endif // #if !defined(_Shot_HEAD_INCLUDED)
