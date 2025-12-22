/*
 * Patch Marble Madness.
 *
 * Usage: cd <Marble Madness disk>
 *        mmpatch
 *
 * > removes protection on c/xxx, c/zzz, c/MarbleMadness!.dat
 *   - 2.0+ actually checks for read protection
 *
 * > applies standard patch to c/xxx (taken from QuickCopy)
 *   - changes some conditional branches to unconditional
 *   - inserts some immediate constants
 *   
 * > applies patch to c/zzz
 *   - original reads some values from low memory and from the Task struct,
 *     expecting the third nybble to be 0xFC (i.e., pointers into ROM);
 *     512k ROMs are at 0xF8xxxx, so this no longer works
 *   - patch uses immediate values instead
 *
 * Derek Noonburg
 * derekn@ece.cmu.edu
 * 29-April-93
 */

#include <stdio.h>
#include <stdlib.h>
#include <exec/types.h>
#include <dos/dos.h>
#include <proto/dos.h>

#define XXXNAME "c/xxx"
#define ZZZNAME "c/zzz"
#define DATNAME "c/MarbleMadness!.dat"
#define SIGNAME "c/sigfile"
#define XXXLEN 6116
#define ZZZLEN 4948

int
main()
{
    BPTR f;
    static UBYTE buf[XXXLEN];
    UWORD *wbuf = (UWORD *)buf;

    SetProtection(XXXNAME, 0);
    SetProtection(ZZZNAME, 0);
    SetProtection(DATNAME, 0);
    SetProtection(SIGNAME, 0);

    if (!(f = Open(XXXNAME, MODE_OLDFILE))) {
        fprintf(stderr, "Can't open file\n");
        exit(1);
    }
    Read(f, buf, XXXLEN);
    buf[0x1bc] = 0x25;
    buf[0x1c0] = 0x9b;
    buf[0x1c4] = 0x6e;
    buf[0x1c6] = 0x83;
    buf[0x1c7] = 0x78;
    buf[0x336] = 0x40;
    buf[0x337] = 0xad;
    buf[0x386] = 0xaf;
    buf[0x387] = 0x3e;
    buf[0x38b] = 0x43;
    buf[0x38e] = 0x53;
    buf[0x38f] = 0xb1;
    Seek(f, 0, OFFSET_BEGINNING);
    Write(f, buf, XXXLEN);
    Close(f);

    if (!(f = Open(ZZZNAME, MODE_OLDFILE))) {
        fprintf(stderr, "Can't open file\n");
        exit(1);
    }
    Read(f, buf, ZZZLEN);
    wbuf[0x82a] = 0x2f3c;   /* move.l #fc000000,-(a7) */
    wbuf[0x82b] = 0x00fc;
    wbuf[0x82c] = 0x0000;
    wbuf[0x82d] = 0x4e71;   /* nop */
    wbuf[0x82e] = 0x4e71;   /* nop */
    wbuf[0x82f] = 0x4e71;   /* nop */
    wbuf[0x830] = 0x4e71;   /* nop */
    wbuf[0x848] = 0x2f3c;   /* move.l #fc000000,-(a7) */
    wbuf[0x849] = 0x00fc;
    wbuf[0x84a] = 0x0000;
    wbuf[0x84b] = 0x4e71;   /* nop */
    wbuf[0x864] = 0x2f3c;   /* move.l #fc000000,-(a7) */
    wbuf[0x865] = 0x00fc;
    wbuf[0x866] = 0x0000;
    wbuf[0x867] = 0x4e71;   /* nop */
    wbuf[0x873] = 0x2f3c;   /* move.l #fc000000,-(a7) */
    wbuf[0x874] = 0x00fc;
    wbuf[0x875] = 0x0000;
    wbuf[0x876] = 0x4e71;   /* nop */
    wbuf[0x87e] = 0x2f3c;   /* move.l #fc000000,-(a7) */
    wbuf[0x87f] = 0x00fc;
    wbuf[0x880] = 0x0000;
    wbuf[0x881] = 0x4e71;   /* nop */
    Seek(f, 0, OFFSET_BEGINNING);
    Write(f, buf, ZZZLEN);
    Close(f);

    return 0;
}
