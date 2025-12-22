#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "array.h"

int **
array2_new(int size_x, int size_y)
{
  int x;
  int **p = NULL;

  if (size_x <= 0)
  {
    fprintf(stderr, "array2_new: size_x is non-positive (%d)\n", size_x);
    return NULL;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "array2_new: size_y is non-positive (%d)\n", size_y);
    return NULL;
  }

  p = (int **) malloc(sizeof(int *) * size_x);
  if (p == NULL)
  {
    fprintf(stderr, "array2_new: malloc(p) failed\n");
    return NULL;
  }
  for (x = 0; x < size_x; x++)
    p[x] = NULL;

  for (x = 0; x < size_x; x++)
  {
    p[x] = (int *) malloc(sizeof(int) * size_y);
    if (p[x] == NULL)
    {
      fprintf(stderr, "array2_new: malloc(p[%d]) failed\n", x);
      array2_delete(p, size_x, size_y);
      p = NULL;
      return NULL;
    }
  }

  return p;
}

void
array2_delete(int **p, int size_x, int size_y)
{
  int x;
  if (p == NULL)
    return;

  for (x = 0; x < size_x; x++)
  {
    if (p[x] != NULL)
    {
      free(p[x]);
      p[x] = NULL;
    }
  }

  free(p);
  p = NULL;
}

int ***
array3_new(int size_z, int size_x, int size_y)
{
  int z;
  int ***p = NULL;

  if (size_z <= 0)
  {
    fprintf(stderr, "array3_new: size_z is non-positive (%d)\n", size_z);
    return NULL;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "array3_new: size_x is non-positive (%d)\n", size_x);
    return NULL;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "array3_new: size_y is non-positive (%d)\n", size_y);
    return NULL;
  }

  p = (int ***) malloc(sizeof(int **) * size_z);
  if (p == NULL)
  {
    fprintf(stderr, "array3_new: malloc failed\n");
    return NULL;
  }
  for (z = 0; z < size_z; z++)
    p[z] = NULL;

  for (z = 0; z < size_z; z++)
  {
    p[z] = array2_new(size_x, size_y);
    if (p[z] == NULL)
    {
      fprintf(stderr, "array3_new: array2_new(%d) failed\n", z);
      array3_delete(p, size_z, size_x, size_y);
      p = NULL;
      return NULL;
    }
  }

  return p;
}

void
array3_delete(int ***p, int size_z, int size_x, int size_y)
{
  int z;

  if (p == NULL)
    return;

  for (z = 0; z < size_z; z++)
  {
    if (p[z] != NULL)
    {
      array2_delete(p[z], size_x, size_y);
      p[z] = NULL;
    }
  }

  free(p);
  p = NULL;
}

