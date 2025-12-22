// Prototypes for Scott.x :-)
void * MemAlloc(int size);
void Make_FFP(char *file, char *dir);
void LoadDatabase(FILE *f, int loud);
BOOL LoadGame(char *name);
void OutReset();
void OutBuf(char *buffer);
void OutputNumber(int a);
void SaveBody(FILE *f);
void LoadBody(FILE *f);
BOOL SaveRestart();
BOOL LoadRestart();
BOOL Handle_Pic(int Room);
void Look();
int  PerformActions(int vb,int no);
void Init_GFX(void);
void Restart(void);
void Speak(char *original);

