#define __NOLIBBASE__ 1
#include "main.h"

const char vtag[] = VERSTAG;

void mainloop (void);

globals *global = NULL;

#ifndef __amigaos4__
extern struct Library *SysBase;
#endif

#ifdef NO_UTILITYBASE
struct Library	*UtilityBase;
#endif
struct Library	*IconBase;
struct Library	*WorkbenchBase;
struct Library	*IntuitionBase;
struct Library	*GfxBase;
struct Library	*P96Base;
struct Library	*DataTypesBase;
struct Library	*LayersBase;
struct Library	*DiskfontBase;
#ifdef USE_TITLEBAR_IMAGE
struct Library	*TitlebarImageBase;
#endif

#ifdef __amigaos4__
#ifdef NO_UTILITYBASE
struct UtilityIFace		*IUtility;
#endif
struct IconIFace		*IIcon;
struct WorkbenchIFace	*IWorkbench;
struct IntuitionIFace	*IIntuition;
struct GraphicsIFace	*IGraphics;
struct P96IFace			*IP96;
struct DataTypesIFace	*IDataTypes;
struct LayersIFace		*ILayers;
struct DiskfontIFace	*IDiskfont;
#endif

static int openlibs (void);
static void closelibs (void);

int main () {
	global = AllocMem(sizeof(*global), MEMF_ANY|MEMF_CLEAR);
	if (!global) return 0;

	if (openlibs()) {

	global->icon = GetDiskObjectNew(GAME_EXE_NAME);
	if (global->icon) {
		global->icon->do_CurrentX = global->icon->do_CurrentY = NO_ICON_POSITION;
		global->timer = OpenTimer();
		global->entropy = OpenEntropy();
		if (global->timer && global->entropy) {
			global->disp = CreateDisplay();
			if (global->disp) {
				if (InitAudioEngine()) {
					mainloop();
					CleanupAudioEngine();
				}
				DeleteDisplay(global->disp);
			}
		}
		CloseEntropy(global->entropy);
		CloseTimer(global->timer);
		FreeDiskObject(global->icon);
	}
	FreeMem(global, sizeof(*global));

	}
	closelibs();

	return 0;
}

static int openlibs (void) {
	#ifdef NO_UTILITYBASE
	UtilityBase = OpenLibrary("utility.library", 0);
	if (!UtilityBase) return FALSE;
	#endif
	IconBase = OpenLibrary("icon.library", 0);
	if (!IconBase) return FALSE;
	WorkbenchBase = OpenLibrary("workbench.library", 0);
	if (!WorkbenchBase) return FALSE;
	IntuitionBase = OpenLibrary("intuition.library", 0);
	if (!IntuitionBase) return FALSE;
	GfxBase = OpenLibrary("graphics.library", 0);
	if (!GfxBase) return FALSE;
	P96Base = OpenLibrary("Picasso96API.library", 0);
	if (!P96Base) return FALSE;
	DataTypesBase = OpenLibrary("datatypes.library", 0);
	if (!DataTypesBase) return FALSE;
	LayersBase = OpenLibrary("layers.library", 0);
	if (!LayersBase) return FALSE;
	DiskfontBase = OpenLibrary("diskfont.library", 0);
	if (!DiskfontBase) return FALSE;
	#ifdef USE_TITLEBAR_IMAGE
	TitlebarImageBase = OpenLibrary("images/titlebar.image", 0);
	if (!TitlebarImageBase) return FALSE;
	#endif

	#ifdef __amigaos4__
	#ifdef NO_UTILITYBASE
	IUtility = (struct UtilityIFace *)GetInterface(UtilityBase, "main", 1, NULL);
	if (!IUtility) return FALSE;
	#endif
	IIcon = (struct IconIFace *)GetInterface(IconBase, "main", 1, NULL);
	if (!IIcon) return FALSE;
	IWorkbench = (struct WorkbenchIFace *)GetInterface(WorkbenchBase, "main", 1, NULL);
	if (!IWorkbench) return FALSE;
	IIntuition = (struct IntuitionIFace *)GetInterface(IntuitionBase, "main", 1, NULL);
	if (!IIntuition) return FALSE;
	IGraphics = (struct GraphicsIFace *)GetInterface(GfxBase, "main", 1, NULL);
	if (!IGraphics) return FALSE;
	IP96 = (struct P96IFace *)GetInterface(P96Base, "main", 1, NULL);
	if (!IP96) return FALSE;
	IDataTypes = (struct DataTypesIFace *)GetInterface(DataTypesBase, "main", 1, NULL);
	if (!IDataTypes) return FALSE;
	ILayers = (struct LayersIFace *)GetInterface(LayersBase, "main", 1, NULL);
	if (!ILayers) return FALSE;
	IDiskfont = (struct DiskfontIFace *)GetInterface(DiskfontBase, "main", 1, NULL);
	if (!IDiskfont) return FALSE;
	#endif

	return TRUE;
}

static void closelibs (void) {
	#ifdef __amigaos4__
	DropInterface((struct Interface *)IDiskfont);
	DropInterface((struct Interface *)ILayers);
	DropInterface((struct Interface *)IDataTypes);
	DropInterface((struct Interface *)IP96);
	DropInterface((struct Interface *)IGraphics);
	DropInterface((struct Interface *)IIntuition);
	DropInterface((struct Interface *)IWorkbench);
	DropInterface((struct Interface *)IIcon);
	#ifdef NO_UTILITYBASE
	DropInterface((struct Interface *)IUtility);
	#endif
	#endif

	#ifdef USE_TITLEBAR_IMAGE
	CloseLibrary(TitlebarImageBase);
	#endif
	CloseLibrary(DiskfontBase);
	CloseLibrary(LayersBase);
	CloseLibrary(DataTypesBase);
	CloseLibrary(P96Base);
	CloseLibrary(GfxBase);
	CloseLibrary(IntuitionBase);
	CloseLibrary(WorkbenchBase);
	CloseLibrary(IconBase);
	#ifdef NO_UTILITYBASE
	CloseLibrary(UtilityBase);
	#endif
}
