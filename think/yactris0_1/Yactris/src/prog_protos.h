
/* MACHINE GENERATED */


/* yactris.c            */

Prototype void TStartUp(void);
Prototype void Tetris(void);
Prototype struct PieceRot *PickPiece(void);
Prototype void ClearPlayField(void);
Prototype BOOL NewPiece(struct PieceRot *, int, int);
Prototype BOOL MovePiece(enum direction);
Prototype BOOL RotatePiece(void);
Prototype void ByeBye(int);
Prototype void PlacePiece(void);
Prototype BOOL GameOver(void);
Prototype void ResetTet(void);
Prototype void FillInTWindow(struct Window *, struct ScreenInfo *);
Prototype BOOL IsHitting(struct PieceRot *, int, int);
Prototype void DoNewPubScreen(struct Screen *news);
Prototype BOOL VerifyQuit(void);
Prototype int NoBreak(void);

/* intuitet.c           */

Prototype struct ScreenInfo *CreateScrInfo(struct Screen *);
Prototype struct Window *OpenTWindow(struct ScreenInfo *, struct Menu *, LONG, LONG);
Prototype void CloseTWindow(struct Window *);
Prototype void FlagWindow(struct Window *, BOOL);
Prototype void UpdateScores(struct Window *, struct ScreenInfo *, int, int, int);
Prototype struct Screen *InquirePubScreen(struct ScreenInfo *, struct Window *tw);
Prototype struct List *MakePubScrList(void);
Prototype void FreePubScrList(struct List *);
Prototype struct Window *OpenPWindow(struct ScreenInfo *, struct MsgPort *, struct Window *tw);
Prototype void ClosePWindow(struct Window *);
Prototype void DispPCount(struct ScreenInfo *, struct Window *, struct PieceRot *, int);
Prototype void FreeScrInfo(struct ScreenInfo *);

/* makepieces.c         */

Prototype BOOL MakePieces(struct ScreenInfo *);
Prototype BOOL GivePieceBitMap(struct PieceRot *, struct ScreenInfo *);
Prototype void UnMakePieces(struct ScreenInfo *);
Prototype void FreePieceBitMap(struct PieceRot *, struct ScreenInfo *);
Prototype void DrawPiece(struct RastPort *, struct MakeStruct *, struct ScreenInfo *);

/* about.c              */

Prototype void DoAbout(struct Window *);

/* makestructs.c        */

