/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * streets.m - define the outside streets in the starter dungeon.
 */

private tp_streets CreateTable().
use tp_streets

define tp_streets STREETS_ID NextEffectId().

define tp_streets proc drawStreets()void:

    if not KnowsEffect(nil, STREETS_ID) then
	DefineEffect(nil, STREETS_ID);
	GSetImage(nil, "Town/streets");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);

	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 69, 41, true);
	    GAMove(nil, 89, 0);
	    GRectangle(nil, 70, 41, true);
	    GAMove(nil, 0, 57);
	    GRectangle(nil, 69, 42, true);
	    GAMove(nil, 89, 57);
	    GRectangle(nil, 70, 42, true);

	    GSetPen(nil, C_DARK_BROWN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 62, 35, true);
	    GAMove(nil, 96, 0);
	    GRectangle(nil, 63, 35, true);
	    GAMove(nil, 0, 63);
	    GRectangle(nil, 62, 36, true);

	    GSetPen(nil, C_WHITE);
	    GAMove(nil, 79, 0);
	    GRDraw(nil, 0, 35);
	    GAMove(nil, 0, 49);
	    GRDraw(nil, 62, 0);
	    GAMove(nil, 97, 49);
	    GRDraw(nil, 62, 0);
	    GAMove(nil, 79, 63);
	    GRDraw(nil, 0, 36);

	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 62, 13);
	    VerticalDoor();
	    GAMove(nil, 96, 1);
	    VerticalDoor();
	    GAMove(nil, 96, 13);
	    VerticalDoor();
	    GAMove(nil, 96, 25);
	    VerticalDoor();
	    GAMove(nil, 101, 35);
	    HorizontalDoor();
	    GAMove(nil, 122, 35);
	    HorizontalDoor();
	    GAMove(nil, 143, 35);
	    HorizontalDoor();
	    GAMove(nil, 62, 65);
	    VerticalDoor();
	    GAMove(nil, 62, 77);
	    VerticalDoor();
	    GAMove(nil, 62, 89);
	    VerticalDoor();
	    GAMove(nil, 5, 63);
	    HorizontalDoor();
	    GAMove(nil, 26, 63);
	    HorizontalDoor();
	    GAMove(nil, 47, 63);
	    HorizontalDoor();

	    GSetPen(nil, C_LIGHT_GREEN);
	    GAMove(nil, 96, 63);
	    GRectangle(nil, 56, 30, true);
	    GSetPen(nil, C_LIGHT_GREY);
	    GAMove(nil, 121, 63);
	    GRectangle(nil, 5, 36, true);
	    GAMove(nil, 111, 69);
	    GRectangle(nil, 25, 18, true);
	    GSetPen(nil, C_BLUE);
	    GAMove(nil, 118, 74);
	    GRectangle(nil, 11, 8, true);
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 123, 78);
	    GCircle(nil, 1, true);
	    GAMove(nil, 124, 78);
	    GCircle(nil, 1, true);

	    GSetPen(nil, C_DARK_BROWN);
	    GAMove(nil, 103, 72);
	    GRectangle(nil, 7, 12, true);
	    GAMove(nil, 137, 72);
	    GRectangle(nil, 8, 12, true);
	    GSetPen(nil, C_BLACK);
	    GAMove(nil, 110, 74);
	    VerticalDoor();
	    GAMove(nil, 137, 74);
	    VerticalDoor();

	    GSetPen(nil, C_FOREST_GREEN);
	    GAMove(nil, 100, 67);
	    GCircle(nil, 5, true);
	    GAMove(nil, 135, 67);
	    GCircle(nil, 4, true);
	    GAMove(nil, 145, 68);
	    GCircle(nil, 5, true);
	    GAMove(nil, 114, 91);
	    GCircle(nil, 3, true);
	    GAMove(nil, 107, 90);
	    GCircle(nil, 3, true);
	    GAMove(nil, 99, 91);
	    GCircle(nil, 3, true);
	    GAMove(nil, 149, 80);
	    GCircle(nil, 3, true);
	    GAMove(nil, 148, 87);
	    GCircle(nil, 3, true);
	    GAMove(nil, 142, 91);
	    GCircle(nil, 3, true);
	    GAMove(nil, 133, 90);
	    GCircle(nil, 3, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, STREETS_ID);
