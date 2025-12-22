/**
This software and ancillary information (herein called "SOFTWARE")
called Supermon is made available under the terms described
here.  The SOFTWARE has been approved for release with associated
LA-CC Number LA-CC 99-51.

Unless otherwise indicated, this SOFTWARE has been authored by an
employee or employees of the University of California, operator of the
Los Alamos National Laboratory under Contract No.  W-7405-ENG-36 with
the U.S. Department of Energy.  The U.S. Government has rights to use,
reproduce, and distribute this SOFTWARE, and to allow others to do so.
The public may copy, distribute, prepare derivative works and publicly
display this SOFTWARE without charge, provided that this Notice and
any statement of authorship are reproduced on all copies.  Neither the
Government nor the University makes any warranty, express or implied,
or assumes any liability or responsibility for the use of this
SOFTWARE.

If SOFTWARE is modified to produce derivative works, such modified
SOFTWARE should be clearly marked, so as not to confuse it with the
version available from LANL.
**/
/** NOTICE: This software is licensed under the GNU Public License, which
    is included as LICENSE_GPL in this source distribution. **/
/** NOTE: This library is part of the supermon project, hence the name
          supermon above. **/
/**
 * Matt's smaller s-expression parsing library
 *
 * Written by Matt Sottile (matt@lanl.gov), January 2002.
 ***/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "sexp.h"
#include "faststack.h"

/*
 * constants related to atom buffer sizes and growth.
 */
static int sexp_val_start_size = 256;
static int sexp_val_grow_size  = 64;

/*
 * Function for tuning growth parameters.
 */
void set_parser_buffer_params(int ss, int gs) {
  if (ss > 0)
    sexp_val_start_size = ss;
  else 
    fprintf(stderr,"PARSER.C: Cannot set buffer start size to a value<1.\n");

  if (gs > 0)
    sexp_val_grow_size = gs;
  else
    fprintf(stderr,"PARSER.C: Cannot set buffer grow size to a value<1.\n");
}

/**
 * this structure is pushed onto the stack so we can keep track of the
 * first and last elements in a list.
 * !!!!DON'T USE THESE OUTSIDE THIS FILE!!!
 */
typedef struct parse_stack_data
{
  sexp_t *fst, *lst;
}
parse_data_t;

/**
 * parse_data_t stack - similar malloc prevention to sexp_t_cache.
 */
faststack_t *pd_cache;

/** 
 * The global <I>sexp_t_cache</I> is a faststack implementing a cache of
 * pre-alloced s-expression element entities.  Odds are a user should never 
 * touch this.  If you do, you're on your own.  This is used internally by 
 * the parser and related code to store unused but allocated sexp_t elements.
 * This should be left alone and manipulated only by the sexp_t_allocate and
 * sexp_t_deallocate functions.  Touching the stack is bad.  
 */ 
faststack_t *sexp_t_cache;

/**
 * sexp_t allocation
 */
#ifdef _NO_MEMORY_MANAGEMENT_
sexp_t *
sexp_t_allocate() {
  sexp_t *sx = (sexp_t *) calloc(1, sizeof(sexp_t));
  assert(sx != NULL);
  return(sx);
}
#else
sexp_t *
sexp_t_allocate() {
  sexp_t *sx;
  stack_lvl_t *l;

  if (sexp_t_cache == NULL) {
    sexp_t_cache = make_stack();
    sx = (sexp_t *)malloc(sizeof(sexp_t));
    assert(sx != NULL);
    sx->next = sx->list = NULL;
  } else {
    if (empty_stack(sexp_t_cache)) {
      sx = (sexp_t *)malloc(sizeof(sexp_t));
      assert(sx != NULL);
      sx->next = sx->list = NULL;
    } else {
      l = pop(sexp_t_cache);
      sx = (sexp_t *)l->data;
    }
  }

  return sx;
}
#endif

/**
 * sexp_t de-allocation
 */
