
(*#################################*)
 IMPLEMENTATION MODULE CaptureSpecs;        (* $VER: CaptureSpecs.mod 0.0 (5.12.2010) *)
(*#################################*)

FROM SimpleGraphics  IMPORT XY;

(*=======================================*)
 PROCEDURE IsHidden(lin:LineSeg):BOOLEAN;
(*=======================================*)

BEGIN

RETURN (ABS(lin.p1[X]-lin.p2[X]) = ScreenSize) OR (ABS(lin.p1[Y]-lin.p2[Y]) = ScreenSize);

END IsHidden;

END CaptureSpecs.