corp;

define tp_streets STREETS_MAP_GROUP NextMapGroup().

define tp_streets proc streetPos(thing room; int x, y)void:

    RoomGraphics(room, "Street", "", STREETS_MAP_GROUP, x, y, drawStreets);
corp;

define tp_streets proc makeStreet(thing parent; int x, y)thing:
    thing newStreet;

    newStreet := CreateThing(parent);
    newStreet@p_rContents := CreateThingList();
    SetThingStatus(newStreet, ts_readonly);
    streetPos(newStreet, x, y);
    newStreet
corp;

define tp_streets proc makeStreetP(thing parent; int x, y)thing:
    thing newStreet;

    newStreet := CreateThing(parent);
    newStreet@p_rContents := CreateThingList();
    SetThingStatus(newStreet, ts_public);
    streetPos(newStreet, x, y);
    newStreet
corp;

define tp_streets BIRDS_SING_ID NextSoundEffectId().

define tp_streets proc birdsSingOnce(thing client)void:
    if SOn(client) then
	SPlaySound(client, "birds", BIRDS_SING_ID);
	IfFound(client);
	Else(client);
	    FailText(client, "Some birds sing.");
	Fi(client);
    else
	SPrint(client, "Some birds sing.\n");
    fi;
corp;

define tp_streets proc parkBirds()status:
    if Random(5) = 0 then
	ForEachAgent(Here(), birdsSingOnce);
	birdsSingOnce(Me());
    fi;
    continue
corp;

define tp_streets proc makePark(string name, desc; int x, y)thing:
    thing newPark;

    newPark := CreateThing(r_park);
    newPark@p_rName := name;
    if desc ~= "" then
	newPark@p_rDesc := desc;
    fi;
    newPark@p_rContents := CreateThingList();
    SetThingStatus(newPark, ts_readonly);
    RoomGraphics(newPark, "Park", "", STREETS_MAP_GROUP, x, y, drawStreets);
    AddAnyEnterChecker(newPark, parkBirds, false);
    newPark
corp;

define tp_streets proc makeParkP(string name, desc; int x, y)thing:
    thing newPark;

    newPark := CreateThing(r_park);
    newPark@p_rName := name;
    if desc ~= "" then
	newPark@p_rDesc := desc;
    fi;
    newPark@p_rContents := CreateThingList();
    SetThingStatus(newPark, ts_public);
    RoomGraphics(newPark, "Park", "", STREETS_MAP_GROUP, x, y, drawStreets);
    AddAnyEnterChecker(newPark, parkBirds, false);
    newPark
corp;

define tp_streets proc makeDingy(string name, desc; int x, y)thing:
    thing newDingy;

    newDingy := CreateThing(r_park);
    newDingy@p_rName := name;
    if desc ~= "" then
	newDingy@p_rDesc := desc;
    fi;
    newDingy@p_rContents := CreateThingList();
    SetThingStatus(newDingy, ts_public);
    RoomGraphics(newDingy, "Dingy", "Sidewalk", STREETS_MAP_GROUP, x, y,
		 drawStreets);
    newDingy
corp;

define tp_streets r_crossNE CreateThing(r_sidewalk).
SetupRoom(r_crossNE, "on the north-east corner of the main intersection",
    "Handy sidewalks head north and east, and you can cross the streets "
    "to the south and west.").
streetPos(r_crossNE, 89, 35).

define tp_streets r_crossNW CreateThing(r_sidewalk).
SetupRoom(r_crossNW, "on the north-west corner of the main intersection",
    "Handy sidewalks head north and west, and you can cross the streets "
    "to the south and east.").
streetPos(r_crossNW, 63, 35).

define tp_streets r_crossSE CreateThing(r_sidewalk).
SetupRoom(r_crossSE, "on the south-east corner of the main intersection",
    "Handy sidewalks head south and east alongside the park, and you can "
    "cross the streets to the north and west.").
streetPos(r_crossSE, 89, 57).

