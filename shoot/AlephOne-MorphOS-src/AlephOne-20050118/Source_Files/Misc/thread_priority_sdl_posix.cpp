/*
 *  thread_priority_sdl_macosx.cpp
 *  AlephOne-OSX
 *
 *  Created by woody on Sat Dec 01 2001.
 *  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
 *
 */

#include	"thread_priority_sdl.h"

#if defined(TARGET_API_MAC_CARBON) && __MACH__
#include <SDL/SDL_Thread.h>
#else
#include	<SDL/SDL_thread.h>
#endif

#ifndef __MORPHOS__
#include	<pthread.h>
#include        <sched.h>
#else
#include <proto/exec.h>
#include <proto/powersdl.h>
#endif

bool
BoostThreadPriority(SDL_Thread* inThread) {
#ifndef __MORPHOS__
    pthread_t		theTargetThread = (pthread_t) SDL_GetThreadID(inThread);
    int			theSchedulingPolicy;
    struct sched_param	theSchedulingParameters;
    
    if(pthread_getschedparam(theTargetThread, &theSchedulingPolicy, &theSchedulingParameters) != 0)
      return false;
    
    theSchedulingParameters.sched_priority = 
      sched_get_priority_max(theSchedulingPolicy);
    
    if(pthread_setschedparam(theTargetThread, theSchedulingPolicy, &theSchedulingParameters) != 0)
      return false;
    
    return true;
#else
	struct Task *task = (struct Task *)SDL_GetThreadID(inThread);
	LONG pri1, pri2;
	NewGetTaskAttrs(FindTask(NULL), &pri1, sizeof(pri2), TASKINFOTYPE_PRI, TAG_DONE);
	NewGetTaskAttrs(task, &pri2, sizeof(pri2), TASKINFOTYPE_PRI, TAG_DONE);
	if (pri1 >= pri2 && pri1 < 5)
		SetTaskPri(task, pri1 + 1);
	return true;
#endif
}
