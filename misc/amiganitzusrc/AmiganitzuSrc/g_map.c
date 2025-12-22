/* g_map.c */
#include <graphics/gfx.h>
#include "g_headers.h"
#include "g_ilbm.h"
#include "g_video.h"

extern struct BitMap tile_bm[NUMBER_OF_TILE_BITMAPS];
extern struct palette_struct no_pal;	// unused palette struct dummy for load_ilbm
extern struct map_struct *map;
extern int plx, ply;
extern struct spiders_struct spi[10];
extern struct player_struct player;
extern struct traps_struct traps[10];
extern struct game_struct game;
int is_spiders = 0;
int is_water = 0;
extern ULONG vbcounter;

char tile_file_list[NUMBER_OF_TILE_BITMAPS][12] = {
	"ply2",
	"ply1",
	"ply4",
	"ply3",
	"rock",
	"dirt",
	"stone1",
	"diamond",
	"brick1",
	"brick2",
	"stone2",
	"key",
	"pipe1",
	"pipe2",
	"pipe3",
	"pipe4",
	"pipe5",
	"pipe6",
	"door",
	"snake1",
	"snake2",
	"water1",
	"spider1",
	"plydeath1",
	"plydeath2",
	"plydeath3",
	"plydeath4",
	"plydeath5",
	"plydeath6",
	"plydeath7",
	"pipe7",
	"pipe8",
	"pipe9",
	"pipe10",
	"pipe11",
	"pipe12",
	"poof1",
	"spear1",
	"spear2",
	"blank",
	"poof2",
	"collapse1",
	"collapse2",
	"collapse3",
	"splode1",
	"splode2",
	"spider2",
	"snake3",
	"snake4",
	"rock1",
	"rock2",
	"rock3",
	"rock4"};

struct tport_struct tport[20];
int num_tports;

void init_map()
{
	int x, y;

	for(y = 0; y < 12; y++)	{
		for(x = 0; x < 16; x++)	{
			map->t[x][y].type = NOTHING;
			map->t[x][y].update = 1;
		}
	}
}

