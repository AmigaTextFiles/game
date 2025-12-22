
/*
 * Hashtable
 *
 * Description
 *
 *    Generic hashtable requiring hash and comparison functions for
 *    the key type.  See `man hashtable' or 
 *    `cat hashtable.3 | nroff -man | $PAGER'.
 *
 * Author 
 *
 *    John Pritchard, john@syntelos.org */

#if !defined(_SYNTELOS_HASHTABLE_H)
#define _SYNTELOS_HASHTABLE_H

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
# define _REENTRANT
# include <pthread.h>

# if OS == Linux
#  define pthread_mutexattr_settype(x, y) pthread_mutexattr_setkind_np(x, y)
#  define PTHREAD_MUTEX_RECURSIVE         PTHREAD_MUTEX_RECURSIVE_NP
#  define PTHREAD_MUTEX_NORMAL            MUTEX_FAST_NP
#  define PTHREAD_MUTEX_ERRORCHECK        MUTEX_NONRECURSIVE_NP 
  // PTHREAD_MUTEX_DEFAULT  undefined.
# endif
#endif

#if !defined(_SYNTELOS_STDMISC)
#define _SYNTELOS_STDMISC

#if defined(NULL)
#  define null NULL
#else
#  define null 0
#endif

typedef enum { false, true} boolean;

#define false 0
#define true 1

typedef unsigned char byte ;

typedef long long blong ;

#endif /* _SYNTELOS_STDMISC */

#ifdef __cplusplus
extern "C" {
#endif

#define HASHTABLE_LEN_INIT 127

#define HASHTABLE_DEPTH_THRESHOLD 3

#define HASHTABLE_REHASH_FACTOR 1.5f

typedef struct hashtable_entry_ {

  unsigned long hash;

  void* key;

  void* value;

  struct hashtable_entry_ * sibling;

} hashtable_entry ;

typedef struct  {

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
  boolean mtsafety;

  pthread_mutex_t mutex;
#endif

  unsigned long (*keyhash)(void*);

  int (*keycomp)(void*,void*);

  unsigned int tablelen_init;

  unsigned int tablelen;

  hashtable_entry** table;

} hashtable ;

hashtable* hashtable_init_len( unsigned long (*hash)(void*), int (*comp)(void*,void*), unsigned int initlen);

hashtable* hashtable_init( unsigned long (*hash)(void*), int (*comp)(void*,void*));

hashtable* hashtable_init_mt( unsigned long (*hash)(void*), int (*comp)(void*,void*));

hashtable* hashtable_init_mt_len( unsigned long (*hash)(void*), int (*comp)(void*,void*), unsigned int initlen);

void hashtable_release( hashtable* ht);

void hashtable_release_values( hashtable* ht);

void hashtable_clear( hashtable* ht);

void hashtable_destroy( hashtable* ht);

int hashtable_size( hashtable* ht);

int hashtable_copyinto( hashtable* ht, void*** array, int arraylen);

void* hashtable_get ( hashtable* ht, void* key);

void* hashtable_put ( hashtable* ht, void* key, void* value);

void* hashtable_remove ( hashtable* ht, void* key);

void* hashtable_remove_value ( hashtable* ht, void* key);

unsigned long hashtable_strhash ( void* string);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* _HASHTABLE_H */
