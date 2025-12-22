#include "main.h"
#include <string.h>

void RenderGfx (display *disp, int dontmove);
void InGameInput ();
void PauseMode ();

int NewHiscore (int32 score);
void LoadHiscores ();
void SaveHiscores ();

enum {
	MENU_NEWGAME = 1,
	MENU_HISCORES,
	MENU_QUIT
};

static const char * menubuttons[] = {
	"New Game",
	"Hiscores",
	"Quit",
	NULL
};

static const char * soundeffects[] = {
	"sfx/launch",
	"sfx/nuke",
	NULL
};

void mainloop (void) {
	int i;
	timer *timer = global->timer;
	display *disp = global->disp;
	int32 countdown;
	int reset = FALSE;

	gfx *aiss = NULL;
	int32 aiss_x, aiss_y;
	int32 aiss_dx, aiss_dy;
	//aiss_x = aiss_y = 0;
	aiss_dx = aiss_dy = 2;

	NewMinList(&global->dmglist);
	NewMinList(&global->city);
	NewMinList(&global->missiles);
	NewMinList(&global->antimissiles);

	global->ptr = CreatePointer("gfx/ptr", -9, -9);
	global->bkg = LoadGfxDT("gfx/bkg");
	global->sounds = LoadSndArray(soundeffects);
	global->mainmenu = CreateMainMenu("- Main Menu -", menubuttons);
	global->hiscoreview = CreateHiscoreView();
	aiss = LoadGfxDT("TBImages:boing");

	LoadHiscores();
	if (global->ptr && global->bkg && global->sounds && global->mainmenu && global->hiscoreview
		&& aiss && GenerateCity(20))
	{
		int txt_col, dtxt_col;

		aiss_x %= (640-aiss->width);
		aiss_y %= (480-aiss->height);
		//Printf("AISS w: %ld, h: %ld\n", aiss->width, aiss->height);

		while (global->status != 2) {
			FreeMissiles();
			RenderGfx(disp, TRUE);
			{
				Menu *menu = global->mainmenu;
				ResetMenu(menu);
				RenderMenu(disp, menu);

				while (global->status == 0) {
					WaitTOF();
					ShowDB(disp);
					SetTimer(timer, 0, MENU_MICROS);
					switch (MenuInput(menu)) {
						case MENU_NEWGAME:
							global->status = 1;
							break;
						case MENU_HISCORES:
							global->status = 4;
							break;
						case MENU_QUIT:
							global->status = 2;
							break;
					}
					WaitTimer(timer);
				}
			}

			if (global->status == 4) {
				HiscoreView *hiscoreview = global->hiscoreview;
				RenderGfx(disp, TRUE);

				if (global->flags & GFLG_NEWHISCORE) {
					int pos;
					pos = NewHiscore(global->score);
					ResetMenu(hiscoreview->menu);
					RenderHiscoreView(disp, hiscoreview);
					if (pos >= 0) {
						int done = FALSE;
						VanillaKeys(disp, TRUE);
						BeginEditHiscore(disp, hiscoreview, pos, global->hiscores[pos].name, 9);
						while (!done) {
							WaitTOF();
							ShowDB(disp);
							SetTimer(timer, 0, MENU_MICROS);
							done = EditHiscore(disp, hiscoreview);
							if (global->status != 4) break;
							WaitTimer(timer);
						}
						EndEditHiscore(disp, hiscoreview);
						VanillaKeys(disp, FALSE);
						SaveHiscores();
					}
					global->flags &= ~GFLG_NEWHISCORE;
				}

				ResetMenu(hiscoreview->menu);
				RenderHiscoreView(disp, hiscoreview);

				while (global->status == 4) {
					WaitTOF();
					ShowDB(disp);
					SetTimer(timer, 0, MENU_MICROS);
					switch (MenuInput(hiscoreview->menu)) {
						case 1:
							global->status = 0;
							break;
					}
					WaitTimer(timer);
				}
				continue;
			}

			if (reset) {
				GenerateCity(20);
			}

			global->wave = 0;
			global->score = 0;
			NextWave();
			global->flags &= ~(GFLG_GAMEOVER|GFLG_NEWHISCORE);
			global->flags |= GFLG_NEWWAVE;
			txt_col = -1; dtxt_col = 4;
			countdown = global->delay;
			while (global->status == 1) {
				WaitTOF();
				ShowDB(disp);
				SetTimer(timer, 0, MICROS/2);
				InGameInput();
				RenderGfx(disp, FALSE);

				BlitGfx(disp, aiss, aiss_x, aiss_y);
				AddClearGfx(&global->dmglist, aiss_x, aiss_y, aiss);
				
				aiss_x += aiss_dx;
				aiss_y += aiss_dy;
				if (aiss_x < 0 || (aiss_x+aiss->width) > 640) {
					aiss_dx = -aiss_dx;
					aiss_x += aiss_dx;
				}
				if (aiss_y < 0 || (aiss_y+aiss->height) > 480) {
					aiss_dy = -aiss_dy;
					aiss_y += aiss_dy;
				}

				if ((global->flags & GFLG_GAMEOVER) && !GetHead((struct List *)&global->missiles)) {
					static char *buf = "Game Over";
					int32 tx, ty, tw, th;
					txt_col += dtxt_col;
					if (txt_col > 255) {
						dtxt_col = -dtxt_col; txt_col += dtxt_col;
					} else if (txt_col <= 0) {
						txt_col = 0;
						global->flags &= ~GFLG_GAMEOVER;
						if (global->score > global->hiscores[9].score) {
							global->status = 4; // go to hiscores
							global->flags |= GFLG_NEWHISCORE;
						} else {
							global->status = 0; // go to "main menu"
						}
					}
					DrawMode(disp, DRM_NORMAL, txt_col, txt_col, txt_col, 0xFF);
					tw = TextWidth(disp, buf); th = TextHeight(disp);
					tx = (640 - tw) >> 1; ty = (480 - th) >> 1;
					DrawText(disp, buf, tx, ty, TXT_ALIGN_LEFT);
					AddClearRect(&global->dmglist, tx, ty, tx+tw-1, ty+th-1);
				} else if ((global->flags & GFLG_NEWWAVE) && !GetHead((struct List *)&global->missiles)) {
					char buf[16];
					int32 tx, ty, tw, th;
					txt_col += dtxt_col;
					if (txt_col > 255) {
						dtxt_col = -dtxt_col; txt_col += dtxt_col;
					} else if (txt_col <= 0) {
						txt_col = 0;
						global->flags &= ~GFLG_NEWWAVE;
						if (global->wave > 1) global->score += CalcScore(&global->city);
					}
					DrawMode(disp, DRM_NORMAL, txt_col, txt_col, txt_col, 0xFF);
					SNPrintf(buf, 16, "Wave #%ld\n", global->wave);
					tw = TextWidth(disp, buf); th = TextHeight(disp);
					tx = (640 - tw) >> 1; ty = (480 - th) >> 1;
					DrawText(disp, buf, tx, ty, TXT_ALIGN_LEFT);
					AddClearRect(&global->dmglist, tx, ty, tx+tw-1, ty+th-1);
				}
				WaitTimer(timer);
				if (global->status == 3) {
					PauseMode();
				}
				if (!(global->flags & GFLG_NEWWAVE) && --countdown == 0) {
					if (LaunchMissile()) {
						if (++global->mlaunched == global->mtotal) {
							NextWave();
							global->flags |= GFLG_NEWWAVE;
							txt_col = -1; dtxt_col = 4;
						}
						countdown = global->delay;
					} else if (!GetHead((struct List *)&global->city)) {
						global->flags |= GFLG_GAMEOVER;
						txt_col = -1; dtxt_col = 4;
					} else
						countdown = 1;
				}
			} /* while */

			StopSnd();
			reset = TRUE;
		} /* while */
	} /* if */
	FreeGfx(aiss);
	FreeClearCmds(&global->dmglist);
	FreeMissiles();
	GenerateCity(-1);
	DeleteHiscoreView(global->hiscoreview);
	DeleteMenu(global->mainmenu);
	FreeSndArray(global->sounds);
	FreeGfx(global->bkg);
	SetDisplayPointer(disp, NULL); DeletePointer(global->ptr);
}

