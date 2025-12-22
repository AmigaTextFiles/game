#include "menu.h"

#define _BUTTON_UP_     0
#define _BUTTON_SELECT_ 1
#define _BUTTON_DOWN_   2

//----------------------------------------------//
class_menu::class_menu ()
{
   setDefault ();
   menu.attr.x= 0;
   menu.attr.y= 0;
   menu.attr.w= 0;
   menu.attr.h= 0;
   menu.init= false;
}
//----------------------------------------------//
class_menu::class_menu (unsigned short input_x, unsigned short input_y, unsigned short input_w, unsigned short input_h)
{
   setDefault ();
   init (input_x, input_y, input_w, input_h, 640, 480);
}
//----------------------------------------------//
class_menu::~class_menu ()
{
   stackDel (&button);
   stackDel (&label);
   stackDel (&frame);
   if (texture)
      delete texture;
   if (font)
      delete font;
   if (img)
      delete img;
}
//----------------------------------------------//
int class_menu::setDefault ()
{
   texture= NULL;
   font= NULL;
   button= NULL;
   label= NULL;
   frame= NULL;
   img= NULL;
   menu.attr.text= NULL;
   mouseButtonState= 0;
   mouseActiveButton= false;
   buttonChoice= 0;
   active= false;
   return _OK_;
}
//----------------------------------------------//
int class_menu::init (unsigned short input_x, unsigned short input_y, unsigned short input_w, unsigned short input_h, unsigned input_windowSizeX, unsigned input_windowSizeY)
{
   windowSizeX= input_windowSizeX;
   windowSizeY= input_windowSizeY;
   menu.attr.text= NULL;
   menu.attr.x= input_x;
   menu.attr.y= windowSizeY  - input_y;
   menu.attr.w= input_w;
   menu.attr.h= input_h;
   menu.init= true;
   return _OK_;
}
//----------------------------------------------//
int class_menu::stackAdd (struct_stack **input_stack, struct_basicAttr input_data)
{
   if (!*input_stack)
   {
      *input_stack= new struct_stack;
      (*input_stack)->attr= input_data;
      (*input_stack)->next= NULL;
   }
   else
   {
      struct_stack *stack= new struct_stack;
      stack->attr= input_data;
      stack->next= *input_stack;
      *input_stack= stack;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::stackDel (struct_stack **input_stack)
{
   while (*input_stack)
   {
      struct_stack *stack= *input_stack;
      *input_stack= (*input_stack)->next;
      delete stack;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::set
(
   int input_type,
   unsigned short input_x,
   unsigned short input_y,
   unsigned short input_w,
   unsigned short input_h,
   char *input_text,
   int input_fontW,
   int input_fontH,
   float input_fontColorR,
   float input_fontColorG,
   float input_fontColorB
)
{
   struct_basicAttr attr= {input_x, input_y, input_w, input_h, input_text, {{input_fontW, input_fontH}, {input_fontColorR, input_fontColorG, input_fontColorB}}};
   switch (input_type)
   {
      case _BUTTON_:
         stackAdd (&button, attr);
      break;

      case _LABEL_:
         stackAdd (&label, attr);
      break;

      case _FRAME_:
         stackAdd (&frame, attr);
      break;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::loadSkin (char *input_fileName)
{
   texture= new class_texture;
   if (texture->loadBMP (input_fileName))
   {
      printf ("ERROR: file \"%s\" is not found\n", input_fileName);
      delete texture;
      return _ERR_;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::loadFont (char *input_fileName)
{
   font= new class_font;
   if (font->load (input_fileName))
   {
      printf ("ERROR: file \"%s\" is not found\n", input_fileName);
      delete font;
      return _ERR_;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::image
(
   char *input_fileName,
   int input_x,
   int input_y,
   int input_w,
   int input_h
)
{
   if (img)
      delete img;
   img= new struct_image;
   if (img->txtr.loadBMP (input_fileName))
   {
      delete img;
      printf ("ERROR: file \"%s\" is not found\n", input_fileName);
      return _ERR_;
   }
   img->x= input_x;
   img->y= input_y;
   img->w= input_w;
   img->h= input_h;
   return _OK_;
}
//----------------------------------------------//
int class_menu::mouseButtonEvent (int input_mouseState)
{
   if (input_mouseState != SDL_MOUSEBUTTONDOWN && input_mouseState != SDL_MOUSEBUTTONUP)
      return _ERR_;
   mouseButtonState= input_mouseState;
   return _OK_;
}
//----------------------------------------------//
int class_menu::getState ()
{
   if (!buttonChoice)
      return 0;
   int returnValue= buttonChoice;
   buttonChoice= 0;
   return returnValue;
}
//----------------------------------------------//
int class_menu::drawMenuBorder (int x, int y, int w, int h)
{
   const int const_line= 10;

   /*Тело меню*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.900f, 0.000f); glVertex2i (0,  0);
		glTexCoord2f (0.900f, 0.100f); glVertex2i (0, -h);
		glTexCoord2f (1.000f, 0.000f); glVertex2i (w, -h);
		glTexCoord2f (1.000f, 0.100f); glVertex2i (w,  0);
	glEnd ();

   /*Левая сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.200f); glVertex2i (         0, -h);
		glTexCoord2f (0.045f, 0.200f); glVertex2i (const_line, -h);
		glTexCoord2f (0.045f, 0.800f); glVertex2i (const_line,  0);
		glTexCoord2f (0.000f, 0.800f); glVertex2i (         0,  0);
	glEnd ();

   /*Правая сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.200f); glVertex2i (w             , -h);
		glTexCoord2f (0.045f, 0.200f); glVertex2i (w - const_line, -h);
		glTexCoord2f (0.045f, 0.800f); glVertex2i (w - const_line,  0);
		glTexCoord2f (0.000f, 0.800f); glVertex2i (w             ,  0);
	glEnd ();

   /*Верхняя сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.200f); glVertex2i (w,           0);
		glTexCoord2f (0.045f, 0.200f); glVertex2i (w, -const_line);
		glTexCoord2f (0.045f, 0.800f); glVertex2i (0, -const_line);
		glTexCoord2f (0.000f, 0.800f); glVertex2i (0,           0);
	glEnd ();

   /*Нижняя сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.200f); glVertex2i (w,             -h);
		glTexCoord2f (0.045f, 0.200f); glVertex2i (w, const_line - h);
		glTexCoord2f (0.045f, 0.800f); glVertex2i (0, const_line - h);
		glTexCoord2f (0.000f, 0.800f); glVertex2i (0,             -h);
	glEnd ();

   /*Верхний левый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.000f); glVertex2i (0         ,           0);
		glTexCoord2f (0.045f, 0.000f); glVertex2i (0         , -const_line);
		glTexCoord2f (0.045f, 0.045f); glVertex2i (const_line, -const_line);
		glTexCoord2f (0.000f, 0.045f); glVertex2i (const_line,           0);
	glEnd ();

   /*Верхний правый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.000f); glVertex2i (w             ,           0);
		glTexCoord2f (0.045f, 0.000f); glVertex2i (w             , -const_line);
		glTexCoord2f (0.045f, 0.045f); glVertex2i (w - const_line, -const_line);
		glTexCoord2f (0.000f, 0.045f); glVertex2i (w - const_line,           0);
	glEnd ();

   /*Нижний левый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.000f); glVertex2i (0         ,             -h);
		glTexCoord2f (0.045f, 0.000f); glVertex2i (0         , const_line - h);
		glTexCoord2f (0.045f, 0.045f); glVertex2i (const_line, const_line - h);
		glTexCoord2f (0.000f, 0.045f); glVertex2i (const_line,             -h);
	glEnd ();

   /*Нижний правый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.000f, 0.000f); glVertex2i (w             ,             -h);
		glTexCoord2f (0.045f, 0.000f); glVertex2i (w             , const_line - h);
		glTexCoord2f (0.045f, 0.045f); glVertex2i (w - const_line, const_line - h);
		glTexCoord2f (0.000f, 0.045f); glVertex2i (w - const_line,             -h);
	glEnd ();

   return _OK_;
}
//----------------------------------------------//
int class_menu::drawFrame (int x, int y, int w, int h)
{
   const int const_line= 7;

   /*Левая сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.200f); glVertex2i (x - const_line, -h - y);
		glTexCoord2f (0.116f, 0.200f); glVertex2i (x             , -h - y);
		glTexCoord2f (0.116f, 0.800f); glVertex2i (x             ,     -y);
		glTexCoord2f (0.070f, 0.800f); glVertex2i (x - const_line,     -y);
	glEnd ();

   /*Правая сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.200f); glVertex2i (const_line + x + w, -h - y);
		glTexCoord2f (0.116f, 0.200f); glVertex2i (             x + w, -h - y);
		glTexCoord2f (0.116f, 0.800f); glVertex2i (             x + w,     -y);
		glTexCoord2f (0.070f, 0.800f); glVertex2i (const_line + x + w,     -y);
	glEnd ();

   /*Верхняя сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.200f); glVertex2i (w + x + const_line, const_line - y);
		glTexCoord2f (0.116f, 0.200f); glVertex2i (w + x + const_line,             -y);
		glTexCoord2f (0.116f, 0.800f); glVertex2i (    x - const_line,             -y);
		glTexCoord2f (0.070f, 0.800f); glVertex2i (    x - const_line, const_line - y);
	glEnd ();

   /*Нижняя сторона*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.200f); glVertex2i (w + x + const_line, -const_line - h - y);
		glTexCoord2f (0.116f, 0.200f); glVertex2i (w + x + const_line,              -h - y);
		glTexCoord2f (0.116f, 0.800f); glVertex2i (    x - const_line,              -h - y);
		glTexCoord2f (0.070f, 0.800f); glVertex2i (    x - const_line, -const_line - h - y);
	glEnd ();

   /*Верхний левый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.000f); glVertex2i (-const_line + x, const_line - y);
		glTexCoord2f (0.116f, 0.000f); glVertex2i (              x, const_line - y);
		glTexCoord2f (0.116f, 0.045f); glVertex2i (              x,             -y);
		glTexCoord2f (0.070f, 0.045f); glVertex2i (-const_line + x,             -y);
   glEnd ();

   /*Верхний правый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.000f); glVertex2i (const_line + w + x, const_line - y);
		glTexCoord2f (0.116f, 0.000f); glVertex2i (             w + x, const_line - y);
		glTexCoord2f (0.116f, 0.045f); glVertex2i (             w + x,             -y);
		glTexCoord2f (0.070f, 0.045f); glVertex2i (const_line + w + x,             -y);
   glEnd ();

   /*Нижний левый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.000f); glVertex2i (-const_line + x, -const_line - h - y);
		glTexCoord2f (0.116f, 0.000f); glVertex2i (              x, -const_line - h - y);
		glTexCoord2f (0.116f, 0.045f); glVertex2i (              x,              -h - y);
		glTexCoord2f (0.070f, 0.045f); glVertex2i (-const_line + x,              -h - y);
   glEnd ();

   /*Нижний правый угол*/
   glBegin (GL_QUADS);
		glTexCoord2f (0.070f, 0.000f); glVertex2i (const_line + w + x, -const_line - h - y);
		glTexCoord2f (0.116f, 0.000f); glVertex2i (             w + x, -const_line - h - y);
		glTexCoord2f (0.116f, 0.045f); glVertex2i (             w + x,              -h - y);
		glTexCoord2f (0.070f, 0.045f); glVertex2i (const_line + w + x,              -h - y);
   glEnd ();

   return _OK_;
}
//----------------------------------------------//
int class_menu::drawButtonBorder (int state, int x, int y, int w, int h, char *str, int fW, int fH)
{
   switch (state)
   {
      case _BUTTON_UP_:
         glBegin (GL_QUADS);
   		   glTexCoord2f (0.142f, 0.998f); glVertex2i (x    ,     -y);
		      glTexCoord2f (0.142f, 0.803f); glVertex2i (x    , -h - y);
		      glTexCoord2f (0.910f, 0.803f); glVertex2i (x + w, -h - y);
		      glTexCoord2f (0.910f, 0.998f); glVertex2i (x + w,     -y);
	      glEnd ();
         /*
         if (font)
            font->printIfOrtho (x + ((w - _FONT_WIDTH_ * strlen (str) * fW) / 2), -y - (h - ((h - _FONT_HEIGHT_ * fH) / 2)), str, fW, fH);
         */
      break;

      case _BUTTON_SELECT_:
         glBegin (GL_QUADS);
            glTexCoord2f (0.142f, 0.780f); glVertex2i (x    ,     -y);
		      glTexCoord2f (0.142f, 0.584f); glVertex2i (x    , -h - y);
		      glTexCoord2f (0.910f, 0.584f); glVertex2i (x + w, -h - y);
		      glTexCoord2f (0.910f, 0.780f); glVertex2i (x + w,     -y);
	      glEnd ();
         /*
         if (font)
            font->printIfOrtho (x + ((w - _FONT_WIDTH_ * strlen (str) * fW) / 2), -y - (h - ((h - _FONT_HEIGHT_ * fH) / 2)), str, fW, fH);
         */
      break;

      case _BUTTON_DOWN_:
         glBegin (GL_QUADS);
            glTexCoord2f (0.142f, 0.561f); glVertex2i (x    ,     -y);
		      glTexCoord2f (0.142f, 0.375f); glVertex2i (x    , -h - y);
		      glTexCoord2f (0.910f, 0.375f); glVertex2i (x + w, -h - y);
		      glTexCoord2f (0.910f, 0.561f); glVertex2i (x + w,     -y);
	      glEnd ();
         /*
         if (font)
            font->printIfOrtho (x + ((w - _FONT_WIDTH_ * strlen (str) * fW) / 2), -y - (h - ((h - _FONT_HEIGHT_ * fH) / 2)) - 2, str, fW, fH);
         */
      break;
   }
   return _OK_;
}
//----------------------------------------------//
int class_menu::draw ()
{
   if (!texture || !menu.init)
      return _ERR_;
   if (!active)
      return _OK_;
   int x, y;
   SDL_GetMouseState (&x, &y);
   x-= menu.attr.x;
   y-= windowSizeY - menu.attr.y;
	glDisable (GL_DEPTH_TEST);
	glMatrixMode (GL_PROJECTION);
	glPushMatrix ();
	glLoadIdentity ();
	glOrtho (0, windowSizeX, 0, windowSizeY, -1, 1);
	glMatrixMode (GL_MODELVIEW);
	glPushMatrix ();
	glLoadIdentity ();
	glTranslated (menu.attr.x, menu.attr.y, 0);
   texture->use (); 
   glColor3d (1.0f, 1.0f, 1.0f);
   drawMenuBorder (menu.attr.x, menu.attr.y, menu.attr.w, menu.attr.h);
   struct_stack *stack= frame;
   while (stack)
   {
      drawFrame (stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h);
      stack= stack->next;
   }
   if (img)
   {
      img->txtr.use ();
      glBegin (GL_QUADS);
		   glTexCoord2d (1, 1); glVertex2i (img->x + img->w, -img->y);
		   glTexCoord2d (0, 1); glVertex2i (img->x, -img->y);
		   glTexCoord2d (0, 0); glVertex2i (img->x, -img->y - img->h);
		   glTexCoord2d (1, 0); glVertex2i (img->x + img->w, -img->y - img->h);
	   glEnd ();
   }
   stack= button;
   int loop= 1, active= 0;
   while (stack)
   {
      texture->use (); 
      glColor3d (1.0f, 1.0f, 1.0f);
      drawFrame (stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h);
      if (x >= stack->attr.x && y >= stack->attr.y && x <= stack->attr.x + stack->attr.w && y <= stack->attr.y + stack->attr.h)
      {
         active++;
         const float const_fontBrightness= 0.1f;
         switch (mouseButtonState)
         {
            case SDL_MOUSEBUTTONDOWN:
               drawButtonBorder (_BUTTON_DOWN_, stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               if (font)
               {
                  glColor3d (stack->attr.font.color.r + const_fontBrightness, stack->attr.font.color.g + const_fontBrightness, stack->attr.font.color.b + const_fontBrightness);
                  font->printIfOrtho (stack->attr.x + ((stack->attr.w - _FONT_WIDTH_ * strlen (stack->attr.text) * stack->attr.font.size.w) / 2), -stack->attr.y - (stack->attr.h - ((stack->attr.h - _FONT_HEIGHT_ * stack->attr.font.size.h) / 2)) - 2, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               }
               mouseActiveButton= true;
            break;

            case SDL_MOUSEBUTTONUP:
               if (!mouseActiveButton)
                  break;
               drawButtonBorder (_BUTTON_UP_, stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               if (font)
               {
                  glColor3d (stack->attr.font.color.r + const_fontBrightness, stack->attr.font.color.g + const_fontBrightness, stack->attr.font.color.b + const_fontBrightness);
                  font->printIfOrtho (stack->attr.x + ((stack->attr.w - _FONT_WIDTH_ * strlen (stack->attr.text) * stack->attr.font.size.w) / 2), -stack->attr.y - (stack->attr.h - ((stack->attr.h - _FONT_HEIGHT_ * stack->attr.font.size.h) / 2)), stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               }
               buttonChoice= loop;
               mouseActiveButton= false;
            break;

            default:
               drawButtonBorder (_BUTTON_SELECT_, stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               if (font)
               {
                  glColor3d (stack->attr.font.color.r + const_fontBrightness, stack->attr.font.color.g + const_fontBrightness, stack->attr.font.color.b + const_fontBrightness);
                  font->printIfOrtho (stack->attr.x + ((stack->attr.w - _FONT_WIDTH_ * strlen (stack->attr.text) * stack->attr.font.size.w) / 2), -stack->attr.y - (stack->attr.h - ((stack->attr.h - _FONT_HEIGHT_ * stack->attr.font.size.h) / 2)), stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
               }
            break;
         }
      }
      else
      {
         
         drawButtonBorder (_BUTTON_UP_, stack->attr.x, stack->attr.y, stack->attr.w, stack->attr.h, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
         if (font)
         {
            glColor3d (stack->attr.font.color.r, stack->attr.font.color.g, stack->attr.font.color.b);
            font->printIfOrtho (stack->attr.x + ((stack->attr.w - _FONT_WIDTH_ * strlen (stack->attr.text) * stack->attr.font.size.w) / 2), -stack->attr.y - (stack->attr.h - ((stack->attr.h - _FONT_HEIGHT_ * stack->attr.font.size.h) / 2)), stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
         }
      }
      stack= stack->next;
      loop++;
   }
   if (!mouseActiveButton)
      mouseButtonState= 0;
   if (!active)
      mouseActiveButton= false;
   if (buttonChoice)
      buttonChoice= loop - buttonChoice;
   stack= label;
   while (stack)
   {
      glColor3d (stack->attr.font.color.r, stack->attr.font.color.g, stack->attr.font.color.b);
      font->printIfOrtho (stack->attr.x, -stack->attr.y, stack->attr.text, stack->attr.font.size.w, stack->attr.font.size.h);
      stack= stack->next;
   }
   glMatrixMode (GL_PROJECTION);
	glPopMatrix ();
	glMatrixMode (GL_MODELVIEW);
	glPopMatrix ();
	glEnable (GL_DEPTH_TEST);
   return _OK_;
}
//----------------------------------------------//
