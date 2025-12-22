#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>
#include "support.h"
#include "parser.h"
#include "misc.h"

extern GtkWidget *window;

char *unit_classes[] = {
    "inf",      "Infantry",
    "tank",     "Tank",
    "recon",    "Recon",
    "antitank", "Anti-Tank",
    "art",      "Artillery",
    "antiair",  "Anti-Aircraft",
    "airdef",   "Air-Defense",
    "fighter",  "Fighter", 
    "tacbomb",  "Tactical Bomber",
    "levbomb",  "Level Bomber",
    "sub",      "Submarine",
    "dest",     "Destroyer",
    "cap",      "Capital Ship",
    "carrier",  "Aircraft Carrier"
    /* landtrp is supportive to classes 
       listed above */
};

char *scenarios[] = {
    "Poland", "Warsaw", "Norway", "LowCountries", "France",
    "Sealion40", "NorthAfrica", "MiddleEast", "ElAlamein",
    "Caucasus", "Sealion43", "Torch", "Husky", "Anzio",
    "D-Day", "Anvil", "Ardennes", "Cobra", "MarketGarden",
    "BerlinWest", "Balkans", "Crete", "Barbarossa", "Kiev",
    "Moscow41", "Sevastapol", "Moscow42", "Stalingrad",
    "Kharkov", "Kursk", "Moscow43", "Byelorussia",
    "Budapest", "BerlinEast", "Berlin", "Washington",
    "EarlyMoscow", "SealionPlus"
};

/* while axis reinforcements are always 
   supplied to Germany the Allied side 
   depends on the scenario */
char *nations[] = {
    "pol", "pol", "eng", "eng", "fra", "eng", "eng", "eng",
    "eng", "so", "eng", "usa", "usa", "usa", "usa", "usa",
    "usa", "usa", "usa", "usa", "eng", "eng", "so", "so",
    "so", "so", "so", "so", "so", "so", "so", "so", "so",
    "so", "usa", "usa", "so", "eng"
};

/*
====================================================================
Icon indices that must be mirrored terminated by -1
====================================================================
*/
int mirror_ids[] = {
    83, 84, 85, 86, 87, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
    102, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114,
    115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126,
    127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138,
    139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
    151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162,
    163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174,
    175, 176, 177, 178, 179, 180, 181 ,182, 183, 184, 185, 186, 
    187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198,
    199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 221,
    232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243,
    244, 250, -1
};

/*
====================================================================
UnitLib entries separated to their classes (axis/allies)
====================================================================
*/
List *unitlib[2][CLASS_COUNT];
List *trplib[2]; /* transporters */
/*
====================================================================
Reinforcements for each scenario (axis/allies)
====================================================================
*/
List *reinf[2][SCEN_COUNT];
/*
====================================================================
Current selections
====================================================================
*/
int cur_scen = 0, cur_player = AXIS, cur_class = 0;
int cur_unit = -1, cur_trp = -1, cur_pin = 1;
int cur_reinf = -1; /* row selection id */

/*
====================================================================
Load/save reinforcement resources
====================================================================
*/
void load_reinf()
{
    char *line;
    Unit *unit;
    int i, j, k, count;
    FILE *file = fopen( "reinf.rc", "r" );
    List *list, *args;
    if ( file ) 
        list = file_read_lines( file );
    else
        return;
    fclose( file );
    cur_pin = 1;
    for ( i = 0; i < SCEN_COUNT; i++ )
    {
        line = list_next( list );
        for ( j = 0; j < 2; j++ ) {
            list_clear( reinf[j][i] );
            count = atoi( list_next( list ) );
            for ( k = 0; k < count; k++ ) {
                line = list_next( list );
                if ( ( args = parser_explode_string( line, ',' ) ) ) {
                    if ( ( unit = calloc( 1, sizeof( Unit ) ) ) ) {
                        unit->pin = cur_pin++;
                        unit->delay = atoi( list_next( args ) );
                        strcpy_lt( unit->id, list_next( args ), 7 );
                        strcpy_lt( unit->trp, list_next( args ), 7 );
                        unit->str = atoi( list_next( args ) );
                        unit->exp = atoi( list_next( args ) );
                        unit->class_id = atoi( list_next( args ) );
                        unit->unit_id = atoi( list_next( args ) );
                        unit->trp_id = atoi( list_next( args ) );
                        build_unit_info( unit, j );
                        list_add( reinf[j][i], unit );
                    }
                    list_delete( args );
                }
            }
        }
    }
    list_delete( list );
    /* update */
    update_reinf_list( cur_scen, cur_player );
}
void save_reinf()
{
    Unit *unit;
    int i, j;
    FILE *file = fopen( "reinf.rc", "w" );
    if ( file == 0 ) return;
    printf( "Reinforcements saved to ./reinf.rc\n" );
    for ( i = 0; i < SCEN_COUNT; i++ )
    {
        fprintf( file, "%s\n", scenarios[i] );
        for ( j = 0; j < 2; j++ ) {
            fprintf( file, "%i\n", reinf[j][i]->count );
            list_reset( reinf[j][i] );
            while ( ( unit = list_next( reinf[j][i] ) ) ) 
                fprintf( file, "%i,%s,%s,%i,%i,%i,%i,%i\n", unit->delay,
                         unit->id, unit->trp, unit->str,
                         unit->exp,
                         unit->class_id, unit->unit_id, unit->trp_id );
        }
    }
    fclose( file );
}

