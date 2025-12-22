/*
 * boardgadget.h
 * =============
 * The board gadget.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef BOARDGADGET_H
#define BOARDGADGET_H

#include <exec/types.h>
#include <utility/tagitem.h>
#include <intuition/classes.h>


typedef enum {
  OPPONENT_HUMAN,
  OPPONENT_COMPUTER
} Opponent;

typedef enum {
  CORRECTION_METHOD_CHILDREN,
  CORRECTION_METHOD_ADULTS
} CorrectionMethod;


#define BOARD_Dummy              (TAG_USER + 0)
#define BOARD_Opponent           (BOARD_Dummy + 1)
#define BOARD_CorrectionMethod   (BOARD_Dummy + 2)
#define BOARD_Panel              (BOARD_Dummy + 3)
#define BOARD_EnterButton        (BOARD_Dummy + 4)
#define BOARD_NewGame            (BOARD_Dummy + 5) /* PRIVATE! */
#define BOARD_EnterRow           (BOARD_Dummy + 6) /* PRIVATE! */


extern Class *CreateBoardClass(VOID);

extern VOID BoardNewGame(struct Gadget *board, struct Window *win,
			 Opponent opponent, CorrectionMethod corrMethod);
extern VOID BoardEnterRow(struct Gadget *board, struct Window *win);

#endif /* BOARDGADGET_H */
