#include "version.h"

extern void NewOnScreenMessage(unsigned char *messagePtr);


#define VERSION_NUMBER			"1.00"
#define VERSION_DATE			"13.10.2013"


#define VERSION_ARCH			"PPC"
//#define VERSION_ARCH			"X86"
//#define VERSION_ARCH			"68K"

#ifdef __MORPHOS__
	#define VERSION_OS			"MorphOS"
#elif defined __AMIGAOS4__
	#define VERSION_OS			"AmigaOS4"
#elif defined __AROS__
	#define VERSION_OS			"AROS"
#else
	#define VERSION_OS			"Amiga"
#endif


#define AVP_VERSION_STRING1	"Aliens vs Predator " VERSION_OS "-" VERSION_ARCH " " VERSION_NUMBER " (" VERSION_DATE ")"
#define AVP_VERSION_STRING2 "Based on Rebellion Developments AvP Gold source"

#define AVP_VERSTAG "\0$VER: " AVP_VERSION_STRING1 "\0"


const char VersionTag[] = AVP_VERSTAG;
const char* AvPVersionString1 = AVP_VERSION_STRING1;
const char* AvPVersionString2 = AVP_VERSION_STRING2;

const char* GetAvpVersionString(void)
{
	return AvPVersionString1;
}

const char* GetAvpExtraVersionString(void)
{
	return AvPVersionString2;
}

void GiveVersionDetails(void)
{
	NewOnScreenMessage((unsigned char*) AvPVersionString1);
	NewOnScreenMessage((unsigned char*) AvPVersionString2);
}