/* put r_crossSW in tp_misc, since is needed in machines.m */
define tp_misc r_crossSW CreateThing(r_sidewalk).
SetupRoom(r_crossSW, "on the south-west corner of the main intersection",
    "Handy sidewalks head south and west, and you can cross the streets "
    "to the north and east.").
streetPos(r_crossSW, 63, 57).

Connect(r_crossNE, r_crossNW, D_WEST).
Connect(r_crossNE, r_crossSE, D_SOUTH).
Connect(r_crossSW, r_crossSE, D_EAST).
Connect(r_crossSW, r_crossNW, D_NORTH).

define tp_streets r_nw CreateThing(r_sidewalk).
SetThingStatus(r_nw, ts_readonly).
r_nw@p_rName := "on the west sidewalk, north of the main intersection".
define tp_streets r_nw1 makeStreet(r_nw, 63, 26).
Connect(r_crossNW, r_nw1, D_NORTH).
define tp_streets r_nw2 makeStreet(r_nw, 63, 14).
Connect(r_nw1, r_nw2, D_NORTH).
define tp_streets r_nw3 makeStreet(r_nw, 63, 2).
r_nw3@p_rDesc := "You can cross the street to the east.".
Connect(r_nw2, r_nw3, D_NORTH).
define tp_streets r_ne CreateThing(r_sidewalk).
SetThingStatus(r_ne, ts_readonly).
r_ne@p_rName := "on the east sidewalk, north of the main intersection".
define t_streets r_ne1 makeStreetP(r_ne, 89, 26).
Connect(r_crossNE, r_ne1, D_NORTH).
define t_streets r_ne2 makeStreetP(r_ne, 89, 14).
Connect(r_ne1, r_ne2, D_NORTH).
define t_streets r_ne3 makeStreetP(r_ne, 89, 2).
r_ne3@p_rDesc := "You can cross the street to the west.".
Connect(r_ne2, r_ne3, D_NORTH).
Connect(r_nw3, r_ne3, D_EAST).

define tp_streets r_en CreateThing(r_sidewalk).
SetThingStatus(r_en, ts_readonly).
r_en@p_rName := "on the north sidewalk, east of the main intersection".
define t_streets r_en1 makeStreetP(r_en, 103, 35).
Connect(r_crossNE, r_en1, D_EAST).
define t_streets r_en2 makeStreetP(r_en, 124, 35).
Connect(r_en1, r_en2, D_EAST).
define t_streets r_en3 makeStreetP(r_en, 145, 35).
Connect(r_en2, r_en3, D_EAST).
r_en3@p_rDesc := "You can cross the street to the south.".
define tp_streets r_es CreateThing(r_sidewalk).
SetThingStatus(r_es, ts_readonly).
r_es@p_rName := "on the south sidewalk, east of the main intersection".
r_es@p_rDesc := "The rail fence around the park is to your south.".
Scenery(r_es, "fence;rail.railing,rail").
define tp_streets r_es1 makeStreet(r_es, 104, 57).
Connect(r_crossSE, r_es1, D_EAST).
/* put r_es2 in tp_misc, since it is needed in machine.m */
define tp_misc r_es2 makeStreet(r_es, 120, 57).
r_es2@p_rDesc := "The north park entrance is to your south.".
Connect(r_es1, r_es2, D_EAST).
define tp_streets r_es3 makeStreet(r_es, 136, 57).
Connect(r_es2, r_es3, D_EAST).
define t_streets r_es4 makeStreetP(r_es, 153, 57).
r_es4@p_rDesc :=
    "You can cross the street to the north or go south alongside the park.".
Connect(r_es3, r_es4, D_EAST).
Connect(r_en3, r_es4, D_SOUTH).

