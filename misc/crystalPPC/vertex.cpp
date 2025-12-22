#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef VERTEX_H
#include "vertex.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

//---------------------------------------------------------------------------

Vertex::Vertex (Vector3& v)
{
  set (v);
}

Vertex::Vertex (float x, float y, float z)
{
  set (x, y, z);
}

Vertex::Vertex ()
{
}

void Vertex::set (Vector3& v)
{
  Vertex::v = v;
}

void Vertex::set (float x, float y, float z)
{
  v.x = x;
  v.y = y;
  v.z = z;
}

void Vertex::set_t (Vector3& vr)
{
  Vertex::vr = vr;
}

void Vertex::set_t (float x, float y, float z)
{
  vr.x = x;
  vr.y = y;
  vr.z = z;
}

void Vertex::set_o (Vector3& vo)
{
  Vertex::vo = vo;
}

void Vertex::set_o (float x, float y, float z)
{
  vo.x = x;
  vo.y = y;
  vo.z = z;
}

void Vertex::dump ()
{
  MSG (("v:(%2.2f,%2.2f,%2.2f) vr:(%2.2f,%2.2f,%2.2f) vis=%d",
	v.x, v.y, v.z, vr.x, vr.y, vr.z, visible));
}

void Vertex::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sVERTEX (%f,%f,%f)\n", sp, vo.x, vo.y, vo.z);
}

void Vertex::load (char** buf)
{
  skip_token (buf, "VERTEX");
  skip_token (buf, "(", "Expected '%s' instead of '%s' after VERTEX statement!\n");
  vo.x = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for VERTEX statement!\n");
  vo.y = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for VERTEX statement!\n");
  vo.z = get_token_float (buf);
  skip_token (buf, ")", "Expected '%s' instead of '%s' to conclude VERTEX statement!\n");
  v = vo;
}

void Vertex::world_to_camera (Matrix3& m_w2c, Vector3& v_w2c)
{
  Vector3 u = v;
  u -= v_w2c;
  m_w2c.transform (u, vr);
}

void Vertex::object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w)
{
  (void)m_w2o;
  m_o2w.transform (vo, v);
  v -= v_o2w;
}

void Vertex::translate (Vector3& trans)
{
  vr = v;
  vr -= trans;
}

//---------------------------------------------------------------------------
