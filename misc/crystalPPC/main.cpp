#include <stdio.h>
#include <stdlib.h>
#ifdef OS_DOS
#  include <conio.h>
#endif
#include <time.h>

#ifndef DEF_H
#include "def.h"
#endif

#ifndef SYSTEM_H
#include "system.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef VIEWPOLY_H
#include "viewpoly.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef CONFIG_H
#include "config.h"
#endif

#ifndef LIGHTMAP_H
#include "lightmap.h"
#endif

#include "global.h"

CrystConfig config ("cryst.cfg");

int fps=0;
int num=0;

Camera c;
ViewPolygon view (40);
World world;
Textures* tex;
Sector* room;
System *Sys;

double tb_scale_hi;
double tb_scale_lo;
int show_fps=0;
int thetimer=0;

extern "C" int ppctimer(unsigned int clock[2]);

long I_GetTime (void)
{
  unsigned int clock[2];
  double currtics;
  static double basetics=0.0;
  if (!thetimer) return time(0);
  else
  {
  ppctimer (clock);
  if (basetics == 0.0)
    basetics = ((double) clock[0])*tb_scale_hi + ((double) clock[1])/tb_scale_lo;

  currtics = ((double) clock[0])*tb_scale_hi + ((double) clock[1])/tb_scale_lo;
  return (int) ((currtics-basetics)/70);
  }
}

//vonmir
//extern "C" CaptureScreen (char *, byte *);
extern CaptureScreen (char *, byte *);
//

void do_expose ()
{
  if (!Sys->Graph->Memory) return;
  //Sys->Graph.Clear (0); // @@@ ONLY TO SEE IF WE DRAW EVERY PIXEL!
  world.draw (Sys->Graph, &c, &view);
  Sys->Graph->Print();
}

void do_buttonpress (int x, int y, int shift, int alt, int ctrl)
{
  (void)alt;
  (void)ctrl;

  if (c.edit_mode == MODE_POLYGON)
    c.sel_polygon = world.select_polygon (&c, &view, x, y);
  else if (c.edit_mode == MODE_VERTEX)
  {
    Vertex* v = world.select_vertex (&c, &view, x, y);
    if (v)
    {
      if (shift) c.sel_vertex[c.num_sel_verts++] = v;
      else
      {
        c.sel_vertex[0] = v;
        c.num_sel_verts = 1;
      }
    }
  }
}

void do_buttonrelease (int x, int y)
{
  (void)x; (void)y;
}

void do_mousemotion (int x, int y)
{
  (void)x; (void)y;
}

int cnt = 1;
long time0 = -1;

#include <clib/rtgmaster_protos.h>
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>

extern struct RtgScreen *MyScreen;
int mhz;

void video_do_fps()
{
  int x;
  static unsigned int start_time[2] = {0, 0};
  unsigned int end_time[2];
  char msg[4];

  ppctimer (end_time);
  if (end_time[1] >= start_time[1])
    x = (((end_time[1] - start_time[1]) << 2) / mhz);
  else
    x = (((end_time[1] - start_time[1]) << 2) / mhz + 1000000);
  if (x != 0) {
    x = (1000000 + (x >> 1)) / x;   /* round to nearest */
    msg[0] = (x % 1000) / 100 + '0';
    msg[1] = (x % 100) / 10 + '0';
    msg[2] = (x % 10) + '0';
    msg[3] = '\0';
    PPCRtgText(MyScreen,PPCGetBufAdr(MyScreen,0),msg,3,FRAME_WIDTH-24,6);
  }
  start_time[1] = end_time[1];
}

void do_stuff ()
{
  if (show_fps)
  {
   video_do_fps();
  }
  {
   if (cnt <= 0)
  {
    long time1 = I_GetTime();
    if (time0 != -1)
    {
      fps=fps+100./(float)(time1-time0);
      num=num+1;
      //dprintf ("Fps = %f\n", 100./(float)(time1-time0));
    }
    cnt = 100;
    time0 = I_GetTime();
  }
  cnt--;
  }

  world.step_scripts ();
  do_expose ();
}

