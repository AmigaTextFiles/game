#include <stdio.h>
#include <stdlib.h>
#include "require.h"

void Require(int exp, char* operationName)
{
        if(!exp)
        {
                printf("%s failed\n", operationName);
                exit(0);
        }
}

