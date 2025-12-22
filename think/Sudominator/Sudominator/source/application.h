/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.3  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.bialystok.pl>       */
/*------------------------------------------*/

/* ApplicationClass header. */

#include <proto/intuition.h>
#include <proto/utility.h>
#include <proto/muimaster.h>
#include <clib/alib_protos.h>

extern struct MUI_CustomClass *ApplicationClass;

struct MUI_CustomClass *CreateApplicationClass(void);
void DeleteApplicationClass(void);

#define APPM_Notifications       0x6EDA3601
#define APPM_MainLoop            0x6EDA3602
#define APPM_QuickSolve          0x6EDA3603
#define APPM_Validate            0x6EDA3604
#define APPM_Clear               0x6EDA3605
#define APPM_LiveSolve           0x6EDA3606
#define APPM_LiveReport          0x6EDA3607
#define APPM_StopLiveSolver      0x6EDA3608
#define APPM_FinalReport         0x6EDA3609
#define APPM_Save                0x6EDA360A
#define APPM_Load                0x6EDA360B
#define APPM_HintRandom          0x6EDA360C
#define APPM_HintSelected        0x6EDA360D
#define APPM_Copy                0x6EDA360E

struct APPP_Report
{
	ULONG MethodID;
	IPTR  Iterations;
};

struct APPP_HintSelected
{
	ULONG MethodID;
	IPTR  SelectedField;
};

