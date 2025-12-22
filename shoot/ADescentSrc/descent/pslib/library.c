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
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>

#include "library.h"
#include "mem.h"
#include "error.h"

int lib_flag;           // library flag
int l_flag;             // listing flag
int b_flag;             // building flag;
int c_flag;             // compression flag
FILE *InputLibFile;     // file to read from
FILE *OutputLibFile;    // file to write to
char *lib_name;         // name of the library
int file_count;         // number of files processed
int headers;            // number of header spaces allocated
char *FileList[MAX_FILES]; // Contains the list of files being processed
file_header Header;     // Holds header info of file being processed

file_header *LibHeaderList;
FILE *InputLibInitFile; // file to read from
short init_numfiles;    // number of files in the library

#define O_BINARY 0

int ReadFileBufRaw( char *filename, ubyte *buf, int bufsize )
{
	int length;
	int handle;

	handle = open( filename, O_RDONLY | O_BINARY );
	if (handle == -1 ) 
		Error("File %s, %s ",filename,strerror(errno)); 

	if (length = read( handle, buf, bufsize ) != bufsize )    
		{
		close( handle );
	  Error("File %s, %s ",filename,strerror(errno)); 
		}
	close( handle );

	return length;
}


ubyte *ReadFileRaw( char *filename, int *length )
{
	void *FileData;
	int handle;

	handle = open( filename, O_RDONLY | O_BINARY );
	if (handle == -1 )
		return NULL;
		// Error("File %s, %s ",filename,strerror(errno)); 

	*length = filelength( handle );

 //   MALLOC( FileData, ubyte, *length );//Compile hack again -KRB
	FileData = (ubyte *)malloc(*length*sizeof(ubyte));

	if (FileData == NULL )  {
		close( handle );
		Error("File %s, cannot malloc memory",filename);
   }

	if (read( handle, FileData, *length ) != *length )    {
		free( FileData );
		close( handle );
	  Error("File %s, %s ",filename,strerror(errno)); 
	}
	close( handle );

	return FileData;

}

int AppendFile( char *filename, void *data, int length )
{
	int handle;

	handle = open( filename, O_WRONLY | O_CREAT | O_APPEND | O_BINARY , S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP );
	if (handle == -1 ) {
//        return ERROR_OPENING_FILE;
		Error("File %s, %s ",filename,strerror(errno)); 
	}
	if (write( handle, data, length )!=length)  {
		close( handle );
//        return ERROR_WRITING_FILE;
		Error("File %s, %s ",filename,strerror(errno)); 
	}

	close( handle );
	return 0;
}

int WriteFile( char *filename, void *data, int length )
{
	int handle;

	handle = open( filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP );
	if (handle == -1 ) {
//        return ERROR_OPENING_FILE;
		Error("File %s, %s ",filename,strerror(errno)); 
	}
	if (write( handle, data, length )!=length)  {
		close( handle );
//        return ERROR_WRITING_FILE;
		Error("File %s, %s ",filename,strerror(errno)); 
	}

	close( handle );
	return 0;
}


int cfwritefile( char *filename, ubyte *buffer, int length ) {
	FILE *output;
	ubyte *compressed;
	int size;

	output = fopen( filename, "wb");

	putc( 'C', output );
	putc( 'F', output );
	fwrite( &length, sizeof(length), 1, output);

	compressed = lzw_compress( buffer, NULL, length, &size);

	if (size < 0) {
		printf("    WARNING! : Compressed size larger than original\n");
		printf("                Not storing.\n");
	}
	else {
		fwrite( compressed, sizeof(ubyte), size, output);
		fclose( output );
		free( compressed );
		return LF_LZW;
	}
	return 0;
}


ubyte *cfreadfile( char *filename, int *size ) {
	FILE *input;
	ubyte *tempbuf;
	ubyte *buf;
	char header[3];
	int length, i;

	input = fopen( filename, "rb" );

	for (i=0;i<3;i++) header[i]=0;
	for (i=0;i<2;i++)
		 header[i] = (char) getc( input );

	if (strcmp( header, "CF" )) {
		return NULL;
	}

	fread( size, sizeof(int), 1, input);

	length = file_size( filename ) - 6;
	//MALLOC( tempbuf, ubyte, length );//Compile hack again -KRB
	tempbuf=(ubyte *)malloc(length*sizeof(ubyte));
	fread( tempbuf, sizeof(ubyte), length, input );

	buf = lzw_expand( tempbuf, NULL, *size );

	return buf;

}


