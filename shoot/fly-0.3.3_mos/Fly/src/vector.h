/* $Id: vector.h,v 1.2 2002/05/31 11:26:00 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __VECTOR__
#define __VECTOR__

#define VECTOR_CPY(dest, orig)  memcpy(dest, orig, sizeof(float)*3)

void Vector_crossprod(float *v1, float *v2, float *out); 
float Vector_mod(float *v);
float Vector_modxz(float *v);
float Vector_lengthxz(float *v1, float *v2);
void Vector_rotate(float *v, float alpha);
float Vector_projection(float *v1, float *v2);
void Vector_sub(float *v1, float *v2, float *out);
void Vector_acum(float *dest, float *org);
float Vector_dot_product(float *v1, float *v2);
void Vector_scale(float *dest, float d);
void Vector_normalize(float *v);
float Vector_modxz(float *v);
void Vector_rotate(float *v, float alpha);

#endif
