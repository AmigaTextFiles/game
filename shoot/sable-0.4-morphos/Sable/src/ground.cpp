/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  ground.cpp: The infinite plasma fractal representing the ground
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#include "sable.h"

#include <stdlib.h>
#include <math.h>
#include "ground.h"
#include "textures.h"

Ground ground;
GLfloat ground_speed;

void
Ground::init (void)
{
	offset = 0.0f;
	fillSquare(0, true);
	fillSquare(64, false);
	fillSquare(128, false);
	ground_speed = 0.5;
}

void
Ground::scroll (void)
{
	offset += ground_speed; 
	if (offset > 1024.0f)
	{
		offset -= 1024.0f;
		for (int i = 0; i < 129; i++) {
			for (int j = 0; j < 65; j++) {
				height[i][j] = height[i+64][j];
				r[i][j] = r[i+64][j];
				g[i][j] = g[i+64][j];
			}
		}
		fillSquare(128, false);
	}
}

static inline void
cross_accum (GLfloat *a, GLfloat *b, GLfloat *dest)
{
	GLfloat c[3], size;
	c[0] = a[1]*b[2] - a[2]*b[1];
	c[1] = a[2]*b[0] - a[0]*b[2];
	c[2] = a[0]*b[1] - a[1]*b[0];
	size = sqrt (c[0]*c[0]+c[1]*c[1]+c[2]*c[2]);
	dest[0] += c[0] / size;
	dest[1] += c[1] / size;
	dest[2] += c[2] / size;
}

void
Ground::fillSquare (int offset, bool first)
{
	/* Clear the grid (except for the first line, unless this is
	 * the initial state */
	int start=offset, limit = offset+65;
	if (!first) start++;
	for (int i = start; i < limit; i++) {
		for (int j = 0; j < 65; j++) {
			height[i][j] = 0;
		}
	}
	/* Initialize the corners. */
	height[offset+64][0] = (random() % 32) - 65.0f;
	height[offset+64][64] = (random() % 32) - 65.0f;
	if (first) {
		height[offset][0] = (random() % 32) - 65.0f;
		height[offset][64] = (random() % 32) - 65.0f;
	}
	GLfloat displacement = 128.0f;
	for (int size = 64; size > 1; size >>= 1) {
		int mid = size >> 1;
		/* Diamond step */
		for (int x = mid; x < 65; x += size) {
			for (int y = mid; y < 65; y += size) {
				GLfloat total;
				total = height[offset+x-mid][y-mid];
				total += height[offset+x-mid][y+mid];
				total += height[offset+x+mid][y-mid];
				total += height[offset+x+mid][y+mid];
				GLfloat down = height[offset+x-mid][y];
				if (down < -20.0f) {
					total += down;
					total /= 5.0f;
				} else {
					total /= 4.0f;
				}
				total += (GLfloat)((random() % 2048)-1024) * displacement / 1024.0f;
				/* clamp */
				if (total > -33.0f) total = -33.0f;
				else if (total < -65.0f) total = -65.0f;
				height[offset+x][y] = total;
			}
		}
		/* Square step */
		for (int x = 0; x < 65; x += mid) {
			for (int y = 0; y < 65; y += mid) {
				/* Skip predefined points */
				if (height[offset+x][y] < -20.0f)
					continue;
				GLfloat total;
				int x1 = x-mid, x2 = x+mid;
				int y1 = y-mid, y2 = y+mid;
				while (x1 < 0) x1 += 64;
				while (x1 > 64) x1 -= 64;
				while (x2 < 0) x2 += 64;
				while (x2 > 64) x2 -= 64;
				while (y1 < 0) y1 += 64;
				while (y1 > 64) y1 -= 64;
				while (y2 < 0) y2 += 64;
				while (y2 > 64) y2 -= 64;
				x1 += offset; x2 += offset;
				total = height[x1][y];
				total += height[x2][y];
				total += height[offset+x][y1];
				total += height[offset+x][y2];
				total /= 4.0f;
				total += (GLfloat)((random() % 2048)-1024) * displacement / 1024.0f;
				/* clamp */
				if (total > -33.0f) total = -33.0f;
				else if (total < -65.0f) total = -65.0f;
				height[offset+x][y] = total;
			}
		}
		/* Lower displacement */
		displacement /= 2.0;
	}
	/* Generate color maps */
	GLfloat f[3], b[3], l[3], rt[3];
	f[0] = 16.0; f[2] = 0.0;
	b[0] = -16.0; b[2] = 0.0;
	rt[2] = 16.0; rt[0] = 0.0;
	l[2] = -16.0; l[0] = 0.0;
	
	for (int i = 0; i < 65; i++)
	{
		for (int j = 0; j < 65; j++)
		{
			GLfloat val = height[offset+i][j];
			val = (val + 65.0f) / 32.0f;
			/* Compute vertex normal */
			int x1 = i-1, x2 = i+1;
			int y1 = j-1, y2 = j+1;
			while (x1 < 0) x1 += 64;
			while (x1 > 64) x1 -= 64;
			while (x2 < 0) x2 += 64;
			while (x2 > 64) x2 -= 64;
			while (y1 < 0) y1 += 64;
			while (y1 > 64) y1 -= 64;
			while (y2 < 0) y2 += 64;
			while (y2 > 64) y2 -= 64;
			x1 += offset; x2 += offset;
			int x = i + offset, y = j;
			GLfloat n[3];
			n[0] = n[1] = n[2] = 0.0;
			f[1] = height[x2][y] - height[x][y];
			b[1] = height[x1][y] - height[x][y];
			l[1] = height[x][y1] - height[x][y];
			rt[1] = height[x][y2] - height[x][y];

			cross_accum (f, l, n);
			cross_accum (l, b, n);
			cross_accum (b, rt, n);
			cross_accum (rt, f, n);
			n[0] /= 12.0;
			n[1] /= 6.0;
			n[2] /= 6.0;
			GLfloat lighting = fabs (n[0] + n[1] + n[2]);
			lighting = 0.5 + (lighting / 2.0f);
			r[x][y] = (val * 0.3f * lighting) + 0.2;
			g[x][y] = ((1.0f - (val * 0.75f)) * lighting)+0.2;
			
		}
	}
}