ubyte *extract( char *library, char *filename ) {
	int i;
	ubyte *buf_ptr;
	ubyte *buf;
	ubyte *tempbuf;
	char header_buf[5];
	short numfiles;

	strupr( filename );
	InputLibFile = fopen( library, "rb" );

	for (i=0;i<5;i++) header_buf[i]=0;
	for (i=0;i<4;i++)
		 header_buf[i] = (char) getc( InputLibFile );

	if (strcmp(header_buf, "PSLB")) {
		fclose( InputLibFile );
		return NULL;
	}
	else {
		//numfiles = (short) getc( InputLibFile );
		  fread( &numfiles, sizeof(short), 1, InputLibFile );
		for (i=0; i<numfiles; i++) {
		   read_data( InputLibFile, &Header );

		   if (!strcmp(Header.name, filename)) {
				fseek( InputLibFile, Header.offset, SEEK_SET );
				//MALLOC(buf, ubyte, Header.original_size);//Compile hack again -KRB
				buf=(ubyte *)malloc(Header.original_size*sizeof(ubyte));
				buf_ptr = buf;

				if ( Header.compression == 0 ) {
					fread( buf, sizeof(ubyte), Header.original_size, InputLibFile );
				}

					else if ( Header.compression == LF_LZW ) {
						//MALLOC(tempbuf, ubyte, Header.length);//Compile hack again -KRB
						tempbuf=(ubyte*)malloc(Header.length*sizeof(ubyte));
						fread( tempbuf, sizeof(ubyte), Header.length, InputLibFile );
						lzw_expand( tempbuf, buf, Header.original_size );
					}

				break;
			}
		 }
		 if ( i >= numfiles ) return NULL;

		 fclose( InputLibFile );
		 return buf_ptr;
	}
}

int read_data( FILE *fp, struct file_header *p )
	{
		return( fread( p, sizeof(*p), 1, fp ) );
	}


int file_size( char *name ) {
	long eof_ftell;
	FILE *file;

	file = fopen( name, "r" );
	if ( file == NULL )
		return( 0L );
	fseek( file, 0L, SEEK_END );
	eof_ftell = ftell( file );
	fclose( file );
	return( eof_ftell );
}


int ReadFileBuf( char *filename, ubyte *buf, int bufsize ) {
	int i;
	int length;
	ubyte *tempbuf;

	strupr( filename );

	length = -1;

	if (CheckFile( filename )==1)  
		 return ReadFileBufRaw( filename, buf, bufsize );

	if (lib_flag == 1)
		for ( i=0; i < init_numfiles; i++ ) {
		   if (!strcmp(LibHeaderList[i].name, filename)) {
				fseek( InputLibInitFile, LibHeaderList[i].offset, SEEK_SET );
				length = LibHeaderList[i].original_size;
	
				if ( length == bufsize )
				if ( LibHeaderList[i].compression == 0 ) {
					//printf("Reading buf size = %d\n", LibHeaderList[i].original_size);
					fread( buf, sizeof(ubyte), LibHeaderList[i].original_size, InputLibInitFile );
				}
					else if ( LibHeaderList[i].compression == LF_LZW ) {
						//MALLOC(tempbuf, ubyte, LibHeaderList[i].length);//Compile hack again -KRB
						tempbuf=(ubyte *)malloc( LibHeaderList[i].length*sizeof(ubyte));
						fread( tempbuf, sizeof(ubyte), LibHeaderList[i].length, InputLibInitFile );
						lzw_expand( tempbuf, buf, LibHeaderList[i].original_size );
					}
	
				break;
			}
		 }
		// else 
	  //  return ReadFileBufRaw( filename, buf, bufsize );

	 if ( i >= init_numfiles ) 
			return ReadFileBufRaw( filename, buf, bufsize );
	
	return length;  //buf_ptr;
}


ubyte *ReadFile( char *filename, int *length ) {
	int i;
	ubyte *buf_ptr;
	ubyte *buf;
	ubyte *tempbuf;

	strupr( filename );

	*length = -1;

	 if (CheckFile( filename )==1)
		return ReadFileRaw( filename, length );

	if (lib_flag == 1)
		for ( i=0; i < init_numfiles; i++ ) {
		   if (!strcmp(LibHeaderList[i].name, filename)) {
				fseek( InputLibInitFile, LibHeaderList[i].offset, SEEK_SET );
				//MALLOC(buf, ubyte, LibHeaderList[i].original_size);//Compile hack again -KRB
				buf=(ubyte *)malloc(LibHeaderList[i].original_size*sizeof(ubyte));
				buf_ptr = buf;
				*length = LibHeaderList[i].original_size;
	
				if ( LibHeaderList[i].compression == 0 ) {
					//printf("Reading buf size = %d\n", LibHeaderList[i].original_size);
					fread( buf, sizeof(ubyte), LibHeaderList[i].original_size, InputLibInitFile );
				}
	
					else if ( LibHeaderList[i].compression == LF_LZW ) {
						//MALLOC(tempbuf, ubyte, LibHeaderList[i].length);//Compile hack again -KRB
						tempbuf=(ubyte *)malloc(LibHeaderList[i].length*sizeof(ubyte));
						fread( tempbuf, sizeof(ubyte), LibHeaderList[i].length, InputLibInitFile );
						lzw_expand( tempbuf, buf, LibHeaderList[i].original_size );
					}
	
				break;
			}
		 } 
			//else
				//return ReadFileRaw( filename, length );

	 if ( i >= init_numfiles )
			return ReadFileRaw( filename, length );

	 return buf_ptr;
}


