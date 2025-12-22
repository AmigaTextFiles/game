#include "c2p.h"
#include <intuition/screens.h>

// abcd efgh ijkl mnop qrst uvwx yzäö üæøë

// AaIiCcKk EeMmGgOo QqYySsÄä UuÜüWwØø
// BbJjDdLl FfNnHhPp RrZzTtÖö VvÆæXxËë

// aeimcgko AEIMCGKO quyüswäø QUYÜSWÄØ
// bfjndhlp BFJNDHLP rvzætxöë RVZÆTXÖË

// alclelglilklmlolqlslulwlylälüløl ahch...
// AlClElGlIlKlMlOlQlSlUlWlYlÄlÜlØl AhCh...
// bldlflhljlllnlplrltlvlxlzlölælël bhdh...
// BlDlFlHlJlLlNlPlRlTlVlXlZlÖlÆlËl BhDh...

void PChk2Pl24(struct BitMap *bitmap,unsigned long *buf,unsigned int x,unsigned int y,unsigned int width,unsigned int height)
{
	unsigned int *ch=(unsigned int *)buf;
	int plmod=bitmap->BytesPerRow-width/2;
	unsigned int offs=y*bitmap->BytesPerRow/4+x/8;
	unsigned int *pl0=(unsigned int *)bitmap->Planes[0]+offs;
	unsigned int *pl1=(unsigned int *)bitmap->Planes[1]+offs;
	unsigned int *pl2=(unsigned int *)bitmap->Planes[2]+offs;
	unsigned int *pl3=(unsigned int *)bitmap->Planes[3]+offs;
	unsigned int *pl4=(unsigned int *)bitmap->Planes[4]+offs;
	unsigned int *pl5=(unsigned int *)bitmap->Planes[5]+offs;
	//unsigned int *pl6=(unsigned int *)bitmap->Planes[6]+offs;
	//unsigned int *pl7=(unsigned int *)bitmap->Planes[7]+offs;
	unsigned int m5=0x55555555;
	unsigned int m3=0x33333333;
	unsigned int mf1=0x00ff00ff;
	unsigned int mf2=0x0f0f0f0f;
	unsigned int a,b,c,d,e,f,g,h;
	unsigned int a1,b1,c1,d1,e1,f1,g1,h1;
	unsigned int t;
	unsigned int i,i2;
	for(i2=0;i2<height;i2++)
	{
		for(i=0;i<width/8;i++)
		{
			a=*ch++;
			a=(a>>2)&0x3f3f3f;
			b=*ch++;
			b=(b>>2)&0x3f3f3f;
			c=*ch++;
			c=(c>>2)&0x3f3f3f;
			d=*ch++;
			d=(d>>2)&0x3f3f3f;
			e=*ch++;
			e=(e>>2)&0x3f3f3f;
			f=*ch++;
			f=(f>>2)&0x3f3f3f;
			g=*ch++;
			g=(g>>2)&0x3f3f3f;
			h=*ch++;
			h=(h>>2)&0x3f3f3f;

			a1=(a&~mf1)|((c&~mf1)>>8);
			b1=(b&~mf1)|((d&~mf1)>>8);
			c1=(e&~mf1)|((g&~mf1)>>8);
			d1=(f&~mf1)|((h&~mf1)>>8);
			e1=(c&mf1)|((a&mf1)<<8);
			f1=(d&mf1)|((b&mf1)<<8);
			g1=(g&mf1)|((e&mf1)<<8);
			h1=(h&mf1)|((f&mf1)<<8);
			
			a=(b1&mf2)|((a1&mf2)<<4);
			b=(a1&~mf2)|((b1&~mf2)>>4);
			c=(d1&mf2)|((c1&mf2)<<4);
			d=(c1&~mf2)|((d1&~mf2)>>4);
			e=(f1&mf2)|((e1&mf2)<<4);
			f=(e1&~mf2)|((f1&~mf2)>>4);
			g=(h1&mf2)|((g1&mf2)<<4);
			h=(g1&~mf2)|((h1&~mf2)>>4);

			a1=a&~m3;
			a1=(a1|(a1<<14))&0xffff0000;
			t=c&~m3;
			a1|=(t|(t<<14))>>16;
			b1=a&m3;
			b1=((b1<<2)|(b1<<16))&0xffff0000;
			t=c&m3;
			b1|=((t<<2)|(t<<16))>>16;

			c1=b&~m3;
			c1=(c1|(c1<<14))&0xffff0000;
			t=d&~m3;
			c1|=(t|(t<<14))>>16;
			d1=b&m3;
			d1=((d1<<2)|(d1<<16))&0xffff0000;
			t=d&m3;
			d1|=((t<<2)|(t<<16))>>16;

			e1=e&~m3;
			e1=(e1|(e1<<14))&0xffff0000;
			t=g&~m3;
			e1|=(t|(t<<14))>>16;
			f1=e&m3;
			f1=((f1<<2)|(f1<<16))&0xffff0000;
			t=g&m3;
			f1|=((t<<2)|(t<<16))>>16;
		
			g1=f&~m3;
			g1=(g1|(g1<<14))&0xffff0000;
			t=h&~m3;
			g1|=(t|(t<<14))>>16;
			h1=f&m3;
			h1=((h1<<2)|(h1<<16))&0xffff0000;
			t=h&m3;
			h1|=((t<<2)|(t<<16))>>16;

			a=(a1&~m5)|((e1&~m5)>>1);
			b=(e1&m5)|((a1&m5)<<1);
			c=(b1&~m5)|((f1&~m5)>>1);
			d=(f1&m5)|((b1&m5)<<1);
			//e=(c1&~m5)|((g1&~m5)>>1);
			//f=(g1&m5)|((c1&m5)<<1);
			g=(d1&~m5)|((h1&~m5)>>1);
			h=(h1&m5)|((d1&m5)<<1);

			*pl0++=d;
			*pl1++=c;
			*pl2++=b;
			*pl3++=a;
			*pl4++=h;
			*pl5++=g;
			//*pl6++=f;
			//*pl7++=e;
		}

		pl0=(unsigned int *)((char *)pl0+plmod);
		pl1=(unsigned int *)((char *)pl1+plmod);
		pl2=(unsigned int *)((char *)pl2+plmod);
		pl3=(unsigned int *)((char *)pl3+plmod);
		pl4=(unsigned int *)((char *)pl4+plmod);
		pl5=(unsigned int *)((char *)pl5+plmod);
		//pl6=(unsigned int *)((char *)pl6+plmod);
		//pl7=(unsigned int *)((char *)pl7+plmod);
	}
}

