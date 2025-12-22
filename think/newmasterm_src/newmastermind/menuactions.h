/*
 * menuactions.h
 * =============
 * The menu actions.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef MENUACTIONS_H
#define MENUACTIONS_H

#include <exec/types.h>


extern VOID New(VOID);
extern VOID About(VOID);
extern VOID Quit(VOID);
extern VOID ColorDisplay(BOOL checked);
extern VOID OpponentHuman(BOOL checked);
extern VOID OpponentComputer(BOOL checked);
extern VOID CorrectionChildren(BOOL checked);
extern VOID CorrectionAdults(BOOL checked);
extern VOID NumColors4(BOOL checked);
extern VOID NumColors6(BOOL checked);
extern VOID NumColors8(BOOL checked);
extern VOID SaveSettingsAction(VOID);

#endif /* MENUACTIONS_H */