//returns error codes listed in cflib.h
int lib_init( char *init_lib_name ) {

	char header_buf[5];
	int i;
	short temp;

	InputLibInitFile = fopen( init_lib_name, "rb" );

	 if (! InputLibInitFile) return LI_NO_FILE;

	for (i=0;i<5;i++) header_buf[i]=0;
	for (i=0;i<4;i++)
		 header_buf[i] = (char) getc( InputLibInitFile );

	if (strcmp(header_buf, "PSLB")) {
		fclose( InputLibInitFile );
		return LI_NOT_PSLIB;
	}

	//init_numfiles = (short) getc( InputLibInitFile );
	 fread( &temp, sizeof(short), 1, InputLibInitFile );
	init_numfiles = temp;

   // MALLOC ( LibHeaderList, file_header, init_numfiles );//Compile hack again -KRB
	  LibHeaderList=(file_header *)malloc(init_numfiles*sizeof(file_header));
	 if (! LibHeaderList) {
		fclose(InputLibInitFile);
	   return LI_NO_MEM;
	 }

	fread( LibHeaderList, sizeof( *LibHeaderList ), init_numfiles, InputLibInitFile );
	atexit(lib_close);

	lib_flag = 1;                   //everything is ok, so mark as open
	return LI_NO_ERROR;
}

void lib_close() {

	fclose( InputLibInitFile );
	 free (LibHeaderList);
	 lib_flag = 0;

}

void init_library( char *filename, int numfiles ) {

	lib_header Lib_Header;
	int i;
	ubyte nul;
	short temp;
	
	OutputLibFile = fopen( filename, "wb");
	strcpy( Lib_Header.id, "PSLB" );
	Lib_Header.nfiles = numfiles;

	for ( i=0; i<4 ; i++ ) putc( Lib_Header.id[i], OutputLibFile );
	 temp = Lib_Header.nfiles;
	//putc( Lib_Header.nfiles, OutputLibFile );
		temp = Lib_Header.nfiles;
	 fwrite( &temp, sizeof(short), 1, OutputLibFile );

	nul = 0;
	for ( i=0; i<numfiles; i++ ) fwrite( &nul, sizeof(nul), 32, OutputLibFile );

	fclose( OutputLibFile );

}

void write_file_header( char *filename, file_header Header ) {

	OutputLibFile = fopen( filename, "rb+" );

	fseek( OutputLibFile, 4+sizeof(short)+32*(file_count-1), SEEK_SET );
	fwrite( &Header, sizeof(file_header), 1, OutputLibFile );
	fclose( OutputLibFile );
}



int CheckFile( char *filename ) {
   int i;
   int handle;

   strupr( filename );

	handle = open( filename, O_RDONLY | O_BINARY );
	if (handle != -1)
		{
		close( handle );
		return 1;
		}

	close(handle);
	
   if (lib_flag == 1)
		for ( i=0; i < init_numfiles; i++ ) 
			if (!strcmp(LibHeaderList[i].name, filename))
				return 2;
		
	return 0;
	
}

FILE * LibraryGetFileInfo( char *filename, int * others_use, int * lib_offset, int * file_size, int * org_size, int * compressed, char * buffer ) {
	int i;
	FILE * lib_file;
	char signature[3];

	strupr( filename );

	lib_file = fopen( filename, "rb" );
	if (lib_file)   {
		if (buffer)
			setvbuf( lib_file, buffer, _IOFBF, 4096*2 );
		*file_size = filelength( fileno( lib_file ));
		fread( signature, 2, sizeof(char), lib_file );
		signature[2] = '\0';
		if (!strcmp( signature, "CF" )) {
			fread( org_size, 1, sizeof(int), lib_file );
			*lib_offset = 6L;       // Offset is CF+Length into file
			*compressed = 1;
		} else {
			*org_size = *file_size;
			*lib_offset = 0;
			fseek( lib_file, 0L, SEEK_SET );
			*compressed = 0;
		}
		*others_use = 0;
		return lib_file;
	}

	if (lib_flag == 1)  
		for ( i=0; i < init_numfiles; i++ ) {
		   if (!strcmp(LibHeaderList[i].name, filename)) {
					lib_file = InputLibInitFile;
					*lib_offset = LibHeaderList[i].offset;
					*org_size = LibHeaderList[i].original_size;
					*file_size = LibHeaderList[i].length;
					*compressed = (LibHeaderList[i].compression == LF_LZW );
					*others_use = 1;
					return lib_file;
			}
		 }

	lib_file = NULL;
	*others_use = 0;
	*lib_offset = 0;
	*org_size = 0;
	*file_size = 0;
	*compressed=0;
	return lib_file;

}

