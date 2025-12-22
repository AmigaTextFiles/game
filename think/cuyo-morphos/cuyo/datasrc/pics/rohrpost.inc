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

global_settings {
  max_trace_level 100
}

light_source {
  <-1,1,-1>*1000
  1
  parallel
  point_at 0
}

light_source {
  <0,0,1>*1000
  1
  parallel
  point_at 0
}

#declare outer_pipe_rad = 1/3;
#declare inner_pipe_rad = 1/4;
#declare mean_pipe_rad = (outer_pipe_rad+inner_pipe_rad)/2;
#declare half_pipe_thick = (outer_pipe_rad-inner_pipe_rad)/2;
#declare pipe_cross_lift = outer_pipe_rad;
#declare mess_len = 2/3;
#declare mess_round = 1/10;
#declare mess_ring_pos = 1/2;
#declare mess_ring_len = 1/4;
#declare mess_ring_thick = 1/15;


#declare pipe_torus_f=function(X,Y) {
  pow(sqrt(X*X+Y*Y)-1/2,2)}



#macro separator(X1,Y1,X2,Y2)
  polygon {
    5
    <X1,Y1,100> <X2,Y2,100> <X2,Y2,-100> <X1,Y1,-100> <X1,Y1,100>
    pigment {rgb 0}
    no_shadow
  }
#end


#declare round_corner_F = function(R,x,y)
  {select(x,
    select(y,
      0,
      y),
    select(y,
      x,
      sqrt(pow(x,2)+pow(y,2))))}

#declare round_cyl_F = function(L,W,R,x,y,z)
  {round_corner_F(R, abs(x)-L+R, sqrt(pow(y,2)+pow(z,2))-W+R)-R}

#declare curve_x = function(x,y)
  {atan2(x,y+1/2)/2}
#declare curve_y = function(x,y)
  {sqrt(pow(x,2)+pow(y+1/2,2))-1/2}

#macro message(trans_x,trans_y,trans_z)
  union {
    isosurface {
      function {round_cyl_F(
        mess_len/2,inner_pipe_rad-mess_ring_thick,mess_round,
        trans_x(x,y,z),trans_y(x,y,z),trans_z(x,y,z))}
      contained_by {box {-1/2 1/2}}
      max_gradient 5
    }
    isosurface {
      function {round_cyl_F(
        mess_len*mess_ring_len/2,inner_pipe_rad-1/1000,mess_round,
        abs(trans_x(x,y,z))-mess_len*mess_ring_pos/2,
        trans_y(x,y,z),
        trans_z(x,y,z))}
      contained_by {box {-(1/2-1/1000) 1/2-1/1000}}
      max_gradient 5
    }
    pigment {color <1,1,1,0,0>}
    no_shadow
  }
#end

#macro glass(col)
  texture {
    pigment {color <0,0,0,0,1>}
    finish {specular 0.3 roughness 0.06}
  }
  interior_texture {
    pigment {color <0,0,0,0,1>}
  }
  interior {
    ior 1.5
    media {
      scattering {1 rgb col}
      absorption rgb (1-col)*2
    }
  }
  hollow
#end

#macro separators()
  #local i=0;
  #while (i<num_pipes)
    separator(pipe_Data[i][0]-1/2,pipe_Data[i][1]-1/2,
      pipe_Data[i][2]+1/2,pipe_Data[i][1]-1/2)
    separator(pipe_Data[i][0]-1/2,pipe_Data[i][1]-1/2,
      pipe_Data[i][0]-1/2,pipe_Data[i][3]+1/2)
    #local i=i+1;
  #end
#end


