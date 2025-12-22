/* :ts=4
 * Slamtilt highscoremanager
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <proto/exec.h>
#include <exec/memory.h>
#include <proto/intuition.h>
#include <exec/types.h>

struct IntuitionBase *IntuitionBase=NULL;


#define DEFAULTNAME		"   "
#define DEFAULTSCORE	0
#define HNUM	4
char *hname[]={
	"Demon.Dat",
	"Mean.Dat",
	"Pirate.Dat",
	"Space.Dat"
};
char name[256];
int bufflen;
char buff[2048];
char *nnow[]={
	"1nn",			// 1
	"2nn",			// 2
	"3nn",			// 3
	"4nn",			// 4
	"5nn"			// 5
};
unsigned char *snow[]={
	"1sn   ",		// 1
	"2sn   ",		// 2
	"3sn   ",		// 3
	"4sn   ",		// 4
	"5sn   "		// 5
};
char *narc[]={
	"1na",			// 1
	"2na",			// 2
	"3na",			// 3
	"4na",			// 4
	"5na"			// 5
};
unsigned char *sarc[]={
	"1as   ",		// 1
	"2as   ",		// 2
	"3as   ",		// 3
	"4as   ",		// 4
	"5as   "		// 5
};
char *nuj[]={		// átmeneti névtároló
	"1nu",			// 1
	"2nu",			// 2
	"3nu",			// 3
	"4nu",			// 4
	"5nu"			// 5
};
unsigned char *suj[]={
	"1us   ",		// 1
	"2us   ",		// 2
	"3us   ",		// 3
	"4us   ",		// 4
	"5us   "		// 5
};


int req(char *text) {
static struct EasyStruct s={
	sizeof(struct EasyStruct),0,NULL,NULL,NULL,
};
	int ret;
	s.es_Title="Slamtilt hman";
	s.es_TextFormat=text;
	s.es_GadgetFormat="Ok";
	ret=EasyRequestArgs(NULL,&s,NULL,NULL);
	return(ret);
}

/*
 * a megadott file-bõl kiolvassa a high score-t,
 * és a megadott tömbbe teszi
 */
void highfill(FILE *f,int skip,char **n,unsigned char **s) {
	int i;
	fseek(f,skip,SEEK_SET);
	// 6 byte hosszú a bcd 'score', majd 3 byte 'név', és 5 byte '0'
	for(i=0;i<5;i++) {
		s[i][0]=fgetc(f);
		s[i][1]=fgetc(f);
		s[i][2]=fgetc(f);
		s[i][3]=fgetc(f);
		s[i][4]=fgetc(f);
		s[i][5]=fgetc(f);
		n[i][0]=fgetc(f);
		n[i][1]=fgetc(f);
		n[i][2]=fgetc(f);
		fgetc(f); fgetc(f); fgetc(f); fgetc(f); fgetc(f);
	}
}

/*
 * from-ból 6 byte-ot to-ba másol
 */
void cp6(unsigned char *to,unsigned char *from) {
	to[0]=from[0];
	to[1]=from[1];
	to[2]=from[2];
	to[3]=from[3];
	to[4]=from[4];
	to[5]=from[5];
}

/*
 * az elsõ párba bemásolja a 2nd párt, de a kettõzéseket kihagyja
 */
int highcopy(char **nuj,unsigned char **suj,char **nnow,unsigned char **snow) {
	int i,j,uniq,k;

	k=0;
	strcpy(nuj[k],nnow[0]);
	cp6(suj[k],snow[0]);
	k++;
	for(i=1;i<5;i++) {
		for(uniq=1,j=0;j<k;j++) if(strcmp(nnow[i],nuj[j])==0) uniq=0;
		if(uniq) {
			strcpy(nuj[k],nnow[i]);
			cp6(suj[k],snow[i]);
			k++;
		}
	}
	if(k==5) k=-1;
	return(k);
}

/*
 * h-> highscore file
 * o-> arc file
 * OUT: buff[] ba,
 * ha semmi teendõ bufflen=0, különben ahogy kell
 */
