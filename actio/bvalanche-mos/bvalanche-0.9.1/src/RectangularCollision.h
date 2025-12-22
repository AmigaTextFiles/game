/*
 * RectangularCollision.h
 * ----------------------------------------------------
 * Basic rectangular collision test for 2D game
 * (originally called "GameEssentials.c")
 *
 * Version : v1.1
 * Date	: January 15, 2011
 *
 * (C) 2008, 2011, bl0ckeduser
 *
 */

/*
 * RC_IsWithin: check if number is within two bounds
 * (Syntax sugar for RC_collides)
 */

extern int RC_IsWithin(int theNumber, int inferiorBound, int superiorBound);

/*
 * RC_Collides: rectangular collision test
 */

extern int RC_collides(int obj1x,int obj1y,int obj1xl,int obj1yl,int obj2x,int obj2y,int obj2xl,int obj2yl);

