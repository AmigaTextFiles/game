#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef POLYPLANE_H
#include "polyplan.h"
#endif

#ifndef VERTEX_H
#include "vertex.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

//---------------------------------------------------------------------------

PolyPlane::PolyPlane (char* name)
{
  strcpy (PolyPlane::name, name);
}

PolyPlane::~PolyPlane ()
{
}

void PolyPlane::set_texture_space (Vertex& v_orig, Vertex& v1, float len1, Vertex& v2, float len2)
{
  float xo = v_orig.get_ox ();
  float yo = v_orig.get_oy ();
  float zo = v_orig.get_oz ();
  float x1 = v1.get_ox ();
  float y1 = v1.get_oy ();
  float z1 = v1.get_oz ();
  float x2 = v2.get_ox ();
  float y2 = v2.get_oy ();
  float z2 = v2.get_oz ();
  set_texture_space (xo, yo, zo, x1, y1, z1, len1, x2, y2, z2, len2);
}

void PolyPlane::set_texture_space (
	float xo, float yo, float zo,
	float x1, float y1, float z1,
	float len1,
	float x2, float y2, float z2,
	float len2)
{
  float l1 = sqrt ((xo-x1)*(xo-x1) + (yo-y1)*(yo-y1) + (zo-z1)*(zo-z1));
  float l2 = sqrt ((xo-x2)*(xo-x2) + (yo-y2)*(yo-y2) + (zo-z2)*(zo-z2));
  x1 = (x1-xo) * len1 / l1;
  y1 = (y1-yo) * len1 / l1;
  z1 = (z1-zo) * len1 / l1;
  x2 = (x2-xo) * len2 / l2;
  y2 = (y2-yo) * len2 / l2;
  z2 = (z2-zo) * len2 / l2;

  set_texture_space (xo, yo, zo, x1, y1, z1, x2, y2, z2, 1, 1, 1);
}

void PolyPlane::set_texture_space (Vertex& v_orig, Vertex& v_u, Vertex& v_v)
{
  float xo = v_orig.get_ox ();
  float yo = v_orig.get_oy ();
  float zo = v_orig.get_oz ();
  float x1 = v_u.get_ox ();
  float y1 = v_u.get_oy ();
  float z1 = v_u.get_oz ();
  float x2 = v_v.get_ox ();
  float y2 = v_v.get_oy ();
  float z2 = v_v.get_oz ();
  set_texture_space (xo, yo, zo, x1, y1, z1, x2, y2, z2);
}

void PolyPlane::set_texture_space (float xo, float yo, float zo,
  			  float xu, float yu, float zu,
  			  float xv, float yv, float zv)
{
  set_texture_space (xo, yo, zo, xu-xo, yu-yo, zu-zo,
  	xv-xo, yv-yo, zv-zo, 1, 1, 1);
}

void PolyPlane::set_texture_space (
	float xo, float yo, float zo,
	float xu, float yu, float zu,
	float xv, float yv, float zv,
	float xw, float yw, float zw)
{
  Matrix3 m_tex2obj;

  m_obj2tex.m11 = xu;
  m_obj2tex.m12 = xv;
  m_obj2tex.m13 = xw;
  m_obj2tex.m21 = yu;
  m_obj2tex.m22 = yv;
  m_obj2tex.m23 = yw;
  m_obj2tex.m31 = zu;
  m_obj2tex.m32 = zv;
  m_obj2tex.m33 = zw;
  m_obj2tex.inverse ();

  v_obj2tex.x = xo;
  v_obj2tex.y = yo;
  v_obj2tex.z = zo;

  m_world2tex = m_obj2tex;
  v_world2tex = v_obj2tex;
}

void PolyPlane::set_texture_space (Matrix3& tx_matrix, Vector3& tx_vector)
{
  m_obj2tex = tx_matrix;
  m_world2tex = tx_matrix;
  v_obj2tex = tx_vector;
  v_world2tex = tx_vector;
}

void PolyPlane::transform_world2cam (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  // Create the matrix to transform camera space to texture space.
  // From: T = Mwt * (W - Vwt)
  //       C = Mwc * (W - Vwc)
  // To:   T = Mct * (C - Vct)

  // Mcw * C + Vwc = W
  // T = Mwt * (Mcw * C + Mcw * Mwc * (Vwc - Vwt))
  // T = Mwt * Mcw * (C - Mwc * (Vwt-Vwc))
  // ===>
  // Mct = Mwt * Mcw
  // Vct = Mwc * (Vwt - Vwc)

  m_cam2tex = m_world2tex;
  m_cam2tex *= m_c2w;

  Vector3 v3 = v_world2tex;
  v3 -= v_w2c;
  m_w2c.transform (v3, v_cam2tex);
}

void PolyPlane::object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w)
{
  // From: T = Mot * (O - Vot)
  //       W = Mow * O - Vow
  // To:   T = Mwt * (W - Vwt)

  // Mwo * (W + Vow) = O
  // T = Mot * (Mwo * (W + Vow) - (Mwo * Mow) * Vot)
  // T = Mot * Mwo * (W + Vow - Mow * Vot)
  // ===>
  // Mwt = Mot * Mwo
  // Vwt = Mow * Vot - Vow

  m_world2tex = m_obj2tex;
  m_world2tex *= m_w2o;
  m_o2w.transform (v_obj2tex, v_world2tex);
  v_world2tex -= v_o2w;
}

void PolyPlane::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sPLANE '%s' (\n", sp, name);
  m_world2tex.save (fp, indent+2);
  v_world2tex.save (fp, indent+2);
  fprintf (fp, "%s)\n", sp);
}

void PolyPlane::load (char** buf)
{
  char* t;
  char* old_buf;

  skip_token (buf, "PLANE");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a PLANE!\n");

  int tx1_given = FALSE, tx2_given = FALSE;
  Vector3 tx1_orig, tx1, tx2;
  float tx1_len = 0, tx2_len = 0;
  Matrix3 tx_matrix;
  Vector3 tx_vector;

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "ORIG"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PLANE/ORIG!\n");
      tx1_given = TRUE;
      tx1_orig.load (buf);
    }
    else if (!strcmp (t, "FIRST"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PLANE/FIRST!\n");
      tx1_given = TRUE;
      tx1.load (buf);
    }
    else if (!strcmp (t, "FIRST_LEN"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PLANE/FIRST_LEN!\n");
      tx1_len = get_token_float (buf);
      tx1_given = TRUE;
    }
    else if (!strcmp (t, "SECOND"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PLANE/SECOND!\n");
      tx2_given = TRUE;
      tx2.load (buf);
    }
    else if (!strcmp (t, "SECOND_LEN"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PLANE/SECOND_LEN!\n");
      tx2_len = get_token_float (buf);
      tx2_given = TRUE;
    }
    else if (!strcmp (t, "MATRIX"))
    {
      *buf = old_buf;
      tx_matrix.load (buf);
    }
    else if (!strcmp (t, "("))
    {
      *buf = old_buf;
      tx_vector.load (buf);
    }
    else
    {
      printf ("What is '%s' doing in a PLANE statement?\n", t);
    }
  }

  if (tx1_given)
    if (tx2_given) set_texture_space (tx1_orig.x, tx1_orig.y, tx1_orig.z,
				      tx1.x, tx1.y, tx1.z, tx1_len,
				      tx2.x, tx2.y, tx2.z, tx2_len);
    else { printf ("Not supported!\n"); exit (0); }
  else set_texture_space (tx_matrix, tx_vector);
}

//---------------------------------------------------------------------------