void perf_test ()
{
  long t1, t2;
  dprintf ("Start performance test at current position!\n");
  t1 = I_GetTime();
  int i;
  for (i = 0 ; i < 100 ; i++)
  {
    world.step_scripts ();
    do_expose ();
  }
  t2 = I_GetTime();
  dprintf ("It took %ld seconds to render 100 frames: %f fps\n",
        t2-t1, 100./(float)(t2-t1));
  cnt = 1;
  time0 = -1;
}

//vonmir
//extern "C" void WritePCX (char *name, char *data, byte *pal, int width,int height);
extern void WritePCX (char *name, char *data, byte *pal, int width,int height);
//

void CaptureScreen (void)
{
        int i = 0;
        char name[255];
        byte pall[768], *pal = pall;

//vonmir
//        do {
//                sprintf (name, "cryst%02d.pcx", i++);
//        } while (i < 100
//#ifndef COMP_WCC
//        && (access (name, 0) == 0)
//#endif
//                        );

//ersatzlos gestrichen
//

        if ( i>= 100) return;
        for (i=0; i<256; i++)
        {
                *pal++ = graphicsPalette[i].red;
                *pal++ = graphicsPalette[i].green;
                *pal++ = graphicsPalette[i].blue;
        }
        WritePCX (name, graphicsData, pall, FRAME_WIDTH, FRAME_HEIGHT);
        dprintf ("Screenshot: %s", name);
}

char* edit_modes[] = { "NONE", "EDIT", "VERTEX", "POLYGON", "MOVE_VERTEX" };

