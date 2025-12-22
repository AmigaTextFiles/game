/*
 * panelgadget.h
 * =============
 * The panel gagdet.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef PANELGADGET_H
#define PANELGADGET_H

#include <exec/types.h>
#include <utility/tagitem.h>
#include <intuition/classes.h>


#define PANEL_Dummy         (TAG_USER + 0)
#define PANEL_NumColors     (PANEL_Dummy + 1)
#define PANEL_ActiveColor   (PANEL_Dummy + 2)


extern Class *CreatePanelClass(VOID);

#endif /* PANELGADGET_H */
