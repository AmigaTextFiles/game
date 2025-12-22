MODULE SkakGo;

(* NoLocale U/S? 
   NoLocale Init for sent eller screen for tidligt *)


(*$ DEFINE Test:=FALSE *)

(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs;
(*$ENDIF *)

(* Activator for Learn-Chess/Lær-Skak v1.2 and newer to make
   the  compile/linking more efficient and less memory hungry

   For DK/Engelsk version :    ret i Skaksprog.mod og rekompiler den

   For Shareware/fuld version: ret Demo i Skak.mod, SkakAlt.mod, Skakfil.mod
                               og Skak20Fil.mod og rekompiler dem.
                               Nyt navn sættes i SkakAlt ca linie 360.
  
   For nyt versionsnr+Rev dato : ret cVersion og RevDate i SkakSprog.mod og
                                 rekompiler den.

                 
KOMPILEKÆDEN:
             
SkakGo-->Skak-SkakAlt------------------->SkakScreen-------->SkakData------>SkakData2
 3k       98k         \               /   73k         \      135k            96k
(1k)     (49k)         \             /   (38k)         \     (35k)          (22k)
                        \           /                   \
                         \-SkakKey----->SkakTeori        -->SkakSprog------->SkakBase 
                          \  11k       \   k  \         /      35k        /    1k
                           \ (4k)       \ (k)  \       /      (17k)       |   (1k)
                            \            \      |     /                   |
                             -->Skak20Fil->-SkakFil----->SkakBrainX-      |
                                    75k        58k          16k    /      |
                                   (31k)      (24k)        (6k)   /       |
                                                        _________/        |
                                                       /                  |
                                                       -->SkakBrain-      | 
                                                            74k    /      |
                                                           (26k)  /       |
                                                        _________/        |
                                                       /                 / 
                                                       -->SkakBrainEval--                
                                                             20k           
                                                             (9k)
*)                                                          

FROM Skak IMPORT
  GoSkak;

IMPORT
  VersionLog;

CONST
  SkakGoCompilation="649"; (*hejsa*)

(*  test Scan of gamefile big for White = "Larsen"

                      Optimization            Benefits
    version:  Size:  Compile: Link:  Time:   Size:  Time: 
   ------------------------------------------------------
     68000   207372    No      No    167       -     -
     68000   195388    No      Yes   155       6%    8%
     68000   194644    No      Yes   155       6%    8%    (volatile,stackparms=0)
     68000   189656    Yes     Yes   152       9%    9%
     68020   187112    Yes     Yes   142      10%    15%   (020 1% and 7% better)


 Compile hierachy (general modules --- chess modules):

  Req.def
  DosKald.def
  DosKald.mod
  PointerSprites.def
  PointerSprites.mod
  NarratorSupport.def
  NarratorSupport.mod
  RandomBetter.def
  RandomBetter.mod
      W.def
      W.mod
      VersionLog.def
      VersionLog.mod
      QuickIntuition.def
      QuickIntuition.mod
      QISupport.def
      QISupport.mod
      ReqSupport.def
      ReqSupport.mod
          RequestFile.def
          RequestFile.mod
----------------
          SKAKdata1-6.def
          SKAKdata1-6.mod
              SKAKdata.def
              SKAKdata.mod
              SkakBase.def
              SkakBase.mod
              SkakSprog.def
              SkakSprog.mod
                  SkakScreen.def
                  SkakScreen.mod
                  SkakBrain.def
                  SkakBrain.mod
                  SkakBrainX.def
                  SkakBrainX..mod
                  (Teori.def)
                  (Teori.mod)
                      SkakFil.def
                      SkakFil.mod
                          Skak.def
                          Skak.mod
                              SkakGo.mod
*)  

BEGIN
(*$IF Test *)
  WRITELN(s('SkakGo.1'));
(*$ENDIF *)
  VersionLog.LogVersion("SkakGo.mod",SkakGoCompilation);
  GoSkak;
(*$IF Test *)
  WRITELN(s('SkakGo.2'));
(*$ENDIF *)
END SkakGo.
