#include <proto/locale.h>
#include <intuition/classes.h>

#define APP_VER      "1.1"
#define APP_DATE     "26.09.2012"
#define APP_AUTHOR   "Grzegorz Kraszewski"
#define APP_NAME     "Sudominator"
#define APP_CYEARS   "2010-2012"
#define APP_BASE     "SUDOMINATOR"
#define APP_DESC     "Sudoku solver"
#define APP_BUILD    __SVNVERSION__
#define STRING(x)    #x
#define APP_BUILDS(x) STRING(x)

#define xset(obj, attr, val) SetAttrs(obj, attr, (LONG)val, TAG_END);
#define xnset(obj, attr, val) DoMethod(obj, MUIM_NoNotifySet, attr, (LONG)val);
#define UNUSED __attribute__((unused))
#define LCS(id, str) GetCatalogStr(Cat, id, (STRPTR)str)
#define findobj(id, parent) (Object*)DoMethod(parent, MUIM_FindUData, id)

Object* DoSuperNewM(Class *cl, Object *obj, ...);
Object* MUI_NewObjectM(char *classname, ...);
Object* NewObjectM(Class *cl, char *classname, ...);
IPTR xget(Object *obj, ULONG attr);

extern struct Library
	*SysBase,
	*DOSBase,
	*GfxBase,
	*IntuitionBase,
	*MUIMasterBase,
	*LocaleBase,
	*UtilityBase,
	*CyberGfxBase,
	*RandomBase;

extern struct Catalog *Cat;
extern Object *PrefsWin;

#define MSG_APPLICATION_DESCRIPTION                            0
#define MSG_MENU_PROJECT                                       1
#define MSG_MENUITEM_QUIT                                      2
#define MSG_MENUITEM_OPEN                                      3
#define MSG_MENUITEM_SAVE                                      4
#define MSG_MENUITEM_ABOUT                                     5
#define MSG_SUDOKUAREA_HELP                                    6
#define MSG_BUTTON_SOLVEQUICK                                  7
#define MSG_BUTTON_SOLVELIVE                                   8
#define MSG_BUTTON_HINTRANDOM                                  9
#define MSG_BUTTON_HINTSELECTED                               10
#define MSG_MENUITEM_NEW                                      11
#define MSG_CANT_START_LIVESOLVER                             12
#define MSG_STATUS_UNRESOLVABLE                               13
#define MSG_STATUS_SOLVED                                     14
#define MSG_STATUS_STOPPED                                    15
#define MSG_STATUS_DUP_IN_ROW                                 16
#define MSG_STATUS_DUP_IN_COLUMN                              17
#define MSG_STATUS_DUP_IN_BOX                                 18
#define MSG_BUTTON_SOLVEQUICK_HELP                            19
#define MSG_BUTTON_SOLVELIVE_HELP                             20
#define MSG_PROGRAM_LICENSE                                   21
#define MSG_PREFS_SUDOKU_FOREGROUND_COLOR_LABEL               22
#define MSG_MENU_SETTINGS                                     23
#define MSG_MENUITEM_SETTINGS_SUDOMINATOR                     24
#define MSG_MENUITEM_SETTINGS_MUI                             25
#define MSG_PREFS_WINDOW_TITLE                                26
#define MSG_PREFS_SELECTED_FIELD_BRIGHTNESS_LABEL             27
#define MSG_PREFS_SAVE_BUTTON                                 28
#define MSG_PREFS_SAVE_BUTTON_HOTKEY                          29
#define MSG_PREFS_USE_BUTTON                                  30
#define MSG_PREFS_USE_BUTTON_HOTKEY                           31
#define MSG_PREFS_CANCEL_BUTTON                               32
#define MSG_PREFS_CANCEL_BUTTON_HOTKEY                        33
#define MSG_LIVE_SOLVING_REPORT                               34
#define MSG_SAVE_REQUESTER_WINDOW_TITLE                       35
#define MSG_UNNAMED_SUDOKU_FILE_NAME                          36
#define MSG_ERROR_WRITING_SUDOKU                              37
#define MSG_ERROR_OPENING_FOR_WRITE                           38
#define MSG_SAVE_LIVE_SOLVER_REQUESTER_BUTTONS                39
#define MSG_SAVE_LIVE_SOLVER_REQUESTER_TEXT                   40
#define MSG_DOS_ERROR_REQUESTER_BUTTON                        41
#define MSG_CLEAR_LIVE_SOLVER_REQUESTER_BUTTONS               42
#define MSG_CLEAR_LIVE_SOLVER_REQUESTER_TEXT                  43
#define MSG_LOAD_LIVE_SOLVER_REQUESTER_BUTTONS                44
#define MSG_LOAD_LIVE_SOLVER_REQUESTER_TEXT                   45
#define MSG_LOAD_ERROR_SUDOKU_INVALID_BUTTON                  46
#define MSG_LOAD_ERROR_SUDOKU_INVALID_TEXT                    47
#define MSG_ERROR_READING_SUDOKU                              48
#define MSG_STATUS_SELECT_FIELD                               49
#define MSG_STATUS_RANDOM_FIELD_DONE                          50
#define MSG_STATUS_SELECTED_FIELD_DONE                        51
#define MSG_BUTTON_HINTRANDOM_HELP                            52
#define MSG_BUTTON_HINTSELECTED_HELP                          53
#define MSG_MENUITEM_EDIT_COPY                                54
