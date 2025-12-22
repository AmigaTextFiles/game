#include <intuition/intuition.h>

#include "global.h"
#include "gfx.h"

#define ITXT	static struct IntuiText

ITXT IText_1  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 350, &TA_Times18, "1", NULL     };
ITXT IText_2  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 300, &TA_Times18, "2", &IText_1 };
ITXT IText_3  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 250, &TA_Times18, "3", &IText_2 };
ITXT IText_4  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 200, &TA_Times18, "4", &IText_3 };
ITXT IText_5  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 150, &TA_Times18, "5", &IText_4 };
ITXT IText_6  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 100, &TA_Times18, "6", &IText_5 };
ITXT IText_7  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0,  50, &TA_Times18, "7", &IText_6 };
ITXT IText_8  = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0,   0, &TA_Times18, "8", &IText_7 };
ITXT IText_A  = { COLOR_RAHMEN, COLOR_BCK, JAM2,  34, 387, &TA_Times18, "A ", &IText_8 };
ITXT IText_B  = { COLOR_RAHMEN, COLOR_BCK, JAM2,  84, 387, &TA_Times18, "B ", &IText_A };
ITXT IText_C  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 134, 387, &TA_Times18, "C ", &IText_B };
ITXT IText_D  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 184, 387, &TA_Times18, "D ", &IText_C };
ITXT IText_E  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 234, 387, &TA_Times18, "E ", &IText_D };
ITXT IText_F  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 284, 387, &TA_Times18, "F ", &IText_E };
ITXT IText_G  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 334, 387, &TA_Times18, "G ", &IText_F };
ITXT IText_H  = { COLOR_RAHMEN, COLOR_BCK, JAM2, 384, 387, &TA_Times18, "H ", &IText_G };
ITXT IText_R1 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 350, &TA_Times18, "8", NULL     };
ITXT IText_R2 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 300, &TA_Times18, "7", &IText_R1 };
ITXT IText_R3 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 250, &TA_Times18, "6", &IText_R2 };
ITXT IText_R4 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 200, &TA_Times18, "5", &IText_R3 };
ITXT IText_R5 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 150, &TA_Times18, "4", &IText_R4 };
ITXT IText_R6 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0, 100, &TA_Times18, "3", &IText_R5 };
ITXT IText_R7 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0,  50, &TA_Times18, "2", &IText_R6 };
ITXT IText_R8 = { COLOR_RAHMEN, COLOR_BCK, JAM2,   0,   0, &TA_Times18, "1", &IText_R7 };
ITXT IText_RA = { COLOR_RAHMEN, COLOR_BCK, JAM2,  34, 387, &TA_Times18, "H ", &IText_R8 };
ITXT IText_RB = { COLOR_RAHMEN, COLOR_BCK, JAM2,  84, 387, &TA_Times18, "G ", &IText_RA };
ITXT IText_RC = { COLOR_RAHMEN, COLOR_BCK, JAM2, 134, 387, &TA_Times18, "F ", &IText_RB };
ITXT IText_RD = { COLOR_RAHMEN, COLOR_BCK, JAM2, 184, 387, &TA_Times18, "E ", &IText_RC };
ITXT IText_RE = { COLOR_RAHMEN, COLOR_BCK, JAM2, 234, 387, &TA_Times18, "D ", &IText_RD };
ITXT IText_RF = { COLOR_RAHMEN, COLOR_BCK, JAM2, 284, 387, &TA_Times18, "C ", &IText_RE };
ITXT IText_RG = { COLOR_RAHMEN, COLOR_BCK, JAM2, 334, 387, &TA_Times18, "B ", &IText_RF };
ITXT IText_RH = { COLOR_RAHMEN, COLOR_BCK, JAM2, 384, 387, &TA_Times18, "A ", &IText_RG };

struct IntuiText	*IText_nor = &IText_H,
					*IText_rev = &IText_RH;