void RenderGfx (display *disp, int dontmove) {
	NODE *node, *next;
	DoClearCmds(&global->dmglist, disp);

	{
		static const gradspec grad = {
			GTYP_VERT, DRM_NORMAL,
			{ 0x00, 0x00, 0x00, 0xFF},
			{ 0x7F, 0x7F, 0xFF, 0xFF}
		};
		gfx *gfx = global->bkg;
		int32 y = 480-gfx->height;
		DrawGradient(disp, &grad, 0, y-40, 639, 479);
		BlitGfx(disp, gfx, 0, y);
		//AddClearRect(&global->dmglist, 0, y-40, 639, 479);
	}

	{
		static const gradspec grad = {
			GTYP_VERT, DRM_BLEND,
			{ 0xFF, 0xFF, 0xFF, 0x00},
			{ 0xFF, 0xFF, 0xFF, 0x7F}
		};
		DrawGradient(disp, &grad, 0, 440, 639, 479);
	}

	for (node = global->missiles.mlh_Head; next = node->mln_Succ; node = next) {
		RenderMissile(node, dontmove);
	}
	for (node = global->city.mlh_Head; next = node->mln_Succ; node = next) {
		RenderBuilding(node, dontmove);
	}
	for (node = global->antimissiles.mlh_Head; next = node->mln_Succ; node = next) {
		RenderAntiMissile(node, dontmove);
	}

	{
		char str[16];
		SNPrintf(str, 16, "Score: %ld", global->score);
		DrawMode(disp, DRM_NORMAL, 0xFF, 0xFF, 0xFF, 0x00);
		DrawText(disp, str, 0, 0, TXT_ALIGN_LEFT);
		AddClearRect(&global->dmglist, 0, 0, TextWidth(disp, str)-1, TextHeight(disp)-1);
	}
}

