#undef BOOL_TYPEDEF
#undef BYTE_TYPEDEF
#undef WORD_TYPEDEF
#include <dos/dosextens.h>
#include <dos/exall.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <proto/intuition.h>
#include <proto/asl.h>
#include <stdarg.h>
#include <stdlib.h>
#include <libraries/asyncio.h>
#include <libraries/mui.h>



extern int CheckGameDirectory(char *dir);


void Amiga_FatalError(const char *message, ...)
{
	char str[1024];

	va_list argp;
	va_start(argp, message);
	vsprintf(str, message, argp);
	va_end(argp);

	struct EasyStruct es;
	es.es_StructSize = sizeof(es);
	es.es_Flags = 0;
	es.es_Title = "Aliens versus Predator Error";
	es.es_TextFormat = str;
	es.es_GadgetFormat = "Quit";
	EasyRequest(0, &es, 0, 0);
	
	exit(EXIT_FAILURE);
}






const char* install_error_msg = "Installation error";

struct fileInfo
{
	char* filename;
	uint  filesize;
	struct fileInfo* next;
};


struct fileInfo* FindAllFilesRecursive(uint* count, char* root)
{
	uint filecount = 0;
	struct fileInfo* first = 0;
	struct fileInfo* last = first;
	
	BPTR srclock;
	struct ExAllControl* excontrol;
	struct ExAllData *ead, *buffer;
	LONG error = 0;
	BOOL exmore;

	BOOL addslash = ((root[strlen(root)-1] != '/') && (root[strlen(root)-1] != ':'));
	

	buffer = AllocMem(512, MEMF_CLEAR);
	if(!buffer)
		return install_error_msg;
	
	srclock = Lock(root, SHARED_LOCK);
	if(srclock)
	{
		excontrol = AllocDosObject(DOS_EXALLCONTROL, NULL);
		if(excontrol)
		{
			excontrol->eac_LastKey = 0;
			do
			{	
				exmore = ExAll(srclock, buffer, 512, ED_NAME|ED_TYPE|ED_SIZE, excontrol);
				error = IoErr();
				if(exmore == NULL && error != ERROR_NO_MORE_ENTRIES)
					break;
					
				if(excontrol->eac_Entries==0)
					continue;
					
				ead = buffer;
				do
				{
					BOOL skip = FALSE;
					struct fileInfo* inf = 0;
					if(ead->ed_Type == -3)
					{
						// file
						if(	(stricmp(ead->ed_Name, "AvP_Classic.exe") == 0) ||
							(stricmp(ead->ed_Name, "AvP_Video.cfg") == 0) ||
							(stricmp(ead->ed_Name, "binkw32.dll") == 0) ||
							(stricmp(ead->ed_Name, "dx_error.log") == 0) ||
							(stricmp(ead->ed_Name, "installscript.vdf") == 0) ||
							(stricmp(ead->ed_Name, "logfile.txt") == 0) ||
							(stricmp(ead->ed_Name, "smackw32.dll") == 0) ||
							(stricmp(ead->ed_Name, "steam_api.dll") == 0) ||
							(stricmp(ead->ed_Name, "avp.exe") == 0) ||
							(stricmp(ead->ed_Name, "ConsoleLog.txt") == 0) ||
							(stricmp(ead->ed_Name, "Uninst.isu") == 0) ||
							(stricmp(ead->ed_Name, "Uninstall.exe") == 0) ||
							(stricmp(ead->ed_Name, "Uninstall.ini") == 0))
							skip = TRUE;

						if(!skip)
						{
							inf = AllocMem(sizeof(struct fileInfo), MEMF_ANY);
							inf->filename = AllocMem(strlen(root)+strlen(ead->ed_Name)+4, MEMF_ANY);
							strcpy(inf->filename, root);
							if(addslash)
								strcat(inf->filename, "/");
							strcat(inf->filename, ead->ed_Name);
							inf->filesize = ead->ed_Size;
							inf->next = 0;
							filecount++;
						}
					}
					else if(ead->ed_Type == 2)
					{
						// folder
						
						if(stricmp(ead->ed_Name, "redist") == 0)
							skip = TRUE;
						
						if(!skip)
						{
							char* newroot = AllocMem(strlen(root)+strlen(ead->ed_Name)+4, MEMF_ANY);
							strcpy(newroot, root);
							if(addslash)
								strcat(newroot, "/");
							strcat(newroot, ead->ed_Name);
							uint subdircount;
							inf = FindAllFilesRecursive(&subdircount, newroot);
							filecount += subdircount;
							FreeMem(newroot);
						}
					}
					
					if(inf)
					{
						if(first==0)
							first = inf;
						else
							last->next = inf;
							
						while(inf->next)
							inf = inf->next;
						last = inf;
						
					}
					
					ead = ead->ed_Next;
				} while(ead);
			} while(exmore);
			
			FreeDosObject(excontrol);
		}
		UnLock(srclock);
	}
	
