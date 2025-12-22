/* Prototypes for functions defined in
examine_city.c
 */

extern char * lv_text[11];

extern int high_text;

extern int now_text;

void draw_listview(void);

void update_listview(int new_text);

void new_examine_city(struct City * metro);

void status_report(int player);

