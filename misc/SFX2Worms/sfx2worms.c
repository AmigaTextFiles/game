
/* This program converts PC Worms Reinforcements samplefile
   to Amiga IFF separate files. 

 Compiler used: SAS/C 6.51

 You must have MCConstants enabled in scoptions!

*/

#include <stdio.h>

#define MAXSIZE 100000

int start[256],len[256];

char *sname[69] = { "Revenge", "OhDear", "OiNutter", "Oooff1", "Oooff2", "Oooff3",
	"Oooww1", "Oooww2", "Oooww3", "Perfect", "Pop", "Punch", "Reload", "Shotgun",
	"Splash", "Stupid", "TakeCover", "Baa", "Teleport", "Traitor", "Twang", "Uzi",
	"WatchThis", "WhatThe", "Whoops", "Wobble", "YesSir", "You'llRegretThat", "Hello",
	"Fuse", "Glasses", "Grenade", "Hup1", "Hup2", "Hurry", "I'llGetYou", "JustYouWait",
	"Kamikaze", "Laugh", "LeaveMeAlone", "Mine",	"Missed", "Nooooo", "Bazooka",
	"BlowTorch", "Boring", "Bungee", "ByeBye", "ComeOnThen", "Communicator", "Coward",
	"Die", "DragonPunch", "Drill", "Excellent", "Explosion", "ExplosionUW", "Fatality",
	"Fire", "FireBall", "FirstBlood", "Flawless", "MiniGun", NULL, NULL, NULL,
	"AirStrike", NULL, NULL };

int iffhdr[] = { 'FORM', 0, '8SVX', 'VHDR', 0x14, 0, 0, 0, 0x3a980100, 0xffff,
		'NAME', 0x14, 'Just', ' a s', 'ampl', 'e!\0\0', 0, 
		'ANNO', 0x14, 'sfxd', '2wor', 'ms\0\0', 0, 0, 'BODY', 0 };

far char sbuf[MAXSIZE];	/* sample buffer */

/* function that converts Intel integers to Motorola format */
int pctoamy(int val)
{
	int res;
	
	res =(val>>24)& 0x000000ff;
	res|=(val>>8) & 0x0000ff00;
	res|=(val<<8) & 0x00ff0000;
	res|=(val<<24)& 0xff000000;
	
	return res;
}

/* main */
int main (char **argv,int argc)
{
	int x;
	FILE *in,*out;
	
	printf("SFX to Amiga Worms converter\nVersion 1.0\nAuthor: Teemu Suikki <zuikkis@sci.fi>\n\n");
	
	if (argc!=2) {
		printf("Usage: sfx2worms <filename>\n");
		return 10;
	}
	
	if (!(in=fopen(argv[1],"rb"))) {
		printf("Input file '%s' not found!\n",argv[1]);
		return 10;
	}
	
	printf("Reading file '%s'\n",argv[1]);
	
/* read sample start and stop addresses */	
	fread(start,4,256,in);
	fread(len,4,256,in);
	
/* convert those ugly PC-integers to understandable numbers, calculate len */
	for (x=0;x<256;x++) {
		start[x]=pctoamy(start[x]);
		len[x]=pctoamy(len[x])-start[x];
	}	
	
/* fix pointers for samples 62-65 */	
	start[62]=start[21];len[62]=len[21];	/* Minigun     -> Uzi         */

/* read samples and write output */	
	for (x=0;x<69;x++) {
		if (sname[x]) {

			if (len[x]>MAXSIZE) {
				printf("Sample #%d (%s) too long! Truncated.\n",x,sname[x]);
				len[x]=MAXSIZE;
			}
			
			fseek(in,start[x]+0x800,SEEK_SET);	/* seek correct position */
			fread(sbuf,len[x],1,in);			/* read data */
		
			if (len[x] & 1) len[x]--;			/* must be even length */
		
			iffhdr[1]=len[x]+0x60;				/* fill in IFF header */
			iffhdr[6]=len[x];
			iffhdr[25]=len[x];
		
			if (!(out=fopen(sname[x],"wb"))) {
				printf("Can't open output file '%s'\n",sname[x]);
				return 10;
			}
		
			fwrite(iffhdr,4,26,out);		/* write iff header */
			fwrite(sbuf,len[x],1,out);		/* write sample data */
			fclose(out);
		}
		
	}
	fclose(in);
	printf("Done!\n");
}	
