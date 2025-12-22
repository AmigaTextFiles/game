/*
** External functions which will be called by the buttons
** via a hook -structure.
**
** NOTE: Since we're using GNU/C, we must provide an Entry()
**       point which pushes the object argument onto the stack:
*
*  _hookEntry:      move.l  a1,-(sp)
*                   move.l  a2,-(sp)
*                   move.l  a0,-(sp)
*                   move.l  h_SubEntry(a0),a0
*                   jsr     (a0)
*                   add.w   #12,sp
*                   rts
*
* To get results from MUI, we must change the source AmberCheat_gui.c to
* reflect this.
*/

#ifdef cplusplus
extern void "C" ChangeRegPage(Object *);
extern void "C" DoUndo(Object *);
extern void "C" CreateCharacter(Object *);
extern void "C" SaveCharacters(Object *);
extern void "C" ReallyQuit(Object *);
extern void "C" ChangeCharacter(Object *);
extern void "C" ChangeIt(Object *);
#else
extern void ChangeRegPage(Object *);
extern void DoUndo(Object *);
extern void CreateCharacter(Object *);
extern void SaveCharacters(Object *);
extern void ReallyQuit(Object *);
extern void ChangeCharacter(Object *);
extern void ChangeIt(Object *);
extern void InfoReq(Object *);
extern void AboutMUI( Object * );
#endif
