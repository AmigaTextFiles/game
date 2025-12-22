/************************************************************************/
/************************************************************************/
/*																		*/
/*							Lord British's Castle						*/
/*																		*/
/************************************************************************/
/************************************************************************/

#include "aklabeth.h"

static char *_BRITISHName(int);

/************************************************************************/
/*																		*/
/*							Visit Lord British							*/
/*																		*/
/************************************************************************/

void BRITISHEnter(WORLDMAP *w,PLAYER *p)
{
	int NextTask = p->Task+1;
	int c,i;

	if (*p->Name == '\0')					/* Require the player name */
	{
		DRAWText("Welcome, peasant into\nthe Halls of the\nmighty Lord British.");
		DRAWText("Herein thou may choose\nto do battle with\nthe evil creatures of the\ndepths, for great\nreward.\n\n");
		DRAWText("What is thy name,\npeasant ?\n");

		do									/* Read the name. */
			{
			c = HWGetKey();
			if (isalpha(c) && strlen(p->Name) < MAX_NAME)
				{
				if (*p->Name != '\0') c = tolower(c);
				sprintf(p->Name+strlen(p->Name),"%c",c);
				HWChar(c);
				}
			}
		while (c >= ' ');
		DRAWText("\n\n");
											/* Great adventure question */
		DRAWText("Doest thou wish\nfor great adventure ?\n\n");
		if (DEADGetYesNo() == 0)
			{
			DRAWText("Then leave and begone!\n\n");
			strcpy(p->Name,"");
			return;
			}
	}

	if (p->Task > 0)						/* Set a task before ? */
	{
		if (p->TaskCompleted == 0)			/* Outstanding task */
		{
			DRAWText("%s, why hast\nthou returned ?\nThou must kill\n%s.\nGo now and complete\nthy quest !\n",
					 p->Name,_BRITISHName(p->Task));
		}
		else
		{
			DRAWText("\nAaaahhhh....\n%s.\n\n",p->Name);
			DRAWText("Thou has accomplished\nthy quest.\n\n");
			if (p->Task == MAX_MONSTERS)
			{
				DRAWText("Lord %s,thou\nhast proved thyself worthy of\nKnighthood, continue\nif thou doth wish\nbut thou hast \naccomplished the\nmain objective of\nthe game.\n\n");
				DRAWText("Now, maybe thou art\nfoolhardy enough to\ntry difficulty level %d.\n\n",p->Skill+1);
			}
			else
			{
				DRAWText("Unfortunately, this\nis not enough to\nbecome a knight.\n\n");
				p->Task = 0;				/* We need another task */
			}
		}
	}
	if (p->Task == 0)						/* Need a new task..... */
	{
		if (NextTask == 1)
		{
			DRAWText("Good ! Thou shalt try\nto become a knight.\nThy first task is to\ngointo the dungeons\nand return only after\nkilling %s.\n\n",
					 _BRITISHName(NextTask));
		}
		else
		{
			DRAWText("Thou must now kill\n%s.\n\n",_BRITISHName(NextTask));
		}
		DRAWText("Go now upon this\nQuest, and may lady\nluck fair be upon you\nAlso I, Lord British\n,have increased each\nof your attributes\nby one.\n\n");
		p->Task = NextTask;
		p->TaskCompleted = 0;
		for (i = 0;i < p->Attributes;i++)	/* LB gives you extra attribs */
								p->Attr[i]++;
	}
}

/************************************************************************/
/*																		*/
/*						Get name modified with a or an					*/
/*																		*/
/************************************************************************/

static char *_BRITISHName(int m)
{
	static char _Buffer[64];
	char *p = GLOMonsterName(m);
	sprintf(_Buffer,"%s %s",
			(strchr("aeiou",tolower(*p)) != NULL) ? "an":"a",
			p);
	return(_Buffer);
}
