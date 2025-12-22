private t_tiles CreateTable()$
use t_tiles

define t_tiles TILE_WIDTH 32$
define t_tiles TILE_HEIGHT 20$

define t_tiles TILES_WIDTH 5$
define t_tiles TILES_HEIGHT 5$

source AmigaMUD:Src/Tiles/town.tile
source AmigaMUD:Src/Tiles/trees.tile
source AmigaMUD:Src/Tiles/river.tile

GDefineTile(nil, 1, TILE_WIDTH, TILE_HEIGHT, makeTownTile())$
GDefineTile(nil, 2, TILE_WIDTH, TILE_HEIGHT, makeTreesTile())$
GDefineTile(nil, 3, TILE_WIDTH, TILE_HEIGHT, makeRiverTile())$

define t_tiles proc makeTerrain()list int:
    list int terrain;
    int row, col;

    terrain := CreateIntArray(TILES_WIDTH * TILES_HEIGHT);
    for row from 0 upto TILES_HEIGHT - 1 do
	terrain[row * TILES_WIDTH] := 3;
	for col from 1 upto TILES_WIDTH - 1 do
	    terrain[row * TILES_WIDTH + col] := 2;
	od;
    od;
    terrain[2] := 1;
    terrain
corp;

define t_tiles TileThing CreateThing(nil)$
define t_tiles TileProp CreateIntListProp()$
TileThing@TileProp := makeTerrain()$

define t_tiles proc drawTiles()void:
    list int terrain;
    int row, col;

    terrain := TileThing@TileProp;
    GAMovePixels(nil, 0, 0);
    for row from 0 upto TILES_HEIGHT - 1 do
	for col from 0 upto TILES_WIDTH - 1 do
	    GDisplayTile(nil, terrain[row * TILES_WIDTH + col]);
	    GRMovePixels(nil, TILE_WIDTH, 0);
	od;
	GRMovePixels(nil, - TILE_WIDTH * TILES_WIDTH, TILE_HEIGHT);
    od;
corp;
