#include <GL/gl.h>
#include <GL/glut.h>
#include <stdlib.h>
#include <stdio.h>
#include "object3d.h"
#include "timing.h"
#include "vector.h"

void Object3d_calc_normals(Object3d *o)
{
    int i;

    for(i = 0; i < o->num_faces; i++) {
	Vector_crossprod(o->t[i].v[0]->c, o->t[i].v[1]->c, o->t[i].v[0]->n);
        Vector_normalize(o->t[i].v[0]->n);
	VECTOR_CPY(o->t[i].v[1]->n, o->t[i].v[0]->n);
	VECTOR_CPY(o->t[i].v[2]->n, o->t[i].v[0]->n);
    }
}


/*
 * Objects are bounds for 1 or more spheres.
 * The collision is done when one sphere of the object1 intersects with
 * one sphere of the object2.
 *
 * One sphere intersects with other if the distance between centers is
 * less than the sum of its radius.
 */
int Object3d_collision(Object3d *o1, Object3d *o2)
{
    int i,j;
    float d;

    float v1[3], v2[3];

    if(!(o1->state & STATE_COLLISION) || !(o2->state & STATE_COLLISION)) return 0;

    for(i = 0; i < o1->num_bounds; i++) {
	VECTOR_CPY(v1, o1->bound[i].c);
	Vector_rotate(v1, RAD(o1->r[1]));
	Vector_acum(v1,o1->tr);
	for(j = 0; j < o2->num_bounds; j++) {
	    VECTOR_CPY(v2, o2->bound[j].c);
	    Vector_rotate(v2, RAD(o2->r[1]));
	    Vector_acum(v2, o2->tr);
	    d = Vector_lengthxz(v1, v2);
	    if(d < o1->bound[i].r + o2->bound[j].r) return 1;  // collision
	}
    }
    
    return 0;
}


int Object3d_collision2(Object3d *o1, Object3d *o2)
{
    float d = Vector_lengthxz(o1->tr, o2->tr);

    if(d < 1.0) return 1;  // collision
    
    return 0;
}

void Object3d_spin(Object3d *o, float g) 
{
    float r, modv;
    
    if(!(o->state & STATE_MOVE)) return;
    
    o->r[1] += g;
    
    // Convert grades in radians
    r = RAD(o->r[1]);
    
    modv = Vector_modxz(o->v);

    o->v[0] = -cos(r) * modv;
    o->v[2] = sin(r) * modv;
}

void Object3d_set_vel(Object3d *o, float v)
{
    // Convert grades in radians
    float r = RAD(o->r[1]);
    
    //if(!(o->state & STATE_MOVE)) return;
    
    o->v[0] = -cos(r) * v;
    o->v[1] = 0.0;
    o->v[2] = sin(r) * v;
}

void Object3d_update_pos(Object3d *o) 
{
    if(!(o->state & STATE_MOVE)) return;
    
    o->tr[0] += o->v[0] * dt / 1000.0;
    o->tr[2] += o->v[2] * dt / 1000.0;
}


void Object3d_draw_collisions(Object3d *o)
{
    int i;
    float v[3];

    glColor3f(1.0,1.0,1.0);
    for(i = 0; i < o->num_bounds; i++) {
	glPushMatrix();
	
	    VECTOR_CPY(v, o->bound[i].c);
	    Vector_rotate(v, RAD(o->r[1]));
	    Vector_acum(v,o->tr);

	    glTranslatef(v[0], v[1], v[2]);
	    glutSolidSphere(o->bound[i].r,10,10);
	glPopMatrix();
    }
}

void Object3d_draw(Object3d *o)
{
    int i;

    //if(!(o->state & STATE_DRAW)) return;
    
    glPushMatrix();

    glTranslatef(o->tr[0], o->tr[1], o->tr[2]);

    glRotatef(o->r[0], 1.0f, 0.0f, 0.0f);
    glRotatef(o->r[1], 0.0f, 1.0f, 0.0f);
    glRotatef(o->r[2], 0.0f, 0.0f, 1.0f);
 
    glColor3fv(o->color);
    glBegin(GL_TRIANGLES);
	for(i = 0; i < o->num_faces; i++) {
	    glNormal3fv(o->t[i].v[0]->n);
	    glVertex3fv(o->t[i].v[0]->c);
	    glNormal3fv(o->t[i].v[1]->n);
	    glVertex3fv(o->t[i].v[1]->c);
	    glNormal3fv(o->t[i].v[2]->n);
	    glVertex3fv(o->t[i].v[2]->c);
	}
    glEnd();
    glPopMatrix();

    //Object3d_draw_collisions(o);
}

