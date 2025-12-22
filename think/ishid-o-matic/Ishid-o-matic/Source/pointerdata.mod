(*$ ChipCODE:=TRUE *)

IMPLEMENTATION MODULE PointerData;

FROM SYSTEM IMPORT ASSEMBLE;

PROCEDURE NormPtrData; (*$ EntryExitCode:=FALSE *)

  BEGIN
    ASSEMBLE(
    DC.W $00000,$00000,
         $0FF00,$0FF00,
         $07E00,$08000,
         $07C00,$08400,
         $07E00,$08200,
         $07F00,$08100,
         $05F80,$0A080,
         $04E00,$09100,
         $00400,$08A00,
         $00000,$00400,
         $00000,$00000
    END);
  END NormPtrData;

PROCEDURE SinglePtrData; (*$ EntryExitCode:=FALSE *)
  BEGIN
    ASSEMBLE(
    DC.W $00000,$00000,
         $0FF00,$0FF00,
         $07E00,$08018,
         $07C00,$08438,
         $07E00,$08218,
         $07F00,$08118,
         $05F80,$0A098,
         $04E00,$09118,
         $00400,$08A3C,
         $00000,$00400,
         $00000,$00000
    END);
  END SinglePtrData;

PROCEDURE TwoPtrData;	(*$ EntryExitCode:=FALSE *)
  BEGIN
    ASSEMBLE(
    DC.W $00000,$00000,
         $0FF00,$0FF00,
         $07E00,$0801C,
         $07C00,$08436,
         $07E00,$08206,
         $07F00,$0810C,
         $05F80,$0A098,
         $04E00,$09130,
         $00400,$08A3E,
         $00000,$00400,
         $00000,$00000
    END);
  END TwoPtrData;

END PointerData.imp
