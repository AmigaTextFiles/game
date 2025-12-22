/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  geometry.cpp: code for unifying objects into a single vertex array
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
#include <stdio.h>

#include "geometry.h"


Geometry::Geometry (int vertexCount, GLfloat *vertices, GLfloat *normals, 
		    int indexCount, GLuint *indices)
{
	_vertexCount = vertexCount;
	_indexCount = indexCount;
	_vertices = vertices;
	_normals = normals;
	_baseindices = indices;
	_indices = new GLuint[_indexCount];
	for (int i = 0; i < _indexCount; i++)
		_indices[i] = _baseindices[i];
}

Geometry::~Geometry (void)
{
	delete[] _indices;
}
	
void
Geometry::setVertexOffset (int offset)
{
	for (int i = 0; i < _indexCount; i++)
		_indices[i] = _baseindices[i] + offset;
}

VertexCompiler::VertexCompiler(void)
{
	_vertices = _normals = NULL;
	_compiled = false;
	_vertexCount = 0;
}

VertexCompiler::~VertexCompiler(void)
{
	if (_vertices)
		delete[] _vertices;
	if (_normals)
		delete[] _normals;
}

void
VertexCompiler::registerGeometry (Geometry *g)
{
	int newVertCount = g->getVertexCount ();
	int oldCount = _vertexCount * 3;
	int newCount = (_vertexCount + newVertCount) * 3;
	GLfloat *newVertices = new GLfloat[newCount * 3];
	GLfloat *newNormals = new GLfloat[newCount * 3];
	for (int i = 0; i < oldCount; i++) 
	{
		newVertices[i] = _vertices[i];
		newNormals[i] = _normals[i];
	}
	GLfloat *addedVertices = g->getVertices ();
	GLfloat *addedNormals = g->getNormals ();

	for (int i = oldCount; i < newCount; i++)
	{
		newVertices[i] = addedVertices[i-oldCount];
		newNormals[i] = addedNormals[i-oldCount];
	}
	if (_vertices)
		delete[] _vertices;
	if (_normals)
		delete[] _normals;
	_vertices = newVertices;
	_normals = newNormals;
	_vertexCount = newCount / 3;
	g->setVertexOffset (oldCount / 3);
}

void
VertexCompiler::compile (void)
{
	if (_vertices != NULL && !_compiled)
	{
		glEnable(GL_NORMALIZE);

		glVertexPointer (3, GL_FLOAT, 0, _vertices);
		glNormalPointer (GL_FLOAT, 0, _normals);

		_compiled = true;
	}
}

