#ifndef CRATE_H
#define CRATE_H

/* Constants */
#define MAX_CRATE_VEL 30

struct crate
{

    /* Coordinates */
    int x;
    int y;

    /* Properties */
    int r;
    int g;
    int b;
    int size;

    /* Physics */
    int velocity;
    int moving;

} typedef crate;


#endif
