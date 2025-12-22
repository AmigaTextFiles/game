/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "Shot.hpp"


Shot::Shot()
{
  this->init();
}

Shot::Shot(flPoint2D pos, float angle, float speed, int owner)
{
  this->init(pos, angle, speed, owner);
}

Shot::~Shot()
{
  // nothing to do
}

void Shot::init()
{
  // set everything to default values
  this->pos.x = 0.0f;
  this->pos.y = 0.0f;
  this->mov.x = 0.0f;
  this->mov.y = 0.0f;
  this->angle = 0.0f;
  this->speed = 0.0f;
  this->owner = -1;
}

void Shot::init(flPoint2D pos, float angle, float speed, int owner)
{
  this->init();
  this->pos = pos;
  this->angle = angle;
  this->speed = speed;
  this->owner = owner;
  this->mov = Cartesian::vectorFromPolarCW(speed, angle);
}
