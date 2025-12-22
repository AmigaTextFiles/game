#ifndef CVECTOR_H
#define CVECTOR_H

class CVector {
	double mX;
	double mY;
	public:
	CVector(double x, double y) { mX = x; mY = y;}
	double getX() {return mX;}
	double getY() {return mY;}

	void add(double uhel, double velikost);
	double veSmeru(double uhel);
	void krat(double zrychleni);
	void soucet(CVector kolega);
};

#endif