define tp_streets r_wn CreateThing(r_sidewalk).
SetThingStatus(r_wn, ts_readonly).
r_wn@p_rName := "on the north sidewalk, west of the main intersection".
define tp_streets r_wn1 makeStreet(r_wn, 49, 35).
Connect(r_crossNW, r_wn1, D_WEST).
define t_streets r_wn2 makeStreet(r_wn, 28, 35).
Connect(r_wn1, r_wn2, D_WEST).
define t_streets r_wn3 makeStreet(r_wn, 7, 35).
r_wn3@p_rDesc := "You can cross the street to the south.".
Connect(r_wn2, r_wn3, D_WEST).
define tp_streets r_ws CreateThing(r_sidewalk).
SetThingStatus(r_ws, ts_readonly).
r_ws@p_rName := "on the south sidewalk, west of the main intersection".
define t_streets r_ws1 makeStreetP(r_ws, 49, 57).
Connect(r_crossSW, r_ws1, D_WEST).
define t_streets r_ws2 makeStreetP(r_ws, 28, 57).
Connect(r_ws1, r_ws2, D_WEST).
define t_streets r_ws3 makeStreetP(r_ws, 7, 57).
r_ws3@p_rDesc := "You can cross the street to the north.".
Connect(r_ws2, r_ws3, D_WEST).
Connect(r_wn3, r_ws3, D_SOUTH).

define tp_streets r_sw CreateThing(r_sidewalk).
SetThingStatus(r_sw, ts_readonly).
r_sw@p_rName := "on the west sidewalk, south of the main intersection".
define tp_streets r_sw1 makeStreetP(r_sw, 63, 66).
Connect(r_crossSW, r_sw1, D_SOUTH).
/* r_sw2 is in tp_misc, since it is needed in bguild.m */
define tp_misc r_sw2 makeStreet(r_sw, 63, 78).
Connect(r_sw1, r_sw2, D_SOUTH).
define t_streets r_sw3 makeStreetP(r_sw, 63, 90).
r_sw3@p_rDesc := "You can cross the street to the east.".
Connect(r_sw2, r_sw3, D_SOUTH).
define tp_streets r_se CreateThing(r_sidewalk).
SetThingStatus(r_se, ts_readonly).
r_se@p_rName := "on the east sidewalk, south of the main intersection".
r_se@p_rDesc := "The rail fence around the park is to your east.".
Scenery(r_se, "fence;rail.railing,rail").
define tp_streets r_se1 makeStreet(r_se, 89, 75).
Connect(r_crossSE, r_se1, D_SOUTH).
define t_streets r_se2 makeStreetP(r_se, 89, 92).
r_se2@p_rDesc :=
    "You can cross the street to the west or go east alongside the park.".
Connect(r_se1, r_se2, D_SOUTH).
Connect(r_sw3, r_se2, D_EAST).

define tp_streets r_parkNorth makePark("at the north entrance to the park",
    "The street is to the north and park walks head east and west. Directly "
    "south of you is the park's central fountain.", 120, 67).
Connect(r_es2, r_parkNorth, D_SOUTH).
define tp_streets o_fountainWater CreateThing(nil).
FakeObject(o_fountainWater, r_parkNorth,
    "water;central,fountain.fountain;water,in,from,the.mermaid;ugly,bronze",
    "The fountain is a square hole in the sidewalk, filled with water. An "
    "ugly bronze mermaid dribbles water into it. The water has a slightly "
    "greenish tinge, and smells of too much chlorine.").
o_fountainWater@p_oEatString :=
    "Drink the water from that fountain? Ick! No way!".
o_fountainWater@p_oTouchString :=
    "You can't reach the bronze mermaid, "
    "and the water is merely tepid and wet.".
o_fountainWater@p_oSmellString := "You can smell the acrid tang of chlorine.".
define tp_streets r_parkNorthEast makePark(
    "at the northeast corner of the park walk", "", 130, 68).
Connect(r_parkNorth, r_parkNorthEast, D_EAST).
AddTail(r_parkNorthEast@p_rContents, o_fountainWater).
define tp_streets r_parkNorthWest makePark(
    "at the northwest corner of the park walk", "", 111, 68).
Connect(r_parkNorth, r_parkNorthWest, D_WEST).
AddTail(r_parkNorthWest@p_rContents, o_fountainWater).
define tp_streets r_parkEast makeParkP("east of the fountain", "", 130, 75).
Connect(r_parkNorthEast, r_parkEast, D_SOUTH).
AddTail(r_parkEast@p_rContents, o_fountainWater).
define tp_streets r_parkWest makeParkP("west of the fountain", "", 111, 75).
Connect(r_parkNorthWest, r_parkWest, D_SOUTH).
AddTail(r_parkWest@p_rContents, o_fountainWater).
define tp_streets r_parkSouthEast makePark(
    "at the southeast corner of the park walk", "", 130, 82).
