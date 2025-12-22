/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Tank.hpp"

Tank::Tank()
{
  this->init();
}

Tank::Tank(flPoint2D pos, float bAngle, float gAngle, float heat, float armor)
{
  this->init(pos, bAngle, gAngle, heat, armor);
}

Tank::~Tank()
{
  // nothing to do
}

void Tank::init()
{
  this->bodyAngle = 0.0f;
  this->gunAngle = 0.0f;
  this->heat = 0.0f;
  this->armor = 0.0f;

  this->pos.x = 0.0f;
  this->pos.y = 0.0f;
  this->mov.x = 0.0f;
  this->mov.y = 0.0f;
 
  this->speed = 0.0f;
  this->engineStatus = 0.0f;
  this->previousDirection = -1.0f;

  this->reloading = 0;
}

void Tank::init(flPoint2D pos, float bAngle, float gAngle, float heat, float armor)
{
  this->init();

  this->pos = pos;
  this->bodyAngle = bAngle;
  this->gunAngle = gAngle;
  this->heat = heat;
  this->armor = armor;
}

void Tank::Reset(flPoint2D pos, float bAngle, float gAngle, float heat, float armor)
{
  this->init(pos, bAngle, gAngle, heat, armor);
}

void Tank::ToggleEngineStatus()
{
  if(this->engineStatus == 1.0f) // forward to stop
  {
    this->previousDirection = 1.0f;
    this->engineStatus = 0.0f;
    return;
  }

  if(this->engineStatus == -1.0f) // reverse to stop
  {
    this->previousDirection = -1.0f;
    this->engineStatus = 0.0f;
    return;
  }

  if(this->engineStatus == 0.0f)
  {
    if(this->previousDirection == 1.0f) // stop to reverse
      this->engineStatus = -1.0f;
    else // reverse to stop
      this->engineStatus = 1.0f;
  }
}

bool Tank::UpdateReload(bool tooHot)
{
  if(this->reloading > 0)
  {
    this->reloading--;
    
    if(tooHot && this->reloading == 0)
      this->reloading = 1;
    
    if(this->reloading == 0)
      return true;
    else
      return false;
  }
  
  return false;
}

void Tank::UpdateHeat(float value, float maxHeat)
{
  this->heat += value;
  if(this->heat < 0.0f)
    this->heat = 0.0f;
  if(this->heat > maxHeat)
    this->heat = maxHeat;
}

void Tank::TakeDamage(float amount)
{
  this->armor -= amount;
  if(this->armor < 0.0f)
    this->armor = 0.0f;
}

void Tank::RotateBody(float degrees)
{
  this->bodyAngle += degrees;
  this->RotateGun(degrees); // rotate gun as well, since it is attached to body
  this->bodyAngle = Cartesian::normalizeAngle(this->bodyAngle);
}

void Tank::RotateGun(float degrees)
{
  this->gunAngle += degrees;
  this->gunAngle = Cartesian::normalizeAngle(this->gunAngle);
}

void Tank::UpdateSpeed(float acceleration, float maxSpeed)
{
  if(this->engineStatus == 0.0f) // want to stop?
  {
    if(this->speed < 0.0f)
    {
      this->speed += acceleration;
      if(this->speed > 0.0f)
        this->speed = 0.0f; 
    }
    else
    {
      this->speed -= acceleration;
      if(this->speed < 0.0f)
        this->speed = 0.0f;
    }
  }
  else // keep accelerating in current direction
  {
    this->speed += acceleration * this->engineStatus;
    if(this->speed < -1.0f * maxSpeed)
      this->speed = -1.0f * maxSpeed;
    if(this->speed > maxSpeed)
      this->speed = maxSpeed;
  }
}
