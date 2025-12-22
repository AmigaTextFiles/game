#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sdlame.h"
#include "vars.h"

void turn_player_1()
{
  char input[2];
  int x=0, y=0;

  /* get input */
  if(GP2X_MODE == 0)
  {
    input_pc(&input);
  }
  else
  {
    input_gp2x(&input);
  }

  /* move cursor */
  if(input[0] == 'r' || input[0] == 'l' || input[0] == 'd' || input[0] == 'u')
  {
    draw_place(cursor_x, cursor_y); //remove current cursor
    if((unit_x == cursor_x) && (unit_y == cursor_y))
    {
      draw_cursor(cursor_x, cursor_y, 2);
    }
    move_cursor(input[0]);              //move cursor
    draw_cursor(cursor_x, cursor_y, 1); //draw new cursor
  }

  /* exit */
  else if(input[0] == 'e')
  {
    menu();
  }

  /* next player */
  else if(input[0] == 'n')
  {
    if(moved_k == 0)
    {
      output("First move a unit!");
    }
    else
    {
      //HERE should be testet if the unit the player moved
      //could beat more units, because if this is the case 
      //the player has to jump over them, too.

      if(mode == 2)
      {
        output("Player 2...");
      }
      else
      {
        output("Computer...");
      }
      player = 2;
      moved_k = 0;
      draw_place(unit_x, unit_y);
      unit_x = 0;
      unit_y = 0;
      beat_k = 0;
    }
  }

  /* choose unit */
  else if(input[0] == 'c')
  {
    if(field[cursor_x][cursor_y] == 1 || field[cursor_x][cursor_y] == 2)
    {
      draw_place(unit_x, unit_y);
      unit_x = cursor_x;
      unit_y = cursor_y;
      draw_cursor(cursor_x, cursor_y, 2);
      output("Choosed unit!");
    }
    else if(field[cursor_x][cursor_y] != 0)
    {
      output("This unit belongs to your enemy!");
    }
    else
    {
      output("On this place is no unit!");
    }
  }

  /* Move unit */
  else if(input[0] == 'm')
  {
    output("Move unit!");

    if(field[cursor_x][cursor_y] != 0)
    {
      output("The place is not free!");
    }
    else if(moved_k == 1)
    {
      output("You have already done your move!");
    }
    else if(field[unit_x][unit_y] == 1) //NORMAL UNIT
    {
      if(is_black(cursor_x, cursor_y) == 1) //CURSOR ON BLACK FIELD
      {
        if((unit_x == cursor_x+1 || unit_x ==  cursor_x-1) && 
           (cursor_y-1 == unit_y)
          )
        {
          //unit is allowed to move. No other unit is beaten.
          field[cursor_x][cursor_y] = 1;
          field[unit_x][unit_y]     = 0;

          //remove old unit from screen
          draw_place(unit_x, unit_y);

          //draw new unit on screen
          draw_place(cursor_x, cursor_y);

          //draw cursor
          draw_cursor(cursor_x, cursor_y, 1);

          //choose this unit automaticaly
          unit_x = cursor_x;
          unit_y = cursor_y;

          //set moved status
          moved_x = cursor_x;
          moved_y = cursor_y;
          moved_k = 1;

          if(cursor_y == 8)
          {
            field[cursor_x][cursor_y] = 2;
            draw_place(cursor_x, cursor_y);
            draw_cursor(cursor_x, cursor_y, 1);
          }

          output("Moved Unit!");
        }
        else if(unit_y >= cursor_y)
        {
          output("Please move foreward!");
        }
        else if((cursor_x == unit_x+2 || unit_x-2) && (cursor_y == unit_y+2))
        {
          //Unit beats probably another one. But it could be one of the player's
          if((cursor_x == unit_x+2) && 
             (field[(unit_x+1)][(unit_y+1)] == 3 || 
              field[(unit_x+1)][(unit_y+1)] == 4)
            )
          {
            printf("Game: White [%d,%d] beats Black [%d,%d]!\n", unit_x, unit_x, 
            cursor_x-1, cursor_y-1);

            player_black--;

            //unit belongs to the enemy -> move!
            field[(cursor_x)][(cursor_y)]     = 1;
            field[(cursor_x-1)][(cursor_y-1)] = 0;
            field[(cursor_x-2)][(cursor_y-2)] = 0;

            //delete old unit from screen
            draw_place(unit_x, unit_y);

            //delete enemy's unit from screen
            draw_place(cursor_x-1, cursor_y-1);

            //draw new unit on screen
            draw_place(cursor_x, cursor_y);

            //draw cursor
            draw_cursor(cursor_x, cursor_y, 1);

            //choose this unit automaticaly
            unit_x  = cursor_x;
            unit_y  = cursor_y;

            //set moved status
            moved_x = cursor_x;
            moved_y = cursor_y;
            moved_k = 1;

            //set beat status
            beat_k = 1;

            if(cursor_y == 8)
            {
              field[cursor_x][cursor_y] = 2;
              draw_place(cursor_x, cursor_y);
              draw_cursor(cursor_x, cursor_y, 1);
            }
          }
          else if((cursor_x == unit_x-2) && 
                  (field[(unit_x-1)][(unit_y+1)] == 3 || 
                   field[(unit_x-1)][(unit_y+1)] == 4)
                 )
          {
            printf("Game: White [%d,%d] beats Black [%d,%d]!\n", unit_x, unit_x, 
            cursor_x+1, cursor_y-1);

            player_black--;

            //unit belongs to the enemy -> move!
            field[(cursor_x)][(cursor_y)]     = 1;
            field[(cursor_x+1)][(cursor_y-1)] = 0;
            field[(cursor_x+2)][(cursor_y-2)] = 0;

            //delete old unit from screen
            draw_place(unit_x, unit_y);

            //delete enemy's unit from screen
            draw_place(cursor_x+1, cursor_y-1);

            //draw new unit on screen
            draw_place(cursor_x, cursor_y);

            //draw cursor
            draw_cursor(cursor_x, cursor_y, 1);

            //choose this unit automaticaly
            unit_x = cursor_x;
            unit_y = cursor_y;

            //set moved status
            moved_x = cursor_x;
            moved_y = cursor_y;
            moved_k = 1;

            //set beat status
            beat_k = 1;

            if(cursor_y == 8)
            {
              field[cursor_x][cursor_y] = 2;
              draw_place(cursor_x, cursor_y);
              draw_cursor(cursor_x, cursor_y, 1);
            }
          }
          else
          {
            output("You'r not allowed to do this!");
          }
        }
        else
        {
          output("You'r not allowed to do this!");
        }
      }
      else
      {
        output("No unit can enter this place!");
      }
    }
    else if(field[unit_x][unit_y] == 2)
    {
      //---------Super Units----------------------------START
      if(is_diagonally(unit_x, unit_y, cursor_x, cursor_y) == FALSE)
      {
        output("Please move diagonally!");
      }
      else
      {
        if(is_moveable(unit_x, unit_y, cursor_x, cursor_y, 0, 0) == TRUE)
        {
          while(unit_x+x != cursor_x)
          {
            if(field[unit_x+x][unit_y+y] == 3 || field[unit_x+x][unit_y+y] == 4)
            {
              printf("Game: White [%d,%d] beats Black [%d,%d]!\n", unit_x,  
              unit_y, (unit_x+x), (unit_y+y));
              beat_k = 1;
            }
            field[(unit_x+x)][(unit_y+y)] = 0;
            draw_place(unit_x+x, unit_y+y);

            if((cursor_x - unit_x) < 0)
            {
              x--;
            }
            else
            {
              x++;
            }

            if((cursor_y - unit_y) < 0)
            {
              y--;
            }
            else
            {
              y++;
            }
          }

          //choose this unit automaticaly
          unit_x = cursor_x;
          unit_y = cursor_y;

          //set moved status
          moved_x = cursor_x;
          moved_y = cursor_y;
          moved_k = 1;

          //set new unit
          field[cursor_x][cursor_y] = 2;

          //draw new unit on screen
          draw_place(cursor_x, cursor_y);

          //draw cursor
          draw_cursor(cursor_x, cursor_y, 1);

          output("Moved unit!");
        }
      }
      //---------Super Units-------------------------------END
    }
  }
}

