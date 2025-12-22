#include "main.h"
#include "scene.h"
#include "font.h"
#include "sound.h"
#include "cursor.h"
#include "menu.h"
#include "sky.h"

#undef main

#ifdef __MORPHOS__
const char *version_tag = "$VER: BeastieWorker 0.4 (20.10.2007)";
#endif

const int _PIXEL_BIT_= 24;

#define _LIMIT_ANGLE_X_MAX_ - 70.0f
#define _LIMIT_ANGLE_X_MIN_    0.0f
#define _LIMIT_ZOOM_MAX_    - 70.0f  
#define _LIMIT_ZOOM_MIN_    -170.0f

#define _MENU_FIRST_ 0
#define _MENU_ABOUT_ 1
#define _MENU_GAME_  2
#define _MENU_WIN_   3

char *const_file_level_index= "levels/index";
char *const_path_model=       "model/";
char *const_file_font=        "textures/font.bmp";
char *const_path_cursor=      "textures/";
char *const_file_menu_skin=   "textures/skin.bmp";
char *const_file_menu_image=  "textures/beasty.bmp";
char *const_file_sound_level= "sounds/level.wav";
char *const_file_sound_push=  "sounds/puch.wav";
char *const_file_sound_step=  "sounds/step.wav";
char *const_file_cloud=       "textures/cloud.bmp";
char *const_file_mist=        "textures/mist.bmp";

bool bFullScreen= false;

unsigned windowSizeX= 800;
unsigned windowSizeY= 600;

enum enum_lang
{
   EN,
   RU
}  eLang;

GLfloat angleX= -30.0f, angleY= 45.0f;
GLfloat zoom= -120.0f;

int level= 1;
int steps= 0;
unsigned gameTime= 0;
class_scene *scene;
class_font *font;
class_cursor *cursor;
class_sky *sky;

typedef class_menu *type_menu[4];

struct struct_menu
{
   type_menu menu;
   int index;
   bool init;
}  menu;

struct struct_fps
{
   unsigned int data;
   unsigned int time;
   bool enable;
}  fps;

int typeSky= 1;
char *chLevel= "Level: ", *chSteps= "Steps: ";

