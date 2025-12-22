/*
    Amiga Joystick and Joypad support for ORBIT

    29.04.2000 - written, tested, worked :)
    30.04.2000 - added diagonal movement,
                 pitch roll for joypad,
                 fire while moving
*/

#include "orbit.h"

LucyPlayJoystick *lucy_joy = NULL;

void InitJoy()
{
  if (lucy_joy = lucJoyInit())
    joy_available = 1;
  else
    joy_available = 0;
}

void JoyStick()
{
  /* Ignore joystick motion if dead */
  if ((state == STATE_DEAD1) || (state == STATE_DEAD2)) return;

  lucJoyRead(lucy_joy);

  if (lucy_joy->Red)      PlayerFires();
  if (lucy_joy->Up)       player.move_up = 0.5;
  if (lucy_joy->Down)     player.move_down = 0.5;
  if (lucy_joy->Left)     player.move_left = 0.5;
  if (lucy_joy->Right)    player.move_right = 0.5;
  if (lucy_joy->Forward)  player.move_pitchright = 1.0;
  if (lucy_joy->Reverse)  player.move_pitchleft = 1.0;
}

void FreeJoy()
{
  if (lucy_joy) lucJoyKill(lucy_joy);
}