void turn_player_2()
{
  char input[2];
  int x = 0,y = 0;

  /* get input */
  if(GP2X_MODE == 0)
  {
    input_pc(&input);
  }
  else
  {
    input_gp2x(&input);
  }

  /* move cursor */
  if(input[0] == 'r' || input[0] == 'l' || input[0] == 'd' || input[0] == 'u')
  {
    draw_place(cursor_x, cursor_y); //remove current cursor
    if(unit_x == cursor_x && unit_y == cursor_y)
    {
      draw_cursor(cursor_x, cursor_y, 2);
    }
    move_cursor(input[0]);               //move cursor
    draw_cursor(cursor_x, cursor_y, 1);  //draw new cursor
  }

  /* exit */
  else if(input[0] == 'e')
  {
    menu();
  }

  /* next player */
  else if(input[0] == 'n')
  {
    if(moved_k == 0)
    {
      output("First move a unit!");
    }
    else
    {
      //HERE should be testet if the unit the player moved
      //could beat more units, because if this is the case 
      //the player has to jump over them, too.

      output("Player 1...");
      player = 1;
      moved_k = 0;
      draw_place(unit_x, unit_y);
      unit_x = 0;
      unit_y = 0;
      beat_k = 0;
    }
  }

  /* choose unit */
  else if(input[0] == 'c')
  {
    if(field[cursor_x][cursor_y] == 3 || field[cursor_x][cursor_y] == 4)
    {
      draw_place(unit_x, unit_y);
      unit_x = cursor_x;
      unit_y = cursor_y;
      draw_cursor(cursor_x, cursor_y, 2);
      output("Choosed unit!");
    }
    else if(field[cursor_x][cursor_y] != 0)
    {
      output("This unit belongs to your enemy!");
    }
    else
    {
      output("On this place is no unit!");
    }
  }

  /* Move unit */
  else if(input[0] == 'm')
  {
    output("Move unit!");

    if(field[cursor_x][cursor_y] != 0)
    {
      output("The place is not free!");
    }
    else if(moved_k == 1)
    {
      output("You have already done your move!");
    }
    else if(field[unit_x][unit_y] == 3)
    {
      //normal unit
      if(is_black(cursor_x, cursor_y) == 1)
      {
        if((cursor_x == unit_x+1 || cursor_x == unit_x-1) && 
           (cursor_y == unit_y-1))
        {
          //unit is allowed to move. No other unit is beaten.
          field[cursor_x][cursor_y] = 3;
          field[unit_x][unit_y]     = 0;

          //remove old unit from screen
          draw_place(unit_x, unit_y);

          //draw new unit on screen
          draw_place(cursor_x, cursor_y);

          //draw cursor
          draw_cursor(cursor_x, cursor_y, 1);

          //choose this unit automaticaly
          unit_x = cursor_x;
          unit_y = cursor_y;

          //set moved status
          moved_x = cursor_x;
          moved_y = cursor_y;
          moved_k = 1;

          if(cursor_y == 1)
          {
            field[cursor_x][cursor_y] = 4;
            draw_place(cursor_x, cursor_y);
            draw_cursor(cursor_x, cursor_y, 1);
          }
        }
        else if(unit_y <= cursor_y)
        {
          output("Please move foreward!");
        }
        if((cursor_x == unit_x+2 || cursor_x == unit_x-2) && 
           (cursor_y == unit_y-2))
        {
          //unit _probably_ beats another one
          if(cursor_x == unit_x+2)
          {
            //other unit = cursor_x-1 cursor_y+1
            if(field[(cursor_x-1)][(cursor_y+1)] == 1 || 
               field[(cursor_x-1)][(cursor_y+1)] == 2) 
            {
              printf("Game: Black [%d,%d] beats White [%d,%d]!\n", unit_x, unit_x, 
              cursor_x-1, cursor_y+1);

              player_white--;

              //unit belongs to the enemy -> move!
              field[(cursor_x)][(cursor_y)]     = 3;
              field[(cursor_x-1)][(cursor_y+1)] = 0;
              field[(cursor_x-2)][(cursor_y+2)] = 0;

              //delete old unit from screen
              draw_place(unit_x, unit_y);

              //delete enemy's unit from screen
              draw_place(cursor_x-1, cursor_y+1);

              //draw new unit on screen
              draw_place(cursor_x, cursor_y);

              //draw cursor
              draw_cursor(cursor_x, cursor_y, 1);

              //choose this unit automaticaly
              unit_x  = cursor_x;
              unit_y  = cursor_y;

              //set moved status
              moved_x = cursor_x;
              moved_y = cursor_y;
              moved_k = 1;

              //set beat status
              beat_k = 1;

              if(cursor_y == 1)
              {
                field[cursor_x][cursor_y] = 4;
                draw_place(cursor_x, cursor_y);
                draw_cursor(cursor_x, cursor_y, 1);
              }
            }
            else if(field[(cursor_x-1)][(cursor_y+1)] == 0)
            {
              output("You can't go 2 fields!");
            }
            else
            {
              output("You can't kill your units!");
            }
          }
          else
          {
            //other unit = cursor_x+1 cursor_y+1
            if(field[(cursor_x+1)][(cursor_y+1)] == 1 || 
               field[(cursor_x+1)][(cursor_y+1)] == 2)
            {
              printf("Game: Black [%d,%d] beats White [%d,%d]!\n", unit_x, unit_x, 
              cursor_x+1, cursor_y+1);

              player_white--;

              //unit belongs to the enemy -> move!
              field[(cursor_x)][(cursor_y)]     = 3;
              field[(cursor_x+1)][(cursor_y+1)] = 0;
              field[(cursor_x+2)][(cursor_y+2)] = 0;

              //delete old unit from screen
              draw_place(unit_x, unit_y);

              //delete enemy's unit from screen
              draw_place(cursor_x+1, cursor_y+1);

              //draw new unit on screen
              draw_place(cursor_x, cursor_y);

              //draw cursor
              draw_cursor(cursor_x, cursor_y, 1);

              //choose this unit automaticaly
              unit_x = cursor_x;
              unit_y = cursor_y;

              //set moved status
              moved_x = cursor_x;
              moved_y = cursor_y;
              moved_k = 1;

              //set beat status
              beat_k = 1;

              if(cursor_y == 1)
              {
                field[cursor_x][cursor_y] = 4;
                draw_place(cursor_x, cursor_y);
                draw_cursor(cursor_x, cursor_y, 1);
              }
            }
            else if(field[(cursor_x-1)][(cursor_y+1)] == 0)
            {
              output("You can't go 2 fields!");
            }
            else
            {
              output("You can't kill your units!");
            }
          }
        }
      }
      else
      {
        output("No unit can enter this place!");
      }
    }
    else if(field[unit_x][unit_y] == 4)
    {
      //---------Super Units----------------------------START
      if(is_diagonally(unit_x, unit_y, cursor_x, cursor_y) == FALSE)
      {
        output("Please move diagonally!");
      }
      else
      {
        if(is_moveable(unit_x, unit_y, cursor_x, cursor_y, 0, 0) == TRUE)
        {
          while(unit_x+x != cursor_x)
          {
            if(field[unit_x+x][unit_y+y] == 1 || field[unit_x+x][unit_y+y] == 2)
            {
              printf("Game: Black [%d,%d] beats White [%d,%d]!\n", unit_x,  
              unit_y, (unit_x+x), (unit_y+y));
              beat_k = 1;
            }
            field[(unit_x+x)][(unit_y+y)] = 0;
            draw_place(unit_x+x, unit_y+y);

            if((cursor_x - unit_x) < 0)
            {
              x--;
            }
            else
            {
              x++;
            }

            if((cursor_y - unit_y) < 0)
            {
              y--;
            }
            else
            {
              y++;
            }
          }

          //choose this unit automaticaly
          unit_x = cursor_x;
          unit_y = cursor_y;

          //set moved status
          moved_x = cursor_x;
          moved_y = cursor_y;
          moved_k = 1;

          //set new unit
          field[cursor_x][cursor_y] = 4;

          //draw new unit on screen
          draw_place(cursor_x, cursor_y);

          //draw cursor
          draw_cursor(cursor_x, cursor_y, 1);

          output("Moved unit!");
        }
      }
      //---------Super Units-------------------------------END
    }
  }
}
