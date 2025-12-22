#define ALIAS(a,b) \
        asm(".stabs \"_" #a "\",11,0,0,0\n.stabs \"_" #b "\",1,0,0,0")

ALIAS(_main,Main);
