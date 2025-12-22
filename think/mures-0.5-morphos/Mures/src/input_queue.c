/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#include <stdlib.h>
#include <stdio.h>
#include "protocol.h"
#include "sim.h"
#include "input_queue.h"

/* input-queue functions */

void input_queue_clear(input_queue *q)
{
  q->head = 0;
  q->tail = 0;
}

void input_enqueue(input_queue *q, player_id player_num, direction dir, grid_int_position pos)
{
  input_type temp;

  temp.player_num = player_num;
  temp.dir = dir;
  temp.pos = pos;
  
  if((q->tail+1)%INPUT_QUEUE_SIZE == q->head) {
    fprintf(stderr, "input queue overflow.\n");
    return;
  }
  
  q->input[q->tail] = temp;
  q->tail = (q->tail+1)%INPUT_QUEUE_SIZE;
}

input_type input_dequeue(input_queue *q)
{
  if(q->head == q->tail) {
    fprintf(stderr, "tried to dequeue from an empty queue.\n");
    exit(1);
  }
  
  q->tail = (q->tail-1+INPUT_QUEUE_SIZE)%INPUT_QUEUE_SIZE;
  
  return q->input[q->tail];
}

