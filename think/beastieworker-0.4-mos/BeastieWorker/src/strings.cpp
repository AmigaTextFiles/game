#include "strings.h"

//----------------------------------------------//
int findLastStr (const char *input_string, char *output_string)
{
   if (!strlen (input_string))
      return 1;
   int i;
   for (i= strlen (input_string) - 1; i > 0; i--)
      if (input_string[i] == '/')
         break;
   strcpy (output_string, input_string);
   output_string[i + 1]= _CHAR_NULL_;
   return 0;
}
//----------------------------------------------//
int findDir (const char *input_path, char *output_dir)
{
   if (!strlen (input_path))
      return 1;
   const char const_slash= '/';
   int i;
   for (i= strlen (input_path); i > 0; i--)
      if (input_path[i] == const_slash)
         break;
   if (!i)
      return 1;
   int j;
   for (j= 0; j <= i; j++)
   {
      output_dir[j]= input_path[j];
   }
   output_dir[j]= _CHAR_NULL_;
   return 0;
}
//----------------------------------------------//
