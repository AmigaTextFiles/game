/***************************************************************************
     leveleditor.cpp  -  class for the new Leveleditor
                             -------------------
    copyright            : (C) 2005 by FluXy
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
#include "include/main.h"

cLevelEditor :: cLevelEditor( void )
{
	wMain.x = 0;
	wMain.y = 20;
	wMain.w = 150;
	wMain.h = 450;
	
	wItem.x = 0;
	wItem.y = screen->h - 120;
	wItem.w = screen->w;
	wItem.h = ( screen->h - wItem.y );
	
	wItem_Count = 0;
	wMenu_Count = 0;
	
	Item_pos = 0;
	
	wMain_open = wMain.w;
	wItem_open = screen->h - 5;
	
	wMain_timer = 2*DESIRED_FPS;
	wItem_timer = 0;

	Item_scoll = 0;

	Item_scroller[0].x = wItem.x + 5;
	Item_scroller[0].y = wItem.y + 30;
	Item_scroller[0].w = 5;
	Item_scroller[0].h = wItem.h - 40;

	Item_scroller[1] = Item_scroller[0];
	Item_scroller[1].x = wItem.x + wItem.w - 20;

	main_cur_posy = 0;

	arrow_left = NULL;
	arrow_right = NULL;
}

cLevelEditor :: ~cLevelEditor( void )
{
	Unload_Item_Menu();
	Unload_Main_Menu();

	arrow_left = NULL;
	arrow_right = NULL;
}

void cLevelEditor :: Load_Default_Menu( void )
{
	Unload_Main_Menu();

	Add_Main_Object( "Ground Basic", MENU_GROUND_GREEN_1, NULL, 50, 220, 90 );
	Add_Main_Object( "Yoshi Basic", MENU_YOSHI_WORLD, NULL, 0, 150, 50 );
	Add_Main_Object( "Ground Ghost", MENU_GROUND_GHOST_1, NULL, 190, 160, 100 );
	Add_Main_Object( "Green Hedge", MENU_HEDGES_GREEN, NULL, 120, 180, 10 );
	Add_Main_Object( "Box", MENU_BOX, NULL, 125, 30, 180 );
	Add_Main_Object( "Pipe", MENU_PIPES, NULL, 20, 80, 240 );
	Add_Main_Object( "Hill", MENU_HILLS, NULL, 130, 130, 220 );
	Add_Main_Object( "Sign", MENU_SIGNS, NULL, 100, 100, 180 );
	Add_Main_Object( "Block", MENU_BLOCKS, NULL, 145, 95, 12 );
	Add_Main_Object( "Cloud", MENU_CLOUDS, NULL, 170, 130, 220 );
	Add_Main_Object( "Extra", MENU_EXTRA, NULL, 20, 200, 120 );
	Add_Main_Object( "5", MENU_SPACER, NULL );
	Add_Main_Object( "Enemy", MENU_ENEMY, NULL, 250, 80, 40 );
	Add_Main_Object( "Special", MENU_SPECIAL, NULL, 220, 200, 10 );
	Add_Main_Object( "8", MENU_SPACER, NULL );
	Add_Main_Object( "Level settings", MENU_FUNCTION, &LE_Settings, 150, 150, 150 );
	Add_Main_Object( "New Level", MENU_FUNCTION, &LE_New, 50, 50, 230 );
	Add_Main_Object( "Load Level", MENU_FUNCTION, &LE_Load, 200, 200, 200 );
	Add_Main_Object( "Save Level", MENU_FUNCTION, &LE_Save, 0, 220, 0 );
	Add_Main_Object( "Clear Level", MENU_FUNCTION, &LE_Clear, 180, 40, 40 );
	Add_Main_Object( "9", MENU_SPACER, NULL );
	Add_Main_Object( "Exit Leveleditor", MENU_FUNCTION, &LE_Exit, 230, 180, 90 );
	Add_Main_Object( "Enter Overworld", MENU_FUNCTION, &LE_Enter_Overworld, 245, 230, 190 );
}

void cLevelEditor :: Unload_Main_Menu( void )
{
	main_cur_posy = 0;

	wMenu_Count = 0;

	if( wMenu_Objects.empty() ) 
	{
		return;
	}
	
	for( unsigned int i = 0; i < wMenu_Count; i++ )
	{
		Menu_Main_Object *Item = Get_Main_Object( i + 1 );

		if( !Item ) 
		{
			continue;
		}

		if( Item->def_img ) 
		{
			SDL_FreeSurface( Item->def_img );
			Item->def_img = NULL;
		}
		
		if( Item->hover_img )
		{
			SDL_FreeSurface( Item->hover_img );
			Item->hover_img = NULL;
		}

		if( Item->shadow_img )
		{
			SDL_FreeSurface( Item->shadow_img );
			Item->shadow_img = NULL;
		}
	}
	
	wMenu_Objects.clear();
}

void cLevelEditor :: Add_Main_Object( string name, unsigned int Item_Menu_link, void ( *nfunction )( void ), Uint8 def_Color_red /* = 0 */, 
									 Uint8 def_Color_green /* = 0 */, Uint8 def_Color_blue /* = 0  */)
{
	if( Item_Menu_link < 1 || Item_Menu_link > 20 && Item_Menu_link != MENU_FUNCTION && Item_Menu_link != MENU_SPACER )
	{
		printf( "Warning : Unknown Menu Link used : %d\n", Item_Menu_link );
		return;
	}
	
	Menu_Main_Object wMenu;
	
	wMenu.name = name;
	wMenu.Item_Menu_Id = Item_Menu_link;
	
	SDL_Color def_color;
	def_color.r = def_Color_red;		def_color.g = def_Color_green;		def_color.b = def_Color_blue;

	wMenu.color = def_color;

	if( Item_Menu_link != MENU_SPACER ) 
	{
		SDL_Color hover_color;
		
		if( wMenu.color.r + 40 <= 255 ) 
		{
			hover_color.r = wMenu.color.r + 40;
		}
		else
		{
			hover_color.r = 255;
		}
		
		if( wMenu.color.g + 40 <= 255 ) 
		{
			hover_color.g = wMenu.color.g + 40;
		}
		else
		{
			hover_color.g = 255;
		}
		
		if( wMenu.color.b + 40 <= 255 ) 
		{
			hover_color.b = wMenu.color.b + 40;
		}
		else
		{
			hover_color.b = 255;
		}
		
		// The description
		wMenu.def_img		= TTF_RenderText_Blended( font_16, name.c_str(), def_color );
		wMenu.hover_img		= TTF_RenderText_Blended( font_16, name.c_str(), hover_color );
		wMenu.shadow_img	= TTF_RenderText_Blended( font_16, name.c_str(), colorBlack );

		wMenu.cur_posy = main_cur_posy;
		main_cur_posy += wMenu.def_img->h + 5;
	}
	else
	{
		int yspace = atoi( name.c_str() );

		if( yspace < 0 || yspace > 20 ) 
		{
			return;
		}

		wMenu.def_img		= NULL;
		wMenu.hover_img		= NULL;
		wMenu.shadow_img	= NULL;
		
		wMenu.spacer_height = yspace;

		wMenu.cur_posy = main_cur_posy;
		main_cur_posy += wMenu.spacer_height;
	}

	
	wMenu_Count++;

	// The Id
	wMenu.CountId = wMenu_Count;

	// The Function
	wMenu.pfunction = nfunction;

	// The state
	wMenu.state = 0;
	
	wMenu_Objects.push_back( wMenu );

	Set_Main_Objects_Pos();
}

