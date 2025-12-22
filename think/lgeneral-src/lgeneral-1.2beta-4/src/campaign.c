/***************************************************************************
                          campaign.c  -  description
                             -------------------
    begin                : Fri Apr 5 2002
    copyright            : (C) 2001 by Michael Speck
    email                : kulkanie@gmx.net
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 
#include "lgeneral.h" 
#include "parser.h"
#include "list.h"
#include "unit.h"
#include "date.h"
#include "scenario.h"
#include "campaign.h"

/*
====================================================================
Externals
====================================================================
*/
extern Setup setup;

int camp_loaded = 0;
char *camp_fname = 0;
char *camp_name = 0;
char *camp_desc = 0;
char *camp_authors = 0;
List *camp_entries = 0; /* scenario entries */
Camp_Entry *camp_cur_scen = 0;

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Delete campaign entry.
====================================================================
*/
static void camp_delete_entry( void *ptr )
{
    Camp_Entry *entry = (Camp_Entry*)ptr;
    if ( entry ) {
        if ( entry->id ) free( entry->id );
        if ( entry->scen ) free( entry->scen );
        if ( entry->brief ) free( entry->brief );
        if ( entry->nexts ) list_delete( entry->nexts );
        free( entry );
    }
}

/* check whether all next entries have a matching scenario entry */
static void camp_verify_tree()
{
    int i;
    Camp_Entry *entry = 0;
    char *next = 0, *ptr;

    for ( i = 0; i < camp_entries->count; i++ )
    {
        entry = list_get( camp_entries, i );
        if ( entry->nexts && entry->nexts->count > 0 )
        {
            list_reset( entry->nexts );
            while ( (next = list_next(entry->nexts)) )
            {
                ptr = strchr( next, '>' ); 
                if ( ptr ) 
                    ptr++; 
                else 
                    ptr = next;
                if ( camp_get_entry(ptr) == 0 ) 
                    printf( "  (is a 'next' entry in scenario %s)\n", entry->id );
            }
        }
    }
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Load campaign.
====================================================================
*/
int camp_load( char *fname )
{
    Camp_Entry *centry = 0;
    PData *pd, *sub, *subsub;
    List *entries, *next_entries;
    char path[512], str[512];
    char *result, *next_scen;
    camp_delete();
    sprintf( path, "%s/campaigns/%s", SRC_DIR, fname );
    camp_fname = strdup( fname );
    if ( ( pd = parser_read_file( fname, path ) ) == 0 ) goto parser_failure;
    /* name, desc, authors */
    if ( !parser_get_string( pd, "name", &camp_name ) ) goto parser_failure;
    if ( !parser_get_string( pd, "desc", &camp_desc ) ) goto parser_failure;
    if ( !parser_get_string( pd, "authors", &camp_authors ) ) goto parser_failure;
    /* entries */
    if ( !parser_get_entries( pd, "scenarios", &entries ) ) goto parser_failure;
    list_reset( entries );
    camp_entries = list_create( LIST_AUTO_DELETE, camp_delete_entry );
    while ( ( sub = list_next( entries ) ) ) {
        centry = calloc( 1, sizeof( Camp_Entry ) );
        centry->id = strdup( sub->name );
        parser_get_string( sub, "scenario", &centry->scen );
        if ( !parser_get_string( sub, "briefing", &centry->brief ) ) goto parser_failure;
        if ( parser_get_entries( sub, "next", &next_entries ) ) {
            centry->nexts = list_create( LIST_AUTO_DELETE, LIST_NO_CALLBACK );
            list_reset( next_entries );
            while ( ( subsub = list_next( next_entries ) ) ) {
                result = subsub->name;
                next_scen = list_first( subsub->values );
                sprintf( str, "%s>%s", result, next_scen );
                list_add( centry->nexts, strdup( str ) );
            }
        }
        list_add( camp_entries, centry );
    }
    parser_free( &pd );
    camp_loaded = 1;
    camp_verify_tree();
    return 1;
parser_failure:
    fprintf( stderr, "%s\n", parser_get_error() );
    camp_delete();
    return 0;
}
/*
====================================================================
Load a campaign description (newly allocated string)
and setup the setup :) except the type which is set when the 
engine performs the load action.
====================================================================
*/
char* camp_load_info( char *fname )
{
    PData *pd;
    char path[512];
    char *name, *desc;
    char *info = 0;
    sprintf( path, "%s/campaigns/%s", SRC_DIR, fname );
    if ( ( pd = parser_read_file( fname, path ) ) == 0 ) goto parser_failure;
    if ( !parser_get_value( pd, "name", &name, 0 ) ) goto parser_failure;
    if ( !parser_get_value( pd, "desc", &desc, 0 ) ) goto parser_failure;
    if ( ( info = calloc( strlen( name ) + strlen( desc ) + 3, sizeof( char ) ) ) == 0 ) {
        fprintf( stderr, "Out of memory\n" );
        goto failure;
    }
    sprintf( info, "%s##%s", name, desc );
    strcpy( setup.fname, fname );
    parser_free( &pd );
    return info;
parser_failure:
    fprintf( stderr, "%s\n", parser_get_error() );
failure:
    if ( info ) free( info );
    parser_free( &pd );
    return 0;
}

void camp_delete()
{
    if ( camp_fname ) free( camp_fname ); camp_fname = 0;
    if ( camp_name ) free( camp_name ); camp_name = 0;
    if ( camp_desc ) free( camp_desc ); camp_desc = 0;
    if ( camp_authors ) free( camp_authors ); camp_authors = 0;
    if ( camp_entries ) list_delete( camp_entries ); camp_entries = 0;
    camp_loaded = 0;
    camp_cur_scen = 0;
}

/*
====================================================================
Query next campaign scenario entry by this result for the current
entry. If 'id' is NULL the first entry called 'first' is loaded.
====================================================================
*/
Camp_Entry *camp_get_entry( char *id )
{
    char *search_str;
    Camp_Entry *entry;
    if ( id == 0 )
        search_str = strdup( "first" );
    else
        search_str = strdup( id );
    list_reset( camp_entries );
    while ( ( entry = list_next( camp_entries ) ) )
        if ( strcmp( entry->id, search_str ) == 0 ) {
            free( search_str );
            return entry;
        }
    fprintf( stderr, "Campaign entry '%s' not found in campaign '%s'\n", search_str, camp_name );
    free( search_str );
    return 0;
}

/*
====================================================================
Set the next scenario entry by searching the results in current
scenario entry. If 'id' is NULL entry 'first' is loaded
====================================================================
*/
int camp_set_next( char *id )
{
    List *tokens;
    char *next_str;
    int found = 0;
    if ( id == 0 )
        camp_cur_scen = camp_get_entry( "first" );
    else {
        list_reset( camp_cur_scen->nexts );
        while ( ( next_str = list_next( camp_cur_scen->nexts ) ) ) {
            if ( ( tokens = parser_split_string( next_str, ">" ) ) ) {
                if ( STRCMP( id, list_first( tokens ) ) ) {
                    camp_cur_scen = camp_get_entry( list_get( tokens, 2 ) );
                    found = 1;
                }
                list_delete( tokens );
                if ( found ) break;
            }
        }
    }
    return camp_cur_scen != 0;
}

/*
====================================================================
Set current scenario by camp scen entry id.
====================================================================
*/
void camp_set_cur( char *id )
{
    camp_cur_scen = camp_get_entry( id );
}
