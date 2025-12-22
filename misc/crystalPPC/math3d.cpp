#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

//---------------------------------------------------------------------------
/*
Tables tables;

Tables::Tables ()
{
  printf ("Creating mathematical tables ... "); fflush (stdout);
  printf ("DONE\n");
}
*/

//---------------------------------------------------------------------------

int Box::in (float x, float y)
{
  if (x < minx || x > maxx) return FALSE;
  if (y < miny || y > maxy) return FALSE;
  return TRUE;
}

int Box::overlap (Box* box)
{
  if (maxx < box->minx || minx > box->maxx) return FALSE;
  if (maxy < box->miny || miny > box->maxy) return FALSE;
  return TRUE;
}

void Box::start_bounding_box ()
{
  minx = 10000.;
  miny = 10000.;
  maxx = -10000.;
  maxy = -10000.;
}

void Box::add_bounding_vertex (float x, float y)
{
  if (x < minx) minx = x;
  if (x > maxx) maxx = x;
  if (y < miny) miny = y;
  if (y > maxy) maxy = y;
}

void Box::dump ()
{
  MSG (("(%2.2f,%2.2f)-(%2.2f,%2.2f)", minx, miny, maxx, maxy));
}

//---------------------------------------------------------------------------

Matrix3::Matrix3 ()
{
}

Matrix3::Matrix3 (float m11, float m12, float m13,
  	    	  float m21, float m22, float m23,
  	   	  float m31, float m32, float m33)
{
  Matrix3::m11 = m11;
  Matrix3::m12 = m12;
  Matrix3::m13 = m13;
  Matrix3::m21 = m21;
  Matrix3::m22 = m22;
  Matrix3::m23 = m23;
  Matrix3::m31 = m31;
  Matrix3::m32 = m32;
  Matrix3::m33 = m33;
}

Matrix3::~Matrix3 ()
{
}

Matrix3& Matrix3::operator+= (Matrix3& m)
{
  m11 += m.m11; m12 += m.m12; m13 += m.m13;
  m21 += m.m21; m22 += m.m22; m23 += m.m23;
  m31 += m.m31; m32 += m.m32; m33 += m.m33;
  return *this;
}

Matrix3& Matrix3::operator-= (Matrix3& m)
{
  m11 -= m.m11; m12 -= m.m12; m13 -= m.m13;
  m21 -= m.m21; m22 -= m.m22; m23 -= m.m23;
  m31 -= m.m31; m32 -= m.m32; m33 -= m.m33;
  return *this;
}

Matrix3& Matrix3::operator*= (Matrix3& m)
{
  Matrix3 r;
  r.m11 = m11*m.m11 + m12*m.m21 + m13*m.m31;
  r.m12 = m11*m.m12 + m12*m.m22 + m13*m.m32;
  r.m13 = m11*m.m13 + m12*m.m23 + m13*m.m33;
  r.m21 = m21*m.m11 + m22*m.m21 + m23*m.m31;
  r.m22 = m21*m.m12 + m22*m.m22 + m23*m.m32;
  r.m23 = m21*m.m13 + m22*m.m23 + m23*m.m33;
  r.m31 = m31*m.m11 + m32*m.m21 + m33*m.m31;
  r.m32 = m31*m.m12 + m32*m.m22 + m33*m.m32;
  r.m33 = m31*m.m13 + m32*m.m23 + m33*m.m33;
  *this = r;
  return *this;
}

Matrix3& Matrix3::operator*= (float s)
{
  m11 *= s; m12 *= s; m13 *= s;
  m21 *= s; m22 *= s; m23 *= s;
  m31 *= s; m32 *= s; m33 *= s;
  return *this;
}

void Matrix3::identity ()
{
  m12 = m13 = 0;
  m21 = m23 = 0;
  m31 = m32 = 0;
  m11 = m22 = m33 = 1;
}

void Matrix3::transpose ()
{
  float swap;
  swap = m12; m12 = m21; m21 = swap;
  swap = m13; m13 = m31; m31 = swap;
  swap = m23; m23 = m32; m32 = swap;
}

