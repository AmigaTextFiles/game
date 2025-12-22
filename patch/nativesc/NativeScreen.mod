(*******************************************************************************
 : Program.         NativeScreen.MOD
 : Author.          Carsten Wartmann
 : Address.         Wutzkyallee 83, D-1000 Berlin 47
 : Phone.           030/6614776
 : E-Mail           C.Wartmann@AMBO.in-berlin.de
 : Version.         1.0
 : Date.            11/94
 : Copyright.       PD (Please e-mail me for suggestions !)
 : Language.        Modula-2
 : Compiler.        M2Amiga V4.3d
 : Contents.        Makes several games run with Picasso/EGS-Spektrum WB .
 : Remark.          OS 2.0 only !!!!!!!!!!!!!!!!!!!!!!!!!
*******************************************************************************)


MODULE NativeScreen ;


FROM SYSTEM       IMPORT BITSET,ADR,ADDRESS,ASSEMBLE,TAG,LONGSET ;

FROM Arts         IMPORT Assert ;

FROM ExecSupport IMPORT CreatePort,DeletePort ;

FROM ExecL       IMPORT WaitPort,ReplyMsg,GetMsg,execVersion,AllocMem,FreeMem,
                        FindPort,PutMsg,Forbid,Permit ;
FROM ExecD       IMPORT MsgPortPtr,Message,MessagePtr,MemReqs,MemReqSet,
                        NodeType ;

FROM DosL         IMPORT Delay ;

FROM IntuitionL   IMPORT OpenScreenTagList,CloseScreen,OpenWindowTagList,
                         CloseWindow,DisplayBeep,EasyRequestArgs,
                         SetMenuStrip,ClearMenuStrip ;
FROM IntuitionD   IMPORT NewScreen,ScreenPtr,customScreen,NewWindow,WindowPtr,
                         IntuiMessage,IDCMPFlags,IDCMPFlagSet,WindowFlags,
                         WindowFlagSet,SaTags,WaTags,DrawPens,IntuiMessagePtr,
                         MenuItemFlags,MenuItemFlagSet,Gadget,GadgetPtr,
                         EasyStruct,GaTags ;

FROM GraphicsL    IMPORT Move,Draw,SetAPen,WaitBOVP,RectFill,LoadRGB4,
                         WritePixel,ReadPixel,DrawEllipse,
                         ScrollRaster,ScrollVPort,WaitTOF,SetDrMd,
                         Text,OpenFont,CloseFont,SetFont,AskSoftStyle,
                         SetSoftStyle ;
FROM GraphicsD    IMPORT ViewModes,ViewModeSet,jam1,
                         RastPortPtr,ViewPortPtr,ViewPtr,TextAttr,TextFontPtr,
                         FontStyleSet,FontStyles,FontFlagSet,FontFlags,
                         hireslaceKey,loresKey ;

(* Grundlegende Tag-Hilfen *)
FROM UtilityD     IMPORT tagDone,TagItem,TagItemPtr,Tag,TagPtr ;
FROM UtilityL     IMPORT AllocateTagItems,FreeTagItems ;




(*Versionsstring für OS 2.0 (version) muß im Programm nochmal verwendet
  werden, da der Compiler ungenutzte Konstanten "wegoptimiert" !        *)

CONST Version  = "$VER: NativeScreen V1.0 (22.11.94)" ;
      PortName = "NativeScreenPort" ;


TYPE TstMsg=RECORD
       msg  : Message ;
       text : ARRAY [0..80] OF CHAR ;
     END ;



VAR screenptr     : ScreenPtr ;			(* Screen und Window Pointer *)
    port,rport    : MsgPortPtr ;
    mail          : TstMsg ;
    mailptr       : POINTER TO TstMsg ;
    msgmem        : ADDRESS ;

    version       : ARRAY [0..40] OF CHAR ;     (* Hält nachher Versionsstr. *)

    mytags        : ARRAY [0..40] OF LONGINT ;  (* Buffer für die Tags       *)

    pens          : INTEGER ;




PROCEDURE OpenAll ;

  BEGIN (* Öffnen des Screens und Windows *)

    (* Versionscheck damit wir unter uns (2.0) bleiben...*)
    Assert(execVersion>36,ADR("PRG ist ohne OS 2.0 nicht lauffähig !")) ;

    pens := -1 ;   (* Macht Intui klar daß wir die WB-Farben wollen *)

    (* Bildschirm mit Hilfe der Tags öffnen *)
    screenptr := OpenScreenTagList(NIL,TAG(mytags,
                           saWidth,             320,
                           saHeight,            256,
                           saDisplayID,		loresKey,
                           saDepth,		1,
                           saPens,		ADR(pens),
                           tagDone)) ;
    Assert(screenptr#NIL,ADR("Nix Bildschirm...")) ; (* offen ??? *)

  END OpenAll ;



BEGIN

  version := Version ;  (* So gehts immerhin... *)

  Forbid() ;
  port := FindPort(ADR(PortName)) ;
  IF port=NIL THEN
    port := CreatePort(ADR(PortName),0) ;
    OpenAll ;

    WaitPort(port) ;
    mailptr := GetMsg(port) ;
    IF mailptr#NIL THEN
      mailptr^.text := "Jaaa ???" ;
      ReplyMsg(mailptr) ;
      DeletePort(port) ;
    END ;
  ELSE
    rport := CreatePort(NIL,0) ;
    mailptr := AllocMem(SIZE(TstMsg),MemReqSet{memClear,public}) ;
    mailptr^.msg.node.type := NodeType{message} ;
    mailptr^.msg.length    := SIZE(TstMsg) ;
    mailptr^.msg.replyPort := rport ;
    mailptr^.text          := "Hallo !!" ;
    PutMsg(port,mailptr) ;
    WaitPort(rport) ;

    mailptr := GetMsg(rport) ;

    DeletePort(rport) ;

    (* Brav die Resourcen zurückgeben *)
    IF mailptr#NIL THEN
      FreeMem(mailptr,SIZE(mail)) ;
    END ;
  END ;
  Permit() ;


CLOSE

  IF screenptr # NIL THEN
    CloseScreen(screenptr) ;
  END (*IF*) ;

END NativeScreen .
