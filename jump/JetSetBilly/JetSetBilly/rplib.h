/*
 * rplib.h
 *
 */

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

/*
 * data encryption
 */

typedef	UWORD	idea_block[4];
typedef UWORD	idea_key[8];
typedef UWORD	idea_key_schedule[104];

#define IDEA_ENCRYPT 1
#define IDEA_DECRYPT 0

void __asm idea_set_key(register __a0 UWORD *userkey,
	register __a1 UWORD *keysched);

void __asm idea_ecb_encrypt( register __a0 UWORD *src,
	register __a1 UWORD *dst, register __a2 UWORD *ks,
	register __d0 int mode);

void __asm idea_cbc_encrypt(register __a0 UWORD *src,
	register __a1 UWORD *dst, register __d0 ULONG len,
	register __a2 UWORD *ks, register __a3 UWORD *ivec,
	register __d1 int mode);

/*
 * simple random generator
 */

void __asm srnd(register __d0 ULONG seed); 
ULONG __asm rnd(void);

/*
 * strong random generator
 */

extern ULONG _random_buffer[16];
void __asm srandom(register __a0 char key_eor[16]);
ULONG __asm random(void);

/*
 * data compression
 */

typedef UBYTE *compress_hash[4096];

ULONG __asm decompress(register __a0 UBYTE *src,
	register __a1 UBYTE *dst, register __d0 ULONG ilen);

ULONG __asm encompress(register __a0 UBYTE *src,
	register __a1 UBYTE *dst, register __d0 ULONG ilen,
	register __a2 UBYTE **hash);

/*
 * crc32
 */

ULONG __asm crc32(register __a0 UBYTE *buf, register __d0 ULONG len);

/*
 * bit operations
 */

ULONG __asm bitcount(register __d0 ULONG val);
ULONG __asm bitrev(register __d0 ULONG val);
ULONG __asm byterev(register __d0 ULONG val);
ULONG __asm highbit(register __d0 ULONG val);
ULONG __asm lowbit(register __d0 ULONG val);
ULONG __asm oddparity(register __d0 ULONG val);
ULONG __asm evenparity(register __d0 ULONG val);

/*
 * integer square root
 */

ULONG __asm isqrt(register __d0 ULONG v);

#if 0
/* Crap? */

/*
 * quicksort
 */

void __asm quicksort(register __a0 void *base, register __d0 ULONG elem,
	register __d1 UWORD width, register __a1 int (*compare_fn)
		(register __a0 void *e1, register __a1 void *e2));

#endif
