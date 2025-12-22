#include "wand_head.h"

extern int debug_disp;
extern int no_passwords;
extern int maxscreens;

#ifndef DICTIONARY
    /* use this stuff if no dictionary file is defined */
    /* feel free to change the words, but don't change how many there are */

char *dictionary[] = {  /* 8 per line, total 128 (16 lines) */
"zero","frog","insanity","hack","stardust","whimpy","lost","rattlesnake",
"panic","crisis","centipede","zaxxon","birdbrain","feeble","juggler","eunuchs",
"unix","amigoid","squirrel","moose","natasha","gyroscope","relax","superstar",
"winner","cheater","liberal","quail","insignificant","oxen","leap","orange",
"troll","zipper","drum","nuke","waste","want","secretword","wyrm",
"english","allegro","treefrog","bullfrog","dump","lunch","donut","lemon",
"helpme","fly","swim","joystick","rambo","leaf","horrible","unknown",
"high","mountain","mispeled","valley","zappa","glass","crunch","sdi",
"squiggly","worms","hint","wanderer","rogue","people","veggie","barf",
"exhausted","raygun","butcher","reebok","gnu","bicycle","fish","boulder",
"repeat","crisis","centipede","birdbrain","lost","rattler","snake","oops",
"squirrel","panic","zero","insanity","whimpy","nifty","crunch","oops",
"paperclip","keynote","keystone","vail","aspen","fall","short","dwarf",
"oboe","bazooka","bassoon","torpedo","risky","bored","cat","music",
"tinker","thunk","liver","onions","tastey","uggh","badnews","whynot",
"because","monster","quest","griffin","gomf","shoe","serpent","tammy"
};
#endif

int scrn_passwd(num, passwd)    /* reads password num into passwd */
int num;
char *passwd;
{
#ifdef DICTIONARY
	long position;
	FILE *fp;

	position = PASSWD;
	while(position > 200000)
		position -= 200000;
	if((fp = fopen(DICTIONARY,"r")) == NULL)
		return 0;
	fseek(fp,position,ftell(fp));
	while(fgetc(fp) != '\n');
	fscanf(fp,"%s\n",passwd);
	/* read a word into passwd */
	fclose(fp);
	return (1);
#else
	static int firsttime = 1;
	if (firsttime)
	{
		/* first time thru, shuffle the passwords in memory */
		/* this thwarts the disk browsers */
		register int i;
		register char *temp;

		firsttime = 0;
		for (i=0; i<64; i+=2)
		{
			temp = dictionary[i];
			dictionary[i] = dictionary[i+64];
			dictionary[i+64] = temp;
		}
		for (i=0; i<123; i+=3)
		{
			temp = dictionary[i];
			dictionary[i] = dictionary[i+2];
			dictionary[i+2] = dictionary[i+1];
			dictionary[i+1] = temp;
		}
	}
	strcpy(passwd, dictionary[num&127]);
	return (1);
#endif
}

void showpass(num)
int num;
{
char correct[20];
char buffer[100];
char ch;
int  passline;
if(no_passwords)
    return;
if(!debug_disp)
    passline = 18;
else
    passline = 20;
move(passline,0);

if(!scrn_passwd(num,correct))
    return;
(void) sprintf(buffer,"The password to jump to level %d ( using ~ ) is : %s        \n",(num+1),correct);
addstr(buffer);
addstr("PRESS ANY KEY TO REMOVE IT AND CONTINUE                          \n");
refresh();
ch = getch();
move(passline,0);
addstr("                                                                        \n");
addstr("                                              ");
move(passline,0);
refresh();
}

int jumpscreen(num)
int num;
{
char word[20],
     buffer[100],
     correct[20];
int index=0;
int  scrn;
int  passline;

if (!debug_disp)
    passline = 16;
else
    passline = 18;

if(no_passwords == 1) {
    move(passline,0);
    addstr("Enter number of desired level.\n");
    refresh();
    scrn = getnum();
    if(scrn > num) {
        move(passline,0);
        addstr("                                                ");
	return scrn;
	}
    move(passline,0);
    addstr("No way, Jose! Back-jumping is prohibited!");
    refresh();
    return num;
    }

move(passline,0);
addstr("Please enter password of screen to jump to:");
refresh();
while(((word[index++] = getch()) != '\n')&&(index < 19))
    {
    addch('*');
    refresh();
    }
word[--index]='\0';
move(passline,0);
addstr("Validating...                                             \n");
refresh();

if(strcmp(word,MASTERPASSWORD) == 0)
    {
    move(passline,0);
    addstr("Enter number of desired level.");
    refresh();
    num = getnum();
    (void) scrn_passwd(num-1,correct);
    sprintf(buffer,"Certainly master, but the correct word is %s.       \n",correct);
    move(passline,0);
    addstr(buffer);
    addstr("PRESS ANY KEY TO REMOVE IT AND CONTINUE                          \n");
    refresh();
    getchar();
    move(passline,0);
    addstr("                                                             ");
    move(passline+1,0);
    addstr("                                                             ");
    move(passline,0);
    refresh();
    return num;
    }

for(scrn = num;scrn < maxscreens;scrn++) {
    if(!scrn_passwd(scrn,correct))
	break;
    if(strcmp(correct,word) == 0)
        {
        move(passline,0);
        addstr("Password Validated..... Jumping to desired screen.        ");
        refresh();
        return ++scrn;
        }
    }

move(passline,0);
addstr("PASSWORD NOT RECOGNISED!  Press any key...  ");
refresh();
getchar();
move(passline,0);
addstr("                                                          ");
refresh();

return num;
}

int getnum()
{
char ch;
int num = 0;
    for(ch = getch(),addch(ch),refresh(); ch >= '0' && ch <= '9'; ch = getch(),addch(ch),refresh())
	{
	num = num * 10 + ch - '0';
	}
    return num;
}