void Matrix3::inverse ()
{
  float s = 1./determinant ();
  Matrix3 C;
  C.m11 =  (m22*m33 - m23*m32);
  C.m12 = -(m21*m33 - m23*m31);
  C.m13 =  (m21*m32 - m22*m31);
  C.m21 = -(m12*m33 - m13*m32);
  C.m22 =  (m11*m33 - m13*m31);
  C.m23 = -(m11*m32 - m12*m31);
  C.m31 =  (m12*m23 - m13*m22);
  C.m32 = -(m11*m23 - m13*m21);
  C.m33 =  (m11*m22 - m12*m21);
  C.transpose ();
  *this = C;
  (*this) *= s;
}

float Matrix3::determinant ()
{
  return
    m11 * (m22*m33 - m23*m32)
   -m12 * (m21*m33 - m23*m31)
   +m13 * (m21*m32 - m22*m31);
}

void Matrix3::transform (float x, float y, float z, Vector3& t)
{
  t.x = m11*x+m12*y+m13*z;
  t.y = m21*x+m22*y+m23*z;
  t.z = m31*x+m32*y+m33*z;
}

void Matrix3::transform (Vector3& f, Vector3& t)
{
  t.x = m11*f.x+m12*f.y+m13*f.z;
  t.y = m21*f.x+m22*f.y+m23*f.z;
  t.z = m31*f.x+m32*f.y+m33*f.z;
}

void Matrix3::dump (char* name)
{
  MSG (("Matrix '%s':\n", name));
  MSG (("/\n"));
  MSG (("| %3.2f %3.2f %3.2f\n", m11, m12, m13));
  MSG (("| %3.2f %3.2f %3.2f\n", m21, m22, m23));
  MSG (("| %3.2f %3.2f %3.2f\n", m31, m32, m33));
  MSG (("\\\n"));
}

void Matrix3::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sMATRIX (", sp);
  fprintf (fp, "%f,%f,%f,", m11, m12, m13);
  fprintf (fp, "%f,%f,%f,", m21, m22, m23);
  fprintf (fp, "%f,%f,%f", m31, m32, m33);
  fprintf (fp, ")\n");
}

void Matrix3::load (char** buf)
{
  char* t;
  skip_token (buf, "MATRIX");

  t = get_token (buf);
  if (!strcmp (t, "IDENTITY"))
  {
    identity ();
    return;
  }
  else if (*t != '(')
  {
    float rc;
    sscanf (t, "%f", &rc);
    identity ();
    *this *= rc;
    return;
  }

  m11 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m12 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m13 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m21 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m22 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m23 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m31 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m32 = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for MATRIX statement!\n");
  m33 = get_token_float (buf);
  skip_token (buf, ")", "Expected '%s' instead of '%s' to conclude MATRIX statement!\n");

}

void Matrix3::init ()
{
}

//---------------------------------------------------------------------------

int Vector2::which_side_2d (Vector2& v1, Vector2& v2)
{
  float s = (v1.y - y)*(v2.x - v1.x) - (v1.x - x)*(v2.y - v1.y);
  if (s < 0) return -1;
  else if (s > 0) return 1;
  else return 0;
}

// This algorithm assumes that the polygon is convex and that
// the vertices of the polygon are oriented in clockwise ordering.
// If this was not the case then the polygon should not be drawn (culled)
// and this routine would not be called for it.
int Vector2::in_poly_2d (Vector2* P, int n, Box* bounding_box)
{
  if (!bounding_box->in (x, y)) return POLY_OUT;
  int i, i1;
  int side;
  i1 = n-1;
  for (i = 0 ; i < n ; i++)
  {
    // If this vertex is left of the polygon edge we are outside the polygon.
    side = which_side_2d (P[i1], P[i]);
    if (side < 0) return POLY_OUT;
    else if (side == 0) return POLY_ON;
    i1 = i;
  }
  return POLY_IN;
}

void Vector3::between (Vector3& v1, Vector3& v2, Vector3& v, float pct, float wid)
{
  if (pct != -1)
    pct /= 100.;
  else
  {
    float dist = sqrt ((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y)+(v1.z-v2.z)*(v1.z-v2.z));
    pct = wid/dist;
  }
  v.x = pct*(v2.x-v1.x)+v1.x;
  v.y = pct*(v2.y-v1.y)+v1.y;
  v.z = pct*(v2.z-v1.z)+v1.z;
}

void Vector3::dump (char* name)
{
  MSG (("Vector '%s': (%2.2f,%2.2f,%2.2f)\n", name, x, y, z));
}

