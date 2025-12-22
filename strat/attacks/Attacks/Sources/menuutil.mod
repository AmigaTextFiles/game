IMPLEMENTATION MODULE MenuUtil;

IMPORT Intuition, Memory, Rasters, Strings, Tasks;
FROM SYSTEM IMPORT ADDRESS, ADR, BYTE;
FROM System IMPORT HALTX;
FROM TermInOut IMPORT WriteString, WriteLn, WriteInt, WriteCard, WriteHex;
FROM AmigaDosProcess IMPORT Delay;
FROM Intuition IMPORT IDCMPFlagsSet, WindowFlagsSet,
                      MenuFlagsSet, MenuItemFlagsSet, MenuItemMutualExcludeSet,
                      AllocRemember, FreeRemember, MenuItemFlags;
FROM Util IMPORT STRINGPTR, WriteAddress, WriteByte, WriteStringPtr;


CONST
  MemoryFlags = Memory.MemReqSet{ Memory.MemChip, Memory.MemClear };
  CharWidth   = 8;
  CharHeight  = 8;

VAR
  menucount : CARDINAL;      (* This "hack" is used to try to fix the  *)
                             (* offset on the first menu item's select *)
                             (* block. *)

(************************************)

PROCEDURE CreateStringCopy(     String     : ARRAY OF CHAR;
                            VAR RememberKey: Intuition.RememberPtr ): STRINGPTR;

(* Creates a copy of the given string in newly allocated memory and returns
 * pointer to it.  Returns NIL if memory allocation fails.
 *)

VAR
  StringPtr : STRINGPTR;
BEGIN
  StringPtr := AllocRemember( RememberKey,
                              Strings.StringLength(String)+1, MemoryFlags );
  IF StringPtr = NIL THEN
    WriteString("Allocation failed in CreateStringCopy"); WriteLn();
    RETURN NIL;
  END;
  Strings.CopyString( StringPtr^, String );
  RETURN StringPtr;
END CreateStringCopy;

(************************************)

PROCEDURE CreateIText(     StringPtr  : STRINGPTR;
                       VAR RememberKey: Intuition.RememberPtr ) :
                                                     Intuition.IntuiTextPtr;
VAR
  ITextPtr : Intuition.IntuiTextPtr;
BEGIN
  ITextPtr := AllocRemember( RememberKey,
                             SIZE(ITextPtr^), MemoryFlags );
  IF ITextPtr = NIL THEN
    WriteString("Allocation failed in CreateIText"); WriteLn();
    RETURN NIL;
  END;
  ITextPtr^.FrontPen  := BYTE(0);
  ITextPtr^.BackPen   := BYTE(1);
  ITextPtr^.DrawMode  := Rasters.Jam2;
  ITextPtr^.LeftEdge  := 0;
  ITextPtr^.TopEdge   := 1;            (* leave one pixel row above *)
  ITextPtr^.ITextFont := NIL;
  ITextPtr^.IText     := StringPtr;
  ITextPtr^.NextText  := NIL;
  RETURN ITextPtr;
END CreateIText;

(************************************)

PROCEDURE DumpIntuiText( ITextPtr : Intuition.IntuiTextPtr );
BEGIN
  WriteString("    INTUITEXT DUMP"); WriteLn();
  WriteString("    ITextPtr  = "); WriteAddress( ITextPtr ); WriteLn();
  IF ITextPtr # NIL THEN
    WITH ITextPtr^ DO
      WriteString("    FrontPen  = "); WriteByte( FrontPen, 6 );  WriteLn();
      WriteString("    BackPen   = "); WriteByte( BackPen,  6 );  WriteLn();
      WriteString("    DrawMode  = ");                            WriteLn();
      WriteString("    LeftEdge  = "); WriteInt( LeftEdge,  6 );  WriteLn();
      WriteString("    TopEdge   = "); WriteInt( TopEdge ,  6 );  WriteLn();
      WriteString("    ITextFont = "); WriteAddress( ITextFont ); WriteLn();
      WriteString("    IText     = "); WriteStringPtr( IText );   WriteLn();
      WriteString("    NextText  = "); WriteAddress( NextText );  WriteLn();
      DumpIntuiText( NextText );
    END;  (* WITH *)
  END;  (* IF *)
END DumpIntuiText;

(************************************)

PROCEDURE DumpItem( ItemPtr : Intuition.MenuItemPtr );
BEGIN
  WriteString("  ITEM DUMP"); WriteLn();
  WriteString("  ItemPtr    = "); WriteAddress( ItemPtr ); WriteLn();
  IF ItemPtr # NIL THEN
    WITH ItemPtr^ DO
      WriteString("  LeftEdge   = "); WriteInt( LeftEdge, 6 );    WriteLn();
      WriteString("  TopEdge    = "); WriteInt( TopEdge , 6 );    WriteLn();
      WriteString("  Width      = "); WriteInt( Width   , 6 );    WriteLn();
      WriteString("  Height     = "); WriteInt( Height  , 6 );    WriteLn();
      WriteString("  Flags      = ");                             WriteLn();
      WriteString("  MutualExcl = ");                             WriteLn();
      WriteString("  Command    = "); WriteByte( Command, 6 );    WriteLn();
      WriteString("  SubItem    = "); WriteAddress( SubItem );    WriteLn();
      WriteString("  ItemFill   = "); WriteAddress( ItemFill );   WriteLn();
      DumpIntuiText( ItemFill );
      WriteString("  SelectFill = "); WriteAddress( SelectFill ); WriteLn();
      DumpIntuiText( SelectFill );
      WriteString("  NextItem   = "); WriteAddress( NextItem );   WriteLn();
      DumpItem( NextItem );
    END;  (* WITH *)
  END;  (* IF *)
END DumpItem;

(************************************)

PROCEDURE DumpMenu( MenuPtr : Intuition.MenuPtr );
BEGIN
  WriteString("MENU DUMP"); WriteLn();
  WriteString("MenuPtr   = "); WriteAddress( MenuPtr ); WriteLn();
  IF MenuPtr # NIL THEN
    WITH MenuPtr^ DO
      WriteString("MenuName  = "); WriteStringPtr( MenuName ); WriteLn();
      WriteString("LeftEdge  = "); WriteInt( LeftEdge, 6 );    WriteLn();
      WriteString("TopEdge   = "); WriteInt( TopEdge , 6 );    WriteLn();
      WriteString("Width     = "); WriteInt( Width   , 6 );    WriteLn();
      WriteString("Height    = "); WriteInt( Height  , 6 );    WriteLn();
      WriteString("Flags     = ");                             WriteLn();
      WriteString("FirstItem = "); WriteAddress( FirstItem );  WriteLn();
      DumpItem( FirstItem );
      WriteString("NextMenu  = "); WriteAddress( NextMenu );   WriteLn();
      DumpMenu( NextMenu );
    END;  (* WITH *)
  END;  (* IF *)
END DumpMenu;

(************************************)

PROCEDURE Dump( MenuBarPtr : MENUBARPTR );
BEGIN
  DumpMenu( MenuBarPtr^.FirstMenuPtr );
END Dump;

(************************************)

PROCEDURE InitMenuBar( VAR MenuBarPtr : MENUBARPTR );

BEGIN
  MenuBarPtr := Memory.AllocMem( SIZE(MenuBarPtr^), MemoryFlags );
  IF MenuBarPtr = NIL THEN
    WriteString("Allocation for new menu bar failed"); WriteLn;
  ELSE
    MenuBarPtr^.FirstMenuPtr := NIL;
    MenuBarPtr^.RememberKey  := NIL;
  END;
END InitMenuBar;

(************************************)

PROCEDURE FindLastMenu(     FirstMenuPtr : Intuition.MenuPtr;
                        VAR MenuPtr      : Intuition.MenuPtr;
                        VAR MenuNumber   : INTEGER            );
BEGIN
  MenuPtr    := FirstMenuPtr;
  MenuNumber := -1;
  IF MenuPtr # NIL THEN
    MenuNumber := 0;
    WHILE MenuPtr^.NextMenu # NIL DO         (* find last menu *)
      MenuPtr := MenuPtr^.NextMenu;
      INC( MenuNumber );
    END;
    (* MenuPtr now points to the last menu *)
  END;
END FindLastMenu;

(************************************)

PROCEDURE FindLastItem(     FirstItemPtr : Intuition.MenuItemPtr;
                        VAR ItemPtr      : Intuition.MenuItemPtr;
                        VAR ItemNumber   : INTEGER                );
BEGIN
  ItemPtr    := FirstItemPtr;
  ItemNumber := -1;
  IF ItemPtr # NIL THEN
    ItemNumber := 0;
    WHILE ItemPtr^.NextItem # NIL DO         (* find last item *)
      ItemPtr := ItemPtr^.NextItem;
      INC( ItemNumber );
    END;
    (* ItemPtr now points to the last menu *)
  END;
END FindLastItem;

(************************************)

PROCEDURE AddMenu( MenuBarPtr : MENUBARPTR;
                   MenuName   : ARRAY OF CHAR );
VAR
  LastMenuPtr : Intuition.MenuPtr;
  NewMenuPtr  : Intuition.MenuPtr;
  MenuNumber  : INTEGER;
  MenuNamePtr : STRINGPTR;

BEGIN
  MenuNamePtr := CreateStringCopy( MenuName, MenuBarPtr^.RememberKey );

  FindLastMenu( MenuBarPtr^.FirstMenuPtr, LastMenuPtr, MenuNumber );
  IF MenuNumber+1 >= Intuition.NoMenu THEN
    WriteString("ERROR in MenuUtil: Too many menus"); WriteLn();
    RETURN;
  END;

(*  WriteString("Adding menu: ");  WriteString( MenuNamePtr^ );
 *  WriteCard( MenuNumber+1, 3 );  WriteLn();
 *)

  NewMenuPtr := AllocRemember( MenuBarPtr^.RememberKey,
                               SIZE(NewMenuPtr^), MemoryFlags );
  IF NewMenuPtr = NIL THEN
    WriteString("Allocation of menu failed"); WriteLn();
    RETURN;
  END;
  IF LastMenuPtr = NIL THEN
    MenuBarPtr^.FirstMenuPtr := NewMenuPtr;
  ELSE
    LastMenuPtr^.NextMenu := NewMenuPtr;
  END;

  NewMenuPtr^.NextMenu  := NIL;
  NewMenuPtr^.Flags     := MenuFlagsSet{ Intuition.MenuEnabled };
  NewMenuPtr^.MenuName  := MenuNamePtr;
  NewMenuPtr^.Width     := CharWidth * ( Strings.StringLength(MenuNamePtr^)+1 );
  NewMenuPtr^.FirstItem := NIL;
END AddMenu;

(************************************)

PROCEDURE AddItem( MenuBarPtr : MENUBARPTR;
                   ItemName   : ARRAY OF CHAR;
                   Command    : CHAR;       (* Is 0C if no command *)
                   MutEx      : MenuItemMutualExcludeSet;
                             (* This set should be empty if no check mark *)
                   InitCheck  : BOOLEAN );     (* Start with a check? *)
CONST
  ItemFlags = MenuItemFlagsSet{ Intuition.ItemText,
                                Intuition.ItemEnabled,
                                Intuition.MIF6         };
VAR
  LastMenuPtr : Intuition.MenuPtr;
  MenuNumber  : INTEGER;
  LastItemPtr : Intuition.MenuItemPtr;
  ItemNumber  : INTEGER;
  NewItemPtr  : Intuition.MenuItemPtr;
  ItemNamePtr : STRINGPTR;
  NewITextPtr : Intuition.IntuiTextPtr;

BEGIN
  FindLastMenu( MenuBarPtr^.FirstMenuPtr, LastMenuPtr, MenuNumber );
  IF LastMenuPtr = NIL THEN
    WriteString("ERROR--attempt to add item w/o any menus"); WriteLn();
    RETURN;
  END;

  FindLastItem( LastMenuPtr^.FirstItem, LastItemPtr, ItemNumber );
  IF ItemNumber+1 >= Intuition.NoItem THEN
    WriteString("ERROR in MenuUtil: Too many items"); WriteLn();
    RETURN;
  END;

  ItemNamePtr := CreateStringCopy( ItemName, MenuBarPtr^.RememberKey );
  IF NewItemPtr = NIL THEN RETURN; END;

  NewITextPtr := CreateIText( ItemNamePtr, MenuBarPtr^.RememberKey );
  IF NewITextPtr = NIL THEN RETURN; END;

(*  WriteString("Adding item: ");  WriteString( ItemNamePtr^ );
 *  WriteCard( ItemNumber+1, 3 );  WriteLn();
 *)

  NewItemPtr := AllocRemember( MenuBarPtr^.RememberKey,
                               SIZE(Intuition.MenuItem), MemoryFlags );
  IF NewItemPtr = NIL THEN
    WriteString("Allocation of item failed"); WriteLn();
    RETURN;
  END;

  IF LastItemPtr = NIL THEN
    LastMenuPtr^.FirstItem := NewItemPtr;
  ELSE
    LastItemPtr^.NextItem := NewItemPtr;
  END;

  NewItemPtr^.NextItem      := NIL;
(****
  NewItemPtr^.LeftEdge      := 0;
  NewItemPtr^.TopEdge       := 2 + 10*(ItemNumber+1);
  NewItemPtr^.Width         := 100;
  NewItemPtr^.Height        := 10;
****)
  NewItemPtr^.Flags         := ItemFlags;
  NewItemPtr^.MutualExclude := MenuItemMutualExcludeSet{};
  NewItemPtr^.ItemFill      := NewITextPtr;
  NewItemPtr^.Command       := BYTE(0);
  NewItemPtr^.SubItem       := NIL;
  IF Command # 0C THEN
     INCL ( NewItemPtr^.Flags, CommSeq );
     NewItemPtr^.Command := BYTE(Command);
     END;
  IF MutEx # MenuItemMutualExcludeSet {} THEN
     INCL ( NewItemPtr^.Flags, CheckIt );
     NewItemPtr^.MutualExclude := MutEx;
     IF InitCheck THEN
        INCL ( NewItemPtr^.Flags, Checked );
        END;
     END;
END AddItem;

(************************************)

PROCEDURE IntuiTextWidth( ITextPtr : Intuition.IntuiTextPtr ) : INTEGER;

(* *)

BEGIN
  RETURN Intuition.IntuiTextLength( ITextPtr^ );
END IntuiTextWidth;

(************************************)

(* MOVE TO UTIL.MOD *)

PROCEDURE MaxInt( Value1, Value2 : INTEGER ): INTEGER;
BEGIN
  IF Value1 > Value2 THEN
    RETURN Value1;
  ELSE
    RETURN Value2;
  END;
END MaxInt;

(************************************)

PROCEDURE ArrangeItems( MenuPtr       : Intuition.MenuPtr;
                        MenuNameWidth : INTEGER            );

CONST
  ItemGap = 2;      (* vertical space between items *)
VAR
  ItemPtr      : Intuition.MenuItemPtr;
  ItemPosition : INTEGER;
  ItemNumber   : INTEGER;
  MaxWidth     : INTEGER;
BEGIN
  ItemNumber   := 0;
  ItemPosition := ItemGap;
  MaxWidth     := MenuNameWidth; (* since pull-down will be at least this wide*)
  ItemPtr      := MenuPtr^.FirstItem;
  WHILE ItemPtr # NIL DO
 (* WriteString("Arranging Item "); WriteCard(ItemNumber,2); WriteLn(); *)

    IF menucount = 1 THEN                (* A hack to fix some menus *)
      ItemPtr^.LeftEdge := 2;
      ELSE
        ItemPtr^.LeftEdge := 0;
      END;

    ItemPtr^.TopEdge  := ItemPosition;
    ItemPtr^.Height   := CharHeight + ItemGap ;
    MaxWidth          := MaxInt( MaxWidth, IntuiTextWidth(ItemPtr^.ItemFill) );
    INC( ItemPosition, CharHeight + ItemGap );    (* for next item *)
    INC( ItemNumber );
    ItemPtr := ItemPtr^.NextItem;
  END;
  ItemPtr := MenuPtr^.FirstItem;
  WHILE ItemPtr # NIL DO
    ItemPtr^.Width := MaxWidth;
    ItemPtr := ItemPtr^.NextItem;
  END;
END ArrangeItems;

(************************************)

PROCEDURE ArrangeMenus( MenuBarPtr : MENUBARPTR );
CONST
  MenuGap = 20;     (* horizontal space between menu names *)
VAR
  MenuPtr      : Intuition.MenuPtr;
  MenuNamePtr  : STRINGPTR;
  MenuNameWidth: INTEGER;
  MenuPosition : INTEGER;
  MenuNumber   : INTEGER;
BEGIN
  menucount := 1;
  MenuNumber   := 0;
  MenuPosition := 0;
  MenuPtr      := MenuBarPtr^.FirstMenuPtr;
  WHILE MenuPtr # NIL DO
 (* WriteString("Arranging menu "); WriteCard(MenuNumber,2); WriteLn(); *)
    MenuNamePtr   := MenuPtr^.MenuName;
    MenuNameWidth := Strings.StringLength( MenuNamePtr^ ) * CharWidth;
    MenuPtr^.LeftEdge := MenuPosition;
    ArrangeItems( MenuPtr, MenuNameWidth );
    INC( MenuPosition, MenuNameWidth + MenuGap );  (* for next menu *)
    INC( MenuNumber );
    MenuPtr := MenuPtr^.NextMenu;
    INC( menucount );
  END;
END ArrangeMenus;

(************************************)

PROCEDURE DisposeMenuBar( VAR MenuBarPtr : MENUBARPTR );
BEGIN
  Intuition.FreeRemember( MenuBarPtr^.RememberKey, TRUE );
  Memory.FreeMem( MenuBarPtr, SIZE(MenuBarPtr^) );
  MenuBarPtr := NIL;  (* this IS necessary--first FreeMem param is not a VAR *)
END DisposeMenuBar;

(************************************)
END MenuUtil.
