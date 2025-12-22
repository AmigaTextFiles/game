// Minimal dll example

#include "dll.h"
#include <stdio.h>

void (* __saveds extfunc)();
int *extvar;

void __saveds function(void)
{
	*extvar=100;
    extfunc();
    printf("dll2 function called\n");
}

void * __saveds dllFindResource(int a,char *b)
{
    return 0L;
}

void * __saveds dllLoadResource(void *a)
{
    return 0L;
}

void __saveds dllFreeResource(void *a)
{
}

dll_tExportSymbol DLL_ExportSymbols[]=
{
    {dllFindResource,"dllFindResource"},
    {dllLoadResource,"dllLoadResource"},
    {dllFreeResource,"dllFreeResource"},
    {function,"function"},
    {0,0}
};

dll_tImportSymbol DLL_ImportSymbols[]=
{
    {(void **)&extfunc,"function","dll1.dll",0},
    {(void **)&extvar,"variable","dll1.dll",0},
    {0,0,0,0}
};

int DLL_Init(void)
{
    printf("dll2 DLL_Init called\n");
    return 1L;
}

void DLL_DeInit(void)
{
    printf("dll2 DLL_DeInit called\n");
}
