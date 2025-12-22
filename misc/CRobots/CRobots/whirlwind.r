Baumeister GmbH
Markus
/* moves always (never halts) in random directions, so he is difficult to hit
   and fires at others which cross his way
*/
main()
{
   long richtung, direc;
   long range, j;

   while(1)
   {
       /* are we moving? if not go in random direction */
       if (speed() == 0)
       {
           drive(richtung = rand(360), 30);
           direc = richtung - 25;
       }
       j = 10;     /* only test this ^^ every ten times    */
       while(--j)
       {
           {
           /* are we in the near of a wall, then change direction  */
           long curx, cury;
               if ((curx = loc_x())<170)
               {
                   drive(richtung=rand(110) + 305, 40); /*change direction*/
                   direc = richtung - 25;  /* which direction to look  */
                   drive(richtung, 55);    /* speed up again   */
               }
               else if (curx > 830)
               {
                   drive(richtung = rand(110) + 125, 40);
                   direc = richtung - 25;
                   drive(richtung, 55);
               }
               if((cury = loc_y()) < 160)
               {
                   drive(richtung = rand(100) + 40, 40);
                   direc = richtung - 25;
                   drive(richtung, 55);
               }
               else if (cury > 840)
               {
                   drive(richtung = rand(100) + 220, 40);
                   direc = richtung - 25;
                   drive(richtung, 55);
               }
           }   /* end of local variables   */
           
           if (range = scan(direc, 5))
           {   /* found someone ! */
               if (range < 360)    /* if he's farer, we would probobly miss him */
                   if (range > 70) /* if he's nearer we would also suffer from hit */
                       cannon(direc, range - 21);  /* shoot at him */
               /* scan with higher resolution  */
               if ((range = scan(direc - 3, 1)) > 67)
                   cannon(direc - 3, range - 18);
               if ((range = scan(direc, 1)) > 65)
                   cannon(direc, range - 16);
               if ((range = scan(direc + 3, 1)) > 67)
                   cannon(direc + 3, range - 18);
               if (direc < richtung)
                   direc -= 10;    /* scan whole section again next time */
           }
           else if ((direc += 10) > richtung + 35) /* are we looking in front of us ?*/
               direc = richtung - 35;              /* no => do so! */
       } /* while(--j) */
   } /* while(1) */
} /* main */
