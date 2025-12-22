program StarFight;

 { 
 *	Copyright (C) Virtual Worlds Productions & Oxygenic
 *  http://www.VirtualWorlds.de
 *
 *  IT 2 is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *   
 *  IT 2 is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *   
 *  You should have received a copy of the GNU General Public License
 *  along with GNU Make; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA. 
 *
 }


USES Intuition,Graphics;

{$incl "intuition/intuitionbase.h","AGA.lib","libraries/dos.h",
       "libraries/dosextens.h","libraries/diskfont.h","soundplay.mod",
       "exec/memory.h","medplayer.lib"}

const FLAG_UNKNOWN=$0;
const FLAG_KNOWN=$80;
const FLAG_TERRA=20;
const FLAG_KLEGAN=8;
const FLAG_REMALO=96;
const FLAG_CARDAC=10;
const FLAG_FERAGI=67;
const FLAG_BAROJA=11;
const FLAG_VOLKAN=27;
const FLAG_OTHER=1;
const FLAG_MAQUES=12;
const FLAG_CIV_MASK=(FLAG_TERRA  or FLAG_KLEGAN or FLAG_REMALO or FLAG_CARDAC
                  or FLAG_FERAGI or FLAG_BAROJA or FLAG_VOLKAN or FLAG_OTHER
                  or FLAG_MAQUES);
const WFLAG_CEBORC=2;
const WFLAG_DCON=3;
const WFLAG_FIELD=4;
const WFLAG_JAHADR=5;


MASK_LTRUPPS=$0F;
MASK_SIEDLER=$F0;

const RDELAY=1;
const LOGOSIZE=14500;

const PAUSE=85;
const GFLAG_EXPLORE=1;
const GFLAG_ATTACK=2;

const SHIPFLAG_NONE=0;
const SHIPFLAG_WATER=1;

const LEVEL_DIED=0;
const LEVEL_UNKNOWN=1;
const LEVEL_PEACE=2;
const LEVEL_WAR=3;
const LEVEL_ALLIANZ=4;
const LEVEL_NO_ALLIANZ=5;
const LEVEL_COLDWAR=6;

const TYPE_PLANET=2;
const TYPE_SHIP=4;
const TYPE_STARGATE=16;
const TYPE_WORMHOLE=32;

const SHIPTYPE_FLEET=200;

const CLASS_DESERT=   5;  {D};
const CLASS_HALFEARTH=4;  {H};
const CLASS_EARTH=    6;  {M};
const CLASS_SATURN=   3;  {S};
const CLASS_GAS=      1;  {G};
const CLASS_ICE=      8;  {I};
const CLASS_PHANTOM=  7;  {P};
const CLASS_STONES=   0;  {T};
const CLASS_WATER=    2;  {W};

const WEAPON_GUN=1;
const WEAPON_LASER=3;
const WEAPON_PHASER=5;
const WEAPON_DISRUPTOR=7;
const WEAPON_PTORPEDO=9;

const MODE_REFRESH = 0;
const MODE_REDRAW  = 1;
const MODE_FLEET   = 2;
const MODE_STARGATE= 3;
const MODE_ONCE    = 4;
const MODE_ALL     = 5;
const MODE_OFFENSIV= 8;
const MODE_DEFENSIV= 9;
const MODE_SHIPS   =10;
const MODE_TERRITORIUM=11;
const MODE_BELEIDIGUNG=12;
const MODE_MONEY   =13;
const MODE_FORCE   =14;

const STATE_ALL_OCC=1;
const STATE_ENEMY=2;
const STATE_TACTICAL=3;

const SCREEN_PLANET=1;
const SCREEN_INVENTION=2;
const SCREEN_HISCORE=3;
const SCREEN_TECH=4;

const TARGET_POSITION=127;
const TARGET_STARGATE=26;
const TARGET_ENEMY_SHIP=126;

const INFLATION=1.03;
const MODULES=4;
const MAXSYSTEMS=25;
const MAXMAQUES=5;
const MAXHOLES=3;
const SOUNDS=4;
const CACHES=4;
const IMAGES=2;
const GADGETS=3;
const FONTS=5;
const MAXPLANETS=11;
const MAXCIVS=9;
const PATHS=11;
const MAXPMONEY=102000;
const MAXSTR=900;

type TagArr=array [1..14] of long;
type PenArr=array [1..13] of word;
type ColSpecArr=array [1..5] of integer;
type StrArr=array [1..MAXSYSTEMS] of string[11];
type StrArr42=array [1..42] of string[30];
type ByteArr42=array [0..42] of byte;
type ByteArr22=array [1..22] of byte;
type LongArr42=array [0..42] of long;
type StrArrMAXPLANETS=array [1..MAXPLANETS] of string[5];
type StrArr11=array [1..11] of string[15];
type WordArr32=array[1..34] of word;


type ShipHeader=^r_ShipHeader;
type r_ShipHeader=record;               { Frei verkettete Strukturen }
        Age,SType,Owner,Flags,ShieldBonus,Ladung,Fracht :byte;
        PosX,PosY                                       :short;
        Shield,Weapon,Repair                            :byte;
        Moving,Source,Target,Tactical                   :short;
        TargetShip,BeforeShip,NextShip                  :ShipHeader;
     end;
type r_ShipData=record
        MaxLoad,MaxShield,MaxMove,WeaponPower  :byte;
     end;
type r_SystemHeader=record
        PlanetMemA                              :long;
        State                                   :byte;
        FirstShip                               :r_ShipHeader;
        Planets,vNS,SysOwner                    :byte;
     end;
type PlanetHeader=^r_PlanetHeader;
type r_PlanetHeader=record
        Class,Size,PFlags,Ethno                                 :byte;
        PName                                                   :string[16];
        PosX,PosY                                               :real;
        Population,Water                                        :long;
        Biosphäre,Infrastruktur,Industrie                       :byte
        XProjectCosts,XProjectPayed                             :long;
        ProjectID                                               :short
        FirstShip                                               :r_ShipHeader;
        ProjectPtr                                              :^ByteArr42;
     end;
type r_HiScore=record
        Player          :array [1..8] of string[20]
        CivVar          :array [1..8] of byte;
        Points          :array [1..8] of long;
     end;

type ITBitMap=record
        BytesPerRow,Rows        :word;
        Flags,Depth             :byte;
        pad                     :word;
        PPtr0,PPtr1,PPtr2,PPtr3,
        PPtr4,PPtr5,PPtr6,PPTr7 :PLANEPTR;
        MemA,MemL               :long;
     end;
type r_WormHole=record
        System                  :array [1..2] of byte;
        PosX,PosY               :array [1..2] of short;
        CivKnowledge            :array [1..MAXCIVS] of byte;
     end;

var Tags        :TagArr;
var Pens        :PenArr;
var ColSpec     :ColSpecArr;

var NeuScreen                           :NewScreen;
var MyScreen                            :array [1..2] of ^Screen;
var NeuWindow                           :NewWindow;
var MyWindow                            :array [1..2] of ^Window;
var XScreen                             :^Screen;
var ImgBitMap4,ImgBitMap7,ImgBitMap8    :ITBitMap;
var Img,GadImg1,GadImg2                 :Image;
var CustomTA                            :array [1..FONTS] of TextAttr;
var CustomFont                          :array [1..FONTS] of ^TextFont;
var IBase                               :^IntuitionBase;
var IMsg                                :^IntuiMessage;

var Process_Ptr                         :p_Process;
var OldWindow_Ptr                       :ptr;

var MyWormHole                          :array [1..MAXHOLES] of r_WormHole;
var Romanum                             :StrArrMAXPLANETS;
var PNames                              :array [0..MAXCIVS-2] of StrArr11;
var SystemX,SystemY                     :array [1..MAXSYSTEMS] of integer;
var SystemFlags                         :array [1..MAXCIVS,1..MAXSYSTEMS] of byte;
var SystemHeader                        :array [1..MAXSYSTEMS] of r_SystemHeader;
var Technology,TechnologyL,Project      :StrArr42;
var TechUse1,TechUse2,ProjectNeedsTech,
    ProjectNeedsProject                 :ByteArr42;
var PriorityList                        :ByteArr22;

var SoundMemA                           :array [1..SOUNDS] of long;
var SoundSize                           :array [1..SOUNDS] of word;
var CacheMemA,CacheMemL                 :array [1..CACHES] of long;
var LogoMemA,LogoSMemA,LogoSMemL        :array [0..MAXCIVS-2] of long;
var ZeroSound                           :long;
var IMemA,IMemL                         :array [0..IMAGES] of long;
var ModMemA,ModMemL                     :array [1..MODULES] of long;
var DKnopf                              :array [1..GADGETS] of Gadget;
var DKnopfTx                            :array [1..GADGETS] of IntuiText;
var PathStr                             :array [1..PATHS] of str;
var ShipData                            :array [8..25] of r_ShipData;

var AllCreative,Militärausgaben,Verschrottung   :array [1..MAXCIVS] of long;
var LastDisplay,Warnung                         :array [1..MAXCIVS] of byte;
var TextMemA,TextMemL,PathMemA,PathMemL,HelpID,
    Year,TMPtr,l1,l2,MaquesShips                :long;
var OffsetX,OffsetY,OldX,OldY                   :integer;
var FHandle                                     :BPTR;
var RData                                       :^word;
var LData                                       :^byte;
var Screen2,ObjType,LastSystem,Level,b,
    RawCode,ActPlayer,ActPlayerFlag,LastPlayer,
    Display,HomePlanets,NewPNames               :byte;
var ObjPtr,MTBase,MDBBase                       :ptr;
var s,s2                                        :string;
var WBench,Bool,Valid,IMemID,DoClock,
    MultiPlayer,Informed                        :boolean;
var HiScore                                     :r_HiScore;
var GetPlanet                                   :array [1..MAXCIVS] of ^r_PlanetHeader;
var GetPlanetSys                                :array [1..MAXCIVS] of byte;
var vNSonde                                     :array [1..MAXCIVS] of boolean;
var i,j                                         :integer;
var PText                                       :array [1..MAXSTR] of str;

type r_Save=record
       WarState,LastWarState                            :array [1..MAXCIVS,1..MAXCIVS] of byte;
       Staatstopf,Bevölkerung,WarPower,MaxWarPower,
       ImperatorState                                   :array [1..MAXCIVS] of long;
       SSMoney                                          :array [1..MAXCIVS,1..MAXCIVS] of long;
       TechCosts,ProjectCosts                           :array [1..MAXCIVS] of LongArr42;
       ActTech,GlobalFlags,GSteuer,JSteuer              :array [1..MAXCIVS] of byte;
       stProject,SService,Military                      :array [1..MAXCIVS] of byte;
       PlayMySelf,SmallFight,SmallLand,FastMove,NoWorm  :boolean;
       WorldFlag,SYSTEMS,CivilWar                       :byte
       SystemName                                       :StrArr;
       CivPlayer                                        :array [1..MAXCIVS] of byte;
end;

var Save                :r_Save;



function GETCIVFLAG(CivVar :byte):byte;

begin
   case CivVar of
       1: GETCIVFLAG:=FLAG_TERRA;
       2: GETCIVFLAG:=FLAG_KLEGAN;
       3: GETCIVFLAG:=FLAG_REMALO;
       4: GETCIVFLAG:=FLAG_CARDAC;
       5: GETCIVFLAG:=FLAG_FERAGI;
       6: GETCIVFLAG:=FLAG_BAROJA;
       7: GETCIVFLAG:=FLAG_VOLKAN;
       8: GETCIVFLAG:=FLAG_OTHER;
       9: GETCIVFLAG:=FLAG_MAQUES;
       otherwise GETCIVFLAG:=0;
   end;
end;



procedure REMOVEPLAYER(ActPlayer :byte);

var MyPlanetHeader              :^r_PlanetHeader;
var MyShipPtr,ActShipPtr        :^r_ShipHeader;
var i,j,ActPlayerFlag           :byte;

begin
   Save.Bevölkerung[ActPlayer]:=0;
   ActPlayerFlag:=GETCIVFLAG(ActPlayer);
   for i:=1 to MAXSYSTEMS do with SystemHeader[i] do if PlanetMemA>0 then begin
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         if MyPlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag then
          with MyPlanetHeader^ do begin
            PFlags:=0;        Ethno:=0;
            Population:=0;
            XProjectCosts:=0; XProjectPayed:=0;
            ProjectID:=0;
            if ProjectPtr<>NIL then begin
               ProjectPtr^[7]:=0;
               ProjectPtr^[26]:=0;
               ProjectPtr^[27]:=0;
            end;
         end;
         if MyPlanetHeader^.FirstShip.NextShip<>NIL then begin
            MyShipPtr:=MyPlanetHeader^.FirstShip.NextShip;
            repeat
               if MyShipPtr^.Owner=ActPlayerFlag then MyShipPtr^.Owner:=0;
               MyShipPtr:=MyShipPtr^.NextShip;
            until MyShipPtr=NIL;
         end;
      end;
      if SystemHeader[i].FirstShip.NextShip<>NIL then begin
         MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
         repeat
            if MyShipPtr^.Owner=ActPlayerFlag then MyShipPtr^.Owner:=0;
            if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
               ActShipPtr:=MyShipPtr^.TargetShip;
               repeat
                  if ActShipPtr^.Owner=ActPlayerFlag then ActShipPtr^.Owner:=0;
                  ActShipPtr:=ActShipPtr^.NextShip;
               until ActShipPtr=NIL;
            end;
            MyShipPtr:=MyShipPtr^.NextShip;
         until MyShipPtr=NIL;
      end;
   end;
end;



function INITLANG:boolean;

var WordSet     :boolean;
var c           :^char;
var Addr1,l     :long;

begin
   INITLANG:=false;
   s:='Language.txt';
   FHandle:=DosOpen(s,MODE_OLDFILE);
   if FHandle=0 then begin
      writeln('Kann Locale-Datei »Language.txt« nicht finden!');
      writeln('Can`t find locale-File »Language.txt« !');
      exit;
   end;
   TextMemL:=DosSeek(FHandle,0,OFFSET_END);
   TextMemL:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   TextMemA:=AllocMem(TextMemL,MEMF_CLEAR);
   if TextMemA=0 then begin
      writeln('Nicht genug Speicher vorhanden!');
      writeln('Not enough Memory!');
      DosClose(FHandle);
      exit;
   end;
   l:=DosRead(FHandle,ptr(TextMemA),TextMemL);
   DosClose(FHandle);
   Addr1:=TextMemA; i:=1; WordSet:=false;
   repeat
      c:=ptr(Addr1); Addr1:=Addr1+1;
      if (ord(c^) in [33..58,60..255]) and not WordSet then begin
         PText[i]:=ptr(Addr1-1);
         i:=i+1;
         WordSet:=true;
      end else if ord(c^)=59 then WordSet:=true
      else if (ord(c^)=10) and WordSet then begin
         c^:=chr(0);
         WordSet:=false;
      end;
   until (Addr1>=TextMemA+TextMemL) or (i>MAXSTR);
   INITLANG:=true;
end;



procedure INITVARS;

var i,j :integer;

begin
   TMPtr:=0;
   Pens:=PenArr(0,0,0,0,0,0,0,0,0,0,0,0,0);
   for i:=1 to SOUNDS do SoundMemA[i]:=0;
   for i:=0 to IMAGES do IMemA[i]:=0;
   for i:=1 to MODULES do ModMemA[i]:=0;
   for i:=1 to CACHES do CacheMemA[i]:=0;
   ImgBitMap4:=ITBitMap(0,0,0,0,0,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,0,0);
   ImgBitMap7:=ITBitMap(0,0,0,0,0,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,0,0);
   ImgBitMap8:=ITBitMap(0,0,0,0,0,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,0,0);
   MyScreen[1]:=NIL; MyScreen[2]:=NIL;
   Screen2:=0;       PathMemA:=0;     ZeroSound:=0;
   Year:=1899;       Level:=5;        Display:=100;
   ActPlayer:=1;     ActPlayerFlag:=FLAG_TERRA;
   LastPlayer:=0;    HomePlanets:=1;  MaquesShips:=0;
   Valid:=true;      IMemID:=false;   DoClock:=false;
   Save.PlayMySelf:=false; Save.NoWorm:=false;
   Save.SmallLand:=false;  Save.SmallFight:=false;
   Save.FastMove:=false;   Save.WorldFlag:=0;
   Save.CivPlayer[1]:=1;   for i:=2 to MAXCIVS do Save.CivPlayer[i]:=0;
   Save.CivilWar:=0;

   for i:=1 to 25 do Save.SystemName[i]:=PText[i];
   Technology:=StrArr42('Halbleiter',              'Informatik',
                        'Recycling',               'Kernfusion',
                        'Carbonfasern',            'Keramik-Technologie',
                        'Mikroelektronik',         'Fotovoltaik',
                        'Gentechnik',              'Teilchenphysik',
                        'Raumstations-Technologie','Supraleiter',
                        'Mikrocomputer',           'selbstwachsende Strukturen',
                        'Hochenergie-Laser',       'Raumdock-Technologie',
                        'Triravit',                'Cyberspace',
                        'Bio-Elektronik',          'Ionenantrieb',
                        'Duravit',                 'künstliche Intelligenz',
                        'Bio-Computer',            'Phaser',
                        'Duranium',                'Androiden',
                        'Raumholografie',          'Impulsantrieb',
                        'Materiedestruktion',      'Sol-Antrieb',
                        'Beamen',                  'Disruptoren',
                        'Warp-Antrieb',            'selbstorganisierende Systeme',
                        'Tiefschlaf-Technologie',  'Transwarp',
                        'Protonentorpedos',        'Bewußtseins-Transformation',
                        'Chaostheorie',            'Energiestrukturen',
                        'Weltformel',              'energetische Intelligenz');
   for i:=1 to 42 do TechnologyL[i]:=PText[29+i];
   TechUse1:=ByteArr42(0,  0,0,0,0,0,  0,1,1,3,4,  3,6,2,8,10,   4,11,13,13,15, 16,18,19,20,21,  12,23,24,24,21,  27,29,25, 2,26,  31,32,34,13,36,  39,38);
   TechUse2:=ByteArr42(0,  0,0,0,0,0,  0,1,1,3,4,  5,6,7,9,16,  11,12,13,14,17, 20,18,22,20,30,  22,23,24,24,28,  29,33,30,31,31,  32,33,35,13,37,  40,41);
   Save.TechCosts[1]:=LongArr42(0,
                            2010,  2510, 3020,13020, 3030, 4530, 4040,  5040, 6550, 7050,
                            7060,  9560,11070,11070,12580,13080,15090, 15100,16100,17100,
                           18200, 29200,21300,21800,22900,23400,24500, 26000,26600,27600,
                           29200, 30200,33300,33800,35400,38900,40500, 55000,15000,55000,
                           85000,135000);
   Project:=StrArr42('','','','','','','',
                {8}  'Wostok',     'Mir',     'Spaceshuttle','Starwing',
               {12}  'Galaxy',    'Catamaran','Quasar',      'Destroyer',
               {16}  'Voyager',   'Deltawing','Tristars',    'Voyager2',
               {20}  'Warbird',   'Stargate', 'Voyager3',    'Pulsar',
               {24}  'Starburner',

               {25}  '','','','','','','','','','','','','','','','','','');
   for i:=1 to 7 do Project[i]:=PText[i+74];
   for i:=25 to 42 do Project[i]:=PText[i+60];

   PriorityList:=ByteArr22(25, 5,1,34, 40,30,6,37, 7,31,41,33, 32,36,42,35,38,28,29,3,4,39);
   ProjectNeedsTech:=ByteArr42(0,
                               0,0,9,19,40,41,42,
                               7,11,15,16, 20,21,24,28, 30,25,33,32, 35,31,36,37, 38,
                               16,0,0,0,
                               2,3,4,8,10,12,13,18,22,23,26,29,34,39);
   ProjectNeedsProject:=ByteArr42(0,
                                  0,29,0,3,0,0,6,
                                  0,0,0,25,25,25,25,25,25,25,25,25,25,25,25,25,25,
                                  0,1,0,0,
                                  28,0,32,0,0,0,0,0,0,35,0,34,0,0);
   Save.ProjectCosts[1]:=LongArr42(0,
                                 92010, 184020, 276030,
                                368040, 561050, 664060,
                                795000,

                              15080,17090,22100,25110,
                              28120,31130,34140,37150,
                              39160,43170,49180,55190,
                              63200,70210,78220,86230,
                              96240,

                               45250,12260,17270,45280,

                               50290, 19300, 55310,
                               35320, 50330, 55340,
                               30350, 25360, 25370,
                               50380, 35390,130400,
                               70410, 80420);
   for i:=1 to MAXCIVS do with Save do begin
      GetPlanet[i]:=NIL;               GetPlanetSys[i]:=0;
      Verschrottung[i]:=0;             vNSonde[i]:=false;
      Warnung[i]:=0;
      GlobalFlags[i]:=GFLAG_EXPLORE;   MaxWarPower[i]:=0;
      SService[i]:=0;                  Military[i]:=0;
      TechCosts[i]:=Save.TechCosts[1]; ProjectCosts[i]:=Save.ProjectCosts[1];
      ImperatorState[i]:=2500;         Staatstopf[i]:=0;
      Bevölkerung[i]:=5;               WarPower[i]:=0;
      AllCreative[i]:=1;               ActTech[i]:=0;
      GSteuer[i]:=10;                  JSteuer[i]:=0;
      stProject[i]:=0;
   end;
   for i:=0 to (MAXCIVS-2) do with Save do begin
      LogoMemA[i]:=0;
      LogoSMemA[i]:=0;
      LogoSMemL[i]:=0;
   end;
   for i:=1 to MAXCIVS do for j:=1 to MAXCIVS do Save.SSMoney[i,j]:=0;

   for i:=1 to MAXCIVS do for j:=1 to MAXCIVS do begin
      LastDisplay[i]:=0;
      Militärausgaben[i]:=0;
      Save.WarState[i,j]:=LEVEL_UNKNOWN;     Save.WarState[j,i]:=LEVEL_UNKNOWN;
      Save.LastWarState[i,j]:=LEVEL_UNKNOWN; Save.LastWarState[j,i]:=LEVEL_UNKNOWN;
      Save.WarState[j,8]:=LEVEL_DIED;        Save.WarState[j,9]:=LEVEL_DIED;
   end;
   Save.WarState[1,1]:=LEVEL_PEACE;
   Save.SYSTEMS:=MAXSYSTEMS;
   for i:=1 to MAXSYSTEMS do SystemHeader[i].PlanetMemA:=0;

              {ShipData:    MaxLoad,MaxShield,MaxMove,WeaponPower}
   ShipData[8]:= r_ShipData( 3,  7, 1, 1);   {Wostok,       7}
   ShipData[9]:= r_ShipData( 4,  5, 1, 1);   {Mir,         11}
   ShipData[10]:=r_ShipData( 5, 16, 2, 5);   {Spaceshuttle,15}
   ShipData[11]:=r_ShipData( 6, 22, 3, 4);   {Starwing,    16}
   ShipData[12]:=r_ShipData( 9, 36, 6, 5);   {Galaxy,      20}
   ShipData[13]:=r_ShipData(10, 49, 6, 6);   {Catamaran,   24}
   ShipData[14]:=r_ShipData(11, 57, 8, 7);   {Quasar,      21}
   ShipData[15]:=r_ShipData( 9, 64, 7, 9);   {Destroyer    28}
   ShipData[16]:=r_ShipData(10, 79,12,10);   {Voyager 1,   25}
   ShipData[17]:=r_ShipData(15, 93,10,11);   {Delta-Wing,  30}
   ShipData[18]:=r_ShipData( 9,107,16,12);   {Tristars,    33}
   ShipData[19]:=r_ShipData(19,121,14,14);   {Voyager 2,   32}
   ShipData[20]:=r_ShipData(22,129,21,15);   {Warbird,     35}
   ShipData[21]:=r_ShipData( 4, 60,20,12);   {Stargate,    31}
   ShipData[22]:=r_ShipData(25,136,19,16);   {Voyager 3,   38}
   ShipData[23]:=r_ShipData(28,149,27,18);   {Pulsar,      37}
   ShipData[24]:=r_ShipData(33,160,24,20);   {Starburner,  36}
   { Maximal:               --,---,27,-                    }
   Romanum:=StrArrMAXPLANETS('I','II','III','IV','V','VI','VII','VIII','IX','X','XI');
   PNames[0]:=StrArr11('Tacoron','Delosiab','Dhelax','Lakusid','Rosod',
                       'Munaxx','Zehketa','Yamos','Jake','Emeneres','Andmun');
   for i:=1 to 9 do PNames[1,i]:=PText[104+i];
   PNames[1,10]:='';
   PNames[1,11]:='';
   PNames[2]:=StrArr11('Darukis','Akaneb', 'Kleganeb','Sedokub','Khalakeb',
                       'Dasekab','Redaseb','Vedekab', 'Damakeb','Khetomer',
                       'Zhalakab');
   PNames[3]:=StrArr11('Akusum', 'Celadum','Remalus','Dianum','Ecanum',
                       'Jamaris','Lorius', 'Noratum','Tamarus','Pekateg',
                       'Raletis');
   PNames[4]:=StrArr11('Inarett',  'Ferraccud','Cardaccia','Latecca',  'Ooro',
                       'Reedameec','Soorov',   'Zalee',    'Zaalasena','Veda',
                       'Sodoora');
   PNames[5]:=StrArr11('Deragi',  'Sodaki',  'Feragini','Zolati', 'Plauti',
                       'Olsatebi','Munakati','Rastoki', 'Mosavli','Berali',
                       'Dresadai');
   PNames[6]:=StrArr11('Bos','Dak','Bajo','Zeda','Co',
                       'Zud','Fec','Paq', 'Loa', 'Zate',
                       'Wid');
   PNames[7]:=StrArr11('Wolaron','Unareus', 'Volkan','Ataneia','Peratham',
                       'Musacem','Geratios','Paluae','Idakel', 'Amirima',
                       'Ressan');
   NewPNames:=succ(random(MAXPLANETS));
   OffsetX:=0; OffsetY:=0; OldX:=0; OldY:=0; LastSystem:=1;
end;






procedure SWITCHDISPLAY;

var pw  :^word;

begin
   pw:=ptr(14676118);
   pw^:=256;
end;



procedure CLOSEMYSCREENS;

var i   :byte;

begin
   ScreenToFront(XScreen);
   SWITCHDISPLAY;
   for i:=1 to 2 do if MyScreen[i]<>NIL then begin
      while MyScreen[i]^.FirstWindow<>NIL do CloseWindow(MyScreen[i]^.FirstWindow);
      CloseScreen(MyScreen[i]); MyScreen[i]:=NIL;
   end;
end;



procedure WRITE(IPosX,IPosY :word; Color,DMode :byte; XScreen :Screen; TA :byte; WText :str);

var MyText      :IntuiText;

begin
   MyText:=IntuiText(Color,0,DMode and $F,IPosX,IPosY,^CustomTA[TA],WText,NIL);
   if (DMode and 16=16) then MyText.LeftEdge:=IPosX-(IntuiTextLength(^MyText) div 2);
   if (DMode and 32=32) then MyText.LeftEdge:=IPosX-IntuiTextLength(^MyText)-(CustomTA[TA].ta_YSize div 2);
   if (DMode and 64=64) then begin
      MyText.FrontPen:=0;
      PrintIText(^XScreen.RastPort,^MyText,1,1);
      MyText.FrontPen:=Color;
   end;
   PrintIText(^XScreen.RastPort,^MyText,0,0);
end;



procedure PLAYSOUND(SID :byte; SRate :word);

var Vol         :byte;

begin
   if TMPtr=0 then DMACON_WRITE^:=$0003;
   WaitTOF;
   if SID=1 then begin
      if TMPtr=0 then begin
         Vol:=IBase^.MouseX div 10;   SPVolB^:=Vol;   SPVolA^:=64-Vol;
         SPAddrA^:=SoundMemA[SID]; SPFreqA^:=SRate; SPLengthA^:=SoundSize[SID];
         SPAddrB^:=SoundMemA[SID]; SPFreqB^:=SRate; SPLengthB^:=SoundSize[SID];
         DMACON_WRITE^:=$8003;
         WaitTOF;
         SPAddrA^:=ZeroSound; SPLengthA^:=1;
         SPAddrB^:=ZeroSound; SPLengthB^:=1;
      end;
      repeat
         delay(RDELAY);
      until not (LData^ and 64=0) and not (RData^ and 1024=0) or Save.PlayMySelf;
      if (TMPtr=0) and (SID=1) then begin
         WaitTOF;
         DMACON_WRITE^:=$0003;
         WaitTOF;
      end;
   end else begin
      SPAddrA^:=SoundMemA[SID];                SPVolA^:=64; SPFreqA^:=SRate; SPLengthA^:=SoundSize[SID] div 2;
      SPAddrB^:=SoundMemA[SID]+SoundSize[SID]; SPVolB^:=64; SPFreqB^:=SRate; SPLengthB^:=SoundSize[SID] div 2;
      if SID=4 then begin
         SPAddrA^:=SoundMemA[SID]; SPVolA^:=64; SPFreqA^:=SRate; SPLengthA^:=SoundSize[SID];
         SPAddrB^:=SoundMemA[SID]; SPVolB^:=64; SPFreqB^:=SRate; SPLengthB^:=SoundSize[SID];
      end;
      DMACON_WRITE^:=$8003;
      WaitTOF;
      SPAddrA^:=ZeroSound; SPLengthA^:=1;
      SPAddrB^:=ZeroSound; SPLengthB^:=1;
   end;
end;



procedure CLEARINTUITION;

var i   :byte;

begin
   if (MyScreen[1]^.FirstWindow=NIL) or (MyScreen[2]^.FirstWindow=NIL) then exit;
   for i:=1 to 2 do repeat
      RawCode:=0;
      IMsg:=Get_Msg(MyWindow[i]^.UserPort);
      if IMsg<>NIL then begin
         RawCode:=1;
         Reply_Msg(IMsg);
      end;
   until Rawcode=0;
end;



function GETRAWCODE:byte;

begin
   GETRAWCODE:=0;
   if (MyScreen[1]^.FirstWindow=NIL) or (MyScreen[2]^.FirstWindow=NIL) then exit;
   IMsg:=Get_Msg(MyWindow[1]^.UserPort);
   if IMsg=NIL then IMsg:=Get_Msg(MyWindow[2]^.UserPort);
   if IMsg<>NIL then begin
      if IMsg^.Class=RAWKEY then GETRAWCODE:=IMsg^.Code;
      Reply_Msg(IMsg);
   end;
end;



procedure WAITLOOP(Bool :boolean);

var i   :byte;

begin
   repeat
      delay(RDELAY);
      RawCode:=GETRAWCODE;
   until (RawCode in [64,67,68])
   or (LData^ and 64=0) or (RData^ and 1024=0) or Bool;
   PLAYSOUND(1,300);
   repeat
      delay(RDELAY);
   until (not (LData^ and 64=0) and not (RData^ and 1024=0)) or Bool;
   CLEARINTUITION;
end;



function OPENSMOOTH(FStr :str; FMode :long):BPTR;

var FName       :string[100];
var DName       :string[20];
var FHandle     :BPTR;
var i           :byte;
var b           :boolean;
var XScreen     :^Screen;

begin
   FName:=FStr;
   FHandle:=DosOpen(FName,FMode);
   if FHandle=0 then begin
      repeat
         delay(RDELAY);
      until not (LData^ and 64=0);
      b:=false;
      for i:=1 to length(FName) do if FName[i]=':' then begin
         DName:=FName;
         DName[i]:=chr(0);
         b:=true;
      end;
      if b then begin
         NeuScreen:=NewScreen(180,0,280,40,1,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,
                              NIL,'',NIL,NIL);
         Tags:=TagArr(SA_DisplayID,   ($9004+HelpID),
                      SA_Interleaved, _TRUE,
                      SA_DRAGGABLE,   _FALSE,
                      SA_PENS,        addr(Pens),
                      SA_COLORS,      addr(ColSpec),
                      TAG_DONE,       0,0,0);
         XScreen:=OpenScreenTagList(^NeuScreen,^Tags);
         if XScreen=NIL then begin
            OPENSMOOTH:=0;
            exit;
         end;
         SetRGB32(^XScreen^.ViewPort,1,$BB000000,$BB000000,$FF000000);
         ScreenToBack(XScreen);
         WRITE(140,00,1,16,XScreen^,4,'Bitte Disk');
         DName:=DName+' einlegen!';
         WRITE(140,20,1,16,XScreen^,4,DName);
         i:=0;
         while (FHandle=0) and (i<3) do begin
            i:=i+1;
            ScreenToFront(XScreen);
            repeat
               delay(6);
               FHandle:=DosOpen(FName,FMode);
            until (LData^ and 64=0) or (FHandle<>0);
            ScreenToBack(XScreen);
            repeat
               delay(6);
            until not (LData^ and 64=0);
            if FHandle=0 then FHandle:=DosOpen(FName,FMode);
         end;
         CloseScreen(XScreen);
      end;
   end;
   OPENSMOOTH:=FHandle;
end;



procedure RECT(XScreen :Screen, Color,LEdge,TEdge,REdge,BEdge :word);

begin
   SetAPen(^XScreen.RastPort,Color);
   RectFill(^XScreen.RastPort,LEdge,TEdge,REdge,BEdge);
end;



procedure MAKEBORDER(XScreen :Screen; LEdge,TEdge,REdge,BEdge :word; Col1,Col2,Darken :byte);

begin
   if Darken<>1 then RECT(XScreen,Darken,LEdge,TEdge,REdge,BEdge);
   RECT(XScreen,Col1,LEdge,TEdge,LEdge+1,BEdge);
   RECT(XScreen,Col1,LEdge+2,TEdge,REdge,TEdge+1);
   RECT(XScreen,Col2,LEdge+2,BEdge-1,REdge,BEdge);
   RECT(XScreen,Col2,REdge-1,TEdge+2,REdge,BEdge-1);
end;




procedure PRINTGLOBALINFOS(ActPlayer :byte);

begin
   s:=intstr(Year);
   WRITE(545,134,109,1,MyScreen[1]^,2,s);
   if not Valid then exit;
   if (Save.CivPlayer[ActPlayer]<>0) and Informed
    then s:=intstr(Save.Staatstopf[ActPlayer]) else s:='0';
   while length(s)>8 do s[length(s)]:=chr(0);
   while length(s)<8 do s:=' '+s;
   if (Save.CivPlayer[ActPlayer]<>0) or not Save.PlayMySelf then
    WRITE(640,185,109,32+1,MyScreen[1]^,2,s);
   if (Save.CivPlayer[ActPlayer]<>0) and Informed
    then s:=intstr(Save.Bevölkerung[ActPlayer]) else s:='0';
   while length(s)<8 do s:=' '+s;
   while length(s)>8 do s[length(s)]:=chr(0);
   if (Save.CivPlayer[ActPlayer]<>0) or not Save.PlayMySelf then
    WRITE(521,236,109,1,MyScreen[1]^,2,s);
end;



function GETCIVVAR(CivFlag :byte):byte;

begin
   case (CivFlag and FLAG_CIV_MASK) of
       FLAG_TERRA:   GETCIVVAR:=1;
       FLAG_KLEGAN:  GETCIVVAR:=2;
       FLAG_REMALO:  GETCIVVAR:=3;
       FLAG_CARDAC:  GETCIVVAR:=4;
       FLAG_FERAGI:  GETCIVVAR:=5;
       FLAG_BAROJA:  GETCIVVAR:=6;
       FLAG_VOLKAN:  GETCIVVAR:=7;
       FLAG_OTHER:   GETCIVVAR:=8;
       FLAG_MAQUES:  GETCIVVAR:=9;
       otherwise GETCIVVAR:=0;
   end;
end;



function GETCIVADJ(CivVar :byte):str;

begin
   case CivVar of
      1: GETCIVADJ:=PText[115];
      2: GETCIVADJ:=PText[116];
      3: GETCIVADJ:=PText[117];
      4: GETCIVADJ:=PText[118];
      5: GETCIVADJ:=PText[119];
      6: GETCIVADJ:=PText[120];
      7: GETCIVADJ:=PText[121];
      8: case Save.WorldFlag of
            WFLAG_DCON:   GETCIVADJ:=PText[122];
            WFLAG_JAHADR: GETCIVADJ:=PText[123];
            otherwise GETCIVADJ:=GETCIVADJ(GETCIVVAR(Save.WorldFlag));
         end;
      otherwise GETCIVADJ:='ERROR';
   end;
end;



function GETCIVNAME(CivVar :byte):str;

begin
   case CivVar of
      1: GETCIVNAME:=PText[125];
      2: GETCIVNAME:=PText[126];
      3: GETCIVNAME:=PText[127];
      4: GETCIVNAME:=PText[128];
      5: GETCIVNAME:=PText[129];
      6: GETCIVNAME:=PText[130];
      7: GETCIVNAME:=PText[131];
      8: case Save.WorldFlag of
            WFLAG_CEBORC: GETCIVNAME:=PText[132];
            WFLAG_DCON:   GETCIVNAME:=PText[133];
            WFLAG_JAHADR: GETCIVNAME:=PText[134];
            otherwise GETCIVNAME:=GETCIVNAME(GETCIVVAR(Save.WorldFlag))
         end;
      9: GETCIVNAME:=PText[135];
      otherwise GETCIVNAME:='ERROR';
   end;
end;




procedure CREATEJAHADR(ActPlayer :byte);

var i,j                 :byte;
var MyPlanetHeader      :PlanetHeader;
var MyShipPtr           :ShipHeader;

begin
   if not Save.WorldFlag in [0,WFLAG_JAHADR] then exit;
   Save.WorldFlag:=WFLAG_JAHADR;
   for i:=1 to 8 do begin
      Save.WarState[i,ActPlayer]:=LEVEL_DIED; Save.LastWarState[i,ActPlayer]:=LEVEL_DIED;
      Save.WarState[i,8]:=LEVEL_UNKNOWN;
      Save.WarState[8,i]:=LEVEL_UNKNOWN;
   end;
   Save.CivPlayer[8]:=0;
   if Year>2050 then Save.Staatstopf[8]:=Save.Staatstopf[8]+abs(Year)*120;
   Save.TechCosts[8,15]:=0;
   Save.TechCosts[8,16]:=0;
   Save.GSteuer[8]:=0;
   for i:=1 to 42 do if Save.TechCosts[ActPlayer,i]<=0 then Save.TechCosts[8,i]:=0;
   for i:=1 to Save.SYSTEMS do begin
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         with MyPlanetHeader^ do if GETCIVVAR(PFlags)=ActPlayer then begin
            PFlags:=FLAG_OTHER;
            Ethno:=(PFlags and FLAG_CIV_MASK);
            Save.Bevölkerung[8]:=Save.Bevölkerung[8]+Population;
            Biosphäre:=200;   Infrastruktur:=200;   Industrie:=200;
            if ProjectPtr<>NIL then begin
               ProjectPtr^[1]:=1;  ProjectPtr^[25]:=1;
               ProjectPtr^[30]:=1; ProjectPtr^[32]:=1;
               PRojectPtr^[26]:=ProjectPtr^[26] or 16;
               PRojectPtr^[27]:=ProjectPtr^[27] or 16;
            end;
            ProjectID:=0;
            if FirstShip.NextShip<>NIL then begin
               MyShipPtr:=FirstShip.NextShip;
               repeat
                  MyShipPtr^.Owner:=(PFlags and FLAG_CIV_MASK);
                  MyShipPtr:=MyShipPtr^.NextShip;
               until MyShipPtr=NIL;
            end;
         end;
      end;
   end;
end;



procedure DRAWSTARS(Mode,ActPlayer :byte);

var i                   :integer;
var MyShipPtr           :^r_ShipHeader;
var MaxVal              :long;
var Factor              :real;
var CVal                :array [1..8] of long;
var ActPlayerFlag       :byte;

begin
   ActPlayerFlag:=GETCIVFLAG(ActPlayer);
   Display:=0;
   if Mode in [MODE_REDRAW,MODE_STARGATE] then begin
      for i:=1 to 3 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,518,500-i*28);
      WRITE(576,418,0,16,MyScreen[1]^,4,PText[140]);
      WRITE(576,446,0,16,MyScreen[1]^,4,PText[141]);
      WRITE(576,474,8,16,MyScreen[1]^,4,PText[142]);
      RECT(MyScreen[1]^,0,0,0,511,511);
      SetAPen(^MyScreen[1]^.RastPort,6);
      for i:=1 to 310 do WritePixel(^MyScreen[1]^.RastPort,random(255)+random(255),random(255)+random(255));
   end;
   if Save.PlayMySelf then begin
      MaxVal:=0;
      for i:=1 to 8 do begin
         CVal[i]:=Save.Bevölkerung[i]+Save.WarPower[i]*20+Save.ImperatorState[i]*10;
         if CVal[i]>MaxVal then MaxVal:=CVal[i];
      end;
      Factor:=MaxVal/20;
      for i:=1 to 8 do if (i<8) or not (Save.WorldFlag in [0,WFLAG_FIELD]) then begin
         RECT(MyScreen[1]^,0            ,pred(i)*64,490,i*64-2,round(511-(CVal[i]/Factor)));
         RECT(MyScreen[1]^,GETCIVFLAG(i),pred(i)*64,round(511-(CVal[i]/Factor)),i*64-2,511);
         s:=intstr(CVal[i]);
         WRITE(i*64+2,502,45,32,MyScreen[1]^,1,s);
      end;
   end;
   SetAPen(^MyScreen[1]^.RastPort,12);
   if Informed then for j:=1 to MAXHOLES do with MyWormHole[j] do for i:=1 to 2 do
    if CivKnowledge[ActPlayer]=FLAG_KNOWN then begin
      Move(^MyScreen[1]^.RastPort,SystemX[System[1]],SystemY[System[1]]);
      Draw(^MyScreen[1]^.RastPort,SystemX[System[2]],SystemY[System[2]]);
   end;
   for i:=1 to Save.SYSTEMS do if (SystemHeader[i].FirstShip.NextShip<>NIL)
   and (Mode<>MODE_STARGATE) then begin
      SetAPen(^MyScreen[1]^.RastPort,ActPlayerFlag);
      MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
      while (MyShipPtr<>NIL) and (MyShipPtr^.NextShip<>MyShipPtr) do begin
         if (MyShipPtr^.Moving<0) and (MyShipPtr^.Owner=ActPlayerFlag)
         and (Save.CivPlayer[ActPlayer]<>0) and Informed
         and (MyShipPtr^.Source in [1..Save.SYSTEMS])
         and (MyShipPtr^.Target in [1..Save.Systems]) then begin
            Move(^MyScreen[1]^.RastPort,SystemX[MyShipPtr^.Source],SystemY[MyShipPtr^.Source]);
            Draw(^MyScreen[1]^.RastPort,SystemX[MyShipPtr^.Target],SystemY[MyShipPtr^.Target]);
         end;
         MyShipPtr:=MyShipPtr^.NextShip;
      end;
   end;
   for i:=1 to Save.SYSTEMS do begin
      if not Save.PlayMySelf and
      (((SystemFlags[ActPlayer,i] and FLAG_KNOWN<>FLAG_KNOWN) or (Save.CivPlayer[ActPlayer]=0)
      or not Informed) and (SystemHeader[i].vNS<>FLAG_KNOWN) or ((Mode=MODE_STARGATE)
      and (SystemHeader[i].FirstShip.SType<>TARGET_STARGATE))) then begin
         RECT(MyScreen[1]^,0,pred(SystemX[i]),pred(SystemY[i]),succ(SystemX[i]),succ(SystemY[i]));
         SetAPen(^MyScreen[1]^.RastPort,12);
         WritePixel(^MyScreen[1]^.RastPort,SystemX[i],SystemY[i]);
         WRITE(SystemX[i]+3,SystemY[i]+3,12,1,MyScreen[1]^,1,Save.SystemName[i]);
      end else if (SystemFlags[1,i] and FLAG_CIV_MASK<>0) then begin
         SetAPen(^MyScreen[1]^.RastPort,SystemFlags[1,i] and FLAG_CIV_MASK);
         if (SystemHeader[i].FirstShip.SType=TARGET_STARGATE)
          then DrawEllipse(^MyScreen[1]^.RastPort,SystemX[i],SystemY[i],4,4)
          else RECT(MyScreen[1]^,SystemFlags[1,i] and FLAG_CIV_MASK,pred(SystemX[i]),pred(SystemY[i]),succ(SystemX[i]),succ(SystemY[i]));
         WRITE(SystemX[i]+3,SystemY[i]+3,SystemFlags[1,i] and FLAG_CIV_MASK,1,MyScreen[1]^,1,Save.SystemName[i]);
      end else begin
         SetAPen(^MyScreen[1]^.RastPort,12);
         if (SystemHeader[i].FirstShip.SType=TARGET_STARGATE)
          then DrawEllipse(^MyScreen[1]^.RastPort,SystemX[i],SystemY[i],4,4)
          else RECT(MyScreen[1]^,12,pred(SystemX[i]),pred(SystemY[i]),succ(SystemX[i]),succ(SystemY[i]));
         WRITE(SystemX[i]+3,SystemY[i]+3,12,1,MyScreen[1]^,1,Save.SystemName[i]);
      end;
   end;
   PRINTGLOBALINFOS(ActPlayer);
   if not Save.PlayMySelf then ScreenToFront(MyScreen[1]);
end;



procedure BOX(XScreen :Screen; Left,Top,Right,Bottom :word);

type BoxArr=array [1..8] of word;

var BArr        :BoxArr;

begin
   BArr:=BoxArr(Right,Top,Right,Bottom,Left,Bottom,Left,Top);
   Move(^XScreen.RastPort,Left,Top);
   PolyDraw(^XScreen.RastPort,4,^BArr);
end;



procedure DRAWSYSTEM(Mode,ActSys :byte; ActShipPtr :ptr);

var x,y,i                       :integer;
var l                           :long;
var MyShipPtr,UseShipPtr        :^r_ShipHeader;
var PlanetHeader                :^r_PlanetHeader;
var Leave,j                     :byte;

begin
   OldX:=OffsetX; OldY:=OffsetY;
   if Mode=MODE_REDRAW then begin
      if Display in [0,100] then begin
         for i:=1 to 3 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,518,500-i*28);
         WRITE(576,418,0,16,MyScreen[1]^,4,PText[143]);
         WRITE(576,446,0,16,MyScreen[1]^,4,PText[144]);
         WRITE(576,474,8,16,MyScreen[1]^,4,PText[142]);
      end;
      Display:=ActSys;
      RECT(MyScreen[1]^,0,522,9,629,116);
      RECT(MyScreen[1]^,0,0,0,511,511);
      RECT(MyScreen[1]^,10,575,62,577,63);
   end;
   Display:=ActSys;
   SetAPen(^MyScreen[1]^.RastPort,109);
   x:=63-OffsetY-10;                   y:=63-OffsetY+8;
   if x<9 then x:=9;                   if y>116 then y:=116;
   Move(^MyScreen[1]^.RastPort,522,x); Draw(^MyScreen[1]^.RastPort,629,x);
   Move(^MyScreen[1]^.RastPort,522,y); Draw(^MyScreen[1]^.RastPort,629,y);
   x:=576-OffsetX-10;                y:=576-OffsetX+8;
   if x<522 then x:=522;             if y>629 then y:=629;
   Move(^MyScreen[1]^.RastPort,x,9); Draw(^MyScreen[1]^.RastPort,x,116);
   Move(^MyScreen[1]^.RastPort,y,9); Draw(^MyScreen[1]^.RastPort,y,116);
   if (OffsetX in [-7..7]) and (OffsetY in [-7..7]) then begin
      BltBitMapRastPort(^ImgBitMap7,288,0,^MyScreen[1]^.RastPort,224+OffsetX*32,224+OffsetY*32,64,32,192);
      BltBitMapRastPort(^ImgBitMap7,352,0,^MyScreen[1]^.RastPort,224+OffsetX*32,256+OffsetY*32,64,32,192);
   end;
   SetAPen(^MyScreen[1]^.RastPort,12);
   for j:=1 to MAXHOLES do with MyWormHole[j] do for i:=1 to 2 do if System[i]=ActSys then begin
      x:=256+round(PosX[i]+OffsetX)*32;
      y:=256+round(PosY[i]+OffsetY)*32;
      if (x in [0..480]) and (y in [0..480]) then begin
         RectFill(^MyScreen[1]^.RastPort,x+15,Y+15,x+17,y+17);
         if (x in [32..448]) and (y in [32..448]) then
          if (SystemFlags[1,System[3-i]] and FLAG_CIV_MASK=0) then WRITE(x+16,y+20,12,16,MyScreen[1]^,1,Save.SystemName[System[3-i]])
          else WRITE(x+16,y+20,SystemFlags[1,System[3-i]] and FLAG_CIV_MASK,16,MyScreen[1]^,1,Save.SystemName[System[3-i]]);
         if Save.CivPlayer[ActPlayer]<>0 then CivKnowledge[ActPlayer]:=FLAG_KNOWN;
      end;
      if CivKnowledge[ActPlayer]=FLAG_KNOWN then WritePixel(^MyScreen[1]^.RastPort,575+PosX[i],62+PosY[i]);
   end;
   for i:=1 to SystemHeader[ActSys].Planets do begin
      PlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(i)*sizeof(r_PlanetHeader));
      with PlanetHeader^ do begin
         if Mode=MODE_REDRAW then begin
            if PFlags>0 then SetAPen(^MyScreen[1]^.RastPort,PFlags) else SetAPen(^MyScreen[1]^.RastPort,12);
            RectFill(^MyScreen[1]^.RastPort,575+round(PosX),62+round(PosY),576+round(PosX),63+round(PosY));
         end;
         x:=256+round(PosX+OffsetX)*32;
         y:=256+round(PosY+OffsetY)*32;
         if (x in [0..480]) and (y in [0..480]) then begin
            BltBitMapRastPort(^ImgBitMap7,Class*32,0,^MyScreen[1]^.RastPort,x,y,32,32,192);
            if (x in [32..448]) and (y in [32..448]) then begin
               MyShipPtr:=FirstShip.NextShip;
               while (MyShipPtr<>NIL) and (MyShipPtr^.Owner=0) do MyShipPtr:=MyShipPtr^.NextShip;
               if MyShipPtr<>NIL then SetAPen(^MyScreen[1]^.RastPort,MyShipPtr^.Owner and FLAG_CIV_MASK)
               else SetAPen(^MyScreen[1]^.RastPort,0);
               DrawEllipse(^MyScreen[1]^.RastPort,x+15,y+15,24,23);
               if ProjectPtr^[25]=1 then BltBitMapRastPort(^ImgBitMap4,544,32,^MyScreen[1]^.RastPort,x-18,y+10,15,14,192);
               if PFlags>0 then begin
                  if (ProjectPtr^[34]<>0) or (ProjectPtr^[40]<>0) then
                   WRITE(x+15,y+32,PFlags,21,MyScreen[1]^,1,PName)
                  else WRITE(x+15,y+32,PFlags,17,MyScreen[1]^,1,PName);
               end else begin
                  if (ProjectPtr<>NIL) and
                  ((ProjectPtr^[34]>0) or (ProjectPtr^[40]>0)) then
                   WRITE(x+15,y+32,12,21,MyScreen[1]^,1,PName)
                  else WRITE(x+15,y+32,12,17,MyScreen[1]^,1,PName);
               end;
            end;
         end;
      end;
   end;
   Leave:=0;
   MyShipPtr:=^SystemHeader[ActSys].FirstShip;
   while (MyShipPtr<>NIL) and (Leave<2) do begin
      if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
         UseShipPtr:=MyShipPtr^.TargetShip;
         while (UseShipPtr<>NIL) and (UseShipPtr^.Owner=0) do UseShipPtr:=UseShipPtr^.NextShip;
      end else UseShipPtr:=MyShipPtr;
      if UseShipPtr<>NIL then
      if (MyShipPtr^.Owner>0) and (UseShipPtr^.Owner>0) and (MyShipPtr^.Moving>=0)
      and (MyShipPtr^.SType>0) or (MyShipPtr^.SType=TARGET_STARGATE) then begin
         x:=256+(MyShipPtr^.PosX+OffsetX)*32;
         y:=256+(MyShipPtr^.PosY+OffsetY)*32;
         if MyShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=MyShipPtr^.TargetShip
         else UseShipPtr:=MyShipPtr;
         if (x in [0..480]) and (y in [0..480]) then begin
            RECT(MyScreen[1]^,0,x,y,x+31,y+31);
            BltBitMapRastPort(^ImgBitMap4,(UseShipPtr^.SType-8)*32,32,^MyScreen[1]^.RastPort,x,y,31,31,192);
         end;
         if UseShipPtr^.SType<>TARGET_STARGATE then SetAPen(^MyScreen[1]^.RastPort,MyShipPtr^.Owner)
         else SetAPen(^MyScreen[1]^.RastPort,12);
         WritePixel(^MyScreen[1]^.RastPort,575+MyShipPtr^.PosX,62+MyShipPtr^.PosY);
         if (x in [0..480]) and (y in [0..480]) and (MyShipPtr^.SType<>TARGET_STARGATE) then begin
            BOX(MyScreen[1]^,x,y,x+31,y+31);
            if MyShipPtr^.SType=SHIPTYPE_FLEET then BOX(MyScreen[1]^,x+2,y+2,x+29,y+29);
            if MyShipPtr^.Flags=SHIPFLAG_WATER then begin
               WRITE(x+8,y+10,0,0,MyScreen[1]^,4,'W');
               WRITE(x+7,y+9,12,0,MyScreen[1]^,4,'W');
            end;
            if MyShipPtr^.Target=TARGET_POSITION then begin
               WRITE(x+11,y+10,0,0,MyScreen[1]^,4,'P');
               WRITE(x+10,y+9,12,0,MyScreen[1]^,4,'P');
            end;
         end;
      end;
      MyShipPtr:=MyShipPtr^.NextShip;
      if Leave=1 then Leave:=2;
      if (MyShipPtr=NIL) and (Leave=0) then begin
         MyShipPtr:=ActShipPtr;
         Leave:=1;
      end;
   end;
   if (SystemFlags[1,ActSys] and FLAG_CIV_MASK=0) then WRITE(200,491,12,0,MyScreen[1]^,4,Save.SystemName[ActSys])
   else WRITE(200,491,SystemFlags[1,ActSys] and FLAG_CIV_MASK,0,MyScreen[1]^,4,Save.SystemName[ActSys]);
   PRINTGLOBALINFOS(ActPlayer);
   if not Save.PlayMySelf then ScreenToFront(MyScreen[1]);
end;



procedure KLICKGAD(x,y :word);

begin
   ClipBlit(^MyScreen[1]^.RastPort,x,y,^XScreen^.RastPort,0,0,116,20,192);
   DrawImage(^MyScreen[1]^.RastPort,^GadImg2,x,y);
   PLAYSOUND(1,300);
   ClipBlit(^XScreen^.RastPort,0,0,^MyScreen[1]^.RastPort,x,y,116,20,192);
end;



function FINDOBJECT(ActSys :byte; GetX,GetY :integer; ExcludeObj :ptr):boolean;

var ActShipPtr          :^r_ShipHeader;
var x,y,i               :integer;
var PlanetHeader        :^r_PlanetHeader;
var j                   :byte;

begin
   FINDOBJECT:=true;
   ObjPtr:=NIL; ObjType:=0;
   i:=1;
   ActShipPtr:=ExcludeObj;
   if (SystemHeader[ActSys].FirstShip.SType=TARGET_STARGATE)
   and (ActShipPtr<>NIL) and (ActShipPtr^.SType<>TARGET_STARGATE) then begin
      x:=256+(SystemHeader[ActSys].FirstShip.PosX+OffsetX)*32;
      y:=256+(SystemHeader[ActSys].FirstShip.PosY+OffsetY)*32;
      if (GetX in [x..x+32]) and (GetY in [y..y+32]) and (PlanetHeader<>ExcludeObj) then begin
         ObjType:=TYPE_STARGATE; exit;
      end;
   end;
   repeat
      PlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(i)*sizeof(r_PlanetHeader));
      x:=256+round(PlanetHeader^.PosX+OffsetX)*32;
      y:=256+round(PlanetHeader^.PosY+OffsetY)*32;
      if (GetX in [x..x+32]) and (GetY in [y..y+32]) and (PlanetHeader<>ExcludeObj) then begin
         ObjType:=TYPE_PLANET; ObjPtr:=PlanetHeader; exit;
      end;
      i:=i+1;
   until (i>SystemHeader[ActSys].Planets);
   if SystemHeader[ActSys].FirstShip.NextShip<>NIL then begin
      ActShipPtr:=SystemHeader[ActSys].FirstShip.NextShip;
      repeat
         x:=256+(ActShipPtr^.PosX+OffsetX)*32;
         y:=256+(ActShipPtr^.PosY+OffsetY)*32;
         if (GetX in [x..x+32]) and (GetY in [y..y+32])
         and (ActShipPtr<>ExcludeObj)
         and (ActShipPtr^.Owner<>0)
         and (ActShipPtr^.Moving>=0) then begin
            ObjType:=TYPE_SHIP; ObjPtr:=ActShipPtr;
            exit;
         end;
         ActShipPtr:=ActShipPtr^.NextShip;
      until ActShipPtr=NIL;
   end;
   for i:=1 to MAXHOLES do with MyWormHole[i] do for j:=1 to 2 do if System[j]=ActSys then begin
      x:=256+(PosX[j]+OffsetX)*32;
      y:=256+(PosY[j]+OffsetY)*32;
      if (GetX in [x..x+32]) and (GetY in [y..y+32]) then begin
         ObjType:=TYPE_WORMHOLE; ObjPtr:=NIL;
         exit;
      end;
   end;
   FINDOBJECT:=false;
end;



procedure INITSTDTAGS;

begin
   Pens:=PenArr(0,0,0,0,0,0,0,0,0,0,0,0,0);
   ColSpec:=ColSpecArr(0,0,0,0,-1);
   Tags:=TagArr(SA_DisplayID,   ($9004+HelpID),
                SA_Interleaved, _TRUE,
                SA_DRAGGABLE,   _FALSE,
                SA_PENS,        addr(Pens),
                SA_COLORS,      addr(ColSpec),
                TAG_DONE,       0,0,0);
end;



function OPENMAINSCREENS:boolean;

var i   :byte;

begin
   IMemID:=false;
   OPENMAINSCREENS:=false;
   for i:=1 to 2 do MyScreen[i]:=NIL;
   for i:=1 to 2 do MyWindow[i]:=NIL;
   NeuScreen:=NewScreen(0,0,640,512,7,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   INITSTDTAGS;
   MyScreen[1]:=OpenScreenTagList(^NeuScreen,^Tags);
   if MyScreen[1]=NIL then exit;
   NeuScreen:=NewScreen(0,0,640,512,8,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   MyScreen[2]:=OpenScreenTagList(^NeuScreen,^Tags);
   if MyScreen[2]=NIL then exit;
   for i:=1 to 2 do with MyScreen[i]^ do begin
      BarHeight:=0;  WBorTop:=0; MenuVBorder:=0; MenuHBorder:=0;
   end;
   for i:=1 to 2 do begin
      NeuWindow:=NewWindow(0,0,640,512,0,0,RAWKEY,SIMPLE_REFRESH+BACKDROP+BORDERLESS,
                           NIL,NIL,'',MyScreen[i],NIL,640,512,640,512,CUSTOMSCREEN);
      MyWindow[i]:=OpenWindow(^NeuWindow);
      if MyWindow[i]=NIL then exit;
   end;
   OPENMAINSCREENS:=true;
end;



procedure UNPACK(Anfang,PackedD,Laenge :long; Mode :byte);

var Anz,Inh,Dest               :^byte;
var UnPackedD,l                :long;
var i                          :integer;


procedure LEVEL1;

begin
   UnPackedD:=Anfang;
   repeat
      Anz:=ptr(PackedD);   PackedD:=PackedD+1;
      if Anz^>127 then begin
         Anz^:=Anz^-127;
         CopyMem(PackedD,UnPackedD,Anz^);
         PackedD:=PackedD+Anz^;
         UnPackedD:=UnPackedD+Anz^;
      end else begin
         Inh:=ptr(PackedD);   PackedD:=PackedD+1;
         for i:=1 to Anz^ do begin
            Dest:=Ptr(UnPackedD); UnPackedD:=UnPackedD+1;
            Dest^:=Inh^;
         end;
      end;
   until (UnPackedD>=PackedD) or (UnPackedD>=Anfang+Laenge);
end;


begin
   if Mode=0 then SWITCHDISPLAY;
   UnPackedD:=Anfang;
   LEVEL1;
end;



function SETCOLOR(XScreen :Screen; FName :str):byte;

type r_Col=record;
        r,g,b   :byte
     end;

var AddrX,l,ISize       :long;
var i                   :integer;
var ColorID             :^long;
var Col                 :^r_Col;
var FHandle             :BPTR;

begin
   SETCOLOR:=0;
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   l:=DosSeek(FHandle,0,OFFSET_END);
   ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   l:=DosRead(FHandle,ptr(IMemA[0]),ISize);
   DosClose(FHandle);
   AddrX:=IMemA[0];
   repeat
      ColorID:=ptr(AddrX); AddrX:=AddrX+4;
   until (AddrX>=IMemA[0]+ISize) or (ColorID^=$434D4150);
   if ColorID^=$434D4150 then begin
      AddrX:=AddrX+4;
      i:=0;
      repeat
         Col:=ptr(AddrX); AddrX:=AddrX+3;
         SetRGB32(^XScreen.ViewPort,i,Col^.r*$1000000,Col^.g*$1000000,Col^.b*$1000000);
         i:=i+1;
      until (AddrX>=IMemA[0]+ISize);
      l:=(ISize-8) div 3;
      i:=0;
      repeat
         l:=l div 2; i:=i+1;
      until l<=1;
      SETCOLOR:=i;
   end;
end;



function RAWLOADIMAGE(Fn :str; LEdge,TEdge,Width,Height,Depth :integer; DestBitMap :ITBitMap):boolean;

type PLANEArr=array [0..7] of PLANEPTR;

var FName               :string[120];
var FHandle             :BPTR;
var CNum,i              :word;
var ISize,l,Addr        :long;
var Size,Colors         :^long;
var Valid               :boolean;
var MyBitMap            :BitMap;
var MyPLANEPTR          :PLANEArr;

begin
   RAWLOADIMAGE:=false;
   FName:=Fn;
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   ISize:=DosSeek(FHandle,0,OFFSET_END);
   ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   l:=DosRead(FHandle,ptr(IMemA[0]+IMemL[0]-ISize-250),ISize);
   DosClose(FHandle);
   l:=Width*Height;
   l:=l*Depth div 8;
   UNPACK(IMemA[0],IMemA[0]+IMemL[0]-ISize-250,l,0);
   if (l=DestBitMap.MemL) and (Depth=4) then CopyMemQuick(IMemA[0],DestBitMap.MemA,DestBitMap.MemL) else begin
      ISize:=(Width*Height) div 8;
      MyPLANEPTR:=PLANEArr(ptr(IMemA[0]),        ptr(IMemA[0]+ISize),  ptr(IMemA[0]+ISize*2),
                           ptr(IMemA[0]+ISize*3),ptr(IMemA[0]+ISize*4),ptr(IMemA[0]+ISize*5),
                           ptr(IMemA[0]+ISize*6),ptr(IMemA[0]+ISize*7));
      MyBitMap:=BitMap(Width div 8,Height,1,Depth,0,MyPLANEPTR);
      l:=BltBitMap(^MyBitMap,0,0,^DestBitMap,LEdge,TEdge,Width,Height,192,$FF,NIL);
   end;
   RAWLOADIMAGE:=true;
end;



function DISPLAYIMAGE(Fn :str; LEdge,TEdge,Width,Height,Depth :integer; XScreen :Screen, CacheNum :byte):boolean;

type r_RGB=record
        r,g,b   :byte;
     end;

var FName               :string[120];
var FHandle             :BPTR;
var CNum,i              :word;
var ISize,l,Addr        :long;
var Size,Colors         :^long;
var RGB                 :^r_RGB;
var Valid               :boolean;

begin
   DISPLAYIMAGE:=false;
   FName:=Fn;
   Valid:=false;
   IMemID:=false;
   if CacheNum>0 then if CacheMemA[CacheNum]>0 then Valid:=true;
   if not Valid then begin
      FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
      if FHandle=0 then exit;
      ISize:=DosSeek(FHandle,0,OFFSET_END);
      ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
      l:=DosRead(FHandle,ptr(IMemA[0]+IMemL[0]-ISize-250),ISize);
      l:=Width*Height;
      l:=l*Depth div 8;
      UNPACK(IMemA[0],IMemA[0]+IMemL[0]-ISize-250,l,0);
      DosClose(FHandle);
   end;
   Case Depth of
      2: CNum:=4;
      3: CNum:=8;
      4: CNum:=16;
      5: CNum:=32;
      6: CNum:=64;
      7: CNum:=128;
      8: CNum:=256;
      otherwise CNum:=1;
   end;
   if Valid then CopyMemQuick((CacheMemA[CacheNum]+CNum*3+8),IMemA[0],(CacheMemL[CacheNum]-CNum*3-8));
   Img:=Image(0,0,Width,Height,Depth,ptr(IMemA[0]),pred(CNum),0,NIL);
   DrawImage(^XScreen.RastPort,^Img,LEdge,TEdge);
   if (CacheNum>0) and not Valid then begin
      CacheMemL[CacheNum]:=l+CNum*3+8;
      CacheMemA[CacheNum]:=AllocMem(CacheMemL[CacheNum],MEMF_FAST);
      if CacheMemA[CacheNum]>0 then begin
         Addr:=CacheMemA[CacheNum];
         Size:=Ptr(Addr);   Size^:=l;      Addr:=Addr+4;
         Colors:=ptr(Addr); Colors^:=CNum; Addr:=Addr+4;
         FName[length(FName)-2]:=chr(0);
         FName:=FName+'pal';
         FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
         if FHandle<>0 then begin
            l:=DosSeek(FHandle,8,OFFSET_BEGINNING);
            l:=DosRead(FHandle,ptr(Addr),CNum*3);
            DosClose(FHandle);
         end;
         Addr:=Addr+CNum*3;
         CopyMemQuick(IMemA[0],Addr,Size^);
         Valid:=true;
      end else begin
         FName[length(FName)-2]:=chr(0);
         FName:=FName+'pal';
         l:=SETCOLOR(XScreen,FName);
      end;
   end;
   if Valid then begin
      Addr:=CacheMemA[CacheNum];
      Size:=Ptr(Addr);   Addr:=Addr+4;
      Colors:=ptr(Addr); Addr:=Addr+4;
      for i:=0 to pred(Colors^) do begin
         RGB:=ptr(Addr); Addr:=Addr+3;
         SetRGB32(^XScreen.ViewPort,i,RGB^.r*$1000000,RGB^.g*$1000000,RGB^.b*$1000000);
      end;
   end;
   DISPLAYIMAGE:=true;
end;



function OPENCINEMA(Depth :byte):ptr;

begin
   INITSTDTAGS;
   NeuScreen:=NewScreen(0,0,640,435,Depth,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   OPENCINEMA:=OpenScreenTagList(^NeuScreen,^Tags);
end;



procedure MAININTRO;

const ROTATE_PX=1;
const ROTATE_PY=2;
const ROTATE_PZ=4;
const ROTATE_NX=8;
const ROTATE_NY=16;
const ROTATE_NZ=32;

type r_RGB=record
        r,g,b   :byte;
     end;
type r_Coords=array [0..40] of real;
type StrArr=array [1..16] of str;
type FontArr=array [1..16] of byte;
type CArr=array[1..6] of real;
type PlaneArr=array [0..7] of PLANEPTR;

type VectorObj=record
        PosX,PosY               :integer;
        Flag,Size1,Size2        :byte;
        X1,Y1,Z1,X2,Y2,Z2       :CArr;
     end;

var Factor,SizeFactor,FactorCos,
    FactorSin,FactorMSin,
    FactorMCos                  :real;
var SArr                        :strArr;
var FArr                        :FontArr;
var i,j,k                       :integer;
var l,ISize                     :long;
var AScr,btx                    :byte;
var FHandle                     :BPTR;
var Col                         :^r_RGB;
var Colors                      :array [0..127] of r_RGB;
var MyRastPtr                   :ptr;
var MyTmpRas                    :TmpRas;
var MyAI                        :AreaInfo;
var VObj                        :array [1..13] of VectorObj;
var MyBitMap                    :BitMap;
var MyPlanePtr                  :PlaneArr;
var ShipX,ShipY,ShipZ           :r_Coords;
var LEdge,TEdge                 :array [1..2] of integer;
var SMemA,SMemL                 :array [1..3] of long;
var IntroBitMap                 :ITBitMap;


procedure SETDARKCOLOR(FName :str);

var AddrX,l,ISize       :long;
var i                   :integer;
var ColorID             :^long;
var FHandle             :BPTR;

begin
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   l:=DosSeek(FHandle,0,OFFSET_END);
   ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   l:=DosRead(FHandle,ptr(IMemA[0]),ISize);
   DosClose(FHandle);
   AddrX:=IMemA[0];
   repeat
      ColorID:=ptr(AddrX); AddrX:=AddrX+4;
   until (AddrX>=IMemA[0]+ISize) or (ColorID^=$434D4150);
   if ColorID^=$434D4150 then begin
      AddrX:=AddrX+4;
      i:=0;
      repeat
         Col:=ptr(AddrX); AddrX:=AddrX+3;
         Colors[i]:=Col^;
         SetRGB32(^MyScreen[1]^.ViewPort,i,0,0,0);
         SetRGB32(^MyScreen[2]^.ViewPort,i,0,0,0);
         i:=i+1;
      until (AddrX>=IMemA[0]+ISize);
   end;
   Colors[31]:=r_RGB(45,45,62)
end;



procedure INTROEXIT;

begin
   SWITCHDISPLAY;
   i:=SetTaskPri(FindTask(NIL),0);
   if MyRastPtr<>NIL then FreeRaster(MyRastPtr,640,360);
   MyRastPtr:=NIL;
   for i:=1 to 2 do if MyScreen[i]<>NIL then RECT(MyScreen[i]^,0,0,75,639,434);
   for i:=1 to 2 do if MyScreen[i]<>NIL then begin
      CloseScreen(MyScreen[i]); MyScreen[i]:=NIL;
   end;
   for i:=1 to 3 do if SMemA[i]>0 then begin
      FreeMem(SMemA[i],SMemL[i]);
      SMemA[i]:=0;
   end;
   for i:=0 to 1 do if IMemA[i]>0 then begin
      FreeMem(IMemA[i],IMemL[i]);
      IMemA[i]:=0;
   end;
   if TMPTR<>0 then begin
      StopPlayer;
      UnloadModule(TMPTR);
   end;
   TMPTR:=0;
   DMACON_WRITE^:=$000F;
end;


procedure ROTATEpX(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         Y1[i]:=Y1[i]*FactorCos-Z1[i]*FactorSin;
         Z1[i]:=Y1[i]*FactorSin+Z1[i]*FactorCos;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         Y2[i]:=Y2[i]*FactorCos-Z2[i]*FactorSin;
         Z2[i]:=Y2[i]*FactorSin+Z2[i]*FactorCos;
      end;
   end;
end;


procedure ROTATEpY(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         X1[i]:=X1[i]*FactorCos-Z1[i]*FactorSin;
         Z1[i]:=Z1[i]*FactorCos+X1[i]*FactorSin;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         X2[i]:=X2[i]*FactorCos-Z2[i]*FactorSin;
         Z2[i]:=Z2[i]*FactorCos+X2[i]*FactorSin;
      end;
   end;
end;


procedure ROTATEpZ(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         X1[i]:=X1[i]*FactorCos-Y1[i]*FactorSin;
         Y1[i]:=X1[i]*FactorSin+Y1[i]*FactorCos;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         X2[i]:=X2[i]*FactorCos-Y2[i]*FactorSin;
         Y2[i]:=X2[i]*FactorSin+Y2[i]*FactorCos;
      end;
   end;
end;


procedure ROTATEnX(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         Y1[i]:=Y1[i]*FactorMCos-Z1[i]*FactorMSin;
         Z1[i]:=Y1[i]*FactorMSin+Z1[i]*FactorMCos;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         Y2[i]:=Y2[i]*FactorMCos-Z2[i]*FactorMSin;
         Z2[i]:=Y2[i]*FactorMSin+Z2[i]*FactorMCos;
      end;
   end;
end;


procedure ROTATEnY(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         X1[i]:=X1[i]*FactorMCos-Z1[i]*FactorMSin;
         Z1[i]:=Z1[i]*FactorMCos+X1[i]*FactorMSin;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         X2[i]:=X2[i]*FactorMCos-Z2[i]*FactorMSin;
         Z2[i]:=Z2[i]*FactorMCos+X2[i]*FactorMSin;
      end;
   end;
end;


procedure ROTATEnZ(k :byte);
var i   :byte;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         X1[i]:=X1[i]*FactorMCos-Y1[i]*FactorMSin;
         Y1[i]:=X1[i]*FactorMSin+Y1[i]*FactorMCos;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         X2[i]:=X2[i]*FactorMCos-Y2[i]*FactorMSin;
         Y2[i]:=X2[i]*FactorMSin+Y2[i]*FactorMCos;
      end;
   end;
end;


procedure FLY(k :byte);
var i,j   :integer;
begin
   with VObj[k] do begin
      if Size1=0 then exit else for i:=1 to Size1 do begin
         X1[i]:=X1[i]*Factor;
         Y1[i]:=Y1[i]*Factor;
         Z1[i]:=Z1[i]*Factor;
         if not (round(PosX-X1[i]) in [0..639])
         or not (round(PosY-Y1[i]) in [75..434]) then begin
            Size1:=0; exit;
         end;
      end;
      if Size2=0 then exit else for i:=1 to Size2 do begin
         X2[i]:=X2[i]*Factor;
         Y2[i]:=Y2[i]*Factor;
         Z2[i]:=Z2[i]*Factor;
         if not (round(PosX-X2[i]) in [0..639])
         or not (round(PosY-Y2[i]) in [75..434]) then begin
            Size1:=0; exit;
         end;
      end;
   end;
end;


procedure GREATEFFECT(Objects :byte);

var Ctr         :word;

begin
   WaitTOF;
   Factor:=0; Ctr:=0;
   repeat
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      Factor:=Factor+0.02; Ctr:=Ctr+1;
      for i:=1 to 31 do
       SetRGB32(^MyScreen[AScr]^.ViewPort,i,round(Colors[i].R*Factor)*$1000000,round(Colors[i].G*Factor)*$1000000,round(Colors[i].B*Factor)*$1000000);
      if Ctr=11 then begin
         SPAddrD^:=SMemA[2];         SPAddrC^:=SMemA[2]+SMemL[2] div 2;
         SPVolD^:=64;                SPVolC^:=64;
         SPFreqD^:=380;              SPFreqC^:=380;
         SPLengthD^:=SMemL[2] div 4; SPLengthC^:=SMemL[2] div 4;
         DMACON_WRITE^:=$800C;
      end else if Ctr=12 then begin
         SPLengthD^:=1;              SPLengthC^:=1;
      end;
   until Factor>=1;
   SetRGB4(^MyScreen[3-AScr]^.ViewPort,0,8,8,10);
   WaitTOF;
   WaitTOF;
   SetRGB4(^MyScreen[3-AScr]^.ViewPort,0,0,0,0);
   for i:=1 to 31 do SetRGB32(^MyScreen[3-AScr]^.ViewPort,i,Colors[i].R*$1000000,Colors[i].G*$1000000,Colors[i].B*$1000000);
   delay(50);
   repeat
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      Factor:=Factor-0.02;
      SetRGB32(^MyScreen[AScr]^.ViewPort,31,round(Colors[31].R*Factor)*$1000000,round(Colors[31].G*Factor)*$1000000,round(Colors[31].B*Factor)*$1000000);
   until Factor<=0;
   for i:=1 to Objects do with VObj[i] do begin
      for j:=1 to Size1 do PosX:=round(PosX+X1[j]); PosX:=round(PosX/Size1);
      for j:=1 to Size1 do PosY:=round(PosY+Y1[j]); PosY:=235+round(PosY/Size1);
      for j:=1 to Size1 do X1[j]:=succ(PosX)-X1[j];
      for j:=1 to Size1 do Y1[j]:=succ(PosY)-Y1[j]-235;
      if Size2>0 then for j:=1 to Size2 do X2[j]:=succ(PosX)-X2[j];
      if Size2>0 then for j:=1 to Size2 do Y2[j]:=succ(PosY)-Y2[j]-235;
   end;
   SPAddrD^:=SMemA[3];         SPAddrC^:=SMemA[3]+SMemL[3] div 2;
   SPVolD^:=64;                SPVolC^:=64;
   SPFreqD^:=550;              SPFreqC^:=550;
   SPLengthD^:=SMemL[3] div 4; SPLengthC^:=SMemL[3] div 4;
   DMACON_WRITE^:=$800C;
   Factor:=1.0025;
   for i:=1 to 29 do begin
      Factor:=Factor+0.004;
      if i>1 then begin
         SetAPen(^MyScreen[AScr]^.RastPort,0);
         RectFill(^MyScreen[AScr]^.RastPort,0,150,639,330);    {75..434}
      end else for j:=2 to 30 do SetRGB32(^MyScreen[AScr]^.ViewPort,j,Colors[j].R*$A00000,Colors[j].G*$A00000,Colors[j].B*$A00000);
      if i>16 then VObj[succ(random(13))].Size1:=0;

      for j:=1 to Objects do with VObj[j] do begin
         if Size1>0 then begin
            if j>2 then begin
               SetAPen(^MyScreen[AScr]^.RastPort,0);
               if Size2>4 then begin
                  AreaMove(^MyScreen[AScr]^.RastPort,round(PosX-X2[4]),round(PosY-Y2[4]));
                  for k:=5 to 6 do AreaDraw(^MyScreen[AScr]^.RastPort,round(PosX-X2[k]),round(PosY-Y2[k]));
               end;
               AreaMove(^MyScreen[AScr]^.RastPort,round(PosX-X1[4]),round(PosY-Y1[4]));
               for k:=5 to 6 do AreaDraw(^MyScreen[AScr]^.RastPort,round(PosX-X1[k]),round(PosY-Y1[k]));
               AreaEnd(^MyScreen[AScr]^.RastPort);
            end;
            SetAPen(^MyScreen[AScr]^.RastPort,1);
            AreaMove(^MyScreen[AScr]^.RastPort,round(PosX-X1[1]),round(PosY-Y1[1]));
            for k:=2 to Size1 do AreaDraw(^MyScreen[AScr]^.RastPort,round(PosX-X1[k]),round(PosY-Y1[k]));
            AreaEnd(^MyScreen[AScr]^.RastPort);
            if Size2>0 then begin
               AreaMove(^MyScreen[AScr]^.RastPort,round(PosX-X2[1]),round(PosY-Y2[1]));
               for k:=2 to Size2 do AreaDraw(^MyScreen[AScr]^.RastPort,round(PosX-X2[k]),round(PosY-Y2[k]));
               AreaEnd(^MyScreen[AScr]^.RastPort);
            end;
         end;
         if not (Flag and ROTATE_PX=0) then ROTATEpX(j);
         if not (Flag and ROTATE_PY=0) then ROTATEpY(j);
         if not (Flag and ROTATE_PZ=0) then ROTATEpZ(j);
         if not (Flag and ROTATE_NX=0) then ROTATEnX(j);
         if not (Flag and ROTATE_NY=0) then ROTATEnY(j);
         if not (Flag and ROTATE_NZ=0) then ROTATEnZ(j);
         FLY(j);
      end;
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      if i=1 then begin
         SPLengthD^:=1; SPLengthC^:=1;
      end;
   end;
   for i:=1 to 2 do begin
      SetAPen(^MyScreen[AScr]^.RastPort,0);
      RectFill(^MyScreen[AScr]^.RastPort,0,75,639,434);
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
   end;
   DMACON_WRITE^:=$000C;
end;


function LOADSOUNDS:boolean;

var i           :byte;
var SSize       :long;

begin
   LOADSOUNDS:=false;
   INITCHANNELS;
   for i:=1 to 3 do begin
      s:=PathStr[8]+'Snd'+intstr(i)+'.RAW';
      FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
      if FHandle<>0 then begin
         SSize:=DosSeek(FHandle,0,OFFSET_END);
         SSize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
         SMemL[i]:=SSize;
         SMemA[i]:=AllocMem(SSize,MEMF_CHIP+MEMF_CLEAR);
         if SMemA[i]=0 then exit;
         l:=DosRead(FHandle,ptr(SMemA[i]),SMemL[i]);
         DosClose(FHandle);
      end else exit;
   end;
   LOADSOUNDS:=true;
end;


begin { MAININTRO }
   i:=SetTaskPri(FindTask(NIL),120);
   TMPtr:=0; AScr:=1; MyRastPtr:=NIL;
   for i:=1 to 2 do MyScreen[i]:=NIL;
   for i:=1 to 3 do SMemA[i]:=0;
   for i:=0 to 1 do IMemA[i]:=0;
   if not LOADSOUNDS then begin
      INTROEXIT;
      exit;
   end;
   for i:=1 to 2 do begin
      MyScreen[i]:=OPENCINEMA(5);
      if MyScreen[i]=NIL then begin
         INTROEXIT;
         exit;
      end;
   end;
   IMemL[0]:=73500;
   IMemA[0]:=AllocMem(IMemL[0],MEMF_CHIP);
   if IMemA[0]=0 then begin
      INTROEXIT;
      exit;
   end;
    IntroBitMap:=ITBitMap(80,183,1,5,0,ptr(IMemA[0]),ptr(IMemA[0]+14640),
                         ptr(IMemA[0]+29280),ptr(IMemA[0]+43920),
                         ptr(IMemA[0]+58560),NIL,NIL,NIL,IMemA[0],IMemL[0]);
   s:=PathStr[8]+'Frame0.pal';
   l:=SETCOLOR(MyScreen[1]^,s);
   l:=SETCOLOR(MyScreen[2]^,s);
   s:=PathStr[8]+'Frame0.img';
   if not RAWLOADIMAGE(s,0,0,640,183,5,IntroBitMap) then begin
      INTROEXIT;
      exit;
   end;
   for i:=1 to 8 do begin
      BltBitMapRastPort(^IntroBitMap,0,0,^MyScreen[3-AScr]^.RastPort,640-i*5,340,i*5,90,192);
      AScr:=3-Ascr; ScreenToFront(MyScreen[Ascr]);
   end;
   l:=590;
   repeat
      l:=l-5;
      BltBitMapRastPort(^IntroBitMap,0,0,^MyScreen[3-AScr]^.RastPort,l,340,49,90,192);
      BltBitMapRastPort(^IntroBitMap,41,0,^MyScreen[3-Ascr]^.RastPort,l+49,340,5,90,192);
      AScr:=3-Ascr; ScreenToFront(MyScreen[Ascr]);
      if LData^ and 64=0 then begin
         INTROEXIT; exit;
      end;
   until l<=10;
   ClipBlit(^MyScreen[Ascr]^.RastPort,10,340,^MyScreen[3-Ascr]^.RastPort,10,340,50,90,192);
   for i:=1 to 9 do begin
      BltBitMapRastPort(^IntroBitMap,50,0,^MyScreen[3-AScr]^.RastPort,640-i*5,340,i*5,90,192);
      AScr:=3-Ascr; ScreenToFront(MyScreen[Ascr]);
   end;
   l:=595;
   SetAPen(^MyScreen[AScr]^.RastPort,0); SetAPen(^MyScreen[3-AScr]^.RastPort,0);
   repeat
      l:=l-5;
      BltBitMapRastPort(^IntroBitMap,50,0,^MyScreen[3-AScr]^.RastPort,l,340,41,90,192);
      RectFill(^MyScreen[3-AScr]^.RastPort,l+41,340,l+50,430);
      AScr:=3-Ascr; ScreenToFront(MyScreen[Ascr]);
      if LData^ and 64=0 then begin
         INTROEXIT; exit;
      end;
   until l<=60;
   ClipBlit(^MyScreen[AScr]^.RastPort,10,340,^MyScreen[3-Ascr]^.RastPort,10,340,150,90,192);
   delay(5);
   for i:=1 to 2 do begin
      BltBitMapRastPort(^IntroBitMap,0,0,^MyScreen[3-AScr]^.RastPort,10,340,616,91,192);
      AScr:=3-Ascr;
      ScreenToFront(MyScreen[Ascr]);
   end;
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   delay(15);
   BltBitMapRastPort(^IntroBitMap,0,90,^MyScreen[3-AScr]^.RastPort,10,337,98,91,192);
   AScr:=3-Ascr;
   ScreenToFront(MyScreen[Ascr]);
   DMACON_WRITE^:=$000F;
   delay(15);
   SPAddrA^:=SMemA[1];         SPAddrB^:=SMemA[1]+SMemL[1] div 2;
   SPVolA^:=0;                 SPVolB^:=0;
   SPFreqA^:=856;              SPFreqB^:=856;
   SPLengthA^:=SMemL[1] div 4; SPLengthB^:=SMemL[1] div 4;

   SPAddrD^:=SMemA[2];         SPAddrC^:=SMemA[2]+SMemL[2] div 2;
   SPVolD^:=64;                SPVolC^:=64;
   SPFreqD^:=380;              SPFreqC^:=380;
   SPLengthD^:=1;              SPLengthC^:=1;

   DMACON_WRITE^:=$8003;
   for btx:=1 to 64 do begin
      SPVolA^:=btx;
      SPVolB^:=btx;
      WaitTOF;
   end;
   delay(25);
   FactorSin:=sin(0.04);   FactorCos:=cos(0.03);
   FactorMSin:=sin(-0.05); FactorMCos:=cos(-0.02);
   for i:=1 to 2 do begin
      SetAPen(^MyScreen[3-Ascr]^.RastPort,0);
      RectFill(^MyScreen[3-Ascr]^.RastPort,0,335,640,430);
      AScr:=3-Ascr;
      ScreenToFront(MyScreen[Ascr]);
   end;

   MyRastPtr:=AllocRaster(640,360);
   if MyRastPtr=NIL then begin
      INTROEXIT;
      exit;
   end;
   InitTmpRas(^MyTmpRas,MyRastPtr,21000);
   InitArea(^MyAI,ptr(IMemA[0]),200);
   MyScreen[1]^.RastPort.TmpRas:=^MyTmpRas; MyScreen[2]^.RastPort.TmpRas:=^MyTmpRas;
   MyScreen[1]^.RastPort.AreaInfo:=^MyAI;   MyScreen[2]^.RastPort.AreaInfo:=^MyAI;

{*****************************************************************************}

   s:=PathStr[8]+'Frame1.pal';         { TOUCHBYTE SOWFTWARE PRESENTS }
   SETDARKCOLOR(s);
   s:=PathStr[8]+'Frame1.img';
   if not DISPLAYIMAGE(s,0,235,640,37,5,MyScreen[AScr]^,0) then begin end;
   WRITE(320,285,31,16,MyScreen[AScr]^,5,'PRESENTS');
   ClipBlit(^MyScreen[AScr]^.RastPort,0,235,^MyScreen[3-AScr]^.RastPort,0,235,640,75,192);
   VObj[1]:=VectorObj(0,0,ROTATE_PY+ROTATE_PX,
      { T }           6,4,CArr(38,9,9,9,9,38),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(18,18,18,18,0,0),CArr(11,36,36,11,0,0),CArr(1,1,3,3,0,0));
   VObj[2]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { U }           6,6,CArr(91,80,80,80,80,91),CArr(1,1,26,26,1,1),CArr(1,1,1,3,3,3),
                          CArr(111,100,100,100,100,111),CArr(1,1,24,24,1,1),CArr(1,1,1,3,3,3));
   VObj[3]:=VectorObj(0,0,ROTATE_PY+ROTATE_NZ,
      { H }           6,6,CArr(163,152,152,152,152,163),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(184,173,173,173,173,184),CArr(2,2,12,12,2,2),CArr(1,1,1,3,3,3));
   VObj[4]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { B }           6,6,CArr(209,187,187,187,187,209),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(205,187,187,187,187,205),CArr(15,15,36,36,15,15),CArr(1,1,1,3,3,3));
   VObj[5]:=VectorObj(0,0,ROTATE_PZ+ROTATE_NX,
      { Y }           6,6,CArr(229,217,229,229,217,229),CArr(2,2,19,19,2,2),CArr(1,1,1,3,3,3),
                          CArr(254,242,236,236,242,254),CArr(2,2,12,12,2,2),CArr(1,1,1,3,3,3));
   VObj[6]:=VectorObj(0,0,ROTATE_NX+ROTATE_NY,
      { T }           6,4,CArr(285,256,256,256,256,285),CArr(2,2,9,9,1,1),CArr(1,1,1,3,3,3),
                          CArr(266,266,266,266,0,0),CArr(11,36,36,11,0,0),CArr(1,1,3,3,0,0));
   VObj[7]:=VectorObj(0,0,ROTATE_PX+ROTATE_PY,
      { E }           6,6,CArr(318,289,289,289,289,318),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(315,289,289,289,289,315),CArr(14,14,36,36,14,14),CArr(1,1,1,3,3,3));
   VObj[8]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { F }           6,6,CArr(440,410,410,410,410,440),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(437,410,410,410,410,437),CArr(14,14,36,36,14,14),CArr(1,1,1,3,3,3));
   VObj[9]:=VectorObj(0,0,ROTATE_NZ+ROTATE_NY,
      { T }           6,4,CArr(472,443,443,443,443,472),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(452,452,452,452,0,0),CArr(11,36,36,11,0,0),CArr(1,1,3,3,0,0));
   VObj[10]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { W }            6,6,CArr(486,475,486,486,475,486),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                           CArr(506,497,492,492,497,506),CArr(2,2,16,16,2,2),CArr(1,1,1,3,3,3));
   VObj[11]:=VectorObj(0,0,ROTATE_PX+ROTATE_PY,
      { A }            6,0,CArr(547,536,521,521,536,547),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[12]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { R }            6,6,CArr(589,565,565,565,565,589),CArr(3,2,10,10,2,3),CArr(1,1,1,3,3,3),
                           CArr(576,565,565,565,565,576),CArr(16,16,36,36,16,16),CArr(1,1,1,3,3,3));
   VObj[13]:=VectorObj(0,0,ROTATE_NX+ROTATE_NY,
      { E }            6,6,CArr(630,601,601,601,601,630),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                           CArr(627,601,601,601,601,627),CArr(14,14,36,36,14,14),CArr(1,1,1,3,3,3));

   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   GREATEFFECT(13);
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;

{*****************************************************************************}

   s:=PathStr[8]+'Frame2.pal';         { A VIRTUAL WORLDS PRODUCTION }
   SETDARKCOLOR(s);
   s:=PathStr[8]+'Frame2.img';
   if not DISPLAYIMAGE(s,0,235,640,37,5,MyScreen[AScr]^,0) then begin end;
   WRITE(320,205,31,16,MyScreen[AScr]^,5,'A');
   WRITE(320,285,31,16,MyScreen[AScr]^,5,'PRODUCTION');
   ClipBlit(^MyScreen[AScr]^.RastPort,0,200,^MyScreen[3-AScr]^.RastPort,0,200,640,100,192);
   VObj[1]:=VectorObj(0,0,ROTATE_PY+ROTATE_PX,
      { V }           6,6,CArr(98,86,101,101,86,98),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(126,114,106,106,114,126),CArr(2,2,23,23,2,2),CArr(1,1,1,3,3,3));
   VObj[2]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { I }           6,0,CArr(140,129,129,129,129,140),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[3]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { R }           6,6,CArr(167,143,143,143,143,167),CArr(3,2,10,10,2,3),CArr(1,1,1,3,3,3),
                          CArr(154,143,143,143,143,154),CArr(16,16,36,36,16,16),CArr(1,1,1,3,3,3));
   VObj[4]:=VectorObj(0,0,ROTATE_PY+ROTATE_NZ,
      { T }           6,4,CArr(206,177,177,177,177,206),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(186,186,186,186,0,0),CArr(11,36,36,11,0,0),CArr(1,1,3,3,0,0));
   VObj[5]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { U }           6,6,CArr(220,209,209,209,209,220),CArr(2,2,27,27,2,2),CArr(1,1,1,3,3,3),
                          CArr(240,229,229,229,229,240),CArr(2,2,25,25,2,2),CArr(1,1,1,3,3,3));
   VObj[6]:=VectorObj(0,0,ROTATE_PZ+ROTATE_NX,
      { A }           6,0,CArr(266,255,240,240,255,266),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[7]:=VectorObj(0,0,ROTATE_NX+ROTATE_NY,
      { L }           6,4,CArr(295,284,284,284,284,295),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(311,296,296,311,0,0),CArr(26,26,26,26,0,0),CArr(1,1,3,3,0,0));
   VObj[8]:=VectorObj(0,0,ROTATE_PX+ROTATE_PY,
      { W }           6,6,CArr(335,324,335,335,324,335),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(355,346,341,341,346,355),CArr(2,2,16,16,2,2),CArr(1,1,1,3,3,3));
   VObj[9]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { R }           6,6,CArr(441,417,417,417,417,441),CArr(3,2,10,10,2,3),CArr(1,1,1,3,3,3),
                          CArr(428,417,417,417,417,428),CArr(16,16,36,36,16,16),CArr(1,1,1,3,3,3));
   VObj[10]:=VectorObj(0,0,ROTATE_NZ+ROTATE_NY,
      { L }            6,4,CArr(464,453,453,453,453,464),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                           CArr(480,465,465,480,0,0),CArr(26,26,26,26,0,0),CArr(1,1,3,3,0,0));
   VObj[11]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { D }            6,0,CArr(505,483,483,483,483,505),CArr(3,2,36,36,2,3),CArr(1,1,1,3,3,3),
                           CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   GREATEFFECT(11);
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
{*****************************************************************************}

   s:=PathStr[8]+'Frame3.pal';         { IMPERIUM TERRANUM }
   SETDARKCOLOR(s);
   s:=PathStr[8]+'Frame3.img';
   if not DISPLAYIMAGE(s,0,235,640,37,5,MyScreen[AScr]^,0) then begin end;
   ClipBlit(^MyScreen[AScr]^.RastPort,0,235,^MyScreen[3-AScr]^.RastPort,0,235,640,37,192);
   VObj[1]:=VectorObj(0,0,ROTATE_PY+ROTATE_PX,
      { I }           6,6,CArr(48,37,37,37,37,48),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(95,84,73,73,84,95),CArr(2,2,18,18,2,2),CArr(1,1,1,3,3,3));
   VObj[2]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { M }           6,0,CArr(62,51,51,51,51,62),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[3]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { E }           6,6,CArr(161,132,132,132,132,161),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(158,132,132,132,132,158),CArr(14,14,36,36,14,14),CArr(1,1,1,3,3,3));
   VObj[4]:=VectorObj(0,0,ROTATE_PY+ROTATE_NZ,
      { I }           6,0,CArr(211,200,200,200,200,211),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[5]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { U }           6,6,CArr(225,214,214,214,214,225),CArr(2,2,27,27,2,2),CArr(1,1,1,3,3,3),
                          CArr(245,234,234,234,234,245),CArr(2,2,25,25,2,2),CArr(1,1,1,3,3,3));
   VObj[6]:=VectorObj(0,0,ROTATE_PZ+ROTATE_NX,
      { M }           6,6,CArr(259,248,248,248,248,259),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                          CArr(292,281,270,270,281,292),CArr(2,2,18,18,2,2),CArr(1,1,1,3,3,3));
   VObj[7]:=VectorObj(0,0,ROTATE_NX+ROTATE_NY,
      { T }           6,4,CArr(338,309,309,309,309,338),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(318,318,318,318,0,0),CArr(21,36,36,11,0,0),CArr(1,1,3,3,0,0));
   VObj[8]:=VectorObj(0,0,ROTATE_PX+ROTATE_PY,
      { E }           6,6,CArr(370,341,341,341,341,370),CArr(2,2,10,10,2,2),CArr(1,1,1,3,3,3),
                          CArr(367,341,341,341,341,367),CArr(14,14,36,36,14,14),CArr(1,1,1,3,3,3));
   VObj[9]:=VectorObj(0,0,ROTATE_NX+ROTATE_PZ,
      { R }           6,6,CArr(433,409,409,409,409,433),CArr(3,2,10,10,2,3),CArr(1,1,1,3,3,3),
                          CArr(420,409,409,409,409,420),CArr(16,16,36,36,16,16),CArr(1,1,1,3,3,3));
   VObj[10]:=VectorObj(0,0,ROTATE_NZ+ROTATE_NY,
      { A }            6,0,CArr(471,460,445,445,460,471),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                           CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0),CArr(0,0,0,0,0,0));
   VObj[11]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { N }            6,6,CArr(500,489,489,489,489,500),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                           CArr(521,510,510,510,510,521),CArr(2,2,17,17,2,2),CArr(1,1,1,3,3,3));
   VObj[12]:=VectorObj(0,0,ROTATE_PX+ROTATE_PZ,
      { M }            6,6,CArr(569,558,558,558,558,569),CArr(2,2,36,36,2,2),CArr(1,1,1,3,3,3),
                           CArr(602,591,580,580,591,602),CArr(2,2,18,18,2,2),CArr(1,1,1,3,3,3));
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   GREATEFFECT(12);
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   FreeRaster(MyRastPtr,640,360); MyRastPtr:=NIL;
   for i:=1 to 2 do if MyScreen[i]<>NIL then begin
      CloseScreen(MyScreen[i]); MyScreen[i]:=NIL;
   end;
   FreeMem(IMemA[0],IMemL[0]); IMemA[0]:=0;

   for i:=1 to 2 do begin
      MyScreen[i]:=OPENCINEMA(7);
      if MyScreen[i]=NIL then begin
         INTROEXIT; exit;
      end;
   end;
   IMemL[0]:=201856; IMemL[1]:=21000;
   for i:=0 to 1 do begin
      IMemA[i]:=AllocMem(IMemL[i],MEMF_CHIP);
      if IMemA[i]=0 then begin
         INTROEXIT;
         exit;
      end;
   end;
   SPAddrD^:=SMemA[2]+6500;            SPAddrC^:=SMemA[2]+(SMemL[2] div 2)+6500;
   SPVolD^:=64;                        SPVolC^:=64;
   SPFreqD^:=380;                      SPFreqC^:=380;
   SPLengthD^:=(SMemL[2]-13000) div 4; SPLengthC^:=(SMemL[2]-13000) div 4;
   DMACON_WRITE^:=$800C;
   WaitTOF;
   SPLengthD^:=1; SPLengthC^:=1;
   btx:=255;
   repeat
      SetRGB32(^MyScreen[2]^.ViewPort,0,btx*$1000000,btx*$1000000,btx*$1000000);
      btx:=btx-5;
      WaitTOF;
   until btx<=10;
   SetRGB32(^MyScreen[2]^.ViewPort,0,0,0,0);
   DMACON_WRITE^:=$000C;
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   s:=PathStr[8]+'MOD.Intro';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle<>0 then DosClose(FHandle);
   TMPTR:=LoadModule(s);
   PlayModule(TMPTR);
   s:=PathStr[8]+'Frame4.pal';
   SETDARKCOLOR(s);
   s:=PathStr[8]+'Frame4.img';
   if not DISPLAYIMAGE(s,0,75,640,360,7,MyScreen[2]^,0) then begin end;
   ClipBlit(^MyScreen[2]^.RastPort,0,75,^MyScreen[1]^.RastPort,0,75,640,360,192);

   s:=PathStr[8]+'Frame5.img';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle<>0 then begin
      ISize:=DosSeek(FHandle,0,OFFSET_END);
      ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
      l:=DosRead(FHandle,ptr(IMemA[0]+IMemL[0]-ISize-250),ISize);
      UNPACK(IMemA[0],IMemA[0]+IMemL[0]-ISize-250,20160,0);
      DosClose(FHandle);
   end;
   MyPlanePtr:=PlaneArr(ptr(IMemA[0]),      ptr(IMemA[0]+2880), ptr(IMemA[0]+5760),
                        ptr(IMemA[0]+8640), ptr(IMemA[0]+11520),ptr(IMemA[0]+14400),
                        ptr(IMemA[0]+17280),NIL);
   MyBitMap:=BitMap(20,144,1,7,0,MyPlanePtr);

   Factor:=0;
   repeat
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      Factor:=Factor+0.05;
      for i:=1 to 127 do
       SetRGB32(^MyScreen[AScr]^.ViewPort,i,round(Colors[i].R*Factor)*$1000000,round(Colors[i].G*Factor)*$1000000,round(Colors[i].B*Factor)*$1000000);
   until Factor>=1;
   for i:=1 to 127 do SetRGB32(^MyScreen[3-AScr]^.ViewPort,i,Colors[i].R*$1000000,Colors[i].G*$1000000,Colors[i].B*$1000000);
   ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,75,639,434);
   for i:=1 to 6 do begin
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-8,0,75,639,434);
      ClipBlit(^MyScreen[AScr]^.RastPort,0,270,^MyScreen[AScr]^.RastPort,0,75,640,8,192);
   end;
   for i:=1 to 35 do begin
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-8,0,75,639,434);
      ClipBlit(^MyScreen[AScr]^.RastPort,0,270,^MyScreen[AScr]^.RastPort,0,75,640,8,192);
      BltBitMapRastPort(^MyBitMap,0,140-i*4,^MyScreen[AScr]^.RastPort,380,75,160,8,192);
   end;
   ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
   ScrollRaster(^MyScreen[AScr]^.RastPort,0,-8,0,75,639,434);
   ClipBlit(^MyScreen[AScr]^.RastPort,0,270,^MyScreen[AScr]^.RastPort,0,75,640,8,192);
   BltBitMapRastPort(^MyBitMap,0,0,^MyScreen[AScr]^.RastPort,380,79,160,4,192);
   for i:=1 to 14 do begin
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-8,0,75,639,434);
      ClipBlit(^MyScreen[AScr]^.RastPort,0,270,^MyScreen[AScr]^.RastPort,0,75,640,8,192);
   end;
   delay(10);
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   RECT(MyScreen[AScr]^,0,0,75,639,434);
   ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
   RECT(MyScreen[AScr]^,0,0,75,639,434);
   s:=PathStr[8]+'Frame6.pal';
   l:=SETCOLOR(MyScreen[AScr]^,s);                  l:=SETCOLOR(MyScreen[3-AScr]^,s);
   SetRGB4(^MyScreen[AScr]^.ViewPort,127,9,9,11);   SetRGB4(^MyScreen[3-AScr]^.ViewPort,127,9,9,11);
   SetRGB4(^MyScreen[AScr]^.ViewPort,126,11,11,15); SetRGB4(^MyScreen[3-AScr]^.ViewPort,126,11,11,15);
   SetRGB4(^MyScreen[AScr]^.ViewPort,125,15,0,15);  SetRGB4(^MyScreen[3-AScr]^.ViewPort,125,15,0,15);
   SetRGB4(^MyScreen[AScr]^.ViewPort,124,13,0,0);   SetRGB4(^MyScreen[3-AScr]^.ViewPort,124,15,2,2);
   SetRGB4(^MyScreen[AScr]^.ViewPort,123,14,14,15); SetRGB4(^MyScreen[3-AScr]^.ViewPort,123,14,14,15);

   s:=PathStr[8]+'Frame6.img';
   if not DISPLAYIMAGE(s,0,75,640,360,7,MyScreen[AScr]^,0) then begin end;
   MyPlanePtr:=PlaneArr(ptr(IMemA[0]),       ptr(IMemA[0]+28800), ptr(IMemA[0]+57600),
                        ptr(IMemA[0]+86400), ptr(IMemA[0]+115200),ptr(IMemA[0]+144000),
                        ptr(IMemA[0]+172800),NIL);
   MyBitMap:=BitMap(80,360,1,7,0,MyPlanePtr);
   BltBitMapRastPort(^MyBitMap,0,0,^MyScreen[3-AScr]^.RastPort,0,75,640,360,192);


   MyRastPtr:=AllocRaster(640,360);
   if MyRastPtr=NIL then begin
      INTROEXIT;
      exit;
   end;
   InitTmpRas(^MyTmpRas,MyRastPtr,21000);
   InitArea(^MyAI,ptr(IMemA[1]),200);
   MyScreen[1]^.RastPort.TmpRas:=^MyTmpRas; MyScreen[2]^.RastPort.TmpRas:=^MyTmpRas;
   MyScreen[1]^.RastPort.AreaInfo:=^MyAI;   MyScreen[2]^.RastPort.AreaInfo:=^MyAI;

  SArr:=StrArr('Software & Design',                 'Oxygenic',
               'Art Director',                      'Cybertrace',
               'Music by',                          'Ludwig v.Beethoven   N.N. Ikonnikow   Richard Wagner',
               'Special Effects',                   'Oxygenic',
               'Credits go to',                     'Adam Benjamin   Rikard Cederlund',
               'Jakob Gaardsted   Andy Jones',      'George Moore',
               'Surround-Sounds created with',      'WaveTracer DS®',
               'Colors in Technicolor®',            'Panaflex® Camera and Lenses by Panavision®');
   FArr:=FontArr(4,5, 4,5, 4,5, 4,5, 4,5,  5,5, 4,5, 4,4);

   ShipX:=r_Coords( 390, 264,252,186,186,192,256,290,354,360,360,294,282, 252, 256, 290,294, 282,294,294, 258,265,273,281,288, 185,185,190,190, 356,356,361,361,0,0,0,0,0,0,0,0);
   ShipY:=r_Coords( 315, 174,275,250,188,225,234,234,225,188,250,275,174, 275, 243, 243,275, 174,275,275, 269,342,269,342,269, 187,172,172,187, 187,172,172,187,0,0,0,0,0,0,0,0);
   ShipZ:=r_Coords(-2.5,  -5, -1, -5, -5, -5, -1, -1, -5, -5, -5, -1, -5,  -1,-1.1,-1.1, -1,  -5, -8, -1,  -2, -2, -2, -2, -2,  -5, -5, -5, -5,  -5, -5, -5, -5,0,0,0,0,0,0,0,0);

   for i:=1 to 40 do begin
      ShipX[i]:=273-ShipX[i]; ShipY[i]:=257-ShipY[i];
   end;
   FactorSin:=sin(0.45); FactorCos:=cos(0.45);
   for j:=1 to 3 do for i:=1 to 40 do begin
      ShipY[i]:=ShipY[i]*FactorCos-ShipZ[i]*FactorSin; {X}
      ShipZ[i]:=ShipY[i]*FactorSin+ShipZ[i]*FactorCos;
   end;
   FactorSin:=sin(-0.44); FactorCos:=cos(-0.44);
   for i:=1 to 40 do begin
      ShipX[i]:=ShipX[i]*FactorCos-ShipZ[i]*FactorSin;
      ShipZ[i]:=ShipZ[i]*FactorCos+ShipX[i]*FactorSin;
   end;
   FactorSin:=sin(-0.08); FactorCos:=cos(-0.08);
   for i:=1 to 40 do begin
      ShipX[i]:=ShipX[i]*FactorCos-ShipY[i]*FactorSin;
      ShipY[i]:=ShipX[i]*FactorSin+ShipY[i]*FactorCos;
   end;

   Factor:=0.0074; SizeFactor:=0.009;
   LEdge[1]:=0; TEdge[1]:=75;
   LEdge[2]:=0; TEdge[2]:=75;
   l:=1; ISize:=0;
   repeat
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      ShipX[0]:=ShipX[0]-Factor-Factor-0.22;
      ShipY[0]:=ShipY[0]-Factor;
      BltBitMapRastPort(^MyBitMap,LEdge[AScr],TEdge[AScr]-75,^MyScreen[AScr]^.RastPort,LEdge[AScr],TEdge[Ascr],160,80,192);
      BltBitMapRastPort(^MybitMap,20,145,^MyScreen[AScr]^.RastPort,20,220,600,55,192);
      LEdge[AScr]:=round(ShipX[0]-90); if LEdge[AScr]<0 then LEdge[AScr]:=0;
      TEdge[AScr]:=round(ShipY[0]-60); if TEdge[AScr]<75 then TEdge[AScr]:=75;
      for i:=1 to 40 do if ShipX[0]-ShipX[i]*SizeFactor<0 then begin
         FactorSin:=(ShipX[0]+abs(ShipX[0]-ShipX[i]*SizeFactor))/ShipX[0];
         ShipX[i]:=ShipX[0]/SizeFactor;
         ShipY[i]:=ShipY[i]/FactorSin;
      end;

      SetAPen(^MyScreen[AScr]^.RastPort,124);
      {*** Antrieb ***}
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[20]*SizeFactor),round(ShipY[0]-ShipY[20]*SizeFactor));
      for k:=21 to 24 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      SetAPen(^MyScreen[AScr]^.RastPort,126);
      {*** BodenPlatte hell ***}
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[13]*SizeFactor),round(ShipY[0]-ShipY[13]*SizeFactor));
      for k:=14 to 16 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      {*** Seitenwand ***}
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[17]*SizeFactor),round(ShipY[0]-ShipY[17]*SizeFactor));
      for k:=18 to 19 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      SetAPen(^MyScreen[AScr]^.RastPort,127);
      {*** BodenPlatte ***}
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[1]*SizeFactor),round(ShipY[0]-ShipY[1]*SizeFactor));
      for k:=2 to 12 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      SetAPen(^MyScreen[AScr]^.RastPort,125);
      {*** Waffen ***}
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[25]*SizeFactor),round(ShipY[0]-ShipY[25]*SizeFactor));
      for k:=26 to 28 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      AreaMove(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[29]*SizeFactor),round(ShipY[0]-ShipY[29]*SizeFactor));
      for k:=30 to 32 do AreaDraw(^MyScreen[AScr]^.RastPort,round(ShipX[0]-ShipX[k]*SizeFactor),round(ShipY[0]-ShipY[k]*SizeFactor));
      AreaEnd(^MyScreen[AScr]^.RastPort);
      SetAPen(^MyScreen[AScr]^.RastPort,0);
      RectFill(^MyScreen[AScr]^.RastPort,0,75,0,200);
      if ISize>1 then begin
         WRITE(320,220,123,16,MyScreen[AScr]^,FArr[l],SArr[l]);
         WRITE(320,245,123,16,MyScreen[AScr]^,FArr[l+1],SArr[l+1]);
      end;
      ISize:=ISize+1;
      if ISize>55 then begin
         l:=l+2; ISize:=0;
      end;
      Factor:=Factor*1.018; SizeFactor:=SizeFactor*1.0137;
   until (Factor>3.2) or (SizeFactor>3.2);
   if LData^ and 64=0 then begin
      INTROEXIT; exit;
   end;
   if l<16 then repeat
      ScreenToFront(MyScreen[AScr]); AScr:=3-AScr;
      BltBitMapRastPort(^MybitMap,0,0,^MyScreen[AScr]^.RastPort,0,75,640,360,192);
      if ISize>0 then begin
         WRITE(320,220,123,16,MyScreen[AScr]^,FArr[l],SArr[l]);
         WRITE(320,245,123,16,MyScreen[AScr]^,FArr[l+1],SArr[l+1]);
      end;
      ISize:=ISize+1;
      if ISize>20 then begin
         l:=l+2; ISize:=0;
      end;
      Factor:=Factor*1.018; SizeFactor:=SizeFactor*1.0137;
   until l>16;
   INTROEXIT;
end;





procedure SETWORLDCOLORS;

begin
   case GETCIVVAR(Save.WorldFlag) of
      1: SetRGB32(^MyScreen[1]^.ViewPort,1,$66000000,$66000000,$F7000000);
      2: SetRGB32(^MyScreen[1]^.ViewPort,1,$FF000000,0,0);
      3: SetRGB32(^MyScreen[1]^.ViewPort,1,0,$FF000000,$12000000);
      4: SetRGB32(^MyScreen[1]^.ViewPort,1,$FF000000,$FF000000,0);
      5: SetRGB32(^MyScreen[1]^.ViewPort,1,$BA000000,$8B000000,$48000000);
      6: SetRGB32(^MyScreen[1]^.ViewPort,1,$FF000000,0,$B0000000);
      7: SetRGB32(^MyScreen[1]^.ViewPort,1,$77000000,$77000000,$77000000);
      otherwise SetRGB32(^MyScreen[1]^.ViewPort,1,$0,$FF000000,$FF000000);
   end;
end;



procedure INITSOUNDS;

var l,ISize     :long;

procedure LOADSOUND(FName :str; SID :byte);

var l           :long;

begin
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   l:=DosSeek(FHandle,0,OFFSET_END);
   l:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   SoundSize[SID]:=l div 2;
   SoundMemA[SID]:=AllocMem(SoundSize[SID]*2,MEMF_CHIP+MEMF_CLEAR);
   if SoundMemA[SID]=0 then begin
      DosClose(FHandle);   exit;
   end;
   l:=DosRead(FHandle,ptr(SoundMemA[SID]),SoundSize[SID]*2);
   DosClose(FHandle);
end;


begin
   s:=PathStr[7]+'Blip.RAW';
   LOADSOUND(s,1);
   s:=PathStr[7]+'DestroyDS.RAW';
   LOADSOUND(s,2);
   s:=PathStr[7]+'StargateDS.RAW';
   LOADSOUND(s,3);
end;



function INITDESK(Mode :byte):boolean;

var l,ISize     :long;


procedure LOADMOD(FName :str; MID :byte);

begin
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle<>0 then begin
      ModMemL[MID]:=DosSeek(FHandle,0,OFFSET_END);
      ModMemL[MID]:=DosSeek(FHandle,0,OFFSET_BEGINNING);
      ModMemA[MID]:=AllocMem(ModMemL[MID],MEMF_FAST+MEMF_CLEAR);
      if ModMemA[MID]<>0 then l:=DosRead(FHandle,ptr(ModMemA[MID]),ModMemL[MID]);
      DosClose(FHandle);
   end;
end;


begin
   INITDESK:=false;
   s:=PathStr[1]+'Desk.pal';
   l:=SETCOLOR(MyScreen[1]^,s);
   s:=PathStr[1]+'Desk.img';
   if not DISPLAYIMAGE(s,512,0,128,512,7,MyScreen[1]^,0) then exit;
   SETWORLDCOLORS;

   WRITE(576,156,45,16,MyScreen[1]^,4,PText[145]);
   WRITE(576,207,45,16,MyScreen[1]^,4,PText[146]);
   WRITE(576,258,45,16,MyScreen[1]^,4,PText[147]);
   s:=PathStr[6]+'DeskImages.img';
   if not RAWLOADIMAGE(s,0,32,608,32,4,ImgBitMap4) then exit;

   if Mode=1 then begin
      s:=PathStr[1]+'DeskImages.img';
      if not RAWLOADIMAGE(s,0,0,416,32,7,ImgBitMap7) then exit;
      s:=PathStr[1]+'ProjectIcons.img';
      if not RAWLOADIMAGE(s,0,0,640,192,8,ImgBitMap8) then exit;

      IMemL[1]:=4480;
      IMemA[1]:=AllocMem(IMemL[1],MEMF_CHIP+MEMF_CLEAR);
      if IMemA[1]=0 then exit;
      s:=PathStr[1]+'DeskGads.img';
      FHandle:=OPENSMOOTH(s,MODE_OLDFILE);       {Planets/Deskgads.img}
      if FHandle=0 then begin
         FreeMem(IMemA[1],IMemL[1]);
         IMemA[1]:=0;
         exit;
      end;
      l:=DosRead(FHandle,ptr(IMemA[1]),4480);
      DosClose(FHandle);
      GadImg1:=Image(0,0,116,20,7,ptr(IMemA[1]),127,0,NIL);
      GadImg2:=Image(0,0,116,20,7,ptr(IMemA[1]+2240),127,0,NIL);

      s:=PathStr[5]+'MOD.Invention';
      LOADMOD(s,1);
      s:=PathStr[5]+'MOD.War';
      LOADMOD(s,2);
      s:=PathStr[5]+'MOD.Tech';
      LOADMOD(s,3);
      s:=PathStr[5]+'MOD.Bad';
      LOADMOD(s,4);

      s:=PathStr[8]+'Worm.img';
      if not RAWLOADIMAGE(s,0,32,512,32,7,ImgBitMap7) then exit;
      s:=PathStr[8]+'XPlode.img';
      if not RAWLOADIMAGE(s,0,0,512,32,4,ImgBitMap4) then exit;
   end;

   INITDESK:=true;
end;



procedure CREATENEWSYSTEM(ActSys,CivVar :byte);

var i,j,l               :integer;
var sin_rot,cos_rot,d   :real;
var btx                 :byte;
var MyPlanetHeader      :^r_PlanetHeader;
var DefaultShip         :r_ShipHeader;

begin
   Save.ImperatorState[CivVar]:=Save.ImperatorState[CivVar]+50;
   randomize;
   with SystemHeader[ActSys] do begin
      Planets:=random(MAXPLANETS+5);
      if Planets<4 then Planets:=4;
      if Planets>MAXPLANETS then Planets:=MAXPLANETS;
      PlanetMemA:=AllocMem(Planets*sizeof(r_PlanetHeader),MEMF_CLEAR);
      if PlanetMemA=0 then begin
         Planets:=0;
         exit;
      end;
      btx:=0;
      for i:=0 to pred(Planets) do begin
         MyPlanetHeader:=ptr(PlanetMemA+i*sizeof(r_PlanetHeader));
         with MyPlanetHeader^ do begin
            Class:=random(9);
            if Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,CLASS_ICE,
                         CLASS_STONES,CLASS_WATER] then btx:=1;
            Size:=random(206)+1;
            case Class of
               CLASS_DESERT    : Water:=Size*13;
               CLASS_HALFEARTH : Water:=Size*38;
               CLASS_EARTH     : Water:=Size*73;
               CLASS_ICE       : Water:=Size*85;
               CLASS_STONES    : Water:=Size*42;
               CLASS_WATER     : Water:=Size*92;
               otherwise Water:=0;
            end;
            PFlags:=0;
            PName:=Save.SystemName[ActSys]+' '+Romanum[i+1];
            PosX:=i*3+4;
            PosY:=PosX;
            if (Class in [CLASS_EARTH,CLASS_WATER]) and (random(10)=0) then Biosphäre:=150+random(50) else Biosphäre:=0;
            Infrastruktur:=0;
            Industrie:=0;
            Population:=0;
            XProjectCosts:=0;       XProjectPayed:=1;
            ProjectID:=0;           ProjectPtr:=NIL;
         end;
      end;
      DefaultShip:=r_ShipHeader(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NIL,NIL,NIL);
      if btx=0 then begin
         i:=random(2)+2;
         MyPlanetHeader:=ptr(PlanetMemA+i*sizeof(r_PlanetHeader));
         l:=random(50)+5;
         MyPlanetHeader^:=r_PlanetHeader(CLASS_EARTH,succ(random(197)),0,0,Save.SystemName[ActSys]+' '+Romanum[i+1],
                                         i*3+4,0,l,l*73,200,random(50)+50,random(50)+50,0,0,0,DefaultShip,NIL);
      end;
      l:=Planets*20;
      for i:=1 to l do for j:=1 to SystemHeader[ActSys].Planets do begin
         MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         with MyPlanetHeader^ do begin
            d:=1/((j*3)+1);
            sin_rot:=sin(d);  cos_rot:=cos(d);
            PosX:=PosX * cos_rot - PosY*sin_rot;
            PosY:=PosX * sin_rot + PosY*cos_rot*(1+d*d);
            if round(PosX)=round(PosY) then PosX:=round(PosY);
         end;
      end;
   end;
end;



procedure LINKSHIP(SPtr,TPtr  :ptr, Mode :byte);

var SourcePtr,TargetPtr         :^r_ShipHeader;

begin
   SourcePtr:=SPtr; TargetPtr:=TPtr;
   if Mode=1 then begin
      SourcePtr^.BeforeShip^.NextShip:=SourcePtr^.NextShip;
      if SourcePtr^.NextShip<>NIL then
       SourcePtr^.NextShip^.BeforeShip:=SourcePtr^.BeforeShip;
   end;
   SourcePtr^.BeforeShip:=TargetPtr;
   SourcePtr^.NextShip:=TargetPtr^.NextShip;
   TargetPtr^.NextShip:=SourcePtr;
   if SourcePtr^.NextShip<>NIL then
    SourcePtr^.NextShip^.BeforeShip:=SourcePtr;
end;



procedure FINDENEMYSYSTEM(ActSys,CivVar :byte; ShipPtr :ptr;);

var l                           :long;
var i,k                         :integer;
var SysEntfernung,SysID,btx     :byte;
var b                           :boolean;
var MyShipPtr                   :^r_ShipHeader;

begin
   MyShipPtr:=ShipPtr;
   SysEntfernung:=255; SysID:=0;
   for i:=1 to Save.SYSTEMS do if i<>ActSys then begin
      l:=abs(SystemX[ActSys]-SystemX[i]);
      if abs(SystemY[ActSys]-SystemY[i])>l then l:=abs(SystemY[ActSys]-SystemY[i]);
      if ((SystemFlags[ActPlayer,i] and FLAG_CIV_MASK<>0)
      and (SystemFlags[1,i] and FLAG_CIV_MASK<>0))
      or (MyShipPtr^.Flags=SHIPFLAG_WATER) then begin
         if (l<SysEntfernung) and (MyShipPtr^.Flags=SHIPFLAG_WATER)
         and (random(3)=0) then begin
            SysEntfernung:=l; SysID:=i;
            if (SystemHeader[ActSys].FirstShip.SType=TARGET_STARGATE)
             and (SystemHeader[SysID].FirstShip.SType=TARGET_STARGATE)
             then SysEntfernung:=255;
         end else if (l<SysEntfernung) and (SystemFlags[1,i] and FLAG_CIV_MASK<>0)
         and (Save.WarState[CivVar,GETCIVVAR(SystemFlags[1,i])] in [LEVEL_WAR,LEVEL_COLDWAR])
         then begin
            SysEntfernung:=l; SysID:=i;
         end;
      end;
   end;
   if SysID=0 then SysID:=random(Save.SYSTEMS)+1;
   if SystemHeader[SysID].Planets=0 then CREATENEWSYSTEM(SysID,CivVar);
   if (SystemHeader[ActSys].FirstShip.SType=TARGET_STARGATE)
    and (SystemHeader[SysID].FirstShip.SType=TARGET_STARGATE) then begin
      MyShipPtr^.Target:=TARGET_ENEMY_SHIP;
      MyShipPtr^.TargetShip:=^SystemHeader[ActSys].FirstShip;
      MyShipPtr^.Source:=SysID;
      exit;
   end;
   for i:=1 to MAXHOLES do if MyWormHole[i].CivKnowledge[CivVar]=FLAG_KNOWN then
   with MyWormhole[i] do for j:=1 to 2 do if (System[j]=ActSys) and
   (SystemFlags[1,System[3-j]] and FLAG_CIV_MASK<>0) then if
   (Save.WarState[CivVar,GETCIVVAR(SystemFlags[1,System[3-j]])] in [LEVEL_WAR,LEVEL_COLDWAR])
   then SysID:=System[3-j]; {*** Feindliche Systeme mit Wurmloch bevorzugt angreifen ****}

   for i:=1 to MAXHOLES do if MyWormHole[i].CivKnowledge[CivVar]=FLAG_KNOWN then
   with MyWormHole[i] do for j:=1 to 2 do if (System[j]=ActSys) and (System[3-j]=SysID) then begin
      MyShipPtr^.Target:=-i;
      MyShipPtr^.Source:=-j;
      exit;
   end;
   MyShipPtr^.Source:=ActSys;
   MyShipPtr^.Target:=SysID;
   l:=-(SysEntfernung div ShipData[MyShipPtr^.SType].MaxMove)-1;
   if l<-127 then l:=-127;
   MyShipPtr^.Moving:=l;
   LINKSHIP(MyShipPtr,^SystemHeader[SysID].FirstShip,1);
end;



function FINDMAQUESSHIP(ActSys :byte; MyShipPtr :ShipHeader):boolean;

var CivVar,CivVar2              :byte;
var OtherShipPtr                :^r_ShipHeader;
var DistOld,DistNew             :long;

begin
   FINDMAQUESSHIP:=false;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   if CivVar in [0,9] then exit;
   DistOld:=10000;
   if SystemHeader[ActSys].FirstShip.NextShip<>NIL then begin
      OtherShipPtr:=SystemHeader[ActSys].FirstShip.NextShip;
      while OtherShipPtr<>NIL do begin
         CivVar2:=GETCIVVAR(OtherShipPtr^.Owner);
         if (OtherShipPtr^.Moving>=0) and (CivVar2=9) then begin
            DistNew:=abs(OtherShipPtr^.PosX-MyShipPtr^.PosX);
            if abs(OtherShipPtr^.PosY-MyShipPtr^.PosY)>DistNew then DistNew:=abs(OtherShipPtr^.PosY-MyShipPtr^.PosY);
            if DistNew<DistOld then begin
               DistOld:=DistNew;
               FINDMAQUESSHIP:=true;
               MyShipPtr^.Target:=TARGET_ENEMY_SHIP;
               MyShipPtr^.TargetShip:=OtherShipPtr;
            end;
         end;
         OtherShipPtr:=OtherShipPtr^.NextShip;
      end;
   end;
end;




procedure FINDENEMYOBJECT(ActSys :byte; ShipPtr :ptr);

var btx,CivVar,CivVar2          :byte;
var MyPlanetHeader              :^r_PlanetHeader;
var MyShipPtr,OtherShipPtr      :^r_ShipHeader;
var DistOld,DistNew             :long;
var k                           :integer;
var ActPProjects                :^ByteArr42;

begin
   MyShipPtr:=ShipPtr;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   if CivVar=0 then exit;
   btx:=0;
   DistOld:=10000;
   for k:=0 to pred(SystemHeader[ActSys].Planets) do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+k*sizeof(r_PlanetHeader));
      CivVar2:=GETCIVVAR(MyPlanetHeader^.PFlags);
      ActPProjects:=MyPlanetHeader^.ProjectPtr;
      if (CivVar2<>0) and (CivVar2<>CivVar) then begin
         if (Save.WarState[CivVar,CivVar2] in [LEVEL_WAR,LEVEL_COLDWAR]) then begin
            if (MyShipPtr^.Ladung and MASK_LTRUPPS>0) or (MyPlanetHeader^.FirstShip.NextShip<>NIL)
            or (ActPProjects^[34]>0) or (ActPProjects^[40]>0) or (CivVar=9) then begin
               DistNew:=round(abs(MyPlanetHeader^.PosX-MyShipPtr^.PosX));
               if round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY))>DistNew then DistNew:=round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY));
               if DistNew<=DistOld then begin
                  DistOld:=DistNew;
                  if btx=0 then btx:=k+1;
                  MyShipPtr^.Target:=k+1;
                  MyShipPtr^.Source:=ActSys;
               end;
            end;
         end;
      end;
   end;
   if (btx>0) and (MyShipPtr^.Owner=FLAG_MAQUES) then exit;
   if SystemHeader[ActSys].FirstShip.NextShip<>NIL then begin
      OtherShipPtr:=SystemHeader[ActSys].FirstShip.NextShip;
      if MyShipPtr^.Owner<>FLAG_MAQUES then while OtherShipPtr<>NIL do begin
         CivVar2:=GETCIVVAR(OtherShipPtr^.Owner);
         if (OtherShipPtr^.Moving>=0) and not (CivVar2 in [CivVar,0]) then begin
            if Save.WarState[CivVar,CivVar2] in [LEVEL_WAR,LEVEL_COLDWAR] then begin
               DistNew:=abs(OtherShipPtr^.PosX-MyShipPtr^.PosX);
               if abs(OtherShipPtr^.PosY-MyShipPtr^.PosY)>DistNew then DistNew:=abs(OtherShipPtr^.PosY-MyShipPtr^.PosY);
               if DistNew<DistOld then begin
                  DistOld:=DistNew;
                  btx:=1;
                  MyShipPtr^.Target:=TARGET_ENEMY_SHIP;
                  MyShipPtr^.TargetShip:=OtherShipPtr;
               end;
            end;
         end;
         OtherShipPtr:=OtherShipPtr^.NextShip;
      end;
      if btx=0 then begin
         MyShipPtr^.Target:=1;
         FINDENEMYSYSTEM(ActSys,CivVar,MyShipPtr);
      end;
   end;
end;



procedure REFRESHDISPLAY;

var Mode        :byte;

begin
   Mode:=MODE_REFRESH;
   if ((OldX<>OffsetX) or (OldY<>OffsetY)) and (Display<>0) then Mode:=MODE_REDRAW;
   if Display=0 then DRAWSTARS(Mode,ActPlayer) else DRAWSYSTEM(Mode,Display,NIL);
end;



procedure QUOTEPICARD;

begin
   MAKEBORDER(MyScreen[1]^,20,70,490,290,12,6,0);
   WRITE(256, 90,12,16,MyScreen[1]^,4,'Ich frage mich, ob es Kaiser Honorius klar');
   WRITE(256,112,12,16,MyScreen[1]^,4,'war, als er sah, das die Westgoten den siebten');
   WRITE(256,134,12,16,MyScreen[1]^,4,'Hügel Roms überwanden, das das Römische Reich');
   WRITE(256,156,12,16,MyScreen[1]^,4,'fallen würde ... Das hier ist nur eine weitere');
   WRITE(256,178,12,16,MyScreen[1]^,4,'Episode der Geschichte. Wird hier unsere');
   WRITE(256,200,12,16,MyScreen[1]^,4,'Zivilisation enden?');
   WRITE(480,228,12,32,MyScreen[1]^,4,'Jean Luc Picard');
   WRITE(480,250,12,32,MyScreen[1]^,4,'Mission "Wolf 359"');
   WAITLOOP(false);
   RECT(MyScreen[1]^,0,20,70,490,290);
   REFRESHDISPLAY;
end;



procedure GOTOWAR(CivFlag1,CivFlag2 :byte);

var CivVar1,CivVar2   :byte;

begin
   CivVar1:=GETCIVVAR(CivFlag1);         CivVar2:=GETCIVVAR(CivFlag2);
   CivFlag1:=CivFlag1 and FLAG_CIV_MASK; CivFlag2:=CivFlag2 and FLAG_CIV_MASK;
   Save.ImperatorState[CivVar1]:=Save.ImperatorState[CivVar1]-150;
   if (CivVar1=0) or (CivVar2=0) or (Save.WarState[CivVar1,CivVar2]=LEVEL_WAR)
   or (Save.WarState[CivVar2,CivVar1]=LEVEL_WAR) then exit;
   Save.WarState[CivVar1,CivVar2]:=LEVEL_WAR;
   Save.WarState[CivVar2,CivVar1]:=LEVEL_WAR;
   if (CivVar1=8) and (Save.WorldFlag=WFLAG_JAHADR) then Save.JSteuer[CivVar2]:=0;
   if (CivVar2=8) and (Save.WorldFlag=WFLAG_JAHADR) then Save.JSteuer[CivVar1]:=0;
   if (Save.WarState[ActPlayer,CivVar1]=LEVEL_UNKNOWN) and (Save.WarState[ActPlayer,CivVar2]=LEVEL_UNKNOWN) then exit;
   MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
   s:=GETCIVNAME(CivVar1);
   WRITE(256,131,CivFlag1,1+16,MyScreen[1]^,4,s);
   WRITE(256,151,12,1+16,MyScreen[1]^,4,PText[150]);
   s:=GETCIVNAME(CivVar2);
   WRITE(256,171,CivFlag2,1+16,MyScreen[1]^,4,s);
   if Save.PlayMySelf then delay(PAUSE);
   WAITLOOP(Save.PlayMySelf);
   RECT(MyScreen[1]^,0,85,120,425,200);
   if (Save.CivPlayer[CivVar2]<>0) and not Save.PlayMySelf
   and (Save.WarPower[CivVar1]>Save.WarPower[CivVar2]) and (random(40)=0)
    then QUOTEPICARD
   else if (Save.CivPlayer[CivVar2]<>0) and not Save.PlayMySelf
   and (CivVar1=8) and (Save.WorldFlag in [WFLAG_CEBORC,WFLAG_JAHADR,WFLAG_DCON])
   and (random(10)=0) then QUOTEPICARD;
end;



function GOTONEXTSYSTEM(ActSys :byte; ShipPtr :ptr;):byte;

var l                                   :long;
var i,k                                 :integer;
var SysEntfernung,SysID,btx,CivVar,j    :byte;
var b                                   :boolean;
var MyShipPtr                           :^r_ShipHeader;

begin
   randomize;
   GOTONEXTSYSTEM:=ActSys;
   MyShipPtr:=ShipPtr;
   if not (MyShipPtr^.SType in [8..24]) then begin
      MyShipPtr^.SType:=8;
      MyShipPtr^.Owner:=0;
   end;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   SysEntfernung:=255; SysID:=0;
   for i:=1 to Save.SYSTEMS do if i<>ActSys then begin
      l:=abs(SystemX[ActSys]-SystemX[i]);
      if abs(SystemY[ActSys]-SystemY[i])>l then l:=abs(SystemY[ActSys]-SystemY[i]);
      if (l<SysEntfernung) and (random(2)=0) then begin
         if ((Save.GlobalFlags[CivVar]=GFLAG_EXPLORE) and (SystemHeader[i].State and STATE_TACTICAL=0))
         or ((MyShipPtr^.Flags=SHIPFLAG_WATER) and
         (((MyShipPtr^.Fracht>0) and (SystemFlags[1,i] and FLAG_CIV_MASK<>0))
         or (MyShipPtr^.Fracht=0))) then begin
            SysEntfernung:=l; SysID:=i;
            if (SystemHeader[ActSys].FirstShip.SType=TARGET_STARGATE)
             and (SystemHeader[SysID].FirstShip.SType=TARGET_STARGATE)
             then SysEntfernung:=255;
         end;
      end;
   end;
   if SysID=0 then begin
      Save.GlobalFlags[CivVar]:=GFLAG_ATTACK;
      MyShipPtr^.Moving:=0;
      exit;
   end;
   if SystemHeader[SysID].Planets=0 then CREATENEWSYSTEM(SysID,CivVar);
   if (SystemHeader[ActSys].FirstShip.SType=TARGET_STARGATE)
   and (SystemHeader[SysID].FirstShip.SType=TARGET_STARGATE) then begin
      MyShipPtr^.Target:=TARGET_ENEMY_SHIP;
      MyShipPtr^.TargetShip:=^SystemHeader[ActSys].FirstShip;
      MyShipPtr^.Source:=SysID;
      exit;
   end;
   for i:=1 to MAXHOLES do if MyWormHole[i].CivKnowledge[CivVar]=FLAG_KNOWN then
   with MyWormHole[i] do for j:=1 to 2 do if (System[j]=ActSys) and (System[3-j]=SysID) then begin
      MyShipPtr^.Target:=-i;
      MyShipPtr^.Source:=-j;
      exit;
   end;
   MyShipPtr^.Source:=ActSys;
   MyShipPtr^.Target:=SysID;
   l:=-(SysEntfernung div ShipData[MyShipPtr^.SType].MaxMove)-1;
   if l<-127 then l:=-127;
   MyShipPtr^.Moving:=l;
   LINKSHIP(MyShipPtr,^SystemHeader[SysID].FirstShip,1);
   GOTONEXTSYSTEM:=SysID;
end;



function EXISTSPLANET(CivVar,ActSys,Mode :byte):boolean;

var MyPlanetHeader      :^r_PlanetHeader;
var i,CivFlag           :byte;

begin
   EXISTSPLANET:=false;
   CivFlag:=GETCIVFLAG(CivVar);
   for i:=0 to pred(SystemHeader[ActSys].Planets) do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+i*sizeof(r_PlanetHeader));
      with MyPlanetHeader^ do if (((Mode=1) and (Water div Size>56))
       or ((Mode=2) and (Water div Size<55)))
       and not (Class in [CLASS_STONES,CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM])
       then begin
         if ((PFlags and FLAG_CIV_MASK) in [CivFlag,0]) then begin
            EXISTSPLANET:=true;
            exit;
         end else if Save.WarState[CivVar,GETCIVVAR(PFlags)] in [LEVEL_WAR,LEVEL_COLDWAR] then begin
            EXISTSPLANET:=true;
            exit;
         end;
      end;
   end;
end;



function FINDNEXTPLANET(ActSys :byte; ShipPtr :ptr):byte;

var btx,CivVar,CivFlag                  :byte;
var MyPlanetHeader                      :^r_PlanetHeader;
var MyShipPtr,OtherShipPtr              :^r_ShipHeader;
var k                                   :integer;
var DistOld,DistNew,WPerc,WPercLow      :long;

begin
   FINDNEXTPLANET:=ActSys;
   if FINDMAQUESSHIP(ActSys,ShipPtr) then exit;
   MyShipPtr:=ShipPtr;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   CivFlag:=MyShipPtr^.Owner and FLAG_CIV_MASK;
   btx:=0;
   DistOld:=10000;
   for k:=0 to pred(SystemHeader[ActSys].Planets) do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+k*sizeof(r_PlanetHeader));
      OtherShipPtr:=MyPlanetHeader^.FirstShip.NextShip;
      while (OtherShipPtr<>NIL) and (OtherShipPtr^.Owner=0) do OtherShipPtr:=OtherShipPtr^.NextShip;
      if MyPlanetHeader^.Size=0 then MyPlanetHeader^.Size:=1;
      WPerc:=MyPlanetHeader^.Water div MyPlanetHeader^.Size;
      WPercLow:=(MyPlanetHeader^.Water-5) div MyPlanetHeader^.Size;
      if ((MyShipPtr^.Ladung and MASK_SIEDLER>0) and
          (MyPlanetHeader^.Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,
                                     CLASS_ICE,CLASS_STONES,CLASS_WATER]) and
          (MyPlanetHeader^.PFlags=0) and (OtherShipPtr=NIL))

      or ((MyShipPtr^.Ladung=0) and (MyShipPtr^.Fracht=0) and
        not (MyPlanetHeader^.Class in [CLASS_STONES,CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM]) and
        ((MyPlanetHeader^.PFlags and FLAG_CIV_MASK in [CivFlag,0])
        or (Save.WarState[CivVar,GETCIVVAR(MyPlanetHeader^.PFlags)]=LEVEL_WAR)) and
        (WPercLow>56))

      or ((MyShipPtr^.Fracht>0) and (WPerc<55) and
      not (MyPlanetHeader^.Class in [CLASS_STONES,CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM]) and
      (MyPlanetHeader^.PFlags and FLAG_CIV_MASK=CivFlag)) then begin
         DistNew:=round(abs(MyPlanetHeader^.PosX-MyShipPtr^.PosX));
         if round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY))>DistNew then DistNew:=round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY));
         if DistNew<DistOld then begin
            DistOld:=DistNew;
            if btx=0 then btx:=k+1;
            MyShipPtr^.Target:=k+1;
            MyShipPtr^.Source:=0;
            MyShipPtr^.TargetShip:=NIL;
         end;
      end;
   end;
   if btx<=0 then begin
      SystemHeader[ActSys].State:=SystemHeader[ActSys].State or STATE_ALL_OCC;
      FINDNEXTPLANET:=GOTONEXTSYSTEM(ActSys,MyShipPtr);
   end else SystemHeader[ActSys].State:=SystemHeader[ActSys].State and not STATE_ALL_OCC;
end;



procedure INITSCREEN(Mode :byte);

var i           :integer;
var l           :long;

begin
   if Mode=SCREEN_TECH then begin
      s:=PathStr[6]+'ShipTech.img';
      if not DISPLAYIMAGE(s,0,0,640,512,3,MyScreen[2]^,1) then exit;
   end;
   if Mode=Screen2 then exit;
   IMemID:=false;
   if Mode=SCREEN_PLANET then begin
      RECT(MyScreen[2]^,0,0,0,639,511);
      s:=PathStr[1]+'PlanetDesk.img';
      if not DISPLAYIMAGE(s,0,94,384,394,8,MyScreen[2]^,2) then exit;
      WRITE(62,126,2,0,MyScreen[2]^,4,PText[151]);
      WRITE(62,175,2,0,MyScreen[2]^,4,PText[152]);
      WRITE(62,224,2,0,MyScreen[2]^,4,PText[153]);
      WRITE(165,250,2,0,MyScreen[2]^,4,PText[154]);
      WRITE(62,273,2,0,MyScreen[2]^,4,PText[155]);
      WRITE(185,312,2,0,MyScreen[2]^,4,PText[156]);
      WRITE(185,359,2,0,MyScreen[2]^,4,PText[157]);
      WRITE(120,461,2,16,MyScreen[2]^,4,PText[158]);
      WRITE(262,461,2,16,MyScreen[2]^,4,PText[159]);
      for i:=1 to 3 do WRITE(333,i*49+54,2,0,MyScreen[2]^,4,'%');
      WRITE(333,402,2,0,MyScreen[2]^,4,'%');
   end else if Mode=SCREEN_HISCORE then begin
      s:=PathStr[5]+'HiScore.img';
      if not DISPLAYIMAGE(s,0,0,640,512,7,MyScreen[2]^,3) then exit;
   end;
   Screen2:=Mode;
end;



procedure CREATEHIGHSCORE;

var FHandle             :BPTR;
var i                   :byte;
var l                   :long;

begin
   with HiScore do begin
      s:=PathStr[5]+'HiScore.dat';
      FHandle:=DosOpen(s,MODE_NEWFILE);
      if FHandle=0 then begin
         ScreenToFront(MyScreen[1]);
         exit;
      end;
      for i:=1 to 8 do begin
         Points[i]:=2800+(9-i)*2150;
         CivVar[i]:=i;
         if i=8 then CivVar[i]:=1;
      end;
      Player[1]:='Oxygenic';     Player[2]:='Kha`thak';
      Player[3]:='Tomalak';      Player[4]:='Megalith';
      Player[5]:='Monolith';     Player[6]:='The One';
      Player[7]:='Dark Blitter'; Player[8]:='CyberTrace';
      l:=DosWrite(FHandle,^HiScore,sizeof(r_Hiscore));
      DosClose(FHandle);
   end;
end;



procedure HIGHSCORE;

var FHandle     :BPTR;
var i           :byte;
var l           :long;


function GETCOLOR(Col :byte):byte;

begin
   case Col of
      1: GETCOLOR:=122;
      2: GETCOLOR:=123;
      3: GETCOLOR:=124;
      4: GETCOLOR:=2;
      5: GETCOLOR:=125;
      6: GETCOLOR:=126;
      7: GETCOLOR:=11;
      otherwise GETCOLOR:=122;
   end;
end;


begin
   SWITCHDISPLAY;
   INITSCREEN(SCREEN_HISCORE);
   WRITE(210,60,127,80,MyScreen[2]^,5,'Imperium Terranum Highscores');
   s:=PathStr[5]+'HiScore.dat';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle=0 then begin
      CREATEHIGHSCORE;
      s:=PathStr[5]+'HiScore.dat';
      FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
      if FHandle=0 then begin
         ScreenToBack(MyScreen[2]);
         exit;
      end;
   end;
   l:=DosRead(FHandle,^HiScore,sizeof(r_HiScore));
   DosClose(FHandle);
   for i:=1 to 8 do with HiScore do begin
      s:=intstr(Points[i]);
      WRITE(115,100+i*30,GETCOLOR(CivVar[i]),32+64,MyScreen[2]^,5,s);
      WRITE(135,100+i*30,GETCOLOR(CivVar[i]),64,MyScreen[2]^,5,Player[i]);
   end;
   ScreenToFront(MyScreen[2]);
   repeat
      delay(RDELAY);
   until (LData^ and 64=0) or (RData^ and 1024=0);
   PLAYSOUND(1,300);
   repeat
      delay(RDELAY);
   until (not (LData^ and 64=0) and not (RData^ and 1024=0)) or Bool;
   ScreenToBack(MyScreen[2]);
end;



function GETPLAYERNAME(ActPlayer :byte):string;

var VWindow             :^Window;
var VKey                :byte;
var PName               :string[20];
var s                   :string;



begin
   GETPLAYERNAME:='PlayerX';
   RECT(MyScreen[2]^,0,0,0,639,511);
   NeuWindow:=NewWindow(0,0,640,512,0,0,VANILLAKEY,BORDERLESS+BACKDROP+ACTIVATE+
                        SIMPLE_REFRESH,NIL,NIL,'',MyScreen[2],NIL,640,512,640,512,CUSTOMSCREEN);
   VWindow:=OpenWindow(^NeuWindow);
   if VWindow=NIL then exit;
   PName:='';
   SetRGB4(^MyScreen[2]^.ViewPort,1,15,15,15);
   SetRGB4(^MyScreen[2]^.ViewPort,2,3,3,15);
   SetRGB4(^MyScreen[2]^.ViewPort,3,9,9,9);
   WRITE(320,100,1,16,MyScreen[2]^,4,PText[160]);
   if not MultiPlayer then WRITE(320,150,2,16,MyScreen[2]^,4,PText[161]) else begin
      s:='Player '+intstr(Save.CivPlayer[ActPlayer])+PText[162];
      WRITE(320,150,2,16,MyScreen[2]^,4,s)
   end;
   MAKEBORDER(MyScreen[2]^,100,200,540,230,1,3,0);
   ScreenToFront(MyScreen[2]);
   repeat
      IMsg:=Wait_Port(VWindow^.UserPort);
      if IMsg<>NIL then begin
         IMsg:=Get_Msg(VWindow^.UserPort);
         if IMsg^.Class=VANILLAKEY then VKey:=IMsg^.Code;
         Reply_Msg(IMsg);
      end;
      if (VKey=8) and (PName<>'') then begin
         PName[length(PName)]:=chr(0);
         RECT(MyScreen[2]^,0,102,202,538,228);
      end;
      if VKey>30 then PName:=PName+chr(VKey);
      WRITE(320,208,2,17,MyScreen[2]^,4,PName)
   until VKey=13;
   GETPLAYERNAME:=PName;
   CloseWindow(VWindow);
end;



procedure PLAYERHIGHSCORE(ActPlayer :byte);

var s   :string;
var l   :long;
var i   :byte;

begin
   s:=PathStr[5]+'HiScore.dat';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle=0 then begin
      CREATEHIGHSCORE;
      s:=PathStr[5]+'HiScore.dat';
      FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   end;
   if FHandle<>0 then begin
      l:=DosRead(FHandle,^HiScore,sizeof(r_Hiscore));
      if HiScore.Points[8]<Save.ImperatorState[ActPlayer] then with HiScore do begin
         Points[8]:=Save.ImperatorState[ActPlayer];
         CivVar[8]:=ActPlayer;
         Player[8]:=GETCIVNAME(ActPlayer);
         if not Save.PlayMySelf and (Save.CivPlayer[ActPlayer]<>0)
          then Player[8]:=GETPLAYERNAME(ActPlayer);
         for i:=8 downto 2 do if Points[i]>=Points[i-1] then begin
            exchange(Points[i],Points[i-1]);
            exchange(CivVar[i],CivVar[i-1]);
            exchange(Player[i],Player[i-1]);
         end;
         l:=DosSeek(FHandle,0,OFFSET_BEGINNING);
         l:=DosWrite(FHandle,^HiScore,sizeof(r_Hiscore));
         HIGHSCORE;
      end;
      DosClose(FHandle);
   end;
end;



procedure CLICKRECT(XScreen :Screen; Left,Top,Right,Bottom :word; Color :byte);

begin
   SetAPen(^XScreen.RastPort,Color); BOX(XScreen,Left+3,Top+3,Right-3,Bottom-3);
   PLAYSOUND(1,300);
   SetAPen(^XScreen.RastPort,0);     BOX(XScreen,Left+3,Top+3,Right-3,Bottom-3);
end;



procedure DOINFLATION(ActPlayer :byte);

var j   :byte;

begin
   for j:=1 to 42 do Save.ProjectCosts[ActPlayer,j]:=round(Save.ProjectCosts[ActPlayer,j]*INFLATION);
   for j:=1 to 42 do Save.TechCosts[ActPlayer,j]:=round(Save.TechCosts[ActPlayer,j]*INFLATION);
end;



procedure HANDLEKNOWNPLANET(ActSys,Mode :byte; PlanetPtr :ptr);

var PMoney,PProd                :long;
var NewProject                  :array [1..25] of string[30];
var ProjectRounds               :array [1..25] of long;
var ProjectNum,ProjectType      :array [1..25] of short;
var i,j                         :integer;
var l                           :long;
var Ships,x,y,btx               :byte;
var DoIt,b                      :boolean;
var MyShipPtr                   :^r_ShipHeader;
var MyPlanetHeader              :^r_PlanetHeader;
var ActPProjects                :^ByteArr42;


procedure WRITEPROJECTDATA;

begin
   with MyPlanetHeader^ do begin
      RECT(MyScreen[2]^,0,56,426,327,448);
      RECT(MyScreen[2]^,0,56,399,256,418);
      l:=0;
      if ProjectID<>0 then begin
         if ProjectID>0 then begin
            s:=Project[ProjectID];
            l:=XProjectPayed*100 div (XProjectCosts+1);
         end else case ProjectID of
            -3: begin
                   s:=PText[163];
                   l:=Biosphäre div 2;
                end;
            -2: begin
                   s:=PText[164];
                   l:=Infrastruktur div 2;
                end;
            otherwise begin
                   s:=PText[165];
                   l:=Industrie div 2;
            end;
         end;
         WRITE(191,430,2,17,MyScreen[2]^,4,s)
      end;
      if l>100 then l:=100;   if l<0 then l:=0;
      s:=intstr(l);
      while length(s)<3 do s:='0'+s;
      WRITE(278,402,4,1,MyScreen[2]^,2,s);
      RECT(MyScreen[2]^,4,56,399,56+l*2,418);

      RECT(MyScreen[2]^,0,56,307,178,330);
      y:=0;   {Kreativität}
      if ActPProjects^[33]>0 then y:=y+1;   if ActPProjects^[35]>0 then y:=y+1;
      if ActPProjects^[36]>0 then y:=y+1;   if ActPProjects^[38]>0 then y:=y+1;
      if ActPProjects^[42]>0 then y:=y+1;
      if y>0 then for i:=1 to y do BltBitMapRastPort(^ImgBitMap8,320,128,^MyScreen[2]^.RastPort,56+pred(i)*25,308,22,22,192);

      RECT(MyScreen[2]^,0,56,354,178,376);
      y:=0;   {Produktivität}
      if ActPProjects^[31]>0 then y:=y+1;   if ActPProjects^[37]>0 then y:=y+1;
      if ActPProjects^[38]>0 then y:=y+1;   if ActPProjects^[41]>0 then y:=y+1;
      if ActPProjects^[42]>0 then y:=y+1;
      if y>0 then for i:=1 to y do BltBitMapRastPort(^ImgBitMap8,320,151,^MyScreen[2]^.RastPort,56+pred(i)*25,354,22,22,192);

      RECT(MyScreen[2]^,0,359,92,639,511);
      x:=1; y:=0;
      for i:=1 to 7 do if Save.ProjectCosts[ActPlayer,i]<=0 then begin
         if ActPPRojects^[i]>0 then RECT(MyScreen[2]^,4,293+x*67,92+y*66,360+x*67,159+y*66);
         BltBitMapRastPort(^ImgBitMap8,pred(i)*64,0,^MyScreen[2]^.RastPort,295+x*67,94+y*66,64,64,192);
         x:=x+1;
         if x>4 then begin
            x:=1; y:=y+1;
         end;
      end;
      for i:=25 to 42 do if (ActPProjects^[i]>0) or ((i=39) and (Save.ProjectCosts[ActPlayer,i]<=0)) then begin
         if i in [25..27] then      BltBitMapRastPort(^ImgBitMap8,(i-18)*64,0,^MyScreen[2]^.RastPort,295+x*67,y*66+94,64,64,192)
         else if i in [28..37] then BltBitMapRastPort(^ImgBitMap8,(i-28)*64,64,^MyScreen[2]^.RastPort,295+x*67,y*66+94,64,64,192)
         else                       BltBitMapRastPort(^ImgBitMap8,(i-38)*64,128,^MyScreen[2]^.RastPort,295+x*67,y*66+94,64,64,192);
         if i in [26..27] then begin
            s:=intstr(ActPPRojects^[i]);
            while length(s)<3 do s:='0'+s;
            WRITE(309+x*67,y*66+141,4,0,MyScreen[2]^,2,s);
         end else if i in [34,40] then begin
            s:=intstr(ActPPRojects^[i])+'%';
            while length(s)<4 do s:='0'+s;
            WRITE(300+x*67,y*66+141,4,0,MyScreen[2]^,2,s);
         end;
         x:=x+1;
         if x>4 then begin
            x:=1; y:=y+1;
         end;
         if y=6 then exit;
      end;
   end;
end;


begin
   SWITCHDISPLAY;
   MyPlanetHeader:=PlanetPtr;
   with MyPlanetHeader^ do begin
      INITSCREEN(SCREEN_PLANET);
      ActPProjects:=ProjectPtr;
      for i:=1 to 3 do RECT(MyScreen[2]^,0,56,i*49+52,256,i*49+71);
      RECT(MyScreen[2]^,0,0,0,639,90);
      s:=PText[166]+': '+Save.SystemName[ActSys]; WRITE(5,5,1,1,MyScreen[2]^,4,s);
      s:=PText[167]+': '+PName;                   WRITE(5,25,1,1,MyScreen[2]^,4,s);
      s:=PText[168]+': ';
      case Class of
         CLASS_DESERT    : s:=s+'D (ca. 60%';
         CLASS_HALFEARTH : s:=s+'H (ca. 80%';
         CLASS_EARTH     : s:=s+'M (ca. 95%';
         CLASS_ICE       : s:=s+'I (ca. 60%';
         CLASS_STONES    : s:=s+'T (ca. 75%';
         CLASS_WATER     : s:=s+'W (ca. 60%';
         otherwise;
      end;
      s:=s+' '+PText[169]+')';
      WRITE(5,45,1,1,MyScreen[2]^,4,s);
      s:=PText[170]+': '+realstr(Size/10,2)+PText[171];
      WRITE(5,65,1,1,MyScreen[2]^,4,s);

      if Save.ActTech[ActPlayer]>0 then begin
         s:=PText[172]+': '+TechnologyL[Save.ActTech[ActPlayer]];
         WRITE(275,5,1,1,MyScreen[2]^,4,s);
      end else WRITE(275,5,1,1,MyScreen[2]^,4,PText[173]);

      if FirstShip.NextShip<>NIL then begin
         i:=0;
         MyShipPtr:=FirstShip.NextShip;
         repeat
            if MyShipPtr^.Owner<>0 then i:=i+1;
            MyShipPtr:=MyShipPtr^.NextShip;
         until MyShipPtr=NIL;
         s:=PText[175]+': '+intstr(i);
         WRITE(275,45,1,1,MyScreen[2]^,4,s);
      end;
      if Ethno<>PFlags and ActPlayerFlag then begin
         s:=Ptext[176]+' '+GETCIVNAME(GETCIVVAR(Ethno));
         WRITE(275,65,1,1,MyScreen[2]^,4,s);
      end;

      RECT(MyScreen[2]^,4,56,101,56+Biosphäre,120);
      s:=intstr(Biosphäre div 2);     while length(s)<3 do s:='0'+s;
      WRITE(278,104,4,1,MyScreen[2]^,2,s);
      l:=5-ActPProjects^[30]-ActPProjects^[31]
          -ActPProjects^[32]-ActPProjects^[37]
          -ActPProjects^[42];
      if l>0 then for i:=1 to l do BltBitMapRastPort(^ImgBitMap8,320,174,^MyScreen[2]^.RastPort,37+i*22,102,19,18,192);

      RECT(MyScreen[2]^,4,56,150,56+Infrastruktur,169);
      s:=intstr(Infrastruktur div 2); while length(s)<3 do s:='0'+s;
      WRITE(278,153,4,1,MyScreen[2]^,2,s);
      RECT(MyScreen[2]^,4,56,199,56+Industrie,218);
      s:=intstr(Industrie div 2);     while length(s)<3 do s:='0'+s;
      WRITE(278,202,4,1,MyScreen[2]^,2,s);
      s:=intstr(Population);    while length(s)<7 do s:='0'+s;
      WRITE(59,251,4,1,MyScreen[2]^,2,s);
      PProd:=11+(ActPProjects^[31]+ActPProjects^[37]
               +ActPProjects^[38]+ActPProjects^[41]
               +ActPProjects^[42])*6;
      PMoney:=round(PProd*(Infrastruktur/17+Industrie/17+Population/17))+1;
      while PMoney>MAXPMONEY do PMoney:=round(PMoney*0.95);

      l:=0;
      WRITEPROJECTDATA;
      ScreenToFront(MyScreen[2]);
      repeat
         delay(RDELAY);
         l:=l+1;
         if Mode=1 then begin
            if l<20 then i:=4 else i:=0;
            l:=l+1;
            if l>40 then l:=0;
            WRITE(278,402,i,1,MyScreen[2]^,2,'100');
         end;

         RawCode:=GETRAWCODE;

         if (LData^ and 64=0) then begin
            if (IBase^.MouseX in [56..187]) and (IBase^.MouseY in [455..480]) then begin
               CLICKRECT(MyScreen[2]^,55,455,186,481,2);
               Mode:=0;
               j:=1;
               if Biosphäre<200 then begin
                  NewProject[j]:=PText[163];
                  ProjectRounds[j]:=(200-Biosphäre)*PMoney div 9;
                  ProjectNum[j]:=-3;
                  ProjectType[j]:=1;
                  j:=j+1;
               end;
               if Infrastruktur<200 then begin
                  NewProject[j]:=PText[164];
                  ProjectRounds[j]:=(200-Infrastruktur)*PMoney div 9;
                  ProjectNum[j]:=-2;
                  ProjectType[j]:=1;
                  j:=j+1;
               end;
               if Industrie<200 then begin
                  NewProject[j]:=PText[165];
                  ProjectRounds[j]:=(200-Industrie)*PMoney div 9;
                  ProjectNum[j]:=-1;
                  ProjectType[j]:=1;
                  j:=j+1;
               end;
               Ships:=0;
               for i:=42 downto 1 do begin
                  DoIt:=false;
                  if (Save.TechCosts[ActPlayer,ProjectNeedsTech[i]]<=0)
                  {Technologie vorhanden }
                  and ((ActPProjects^[ProjectNeedsProject[i]]>0) or (Save.ProjectCosts[ActPlayer,ProjectNeedsProject[i]]<=0)) then begin
                  { nötiges Projekt vorhanden }
                     if (i in [1..7,39]) and (Save.ProjectCosts[ActPlayer,i]>0) then DoIt:=true;
                     { Großprojekt noch nicht gebaut }
                     if (i in [25,28..38,40..42]) and (ActPProjects^[i]=0) then DoIt:=true;
                     { Projekt noch nicht gebaut }
                     if i in [8..24,26,27] then DoIt:=true;
                     { sonstige Projekte, können mehrfach gebaut werden }
                  end;
                  if DoIt then begin
                     ProjectRounds[j]:=Save.ProjectCosts[ActPlayer,i];
                     NewProject[j]:=Project[i];
                     ProjectNum[j]:=i;
                     if i in [8..24] then begin
                        if (Ships>3) then j:=j-1 else begin
                           Ships:=Ships+1;
                           ProjectType[j]:=3;
                           ProjectRounds[j]:=round(ProjectRounds[j]+(ProjectRounds[j]*(Save.Military[ActPlayer]/100)));
                        end;
                     end;
                     if i in [1..7] then ProjectType[j]:=2;
                     if i>24 then ProjectType[j]:=4;
                     j:=j+1;
                  end;
               end;
               j:=j-1;
               Img:=Image(0,0,384,407,7,ptr(IMemA[0]),127,0,NIL);
               RECT(MyScreen[2]^,0,360,92,639,511);
               WRITE(365,474,4,1,MyScreen[2]^,4,PText[177]);
               for i:=1 to j do begin
                  WRITE(365,78+i*16,ProjectType[i],1,MyScreen[2]^,3,NewProject[i]);
                  if ProjectNum[i]>0 then l:=(ProjectRounds[i]-XProjectPayed) div PMoney +1
                  else l:=ProjectRounds[i] div PMoney +1;
                  if l<=0 then l:=1;
                  s:=intstr(l);
                  while length(s)<7 do s:='0'+s;
                  WRITE(575,78+i*16,ProjectType[i],1,MyScreen[2]^,3,s);
               end;
               btx:=1;
               ProjectID:=0;
               l:=0;
               repeat
                  delay(RDELAY);
                  if IBase^.MouseX>365 then begin
                     i:=(IBase^.MouseY-78) div 16;
                     if (i<>btx) and (i in [1..j]) then begin
                        btx:=i;
                        for i:=1 to j do
                         if i<>btx then WRITE(365,78+i*16,ProjectType[i],1,MyScreen[2]^,3,NewProject[i])
                         else WRITE(365,78+i*16,ProjectType[i],5,MyScreen[2]^,3,NewProject[i]);
                     end;
                     if (LData^ and 64=0) then begin
                        PLAYSOUND(1,300);
                        if (btx>0) then ProjectID:=ProjectNum[btx];
                     end;
                  end;
               until (ProjectID<>0) or (RData^ and 1024=0);
               if (RData^ and 1024=0) then begin
                  ProjectID:=0;
                  PLAYSOUND(1,300);
               end else begin
                  XProjectCosts:=ProjectRounds[btx];
                  if ProjectID>0 then s:=Project[ProjectID];
               end;
               WRITEPROJECTDATA;
            end else if (IBase^.MouseX in [198..328]) and (IBase^.MouseY in [455..480])
            and (ProjectID>0) then begin
               CLICKRECT(MyScreen[2]^,197,455,328,481,2);
               RECT(MyScreen[2]^,0,360,92,639,511);
               MAKEBORDER(MyScreen[2]^,362,350,635,487,2,32,0);
               WRITE(498,361,2,16,MyScreen[2]^,4,PText[178]);
               l:=XProjectCosts-XProjectPayed;
               if l<0 then l:=0;
               s:=intstr(l);
               WRITE(498,382,4,16,MyScreen[2]^,2,s);
               WRITE(498,403,2,16,MyScreen[2]^,4,PText[179]);
               s:=intstr(Save.Staatstopf[ActPlayer]);
               WRITE(498,424,4,16,MyScreen[2]^,2,s);
               MAKEBORDER(MyScreen[2]^,372,450,493,475,2,32,0); WRITE(432,456,2,16,MyScreen[2]^,4,'Kaufen');
               MAKEBORDER(MyScreen[2]^,503,450,625,475,2,32,0); WRITE(564,456,2,16,MyScreen[2]^,4,'Abbruch');
               b:=false;
               repeat
                  delay(RDELAY);
                  if (LData^ and 64=0) and (IBase^.MouseX in [372..493])
                  and (IBase^.MouseY in [450..475]) then begin
                     CLICKRECT(MyScreen[2]^,372,450,493,475,2);
                     b:=true;
                     l:=XProjectCosts-XProjectPayed;
                     if l<0 then l:=0;
                     if l>=Save.Staatstopf[ActPlayer] then begin
                        XProjectPayed:=XProjectPayed+Save.Staatstopf[ActPlayer];
                        Save.Staatstopf[ActPlayer]:=0;
                     end else begin
                        XProjectPayed:=XProjectCosts;
                        Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-l;
                     end;
                  end;
                  if (RData^ and 1024=0) or ((LData^ and 64=0)
                  and (IBase^.MouseX in [503..625]) and (IBase^.MouseY in [450..475]))
                  then begin
                     CLICKRECT(MyScreen[2]^,503,450,625,475,2);
                     b:=true;
                  end;
               until b;
               WRITEPROJECTDATA;
            end;
         end;
      until (RData^ and 1024=0) or (RawCode in [64,67,68]);
      PLAYSOUND(1,300);
      CLEARINTUITION;
      ScreenToFront(MyScreen[1]);
   end;
end;



procedure WRITEGALAXYDATA(ActSys,ShipMaxMove :byte);

var i           :integer;
var l           :long;

begin
   for i:=1 to Save.SYSTEMS do
    if (IBase^.MouseX in [SystemX[i]-20..SystemX[i]+20])
    and (IBase^.MouseY in [SystemY[i]-5..SystemY[i]+5])
    and (LastSystem<>i) then begin
      LastSystem:=i;
      RECT(MyScreen[1]^,0,522,9,629,116);
      WRITE(528,12,12,0,MyScreen[1]^,4,Save.SystemName[i]);
      if (Save.CivPlayer[ActPlayer]<>0)
      and not (SystemFlags[ActPlayer,i] and FLAG_KNOWN=0) then begin
         s:=intstr(SystemHeader[i].Planets)+' '+PText[180];
         WRITE(528,29,12,0,MyScreen[1]^,4,s);
         s:=GETCIVNAME(GETCIVVAR(SystemFlags[1,i] and FLAG_CIV_MASK));
         WRITE(528,46,SystemFlags[1,i] and FLAG_CIV_MASK,0,MyScreen[1]^,4,s);
      end else WRITE(528,29,12,0,MyScreen[1]^,4,PText[181]);
      if ActSys>0 then begin
         l:=abs(SystemX[ActSys]-SystemX[i]) + abs(SystemY[ActSys]-SystemY[i]);
         l:=l div ShipMaxMove;
         s:=intstr(l);
         while length(s)<4 do s:='0'+s;
         WRITE(547,70,8,0,MyScreen[1]^,2,s);
         WRITE(550,87,12,0,MyScreen[1]^,4,PText[148]);
      end else if SystemHeader[i].FirstShip.SType=TARGET_STARGATE then WRITE(528,77,12,0,MyScreen[1]^,4,'Stargate')
   end;
end;



function GETTHESOUND(MID :byte):long;

var l           :long;

begin
   GETTHESOUND:=0;
   if ModMemA[MID]=0 then exit;
   l:=AllocMem(ModMemL[MID],MEMF_CHIP);
   GETTHESOUND:=l;
   if l<>0 then begin
      CopyMemQuick(ModMemA[MID],l,ModMemL[MID]);
      RelocModul(l);
      PlayModule(l);
   end;
end;



procedure SYSTEMINFO(ActSys :byte);
forward;



procedure SHIPINFO(ActSys :byte);

var Step                :byte;
var ModC                :long;
var MyShipPtr           :^r_ShipHeader;
var MyPlanetHeader      :^r_PlanetHeader;



procedure WRITEDATA;

var w1,w2,Col1,Col2     :integer;
var c1,c2,i             :byte;

begin
   with MyShipPtr^ do begin
      Step:=(300 div Shield);
      RECT(MyScreen[2]^,0,386,296,513,310);
      WRITE(443-Step*Tactical,297,1,1,MyScreen[2]^,2,'#');
      Step:=Shield div 3;
      if Step=0 then Step:=1;
      Col1:=round((Tactical+Step)*(255/Step));
      Col2:=round(-(Tactical-Step)*(255/Step));
      for i:=1 to 8 do begin
         if Col1<0 then c1:=0 else if Col1>255 then c1:=255 else c1:=Col1;
         SetRGB32(^MyScreen[2]^.ViewPort, i+5,c1*$1000000,0,0);
         Col1:=Col1-30;

         if Col2<0 then c2:=0 else if Col2>255 then c2:=255 else c2:=Col2;
         SetRGB32(^MyScreen[2]^.ViewPort,i+19,c2*$1000000,0,c2*$1000000);
         Col2:=Col2-30;
      end;
      s:=intstr(Shield+Tactical*3); while length(s)<3 do s:='0'+s;
      WRITE(275,296,5,1,MyScreen[2]^,2,s);
      s:=intstr(round((Shield+Tactical*3)/ShipData[SType].MaxShield*100));
      while length(s)<3 do s:='0'+s;
      WRITE(324,296,5,1,MyScreen[2]^,2,s);

      w1:=round((Weapon/10+1)*(ShipData[SType].WeaponPower-Tactical));
      w2:=round((Weapon/10+1)*ShipData[SType].WeaponPower);
      s:=intstr(w1);
      while length(s)<3 do s:='0'+s;
      WRITE(522,296,5,1,MyScreen[2]^,2,s);
      s:=intstr(round((w1/w2*100)));
      while length(s)<3 do s:='0'+s;
      WRITE(571,296,5,1,MyScreen[2]^,2,s);

      Step:=111 div ShipData[SType].MaxMove;
      RECT(MyScreen[2]^,0,386,427,513,442);
      WRITE(498-Step*Repair,429,1,1,MyScreen[2]^,2,'#');

      if Repair=0 then s:='999' else
      if Shield=ShipData[SType].MaxShield then s:='---' else
      s:=intstr((ShipData[SType].MaxShield-Shield) div Repair);

      while length(s)<3 do s:='0'+s;
      WRITE(337,428,5,1,MyScreen[2]^,2,s);
      s:=intstr(ShipData[SType].MaxMove-Repair); while length(s)<3 do s:='0'+s;
      WRITE(522,428,5,1,MyScreen[2]^,2,s);
   end;
end;


begin
   MyShipPtr:=ObjPtr;
   if not (MyShipPtr^.SType in [8..24]) or (MyShipPtr^.Owner<>ActPlayerFlag) then exit;
   ModC:=GETTHESOUND(3);
   INITSCREEN(SCREEN_TECH);
   s:=PathStr[6]+Project[MyShipPtr^.SType]+'Tech.img';
   if not DISPLAYIMAGE(s,6,7,256,498,5,MyScreen[2]^,0) then begin end;
   with MyShipPtr^ do begin

      WRITE(290,15,1,0,MyScreen[2]^,4,Project[MyShipPtr^.SType]);
      case Weapon of
         WEAPON_GUN:       s:=PText[185];
         WEAPON_LASER:     s:=PText[186];
         WEAPON_PHASER:    s:=PText[187];
         WEAPON_DISRUPTOR: s:=PText[188];
         WEAPON_PTORPEDO:  s:=PText[189];
         otherwise s:=intstr(Weapon);
      end;
      s:='- '+PText[190]+':  '+s;
      WRITE(290,42,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[191]+':  '+intstr(round(ShipData[SType].WeaponPower*(Weapon/10+1)));
      WRITE(290,62,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[192]+':  '+intstr(ShipData[SType].MaxShield);
      WRITE(290,82,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[193]+':  '+intstr(ShieldBonus);
      WRITE(290,102,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[194]+':  '+realstr(Shield/ShipData[SType].MaxShield*100,2)+' %';
      WRITE(290,122,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[195]+':  '+intstr(ShipData[SType].MaxMove);
      WRITE(290,142,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[196]+':  '+intstr((Ladung and MASK_SIEDLER) div 16);
      WRITE(290,162,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[197]+':  '+intstr(Ladung and MASK_LTRUPPS);
      WRITE(290,182,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[198]+' '+intstr(round(Fracht / ShipData[Stype].MaxLoad*100))+'% belegt';
      WRITE(290,202,1,0,MyScreen[2]^,3,s);
      s:='- '+PText[199]+': ';
      if Age<200 then s:=s+intstr(Year-Age) else s:=s+' '+PText[200];
      WRITE(290,222,1,0,MyScreen[2]^,3,s);

      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(MyShipPtr^.Target)*sizeof(r_PlanetHeader));
      WRITEDATA;
      ScreenToFront(MyScreen[2]);
      repeat
         delay(RDELAY);
         if (LData^ and 64=0) then begin
            PLAYSOUND(1,300);
            if IBase^.MouseY in [455..480] then begin
               if (IBase^.MouseX in [380..410]) and (Repair<ShipData[SType].MaxMove) then Repair:=Repair+1;
               if (IBase^.MouseX in [490..525]) and (Repair>0) then Repair:=Repair-1;
               WRITEDATA;
            end;
            if IBase^.MouseY in [315..345] then begin
               if (IBase^.MouseX in [380..410])
                and (Tactical<ShipData[SType].WeaponPower-2)
                and (3*Tactical<Shield-2) then Tactical:=Tactical+1;
               if (IBase^.MouseX in [490..525])
                and (-3*Tactical<Shield-2)
                and (-Tactical<ShipData[SType].WeaponPower-2) then Tactical:=Tactical-1;
               WRITEDATA;
            end;
         end;
      until (RData^ and 1024=0);
   end;
   if ModC<>0 then begin
      StopPlayer;
      FreeMem(ModC,ModMemL[3]);
   end;
   PLAYSOUND(1,300);
   ScreenToFront(MyScreen[1]);
end;



procedure CHECKPROJECTS(PlanetPtr :ptr; NewOwner :byte);

var MyPlanetHeader      :^r_PlanetHeader;
var ActPProject         :^ByteArr42;
var i                   :byte;

begin
   MyPlanetHeader:=PlanetPtr;
   ActPProject:=MyPlanetHeader^.ProjectPtr;
   for i:=1 to 7 do if ActPProject^[i]>0 then with MyPlanetHeader^ do begin
      Save.ProjectCosts[GETCIVVAR(NewOwner),i]:=0;
      Save.ProjectCosts[GETCIVVAR(PFlags),i]:=abs(Year)*i*11;
      if (Save.CivPlayer[GETCIVVAR(PFlags)]<>0) or (Save.CivPlayer[GETCIVVAR(NewOwner)]<>0) then begin
         MAKEBORDER(MyScreen[1]^,85,118,425,200,12,6,0);
         s:=GETCIVNAME(GETCIVVAR(PFlags))+' '+PText[205];
         WRITE(256,130,PFlags and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
         s:=Project[i]+'-';
         WRITE(256,150,12,1+16,MyScreen[1]^,4,s);
         s:=PText[206]+' '+GETCIVNAME(GETCIVVAR(NewOwner));
         WRITE(256,171,NewOwner and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
         if Save.PlayMySelf then delay(PAUSE);
         WAITLOOP(Save.PlayMySelf);
         RECT(MyScreen[1]^,0,85,118,425,200);
      end;
   end;
end;



procedure SYSTEMTOENEMY(ActSys,NewOwner,OldOwner :byte);

var i                   :byte;
var MyPlanetHeader      :^r_PlanetHeader;
var MyShipPtr           :^r_ShipHeader;


begin
   for i:=0 to pred(SystemHeader[ActSys].Planets) do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+i*sizeof(r_PlanetHeader));
      with MyPlanetHeader^ do if PFlags and FLAG_CIV_MASK=OldOwner then  begin
         CHECKPROJECTS(MyPlanetHeader,NewOwner);
         PFlags:=NewOwner;
         MyShipPtr:=FirstShip.NextShip;
         while MyShipPtr<>NIL do begin
            MyShipPtr^.PosX:=round(PosX);
            MyShipPtr^.PosY:=round(PosY);
            LINKSHIP(MyShipPtr,^SystemHeader[ActSys].FirstShip,1);
            MyShipPtr:=FirstShip.NextShip;
         end;
      end;
   end;
end;



procedure PLAYERJINGLE(JingleID :byte);

var l           :long;
var Fname       :string;

begin
   if LogoSMemA[JingleID]=0 then begin
      FName:=PathStr[10]+intstr(JingleID)+'.RAW';
      FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
      if FHandle=0 then exit;
      l:=DosSeek(FHandle,0,OFFSET_END);
      LogoSMemL[JingleID]:=DosSeek(FHandle,0,OFFSET_BEGINNING);
      LogoSMemA[JingleID]:=AllocMem(LogoSMemL[JingleID],MEMF_FAST+MEMF_CLEAR);
      if LogoSMemA[JingleID]=0 then begin
         DosClose(FHandle);   exit;
      end;
      l:=DosRead(FHandle,ptr(LogoSMemA[JingleID]),LogoSMemL[JingleID]);
      DosClose(FHandle);
   end;
   if (SoundMemA[4]=0) or (SoundSize[4]*2<>LogoSMemL[JingleID]) then begin
      if SoundSize[4]<>0 then FreeMem(SoundMemA[4],SoundSize[4]*2);
      SoundSize[4]:=LogoSMemL[JingleID] div 2;
      SoundMemA[4]:=AllocMem(SoundSize[4]*2,MEMF_CHIP+MEMF_CLEAR);
      if SoundMemA[4]=0 then exit;
   end;
   CopyMemQuick(LogoSMemA[JingleID],SoundMemA[4],LogoSMemL[JingleID]);
   PLAYSOUND(4,300);
end;



procedure DISPLAYLOGO(ActPlayer :byte; Ledge,TEdge :word);

var FName               :string;
var ISize,l,ActMem      :long;

begin
   if LogoMemA[0]=0 then LogoMemA[0]:=AllocMem(LOGOSIZE,MEMF_CHIP+MEMF_CLEAR);
   if LogoMemA[0]<>0 then begin
      if LogoMemA[ActPlayer]=0 then begin
         LogoMemA[ActPlayer]:=AllocMem(LOGOSIZE,MEMF_FAST+MEMF_CLEAR);
         ActMem:=LogoMemA[ActPlayer];
         if ActMem=0 then ActMem:=LogoMemA[0];
         FName:=PathStr[11]+intstr(ActPlayer)+'.img';
         FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
         if FHandle<>0 then begin
            ISize:=DosSeek(FHandle,0,OFFSET_END);
            ISize:=DosSeek(FHandle,0,OFFSET_BEGINNING);
            l:=DosRead(FHandle,ptr(ActMem+LOGOSIZE-ISize-150),ISize);
            UNPACK(ActMem,ActMem+LOGOSIZE-ISize-150,14336,1);
            DosClose(FHandle);
         end;
      end;
      if LogoMemA[ActPlayer]>0 then CopyMemQuick(LogoMemA[ActPlayer],LogoMemA[0],LOGOSIZE);
      Img:=Image(0,0,128,128,7,ptr(LogoMemA[0]),127,0,NIL);
      DrawImage(^MyScreen[1]^.RastPort,^Img,LEdge,TEdge);
   end;
end;



procedure INFORMUSER;

begin
   if (Save.CivPlayer[ActPlayer]=0) or Informed or
   (Save.WarState[ActPlayer,ActPlayer]=LEVEL_DIED) then exit;
   Informed:=true;
   if LastPlayer=ActPlayer then exit;
   LastPlayer:=ActPlayer;
   Display:=LastDisplay[ActPlayer];
   RECT(MyScreen[1]^,0,523,10,630,117);
   if Multiplayer then begin
      if not Save.PlayMySelf then RECT(MyScreen[1]^,0,0,0,511,511);
      s:='Player '+intstr(Save.CivPlayer[ActPlayer]);
      PLAYERJINGLE(ActPlayer);
      MAKEBORDER(MyScreen[1]^,35,80,475,290,12,6,0);
      WRITE(256,100,12,16,MyScreen[1]^,4,PText[207]);
      WRITE(256,125,ActPlayerFlag,16,MyScreen[1]^,4,s);
      DISPLAYLOGO(ActPlayer,192,150);
      PRINTGLOBALINFOS(ActPlayer);
      if Save.PlayMySelf then delay(PAUSE);
      WAITLOOP(Save.PlayMySelf);
      if Display=0 then DRAWSTARS(MODE_REDRAW,ActPlayer) else DRAWSYSTEM(MODE_REDRAW,Display,NIL);
   end;
end;



procedure CHECKPLANET(MyPlanetHeader :PlanetHeader);

var HomeWorld,SplitWorld,i,j :byte;
var MyShipPtr                :ShipHeader;

begin
   HomeWorld:=0;
   with MyPlanetHeader^ do for i:=1 to (MAXCIVS-2) do
   if (PNames[i,3]=PName) and (GETCIVVAR(PFlags)=i) then HomeWorld:=i;
   if HomeWorld>0 then begin
      {*** Eroberte Civi abspalten ***}
      SplitWorld:=0;
      for i:=1 to Save.SYSTEMS do begin
         for j:=1 to SystemHeader[i].Planets do begin
            MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
            with MyPlanetHeader^ do if GETCIVVAR(PFlags)=HomeWorld then begin
               if (SplitWorld=0) and (Ethno<>PFlags and FLAG_CIV_MASK) then begin
                  if Ethno<>PFlags and FLAG_CIV_MASK then SplitWorld:=Ethno;
                  if Save.CivPlayer[ActPlayer]<>0 then begin
                     INFORMUSER;
                     MAKEBORDER(MyScreen[1]^,80,120,430,250,12,6,0);
                     WRITE(256,136,GETCIVFLAG(HomeWorld),1+16,MyScreen[1]^,4,PText[208]);
                     s:=GETCIVNAME(HomeWorld)+' '+PText[209];
                     WRITE(256,156,GETCIVFLAG(HomeWorld),1+16,MyScreen[1]^,4,s);
                     WRITE(256,176,GETCIVFLAG(HomeWorld),1+16,MyScreen[1]^,4,PText[210]);
                     WRITE(256,196,SplitWorld,1+16,MyScreen[1]^,4,PText[211]);
                     s:=GETCIVADJ(GETCIVVAR(Splitworld))+PText[212]+'!';
                     WRITE(256,216,SplitWorld,1+16,MyScreen[1]^,4,s);
                     if Save.PlayMySelf then begin
                        delay(PAUSE); delay(PAUSE);
                     end;
                     WAITLOOP(Save.PlayMySelf);
                     RECT(MyScreen[1]^,0,80,120,430,250);
                  end;
               end;
               if SplitWorld=Ethno then begin
                  PFlags:=Ethno;
                  if FirstShip.NextShip<>NIL then begin
                     MyShipPtr:=FirstShip.NextShip;
                     repeat
                        MyShipPtr^.Owner:=(PFlags and FLAG_CIV_MASK);
                        MyShipPtr:=MyShipPtr^.NextShip;
                     until MyShipPtr=NIL;
                  end;
               end;
            end;
         end;
      end;
   end;
end;



function GETCNUM(Depth :byte):byte;

var i,j   :integer;

begin
   j:=1;
   for i:=1 to Depth do j:=j*2;
   GETCNUM:=j-1;
end;



procedure REQUEST(s1,s2 :str; c1,c2 :byte);

begin
   MAKEBORDER(MyScreen[1]^,35,110,475,190,12,6,0);
   WRITE(256,130,c1,16,MyScreen[1]^,4,s1);
   WRITE(256,155,c2,16,MyScreen[1]^,4,s2);
   if Save.PlayMySelf then delay(PAUSE);
   WAITLOOP(Save.PlayMySelf);
   RECT(MyScreen[1]^,0,35,110,475,190);
   REFRESHDISPLAY;
end;



procedure STOPCIVILWAR(EndText :byte);

var CivVar,CivFlag,i,j  :byte;
var s                   :string;
var MyPlanetHeader      :PlanetHeader;
var MyShipPtr           :ShipHeader;
var ModC,ModL           :long;

begin
   ModC:=0;
   if Save.WorldFlag in [0,WFLAG_CEBORC,WFLAG_FIELD,WFLAG_DCON,WFLAG_JAHADR] then exit;
   INFORMUSER;
   CivVar:=GETCIVVAR(Save.WorldFlag);
   CivFlag:=Save.WorldFlag;
   Save.WorldFlag:=0;
   Save.Bevölkerung[8]:=0; Save.WarPower[8]:=0;
   Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]+Save.Staatstopf[8];
   Save.Staatstopf[8]:=0;
   if Save.CivPlayer[CivVar]<>0 then begin
      ModC:=GETTHESOUND(2);
      ModL:=ModMemL[2];
   end;
   if EndText=0 then begin
      s:=PText[215]+' '+GETCIVNAME(CivVar)+' '+PText[216];
      if Save.CivPlayer[CivVar]<>0 then REQUEST(s,PText[217],CivFlag,CivFlag);
   end else if EndText=1 then begin
      if Save.CivPlayer[CivVar]<>0 then REQUEST(PText[218],PText[219],CivFlag,CivFlag);
      for i:=1 to MAXCIVS-2 do if i<>CivVar then begin
         Save.WarState[i,CivVar]:=Save.WarState[i,8];
         Save.WarState[CivVar,i]:=Save.WarState[8,i];
      end;
   end else if EndText=2 then if Save.CivPlayer[CivVar]<>0 then
    REQUEST(PText[220],PText[221],CivFlag,CivFlag);
   for i:=1 to pred(MAXCIVS) do begin
      Save.WarState[i,8]:=LEVEL_UNKNOWN;
      Save.WarState[8,i]:=LEVEL_UNKNOWN
   end;
   for i:=1 to 42 do if Save.TechCosts[8,i]<=0 then Save.TechCosts[CivVar,i]:=0;
   for i:=1 to Save.SYSTEMS do begin
      if (SystemFlags[1,i] and FLAG_CIV_MASK=FLAG_OTHER)
       then SystemFlags[1,i]:=SystemFlags[1,i] and not FLAG_OTHER or CivFlag;
      with SystemHeader[i] do if FirstShip.NextShip<>NIL then begin
         MyShipPtr:=FirstShip.NextShip;
         repeat
            if MyShipPtr^.Owner=FLAG_OTHER then begin
               if random(100)<15 then begin
                  MyShipPtr^.Owner:=FLAG_MAQUES;
                  MyShipPtr^.Flags:=0;
                  MyShipPtr^.Target:=0;
               end else begin
                  MyShipPtr^.Owner:=CivFlag;
                  Save.WarPower[CivVar]:=Save.WarPower[CivVar]+round(ShipData[MyShipPtr^.SType].WeaponPower*(MyShipPtr^.Weapon/10+1));
               end;
            end;
            MyShipPtr:=MyShipPtr^.NextShip;
         until MyShipPtr=NIL;
      end;
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         with MyPlanetHeader^ do if GETCIVVAR(PFlags)=8 then begin
            PFlags:=CivFlag;
            if (Ethno and FLAG_CIV_MASK=FLAG_OTHER) then Ethno:=PFlags;
            Save.Bevölkerung[CivVar]:=Save.Bevölkerung[CivVar]+Population;
            if FirstShip.NextShip<>NIL then begin
               MyShipPtr:=FirstShip.NextShip;
               repeat
                  MyShipPtr^.Owner:=CivFlag;
                  Save.WarPower[CivVar]:=Save.WarPower[CivVar]+round(ShipData[MyShipPtr^.SType].WeaponPower*(MyShipPtr^.Weapon/10+1));
                  MyShipPtr:=MyShipPtr^.NextShip;
               until MyShipPtr=NIL;
            end;
         end;
      end;
   end;
   REFRESHDISPLAY;
   SETWORLDCOLORS;
   if ModC<>0 then begin
      StopPlayer;
      FreeMem(ModC,ModL);
   end;
end;



procedure DISPLAYTECH(TechID,CivVar :byte);

var s                   :string[50];
var Depth               :byte;
var l,Offset,ModC       :long;

begin
   if TechID=0 then exit;
   SWITCHDISPLAY;
   ModC:=GETTHESOUND(1);
   IMemID:=false;
   RECT(MyScreen[2]^,0,0,0,639,511);
   s:=Technology[TechID]+'.pal';
   if TechID=34 then s:='selbstSys.pal';
   if      TechID in [1..18]  then s:=PathStr[2]+s
   else if TechID in [19..38] then s:=PathStr[3]+s
   else if TechID in [39..42] then s:=PathStr[4]+s;
   Depth:=SETCOLOR(MyScreen[2]^,s);
   if Depth=0 then begin
      s:=PathStr[2]+'NoPic.pal';
      Depth:=SETCOLOR(MyScreen[2]^,s);
   end;
   s[length(s)-3]:=chr(0);
   s:=s+'.img';
   if not DISPLAYIMAGE(s,0,40,320,256,Depth,MyScreen[2]^,0) then begin end;

   WRITE(340,50,1,0,MyScreen[2]^,3,PText[223]);
   WRITE(340,70,1,0,MyScreen[2]^,4,TechnologyL[TechID]);
   if TechUse1[TechID]>0 then begin
      WRITE(340,110,1,0,MyScreen[2]^,4,PText[224]);
      WRITE(370,130,1,0,MyScreen[2]^,4,TechnologyL[TechUse1[TechID]]);
      if TechUse1[TechID]<>TechUse2[TechID] then WRITE(370,150,1,0,MyScreen[2]^,4,TechnologyL[TechUse2[TechID]]);
   end;
   if TechID<>27 then begin
      WRITE(340,190,1,0,MyScreen[2]^,4,PText[225]);
      l:=0;
      for CivVar:=1 to 42 do if TechUse1[CivVar]=TechID then l:=CivVar;
      for CivVar:=1 to 42 do if TechUse2[CivVar]=TechID then Offset:=CivVar;
      if l>0 then WRITE(370,210,1,0,MyScreen[2]^,4,TechnologyL[l]);
      if (l<>Offset) and (Offset in [1..42]) then WRITE(370,230,1,0,MyScreen[2]^,4,TechnologyL[Offset]);
   end;
   l:=320;
   for CivVar:=1 to 42 do if ProjectNeedsTech[CivVar]=TechID then begin
      if CivVar in [1..7] then s:=PText[226]
      else if CivVar in [8..24] then s:=PText[227]
      else s:=PText[228];
      s:=s+'  '+Project[CivVar];
      WRITE(20,l,1,0,MyScreen[2]^,4,s);
      l:=l+20;
   end;
   Screen2:=SCREEN_INVENTION;
   ScreenToFront(MyScreen[2]);
   if Save.PlayMySelf then delay(PAUSE*2);
   WAITLOOP(Save.PlayMySelf);
   if ModC<>0 then begin
      StopPlayer;
      FreeMem(ModC,ModMemL[1]);
   end;
   ScreenToFront(MyScreen[1]);
end;




function TAKETECH(CivFlag1,CivFlag2 :byte):boolean;

var i,TechID,CivVar1,CivVar2    :byte;

begin
   TAKETECH:=false;
   CivVar1:=GETCIVVAR(CivFlag1);
   CivVar2:=GETCIVVAR(CivFlag2);
   TechID:=0;
   for i:=41 downto 1 do
    if ((Save.TechCosts[CivVar1,i]>0) and (Save.TechCosts[CivVar2,i]<=0)) then TechID:=i;
   if TechID=0 then exit;
   if ((CivVar1=ActPlayer) or (CivVar2=ActPlayer))
   and ((Save.CivPlayer[CivVar1]<>0) or (Save.CivPlayer[CivVar2]<>0)) then begin
      MAKEBORDER(MyScreen[1]^,85,118,425,200,12,6,0);
      s:=GETCIVNAME(CivVar1)+' '+PText[230]+':';
      WRITE(256,140,CivFlag1,1+16,MyScreen[1]^,4,s);
      s:=TechnologyL[TechID];
      WRITE(256,160,12,1+16,MyScreen[1]^,4,s);
      if Save.PlayMySelf then delay(PAUSE);
      WAITLOOP(Save.PlayMySelf);
      RECT(MyScreen[1]^,0,85,118,425,200);
      REFRESHDISPLAY;
      if (CivFlag1=ActPlayerFlag) then DISPLAYTECH(TechID,CivVar1);
   end;
   Save.TechCosts[CivVar1,TechID]:=0;
   if Save.ActTech[CivVar1]=TechID then Save.ActTech[CivVar1]:=0;
   TAKETECH:=true;
end;



procedure PEACEINFO(CivVar1,CivVar2,CivFlag1,CivFlag2 :byte);

var s   :string;

begin
   INFORMUSER;
   MAKEBORDER(MyScreen[1]^,85,120,425,220,12,6,0);
   s:=GETCIVNAME(CivVar1);
   WRITE(256,132,CivFlag1,1+16,MyScreen[1]^,4,s);
   WRITE(256,152,12,1+16,MyScreen[1]^,4,PText[231]);
   s:=GETCIVNAME(CivVar2);
   WRITE(256,172,CivFlag2,1+16,MyScreen[1]^,4,s);
   WRITE(256,192,12,1+16,MyScreen[1]^,4,PText[232]);
   if Save.PlayMySelf then delay(PAUSE);
   WAITLOOP(Save.PlayMySelf);
   RECT(MyScreen[1]^,0,85,120,425,220);
   REFRESHDISPLAY;
   if (Save.WorldFlag in [CivFlag1,CivFlag2])
    and ((CivVar1=8) or (CivVar2=8)) then STOPCIVILWAR(0);
end;



procedure SYSINFO(SysID,ThePlayerFlag :byte);

var MyPlanetHeader      :^r_PlanetHeader;
var ActPProject         :^ByteArr42;
var SysPop,Buildings    :long;
var MyPlanets           :byte;
var j,i                 :byte;
var s                   :string;

begin
   RECT(MyScreen[1]^,0,30,250,480,360);
   if SysID=0 then exit;
   SysPop:=0; MyPlanets:=0; Buildings:=0;
   with SystemHeader[SysID] do for i:=0 to pred(Planets) do begin
      MyPlanetHeader:=ptr(PlanetMemA+i*sizeof(r_PlanetHeader));
      with MyPlanetHeader^ do if (PFlags and FLAG_CIV_MASK=ThePlayerFlag) then begin
         SysPop:=SysPop+Population;
         MyPlanets:=MyPlanets+1;
         ActPProject:=ProjectPtr;
         for j:=1 to 42 do if ActPProject^[j]>0 then Buildings:=Buildings+1;
      end;
   end;
   if MyPlanets>0 then begin
      MAKEBORDER(MyScreen[1]^,30,250,480,360,12,6,1);
      Buildings:=Buildings div MyPlanets +1;
      s:=PText[166]+': '+Save.SystemName[SysID];
      WRITE(256,260,SystemFlags[1,SysID] and FLAG_CIV_MASK,0+16,MyScreen[1]^,4,s);
      s:=PText[235]+': '+intstr(SysPop)+' '+PText[154];
      WRITE(256,290,ThePlayerFlag,0+16,MyScreen[1]^,4,s);
      s:=PText[236]+': '+intstr(SystemHeader[SysID].Planets)+', '+PText[237]+' '+intstr(MyPlanets)
        +' '+GETCIVADJ(GETCIVVAR(ThePlayerFlag));
      WRITE(256,310,ThePlayerFlag,0+16,MyScreen[1]^,4,s);
      if Buildings<3 then s:=PText[238]
      else if Buildings<5 then s:=PText[239]
      else if Buildings<10 then s:=PText[240]
      else if Buildings<18 then s:=PText[241]
      else if Buildings>=34 then s:=PText[242];
      WRITE(256,330,ThePlayerFlag,0+16,MyScreen[1]^,4,s);
   end;
end;



procedure VERHANDLUNG(CivFlag,Mode :byte);

type TextArr4=array [1..4] of str;

var CivStr,s,s2                 :string[55];
var XSystem,XTech,CivVar,i      :byte;
var XCosts                      :long;
var TArr4                       :TextArr4;


procedure INIT(Mode :byte);

begin
   MAKEBORDER(MyScreen[1]^,30,80,480,230,12,6,0);
   WRITE(256,90,CivFlag,0+16,MyScreen[1]^,4,CivStr);
   if Mode=1 then begin
      DrawImage(^MyScreen[1]^.RastPort,^GadImg1,60,200);
      DrawImage(^MyScreen[1]^.RastPort,^GadImg1,330,200);
      WRITE(118,202,0,16,MyScreen[1]^,4,PText[245]);
      WRITE(388,202,0,16,MyScreen[1]^,4,PText[246]);
   end;
end;



begin
   CivVar:=GETCIVVAR(CivFlag);
   if (Save.WorldFlag=WFLAG_CEBORC) and (CivFlag=FLAG_OTHER) then exit;
   if CivFlag=FLAG_MAQUES then exit;
   if CivVar=0 then exit;
   if (Mode in [MODE_OFFENSIV,MODE_DEFENSIV])
   and (Save.CivPlayer[CivVar]<>0) then begin
      Save.WarState[CivVar,ActPlayer]:=LEVEL_WAR;
      Save.WarState[ActPlayer,CivVar]:=LEVEL_WAR;
      exit;
   end;
   case CivFlag of
      FLAG_TERRA:  CivStr:=PText[247]
      FLAG_KLEGAN: CivStr:=PText[248];
      FLAG_REMALO: CivStr:=PText[249];
      FLAG_CARDAC: CivStr:=PText[250];
      FLAG_FERAGI: CivStr:=PText[251];
      FLAG_BAROJA: CivStr:=PText[252];
      FLAG_VOLKAN: CivStr:=PText[253];
      FLAG_OTHER:  case Save.WorldFlag of
                      WFLAG_DCON:   CivStr:=PText[254];
                      WFLAG_JAHADR: CivStr:=PText[255];
                      otherwise CivStr:=PText[256];
                   end;
      otherwise exit;
   end;
   XSystem:=0;
   for i:=1 to Save.SYSTEMS do if SystemFlags[1,i] and FLAG_CIV_MASK=ActPlayerFlag then XSystem:=i;
   XTech:=0;
   for i:=42 downto 1 do if (Save.TechCosts[CivVar,i]>0) and (Save.TechCosts[ActPlayer,i]<=0) then XTech:=i;
   XCosts:=abs(Year) * 46;
   if (CivVar=8) and (Save.WorldFlag=WFLAG_JAHADR) then begin
      if Save.WarState[ActPlayer,8]<>LEVEL_WAR then begin
         INIT(1);
         i:=2*(1+(Save.WarPower[8] div Save.WarPower[ActPlayer]));
         if Mode=MODE_FORCE then begin
            s:=PText[260]+' '+GETCIVNAME(ActPlayer)+' '+PText[231];
            WRITE(256,110,FLAG_OTHER,16,MyScreen[1]^,4,s);
            WRITE(256,130,FLAG_OTHER,16,MyScreen[1]^,4,PText[261]);
            WRITE(256,150,FLAG_OTHER,16,MyScreen[1]^,4,PText[262]);
         end else begin
            WRITE(256,110,FLAG_OTHER,16,MyScreen[1]^,4,PText[263]);
            WRITE(256,130,FLAG_OTHER,16,MyScreen[1]^,4,PText[264]);
            WRITE(256,150,FLAG_OTHER,16,MyScreen[1]^,4,PText[265]);
         end;
         if Save.JSteuer[ActPlayer]=0 then s:=PText[266]+' '+intstr(i)+'% '+PText[267]
         else s:=PText[268];
         WRITE(256,170,FLAG_OTHER,16,MyScreen[1]^,4,s);
         repeat
            delay(RDELAY);
         until (LData^ and 64=0) and (IBase^.MouseY in [200..220]) and (IBase^.MouseX in [60..176,330..446]);
         SYSINFO(0,0);
         if IBase^.MouseX in [60..176] then begin
            KLICKGAD(60,200);
            RECT(MyScreen[1]^,0,30,80,480,230);
            if Save.JSteuer[ActPlayer] in [1..99] then Save.JSteuer[ActPlayer]:=Save.JSteuer[ActPlayer]+1
            else Save.JSteuer[ActPlayer]:=i;
            Save.WarState[8,ActPlayer]:=LEVEL_PEACE;
            Save.WarState[ActPlayer,8]:=LEVEL_PEACE;
            PEACEINFO(ActPlayer,8,ActPlayerFlag,FLAG_OTHER);
            exit;
         end;
         KLICKGAD(330,200);
         INIT(0);
         WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[270]);
         WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[271]);
         s:=PText[272]+' '+GETCIVADJ(ActPlayer)+' '+PText[273];
         WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,s);
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,80,480,230);
         Save.JSteuer[ActPlayer]:=0;
         Save.WarState[CivVar,ActPlayer]:=LEVEL_WAR;
         Save.WarState[ActPlayer,CivVar]:=LEVEL_WAR;
         exit;
      end else if (Save.WarPower[8]*2>Save.WarPower[ActPlayer]) then begin
         if (Year mod 6=0) then begin
            INIT(1);
            WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[275]);
            WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[276]);
            WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,PText[277]);
            i:=2*(1+(Save.WarPower[8] div Save.WarPower[ActPlayer]));
            if i>53 then i:=53;
            s:=PText[278]+' '+intstr(i)+'% '+PText[279];
            WRITE(256,170,CivFlag,0+16,MyScreen[1]^,4,s);
            repeat
               delay(RDELAY);
            until (LData^ and 64=0) and (IBase^.MouseY in [200..220]) and (IBase^.MouseX in [60..176,330..446]);
            if IBase^.MouseX in [60..176] then begin
               KLICKGAD(60,200);
               RECT(MyScreen[1]^,0,30,80,480,230);
               Save.JSteuer[ActPlayer]:=i;
               Save.WarState[8,ActPlayer]:=LEVEL_PEACE;
               Save.WarState[ActPlayer,8]:=LEVEL_PEACE;
               PEACEINFO(ActPlayer,8,ActPlayerFlag,FLAG_OTHER);
               exit;
            end;
            KLICKGAD(330,200);
            RECT(MyScreen[1]^,0,30,80,480,230);
            exit;
         end else if Mode=MODE_FORCE then begin
            INIT(0);
            WRITE(256,115,CivFlag,0+16,MyScreen[1]^,4,PText[280]);
            WAITLOOP(false);
            RECT(MyScreen[1]^,0,30,80,480,230);
            exit;
         end;
      end else if Save.WarPower[8]*2>Save.WarPower[ActPlayer] then exit;
   end;
   if Mode=MODE_BELEIDIGUNG then begin
      INIT(0);
      WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[282]);
      WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[283]);
      WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,PText[284]);
      WAITLOOP(false);
      RECT(MyScreen[1]^,0,30,80,480,230);
      Save.WarState[CivVar,ActPlayer]:=LEVEL_WAR;
      Save.WarState[ActPlayer,CivVar]:=LEVEL_WAR;
      exit;
   end else if Mode in [MODE_OFFENSIV,MODE_MONEY,MODE_FORCE] then begin
      if Save.WarState[CivVar,ActPlayer]<>LEVEL_WAR then begin
         INIT(1);
         if Mode<>MODE_MONEY then Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]-50;
         s2:=PText[285]+' '+GETCIVADJ(ActPlayer)+' '+PText[286];
         TArr4:=TextArr4(s2,PText[287],'','');
         if Mode=MODE_MONEY then begin
            s:=PText[290]+' '+intstr(XCosts)+', '+PText[291];
            s2:=PText[292]+' '+GETCIVADJ(ActPlayer);
            TArr4:=TextArr4(PText[293],s,s2,PText[294]);
         end else if (Save.WarPower[ActPlayer]<Save.WarPower[CivVar]*3) and (XSystem>0) then begin
            TArr4[3]:=PText[295];
            s:=PText[174]+' '+Save.SystemName[XSystem]+'.';
            TArr4[4]:=^s;
            SYSINFO(XSystem,ActPlayerFlag);
         end else if (Save.WarPower[ActPlayer]<Save.WarPower[CivVar]*4) and (XTech>0) then begin
            s:=' '+TechnologyL[XTech]+'.';
            if XTech in [12,13,15,18,20,23,24,28,30,33,36] then s:=PText[296]+s
            else if XTech in [3,17,21,25,31] then s:=PText[297]+s else s:=PText[298]+s;
            TArr4[3]:=PText[299];
            TArr4[4]:=^s;
         end else begin
            s:=intstr(XCosts);
            TArr4[3]:=PText[300];
            TArr4[4]:=^s;
         end;
         for i:=1 to 4 do WRITE(256,i*20+90,CivFlag,16,MyScreen[1]^,4,TArr4[i]);
         repeat
            delay(RDELAY);
         until (LData^ and 64=0) and (IBase^.MouseY in [200..220]) and (IBase^.MouseX in [60..176,330..446]);
         SYSINFO(0,0);
         if IBase^.MouseX in [60..176] then begin
            KLICKGAD(60,200);
            RECT(MyScreen[1]^,0,30,80,480,230);
            if (Save.WarPower[ActPlayer]<Save.WarPower[CivVar]*2) and (XSystem>0) then SYSTEMTOENEMY(XSystem,CivFlag,ActPlayerFlag)
            else if (Save.WarPower[ActPlayer]<Save.WarPower[CivVar]*3) and (XTech>0) then Save.TechCosts[XTech,CivVar]:=0
            else BEGIN
               Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]+XCosts;
               Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-XCosts;
            end;
            Save.WarState[CivVar,ActPlayer]:=LEVEL_PEACE;
            Save.WarState[ActPlayer,CivVar]:=LEVEL_PEACE;
            PEACEINFO(ActPlayer,CivVar,ActPlayerFlag,CivFlag);
            exit;
         end;
         KLICKGAD(330,200);
         INIT(0);
         WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[305]);
         WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[306]);
         s:=PText[298]+' '+GETCIVNAME(ActPlayer)+' '+PText[307];
         WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,s);
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,80,480,230);
         Save.WarState[CivVar,ActPlayer]:=LEVEL_WAR;
         Save.WarState[ActPlayer,CivVar]:=LEVEL_WAR;
         exit;
      end;
      if (Save.WarState[CivVar,ActPlayer]=LEVEL_WAR) and (Save.WarPower[CivVar]*2<Save.WarPower[ActPlayer])
      and ((Year mod 6=0) or (Mode=MODE_FORCE)) then begin
         INIT(1);
         WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[308]);
         WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[309]);
         repeat
            delay(RDELAY);
         until (LData^ and 64=0) and (IBase^.MouseY in [200..220]) and (IBase^.MouseX in [60..176,330..446]);
         if IBase^.MouseX in [60..176] then begin
            KLICKGAD(60,200);
            RECT(MyScreen[1]^,0,30,80,480,250);
            Save.WarState[CivVar,ActPlayer]:=LEVEL_PEACE;
            Save.WarState[ActPlayer,CivVar]:=LEVEL_PEACE;
            PEACEINFO(ActPlayer,CivVar,ActPlayerFlag,CivFlag);
            exit;
         end;
         KLICKGAD(330,200);
         RECT(MyScreen[1]^,0,30,80,480,250);
      end else if Mode=MODE_FORCE then begin
         MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
         s:=PText[310]+' '+GETCIVNAME(ActPlayer);
         WRITE(256,140,CivFlag,16,MyScreen[1]^,4,s);
         WRITE(256,165,CivFlag,16,MyScreen[1]^,4,PText[311]);
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,85,120,425,200);
         REFRESHDISPLAY;
      end;
   end else if Mode in [MODE_DEFENSIV,MODE_TERRITORIUM] then begin
      if random(3)=0 then exit;
      if XSystem<>0 then begin
         INIT(1);
         if Mode=MODE_TERRITORIUM then begin
            WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[315]);
            WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[316]);
            WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,PText[317]);
         end else begin
            WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[318]);
            WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[319]);
            WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,PText[320]);
         end;
         s:=GETCIVADJ(ActPlayer)+' '+PText[321]+' '+Save.SystemName[XSystem]+'.';
         WRITE(256,170,CivFlag,0+16,MyScreen[1]^,4,s);
         SYSINFO(XSystem,ActPlayerFlag);
         repeat
            delay(RDELAY);
         until (LData^ and 64=0) and (IBase^.MouseY in [200..220]) and (IBase^.MouseX in [60..176,330..446]);
         SYSINFO(0,0);
         if IBase^.MouseX in [60..176] then begin
            KLICKGAD(60,200);
            RECT(MyScreen[1]^,0,30,80,480,230);
            SYSTEMTOENEMY(XSystem,CivFlag,ActPlayerFlag);
            Save.WarState[CivVar,ActPlayer]:=LEVEL_PEACE;
            Save.WarState[ActPlayer,CivVar]:=LEVEL_PEACE;
            if random(100)<25 then XSystem:=0 else begin
               PEACEINFO(ActPlayer,CivVar,ActPlayerFlag,CivFlag);
               exit;
            end;
         end else begin
            KLICKGAD(330,200);
            RECT(MyScreen[1]^,0,30,80,480,230);
            if Save.WarState[CivVar,ActPlayer]=LEVEL_WAR then exit;
         end;
         INIT(0);
         if Mode=MODE_TERRITORIUM then begin
            WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[325]);
            WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[326]);
            s:='den Krieg gegen die '+GETCIVNAME(ActPlayer)+'!';
            WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,s);
         end else begin
            WRITE(256,110,CivFlag,0+16,MyScreen[1]^,4,PText[327]);
            WRITE(256,130,CivFlag,0+16,MyScreen[1]^,4,PText[328]);
            s:=PText[329]+' '+GETCIVADJ(ActPlayer)+PText[330];
            WRITE(256,150,CivFlag,0+16,MyScreen[1]^,4,s);
         end;
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,80,480,230);
         Save.WarState[CivVar,ActPlayer]:=LEVEL_WAR;
         Save.WarState[ActPlayer,CivVar]:=LEVEL_WAR;
      end;
   end;
end;



procedure GOTOPEACE(CivVar1,CivVar2 :byte);

begin
   Save.WarState[CivVar1,CivVar2]:=LEVEL_PEACE;
   Save.WarState[CivVar2,CivVar1]:=LEVEL_PEACE;
   if (Save.WarState[CivVar1,ActPlayer]=LEVEL_UNKNOWN) and (Save.WarState[CivVar2,ActPlayer]=LEVEL_UNKNOWN) then exit;
   if Save.WarState[CivVar1,ActPlayer]=LEVEL_ALLIANZ then begin
      Save.WarState[CivVar1,ActPlayer]:=LEVEL_PEACE;
      Save.WarState[ActPlayer,CivVar1]:=LEVEL_PEACE;
   end;
   if Save.WarState[CivVar2,ActPlayer]=LEVEL_ALLIANZ then begin
      Save.WarState[CivVar2,ActPlayer]:=LEVEL_PEACE;
      Save.WarState[ActPlayer,CivVar2]:=LEVEL_PEACE;
   end;
   PEACEINFO(CivVar1,CivVar2,GETCIVFLAG(CivVar1),GETCIVFLAG(CivVar2));
end;



procedure AUTOVERHANDLUNG(CivFlag1,CivFlag2,ActSys,Mode :byte);

var CivVar1,CivVar2,i,XSystem   :byte;

begin
   if (Save.WorldFlag=WFLAG_CEBORC) and ((CivFlag1=FLAG_OTHER) or (CivFlag2=FLAG_OTHER)) then exit;
   CivVar1:=GETCIVVAR(CivFlag1);
   CivVar2:=GETCIVVAR(CivFlag2);
   if (CivVar1 in [0,9]) or (CivVar2 in [0,9]) then exit;
   if (CivVar1=ActPlayer) or (CivVar2=ActPlayer) then INFORMUSER;
   if not Save.PlayMySelf and
   ((Save.CivPlayer[CivVar1]<>0) or (Save.CivPlayer[CivVar2]<>0)) then begin
      if (Mode in [MODE_TERRITORIUM,MODE_BELEIDIGUNG]) then begin
         if (CivFlag1=ActPlayerFlag) or (CivFlag2=ActPlayerFlag) then begin
            VERHANDLUNG(CivFlag1,Mode);
            REFRESHDISPLAY;
            exit;
         end;
      end else begin
         if CivFlag1=ActPlayerFlag then begin
            VERHANDLUNG(CivFlag2,MODE_OFFENSIV);
            REFRESHDISPLAY;
            exit;
         end else if CivFlag2=ActPlayerFlag then begin
            VERHANDLUNG(CivFlag1,MODE_DEFENSIV);
            REFRESHDISPLAY;
            exit;
         end;
      end;
      exit;
   end;
   if Year mod 4<>0 then exit;
   if (CivVar1=8) and (Save.WorldFlag=WFLAG_JAHADR)
   and (Save.WarPower[8]>Save.WarPower[CivVar2]*2) then begin
      if Save.JSteuer[CivVar2] in [1..99] then Save.JSteuer[CivVar2]:=Save.JSteuer[CivVar2]+1
      else begin
         Save.JSteuer[CivVar2]:=2*(1+(Save.WarPower[8] div succ(Save.WarPower[CivVar2])));
         if Save.JSteuer[CivVar2]>53 then Save.JSteuer[CivVar2]:=53;
      end;
      GOTOPEACE(CivVar1,CivVar2);
      exit;
   end else begin
      Save.JSteuer[CivVar2]:=0;
      exit;
   end;
   if Save.WarPower[CivVar1]>Save.WarPower[CivVar2]*5 then exit;
   if Save.WarPower[CivVar1]>Save.WarPower[CivVar2]*3 then begin
      if TAKETECH(CivFlag1,CivFlag2) then begin
         GOTOPEACE(CivVar1,CivVar2);
         exit;
      end;
   end;
   if Save.WarPower[CivVar1]>Save.WarPower[CivVar2]*2 then begin
      Save.Staatstopf[CivVar1]:=Save.Staatstopf[CivVar1]+abs(Year*10);
      Save.Staatstopf[CivVar2]:=Save.Staatstopf[CivVar2]-abs(Year*10);
      GOTOPEACE(CivVar1,CivVar2);
   end;
end;



procedure PLANETINFO(ActSys :byte);

const MAXPROJECT=30;

type SArr6=array [1..6] of str;

var SA6                 :SArr6;
var c,x,y,l             :long;
var i,j                 :integer;
var PlanetHeader        :^r_PlanetHeader;

begin
   PlanetHeader:=ObjPtr;
   with PlanetHeader^ do if (PFlags and FLAG_CIV_MASK<>ActPlayerFlag) then begin
      MAKEBORDER(MyScreen[1]^,81,81,428,278,12,6,0);
      MAKEBORDER(MyScreen[1]^,90,90,161,161,12,6,1);
      j:=12;
      if PFlags>0 then j:=PFlags;
      s:=realstr(Size/10,2)+' '+PText[171];
      WRITE(170,114,j,0,MyScreen[1]^,4,s);
      s:=PText[168]+' ';
      case Class of
         CLASS_DESERT    : s:=s+'D';
         CLASS_HALFEARTH : s:=s+'H';
         CLASS_EARTH     : s:=s+'M';
         CLASS_SATURN    : s:=s+'S';
         CLASS_GAS       : s:=s+'G';
         CLASS_ICE       : s:=s+'I';
         CLASS_PHANTOM   : s:=s+'P';
         CLASS_STONES    : s:=s+'T';
         CLASS_WATER     : s:=s+'W';
      end;
      s:=s+'-'+PText[167];
      WRITE(170,134,j,0,MyScreen[1]^,4,s);
      i:=round((abs(PosX)+abs(PosY))/3.4);
      l:=(13-i)*(13-i)*(13-i) div 3 -270;
      WRITE(170,94,j,0,MyScreen[1]^,4,PName);
      if Class in [CLASS_SATURN,CLASS_GAS] then s:=PText[332]+' '
      else s:=PText[333]+' ';
      case Class of
         CLASS_DESERT:    begin
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=SArr6(PText[334],PText[335],PText[336],PText[337],
                                        PText[338],s);
                             l:=5;
                          end;
         CLASS_HALFEARTH: begin     
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=Sarr6(PText[340],PText[341],PText[342],PText[343],
                                        PText[344],s);
                             l:=4;
                          end;
         CLASS_EARTH:     begin
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=SArr6(PText[346],PText[347],PText[348],PText[349],
                                        PText[350],s);
                             l:=6;
                          end;
         CLASS_SATURN:    begin
                             s:=s+intstr(l)+' .. '+intstr(l+(12-i)*10)+ '°C';
                             SA6:=SArr6(PText[352],PText[353],PText[354],PText[355],
                                        PText[356],s);
                             l:=3;
                          end;
         CLASS_GAS:       begin
                             s:=s+intstr(l)+' .. '+intstr(l+(12-i)*10)+ '°C';
                             SA6:=SArr6(PText[358],PText[359],PText[360],PText[361],
                                        PText[362],s);
                             l:=1;
                          end;
         CLASS_ICE:       begin
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=SArr6(PText[364],PText[365],PText[366],PText[367],
                                        PText[368],s);
                             l:=8;
                          end;
         CLASS_PHANTOM:   begin
                             SA6:=SArr6(PText[370],PText[371],'','','','');
                             l:=7;
                          end;
         CLASS_STONES:    begin
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=SArr6(PText[373],PText[374],PText[375],PText[376],
                                        PText[377],s);
                             l:=0;
                          end;
         CLASS_WATER:     begin
                             s:=s+intstr(Water div Size)+'%';
                             SA6:=SArr6(PText[379],PText[380],PText[381],PText[382],
                                        PText[383],s);
                             l:=2;
                          end;
         otherwise;
      end;
      for i:=1 to 6 do WRITE(90,i*17+151,12,0,MyScreen[1]^,3,SA6[i]);
      x:=0; y:=0;
      repeat
         delay(RDELAY);
         if (x<32) and (y<32) then begin
            BltBitMapRastPort(^ImgBitMap7,l*32+x,y,^MyScreen[1]^.RastPort,x*2+93,y*2+93,1,1,192);
            BltBitMapRastPort(^ImgBitMap7,l*32+x,y,^MyScreen[1]^.RastPort,x*2+94,y*2+93,1,1,192);
            BltBitMapRastPort(^ImgBitMap7,l*32+x,y,^MyScreen[1]^.RastPort,x*2+93,y*2+94,1,1,192);
            BltBitMapRastPort(^ImgBitMap7,l*32+x,y,^MyScreen[1]^.RastPort,x*2+94,y*2+94,1,1,192);
            x:=x+1;
            if x>31 then begin
               x:=1; y:=y+1;
            end;
         end;
      until (LData^ and 64=0) or (RData^ and 1024=0);
      PLAYSOUND(1,300);
      RECT(MyScreen[1]^,0,80,80,430,280);
      REFRESHDISPLAY;
   end else HANDLEKNOWNPLANET(ActSys,0,PlanetHeader);
end;



procedure AUTOSHIPTRAVEL(ActSys,Mode :byte; ShipPtr :ptr);
forward;



procedure  CLOCK;

var LastSec,Stunde,Minute,Rest  :long;

begin
   with IBase^ do begin;
      LastSec:=IBase^.Seconds;
      if LastSec mod 5<>0 then exit;
      Stunde:=LastSec div 3600;        Rest:=Stunde*3600;
      Minute:=(LastSec-Rest) div 60;   Rest:=Rest+Minute*60;
      Stunde:=Stunde-(Stunde div 24 * 24);
      s:='';
      if Stunde<10 then s:=s+'0';      s:=s+intstr(Stunde)+':';
      if Minute<10 then s:=s+'0';      s:=s+intstr(Minute);
      if (Stunde in [0..8,22..23]) and not DoClock then begin
         DoClock:=true;
         MAKEBORDER(MyScreen[1]^,537,350,614,372,29,12,0);
      end;
      if DoClock then WRITE(541,354,8,1,MyScreen[1]^,2,s);
   end;
end;



procedure CEBORCATTACK(ActPlayerFlag :byte);

var i,j         :byte;
var l           :long;
var MyShipPtr   :^r_ShipHeader;

begin
   if not Save.WorldFlag in [0,WFLAG_CEBORC] then exit;
   Save.WorldFlag:=WFLAG_CEBORC;
   if ActPlayerFlag<>0 then begin
      l:=0;
      for i:=1 to Save.SYSTEMS do
       if SystemFlags[1,i] and FLAG_CIV_MASK=ActPlayerFlag then l:=1;
      if l=0 then exit;
   end;
   repeat
      j:=random(Save.SYSTEMS)+1;
   until (ActPlayerFlag=0)
   or (SystemFlags[1,j] and FLAG_CIV_MASK=ActPlayerFlag);
   for i:=1 to pred(MAXCIVS) do Save.WarState[8,i]:=LEVEL_COLDWAR;
   for i:=1 to (random(11)+6) do begin
      Save.Bevölkerung[8]:=Save.Bevölkerung[8]+1;
      l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
      MyShipPtr:=ptr(l);
      if random(100)<40 then l:=20 else l:=23;
      MyShipPtr^:=r_ShipHeader(0,l,FLAG_OTHER,0,100,1,0,random(20)-40,random(20)-40,
                               ShipData[l].MaxShield,WEAPON_PTORPEDO,1,
                               ShipData[l].MaxMove,0,0,0,NIL,NIL,NIL);
      LINKSHIP(MyShipPtr,^SystemHeader[j].FirstShip,0);
   end;
end;



function CREATEMAQUESSHIP(SysID,ShipID :byte):boolean;

var ActShipPtr  :^r_ShipHeader;
var i           :byte;
var l           :long;

begin
   CREATEMAQUESSHIP:=false;
   if (Year>=2000) and (random(4)>0) then exit;
   CREATEMAQUESSHIP:=true;
   l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
   if l=0 then exit;
   ActShipPtr:=ptr(l);
   if ShipID>8 then ShipID:=ShipID-1;
   ActShipPtr^:=r_ShipHeader(0,ShipID,FLAG_MAQUES,0,0,0,0,0,0,
                             ShipData[ShipID].MaxShield,1,1,
                             -10,0,0,0,NIL,NIL,NIL);
                            {Age,SType,Owner,Flags,ShieldBonus,Ladung,Fracht,PosX,PosY,
                             Shield,Weapon,Repair
                             Moving,Source,Target,Tactical,TargetShip,BeforeShip,NextShip}
   with ActShipPtr^ do begin
      Weapon:=WEAPON_GUN;
      if Save.TechCosts[ActPlayer,15]<=0 then Weapon:=WEAPON_LASER;
      if Save.TechCosts[ActPlayer,24]<=0 then Weapon:=WEAPON_PHASER;
      if Save.TechCosts[ActPlayer,32]<=0 then Weapon:=WEAPON_DISRUPTOR;
      if Save.TechCosts[ActPlayer,27]<=0 then Weapon:=WEAPON_PTORPEDO;
   end;
   LINKSHIP(ActShipPtr,^SystemHeader[SysID].FirstShip,0);
   for i:=1 to pred(MAXCIVS) do begin
      Save.WarState[9,i]:=LEVEL_WAR;     Save.WarState[i,9]:=LEVEL_WAR;
      Save.LastWarState[9,i]:=LEVEL_WAR; Save.LastWarState[i,9]:=LEVEL_WAR;
   end;
   Save.WarState[9,9]:=LEVEL_PEACE;
end;



procedure CREATECIVILWAR(CivVar :byte);

var i,j,CivFlag         :byte;
var MyPlanetHeader      :PlanetHeader;
var MyShipPtr           :ShipHeader;
var s                   :string;
var ModC,ModL           :long;

begin
   CivFlag:=GETCIVFLAG(CivVar);
   ModC:=0;
   if not Save.WorldFlag in [0,CivFlag] then exit;
   if Save.WorldFlag=0 then begin
      s:=PText[385]+' '+GETCIVNAME(CivVar)+' '+PText[386];
      if Save.CivPlayer[CivVar]<>0 then begin
         ModC:=GETTHESOUND(2);
         ModL:=ModMemL[2];
         REQUEST(s,PText[387],CivFlag,CivFlag);
      end;
      for i:=1 to pred(MAXCIVS) do begin
         Save.WarState[i,8]:=LEVEL_PEACE;
         Save.WarState[8,i]:=LEVEL_PEACE
      end;
      Save.WarState[CivVar,8]:=LEVEL_WAR;
      Save.WarState[8,CivVar]:=LEVEL_WAR;
      Save.GSteuer[8]:=0;
      Save.Staatstopf[8]:=-5000;
      for i:=1 to 42 do begin
         Save.TechCosts[8,i]:=Save.TechCosts[CivVar,i];
         Save.ProjectCosts[8,i]:=Save.ProjectCosts[CivVar,i];
      end;
   end;
   Save.WorldFlag:=CivFlag;
   Save.CivilWar:=CivVar;
   SETWORLDCOLORS;
   for i:=1 to Save.SYSTEMS do begin
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         with MyPlanetHeader^ do if (GETCIVVAR(PFlags)=CivVar) and (random(100)>=50) then begin
            PFlags:=FLAG_OTHER;
            Save.Bevölkerung[8]:=Save.Bevölkerung[8]+Population;
            if FirstShip.NextShip<>NIL then begin
               MyShipPtr:=FirstShip.NextShip;
               repeat
                  MyShipPtr^.Owner:=(PFlags and FLAG_CIV_MASK);
                  Save.WarPower[8]:=Save.WarPower[8]+round(ShipData[MyShipPtr^.SType].WeaponPower*(MyShipPtr^.Weapon/10+1));
                  MyShipPtr:=MyShipPtr^.NextShip;
               until MyShipPtr=NIL;
            end;
         end;
      end;
   end;
   if ModC<>0 then begin
      StopPlayer;
      FreeMem(ModC,ModL);
   end;
   if Save.WarPower[8]*3<Save.WarPower[CivVar]-Save.WarPower[8] then CREATECIVILWAR(CivVar);
end;



procedure PUMPUPTHELEVEL;

var b   :boolean;
var i,j :byte;

begin
   b:=false;
   repeat
      case random(5) of
         0: if Save.WorldFlag in [0,WFLAG_CEBORC] then begin
               CEBORCATTACK(ActPlayerFlag);
               b:=true;
            end;
         1: if Save.WorldFlag in [0,WFLAG_JAHADR] then for i:=1 to MAXCIVS-2 do
            if (i<>ActPlayer) and not b and (Save.WarPower[i]>Save.WarPower[ActPlayer]) then begin
               CREATEJAHADR(i);
               b:=true;
            end;
         2: begin
               for i:=1 to MAXCIVS-2 do for j:=1 to MAXCIVS-2 do
               if (Save.WarState[i,j]<>LEVEL_DIED) and (Save.WarState[j,i]<>LEVEL_DIED) then begin
                  if (i<>ActPlayer) and (j<>ActPlayer)
                  and (Save.CivPlayer[i]=0) and (Save.CivPlayer[j]=0)
                  then begin
                     Save.WarState[i,j]:=LEVEL_PEACE;
                     Save.WarState[j,i]:=LEVEL_PEACE;
                     Save.Staatstopf[i]:=Save.Staatstopf[i]+5000;
                     Save.Staatstopf[j]:=Save.Staatstopf[j]+5000;
                  end else if (i<>j) then begin
                     Save.WarState[i,j]:=LEVEL_COLDWAR;
                     Save.WarState[j,i]:=LEVEL_COLDWAR;
                  end;
               end;
               b:=true;
            end;
         3: begin
               for i:=1 to 25 do repeat until CREATEMAQUESSHIP(i,random(5)+19);
               b:=true;
            end;
         4: if Save.WorldFlag in [0,ActPlayerFlag] then begin
               CREATECIVILWAR(ActPlayer);
               b:=true;
            end;
      end;
   until b;
   REQUEST(PText[388],PText[389],12,12);
end;



procedure STARDESASTER(ActSys :byte, ShipPtr :ptr);

type NameArr=array[0..25] of char;

var NArr                :NameArr;
var i,j,k               :byte;
var MyPlanetHeader      :^r_PlanetHeader;
var MyShipPtr           :^r_ShipHeader;
var ActPPRoject         :^ByteArr42;
var b                   :boolean;
var l                   :long;



procedure FUCKSYSTEM;

begin
   for i:=1 to SystemHeader[ActSys].Planets do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(i)*sizeof(r_PlanetHeader));
      with MyPlanetHeader^ do if not (Class in [CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM]) then begin
         if ProjectPtr<>NIL then begin
            ActPProject:=Ptr(ProjectPtr);
            for j:=1 to 7 do if ActPProject^[j]>0 then Save.ProjectCosts[GETCIVVAR(PFlags),j]:=abs(Year)*j*10;
            for j:=8 to 42 do ActPProject^[j]:=0;
         end;
         Class:=CLASS_DESERT;
         Water:=Size*12;
         PFlags:=0;
         Ethno:=0;         Population:=0;
         Biosphäre:=0;
         Industrie:=0;     Infrastruktur:=0;
         XProjectCosts:=0; XProjectPayed:=0;
         ProjectID:=0;
      end;
      with MyPlanetHeader^ do if FirstShip.NextShip<>NIL then begin
         MyShipPtr:=FirstShip.NextShip;
         repeat
            MyShipPtr^.Owner:=0;
            MyShipPtr:=MyShipPtr^.NextShip;
         until MyShipPtr=NIL;
      end;
      if SystemHeader[ActSys].FirstShip.NextShip<>NIL then begin
         SystemHeader[ActSys].FirstShip.SType:=0;
         MyShipPtr:=SystemHeader[ActSys].FirstShip.NextShip;
         repeat
            MyShipPtr^.Owner:=0;
            MyShipPtr:=MyShipPtr^.NextShip;
         until MyShipPtr=NIL;
      end;
   end;
   DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   for i:=1 to 5 do begin
      SetRGB32(^MyScreen[1]^.ViewPort,0,$FF000000,$FF000000,$FF000000);
      PLAYSOUND(2,1200+random(250));
      delay(random(10)+1);
      SetRGB32(^MyScreen[1]^.ViewPort,0,0,0,0);
      delay(random(10)+1);
   end;
   delay(100);
end;


begin
   MyShipPtr:=ShipPtr;
   if Save.WorldFlag=WFLAG_FIELD then begin
      Save.SYSTEMS:=MAXSYSTEMS;
      Save.WorldFlag:=0;
      PLAYSOUND(3,420);
      MAKEBORDER(MyScreen[1]^,50,100,460,180,12,6,0);
      WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[391]);
      WRITE(256,130,ActPlayerFlag,16,MyScreen[1]^,4,PText[392]);
      WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,PText[393]);
      WAITLOOP(false);
      RECT(MyScreen[1]^,0,50,100,460,180);
      REFRESHDISPLAY;
      exit;
   end;
   Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]-500;
   if Save.WorldFlag<>0 then begin
      FUCKSYSTEM;
      exit;
   end;
   Save.GSteuer[8]:=0;
   case random(5) of
      0: FUCKSYSTEM;  { SONNENSYS ZERSTÖRT }
      1: begin        { NEUVERTEILUNG DER KRÄFTE }
            PLAYSOUND(3,420);
            Year:=Year-random(250)+75;
            MAKEBORDER(MyScreen[1]^,50,100,460,180,12,6,0);
            WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[394]);
            WRITE(256,130,ActPlayerFlag,16,MyScreen[1]^,4,PText[395]);
            WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,PText[396]);
            for i:=1 to Save.SYSTEMS do begin
               repeat
                  SystemX[i]:=5+random(250)+random(210);
                  SystemY[i]:=5+random(240)+random(240);
                  b:=true;
                  for j:=1 to pred(i) do if SystemY[i] in [SystemY[j]-10..SystemY[j]+10] then b:=false;
               until b;
            end;
            for i:=1 to 7 do for j:=1 to 7 do Save.WarState[i,j]:=LEVEL_COLDWAR;
            for j:=1 to 7 do begin
               for i:=1 to 25 do Save.TechCosts[j,i]:=0;
               for i:=26 to 42 do Save.TechCosts[j,i]:=i*2500;
               for i:=2 to 7 do Save.ProjectCosts[j,i]:=i*100000;
               Save.ProjectCosts[j,39]:=40000;
               Save.ActTech[j]:=0;
            end;
            for i:=1 to Save.SYSTEMS do begin
               SystemHeader[i].FirstShip.SType:=0;
               SystemHeader[i].vNS:=0;
               for j:=1 to SystemHeader[i].Planets do begin
                  MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
                  with MyPlanetHeader^ do if PFlags<>0 then begin
                     case random(7) of
                        0: PFlags:=FLAG_TERRA;
                        1: PFlags:=FLAG_KLEGAN;
                        2: PFlags:=FLAG_REMALO;
                        3: PFlags:=FLAG_CARDAC;
                        4: PFlags:=FLAG_BAROJA;
                        5: PFlags:=FLAG_VOLKAN;
                        6: PFlags:=FLAG_FERAGI;
                     end;
                     Ethno:=(PFlags and FLAG_CIV_MASK);
                     Biosphäre:=Biosphäre-random(20);
                     Infrastruktur:=Biosphäre-random(20);
                     Industrie:=Industrie-random(20);
                     if ProjectPtr<>NIL then begin
                        ActPProject:=Ptr(ProjectPtr);
                        ActPProject^[2]:=0;
                        ActPPRoject^[39]:=0;
                        for k:=1 to 42 do if ProjectNeedsTech[k]>0 then ActPProject^[k]:=0;
                     end;
                     ProjectID:=-3;
                     Population:=round(Population*0.7);
                     if FirstShip.NextShip<>NIL then begin
                        MyShipPtr:=FirstShip.NextShip;
                        repeat
                           MyShipPtr^.Owner:=(PFlags and FLAG_CIV_MASK);
                           MyShipPtr:=MyShipPtr^.NextShip;
                        until MyShipPtr=NIL;
                     end;
                  end;
               end;
            end;
            WAITLOOP(false);
            RECT(MyScreen[1]^,0,50,100,460,180);
         end;
      2: begin   { CEBORCS }
            PLAYSOUND(3,420);
            MAKEBORDER(MyScreen[1]^,50,100,460,180,12,6,0);
            WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[395]);
            WRITE(256,130,ActPlayerFlag,16,MyScreen[1]^,4,PText[398]);
            WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,PText[399]);
            CEBORCATTACK(0);
            WAITLOOP(false);
            RECT(MyScreen[1]^,0,50,100,460,180);
         end;
      3: begin   { DCON-IMPERIUM }
            PLAYSOUND(3,420);
            MAKEBORDER(MyScreen[1]^,50,100,460,180,12,6,0);
            WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[395]);
            WRITE(256,130,ActPlayerFlag,16,MyScreen[1]^,4,PText[401]);
            WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,PText[402]);
            while Year>-40000 do Year:=Year-random(89)*random(89);
            Save.Bevölkerung[8]:=100;
            Save.WorldFlag:=WFLAG_DCON;
            for i:=1 to pred(MAXCIVS) do begin
               Save.WarState[8,i]:=LEVEL_PEACE;
               Save.WarState[i,8]:=LEVEL_PEACE;
            end;
            NArr:=NameArr('a','e','i','o','u',
                          'b','c','d','f','g','h','j','k','l','m','n','p',
                          'q','r','s','t','v','w','x','y','z');
            for i:=1 to MAXSYSTEMS do if i<>ActSys then begin
               Save.SystemName[i]:='Dc'+NArr[random(6)]+NArr[random(20)+6]
                                  +NArr[random(6)]+NArr[random(20)+6];
               SystemHeader[i].FirstShip.SType:=0;
               SystemHeader[i].FirstShip.Owner:=0;
               if SystemHeader[i].FirstShip.NextShip<>NIL then begin
                  MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
                  repeat
                     MyShipPtr^.Owner:=FLAG_OTHER;
                     MyShipPtr:=MyShipPtr^.NextShip;
                  until MyShipPtr=NIL;
               end;
               for j:=1 to SystemHeader[i].Planets do begin
                  MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
                  with MyPlanetHeader^ do begin
                     PName:='Dc'+NArr[random(6)]+NArr[random(20)+6];
                     if PFlags<>0 then begin
                        PFlags:=FLAG_OTHER;
                        Ethno:=FLAG_OTHER;
                        Biosphäre:=200;
                        Infrastruktur:=190;
                        Industrie:=180;
                        if ProjectPtr<>NIL then begin
                           ActPProject:=Ptr(ProjectPtr);
                           for k:=1 to 7 do
                            if (ActPProject^[i]>0) and (Save.ProjectCosts[8,i]=0) then ActPProject^[i]:=0
                            else Save.ProjectCosts[8,i]:=0;
                        end;
                        ProjectID:=-3;
                        if FirstShip.NextShip<>NIL then begin
                           MyShipPtr:=FirstShip.NextShip;
                           repeat
                              MyShipPtr^.Owner:=FLAG_OTHER;
                              MyShipPtr:=MyShipPtr^.NextShip;
                           until MyShipPtr=NIL;
                        end;
                     end;
                  end;
               end;
            end;
            for i:=1 to 25 do Save.TechCosts[8,i]:=0;
            WAITLOOP(false);
            RECT(MyScreen[1]^,0,50,100,460,180);
         end;
      4: begin   { ZEIT-ANOMALIE }
            PLAYSOUND(3,420);
            MAKEBORDER(MyScreen[1]^,50,100,460,180,12,6,0);
            WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[404]);
            WRITE(256,130,ActPlayerFlag,16,MyScreen[1]^,4,PText[405]);
            WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,PText[406]);
            Save.WorldFlag:=WFLAG_FIELD;
            WAITLOOP(false);
            RECT(MyScreen[1]^,0,50,100,460,180);
         end;
   end;
   REFRESHDISPLAY;
end;




procedure MOVESHIP(ActSys :byte; ShipPtr:ptr; Visible :boolean);
forward;



procedure ORBITINFO(StShipPtr :ShipHeader; ReqText :str, ActSys :byte; XPosX,XPosY :short);

var MoreThanShown,b,FleetUsed   :boolean;
var ShipNames                   :array [1..12] of string[15];
var ShipFactor                  :byte;
var SelShip                     :word;
var BeforeMyShipPtr             :^r_ShipHeader;
var k,j                         :integer;
var MyShipPtr                   :^r_ShipHeader;


procedure DRAWSHIPS;

var j   :integer;

begin
   RECT(MyScreen[1]^,0,22,69,416,456);
   for j:=1 to 12 do ShipNames[j]:='';
   j:=1;
   repeat
      if MyShipPtr^.SType=SHIPTYPE_FLEET then DisplayBeep(NIL) else
      with MyShipPtr^ do if Owner<>0 then begin
         BltBitMapRastPort(^ImgBitMap4,(SType-8)*32,32,^MyScreen[1]^.RastPort,35,37+i*32,32,32,192);
         WRITE(72,45+i*32,12,0,MyScreen[1]^,4,Project[MyShipPtr^.SType]);
         ShipNames[j]:=Project[MyShipPtr^.SType];
         s:=intstr(round((MyShipPtr^.Shield+Tactical*3)/ShipData[MyShipPtr^.SType].MaxShield*100))+'%';
         while length(s)<4 do s:='0'+s;
         s:=intstr(MyShipPtr^.ShieldBonus)+' '+s;
         while length(s)<7 do s:='0'+s;
         s:=intstr(MyShipPtr^.Ladung and MASK_LTRUPPS)+' '+s;
         while length(s)<10 do s:='0'+s;
         s:=intstr((MyShipPtr^.Ladung and MASK_SIEDLER) div 16)+' '+s;
         while length(s)<13 do s:='0'+s;
         WRITE(235,45+i*32,8,0,MyScreen[1]^,2,s);
         i:=i+1;   j:=j+1;
      end;
      MyShipPtr:=MyShipPtr^.NextShip;
   until (MyShipPtr=NIL) or (i>12);
end;


procedure SETFLEETPOSITION;

begin
   MyShipPtr^.PosX:=StShipPtr^.PosX;
   MyShipPtr^.PosY:=StShipPtr^.PosY;
   MyShipPtr^.Moving:=StShipPtr^.Moving+1;
   MyShipPtr^.Target:=0;
   while FINDOBJECT(ActSys,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr)
   do with MyShipPtr^ do case random(4) of
      0: PosX:=PosX+1;
      1: PosX:=PosX-1;
      2: PosY:=PosY+1;
      3: PosY:=PosY-1;
   end;
end;



begin
   if StShipPtr=NIL then exit;
   MyShipPtr:=StShipPtr;
   while (MyShipPtr^.Owner=0) and (MyShipPtr^.NextShip<>NIL) do MyShipPtr:=MyShipPtr^.NextShip;
   if MyShipPtr^.Owner<>ActPlayerFlag then exit;
   if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
      MyShipPtr:=MyShipPtr^.TargetShip;
      FleetUsed:=true;
   end else FleetUsed:=false;
   MAKEBORDER(MyScreen[1]^,20,30,420,480,12,6,0);
   s:=ReqText;
   WRITE(63,37,ActPlayerFlag,0,MyScreen[1]^,4,s);
   WRITE(36,56,12,0,MyScreen[1]^,1,PText[408]);
   WRITE(232,56,12,0,MyScreen[1]^,1,PText[409]);
   i:=1; ShipFactor:=0;
   DRAWSHIPS;
   if (i>12) and (MyShipPtr<>NIL) then begin
      MoreThanShown:=true;
      DrawImage(^MyScreen[1]^.RastPort,^GadImg1,300,457);
      WRITE(335,460,0,0,MyScreen[1]^,4,PText[410]);
   end else MoreThanShown:=false;
   b:=false;
   SelShip:=1; k:=0;
   repeat
      delay(RDELAY);
      if IBase^.MouseX in [60..370] then begin
         k:=(IBase^.MouseY-35) div 32;
         if k<>SelShip then begin
            for j:=1 to 12 do if j<>k then
             WRITE(72,45+j*32,12,0,MyScreen[1]^,4,ShipNames[j])
             else WRITE(72,45+j*32,ActPlayerFlag,0,MyScreen[1]^,4,ShipNames[j]);
            SelShip:=k;
         end;
      end;
      if (LData^ and 64=0) then begin
         if (IBase^.MouseX in [300..416]) and (IBase^.MouseY in [457..477]) then begin
            KLICKGAD(300,457);
            if MyShipPtr=NIL then begin
               MyShipPtr:=StShipPtr;
               if FleetUsed then MyShipPtr:=MyShipPtr^.TargetShip;
               i:=1; ShipFactor:=0;
            end else begin
               i:=i-12; ShipFactor:=ShipFactor+1;
            end;
            DRAWSHIPS;
         end else if IBase^.MouseX in [60..370] then begin
            PLAYSOUND(1,300);
            SelShip:=SelShip+ShipFactor*12;
            b:=true;
         end;
      end;
   until b or (RData^ and 1024=0);
   if (RData^ and 1024=0) then PLAYSOUND(1,300);
   RECT(MyScreen[1]^,0,20,30,422,482);
   if b then begin
      i:=1;
      MyShipPtr:=StShipPtr;
      while (MyShipPtr^.Owner=0) and (MyShipPtr^.NextShip<>NIL) do MyShipPtr:=MyShipPtr^.NextShip;
      if FleetUsed then MyShipPtr:=MyShipPtr^.TargetShip;
      while (i<>SelShip) and (MyShipPtr<>NIL) do begin
         if MyShipPtr^.Owner<>0 then i:=i+1;
         MyShipPtr:=MyShipPtr^.NextShip;
      end;
      if MyShipPtr<>NIL then begin
         if FleetUsed then begin
            SETFLEETPOSITION;
            if MyShipPtr=StShipPtr^.TargetShip then begin
               StShipPtr^.TargetShip:=MyShipPtr^.NextShip;
               if MyShipPtr^.NextShip<>NIL then MyShipPtr^.NextShip^.BeforeShip:=StShipPtr;
               LINKSHIP(MyShipPtr,^SystemHeader[ActSys].FirstShip,0);
            end else LINKSHIP(MyShipPtr,^SystemHeader[ActSys].FirstShip,1);
            if StShipPtr^.TargetShip^.NextShip=NIL then begin
               StShipPtr^.TargetShip^.PosX:=StShipPtr^.PosX;
               StShipPtr^.TargetShip^.PosY:=StShipPtr^.PosY;
               LINKSHIP(StShipPtr^.TargetShip,^SystemHeader[ActSys].FirstShip,0);
               StShipPtr^.Owner:=0;
               StShipPtr^.SType:=8;
            end;
         end else begin
            MyShipPtr^.PosX:=XPosX;
            MyShipPtr^.PosY:=XPosY;
            if FleetUsed then SETFLEETPOSITION;
            LINKSHIP(MyShipPtr,^SystemHeader[ActSys].FirstShip,1);
         end;
         REFRESHDISPLAY;
         if MyShipPtr^.Moving>0 then begin
            DRAWSYSTEM(MODE_REFRESH,ActSys,MyShipPtr);
            MOVESHIP(ActSys,MyShipPtr,false);
         end;
      end
   end;
   REFRESHDISPLAY;
end;



procedure KILLFLEET(MyShipPtr :ShipHeader);

var LastShipPtr :ShipHeader;

begin
   LastShipPtr:=MyShipPtr;
   MyShipPtr^.NextShip:=MyShipPtr^.TargetShip;
   MyShipPtr^.TargetShip^.BeforeShip:=MyShipPtr;
   while MyShipPtr<>NIL do begin
      MyShipPtr^.Owner:=LastShipPtr^.Owner;
      MyShipPtr:=MyShipPtr^.NextShip;
   end;
   MyShipPtr^.NextShip:=LastShipPtr^.NextShip;
   if LastShipPtr^.NextShip<>NIL then LastShipPtr^.NextShip^.BeforeShip:=MyShipPtr;
   LastShipPtr^.Owner:=0;
end;






procedure MOVESHIP;

var ToX,ToY,i,j,k,FromX,FromY           :integer;
var MyShipPtr,OtherShipPtr,FleetShipPtr :^r_ShipHeader;
var MyPlanetHeader                      :^r_PlanetHeader;
var l,x,y                               :long;
var b                                   :boolean;
var CivVar,CivFlag,OldMoving,SysID      :byte;
var ActPProjects                        :^ByteArr42;



procedure DRAWSCENE(ActSys :byte);

begin
   if ActSys<>Display then begin
      OffsetX:=-MyShipPtr^.PosX-1;
      OffsetY:=-MyShipPtr^.PosY-1;
      x:=256+(MyShipPtr^.PosX+OffsetX)*32;
      y:=256+(MyShipPtr^.PosY+OffsetY)*32;
      DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   end else REFRESHDISPLAY;
   delay(10);
end;



procedure EXPLODE(ActSys :byte; MyShipPtr :ShipHeader);

begin
   if ActSys<>0 then begin
      if ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN) and (MyShipPtr<>NIL)
      and (Save.CivPlayer[ActPlayer]<>0))
      or ((GETCIVVAR(SystemFlags[1,ActSys])<>0)
          and (Save.CivPlayer[GETCIVVAR(SystemFlags[1,ActSys])]<>0)) then with MyShipPtr^ do begin
         DRAWSCENE(ActSys);
         PLAYSOUND(2,1100);
         x:=256+(PosX+OffsetX)*32;
         y:=256+(PosY+OffsetY)*32;
         if not ((PosX=0) and (PosY=0)) then begin
            PosX:=FromX;   PosY:=FromY;
         end;
         if (x in [0..480]) and (y in [0..480]) and not ((PosX=0) and (PosY=0)) then begin
            RECT(MyScreen[1]^,0,x,y,x+31,y+31);
            for i:=0 to 15 do begin
               BltBitMapRastPort(^ImgBitMap4,i*32,0,^MyScreen[1]^.RastPort,x,y,31,31,192);
               delay(5);
            end;
            RECT(MyScreen[1]^,0,x,y,x+31,y+31);
            delay(10);
            DMACON_WRITE^:=$0003;
         end;
      end;
   end;
   if MyShipPtr<>NIL then begin
      MyShipPtr^.Owner:=0;
      MyShipPtr^.Moving:=0;
   end;
   REFRESHDISPLAY;
   delay(10);
end;



procedure SMALLANDING(PPtr,SPtr :ptr; ActSys :byte);

var MyShipPtr                           :^r_ShipHeader;
var MyPlanetHeader                      :^r_PlanetHeader;
var ActPProjects                        :^ByteArr42;
var ShipShield,ShipWeapon,GroundWeapon  :integer;
var LandShield                          :integer;
var Visible                             :boolean;
var HitCtr                              :byte;
var l                                   :long;
var Percs                               :real;

begin
   MyPlanetHeader:=PPtr;
   MyShipPtr:=ShipPtr;
   HitCtr:=0;
   if (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0)
   or ((MyPlanetHeader^.PFlags>0) and (Save.CivPlayer[GETCIVVAR(MyPlanetHeader^.PFlags)]<>0))
   or (Display=ActSys) then Visible:=true else Visible:=false;
   with MyPlanetHeader^ do begin
      ActPPRojects:=ProjectPtr;
      ShipShield:=(MyShipPtr^.Shield+MyShipPtr^.Tactical*3+MyShipPtr^.ShieldBonus);
      ShipWeapon:=round((MyShipPtr^.Weapon/10+1)*ShipData[MyShipPtr^.SType].WeaponPower-MyShipPtr^.Tactical);
      CivVar:=GETCIVVAR(MyPlanetHeader^.PFlags);
      if CivVar<>0 then begin
         GroundWeapon:=WEAPON_GUN;
         if Save.TechCosts[CivVar,15]=0 then GroundWeapon:=WEAPON_LASER;
         if Save.TechCosts[CivVar,24]=0 then GroundWeapon:=WEAPON_PHASER;
         if Save.TechCosts[CivVar,32]=0 then GroundWeapon:=WEAPON_DISRUPTOR;
         if Save.TechCosts[CivVar,27]=0 then GroundWeapon:=WEAPON_PTORPEDO;
      end else GroundWeapon:=WEAPON_PTORPEDO;
      randomize;

      if ActPProjects^[34]>0 then begin
         LandShield:=round(16*ActPProjects^[34]/10);
         repeat
            case random(5) of
               0: ShipShield:=ShipShield-GroundWeapon;
               otherwise begin
                  LandShield:=LandShield-ShipWeapon;
                  HitCtr:=HitCtr+1;
               end;
            end;
         until (ShipShield<0) or (LandShield<0);
         if LandShield<=0 then begin
            ActPProjects^[34]:=0;
            if Visible then PLAYSOUND(2,1100);
         end else ActPPRojects^[34]:=round(LandShield*100/9/10);
      end;

      if (ActPProjects^[40]>0) and (ShipShield>=0) then begin
         delay(20);
         LandShield:=round(64*ActPProjects^[40]/10);
         repeat
            case random(5) of
               0: ShipShield:=ShipShield-GroundWeapon;
               otherwise begin
                  LandShield:=LandShield-ShipWeapon;
                  HitCtr:=HitCtr+1;
               end;
            end;
         until (ShipShield<0) or (LandShield<0);
         if LandShield<=0 then begin
            ActPProjects^[40]:=0;
            if Visible then PLAYSOUND(2,1100);
         end else ActPPRojects^[40]:=round(LandShield*100/49/10);
      end;

      if ShipShield>=0 then with MyShipPtr^ do begin
         if ShipShield-ShieldBonus-Tactical*3>0 then
          Shield:=ShipShield-ShieldBonus-Tactical*3 else Shield:=1;
         ShieldBonus:=ShieldBonus+1;
         REFRESHDISPLAY;
         delay(10);
      end else begin
         if Visible then EXPLODE(ActSys,MyShipPtr);
         MyShipPtr^.Owner:=0;
      end;
   end;
end;



procedure STARLANDING(PPtr,SPtr :ptr; ActSys: byte);

var NeuScreen                           :NewScreen;
var ImgBitMap5                          :ITBitMap;
var l                                   :long;
var i,j,k                               :integer;
var AScr,DefaultColor,CivVar            :byte;
var SLSoundMemA                         :long;
var SLSoundSize                         :word;
var ShipShield,ShipWeapon,
    GroundWeapon                        :integer;
var MyPlanetHeader                      :^r_PlanetHeader;
var MyShipPtr                           :^r_ShipHeader;
var Percs                               :real;
var ActPProjects                        :^ByteArr42;


function INITIMAGES:boolean;

var ISize       :long;

begin
   INITIMAGES:=false;
   case MyPlanetHeader^.Class of
      CLASS_DESERT:   s:='D';
      CLASS_HALFEARTH:s:='H';
      CLASS_EARTH:    s:='M';
      CLASS_ICE:      s:='I';
      CLASS_STONES:   s:='T';
      CLASS_WATER:    s:='W';
   end;
   s:=PathStr[1]+'LandScape'+s+'.img';
   if not RAWLOADIMAGE(s,0,0,640,32,5,ImgBitMap5) then exit;

   s[length(s)-3]:=chr(0); s:=s+'.pal';
   i:=SETCOLOR(MyScreen[1]^,s);
   i:=SETCOLOR(MyScreen[2]^,s);

   case MyShipPtr^.Weapon of
      WEAPON_GUN:       s:='Gun';
      WEAPON_LASER:     s:='Laser';
      WEAPON_PHASER:    s:='Phaser';
      WEAPON_DISRUPTOR: s:='Disruptor';
      WEAPON_PTORPEDO:  s:='PTorpedo';
   end;
   s:=PathStr[7]+s+'.RAW';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle=0 then exit;
   SLSoundSize:=DosSeek(FHandle,0,OFFSET_END);
   SLSoundSize:=DosSeek(FHandle,0,OFFSET_BEGINNING) div 2;
   SLSoundMemA:=IMemA[0];
   l:=DosRead(FHandle,ptr(SLSoundMemA),SLSoundSize*2);
   DosClose(FHandle);
   INITIMAGES:=true;
end;



procedure LANDING;

const ID_WATER=    -1;
const ID_WOOD=      0;
const ID_GRASS=    32;
const ID_DESERT=   64;
const ID_HILLS=    96;
const ID_SPHALANX=128;
const ID_SDI=     160;
const ID_CITY1=   192;
const ID_CITY2=   224;
const ID_LAKE=    256;
const ID_UFER_OUT=288;
const ID_UFER_IN= 320;


var Moved                               :array [1..2] of integer;
var LandID,LandShield                   :array [0..7,0..7] of integer;
var HitX,HitY,Fired                     :short;
var SDIBases,SPHBases                   :integer;
var SDIBaseDrawed,SPHBaseDrawed,
    SDIBaseHit,SPHBaseHit,CityDrawed,
    CityHit,BioDrawed,BioHit,CityComp   :long;


procedure DRAWFIRE;

begin
   SPAddrA^:=ZeroSound; SPLengthA^:=1;
   SPAddrB^:=ZeroSound; SPLengthB^:=1;
   SPAddrC^:=ZeroSound; SPLengthC^:=1;
   SPAddrD^:=ZeroSound; SPLengthD^:=1;
   if (HitX>-1) and (HitY>-1) then begin
      LandID[HitX,HitY]:=LandID[HitX,HitY]+32;
      BltBitMapRastPort(^ImgBitMap5,LandID[HitX,HitY],0,^MyScreen[AScr]^.RastPort,HitX*32,HitY*32-Moved[Ascr],32,32,192);
      if LandID[HitX,HitY]=608 then begin
         if Moved[3-Ascr]>0 then
            BltBitMapRastPort(^ImgBitMap5,LandID[HitX,HitY],0,^MyScreen[3-AScr]^.RastPort,HitX*32,HitY*32-Moved[3-Ascr],32,32,192)
         else
            BltBitMapRastPort(^ImgBitMap5,LandID[HitX,HitY],0,^MyScreen[3-AScr]^.RastPort,HitX*32,HitY*32-32,32,32,192);
         HitX:=-1; HitY:=-1;
      end;
   end;
   if Fired>0 then Fired:=Fired-1 else if (LData^ and 64=0) and (IBase^.MouseY in [65..382]) then begin
      Fired:=7;
      DMACON_WRITE^:=$000C;
      SPAddrC^:=SLSoundMemA; SPFreqC^:=350; SPLengthC^:=SLSoundSize; SPVolC^:=50;
      SPAddrD^:=SLSoundMemA; SPFreqD^:=300; SPLengthD^:=SLSoundSize; SPVolD^:=50;
      DMACON_WRITE^:=$800C;
      HitX:=(IBase^.MouseX-32) div 64; HitY:=(IBase^.MouseY div 2 + Moved[AScr]) div 32;
      LandShield[HitX,HitY]:=LandShield[HitX,HitY]-ShipWeapon;
      if ((LandID[HitX,HitY] in [ID_SDI,ID_SPHALANX]) and (LandShield[HitX,HitY]<0))
      or (LandID[HitX,HitY] in [ID_WOOD,ID_GRASS,ID_DESERT,ID_HILLS,ID_CITY2,ID_CITY1]) then begin
         if LandID[HitX,HitY]=ID_SDI then SDIBaseHit:=SDIBaseHit+1
         else if LandID[HitX,HitY]=ID_SPHALANX then SPHBaseHit:=SPHBaseHit+1
         else if LandID[HitX,HitY] in [ID_CITY1,ID_CITY2] then CityHit:=CityHit+1
         else BioHit:=BioHit+1;
         PLAYSOUND(2,800);
         LandID[HitX,HitY]:=352;
         BltBitMapRastPort(^ImgBitMap5,352,0,^MyScreen[AScr]^.RastPort,HitX*32,HitY*32-Moved[Ascr],32,32,192);
      end else begin
         HitX:=-1; HitY:=-1;
      end;
   end;
end;



begin
   for i:=1 to 2 do begin
      RECT(MyScreen[i]^,DefaultColor,0,0,255,240);
      RECT(MyScreen[i]^,12,0,244,255,255);
      if ShipShield<255 then RECT(MyScreen[i]^,0,ShipShield,245,254,254);
   end;
   for i:=0 to 7 do for j:=0 to 7 do begin
      LandID[j,i]:=ID_WATER; LandShield[j,i]:=0;
   end;
   for i:=0 to 7 do LandID[i,0]:=ID_UFER_IN;
   Moved[AScr]:=32; Moved[3-AScr]:=30; Fired:=0;
   HitX:=-1;        HitY:=-1;
   SDIBases:=0;      SPHBases:=0;
   SDIBaseDrawed:=0; SPHBaseDrawed:=0;
   SDIBaseHit:=0;    SPHBaseHIT:=0;
   CityDrawed:=0;    CityHit:=0;
   BioDrawed:=0;     BioHit:=0;
   CityComp:=MyPlanetHeader^.Population div 300+1;
   if CityComp>30 then CityComp:=30;
   repeat                      { MOVE UFER_IN }
      SDIBases:=SDIBases+1;
      Moved[Ascr]:=Moved[AScr]-4;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
      for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],Moved[AScr],^MyScreen[AScr]^.RastPort,i*32,0,32,4,192);
      DRAWFIRE;
      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;
   until SDIBases>=14;

   SDIBases:=(ActPProjects^[34] div 10)-1;
   SPHBases:=(ActPProjects^[40] div 10)-1;

   repeat                      { MOVE LANDSCAPE AND BATTLE }
      Moved[Ascr]:=Moved[AScr]-4;
      if Moved[AScr]<0 then Moved[Ascr]:=Moved[Ascr]+32;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
      SetRGB32(^MyScreen[AScr]^.ViewPort,0,0,0,0);
      if Moved[AScr]=30 then begin
         for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0], 0,^MyScreen[AScr]^.RastPort,i*32,2,32,2,192);
         for i:=0 to 7 do begin
            if LandID[i,7] in [ID_SDI,ID_SPHALANX] then begin
               SetRGB32(^MyScreen[AScr]^.ViewPort,0,$FF000000,$FF000000,$FF000000);
               PLAYSOUND(2,400);
               ShipShield:=ShipShield-GroundWeapon;
               if ShipShield<0 then ShipShield:=0;
               if ShipShield in [0..255] then for k:=1 to 2 do RECT(MyScreen[k]^,0,ShipShield,245,254,254);
            end;
            for j:=6 downto 0 do begin
               LandID[i,succ(j)]:=LandID[i,j];
               LandShield[i,succ(j)]:=LandShield[i,j];
            end;
         end;
         for i:=0 to 7 do begin
            LandShield[i,0]:=0;
            if (Random(5)=0) or (CityDrawed>CityComp) then begin
               LandID[i,0]:=random(9)*32;
               case LandID[i,0] of
                  ID_SDI:      if SDIBases<0 then LandID[i,0]:=ID_CITY1
                               else begin
                                  SDIBases:=SDIBases-1;
                                  SDIBaseDrawed:=SDIBaseDrawed+1;
                                  LandShield[i,0]:=18;
                               end;
                  ID_SPHALANX: if SPHBases<0 then LandID[i,0]:=ID_CITY2
                               else begin
                                  SPHBases:=SPHBases-1;
                                  SPHBaseDrawed:=SPHBaseDrawed+1;
                                  LandShield[i,0]:=72;
                               end;
                  otherwise;
               end;
               if LandID[i,0] in [ID_CITY1,ID_CITY2] then CityDrawed:=CityDrawed+1
                else if LandID[i,0] in [ID_WOOD..ID_HILLS] then BioDrawed:=BioDrawed+1;
            end else begin
               if (MyPlanetHeader^.Biosphäre<190) and (random(100)<5) then LandID[i,0]:=608 else begin
                  LandID[i,0]:=random(3)*32;
                  BioDrawed:=BioDrawed+1;
               end;
            end;
         end;
         for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],30,^MyScreen[AScr]^.RastPort,i*32,0,32,2,192);
         if HitY>-1 then begin
            HitY:=HitY+1;
            if HitY=8 then HitY:=0;
         end;
      end else for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],Moved[AScr],^MyScreen[AScr]^.RastPort,i*32,0,32,4,192);
      DRAWFIRE;
      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;
      if (SDIBases<0) and (SPHBases<0) then SDIBases:=SDIBases-1;
   until ((ShipShield<=0) or ((SDIBases<-160) and (CityDrawed>CityComp))) and (Ascr=1);

   if ShipShield<0 then begin                { DESTROYED SHIP }
      MyShipPtr^.Owner:=0;
      DMACON_WRITE^:=$000F;
      SetRGB32(^MyScreen[1]^.ViewPort,0,$FF000000,$FF000000,$FF000000);
      RECT(MyScreen[1]^,0,0,0,255,255);
      PLAYSOUND(2,1000);
      SPAddrD^:=SoundMemA[2]+SoundSize[2]; SPFreqD^:=900; SPLengthD^:=SoundSize[2] div 2; SPVolD^:=64;
      SPAddrC^:=SoundMemA[2];              SPFreqC^:=900; SPLengthC^:=SoundSize[2] div 2; SPVolC^:=64;

      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;         WaitTOF;
      SPAddrA^:=ZeroSound; SPLengthA^:=1;

      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;         WaitTOF;
      SPAddrB^:=ZeroSound; SPLengthB^:=1;

      DMACON_WRITE^:=$800C;
      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;         WaitTOF;
      SPAddrD^:=ZeroSound; SPLengthD^:=1;

      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;         WaitTOF;
      SPAddrC^:=ZeroSound; SPLengthC^:=1;

      for i:=1 to 20 do begin
         ScreenToFront(MyScreen[AScr]);
         AScr:=3-AScr;         WaitTOF;
      end;

   end else begin                            { MOVE UFER_OUT }
      if Moved[Ascr]-4>0 then begin
         repeat
            Moved[Ascr]:=Moved[AScr]-4;
            ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
            for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],Moved[AScr],^MyScreen[AScr]^.RastPort,i*32,0,32,4,192);
            DRAWFIRE;
            ScreenToFront(MyScreen[AScr]);
            AScr:=3-AScr;
         until Moved[Ascr]-4<0;
      end;

      SDIBases:=0;

      Moved[Ascr]:=Moved[AScr]+28;
      ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
      for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0], 0,^MyScreen[AScr]^.RastPort,i*32,2,32,2,192);
      for i:=0 to 7 do begin
         for j:=6 downto 0 do begin
            LandID[i,succ(j)]:=LandID[i,j];
            LandShield[i,succ(j)]:=LandShield[i,j];
         end;
         LandID[i,0]:=ID_UFER_OUT;
      end;
      if HitY>-1 then begin
         HitY:=HitY+1;
         if HitY=8 then HitY:=0;
      end;
      for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],30,^MyScreen[AScr]^.RastPort,i*32,0,32,2,192);
      DRAWFIRE;
      ScreenToFront(MyScreen[AScr]);
      AScr:=3-AScr;
      repeat
         SDIBases:=SDIBases+1;
         Moved[Ascr]:=Moved[AScr]-4;
         if Moved[AScr]<0 then Moved[Ascr]:=Moved[Ascr]+32;
         if Moved[AScr]=30 then begin
            for i:=0 to 7 do begin
               for j:=6 downto 0 do begin
                  LandID[i,succ(j)]:=LandID[i,j];
                  LandShield[i,succ(j)]:=LandShield[i,j];
               end;
               LandID[i,0]:=ID_WATER;
            end;
            if HitY>-1 then begin
               HitY:=HitY+1;
               if HitY=8 then HitY:=0;
            end;
         end;
         ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
         for i:=0 to 7 do BltBitMapRastPort(^ImgBitMap5,LandID[i,0],Moved[AScr],^MyScreen[AScr]^.RastPort,i*32,0,32,4,192);
         DRAWFIRE;
         ScreenToFront(MyScreen[AScr]);
         AScr:=3-AScr;
      until SDIBases>=14;

      for i:=1 to 128 do begin
         Moved[Ascr]:=Moved[AScr]-4;
         if Moved[AScr]<0 then Moved[Ascr]:=Moved[Ascr]+32;
         if Moved[Ascr]=30 then begin
            for i:=0 to 7 do begin
               LandID[i,0]:=ID_WATER;
               for j:=6 downto 0 do begin
                  LandID[i,succ(j)]:=LandID[i,j];
                  LandShield[i,succ(j)]:=LandShield[i,j];
               end;
            end;
            if HitY>-1 then begin
               HitY:=HitY+1;
               if HitY=8 then HitY:=0;
            end;
         end;
         ScrollRaster(^MyScreen[AScr]^.RastPort,0,-4,0,0,255,240);
         RECT(MyScreen[Ascr]^,DefaultColor,0,0,255,4);
         DRAWFIRE;
         ScreenToFront(MyScreen[AScr]);
         AScr:=3-AScr;
      end;
   end;
   BioDrawed:=BioDrawed+CityDrawed+SDIBaseDrawed+SPHBaseDrawed;
   BioHit:=BioHit+CityHit+SDIBaseHit+SPHBaseHit;
   with MyPlanetHeader^ do begin
      s:=PathStr[1]+'Paper.pal';
      l:=SETCOLOR(MyScreen[AScr]^,s);
      s:=PathStr[1]+'Paper.img';
      if not DISPLAYIMAGE(s,0,0,256,256,5,MyScreen[AScr]^,0) then begin end;
      if SDIBaseDrawed>0 then ActPProjects^[34]:=ActPPRojects^[34]-(SDIBaseHit*ActPProjects^[34] div SDIBaseDrawed);
      if SPHBaseDrawed>0 then ActPPRojects^[40]:=ActPPRojects^[40]-(SPHBaseHit*ActPProjects^[40] div SPHBaseDrawed);
      if (SDIBaseDrawed>0) and (SPHBaseDrawed>0) then begin
         CityDrawed:=CityDrawed*20+SDIBaseDrawed+SPHBaseDrawed;
         CityHit:=CityHit*20+SDIBaseHit+SPHBaseHit;
      end;
      if CityHit=0 then Percs:=1 else Percs:=1-(CityHit/CityDrawed);
      if Percs<0.8 then begin
         Ethno:=PFlags and FLAG_CIV_MASK;
         Save.ImperatorState[ActPlayer]:=round(Save.ImperatorState[ActPlayer]*Percs);
      end;

      s:=PText[411]+': '+intstr(Population)+' -> ';
      Population:=round(Population*Percs);
      if (Percs>0) and (Population<=0) then Population:=1;
      s:=s+intstr(Population)+' ('+intstr(round(Percs*100))+'%)';
      WRITE(22,40,29,0,MyScreen[Ascr]^,1,s);

      s:=PText[152]+': '+intstr(Infrastruktur div 2)+'% -> ';
      Infrastruktur:=Infrastruktur-(CityHit*Infrastruktur div CityDrawed);
      s:=s+intstr(Infrastruktur div 2)+'%';
      WRITE(22,55,29,0,MyScreen[Ascr]^,1,s);

      s:=PText[149]+': '+intstr(Industrie div 2)+'% -> ';
      Industrie:=    Industrie-    (CityHit*Industrie     div CityDrawed);
      s:=s+intstr(Industrie div 2)+'%';
      WRITE(22,70,29,0,MyScreen[Ascr]^,1,s);

      s:=PText[151]+': '+intstr(Biosphäre div 2)+'% -> ';
      Biosphäre:=    Biosphäre-    (BioHit* Biosphäre     div BioDrawed);
      s:=s+intstr(Biosphäre div 2)+'%';
      WRITE(22,85,29,0,MyScreen[Ascr]^,1,s);

      s:=PText[413]+': '+intstr(Save.ImperatorState[ActPlayer])+' '+PText[414];
      WRITE(22,120,29,0,MyScreen[Ascr]^,1,s);
      ScreenToFront(MyScreen[Ascr]);
      WAITLOOP(false);
   end;
end;



procedure STARLANDINGEXIT(Error :boolean);

begin
   DoClock:=false;
   if ImgBitMap5.MemA<>0 then FreeMem(ImgBitMap5.MemA,ImgBitMap5.MemL);
   ImgBitMap5.MemA:=0;
   CLOSEMYSCREENS;
   DMACON_WRITE^:=$000F;
   b:=OPENMAINSCREENS;
   b:=INITDESK(0);
   Screen2:=0;
   if Error then SMALLANDING(PPtr,SPtr,ActSys);
   DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
end;



begin
   if Save.SmallLand then begin
      SMALLANDING(PPtr,SPtr,ActSys);
      exit;
   end;
   MyPlanetHeader:=PPtr; MyShipPtr:=SPtr;
   ActPProjects:=MyPlanetHeader^.ProjectPtr;
   CLOSEMYSCREENS;
   Display:=100;
   ImgBitMap5:=ITBitMap(0,0,0,0,0,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,0,0);
   with ImgBitMap5 do begin
      MemL:=13600;  {640 x 34 x 5}
      MemA:=AllocMem(MemL,MEMF_CHIP+MEMF_CLEAR);
      if MemA=0 then exit;
      ImgBitMap5:=ITBitMap(80,34,1,5,0,ptr(MemA),     ptr(MemA+2720),ptr(MemA+5440),
                                       ptr(MemA+8160),ptr(MemA+10880),
                                       NIL,NIL,NIL,MemA,MemL);
   end;
   Tags:=TagArr(SA_DisplayID,   ($1000+HelpID),
                SA_Interleaved, _TRUE,
                SA_Draggable,   _FALSE,
                SA_COLORS,      addr(ColSpec),
                TAG_DONE,       0,0,0,0,0);
   NeuScreen:=NewScreen(16,0,256,256,5,0,0,0,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   for i:=1 to 2 do MyScreen[i]:=OpenScreenTagList(^NeuScreen,^Tags);
   if MyScreen[1]=NIL then begin
      STARLANDINGEXIT(true); exit;
   end;
   if MyScreen[2]=NIL then begin
      STARLANDINGEXIT(true); exit;
   end;
   SWITCHDISPLAY;
   if not INITIMAGES then begin
      STARLANDINGEXIT(true); exit;
   end;
   BltBitMapRastPort(^ImgBitMap5,304,0,^MyScreen[1]^.RastPort,0,0,1,1,192);
   DefaultColor:=ReadPixel(^MyScreen[1]^.RastPort,0,0);
   AScr:=2;

   ShipShield:=(MyShipPtr^.Shield+MyShipPtr^.Tactical*3+MyShipPtr^.ShieldBonus);
   ShipWeapon:=round((MyShipPtr^.Weapon/10+1)*ShipData[MyShipPtr^.SType].WeaponPower-MyShipPtr^.Tactical);
   CivVar:=GETCIVVAR(MyPlanetHeader^.PFlags);
   if CivVar<>0 then begin
      GroundWeapon:=WEAPON_GUN;
      if Save.TechCosts[CivVar,15]=0 then GroundWeapon:=WEAPON_LASER;
      if Save.TechCosts[CivVar,24]=0 then GroundWeapon:=WEAPON_PHASER;
      if Save.TechCosts[CivVar,32]=0 then GroundWeapon:=WEAPON_DISRUPTOR;
      if Save.TechCosts[CivVar,27]=0 then GroundWeapon:=WEAPON_PTORPEDO;
   end else GroundWeapon:=WEAPON_PTORPEDO;
   GroundWeapon:=GroundWeapon*3;
   LANDING;
   STARLANDINGEXIT(false);
   if ShipShield>0 then with MyShipPtr^ do begin
      if ShipShield-ShieldBonus-Tactical*3>0 then
       Shield:=ShipShield-ShieldBonus-Tactical*3 else Shield:=1;
      ShieldBonus:=ShieldBonus+1;
   end else MyShipPtr^.Owner:=0;
end;




function BIGSHIPFIGHT(Ship1,Ship2 :ShipHeader; Mode,ActSys :byte):byte;

type r_SmallShipHeader=record
   ShieldS,WeaponS        :integer;
end;

var SSHeader                    :array [0..1] of r_SmallShipHeader;
var l                           :long;
var i,j                         :integer;
var AScr                        :byte;
var BSFSoundMemA                :array [2..4] of long;
var BSFSoundSize                :array [2..4] of word;
var ShipPtr1,ShipPtr2           :^r_ShipHeader;
var Visible                     :boolean;


function INITIMAGES:boolean;

var ISize               :long;

function LOADSAMPLE(FName :str; SID :byte):boolean;

begin
   LOADSAMPLE:=false;
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   l:=DosSeek(FHandle,0,OFFSET_END);
   l:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   BSFSoundSize[SID]:=l div 2;
   l:=DosRead(FHandle,ptr(BSFSoundMemA[SID]),BSFSoundSize[SID]*2);
   DosClose(FHandle);
   LOADSAMPLE:=true;
end;


procedure INITSOUNDNAMES(SoundID :byte);

begin
   case SoundID of
      WEAPON_GUN:       s:='Gun';
      WEAPON_LASER:     s:='Laser';
      WEAPON_PHASER:    s:='Phaser';
      WEAPON_DISRUPTOR: s:='Disruptor';
      WEAPON_PTORPEDO:  s:='PTorpedo';
      otherwise;
   end;
   s:=PathStr[7]+s+'.RAW';    {SFX/}
end;


begin
   INITIMAGES:=false;
   s:=PathStr[6]+Project[ShipPtr1^.SType]+'.img';       { SHIPS/ }
   if not RAWLOADIMAGE(s,0,32,512,32,4,ImgBitMap4) then exit;
   s:=PathStr[6]+Project[ShipPtr2^.SType]+'.img';       { SHIPS/ }
   if not RAWLOADIMAGE(s,0,64,512,32,4,ImgBitMap4) then exit;

   BSFSoundMemA[2]:=IMemA[0];
   INITSOUNDNAMES(ShipPtr1^.Weapon);
   if not LOADSAMPLE(s,2) then exit;
   BSFSoundMemA[3]:=BSFSoundMemA[2]+BSFSoundSize[2]*2;
   INITSOUNDNAMES(ShipPtr2^.Weapon);
   if not LOADSAMPLE(s,3) then exit;
   BSFSoundMemA[4]:=BSFSoundMemA[3]+BSFSoundSize[3]*2;
   s:=PathStr[7]+'FightSoundDS.RAW';                      { SFX/ }
   if not LOADSAMPLE(s,4) then exit;
   BSFSoundSize[4]:=BSFSoundSize[4] div 2;

   INITIMAGES:=true;
end;



procedure XTRAROUND;

const STARS=15;

type SArr15=array [0..15] of short;

var x,y                         :array [0..1] of word;
var Angle                       :array [0..1] of integer;
var sx1,sy1,sx2,sy2             :array [0..1,1..2] of integer;
var StepCtr                     :word;
var StarX,StarY                 :array [1..STARS] of word;
var dx,dy,da,FireFactor         :integer;
var mx,my                       :SArr15;
var NowDie,Rotation             :byte;


procedure STARFLY(Ship :byte);

var i   :byte;

begin
   Rotation:=Rotation+1;
   if Rotation>2 then Rotation:=0;
   RectFill(^MyScreen[AScr]^.RastPort,x[Ship]-4,y[Ship]-4,x[Ship]+36,y[Ship]+36);
   case Angle[Ship] of
        0: y[Ship]:=y[Ship]-2;
       32: begin
              x[Ship]:=x[Ship]+1; y[Ship]:=y[Ship]-2;
           end;
       64: begin
              x[Ship]:=x[Ship]+2; y[Ship]:=y[Ship]-2;
           end;
       96: begin
              x[Ship]:=x[Ship]+2; y[Ship]:=y[Ship]-1;
           end;
      128: x[Ship]:=x[Ship]+2;
      160: begin
              x[Ship]:=x[Ship]+2;  y[Ship]:=y[Ship]+1;
           end;
      192: begin
              x[Ship]:=x[Ship]+2;  y[Ship]:=y[Ship]+2;
           end;
      224: begin
              x[Ship]:=x[Ship]+1;  y[Ship]:=y[Ship]+2;
           end;
      256: y[Ship]:=y[Ship]+2;
      288: begin
              x[Ship]:=x[Ship]-1;   y[Ship]:=y[Ship]+2;
           end;
      320: begin
              x[Ship]:=x[Ship]-2;   y[Ship]:=y[Ship]+2;
           end;
      352: begin
              x[Ship]:=x[Ship]-2;   y[Ship]:=y[Ship]+1;
           end;
      384: x[Ship]:=x[Ship]-2;
      416: begin
              x[Ship]:=x[Ship]-2; y[Ship]:=y[Ship]-1;
           end;
      448: begin
              x[Ship]:=x[Ship]-2; y[Ship]:=y[Ship]-2;
           end;
      480: begin
              x[Ship]:=x[Ship]-1; y[Ship]:=y[Ship]-2;
           end;
      otherwise;
   end;

   dx:=(x[1-Ship]-x[Ship]);
   dy:=(y[1-Ship]-y[Ship]);
   if (dx=0) and (dy<0) then da:=0   else
   if (dx>0) and (dy<0) then da:=64  else
   if (dx>0) and (dy=0) then da:=128 else
   if (dx>0) and (dy>0) then da:=192 else
   if (dx=0) and (dy>0) then da:=256 else
   if (dx<0) and (dy>0) then da:=320 else
   if (dx<0) and (dy=0) then da:=384 else
   if (dx<0) and (dy<0) then da:=448;

   if Rotation=0 then begin
      StepCtr:=0;
      if x[Ship]<15 then StepCtr:=1 else if x[Ship]>592 then StepCtr:=1;
      if y[Ship]<15 then StepCtr:=StepCtr+1 else if y[Ship]>462 then StepCtr:=StepCtr+1;
      if StepCtr>1 then Angle[Ship]:=Angle[Ship]+32
      else if
       ((y[Ship]<40) and (Angle[Ship] in [0..128]) and (Ship=1)) or
       ((y[Ship]<90) and (Angle[Ship] in [0..128]) and (Ship=0)) or
       ((x[Ship]>560) and (Angle[Ship] in [128..256]) and (Ship=1)) or
       ((x[Ship]>510) and (Angle[Ship] in [128..256]) and (Ship=0)) or
       ((y[Ship]>420) and (Angle[Ship] in [256..384]) and (Ship=1)) or
       ((y[Ship]>370) and (Angle[Ship] in [256..384]) and (Ship=0)) or
       ((x[Ship]<40) and (Angle[Ship] in [384..480,0]) and (Ship=1)) or
       ((x[Ship]<90) and (Angle[Ship] in [384..480,0]) and (Ship=0)) then Angle[Ship]:=Angle[Ship]+32

      else if
       ((y[Ship]<40) and (Angle[Ship] in [384..480]) and (Ship=1)) or
       ((y[Ship]<90) and (Angle[Ship] in [384..480]) and (Ship=0)) or
       ((x[Ship]>560) and (Angle[Ship] in [0..96]) and (Ship=1)) or
       ((x[Ship]>510) and (Angle[Ship] in [0..96]) and (Ship=0)) or
       ((y[Ship]>420) and (Angle[Ship] in [128..224]) and (Ship=1)) or
       ((y[Ship]>370) and (Angle[Ship] in [128..224]) and (Ship=0)) or
       ((x[Ship]<40) and (Angle[Ship] in [256..352]) and (Ship=1)) or
       ((x[Ship]<90) and (Angle[Ship] in [256..352]) and (Ship=0)) then Angle[Ship]:=Angle[Ship]-32

      else if
       (x[Ship] in [x[1-Ship]-130..x[1-Ship]+130]) and (y[Ship] in [y[1-Ship]-130..y[1-Ship]+130])
        then if Ship=0 then Angle[Ship]:=Angle[Ship]+32 else Angle[Ship]:=Angle[Ship]-32

      else if (Angle[Ship]<>da) and not (x[Ship] in [2000..440])
      and not (y[Ship] in [150..350])
      and not ((x[Ship]<25) or (x[Ship]>582) or (y[Ship]<25) or (y[Ship]>452)) then begin
         if (da in [Angle[Ship]-224..Angle[Ship]]) or (da-512 in [Angle[Ship]-228..Angle[Ship]]) then
          Angle[Ship]:=Angle[Ship]-32
         else Angle[Ship]:=Angle[Ship]+32
      end;
      if not (Angle[Ship] in [da-32..da+32]) and (x[Ship] in [50..590]) and (y[Ship] in [50..462]) then case random(20) of
         0: x[Ship]:=x[Ship]+1;
         1: x[Ship]:=x[Ship]-1;
         2: y[Ship]:=y[Ship]+1;
         3: y[Ship]:=y[Ship]-1;
         4: Angle[Ship]:=Angle[Ship]+32;
         5: Angle[Ship]:=Angle[Ship]-32;
         otherwise;
      end;
      while Angle[Ship]<0 do Angle[Ship]:=Angle[Ship]+512;
      while Angle[Ship]>=512 do Angle[Ship]:=Angle[Ship]-512;
   end;

   SetAPen(^MyScreen[AScr]^.RastPort,0);
   if sx1[Ship,AScr]<>0 then begin
      Move(^MyScreen[AScr]^.RastPort,sx1[Ship,AScr],sy1[Ship,AScr]);
      Draw(^MyScreen[AScr]^.RastPort,sx2[Ship,AScr],sy2[Ship,AScr]);
      sx1[Ship,AScr]:=0;
   end;

   BltBitMapRastPort(^ImgBitMap4,Angle[Ship],succ(Ship)*32,^MyScreen[Ascr]^.RastPort,x[Ship],y[Ship],32,32,192);

   if (Angle[Ship] in [da-32..da+32]) and ((x[Ship] in [x[1-Ship]-150..x[1-Ship]+150]) and (y[Ship] in [y[1-Ship]-150..y[1-Ship]+150])) then begin
      sx1[Ship,AScr]:=x[Ship]+16;
      sy1[Ship,AScr]:=y[Ship]+16;
      FireFactor:=(abs(sx1[Ship,AScr]-x[1-Ship]+16)+abs(sy1[Ship,AScr]-y[1-Ship]+16)) div 3;
      if FireFactor>75 then FireFactor:=75;
      sx2[Ship,AScr]:=sx1[Ship,AScr]+ FireFactor*mx[Angle[ship] div 32];
      sy2[Ship,AScr]:=sy1[Ship,AScr]+ FireFactor*my[Angle[ship] div 32];
      if (sx2[Ship,AScr]<1) or (sx2[Ship,AScr]>639) or (sy2[Ship,AScr]<1) or (sy2[Ship,AScr]>511) then sx1[Ship,AScr]:=0;
   end;

   SPAddrC^:=ZeroSound; SPLengthC^:=1;
   SPAddrD^:=ZeroSound; SPLengthD^:=1;
end;



procedure DRAWFIRE;

var Ship        :byte;

begin
   RECT(MyScreen[AScr]^,7,0,500,639,511);
   if SSHeader[0].ShieldS>=319 then RECT(MyScreen[AScr]^,14,0,501,319,510)
   else RECT(MyScreen[AScr]^,14,0,501,SSHeader[0].ShieldS,510);
   if SSHeader[1].ShieldS>=319 then RECT(MyScreen[AScr]^,15,319,501,639,510)
   else RECT(MyScreen[AScr]^,15,319,501,SSHeader[1].ShieldS+319,510);

   for Ship:=0 to 1 do if sx1[Ship,AScr]>0 then begin
      if Ship=0 then begin
         DMACON_WRITE^:=$0008;
         SPAddrD^:=BSFSoundMemA[2]; SPFreqD^:=350; SPLengthD^:=BSFSoundSize[2]; SPVolD^:=50;
         DMACON_WRITE^:=$8008;
      end else begin
         DMACON_WRITE^:=$0004;
         SPAddrC^:=BSFSoundMemA[3]; SPFreqC^:=300; SPLengthC^:=BSFSoundSize[3]; SPVolC^:=50;
         DMACON_WRITE^:=$8004;
      end;
      if Ship=0 then SetAPen(^MyScreen[AScr]^.RastPort,14) else SetAPen(^MyScreen[AScr]^.RastPort,15);
      Move(^MyScreen[AScr]^.RastPort,sx1[Ship,AScr],sy1[Ship,AScr]);
      Draw(^MyScreen[AScr]^.RastPort,sx2[Ship,AScr],sy2[Ship,AScr]);
      if (sx2[Ship,AScr] in [x[1-Ship]..x[1-Ship]+32]) and (sy2[Ship,AScr] in [y[1-Ship]..y[1-Ship]+32]) then begin
         SSHeader[1-Ship].ShieldS:=SSHeader[1-Ship].ShieldS-SSHeader[Ship].WeaponS;
         if Ship=0 then begin
            DMACON_WRITE^:=$0004;
            SPAddrC^:=SoundMemA[2]; SPFreqC^:=300; SPLengthC^:=SoundSize[2] div 2; SPVolC^:=64;
            DMACON_WRITE^:=$8004;
         end else begin
            DMACON_WRITE^:=$0008;
            SPAddrD^:=SoundMemA[2]; SPFreqD^:=350; SPLengthD^:=SoundSize[2] div 2; SPVolD^:=64;
            DMACON_WRITE^:=$8008;
         end;
      end;
   end;
end;



procedure KILLSHIP(Ship,Phase :byte);

begin
   if Phase=0 then begin
      WaitTOF;
      PLAYSOUND(2,1100);
      BltBitMapRastPort(^ImgBitMap4,0,0,^MyScreen[AScr]^.RastPort,x[Ship],y[Ship],32,32,192);
      WaitTOF;
   end else if Phase=16 then RectFill(^MyScreen[AScr]^.RastPort,x[Ship]-3,y[Ship]-3,x[Ship]+36,y[Ship]+36)
   else begin
      RectFill(^MyScreen[AScr]^.RastPort,x[Ship]-3,y[Ship]-3,x[Ship]+36,y[Ship]+36);
      BltBitMapRastPort(^ImgBitMap4,Phase*32,0,^MyScreen[Ascr]^.RastPort,x[Ship],y[Ship],32,32,192);
      SPAddrA^:=ZeroSound; SPLengthA^:=1;
      SPAddrB^:=ZeroSound; SPLengthB^:=1;
   end;
end;



begin
   Rotation:=0;
   randomize;
   for i:=1 to STARS do begin
      StarX[i]:=succ(random(639 div STARS))*STARS;
      StarY[i]:=succ(random(505 div STARS))*STARS;
   end;
   mx:=SArr15(0,1,2,2,2,2,2,1,0,-1,-2,-2,-2,-2,-2,-1);
   my:=SArr15(-2,-2,-2,-1,0,1,2,2,2,2,2,1,0,-1,-2,-2);
   sx1[0,1]:=0; sx1[1,1]:=0; sx1[0,2]:=0; sx1[1,2]:=0;
   x[1]:=520;   y[1]:=100;   Angle[1]:=random(17)*32;
   x[0]:=120;   y[0]:=412;   Angle[0]:=random(17)*32;
   StepCtr:=1;
   RECT(MyScreen[1]^,0,0,0,639,511);
   RECT(MyScreen[2]^,0,0,0,639,511);
   DMACON_WRITE^:=$000F;
   SPAddrA^:=BSFSoundMemA[4]; SPFreqA^:=450; SPLengthA^:=BSFSoundSize[4]; SPVolA^:=40;
   SPAddrB^:=BSFSoundMemA[4]+BSFSoundSize[4]*2;
                              SPFreqB^:=450; SPLengthB^:=BSFSoundSize[4]; SPVolB^:=40;
   DMACON_WRITE^:=$8003;
   repeat
      AScr:=3-AScr;
      SetAPen(^MyScreen[AScr]^.RastPort,12);
      for i:=1 to STARS do WritePixel(^MyScreen[AScr]^.RastPort,StarX[i],StarY[i]);
      SetAPen(^MyScreen[AScr]^.RastPort,0);
      STARFLY(0); STARFLY(1);
      DRAWFIRE;
      ScreenToFront(MyScreen[Ascr]);
   until (SSHeader[0].ShieldS<0) or (SSHeader[1].ShieldS<0);
   if SSHeader[0].ShieldS<0 then NowDie:=0;
   if SSHeader[1].ShieldS<0 then NowDie:=1;
   for i:=1 to 2 do if sx1[NowDie,i]<>0 then begin
      SetAPen(^MyScreen[i]^.RastPort,0);
      Move(^MyScreen[i]^.RastPort,sx1[NowDie,i],sy1[NowDie,i]);
      Draw(^MyScreen[i]^.RastPort,sx2[NowDie,i],sy2[NowDie,i]);
      sx1[NowDie,i]:=0;
   end;
   AScr:=3-AScr;
   SetAPen(^MyScreen[Ascr]^.RastPort,0);
   if SSHeader[1-NowDie].ShieldS<=0 then SSheader[1-NowDie].ShieldS:=1;
   KILLSHIP(NowDie,0);
   STARFLY(1-NowDie);
   ScreenToFront(MyScreen[Ascr]);
   for i:=1 to 16 do for j:=1 to 4 do begin
      AScr:=3-AScr;
      SetAPen(^MyScreen[Ascr]^.RastPort,0);
      KILLSHIP(NowDie,i);
      STARFLY(1-NowDie);
      ScreenToFront(MyScreen[Ascr]);
   end;
   for i:=1 to 35 do begin
      AScr:=3-AScr;
      SetAPen(^MyScreen[AScr]^.RastPort,12);
      for i:=1 to STARS do WritePixel(^MyScreen[AScr]^.RastPort,StarX[i],StarY[i]);
      SetAPen(^MyScreen[AScr]^.RastPort,0);
      STARFLY(1-NowDie);
      ScreenToFront(MyScreen[Ascr]);
   end;
   DMACON_WRITE^:=$000F;
end;



function SMALLSHIPFIGHT(ShipPtr1,ShipPtr2,ShipPtr02 :ShipHeader; Mode,ActSys :byte):byte;

var Shield1,Shield2,Fire1,Fire2 :integer;

begin
   Shield1:=ShipPtr1^.Shield+ShipPtr1^.ShieldBonus+MyShipPtr^.Tactical*3;
   repeat
      Shield2:=ShipPtr2^.Shield+ShipPtr2^.ShieldBonus+MyShipPtr^.Tactical*3;
      Fire1:=round((ShipPtr1^.Weapon/10+1)*ShipData[ShipPtr1^.SType].WeaponPower-ShipPtr1^.Tactical);
      Fire2:=round((ShipPtr2^.Weapon/10+1)*ShipData[ShipPtr2^.SType].WeaponPower-ShipPtr2^.Tactical);
      randomize;
      repeat
         case random(2) of
            0: Shield1:=Shield1-Fire2;
            1: Shield2:=Shield2-Fire1;
         end;
      until (Shield1<=0) or (Shield2<=0);
      if Shield1<=0 then begin
         SMALLSHIPFIGHT:=1;
         with ShipPtr2^ do begin
            if Shield2-ShieldBonus-Tactical*3>0 then
             Shield:=Shield2-ShieldBonus-Tactical*3 else Shield:=1;
            if ShipPtr1^.SType>SType then ShieldBonus:=ShieldBonus+(ShipPtr1^.SType-SType)
            else ShieldBonus:=ShieldBonus+1;
         end;
         ShipPtr1^.Owner:=0;
         exit;
      end else begin
         SMALLSHIPFIGHT:=2;
         with ShipPtr1^ do begin
            if Shield1-ShieldBonus-Tactical*3>0 then
             Shield:=Shield1-ShieldBonus-Tactical*3 else Shield:=1;
            if ShipPtr2^.SType>SType then ShieldBonus:=ShieldBonus+(ShipPtr2^.SType-SType)
            else ShieldBonus:=ShieldBonus+1;
            PosX:=FromX;
            PosY:=FromY;
         end;
         ShipPtr2^.Owner:=0;
         if Mode in [MODE_ALL,MODE_FLEET] then begin
            if not (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0)
            or (ShipPtr1^.Owner=ActPlayerFlag) or (ShipPtr2^.Owner=ActPlayerFlag) then begin
               if Mode=MODE_ALL then begin
                  if Visible then PLAYSOUND(2,900);
                  delay(20);
               end else begin
                  ShipPtr2^.PosX:=ShipPtr02^.PosX;
                  ShipPtr2^.PosY:=ShipPtr02^.PosY;
                  if Visible then EXPLODE(ActSys,ShipPtr2);
               end;
            end;
            repeat
               ShipPtr2:=ShipPtr2^.NextShip
            until (ShipPtr2^.Owner<>0) or (ShipPtr2=NIL);
         end;
      end;
   until (Mode=MODE_ONCE) or (ShipPtr2=NIL);
end;



procedure BIGFIGHTEXIT;

var b   :boolean;

begin
   DoClock:=false;
   CLOSEMYSCREENS;
   b:=OPENMAINSCREENS;
   b:=INITDESK(0);
   Screen2:=0;
   if (SSHeader[0].ShieldS>0) and (SSHeader[1].ShieldS>0) then BIGSHIPFIGHT:=SMALLSHIPFIGHT(ShipPtr1,ShipPtr2,NIL,Mode,ActSys);
   DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   ScreenToFront(MyScreen[1]);
end;



begin
   ShipPtr1:=Ship1; ShipPtr2:=Ship2;
   if Ship2^.SType=SHIPTYPE_FLEET then begin
      ShipPtr2:=Ship2^.TargetShip;
      Mode:=MODE_FLEET;
   end;
   while (ShipPtr2^.Owner=0) and (ShipPtr2<>NIL) do ShipPtr2:=ShipPtr2^.NextShip;
   if ShipPtr2=NIL then begin
      BIGSHIPFIGHT:=2;
      exit;
   end;
   if (Save.CivPlayer[GETCIVVAR(ShipPtr1^.Owner)]<>0)
    or (Save.CivPlayer[GETCIVVAR(ShipPtr2^.Owner)]<>0)
    or (Display=ActSys) then Visible:=true else Visible:=false;
   if ((ShipPtr1^.Owner<>ActPlayerFlag) and (ShipPtr2^.Owner<>ActPlayerFlag))
   or ((Save.CivPlayer[GETCIVVAR(ShipPtr1^.Owner)]=0) and (Save.CivPlayer[GETCIVVAR(ShipPtr2^.Owner)]=0))
   or (Save.SmallFight) or (Ship2^.SType=SHIPTYPE_FLEET) then begin
      l:=SMALLSHIPFIGHT(ShipPtr1,ShipPtr2,Ship2,Mode,ActSys);
      if (l=1) and Visible then EXPLODE(ActSys,ShipPtr1)
      else if (l=2) and (Mode<>MODE_FLEET) and Visible then EXPLODE(ActSys,ShipPtr2);
      BIGSHIPFIGHT:=l;
      if Ship2^.SType=SHIPTYPE_FLEET then begin
         ShipPtr2:=Ship2^.TargetShip;
         repeat
            if ShipPtr2^.Owner=0 then begin
               Ship2^.TargetShip:=ShipPtr2^.NextShip;
               if ShipPtr2^.NextShip<>NIL then ShipPtr2^.NextShip^.BeforeShip:=Ship2;
               LINKSHIP(ShipPtr2,Ship2,0);
            end;
            ShipPtr2:=Ship2^.TargetShip;
         until (ShipPtr2=NIL) or (ShipPtr2^.Owner<>0);
         if ShipPtr2=NIL then Ship2^.Owner:=0
         else if ShipPtr2^.NextShip=NIL then begin
            Ship2^.Owner:=0;
            Ship2^.SType:=8;
            ShipPtr2^.PosX:=Ship2^.PosX;
            ShipPtr2^.PosY:=Ship2^.PosY;
            LINKSHIP(ShipPtr2,Ship2,0);
         end;
         REFRESHDISPLAY;
      end;
      exit;
   end;
   SSHeader[0].ShieldS:=1;
   SSHeader[1].ShieldS:=1;
   CLOSEMYSCREENS;
   Display:=100;
   MyScreen[1]:=NIL;         MyScreen[2]:=NIL;
   NeuScreen:=NewScreen(0,0,640,512,4,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   for i:=1 to 2 do begin
      MyScreen[i]:=OpenScreenTagList(^NeuScreen,^Tags);
      if MyScreen[i]<>NIL then begin
         SetRGB4(^MyScreen[i]^.ViewPort,1,0,0,0);
         SetRGB4(^MyScreen[i]^.ViewPort,2,13,13,15);  SetRGB4(^MyScreen[i]^.ViewPort,3,12,12,14);
         SetRGB4(^MyScreen[i]^.ViewPort,4,11,11,13);  SetRGB4(^MyScreen[i]^.ViewPort,5,10,10,12);
         SetRGB4(^MyScreen[i]^.ViewPort,6,9,9,11);    SetRGB4(^MyScreen[i]^.ViewPort,7,8,8,10);
         SetRGB4(^MyScreen[i]^.ViewPort,8,15,0,0);    SetRGB4(^MyScreen[i]^.ViewPort,9,7,5,5);
         SetRGB4(^MyScreen[i]^.ViewPort,10,15,15,0);  SetRGB4(^MyScreen[i]^.ViewPort,11,15,2,12);
         SetRGB4(^MyScreen[i]^.ViewPort,12,15,15,15); SetRGB4(^MyScreen[i]^.ViewPort,13,1,1,15);
      end;
   end;
   SWITCHDISPLAY;
   if MyScreen[1]=NIL then begin
      BIGFIGHTEXIT; exit;
   end;
   if MyScreen[2]=NIL then begin
      BIGFIGHTEXIT; exit;
   end;
   AScr:=2;
   repeat
      if not INITIMAGES then begin
         BIGFIGHTEXIT; exit;
      end;
      with ShipPtr1^ do SSHeader[0]:=r_SmallShipHeader((Shield+ShieldBonus+Tactical*3)*2,round((Weapon/10+1)*ShipData[SType].WeaponPower-Tactical));
      with ShipPtr2^ do SSHeader[1]:=r_SmallShipHeader((Shield+ShieldBonus+Tactical*3)*2,round((Weapon/10+1)*ShipData[SType].WeaponPower-Tactical));
      for i:=1 to 2 do begin
         case ShipPtr1^.Owner of
            FLAG_TERRA:  SetRGB32(^MyScreen[i]^.ViewPort,14,$66000000,$66000000,$FF000000);
            FLAG_KLEGAN: SetRGB32(^MyScreen[i]^.ViewPort,14,$FF000000,        0,        0);
            FLAG_REMALO: SetRGB32(^MyScreen[i]^.ViewPort,14,        0,$FF000000,$11000000);
            FLAG_CARDAC: SetRGB32(^MyScreen[i]^.ViewPort,14,$FF000000,$FF000000,        0);
            FLAG_FERAGI: SetRGB32(^MyScreen[i]^.ViewPort,14,$BA000000,$8B000000,$48000000);
            FLAG_BAROJA: SetRGB32(^MyScreen[i]^.ViewPort,14,$FF000000,        0,$B0000000);
            FLAG_VOLKAN: SetRGB32(^MyScreen[i]^.ViewPort,14,$77000000,$77000000,$77000000);
            FLAG_OTHER:  SetRGB32(^MyScreen[i]^.ViewPort,14,        0,$FF000000,$FF000000);
            otherwise    SetRGB32(^MyScreen[i]^.ViewPort,14,$FF000000,$FF000000,$FF000000);
         end;
      end;
      for i:=1 to 2 do begin
         case ShipPtr2^.Owner of
            FLAG_TERRA:  SetRGB32(^MyScreen[i]^.ViewPort,15,$66000000,$66000000,$FF000000);
            FLAG_KLEGAN: SetRGB32(^MyScreen[i]^.ViewPort,15,$FF000000,        0,        0);
            FLAG_REMALO: SetRGB32(^MyScreen[i]^.ViewPort,15,        0,$FF000000,$11000000);
            FLAG_CARDAC: SetRGB32(^MyScreen[i]^.ViewPort,15,$FF000000,$FF000000,        0);
            FLAG_FERAGI: SetRGB32(^MyScreen[i]^.ViewPort,15,$BA000000,$8B000000,$48000000);
            FLAG_BAROJA: SetRGB32(^MyScreen[i]^.ViewPort,15,$FF000000,        0,$B0000000);
            FLAG_VOLKAN: SetRGB32(^MyScreen[i]^.ViewPort,15,$77000000,$77000000,$77000000);
            FLAG_OTHER:  SetRGB32(^MyScreen[i]^.ViewPort,15,        0,$FF000000,$FF000000);
            otherwise    SetRGB32(^MyScreen[i]^.ViewPort,15,$FF000000,$FF000000,$FF000000);
         end;
      end;
      XTRAROUND;
      if SSHeader[0].ShieldS<0 then begin
         BIGSHIPFIGHT:=1;
         with ShipPtr2^ do begin
            if (SSHeader[1].ShieldS div 2)-ShieldBonus-Tactical*3>0 then
             Shield:=(SSHeader[1].ShieldS div 2)-ShieldBonus-Tactical*3 else Shield:=1;
            if ShipPtr1^.SType>SType then ShieldBonus:=ShieldBonus+(ShipPtr1^.SType-SType)
            else ShieldBonus:=ShieldBonus+1;
         end;
         ShipPtr1^.Owner:=0;
      end else begin
         BIGSHIPFIGHT:=2;
         with ShipPtr1^ do begin
            if (SSHeader[0].ShieldS div 2)-ShieldBonus-Tactical*3>0 then
             Shield:=(SSHeader[0].ShieldS div 2)-ShieldBonus-Tactical*3 else Shield:=1;
            if ShipPtr2^.SType>SType then ShieldBonus:=ShieldBonus+(ShipPtr2^.SType-SType)
            else ShieldBonus:=ShieldBonus+1;
            PosX:=FromX;
            PosY:=FromY;
         end;
         ShipPtr2^.Owner:=0;
         if Mode=MODE_ALL then begin
            repeat
               ShipPtr2:=ShipPtr2^.NextShip
            until (ShipPtr2^.Owner<>0) or (ShipPtr2=NIL);
         end;
      end;
   until (Mode=MODE_ONCE) or (ShipPtr2=NIL) or (ShipPtr1^.Owner=0);

   BIGFIGHTEXIT;
end;



procedure DRAWRECT(x,y :long);

begin
   if (x in [1..480]) and (y in [1..480]) then BOX(MyScreen[1]^,x,y,x+31,y+31);
   WritePixel(^MyScreen[1]^.RastPort,575+MyShipPtr^.PosX,62+MyShipPtr^.PosY);
end;



function STARTBIGSHIPFIGHT(Ship1,Ship2 :ShipHeader; Mode,ActSys :byte):byte;

var MyShipPtr   :^r_ShipHeader;
var Result      :byte;
var SFight      :boolean;

begin
   SFight:=true;
   if Ship1^.SType=SHIPTYPE_FLEET then begin
      exchange(SFight,Save.SmallFight);
      MyShipPtr:=Ship1^.TargetShip;
      repeat
         MyShipPtr^.PosX:=Ship1^.PosX;
         MyShipPtr^.PosY:=Ship1^.PosY;
         Result:=BIGSHIPFIGHT(MyShipPtr,Ship2,Mode,ActSys);
         if MyShipPtr^.Owner=0 then begin
            Ship1^.TargetShip:=MyShipPtr^.NextShip;
            if MyShipPtr^.NextShip<>NIL then MyShipPtr^.NextShip^.BeforeShip:=Ship1;
            LINKSHIP(MyShipPtr,Ship1,0);
         end;
         MyShipPtr:=Ship1^.TargetShip;
      until (Result=2) or (MyShipPtr=NIL);
      if MyShipPtr=NIL then Ship1^.Owner:=0
      else if MyShipPtr^.NextShip=NIL then begin
         Ship1^.Owner:=0;
         Ship1^.SType:=8;
         LINKSHIP(MyShipPtr,Ship1,0);
      end;
      exchange(SFight,Save.SmallFight);
   end else STARTBIGSHIPFIGHT:=BIGSHIPFIGHT(Ship1,Ship2,Mode,ActSys);
end;



function PLANETHANDLING(ActSys :byte; MyShipPtr :ShipHeader):boolean;

const GADGET_ANGRIFF= 1;
const GADGET_ORBIT=   2;
const GADGET_LADEN=   3;
const GADGET_LANDUNG= 4;
const GADGET_DIPLOMAT=8;
const GADGET_ATTACK =16;


const MAXGADGETS=7;

var GadSet              :array [1..MAXGADGETS] of byte;
var GadCnt              :byte;
var l                   :long;
var i                   :integer;
var b,OldCiviPlanet     :boolean;
var ShipsInOrbit        :byte;
var LTOut,SOut,FIn      :integer;
var MyPlanetHeader      :^r_PlanetHeader;
var ActPProjects        :^ByteArr42;
var XShipPtr            :^r_ShipHeader;
var s                   :string;

procedure DIPLOMACY;

const OPT_NONE=10;
const OPT_SYSTEM=20;
const OPT_TECH=30;
const OPT_MONEY=40;
const OPT_WAR=50;
const OPT_HELP=60;
const OPT_SHIP=70;

var OptArr                              :array[1..7] of str;
var OptID                               :array[1..7] of byte;
var XSystem,XTech,CivVar,CivFlag,Opts   :byte;
var XCosts,l                            :long;
var s                                   :array [1..MAXCIVS] of string[20];
var s2                                  :string;


procedure NEGATIVEANSWER;

var s   :string;

begin
   MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
   s:=PText[215]+' '+GETCIVADJ(ActPlayer)+PText[416];
   WRITE(256,140,ActPlayerFlag,16,MyScreen[1]^,4,s);
   WRITE(256,165,ActPlayerFlag,16,MyScreen[1]^,4,PText[417]);
   WAITLOOP(false);
   RECT(MyScreen[1]^,0,85,120,425,200);
   REFRESHDISPLAY;
end;


procedure POSITIVEANSWER;

var s   :string;

begin
   Save.WarState[ActPlayer,CivVar]:=LEVEL_PEACE;
   Save.WarState[CivVar,ActPlayer]:=LEVEL_PEACE;
   MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
   s:=PText[215]+' '+GETCIVADJ(ActPlayer)+PText[418];
   WRITE(256,140,ActPlayerFlag,16,MyScreen[1]^,4,s);
   WRITE(256,165,ActPlayerFlag,16,MyScreen[1]^,4,PText[419]);
   WAITLOOP(false);
   RECT(MyScreen[1]^,0,85,120,425,200);
   REFRESHDISPLAY;
end;


function GETOPTION:byte;

var Pos,i       :byte;

begin
   MAKEBORDER(MyScreen[1]^,50,100,460,240,12,6,0);
   for i:=1 to Opts do  WRITE(60,i*20+90,12,0,MyScreen[1]^,4,OptArr[i]);
   Pos:=1;
   repeat
      delay(RDELAY);
      if IBase^.MouseY in [110..(90+succ(Opts)*20)] then begin
         i:=(IBase^.MouseY-90) div 20;
         if (i<>Pos) and (i in [1..Opts]) then begin
            Pos:=i;
            for i:=1 to Opts do if i=Pos then
             WRITE(60,i*20+90,CivFlag,0,MyScreen[1]^,4,OptArr[i])
            else WRITE(60,i*20+90,12,0,MyScreen[1]^,4,OptArr[i])
         end;
      end;
   until (LData^ and 64=0) or (RData^ and 1024=0);
   if (RData^ and 1024)=0 then Pos:=0;
   PLAYSOUND(1,300);
   GETOPTION:=Pos;
   RECT(MyScreen[1]^,0,50,100,460,240);
   REFRESHDISPLAY;
end;



function SMALLREQUEST(s :str):boolean;

var s2  :string;

begin
   MAKEBORDER(MyScreen[1]^,35,110,475,220,12,6,0);
   s2:='Player '+intstr(Save.CivPlayer[CivVar])+', '+PText[421];
   WRITE(256,130,CivFlag,16,MyScreen[1]^,4,s2);
   WRITE(256,155,CivFlag,16,MyScreen[1]^,4,s);
   DrawImage(^MyScreen[1]^.RastPort,^GadImg1,55,190);
   DrawImage(^MyScreen[1]^.RastPort,^GadImg1,337,190);
   WRITE(115,192,8,16,MyScreen[1]^,4,PText[245]);
   WRITE(397,192,8,16,MyScreen[1]^,4,PText[246]);
   repeat
      delay(RDELAY);
   until (LData^ and 64=0) and (IBase^.MouseX in [55..183,337..465])
     and (IBase^.MouseY in [190..210]);
   if IBase^.MouseX in [55..183] then begin
      KLICKGAD(55,190);
      SMALLREQUEST:=true;
   end else begin
      KLICKGAD(337,190);
      SMALLREQUEST:=false;
   end;
   RECT(MyScreen[1]^,0,35,110,475,220);
   REFRESHDISPLAY;
end;



procedure CALLOTHERPLAYER;

begin
   PLAYERJINGLE(CivVar);
   MAKEBORDER(MyScreen[1]^,35,80,475,290,12,6,0);
   WRITE(256,95,12,16,MyScreen[1]^,4,PText[422]);
   WRITE(256,125,12,16,MyScreen[1]^,4,'-');
   s2:=GETCIVNAME(ActPlayer); WRITE(160,125,ActPlayerFlag,16,MyScreen[1]^,4,s2);
   s2:=GETCIVNAME(CivVar);    WRITE(351,125,CivFlag,16,MyScreen[1]^,4,s2);
   DISPLAYLOGO(ActPlayer,96,150);
   DISPLAYLOGO(CivVar,287,150);
   WAITLOOP(false);
   RECT(MyScreen[1]^,0,35,80,475,290);
   REFRESHDISPLAY;
end;



begin
   CivFlag:=MyPlanetHeader^.PFlags and FLAG_CIV_MASK;
   CivVar:=GETCIVVAR(CivFlag);
   XSystem:=0;
   for i:=1 to Save.SYSTEMS do
    if (SystemFlags[CivVar,i] and FLAG_CIV_MASK=CivFlag)
    and (SystemHeader[i].SysOwner<>CivFlag) then XSystem:=i;
   XTech:=0;
   for i:=42 downto 1 do if (Save.TechCosts[ActPlayer,i]>0) and (Save.TechCosts[CivVar,i]<=0) then XTech:=i;
   XCosts:=abs(Year) * 43;
   if (XCosts>Save.Staatstopf[CivVar]) then XCosts:=Save.Staatstopf[CivVar];
   Opts:=1;
   if Save.WarState[ActPlayer,CivVar]=LEVEL_WAR then begin
      OptArr[Opts]:=PText[423];
      OptID[Opts]:=OPT_NONE;
      Opts:=2;
      if XSystem>0 then begin
         OptArr[Opts]:=PText[424];
         OptID[Opts]:=OPT_SYSTEM;
         Opts:=Opts+1;
      end;
      if XTech>0 then begin
         OptArr[Opts]:=PText[425];
         OptID[Opts]:=OPT_TECH;
         Opts:=Opts+1;
      end;
      OptArr[Opts]:=PText[426];
      OptID[Opts]:=OPT_MONEY;
      Opts:=Opts+1;
   end else begin
      if XSystem>0 then begin
         OptArr[Opts]:=PText[427];
         OptID[Opts]:=OPT_SYSTEM;
         Opts:=Opts+1;
      end;
      if XTech>0 then begin
         OptArr[Opts]:=PText[428];
         OptID[Opts]:=OPT_TECH;
         Opts:=Opts+1;
      end;
      OptArr[Opts]:=PText[429];
      OptID[Opts]:=OPT_MONEY;
      Opts:=Opts+1;
      OptArr[Opts]:=PText[430];
      OptID[Opts]:=OPT_WAR;
      Opts:=Opts+1;
      if Save.CivPlayer[CivVar]=0 then begin
         OptArr[Opts]:=PText[431];
         OptID[Opts]:=OPT_HELP;
         Opts:=Opts+1;
         if Save.WarPower[CivVar]<Save.WarPower[ActPlayer] then begin
            OptArr[Opts]:=PText[432];
            OptID[Opts]:=OPT_SHIP;
            Opts:=Opts+1;
         end;
      end;
   end;
   Opts:=Opts-1;
   l:=GETOPTION;
   if l=0 then exit;
   if (CivVar=8) and (Save.WorldFlag=WFLAG_JAHADR) and (OptID[l]<>OPT_HELP)
    then OptID[l]:=OPT_NONE;
   if (Save.CivPlayer[CivVar]<>0) and not Save.PlayMySelf then begin
      if OptID[l]<>OPT_WAR then CALLOTHERPLAYER;
      case OptID[l] of
         OPT_NONE:   begin
                        if SMALLREQUEST(PText[435])
                        then POSITIVEANSWER else NEGATIVEANSWER;
                     end;
         OPT_SYSTEM: begin
                        s2:=PText[436]+' '+Save.SystemName[XSystem]+' '+PText[437];
                        SYSINFO(XSystem,CivFlag);
                        if not SMALLREQUEST(s2) then NEGATIVEANSWER else begin
                           POSITIVEANSWER;
                           SYSTEMTOENEMY(XSystem,ActPlayerFlag,CivFlag);
                        end;
                        RECT(MyScreen[1]^,0,30,250,480,360);
                     end;
         OPT_TECH:   begin
                        s2:=PText[438]+' '+TechnologyL[XTech]+' '+PText[437];
                        if not SMALLREQUEST(s2) then NEGATIVEANSWER else begin
                           POSITIVEANSWER;
                           Save.TechCosts[ActPlayer,XTech]:=0;
                           DISPLAYTECH(XTech,ActPlayer);
                        end;
                     end;
         OPT_MONEY:  begin
                        s2:=intstr(XCosts)+' '+PText[439];
                        if not SMALLREQUEST(s2) then NEGATIVEANSWER else begin
                           POSITIVEANSWER;
                           Save.Staatstopf[CivVar]:=Save.StaatsTopf[CivVar]-XCosts;
                           Save.Staatstopf[ActPlayer]:=Save.StaatsTopf[ActPlayer]+XCosts;
                           PRINTGLOBALINFOS(ActPlayer);
                        end;
                     end;
         OPT_WAR:    begin
                        Opts:=1;
                        for i:=1 to pred(MAXCIVS) do if not (i in [CivVar,ActPlayer])
                        and not (Save.WarState[ActPlayer,i] in [LEVEL_DIED,LEVEL_UNKNOWN])
                        and ((i<8) or (Save.WorldFlag<>0)) then begin
                           s[i]:=PText[440]+' '+GETCIVNAME(i);
                           OptArr[Opts]:=s[i];
                           OptID[Opts]:=i;
                           Opts:=Opts+1;
                        end;
                        Opts:=Opts-1;
                        if Opts>0 then begin
                           l:=GETOPTION;
                           if l=0 then exit;
                           CALLOTHERPLAYER;
                           s2:=PText[441]+' '+GETCIVNAME(OptID[l])+' '+PText[442];
                           if not SMALLREQUEST(s2) then NEGATIVEANSWER else begin
                              POSITIVEANSWER;
                              GOTOWAR(ActPlayerFlag,GETCIVFLAG(OptID[l]));
                              GOTOWAR(CivFlag,GETCIVFLAG(OptID[l]));
                              Save.WarState[ActPlayer,CivVar]:=LEVEL_ALLIANZ;
                              Save.WarState[CivVar,ActPlayer]:=LEVEL_ALLIANZ;
                           end;
                        end else begin
                           MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                           WRITE(256,140,12,16,MyScreen[1]^,4,PText[445]);
                           WRITE(256,160,12,16,MyScreen[1]^,4,PText[446]);
                           WAITLOOP(false);
                           RECT(MyScreen[1]^,0,85,120,425,200);
                           REFRESHDISPLAY;
                        end;
                     end;

         otherwise;
      end;
      exit;
   end;
   case OptID[l] of
      OPT_NONE:   VERHANDLUNG(CivFlag,MODE_FORCE);
      OPT_SYSTEM: if (Save.WarPower[CivVar]*4>Save.WarPower[ActPlayer]) or (XSystem=0) then NEGATIVEANSWER
                  else if random(2)=0 then begin
                     POSITIVEANSWER;
                     SYSTEMTOENEMY(XSystem,ActPlayerFlag,CivFlag);
                     if (Save.WorldFlag=ActPlayerFlag) and (CivVar=8) then STOPCIVILWAR(0);
                  end else VERHANDLUNG(CivFlag,MODE_OFFENSIV);
      OPT_TECH:   if (Save.WarPower[CivVar]*3>Save.WarPower[ActPlayer]) or (XTech=0) then NEGATIVEANSWER
                  else if random(3)<>0 then begin
                     POSITIVEANSWER;
                     Save.TechCosts[ActPlayer,XTech]:=0;
                     DISPLAYTECH(XTech,ActPlayer);
                     if (Save.WorldFlag=ActPlayerFlag) and (CivVar=8) then STOPCIVILWAR(0);
                  end else VERHANDLUNG(CivFlag,MODE_OFFENSIV);
      OPT_MONEY:  if (Save.WarPower[CivVar]*2>Save.WarPower[ActPlayer]) or (XCosts<10000) then NEGATIVEANSWER
                  else if random(3)<>0 then begin
                     Save.WarState[ActPlayer,CivVar]:=LEVEL_PEACE;
                     Save.WarState[CivVar,ActPlayer]:=LEVEL_PEACE;
                     Save.Staatstopf[CivVar]:=Save.StaatsTopf[CivVar]-XCosts;
                     Save.Staatstopf[ActPlayer]:=Save.StaatsTopf[ActPlayer]+XCosts;
                     MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                     WRITE(256,127,ActPlayerFlag,16,MyScreen[1]^,4,PText[447]);
                     WRITE(256,147,ActPlayerFlag,16,MyScreen[1]^,4,PText[448]);
                     s[1]:=intstr(XCosts);
                     WRITE(256,173,CivFlag,16,MyScreen[1]^,4,s[1]);
                     WAITLOOP(false);
                     RECT(MyScreen[1]^,0,85,120,425,200);
                     if (Save.WorldFlag=ActPlayerFlag) and (CivVar=8) then STOPCIVILWAR(0);
                  end else VERHANDLUNG(CivFlag,MODE_OFFENSIV);
      OPT_WAR:    begin
                     Opts:=1;
                     for i:=1 to pred(MAXCIVS) do if not (i in [CivVar,ActPlayer])
                     and not (Save.WarState[ActPlayer,i] in [LEVEL_DIED,LEVEL_UNKNOWN])
                     and ((i<8) or (Save.WorldFlag<>0)) then begin
                        s[i]:=PText[440]+' '+GETCIVNAME(i);
                        OptArr[Opts]:=s[i];
                        OptID[Opts]:=i;
                        Opts:=Opts+1;
                     end;
                     Opts:=Opts-1;
                     if Opts>0 then begin
                        l:=GETOPTION;
                        if l=0 then exit;
                        if ((CivVar in [2..4]) and (Save.WarPower[CivVar]>80)) or
                         ((Save.GlobalFlags[CivVar]=GFLAG_ATTACK) and (Save.WarPower[ActPlayer]+Save.WarPower[OptID[l]]>Save.WarPower[CivVar]))
                         or (Save.WarState[CivVar,OptID[l]]=LEVEL_WAR) then begin
                            POSITIVEANSWER;
                            GOTOWAR(ActPlayerFlag,GETCIVFLAG(OptID[l]));
                            GOTOWAR(CivFlag,GETCIVFLAG(OptID[l]));
                            if (CivVar<>8) and (ActPlayer<>8) then begin
                               Save.WarState[ActPlayer,CivVar]:=LEVEL_ALLIANZ;
                               Save.WarState[CivVar,ActPlayer]:=LEVEL_ALLIANZ;
                            end;
                         end else NEGATIVEANSWER;
                     end else begin
                        MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                        WRITE(256,140,12,16,MyScreen[1]^,4,PText[445]);
                        WRITE(256,160,12,16,MyScreen[1]^,4,PText[446]);
                        WAITLOOP(false);
                        RECT(MyScreen[1]^,0,85,120,425,200);
                        REFRESHDISPLAY;
                     end;
                  end;
      OPT_HELP:   begin
                     i:=random(3);
                     if i in [0,1] then begin
                        XTech:=0;
                        for i:=40 downto 1 do
                         if (Save.TechCosts[ActPlayer,i]<=0) and (Save.TechCosts[CivVar,i]>0)
                         then XTech:=i;
                        if XTech=0 then i:=2 else begin
                           i:=0;
                           s2:=TechnologyL[XTech]+'.';
                           REQUEST(PText[450],s2,ActPlayerFlag,ActPlayerFlag);
                           Save.TechCosts[CivVar,XTech]:=0;
                           Save.WarState[CivVar,ActPlayer]:=LEVEL_ALLIANZ;
                           Save.WarState[ActPlayer,CivVar]:=LEVEL_ALLIANZ;
                        end;
                     end;
                     if i=2 then begin
                        XCosts:=abs(Year)*27;
                        if XCosts>Save.Staatstopf[ActPlayer] div 5
                         then XCosts:=Save.Staatstopf[ActPlayer] div 5;
                        if XCosts=0 then i:=3 else begin
                           i:=0;
                           s2:=PText[452]+' '+intstr(XCosts)+'.';
                           REQUEST(PText[451],s2,ActPlayerFlag,ActPlayerFlag);
                           Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]+XCosts;
                           Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-XCosts;
                           Save.WarState[CivVar,ActPlayer]:=LEVEL_ALLIANZ;
                           Save.WarState[ActPlayer,CivVar]:=LEVEL_ALLIANZ;
                           PRINTGLOBALINFOS(ActPlayer);
                        end;
                     end;
                     if i=3 then REQUEST(PText[453],PText[454],ActPlayerFlag,ActPlayerFlag);
                     RECT(MyScreen[1]^,0,85,120,425,200);
                     REFRESHDISPLAY;
                  end;
      OPT_SHIP:   begin
                     if MyShipPtr^.SType=SHIPTYPE_FLEET then PLAYSOUND(1,600) else begin
                        MyShipPtr^.Owner:=CivFlag;
                        MyShipPtr^.Moving:=0;
                     end;
                     RECT(MyScreen[1]^,0,85,120,425,200);
                     REFRESHDISPLAY;
                     delay(15);
                  end;
      otherwise;
   end;
end;



procedure MAKELOADWINDOW;

begin
   MAKEBORDER(MyScreen[1]^,42,148,469,273,12,6,0);
   BltBitMapRastPort(^ImgBitMap4,(MyShipPtr^.SType-8)*32,32,^MyScreen[1]^.RastPort,59,163,32,32,192);
   BltBitMapRastPort(^ImgBitMap7,MyPlanetHeader^.Class*32,0,^MyScreen[1]^.RastPort,59,227,32,32,192);
   for i:=1 to 3 do MAKEBORDER(MyScreen[1]^,i*115-3,163,i*115+97,193,12,6,1);
   with MyPlanetHeader^ do begin
      if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) or (Population=0) then MAKEBORDER(MyScreen[1]^,112,228,212,258,12,6,1);
      if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) or (Population>0) then MAKEBORDER(MyScreen[1]^,227,228,327,258,12,6,1);
      if ((PFlags and FLAG_CIV_MASK in [ActPlayerFlag,0]) or (ActPProjects^[34]=0) and (ActPProjects^[40]=0)
      or (ProjectPtr=NIL)) and (Class<>CLASS_STONES) then MAKEBORDER(MyScreen[1]^,342,228,442,258,12,6,1);
   end;
   WRITE(133,203,ActPlayerFlag,0,MyScreen[1]^,4,PText[456]);
   WRITE(232,203,ActPlayerFlag,0,MyScreen[1]^,4,PText[457]);
   WRITE(363,203,ActPlayerFlag,0,MyScreen[1]^,4,PText[458]);
end;


procedure WRITELOADDATA;


procedure CLIPPLANET(Class :byte);

begin
   BltBitMapRastPort(^ImgBitMap7,Class*32,0,^MyScreen[1]^.RastPort,59,227,32,32,192);
end;


begin
   with MyShipPtr^ do begin
      s:=intstr(ShipData[SType].MaxLoad);        while length(s)<2 do s:='0'+s;
      s:=intstr((Ladung and MASK_SIEDLER) div 16)+' '+s;  while length(s)<5 do s:='0'+s;
      WRITE(128,171,8,1,MyScreen[1]^,2,s);

      s:=intstr(ShipData[SType].MaxLoad); while length(s)<2 do s:='0'+s;
      s:=intstr(Ladung and MASK_LTRUPPS)+' '+s;    while length(s)<5 do s:='0'+s;
      WRITE(243,171,8,1,MyScreen[1]^,2,s);

      s:=intstr(round(Fracht/ShipData[SType].MaxLoad*100))+'%';
      while length(s)<4 do s:='0'+s;
      WRITE(364,171,8,1,MyScreen[1]^,2,s);

      with MyPlanetHeader^ do begin
         if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) or (Population=0) then begin
            s:=intstr(ActPProjects^[26]);   while length(s)<3 do s:='0'+s;
            WRITE(141,236,8,1,MyScreen[1]^,2,s);
         end;
         if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) or (Population>0) then begin
            if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) then s:=intstr(ActPProjects^[27])
            else if Population>0 then s:=intstr(LTOut);
            while length(s)<3 do s:='0'+s;
            WRITE(256,236,8,1,MyScreen[1]^,2,s);
         end;
         if ((PFlags and FLAG_CIV_MASK in [ActPlayerFlag,0]) or ((ActPProjects^[34]=0) and (ActPProjects^[40]=0))
         or (ProjectPtr=NIL)) and (Class<>CLASS_STONES) then begin
            s:=intstr(Water div Size)+'%';   while length(s)<4 do s:='0'+s;
            WRITE(353,236,8,1,MyScreen[1]^,2,s);
            if (Water div Size>80) then begin
               if Class=CLASS_ICE then begin
                  s:=' I  ';
                  CLIPPLANET(CLASS_ICE);
               end else begin
                  s:='W';
                  CLIPPLANET(CLASS_WATER);
               end;
            end else if (Water div Size in [55..80]) then begin
               s:='M';
               CLIPPLANET(CLASS_EARTH);
            end else if (Water div Size in [21..54]) then begin
               s:='H ';
               CLIPPLANET(CLASS_HALFEARTH);
            end else if (Water div Size<21) then begin
               s:='D ';
               CLIPPLANET(CLASS_DESERT);
            end;
            WRITE(419,235,ActPlayerFlag,1,MyScreen[1]^,4,s);
         end;
      end;
   end;
end;



begin
   PLANETHANDLING:=false;
   MyPlanetHeader:=ObjPtr;
   CivVar:=GETCIVVAR(MyPlanetHeader^.PFlags);
   if CivVar=0 then MyPlanetHeader^.Population:=0;
   ActPProjects:=MyPlanetHeader^.ProjectPtr;
   MyShipPtr^.PosX:=FromX;
   MyShipPtr^.PosY:=FromY;
   GadCnt:=1;
   for i:=1 to MAXGADGETS do GadSet[i]:=0;
   with MyPlanetHeader^ do begin
      ShipsInOrbit:=0;
      if FirstShip.NextShip<>NIL then begin
         XShipPtr:=FirstShip.NextShip;
         repeat
            ShipsInOrbit:=XShipPtr^.Owner;
            XShipPtr:=XShipPtr^.NextShip;
         until (ShipsInOrbit<>0) or (XShipPtr=NIL);
      end;
      l:=PFlags and FLAG_CIV_MASK;
      if not (l in [0,ActPlayerFlag]) then begin
         GadSet[1]:=GADGET_DIPLOMAT;
         GadCnt:=2;
      end;
      if not (l in [0,ActPlayerFlag]) and (ShipsInOrbit<>0) then begin
         GadSet[GadCnt]:=GADGET_ATTACK;
         GadCnt:=GadCnt+1;
      end;
      if (l in [0,ActPlayerFlag]) then
       if ShipsInOrbit in [0,ActPlayerFlag] then begin
         GadSet[GadCnt]:=GADGET_ORBIT;
         GadCnt:=GadCnt+1;
      end;
      if MyShipPtr^.SType<>SHIPTYPE_FLEET then begin
         if (Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,CLASS_ICE,
         CLASS_STONES,CLASS_WATER]) and
         (((ShipsInOrbit in [0,ActPlayerFlag]) and (ActPProjects^[34]=0) and (ActPProjects^[40]=0))
         or (ProjectPtr=NIL) or (l=ActPlayerFlag)) then begin
            GadSet[GadCnt]:=GADGET_LADEN;
            GadCnt:=GadCnt+1;
         end;
         if (Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,CLASS_ICE,CLASS_STONES,
         CLASS_WATER]) and ((ProjectPtr=NIL) or (l<>0) or (ActPProjects^[34]<>0)
         or (ActPProjects^[40]<>0)) and ((l=ActPlayerFlag) or (ShipsInOrbit=0)) then begin
            GadSet[GadCnt]:=GADGET_ANGRIFF;
            GadCnt:=GadCnt+1;
         end;
         if not (l<>ActPlayerFlag) and (ShipsInOrbit=0)
         and (((ActPProjects^[34]=0) and (ActPProjects^[40]=0))
         or (ProjectPtr=NIL)) then begin
            GadSet[GadCnt]:=GADGET_LANDUNG;
            GadCnt:=GadCnt+1;
         end;
      end;
      GadCnt:=GadCnt-1;
      MAKEBORDER(MyScreen[1]^,194,119,316,122+GadCnt*22,12,6,1);
      for i:=1 to GadCnt do begin
         DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
         case GadSet[i] of
            GADGET_LADEN:    WRITE(256,103+i*22,0,16,MyScreen[1]^,4,PText[460]);
            GADGET_ORBIT:    WRITE(256,103+i*22,0,16,MyScreen[1]^,4,PText[461]);
            GADGET_LANDUNG:  WRITE(256,103+i*22,0,16,MyScreen[1]^,4,PText[462]);
            GADGET_DIPLOMAT: WRITE(256,103+i*22,0,16,MyScreen[1]^,4,PText[463]);
            otherwise WRITE(256,102+i*22,0,16,MyScreen[1]^,4,PText[464]);
         end;
      end;
      b:=false;
      LTOut:=0; SOut:=0; FIn:=0;
      repeat
         delay(RDELAY);
         if (LData^ and 64=0) then begin
            if (IBase^.MouseX in [198..315]) and (IBase^.MouseY in [122..pred((100+succ(GadCnt)*22))]) then begin
               l:=(IBase^.MouseY-100) div 22;
               KLICKGAD(198,100+l*22);
               RECT(MyScreen[1]^,0,194,119,316,122+GadCnt*22);
               REFRESHDISPLAY;
               case GadSet[l] of
                  GADGET_ATTACK:   begin
                                      OtherShipPtr:=FirstShip.NextShip;
                                      while (OtherShipPtr<>NIL) and (OtherShipPtr^.Owner=0) do OtherShipPtr:=OtherShipPtr^.NextShip;
                                      if (OtherShipPtr<>NIL) and (OtherShipPtr^.Owner<>ActPlayerFlag) then begin
                                         MyShipPtr^.Moving:=0;
                                         MyShipPtr^.PosX:=FromX;
                                         MyShipPtr^.PosY:=FromY;
                                         if STARTBIGSHIPFIGHT(MyShipPtr,OtherShipPtr,MODE_ALL,ActSys)=1 then begin
                                            AUTOVERHANDLUNG(ActPlayerFlag,PFlags and FLAG_CIV_MASK,ActSys,0);
                                            MyShipPtr^.Moving:=0;
                                            exit;
                                         end;
                                         AUTOVERHANDLUNG(ActPlayerFlag,PFlags and FLAG_CIV_MASK,ActSys,0);
                                         exit;
                                      end;
                                   end;
                  GADGET_ANGRIFF:  begin
                                      b:=true;
                                      STARLANDING(MyPlanetHeader,MyShipPtr,ActSys);
                                      AUTOVERHANDLUNG(ActPlayerFlag,MyPlanetHeader^.PFlags and FLAG_CIV_MASK,ActSys,0);
                                   end;
                  GADGET_ORBIT:    begin
                                      if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
                                         XShipPtr:=^MyPlanetHeader^.FirstShip;
                                         while XShipPtr^.NextShip<>NIL do XShipPtr:=XShipPtr^.NextShip;
                                         XShipPtr^.NextShip:=MyShipPtr^.TargetShip;
                                         MyShipPtr^.TargetShip^.BeforeShip:=XShipPtr;
                                         MyShipPtr^.Owner:=0;
                                      end else begin
                                         LINKSHIP(MyShipPtr,^MyPlanetHeader^.FirstShip,1);
                                         DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
                                      end;
                                      exit;
                                   end;
                  GADGET_DIPLOMAT: begin
                                      DIPLOMACY;
                                      b:=true;
                                   end;
                  otherwise        with MyShipPtr^ do begin
                  {GADGET_LADEN,GADGET_LANDUNG}
                                      if MyPlanetHeader^.ProjectPtr=NIL then begin
                                         l:=AllocMem(sizeof(ByteArr42),MEMF_CLEAR);
                                         if l=0 then exit else ProjectPtr:=ptr(l);
                                         OldCiviPlanet:=false;
                                      end else OldCiviPlanet:=true;
                                      ActPProjects:=MyPlanetHeader^.ProjectPtr;
                                      ActPProjects^[0]:=1;
                                      b:=true;
                                      MAKELOADWINDOW;
                                      WRITELOADDATA;
                                      repeat
                                         delay(RDELAY);
                                         if (LData^ and 64=0) then begin
                                            if (MyPlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag) or
                                             (MyPlanetHeader^.Population=0) then begin
                                               if (IBase^.MouseX in [112..212]) and (IBase^.MouseY in [164..194])
                                               and (ActPProjects^[26]>0)
                                               and (ShipData[SType].MaxLoad>((Ladung and MASK_SIEDLER) div 16 + (Ladung and MASK_LTRUPPS)))
                                               and (15>(Ladung and MASK_SIEDLER) div 16)
                                               and (15>(Ladung and MASK_LTRUPPS))
                                               and (Fracht=0) then begin
                                                  PLAYSOUND(1,300);
                                                  ActPProjects^[26]:=ActPProjects^[26]-1;
                                                  Ladung:=Ladung+16;
                                                  SOut:=SOut-1;
                                               end;
                                               if (IBase^.MouseX in [112..212]) and (IBase^.MouseY in [228..258]) and
                                                  (ActPProjects^[26]<250) and ((Ladung and MASK_SIEDLER)>0)
                                                  and (Fracht=0) then begin
                                                  PLAYSOUND(1,300);
                                                  ActPProjects^[26]:=ActPProjects^[26]+1;
                                                  Ladung:=Ladung-16;
                                                  SOut:=SOut+1;
                                               end;
                                            end;
                                            if (MyPlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag) or
                                             (MyPlanetHeader^.Population>0) then begin
                                               if (IBase^.MouseX in [227..327]) and (IBase^.MouseY in [164..194])
                                               and (ActPProjects^[27]>0)
                                               and (ShipData[SType].MaxLoad>((Ladung and MASK_SIEDLER) div 16 + (Ladung and MASK_LTRUPPS)))
                                               and (15>(Ladung and MASK_SIEDLER) div 16)
                                               and (15>(Ladung and MASK_LTRUPPS))
                                               and (Fracht=0) and
                                               ((MyPlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag) or (LTOut>0)) then begin
                                                  PLAYSOUND(1,300);
                                                  ActPProjects^[27]:=ActPProjects^[27]-1;
                                                  Ladung:=Ladung+1;
                                                  LTOut:=LTOut-1;
                                               end;
                                               if (IBase^.MouseX in [227..327]) and (IBase^.MouseY in [228..258])
                                               and (ActPProjects^[27]<250) and ((Ladung and MASK_LTRUPPS)>0)
                                               and (Fracht=0) then begin
                                                  PLAYSOUND(1,300);
                                                  ActPProjects^[27]:=ActPProjects^[27]+1;
                                                  Ladung:=Ladung-1;
                                                  LTOut:=LTOut+1;
                                               end;
                                            end;
                                            if ((MyPlanetHeader^.PFlags and FLAG_CIV_MASK in [ActPlayerFlag,0]) or
                                               (ActPProjects^[34]=0) and (ActPProjects^[40]=0))
                                            and (MyPlanetHeader^.Class<>CLASS_STONES) then begin
                                               repeat
                                                  delay(RDELAY);
                                                  if (IBase^.MouseX in [342..442]) and (IBase^.MouseY in [164..194])
                                                  and (Ladung=0) and (Fracht<ShipData[SType].MaxLoad) and (Water>10) then begin
                                                     delay(7);
                                                     Fracht:=Fracht+1;
                                                     FIn:=FIn+1;
                                                     Water:=Water-5;
                                                     WRITELOADDATA;
                                                  end;
                                                  if (IBase^.MouseX in [342..442]) and (IBase^.MouseY in [228..258])
                                                  and (Fracht>0) and (Water div Size<100) then begin
                                                     delay(7);
                                                     Water:=Water+5;
                                                     FIn:=FIn-1;
                                                     Fracht:=Fracht-1;
                                                     WRITELOADDATA;
                                                  end;
                                               until not (LData^ and 64=0);
                                            end;
                                            WRITELOADDATA;
                                         end;
                                      until (RData^ and 1024=0);
                                      PLAYSOUND(1,300);
                                      RECT(MyScreen[1]^,0,42,148,469,273);
                                      REFRESHDISPLAY;
                                      if (MyPlanetHeader^.PFlags and FLAG_CIV_MASK<>ActPlayerFlag) then begin
                                         if (MyPlanetHeader^.PFlags and FLAG_CIV_MASK<>0) and (FIn>0)
                                          then AUTOVERHANDLUNG(ActPlayerFlag,MyPlanetHeader^.PFlags and FLAG_CIV_MASK,ActSys,0);
                                         if SOut>0 then begin
                                            Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+25;
                                            PFlags:=ActPlayerFlag or FLAG_KNOWN;
                                            Ethno:=ActPlayerFlag;
                                            Population:=Population+10*SOut;
                                            ActPProjects^[26]:=0;
                                            if not OldCiviPlanet then begin
                                               if Class=CLASS_EARTH then begin
                                                  Biosphäre:=200; Infrastruktur:=1; Industrie:=1;
                                               end else if Class in [CLASS_HALFEARTH,CLASS_WATER] then begin
                                                  Biosphäre:=90; Infrastruktur:=1; Industrie:=1;
                                               end else if Class=CLASS_DESERT then begin
                                                  Biosphäre:=50; Infrastruktur:=1; Industrie:=1;
                                               end else begin
                                                  Biosphäre:=30; Infrastruktur:=1; Industrie:=1;
                                               end;
                                            end;
                                            HANDLEKNOWNPLANET(ActSys,0,MyPlanetHeader);
                                         end;
                                         if LTOut>0 then begin
                                            CHECKPLANET(MyPlanetHeader);
                                            CHECKPROJECTS(MyPlanetHeader,ActPlayerFlag);
                                            AUTOVERHANDLUNG(ActPlayerFlag,MyPlanetHeader^.PFlags and FLAG_CIV_MASK,ActSys,0);
                                            REFRESHDISPLAY;
                                            Bool:=TAKETECH(ActPlayerFlag,PFlags and FLAG_CIV_MASK);
                                            if MyPlanetHeader^.XProjectPayed>1000 then begin
                                               s:=intstr(XProjectPayed div 5);
                                               REQUEST(PText[466],s,ActPlayerFlag,12);
                                               Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]+(MyPlanetHeader^.XProjectPayed div 5);
                                               MyPlanetHeader^.XProjectPayed:=round(MyPlanetHeader^.XProjectPayed*0.8);
                                            end;
                                            PFlags:=ActPlayerFlag;
                                            if Population<Size*13 then Ethno:=ActPlayerFlag;
                                            HANDLEKNOWNPLANET(ActSys,0,MyPlanetHeader);
                                         end;
                                      end;
                                   end;
               end;
            end;
         end;
      until b or (RData^ and 1024=0);
      if (RData^ and 1024=0) then PLAYSOUND(1,300);
      RECT(MyScreen[1]^,0,194,119,318,280);
      REFRESHDISPLAY;
   end;
   PLANETHANDLING:=true;
end;



procedure DRAWMOVINGSHIP;

var Step        :byte;
var UseShipPtr  :^r_ShipHeader;



procedure FASTREFRESH(OldX,OldY :short; XCludeShip :ptr);

var x,y,i               :integer;
var OtherShipPtr        :^r_ShipHeader;
var PlanetHeader        :^r_PlanetHeader;

begin
   OtherShipPtr:=^SystemHeader[Display].FirstShip;
   repeat
      if (OtherShipPtr^.PosX in [pred(OldX)..succ(OldX)])
      and (OtherShipPtr^.PosY in [pred(OldY)..succ(OldY)]) then begin
         if ((OtherShipPtr<>XCludeShip) and (OtherShipPtr^.Owner>0)
         and (OtherShipPtr^.Moving>=0))
         or (OtherShipPtr^.SType=TARGET_STARGATE) then with OtherShipPtr^ do begin
            x:=256+(PosX+OffsetX)*32;
            y:=256+(PosY+OffsetY)*32;
            if OtherShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=OtherShipPtr^.TargetShip
            else UseShipPtr:=OtherShipPtr;
            if (x in [0..480]) and (y in [0..480]) then
             BltBitMapRastPort(^ImgBitMap4,(UseShipPtr^.SType-8)*32+1,33,^MyScreen[1]^.RastPort,x+1,y+1,30,30,192);
         end;
      end;
      OtherShipPtr:=OtherShipPtr^.NextShip;
   until OtherShipPtr=NIL;

   for i:=1 to SystemHeader[Display].Planets do begin
      PlanetHeader:=ptr(SystemHeader[Display].PlanetMemA+pred(i)*sizeof(r_PlanetHeader));
      if (round(PlanetHeader^.PosX) in [OldX-1..OldX+1]) and (round(PlanetHeader^.PosY) in [OldY-1..OldY+1])
      then with PlanetHeader^ do begin
         x:=256+round(PosX+OffsetX)*32;
         y:=256+round(PosY+OffsetY)*32;
         if (x in [0..480]) and (y in [0..480])
          then BltBitMapRastPort(^ImgBitMap7,Class*32,0,^MyScreen[1]^.RastPort,x,y,32,32,192);
      end;
   end;
end;



begin
   if Display=0 then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   if (MyShipPtr^.PosX=FromX) and (MyShipPtr^.PosY=FromY) then exit;
   b:=true;
   if Save.FastMove then Step:=4 else Step:=2;
   repeat
      if (x in [0..480]) and (y in [0..480]) then begin
         FASTREFRESH(FromX,FromY,MyShipPtr);
         RECT(MyScreen[1]^,0,x,y,x+31,y+31);
      end;
      if ToX<x then x:=x-Step else if ToX>x then x:=x+Step;
      if ToY<y then y:=y-Step else if ToY>y then y:=y+Step;
      if MyShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=MyShipPtr^.TargetShip
      else UseShipPtr:=MyShipPtr;
      if (x in [0..480]) and (y in [0..480]) then begin
         BltBitMapRastPort(^ImgBitMap4,(UseShipPtr^.SType-8)*32,32,^MyScreen[1]^.RastPort,x,y,31,31,192);
         SetAPen(^MyScreen[1]^.RastPort,UseShipPtr^.Owner);
         DRAWRECT(x,y);
         if MyShipPtr^.Owner<>FLAG_OTHER then begin
            WaitBlit; WaitBlit;
         end;
         WaitBlit; WaitTOF;
      end else b:=false;
   until (x=ToX) and (y=ToY);
   if not ((x in [1..478]) and (y in [1..478])) and (MyShipPtr^.Moving>0) and b then begin
      OffsetX:=-MyShipPtr^.PosX-1; OffsetY:=-MyShipPtr^.PosY-1;
      x:=256+(MyShipPtr^.PosX+OffsetX)*32;
      y:=256+(MyShipPtr^.PosY+OffsetY)*32;
      ToX:=x; ToY:=y;
      DRAWSYSTEM(MODE_REDRAW,Display,NIL);
   end else REFRESHDISPLAY;
end;



function CHECKSUN(ShipPtr: ptr):boolean;

var MyShipPtr   :^r_ShipHeader;

begin
   MyShipPtr:=ShipPtr;
   CHECKSUN:=false;
   with MyShipPtr^ do if (PosX in [-3..2]) and (PosY in [-3..2]) then begin
      if not ((FromX in [-3..2]) and (PosY in [-3..2])) then PosX:=FromX else
      if not ((PosX in [-3..2]) and (FromY in [-3..2])) then PosY:=FromY else begin
         PosX:=FromX;
         PosY:=FromY;
      end;
      if (PosX=FromX) and (PosY=FromY) then begin
         CHECKSUN:=true;
         MyShipPtr^.Moving:=0;
      end;
   end;
end;



procedure LINKTOORBIT(ActSys :byte);

var x,y         :word;

begin
   if (MyShipPtr^.Ladung and MASK_SIEDLER)=0 then LINKSHIP(MyShipPtr,^MyPlanetHeader^.FirstShip,1);
   if not (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0) or (MyShipPtr^.Owner=ActPlayerFlag) then begin
      x:=256+(MyShipPtr^.PosX+OffsetX)*32;
      y:=256+(MyShipPtr^.PosY+OffsetY)*32;
      if (x in [0..480]) and (y in [0..480]) then begin
         RECT(MyScreen[1]^,0,x,y,x+31,y+31);
         REFRESHDISPLAY;
         delay(10);
      end;
   end;
   MyShipPtr^.PosX:=0; MyShipPtr^.PosY:=0;
end;



procedure DOWORMHANDLING(MyShipPtr :ShipHeader);

var i,j,WormID,PosID,NewSys     :byte;

begin
   for i:=1 to MAXHOLES do with MyWormHole[i] do
    for j:=1 to 2 do if (System[j]=ActSys) and (PosX[j]=MyShipPtr^.PosX)
    and (PosY[j]=MyShipPtr^.PosY) then begin
      PosID:=3-j; WormID:=i; NewSys:=System[3-j];
   end;
   MyShipPtr^.Source:=0; MyShipPtr^.Target:=0;
   if Visible then begin
      DRAWMOVINGSHIP;
      if not ((ToX in [0..478]) and (ToY in [0..478])) then begin
         OffsetX:=-MyShipPtr^.PosX-1;
         OffsetY:=-MyShipPtr^.PosY-1;
         ToX:=256+(MyShipPtr^.PosX+OffsetX)*32;
         ToY:=256+(MyShipPtr^.PosY+OffsetY)*32;
         DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
      end;
      PLAYSOUND(3,280);
      for i:=15 downto 0 do begin
         BltBitMapRastPort(^ImgBitMap7,i*32,32,^MyScreen[1]^.RastPort,ToX,ToY,32,32,192);
         WaitTOF;   delay(4);
      end;
   end;
   if SystemHeader[NewSys].Planets=0 then CREATENEWSYSTEM(NewSys,ActPlayer);
   SystemFlags[ActPlayer,NewSys]:=SystemFlags[ActPlayer,NewSys] or FLAG_KNOWN;
   LINKSHIP(MyShipPtr,^SystemHeader[NewSys].FirstShip,1);
   MyShipPtr^.PosX:=MyWormHole[WormID].PosX[PosID];
   MyShipPtr^.PosY:=MyWormHole[WormID].PosY[PosID];
   repeat
      MyShipPtr^.PosX:=MyShipPtr^.PosX-1+random(3);
      MyShipPtr^.PosY:=MyShipPtr^.PosY-1+random(3);
   until not FINDOBJECT(NewSys,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr)
   or (MyShipPtr^.PosX in [-3..3]) or (MyShipPtr^.PosY in [-3..3]);
   if Visible then begin
      for i:=0 to 15 do begin
         BltBitMapRastPort(^ImgBitMap7,i*32,32,^MyScreen[1]^.RastPort,ToX,ToY,32,32,192);
         WaitTOF;   delay(4);
      end;
      RECT(MyScreen[1]^,0,ToX,ToY,ToX+31,ToY+31);
      REFRESHDISPLAY;
   end;
   MyShipPtr^.Moving:=MyShipPtr^.Moving-1;
   AUTOSHIPTRAVEL(NewSys,MODE_SHIPS,MyShipPtr);
   if Visible then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   if MyShipPtr^.Moving=0 then MyShipPtr^.Moving:=1;
end;



function WORMHOLE(ShipPtr :ptr):boolean;

var SysID       :byte;
var Offset      :word;
var MyShipPtr   :^r_ShipHeader;


function WORMFLIGHT:boolean;

const STEPS=1100;

var i,j,k                       :integer;
var l,ShipShield                :long;
var AScr,RectCol                :byte;
var ImgBitMapW4                 :ITBitMap;
var FHandle                     :BPTR;
var WHSoundMemA,WHSoundMemL     :array [1..2] of long;
var Error                       :boolean;


procedure INITSOUNDS;

var l,ISize     :long;
var s           :string;


procedure LOADSOUND(FName :str; SID :byte);

var l           :long;

begin
   FHandle:=OPENSMOOTH(FName,MODE_OLDFILE);
   if FHandle=0 then exit;
   l:=DosSeek(FHandle,0,OFFSET_END);
   l:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   WHSoundMemL[SID]:=l div 2;
   if SID=1 then WHSoundMemL[SID]:=WHSoundMemL[SID]+STEPS*3;
   WHSoundMemA[SID]:=AllocMem(WHSoundMemL[SID]*2,MEMF_CHIP+MEMF_CLEAR);
   if WHSoundMemA[SID]=0 then begin
      DosClose(FHandle);   exit;
   end;
   l:=DosRead(FHandle,ptr(WHSoundMemA[SID]),WHSoundMemL[SID]*2);
   DosClose(FHandle);
end;



begin
   s:=PathStr[7]+'Sensor.RAW';
   LOADSOUND(s,1);                        {SFX/Sensor.RAW}
   s:=PathStr[7]+'FightSoundDS.RAW';
   LOADSOUND(s,2);                        {SFX/FightsoundDS.RAW}
end;



function INITIMAGES:boolean;

type r_Col=record;
        r,g,b   :byte
     end;

var IMem,ISize,AddrX    :long;
var ColorID             :^long;
var Col                 :^r_Col;


begin
   INITIMAGES:=false;
   s:=PathStr[5]+'Wormhole.img';
   if not RAWLOADIMAGE(s,0,0,640,512,4,ImgBitMapW4) then begin end;
   s:=PathStr[5]+'Wormhole.pal';
   l:=SETCOLOR(MyScreen[1]^,s);
   l:=SETCOLOR(MyScreen[2]^,s);
   INITIMAGES:=true;
end;



procedure TRAVEL;

var X,Y,S                               :array [1..5] of integer;
var XOff,YOff                           :integer;
var Joy                                 :^word;
var DirCnt,DVert,DHoriz,JVert,JHoriz    :short;
var Clear                               :integer;


begin
   for i:=1 to 2 do RECT(MyScreen[i]^,7,311,0,319,255);
   SPAddrA^:=WHSoundMemA[1]; SPLengthA^:=WHSoundMemL[1]; SPVolA^:=45; SPFreqA^:=300;
   SPAddrC^:=WHSoundMemA[2]; SPLengthC^:=WHSoundMemL[2] div 2; SPVolC^:=64; SPFreqC^:=400;
   SPAddrD^:=WHSoundMemA[2]+WHSoundMemL[2];
                             SPLengthD^:=WHSoundMemL[2] div 2; SPVolD^:=64; SPFreqD^:=400;

   SPAddrB^:=0; SPLengthB^:=1;
   DMACON_WRITE^:=$800F;
   randomize;
   X[1]:=155; Y[1]:=128; S[1]:=10; XOff:=0; YOff:=0; Clear:=0;
   for j:=1 to 4 do begin
      X[succ(j)]:=X[j];
      Y[succ(j)]:=Y[j];
      S[succ(j)]:=round(S[j]*1.6);
   end;
   AScr:=1; DirCnt:=1; DVert:=0; DHoriz:=0;
   Joy:=ptr($DFF00C);
   for i:=1 to STEPS do begin
      if i<(STEPS-55) then begin
         if DirCnt>8 then DirCnt:=0
         else if DirCnt=0 then begin
            DHoriz:=pred(random(3))*3;
            if DHoriz=0 then DVert:=pred(random(3))*3;
            DirCnt:=1;
         end else DirCnt:=DirCnt+1;
      end else begin
         DHoriz:=0; DVert:=0;
      end;

      JVert:=0; JHoriz:=0;
      if (Joy^ and $3 in [$3,$2]) then JHoriz:=-8 else if (Joy^ and $300 in [$300,$200]) then JHoriz:=8;
      if (Joy^ and $3 in [$1,$2]) then JVert:=8   else if (Joy^ and $300 in [$100,$200]) then JVert:=-8;
      if JHoriz<>0 then begin
         for j:=1 to 5 do X[j]:=X[j]+JHoriz;
         XOff:=XOff+JHoriz;
      end;
      if JVert<>0 then begin
         for j:=1 to 5 do Y[j]:=Y[j]+JVert;
         YOff:=YOff+JVert;
      end;

      XOff:=XOff+DHoriz;
      YOff:=YOff+DVert;
      if XOff>145 then XOff:=145;
      if XOff<-145 then XOff:=-145;
      if YOff>122 then YOff:=122;
      if YOff<-122 then YOff:=-122;

      for j:=1 to 5 do begin
         if X[j]<154 then X[j]:=round(155-(155-X[j])*0.98)
         else if X[j]>156 then X[j]:=round((X[j]-155)+0.98+155);

         if Y[j]<127 then Y[j]:=round(128-(128-Y[j])*0.98)
         else if Y[j]>129 then Y[j]:=round((Y[j]-128)+0.98+128);

         S[j]:=round(S[j]*1.06);
      end;

      if (S[5]>240) then begin
         for j:=4 downto 1 do begin
            X[succ(j)]:=X[j];
            Y[succ(j)]:=Y[j];
            S[succ(j)]:=S[j];
         end;
         X[1]:=155+XOff; Y[1]:=128+YOff; S[1]:=10;
      end;

      BltBitMapRastPort(^ImgBitMapW4,170-XOff,128-YOff,^MyScreen[AScr]^.RastPort,0,0,310,256,192);
      SetAPen(^MyScreen[Ascr]^.RastPort,6);
      for j:=1 to 5 do begin
         if (X[j]-S[j] in [1..309]) and (Y[j]-S[j] in [1..255])
         and (X[j]+S[j] in [1..309]) and (Y[j]+S[j] in [1..255]) then
          BOX(MyScreen[AScr]^,X[j]-S[j],Y[j]-S[j],X[j]+S[j],Y[j]+S[j]);
      end;
      if not (X[5] in [120..200]) or not (Y[5] in [90..165]) then begin
         if (X[5] in [105..215]) and (Y[5] in [75..180]) then begin
             SPFreqB^:=120;
             ShipShield:=ShipShield-2;
         end else begin
             SPFreqB^:=80;
             ShipShield:=ShipShield-4;
         end;
         SPAddrB^:=WHSoundMemA[1]; SPLengthB^:=1500; SPVolB^:=52;
         RectCol:=15;
         if ShipShield in [13..762] then RECT(MyScreen[AScr]^,0,312,1,318,round(258-ShipShield/3));
         if ShipShield<0 then begin
            DMACON_WRITE^:=$000F;
            for j:=1 to random(5)+5 do begin
               PLAYSOUND(2,1100);
               SetRGB4(^MyScreen[3-Ascr]^.ViewPort,0,8,8,15);
               delay(3);
               SetRGB4(^MyScreen[3-Ascr]^.ViewPort,0,0,0,3);
               delay(3);
            end;
            exit;
         end;
      end else RectCol:=9;

      SetAPen(^MyScreen[Ascr]^.RastPort,5);
      Move(^MyScreen[Ascr]^.RastPort,XOff+150,YOff+128);
      for j:=1 to 5 do if (X[j]-S[j] in [1..309]) and (Y[j]-S[j] in [1..255]) then
      Draw(^MyScreen[Ascr]^.RastPort,X[j]-S[j],Y[j]-S[j]);

      Move(^MyScreen[Ascr]^.RastPort,XOff+150,YOff+128);
      for j:=1 to 5 do if (X[j]+S[j] in [1..309]) and (Y[j]-S[j] in [1..255]) then
      Draw(^MyScreen[Ascr]^.RastPort,X[j]+S[j],Y[j]-S[j]);

      Move(^MyScreen[Ascr]^.RastPort,XOff+150,YOff+128);
      for j:=1 to 5 do if (X[j]+S[j] in [1..309]) and (Y[j]+S[j] in [1..255]) then
      Draw(^MyScreen[Ascr]^.RastPort,X[j]+S[j],Y[j]+S[j]);

      Move(^MyScreen[Ascr]^.RastPort,XOff+150,YOff+128);
      for j:=1 to 5 do if (X[j]-S[j] in [1..309]) and (Y[j]+S[j] in [1..255]) then
      Draw(^MyScreen[Ascr]^.RastPort,X[j]-S[j],Y[j]+S[j]);

      SetAPen(^MyScreen[Ascr]^.RastPort,RectCol);
      BOX(MyScreen[Ascr]^,60,35,250,220);

      SPAddrB^:=ZeroSound; SPLengthB^:=1;
      if i>(STEPS-30) then begin
         SPAddrA^:=ZeroSound; SPLengthA^:=1;
         Clear:=Clear+4;
         RECT(MyScreen[AScr]^,0,160-Clear,128-Clear,160+Clear,128+Clear);
      end else SPLengthA^:=WHSoundMemL[1]-i-i-i;
      ScreenToFront(MyScreen[Ascr]);
      AScr:=3-AScr;
   end;
end;



function SMALLWORMFLIGHT:boolean;

begin
   ShipShield:=round(ShipShield*(random(45)+15)/100);
   if ShipShield<=0 then SMALLWORMFLIGHT:=false else begin
      with MyShipPtr^ do Shield:=round(ShipShield / 760 * ShipData[SType].MaxShield);
      SMALLWORMFLIGHT:=true;
   end;
end;



procedure WORMEXIT;

begin
   DoClock:=false;
   CLOSEMYSCREENS;
   for i:=1 to 2 do if WHSoundMemA[i]<>0 then begin
      FreeMem(WHSoundMemA[i],WHSoundMemL[i]*2);
      WHSoundMemA[i]:=0;
   end;
   if ImgBitMapW4.MemA<>0 then FreeMem(ImgBitMapW4.MemA,ImgBitMapW4.MemL);
   ImgBitMapW4.MemA:=0;
   DMACON_WRITE^:=$000F;
   b:=OPENMAINSCREENS;
   b:=INITDESK(0);
   if Error then WORMFLIGHT:=SMALLWORMFLIGHT;
   Screen2:=0;   Display:=0;
   DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
end;



begin
   Error:=true;
   MyShipPtr:=ShipPtr;
   with MyShipPtr^ do ShipShield:=round(Shield / ShipData[SType].MaxShield * 760);
   if Save.NoWorm then begin
      WORMFLIGHT:=SMALLWORMFLIGHT;
      exit;
   end;
   for i:=1 to 2 do WHSoundMemA[i]:=0;
   CLOSEMYSCREENS;
   ImgBitMapW4:=ITBitMap(0,0,0,0,0,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,0,0);
   with ImgBitMapW4 do begin
      MemL:=163840;  {640 x 512 x 4}
      MemA:=AllocMem(MemL,MEMF_CHIP+MEMF_CLEAR);
      if MemA=0 then exit;
      ImgBitMapW4:=ITBitMap(80,512,1,4,0,ptr(MemA),       ptr(MemA+40960),ptr(MemA+81920),
                                         ptr(MemA+122880),NIL,NIL,NIL,NIL,MemA,MemL);
   end;
   Tags:=TagArr(SA_DisplayID,   ($1000+HelpID),
                SA_Interleaved, _TRUE,
                SA_Draggable,   _FALSE,
                SA_COLORS,      addr(ColSpec),
                TAG_DONE,       0,0,0,0,0);
   NeuScreen:=NewScreen(0,0,320,256,4,0,0,GENLOCK_VIDEO,CUSTOMSCREEN+SCREENQUIET,
                        NIL,'',NIL,NIL);
   for i:=1 to 2 do MyScreen[i]:=OpenScreenTagList(^NeuScreen,^Tags);
   if MyScreen[1]=NIL then begin
      WORMEXIT;
      exit;
   end;
   if MyScreen[2]=NIL then begin
      WORMEXIT;
      exit;
   end;
   if not INITIMAGES then begin
      WORMEXIT; exit;
   end;
   INITSOUNDS;
   TRAVEL;
   if ShipShield<=0 then WORMFLIGHT:=false else begin
      with MyShipPtr^ do Shield:=round(ShipShield / 760 * ShipData[SType].MaxShield);
      WORMFLIGHT:=true;
   end;
   Error:=false;
   WORMEXIT;
end;



begin
   MyShipPtr:=ShipPtr;
   if not ((ToX in [0..478]) and (ToY in [0..478])) then begin
      OffsetX:=-MyShipPtr^.PosX-1;
      OffsetY:=-MyShipPtr^.PosY-1;
      ToX:=256+(MyShipPtr^.PosX+OffsetX)*32;
      ToY:=256+(MyShipPtr^.PosY+OffsetY)*32;
      DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   end;
   PLAYSOUND(3,250);
   delay(7);
   for i:=15 downto 0 do begin
      BltBitMapRastPort(^ImgBitMap7,i*32,32,^MyScreen[1]^.RastPort,ToX,ToY,32,32,192);
      WaitTOF;   delay(4);
   end;
   if ToY>210 then Offset:=110 else Offset:=260;
   SysID:=succ(random(Save.SYSTEMS));
   MAKEBORDER(MyScreen[1]^,70,Offset,440,Offset+85,12,6,0);
   WRITE(256,Offset+13,ActPlayerFlag,16,MyScreen[1]^,4,PText[467]);
   WRITE(256,Offset+35,ActPlayerFlag,16,MyScreen[1]^,4,PText[468]);
   s:=PText[469]+' '+Save.SystemName[SysID];
   WRITE(256,Offset+57,ActPlayerFlag,16,MyScreen[1]^,4,s);
   if SystemHeader[SysID].Planets=0 then CREATENEWSYSTEM(SysID,ActPlayer);
   SystemFlags[ActPlayer,SysID]:=SystemFlags[ActPlayer,SysID] or FLAG_KNOWN;
   LINKSHIP(MyShipPtr,^SystemHeader[SysID].FirstShip,1);
   repeat
      MyShipPtr^.PosX:=random(80)-40;
      MyShipPtr^.PosY:=random(80)-40;
   until not FINDOBJECT(SysID,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr)
   or (MyShipPtr^.PosX in [-3..3]) or (MyShipPtr^.PosY in [-3..3]);

   WAITLOOP(false);
   RECT(MyScreen[1]^,0,70,Offset,440,Offset+85);
   REFRESHDISPLAY;

   PLAYSOUND(3,250);
   delay(7);
   for i:=0 to 15 do begin
      BltBitMapRastPort(^ImgBitMap7,i*32,32,^MyScreen[1]^.RastPort,ToX,ToY,32,32,192);
      WaitTOF;   delay(4);
   end;
   RECT(MyScreen[1]^,0,ToX,ToY,ToX+31,ToY+31);
   delay(20);
   if WORMFLIGHT then begin
      WORMHOLE:=true;
      AUTOSHIPTRAVEL(SysID,MODE_SHIPS,MyShipPtr);
      if not (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0)
      or (MyShipPtr^.Owner=ActPlayerFlag) then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
      if MyShipPtr^.Moving=0 then MyShipPtr^.Moving:=1;
   end else WORMHOLE:=false;
end;



procedure FADESTARGATE(SysID,ActSys :byte; MyShipPtr :ShipHeader);

var UseShipPtr        :^r_ShipHeader;
var i                 :integer;
var Color,Cx,Cy       :byte;

begin
   if MyShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=MyShipPtr^.TargetShip
   else UseShipPtr:=MyShipPtr;

   if ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN) and (Save.CivPlayer[ActPlayer]<>0))
   or (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0) then begin
      if not (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0) then DRAWMOVINGSHIP;
      PLAYSOUND(3,250);
      if (ToX in [0..478]) and (ToY in [0..478]) then for i:=1 to 1800 do begin
         Cx:=succ(random(29));
         Cy:=succ(random(29));
         BltBitMapRastPort(^ImgBitMap4,576+Cx,32+Cy,^MyScreen[1]^.RastPort,ToX+Cx,ToY+Cy,1,1,192);
         Color:=ReadPixel(^MyScreen[1]^.RastPort,ToX+Cx,ToY+Cy);
         SetAPen(^MyScreen[1]^.RastPort,Color);
         RectFill(^MyScreen[1]^.RastPort,ToX+Cx,ToY+Cy,succ(ToX+Cx),succ(ToY+Cy));
      end;
   end;
   LINKSHIP(MyShipPtr,^SystemHeader[SysID].FirstShip,1);
   delay(5);
   REFRESHDISPLAY;
   delay(5);
   MyShipPtr^.PosX:=SystemHeader[SysID].FirstShip.PosX;
   MyShipPtr^.PosY:=SystemHeader[SysID].FirstShip.PosY;
   OffsetX:=-MyShipPtr^.PosX-1;
   OffsetY:=-MyShipPtr^.PosY-1;
   x:=256+(MyShipPtr^.PosX+OffsetX)*32;
   y:=256+(MyShipPtr^.PosY+OffsetY)*32;
   if ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN) and (Save.CivPlayer[ActPlayer]<>0))
   or (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0) then begin
      if (x in [0..478]) and (y in [0..478]) then begin
         MyShipPtr^.Moving:=-MyShipPtr^.Moving;
         if MyShipPtr^.Moving=0 then MyShipPtr^.Moving:=-1;
         DRAWSYSTEM(MODE_REDRAW,SysID,NIL);
         delay(5);
         if (x in [0..478]) and (y in [0..478]) then for i:=1 to 1800 do begin
            Cx:=succ(random(29));
            Cy:=succ(random(29));
            BltBitMapRastPort(^ImgBitMap4,(UseShipPtr^.Stype-8)*32+Cx,32+Cy,^MyScreen[1]^.RastPort,x+Cx,y+Cy,2,1,192);
            Color:=ReadPixel(^MyScreen[1]^.RastPort,x+Cx,y+Cy);
            SetAPen(^MyScreen[1]^.RastPort,Color);
            RectFill(^MyScreen[1]^.RastPort,x+Cx,y+Cy,succ(x+Cx),succ(y+Cy));
         end;
         delay(5);
         MyShipPtr^.Moving:=-MyShipPtr^.Moving;
         DRAWSYSTEM(MODE_REFRESH,SysID,NIL);
         delay(5);
      end;
   end;
   FromX:=MyShipPtr^.PosX;
   FromY:=MyShipPtr^.PosY;
   repeat
      with MyShipPtr^ do case random(4) of
         0: PosX:=PosX+1;
         1: PosY:=PosY+1;
         2: PosX:=PosX-1;
         3: PosY:=PosY-1;
      end;
   until not FINDOBJECT(SysID,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr);
   ToX:=256+(MyShipPtr^.PosX+OffsetX)*32;
   ToY:=256+(MyShipPtr^.PosY+OffsetY)*32;
   if ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN)
    and (Save.CivPlayer[ActPlayer]<>0))
    or (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0) then DRAWMOVINGSHIP;
   if MyShipPtr^.Flags=SHIPFLAG_WATER then  SysID:=FINDNEXTPLANET(SysID,MyShipPtr);
   MyShipPtr^.Moving:=MyShipPtr^.Moving-1;
   if MyShipPtr^.Owner=FLAG_OTHER then MyShipPtr^.Moving:=0;
   AUTOSHIPTRAVEL(SysID,MODE_SHIPS,MyShipPtr);
   if MyShipPtr^.Owner=0 then exit;
   if ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN)
    and (Save.CivPlayer[ActPlayer]<>0))
    or (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0) then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
end;



function AUTOWATERTRANSPORT(MyPlanetHeader :PlanetHeader):boolean;

begin
   AUTOWATERTRANSPORT:=true;
   if MyShipPtr^.Fracht=0 then with MyPlanetHeader^ do begin
      if (Water div Size>56) and not (Class in [CLASS_STONES,CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM])
      then begin
         while (MyShipPtr^.Fracht<ShipData[MyShipPtr^.SType].MaxLoad)
         and ((Water-5) div Size>56) do begin
            MyShipPtr^.Fracht:=MyShipPtr^.Fracht+1;
            Water:=Water-5;
         end;
         l:=FINDNEXTPLANET(ActSys,MyShipPtr);
         if MyShipPtr^.Moving>0 then MyShipPtr^.Moving:=0;
         exit;
      end;
   end else with MyPlanetHeader^ do begin
      if (Water div Size<55) and not (Class in [CLASS_STONES,CLASS_GAS,CLASS_SATURN,CLASS_PHANTOM])
      then begin
         while (MyShipPtr^.Fracht>0) and (Water div Size<55) do begin
            MyShipPtr^.Fracht:=MyShipPtr^.Fracht-1;
            Water:=Water+5;
         end;
         l:=FINDNEXTPLANET(ActSys,MyShipPtr);
         if MyShipPtr^.Moving>0 then MyShipPtr^.Moving:=0;
         exit;
      end;
   end;
   AUTOWATERTRANSPORT:=false;
end;



procedure SUPPORTCIVI(XValue :long);

var CivVar      :byte;

begin
   if Save.WorldFlag=WFLAG_JAHADR then Save.Staatstopf[8]:=Save.Staatstopf[8]+XValue
   else if MultiPlayer then begin
      CivVar:=random(MAXCIVS-2)+1;
      if (Save.CivPlayer[CivVar]=0) and (Save.WarState[CivVar,CivVar]<>LEVEL_DIED)
       then Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]+XValue;
   end;
end;



begin; {MOVESHIP}
   CLOCK;
   OldMoving:=0; l:=0;
   MyShipPtr:=ShipPtr;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   if (CivVar=0) or (MyShipPtr^.Moving<=0) then exit;
   x:=256+(MyShipPtr^.PosX+OffsetX)*32;
   y:=256+(MyShipPtr^.PosY+OffsetY)*32;
   if (not ((x in [1..478]) and (y in [1..478])) and (Display=ActSys))
   and ((SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN)
   or Visible) then begin
      OffsetX:=-MyShipPtr^.PosX-1;
      OffsetY:=-MyShipPtr^.PosY-1;
      x:=256+(MyShipPtr^.PosX+OffsetX)*32;
      y:=256+(MyShipPtr^.PosY+OffsetY)*32;
      if ((MyShipPtr^.Owner=ActPlayerFlag) and (Save.CivPlayer[ActPlayer]<>0))
      or Visible then DRAWSYSTEM(MODE_REDRAW,ActSys,MyShipPtr);
   end;
   if MyShipPtr^.Owner=ActPlayerFlag then RECT(MyScreen[1]^,0,520,291,632,308);
   if (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]=0)
   or (MyShipPtr^.Flags=SHIPFLAG_WATER) or Save.PlayMySelf then begin
      if (MyShipPtr^.Moving=1) and (Year mod 2=0) then MyShipPtr^.Moving:=MyShipPtr^.Moving+1;
      delay(2);
      repeat
         FromX:=MyShipPtr^.PosX;
         FromY:=MyShipPtr^.PosY;
         if (MyShipPtr^.SType=21) and (SystemHeader[ActSys].FirstShip.SType<>TARGET_STARGATE) then
         with MyShipPtr^ do begin
         {*** STARGATE INSTALLIEREN ***}
            if SQRT((PosX*PosX)+(PosY*PosY))<10 then begin
               if not FINDOBJECT(ActSys,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr) then begin
                  SystemHeader[ActSys].FirstShip.SType:=TARGET_STARGATE;
                  SystemHeader[ActSys].FirstShip.PosX:=MyShipPtr^.PosX;
                  SystemHeader[ActSys].FirstShip.PosY:=MyShipPtr^.PosY;
                  Owner:=0;
                  if (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=FLAG_KNOWN) then REFRESHDISPLAY;
                  delay(20);
               end else Moving:=0;
               exit;
            end;
            if 0<PosX then PosX:=PosX-1 else if 0>PosX then PosX:=PosX+1;
            if 0<PosY then PosY:=PosY-1 else if 0>PosY then PosY:=PosY+1;
         end else if MyShipPtr^.Target=TARGET_ENEMY_SHIP then begin
         {*** FEINDLICHES SCHIFF ABFANGEN ***}
            if MyShipPtr^.TargetShip^.PosX<MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX-1 else
             if MyShipPtr^.TargetShip^.PosX>MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX+1;
            if MyShipPtr^.TargetShip^.PosY<MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY-1 else
             if MyShipPtr^.TargetShip^.PosY>MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY+1;
         end else with MyShipPtr^ do if (Source<0)and (Target<0) then begin
         {*** STABILES WURMLOCH BENUTZEN ***}
            if MyWormHole[-Target].PosX[-Source]<MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX-1 else
             if MyWormHole[-Target].PosX[-Source]>MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX+1;
            if MyWormHole[-Target].PosY[-Source]<MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY-1 else
             if MyWormHole[-Target].PosY[-Source]>MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY+1;
         end else begin
         {*** PLANETEN ANFLIEGEN ***}
            while MyShipPtr^.Target>SystemHeader[ActSys].Planets do begin
               { Unkorrektes Ziel für Bewässerung }
               SysID:=FINDNEXTPLANET(ActSys,MyShipPtr);
               if ActSys<>SysID then AUTOSHIPTRAVEL(SysID,MODE_SHIPS,MyShipPtr);
            end;
            MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+pred(MyShipPtr^.Target)*sizeof(r_PlanetHeader));
            if round(MyPlanetHeader^.PosX)<MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX-1 else
             if round(MyPlanetHeader^.PosX)>MyShipPtr^.PosX then MyShipPtr^.PosX:=MyShipPtr^.PosX+1;
            if round(MyPlanetHeader^.PosY)<MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY-1 else
             if round(MyPlanetHeader^.PosY)>MyShipPtr^.PosY then MyShipPtr^.PosY:=MyShipPtr^.PosY+1;
         end;
         if CHECKSUN(MyShipPtr) then exit;
         ToX:=256+(MyShipPtr^.PosX+OffsetX)*32;
         ToY:=256+(MyShipPtr^.PosY+OffsetY)*32;
         if (abs(MyShipPtr^.PosX)>50) or (abs(MyShipPtr^.PosY)>50)
         or not (MyShipPtr^.Target in [1..SystemHeader[ActSys].Planets,TARGET_POSITION,TARGET_STARGATE,TARGET_ENEMY_SHIP]) then begin
            {Bugfix Mad Ship}
            MyShipPtr^.Owner:=0;
            exit;
         end;
         if FINDOBJECT(ActSys,ToX+16,ToY+16,MyShipPtr) then begin
            if MyShipPtr^.Flags=SHIPFLAG_WATER then with MyShipPtr^ do begin
               if not (ObjType in [TYPE_STARGATE,TYPE_WORMHOLE]) then begin
                  PosX:=FromX;
                  PosY:=FromY;
                  {if ObjType<>TYPE_PLANET then ObjType:=0;}
               end;
            end;
            case ObjType of
               TYPE_PLANET: if MyShipPtr^.Flags=SHIPFLAG_WATER then begin
                               SystemFlags[ActPlayer,ActSys]:=SystemFlags[ActPlayer,ActSys] or FLAG_KNOWN;
                               if AUTOWATERTRANSPORT(ObjPtr) then exit;
                               MyShipPtr^.Moving:=0;
                            end else begin
                               if long(ObjPtr)=SystemHeader[ActSys].PlanetMemA+pred(MyShipPtr^.Target)*sizeof(r_PlanetHeader) then begin
                                  MyShipPtr^.PosX:=FromX;
                                  MyShipPtr^.PosY:=FromY;
                                  MyPlanetHeader:=ptr(ObjPtr);
                                  OtherShipPtr:=MyPlanetHeader^.FirstShip.NextShip;
                                  while (OtherShipPtr<>NIL) and (OtherShipPtr^.Owner=0) do OtherShipPtr:=OtherShipPtr^.NextShip;
                                  if (OtherShipPtr<>NIL) and (Save.WarState[CivVar,GETCIVVAR(MyPlanetHeader^.PFlags)] in [LEVEL_WAR,LEVEL_COLDWAR]) then begin
                                     {*** Feindliches Schiff im Orbit ***}
                                     if (Save.CivPlayer[ActPlayer]=0)
                                      and (Save.CivPlayer[GETCIVVAR(MyPlanetHeader^.PFlags)]<>0) then exit;
                                     if Save.WarState[CivVar,GETCIVVAR(MyPlanetHeader^.PFlags)]=LEVEL_COLDWAR then GOTOWAR(MyShipPtr^.Owner,MyPlanetHeader^.PFlags);
                                     MyShipPtr^.Moving:=0;
                                     if OtherShipPtr^.Owner<>MyShipPtr^.Owner then begin
                                        delay(20);
                                        if BIGSHIPFIGHT(MyShipPtr,OtherShipPtr,MODE_ALL,ActSys)=1 then exit;
                                        REFRESHDISPLAY;
                                        delay(10);
                                        AUTOVERHANDLUNG(MyShipPtr^.Owner,MyPlanetHeader^.PFlags,ActSys,0);
                                        exit;
                                     end;
                                     LINKTOORBIT(ActSys);
                                     exit
                                  end else if ((MyPlanetHeader^.PFlags and FLAG_CIV_MASK)=0) then begin
                                     if (MyShipPtr^.Ladung and MASK_SIEDLER>0) and (MyPlanetHeader^.Class in [CLASS_DESERT,CLASS_HALFEARTH,
                                     CLASS_EARTH,CLASS_ICE,CLASS_STONES,CLASS_WATER]) then with MyPlanetHeader^ do begin
                                        {*** Planet unbewohnt ***}
                                        if ProjectPtr<>NIL then begin
                                           ActPProjects:=MyPlanetHeader^.ProjectPtr;
                                           if (ActPProjects^[34]>0) or (ActPProjects^[40]>0) then begin
                                              SMALLANDING(MyPlanetHeader,MyShipPtr,ActSys);
                                              exit;
                                           end;
                                        end;
                                        Save.ImperatorState[CivVar]:=Save.ImperatorState[CivVar]+25;
                                        if ProjectPtr=NIL then begin
                                           l:=AllocMem(sizeof(ByteArr42),MEMF_CLEAR);
                                           if l=0 then exit else ProjectPtr:=ptr(l);
                                        end else l:=13;
                                        ActPPRojects:=ProjectPtr;
                                        ActPProjects^[0]:=1;
                                        if SystemFlags[1,ActSys] and FLAG_CIV_MASK=0 then SystemFlags[1,ActSys]:=MyShipPtr^.Owner;
                                        PFlags:=MyShipPtr^.Owner;
                                        Ethno:=MyShipPtr^.Owner;
                                        MyShipPtr^.Ladung:=MyShipPtr^.Ladung-16;
                                        Population:=Population+10;
                                        if l<>13 then begin
                                           if Class=CLASS_EARTH then begin
                                              Biosphäre:=200; Infrastruktur:=1; Industrie:=1;
                                           end else if Class in [CLASS_HALFEARTH,CLASS_WATER] then begin
                                              Biosphäre:=90; Infrastruktur:=1; Industrie:=1;
                                           end else if Class=CLASS_DESERT then begin
                                              Biosphäre:=50; Infrastruktur:=1; Industrie:=1;
                                           end else begin
                                              Biosphäre:=30; Infrastruktur:=1; Industrie:=1;
                                           end;
                                        end;
                                        if (MyShipPtr^.Ladung and MASK_SIEDLER)>0 then begin
                                           SysID:=FINDNEXTPLANET(ActSys,MyShipPtr);
                                           if ActSys<>SysID then AUTOSHIPTRAVEL(SysID,MODE_SHIPS,MyShipPtr);
                                        end;
                                     end;
                                     if not (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0) then begin
                                        REFRESHDISPLAY;
                                        delay(10);
                                     end;
                                     MyShipPtr^.Moving:=0;
                                     exit;
                                  end else if (MyPlanetHeader^.PFlags and FLAG_CIV_MASK=MyShipPtr^.Owner)
                                  and (MyShipPtr^.Ladung and MASK_SIEDLER=0) then begin
                                     if AUTOWATERTRANSPORT(MyPlanetHeader) then exit;
                                     {*** Eigener Planet, Schiff ohne Siedler, kein Wassertransport ***}
                                     LINKTOORBIT(ActSys);
                                     exit;
                                  end else if Save.WarState[CivVar,GETCIVVAR(MyPlanetHeader^.PFlags)] in [LEVEL_WAR,LEVEL_COLDWAR] then begin
                                     {*** Feindlicher Planet ***}
                                     if (Save.CivPlayer[ActPlayer]=0)
                                      and (Save.CivPlayer[GETCIVVAR(MyPlanetHeader^.PFlags)]<>0) then exit;
                                     if Save.WarState[CivVar,GETCIVVAR(MyPlanetHeader^.PFlags)]=LEVEL_COLDWAR then GOTOWAR(MyShipPtr^.Owner,MyPlanetHeader^.PFlags);
                                     ActPProjects:=MyPlanetHeader^.ProjectPtr;
                                     if (ActPProjects^[34]>0) or (ActPProjects^[40]>0) then begin
                                        if (Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]<>0)
                                         or (Save.CivPlayer[GETCIVVAR(MyPlanetHeader^.PFlags)]<>0)
                                         then DRAWSCENE(ActSys);
                                        SMALLANDING(MyPlanetHeader,MyShipPtr,ActSys);
                                        exit;
                                     end;
                                     if (Save.WorldFlag=WFLAG_CEBORC) and (CivVar=8) then begin
                                        with MyPlanetHeader^ do begin
                                           PFlags:=0;
                                           Ethno:=0;         Population:=0;
                                           Biosphäre:=random(150);
                                           Industrie:=random(150); Infrastruktur:=random(150);
                                           XProjectCosts:=0; XProjectPayed:=0;
                                           ProjectID:=0;
                                        end;
                                        for j:=1 to 42 do ActPProjects^[j]:=0;
                                        if Visible then begin
                                           PLAYSOUND(2,1300);
                                           REFRESHDISPLAY;
                                           delay(20);
                                        end;
                                        exit;
                                     end else if CivVar=9 then begin
                                        with MyPlanetHeader^ do begin
                                           Population:=round(Population*0.99);
                                           Biosphäre:=round(Biosphäre*0.97);
                                           Industrie:=round(Industrie*0.95);
                                           Infrastruktur:=round(Infrastruktur*0.93);
                                           s:=PText[470]+' '+PName;
                                           s2:=PText[471]+' '+intstr(XProjectPayed div 5)+'!';
                                           if Visible then REQUEST(s,s2,12,12);
                                           SUPPORTCIVI(XProjectPayed div 5);
                                           XProjectPayed:=round(XProjectPayed*0.8);
                                           l:=GOTONEXTSYSTEM(ActSys,MyShipPtr);
                                        end;
                                     end else if (MyShipPtr^.Ladung and MASK_LTRUPPS)>0 then with MyPlanetHeader^ do begin
                                        CHECKPLANET(MyPlanetHeader);
                                        Bool:=TAKETECH(MyShipPtr^.Owner,MyPlanetHeader^.PFlags and FLAG_CIV_MASK);
                                        Save.Staatstopf[GETCIVVAR(MyShipPtr^.Owner)]:=
                                         Save.Staatstopf[GETCIVVAR(MyShipPtr^.Owner)]+(MyPlanetHeader^.XProjectPayed div 5);
                                        MyPlanetHeader^.XProjectPayed:=round(MyPlanetHeader^.XProjectPayed*0.8);
                                        AUTOVERHANDLUNG(MyShipPtr^.Owner,PFlags,ActSys,0);
                                        CHECKPROJECTS(MyPlanetHeader,MyShipPtr^.Owner);
                                        PFlags:=MyShipPtr^.Owner;
                                        if (Population<Size*13) or (random(5)=0) then Ethno:=MyShipPtr^.Owner;
                                        ProjectID:=0;
                                        MyShipPtr^.Moving:=0;
                                        if not SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0 then begin
                                           REFRESHDISPLAY;
                                           delay(10);
                                        end;
                                        exit;
                                     end else FINDENEMYOBJECT(ActSys,MyShipPtr);
                                  end else begin
                                     MyShipPtr^.PosX:=FromX;
                                     MyShipPtr^.PosY:=FromY;
                                     MyShipPtr^.Moving:=0;
                                     if (Save.WarState[CivVar,1] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,2] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,3] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,4] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,5] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,6] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,7] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                                        (Save.WarState[CivVar,8] in [LEVEL_WAR,LEVEL_COLDWAR])
                                     then FINDENEMYOBJECT(i,MyShipPtr)
                                     else l:=GOTONEXTSYSTEM(ActSys,MyShipPtr);
                                     exit;
                                  end;
                               end;
                            end;
               TYPE_SHIP:   begin
                               OtherShipPtr:=ObjPtr;
                               if (OtherShipPtr^.Owner<>MyShipPtr^.Owner)
                               and (Save.WarState[CivVar,GETCIVVAR(OtherShipPtr^.Owner)] in [LEVEL_WAR,LEVEL_COLDWAR]) then begin
                                  if (Save.CivPlayer[ActPlayer]=0)
                                   and (Save.CivPlayer[GETCIVVAR(OtherShipPtr^.Owner)]<>0) then begin
                                     MyShipPtr^.PosX:=FromX;
                                     MyShipPtr^.PosY:=FromY;
                                     exit;
                                  end;
                                  if Save.WarState[CivVar,GETCIVVAR(OtherShipPtr^.Owner)]=LEVEL_COLDWAR then GOTOWAR(MyShipPtr^.Owner,OtherShipPtr^.Owner);
                                  MyShipPtr^.PosX:=FromX;
                                  MyShipPtr^.PosY:=FromY;
                                  delay(20);
                                  if BIGSHIPFIGHT(MyShipPtr,OtherShipPtr,MODE_ONCE,ActSys)=1 then begin
                                     MyShipPtr^.Moving:=0;
                                     exit;
                                  end;
                               end else begin
                                  MyShipPtr^.PosX:=FromX;
                                  MyShipPtr^.PosY:=FromY;
                                  exit;
                               end;
                            end;
               TYPE_STARGATE: if MyShipPtr^.Target=TARGET_ENEMY_SHIP then
                               if MyShipPtr^.TargetShip=^SystemHeader[ActSys].FirstShip then begin
                                 SysID:=MyShipPtr^.Source;
                                 FADESTARGATE(SysID,ActSys,MyShipPtr);
                                 if MyShipPtr^.Moving<=0 then
                                  SystemFlags[ActPlayer,ActSys]:=SystemFlags[ActPlayer,ActSys] or FLAG_KNOWN;
                                 exit;
                              end;
               TYPE_WORMHOLE: DOWORMHANDLING(MyShipPtr);
               otherwise;
            end;
         end;
         for i:=1 to MAXHOLES do with MyWormHole[i] do for j:=1 to 2 do if System[j]=ActSys then begin
            if (MyShipPtr^.PosX in [PosX[j]-10..PosX[j]+10]) and
            (MyShipPtr^.PosY in [PosY[j]-10..PosY[j]+10]) then begin
               if GETCIVVAR(MyShipPtr^.Owner)>0 then CivKnowledge[GETCIVVAR(MyShipPtr^.Owner)]:=FLAG_KNOWN;
            end;
         end;
         MyShipPtr^.Moving:=MyShipPtr^.Moving-1;
         if Visible then begin
            DRAWMOVINGSHIP;
            if (MyShipPtr^.Moving>=0) and (OldMoving<>MyShipPtr^.Moving) then with MyShipPtr^ do begin
               s:=intstr(round((Shield+Tactical*3)/ShipData[SType].MaxShield*100))+'%';
                                        while length(s)<4 do s:='0'+s;
               s:=intstr(Moving)+'-'+s; while length(s)<7 do s:='0'+s;
               WRITE(521,293,GETCIVFLAG(ActPlayer),1,MyScreen[1]^,2,s);
               OldMoving:=Moving;
            end;
         end;
      until MyShipPtr^.Moving<=0;
      exit;
   end;
   repeat
      CLOCK;
      delay(1);
      FromX:=MyShipPtr^.PosX;
      FromY:=MyShipPtr^.PosY;
      l:=l+1;
      if l=15 then begin
         SetAPen(^MyScreen[1]^.RastPort,0);
         if (x in [0..480]) and (y in [0..480]) then DRAWRECT(x,y);
         if (x in [0..505]) and (y in [0..512]) and (MyShipPtr^.SType<>SHIPTYPE_FLEET)
         then with MyShipPtr^ do begin
            s:='';
            if Ladung and MASK_SIEDLER>0 then s:='S';
            if Ladung and MASK_LTRUPPS>0 then s:=s+'L';
            if Fracht>0 then s:='W';
            if SType=21 then s:=s+' '+intstr(round(SQRT((PosX*PosX)+(PosY*PosY))));
            WRITE(x+2,y+21,MyShipPtr^.Owner,0,MyScreen[1]^,1,s);
         end;
      end else if l=30 then begin
         SetAPen(^MyScreen[1]^.RastPort,MyShipPtr^.Owner);
         if (x in [0..480]) and (y in [0..480]) then DRAWRECT(x,y);
         l:=0;
      end;

      RawCode:=0;
      RawCode:=GETRAWCODE;

      if (LData^ and 64=0) or (RawCode in [29..31,45,47,61..63,76..79]) then begin
         if (IBase^.MouseX in [0..512])
         or (RawCode in [29..31,45,47,61..63,76..79]) then begin
            if FINDOBJECT(ActSys,IBase^.MouseX,IBase^.MouseY,NIL) then begin
               PLAYSOUND(1,300);
               case ObjType of
                  TYPE_PLANET:   PLANETINFO(ActSys);
                  TYPE_SHIP:     if MyShipPtr^.SType=SHIPTYPE_FLEET then ORBITINFO(MyShipPtr,'Flotte',ActSys,0,0)
                                 else SHIPINFO(ActSys);
                  otherwise
               end
            end else begin
               if ((IBase^.MouseX<x) and (RawCode=0)) or (RawCode in [29,45,61,79]) then MyShipPtr^.PosX:=MyShipPtr^.PosX-1;
               if ((IBase^.MouseX>x+32) and (RawCode=0)) or (RawCode in [31,47,63,78]) then MyShipPtr^.PosX:=MyShipPtr^.PosX+1;
               if ((IBase^.MouseY<y) and (RawCode=0)) or (RawCode in [61..63,76]) then MyShipPtr^.PosY:=MyShipPtr^.PosY-1;
               if ((IBase^.MouseY>y+32) and (RawCode=0)) or (Rawcode in [29..31,77]) then MyShipPtr^.PosY:=MyShipPtr^.PosY+1;
               if (FromX=MyShipPtr^.PosX) and (FromY=MyShipPtr^.PosY) then begin
                  ObjPtr:=MyShipPtr;
                  SHIPINFO(ActSys);
               end else begin
                  if MyShipPtr^.PosX>50 then MyShipPtr^.PosX:=50; if MyShipPtr^.PosX<-50 then MyShipPtr^.PosX:=-50;
                  if MyShipPtr^.PosY>50 then MyShipPtr^.PosY:=50; if MyShipPtr^.PosY<-50 then MyShipPtr^.PosY:=-50;
                  ToX:=256+(MyShipPtr^.PosX+OffsetX)*32;
                  ToY:=256+(MyShipPtr^.PosY+OffsetY)*32;
                  if FINDOBJECT(ActSys,ToX+16,ToY+16,MyShipPtr) then case ObjType of
                     TYPE_PLANET:   begin
                                       PLAYSOUND(1,300);
                                       if not PLANETHANDLING(ActSys,MyShipPtr) then begin
                                          MyShipPtr^.Moving:=0;
                                          exit;
                                       end;
                                    end;
                     TYPE_SHIP:     begin
                                       OtherShipPtr:=ObjPtr;
                                       if OtherShipPtr^.Owner<>MyShipPtr^.Owner then begin
                                          CivFlag:=OtherShipPtr^.Owner;
                                          MyShipPtr^.PosX:=FromX;
                                          MyShipPtr^.PosY:=FromY;
                                          if STARTBIGSHIPFIGHT(MyShipPtr,OtherShipPtr,MODE_ONCE,ActSys)=1 then begin
                                             AUTOVERHANDLUNG(ActPlayerFlag,CivFlag,ActSys,0);
                                             MyShipPtr^.Moving:=0;
                                             exit;
                                          end;
                                          AUTOVERHANDLUNG(ActPlayerFlag,CivFlag,ActSys,0);
                                       end else if MyShipPtr^.SType<>SHIPTYPE_FLEET then begin
                                          FleetShipPtr:=OtherShipPtr;
                                          if OtherShipPtr^.SType<>SHIPTYPE_FLEET then begin
                                             l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
                                             if l=0 then DisplayBeep(NIL) else begin
                                                CopyMemQuick(long(OtherShipPtr),l,sizeof(r_ShipHeader));
                                                OtherShipPtr^.SType:=SHIPTYPE_FLEET;
                                                OtherShipPtr^.TargetShip:=ptr(l);
                                                OtherShipPtr^.TargetShip^.BeforeShip:=OtherShipPtr;
                                                OtherShipPtr^.TargetShip^.NextShip:=NIL;
                                                OtherShipPtr^.TargetShip^.Flags:=0;
                                             end;
                                          end;
                                          if OtherShipPtr^.TargetShip<>NIL then begin
                                             OtherShipPtr^.Flags:=0;
                                             OtherShipPtr:=OtherShipPtr^.TargetShip;

                                             while (OtherShipPtr^.SType<MyShipPtr^.SType)
                                             and (OtherShipPtr^.NextShip<>NIL)
                                              do OtherShipPtr:=OtherShipPtr^.NextShip;

                                             if OtherShipPtr^.BeforeShip^.SType=SHIPTYPE_FLEET then begin
                                                MyShipPtr^.BeforeShip^.NextShip:=MyShipPtr^.NextShip;
                                                if MyShipPtr^.NextShip<>NIL then MyShipPtr^.NextShip^.BeforeShip:=MyShipPtr^.BeforeShip;
                                                MyShipPtr^.BeforeShip:=OtherShipPtr^.BeforeShip;
                                                MyShipPtr^.NextShip:=OtherShipPtr;

                                                OtherShipPtr^.BeforeShip^.TargetShip:=MyShipPtr;
                                                OtherShipPtr^.BeforeShip:=MyShipPtr;
                                             end else LINKSHIP(MyShipPtr,OtherShipPtr,1);
                                             DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
                                          end;
                                          MyShipPtr:=FleetShipPtr;
                                       end else begin
                                          MyShipPtr^.PosX:=FromX;
                                          MyShipPtr^.PosY:=FromY;
                                          PLAYSOUND(1,600);
                                       end;
                                    end;
                     TYPE_STARGATE: begin
                                       DRAWSTARS(MODE_STARGATE,ActPlayer);
                                       SysID:=0;
                                       repeat
                                          delay(RDELAY);
                                          if (LData^ and 64=0) then begin
                                             if LastSystem<>0 then
                                              if SystemHeader[LastSystem].FirstShip.SType=TARGET_STARGATE then
                                              SysID:=LastSystem;
                                             PLAYSOUND(1,300);
                                          end else WRITEGALAXYDATA(0,TARGET_STARGATE);
                                       until (RData^ and 1024=0) or (SysID<>0);
                                       if (RData^ and 1024=0) or (SysID=ActSys) then begin
                                          MyShipPtr^.PosX:=FromX;
                                          MyShipPtr^.PosY:=FromY;
                                          PLAYSOUND(1,300);
                                          DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
                                       end;
                                       if not (SysID in [0,ActSys]) then begin
                                          x:=ToX; y:=ToY;
                                          FADESTARGATE(SysID,ActSys,MyShipPtr);
                                          exit;
                                       end;
                                    end;
                     TYPE_WORMHOLE: DOWORMHANDLING(MyShipPtr);
                     otherwise begin
                        writeln('FINDOBJ-Err,TerraShip');
                        DisplayBeep(NIL);
                     end;
                  end else if (SystemHeader[ActSys].FirstShip.SType<>TARGET_STARGATE)
                  and (MyShipPtr^.SType<>SHIPTYPE_FLEET)
                  and ((Year+(MyShipPtr^.PosX*MyShipPtr^.PosY)) mod 335=0) then begin
                     DRAWMOVINGSHIP;


                     if not WORMHOLE(MyShipPtr) then begin
                        MyShipPtr^.Owner:=0;
                        exit;
                     end;
                  end else DRAWMOVINGSHIP;
                  if MyShipPtr^.Moving>0 then MyShipPtr^.Moving:=MyShipPtr^.Moving-1;
                  if (MyShipPtr^.PosX in [-3..2]) and (MyShipPtr^.PosY in [-3..2]) then begin
                     FromX:=MyShipPtr^.PosX;
                     FromY:=MyShipPtr^.PosY;
                     MyShipPtr^.Owner:=0;
                     EXPLODE(ActSys,MyShipPtr);
                     if MyShipPtr^.SType=SHIPTYPE_FLEET then KILLFLEET(MyShipPtr)
                     else if MyShipPtr^.SType in [17..24] then STARDESASTER(ActSys,MyShipPtr);
                     exit;
                   end;
                end;
             end;
         end else if (RawCode=0) and (IBase^.MouseX in [522..629])
         and (IBase^.MouseY in [9..117]) then begin
            OffsetX:=576-IBase^.MouseX; OffsetY:=63-IBase^.MouseY;
            DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
         end;
      end else if (RData^ and 1024=0) then begin
         if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [9..117]) then begin
            if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [9..29]) then
             if OffsetY<42 then OffsetY:=OffsetY+2;
            if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [97..117]) then
             if OffsetY>-42 then OffsetY:=OffsetY-2;
            if (IBase^.MouseX in [518..538]) and (IBase^.MouseY in [9..117]) then
             if OffsetX<42 then OffsetX:=OffsetX+2;
            if (IBase^.MouseX in [614..634]) and (IBase^.MouseY in [9..117]) then
             if OffsetX>-42 then OffsetX:=OffsetX-2;
            DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
         end else begin
            PLAYSOUND(1,300);
            if FINDOBJECT(ActSys,x+16,y+16,NIL) then begin
               case ObjType of
                  TYPE_SHIP: SYSTEMINFO(ActSys);
                  otherwise;
               end;
            end;
         end;

      end;
      if (MyShipPtr^.PosX>60) or (MyShipPtr^.PosY>60) then begin
         ObjPtr:=MyShipPtr;
         SYSTEMINFO(ActSys);
      end;
      if (MyShipPtr^.Moving>=0) and (OldMoving<>MyShipPtr^.Moving) then with MyShipPtr^ do begin
         if SType=SHIPTYPE_FLEET then s:='----' else begin
            s:=intstr(round((Shield+Tactical*3)/ShipData[SType].MaxShield*100))+'%';
            while length(s)<4 do s:='0'+s;
         end;
         s:=intstr(Moving)+'-'+s; while length(s)<7 do s:='0'+s;
         OldMoving:=Moving;
         WRITE(521,293,GETCIVFLAG(ActPlayer),1,MyScreen[1]^,2,s);
      end;
      x:=256+(MyShipPtr^.PosX+OffsetX)*32;
      y:=256+(MyShipPtr^.PosY+OffsetY)*32;
      CLEARINTUITION;
   until (MyShipPtr^.Moving<=0) or (MyShipPtr^.Target=TARGET_POSITION) or (MyShipPtr^.Owner=0);
   RECT(MyScreen[1]^,0,520,291,632,308);
end;   { MOVESHIP }



procedure SYSTEMINFO;

var i                           :integer;
var l                           :long;
var SysID                       :byte;
var x,y                         :word;
var b                           :boolean;
var MyShipPtr,UseShipPtr        :^r_ShipHeader;
var FleetUsed                   :boolean;


begin
   b:=false;
   MyShipPtr:=ObjPtr;
   if Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]=0 then exit;
   UseShipPtr:=MyShipPtr;
   if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
      FleetUsed:=true;
      MyShipPtr:=MyShipPtr^.TargetShip;
   end else FleetUsed:=false;
   MAKEBORDER(MyScreen[1]^,194,119,316,232,12,6,1);
   for i:=1 to 5 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
   WRITE(256,124,0,16,MyScreen[1]^,4,PText[473]);
   WRITE(256,146,0,16,MyScreen[1]^,4,PText[474]);
   if UseShipPtr^.Target=TARGET_POSITION then WRITE(256,168,0,16,MyScreen[1]^,4,PText[475])
   else WRITE(256,168,0,16,MyScreen[1]^,4,PText[476]);
   if MyShipPtr^.SType<>21 then WRITE(256,190,0,16,MyScreen[1]^,4,PText[477])
     else WRITE(256,190,0,16,MyScreen[1]^,4,PText[478]);
   WRITE(256,212,0,16,MyScreen[1]^,4,PText[479]);
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         if IBase^.MouseX in [194..316] then begin
            if IBase^.MouseY in [122..142] then begin
               KLICKGAD(198,122);
               b:=true;
               DRAWSTARS(MODE_REDRAW,ActPlayer);
               SysID:=0;
               repeat
                  delay(RDELAY);
                  if (LData^ and 64=0) then begin
                     SysID:=LastSystem;
                     PLAYSOUND(1,300);
                  end else WRITEGALAXYDATA(ActSys,ShipData[MyShipPtr^.SType].MaxMove);
               until (RData^ and 1024=0) or (SysID<>0);
               if (RData^ and 1024=0) then PLAYSOUND(1,300);
               if (SysID in [1..MAXSYSTEMS]) and (SysID<>ActSys) then begin
                  with SystemHeader[SysID] do if Planets=0 then CREATENEWSYSTEM(SysID,1);
                  MyShipPtr^.Target:=SysID;
                  MyShipPtr^.Source:=ActSys;
                  l:=abs(SystemX[ActSys]-SystemX[SysID]) + abs(SystemY[ActSys]-SystemY[SysID]);
                  l:=-(l div ShipData[MyShipPtr^.SType].MaxMove)-1;
                  if l<-127 then l:=-127;
                  MyShipPtr^.Moving:=l;
                  if not FleetUsed then LINKSHIP(MyShipPtr,^SystemHeader[SysID].FirstShip,1)
                  else begin
                     MyShipPtr^.BeforeShip^.Moving:=MyShipPtr^.Moving;
                     MyShipPtr^.BeforeShip^.Target:=MyShipPtr^.Target;
                     MyShipPtr^.BeforeShip^.Source:=MyShipPtr^.Source;
                     LINKSHIP(MyShipPtr^.BeforeShip,^SystemHeader[SysID].FirstShip,1);
                     MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
                  end;
               end;
               DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
            end else if IBase^.MouseY in [144..164] then begin
               KLICKGAD(198,144);
               b:=true;
               RECT(MyScreen[1]^,0,194,119,316,234);
               REFRESHDISPLAY;
               x:=256+(UseShipPtr^.PosX+OffsetX)*32;
               y:=256+(UseShipPtr^.PosY+OffsetY)*32;
               PLAYSOUND(2,1100);
               if (x in [0..480]) and (y in [0..480]) then begin
                  RECT(MyScreen[1]^,0,x,y,x+31,y+31);
                  for i:=0 to 15 do begin
                     BltBitMapRastPort(^ImgBitMap4,i*32,0,^MyScreen[1]^.RastPort,x,y,31,31,192);
                     delay(5);
                  end;
                  RECT(MyScreen[1]^,0,x,y,x+31,y+31);
               end;
               delay(10);
               UseShipPtr^.Owner:=0;
               UseShipPtr^.SType:=8;
               UseShipPtr^.Moving:=0;
               if FleetUsed then begin
                  repeat
                     MyShipPtr^.Owner:=0;
                     MyShipPtr:=MyShipPtr^.NextShip;
                  until MyShipPtr=NIL;
               end;
               DMACON_WRITE^:=$0003;
           end else if IBase^.MouseY in [166..186] then begin
               KLICKGAD(198,166);
               b:=true;
               if UseShipPtr^.Target=TARGET_POSITION then begin
                  RECT(MyScreen[1]^,0,194,119,316,234);
                  REFRESHDISPLAY;
                  UseShipPtr^.Target:=ActSys;
                  if UseShipPtr^.Moving>0 then MOVESHIP(ActSys,UseShipPtr,false);
               end else UseShipPtr^.Target:=TARGET_POSITION;
            end else if IBase^.MouseY in [188..208] then begin
               KLICKGAD(198,188);
               b:=true;
               if MyShipPtr^.SType=21 then with SystemHeader[ActSys] do begin
                  if round(SQRT((MyShipPtr^.PosX*MyShipPtr^.PosX)+(MyShipPtr^.PosY*MyShipPtr^.PosY)))>=10 then begin
                     MAKEBORDER(MyScreen[1]^,70,115,440,200,12,6,0);
                     WRITE(256,125,ActPlayerFlag,16,MyScreen[1]^,4,PText[481]);
                     WRITE(256,147,ActPlayerFlag,16,MyScreen[1]^,4,PText[482]);
                     WRITE(256,169,ActPlayerFlag,16,MyScreen[1]^,4,PText[483]);
                     WAITLOOP(false);
                     RECT(MyScreen[1]^,0,70,115,440,200);
                  end else if FirstShip.SType=0 then begin
                     FirstShip.SType:=TARGET_STARGATE;
                     FirstShip.PosX:=MyShipPtr^.PosX;
                     FirstShip.PosY:=MyShipPtr^.PosY;
                     MyShipPtr^.Owner:=0;
                     RECT(MyScreen[1]^,0,194,119,316,234);
                     REFRESHDISPLAY;
                     delay(15);
                  end else REQUEST(PText[485],PText[486],ActPlayerFlag,ActPlayerFlag)
               end else with MyShipPtr^ do if Ladung=0
                  then begin
                     if not FleetUsed then begin
                        MyShipPtr^.Flags:=1-MyShipPtr^.Flags;
                        { SHIPFLAG_NONE <-> SHIPFLAG_WATER }
                        MyShipPtr^.Moving:=0;
                     end else REQUEST(PText[487],PText[488],ActPlayerFlag,ActPlayerFlag);
                  end else REQUEST(PText[489],PText[490],ActPlayerFlag,ActPlayerFlag);
            end else if IBase^.MouseY in [210..230] then begin
               KLICKGAD(198,210);
               UseShipPtr^.Moving:=0;
               b:=true;
            end;
         end;
      end;
      if (RData^ and 1024=0) then begin
         PLAYSOUND(1,300);
         b:=true;
      end;
   until b;
   RECT(MyScreen[1]^,0,194,119,316,234);
   REFRESHDISPLAY;
end;



procedure INITMENU;

var l,ISize     :long;

begin
   Screen2:=0;
   s:=PathStr[8]+'Menu.pal';
   l:=SETCOLOR(MyScreen[2]^,s);
   if not IMemID then begin
      s:=PathStr[8]+'Menu.img';
      if not DISPLAYIMAGE(s,0,0,640,512,6,MyScreen[2]^,4) then begin
         DisplayBeep(NIL);
         exit;
      end;
      IMemID:=true;
      exit;
   end;
   DrawImage(^MyScreen[2]^.RastPort,^Img,0,0);
end;




procedure OPTIONMENU(Mode :byte);

var i,j,Player,btx      :byte;
var Factor              :real;
var b                   :boolean;


procedure DRAWGAD(GadID,GadSelect :word);

var Col1,Col2   :byte;

begin
   if GadSelect=1 then begin
      Col1:=100; Col2:=107;
   end else begin
      Col1:=40; Col2:=14;
   end;
   MAKEBORDER(MyScreen[2]^,60,GadID,124,GadID+63,Col1,Col2,1);
   if GadSelect=1 then begin
      Col1:=40; Col2:=14;
   end else begin
      Col1:=100; Col2:=107;
   end;
   MAKEBORDER(MyScreen[2]^,150,GadID,214,GadID+63,Col1,Col2,1);
end;


procedure CHECKGADS(GadID :byte);

begin
   if GadID in [0,7] then begin
      RECT(MyScreen[2]^,0,542,141,568,310);
      s:=intstr(Player);
      WRITE(555,(5-Player)*38+142,40,16,MyScreen[2]^,4,s);
      if GadID=7 then exit;
   end;
   if GadID in [0,6] then begin
      RECT(MyScreen[2]^,0,447,141,473,310);
      RECT(MyScreen[2]^,0,412,341,508,360);
      s:=intstr(Level);
      WRITE(460,(10-Level)*17+142,40,16,MyScreen[2]^,4,s);
      s:=PText[Level+491];
      WRITE(460,343,40,16,MyScreen[2]^,4,s);
      if GadID=6 then exit;
   end;
   if GadID=0 then for i:=1 to 5 do RECT(MyScreen[2]^,0,238,33+i*80,388,52+i*80)
   else RECT(MyScreen[2]^,0,238,33+GadID*80,388,52+GadID*80);
   if GadID in [0,1] then begin
      if Save.PlayMySelf then begin
         DRAWGAD(80,1);
         WRITE(240,115,40,1,MyScreen[2]^,4,PText[505]);
      end else begin
         DRAWGAD(80,2);
         WRITE(240,115,40,1,MyScreen[2]^,4,PText[506]);
      end;
   end;
   if GadID in [0,2] then begin
      if Save.SmallFight then begin
         DRAWGAD(160,1);
         WRITE(240,195,40,1,MyScreen[2]^,4,PText[507]);
      end else begin
         DRAWGAD(160,2);
         WRITE(240,195,40,1,MyScreen[2]^,4,PText[508]);
      end;
   end;
   if GadID in [0,3] then begin
      if Save.SmallLand then begin
         DRAWGAD(240,1);
         WRITE(240,275,40,1,MyScreen[2]^,4,PText[505]);
      end else begin
         DRAWGAD(240,2);
         WRITE(240,275,40,1,MyScreen[2]^,4,'Player');
      end;
   end;
   if GadID in [0,4] then begin
      if Save.NoWorm then begin
         DRAWGAD(320,1);
         WRITE(240,355,40,1,MyScreen[2]^,4,PText[505]);
      end else begin
         DRAWGAD(320,2);
         WRITE(240,355,40,1,MyScreen[2]^,4,'Player');
      end;
   end;
   if GadID in [0,5] then begin
      if Save.FastMove then begin
         DRAWGAD(400,1);
         WRITE(240,435,40,1,MyScreen[2]^,4,PText[510]);
      end else begin
         DRAWGAD(400,2);
         WRITE(240,435,40,1,MyScreen[2]^,4,PText[511]);
      end;
   end;
end;


begin
   SWITCHDISPLAY;
   INITMENU;
   Player:=0;
   for i:=1 to 7 do if Save.CivPlayer[i]<>0 then Player:=Player+1;
   WRITE(320,55,40,16,MyScreen[2]^,4,PText[513]);
   for i:=1 to 5 do MAKEBORDER(MyScreen[2]^,236,32+i*80,390,53+i*80,14,40,1);

   BltBitMapRastPort(^ImgBitMap8,384,128,^MyScreen[2]^.RastPort, 60,80,64,64,192);
   BltBitMapRastPort(^ImgBitMap8,448,128,^MyScreen[2]^.RastPort,150,80,64,64,192);
   WRITE(240,90,40,0,MyScreen[2]^,4,'Player');

   BltBitMapRastPort(^ImgBitMap8,384,128,^MyScreen[2]^.RastPort, 60,160,64,64,192);
   BltBitMapRastPort(^ImgBitMap8,512,128,^MyScreen[2]^.RastPort,150,160,64,64,192);
   WRITE(240,170,40,0,MyScreen[2]^,4,PText[514]);

   BltBitMapRastPort(^ImgBitMap8,384,128,^MyScreen[2]^.RastPort, 60,240,64,64,192);
   BltBitMapRastPort(^ImgBitMap8,448,128,^MyScreen[2]^.RastPort,150,240,64,64,192);
   WRITE(240,250,40,0,MyScreen[2]^,4,PText[515]);

   BltBitMapRastPort(^ImgBitMap8,384,128,^MyScreen[2]^.RastPort, 60,320,64,64,192);
   BltBitMapRastPort(^ImgBitMap8,448,128,^MyScreen[2]^.RastPort,150,320,64,64,192);
   WRITE(240,330,40,0,MyScreen[2]^,4,PText[516]);

   BltBitMapRastPort(^ImgBitMap8,576,128,^MyScreen[2]^.RastPort, 60,400,64,64,192);
   BltBitMapRastPort(^ImgBitMap8,512,128,^MyScreen[2]^.RastPort,150,400,64,64,192);

   WRITE(240,410,40,0,MyScreen[2]^,4,PText[517]);

   WRITE(460,100,40,16,MyScreen[2]^,4,'Level');
   if Mode=1 then begin
      WRITE(455,120,40,0,MyScreen[2]^,2,'I');
      WRITE(455,320,40,0,MyScreen[2]^,2,'J');
   end;
   MAKEBORDER(MyScreen[2]^,445,139,475,312,14,40,1);
   MAKEBORDER(MyScreen[2]^,410,339,510,362,14,40,1);

   WRITE(555,100,40,16,MyScreen[2]^,4,'Player');
   if Mode=1 then begin
      WRITE(550,120,40,0,MyScreen[2]^,2,'I');
      WRITE(550,320,40,0,MyScreen[2]^,2,'J');
   end;
   MAKEBORDER(MyScreen[2]^,540,139,570,312,14,40,1);

   CHECKGADS(0);

   ScreenToFront(MyScreen[2]);
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         PLAYSOUND(1,300);
         if (Mode=1) and (IBase^.MouseX in [550..580]) and (IBase^.MouseY in [120..330]) then begin
            if (IBase^.MouseY in [120..140]) and (Player<5) then Player:=Player+1;
            if (IBase^.MouseY in [310..330]) and (Player>1) then Player:=Player-1;
            CHECKGADS(7);
         end else if (Mode=1) and (IBase^.MouseX in [455..485]) and (IBase^.MouseY in [120..330]) then begin
            if (IBase^.MouseY in [120..140]) and (Level<10) then Level:=Level+1;
            if (IBase^.MouseY in [310..330]) and (Level>1) then Level:=Level-1;
            CHECKGADS(6);
         end else begin
            if IBase^.MouseY in [80..144] then begin
               if IBase^.MouseX in [60..124] then Save.PlayMySelf:=true
               else if IBase^.MouseX in [150..214] then Save.PlayMySelf:=false;
               CHECKGADS(1);
            end;

            if IBase^.MouseY in [160..224] then begin
               if IBase^.MouseX in [60..124] then Save.SmallFight:=true
               else if IBase^.MouseX in [150..214] then Save.SmallFight:=false;
               CHECKGADS(2);
            end;

            if IBase^.MouseY in [240..304] then begin
               if IBase^.MouseX in [60..124] then Save.SmallLand:=true
               else if IBase^.MouseX in [150..214] then Save.SmallLand:=false;
               CHECKGADS(3);
            end;

            if IBase^.MouseY in [320..384] then begin
               if IBase^.MouseX in [60..124] then Save.NoWorm:=true
               else if IBase^.MouseX in [150..214] then Save.NoWorm:=false;
               CHECKGADS(4);
            end;

            if IBase^.MouseY in [400..464] then begin
               if IBase^.MouseX in [60..124] then Save.FastMove:=true
               else if IBase^.MouseX in [150..214] then Save.FastMove:=false;
               CHECKGADS(5);
            end;
         end;
         delay(10);
      end;
   until (RData^ and 1024=0);
   PLAYSOUND(1,300);
   ScreenToFront(XScreen);
   if (Player>1) or (Save.CivPlayer[1]=0) then Multiplayer:=true else Multiplayer:=false;

   if (Mode=1) and (Player=1) then Save.CivPlayer[1]:=1;
   if (Player>1) and (Mode=1) then begin
      repeat
         i:=succ(random(MAXSYSTEMS));
      until i>1;
      exchange(Save.SystemName[1],Save.SystemName[i]);
      for i:=1 to Player do begin
         SWITCHDISPLAY;
         INITMENU;
         s:='Player '+intstr(i)+' '+PText[520];
         WRITE(320,50,40,16,MyScreen[2]^,4,s);
         if i=1 then begin
            btx:=1;
            Save.CivPlayer[1]:=0;
         end else btx:=7;
         for j:=1 to btx do begin
            MAKEBORDER(MyScreen[2]^,100,j*50+50,540,j*50+80,14,40,0);
            if Save.CivPlayer[j]=0 then s:=GETCIVNAME(j) else s:='Player '+intstr(Save.CivPlayer[j]);
            WRITE(320,j*50+58,40,16,MyScreen[2]^,4,s);
         end;
         b:=false;
         ScreenToFront(MyScreen[2]);
         repeat
            delay(RDELAY);
            if (LData^ and 64=0) and (IBase^.MouseX in [100..540]) then begin
               for j:=1 to btx do
                if (IBase^.MouseY in [j*50+50..j*50+80]) and (Save.CivPlayer[j]=0)
                then begin
                  b:=true;
                  Save.CivPlayer[j]:=i;
                  CLICKRECT(MyScreen[2]^,100,j*50+50,540,j*50+80,40);
                  PLAYERJINGLE(j);
               end;
            end;
         until b;
         for j:=1 to MAXCIVS do
          if (Save.CivPlayer[i]=Save.CivPlayer[j]) and (i<>j)
          then Save.CivPlayer[j]:=0;
         delay(20);
      end;
      SWITCHDISPLAY;
      INITMENU;
      WRITE(320,100,40,16,MyScreen[2]^,4,PText[521]);
      for i:=1 to 5 do begin
         MAKEBORDER(MyScreen[2]^,i*88+35,200,i*88+75,240,14,40,0);
         s:=intstr(i);
         WRITE(i*88+55,213,40,16,MyScreen[2]^,4,s);
      end;
      ScreenToFront(MyScreen[2]);
      Homeplanets:=0;
      repeat
         delay(RDELAY);
         if (LData^ and 64=0) and (IBase^.MouseY in [200..240]) then
          Homeplanets:=(IBase^.MouseX-35) div 88;
      until Homeplanets in [1..5];
      CLICKRECT(MyScreen[2]^,Homeplanets*88+35,200,Homeplanets*88+75,240,40);
      delay(20);
      SWITCHDISPLAY;
   end;
   if Mode=1 then begin
      if Level<=5 then begin
         Factor:=1+((Level-5)*0.055);     {78%..100}
         for j:=1 to MAXCIVS do if Save.CivPlayer[j]<>0 then for i:=1 to 42 do begin
            Save.TechCosts[j,i]:=round(Save.TechCosts[j,i]*Factor);
            Save.ProjectCosts[j,i]:=round(Save.ProjectCosts[j,i]*Factor);
         end;
      end else begin
         Factor:=1+((5-Level)*0.066);
         for j:=1 to MAXCIVS do if Save.CivPlayer[j]=0 then for i:=1 to 42 do begin
            Save.TechCosts[j,i]:=round(Save.TechCosts[j,i]*Factor);
            Save.ProjectCosts[j,i]:=round(Save.ProjectCosts[j,i]*Factor);
         end;
      end;
   end;
end;



procedure FREESYSTEMMEMORY;

var MyPlanetHeader              :^r_PlanetHeader;
var ActShipPtr,FleetShipPtr     :^r_ShipHeader;
var i,j                         :integer;
var l,MemCtr                    :long;

begin
   for i:=1 to MAXSYSTEMS do with SystemHeader[i] do if PlanetMemA>0 then begin
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         if MyPlanetHeader^.ProjectPtr<>NIL then FreeMem(long(MyPlanetHeader^.ProjectPtr),sizeof(ByteArr42));
         if MyPlanetHeader^.FirstShip.NextShip<>NIL then begin
            ActShipPtr:=MyPlanetHeader^.FirstShip.NextShip;

            if (ActShipPtr^.SType=SHIPTYPE_FLEET)
            and (ActShipPtr^.TargetShip<>NIL) then begin
               FleetShipPtr:=ActShipPtr^.TargetShip;
               repeat
                  l:=long(FleetShipPtr);
                  FleetShipPtr:=FleetShipPtr^.NextShip;
                  FreeMem(l,sizeof(r_ShipHeader));
               until FleetShipPtr=NIL;
            end;

            repeat
               l:=long(ActShipPtr);
               ActShipPtr:=ActShipPtr^.NextShip;
               FreeMem(l,sizeof(r_ShipHeader));
            until ActShipPtr=NIL;
         end;
      end;
      FreeMem(PlanetMemA,Planets*sizeof(r_PlanetHeader));
   end;
end;



function DISKMENU(Auto :byte):boolean;

const ACTVERSION=$0004;
const MODE_SYSTEM=1;
const MODE_PLANET=2;

var p                   :ptr;
var i,j,k               :integer;
var l                   :long;
var b                   :boolean;
var PlanetHeader        :^r_PlanetHeader;



procedure DECODEDATA;

var i   :byte;

begin
   for i:=1 to MAXCIVS do with Save do
    Staatstopf[i]:=((Staatstopf[i] xor $FA5375AF)-$13605185) xor $17031973
end;



procedure LOADSHIPS(ShipPtr :ptr);

var ActShipPtr,BeforeShipPtr,
    FleetShipPtr,BFleetShipPtr  :^r_ShipHeader;
var l                           :long;
var FirstFShip                  :boolean;

begin
   BeforeShipPtr:=ShipPtr;
   ActShipPtr:=BeforeShipPtr^.NextShip;
   while ActShipPtr<>NIL do begin
      l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
      if l=0 then begin
         BeforeShipPtr^.NextShip:=NIL;
         ActShipPtr:=NIL;
         exit;
      end;
      ActShipPtr:=ptr(l);
      l:=DosRead(FHandle,ActShipPtr,sizeof(r_ShipHeader));
      BeforeShipPtr^.NextShip:=ActShipPtr;
      ActShipPtr^.BeforeShip:=BeforeShipPtr;
      BeforeShipPtr:=ActShipPtr;
      if (ActShipPtr^.SType=SHIPTYPE_FLEET)
      and (ActShipPtr^.TargetShip<>NIL) then begin
         FirstFShip:=true;
         repeat
            l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
            if l=0 then begin
               ActShipPtr^.TargetShip:=NIL;
               ActShipPtr^.SType:=8;
               exit;
            end;
            FleetShipPtr:=ptr(l);
            l:=DosRead(FHandle,FleetShipPtr,sizeof(r_ShipHeader));
            if FirstFShip then begin
               FleetShipPtr^.BeforeShip:=ActShipPtr;
               ActShipPtr^.TargetShip:=FleetShipPtr;
            end else begin
               BFleetShipPtr^.NextShip:=FleetShipPtr;
               FleetShipPtr^.BeforeShip:=BFleetShipPtr;
            end;
            BFleetShipPtr:=FleetShipPtr;
            FleetShipPtr:=FleetShipPtr^.NextShip;
            FirstFShip:=false;
         until FleetShipPtr=NIL;
      end;
      ActShipPtr:=ActShipPtr^.NextShip;
   end;
end;



procedure SAVESHIPS(ShipPtr :ptr);

var ActShipPtr,FleetShipPtr     :^r_ShipHeader;
var l                           :long;

begin
   ActShipPtr:=ShipPtr;
   ActShipPtr:=ActShipPtr^.NextShip;
   repeat
      p:=ActShipPtr;
      l:=DosWrite(FHandle,p,sizeof(r_ShipHeader));
      if (ActShipPtr^.SType=SHIPTYPE_FLEET)
      and (ActShipPtr^.TargetShip<>NIL) then begin
         FleetShipPtr:=ActShipPtr^.TargetShip;
         repeat
            p:=FleetShipPtr;
            l:=DosWrite(FHandle,p,sizeof(r_ShipHeader));
            FleetShipPtr:=FleetShipPtr^.NextShip;
         until FleetShipPtr=NIL;
      end;
      ActShipPtr:=ActShipPtr^.NextShip;
   until ActShipPtr=NIL;
end;



function GETSAVENAME(Title :str):string;

var ID                  :array [1..6] of string;
var Y,Version           :long;
var Lev,i,j,jbef        :byte;

begin
   GETSAVENAME:='';
   s:=PathStr[9]+'IMPT.ID';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle=0 then exit else DosClose(FHandle);
   for i:=1 to 6 do begin
      ID[i]:='';
      repeat
         s:=PathStr[9]+'IMPT.'+intstr(i);
         FHandle:=DosOpen(s,MODE_OLDFILE);
         if FHandle=0 then ID[i]:=PText[525] else begin
            l:=DosRead(FHandle,^Version,4);
            if Version=ACTVERSION then begin
               l:=DosRead(FHandle,^Y,4);
               l:=DosRead(FHandle,^Lev,1);
               ID[i]:=PText[145]+': '+intstr(Y)+'     Level: '+intstr(Lev);
               DosClose(FHandle);
            end else begin
               DosClose(FHandle);
               j:=DeleteFile(s);
            end;
         end;
      until ID[i]<>'';
   end;
   MAKEBORDER(MyScreen[1]^,100, 80,410,270,12,6,2);
   MAKEBORDER(MyScreen[1]^,110,110,400,225,6,12,0);
   MAKEBORDER(MyScreen[1]^,110,235,400,260,6,12,0);
   WRITE(255,87,ActPlayerFlag,80,MyScreen[1]^,4,Title);
   for i:=1 to 6 do WRITE(120,97+i*18,ActPlayerFlag,0,MyScreen[1]^,4,ID[i]);
   jbef:=0;
   repeat
      j:=(IBase^.MouseY-97) div 18;
      if (i<>j) and (j in [1..6]) then begin
         if jbef<>j then for i:=1 to 6 do if i=j then begin
            WRITE(120,97+i*18,12,0,MyScreen[1]^,4,ID[i]);
            RECT(MyScreen[1]^,0,112,237,398,258);
            WRITE(120,240,12,1,MyScreen[1]^,4,ID[i]);
            jbef:=j;
         end else WRITE(120,97+i*18,ActPlayerFlag,0,MyScreen[1]^,4,ID[i]);
      end;
   until (j in [1..6]) and (LData^ and 64=0);
   PLAYSOUND(1,300);
   GETSAVENAME:=PathStr[9]+'IMPT.'+intstr(j);
end;


procedure ENCODEDATA;

var i   :byte;

begin
   for i:=1 to MAXCIVS do with Save do
    Staatstopf[i]:=((Staatstopf[i] xor $17031973)+$13605185) xor $FA5375AF;
end;




procedure NOMEMMESSAGE;

begin
   REQUEST(PText[526],PText[527],8,8);
end;


begin
   DISKMENU:=true;
   MAKEBORDER(MyScreen[1]^,194,119,316,254,12,6,1);
   for i:=1 to 6 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
   WRITE(255,124,0,16,MyScreen[1]^,4,PText[529]);
   WRITE(255,146,0,16,MyScreen[1]^,4,PText[530]);
   WRITE(255,168,0,16,MyScreen[1]^,4,PText[531]);
   WRITE(255,190,0,16,MyScreen[1]^,4,PText[532]);
   WRITE(255,212,0,16,MyScreen[1]^,4,PText[533]);
   WRITE(255,234,8,16,MyScreen[1]^,4,PText[534]);
   b:=false;
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) or (Auto>0) then begin
         if (IBase^.MouseX in [198..314]) or (Auto>0) then begin
            if (IBase^.MouseY in [122..142]) or (Auto=2) then begin
               KLICKGAD(198,122);
               b:=true;
               s:=GETSAVENAME(PText[536]);
               if s<>'' then begin
                  FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
                  if FHandle<>0 then begin
                     FREESYSTEMMEMORY;
                     l:=DosRead(FHandle,^l,4);
                     l:=DosRead(FHandle,^Year,4);
                     l:=DosRead(FHandle,^Level,1);
                     l:=DosRead(FHandle,^ActPlayer,1);
                     for i:=1 to 3 do l:=DosRead(FHandle,^MyWormHole[i],sizeof(r_WormHole));
                     l:=DosRead(FHandle,^SystemX[1],MAXSYSTEMS*2);
                     l:=DosRead(FHandle,^SystemY[1],MAXSYSTEMS*2);
                     l:=DosRead(FHandle,^SystemFlags[1,1],MAXSYSTEMS*MAXCIVS);
                     l:=DosRead(FHandle,^MaquesShips,4);
                     for i:=1 to MAXSYSTEMS do begin
                        l:=DosRead(FHandle,^SystemHeader[i],sizeof(r_SystemHeader));
                        with SystemHeader[i] do if (PlanetMemA>0) and (Planets>0) then begin
                           if SystemHeader[i].FirstShip.NextShip<>NIL then LOADSHIPS(^SystemHeader[i].FirstShip);
                           PlanetMemA:=AllocMem(sizeof(r_PlanetHeader)*Planets,MEMF_CLEAR);
                           if PlanetMemA=0 then begin
                              NOMEMMESSAGE;
                              exit;
                           end;
                           l:=DosRead(FHandle,ptr(PlanetMemA),Planets*sizeof(r_PlanetHeader));
                           for j:=1 to Planets do begin
                              PlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
                              if PlanetHeader^.ProjectPtr<>NIL then with PlanetHeader^ do begin
                                 l:=AllocMem(sizeof(ByteArr42),MEMF_CLEAR);
                                 if l=0 then begin
                                    for k:=1 to Planets do begin
                                       if ProjectPtr<>NIL then FreeMem(long(ProjectPtr),sizeof(ByteArr42));
                                       ProjectPtr:=NIL;
                                    end;
                                    NOMEMMESSAGE;
                                    exit;
                                 end;
                                 ProjectPtr:=ptr(l);
                                 l:=DosRead(FHandle,ProjectPtr,sizeof(ByteArr42));
                              end;
                              if PlanetHeader^.FirstShip.NextShip<>NIL then LOADSHIPS(^PlanetHeader^.FirstShip);
                           end;
                        end;
                     end;
                     l:=DosRead(FHandle,^Save,sizeof(r_Save));
                     DECODEDATA;
                     DosClose(FHandle);
                  end;
               end;
               SETWORLDCOLORS;
               MultiPlayer:=false;
               for i:=2 to 7 do if Save.CivPlayer[i]<>0 then MultiPlayer:=true;
               ActPlayerFlag:=GETCIVFLAG(ActPlayer);
               LastPlayer:=0; Informed:=false;
               INFORMUSER;
            end else if (IBase^.MouseY in [144..164]) or (Auto=1) then begin
               KLICKGAD(198,144);
               b:=true;
               s:=GETSAVENAME(PText[537]);
               if s<>'' then begin
                  FHandle:=OPENSMOOTH(s,MODE_NEWFILE);
                  if FHandle<>0 then begin
                     l:=ACTVERSION;
                     l:=DosWrite(FHandle,^l,4);
                     l:=DosWrite(FHandle,^Year,4);
                     l:=DosWrite(FHandle,^Level,1);
                     l:=DosWrite(FHandle,^ActPlayer,1);
                     for i:=1 to 3 do l:=DosWrite(FHandle,^MyWormHole[i],sizeof(r_WormHole));
                     l:=DosWrite(FHandle,^SystemX[1],MAXSYSTEMS*2);
                     l:=DosWrite(FHandle,^SystemY[1],MAXSYSTEMS*2);
                     l:=DosWrite(FHandle,^SystemFlags[1,1],MAXSYSTEMS*MAXCIVS);
                     l:=DosWrite(FHandle,^MaquesShips,4);
                     for i:=1 to MAXSYSTEMS do begin
                        l:=DosWrite(FHandle,^SystemHeader[i],sizeof(r_SystemHeader));
                        with SystemHeader[i] do if (PlanetMemA>0) and (Planets>0) then begin
                           if SystemHeader[i].FirstShip.NextShip<>NIL then SAVESHIPS(^SystemHeader[i].FirstShip);
                           l:=DosWrite(FHandle,ptr(PlanetMemA),Planets*sizeof(r_PlanetHeader));
                           for j:=1 to Planets do begin
                              PlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
                              if PlanetHeader^.ProjectPtr<>NIL then l:=DosWrite(FHandle,PlanetHeader^.ProjectPtr,sizeof(ByteArr42));
                              if PlanetHeader^.FirstShip.NextShip<>NIL then SAVESHIPS(^PlanetHeader^.FirstShip);
                           end;
                        end;
                     end;
                     ENCODEDATA;
                     l:=DosWrite(FHandle,^Save,sizeof(r_Save));
                     DECODEDATA;
                     DosClose(FHandle);
                  end else writeln('No Savefile');
               end;
            end else if IBase^.MouseY in [166..186] then begin
               KLICKGAD(198,166);
               s:=GETSAVENAME(PText[538]);
               if s<>'' then l:=DeleteFile(s);
               b:=true;
            end else if IBase^.MouseY in [188..208] then begin
               KLICKGAD(198,188);
               OPTIONMENU(0);
               ScreenToFront(MyScreen[1]);
            end else if IBase^.MouseY in [210..230] then begin
               KLICKGAD(198,210);
               HIGHSCORE
            end else if IBase^.MouseY in [232..252] then begin
               KLICKGAD(198,232);
               DISKMENU:=false;
               b:=true;
            end;
         end;
      end;
   until b or (RData^ and 1024=0) or (Auto>0);
   if (RData^ and 1024=0) then PLAYSOUND(1,300);
   DRAWSTARS(MODE_REDRAW,ActPlayer);
end;



procedure AUTOSHIPTRAVEL;

var l                                   :long;
var i,k                                 :integer;
var MyShipPtr,BAKShipPtr                :^r_ShipHeader;
var CivVar,CivVar2,SysSteps,iStep       :byte;
var DconDone,b,Visible                  :boolean;
var MyPlanetHeader                      :^r_PlanetHeader;



function GETMYADJ(CivFlag :byte):str;

begin
   case CivFlag of
      FLAG_TERRA:  GETMYADJ:=PText[540];
      FLAG_KLEGAN: GETMYADJ:=PText[541];
      FLAG_REMALO: GETMYADJ:=PText[542];
      FLAG_CARDAC: GETMYADJ:=PText[543];
      FLAG_FERAGI: GETMYADJ:=PText[544];
      FLAG_BAROJA: GETMYADJ:=PText[545];
      FLAG_VOLKAN: GETMYADJ:=PText[546];
      FLAG_OTHER:  case Save.WorldFlag of
                     WFLAG_CEBORC: GETMYADJ:=PText[547];
                     WFLAG_DCON:   begin
                                      GETMYADJ:=PText[548];
                                      DconDone:=true;
                                   end;
                     WFLAG_JAHADR: GETMYADJ:=PText[549];
                     otherwise GETMYADJ:=GETMYADJ(Save.WorldFlag);
                  end;
      FLAG_MAQUES: GETMYADJ:=PText[550];
      otherwise GETMYADJ:='ERROR!';
   end;
end;



begin
   DconDone:=false;
   if Mode=MODE_SHIPS then begin
      SysSteps:=1;
      i:=ActSys-1;
      MyShipPtr:=ShipPtr;
   end else begin
      i:=0;
      SysSteps:=2;
   end;
   repeat
      i:=i+1;
      for iStep:=1 to SysSteps do begin
         if Mode=MODE_ALL then MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
         if MyShipPtr<>NIL then repeat
            CivVar:=GETCIVVAR(MyShipPtr^.Owner);
            if (MyShipPtr^.SType=SHIPTYPE_FLEET) and (CivVar in [1..MAXCIVS])
            and ((Save.CivPlayer[CivVar]=0) or Save.PlayMySelf)
             then KILLFLEET(MyShipPtr);
            if (MyShipPtr^.SType=SHIPTYPE_FLEET) and (CivVar=0) then KILLFLEET(MyShipPtr);
            if CivVar in [1..MAXCIVS] then begin
               b:=false; Visible:=false;
               if CivVar=ActPlayer then b:=true;
               if b and (Save.CivPlayer[ActPlayer]<>0) then Visible:=true;

                  {*** Computership mit Playerplanet als Ziel ***}
                  if (MyShipPtr^.Target>0) and (CivVar in [1..MAXCIVS])
                  and (Save.CivPlayer[CivVar]=0) then begin
                     MyPlanetHeader:=ptr(SystemHeader[i].PlanetMemA+sizeof(r_PlanetHeader)*pred(MyShipPtr^.Target));
                     if GETCIVVAR(MyPlanetHeader^.PFlags) in [1..MAXCIVS] then begin
                        if  (MyPlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag) then begin
                           b:=true;
                           if Save.CivPlayer[GETCIVVAR(MyPlanetHeader^.PFlags)]<>0 then Visible:=true;
                        end else b:=false;
                     end;
                  end;
                  {*** Computership mit Playership als Ziel ***}
                  if MyShipPtr^.Target=TARGET_ENEMY_SHIP then FINDENEMYOBJECT(i,MyShipPtr);
                  if (MyShipPtr^.TargetShip<>NIL) and (CivVar in [1..MAXCIVS])
                  and not (MyShipPtr^.SType=SHIPTYPE_FLEET) then begin
                     if (GETCIVVAR(MyShipPtr^.TargetShip^.Owner) in [1..MAXCIVS])
                     and (Save.CivPlayer[GETCIVVAR(MyShipPtr^.TargetShip^.Owner)]<>0) then begin
                        if ((GETCIVVAR(MyShipPtr^.TargetShip^.Owner)=ActPlayer)
                        and (Save.CivPlayer[CivVar]=0)) then begin
                           b:=true;
                           if Save.CivPlayer[GETCIVVAR(MyShipPtr^.TargetShip^.Owner)]<>0
                            then Visible:=true;
                        end else b:=false;
                     end
                  end;
                  {*** ComputerShip erreicht PlayerSystem ***}
                  if (CivVar in [1..MAXCIVS]) and
                  (GETCIVVAR(SystemFlags[1,i]) in [1..MAXCIVS]) then begin
                     if (Save.CivPlayer[GETCIVVAR(SystemFlags[1,i])]<>0)
                     and (Save.CivPlayer[CivVar]=0) and (GETCIVVAR(SystemFlags[1,i])=ActPlayer)
                     then begin
                        b:=true;
                        Visible:=true;
                     end;
                  end;
                  if Save.CivPlayer[CivVar]<>0 then Visible:=true;
                  if Multiplayer and (not (MyShipPtr^.Flags and SHIPFLAG_WATER=0) and not Informed)
                   then Visible:=false;

               if b then begin
                  BAKShipPtr:=MyShipPtr^.BeforeShip;
                  if (MyShipPtr^.Moving>0) and (MyShipPtr^.Target<>TARGET_POSITION) then begin
                     if ((Save.CivPlayer[GETCIVVAR(MyShipPtr^.Owner)]=0) or Save.PlayMySelf)
                     and not ((MyShipPtr^.SType=21) and (SystemHeader[i].FirstShip.SType<>TARGET_STARGATE))
                     then begin
                        if (Save.WarState[CivVar,1] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,2] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,3] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,4] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,5] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,6] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,7] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[CivVar,8] in [LEVEL_WAR,LEVEL_COLDWAR])
                         then FINDENEMYOBJECT(i,MyShipPtr)
                        else l:=FINDNEXTPLANET(i,MyShipPtr);
                     end;
                     if Visible then INFORMUSER;
                     if MyShipPtr^.Moving>0 then begin
                        if Visible then begin
                           if not ((256+(MyShipPtr^.PosX+OffsetX)*32 in [1..478])
                           and (256+(MyShipPtr^.PosY+OffsetY)*32 in [1..478]))
                           or  (Display<>i) then begin
                              OffsetX:=-MyShipPtr^.PosX-1;
                              OffsetY:=-MyShipPtr^.PosY-1;
                              DRAWSYSTEM(MODE_REDRAW,i,MyShipPtr);
                           end;
                        end;
                     end;
                     CivVar2:=GETCIVVAR(SystemFlags[1,i]);
                     if CivVar2>0 then begin
                        if Save.WarState[CivVar,CivVar2]=LEVEL_UNKNOWN then Save.WarState[CivVar,CivVar2]:=LEVEL_PEACE;
                        if Save.WarState[CivVar2,CivVar]=LEVEL_UNKNOWN then Save.WarState[CivVar2,CivVar]:=LEVEL_PEACE;
                     end;
                     MOVESHIP(i,MyShipPtr,Visible);
                  end else if (MyShipPtr^.Moving<0) and (Mode=MODE_ALL) then begin
                     MyShipPtr^.Moving:=MyShipPtr^.Moving+1;
                     if MyShipPtr^.Moving>=0 then begin
                        CivVar2:=GETCIVVAR(SystemFlags[1,i]);
                        if CivVar2>0 then begin
                           if Save.WarState[CivVar,CivVar2]=LEVEL_UNKNOWN then Save.WarState[CivVar,CivVar2]:=LEVEL_PEACE;
                           if Save.WarState[CivVar2,CivVar]=LEVEL_UNKNOWN then Save.WarState[CivVar2,CivVar]:=LEVEL_PEACE;
                        end;
                        SystemFlags[CivVar,i]:=SystemFlags[CivVar,i] or FLAG_KNOWN;
                        case random(2) of
                           0: MyShipPtr^.PosX:=-35;
                           1: MyShipPtr^.PosX:=35;
                        end;
                        case random(3) of
                           0: MyShipPtr^.PosY:=-35;
                           1: MyShipPtr^.PosY:=35;
                           2: MyShipPtr^.PosY:=0;
                        end;
                        repeat
                           with MyShipPtr^ do case random(4) of
                              0: PosX:=PosX+1;
                              1: PosY:=PosY+1;
                              2: PosX:=PosX-1;
                              3: PosY:=PosY-1;
                           end;
                        until not FINDOBJECT(i,256+(MyShipPtr^.PosX+OffsetX)*32,256+(MyShipPtr^.PosY+OffsetY)*32,MyShipPtr);
                        if ((SystemFlags[1,i] and ActPlayerFlag=ActPlayerFlag) or (CivVar=ActPlayer))
                        and (Save.CivPlayer[ActPlayer]<>0) and not DconDone then begin
                           INFORMUSER;
                           MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                           s:=GETMYADJ(MyShipPtr^.Owner);

                           if not DconDone then
                            if MyShipPtr^.SType=SHIPTYPE_FLEET then begin
                              s[length(s)]:=chr(0);
                              s:=s+' '+PText[552]
                           end else s:=s+' '+PText[553];
                           WRITE(280,136,MyShipPtr^.Owner,1+16,MyScreen[1]^,4,s);
                           s:=PText[166]+' '+Save.SystemName[i];
                           if SystemFlags[1,i] and FLAG_CIV_MASK<>0 then
                            WRITE(280,163,SystemFlags[1,i] and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s)
                           else
                            WRITE(280,163,12,1+16,MyScreen[1]^,4,s);
                           if MyShipPtr^.Stype<>SHIPTYPE_FLEET then BltBitMapRastPort(^ImgBitMap4,(MyShipPtr^.SType-8)*32,32,^MyScreen[1]^.RastPort,93,140,32,32,192)
                           else BltBitMapRastPort(^ImgBitMap4,(MyShipPtr^.TargetShip^.SType-8)*32,32,^MyScreen[1]^.RastPort,93,140,32,32,192);
                           if Save.PlayMySelf then delay(PAUSE);
                           WAITLOOP(Save.PlayMySelf);
                           RECT(MyScreen[1]^,0,85,120,425,200);
                           REFRESHDISPLAY;
                           if (SystemFlags[1,i] and FLAG_CIV_MASK=FLAG_REMALO) and (Save.CivPlayer[3]=0)
                            and (MyShipPtr^.Owner<>FLAG_REMALO)
                            and (Save.WarPower[3]>Save.WarPower[GETCIVVAR(MyShipPtr^.Owner)])
                            and not (Save.WarState[3,GETCIVVAR(MyShipPtr^.Owner)] in [LEVEL_DIED,LEVEL_ALLIANZ,LEVEL_WAR]) then begin
                              AUTOVERHANDLUNG(FLAG_REMALO,MyShipPtr^.Owner,ActSys,MODE_TERRITORIUM);
                              REFRESHDISPLAY;
                           end;
                        end;
                     end;
                  end;
                  MyShipPtr:=BAKShipPtr^.NextShip;
               end;
            end;
            if (MyShipPtr<>NIL) and (Mode<>MODE_SHIPS) then MyShipPtr:=MyShipPtr^.NextShip;
         until (MyShipPtr=NIL) or (Mode=MODE_SHIPS);
      end;
   until (i=MAXSYSTEMS) or (Mode=MODE_SHIPS);
   if (ActSys<>Display) and (Mode<>MODE_SHIPS) then begin
      if ActSys=0 then DRAWSTARS(MODE_REDRAW,ActPlayer)
      else DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   end;
end;



procedure ROTATEPLANETS(ActSys :byte);


var SystemOwn                           :array [1..MAXCIVS] of long;
var i,j,k                               :integer;
var l,PMoney                            :long;
var sin_rot,cos_rot,d                   :real;
var NewTech                             :array [1..6] of byte;
var CivVar,PCreativity,PProd,
    btx,XState,Fight                    :byte;
var PlanetHeader                        :^r_PlanetHeader;
var MyShipPtr,ActShipPtr                :^r_ShipHeader;
var vNS,b,FreeSystem                    :boolean;
var ActPProjects                        :^ByteArr42;
var FromX,FromY                         :short;



function FINDMONEYPLANET(CivFlag,CivVar :byte):byte;

var MyPlanetHeader                              :^r_PlanetHeader;
var ActPProject                                 :^ByteArr42;
var i,j,k,l,Objects,SysID,PID,XProjectID        :Byte;

begin
   FINDMONEYPLANET:=0;
   SysID:=0;   PID:=0;   Objects:=0;   XProjectID:=0;
   for i:=1 to Save.SYSTEMS do with SystemHeader[i] do if Planets>0 then for j:=1 to Planets do begin
      MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
      l:=0;
      with MyPlanetHeader^ do if (PFlags and FLAG_CIV_MASK=CivFlag) then begin
         ActPProject:=ProjectPtr;
         l:=ActPProject^[25];
         for k:=28 to 42 do if ActPProject^[k]>0 then l:=l+1;
      end;
      if l>Objects then begin
         SysID:=i; PID:=j; Objects:=l;
      end;
   end;
   if Objects=0 then exit;
   if SysID>0 then begin
      MyPlanetHeader:=ptr(SystemHeader[SysID].PlanetMemA+pred(PID)*sizeof(r_PlanetHeader));
      ActPProject:=MyPlanetHeader^.ProjectPtr;
      s:=PText[166]+': '+Save.SystemName[SysID]+'   '+PText[167]+': '+MyPlanetHeader^.PName;
      repeat
         XProjectID:=succ(random(42));
      until (XProjectID in [25,28..42]) and (ActPProject^[XProjectID]>0);
      ActPProject^[XProjectID]:=0;
      Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]+(Save.ProjectCosts[CivVar,XProjectID] div 29);
   end;
   FINDMONEYPLANET:=XProjectID;
end;



procedure REFRESHSHIPS(ShipPtr :ptr; SysID,Mode :byte);

var ActShipPtr,BehindShipPtr,UseShipPtr :^r_ShipHeader;
var CivVar,CivVar2,i                    :byte;

begin
   ActShipPtr:=ShipPtr;
   if ActShipPtr=NIL then exit;
   repeat
      CivVar:=GETCIVVAR(ActShipPtr^.Owner);
      while not (ActShipPtr^.SType in [8..24,SHIPTYPE_FLEET,TARGET_STARGATE])
      or not (CivVar in [1..MAXCIVS]) or (ActShipPtr^.Owner=0)
      or ((ActShipPtr^.Age>=200) and (ActShipPtr^.Fracht=0) and (ActShipPtr^.Ladung=0)
          and (ActShipPtr^.SType<>SHIPTYPE_FLEET)) do begin
         if (CivVar>0) and (ActShipPtr^.Age>=200) then Verschrottung[CivVar]:=Verschrottung[CivVar]+1;
         BehindShipPtr:=ActShipPtr^.NextShip;

         ActShipPtr^.BeforeShip^.NextShip:=ActShipPtr^.NextShip;
         if ActShipPtr^.NextShip<>NIL then ActShipPtr^.NextShip^.BeforeShip:=ActShipPtr^.BeforeShip;

         FreeMem(long(ActShipPtr),sizeof(r_ShipHeader));
         ActShipPtr:=BehindShipPtr;
         if ActShipPtr=NIL then exit;
         CivVar:=GETCIVVAR(ActShipPtr^.Owner);
      end;
      if ActShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=ActShipPtr^.TargetShip
      else UseShipPtr:=ActShipPtr;
      with UseShipPtr^ do begin
         if Mode=0 then begin
            ActShipPtr^.PosX:=0; ActShipPtr^.PosY:=0;
         end;
         if (Mode=1) and (ActShipPtr^.NextShip<>NIL) then begin
            CivVar2:=GETCIVVAR(ActShipPtr^.NextShip^.Owner);
            if (CivVar2>0) and (Moving>0) and (NextShip^.Moving>0) then begin
               if Save.WarState[CivVar,CivVar2]=LEVEL_UNKNOWN then Save.WarState[CivVar,CivVar2]:=LEVEL_PEACE;
               if Save.WarState[CivVar2,CivVar]=LEVEL_UNKNOWN then Save.WarState[CivVar2,CivVar]:=LEVEL_PEACE;
            end;
         end;
         if ActShipPtr^.Moving>=0 then begin
            SystemFlags[CivVar,SysID]:=SystemFlags[CivVar,SysID] or FLAG_KNOWN;
            for i:=1 to MAXCIVS do if Save.WarState[i,CivVar]=LEVEL_ALLIANZ
             then SystemFlags[i,SysID]:=SystemFlags[i,SysID] or FLAG_KNOWN;
            ActShipPtr^.Moving:=ShipData[SType].MaxMove;
         end;
         if Shield<ShipData[SType].MaxShield then begin
            if (Save.CivPlayer[GETCIVVAR(Owner)]<>0) and not Save.PlayMySelf and (Mode=1) then begin
               Shield:=Shield+Repair;
               if ActShipPtr^.Moving>0 then ActShipPtr^.Moving:=ActShipPtr^.Moving-Repair;
            end else begin
               Shield:=round(Shield*1.3)+1;
               ActShipPtr^.Moving:=round(ActShipPtr^.Moving*0.77);
            end;
         end;
         if ActShipPtr^.Owner=FLAG_MAQUES then MaquesShips:=MaquesShips+1;
      end;
      repeat
         if UseShipPtr^.Shield>ShipData[UseShipPtr^.SType].MaxShield
          then UseShipPtr^.Shield:=ShipData[UseShipPtr^.SType].MaxShield;
         if UseShipPtr^.Age<200 then UseShipPtr^.Age:=UseShipPtr^.Age+1
         else if UseShipPtr^.Moving>2 then UseShipPtr^.Moving:=ActShipPtr^.Moving div 2;
         Save.WarPower[CivVar]:=Save.WarPower[CivVar]+round(ShipData[UseShipPtr^.SType].WeaponPower*(UseShipPtr^.Weapon/10+1));
         Save.Bevölkerung[CivVar]:=Save.Bevölkerung[CivVar]+1;
         Save.Staatstopf[CivVar]:=Save.Staatstopf[CivVar]-(UseShipPtr^.SType*14);
         Militärausgaben[CivVar]:=Militärausgaben[CivVar]+(UseShipPtr^.SType*14);
         if ActShipPtr^.SType=SHIPTYPE_FLEET then UseShipPtr:=UseShipPtr^.NextShip;
      until (ActShipPtr^.SType<>SHIPTYPE_FLEET) or (UseShipPtr=NIL);
      if ActShipPtr^.NextShip<>NIL then
       if ActShipPtr^.NextShip^.BeforeShip<>ActShipPtr then ActShipPtr^.NextShip:=NIL;
      ActShipPtr:=ActShipPtr^.NextShip;
   until ActShipPtr=NIL;
end;



function GOTONEXTPLANET(ActSys :byte; MyShipPtr :ShipHeader):byte;

var btx,CivVar,CivFlag          :byte;
var MyPlanetHeader              :^r_PlanetHeader;
var OtherShipPtr                :^r_ShipHeader;
var k,DistOld,DistNew           :integer;

begin
   GOTONEXTPLANET:=ActSys;
   if FINDMAQUESSHIP(ActSys,MyShipPtr) then exit;
   CivVar:=GETCIVVAR(MyShipPtr^.Owner);
   CivFlag:=MyShipPtr^.Owner and FLAG_CIV_MASK;
   btx:=0;
   DistOld:=10000;
   for k:=0 to pred(SystemHeader[ActSys].Planets) do begin
      MyPlanetHeader:=ptr(SystemHeader[ActSys].PlanetMemA+k*sizeof(r_PlanetHeader));
      OtherShipPtr:=MyPlanetHeader^.FirstShip.NextShip;
      while (OtherShipPtr<>NIL) and (OtherShipPtr^.Owner=0) do OtherShipPtr:=OtherShipPtr^.NextShip;
      if (MyPlanetHeader^.Class in [CLASS_DESERT,CLASS_HALFEARTH,
                                    CLASS_EARTH,CLASS_ICE,
                                    CLASS_STONES,CLASS_WATER])
       and (MyPlanetHeader^.PFlags=0) and (OtherShipPtr=NIL) then begin
         DistNew:=round(abs(MyPlanetHeader^.PosX-MyShipPtr^.PosX));
         if round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY))>DistNew then DistNew:=round(abs(MyPlanetHeader^.PosY-MyShipPtr^.PosY));
         if DistNew<DistOld then begin
            DistOld:=DistNew;
            btx:=k+1;
            MyShipPtr^.Target:=k+1;
            MyShipPtr^.Source:=ActSys;
         end;
      end;
   end;
   if btx<>0 then LINKSHIP(MyShipPtr,^SystemHeader[ActSys].FirstShip,1)
   else begin
      SystemHeader[ActSys].State:=SystemHeader[ActSys].State or STATE_ALL_OCC;
      GOTONEXTPLANET:=GOTONEXTSYSTEM(ActSys,MyShipPtr);
   end
end;



procedure CREATEPANIC(PPtr :ptr; ActSys,PlanetNum :byte);

var ActPProjects        :^ByteArr42;
var MyPlanetHeader      :^r_PlanetHeader;
var OldPlanet           :r_PlanetHeader;
var TheProject          :short;
var s1,s2               :string;
var i,k,NewEthnoFlag    :byte;
var ModC,ModL,l         :long;
var PlanetLose,b        :boolean;
var MyShipPtr           :ShipHeader;


function SETNEWPLANETOWNER:boolean;

begin
   SETNEWPLANETOWNER:=false;
   with MyPlanetHeader^ do begin
      NewEthnoFlag:=0;
      if (PFlags and FLAG_CIV_MASK<>Ethno) then NewEthnoFlag:=Ethno
      else begin
         for i:=1 to MAXCIVS-2 do if (Save.ImperatorState[i]>2000)
         and not (Save.WarState[ActPlayer,i] in [LEVEL_UNKNOWN,LEVEL_DIED]) then
          NewEthnoFlag:=GETCIVFLAG(i);
         if NewEthnoFlag<>0 then begin
            repeat
               i:=random(MAXCIVS-2)+1;
            until (Save.ImperatorState[i]>2000)
            and not (Save.WarState[ActPlayer,i] in [LEVEL_UNKNOWN,LEVEL_DIED]);
            NewEthnoFlag:=GETCIVFLAG(i);
         end;
      end;
      if NewEthnoFlag=0 then exit;
      if GetPlanetSys[GETCIVVAR(NewEthnoFlag)]<>0 then exit;
      GetPlanet[GETCIVVAR(NewEthnoFlag)]:=MyPlanetHeader;
      GetPlanetSys[GETCIVVAR(NewEthnoFlag)]:=ActSys;
      OldPlanet:=MyPlanetHeader^;
      if (Save.CivPlayer[ActPlayer]<>0) then TheProject:=-1;
      s1:=PText[555];
      if PFlags and FLAG_CIV_MASK=ActPlayerFlag then s2:=PText[556];
      for i:=1 to pred(MAXCIVS) do
       if Save.WarState[i,GETCIVVAR(Ethno)]=LEVEL_DIED then Save.WarState[i,GETCIVVAR(Ethno)]:=LEVEL_PEACE;
      if Save.WarState[GETCIVVAR(PFlags),GETCIVVAR(Ethno)]=LEVEL_DIED then Save.WarState[GETCIVVAR(PFlags),GETCIVVAR(Ethno)]:=LEVEL_COLDWAR;
      PFlags:=NewEthnoFlag;
      MyShipPtr:=MyPlanetHeader^.FirstShip.NextShip;
      while MyShipPtr<>NIL do begin
         if MyShipPtr^.Owner<>0 then MyShipPtr^.Owner:=NewEthnoFlag;
         MyShipPtr:=MyShipPtr^.NextShip;
      end;
      Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+35;
      if PFlags and FLAG_CIV_MASK=ActPlayerFlag then s2:=PText[557];
      PlanetLose:=true;
   end;
   SETNEWPLANETOWNER:=true;
end;


begin
   PlanetLose:=false;
   ModC:=0;
   MyPlanetHeader:=PPtr;
   with MyPlanetHeader^ do begin
      ActPProjects:=ProjectPtr;
      TheProject:=0; s1:=''; s2:='';
      if (Year mod 10=0) and (odd(Year div 10)=odd(PlanetNum)) then begin
         s1:=PText[559];
         if ActPProjects^[41]=0 then begin
            if ActPProjects^[30]=0 then begin
               if (Population>5500) and (Save.TechCosts[ActPlayer,ProjectNeedsTech[30]]<=0)
               and (ProjectID<>30) then begin                      { RECYCLINGANLAGE }
                  TheProject:=30;
                  s1:=PText[560];
               end else exit;
            end else if ActPProjects^[32]=0 then begin
               if (Population>7000) and (Save.TechCosts[ActPlayer,ProjectNeedsTech[32]]<=0)
               and (ProjectID<>32) then TheProject:=32 else exit   { HYDROKRAFTWERK }
            end else if ActPProjects^[31]=0 then begin
               if (Population>9000) and (Save.TechCosts[ActPlayer,ProjectNeedsTech[31]]<=0)
               and (ProjectID<>31) then TheProject:=31 else exit   { FUSIONSKRAFTWERK }
            end else if ActPProjects^[42]=0 then begin
               if (Population>11500) and (Save.TechCosts[ActPlayer,ProjectNeedsTech[42]]<=0)
               and (ProjectID<>42) then begin
                  TheProject:=42;
                  s1:=PText[561];
               end else exit;
            end else exit;
         end else exit;
         INFORMUSER;
         ModC:=GETTHESOUND(4);
         ModL:=ModMemL[4];
      end else begin
         if (random(80)<>0) and (Warnung[ActPlayer]=0) then exit;
         Population:=round(Population*0.895);
         if Warnung[ActPlayer]<>0 then begin
            i:=random(20);
            if (i in [2,3]) then i:=0;
         end else i:=random(10);
         case i of
            0: if ActPProjects^[28]=0 then begin    {kontinentale Union}
                  TheProject:=28;  s1:=PText[562];
               end else exit;
            1: if ActPProjects^[29]=0 then begin    {globale Union}
                  TheProject:=29;  s1:=PText[563];
               end else exit;
            2: if Save.ProjectCosts[ActPlayer,4]<>0 then s1:=PText[564] else exit;
            3: s1:=PText[565];
            otherwise if (PFlags and FLAG_CIV_MASK<>Ethno) and (FirstShip.NextShip=NIL)
            and (GetPlanetSys[GETCIVVAR(Ethno)]=0) then begin
               if (Warnung[ActPlayer]<>0) and (random(10)<>0) then exit;
               GetPlanet[GETCIVVAR(Ethno)]:=MyPlanetHeader;
               GetPlanetSys[GETCIVVAR(Ethno)]:=ActSys;
               OldPlanet:=MyPlanetHeader^;
               if (Save.CivPlayer[ActPlayer]<>0) then TheProject:=-1;
               s1:=PText[566];
               if PFlags and FLAG_CIV_MASK=ActPlayerFlag then s2:=PText[567];
               for i:=1 to pred(MAXCIVS) do
                if Save.WarState[i,GETCIVVAR(Ethno)]=LEVEL_DIED then Save.WarState[i,GETCIVVAR(Ethno)]:=LEVEL_PEACE;
               if Save.WarState[GETCIVVAR(PFlags),GETCIVVAR(Ethno)]=LEVEL_DIED then Save.WarState[GETCIVVAR(PFlags),GETCIVVAR(Ethno)]:=LEVEL_COLDWAR;
               PFlags:=Ethno;
               if PFlags and FLAG_CIV_MASK=ActPlayerFlag then s2:=PText[568];
               PlanetLose:=true;
            end else if (Warnung[ActPlayer] in [1,2]) and (random(22)=0) then begin
               if not SETNEWPLANETOWNER then exit;
            end else if (Warnung[ActPlayer]=2) and (random(10)=0) then begin
               if not SETNEWPLANETOWNER then exit;
            end else exit;
         end;
      end;

      l:=GETCIVVAR(PFlags);
      if (Save.CivPlayer[GETCIVVAR(PFlags)]<>0) or (TheProject=-1) then begin
         INFORMUSER;
         if TheProject in [-1,28,29] then begin
            ModC:=GETTHESOUND(2);
            ModL:=ModMemL[2];
         end;
         MAKEBORDER(MyScreen[1]^,85,110,425,200,12,6,0);
         WRITE(256,161,12,1+16,MyScreen[1]^,3,s1);
         s:=PText[166]+': '+Save.SystemName[ActSys]; WRITE(256,117,PFlags and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
         s:=PText[167]+': '+PName;                   WRITE(256,137,PFlags and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
         if (TheProject>0) and (Save.TechCosts[ActPlayer,ProjectNeedsTech[TheProject]]<=0) then begin
            s:=PText[570]+' '+Project[TheProject];
            WRITE(256,178,12,1+16,MyScreen[1]^,3,s);
         end;
         if TheProject=-1 then WRITE(256,178,12,1+16,MyScreen[1]^,3,s2);

         if (Save.CivPlayer[GETCIVVAR(PFlags)]<>0) and (ActPlayer=GETCIVVAR(PFlags)) then begin
            MAKEBORDER(MyScreen[1]^,85,208,425,248,12,6,0);
            BltBitMapRastPort(^ImgBitMap7,Class*32,0,^MyScreen[1]^.RastPort,95,212,32,32,192);
            for k:=1 to 2 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,k*140,218);
            WRITE(198,220,0,16,MyScreen[1]^,4,PText[167]);
            WRITE(338,220,0,16,MyScreen[1]^,4,PText[571]);
            b:=false;
            if not Save.PlayMySelf then repeat
               delay(RDELAY);
               if (LData^ and 64=0) and (IBase^.MouseY in [218..238]) then begin
                  if IBase^.MouseX in [140..256] then begin
                     KLICKGAD(140,218);
                     b:=true;
                     HANDLEKNOWNPLANET(ActSys,0,MyPlanetHeader);
                  end else if IBase^.MouseX in [280..396] then begin
                     KLICKGAD(280,218);   b:=true;
                  end;
               end;
            until b;
            if Save.PlayMySelf then delay(PAUSE);
            RECT(MyScreen[1]^,0,85,208,425,248);
         end else begin
            if Save.PlayMySelf then delay(PAUSE);
            WAITLOOP(Save.PlayMySelf);
         end;
         RECT(MyScreen[1]^,0,85,110,425,200);
         if PlanetLose then CHECKPROJECTS(^OldPlanet,MyPlanetHeader^.PFlags);
      end;
      if ModC<>0 then begin
         StopPlayer;
         FreeMem(ModC,ModL);
      end;
   end;
end;



procedure DECREASE(ActSys :byte; PPtr :ptr;);

var ModC                :long;
var MyPlanetHeader      :^r_PlanetHeader;

begin
   MyPlanetHeader:=PPtr;
   with MyPlanetHeader^ do begin
      INFORMUSER;
      ModC:=GETTHESOUND(4);
      MAKEBORDER(MyScreen[1]^,80,120,430,220,12,6,0);
      s:=PText[166]+': '+Save.SystemName[ActSys]; WRITE(256,127,PFlags and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
      s:=PText[167]+': '+PName;              WRITE(256,147,PFlags and FLAG_CIV_MASK,1+16,MyScreen[1]^,4,s);
      WRITE(256,170,12,16,MyScreen[1]^,4,PText[572]);
      WRITE(256,190,12,16,MyScreen[1]^,4,PText[573]);
      if Save.PlayMySelf then delay(PAUSE);
      WAITLOOP(Save.PlayMySelf);
      RECT(MyScreen[1]^,0,80,120,430,220);
      HANDLEKNOWNPLANET(ActSys,0,MyPlanetHeader);
      if ModC<>0 then begin
         StopPlayer;
         FreeMem(ModC,ModMemL[4]);
      end;
   end;
end;



procedure DOHUMANITY;

var Smallest,Biggest,i          :byte;
var SmallValue,BigValue         :long;
var Direction,Ende              :short;

begin
   Smallest:=1; Biggest:=1;
   SmallValue:=1000000000; BigValue:=0;
   if odd(Year) then begin
      i:=0; Ende:=(MAXCIVS-2); Direction:=1;
   end else begin
      i:=MAXCIVS; Ende:=1; Direction:=-1;
   end;
   repeat
      i:=i+Direction;
      if (Save.WarPower[i]>BigValue) and (Save.Bevölkerung[i]>0) then begin
         BigValue:=Save.WarPower[i];
         Biggest:=i;
      end;
      if (Save.WarPower[i]<SmallValue) and (Save.Bevölkerung[i]>1000) and
      ((Save.CivPlayer[i]=0) or Save.PlayMySelf) then begin
         SmallValue:=Save.WarPower[i];
         Smallest:=i;
      end;
   until i=Ende;
   if (Save.Bevölkerung[Smallest]>1000) and ((Save.CivPlayer[Smallest]=0) or Save.PlayMySelf)
    then begin
      Save.ImperatorState[Biggest]:=Save.ImperatorState[Biggest]+2;
      Save.Staatstopf[Biggest]:=Save.Staatstopf[Biggest]-(Save.WarPower[Biggest]*25);
      Save.Staatstopf[Smallest]:=Save.Staatstopf[Smallest]+(Save.WarPower[Biggest]*25);
   end;
   i:=GETCIVVAR(Save.WorldFlag);
   if i in [1..7] then if Save.Bevölkerung[Biggest]>Save.Bevölkerung[i]*3 then STOPCIVILWAR(0);
   if (Save.Bevölkerung[Biggest]>75000) and (random(255)=0) and (Save.WorldFlag=0)
    then CREATECIVILWAR(Biggest);
end;




begin { ROTATEPLANETS }
   if (Year>2000) and (ActPlayer=1) then DOHUMANITY;
   RECT(MyScreen[1]^,0,520,291,632,308);
   Valid:=false;
   if ActPlayer=1 then Year:=Year+1;
   FreeSystem:=false;
   if (Year mod 10=0) and not Save.PlayMySelf then INFORMUSER;
   AllCreative[ActPlayer]:=0;
   for j:=1 to 7 do if Save.ProjectCosts[ActPlayer,j]<=0 then
    if Year>0 then Save.ProjectCosts[ActPlayer,j]:=50*Year*j else Save.ProjectCosts[ActPlayer,j]:=180000*j;
   vNS:=true;
   if ActPlayer=1 then begin
      MaquesShips:=0;
      for i:=1 to MAXCIVS do begin
         Save.WarPower[i]:=0;
         Save.Bevölkerung[i]:=0;
         Militärausgaben[i]:=0;
      end;
   end;
   for i:=1 to Save.SYSTEMS do if (Save.ProjectCosts[ActPlayer,39]<=0) and vNS
   and (SystemHeader[i].vNS<>FLAG_KNOWN) and (random(5)=0) then begin
      SystemHeader[i].vNS:=FLAG_KNOWN;
      vNS:=false;
   end;
   for i:=1 to Save.SYSTEMS do if SystemHeader[i].Planets>0 then begin
      if ActPlayer=1 then for j:=1 to MAXCIVS do SystemFlags[j,i]:=SystemFlags[j,i] and FLAG_CIV_MASK;
      if (ActPlayer=1) and (SystemHeader[i].FirstShip.SType=TARGET_STARGATE) then with SystemHeader[i] do begin
         FromX:=FirstShip.PosX;
         FromY:=FirstShip.PosY;
         j:=round((SQRT(FirstShip.PosX*FirstShip.PosX+FirstShip.PosY*FirstShip.PosY)-1)/3);
         d:=1/((j*3)+1);
         sin_rot:=sin(d);  cos_rot:=cos(d);
         FirstShip.PosX:=round(FirstShip.PosX * cos_rot - FirstShip.PosY*sin_rot);
         FirstShip.PosY:=round(FirstShip.PosX * sin_rot + FirstShip.PosY*cos_rot*(1+d*d));
         MyShipPtr:=^SystemHeader[i].FirstShip;
         if FINDOBJECT(i,256+(FirstShip.PosX+OffsetX)*32,256+(FirstShip.PosY+OffsetY)*32,MyShipPtr) then begin
            FirstShip.PosX:=FromX;
            FirstShip.PosY:=FromY;
         end;
         if FirstShip.PosY=0 then begin
            if FirstShip.PosX>0 then FirstShip.PosX:=FirstShip.PosX-1;
            if FirstShip.PosX<0 then FirstShip.PosX:=FirstShip.PosX+1;
         end;
         if (FirstShip.PosX in [-3..2]) and (FirstShip.PosY in [-3..2]) then begin
            MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
            s:=PText[166]+': '+Save.SystemName[i];
            WRITE(256,131,12,16,MyScreen[1]^,4,s);
            WRITE(256,151,12,16,MyScreen[1]^,4,PText[575]);
            WRITE(256,171,12,16,MyScreen[1]^,4,PText[576]);
            if Save.PlayMySelf then delay(PAUSE);
            WAITLOOP(Save.PlayMySelf);
            RECT(MyScreen[1]^,0,85,120,425,200);
            FirstShip.SType:=0;
         end;
      end;
      if ActPlayer=1 then REFRESHSHIPS(SystemHeader[i].FirstShip.NextShip,i,1);
      if ActPlayer<MAXCIVS then for j:=1 to SystemHeader[i].Planets do begin
         PlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         if PlanetHeader<>NIL then with PlanetHeader^ do begin
            if (Ethno=FLAG_OTHER) and (Save.WorldFlag<>WFLAG_JAHADR) then Ethno:=PFlags and FLAG_CIV_MASK;
            if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) then begin
               if (ProjectPtr<>NIL) and (PFlags and FLAG_CIV_MASK<>0) then begin
                  ActPProjects:=ProjectPtr;
                  for k:=1 to 7 do if ActPProjects^[k]>0 then Save.ProjectCosts[GETCIVVAR(PFlags),k]:=0;
               end;
               CREATEPANIC(PlanetHeader,i,j);
            end;
            if ActPlayer=1 then begin
               { Bevölkerungswachstum }
               CivVar:=GETCIVVAR(PFlags);
               if (CivVar=0) and (Infrastruktur>0) then Infrastruktur:=abs(Infrastruktur-random(7));
               if (CivVar=0) and (Industrie>0) then Industrie:=abs(Industrie-random(7));
               if (CivVar in [1..MAXCIVS]) and (ProjectPtr<>NIL) then begin
                  ActPProjects:=ProjectPtr;
                  if ((Class=CLASS_EARTH)     and (Population div 1176<=Size))
                  or ((Class=CLASS_HALFEARTH) and (Population div  991<=Size))
                  or ((Class=CLASS_ICE)       and (Population div  743<=Size))
                  or ((Class=CLASS_WATER)     and (Population div  745<=Size))
                  or ((Class=CLASS_STONES)    and (Population div  929<=Size))
                  or ((Class=CLASS_DESERT)    and (Population div  739<=Size)) then begin
                     Population:=Population+1+(ActPProjects^[41]+ActPProjects^[42])*20;
                     Population:=round(Population*1.008);
                     if Save.ProjectCosts[CivVar,3]=0 then Population:=round(Population*1.028);
                     if Save.ProjectCosts[CivVar,4]=0 then Population:=round(Population*1.029);
                     if Population<1000 then Population:=round(Population*1.05);
                     if Population<2000 then Population:=round(Population*1.009);
                     if Population<3000 then Population:=round(Population*1.005);
                     if Population<0 then Population:=0;
                  end;
                  Save.Bevölkerung[CivVar]:=Save.Bevölkerung[CivVar]+Population;
               end else if ProjectPtr=NIL then ProjectPtr:=ptr(AllocMem(sizeof(ByteArr42),MEMF_CLEAR));
               if (Class=CLASS_PHANTOM) and (PlanetHeader^.FirstShip.NextShip<>NIL) then PlanetHeader^.FirstShip.NextShip^.Owner:=0;
               REFRESHSHIPS(FirstShip.NextShip,i,0);
               d:=1/((j*3)+1);
               sin_rot:=sin(d);  cos_rot:=cos(d);
               PosX:=PosX * cos_rot - PosY*sin_rot;
               PosY:=PosX * sin_rot + PosY*cos_rot*(1+d*d);
               if round(PosX)=round(PosY) then PosX:=round(PosY);
               if Population=0 then begin
                  PFlags:=0;   Ethno:=0;
               end;
            end;
         end;
      end;
   end;
   if ActSys>0 then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   if ActPlayer<MAXCIVS then for i:=1 to Save.SYSTEMS do if SystemHeader[i].Planets>0 then begin
      for j:=1 to MAXCIVS do SystemOwn[j]:=0;
      for j:=1 to SystemHeader[i].Planets do begin
         PlanetHeader:=ptr(SystemHeader[i].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         with PlanetHeader^ do begin
            CivVar:=GETCIVVAR(PlanetHeader^.PFlags);
            if CivVar in [1..MAXCIVS] then SystemOwn[CivVar]:=SystemOwn[CivVar]+Population;
            if (PlanetHeader^.PFlags and FLAG_CIV_MASK in [0,ActPlayerFlag])
            and (PlanetHeader^.Class in [CLASS_WATER,CLASS_ICE,CLASS_EARTH,
            CLASS_HALFEARTH,CLASS_DESERT]) then begin
               b:=false;
               if (Water div Size>80) and not (Class in [CLASS_WATER,CLASS_ICE]) then begin
                  Class:=CLASS_WATER; b:=true;
               end else if (Water div Size in [55..80]) and (Class<>CLASS_EARTH) then begin
                  Class:=CLASS_EARTH; b:=true;
               end else if (Water div Size in [21..54]) and not (Class in [CLASS_HALFEARTH,CLASS_STONES]) then begin
                  Class:=CLASS_HALFEARTH; b:=true;
               end else if (Water div Size<21) and (Class<>CLASS_DESERT) then begin
                  Class:=CLASS_DESERT; b:=true;
               end;
               if b and (PlanetHeader^.PFlags and FLAG_CIV_MASK=ActPlayerFlag)
               and (Save.CivPlayer[ActPlayer]<>0) and (Year>1900) then begin
                  INFORMUSER;
                  MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                  s:=PText[166]+': '+Save.SystemName[i]; WRITE(256,127,ActPlayerFlag,1+16,MyScreen[1]^,4,s);
                  s:=PText[167]+': '+PName;         WRITE(256,147,ActPlayerFlag,1+16,MyScreen[1]^,4,s);
                  s:=PText[578]+' ';
                  case Class of
                     CLASS_DESERT    : s:=s+'D';
                     CLASS_HALFEARTH : s:=s+'H';
                     CLASS_EARTH     : s:=s+'M';
                     CLASS_WATER     : s:=s+'W';
                     otherwise;
                  end;
                  WRITE(256,173,12,1+16,MyScreen[1]^,4,s);
                  if Save.PlayMySelf then delay(PAUSE);
                  WAITLOOP(Save.PlayMySelf);
                  RECT(MyScreen[1]^,0,85,120,425,200);
                  REFRESHDISPLAY;
               end;
            end;
            if PFlags and FLAG_CIV_MASK=ActPlayerFlag then begin
               if (ProjectID in [1..7,39]) and (Save.ProjectCosts[ActPlayer,ProjectID]<=0) then begin
                  if (ProjectID=39) and (Save.ProjectCosts[ActPlayer,39]>0) then
                   for k:=1 to MAXCIVS do if k<>ActPlayer then vNSonde[k]:=true;
                  if (Save.CivPlayer[GETCIVVAR(PFlags)]<>0) and not Save.PlayMySelf
                  then begin
                     INFORMUSER;
                     HANDLEKNOWNPLANET(i,1,PlanetHeader)
                  end else ProjectID:=0;
               end;
               ActPProjects:=ProjectPtr;
               if ActPProjects^[34] in [1..99] then ActPProjects^[34]:=round(ActPPRojects^[34]*1.2)+1;
               if ActPProjects^[40] in [1..99] then ActPProjects^[40]:=round(ActPPRojects^[40]*1.2)+1;

               SystemFlags[ActPlayer,i]:=SystemFlags[ActPlayer,i] or FLAG_KNOWN;

               PProd:=11+(ActPProjects^[31]+ActPProjects^[37]
                        +ActPProjects^[38]+ActPProjects^[41]
                        +ActPProjects^[42])*6;

               PCreativity:=20+(ActPProjects^[33]+ActPProjects^[35]+ActPProjects^[36]+
                                ActPProjects^[38]+ActPProjects^[42])*10;
               AllCreative[ActPlayer]:=AllCreative[ActPlayer]+round(PCreativity*(Biosphäre/80+Population/400))+1;
               if ActPProjects^[41]=0 then begin       { Keine MICROIDEN, Biosphären-Abbau }
                  l:=4+(ActPProjects^[30]+               { Recycling-Anl. }
                        ActPProjects^[31]+               { Fusions-Kraftwerk }
                        ActPProjects^[32]+               { Hydro-Kraftwerk }
                        ActPProjects^[37]+               { intell. Fabrik }
                        ActPProjects^[42])*2;            { Wetter-Sat }
                  if (Biosphäre>0) and (random(l)=0) then Biosphäre:=Biosphäre-2;
                  if (Biosphäre in [0..127]) and (Population>30) then begin          { Biosphäre<73%,
                                                         Infra-,Industrie- und
                                                         Bevölkerungsabbau}
                     if random(8)=0 then begin
                        if Infrastruktur>1 then Infrastruktur:=Infrastruktur-2;
                        if Industrie>1 then Industrie:=Industrie-2;
                     end;
                     Population:=round(Population*0.95);
                     if (ProjectID<>-3) and (Save.CivPlayer[GETCIVVAR(PFlags)]<>0)
                     and not Save.PlayMySelf then DECREASE(i,PlanetHeader);
                  end;
                  if (random(20)=0) and (Infrastruktur>1) then Infrastruktur:=Infrastruktur-1;
                  if (random(20)=0) and (Industrie>1) then Industrie:=Industrie-1;
               end else begin
                  Biosphäre:=Biosphäre+2;         if Biosphäre>200 then Biosphäre:=200;
                  Infrastruktur:=Infrastruktur+3; if Infrastruktur>200 then Infrastruktur:=200;
                  Industrie:=Industrie+2;         if Industrie>200 then Industrie:=200;
               end;
               l:=0;
               if ((Save.CivPlayer[ActPlayer]=0) or Save.PlayMySelf) and (ProjectID=0) then ProjectID:=-1;
               if ProjectID<>0 then begin
                  l:=0;
                  if ProjectID<0 then begin
                     case ProjectID of
                        -3: begin
                               Biosphäre:=Biosphäre+9;
                               if Biosphäre>200 then begin
                                  l:=1; Biosphäre:=200;
                               end;
                            end;
                        -2: begin
                               Infrastruktur:=Infrastruktur+9;
                               if Infrastruktur>200 then begin
                                  l:=1; Infrastruktur:=200;
                               end;
                            end;
                        otherwise begin
                               Industrie:=Industrie+9;
                               if Industrie>200 then begin
                                  l:=1; Industrie:=200;
                               end;
                        end;
                     end;
                  end else begin
                     PMoney:=round(PProd*(Infrastruktur/17+Industrie/17+Population/17))+1;
                     while PMoney>MAXPMONEY do PMoney:=round(PMoney*0.95);
                     if Save.CivPlayer[ActPlayer]<>0
                      then PMoney:=round(PMoney*(100-Save.JSteuer[ActPlayer]-Save.GSteuer[ActPlayer]-Save.SService[ActPlayer])/100)
                     else PMoney:=round(PMoney*(100-Save.JSteuer[ActPlayer]-Save.GSteuer[ActPlayer])/100);
                     XProjectPayed:=XProjectPayed+PMoney;

                     {*** Überschüssige Finanzen für Planeten ausgeben ***}
                     if (Save.Staatstopf[ActPlayer]>XProjectCosts*10) and
                     (Save.GSteuer[ActPlayer]<=2) and
                     ((Save.CivPlayer[ActPlayer]=0) or Save.PlayMySelf)
                     then begin
                        Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-(XProjectCosts-XProjectPayed);
                        XProjectPayed:=XProjectCosts;
                     end;
                     if random(100)<50 then if ((Save.CivPlayer[ActPlayer]=0) or (Save.PlayMySelf))
                     and (XProjectCosts>XProjectPayed) and (Save.GSteuer[ActPlayer]<15)
                     and (Save.Staatstopf[ActPlayer]>3000) then begin
                        if ((Save.Staatstopf[ActPlayer]*0.7)>Militärausgaben[ActPlayer]*15) then begin
                           XProjectPayed:=round(XProjectPayed+(Save.Staatstopf[ActPlayer]*0.3));
                           Save.Staatstopf[ActPlayer]:=round(Save.Staatstopf[ActPlayer]*0.7);
                        end else if ((Save.Staatstopf[ActPlayer]*0.85)>Militärausgaben[ActPlayer]*9) then begin
                           XProjectPayed:=round(XProjectPayed+(Save.Staatstopf[ActPlayer]*0.15));
                           Save.Staatstopf[ActPlayer]:=round(Save.Staatstopf[ActPlayer]*0.85);
                        end else if ((Save.Staatstopf[ActPlayer]*0.9)>Militärausgaben[ActPlayer]*8) then begin
                           XProjectPayed:=round(XProjectPayed+(Save.Staatstopf[ActPlayer]*0.1));
                           Save.Staatstopf[ActPlayer]:=round(Save.Staatstopf[ActPlayer]*0.9);
                        end else if (Save.Staatstopf[ActPlayer]>Militärausgaben[ActPlayer]*7)
                        and (Year>0) then begin
                           XProjectPayed:=XProjectPayed+Year*2;
                           Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-Year*2;
                        end;
                     end;

                     if (PFlags and FLAG_CIV_MASK=FLAG_OTHER) and (ProjectID=7) then ProjectID:=0;
                  end;
                  if (ProjectID>0) and (abs(XProjectPayed)>XProjectCosts) then begin
                     XProjectPayed:=XProjectPayed-XProjectCosts;
                     ActPProjects:=ProjectPtr;
                     if ProjectID in [34,40] then ActPPRojects^[ProjectID]:=100
                     else if ProjectID in [1..7,25..38,40..42] then ActPProjects^[ProjectID]:=ActPProjects^[ProjectID]+1
                     else if ProjectID in [8..24] then begin
                        if MaquesShips<MAXMAQUES then if CREATEMAQUESSHIP(i,ProjectID) then begin end;
                        l:=AllocMem(sizeof(r_ShipHeader),MEMF_CLEAR);
                        ActShipPtr:=ptr(l);
                        ActShipPtr^:=r_ShipHeader(0,ProjectID,PFlags and FLAG_CIV_MASK,0,0,0,0,0,0,
                                                  ShipData[ProjectID].MaxShield,1,1,
                                                  ShipData[ProjectID].MaxMove,0,0,0,NIL,NIL,NIL);
                                                 {Age,SType,Owner,Flags,ShieldBonus,Ladung,Fracht,PosX,PosY,
                                                  Shield,Weapon,Repair
                                                  Moving,Source,Target,Tactical,TargetShip,BeforeShip,NextShip}
                        with ActShipPtr^ do begin
                           Weapon:=WEAPON_GUN;
                           if Save.TechCosts[ActPlayer,15]<=0 then Weapon:=WEAPON_LASER;
                           if Save.TechCosts[ActPlayer,24]<=0 then Weapon:=WEAPON_PHASER;
                           if Save.TechCosts[ActPlayer,32]<=0 then Weapon:=WEAPON_DISRUPTOR;
                           if Save.TechCosts[ActPlayer,27]<=0 then Weapon:=WEAPON_PTORPEDO;
                        end;
                        if (ProjectID=21) and (SystemHeader[i].FirstShip.SType=0)
                        and ((Save.CivPlayer[GETCIVVAR(ActShipPtr^.Owner)]=0) or Save.PlayMySelf) then begin
                           ActShipPtr^.PosX:=round(PosX);
                           ActShipPtr^.PosY:=round(PosY);
                           LINKSHIP(ActShipPtr,^SystemHeader[i].FirstShip,0);
                        end else LINKSHIP(ActShipPtr,^PlanetHeader^.FirstShip,0);
                     end;
                     if ProjectID in [1..7,39] then Save.ProjectCosts[ActPlayer,ProjectID]:=0;
                     l:=1;
                  end;
                  if l=1 then begin
                     if ProjectID in [1..7] then begin
                        Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+150;
                        if Save.stProject[ProjectID]=0 then begin
                           INFORMUSER;
                           Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+50;
                           Save.stProject[ProjectID]:=ActPlayer;
                           MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                           s:=GETCIVNAME(ActPlayer)+' '+PText[579];
                           WRITE(256,127,GETCIVFLAG(ActPlayer),1+16,MyScreen[1]^,4,s);
                           s:=Project[ProjectID]+'-';
                           WRITE(256,149,12,1+16,MyScreen[1]^,4,s);
                           s:=PText[580];
                           if ProjectID in [1..3] then s:=PText[582]+' '+s;
                           WRITE(256,173,12,1+16,MyScreen[1]^,4,s);
                           if Save.PlayMySelf then delay(PAUSE);
                           WAITLOOP(Save.PlayMySelf);
                           Rect(MyScreen[1]^,0,85,120,425,200);
                        end;
                     end else if ProjectID in [8..24] then begin
                        if Save.CivPlayer[ActPlayer]<>0 then begin
                           btx:=1; XState:=0; Fight:=0;
                           for k:=1 to 6 do begin
                              if (Save.Military[ActPlayer] and btx=btx) then begin
                                 XState:=XState+i;
                                 Fight:=Fight+8;
                              end;
                              btx:=btx*2;
                           end;
                           Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]-XState;
                           ActShipPtr^.ShieldBonus:=Fight;
                        end else ActShipPtr^.ShieldBonus:=round(Level*2-2);
                     end else if ProjectID in [26,28..42] then Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+10;
                     if ProjectID in [26,27] then Population:=Population-10;
                  end;
                  if (l=1) and (Save.CivPlayer[ActPlayer]<>0) then begin
                     INFORMUSER;
                     MAKEBORDER(MyScreen[1]^,85,120,425,200,12,6,0);
                     s:=PText[166]+': '+Save.SystemName[i]; WRITE(256,127,ActPlayerFlag,1+16,MyScreen[1]^,4,s);
                     s:=PText[167]+': '+PName;              WRITE(256,147,ActPlayerFlag,1+16,MyScreen[1]^,4,s);
                     if ProjectID>0 then s:=PText[583]+' '+Project[ProjectID]
                     else case ProjectID of
                        -3: s:=PText[584];
                        -2: s:=PText[585];
                        otherwise s:=PText[586];
                     end;
                     WRITE(256,173,12,1+16,MyScreen[1]^,4,s);
                     delay(5);
                     if (ProjectID in [8..24]) and not Save.PlayMySelf then begin
                        MAKEBORDER(MyScreen[1]^,85,208,425,248,12,6,0);
                        BltBitMapRastPort(^ImgBitMap4,(ProjectID-8)*32,32,^MyScreen[1]^.RastPort,95,212,32,32,192);
                        for k:=1 to 2 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,k*140,218);
                        WRITE(198,220,0,16,MyScreen[1]^,4,PText[587]);
                        WRITE(338,220,0,16,MyScreen[1]^,4,PText[588]);
                        b:=false;
                        repeat
                           delay(RDELAY);
                           if (LData^ and 64=0) then begin
                              if IBase^.MouseY in [218..238] then begin
                                 if IBase^.MouseX in [140..256] then begin
                                    KLICKGAD(140,218);
                                    b:=true;
                                    ActShipPtr^.PosX:=round(PlanetHeader^.PosX);
                                    ActShipPtr^.PosY:=round(PlanetHeader^.PosY);
                                    LINKSHIP(ActShipPtr,^SystemHeader[i].FirstShip,1);
                                 end else if IBase^.MouseX in [280..396] then begin
                                    KLICKGAD(280,218);   b:=true;
                                 end;
                              end;
                           end;
                        until b;
                        RECT(MyScreen[1]^,0,85,208,425,248);
                     end else begin
                        if Save.PlayMySelf then delay(PAUSE);
                        WAITLOOP(Save.PlayMySelf);
                     end;
                     RECT(MyScreen[1]^,0,85,120,425,200);
                     REFRESHDISPLAY;
                     if not (ProjectID in [8..24,26,27]) then ProjectID:=0;
                     if not Save.PlayMySelf then HANDLEKNOWNPLANET(i,1,PlanetHeader);
                  end;
                  if ((l=1) or (ProjectID in [-3..0])) and ((Save.CivPlayer[ActPlayer]=0) or Save.PlayMySelf) then begin
                     ProjectID:=0;
                     for k:=8 to 24 do
                     if (Save.TechCosts[ActPlayer,ProjectNeedsTech[k]]<=0)
                     and (ActPProjects^[ProjectNeedsProject[k]]>0) then begin
                        if ((k=21) and (ProjectID<18)) or
                        ((k>21) and (SystemHeader[i].FirstShip.SType and TARGET_STARGATE=TARGET_STARGATE))
                        or (k<=21) then ProjectID:=k;
                        if (ProjectID in [8,9]) and (Save.WarPower[ActPlayer]>40) then ProjectID:=0;
                     end;
                     if (ActPlayer=8) and (Save.WarPower[8]>8000) then ProjectID:=0;
                        {*** DCON`s begrenzen ***}
                     if PlanetHeader^.FirstShip.NextShip<>NIL then
                     if PlanetHeader^.FirstShip.NextShip^.NextShip<>NIL then begin
                        MyShipPtr:=PlanetHeader^.FirstShip.NextShip^.NextShip;
                        if (Save.WarState[ActPlayer,1] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,2] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,3] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,4] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,5] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,6] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,7] in [LEVEL_WAR,LEVEL_COLDWAR]) or
                           (Save.WarState[ActPlayer,8] in [LEVEL_WAR,LEVEL_COLDWAR]) then begin
                        { Krieg mit anderer Zivi }
                           if ActPProjects^[27]<1 then ProjectID:=27;
                           while (MyShipPtr<>NIL) and (MyShipPtr^.NextShip<>NIL) do begin
                              if (MyShipPtr^.Ladung and MASK_LTRUPPS=0) and (ActPPRojects^[27]>0) and
                              (ShipData[MyShipPtr^.SType].MaxLoad>(MyShipPtr^.Ladung and MASK_SIEDLER) div 16
                              + (MyShipPtr^.Ladung and MASK_LTRUPPS)) then begin
                                 ActPProjects^[27]:=ActPProjects^[27]-1;
                                 MyShipPtr^.Ladung:=MyShipPtr^.Ladung+1;
                              end;
                              ActShipPtr:=MyShipPtr^.NextShip;
                              MyShipPtr^.PosX:=round(PlanetHeader^.PosX);
                              MyShipPtr^.PosY:=round(PlanetHeader^.PosY);
                              LINKSHIP(MyShipPtr,^SystemHeader[i].FirstShip,1);
                              FINDENEMYOBJECT(i,MyShipPtr);
                              MyShipPtr:=ActShipPtr;
                           end;
                        end else if (SystemHeader[i].State and STATE_TACTICAL<>STATE_ALL_OCC)
                        and (Save.GlobalFlags[ActPlayer]=GFLAG_EXPLORE) then begin
                        {*** Noch nicht alle Planeten des Systems besiedelt! ***}
                           if ActPProjects^[26]>=ShipData[MyShipPtr^.SType].MaxLoad then begin
                              for k:=1 to ShipData[MyShipPtr^.SType].MaxLoad do
                              if (ActPProjects^[26]>0) and
                               (ShipData[MyShipPtr^.SType].MaxLoad>(MyShipPtr^.Ladung and MASK_SIEDLER) div 16
                               +(MyShipPtr^.Ladung and MASK_LTRUPPS)) then begin
                                 ActPProjects^[26]:=ActPProjects^[26]-1;
                                 MyShipPtr^.Ladung:=MyShipPtr^.Ladung+16;
                              end;
                              MyShipPtr^.PosX:=round(PlanetHeader^.PosX);
                              MyShipPtr^.PosY:=round(PlanetHeader^.PosY);
                              l:=GOTONEXTPLANET(i,MyShipPtr);
                           end else ProjectID:=26;
                        end else if (SystemHeader[i].State and STATE_TACTICAL=STATE_ALL_OCC)
                        and (Save.GlobalFlags[ActPlayer]=GFLAG_EXPLORE) then begin
                        {*** Expedition in andere Galaxie ***}
                           if random(100)<15 then l:=2 else begin
                              if ActPProjects^[26]+ActPProjects^[27]>ShipData[MyShipPtr^.SType].MaxLoad then begin
                                 MyShipPtr^.PosX:=round(PlanetHeader^.PosX);
                                 MyShipPtr^.PosY:=round(PlanetHeader^.PosY);
                                 for k:=1 to ShipData[MyShipPtr^.SType].MaxLoad do begin
                                    if (ActPProjects^[26]>1) and (ShipData[MyShipPtr^.SType].MaxLoad
                                    >((MyShipPtr^.Ladung and MASK_SIEDLER) div 16)+(MyShipPtr^.Ladung and MASK_LTRUPPS)) then begin
                                       ActPProjects^[26]:=ActPProjects^[26]-1;
                                       MyShipPtr^.Ladung:=MyShipPtr^.Ladung+16;
                                    end;
                                    if (ActPProjects^[27]>1) and (ShipData[MyShipPtr^.SType].MaxLoad
                                    >((MyShipPtr^.Ladung and MASK_SIEDLER) div 16)+(MyShipPtr^.Ladung and MASK_LTRUPPS)) then begin
                                       ActPProjects^[27]:=ActPProjects^[27]-1;
                                       MyShipPtr^.Ladung:=MyShipPtr^.Ladung+1;
                                    end;
                                 end;
                                 l:=GOTONEXTSYSTEM(i,MyShipPtr);
                              end else begin
                                 if ActPProjects^[26]<ShipData[MyShipPtr^.SType].MaxLoad then ProjectID:=26;
                                 if ActPProjects^[27]<2 then ProjectID:=27 else ProjectID:=26;
                              end;
                           end;
                        end else if Save.GlobalFlags[ActPlayer]=GFLAG_ATTACK then begin
                        { Alles Besetzt, Krieg beginnen }
                           l:=0;
                           for k:=1 to pred(MAXCIVS) do if (k<>ActPlayer) and (Save.WarState[ActPlayer,k]=LEVEL_NO_ALLIANZ) then l:=k;
                           if l=0 then for k:=1 to pred(MAXCIVS) do if (k<>ActPlayer) and not (Save.WarState[ActPlayer,k] in [LEVEL_UNKNOWN,LEVEL_DIED]) then l:=k;
                           if l<>0 then Save.WarState[ActPlayer,l]:=LEVEL_COLDWAR;
                           l:=0;
                        end;
                        if FirstShip.NextShip<>NIL then
                        if (FirstShip.NextShip^.NextShip<>NIL) and (SystemHeader[i].State and STATE_TACTICAL=STATE_ALL_OCC)
                        and (ActPProjects^[26]=0) then begin
                           if ((Water div Size<55) and EXISTSPLANET(ActPlayer,i,1))
                           or ((Water div Size>56) and EXISTSPLANET(ActPlayer,i,2)) then begin
                              MyShipPtr:=PlanetHeader^.FirstShip.NextShip^.NextShip;
                              MyShipPtr^.PosX:=round(PlanetHeader^.PosX);
                              MyShipPtr^.PosY:=round(PlanetHeader^.PosY);
                              LINKSHIP(MyShipPtr,^SystemHeader[i].FirstShip,1);
                           end else if FirstShip.NextShip^.SType-FirstShip.NextShip^.NextShip^.SType>3 then
                            FirstShip.NextShip^.NextShip^.Owner:=0;
                        end;
                     end;
                     if (random(100)<35) then l:=2 else l:=0;
                     if (Year>2000) and (ProjectID in [8..24]) and (Save.WarPower[ActPlayer]<Year div 30) and (random(100)<65) then l:=0;
                      if (l=2) or (ProjectID=0) then begin
                        for k:=22 downto 1 do
                        if (Save.TechCosts[ActPlayer,ProjectNeedsTech[PriorityList[k]]]<=0)
                            { Technologie vorhanden }
                        and ((ActPProjects^[ProjectNeedsProject[PriorityList[k]]]>0)
                        or (Save.ProjectCosts[ActPlayer,ProjectNeedsProject[PriorityList[k]]]=0)) then begin
                               { evtl. nötiges Projekt vorhanden }
                            if ((PriorityList[k] in [1..7]) and (Save.ProjectCosts[ActPlayer,ProjectNeedsProject[PriorityList[k]]]=0)
                            and (Save.ProjectCosts[ActPlayer,PriorityList[k]]>0)) then ProjectID:=PriorityList[k];
                               { Großprojekt noch nicht gebaut }
                            if (PriorityList[k] in [25,28..42]) and (ActPProjects^[PriorityList[k]]=0)
                            then ProjectID:=PriorityList[k];
                               { Projekt noch nicht gebaut }
                        end;
                     end;
                     if Save.ProjectCosts[ActPlayer,1]>0 then ProjectID:=1;
                     if ProjectID=0 then begin
                        if Industrie<200 then ProjectID:=-1;
                        if Infrastruktur<200 then ProjectID:=-2;
                        if Biosphäre<200 then ProjectID:=-3;
                     end;
                     if ProjectID>0 then XProjectCosts:=Save.ProjectCosts[ActPlayer,ProjectID];
                  end;
                  if (Save.CivPlayer[ActPlayer]=0) or Save.PlayMySelf then begin
                     if Industrie<170 then ProjectID:=-1;
                     if Infrastruktur<170 then ProjectID:=-2;
                     if Biosphäre<170 then ProjectID:=-3;
                  end;
                  PMoney:=round(PProd*(Infrastruktur/17+Industrie/17+Population/17))+1;
                  while PMoney>MAXPMONEY do PMoney:=round(PMoney*0.95);
                  Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]+round(PMoney*Save.GSteuer[ActPlayer]/100);
                  if Save.WorldFlag=WFLAG_JAHADR
                   then Save.Staatstopf[8]:=Save.Staatstopf[8]+round(PMoney*Save.JSteuer[ActPlayer]/100);
                  {Steuerentrichtung}
               end else begin
                  PMoney:=round(PProd*(Infrastruktur/17+Industrie/17+Population/17))+1;
                  while PMoney>MAXPMONEY do PMoney:=round(PMoney*0.95);
                  Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]+round(PMoney/3);
                  if Save.WorldFlag=WFLAG_JAHADR
                   then Save.Staatstopf[8]:=Save.Staatstopf[8]+round(PMoney*Save.JSteuer[ActPlayer]/100);
                  {Steuerentrichtung}
                  {keine Produktion}
               end;
               if Save.CivPlayer[ActPlayer]<>0 then begin
                  repeat
                     k:=random(pred(MAXCIVS))+1;
                  until k<>ActPlayer;
                  if not (Save.WarState[ActPlayer,k] in [LEVEL_DIED,LEVEL_UNKNOWN]) then
                   Save.SSMoney[ActPlayer,k]:=Save.SSMoney[ActPlayer,k]+round(PMoney/100*Save.SService[ActPlayer]);
                  if (Year mod 5=0) and (random(200)=0) then Save.SSMoney[ActPlayer,k]:=0;
               end;
            end;
         end;
      end;
      l:=0;
      if SystemOwn[1]>0 then l:=FLAG_TERRA;
      if SystemOwn[2]>SystemOwn[1] then begin
         l:=FLAG_KLEGAN;
         SystemOwn[1]:=SystemOwn[2];
      end;
      if SystemOwn[3]>SystemOwn[1] then begin
         l:=FLAG_REMALO;
         SystemOwn[1]:=SystemOwn[3];
      end;
      if SystemOwn[4]>SystemOwn[1] then begin
         l:=FLAG_CARDAC;
         SystemOwn[1]:=SystemOwn[4];
      end;
      if SystemOwn[5]>SystemOwn[1] then begin
         l:=FLAG_FERAGI;
         SystemOwn[1]:=SystemOwn[5];
      end;
      if SystemOwn[6]>SystemOwn[1] then begin
         l:=FLAG_BAROJA;
         SystemOwn[1]:=SystemOwn[6];
      end;
      if SystemOwn[7]>SystemOwn[1] then begin
         l:=FLAG_VOLKAN;
         SystemOwn[1]:=SystemOwn[7]
      end;
      if SystemOwn[8]>SystemOwn[1] then l:=FLAG_OTHER;
      SystemFlags[1,i]:=(SystemFlags[1,i] and FLAG_KNOWN) or l;
      if SystemFlags[1,i] and FLAG_CIV_MASK=0 then FreeSystem:=true;
      if FreeSystem then SystemHeader[i].State:=SystemHeader[i].State and not STATE_ALL_OCC;
   end;
   if FreeSystem and not ((Save.WarState[ActPlayer,1]=LEVEL_WAR) or
   (Save.WarState[ActPlayer,2]=LEVEL_WAR) or (Save.WarState[ActPlayer,3]=LEVEL_WAR) or
   (Save.WarState[ActPlayer,4]=LEVEL_WAR) or (Save.WarState[ActPlayer,5]=LEVEL_WAR) or
   (Save.WarState[ActPlayer,6]=LEVEL_WAR) or (Save.WarState[ActPlayer,7]=LEVEL_WAR) or
   (Save.WarState[ActPlayer,8]=LEVEL_WAR)) then Save.GlobalFlags[ActPlayer]:=GFLAG_EXPLORE;
   Valid:=true;
   REFRESHDISPLAY;
   if ActPlayer=1 then if Year mod 50=0 then for i:=1 to pred(MAXCIVS) do
    if (Save.WarState[ActPlayer,i] in [LEVEL_ALLIANZ,LEVEL_NO_ALLIANZ]) then begin
      Save.WarState[i,ActPlayer]:=LEVEL_PEACE;
      Save.WarState[ActPlayer,i]:=LEVEL_PEACE;
   end;
   PRINTGLOBALINFOS(ActPlayer);
   if ((Year mod (18+ActPlayer)=0)
   or (not (Save.WorldFlag in [0,WFLAG_CEBORC,WFLAG_FIELD]) and (ActPlayer=8) and (Year mod 8=0)))
   and (Save.CivPlayer[ActPlayer]=0) then begin
      repeat
         i:=random(7)+1;
      until i<>ActPlayer;
      if not (Save.WarState[ActPlayer,i] in [LEVEL_DIED,LEVEL_UNKNOWN,LEVEL_ALLIANZ,LEVEL_WAR])
      and (Save.WarPower[i]<Save.WarPower[ActPlayer]) then Save.WarState[ActPlayer,i]:=LEVEL_COLDWAR;
   end;
   if (Year mod 18=0) and (Save.WarPower[2]>42) and (ActPlayer=2)
   and (Save.CivPlayer[ActPlayer]=0) then begin
      repeat
         i:=random(7)+1;
      until i<>2;
      if not (Save.WarState[2,i] in [LEVEL_DIED,LEVEL_UNKNOWN,LEVEL_ALLIANZ,LEVEL_WAR])
      then Save.WarState[2,i]:=LEVEL_COLDWAR;
   end;
   if (Year mod 17=0) and (Save.WarPower[4]>47) and (ActPlayer=4)
   and (Save.CivPlayer[ActPlayer]=0)  then begin
      repeat
         i:=random(7)+1;
      until i<>4;
      if not (Save.WarState[4,i] in [LEVEL_DIED,LEVEL_UNKNOWN,LEVEL_WAR])
      then Save.WarState[4,i]:=LEVEL_COLDWAR;
   end;

   if ActPlayer<MAXCIVS then if (Year>1901) or (Year<0) then begin
      if Save.ActTech[ActPlayer]<>0 then begin { Forschung }
         if AllCreative[ActPlayer]<0 then Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]:=0 else
         Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]:=Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]-AllCreative[ActPlayer];
         if Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]<=0 then begin
            Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]+50;
            if (Save.CivPlayer[ActPlayer]<>0) then begin
               INFORMUSER;
               DISPLAYTECH(Save.ActTech[ActPlayer],ActPlayer);
            end;
            Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]:=0;
         end;
      end;
      if (Save.CivPlayer[ActPlayer]=0) or Save.PlayMySelf then begin
         if Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]<=0 then begin
            Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]:=0;
            l:=Save.ActTech[ActPlayer];
            Save.ActTech[ActPlayer]:=0;
            repeat
               if l=0 then j:=3
               else if l=3 then j:=5
               else if l=5 then j:=11
               else if l=11 then j:=4
               else if l=4 then j:=16
               else j:=succ(random(42));
               if Save.TechCosts[ActPlayer,j]>0 then begin
                  if TechUse1[j]=0 then Save.ActTech[ActPlayer]:=j
                  else if ((Save.TechCosts[ActPlayer,TechUse1[j]]<=0) and (Save.TechCosts[ActPlayer,TechUse2[j]]<=0)) then
                  Save.ActTech[ActPlayer]:=j;
               end;
               l:=-1;
            until (Save.ActTech[ActPlayer]<>0) or (Save.TechCosts[ActPlayer,42]<=0);
         end;
         if (ActPlayer=8) and (Save.ActTech[ActPlayer]=42) then Save.ActTech[ActPlayer]:=0;
         if (Save.ActTech[ActPlayer]=42) and (Save.ProjectCosts[ActPlayer,6]>0) then Save.ActTech[ActPlayer]:=0;
      end else if (Save.ActTech[ActPlayer]=0) or (Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]]<=0) then begin
         Save.ActTech[ActPlayer]:=0;
         for j:=1 to 6 do NewTech[j]:=0;
         j:=1; i:=1;
         repeat
            if Save.TechCosts[ActPlayer,i]>0 then begin
               if TechUse1[i]=0 then begin
                  NewTech[j]:=i; j:=j+1;
               end else if ((Save.TechCosts[ActPlayer,TechUse1[i]]<=0) and (Save.TechCosts[ActPlayer,TechUse2[i]]<=0)) then begin
                 NewTech[j]:=i; j:=j+1;
               end;
            end;
            i:=i+1;
         until (i>42) or (j>6);
         if NewTech[1]<>0 then begin
            if (NewTech[1]=42) and (Save.ProjectCosts[ActPlayer,6]>0) then begin
               if Year mod 13=0 then begin
                  MAKEBORDER(MyScreen[1]^,100,100,410,180,12,6,0);
                  WRITE(256,110,ActPlayerFlag,0+16,MyScreen[1]^,4,PText[590]);
                  WRITE(256,132,ActPlayerFlag,0+16,MyScreen[1]^,4,PText[591]);
                  WRITE(256,154,12,0+16,MyScreen[1]^,4,PText[592]);
                  WAITLOOP(false);
                  RECT(MyScreen[1]^,0,100,100,410,180);
                  REFRESHDISPLAY;
               end;
            end;
            INFORMUSER;
            MAKEBORDER(MyScreen[1]^,60,100,368,267,12,6,0);
            WRITE(214,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[593]);
            for j:=1 to 6 do if NewTech[j]>0 then WRITE(70,j*20+120,12,0,MyScreen[1]^,4,TechnologyL[NewTech[j]]);
            i:=0;
            repeat
               delay(RDELAY);
               j:=(IBase^.MouseY-120) div 20;
               if (i<>j) and (j in [1..6]) then begin
                  i:=j;
                  for j:=1 to 6 do if NewTech[j]>0 then WRITE(70,j*20+120,12,0,MyScreen[1]^,4,TechnologyL[NewTech[j]]);
                  if NewTech[i]>0 then WRITE(70,i*20+120,ActPlayerFlag,0,MyScreen[1]^,4,TechnologyL[NewTech[i]]);
               end;
               if (LData^ and 64=0) then begin
                  PLAYSOUND(1,300);
                  if i>0 then if NewTech[i]>0 then Save.ActTech[ActPlayer]:=NewTech[i];
               end;
            until Save.ActTech[ActPlayer]>0;
            RECT(MyScreen[1]^,0,60,100,370,270);
            REFRESHDISPLAY;
         end;
      end;
      for i:=1 to pred(MAXCIVS) do begin
         if (ActPlayer=1) and ((i<8) or (Save.WorldFlag<>0)) then begin
            if Save.JSteuer[i]+Save.GSteuer[i]>100 then Save.GSteuer[i]:=100-Save.JSteuer[i];
            if Save.JSteuer[i]+Save.GSteuer[i]+Save.SService[i]>100 then Save.SService[i]:=0;
            if (Save.CivPlayer[i]=0) or Save.PlayMySelf then begin
               if ((Save.Staatstopf[i]<Militärausgaben[i]*7) or (Save.Staatstopf[i]<3000))
               and (Save.GSteuer[i]+Save.JSteuer[i]<90) then begin
                  Save.GSteuer[i]:=Save.GSteuer[i]+1;
                  if (Save.Staatstopf[i]<0) and (Save.GSteuer[i]+Save.JSteuer[i]+3<=100)
                   then Save.GSteuer[i]:=Save.GSteuer[i]+3;
               end else begin
                  if (Save.Staatstopf[i]>0) and (Save.GSteuer[i]>0) then Save.GSteuer[i]:=Save.GSteuer[i]-1;
                  if (Save.Staatstopf[i]>2500000) and (Save.GSteuer[i]>5) then Save.GSteuer[i]:=Save.GSteuer[i]-5;
               end;
               if (Save.Staatstopf[i]<-10000) and (Save.GSteuer[i]>20) then btx:=FINDMONEYPLANET(GETCIVFLAG(i),i);
               if (Save.Bevölkerung[i]<1000) and (Save.Staatstopf[i]<0) then Save.Staatstopf[i]:=0;
            end;
            for j:=1 to MAXCIVS do if (i<>j) and (Save.Bevölkerung[i]>Save.Bevölkerung[j]) then Save.ImperatorState[i]:=Save.ImperatorState[i]+2;
            if (Year mod 10=0) then DOINFLATION(i);
         end;
         if (Save.CivPlayer[i]=0) and (Save.CivPlayer[ActPlayer]<>0)
         and not Save.PlayMySelf then for j:=1 to pred(MAXCIVS) do if (j<>i)
         and (Save.WarState[j,i]=LEVEL_WAR) and (Save.WarState[j,ActPlayer]=LEVEL_WAR)
         and (not (Save.WarState[ActPlayer,i] in [LEVEL_WAR,LEVEL_ALLIANZ,LEVEL_UNKNOWN,LEVEL_NO_ALLIANZ]))
         then begin
            MAKEBORDER(MyScreen[1]^,85,120,425,265,12,6,0);
            s:=GETCIVNAME(i);
            WRITE(256,136,GETCIVFLAG(i),1+16,MyScreen[1]^,4,s);
            WRITE(256,156,12,1+16,MyScreen[1]^,4,PText[597]);
            s:=GETCIVNAME(j);
            WRITE(256,176,GETCIVFLAG(j),1+16,MyScreen[1]^,4,s);
            WRITE(256,196,12,1+16,MyScreen[1]^,4,PText[598]);
            DrawImage(^MyScreen[1]^.RastPort,^GadImg1,105,225);
            DrawImage(^MyScreen[1]^.RastPort,^GadImg1,290,225);
            WRITE(162,227,8,16,MyScreen[1]^,4,PText[245]);
            WRITE(348,227,8,16,MyScreen[1]^,4,PText[246]);
            repeat
               delay(RDELAY);
            until (LData^ and 64=0) and (IBase^.MouseX in [105..221,290..406]) and (IBase^.MouseY in [225..245]);
            if IBase^.MouseX in [105..221] then begin
               KLICKGAD(105,225);
               Save.WarState[i,ActPlayer]:=LEVEL_ALLIANZ;
               Save.WarState[ActPlayer,i]:=LEVEL_ALLIANZ
            end else begin
               KLICKGAD(290,225);
               Save.WarState[i,ActPlayer]:=LEVEL_NO_ALLIANZ;
               Save.WarState[ActPlayer,i]:=LEVEL_NO_ALLIANZ;
               if (i in [2,3]) and (random(3)=0) and (Save.WarPower[i]>Save.WarPower[ActPlayer])
                then AUTOVERHANDLUNG(i,ActPlayer,ActSys,MODE_BELEIDIGUNG);
            end;
            RECT(MyScreen[1]^,0,85,120,425,265);
            REFRESHDISPLAY;
         end;
         if ((Save.Bevölkerung[i]=0) and not (Save.WarState[ActPlayer,i] in [LEVEL_DIED,LEVEL_UNKNOWN])
         and (i<8))
         or ((Save.Bevölkerung[8]=0) and (i=8) and not (Save.WorldFlag in [0,WFLAG_FIELD])) then begin
            Save.WarState[ActPlayer,i]:=LEVEL_DIED;
            Save.WarState[i,i]:=LEVEL_DIED;
            if Save.CivPlayer[ActPlayer]<>0 then begin
               INFORMUSER;
               MAKEBORDER(MyScreen[1]^,85,120,425,210,12,6,0);
               s:=PText[600]+' '+GETCIVNAME(i);
               WRITE(256,140,GETCIVFLAG(i),1+16,MyScreen[1]^,4,s);
               WRITE(256,165,12,1+16,MyScreen[1]^,4,PText[601]);
               if Save.PlayMySelf then delay(PAUSE);
               WAITLOOP(Save.PlayMySelf);
               RECT(MyScreen[1]^,0,85,120,425,210);
               REFRESHDISPLAY;
            end;
            if i=8 then begin
               for j:=1 to 8 do Save.JSteuer[j]:=0;
               Save.WorldFlag:=0;
            end;
            Save.JSteuer[i]:=0;
         end;
      end;
   end;
   randomize;
   l:=0;
   if (Save.WorldFlag=WFLAG_JAHADR) and not (Save.WarState[ActPlayer,8] in [LEVEL_WAR,LEVEL_COLDWAR])
   and (Year mod 5=0) then for i:=1 to (MAXCIVS-2) do if (l=0) and (i<>ActPlayer)
    and (Save.JSteuer[i]>0) and (Save.WarState[ActPlayer,i]=LEVEL_WAR) then begin
      if (Save.CivPlayer[ActPlayer]<>0) and not Save.PlayMySelf then begin
         MAKEBORDER(MyScreen[1]^,80,120,430,265,12,6,0);
         WRITE(256,136,FLAG_OTHER,1+16,MyScreen[1]^,4,PText[602]);
         WRITE(256,156,FLAG_OTHER,1+16,MyScreen[1]^,4,PText[603]);
         s:=GETCIVNAME(i)+' '+PText[604];
         WRITE(256,176,FLAG_OTHER,1+16,MyScreen[1]^,4,s);
         l:=abs(Year)*11;   s:=PText[605]+' '+intstr(l);
         WRITE(256,196,FLAG_OTHER,1+16,MyScreen[1]^,4,s);
         DrawImage(^MyScreen[1]^.RastPort,^GadImg1,105,225);
         DrawImage(^MyScreen[1]^.RastPort,^GadImg1,290,225);
         WRITE(162,227,8,16,MyScreen[1]^,4,PText[245]);
         WRITE(348,227,8,16,MyScreen[1]^,4,PText[246]);
         repeat
            delay(RDELAY);
         until (LData^ and 64=0) and (IBase^.MouseX in [105..221,290..406]) and (IBase^.MouseY in [225..245]);
         if IBase^.MouseX in [105..221] then begin
            KLICKGAD(105,225);
            Save.Staatstopf[i]:=Save.Staatstopf[i]+l;
            Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]-l;
            GOTOPEACE(i,ActPlayer);
            if Save.JSteuer[ActPlayer] in [1..99]
             then Save.JSteuer[ActPlayer]:=Save.JSteuer[ActPlayer]+1;
         end else begin
            KLICKGAD(290,225);
            Save.WarState[8,ActPlayer]:=LEVEL_COLDWAR;
         end;
         RECT(MyScreen[1]^,0,80,120,430,265);
         REFRESHDISPLAY;
      end else if Save.CivPlayer[i]=0 then begin
         if Save.JSteuer[ActPlayer]>0 then begin
            GOTOPEACE(i,ActPlayer);
            if Save.JSteuer[ActPlayer] in [1..99]
             then Save.JSteuer[ActPlayer]:=Save.JSteuer[ActPlayer]+1;
            l:=1;
         end else begin
            Save.WarState[8,ActPlayer]:=LEVEL_WAR;
            Save.WarState[ActPlayer,8]:=LEVEL_WAR;
            l:=1;
         end;
      end;
   end;
   if (Save.WarState[8,ActPlayer]=LEVEL_WAR) or (Save.WarState[ActPlayer,8]=LEVEL_WAR)
    then Save.JSteuer[ActPlayer]:=0;
   AUTOSHIPTRAVEL(Display,MODE_ALL,NIL);
   if (Save.Staatstopf[ActPlayer]<(Militärausgaben[ActPlayer]*3)) and (Year mod 2=0)
   and (Save.CivPlayer[ActPlayer]<>0) and (Save.Staatstopf[ActPlayer]>=0)
   and not Save.PlayMySelf then begin
      INFORMUSER;
      REQUEST(PText[607],PText[608],ActPlayerFlag,ActPlayerFlag);
   end;
   if Save.Staatstopf[ActPlayer]<0 then begin
      Save.Staatstopf[ActPlayer]:=round(Save.Staatstopf[ActPlayer]*1.1);
      if Save.CivPlayer[ActPlayer]<>0 then PRINTGLOBALINFOS(ActPlayer);
   end;
   if (Save.Staatstopf[ActPlayer] in [-1..-10000]) and
   (Save.CivPlayer[ActPlayer]<>0) and not Save.PlayMySelf then begin
      INFORMUSER;
      REQUEST(PText[609],PText[610],ActPlayerFlag,ActPlayerFlag);
   end;
   if Save.Staatstopf[ActPlayer]<-10000 then begin
      btx:=FINDMONEYPLANET(ActPlayerFlag,ActPlayer);
      if (btx>0) and (Save.CivPlayer[ActPlayer]<>0) then begin
         INFORMUSER;
         MAKEBORDER(MyScreen[1]^,35,110,475,210,12,6,0);
         WRITE(256,150,ActPlayerFlag,16,MyScreen[1]^,4,s);
         s:=GETCIVNAME(ActPlayer)+' '+PText[615];
         WRITE(256,127,12,16,MyScreen[1]^,4,s);
         s:=PText[616]+' '+Project[btx]+' '+PText[617];
         WRITE(256,175,12,16,MyScreen[1]^,4,s);
         if Save.PlayMySelf then delay(PAUSE);
         WAITLOOP(Save.PlayMySelf);
         RECT(MyScreen[1]^,0,35,110,475,210);
         REFRESHDISPLAY;
      end;
   end;
   if (Year>1973) and (Save.CivPlayer[ActPlayer]<>0) then begin
      if (Save.ImperatorState[ActPlayer]<700) and (Warnung[ActPlayer]=0) then begin
         INFORMUSER;
         MAKEBORDER(MyScreen[1]^,30,80,480,205,12,6,0);
         WRITE(256, 95,ActPlayerFlag,16,MyScreen[1]^,4,PText[620]);
         WRITE(256,115,ActPlayerFlag,16,MyScreen[1]^,4,PText[621]);
         WRITE(256,135,ActPlayerFlag,16,MyScreen[1]^,4,PText[622]);
         WRITE(256,155,ActPlayerFlag,16,MyScreen[1]^,4,PText[623]);
         WRITE(256,175,ActPlayerFlag,16,MyScreen[1]^,4,PText[624]);
         Warnung[ActPlayer]:=1;
         Save.ImperatorState[ActPlayer]:=700;
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,80,480,205);
         REFRESHDISPLAY;
      end else if (Save.ImperatorState[ActPlayer]<500) and (Warnung[ActPlayer]=1) then begin
         INFORMUSER;
         MAKEBORDER(MyScreen[1]^,30,80,480,185,12,6,0);
         WRITE(256, 95,ActPlayerFlag,16,MyScreen[1]^,4,PText[626]);
         WRITE(256,115,ActPlayerFlag,16,MyScreen[1]^,4,PText[627]);
         WRITE(256,135,ActPlayerFlag,16,MyScreen[1]^,4,PText[628]);
         WRITE(256,155,ActPlayerFlag,16,MyScreen[1]^,4,PText[629]);
         Warnung[ActPlayer]:=2;
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,80,480,185);
         REFRESHDISPLAY;
      end;
      if Save.ImperatorState[ActPlayer]>=1000 then Warnung[ActPlayer]:=0;
   end;
   {*** STATUSCHECK BÜRGERKRIEG ***}
   if (Year mod 4=0) and (Save.WorldFlag=ActPlayerFlag) then begin
      if Save.WarPower[8]>Save.WarPower[ActPlayer]*3 then STOPCIVILWAR(1)
      else if Save.WarPower[8]*3<Save.WarPower[ActPlayer] then STOPCIVILWAR(2)
      else if Save.Bevölkerung[8]+Save.Bevölkerung[ActPlayer]<100000 then STOPCIVILWAR(0);
   end;
   if (Save.WorldFlag=WFLAG_FIELD) and (ActPlayer=1) then begin
      if Save.SYSTEMS>1 then Save.SYSTEMS:=Save.SYSTEMS-1 else Save.Bevölkerung[ActPlayer]:=0;
      if Display>Save.SYSTEMS then DRAWSTARS(MODE_REDRAW,ActPlayer)
   end;
   {*** SPIELER SPIELT NICHT ***}
   if Save.WarPower[ActPlayer]>Save.MaxWarPower[ActPlayer] then Save.MaxWarPower[ActPlayer]:=Save.WarPower[ActPlayer];
   if Multiplayer and not Save.PlayMySelf
   and (Save.CivPlayer[ActPlayer]<>0) and (Year>2065) and (Save.MaxWarPower[ActPlayer]=0) then begin
      j:=0;
      for i:=1 to (MAXCIVS-2) do if Save.CivPlayer[i]<>0 then j:=j+1;
      if j>1 then begin
         INFORMUSER;
         MAKEBORDER(MyScreen[1]^,30,120,480,215,12,6,0);
         s:=PText[215]+' '+GETCIVNAME(ActPlayer)+' '+PText[631]+' '+intstr(Save.CivPlayer[ActPlayer])+',';
         WRITE(256,140,ActPlayerFlag,16,MyScreen[1]^,4,s);
         WRITE(256,160,ActPlayerFlag,16,MyScreen[1]^,4,PText[632]);
         WRITE(256,180,ActPlayerFlag,16,MyScreen[1]^,4,PText[633]);
         WAITLOOP(false);
         RECT(MyScreen[1]^,0,30,120,480,215);
         Save.CivPlayer[ActPlayer]:=0;
         Save.Staatstopf[ActPlayer]:=Save.Staatstopf[ActPlayer]+Year*120;
         for i:=1 to 7 do Save.TechCosts[ActPlayer,succ(random(30))]:=0;
         for i:=1 to pred(MAXCIVS) do begin
            if Save.WarState[i,ActPlayer] in [LEVEL_WAR,LEVEL_COLDWAR] then Save.WarState[i,ActPlayer]:=LEVEL_PEACE;
            if Save.WarState[ActPlayer,i] in [LEVEL_WAR,LEVEL_COLDWAR] then Save.WarState[ActPlayer,i]:=LEVEL_PEACE;
         end;
         CREATEJAHADR(ActPlayer);
      end;
   end;

   {*** WIEDERAUFERSTEHUNG ZIVI ***}
   if ((ActPlayer<>1) or Multiplayer) and (Save.WorldFlag<>WFLAG_CEBORC)
   and (ActPlayer<=(MAXCIVS-2)) and (Save.Bevölkerung[ActPlayer]<=0) then begin
      j:=succ(random(Save.SYSTEMS));
      if SystemFlags[1,j] and FLAG_CIV_MASK=0 then begin
         if SystemHeader[j].Planets=0 then CREATENEWSYSTEM(j,ActPlayer);
         for k:=0 to pred(SystemHeader[j].Planets) do if (Save.Bevölkerung[ActPlayer]=0)
         then begin
            PlanetHeader:=ptr(SystemHeader[j].PlanetMemA+sizeof(r_PlanetHeader)*k);
            if PlanetHeader^.Class in [CLASS_WATER,CLASS_ICE,CLASS_DESERT,CLASS_HALFEARTH,
            CLASS_STONES] then with PlanetHeader^ do begin
               SystemHeader[j].vNS:=0;
               Save.CivPlayer[ActPlayer]:=0;
               PName:=PNames[0,NewPNames];
               NewPNames:=NewPNames+1;
               if NewPNames>MAXPLANETS then NewPNames:=1;
               PlanetHeader^.PFlags:=ActPlayerFlag; Ethno:=PFlags;
               Population:=abs(Year*5);
               if Population>Size*500 then Population:=Size*500;
               Save.Bevölkerung[ActPlayer]:=PlanetHeader^.Population;
               Biosphäre:=200;
               Infrastruktur:=190;
               Industrie:=180;
               ProjectPtr:=ptr(AllocMem(sizeof(ByteArr42),MEMF_CLEAR));
               ProjectPtr^[1]:=1;
               ProjectPtr^[26]:=5;
               for i:=1 to pred(MAXCIVS) do if i<>ActPlayer then begin
                  Save.WarState[ActPlayer,i]:=LEVEL_UNKNOWN;
                  Save.WarState[i,ActPlayer]:=LEVEL_UNKNOWN;
               end;
               Save.WarState[ActPlayer,ActPlayer]:=LEVEL_PEACE;
            end;
         end;
         if (Year<2120) and (random(50)=0) then CREATEJAHADR(ActPlayer);
      end;
   end;
   if (random(219)=0) and (random(219)=0) then CEBORCATTACK(0);
   if (random(240)=0) and (random(50)=0) then begin
      l:=0;
      for i:=1 to (MAXCIVS-2) do
       if (i<>ActPlayer) and (Save.WarState[ActPlayer,1]<>LEVEL_UNKNOWN) then l:=1;
      if l=0 then CREATEJAHADR(ActPlayer);
   end;
end; {ROTATEPLANETS}



procedure STARTROTATEPLANETS(ActSys :byte);
forward;



procedure HANDLESYSTEM(ActSys :byte; ShipPtr :ptr);

var i                   :integer;
var MyShipPtr           :^r_ShipHeader;
var MyPlanetHeader      :^r_PlanetHeader;



procedure SEARCHOBJECT;

var PSys,PNum,PCol      :array [1..37] of byte;
var ShipPos             :array [1..37] of ^r_ShipHeader;
var y,z                 :integer;
var LastSys             :byte;
var MyPlanet            :^r_PlanetHeader;
var MyShipPtr           :^r_ShipHeader;
var ThisP,LastP         :byte;
var Mode                :short;
var b                   :boolean;
var sx                  :string;
var s                   :string;


procedure DRAWSHIPS(CivFlag,stSys :byte);

var i,j         :byte;

begin
   RECT(MyScreen[1]^,0,0,0,511,511);
   y:=0;   z:=0;
   for i:= 1 to 35 do PSys[i]:=0;
   for i:=36 to 37 do PSys[i]:=1;
   for i:=stSys to Save.SYSTEMS do
   if (SystemFlags[ActPlayer,i] and FLAG_KNOWN=FLAG_KNOWN) then with SystemHeader[i] do begin
      MyShipPtr:=SystemHeader[i].FirstShip.NextShip;
      while MyShipPtr<>NIL do begin
         if (MyShipPtr^.Owner=ActPlayerFlag) and
         (((Mode=-1) and (MyShipPtr^.Target=TARGET_POSITION)) or
         ((Mode=-2) and (MyShipPtr^.Flags=SHIPFLAG_WATER) and (MyShipPtr^.Moving>=0)))
         then begin
            z:=z+1;
            if z=36 then begin
               LastSys:=i;
               WRITE(100,497,12,0,MyScreen[1]^,3,sx);
               exit;
            end;
            ShipPos[z]:=MyShipPtr; PSys[z]:=i;
            with MyShipPtr^ do begin
               if SType=SHIPTYPE_FLEET then begin
                  s:=PText[635];
                  WRITE(40,y,ActPlayerFlag,0,MyScreen[1]^,3,s);
               end else begin
                  s:=Project[SType];
                  WRITE(40,y,ActPlayerFlag,0,MyScreen[1]^,3,s);
                  s:=PText[455]+': '+intstr((Ladung and MASK_SIEDLER) div 16);
                  WRITE(135,y,12,0,MyScreen[1]^,3,s);
                  s:=PText[456]+': '+intstr(Ladung and MASK_LTRUPPS);
                  WRITE(230,y,12,0,MyScreen[1]^,3,s);
                  s:=PText[458]+': '+intstr(round(Fracht / ShipData[Stype].MaxLoad*100))+' %';
                  WRITE(365,y,12,0,MyScreen[1]^,3,s);
               end;
            end;
            y:=y+14;
         end;
         MyShipPtr:=MyShipPtr^.NextShip;
      end;
   end;
   LastSys:=1;
   WRITE(100,497,12,0,MyScreen[1]^,3,sx);
end;



procedure DRAWPLANETS(CivFlag,stSys :byte);

var i,j         :byte;

begin
   RECT(MyScreen[1]^,0,0,0,511,511);
   y:=0;   z:=0;
   for i:= 1 to 35 do PSys[i]:=0;
   for i:=36 to 37 do PSys[i]:=1;
   for i:=stSys to Save.SYSTEMS do
    if (SystemFlags[ActPlayer,i] and FLAG_KNOWN=FLAG_KNOWN) then with SystemHeader[i] do for j:=1 to Planets do begin
      MyPlanet:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
      with MyPlanet^ do if ((PFlags and FLAG_CIV_MASK=CivFlag) and (CivFlag<>0)) or
      ((CivFlag=0) and not (PFlags and FLAG_CIV_MASK=ActPlayerFlag) and (PFlags>0)) then begin
         z:=z+1;
         if z=36 then begin
            LastSys:=i;
            WRITE(100,497,12,0,MyScreen[1]^,3,sx);
            exit;
         end;
         PSys[z]:=i; PNum[z]:=j; PCol[z]:=PFlags and FLAG_CIV_MASK;
         if PCol[z]=0 then PCol[z]:=1;
         WRITE(50,y,PCol[z],0,MyScreen[1]^,3,PName);
         if CivFlag=ActPlayerFlag then begin
            case ProjectID of
               -3: s:=PText[163];
               -2: s:=PText[164];
               -1: s:=PText[165];
                0: s:='---';
                otherwise s:=Project[ProjectID];
            end;
            WRITE(170,y,12,0,MyScreen[1]^,3,s);
            s:=intstr(Population)+' Mio';
            WRITE(465,y,12,32,MyScreen[1]^,3,s);
         end else begin
            s:=PText[170]+': '+realstr(Size/10,2);
            WRITE(170,y,12,0,MyScreen[1]^,3,s);
            if Ethno=ActPlayerFlag then begin
               s:=GETCIVADJ(ActPlayer)+' '+PText[182];
               WRITE(350,y,12,0,MyScreen[1]^,3,s);
            end;
         end;
         y:=y+14;
      end;
   end;
   LastSys:=1;
   WRITE(100,497,12,0,MyScreen[1]^,3,sx);
end;



begin
   ThisP:=1; LastP:=1; LastSys:=1;
   sx:=PText[636]+'      >>>';
   MAKEBORDER(MyScreen[1]^,194,119,316,254,12,6,1);
   for i:=2 to 3 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
   for i:=5 to 6 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
   WRITE(255,124,12,16,MyScreen[1]^,4,PText[637]);
   WRITE(255,146,0,16,MyScreen[1]^,4,PText[638]);
   WRITE(255,168,0,16,MyScreen[1]^,4,PText[639]);
   WRITE(255,190,12,16,MyScreen[1]^,4,PText[640]);
   WRITE(255,212,0,16,MyScreen[1]^,4,PText[641]);
   WRITE(255,234,0,16,MyScreen[1]^,4,PText[642]);
   b:=false;
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         if IBase^.MouseX in [196..314] then begin
            if IBase^.MouseY in [144..164] then begin
               KLICKGAD(198,144);
               Mode:=ActPlayerFlag;
               b:=true;
            end else if IBase^.MouseY in [166..186] then begin
               KLICKGAD(198,166);
               Mode:=0;
               b:=true;
            end else if IBase^.MouseY in [210..230] then begin
               KLICKGAD(198,210);
               Mode:=-1;
               b:=true;
            end else if IBase^.MouseY in [232..252] then begin
               KLICKGAD(198,232);
               Mode:=-2;
               b:=true;
            end;
         end
      end;
   until b or (RData^ and 1024=0);
   if RData^ and 1024=0 then begin
      PLAYSOUND(1,300);
      RECT(MyScreen[1]^,0,194,119,316,254);
      REFRESHDISPLAY;
      exit;
   end;
   b:=false;
   if Mode<0 then begin
      repeat
         delay(RDELAY);
         DRAWSHIPS(Mode,1);
         repeat
            delay(RDELAY);
            repeat
               delay(RDELAY);
               ThisP:=succ(IBase^.MouseY div 14);
               if (PSys[ThisP]<>0) and (ThisP<>LastP) and (IBase^.MouseX in [0..511]) then begin
                  if (LastP<36) and (PSys[LastP]<>0) then begin
                     MyShipPtr:=ShipPos[LastP];
                     if ShipPos[LastP]^.SType=SHIPTYPE_FLEET
                     then s:=PText[635] else s:=Project[ShipPos[LastP]^.SType];
                     WRITE(40,pred(LastP)*14,ActPlayerFlag,1,MyScreen[1]^,3,s);
                  end else WRITE(100,497,12,1,MyScreen[1]^,3,sx);
                  if ThisP<36 then begin
                     MyShipPtr:=ShipPos[ThisP];
                     if ShipPos[ThisP]^.SType=SHIPTYPE_FLEET
                     then s:=PText[635] else s:=Project[ShipPos[ThisP]^.SType];
                     WRITE(40,pred(ThisP)*14,ActPlayerFlag,5,MyScreen[1]^,3,s);
                  end else WRITE(100,497,12,5,MyScreen[1]^,3,sx);
                  LastP:=ThisP;
               end else ThisP:=LastP;
            until (RData^ and 1024=0) or (LData^ and 64=0);
            if (LData^ and 64=0) then begin
               PLAYSOUND(1,300);
               if ThisP>=36 then DRAWSHIPS(Mode,LastSys) else begin
                  if PSys[ThisP]<>0 then begin
                     OffsetX:=-ShipPos[ThisP]^.PosX-1;
                     OffsetY:=-ShipPos[ThisP]^.PosY-1;
                     ActSys:=PSys[ThisP];
                  end;
                  DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
                  b:=true;
               end;
            end;
         until (RData^ and 1024=0) or b;
      until (RData^ and 1024=0) or b;
   end else begin
      repeat
         delay(RDELAY);
         DRAWPLANETS(Mode,1);
         repeat
            delay(RDELAY);
            repeat
               delay(RDELAY);
               ThisP:=succ(IBase^.MouseY div 14);
               if (PSys[ThisP]<>0) and (ThisP<>LastP) and (IBase^.MouseX in [0..511]) then begin
                  if (LastP<36) and (PSys[LastP]<>0) then begin
                     MyPlanet:=ptr(SystemHeader[PSys[LastP]].PlanetMemA+pred(PNum[LastP])*sizeof(r_PlanetHeader));
                     WRITE(50,pred(LastP)*14,PCol[LastP],1,MyScreen[1]^,3,MyPlanet^.PName);
                  end else WRITE(100,497,12,1,MyScreen[1]^,3,sx);
                  if ThisP<36 then begin
                     MyPlanet:=ptr(SystemHeader[PSys[ThisP]].PlanetMemA+pred(PNum[ThisP])*sizeof(r_PlanetHeader));
                     WRITE(50,pred(ThisP)*14,PCol[ThisP],5,MyScreen[1]^,3,MyPlanet^.PName);
                  end else WRITE(100,497,12,5,MyScreen[1]^,3,sx);
                  LastP:=ThisP;
               end else ThisP:=LastP;
            until (RData^ and 1024=0) or (LData^ and 64=0);
            if (LData^ and 64=0) then begin
               PLAYSOUND(1,300);
               if ThisP>=36 then DRAWPLANETS(Mode,LastSys) else begin
                  if PSys[ThisP]<>0 then begin
                     OffsetX:=-round(MyPlanet^.PosX)-1;
                     OffsetY:=-round(MyPlanet^.PosY)-1;
                     ActSys:=PSys[ThisP];
                  end;
                  DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
                  b:=true;
               end;
            end;
         until (RData^ and 1024=0) or b;
      until (RData^ and 1024=0) or b;
   end;
   if RData^ and 1024=0 then begin
      PLAYSOUND(1,300);
      DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   end;
end;



begin
   OffsetX:=0; OffsetY:=0;
   if Display<>ActSys then DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
   repeat
      delay(RDELAY);
      ScreenToFront(MyScreen[1]);
      CLOCK;
      RawCode:=GETRAWCODE;
      if (Save.PlayMySelf) or (Save.CivPlayer[ActPlayer]=0) or not Informed
      or (not Multiplayer and not Informed and (Year mod 10<>0)) then STARTROTATEPLANETS(ActSys) else begin
         if (LData^ and 64=0) or (RData^ and 1024=0) then delay(3);
         if ((LData^ and 64=0) and (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [472..492]))
          or ((LData^ and 64=0) and (RData^ and 1024=0)) or (RawCode in [64,67,68]) then begin
            KLICKGAD(518,472);
            STARTROTATEPLANETS(ActSys);
         end;

         if (LData^ and 64=0) and not Save.PlayMySelf then begin
            if IBase^.MouseX in [518..634] then begin
               if IBase^.MouseY in [9..117] then begin
                  PLAYSOUND(1,300);
                  OffsetX:=576-IBase^.MouseX; OffsetY:=63-IBase^.MouseY;
                  DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
               end else if IBase^.MouseY in [416..436] then begin
                  KLICKGAD(518,416);
                  SEARCHOBJECT;
               end;
            end else if (IBase^.MouseX in [0..511]) and (IBase^.MouseY in [0..511]) then begin
               PLAYSOUND(1,300);
               if FINDOBJECT(ActSys,IBase^.MouseX,IBase^.MouseY,NIL) then case ObjType of
                  TYPE_PLANET:   PLANETINFO(ActSys);
                  TYPE_SHIP:     begin
                                    MyShipPtr:=ObjPtr;
                                    if MyShipPtr^.SType=SHIPTYPE_FLEET then ORBITINFO(MyShipPtr,'Flotte',ActSys,0,0)
                                    else SHIPINFO(ActSys);
                                 end;
                  otherwise;
               end;
            end;
         end else if (RData^ and 1024=0) then begin
            if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [9..117]) then begin
               if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [9..29]) then
                if OffsetY<42 then OffsetY:=OffsetY+2;
               if (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [97..117]) then
                if OffsetY>-42 then OffsetY:=OffsetY-2;
               if (IBase^.MouseX in [518..538]) and (IBase^.MouseY in [9..117]) then
                if OffsetX<42 then OffsetX:=OffsetX+2;
               if (IBase^.MouseX in [614..634]) and (IBase^.MouseY in [9..117]) then
                if OffsetX>-42 then OffsetX:=OffsetX-2;
               DRAWSYSTEM(MODE_REDRAW,ActSys,NIL);
            end;
            if (IBase^.MouseX in [0..511]) and (IBase^.MouseY in [0..511]) then begin
               PLAYSOUND(1,300);
               if FINDOBJECT(ActSys,IBase^.MouseX,IBase^.MouseY,NIL) then case ObjType of
                  TYPE_PLANET:   begin
                                    MyPlanetHeader:=ObjPtr;
                                    s:=PText[645]+' '+MyPlanetHeader^.PName;
                                    with MyPlanetHeader^ do ORBITINFO(FirstShip.NextShip,s,ActSys,round(PosX),round(PosY));
                                 end;
                  TYPE_SHIP:     SYSTEMINFO(ActSys);
                  otherwise;
               end;
            end;
         end;
      end;
      CLEARINTUITION;
   until (Display=0) or (SystemFlags[ActPlayer,ActSys] and FLAG_KNOWN=0)
   or ((LData^ and 64=0) and (IBase^.MouseX in [518..634]) and  (IBase^.MouseY in [444..464]))
   or Save.PlayMySelf;
   if Display<>0 then begin
      KLICKGAD(518,444);
      RECT(MyScreen[1]^,0,522,9,629,117);
      DRAWSTARS(MODE_REDRAW,ActPlayer)
   end;
end;



procedure STARTROTATEPLANETS;

var i,j,PredPlayer      :byte;
var s                   :string;


procedure CREATEINFOBOX;

var s           :string;

begin
   INFORMUSER;
   MAKEBORDER(MyScreen[1]^,30,100,480,270,12,6,0);
   s:=PText[646]+' '+intstr(Year)+':';
   WRITE(255,110,ActPlayerFlag,16,MyScreen[1]^,4,s);
   PRINTGLOBALINFOS(ActPlayer);
end;


begin
   for i:=1 to MAXCIVS do Save.LastWarState[ActPlayer,i]:=Save.WarState[ActPlayer,i];
   if Informed then LastDisplay[ActPlayer]:=Display;
   ActPlayer:=ActPlayer+1;
   if ActPlayer>MAXCIVS then ActPlayer:=1;
   ActPlayerFlag:=GETCIVFLAG(ActPlayer);
   if Display<>0 then DRAWSTARS(MODE_REDRAW,ActPlayer);
   Informed:=false;
   j:=1;
   if (Year>1900) and (Save.CivPlayer[ActPlayer]<>0) then begin
      if (Save.WarState[ActPlayer,ActPlayer]<>LEVEL_DIED) then for i:=1 to pred(MAXCIVS) do begin
         if Save.LastWarState[ActPlayer,i]<>Save.WarState[ActPlayer,i] then begin
            j:=j+1;
            if Save.WarState[ActPlayer,i]=LEVEL_DIED then s:=PText[600]+' '+GETCIVNAME(i)+' '+PText[601]
            else if (Save.WarState[ActPlayer,i]=LEVEL_PEACE)
             and (Save.LastWarState[ActPlayer,i]=LEVEL_WAR) then s:=GETCIVNAME(i)+' '+PText[647]
            else if Save.WarState[ActPlayer,i]=LEVEL_WAR then s:=GETCIVNAME(i)+' '+PText[648]+' '+GETCIVNAME(ActPlayer)+' '+PText[649]
            else if Save.WarState[ActPlayer,i]=LEVEL_ALLIANZ then s:=GETCIVNAME(i)+' '+PText[650]+' '+GETCIVNAME(ActPlayer)+PText[651]
            else j:=j-1;
         end;
         if j>1 then begin
            if not Informed then CREATEINFOBOX;
            WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
         end;
      end;
      if (Save.WarState[ActPlayer,8]=LEVEL_PEACE)
      and (Save.LastWarState[ActPlayer,8]=LEVEL_UNKNOWN)
      and (Save.WorldFlag in [FLAG_TERRA,FLAG_KLEGAN,FLAG_REMALO,FLAG_CARDAC,
      FLAG_FERAGI,FLAG_BAROJA,FLAG_VOLKAN]) then begin
         if not Informed then CREATEINFOBOX;
         j:=j+1;
         s:=GETCIVNAME(FLAG_OTHER)+' '+PText[655];
         if not Informed then CREATEINFOBOX;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
         j:=j+1;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,PText[656]);
      end;
      if (ActPlayer=7) and (Save.CivilWar<>0) and
      (Save.WarState[Save.CivilWar,8]=Save.LastWarState[Save.CivilWar,8]) then Save.CivilWar:=0;
      if Save.CivilWar<>0 then if (Save.WarState[Save.CivilWar,8]=LEVEL_UNKNOWN)
      and (Save.LastWarState[Save.CivilWar,8]=LEVEL_WAR)
      and (GETCIVVAR(Save.WorldFlag) in [1..7]) then begin
         j:=j+1;
         s:=GETCIVNAME(FLAG_OTHER)+' '+PText[657];
         if not Informed then CREATEINFOBOX;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
      end;

      if GetPlanetSys[ActPlayer]<>0 then begin
         j:=j+1;
         s:=PText[167]+' '+GetPlanet[ActPlayer]^.PName+' '+PText[658];
         if not Informed then CREATEINFOBOX;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
      end;
      if Verschrottung[ActPlayer]>0 then begin
         j:=j+1;
         if Verschrottung[ActPlayer]>1 then s:=intstr(Verschrottung[ActPlayer])+' '+PText[659]
         else s:=PText[660];
         if not Informed then CREATEINFOBOX;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
         Verschrottung[ActPlayer]:=0;
      end;
      if vNSonde[ActPlayer] then begin
         j:=j+1;
         s:=GETCIVNAME(ActPlayer)+' '+PText[662];
         if not Informed then CREATEINFOBOX;
         WRITE(255,100+j*18,12,16,MyScreen[1]^,4,s);
         vNSonde[ActPlayer]:=false;
      end;
   end;
   if (Year=1963) and (Save.CivPlayer[ActPlayer]<>0)
   and (random(10)=0) then begin
      j:=j+2;
      if not Informed then CREATEINFOBOX;
      WRITE(255,100+pred(j)*18,12,16,MyScreen[1]^,4,'Auf der Erde nimmt Dank Gene Roddenberry');
      WRITE(255,100+j*18,12,16,MyScreen[1]^,4,'eine Legende ihren Anfang!');
   end;
   if (Year=1973) and (Save.CivPlayer[ActPlayer]<>0)
   and (random(10)=0) then begin
      j:=j+2;
      if not Informed then CREATEINFOBOX;
      WRITE(255,100+pred(j)*18,12,16,MyScreen[1]^,4,'Auf der Erde wird ein');
      WRITE(255,100+j*18,12,16,MyScreen[1]^,4,'genialer Programmierer geboren!');
   end;
   if (Year=2001) and (Save.CivPlayer[ActPlayer]<>0)
   and (random(10)=0) then begin
      j:=j+2;
      if not Informed then CREATEINFOBOX;
      WRITE(255,100+pred(j)*18,12,16,MyScreen[1]^,4,'Stanley Kubricks & Arthur C. Clarkes');
      WRITE(255,100+j*18,12,16,MyScreen[1]^,4,'Vision wird Wirklichkeit!');
   end;
   if (Year=2010) and (Save.CivPlayer[ActPlayer]<>0)
   and (random(10)=0) then begin
      j:=j+2;
      if not Informed then CREATEINFOBOX;
      WRITE(255,100+pred(j)*18,12,16,MyScreen[1]^,4,'Peter Hyams & Arthur C. Clarkes');
      WRITE(255,100+j*18,12,16,MyScreen[1]^,4,'Vision wird Wirklichkeit!');
   end;
   if (Year=2063) and (Save.CivPlayer[ActPlayer]<>0)
   and (random(10)=0) then begin
      j:=j+2;
      if not Informed then CREATEINFOBOX;
      WRITE(255,100+pred(j)*18,12,16,MyScreen[1]^,4,'Auf der Erde findet');
      WRITE(255,100+j*18,12,16,MyScreen[1]^,4,'"Der erste Kontakt" statt!');
   end;
   if j>1 then begin
      if Save.PlayMySelf then delay(PAUSE);
      WAITLOOP(Save.PlayMySelf);
      RECT(MyScreen[1]^,0,30,100,480,270);
      REFRESHDISPLAY;
      if GetPlanetSys[ActPlayer]<>0 then begin
         if not Save.PlayMySelf and (Save.CivPlayer[ActPlayer]<>0)
          then HANDLEKNOWNPLANET(GetPlanetSys[ActPlayer],0,GetPlanet[ActPlayer]);
      end;
   end;
   GetPlanetSys[ActPlayer]:=0;
   ROTATEPLANETS(Display);
   if Informed then begin
      if (LastDisplay[ActPlayer]=0) and (Display<>0) then DRAWSTARS(MODE_REDRAW,ActPlayer)
      else if (LastDisplay[ActPlayer]<>0) then HANDLESYSTEM(LastDisplay[ActPlayer],NIL);
   end;
   if (Save.CivPlayer[ActPlayer]<>0) and Informed then begin
      RECT(MyScreen[1]^,0,520,291,632,308);
      WRITE(521,292,12,1,MyScreen[1]^,4,PText[663]);
   end;
end;



function INITSTARS:boolean;

type StrArrMAXP=array[1..MAXPLANETS] of string[20];

var l,m,HomePlanetProd  :long;
var b                   :boolean;
var PMemA               :array [1..MAXCIVS-2,1..5] of long;
var i,j,k               :integer;
var sin_rot,cos_rot,d   :real;
var PlanetHeader        :^r_PlanetHeader;
var ActPProjects        :^ByteArr42;
var DefaultShip         :r_ShipHeader;

begin
   INITSTARS:=false;
   randomize;
   SystemFlags[1,1]:=FLAG_TERRA+FLAG_KNOWN;
   for i:=1 to MAXCIVS-2 do for j:=1 to HomePlanets do begin
      PMemA[i,j]:=AllocMem(sizeof(ByteArr42),MEMF_CLEAR);
      if PMemA[i,j]=0 then exit;
      ActPProjects:=ptr(PMemA[i,j]);
      ActPProjects^[0]:=1;
   end;
   DefaultShip:=r_ShipHeader(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NIL,NIL,NIL);
   for i:=1 to MAXSYSTEMS do SystemHeader[i]:=r_SystemHeader(0,0,DefaultShip,0,0,0);
   with SystemHeader[1] do begin
      FirstShip.Owner:=FLAG_TERRA;
      Planets:=9;
      FirstShip:=DefaultShip;
      PlanetMemA:=AllocMem(Planets*sizeof(r_PlanetHeader),MEMF_CLEAR);
      if PlanetMemA=0 then exit;
      PlanetHeader:=ptr(PlanetMemA);
      PlanetHeader^:=r_PlanetHeader(CLASS_DESERT,2,FLAG_UNKNOWN,0,PNames[1,1],4,4,0,24,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader));
      PlanetHeader^:=r_PlanetHeader(CLASS_HALFEARTH,7,FLAG_UNKNOWN,0,PNames[1,2],7,7,0,283,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*2);
      PlanetHeader^:=r_PlanetHeader(CLASS_EARTH,10,FLAG_TERRA,FLAG_TERRA,PNames[1,3],10,10,4000,760,170,165,160,0,0,0,DefaultShip,ptr(PMemA[1,1]));
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*3);
      PlanetHeader^:=r_PlanetHeader(CLASS_DESERT,5,FLAG_UNKNOWN,0,PNames[1,4],13,13,0,61,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*4);
      PlanetHeader^:=r_PlanetHeader(CLASS_GAS,115,FLAG_UNKNOWN,0,PNames[1,5],16,16,0,0,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*5);
      PlanetHeader^:=r_PlanetHeader(CLASS_SATURN,82,FLAG_UNKNOWN,0,PNames[1,6],19,19,0,0,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*6);
      PlanetHeader^:=r_PlanetHeader(CLASS_GAS,41,FLAG_UNKNOWN,0,PNames[1,7],22,22,0,0,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*7);
      PlanetHeader^:=r_PlanetHeader(CLASS_GAS,45,FLAG_UNKNOWN,0,PNames[1,8],25,25,0,0,0,0,0,0,0,0,DefaultShip,NIL);
      PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*8);
      PlanetHeader^:=r_PlanetHeader(CLASS_DESERT,1,FLAG_UNKNOWN,0,PNames[1,9],30,30,0,11,0,0,0,0,0,0,DefaultShip,NIL);
      SystemHeader[1].SysOwner:=FLAG_TERRA;
      HomePlanetProd:=0;
      if HomePlanets>1 then begin
         l:=Homeplanets;
         for j:=0 to pred(Planets) do begin
            PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*j);
            if PlanetHeader^.Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,
            CLASS_WATER,CLASS_STONES,CLASS_ICE] then begin
               if (l>0) and ((l>1) or (j>1)) then with PlanetHeader^ begin
                  PFlags:=FLAG_TERRA;  Ethno:=PFlags;
                  PlanetHeader^.Water:=PlanetHeader^.Water div PlanetHeader^.Size;
                  PlanetHeader^.Size:=random(15)+5;
                  PlanetHeader^.Water:=PlanetHeader^.Water*PlanetHeader^.Size;
                  Population:=Size*400;   Biosphäre:=170;
                  Infrastruktur:=165;     Industrie:=160;
                  ProjectPtr:=ptr(PMemA[1,l]);
                  l:=l-1;
                  HomePlanetProd:=HomePlanetProd+Size;
               end;
            end;
         end;
         Save.ImperatorState[1]:=Save.ImperatorState[1]-(HomePlanetProd*3);
         if round(HomePlanetProd/15)>1 then for i:=1 to 42 do Save.TechCosts[1,i]:=round(Save.TechCosts[1,i]*(HomePlanetProd/15));
      end;
   end;
   for i:=1 to 200 do for j:=1 to SystemHeader[1].Planets do begin
      PlanetHeader:=ptr(SystemHeader[1].PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
      with PlanetHeader^ do begin
         d:=1/((j*3)+1);
         sin_rot:=sin(d);  cos_rot:=cos(d);
         PosX:=PosX * cos_rot - PosY*sin_rot;
         PosY:=PosX * sin_rot + PosY*cos_rot*(1+d*d);
         if round(PosX)=round(PosY) then PosX:=round(PosY);
      end;
   end;
   SystemX[1]:=10+random(250)+random(208);
   SystemY[1]:=10+random(250)+random(240);
   for i:=2 to MAXSYSTEMS do begin
      repeat
         SystemX[i]:=10+random(250)+random(208);
         SystemY[i]:=10+random(250)+random(240);
         b:=true;
         for j:=1 to pred(i) do if SystemY[i] in [SystemY[j]-10..SystemY[j]+10] then b:=false;
      until b;
      with SystemHeader[i] do begin
         Planets:=0;
         PlanetMemA:=0;
         FirstShip:=DefaultShip;
      end;
      for j:=1 to (MAXCIVS-2) do SystemFlags[j,i]:=FLAG_UNKNOWN;
   end;
   for k:=2 to (MAXCIVS-2) do begin
      repeat
         i:=random(MAXSYSTEMS-1)+2;
      until SystemHeader[i].Planets=0;
      SystemFlags[1,i]:=GETCIVFLAG(k);
      SystemFlags[k,i]:=FLAG_KNOWN;
      CREATENEWSYSTEM(i,k);
      with SystemHeader[i] do for j:=0 to pred(Planets) do begin
         FirstShip.Owner:=GETCIVFLAG(k);
         PlanetHeader:=ptr(PlanetMemA+sizeof(r_PlanetHeader)*j);
         if j=2 then PlanetHeader^:=r_PlanetHeader(CLASS_EARTH,1,GETCIVFLAG(k),GETCIVFLAG(k),'',13,0,4000,73,170,165,160,0,0,0,DefaultShip,ptr(PMemA[k,1]));
         PlanetHeader^.PName:=PNames[k,succ(j)];
         PlanetHeader^.Water:=PlanetHeader^.Water div PlanetHeader^.Size;
         PlanetHeader^.Size:=random(15)+5;
         PlanetHeader^.Water:=PlanetHeader^.Water*PlanetHeader^.Size;
      end;
      SystemFlags[k,i]:=SystemFlags[k,i]+FLAG_KNOWN;
      SystemHeader[i].SysOwner:=GETCIVFLAG(k);

      if HomePlanets>1 then begin
         HomePlanetProd:=0;
         l:=Homeplanets;
         for j:=0 to pred(SystemHeader[i].Planets) do begin
            PlanetHeader:=ptr(SystemHeader[i].PlanetMemA+sizeof(r_PlanetHeader)*j);
            if PlanetHeader^.Class in [CLASS_DESERT,CLASS_HALFEARTH,CLASS_EARTH,
            CLASS_WATER,CLASS_STONES,CLASS_ICE] then begin
               if (l>0) and ((l>1) or (j>1)) then with PlanetHeader^ do begin
                  PFlags:=GETCIVFLAG(k);  Ethno:=PFlags;
                  PlanetHeader^.Water:=PlanetHeader^.Water div PlanetHeader^.Size;
                  PlanetHeader^.Size:=random(15)+5;
                  PlanetHeader^.Water:=PlanetHeader^.Water*PlanetHeader^.Size;
                  Population:=Size*400;   Biosphäre:=170;
                  Infrastruktur:=165;     Industrie:=160;
                  ProjectPtr:=ptr(PMemA[k,l]);
                  l:=l-1;
                  HomePlanetProd:=HomePlanetProd+Size;
               end;
            end;
         end;
         Save.ImperatorState[k]:=Save.ImperatorState[k]-(HomePlanetProd*3);
         if HomePlanetProd/15>1 then for i:=1 to 42 do Save.TechCosts[k,i]:=round(Save.TechCosts[k,i]*(HomePlanetProd/15));
      end;
   end;
   if HomePlanets>1 then for k:=1 to (HomePlanets+3) do for i:=1 to (MAXCIVS-2) do
    if Save.CivPlayer[i]<>0 then for j:=1 to 42 do Save.ProjectCosts[i,j]:=round(Save.ProjectCosts[i,j]*INFLATION);
   for j:=1 to MAXHOLES do with MyWormHole[j] do begin
      for i:=1 to MAXCIVS do CivKnowledge[i]:=0;
      System[1]:=random(MAXSYSTEMS+1);
      System[2]:=random(MAXSYSTEMS+1);
      if (System[1]=0) or (System[2]=0) or (System[1]=System[2]) then begin
         System[1]:=0; System[2]:=0;
      end else begin
         for i:=1 to 2 do begin
            PosX[i]:=35-random(70); if PosX[i]<4 then PosX[i]:=4; if random(2)=0 then PosX[i]:=-PosX[i];
            PosY[i]:=35-random(70); if PosY[i]<4 then PosY[i]:=4; if random(2)=0 then PosY[i]:=-PosY[i];
         end;
      end;
   end;
   INITSTARS:=true;
end;



procedure CREATEPATHS;

var btx         :^byte;
var i           :integer;
var l           :long;

begin
   i:=1; l:=PathMemA;
   repeat
      PathStr[i]:=ptr(l);
      repeat
         btx:=ptr(l); l:=l+1;
         if btx^=10 then btx^:=0;
      until (l>PathMeMA+PathMemL) or (btx^=0) or (i>PATHS);
      i:=i+1;
   until (i>PATHS) or (l>PathMeMA+PathMemL);
end;



function FIRSTMENU:byte;

var i           :byte;
var l,m         :long;
var s           :string;

begin
   SWITCHDISPLAY;
   INITMENU;
   WRITE(320,55,40,16,MyScreen[2]^,4,'IMPERIUM TERRANUM 2');
   WRITE(320,71,40,16,MyScreen[2]^,3,'- War of the Worlds -');
   WRITE(320,70,40,16,MyScreen[2]^,4,'______________________');
   WRITE(320,435,40,16,MyScreen[2]^,3,'Version 2.8');
   WRITE(320,455,40,16,MyScreen[2]^,3,'Surround-sounds, created with the WaveTracer DS®');
   WRITE(320,128,40,16,MyScreen[2]^,3,'Frei kopierbare Version');
   WRITE(320,146,40,16,MyScreen[2]^,3,'FREEWARE and OpenSource');
   WRITE(320,164,40,16,MyScreen[2]^,3,'Created by VirtualWorlds Productions:http://www.VirtualWorlds.de');
   MAKEBORDER(MyScreen[2]^,150,200,490,230,40,14,0);
   MAKEBORDER(MyScreen[2]^,150,240,490,270,40,14,0);
   WRITE(320,207,21,16,MyScreen[2]^,4,PText[664]);
   WRITE(320,247,21,16,MyScreen[2]^,4,PText[665]);
   ScreenToFront(MyScreen[2]);
   l:=0;
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         if IBase^.MouseX in [150..490] then begin
            if IBase^.MouseY in [200..230] then begin
               l:=1;
               CLICKRECT(MyScreen[2]^,150,200,490,230,40);
            end else if IBase^.MouseY in [240..270] then begin
               CLICKRECT(MyScreen[2]^,150,240,490,270,40);
               l:=2;
            end
         end;
      end;
   until l<>0;
   ScreenToFront(XScreen);
   if l=1 then OPTIONMENU(1);
   if l=2 then begin
      FIRSTMENU:=1;
      if TMPTR<>0 then begin
         StopPlayer;
         UnloadModule(TMPTR);
         TMPtr:=0;
      end;
   end else if l=3 then FIRSTMENU:=2
   else FIRSTMENU:=0;
   if Save.PlayMySelf then Save.ActTech[1]:=3;
end;



procedure REGIERUNG;

var i,j,btx     :byte;
var b           :boolean;


procedure MILITÄR;


procedure DRAWDATA(BSet :byte);

var XState,Fight,Costs   :byte;

begin
   SetAPen(^MyScreen[1]^.RastPort,0);
   if (BSet in [1..8])
    or ((BSet=16) and (Save.TechCosts[ActPlayer,9]<=0))
    or ((BSet=32) and (Save.TechCosts[ActPlayer,23]<=0))
     then if (Save.Military[ActPlayer] and BSet=0) then
     Save.Military[ActPlayer]:=Save.Military[ActPlayer]+BSet
     else Save.Military[ActPlayer]:=Save.Military[ActPlayer]-BSet;
   btx:=1; XState:=0; Fight:=0; Costs:=Save.Military[ActPlayer];
   for i:=1 to 6 do begin
      if (Save.Military[ActPlayer] and btx=btx) then begin
         XState:=XState+i;
         Fight:=Fight+8;
         WRITE(74,i*30+95,12,1,MyScreen[1]^,4,'|');
      end else RectFill(^MyScreen[1]^.RastPort,74,i*30+95,90,i*30+110);
      btx:=btx*2;
   end;
   s:=' -'+intstr(XState);
   WRITE(280,310,8,32+1,MyScreen[1]^,2,s);
   s:=' +'+intstr(Fight);
   WRITE(280,335,8,32+1,MyScreen[1]^,2,s);
   s:=' +'+intstr(Costs)+'%';
   WRITE(294,360,8,32+1,MyScreen[1]^,2,s);
end;


begin
   MAKEBORDER(MyScreen[1]^,50,70,460,400,12,6,0);
   for i:=1 to 6 do MAKEBORDER(MyScreen[1]^,70,i*30+90,95,i*30+115,12,6,1);
   WRITE(255,80,ActPlayerFlag,16,MyScreen[1]^,4,PText[667]);
   WRITE(110,125,12,0,MyScreen[1]^,4,PText[668]);
   WRITE(110,155,12,0,MyScreen[1]^,4,PText[669]);
   WRITE(110,185,12,0,MyScreen[1]^,4,PText[670]);
   WRITE(110,215,12,0,MyScreen[1]^,4,PText[671]);
   if Save.TechCosts[ActPlayer,9]<=0 then s:=PText[672] else s:='---  (benötigt '+TechnologyL[9]+')';
   WRITE(110,245,12,0,MyScreen[1]^,4,s);
   if Save.TechCosts[ActPlayer,23]<=0 then s:=PText[673] else s:='--- (benötigt '+TechnologyL[23]+')';
   WRITE(110,275,12,0,MyScreen[1]^,4,s);
   WRITE(70,310,ActPlayerFlag,0,MyScreen[1]^,4,PText[674]);
   WRITE(70,335,ActPlayerFlag,0,MyScreen[1]^,4,PText[675]);
   WRITE(70,360,ActPlayerFlag,0,MyScreen[1]^,4,PText[676]);
   DRAWDATA(0);
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         PLAYSOUND(1,300);
         if IBase^.MouseX in [70..440] then begin
            if IBase^.MouseY in [120..145] then DRAWDATA(1)
            else if IBase^.MouseY in [150..175] then DRAWDATA(2)
            else if IBase^.MouseY in [180..205] then DRAWDATA(4)
            else if IBase^.MouseY in [210..235] then DRAWDATA(8)
            else if IBase^.MouseY in [240..265] then DRAWDATA(16)
            else if IBase^.MouseY in [270..295] then DRAWDATA(32)
         end;
      end;
   until (RData^ and 1024=0)
end;



procedure FINANZEN;


procedure WRITEDATA(Mode :byte);

begin
   s:=intstr(Save.GSteuer[ActPlayer])+'%';
   while length(s)<4 do s:='0'+s;
   WRITE(367,147,8,33,MyScreen[1]^,2,s);
   s:=intstr(100-Save.JSteuer[ActPlayer]-Save.GSteuer[ActPlayer]-Save.SService[ActPlayer])+'%';
   while length(s)<4 do s:='0'+s;
   WRITE(367,192,8,33,MyScreen[1]^,2,s);
   s:=intstr(Save.SService[ActPlayer])+'%';
   while length(s)<4 do s:='0'+s;
   WRITE(367,237,8,33,MyScreen[1]^,2,s);
   if (Save.WorldFlag=WFLAG_JAHADR) and (Save.JSteuer[ActPlayer]+Mode>0) and
   not (Save.WarState[ActPlayer,8] in [LEVEL_UNKNOWN,LEVEL_DIED])
   then begin
      s:=intstr(Save.JSteuer[ActPlayer])+'%';
      while length(s)<4 do s:='0'+s;
      WRITE(367,327,8,33,MyScreen[1]^,2,s);
   end;
end;


begin
   MAKEBORDER(MyScreen[1]^,60,100,430,275,12,6,0);
   WRITE(256,110,ActPlayerFlag,16,MyScreen[1]^,4,PText[678]);
   WRITE(80,147,12,0,MyScreen[1]^,4,PText[679]);
   WRITE(80,192,ActPlayerFlag,0,MyScreen[1]^,4,PText[680]);
   WRITE(80,237,12,0,MyScreen[1]^,4,PText[681]);
   for i:=1 to 3 do MAKEBORDER(MyScreen[1]^,291,i*45+97,370,i*45+120,12,6,1);
   WRITE(310,170,12,0,MyScreen[1]^,2,'I J');
   WRITE(310,215,12,0,MyScreen[1]^,2,'J I');
   if (Save.WorldFlag=WFLAG_JAHADR) and (Save.JSteuer[ActPlayer]>0) and
   not (Save.WarState[ActPlayer,8] in [LEVEL_UNKNOWN,LEVEL_DIED])
   then begin
      MAKEBORDER(MyScreen[1]^,60,300,430,365,12,6,0);
      WRITE(325,305,8,0,MyScreen[1]^,2,'I');
      WRITE(80,316,FLAG_OTHER,0,MyScreen[1]^,4,PText[683]);
      MAKEBORDER(MyScreen[1]^,291,322,370,345,12,6,1);
      WRITE(80,333,FLAG_OTHER,0,MyScreen[1]^,4,PText[684]);
   end;
   WRITEDATA(0);
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         PLAYSOUND(1,300);
         if IBase^. MouseY in [165..188] then begin
            if IBase^.MouseX in [300..330] then begin
               if Save.GSteuer[ActPlayer]<100-Save.JSteuer[ActPlayer]-Save.SService[ActPlayer]
                then Save.GSteuer[ActPlayer]:=Save.GSteuer[ActPlayer]+1;
            end else if IBase^.MouseX in [335..365] then begin
               if Save.GSteuer[ActPlayer]>0
                then Save.GSteuer[ActPlayer]:=Save.GSteuer[ActPlayer]-1;
            end;
            WRITEDATA(0);
         end;
         if IBase^. MouseY in [210..233] then begin
            if IBase^.MouseX in [300..330] then begin
               if Save.SService[ActPlayer]<100-Save.JSteuer[ActPlayer]-Save.GSteuer[ActPlayer] then
                Save.SService[ActPlayer]:=Save.SService[ActPlayer]+1;
            end else if IBase^.MouseX in [335..365] then begin
               if Save.SService[ActPlayer]>0 then
                Save.SService[actPlayer]:=Save.SService[actPlayer]-1;
            end;
            WRITEDATA(0);
         end;
         if (IBase^.MouseX in [320..340]) and (IBase^.MouseY in [300..320])
         and (Save.WorldFlag=WFLAG_JAHADR) and (Save.JSteuer[ActPlayer]>0) then begin
            while Save.JSteuer[ActPlayer]>0 do begin
               Save.JSteuer[ActPlayer]:=Save.JSteuer[ActPlayer]-1;
               WRITEDATA(1);
               PLAYSOUND(1,300);
               delay(10);
            end;
            GOTOWAR(ActPlayerFlag,FLAG_OTHER);
            exit;
         end;
      end;
   until (RData^ and 1024=0);
end;



procedure DOSSIER(Cheat :boolean);

var i   :integer;

begin
   MAKEBORDER(MyScreen[1]^,0,50,510,255,12,6,0);
   MAKEBORDER(MyScreen[1]^,0,256,510,442,12,6,0);
   WRITE(175,60,12,32,MyScreen[1]^,3,PText[686]);
   WRITE(275,60,12,32,MyScreen[1]^,3,PText[687]);
   WRITE(345,60,12,32,MyScreen[1]^,3,PText[688]);
   WRITE(430,60,12,32,MyScreen[1]^,3,PText[689]);
   WRITE(500,60,12,32,MyScreen[1]^,3,PText[690]);
   for i:=1 to pred(MAXCIVS) do if ((Save.WarState[i,ActPlayer]<>LEVEL_UNKNOWN)
   or (i=ActPlayer) or Cheat) and ((i<8) or
   not (Save.WorldFlag in [0,WFLAG_FIELD])) then begin
      s:=GETCIVNAME(i);
      WRITE(14,i*20+70,GETCIVFLAG(i),0,MyScreen[1]^,3,s);
      if i<8 then WRITE(i*73-35,265,GETCIVFLAG(i),16,MyScreen[1]^,3,s);
      case Save.WarState[ActPlayer,i] of
         LEVEL_ALLIANZ: s:=PText[692];
         LEVEL_WAR:     s:=PText[693];
         LEVEL_DIED:    s:='---';
         otherwise      s:=PText[694];
      end;
      if i<>ActPlayer then WRITE(175,i*20+70,GETCIVFLAG(i),32,MyScreen[1]^,3,s);
      if (i=ActPlayer) or (Save.WarState[ActPlayer,i]=LEVEL_DIED) or
      (Save.SSMoney[ActPlayer,i]>Save.WarPower[i]*39) or (Cheat) then begin
         s:=intstr(Save.Bevölkerung[i])+' Mio';
         WRITE(275,i*20+70,GETCIVFLAG(i),32,MyScreen[1]^,3,s);
         s:=intstr(Save.WarPower[i]);
         WRITE(345,i*20+70,GETCIVFLAG(i),32,MyScreen[1]^,3,s);
         s:=intstr(Save.Staatstopf[i]);
         WRITE(430,i*20+70,GETCIVFLAG(i),32,MyScreen[1]^,3,s);
         for j:=1 to 7 do if ((i in [1..7]) or not (Save.WorldFlag in [0,WFLAG_FIELD]))
         and (not (Save.WarState[i,j] in [LEVEL_DIED,LEVEL_UNKNOWN])
         or Cheat) and ((i<>j) or (GETCIVVAR(Save.WorldFlag)=i)) then begin
            case Save.WarState[i,j] of
               LEVEL_ALLIANZ: s:=PText[692];
               LEVEL_DIED:    s:='---';
               LEVEL_WAR:     s:=PText[693];
               otherwise begin
                  s:=PText[694];
                  if (Save.WorldFlag=WFLAG_JAHADR) and (i=8) and (Save.JSteuer[j]>0)
                  then s:=PText[696];
               end;
            end;
            if (i=j) and (GETCIVVAR(Save.WorldFlag)=i)
            then WRITE(j*73-35,267+i*18,GETCIVFLAG(i),21,MyScreen[1]^,3,PText[693])
            else WRITE(j*73-35,267+i*18,GETCIVFLAG(i),16,MyScreen[1]^,3,s);
         end;
      end else WRITE(210,i*20+70,GETCIVFLAG(i),0,MyScreen[1]^,3,PText[697]);
      s:=intstr(Save.ImperatorState[i]);
      WRITE(500,i*20+70,GETCIVFLAG(i),32,MyScreen[1]^,3,s);
   end;
   WAITLOOP(false);
end;



procedure PROJEKTE;

var i,k,CivVar          :byte;
var j                   :word;
var YPos                :array [1..7] of word;
var MyPlanetHeader      :^r_PlanetHeader;

begin
   MAKEBORDER(MyScreen[1]^,0,1,511,511,12,6,0);
   for i:=1 to 3 do begin
      WRITE(i*167+5,15,12,32,MyScreen[1]^,1,Project[i]);
      YPos[i]:=40;
   end;
   for i:=1 to Save.SYSTEMS do with SystemHeader[i] do if PlanetMemA>0 then begin
      for j:=1 to SystemHeader[i].Planets do begin
         MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
         if MyPlanetHeader^.PFlags and FLAG_CIV_MASK<>0 then with MyPlanetHeader^ do begin
            CivVar:=GETCIVVAR(PFlags);
            if (Save.SSMoney[ActPlayer,CivVar]>Save.WarPower[CivVar]*39)
            or (CivVar=ActPlayer) then
            for k:=1 to 3 do if (ProjectPtr^[k]<>0) and (YPos[k]<500) then begin
               WRITE(k*167+5,YPos[k],GETCIVFLAG(CivVar),32,MyScreen[1]^,1,PName);
               YPos[k]:=YPos[k]+11;
            end;
         end;
      end;
   end;
   j:=0;
   for i:=1 to 3 do if YPos[i]>j then j:=YPos[i];
   j:=j+15;
   if j<500 then begin
      for i:=1 to 7 do YPos[i]:=j;
      SetAPen(^MyScreen[1]^.RastPort,12);
      Move(^MyScreen[1]^.RastPort,10,YPos[1]-10);
      Draw(^MyScreen[1]^.RastPort,500,YPos[1]-10);
      for i:=4 to 7 do begin
         WRITE((i-3)*125+5,YPos[i],12,32,MyScreen[1]^,1,Project[i]);
         YPos[i]:=YPos[i]+15;
      end;
      for i:=1 to Save.SYSTEMS do with SystemHeader[i] do if PlanetMemA>0 then begin
         for j:=1 to SystemHeader[i].Planets do begin
            MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
            if MyPlanetHeader^.PFlags and FLAG_CIV_MASK<>0 then with MyPlanetHeader^ do begin
               CivVar:=GETCIVVAR(PFlags);
               if (Save.SSMoney[ActPlayer,CivVar]>Save.WarPower[CivVar]*39)
               or (CivVar=ActPlayer) then
               for k:=4 to 7 do if (ProjectPtr^[k]<>0) and (YPos[k]<500) then begin
                  WRITE((k-3)*125+5,YPos[k],GETCIVFLAG(CivVar),32,MyScreen[1]^,1,PName);
                  YPos[k]:=YPos[k]+11;
               end;
            end;
         end;
      end;
   end;
   j:=0;
   for i:=1 to 7 do if YPos[i]>j then j:=YPos[i];
   j:=j+30;
   if j<500 then begin
      for i:=4 to 7 do YPos[i]:=j;
      SetAPen(^MyScreen[1]^.RastPort,12);
      Move(^MyScreen[1]^.RastPort,10,YPos[4]-25);
      Draw(^MyScreen[1]^.RastPort,500,YPos[4]-25);
      WRITE(255,YPos[4]-15,12,16,MyScreen[1]^,1,PText[698]);
      for i:=1 to Save.SYSTEMS do with SystemHeader[i] do if PlanetMemA>0 then begin
         for j:=1 to SystemHeader[i].Planets do begin
            MyPlanetHeader:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
            if MyPlanetHeader^.PFlags and FLAG_CIV_MASK<>0 then with MyPlanetHeader^ do begin
               CivVar:=GETCIVVAR(PFlags);
               if (Save.SSMoney[ActPlayer,CivVar]>Save.WarPower[CivVar]*39)
               or (CivVar=ActPlayer) then
               if (ProjectID in [4..7]) and (YPos[ProjectID]<500) then begin
                  WRITE((ProjectID-3)*125+5,YPos[ProjectID],GETCIVFLAG(CivVar),32,MyScreen[1]^,1,PName);
                  YPos[ProjectID]:=YPos[ProjectID]+11;
               end;
            end;
         end;
      end;
   end;
   WAITLOOP(false);
end;



procedure STATISTIK;

type XStr9=array[1..9] of str;

var ActPProjects                                :^ByteArr42;
var MyPlanet                                    :^r_PlanetHeader;
var Produktivität,Kreativität,Planeten,Bio,Infra,
    Ind,Grösse,Eth,l,Buildings                  :long;
var Str9                                        :XStr9;

begin
   Produktivität:=0; Kreativität:=0; Planeten:=0; Bio:=0;
   Infra:=0;         Ind:=0;         Grösse:=0;   Eth:=0;
   Buildings:=0;
   for i:=1 to Save.SYSTEMS do if (SystemFlags[ActPlayer,i] and FLAG_KNOWN=FLAG_KNOWN) then
    with SystemHeader[i] do for j:=1 to Planets do begin
      MyPlanet:=ptr(PlanetMemA+pred(j)*sizeof(r_PlanetHeader));
      with MyPlanet^ do if (PFlags and FLAG_CIV_MASK=ActPlayerFlag) then begin
         ActPProjects:=ProjectPtr;
         Planeten:=Planeten+1;
         Kreativität:=Kreativität+      ActPProjects^[33]+ActPProjects^[35]+
                      ActPProjects^[36]+ActPProjects^[38]+ActPProjects^[42];
         Produktivität:=Produktivität+    ActPProjects^[31]+ActPProjects^[37]+
                        ActPProjects^[38]+ActPProjects^[41]+ActPProjects^[42];
         Buildings:=Buildings+       ActPProjects^[30]+ActPProjects^[31]+
                    ActPProjects^[35]+ActPProjects^[36]+ActPProjects^[37]+
                    ActPProjects^[38]+ActPProjects^[39]+ActPProjects^[41];
         if ActPProjects^[34]>0 then Buildings:=Buildings+1;
         if ActPProjects^[40]>0 then Buildings:=Buildings+1;
         Bio:=Bio+Biosphäre;
         Infra:=Infra+Infrastruktur;
         Ind:=Ind+Industrie;
         Grösse:=Grösse+Size;
         if (Ethno<>0) and (PFlags and FLAG_CIV_MASK<>Ethno) then Eth:=Eth+1;
      end;
   end;
   MAKEBORDER(MyScreen[1]^,10,30,500,390,12,6,0);
   Str9:=XStr9(PText[700],PText[701],PText[702],PText[703],PText[704],PText[705],
               PText[706],PText[707],PText[708]);
   for i:=1 to 9 do WRITE(30,30+i*20,12,0,MyScreen[1]^,4,Str9[i]);
   if Planeten>0 then begin
      s:=realstr(Kreativität/Planeten*20,2)+'%';
      WRITE(365,50,8,32,MyScreen[1]^,2,s);
      s:=realstr(Produktivität/Planeten*20,2)+'%';
      WRITE(365,70,8,32,MyScreen[1]^,2,s);
      s:=realstr(Bio/Planeten/2,2)+'%';
      WRITE(365,90,8,32,MyScreen[1]^,2,s);
      s:=realstr(Infra/Planeten/2,2)+'%';
      WRITE(365,110,8,32,MyScreen[1]^,2,s);
      s:=realstr(Ind/Planeten/2,2)+'%';
      WRITE(365,130,8,32,MyScreen[1]^,2,s);
      s:=intstr(round(Save.Bevölkerung[ActPlayer]/Planeten));
      WRITE(350,150,8,32,MyScreen[1]^,2,s);
      s:=intstr(round(Grösse/Planeten/10));
      WRITE(350,170,8,32,MyScreen[1]^,2,s);
      s:=realstr(Eth/Planeten*100,2)+'%';
      WRITE(365,190,8,32,MyScreen[1]^,2,s);
   end;

   WRITE(30,240,ActPlayerFlag,0,MyScreen[1]^,4,PText[686]);
   WRITE(60,260,ActPlayerFlag,0,MyScreen[1]^,4,PText[710]);
   WRITE(60,280,ActPlayerFlag,0,MyScreen[1]^,4,PText[711]);

   if Planeten>0 then begin
      l:=round((Buildings/Planeten*10)+(Bio/Planeten/2)+(Infra/Planeten/2));
      s:=realstr(l/3.1,2)+'%';
      WRITE(385,260,8,32,MyScreen[1]^,2,s);
      case round(l/31) of
         0: s:=PText[712]
         1: s:=PText[713]
         2: s:=PText[714]
         3: s:=PText[715]
         4: s:=PText[716]
         5: s:=PText[717]
         6: s:=PText[718]
         7: s:=PText[719]
         8: s:=PText[720]
         otherwise s:=PText[721];
      end;
      WRITE(280,280,ActPlayerFlag,0,MyScreen[1]^,4,s);

      l:=l div 3;
      if l<10 then s:=PText[723]
      else if l in [10..20] then s:=PText[724]
      else if l in [20..30] then s:=PText[725]
      else if l in [30..40] then s:=PText[726]
      else if l in [40..50] then s:=PText[727]
      else if l in [50..60] then s:=PText[728]
      else if l in [60..70] then s:=PText[729]
      else if l in [70..80] then s:=PText[730]
      else if l in [80..90] then s:=PText[731]      
      else if l>90 then s:=PText[732];
      WRITE(260,210,12,0,MyScreen[1]^,4,s);
   end;
   s:=PText[735]+': '+intstr(Militärausgaben[ActPlayer]);
   WRITE(30,310,12,0,MyScreen[1]^,4,s);
   s:=PText[736]+': '+intstr(Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]] div succ(AllCreative[ActPlayer]))+' '+PText[148];
   WRITE(30,330,12,0,MyScreen[1]^,4,s);
   s:=PText[674]+': '+intstr(Save.ImperatorState[ActPlayer])+' '+PText[414];
   WRITE(30,350,12,0,MyScreen[1]^,4,s);
   s:=intstr(MaquesShips)+'  '+intstr(Save.WarPower[9]);
   WRITE(13,32,12,0,MyScreen[1]^,1,s);
   WAITLOOP(false);
end;



procedure FORSCHUNG;

var l   :long;
var i   :byte;
var s   :string;

begin
   MAKEBORDER(MyScreen[1]^,0,0,510,330,12,6,0);
   WRITE(255,10,ActPlayerFlag,16,MyScreen[1]^,4,PText[737]);
   for i:=1 to 2 do for j:=1 to 21 do if Save.TechCosts[ActPlayer,pred(i)*21+j]<=0 then
    WRITE(pred(i)*245+10,j*14+15,12,0,MyScreen[1]^,3,TechnologyL[pred(i)*21+j])
   else
    WRITE(pred(i)*245+10,j*14+15,29,0,MyScreen[1]^,3,TechnologyL[pred(i)*21+j]);

   MAKEBORDER(MyScreen[1]^,0,331,510,400,12,6,0);
   if Save.ActTech[ActPlayer]>0 then begin
      s:=TechnologyL[Save.ActTech[ActPlayer]]+', '+intstr(Save.TechCosts[ActPlayer,Save.ActTech[ActPlayer]] div succ(AllCreative[ActPlayer]))+' '+PText[148];
      WRITE(255,342,ActPlayerFlag,16,MyScreen[1]^,4,s);
      MAKEBORDER(MyScreen[1]^,20,365,492,390,6,12,0);
      l:=Save.TechCosts[ActPlayer,Save.ActTech[1]];
      if l<0 then l:=0;
      RECT(MyScreen[1]^,8,22,367,490-round(468*l/Save.TechCosts[ActPlayer,42]),388);
   end else WRITE(255,342,ActPlayerFlag,16,MyScreen[1]^,4,PText[173]);

   {ShipData:    MaxLoad,MaxShield,MaxMove,WeaponPower}
   MAKEBORDER(MyScreen[1]^,0,401,510,510,12,6,0);
   WRITE(10,410,12,0,MyScreen[1]^,3,PText[740]);
   WRITE(110,410,12,0,MyScreen[1]^,3,PText[741]);
   WRITE(210,410,12,0,MyScreen[1]^,3,PText[742]);
   WRITE(310,410,12,0,MyScreen[1]^,3,PText[743]);
   WRITE(410,410,12,0,MyScreen[1]^,3,PText[744]);
   l:=0;
   for i:=24 downto 8 do if (Save.TechCosts[ActPlayer,ProjectNeedsTech[i]]<=0) then begin
      if (l<4) then begin
         l:=l+1;
         WRITE(10,415+l*18,ActPlayerFlag,0,MyScreen[1]^,3,Project[i]);
         s:=intstr(ShipData[i].MaxLoad);     WRITE(150,415+l*18,ActPlayerFlag,32,MyScreen[1]^,3,s);
         s:=intstr(ShipData[i].MaxMove);     WRITE(250,415+l*18,ActPlayerFlag,32,MyScreen[1]^,3,s);
         s:=intstr(ShipData[i].MaxShield);   WRITE(350,415+l*18,ActPlayerFlag,32,MyScreen[1]^,3,s);
         s:=intstr(ShipData[i].WeaponPower); WRITE(450,415+l*18,ActPlayerFlag,32,MyScreen[1]^,3,s);
      end;
   end;
   WAITLOOP(false);
end;



begin
   MAKEBORDER(MyScreen[1]^,194,119,316,276,12,6,1);
   for i:=1 to 7 do DrawImage(^MyScreen[1]^.RastPort,^GadImg1,198,100+i*22);
   WRITE(255,124,0,16,MyScreen[1]^,4,PText[746]);
   WRITE(255,146,0,16,MyScreen[1]^,4,PText[747]);
   WRITE(255,168,0,16,MyScreen[1]^,4,PText[748]);
   WRITE(255,190,0,16,MyScreen[1]^,4,PText[749]);
   WRITE(255,212,0,16,MyScreen[1]^,4,PText[750]);
   WRITE(255,234,0,16,MyScreen[1]^,4,PText[751]);
   WRITE(255,256,8,16,MyScreen[1]^,4,PText[752]);
   b:=false;
   repeat
      delay(RDELAY);
      if (LData^ and 64=0) then begin
         if IBase^.MouseX in [196..314] then begin
            if IBase^.MouseY in [122..142] then begin
               KLICKGAD(198,122);   MILITÄR;     b:=true;
            end else if IBase^.MouseY in [144..164] then begin
               KLICKGAD(198,144);   FINANZEN;    b:=true;
            end else if IBase^.MouseY in [166..186] then begin
               KLICKGAD(198,166);   DOSSIER(false);     b:=true;
            end else if IBase^.MouseY in [188..208] then begin
               KLICKGAD(198,188);   PROJEKTE;    b:=true;
            end else if IBase^.MouseY in [210..230] then begin
               KLICKGAD(198,210);   STATISTIK;   b:=true;
            end else if IBase^.MouseY in [232..252] then begin
               KLICKGAD(198,232);   FORSCHUNG;   b:=true;
            end else if IBase^.MouseY in [254..274] then begin
               KLICKGAD(198,254);
               RECT(MyScreen[1]^,0,194,119,316,276);
               REFRESHDISPLAY;
               PUMPUPTHELEVEL;
               b:=true;
            end
         end;
      end;
   until b or (RData^ and 1024=0);
   DRAWSTARS(MODE_REDRAW,ActPlayer);
end;





procedure SMALLGAMEEXIT;

var i           :byte;

begin
   DMACON_WRITE^:=$000F;
   if ImgBitMap4.MemA<>0 then FreeMem(ImgBitMap4.MemA,ImgBitMap4.MemL);
   ImgBitMap4.MemA:=0;
   if ImgBitMap7.MemA<>0 then FreeMem(ImgBitMap7.MemA,ImgBitMap7.MemL);
   ImgBitMap7.MemA:=0;
   if ImgBitMap8.MemA<>0 then FreeMem(ImgBitMap8.MemA,ImgBitMap8.MemL);
   ImgBitMap8.MemA:=0;
   for i:=1 to MODULES do if ModMemA[i]>0 then begin
      FreeMem(ModMemA[i],ModMemL[i]); ModMemA[i]:=0;
   end;
   for i:=1 to CACHES do if CacheMemA[i]>0 then begin
      FreeMem(CacheMemA[i],CacheMemL[i]); CacheMemA[i]:=0;
   end;
   for i:=0 to (MAXCIVS-2) do if LogoMemA[i]>0 then begin
      FreeMem(LogoMemA[i],LOGOSIZE);  LogoMemA[i]:=0;
   end;
   for i:=0 to (MAXCIVS-2) do if LogoSMemA[i]>0 then begin
      FreeMem(LogoSMemA[i],LogoSMemL[i]);  LogoMemA[i]:=0;
   end;
end;




procedure GAMEEXIT;

var i   :integer;

begin
   SMALLGAMEEXIT;
   for i:=0 to IMAGES do if IMemA[i]>0 then begin
      FreeMem(IMemA[i],IMemL[i]);     IMemA[i]:=0;
   end;
   for i:=1 to SOUNDS do if SoundMemA[i]>0 then begin
      FreeMem(SoundMemA[i],SoundSize[i]*2);
      SoundMemA[i]:=0;
   end;
   if ZeroSound>0 then begin
      FreeMem(ZeroSound,8);           ZeroSound:=0;
   end;
   OpenWorkBench;
   CLOSEMYSCREENS;
   FREESYSTEMMEMORY;
   if PathMemA>0  then FreeMem(PathMemA,PathMemL);
   if XScreen<>NIL then CloseScreen(XScreen);
end;



procedure ENDSEQUENZ(Mode :short);

type SArr13=array [1..11] of str;

var SA13        :SArr13;
var i,j,t       :byte;
var FHandle     :BPTR;
var MPTR        :long;
var s2          :string;

begin
   ScreenToFront(XScreen);
   SMALLGAMEEXIT;
   while MyScreen[1]^.FirstWindow<>NIL do CloseWindow(MyScreen[1]^.FirstWindow);
   CloseScreen(MyScreen[1]);

   IMemL[0]:=230656;
   IMemA[0]:=AllocMem(IMemL[0],MEMF_CHIP);
   if IMemA[0]=0 then exit;
   MyScreen[1]:=OPENCINEMA(8);
   if MyScreen[1]=NIL then exit;
   if Mode in [1,-3] then s:=PathStr[5]+'MOD.HappyEnd' else s:=PathStr[5]+'MOD.DeadEnd';
   FHandle:=OPENSMOOTH(s,MODE_OLDFILE);
   if FHandle<>0 then DosClose(FHandle);
   MPTR:=LoadModule(s);
   PlayModule(MPTR);
   delay(5);

   t:=8;
   if Mode=-1 then begin
      if Save.WorldFlag=WFLAG_FIELD then begin
         s:=PathStr[5]+'FieldEnd.pal';
         i:=SETCOLOR(MyScreen[1]^,s);
         s:=PathStr[5]+'FieldEnd.img';
      end else begin
         s:=PathStr[5]+'DeadEnd.pal';
         i:=SETCOLOR(MyScreen[1]^,s);
         s:=PathStr[5]+'DeadEnd.img';
      end;
   end else if Mode=-2 then begin
      s:=PathStr[5]+'BigBang.pal';
      i:=SETCOLOR(MyScreen[1]^,s);
      s:=PathStr[5]+'BigBang.img';
   end else begin
      s:=PathStr[5]+'HappyEnd.pal';
      i:=SETCOLOR(MyScreen[1]^,s);
      s:=PathStr[5]+'HappyEnd.img';
   end;
   if not DISPLAYIMAGE(s,0,75,640,360,8,MyScreen[1]^,0) then begin end;
   SetRGB4(^MyScreen[1]^.ViewPort,255,7,7,7);
   if Mode=-1 then begin
      s:=PText[758]+' '+intstr(Year)+' '+PText[759];
      if Save.WorldFlag=WFLAG_FIELD then begin
         SA13:=SArr13(s,PText[760],PText[761],PText[762],PText[763],PText[764],
                        PText[765],PText[766],PText[767],PText[768],PText[769]);
         t:=11;
      end else begin
         s2:=PText[771]+' '+GETCIVADJ(ActPlayer)+PText[772];
         SA13:=SArr13(s,s2,PText[773],PText[774],PText[775],PText[776],PText[777],
                           PText[778],PText[779],PText[780],'');
         t:=10;
      end;
   end else if Mode=-2 then begin
      s:=intstr(Year)+' '+PText[782]+' '+GETCIVNAME(ActPlayer)+' '+PText[783];
      SA13:=SArr13(s,PText[784],PText[785],PText[786],PText[787],PText[788],
                     PText[789],PText[790],PText[791],'','');
         t:=9;
   end else if Mode=-3 then begin
      Save.ImperatorState[ActPlayer]:=Save.ImperatorState[ActPlayer]-1500;
      s:=PText[793]+' '+intstr(Year)+' '+PText[794]+' '+GETCIVNAME(ActPlayer)+' '+PText[795];
      SA13:=SArr13(s,PText[796],PText[797],PText[798],PText[799],PText[800],
                     PText[801],PText[802],PText[803],PText[804],'');
      t:=10;
   end else if Mode=1 then begin
      s:='';
      if ActPlayer<>3 then s:='n';
      s:=PText[793]+' '+intstr(Year)+' '+PText[794]+' '+GETCIVNAME(ActPlayer)+s+', '+PText[806];
      SA13:=SArr13(s,PText[807],PText[808],PText[809],PText[810],PText[811],
                     PText[812],PText[813],PText[814],'','');
      t:=9;
   end else begin
      s:='';
      if Mode<>3 then s:='n';
      s:=PText[793]+' '+intstr(Year)+' '+PText[794]+' '+GETCIVNAME(Mode)+s+', '+PText[816];
      SA13:=SArr13(s,PText[817],PText[818],PText[819],PText[820],PText[821],
                     PText[822],PText[823],'','','');
   end;
   ScreenToFront(MyScreen[1]);
   delay(200);
   for i:=1 to t do begin
      WRITE(320,i*25+80,255,80,MyScreen[1]^,5,SA13[i]);
      delay(50);
   end;
   if Mode=-2 then WRITE(320,340,255,16,MyScreen[1]^,1,'(Womit bewiesen wäre, daß unser Universum geschlossen ist!)');
   WAITLOOP(false);
   if MPTR<>0 then begin
      StopPlayer;
      UnloadModule(MPTR);
   end;
   SWITCHDISPLAY;
   RECT(MyScreen[1]^,0,0,75,639,434);
end;



procedure DISPLAYSTATE;

var l   :long;

begin
   Screen2:=0;
   SetRGB4(^MyScreen[2]^.ViewPort,0,0,0,3);
   SetRGB4(^MyScreen[2]^.ViewPort,1,12,12,15);
   SetRGB4(^MyScreen[2]^.ViewPort,2,15,0,3);
   RECT(MyScreen[2]^,0,0,0,639,511);
   WRITE(320,40,1,16,MyScreen[2]^,5,PText[825]);

   WRITE(100,130,1,0,MyScreen[2]^,4,PText[826]);
   s:=intstr(Save.ImperatorState[ActPlayer]);
   WRITE(540,130,2,32,MyScreen[2]^,2,s);

   WRITE(100,160,1,0,MyScreen[2]^,4,PText[827]);
   s:=intstr(round(Save.ImperatorState[ActPlayer]*(1+Level/30))-Save.ImperatorState[ActPlayer]);
   WRITE(540,160,2,32,MyScreen[2]^,2,s);

   WRITE(100,190,1,0,MyScreen[2]^,4,PText[828]);
   s:=intstr(-Year); if Year<0 then s:='0';
   WRITE(540,190,2,32,MyScreen[2]^,2,s);

   WRITE(540,210,2,32,MyScreen[2]^,2,'-------');

   WRITE(100,240,1,0,MyScreen[2]^,4,PText[829]);
   l:=round(Save.ImperatorState[ActPlayer]* (1+Level/30));
   if Year>0 then s:=intstr(l-Year) else s:=intstr(l);
   WRITE(540,240,2,32,MyScreen[2]^,2,s);

   WRITE(540,270,2,32,MyScreen[2]^,2,'-------');
   WRITE(540,275,2,32,MyScreen[2]^,2,'-------');
   ScreenToFront(MyScreen[2]);
   repeat
      delay(RDELAY);
   until (LData^ and 64=0) or (RData^ and 1024=0);
   PLAYSOUND(1,300);
   repeat
      delay(RDELAY);
   until (not (LData^ and 64=0) and not (RData^ and 1024=0)) or Bool;
end;



procedure MAIN;

var i,j         :integer;
var l           :long;
var s           :string;

begin
   if not INITLANG then exit;
   INITVARS;
   OpenLib(DiskFontBase,'diskfont.library',0);
   CustomTA[1]:=TextAttr('StarFont.font',11,0,0);
   CustomTA[2]:=TextAttr(CustomTA[1].ta_Name,14,0,0);
   CustomTA[3]:=TextAttr(CustomTA[1].ta_Name,15,0,0);
   CustomTA[4]:=TextAttr(CustomTA[1].ta_Name,17,0,0);
   CustomTA[5]:=TextAttr(CustomTA[1].ta_Name,24,2,0);
   for i:=1 to FONTS do begin
      CustomFont[i]:=OpenDiskFont(^CustomTA[i]);
      if CustomFont[i]=NIL then begin
         DisplayBeep(NIL);
         error('Can`t find StarFont 14, 15, 17 and 24!');
      end;
   end;
   CloseLib(DiskFontBase);
   IBase:=IntBase;
   LData:=ptr($BFE001);
   LData^:=LData^ or 2;
   RData:=ptr($DFF016);

   FHandle:=DosOpen('Paths.txt',MODE_OLDFILE);
   if FHandle=0 then exit;
   PathMemL:=DosSeek(FHandle,0,OFFSET_END);
   PathMemL:=DosSeek(FHandle,0,OFFSET_BEGINNING);
   PathMemA:=AllocMem(PathMemL,MEMF_CLEAR);
   if PathMemA=0 then begin
      DosClose(FHandle);
      writeln('Can`t find file Paths.txt!');
      exit;
   end;
   l:=DosRead(FHandle,ptr(PathMemA),PathMemL);
   DosClose(FHandle);
   CREATEPATHS;

   HelpID:=$A0000;
   INITSTDTAGS;
   NeuScreen:=NewScreen(0,0,116,201,7,0,0,HIRES+LACE,CUSTOMSCREEN+SCREENQUIET,NIL,'',NIL,NIL);
   XScreen:=OpenScreenTagList(^NeuScreen,^Tags);
   if XScreen=NIL then begin
      HelpID:=$20000;
      INITSTDTAGS;
      XScreen:=OpenScreenTagList(^NeuScreen,^Tags);
   end;
   if XScreen=NIL then begin
      writeln('Can`t open screen!');
      GAMEEXIT;
      exit;
   end;
   for i:=1 to 127 do SetRGB4(^XScreen^.ViewPort,i,0,0,0);
   INITCHANNELS;
   MAININTRO;
   if not OPENMAINSCREENS then begin
      GAMEEXIT;
      writeln('Can`t open screens!');
      exit;
   end;
   WBench:=CloseWorkBench;

   s:='Not enougn memory available!';
   with ImgBitMap4 do begin
      MemL:=29184;   {608 x 96 x 4}
      MemA:=AllocMem(MemL,MEMF_CHIP+MEMF_CLEAR);
      if MemA=0 then begin
         GAMEEXIT;
         writeln(s);
         exit;
      end;
      ImgBitMap4:=ITBitMap(76,96,1,4,0,ptr(MemA),      ptr(MemA+7296), ptr(MemA+14592),
                                       ptr(MemA+21888),NIL,NIL,NIL,NIL,MemA,MemL);
   end;
   with ImgBitMap7 do begin
      MemL:=28672;   {512 x 64 x 7}
      MemA:=AllocMem(MemL,MEMF_CHIP+MEMF_CLEAR);
      if MemA=0 then begin
         GAMEEXIT;
         writeln(s);
         exit;
      end;
      ImgBitMap7:=ITBitMap(64,64,1,7,0,ptr(MemA),      ptr(MemA+4096), ptr(MemA+8192),
                                       ptr(MemA+12288),ptr(MemA+16384),ptr(MemA+20480),
                                       ptr(MemA+24576),NIL,MemA,MemL);
   end;
   with ImgBitMap8 do begin
      MemL:=122880;  {640 x 192 x 8}
      MemA:=AllocMem(MemL,MEMF_CHIP+MEMF_CLEAR);
      if MemA=0 then begin
         GAMEEXIT;
         writeln(s);
         exit;
      end;
      ImgBitMap8:=ITBitMap(80,192,1,8,0,ptr(MemA),     ptr(MemA+15360),ptr(MemA+30720),
                                       ptr(MemA+46080),ptr(MemA+61440),ptr(MemA+76800),
                                       ptr(MemA+92190),ptr(MemA+107520),MemA,MemL);
   end;
   IMemL[0]:=287000;
   IMemA[0]:=AllocMem(IMemL[0],MEMF_CHIP);
   s:='Not enough memory!';
   if IMemA[0]=0 then begin
      GAMEEXIT;
      writeln(s);
      exit;
   end;
   ZeroSound:=AllocMem(8,MEMF_CHIP+MEMF_CLEAR);
   if ZeroSound=0 then begin
      GAMEEXIT;
      writeln(s);
      exit;
   end;
   INITCHANNELS;
   INITSOUNDS;
   i:=0;
   if not WBench then begin
      WRITE(320,100,1,16,MyScreen[1]^,4,PText[831]);
      SetRGB4(^MyScreen[1]^.ViewPort,1,15,15,15);
      WRITE(320,130,1,16,MyScreen[1]^,4,PText[832]);
      ScreenToFront(MyScreen[1]);
      WAITLOOP(false);
      RECT(MyScreen[1]^,0,0,0,639,511);
   end;
   SWITCHDISPLAY;
   if not INITDESK(1) then begin
      GAMEEXIT;
      writeln('Intuition-Error');
      exit;
   end;
   b:=1;
   repeat
      b:=FIRSTMENU;
   until b<>2;
   if not INITSTARS then begin
      GAMEEXIT;
      writeln(s);
      exit;
   end;
   DRAWSTARS(MODE_REDRAW,ActPlayer);
   ScreenToFront(MyScreen[1]);
   if b=1 then Bool:=DISKMENU(2) else STARTROTATEPLANETS(0);
   repeat
      delay(RDELAY);
      CLOCK;
      ScreenToFront(MyScreen[1]);
      RawCode:=GETRAWCODE;
      if Multiplayer then begin
         ShipData[8].MaxMove:=3;   ShipData[9].MaxMove:=3;
         ShipData[10].MaxMove:=3;
      end;

      if (Save.PlayMySelf) or (Save.CivPlayer[ActPlayer]=0) or not Informed
      or (not Multiplayer and not Informed and (Year mod 10<>0)) then STARTROTATEPLANETS(0) else begin
         if (LData^ and 64=0) or (RData^ and 1024=0) then delay(3);
         if ((LData^ and 64=0) and (IBase^.MouseX in [518..634]) and (IBase^.MouseY in [472..492]))
          or ((LData^ and 64=0) and (RData^ and 1024=0)) or (RawCode in [64,67,68]) then begin
            KLICKGAD(518,472);
            STARTROTATEPLANETS(0);
         end;
         if (LData^ and 64=0) and (Save.CivPlayer[ActPlayer]<>0) then begin

            if (IBase^.MouseX in [0..512]) and (IBase^.MouseY in [0..512]) then begin
               PLAYSOUND(1,300);
               if SystemFlags[ActPlayer,LastSystem] and FLAG_KNOWN=FLAG_KNOWN then HANDLESYSTEM(LastSystem,NIL)
            end else if IBase^.MouseX in [518..634] then begin
               if IBase^.MouseY in [444..464] then begin
                  KLICKGAD(518,444);
                  if not DISKMENU(0) then begin
                     GAMEEXIT;
                     exit;
                  end;
               end else if IBase^.MouseY in [416..436] then begin
                  KLICKGAD(518,416);
                  REGIERUNG
               end;
            end;
         end else WRITEGALAXYDATA(0,0);
      end;
      Bool:=false;
      if Save.WorldFlag=WFLAG_FIELD then begin
         if Save.Systems<=1 then Bool:=true
      end else begin
         l:=0;
         for i:=1 to MAXCIVS do if (Save.CivPlayer[i]<>0) and (i<>ActPlayer) then l:=l+Save.Bevölkerung[i];
         if (Save.Bevölkerung[1]+Save.Bevölkerung[2]+Save.Bevölkerung[3]+
             Save.Bevölkerung[4]+Save.Bevölkerung[5]+Save.Bevölkerung[6]+
             Save.Bevölkerung[7]+Save.Bevölkerung[8]-Save.Bevölkerung[ActPlayer]<=20)
         and (l=0) then begin
            Bool:=true;
            if MultiPlayer then begin
               ENDSEQUENZ(-3);
               GAMEEXIT;
               exit;
            end;
         end;
         if not Multiplayer then begin
            if Save.Bevölkerung[1]=0 then begi