/*
 * hotel.m - create hotel code
 */

private tp_hotel CreateTable().

use t_util.
use t_base.
use t_roomTypes.
use t_streets.
use tp_hotel

define tp_hotel p_rRoomList CreateThingListProp().

/****/

define tp_hotel r_foyer CreateThing(r_indoors).
SetupRoom(r_foyer, "in the hotel foyer",
    "There is a receptionist behind a desk to the east, and a restaurant"
    " to the west. There is a lift to the north, and the exit is south.").
r_foyer@p_rNorthDesc:="To the north is a modern looking elevator.".
r_foyer@p_rEastDesc :="To the east is the reception desk. A young lady "
    "sits behind it, reading a magazine. There is a sign on the desk.".
r_foyer@p_rWestDesc :="To the west is a door leading to the restaurant.".
r_foyer@p_rSouthDesc:="To the south is a door which leads outside.".
r_foyer@p_rExitDesc:="To the south is a door which leads outside.".
Connect(r_en2,r_foyer,D_NORTH).
UniConnect(r_en2, r_foyer, D_ENTER).
UniConnect(r_foyer, r_en2, D_EXIT).
r_en2@p_rScenery:="door;plain,wooden,wood.building".
r_foyer@p_rScenery:="entry.foyer;large.desk;reception.door;west,south.magazine;colorful,looking.receptionist.lady".

define tp_hotel r_restaurant CreateThing(r_indoors).
SetupRoom(r_restaurant, "in the hotel restaurant", "** add a description here **").
Connect(r_foyer,r_restaurant,D_WEST).
UniConnect(r_restaurant, r_foyer, D_EXIT).
r_restaurant@p_rScenery:="tables;large".

define tp_hotel r_lift CreateThing(r_indoors).
SetupRoom(r_lift, "in the hotel lift", "The interior of the lift has a "
    "black marble-like finish, which is covered in greasy smears. There "
    "is a control panel with two buttons.").
Connect(r_foyer,r_lift,D_NORTH).
r_lift@p_rScenery:="panel;metal,control.finish;black,marble.marble;black.smear;greasy".

/****/

define tp_hotel proc FindRoom(thing who)thing:
  int count;
  thing room;
  list thing lt;

  lt:=r_lift@p_rRoomList;
  count:=Count(lt)-1;
  while count>-1 do
    room:=lt[count];
    if room@p_oCarryer=who then
      count:=-2;
    else
      count:=count-1;
    fi;
  od;
  if count=-1 then
    nil
  else
    room
  fi
corp;

/****/

/* Create lift button */
define tp_hotel o_button CreateThing(nil).
SetThingStatus(o_button, ts_public).
o_button@p_oInvisible:=true.
o_button@p_oNotGettable:=true.

define tp_hotel o_button1 CreateThing(o_button).
o_button1@p_oName := "button;top.1,1,top,first;button".
o_button1@p_oReadString := "The button is labeled '1'.".
AddTail(r_lift@p_rContents, o_button1).

define tp_hotel o_buttonG CreateThing(o_button).
o_buttonG@p_oName := "button;bottom,2,G.G,bottom,2;button".
o_buttonG@p_oReadString := "The button is labeled 'G'.".
AddTail(r_lift@p_rContents, o_buttonG).

define tp_hotel proc moveLift(thing room)bool:
  if r_lift@p_rSouth~=room then
    /* lift needs to move */
    if room=r_foyer then
      /* going down */
      ABPrint(r_lift,nil,nil,"The lift descends and stops gently at the ground floor. The doors open to reveal the foyer.\n");
    else
      /* going up */
      ABPrint(r_lift,nil,nil,"The lift ascends for a few seconds before stopping. There only seems to be one room on this floor.\n");
    fi;
    r_lift@p_rSouth:=room;
    true
  else
    /* lift is already there */
    false
  fi
corp;

define tp_hotel proc pressButton()status:
  thing room;

  if It()=o_buttonG then
    if moveLift(r_foyer)=false then
      Print("Nothing happens.\n");
    fi;
  else
    room:=FindRoom(Me());
    if room~=nil then
      if moveLift(room)=false then
	Print("The button remains lit.\n");
      fi;
    else
      Print("The button lights, blinks twice, then goes out.\n");
    fi;
  fi;
  succeed
corp;
o_button@p_oPushChecker := pressButton.

define tp_hotel proc descButton()string:
  thing it,me,room;
  bool b;
  string s;

  it:=It();

  if it=o_buttonG then
    b:=(r_lift@p_rSouth=r_foyer);
    s:="G";
  else
    b:=(r_lift@p_rSouth~=r_foyer);
    s:="1";
  fi;

  if b=true then
    "The button, labeled '"+s+"', is lit up brightly."
  else
    "The button, labeled '"+s+"', is not lit."
  fi
corp;
o_button@p_oDescAction:= descButton.

define tp_hotel o_sign CreateThing(nil).
o_sign@p_oNotGettable:=true.
o_sign@p_oInvisible:=true.
o_sign@p_oName:="sign".
o_sign@p_oDesc:="The sign is a piece of white card folded in half.".
o_sign@p_oReadString:="The sign reads 'One room only per customer. Register at the desk.'".
AddTail(r_foyer@p_rContents,o_sign).

define tp_hotel proc exitToLift()status:
  thing room;
  bool b;

  room:=Here();
  b:=moveLift(room);
  continue
corp;
AddNorthChecker(r_foyer,exitToLift,false).

define tp_hotel proc nameRoom()string:
  thing room;
  room:=Here();
  if room@p_oCarryer=Me() then
    "in your room"
  else
    "in " + room@p_oCarryer@p_pName + "'s room"
  fi
corp;

/****/

/* Create the rooms */
r_lift@p_rRoomList:=CreateThingList().

/****/

define tp_hotel defaultRoom CreateThing(r_indoors).
defaultRoom@p_rDesc:="There is a double bed and a wardrobe.".
defaultRoom@p_rNameAction:=nameRoom.
defaultRoom@p_rScenery:="bed;double.wardrobe;plain,wooden".
UniConnect(defaultRoom, r_lift, D_EXIT).
UniConnect(defaultRoom, r_lift, D_NORTH).
AddNorthChecker(defaultRoom,exitToLift,false).


/****/


define tp_hotel proc roomRegister()bool:
  thing me,room;

  me := Me();
  room:=FindRoom(me);
  if room=nil then
    room:=CreateThing(defaultRoom);
    room@p_rContents := CreateThingList();
    room@p_oCarryer:=me;
    SetThingStatus(room, ts_public);

    AddTail(r_lift@p_rRoomList,room);
    Print("You walk up to the counter to register.  A receptionist get up "
	  "from her seat, and helps you fill out all of the forms in "
	  "triplicate.  She then tells you that your room is on the "
	  "first floor, says goodbye, and returns to her magazine.\n");
    if not me@p_pHidden then
      OPrint(me@p_pName + " walks to the reception area and speaks to the receptionist.\n");
    else
      OPrint("The receptionist gets up and speaks into thin air!\n");
    fi;
    true
  else
    Print("You already have a room here!\n");
    if not me@p_pHidden then
      OPrint(me@p_pName + " walks up to the counter, but is turned away.\n");
    fi;
    false
  fi
corp;

r_foyer@p_rRegisterAction := roomRegister.

/****/

unuse t_util.
unuse t_base.
unuse t_roomTypes.
unuse t_streets.
unuse tp_hotel


