#ifndef SCRIPT_H
#define SCRIPT_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class PolygonSet;
class ScriptRun;
class World;
class CsObject;

#define CMD_QUIT 0		// Stop script
#define CMD_MOVE 1		// Move relative with given vector
#define CMD_TRANSFORM 2		// Transform with given matrix
#define CMD_LOOP 3		// Do a loop
#define CMD_FOREVER 4		// Loop forever
#define CMD_WAIT 5		// Wait
#define CMD_RETURN 6		// Return from current sequence (possibly stop script if toplevel)
#define CMD_SCRIPT 7		// Start a script for a local object

#define CMD_INITLOOP 100	// Internal command to initialize the loop

typedef signed char ubyte;

class CmdSequence
{
  friend class Script;
  friend class CmdSequenceRun;
  friend class ScriptRun;

private:
  ubyte* cmds;		// All commands

  long* long_args;	// Long arguments
  Matrix3* mat_args;	// Matrix arguments
  Vector3* vec_args;	// Vector arguments
  CmdSequence* seq_args;// CmdSequences

  int num_cmds;
  int num_long_args, num_mat_args, num_vec_args, num_seq_args;
  int num_long_vars;

  void compile_pass1 (char** buf);
  void compile_pass2 (char** buf);

  CmdSequence ();
  ~CmdSequence ();
};

class Script
{
  friend class ScriptRun;

private:
  Script* next;		// Linked list of all scripts.
  CmdSequence main;	// Main command sequence for this script.

  char name[30];

public:
  Script (char* name);
  ~Script ();

  char* get_name () { return name; }

  void set_next (Script* n) { next = n; }
  Script* get_next () { return next; }

  void save (FILE* fp, int indent);
  void load (char** buf);
};

class CmdSequenceRun
{
  friend class ScriptRun;

private:
  int cur_cmd;
  int cur_long_arg, cur_mat_arg, cur_vec_arg, cur_seq_arg;
  long* vars;			// Local variables

  CmdSequenceRun ();
  ~CmdSequenceRun ();

  void start (CmdSequence* seq);
};

class ScriptRun
{
private:
  ScriptRun* nextR, * prevR;	// Double linked list of all running scripts.
  CsObject* object;		// Object to perform the actions on.
  int type;			// Type of object (PS_THING or PS_SECTOR).
  Script* script;		// Pointer to script.

  CmdSequenceRun stackr[20];
  CmdSequence* stack[20];
  int stack_idx;
  CmdSequenceRun* seqr;
  CmdSequence* seq;

public:
  ScriptRun (Script* script, CsObject* object);
  ~ScriptRun ();

  void set_next (ScriptRun* n) { nextR = n; }
  void set_prev (ScriptRun* p) { prevR = p; }
  ScriptRun* get_next () { return nextR; }
  ScriptRun* get_prev () { return prevR; }

  void start ();	// Start script (is done at construction).
  int step ();		// Do one step, return TRUE if finished.
};

class TriggerList
{
private:
  class Trigger
  {
  public:
    Trigger* next;
    CsObject* object;
    Script* script;
  };

  Trigger* first_trigger;

public:
  TriggerList ();
  ~TriggerList ();

  void add_trigger (Script* s, CsObject* ob = NULL);
  void perform (World* w, CsObject* object);
};

#endif /*SCRIPT_H*/
