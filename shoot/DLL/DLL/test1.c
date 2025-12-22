#include "dll.h"
#include <stdio.h>

void (* __saveds extfunc)();
int *v;

dll_tImportSymbol DLL_ImportSymbols[]=
{
	{(void **)&extfunc,"function","dll2.dll",0},
	{0,0,0,0}
};

int main(void)
{
	if(!dllImportSymbols())
		exit(10L);

	extfunc();
	dllKillLibrary("dll2.dll");

	return 0L;
}
