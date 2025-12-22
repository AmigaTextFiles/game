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

#include "hand.h"
#include "glwrapper.h"
#include <stdio.h>
#include <assert.h>
#include "matrix.h"
#include <math.h>
#include <string.h>
#include "quat.h"
#include "hand_dat.h"

class Bone {
public:
	~Bone();

	int parent;
	GLTYPE restMatrix[16];
	GLTYPE *initPos;
	GLTYPE rot[16];

	int nIndices;
	short *indices;
//	int nVertices;
	GLTYPE *vertices;
	GLTYPE *normals;

	int nPoses;
	GLTYPE *poses;
	GLTYPE *poseMatrices;
	GLTYPE *poseTransAA;
};

class DataSource {
public:
	virtual int readInt() = 0;
	virtual int readInt32() = 0;
	virtual float readFloat() = 0;
	virtual void skip(int n) = 0;
	virtual ~DataSource() {}
};

class FileDataSource : public DataSource {
public:
	FileDataSource(const char *name) {
		in = fopen(name, "rb");
	}
	~FileDataSource() {
		fclose(in);
	}
	int readInt() {
		signed short n = 0;
		n |= (fgetc(in) & 0xFF);
		n |= (fgetc(in) & 0xFF) << 8;
		return n;
	}
	int readInt32() {
		int n = 0;
		n |= (fgetc(in) & 0xFF);
		n |= (fgetc(in) & 0xFF) << 8;
		n |= (fgetc(in) & 0xFF) << 16;
		n |= (fgetc(in) & 0xFF) << 24;
		return n;
	}
	float readFloat() {
		union {
			float f;
			int i;
		} u;
		u.i = readInt32();
		return u.f;
	}
	void skip(int n) {
		for (int i = 0; i < n; i++)
			fgetc(in);
	}

private:
	FILE *in;
};

class MemDataSource : public DataSource {
public:
	MemDataSource(const void *ptr) {
		in = (const unsigned char*) ptr;
	}
	~MemDataSource() {
	}
	int readInt() {
		signed short n = 0;
		n |= (*in++ & 0xFF);
		n |= (*in++ & 0xFF) << 8;
		return n;
	}
	int readInt32() {
		int n = 0;
		n |= (*in++ & 0xFF);
		n |= (*in++ & 0xFF) << 8;
		n |= (*in++ & 0xFF) << 16;
		n |= (*in++ & 0xFF) << 24;
		return n;
	}
	float readFloat() {
		union {
			float f;
			int i;
		} u;
		u.i = readInt32();
		return u.f;
	}
	void skip(int n) {
		in += n;
	}

private:
	const unsigned char *in;
};

Bone::~Bone() {
	delete [] indices;
	delete [] vertices;
	delete [] normals;
	delete [] poses;
	delete [] poseTransAA;
	delete [] poseMatrices;
}

Hand::Hand() {
//	initFromFile("hand.dat");
	initFromMem(hand_dat);
	setPose(0);
}

Hand::~Hand() {
	delete [] faces;
	delete [] vertices;
	delete [] normals;
	delete [] bones;
}

void Hand::initFromFile(const char *name) {
	initFromDS(new FileDataSource(name));
}

void Hand::initFromMem(const void *ptr) {
	initFromDS(new MemDataSource(ptr));
}

class VGroup {
public:
	~VGroup() {
		delete [] indices;
	}
	int index;
	int nIndices;
	short *indices;
};