void Object3d_draw_list(Object3d *o)
{
    if(!(o->state & STATE_DRAW)) return;
    
    glPushMatrix();

    glTranslatef(o->tr[0], o->tr[1], o->tr[2]);

    glRotatef(o->r[1], 0.0f, 1.0f, 0.0f);
    glRotatef(o->r[0], 1.0f, 0.0f, 0.0f);
    glRotatef(o->r[2], 0.0f, 0.0f, 1.0f);

    glColor3fv(o->color);
    glCallList(o->display_list);
    glPopMatrix();
}

void Object3d_gen_list(Object3d *o)
{
    int i;

    o->display_list = glGenLists(1);
    glNewList(o->display_list, GL_COMPILE);
        glBegin(GL_TRIANGLES);
	    for(i = 0; i < o->num_faces; i++) {
	        glNormal3fv(o->t[i].v[0]->n);
	        glVertex3fv(o->t[i].v[0]->c);
	        glNormal3fv(o->t[i].v[1]->n);
	        glVertex3fv(o->t[i].v[1]->c);
	        glNormal3fv(o->t[i].v[2]->n);
	        glVertex3fv(o->t[i].v[2]->c);
	    }
        glEnd();
    glEndList();
}


void readstr(FILE *f, char *string)
{
    do {
	fgets(string, 255, f);
    } while ((string[0] == '/') || (string[0] == '\r') || (string[0] == '\n'));
}

void Object3d_load(Object3d *o, char *name)
{
    int ver;
    float rx, ry, rz;
    int v1, v2, v3;
    FILE *filein;
    char oneline[255];
    int i;

    filein = fopen(name, "rt");
    if(filein == NULL) perror(name);

    // Number of vertices
    readstr(filein, oneline);
    sscanf(oneline, "Vertices: %d\n", &ver);
    o->num_vertices = ver;
    o->vertex=(Vertex *)malloc(sizeof(Vertex)*ver);

    // Number of faces
    readstr(filein, oneline);
    sscanf(oneline, "Faces: %d\n", &ver);
    o->num_faces = ver;
    o->t = (Triangle *)malloc(sizeof(Triangle)*ver);
    
    printf("Loading %s.  %d faces    %d vertices\n",name, o->num_faces, o->num_vertices);

    // Load vertices
    for (i = 0; i < o->num_vertices; i++) {
        readstr(filein, oneline);
        sscanf(oneline, "%f %f %f", &rx, &ry, &rz);
        //printf("%f %f %f\n", rx, ry, rz);
        o->vertex[i].c[0] = rx;
        o->vertex[i].c[1] = ry;
        o->vertex[i].c[2] = rz;
    }

    if(o->num_faces == 0) return;
    
    // Load normals
    for (i = 0; i < o->num_vertices; i++) {
        readstr(filein, oneline);
        sscanf(oneline, "%f %f %f", &rx, &ry, &rz);
        //printf("%f %f %f\n", rx, ry, rz);
        o->vertex[i].n[0] = rx;
        o->vertex[i].n[1] = ry;
        o->vertex[i].n[2] = rz;
    }
   
    // Load faces
    for (i = 0; i < o->num_faces; i++) {
        readstr(filein, oneline);
        sscanf(oneline, "%d %d %d", &v1, &v2, &v3);
        //printf("%d %d %d\n", v1, v2, v3);
        o->t[i].v[0] = &(o->vertex[v1-1]);
        o->t[i].v[1] = &(o->vertex[v2-1]);
        o->t[i].v[2] = &(o->vertex[v3-1]);
    }
    
    fclose(filein);
}


void Object3d_shift(Object3d *o, float shift)
{
    float y[3] = {0.0, 1.0, 0.0};
    float s[3];
    
    // Calcs velocity unitary perpendicular
    Vector_crossprod(y, o->v, s);
    Vector_normalize(s);

    Vector_scale(s, shift);
    Vector_acum(o->tr, s);
}
