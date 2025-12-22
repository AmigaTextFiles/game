/******************************************************
*    ICHINGSTRUCTS.H   Structure definitions for the
*                      I Ching program.
*
*    LAST CHANGED:     9/8/88
*
******************************************************
*/


struct TRIGRAM  {

   struct IntuiText *TriText;
   struct Image     *TriImage;
};

struct PAGE     {

   struct IntuiText *HexName;
   struct TRIGRAM   *Top_Trigram, *Bot_Trigram;

};

/* ------------------- End of IChingStructs.h ------------------ */
