#ifndef ORM_H
#define ORM_H


/****************************************************************************/


/* This file was created automatically by CatComp.
 * Do NOT edit by hand!
 */


#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif


/****************************************************************************/


#define MSG_SCRTITLE1 0
#define MSG_SCRTITLE1_STR "Orm til Amiga - 1993"

#define MSG_SCRTITLE2 1
#define MSG_SCRTITLE2_STR "Orm til Amiga - 1993 (uden forhindringer)"

#define MSG_EASYREQ_RESULT_TITLE 2
#define MSG_EASYREQ_RESULT_TITLE_STR "Resultat"

#define MSG_EASYREQ_RESULT_GAD 3
#define MSG_EASYREQ_RESULT_GAD_STR "OK"

#define MSG_EASYREQ_RESULT 4
#define MSG_EASYREQ_RESULT_STR "Ormen blev %d led lang"

#define MSG_WINDOWTITLE 5
#define MSG_WINDOWTITLE_STR "Længde: %d"


/****************************************************************************/


#ifdef STRINGARRAY

struct AppString
{
    LONG   as_ID;
    STRPTR as_Str;
};

struct AppString AppStrings[] =
{
    {MSG_SCRTITLE1,MSG_SCRTITLE1_STR},
    {MSG_SCRTITLE2,MSG_SCRTITLE2_STR},
    {MSG_EASYREQ_RESULT_TITLE,MSG_EASYREQ_RESULT_TITLE_STR},
    {MSG_EASYREQ_RESULT_GAD,MSG_EASYREQ_RESULT_GAD_STR},
    {MSG_EASYREQ_RESULT,MSG_EASYREQ_RESULT_STR},
    {MSG_WINDOWTITLE,MSG_WINDOWTITLE_STR},
};


#endif /* STRINGARRAY */


/****************************************************************************/


#endif /* ORM_H */
