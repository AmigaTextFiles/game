#ifndef GST_DIRECTIONS_H
#define GST_DIRECTIONS_H

typedef enum 
{
  sud = 0, 
  ouest, nord, est,
  nbre_de_directions
} type_directions;

typedef struct type_position 
{
  int x, y;
} type_position;

/* Pour chacune des directions, indique le signe de x et de y du vecteur */
extern type_position valeurs_directions [nbre_de_directions];


#endif /* GST_DIRECTIONS_H */