Menu_Main_Object *cLevelEditor :: Get_Main_Object( unsigned int nId )
{
	if( !wMenu_Objects.size() || !wMenu_Count ) 
	{
		return NULL;
	}

	for( unsigned int i = 0; i < wMenu_Objects.size(); i++ )
	{
		if( wMenu_Objects[i].CountId == nId )
		{
			return &wMenu_Objects[i];
		}
	}

	return NULL;
}

void cLevelEditor :: Set_Main_Objects_Pos( void )
{
	for( unsigned int i = 0; i < wMenu_Count; i++ )
	{
		Menu_Main_Object *Item = Get_Main_Object( i + 1 );
		
		if( !Item )
		{
			continue;
		}

		if( Item->Item_Menu_Id != MENU_SPACER ) 
		{
			// The Collision Rect
			Item->ColRect.w = Item->def_img->w;
			Item->ColRect.h = Item->def_img->h;
		}
		else
		{
			Item->ColRect.w = 0;
			Item->ColRect.h = 0;
		}

		if( wMain.w - 20 > 0 ) 
		{
			Item->ColRect.x = wMain.w - 130;
		}
		else
		{
			Item->ColRect.x = 0;
		}
		
		Item->ColRect.y = wMain.y + 8 + Item->cur_posy;

	}
}

void cLevelEditor :: Set_Main_Active( unsigned int object_id )
{
	for( unsigned int i = 0; i < wMenu_Count; i++ )
	{
		Menu_Main_Object *Item = Get_Main_Object( i + 1 );
		
		if( !Item )
		{
			continue;
		}

		if( Item->Item_Menu_Id != MENU_SPACER ) 
		{
			if( i == object_id ) 
			{
				Item->state = 2;
			}
			else
			{
				Item->state = 0;
			}
		}
	}
}

