// MORTAR sky background (w) 1998-1999 by Eero Tamminen

#include "colors.inc"
#include "textures.inc"

 
cylinder {
	-8*x, 8*x, 2
	texture {
		pigment { Bright_Blue_Sky }
		normal {
			bozo 0.05
			scale 0.1
		}
		scale 0.6
	}
	scale <1, 1, 2>
	hollow
}

fog {
	fog_type 2
	color rgb <0.9, 0.91, 0.9>
	fog_offset 0.2
	fog_alt 0.8
	distance 1.1
	turbulence 10
}


camera {
  location  <0, 1.6, -1>
  look_at   <0, 1.6, 1>
}

light_source { <0, 0, 0>  color 2*White }
