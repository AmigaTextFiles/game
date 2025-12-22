/*	Map Info: Parse entity and texture info from Quake 2 map files.
	Copyright 2010 C.D. Reimer (Email: webmaster@cdreimer-associates.com)

	Quake 2 is owned by Id Software LLC.  Other than glancing at the map
	file to determine parsing pattern, Map Info does not incoporate any
	code written by Id Software under the GNU General Public License.
	http://www.idsoftware.com/business/idtech2/

	This file is part of Map Info.

    Map Info is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Map Info is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Map Info.  If not, see <http://www.gnu.org/licenses/>.

*/



#define _CRT_SECURE_NO_DEPRECATE	/* turns off Microsoft Visual Studio warnings */

#define TRUE 1
#define FALSE 0

#define CL_HELP "for more options: mapinfo [-h | --help]"
#define CL_FILE_CONTAINS_NO_DATA "mapinfo: file contains no usable data"
#define CL_ILLEGAL_OPTION "mapinfo: illegal option -- "
#define CL_MISSING_FILENAME "mapinfo: missing required filename"

#define CL_OPT_BA "[-A | --alphabetical]"
#define CL_OPT_BA_DESC "display index in alphabetical order"
#define CL_OPT_BA_LONG "--alphabetical"
#define CL_OPT_BA_SHORT "-A"

#define CL_OPT_LA "[-a | --ascending]"
#define CL_OPT_LA_DESC "sort in ascending order"
#define CL_OPT_LA_LONG "--ascending"
#define CL_OPT_LA_SHORT "-a"

#define CL_OPT_BD "[-D | --double]"
#define CL_OPT_BD_DESC "display output in double column (DEFAULT)"
#define CL_OPT_BD_LONG "--double"
#define CL_OPT_BD_SHORT "-D"

#define CL_OPT_LD "[-d | --descending]"
#define CL_OPT_LD_DESC "display in descending order (DEFAULT)"
#define CL_OPT_LD_LONG "--descending"
#define CL_OPT_LD_SHORT "-d"

#define CL_OPT_LE "[-e | --entities]"
#define CL_OPT_LE_DESC "display only entities in a single column"
#define CL_OPT_LE_LONG "--entities"
#define CL_OPT_LE_SHORT "-e"

#define CL_OPT_BF "[-F | --formatted]"
#define CL_OPT_BF_DESC "display formatted output (DEFAULT)"
#define CL_OPT_BF_LONG "--formatted"
#define CL_OPT_BF_SHORT "-F"

#define CL_OPT_LF "[-f | --filename]"
#define CL_OPT_LF_DESC "map file name (REQUIRED)"
#define CL_OPT_LF_LONG "--filename"
#define CL_OPT_LF_SHORT "-f"

#define CL_OPT_LH "[-h | --help]"
#define CL_OPT_LH_DESC "display this help summary"
#define CL_OPT_LH_LONG "--help"
#define CL_OPT_LH_SHORT "-h"

#define CL_OPT_LL "[-l | --license]"
#define CL_OPT_LL_DESC "display license information"
#define CL_OPT_LL_LONG "--license"
#define CL_OPT_LL_SHORT "-l"

#define CL_OPT_BN "[-N | --numerical]"
#define CL_OPT_BN_DESC "display index in numerical order (DEFAULT)"
#define CL_OPT_BN_LONG "--numerical"
#define CL_OPT_BN_SHORT "-N"

#define CL_OPT_BR "[-R | --raw]"
#define CL_OPT_BR_DESC "display output unformatted"
#define CL_OPT_BR_LONG "--raw"
#define CL_OPT_BR_SHORT "-R"

#define CL_OPT_BS "[-S | --single]"
#define CL_OPT_BS_DESC "display output in a single column"
#define CL_OPT_BS_LONG "--single"
#define CL_OPT_BS_SHORT "-S"

#define CL_OPT_LT "[-t | --textures]"
#define CL_OPT_LT_DESC "display only textures in single column"
#define CL_OPT_LT_LONG "--textures"
#define CL_OPT_LT_SHORT "-t"

#define CL_OPT_LU "[-u | --unordered]"
#define CL_OPT_LU_DESC "display without sorting, ignoring either -A or -N"
#define CL_OPT_LU_LONG "--unordered"
#define CL_OPT_LU_SHORT "-u"

#define CL_OPT_LV "[-v | --version]"
#define CL_OPT_LV_DESC "display version number"
#define CL_OPT_LV_LONG "--version"
#define CL_OPT_LV_SHORT "-v"

#define CL_OPT_SPACER "%-20s\t%s\n"
#define CL_OPT_USAGE "usage: mapinfo [-options | --options] [-f | --filename] filename"

#define CL_OUT_BLANK ""
#define CL_OUT_COPYRIGHT "2010 (c) C.D. Reimer (webmaster@cdreimer-associates.com)"

#define CL_OUT_GNU_A1 " is free software: you can redistribute it and/or modify"
#define CL_OUT_GNU_A2 "it under the terms of the GNU General Public License as published by"
#define CL_OUT_GNU_A3 "the Free Software Foundation, either version 3 of the License, or"
#define CL_OUT_GNU_A4 "at your option) any later version."

