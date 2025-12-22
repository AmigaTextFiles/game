/* Prototypes for functions defined in
main_menu.c
 */

extern char * version;

extern short revision;

extern char foo[256];

extern char bar[256];

extern BPTR my_console;

extern struct Screen * title_screen;

extern struct BitMap title_bmp;

extern struct Screen * map_screen;

extern APTR vi;

extern struct Window * map_window;

extern struct Window * terrain_window;

extern struct Menu * main_menu_strip;

extern struct ReqToolsBase * ReqToolsBase;

extern struct MEDPlayerBase * MEDPlayerBase;

extern char default_sound[5][216];

extern char current_sound[5][216];

extern char win_title[80];

extern int disp_wd;

extern int disp_ht;

extern struct Gadget * context;

extern struct Gadget * vert_scroller;

extern struct Gadget * horz_scroller;

extern APTR vs_si;

extern APTR hs_si;

extern struct TextAttr topaz8;

extern struct TextAttr topaz9;

extern struct TextAttr topaz11;

extern struct TextAttr topaz11bold;

extern char req_true;

extern char req_false;

extern struct Emp2Prefs prefs;

extern struct newEmp2Prefs newprefs;

void print(char * );

void alarm(char * );

void clean_exit(int , char * );

void open_libraries(void);

int alert(struct Window * , char * , char * , char * );

struct rtHandlerInfo * post_it(char * );

void unpost_it(struct rtHandlerInfo * );

int left_buttonP(void);

void set_title_palette(void);

void open_title_screen(void);

void load_title_graphics(void);

void title_show(void);

void open_map_screen(void);

void open_map_window(void);

void set_default_palette(struct Screen * );

void check_fonts(void);

void seed_random(void);

void create_console(void);

void build_main_gadget_list(void);

void build_main_menu(void);

void about_empire(void);

void quit_program(void);

void load_prefs(void);

void save_prefs(void);

void change_screenmode(void);

void change_sounds(void);

void main_menu(void);

void main(void);

