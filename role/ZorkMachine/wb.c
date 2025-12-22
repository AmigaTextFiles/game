#include <workbench/workbench.h>
#include <workbench/startup.h>

#include <clib/exec_protos.h>
#include <clib/icon_protos.h>

#include <string.h>
#include <stdlib.h>

enum	{	FILETYPE_UNKNOWN, FILETYPE_STORY, FILETYPE_BOOKMARK };

extern struct WBStartup	*WBenchMsg;
extern struct Library	*IconBase;
extern struct Screen	*Screen;

extern char		*story_name,
			 print_name[];
extern int		 printer_width;

USHORT IconData[144] =
{
	0x0000,0x0007,0xF000,0x0000,0x0000,0x0007,0xF000,0x0000,
	0xFFFF,0xFFFF,0xFFFF,0xF800,0x8000,0x0067,0xF000,0x1800,
	0x8000,0x0067,0xF000,0x1800,0x8FFF,0xFC67,0xFFFF,0x1800,
	0x8000,0x0067,0xF000,0x1800,0x8FFF,0xFC67,0xFFFF,0x1800,
	0x8000,0x0067,0xF000,0x1800,0x8FFF,0xFC67,0xF000,0x1800,
	0x8000,0x0067,0xFFFF,0x1800,0x8000,0x0067,0xF000,0x1800,
	0x8FFF,0xFC67,0xFFFF,0x1800,0x8000,0x0060,0x0000,0x1800,
	0x8FFF,0xFC67,0xFFFF,0x1800,0x8000,0x0060,0x0000,0x1800,
	0x8000,0x0060,0x0000,0x1800,0xFFFF,0xFFFF,0xFFFF,0xF800,

	0x0000,0x0000,0x0000,0x0000,0x0000,0x0003,0xE000,0x0000,
	0x0000,0x0003,0xE000,0x0000,0x7FFF,0xFF9B,0xEFFF,0xE000,
	0x7FFF,0xFF9B,0xEFFF,0xE000,0x7000,0x039B,0xE000,0xE000,
	0x7FFF,0xFF9B,0xEFFF,0xE000,0x7000,0x039B,0xE000,0xE000,
	0x7FFF,0xFF9B,0xEFFF,0xE000,0x7000,0x039B,0xEFFF,0xE000,
	0x7FFF,0xFF9B,0xE000,0xE000,0x7FFF,0xFF9B,0xEFFF,0xE000,
	0x7000,0x0398,0x0000,0xE000,0x7FFF,0xFF9F,0xFFFF,0xE000,
	0x7000,0x0398,0x0000,0xE000,0x7FFF,0xFF9F,0xFFFF,0xE000,
	0x7FFF,0xFF9F,0xFFFF,0xE000,0x0000,0x0000,0x0000,0x0000
};

struct Image IconImage =
{
	0,0,
	53,18,2,
	IconData,
	0x03,0x00,
	(struct Image *)NULL
};

struct DiskObject DefaultIcon =
{
	WB_DISKMAGIC,
	WB_DISKVERSION,

	(struct Gadget *)NULL,
	323,24,
	53,19,
	0x0005,
	0x0003,
	0x0001,
	(APTR)&IconImage,
	(APTR)NULL,
	(struct IntuiText *)NULL,
	NULL,
	(APTR)NULL,
	NULL,
	(APTR)NULL,

	WBPROJECT,
	(char *)NULL,
	NULL,
	NO_ICON_POSITION,
	NO_ICON_POSITION,
	(struct DrawerData *)NULL,
	(char *)NULL,
	10000
};

char *Args[13];

