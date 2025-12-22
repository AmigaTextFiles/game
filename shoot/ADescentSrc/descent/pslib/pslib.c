/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#include <fcntl.h>

#include "library.h"
#include "parsarg.h"
#include "mem.h"

void print_usage ( void ) {

	 printf("    Usage: PSLIB <libfile> [<options>] <files>\n");
	 printf("       options :\n");
	 printf("         -a : add <files> to <libfile>\n");
	 printf("         -c : turn compression flag on\n");
	 printf("         -l : list all files in <libfile>\n");
	 printf("         -x : test extraction function\n");
	 printf("        -lr : test library read function\n");
	 printf("       -cfr : test cfreadfile function\n");
	 printf("       -cfw : test cfwrite function\n");
	 printf("\n       (for -cfr & -cfw, no <libfile> should be specified)\n");

	 exit(0);
}


void datetime( char *filename, ushort *date_ptr, ushort *time_ptr ) {
	int handle;
	ushort date, time;

	if( _dos_open( filename, O_RDONLY, &handle ) != 0 )
		printf( "    Unable to`open '%s' for date & time check\n", filename );
	else {
		_dos_getftime( handle, &date, &time );
		_dos_close( handle );
		*date_ptr = date;
		*time_ptr = time;
	}
}


void list_files( void ) {

	char header_buf[5];
	short numfiles;
	static char *methods[] = { "Stored", " LZW  " };
	int i;
	int total_length, total_size, total_ratio;

	printf("    Listing files in %s.\n\n", lib_name);
	InputLibFile = fopen( lib_name, "rb" );

	 if (InputLibFile == NULL) 
		{
		fprintf( stderr, "    PSLIB : %s file not found\n", lib_name );
		return;
		}

	for (i=0;i<5;i++) header_buf[i]=0;
	for (i=0;i<4;i++)
		 header_buf[i] = (char) getc( InputLibFile );

	if (strcmp(header_buf, "PSLB")) {
		fprintf( stderr, "    PSLIB : %s is not a PSLB file.\n", lib_name );
		fclose( InputLibFile );
	}
	else {
		//numfiles = (short) getc( InputLibFile );
		  fread( &numfiles, sizeof(short),1, InputLibFile );
		total_length = total_size = 0;
		printf( "                     Original\n");
		printf( "Filename       Length  Size  Ratio  Method         Date & Time\n");
		printf( "---------------------------------------------------------------------------\n");
		for (i=0;i<numfiles;i++) {
		   read_data( InputLibFile, &Header );
		   total_length += Header.length;
		   total_size += Header.original_size;
		   printf( "%-13s %6lu %6lu %4d%%   %-s      ",
					Header.name,
					Header.length,
					Header.original_size,
					Header.ratio,
					methods[ Header.compression ] );
			printf( "%-d/%d/%d %.2d:%.2d:%.2d\n",
					MONTH(Header.date), DAY(Header.date), YEAR(Header.date),
					HOUR(Header.time), MINUTE(Header.time), SECOND(Header.time) );
		}
		fclose( InputLibFile );
		printf( "---------------------------------------------------------------------------\n");
		total_ratio = 100 - (int) ( total_length * 100L / total_size );
		printf( "              %6lu %6lu %4d%%", total_length, total_size, total_ratio);
		printf("               Number of Files: %d\n", numfiles );

		}
	}


void check_list( char *argv ) {
	if (!strcmp( argv, "-l"))
		l_flag = LISTING;
}

void header_count( char *argv ) {
	if (!(*argv == '-')) headers++;
}

void cfr_test( char *input, char *output ) {
	ubyte *outputbuf;
	int size;

	//outputbuf = cfreadfile( input, &size );
	//if (WriteFile ( output, outputbuf, size ))
	//    printf("WriteFile Error\n");

}


void cfw_test( char *input, char *output ) {
	ubyte *inputbuf;
	int length;
	int success;

	//inputbuf = ( ubyte * ) ReadFileRaw( input, &length );
	//if (success = cfwrite( output, inputbuf, length ) )
	//    printf("    CFWRITE '%s' -> '%s' successful!\n", input, output);

}


void extract_test( char *extractname, char *extractout ) {
	ubyte *buffer;

	printf("Extracting %s from %s\n", extractname, lib_name);
	buffer = extract ( lib_name, extractname );
	if (buffer != NULL) {
		if (WriteFile( extractout, buffer, Header.original_size ))
			printf("WriteFile Error\n");
		free ( buffer );
	} else
		printf("    %s not found in library or local directory\n", extractname );
	return;
}


void lib_read_test( char *extractname, char *extractout ) {
	ubyte *buffer;
	int length;

	lib_init( lib_name);
	buffer = ReadFile ( extractname, &length );
	if (buffer == NULL)
		printf("    %s not found in library or local directory\n", extractname );
		else {
			printf("   %s found! and extracted.\n", extractname);
			if (WriteFile(extractout, buffer, length ))
				printf("WriteFile Error\n");
			free ( buffer );
		}
	lib_close();
	return;
}


