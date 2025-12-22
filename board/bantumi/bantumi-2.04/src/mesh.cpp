/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include "mesh.h"
#include "glwrapper.h"
#include "math.h"
#include <string.h>
#include <stdio.h>
#include "matrix.h"

#ifndef M_PI
#define M_PI 3.141592654
#endif

Mesh::Mesh() {
	vertices = NULL;
	normals = NULL;
	faces = NULL;
	nVertices = nFaces = 0;
}
Mesh::~Mesh() {
	delete [] vertices;
	delete [] normals;
	delete [] faces;
}
void Mesh::draw() {
	glVertexPointer(3, GLTYPETOKEN, 0, vertices);
	glNormalPointer(GLTYPETOKEN, 0, normals);
	glDrawElements(GL_TRIANGLES, 3*nFaces, GL_UNSIGNED_SHORT, faces);
}
void Mesh::getDim(GLTYPE *dim) {
	GLTYPE xMin = 0, xMax = 0, yMin = 0, yMax = 0, zMin = 0, zMax = 0;
	for (int i = 0; i < nVertices; i++) {
		GLTYPE x = vertices[3*i+0];
		GLTYPE y = vertices[3*i+1];
		GLTYPE z = vertices[3*i+2];
		if (x < xMin) xMin = x;
		if (x > xMax) xMax = x;
		if (y < yMin) yMin = y;
		if (y > yMax) yMax = y;
		if (z < zMin) zMin = z;
		if (z > zMax) zMax = z;
	}
	dim[0] = xMax - xMin;
	dim[1] = yMax - yMin;
	dim[2] = zMax - zMin;
}
void Mesh::scale(GLTYPE x, GLTYPE y, GLTYPE z) {
	for (int i = 0; i < nVertices; i++) {
		MULBY(vertices[3*i+0], x);
		MULBY(vertices[3*i+1], y);
		MULBY(vertices[3*i+2], z);
		MULBY(normals[3*i+0], x);
		MULBY(normals[3*i+1], y);
		MULBY(normals[3*i+2], z);
		NORMALIZE3(&normals[3*i]);
	}
}

AggregateMesh::AggregateMesh(int n, Mesh *m) {
	copies = n;
	parent = m;
	nVertices = n*m->nVertices;
	nFaces = n*m->nFaces;
	vertices = new GLTYPE[3*nVertices];
	normals = new GLTYPE[3*nVertices];
	colors = new GLTYPE[4*nVertices];
	faces = new short[3*nFaces];
}

AggregateMesh::~AggregateMesh() {
	delete [] colors;
}

void AggregateMesh::draw() {
	if (copies == 0) return;
	glColorPointer(4, GLTYPETOKEN, 0, colors);
	Mesh::draw();
}

void AggregateMesh::setFaces() {
	for (int i = 0; i < copies; i++)
		for (int j = 0; j < 3*parent->nFaces; j++)
			faces[3*i*parent->nFaces+j] = parent->faces[j]+i*parent->nVertices;
}

void AggregateMesh::setColor(int n, const GLTYPE *color) {
	for (int i = 0; i < parent->nVertices; i++) {
		memcpy(&colors[4*n*parent->nVertices+4*i], color, sizeof(GLTYPE)*3);
		colors[4*n*parent->nVertices+4*i+3] = F(1);
	}
}

void AggregateMesh::setVertices(int n, const GLTYPE *matrix) {
	for (int i = 0; i < parent->nVertices; i++) {
		multVect3(&vertices[3*n*parent->nVertices+3*i], matrix, &parent->vertices[3*i], F(1));
		multVect3(&normals[3*n*parent->nVertices+3*i], matrix, &parent->normals[3*i], F(0));
	}
}


SphereMesh::SphereMesh(int rings, int segments) {
	nFaces = (rings-1)*segments*2 + 2*segments;
	nVertices = rings*segments+2;
	vertices = new GLTYPE[3*nVertices];
	normals = new GLTYPE[3*nVertices];
	faces = new short[3*nFaces];
	vertices[0*3+0] = F(0);
	vertices[0*3+1] = F(0);
	vertices[0*3+2] = F(1);
	vertices[(nVertices-1)*3+0] = F(0);
	vertices[(nVertices-1)*3+1] = F(0);
	vertices[(nVertices-1)*3+2] = F(-1);
	for (int i = 0; i < rings; i++) {
		float r = sin((i+1)*M_PI/(rings+1));
		float z = cos((i+1)*M_PI/(rings+1));
		for (int j = 0; j < segments; j++) {
			float x = r*sin(j*2*M_PI/segments);
			float y = r*cos(j*2*M_PI/segments);
			vertices[(1+i*segments+j)*3+0] = F(x);
			vertices[(1+i*segments+j)*3+1] = F(y);
			vertices[(1+i*segments+j)*3+2] = F(z);
		}
	}
	memcpy(normals, vertices, sizeof(GLTYPE)*nVertices*3);
	int face = 0;
	for (int i = 0; i < segments; i++) {
		faces[3*face+0] = 0;
		faces[3*face+1] = 1+((i+1)%segments);
		faces[3*face+2] = 1+i;
		face++;
	}
	for (int i = 0; i < (rings-1); i++) {
		for (int j = 0; j < segments; j++) {
			faces[3*face+0] = 1+i*segments+j;
			faces[3*face+1] = 1+i*segments+((j+1)%segments);
			faces[3*face+2] = 1+(i+1)*segments+j;
			face++;
			faces[3*face+0] = 1+i*segments+((j+1)%segments);
			faces[3*face+1] = 1+(i+1)*segments+((j+1)%segments);
			faces[3*face+2] = 1+(i+1)*segments+j;
			face++;
		}
	}
	for (int i = 0; i < segments; i++) {
		faces[3*face+0] = nVertices-1-segments+i;
		faces[3*face+1] = nVertices-1-segments+((i+1)%segments);
		faces[3*face+2] = nVertices-1;
		face++;
	}
}