void do_keypress (int key, int shift, int alt, int ctrl)
{
  Vector3* v;

  switch (key)
  {
    case 'b':
      c.turn_around ();
      break;
    case KEY_UP:
      if (alt)
      {
        if (ctrl) c.up (.01);
        else if (shift) c.up (.4);
        else c.up (.2);
      }
      else if (ctrl) c.forward (.01);
      else if (shift) c.forward (.4);
      else c.forward (.2);
      break;
    case KEY_DOWN:
      if (alt)
      {
        if (ctrl) c.down (.01);
        else if (shift) c.down (.4);
        else c.down (.2);
      }
      else if (ctrl) c.backward (.01);
      else if (shift) c.backward (.4);
      else c.backward (.2);
      break;
    case KEY_LEFT:
      if (alt)
      {
        if (ctrl) c.left (.01);
        else if (shift) c.left (.4);
        else c.left (.2);
      }
      else if (ctrl) c.rot_left (.005);
      else if (shift) c.rot_left (.2);
      else c.rot_left (.1);
      break;
    case KEY_RIGHT:
      if (alt)
      {
        if (ctrl) c.right (.01);
        else if (shift) c.right (.4);
        else c.right (.2);
      }
      else if (ctrl) c.rot_right (.005);
      else if (shift) c.rot_right (.2);
      else c.rot_right (.1);
      break;
    case KEY_PGUP:
      if (alt)
      {
        if (ctrl) c.rot_z_left (.005);
        else c.rot_z_left (.1);
      }
      else if (ctrl) c.rot_up (.005);
      else if (shift) c.rot_up (.2);
      else c.rot_up (.1);
      break;
    case KEY_PGDN:
      if (alt)
      {
        if (ctrl) c.rot_z_right (.005);
        else c.rot_z_right (.1);
      }
      else if (ctrl) c.rot_down (.005);
      else if (shift) c.rot_down (.2);
      else c.rot_down (.1);
      break;
    case ' ':
      world.trigger_activate (c);
      break;
    case 'l':
      tex->do_lighting = !tex->do_lighting;
      dprintf ("Lighting '%s'.\n", tex->do_lighting ? "on" : "off");
#if 0
      {
        Vector3 pos;
        c.get_forward_position (6, pos);
        c.sector->add_dyn_light (pos.x, pos.y, pos.z, 7, 1, 0, 0);
      }
#endif
      break;
    case 'a':
        CaptureScreen ();
        break;
    case 'e':
      if (c.edit_mode == MODE_NONE) c.edit_mode = MODE_EDIT;
      else c.edit_mode = MODE_NONE;
      dprintf ("Current mode: %s\n", edit_modes[c.edit_mode]);
      break;
    case 'm':
      if (c.edit_mode == MODE_NONE) break;
      if (c.edit_mode == MODE_VERTEX) c.edit_mode = MODE_POLYGON;
      else if (c.edit_mode == MODE_POLYGON) c.edit_mode = MODE_EDIT;
      else c.edit_mode = MODE_VERTEX;
      dprintf ("Current mode: %s\n", edit_modes[c.edit_mode]);
      break;
    case 'v':
      if (c.edit_mode == MODE_NONE) break;
      if (c.edit_mode == MODE_MOVE_VERTEX) c.edit_mode = MODE_EDIT;
      else c.edit_mode = MODE_MOVE_VERTEX;
      dprintf ("Current mode: %s\n", edit_modes[c.edit_mode]);
      break;
    case 'x':
      if (c.edit_mode != MODE_MOVE_VERTEX && !c.sel_vertex[0]) break;
      v = &c.sel_vertex[0]->get_ov ();
      if (shift) v->x -= .05;
      else v->x += .05;
      c.sel_vertex[0]->set (*v);
      break;
    case 'y':
      if (c.edit_mode != MODE_MOVE_VERTEX && !c.sel_vertex[0]) break;
      v = &c.sel_vertex[0]->get_ov ();
      if (shift) v->y -= .05;
      else v->y += .05;
      c.sel_vertex[0]->set (*v);
      break;
    case 'z':
      if (c.edit_mode != MODE_MOVE_VERTEX && !c.sel_vertex[0]) break;
      v = &c.sel_vertex[0]->get_ov ();
      if (shift) v->z -= .05;
      else v->z += .05;
      c.sel_vertex[0]->set (*v);
      break;
    case 'c':
      dprintf ("==============================================================\n");
      if (shift)
      {
        printf ("SAVE COORDS\n");
        c.save_file ("coord");
      }
      else
      {
        dprintf ("LOAD COORDS\n");
        c.load_file (&world, "coord");
      }
      dprintf ("==============================================================\n");
      break;
    case 's':
      if (alt)
      {
        dprintf ("SAVE LEVEL\n");
        world.save ("world");
        dprintf ("DONE!\n");
      }
      else if (shift)
      {
        dprintf ("LOAD LEVEL\n");
        world.load ("world");
        dprintf ("DONE!\n");
        tex = world.get_textures ();
        tex->alloc_palette (Sys->Graph);
        room = world.get_sector ("room");

        c.m_world2cam.identity ();
        c.v_world2cam.x = 0;
        c.v_world2cam.y = 0;
        c.v_world2cam.z = 0;
        c.sector = room;
      }
      else
      {
        if (c.edit_mode == MODE_NONE) break;
        dprintf ("Split poly\n");
        world.edit_split_poly (&c);
      }
      break;
    case 'q':
        Sys->Shutdown = 1;
        break;
    case 't':
      if (shift)
      {
        switch (tex->mipmapped)
        {
          case 0:
            tex->mipmapped = 1;
            dprintf ("Mipmapping 'on'\n");
            break;
          case 1:
            tex->mipmapped = 2;
            dprintf ("Mipmapping 'always'\n");
            break;
          case 2:
            tex->mipmapped = 0;
            dprintf ("Mipmapping 'off'\n");
            break;
        }
      }
      else if (alt)
      {
        switch (LightMap::setting)
        {
          case MIPMAP_SHADOW_ACCURATE:
            LightMap::setting = MIPMAP_SHADOW_REASONABLE;
            dprintf ("Shadow-mipmapping 'reasonable'\n");
            break;
          case MIPMAP_SHADOW_REASONABLE:
            LightMap::setting = MIPMAP_SHADOW_INACCURATE;
            dprintf ("Shadow-mipmapping 'inaccurate'\n");
            break;
          case MIPMAP_SHADOW_INACCURATE:
            LightMap::setting = MIPMAP_SHADOW_ACCURATE;
            dprintf ("Shadow-mipmapping 'accurate'\n");
            break;
        }
        world.mipmap_settings (LightMap::setting);
      }
      else
      {
        tex->textured = !tex->textured;
        dprintf ("Texture mapping '%s'.\n", tex->textured ? "on" : "off");
      }
      break;
    case 'i':
      cache.dump ();
      break;
    case 'r':
      dprintf ("Refresh (clear) the texture cache.\n");
      cache.clear ();
      break;
    case 'p':
      perf_test ();
      break;
    default:
      break;
  }
}


