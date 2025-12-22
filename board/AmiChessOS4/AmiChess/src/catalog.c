#include <stdio.h>
#include <proto/locale.h>

#define CATCOMP_NUMBERS
#define CATCOMP_CODE
#define CATCOMP_BLOCK
#include "AmiChess_Catalog.h"

static struct LocaleInfo li;

void init_catalog( void )
{
	li.li_LocaleBase 	= NULL;
	li.li_Catalog 		= NULL;

	li.li_LocaleBase = LocaleBase;
	li.li_Catalog = OpenCatalog(NULL, "AmiChess.catalog", OC_BuiltInLanguage, "english", TAG_DONE);
}

void close_catalog( void )
{
	if (li.li_Catalog) CloseCatalog(li.li_Catalog);
}

char *getstr(unsigned long num)
{
	return (char *)GetString(&li, num);
}