#ifdef _NO_MEMORY_MANAGEMENT_
void
sexp_t_deallocate(sexp_t *s) {
  /*  free(s);*/
}
#else
void
sexp_t_deallocate(sexp_t *s) {
  if (sexp_t_cache == NULL) sexp_t_cache = make_stack();

  s->list = s->next = NULL;
  sexp_t_cache = push(sexp_t_cache, s);
}
#endif

/**
 * cleanup the sexp library.  Note this is implemented HERE since we need
 * to know about pd_cache, which is local to this file.
 */
#ifdef _NO_MEMORY_MANAGEMENT_
void sexp_cleanup() {
}
#else
void sexp_cleanup() {
  stack_lvl_t *l;

  if (pd_cache != NULL) {
    l = pd_cache->top;
    while (l != NULL) {
      free(l->data);
      l = l->below;
    }
    destroy_stack(pd_cache);
    pd_cache = NULL;
  }

  if (sexp_t_cache != NULL) {
    l = sexp_t_cache->top;
    while (l != NULL) {
      free(l->data);
      l = l->below;
    }
    destroy_stack(sexp_t_cache);
    sexp_t_cache = NULL;
  }
}
#endif

/**
 * allocation
 */
parse_data_t *
pd_allocate() {
  parse_data_t *p;
  stack_lvl_t *l;

  if (pd_cache == NULL) {
    pd_cache = make_stack();
    p = (parse_data_t *)malloc(sizeof(parse_data_t));
    assert(p!=NULL);
  } else {
    if (empty_stack(pd_cache)) {
      p = (parse_data_t *)malloc(sizeof(parse_data_t));
      assert(p!=NULL);
    } else {
      l = pop(pd_cache);
      p = (parse_data_t *)l->data;
    }
  }

  return p;
}

/**
 * de-allocation
 */
void
pd_deallocate(parse_data_t *p) {
  if (pd_cache == NULL) pd_cache = make_stack();

  pd_cache = push(pd_cache, p);
}

/**
 * Destroy a continuation by freeing all of its fields that it is responsible
 * for managing, and then free the continuation itself.  This includes internal
 * buffers, stacks, etc..
 */
void
destroy_continuation (pcont_t * pc)
{
  stack_lvl_t *lvl;
  parse_data_t *lvl_data;

  if (pc == NULL) return; /* return if null passed in */

  if (pc->stack != NULL) {
    lvl = pc->stack->top;
    
    /*
     * note that destroy_stack() does not free the data hanging off of the
     * stack.  we have to walk down the stack and do that here. 
     */
    
    while (lvl != NULL) {
      lvl_data = (parse_data_t *)lvl->data;

      /**
       * Seems to have fixed bug with destroying partially parsed
       * expression continuations with the short three lines below.
       */
      if (lvl_data != NULL) {
        lvl_data->lst = NULL;
        destroy_sexp(lvl_data->fst);
        lvl_data->fst = NULL;

        /* free(lvl_data); */
        pd_deallocate(lvl_data);
        lvl->data = lvl_data = NULL;
      }

      lvl = lvl->below;
    }
    
    //
    // stack has no data on it anymore, so we can free it.
    //
    destroy_stack(pc->stack);
    pc->stack = NULL;
  }

  //
  // free up other allocated data
  //
  free (pc->val);
  free (pc);
}

/* 
 * wrapper around cparse_sexp.  assumes s contains a single, complete,
 * null terminated s-expression.  partial sexps or strings containing more
 * than one will act up.
 */
sexp_t *
parse_sexp (char *s, int len)
{
  pcont_t *pc = NULL;
  sexp_t *sx = NULL;

  pc = cparse_sexp (s, len, pc);
  sx = pc->last_sexp;

  destroy_continuation(pc);

  return sx;
}