void cLevelEditor :: Load_Item_Menu( unsigned int menu_id )
{
	if( menu_id == MENU_FUNCTION || menu_id == MENU_SPACER ) 
	{
		return;
	}

	Unload_Item_Menu();
	
	cSprite *Sprite_type = NULL;

	if( menu_id == MENU_BOX ) 
	{
		Sprite_type = new cSpinBox( 0, 0 );
		Add_Item_Object( "game/box/yellow1_1.png", Sprite_type, "SpinBox" );

		Sprite_type = new cGoldBox( 0, 0 );
		Add_Item_Object( "game/box/yellow1_1.png", Sprite_type, "GoldBox" );

		Sprite_type = new cBonusBox( 0, 0, TYPE_BONUSBOX_MUSHROOM_FIRE );
		Add_Item_Object( "game/box/yellow3_1.png", Sprite_type, "Box M-F" );

		Sprite_type = new cBonusBox( 0, 0,TYPE_BONUSBOX_LIVE );
		Add_Item_Object( "game/box/yellow3_1.png", Sprite_type, "Box 1-UP" );

	}
	else if( menu_id == MENU_GROUND_GREEN_1 ) 
	{
		string path;

		path = "ground/green_1/ground/up.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Up" );

		path = "ground/green_1/ground/down.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Down" );
		
		path = "ground/green_1/ground/right.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Right" );

		path = "ground/green_1/ground/left.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Left" );

		path = "ground/green_1/ground/middle.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Middle" );

		path = "ground/green_1/ground/left_up.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Left up" );

		path = "ground/green_1/ground/right_up.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Right up" );

		path = "ground/green_1/ground/left_down.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Left Down" );

		path = "ground/green_1/ground/right_down.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Right Down" );

		path = "ground/green_1/ground/hill_left.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Hill Left" );

		path = "ground/green_1/ground/hill_right.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Hill Right" );

		path = "ground/green_1/ground/hill_left_up.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Hill Left up" );

		path = "ground/green_1/ground/hill_right_up.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Hill Right up" );
		
		path = "ground/green_1/kplant.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Jungle Plant" );

		path = "ground/green_1/plant_l.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant left" );

		path = "ground/green_1/plant_m.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant middle" );

		path = "ground/green_1/plant_r.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant right" );
	}
	else if( menu_id == MENU_YOSHI_WORLD ) 
	{
		string path;

		path = "ground/yoshi_1/hill_up_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Yoshi Hill up" );

		path = "ground/yoshi_1/rope_1_leftright.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Rope" );

		path = "ground/yoshi_1/extra_1_red.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant Red" );

		path = "ground/yoshi_1/extra_1_yellow.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant Yellow" );

		path = "ground/yoshi_1/extra_1_blue.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant Blue" );

		path = "ground/yoshi_1/extra_1_green.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Plant Green" );
	}
	else if( menu_id == MENU_GROUND_GHOST_1 )
	{
		string path;

		path = "ground/ghost_1/way_1_small.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Way small" );

		path = "ground/ghost_1/way_1_left.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Way left" );

		path = "ground/ghost_1/way_1_middle.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Way middle" );

		path = "ground/ghost_1/way_1_right.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Way right" );

		path = "ground/ghost_1/lamp_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Lamp" );

		path = "ground/ghost_1/window_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Window" );
	}
	else if( menu_id == MENU_HEDGES_GREEN ) 
	{
		string path;

		path = "ground/green_1/hedges/medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Hedge Med" );

		path = "ground/green_1/hedges/medium_2.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Hedge Med" );

		path = "ground/green_1/hedges/small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Hedge Sm" );

		path = "ground/green_1/hedges/small_2.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Hedge Sm" );

		path = "ground/green_1/hedges/big_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Hedge Big" );
		
		path = "ground/green_1/hedges/wild_medium.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Wild Hedge" );
	}
	else if( menu_id == MENU_PIPES ) 
	{
		string path;

		// The upward pipes
		path = "pipes/up/blue_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Blue Sm" );

		path = "pipes/up/blue_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Blue Med" );

		path = "pipes/up/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/up/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		
		path = "pipes/up/grey_big_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Big" );

		path = "pipes/up/grey_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Sm" );

		path = "pipes/up/yellow_big_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Big" );

		path = "pipes/up/yellow_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Med" );

		// The left pipes
		
		path = "pipes/left/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		path = "pipes/left/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/left/grey_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Sm" );

		// The right pipes
		path = "pipes/right/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		path = "pipes/right/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/right/grey_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Sm" );

		// The downward pipes
		
		path = "pipes/down/blue_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Blue Sm" );

		path = "pipes/down/blue_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Blue Med" );

		path = "pipes/down/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/down/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		
		path = "pipes/down/grey_big_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Big" );

		path = "pipes/down/grey_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Grey Sm" );

		path = "pipes/down/yellow_big_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Big" );

		path = "pipes/down/yellow_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Med" );

		// The leftright pipes

		path = "pipes/leftright/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/leftright/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		path = "pipes/leftright/yellow_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Med" );
		
		// The updown pipes

		path = "pipes/updown/green_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Med" );

		path = "pipes/updown/green_small_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Green Sm" );

		path = "pipes/updown/yellow_medium_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Yellow Med" );

	}
	else if( menu_id == MENU_HILLS ) 
	{
		string path;

		path = "hills/blue_1/1_big.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Blue Big" );

		path = "hills/blue_1/1_medium.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Blue Med" );

		path = "hills/light_blue_1/head.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "LBlue Head" );

		path = "hills/light_blue_1/middle.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "LBlue" );
	}
	else if( menu_id == MENU_BLOCKS ) 
	{
		string path;

		path = "game/box/brown1_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "default" );

		path = "blocks/stone/1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Add_Item_Object( path, Sprite_type, "Stone" );

		path = "blocks/wood/1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "Wood" );

		path = "game/box/white1_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Sprite_type->halfmassive = 1;
		Add_Item_Object( path, Sprite_type, "white" );
	}
	else if( menu_id == MENU_SIGNS ) 
	{
		string path;

		path = "signs/default_1/1_ending.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Ending" );

		path = "signs/default_1/1_ending_big.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Ending Big" );

		path = "signs/yoshi/post.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Yoshi Post" );
	}
	else if( menu_id == MENU_CLOUDS ) 
	{
		string path;

		path = "clouds/default_1/2_big.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Cloud Big" );

		path = "clouds/default_1/2_small.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 0;
		Add_Item_Object( path, Sprite_type, "Cloud Sm" );
	}
	else if( menu_id == MENU_EXTRA ) 
	{
		string path;

		path = "slider/grey_1/slider_1.png";
		Sprite_type = new cSprite( GetImage( path ), 0, 0 );
		Sprite_type->massive = 1;
		Add_Item_Object( path, Sprite_type, "Slider" );
	}
	else if( menu_id == MENU_ENEMY ) 
	{
		Sprite_type = new cGoomba( 0, 0, 0 ); // Brown
		Add_Item_Object( "Enemy/Goomba/brown/r.png", Sprite_type, "Goomba Brown" );

		Sprite_type = new cGoomba( 0, 0, 1 ); // Blue
		Add_Item_Object( "Enemy/Goomba/blue/r.png", Sprite_type, "Goomba Blue" );

		Sprite_type = new cTurtle( 0, 0, 1 ); // Red
		Add_Item_Object( "Enemy/Turtle/red/turtle_r1r.png", Sprite_type, "Turtle Red" );
		
		Sprite_type = new cjPiranha( 0, 0 );
		Add_Item_Object( "Enemy/jpiranha/c2.png", Sprite_type, "jPiranha" );

		Sprite_type = new cbanzai_bill( 0, 0, LEFT ); // left
		Add_Item_Object( "Enemy/Banzai_Bill/l.png", Sprite_type, "Banzai Bill" );

		Sprite_type = new cbanzai_bill( 0, 0, RIGHT ); // right
		Add_Item_Object( "Enemy/Banzai_Bill/r.png", Sprite_type, "Banzai Bill" );

		Sprite_type = new cRex( 0, 0 );
		Add_Item_Object( "Enemy/Rex/r1.png", Sprite_type, "Rex" );
	}
	else if( menu_id == MENU_SPECIAL ) 
	{
		Sprite_type = new cLevelExit( 0, 0 );
		Add_Item_Object( "game/level/door_yellow_1.png", Sprite_type, "Levelexit" );

		Sprite_type = new cCloud( 0, 0 );
		Add_Item_Object( "clouds/default_1/1_right.png", Sprite_type, "Moving Cloud" );

		Sprite_type = new cGoldPiece( 0, 0 );
		Add_Item_Object( "animation/goldpiece_1/3.png", Sprite_type, "Goldpiece" );

		Sprite_type = new cMoon( 0, 0 );
		Add_Item_Object( "game/items/moon_1.png", Sprite_type, "Moon" );

		Sprite_type = new cEnemyStopper( 0, 0 );
		Add_Item_Object( "game/leveleditor/special.png", Sprite_type, "Enemystopper" );
	}
	else
	{
		printf( "Unknown defualt Menu : %d\n", menu_id );
	}
	
	Set_Item_Objects_Pos();
	
	wItem_timer = ( DESIRED_FPS*5 );
}

