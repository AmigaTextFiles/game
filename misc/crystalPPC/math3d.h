#ifndef MATH3D_H
#define MATH3D_H

#define POLY_IN 1
#define POLY_ON 0
#define POLY_OUT -1

#ifndef DEF_H
#include "def.h"
#endif

class Vector2;
class Vector3;
class Box;

class Tables
{
private:

public:
  Tables ();
};

extern Tables tables;

class Segment
{
public:
  static int intersect_segments (
    Vector2& a, Vector2& b, // First segment
    Vector2& c, Vector2& d, // Second segment
    Vector2& isect,         // Intersection vertex
    float* rp);		    // 'r' index value
  static int intersect_segment_line (
    Vector2& a, Vector2& b, // First segment
    Vector2& c, Vector2& d, // Second line
    Vector2& isect,         // Intersection vertex
    float* rp);		    // 'r' index value

  static float intersect_z_plane_3d (
				     float z,			// Z plane coordinate
				     Vector3& a, Vector3& b,	// Segment
				     Vector3& i);		// Intersection vertex

};

class Vector3
{
public:
  float x, y, z;

  Vector3 () { }
  Vector3 (float x, float y, float z) { Vector3::x = x; Vector3::y = y; Vector3::z = z; }
  void dump (char* name);

  Vector3& operator+= (Vector3& v);
  Vector3& operator-= (Vector3& v);

  void save (FILE* fp, int indent);
  void load (char** buf);

  static void between (Vector3& v1, Vector3& v2, Vector3& v, float pct, float wid);
};

class Vector2
{
public:
  float x, y;

  Vector2 () { }
  Vector2 (float x, float y) { Vector2::x = x; Vector2::y = y; }
  void dump (char* name);

  // Return -1 if vector is left of 'v1-v2'. 1 is vector is right of 'v1-v2'
  // or 0 is vector is on 'v1-v2'.
  int which_side_2d (Vector2& v1, Vector2& v2);

  // Return POLY_IN, POLY_OUT, or POLY_ON for this vector with respect
  // to the given polygon. The polygon is given as an array of 2D vectors
  // with a bounding box.
  int in_poly_2d (Vector2* P, int n, Box* bounding_box);

  // Returns twice the signed area of the triangle determined by a,b,c,
  // positive if a,b,c are oriented ccw, and negative if cw.
  static float Area2 (float ax, float ay, float bx, float by, float cx, float cy);

  // Returns true iff c is strictly to the right of the directed
  // line through a to b.
  static int Right (float ax, float ay, float bx, float by, float cx, float cy);

  // Returns true iff c is strictly to the left of the directed
  // line through a to b.
  static int Left (float ax, float ay, float bx, float by, float cx, float cy);
};

class Box
{
public:
  float minx, miny, maxx, maxy;

  int in (float x, float y);
  int overlap (Box* box);
  void start_bounding_box ();
  void add_bounding_vertex (float x, float y);
  void add_bounding_vertex (Vector2& v) { add_bounding_vertex (v.x, v.y); }

  void dump ();
};

class Matrix3
{
public:
  float m11, m12, m13;
  float m21, m22, m23;
  float m31, m32, m33;

public:
  Matrix3 ();
  Matrix3 (float m11, float m12, float m13,
  	   float m21, float m22, float m23,
  	   float m31, float m32, float m33);
  ~Matrix3 ();

  static void init ();

  Matrix3& operator+= (Matrix3& m);
  Matrix3& operator-= (Matrix3& m);
  Matrix3& operator*= (Matrix3& m);
  Matrix3& operator*= (float s);
  void transpose ();
  void inverse ();
  float determinant ();
  void transform (Vector3& f, Vector3& t);
  void transform (float x, float y, float z, Vector3& t);
  void identity ();

  void dump (char* name);
  void save (FILE* fp, int indent);
  void load (char** buf);
};

#endif /*MATH3D_H*/