pcont_t *
init_continuation(char *str) 
{
  pcont_t *cc;
  /* new continuation... */
  cc = (pcont_t *)malloc(sizeof(pcont_t));
  assert(cc != NULL);
  
  /* allocate atom buffer */
  cc->val = (char *)malloc(sizeof(char)*sexp_val_start_size);
  assert(cc->val != NULL);
  
  cc->val_allocated = sexp_val_start_size;
  cc->val_used = 0;

  /* allocate stack */
  cc->esc = 0;
  cc->stack = make_stack();
  cc->sbuffer = str;
  cc->lastPos = NULL;
  cc->state = 1;
  cc->vcur = cc->val;
  cc->depth = 0;
  cc->qdepth = 0;
  
  return cc;
}

/**
 * Iterative parser.  Wrapper around parse_sexp that is slightly more
 * intelligent and allows users to iteratively "pop" the expressions
 * out of a string that contains a bunch of expressions.
 * Useful if you have a string like "(foo bar)(goo har)(moo mar)" and
 * want to get "(foo bar)", "(goo har)", and "(moo mar)" individually on
 * repeated calls.
 */
sexp_t *
iparse_sexp (char *s, int len, pcont_t *cc) {
  pcont_t *pc;
  sexp_t *sx = NULL;
  
  /* 
   * sanity check.
   */
  if (cc == NULL) {
    fprintf(stderr,"iparse_sexp called with null continuation!\n");
    return NULL;
  }
  
  /* call the parser */
  pc = cparse_sexp(s,len,cc);
  
  if (cc->last_sexp != NULL) {
    sx = cc->last_sexp;
    cc->last_sexp = NULL;
  }
  
  return sx;
}

/*************************************************************************/
/*************************************************************************/
/*************************************************************************/
/*************************************************************************/
/*************************************************************************/

/**
 * Continuation based parser - the guts of the package.
 */
