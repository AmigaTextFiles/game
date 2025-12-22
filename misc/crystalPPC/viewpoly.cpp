#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef VIEWPOLY_H
#include "viewpoly.h"
#endif

//---------------------------------------------------------------------------

ViewPolygon::ViewPolygon (int num)
{
  max_vertices = num;
  bbox.start_bounding_box ();
  vertices = new Vector2 [num];
  num_vertices = 0;
}

ViewPolygon::~ViewPolygon ()
{
  if (vertices) delete [] vertices;
}

void ViewPolygon::add_vertex (float x, float y)
{
  vertices[num_vertices].x = x;
  vertices[num_vertices].y = y;
  num_vertices++;
  bbox.add_bounding_vertex (x, y);
}

void ViewPolygon::dump (char* name)
{
  MSG (("Dump view '%s':\n", name));
  MSG (("    num_vertices=%d  max_vertices=%d\n", num_vertices, max_vertices));
  MSG (("    Bounding box: ")); bbox.dump (); MSG (("\n"));
  int i;
  for (i = 0 ; i < num_vertices ; i++)
    MSG (("        vector2[%d]: (%2.2f,%2.2f)\n",
    	i,
    	vertices[i].x,
    	vertices[i].y));
  fflush (stdout);
}

//---------------------------------------------------------------------------
