#ifndef GFX_CLEAR_H
#define GFX_CLEAR_H

enum {
	CLEAR_RECT = 0,
	CLEAR_LINE,
	CLEAR_CIRCLE
};

/* gfx_clear.h */
#define AddClearGfx(dmglist,x,y,gfx) AddClearRect(dmglist,x,y,(x)+(gfx)->width-1,(y)+(gfx)->height-1)
#define AddClearRect(dmglist,x1,y1,x2,y2) AddClearCmd(dmglist,CLEAR_RECT,x1,y1,x2,y2)
#define AddClearLine(dmglist,x1,y1,x2,y2) AddClearCmd(dmglist,CLEAR_LINE,x1,y1,x2,y2)
#define AddClearCircle(dmglist,cx,cy,r) AddClearCmd(dmglist,CLEAR_CIRCLE,cx,cy,r,0)
void AddClearCmd(LIST *dmglist, int cmd_id, int32 arg0, int32 arg1, int32 arg2, int32 arg3);
void DoClearCmds (LIST *dmglist, display *disp);
void FreeClearCmds (LIST *dmglist);

#endif
