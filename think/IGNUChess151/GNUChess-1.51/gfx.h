#define ODD(N)		((N) & 0x1)

#define FELDBREITE	50
#define FELDHOEHE	50
#define XOFF		21
#define YOFF		426

#define XPOS(X)		(XOFF+(X)*FELDBREITE)
#define YPOS(Y)		(YOFF-((Y)+1)*FELDHOEHE)

#define FCOLOR(X,Y)	(ODD((X)+(Y)) ? COLOR_SFELD : COLOR_WFELD)

#define NX1		(XPOS(8)+6)
#define NY1		(YPOS(7))
#define NX2		(w->Width-7)
#define NY2		(YPOS(4)-3)

#define TX1		(XPOS(8)+6)
#define TY1		(YPOS(3))
#define TX2		(w->Width-7)
#define TY2		(YPOS(-1)-3)

extern struct Image		*Images[];
extern struct IntuiText	*IText_nor,
						*IText_rev;
extern struct Window	*w;
extern struct IntuiText	*Ntxt;
extern struct Screen	*s;
extern struct Image		WFImage;
extern struct Image		SFImage;
extern struct Image		WBWFImage;
extern struct Image		WBSFImage;
extern struct Image		SBWFImage;
extern struct Image		SBSFImage;
extern struct Image		WTWFImage;
extern struct Image		WTSFImage;
extern struct Image		STWFImage;
extern struct Image		STSFImage;
extern struct Image		WSWFImage;
extern struct Image		WSSFImage;
extern struct Image		SSWFImage;
extern struct Image		SSSFImage;
extern struct Image		WLWFImage;
extern struct Image		WLSFImage;
extern struct Image		SLWFImage;
extern struct Image		SLSFImage;
extern struct Image		WDWFImage;
extern struct Image		WDSFImage;
extern struct Image		SDWFImage;
extern struct Image		SDSFImage;
extern struct Image		WKWFImage;
extern struct Image		WKSFImage;
extern struct Image		SKWFImage;
extern struct Image		SKSFImage;
