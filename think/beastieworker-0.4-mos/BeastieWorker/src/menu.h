#include "main.h"
#include "texture.h"
#include "font.h"

#define _BUTTON_  1
#define _LABEL_   2
#define _FRAME_   3

#ifndef __menu_h_
#define __menu_h_

class class_menu
{
   private:

   /*Основные атрибуты*/
   struct struct_fontSize
   {
      int w, h;
   };

   struct struct_fontColor
   {
      float r, g, b;
   };

   struct struct_font
   {
      struct_fontSize size;
      struct_fontColor color;
   };

   struct struct_basicAttr
   {
      unsigned short x, y;
      unsigned short w, h;
      char *text;
      struct_font font;
   };

   /*Меню*/
   struct struct_menu
   {
      struct_basicAttr attr;
      bool init;
   }  menu;

   /*Стек*/
   struct struct_stack
   {
      struct_basicAttr attr;
      struct_stack *next;
   }  *button, *label, *frame;

   /*Картинка*/
   struct struct_image
   {
      int x, y;
      int w, h;
      class_texture txtr;
   }  *img;

   class_texture *texture;
   class_font *font;
      
   unsigned windowSizeX, windowSizeY;

   /*Метод обнуления по умолчанию*/
   int setDefault ();
   /*Методы работы со стеком*/
   int stackAdd (struct_stack **, struct_basicAttr);
   int stackDel (struct_stack **);
   /*Методы вывода частей меню*/
   int drawMenuBorder (int, int, int, int);
   int drawFrame (int, int, int, int);
   int drawButtonBorder (int, int, int, int, int, char *, int, int);

   int mouseButtonState;
   bool mouseActiveButton;
   int buttonChoice;

   public:

   bool active;

   class_menu ();
   class_menu (unsigned short, unsigned short, unsigned short, unsigned short);
   ~class_menu ();
   int init (unsigned short, unsigned short, unsigned short, unsigned short, unsigned, unsigned);
   int set (int, unsigned short, unsigned short, unsigned short, unsigned short, char (*)= "", int= 1, int= 1, float= 0.4f, float= 0.4f, float= 0.4f);
   int loadSkin (char *);
   int loadFont (char *);
   int image (char *, int, int, int, int);
   int mouseButtonEvent (int);
   int getState ();
   int draw ();
};

#endif