/*
 * Our main event loop.
 */
void main_loop ()
{
  //render_time = time (NULL);
  Sys->Loop();
  if (num>0) printf("fps = %i\n",fps/num);
}

int func1 (float x)
{
  return QRound (x);
}

int func2 (float x)
{
  return (int)(x+.5);
}

int test (float par)
{
  time_t s1, s2;
  int i;
  int rc1 = 1, rc2 = 1;

  printf ("START (1)\n");
  s1 = I_GetTime();
  for (i = 0 ; i < 10000000 ; i++)
  {
    rc1 = func1 (par);
  }
  s2 = I_GetTime();
  printf ("STOP: %ld\n", s2-s1);

  printf ("START (2)\n");
  s1 = I_GetTime();
  for (i = 0 ; i < 10000000 ; i++)
  {
    rc2 = func2 (par);
  }
  s2 = I_GetTime();
  printf ("STOP: %ld\n", s2-s1);

  printf ("rc1 = %d, rc2 = %d\n", rc1, rc2);

  return 0;
}

/*
 * Main function
 */

int mmu=0;


int main (int argc, char* argv[])
{
#if 0
  // This construction enables short-precision mode in the pentium
  // processor. I read somewhere that this should be faster. As
  // this doesn't seem to give a speed increase in Linux I don't enable it
  // yet. Maybe later when I test it in DOS?
  int OldFPUCW, FPUCW;
  asm volatile ("\
        fstcw (%0)              \n\
        movl (%0),%%eax         \n\
        andl $0xfcff,%%eax      \n\
        movl %%eax,(%1)         \n\
        fldcw (%1)              "
        :
        : "g" (&OldFPUCW), "g" (&FPUCW)
        : "eax");
#endif
  int f;
  show_fps=0;
  mhz=40;
  if (argc>1)
  {
   for (f=1;f<=argc-1;f++)
   {
    if (strstr(argv[f],"-fps"))
    {
     printf("fps-Counter enabled.\n");
     show_fps=1;
    }
    if (strstr(argv[f],"-bus"))
    {
     if (argc-1>f)
     {
      mhz=atoi(argv[f+1]);
      printf("Bus Clock: %i\n",mhz);
     }
    }
    else if (strstr(argv[f],"-mmu"))
    {
     printf("MMU used.\n");
     mmu=1;
    }
    else if (strstr(argv[f],"-thetimer"))
    {
     printf("PPC Timer used.\n");
     thetimer=1;
    }
   }
  }
  tb_scale_lo = ((double)(mhz*1000000 >> 2)) / 35.0;
  tb_scale_hi = (4.294967296E9 / (double)(mhz*1000000 >> 2)) * 35.0;

  extern int test (float);
  //test (3.1415926);

  Matrix3::init ();

  Sys = new System (argc, argv);

  world.load ("world");
  tex = world.get_textures ();
  room = world.get_sector ("room");

  c.m_world2cam.identity ();
  c.v_world2cam.x = 0;
  c.v_world2cam.y = 0;
  c.v_world2cam.z = 0;
  c.sector = room;

  view.add_vertex (3, FRAME_HEIGHT-3);
  view.add_vertex (FRAME_WIDTH-3, FRAME_HEIGHT-3);
  view.add_vertex (FRAME_WIDTH-3, 3);
  view.add_vertex (3, 3);

  printf ("------------------------------------------------------\n");

  Sys->Open();

  tex->alloc_palette (Sys->Graph);
  main_loop ();

  Sys->Close();
  return (1);
}

#include <wbstartup.h>

void wbmain(struct WBStartup * argmsg)
{
 char argv[1][]={"CrystalPPC"};
 int argc=1;
 main(argc,(char **)argv);
}
