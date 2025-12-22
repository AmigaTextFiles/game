
(*#################################*)
 IMPLEMENTATION MODULE CaptureDefs;        (* $VER: CaptureDefs.MOD 0.0 (19.12.2010) *)
(*#################################*)

FROM Storage    IMPORT ALLOCATE, DEALLOCATE;
FROM Assertions IMPORT Assert;

BEGIN

NEW(MovingObjects[BumperObj].specsB);
NEW(MovingObjects[BumperObj].infoB);
MovingObjects[BumperObj].otyp := BumperObj;

NEW(MovingObjects[PuckObj].specsP);
NEW(MovingObjects[PuckObj].infoP);
MovingObjects[PuckObj].otyp := PuckObj;

NEW(MovingObjects[WallObj].specsW);
MovingObjects[WallObj].otyp := WallObj;

Assert((MovingObjects[BumperObj].infoB # NIL) AND (MovingObjects[PuckObj].infoP # NIL) AND (MovingObjects[WallObj].specsW # NIL),
       "Unable to ALLOCATE MovingObjects?");

END CaptureDefs.

