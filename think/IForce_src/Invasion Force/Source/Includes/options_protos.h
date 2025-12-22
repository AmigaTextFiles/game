/* Prototypes for functions defined in
options.c
 */

extern int high_player;

extern BOOL fmail;

extern BOOL modem;

extern struct Window * opt_window;

extern struct Gadget * minus_gad;

extern struct Gadget * plus_gad;

extern struct Gadget * pgads[9];

extern struct Gadget * namefield;

extern struct Gadget * rol_ptype;

extern struct Gadget * mapfile_button;

extern struct Gadget * mapfile_field;

extern struct Gadget * prod_slide;

extern struct Gadget * att_slide;

extern struct Gadget * def_slide;

extern struct Gadget * aggr_slide;

extern struct Gadget * prod_int;

extern struct Gadget * att_int;

extern struct Gadget * def_int;

extern struct Gadget * aggr_int;

extern struct Opt opt;

void show_player(int );

void init_players(void);

void change_ptype(int );

void change_gametype(int );

void read_slider(int , UWORD );

void read_integer(int );

void update_player(void);

void store_player(void);

void toggle_pgad(UWORD );

void add_player(void);

void subtract_player(void);

void av_update_gadget(struct Gadget * );

BOOL edit_options(void);

