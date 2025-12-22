#ifndef _GAME_TIME_H
#define _GAME_TIME_H

/* game_time.h */
/* Prototypes */

void init_game_time(void);

void set_year(int);
void set_day(int);
void set_hour(int);
void set_minute(int);
void set_second(int);

void add_years(int);
void add_days(int);
void add_hours(int);
void add_mins(int);
void add_secs(int);
void sub_years(int);
void sub_days(int);
void sub_hours(int);
void sub_mins(int);
void sub_secs(int);

int query_mins(void);
int query_secs(void);
int query_hours(void);
int query_year_day(void);
int query_year(void);
int query_month(void);
int query_festival_month(void);
int query_day(void);
char *query_month_name(void);
char *query_month_name_quenya(void);
char *query_daytime(void);
char *query_season(void);
char *query_season_english(void);

/* Yep, it's externs again! */
extern int	year, day, hours, mins, secs;

#endif /* _GAME_TIME_H */
