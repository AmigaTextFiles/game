#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef POLYPLANE_H
#include "polyplan.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef LIGHTMAP_H
#include "lightmap.h"
#endif

//#ifndef OCCLUS_H
//#include "occlus.h"
//#endif
#include <clib/powerpc_protos.h>

//---------------------------------------------------------------------------

// Given a camera space coordinate, calculate the texture space coordinates
// (u,v) coordinates. This is a theoretical function which is never used
// anywhere but I don't remove it since it documents the core of the
// perspective correct texture mapping equations.

void get_uv (float x, float y, float z, Matrix3& m_cam2tex, Vector3& v_cam2tex,
        float* p_u, float* p_v)
{
  // From: T = Mct * (C - Vct)
  x -= v_cam2tex.x;
  y -= v_cam2tex.y;
  z -= v_cam2tex.z;
  *p_u = m_cam2tex.m11*x+m_cam2tex.m12*y+m_cam2tex.m13*z;
  *p_v = m_cam2tex.m21*x+m_cam2tex.m22*y+m_cam2tex.m23*z;
}

//---------------------------------------------------------------------------

Polygon3D::Polygon3D (char* name, int max, Textures* textures, int texnr)
{
  max_vertices = max;
  vertices_idx = new int [max];
  num_vertices = 0;

  strcpy (Polygon3D::name, name);

  portal = NULL;

  tex = new PolyTexture ();
  tex->set_polygon (this);
  tex->set_texnr (textures, texnr);

  tex1 = new PolyTexture ();
  tex1->set_polygon (this);
  tex1->set_texnr (textures, textures->get_mipmap1_nr (texnr));

  tex2 = new PolyTexture ();
  tex2->set_polygon (this);
  tex2->set_texnr (textures, textures->get_mipmap2_nr (texnr));

  tex3 = new PolyTexture ();
  tex3->set_polygon (this);
  tex3->set_texnr (textures, textures->get_mipmap3_nr (texnr));

  plane = NULL;
  delete_plane = FALSE;

  do_warp_space = FALSE;
  no_mipmap = FALSE;
  no_lighting = FALSE;

  lightmap = lightmap1 = lightmap2 = lightmap3 = NULL;
}

Polygon3D::~Polygon3D ()
{
  if (vertices_idx) delete [] vertices_idx;
  if (tex) delete tex;
  if (tex1) delete tex1;
  if (tex2) delete tex2;
  if (tex3) delete tex3;
  if (plane && delete_plane) delete plane;
  if (lightmap) delete lightmap;
  if (lightmap1) delete lightmap1;
  if (lightmap2) delete lightmap2;
  if (lightmap3) delete lightmap3;
}

void Polygon3D::set_texnr (Textures* textures, int texnr)
{
  tex->set_texnr (textures, texnr);
  tex1->set_texnr (textures, textures->get_mipmap1_nr (texnr));
  tex2->set_texnr (textures, textures->get_mipmap2_nr (texnr));
  tex3->set_texnr (textures, textures->get_mipmap3_nr (texnr));
}

PolyTexture* Polygon3D::get_polytex (int mipmap)
{
  switch (mipmap)
  {
    case 0: return tex;
    case 1: return tex1;
    case 2: return tex2;
    case 3: return tex3;
  }
  return tex;
}

PolyTexture* Polygon3D::get_polytex (float z_dist)
{
  if (z_dist < ZDIST_MIPMAP1) return tex;
  if (z_dist < ZDIST_MIPMAP2) return tex1;
  if (z_dist < ZDIST_MIPMAP3) return tex2;
  return tex3;
}

void Polygon3D::warp_space (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  if (do_warp_space)
  {
    m_w2c *= m_warp;

    Matrix3 m = m_warp_inv;
    m *= m_c2w;
    m_c2w = m;

    v_w2c += v_warp;
  }
}

void Polygon3D::set_warp (Matrix3& m_w, Vector3& v_w)
{
  do_warp_space = TRUE;
  m_warp = m_w;
  m_warp_inv = m_w;
  m_warp_inv.inverse ();
  v_warp = v_w;
}

int Polygon3D::same_plane (Polygon3D* p)
{
  if (p->plane == plane) return TRUE;

  if (ABS (p->A-A) > .001) return FALSE;
  if (ABS (p->B-B) > .001) return FALSE;
  if (ABS (p->C-C) > .001) return FALSE;
  if (ABS (p->D-D) > .001) return FALSE;
  return TRUE;
}

void Polygon3D::compute_normal ()
{
  PlaneNormal (&Ao, &Bo, &Co);
  Do = -Ao*vtex (0).get_ox () - Bo*vtex (0).get_oy () - Co*vtex (0).get_oz ();

  // By default the world space normal is equal to the object space normal.
  A = Ao;
  B = Bo;
  C = Co;
  D = Do;
}

void Polygon3D::get_camera_normal (float* p_A, float* p_B, float* p_C, float* p_D)
{
  *p_A = Ac;
  *p_B = Bc;
  *p_C = Cc;
  *p_D = Dc;
}

void Polygon3D::get_world_normal (float* p_A, float* p_B, float* p_C, float* p_D)
{
  *p_A = A;
  *p_B = B;
  *p_C = C;
  *p_D = D;
}

void Polygon3D::normal_object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w)
{
  (void)m_w2o; (void)v_o2w;
  // Transform the plane normal.
  Vector3 v; v.x = Ao; v.y = Bo; v.z = Co;
  Vector3 v2;
  m_o2w.transform (v, v2);
  A = v2.x; B = v2.y; C = v2.z;
  D = -A*vtex (0).get_x () - B*vtex (0).get_y () - C*vtex (0).get_z ();
}

void Polygon3D::normal_world_to_camera (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  (void)m_c2w; (void)v_w2c;
  // Transform the plane normal.
  Vector3 v; v.x = A; v.y = B; v.z = C;
  Vector3 v2;
  m_w2c.transform (v, v2);
  Ac = v2.x; Bc = v2.y; Cc = v2.z;
  Dc = -Ac*vtex (0).get_tx () - Bc*vtex (0).get_ty () - Cc*vtex (0).get_tz ();
}

void Polygon3D::object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w)
{
  plane->object_to_world (m_o2w, m_w2o, v_o2w);
  normal_object_to_world (m_o2w, m_w2o, v_o2w);
}

float Polygon3D::sq_distance (Vector3& v)
{
  float n = A*v.x + B*v.y + C*v.z + D;
  // The normal is normalized (has unit length) so this is
  // all we need to calculate the squared distance.
  return n*n;
  //return (n*n) / (A*A + B*B + C*C);
}

