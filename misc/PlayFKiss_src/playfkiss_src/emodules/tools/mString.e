/* mString: new string functions */

OPT PREPROCESS
OPT MODULE

#define CPU020

/****** mString/mStrLeft **************************************************
*
*   NAME
*       mStrLeft -- copy leftmost characters
*
*   SYNOPSIS
*       mStrMap(str,len,pad)
*
*   FUNCTION
*       The result is a string of a len characters made up of the leftmost
*       characters in str. If len is grater than the lenght of str, then
*       the string returned is filled out on the right width pad string.
*
*   INPUTS
*       str     - pointer to string to operate on.
*       len     - the lenght of a string to create.
*       pad     - pointer to the padding string. By default it contains a
*                 single space.
*
*   RESULT
*       Pointer to a new e-string.
*
**************************************************************************/
EXPORT PROC mStrLeft(str,len,pad=NIL)
  DEF ret:PTR TO CHAR,strlen,padlen,i
  ret:=String(len)
  strlen:=StrLen(str)
  IF strlen>=len
    StrCopy(ret,str,len)
  ELSE
    /* By default we pad with spaces */
    IF pad=NIL THEN pad:=' '
    StrCopy(ret,str,strlen)
    padlen:=StrLen(pad)
    FOR i:=0 TO ((len-strlen)/padlen) DO StrAdd(ret,pad,padlen)
  ENDIF
ENDPROC ret


/*
** Reverse order of bytes in a string
*/
EXPORT PROC mStrFlip(str)
  DEF len,newstr
  len:=StrLen(str)
  newstr:=String(len)
  MOVE.L len,D0
  SUBI.L #1,D0
  MOVE.L str,A0
  ADD.L  len,A0
  MOVE.L newstr,A1
  loop:
  MOVE.B -(A0),(A1)+
  DBF    D0,loop
  MOVE.B #0,(A1)+
ENDPROC newstr

EXPORT PROC mStrClear(str)
  DEF len,pos=0,space_beg=0,space_end=0,newstr:PTR TO CHAR
  len:=StrLen(str)
  /* Wyciëcie wszelkich bonusowych spacji */
  /* Wpierw liczymy iloôê zbëdnych spacji na poczâtku i koïcu zdania */
  WHILE (Char(str+pos))=$20 -> $20 to kod spacji
    ADDQ.L #1,space_beg
    ADDQ.L #1,pos
  ENDWHILE
  pos:=len-1
  WHILE (Char(str+pos)=$20) -> $20 to kod spacji
    ADDQ.L #1,space_end
    SUBQ.L #1,pos
  ENDWHILE
  /* Kopiowanie z pomin¡ëciem spacji */
  newstr:=String(len-(space_beg+space_end))
  IF (space_beg OR space_end) THEN MidStr(newstr,str,space_beg,len-(space_beg+space_end))
ENDPROC newstr

EXPORT PROC mAddPart(dir,name,maxbuf)
  AddPart(dir,name,maxbuf)
  SetStr(dir,StrLen(dir))
ENDPROC

EXPORT PROC mStrCmp(str,to,from=0)
  DEF len,tmp:PTR TO CHAR,r
  len:=StrLen(to)
  tmp:=String(len)
  /* Wyciëcie interesujâcego nas fragmentu */
  MidStr(tmp,str,from,len)
  /* Porównanie */
  r:=StrCmp(tmp,to)
  /* Zwolnienie pamiëci */
  DisposeLink(tmp)
ENDPROC r

EXPORT PROC mStrCount(str,what,from=0)
  DEF len,i=0,found,last
  IF (len:=StrLen(str))=0 THEN RETURN -1
  IF (last:=from)>len THEN RETURN -1
  WHILE (found:=InStr(str,what,last))>-1
    ADDQ.L #1,i
    last:=found+1
  ENDWHILE
ENDPROC i

/*
** Count occurances of all characters
*/
EXPORT PROC mCharPrepCT(str:PTR TO CHAR,from=0)
  DEF ct:PTR TO LONG,i
  -> memory for count table
  ct:=FastNew(256*4)
  i:=from
  -> count occurances
  WHILE str[i]>0
    ct[str[i]]:=ct[str[i]]+1
    INC i
  ENDWHILE
ENDPROC ct

/*
** Return number of occurances of selected charcter
*/
EXPORT PROC mCharCount(string,char,from=0)
  DEF ct:PTR TO LONG
  ct:=mCharPrepCT(string,from)
ENDPROC ct[char]

/*
** Returns position of N occurance of what in str
*/
EXPORT PROC mStrPos(str,what,which=1)
  DEF i=0,found,last=0
  WHILE (found:=InStr(str,what,last))>-1 AND (i<which)
    INC i
    last:=found+1
  ENDWHILE
ENDPROC last-1

/****** mString/mStrMap ***************************************************
*
*   NAME
*       mStrMap -- map string contents
*
*   SYNOPSIS
*       mStrMap(str,table,tablen)
*
*   FUNCTION
*       Replaces characters in string.
*
*   INPUTS
*       str     - pointer to string to operate on.
*       table   - pointer to array of bytes. This array is used do define
*                 which characters to look for, and what to puts instead.
*                 It contains number of pairs, where first character is the
*                 to look for in string and the second is put in place of
*                 the first one.
*
*   RESULT
*       This function always returns NIL.
*
**************************************************************************/
EXPORT PROC mStrMap(str:PTR TO CHAR,table:PTR TO CHAR,tablen,from=0)
  DEF convtab:PTR TO CHAR,i=0
  -> allocate memory for conversion table
  convtab:=FastNew(256)
  CopyMemQuick({map_def},convtab,256)
  -> calculate real length
  tablen:=tablen+tablen
  -> prepare conversion table
  REPEAT
    convtab[table[i]]:=table[i+1]
    i:=i+2
  UNTIL i>=tablen
  -> map string
  mStrMapFast(str,convtab,from)
  -> free memory
  FastDispose(convtab,256)
ENDPROC NIL

/*
** Map string using predefined conversion table
*/
EXPORT PROC mStrMapFast(str:PTR TO CHAR,convtab:PTR TO CHAR,from=0)
  DEF i=0
 -> map string
  i:=from
  WHILE str[i]>0
    str[i]:=convtab[str[i]]
    INC i
  ENDWHILE
ENDPROC NIL

map_def:
CHAR 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,
     55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,
     81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,
     105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,
     124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,
     143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,
     162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,
     181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,
     200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,
     219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,
     238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255