Connect(r_parkEast, r_parkSouthEast, D_SOUTH).
AddTail(r_parkSouthEast@p_rContents, o_fountainWater).
define tp_streets r_parkSouthWest makePark(
    "at the southwest corner of the park walk", "", 111, 82).
Connect(r_parkWest, r_parkSouthWest, D_SOUTH).
AddTail(r_parkSouthWest@p_rContents, o_fountainWater).
define tp_streets r_parkSouth makePark("at the south entrance to the park",
    "A dingy sidewalk is to the south and park walks head east and west. "
    "Directly north of you is the park's central fountain.", 120, 83).
Connect(r_parkSouthEast, r_parkSouth, D_WEST).
Connect(r_parkSouthWest, r_parkSouth, D_EAST).
AddTail(r_parkSouth@p_rContents, o_fountainWater).
define t_streets r_dingySouth makeDingy(
    "on a dingy east-west sidewalk",
    "The south park entrance is to your north", 120, 92).
Connect(r_se2, r_dingySouth, D_EAST).
Connect(r_parkSouth, r_dingySouth, D_SOUTH).
define t_streets r_dingyCorner makeDingy(
    "on a corner of dingy sidewalks",
    "You can go north or west, both alongside the fenced-off park.", 153, 92).
Connect(r_dingySouth, r_dingyCorner, D_EAST).
Scenery(r_dingySouth, "park,fence,railing,rail;rail,fenced,off,fenced-off").
define t_streets r_dingyEast makeDingy(
    "on a dingy north-south sidewalk east of the park", "", 153, 76).
Connect(r_dingyCorner, r_dingyEast, D_NORTH).
Connect(r_es4, r_dingyEast, D_SOUTH).

/* connect the street to the minimall */

ExtendDesc(r_nw2,
    "A passageway heads to the west. The walls and floor of the passageway "
    "are of brown tile, with a simple pattern of white tiles thrown in. The "
    "ceiling of the passageway is painted concrete, and fluorescent "
    "striplights (half of which don't work at all) cast intermittant light on "
    "the rubbish-strewn floor.").
r_nw2@p_rWestDesc :=
    "The passageway is fairly large, and is poorly lit. It is obviously well "
    "used however. It is fairly long, but you can see a large open area at "
    "the far end.".
r_nw2@p_rWestMessage := "You head into the gloom of the passageway.".
r_nw2@p_rWestOMessage := "heads into the passageway.".
r_nw2@p_rWestEMessage := "comes out of the passageway.".
r_nw2@p_rEnterDesc :=
    "The passageway is fairly large, and is poorly lit. It is obviously well "
    "used however. It is fairly long, but you can see a large open area at "
    "the far end.".
r_nw2@p_rEnterMessage := "You head into the gloom of the passageway.".
r_nw2@p_rEnterOMessage := "heads into the passageway.".
Connect(r_nw2, r_mallEntrance, D_WEST).
Connect(r_nw2, r_mallEntrance, D_ENTER).
Scenery(r_nw2,
    "passageway,passage,floor,wall,ceiling;rubbish,strewn,rubbish-strewn."
    "tile;brown,white,patterned."
    "pattern;simple."
    "concrete,painted."
    "light,striplight;strip,fluorescent."
    "rubbish").

/* Connect Questor's office to r_ws2 */

SetupQuestorOffice(r_ws2, D_SOUTH).

/* Build a ring road around the town. */
/* I deliberately did not inherit from anything other than 'r_road' here,
   to make it easier for others to modify the roads. */

define tp_streets TOWN_ROAD_NORTH_ID NextEffectId().
define tp_streets proc drawRoadNorth()void:

    if not KnowsEffect(nil, TOWN_ROAD_NORTH_ID) then
	DefineEffect(nil, TOWN_ROAD_NORTH_ID);
	GSetImage(nil, "Town/roadNorth");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    GSetPen(nil, C_DARK_GREEN);
	    GAMove(nil, 0, 0);
	    GRectangle(nil, 159, 99, true);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 0, 38);
	    GRectangle(nil, 159, 24, true);
	    GAMove(nil, 65, 50);
	    GRectangle(nil, 30, 49, true);
	    GAMove(nil, 75, 0);
	    GRectangle(nil, 10, 50, true);
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, TOWN_ROAD_NORTH_ID);
corp;
define tp_streets r_roadNorth CreateThing(r_road).
SetupRoomP(r_roadNorth, "at a junction",
    "The town is to the south. A pathway leads to the north.").