#define GROUND_MINX -100
void
Ground::render (void)
{
	glEnable (GL_TEXTURE_2D);
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
	select_texture(GROUND_TEX);
	glBegin (GL_TRIANGLES);
	glNormal3f(0.0, 1.0, 0.0);
	int i_start = (int)((512.0f+(GROUND_MINX)+offset) / 16.0f);
	for (int i = i_start; i < 192; i++) {
		for (int j = 0; j < 64; j++) {
			GLfloat x1 = -512.0f-offset+i*16.0f, x2 = x1 + 16.0f;
			GLfloat z1 = -512.0f+j*16.0f, z2 = z1 + 16.0f;
			GLfloat tx1 = i / 16.0f, tx2 = tx1 + (1.0f / 16.0f);
			GLfloat tz1 = j / 16.0f, tz2 = tz1 + (1.0f / 16.0f);

			GLfloat y11 = height[i][j], y12 = height[i][j+1];
			GLfloat y21 = height[i+1][j], y22 = height[i+1][j+1];

			GLfloat r11 = r[i][j], r12 = r[i][j+1];
			GLfloat r21 = r[i+1][j], r22 = r[i+1][j+1];

			GLfloat g11 = g[i][j], g12 = g[i][j+1];
			GLfloat g21 = g[i+1][j], g22 = g[i+1][j+1];

			glTexCoord2f(tx1, tz2); 
			glColor3f (r12, g12, 0.2f);
			glVertex3f(x1, y12, z2);
			glTexCoord2f(tx2, tz1); 
			glColor3f (r21, g21, 0.2f);
			glVertex3f(x2, y21, z1);
			glTexCoord2f(tx1, tz1); 
			glColor3f (r11, g11, 0.2f);
			glVertex3f(x1, y11, z1);
			
			glTexCoord2f(tx1, tz2); 
			glColor3f (r12, g12, 0.2f);
			glVertex3f(x1, y12, z2);
			glTexCoord2f(tx2, tz2); 
			glColor3f (r22, g22, 0.2f);
			glVertex3f(x2, y22, z2);
			glTexCoord2f(tx2, tz1); 
			glColor3f (r21, g21, 0.2f);
			glVertex3f(x2, y21, z1);
		}
	}
	glEnd ();
	glDisable (GL_TEXTURE_2D);
}