void cLevelEditor :: Unload_Item_Menu( void )
{
	if( wItem_Objects.empty() ) 
	{
		return;
	}
	
	for( unsigned int i = 0; i < wItem_Count; i++ )
	{
		Menu_Item_Object *Item = Get_Item_Object( i + 1 );

		if( Item->preview_img ) 
		{
			SDL_FreeSurface( Item->preview_img );
			Item->preview_img = NULL;
		}
		
		if( Item->name_img )
		{
			SDL_FreeSurface( Item->name_img );
			Item->name_img = NULL;
		}
		
		if( Item->name_img_shadow )
		{
			SDL_FreeSurface( Item->name_img_shadow );
			Item->name_img_shadow = NULL;
		}
		
		if( Item->size_img )
		{
			SDL_FreeSurface( Item->size_img );
			Item->size_img = NULL;
		}
		
		if( Item->size_img_shadow )
		{
			SDL_FreeSurface( Item->size_img_shadow );
			Item->size_img_shadow = NULL;
		}

		if( Item->Sprite_type )
		{
			delete Item->Sprite_type;
			Item->Sprite_type = NULL;
		}
	}
	
	wItem_Objects.clear();
	
	wItem_Count = 0;

	Item_scoll = 0;
}

void cLevelEditor :: Draw( SDL_Surface *target )
{
	if( cameraposy > 0 && cameraposy < screen->h ) 
	{
		int start_x = 0;

		if( cameraposx < 0 ) 
		{
			start_x = -cameraposx;
		}

		lineRGBA( screen, start_x, screen->h - cameraposy, screen->w, screen->h - cameraposy, 0, 0, 100, 255 );
	}

	if( cameraposx < 0 && cameraposx > -screen->w ) 
	{
		int start_y = screen->h;

		if( cameraposy < screen->h ) 
		{
			start_y = screen->h - cameraposy;
		}

		lineRGBA( screen, 0 - cameraposx, start_y , 0 - cameraposx, 0 , 0, 100, 0, 255 );
	}


	// The Main Window Animation
	if( wMain_timer <= 0 ) 
	{
		if( (int)wMain_open > 10 ) 
		{
			wMain_open -= Framerate.speedfactor*8;

			if( wMain_open < 10 ) 
			{
				wMain_open = 10;
			}

			wMain.w = (int)wMain_open;

			Set_Main_Objects_Pos();
		}
	}
	else
	{
		wMain_timer -= Framerate.speedfactor;

		if( (int)wMain_open < 150 ) 
		{
			wMain_open += Framerate.speedfactor*8;

			if( wMain_open > 150 ) 
			{
				wMain_open = 150;
			}

			wMain.w = (int)wMain_open;

			Set_Main_Objects_Pos();
		}
	}

	// The Item Window Animation
	if( wItem_timer <= 0 ) 
	{
		if( (int)wItem_open > 10 ) 
		{
			wItem_open += Framerate.speedfactor*8;

			if( wItem_open > screen->h - 10 ) 
			{
				wItem_open = screen->h - 10;
			}

			wItem.y = (int)wItem_open;

			Set_Item_Objects_Pos();
		}
	}
	else
	{
		wItem_timer -= Framerate.speedfactor;

		if( (int)wItem_open > screen->h - wItem.h ) 
		{
			wItem_open -= Framerate.speedfactor*8;

			if( wItem_open < (double)( screen->h - wItem.h ) ) 
			{
				wItem_open = (double)( screen->h - wItem.h );
			}

			wItem.y = (int)wItem_open;
			
			Set_Item_Objects_Pos();
		}
	}

	// Main Window Box
	boxRGBA( target, wMain.x, wMain.y, wMain.x + wMain.w, wMain.y + wMain.h, 40, 100, 50, 255 );
	boxRGBA( target, wMain.x, wMain.y, wMain.x + 10, wMain.y + wMain.h, 0, 0, 130, 255 );
	
	if( wItem_Count ) 
	{
		// Item Window Box
		boxRGBA( target, wItem.x, wItem.y, wItem.x + wItem.w, wItem.y + wItem.h, 0, 0, 0, 255 );
		boxRGBA( target, wItem.x, wItem.y, wItem.x + wItem.w, wItem.y + 10, 130, 0, 0, 255 );
	}

	unsigned int i;

	for( i = 0; i < wItem_Count; i++ )
	{
		Menu_Item_Object *Item = Get_Item_Object( i + 1 );

		if( !Item )
		{
			continue;
		}

		if( Item->ColRect.x > wItem.x + wItem.w - 27 - Item->ColRect.w || Item->ColRect.x < wItem.x + 20 ) // limits
		{
			Item->visible = 0;
			continue;
		}
		else
		{
			Item->visible = 1;
		}
		
		boxRGBA( target, Item->ColRect.x, Item->ColRect.y, Item->ColRect.x + Item->ColRect.w, Item->ColRect.y + Item->ColRect.h, 0, 0, 0, 255 );

		// The Preview Image
		SDL_Rect r;
		r.x = Item->ColRect.x + 5;
		r.y = Item->ColRect.y + 5;
		r.w = Item->preview_img->w;
		r.h = Item->preview_img->h;

		SDL_BlitSurface( Item->preview_img, NULL, target, &r );


		// The Image Name
		r.y = Item->ColRect.y - 15;
		
		SDL_BlitSurface( Item->name_img_shadow, NULL, target, &r );

		r.x -= 2;
		r.y -= 2;

		SDL_BlitSurface( Item->name_img, NULL, target, &r );

		// The image dimensions
		r.y = Item->ColRect.y + Item->ColRect.h + 4;
		
		SDL_BlitSurface( Item->size_img_shadow, NULL, target, &r );

		r.x -= 2;
		r.y -= 2;

		SDL_BlitSurface( Item->size_img, NULL, target, &r );
	}

	if( wItem.y == screen->h - wItem.h )
	{
		if( arrow_left ) 
		{
			SDL_BlitSurface( arrow_left, NULL, target, &Item_scroller[0] );
		}

		if( arrow_right ) 
		{
			SDL_BlitSurface( arrow_right, NULL, target, &Item_scroller[1] );
		}
	}

	for( i = 0; i < wMenu_Count; i++ )
	{
		Menu_Main_Object *Item = Get_Main_Object( i + 1 );
		
		if( !Item || Item->ColRect.x == 0 )
		{
			continue;
		}

		if( Item->Item_Menu_Id != MENU_SPACER ) 
		{
			//boxRGBA( target, wMain.x + 15, Item->ColRect.y - 2, wMain.x + wMain.w - 7, Item->ColRect.y + Item->ColRect.h, 200, 200, 250, 255 );
			
			// The Shadow
			SDL_Rect r;
			r.x = Item->ColRect.x + 1;
			r.y = Item->ColRect.y + 1;
			r.w = Item->ColRect.w;
			r.h = Item->ColRect.h;

			SDL_BlitSurface( Item->shadow_img, NULL, target, &r ); // shadow

			if( Item->state == 1 )	// Hovered
			{
				SDL_BlitSurface( Item->hover_img, NULL, target, &Item->ColRect );
			}
			else // default
			{
				SDL_BlitSurface( Item->def_img, NULL, target, &Item->ColRect );
			}

			if( Item->state == 2 )	// Active
			{
				boxRGBA( target, wMain.w - 13, Item->ColRect.y, wMain.w - 8, Item->ColRect.y + Item->ColRect.h - 1, 0, 200, 0, 255 );
			}			
		}
		else
		{
			boxRGBA( target, wMain.x + 15, wMain.y + 5 + Item->cur_posy + Item->spacer_height/2, wMain.x + wMain.w - 5, wMain.y + 5 + Item->cur_posy + Item->spacer_height/2, 200, 200, 200, 255 );
		}
	}
}

