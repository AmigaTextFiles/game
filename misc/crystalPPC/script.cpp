#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef SCRIPT_H
#include "script.h"
#endif

#ifndef THING_H
#include "thing.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

//---------------------------------------------------------------------------

CmdSequence::CmdSequence  ()
{
  cmds = NULL;
  long_args = NULL;
  mat_args = NULL;
  vec_args = NULL;
  seq_args = NULL;
}

CmdSequence::~CmdSequence ()
{
  if (cmds) delete [] cmds;
  if (long_args) delete [] long_args;
  if (mat_args) delete [] mat_args;
  if (vec_args) delete [] vec_args;
  if (seq_args) delete [] seq_args;
}

void CmdSequence::compile_pass1 (char** buf)
{
  char* t;

  num_cmds = 0;
  num_long_args = 0;
  num_mat_args = 0;
  num_vec_args = 0;
  num_seq_args = 0;
  num_long_vars = 0;

  while (TRUE)
  {
    t = get_token (buf);
    if (*t == ')' || *t == 0 || *t == '}') break;
    if (!strcmp (t, "move"))
    {
      skip_token (buf, "(", "Expected '%s' instead of '%s' after 'move' cmd!\n");
      get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in 'move' cmd!\n");
      get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in 'move' cmd!\n");
      get_token_float (buf);
      skip_token (buf, ")", "Expected '%s' instead of '%s' to end 'move' cmd!\n");

      num_cmds++;
      num_vec_args++;
    }
    else if (!strcmp (t, "transform"))
    {
      skip_token (buf, "(", "Expected '%s' instead of '%s' after 'transform' cmd!\n");
      t = get_token (buf);
      int bra = 1;
      while (*t)
      {
        if (*t == ')')
	  if (bra <= 1) break;
	  else bra--;
	if (*t == '(') bra++;
        t = get_token (buf);
      }
      num_cmds++;
      num_mat_args++;
    }
    else if (!strcmp (t, "forever"))
    {
      skip_token (buf, "{", "Expected '%s' instead of '%s' after 'forever' cmd!\n");
      t = get_token (buf);
      int bra = 1;
      while (*t)
      {
        if (*t == '}')
	  if (bra <= 1) break;
	  else bra--;
	if (*t == '{') bra++;
        t = get_token (buf);
      }
      num_cmds++;
      num_seq_args++;
    }
    else if (!strcmp (t, "loop"))
    {
      get_token_int (buf);
      skip_token (buf, "{", "Expected '%s' instead of '%s' after 'loop' cmd!\n");
      t = get_token (buf);
      int bra = 1;
      while (*t)
      {
        if (*t == '}' && bra <= 1) break;
	if (*t == '{') bra++;
        t = get_token (buf);
      }
      num_cmds++;		// INITLOOP command
      num_long_args++;		// Number of times we should loop
      num_long_args++;		// Index to variable where we keep our loop counter
      num_cmds++;		// LOOP command
      num_long_args++;		// Index to variable where we keep our loop counter
      num_seq_args++;		// Sequence to loop
      num_long_vars++;		// We need one extra loop counter
    }
    else if (!strcmp (t, "wait"))
    {
      num_cmds++;
    }
    else
    {
      printf ("What is '%s' doing in a SCRIPT?\n", t);
      exit (0);
    }
  }

  num_cmds++; // Room for CMD_RETURN

  cmds = new ubyte [num_cmds];
  if (num_long_args) long_args = new long [num_long_args];
  if (num_mat_args) mat_args = new Matrix3 [num_mat_args];
  if (num_vec_args) vec_args = new Vector3 [num_vec_args];
  if (num_seq_args) seq_args = new CmdSequence [num_seq_args];
}

