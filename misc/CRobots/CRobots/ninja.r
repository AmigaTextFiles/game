Bugaboo Inc.
The Mad Doctor
/* ninja reverse thorin */

/* only one routine !! */
main()
{
     int    Dir,Range;

     Dir=Range=0;
     while (1) /* main loop */
     {
          drive(rand(360),100);
          while (!(Range=scan(Dir,10)))
               Dir += 20;

          if (!speed())
             while (!speed())
                   drive(rand(360,100));

          Dir -= 20;

          while (!(Range=scan(Dir,5)))
               Dir += 5;

          while (speed() > 49)
          {
                cannon(Dir,Range);
                drive(Dir,0);

          }

          drive(Dir+180,100);

          while (Range = scan(Dir,5))
          {
                while (Range = scan(Dir,5))
                      cannon(Dir,Range);

                if (Range = scan(Dir, 10))
                {
                     int k;

                     Dir -= 10;
                     k = Dir;
                     while ((!(Range = scan(Dir,5))) &&
                            (Dir - k <= 30))
                           Dir += 5;  /* fine tuning */

                     while (speed() > 49)
                           drive(Dir+180,0);

                     drive(Dir, 100);
                 }

          }  /* if out of this loop? probably passed by.  turn around */

         Dir += 170;
         while (speed() > 49)
               drive(0,0);

    } /* while */

}

