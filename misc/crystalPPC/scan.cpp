#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#if defined(PROC_M68K) && defined(COMP_GCC) && !defined(OS_LINUX)
extern void draw_sl_map_m68k_big(void) asm("_draw_sl_map_m68k_big");
#define DRAW_SL_MAP_M68K(XX,TW,TH,SHF_U,D,TMAP,INV_Z,U_DIV_Z,V_DIV_Z,M,J,K)	\
({										\
        {									\
                register int _xx1 __asm("d0") = XX;				\
                register int _tw1 __asm("d1") = TW;				\
                register int _th1 __asm("d2") = TH;				\
                register int _shf_u1 __asm("d3") = SHF_U;			\
                register unsigned char *_d1 __asm("a0") = D;			\
                register unsigned char *_tmap2 __asm("a1") = TMAP;		\
                register float _inv_z1 __asm("fp0") = INV_Z;			\
                register float _u_div_z1 __asm("fp1") = U_DIV_Z;		\
                register float _v_div_z1 __asm("fp2") = V_DIV_Z;		\
                register float _m1 __asm("fp3") = M;				\
                register float _j1 __asm("fp4") = J;				\
                register float _k1 __asm("fp5") = K;				\
                __asm volatile ("jsr _draw_sl_map_m68k_big"			\
                : /* no output */						\
                : "r"(_xx1), "r"(_tw1), "r"(_th1), "r"(_shf_u1), "r"(_d1), "r"(_tmap2), \
                  "r"(_inv_z1), "r"(_u_div_z1), "r"(_v_div_z1), "r"(_m1), "r"(_j1), \
                  "r"(_k1)							\
                : "d0", "d1", "a0", "a1", "fp0", "fp1","cc","memory");		\
   }										\
})
#endif

// The GCC on my Linux/68k box didn't accept more than 10 parameters to
// __asm statement -- amlaukka@cc.helsinki.fi.
#if defined(PROC_M68K) && defined(OS_LINUX)
extern void DRAW_SL_MAP_M68K(   int, int, int, int, unsigned char*,
                                unsigned char*, float, float, float,
                                float, float, float)
                                asm("_draw_sl_map_m68k_big");
#endif

Graphics* Scan::g;
Camera* Scan::c;
Texture* Scan::texture;
Textures* Scan::textures;
unsigned char* Scan::tmap;
int Scan::texnr;
int Scan::tw;
int Scan::th;
int Scan::shf_w, Scan::and_w;
int Scan::shf_h, Scan::and_h;
float Scan::t11, Scan::t12, Scan::t13;
float Scan::t21, Scan::t22, Scan::t23;
float Scan::t31, Scan::t32, Scan::t33;
float Scan::tx, Scan::ty, Scan::tz;
SegmentInfo Scan::sinfo;
unsigned long* Scan::z_buffer = NULL;

unsigned char* Scan::tmap2;
int Scan::tw2;
int Scan::th2;
float Scan::fdu;
float Scan::fdv;
int Scan::shf_u;


void Scan::draw_scanline_flat (int xx, unsigned char* d,
			       unsigned long* z_buf,
			       float inv_z, float u_div_z, float v_div_z,
			       float M, float J1, float K1)
{
  (void)z_buf; (void)inv_z; (void)u_div_z; (void)v_div_z;
  (void)M; (void)J1; (void)K1;
  int color = texnr;
  while (xx > 0)
  {

    *d++ = color;
    xx--;
  }
}

void Scan::draw_scanline (int xx, unsigned char* d,
			  unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1)
{
  (void)z_buf;
  float u1, v1, u, v, z, z1;
  int uu1, vv1, duu, dvv, uu, vv;

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);

  // Some optimizations for processors with many registers (PowerPC, 680x0).
  // Get global variables into registers.
  unsigned long shifter_w = shf_w;
  unsigned long shifter_h = shf_h;
  unsigned long ander_w = and_w;
  unsigned long ander_h = and_h;
  unsigned char* srcTex = tmap;
  unsigned char* lastD;
  unsigned char* dd = d;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;

    u_div_z += J1;
    v_div_z += K1;

    if (xx < INTERPOL_STEP) { lastD = dd + xx; xx = 0; }
    else { lastD = dd + INTERPOL_STEP; xx -= INTERPOL_STEP; }

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;
    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    do
    {
      *dd++ = srcTex[((uu>>shifter_w)&ander_w) + ((vv>>shifter_h)&ander_h)];
      uu += duu;
      vv += dvv;
    }
    while (dd < lastD);
  }
}

