Dark Unicorn
Damascene Ind.
/* SHARPSHOOTER

   Copyright (C) 1988 Dark Unicorn Publishing
   A Product of Damascene Industries

   TIGER without movement.  SHARPSHOOTER is designed to lock onto and destroy
   any robot it sees. */

int angle,range;

main()
{
  move (500,500);
  while (1)
    search();
}

/* Search: SHARPSHOOTER uses a fast scan to detect targets, then guns it down
    with auto-tracking. */

search()
{
  if (range = scan(angle += 130,10))
    while (range = scan(angle = track(angle,10),10))
      cannon(angle,range * 9 / 10);
}

/* Track: pinpoints the enemy. */

track(d,r)
int d,r;
{
  if (r > 0)
    {
      if (scan(d-r,r) > 0)
        return(track(d-r,r/2));
      else
        if (scan(d+r,r) > 0)
          return(track(d+r,r/2));
        else
          return(track(d,r/2));
    }
  else
    return(d);
}

/* Move: go to a specific location.  Shoot anything seen in SHARPSHOOTER's
    path. */

move (dest_x, dest_y)
int dest_x, dest_y;
{
  int course,range;

  course = plot_course(dest_x,dest_y);
  while (distance(loc_x(),loc_y(),dest_x,dest_y) > 50)
  {
    drive (course,100);
    if (range = scan(course,10))
      cannon(course,range);
  }
  drive(course,0);
}

/* Distance: calculates distance between two points. */

distance(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  return(sqrt(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2))));
}

/* Plot Course: calculates the degree heading of a location. */

plot_course(xx,yy)
int xx, yy;
{
  int d,
      x,y;

  x = loc_x() - xx;
  y = loc_y() - yy;

  if (x == 0) {
    if (y > 0)
      d = 90;
    else
      d = 270;
  }
  else {
    d = atan((100000 * y) / x);
    if (x >= 0)
      d += 180;
    else if ((y > 0) && (x < 0))
      d += 360;
  }
  return (d % 360);
}