/*
====================================================================
Build LGC-PG reinforcements file in ../../src/convdata
====================================================================
*/
void build_reinf()
{
    Unit *unit;
    int i, j;
    FILE *file = fopen( "../../lgc-pg/convdata/reinf", "w" );
    if ( file ) {
        for ( i = 0; i < SCEN_COUNT; i++ ) {
            if ( reinf[AXIS][i]->count == 0 )
                if ( reinf[ALLIES][i]->count == 0 )
                    continue;
            fprintf( file, "%s {\n", scenarios[i] );
            for ( j = 0; j < 2; j++ ) {
                if ( reinf[j][i]->count == 0 )
                    continue;
                fprintf( file, "  %s {\n", (j==AXIS)?"ger":nations[i] );
                list_reset( reinf[j][i] );
                while ( ( unit = list_next( reinf[j][i] ) ) )
                    fprintf( file, "    unit { id = %s trsp = %s "
                                              "delay = %i str = %i "
                                              "exp = %i }\n",
                             unit->id, unit->trp, unit->delay,
                             unit->str, unit->exp );
                fprintf( file, "  }\n" );
            }
            fprintf( file, "}\n\n" );
        }
        fclose( file );
        printf( "Reinforcements built to ../../lgc-pg/convdata/reinf\n" );
    }
    else
        printf( "../../lgc-pg/convdata/reinf not found!\n" );
}

/*
====================================================================
Inititate application and load resources.
====================================================================
*/
void init()
{
    gchar *row[1];
    GtkWidget *clist = 0;
    UnitLib_Entry *entry = 0;
    PData *pd = 0, *units = 0, *unit = 0;
    int i, j;
    char *str;
    /* create lists */
    for ( j = 0; j < 2; j++ ) {
        for ( i = 0; i < CLASS_COUNT; i++ )
            unitlib[j][i] = list_create( LIST_AUTO_DELETE, 
                                         LIST_NO_CALLBACK );
        trplib[j] = list_create( LIST_AUTO_DELETE,
                                 LIST_NO_CALLBACK );
        if ( ( entry = calloc( 1, sizeof( UnitLib_Entry ) ) ) ) {
            strcpy( entry->name, "NONE" );
            list_add( trplib[j], entry );
        }
        for ( i = 0; i < SCEN_COUNT; i++ )
            reinf[j][i] = list_create( LIST_AUTO_DELETE, 
                                       LIST_NO_CALLBACK );
    }
    /* load unit lib */
    if ( ( pd = parser_read_file( "unitlib", "../../src/units/pg.udb" ) ) == 0 )
        goto failure;
    if ( !parser_get_pdata( pd, "unit_lib", &units ) )
        goto failure;
    /* load and categorize unit entries */
    list_reset( units->entries );
    while ( ( unit = list_next( units->entries ) ) ) {
        /* id, name and side */
        if ( ( entry = calloc( 1, sizeof( UnitLib_Entry ) ) ) == 0 )
            goto failure;
        strcpy_lt( entry->id, unit->name, 7 );
        if ( parser_get_value( unit, "name", &str, 0 ) )
            strcpy_lt( entry->name, str, 23 );
        if ( parser_get_value( unit, "icon_id", &str, 0 ) )
             j = atoi( str ); 
        i = 0; entry->side = 0;
        while ( 1 ) {
            if ( mirror_ids[i++] == j ) {
                entry->side = 1;
                break;
            }
            if ( mirror_ids[i] == -1 )
                break;
        }
        /* get class and add to list */
        if ( parser_get_value( unit, "class", &str, 0 ) ) {
            if ( STRCMP( "landtrp", str ) )
                /* ground transporters are special */
                list_add( trplib[entry->side], entry );
            else
                for ( i = 0; i < CLASS_COUNT; i++ )
                    if ( STRCMP( unit_classes[i * 2], str ) ) {
                        list_add( unitlib[entry->side][i], entry );
                        break;
                    }
        }
    }
    /* load reinforcements */
    load_reinf();
    /* add scenarios to list l_scenarios */
    if ( ( clist = lookup_widget( window, "scenarios" ) ) ) {
        for ( i = 0; i < SCEN_COUNT; i++ ) {
            row[0] = scenarios[i];
            gtk_clist_append( GTK_CLIST (clist), row );
        }
    }
    /* show unit list */
    update_unit_list( cur_player, cur_class );
    update_trp_list( cur_player );
    /* we're done */
    parser_free( &pd );
    return;
failure:
    parser_free( &pd );
    finalize();
    fprintf( stderr, "Aborted: %s\n", parser_get_error() );
    exit( 1 );
}

