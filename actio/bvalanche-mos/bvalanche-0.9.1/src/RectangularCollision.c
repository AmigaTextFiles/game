/*
 * RectangularCollision.c
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

int RC_IsWithin(int theNumber, int inferiorBound, int superiorBound)
{
    return(theNumber>=inferiorBound && theNumber<=superiorBound);
}

/*
 * RC_Collides: rectangular collision test
 */

int RC_collides(int obj1x,int obj1y,int obj1xl,int obj1yl,int obj2x,int obj2y,int obj2xl,int obj2yl)
{
    if(RC_IsWithin(obj1x,obj2x,obj2x+obj2xl) && RC_IsWithin(obj1y,obj2y,obj2y+obj2yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj1x+obj1xl,obj2x,obj2x+obj2xl) && RC_IsWithin(obj1y,obj2y,obj2y+obj2yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj1x,obj2x,obj2x+obj2xl) && RC_IsWithin(obj1y+obj1yl,obj2y,obj2y+obj2yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj1x+obj1xl,obj2x,obj2x+obj2xl) && RC_IsWithin(obj1y+obj1yl,obj2y,obj2y+obj2yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj2x,obj1x,obj1x+obj1xl) && RC_IsWithin(obj2y,obj1y,obj1y+obj1yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj2x+obj2xl,obj1x,obj1x+obj1xl) && RC_IsWithin(obj2y,obj1y,obj1y+obj1yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj2x,obj1x,obj1x+obj1xl) && RC_IsWithin(obj2y+obj2yl,obj1y,obj1y+obj1yl))
    {
        return 1;
    }

    if(RC_IsWithin(obj2x+obj2xl,obj1x,obj1x+obj1xl) && RC_IsWithin(obj2y+obj2yl,obj1y,obj1y+obj1yl))
    {
        return 1;
    }

    return 0;
}
