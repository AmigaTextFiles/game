///////////////////////////////////////////////////////////////////////////////
// File         : strconst.c
// Info         : Strings and configurable parameters
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

char *gametypenames[] =
	{
	"ONE player game",
	"TWO players game",
	NULL
	};

char	strpaused[]=	"Paused",
	strscore[]=		"Score",
	strlevel[]=		"Level",
	strnobody[]=	"Nobody",
	stranon[]=		"Anonymous",
	strpoints[]=	"Points",
	strgameover[]=	"Game Over!!!!",
	strendofdemo[]=	"End of demo!",
	strgofornext[]=	"Go for the next screen !!!!!",
	strnomoreroom[]="No more room for demo",
	strnodemofile[]="No demo file!!!",
	strcrushen[]=	"Crush Enemies",
	strstunen[]=	"Stun Enemies",
	str3inarow[]=	"3 in a row",
	str2better[]=	"2 players is better than one" ;

char copyright[]= "(C) 2000 Carlo Borreo borreo@softhome.net" ;
char scorename[]= SCOREDIR "/lupsco.dat" ;

int	ExtraLifeEvery = 20000,
	FlashTime = 15,
	StartLives[ GAMETYPES ] = { 3, 6 },
	AutoFire = 1 ;