Connect(r_ne3, r_roadNorth, D_NORTH).
UniConnect(r_nw3, r_roadNorth, D_NORTH).
AutoGraphics(r_roadNorth, drawRoadNorth).

define t_streets r_roadNorthEast CreateThing(r_road).
SetupRoomP(r_roadNorthEast, "at a corner in the road", "").
Connect(r_roadNorth, r_roadNorthEast, D_EAST).
AutoGraphics(r_roadNorthEast, AutoRoads).

define t_streets r_roadEast CreateThing(r_road).
SetupRoomP(r_roadEast, "at a junction", "The town is to the west.").
Connect(r_roadNorthEast, r_roadEast, D_SOUTH).
Connect(r_es4, r_roadEast, D_EAST).
UniConnect(r_en3, r_roadEast, D_EAST).
AutoGraphics(r_roadEast, AutoRoads).

define t_streets r_roadSouthEast CreateThing(r_road).
SetupRoomP(r_roadSouthEast, "at a corner in the road", "").
Connect(r_roadEast, r_roadSouthEast, D_SOUTH).
AutoGraphics(r_roadSouthEast, AutoRoads).

define t_streets r_roadSouth CreateThing(r_road).
SetupRoomP(r_roadSouth, "at a junction", "The town is to the north.").
Connect(r_roadSouthEast, r_roadSouth, D_WEST).
Connect(r_se2, r_roadSouth, D_SOUTH).
UniConnect(r_sw3, r_roadSouth, D_SOUTH).
AutoGraphics(r_roadSouth, AutoRoads).

define t_streets r_roadSouthWest CreateThing(r_road).
SetupRoomP(r_roadSouthWest, "at a corner in the road", "").
Connect(r_roadSouth, r_roadSouthWest, D_WEST).
AutoGraphics(r_roadSouthWest, AutoRoads).

define t_streets r_roadWest CreateThing(r_road).
SetupRoomP(r_roadWest, "at a junction", "The town is to the east.").
Connect(r_roadSouthWest, r_roadWest, D_NORTH).
Connect(r_ws3, r_roadWest, D_WEST).
UniConnect(r_wn3, r_roadWest, D_WEST).
AutoGraphics(r_roadWest, AutoRoads).

define t_streets r_roadNorthWest CreateThing(r_road).
SetupRoomP(r_roadNorthWest, "at a corner in the road", "").
Connect(r_roadWest, r_roadNorthWest, D_NORTH).
Connect(r_roadNorth, r_roadNorthWest, D_WEST).
AutoGraphics(r_roadNorthWest, AutoRoads).

/* a bit of the great outdoors */

define t_streets r_path1 CreateThing(r_path).
SetupRoomP(r_path1, "on a north-south pathway", "The town is to the south.").
Connect(r_roadNorth, r_path1, D_NORTH).
AutoGraphics(r_path1, AutoPaths).

define t_streets r_path2 CreateThing(r_path).
SetupRoomP(r_path2, "on a north-south pathway",
    "A small trail heads to the east.").
SetThingStatus(r_path2, ts_public);
Connect(r_path1, r_path2, D_NORTH).
AutoGraphics(r_path2, AutoPaths).

define t_streets r_path3 CreateThing(r_path).
SetupRoomP(r_path3, "at a dead-end",
    "A large billboard reads: Castle lots for sale - apply with SysAdmin.").
Connect(r_path2, r_path3, D_NORTH).
AutoGraphics(r_path3, AutoPaths).
Sign(r_path3, "board,billboard;large,bill", "",
    "Castle lots for sale - apply with SysAdmin").

/* and now a connecting trail */