	FreeMem(buffer);
	
	if(error != ERROR_NO_MORE_ENTRIES)
		Amiga_FatalError(install_error_msg);	
	
	*count = filecount;
	return first;
}


void Amiga_GameDataInstaller()
{
	// Install or Quit dialog
	struct EasyStruct es;
	es.es_StructSize = sizeof(es);
	es.es_Flags = 0;
	es.es_Title = "Aliens versus Predator";
	es.es_TextFormat = "Aliens versus Predator requires original data files from Classic2000 or Gold edition.";
	es.es_GadgetFormat = "Install|Quit";
	if(!EasyRequest(0, &es, 0, 0))
		exit(EXIT_FAILURE);
	

	// Pick folder for original gamedata
    struct FileRequester *fileRequest = (struct FileRequester *) AllocAslRequestTags(ASL_FileRequest, ASL_Hail, "Select folder with original gamedata", (struct TagItem *)TAG_DONE);
    if(!AslRequestTags(fileRequest, ASLFR_InitialWidth, 300, ASLFR_InitialHeight, 350, ASLFR_InitialPattern, "#?", ASLFR_PositiveText, "Install",		(struct TagItem *)TAG_DONE))
		exit(EXIT_FAILURE);


	const char* folder_error_msg = "The selected folder does not contain Aliens versus Predator gamedata";
	
	
	char srcdir[512];
	strcat(srcdir, fileRequest->rf_Dir);
	if(strlen(fileRequest->rf_File)>0)
	{
		// selection must be a folder
		if((fileRequest->rf_File[strlen(fileRequest->rf_File)-1] != '/') && (fileRequest->rf_File[strlen(fileRequest->rf_File)-1] != ':'))
			Amiga_FatalError(folder_error_msg);

		// file selection is a volume so clear directory name
		if(fileRequest->rf_File[strlen(fileRequest->rf_File)-1]==':')
			srcdir[0] = 0;

		// add path separator if folder is set and it isn't a volume
		if(strlen(srcdir)>0 && srcdir[strlen(srcdir)-1] != ':')
			strcat(srcdir, "/");
			
		// add filename
		strcat(srcdir, fileRequest->rf_File);
	}
	if(strlen(srcdir)>0 && srcdir[strlen(srcdir)-1] != '/' && srcdir[strlen(srcdir)-1] != ':')
		strcat(srcdir, "/");
	
	printf("dir = [%s]\n", srcdir);
	
	if(!CheckGameDirectory(srcdir))
		Amiga_FatalError(folder_error_msg);

	

	APTR AP_Installer, WI_Master, GA_Gauge, TO_Text;
	#define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
	AP_Installer = ApplicationObject,
		MUIA_Application_Title         , "AvP-Installer",
		MUIA_Application_Version       , "$VER: AVP-Installer 1.00 (13.10.2013)",
		MUIA_Application_Copyright     , "Copyright ©2013, Anders Granlund",
		MUIA_Application_Author        , "Anders Granlund",
		MUIA_Application_Description   , "Aliens versus Predator Installer",
		MUIA_Application_Base          , "AVPINSTALLER",
		SubWindow, WI_Master = WindowObject,
			MUIA_Window_Title,			"Installing Aliens versus Predator...",
			MUIA_Window_ID,				MAKE_ID('A','V','P','I'),
			MUIA_Window_Width,			400,
			MUIA_Window_AltWidth,		400,
			//MUIA_Window_CloseGadget, 	FALSE,
			MUIA_Window_SizeGadget, 	FALSE,
			WindowContents, VGroup,
			
				Child, TO_Text = TextObject,
					TextFrame,
					MUIA_Background, MUII_TextBack,
					MUIA_Text_Contents, " ",
					End,
		
				Child, GA_Gauge = GaugeObject,
					GaugeFrame,
					MUIA_Gauge_Horiz, TRUE,
					End,
					/*
				Child, ScaleObject,
					MUIA_Scale_Horiz, TRUE,
					End,
					*/
				End,
			End,
		End;
			

	DoMethod(WI_Master,MUIM_Notify,MUIA_Window_CloseRequest,TRUE, AP_Installer,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit);
	set(WI_Master,MUIA_Window_Open,TRUE);

	// enumerate all files
	uint numfiles;
	struct fileInfo* files = FindAllFilesRecursive(&numfiles, srcdir);
	set(GA_Gauge, MUIA_Gauge_Max, numfiles);

	// copy files
	char dir[256];
	uint copiedfiles = 0;
	uint currentfile = 0;
	BOOL abortinstallation = FALSE;
	while(files != 0)
	{
		char* src = files->filename;
		char* dst = &files->filename[strlen(srcdir)];
		char* dir = 0;
		printf("Install: %03d - [%s] --> [%s]\n", copiedfiles, src, dst);

		ULONG sigs = 0;
		if(DoMethod(AP_Installer, MUIM_Application_NewInput, &sigs) == MUIV_Application_ReturnID_Quit)
		{
			set(TO_Text, MUIA_Text_Contents, "Aborting installation...");
			set(GA_Gauge, MUIA_Gauge_Current, numfiles);
			DeleteFile("language.txt");
			abortinstallation = TRUE;
		}

		if(!abortinstallation)
		{
			set(TO_Text, MUIA_Text_Contents, dst);
			set(GA_Gauge, MUIA_Gauge_Current, currentfile);
		
			for(int i=strlen(dst)-1; i>=0; i--)
			{
				if(dst[i]=='/')
				{
					dst[i] = 0;
					BPTR lock = CreateDir(dst);
					if(lock)
						UnLock(lock);
					dst[i] = '/';
					break;
				}
			}

			
			struct AsyncFile* fileIn;
			struct AsyncFile* fileOut;
			LONG num;
			if(fileIn = OpenAsync(src, MODE_READ, (512*1024)))
			{
				if(fileOut = OpenAsync(dst, MODE_WRITE, (512*1024)))
				{
					while((num = ReadCharAsync(fileIn))>=0)
						WriteCharAsync(fileOut, num);
					CloseAsync(fileOut);
					copiedfiles++;
				}
				CloseAsync(fileIn);
			}
		}
		
		struct fileInfo* nextfile = files->next;
		FreeMem(files->filename);
		FreeMem(files);
		files = nextfile;
		currentfile++;
		
	}

	MUI_DisposeObject(AP_Installer);

	if(copiedfiles < numfiles)
		Amiga_FatalError("Failed to install %d files", numfiles-copiedfiles);
		
	// done
	es.es_StructSize = sizeof(es);
	es.es_Flags = 0;
	es.es_Title = "Aliens versus Predator";
	es.es_TextFormat = "Gamedata installation completed.";
	es.es_GadgetFormat = "Play|Quit";
	if(!EasyRequest(0, &es, 0, 0))
		exit(EXIT_FAILURE);
}




