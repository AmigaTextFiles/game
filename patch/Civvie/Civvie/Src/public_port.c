/* public_port.c
	vi:ts=3 sw=3:
	
	Proper creation/deletion of unique public ports
 */

#include <proto/exec.h>

#include "public_port.h"

struct MsgPort *setup_public_port(char *name)
	{
	struct MsgPort *port;
	
	port = CreateMsgPort();
	if (port)
		{
			/* Ensure there is no other port of the same name */
		Forbid();
		if (FindPort(name))
			{
			DeleteMsgPort(port);
			port = 0;
			}
		else
			{
			port->mp_Node.ln_Name = name;
			port->mp_Node.ln_Pri = 0;
			AddPort(port);
			}
		Permit();
		}
	return port;
	}

void remove_public_port(struct MsgPort *port)
	{
	RemPort(port);
	DeleteMsgPort(port);
	}
