/***************************************************************************
                          sdlkurve.h  -  description
                             -------------------
    begin                : Tue Oct 5 2004
    copyright            : (C) 2004 by Jakub Judas
    email                : 
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 struct kurve{
   int x,y,xold,yold,points;
   unsigned char hole;
   double angle,ax,ay,fx,fy;
   int left,right;
   bool alive,leftpressed,rightpressed,active;
   char pointshow[2];
   };
   void Update(void);
