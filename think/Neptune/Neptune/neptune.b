{*******************************************************************}
{ Voyage to Neptune                                                 }
{ For ACE basic                                                     }
{ This source is public domain.  Mangle it all you want.            }
{ Take note of these simple rules:                                  }
{ 1. Seek truth.  Get your hands dirty and figure it out.  Don't    }
{    let anyone stop you in this pursuit.                           }
{ 2. Information wants to be free.  Those who share information     }
{    give the universe life.  Those who keep information enslave    }
{    themselves and others.                                         }
{ 3. Question authority.  Each mind must make itself.  Beware of    }
{    those building a golden path, for it probably leads to hell.   }
{ 4. Judge all things by their their important attributes in        }
{    context.  And check your premises.                             }
{ 5. Everything you create is art, good or bad.                     }
{ 6. Pursue happiness and when you have it, invest it in others.    }
{*******************************************************************}


dim STRING Plan(7)
dim SHORTINT Trip_Distance(7)
LONGINT Efficiency, Fuel_Produced, Storage_Decay, Fuel_Used, Rate
LONGINT Total_Time, Used_Breeders, Distance, Temp_Input, Active_Breeders
SHORTINT Flag, Answer_Num, Days, Months, Years, Segment
SHORTINT Menu_Num, Selection_Num, Activated_Gadget, Counter
STRING Answer_String SIZE 10
STRING Temp_String SIZE 40
SINGLE Malfunction, My_Time, Temp_Time, Fuel_Decay

WINDOW 9,"Voyage to Neptune",(0,0)-(637,195),22
{* RENDER GADGETS, BEVEL-BOXES AND TEXT *}
GADGET 255,ON,"Buy Cells",(2,166)-(109,180),BUTTON
GADGET 254,ON,"Buy Fuel",(2,149)-(109,163),BUTTON
GADGET 253,ON,120,(111,166)-(288,179),POTX
GADGET 252,ON,3000,(111,149)-(288,162),POTX
BEVELBOX (2,2)-(626,144),1
GADGET 251,ON,"Make Trip",(417,149)-(520,180),BUTTON
GADGET 250,ON,"Quit",(523,149)-(627,163),BUTTON
GADGET 249,ON,"About",(523,166)-(627,180),BUTTON

{ Set initial values }
Breeders = 120
Total_Fuel = 3000
Segment = 1
for i = 1 to 7
read Plan(I), Trip_Distance(I)
next i
data "Earth",391,"Callisto",403,"Titan",446,"Alpha 1",447
data "Ariel",507,"Theta 2",507,"Neptune",0

RANDOMIZE TIMER

Trade = int(150+(80*RND(1)))

while -1
     if Segment = 7 goto ARRIVAL
     gosub CONDITIONS
     locate 20,37
     PRINT "          ";
     locate 20,37
     PRINT Fuel_Used "Fuel";
     locate 22,37
     PRINT "          ";
     locate 22,37
     PRINT Active_Breeders "Cells";
     GADGET WAIT 0
     Activated_Gadget = GADGET(1)
     CASE
          Activated_Gadget = 255: gosub BUY_CELLS
          Activated_Gadget = 254: gosub BUY_FUEL
          Activated_Gadget = 253: gosub SET_CELLS
          Activated_Gadget = 252: gosub SET_FUEL
          Activated_Gadget = 251: gosub MAKE_TRIP
          Activated_Gadget = 250: gosub QUIT_PROGRAM
          Activated_Gadget = 249: gosub ABOUT
     END CASE
wend

{*********************************************************}
{ Subroutines                                             }
{*********************************************************}

BUY_CELLS:
     if (Total_Fuel - Fuel_Used) < Trade then
          MsgBox "Not enough unused fuel to sell!", "OK"
          return
     end if
     if (Total_Fuel - Trade) < 1500 then
          MsgBox "Dangerously low fuel level!", "OK"
          return
     end if
     Total_Fuel = Total_Fuel - Trade
     GADGET MOD 252, Fuel_Used, Total_Fuel
     ++Breeders
     GADGET MOD 253, Active_Breeders, Breeders
     return
BUY_FUEL:
     if Breeders > 50 then
          --Breeders
          GADGET MOD 253, Active_Breeders, Breeders
          Total_Fuel = Total_Fuel + Trade
          GADGET MOD 252, Fuel_Used, Total_Fuel
     else
          MsgBox "Need 50 breeders to stay operational!", "OK"
     end if
     return
SET_CELLS:
     Temp_Input = GADGET(3)
     if Fuel_Used/20 < Temp_Input then 
          MsgBox "Not enough spent fuel to run breeders!", "OK"
          GADGET MOD 253, Active_Breeders, Breeders
          return
     end if
     if Temp_Input*5 > (Total_Fuel - Fuel_Used) then
          MsgBox "Not enough unused fuel to seed breeders!", "OK"
          GADGET MOD 253, Active_Breeders, Breeders
          return
     end if
     Active_Breeders = Temp_Input
     return
SET_FUEL:
     Temp_Input = GADGET(3)
     if Temp_Input > Total_Fuel then
          MsgBox "Not enough fuel to fill request!", "OK"
          Fuel_Used = Total_Fuel
          GADGET MOD 252, Fuel_Used, Total_Fuel
          return
     end if
     if Temp_Input/20 < Active_Breeders then 
          MsgBox "Not enough spent fuel to run breeders!", "OK"
          GADGET MOD 252, Fuel_Used, Total_Fuel
          return
     end if
     if Active_Breeders*5 > (Total_Fuel - Temp_Input) then
          MsgBox "Not enough unused fuel to seed breeders!", "OK"
          GADGET MOD 252, Fuel_Used, Total_Fuel
          return
     end if
     Fuel_Used = Temp_Input
     return
MAKE_TRIP:
     { Calculate the results of input data }
     Total_Fuel = Total_Fuel - Fuel_Used
     Total_Fuel = Total_Fuel - 5*Active_Breeders
     Efficiency = 56 - Segment*8 + Fuel_Used/40
     if Efficiency>104 then Efficiency = 104 : ' 104 is max efficiency
     Malfunction = RND(1)
     { 10% chance of engine problem }
     if Malfunction < 0.1 then
          MsgBox "Engine Malfunction!", "OK"
          Efficiency = Efficiency*(1-3*Malfunction)
     end if
     Rate = Efficiency*513.89 : 'Rate in mph
     Distance = Distance + Trip_Distance(Segment) : 'Distance in million miles
     My_Time = int(Trip_Distance(Segment)*41667!/Rate) : 'Time in days
     Total_Time = Total_Time + My_Time : 'total trip time
     Fuel_Produced = int(16+18*RND(1))
     Total_Fuel = Total_Fuel + Fuel_Produced*Active_Breeders : 'New Fuel from breeder
     Fuel_Decay = RND(1)
     if Fuel_Decay < 0.2 then Storage_Decay = int(Fuel_Decay*Total_Fuel) : ' How much fuel decayed
     Total_Fuel = Total_Fuel - Storage_Decay : ' Decrease fuel by amount that decayed
     ++Segment
     Fuel_Used = 0
     GADGET MOD 252, 0, Total_Fuel
     Used_Breeders = Active_Breeders
     Active_Breeders = 0
     GADGET MOD 253, 0, Breeders
     Trade = int(150+(80*RND(1)))
     return


{ Print current conditions }
CONDITIONS:
     { clear out the screen }
     FOR i=2 to 17
          locate i,2
          print"                                       ";
          print"                                      "
     NEXT i

     locate 2,2
     print "Location: " Plan(Segment)
     locate 3,2
     print "Distance to Neptune:" 2701-Distance "million miles."
     if Segment > 1 then
          locate 4,2
          print "Distance from Earth:" Distance "million miles."
          locate 5,2
          print "Over the last segment, your average speed was" int(Rate) "mph,"
          locate 6,2
          print "and you covered" Trip_Distance(Segment - 1) "million miles in" My_Time "days."
          Temp_Time = 0.81 * Distance
          locate 7,2
          print "Time estimate for this total distance.";
          gosub CALC_TIME
          Temp_Time = Total_Time
          locate 8,2
          print "Your actual cumulative time was:";
          gosub CALC_TIME
          locate 9,2
          print "You used" Used_Breeders "cells which produced" Fuel_Produced "pounds of fuel each."
          locate 15,2
          print "Your engine worked at" Efficiency "% efficiency last trip."
          if Storage_Decay > 0 then
               locate 10,2 
               print Storage_Decay "pounds of fuel in storage decayed into an unusable state."
          end if
     end if
     locate 11,2
     print "Pounds of nuclear fuel ready for use:" Total_Fuel
     locate 12,2
     print "Operational breeder-reactor cells:" Breeders
     print
     locate 14,2
     print "Solar collectors can fulfill"; 
     print  56 - Segment*8 "% of the fuel requirements of the engines."
     locate 17,2
     print "Breeders are trading for " Trade " pounds of fuel."
     return

{ calculate and print time in years }
CALC_TIME:
     Years = int(Temp_Time/365)
     if Years >= 1 then
          if Years = 1 then
               print " 1 year";
          else
               print Years "years";
          end if
     end if
     Months = int((Temp_Time/365-Years)*12)
     if Months >= 1 then
          if Months = 1 then
               print ", 1 month";
          else
               print "," Months "months";
          end if
     end if
     Days = int(Temp_Time-Years*365 - Months*30.5)
     if Days < 1 then
          print "."
          return
     end if
     if Days = 1 then
          print ", 1 day."
     else
          print "," Days "days."
     end if
     return
     
{************************}
{ Print a line, centered }
{************************}
CENTER_LINE:
     print tab((79 - len(Temp_String))/2) Temp_String;
     return

{********************}
{ ARRIVED AT NEPTUNE }
{********************}
ARRIVAL:
     { clear out the screen }
     FOR i=2 to 17
          locate i,2
          print"                                       ";
          print"                                      "
     NEXT i
     locate 2,2
     print "You finally reached Neptune in";
     Temp_Time = Total_Time
     gosub CALC_TIME
     locate 3,2
     print "Had your engines run at 100% efficiency the entire way,";
     print " you would have"
     locate 4,2
     print "averaged 51,389 mph and completed the trip in exactly 6 years."
     locate 6,2
     if Temp_Time<=2220 then
          Temp_String="Congratulations!  Outstanding job!"
          gosub CENTER_LINE
     else
          Temp_Time = Total_Time - 2190
          print "You trip took longer than this by";
          gosub CALC_TIME
          locate 7,2
          print "Your performance was ";
          Years = Years + 1
          if Years = 1 then
               print "excellent (room for slight improvement)."
          else
               if Years = 2 then
                    print "quite good (but could be better)."
               else
                    if Years = 3 then
                         print "marginal (could do much better)."
                    else
                         print "abysmal (need lots more practice)."
                    end if
               end if
          end if
     end if

     locate 9,2
     if Breeders >= 105 then
          print "Fortunately you have" Breeders "operational breeder-reactor cells"
          locate 10,2
          print "for your return trip.  Very good."
     else
          print "I guess you realize that the return trip will be extremely"
          locate 10,2
          print "chancy with only" Breeders "breeder-reactor cells operational."
     end if

     locate 12,2
     print "With your remaining" Total_Fuel "pounds of fuel and" Breeders "breeder"
     Temp_Time = 42250!/(8+Total_Fuel/40)
     if Temp_Time < 405 then Temp_Time = 405
     locate 13,2
     print "cells, to get back to Theta 2 will take";
     gosub CALC_TIME
     GADGET WAIT 0
     goto QUIT_PROGRAM


ABOUT:
     WINDOW 8,,(0,0)-(640,200),0
     {* RENDER GADGETS, BEVEL-BOXES AND TEXT *}
     GADGET 1,ON,"Very Interesting!",(230,174)-(410,194),BUTTON
     locate 1,1
     print"     Voyage to Neptune is inspired by a program by the same name by David Ahl,"
     print"who wrote lots of books with programs in them in the seventies and eighties."
     print"He also started the magazine Creative Computing many years ago."
     print"     The source to his version of this program is in his book, BASIC Computer"
     print"adventures.  The algorithms are mostly the same, but if you get the chance"
     print"to compare the sources you will find significant differences.  Hopefully"
     print"enough to avoid any silly copyright concerns."
     print"     The story behind the game is that you are piloting a space ship in 2100,"
     print"making the first trip to Neptune.  Mankind has established space stations"
     print"past Uranus and other places in between, however.  So, you will get the"
     print"chance to stop for re-fueling."
     print"     Your ship has two sources of propulsion: solar panels and nuclear rockets."
     print"In addition, you have a multi-celled nuclear breeder reactor which is a tiny"
     print"fusion engine.  It will take used fuel and some unused fuel to create more fuel."
     print"     I'm releasing this program and its source to the public domain.  That"
     print"means anyone can do whatever they want with it.  The source is for ACE basic,"
     print"but it probably isn't much to get it working in AMOS.  You could add lots of"
     print"other routines and make it more fun.  My email address is lda@netcom.com if"
     print"anyone needs to contact me."



     {* GADGET HANDLING CODE STARTS HERE *}
     GADGET WAIT 0
     {* CLEAN UP *}
     GADGET CLOSE 1
     WINDOW CLOSE 8 
     return


QUIT_PROGRAM:
     {* CLEAN UP *}
     FOR Counter=255 TO 249 STEP -1
          GADGET CLOSE Counter
     NEXT
     
     WINDOW CLOSE 9
