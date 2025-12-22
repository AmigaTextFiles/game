/* Amiga Glulxe Glk implementation */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "glk.h"
#include "glkterm.h"
#include "glulxe.h"

char TitleBar[] = "Amiga Glulxe 0.4.7";
char AboutText[] =
  "Amiga Glulxe 0.4.7\n"
  "Glulxe © 1999-2010 by Andrew Plotkin\n"
  "Amiga version written by David Kinder\n"
  "AROS port by Szilárd Biró\n\n"  
  "This program includes software written\nby Eric Young (eay@cryptsoft.com)";
char InitReqTitle[] = "Select a Glulx Game";
char InitReqPattern[] = "#?.(ulx|blb|blorb|glb|gblorb)";

extern strid_t gamefile;

int amiga_startup_code(char* path)
{
  gamefile = gli_stream_open_pathname(path,0,0,0);
  if (!gamefile)
    return 0;

  glk_stream_set_position(gamefile,0,seekmode_Start);

  unsigned char buf[12];
  int res = glk_get_buffer_stream(gamefile,(char*)buf,12);
  if (!res)
    return 0;

  if (buf[0] == 'G' && buf[1] == 'l' && buf[2] == 'u' && buf[3] == 'l') {
    locate_gamefile(FALSE);
    return 1;
  }
  else if (buf[0] == 'F' && buf[1] == 'O' && buf[2] == 'R' && buf[3] == 'M'
    && buf[8] == 'I' && buf[9] == 'F' && buf[10] == 'R' && buf[11] == 'S') {
    locate_gamefile(TRUE);
    return 1;
  }
  return 0;
}

void* glulx_malloc(glui32 len)
{
  return malloc(len);
}

void* glulx_realloc(void* ptr, glui32 len)
{
  return realloc(ptr,len);
}

void glulx_free(void* ptr)
{
  free(ptr);
}

void glulx_setrandom(glui32 seed)
{
  if (seed == 0)
    seed = time(NULL);
  srand(seed);
}

glui32 glulx_random()
{
  return (rand() << 16) ^ rand();
}

void glulx_sort(void* addr, int count, int size, 
  int (*comparefunc)(void* p1, void* p2))
{
  qsort(addr,count,size,
    (int (*)(const void*,const void*))comparefunc);
}

#if defined __AROS__

int __isinff(float x)
{ 
  return !isnan((double) x) && isnan((double)x - (double)x);
}

gfloat32 glulx_powf(gfloat32 val1, gfloat32 val2)
{
  if (val1 == 1.0f)
    return 1.0f;
  else if ((val2 == 0.0f) || (val2 == -0.0f))
    return 1.0f;
  else if ((val1 == -1.0f) && isinf(val2))
    return 1.0f;
  return powf(val1, val2);
}

float glulx_fmodf(float x, float y)
{
  return fmodf(x, y);
}

#else
gfloat32 glulx_powf(gfloat32 val1, gfloat32 val2)
{
  float intPart;

  if ((val1 == +0.0f) || (val1 == -0.0f))
  {
    if (val2 < 0.0f)
    {
      if (fmodf(val2 / 2.0,&intPart) == -0.5f)
        return decode_float(signbit(val1) ? 0xff800000 : 0x7f800000); /* -Inf / +Inf */
      return decode_float(0x7f800000); /* +Inf */
    }
    else if (val2 > 0.0f)
    {
      if (fmodf(val2 / 2.0,&intPart) == 0.5f)
        return signbit(val1) ? -0.0f : +0.0f;
      return +0.0f;
    }
  }

  if (isinf(val1))
  {
    if (signbit(val1))
    {
      if (val2 < 0.0f)
      {
        if (fmodf(val2 / 2.0,&intPart) == -0.5f)
          return -0.0f;
        return +0.0f;
      }
      else if (val2 > 0.0f)
      {
        if (fmodf(val2 / 2.0,&intPart) == 0.5f)
          return decode_float(0xff800000); /* -Inf */
        return decode_float(0x7f800000); /* +Inf */
      }
    }
    else
    {
      if (val2 < 0.0f)
        return +0.0f;
      else if (val2 > 0.0f)
        return decode_float(0x7f800000); /* +Inf */
    }
  }

  if (val1 == 1.0f)
    return 1.0f;
  else if ((val2 == 0.0f) || (val2 == -0.0f))
    return 1.0f;
  else if ((val1 == -1.0f) && isinf(val2))
    return 1.0f;
  else if (isinf(val2))
  {
    if (signbit(val2))
      return (fabs(val1) < 1.0f) ? decode_float(0x7f800000) : 0.0f; /* +Inf */
    else
      return (fabs(val1) < 1.0f) ? 0.0f : decode_float(0x7f800000); /* +Inf */
  }
  else if ((val1 < 0.0f) && (fmodf(val2,&intPart) != 0.0f))
    return decode_float(0x7f800001); /* NaN */
  else if (isnan(val1) || isnan(val2))
    return decode_float(0x7f800001); /* NaN */
  return fpow(val1,val2);
}

