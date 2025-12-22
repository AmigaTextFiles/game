CRobots, Inc.
John Smolin
/* KILLER.R    by John Smolin  */
/* Combination of Leader (standing stiill) and B2  */
/* Eventually there will be one which moves instead of corner-sitting  */

int range, x, orange, ox, dir;

main()
{
   drive(270,100);
   x = -239;
   dir = 90;
   while(loc_y() > 35);
   drive(90,0);
   while(speed() > 49);
   drive(0,100);
   while(loc_x() < 965);
   drive(100,0);
   while(damage() < 55)
   {
       x += 329;
       while(!range && (damage() < 55))
       {
           if (range = scan(x += 15, 8))
           {
               x = killit(x);
           }
           else if (x > 180)
           {
               x = 80;
           }
       }
       while(1)
       {
           if (dir == 450)
           {
               dir = 90;
           }
           if (((dir == 90) && (loc_y() > 920)) || ((dir == 270) && (loc_y()
               < 80)) || ((dir == 0) && (loc_x() > 920)) || ((dir == 180) &&
               (loc_x() < 80)))
           {
               drive(dir += 90, 0);
               while(speed() > 49);
               drive(dir, 100);
           }
           if (speed() < 50)
           {
               drive(dir, 100);
           }
           if ((x > dir + 179) && !range)
           {
               x = dir - 25;
           }
           if (range && (range < 701))
           {
               x += 5 - (scan(x - 5, 5) != 0) * 10;
               x += 3 - (scan(x - 3, 3) != 0) * 6;
               orange = range;
               if ((range = scan(x, 10)) > 40)
               {
                   cannon(x, range + (range - orange + cos(x - dir) / 2000)
                       * range / 325);
               }
               else
               {
                   cannon(x, 46);
               }
           }
           else
           {
               range = scan(x += 19, 10);
           }
       }
   }
}

killit(x)
{
   cannon(x, range);
   while(range && (range < 700) && (damage() < 55))
   {
       ox = x;
       orange = range;
       x += 4 - (scan(x - 4, 4) != 0) * 8;
       x += 2 - (scan(x - 2, 2) != 0) * 4;
       range = scan(x, 10);
       if (range > 150)
       {
           x += 1 - (scan(x - 1, 1) != 0) * 2;
           if (range)
           {
               cannon(x + (x - ox) * range / 275, range + (range - orange)
                   * range / 275);
           }
       }
       else
       {
           if (range < 41 && range)
           {
               range = 41;
           }
           if (range)
           {
               cannon(x, range);
           }
       }
   }
   range = 0;
   return(x);
}
