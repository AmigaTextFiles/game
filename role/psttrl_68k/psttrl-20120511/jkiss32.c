#include <stdio.h>
/* rand, srand */
#include <stdlib.h>
/* CHAR_BIT */
#include <limits.h>
/* time */
#include <time.h>

#include "config.h"

#include "jkiss32.h"

#ifdef USE_BUILT_IN_RAND

/* an implementation of 31-bit rand() and srand()
 * assumes that unsigned int has at least 32 bits
 */
/* based on JKISS32 RNG by David Jones,
 * a 32-bit KISS RNG which uses no multiply instruction
 * http://www.cs.ucl.ac.uk/staff/d.jones/GoodPracticeRNG.pdf
 */

#define DEFAULT_LCG_X 123456789u
/* DEFAULT_XORSHIFT_X must not be 0 */
#define DEFAULT_XORSHIFT_X 234567891u;
/* at least one of DEFAULT_AWC_X0, DEFAULT_AWC_X1 and DEFAULT_AWC_C
 * must be non-zero
 * DEFAULT_AWC_X0 and DEFAULT_AWC_X1 must be less than 2 ** 31
 * DEFAULT_AWC_C must be 0u or 1u
 */
#define DEFAULT_AWC_X0 345678912u
#define DEFAULT_AWC_X1 456789123u
#define DEFAULT_AWC_C 0u

static unsigned int lcg_x = DEFAULT_LCG_X;
static unsigned int xorshift_x = DEFAULT_XORSHIFT_X;
static unsigned int awc_x0 = DEFAULT_AWC_X0;
static unsigned int awc_x1 = DEFAULT_AWC_X1;
static unsigned int awc_c = DEFAULT_AWC_C;

#endif /* USE_BUILT_IN_RAND */

static unsigned int lfsr_next(unsigned int n);

#ifdef USE_BUILT_IN_RAND

int
rand(void)
{
  unsigned int awc_x2;

  /* Linear Congruential Generator modulo 2 ** 32
   * (only the lower 32 bits are used)
   * note that 0x542023abu is _not_ prime
   * (0x542023abu = 1411392427 = 293 * 4817039)
   */
  lcg_x += 0x542023abu;

  /* 32-bit Xorshift */
  xorshift_x ^= (xorshift_x << 5);
  /* unsigned int may be longer than 32 bit */
  xorshift_x &= 0xffffffffu;
  xorshift_x ^= (xorshift_x >> 7);
  xorshift_x ^= (xorshift_x << 22);

  /* 31-bit Add-With-Carry */
  awc_x2 = awc_x1 + awc_x0 + awc_c;
  awc_x0 = awc_x1;
  awc_x1 = awc_x2 & 0x7fffffffu;
  /* awc_c is 1u if awc_x2 is "overflowed" as a 31-bit integer,
   * 0u otherwise
   */
  awc_c = (unsigned int) (awc_x2 >= 0x80000000u);

  return (int) ((lcg_x + xorshift_x + awc_x1) & 0x7fffffffu);
}

void
srand(unsigned int seed)
{
  lcg_x = DEFAULT_LCG_X;
  xorshift_x = DEFAULT_XORSHIFT_X;
  awc_x0 = DEFAULT_AWC_X0;
  awc_x1 = DEFAULT_AWC_X1;
  awc_c = DEFAULT_AWC_C;

  awc_x1 = seed;
}

#endif /* USE_BUILT_IN_RAND */

/* this value is taken from Wikipedia
 * http://en.wikipedia.org/wiki/Linear_feedback_shift_register
 */
#define MAGIC_TAP 0xd0000001u

/* 32-bit Galois Linear Feedback Shift Register */
/* assumes that n is less than 2 ** 32 */
static unsigned int
lfsr_next(unsigned int n)
{
  /* (n & 1u) is unsigned 0 or 1.
   * If (n & 1u) is 0u, -(n & 1u) is 0u.
   * Otherwise, all bits in -(n & 1u) is 1.
   * Therefore, ((-(n & 1u)) & MAGIC_TAP) is 0u or MAGIC_TAP.
   */
  return (n >> 1) ^ ((-(n & 1u)) & MAGIC_TAP);
}

int
initialize_rand(void)
{
  int i;
  unsigned int n;
  unsigned int seed;
  time_t t_now;

#ifdef USE_BUILT_IN_RAND

  if (sizeof(unsigned int) * CHAR_BIT < 32)
  {
    fprintf(stderr, "initialize_rand: unsigned int is shorter than 32 bit\n");
    return 1;
  }

#endif /* USE_BUILT_IN_RAND */

  t_now = time(NULL);
  /* time() returns (time_t) (-1) on error
   * don't use == here because time_t can be a floating-point number
   * on some system
   */
  if (t_now < (time_t) 0)
  {
    fprintf(stderr, "initialize_rand: time() failed\n");
    return 1;
  }

  /* assumes that t_now is non-negative and small enough */
  seed = (unsigned int) t_now;
  srand(seed);

  /* discard some numbers */
  for (i = 0; i < 128; i++)
    rand();

  /* discard more numbers */
  if (seed != 0)
  {
    /* n must be less than 2 ** 32 */
    n = seed & 0xffffffffu;
    for (i = 0; i < 128; i++)
    {
      if (n & 1u)
      {
        rand();
      }
      n = lfsr_next(n);
    }
  }

  return 0;
}