void Hand::initFromDS(DataSource *ds) {
	int meshes = ds->readInt();
	assert(meshes == 1);

	int namelen = ds->readInt();
	ds->skip(namelen);

	GLTYPE meshMatrix[16];
	for (int i = 0; i < 16; i++)
		meshMatrix[i] = F(ds->readFloat());

	nVertices = ds->readInt();
	vertices = new GLTYPE[nVertices];
	normals = new GLTYPE[nVertices];
	for (int i = 0; i < nVertices; i++)
		vertices[i] = F(ds->readFloat());
	for (int i = 0; i < nVertices; i++)
		normals[i] = F(ds->readFloat());
	nVertices /= 3;

	nFaces = ds->readInt();
	faces = new short[nFaces];
	for (int i = 0; i < nFaces; i++)
		faces[i] = ds->readInt();
	nFaces /= 3;

	int nVgroups = ds->readInt();
	VGroup *vgroups = new VGroup[nVgroups];
	for (int i = 0; i < nVgroups; i++) {
		vgroups[i].index = ds->readInt();
		vgroups[i].nIndices = ds->readInt();
		vgroups[i].indices = new short[vgroups[i].nIndices];
		for (int j = 0; j < vgroups[i].nIndices; j++)
			vgroups[i].indices[j] = ds->readInt();
	}

	int armatures = ds->readInt();
	assert(armatures == 1);

	GLTYPE armatureMatrix[16];
	for (int i = 0; i < 16; i++)
		armatureMatrix[i] = F(ds->readFloat());

	nBones = ds->readInt();
	bones = new Bone[nBones];
	for (int i = 0; i < nBones; i++) {
		int index = ds->readInt();
		bones[index].parent = ds->readInt();

		int armature = ds->readInt();
		assert(armature == 0);

		for (int j = 0; j < 16; j++)
			bones[index].restMatrix[j] = F(ds->readFloat());

		ds->readFloat(); // length
		bones[index].nPoses = ds->readInt();
		bones[index].poses = new GLTYPE[4*bones[index].nPoses];
		for (int j = 0; j < bones[index].nPoses; j++) {
			bones[index].poses[4*j+1] = F(ds->readFloat()); // x
			bones[index].poses[4*j+2] = F(ds->readFloat()); // y
			bones[index].poses[4*j+3] = F(ds->readFloat()); // z
			bones[index].poses[4*j+0] = F(ds->readFloat()); // w
			NORMALIZE4(&bones[index].poses[4*j]);
		}
	}
	delete ds;

	for (int i = 0; i < nVgroups; i++) {
		int index = vgroups[i].index;
		if (index <= nBones) {
			Bone *b = &bones[index];
			b->nIndices = vgroups[i].nIndices;
			b->indices = vgroups[i].indices;
			vgroups[i].indices = NULL;
//			b->nVertices = b->nIndices;
			b->vertices = new GLTYPE[3*b->nIndices];
			b->normals = new GLTYPE[3*b->nIndices];
		}
	}
	delete [] vgroups;


	GLTYPE meshInverse[16];
	GLTYPE armInit[16];
	invertMatrix(meshInverse, meshMatrix);
	multMatrix(armInit, meshInverse, armatureMatrix);

	for (int i = 0; i < nBones; i++) {
		Bone *b = &bones[i];
		if (b->parent >= 0)
			continue;
		GLTYPE tempMatrix[16];
		multMatrix(tempMatrix, armInit, b->restMatrix);
		memcpy(b->restMatrix, tempMatrix, sizeof(GLTYPE)*16);
	}

	for (int i = 0; i < nBones; i++) {
		GLTYPE matrix1[16], matrix2[16];
		Bone *b = &bones[i];
		memcpy(matrix1, b->restMatrix, sizeof(GLTYPE)*16);
		while (b->parent >= 0) {
			b = &bones[b->parent];
			multMatrix(matrix2, b->restMatrix, matrix1);
			memcpy(matrix1, matrix2, sizeof(GLTYPE)*16);
		}
		b = &bones[i];
		invertMatrix(matrix2, matrix1);
		for (int j = 0; j < b->nIndices; j++) {
			multVect3(&b->vertices[3*j], matrix2, &vertices[3*b->indices[j]], F(1));
			multVect3(&b->normals[3*j], matrix2, &normals[3*b->indices[j]], F(0));
		}

		b->poseTransAA = new GLTYPE[4*(b->nPoses-1)];
		b->poseMatrices = new GLTYPE[16*b->nPoses];
		for (int j = 0; j < b->nPoses; j++) {
			if (j+1 < b->nPoses) {
				GLTYPE q1inv[4], q1to2[4];
				quatInv(q1inv, &b->poses[4*j]);
				quatMul(q1to2, q1inv, &b->poses[4*(j+1)]);
				quatToAA(&b->poseTransAA[4*j], q1to2);
			}
			quatToMatrix(&b->poseMatrices[16*j], &b->poses[4*j]);
		}
	}
	// these bones' poses are all the same, no need to move them
	bones[0].nIndices = 0;
	bones[4].nIndices = 0;
	bones[8].nIndices = 0;
	bones[12].nIndices = 0;
	bones[16].nIndices = 0;

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

void Hand::getDim(GLTYPE *v) {
	memcpy(v, dim, sizeof(GLTYPE)*3);
}

void Hand::scale(GLTYPE f) {
	MULBY(dim[0], f);
	MULBY(dim[1], f);
	MULBY(dim[2], f);
	for (int i = 0; i < nVertices; i++) {
		MULBY(vertices[3*i+0], f);
		MULBY(vertices[3*i+1], f);
		MULBY(vertices[3*i+2], f);
	}

	for (int i = 0; i < nBones; i++) {
		Bone *b = &bones[i];
		MULBY(b->restMatrix[12], f);
		MULBY(b->restMatrix[13], f);
		MULBY(b->restMatrix[14], f);
		for (int j = 0; j < b->nIndices; j++) {
			MULBY(b->vertices[3*j+0], f);
			MULBY(b->vertices[3*j+1], f);
			MULBY(b->vertices[3*j+2], f);
		}
	}
}

void Hand::draw() {
	glVertexPointer(3, GLTYPETOKEN, 0, vertices);
	glNormalPointer(GLTYPETOKEN, 0, normals);
	glDrawElements(GL_TRIANGLES, 3*nFaces, GL_UNSIGNED_SHORT, faces);
}

void Hand::setPose(int n, GLTYPE pose) {
#ifdef USE_FIXED
	int base = pose >> 16;
	GLfixed diff = pose & 0x0000FFFF;
#else
	int base = (int) pose;
	float diff = pose - base;
#endif

	Bone *b = &bones[n];
	if (base >= b->nPoses - 1) {
		base = b->nPoses - 2;
		diff = F(1);
	}
	b->initPos = &b->poseMatrices[16*base];
	GLTYPE aa[4];
	aa[0] = MUL(diff, b->poseTransAA[4*base+0]);
	aa[1] = b->poseTransAA[4*base+1];
	aa[2] = b->poseTransAA[4*base+2];
	aa[3] = b->poseTransAA[4*base+3];
	aaToMatrix(b->rot, aa);
}

void Hand::setPose(GLTYPE pose) {
	for (int i = 0; i < nBones; i++)
		setPose(i, pose);
}

void Hand::doPose() {
	for (int i = 0; i < nBones; i++) {
		GLTYPE matrix1[16], matrix2[16];
		Bone *b = &bones[i];
		multMatrix(matrix2, b->restMatrix, b->initPos);
		multMatrix(matrix1, matrix2, b->rot);

		while (b->parent >= 0) {
			b = &bones[b->parent];
			multMatrix(matrix2, b->rot, matrix1);
			multMatrix(matrix1, b->initPos, matrix2);
			multMatrix(matrix2, b->restMatrix, matrix1);
			memcpy(matrix1, matrix2, sizeof(GLTYPE)*16);
		}
		b = &bones[i];
		for (int j = 0; j < b->nIndices; j++) {
			multVect3(&vertices[3*b->indices[j]], matrix1, &b->vertices[3*j], F(1));
			multVect3(&normals[3*b->indices[j]], matrix1, &b->normals[3*j], F(0));
		}
	}
}