void Polygon3D::closest_point (Vector3& v, Vector3& isect)
{
  // The normal is normalized (has unit length) so this is
  // all we need to calculate the squared distance.
  float r = A*v.x + B*v.y + C*v.z + D;
  //  float r = (A*v.x + B*v.y + C*v.z + D) / (A*A + B*B + C*C);

  isect.x = r*(-A-v.x)+v.x;
  isect.y = r*(-B-v.y)+v.y;
  isect.z = r*(-C-v.z)+v.z;
}

void Polygon3D::precalculate ()
{
  tex->create_bounding_texture_box (); tex->lm = NULL;
  tex1->create_bounding_texture_box (); tex1->lm = NULL;
  tex2->create_bounding_texture_box (); tex2->lm = NULL;
  tex3->create_bounding_texture_box (); tex3->lm = NULL;

  lightmap = lightmap1 = lightmap2 = lightmap3 = NULL;
  if (!no_lighting && tex->w*tex->h < 1000000 && !tex->get_texture ()->get_filtered ())
  {
    lightmap = new LightMap ();
    lightmap->alloc (tex->w, tex->h, this);
    tex->mipmap_size = 16; tex->lm = lightmap;
  }
}

void Polygon3D::mipmap_settings (int setting)
{
  if (!lightmap) return;

  if (lightmap1) { delete lightmap1; lightmap1 = NULL; }
  if (lightmap2) { delete lightmap2; lightmap2 = NULL; }
  if (lightmap3) { delete lightmap3; lightmap3 = NULL; }

  switch (setting)
  {
    case MIPMAP_SHADOW_ACCURATE:
      tex1->mipmap_size = 8; tex1->lm = lightmap;
      tex2->mipmap_size = 4; tex2->lm = lightmap;
      tex3->mipmap_size = 2; tex3->lm = lightmap;
      break;
    case MIPMAP_SHADOW_INACCURATE:
      lightmap1 = new LightMap ();
      lightmap1->mipmap_lightmap (tex1->w, tex1->h, lightmap, tex->w, tex->h);
      lightmap2 = new LightMap ();
      lightmap2->mipmap_lightmap (tex2->w, tex2->h, lightmap1, tex1->w, tex1->h);
      lightmap3 = new LightMap ();
      lightmap3->mipmap_lightmap (tex3->w, tex3->h, lightmap2, tex2->w, tex2->h);
      tex1->mipmap_size = 16; tex1->lm = lightmap1;
      tex2->mipmap_size = 16; tex2->lm = lightmap2;
      tex3->mipmap_size = 16; tex3->lm = lightmap3;
      break;
    case MIPMAP_SHADOW_REASONABLE:
      lightmap2 = new LightMap ();
      lightmap2->mipmap_lightmap (tex1->w, tex1->h, lightmap, tex->w, tex->h);
      tex1->mipmap_size = 8; tex1->lm = lightmap;
      tex2->mipmap_size = 8; tex2->lm = lightmap2;
      tex3->mipmap_size = 4; tex3->lm = lightmap2;
      break;
  }
}

void Polygon3D::set_texture_space (PolyPlane* pl)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = pl;
  delete_plane = FALSE;

  precalculate ();
}

void Polygon3D::set_texture_space (Polygon3D* copy_from)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = copy_from->plane;
  delete_plane = FALSE;

  precalculate ();
}

void Polygon3D::set_texture_space (Matrix3& tx_matrix, Vector3& tx_vector)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (tx_matrix, tx_vector);

  precalculate ();
}

void Polygon3D::set_texture_space (Vertex& v_orig, Vertex& v1, float len1)
{
  float xo = v_orig.get_ox ();
  float yo = v_orig.get_oy ();
  float zo = v_orig.get_oz ();
  float x1 = v1.get_ox ();
  float y1 = v1.get_oy ();
  float z1 = v1.get_oz ();
  set_texture_space (xo, yo, zo, x1, y1, z1, len1);
}

void Polygon3D::set_texture_space (Vertex& v_orig,
        Vertex& v1, float len1,
        Vertex& v2, float len2)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (v_orig, v1, len1, v2, len2);

  precalculate ();
}

void Polygon3D::set_texture_space (
        float xo, float yo, float zo,
        float x1, float y1, float z1,
        float len1)
{
  compute_normal ();

  float l1 = sqrt ((xo-x1)*(xo-x1) + (yo-y1)*(yo-y1) + (zo-z1)*(zo-z1));
  x1 = (x1-xo) / l1;
  y1 = (y1-yo) / l1;
  z1 = (z1-zo) / l1;

  float x2, y2, z2;

  // The cross product of the given vector and the normal of
  // the polygon plane is a vector which is perpendicular on
  // both (and thus is also on the plane).
  x2 = y1*C-z1*B;
  y2 = z1*A-x1*C;
  z2 = x1*B-y1*A;

  float l2 = sqrt (x2*x2 + y2*y2 + z2*z2);

  x1 *= len1;
  y1 *= len1;
  z1 *= len1;
  x2 = x2*len1 / l2;
  y2 = y2*len1 / l2;
  z2 = z2*len1 / l2;

  float l3 = sqrt (A*A + B*B + C*C);
  float a, b, c;
  a = A*len1 / l3;
  b = B*len1 / l3;
  c = C*len1 / l3;

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (xo, yo, zo, x1, y1, z1, x2, y2, z2, a, b, c);

  precalculate ();
}

void Polygon3D::set_texture_space (
        float xo, float yo, float zo,
        float x1, float y1, float z1,
        float len1,
        float x2, float y2, float z2,
        float len2)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (xo, yo, zo, x1, y1, z1, len1, x2, y2, z2, len2);

  precalculate ();
}

void Polygon3D::set_texture_space (Vertex& v_orig, Vertex& v_u, Vertex& v_v)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (v_orig, v_u, v_v);

  precalculate ();
}

void Polygon3D::set_texture_space (float xo, float yo, float zo,
                          float xu, float yu, float zu,
                          float xv, float yv, float zv)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (xo, yo, zo, xu, yu, zu, xv, yv, zv);

  precalculate ();
}

void Polygon3D::set_texture_space (
        float xo, float yo, float zo,
        float xu, float yu, float zu,
        float xv, float yv, float zv,
        float xw, float yw, float zw)
{
  compute_normal ();

  if (plane && delete_plane) delete plane;
  plane = new PolyPlane ("-");
  delete_plane = TRUE;
  plane->set_texture_space (xo, yo, zo, xu, yu, zu, xv, yv, zv, xw, yw, zw);

  precalculate ();
}

