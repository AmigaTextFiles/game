/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  geometry.h: An abstraction for allowing multiple objects to share
 *  a vertex array
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

#ifndef _GEOMETRY_H_
#define _GEOMETRY_H_

#include "sable.h"

class Geometry {
 public:
	Geometry (int vertexCount, GLfloat *vertices, GLfloat *normals, int indexCount, GLuint *indices);
	virtual ~Geometry (void);
	
	void setVertexOffset (int offset);
	GLfloat *getVertices(void) { return _vertices; }
	GLfloat *getNormals(void) { return _normals; }
	int getVertexCount(void) { return _vertexCount; }
	virtual void render (void) = 0;
	
 protected:
	/* Only _indices is owned. */
	GLfloat *_vertices, *_normals;
	GLuint *_baseindices, *_indices;
	int _vertexCount, _indexCount;
};

class VertexCompiler {
 public:
	VertexCompiler(void);
	~VertexCompiler(void);
	void registerGeometry (Geometry *);
	void compile (void);
 private:
	GLfloat *_vertices, *_normals;
	bool _compiled;
	GLint _vertexCount;
};

#endif
