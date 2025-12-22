/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.5  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.edu.pl>             */
/*------------------------------------------*/

/* SudokuAreaClass header. */

#include <proto/intuition.h>
#include <proto/utility.h>
#include <proto/muimaster.h>
#include <clib/alib_protos.h>
#include <stdint.h>

extern struct MUI_CustomClass *SudokuAreaClass;

struct MUI_CustomClass *CreateSudokuAreaClass(void);
void DeleteSudokuAreaClass(void);


#define SUAM_SetField                  0x6EDA37A5
#define SUAM_GetSudoku                 0x6EDA37A6
#define SUAM_SetSudoku                 0x6EDA37A7
#define SUAM_Update                    0x6EDA37A8
#define SUAM_FlashOneField             0x6EDA37A9
#define SUAM_FlashTwoFields            0x6EDA37AA

#define SUAA_Full                      0x6EDA37C0  /* [..G] BOOL   */
#define SUAA_ClickedField              0x6EDA37C1  /* [..G] LONG   */
#define SUAA_Disabled                  0x6EDA37C2  /* [.S.] BOOL   */

struct SUAP_SetField
{
	ULONG    MethodID;
	IPTR     Value;
	IPTR     Index;
};


struct SUAP_SetSudoku
{
	ULONG    MethodID;
	LONG*    Field;
};


struct SUAP_GetSudoku
{
	ULONG    MethodID;
	LONG*    Field;
};

struct SUAP_FlashOneField
{
	ULONG    MethodID;
	IPTR     Field;
};

struct SUAP_FlashTwoFields
{
	ULONG    MethodID;
	IPTR     Field1;
	IPTR     Field2;
};