void Polygon3D::shine (Light* light)
{
  if (shine_done) return;
  shine_done = TRUE;
  tex->shine (light);
}

void Polygon3D::setup_dyn_light (DynLight* light, float sq_dist)
{
  if (shine_done) return;
  shine_done = TRUE;
  light->add_polygon (this);
  tex->setup_dyn_light (light, sq_dist);
  if (tex1) tex1->setup_dyn_light (light, sq_dist);
  if (tex2) tex2->setup_dyn_light (light, sq_dist);
  if (tex3) tex3->setup_dyn_light (light, sq_dist);
}

void Polygon3D::add_vertex (int v)
{
  vertices_idx[num_vertices] = v;
  num_vertices++;
  if (num_vertices > max_vertices)
        dprintf ("OVERFLOW add_vertex!\n");
}

enum InFlag { IN_P, IN_Q, IN_UNKNOWN };

void Polygon3D::PlaneNormal (float* yz, float* zx, float* xy)
{
  float ayz = 0;
  float azx = 0;
  float axy = 0;
  int i, i1;
  float x1, y1, z1, x, y, z;

  i1 = num_vertices-1;
  for (i = 0 ; i < num_vertices ; i++)
  {
    x = vtex (i).get_x ();
    y = vtex (i).get_y ();
    z = vtex (i).get_z ();
    x1 = vtex (i1).get_x ();
    y1 = vtex (i1).get_y ();
    z1 = vtex (i1).get_z ();
    ayz += (z1+z) * (y-y1);
    azx += (x1+x) * (z-z1);
    axy += (y1+y) * (x-x1);
    i1 = i;
  }

  float d = sqrt (ayz*ayz + azx*azx + axy*axy);

  *yz = ayz / d;
  *zx = azx / d;
  *xy = axy / d;
}

int Polygon3D::visible_from_point (Vector3& p)
{
  // Back-face culling.
  float dot = A*(vtex (0).get_x ()-p.x) + B*(vtex (0).get_y ()-p.y) + C*(vtex (0).get_z ()-p.z);
  return dot > 0;
}

int Polygon3D::do_perspective (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c, Polygon2D* dest)
{
  int i, i1, cnt_vis;
  float r;
  int zs, z1s;

  // Count the number of visible vertices for this polygon (note
  // that the transformation from world to camera space for all the
  // vertices has been done earlier).
  // If there are no visible vertices this polygon need not be drawn.
  cnt_vis = 0;
  for (i = 0 ; i < num_vertices ; i++)
    if (vtex (i).get_tz () >= SMALL_Z) cnt_vis++;
  if (cnt_vis == 0) return FALSE;

  // Perform backface culling.
  // Note! The plane normal needs to be correctly calculated for this
  // to work!
  if (!visible_from_point (v_w2c)) return FALSE;

  dest->make_empty ();

  if (cnt_vis < num_vertices)
  {
    // Some vertices are visible and some are not, so we need to clip
    // against z=SMALL_Z.
    i1 = num_vertices-1;
    Vector3 isect;
    for (i = 0 ; i < num_vertices ; i++)
    {
      zs = vtex (i).get_tz () < SMALL_Z;
      z1s = vtex (i1).get_tz () < SMALL_Z;

      if (z1s && !zs)
      {
        r = Segment::intersect_z_plane_3d (SMALL_Z, vtex (i1).get_tv (), vtex (i).get_tv (), isect);
        dest->add_perspective (isect);
        dest->add_perspective (vtex (i).get_tv ());
      }
      else if (!z1s && zs)
      {
        r = Segment::intersect_z_plane_3d (SMALL_Z, vtex (i1).get_tv (), vtex (i).get_tv (), isect);
        dest->add_perspective (isect);
      }
      else if (!z1s && !zs)
      {
        dest->add_perspective (vtex (i).get_tv ());
      }
      i1 = i;
    }
  }
  else
  {
    // All vertices are visible, just do perspective projection.
    for (i = 0 ; i < num_vertices ; i++)
      dest->add_perspective (vtex (i).get_tv ());
  }

  // If polygon is still visible we also create the matrix to transform
  // camera space to texture space.
  plane->transform_world2cam (m_w2c, m_c2w, v_w2c);

  // We also transform the plane normal to camera space.
  normal_world_to_camera (m_w2c, m_c2w, v_w2c);

  return TRUE;
}

void Polygon3D::dump ()
{
  MSG (("Dump polygon '%s':\n", name));
  MSG (("    num_vertices=%d  max_vertices=%d\n", num_vertices, max_vertices));
  if (portal) MSG (("    Polygon is a portal to sector '%s'.\n", portal->get_name ()));
  int i;
  for (i = 0 ; i < num_vertices ; i++)
    MSG (("        v[%d]: (%2.2f,%2.2f,%2.2f)  camera:(%2.2f,%2.2f,%2.2f)\n",
        i,
        vtex (i).get_x (),
        vtex (i).get_y (),
        vtex (i).get_z (),
        vtex (i).get_tx (),
        vtex (i).get_ty (),
        vtex (i).get_tz ()));
  fflush (stdout);
}

int Polygon3D::intersect_segment (Vector3& start, Vector3& end, Vector3& isect)
{
  float x1 = start.x;
  float y1 = start.y;
  float z1 = start.z;
  float x2 = end.x;
  float y2 = end.y;
  float z2 = end.z;
  float r, num, denom;

  // @@@ Note! I think this algorithm can be done more efficiently.
  // I have had no time yet to look at it closely.

  // First we do backface culling on the polygon with respect to
  // the starting point of the beam.
  if (!visible_from_point (start)) return FALSE;

  // So now we have the plane equation of the polygon:
  // A*x + B*y + C*z + D = 0
  //
  // We also have the parameter line equations of the ray
  // going through 'start' and 'end':
  // x = r*(x2-x1)+x1
  // y = r*(y2-y1)+y1
  // z = r*(z2-z1)+z1
  //
  // =>   A*(r*(x2-x1)+x1) + B*(r*(y2-y1)+y1) + C*(r*(z2-z1)+z1) + D = 0

  denom = A*(x2-x1) + B*(y2-y1) + C*(z2-z1);
  if (ABS (denom) < SMALL_EPSILON) return FALSE;        // Lines are parallel

  num = - (A*x1 + B*y1 + C*z1 + D);
  r = num / denom;

  // If r is not in [0,1] the intersection point is not on the segment.
  if (r < -SMALL_EPSILON || r > 1) return FALSE;

  isect.x = r*(x2-x1)+x1;
  isect.y = r*(y2-y1)+y1;
  isect.z = r*(z2-z1)+z1;

  // At this point we know that the segment intersects with the plane of the
  // polygon. Now we check if the intersection point is in the polygon.
  int rc = in_poly_3d (isect);
  return rc != POLY_OUT;
}