void Vector3::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%s(%f,%f,%f)\n", sp, x, y, z);
}

void Vector3::load (char** buf)
{
  skip_token (buf, "(", "Expected '%s' instead of '%s' to begin vector!\n");
  x = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for vector!\n");
  y = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for vector!\n");
  z = get_token_float (buf);
  skip_token (buf, ")", "Expected '%s' instead of '%s' to conclude a vector!\n");
}

void Vector2::dump (char* name)
{
  MSG (("Vector '%s': (%2.2f,%2.2f)\n", name, x, y));
}

Vector3& Vector3::operator+= (Vector3& v)
{
  x += v.x;
  y += v.y;
  z += v.z;
  return *this;
}

Vector3& Vector3::operator-= (Vector3& v)
{
  x -= v.x;
  y -= v.y;
  z -= v.z;
  return *this;
}

float Vector2::Area2 (float ax, float ay, float bx, float by, float cx, float cy)
{
  float rc =
    ax * by - ay * bx +
    ay * cx - ax * cy +
    bx * cy - cx * by;
  if (ABS (rc) < SMALL_EPSILON) rc = 0;
  return rc;
}

int Vector2::Right (float ax, float ay, float bx, float by, float cx, float cy)
{
  return Area2 (ax, ay, bx, by, cx, cy) < 0;
}

int Vector2::Left (float ax, float ay, float bx, float by, float cx, float cy)
{
  return Area2 (ax, ay, bx, by, cx, cy) > 0;
}

//---------------------------------------------------------------------------

/*
 * General function to test if two lines intersect.
 * This function should not be used in speed-sensitive
 * computations but it can be used to pre-compute stuff.
 * The first line has its origin at (0,0).
 * This function returns FALSE if the lines don't intersect
 * (given that the second line is only a line-segment really
 * and the first line is a vector starting at (0,0)).
 * Note, that even in the case that lines don't intersect
 * the intersection point is still correctly computed unless
 * the slopes of the two lines is too close together.
 * In the last case the intersection point is set to (0,0).
 */
int intersect (
  float x1, float y1,   /* End-point of first line (vector really) */
  float X1, float Y1,   /* Coordinates of second line (segment really) */
  float X2, float Y2,
  Vector2* isect)       /* Intersection vertex */
{
  float u;              /* Slope of first line */
  float v;              /* Slope of second line */
  float cx, cy;         /* Intersection point */
  int ii;               /* Set to TRUE if really intersect */

  ii = TRUE;
  cx = 0.;
  cy = 0.;

  if (ABS (x1) > ABS (y1))
  {
    /*
     * First line is more horizontal than vertical:
     *      y1
     * y = ---- x
     *      x1
     */
    u = y1/x1;

    if (ABS (X2-X1) > ABS (Y2-Y1))
    {
      /*
       * Second line is more horizontal than vertical.
       */
      v = (Y2-Y1) / (X2-X1);
      if (ABS (u-v) < SMALL_EPSILON)
        ii = FALSE;
      else
      {
        cx = (Y1-v*X1)/(u-v);
        cy = u*cx;

        /*
         * Check if the line really cuts.
         */
        if ((cx < X1 && cx < X2) || (cx > X1 && cx > X2)) ii = FALSE;
      }
    }
    else
    {
      /*
       * Second line is more vertical than horizontal.
       */
      v = (X2-X1) / (Y2-Y1);
      if (ABS (1-u*v) < SMALL_EPSILON)
        ii = FALSE;
      else
      {
        cx = (X1-v*Y1)/(1-u*v);
        cy = u*cx;

        /*
         * Check if the line really cuts.
         */
        if ((cy < Y1 && cy < Y2) || (cy > Y1 && cy > Y2)) ii = FALSE;
      }
    }

    /*
     * Check if cutting point is in right direction of first vector.
     */
    if ((x1 < 0 || cx < 0) && (x1 > 0 || cx > 0)) ii = FALSE;
  }
  else
  {
    /*
     * First line is more vertical than horizontal:
     *      x1
     * x = ---- y
     *      y1
     */
    u = x1/y1;

    if (ABS (X2-X1) > ABS (Y2-Y1))
    {
      /*
       * Second line is more horizontal than vertical.
       */
      v = (Y2-Y1) / (X2-X1);
      if (ABS (1-u*v) < SMALL_EPSILON)
        ii = FALSE;
      else
      {
        cy = (Y1-v*X1)/(1-u*v);
        cx = u*cy;

        /*
         * Check if the line really cuts.
         */
        if ((cx < X1 && cx < X2) || (cx > X1 && cx > X2)) ii = FALSE;
      }
    }
    else
    {
      /*
       * Second line is more vertical than horizontal.
       */
      v = (X2-X1) / (Y2-Y1);
      if (ABS (u-v) < SMALL_EPSILON)
        ii = FALSE;
      else
      {
        cy = (X1-v*Y1)/(u-v);
        cx = u*cy;

        /*
         * Check if the line really cuts.
         */
        if ((cy < Y1 && cy < Y2) || (cy > Y1 && cy > Y2)) ii = FALSE;
      }
    }

    /*
     * Check if cutting point is in right direction of first vector.
     */
    if ((y1 < 0 || cy < 0) && (y1 > 0 || cy > 0)) ii = FALSE;
  }

  if (isect)
  {
    isect->x = cx;
    isect->y = cy;
  }
  return ii;
}