#define CL_OUT_GNU_B1 " is distributed in the hope that it will be useful,"
#define CL_OUT_GNU_B2 "but WITHOUT ANY WARRANTY; without even the implied warranty of"
#define CL_OUT_GNU_B3 "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
#define CL_OUT_GNU_B4 "GNU General Public License for more details."

#define CL_OUT_GNU_C1 "You should have received a copy of the GNU General Public License"
#define CL_OUT_GNU_C2 "along with "
#define CL_OUT_GNU_C3 ".  If not, see <http://www.gnu.org/licenses/>."

#define CL_OUT_HEADER1 "Released under GNU General Public License v3+."
#define CL_OUT_HEADER2 "Type -l or -license to see full license."

#define CL_OUT_ID1 "Quake 2 is owned by Id Software LLC.  Other than glancing at the map"
#define CL_OUT_ID2 "file to determine parsing pattern, Map Info does not incoporate any"
#define CL_OUT_ID3 "code written by Id Software under the GNU General Public License."
#define CL_OUT_ID4 "http://www.idsoftware.com/business/idtech2/"

#define CL_OUT_MAPFILE "Map File: "
#define CL_OUT_MAPFILE_DESC "Parse entity and texture info from Quake 2 map files."
#define CL_OUT_MAPINFO "Map Info"
#define CL_OUT_TOTAL_REF "Total References: "
#define CL_OUT_VERSION "Version 1.0.0 - 2010/02/24"

#define CL_TOO_MANY_COLUMN_OPTIONS "mapinfo: too many column options - only one is allowed"
#define CL_TOO_MANY_INDEX_OPTIONS "mapinfo: too many index options - only one is allowed"
#define CL_TOO_MANY_OUTPUT_OPTIONS "mapinfo: too many column options - only one is allowed"
#define CL_TOO_MANY_SORT_OPTIONS "mapinfo: too many sort options - only one is allowed"
#define CL_TOO_MANY_TYPE_OPTIONS "mapinfo: too many type options - only one is allowed"

#define ERROR_FORMAT "%s%s\n"
#define ERROR_MSG "mapinfo: ERROR"
#define ERROR_MSG_CI1 "[index.c:CreateIndex()] Memory Allocation Failure"
#define ERROR_MSG_CLB1 "[buffer.c:CreateLineBuffer()] Memory Allocation Failure"
#define ERROR_MSG_LFB1 "[buffer.c:LoadFileBuffer()] Invalid Filename"
#define ERROR_MSG_LFB2 "[buffer.c:LoadFileBuffer()] File Does Not Exist"
#define ERROR_MSG_LFB3 "[buffer.c:LoadFileBuffer()] Memory Allocation Failure"
#define ERROR_MSG_LFB4 "[buffer.c:LoadFileBuffer()] File Has Zero Bytes"
#define ERROR_MSG_SP1 "[index.c - SwapPtrs()] Memory Allocation Failure"

#define LINEBUFFER_SIZE 80
#define NAME_E "Entities"
#define NAME_FORMAT "%-25s"
#define NAME_SIZE 25
#define NAME_T "Textures"
#define SPACER "------------------------------------------------------------------------------"


/* 									  	*/
/*  struct declarations					*/
/*                     					*/

struct node
{
	char item[NAME_SIZE + 1];
	unsigned int count;
	struct node *next;
};

struct list
{
	char name[NAME_SIZE + 1];
	unsigned long int itemCount;
	int nodeCount;
	struct node *start;
};

struct index
{
	struct node *link;
	union
	{
		unsigned long int count;
		char *item;
	} value;
};


/* 									  	*/
/*  function prototypes for buffer.c	*/
/*                     					*/

void* CreateLineBuffer(void);
void* LoadFileBuffer(char *filename);
void  ResetBuffer(char *buffer);
void  UnloadBuffer(char *buffer);


/* 										*/
/*  function prototypes for list.c		*/
/*                     					*/

void  BuildList(struct list *sList, char *buffer);
void  CalculateListStats(struct list *sList);
void  InitList(struct list *sList, const char *name);
void  Pop(struct list *sList);
void  Push(struct list *sList, char *buffer);
void  UnloadList(struct list *sList);


/* 										*/
/*  function prototypes for index.c		*/
/*                     					*/
void* CreateIndex(int size);
void  SetIndexAlpha(struct list *sList, struct index *nIndex, char sort);
void  SetIndexNumeric(struct list *sList, struct index *nIndex, const char sort);
void  SwapPtrs(void *a, void *b, size_t size);

/* 										*/
/*  function prototypes for output.c	*/
/*                     					*/

void DoubleColumn(struct list *eList, struct index *eIndex, struct list *tList, struct index *tIndex);
void HeaderOutput(void);
void LicenseOutput(void);
void PathOutput(char *filename);
void RawOutput(struct list *sList, struct index *sIndex);
void SingleColumn(struct list *sList, struct index *sIndex);
void VersionOutput (void);


/* 										*/
/*  function prototypes for parse.c		*/
/*                     					*/

void  ParseEntity(char *line, char *buffer);
void  ParseTexture(char *line, char *buffer);