#if defined(PROC_M68K) && defined(COMP_GCC)
void Scan::draw_scanline_map( int xx, unsigned char *d,
				unsigned long *z_buf,
				float inv_z, float u_div_z, float v_div_z,
				float M, float J1, float K1)
{
        (void)z_buf;
        DRAW_SL_MAP_M68K( xx, Scan::tw2, Scan::th2, shf_u, d,Scan::tmap2, inv_z, u_div_z, v_div_z, M, J1, K1);
}
#else
void Scan::draw_scanline_map (int xx, unsigned char* d,
			      unsigned long* z_buf,
			      float inv_z, float u_div_z, float v_div_z,
			      float M, float J1, float K1)
{
  (void)z_buf;
  float u1, v1, u, v, z, z1;
  int uu1, vv1, duu, dvv, uu, vv;

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);
  if (uu < 0) uu = 0; else if (uu >= (tw2<<16)) uu = (tw2<<16)-1;
  if (vv < 0) vv = 0; else if (vv >= (th2<<16)) vv = (th2<<16)-1;

  // Some optimizations for processors with many registers (PowerPC, 680x0).
  // Get global variables into registers.
  unsigned long shifter = shf_u;
  unsigned char* srcTex = tmap2;
  unsigned char* lastD;
  unsigned char* dd = d;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;

    u_div_z += J1;
    v_div_z += K1;

    if (xx < INTERPOL_STEP) { lastD = dd + xx; xx = 0; }
    else { lastD = dd + INTERPOL_STEP; xx -= INTERPOL_STEP; }

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;
    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    // Slight rounding errors in floating point can cause this error!
    // @@@ Can't we prevent this some way?
    if (uu1 < 0) uu1 = 0; else if (uu1 >= (tw2<<16)) uu1 = (tw2<<16)-1;
    if (vv1 < 0) vv1 = 0; else if (vv1 >= (th2<<16)) vv1 = (th2<<16)-1;

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    do
    {
      *dd++ = srcTex[((vv>>16)<<shifter) + (uu>>16)];
      uu += duu;
      vv += dvv;
    }
    while (dd < lastD);
  }
}
#endif

#if 0
	movl i,%ecx
	movl tmap2,%esi
	movl d,%edi
	incl %ecx
    .loop:
    	decl %ecx
	jz .end
	movl vv,%edx
	movl %edx,%eax
	sarl $16,%eax
	movl shf_u,%ebx
	sall %bl,%eax
	movl uu,%ebx
	sarl $16,%ebx
	addl %ebx,%eax
	movb (%eax,%esi),%al
	movb %al,(%edi)
	incl %edi

    asm ("\
    	movl %0,%%ecx /*i*/ \
	movl %0,%%esi /*tmap2*/ \
	movl %0,%%edi /*d*/ \
    .loop: \
        testl %%ecx,%%ecx \
	jz .end \
	decl %%ecx \
	movl %0,%%eax /*vv*/ \
	sarl $16,%%eax \
	movl %0,%%edx /*shf_u*/ \
	sall %%edx,%%eax \
	movl %0,%%edx /*uu*/ \
	sarl $16,%%edx \
	addl %%edx,%%eax \
	movb (%%esi,%%eax),%%al \
	movb %%al,(%%edi) \
	incl %%edi \
	jmp .loop \
    .end: \
        movl %%edi,%w0 \
	"
	: "=g" (d)
	: "g" (i), "g" (tmap2), "0" (d), "g" (vv), "g" (shf_u), "g" (uu)
	: "%ecx", "%edx", "%eax", "%ebx", "%edi", "%esi", "cc");
#endif

void Scan::draw_scanline_transp (int xx, unsigned char* d,
				 unsigned long* z_buf,
				 float inv_z, float u_div_z, float v_div_z,
				 float M, float J1, float K1)
{
  (void)z_buf;
  int i;
  float u1, v1, u, v, z, z1;
  int uu1, vv1, duu, dvv, uu, vv;
  unsigned char c;

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);
  if (uu < 0) uu = 0; else if (uu >= (tw2<<16)) uu = (tw2<<16)-1;
  if (vv < 0) vv = 0; else if (vv >= (th2<<16)) vv = (th2<<16)-1;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;

    u_div_z += J1;
    v_div_z += K1;

    i = INTERPOL_STEP;
    if (xx < i) i = xx;
    xx -= i;

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;
    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    // Slight rounding errors in floating point can cause this error!
    // @@@ Can't we prevent this some way?
    if (uu1 < 0) uu1 = 0; else if (uu1 >= (tw2<<16)) uu1 = (tw2<<16)-1;
    if (vv1 < 0) vv1 = 0; else if (vv1 >= (th2<<16)) vv1 = (th2<<16)-1;

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    while (i-- > 0)
    {
      c = tmap[((uu>>shf_w)&and_w) + ((vv>>shf_h)&and_h)];
      if (c) *d++ = c;
      else d++;
      uu += duu;
      vv += dvv;
    }
  }
}

