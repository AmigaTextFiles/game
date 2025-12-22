/************************************************************************/
/* Prototypes for GUI functions											*/
/************************************************************************/

void Initialize(void);
void ExitChess(int);
void InputCommand(void);
void help(void);
void EditBoard(void);
void ShowDepth(char);
void ShowResults(short, unsigned short *, char);
void SearchStartStuff(short);
void OutputMove(void);
void ElapsedTime(short );
void SetTimeControl(void);
void ClrScreen(void);
void UpdateDisplay(short, short, short, short);
void GetOpenings(void);
void ShowMessage(char *);
void ClearMessage(void);
void ShowSidetomove(void);
void PromptForMove(void);
void ShowCurrentMove(short, short, short);
void SelectLevel(void);
void DrawPiece(short);

ULONG ModeID( char * );
extern ULONG DisplayID;