void PInit24BitMode(struct PDisplay *dp)
{
	struct BitMap *bmp;
	unsigned long *fbp1;
	unsigned long *fbp2;
	long mod;
	int x,y;
	bmp=dp->screenbuf1->sb_BitMap;
	mod=bmp->BytesPerRow;
	fbp1=(unsigned long *)bmp->Planes[6];
	fbp2=(unsigned long *)bmp->Planes[7];
	for(y=0;y<dp->height;y++)
	{
		for(x=0;x<dp->width/8;x++)
		{
			fbp1[x]=0x33333333;
			fbp2[x]=0xeeeeeeee;
		}
		(char *)fbp1+=mod;
		(char *)fbp2+=mod;
	}
	bmp=dp->screenbuf2->sb_BitMap;
	mod=bmp->BytesPerRow;
	fbp1=(unsigned long *)bmp->Planes[6];
	fbp2=(unsigned long *)bmp->Planes[7];
	for(y=0;y<dp->height;y++)
	{
		for(x=0;x<dp->width/8;x++)
		{
			fbp1[x]=0x33333333;
			fbp2[x]=0xeeeeeeee;
		}
		(char *)fbp1+=mod;
		(char *)fbp2+=mod;
	}
	bmp=dp->screenbuf3->sb_BitMap;
	mod=bmp->BytesPerRow;
	fbp1=(unsigned long *)bmp->Planes[6];
	fbp2=(unsigned long *)bmp->Planes[7];
	for(y=0;y<dp->height;y++)
	{
		for(x=0;x<dp->width/8;x++)
		{
			fbp1[x]=0x33333333;
			fbp2[x]=0xeeeeeeee;
		}
		(char *)fbp1+=mod;
		(char *)fbp2+=mod;
	}
}
