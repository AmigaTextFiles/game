#include <stdio.h>
#include <stdlib.h>

#include "codewar.h"

int main(void)
{   if (cw_register_program("Foobar"))
    {   cw_print_buffer("Hello, world!");
        for (;;);
    }

    return 0;
}
