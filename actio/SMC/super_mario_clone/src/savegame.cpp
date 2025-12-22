/***************************************************************************
           Savegame.cpp  -  Savegame Engine
                             -------------------
    copyright            : (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#include "include/globals.h"


Savegame Loaded_Save_info; // for Savegame loading

Savegame Savegame_Load( unsigned int Save_file )
{
	sprintf( Loaded_Save_info.Levelname, "lvl_1.txt" );
	Loaded_Save_info.Description = "No Description";

	Loaded_Save_info.Version = 0;
	Loaded_Save_info.Lives = 0;
	Loaded_Save_info.Points = 0;
	Loaded_Save_info.Goldpieces = 0;
	Loaded_Save_info.Pos_x = 0;
	Loaded_Save_info.Pos_y = 0;
	Loaded_Save_info.State = 0;
	Loaded_Save_info.OWsave = 0;
	Loaded_Save_info.OWNlevel = 0;
	Loaded_Save_info.OWSlevel = 0;
	Loaded_Save_info.OWCurr_WP = 0;
	Loaded_Save_info.OverWorld = 0;
	Loaded_Save_info.Itembox_item = 0;
	
	char Full_Save_Name[40];
	sprintf( Full_Save_Name,"%s/%d.sav", SAVE_DIR, Save_file );

	ifstream ifs( Full_Save_Name, ios::in );

	if( !ifs )
	{
		printf( "Savegame_Load : No Savegame found at Slot : %s \n", Full_Save_Name );
		return Loaded_Save_info;
	}

	char *contents = new char[1000];

	for( int i = 0; ifs.getline( contents, 1000 ); i++ )
	{
		if( GetSave( contents, i ) != 1 )
		{
			printf( "Savegame Error at Slot : %d\n", Save_file );
			Loaded_Save_info.Description = "broken Savegame file";
		}
	}

	ifs.close();
	delete( contents );

	return Loaded_Save_info;
}

int Savegame_Save( unsigned int Save_file, Savegame Save_info )
{
	char Full_Save_Name[45];
	sprintf( Full_Save_Name, "%s/%d.sav", SAVE_DIR, Save_file );

	ifstream ifs( Full_Save_Name, ios::in );

	if( ifs )
	{
		ifs.close();
		ifs.open( Full_Save_Name, ios::trunc ); // Delete existing
	}
	
	ifs.close();
	
	// Finds all the " " in Save_info.Description and replaces them with "_"
	int pos = -1;
	
	while( Save_info.Description.find( " " ) >= 0 )
	{
		pos = Save_info.Description.find( " " );
		
		if( pos >= 0 )
		{
			Save_info.Description.replace( pos, 1, "_" );
		}
		else
		{
			break;
		}
	}

	ofstream ofs( Full_Save_Name, ios::out );

	char *row = new char[220];

	sprintf( row, "## Savegame File at Slot %d with Savegame V.%s ,Game V.%s ##\n\n", Save_file, SAVEGAME_VERSION, VERSION );
	ofs.write( row, strlen(row) );

	sprintf( row, "Save_Time_Stamp %s", Save_info.Time_Stamp ); // in .Time_Stamp is a \n
	ofs.write( row, strlen(row) );

	sprintf( row, "Save_Description %s\n", Save_info.Description.c_str() );
	ofs.write( row, strlen(row) );

	sprintf( row, "Save_Version %d\n", Save_info.Version );
	ofs.write( row, strlen(row) );

	sprintf( row, "Level_name %s\n", Save_info.Levelname );
	ofs.write( row, strlen(row) );

	sprintf( row, "Lives %d\n", Save_info.Lives );
	ofs.write( row, strlen(row) );

	sprintf( row, "Points %d\n", Save_info.Points );
	ofs.write( row, strlen(row) );

	sprintf( row, "Goldpieces %d\n", Save_info.Goldpieces );
	ofs.write( row, strlen(row) );
	
	sprintf( row, "Position %d %d\n", Save_info.Pos_x,Save_info.Pos_y );
	ofs.write( row, strlen(row) );

	sprintf( row, "State %d\n", Save_info.State );
	ofs.write( row, strlen(row) );

	sprintf( row, "Itembox_Item %d\n", Save_info.Itembox_item );
	ofs.write( row, strlen(row) );

	// Overworld info
	sprintf( row, "\n## OverWorld Data ##\n\n" );
	ofs.write( row, strlen(row) );

	sprintf( row, "OWsave %d\n", Save_info.OWsave );
	ofs.write( row, strlen(row) );

	sprintf( row, "OWNlevel %d\n", Save_info.OWNlevel );
	ofs.write( row, strlen(row) );

	sprintf( row, "OWSlevel %d\n", Save_info.OWSlevel );
	ofs.write( row, strlen(row) );

	sprintf( row, "OWCurr_WP %d\n", Save_info.OWCurr_WP );
	ofs.write( row, strlen(row) );

	sprintf( row, "OverWorld %d\n", Save_info.OverWorld );
	ofs.write( row, strlen(row) );

	ofs.close();

	printf( "Saved to : %s\n", Full_Save_Name );
	
	return 1;
}

const char *Savegame_GetDescription( unsigned int Save_file, bool Only_Description )
{
	string Full_Save_Name;
	char buffer[10];

	char *ret = new char[80];

	Full_Save_Name = SAVE_DIR "/.sav";
	
	sprintf( buffer, "%d", Save_file );

	Full_Save_Name.insert( strlen( SAVE_DIR ) + 1, buffer );

	if( !valid_file( Full_Save_Name ) )
	{
		sprintf( ret, "%d. %s",Save_file, "No Save file" );
		return ret;
	}
	
	Savegame Temp_Savegame = Savegame_Load( Save_file );

	if( Temp_Savegame.Lives < 0 )
	{
		sprintf( ret, "%d. %s", Save_file, "broken Save file" );
		return ret;
	}

	// Finds all the "_" in Temp_Savegame.Description and replaces them with " "
	int pos = -1;
	
	while( Temp_Savegame.Description.find( "_" ) >= 0 )
	{
		pos = Temp_Savegame.Description.find( "_" );

		if ( pos >= 0 )
		{
			Temp_Savegame.Description.replace( pos, 1, " " );
		}
		else
		{
			break;
		}
	}

	if( !Only_Description ) // Full Description
	{
		sprintf( ret, "%d. %s      Level : %s  Date : %s", Save_file, Temp_Savegame.Description.c_str(),
			Temp_Savegame.Levelname, Temp_Savegame.Time_Stamp );
	}
	else // Only the User Description
	{
		sprintf( ret, " %s", Temp_Savegame.Description.c_str() );
	}

	return ret;
}

bool Savegame_valid( unsigned int Save_file )
{
	char savename[30];

	sprintf( savename, "%s/%d.sav", SAVE_DIR, Save_file );

	return valid_file( savename );
}

bool GetSave( char *command, unsigned int line )
{
	bool was_error = 0;
	
	if( strlen( command ) <= 5 || *command == '#')
	{
		return 1;
	}
	
	char* str = command;
	int count = 0;
	int i = 0;
	
	str += strspn( str, " " );
	
	while( *str )
	{
		count++;
		str += strcspn( str, " " );
		str += strspn( str, " " );
	}
	
	str = command; // reset
	
	char** parts = new char*[ count ];
	
	str += strspn( str, " " );
	
	while( *str )
	{
		int len = strcspn( str, " " );
		parts[i] = (char*)malloc( len+1 );
		memcpy(parts[i],str,len);
		parts[i][len] = 0;
		str += len + strspn( str + len, " " );
		i++; 
	}

/***************************************************************************/

	if( strcspn( parts[0], "#" ) == 0 )
	{
		return 1;
	}
	else if ( strcmp( parts[0], "Level_name") == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Level_Name needs 2 parameters" << "\n";
			was_error = 1;
		}
		
		char *filename = new char[60];
		sprintf( filename, "%s/%s", LEVEL_DIR, parts[1] );

		FILE* fp = fopen( filename, "r" );

		if( !fp )
		{
			cout << "line " << line << " error! " << "Savegame : Level not found : " << filename  << "\n";
			was_error = 1;
		}
		
		delete( filename );
		strcpy( Loaded_Save_info.Levelname, parts[1] );

	}
	else if( strcmp( parts[0], "Lifes" ) == 0 || strcmp( parts[0], "Lives" ) == 0  ) // Lifes for older savegame support
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Lives needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) || atoi( parts[1] ) < 0 )
		{
			cout << "line " << line << " error! " << "Savegame : Lives < 0 or not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Lives = atoi( parts[1] );

	}
	else if( strcmp( parts[0], "Position" ) == 0 )
	{
		if( count != 3 )
		{
			cout << "line " << line << " error! " << "Savegame : Position needs 3 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number(parts[1]) )
		{
			cout << "line " << line << " error! " << "Savegame : X Position not a number" << "\n";
			was_error = 1;
		}
		
		if( !is_valid_number(parts[2]) )
		{
			cout << "line " << line << " error! " << "Savegame : Y Position not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Pos_x = atoi( parts[1] ); // x position first
		Loaded_Save_info.Pos_y = atoi( parts[2] );
	}
	else if( strcmp( parts[0], "Points" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Points needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : Points not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Points = atoi( parts[1] );
	}
	else if( strcmp( parts[0], "Goldpieces" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Goldpieces needs 2 parameters" << "\n";
			was_error = 1;
		}
		
		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : Goldpieces not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Goldpieces = atoi( parts[1] );
	}
	else if( strcmp( parts[0], "State" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : State needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : State not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.State = atoi( parts[1] );
	}
	else if( strcmp( parts[0], "Itembox_Item" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Itembox_item needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : Itembox_item not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Itembox_item = atoi( parts[1] );
	}
	else if( strcmp( parts[0], "Save_Description" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Save_Description needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( Loaded_Save_info.Description.compare( "broken Savegame file" ) != 0 )
		{
			Loaded_Save_info.Description = parts[1];
		}

	}
	else if( strcmp( parts[0], "Save_Version" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : Save_Version needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number(parts[1]) )
		{
			cout << "line " << line << " error! " << "Savegame : Save_Version not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.Version = atoi( parts[1] );
	}
	else if ( strcmp( parts[0], "Save_Time_Stamp") == 0 )
	{
		if( count != 6 )
		{
			cout << "line " << line << " error! " << "Savegame : Save_Time_Stamp needs 6 parameters" << "\n";
			was_error = 1;
		}

		char Date[40];
		/*
		parts[1] = Day (Mon,Tue,Wed,Thu,Fri,...)
		parts[2] = Month
		parts[3] = Day (1,2,3,4,...)
		parts[4] = Day Time (22:52:30)
		parts[5] = Year
		*/
		sprintf( Date, "%s %s.%s %s", parts[4], parts[3], parts[2], parts[5] );

		strcpy( Loaded_Save_info.Time_Stamp, Date );
	}
	else if( strcmp( parts[0], "OWsave" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : OWsave needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : OWsave not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.OWsave = atoi( parts[1] );
	}
	else if ( strcmp( parts[0], "OWNlevel") == 0 ) // Overworld Normal Level
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : OWNlevel needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : OWNlevel not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.OWNlevel = atoi( parts[1] );
	}
	else if( strcmp( parts[0], "OWSlevel") == 0 ) // Overworld Secret Level
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : OWSlevel needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : OWSlevel not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.OWSlevel = atoi( parts[1] );
	}
	else if ( strcmp( parts[0], "OWCurr_WP" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : OWCurr_WP needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : OWCurr_WP not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.OWCurr_WP = atoi( parts[1] );
	}
	else if ( strcmp( parts[0], "OverWorld" ) == 0 )
	{
		if( count != 2 )
		{
			cout << "line " << line << " error! " << "Savegame : OverWorld needs 2 parameters" << "\n";
			was_error = 1;
		}

		if( !is_valid_number( parts[1] ) )
		{
			cout << "line " << line << " error! " << "Savegame : OverWorld not a number" << "\n";
			was_error = 1;
		}

		Loaded_Save_info.OverWorld = atoi( parts[1] );
	}
	else
	{
		cout << "line " << line << " warning : " << "unknown entry : " << parts[0] << "\n";
	}

	for( i = 0; i < count ; i++ )
	{
		delete( parts[i] );
	}

	delete []parts;
	
	if( was_error == 0 )
	{
		return 1;
	}
	else
	{
		return 0;
	}

}

void Savegame_Debug_Print( Savegame TSavegame )
{
	printf( "\nSavegame Debug Print : \n\nLevel_Name %s\nLifes : %d\nPos x : %d\nPos y : %d\nPoints : %d\nGoldpieces : %d\nState : %d\nOverWorld Save : %d\nOverWorld Normal Level : %d\nOverWorld Secret Level : %d\nOverWorld : %d\n",
		TSavegame.Levelname, TSavegame.Lives, TSavegame.Pos_x,TSavegame.Pos_y, TSavegame.Points, TSavegame.Goldpieces, TSavegame.State, TSavegame.OWsave, TSavegame.OWNlevel, TSavegame.OWSlevel, TSavegame.OverWorld );
}
