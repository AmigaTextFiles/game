#ifndef __DRAWING_HEADER
#define __DRAWING_HEADER

void PutPixel8B(UBYTE *video,int x,int y,long pitch,UBYTE color);
void Line8B(UBYTE *video,int x1,int y1,int x2,int y2,long pitch,UBYTE color);
void Line8B_transp(UBYTE *video,int x1,int y1,int x2,int y2,long pitch,UBYTE color);
int  line_mean(int x1,int y1,int x2,int y2,UBYTE *orig,long pitch);
void B_polygon(int *xp,int *yp,int nump,UBYTE col,UBYTE *dir,int pitch);

void GausianDot(UBYTE *screen,int x,int y,int pitch,int radius,UBYTE color);
void Circle(UBYTE *screen,int x,int y,int pitch,int radius,UBYTE color);
void FillCircle(UBYTE *screen,int x,int y,int pitch,int radius,UBYTE color);
void B_rectangle(UBYTE *screen,int x,int y,int dx,int dy,int pitch,UBYTE color);
void B_rectangle2(UBYTE *screen,int x,int y,int dx,int dy,int pitch,UBYTE color);

#endif

