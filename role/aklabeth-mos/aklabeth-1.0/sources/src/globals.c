/************************************************************************/
/************************************************************************/
/*																		*/
/*				Global Constants : Lists of things, etc.				*/
/*																		*/
/************************************************************************/
/************************************************************************/

#include "aklabeth.h"

struct _OInfStruct
		{ char *Name; int Cost; int MaxDamage; char Key; };
struct _MInfStruct
		{ char *Name; int Level; };

static struct _OInfStruct _OInfo[] =
	{
		{ "Food",1,0,'F' },
		{ "Rapier",8,10,'R' },
		{ "Axe",5,5,'A' },
		{ "Shield",6,1,'S' },
		{ "Bow+Arrow",3,4,'B' },
		{ "Amulet",15,0,'M' }
	};

static struct _MInfStruct _MInfo[] =
	{
		{ "Skeleton",1 },
		{ "Thief",2 },
		{ "Giant Rat",3 },
		{ "Orc",4 },
		{ "Viper",5 },
		{ "Carrion Crawler",6 },
		{ "Gremlin",7 },
		{ "Mimic",8 },
		{ "Daemon",9 },
		{ "Balrog",10 }
	};

static char *_AName[] =
	{ 	"HP",		"Strength",	"Dexterity",	"Stamina",
		"Wisdom",	"Gold"  };

/************************************************************************/
/*																		*/
/*						Return name of object							*/
/*																		*/
/************************************************************************/

char *GLOObjName(int n)
{ return _OInfo[n].Name; }

void GLOGetInfo(int n,int *pDamage,int *pCost,int *pKey)
{
	if (pDamage != NULL) *pDamage = _OInfo[n].MaxDamage;
	if (pCost != NULL) 	 *pCost = _OInfo[n].Cost;
	if (pKey != NULL) 	 *pKey = _OInfo[n].Key;
}

/************************************************************************/
/*																		*/
/*						Return name of attribute						*/
/*																		*/
/************************************************************************/

char *GLOAttribName(int n)
{
return _AName[n];
}

/************************************************************************/
/*																		*/
/*							Return name of class						*/
/*																		*/
/************************************************************************/

char *GLOClassName(char c)
{
	return (c == 'F') ? "Fighter":"Mage";
}

char *GLOMonsterName(int n)
{
	return _MInfo[n-1].Name;
}

int GLOMonsterLevel(int n)
{
	return _MInfo[n-1].Level;
}