/*
====================================================================
Cleanup
====================================================================
*/
void finalize()
{
    int i, j;
    for ( j = 0; j < 2; j++ ) {
        for ( i = 0; i < CLASS_COUNT; i++ )
            if ( unitlib[j][i] ) 
                list_delete( unitlib[j][i] );
        if ( trplib[j] )
            list_delete( trplib[j] );
        for ( i = 0; i < SCEN_COUNT; i++ )
            if ( reinf[j][i] ) 
                list_delete( reinf[j][i] );
    }
}

/*
====================================================================
Copy source to dest and at maximum limit chars. Terminate with 0.
====================================================================
*/
void strcpy_lt( char *dest, char *src, int limit )
{
    int len = strlen( src );
    if ( len > limit ) {
        strncpy( dest, src, limit );
        dest[limit] = 0;
    }
    else
        strcpy( dest, src );
}

/*
====================================================================
Update unit/transporters list
====================================================================
*/
void update_unit_list( int player, int unit_class )
{
    UnitLib_Entry *entry;
    gchar *row[1];
    GtkWidget *clist;
    if ( ( clist = lookup_widget( window, "units" ) ) ) {
        gtk_clist_clear( GTK_CLIST(clist) );
        list_reset( unitlib[player][unit_class] );
        while ( ( entry = list_next( unitlib[player][unit_class] ) ) ) {
            row[0] = entry->name;
            gtk_clist_append( GTK_CLIST(clist), row );
        }
    }
}
void update_trp_list( int player )
{
    UnitLib_Entry *entry;
    gchar *row[1];
    GtkWidget *clist;
    if ( ( clist = lookup_widget( window, "transporters" ) ) ) {
        gtk_clist_clear( GTK_CLIST(clist) );
        list_reset( trplib[player] );
        while ( ( entry = list_next( trplib[player] ) ) ) {
            row[0] = entry->name;
            gtk_clist_append( GTK_CLIST(clist), row );
        }
    }
}
void update_reinf_list( int scen, int player )
{
    Unit *entry;
    gchar *row[1];
    GtkWidget *clist;
    if ( ( clist = lookup_widget( window, "reinforcements" ) ) ) {
        gtk_clist_clear( GTK_CLIST(clist) );
        list_reset( reinf[player][scen] );
        while ( ( entry = list_next( reinf[player][scen] ) ) ) {
            row[0] = entry->info;
            gtk_clist_append( GTK_CLIST(clist), row );
        }
        gtk_clist_sort( GTK_CLIST(clist) );
    }
}

/*
====================================================================
Read all lines from file.
====================================================================
*/
List* file_read_lines( FILE *file )
{
    List *list;
    char buffer[1024];

    if ( !file ) return 0;

    list = list_create( LIST_AUTO_DELETE, LIST_NO_CALLBACK );
    
    /* read lines */
    while( !feof( file ) ) {
        if ( !fgets( buffer, 1023, file ) ) break;
        if ( buffer[0] == 10 ) continue; /* empty line */
        buffer[strlen( buffer ) - 1] = 0; /* cancel newline */
        list_add( list, strdup( buffer ) );
    }
    return list;
}

/*
====================================================================
Build unit's info string.
====================================================================
*/
void build_unit_info( Unit *unit, int player )
{
    int i;
    UnitLib_Entry *entry, *trp_entry = 0;
    for ( i = 0; i < CLASS_COUNT; i++ ) {
        list_reset( unitlib[player][i] );
        while ( ( entry = list_next( unitlib[player][i] ) ) )
            if ( STRCMP( entry->id, unit->id ) )
                break;
        if ( entry )
            break;
    }
    if ( !STRCMP( unit->trp, "none" ) ) {
        list_reset( trplib[player] );
        while ( ( trp_entry = list_next( trplib[player] ) ) )
            if ( STRCMP( trp_entry->id, unit->trp ) )
                break;
    }
    if ( trp_entry ) {
        snprintf( unit->info, 128, 
                  "T %02i: '%s' (%i, %i Stars) [%s]   #%i", 
                  unit->delay + 1, entry->name, 
                  unit->str, unit->exp,
                  trp_entry->name, unit->pin );
    }
    else
        snprintf( unit->info, 128, 
                  "T %02i: '%s' (%i, %i Stars)   #%i", 
                  unit->delay + 1, entry->name, 
                  unit->str, unit->exp,
                  unit->pin );
}