void process_arg( char *argv ) {
	char filename[13], ext[_MAX_EXT];
	unsigned char *input;
	unsigned char *output;
	file_header Header;
	int length, i;

	_splitpath ( argv, NULL, NULL, &filename, &ext );
	strcat( filename, ext );

	if ( strcmp( argv, lib_name ) )    // Don't want to write library twice.
  {
	if (!strcmp( argv, "-c")) {
		printf("*** Compression Flag enabled.\n");
		c_flag = LF_LZW;
		return;
	}
	if (!strcmp( argv, "-a")) {
		printf("*** Building Library.\n");
		init_library ( lib_name, headers );
		b_flag = BUILDING;
		return;
	}
	else if ( *argv == '-' ) {
		fprintf(stderr, "    PSLIB : Invalid Flag %s\n", argv );
		return;
	}

	for (i=0;i<file_count;i++) {
		if (!strcmp(FileList[i], filename)) {
			printf("    ERROR processing %s : Duplicate file name.\n", filename );
			return;
		}
	}
	if ( b_flag == BUILDING ) {
		input = ( ubyte * ) ReadFileRaw( argv, &length );
		if (length == 0) {
			free(input);
			printf("     File: %s has no size.  Skipping...\n", argv);
		}
		if (length>0) {
		strcpy ( Header.name, filename );
		MALLOC(FileList[file_count], char, 13);
		strcpy ( FileList[file_count++], filename );
		  if (file_count >= MAX_FILES-1) {
				printf("\n    ERROR: MAX_FILES exceeded by file_count\n", file_count);
				for (i=0;i<file_count;i++)
					free( FileList[i] );
				free( lib_name );
			if ( input != NULL ) free( input );
				exit(1);
				} 
		Header.compression = c_flag;
		datetime( argv, &Header.date, &Header.time );
		if ( c_flag == LF_LZW ) {
			printf("*** LZW Compressing and Adding %s to Library %s : ", filename, lib_name );
			Header.offset = file_size ( lib_name );
			Header.original_size = length;
			output = lzw_compress( input, NULL, length, &Header.length );
			Header.ratio = 100 - (int) ( Header.length * 100L / Header.original_size );
			if (Header.length >= 0) {
				printf( "%d%%\n", Header.ratio );
				if (AppendFile( lib_name, output, Header.length))
					printf("AppendFile Error\n");
			}
			else {
				Header.length = length;
				Header.ratio = 0;
				printf("\n     Compression ratio sucked!  Storing uncompressed...\n");
				Header.compression = 0;
				if (AppendFile( lib_name, input, length ))
					printf("AppendFile Error\n");
			}
			write_file_header( lib_name, Header );
			if ( input != NULL ) free( input );
			if ( output != NULL ) free( output );
		}
		else {
			printf("*** Storing %s (uncompressed) in Library %s\n", filename, lib_name );
			Header.offset = file_size ( lib_name );
			Header.length = length;
			Header.original_size = length;
			Header.ratio = 0;
			write_file_header( lib_name, Header );
			if (AppendFile( lib_name, input, length ))
				printf("AppendFile Error\n");
			if ( input != NULL ) free( input );
			//if ( output != NULL ) free( output );
		}
	  }
	}
  }
}                                                               



void main( int argc, char *argv[] ) {
	int i;

	printf( "\nPSLIB 1.0 - " );
	printf( "Parallax Software Library Generation Tool.\n\n");

	if ( !strcmp( argv[1], "-cfr" ) ) {
		if (argc < 4) {
			printf("    Usage: PSLIB -cfr <cf-file> <outputfile>\n");
			exit(1);
		} else
	cfr_test( argv[2], argv[3] );
	exit(0);
	}

	if ( !strcmp( argv[1], "-cfw" ) ) {
		if (argc < 4) {
			printf("    Usage: PSLIB -cfw <inputfile>`<cf/outputfile>\n");
			exit(1);
		} else
	cfw_test( argv[2], argv[3] );
	exit(0);
	}

	if ( argc < 3 ) {
		print_usage();
	}

	file_count = 0;
	i=1;

	MALLOC(lib_name, char, 128);
	while (*argv[i] == '-')
		i++;
	strcpy( lib_name, argv[i] );
	strupr ( lib_name );

	if ( !strcmp( argv[2], "-lr" ) ) {
		if (argc < 5) {
			printf("    Usage: PSLIB <libfile> -lr <extractname> <outputfile>\n");
			free(lib_name);
			exit(1);
		} else
	lib_read_test( argv[3], argv[4] );
	} else
	if ( !strcmp( argv[2], "-x" ) ) {
		if (argc < 5) {
			printf("    Usage: PSLIB <libfile> -x <extractname> <outputfile>\n");
			free(lib_name);
			exit(1);
		} else
	extract_test( argv[3], argv[4] );
	}

	else {
		headers = 0;
		parse_args( argc-1, argv+1, check_list, 0 );
		if (l_flag == LISTING)
			list_files();
		else {
		parse_args( argc-1, argv+1, header_count, PA_EXPAND );
		if (headers<2) {
			free(lib_name);
			print_usage();
		}
		parse_args( argc-1, argv+1, process_arg, PA_EXPAND );
		}
		if (b_flag == BUILDING) {
			OutputLibFile = fopen( lib_name, "r+b" );
			if (!fseek( OutputLibFile, 4L, SEEK_SET ) ) {
					short temp;
					temp = file_count;
				//fputc( file_count, OutputLibFile );
					fwrite( &temp, sizeof(short), 1, OutputLibFile );
				printf( "\nFile Count : %d\n", file_count);
				for (i=0;i<file_count;i++) free(FileList[i]);
				}
			fclose( OutputLibFile );
			}
		else if (b_flag + l_flag == 0) {
			free(lib_name);
			print_usage();
		}
	free(lib_name);
	}
}

