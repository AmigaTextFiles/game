// med.c protos:

void buildListOfSongs( STRPTR dir );
void destroyList(void);
BOOL playSong( WORD selection );
BOOL playMusic( STRPTR file );
void closePlayer( struct MMD0 *sng );
void stopAudio(void);
void freeAudio(void);
