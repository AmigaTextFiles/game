// coRect.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details 

#ifndef _CORECT_
#define _CORECT_

#include "level.h" 

class CoRect{

	private:
		int x, y, w, h, typ;
		bool kante; 	//ist Baustein eine Levelkante??
	
	public:
		CoRect(){
			x=y=w=h=0;
		}
		CoRect(int x, int y, int w, int h, int typ){
			CoRect::x = x;
			CoRect::y = y;
			CoRect::w = w;
			CoRect::h = h;
			CoRect::typ = typ;
		}
		
		CoRect (Eingang eingang) {			//Konvertierungskonstruktor
			CoRect::x = eingang.xCoor;
			CoRect::y = eingang.yCoor;
			CoRect::w =40;	//Grösser als normal um Herausgehen zu vereinfachen
			CoRect::h = 70;
			CoRect::typ = -1;
		}
		
			
		
		int getX() {return x;}
		int getY() {return y;}
		int getH() {return h;}
		int getW() {return w;}
		int setH(int newH) { h = newH;}
		int setW(int newW) { w = newW;}
		void setX(int param) { x += param;}
		void setY(int param) { y += param;}
		int getTyp() {return typ;}
		void setTyp(int nr) {typ=nr;}
		void setKante(bool param) {kante = param;}
		bool getKante() { return kante; }
		
		void setPosition(int xNeu, int yNeu){
			x = xNeu;
			y = yNeu;
		}
		
		void setDimension (int hNeu, int wNeu){
			h = hNeu;
			w = wNeu;
		}
		
		bool intersects(CoRect* rec){
			if (x + w >= rec->getX() && x <= ( rec->getX() + rec->getW()) && y + h >= rec->getY() && y <= ( rec->getY() + rec->getH())){
				return true;
			}
			return false;
		}
		
		bool contains(CoRect rec){
			if ( x <= rec.getX() && (x + w) >= ( rec.getX() + rec.getW() ) && y <= rec.getY() && (y +w) >= (rec.getY() + rec.getW() )  )
				return true;
		
			return false;
		}
		
		
	};



























#endif
