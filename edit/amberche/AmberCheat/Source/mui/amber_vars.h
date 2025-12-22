#ifndef   AMBER_DEFINES_H
#include  "amber_defines.h"
#endif

/* These variables gets automatical updated by MUI */
extern  ULONG slp, tp, gold, str, mstr, Int, mint, ges, mges, sch, msch;
extern  ULONG kon, mkon, kar, mkar, glu, mglu, anm, manm;
extern  ULONG att, matt, par, mpar, sch2, msch2, kri, mkri, faf, mfaf;
extern  ULONG fae, mfae, sco, msco, suc, msuc, srl, msrl, mab, mmab;
extern  ULONG lp, mlp, sp, msp;
extern  char  name[16];

/* These variables are for open/close the amberSaves */
extern struct AmberSaves   *Saves;
extern struct AmberHeader  *Header;
extern struct AmberHeader  *UndoHeader;
extern struct Character    *ActChar;
extern struct Character    *UndoChar;
extern BPTR                InFile;
extern BPTR                OutFile;
extern BPTR                AmberLock;
extern BPTR                SavesFH;
extern BPTR                OldDir;

extern char                AmberFile[512];
extern char               *AmberDir;

extern char             * SaveDirTempl;
extern char             * SaveFile;
extern char             * CheatFile;
extern char             * NameList[];
extern char             * oNameList[];
extern BOOL            Undo;
extern BOOL            Changes;
extern ULONG           PartyLen;

