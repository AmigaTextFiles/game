#include "computer_player.h"
#include "gameboardclass.h"
#include <stdlib.h>
#include <stdio.h>
#include <resources/battclock.h>
#include <clib/exec_protos.h>
#include <clib/battclock_protos.h>

//#define THREE_S_DEBUG
//#define THREE_WE_DEBUG
//#define THREE_NWSE_DEBUG
//#define THREE_NESW_DEBUG

/*
**  Inputs:
**          skill_level     1 being the lowest skill level
**                          1 being the highest skill level
**          filled          2D array describing gameboard contents
**          columntop       array giving row number of topmost piece in each column
**          current_player  see "gameboardclass.h" for details
**          newgame         boolean switch to initialise player before each game
**
**  Result:
**          Computer player's choice of column in which to place piece
**          -1 on error
*/
APTR BattClockBase=NULL;

int computer_player (int skill_level, char (*filled)[5], char *columntop, ULONG current_player, BOOL newgame)
{
    enum {ERROR=-1};

    if (BattClockBase=OpenResource(BATTCLOCKNAME))
    {
        if (newgame)
            srand(ReadBattClock()); // Seed the random generator with the system clock
                                    // to ensure the moves are different each time
        switch (skill_level)
        {
            // just needs columntop
            case 1:
            {
                int result;
                BOOL badmove=TRUE;

                while (badmove)
                {
                    result=rand();
                    result-=(result/7)*7;
                    if (columntop[result]!=4)
                        badmove=FALSE;
                }

                return result;
            }

            case 2:
            {
                int result;
                ULONG opponent;

                if (current_player=red_player)
                    opponent=yellow_player;
                else
                    opponent=red_player;

                if ((result=capthree(filled, columntop, opponent))!=-1)
                    return result;

                {
                    BOOL badmove=TRUE;

                    while (badmove)
                    {
                        result=rand();
                        result-=(result/7)*7;
                        if (columntop[result]!=4)
                            badmove=FALSE;
                    }

                    return result;
                }
            }

            default:
                return ERROR;
        }
    }

    return ERROR;
}


// calls helper functions three[S|WE|NWSE|NESW] to try and stop an opponent's
// line of three turning into *gulp* a line of four!
int capthree (char (*filled)[5], char *columntop, ULONG opponent)
{
    int result;

    if ((result=threeS(filled, columntop, opponent))!=-1)
    {
        #ifdef THREE_S_DEBUG
        printf("threeS=%d\n", result);
        #endif
        return result;
    }

    if ((result=threeWE(filled, columntop, opponent))!=-1)
    {
        #ifdef THREE_WE_DEBUG
        printf("threeWE=%d\n", result);
        #endif
        return result;
    }

    if ((result=threeNWSE(filled, columntop, opponent))!=-1)
    {
        #ifdef THREE_NWSE_DEBUG
        printf("threeNWSE=%d\n", result);
        #endif
        return result;
    }

    if ((result=threeNESW(filled, columntop, opponent))!=-1)
    {
        #ifdef THREE_NESW_DEBUG
        printf("threeNESW=%d\n", result);
        #endif
        return result;
    }

    return -1;
}

int threeS (char (*filled)[5], char *columntop, ULONG opponent)
{
    char column;

    for (column=0; column<7; column++)
    {
        #ifdef THREE_S_DEBUG
        printf("column=%d\n", column);
        #endif
        if (columntop[column]!=4 && columntop[column]!=-1)   // Only examine the column if it isn't already full or isn't completely empty
        {      
            char row, oppcount=0;
            #ifdef THREE_S_DEBUG
            printf("  scanning...\n");
            #endif
            for (row=0; row<=columntop[column]; row++)
            {
                #ifdef THREE_S_DEBUG
                printf("    row=%d\n", row);
                #endif
                if (filled[column][row]==opponent)
                    oppcount++;
                else
                    oppcount=0;
                #ifdef THREE_S_DEBUG
                printf("      oppcount=%d\n", oppcount);
                #endif
            }

            if (oppcount==3)    // opponent has a vertical line of 3 pieces
                return column;
        }
        #ifdef THREE_S_DEBUG
        else
            puts("  skipped");
        puts("");
        #endif
    }

    return -1;
}


