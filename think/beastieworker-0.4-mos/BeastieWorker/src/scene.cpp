#include "scene.h"

#define _SC_ 17.0f

const char *const_file[6]=
{
   "map",
   "wall.bmp",
   "floorA.bmp",
   "boxA.bmp",
   "floorB.bmp",
   "boxB.bmp"
};

//----------------------------------------------//
class_scene::class_scene ()
{
   levels.list= NULL;
   modelPlayer= NULL;
   map.data= NULL;
   levels.size= 0;
   map.i= 0;
   map.j= 0;
   points= 0;
   pointsFilling= 0;
   numberPresentLevel= 0;
}
//----------------------------------------------//
class_scene::~class_scene ()
{
   if (!levels.size)
      delete levels.list;

//   if (modelPlayer)
//      delete modelPlayer;

   delLevel ();
}
//----------------------------------------------//
int class_scene::delLevel ()
{
   unsigned int i;
   if (!map.j && !map.i)
   {
      for (i= 0; i < map.i; i++)
         delete map.data[i];
      delete map.data;
   }
   for (i= 0; i < _AMOUNT_TEXTURES_; i++)
      texture[i].del ();
   map.i= 0;
   map.j= 0;
   points= 0;
   pointsFilling= 0;
   return _OK_;
}
//----------------------------------------------//
int class_scene::fileExist (char *input_fileName)
{
   FILE *file= fopen (input_fileName, "rt");
   if (file == NULL)
      return _ERR_;
   fclose (file);
   return _OK_;
}
//----------------------------------------------//
int class_scene::loadLevelIndex (char *input_fileName)
{
   FILE *file= fopen (input_fileName, "rt");
   type_string strBuffer;
   unsigned int iBuffer= 0;
   while (!feof (file))
   {
      fgets (strBuffer, _STR_LENGTH_MAX_, file);
      if (strBuffer[0] != _CHAR_ENDLINE_)
         iBuffer++;
   }
   fclose (file);
   if (!iBuffer)
      return _ERR_;
   levels.size= iBuffer;
   levels.list= new type_string [iBuffer];
   file= fopen (input_fileName, "rt");
   type_string strDir;
   iBuffer= 0;
   while (!feof (file))
   {
      fgets (strBuffer, _STR_LENGTH_MAX_, file);
      if (strBuffer[0] == _CHAR_ENDLINE_)
         continue;
      findDir (input_fileName, strDir);
      strcat (strDir, strBuffer);
      findLastStr (strDir, levels.list[iBuffer++]);
   }
   fclose (file);
   return _OK_;
}
//----------------------------------------------//
int class_scene::loadMap (char *input_fileName)
{  
   type_string fileName;
   strcpy (fileName, input_fileName);
   strcat (fileName, const_file[0]);
   if (fileExist (fileName))
   {
      printf ("ERROR: file \"%s\" is not found\n", fileName);
      return _ERR_;
   }
   FILE *file= fopen (fileName, "rt");
   type_string strBuffer;
   while (!feof (file))
   {
      fgets (strBuffer, _STR_LENGTH_MAX_, file);
      if (strBuffer[0] == _CHAR_ENDLINE_)
         continue;
      if (strstr (strBuffer, "size"))
      {
         type_string strTemp;
         sscanf (strBuffer, "%s%ix%i", strTemp, &map.i, &map.j);
         break;
      }

   }
   if (!map.i || !map.j)
   {
      printf ("ERROR: bad data in file \"%s\"\n", fileName);
      fclose (file);
      return _ERR_;
   }
   map.data= new unsigned int* [map.i];
   unsigned int i;
   for (i = 0; i < map.i; i++)
      map.data[i]= new unsigned int [map.j];
   i= 0;
   unsigned int j= 0;
   unsigned int boxes= 0, players= 0;
   while (!feof (file))
   {
      fscanf (file, "%i", &map.data[i][j]);
      switch (map.data[i][j])
      {
         case _SECTOR_PLAYER_:
            player.i= i;
            player.j= j;
            players++;
         break;

         case _SECTOR_POINT_PLAYER_:
            player.i= i;
            player.j= j;
            players++;
            points++;
         break;

         case _SECTOR_POINT_BOX_:
            points++;
            pointsFilling++;
            boxes++;
         break;

         case _SECTOR_POINT_:
            points++;
         break;

         case _SECTOR_BOX_:
            boxes++;
         break;
      }
      if (++j == map.j)
      {
         j= 0;
         i++;
      }
   }
   if (boxes != points || players != 1 || !boxes)
   {
      fclose (file);
      printf ("ERROR: bad data in file \"%s\"\n", fileName);
      return _ERR_;
   }
   fclose (file);
   return _OK_;
}
//----------------------------------------------//
int class_scene::loadTexture (char *input_dir)
{
   type_string strBuffer;
   int iReturn= 0, i;
   for (i= 1; i < _SECTOR_PLAYER_; i++)
   {
      strcpy (strBuffer, input_dir);
      strcat (strBuffer, const_file[i]);
      if (texture[i].loadBMP (strBuffer))
      {
         printf ("ERROR: file \"%s\" is not load\n", strBuffer);
         iReturn= _ERR_;
      }
   }
   return iReturn;
}
//----------------------------------------------//
int class_scene::loadLevel (char *input_fileName)
{
   if (fileExist (input_fileName))
   {
      printf ("ERROR: file \"%s\" is not found\n", input_fileName);
      return _ERR_;
   }
   if (loadLevelIndex (input_fileName))
   {
      printf ("ERROR: bad data in file \"%s\"\n", input_fileName);
      return _ERR_;
   }
   if (loadMap (levels.list[numberPresentLevel]))
      return _ERR_;
   if (loadTexture (levels.list[numberPresentLevel]))
      return _ERR_;
   return _OK_;
}
//----------------------------------------------//
int class_scene::loadModel (char *input_dirName)
{
   modelPlayer= new class_player;
   int iReturn= _OK_;
   if (modelPlayer->load (input_dirName))
      iReturn= _ERR_;
   return iReturn;
}
//----------------------------------------------//
int class_scene::drawBox ()
{
   glBegin(GL_QUADS);
      
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (0.0f, 0.0f, _SC_);
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (_SC_, 0.0f, _SC_);
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (_SC_, _SC_, _SC_);
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (0.0f, _SC_, _SC_);
    
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( 0.0f,  0.0f, -_SC_); glVertex3f (0.0f, 0.0f, 0.0f);
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( 0.0f,  0.0f, -_SC_); glVertex3f (0.0f, _SC_, 0.0f);
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( 0.0f,  0.0f, -_SC_); glVertex3f (_SC_, _SC_, 0.0f);
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( 0.0f,  0.0f, -_SC_); glVertex3f (_SC_, 0.0f, 0.0f);
	
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( 0.0f,  _SC_,  0.0f); glVertex3f (0.0f, _SC_, 0.0f);
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( 0.0f,  _SC_,  0.0f); glVertex3f (0.0f, _SC_, _SC_);
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( 0.0f,  _SC_,  0.0f); glVertex3f (_SC_, _SC_, _SC_);
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( 0.0f,  _SC_,  0.0f); glVertex3f (_SC_, _SC_, 0.0f);
    
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( 0.0f, -_SC_,  0.0f); glVertex3f (0.0f, 0.0f, 0.0f);
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( 0.0f, -_SC_,  0.0f); glVertex3f (_SC_, 0.0f, 0.0f);
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( 0.0f, -_SC_,  0.0f); glVertex3f (_SC_, 0.0f, _SC_);
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( 0.0f, -_SC_,  0.0f); glVertex3f (0.0f, 0.0f, _SC_);
    
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( _SC_,  0.0f,  0.0f); glVertex3f (_SC_, 0.0f, 0.0f);
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( _SC_,  0.0f,  0.0f); glVertex3f (_SC_, _SC_, 0.0f);
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( _SC_,  0.0f,  0.0f); glVertex3f (_SC_, _SC_, _SC_);
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( _SC_,  0.0f,  0.0f); glVertex3f (_SC_, 0.0f, _SC_);
    
      glTexCoord2f (0.0f, 0.0f); glNormal3f (-_SC_,  0.0f,  0.0f); glVertex3f (0.0f, 0.0f, 0.0f);
      glTexCoord2f (1.0f, 0.0f); glNormal3f (-_SC_,  0.0f,  0.0f); glVertex3f (0.0f, 0.0f, _SC_);
      glTexCoord2f (1.0f, 1.0f); glNormal3f (-_SC_,  0.0f,  0.0f); glVertex3f (0.0f, _SC_, _SC_);
      glTexCoord2f (0.0f, 1.0f); glNormal3f (-_SC_,  0.0f,  0.0f); glVertex3f (0.0f, _SC_, 0.0f);

   glEnd();
   return _OK_;
}
//----------------------------------------------//
int class_scene::drawFloor ()
{
   glBegin (GL_POLYGON);
      glTexCoord2f (1.0f, 0.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (0.0f, 0.0f, 0.0f);
      glTexCoord2f (1.0f, 1.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (0.0f, _SC_, 0.0f);
      glTexCoord2f (0.0f, 1.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (_SC_, _SC_, 0.0f);
      glTexCoord2f (0.0f, 0.0f); glNormal3f ( 0.0f,  0.0f,  _SC_); glVertex3f (_SC_, 0.0f, 0.0f);
   glEnd ();
   return _OK_;
}
//----------------------------------------------//
int class_scene::action (unsigned int input_action)
{
   if (modelPlayer->getPlay ())
      return _ERR_;
   if (input_action == _PLAYER_STEP_)
   {
      float angle= modelPlayer->getAngle ();
      unsigned int newI= player.i, newJ= player.j;
      if (angle == 90.0f)
         newI++;
      else
         if (angle == 180.0f)
            newJ++;
         else
            if (angle == 270.0f)
               newI--;
            else
               newJ--;
      if (map.data[newI][newJ] == _SECTOR_WALL_ || map.data[newI][newJ] == _SECTOR_BOX_ || map.data[newI][newJ] == _SECTOR_POINT_BOX_ || !map.data[newI][newJ])
         return _ERR_;
      switch (map.data[player.i][player.j])
      {
         case _SECTOR_PLAYER_:
            map.data[player.i][player.j]= _SECTOR_FLOOR_;
         break;

         case _SECTOR_POINT_PLAYER_:
            map.data[player.i][player.j]= _SECTOR_POINT_;
         break;
      }
      player.i= newI;
      player.j= newJ;
      switch (map.data[player.i][player.j])
      {
         case _SECTOR_FLOOR_:
            map.data[player.i][player.j]= _SECTOR_PLAYER_;
         break;

         case _SECTOR_POINT_:
            map.data[player.i][player.j]= _SECTOR_POINT_PLAYER_;
         break;
      }
   }
   if (input_action == _PLAYER_PUSH_)
   {
      float angle= modelPlayer->getAngle ();
      unsigned int newI= player.i, newJ= player.j, boxI= player.i, boxJ= player.j;
      if (angle == 90.0f)
      {
         newI+= 1;
         boxI+= 2;
      }
      else
         if (angle == 180.0f)
         {
            newJ+= 1;
            boxJ+= 2;
         }
         else
            if (angle == 270.0f)
            {
               newI-= 1;
               boxI-= 2;
            }
            else
            {
               newJ-= 1;
               boxJ-= 2;
            }
      if (map.data[newI][newJ] != _SECTOR_BOX_ && map.data[newI][newJ] != _SECTOR_POINT_BOX_)
         return _ERR_;
      if (map.data[boxI][boxJ] != _SECTOR_FLOOR_ && map.data[boxI][boxJ] != _SECTOR_POINT_)
         return _ERR_;
      switch (map.data[player.i][player.j])
      {
         case _SECTOR_PLAYER_:
            map.data[player.i][player.j]= _SECTOR_FLOOR_;
         break;

         case _SECTOR_POINT_PLAYER_:
            map.data[player.i][player.j]= _SECTOR_POINT_;
         break;
      }
      player.i= newI;
      player.j= newJ;
      box.i= boxI;
      box.j= boxJ;
      switch (map.data[player.i][player.j])
      {
         case _SECTOR_BOX_:
            map.data[player.i][player.j]= _SECTOR_PLAYER_;
         break;

         case _SECTOR_POINT_BOX_:
            map.data[player.i][player.j]= _SECTOR_POINT_PLAYER_;
            pointsFilling--;
         break;
      }
      switch (map.data[box.i][box.j])
      {
         case _SECTOR_FLOOR_:
            map.data[box.i][box.j]= _SECTOR_BOX_;
         break;

         case _SECTOR_POINT_:
            map.data[box.i][box.j]= _SECTOR_POINT_BOX_;
            pointsFilling++;
         break;
      }

   }
   if (modelPlayer->action (input_action))
      return _ERR_;
   return _OK_;
}
//----------------------------------------------//
int class_scene::draw ()
{
   glTranslatef (- ((map.i * _SC_ * 0.5f) * _SCENE_SCALE_), -((map.j * _SC_ * 0.5f) * _SCENE_SCALE_), 0.0f);
   unsigned int i, j;
   for (i= 0; i < map.i; i++)
      for (j= 0; j < map.j; j++)
      {
         if (map.data[i][j] == _SECTOR_ZERRO_)
            continue;
         glPushMatrix ();
         glTranslatef (i * _SC_, j * _SC_, 0.0f);
         switch (map.data[i][j])
         {
            case _SECTOR_WALL_:
               texture[_SECTOR_WALL_].use ();
               drawBox ();
            break;

            case _SECTOR_BOX_:
               if (box.i != i || box.j != j)
               {
                  texture[_SECTOR_BOX_].use ();
                  drawBox ();
               }
               texture[_SECTOR_FLOOR_].use ();
               drawFloor ();
            break;

            case _SECTOR_FLOOR_:
               texture[_SECTOR_FLOOR_].use ();
               drawFloor ();
            break;

            case _SECTOR_POINT_:
               texture[_SECTOR_POINT_].use ();
               drawFloor ();
            break;

            case _SECTOR_POINT_BOX_:
               if (box.i != i || box.j != j)
               {
                  texture[_SECTOR_POINT_BOX_].use ();
                  drawBox ();
               }
               texture[_SECTOR_POINT_].use ();
               drawFloor ();
            break;

            case _SECTOR_POINT_PLAYER_:
               texture[_SECTOR_POINT_].use ();
               drawFloor ();
            break;

            case _SECTOR_PLAYER_:
               texture[_SECTOR_FLOOR_].use ();
               drawFloor ();
            break;
         }
         glPopMatrix ();
      }
   glPushMatrix ();
   glTranslatef ((player.i + 0.5f) * _SC_, (player.j + 0.5f) * _SC_, 0.0f);
   glRotatef (90.0f, 1, 0, 0);
   modelPlayer->draw ();
   glPopMatrix ();
   if (box.i != 0 && box.j != 0)
   {
      glPushMatrix ();
      float x, y, z;
      modelPlayer->getPos (&x, &y, &z);
      float angle= modelPlayer->getAngle ();
      float fBuffer;
      if (angle == 90.0f)
      {
         fBuffer= box.i * _SC_;
         if (fBuffer - y < fBuffer - _SC_)
            glTranslatef (fBuffer - _SC_, box.j * _SC_, 0.0f);
         else
            if (fBuffer - y > fBuffer)
              glTranslatef (fBuffer, box.j * _SC_, 0.0f);
            else
               glTranslatef (fBuffer - y, box.j * _SC_, 0.0f);
      }
      else
         if (angle == 180.0f)
         {
            fBuffer= box.j * _SC_;
            if (fBuffer - y < fBuffer - _SC_)
               glTranslatef (box.i * _SC_, fBuffer - _SC_, 0.0f);
            else
               if (fBuffer - y > fBuffer)
                  glTranslatef (box.i * _SC_, fBuffer, 0.0f);
               else
                  glTranslatef (box.i * _SC_, fBuffer - y, 0.0f);
         }  
         else
            if (angle == 270.0f)
            {
               fBuffer= box.i * _SC_;
               if (fBuffer + y < fBuffer)
                  glTranslatef (fBuffer, box.j * _SC_, 0.0f);
               else
                  if (fBuffer + y > fBuffer + _SC_)
                     glTranslatef (fBuffer + _SC_, box.j * _SC_, 0.0f);
                  else
                     glTranslatef (fBuffer + y, box.j * _SC_, 0.0f);
            }
            else
            {
               fBuffer= box.j * _SC_;
               if (fBuffer + y < fBuffer)
                  glTranslatef (box.i * _SC_ , fBuffer, 0.0f);
               else
                  if (fBuffer + y > fBuffer + _SC_)
                     glTranslatef (box.i * _SC_ , fBuffer + _SC_, 0.0f);
                  else
                     glTranslatef (box.i * _SC_ , fBuffer + y, 0.0f);
            }
      texture[_SECTOR_BOX_].use ();
      drawBox ();
      glPopMatrix ();
   }
   if (!modelPlayer->getPlay ())
   {
      box.i= 0;
      box.j= 0;
   }
   return _OK_;
}
//----------------------------------------------//
int class_scene::level (int input_level)
{
   switch (input_level)
   {
      case _LEVEL_FIRST_:
         numberPresentLevel= 0;
      break;

      case _LEVEL_NEXT_:
         numberPresentLevel= numberPresentLevel == levels.size - 1 ? 0 : numberPresentLevel + 1;
      break;

      case _LEVEL_PREV_:
         numberPresentLevel= numberPresentLevel == 0 ? levels.size - 1 : numberPresentLevel - 1;
      break;
   }
   delLevel ();
   loadMap (levels.list[numberPresentLevel]);
   loadTexture (levels.list[numberPresentLevel]);
   return numberPresentLevel;
}
//----------------------------------------------//
bool class_scene::levelWin ()
{
   if (!modelPlayer->getPlay ())
      if (points == pointsFilling)
         return true;
   return false;
}
//----------------------------------------------//