void
wbtocli(int *argc,char ***argv)
{
	struct DiskObject *Icon;

	memset(Args,0,sizeof(Args));

	*argc = 1;
	*argv = Args;

	Args[0] = WBenchMsg -> sm_ArgList[0] . wa_Name;

	if(!IconBase)
	{
		if(!(IconBase = OpenLibrary("icon.library",37)))
			return;
	}

	if(WBenchMsg -> sm_NumArgs > 1)
	{
		CurrentDir(WBenchMsg -> sm_ArgList[1] . wa_Lock);

		if(Icon = GetDiskObject(WBenchMsg -> sm_ArgList[1] . wa_Name))
		{
			if(Icon -> do_Type == WBPROJECT)
			{
				UBYTE	*Result;
				BYTE	 Type = FILETYPE_UNKNOWN;

				if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"FILETYPE"))
				{
					if(stricmp((char *)Result,"Z3SAVEFILE"))
					{
						if(!stricmp((char *)Result,"Z3STORY"))
						{
							CurrentDir(WBenchMsg -> sm_ArgList[1] . wa_Lock);

							Args[(*argc)++] = "-s";

							if(Args[*argc] = malloc(strlen((char *)Result) + 1))
								strcpy(Args[(*argc)++],(char *)Result);

							Type = FILETYPE_STORY;
						}
					}
					else
						Type = FILETYPE_BOOKMARK;
				}

				if(Type != FILETYPE_UNKNOWN)
				{
					if(FindToolType((UBYTE **)Icon -> do_ToolTypes,"CUSTOMSCREEN"))
						Args[(*argc)++] = "-c";

					if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"PROTOCOLFILE"))
					{
						Args[(*argc)++] = "-p";

						if(Args[*argc] = malloc(strlen((char *)Result) + 1))
							strcpy(Args[(*argc)++],(char *)Result);
					}

					if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"PROTOCOLWIDTH"))
					{
						Args[(*argc)++] = "-w";

						if(Args[*argc] = malloc(strlen((char *)Result) + 1))
							strcpy(Args[(*argc)++],(char *)Result);
					}

					if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"COLOUR0"))
					{
						Args[(*argc)++] = "-k";

						if(Args[*argc] = malloc(strlen((char *)Result) + 1))
							strcpy(Args[(*argc)++],(char *)Result);
					}

					if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"COLOUR1"))
					{
						Args[(*argc)++] = "-l";

						if(Args[*argc] = malloc(strlen((char *)Result) + 1))
							strcpy(Args[(*argc)++],(char *)Result);
					}

					if(Type == FILETYPE_BOOKMARK)
					{
						if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"STORYFILE"))
						{
							Args[(*argc)++] = "-s";

							if(Args[*argc] = malloc(strlen((char *)Result) + 1))
								strcpy(Args[(*argc)++],(char *)Result);
						}

						Args[(*argc)++] = "-r";

						if(Args[*argc] = malloc(strlen(WBenchMsg -> sm_ArgList[1] . wa_Name) + 1))
							strcpy(Args[*argc],WBenchMsg -> sm_ArgList[1] . wa_Name);
						else
							(*argc)--;
					}
				}
			}

			FreeDiskObject(Icon);
		}
	}
	else
	{
		if(Icon = GetDiskObject(WBenchMsg -> sm_ArgList[0] . wa_Name))
		{
			if(Icon -> do_Type == WBTOOL)
			{
				UBYTE *Result;

				if(FindToolType((UBYTE **)Icon -> do_ToolTypes,"CUSTOMSCREEN"))
					Args[(*argc)++] = "-c";

				if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"PROTOCOLFILE"))
				{
					Args[(*argc)++] = "-p";

					if(Args[*argc] = malloc(strlen((char *)Result) + 1))
						strcpy(Args[(*argc)++],(char *)Result);
				}

				if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"PROTOCOLWIDTH"))
				{
					Args[(*argc)++] = "-w";

					if(Args[*argc] = malloc(strlen((char *)Result) + 1))
						strcpy(Args[(*argc)++],(char *)Result);
				}

				if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"COLOUR0"))
				{
					Args[(*argc)++] = "-k";

					if(Args[*argc] = malloc(strlen((char *)Result) + 1))
						strcpy(Args[(*argc)++],(char *)Result);
				}

				if(Result = FindToolType((UBYTE **)Icon -> do_ToolTypes,"COLOUR1"))
				{
					Args[(*argc)++] = "-l";

					if(Args[*argc] = malloc(strlen((char *)Result) + 1))
						strcpy(Args[(*argc)++],(char *)Result);
				}
			}

			FreeDiskObject(Icon);
		}
	}
}

void
saveicon(char *File)
{
	SetProtection(File,FIBF_EXECUTE);

	if(WBenchMsg)
	{
		STATIC UBYTE *Types[8] =
		{
			"FILETYPE=Z3SAVEFILE",
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		};

		STATIC UBYTE Buffer[512],NameBuffer[256],PrinterBuffer[256],WidthBuffer[30],Colour0Buffer[30],Colour1Buffer[30];

		extern BYTE CustomScreen;

		struct DiskObject *Icon;

		UBYTE *Tool,Count = 1;

		if(NameFromLock(WBenchMsg -> sm_ArgList[0] . wa_Lock,NameBuffer,256))
		{
			if(AddPart(NameBuffer,WBenchMsg -> sm_ArgList[0] . wa_Name,256))
				Tool = NameBuffer;
			else
				Tool = WBenchMsg -> sm_ArgList[0] . wa_Name;
		}
		else
			Tool = WBenchMsg -> sm_ArgList[0] . wa_Name;

		Icon = GetDiskObject("Icon.Data");

		Types[Count++] = Buffer;

		if((char *)FilePart(story_name) == story_name)
		{
			strcpy(Buffer,"STORYFILE=");

			if(!GetCurrentDirName(&Buffer[10],500))
				strcpy(&Buffer[10],story_name);
			else
			{
				if(!AddPart(&Buffer[10],story_name,500))
					strcpy(&Buffer[10],story_name);
			}
		}
		else
			sprintf(Buffer,"STORYFILE=%s",story_name);

		Types[Count++] = PrinterBuffer;

		sprintf(PrinterBuffer,"PROTOCOLFILE=%s",print_name);

		Types[Count++] = WidthBuffer;

		sprintf(WidthBuffer,"PROTOCOLWIDTH=%ld",printer_width);

		if(CustomScreen)
		{
			Types[Count++] = "CUSTOMSCREEN";

			if(Screen)
			{
				sprintf(Colour0Buffer,"COLOUR0=%03lx",GetRGB4(Screen -> ViewPort . ColorMap,0));

				Types[Count++] = Colour0Buffer;

				sprintf(Colour1Buffer,"COLOUR1=%03lx",GetRGB4(Screen -> ViewPort . ColorMap,1));

				Types[Count++] = Colour1Buffer;
			}
		}

		Types[Count] = NULL;

		if(Icon)
		{
			Icon -> do_DefaultTool	= Tool;
			Icon -> do_ToolTypes	= (char **)Types;
			Icon -> do_CurrentX	= NO_ICON_POSITION;
			Icon -> do_CurrentY	= NO_ICON_POSITION;

			if(!PutDiskObject(File,Icon))
				ConPutS("*** Could not create icon file ***");

			FreeDiskObject(Icon);
		}
		else
		{
			DefaultIcon . do_DefaultTool	= Tool;
			DefaultIcon . do_ToolTypes	= (char **)Types;

			if(!PutDiskObject(File,&DefaultIcon))
				ConPutS("*** Could not create icon file ***");
		}
	}
	else
		ConPutS("[No icon]\n");
}
