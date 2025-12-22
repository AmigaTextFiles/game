#ifndef _WEATHER_H
#define _WEATHER_H

/* weather.h */

/* base temp (farenheit), variation, % chance of precipitation */
struct Monthly_Weather_Type
{
	short	temp_base, temp_var, prec_chance;
};

struct Area_Weather
{
	char	*area_name;
	struct Monthly_Weather_Type w_types[12];
};

int farenheit_to_celcius(int);
int celcius_to_farenheit(int);
void todays_weather(void);
char *weather_desc(void);

/* Extern variables (So? Would you rather see this in AmigaBASIC?) */
extern struct Area_Weather aw[];

/* Defaults: constant for now */
/* Rhudaur */
#define DEFAULT_AREA 4

#endif /* _WEATHER_H */
