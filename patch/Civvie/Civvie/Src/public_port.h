/* public_port.h
	vi:ts=3 sw=3:
 */
 

extern struct MsgPort *setup_public_port(char *name);
extern void remove_public_port(struct MsgPort *port);
