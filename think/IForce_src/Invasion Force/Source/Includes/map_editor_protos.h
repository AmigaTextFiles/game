/* Prototypes for functions defined in
map_editor.c
 */

extern struct Menu * editor_menu_strip;

extern BOOL MEdit;

extern BOOL INFO;

extern BOOL terminated;

extern BOOL mapgen;

extern BOOL mycity;

extern int brush;

extern int tot;

extern int totP;

extern int figctr[16];

extern int infoctr[16];

extern int map_safe;

extern char map_filepath[108];

extern char map_filename[108];

void save_map(char * );

BOOL load_map(char * );

void ME_load_map(char * );

void rt_loadsave_map(int );

void try_map_resize(int , int );

void map_size_request(void);

extern int new_brush;

extern int terrain_index[17];

void new_terrain(int , int );

void highlight_terrain(int , int );

void do_terrain_window(void);

void info_update_gadget(struct Gadget * );

void do_info_window(void);

void handleGadgetEvent(struct Window * , struct Gadget * , UWORD , WORD * , struct Gadget ** );

struct Gadget * createAllGadgets(struct Gadget ** , void * , WORD , struct Gadget ** );

void process_window_events(struct Window * , WORD * , struct Gadget ** );

void Random_Window(void);

void do_presets(void);

void do_city(void);

void menu_select_terrain(void);

void build_editor_menu(void);

BOOL user_plopcity(int , int );

void user_plot(int , int , UWORD );

void initialize_editor(void);

void editor_menu(void);

void map_editor(void);

