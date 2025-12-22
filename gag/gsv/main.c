
#include <intuition/intuition.h>
#include <exec/memory.h>

struct IntuitionBase *IntuitionBase;
struct Screen *scr;
struct Window *wind;
struct IntuiMessage *messi;

extern UWORD gsvData[13446];
extern struct Image gsv;

struct Gadget gad3 =
{
    NULL,
    395, 6,
    19, 19,
    GFLG_GADGHCOMP,
    GACT_RELVERIFY,
    GTYP_BOOLGADGET,
    NULL,
    NULL,
    NULL,
    0,0,3,0
};

struct Gadget gad2 =
{
    &gad3,
    344, 117,
    72, 25,
    GFLG_GADGHCOMP,
    GACT_RELVERIFY,
    GTYP_BOOLGADGET,
    NULL,
    NULL,
    NULL,
    0,0,2,0
};
struct Gadget gad1 =
{
    &gad2,
    344, 52,
    72, 25,
    GFLG_GADGHCOMP,
    GACT_RELVERIFY,
    GTYP_BOOLGADGET,
    NULL,
    NULL,
    NULL,
    0,0,1,0
};

    int terminate=FALSE;

int
main(int argc, char *argv[])
{
    void *mem;
    char pubname[MAXPUBSCREENNAME];
    ULONG oldpalette[8];
    int x, y, rt=0, p=0;

    if ((IntuitionBase = (struct IntuitionBase*)OpenLibrary("intuition.library", 36L)) == NULL)
    {
        puts("failed on intuition"); exit(100);
    }
    if ((mem=(void*)AllocVec(sizeof(UWORD)*13446, MEMF_CHIP)) == NULL)
    {
        puts("no chip mem"); CloseLibrary(IntuitionBase); exit(100);
    }

    if (argc==2)
        p=atoi(argv[1]);

    Delay((ULONG)p);

    GetDefaultPubScreen(pubname);

    if ((scr = LockPubScreen(pubname)) == NULL)
    { puts("no pubscreen"); FreeVec(mem); CloseLibrary(IntuitionBase); exit(100); }

    x=scr->Width; y=scr->Height;

    oldpalette[0] = GetRGB4(scr->ViewPort.ColorMap, 0);
    oldpalette[1] = GetRGB4(scr->ViewPort.ColorMap, 1);
    oldpalette[2] = GetRGB4(scr->ViewPort.ColorMap, 2);
    oldpalette[3] = GetRGB4(scr->ViewPort.ColorMap, 3);
    oldpalette[4] = GetRGB4(scr->ViewPort.ColorMap, 4);
    oldpalette[5] = GetRGB4(scr->ViewPort.ColorMap, 5);
    oldpalette[6] = GetRGB4(scr->ViewPort.ColorMap, 6);
    oldpalette[7] = GetRGB4(scr->ViewPort.ColorMap, 7);

    SetRGB4(&scr->ViewPort, 0, 0x0, 0x0, 0x0);
    SetRGB4(&scr->ViewPort, 1, 0x8, 0x0, 0x0);
    SetRGB4(&scr->ViewPort, 2, 0x0, 0x8, 0x8);
    SetRGB4(&scr->ViewPort, 3, 0x8, 0x8, 0x8);
    SetRGB4(&scr->ViewPort, 4, 0x0, 0x0, 0x8);
    SetRGB4(&scr->ViewPort, 5, 0xF, 0x0, 0x0);
    SetRGB4(&scr->ViewPort, 6, 0xB, 0xB, 0xB);
    SetRGB4(&scr->ViewPort, 7, 0xF, 0xF, 0xF);

    if((wind = (struct Window *) OpenWindowTags(NULL,
        WA_Left, (x-423)/2,
        WA_Top, (y-166)/2,
        WA_Width, 423, WA_Height, 166,
        WA_Borderless, TRUE, WA_Activate, TRUE,
        WA_PubScreenName, pubname,
        WA_IDCMP, IDCMP_GADGETUP|IDCMP_VANILLAKEY,
        WA_Gadgets, &gad1,
        TAG_DONE)) == NULL)
    {
        puts("failed on win"); FreeVec(mem); CloseLibrary(IntuitionBase); exit(100);
    }

    UnlockPubScreen(NULL, scr);

    CopyMem(gsvData, mem, sizeof(UWORD)*13446);
    gsv.ImageData = mem;

    DrawImage(wind->RPort, &gsv, 0, 0);

    while (!terminate)
    {
        while ((messi=(struct IntuiMessage *)GetMsg(wind->UserPort)) == NULL)
            WaitPort(wind->UserPort);

        if (messi->Class == IDCMP_GADGETUP)
            switch(((struct Gadget *)messi->IAddress)->GadgetID)
            {
                case 1:
                    rt=0; terminate=TRUE; break;
                case 2:
                    rt=1; terminate=TRUE; break;
                case 3:
                    rt=5; terminate=TRUE; break;
            }
        if (messi->Class == IDCMP_VANILLAKEY)
            switch(messi->Code)
            {
                case 'c':
                case 'C':
                case 13:
                    rt=0; terminate=TRUE; break;
                case 'd':
                case 'D':
                case 27:
                    rt=1; terminate=TRUE; break;
            }
        ReplyMsg(messi);
    }

    SetRGB4(&scr->ViewPort, 0, (oldpalette[0]& 0xF00)>>8, (oldpalette[0]& 0xF0)>>4, oldpalette[0] & 0xF);
    SetRGB4(&scr->ViewPort, 1, (oldpalette[1]& 0xF00)>>8, (oldpalette[1]& 0xF0)>>4, oldpalette[1] & 0xF);
    SetRGB4(&scr->ViewPort, 2, (oldpalette[2]& 0xF00)>>8, (oldpalette[2]& 0xF0)>>4, oldpalette[2] & 0xF);
    SetRGB4(&scr->ViewPort, 3, (oldpalette[3]& 0xF00)>>8, (oldpalette[3]& 0xF0)>>4, oldpalette[3] & 0xF);
    SetRGB4(&scr->ViewPort, 4, (oldpalette[4]& 0xF00)>>8, (oldpalette[4]& 0xF0)>>4, oldpalette[4] & 0xF);
    SetRGB4(&scr->ViewPort, 5, (oldpalette[5]& 0xF00)>>8, (oldpalette[5]& 0xF0)>>4, oldpalette[5] & 0xF);
    SetRGB4(&scr->ViewPort, 6, (oldpalette[6]& 0xF00)>>8, (oldpalette[6]& 0xF0)>>4, oldpalette[6] & 0xF);
    SetRGB4(&scr->ViewPort, 7, (oldpalette[7]& 0xF00)>>8, (oldpalette[7]& 0xF0)>>4, oldpalette[7] & 0xF);

    CloseWindow(wind);
    FreeVec(mem);
    CloseLibrary(IntuitionBase);
}

