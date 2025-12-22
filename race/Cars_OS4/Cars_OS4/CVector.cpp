#include "CVector.hpp"

// !!! nutno skompilovat s ' -lm'
#include <math.h>


//-----------------------------------------------------------------
/*
   pricteni vectoru zadaneho uhlem a velikosti
 */
	void
CVector::add(double uhel, double velikost)
{
	mY += velikost * sin(uhel); 
	mX += velikost * cos(uhel);
}

//-----------------------------------------------------------------
/*
   zjisti velikost ve smeru zadaneho uhlu
 */
	double
CVector::veSmeru(double uhel)
{
	double beta;
	double velikost;

	// hypot(x, y) == sqrt(x*x + y*y)
	// mY musime davat s obracenym znamenkem
	beta = atan2(mY, mX);
	velikost = hypot(mX, mY);
	return velikost * cos(beta - uhel);
}

//-----------------------------------------------------------------
/*
   vynasobeni danym cislem
 */
void
CVector::krat(double zrychleni)
{
	mX *= zrychleni;
	mY *= zrychleni;
}
//-----------------------------------------------------------------
/*
   soucet dvou vektoru
   A = A + B
   pozn. nechce se mi pretezovat operatory
 */
void
CVector::soucet(CVector kolega)
{
	mX = mX + kolega.mX;
   	mY = mY + kolega.mY;
}