void CmdSequence::compile_pass2 (char** buf)
{
  char* t;

  int idx_cmds = 0;
  int idx_long_args = 0;
  int idx_mat_args = 0;
  int idx_vec_args = 0;
  int idx_seq_args = 0;
  int idx_long_vars = 0;

  while (TRUE)
  {
    t = get_token (buf);
    if (*t == ')' || *t == 0 || *t == '}') break;
    if (!strcmp (t, "move"))
    {
      cmds[idx_cmds++] = CMD_MOVE;
      skip_token (buf, "(", "Expected '%s' instead of '%s' after 'move' cmd!\n");
      vec_args[idx_vec_args].x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in 'move' cmd!\n");
      vec_args[idx_vec_args].y = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in 'move' cmd!\n");
      vec_args[idx_vec_args].z = get_token_float (buf);
      skip_token (buf, ")", "Expected '%s' instead of '%s' to end 'move' cmd!\n");
      idx_vec_args++;
    }
    else if (!strcmp (t, "transform"))
    {
      cmds[idx_cmds++] = CMD_TRANSFORM;
      skip_token (buf, "(", "Expected '%s' instead of '%s' after 'transform' cmd!\n");
      Matrix3 r;
      mat_args[idx_mat_args].identity ();
      t = get_token (buf);
      while (*t && *t != ')')
      {
	if (!strcmp (t, "rot_x"))
	{
	  float a = get_token_float (buf);
	  a = a * 2*PI / 360.;
	  r.m11 = 1;       r.m12 = 0;       r.m13 = 0;
	  r.m21 = 0;       r.m22 = cos (a); r.m23 = -sin (a);
	  r.m31 = 0;       r.m32 = sin (a); r.m33 = cos (a);
	  r *= mat_args[idx_mat_args];
	  mat_args[idx_mat_args] = r;
	}
	else if (!strcmp (t, "rot_y"))
	{
	  float a = get_token_float (buf);
	  a = a * 2*PI / 360.;
	  r.m11 = cos (a); r.m12 = 0;       r.m13 = -sin (a);
	  r.m21 = 0;       r.m22 = 1;       r.m23 = 0;
	  r.m31 = sin (a); r.m32 = 0;       r.m33 = cos (a);
	  r *= mat_args[idx_mat_args];
	  mat_args[idx_mat_args] = r;
	}
	else if (!strcmp (t, "rot_z"))
	{
	  float a = get_token_float (buf);
	  a = a * 2*PI / 360.;
	  r.m11 = cos (a); r.m12 = -sin (a); r.m13 = 0;
	  r.m21 = sin (a); r.m22 = cos (a);  r.m23 = 0;
	  r.m31 = 0;       r.m32 = 0;        r.m33 = 1;
	  r *= mat_args[idx_mat_args];
	  mat_args[idx_mat_args] = r;
	}
	else
	{
	  printf ("What is '%s' doing in a 'transform' cmd?\n", t);
	  exit (0);
	}
	t = get_token (buf);
      }
      idx_mat_args++;
    }
    else if (!strcmp (t, "forever"))
    {
      cmds[idx_cmds++] = CMD_FOREVER;
      skip_token (buf, "{", "Expected '%s' instead of '%s' after 'forever' cmd!\n");
      char* old_buf;
      old_buf = *buf;
      seq_args[idx_seq_args].compile_pass1 (buf);
      *buf = old_buf;
      seq_args[idx_seq_args].compile_pass2 (buf);
      idx_seq_args++;
    }
    else if (!strcmp (t, "loop"))
    {
      cmds[idx_cmds++] = CMD_INITLOOP;
      cmds[idx_cmds++] = CMD_LOOP;
      long_args[idx_long_args++] = get_token_int (buf);
      long_args[idx_long_args++] = idx_long_vars;
      long_args[idx_long_args++] = idx_long_vars;
      skip_token (buf, "{", "Expected '%s' instead of '%s' after 'loop' cmd!\n");
      char* old_buf;
      old_buf = *buf;
      seq_args[idx_seq_args].compile_pass1 (buf);
      *buf = old_buf;
      seq_args[idx_seq_args].compile_pass2 (buf);
      idx_seq_args++;
      idx_long_vars++;
    }
    else if (!strcmp (t, "wait"))
    {
      cmds[idx_cmds++] = CMD_WAIT;
    }
    else
    {
      printf ("What is '%s' doing in a SCRIPT?\n", t);
      exit (0);
    }
  }

  cmds[idx_cmds++] = CMD_RETURN;
}

//---------------------------------------------------------------------------

Script::Script (char* name)
{
  strcpy (Script::name, name);
}

Script::~Script ()
{
}

