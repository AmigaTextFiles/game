#ifndef CAMERA_H
#define CAMERA_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class Sector;
class Polygon3D;
class Vertex;
class World;

#define MODE_NONE 0
#define MODE_EDIT 1
#define MODE_VERTEX 2
#define MODE_POLYGON 3
#define MODE_MOVE_VERTEX 4

#define MAX_SEL_VERTEX 20

#define SHIFT_VIEWPOINT -.3

class Camera
{
public:
  Matrix3 m_world2cam;
  Vector3 v_world2cam;
  Vector3 v_viewpos;
  Sector* sector;
  Matrix3 m_cam2world;
  int edit_mode;
  Polygon3D* sel_polygon;
  int num_sel_verts;
  Vertex* sel_vertex[MAX_SEL_VERTEX];
  int light_lev;

private:
  void really_move (Vector3& new_position);

public:
  Camera ();
  ~Camera ();

  void save_file (char* filename);
  void load_file (World* world, char* filename);

  void get_forward_position (float dist, Vector3& where);
  Polygon3D* get_hit (Vector3& where);

  void turn_around ();
  void forward (float dist);
  void backward (float dist) { forward (-dist); }
  void up (float dist);
  void down (float dist) { up (-dist); }
  void right (float dist);
  void left (float dist) { right (-dist); }
  void rot_right (float angle);
  void rot_left (float angle) { rot_right (-angle); }
  void rot_up (float angle);
  void rot_down (float angle) { rot_up (-angle); }
  void rot_z_right (float angle);
  void rot_z_left (float angle) { rot_z_right (-angle); }
};

#endif /*CAMERA_H*/
