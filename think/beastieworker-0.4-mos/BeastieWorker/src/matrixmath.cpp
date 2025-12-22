#include "matrixmath.h"
#include <math.h>


type_matrix identity=
{
   {1, 0, 0, 0},
   {0, 1, 0, 0},
   {0, 0, 1, 0},
   {0, 0, 0, 1}
};

//----------------------------------------------//
int MatrixCopy (type_matrix output_matrix, type_matrix input_matrix)
{
   int i, j;
   for (i= 0; i < _MATRIX_SIZE_; i++)
      for (j= 0; j < _MATRIX_SIZE_; j++)
         output_matrix[i][j]= input_matrix[i][j];
   return 0;
}
//----------------------------------------------//
int VertexCopy (type_vertex output_vertex, type_vertex input_vertex)
{
   output_vertex[0]= input_vertex[0];
   output_vertex[1]= input_vertex[1];
   output_vertex[2]= input_vertex[2];
   return 0;
}
//----------------------------------------------//
int VertexFilling (type_vertex output_vertex, float input_x, float input_y, float input_z)
{
   output_vertex[0]= input_x;
   output_vertex[1]= input_y;
   output_vertex[2]= input_z;
   return 0;
}
//----------------------------------------------//
int VertexAdd (type_vertex output_vertex, type_vertex input_vertex1, type_vertex input_vertex2)
{
   output_vertex[0]= input_vertex1[0] + input_vertex2 [0];
   output_vertex[1]= input_vertex1[1] + input_vertex2 [1];
   output_vertex[2]= input_vertex1[2] + input_vertex2 [2];
   return 0;
}
//----------------------------------------------//
int VertexMul (type_vertex output_vertex, type_vertex input_vertex1, type_vertex input_vertex2)
{
   output_vertex[0]= input_vertex1[0] * input_vertex2 [0];
   output_vertex[1]= input_vertex1[1] * input_vertex2 [1];
   output_vertex[2]= input_vertex1[2] * input_vertex2 [2];
   return 0;
}
//----------------------------------------------//
int VertexSub (type_vertex output_vertex, type_vertex input_vertex_subtrahend, type_vertex input_vertex_subtractor)
{
   output_vertex[0]= input_vertex_subtrahend[0] - input_vertex_subtractor [0];
   output_vertex[1]= input_vertex_subtrahend[1] - input_vertex_subtractor [1];
   output_vertex[2]= input_vertex_subtrahend[2] - input_vertex_subtractor [2];
   return 0;
}
//----------------------------------------------//
int MatrixRotX (type_matrix output_matrix, float input_rotation_x)
{
   MatrixCopy (output_matrix, identity);
   output_matrix[1][1]= (float)  cos (input_rotation_x);
   output_matrix[2][1]= (float)  sin (input_rotation_x);
   output_matrix[1][2]= (float) -sin (input_rotation_x);
   output_matrix[2][2]= (float)  cos (input_rotation_x);
   return 0;
}
//----------------------------------------------//
int MatrixRotY (type_matrix output_matrix, float input_rotation_y)
{
   MatrixCopy (output_matrix, identity);
   output_matrix[0][0]= (float)  cos (input_rotation_y);
   output_matrix[0][2]= (float)  sin (input_rotation_y);
   output_matrix[2][0]= (float) -sin (input_rotation_y);
   output_matrix[2][2]= (float)  cos (input_rotation_y);
   return 0;
}
//----------------------------------------------//
int MatrixRotZ (type_matrix output_matrix, float input_rotation_z)
{
   MatrixCopy (output_matrix, identity);
   output_matrix[0][0]= (float)  cos (input_rotation_z);
   output_matrix[1][0]= (float)  sin (input_rotation_z);
   output_matrix[0][1]= (float) -sin (input_rotation_z);
   output_matrix[1][1]= (float)  cos (input_rotation_z);
   return 0;
}
//----------------------------------------------//
int MatrixConcat (type_matrix output_matrix, type_matrix input_matrix)
{
   int i, j;
   type_matrix tmp_matrix;
   for (i= 0; i < _MATRIX_SIZE_; i++)
      for (j= 0; j < _MATRIX_SIZE_; j++)
         tmp_matrix[i][j]= 
            input_matrix[0][j] * output_matrix[i][0] +
            input_matrix[1][j] * output_matrix[i][1] +
            input_matrix[2][j] * output_matrix[i][2] +
            input_matrix[3][j] * output_matrix[i][3];
   MatrixCopy (output_matrix, tmp_matrix);
   return 0;      
}
//----------------------------------------------//
int MatrixApply (type_vertex output_vertex, type_matrix input_matrix)
{
   type_vertex result_vertex;
   result_vertex[0]= output_vertex[0] * input_matrix[0][0] + output_vertex[1] * input_matrix[1][0] + output_vertex[2] * input_matrix[2][0] + input_matrix[3][0];
   result_vertex[1]= output_vertex[0] * input_matrix[0][1] + output_vertex[1] * input_matrix[1][1] + output_vertex[2] * input_matrix[2][1] + input_matrix[3][1];
   result_vertex[2]= output_vertex[0] * input_matrix[0][2] + output_vertex[1] * input_matrix[1][2] + output_vertex[2] * input_matrix[2][2] + input_matrix[3][2];
   VertexCopy (output_vertex, result_vertex);
   return 0;
}
//----------------------------------------------//
int MatrixApply (float *output_x, float *output_y, float *output_z, type_matrix input_matrix)
{
   float x, y, z;
   x= *output_x * input_matrix[0][0] + *output_y * input_matrix[1][0] + *output_z * input_matrix[2][0] + input_matrix[3][0];
   y= *output_x * input_matrix[0][1] + *output_y * input_matrix[1][1] + *output_z * input_matrix[2][1] + input_matrix[3][1];
   z= *output_x * input_matrix[0][2] + *output_y * input_matrix[1][2] + *output_z * input_matrix[2][2] + input_matrix[3][2];

   *output_x= x;
   *output_y= y;
   *output_z= z;
   return 0;
}
//----------------------------------------------//
int MatrixApplyNormal (float *output_x, float *output_y, float *output_z, type_matrix input_matrix)
{
   float x, y, z;
   x= *output_x * input_matrix[0][0] + *output_y * input_matrix[1][0] + *output_z * input_matrix[2][0];
   y= *output_x * input_matrix[0][1] + *output_y * input_matrix[1][1] + *output_z * input_matrix[2][1];
   z= *output_x * input_matrix[0][2] + *output_y * input_matrix[1][2] + *output_z * input_matrix[2][2];

   *output_x= x;
   *output_y= y;
   *output_z= z;
   return 0;
}
//----------------------------------------------//
int MatrixInvertApply (type_vertex output_vertex, type_matrix input_matrix)
{
   type_vertex result_vertex;
   output_vertex[0]= output_vertex[0] - input_matrix [3][0];
   output_vertex[1]= output_vertex[1] - input_matrix [3][1];
   output_vertex[2]= output_vertex[2] - input_matrix [3][2];

   result_vertex[0]= output_vertex[0] * input_matrix[0][0] + output_vertex[1] * input_matrix[0][1] + output_vertex[2] * input_matrix[0][2];
   result_vertex[1]= output_vertex[0] * input_matrix[1][0] + output_vertex[1] * input_matrix[1][1] + output_vertex[2] * input_matrix[1][2];
   result_vertex[2]= output_vertex[0] * input_matrix[2][0] + output_vertex[1] * input_matrix[2][1] + output_vertex[2] * input_matrix[2][2];
   VertexCopy (output_vertex, result_vertex);
   return 0;
}
//----------------------------------------------//
int MatrixInvertApply (float *output_x, float *output_y, float *output_z, type_matrix input_matrix)
{
   *output_x= *output_x - input_matrix [3][0];
   *output_y= *output_y - input_matrix [3][1];
   *output_z= *output_z - input_matrix [3][2];

   float x, y, z;
   x= *output_x * input_matrix[0][0] + *output_y * input_matrix[0][1] + *output_z * input_matrix[0][2];
   y= *output_x * input_matrix[1][0] + *output_y * input_matrix[1][1] + *output_z * input_matrix[1][2];
   z= *output_x * input_matrix[2][0] + *output_y * input_matrix[2][1] + *output_z * input_matrix[2][2];

   *output_x= x;
   *output_y= y;
   *output_z= z;

   return 0;
}
//----------------------------------------------//
int MatrixInvertApplyNormal (float *output_x, float *output_y, float *output_z, type_matrix input_matrix)
{
   float x, y, z;
   x= *output_x * input_matrix[0][0] + *output_y * input_matrix[0][1] + *output_z * input_matrix[0][2];
   y= *output_x * input_matrix[1][0] + *output_y * input_matrix[1][1] + *output_z * input_matrix[1][2];
   z= *output_x * input_matrix[2][0] + *output_y * input_matrix[2][1] + *output_z * input_matrix[2][2];

   *output_x= x;
   *output_y= y;
   *output_z= z;

   return 0;
}
//----------------------------------------------//
