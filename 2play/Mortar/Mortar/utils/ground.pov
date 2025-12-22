// MORTAR rock background (w) 1998-1999 by Eero Tamminen

#include "colors.inc"
#include "textures.inc"


// use either of these
#declare P_brown = pigment { Brown_Agate }
#declare P_gray  = pigment {
	agate
	color_map {
		[0.0 Black]
		[1.0 White]
	}
}


#declare T_ground =
texture {
	pigment {
		P_brown
		scale 0.03
	}
	normal  {
		agate 0.7
		scale 0.03
	}
	finish{
		phong 1
		phong_size 200
	}
}

cylinder {
	-x, x, 1
	texture { T_ground }
}

camera {
  location  <0, 0.4, -1.4>
  look_at   <0, 0.4, 0>
}

light_source { <300, 500, -500> color White }
light_source { <-50,  10, -500> color White }
