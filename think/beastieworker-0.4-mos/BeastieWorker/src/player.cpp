#include "player.h"

const char *const_fileName[_PLAYER_STATE_]=
{
   "look.3d",
   "step.3d",
   "left.3d",
   "right.3d",
   "push.3d"
};

const float const_rotate   =  90.0f;
const float const_rotateMax= 360.0f;
const float const_rotateMin=   0.0f;

//----------------------------------------------//
class_player::class_player ()
{
   int i;
   for (i= 0; i < _PLAYER_STATE_; i++)
      player[i]= new class_model3d;
   actionState= _PLAYER_QUIETNESS_;
   angleRotate= const_rotate;
}
//----------------------------------------------//
class_player::~class_player ()
{
   int i;
   for (i= 0; i < _PLAYER_STATE_; i++)
      delete player[i];
}
//----------------------------------------------//
int class_player::load (char *input_fileDir)
{
   int iReturn= _OK_;
   int i;
   for (i= 0; i < _PLAYER_STATE_; i++)
   {
      type_string fileName;
      strcpy (fileName, input_fileDir);
      strcat (fileName, const_fileName[i]); 
      if (player[i]->load (fileName))
         iReturn= _ERR_;
   }
   return iReturn;
}
//----------------------------------------------//
float class_player::getAngle ()
{
   return angleRotate;
}
//----------------------------------------------//
int class_player::getPlay ()
{
   return actionState;
}
//----------------------------------------------//
int class_player::getPos (float *output_x, float *output_y, float *output_z)
{
   player[actionState]->getBasicJoint (output_x, output_y, output_z);
   return _OK_;
}
//----------------------------------------------//
int class_player::action (unsigned int input_action)
{
   if (actionState || input_action >= _PLAYER_STATE_)
      return actionState;
   actionState= input_action;
   switch (actionState)
   {
      case _PLAYER_LEFT_:
         if (angleRotate == const_rotateMax)
            angleRotate= const_rotateMin;
         angleRotate+= const_rotate;
      break;

      case _PLAYER_RIGHT_:
         if (angleRotate == const_rotateMin)
            angleRotate= const_rotateMax;
         angleRotate-= const_rotate;
      break;
   }
   if (actionState)
      player[_PLAYER_QUIETNESS_]->resetFrame ();
   player[actionState]->play= true;
   return _OK_;
}
//----------------------------------------------//
int class_player::draw ()
{
   glPushMatrix ();
   glRotatef (-90, 1, 0, 0);
   switch (actionState)
   {
      case _PLAYER_LEFT_:
         glRotatef (angleRotate - const_rotate, 0, 0, 1);
      break;

      case _PLAYER_RIGHT_:
         glRotatef (angleRotate + const_rotate, 0, 0, 1); 
      break;

      default:
         glRotatef (angleRotate, 0, 0, 1);
      break;
   }
   player[actionState]->draw ();
   glPopMatrix ();
   if (!player[actionState]->play)
      actionState= _PLAYER_QUIETNESS_;
   return _OK_;
}
//----------------------------------------------//