void InGameInput () {
	display *disp = global->disp;
	struct IntuiMessage *msg;

	while (msg = GetGameInput()) {
		switch (msg->Class) {

			case IDCMP_MOUSEBUTTONS:
				if (msg->Code == SELECTDOWN) {
					int32 mx, my;
					mx = msg->MouseX - disp->bounds.MinX;
					my = msg->MouseY - disp->bounds.MinY;

					if (mx >= 0 && my >= 0 &&
						mx < 640 && my < global->skyline)
					{
						LaunchAntiMissile(mx, my);
					}
				}
				break;

		} /* switch */
		ReplyMsg((struct Message *)msg);
	} /* while */
}

void PauseMode () {
	static const char * str[] = {
		//"Continue",
		NULL
	};
	display *disp = global->disp;
	timer *timer = global->timer;
	Menu *menu;
	struct IntuiMessage *msg;
	menu = CreateMainMenu("- PAUSED -", str);
	if (menu) {
		RenderMenu(disp, menu);
		global->status = 3;
		while (global->status == 3) {
			WaitTOF();
			ShowDB(disp);
			SetTimer(timer, 0, MENU_MICROS);
			/*switch (MenuInput(menu)) {
				case 1:
					global->status = 1;
					break;
			}*/
			while (msg = GetGameInput()) {
				switch (msg->Class) {
					case IDCMP_MOUSEBUTTONS:
						if (msg->Code == SELECTDOWN) {
							if (msg->MouseX >= disp->bounds.MinX &&
								msg->MouseY >= disp->bounds.MinY &&
								msg->MouseX <= disp->bounds.MaxX &&
								msg->MouseY <= disp->bounds.MaxY)
							{
								global->status = 1;
							}
						}
						break;
				}
				ReplyMsg((struct Message *)msg);
			}
			WaitTimer(timer);
		}
		DeleteMenu(menu);
	}
}

