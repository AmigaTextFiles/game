/************************************************************************/
/************************************************************************/
/*																		*/
/*						Enter town (shopkeeper code)					*/
/*																		*/
/************************************************************************/
/************************************************************************/

#include "aklabeth.h"

void TOWNEnter(WORLDMAP *w,PLAYER *p)
{
	int Key,i,Cost,Incr,Item;
	DRAWText("Welcome to the\nAdventure shop.\n");
	do      								/* Keep Buying */
	{
		HWStatus(p->Object[OB_FOOD],		/* Refresh the status bar */
							p->Attr[AT_HP],p->Attr[AT_GOLD]);
		DRAWText("\nWhat shalt thou buy?\n\n");
		for (i = 0;i < p->Objects;i++)		/* Price list */
		{
			GLOGetInfo(i,NULL,&Cost,NULL);
			DRAWText("%s: %.0f (%d GP)\n",GLOObjName(i),floor(p->Object[i]),Cost);
		}
		Key = HWGetKey();Item = -1;			/* Get item to buy */
		for (i = 0;i < p->Objects;i++)		/* Find which one it was */
		{
			GLOGetInfo(i,NULL,NULL,&Cost);
			if (Cost == Key) Item = i;
		}
		if (p->Class == 'M')				/* Some things mages can't use */
			if (Item == OB_BOW || Item == OB_RAPIER)
			{
				DRAWText("\nI'm sorry, Mages\ncan't use that.\n");
				Item = -1;
			}

		if (Item >= 0)						/* Something selected */
		{
			GLOGetInfo(Item,NULL,&Cost,NULL);
			if (Cost > p->Attr[AT_GOLD])
				DRAWText("\nM'Lord thou cannot\nafford that item.\n");
			else
			{
				p->Attr[AT_GOLD] -= Cost;   /* Lose the money */
				HWStatus(p->Object[OB_FOOD],/* Refresh the status bar */
						p->Attr[AT_HP],p->Attr[AT_GOLD]);
				Incr = 1;if (Item == OB_FOOD) Incr = 10;
				p->Object[Item] += Incr;	/* Add 1 or 10 on */
			}
		}
	}
	while(Key != 'Q');
	DRAWText("\nBye.\n\n");
}