define t_streets r_ewTrail1 CreateThing(r_path).
SetupRoomP(r_ewTrail1, "on an east-west trail", "").
Connect(r_path2, r_ewTrail1, D_EAST).
AutoGraphics(r_ewTrail1, AutoPaths).

define t_streets r_ewTrail2 CreateThing(r_path).
SetupRoomP(r_ewTrail2, "on an east-west trail",
    "The trail continues to the east and the west. A line of trees starts "
    "just north of here and continues to the east. You can see the town to "
    "the south, but you can't get there from here.").
Connect(r_ewTrail1, r_ewTrail2, D_EAST).
Scenery(r_ewTrail2, "ground,sky,path,trail,grass.tree,line;line,of.town").
AutoGraphics(r_ewTrail2, AutoPaths).

define t_streets r_ewTrail3 CreateThing(r_outdoors).
SetupRoomP(r_ewTrail3, "on an east-west trail",
    "The line of trees continues to the north, and you can see an open field "
    "to the east.").
Scenery(r_ewTrail3, "ground,sky,tree,path,trail,field,trail;line,of").
Connect(r_ewTrail2, r_ewTrail3, D_EAST).
AutoGraphics(r_ewTrail3, AutoPaths).

/* here for the next little while is the field with the pear tree */

define t_streets r_pearField CreateThing(r_field).
SetupRoomP(r_pearField, "in a field",
    "There is a large pear tree here, full of pears. "
    "A small trail heads west.").
Connect(r_ewTrail3, r_pearField, D_EAST).
AutoGraphics(r_pearField, AutoPaths).
define tp_streets proc fieldSmell()status:
    if It() = nil then
	Print("The air here smells quite fresh and clean!\n");
	succeed
    else
	continue
    fi
corp;
r_pearField@p_oSmellChecker := fieldSmell.
r_pearField@p_Image := "Town/pearField".

define tp_streets o_pearTree CreateThing(nil).
SetupObject(o_pearTree, r_pearField, "tree;large,pear.branch;loaded",
    "The tree is quite large, with many long branches loaded with pears. "
    "It stands by itself in the center of this small field. Many of the "
    "branches come within easy reach.").
o_pearTree@p_oInvisible := true.
o_pearTree@p_oSmellString := "The pear tree smells somewhat woody.".
o_pearTree@p_Image := "Town/pearTree".

define tp_streets o_pearOnTree CreateThing(nil).
SetupObject(o_pearOnTree, r_pearField, "pear;plump,juicy",
    "The pears on the tree look quite delicious.").
o_pearOnTree@p_oInvisible := true.
o_pearOnTree@p_oEatString := "You should pick a pear from the tree first.".
o_pearOnTree@p_oSmellString := o_pearOnTree@p_oEatString.
o_pearOnTree@p_oTouchString := o_pearOnTree@p_oEatString.

/* Special procs for the pears. Note the lack of 'utility', since we
   make the pears belong to whoever sources this file */

define tp_streets proc pearDrop(thing pear)status:
    thing carryer, here;

    carryer := pear@p_oCarryer;
    ClearThing(pear);
    SPrint(carryer, "The pear drops and is pulped!\n");
    here := Here();
    if CanSee(here, carryer) and not carryer@p_pHidden then
	ABPrint(here, carryer, carryer,
	    Capitalize(CharacterNameG(carryer)) +
	    " drops a pear which sploops.\n");
    else
	ABPrint(here, carryer, carryer, "You hear a smack! sound.\n");
    fi;
    DelElement(carryer@p_pCarrying, pear);
    /* we have just destroyed the pear and already dropped it, we do NOT
       want to continue with normal drop processing */
    succeed
corp;

define tp_streets proc pearEat()status:
    thing th, me;

    th := It();
    me := Me();
    if th@p_oCreator = me then
	Print("You eat the pear. It was really good.\n");
	if CanSee(Here(), me) and not me@p_pHidden then
	    OPrint(Capitalize(CharacterNameG(me)) + " eats a pear.\n");
	else
	    OPrint("You hear some slurping noises.\n");
	fi;
	ClearThing(th);
	DelElement(me@p_pCarrying, th);
    else
	Print("That's not your pear!\n");
    fi;
    /* do NOT continue with normal 'eat' processing */
    succeed
