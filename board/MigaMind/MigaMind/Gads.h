#ifndef GADS_H
#define GADS_H
/****************************************************************************

				Gads.h
								1-5-90
								 Ekke
****************************************************************************/

typedef struct {
		WORD bg_x,bg_y;
		WORD bg_w,bg_h;
		char *bg_text;
		WORD bg_tsize;
		char bg_TPen;
		char bg_BPen;
	       } BGAD;


#define GAD_W 11
#define GAD_H 8
#define SYSGAD_W 35
#define SYSGAD_H GAD_H
#define TEXTPOS_X 2
#define TEXTPOS_Y 7
#define BPEN 1
#define TPEN 2
#define BPEN_S 3
#define TPEN_S 0
#define QUIT 0
#define SHOW 1

#endif /* GADS_H */
