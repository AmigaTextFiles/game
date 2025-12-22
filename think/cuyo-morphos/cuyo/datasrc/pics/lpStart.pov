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

#include "rohrpost.inc"

camera {
  orthographic
  location 0
  direction z
  right 4*x
  up 20*y

  translate <1.5,9.5,-10>
}

#declare num_pipes = 12;
#declare pipe_Data = array[num_pipes][4] {
    {0,0,3,2},
    {0,3,3,3},
    {0,4,3,6},
    {0,7,3,7},
    {0,8,0,11},
    {1,8,3,11},
    {0,12,0,15},
    {1,12,3,15},
    {0,16,0,18},
    {1,16,3,18},
    {0,19,0,19},
    {1,19,3,19}
  };

#macro pipe(X1,Y1,X2,Y2)
  #local X1_=X1+1/2;
  #local Y1_=Y1+1/2;
  #local X2_=X2-1/2;
  #local Y2_=Y2-1/2;
  isosurface {
    function {
      abs(sqrt(
        select(z,
          #if ((X1=X2) & (Y1=Y2))
            pow(mod(x+1/2,1)-1/2,2)+pow(mod(y+1/2,1)-1/2,2)+z*z
          #else
            min (
              #if (X1=X2)
                1
              #else
                pow(mod(y+1/2,1)-1/2,2)+
                select(x-X1_,
                  pipe_torus_f(x-X1_,z),
                select(x-X2_,
                  pipe_torus_f(mod(x,1)-1/2,z),
                  pipe_torus_f(x-X2_,z)))
              #end,
              #if (Y1=Y2)
                1
              #else
                pow(mod(x+1/2,1)-1/2,2)+
                select(y-Y1_,
                  pipe_torus_f(y-Y1_,z),
                select(y-Y2_,
                  pipe_torus_f(mod(y,1)-1/2,z),
                  pipe_torus_f(y-Y2_,z)))
              #end)
          #end
          ,1
//          pow(mod(x+1/2,1)-1/2,2)+pow(mod(y+1/2,1)-1/2,2)
))
      -mean_pipe_rad)}
    threshold half_pipe_thick
    contained_by {box {<X1,Y1,-1/2>-1/2 <X2,Y2,2>+1/2}}
    glass(1)
    no_shadow
  }
#end

#local trans_x = function(x,y,z) {curve_x(y-1/2,-z)+pi/8};
#local trans_y = function(x,y,z) {curve_y(y-1/2,-z)};
#local trans_z = function(x,y,z) {x};
#declare messages1 =
  union {
    #local X=-3/2;
    #while (X<2)
      #local Y=-3/2;
      #while (Y<2)
        object {message(trans_x,trans_y,trans_z)  translate <X,Y,-1/2>}
        #local Y=Y+2;
      #end
      #local X=X+1;
    #end
  }

#local trans__x = function(x,y,z) {curve_x(y,-z)};
#local trans__y = function(x,y,z) {curve_y(y,-z)};
#local trans__z = function(x,y,z) {x};
#declare messages2 =
  union {
    #local X=-3/2;
    #while (X<2)
      #local Y=-1;
      #while (Y<2)
        object {message(trans__x,trans__y,trans__z)  translate <X,Y,-1/2>}
        #local Y=Y+2;
      #end
      #local X=X+1;
    #end
  }

#local trans___x = function(x,y,z) {z};
#local trans___y = function(x,y,z) {y};
#local trans___z = function(x,y,z) {x};


//
/// Now let's start
//

#local I=0;
#while (I<num_pipes)
  pipe(pipe_Data[I][0],pipe_Data[I][1],pipe_Data[I][2],pipe_Data[I][3])
  #local I=I+1;
#end


//separators()


object {messages1 rotate 90*z translate <3/2,3/2,0>}
object {messages1 rotate 270*z translate <3/2,3/2,0>}
object {messages2 rotate 90*z translate <3/2,11/2,0>}
object {messages1 translate <3/2,19/2,0>}
object {messages1 rotate 180*z translate <3/2,19/2,0>}
object {messages2 translate <3/2,27/2,0>}

#local X=0;
#while (X<=3)
  #local Y=0;
  #while (Y<=19)
    union {
      object {message(trans___x,trans___y,trans___z)  translate 2*z}
      difference {
        cylinder {0 3*z outer_pipe_rad}
        union {
          cylinder {-z 4*z inner_pipe_rad}
          torus {mean_pipe_rad half_pipe_thick rotate 90*x}
        }
        pigment {rgb 0}
      }
      no_shadow
      translate <X,Y,0>
    }
    #local Y=Y+1;
  #end
  #local X=X+1;
#end