corp;

define tp_streets proc pearGive(thing target)status:
    thing me, pear;

    me := Me();
    pear := It();
    if pear@p_oCreator = me then
	Print("You fumble when trying to give away the pear, and drop it!\n");
	if CanSee(Here(), me) and not me@p_pHidden then
	    OPrint(Capitalize(CharacterNameG(me)) +
		" drops a pear which sploops.\n");
	else
	    OPrint("You hear a smack! sound.\n");
	fi;
	ClearThing(pear);
	DelElement(me@p_pCarrying, pear);
    else
	Print("That's not your pear!\n");
    fi;
    /* the give never works */
    fail
corp;

define tp_streets proc pearPutIn(thing pear, container)status:
    string containerName;

    containerName := FormatName(container@p_oName);
    Print("You drop the pear into the " + containerName +
	". Unfortunately, the pear doesn't survive the dropping - it is "
	"squished. You shake out the pieces and clean the mess out of the " +
	containerName + ".\n");
    ClearThing(pear);
    DelElement(Me()@p_pCarrying, pear);
    succeed
corp;

define tp_streets o_pearInHand CreateThing(nil).
o_pearInHand@p_oName := "pear;plump,juicy".
o_pearInHand@p_oDesc := "The pear looks exceedingly delicious!".
o_pearInHand@p_oEatChecker := pearEat.
o_pearInHand@p_oDropChecker := pearDrop.
o_pearInHand@p_oPutMeInChecker := pearPutIn.
o_pearInHand@p_oSmellString := "The pear smells like a pear.".
o_pearInHand@p_oTouchString := "Surprise! The pear feels like a pear.".
o_pearInHand@p_Image := "Town/pear".
SetThingStatus(o_pearInHand, ts_public).

define tp_streets proc pearGet(thing th)status:
    thing me;

    me := Me();
    if FindChildOnList(me@p_pCarrying, o_pearInHand) then
	Print("Don't be greedy! You already have a pear.\n");
    else
	/* will be owned by the real player */
	th := CreateThing(o_pearInHand);
	th@p_oCreator := me;
	SetThingStatus(th, ts_public);
	if CarryItem(th) then
	    /* This is put directly on the individual pears, so that it can
	       be removed in 'questPearGive'. */
	    th@p_oGiveChecker := pearGive;
	    Print("You pick a pear from the tree.\n");
	    /* assume it is not dark */
	    if not me@p_pHidden then
		OPrint(Capitalize(CharacterNameG(me)) +
		       " picks a pear from the tree.\n");
	    fi;
	else
	    ClearThing(th);
	fi;
    fi;
    /* do not want to continue with normal get processing */
    succeed
corp;

o_pearOnTree@p_oGetChecker := pearGet.

define tp_streets proc questPearDesc()string:

    "Bring me two pears."
corp;

define tp_streets proc questPearGive()status:
    thing pear;
    bool hadOne;

    pear := It();
    if Parent(pear) = o_pearInHand then
	/* make it not sploop */
	hadOne :=
	    FindChildOnList(FindAgent("Questor")@p_pCarrying, o_pearInHand);
	pear -- p_oGiveChecker;
	if hadOne then
	    GiveToQuestor("plump juicy pear");
	    succeed
	else
	    continue
	fi
    elif pear@p_oName = "pear;plump,juicy" then
	GiveToQuestor("plump juicy pear");
	SPrint(TrueMe(), "Questor is not impressed.\n");
	fail
    else
	continue
    fi
corp;

define tp_streets proc questPearHint()string:

    "Perhaps you need help from a friendly flower."
corp;

QuestGive("Pear", questPearDesc, questPearGive, questPearHint).

define tp_streets proc pearTreeGet(thing th)status:
    Print("The tree is far too large for you to carry, and in any event, "
	    "it is securely rooted to the ground.\n");
    if Me()@p_pHidden then
	OPrint("The tree shakes slightly.\n");
    else
	OPrint(Capitalize(CharacterNameG(Me())) +
	       " seems to be embracing the tree.\n");
    fi;
    succeed
corp;

o_pearTree@p_oGetChecker := pearTreeGet.

unuse tp_streets