int Polygon3D::in_poly_3d (Vector3& vv)
{
  int i, j, dj;
  Vector2 v2[200];
  Vector2 v;
  Box box;

  box.start_bounding_box ();

  // Using the plane normal of the polygon we determine the most
  // distinguising two components (x, y, or z) that we are going to use
  // to use a 2D test with.
  // @@@ Note! I'm not very satisfied with this algorithm. I think it
  // should be possible to do this completely in 3D, but I'm not such
  // an expert on this. Maybe someone else can help?

  if (ABS (C) > ABS (A) && ABS (C) > ABS (B))
  {
    // Use x and y.
    if (C < 0) { j = num_vertices-1; dj = -1; } // Make clockwise
    else { j = 0 ; dj = 1; }
    for (i = 0 ; i < num_vertices ; i++)
    {
      v2[i].x = vtex (j).get_x ();;
      v2[i].y = vtex (j).get_y ();
      box.add_bounding_vertex (v2[i].x, v2[i].y);
      j += dj;
    }
    v.x = vv.x;
    v.y = vv.y;
  }
  else if (ABS (A) > ABS (B) && ABS (A) > ABS (C))
  {
    // Use y and z.
    if (A < 0) { j = num_vertices-1; dj = -1; } // Make clockwise
    else { j = 0 ; dj = 1; }
    for (i = 0 ; i < num_vertices ; i++)
    {
      v2[i].x = vtex (j).get_y ();
      v2[i].y = vtex (j).get_z ();
      box.add_bounding_vertex (v2[i].x, v2[i].y);
      j += dj;
    }
    v.x = vv.y;
    v.y = vv.z;
  }
  else
  {
    // Use x and z.
    if (B > 0) { j = num_vertices-1; dj = -1; } // Make clockwise
    else { j = 0 ; dj = 1; }
    for (i = 0 ; i < num_vertices ; i++)
    {
      v2[i].x = vtex (j).get_x ();
      v2[i].y = vtex (j).get_z ();
      box.add_bounding_vertex (v2[i].x, v2[i].y);
      j += dj;
    }
    v.x = vv.x;
    v.y = vv.z;
  }

  return v.in_poly_2d (v2, num_vertices, &box);
}

void Polygon3D::save (FILE* fp, int indent, Textures* textures)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sPOLYGON '%s' (\n", sp, name);
  fprintf (fp, "%s  MAX_VERTICES=%d\n", sp, max_vertices);
  fprintf (fp, "%s  TEXNR='%s'\n", sp, textures->get_texture (tex->texnr)->get_name ());
  if (portal) fprintf (fp, "%s  PORTAL='%s'\n", sp, portal->get_name ());

  if (no_mipmap) fprintf (fp, "%s  MIPMAP=no\n", sp);
  if (no_lighting) fprintf (fp, "%s  LIGHTING=no\n", sp);

  if (!delete_plane && plane->get_name ()[0] != '-')
  {
    fprintf (fp, "%s  TEXTURE=(PLANE '%s')\n", sp, plane->get_name ());
  }
  else
  {
    fprintf (fp, "%s  TEXTURE=(\n", sp);
    plane->m_world2tex.save (fp, indent+4);
    plane->v_world2tex.save (fp, indent+4);
    fprintf (fp, "%s  )\n", sp);
  }

  if (do_warp_space)
  {
    fprintf (fp, "%s  WARP=(\n", sp);
    m_warp.save (fp, indent+4);
    v_warp.save (fp, indent+4);
    fprintf (fp, "%s  )\n", sp);
  }

  int i;
  if (num_vertices)
  {
    fprintf (fp, "%s  VERTICES=[%d", sp, vertices_idx[0]);
    for (i = 1 ; i < num_vertices ; i++)
      fprintf (fp, ",%d", vertices_idx[i]);
    fprintf (fp, "]\n");
  }
  fprintf (fp, "%s)\n", sp);
}

