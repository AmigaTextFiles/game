#ifndef AMIGA_H
#define AMIGA_H

#define dprintf printf

#define PixelAt(x,y) (graphicsData+FRAME_WIDTH*(y)+(x))

class Graphics
{
public:
  Graphics(int argc, char *argv[]);
  ~Graphics(void);

  int Open(void);
  void Close(void);

  void Print(void);
  void Clear(int color);

  void SetPixel (int x, int y, int color);
  void SetLine (int x1, int y1, int x2, int y2, int color);
  void SetHorLine (int x1, int x2, int y, int color);
  void SetRGB(int i, int r, int g, int b);

  char *Memory;
};

class Keyboard
{
public:
  Keyboard(int argc, char *argv[]);
  ~Keyboard(void);

  int Open(void);
  void Close(void);
};

#endif // AMIGA_H
