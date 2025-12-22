#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>
#include <proto/muimaster.h>
#include <proto/multimedia.h>
#include <proto/locale.h>
#include <dos/dos.h>
#include <workbench/startup.h>
#include <libraries/asl.h>
#include <workbench/workbench.h>

#include <clib/debug_protos.h>

#include "main.h"
#include "application.h" 
#include "sudokuarea.h"
#include "prefswin.h"

/// structures, defines

extern struct Library *SysBase;
extern struct Library *DOSBase;

struct Library *MUIMasterBase;
struct Library *IntuitionBase;
struct Library *LocaleBase;
struct Library *GfxBase;
struct Library *UtilityBase;
struct Library *CyberGfxBase;
struct Library *RandomBase;

struct Catalog *Cat;

Object *PrefsWin;

STRPTR UsedClasses[] = {0};


///=============================================================================
/// GetResources()
//==============================================================================

BOOL GetResources(void)
{
	if (!(UtilityBase = OpenLibrary((STRPTR)"utility.library", 50))) return FALSE;
	if (!(GfxBase = OpenLibrary((STRPTR)"graphics.library", 50))) return FALSE;
	if (!(IntuitionBase = OpenLibrary((STRPTR)"intuition.library", 50))) return FALSE;
	if (!(MUIMasterBase = OpenLibrary((STRPTR)"muimaster.library", 20))) return FALSE;
	if (!(LocaleBase = OpenLibrary((STRPTR)"locale.library", 50))) return FALSE;
	if (!(CyberGfxBase = OpenLibrary((STRPTR)"cybergraphics.library", 50))) return FALSE;
	if (!(RandomBase = OpenLibrary((STRPTR)"random.library", 1))) return FALSE;
	Cat = OpenCatalog(NULL, (STRPTR)"sudominator.catalog", TAG_END);
	if (!CreateApplicationClass()) return FALSE;
	if (!CreateSudokuAreaClass()) return FALSE;
	if (!CreatePrefsWinClass()) return FALSE;
	return TRUE;
}


///=============================================================================
/// FreeResources()
//==============================================================================

void FreeResources(void)
{
	if (PrefsWinClass) DeletePrefsWinClass();
	if (SudokuAreaClass) DeleteSudokuAreaClass();
	if (ApplicationClass) DeleteApplicationClass();
	CloseCatalog(Cat);
	if (RandomBase) CloseLibrary(RandomBase);
	if (CyberGfxBase) CloseLibrary(CyberGfxBase);
	if (LocaleBase) CloseLibrary(LocaleBase);
	if (MUIMasterBase) CloseLibrary(MUIMasterBase);
	if (IntuitionBase) CloseLibrary(IntuitionBase);
	if (GfxBase) CloseLibrary(GfxBase);
	if (UtilityBase) CloseLibrary(UtilityBase);
	return;
}


///=============================================================================
/// DoSuperNewM()
//==============================================================================

Object* DoSuperNewM(Class *cl, Object *obj, ...)
{
	va_list args, args2;
	int argc = 0;
	uint32_t tag;
	intptr_t val;
	Object *result = NULL;

	__va_copy(args2, args);

	va_start(args, obj);

	do
	{
		tag = va_arg(args, uint32_t);
		val = va_arg(args, intptr_t);
		argc++;
	}
	while (tag != TAG_MORE);

	va_end(args);

	{
		struct TagItem tags[argc];
		int i;

		va_start(args2, obj);

		for (i = 0; i < argc; i++)
		{
			tags[i].ti_Tag = va_arg(args2, uint32_t);
			tags[i].ti_Data = va_arg(args2, intptr_t);
		}

		va_end(args2);

		result = (Object*)DoSuperMethod(cl, obj, OM_NEW, (intptr_t)tags);
	}
	return result;
}


///=============================================================================
/// MUI_NewObjectM()
//==============================================================================

Object* MUI_NewObjectM(char *classname, ...)
{
	va_list args, args2;
	int argc = 0;
	uint32_t tag;
	intptr_t val;
	Object *result = NULL;

	__va_copy(args2, args);

	va_start(args, classname);

	while ((tag = va_arg(args, uint32_t)) != TAG_END)
	{
		val = va_arg(args, intptr_t);
		argc++;
	}

	va_end(args);

	{
		struct TagItem tags[argc + 1];  // one for {TAG_END, 0}
		int i;

		va_start(args2, classname);

		for (i = 0; i < argc; i++)
		{
			tags[i].ti_Tag = va_arg(args2, uint32_t);
			tags[i].ti_Data = va_arg(args2, intptr_t);
		}

		tags[argc].ti_Tag = TAG_END;
		tags[argc].ti_Data = 0;

		va_end(args2);

		result = (Object*)MUI_NewObjectA(classname, tags);
	}
	return result;
}


///=============================================================================
/// NewObjectM()

Object* NewObjectM(Class *cl, char *classname, ...)
{
	va_list args, args2;
	LONG argc = 0;
	ULONG tag;
	IPTR val;
	Object *result = NULL;

	__va_copy(args2, args);

	va_start(args, classname);

	while ((tag = va_arg(args, ULONG)) != TAG_END)
	{
		val = va_arg(args, IPTR);
		argc++;
	}

	va_end(args);

	{
		struct TagItem tags[argc + 1];  // one for {TAG_END, 0}
		LONG i;

		va_start(args2, classname);

		for (i = 0; i < argc; i++)
		{
			tags[i].ti_Tag = va_arg(args2, ULONG);
			tags[i].ti_Data = va_arg(args2, IPTR);
		}

		tags[argc].ti_Tag = TAG_END;
		tags[argc].ti_Data = 0;

		va_end(args2);

		result = NewObjectA(cl, (STRPTR)classname, tags);
	}
	return result;
}


///
/// xget()

IPTR xget(Object *obj, ULONG attr)
{
	IPTR value;

	GetAttr(attr, obj, &value);
	return value;
}


///
/// BuildGui()
//==============================================================================

Object *BuildGui(void)
{
	Object *application;

	application = NewObjectM(ApplicationClass->mcc_Class, 0,
		MUIA_Application_Author, (ULONG)APP_AUTHOR,
		MUIA_Application_Base, (ULONG)APP_BASE,
		MUIA_Application_Copyright, (ULONG)"(c) " APP_CYEARS " " APP_AUTHOR,
		MUIA_Application_Description, (ULONG)LCS(MSG_APPLICATION_DESCRIPTION, APP_DESC),
		MUIA_Application_Title, (ULONG)APP_NAME,
		MUIA_Application_UsedClasses, (ULONG)UsedClasses,
		MUIA_Application_Version, (ULONG)"$VER: " APP_NAME " " APP_VER " (" APP_DATE ")",
	TAG_END);

	return application;
}


///=============================================================================
/// Main()
//==============================================================================

ULONG Main(UNUSED struct WBStartup *wbmessage)
{
	ULONG result = RETURN_OK;
	Object *application = 0;

	if (GetResources())
	{
		if (application = BuildGui())
		{
			DoMethod(application, MUIM_Application_Load, (IPTR)MUIV_Application_Load_ENV);
			DoMethod(application, APPM_Notifications);
			DoMethod(application, APPM_MainLoop);
			MUI_DisposeObject(application);
		}
	}
	else result = RETURN_FAIL;

	FreeResources();
	return result;
}

///=============================================================================

