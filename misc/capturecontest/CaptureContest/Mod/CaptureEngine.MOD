
(* Question: do we Limit the velocity of a bumper even in a collision to 24? *)

(*###################################*)
 IMPLEMENTATION MODULE CaptureEngine;        (* $VER: CaptureEngine.mod 0.0 (5.2.2011) *)
(*##################################*)

FROM SYSTEM          IMPORT ADR;
FROM Assertions      IMPORT Assert;
FROM Debugging       IMPORT Debug, DebugOff, DebugOn, DebugPause;
FROM CaptureDebug    IMPORT (*DebugBumper,*) DebugLine, DebugPoint, (*DebugPuck,*) DebugReal, DebugReal2,
                            LineFeed, PrintInt, PrintLine, PrintMsg, PrintPoint,
                            PrintReal(*, PrintSledState*);

FROM RealMath        IMPORT arctan, cos, pi, sin, sqrt;

FROM CaptureDefs     IMPORT CollideInfo, CollideObj, MovingObjectInfo, MovingObjects, ObjectInfo, ObjInfoPtr,
                            SledInfo, Sleds, StepsPerTurn;
FROM CaptureSpecs    IMPORT BlueSledIndex, BumperIndices, BumperMass, BumperRadius, GameColors, IsHidden, LineSeg,
                            MaxBumperVelocity, MaxBumperVelocDelta, MaxSledTrailLen, MaxSledTurn,
                            NumBumpers, NumPucks, NumWalls, ObjSpecs, ObjSpecsPtr, Point,
                            PuckFriction, PuckMass, PuckRadius, RedSledIndex, ScreenSize, SledSpecs, SledVelocity,
                            TrailMaxPoints;

FROM MaxMin          IMPORT minc;
FROM SimpleGraphics  IMPORT XY;

(*DEBUG*)IMPORT STextIO, SRealIO, SWholeIO;

CONST NoVelocityLimit = 0.0;

TYPE LinePointsRelation = (sameSide, oppositeSides, onLine);
     LinesRelation = (intersecting, nonintersecting, collinear);

(*CONST ScreenHigh = ScreenSize - 1.0;*)

TYPE LoopPuckInfo    = RECORD
                         pos     :Point;
                         puckInx :CARDINAL;
                       END;
VAR  LoopPucks        :ARRAY [0..NumPucks-1] OF LoopPuckInfo;

VAR  LoopUnwrapped    :ARRAY [0..TrailMaxPoints(*-1*)] OF Point;

VAR  StepsPerTurnF :REAL;

TYPE DistType = RECORD
                  dist,
                  distsqu :REAL;
                END;

CONST CollisionDistFudge = 10.0;
VAR  MaxCollisionDist :ARRAY CollideObj, CollideObj OF DistType;     (* if these two obj types are farther apart than this distance *)
     MaxPuckVelocity  :REAL; (* roughly *)                           (* before the step, then don't test for a collision *)

CONST  DEBUG          = FALSE;
       DEBUGLOOP      = FALSE;
       DEBUGINTERSECT = FALSE;
       DEBUGCOLLIDEBUMPERS      = FALSE;
       DEBUGCOLLIDEBUMPERPUCK   = FALSE;
       DEBUGCOLLIDEBUMPERWALL   = FALSE;
       DEBUGTRACE = FALSE;

(*----------------------------------------*)
 PROCEDURE minr(r1, r2:REAL):REAL;
(*----------------------------------------*)
BEGIN
   IF r1 > r2 THEN
      RETURN r2;
   ELSE
      RETURN r1;
   END;
END minr;

(*----------------------------------------*)
 PROCEDURE maxr(r1, r2:REAL):REAL;
(*----------------------------------------*)
BEGIN
   IF r1 < r2 THEN
      RETURN r2;
   ELSE
      RETURN r1;
   END;
END maxr;

(*----------------------------------*)
 PROCEDURE sqr(a:REAL):REAL;
(*----------------------------------*)
BEGIN

RETURN a*a;

END sqr;

(*---------------------------------*)
 PROCEDURE sgn(a:REAL):REAL;
(*---------------------------------*)
BEGIN

IF a < 0.0 THEN
   RETURN -1.0;
END;

RETURN 1.0;

END sgn;

(*
(*------------------------------------------------------------------*)
 PROCEDURE SameSide(lin:LineSeg; p1, p2:Point):LinePointsRelation;
(*------------------------------------------------------------------*)
                     (* from Sedgwick, Algorithms, 1983 Addison Wesley *)
                     (* this are for unbounded lines *)
VAR  dx,  dy,
     dx1, dy1,
     dx2, dy2 :REAL;
     sameTest :REAL;

BEGIN

dx := lin.p2[X] - lin.p1[X];
dy := lin.p2[Y] - lin.p1[Y];

dx1 := p1[X] - lin.p1[X];           
dy1 := p1[Y] - lin.p1[Y];

dx2 := p2[X] - lin.p2[X];           
dy2 := p2[Y] - lin.p2[Y];

sameTest := (dx*dy1 - dy*dx1) * (dx*dy2 - dy*dx2);    (* first/second term is 0 if p1/p2 is on the line *)
                                                      (* terms are positive/negative is point is on one or other side of the line *)
(*PrintReal("sameTest", sameTest);*)

IF sameTest > 0.01 THEN                     (* this does not help *)
   RETURN sameSide;
ELSIF sameTest < -0.01 THEN
   RETURN oppositeSides;
ELSE (*sameTest = 0.0*)
   RETURN onLine;
END;

END SameSide;
*)

(*------------------------------------------------------------------------------*)
 PROCEDURE FindIntersect(lin1, lin2:LineSeg; VAR IntersectPoint:Point):BOOLEAN;
(*------------------------------------------------------------------------------*)
                               (* returns FALSE if lines paralles or the intersection is not on the line segments themselves *)
                   (* using simultaneous equation solution for the parametric representation of line segments,
                      (1-u)*point1 + u*point2 and (1-v)*point3 + v*point4
                      see Angell, Ian, "A Practical Introduction to Computer Graphics", Wiley and Sons, 1981 *)

VAR delta,
    u, l      :REAL;

BEGIN

IntersectPoint[X] := -1.0;
IntersectPoint[Y] := -1.0;

(* u = [(x3-x1)*(y3-y4)-(x3-x4)*(y3-y1)] / delta
where
   delta = (x2-x1)*(y3-y4)-(x3-x4)*(y2-y1)
if delta is 0, the lines are parallel
*)

delta := (lin1.p2[X]-lin1.p1[X])*(lin2.p1[Y]-lin2.p2[Y]) - (lin2.p1[X]-lin2.p2[X])*(lin1.p2[Y]-lin1.p1[Y]);
IF DEBUGINTERSECT THEN PrintReal("delta=", delta); LineFeed; END;

IF ABS(delta) < 0.01 THEN
   IF DEBUGINTERSECT THEN PrintReal(" delta is 0", delta) END;
   RETURN FALSE;
END;

u := ((lin2.p1[X]-lin1.p1[X])*(lin2.p1[Y]-lin2.p2[Y]) - (lin2.p1[X]-lin2.p2[X])*(lin2.p1[Y]-lin1.p1[Y])) / delta;
IF DEBUGINTERSECT THEN PrintReal("u=", u); END;

IF lin2.p1[X] = lin2.p2[X] THEN
   l := 0.0;
   (*PrintReal("u=", u);*)
   (*PrintReal("   l=", l); LineFeed;*)
   (*DebugReal("div by 0 for l ", 0, lin2.p1[X]);*)
ELSE
   l := ((lin2.p1[X]-lin1.p1[X]) - u*(lin1.p2[X]-lin1.p1[X])) / (lin2.p1[X]-lin2.p2[X]);
END;
IF DEBUGINTERSECT THEN PrintReal("   l=", l); LineFeed; END;

IF (u > 1.0) OR (u < 0.0) OR (l > 1.0) OR (l < 0.0) THEN
   IF DEBUGINTERSECT THEN DebugPause("FindIntersect u/l is not between 0.0 and 1.0", 0); END;
   RETURN FALSE;
END;

IntersectPoint[X] := (1.0-u)*lin1.p1[X] + u*lin1.p2[X];
IntersectPoint[Y] := (1.0-u)*lin1.p1[Y] + u*lin1.p2[Y];

(*PrintMsg("FoundIntersect"); PrintLine(" lin1:", lin1); PrintLine(" lin2:", lin2); LineFeed;*)
(*PrintPoint("ip:", IntersectPoint); LineFeed;*)
RETURN TRUE;

END FindIntersect;

(*---------------------------------------------------------------------------------*)
 PROCEDURE TstIntersect(lin1, lin2:LineSeg; VAR IntersectPoint:Point):LinesRelation;
(*---------------------------------------------------------------------------------*)
                     (* from Sedgwick, Algorithms, 1983 Addison Wesley *)
                     (* this are for unbounded lines *)
VAR  (*lin1WRTlin2,
     lin2WRTlin1    :LinePointsRelation;*)

     hiX, loX,
     hiY, loY       :REAL;
     retRes         :LinesRelation;

BEGIN

(*Debug("TstIntersect", 0);*)
(*DebugReal2("lin1.p1", 0, lin1.p1[X], lin1.p1[Y]);*)
(*DebugReal2("lin1.p2", 0, lin1.p2[X], lin1.p2[Y]);*)

(*DebugReal2("lin2.p1", 0, lin2.p1[X], lin2.p1[Y]);*)
(*DebugReal2("lin2.p2", 0, lin2.p2[X], lin2.p2[Y]);*)
IF DEBUGLOOP THEN PrintLine("TstIntersect line1", lin1); PrintLine("TstIntersect line2", lin2); END;

(*
lin1WRTlin2 := SameSide(lin1, lin2.p1, lin2.p2);
lin2WRTlin1 := SameSide(lin2, lin1.p1, lin1.p2);

Debug("lin1WRTlin2", ORD(lin1WRTlin2));
Debug("lin2WRTlin1", ORD(lin2WRTlin1));
IF DEBUGLOOP THEN PrintMsg("lin1WRTlin2", ORD(lin1WRTlin2)); PrintMsg("lin2WRTlin1", ORD(lin2WRTlin1)); END;

IF (lin1WRTlin2 = sameSide) OR (lin2WRTlin1 = sameSide) THEN
   retRes := nonintersecting;
ELSIF ((lin1WRTlin2 = onLine) AND (lin2WRTlin1 = onLine)) THEN
   retRes := collinear;
ELSE
   retRes := intersecting;
END;
*)

IF NOT FindIntersect(lin1, lin2, IntersectPoint) THEN

   retRes := nonintersecting;
   IntersectPoint[X] := -1.0;
   IntersectPoint[Y] := -1.0;

ELSE
   IF lin1.p1[X] > lin1.p2[X] THEN
      hiX := lin1.p1[X];
      loX := lin1.p2[X];
   ELSE
      loX := lin1.p1[X];
      hiX := lin1.p2[X];
   END;
   IF lin1.p1[Y] > lin1.p2[Y] THEN
      hiY := lin1.p1[Y];
      loY := lin1.p2[Y];
   ELSE
      loY := lin1.p1[Y];
      hiY := lin1.p2[Y];
   END;
   DebugPoint("IntersectPoint", IntersectPoint);
   IF (IntersectPoint[X] <= hiX) AND (IntersectPoint[X] >= loX)
             AND (IntersectPoint[Y] <= hiY) AND (IntersectPoint[Y] >= loY) THEN   (* Y necessary? *)
      retRes := intersecting;
   ELSE
      retRes := nonintersecting;
      IntersectPoint[X] := -1.0;
      IntersectPoint[Y] := -1.0;
   END;
END;

IF DEBUGLOOP THEN PrintInt("retRes", ORD(retRes)); LineFeed; END;
RETURN retRes;

END TstIntersect;

(*-------------------------------------------------------------------------------*)
 PROCEDURE NewVelocityToComponents(Velocity:REAL; VAR xComp, yComp:REAL);
(*-------------------------------------------------------------------------------*)

VAR  ratio :REAL;

BEGIN

IF Velocity # 0.0 THEN

   IF xComp = 0.0 THEN
      yComp := sgn(yComp) * Velocity;
   ELSIF yComp = 0.0 THEN
      xComp := sgn(xComp) * Velocity;
   ELSE
      ratio := ABS(yComp/xComp);
      xComp := sgn(xComp) * Velocity / sqrt(1.0+sqr(ratio));
      yComp := sgn(yComp) * ABS(xComp) * ratio;
   END;

ELSE

   xComp := 0.0;
   yComp := 0.0;

END;

END NewVelocityToComponents;

(*------------------------------------------------------------------*)
 PROCEDURE ComponentsToDirection(components:Point; VAR radians:REAL);
(*------------------------------------------------------------------*)
                (* assume vector starts from 0,0 *)
                (* always returns a positive (counterclockwise) angle *)
BEGIN

IF ABS(components[X]) < 1.0E-6 THEN
   IF components[Y] > 0.0 THEN
      radians := pi;
   ELSIF components[Y] < 0.0 THEN
      radians := -pi;
   ELSE
      Assert(FALSE, "ComponentsToDirection: point input");
   END;
ELSE
   radians := arctan(components[Y] / components[X]);
   (*NG, use the best trig func*)           (* [-pi/2, pi/2] *)
END;

IF components[X] < 0.0 THEN

   radians := radians + pi;

END;

END ComponentsToDirection;

(*-----------------------------------------------------------------*)
 PROCEDURE LimitVeloc(VAR xSpeed, ySpeed:REAL; MaxVeloc:REAL):REAL;
(*-----------------------------------------------------------------*)

VAR  velocReturn :REAL;

BEGIN

velocReturn := sqrt(sqr(xSpeed)+sqr(ySpeed));

IF (MaxVeloc # NoVelocityLimit) AND (velocReturn > MaxVeloc) THEN

   velocReturn := MaxVeloc;

   NewVelocityToComponents(velocReturn, xSpeed, ySpeed);

END;

RETURN velocReturn;

END LimitVeloc;

(*==============================================*)
 PROCEDURE ReflectDirection(dir:REAL):REAL;
(*==============================================*)
    (* returns direction (in radians) reflected on X axis *)
    (* for translating Blue player's sled to "Red" on input/output to him *)

VAR
     ret    :REAL;

BEGIN

(*DebugOn(0);
DebugReal2("ReflectSled Before speed", ORD(WhichSled), infoS[WhichSled].speed[X], infoS[WhichSled].speed[X]);
*)
(*
rpoint[X] := -infoS[WhichSled].speed[X];
rpoint[Y] := infoS[WhichSled].speed[Y];

ComponentsToDirection(rpoint, ret);
*)

ret := pi - dir;

RETURN ret;

END ReflectDirection;

(*====================================================*)
 PROCEDURE TurnSled(WhichSled:CARDINAL; radians:REAL);
(*====================================================*)
       (* note: negative radians means turn left, positive turn right *)

BEGIN WITH Sleds DO

(*IF WhichSled = 0 THEN DebugOn(0); END;*)
DebugReal("TurnSled: radians", 0, radians);

IF ABS(radians) > MaxSledTurn THEN
   radians := sgn(radians) * MaxSledTurn;
END;

DebugReal("TurnSled: limited radians", 0, radians);
DebugReal("TurnSled: cur direct", 0, specsS[WhichSled].direct);

specsS[WhichSled].direct := specsS[WhichSled].direct (*+*)- radians;                  (* note above *)

DebugReal("TurnSled: new direct", 0, specsS[WhichSled].direct);

infoS[WhichSled].speed[X] := cos(specsS[WhichSled].direct) * infoS[WhichSled].veloc;
infoS[WhichSled].speed[Y] := sin(specsS[WhichSled].direct) * infoS[WhichSled].veloc;

DebugReal2("TurnSled: speedXY", 0, infoS[WhichSled].speed[X], infoS[WhichSled].speed[Y]);

END END TurnSled;

(*===============================================================*)
 PROCEDURE AccelBumper(WhichBumper:CARDINAL; xaccel, yaccel:REAL);
(*===============================================================*)

VAR  velocdelta :REAL;

BEGIN WITH MovingObjects[BumperObj] DO

velocdelta := LimitVeloc(xaccel, yaccel, MaxBumperVelocDelta);   (* maximum step accel is 8.0 *)

infoB^[WhichBumper].speed[X] := infoB^[WhichBumper].speed[X] + xaccel;
infoB^[WhichBumper].speed[Y] := infoB^[WhichBumper].speed[Y] + yaccel;

infoB^[WhichBumper].veloc := LimitVeloc(infoB^[WhichBumper].speed[X], infoB^[WhichBumper].speed[Y], MaxBumperVelocity);

END END AccelBumper;

(*----------------------------------------------------------*)
 PROCEDURE DoUnitNormal(obj1, obj2:Point; VAR un, ut:Point);
(*----------------------------------------------------------*)

VAR VecLen :REAL;

BEGIN

un[X] := obj1[X] - obj2[X];
un[Y] := obj1[Y] - obj2[Y];

IF DEBUG THEN DebugOn(0); END;
(*DebugReal2("DoUnitNormal X", 0, obj1[X], obj2[X]);*)
(*DebugReal2("DoUnitNormal Y", 0, obj1[Y], obj2[Y]);*)

VecLen := sqrt(un[X]*un[X] + un[Y]*un[Y]);

(*DebugReal("VecLen", 0, VecLen);*)

un[X] := un[X] / VecLen;
un[Y] := un[Y] / VecLen;

ut[X] := -un[Y];
ut[Y] := un[X];

END DoUnitNormal;

(*--------------------------------------------------------------------*)
 PROCEDURE VectorizeVelocity(v:REAL; unit:Point; VAR VelocVec:Point);
(*--------------------------------------------------------------------*)

BEGIN

VelocVec[X] := v * unit[X];
VelocVec[Y] := v * unit[Y];

END VectorizeVelocity;

(*--------------------------------------*)
 PROCEDURE DotProduct(a, b:Point):REAL;
(*--------------------------------------*)

BEGIN

RETURN a[X]*b[X] + a[Y]*b[Y];

END DotProduct;

(*--------------------------------------------------------------*)
 PROCEDURE OneDCollision(m1, m2, v1, v2:REAL; VAR vp1, vp2:REAL);
(*--------------------------------------------------------------*)
(*
*)

BEGIN

vp1 :=  ((m1-m2)*v1 + 2.0*m2*v2) / (m1+m2);
vp2 :=  ((m2-m1)*v2 + 2.0*m1*v1) / (m1+m2);

END OneDCollision;

(*-------------------------------------------------------------------------------------*)
 PROCEDURE StepObject(ot:CollideObj; VAR oInfo:ObjectInfo; VAR oSpecs:ObjSpecs; t:REAL);
(*-------------------------------------------------------------------------------------*)
BEGIN WITH oInfo DO
IF DEBUGTRACE THEN STextIO.WriteString("StepObject -> "); END;

IF (prevveloc # 0.0) THEN

   IF NOT oSpecs.moved THEN

      oSpecs.pos[X] := prevpos[X] + t*speed[X]/StepsPerTurnF;
      oSpecs.pos[Y] := prevpos[Y] + t*speed[Y]/StepsPerTurnF;

      IF ot = PuckObj THEN

         IF veloc < 0.0 THEN                                (* move this out and do it at the loop end? *)
            veloc := prevveloc + t*PuckFriction/StepsPerTurnF;
            IF veloc > 0.0 THEN
               veloc := 0.0;
            END;
         ELSE
            veloc := prevveloc - t*PuckFriction/StepsPerTurnF;
            IF veloc < 0.0 THEN
               veloc := 0.0;
            END;
         END;

         NewVelocityToComponents(veloc, speed[X], speed[Y]);

      END;

   END;

END;

oSpecs.moved := FALSE;

IF DEBUGTRACE THEN STextIO.WriteString("<- StepObject"); STextIO.WriteLn; END;
END END StepObject;

(*--------------------------------*)
 PROCEDURE MoveObjects(t:REAL);
(*--------------------------------*)

VAR i :INTEGER;

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("MoveObjects -> "); END;

FOR i := MIN(BumperIndices) TO MAX(BumperIndices) DO
   StepObject(BumperObj, MovingObjects[BumperObj].infoB^[i], MovingObjects[BumperObj].specsB^[i], t);
END;

FOR i := 0 TO NumPucks-1 DO
   StepObject(PuckObj, MovingObjects[PuckObj].infoP^[i], MovingObjects[PuckObj].specsP^[i], t);
END;

IF DEBUGTRACE THEN STextIO.WriteString("<- MoveObjects"); STextIO.WriteLn; END;
END MoveObjects;

(*------------------------------------------------------------------------------*)
 PROCEDURE FindCollisionTime(lin1, lin2:LineSeg; r1, r2:REAL; VAR CollisionTime:REAL):BOOLEAN;
(*------------------------------------------------------------------------------*)
(* for quadratic equation,    ax^2 + bx + c = 0

   whose solution is x = (-b +/-sqrt(b^2-4ac)) / 2a

for the situation with two circles moving together, we want to know at what time (w/r/t the step) their
centers are exactly 2r distance apart.

Using a parametric expression of the path during the step of the two circles' centers, for a point on
the line (1-t)P1 + tP2, going from endpoints P1 to P2 (P3 to P4 for the other circle), the distance between
these two points can be expressed as

   sqrt([((1-t)x1+tx2)-((1-t)x3+tx4)]^2 + [((1-t)y1+ty2)-((1-t)y3+ty4)]^2)

which we want to be equal to 2r  (or r1+r2 if the radii are different).

manipulating this equation, without the sqrt(), and multiplying out the (1-t) we get

[(x1-tx1+tx2)-(x3-tx3+tx4)]^2 + [(y1-ty1+ty2)-(y3-ty3+ty4)]^2

factoring out the t we get

[x1+t(-x1+x2)-(x3+t(-x3+x4)]^2 + [y1+t(-y1+y2)-(y3+t(-y3+y4)]^2

rearrange to put the constants together

[x1-x3+t(-x1+x2)+t(x3-x4)]^2 + [y1-y3+t(-y1+y2)+t(y3-y4)]^2
[(x1-x3)+t(-x1+x2+x3-x4)]^2 + [(y1-y3)+t(-y1+y2+y3-y4)]^2

Multiplying out the squares
  (x1-x3)^2 + 2(x1-x3)(-x1+x2+x3-x4)t + (-x1+x2+x3-x4)^2t^2
+ (y1-y3)^2 + 2(y1-y3)(-y1+y2+y3-y4)t + (-y1+y2+y3-y4)^2t^2


Now let (x1-x3)        be const Lx
        (-x1+x2+x3-x4) be const Mx
        (y1-y3)        be const Ly
        (-y1+y2+y3-y4) be const My

LX := lin1.p1[X]-lin2.p1[X];
LY := lin1.p1[Y]-lin2.p1[Y];
MX := -lin1.p1[X]+lin1.p2[X]+lin2.p1[X]-lin2.p2[X];
MY := -lin1.p1[Y]+lin1.p2[Y]+lin2.p1[Y]-lin2.p2[Y];

we can express the quadratic equation as

    (Mx^2+My^2)t^2 + 2(LxMx+LyMy)t + (Lx^2+Ly^2)  = (r1+r2)^2 = r1^2+2r1r2+r2^2
                                                        for equal size circles, this reduces to 4r^2
                                                        for wall collisions to r^2

  so a is (Mx^2+My^2)
       b is 2(LxMx+LyMy)
       c is (Lx^2+Ly^2) - (r1+r2)^2

a := MX*MX + MY*MY;
b := 2.0*(LX*MX+LY*MY);
c := LX*LX + LY*LY -(r1*r2)^2;

discrim := b*b-4.0*a*c;

This is assuming straight paths during the step, and no acceleration.

*)

VAR a,
    b,
    c         :REAL;
    LX,
    MX,
    LY,
    MY        :REAL;
    discrim   :REAL;
    t1,
    t2        :REAL;
    bRes      :BOOLEAN;

BEGIN
(*DebugOn(0); DebugPause("FindCollisionTime", 0);*)
IF DEBUGTRACE THEN STextIO.WriteString("FindCollisionTime -> "); END;

(*a := lin1.p1[X]-lin2.p1[X];*)
(*b := lin1.p1[Y]-lin2.p1[Y];*)
(*DebugOn(0); DebugReal("PrevDist", 0, sqrt(a*a+b*b));*)
(*a := lin1.p2[X]-lin2.p2[X];*)
(*b := lin1.p2[Y]-lin2.p2[Y];*)
(*DebugReal("endDist", 0, sqrt(a*a+b*b));*)
(*a := 0.5*lin1.p1[X]+0.5*lin1.p2[X] - (0.5*lin2.p1[X]+0.5*lin2.p2[X]);*)
(*b := 0.4*lin1.p1[Y]+0.6*lin1.p2[Y] - (0.4*lin2.p1[Y]+0.6*lin2.p2[Y]);*)
(*DebugReal("t = 0.6", 0, sqrt(a*a+b*b));*)

LX := lin1.p1[X]-lin2.p1[X];
LY := lin1.p1[Y]-lin2.p1[Y];
MX := -lin1.p1[X]+lin1.p2[X]+lin2.p1[X]-lin2.p2[X];
MY := -lin1.p1[Y]+lin1.p2[Y]+lin2.p1[Y]-lin2.p2[Y];

a := MX*MX + MY*MY;
b := 2.0*(LX*MX+LY*MY);

c := LX*LX + LY*LY -(r1*r1+2.0*r1*r2+r2*r2);

discrim := b*b-4.0*a*c;

CollisionTime := -1.0;

IF (discrim < 0.0) OR (a = 0.0) THEN
   (*DebugReal("discriminant < 0", 0, discrim);*)
ELSE
   (*DebugOn(0);*)
   (*DebugReal("sqrt(discrim)", 0, sqrt(discrim));*)

   t2 := (-b - sqrt(discrim)) / (2.0*a);
   (*DebugReal("t2", 0, t2);*)

   (*DEBUG>>>>*)t1 := (-b + sqrt(discrim)) / (2.0*a);
   (*(*DEBUG>>>>*)DebugReal("t1", 0, t1);*)
   (*DEBUG>>>>*)IF (t1 < t2) THEN
   (*DEBUG>>>>*)   (*DEBUG*)DebugOn(0); DebugPause("Check this t1 and t2", 0);
   (*DEBUG>>>>*)   DebugReal("t2", 0, t2);
   (*DEBUG>>>>*)   DebugReal("t1", 0, t1);
   (*DEBUG>>>>*)END;

   IF t2 <= 1.0 THEN

      CollisionTime := t2;

   ELSE

      t1 := (-b + sqrt(discrim)) / (2.0*a);
      
      IF t1 <= 1.0 THEN

         CollisionTime := t1;

      (*ELSE*)
         (*(*DEBUG*)DebugOn(0); DebugPause("Check this t1 and t2", 0);*)
         (*DebugReal("t2", 0, t2);*)
         (*DebugReal("t1", 0, t1);*)
      END;
   END;

END;

IF DEBUGTRACE THEN STextIO.WriteString("<- FindCollisionTime"); STextIO.WriteLn; END;
bRes := (CollisionTime > 0.0);
IF bRes THEN
   (*(*DEBUG>>>>*)   DebugOn(0); DebugReal("t2", 0, t2);*)
   (*(*DEBUG>>>>*)   DebugReal("t1", 0, t1);*)
   RETURN TRUE;
ELSE
   RETURN FALSE;
END;

END FindCollisionTime;

(*-----------------------------------------------------------------------------------------------------------------*)
 PROCEDURE FindCollisionTimeWall(lin:LineSeg; r:REAL; WhichWall:CARDINAL;
                                 VAR CollisionTime:REAL):BOOLEAN;
(*-----------------------------------------------------------------------------------------------------------------*)
(* 
For the situation with a circle moving towards a wall, we want to know at what time (w/r/t the step) the
center of the circle is exactly r distance from the wall

Walls numbered    2222222222222222222222
                  3                    1
                  3                    1
                  3                    1
                  3                    1
                  3                    1
                  3                    1
                  3                    1
                  3                    1
                  0000000000000000000000

Using a parametric expression of the path during the step of the two circles' centers, for a point on
the line (1-t)P1 + tP2, going from endpoints P1 to P2, the distance between the center and the wall
can be expressed as

   (1-t)y1+ty2                 for wall 0, ie the normal to the wall is only the y distance
   ScreenSize - (1-t)x1+tx2    for wall 1, ie the normal to the wall is only the x distance
   ScreenSize - (1-t)y1+ty2    for wall 2
   (1-t)x1+tx2                 for wall 3

which we want to be equal to r.

manipulating this equation and multiplying out the (1-t) we get


t = t = (r-y1)/(y2-y1)                    for wall 0
t = (ScreenSize-r-x1)/(x2-x1)             for wall 1
t = (ScreenSize-r-y1)/(y2-y1)             for wall 2
t = (r-y1)/(y2-y1)                        for wall 3
 
This is assuming straight paths during the step, and no acceleration.

*)

VAR XDiv,
    YDiv      :REAL;
    bRes      :BOOLEAN;

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("FindCollisionTimeWall -> "); END;

IF DEBUGCOLLIDEBUMPERWALL THEN
   DebugPause("FindCollisionTimeWall", WhichWall);
   DebugReal("WhichRadius", 0, r);
   DebugLine("path", lin);
END;

CollisionTime := 6.0E6;

XDiv := lin.p2[X]-lin.p1[X];
YDiv := lin.p2[Y]-lin.p1[Y];

IF DEBUGCOLLIDEBUMPERWALL THEN
   DebugReal("XDiv", 0, XDiv);
   DebugReal("YDiv", 0, YDiv);
END;

IF ODD(WhichWall) THEN
   bRes := XDiv # 0.0;
ELSE
   bRes := YDiv # 0.0;
END;

IF bRes THEN
   CASE WhichWall OF
      0: CollisionTime := (r-lin.p1[Y])/YDiv;
         IF DEBUGCOLLIDEBUMPERWALL THEN
            DebugReal("r-lin.p1[Y]", 0, r-lin.p1[Y]);
         END;
         |
      1: CollisionTime := (ScreenSize-r-lin.p1[X])/XDiv;
         IF DEBUGCOLLIDEBUMPERWALL THEN
            DebugReal("ScreenSize-r-lin.p1[X]", 1, ScreenSize-r-lin.p1[X]);
         END;
         |
      2: CollisionTime := (ScreenSize-r-lin.p1[Y])/YDiv;
         IF DEBUGCOLLIDEBUMPERWALL THEN
            DebugReal("ScreenSize-r-lin.p1[Y]", 2, ScreenSize-r-lin.p1[Y]);
         END;
         |
      3: CollisionTime := (r-lin.p1[X])/XDiv;
         IF DEBUGCOLLIDEBUMPERWALL THEN
            DebugReal("r-lin.p1[X]", 3, r-lin.p1[X]);
         END;
   END;
END;

bRes := bRes AND (CollisionTime >= (*?*)0.0) AND (CollisionTime <= (*?*)1.0);
IF DEBUGTRACE THEN STextIO.WriteString("<- FindCollisionTimeWall"); STextIO.WriteLn; END;
IF bRes THEN
   IF DEBUGCOLLIDEBUMPERWALL THEN
      DebugOn(0); DebugReal("wall collision t", WhichWall, CollisionTime);
   END;
   RETURN TRUE;
ELSE
   IF DEBUGCOLLIDEBUMPERWALL THEN
      DebugReal("No wall collision t", WhichWall, CollisionTime);
   END;
   RETURN FALSE;
END;

END FindCollisionTimeWall;

(*----------------------------------*)
 PROCEDURE DoCollide(c:CollideInfo);                           
(*----------------------------------*)                         
(*
from

    "2-Dimensional Elastic Collisions without Trigonometry"
                       Chad Berchek
                       Vobarian Software   http://www.vobarian.com/

         1. Create unit normal and unit tangent vectors.
                > using the centers of the colliding circles

         2. Locate the initial (before the collision) velocity vectors, v1 and v2.
                > ie, the x and y velocity components

         3. Resolve the velocity vectors, v1 and v2, into normal and tangential components
                > use the dot product to project the x/y velocities onto the norman/tangent directions

         4. Find the new tangential velocities (after the collision).
                > not too hard, since there is no change in velocity in the tangential direction

         5. Find the new normal velocities.
                > use the one dimensional collision formulas derived from conservation of momentum and kinetic energy

         6. Convert the scalar normal and tangential velocities into vectors.
                > multiply by the unit normal and tangential vectors

         7. Find the final velocity vectors.

      CollideInfo   = RECORD
                        colltime :REAL;
                        inx1,
                        inx2     :INTEGER;
                        obj1,
                        obj2     :CollideObj;
                      END;

*)

VAR UnitNormal,
    UnitTangent       :Point;
    PreVelocNormal,
    PostVelocNormal,
    VelocTangent      :ARRAY[1..2] OF REAL;
    PostVelocVecNorm,
    PostVelocVecTang  :ARRAY[1..2] OF Point;
    mass,
    velocityLimit     :ARRAY[1..2] OF REAL;
    (*pos,*)
    radius            :REAL;
    obj1Specs,
    obj2Specs         :ObjSpecsPtr;
    obj1Info,
    obj2Info          :ObjInfoPtr;

BEGIN WITH c DO
IF DEBUGTRACE THEN STextIO.WriteString("DoCollide -> "); END;
IF DEBUG THEN DebugOn(0); DebugPause("DoCollide", 0); END;

CASE obj1 OF
   BumperObj: obj1Specs := ADR(MovingObjects[obj1].specsB^[inx1]);
              obj1Info := ADR(MovingObjects[obj1].infoB^[inx1]);     |
   PuckObj:   obj1Specs := ADR(MovingObjects[obj1].specsB^[inx1]);
              obj1Info := ADR(MovingObjects[obj1].infoB^[inx1]);     |
   WallObj:   obj1Specs := ADR(MovingObjects[obj1].specsB^[inx1]);
              obj1Info := ADR(MovingObjects[obj1].infoB^[inx1]);
END;

CASE obj2 OF
   BumperObj: obj2Specs := ADR(MovingObjects[obj2].specsB^[inx2]);
              obj2Info := ADR(MovingObjects[obj2].infoB^[inx2]);     |
   PuckObj:   obj2Specs := ADR(MovingObjects[obj2].specsB^[inx2]);
              obj2Info := ADR(MovingObjects[obj2].infoB^[inx2]);     |
   WallObj:   obj2Specs := ADR(MovingObjects[obj2].specsB^[inx2]);
              obj2Info := ADR(MovingObjects[obj2].infoB^[inx2]);
END;

IF obj1 = BumperObj THEN
   velocityLimit[1] := MaxBumperVelocity;
ELSE
   velocityLimit[1] := NoVelocityLimit;
END;

IF obj2 = BumperObj THEN
   velocityLimit[2] := MaxBumperVelocity;
ELSE
   velocityLimit[2] := NoVelocityLimit;
END;

(* step obj1 into the collision *)
obj1Specs^.pos := obj1Info^.prevpos;      (* put it back to before the collision *)
obj1Info^.veloc := obj1Info^.prevveloc;
(*MovingObjects[obj1]^[inx1].specs.pos := MovingObjects[obj1]^[inx1].prevpos;*)   
(*MovingObjects[obj1]^[inx1].veloc := MovingObjects[obj1]^[inx1].prevveloc;*)
(*DebugReal("DoCollide step", ORD(obj1), colltime);*)

StepObject(obj1, obj1Info^, obj1Specs^, colltime);                          (* move it to the collision point *)

obj1Specs^.moved := TRUE;
(*MovingObjects[obj1]^[inx1].specs.marked := TRUE; <<< do this earlier *)

(* step obj2 into the collision *)
IF obj2 # WallObj THEN

   obj2Specs^.pos := obj2Info^.prevpos;      (* put it back to before the collision *)
   obj2Info^.veloc := obj2Info^.prevveloc;

   StepObject(obj2, obj2Info^, obj2Specs^, colltime);                          (* move it to the collision point *)

   obj2Specs^.moved := TRUE;
   (*MovingObjects[obj2]^[inx2].specs.marked := TRUE; <<< do this earlier *)
END;

(*DebugReal("DoCollide: After re-step object", 0, colltime);*)

IF obj2 = WallObj THEN

   (*IF DEBUG THEN*) (*DebugOn(0);*) (*DebugPause("WallObj in DoCollide", 0);(* END;*)*)
   IF obj1 = BumperObj THEN          (* ? *)
      radius := BumperRadius;
   ELSE
      radius := PuckRadius;
   END;

   (*DebugReal("veloc in", inx2, MovingObjects[obj1]^[inx1].veloc);*)
   (*DebugReal("DoCollide: speed[X] in", inx2, MovingObjects[obj1]^[inx1].speed[X]);*)
   (*DebugReal("DoCollide: speed[Y] in", inx2, MovingObjects[obj1]^[inx1].speed[Y]);*)

   (*pos := MovingObjects[obj1]^[inx1].pos[X];*)
   (*IF (pos >= ScreenSize-radius) OR (pos <= radius) THEN*)
   IF ODD(inx2) THEN                                               (* walls 1 and 3 *)
      obj1Info^.speed[X] := -obj1Info^.speed[X];
   (*END;*)
   ELSE
   (*pos := MovingObjects[obj1]^[inx1].pos[Y];*)
   (*IF (pos >= ScreenSize-radius) OR (pos <= radius) THEN*)
      obj1Info^.speed[Y] := -obj1Info^.speed[Y];
   (*END;*)
   END;

   obj1Info^.veloc := LimitVeloc(obj1Info^.speed[X], obj1Info^.speed[Y], velocityLimit[1]);

   (*DebugReal("speed[X]", inx2, MovingObjects[obj1]^[inx1].speed[X]);*)
   (*DebugReal("speed[Y]", inx2, MovingObjects[obj1]^[inx1].speed[Y]);*)
   (*DebugReal("veloc out", inx2, MovingObjects[obj1]^[inx1].veloc);*)

   (*Try this to "debounce" wall and object *)
   IF obj1Specs^.pos[X] <= radius THEN
      obj1Specs^.pos[X] := radius + 0.1;
   ELSIF obj1Specs^.pos[X] >= ScreenSize - radius THEN
      obj1Specs^.pos[X] := ScreenSize - radius - 0.1;
   END;
   IF obj1Specs^.pos[Y] <= radius THEN
      obj1Specs^.pos[Y] := radius + 0.1;
   ELSIF obj1Specs^.pos[Y] >= ScreenSize - radius THEN
      obj1Specs^.pos[Y] := ScreenSize - radius - 0.1;
   END;

ELSE  (* two objects collide *)

   IF obj1 = BumperObj THEN
      mass[1] := BumperMass;
   ELSE
      mass[1] := PuckMass;
   END;

   IF obj2 = BumperObj THEN
      mass[2] := BumperMass;
   ELSE
      mass[2] := PuckMass;
   END;

   (*DebugPause("obj2 is ", ORD(obj2));*)

   DoUnitNormal(obj1Specs^.pos, obj2Specs^.pos, UnitNormal, UnitTangent);
   (*DebugPause("after DoUnitNormal", 0);*)

   PreVelocNormal[1] := DotProduct(UnitNormal, obj1Info^.speed);
   PreVelocNormal[2] := DotProduct(UnitNormal, obj2Info^.speed);
   VelocTangent[1] := DotProduct(UnitTangent, obj1Info^.speed);
   VelocTangent[2] := DotProduct(UnitTangent, obj2Info^.speed);
   (*DebugPause("after DotProducts", 0);*)

   (*(*DebugOn(0);*) DebugPause("Before OneDCollision", ORD(obj2));*)
   (*DebugReal("mass[1]", 1, mass[1]);*)
   (*DebugReal("obj1 speed[X]", 1, MovingObjects[obj1]^[inx1].speed[X]); DebugReal("obj1 speed[Y]", 1, MovingObjects[obj1]^[inx1].speed[Y]);*)
   (*DebugReal("obj1 veloc", 1, MovingObjects[obj1]^[inx1].veloc);*)
   (*DebugReal("mass[2]", 2, mass[2]);*)
   (*DebugReal("obj2 speed[X]", 2, MovingObjects[obj2]^[inx2].speed[X]); DebugReal("obj2 speed[Y]", 2, MovingObjects[obj2]^[inx2].speed[Y]);*)
   (*DebugReal("obj2 veloc", 2, MovingObjects[obj2]^[inx2].veloc);*)

   (*DebugReal("obj1 PreVelocNorm", 1, PreVelocNormal[1]);*)
   (*DebugReal("obj1 VelocTangent", 1, VelocTangent[1]);*)
   (*DebugReal("obj2 PreVelocNorm", 2, PreVelocNormal[2]);*)
   (*DebugReal("obj2 VelocTangent", 2, VelocTangent[2]);*)

   OneDCollision(mass[1], mass[2], PreVelocNormal[1], PreVelocNormal[2],
                 PostVelocNormal[1], PostVelocNormal[2]);

   (*(*DebugOn(0);*) DebugPause("after OneDCollision", 0);*)

   (*DebugReal("obj1 PostVelocNorm", 1, PostVelocNormal[1]);*)
   (*DebugReal("obj2 PostVelocNorm", 2, PostVelocNormal[2]);*)

   VectorizeVelocity(PostVelocNormal[1], UnitNormal, PostVelocVecNorm[1]);
   VectorizeVelocity(VelocTangent[1], UnitTangent, PostVelocVecTang[1]);
   VectorizeVelocity(PostVelocNormal[2], UnitNormal, PostVelocVecNorm[2]);
   VectorizeVelocity(VelocTangent[2], UnitTangent, PostVelocVecTang[2]);
   (*DebugPause("after VectorizeVelocity", 0);*)

   (*DebugReal("obj1 PostVelocVecNorm[1,X]", 1, PostVelocVecNorm[1,X]);*)
   (*DebugReal("obj2 PostVelocVecNorm[2,X]", 2, PostVelocVecNorm[2,X]);*)

   obj1Info^.speed[X] := PostVelocVecNorm[1, X] + PostVelocVecTang[1, X];
   obj1Info^.speed[Y] := PostVelocVecNorm[1, Y] + PostVelocVecTang[1, Y];
   obj1Info^.veloc := LimitVeloc(obj1Info^.speed[X], obj1Info^.speed[Y], velocityLimit[1]);
   (*DebugPause("After 1 update", 0);*)
   (*(*DEBUG*)IF (obj1 = BumperObj) AND (MovingObjects[obj1]^[inx1].veloc > MaxBumperVelocity) THEN
   (*DEBUG*)   DebugOn(0); DebugReal("out of collision too fast", ORD(obj1), MovingObjects[obj1]^[inx1].veloc);
   (*DEBUG*)END;*)

   obj2Info^.speed[X] := PostVelocVecNorm[2, X] + PostVelocVecTang[2, X];
   obj2Info^.speed[Y] := PostVelocVecNorm[2, Y] + PostVelocVecTang[2, Y];
   (*DebugReal("obj2 speed[X]", 2, MovingObjects[obj2]^[inx2].speed[X]); DebugReal("obj2 speed[Y]", 2, MovingObjects[obj2]^[inx2].speed[Y]);*)
   obj2Info^.veloc := LimitVeloc(obj2Info^.speed[X], obj2Info^.speed[Y], velocityLimit[2]);
   (*DebugPause("After 2 update", 0);*)
   (*DebugReal("obj2 speed[X]", 2, MovingObjects[obj2]^[inx2].speed[X]); DebugReal("obj2 speed[Y]", 2, MovingObjects[obj2]^[inx2].speed[Y]);*)

   (*(*DEBUG*)IF (obj2 = BumperObj) AND (MovingObjects[obj2]^[inx2].veloc > MaxBumperVelocity) THEN
   (*DEBUG*)   DebugOn(0); DebugReal("out of collision too fast", ORD(obj2), MovingObjects[obj2]^[inx2].veloc);
   (*DEBUG*)END;*)
   (*DebugReal("mass[1]", 1, mass[1]);*)
   (*DebugReal("obj1 speed[X]", 1, MovingObjects[obj1]^[inx1].speed[X]); DebugReal("obj1 speed[Y]", 1, MovingObjects[obj1]^[inx1].speed[Y]);*)
   (*DebugReal("obj1 veloc", 1, MovingObjects[obj1]^[inx1].veloc);*)
   (*DebugReal("mass[2]", 2, mass[2]);*)
   (*DebugReal("obj2 speed[X]", 2, MovingObjects[obj2]^[inx2].speed[X]); DebugReal("obj2 speed[Y]", 2, MovingObjects[obj2]^[inx2].speed[Y]);*)
   (*DebugReal("obj2 veloc", 2, MovingObjects[obj2]^[inx2].veloc);*)

   (*DebugReal("obj1 PreVelocNorm", 1, PreVelocNormal[1]);*)
   (*DebugReal("obj1 VelocTangent", 1, VelocTangent[1]);*)
   (*DebugReal("obj2 PreVelocNorm", 2, PreVelocNormal[2]);*)
   (*DebugReal("obj2 VelocTangent", 2, VelocTangent[2]);*)

END;
IF DEBUGTRACE THEN STextIO.WriteString("<- DoCollide"); STextIO.WriteLn; END;
END END DoCollide;

(*----------------------*)
 PROCEDURE FinalizeMove;
(*----------------------*)

VAR bump :BumperIndices;
    i    :INTEGER;

BEGIN

FOR bump := MIN(BumperIndices) TO MAX(BumperIndices) DO
   WITH MovingObjects[BumperObj] DO
      infoB^[bump].prevpos := specsB^[bump].pos;
      infoB^[bump].prevveloc := infoB^[bump].veloc;
   END;
END;

FOR i := 0 TO NumPucks-1 DO
   WITH MovingObjects[PuckObj] DO
      infoP^[i].prevpos := specsP^[i].pos;
      infoP^[i].prevveloc := infoP^[i].veloc;
   END;
END;

END FinalizeMove;

(*=======================*)
 PROCEDURE FollowObjects;
(*=======================*)
                 (* PROBLEMS: 1.Edge collisions appear on every repeat
                              2.Bumper-puck collisions appear on two repeats

                    for #2 - APPEARS problem is with step and .prevpos and .moved.
                    We need (unstep) then to restep all non-colliding objects from orig .prevpos to FirstCollide.colltime.
                    AND we need to maintain .moved so it does not stick on the colliding objects!

                    #1 -> puck (or bumper) is just going off the edge (and hanging the machine!)
                          really, wall collisions can't be done the way I assumed, what you need
                          to calculate is the time that the intersection of a normal to the wall from
                          the obj pos becomes equal to the radius of the object.
                          ie, need a different FindCollisionTime for the wall collisions
                 *)
(*
    OK, the full monty.

       0 Repeat until no collisions within the remaining move to the end of the full step.
       1 Calculate the first collision time given the remaining move to the end of the full step.
       2 move all objects that distance and reset prevpos
       3 perform that collision calculation to get the new dir and vel of the colliders
       4 decrement the remaining move
       5 go back to #0

    Note: the same 0.0 to 1.0 t parameterization is used for each call to FindCollisionTime(),
          but the MoveObjects() should be sent a fraction of the actual total step.

          Given FindCollisionTime returns ti
          fraction remaining before first collide is    1.0
                             tleft after first time is  1.0 - t1
                             tleft after second time is tleft - t2(tleft)
                             after third time is        tleft - t3(tleft)
                             etc

*)

VAR  i, j                        :INTEGER;
     OnePath,
     TwoPath                     :LineSeg;
     t,
     tScaledToStep,
     tmoved,
     tleft                       :REAL;
     FirstCollide                :CollideInfo;
     newDist,
     prevDist                    :REAL;
     separation                  :REAL;
     (*DEBUG*)numreps,
     (*DEBUG*)numcolls           :INTEGER;
     AnyCollision,
     bRes                        :BOOLEAN;

     DebugPending                :BOOLEAN;

               (*-------------------------------------------------------*)
                PROCEDURE WriteName(lead:CHAR; o:CollideObj; trail:CHAR);
               (*-------------------------------------------------------*)
               BEGIN
               IF lead # 0C THEN
                  STextIO.WriteChar(lead);
               END;
               CASE o OF
                  BumperObj: STextIO.WriteString("Bumper"); |
                  PuckObj:   STextIO.WriteString("Puck");   |
                  WallObj:   STextIO.WriteString("Wall");
               END;
               IF trail # 0C THEN
                  STextIO.WriteChar(trail);
               END;
               END WriteName;

               (*(*-------------------------------------------*)
                PROCEDURE DebugCollisions(o1, o2:CollideObj);
               (*-------------------------------------------*)
               BEGIN
               IF (numcolls > 1) OR DebugPending THEN
                  (*DebugOn(0);*) DebugPause("INC(numcolls)", numcolls);
                  IF numcolls = 2 THEN
                     STextIO.WriteString("----------"); SRealIO.WriteFloat(tleft, 5, 10); STextIO.WriteLn;
                     SRealIO.WriteFloat(FirstCollide.colltime, 5, 10); WriteName(" ", FirstCollide.obj1, "-");
                     WriteName(0C, FirstCollide.obj2, 0C);
                     STextIO.WriteLn;
                  END;
                  SRealIO.WriteFloat(tScaledToStep, 5, 10); WriteName(" ", o1, "-"); WriteName(0C, o2, 0C); STextIO.WriteLn;
                  DebugPending := TRUE;
               END;
               END DebugCollisions;*)

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("FollowObjects -> "); END;
DebugPending := FALSE;

numreps := 0;
tleft := 1.0;
tmoved := 0.0;
REPEAT

   (*IF tleft # 1.0 THEN*)
      (*DebugReal("Before Test move in loop: Bumper.pos before moving to tleft", numreps, tleft);*)
      (*FOR i := 0 TO 3 DO*)
         (*DebugBumper(i);*)
      (*END;*)
   (*END;*)

   MoveObjects(tleft);      (* move every obj all the way to the end of the step, but not finalized *)

   (*IF tleft # 1.0 THEN *)
      (*DebugPause("After Test move in loop: BumperPos after moving to tleft", numreps);*)
      (*FOR i := 0 TO 3 DO*)
         (*DebugBumper(i);*)
      (*END;*)
   (*END;*)

   FirstCollide.colltime := 1.0E6;
   AnyCollision := FALSE;
   numcolls := 0;

   (*IF DEBUGCOLLIDEBUMPERWALL THEN
      DebugOn(0);
   END;*)

   (* First, find earliest Bumper-wall collision *)
   FOR i := 0 TO NumBumpers-1 DO

      OnePath.p1 := MovingObjects[BumperObj].infoB^[i].prevpos;
      OnePath.p2 := MovingObjects[BumperObj].specsB^[i].pos;

      FOR j := 0 TO NumWalls-1 DO      (* ---->>>> .marked only on bumper is NOT GOOD ENUF if bumper with hit two walls at step *)
                                       (* ****** NOT ONLY THAT, BUT WAY WRITTEN NOW CAN RESULT IN FIRST COLLISION WRONG IN THAT CASE *)
         (* 
         newDist := sqr(MovingObjects[BumperObj]^[j].pos[X]-MovingObjects[WallObj]^[i].pos[X]) + sqr(MovingObjects[BumperObj]^[j].pos[Y]-MovingObjects[WallObj]^[i].pos[Y]);
         prevDist := sqr(MovingObjects[BumperObj]^[j].prevpos[X]-MovingObjects[WallObj]^[i].prevpos[X]) + sqr(MovingObjects[BumperObj]^[j].prevpos[Y]-MovingObjects[WallObj]^[i].prevpos[Y]);

         IF prevDist <= MaxCollisionDist[BumperObj, WallObj].distsqu THEN
         *)
            (*DebugPause("before wall FindCollision", j);
            DebugLine("OnePath", OnePath);*)

            IF DEBUGCOLLIDEBUMPERWALL THEN
               DebugReal("Bumper-Wall", i, MovingObjects[BumperObj].infoB^[i].veloc);
            END;

            (*
            IF MovingObjects[BumperObj]^[i].marked THEN           (* just collided, touching not to collide again immediatedly *)
               bRes := FALSE;
               DebugPause("bumper obj was marked, Timetest skipped", i);
            ELSE*)
               bRes := FindCollisionTimeWall(OnePath, BumperRadius, j, t);
            (*END;*)
 
            IF bRes THEN
               INC(numcolls);
               IF DEBUGCOLLIDEBUMPERWALL THEN
                  DebugReal("Bumper-Wall Collision at", j, t);
                  DebugReal("tleft", 0, tleft);
                  DebugReal("tScaledToStep", numcolls, t*tleft);
                  DebugReal("FirstCollide.colltime", numcolls, FirstCollide.colltime);
                  (*DebugOff;*)
               END;
               tScaledToStep := t*tleft;
               (*DebugCollisions(BumperObj, WallObj);*)

               IF tScaledToStep < FirstCollide.colltime THEN

                  (*DebugPause("new FirstCollide time", i);*)
                  AnyCollision := TRUE;
                  (* ??? IF numcolls > 1 THEN
                     MovingObjects[FirstCollide.obj1]^[FirstCollide.inx1].marked := FALSE; (* remove provisional one *)
                  END;
                  MovingObjects[BumperObj]^[i].marked := TRUE;
                  ??? *)

                  FirstCollide.colltime := tScaledToStep;      (* actual time for whole step *)
                  FirstCollide.obj1 := BumperObj;
                  FirstCollide.inx1 := i;
                  FirstCollide.obj2 := WallObj;
                  FirstCollide.inx2 := j;
               END;
            (*ELSE*)
               (*DebugPause("no collision for Bumper", i);*)
            END;

         (*END;*)

      END;

   END;

   (* Or earliest Puck-wall collision *)
   FOR i := 0 TO NumPucks-1 DO

      OnePath.p1 := MovingObjects[PuckObj].infoP^[i].prevpos;
      OnePath.p2 := MovingObjects[PuckObj].specsP^[i].pos;

      FOR j := 0 TO NumWalls-1 DO

         (* 
         newDist := sqr(MovingObjects[PuckObj]^[j].pos[X]-MovingObjects[WallObj]^[i].pos[X]) + sqr(MovingObjects[PuckObj]^[j].pos[Y]-MovingObjects[WallObj]^[i].pos[Y]);
         prevDist := sqr(MovingObjects[PuckObj]^[j].prevpos[X]-MovingObjects[WallObj]^[i].prevpos[X]) + sqr(MovingObjects[PuckObj]^[j].prevpos[Y]-MovingObjects[WallObj]^[i].prevpos[Y]);

         IF prevDist <= MaxCollisionDist[PuckObj, WallObj].distsqu THEN
         *)

            bRes := FindCollisionTimeWall(OnePath, PuckRadius, j, t);

            IF bRes THEN
               (*(*IF DEBUG THEN*) (*DebugOn(0);*) DebugReal("Puck-Wall potential Collision at", j, t); (*END;*)*)
               (*DEBUG*)INC(numcolls);
               tScaledToStep := t*tleft;
               (*DebugCollisions(PuckObj, WallObj);*)
               IF tScaledToStep < FirstCollide.colltime THEN
                  AnyCollision := TRUE;

                  (* ??? IF numcolls > 1 THEN
                     MovingObjects[FirstCollide.obj1]^[FirstCollide.inx1].marked := FALSE; (* remove provisional one *)
                  END;
                  MovingObjects[PuckObj]^[i].marked := TRUE;*)

                  FirstCollide.colltime := tScaledToStep;
                  FirstCollide.obj1 := PuckObj;
                  FirstCollide.inx1 := i;
                  FirstCollide.obj2 := WallObj;
                  FirstCollide.inx2 := j;
               END;
            END;

         (*END;*)

      END;
   END;

   (* Then, find earliest bumper-bumper collision *)
   FOR i := 0 TO NumBumpers-1 DO

      OnePath.p1 := MovingObjects[BumperObj].infoB^[i].prevpos;
      OnePath.p2 := MovingObjects[BumperObj].specsB^[i].pos;

      FOR j := i+1 TO NumBumpers-1 DO

         TwoPath.p1 := MovingObjects[BumperObj].infoB^[j].prevpos;
         TwoPath.p2 := MovingObjects[BumperObj].specsB^[j].pos;

         (*newDist := sqr(MovingObjects[BumperObj]^[j].pos[X]-MovingObjects[BumperObj]^[i].pos[X]) + sqr(MovingObjects[BumperObj]^[j].pos[Y]-MovingObjects[BumperObj]^[i].pos[Y]);*)
         prevDist := sqr(MovingObjects[BumperObj].infoB^[j].prevpos[X]-MovingObjects[BumperObj].infoB^[i].prevpos[X])
                     + sqr(MovingObjects[BumperObj].infoB^[j].prevpos[Y]-MovingObjects[BumperObj].infoB^[i].prevpos[Y]);

         IF prevDist <= MaxCollisionDist[BumperObj, BumperObj].distsqu THEN

            bRes := FindCollisionTime(OnePath, TwoPath, BumperRadius, BumperRadius, t);
            IF bRes THEN
               IF DEBUG THEN DebugOn(0); DebugReal("Bumper-Bumper potential Collision at", j, t); END;
               (*DEBUG*)INC(numcolls);
               tScaledToStep := t*tleft;
               (*DebugCollisions(BumperObj, BumperObj);*)

               IF tScaledToStep < FirstCollide.colltime THEN

                  (* ??? lls > 1 THEN
                     MovingObjects[FirstCollide.obj1]^[FirstCollide.inx1].marked := FALSE; (* remove provisional one *)
                  END;
                  MovingObjects[BumperObj]^[i].marked := TRUE; *)

                  AnyCollision := TRUE;
                  FirstCollide.colltime := tScaledToStep;
                  FirstCollide.obj1 := BumperObj;
                  FirstCollide.inx1 := i;
                  FirstCollide.obj2 := BumperObj;
                  FirstCollide.inx2 := j;
               END;
            END;

         END;

      END;
   END;

   (* Next, find earliest bumper-puck collision *)
   FOR i := 0 TO NumBumpers-1 DO

      OnePath.p1 := MovingObjects[BumperObj].infoB^[i].prevpos;
      OnePath.p2 := MovingObjects[BumperObj].specsB^[i].pos;

      FOR j := 0 TO NumPucks-1 DO

         TwoPath.p1 := MovingObjects[PuckObj].infoP^[j].prevpos;
         TwoPath.p2 := MovingObjects[PuckObj].specsP^[j].pos;

         (*newDist := sqr(MovingObjects[BumperObj]^[i].pos[X]-MovingObjects[PuckObj]^[j].pos[X]) + sqr(MovingObjects[BumperObj]^[i].pos[Y]-MovingObjects[PuckObj]^[j].pos[Y]);*)
         prevDist := sqr(MovingObjects[BumperObj].infoB^[i].prevpos[X]-MovingObjects[PuckObj].infoP^[j].prevpos[X])
                          + sqr(MovingObjects[BumperObj].infoB^[i].prevpos[Y]-MovingObjects[PuckObj].infoP^[j].prevpos[Y]);

         IF prevDist <= MaxCollisionDist[BumperObj, PuckObj].distsqu THEN

            bRes := FindCollisionTime(OnePath, TwoPath, BumperRadius, PuckRadius, t);
            IF bRes THEN
               IF DEBUG THEN DebugOn(0); DebugReal("Bumper-Puck potential Collision at", i, t); DebugPause("puck", j); END;
               (*DEBUG*)INC(numcolls);
               tScaledToStep := t*tleft;
               (*DebugCollisions(BumperObj, PuckObj);*)

               IF tScaledToStep < FirstCollide.colltime THEN
                  AnyCollision := TRUE;

                  (* ??? IF numcolls > 1 THEN
                     MovingObjects[FirstCollide.obj1]^[FirstCollide.inx1].marked := FALSE; (* remove provisional one *)
                  END;
                  MovingObjects[PuckObj]^[i].marked := TRUE;*)

                  FirstCollide.colltime := tScaledToStep;
                  FirstCollide.obj1 := BumperObj;
                  FirstCollide.inx1 := i;
                  FirstCollide.obj2 := PuckObj;
                  FirstCollide.inx2 := j;
               END;
            END;

         END;

      END;
   END;

   (* Finally, find earliest puck-puck collision *)
   FOR i := 0 TO NumPucks-1 DO

      OnePath.p1 := MovingObjects[PuckObj].infoP^[i].prevpos;
      OnePath.p2 := MovingObjects[PuckObj].specsP^[i].pos;

      FOR j := i+1 TO NumPucks-1 DO

         TwoPath.p1 := MovingObjects[PuckObj].infoP^[j].prevpos;
         TwoPath.p2 := MovingObjects[PuckObj].specsP^[j].pos;

         (*newDist := sqr(MovingObjects[PuckObj]^[i].pos[X]-MovingObjects[PuckObj]^[j].pos[X]) + sqr(MovingObjects[PuckObj]^[i].pos[Y]-MovingObjects[PuckObj]^[j].pos[Y]);*)
         prevDist := sqr(MovingObjects[PuckObj].infoP^[i].prevpos[X]-MovingObjects[PuckObj].infoP^[j].prevpos[X])
                          + sqr(MovingObjects[PuckObj].infoP^[i].prevpos[Y]-MovingObjects[PuckObj].infoP^[j].prevpos[Y]);

         IF prevDist <= MaxCollisionDist[PuckObj, PuckObj].distsqu THEN

            bRes := FindCollisionTime(OnePath, TwoPath, PuckRadius, PuckRadius, t);
            IF bRes THEN
               IF DEBUG THEN DebugOn(0); DebugReal("Puck-Puck potential Collision at", i, t); END;
               (*DEBUG*)INC(numcolls);
               tScaledToStep := t*tleft;
               (*DebugCollisions(PuckObj, PuckObj);*)

               IF tScaledToStep < FirstCollide.colltime THEN
                  AnyCollision := TRUE;
                  FirstCollide.colltime := tScaledToStep;
                  FirstCollide.obj1 := PuckObj;
                  FirstCollide.inx1 := i;
                  FirstCollide.obj2 := PuckObj;
                  FirstCollide.inx2 := j;
               END;
            END;

         END;

      END;

   END;

   (*???
   FOR i := 0 TO NumBumpers-1 DO
      IF MovingObjects[BumperObj]^[i].marked THEN
         IF NOT (AnyCollision AND (FirstCollide.inx1 = i)) THEN
            MovingObjects[BumperObj]^[i].marked := FALSE;            (* remove marked for object after it has served its purpose *)
         END;
      END;
   END;                              (* BETTER, two kinds of marked? *)
   *)

   (*DebugOff;*)
   (*IF (numcolls > 1) THEN*)
      (*(*DebugOn(0);*) DebugPause("numcolls before collision", numcolls);*)
   (*END;*)
   IF AnyCollision THEN
      WITH FirstCollide DO
         (*DEBUG KLUDGE*)(*IF colltime < 0.01 THEN colltime := 0.01; END; (* SEEMS NOT TO BE ENUF, SYNCING COLLISIONS CAN END UP WITH NO PROGRESS *)*)
      
         (*(*IF DEBUG THEN*) DebugReal("First Collision at", ORD(obj2), colltime); (*DebugOff;*) (*END;*)*)

         (*(*DebugOn(0);*) DebugReal("tleft", numreps, tleft);*)
         (*(*DebugOn(0);*) DebugPause("obj1 is", ORD(obj1)*10000+ORD(inx1)); DebugPause("obj2 is", ORD(obj2)*10000+ORD(inx2));*)
         (*DebugPoint("Obj1 pos before collide", MovingObjects[obj1]^[inx1].pos);
         DebugPoint("Obj2 pos before collide", MovingObjects[obj2]^[inx2].pos);
         DebugReal("Obj1 - Obj2 before collide", 0, sqrt(sqr(MovingObjects[obj1]^[inx1].pos[X]-MovingObjects[obj2]^[inx2].pos[X])+sqr(MovingObjects[obj1]^[inx1].pos[Y]-MovingObjects[obj2]^[inx2].pos[Y])));*)

         (*
         (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] < BumperRadius THEN
         (*DEBUG*)   DebugOn(0);
         (*DEBUG*)   DebugReal("X already too small in FindCollisionWall", 0, MovingObjects[obj1]^[inx1].pos[X]);
         (*DEBUG*)END;
         (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] > ScreenSize - BumperRadius THEN
         (*DEBUG*)   DebugOn(0);
         (*DEBUG*)   DebugReal("X already too big in FindCollisionWall", 0, MovingObjects[obj1]^[inx1].pos[X]);
         (*DEBUG*)END;
         (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] < BumperRadius THEN
         (*DEBUG*)   DebugOn(0);
         (*DEBUG*)   DebugReal("Y already too small in FindCollisionWall", 0, MovingObjects[obj1]^[inx1].pos[Y]);
         (*DEBUG*)END;
         (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] > ScreenSize - BumperRadius THEN
         (*DEBUG*)   DebugOn(0);
         (*DEBUG*)   DebugReal("Y already too big in FindCollisionWall", 0, MovingObjects[obj1]^[inx1].pos[Y]);
         (*DEBUG*)END;
         *)
         (*DebugPause("Bumper's.pos before DoCollide", numreps);*)
         (*FOR i := 0 TO 3 DO*)
            (*DebugBumper(i);*)
         (*END;*)

         DoCollide(FirstCollide);             (* retreats and moves the colliding objects *)

         (*DebugReal("after DoCollide", numreps, FirstCollide.colltime);*)

         (*(*DEBUG*)IF obj2 = WallObj THEN
            (*DEBUG*)
            (*IF DEBUG THEN*) (*DebugOn(0);*) DebugPause("WallObj in DoCollide", 0);(* END;*)
            (*DEBUG*)IF obj1 = BumperObj THEN          (* ? *)
            (*DEBUG*)   separation := BumperRadius;
            (*DEBUG*)ELSE (* Puck Obj *)
            (*DEBUG*)   separation := PuckRadius;
            (*DEBUG*)END;
            (*DEBUG*)
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] <= separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("X Still too small after DoCollide", 0, MovingObjects[obj1]^[inx1].pos[X]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] >= ScreenSize - separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("X Still too big after DoCollide", 0, MovingObjects[obj1]^[inx1].pos[X]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] <= separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("Y Still too small after DoCollide", 0, MovingObjects[obj1]^[inx1].pos[Y]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] >= ScreenSize - separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("Y Still too big after DoCollide", 0, MovingObjects[obj1]^[inx1].pos[Y]);
            (*DEBUG*)END;
            (*DEBUG*)
            (*DEBUG*)IF obj1 = BumperObj THEN
            (*DEBUG*)   (*DebugOn(0);*) DebugPause("Bumper's.pos after DoCollide", numreps);
            (*DEBUG*)   FOR i := 0 TO 3 DO
            (*DEBUG*)      DebugBumper(i);
            (*DEBUG*)   END;
            (*DEBUG*)END;*)

         (*END;*)

         (*DebugPoint("Obj1 pos after collide", MovingObjects[obj1]^[inx1].pos);
         DebugPoint("Obj2 pos after collide", MovingObjects[obj2]^[inx2].pos);
         DebugReal("Obj1 - Obj2 after distance", 0, sqrt(sqr(MovingObjects[obj1]^[inx1].pos[X]-MovingObjects[obj2]^[inx2].pos[X])+sqr(MovingObjects[obj1]^[inx1].pos[Y]-MovingObjects[obj2]^[inx2].pos[Y])));*)

         (*DebugReal("Before move other objects", numreps, colltime);
         (*DebugOn(0);*) DebugPause("Bumper's.pos before Move(other) objects", numreps);
         FOR i := 0 TO 3 DO
            DebugBumper(i);
         END;*)

         (*DebugReal("before moving rest of bumpers the same time span", 0, FirstCollide.colltime);*)
         MoveObjects(FirstCollide.colltime);     (* retreats and move all objects as far as the colltime from their current pos *)

         (*(*DebugOn(0);*) DebugPause("after moving rest of bumpers the same time span", numreps);*)
         (*FOR i := 0 TO 3 DO*)
            (*DebugBumper(i);*)
         (*END;*)

         (*(*DEBUG*)IF obj2 = WallObj THEN
            (*DEBUG*)
            (*IF DEBUG THEN*) (*DebugOn(0);*) DebugPause("WallObj in DoCollide", 0);(* END;*)
            (*DEBUG*)IF obj1 = BumperObj THEN          (* ? *)
            (*DEBUG*)   separation := BumperRadius;
            (*DEBUG*)ELSE (* Puck Obj *)
            (*DEBUG*)   separation := PuckRadius;
            (*DEBUG*)END;
            (*DEBUG*)
            (*IF DEBUG THEN*) (*DebugOn(0);*) DebugPause("WallObj in DoCollide", 0);(* END;*)
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] <= separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("X Still too small after MoveObjects", 0, MovingObjects[obj1]^[inx1].pos[X]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[X] >= ScreenSize - separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("X Still too big after MoveObjects", 0, MovingObjects[obj1]^[inx1].pos[X]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] <= separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("Y Still too small after MoveObjects", 0, MovingObjects[obj1]^[inx1].pos[Y]);
            (*DEBUG*)END;
            (*DEBUG*)IF MovingObjects[obj1]^[inx1].pos[Y] >= ScreenSize - separation THEN
            (*DEBUG*)   DebugOn(0);
            (*DEBUG*)   DebugReal("Y Still too big after MoveObjects", 0, MovingObjects[obj1]^[inx1].pos[Y]);
            (*DEBUG*)END;
         (*DEBUG*)END;*)

         IF obj1 = BumperObj THEN
            MovingObjects[obj1].specsB^[inx1].moved := FALSE;      (* remove the restriction on their moving during the above MoveObjects() *)
         ELSE
            MovingObjects[obj1].specsP^[inx1].moved := FALSE;      (* remove the restriction on their moving during the above MoveObjects() *)
         END;
         IF obj2 = BumperObj THEN
            MovingObjects[obj2].specsB^[inx2].moved := FALSE;      (* remove the restriction on their moving during the above MoveObjects() *)
         ELSE
            MovingObjects[obj2].specsP^[inx2].moved := FALSE;      (* remove the restriction on their moving during the above MoveObjects() *)
         END;

         FinalizeMove;              (* sets .prevpos to .pos *)

         tmoved := tmoved + FirstCollide.colltime;
         (*DebugReal("tmoved after collision", 0, tmoved);*)
         tleft := 1.0-tmoved;
         (*DebugReal("tleft after collision", 0, tleft);*)
         (*IF DebugPending THEN
            (*DEBUG*)STextIO.WriteString("First one: "); SRealIO.WriteFloat(VAL(REAL, FirstCollide.colltime), 5, 10);
            WriteName(" ", FirstCollide.obj1, "-"); WriteName(0C, FirstCollide.obj2, 0C);
            STextIO.WriteLn;
            STextIO.WriteString("tmoved "); SRealIO.WriteFloat(VAL(REAL, tmoved), 5, 10);
            STextIO.WriteString("  tleft "); SRealIO.WriteFloat(VAL(REAL, tleft), 5, 10);
            STextIO.WriteLn;
         END;*)

         (*IF numcolls = 1 THEN*)
            (*DebugPending := FALSE;*)
         (*END;*)
      END;
   END;

   INC(numreps);
   IF numreps > 100 THEN
      DebugOn(0); DebugPause("numreps", numreps);
      AnyCollision := FALSE;
   END;

UNTIL NOT AnyCollision OR (tleft = 0.0);       (* can't make any progress at 0.0 *)

(* OR WORSE TWO COLLISIONS AT t of 0.0 hang the loop even with tleft of 1.0 *)

(*
FOR i := 0 TO 3 DO
   (*DEBUG*)IF MovingObjects[BumperObj]^[i].pos[X] <= BumperRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Bumper X Still too small on exit FollowObjects", i, MovingObjects[BumperObj]^[i].pos[X]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[BumperObj]^[i].pos[X] >= ScreenSize - BumperRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Bumper X Still too big on exit FollowObjects", i, MovingObjects[BumperObj]^[i].pos[X]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[BumperObj]^[i].pos[Y] <= BumperRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Bumper Y Still too small on exit FollowObjects", i, MovingObjects[BumperObj]^[i].pos[Y]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[BumperObj]^[i].pos[Y] >= ScreenSize - BumperRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Bumper Y Still too big on exit FollowObjects", i, MovingObjects[BumperObj]^[i].pos[Y]);
   (*DEBUG*)END;
END;
*)
(*
FOR i := 0 TO NumPucks-1 DO
   (*DEBUG*)IF MovingObjects[PuckObj]^[i].pos[X] <= PuckRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Puck X Still too small on exit FollowObjects", i, MovingObjects[PuckObj]^[i].pos[X]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[PuckObj]^[i].pos[X] >= ScreenSize - PuckRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Puck X Still too big on exit FollowObjects", i, MovingObjects[PuckObj]^[i].pos[X]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[PuckObj]^[i].pos[Y] <= PuckRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Puck Y Still too small on exit FollowObjects", i, MovingObjects[PuckObj]^[i].pos[Y]);
   (*DEBUG*)END;
   (*DEBUG*)IF MovingObjects[PuckObj]^[i].pos[Y] >= ScreenSize - PuckRadius THEN
   (*DEBUG*)   DebugOn(0);
   (*DEBUG*)   DebugReal("Puck Y Still too big on exit FollowObjects", i, MovingObjects[PuckObj]^[i].pos[Y]);
   (*DEBUG*)END;
END;
*)

(*
(*DEBUG*)FOR i := 0 TO NumBumpers-1 DO
   IF MovingObjects[BumperObj]^[i].marked THEN
      DebugOn(0); DebugPause("marked obj on exit!", i);
      MovingObjects[BumperObj]^[i].marked := FALSE;
   END;
END;                              (* BETTER, two kinds of marked? *)
*)

IF DEBUGTRACE THEN STextIO.WriteString("<- FollowObjects"); STextIO.WriteLn; END;
(*DebugOn(0); DebugPause("FollowObjects for step is finished", 0); END;*)
END FollowObjects;

(*----------------------------------------------------------*)
 PROCEDURE InitTrail(VAR specs:SledSpecs; VAR info:SledInfo);
(*----------------------------------------------------------*)

VAR  t  :INTEGER;

BEGIN

specs.TrailHeadPos := 0;

specs.Trail[0] := specs.pos;

specs.TrailNumPoints := 1;

info.TrailNumHidden := 0;
info.TrailTailPos := 0; (*??*)

info.loopP[X] := -1.0;
info.loopP[Y] := -1.0;
info.loopSeg := 0;

END InitTrail;

(*============================================*)
 PROCEDURE RemoveSledLoop(WhichSled:CARDINAL);
(*============================================*)

VAR i :INTEGER;

BEGIN WITH Sleds DO

InitTrail(specsS[WhichSled], infoS[WhichSled]);

END END RemoveSledLoop;

(*===========================================================*)
 PROCEDURE DoSledLoop(WhichSled:CARDINAL; HitSegPoint:CARDINAL);
(*===========================================================*)
                                           
CONST MaxLoopSplits = 5;    (* big enuf? *)

TYPE loopBoxInfo    = RECORD
                        loopMinBox,
                        loopMaxBox  :Point;       (* these are w/r/t the actual (untransformed) screen points *)
                        loopAdj     :Point;
                      END;

VAR  i0, i,
     j, k           :INTEGER;

     subloop        :INTEGER;
     loopSplits     :ARRAY [0..MaxLoopSplits-1] OF loopBoxInfo;
     numSplits      :INTEGER;

     puckPos        :Point;
     loopInx        :INTEGER;
     numLoopPoints    :INTEGER;
     unWrapAdjust   :Point;
     numCandidates  :INTEGER;

     ThruLine       :LineSeg;
     Crossings      :CARDINAL;
     OutsideLoop    :Point;
     anyUnwrap,
     puckSelected,
     loopReds,
     loopBlues      :BOOLEAN;

     CrossLine1,
     CrossLine2,
     ls             :LineSeg;
     CrossingPoint  :Point;
     fin            :BOOLEAN;

     debugCntr      :INTEGER;

(* NOTE: This routine is reconstructing a wrapped around (split) loop into an unsplit loop (with part of
         it off the screen coordinates. Ditto for the positions of the pucks within a box enclosing the
         transformed loop.

         After this transform, the split loop can be processed to find internal pucks with the same code that
         does the unsplit loops. This is done by counting the crossings of a line from the tested puck to a
         point beyond the extent of the loop. If it is odd, then the puck is within the loop, otherwise not.
*)

BEGIN WITH Sleds DO

CrossLine1.p1 := specsS[WhichSled].Trail[specsS[WhichSled].TrailHeadPos];
j := (specsS[WhichSled].TrailHeadPos + TrailMaxPoints -1) MOD TrailMaxPoints;
CrossLine1.p2 := specsS[WhichSled].Trail[j];

j := (HitSegPoint + TrailMaxPoints +1) MOD TrailMaxPoints;
CrossLine2.p1 := specsS[WhichSled].Trail[j];
CrossLine2.p2 := specsS[WhichSled].Trail[HitSegPoint];            (* earliest point in the line seg *)

(* double check - necessary? *)
IF FindIntersect(CrossLine1, CrossLine2, CrossingPoint)          
          AND (CrossingPoint[X] = infoS[WhichSled].loopP[X]) AND (CrossingPoint[Y] = infoS[WhichSled].loopP[Y]) THEN 

   infoS[WhichSled].loopSeg := HitSegPoint;    

   (* Find the enclosing box of the loop and transform any split loop into a whole loop *)
   (*-----------------------------------------------------------------------------------*)

   FOR i := 0 TO MaxLoopSplits-1 DO
      loopSplits[i].loopMinBox[X] := 1.0E6; loopSplits[i].loopMinBox[Y] := 1.0E6;
      loopSplits[i].loopMaxBox[X] := -1.0E6; loopSplits[i].loopMaxBox[Y] := -1.0E6;
   END;

   unWrapAdjust[X] := 0.0;
   unWrapAdjust[Y] := 0.0;
   numLoopPoints := 0;
   numSplits := 1;
   fin := FALSE;
   subloop := 0;
   i := specsS[WhichSled].TrailHeadPos;

   loopSplits[0].loopAdj := unWrapAdjust;

   REPEAT

      IF numLoopPoints = 0 THEN                                    (* don't include the overlap of the crossing segments *)
         LoopUnwrapped[0, X] := infoS[WhichSled].loopP[X];
         LoopUnwrapped[0, Y] := infoS[WhichSled].loopP[Y];
      ELSE
         LoopUnwrapped[numLoopPoints, X] := specsS[WhichSled].Trail[i, X] + unWrapAdjust[X];
         LoopUnwrapped[numLoopPoints, Y] := specsS[WhichSled].Trail[i, Y] + unWrapAdjust[Y];
         (*DEBUG*) IF ((unWrapAdjust[X] # 0.0) AND (ABS(unWrapAdjust[X]) # 800.0))
                                           OR
                      ((unWrapAdjust[Y] # 0.0) AND (ABS(unWrapAdjust[Y]) # 800.0)) THEN
         (*DEBUG*)    DebugOn(0); DebugPoint("not 0.0", unWrapAdjust);
         (*DEBUG*) END;
      END;
                                            (* NOTE: no segments are in more than one split *)
      WITH loopSplits[subloop] DO                                            (* these are w/r/t the actual (untransformed) screen points *)
         loopMinBox[X] := minr(loopMinBox[X], specsS[WhichSled].Trail[i, X]);           (* ok, testing separately *)
         loopMinBox[Y] := minr(loopMinBox[Y], specsS[WhichSled].Trail[i, Y]);
         loopMaxBox[X] := maxr(loopMaxBox[X], specsS[WhichSled].Trail[i, X]);
         loopMaxBox[Y] := maxr(loopMaxBox[Y], specsS[WhichSled].Trail[i, Y]);
       (*loopMinBox[X] := minr(loopMinBox[X], LoopUnwrapped[numLoopPoints, X]);       (* ok, testing separately *)
         loopMinBox[Y] := minr(loopMinBox[Y], LoopUnwrapped[numLoopPoints, Y]);    <<< WRONG, BOXES DON't USE Unwrapped points
         loopMaxBox[X] := maxr(loopMaxBox[X], LoopUnwrapped[numLoopPoints, X]);
         loopMaxBox[Y] := maxr(loopMaxBox[Y], LoopUnwrapped[numLoopPoints, Y]);*)
      END;

      INC(numLoopPoints);

      IF i = VAL(INTEGER, HitSegPoint) THEN        (* ????? did not this just leave the wrong point check for Min/Max Box above?? *)
         fin := TRUE;                              (* ????? YES, but adjusted for below ???? *)

         LoopUnwrapped[numLoopPoints-1, X] := infoS[WhichSled].loopP[X];          (* don't include the overlap of the crossing segments *)
         LoopUnwrapped[numLoopPoints-1, Y] := infoS[WhichSled].loopP[Y];
         (*DEBUG*)IF (unWrapAdjust[X] # 0.0) OR (unWrapAdjust[Y] # 0.0) THEN
         (*DEBUG*)   DebugOn(0); DebugPause("Not back at original loop split?", i);
         (*DEBUG*)END;

      ELSE

         i0 := i;
         i := (i + TrailMaxPoints -1) MOD TrailMaxPoints;
         ls.p1 := specsS[WhichSled].Trail[i0];
         ls.p2 := specsS[WhichSled].Trail[i];

         IF IsHidden(ls) THEN                (* (600,10) (601,0) (601,800) (602,790) *)

            (*DebugLine("hidden lineseg", specsS[WhichSled].Trail[i]);*)
            anyUnwrap := FALSE;                       

            IF (ls.p1[X] = 0.0) AND (ls.p2[X] = ScreenSize) THEN  (* we are going "backwards" thru the trail      *)
               unWrapAdjust[X] := unWrapAdjust[X] - ScreenSize;           (* so a 0->800 transition needs to be unwrapped *)
               anyUnwrap := TRUE;                                         (* by the opposite of how it was wrapped        *)
            ELSIF (ls.p1[X] = ScreenSize) AND (ls.p2[X] = 0.0) THEN
               unWrapAdjust[X] := unWrapAdjust[X] + ScreenSize;
               anyUnwrap := TRUE;
            END;
            IF (ls.p1[Y] = 0.0) AND (ls.p2[Y] = ScreenSize) THEN
               unWrapAdjust[Y] := unWrapAdjust[Y] - ScreenSize;
               anyUnwrap := TRUE;
            ELSIF (ls.p1[Y] = ScreenSize) AND (ls.p2[Y] = 0.0) THEN
               unWrapAdjust[Y] := unWrapAdjust[Y] + ScreenSize;
               anyUnwrap := TRUE;
            END;
            Assert(anyUnwrap, "Not anyUnwrap in hidden in DoSledLoop");
                                                     
            i := (i + TrailMaxPoints -1) MOD TrailMaxPoints;
            loopSplits[numSplits].loopAdj := unWrapAdjust;
            INC(numSplits);
            INC(subloop);  (* := (subloop+1) MOD 2*)
         END;

      END;

   UNTIL fin; (* exits when the loop HitSegPoint is reached (from the end) *)

   (*??????  I think this point creates a segment outside the loop ????
   i := (i + TrailMaxPoints -1);
   LoopUnwrapped[numLoopPoints+1] := specsS[WhichSled].Trail[i]; (* ??? need to add this extra one? *)*)

   IF numSplits > 1 THEN
      (* Assert(ODD(numSplits), "numSplits not ODD?");  <<< nope can be even *)    (* will be 3 for a simple wraparound loop at this point *)

      (* merge the max/min for the last split with the first split, which must be the same split *) (* ? *)
      WITH loopSplits[0] DO
         loopMinBox[X] := minr(loopMinBox[X], loopSplits[numSplits-1].loopMinBox[X]);
         loopMinBox[Y] := minr(loopMinBox[Y], loopSplits[numSplits-1].loopMinBox[Y]);
         loopMaxBox[X] := maxr(loopMaxBox[X], loopSplits[numSplits-1].loopMaxBox[X]);
         loopMaxBox[Y] := maxr(loopMaxBox[Y], loopSplits[numSplits-1].loopMaxBox[Y]);
      END;

      DEC(numSplits); (* last split is part of the first split - finised with it *)

      (*DEBUG*) IF numSplits > 2 THEN
         DebugOn(0); DebugPause("numSplits", numSplits);

         FOR subloop := 0 TO numSplits-1 DO
            DebugPause("subloop", subloop);
            DebugPoint("[]loopAdj", loopSplits[subloop].loopAdj);
            DebugPoint("loopMinBox", loopSplits[subloop].loopMinBox);
            DebugPoint("loopMaxBox", loopSplits[subloop].loopMaxBox);
         END;
      END;

   END;

   (* consider only the pucks withing the enclosing box of the loop *)
   numCandidates := 0;
   FOR i := 0 TO VAL(INTEGER, NumPucks)-1 DO

      puckSelected := FALSE;
      puckPos := MovingObjects[PuckObj].specsP^[i].pos;

      k := 0;
      WHILE (k <= (numSplits-1)) AND NOT puckSelected DO
         (* Remember the max/min box values are not transformed *)
         IF (puckPos[X] >= loopSplits[k].loopMinBox[X]) AND (puckPos[X] <= loopSplits[k].loopMaxBox[X])
              AND (puckPos[Y] >= loopSplits[k].loopMinBox[Y]) AND (puckPos[Y] <= loopSplits[k].loopMaxBox[Y]) THEN
            puckSelected := TRUE;
         ELSE
            INC(k);
         END;
      END;
      (* k now contains the loopSplit in which this puck was found *)

      IF puckSelected THEN
         WITH LoopPucks[numCandidates] DO
            puckInx := i;
            pos[X] := MovingObjects[PuckObj].specsP^[i].pos[X] + loopSplits[k].loopAdj[X];   (* now puck positions transformed *)
            pos[Y] := MovingObjects[PuckObj].specsP^[i].pos[Y] + loopSplits[k].loopAdj[Y];
         END;
         INC(numCandidates);
      END;

   END;
   (* numCandidates is the number of candidate pucks at this point *)
   (*IF numSplits > 1 THEN*)
   (*   DebugOn(0); DebugPause("Candidates", numCandidates);*)

   (*   PrintInt("candidates", numCandidates); LineFeed;*)
   (*   (*FOR i := 0 TO numCandidates-1 DO*)
   (*      PrintInt("", i); PrintPoint("  ", MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].pos); LineFeed;*)
   (*   END;*)*)
   (*END;*)

   (* count intersections *)
   debugCntr := 0(*DEBUG*);
   loopReds := FALSE;
   loopBlues := FALSE;

   (* Get the adjusted upper right corner of the box w/r/t the unwrapped trail *)
   ThruLine.p2 := loopSplits[0].loopMaxBox;  (* ?not exactly right, do we need to unwrap the other box? *)
   IF numSplits > 1 THEN
      FOR subloop := 1 TO numSplits-1 DO
         ThruLine.p2[X] := maxr(ThruLine.p2[X], loopSplits[subloop].loopMaxBox[X]+loopSplits[subloop].loopAdj[X]);
         ThruLine.p2[Y] := maxr(ThruLine.p2[Y], loopSplits[subloop].loopMaxBox[Y]+loopSplits[subloop].loopAdj[Y]);
      END;
   END;

   (* find which candidates are really inside the loop segment *)
   FOR i := 0 TO numCandidates-1 DO   (* for each loop puck candidate *)

      (*DebugPause("LoopPuck", numCandidates);*)
      (*DebugPoint("LoopPucks[i].pos", LoopPucks[i].pos);*)

      ThruLine.p1 := LoopPucks[i].pos;     (* ThruLine goes from the puck to the box around the loop *)
                                           (* check if it also goes through the loop itself an odd number of times *)

      Crossings := 0;
      FOR loopInx := 0 TO numLoopPoints-2 DO    (* for each segment in the unwrapped loop (one less than the points *)

         ls.p1 := LoopUnwrapped[loopInx];
         ls.p2 := LoopUnwrapped[loopInx+1];
         IF TstIntersect(ThruLine, ls, CrossingPoint) = intersecting THEN
            INC(Crossings);
            (*DebugPause("Hit", Crossings);*)
            (*DebugLine("ThruLine", ThruLine);*)
            (*DebugLine("LoopUnwrapped[loopInx]", LoopUnwrapped[loopInx]);*)
         END;

      END;
      (*Assert(Crossings # 0, "No crossings?");*)
      IF ODD(Crossings) THEN
         INC(debugCntr); (*DEBUG*)
         MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].marked := TRUE;
         IF MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].color = RedPlayer THEN
            loopReds := TRUE;
         ELSIF MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].color = BluePlayer THEN
            loopBlues := TRUE;
         END;
      END;
   END;

   (*DEBUG*) (*IF numSplits > 1 THEN*)IF DEBUGLOOP THEN DebugOn(0); DebugPause("PucksMarked", debugCntr); END;

   FOR i := 0 TO numCandidates-1 DO

      IF MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].marked THEN
         IF loopReds AND loopBlues THEN
            MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].color := NoPlayer;
         ELSIF loopReds THEN
            MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].color := RedPlayer;
         ELSIF loopBlues THEN
            MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].color := BluePlayer;
         END;
         MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].marked := FALSE;
      END;

   END;

   (*(*DEBUG*)IF numSplits > 1 THEN*)
   (*   DebugOn(0); DebugPause("inside", debugCntr);*)
   (**)
   (*   PrintInt("num inside", debugCntr); LineFeed;*)
   (*   (*FOR i := 0 TO numCandidates-1 DO*)
   (*      PrintInt("", i); PrintPoint("  ", MovingObjects[PuckObj].specsP^[LoopPucks[i].puckInx].pos); LineFeed;*)
   (*   END;*)*)
   (*END;*)

ELSE

   DebugOn(0); DebugPause("FindIntersect FAIL in DoSledLoop", HitSegPoint);

END;

END END DoSledLoop;

(*=================================================*)
 PROCEDURE TstSledLoop(WhichSled:CARDINAL):INTEGER;
(*=================================================*)
    (* returns point at the older end of the trail segment that has been crossed to make the loop *)
    (* return -1 for no loop *)

VAR  tseg,
     tsegFirst     :LineSeg;
     j, j0         :INTEGER;

BEGIN WITH Sleds DO
   (*(*DEBUG*)IF WhichSled = 0 THEN
      DebugOn(0)
   END;*)

IF specsS[WhichSled].TrailNumPoints < 5 THEN       (* actually, could be much larger *)
   RETURN -1;
END;

tsegFirst.p1 := specsS[WhichSled].Trail[specsS[WhichSled].TrailHeadPos];

j0 := (specsS[WhichSled].TrailHeadPos + TrailMaxPoints -1) MOD TrailMaxPoints;  (* second point *)
tsegFirst.p2 := specsS[WhichSled].Trail[j0];

IF IsHidden(tsegFirst) THEN                (* can this happen? *)
   DebugOn(0); DebugPause("TstSledLoop: first seg hidden?", j0);
   RETURN -1;
END;

(*PrintLine("tsegFirst", tsegFirst);*)

j0 := (j0 + TrailMaxPoints - 2) MOD TrailMaxPoints;     (* skip the second and third seg  *)  (* j0 is 3rd point from head *)
REPEAT                                                  (* start with fourth seg *)  (* 5 points in trail = 4 segments *)

   j := j0;
   j0 := (j0 + TrailMaxPoints - 1) MOD TrailMaxPoints;

   tseg.p1 := specsS[WhichSled].Trail[j];
   tseg.p2 := specsS[WhichSled].Trail[j0];
   IF NOT IsHidden(tseg) THEN
      IF TstIntersect(tsegFirst, tseg, infoS[WhichSled].loopP) = intersecting THEN
        (*PrintLine("F", tsegFirst); (*PrintInt(" Head", specsS[WhichSled].TrailHeadPos); PrintInt(" Tail", infoS[WhichSled].TrailTailPos); PrintInt(" Num", specsS[WhichSled].TrailNumPoints);*) LineFeed;*)
        (*PrintLine("L", tseg); (*PrintInt(" j0", j0);*) LineFeed;*)
        (*PrintPoint("X", infoS[WhichSled].loopP); LineFeed;*)
        RETURN j0;                                                      (* returning the earliest point for the intersect segment *)
      END;
   ELSE
      Assert(j0 # INT(infoS[WhichSled].TrailTailPos), "TstSledLoop Tail overrun");           (* THIS HAS FAILED, WHEN ONLY THE TINIEST BIT OF THE TAIL before wrap, BUT WHY? *)
      j0 := (j0 + TrailMaxPoints - 1) MOD TrailMaxPoints;      (* don't use the hidden one *)
   END;

UNTIL j0 = INT(infoS[WhichSled].TrailTailPos);

(*DebugPause("TstSledLool nointer", 0);*)
RETURN -1;

END END TstSledLoop;

(*======================================*)
 PROCEDURE StepSled(WhichSled:CARDINAL);
(*======================================*)

VAR  newPos,
     WrapAt           :Point;
     Intersect        :Point;
     wrapIt           :BOOLEAN;
     interp1,
     interp2,
     hiddenpt         :INTEGER;
     tSeg,
     unwrappedSeg,
     border           :LineSeg;
     i, j             :INTEGER;

(* note: wraparound results in addition of three trail segments, the Before, the Hidden, and the After. The Before and the After
         together add up to a length of 15.
*)

BEGIN WITH Sleds DO

(*
PrintInt("StepSled old TrailNumPoints", specsS[WhichSled].TrailNumPoints); LineFeed;
PrintInt("StepSled old TrailHeadPos", specsS[WhichSled].TrailHeadPos); LineFeed;
PrintInt("StepSled old TrailTailPos", infoS[WhichSled].TrailTailPos); LineFeed;
*)

(* sled velocity is constant *)

wrapIt := FALSE;

(* HeadPos always increases *)
specsS[WhichSled].TrailHeadPos := (specsS[WhichSled].TrailHeadPos+1) MOD TrailMaxPoints;           (* wraparound at end of array *)

(*IF FLOAT(TrailNumPoints) * (SledVelocity/StepsPerTurnF) < MaxSledTrailLen(*600.0*) THEN   (* assumes all sled steps are the same length *) *)

IF FLOAT((specsS[WhichSled].TrailNumPoints-1)-2*infoS[WhichSled].TrailNumHidden) * (SledVelocity/StepsPerTurnF) < MaxSledTrailLen(*600.0*) THEN
                                       (* subtract two because each hidden generates two short segments, one before and one after *)
   (* tail can still grow *)
   Assert(specsS[WhichSled].TrailNumPoints < TrailMaxPoints, "TrailNumPoints overflow in StepSled");
   INC(specsS[WhichSled].TrailNumPoints);
   (*PrintInt("grow", specsS[WhichSled].TrailNumPoints); LineFeed;*)

ELSE

   (* if there is a hidden segment now at (embedded in) the tail position, remove it *)
   (* two short segments bracket each hidden segment *)
   tSeg.p2 := specsS[WhichSled].Trail[infoS[WhichSled].TrailTailPos+1];
   j := (infoS[WhichSled].TrailTailPos+2) MOD TrailMaxPoints;
   tSeg.p1 := specsS[WhichSled].Trail[j];
   (*PrintLine("new tail seg", tSeg);*)

   IF IsHidden(tSeg) THEN
      infoS[WhichSled].TrailTailPos := (infoS[WhichSled].TrailTailPos+2) MOD TrailMaxPoints;
      DEC(specsS[WhichSled].TrailNumPoints, 2);                                         (* subtracted one already *)
      DEC(infoS[WhichSled].TrailNumHidden);
      infoS[WhichSled].TrailTailPos := j;
      (*PrintInt("tail was hidden", specsS[WhichSled].TrailNumPoints); LineFeed;*)
   END;

   (* tail is already at maximum length *)
   infoS[WhichSled].TrailTailPos := (infoS[WhichSled].TrailTailPos+1) MOD TrailMaxPoints;

   (*PrintInt("no grow", specsS[WhichSled].TrailNumPoints); LineFeed;*)

END;

newPos[X] := specsS[WhichSled].pos[X] + infoS[WhichSled].speed[X]/StepsPerTurnF;
newPos[Y] := specsS[WhichSled].pos[Y] + infoS[WhichSled].speed[Y]/StepsPerTurnF;
(*DebugPoint("newpos", newPos);*)
      
WrapAt[X] := -1.0;
WrapAt[Y] := -1.0;
unwrappedSeg.p1 := specsS[WhichSled].pos;
unwrappedSeg.p2 := newPos;
                                                 
IF newPos[X] > ScreenSize THEN                     (* sled gone right of the screen, wrap to the left part of the screen *)
   newPos[X] := newPos[X] - ScreenSize;            (* stop the tail segment to the screen right *)
   WrapAt[X] := ScreenSize;
   wrapIt := TRUE;
ELSIF newPos[X] < 0.0 THEN
   newPos[X] := newPos[X] + ScreenSize;
   WrapAt[X] := 0.0;
   wrapIt := TRUE;
END;

IF newPos[Y] > ScreenSize THEN
   newPos[Y] := newPos[Y] - ScreenSize;            (* sled gone above the screen, wrap to the bottom part of the screen *)
   WrapAt[Y] := ScreenSize;                        (* stop the tail segment to the screen top *)
   wrapIt := TRUE;
ELSIF newPos[Y] < 0.0 THEN
   newPos[Y] := newPos[Y] + ScreenSize;
   WrapAt[Y] := 0.0;
   wrapIt := TRUE;
END;

(*DebugOn(0); DebugPause("StepSled TrailHeadPos", TrailHeadPos); DebugPause("StepSled TrailNumPoints", TrailNumPoints);*)
(*specsS[WhichSled].Trail[specsS[WhichSled].TrailHeadPos].p1 := specsS[WhichSled].pos; *)

specsS[WhichSled].Trail[specsS[WhichSled].TrailHeadPos] := newPos;

IF wrapIt THEN                   (* interpolate a hidden line, could be because or X wrapping or Y wrapping or both *)

   (*DebugOn(0); DebugPause("WrapIt TrailHeadPos", TrailHeadPos);*)       (* <<<<      maybe we do want two??? *)

   interp1 := specsS[WhichSled].TrailHeadPos;

   (*DebugPause("interp1", interp1);*)

   hiddenpt := (specsS[WhichSled].TrailHeadPos+1) MOD TrailMaxPoints;
   INC(specsS[WhichSled].TrailNumPoints);
   Assert(specsS[WhichSled].TrailNumPoints < TrailMaxPoints, "TrailNumPoints hiddenpt overflow in StepSled");

   interp2 := (specsS[WhichSled].TrailHeadPos+2) MOD TrailMaxPoints;
   INC(specsS[WhichSled].TrailNumPoints);
   Assert(specsS[WhichSled].TrailNumPoints < TrailMaxPoints, "TrailNumPoints interp2 overflow in StepSled");

   specsS[WhichSled].Trail[interp2] := newPos;  (* in case both X and Y wrap *)

   (*DebugPause("interp2", interp2);*)
   (*DebugPause("TrailNumPoints", TrailNumPoints);*)

   (*PrintLine("initial Head", Trail[TrailHeadPos]); LineFeed;*)

   IF WrapAt[X] >= 0.0 THEN
      IF WrapAt[X] = 0.0 THEN
         specsS[WhichSled].Trail[interp1, X] := 0.0;
         specsS[WhichSled].Trail[hiddenpt, X] := ScreenSize;
      ELSE
         specsS[WhichSled].Trail[interp1, X] := ScreenSize;
         specsS[WhichSled].Trail[hiddenpt, X] := 0.0;
      END;
   ELSE
      (* X not wrapping, Interpolate *)
      WITH border DO
         p1[X] := 0.0;        p1[Y] := WrapAt[Y];
         p2[X] := ScreenSize; p2[Y] := WrapAt[Y];
      END;
      (*PrintLine("FindIntersect ", unwrappedSeg); PrintLine(" - ", border); LineFeed;*)
      Assert(FindIntersect(unwrappedSeg, border, Intersect), "FindIntersect fail on WrapIt X interpol"); 
      (*PrintPoint("Intersect point ", Intersect); LineFeed;*)
      specsS[WhichSled].Trail[interp1, X] := Intersect[X];
      specsS[WhichSled].Trail[hiddenpt, X] := Intersect[X];
      specsS[WhichSled].Trail[interp2, X] := newPos[X];
   END;

   IF WrapAt[Y] >= 0.0 THEN
      IF WrapAt[Y] = 0.0 THEN
         specsS[WhichSled].Trail[interp1, Y] := 0.0;
         specsS[WhichSled].Trail[hiddenpt, Y] := ScreenSize;
      ELSE
         specsS[WhichSled].Trail[interp1, Y] := ScreenSize;
         specsS[WhichSled].Trail[hiddenpt, Y] := 0.0;
      END;
   ELSE
      (* Y not wrapping, Interpolate *)
      WITH border DO
         p1[X] := WrapAt[X];   p1[Y] := 0.0;
         p2[X] := WrapAt[X];   p2[Y] := ScreenSize;
      END;
      Assert(FindIntersect(unwrappedSeg, border, Intersect), "FindIntersect fail on WrapIt Y interpol");
      specsS[WhichSled].Trail[interp1, Y] := Intersect[Y];
      specsS[WhichSled].Trail[hiddenpt, Y] := Intersect[Y];
      specsS[WhichSled].Trail[interp2, Y] := newPos[Y];
   END;

   INC(infoS[WhichSled].TrailNumHidden);

   (*???specsS[WhichSled].Trail[interp1].hidden := TRUE;       (* *)
   ???INC(infoS[WhichSled].TrailNumHidden);
   ???specsS[WhichSled].Trail[interp2].hidden := FALSE;                  <<< interp2 may not be necessary, ICPC does not seem to do it *)

   (*PrintPoint("0-1", Trail[TrailHeadPos].p1); PrintPoint("0-2", Trail[TrailHeadPos].p2);*)
   (*PrintPoint("1-1", Trail[interp1].p1); PrintPoint("1-2", Trail[interp1].p2);*)
   (*PrintPoint("2-1", Trail[interp2].p1); PrintPoint("2-2", Trail[interp2].p2);*)
   (*DebugOn(0); DebugLine("last seg", Trail[TrailHeadPos]);*)
   (*DebugLine("hidden seg", Trail[interp1]);*)
   (*DebugLine("first seg", Trail[interp2]);*)

   specsS[WhichSled].TrailHeadPos := interp2;
      
   (*DebugPause("WrapIt TrailHeadPos fin", TrailHeadPos);*)

END;

(*
(* DEBUG - try his for debugging now *)
(* DEBUG *)TrailHeadPos := 0;

Trail[TrailHeadPos].p1 := pos;      (* !!! should be able to do it with only one pos[] per trail element !!! *)
Trail[TrailHeadPos].p2 := newPos;
Trail[TrailHeadPos].hidden := wrapIt;
*)

(*DebugLine("TrailHeadPos[]", Trail[TrailHeadPos]);*)

specsS[WhichSled].pos := newPos;       (* newPos was calculated correctly for wrap or no wrap *)

(*
PrintInt("StepSled new TrailNumPoints", specsS[WhichSled].TrailNumPoints); LineFeed;
PrintInt("StepSled new TrailHeadPos", specsS[WhichSled].TrailHeadPos); LineFeed;
PrintInt("StepSled new TrailTailPos", infoS[WhichSled].TrailTailPos); LineFeed;
*)

END; END StepSled;

(*=======================*)
 PROCEDURE InitStepState;
(*=======================*)

VAR bump :BumperIndices;
    (*sld  :CARDINAL;*)
    i    :INTEGER;

BEGIN

FOR bump := MIN(BumperIndices) TO MAX(BumperIndices) DO
   WITH MovingObjects[BumperObj] DO
      specsB^[bump].moved := FALSE;
      specsB^[bump].marked := FALSE;
      infoB^[bump].prevpos := specsB^[bump].pos;
      infoB^[bump].prevveloc := infoB^[bump].veloc;
   END;
END;

FOR i := 0 TO NumPucks-1 DO
   WITH MovingObjects[PuckObj] DO
      specsP^[i].moved := FALSE;
      specsP^[i].marked := FALSE;
      infoP^[i].prevpos := specsP^[i].pos;
      infoP^[i].prevveloc := infoP^[i].veloc;
   END;
END;

(*IF DEBUG THEN sld := 0; PrintSledState(sld); END;*)
IF DEBUG THEN DebugOn(0); DebugPause("pause", 0); END;

END InitStepState;

(*---------------------------------------------------------------------------------------------------------*)
 PROCEDURE SetObjInitial(inx:CARDINAL; x, y:REAL; pcolor:GameColors; typ:CollideObj; VAR o:MovingObjectInfo);
(*---------------------------------------------------------------------------------------------------------*)

VAR  oInfo  :ObjInfoPtr;
     oSpecs :ObjSpecsPtr;

BEGIN WITH o DO

otyp := typ;
CASE typ OF
   BumperObj: oInfo := ADR(infoB^[inx]);
              oSpecs := ADR(specsB^[inx]); |
   PuckObj:   oInfo := ADR(infoP^[inx]);
              oSpecs := ADR(specsP^[inx]); |
   WallObj:   oInfo := NIL;
              oSpecs := ADR(specsW^[inx]);
END;


oSpecs^.pos[X] := x;
oSpecs^.pos[Y] := y;
oSpecs^.color := pcolor;
oSpecs^.moved := FALSE;
oSpecs^.marked := FALSE;

IF oInfo # NIL THEN
   oInfo^.prevpos := oSpecs^.pos;
   oInfo^.speed[X] := 0.0;
   oInfo^.speed[Y] := 0.0;
   oInfo^.veloc := 0.0;
   oInfo^.prevveloc := 0.0;
END;

END END SetObjInitial;

(*-------------------*)
 PROCEDURE InitWalls;
(*-------------------*)

BEGIN

SetObjInitial(0, 0.0,            0.0,              NoPlayer,   WallObj, MovingObjects[WallObj]);
SetObjInitial(1, ScreenSize-1.0, 0.0,              NoPlayer,   WallObj, MovingObjects[WallObj]);
SetObjInitial(2, ScreenSize-1.0, ScreenSize-1.0,   NoPlayer,   WallObj, MovingObjects[WallObj]);
SetObjInitial(3, 0.0,            ScreenSize-1.0,   NoPlayer,   WallObj, MovingObjects[WallObj]);
(* the above sets .prevpos *)

(* now below, set .pos *)
MovingObjects[WallObj].specsW^[0].pos[X] := ScreenSize-1.0;  MovingObjects[WallObj].specsW^[0].pos[Y] := 0.0;
MovingObjects[WallObj].specsW^[1].pos[X] := ScreenSize-1.0;  MovingObjects[WallObj].specsW^[1].pos[Y] := ScreenSize-1.0;
MovingObjects[WallObj].specsW^[2].pos[X] := 0.0;             MovingObjects[WallObj].specsW^[2].pos[Y] := ScreenSize-1.0;
MovingObjects[WallObj].specsW^[3].pos[X] := 0.0;             MovingObjects[WallObj].specsW^[3].pos[Y] := 0.0;

END InitWalls;

(*=====================*)
 PROCEDURE InitBumpers;
(*=====================*)

BEGIN

SetObjInitial(0, 100.0, 300.0, RedPlayer,  BumperObj, MovingObjects[BumperObj]);
SetObjInitial(1, 100.0, 500.0, RedPlayer,  BumperObj, MovingObjects[BumperObj]);
SetObjInitial(2, 700.0, 300.0, BluePlayer, BumperObj, MovingObjects[BumperObj]);
SetObjInitial(3, 700.0, 500.0, BluePlayer, BumperObj, MovingObjects[BumperObj]);

END InitBumpers;

(*===================*)
 PROCEDURE InitPucks;
(*===================*)

VAR  p,
     r,
     c,
     lim   :INTEGER;
     x,
     y     :REAL;
     color :GameColors;

BEGIN

p := 0;
y := 50.0;

FOR r := 0 TO 14(*(2*NumPucks)/15*) DO           (* rows contain alternately 7 and 8 pucks *)

   IF NOT ODD(r) THEN
      lim := 6;
      x := 100.0;
   ELSE
      lim := 7;
      x := 50.0;
   END;

   FOR c := 0 TO lim DO
      color := NoPlayer;
      IF r = 6 THEN
         IF c = 0 THEN
            color := RedPlayer;
         ELSIF c = lim THEN
            color := BluePlayer;
         END;
      ELSIF r = 7 THEN
         IF c <= 1 THEN
            color := RedPlayer;
         ELSIF c >= lim-1 THEN
            color := BluePlayer;
         END;
      ELSIF r = 8 THEN
         IF c = 0 THEN
            color := RedPlayer;
         ELSIF c = lim THEN
            color := BluePlayer;
         END;
      END;
      SetObjInitial(p, x, y, color, PuckObj, MovingObjects[PuckObj]);
      x := x + 100.0;
      INC(p);
   END;

   y := y + 50.0;
END;

END InitPucks;

(*===================*)
 PROCEDURE InitSleds;
(*===================*)

VAR  i,
     t  :INTEGER;

BEGIN

(*DebugOn(0); DebugPause("InitSleds", 0);*)
FOR i := RedSledIndex TO BlueSledIndex DO
   WITH Sleds DO

      infoS[i].veloc := SledVelocity;
      infoS[i].speed[Y] := 0.0;
      specsS[i].pos[Y] := 400.0;

      IF i = RedSledIndex THEN
         specsS[i].color := RedPlayer;
         specsS[i].pos[X] := 100.0;
         infoS[i].speed[X] := SledVelocity;
         specsS[i].direct := 0.0;
      ELSE
         specsS[i].color := BluePlayer;
         specsS[i].pos[X] := 700.0;
         infoS[i].speed[X] := -SledVelocity;
         specsS[i].direct := pi;
      END;

      InitTrail(specsS[i], infoS[i]);

   END;
END;

END InitSleds;

(*====================*)
 PROCEDURE InitEngine;
(*====================*)

VAR rTemp,
    rDummy :REAL;

BEGIN

InitPucks;
InitBumpers;
InitWalls;
InitSleds;

(* Find out how fast a speed pucks might reach *)
OneDCollision(BumperMass, PuckMass, MaxBumperVelocity, -MaxBumperVelocity, rDummy, rTemp);  (* Bumper and Puck colliding at MaxBumperVelocity *)
OneDCollision(BumperMass, PuckMass, MaxBumperVelocity, -rTemp, rDummy, MaxPuckVelocity);    (* Bumper at MaxBumperVelocity colliding with Puck at above velocity *)
(* good enough? *)
(*DebugReal("final MaxPuckVelocity", 2, MaxPuckVelocity);*)

(* Find out how close moving objects need to be in order to have a chance of colliding in the next turn *)
WITH MaxCollisionDist[BumperObj, BumperObj] DO
   dist := 2.0*BumperRadius+(2.0*MaxBumperVelocity+CollisionDistFudge)/FLOAT(StepsPerTurn);
   (*DebugReal("Bumper-Bumper dist", 0, dist);*)
   distsqu := dist * dist;
END;

WITH MaxCollisionDist[BumperObj, PuckObj] DO
   dist := BumperRadius+PuckRadius+(MaxBumperVelocity+MaxPuckVelocity+CollisionDistFudge)/FLOAT(StepsPerTurn);
   (*DebugReal("Bumper-Puck dist", 0, dist);*)
   distsqu := dist * dist;
END;

WITH MaxCollisionDist[PuckObj, PuckObj] DO
   dist := 2.0*PuckRadius + (2.0*MaxPuckVelocity+CollisionDistFudge)/FLOAT(StepsPerTurn);
   (*DebugReal("Puck-Puck dist", 0, dist);*)
   distsqu := dist * dist;
END;

WITH MaxCollisionDist[BumperObj, WallObj] DO
   dist := BumperRadius + (MaxBumperVelocity+CollisionDistFudge)/FLOAT(StepsPerTurn);
   (*DebugReal("Bumper-Wall dist", 0, dist);*)
   distsqu := dist * dist;
END;

WITH MaxCollisionDist[PuckObj, WallObj] DO
   dist := PuckRadius + (MaxPuckVelocity+CollisionDistFudge)/FLOAT(StepsPerTurn);
   (*DebugReal("Puck-Wall dist", 0, dist);*)
   distsqu := dist * dist;
END;

StepsPerTurnF := FLOAT(StepsPerTurn);

END InitEngine;

(*-------------------*)
 BEGIN (* mod init *)
(*-------------------*)

END CaptureEngine.