void hman(FILE *h,FILE *o) {
	char bf[5];
	char *b;
	int oskip,hskip,hely,uniq;
	int i,j,k;

	fread(bf,1,4,h);
	bf[4]='\0';
	if(strcmp(bf,"STTF")!=0) {
		req("Wrong highscore file");
		return;
	}
	fread(bf,1,4,o);
	bf[4]='\0';
	if(strcmp(bf,"STTF")!=0) {
		req("Wrong arc file");
		return;
	}
	fseek(h,0x21,SEEK_SET);
	hskip=fgetc(h);
	fseek(o,0x21,SEEK_SET);
	oskip=fgetc(o);
	highfill(h,hskip,nnow,snow);
	highfill(o,oskip,narc,sarc);
	rewind(h);
	fread(buff,1,hskip-1,h);
	b=buff+hskip-1;
	*b++=0;
	fseek(h,(14*5)+1,SEEK_CUR);				// skip high scores in file
	for(i=0;i<5;i++) nuj[i][0]='\0';	// clear name-cache
	hely=highcopy(nuj,suj,nnow,snow);	// kettõzések kiszûrése
	if(hely!=-1) {
		// maradt hely (hely-tõl)
		for(i=hely;i<5;i++) {
			for(j=0;j<5;j++) {
				for(uniq=1,k=0;k<i;k++) if(strcmp(narc[j],nuj[k])==0) uniq=0;
				if(uniq) {
					strcpy(nuj[i],narc[j]);
					cp6(suj[i],sarc[j]);
					break;
				}
			}
			if(!uniq) break;
		}
	}
	for(i=1;i<5;i++) {
		if(nuj[i][0]=='\0') {
			strcpy(nuj[i],DEFAULTNAME);
			suj[i][0]=0; suj[i][1]=0; suj[i][2]=0; suj[i][3]=0; suj[i][4]=0; suj[i][5]=0;
		}
	}
	// b -> buff köv hely
	// 6 byte hosszú a bcd 'score', majd 3 byte 'név', és 5 byte '0'
	for(i=0;i<5;i++) {
		*b++=suj[i][0];	*b++=suj[i][1]; *b++=suj[i][2]; *b++=suj[i][3]; *b++=suj[i][4]; *b++=suj[i][5];
		*b++=nuj[i][0];	*b++=nuj[i][1]; *b++=nuj[i][2];
		*b++=0; *b++=0; *b++=0; *b++=0; *b++=0;
	}
	i=b-buff;
	b+=fread(b,1,2048-i,h);
	bufflen=b-buff;
}

int main(void) {
	char np[]="_ARC";
	int i,j,c,ret=0;
	FILE *h,*o,*f;

	if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",36))) return(0);
	for(i=0;i<4;i++) {
		bufflen=0;
		buff[0]='\0';
		strcpy(name,hname[i]);
		strcat(name,np);
		h=fopen(hname[i],"rb");
		o=fopen(name,"rb");
		if(h!=NULL&&o!=NULL) {
			hman(h,o);
			fclose(h);
			fclose(o);
			if(bufflen!=0) {
				if(NULL!=(f=fopen(hname[i],"wb"))) {
					for(j=0;j<bufflen;j++) fputc(buff[j],f);
					fclose(f);
					if(NULL!=(f=fopen(name,"wb"))) {
						for(j=0;j<bufflen;j++) fputc(buff[j],f);
						fclose(f);
					} else {
						req("Can't open ARCfile");
						ret=50;
					}
				} else {
					req("Can't open outfile");
					ret=50;
				}
			}
		} else {
			if(o==NULL&&h!=NULL) {
				// nincs _arc
				o=fopen(name,"wb");
				if(o!=NULL) {
					rewind(h);
					while(EOF!=(c=fgetc(h))) fputc(c,o);
					fclose(h);
					fclose(o);
				} else {
					req("Can't create file");
					ret=50;
				}
			} else {
				req("Can't open files");
				ret=50;
			}
		}
	}
	if(IntuitionBase) CloseLibrary((struct Library *)IntuitionBase);
	return(ret);
}
