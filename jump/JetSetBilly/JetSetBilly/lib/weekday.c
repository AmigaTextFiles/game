#include <math.h>
#include <stdio.h>

#include "proto.h"

/* Into Gregorian calendar in most European countries */
/* #define IGREG (15 + 31L * (10 * 12L * 1582)) */

/* but Finland (including its province Sweden) */
#define IGREG (18 + 31L * (1 * 12L * 1753))

static char *days[] = {
	"Sunday", "Monday", "Tuesday", "Wednesday",
	"Thursday", "Friday", "Saturday"
};

/*
 * Given day, month and year, return string value for day of the week
 *
 */
char *weekday(int day, int month, int year)
{
    int nday;

    nday = (int)((1 + julday(day, month, year)) % 7);

    return(days[nday]);
}

/* 
 * Generate the Julian date from an input day, month and year.
 * Acquired with thanks from _Numerical Recipes in C_ by Press, 
 * Flannery, Teukolsky and Vetterling; Cambridge University Press.
 *
 */
long
julday(int day, int month, int year)
{
	long jul;
	int a, y, m;

	if (year == 0) {
		fprintf(stderr, "Error. Can't use year zero.\n");
		return 0;
	}

	if (year < 0) year++;

	if (month > 2) {
		y = year;
		m = month + 1;
	} else {
		y = year - 1;
		m = month + 13;
	}

	jul = (long)(floor(365.25 * y) + floor(30.6001 * m) + day + 1720095);

	/* check whether to go to Gregorian calendar */

	if (day + 31L * (month + 12L * year) >= IGREG) {
		a = 0.01 * y;
		jul += 2 - a + (int)(0.25 * a);
	}

	return jul;
}
