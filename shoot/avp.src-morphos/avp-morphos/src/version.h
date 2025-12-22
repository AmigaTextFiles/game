#ifndef __VERSION_H__
#define __VERSION_H__

/* KJL 15:56:24 29/03/98 - this function supplies a text
description of the current build, and the build date. */
extern void GiveVersionDetails(void);
extern const char* GetAvpVersionString(void);
extern const char* GetAvpExtraVersionString(void);

#endif
