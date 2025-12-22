#ifndef WORLD_H
#define WORLD_H

class Sector;
class Textures;
class PolyPlane;
class Script;
class ScriptRun;
class Vertex;
class Polygon3D;
class ViewPolygon;
class Camera;
class Graphics;
class PolygonSet;
class Thing;
class Collection;
class CsObject;

class World
{
private:
  Sector* first_sector;
  Textures* textures;
  PolyPlane* first_plane;
  Script* first_script;
  ScriptRun* first_run;
  Collection* first_collection;

public:
  World ();
  ~World ();

  void clear ();

  Sector* new_sector (char* name, int max_v, int max_p);
  Sector* get_sector (char* name);
  Textures* new_textures (int max);
  Textures* get_textures () { return textures; }

  Collection* new_collection (char* name);
  Collection* get_collection (char* name);

  PolyPlane* new_plane (char* name);
  PolyPlane* get_plane (char* name);

  Thing* get_thing (char* name);

  Script* new_script (char* name);
  Script* get_script (char* name);
  ScriptRun* run_script (Script* s, CsObject* ps);
  void step_scripts ();

  void trigger_activate (Camera& c);

  void draw (Graphics* g, Camera* c, ViewPolygon* view);

  void save (FILE* fp, int indent);
  void save (char* name);
  void load (char** buf);
  void load (char* name);

  Polygon3D* select_polygon (Camera* c, ViewPolygon* view, int xx, int yy);
  Vertex* select_vertex (Camera* c, ViewPolygon* view, int xx, int yy);

  void edit_split_poly (Camera* c);

  void shine_lights ();
  void mipmap_settings (int setting);
};

#endif /*WORLD_H*/
