Dark Unicorn
Conrad Wong
/* PROWLING TIGER

   Tiger, Tiger, Burning Bright,
   Stalking Through the Jungle Night,
   What Mortal Hand or Eye
   Dare Trace Thy Fearful Symmetry?

   version 3.0 last revised November 4, 1988

   Created July 21, 1988 by Conrad Wong
   Copyrighted (C) 1988 Dark Unicorn Publishing */

int angle,
    range,
    look,
    movex,
    movey;

main()
{
  int temp;

  movex = 100;
  movey = 900;
  while (1) {
    move(movex,movey);
    temp = movex;
    movex = movey;
    movey = 1000 - temp;
  }
}

/* Move: Tiger searches for prey by moving in a square inscribed in the
    battlefield.  He looks always in the direction he's heading and in a
    constantly rotating direction. */

move (dest_x, dest_y)
int dest_x, dest_y;
{
  int course,range;

  course = plot_course(dest_x,dest_y);
  while (distance(loc_x(),loc_y(),dest_x,dest_y) > 50)
  {
    drive (course,100);
    if (range = scan(angle = course,10)) {
      pounce();
      course = plot_course(dest_x,dest_y);
    }
    if (range = scan(angle = (look -= 110),10)) {
      pounce();
      course = plot_course(dest_x,dest_y);
    }
  }
  drive(course,0);
}

/* Pounce: when Tiger is charging, he uses the tracking subroutine to make
    sure his gun is on target, then subtracts a bit from range because he's
    moving so fast.  If Tiger is close enough, he stops and uses the killprey
    subroutine; if he loses sight of the prey, he's passed it and does a
    quick scan.  */

pounce()
{
  int course;

  course = angle;
  while ((range = scan(angle = track(angle,10,0),10)) > 200) {
    cannon(angle,range * 9 / 10);
    drive (course,100);
  }
  if (range)
    killprey();
  spotprey();
}

/* Spot Prey: Tiger has lost the prey, but because it was pouncing, Tiger
    thinks the prey is fairly close and uses a tracking subroutine to spot it.
    Depending on the range, it will either pounce or killprey. */

spotprey()
{
  int time;

  drive (0,0);
  time = 0;

  while (!(range = scan(angle += 100,10)) && (time < 36)) {
    time += 1;
  }
  if (range)
    killprey();
}

/* Kill Prey: Tiger has spotted the prey in close and doesn't want to waste
    time charging.  Instead Tiger uses a lower resolution on the subroutine
    to keep a good lock on the prey.  Tiger also knows if he's been hit too
    much staying where he is and flees. */

killprey()
{
  int hit;

  drive (0,0);
  hit = damage() + 30;

  cannon (angle,range);
  while (range = scan(angle = track(angle,20,5),10)) {
    cannon (angle,range);
    if (!range) {
      spotprey();
      range = 0;
    }
    if (range > 200) {
      pounce();
      range = 0;
    }
    if (hit < damage()) {
      flee();
      range = 0;
    }
  }
}

/* Flee: if Tiger takes too much damage attacking the prey, it will flee by
    running in a random direction. */

flee()
{
  int x,y,course;

  x = rand(1000);
  y = rand(1000);
  course = plot_course(x,y);
  while (distance(loc_x(),loc_y(),x,y) > 50) {
    drive (course,100);
    range = scan (course,10);
    if (range > 0)
      cannon(course,range);
  }
  drive (0,0);
}

/* Track: pinpoints the enemy. */

track(d,r,l)
int d,r,l;
{
  if (r > l)
    {
      if (scan(d-r,r) > 0)
        return(track(d-r,r/2,l));
      else
        if (scan(d+r,r) > 0)
          return(track(d+r,r/2,l));
        else
          if (scan(d,r) > 0)
            return(track(d,r/2,l));
          else
            return (d);
    }
  else
    return(d);
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