void cLevelEditor :: Add_Item_Object( string path, cSprite *nSprite_type, string nName /* = "" */ )
{
	string full_path = path;

	full_path.insert( 0, "/" );
	full_path.insert( 0, PIXMAPS_DIR );

	ifstream ifs( full_path.c_str(), ios::in );

	if( !ifs ) 
	{
		printf( "Invalid Menu Item path : %s\n", full_path.c_str() );
		return;
	}

	ifs.close();

	if( !arrow_left ) 
	{
		arrow_left = GetImage( "game/leveleditor/arrow_left.png" );
	}

	if( !arrow_right ) 
	{
		arrow_right = GetImage( "game/leveleditor/arrow_right.png" );
	}

	Menu_Item_Object mItem;

	SDL_Surface *temp = LoadImage( full_path.c_str() );

	int img_w = 0;
	int img_h = 0;

	if( temp ) 
	{
		img_w = temp->w;
		img_h = temp->h;

		if( temp->h <= 50 && temp->w <= 50 )
		{
			mItem.preview_img = temp;
		}
		else	// Zoom the image
		{
			double zoom = 50.0 / (double)temp->w;

			if( 50.0 / (double)temp->h < zoom )
			{
				zoom = 50.0 / (double)temp->h;
			}

			mItem.preview_img = zoomSurface( temp, zoom, zoom, 0 );

			SDL_SetColorKey( mItem.preview_img, SDL_SRCCOLORKEY | SDL_RLEACCEL | SDL_SRCALPHA, temp->format->colorkey );

			SDL_FreeSurface( temp );
		}
	}
	else
	{
		printf( "Could not open Menu Item Image : %s\n", full_path.c_str() );
		return;
	}

	mItem.path = full_path;

	if( nName.length() > 1 )
	{
		mItem.name = nName;
	}
	else
	{
		full_path.erase( 0, full_path.rfind( "/" ) + 1 ); // Remove the path
		full_path.erase( full_path.length() - 4, full_path.length() ); // Remove the image extension

		mItem.name = full_path;
	}

	// The description
	mItem.name_img = TTF_RenderText_Blended( font_16, mItem.name.c_str(), colorWhite );
	mItem.name_img_shadow = TTF_RenderText_Blended( font_16, mItem.name.c_str(), colorBlack );

	// The Image Size text
	char size_text[10];
	sprintf( size_text, "%dx%d", img_w, img_h );

	mItem.size_img = TTF_RenderText_Blended( font_16, size_text, colorWhite );
	mItem.size_img_shadow = TTF_RenderText_Blended( font_16, size_text, colorBlack );

	mItem.Sprite_type = nSprite_type;

	mItem.visible = 0;

	wItem_Count++;
	
	// The Id
	mItem.CountId = wItem_Count;

	wItem_Objects.push_back( mItem );

	Set_Item_Objects_Pos();
}