int threeWE (char (*filled)[5], char *columntop, ULONG opponent)
{
    char column, row, potential, emptyhole;
    enum {EMPTYHOLE=-1};
 
    for (row=0; row<5; row++)
    {
        #ifdef THREE_WE_DEBUG
        printf("row=%d\n", row);
        #endif
        potential=0;
        emptyhole=EMPTYHOLE;
        for (column=0; column<7; column++)
        {
            if (filled[column][row]==EMPTYHOLE)
            {
                if (emptyhole==EMPTYHOLE)
                    potential++;
                else
                    potential=1;
                emptyhole=column;

                #ifdef THREE_WE_DEBUG
                printf("  emptyhole=%d  potential=%d\n", emptyhole, potential);
                #endif
            }
            else if (filled[column][row]==opponent)
            {
                potential++;
                #ifdef THREE_WE_DEBUG
                printf("  potential=%d\n", potential);
                #endif
            }
            else
            {
                potential=0;
                emptyhole=EMPTYHOLE;
                #ifdef THREE_WE_DEBUG
                puts("  potential reset");
                #endif
            }

            if (potential==4)
            {
                if (columntop[emptyhole]==row-1)
                    return emptyhole;
            }
        }

    }

    return -1;
}


int threeNWSE (char (*filled)[5], char *columntop, ULONG opponent)
{
    char diagrow, potential, diagcolumn, diagonal, emptyhole, rowencountered;
    enum {EMPTYHOLE=-1, NOROW=-1};

    for (diagonal=7; diagonal>2; diagonal--)
    {
        potential=0;
        diagrow=0;
        emptyhole=EMPTYHOLE;
        rowencountered=NOROW;

        for (diagcolumn=diagonal; diagrow<5; diagcolumn--)
        {
            if (diagcolumn>=0 && diagcolumn<=6)
            {
                #ifdef THREE_NWSE_DEBUG
                printf("[diagcolumn:%d][diagrow:%d]=%d\n", diagcolumn, diagrow, filled[diagcolumn][diagrow]);
                #endif
                if (filled[diagcolumn][diagrow]==EMPTYHOLE && emptyhole==EMPTYHOLE)
                {
                    emptyhole=diagcolumn;
                    rowencountered=diagrow;
                    potential++;
                    #ifdef THREE_NWSE_DEBUG
                    printf("  emptyhole=%d  potential=%d\n", emptyhole, potential);
                    #endif
                }
                else if (filled[diagcolumn][diagrow]==opponent)
                {
                    potential++;
                    #ifdef THREE_NWSE_DEBUG
                    printf("  potential=%d\n", potential);
                    #endif
                }
                else
                {
                    potential=0;
                    emptyhole=EMPTYHOLE;
                    rowencountered=NOROW;
                    #ifdef THREE_NWSE_DEBUG
                    puts("  potential reset");
                    #endif
                }

                if (potential==4)
                {
                    if (columntop[emptyhole]==rowencountered-1)
                        return emptyhole;
                }
            }

            diagrow++;
            #ifdef THREE_NWSE_DEBUG
            puts("");
            #endif
        }
        
    }

    return -1;
}


int threeNESW (char (*filled)[5], char *columntop, ULONG opponent)
{
    char diagrow, potential, diagcolumn, diagonal, emptyhole, rowencountered;
    enum {EMPTYHOLE=-1, NOROW=-1};

    for (diagonal=-1; diagonal<4; diagonal++)
    {
        potential=0;
        diagrow=0;
        emptyhole=EMPTYHOLE;
        rowencountered=NOROW;

        for (diagcolumn=diagonal; diagrow<5; diagcolumn++)
        {
            if (diagcolumn>=0 && diagcolumn<=6)
            {
                #ifdef THREE_NESW_DEBUG
                printf("[diagcolumn:%d][diagrow:%d]=%d\n", diagcolumn, diagrow, filled[diagcolumn][diagrow]);
                #endif
                if (filled[diagcolumn][diagrow]==EMPTYHOLE && emptyhole==EMPTYHOLE)
                {
                    emptyhole=diagcolumn;
                    rowencountered=diagrow;
                    potential++;
                    #ifdef THREE_NESW_DEBUG
                    printf("  emptyhole=%d  potential=%d\n", emptyhole, potential);
                    #endif
                }
                else if (filled[diagcolumn][diagrow]==opponent)
                {
                    potential++;
                    #ifdef THREE_NESW_DEBUG
                    printf("  potential=%d\n", potential);
                    #endif
                }
                else
                {
                    potential=0;
                    emptyhole=EMPTYHOLE;
                    rowencountered=NOROW;
                    #ifdef THREE_NESW_DEBUG
                    puts("  potential reset");
                    #endif
                }

                if (potential==4)
                {
                    if (columntop[emptyhole]==rowencountered-1)
                        return emptyhole;
                }
            }

            diagrow++;
            #ifdef THREE_NWSE_DEBUG
            puts("");
            #endif
        }
        
    }

    return -1;
}



