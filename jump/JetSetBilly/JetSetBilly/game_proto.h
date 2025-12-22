#ifndef _GAME_PROTO_H
#define _GAME_PROTO_H

/* compress.c protos */
ULONG pack(UBYTE *src, UBYTE *dst, ULONG len);
ULONG unpack(UBYTE *src, UBYTE *dst, ULONG len);

/* files.c protos */
BOOL load_file(char *filename, UBYTE *dest, ULONG size);
BOOL load_packed_file(char *filename, UBYTE *dest, ULONG size);
BOOL save_packed_file(char *filename, UBYTE *src, ULONG size);
BOOL filerequest(UBYTE mode);
void setup_asl(void);
void cleandown_asl(void);

/* muzak.c */
void initmusic(void);
void stopmusic(void);
void contmusic(void);
void playmusic(UWORD n);
void cleanmusic(void);

#endif /* _GAME_PROTO_H */
