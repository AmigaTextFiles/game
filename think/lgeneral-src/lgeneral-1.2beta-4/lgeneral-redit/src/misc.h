#ifndef __MISC_H
#define __MISC_H

/* compare strings */
#define STRCMP( str1, str2 ) ( strlen( str1 ) == strlen( str2 ) && !strncmp( str1, str2, strlen( str1 ) ) )

#define AXIS 0
#define ALLIES 1
#define CLASS_COUNT 14
#define SCEN_COUNT 38

/* unitlib entry */
typedef struct {
    char id[8];
    char name[24];
    int side; /* either axis(0) or allies(1) determined
                 from mirror index list which are the allied
                 units */
} UnitLib_Entry;

/* reinforcement */
typedef struct {
    int pin; /* PIN to identify unit when removing */
    char id[8]; /* unit id */
    char trp[8]; /* transporter id */
    char info[128]; /* info string */
    int delay;
    int str;
    int exp;
    /* to reselect unit properties from reinf list */
    int class_id;
    int unit_id;
    int trp_id;
} Unit;

/*
====================================================================
Load/save reinforcement resources
====================================================================
*/
void load_reinf();
void save_reinf();

/*
====================================================================
Build LGC-PG reinforcements file.
====================================================================
*/
void build_reinf();

/*
====================================================================
Inititate application and load resources.
====================================================================
*/
void init();

/*
====================================================================
Cleanup
====================================================================
*/
void finalize();

/*
====================================================================
Copy source to dest and at maximum limit chars. Terminate with 0.
====================================================================
*/
void strcpy_lt( char *dest, char *src, int limit );

/*
====================================================================
Update unit/transporters/reinf list
====================================================================
*/
void update_unit_list( int player, int unit_class );
void update_trp_list( int player );
void update_reinf_list( int scen, int player );

/*
====================================================================
Read all lines from file.
====================================================================
*/
List* file_read_lines( FILE *file );

/*
====================================================================
Build units info string.
====================================================================
*/
void build_unit_info( Unit *unit, int player );

#endif
