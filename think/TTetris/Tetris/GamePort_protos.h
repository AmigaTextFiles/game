/* Prototypes for functions defined in
GamePort.c
 */

void send_read_request(struct InputEvent *, struct IOStdReq *);

BOOL set_controller_type(BYTE , struct IOStdReq *);

void set_trigger_conditions(struct GamePortTrigger *, struct IOStdReq *);

void flush_buffer(struct IOStdReq *);

void free_gp_unit(struct IOStdReq *);

