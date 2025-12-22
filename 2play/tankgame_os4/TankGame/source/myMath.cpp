/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include "myMath.hpp"

float Cartesian::distance(ptrFlPoint2D pA, ptrFlPoint2D pB)
{
  flPoint2D vD;
  vD.x = pB->x - pA->x;
  vD.y = pB->y - pA->y;
  return sqrt( vD.x * vD.x + vD.y * vD.y );
}

flPoint2D Cartesian::vector(ptrFlPoint2D pA, ptrFlPoint2D pB)
{
  flPoint2D v;
  v.x = pB->x - pA->x;
  v.y = pB->y - pA->y;
  return v;
}

flPoint2D Cartesian::unitVector(ptrFlPoint2D pA)
{
  float len = vectorLength(pA);
  if(len != 0.0f)
  {
    flPoint2D r;
    r.x = pA->x / len;
    r.y = pA->y / len;
    return r;
  }
  else
  {
    return Cartesian::nullVector2D();
  } 
}

float Cartesian::vectorLength(ptrFlPoint2D pA)
{
  return sqrt( pA->x * pA->x + pA->y * pA->y );
}

float Cartesian::vectorAngleCW(ptrFlPoint2D pA)
{
  if(pA->x == 0.0f && pA->y == 0.0f)
    return 0.0f;
  else
  {
    float len = Cartesian::vectorLength(pA);
    float angle = acos(pA->x / len) * MConst::toDegFactor;
    if(pA->y > 0.0f)
    {
      return angle;
    }
    else if(pA->y < 0.0f)
    {
      return 360.0f - angle;
    }
    else
      return angle; // y == 0.0f
  }
}

float Cartesian::vectorAngleCCW(ptrFlPoint2D pA)
{
  if(pA->x == 0.0f && pA->y == 0.0f)
    return 0.0f;
  else
  {
    float len = Cartesian::vectorLength(pA);
    float angle = acos(pA->x / len) * MConst::toDegFactor;
    if(pA->y < 0.0f)
    {
      return angle;
    }
    else if(pA->y > 0.0f)
    {
      return 360.0f - angle;
    }
    else
      return angle; // y == 0.0f
  }
}

flPoint2D Cartesian::vectorFromPolarCW(float length, float angleDeg)
{
  flPoint2D v;
  float angRad = angleDeg * MConst::toRadFactor;
  v.x = cos(angRad) * length;
  v.y = sin(angRad) * length;
  return v;
}

flPoint2D Cartesian::vectorFromPolarCCW(float length, float angleDeg)
{
  flPoint2D v;
  float angRad = angleDeg * MConst::toRadFactor;
  v.x = cos(angRad) * length;
  v.y = -1.0f * (sin(angRad) * length);
  return v;
}

flPoint2D Cartesian::vectorSum(ptrFlPoint2D pA, ptrFlPoint2D pB)
{
  flPoint2D v;
  v.x = pA->x + pB->x;
  v.y = pA->y + pB->y;
  return v;
}

float Cartesian::normalizeAngle(float angle)
{
  float tmpAngle = angle;
  tmpAngle = fmod(tmpAngle, 360.0f);
  if(tmpAngle < 0.0f)
    tmpAngle = 360.0f + tmpAngle;
  return tmpAngle;
}