static int getIndex(short *mapping, int v1, int v2, int *next, int nVertices) {
	int pos = nVertices*v1+v2;
	if (v1 > v2)
		pos = nVertices*v2+v1;
	if (mapping[pos] >= 0)
		return mapping[pos];
	mapping[pos] = *next;
	(*next)++;
	return mapping[pos];
}

static void averageNormalize(GLTYPE *out, const GLTYPE *v1, const GLTYPE *v2) {
	out[0] = v1[0] + v2[0];
	out[1] = v1[1] + v2[1];
	out[2] = v1[2] + v2[2];
	NORMALIZE3(out);
}

static void subdivide(int nVertices, int nFaces, GLTYPE *vertices, short *faces, GLTYPE *newVertices, short *newFaces) {
	int outFace = 0;
	int outVertex = 0;

	short *mapping = new short[nVertices*nVertices];
	for (int i = 0; i < nVertices*nVertices; i++)
		mapping[i] = -1;

	for (int i = 0; i < nFaces; i++) {
		int v1 = faces[3*i+0];
		int v2 = faces[3*i+1];
		int v3 = faces[3*i+2];
		int old = outVertex;
		int outv1 = getIndex(mapping, v1, v1, &outVertex, nVertices);
		int outv2 = getIndex(mapping, v1, v2, &outVertex, nVertices);
		int outv3 = getIndex(mapping, v2, v2, &outVertex, nVertices);
		int outv4 = getIndex(mapping, v2, v3, &outVertex, nVertices);
		int outv5 = getIndex(mapping, v3, v3, &outVertex, nVertices);
		int outv6 = getIndex(mapping, v3, v1, &outVertex, nVertices);
		if (outv1 >= old)
			memcpy(&newVertices[3*outv1], &vertices[3*v1], sizeof(GLTYPE)*3);
		if (outv2 >= old)
			averageNormalize(&newVertices[3*outv2], &vertices[3*v1], &vertices[3*v2]);
		if (outv3 >= old)
			memcpy(&newVertices[3*outv3], &vertices[3*v2], sizeof(GLTYPE)*3);
		if (outv4 >= old)
			averageNormalize(&newVertices[3*outv4], &vertices[3*v2], &vertices[3*v3]);
		if (outv5 >= old)
			memcpy(&newVertices[3*outv5], &vertices[3*v3], sizeof(GLTYPE)*3);
		if (outv6 >= old)
			averageNormalize(&newVertices[3*outv6], &vertices[3*v3], &vertices[3*v1]);
		newFaces[3*outFace+0] = outv1;
		newFaces[3*outFace+1] = outv2;
		newFaces[3*outFace+2] = outv6;
		outFace++;
		newFaces[3*outFace+0] = outv2;
		newFaces[3*outFace+1] = outv3;
		newFaces[3*outFace+2] = outv4;
		outFace++;
		newFaces[3*outFace+0] = outv2;
		newFaces[3*outFace+1] = outv4;
		newFaces[3*outFace+2] = outv6;
		outFace++;
		newFaces[3*outFace+0] = outv6;
		newFaces[3*outFace+1] = outv4;
		newFaces[3*outFace+2] = outv5;
		outFace++;
	}

	delete [] mapping;
}

TriSphereMesh::TriSphereMesh(int levels) {
	static const GLTYPE startVertices[] = {
		F(0), F(0), F(1),
		F(1), F(0), F(0),
		F(0), F(1), F(0),
		F(-1), F(0), F(0),
		F(0), F(-1), F(0),
		F(0), F(0), F(-1)
	};
	static const short startFaces[] = {
		0, 1, 2,
		0, 2, 3,
		0, 3, 4,
		0, 4, 1,
		5, 2, 1,
		5, 3, 2,
		5, 4, 3,
		5, 1, 4
	};
	nFaces = 8;
	nVertices = 6;
	vertices = new GLTYPE[3*nVertices];
	faces = new short[3*nFaces];
	memcpy(vertices, startVertices, sizeof(GLTYPE)*nVertices*3);
	memcpy(faces, startFaces, sizeof(short)*nFaces*3);

	while (levels > 0) {
		levels--;
		int newNVertices = 2+(nVertices-2)*4;
		int newNFaces = 4*nFaces;
		GLTYPE *newVertices = new GLTYPE[3*newNVertices];
		short *newFaces = new short[3*newNFaces];
		subdivide(nVertices, nFaces, vertices, faces, newVertices, newFaces);
		nVertices = newNVertices;
		nFaces = newNFaces;
		delete [] vertices;
		delete [] faces;
		vertices = newVertices;
		faces = newFaces;
	}

	normals = new GLTYPE[3*nVertices];
	memcpy(normals, vertices, sizeof(GLTYPE)*nVertices*3);
}

