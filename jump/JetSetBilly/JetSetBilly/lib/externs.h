
extern SHORT			SWidth, SHeight, SDepth;
extern USHORT			SMode;
extern ULONG			SFlags;

extern struct IntuitionBase	*IntuitionBase;
extern struct Library		*LayersBase;
extern struct GfxBase		*GfxBase;
extern struct ViewPort		*vp;
extern struct RastPort		*rp;
extern struct TmpRas		tmpras;
extern struct Screen		*screen;
extern struct Window		*window;
extern struct BitMap		*mybitmaps[2];
extern WORD			toggleframe;
extern struct Library		*ConsoleDevice;
extern int			tick;
extern char			*inkey;
extern unsigned int		incode;
extern USHORT			rawkey;
extern int			inpos;
extern struct IOStdReq		*writereq;
extern struct MsgPort		*writeport;
extern char			buf[512];
extern char			inbuf[512];

extern ULONG			cursor_keys;

extern USHORT			msg_code;
extern SHORT			mousex, mousey;

/* Own flags */
#define DOUBLE_BUFFER		(1)
#define REDIR_SYSREQ		(1<<1)
#define SCREEN_QUIET		(1<<2)

/* incode (Qualifiers) */
#define KEY_LEFT_SHIFT		0x00000001
#define KEY_RIGHT_SHIFT		0x00000002
#define KEY_CAPS_LOCK		0x00000004
#define KEY_CTRL		0x00000008
#define KEY_LEFT_ALT		0x00000010
#define KEY_RIGHT_ALT		0x00000020
#define KEY_LEFT_AMIGA		0x00000040
#define KEY_RIGHT_AMIGA		0x00000080
#define KEY_NUMERIC_PAD		0x00000100
#define KEY_REPEAT		0x00000200
#define KEY_INTERRUPT		0x00000400
#define KEY_MULTI_BROADCAST	0x00000800
#define KEY_MIDDLE_MOUSE_BUTTON	0x00001000
#define KEY_RIGHT_MOUSE_BUTTON	0x00002000
#define KEY_LEFT_MOUSE_BUTTON	0x00004000
#define KEY_RELATIVE_MOUSE	0x00008000
/* Own additions */
#define KEY_FUNCTION		0x00010000
#define KEY_CURSOR		0x00020000
#define KEY_HELP		0x00040000
/* Cursor key kept down */
#define CUR_DOWN		0x00100000
#define CUR_UP			0x00200000
#define CUR_LEFT		0x00400000
#define CUR_RIGHT		0x00800000
/* Mouse buttons (leave a bit for possible middle button) */
#define MOUSE_SELECT_BUTTON	0x01000000
#define MOUSE_MENU_BUTTON	0x04000000
