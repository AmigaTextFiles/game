#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "bool.h"
#include "require.h"

void require(bool b, char* description)
{
    if(!b)
    {
        printf("%s is required but failed\n", description);
        exit(0);
    }
}
