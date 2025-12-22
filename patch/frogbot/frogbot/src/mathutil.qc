#ifdef QUAKE
/*
===========
FixedAngle

Fixes a bug in Quake when "self.fixangle == TRUE"
assume v is rounded
============
*/
float(float v) FixedAngle =
{
	v = v + 1.40625;	// 1.40625 = 360 / 256

	if (v >= 0)
		return (ceil(v));
	else
		return (floor(v));
};

/*
===========
FixedAngle2

Fixes a bug in Quake when "self.fixangle == TRUE"
============
*/
float(float v) FixedAngle2 =
{
	v = (rint( v / 1.40625 ) + 1) * 1.40625;	// 1.40625 = 360 / 256

	if (v >= 0)
		return (ceil(v));
	// .angle_y (next frame) = (floor( floor(.angle_y) / 1.40625 ) - 1) * 1.40625
	//                        = rint( .real_angles_y / 1.40625 ) * 1.40625

	else
		return (floor(v));
	// .angle_y (next frame) = (ceil( ceil(.angle_y) / 1.40625 ) - 1) * 1.40625
	//                        = rint( .real_angles_y / 1.40625 ) * 1.40625
};
#endif // QUAKE
