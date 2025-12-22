/* Prototypes for functions defined in
data_struct.c
 */

extern int width;

extern int height;

extern int xoffs;

extern int yoffs;

extern BOOL wrap;

extern UBYTE * t_grid;

extern UBYTE * me_grid;

extern struct MinList city_list;

extern char default_city_name[11];

extern struct Hex_Coords hexlist[64];

extern char * terrain_name_table[18];

extern short movement_cost_table[12][16];

extern struct UnitTemplate wishbook[12];

extern struct InfoTemplate infostatus[11];

void put(UBYTE * , int , int , int );

void put_flags(UBYTE * , int , int , int );

int get(UBYTE * , int , int );

int get_flags(UBYTE * , int , int );

void free_map(UBYTE ** );

BOOL alloc_map(UBYTE ** );

void flood_map(UBYTE * , int );

void int_grid(UBYTE * , int );

void clear_orders(struct Unit * );

void destruct_unit(struct Unit * );

char * random_name(int );

void name_unit(struct Unit * , char * );

BOOL emptylistP(struct MinList * );

void nuke_list(struct MinList * );

void nuke_units(struct MinList * );

int count_nodes(struct MinList * );

struct City * city_hereP(int , int );

void create_city(int , int );

void remove_city(int , int );

int adjacent(int , int );

BOOL port_cityP(struct City * );

