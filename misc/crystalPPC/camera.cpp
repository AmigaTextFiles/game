#include <math.h>
#include <time.h>

#ifndef SYSTEM_H
#include "system.h"
#endif

#ifndef DEF_H
#include "def.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

//---------------------------------------------------------------------------

Camera::Camera ()
{
  m_world2cam.identity ();
  v_world2cam.x = 0;
  v_world2cam.y = 0;
  v_world2cam.z = 0;
  m_cam2world = m_world2cam;
  m_cam2world.inverse ();
  edit_mode = MODE_NONE;
  sel_polygon = NULL;
  num_sel_verts = 0;
  light_lev = 200;
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

Camera::~Camera ()
{
}

void Camera::save_file (char* filename)
{
  FILE* fp = fopen (filename, "w");
  fprintf (fp, "%f %f %f\n", v_world2cam.x, v_world2cam.y, v_world2cam.z);
  fprintf (fp, "%f %f %f\n", m_world2cam.m11, m_world2cam.m12, m_world2cam.m13);
  fprintf (fp, "%f %f %f\n", m_world2cam.m21, m_world2cam.m22, m_world2cam.m23); 
  fprintf (fp, "%f %f %f\n", m_world2cam.m31, m_world2cam.m32, m_world2cam.m33);
  fprintf (fp, "%s\n", sector->get_name ());
  fclose (fp);
}

void Camera::load_file (World* world, char* filename)
{
  char buf[100];
  FILE* fp = fopen (filename, "r");
  fscanf (fp, "%f %f %f\n", &v_world2cam.x, &v_world2cam.y, &v_world2cam.z);
  fscanf (fp, "%f %f %f\n", &m_world2cam.m11, &m_world2cam.m12, &m_world2cam.m13);
  fscanf (fp, "%f %f %f\n", &m_world2cam.m21, &m_world2cam.m22, &m_world2cam.m23); 
  fscanf (fp, "%f %f %f\n", &m_world2cam.m31, &m_world2cam.m32, &m_world2cam.m33);
  fscanf (fp, "%s\n", buf);
  fclose (fp);
  m_cam2world = m_world2cam;
  m_cam2world.inverse ();
  sector = world->get_sector (buf);
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

void Camera::really_move (Vector3& new_position)
{
  Vector3 isect;
  Polygon3D* p = sector->intersect_segment (v_world2cam, new_position, isect);
  if (p)
  {
    if (p->get_portal ()) sector = p->get_portal ();
    else return; // Don't move, hit wall
  }
  v_world2cam = new_position;

  // Here we set our view position a small amount back. This should minimize
  // the problems with portal polygons that are too close by. The reason this
  // works and changing the SMALL_Z offset doesn't is as follows:
  //     The real position of our hero is located in some sector. If we are
  //     close to a portal polygon to another sector it is possible that
  //     the portal polygon will be clipped incorrectly to the Z plane and only
  //     part of the other portal will be seen. If we shift our view position
  //     back WITHOUT changing the sector we are in, we will in effect take
  //     a distance from the portal polygons.
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

void Camera::get_forward_position (float dist, Vector3& where)
{
  Vector3 pos (0, 0, 1); pos.z = dist;
  m_cam2world.transform (pos, where);
  where += v_world2cam;
}

Polygon3D* Camera::get_hit (Vector3& where)
{
  return sector->hit_beam (v_world2cam, where);
}

void Camera::forward (float dist)
{
  Vector3 pos (0, 0, dist);
  Vector3 new_position;
  m_cam2world.transform (pos, new_position);
  new_position += v_world2cam;
  really_move (new_position);
}

void Camera::up (float dist)
{
  Vector3 pos (0, dist, 0);
  Vector3 new_position;
  m_cam2world.transform (pos, new_position);
  new_position += v_world2cam;
  really_move (new_position);
}

void Camera::right (float dist)
{
  Vector3 pos (dist, 0, 0);
  Vector3 new_position;
  m_cam2world.transform (pos, new_position);
  new_position += v_world2cam;
  really_move (new_position);
}

void Camera::turn_around ()
{
  rot_right (M_PI);
}

void Camera::rot_right (float angle)
{
  Matrix3 rot (0, 0, 0, 0, 1, 0, 0, 0, 0);
  rot.m11 =  cos (angle);
  rot.m13 = -sin (angle);
  rot.m31 =  sin (angle);
  rot.m33 =  cos (angle);
  rot *= m_world2cam;
  m_world2cam = rot;
  m_cam2world = rot;
  m_cam2world.inverse ();
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

void Camera::rot_up (float angle)
{
  Matrix3 rot (1, 0, 0, 0, 0, 0, 0, 0, 0);
  rot.m22 =  cos (angle);
  rot.m23 = -sin (angle);
  rot.m32 =  sin (angle);
  rot.m33 =  cos (angle);
  rot *= m_world2cam;
  m_world2cam = rot;
  m_cam2world = rot;
  m_cam2world.inverse ();
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

void Camera::rot_z_right (float angle)
{
  Matrix3 rot (0, 0, 0, 0, 0, 0, 0, 0, 1);
  rot.m11 =  cos (angle);
  rot.m12 = -sin (angle);
  rot.m21 =  sin (angle);
  rot.m22 =  cos (angle);
  rot *= m_world2cam;
  m_world2cam = rot;
  m_cam2world = rot;
  m_cam2world.inverse ();
  get_forward_position (SHIFT_VIEWPOINT, v_viewpos);
}

//---------------------------------------------------------------------------