int isnan(float x)
{
  unsigned long ex;
  *(float*)(&ex) = x;

  if ((ex & 0x7f800000) != 0x7f800000)
    return 0;
  if ((ex & 0x7fffff) == 0)
    return 0;
  return 1;
}

int isinf(float x)
{
  unsigned long ex;
  *(float*)(&ex) = x;

  if ((ex & 0x7f800000) != 0x7f800000)
    return 0;
  if ((ex & 0x7fffff) != 0)
    return 0;
  return 1;
}

int signbit(float x)
{
  unsigned long ex;
  *(float*)(&ex) = x;

  return (ex & 0x80000000) ? 1 : 0;
}

float ceilf(float x)
{
  if ((x == +0.0f) || (x == -0.0f))
    return x;
  return fceil(x);
}

float floorf(float x)
{
  if ((x == +0.0f) || (x == -0.0f))
    return x;
  return ffloor(x);
}

float truncf(float x)
{
  if ((x == +0.0f) || (x == -0.0f))
    return x;
  else if (x >= 0.0f)
    return ffloor(x);
  return fceil(x);
}

float roundf(float x)
{
  if ((x == +0.0f) || (x == -0.0f))
    return x;
  else if (x >= 0.0f)
    return ffloor(x+0.5f);
  return fceil(x-0.5f);
}

float sqrtf(float x)
{
  if (signbit(x))
  {
    if (x == -0.0f)
      return -0.0f;
    else
      return decode_float(0x7f800001); /* NaN */
  }
  return fsqrt(x);
}

float logf(float x)
{
  if ((x == +0.0f) || (x == -0.0f))
    return decode_float(0xff800000); /* -Inf */
  else if ((x < 0.0f) || isnan(x))
    return decode_float(0x7f800001); /* NaN */
  else if (isinf(x))
    return decode_float(0x7f800000); /* +Inf */
  return flog(x);
}

float expf(float x)
{
  if (isnan(x))
    return decode_float(0x7f800001); /* NaN */
  else if (isinf(x))
  {
    if (signbit(x))
      return 0.0f;
    else
      return decode_float(0x7f800000); /* +Inf */
  }
  return fexp(x);
}

float sinf(float x)
{
  if (isinf(x) || isnan(x))
    return decode_float(0x7f800001); /* NaN */
  return fsin(x);
}

float cosf(float x)
{
  if (isinf(x) || isnan(x))
    return decode_float(0x7f800001); /* NaN */
  return fcos(x);
}

float tanf(float x)
{
  if (isinf(x) || isnan(x))
    return decode_float(0x7f800001); /* NaN */
  return ftan(x);
}

float asinf(float x)
{
  if (isinf(x) || isnan(x) || (x < -1.0f) || (x > 1.0f))
    return decode_float(0x7f800001); /* NaN */
  return fasin(x);
}

float acosf(float x)
{
  if (isinf(x) || isnan(x) || (x < -1.0f) || (x > 1.0f))
    return decode_float(0x7f800001); /* NaN */
  return facos(x);
}

float atanf(float x)
{
  if (isnan(x))
    return decode_float(0x7f800001); /* NaN */
  else if (isinf(x))
    return decode_float(signbit(x) ? 0xbfc90fdb : 0x3fc90fdb); /* -Pi/2 / +Pi/2 */
  return fatan(x);
}

float atan2f(float x, float y)
{
  if (isnan(x) || isnan(y))
    return decode_float(0x7f800001); /* NaN */
  else if ((x == +0.0f) || (x == -0.0f) || (!isinf(x) && isinf(y)))
  {
    if (signbit(y))
      return decode_float(signbit(x) ? 0xC0490FDB : 0x40490FDB); /* -Pi / +Pi */
    else
      return signbit(x) ? -0.0f : +0.0f;
  }
  else if (isinf(x))
  {
    if (!isinf(y))
      return decode_float(signbit(x) ? 0xbfc90fdb : 0x3fc90fdb); /* -Pi/2 / +Pi/2 */
    else if (signbit(y))
      return decode_float(signbit(x) ? 0xc016cbe4 : 0x4016cbe4); /* -Pi*3/4 / +Pi*3/4 */
    else
      return decode_float(signbit(x) ? 0xbf490fdb : 0x3f490fdb); /* -Pi*4 / +Pi*4 */
  }
  return atan2(x,y);
}

float glulx_fmodf(float x, float y)
{
  if (isnan(x) || isnan(y) || (y == +0.0f) || (y == -0.0f))
    return decode_float(0x7f800001); /* NaN */
  else if (!isinf(x) && isinf(y))
    return x;
  else if ((x == +0.0f) || (x == -0.0f))
    return x;

  float rem = x - (y * truncf(x/y));
  if ((rem == 0.0f) && signbit(x))
    return -0.0f;
  return rem;
}
#endif
