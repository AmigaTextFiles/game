#include <stdio.h>
#include <stdarg.h>
#include <string.h>

#define	MAXSTRSLEN	1024;


#define	RGB(r,g,b)	 ((((r)>>3)<<10) | (((g)>>3)<<5) | ((b)>>3))

#define	SCREEN_WIDTH	480
#define	SCREEN_HEIGHT	272
#define	SCREEN_PITCH	512

#define	FONT_SIZE	10

#define	CXMAX	(SCREEN_WIDTH/(FONT_SIZE/2))
#define	CYMAX	(SCREEN_HEIGHT/FONT_SIZE)

extern const unsigned char hankaku_font10[];

//extern unsigned short* vramaddr(int x,int y);
static unsigned short* vramaddr(int x,int y)
{
	return (unsigned short*)0x44000000 + x + y*SCREEN_PITCH;
}

void draw_char(unsigned short *dst,int ch,int color)
{
	if (ch<0x20) {
		ch = 0;
	} else if (ch<0x80) {
		ch -= 0x20;
	} else if (ch<0xa0) {
		ch = 0;
	} else {
		ch -= 0x40;
	}

	if (ch==0) return;

	const unsigned char * src = &hankaku_font10[ch*FONT_SIZE];
	int x,y;
	for(y=0;y<FONT_SIZE;y++) {
		unsigned bits = *src++;
		for(x = 0; x<FONT_SIZE/2; x++) {
			if (bits&1) dst[x] = color;
			// else dst[x] = RGB(0,0,0);
			bits>>=1;
//
		}
		dst += SCREEN_PITCH;
	}
}

void draw_str(int x0,int y0,const char* str,int color)
{
	const char *p = str;
	int ch;

	unsigned short *dst = vramaddr(x0,y0);

	while((ch=*p++)!=0) {
		draw_char(dst,ch,color);
		dst+=FONT_SIZE/2;
	}
}

static void scrollup()
{
	memcpy(vramaddr(0,0),vramaddr(0,10),SCREEN_PITCH*(CYMAX-1)*FONT_SIZE*2);
	memset(vramaddr(0,(CYMAX-1)*FONT_SIZE),0,SCREEN_PITCH*FONT_SIZE*2);
}

static int cx,cy;
void dbg_putc(int ch)
{
	unsigned short *dst = vramaddr(cx*(FONT_SIZE/2),cy*FONT_SIZE);

	if (ch == '\n') {
		cx = 0; cy++;
	} else {
		draw_char(dst,ch,RGB(255,255,255));
		cx++;
		if (cx>=CXMAX) {
			cx = 0; cy++;
		}
	}
	if (cy>=CYMAX) {
		cy = CYMAX-1; scrollup();
	}
}

int dbg_write(const char* buf,int len)
{
	int i;
	for(i=0;i<len;i++) dbg_putc(buf[i]);
}

void dbg_puts(const char *buf)
{
	const char *p = buf;
	int ch;
	while((ch=*p++)!=0) dbg_putc(ch);
}

int dbg_vprintf(const char *fmt,va_list argp)
{
	char buf[1024];

	int ret = vsprintf(buf,fmt,argp);
	dbg_write(buf,ret);
	return ret;
}

int dbg_printf(const char *fmt,...)
{
	int ret;
	va_list         argp;
	va_start (argp,fmt);
	ret = dbg_vprintf (fmt,argp);
	va_end (argp);

	return ret;
}
