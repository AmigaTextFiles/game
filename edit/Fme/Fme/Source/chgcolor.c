#include "stdio.h"
#include "exec/types.h"
int map[33][65], x, y;
char c, *colors, name[40];
FILE *in, *out;
main()
{
   printf("Change map to (g)reen or (b)rown? ");
   c = getchar();
   if (c=='g')
       colors = "green";
   else if (c=='b')
       colors = "brown";
   else exit(0);
   printf("Enter name of map to change to %s ",colors);
   gets(name);
   gets(name);
   if ((in = fopen(name,"r")) == NULL)
     {
        printf("Error opening file.\n");
        exit(0);
     }
   for (x=1;x<33;x++)
      {
         for (y=1;y<65;y++)
               map[x][y] = getc(in);
      }
   fclose(in);

   if (c=='g')
     {
        for (x=1;x<33;x++)
           {
              for (y=1;y<65;y++)
                 {
                    if (map[x][y] < 5) continue;
                      switch (map[x][y])
                          {
                             case 20 : map[x][y] = 32;
                                       break;
                             case 44 : map[x][y] = 67;
                                       break;
                             case 17 : map[x][y] = 29;
                                       break;
                             case 18 : map[x][y] = 30;
                                       break;
                             case 19 : map[x][y] = 31;
                                       break;
                             case 22 : map[x][y] = 34;
                                       break;
                             case 24 : map[x][y] = 36;
                                       break;
                             case 25 : map[x][y] = 37;
                                       break;
                             case 89 : map[x][y] = 92;
                                       break;
                             case 42 : map[x][y] = 65;
                                       break;
                             case 47 : map[x][y] = 70;
                                       break;
                             case 27 : map[x][y] = 39;
                                       break;
                             case 85 : map[x][y] = 87;
                                       break;
                             case 41 : map[x][y] = 64;
                                       break;
                             case 43 : map[x][y] = 66;
                                       break;
                             case 48 : map[x][y] = 71;
                                       break;
                             case 50 : map[x][y] = 73;
                          }
                 }
           }
     strcat(name,".g");
     }

   if (c=='b')
     {
        for (x=1;x<33;x++)
           {
              for (y=1;y<65;y++)
                 {
                    if (map[x][y] < 5) continue;
                      switch (map[x][y])
                          {
                             case 32 : map[x][y] = 20;
                                       break;
                             case 67 : map[x][y] = 44;
                                       break;
                             case 29 : map[x][y] = 17;
                                       break;
                             case 30 : map[x][y] = 18;
                                       break;
                             case 31 : map[x][y] = 19;
                                       break;
                             case 34 : map[x][y] = 22;
                                       break;
                             case 36 : map[x][y] = 24;
                                       break;
                             case 37 : map[x][y] = 25;
                                       break;
                             case 92 : map[x][y] = 89;
                                       break;
                             case 65 : map[x][y] = 42;
                                       break;
                             case 70 : map[x][y] = 47;
                                       break;
                             case 39 : map[x][y] = 27;
                                       break;
                             case 87 : map[x][y] = 85;
                                       break;
                             case 64 : map[x][y] = 41;
                                       break;
                             case 66 : map[x][y] = 43;
                                       break;
                             case 71 : map[x][y] = 48;
                                       break;
                             case 73 : map[x][y] = 50;
                          }
                 }
           }
     strcat(name,".b");
     }

   if ((out = fopen(name,"w")) == NULL)
     {
        printf("Error writing file.\n");
        exit(0);
     }
   for (x=1;x<33;x++)
      {
         for (y=1;y<65;y++)
               putc(map[x][y],out);
      }
   fclose(out);
   
}


