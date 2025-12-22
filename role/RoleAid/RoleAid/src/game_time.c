/*
 * Middle-Earth game time for Roleaid ®
 * Converted from Eru © Mudlib
 *
 * Changes:
 *
 *	30. 4.1992 (NP)		Converted to C (from LPC), bugs fixed.
 *
 */

#include <exec/types.h>
#include <math.h>

#include "game_time.h"

int	year, day, hours, mins, secs;

void
init_game_time()
{
	year = 1627;
	day = 99;
	hours = 8;
	mins = 0;
	secs = 0;
}

void
set_year(int x)
{
	year = x;
}

void
set_day(int x)
{
	if (x < 0 || x > 364) return;
	day = x;
}

void
set_hour(int x)
{
	if (x < 0 || x > 23) return;
	hours = x;
}

void
set_minute(int x)
{
	if (x < 0 || x > 59) return;
	mins = x;
}

void
set_second(int x)
{
	if (x < 0 || x > 59) return;
	secs = x;
}

void
add_years(int x)
{
	year += x;
}

void
add_days(int x)
{
	day += x;
	if (day > 364) {
		add_years(day / 365);
		day -= 365 * (day / 365);
	}
}

void
add_hours(int x)
{
	hours += x;
	if (hours > 23) {
		add_days(hours / 24);
		hours -= 24 * (hours / 24);
	}
}

void
add_mins(int x)
{
	mins += x;
	if (mins > 59) {
		add_hours(mins / 60);
		mins -= 60 * (mins / 60);
	}
}

void
add_secs(int x)
{
	secs += x;
	if (secs > 59) {
		add_mins(secs / 60);
		secs -= 60 * (secs / 60);
	}
}

void
sub_years(int x)
{
	year -= x;
}

void
sub_days(int x) {
	day -= x;
	while (day < 0) {
		sub_years(1);
		day += 365;
	}
}

void
sub_hours(int x)
{
	hours -= x;
	while (hours < 0) {
		sub_days(1);
		hours += 24;
	}
}

void
sub_mins(int x)
{
	mins -= x;
	while (mins < 0) {
		sub_hours(1);
		mins += 60;
	}
}

void
sub_secs(int x)
{
	secs -= x;
	while (secs < 0) {
		sub_mins(1);
		secs += 60;
	}
}

int query_mins() { return mins; }
int query_secs() { return secs; }
int query_hours() { return hours; }
int query_year_day() { return day; }
int query_year() { return year; }

/* Return number of the month */
int
query_month()
{
	int d;

	d = day + 1;

	if (d == 365) return -1; /* Festival days: return -1 */
	if (d == 274) return -1; /* As they are outside of   */
	if (d == 183) return -1; /* the normal months.       */
	if (d ==  92) return -1;
	if (d ==   1) return -1;

	if (d > 364) d--; /* Kludge: throw away festival days */
	if (d > 273) d--;
	if (d > 182) d--;
	if (d >  91) d--;
	d -= 2;

	return (d / 30) + 1;
}

/* Used for weather */
int
query_festival_month()
{
	int d;

	d = day + 1;

	if (d == 274) return 9;
	if (d == 183) return 6;
	if (d ==  92) return 3;

	return 1;
}

/* Return name of the month (or festival) in sindar */
char *
query_month_name()
{
	int d;

	d = day + 1;

	if (d ==   1) return "Yestare"; /* Jule festival */
	if (d ==  92) return "Tuilere"; /* Spring festival */
	if (d == 183) return "Loende";  /* Midsummer festival */
	if (d == 274) return "Yaviere"; /* Autumn festival */
	if (d == 365) return "Mettare"; /* End of the year festival */

	switch(query_month()) {
		case  1: return "Narwain"; break;
		case  2: return "Ninui"; break;
		case  3: return "Gwaeron"; break;
		case  4: return "Gwirith"; break;
		case  5: return "Lothron"; break;
		case  6: return "Norui"; break;
		case  7: return "Cerveth"; break;
		case  8: return "Urui"; break;
		case  9: return "Ivanneth"; break;
		case 10: return "Narbeleth"; break;
		case 11: return "Hithui"; break;
		case 12: return "Girithron"; break;
		default: break;
	}

	return "error";
}

/* Return name of the month (or festival) in quenya */
char *
query_month_name_quenya()
{
	int d;

	d = day + 1;

	if (d ==   1) return "Yestare"; /* Jule festival */
	if (d ==  92) return "Tuilere"; /* Spring festival */
	if (d == 183) return "Loende";  /* Midsummer festival */
	if (d == 274) return "Yaviere"; /* Autumn festival */
	if (d == 365) return "Mettare"; /* End of the year festival */

	switch(query_month()) {
		case  1: return "Narvinye"; break;
		case  2: return "Nenieme"; break;
		case  3: return "Sulime"; break;
		case  4: return "Viresse"; break;
		case  5: return "Lotesse"; break;
		case  6: return "Narie"; break;
		case  7: return "Cermie"; break;
		case  8: return "Urime"; break;
		case  9: return "Yavannie"; break;
		case 10: return "Naruqelie"; break;
		case 11: return "Hisime"; break;
		case 12: return "Ringare";
		default: break;
	}
	return "error";
}

/* Return day of the month */
int
query_day()
{
	int d;

	d = day + 1;

	if (d == 365) return -1; /* Festival days: return -1 */
	if (d == 274) return -1; /* As they are outside of   */
	if (d == 183) return -1; /* the normal months.       */
	if (d ==  92) return -1;
	if (d ==   1) return -1;

	if (d > 364) d--; /* Kludge: throw away festival days */
	if (d > 273) d--;
	if (d > 182) d--;
	if (d >  91) d--;
	d -= 2;

	return (d - ((d/30) * 30)) + 1;
}

/* Return a description of the time of day */
char *
query_daytime()
{
	int h;

	h = hours + 1;

	if (h < 1 || h > 24) return "error";

	if ((h == 24 && mins > 45) || (h ==  1 && mins < 16))
		return "midnight";

	if ((h == 12 && mins > 45) || (h == 13 && mins < 16))
		return "noon";

	if (h >  3 && h <  6) return "early morning";
	if (h >  5 && h <  9) return "morning";
	if (h >  8 && h < 15) return "day";
	if (h > 14 && h < 18) return "afternoon";
	if (h > 17 && h < 22) return "evening";

	return "night";
}

/* Return season name in sindar */
char *
query_season()
{
	int m;

	m = query_month();

	if (m == -1) return "Festival day";

	if (m < 4) return "Hrive";
	if (m > 3 && m < 7) return "Tuile";
	if (m > 6 && m < 10) return "Laire";
	return "Yavie";
}

/* Return season name in english. Suits northern Middle-Earth. */
char *
query_season_english()
{
	int m;

	m = query_month();

	if (m < 1 || m > 12) return "Festival day";

	if (m < 3 || m > 11)	return "Winter";
	if (m == 3)		return "Stirring";
	if (m > 3 && m < 6)	return "Spring";
	if (m > 5 && m < 9)	return "Summer";
	if (m < 11)		return "Autumn";
	return "Fading";
}
