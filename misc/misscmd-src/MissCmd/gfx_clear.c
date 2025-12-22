#include "main.h"

typedef struct {
	NODE node;
	int cmd;
	int32 arg[4];
} ClearCmd;

void AddClearCmd(LIST *dmglist, int cmd_id, int32 arg0, int32 arg1, int32 arg2, int32 arg3) {
	ClearCmd *cmd;
	cmd = CreateNode(sizeof(ClearCmd));
	if (!cmd) return;

	cmd->cmd = cmd_id;
	cmd->arg[0] = arg0; cmd->arg[1] = arg1;
	cmd->arg[2] = arg2; cmd->arg[3] = arg3;

	AddTail((struct List *)dmglist, (struct Node *)cmd);
}

void DoClearCmds (LIST *dmglist, display *disp) {
	ClearCmd *cmd, *next;
	DrawMode(disp, DRM_NORMAL, 0x00, 0x00, 0x00, 0x00);
	for (cmd = (ClearCmd *)dmglist->mlh_Head; next = (ClearCmd *)cmd->node.mln_Succ; cmd = next) {
		switch (cmd->cmd) {
			case CLEAR_RECT:
				DrawRect(disp, cmd->arg[0], cmd->arg[1], cmd->arg[2], cmd->arg[3]);
				break;
			case CLEAR_LINE:
				DrawLine(disp, cmd->arg[0], cmd->arg[1], cmd->arg[2], cmd->arg[3]);
				break;
			case CLEAR_CIRCLE:
				DrawCircle(disp, cmd->arg[0], cmd->arg[1], cmd->arg[2]);
				break;
		}
		DeleteNode(cmd);
	}
	NewMinList(dmglist);
}

void FreeClearCmds (LIST *dmglist) {
	NODE *cmd;
	while (cmd = (NODE *)RemHead((struct List *)dmglist)) DeleteNode(cmd);
	NewMinList(dmglist);
}
