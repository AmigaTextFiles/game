IMPLEMENTATION MODULE SkakSprog;

(* tidligere kaldet skakdiv *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(*$ DEFINE Dansk  :=FALSE *)   (*  OK  *)   (* Kun een af sprogene TRUE *)
(*$ DEFINE Engelsk:=TRUE *)    (*  OK  *)
(*$ DEFINE Svensk :=FALSE *)   (*  U/S *)
(*$ DEFINE Tysk   :=FALSE *)   (*  U/S *)

FROM SYSTEM IMPORT
  ADR,ADDRESS;
FROM Heap IMPORT
  Allocate;
FROM VersionLog IMPORT
  LogVersion;
FROM String IMPORT
  Concat, Copy, Length;
FROM FileSystem IMPORT
  File, Lookup, Close, Response, ReadChar;
FROM FileSystemSupport IMPORT
  ReadString; (*,WriteString*)
FROM SkakBase IMPORT
  NoLocale;

(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs;
(*$ENDIF *)

CONST
  SkakSprogModCompilation="223";

  RevDate='4/8-98';
  cVersion="v2.8"+
(*$IF m68020 *)
  "q";
(*$ELSE *)
  " ";
(*$ENDIF *)

TYPE
  TAGarr147=ARRAY[147..181] OF ARRAY[0..19] OF CHAR;

CONST

(*$ IF Dansk *)
cTxFILTERDROPHENT='Vil du bruge stillingen på brættet som\n'+
                  'filter ved indlæsning af spil?\n';
cTxOK='  O K  ';
cTxMID=' DROP ';
cTxUPS=' UPS ! ';
cTxSti=' Sti';
cTxNavn='Navn';
cTxUdvalgt='Udvalgt';
cTxOKAY='OH3KEY1';
cTxSKAKMAT='SKAX6K, OW, MAX6T.';
cTxHVIDVANDT='VIY4DH, VAENDT.';
cTxSORTVANDT='SOH2AXT, VAENDT.';
cTxREMIS='REHMIX1.';
cTxHUMM='WHM';
cTxAHA='AX1/HAH2,';
cTxHVIDSTUR='VIY9DHS TUW2AX';
cTxSORTSTUR='SOH2AXTS TUW2AX';
cTxNAAH='NAH';
cTxENPASSANT='AANG PAXSAANG';
cTxROKADE='ROHKAEDHEH';
cTxPATREMIS='PAET, REHMIX1.';
cTxHAPS='/HAAPS';
cTxSKAK='SKAX6K';
cTxDENKANIKKERYKKES='DEH9N, KAXN, EH9KEH, RERKEHS.';
cTxGODDAG='GUHDAE1, MEHD DAY.';
cTxForkertTegnIStilling='Forkert tegn i stilling.';
 
cFxs01='udført';
cFxs02='ikke udført';
cFxs03='låsefejl';
cFxs04='åbnefejl';
cFxs05='læsefejl';
cFxs06='skrivefejl';
cFxs07='søgefejl';
cFxs08='lagerfejl';
cFxs09='i brug';
cFxs10='ikke fundet';
cFxs11='disk skrivebeskyttet';
cFxs12='apparat ikke monteret';
cFxs13='disken er fuld';
cFxs14='filen er slettebeskyttet';
cFxs15='filen er skrivebeskyttet';
cFxs16='disken er ikke en DOS disk';
cFxs17='ingen Disk';
cFxs18='ukendt problem';            
cTxGEMSPIL='Gem Spil/Opgave';
cTxSKRIVSPIL='Skriv Spil/Opgave';
cTxIKKEGEMT='\n  I K K E   g e m t  !  \n\n';
cTxIKKEUDSKREVET='\n  I K K E   u d s k r e v e t  !  \n\n';
cTxHENTSPIL='Hent Spil/Opgave';
cTxLAESSPIL='Indlæs Spil/Opgave fra Tekst';
cTxSPILIKKETEKST=' En Spil/Opgave fil, ikke en tekst-fil \n';
cTxLINIE='  Linie ';
cTxPOSITION=', Position ';
cTxHALVTRAEK=', HalvTræk ';
cTxIKKEHENTET='\n  I K K E   h e n t e t  !  \n\n';
cTxIKKESKAKFIL='ikke en korrekt skak-fil';
cTxIKKESKAKTXT=' filen indeholder ikke (mere) \n læsbar skak-tekst.';
cTxUKORREKTKUNDELVIS='\n Afbrød indlæsning \n ved ubrugbart træk!\n\nIndlæsning af evt. følgende parti kan forsøges. \n(er tooltype INTERNATIONAL=ON ?)';
cTxSKAKSPISEBMREV='\n----- S K A K, spis kongen -----\n\n   (c) E.B.Madsen 1990/91 DK\n       Rev: ';
cTxDUVALGTEAT='\n\nDu valgte at ';
cTxFORLIDTRAMDROPTEKST='\n  For lidt RAM !!!!!  \n  Drop teksten ?  \n';
cAx01='Special-stilling (ingen sorte brikker). \nHvid vil kunne trække hver gang';
cAx02='For mange hvide bønder (højest 8)';
cAx03='For mange sorte bønder (højest 8)';
cAx04='Sort konge, men ingen tårne, har rokaderet';
cAx05='Hvid konge, men ingen tårne, har rokaderet';
cAx06='Sort tårn, men ikke konge, har rokaderet';
cAx07='Hvidt tårn, men ikke konge, har rokaderet';
cAx08='Ingen hvid konge';
cAx09='Ingen sort konge';
cAx10='Mere end 2 hvide tårne';
cAx11='Mere end 2 sorte tårne';
cAx12='Mere end 2 hvide springere';
cAx13='Mere end 2 sorte springere';
cAx14='Mere end 2 hvide løbere';   
cAx15='Mere end 2 sorte løbere';   
cAx16='Mere end 1 hvid dronning';  
cAx17='Mere end 1 sort dronning';  
cTxKONTROLADVARSEL=' kontrol af stilling:  --- A D V A R S E L --- \n';
cTxSTOP='\n\n        S  T  O  P     ?      \n\n';
cDemoMessage="---- Shareware-version!! #0439 ----\n\n"+
              "Gem/udskriv, høj styrke, over 80 træk,\n"+
              "og andre ting er derfor slået fra.\n\n"+
              "Køb nyeste, fulde version for 400 DKR ($70) hos :\n"+
              "  Programmør E. B. Madsen\n"+
              "  Kastebjergvej 23\n"+
              "  2750 Ballerup, DK Denmark\n"+
              "og undgå denne meddelelse og få ca 80.000 nye PIG spil!";

tRYKKE='rykke ';
tPLACERE='placere ';
t00='få hjælp til den sidst brugte\nfunktion. Vælg een og prøv igen\n';
t01='vende brættet om\n';
t02='spille for hvid\n';
t03='spille for sort\n';
t04='jeg skal spille for hvid\n';
t05='jeg skal spille for sort\n';
t06='jeg skal tænke hurtigt\n';
t07='jeg skal tænke almindeligt\n';
t08='jeg skal tænke grundigt\n';
t09='hente opgave/spil ind fra disk\n';
t59='indlæse opgave/spil fra tekstfil på disk\n';
t10='gemme opgave/spil ud på en disk\n'; 
t60='udskrive opgave/spil på printer/tekstfil\n'; 
t11='gå til spillets start\n';
t12='gå et træk tilbage\n'; 
t13='gå et træk frem\n';
t14='gå til spillets slutning\n'; 
t15='slå tale til\n'; 
t16='slå tale fra\n'; 
t17='ændre farverne\n';
t18='starte på et nyt spil\nVælg OK eller fortryd med UPS!\n'; 
t19='felt beherskelse skal vises\n'; 
t20='felt beherskelse ikke skal vises\n'; 
t21='ændre på stillingen\nNår du er færdig så Vælg OK eller fortryd med UPS!\n'; 
t22='hvid er i trækket\n'; 
t23='sort er i trækket\n'; 
t24='sætte start-stillingen op\n'; 
t25='tømme brættet\n'; 
t26='gå tilbage til original-stillingen\n'; 
t27='indtaste en kommentar til denne\nstilling. Hvis det er den eneste ændring, vil\ndet igangværende spil bevares\n'; 
t28='en KONGE med rokade-ret\nKan den ikke reddes er spillet tabt\n'; 
t29='en KONGE uden rokade-ret\nKan den ikke reddes er spillet tabt\n'; 
t30='en DRONNING\nDe er cirka 8 til 9 bønder værd\n'; 
t31='et TÅRN med rokade-ret\nDe er cirka 4 til 5 bønder værd\n'; 
t32='et TÅRN uden rokade-ret\nDe er cirka 4 til 5 bønder værd\n'; 
t33='en LØBER\nDe er cirka 3 bønder værd\n'; 
t34='en SPRINGER\nDe er cirka 3 bønder værd\n'; 
t35='en BONDE der må slå\nen-passant D.V.S. slå en bonde der\nnetop er passeret ved at gå to frem\n';
t36='en BONDE\nDe kan forvandles til DRONNING når\nde rykkes til sidste række\n';                    
t37='et tomt felt\n';
t38='flytte rundt på brikkerne\n';
t39='afslutte spillet, men fortrød\n';
t40='gå tilbage til spillet\n'; 
t41='gå igang med et nyt spil\n';
t42='gem/hent opgave/spil vil gå på disk'; 
t43='gem/hent vil skrive opgave/spil til printer\n(evt skrive/læse opgave/spil på disk)';
t44='44\n';                                                                              

cTASTBESKRIVELSE="  T A S T    B E S K R I V E L S E  ";
cLAERSKAK="PIGbase4 med LÆR SKAK "+cVersion+"  (c) EBM";

TxrU='r';
TxtU='t';
TxsU='s';
TxlU='l';
TxdU='d';
TxmU='m';
TxkU='k';
TxeU='e';
TxbU='b';
TxRU='R';
TxTU='T';
TxSU='S';
TxLU='L';
TxDU='D';
TxMU='M';
TxKU='K';
TxEU='E';
TxBU='B';

TxQ83 ='Det er en PIG-BASE fil, brug tasterne:\n\n'+
       '  F1 = Udvælg PIG-BASE spil og hent\n'+
       '  F2 = Hent fra udvalgte spil\n';
TxQ84 ='\n  Ikke flere spil i PIG-BASE fil  \n';
TxQ85 ='Vælg en PIG-BASE fil:';
TxQ86 ='Tilføj spil til PIG-BASE fil:';

TxQ87 =' orig.';
TxQ88 =' slet ';
TxQ89 ='  PGN ';
TxQ90 ='tilføj';
TxQ91 ='Match Variant';
TxQ92 ='FILTER';
TxQ93 ='PGN INFORMATION TAG';
TxQ94 ='alle0 ';
TxQ95 ='alle1 ';
TxQ96 =' vin0 ';
TxQ97 =' vin1 ';
TxQ201='Vælg fra listen...';
TxQ202=' Alloc: Jeg vil have ram memory! \n  Frigør noget hvis muligt.';
TxQ203=' spil læst fra     : ';
TxQ204=' spil tilføjet til : ';
TxQ205='\n Spil markeret som slettet i PIG fil: \n\n ';
TxQ206='\n Tast F7 nu for at danne igen\n';
TxQ207='\n Spil gendannet i PIG fil: \n\n ';
TxQ208='INGEN LISTE !!!  brug først F1 for at udvælge PIG-BASE spil';
TxQ209='LÆSER LISTE, læst: ';
TxQ210=
'\n  F1  = Vælg PIG-BASE spil og hent'+
'\n  F2  = Hent fra valgte spil'+
'\n (F3  = Udvælg spil og tilføj dem til en PIG fil) '+
'\n  F4  = Konverter alle PGN (CBF) filer til PIG filer'+
'\n  F5  = Gem/tilføj spil til en PIG fil'+
'\n (F6  = Marker spil som slettet i PIG fil)'+
'\n (F7  = Marker spil som ikke-slettet i PIG fil)'+
'\n  F8  = Tilføj en PIG fil til en PIG fil'+
'\n  F9  = Konverter en PGN (CBF) fil til en PIG fil'+
'\n  F0  = Konverter en PIG fil til en PGN fil'+
'\n NumL = Vis (ScrL=ret) PGN INFORMATIONER (TAGS)'+
'\n Enter= (Op)ret kommentarer til denne position'+
'\n Esc  = Afbryd         AT FLYTTE I ET SPIL:'+
'\n Home, Op(10), PgUp(4), Ve, Hø PgDn, Ned, End'+
'\n ANDRE: M=Tabel, N/E/K=NIC/ECO/BEGGE nøgler';
TxQ211=' spil fra ';
TxQ212=' fil: ';
TxQ213='føj til ';
TxQ214='Ændringer lavet til spillet i: \n\n'; (* fri?*)
TxQ215='  Kommentarer\n';
TxQ216='  PGN informationer\n';
TxQ217='  Træk\n'; (* fri?*)
TxQ218='\n er det OK at skippe spillet?\n'; (* fri?*)
TxQ219=' af spillene kunne ikke konverteres fuldstændigt!';
TxQ220='\nOK at vende slet-markering ved de\nudvalgte spil ?\n';
TxQ221='Giver hjælp til den sidst aktiverede funktion i filter';

TxQ262='Start/stop  analyse (bevar spillet imens)';
TxQ263='Gør analyse til Spil (og glem resten af spillet)';
TxQ264='Retur (gem analysen som kommentar til spillet).';
TxQ265='\n ADVARSEL! Filen findes i forvejen, OK at skrive ? \n';
TxQ266='Marker nogle spil i listen først!\n';
TxQ267='     1 spil fra PGN fil:  \n\n  ';
TxQ268='  \n\ntilføjet til PIG-BASE fil:  \n\n  ';
TxQ269=' PGN filer konverteret til PIG filer.  \n\n';
TxQ270=' Se detaljer i t:AutoPGNtoPIG.LOGFILE \n';
TxQ271='Konverter alle .PGN til .PIG';
TxQ272='     0 spil fra PIG fil:  \n\n  ';
TxQ273='  \n\ntilføjet til PGN fil:  \n\n  ';
TxQ274='Du skal have req.library placeret \ni libs: for at kunne bruge farve menuen!\n\nREQFILEREQUESTER tooltype er derfor OFF!';
TxQ275='Konvertering af .CBF (ChessBase spil-fil) til PGN format: \n\n';
TxQ276='\n\nfejlede!\n\nHar du nok fri plads i t: (5 gange .CBF størrelsen)?\nHar du cbascii konverterings programmet i dit path?\n';
TxQ277='(se F5)';
TxQ278='(se F2)';
TxQ279='(se F1)';
TxQ280='(ScrL: åbne PGN edit vindue)';
TxQ281='(NumL: åbne PGN info vindue)';
TxQ282='(se F8)';
TxQ283='(F10: se F0)';
TxQ284='(se F9)';
TxQ285='(se F4)';
TxQ286='(PrtSc: åbne teori vindue)';
TxQ287='(se F3)';
TxQ288='(se F6)';
TxQ289='(se F7)';
TxQ290='(SysRq: åbne tooltype setup vindue)';
TxQ291='Lave en turnerings tabel (M tast)';
TxQ292='ikke fundet (skal være i samme directory som PIGbase)';
TxQ293='ikke en pig fil';
TxQ294='ikke åbnet (hukommelse lav)';
TxQ295='tom';
TxQ296='gav nøgle: ';
TxQ297='Lav nøgle:\n\n';
TxQ298='\n  Tabel for stor at vise (maks. 24 personer)!  \n\n    Se filen "t:Table"';
TxQ299='  #  p  '; (* #=antal spil, p=total points *)
TxQ300='     1 spil\n     2 personer\n\n'+
       '  Laver turnerings tabel (til fil "t:Table")  \n'
TxQ301='  TrNr:';                        (* 301-311 =SkakTeori *)
TxQ302='Noder:';
TxQ303='S';
TxQ304='F';
TxQ305=' Teo=';
TxQ306='Vari=';
TxQ307=' Stat=';
TxQ308='- Ingen teori           \n';
TxQ309='TOTAL:  ';
TxQ310='BEDST:  ';
TxQ311='- Teori ender her -     \n';
TxQ312='ukendt fejl';
TxQ313='H';                     (* 313-324 SkakKey *)
TxQ314='S';
TxQ315='Remis værdi:  Statistik:';
TxQ316='Teori:  F3=Import';
TxQ317=' HENT ';
TxQ318=' GEM  ';
TxQ319='  NY  ';
TxQ320='Position';
TxQ321='SLETTE';
TxQ322='Spil:';
TxQ323='ANALYSER';
TxQ324='ADDER';
TxQ325='';
TxQ326='Hent teori ';                (* 326-336 Skak *)
TxQ327='    Henter...           \n';
TxQ328='Teori ikke (komplet) hentet!   ';
TxQ329='Gem teori  ';
TxQ330='    Gemmer...           \n';
TxQ331='Teori ikke (komplet) gemt!    ';
TxQ332='Spil ikke (komplet) adderet!';
TxQ333='    Søger...            \n';
TxQ334='    Genberegner...      \n';
TxQ335='adderet teori  ';
TxQ336='Spil ikke (komplet) adderet! ';
TxQ337='FLYTTE: Home,PgUp,up,down,PgDn,End taster\n'+
       'VÆLGE:  alle1 for at vælge alle i listen nu\n'+
       '        vin1 for at vælge alle i vinduet\n'+
       'SLETTE: Vend slet-markering på de valgte spil (X=slettet) \n'+
       'tilføj: Kopier/tilføj de valgte spil til en anden PIG fil\n'+
       '        (det er meget hurtigere at bruge append i filteret)';
TxQ338=' Omskifter '; (* in filter *)
TxQ339='';
TxQ340='';

TxTAG=TAGarr147{
  'Begivenhed','Sted','Dato','Runde','Hvid','Sort','Resultat',
  'HvidTitel','SortTitel','HvidElo','SortElo','HvidUSCF',
  'SortUSCF','NIC nøgle','Forfatter','Kilde','Info','TurneringDato',
  'TurneringSponsor','Sektion','Niveau','Bræt','Åbning','Variant',
  'BiVariant','ECO nøgle', 'Tidspunkt', 'HvidNation','SortNation',
  'Slettede','Med info','Tekst-tegn','Træk','  =  ','Drop:'};
TxNoHelp='Kun hjælpetekster her når LOCALE fil bruges.';

(*$ ENDIF *)

(*$ IF Engelsk *)
cTxFILTERDROPHENT='\n  Do you want to use the position on the\n'+
                    '  board as a filter when reading the game?  \n';
cTxOK= '  O K  ';
cTxMID='CANCEL';
cTxUPS=' OOPS! ';
cTxSti='Path';
cTxNavn='Name';
cTxUdvalgt='Chosen';
cTxOKAY='OH3KEY1';
cTxSKAKMAT='CHEH4K AEND MEY4T.';
cTxHVIDVANDT='WHAY4T WIH4NZ.';
cTxSORTVANDT='BLAE4K WIH4NZ.';
cTxREMIS='DRAO4.';
cTxHUMM='WHM';
cTxAHA='AX1/HAH2,';
cTxHVIDSTUR='WHAY4TS MUW,'; (* !!!!!!!!!!!!!!!!!!!!!!  white to move !!!!!! *)
cTxSORTSTUR='BLAE4KS MUW,';
cTxNAAH='NAH';
cTxENPASSANT='AANG PAXSAANG';
cTxROKADE='KAA2STULIHNX';
cTxPATREMIS='STAHEH4L MEY4T. DRAO4.';
cTxHAPS='/HAAPS';
cTxSKAK='CHEH4K';
cTxDENKANIKKERYKKES='IHT KAE4NT BIY MUW4VD.';
cTxGODDAG='/HEH6LOW6. REH3DIY TUW PLEY2 CHEH9S,';
cTxForkertTegnIStilling='Illegal char in position.';
cFxs01='done';
cFxs02='not done';
cFxs03='lock-error';
cFxs04='open-error';
cFxs05='read-error';
cFxs06='write-error';
cFxs07='seek-error';
cFxs08='memory error';
cFxs09='in use';
cFxs10='not found';
cFxs11='disc write-protected';
cFxs12='device not mounted';
cFxs13='disc full';
cFxs14='file is delete-protected';
cFxs15='file is write-protected';
cFxs16='disc is not a DOS disc';
cFxs17='no disc';
cFxs18='unknown problem';            
cTxGEMSPIL='Save Game/Problem';
cTxSKRIVSPIL='Write Game/Problem';
cTxIKKEGEMT='\n  N O T   s a v e d  !  \n\n';
cTxIKKEUDSKREVET='\n  N O T   w r i t t e n  !  \n\n';
cTxHENTSPIL='Load Game/Problem';
cTxLAESSPIL='Read Game/Problem from text';
cTxSPILIKKETEKST=' A Game/Problem file, not a text-file \n';
cTxLINIE='  Line ';
cTxPOSITION=', Position ';
cTxHALVTRAEK=', Half-move ';
cTxIKKEHENTET='\n  N O T   l o a d e d  !  \n\n';
cTxIKKESKAKFIL='not a correct chess-file';
cTxIKKESKAKTXT=' could not find (more) readable \n chess-text in the file.';
cTxUKORREKTKUNDELVIS='\n Breaked reading \n at unfittable move!\n\n Reading of evt. following game can be tried. \n(is tooltype INTERNATIONAL=ON ?)';
cTxSKAKSPISEBMREV='\n----- C H E S S, eat the king -----\n\n   (c) E.B.Madsen 1990/91 DK\n       Rev: ';
cTxDUVALGTEAT='\n\nYou choosed to ';
cTxFORLIDTRAMDROPTEKST='\n  not enough RAM !!!!!  \n  Drop the text ?  \n';
cAx01='Special-position (no black pieces). \nWhite will be able to move around!';
cAx02='Too many white pawns (max 8)';
cAx03='Too many black pawns (max 8)';
cAx04='The black king, but none of the rooks, has castling-right';
cAx05='The white king, but none of the rooks, has castling-right';
cAx06='A black rook, but not the king, has castling-right';
cAx07='A white rook, but not the king, has castling-right';
cAx08='no white king';
cAx09='no black king';
cAx10='More than 2 white rooks';
cAx11='More than 2 black rooks';
cAx12='More than 2 white knights';
cAx13='More than 2 black knights';
cAx14='More than 2 white bishops';   
cAx15='More than 2 black bishops';   
cAx16='More than 1 white queen';  
cAx17='More than 1 black queen';  
cTxKONTROLADVARSEL=' Check of position:  ---  C A U T I O N  --- \n';
cTxSTOP='\n\n        S  T  O  P     ?      \n\n';
cDemoMessage="---- Shareware-version!! #101 ----\n\n"+
              "Save/write, max strength, more than 80 moves,\n"+
              "and some other things is therefore turned off.\n\n"+
              "Buy the full program (newest version) for £40 ($70) at :\n"+
              "  Programmer E. B. Madsen\n"+
              "  Kastebjergvej 23\n"+
              "  2750 Ballerup, DK Denmark\n"+
              "to avoid this message and get about 80.000 new PIG games!";

tRYKKE='move ';
tPLACERE='place ';
t00='get help for the last used\nfunction. Select one and try again\n';
t01='turn-around the board\n';
t02='play for white\n';
t03='play for black\n';
t04='let me play for white\n';
t05='let me play for black\n';
t06='let me think fast\n';
t07='let me think normal\n';
t08='let me think best\n';
t09='load problem/game from disc\n';
t59='read problem/game from textfile on disc\n';
t10='save problem/game on a disc\n'; 
t60='write problem/game on printer/textfile\n'; 
t11='go to game-start\n'; 
t12='go a move back\n'; 
t13='go a move forward\n'; 
t14='go to game-end\n'; 
t15='turn-on speaker\n'; 
t16='turn-off speaker\n'; 
t17='change colours\n'; 
t18='start a new game\nSelect OK or abort with UPS!\n'; 
t19='let field power be shown\n'; 
t20='let field power not be shown\n'; 
t21='change the position\nWhen you are finished, Select OK or abort with UPS!\n'; 
t22='let white turn\n'; 
t23='let black turn\n'; 
t24='setup the start-position\n'; 
t25='empty the board\n'; 
t26='go back to original-position\n'; 
t27='Key in a comment to this\nposition. If it is the only change, the\n current game will be kept\n'; 
t28='a KING with castling-right\nIf it cannot be rescued, the game is lost\n'; 
t29='a KING without castling-right\nIf it cannot be rescued, the game is lost\n'; 
t30='a QUEEN\nThey are worth around 8 to 9 pawns\n'; 
t31='a ROOK with castling-right\nThey are worth around 4 to 5 pawns\n'; 
t32='a ROOK without castling-right\nThey are  worth around 4 to 5 pawns\n'; 
t33='a BISHOP\nThey are worth around 3 pawns\n'; 
t34='a KNIGHT\nThey are worth around 3 pawns\n'; 
t35='a PAWN who may taken by\nen-passant. (take a pawn that\njust passed by going two forward\n';
t36='a PAWN\nThey can convert to QUEENS when\nthey are moved to the last row\n';                    
t37='an empty field\n';
t38='move around the pieces\n';
t39='stop the game, but aborted\n';
t40='go back to the game\n'; 
t41='start a new game\n';
t42='save/load problem/game will go on disc'; 
t43='save/load will write problem/game to printer\n(write/read problem/game on disc)';
t44='44\n';                                                                              

cTASTBESKRIVELSE="  K E Y - I N    D E S C R I P T I O N  ";
cLAERSKAK="PIGbase4 with LEARN CHESS "+cVersion+"  (c) EBM dk";

TxrU='t';
TxtU='r';
TxsU='n';
TxlU='b';
TxdU='q';
TxmU='m';
TxkU='k';
TxeU='e';
TxbU='p';
TxRU='T';
TxTU='R';
TxSU='N';
TxLU='B';
TxDU='Q';
TxMU='M';
TxKU='K';
TxEU='E';
TxBU='P';

TxQ83 ='It is a PIG-BASE file, use the keys:\n\n'+
       '  F1 = Select PIG-BASE games and load\n'+
       '  F2 = Load from selected games\n';
TxQ84 ='\n  No more games in the PIG-BASE  \n';
TxQ85 ='Select a PIG-BASE file:';
TxQ86 ='Append game to PIG-BASE file:';
TxQ87 =' orig.';
TxQ88 =' clear';
TxQ89 ='  PGN ';
TxQ90 ='append';
TxQ91 ='Match Variant';
TxQ92 ='FILTER';
TxQ93 ='PGN INFORMATION TAG';
TxQ94 =' ALL0 ';
TxQ95 =' ALL1 ';
TxQ96 =' WIN0 ';
TxQ97 =' WIN1 ';
TxQ201=' Select from the list...';
TxQ202=' Alloc: I want memory! \n  Please free some if possible.';
TxQ203=' games read from   : ';
TxQ204=' games appended to : ';
TxQ205='\n Game marked as deleted in PIG file: \n\n ';
TxQ206='\n Press F7 now to undelete again\n';
TxQ207='\n Game undeleted in PIG file: \n\n ';
TxQ208='NO LIST !!!  first use F1 to Select PIG-BASE games';
TxQ209='READING LIST, read: ';
TxQ210=
'\n  F1  = Select PIG-BASE games and load'+
'\n  F2  = Load from selected games'+
'\n (F3  = Select and append games to a PIG file) '+
'\n  F4  = Convert all PGN (CBF) files to PIG files'+
'\n  F5  = Save/append game to a PIG file'+
'\n (F6  = Mark game as deleted in PIG file)'+
'\n (F7  = Mark game as undeleted in PIG file)'+
'\n  F8  = Append a PIG file to a PIG file'+
'\n  F9  = Convert a PGN (CBF) file to a PIG file'+
'\n  F0  = Convert a PIG file to a PGN file'+
'\n NumL = Show (ScrL=edit) PGN INFOs (TAGS)'+
'\n Enter= Edit comments to current position'+
'\n Esc  = Break       TO MOVE IN A GAME: '+
'\n Home, Up(10), PgUp(4), Lt, Rt PgDn, Dn, End '+
'\n OTHER: M=MakeTable, N/E/K=NIC/ECO/BOTH keys';
TxQ211=' games from '; (* (skak.kopi20),PGNtilPIG, autoPGNtilPIG, PIGtilPGN, PIGtilPIG *)
TxQ212=' file: ';
TxQ213='append to ';
TxQ214='Changes made to the game in: \n\n';(* fri?*)
TxQ215='  Comments\n';
TxQ216='  PGN infos\n';
TxQ217='  Moves\n';(* fri?*)
TxQ218='\n is it OK to skip the game?\n';(* fri?*)
TxQ219=' of the games could not be converted completely!';
TxQ220='\nOK to toggle the delete-mark on the\nselected games ?\n';
TxQ221='Gives help to the last activated function in filter';

TxQ262='Start/stop  analyze (keep the game while)';
TxQ263='Make Analyze to Game (and forget rest of game)';
TxQ264='Return (store the analyze as comment to game).';
TxQ265='\n WARNING! File already exists, OK to write ? \n';
TxQ266='Mark some games in the list first!';
TxQ267='     1 games from PGN file:  \n\n  ';
TxQ268='  \n\nappended to PIG-BASE file:  \n\n  ';
TxQ269=' PGN files converted to PIG files.  \n\n';
TxQ270=' See the details in t:AutoPGNtoPIG.LOGFILE \n';
TxQ271='Convert all .PGN to .PIG';
TxQ272='     0 games from PIG file:  \n\n  ';
TxQ273='  \n\nappended to PGN file:  \n\n  ';
TxQ274='You needs the file req.library placed \nin libs: to get the color requester!\n\nThe REQFILEREQUESTER tooltype option is OFF too!';
TxQ275='Conversion of .CBF (ChessBase gamefile) to PGN format: \n\n';
TxQ276='\n\nfailed!\n\nDo you have enough free space in t: (5 times the .CBF size)?\nDo you have the cbascii conversion utility in your path?\n';
TxQ277='(see F5)';
TxQ278='(see F2)';
TxQ279='(see F1)';
TxQ280='(ScrL: open PGN edit window)';
TxQ281='(NumL: open PGN info window)';
TxQ282='(see F8)';
TxQ283='(F10: see F0)';
TxQ284='(see F9)';
TxQ285='(see F4)';
TxQ286='(PrtSc: open theory window)';
TxQ287='(see F3)';
TxQ288='(see F6)';
TxQ289='(see F7)';
TxQ290='(SysRq: open tooltypes setup window)';
TxQ291='Make a tournament table (key M)';
TxQ292='not found (has to be in the same directory as PIGbase)';
TxQ293='not a pig file';
TxQ294='not opened (memory low)';
TxQ295='empty';
TxQ296='gave key: ';
TxQ297='Create key:\n\n';
TxQ298='\n  Table too big to show (max 24 persons)!  \n\n    See the file "t:Table"';
TxQ299='  #  p  '; (* #=count of games, p=total points *)
TxQ300='     1 games\n     2 persons\n\n'+
       '  Making tournament table (to file "t:Table")  \n';
TxQ301='  MvNr:';                        (* 301-311 =SkakTeori *)
TxQ302='Nodes:';
TxQ303='T';
TxQ304='F';
TxQ305=' Teo=';
TxQ306='Vari=';
TxQ307=' Stat=';
TxQ308='- No theory -           \n';
TxQ309='TOTAL:  ';
TxQ310='BEST:   ';
TxQ311='- End of theory -       \n';
TxQ312='unknown error';
TxQ313='W';                     (* 313-324 SkakKey *)
TxQ314='B';
TxQ315='Draw values:  Statistic:';
TxQ316='Theory: F3=Import';
TxQ317=' LOAD ';
TxQ318=' SAVE ';
TxQ319=' NEW  ';
TxQ320='Position';
TxQ321='DELETE';
TxQ322='Game:';
TxQ323='ANALYZE ';
TxQ324=' ADD ';
TxQ325='';
TxQ326='Load theory';                (* 326-336 Skak *)
TxQ327='    Loading...          \n';
TxQ328='Theory not (completely) loaded!';
TxQ329='Save theory';
TxQ330='    Saving...           \n';
TxQ331='Theory not (completely) saved!';
TxQ332='Game not (completely) added!';
TxQ333='    Searching...        \n';
TxQ334='    Recalculating...    \n';
TxQ335='added to theory';
TxQ336='Games not (completely) added!';
TxQ337='MOVING: Home,PgUp,up,down,PgDn,End keys\n'+
       'SELECT: all1 to select all current in the list\n'+
       '        win1 to select all visible in window\n'+
       'DELETE: Delete-mark toggle the selected games (X=Deleted) \n'+
       'append: Copy the selected games to another PIG file\n'+
       '        (it is much faster to use append in the filter)';
TxQ338='      Bool '; (* in filter *)
TxQ339='';
TxQ340='';

TxTAG=TAGarr147{
  'Event','Site','Date','Round','White','Black','Result',
  'WhiteTitle','BlackTitle','WhiteElo','BlackElo','WhiteUSCF',
  'BlackUSCF','NIC key','Annotator','Source','Info','EventDate',
  'EventSponsor','Section','Stage','Board','Opening','Variation',
  'SubVariation','ECO key','Time','WhiteCountry','BlackCountry',
  'Deleted','With info','TextChars','Moves','  =  ','Skip:'};
TxNoHelp='Only helptexts here when LOCALE file is used.';

(*$ ENDIF *)

PROCEDURE AddHelp(VAR st:HelpSt; HelpNr,Valg:CARDINAL);
BEGIN
  IF (HelpNr>27) & (HelpNr<38) THEN
    IF (Valg>0) & (Valg<189) THEN
      Copy(st,Q[RYKKE]^);
    ELSE
      Copy(st,Q[PLACERE]^);
    END;
  END;
  CASE HelpNr OF (* 'Du valgte at ' 0..44,59..60 *)
  | 0..9   : Copy(st,Q[T00+HelpNr]^);
  | 10     : Copy(st,Q[T10]^);
  | 11..44 : Copy(st,Q[T00+HelpNr+2]^);
  | 59     : Copy(st,Q[T59]^);
  | 60     : Copy(st,Q[T60]^);
(*  |  0 : Copy(st,Q[T00]^);
    |  1 : Copy(st,Q[T01]^);
    |  2 : Copy(st,Q[T02]^);
    |  3 : Copy(st,Q[T03]^);
    |  4 : Copy(st,Q[T04]^);
    |  5 : Copy(st,Q[T05]^);
    |  6 : Copy(st,Q[T06]^);
    |  7 : Copy(st,Q[T07]^);
    |  8 : Copy(st,Q[T08]^);
    |  9 : Copy(st,Q[T09]^);
    | 10 : Copy(st,Q[T10]^);
    | 11 : Copy(st,Q[T11]^);
    | 12 : Copy(st,Q[T12]^);
    | 13 : Copy(st,Q[T13]^);
    | 14 : Copy(st,Q[T14]^);
    | 15 : Copy(st,Q[T15]^);
    | 16 : Copy(st,Q[T16]^);
    | 17 : Copy(st,Q[T17]^);
    | 18 : Copy(st,Q[T18]^);
    | 19 : Copy(st,Q[T19]^);
    | 20 : Copy(st,Q[T20]^);
    | 21 : Copy(st,Q[T21]^);
    | 22 : Copy(st,Q[T22]^);
    | 23 : Copy(st,Q[T23]^);
    | 24 : Copy(st,Q[T24]^);
    | 25 : Copy(st,Q[T25]^);
    | 26 : Copy(st,Q[T26]^);
    | 27 : Copy(st,Q[T27]^);
    | 28 : Concat(st,Q[T28]^);
    | 29 : Concat(st,Q[T29]^);
    | 30 : Concat(st,Q[T30]^);
    | 31 : Concat(st,Q[T31]^);
    | 32 : Concat(st,Q[T32]^);
    | 33 : Concat(st,Q[T33]^);
    | 34 : Concat(st,Q[T34]^);
    | 35 : Concat(st,Q[T35]^);
    | 36 : Concat(st,Q[T36]^);
    | 37 : Concat(st,Q[T37]^);
    | 38 : Copy(st,Q[T38]^);
    | 39 : Copy(st,Q[T39]^);
    | 40 : Copy(st,Q[T40]^);
    | 41 : Copy(st,Q[T41]^);
    | 42 : Copy(st,Q[T42]^);
    | 43 : Copy(st,Q[T43]^); 
    | 44 : Copy(st,Q[T44]^);
    | 59 : Copy(st,Q[T59]^);
    | 60 : Copy(st,Q[T60]^); *)
    (* 59,60 used *)
  ELSE
    IF Q[HelpNr]<>NIL THEN 
      Copy(st,Q[HelpNr]^);
    END;
  END; 
END AddHelp;

PROCEDURE ReadLocaleFile;
VAR
  n,m:INTEGER;
  filnavn:ARRAY[0..32] OF CHAR;
  st:ARRAY[0..4096] OF CHAR;
  lfil:File;
  ch:CHAR;
  n2:INTEGER;
  oldm:ADDRESS;
  lstr:LONGINT;
BEGIN
  Copy(filnavn,NoLocale);
(*$IF Test *)
  WRITELN(s('ReadLocaleFile "')+s(filnavn)+s('"'));
(*$ENDIF *)
  IF filnavn[0]<>0C THEN 
    Lookup(lfil,filnavn,4096,FALSE);
    m:=0;
(*$IF Test *)
  WRITELN(s('LU'));
(*$ENDIF *)
    IF lfil.res=done THEN
      WHILE ~lfil.eof & (lfil.res=done) & (m<=MaxTxts) DO
        (* læs til ikke tom ikke-kommentar linie er indlæst *)
        REPEAT

(*        n2:=0;
          ch:=0C;
          WHILE ~lfil.eof & (lfil.res=done) & (ch<>12C) & (n2<SIZE(st)) DO
            ReadChar(lfil,ch);
            st[n2]:=ch;
            INC(n2);
          END;
          WHILE (n2>0) & (st[n2-1]<' ') DO
            DEC(n2);
          END;
          st[n2]:=0C; *)

          ReadString(lfil,st);
(*$IF Test *)
  WRITELN(s(st));
(*$ENDIF *)
        UNTIL lfil.eof OR (lfil.res#done) OR (st[0]#';') & (st[0]#0C);
        (* konverter \ til linefeed: *)
        n:=0;
        WHILE (n<SIZE(st)) & (st[n]<>0C) DO
          IF st[n]='\\' THEN
            st[n]:=12C;
          END;
          INC(n);
        END;
        
        IF (lfil.res=done) & ~lfil.eof & (m#DemoMessage) & (m#LAERSKAK) & (st[0]<>':') THEN
          lstr:=Length(st);
          IF (lstr>0) & ((m<>PIECES) OR (lstr>17)) THEN
            oldm:=Q[m];
            Q[m]:=NIL;
            Allocate(Q[m],lstr+1);
            IF Q[m]<>NIL THEN
(*$IF Test *)
  WRITELN(s('A: ')+s(st));
(*$ENDIF *)
              (* Copy(Q[m]^,st);*)
              FOR n:=0 TO lstr-1 DO
                Q[m]^[n]:=st[n];
              END;
              Q[m]^[lstr]:=0C;

              IF m=PIECES THEN
                Txr:=Q[PIECES]^[0];
                Txt:=Q[PIECES]^[1];
                Txs:=Q[PIECES]^[2];
                Txl:=Q[PIECES]^[3];
                Txd:=Q[PIECES]^[4];
                Txm:=Q[PIECES]^[5];
                Txk:=Q[PIECES]^[6];
                Txe:=Q[PIECES]^[7];
                Txb:=Q[PIECES]^[8];
                TxR:=Q[PIECES]^[9];
                TxT:=Q[PIECES]^[10];
                TxS:=Q[PIECES]^[11];
                TxL:=Q[PIECES]^[12];
                TxD:=Q[PIECES]^[13];
                TxM:=Q[PIECES]^[14];
                TxK:=Q[PIECES]^[15];
                TxE:=Q[PIECES]^[16];
                TxB:=Q[PIECES]^[17];
              END;
            ELSE
              Q[m]:=oldm;
            END;
          END;
  (*$IF Test *)
    WRITELN(s('m=')+l(m)+s(' st=')+s(st));
    IF (m=210) & (Q[m]<>NIL) THEN
      WRITELN(s('ReadQ210="')+s(Q[m]^)+s('"'));
    END;
  (*$ENDIF *)
        END;
        INC(m);
      END;
      Close(lfil);
(*$IF Test *)
  WRITELN(s('CLOSED. ')+s(st));
(*$ENDIF *)
    END;
  END;
END ReadLocaleFile;

PROCEDURE InitSprog(Future:INTEGER):BOOLEAN;
BEGIN
  ReadLocaleFile;
  RETURN(TRUE);
END InitSprog;

VAR
  PIECESTR:ARRAY[0..19] OF CHAR;

PROCEDURE Init;
VAR
  n:INTEGER;
BEGIN
  FOR n:=0 TO MaxTxts DO
    Q[n]:=NIL;
  END;
(* Brikbetegnelserne ved visning (tekst udprint,indlæs) *)
  Txr:=TxrU;
  Txt:=TxtU;
  Txs:=TxsU;
  Txl:=TxlU;
  Txd:=TxdU;
  Txm:=TxmU;
  Txk:=TxkU;
  Txe:=TxeU;
  Txb:=TxbU;
  TxR:=TxRU;
  TxT:=TxTU;
  TxS:=TxSU;
  TxL:=TxLU;
  TxD:=TxDU;
  TxM:=TxMU;
  TxK:=TxKU;
  TxE:=TxEU;
  TxB:=TxBU;

  Q[DemoMessage]:=ADR(cDemoMessage);
  Q[LAERSKAK]:=ADR(cLAERSKAK);

  Q[TxFILTERDROPHENT]:=ADR(cTxFILTERDROPHENT); 
  Q[TxOK]:=ADR(cTxOK); 
  Q[TxMID]:=ADR(cTxMID); 
  Q[TxUPS]:=ADR(cTxUPS); 
  Q[TxSti]:=ADR(cTxSti); 
  Q[TxNavn]:=ADR(cTxNavn); 
  Q[TxUdvalgt]:=ADR(cTxUdvalgt); 
  Q[TxOKAY]:=ADR(cTxOKAY); 
  Q[TxSKAKMAT]:=ADR(cTxSKAKMAT); 
  Q[TxHVIDVANDT]:=ADR(cTxHVIDVANDT); 
  Q[TxSORTVANDT]:=ADR(cTxSORTVANDT); 
  Q[TxREMIS]:=ADR(cTxREMIS); 
  Q[TxHUMM]:=ADR(cTxHUMM); 
  Q[TxAHA]:=ADR(cTxAHA); 
  Q[TxHVIDSTUR]:=ADR(cTxHVIDSTUR); 
  Q[TxSORTSTUR]:=ADR(cTxSORTSTUR); 
  Q[TxNAAH]:=ADR(cTxNAAH); 
  Q[TxENPASSANT]:=ADR(cTxENPASSANT); 
  Q[TxROKADE]:=ADR(cTxROKADE); 
  Q[TxPATREMIS]:=ADR(cTxPATREMIS); 
  Q[TxHAPS]:=ADR(cTxHAPS); 
  Q[TxSKAK]:=ADR(cTxSKAK); 
  Q[TxDENKANIKKERYKKES]:=ADR(cTxDENKANIKKERYKKES); 
  Q[TxGODDAG]:=ADR(cTxGODDAG); 
  Q[TxForkertTegnIStilling]:=ADR(cTxForkertTegnIStilling); 
  Q[Fxs01]:=ADR(cFxs01); 
  Q[Fxs02]:=ADR(cFxs02); 
  Q[Fxs03]:=ADR(cFxs03); 
  Q[Fxs04]:=ADR(cFxs04); 
  Q[Fxs05]:=ADR(cFxs05); 
  Q[Fxs06]:=ADR(cFxs06); 
  Q[Fxs07]:=ADR(cFxs07); 
  Q[Fxs08]:=ADR(cFxs08); 
  Q[Fxs09]:=ADR(cFxs09); 
  Q[Fxs10]:=ADR(cFxs10); 
  Q[Fxs11]:=ADR(cFxs11); 
  Q[Fxs12]:=ADR(cFxs12); 
  Q[Fxs13]:=ADR(cFxs13); 
  Q[Fxs14]:=ADR(cFxs14); 
  Q[Fxs15]:=ADR(cFxs15); 
  Q[Fxs16]:=ADR(cFxs16); 
  Q[Fxs17]:=ADR(cFxs17); 
  Q[Fxs18]:=ADR(cFxs18); 
  Q[TxGEMSPIL]:=ADR(cTxGEMSPIL); 
  Q[TxSKRIVSPIL]:=ADR(cTxSKRIVSPIL); 
  Q[TxIKKEGEMT]:=ADR(cTxIKKEGEMT); 
  Q[TxIKKEUDSKREVET]:=ADR(cTxIKKEUDSKREVET); 
  Q[TxHENTSPIL]:=ADR(cTxHENTSPIL); 
  Q[TxLAESSPIL]:=ADR(cTxLAESSPIL); 
  Q[TxSPILIKKETEKST]:=ADR(cTxSPILIKKETEKST); 
  Q[TxLINIE]:=ADR(cTxLINIE); 
  Q[TxPOSITION]:=ADR(cTxPOSITION); 
  Q[TxHALVTRAEK]:=ADR(cTxHALVTRAEK); 
  Q[TxIKKEHENTET]:=ADR(cTxIKKEHENTET); 
  Q[TxIKKESKAKFIL]:=ADR(cTxIKKESKAKFIL); 
  Q[TxIKKESKAKTXT]:=ADR(cTxIKKESKAKTXT); 
  Q[TxUKORREKTKUNDELVIS]:=ADR(cTxUKORREKTKUNDELVIS); 
  Q[TxSKAKSPISEBMREV]:=ADR(cTxSKAKSPISEBMREV); 
  Q[TxDUVALGTEAT]:=ADR(cTxDUVALGTEAT); 
  Q[TxFORLIDTRAMDROPTEKST]:=ADR(cTxFORLIDTRAMDROPTEKST); 
  Q[Ax01]:=ADR(cAx01); 
  Q[Ax02]:=ADR(cAx02); 
  Q[Ax03]:=ADR(cAx03); 
  Q[Ax04]:=ADR(cAx04); 
  Q[Ax05]:=ADR(cAx05); 
  Q[Ax06]:=ADR(cAx06); 
  Q[Ax07]:=ADR(cAx07); 
  Q[Ax08]:=ADR(cAx08); 
  Q[Ax09]:=ADR(cAx09); 
  Q[Ax10]:=ADR(cAx10); 
  Q[Ax11]:=ADR(cAx11); 
  Q[Ax12]:=ADR(cAx12); 
  Q[Ax13]:=ADR(cAx13); 
  Q[Ax14]:=ADR(cAx14); 
  Q[Ax15]:=ADR(cAx15); 
  Q[Ax16]:=ADR(cAx16); 
  Q[Ax17]:=ADR(cAx17); 
  Q[TxKONTROLADVARSEL]:=ADR(cTxKONTROLADVARSEL); 
  Q[TxSTOP]:=ADR(cTxSTOP); 
  Q[TASTBESKRIVELSE]:=ADR(cTASTBESKRIVELSE); 

  Q[PIECES]:=ADR(PIECESTR);
  PIECESTR[0]:=Txr;
  PIECESTR[1]:=Txt;
  PIECESTR[2]:=Txs;
  PIECESTR[3]:=Txl;
  PIECESTR[4]:=Txd;
  PIECESTR[5]:=Txm;
  PIECESTR[6]:=Txk;
  PIECESTR[7]:=Txe;
  PIECESTR[8]:=Txb;
  PIECESTR[9]:=TxR;
  PIECESTR[10]:=TxT;
  PIECESTR[11]:=TxS;
  PIECESTR[12]:=TxL;
  PIECESTR[13]:=TxD;
  PIECESTR[14]:=TxM;
  PIECESTR[15]:=TxK;
  PIECESTR[16]:=TxE;
  PIECESTR[17]:=TxB;
  PIECESTR[18]:=0C;

  Q[RYKKE]:=ADR(tRYKKE); 
  Q[PLACERE]:=ADR(tPLACERE); 
  Q[T00]:=ADR(t00); 
  Q[T01]:=ADR(t01); 
  Q[T02]:=ADR(t02); 
  Q[T03]:=ADR(t03); 
  Q[T04]:=ADR(t04); 
  Q[T05]:=ADR(t05); 
  Q[T06]:=ADR(t06); 
  Q[T07]:=ADR(t07); 
  Q[T08]:=ADR(t08); 
  Q[T09]:=ADR(t09); 
  Q[T59]:=ADR(t59); 
  Q[T10]:=ADR(t10); 
  Q[T60]:=ADR(t60); 
  Q[T11]:=ADR(t11); 
  Q[T12]:=ADR(t12); 
  Q[T13]:=ADR(t13); 
  Q[T14]:=ADR(t14); 
  Q[T15]:=ADR(t15); 
  Q[T16]:=ADR(t16); 
  Q[T17]:=ADR(t17); 
  Q[T18]:=ADR(t18); 
  Q[T19]:=ADR(t19); 
  Q[T20]:=ADR(t20); 
  Q[T21]:=ADR(t21); 
  Q[T22]:=ADR(t22); 
  Q[T23]:=ADR(t23); 
  Q[T24]:=ADR(t24); 
  Q[T25]:=ADR(t25); 
  Q[T26]:=ADR(t26); 
  Q[T27]:=ADR(t27); 
  Q[T28]:=ADR(t28); 
  Q[T29]:=ADR(t29); 
  Q[T30]:=ADR(t30); 
  Q[T31]:=ADR(t31); 
  Q[T32]:=ADR(t32); 
  Q[T33]:=ADR(t33); 
  Q[T34]:=ADR(t34); 
  Q[T35]:=ADR(t35); 
  Q[T36]:=ADR(t36); 
  Q[T37]:=ADR(t37); 
  Q[T38]:=ADR(t38); 
  Q[T39]:=ADR(t39); 
  Q[T40]:=ADR(t40); 
  Q[T41]:=ADR(t41); 
  Q[T42]:=ADR(t42); 
  Q[T43]:=ADR(t43); 
  Q[T44]:=ADR(t44); 

  Q[Qisapigfile]:=ADR(TxQ83); 
  Q[Qnomoregamesinpig]:=ADR(TxQ84); 
  Q[Qgetfirstgameinpig]:=ADR(TxQ85); 
  Q[Qappendgametopig]:=ADR(TxQ86); 

  Q[Qoriginal]:=ADR(TxQ87); 
  Q[Qclear]:=ADR(TxQ88); 
  Q[Qpgn]:=ADR(TxQ89); 
  Q[Qspg]:=ADR(TxQ90); 
  Q[Qor]:=ADR(TxQ91); 
  Q[Qtitlefilter]:=ADR(TxQ92); 
  Q[Qtitlepgninfo]:=ADR(TxQ93); 
  Q[Qall0]:=ADR(TxQ94); 
  Q[Qall1]:=ADR(TxQ95); 
  Q[Qwin0]:=ADR(TxQ96); 
  Q[Qwin1]:=ADR(TxQ97); 
  Q[Qtitlepick]:=ADR(TxQ201); 
  Q[Qwantmemory]:=ADR(TxQ202); 
  Q[Qgamesread]:=ADR(TxQ203); 
  Q[Qgamesappended]:=ADR(TxQ204); 
  Q[Qgamedeleted]:=ADR(TxQ205); 
  Q[Qf7toundelete]:=ADR(TxQ206); 
  Q[Qgameundeleted]:=ADR(TxQ207); 
  Q[Qnotext]:=ADR(TxQ208); 
  Q[Qreadinglist]:=ADR(TxQ209); 
  Q[Qkeyshelp]:=ADR(TxQ210);

  Q[Q211]:=ADR(TxQ211); 
  Q[Q212]:=ADR(TxQ212); 
  Q[Q213]:=ADR(TxQ213); 
  Q[Q214]:=ADR(TxQ214); 
  Q[Q215]:=ADR(TxQ215); 
  Q[Q216]:=ADR(TxQ216); 
  Q[Q217]:=ADR(TxQ217); 
  Q[Q218]:=ADR(TxQ218); 
  Q[Q219]:=ADR(TxQ219); 
  Q[Q220]:=ADR(TxQ220); 
  Q[QFilterHelp]:=ADR(TxQ221); 


  FOR n:=147 TO 181 DO
    Q[n]:=ADR(TxTAG[n]);
  END;

  Q[262]:=ADR(TxQ262); 
  Q[263]:=ADR(TxQ263); 
  Q[264]:=ADR(TxQ264); 
  Q[265]:=ADR(TxQ265); 
  Q[266]:=ADR(TxQ266); 
  Q[267]:=ADR(TxQ267); 
  Q[268]:=ADR(TxQ268); 
  Q[269]:=ADR(TxQ269); 
  Q[270]:=ADR(TxQ270); 
  Q[271]:=ADR(TxQ271); 
  Q[272]:=ADR(TxQ272); 
  Q[273]:=ADR(TxQ273); 
  Q[274]:=ADR(TxQ274); 
  Q[275]:=ADR(TxQ275); 
  Q[276]:=ADR(TxQ276); 
  Q[277]:=ADR(TxQ277); 
  Q[278]:=ADR(TxQ278); 
  Q[279]:=ADR(TxQ279); 
  Q[280]:=ADR(TxQ280); 
  Q[281]:=ADR(TxQ281); 
  Q[282]:=ADR(TxQ282); 
  Q[283]:=ADR(TxQ283); 
  Q[284]:=ADR(TxQ284); 
  Q[285]:=ADR(TxQ285); 
  Q[286]:=ADR(TxQ286); 
  Q[287]:=ADR(TxQ287); 
  Q[288]:=ADR(TxQ288); 
  Q[289]:=ADR(TxQ289); 
  Q[290]:=ADR(TxQ290); 
  Q[291]:=ADR(TxQ291); 
  Q[292]:=ADR(TxQ292); 
  Q[293]:=ADR(TxQ293); 
  Q[294]:=ADR(TxQ294); 
  Q[295]:=ADR(TxQ295); 
  Q[296]:=ADR(TxQ296); 
  Q[297]:=ADR(TxQ297); 
  Q[298]:=ADR(TxQ298); 
  Q[299]:=ADR(TxQ299); 
  Q[300]:=ADR(TxQ300); 
  Q[301]:=ADR(TxQ301); 
  Q[302]:=ADR(TxQ302); 
  Q[303]:=ADR(TxQ303); 
  Q[304]:=ADR(TxQ304); 
  Q[305]:=ADR(TxQ305); 
  Q[306]:=ADR(TxQ306); 
  Q[307]:=ADR(TxQ307); 
  Q[308]:=ADR(TxQ308); 
  Q[309]:=ADR(TxQ309); 
  Q[310]:=ADR(TxQ310); 
  Q[311]:=ADR(TxQ311); 
  Q[312]:=ADR(TxQ312); 
  Q[313]:=ADR(TxQ313); 
  Q[314]:=ADR(TxQ314); 
  Q[315]:=ADR(TxQ315); 
  Q[316]:=ADR(TxQ316); 
  Q[317]:=ADR(TxQ317); 
  Q[318]:=ADR(TxQ318); 
  Q[319]:=ADR(TxQ319); 
  Q[320]:=ADR(TxQ320); 
  Q[321]:=ADR(TxQ321); 
  Q[322]:=ADR(TxQ322); 
  Q[323]:=ADR(TxQ323); 
  Q[324]:=ADR(TxQ324); 
  Q[325]:=ADR(TxQ325); 
  Q[326]:=ADR(TxQ326); 
  Q[327]:=ADR(TxQ327); 
  Q[328]:=ADR(TxQ328); 
  Q[329]:=ADR(TxQ329); 
  Q[330]:=ADR(TxQ330); 
  Q[331]:=ADR(TxQ331); 
  Q[332]:=ADR(TxQ332); 
  Q[333]:=ADR(TxQ333); 
  Q[334]:=ADR(TxQ334); 
  Q[335]:=ADR(TxQ335); 
  Q[336]:=ADR(TxQ336); 
  Q[337]:=ADR(TxQ337); 
  Q[338]:=ADR(TxQ338); 
  Q[339]:=ADR(TxQ339); 
  Q[340]:=ADR(TxQ340); 

  FOR n:=QFilterHelp+1 TO QFilterHelp+40 DO (* 222-261 (før 256) *)
    Q[n]:=ADR(TxNoHelp);
  END;
(*
  Allocate(Q[],SIZE(c)+1);
  Q[]^:=c;
*)

(*
filnavn:='LOCALE.ud';
Lookup(lfil,filnavn,2048,TRUE);
*)

  FOR n:=0 TO MaxTxts DO
    IF Q[n]=NIL THEN
      Q[n]:=ADR('NoText');
    END;

(*
Copy(st,Q[n]^);
m:=0;
WHILE st[m]<>0C DO
  IF st[m]=12C THEN
    st[m]:='\\';
  END;
  INC(m);
END;
WriteString(lfil,st);
*)

  END;

(*
Close(lfil);
*)
END Init;

BEGIN
(*$IF Test *)
  WRITELN(s('SkakSprog.1'));
(*$ENDIF *)
  LogVersion("SkakSprog.def",SkakSprogDefCompilation);
  LogVersion("SkakSprog.mod",SkakSprogModCompilation);
  Copy(Rev,RevDate);

  Init;
  (* InitSprog is initiated later by Skak(Screen) (because tooltypes binding)
     so don't use SkakSprog in inits in child modules to SkakScreen! 
  *)


(*$IF Test *)
  WRITELN(s('SkakSprog.2'));
(*$ENDIF *)
END SkakSprog.
