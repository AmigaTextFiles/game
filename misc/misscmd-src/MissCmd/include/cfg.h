#ifndef GAME_CFG_H
#define GAME_CFG_H 1

/* cfg.c */
int CFGBoolean (char * attr);
int32 CFGInteger (char * attr, int32 def);
char * CFGString (char * attr, char * def);

#endif /* GAME_CFG_H */