pcont_t *
cparse_sexp (char *str, int len, pcont_t *lc)
{
  char *t, *s;
  register unsigned int val_allocated = 0;
  register unsigned int val_used = 0;
  register unsigned int state = 1;
  register unsigned int depth = 0;
  register unsigned int qdepth = 0;
  register unsigned int elts = 0;
  register unsigned int esc = 0;
  pcont_t *cc;
  char *val, *vcur;
  sexp_t *sx = NULL;
  faststack_t *stack;
  parse_data_t *data;
  stack_lvl_t *lvl;
#ifdef _DEBUG_
  unsigned long fsm_iterations = 0;
  unsigned long maxdepth = 0;
#endif /* _DEBUG_ */
  char *bufEnd;

  /* make sure non-null string */
  if (str == NULL) {
    fprintf(stderr,"cparse_sexp: called with null string.\n");
    return lc;
  }
  
  /* first, if we have a non null continuation passed in, restore state. */
  if (lc != NULL) {
    cc = lc;
    val_used = cc->val_used;
    val_allocated = cc->val_allocated;
    val = cc->val;
    vcur = cc->vcur;
    state = cc->state;
    depth = cc->depth;
    qdepth = cc->qdepth;
    stack = cc->stack;
    esc = cc->esc;
    s = str;
    if (cc->lastPos != NULL)
      t = cc->lastPos;
    else {
      t = s;
      cc->sbuffer = str;
    }
  } else {
    /* new continuation... */
    cc = (pcont_t *)malloc(sizeof(pcont_t));
    assert(cc != NULL);
    
    /* allocate atom buffer */
    cc->val = val = (char *)malloc(sizeof(char)*sexp_val_start_size);
    assert(val != NULL);
    
    cc->val_used = val_used = 0;
    cc->val_allocated = val_allocated = sexp_val_start_size;

    vcur = val;
    
    /* allocate stack */
    cc->stack = stack = make_stack();
    
    /* t is temp pointer into s for current position */
    s = str;
    t = s;
    cc->sbuffer = str;
  }
  
  bufEnd = cc->sbuffer+len;

  /*==================*/
  /* main parser loop */
  /*==================*/
  while (t[0] != '\0' && t != bufEnd)
    {
#ifdef _DEBUG_
      printf("PARSER: STATE=%d CURCHAR=%c (0x%x)\n",state,t[0],t);
      printf("        VAL_ALLOCATED=%d VAL_USED=%d\n",val_allocated,val_used);
      fsm_iterations++;
#endif

      /* based on the current state in the FSM, do something */
      switch (state)
	{
	case 1:
	  switch (t[0])
	    {
	      /* space,tab,CR,LF considered white space */
	    case '\n':
	    case ' ':
	    case '\t':
	    case '\r':             
	      t++;
	      break;
              /* semicolon starts a comment that extends until a \n is
                 encountered. */
            case ';':
              t++;
              state = 11;
              break;
	      /* enter state 2 for open paren */
	    case '(':
	      state = 2;
	      t++;
	      break;
	      /* enter state 3 for close paran */
	    case ')':
	      state = 3;
	      break;
	      /* begin quoted string - enter state 5 */
	    case '\"':
	      state = 5;
	      /* set cur pointer to beginning of val buffer */
	      vcur = val;
	      t++;
	      break;
	      /* single quote - enter state 7 */
	    case '\'':
	      state = 7;
	      t++;
	      break;
	      /* other characters are assumed to be atom parts */
	    default:
	      /* set cur pointer to beginning of val buffer */
	      vcur = val;

              /** NOTE: the following code originally required a transition
                  to state 4 before processing the first atom character --
                  this required two iterations for the first character
                  of each atom.  merging this into here allows us to process
                  what we already know to be a valid atom character before
                  entering state 4. **/
	      vcur[0] = t[0];
	      if (t[0] == '\\') esc = 1;
	      else esc = 0;
              val_used++;

              if (val_used == val_allocated) {
                val = (char *)realloc(val,val_allocated+sexp_val_grow_size);
                assert(val != NULL);
                vcur = val + val_used;
                val_allocated += sexp_val_grow_size;
              } else vcur++;

	      t++;

	      /* enter state 4 */
	      state = 4;
	      break;
	    }
	  break;
	case 2:
	  /* open paren */
	  depth++;
	  /* sx = (sexp_t *) malloc (sizeof (sexp_t)); */
          sx = sexp_t_allocate();
	  assert(sx!=NULL);
	  elts++;
	  sx->ty = SEXP_LIST;
	  sx->next = NULL;
	  sx->list = NULL;
	  
	  if (stack->height < 1)
	    {
	      /* data = (parse_data_t *) malloc (sizeof (parse_data_t)); */
              data = pd_allocate();
	      assert(data!=NULL);
	      data->fst = data->lst = sx;
	      push (stack, data);
	    }
	  else
	    {
	      data = (parse_data_t *) top_data (stack);
	      if (data->lst != NULL)
		data->lst->next = sx;
	      else
		data->fst = sx;
	      data->lst = sx;
	    }
	  
	  /* data = (parse_data_t *) malloc (sizeof (parse_data_t)); */
          data = pd_allocate();
	  assert(data!=NULL);
	  data->fst = data->lst = NULL;
	  push (stack, data);
	  
	  state = 1;
	  break;
	case 3:
	  /** close paren **/
#ifdef _DEBUG_    
          if (depth > maxdepth) maxdepth = depth;
#endif /* _DEBUG_ */

          /* check for close parens that were never opened. */
          if (depth == 0) {
            fprintf(stderr,"Badly formed s-expression.  Parser exiting.\n");
	    cc->val = val;
            cc->val_used = val_used;
            cc->val_allocated = val_allocated;
	    cc->vcur = vcur;
	    cc->lastPos = t;
	    cc->depth = depth;
	    cc->qdepth = qdepth;
	    cc->state = 1;
	    cc->stack = stack;
	    cc->esc = 0;
	    cc->last_sexp = NULL;
            cc->error = 1;

#ifdef _DEBUG_
            fprintf(stderr,"State Machine Iterations: %d\nMaxdepth: %d\n",
                    fsm_iterations,maxdepth);
#endif /* debug */

	    return cc;
          }

	  t++;
	  depth--;

	  lvl = pop (stack);
	  data = (parse_data_t *) lvl->data;
	  sx = data->fst;
	  /* free (data); */
          pd_deallocate(data);
          lvl->data = NULL;

	  if (stack->top != NULL)
	    {
	      data = (parse_data_t *) top_data (stack);
	      data->lst->list = sx;
	    }
	  else
	    {
	      fprintf (stderr, "Hmmm. Stack->top is null.\n");
	    }

	  state = 1;

	  /** if depth = 0 then we finished a sexpr, and we return **/
	  if (depth == 0) {
            cc->error = 0;
	    cc->val = val;
            cc->val_allocated = val_allocated;
            cc->val_used = val_used;
	    cc->vcur = vcur;
	    cc->lastPos = t;
	    cc->depth = depth;
	    cc->qdepth = qdepth;
	    cc->state = 1;
	    cc->stack = stack;
	    cc->esc = 0;
	    while (stack->top != NULL)
	      {
		lvl = pop (stack);
		data = (parse_data_t *) lvl->data;
		sx = data->fst;
		/* free (data); */
                pd_deallocate(data);
                lvl->data = NULL;
	      }
	    cc->last_sexp = sx;

#ifdef _DEBUG_
            fprintf(stderr,"State Machine Iterations: %d\nMaxdepth: %d\n",
                    fsm_iterations,maxdepth);
#endif /* debug */

	    return cc;
	  }
	  break;
	case 4: /** parsing atom **/
	  if (esc == 1 && (t[0] == '\"' || t[0] == '(' ||
			   t[0] == ')' || t[0] == '\'' ||
			   t[0] == '\\')) {
	    vcur--; /* back up to overwrite the \ */
	    vcur[0] = t[0];
	    vcur++;
	    t++;
	    esc = 0;
	    break;
	  }

	  /* look at an ascii table - these ranges are the non-whitespace, non
	     paren and quote characters that are legal in atoms */
	  if (!((t[0] >= '*' && t[0] <= '~') ||
		((unsigned char)(t[0]) > 127) || 
		(t[0] == '!') ||
		(t[0] >= '#' && t[0] <= '&')))
	    {
	      vcur[0] = '\0';
              val_used++;

              sx = sexp_t_allocate();
	      assert(sx!=NULL);
	      elts++;
	      sx->ty = SEXP_VALUE;
              sx->val = val;
              sx->val_allocated = val_allocated;
              sx->val_used = val_used;
	      sx->next = NULL;
	      sx->aty = SEXP_BASIC;

              val = (char *)malloc(sizeof(char)*sexp_val_start_size);
              assert(val != NULL);
              val_allocated = sexp_val_start_size;
              val_used = 0;
              vcur = val;
	      
	      if (!empty_stack (stack))
		{
		  data = (parse_data_t *) top_data (stack);
		  if (data->fst == NULL)
		    {
		      data->fst = data->lst = sx;
		    }
		  else
		    {
		      data->lst->next = sx;
		      data->lst = sx;
		    }
		}
	      else
		{
                  /* looks like this expression was just a basic atom - so
                     return it. */
                  cc->error = 0;
                  cc->val = val;
                  cc->val_used = val_used;
                  cc->val_allocated = val_allocated;
                  cc->vcur = vcur;
                  cc->lastPos = t;
                  cc->depth = depth;
                  cc->qdepth = qdepth;
                  cc->state = 1;
                  cc->stack = stack;
                  cc->esc = 0;
                  cc->last_sexp = sx;
                  assert(sx != NULL);

                  return cc;
		}

	      switch (t[0]) {
              case ' ':
              case '\t':
              case '\n':
              case '\r':
                /** NOTE: we know whitespace following atom, so spin ahead
                    one and let state 1 do what it needs to for the next
                    character. **/
                state = 1;
                t++;
                break;
              case ')':
                state = 3;
                break;
              default:
                state = 1;
              }
	    }
	  else
	    {
	      vcur[0] = t[0];
	      if (t[0] == '\\') esc = 1;
	      else esc = 0;
              val_used++;

              if (val_used == val_allocated) {
                val = (char *)realloc(val,val_allocated+sexp_val_grow_size);
                assert(val != NULL);
                vcur = val + val_used;
                val_allocated += sexp_val_grow_size;
              } else vcur++;

	      t++;
	    }
	  break;
	case 5:
	  if (esc == 1 && (t[0] == '\"' ||
			   t[0] == '\'' ||
			   t[0] == '(' ||
			   t[0] == ')' ||
			   t[0] == '\\')) {
	    vcur--;
	    vcur[0] = t[0];
	    vcur++;
            /** NO NEED TO UPDATE VAL COUNTS **/
	    t++;
	    esc = 0;
	  }

	  if (t[0] == '\"')
	    {
	      state = 6;
	      vcur[0] = '\0';
              val_used++;
	      /* sx = (sexp_t *) malloc (sizeof (sexp_t)); */
              sx = sexp_t_allocate();
	      assert(sx!=NULL);
	      elts++;
	      sx->ty = SEXP_VALUE;
              sx->val = val;
              sx->val_used = val_used;
              sx->val_allocated = val_allocated;
	      sx->next = NULL;
	      sx->aty = SEXP_DQUOTE;

              val = (char *)malloc(sizeof(char)*sexp_val_start_size);
              assert(val != NULL);
              val_allocated = sexp_val_start_size;
              val_used = 0;
              vcur = val;
	      
	      if (!empty_stack (stack))
		{
		  data = (parse_data_t *) top_data (stack);
		  if (data->fst == NULL)
		    {
		      data->fst = data->lst = sx;
		    }
		  else
		    {
		      data->lst->next = sx;
		      data->lst = sx;
		    }
		}
	      else
		{
                  /* looks like this expression was just a basic double
                     quoted atom - so return it. */
                  t++; /* spin past the quote */

                  cc->error = 0;
                  cc->val = val;
                  cc->val_used = val_used;
                  cc->val_allocated = val_allocated;
                  cc->vcur = vcur;
                  cc->lastPos = t++;
                  cc->depth = depth;
                  cc->qdepth = qdepth;
                  cc->state = 1;
                  cc->stack = stack;
                  cc->esc = 0;
                  cc->last_sexp = sx;
                  assert(sx != NULL);

                  return cc;
		}
	    }
	  else
	    {
	      vcur[0] = t[0];
              val_used++;

              if (val_used == val_allocated) {
                val = (char *)realloc(val,val_allocated+sexp_val_grow_size);
                assert(val != NULL);
                vcur = val + val_used;
                val_allocated += sexp_val_grow_size;
              } else vcur++;

	      if (t[0] == '\\') { 
                esc = 1;  
	      } else 
                esc = 0;
	    }
	  t++;
	  break;
	case 6:
	  vcur = val;
	  state = 1;
	  break;
	case 7:
	  if (t[0] == '\"')
	    {
	      state = 5;
	      vcur = val;
	    }
	  else if (t[0] == '(')
	    {
	      vcur = val;
	      state = 8;
	    }
	  else
	    {
	      vcur = val;
	      state = 4;
	    }
	  break;
	case 8:
	  if (esc == 0) {
	    if (t[0] == '(')
	      {
		qdepth++;
	      }
	    else if (t[0] == ')')
	      {
		qdepth--;
		state = 9;
	      }
            else if (t[0] == '\"')
              {
                state = 10;
              }
	  } else {
	    esc = 0;
	  }
	  vcur[0] = t[0];
	  if (t[0] == '\\') esc = 1;
	  else esc = 0;
          val_used++;

          if (val_used == val_allocated) {
            val = (char *)realloc(val,val_allocated+sexp_val_grow_size);
            assert(val != NULL);
            vcur = val + val_used;
            val_allocated += sexp_val_grow_size;
          } else vcur++;

	  t++;
          /* let it fall through to state 9 if we know we're transitioning
             into that state */
          if (state != 9)
            break;
	case 9:
	  if (qdepth == 0)
	    {
	      state = 1;
	      vcur[0] = '\0';
	      /* sx = (sexp_t *) malloc (sizeof (sexp_t)); */
              sx = sexp_t_allocate();
	      assert(sx!=NULL);
	      elts++;
	      sx->ty = SEXP_VALUE;
              sx->val = val;
              sx->val_allocated = val_allocated;
              sx->val_used = val_used;
	      sx->next = NULL;
	      sx->aty = SEXP_SQUOTE;

              val = (char *)malloc(sizeof(char)*sexp_val_start_size);
              assert(val != NULL);
              val_allocated = sexp_val_start_size;
              val_used = 0;
              vcur = val;
	      
	      if (!empty_stack (stack))
		{
		  data = (parse_data_t *) top_data (stack);
		  if (data->fst == NULL)
		    {
		      data->fst = data->lst = sx;
		    }
		  else
		    {
		      data->lst->next = sx;
		      data->lst = sx;
		    }
		}
	      else
		{
                  /* looks like the whole expression was a single
                     quoted value!  So return it. */
                  cc->error = 0;
                  cc->val = val;
                  cc->val_used = val_used;
                  cc->val_allocated = val_allocated;
                  cc->vcur = vcur;
                  cc->lastPos = t;
                  cc->depth = depth;
                  cc->qdepth = qdepth;
                  cc->state = 1;
                  cc->stack = stack;
                  cc->esc = 0;
                  cc->last_sexp = sx;
                  assert(sx != NULL);

                  return cc;
		}
	    }
	  else
	    state = 8;
	  break;
        case 10:
          if (t[0] == '\"' && esc == 0)
            {
              state = 8;
            }
          vcur[0] = t[0];
          if (t[0] == '\\') esc = 1;
          else esc = 0;
          val_used++;

          if (val_used == val_allocated) {
            val = (char *)realloc(val,val_allocated+sexp_val_grow_size);
            assert(val != NULL);
            vcur = val + val_used;
            val_allocated += sexp_val_grow_size;
          } else vcur++;

          t++;
          break;
        case 11:
          if (t[0] == '\n') {
            state = 1;
          }
          t++;
          break;
	default:
	  fprintf (stderr, "Unknown parser state %d.\n", state);
	  break;
	}
    }

#ifdef _DEBUG_
  fprintf(stderr,"State Machine Iterations: %d\nMax Paren Depth: %d\n",
          fsm_iterations, maxdepth);
#endif /* _DEBUG_ */

  if (depth == 0 && elts > 0) {
    cc->error = 0;
    cc->val = val;
    cc->val_used = val_used;
    cc->val_allocated = val_allocated;
    cc->vcur = vcur;
    cc->lastPos = t;
    cc->depth = depth;
    cc->qdepth = qdepth;
    cc->state = 1;
    cc->stack = stack;
    cc->esc = 0;
    while (stack->top != NULL)
    {
      lvl = pop (stack);
      data = (parse_data_t *) lvl->data;
      sx = data->fst;
      /* free (data); */
      pd_deallocate(data);
      lvl->data = NULL;
    }
    cc->last_sexp = sx;
  } else {
    cc->val = val;
    cc->esc = esc;
    cc->vcur = vcur;
    cc->val_allocated = val_allocated;
    cc->val_used = val_used;
    if (t[0] == '\0' || t == bufEnd)
      cc->lastPos = NULL;
    else
      cc->lastPos = t;
    cc->depth = depth;
    cc->qdepth = qdepth;
    cc->state = state;
    cc->stack = stack;
    cc->last_sexp = NULL;
    cc->error = 0;
  }
  
  return cc;
}