void Polygon3D::load (World* w, char** buf, Textures* textures, int default_texnr,
                      float default_texlen)
{
  char* t;
  int i;
  char* old_buf;

  skip_token (buf, "POLYGON");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a POLYGON!\n");

  int texnr;
  if (default_texnr == -1) texnr = 0;
  else
  {
    texnr = default_texnr;
    set_texnr (textures, texnr);
  }

  portal = NULL; // Default

  int tx1_given = FALSE, tx2_given = FALSE;
  Vector3 tx1_orig, tx1, tx2;
  float tx1_len = default_texlen, tx2_len = default_texlen;
  float tx_len = default_texlen;
  Matrix3 tx_matrix;
  Vector3 tx_vector;
  char plane_name[30];
  plane_name[0] = 0;

  do_warp_space = FALSE;
  no_lighting = FALSE;
  no_mipmap = FALSE;

  while (TRUE)
  {
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "MAX_VERTICES"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after MAX_VERTICES!\n");
      max_vertices = get_token_int (buf);
      if (vertices_idx) delete [] vertices_idx;
      vertices_idx = new int [max_vertices];
    }
    else if (!strcmp (t, "TEXNR"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXNR!\n");
      t = get_token (buf);
      texnr = textures->get_texture_idx (t);
      if (texnr == -1)
      {
        printf ("Couldn't find texture named '%s'!\n", t);
      }
      set_texnr (textures, texnr);
    }
    else if (!strcmp (t, "LIGHTING"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after LIGHTING!\n");
      t = get_token (buf);
      no_lighting = !!strcmp (t, "yes");
    }
    else if (!strcmp (t, "MIPMAP"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after MIPMAP!\n");
      t = get_token (buf);
      no_mipmap = !!strcmp (t, "yes");
    }
    else if (!strcmp (t, "PORTAL"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PORTAL!\n");
      t = get_token (buf);
      portal = w->get_sector (t);
      if (!portal)
        portal = w->new_sector (t, 10, 10);  // This will later be defined correctly
    }
    else if (!strcmp (t, "WARP"))
    {
      do_warp_space = TRUE;
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE!\n");
      skip_token (buf, "(", "Expected '%s' instead of '%s' to open TEXTURE statement!\n");
      while (TRUE)
      {
        old_buf = *buf;
        t = get_token (buf);
        if (*t == ')' || *t == 0) break;
        else if (!strcmp (t, "MATRIX"))
        {
          *buf = old_buf;
          m_warp.load (buf);
          m_warp_inv = m_warp;
          m_warp_inv.inverse ();
        }
        else if (!strcmp (t, "("))
        {
          *buf = old_buf;
          v_warp.load (buf);
        }
        else
        {
          printf ("What is '%s' doing in a POLYGON/WARP statement?\n", t);
        }
      }
    }
    else if (!strcmp (t, "TEXTURE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE!\n");
      skip_token (buf, "(", "Expected '%s' instead of '%s' to open TEXTURE statement!\n");
      while (TRUE)
      {
        old_buf = *buf;
        t = get_token (buf);
        if (*t == ')' || *t == 0) break;
        if (!strcmp (t, "ORIG"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/ORIG!\n");
          tx1_given = TRUE;
          tx1_orig.load (buf);
        }
        else if (!strcmp (t, "FIRST"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/FIRST!\n");
          tx1_given = TRUE;
          tx1.load (buf);
        }
        else if (!strcmp (t, "FIRST_LEN"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/FIRST_LEN!\n");
          tx1_len = get_token_float (buf);
          tx1_given = TRUE;
        }
        else if (!strcmp (t, "SECOND"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/SECOND!\n");
          tx2_given = TRUE;
          tx2.load (buf);
        }
        else if (!strcmp (t, "SECOND_LEN"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/SECOND_LEN!\n");
          tx2_len = get_token_float (buf);
          tx2_given = TRUE;
        }
        else if (!strcmp (t, "LEN"))
        {
          skip_token (buf, "=", "Expected '%s' instead of '%s' after POLYGON/LEN!\n");
          tx_len = get_token_float (buf);
        }
        else if (!strcmp (t, "MATRIX"))
        {
          *buf = old_buf;
          tx_matrix.load (buf);
          tx_len = 0;
        }
        else if (!strcmp (t, "("))
        {
          *buf = old_buf;
          tx_vector.load (buf);
          tx_len = 0;
        }
        else if (!strcmp (t, "PLANE"))
        {
          t = get_token (buf);
          strcpy (plane_name, t);
          tx_len = 0;
        }
        else
        {
          printf ("What is '%s' doing in a POLYGON/TEXTURE statement?\n", t);
        }
      }
    }
    else if (!strcmp (t, "VERTICES"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after VERTICES!\n");
      t = get_token (buf);
      while (*t && *t != ']')
      {
        if (*t != '[' && *t != ',')
        {
          printf ("Expected '[' or ',' instead of '%s' in vertex list!\n", t);
        }
        i = get_token_int (buf);
        add_vertex (i);
        t = get_token (buf);
      }
    }
    else
    {
      printf ("What is '%s' doing in a POLYGON statement?\n", t);
    }
  }

  if (tx1_given)
    if (tx2_given) set_texture_space (tx1_orig.x, tx1_orig.y, tx1_orig.z,
                                      tx1.x, tx1.y, tx1.z, tx1_len,
                                      tx2.x, tx2.y, tx2.z, tx2_len);
    else set_texture_space (tx1_orig.x, tx1_orig.y, tx1_orig.z,
                            tx1.x, tx1.y, tx1.z, tx1_len);
  else if (plane_name[0]) set_texture_space (w->get_plane (plane_name));
  else if (tx_len)
  {
    // If a length is given (with 'LEN') we will take the first two vertices
    // and calculate the texture orientation from them (with the given
    // length).
    set_texture_space (poly_set->vtex (vertices_idx[0]),
                       poly_set->vtex (vertices_idx[1]), tx_len);
  }
  else set_texture_space (tx_matrix, tx_vector);
}

//---------------------------------------------------------------------------

Polygon2D Polygon2D::clipped (MAX_VERTICES);

Polygon2D::Polygon2D (int max)
{
  max_vertices = max;
  vertices = new Vector2 [max];
  make_empty ();
}

Polygon2D::Polygon2D (Polygon2D& copy)
{
  max_vertices = copy.max_vertices;
  vertices = new Vector2 [max_vertices];
  num_vertices = copy.num_vertices;
  CopyMemPPC (copy.vertices, vertices,sizeof (Vector2)*num_vertices);
  bbox = copy.bbox;
}

Polygon2D::~Polygon2D ()
{
  if (vertices) delete [] vertices;
}

void Polygon2D::make_empty ()
{
  num_vertices = 0;
  bbox.start_bounding_box ();
}

void Polygon2D::add_vertex (float x, float y)
{
  vertices[num_vertices].x = x;
  vertices[num_vertices].y = y;
  num_vertices++;
  bbox.add_bounding_vertex (x, y);
  if (num_vertices > max_vertices) dprintf ("OVERFLOW add_vertex!\n");
}

void Polygon2D::add_perspective (float x, float y, float z)
{
  float iz = ASPECT/z;
  float px, py;

  if (num_vertices >= max_vertices) dprintf ("OVERFLOW add_perspective!\n");

  px = x * iz + (FRAME_WIDTH/2);
  py = y * iz + (FRAME_HEIGHT/2);
  vertices[num_vertices].x = px;
  vertices[num_vertices].y = py;

  num_vertices++;
  bbox.add_bounding_vertex (px, py);
}

#if USE_OCCLUSION
int Polygon2D::clip_to_occlusion (Occlusion* o)
{
  if (o->hull_is_empty ()) return TRUE;

  int i, in;
  for (i = 0 ; i < num_vertices ; i++)
  {
    in = o->point_in_hull (vertices[i]);
    if (in == POLY_OUT) return TRUE;
  }
  return FALSE;
}
#endif

// This is a variant of clip_poly that I use because I can't seem to get
// that version working in all cases. clip_poly will probably be faster
// than this version, but this version always works (I think).
int Polygon2D::clip_poly_variant (Vector2* Q, int m, Box* box)
{
  if (!overlap_bounding_box (box)) return FALSE;

  int i, i1;

  i1 = m-1;
  for (i = 0 ; i < m ; i++)
  {
    clip_poly_plane (Q[i1], Q[i]);
    if (num_vertices < 3) return FALSE;
    i1 = i;
  }

  return TRUE;
}

// Clip a polygon against a plane.
void Polygon2D::clip_poly_plane (Vector2& v1, Vector2& v2)
{
  Vector2 nclip[100];
  int num_nclip = 0;
  int i, i1;
  float r;
  Vector2 isect;
  int side, side1;
  int isect_happened = 0;

  bbox.start_bounding_box ();

  i1 = num_vertices-1;
  side1 = vertices[i1].which_side_2d (v1, v2);

  for (i = 0 ; i < num_vertices ; i++)
  {
    side = vertices[i].which_side_2d (v1, v2);

    if ((side1 < 0 && side > 0) || (side1 > 0 && side < 0))
      if (!Segment::intersect_segment_line (vertices[i1], vertices[i], v1, v2, isect, &r))
      {
#       if 0
        MSG (("Strange! there should be an intersection!\n"));
        MSG (("    segment: (%2.2f,%2.2f)-(%2.2f,%2.2f) with\n",
              vertices[i1].x, vertices[i1].y, vertices[i].x, vertices[i].y));
        MSG (("    line:    (%2.2f,%2.2f)-(%2.2f,%2.2f)\n",
              v1.x, v1.y, v2.x, v2.y));
#       endif
      }
      else
      {
        isect_happened++;
        nclip[num_nclip] = isect;
        num_nclip++;
        bbox.add_bounding_vertex (isect);
      }

    if (side >= 0)
    {
      nclip[num_nclip] = vertices[i];
      num_nclip++;
      bbox.add_bounding_vertex (vertices[i]);
    }

    i1 = i;
    side1 = side;
  }

  if (isect_happened || num_nclip != num_vertices)
  {
    for (i = 0 ; i < num_nclip ; i++) vertices[i] = nclip[i];
    num_vertices = num_nclip;
  }
}

int Polygon2D::clip_poly (Vector2* Q, int m, Box* box, Polygon2D* dest)
{
  dest->make_empty ();
  if (!overlap_bounding_box (box)) return FALSE;

  // This polygon is P; Q is the view_poly
  int a, b;             // Indices on P and Q
  int a1, b1;           // a-1, b-1
  Vector2* va, * vb;    // Pointer to respective vertices
  Vector2* va1, * vb1;
  Vector2 A, B;         // Directed edges on P and Q
  float cross;          // A x B
  int bHA, aHB;         // b in H(A), a in H(b)
  Vector2 p;            // Point of intersection
  InFlag inflag;        // Which polygon is known to be inside
  int i;
  int aa, ba;           // # advances on a & b indices (from 1st intersection)
  int reset = FALSE;    // Have the advance counters ever been reset?
  int n;                // # vertices of P (resp.)
  float r;

  a = 0; b = 0; aa = 0; ba = 0;
  i = 0;
  inflag = IN_UNKNOWN;
  n = num_vertices;

  do
  {
    // Computations of key variables.
    a1 = (a+n-1) % n;
    b1 = (b+m-1) % m;
    va = &vertices[a];
    va1 = &vertices[a1];
    vb = &Q[b];
    vb1 = &Q[b1];

    A.x = va->x - va1->x;
    A.y = va->y - va1->y;
    B.x = vb->x - vb1->x;
    B.y = vb->y - vb1->y;

    // Compute twice the signed area of the triangle determined by
    // 0 (origin), A and B. Positive if 0, A and B are oriented ccw,
    // and negative if cw.
    // cross = Vector2::Area2 (0, 0, A.x, A.y, B.x, B.y);
    cross = A.x * B.y - B.x * A.y;
    if (ABS (cross) < SMALL_EPSILON) cross = 0;

    // bHA is TRUE if vb is strictly to the right of va1-va.
    bHA = Vector2::Right (va1->x, va1->y, va->x, va->y, vb->x, vb->y);

    // aHB is TRUE if va is strictly to the right of vb1-vb.
    aHB = Vector2::Right (vb1->x, vb1->y, vb->x, vb->y, va->x, va->y);

    // If A & B intersect, update inflag.
    if (Segment::intersect_segments (*va1, *va, *vb1, *vb, p, &r))
    {
      if (inflag == IN_UNKNOWN && !reset)
      {
        aa = ba = 0;
        reset = TRUE;
      }
      dest->add_vertex (p);
      if (aHB) inflag = IN_P;
      else if (bHA) inflag = IN_Q;
    }

    // Advance rules.
    if (ABS (cross) < SMALL_EPSILON && !bHA && !aHB)
    {
      if (inflag == IN_P)
      {
        b = (b+1) % m;
        ba++;
        //b = Advance (verbose, b, &ba, m, inflag == IN_Q, vb->x, vb->y);
      }
      else
      {
        a = (a+1) % n;
        aa++;
        //a = Advance (verbose, a, &aa, n, inflag == IN_P, va->x, va->y);
      }
    }
    else if (cross <= 0)
    {
      if (bHA)
      {
        if (inflag == IN_P)
        {
          if (va->in_poly_2d (Q, m, box) == POLY_OUT) inflag = IN_Q;
          else dest->add_vertex (*va);
        }

        a = (a+1) % n;
        aa++;

        //a = Advance (verbose, a, &aa, n, inflag == IN_P, va->x, va->y);
      }
      else
      {
        if (inflag == IN_Q) dest->add_vertex (*vb);

        b = (b+1) % m;
        ba++;

        //b = Advance (verbose, b, &ba, m, inflag == IN_Q, vb->x, vb->y);
      }
    }
    else
    {
      if (aHB)
      {
        if (inflag == IN_Q) dest->add_vertex (*vb);

        b = (b+1) % m;
        ba++;

        //b = Advance (verbose, b, &ba, m, inflag == IN_Q, vb->x, vb->y);
      }
      else
      {
        if (inflag == IN_P)
        {
          if (va->in_poly_2d (Q, m, box) == POLY_OUT) inflag = IN_Q;
          else dest->add_vertex (*va);
        }

        a = (a+1) % n;
        aa++;

        //a = Advance (verbose, a, &aa, n, inflag == IN_P, va->x, va->y);
      }
    }
  }
  // Quit when both adv. indices have cycled, or one has cycled twice. 
  while ( ((aa < n) || (ba < m)) && (aa < n+n) && (ba < m+m) );

  // Deal with special cases.
  if (inflag == IN_UNKNOWN) 
  {
    // The boundaries of P and Q do not cross.
    if (vertices[0].in_poly_2d (Q, m, box) != POLY_OUT)
    {
      // P is in Q. This poly need not be clipped.
      for (i = 0 ; i < num_vertices ; i++) dest->add_vertex (vertices[i]);
    }
    else
    {
      if (Q[0].in_poly_2d (vertices, n, &bbox) != POLY_OUT)
      {
        // Q is in P.
        for (i = 0 ; i < m ; i++) dest->add_vertex (Q[i]);
      }
      else
        // P and Q are independent.
        return FALSE;
    }
  }

  return TRUE;
}

ViewPolygon* Polygon2D::create_view ()
{
  if (!num_vertices) return NULL;

  ViewPolygon* view = new ViewPolygon (20);
  int i;

  for (i = 0 ; i < num_vertices ; i++)
    view->add_vertex (vertices[i]);

  return view;
}

void Polygon2D::draw (int col)
{
  int i;
  int x1, y1, x2, y2;

  if (!num_vertices) return;

  x1 = QRound (vertices[num_vertices-1].x);
  y1 = QRound (vertices[num_vertices-1].y);
  for (i = 0 ; i < num_vertices ; i++)
  {
    x2 = QRound (vertices[i].x);
    y2 = QRound (vertices[i].y);
    Scan::g->SetLine (x1, y1, x2, y2, col);

    x1 = x2;
    y1 = y2;
  }
}

void Polygon2D::draw_filled (Polygon3D* poly, int use_z_buf)
{
  int i;
  float sy1, sy2;
  int yy1, yy2;
  float sy;
  float P1, P2, P3, P4;
  float Q1, Q2, Q3, Q4;
  unsigned char* d;
  int yy, xxL;
  int max_i, min_i;
  float max_y, min_y;
  float min_z;
  unsigned long* z_buf;
  float inv_z, u_div_z, v_div_z;
  void (*dscan) (int len, unsigned char* d, unsigned long* z_buf,
                float inv_z, float u_div_z, float v_div_z,
                float dM, float dJ1, float dK1);

  if (num_vertices < 3) return;

  // Get the plane normal of the polygon. Using this we can calculate
  // '1/z' at every screen space point.
  float Ac, Bc, Cc, Dc, inv_Dc;
  poly->get_camera_normal (&Ac, &Bc, &Cc, &Dc);
  inv_Dc = 1/Dc;
  float M = -Ac*inv_Dc*(1./ASPECT);
  float N = -Bc*inv_Dc*(1./ASPECT);
  float O = -Cc*inv_Dc;

  // Compute the min_y and max_y for this polygon in screen space coordinates.
  // We are going to use these to scan the polygon from top to bottom.
  // Also compute the min_z in camera space coordinates. This is going to be
  // used for mipmapping.
  min_i = max_i = 0;
  min_y = max_y = vertices[0].y;
  min_z = M*(vertices[0].x-FRAME_WIDTH/2) + N*(vertices[0].y-FRAME_HEIGHT/2) + O;
  for (i = 1 ; i < num_vertices ; i++)
  {
    if (vertices[i].y > max_y)
    {
      max_y = vertices[i].y;
      max_i = i;
    }
    else if (vertices[i].y < min_y)
    {
      min_y = vertices[i].y;
      min_i = i;
    }
    inv_z = M*(vertices[i].x-FRAME_WIDTH/2) + N*(vertices[i].y-FRAME_HEIGHT/2) + O;
    if (inv_z > min_z) min_z = inv_z;
  }

  // Mipmapping.
  PolyTexture* tex;
  if (poly->get_no_mipmap () || Scan::textures->mipmapped == 0) tex = poly->get_polytex (0);
  else if (Scan::textures->mipmapped == 1) tex = poly->get_polytex ((float)1./min_z); // @@@ Don't use 1/z
  else tex = poly->get_polytex (3);
  PolyPlane* pl = poly->get_plane ();
  cache.use_texture (tex, Scan::textures);
  Scan::init_draw (poly, tex);

  // @@@ The texture transform matrix is currently written as T = M*(C-V)
  // (with V being the transform vector, M the transform matrix, and C
  // the position in camera space coordinates. It would be better (more
  // suitable for the following calculations) if it would be written
  // as T = M*C - V.
  P1 = pl->m_cam2tex.m11;
  P2 = pl->m_cam2tex.m12;
  P3 = pl->m_cam2tex.m13;
  P4 = -(P1*pl->v_cam2tex.x + P2*pl->v_cam2tex.y + P3*pl->v_cam2tex.z);
  Q1 = pl->m_cam2tex.m21;
  Q2 = pl->m_cam2tex.m22;
  Q3 = pl->m_cam2tex.m23;
  Q4 = -(Q1*pl->v_cam2tex.x + Q2*pl->v_cam2tex.y + Q3*pl->v_cam2tex.z);

  if (Scan::tmap2)
  {
    P1 *= Scan::tw; P2 *= Scan::tw; P3 *= Scan::tw; P4 *= Scan::tw;
    Q1 *= Scan::th; Q2 *= Scan::th; Q3 *= Scan::th; Q4 *= Scan::th;
    P4 -= Scan::fdu; Q4 -= Scan::fdv;
  }

  // Precompute everything so that we can calculate (u,v) (texture space
  // coordinates) for every (sx,sy) (screen space coordinates). We make
  // use of the fact that 1/z, u/z and v/z are linear in screen space.
  float R1 = P1*(1./ASPECT);
  float R2 = P2*(1./ASPECT);
  float S1 = Q1*(1./ASPECT);
  float S2 = Q2*(1./ASPECT);

  float J1 = R1+P4*M;
  float J2 = R2+P4*N;
  float J3 = P3+P4*O;
  float K1 = S1+Q4*M;
  float K2 = S2+Q4*N;
  float K3 = Q3+Q4*O;

  // Steps for interpolating horizontally accross a scanline.
  float dM = M*INTERPOL_STEP;
  float dJ1 = J1*INTERPOL_STEP;
  float dK1 = K1*INTERPOL_STEP;

  // Select the right scanline drawing function.
  if (Scan::textures->textured)
  {
    if (use_z_buf)
    {
      if (Scan::tmap2) dscan = Scan::draw_scanline_z_buf_map;
      else dscan = Scan::draw_scanline_z_buf;
    }
    else if (Scan::texture->get_filtered ()) dscan = Scan::draw_scanline_filtered;
    else if (Scan::texture->get_transparent () != -1) dscan = Scan::draw_scanline_transp;
    else if (Scan::tmap2) dscan = Scan::draw_scanline_map;
    else dscan = Scan::draw_scanline;
  }
  else
  {
    if (use_z_buf) dscan = Scan::draw_scanline_z_buf_flat;
    else dscan = Scan::draw_scanline_flat;
  }

  // Scan both sides of the polygon at once.
  // We start with two pointers at the top (as seen in y-inverted
  // screen-space: bottom of display) and advance them until both
  // join together at the bottom. The way this algorithm works, this
  // should happen automatically; the left pointer is only advanced
  // when it is farther away from the bottom than the right pointer
  // and vice versa.
  // Using this we effectively partition our polygon in trapezoids
  // with at most two triangles (one at the top and one at the bottom).
# define BOTH 0
# define LEFT 1
# define RIGHT 2
  int iL, iR, advance;
  float dd;
  float syL, sx1L, sx2L, dL, sxL;
  int yyL;
  float syR, sx1R, sx2R, dR, sxR;
  int yyR;

  sy1 = vertices[max_i].y;
  yy1 = QRound (sy1);
  sx1L = sx1R = vertices[max_i].x;

  iL = (max_i-1+num_vertices)%num_vertices;
  iR = (max_i+1)%num_vertices;

  syL = vertices[iL].y;
  yyL = QRound (syL);

  syR = vertices[iR].y;
  yyR = QRound (syR);

  for (;;)
  {
    if (yyL == yyR)
    {
      sy2 = syL;
      yy2 = yyL;
      sx2L = vertices[iL].x;
      sx2R = vertices[iR].x;

      advance = BOTH;
    }
    else if (yyL < yyR)
    {
      sy2 = syR;
      yy2 = yyR;
      sx2R = vertices[iR].x;
      if (ABS (syL-sy1) < EPSILON)
        sx2L = sx1L;
      else
        sx2L = (vertices[iL].x-sx1L) * (sy2-sy1) / (syL-sy1) + sx1L;

      advance = RIGHT;
    }
    else
    {
      sy2 = syL;
      yy2 = yyL;
      sx2L = vertices[iL].x;
      if (ABS (syR-sy1) < EPSILON)
        sx2R = sx1R;
      else
        sx2R = (vertices[iR].x-sx1R) * (sy2-sy1) / (syR-sy1) + sx1R;

      advance = LEFT;
    }

    // We are now drawing a trapezoid defined by:
    //   - floating point perspective corrected screen coordinates (screen space):
    //         (sx1L,sy1) - (sx1R,sy1)
    //              |            |
    //         (sx2L,sy2) - (sx2R,sy2)

    if (ABS (sy1-sy2) < 1.0)
    {
      // The trapezoid is not very high. This is a seperate case to
      // eliminate overflow errors in this case.
      sy = (float)(yy1-FRAME_HEIGHT/2);
      xxL = QRound (sx1L);
      sxL = (float)(xxL-FRAME_WIDTH/2);

      // d = graphicsData+FRAME_WIDTH*(FRAME_HEIGHT-yy1)+xxL;
      d = PixelAt (xxL, FRAME_HEIGHT-yy1);
      z_buf = Scan::z_buffer+FRAME_WIDTH*(FRAME_HEIGHT-yy1)+xxL;

      inv_z = M*sxL + N*sy + O;
      u_div_z = J1*sxL + J2*sy + J3;
      v_div_z = K1*sxL + K2*sy + K3;

      dscan (QRound (sx1R-sx1L)+1, d, z_buf, inv_z, u_div_z, v_div_z, dM, dJ1, dK1);
    }
    else
    {
      dd = 1 / (sy2-sy1);

      // Instead of using sy1-FRAME_HEIGHT/2 which would give a more
      // 'accurate' result, we use yy1 which is the rounded version.
      // This way we vastly increase the precision of the texture mapper.
      // The result of this is that the textures are now rock-steady
      // while moving; even in low-resolution.
      // Something similar is done for sxL and sxR.
      sxL = (float)QRound (sx1L-FRAME_WIDTH/2);
      sxR = (float)QRound (sx1R-FRAME_WIDTH/2);
      sy = (float)(yy1-FRAME_HEIGHT/2);
      dL = (sx2L-sx1L)*dd;
      dR = (sx2R-sx1R)*dd;

      // Steps for interpolating vertically over scanlines.
      float vd_inv_z = dL*M+N;
      float vd_u_div_z = dL*J1+J2;
      float vd_v_div_z = dL*K1+K2;

      inv_z = M*sxL + N*sy + O;
      u_div_z = J1*sxL + J2*sy + J3;
      v_div_z = K1*sxL + K2*sy + K3;

      // @@@ There are still things that can be moved outside the loop.
      // But beware of problems with converting from float to int and rounding!

      for (yy = yy1 ; yy > yy2 ; yy--)
      {
        xxL = QRound (sxL+FRAME_WIDTH/2);

        //d = graphicsData+FRAME_WIDTH*(FRAME_HEIGHT-yy)+xxL;
        d = PixelAt (xxL, FRAME_HEIGHT-yy);
        z_buf = Scan::z_buffer+FRAME_WIDTH*(FRAME_HEIGHT-yy)+xxL;

        dscan (QRound (sxR-sxL)+1, d, z_buf, inv_z, u_div_z, v_div_z, dM, dJ1, dK1);

        sxL -= dL;
        sxR -= dR;
        inv_z -= vd_inv_z;
        u_div_z -= vd_u_div_z;
        v_div_z -= vd_v_div_z;
      }
    }

    if (iL == iR) break;

    if (advance == BOTH)
    {
      iL = (iL-1+num_vertices)%num_vertices;
      // To make sure that the two pointers will not accidentally miss each
      // other we only advance the right pointer if it is not equal to the
      // left one.
      if (iL != iR) iR = (iR+1)%num_vertices;
    }
    else if (advance == LEFT) iL = (iL-1+num_vertices)%num_vertices;
    else iR = (iR+1)%num_vertices;

    if (advance == BOTH || advance == LEFT)
    {
      syL = vertices[iL].y;
      yyL = QRound (syL);
    }
    if (advance == BOTH || advance == RIGHT)
    {
      syR = vertices[iR].y;
      yyR = QRound (syR);
    }

    sx1L = sx2L;
    sx1R = sx2R;
    sy1 = sy2;
    yy1 = yy2;
  }
}

void Polygon2D::dump (char* name)
{
  MSG (("Dump polygon 2D '%s':\n", name));
  MSG (("    num_vertices=%d  max_vertices=%d\n", num_vertices, max_vertices));
  int i;
  for (i = 0 ; i < num_vertices ; i++)
    MSG (("        v[%d]: (%2.2f,%2.2f)\n", i, vertices[i].x, vertices[i].y));
  fflush (stdout);
}

//---------------------------------------------------------------------------