static void makeCircle(GLTYPE *out, int segments, float r, float z) {
	for (int i = 0; i < segments; i++) {
		out[i*3+0] = F(r*cos(i*2*M_PI/segments));
		out[i*3+1] = F(r*sin(i*2*M_PI/segments));
		out[i*3+2] = F(z);
	}
}

static void fillCircle(short *faces, int segments, int offset) {
	int left = offset;
	int right = offset+segments-1;
	int face = 0;
	while (left+2 < right) {
		faces[3*face+0] = left;
		faces[3*face+1] = left+1;
		faces[3*face+2] = right;
		face++;
		left++;
		faces[3*face+0] = right;
		faces[3*face+1] = left;
		faces[3*face+2] = right-1;
		right--;
		face++;
	}
	if (left+1 < right) {
		faces[3*face+0] = left;
		faces[3*face+1] = left+1;
		faces[3*face+2] = right;
		face++;
		left++;
	}
}

void circleBorder(short *faces, int r1, int r2, int segments) {
	for (int i = 0; i < segments; i++) {
		faces[6*i+0] = r1+i;
		faces[6*i+1] = r2+i;
		faces[6*i+2] = r1+((i+1)%segments);
		faces[6*i+3] = r2+i;
		faces[6*i+4] = r2+((i+1)%segments);
		faces[6*i+5] = r1+((i+1)%segments);
	}
}

static void makeCircleNormals(GLTYPE *normals, int segments, float hdiff, float rdiff) {
	float nz = rdiff;
	float nr = hdiff;
	float len = sqrt(nz*nz + nr*nr);
	nz /= len;
	nr /= len;
	for (int i = 0; i < segments; i++) {
		normals[3*i+0] = F(-nr*cos(i*2*M_PI/segments));
		normals[3*i+1] = F(-nr*sin(i*2*M_PI/segments));
		normals[3*i+2] = F(nz);
	}
}

BowlMesh::BowlMesh(int segments, bool smooth, float r1, float r2, float r3, float h1) {
	if (smooth)
		nVertices = 3*segments;
	else
		nVertices = 5*segments;
	nFaces = segments-2 + 2*segments + 2*segments;
	vertices = new GLTYPE[3*nVertices];
	normals = new GLTYPE[3*nVertices];
	faces = new short[3*nFaces];
	if (smooth) {
		makeCircle(&vertices[0*segments*3], segments, r1, 0);
		makeCircle(&vertices[1*segments*3], segments, r2, h1);
		makeCircle(&vertices[2*segments*3], segments, r3, h1);
		makeCircleNormals(&normals[0*segments*3], segments, 0, r1);
		makeCircleNormals(&normals[1*segments*3], segments, h1, r2-r1);
		makeCircleNormals(&normals[2*segments*3], segments, 0, r3-r2);
		int face = 0;
		fillCircle(&faces[3*face], segments, 0);
		face += segments-2;
		circleBorder(&faces[3*face], 0, segments, segments);
		face += 2*segments;
		circleBorder(&faces[3*face], segments, 2*segments, segments);
		face += 2*segments;
	} else {
		makeCircle(&vertices[0*segments*3], segments, r1, 0);
		makeCircle(&vertices[1*segments*3], segments, r1, 0);
		makeCircle(&vertices[2*segments*3], segments, r2, h1);
		makeCircle(&vertices[3*segments*3], segments, r2, h1);
		makeCircle(&vertices[4*segments*3], segments, r3, h1);
		makeCircleNormals(&normals[0*segments*3], segments, 0, r1);
		makeCircleNormals(&normals[1*segments*3], segments, h1, r2-r1);
		makeCircleNormals(&normals[2*segments*3], segments, h1, r2-r1);
		makeCircleNormals(&normals[3*segments*3], segments, 0, r3-r2);
		makeCircleNormals(&normals[4*segments*3], segments, 0, r3-r2);
		int face = 0;
		fillCircle(&faces[3*face], segments, 0);
		face += segments-2;
		circleBorder(&faces[3*face], 1*segments, 2*segments, segments);
		face += 2*segments;
		circleBorder(&faces[3*face], 3*segments, 4*segments, segments);
		face += 2*segments;
	}

}

CircleMesh::CircleMesh(int segments) {
	nVertices = segments;
	nFaces = segments-2;
	vertices = new GLTYPE[3*nVertices];
	normals = new GLTYPE[3*nVertices];
	faces = new short[3*nFaces];
	makeCircle(vertices, segments, 1, 0);
	for (int i = 0; i < nVertices; i++) {
		normals[3*i+0] = F(0);
		normals[3*i+1] = F(0);
		normals[3*i+2] = F(1);
	}
	fillCircle(faces, segments, 0);
}