void Script::save (FILE* fp, int indent)
{
#if 0
// @@@ NOT IMPLEMENTED YET
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sSCRIPT '%s' (\n", sp, name);
  fprintf (fp, "%s  TIMES=%d\n", sp, times);
  fprintf (fp, "%s  DO (\n", sp);
  m.save (fp, indent+4);
  v.save (fp, indent+4);
  fprintf (fp, "%s  )\n", sp);
  fprintf (fp, "%s)\n", sp);
#endif
}

void Script::load (char** buf)
{
  char* t;
  char* old_buf;

  skip_token (buf, "SCRIPT");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a SCRIPT!\n");

  old_buf = *buf;
  main.compile_pass1 (buf);
  *buf = old_buf;
  main.compile_pass2 (buf);
}

//---------------------------------------------------------------------------

CmdSequenceRun::CmdSequenceRun ()
{
  vars = NULL;
}

CmdSequenceRun::~CmdSequenceRun ()
{
  if (vars) delete [] vars;
}

void CmdSequenceRun::start (CmdSequence* seq)
{
  cur_cmd = 0;
  cur_long_arg = 0;
  cur_mat_arg = 0;
  cur_vec_arg = 0;
  cur_seq_arg = 0;
  if (vars) { delete [] vars; vars = NULL; }
  if (seq->num_long_vars)
  {
    vars = new long [seq->num_long_vars];
  }
}

//---------------------------------------------------------------------------

ScriptRun::ScriptRun (Script* script, CsObject* object)
{
  ScriptRun::script = script;
  ScriptRun::object = object;
  type = object->get_type ();
  start ();
}

ScriptRun::~ScriptRun ()
{
}

void ScriptRun::start ()
{
  stack_idx = 0;
  seqr = &stackr[stack_idx];
  seq = stack[stack_idx] = &script->main;
  seqr->start (seq);
}

int ScriptRun::step ()
{
  for (;;)
  {
    // printf ("[%d] Exec cmd [%d]: %d\n", stack_idx, seqr->cur_cmd, seq->cmds[seqr->cur_cmd]);

    switch (seq->cmds[seqr->cur_cmd])
    {
      case CMD_QUIT:
	return TRUE;

      case CMD_RETURN:
	if (stack_idx <= 0) return TRUE;
	stack_idx--;
	seqr = &stackr[stack_idx];
	seq = stack[stack_idx];
	break;

      case CMD_FOREVER:
	{
	  CmdSequence* ns;
	  ns = &(seq->seq_args[seqr->cur_seq_arg]);
	  stack_idx++;
	  seqr = &stackr[stack_idx];
	  seq = stack[stack_idx] = ns;
	  seqr->start (seq);
	  break;
	}

      case CMD_INITLOOP:
	{
	  seqr->cur_cmd++;
	  seqr->vars[seq->long_args[seqr->cur_long_arg+1]] = seq->long_args[seqr->cur_long_arg];
	  seqr->cur_long_arg += 2;
	  break;
	}

      case CMD_LOOP:
	{
	  if (seqr->vars[seq->long_args[seqr->cur_long_arg]] > 0)
	  {
	    seqr->vars[seq->long_args[seqr->cur_long_arg]]--;

	    CmdSequence* ns;
	    ns = &(seq->seq_args[seqr->cur_seq_arg]);
	    stack_idx++;
	    seqr = &stackr[stack_idx];
	    seq = stack[stack_idx] = ns;
	    seqr->start (seq);
	  }
	  else
	  {
	    seqr->cur_long_arg++;
	    seqr->cur_seq_arg++;
	    seqr->cur_cmd++;
	  }
	  break;
	}

      case CMD_MOVE:
	seqr->cur_cmd++;
	if (type == CS_THING)
	{
	  Thing* thing = (Thing*)object;
	  thing->move (seq->vec_args[seqr->cur_seq_arg++]);
	  thing->transform (); // @@@ This should be delayed until sure that the thing is really on screen.
	}
	else if (type == CS_COLLECTION)
	{
	  Collection* col = (Collection*)object;
	  col->move (seq->vec_args[seqr->cur_seq_arg++]);
	  col->transform ();
	}
	break;

      case CMD_TRANSFORM:
	seqr->cur_cmd++;
	if (type == CS_THING)
	{
	  Thing* thing = (Thing*)object;
	  thing->transform (seq->mat_args[seqr->cur_mat_arg++]);
	  thing->transform ();
	}
	else if (type == CS_COLLECTION)
	{
	  Collection* col = (Collection*)object;
	  col->transform (seq->mat_args[seqr->cur_mat_arg++]);
	  col->transform ();
	}
	break;

      case CMD_WAIT:
	seqr->cur_cmd++;
	return FALSE;
    }
  }
  return FALSE;
}


//---------------------------------------------------------------------------

TriggerList::TriggerList ()
{
  first_trigger = NULL;
}

TriggerList::~TriggerList ()
{
  while (first_trigger)
  {
    Trigger* n = first_trigger->next;
    delete first_trigger;
    first_trigger = n;
  }
}

void TriggerList::add_trigger (Script* s, CsObject* object)
{
  Trigger* t = new Trigger ();
  t->script = s;
  t->next = first_trigger;
  t->object = object;
  first_trigger = t;
}

void TriggerList::perform (World* w, CsObject* object)
{
  Trigger* t = first_trigger;
  while (t)
  {
    w->run_script (t->script, t->object ? t->object : object);
    t = t->next;
  }
}

//---------------------------------------------------------------------------
