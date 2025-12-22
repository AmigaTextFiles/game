/*
  --- Projectname: TankGame ---
  (Targetsystem: Crossplatform)
  
  Author: Dennis Busch, http://www.dennisbusch.de
          Dennis-Busch@gmx.net
*/

#include <math.h>

#if !defined(_myMath_HEAD_INCLUDED)
#define _myMath_HEAD_INCLUDED

// a point in 2D cartesian space
struct flPoint2D
{
  float x;
  float y;
};
typedef flPoint2D* ptrFlPoint2D;

// constants for DEG, RAD conversions
namespace MConst
{
  const float myPI = 3.14159265358979f; // PI as a constant
  const float toDegFactor = 180.0f / myPI; // multiply with an angle in RAD to get DEG
  const float toRadFactor = myPI / 180.0f; // multiply with an angle in DEG to get RAD
  
  const float fromDegTo256 = 256.0f / 360.0f; // multiply with an angle in DEG to sample down to have 256 be the full circle
}

// standard 2D cartesian coordinate system functions
class Cartesian
{
  public:
    // returns the 2D 0-vector
    static inline flPoint2D nullVector2D() { flPoint2D n; n.x = 0.0f; n.y = 0.0f; return n; }

     // pythagorean distance between two points
    static float distance(ptrFlPoint2D pA, ptrFlPoint2D pB);

     // vector from pA to pB
    static flPoint2D vector(ptrFlPoint2D pA, ptrFlPoint2D pB);

    // unit vector of pA
    static flPoint2D unitVector(ptrFlPoint2D pA);

    // length of pA
    static float vectorLength(ptrFlPoint2D pA);

    // angle between (1,0) and vector from (0,0) to pA (clockwise)
    static float vectorAngleCW(ptrFlPoint2D pA);

    // angle between (1,0) and vector from (0,0) to pA (counterclockwise)
    static float vectorAngleCCW(ptrFlPoint2D pA);

    // e.g.: (1, 90°) -> (0, 1)
    static flPoint2D vectorFromPolarCW(float length, float angleDeg);

    // e.g.: (1, 90°) -> (0,-1)
    static flPoint2D vectorFromPolarCCW(float length, float angleDeg);

    // add two vectors
    static flPoint2D vectorSum(ptrFlPoint2D pA, ptrFlPoint2D pB);
    
    // normalize an angle, so it's always between 0.0f and 360.0f
    static float normalizeAngle(float angle);
};

#endif // #if !defined(_myMath_HEAD_INCLUDED)
