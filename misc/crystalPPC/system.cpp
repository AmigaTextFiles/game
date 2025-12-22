#ifndef DEF_H
#include "def.h"
#endif

#ifndef SYSTEM_H
#include "system.h"
#endif

#ifndef CONFIG_H
#include "config.h"
#endif

char *graphicsData;
colorRGB graphicsPalette[255];
int graphicsPalette_alloc[256];

System::System(int argc, char *argv[])
{
  Graph = new Graphics(argc, argv);
  Key = new Keyboard(argc, argv);
}

System::~System(void)
{
  Close();
}

int System::Open(void)
{
  if(Graph->Open() && Key->Open()) return (1);
  return (0);
}

void System::Close(void)
{
  Key->Close();
  Graph->Close();
}

// void System::Loop() redefined
/*
 * Get a rgb value.
 */
void GetRGB (int i, int* r, int* g, int* b)
{
  *r = graphicsPalette[i].red ;
  *g = graphicsPalette[i].green;
  *b = graphicsPalette[i].blue;
}

/*
 * Find the color best matching the given red/green/blue values.
 */
int worst_r, worst_g, worst_b;
int worst_distance = -1;
int worst2_r, worst2_g, worst2_b;
int worst2_distance = -1;
int worst3_r, worst3_g, worst3_b;
int worst3_distance = -1;
int worst4_r, worst4_g, worst4_b;
int worst4_distance = -1;
int worst5_r, worst5_g, worst5_b;
int worst5_distance = -1;

int rgb_stats[256];

void dump_rgb_usage_stats ()
{
  int i;

  printf ("Print color statistics:\n");
  for (i = 0 ; i < 256 ; i++)
    printf ("Color %d with rgb %d,%d,%d is used %d times.\n", i,
	    graphicsPalette[i].red, graphicsPalette[i].green, graphicsPalette[i].blue, rgb_stats[i]);
  printf ("Worst        r,g,b value: %d,%d,%d (distance %d)\n",
	  worst_r, worst_g, worst_b, worst_distance);
  printf ("Second Worst r,g,b value: %d,%d,%d (distance %d)\n",
	  worst2_r, worst2_g, worst2_b, worst2_distance);
  printf ("Third Worst  r,g,b value: %d,%d,%d (distance %d)\n",
	  worst3_r, worst3_g, worst3_b, worst3_distance);
  printf ("Fourth Worst r,g,b value: %d,%d,%d (distance %d)\n",
	  worst4_r, worst4_g, worst4_b, worst4_distance);
  printf ("Fifth Worst  r,g,b value: %d,%d,%d (distance %d)\n",
	  worst5_r, worst5_g, worst5_b, worst5_distance);
  printf ("Done!\n");
}

int find_rgb (int r, int g, int b)
{
  static int first_rgb = TRUE;
  int i;
  int pr, pg, pb;
  int max, best, min_best;
  int dr, dg, db;

  if (first_rgb)
  {
    for (i = 0 ; i < 256 ; i++)
      rgb_stats[i] = 0;
    first_rgb = FALSE;
  }

  best = 0;
  min_best = 1000;
  for (i = 0 ; i < 256 ; i++)
  {
    if (graphicsPalette_alloc[i])
    {
      pr = graphicsPalette[i].red;
      pg = graphicsPalette[i].green;
      pb = graphicsPalette[i].blue;
      dr = ABS (pr-r);
      dg = ABS (pg-g);
      db = ABS (pb-b);
      max = MAX (dr, dg);
      max = MAX (db, max);
      if (max < min_best)
      {
	best = i;
	min_best = max;
      }
    }
  }

  if (min_best > worst_distance)
  {
    worst5_r = worst4_r;
    worst5_g = worst4_g;
    worst5_b = worst4_b;
    worst5_distance = worst4_distance;
    worst4_r = worst3_r;
    worst4_g = worst3_g;
    worst4_b = worst3_b;
    worst4_distance = worst3_distance;
    worst3_r = worst2_r;
    worst3_g = worst2_g;
    worst3_b = worst2_b;
    worst3_distance = worst2_distance;
    worst2_r = worst_r;
    worst2_g = worst_g;
    worst2_b = worst_b;
    worst2_distance = worst_distance;
    worst_r = r;
    worst_g = g;
    worst_b = b;
    worst_distance = min_best;
  }
  rgb_stats[best]++;
  return best;
}
