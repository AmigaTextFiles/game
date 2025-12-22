// Minimal dll example

#include "dll.h"
#include <stdio.h>

int variable=0;

void __saveds function(void)
{
    printf("dll1 function called variable: %d\n",variable);
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
    {&variable,"variable"},
    {function,"function"},
    {0,0}
};

dll_tImportSymbol DLL_ImportSymbols[]=
{
    {0,0,0,0}
};

int DLL_Init(void)
{
    printf("dll1 DLL_Init called\n");
    return 1L;
}

void DLL_DeInit(void)
{
    printf("dll1 DLL_DeInit called\n");
}