/*
 *           (YA-YC)(XD-XC)-(XA-XC)(YD-YC)
 *       r = -----------------------------  (eqn 1)
 *           (XB-XA)(YD-YC)-(YB-YA)(XD-XC)
 *
 *           (YA-YC)(XB-XA)-(XA-XC)(YB-YA)
 *       s = -----------------------------  (eqn 2)
 *           (XB-XA)(YD-YC)-(YB-YA)(XD-XC)
 */
int Segment::intersect_segments (
  Vector2& a, Vector2& b, /* First segment */
  Vector2& c, Vector2& d, /* Second segment */
  Vector2& isect,         /* Intersection vertex */
  float* rp)		  /* Return of the 'r' value */
{
  float denom;
  float r, s;

  denom = (b.x-a.x)*(d.y-c.y) - (b.y-a.y)*(d.x-c.x);
  if (ABS (denom) < EPSILON) return FALSE;

  r = ((a.y-c.y)*(d.x-c.x) - (a.x-c.x)*(d.y-c.y)) / denom;
  s = ((a.y-c.y)*(b.x-a.x) - (a.x-c.x)*(b.y-a.y)) / denom;

  //if (r < 0 || r > 1 || s < 0 || s > 1) return FALSE;
  if (r < -SMALL_EPSILON || r > 1+SMALL_EPSILON || s < -SMALL_EPSILON || s > 1+SMALL_EPSILON) return FALSE;

  isect.x = a.x + r*(b.x-a.x);
  isect.y = a.y + r*(b.y-a.y);
  *rp = r;

  return TRUE;
}

int Segment::intersect_segment_line (
  Vector2& a, Vector2& b, /* First segment */
  Vector2& c, Vector2& d, /* Second line */
  Vector2& isect,         /* Intersection vertex */
  float* rp)		  /* Return of the 'r' value */
{
  float denom;
  float r;

  denom = (b.x-a.x)*(d.y-c.y) - (b.y-a.y)*(d.x-c.x);
  if (ABS (denom) < SMALL_EPSILON) return FALSE;

  r = ((a.y-c.y)*(d.x-c.x) - (a.x-c.x)*(d.y-c.y)) / denom;

  //if (r < 0 || r > 1) return FALSE;
  if (r < -SMALL_EPSILON || r > 1+SMALL_EPSILON) return FALSE;

  isect.x = a.x + r*(b.x-a.x);
  isect.y = a.y + r*(b.y-a.y);
  *rp = r;

  return TRUE;
}

/*
 * x = r * (x2-x1) + x1;
 * y = r * (y2-y1) + y1;
 * z = r * (z2-z1) + z1;
 */
float Segment::intersect_z_plane_3d (
  float z,			// Z plane coordinate
  Vector3& a, Vector3& b,	// Segment
  Vector3& i)			// Intersection vertex
{
  //     z = r * (z2-z1) + z1;
  // --> r = (z-z1) / (z2-z1)
  float r = (z-a.z) / (b.z-a.z);
  i.x = r * (b.x-a.x) + a.x;
  i.y = r * (b.y-a.y) + a.y;
  i.z = z;
  return r;
}

//---------------------------------------------------------------------------
