#include <math.h>

void Vector_crossprod(float *v1, float *v2, float *out) 
{
    out[0] = v1[1] * v2[2] - v1[2] * v2[1];
    out[1] = v1[2] * v2[0] - v1[0] * v2[2];
    out[2] = v1[0] * v2[1] - v1[1] * v2[0];
}

float Vector_modxz(float *v)
{
    return sqrt(v[0] * v[0] + v[2] * v[2]);
}

float Vector_mod(float *v)
{
    return sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
}

float Vector_lengthxz(float *v1, float *v2)
{
    return sqrt((v2[0]-v1[0])*(v2[0]-v1[0])+(v2[2]-v1[2])*(v2[2]-v1[2]));
}

void Vector_normalize(float *v)
{
    float mod = Vector_mod(v);
    v[0] = v[0] / mod;
    v[1] = v[1] / mod;
    v[2] = v[2] / mod;
}

void Vector_sub(float *v1, float *v2, float *out)
{
    out[0] = v1[0] - v2[0];
    out[1] = v1[1] - v2[1];
    out[2] = v1[2] - v2[2];
}


float Vector_dot_product(float *v1, float *v2)
{
    return ( v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2]);
}

/*
 * Projection of v1 over v2
 */
float Vector_projection(float *v1, float *v2)
{
    return Vector_dot_product(v1, v2) / Vector_mod(v2);
}


void Vector_sum(float *v1, float *v2, float *out)
{
    out[0] = v1[0] + v2[0];
    out[1] = v1[1] + v2[1];
    out[2] = v1[2] + v2[2];
}

void Vector_acum(float *dest, float *org)
{
    dest[0] += org[0];
    dest[1] += org[1];
    dest[2] += org[2];
}

void Vector_scale(float *dest, float d)
{
    dest[0] *= d;
    dest[1] *= d;
    dest[2] *= d;
}


/*
 * Rotates the 'v' point alpha radians
 */
void Vector_rotate(float *v, float alpha)
{   
    float x,y;
    
    alpha = -alpha;
    
    x = v[0] * cos(alpha) - v[2] * sin(alpha);
    y = v[0] * sin(alpha) + v[2] * cos(alpha);

    v[0] = x; v[2] = y;
}

