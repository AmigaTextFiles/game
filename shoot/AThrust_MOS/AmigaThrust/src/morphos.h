#ifndef THRUST_MORPHOS_H
#define THRUST_MORPHOS_H

#define	MUIA_Window_DisableKeys 0x80424c36 /* V15 isg ULONG */ /* private */
#define	MUIA_Application_UsedClasses	0x8042e9a7	/* V20 STRPTR *	i..	*/

#define THRUSTTAGBASE   0xad00f000

#define MUIM_Display_GetKey         (THRUSTTAGBASE + 0)
#define MUIM_Display_Update         (THRUSTTAGBASE + 1)
#define MUIM_Display_UpdatePalette  (THRUSTTAGBASE + 2)

struct MUIP_Display_GetKey { ULONG MethodID; ULONG *key; };

typedef enum
{
    DRAW_DIRECT,
    DRAW_OVERLAY,
    DRAW_SCALED
} DRAWMODE;

struct KeyNode
{
    struct MinNode	Node;
    ULONG   Code;
};

struct Display_Data
{
    struct MUI_EventHandlerNode ehnode;
    struct MinList	KeyList;
    DRAWMODE        DrawMode;
    APTR            VLayer;
    struct RastPort RastPort;
    ULONG           pixfmt, width, height;
    UWORD           OverlayColors[256];
    ULONG           ScreenColors[256];
};

#endif /* THRUST_MORPHOS_H */