int load_map(char *fname)
{
	FILE *file = NULL;
	int x, y, i;
	char str[6], c, length;

	is_spiders = 0;
	is_water = 0;

	file = fopen(fname, "r");
	if(!file) return 0;

	// get to the start of the text message info
	while(fgetc(file) != '!');
	c = fgetc(file);
	map->num_lines = atoi(&c);

	for(i = 0; i < 4; i++) for(x = 0; x < 42; x++) map->line[i][x] = ' ';
	
	if(map->num_lines != 0) {
		// read in the text
		for(i = 0; i < map->num_lines; i++) {
			while(fgetc(file) != '"');
			x = 0;
			c = 'a';
			while(c != '"') {
				c = fgetc(file);
				map->line[i][x] = c;
				x++;
			}
			map->line[i][x-1] = '\0';
		}
		// set all lines to the same length
		length = 0;
		for(i = 0; i < map->num_lines; i++) if(strlen(map->line[i]) > length) length = strlen(map->line[i]);
		for(i = 0; i < map->num_lines; i++)	{
			x = strlen(map->line[i]);
			if(x != length)	{
				map->line[i][x] = ' ';
				map->line[i][length] = '\0';
			}
		}
	}
	// get to the start of the hard code id
	while(fgetc(file) != '!');
	c = fgetc(file);
	map->hard_code = atoi(&c);
	if(map->hard_code) map->hce_state = HCE_START;

	/*
	printf("\n");
	for(i = 0; i < map->num_lines; i++) printf("%s\n", map->line[i]);
	printf("hard code - %i\n", map->hard_code);
	*/

	num_tports = 0;

	// get to the start of t
	for(y = 0; y < 12; y++) {
		// get to the start of the line
		while(fgetc(file) != '*');

		for(x = 0; x < 16; x++)	{
			map->t[x][y].update = 1;
			map->t[x][y].direction = EAST;
			map->t[x][y].sub_type = NOTHING;
			map->t[x][y].bm = BM_BLANK;
			
			switch(fgetc(file))	{
			case 'P':
				num_tports++;
				map->t[x][y].type = NOTHING;
				map->t[x][y].sub_type = TELEPORT;
				break;
			case '0':
				map->t[x][y].type = NOTHING;
				break;
			case '1':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = STONE1;
				map->t[x][y].bm = BM_STONE1;
				map->t[x][y].direction = NORMAL;
				break;
			case '[':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = STONE1;
				map->t[x][y].bm = BM_STONE1;
				map->t[x][y].direction = COLLAPSE;
				break;
			case '2':
				map->t[x][y].type = DIRT;
				map->t[x][y].bm = BM_DIRT;
				break;
			case '3':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = BRICK1;
				map->t[x][y].bm = BM_BRICK1;
				map->t[x][y].direction = NORMAL;
				break;
			case '7':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = BRICK1;
				map->t[x][y].bm = BM_BRICK1;
				map->t[x][y].direction = COLLAPSETOGEM;
				break;
			case '8':
				map->t[x][y].type = SPEARTRAP;
				map->t[x][y].bm = BM_SPEAR1;
				map->t[x][y].sub_type = SPEAR1;
				break;
			case '4':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = BRICK2;
				map->t[x][y].bm = BM_BRICK2;
				map->t[x][y].direction = NORMAL;
				break;
			case '{':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = BRICK2;
				map->t[x][y].bm = BM_BRICK2;
				map->t[x][y].direction = COLLAPSE;
				break;
			case '5':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = STONE2;
				map->t[x][y].bm = BM_STONE2;
				map->t[x][y].direction = NORMAL;
				break;
			case '6':
				map->t[x][y].type = WALL;
				map->t[x][y].sub_type = STONE2;
				map->t[x][y].bm = BM_STONE2;
				map->t[x][y].direction = COLLAPSETOGEM;
				break;
			case 'd':
				map->t[x][y].type = DIAMOND;
				map->t[x][y].bm = BM_DIAMOND;
				break;
			case 'k':
				map->t[x][y].type = KEY;
				map->t[x][y].bm = BM_KEY;
				break;
			case 'p':
				map->t[x][y].type = PLAYER;
				map->t[x][x].direction = EAST;
				plx = x;
				ply = y;
				player.prev_x = x;
				player.prev_y = y;
				break;
			case 'e':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = NORTH;
				map->t[x][y].direction = CCW;
				break;
			case 'E':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = NORTH;
				map->t[x][y].direction = CW;
				break;
			case 't':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = EAST;
				map->t[x][y].direction = CCW;
				break;
			case 'T':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = EAST;
				map->t[x][y].direction = CW;
				break;
			case 'y':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = SOUTH;
				map->t[x][y].direction = CCW;
				break;
			case 'Y':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = SOUTH;
				map->t[x][y].direction = CW;
				break;
			case 'u':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = WEST;
				map->t[x][y].direction = CCW;
				break;
			case 'U':
				map->t[x][y].type = SPIDER;
				map->t[x][y].sub_type = WEST;
				map->t[x][y].direction = CW;
				break;
			case 's':
				map->t[x][y].type = SNAKE;
				map->t[x][y].sub_type = BM_SNAKE2;
				map->t[x][x].direction = WEST;
				break;
			case 'r':
				map->t[x][y].type = ROCK;
				map->t[x][y].bm = BM_ROCK1;
				break;
			case 'w':
				map->t[x][y].type = WATER;
				map->t[x][y].bm = BM_WATER1;
				is_water = 1;
				break;
			case 'z':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE1;
				map->t[x][y].bm = BM_PIPE1;
				break;
			case 'x':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE2;
				map->t[x][y].bm = BM_PIPE2;
				break;
			case 'c':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE3;
				map->t[x][y].bm = BM_PIPE3;
				break;
			case 'v':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE4;
				map->t[x][y].bm = BM_PIPE4;
				break;
			case 'b':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE5;
				map->t[x][y].bm = BM_PIPE5;
				break;
			case 'n':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE6;
				map->t[x][y].bm = BM_PIPE6;
				break;
			case 'Z':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE7;
				map->t[x][y].bm = BM_PIPE7;
				break;
			case 'X':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE8;
				map->t[x][y].bm = BM_PIPE8;
				break;
			case 'C':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE9;
				map->t[x][y].bm = BM_PIPE9;
				break;
			case 'V':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE10;
				map->t[x][y].bm = BM_PIPE10;
				break;
			case 'B':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE11;
				map->t[x][y].bm = BM_PIPE11;
				break;
			case 'N':
				map->t[x][y].type = PIPE;
				map->t[x][y].sub_type = PIPE12;
				map->t[x][y].bm = BM_PIPE12;
				break;
			case 'q':
				map->t[x][y].type = DOOR;
				map->t[x][y].bm = BM_DOOR;
				break;
			default:
				map->t[x][y].type = NOTHING;
				break;
			}
		}
	}

	// read teleport info if needed
	if(num_tports > 0) {
		num_tports = num_tports / 2; // since each tport will be connected and only have one line of info

		for(i = 0; i < num_tports; i++) tport[i].empty = 1;
		for(i = 0; i < num_tports; i++)	{
			tport[i].empty = 0;

			while(fgetc(file) != '*');
			str[0] = fgetc(file);
			str[1] = fgetc(file);
			str[2] = '\0';
			tport[i].x1 = atoi(str);

			str[0] = fgetc(file);
			str[1] = fgetc(file);
			str[2] = '\0';
			tport[i].y1 = atoi(str);

			str[0] = fgetc(file);
			str[1] = fgetc(file);
			str[2] = '\0';
			tport[i].x2 = atoi(str);

			str[0] = fgetc(file);
			str[1] = fgetc(file);
			str[2] = '\0';
			tport[i].y2 = atoi(str);
		}
	}

	// work out the number of keys
	map->num_keys = 0;
	for(y = 0; y < 12; y++)	{
		for(x = 0; x < 16; x++)	if(map->t[x][y].type == KEY) map->num_keys++;
	}

	// clear the traps struct
	for(i = 0; i < 10; i++) traps[i].empty = 1;
	// populate the traps struct
	for(y = 0; y < 12; y++)	{
		for(x = 0; x < 16; x++)	{
			if(map->t[x][y].type == SPEARTRAP) {
				for(i = 0; i < 10; i++)	{
					if(traps[i].empty == 1)	{
						traps[i].orig_x = x;
						traps[i].orig_y = y;
						traps[i].x = x;
						traps[i].y = y;
						traps[i].flag = TRAP_SET;
						traps[i].time_stamp = 0;
						traps[i].empty = 0;
						break;
					}
				}
			}
		}
	}

	// clear the spiders struct
	for(i = 0; i < 10; i++) spi[i].empty = 1;
	// populate the spiders struct
	for(y = 0; y < 12; y++) {
		for(x = 0; x < 16; x++) {
			if(map->t[x][y].type == SPIDER) {
				map->t[x][y].bm = BM_SPIDER1;
				// find a slot in the spiders struct and add this spider
				is_spiders = 1;
				for(i = 0; i < 10; i++)	{
					if(spi[i].empty == 1) {
						spi[i].x = x;
						spi[i].y = y;
						spi[i].empty = 0;
						spi[i].direction = NONE;
						spi[i].orientation = map->t[x][y].direction;
						switch(map->t[x][y].sub_type) {
						case NORTH:
							spi[i].lx = x;
							spi[i].ly = y - 1;
							spi[i].latched_edge = STH;
							break;
						case EAST:
							spi[i].lx = x + 1;
							spi[i].ly = y;
							spi[i].latched_edge = WST;
							break;
						case SOUTH:
							spi[i].lx = x;
							spi[i].ly = y + 1;
							spi[i].latched_edge = NTH;
							break;
						case WEST:
							spi[i].lx = x - 1;
							spi[i].ly = y;
							spi[i].latched_edge = EST;
							break;
						}
						break;
					}
				}
			}
		}
	}
	fclose(file);

	player.bonus = 500;
	player.bonus_time = vbcounter;
	player.keys = 0;
	player.anim_flag = ANIM_NONE;

	// change directions of snakes if needed
	for(y = 0; y < 12; y++) {
		for(x = 0; x < 16; x++) {
			if(map->t[x][y].type == SNAKE) {
				if(plx > x) {
					map->t[x][y].direction = EAST;
					map->t[x][y].bm = BM_SNAKE1;
					map->t[x][y].update = 1;
				}
				if(plx < x) {
					map->t[x][y].direction = WEST;
					map->t[x][y].bm = BM_SNAKE2;
					map->t[x][y].update = 1;
				}
			}
		}
	}
	
	return 1;
}


