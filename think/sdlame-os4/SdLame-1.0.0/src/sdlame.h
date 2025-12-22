/* Version */
#define VERSION printf("Start SdLame 1.0.0...\n")

/* Text */
#define RENDER_MODE 2

/* Keys */
#define GP2X_BUTTON_UP              (0)
#define GP2X_BUTTON_DOWN            (4)
#define GP2X_BUTTON_LEFT            (2)
#define GP2X_BUTTON_RIGHT           (6)
#define GP2X_BUTTON_UPLEFT          (1)
#define GP2X_BUTTON_UPRIGHT         (7)
#define GP2X_BUTTON_DOWNLEFT        (3)
#define GP2X_BUTTON_DOWNRIGHT       (5)
#define GP2X_BUTTON_CLICK           (18)
#define GP2X_BUTTON_A               (12)
#define GP2X_BUTTON_B               (13)
#define GP2X_BUTTON_X               (14)
#define GP2X_BUTTON_Y               (15)
#define GP2X_BUTTON_L               (10)
#define GP2X_BUTTON_R               (11)
#define GP2X_BUTTON_START           (8)
#define GP2X_BUTTON_SELECT          (9)
#define GP2X_BUTTON_VOL_UP          (16)
#define GP2X_BUTTON_VOL_DOWN        (17)

#define BOOL int
#define TRUE 1
#define FALSE 0

/* Define GP2X MODE */
#ifdef GP2X_MODE
#define GP2X_MODE 1
#else
#define GP2X_MODE 0
#endif

#define SAVEFILE "../../sdlame.sav"

/* player.c */
void turn_player_1();
void turn_player_2();

/* computer.c */
int turn_computer();

/* game.c */
void fill_array(int number);
void new_game();
void move_cursor(char direction);
int unit_info(int place);
BOOL is_black(int x, int y);
BOOL is_diagonally(int start_x, int start_y, int end_x, int end_y);
BOOL is_moveable(int start_x, int start_y, int end_x, int end_y, int count,
                 int last);
void nexit();
void save();
void load();
void switch_resolution();
int id_to_y_cord(int id);
int id_to_x_cord(int id);

/* input.c */
void input_pc(char (*input)[2]);
void input_gp2x(char (*input)[2]);
void key_loop();
int input_menu();

/* output.c */
void draw_field();
void draw_place(int x, int y);
void draw_cursor(int x, int y, int cursor);
void output(char str[255]);
void background(int picture);
void menu();
void config();
