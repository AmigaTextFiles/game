#include <stdio.h>

#include "enchantment-detail.h"

const char *
enchantment_name(int type)
{
  switch (type)
  {
  case ENC_POISON:
    return "poison";
    break;
  case ENC_FAST:
    return "fast";
    break;
  case ENC_SLOW:
    return "slow";
    break;
  default:
    return "unknown enchantment";
    break;
  }

  return "should not reach here";
}