int load_tile_bitmaps()
{
	int i, load_success = 1;
	char fname[64];

	for(i = 0; i < NUMBER_OF_TILE_BITMAPS; i++) {
		sprintf(fname, "data/32%s.iff", tile_file_list[i]);
		if(load_ilbm(fname, &tile_bm[i], &no_pal) == 0) load_success = 0;
	}

	return load_success;
}

void unload_tile_bitmaps()
{
	int i;

	for(i = 0; i < NUMBER_OF_TILE_BITMAPS; i++) free_bitmap(&tile_bm[i]);
}

int save_game(int a)
{
	char fname[16];
	FILE *file = NULL;

	sprintf(fname, "data/save%d", a);
	file = fopen(fname, "wb");
	if(!file) return 0;

	// write the map struct
	fwrite(map, sizeof(struct map_struct), 1, file);
	// write the player struct
	fwrite(&player, sizeof(struct player_struct), 1, file);
	// write plx and play
	fwrite(&plx, sizeof(int), 1, file);
	fwrite(&ply, sizeof(int), 1, file);
	// write spiders struct
	fwrite(&spi, sizeof(struct spiders_struct), 10, file);
	// write traps struct
	fwrite(&traps, sizeof(struct traps_struct), 10, file);
	// teleports
	fwrite(&tport, sizeof(struct tport_struct), 20, file);
	// num_tports
	fwrite(&num_tports, sizeof(int), 1, file);

	fclose(file);
	return 1;
}

