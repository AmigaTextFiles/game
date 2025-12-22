// title.pov

// POVRay definition of Entombed!'s title screen
// Bill Kendrick
// bill@newbreedsoftware.com

// May 5, 2002 - May 18, 2002


#include "colors.inc"
#include "stones.inc"

camera
{
  location <0, 1.8, -3>
  look_at  <0, 1,  2>
  up       <0, 1.333,  0>  // for the 240x320...
  right    <1, 0,  0>      // ...aspect ratio
}

light_source {
  <3, 4, -2>
  color White
  spotlight
  radius 10
  falloff 15
  tightness 20
  point_at <-1, 1, 0>
}

light_source {
  <2, 4, -3>
  color White
  spotlight
  radius 10
  falloff 15
  tightness 20
  point_at <0, 1, 0>
}

light_source {
  <-2, 3, 3>
  color White
}

//global_settings { ambient_light rgb<1, 0, 0> }
global_settings { ambient_light rgb<1, 1, 1> }


fog
{
  distance 2
  color rgbf <0.4, 0.5, 0.15, 0.1>
  turbulence 1
  turb_depth 0.3
  fog_type 2
  fog_offset 1.025
  fog_alt 0.05
}

text
{
  ttf "timrom.ttf" "ENTOMBED!" 0.1, 0
  rotate -20*x

  translate -3*x
  scale .45
  translate 2.75*y
  
  pigment { Green }
  finish { reflection 1 specular 1 }
}

light_source {
  <1, 3, 0>
  color White
  spotlight
  radius 10
  falloff 50
  tightness 100
  point_at <0, 2.75, 0>
}

box
{
  <-4.00,  0.5,  1>
  < 1.00,  2.5,  3>

  pigment { Yellow }

  normal
  {
    bump_map
    {
      gif "brick-bumpmap.gif"
      bump_size 2
    }
  }

  rotate y*45
  translate x*1
}


box
{
  <-2.0, 0.5,  0.25>
  < 0.0, 2.5,  2.25>

  pigment { Yellow }

  normal
  {
    bump_map
    {
      gif "brick-bumpmap.gif"
      bump_size 2
    }
  }

  rotate y*-60
}


plane
{
  <0, 1, 0>, 0.5
  texture { T_Stone4 }
}

