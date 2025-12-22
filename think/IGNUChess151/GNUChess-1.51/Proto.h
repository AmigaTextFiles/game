/************************************************************************/
/* Prototypes for GNUChess Functions									*/
/************************************************************************/

int		VerifyMove(char *, short, unsigned short *);
void	NewGame(void);
void	algbr(short, short, short);
int		SelectMove(short, short);
void	MoveList(short, short);
int		castle(short, short, short, short);
void	InitializeStats(void);
int		SqAtakd(short, short);
void	ScorePosition(short, short *);
short	SqValue(short, short);
void	ExaminePosition(void);
short	distance(short, short);