int load_game(int a)
{
	char fname[16];
	int i;
	int x, y;
	FILE *file = NULL;

	sprintf(fname, "data/save%d", a);
	file = fopen(fname, "rb");
	if(!file) return 0;

	// read map
	fread(map, sizeof(struct map_struct), 1, file);
	// read player struct
	fread(&player, sizeof(struct player_struct), 1, file);
	player.anim_time = 0;
	player.bonus_time = 0;
	// read plx, ply
	fread(&plx, sizeof(int), 1, file);
	fread(&ply, sizeof(int), 1, file);
	// read spiders struct
	fread(&spi, sizeof(struct spiders_struct), 10, file);
	// write traps struct
	fread(&traps, sizeof(struct traps_struct), 10, file);
	// teleports
	fread(&tport, sizeof(struct tport_struct), 20, file);
	// num_tports
	fread(&num_tports, sizeof(int), 1, file);

	fclose(file);

	is_spiders = 0;
	for(i = 0; i < 10; i++) if(!spi[i].empty) is_spiders = 1;
	is_water = 0;
	for(y = 0; y < 12; y++) for(x = 0; x < 16; x++) if(map->t[x][y].type == WATER) is_water = 1;
	// change directions of snakes if needed
	for(y = 0; y < 12; y++) {
		for(x = 0; x < 16; x++) {
			if(map->t[x][y].type == SNAKE) {
				if(plx > x) {
					map->t[x][y].direction = EAST;
					map->t[x][y].sub_type = BM_SNAKE1;
					map->t[x][y].update = 1;
				}
				if(plx < x) {
					map->t[x][y].direction = WEST;
					map->t[x][y].sub_type = BM_SNAKE2;
					map->t[x][y].update = 1;
				}
			}
		}
	}

	return 1;
}

