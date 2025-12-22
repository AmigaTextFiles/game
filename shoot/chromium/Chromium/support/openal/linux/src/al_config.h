#ifndef AL_CONFIG_H_
#define AL_CONFIG_H_

#include "AL/altypes.h"

#include "al_rctree.h"
#include "al_rcvar.h"

ALboolean _alParseConfig(void);
void _alDestroyConfig(void);

ALboolean _alGetGlobalScalar(const char *str,
			ALRcEnum type,
			void *retref);
ALboolean _alGetGlobalVector(const char *str,
			ALRcEnum type,
			ALuint num,
			void *retref);

/* get binding for symbol described by str */
AL_rctree *_alGlobalBinding(const char *str);

/* evaluate expression */
AL_rctree *_alEval(const char *expression);
AL_rctree *_alDefine(const char *symname, AL_rctree *value);

/* invalid is returned as an error for functions returning
 * AL_rctree (not AL_rctree *) structures */
extern const AL_rctree scminvalid;
extern const AL_rctree scmfalse;
extern const AL_rctree scmtrue;

#endif
