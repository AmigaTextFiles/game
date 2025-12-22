#include <stdlib.h>
#include <math.h>

#include "LunaMath.h"
#include "grp_table.h"

void LunaMath::Initialize(int seed)
{
  srand( (unsigned long) seed );
}

float LunaMath::Sin( long Angle )
{
  int  r;

  r = (360 * Angle) / 65536;

  return(sprite_sin[r]);
}

float LunaMath::Cos( long Angle )
{
  int  r;

  r = (360 * Angle) / 65536;

  return(sprite_cos[r]);
}

long LunaMath::Atan( long Dx, long Dy )
{
  float  dig, r;

  dig = atan2((float)Dx, (float)(Dy));
  r = 65536.0 * dig / (3.1415926535 * 2);

  return((long)r);
}

long LunaMath::Rand( long Start, long End )
{
  return (rand() % (End - Start + 1)) + Start;
}

float LunaMath::RandF( void )
{
  long  r;

  r = Rand(0, 4096);
  return ((float)r / 4096.0);
}
