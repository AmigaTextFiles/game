/*
    Copyright 2005 by Mark Weyer

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
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifndef(the_colour)
  #declare the_colour = <1,0,0>;
#end

#include "rohrpost.inc"

camera {
  orthographic
  location 0
  direction z
  right 8*x
  up 9*y

  translate <3.5,4,-10>
}


#declare num_pipes = 11;
#declare pipe_Data = array[num_pipes][4] {
    {0,0,1,0},
    {2,0,7,1},
    {0,1,1,5},
    {2,2,6,2},
    {7,2,7,3},
    {2,3,2,5},
    {3,3,5,3},
    {6,3,6,3},
    {3,4,3,8},
    {4,4,7,8},
    {0,6,2,8}
  };
#declare num_messages1 = 20;
#declare message1_Data = array[num_messages1][4] {
    {0,0,1,3},
    {1,0,1,3},
    {4,0,1,2},
    {5,0,2,3},
    {0,1,1,2},
    {1,1,2,3},
    {4,1,0,1},
    {5,1,0,3},
    {4,2,1,3},
    {7,2,0,2},
    {0,3,0,1},
    {1,3,0,3},
    {7,3,0,2},
    {0,5,0,1},
    {1,5,0,3},
    {5,5,0,2},
    {3,6,0,2},
    {5,6,1,3},
    {4,7,1,2},
    {7,7,2,3}
  };
#declare num_messages2 = 18;
#declare message2_Data = array[num_messages2][6] {
    {2,0,2,1,1,1},
    {3,0,3,1,3,3},
    {6,0,6,1,1,1},
    {7,0,7,1,3,3},
    {0,2,1,2,0,0},
    {2,2,3,2,3,1},
    {5,2,6,2,3,1},
    {0,4,1,4,2,2},
    {3,4,3,5,0,2},
    {4,4,5,4,2,2},
    {6,4,7,4,2,2},
    {4,5,4,6,1,1},
    {6,5,6,6,0,2},
    {7,5,7,6,3,3},
    {3,7,3,8,0,2},
    {5,7,6,7,3,1},
    {4,8,5,8,0,0},
    {6,8,7,8,0,0}
  };

#macro pipe(X1,Y1,X2,Y2)
  #if (X1=X2)
    #if (Y1=Y2)
      difference {
        sphere {<X1,Y1,0> outer_pipe_rad}
        sphere {<X1,Y1,0> inner_pipe_rad}
    #else
      difference {
        cylinder {
          <X1,Y1-mess_len/2+inner_pipe_rad-outer_pipe_rad,0>
          <X1,Y2+mess_len/2-inner_pipe_rad+outer_pipe_rad,0>
          outer_pipe_rad
        }
        cylinder {<X1,Y1-mess_len/2,0> <X1,Y2+mess_len/2,0> inner_pipe_rad}
    #end
  #else
    #if (Y1=Y2)
      difference {
        cylinder {
          <X1-mess_len/2+inner_pipe_rad-outer_pipe_rad,Y1,0>
          <X2+mess_len/2-inner_pipe_rad+outer_pipe_rad,Y1,0>
          outer_pipe_rad
        }
        cylinder {<X1-mess_len/2,Y1,0> <X2+mess_len/2,Y1,0> inner_pipe_rad}
    #else
      #local X1_=X1+1/2;
      #local Y1_=Y1+1/2;
      #local X2_=X2-1/2;
      #local Y2_=Y2-1/2;
      isosurface {
        function {
          abs(sqrt(z*z+
            select(x-X1_,
              select(y-Y1_,
                pipe_torus_f(x-X1_, y-Y1_),
              //
              select(y-Y2_,
                pipe_torus_f(x-X1_, mod(y,1)-1/2),
                pipe_torus_f(x-X1_, y-Y2_))),
            select(x-X2_,
              select(y-Y1_,
                pipe_torus_f(mod(x,1)-1/2, y-Y1_),
              select(y-Y2_,
                min(pow(mod(x+1/2,1)-1/2,2),pow(mod(y+1/2,1)-1/2,2)),
              //
                pipe_torus_f(mod(x,1)-1/2, y-Y2_))),
            //
              select(y-Y1_,
                pipe_torus_f(x-X2_, y-Y1_),
              //
              select(y-Y2_,
                pipe_torus_f(x-X2_, mod(y,1)-1/2),
                pipe_torus_f(x-X2_, y-Y2_))))))
          -mean_pipe_rad)}
        threshold half_pipe_thick
        contained_by {box {<X1,Y1,0>-1/2 <X2,Y2,0>+1/2}}
    #end
  #end
    glass(the_colour)
    no_shadow
  }
#end

#macro message1(X,Y,d1,d2)	// d1,d2: direction
				// 0=down, 1=right, 2=up, 3=left
				// d1<d2 required
  object {
    #switch(d1)
      #case (0)
        #switch (d2)
          #case (1)		// down to right
            #local trans_x = function(x,y,z) {curve_x(-y-1/2,-x)+pi/8}
            #local trans_y = function(x,y,z) {curve_y(-y-1/2,-x)}
            #local trans_z = function(x,y,z) {z}
            #break
          #case (2)		// down to up
            #local trans_x = function(x,y,z) {y};
            #local trans_y = function(x,y,z) {x};
            #local trans_z = function(x,y,z) {z}
            #break
          #case (3)		// down to left
            #local trans_x = function(x,y,z) {curve_x(-x-1/2,y)+pi/8}
            #local trans_y = function(x,y,z) {curve_y(-x-1/2,y)}
            #local trans_z = function(x,y,z) {z}
            #break
        #end
        #break
      #case (1)
        #if (d2=2)		// right to up
          #local trans_x = function(x,y,z) {curve_x(x-1/2,-y)+pi/8}
          #local trans_y = function(x,y,z) {curve_y(x-1/2,-y)}
          #local trans_z = function(x,y,z) {z}
        #else			// right to left
          #local trans_x = function(x,y,z) {x};
          #local trans_y = function(x,y,z) {y};
          #local trans_z = function(x,y,z) {z}
        #end
        #break
      #case (2)			// up to left
        #local trans_x = function(x,y,z) {curve_x(y-1/2,x)+pi/8}
        #local trans_y = function(x,y,z) {curve_y(y-1/2,x)}
        #local trans_z = function(x,y,z) {z}
        #break
    #end
    message(trans_x,trans_y,trans_z)
    translate <X,Y,0>
  }
#end

#macro message2(X1,Y1,X2,Y2,d1,d2)
  object {
    #if(X1=X2)	// assume Y2=Y1+1, d1 among 0,1,3, d2 among 1,2,3
      #local trans_x = function(x,y,z)
        {select(y,
          #switch (d1)	// lower part
            #case(0)
              y
              #break
            #case(1)
              curve_x(y,-x)
              #break
            #case(3)
              curve_x(y,x)
              #break
          #end,
          #switch (d2)	// upper part
            #case(1)
              curve_x(y,-x)
              #break
            #case(2)
              y
              #break
            #case(3)
              curve_x(y,x)
              #break
          #end)}
      #local trans_y = function(x,y,z)
        {select(y,
          #switch (d1)	// lower part
            #case(0)
              x
              #break
            #case(1)
              curve_y(y,-x)
              #break
            #case(3)
              curve_y(y,x)
              #break
          #end,
          #switch (d2)	// upper part
            #case(1)
              curve_y(y,-x)
              #break
            #case(2)
              x
              #break
            #case(3)
              curve_y(y,x)
              #break
          #end)}
    #else	// assume X2=X1+1, d1 among 0,2,3, d2 among 0,1,2
      #local trans_x = function(x,y,z)
        {select(x,
          #switch (d1)	// left part
            #case(0)
              curve_x(x,y)
              #break
            #case(2)
              curve_x(x,-y)
              #break
            #case(3)
              x
              #break
          #end,
          #switch (d2)	// left part
            #case(0)
              curve_x(x,y)
              #break
            #case(1)
              x
              #break
            #case(2)
              curve_x(x,-y)
              #break
          #end)}
      #local trans_y = function(x,y,z)
        {select(x,
          #switch (d1)	// left part
            #case(0)
              curve_y(x,y)
              #break
            #case(2)
              curve_y(x,-y)
              #break
            #case(3)
              y
              #break
          #end,
          #switch (d2)	// left part
            #case(0)
              curve_y(x,y)
              #break
            #case(1)
              y
              #break
            #case(2)
              curve_y(x,-y)
              #break
          #end)}
    #end
    #local trans_z = function (x,y,z) {z}
    message(trans_x,trans_y,trans_z)
    translate <X1+X2,Y1+Y2,0>/2
  }
#end

//
/// Now let's start
//

#local I=0;
#while (I<num_pipes)
  pipe(pipe_Data[I][0],pipe_Data[I][1],pipe_Data[I][2],pipe_Data[I][3])
  #local I=I+1;
#end

separators()

#local i=0;
#while (i<num_messages1)
  message1(message1_Data[i][0],message1_Data[i][1],
    message1_Data[i][2],message1_Data[i][3])
  #local i=i+1;
#end

#local i=0;
#while (i<num_messages2)
  message2(message2_Data[i][0],message2_Data[i][1],message2_Data[i][2],
    message2_Data[i][3],message2_Data[i][4],message2_Data[i][5])
  #local i=i+1;
#end