struct IntuiMessage *GetGameInput () {
	static int winptr = FALSE;
	display *disp = global->disp;
	struct MsgPort *port = disp->win->UserPort;
	struct IntuiMessage *msg;
	int retmsg, toggle = FALSE;

	while (msg = (struct IntuiMessage *)GetMsg(port)) {
		retmsg = TRUE;
		switch (msg->Class) {

			case IDCMP_CLOSEWINDOW:
				global->status = 2;
				retmsg = FALSE;
				break;

			case IDCMP_GADGETUP:
				{
					struct Gadget *gad;
					gad = (struct Gadget *)msg->IAddress;
					switch (gad->GadgetID) {
						case GID_ICONIFY:
							DoIconify(disp);
							retmsg = FALSE;
							break;
					}
				}
				break;

			case IDCMP_MOUSEMOVE:
				if (msg->MouseX < disp->bounds.MinX || msg->MouseY < disp->bounds.MinY ||
					msg->MouseX > disp->bounds.MaxX || msg->MouseY > disp->bounds.MaxY)
				{
					if (winptr) {
						SetDisplayPointer(disp, NULL);
						winptr = FALSE;
					}
				} else {
					if (!winptr) {
						SetDisplayPointer(disp, global->ptr);
						winptr = TRUE;
					}
				}
				break;

			case IDCMP_RAWKEY:
				if (msg->Code & KEYUP) {
					msg->Code -= KEYUP;
					switch (msg->Code) {
					}
				} else {
					if (msg->Qualifier & IEQUALIFIER_REPEAT) break;
					retmsg = FALSE;
					//Printf("Key pressed: %lx\n", msg->Code);
					switch (msg->Code) {

						case KEY_ESCAPE:
							if (global->status == 0)
								global->status = 2;
							else if (global->status == 3)
								global->status = 1;
							else
								global->status = 0;
							break;

						case KEY_RETURN:
							if (msg->Qualifier & (IEQUALIFIER_LALT|IEQUALIFIER_RALT))
								toggle = TRUE;
							else
								retmsg = TRUE;
							break;

						case KEY_PAUSE:
							switch (global->status) {
								case 1:
									global->status = 3;
									break;
								case 3:
									global->status = 1;
									break;
							}
							break;

						default:
							retmsg = TRUE;
							break;

					}
				}
				break;

		}
		if (retmsg)
			break;
		else
			ReplyMsg((struct Message *)msg);
	}
	if (toggle) {
		struct Window *win;
		ToggleFullscreen(disp);
		win = disp->win;
		if (win->MouseX < disp->bounds.MinX || win->MouseY < disp->bounds.MinY ||
			win->MouseX > disp->bounds.MaxX || win->MouseY > disp->bounds.MaxY)
		{
			SetDisplayPointer(disp, NULL);
			winptr = FALSE;
		} else {
			SetDisplayPointer(disp, global->ptr);
			winptr = TRUE;
		}
	}
	return msg;
}

int NewHiscore (int32 score) {
	hiscore *hi = global->hiscores;
	int i, pos;
	for (i = 0, pos = -1; i < 10; i++) {
		if (score > hi->score) {
			pos = i;
			break;
		}
		hi++;
	}
	if (pos >= 0) {
		if (pos < 9) MoveMem(hi, hi+1, (9-pos)*sizeof(hiscore));
		hi->name[0] = '\0';
		hi->score = score;
	}
	return pos;
}

void LoadHiscores () {
	BPTR file;
	memset(global->hiscores, 0, sizeof(hiscore)*10);
	file = Open("hiscores.bin", MODE_OLDFILE);
	if (file) {
		Read(file, global->hiscores, sizeof(hiscore)*10);
		Close(file);
	} else {
		int i;
		hiscore *hi = global->hiscores;
		for (i = 0; i < 10; i++) {
			strcpy(hi->name, "-Empty-");
			hi->score = 0;
			hi++;
		}
	}
}

void SaveHiscores () {
	BPTR file;
	file = Open("hiscores.bin", MODE_NEWFILE);
	if (file) {
		Write(file, global->hiscores, sizeof(hiscore)*10);
		Close(file);
	}
}