Menu_Item_Object *cLevelEditor :: Get_Item_Object( unsigned int nId )
{
	if( !wItem_Objects.size() || !wItem_Count ) 
	{
		return NULL;
	}

	for( unsigned int i = 0; i < wItem_Objects.size(); i++ )
	{
		if( wItem_Objects[i].CountId == nId )
		{
			return &wItem_Objects[i];
		}
	}

	return NULL;
}

void cLevelEditor :: Set_Item_Objects_Pos( void )
{
	for( unsigned int i = 0; i < wItem_Count; i++ )
	{
		Menu_Item_Object *Item = Get_Item_Object( i + 1 );
		
		if( Item )	
		{
			// The Collision Rect
			Item->ColRect.w = 60;
			Item->ColRect.h = 60;
			Item->ColRect.x = wItem.x + (int)Item_scoll + 30 + ( ( Item->ColRect.w + 20 ) * ( i ) );
			Item->ColRect.y = wItem.y + 30;
		}
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

void LE_Settings( void )
{
	DeleteAllDialogObjects();
	
	bool menu = 1;

	cSprite *text_music				= new cSprite( TTF_RenderText_Shaded( font, "Music", colorBlack, colorWhite ), 50, 60 );
	cSprite *text_background_colors = new cSprite( TTF_RenderText_Shaded( font, "Background Colors", colorBlack, colorWhite ), 50, 150 );
	cSprite *text_level_name		= new cSprite( TTF_RenderText_Shaded( font, "Level name", colorBlack, colorWhite ), 50, 230 );
	cSprite *text_back				= new cSprite( TTF_RenderText_Shaded( font, "Back", colorBlack, colorWhite ), screen->w - 100, screen->h - 50 );
	
	// ### The Dialogs

	// ## Music
	string Music_file;
	Music_file.reserve( 120 );
	Music_file = pLevel->Musicfile;
	Music_file.erase( 0, strlen( MUSIC_DIR ) + 1 );
	
	AddDialog( 250, 100, "Level Music", Music_file, DIALOG_ALL, 80, 300 );

	// ## Background Color
	char color[4];
	
	Uint8 Back_red;
	Uint8 Back_green;
	Uint8 Back_blue;

	SDL_GetRGB( pLevel->background_color, screen->format, &Back_red, &Back_green, &Back_blue );

	sprintf( color, "%d", Back_red );
	AddDialog( 250, 190, "Level Background Red", color, DIALOG_ONLY_NUMBERS, 255, 50 );
	sprintf( color, "%d", Back_green );
	AddDialog( 330, 190, "Level Background Green", color, DIALOG_ONLY_NUMBERS, 255, 50 );
	sprintf( color, "%d", Back_blue );
	AddDialog( 410, 190, "Level Background Blue", color, DIALOG_ONLY_NUMBERS, 255, 50 );

	// ## the Level name
	string Level_name;
	Level_name.reserve( 120 );
	Level_name = pLevel->Levelfile;
	Level_name.erase( 0, strlen( LEVEL_DIR ) + 1 );

	AddDialog( 250, 270, "Level name", Level_name, DIALOG_ALL, 80, 300 );

	// ## gets the the Dialog id's
	int id_red = Get_Dialog( "Level Background Red" );
	int id_green = Get_Dialog( "Level Background Green" );
	int id_blue = Get_Dialog( "Level Background Blue" );
	int id_music = Get_Dialog( "Level Music" );
	int id_level_name = Get_Dialog( "Level name" );

		// ### The Dialogs ###
	signed int cameraposx_old = cameraposx;
	signed int cameraposy_old = cameraposy;

	cameraposx = 0;
	cameraposy = 0;

	while( menu )
	{
		SDL_FillRect( screen, NULL, white );

		pMouseCursor->Update_Position();

		text_music->Draw( screen );
		text_background_colors->Draw( screen );
		text_level_name->Draw( screen );

		if( DialogObjects[id_red]->gotChanged() )
		{
			Back_red = DialogObjects[id_red]->Get_Value_int();
		}

		if( DialogObjects[id_green]->gotChanged() )
		{
			Back_green = DialogObjects[id_green]->Get_Value_int();
		}

		if( DialogObjects[id_blue]->gotChanged() )
		{
			Back_blue = DialogObjects[id_blue]->Get_Value_int();
		}

		boxRGBA( screen, 490, 190, 520, 220, Back_red, Back_green, Back_blue, 255 );

		stringRGBA( screen, 228, 190, "R:", Back_red, 0, 0, 255 );
		stringRGBA( screen, 308, 190, "G:", 0, Back_green, 0, 255 );
		stringRGBA( screen, 388, 190, "B:", 0, 0, Back_blue, 255 );

		if( !pMouseCursor->CollsionCheck( pMouseCursor->posx, pMouseCursor->posy ) )
		{
			if( pMouseCursor->iCollisionType == 10 ) // A Dialog Box
			{
				if( DialogCount >= pMouseCursor->iCollisionNumber && pMouseCursor->iCollisionNumber >= 0 )
				{
					if( pMouseCursor->MousePressed_left ) 
					{
						DialogObjects[pMouseCursor->iCollisionNumber]->Get_Focus();
						pMouseCursor->MousePressed_left = 0;
					}
				}
			}
			else if( RectIntersect( &pMouseCursor->rect, &text_back->rect ) ) 
			{
				boxRGBA( screen, text_back->rect.x - 2, text_back->rect.y - 2, text_back->rect.x + text_back->rect.w + 2, text_back->rect.y + text_back->rect.h + 2, 230, 150, 50, 200 );
			}
			else
			{
				if( !pMouseCursor->MousePressed_left && pMouseCursor->iCollisionType == 0 )
				{
					pMouseCursor->mouse_W = 0;
					pMouseCursor->mouse_H = 0;
				}
				
				pMouseCursor->iCollisionType = 0;
				pMouseCursor->iCollisionNumber = 0;
			}
		}


		text_back->Draw( screen );
		
		UpdateDialogs();
		pMouseCursor->Update();

		SDL_Flip( screen );
		
		while( SDL_PollEvent( &event ) )
		{
			switch( event.type )
			{
				case SDL_QUIT:
				{
					done = 1;
					menu = 0;
					break;
				}
				case SDL_MOUSEBUTTONDOWN:
				{
					if( event.button.button == 1 ) // left
					{
						pMouseCursor->MousePressed_left = 1;

						if( RectIntersect( &pMouseCursor->rect, &text_back->rect ) ) 
						{
							menu = 0;
						}
					}
					else if( event.button.button == 3 ) // right
					{
						pMouseCursor->MousePressed_right = 1;
					}

					break;
				}
				case SDL_MOUSEBUTTONUP:
				{
					if( event.button.button == 1 )
					{
						pMouseCursor->MousePressed_left = 0;
					}
					else if( event.button.button == 2 )
					{
						pMouseCursor->fastCopyMode = 0;
					}
					else if( event.button.button == 3 )
					{
						pMouseCursor->MousePressed_right = 0;
					}

					break;
				}
				case SDL_KEYDOWN:
				{
					if( KeyPressed( KEY_ESC ) ) 
					{
						menu = 0;
					}
					break;
				}
				default:
				{
					break;
				}
			}
		}

	}

	SDL_FreeSurface( text_back->image );
	text_back->image = NULL;
	SDL_FreeSurface( text_music->image );
	text_music->image = NULL;
	SDL_FreeSurface( text_background_colors->image );
	text_background_colors->image = NULL;
	SDL_FreeSurface( text_level_name->image );
	text_level_name->image = NULL;

	delete text_back;
	text_back = NULL;
	delete text_music;
	text_music = NULL;
	delete text_background_colors;
	text_background_colors = NULL;
	delete text_level_name;
	text_level_name = NULL;

	pLevel->Set_BackgroundColor( Back_red, Back_green, Back_blue );
	pLevel->Set_Musicfile( DialogObjects[id_music]->Get_Value_string() );

	if( DialogObjects[id_level_name]->gotChanged() ) 
	{
		if( Level_name.compare( DialogObjects[id_level_name]->Get_Value_string() ) != 0 ) 
		{
			pLevel->Set_Levelfile( DialogObjects[id_level_name]->Get_Value_string() );
		}

		debugdisplay->counter = 0; // no level saved info
	}

	cameraposx = cameraposx_old;
	cameraposy = cameraposy_old;

	DeleteAllDialogObjects();
}

void LE_New( void )
{
	boxRGBA( screen, 0, 0, screen->w, screen->h , 0, 0, 0, 64 );

	string levelname = EditMessageBox( "Create a new Level", "Levelname", screen->w/2 - 100, screen->h/2 - 10, 1 );

	if( levelname.length() < 2) 
	{
		return;
	}

	if( levelname.find( ".txt" ) == string::npos ) 
	{
		levelname.insert( levelname.length(), ".txt" );
	}

	if( levelname.find( "levels/" ) == string::npos ) 
	{
		levelname.insert( 0, "levels/" );
	}

	if( pLevel->New( levelname ) )
	{
		sprintf( debugdisplay->text, "Created %s", levelname.c_str() );
		debugdisplay->counter = DESIRED_FPS*2;
	}
	else
	{
		sprintf( debugdisplay->text, "Level already exist %s", levelname.c_str() );
		debugdisplay->counter = DESIRED_FPS*2;
	}
}

void LE_Load( void )
{
	KeyDown( SDLK_l );
}

void LE_Save( void )
{
	pLevel->Save();
}

void LE_Clear( void )
{
	string Levelfile_old = pLevel->Levelfile;
	pLevel->Unload();
	pLevel->Levelfile = Levelfile_old;
}

void LE_Exit( void )
{
	KeyDown( SDLK_F8 );
}

void LE_Enter_Overworld( void )
{
	pOverWorld->Enter();
}