void Scan::draw_scanline_filtered (int xx, unsigned char* d,
				   unsigned long* z_buf,
				   float inv_z, float u_div_z, float v_div_z,
				   float M, float J1, float K1)
{
  (void)z_buf;
  float u1, v1, u, v, z, z1;
  int uu1, vv1, duu, dvv, uu, vv;
  unsigned char c;
  Filter** filters = texture->get_filters ();

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);
  if (uu < 0) uu = 0; else if (uu >= (tw2<<16)) uu = (tw2<<16)-1;
  if (vv < 0) vv = 0; else if (vv >= (th2<<16)) vv = (th2<<16)-1;

  // Some optimizations for processors with many registers (PowerPC, 680x0).
  // Get global variables into registers.
  unsigned long shifter_w = shf_w;
  unsigned long shifter_h = shf_h;
  unsigned long ander_w = and_w;
  unsigned long ander_h = and_h;
  unsigned char* srcTex = tmap;
  unsigned char* lastD;
  unsigned char* dd = d;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;

    u_div_z += J1;
    v_div_z += K1;

    if (xx < INTERPOL_STEP) { lastD = dd + xx; xx = 0; }
    else { lastD = dd + INTERPOL_STEP; xx -= INTERPOL_STEP; }

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;
    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    // Slight rounding errors in floating point can cause this error!
    // @@@ Can't we prevent this some way?
    if (uu1 < 0) uu1 = 0; else if (uu1 >= (tw2<<16)) uu1 = (tw2<<16)-1;
    if (vv1 < 0) vv1 = 0; else if (vv1 >= (th2<<16)) vv1 = (th2<<16)-1;

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    do
    {
      c = srcTex[((uu>>shifter_w)&ander_w) + ((vv>>shifter_h)&ander_h)];
      if (filters[c]) *dd++ = filters[c]->translate (*dd);
      else *dd++ = c;
      uu += duu;
      vv += dvv;
    }
    while (dd < lastD);
  }
}

void Scan::draw_scanline_z_buf_flat (int xx, unsigned char* d,
			       unsigned long* z_buf,
			       float inv_z, float u_div_z, float v_div_z,
			       float M, float J1, float K1)
{
  (void)u_div_z; (void)v_div_z; (void)J1; (void)K1;
  int i;
  int zz1, dzz, zz;
  int color = texnr;

  zz = QInt16 (inv_z);
    
  while (xx > 0)
  {
    inv_z += M;

    i = INTERPOL_STEP;
    if (xx < i) i = xx;
    xx -= i;

    zz1 = QInt16 (inv_z);
    dzz = (zz1-zz)/INTERPOL_STEP;

    while (i-- > 0)
    {
      if (zz > (int)(*z_buf))
      {
	*d++ = color;
	*z_buf = zz;
      }
      else d++;
      z_buf++;
      zz += dzz;
    }
  }
}

void Scan::draw_scanline_z_buf (int xx, unsigned char* d,
				unsigned long* z_buf,
				float inv_z, float u_div_z, float v_div_z,
				float M, float J1, float K1)
{
  float u1, v1, z, z1, u, v;
  int uu1, vv1, duu, dvv, uu, vv;
  long zz, zz1, dzz;

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);
  zz = QInt16 (inv_z);

  // Some optimizations for processors with many registers (PowerPC, 680x0).
  // Get global variables into registers.
  unsigned long shifter_w = shf_w;
  unsigned long shifter_h = shf_h;
  unsigned long ander_w = and_w;
  unsigned long ander_h = and_h;
  unsigned char* srcTex = tmap;
  unsigned char* lastD;
  unsigned long* z_buffer = z_buf;
  unsigned char* dd = d;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;
    zz1 = QInt16 (inv_z);
    dzz = (zz1-zz)/INTERPOL_STEP;

    u_div_z += J1;
    v_div_z += K1;

    if (xx < INTERPOL_STEP) { lastD = dd + xx; xx = 0; }
    else { lastD = dd + INTERPOL_STEP; xx -= INTERPOL_STEP; }

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;

    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);
    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    do
    {
      if (zz > (int)(*z_buffer))
      {
	*dd++ = srcTex[((uu>>shifter_w)&ander_w) + ((vv>>shifter_h)&ander_h)];
	*z_buffer = zz;
      }
      else dd++;
      z_buffer++;
      uu += duu;
      vv += dvv;
      zz += dzz;
    }
    while (dd < lastD);
  }
}

