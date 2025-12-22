/* Prototypes for functions defined in
graphics.c
 */

extern USHORT __chip busy_pointer_data[36];

extern struct RastPort * rast_port;

extern struct BitMap grafx_bitmap;

extern struct BitMap hex_transfer;

extern UBYTE __chip transfer_bitmap[512];

extern struct hex_struct hexes[16];

extern struct icon_struct icons[30];

extern ULONG __chip hex_mask[32];

extern ULONG __chip banned_mask[13];

extern ULONG __chip battleship_mask[15];

extern ULONG __chip carrier_mask[15];

extern ULONG __chip cruiser_mask[15];

extern ULONG __chip destroyer_mask[15];

extern ULONG __chip sub_mask[15];

extern ULONG __chip transport_mask[15];

extern ULONG __chip fighter_mask[15];

extern ULONG __chip armor_mask[15];

extern ULONG __chip bomber_mask[15];

extern ULONG __chip aircav_mask[15];

extern ULONG __chip rifle_mask[15];

extern ULONG __chip city_mask[15];

extern ULONG __chip airbase_mask[15];

extern ULONG __chip landmine_mask[8];

extern ULONG __chip seamine_mask[10];

extern struct Region * map_region;

extern struct Region * bar_region;

void init_icons(void);

void px_outline_hex(int , int );

void px_plot_hex(int , int , int );

void wrap_coords(int * , int * );

void log_to_abs(int , int , int * , int * );

void abs_to_log(int , int , int * , int * );

void log_to_phys(int , int , int * , int * );

void outline_hex(int , int , int );

void wipe_hex(int , int , int );

void plot_hex(int , int , int );

void drawto(int , int , int , int , int );

void draw_road(int , int , int , int );

void bevel_box(int , int , int , int , BOOL );

void bevel_frame(int , int , int , int , BOOL );

void box(int , int , int , int , int );

void frame(int , int , int , int , BOOL );

void plot_text(int , int , char * , int , int , int , struct TextAttr * );

void outline_text(int , int , char * , int , struct TextAttr * );

void px_plot_landmine(int , int );

void px_plot_seamine(int , int );

void px_plot_icon(int , int , int , int , int , BOOL );

void plot_icon(int , int , int , int , int , BOOL );

void px_plot_city(int , int );

void px_plot_roads(int , int );

void px_plot_city_complete(int , int , int , BOOL );

void plot_city(int , int , int , BOOL );

void save_hex_graphics(int , int , int );

void restore_hex_graphics(int , int , int );

void plot_mapobject(int , int , int , int );

void init_map_grafx(void);

void zero_scrollers(void);

void update_scrollers(void);

BOOL scrolly(struct Gadget * , UWORD );

void fat_plot(struct RastPort * , int , int , int );

BOOL visible_stripP(int , int , int , int , int , int );

BOOL within_areaP(int , int , int , int , int , int );

BOOL visibleP(int , int );

BOOL easily_visibleP(int , int );

BOOL need_to_scrollP(int , int );

void clear_movebar(void);

void anim_move(struct Unit * , int , int , int , int );

