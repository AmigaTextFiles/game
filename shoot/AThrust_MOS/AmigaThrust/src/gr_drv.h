
/* Written by Peter Ekberg, peda@lysator.liu.se */
/* Amiga extensions by Frank Wille, frank@phoenix.owl.de */

#ifndef GR_DRV_H
#define GR_DRV_H

#ifdef __STDC__

#if defined(AMIGA) && defined(__VBCC__)
#ifdef __PPC__
extern unsigned char *gfxbuf;
void _putpixel(__reg("r3")int, __reg("r4")int, __reg("r5")unsigned char,
               __reg("r6")unsigned char *) =
        "\tmulli\t4,4,320\n"
        "\tadd\t6,6,3\n"
        "\tstbx\t5,6,4";
#define putpixel(x,y,c) _putpixel(x,y,c,gfxbuf)

void _putarea(__reg("r3")unsigned char *, __reg("r4")int, __reg("r5")int,
              __reg("r6")int, __reg("r7")int, __reg("r8")int,
              __reg("r9")int, __reg("r10")int, __reg("r11")unsigned char *) =
        "\tmulli\t10,10,320\n"
        "\tadd\t3,3,4\n"
        "\tadd\t4,11,9\n"
        "\tadd\t4,4,10\n"
        "\tmullw\t5,5,8\n"
        "\tsubi\t4,4,1\n"
        "\tsub\t8,8,6\n"
        "\tli\t9,320\n"
        "\tsub\t9,9,6\n"
        "\tadd\t3,3,5\n"
        "\tsubi\t3,3,1\n"
        "\tmtctr\t6\n"
        "\tlbzu\t5,1(3)\n"
        "\tstbu\t5,1(4)\n"
        "\tbdnz\t$-8\n"
        "\tsubic.\t7,7,1\n"
        "\tadd\t3,3,8\n"
        "\tadd\t4,4,9\n"
        "\tbne\t$-28";
#define putarea(src,sx,sy,w,h,bpr,dx,dy) _putarea(src,sx,sy,w,h,bpr,dx,dy,gfxbuf)

#else /* M68k */
extern unsigned char **ytab;
void _putpixel(__reg("d0")int, __reg("d1")int, __reg("d2")unsigned char,
               __reg("a0")unsigned char **) =
        "\tmove.l\t(a0,d1.l*4),a0\n"
        "\tmove.b\td2,(a0,d0.l)";
#define putpixel(x,y,c) _putpixel(x,y,c,ytab)

void _putarea(__reg("a0")unsigned char *, __reg("d0")int, __reg("d1")int,
              __reg("d2")int, __reg("d3")int, __reg("d4")int,
              __reg("a1")char *, __reg("a2")char *,
              __reg("a3")unsigned char **) =
        "\tmove.l\t(a3,a2.l*4),a2\n"
        "\tmulu\td4,d1\n"
        "\tadd.l\ta2,a1\n"
        "\tadd.l\td1,d0\n"
        "\tadd.l\td0,a0\n"
        "\tsub.l\td2,d4\n"
        "\tmove.w\t#320,a2\n"
        "\tsub.l\td2,a2\n"
        "\tsubq.w\t#1,d3\n"
        "\tmoveq\t#3,d1\n"
        "\tand.w\td2,d1\n"
        "\tbeq.b\t*+20\n"
        "\tsubq.w\t#1,d2\n"
        "\tmove.w\td2,d0\n"
        "\tmove.b\t(a0)+,(a1)+\n"
        "\tdbf\td0,*-4\n"
        "\tadd.l\td4,a0\n"
        "\tadd.l\ta2,a1\n"
        "\tdbf\td3,*-14\n"
        "\tbra.b\t*+20\n"
        "\tlsr.w\t#2,d2\n"
        "\tsubq.w\t#1,d2\n"
        "\tmove.w\td2,d0\n"
        "\tmove.l\t(a0)+,(a1)+\n"
        "\tdbf\td0,*-4\n"
        "\tadd.l\td4,a0\n"
        "\tadd.l\ta2,a1\n"
        "\tdbf\td3,*-14";
#define putarea(src,sx,sy,w,h,bpr,dx,dy) _putarea(src,sx,sy,w,h,bpr,(char *)(dx),(char *)(dy),ytab)
#endif

#else
void putpixel(int x, int y, unsigned char color);
void putarea(unsigned char *source,
      	     int x, int y, int width, int height, int bytesperline,
	           int destx, int desty);
#endif

void clearscr(void);
void syncscreen(void);
void displayscreen(void);
void fade_in(void);
void fade_out(void);
void fadepalette(int first, int last,
		 unsigned char *RGBtable,
		 int fade, int flag);
void graphics_preinit(void);
int graphicsinit(int argc, char **argv);
int graphicsclose(void);
char *graphicsname(void);

#endif

#endif
