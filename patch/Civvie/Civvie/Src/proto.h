/* proto.h
	vi:ts=3 sw=3:
	
	Glue, see various modules for documentation
 */

/* where to save extended save files */
#define BASEDIR "civ:saves"

/* rendez-vous between civ launcher and main task */
#define PORTNAME "Civ Manager"

/* subtask name */
#define SUBTASK "Civ Launcher"

/* map.c */
extern void restaure_file(char *name);
extern void copy_save_file(int i);
extern void setup_iobuf(void);

/* subtask.c */
extern void civ_and_die(void);
extern void cleanup_subtask(struct MsgPort *port);

/* watcher.c */
extern void watcher(struct MsgPort *end_port);
