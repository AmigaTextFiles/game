#ifndef POWERLIB_H
#define POWERLIB_H

struct PDisplay;

#define PMEMF_NOCACHE 1

int PInit(int argc,char *argv[]);
void PDeinit();

void *PAllocMem(int size,unsigned int);
void PFreeMem(void *);

void *PLoadFile(char *,unsigned int);

struct PDisplay *POpenDisplay(int w,int h,int d);
void PCloseDisplay(struct PDisplay*);
void PBltChkHidden(struct PDisplay *dp,char *buf,int x,int y,int w,int h);
void PBlt24Hidden(struct PDisplay *dp,unsigned long *buf,int x,int y,int w,int h);
void PSwapDisplay(struct PDisplay *dp);
void PWaitRaster(int);
void PWaitRaster2(int);
void PTimeShare(unsigned short);
void PSetPalette(struct PDisplay *,unsigned char *);

int PLMBStatus();
int PGetKey();

#endif
