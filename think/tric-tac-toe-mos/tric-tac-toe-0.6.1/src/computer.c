/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "computer.h"


extern int cell_state[],
           points[],
           no_delay;

/*
 *  ComputerCellTest() amasses the score possibilities for the given
 *  cell value.
 */

void
ComputerCellTest( int value, int *block, int *seize,
                  int *might_block, int *might_seize,
                  int *along_block, int *along_seize )
{
    int i = 0,
        c = 0,
        connect = 0,
        color[2] = { 0, 0 },
        side = GetFace(value);

    for (connect = 0; connect < NUM_CONNECTORS; ++connect)
    {
        if (ConnectValue(side, connect) != value)
            continue;

        for (i = 0; i < 2; ++i)
            color[i] = cell_state[ConnectValue((side + i + 1) % 3, connect)];

        if (color[0] > -1 && color[0] == color[1])
        {
            if (color[0] != PlayerUp())
            {
                /* Favor a cell that blocks higher scoring players */
                if (block != NULL)
                    *block +=
                        points[color[0]] / (points[PlayerUp()] + 1) + 1;
            }
            else
            {
                if (seize != NULL)
                    *seize += 1;
            }
        }
        else if (color[0] != color[1] && (color[0] == -1 || color[1] == -1))
        {
            c = (color[0] > -1) ? color[0] : color[1];
            if (c != PlayerUp())
            {
                /* Favor a cell that might block a higher scoring player */
                if (might_block != NULL)
                    *might_block +=
                        points[c] / (points[PlayerUp()] + 1) + 1;
            }
            else
            {
                if (might_seize != NULL)
                    *might_seize += 1;
            }
        }
    }

    /* along_block/seize not currently implemented. */
#if 0
    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (GetFace(i) == side && cell_state[i] == -1)
        {
            if (along_block != NULL)
                *along_block += points[c] / (points[PlayerUp()] + 1) + 1;
            if (along_seize != NULL)
                *along_seize += 1;
        }
    }
#endif
}

/*
 *  int ComputerPickCellLevelHard()
 *  
 *  Returns (-1) if unable to pick a cell,
 *  (-2) if player opted to quit to end screen during thinking time,
 *  else it returns the cell value of the computer's choosing, with a 
 *  hard difficulty.
 */

int
ComputerPickCellLevelHard()
{
    ComputerCell_t cells_free[NUM_CELLS];
    int max_cell = 0,
        t_start = 0,
        connect = 0,
        count = 0,
        temp = 0,
        i = 0,
        j = 0;

    t_start = SDL_GetTicks();

    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (cell_state[i] == -1)
            cells_free[count++].value = i;
    }

    if (count == 0)
        return -1;

    /*
     *  Randomize cells_free[] first, to make computer choice less
     *  predictable.
     */
    for (i = 0; i < count; ++i)
    {
        j = rand() % count;
        temp = cells_free[i].value;
        cells_free[i].value = cells_free[j].value;
        cells_free[j].value = temp;
    }

    for (i = 0; i < count; ++i)
    {
        cells_free[i].block = cells_free[i].seize = 0;
        cells_free[i].might_block = cells_free[i].might_seize = 0;
        cells_free[i].along_block = cells_free[i].along_seize = 0;

        ComputerCellTest( cells_free[i].value, &cells_free[i].block,
                          &cells_free[i].seize, &cells_free[i].might_block,
                          &cells_free[i].might_seize, NULL, NULL );
        cells_free[i].total =
            cells_free[i].seize * 8 + cells_free[i].might_seize * 4 +
            cells_free[i].block * 5 + cells_free[i].might_block * 3;
        if (cells_free[i].total > cells_free[max_cell].total)
        {
            max_cell = i;
        }
    }

    if (ComputerFinishDelay(t_start) == 1)
    {
        return -2;
    }

    return cells_free[max_cell].value;
}

/*
 *  int ComputerPickCellLevelMedium()
 *  
 *  Returns (-1) if unable to pick a cell,
 *  (-2) if player opted to quit to end screen during thinking time,
 *  else it returns the cell value of the computer's choosing, with a
 *  medium difficulty (a little more random than above).
 */

int
ComputerPickCellLevelMedium()
{
    ComputerCell_t cells_free[NUM_CELLS];
    float random_factor = (float)rand() / RAND_MAX * 0.5f;
    int max_cell = 0,
        t_start = 0,
        connect = 0,
        count = 0,
        temp = 0,
        i = 0,
        j = 0;

    t_start = SDL_GetTicks();

    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (cell_state[i] == -1)
            cells_free[count++].value = i;
    }

    if (count == 0)
        return -1;

    /*
     *  Randomize cells_free[] first, to make computer choice less
     *  predictable.
     */
    for (i = 0; i < count; ++i)
    {
        j = rand() % count;
        temp = cells_free[i].value;
        cells_free[i].value = cells_free[j].value;
        cells_free[j].value = temp;
    }

    for (i = 0, max_cell = 0; i < count; ++i)
    {
        cells_free[i].block = cells_free[i].seize = 0;
        cells_free[i].might_block = cells_free[i].might_seize = 0;

        ComputerCellTest( cells_free[i].value, &cells_free[i].block,
                          &cells_free[i].seize, &cells_free[i].might_block,
                          &cells_free[i].might_seize, NULL, NULL );
        cells_free[i].total =
            cells_free[i].seize * 8 + cells_free[i].might_seize * 4;
            cells_free[i].block * 5 + cells_free[i].might_block * 3;
        if (cells_free[i].total > cells_free[max_cell].total)
            max_cell = i;
    }

    j = (int)((float)cells_free[max_cell].total * random_factor);
    for (i = 0; i < count; ++i)
    {
        if (abs(cells_free[i].total - j) < abs(cells_free[max_cell].total - j))
            max_cell = i;
    }

    if (ComputerFinishDelay(t_start) == 1)
    {
        return -2;
    }

    return cells_free[max_cell].value;
}

/*
 *  Same as above, but chooses the cell value randomly.
 *  Not currently implemented in the game, included for historical
 *  reasons.
 */

int
ComputerPickCellRandom()
{
    int cells_free[NUM_CELLS],
        t_start = 0,
        count = 0,
        i = 0;

    t_start = SDL_GetTicks();

    for (i = 0; i < NUM_CELLS; ++i)
    {
        if (cell_state[i] == -1)
            cells_free[count++] = i;
    }

    if (count == 0)
        return -1;

    i = cells_free[rand() % count];

    if (ComputerFinishDelay(t_start) == 1)
    {
        return -2;
    }

    return i;
}


SDL_Event evt;

int
ComputerFinishDelay(int t_start)
{
    if (!no_delay)
    {
        while (SDL_GetTicks() - t_start < CPU_MIN_THINK_TIME)
        {
            /* Handle events during the computer's "thinking" time */
            while (SDL_PollEvent(&evt))
            {
                switch (evt.type)
                {
                    case SDL_QUIT:
                        Quit(0);

                    case SDL_KEYDOWN:
                        if ( evt.key.keysym.sym == SDLK_ESCAPE ||
                             evt.key.keysym.sym == SDLK_q )
                        {
                            return 1;
                        }
                        break;
                }
            }
            SDL_Delay(1);
        }
    }

    return 0;
}
