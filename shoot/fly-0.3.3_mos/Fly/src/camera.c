#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <math.h>
#include "vector.h"
#include "flyer.h"
#include "camera.h"

int WIDTH;
int HEIGHT;

// predefined cameras
struct Camera fix_camera[] = {
    {  0.0,  0.0,  0.0,
       0.0,  2.0, 10.0,
       0.0,  0.0,  0.0,
       0.0,  0.0,  0.0, E_FOLLOW2}, // First created
    {  0.0,  0.0,  0.0,
     -60.0,-99.5,-50.1,
       0.0,  0.0,  0.0,
      90.0,  0.0,  0.0, E_STATIC},  // All scenario view
    {  0.0,  0.0,  0.0,
     -40.1,-70.7,-76.0,
       0.0,  0.0,  0.0,
      60.0,  0.0,  0.0, E_STATIC},  // All scenario view, a few perspective
    {  0.0,  0.0,  0.0,
       0.0,  5.6, 19.3,
       0.0,  0.0,  0.0,
      16.5,  0.0,  0.0, E_FOLLOW2},  // More field that the first 
    {  0.0,  0.0,  0.0,
       0.0,  2.0, 20.0,
       0.0,  0.0,  0.0,
      14.0,  0.0,  0.0, E_FOLLOW2},  // 
    {  0.0,  0.0,  0.0,
      20.0,  2.0,  0.0,
       0.0,-90.0,  0.0,
       0.0,-90.0,  0.0, E_FOLLOW},   // back view 
    {  0.0,  0.0,  0.0,
      20.0, 10.0,  0.0,
       0.0,  0.0,  0.0,
      29.5,-90.0,  0.0, E_FOLLOW},  
    {  0.0,  0.0,  0.0,
       0.0, 12.0, 27.5,
       0.0,  0.0,  0.0,
      29.0,  0.0,  0.0, E_FOLLOW2},  
    {  0.0,  0.0,  0.0,
       6.0,  3.0,  0.6,
       0.0,  0.0,  0.0,
      16.5,-88.0, -2.0, E_FOLLOW},  
};

int Camera_get_width()
{
    return WIDTH;
}

int Camera_get_height()
{
    return HEIGHT;
}

void Camera_set_size(int width, int height)
{
    WIDTH = width;
    HEIGHT = height;
}

struct Camera *Camera_new(int n)
{
    return fix_camera + n;
}

void Camera_set(struct Camera *camera)
{
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    gluPerspective(45.0f, (GLfloat) WIDTH / (GLfloat) HEIGHT, 0.1f, 100.0f);
    glMatrixMode(GL_MODELVIEW);

    glLoadIdentity();
    if(camera->type == E_LOOKAT) { 
        gluLookAt(camera->itx, camera->ity, camera->itz, 
	    camera->tx, camera->ty, camera->tz,
	    0.0, 1.0, 0.0);
    } else {
        glRotatef(camera->rx, 1.0f, 0.0f, 0.0f);
        glRotatef(camera->ry, 0.0f, 1.0f, 0.0f);
        glRotatef(camera->rz, 0.0f, 0.0f, 1.0f);
        glTranslatef(camera->tx, camera->ty, camera->tz);
    }
}

void Camera_update_pos(struct Camera *camera, Flyer *flyer)
{
    switch(camera->type) {
	case E_FOLLOW:
	    Camera_update_pos_follow(camera, flyer);
	    break;
	case E_FOLLOW2:
	    Camera_update_pos_follow2(camera, flyer);
	    break;
	case E_STATIC:
	    Camera_update_pos_static(camera);
	    break;
        case E_LOOKAT:
	    Camera_update_pos_lookat(camera, flyer);
	    break;
    }
	    
}


void Camera_update_pos_follow2(struct Camera *camera, Flyer *flyer)
{
    camera->tx = -(flyer->o.tr[0] + camera->itx);
    camera->ty = -(flyer->o.tr[1] + camera->ity);
    camera->tz = -(flyer->o.tr[2] + camera->itz);

    //printf("camera x: %f   y: %f   z: %f \n",camera->tx,camera->ty,camera->tz);

    //camera->rx = -(flyer->rx + camera->irx);
    //camera->ry = -(flyer->ry + camera->iry);
    //camera->rz = -(flyer->rz + camera->irz);
    
    camera->rx = camera->irx;
    camera->ry = camera->iry;
    camera->rz = camera->irz;
}


void Camera_update_pos_lookat(struct Camera *camera, Flyer *flyer)
{
    camera->tx = flyer->o.tr[0];
    camera->ty = flyer->o.tr[1];
    camera->tz = flyer->o.tr[2];
}


void Camera_update_pos_follow(struct Camera *camera, Flyer *flyer)
{
    float v[3];

    v[0] = camera->itx; v[1] = camera->ity; v[2] = camera->itz;

    Vector_rotate(v, RAD(flyer->o.r[1]));
    
    camera->tx = -(flyer->o.tr[0] + v[0]);
    camera->ty = -(flyer->o.tr[1] + v[1]);
    camera->tz = -(flyer->o.tr[2] + v[2]);

    // camera->rx = flyer->o.r[0] + camera->irx;
    camera->rx = camera->irx;
    camera->ry = -flyer->o.r[1] + camera->iry;
    // camera->rz = flyer->o.r[2] + camera->irz;
    camera->rz = camera->irz;
}

void Camera_update_pos_follow3(struct Camera *camera, Flyer *flyer)
{
    float v[3];
    float alpha = flyer->o.r[1] - (camera->ry - camera->iry);
    float epsilon = 60.0;

    v[0] = camera->itx; v[1] = camera->ity; v[2] = camera->itz;

    if(alpha > epsilon) alpha = alpha - epsilon;
    else if(alpha < -epsilon) alpha = alpha + epsilon;
    else alpha = 0;

    printf("alpha: %f, ry: %f, iry: %f, flyer: %f\n",alpha,camera->ry, camera->iry, flyer->o.r[1]);
    
    Vector_rotate(v, -RAD(alpha));
 
    camera->rx = flyer->o.r[0] + camera->irx;
    camera->ry = alpha + camera->ry;
    camera->rz = flyer->o.r[2] + camera->irz;
   
    camera->tx = -(flyer->o.tr[0] + v[0]);
    camera->ty = -(flyer->o.tr[1] + v[1]);
    camera->tz = -(flyer->o.tr[2] + v[2]);
}

void Camera_update_pos_static(struct Camera *camera)
{
    camera->tx = camera->itx;
    camera->ty = camera->ity;
    camera->tz = camera->itz;

    camera->rx = camera->irx;
    camera->ry = camera->iry;
    camera->rz = camera->irz;
}