//----------------------------------------------//
void resize (int input_width, int input_height)
{
	glViewport (0, 0, input_width, input_height);
   glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluPerspective (45.0f, (GLfloat) input_width / (GLfloat) input_height, 0.1f, 250.0f);
   glMatrixMode (GL_MODELVIEW);
}
//----------------------------------------------//
void initGL (int input_width, int input_height)
{
   resize (input_width, input_height);
   glClearColor(0.1f, 0.2f, 0.3f, 1.0f);
	glEnable (GL_TEXTURE_2D);
	glEnable (GL_DEPTH_TEST);
	glEnable (GL_LIGHTING);
	glEnable (GL_LIGHT0);
   glEnable (GL_COLOR_MATERIAL);
//   glMaterialf (GL_FRONT, GL_SHININESS, 128.0 );
}
//----------------------------------------------//
int initMenu ()
{
   int menuWidth= 440;
   int menuHeight= 310;
   menu.menu[_MENU_FIRST_] = new class_menu;
   menu.menu[_MENU_FIRST_]->loadSkin (const_file_menu_skin);
   menu.menu[_MENU_FIRST_]->loadFont (const_file_font);
   menu.menu[_MENU_FIRST_]->init ((windowSizeX - menuWidth) / 2, (windowSizeY - menuHeight) / 2, menuWidth, menuHeight, windowSizeX, windowSizeY);
   menu.menu[_MENU_FIRST_]->set (_FRAME_, 20, 20, 400, 223);
   menu.menu[_MENU_FIRST_]->set (_LABEL_, 85, 190, 0, 0, "Beastie Worker", 2, 2, 0.3f, 0.3f, 0.3f);
   menu.menu[_MENU_FIRST_]->set (_LABEL_, 360, 40, 0, 0, "v 0.4", 1, 1, 0.3f, 0.3f, 0.3f);
   if (eLang == RU)
   {
      menu.menu[_MENU_FIRST_]->set (_LABEL_, 125, 220, 0, 0, "тот самый \"socoban\"", 1, 1, 0.25f, 0.25f, 0.25f);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 20, 260, 120, 30, "Играть", 1, 1, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 160, 260, 120, 30, "Автор", 1, 1);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 300, 260, 120, 30, "Выход", 1, 1, 0.5f, 0.1f ,0.1f);
   }
   else
   {
      menu.menu[_MENU_FIRST_]->set (_LABEL_, 150, 220, 0, 0, "very \"socoban\"", 1, 1, 0.25f, 0.25f, 0.25f);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 20, 260, 120, 30, "Start", 1, 1, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 160, 260, 120, 30, "Author", 1, 1);
      menu.menu[_MENU_FIRST_]->set (_BUTTON_, 300, 260, 120, 30, "Exit", 1, 1, 0.5f, 0.1f ,0.1f);
   }
   menu.menu[_MENU_FIRST_]->image (const_file_menu_image, 170, 40, 100, 100);
   menu.menu[_MENU_FIRST_]->active= true;

   menuWidth= 240;
   menuHeight= 210;
   menu.menu[_MENU_ABOUT_] = new class_menu;
   menu.menu[_MENU_ABOUT_]->loadSkin (const_file_menu_skin);
   menu.menu[_MENU_ABOUT_]->loadFont (const_file_font);
   menu.menu[_MENU_ABOUT_]->init ((windowSizeX - menuWidth) / 2, (windowSizeY - menuHeight) / 2, menuWidth, menuHeight, windowSizeX, windowSizeY);
   menu.menu[_MENU_ABOUT_]->set (_FRAME_, 20, 50, 200, 90);
   if (eLang == RU)
   {
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 75, 35, 0, 0, "А В Т О Р");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 75, 0, 0, "Разработчик:");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 90, 0, 0, "Мартыненко Андрей", 1, 1, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 115, 0, 0, "E-Mail:");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 130, 0, 0, "t_gran@mail.ru", 1, 1, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_ABOUT_]->set (_BUTTON_, 70, 160, 100, 25, "Угу");
   }
   else
   {
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 65, 35, 0, 0, "A U T H O R");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 75, 0, 0, "Developer:");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 90, 0, 0, "Martynenko Andrey", 1, 1, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 115, 0, 0, "E-Mail:");
      menu.menu[_MENU_ABOUT_]->set (_LABEL_, 30, 130, 0, 0, "t_gran@mail.ru", 1, 1, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_ABOUT_]->set (_BUTTON_, 70, 160, 100, 25, "Ok");
   }
   menu.menu[_MENU_ABOUT_]->active= true;

   menuWidth= 160;
   menuHeight= 294;
   menu.menu[_MENU_GAME_] = new class_menu;
   menu.menu[_MENU_GAME_]->loadSkin (const_file_menu_skin);
   menu.menu[_MENU_GAME_]->loadFont (const_file_font);
   menu.menu[_MENU_GAME_]->init ((windowSizeX - menuWidth) / 2, (windowSizeY - menuHeight) / 2, menuWidth, menuHeight, windowSizeX, windowSizeY);
   if (eLang == RU)
   {
      menu.menu[_MENU_GAME_]->set (_LABEL_, 35, 40, 0, 0, "меню", 2, 2, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 50, 120, 30, "Продолжить", 1, 1, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 98, 120, 30, "Сброс", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 147, 120, 30, "Предыдущий", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 195, 120, 30, "Следующий", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 243, 120, 30, "Выход", 1, 1, 0.5f, 0.1f ,0.1f);
   }
   else
   {
      menu.menu[_MENU_GAME_]->set (_LABEL_, 35, 40, 0, 0, "menu", 2, 2, 0.2f, 0.2f, 0.2f);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 50, 120, 30, "Continue", 1, 1, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 98, 120, 30, "[R]estart", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 147, 120, 30, "[P]revious", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 195, 120, 30, "[N]ext", 1, 1);
      menu.menu[_MENU_GAME_]->set (_BUTTON_, 20, 243, 120, 30, "End", 1, 1, 0.5f, 0.1f ,0.1f);

   }
   menu.menu[_MENU_GAME_]->active= true;

   menuWidth= 240;
   menuHeight= 150;
   menu.menu[_MENU_WIN_] = new class_menu;
   menu.menu[_MENU_WIN_]->loadSkin (const_file_menu_skin);
   menu.menu[_MENU_WIN_]->loadFont (const_file_font);
   menu.menu[_MENU_WIN_]->init ((windowSizeX - menuWidth) / 2, (windowSizeY - menuHeight) / 2, menuWidth, menuHeight, windowSizeX, windowSizeY);
   if (eLang == RU)
   {
      menu.menu[_MENU_WIN_]->set (_LABEL_, 50, 40, 0, 0, "У Р О В Е Н Ь", 1, 1, 0.8f, 0.8f, 0.8f);
      menu.menu[_MENU_WIN_]->set (_LABEL_, 43, 82, 0, 0, "ПРОЙДЕН", 2, 2, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_WIN_]->set (_BUTTON_, 70, 100, 100, 25, "Угу");
   }
   else
   {
      menu.menu[_MENU_WIN_]->set (_LABEL_, 72, 40, 0, 0, "L E V E L", 1, 1, 0.8f, 0.8f, 0.8f);
      menu.menu[_MENU_WIN_]->set (_LABEL_, 85, 82, 0, 0, "WIN", 2, 2, 0.1f, 0.5f ,0.1f);
      menu.menu[_MENU_WIN_]->set (_BUTTON_, 70, 100, 100, 25, "Ok");
   }
   menu.menu[_MENU_WIN_]->active= true;
   menu.index= _MENU_FIRST_;
   menu.init= true;
   return _OK_;
}
//----------------------------------------------//
void display ()
{
   glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   glLoadIdentity ();

/*
   GLfloat fogColor[4]= {0.5f, 0.5f, 0.5f, 1.0f}; 
   glClearColor(0.5f,0.5f,0.5f,1.0f);
   glEnable(GL_FOG);
   glFogi(GL_FOG_MODE, GL_EXP);
   glFogfv(GL_FOG_COLOR, fogColor);
   glFogf(GL_FOG_DENSITY, 0.003f);
   glHint(GL_FOG_HINT, GL_DONT_CARE);
*/

   glEnable (GL_LIGHTING);
   glColor3d (1.0f, 1.0f, 1.0f);
   glPushMatrix ();
      glTranslatef (0.0f, 0.0f, zoom);
	   glRotatef (angleX, 1.0f, 0.0f, 0.0f);
	   glRotatef (angleY, 0.0f, 0.0f, 1.0f);
      scene->draw ();
   glPopMatrix ();

   glDisable (GL_LIGHTING);
   
   if (typeSky)
   {
      glColor3d (0.7f, 0.7f ,0.7f);
      sky->draw ();
   }
   if (menu.init)
      menu.menu[menu.index]->draw ();
   glColor3d (0.3f, 0.9f ,0.3f);
   font->print (275, 445, gameTime / 60, gameTime % 60, 1.5f, 2.0f);
   glColor3d (0.8f, 0.8f, 0.8f);
   font->print (10, 450, chLevel, level, 1.2f, 1.2f);
   font->print (10, 10, chSteps, steps, 1.2f, 1.2f);
   if (fps.enable)
		font->print (545, 450, "fps: ", (Uint32) fps.data);
   glColor3d (1.0f, 1.0f, 1.0f);
   cursor->draw (windowSizeX, windowSizeY);
   SDL_GL_SwapBuffers ();
}
//----------------------------------------------//
int analizer (int input_c, char **input_v)
{
	int i= 0;
	bool done= false;
	for (i= 1; i < input_c && !done; i++)
	{
      if (!strcmp (input_v[i], "-h") || !strcmp (input_v[i], "-help") || !strcmp (input_v[i], "--help"))
		{
			printf ("BeastieWorker v0.4\nUsage: BeastieWorker [options]\nOptions:\n -h     this help\n -f     full screen mode\n -l     set language (-l help)\n -s     set width and height (-s help)\n --sky  set sky (--sky help)\n");
         return 1;
		}
		if (!strcmp(input_v[i], "-f"))
			bFullScreen= true;
		if (!strcmp(input_v[i], "-l"))
		{
			if (i == input_c - 1)
			{
				printf ("-l help\n");
            return 1;
			}
			if (!strcmp(input_v[i+1], "ru") || !strcmp(input_v[i+1], "RU"))
			{
            chLevel= "Уровень: ";
            chSteps= "Шаги: ";
            eLang= RU;
				continue;
         }
         if (!strcmp(input_v[i+1], "en") || !strcmp(input_v[i+1], "EN"))
         {
            chLevel= "Level: ";
            chSteps= "Steps: ";
            eLang= EN;
				continue;
         }
			if (!strcmp(input_v[i+1], "h") || !strcmp(input_v[i+1], "help"))
			{
				printf (" en   english\n ru   russian\n example: -l ru\n default: en\n");
				return 1;
			}
			if (input_v[i+1][0] != '-')
				printf ("unknow lang %s\n", input_v[++i]);
			printf ("-l help\n");
			return 1;
		}
      
      if (!strcmp(input_v[i], "--sky"))
      {
			if (i == input_c - 1)
			{
				printf ("--sky help\n");
            return 1;
			}
         if (!strcmp(input_v[i+1], "no") || !strcmp(input_v[i+1], "NO"))
         {
            typeSky= 0;
				continue;
         }
         if (!strcmp(input_v[i+1], "cl") || !strcmp(input_v[i+1], "CL"))
         {
            typeSky= 1;
				continue;
         }
         if (!strcmp(input_v[i+1], "ms") || !strcmp(input_v[i+1], "MS"))
         {
            typeSky= 2;
				continue;
         }
			if (!strcmp(input_v[i+1], "h") || !strcmp(input_v[i+1], "help"))
			{
				printf (" no   disable sky\n cl   cloud\n ms   mist\n example: --sky ms\n default: cl\n");
				return 1;
			}
      }
      
		if (!strcmp(input_v[i], "-s"))
		{
			if (i == input_c - 1)
			{
				printf ("-s help\n");
            return 1;
			}
			if (!strcmp(input_v[i+1], "h") || !strcmp(input_v[i+1], "help"))
			{
				printf (" \'width\'x\'height\' (min 500x400)\n example: -s 640x480\n default: 800x600\n");
            return 1;
			}
			char *chWidth= new char;
			unsigned j;
			for (j= 0; j < strlen (input_v[i+1]); j++)
				if (input_v[i+1][j] != 'x')
					chWidth[j]= input_v[i+1][j];
				else
					break;
			chWidth[j]= '\0';
			char *chHeight= new char;
			int g= 0;
			for (j++; j < strlen (input_v[i+1]); j++)
				chHeight[g++]= input_v[i+1][j];
			chHeight[g]= '\0';
			int width= atoi (chWidth);
			int height= atoi (chHeight);
			if (width < 500 || height < 400)
			{
				printf ("bad data or data much small\n-s help\n");
            return 1;
   		}
         windowSizeX= width;
         windowSizeY= height;
		}
	}
   return _OK_;
}
//----------------------------------------------//
int main (int argc, char *argv[])
{
   if (analizer (argc, argv))
      return _OK_;
   if (SDL_Init (SDL_INIT_VIDEO))
	{
		printf ("ERROR: unable to initialize SDL: %s\n", SDL_GetError());
		getchar ();
		return _ERR_;
	}
   if (bFullScreen)
      SDL_SetVideoMode (windowSizeX, windowSizeY, _PIXEL_BIT_, SDL_OPENGL | SDL_FULLSCREEN);
   else
      SDL_SetVideoMode (windowSizeX, windowSizeY, _PIXEL_BIT_, SDL_OPENGL);
   SDL_WM_SetCaption ("Beastie Worker", NULL);
   SDL_WM_SetIcon (SDL_LoadBMP ("icon.bmp"), NULL);
   initGL (windowSizeX, windowSizeY);
   checkAudioDevice ();
   scene= new class_scene;
   if (scene->loadLevel (const_file_level_index))
      return _ERR_;
   if (scene->loadModel (const_path_model))
      return _ERR_;
   font= new class_font;
   if (font->load (const_file_font))
      return _ERR_;
   if (typeSky)
   {
      sky= new class_sky;
      switch (typeSky)
      {
         case 1:
            sky->load (const_file_cloud);
         break;
         case 2:
            sky->load (const_file_mist);
         break;
      }
      const int const_size= 150;
      sky->x= (int) (((float) windowSizeX / (float) windowSizeY / 1.33f) * const_size);
      sky->y= const_size;
      sky->z= -245;
   }
   cursor= new class_cursor;
   cursor->load (const_path_cursor);
   initMenu ();
   bool flagMouseMuveLeft= false, flagMouseMuveRight= false;
   bool flagPlayerMove= false, flagPlayerLeft= false, flagPlayerRight= false;
	int mouseFixateX, mouseFixateY, mouseChangeX, mouseChangeY;
   int menuState;
   fps.enable= false;
   fps.data= 0;
   unsigned int time, loop= 0;
	SDL_Event event;
   int done= 0;
   soundPlay (const_file_sound_level);
   while (!done)
	{
      time= SDL_GetTicks();
      loop++;
      if (time - fps.time >= 1000)
      {
         if (!menu.init)
            gameTime++;
         fps.data= loop;
         loop= 0;
         fps.time= time;
      }
		display ();
      if ((menuState= menu.menu[menu.index]->getState ()))
      {
         switch (menu.index)
         {
            case _MENU_FIRST_:
               switch (menuState)
               {
                  case 1:
                     steps= 0;
                     gameTime= 0;
                     level= scene->level (_LEVEL_FIRST_) + 1;
                     menu.index= _MENU_GAME_;
                     menu.init= false;
                  break;

                  case 2:
                     menu.index= _MENU_ABOUT_;
                  break;

                  case 3:
                     done= 1;
                  break;
               }
            break;

            case _MENU_ABOUT_:
               switch (menuState)
               {
                  case 1:
                     menu.index= _MENU_FIRST_;
                  break;
               }
            break;

            case _MENU_GAME_:
               switch (menuState)
               {
                  case 1:
                     menu.init= false;
                  break;

                  case 2:
                     menu.init= false;
                     steps= 0;
                     scene->level (_LEVEL_RESTART_);
                  break;
                  
                  case 3:
                     steps= 0;
                     gameTime= 0;
							level= scene->level (_LEVEL_PREV_) + 1;
                  break;
                  
                  case 4:
                     steps= 0;
                     gameTime= 0;
                     level= scene->level (_LEVEL_NEXT_) + 1;
                  break;
                  
                  case 5:
                     steps= 0;
                     gameTime= 0;
                     level= scene->level (_LEVEL_FIRST_) + 1;
                     menu.index= _MENU_FIRST_;
                  break;
               }
            break;

            case _MENU_WIN_:
               switch (menuState)
               {
                  case 1:
                     menu.init= false;
                     steps= 0;
                     gameTime= 0;
                     level= scene->level (_LEVEL_NEXT_) + 1;
                     menu.index= _MENU_GAME_;
                  break;
               }
            break;
         }
      }
		if (SDL_PollEvent (&event))
		{
			switch (event.type) 
			{
				case SDL_QUIT:
					done= 1;
				break;

				case SDL_KEYDOWN:
					switch (event.key.keysym.sym)
					{
                  case SDLK_UP:
                     if (!menu.init)
                        flagPlayerMove= true;
                  break;
                  
                  case SDLK_LEFT:
                     if (!menu.init)
                        flagPlayerLeft= true;
                  break;

                  case SDLK_RIGHT:
                     if (!menu.init)
                        flagPlayerRight= true;
                  break;
                  
						case SDLK_ESCAPE:
                     if (menu.index == _MENU_GAME_)
                        menu.init= !menu.init;
						break;
                  
                  case SDLK_SPACE:
                     if (!menu.init && !scene->action (_PLAYER_PUSH_))
                     {
                        steps++;
                        soundPlay (const_file_sound_push);
                     }
                  break;
                  
                  case SDLK_RETURN:
                     if (menu.index == _MENU_WIN_)
                     {
                        menu.init= false;
                        steps= 0;
                        gameTime= 0;
                        level= scene->level (_LEVEL_NEXT_) + 1;
                        menu.index= _MENU_GAME_;
                     }
                  break;

                  default:
                  break;
					}
				break;

            case SDL_KEYUP:
            {
               switch (event.key.keysym.sym)
					{

                  case SDLK_UP:
                     flagPlayerMove= false;
                  break;

                  case SDLK_LEFT:
                     flagPlayerLeft= false;
                  break;

                  case SDLK_RIGHT:
                     flagPlayerRight= false;
                  break;

                  case SDLK_n:
                     steps= 0;
                     gameTime= 0;
							level= scene->level (_LEVEL_NEXT_) + 1;
						break;

                  case SDLK_p:
                     steps= 0;
                     gameTime= 0;
                     level= scene->level (_LEVEL_PREV_) + 1;
                  break;

                  case SDLK_r:
                     steps= 0;
                     scene->level (_LEVEL_RESTART_);
                  break;

                  case SDLK_f:
                     fps.enable= !fps.enable;
                     if (!fps.enable)
                        loop= 0;
                  break;

                  default:
                  break;
					}
            }
            break;
            
            case SDL_MOUSEBUTTONDOWN:
               switch (event.button.button)
               {
                  case SDL_BUTTON_LEFT:
                     flagMouseMuveLeft= !flagMouseMuveLeft;
                     if (menu.init)
                        menu.menu[menu.index]->mouseButtonEvent (SDL_MOUSEBUTTONDOWN);
                  break;

                  case SDL_BUTTON_RIGHT:
                     flagMouseMuveRight= !flagMouseMuveRight;
                  break;
               }
               SDL_GetMouseState (&mouseFixateX, &mouseFixateY);
            break;

            case SDL_MOUSEBUTTONUP:
               if (flagMouseMuveLeft)
               {
                  flagMouseMuveLeft= !flagMouseMuveLeft;
                  if (menu.init)
                     menu.menu[menu.index]->mouseButtonEvent (SDL_MOUSEBUTTONUP);
               }
               if (flagMouseMuveRight)
                  flagMouseMuveRight= !flagMouseMuveRight;
            break;
			}
 		}
      if (flagPlayerMove && !scene->action (_PLAYER_STEP_))
      {
         steps++;
         soundPlay (const_file_sound_step);
      }
      if (flagPlayerLeft && !scene->action (_PLAYER_LEFT_))
         soundPlay (const_file_sound_step);
      if (flagPlayerRight && !scene->action (_PLAYER_RIGHT_))
         soundPlay (const_file_sound_step);
      if (flagMouseMuveLeft && !menu.init)
      {
         SDL_GetMouseState (&mouseChangeX, &mouseChangeY);
         angleX+= (mouseChangeY - mouseFixateY) * 0.5f;
         angleY+= (mouseChangeX - mouseFixateX) * 0.5f;
         if (angleX < _LIMIT_ANGLE_X_MAX_)
            angleX= _LIMIT_ANGLE_X_MAX_;
         if (angleX > _LIMIT_ANGLE_X_MIN_)
            angleX= _LIMIT_ANGLE_X_MIN_;
         mouseFixateX= mouseChangeX;
         mouseFixateY= mouseChangeY;
      }
      if (flagMouseMuveRight && !menu.init)
      {
         SDL_GetMouseState (&mouseChangeX, &mouseChangeY);
         zoom-= (mouseChangeY - mouseFixateY) * 0.1f;
         if (zoom > _LIMIT_ZOOM_MAX_)
            zoom= _LIMIT_ZOOM_MAX_;
         if (zoom < _LIMIT_ZOOM_MIN_)
            zoom= _LIMIT_ZOOM_MIN_;
         mouseFixateX= mouseChangeX;
         mouseFixateY= mouseChangeY;        
      }
      scene->action (_PLAYER_QUIETNESS_);

      if (scene->levelWin () && menu.index == _MENU_GAME_)
      {
         menu.index= _MENU_WIN_;
         menu.init= !menu.init;
         soundPlay (const_file_sound_level);
      }
	}
   SDL_Quit ();
   return _OK_;
}
