#ifndef GAME_H
#define GAME_H

struct coords
{
    int x,y;
    BOOL z;
};

struct score
{
    int bricks;
    ULONG value;
    char player[11];
};

struct ball
{
    struct coords coin[5];
};

struct brick
{
    int colour,x1,y1,hit;
};

struct grid
{
    struct brick tab[11][13];
    int score,scoretotal,taille,total;  // taille == size or height ???
};

void DisplayGrid(struct grid *grid1);
void Lives(int a);
void GameOver(struct score *player);
void DisplayScore(struct grid *player);
void DisplayLevel(int levelnumber);
void LimitMUR(struct ball *ball1,struct coords *step);
BOOL LimitY(struct ball *ball1,int posi,struct coords *step);
void ReactTOUCHE(int cote, int x, int y,struct ball *ball1,struct coords *step,struct grid *grid1);
void LimitBricks(struct ball *ball1,struct coords *step,struct grid *grid1);
BOOL Game_MoveBall(struct ball *ball1,int posi,struct coords *step,struct grid *grid1);

// New in version 1.15
void LoadScore(struct score *score1,int rank);
void SaveScore(struct score *score1,int rank);

// => LevelSUPP Unit in pascal version
void LoadLevel(int levelnumber, struct grid *level, STRPTR filename);
void SaveLevel(int levelnumber, struct grid *level, STRPTR filename);


#endif
