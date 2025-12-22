#ifndef __DESK_H__
#define __DESK_H__

#include <Fl/Fl_Widget.h>

class Desk: public Fl_Widget
{
    protected:
      void draw();
      int handle(int act);
    public:
      Desk(int x,int y,int w,int h,const char *l);
      ~Desk();
};

#endif
