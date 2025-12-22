#ifndef CSOBJECT_H
#define CSOBJECT_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef SCRIPT_H
#include "script.h"
#endif

class Polygon3D;
class Sector;
class World;
class Camera;
class ViewPolygon;
class Textures;

// Crystal Space object:
#define CS_SECTOR 0
#define CS_THING 1
#define CS_COLLECTION 2

// CsObject is the toplevel class for all objects in the Crystal
// Space engine that can be manipulated by scripts. Currently the
// supported CsObjects are sectors, things and collections.
//
// CsObjects have names and a type (one of CS_...).
// Activate triggers are supported for CsObjects.
//
// All this is not proper object oriented design. CsObject should
// be implemented with virtual functions. But I'm a bit worried that
// this may cause a slowdown. After all these objects are going to
// be used in rather time-critical situations. Maybe I'm worrying
// for nothing.

class CsObject
{
protected:
  char name[30];
  int type;		// Type (CS_...).

  TriggerList activate_triggers;

public:
  CsObject (char* name, int type);
  ~CsObject ();

  int get_type () { return type; }
  char* get_name () { return name; }

  void new_activate_trigger (Script* script, CsObject* ob = NULL);
  void do_activate_triggers (World* w);
};

// A collection object is for conveniance of the script language.
// Objects are (currently) not really hierarchical in Crystal Space.
// A collection simulates a hierarchy. The script can then perform
// operations like 'move' and 'transform' on all the objects in
// the collection together.

class Collection : public CsObject
{
private:
  Collection* next;
  CsObject** objects;
  int num_objects;

public:
  Collection (char* name);
  ~Collection ();

  void set_next (Collection* n) { next = n; }
  Collection* get_next () { return next; }

  void set_move (Sector* home, Vector3& v) { set_move (home, v.x, v.y, v.z); }
  void set_move (Sector* home, float x, float y, float z);
  void set_transform (Matrix3& matrix);
  void move (float dx, float dy, float dz);
  void move (Vector3& v) { move (v.x, v.y, v.z); }
  void transform (Matrix3& matrix);
  void transform ();

  CsObject* find_object (char* name);

  void save (FILE* fp, int indent);
  void load (World* w, char** buf);
};

#endif /*CSOBJECT_H*/
