/*------------------------------------------*/
/* Code generated with ChocolateCastle 0.6  */
/* written by Grzegorz "Krashan" Kraszewski */
/* <krashan@teleinfo.pb.edu.pl>             */
/*------------------------------------------*/

/* PrefsWinClass header. */

#include <proto/intuition.h>
#include <proto/utility.h>
#include <proto/muimaster.h>
#include <clib/alib_protos.h>

extern struct MUI_CustomClass *PrefsWinClass;

struct MUI_CustomClass *CreatePrefsWinClass(void);
void DeletePrefsWinClass(void);

/* Attributes. */

#define PRWA_SudokuColor        0x6EDA543A   /* [..G] (struct MUI_PenSpec*) */
#define PRWA_EffectDepth        0x6EDA543B   /* [..G] (LONG)                */
#define PRWA_SettingsUpdated    0x6EDA543C   /* [..G] (BOOL)                */

/* Methods. */

#define PRWM_UseSettings        0x6EDA543D

struct PRWP_UseSettings
{
	ULONG MethodID;
	IPTR  Save;
};

