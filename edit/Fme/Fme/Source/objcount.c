#include "stdio.h"
#include "exec/types.h"
int map[65][65], x, y, size;
int gfuels = 0, bfuels = 0, gturrets = 0, bturrets = 0, gflags = 0, bflags = 0;
char c, *horf, name[40];
FILE *in;
main()
{
   printf("Load (h)alf map or (f)ull map? ");
   c = getchar();
   if (c=='h')
     {
        horf = "half";
        size = 33;
     }
   else if (c=='f')
     {
        horf = "full";
        size = 65;
     }
   else exit(0);
   printf("Enter name of %s map to display data on: ",horf);
   gets(name);
   gets(name);
   if ((in = fopen(name,"r")) == NULL)
     {
        printf("Error opening file.\n");
        exit(0);
     }
   for (x=1;x<size;x++)
      {
         for (y=1;y<65;y++)
               map[x][y] = getc(in);
      }
   fclose(in);

   for (x=1;x<size;x++)
      {
         for (y=1;y<65;y++)
            {
                if (map[x][y] == 37) gfuels += 1;
                if (map[x][y] == 92) gflags += 1;
                if ((map[x][y] == 39) || (map[x][y] == 87) ||
                    (map[x][y] == 64) || (map[x][y] == 66) ||
                     (map[x][y] == 71) || (map[x][y] == 73))
                   gturrets += 1;
                if (map[x][y] == 25) bfuels += 1;
                if (map[x][y] == 89) bflags += 1;
                if ((map[x][y] == 27) || (map[x][y] == 85) ||
                    (map[x][y] == 41) || (map[x][y] == 43) ||
                     (map[x][y] == 48) || (map[x][y] == 50))
                   bturrets += 1;
            }
      }
   printf("\n         green | brown");
   printf("         green | brown");
   printf("         green | brown\n");
   printf("         fuels | fuels");
   printf("         flags | flags");
   printf("       turrets | turrets\n");
   printf("         ----- | -----");
   printf("         ----- | -----");
   printf("       ------- | -------\n");
   printf("          %3d  |  %3d",gfuels,bfuels);
   printf("           %3d  |  %3d",gflags,bflags);
   printf("          %3d   |   %3d",gturrets,bturrets);
   printf("\n\n");
}