void Scan::draw_scanline_z_buf_map (int xx, unsigned char* d,
				    unsigned long* z_buf,
				    float inv_z, float u_div_z, float v_div_z,
				    float M, float J1, float K1)
{
  float u1, v1, z, z1, u, v;
  int uu1, vv1, duu, dvv, uu, vv;
  long zz, zz1, dzz;

  z = 1 / inv_z;
  u = u_div_z * z;
  v = v_div_z * z;
  uu = QInt16 (u);
  vv = QInt16 (v);

  zz = QInt16 (inv_z);
  if (uu < 0) uu = 0; else if (uu >= (tw2<<16)) uu = (tw2<<16)-1;
  if (vv < 0) vv = 0; else if (vv >= (th2<<16)) vv = (th2<<16)-1;

  // Some optimizations for processors with many registers (PowerPC, 680x0).
  // Get global variables into registers.
  unsigned long shifter = shf_u;
  unsigned char *srcTex = tmap2;
  unsigned long *z_buffer = z_buf;
  unsigned char *lastD;
  unsigned char* dd = d;

  while (xx > 0)
  {
    inv_z += M;
    z1 = 1 / inv_z;
    zz1 = QInt16 (inv_z);

    u_div_z += J1;
    v_div_z += K1;

    if (xx < INTERPOL_STEP) { lastD = dd + xx; xx = 0; }
    else { lastD = dd + INTERPOL_STEP; xx -= INTERPOL_STEP; }

    u1 = u_div_z * z1;
    v1 = v_div_z * z1;

    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    // Slight rounding errors in floating point can cause this error!
    // @@@ Can't we prevent this some way?
    if (uu1 < 0) uu1 = 0; else if (uu1 >= (tw2<<16)) uu1 = (tw2<<16)-1;
    if (vv1 < 0) vv1 = 0; else if (vv1 >= (th2<<16)) vv1 = (th2<<16)-1;

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;
    dzz = (zz1-zz)/INTERPOL_STEP;

    do
    {
      if (zz > (int)(*z_buffer))
      {
	*dd++ = srcTex[((vv>>16)<<shifter) + (uu>>16)];
	*z_buffer = zz;
      }
      else dd++;
      z_buffer++;
      uu += duu;
      vv += dvv;
      zz += dzz;
    }
    while (dd < lastD);
  }
}

#if 0
void Scan::light_scanline (int xx,
			   int uu, int vv,
			   unsigned char* d,
			   float d1, float d2, float dd1, float dd2,
			   float dd_u, float da_u, float dd_v, float da_v,
			   int lu, int lv, int sq_rad)
{
  int i;
  float r, u1, v1;
  int uu1, vv1, duu, dvv;
  int sqd;
  unsigned char* lt;

  while (xx > 0)
  {
    d1 -= dd1;
    d2 += dd2;
    r = d1 / d2;

    i = INTERPOL_STEP;
    if (xx < i) i = xx;
    xx -= i;

    u1 = r*dd_u + da_u;
    v1 = r*dd_v + da_v;

    uu1 = QInt16 (u1);
    vv1 = QInt16 (v1);

    duu = (uu1-uu)/INTERPOL_STEP;
    dvv = (vv1-vv)/INTERPOL_STEP;

    while (i-- > 0)
    {
      sqd = ((uu>>16)-lu)*((uu>>16)-lu) + ((vv>>16)-lv)*((vv>>16)-lv);
      sqd = sq_rad-sqd;
      if (sqd > 0)
      {
	if (sqd > (255-NORMAL_LIGHT_LEVEL)) sqd = 255-NORMAL_LIGHT_LEVEL;
	lt = textures->get_light_table (NORMAL_LIGHT_LEVEL+sqd);
	*d++ = lt[*d];
      }
      uu += duu;
      vv += dvv;
    }
  }
}
#endif

void Scan::init_draw (Polygon3D* p, PolyTexture* tex)
{
  (void)p;
  texnr = tex->get_texnr ();
  texture = textures->get_texture (texnr);
  tmap = texture->get_bitmap ();
  tw = texture->get_width ();
  th = texture->get_height ();

  if (textures->do_lighting) tmap2 = tex->get_bitmap ();
  else tmap2 = NULL;
  tw2 = tex->get_width ();
  th2 = tex->get_height ();
  fdu = tex->get_fdu ();
  fdv = tex->get_fdv ();
  shf_u = tex->get_shf_u ();

  shf_w = texture->get_w_shift ();
  and_w = texture->get_w_mask ();
  shf_h = texture->get_h_shift ();
  and_h = texture->get_h_mask ();

  and_h <<= shf_w;
  shf_h += shf_w;
  shf_w = 16-shf_w;
  shf_h = 16-shf_h;
}

//---------------------------------------------------------------------------
