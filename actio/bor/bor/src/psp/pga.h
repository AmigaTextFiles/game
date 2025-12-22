int pgaVolume(int ch,int lvol,int rvol);
int pgaOutBlocking(unsigned int channel,unsigned int vol1,unsigned int vol2,void *buf);
void pgaSetChannelCallback(int channel, void (*callback)(void*,unsigned));
int pgaInit(void);
void pgaTermPre(void);
void pgaTerm(void);
