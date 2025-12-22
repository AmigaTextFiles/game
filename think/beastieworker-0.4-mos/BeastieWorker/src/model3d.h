#include "main.h"
#include "texture.h"
#include "matrixmath.h"

#define _FRAME_DELAY_ 27

#ifndef __model3d_h_
#define __model3d_h_

class class_model3d
{
   private:
   
   struct struct_coordinates3d
   {
      GLfloat x, y, z;
   };
   struct struct_coordinates2d
   {
      GLfloat x, y;
   };
   struct struct_vertex
   {
      struct_coordinates3d vertex, normal;
      struct_coordinates2d texture;
      unsigned int joint;
   };
   typedef struct_vertex type_vertexs[3]; 
   struct struct_model
   {
      type_vertexs *faces;
      unsigned int size;
   };
   struct_model m3d_model;
   type_vertexs *m3d_modelFolding;
   bool bFolding;

   struct struct_joint
   {
      struct_coordinates3d translate, rotate; 
   };
   struct struct_skeleton
   {
      struct_joint *joint;
   };
   struct struct_frame
   {
      struct_skeleton *skeleton;
      unsigned int sizeJoint;
      unsigned int sizeFrame;
   };
   struct_frame m3d_frame;

   struct struct_animation
   {
      int depend;
      type_matrix absolute, relative;
      type_vertex point;
   };
   struct_animation *m3d_animation;
   unsigned int presentFrame;

   class_texture *m3d_texture;

   unsigned int timeBuffer;

   int fileExist (char *);

   public:
   
   bool play;
   class_model3d ();
   ~class_model3d ();
   int load (char *);
   int getBasicJoint (float *, float *, float *);
   int resetFrame ();
   int draw ();
};

#endif
