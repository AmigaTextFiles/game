#include "model3d.h"
#include <ctype.h>
#include <string.h>

#define _MAX_SIZE_STR_ 256

//----------------------------------------------//
class_model3d::class_model3d ()
{
   m3d_model.faces= NULL;
   m3d_frame.skeleton= NULL;
   m3d_animation= NULL;
   m3d_modelFolding= NULL;
   m3d_texture= NULL;
   m3d_model.size= 0;
   m3d_frame.sizeJoint= 0;
   m3d_frame.sizeFrame= 0;
   presentFrame= 0;
   timeBuffer= 0;
   play= false;
   bFolding= false;
}
//----------------------------------------------//
class_model3d::~class_model3d ()
{
   if (!m3d_model.size)
      delete m3d_model.faces;
      
   if (!m3d_frame.sizeFrame)
   {
      unsigned int i;
      for (i= 0; i < m3d_frame.sizeFrame; i++)
         delete m3d_frame.skeleton[i].joint;
      delete m3d_frame.skeleton;
   }

   if (m3d_modelFolding != NULL)
      delete m3d_modelFolding;

   if (!m3d_frame.sizeJoint)
      delete m3d_animation;

   if (!m3d_texture)
      m3d_texture->del ();
}
//----------------------------------------------//
int class_model3d::fileExist (char *input_fileName)
{
 	FILE *file= fopen (input_fileName, "rt");
	if (file == NULL)
		return _ERR_;
	fclose (file);
	return _OK_;
}
//----------------------------------------------//
int class_model3d::load (char *input_fileName)
{
   const char const_charZr= '\00';
   const char conat_charNl= '\12';
   //const char const_charSp= '\40';
   if (fileExist (input_fileName))
   {
      printf ("ERROR: file \"%s\" is not found\n", input_fileName);
      return _ERR_;
   }
   FILE *file= fopen (input_fileName, "r");
   char strBuffer [_MAX_SIZE_STR_];
   bool bModel= false, bJoint= false, bFrame= false;
   while (!feof (file))
   {
      fgets (strBuffer, _MAX_SIZE_STR_, file);
      if ((strBuffer[0] == 'M' || strBuffer[0] == 'm') && !bFrame)
      {
         bModel= !bModel;
         continue;
      }
      if ((strBuffer[0] == 'J' || strBuffer[0] == 'j') && !bModel)
      {
         bFrame= !bFrame;
         bJoint= true;
         continue;
      }
      
      if (bModel && (strBuffer[0] == conat_charNl || strBuffer[1] == conat_charNl))
         m3d_model.size++;
      if (bFrame && (strBuffer[0] == conat_charNl || strBuffer[1] == conat_charNl))
      {
         m3d_frame.sizeFrame++;
         bJoint= false;
      }
      if (bFrame && bJoint)
         m3d_frame.sizeJoint++;
   }
   if (!m3d_model.size || !m3d_frame.sizeJoint || !m3d_frame.sizeFrame)
   {
      printf ("size= %i  joints= %i  frames= %i\n", m3d_model.size, m3d_frame.sizeJoint, m3d_frame.sizeFrame);
      printf ("ERROR: bad data in file \"%s\"\n", input_fileName);
      return _ERR_;
   }
   m3d_model.faces= new type_vertexs [m3d_model.size];
   m3d_frame.skeleton= new struct_skeleton [m3d_frame.sizeFrame];
   unsigned int i;
   for (i= 0; i < m3d_frame.sizeFrame; i++)
      m3d_frame.skeleton[i].joint= new struct_joint [m3d_frame.sizeJoint];
   m3d_animation= new struct_animation [m3d_frame.sizeJoint];
   fclose (file);
   file= fopen (input_fileName, "r");
   char textureFileName[_MAX_SIZE_STR_]= {};
   bFrame= false;
   bModel= false;
   bJoint= false;
   unsigned int iFaces= 0, iFrames= 0, iJoints= 0;
   while (!feof (file))
   {
      fgets (strBuffer, _MAX_SIZE_STR_, file);
      if (strBuffer[0] == 'T' || strBuffer[0] == 't')
      {  
         unsigned int i= 0;
         while (!isgraph (strBuffer[++i]));
         strcpy (textureFileName, &strBuffer[i]);
         textureFileName[strlen (textureFileName)-1]= const_charZr;
      }
      if ((strBuffer[0] == 'M' || strBuffer[0] == 'm') && !bFrame && !bJoint)
      {
         bModel= !bModel;
         continue;
      }
      if ((strBuffer[0] == 'S' || strBuffer[0] == 's') && !bFrame && !bModel)
      {
         bJoint= !bJoint;
         continue;
      }
      if ((strBuffer[0] == 'J' || strBuffer[0] == 'j') && !bModel && !bJoint)
      {
         bFrame= !bFrame;
         continue;
      }
      if (bModel && (strBuffer[0] != conat_charNl))
      {
         unsigned int i;
         for (i = 0; i < 3; i++)
         {
            sscanf
            (
               strBuffer, "%i%f%f%f%f%f%f%f%f",
               &m3d_model.faces[iFaces][i].joint,
               &m3d_model.faces[iFaces][i].vertex.x,  &m3d_model.faces[iFaces][i].vertex.y, &m3d_model.faces[iFaces][i].vertex.z,
               &m3d_model.faces[iFaces][i].normal.x,  &m3d_model.faces[iFaces][i].normal.y, &m3d_model.faces[iFaces][i].normal.z,
               &m3d_model.faces[iFaces][i].texture.x, &m3d_model.faces[iFaces][i].texture.y
            );
            fgets (strBuffer, _MAX_SIZE_STR_, file);
         }
         iFaces++;
      }
      if (bJoint && strBuffer[0] != conat_charNl)
      {
         int iBuffer;
         sscanf (strBuffer, "%i%i", &iBuffer, &m3d_animation[iJoints++].depend);
      }
      if (bFrame && strBuffer[0] != conat_charNl)
      {
         unsigned int i, iBuffer;
         for (i = 0; i < m3d_frame.sizeJoint; i++)
         {
            sscanf 
            (
               strBuffer, "%i%f%f%f%f%f%f",
               &iBuffer,
               &m3d_frame.skeleton[iFrames].joint[i].translate.x, &m3d_frame.skeleton[iFrames].joint[i].translate.y, &m3d_frame.skeleton[iFrames].joint[i].translate.z,
               &m3d_frame.skeleton[iFrames].joint[i].rotate.x,    &m3d_frame.skeleton[iFrames].joint[i].rotate.y,    &m3d_frame.skeleton[iFrames].joint[i].rotate.z
            );
            fgets (strBuffer, _MAX_SIZE_STR_, file);
         }
         iFrames++;
      }
   }
   m3d_texture= new class_texture;
   if (m3d_texture->loadBMP (textureFileName))
   {
      printf ("ERROR: file \"%s\" with texture is not found\n", textureFileName);
      delete m3d_texture;
      return _ERR_;
   }
   return _OK_;
}
//----------------------------------------------//
int class_model3d::getBasicJoint (float *output_x, float *output_y, float *output_z)
{
   *output_x= m3d_frame.skeleton[presentFrame].joint[0].translate.x;
   *output_y= m3d_frame.skeleton[presentFrame].joint[0].translate.y;
   *output_z= m3d_frame.skeleton[presentFrame].joint[0].translate.z;
   return _OK_;
}
//----------------------------------------------//
int class_model3d::resetFrame ()
{
   play= false;
   presentFrame= 0;
   return _OK_;
}
//----------------------------------------------//
int class_model3d::draw ()
{
   if (!m3d_model.faces)
      return _ERR_;
   m3d_texture->use ();
   unsigned int i, j;
   for (i= 0; i < m3d_frame.sizeJoint; i++)
   {
      m3d_animation[i].point[0]= 0.0f;
      m3d_animation[i].point[1]= 0.0f;
      m3d_animation[i].point[2]= 0.0f;
      MatrixRotX (m3d_animation[i].relative, -m3d_frame.skeleton[presentFrame].joint[i].rotate.x);
      type_matrix matrixRotY, matrixRotZ;
      MatrixRotY (matrixRotY, -m3d_frame.skeleton[presentFrame].joint[i].rotate.y);
      MatrixConcat (m3d_animation[i].relative, matrixRotY);
      MatrixRotZ (matrixRotZ, -m3d_frame.skeleton[presentFrame].joint[i].rotate.z);
      MatrixConcat (m3d_animation[i].relative, matrixRotZ);
      m3d_animation[i].relative[3][0]= m3d_frame.skeleton[presentFrame].joint[i].translate.x;
      m3d_animation[i].relative[3][1]= m3d_frame.skeleton[presentFrame].joint[i].translate.y;
      m3d_animation[i].relative[3][2]= m3d_frame.skeleton[presentFrame].joint[i].translate.z;
      if (m3d_animation[i].depend != -1)
         MatrixConcat (m3d_animation[i].relative, m3d_animation[m3d_animation[i].depend].absolute);
      MatrixCopy (m3d_animation[i].absolute, m3d_animation[i].relative);
   }

   if (!bFolding)
   {
      m3d_modelFolding= new type_vertexs [m3d_model.size];
      for (i= 0; i < m3d_model.size; i++)
         for (j= 0; j < 3; j++)
         {
            m3d_modelFolding[i][j]= m3d_model.faces[i][j];
            MatrixInvertApply (&m3d_modelFolding[i][j].vertex.x, &m3d_modelFolding[i][j].vertex.y, &m3d_modelFolding[i][j].vertex.z, m3d_animation[m3d_modelFolding[i][j].joint].absolute);
            MatrixInvertApplyNormal (&m3d_modelFolding[i][j].normal.x, &m3d_modelFolding[i][j].normal.y, &m3d_modelFolding[i][j].normal.z, m3d_animation[m3d_modelFolding[i][j].joint].absolute);
         }
      bFolding= true;
   }

   for (i= 0; i < m3d_model.size; i++)
      for (j= 0; j < 3; j++)
      {
         m3d_model.faces[i][j]= m3d_modelFolding[i][j];
         MatrixApply (&m3d_model.faces[i][j].vertex.x, &m3d_model.faces[i][j].vertex.y, &m3d_model.faces[i][j].vertex.z, m3d_animation[m3d_model.faces[i][j].joint].absolute);
         MatrixApplyNormal (&m3d_model.faces[i][j].normal.x, &m3d_model.faces[i][j].normal.y, &m3d_model.faces[i][j].normal.z, m3d_animation[m3d_model.faces[i][j].joint].absolute);
      }      
   for (i= 0; i < m3d_model.size; i++)
   {
      glBegin (GL_TRIANGLES);
            
         glTexCoord2f (m3d_model.faces[i][0].texture.x, m3d_model.faces[i][0].texture.y);
         glNormal3f (m3d_model.faces[i][0].normal.x, m3d_model.faces[i][0].normal.y, m3d_model.faces[i][0].normal.z);
         glVertex3f (m3d_model.faces[i][0].vertex.x, m3d_model.faces[i][0].vertex.y, m3d_model.faces[i][0].vertex.z);

         glTexCoord2f (m3d_model.faces[i][1].texture.x, m3d_model.faces[i][1].texture.y);
         glNormal3f (m3d_model.faces[i][1].normal.x, m3d_model.faces[i][1].normal.y, m3d_model.faces[i][1].normal.z);
         glVertex3f (m3d_model.faces[i][1].vertex.x, m3d_model.faces[i][1].vertex.y, m3d_model.faces[i][1].vertex.z);

         glTexCoord2f (m3d_model.faces[i][2].texture.x, m3d_model.faces[i][2].texture.y);
         glNormal3f (m3d_model.faces[i][2].normal.x, m3d_model.faces[i][2].normal.y, m3d_model.faces[i][2].normal.z);
         glVertex3f (m3d_model.faces[i][2].vertex.x, m3d_model.faces[i][2].vertex.y, m3d_model.faces[i][2].vertex.z);

      glEnd ();
   }

   if (play)
   {
      unsigned int timeNow= SDL_GetTicks();
      if (timeBuffer <= timeNow)
      {
         timeBuffer= timeNow + _FRAME_DELAY_;
         presentFrame++;
      }
      if (presentFrame == m3d_frame.sizeFrame)
      {
         presentFrame= 0;
         play= false;
      }
   }
   return _OK_;
}
//----------------------------------------------//
