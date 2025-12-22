#include <exec/types.h>
#include <exec/io.h>
#include <exec/memory.h>
#include <exec/exec.h>
#include <devices/gameport.h>
#include <devices/inputevent.h>
/* */
#include <clib/exec_protos.h>

/*-----------------------------------------------------------------------
** send a request to the gameport to read an event.
*/
void 
send_read_request(struct InputEvent * game_event, struct IOStdReq * game_io_msg)
{
	game_io_msg->io_Command = GPD_READEVENT;
	game_io_msg->io_Flags = 0;
	game_io_msg->io_Data = (APTR) game_event;
	game_io_msg->io_Length = sizeof(struct InputEvent);
	SendIO(game_io_msg);		/* Asynchronous - message will return later */
}

/*-----------------------------------------------------------------------
** allocate the controller if it is available.
** you allocate the controller by setting its type to something
** other than GPCT_NOCONTROLLER.  Before you allocate the thing
** you need to check if anyone else is using it (it is free if
** it is set to GPCT_NOCONTROLLER).
*/
BOOL 
set_controller_type(BYTE type, struct IOStdReq *game_io_msg)
{
	BOOL            success = FALSE;
	BYTE            controller_type = 0;

	/*
	 * begin critical section * we need to be sure that between the time
	 * we check that the controller * is available and the time we
	 * allocate it, no one else steals it.
	 */
	Forbid();

	game_io_msg->io_Command = GPD_ASKCTYPE;		/* inquire current status */
	game_io_msg->io_Flags = IOF_QUICK;
	game_io_msg->io_Data = (APTR) & controller_type;	/* put answer in here */
	game_io_msg->io_Length = 1;
	DoIO(game_io_msg);

	/* No one is using this device unit, let's claim it */
	if (controller_type == GPCT_NOCONTROLLER) {
		game_io_msg->io_Command = GPD_SETCTYPE;
		game_io_msg->io_Flags = IOF_QUICK;
		game_io_msg->io_Data = (APTR) & type;
		game_io_msg->io_Length = 1;
		DoIO(game_io_msg);
		success = TRUE;
	}
	Permit();					/* critical section end */
	return (success);
}

/*-----------------------------------------------------------------------
** tell the gameport when to trigger.
*/
void 
set_trigger_conditions(struct GamePortTrigger * gpt, struct IOStdReq * game_io_msg)
{
	game_io_msg->io_Command = GPD_SETTRIGGER;
	game_io_msg->io_Flags = IOF_QUICK;
	game_io_msg->io_Data = (APTR) gpt;
	game_io_msg->io_Length = (LONG) sizeof(struct GamePortTrigger);
	DoIO(game_io_msg);
}

/*-----------------------------------------------------------------------
** clear the buffer.  do this before you begin to be sure you
** start in a known state.
*/
void 
flush_buffer(struct IOStdReq *game_io_msg)
{
	game_io_msg->io_Command = CMD_CLEAR;
	game_io_msg->io_Flags = IOF_QUICK;
	game_io_msg->io_Data = NULL;
	game_io_msg->io_Length = 0;
	DoIO(game_io_msg);
}

/*-----------------------------------------------------------------------
** free the unit by setting its type back to GPCT_NOCONTROLLER.
*/
void 
free_gp_unit(struct IOStdReq *game_io_msg)
{
	BYTE            type = GPCT_NOCONTROLLER;

	game_io_msg->io_Command = GPD_SETCTYPE;
	game_io_msg->io_Flags = IOF_QUICK;
	game_io_msg->io_Data = (APTR) & type;
	game_io_msg->io_Length = 1;
	DoIO(game_io_msg);
}
