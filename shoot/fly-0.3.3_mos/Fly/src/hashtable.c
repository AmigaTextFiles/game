
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

#include "hashtable.h"

/*
 * Allocate default hashtable.  With `pthread semantics',
 * synchronization is disabled by default.  */
hashtable* hashtable_init_len( unsigned long (*hash)(void*), int (*comp)(void*,void*), unsigned int initlen){

  if ( null == comp){

    fprintf( stderr, "Null comparison function initializing hashtable.");

    return null;
  }
  else if ( null == hash){

    fprintf( stderr, "Null hash function initializing hashtable.");

    return null;
  }
  else {

    hashtable* ht = (hashtable*) calloc( 1, sizeof( hashtable));

    if ( null == ht){

      fprintf( stderr, "Out of memory while initializing hashtable.");

      return null;
    }
    else {

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      pthread_mutexattr_t mattr; 

      if ( pthread_mutexattr_init( &mattr)){ 

	fprintf( stderr, "Error initializing hashtable mutex attribute object (%s).", strerror(errno));

	pthread_mutexattr_destroy(&mattr);

	free(ht);

	return null;
      }
      else if ( pthread_mutexattr_settype( &mattr, PTHREAD_MUTEX_RECURSIVE)){ 

	fprintf( stderr, "Error initializing hashtable mutex attributes (%s).", strerror(errno));

	pthread_mutexattr_destroy(&mattr);

	free(ht);

	return null;
      }
#endif

      ht->tablelen_init = initlen;

      ht->keyhash = hash;

      ht->keycomp = comp;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS) 
      if ( pthread_mutex_init( &(ht->mutex), &mattr)){

	fprintf( stderr, "Error initializing hashtable mutex (%s).", strerror(errno));

	free(ht);

	pthread_mutexattr_destroy(&mattr);

	return null;
      }
      else {
	pthread_mutexattr_destroy(&mattr);

	return ht;
      }
#else 
      return ht;
#endif
    }
  }
}

hashtable* hashtable_init( unsigned long (*hash)(void*), int (*comp)(void*,void*)){
  return hashtable_init_len( hash, comp, HASHTABLE_LEN_INIT);
}

/*
 * Allocate hashtable if we have `pthread semantics', otherwise return
 * null.  Enable synchronization on a hashtable to be returned. */
hashtable* hashtable_init_mt_len( unsigned long (*hash)(void*), int (*comp)(void*,void*), unsigned int initlen){
#if defined(_HASHTABLE_PTHREAD_SEMANTICS)

  hashtable* ht = hashtable_init_len( hash, comp, initlen);

  if ( null == ht)

    return null;

  else {

    ht->mtsafety = true;

    return ht;
  }
#else
  return null;
#endif
}

hashtable* hashtable_init_mt( unsigned long (*hash)(void*), int (*comp)(void*,void*)){
  return hashtable_init_mt_len( hash, comp, HASHTABLE_LEN_INIT);
}

static void ent_clear( hashtable_entry* ent){
  if ( null != ent){

    hashtable_entry* sib = ent->sibling;

    if ( null != sib)
      ent_clear(sib);

    free(ent->key);
    free(ent->value);
    free(ent);
  }
}
static void ent_release( hashtable_entry* ent){
  if ( null != ent){

    hashtable_entry* sib = ent->sibling;

    if ( null != sib)
      ent_release(sib);

    free(ent);
  }
}
static void ent_release_values( hashtable_entry* ent){
  if ( null != ent){

    hashtable_entry* sib = ent->sibling;

    if ( null != sib)
      ent_release_values(sib);

    free(ent->key);
    free(ent);
  }
}
static int ent_count( hashtable_entry* ent){

  if ( null != ent){

    hashtable_entry* sib = ent->sibling;

    if ( null != sib)
      return ent_count(sib)+1;
    else
      return 1;
  }
  else
    return 0;
}

/*
 * Empty hashtable, free all resources.  */
void hashtable_clear( hashtable* ht){

  if ( null == ht)

    return;

  else {

    hashtable_entry** table ;

    int tabc, tablen;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    table = ht->table;

    tablen = ht->tablelen;

    for ( tabc = 0; tabc < tablen; tabc++){

      ent_clear( table[tabc]);

      table[tabc] = null;
    }

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex));
#endif
  }
}

/*
 * Empty hashtable, free internal resources, preserve contained
 * resources.  */
void hashtable_release( hashtable* ht){

  if ( null == ht)

    return;

  else {

    hashtable_entry** table;

    int tabc, tablen;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    table = ht->table;

    tablen = ht->tablelen;

    for ( tabc = 0; tabc < tablen; tabc++){

      ent_release( table[tabc]);

      table[tabc] = null;
    }

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

  }
}

/*
 * Empty hashtable, free internal resources, preserve contained
 * values, free contained keys.  */
void hashtable_release_values( hashtable* ht){

  if ( null == ht)

    return;

  else {

    hashtable_entry** table ;

    int tabc, tablen ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    table = ht->table;

    tablen = ht->tablelen;

    for ( tabc = 0; tabc < tablen; tabc++){

      ent_release_values( table[tabc]);

      table[tabc] = null;
    }

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

  }
}

/*
 * Empty hashtable, free all contained resources, free hashtable.  */
void hashtable_destroy( hashtable* ht){

  if ( null == ht)

    return;

  else {

    hashtable_clear(ht);
    
#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    pthread_mutex_destroy( &(ht->mutex)); 
#endif

    if ( 0 < ht->tablelen)
      free(ht->table);

    free(ht);
  }
}

/*
 * Return number of key- value pairs in hashtable
 */
int hashtable_size( hashtable* ht){

  if ( null == ht)

    return 0;

  else {

    hashtable_entry** table ;

    int count = 0, tabc, tablen ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    table = ht->table;

    tablen = ht->tablelen;

    for ( tabc = 0; tabc < tablen; tabc++){

      count += ent_count( table[tabc]);
    }

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

    return count;
  }
}

static int ent_copyinto( void*** array, int arix, int arraylen, hashtable_entry* ent){

  if ( null != ent && arix < arraylen){

    hashtable_entry* sib = ent->sibling;

    array[arix][0] = ent->key;

    array[arix][1] = ent->value;

    if ( null != sib)
      return ent_copyinto(array, (arix+1), arraylen, sib)+1;
    else
      return 1;
  }
  else
    return 0;
}
/*
 * Assign key & value references into `array'.  Intended where
 * `arraylen == hashtable_size()'.  */
int hashtable_copyinto( hashtable* ht, void*** array, int arraylen){

  if ( null == ht)

    return 0;

  else {

    hashtable_entry** table ;

    int arix = 0, tabc, tablen ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    table = ht->table;

    tablen = ht->tablelen;

    for ( tabc = 0; tabc < tablen; tabc++){

      arix += ent_copyinto( array, arix, arraylen, table[tabc]);
    }

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

    return arix;
  }
}

static void* ent_get( hashtable* ht, hashtable_entry* ent, void* key){

  if ( null == ent)

    return null;

  else {

    if ( 0 == ht->keycomp( key, ent->key)){

      return ent->value;
    }
    else {

      hashtable_entry* sib = ent->sibling;

      if ( null != sib)
	return ent_get( ht, sib, key);
      else
	return null;
    }
  }
}
/*
 * 
 */
void* hashtable_get ( hashtable* ht, void* key){

  if ( null != ht && null != key) {

    unsigned long tablen ;

    hashtable_entry** table ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    tablen = ht->tablelen;

    table = ht->table;

    if ( 0 < tablen){

      int tidx = (ht->keyhash(key)) % tablen;

      void* value = ent_get( ht, table[tidx], key);

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return value;
    }
    else {

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return null;
    }
  }
  else
    return null;
}

static void* ent_rm( hashtable* ht, hashtable_entry* entolder, hashtable_entry** entp, void* key, boolean freekey){

  hashtable_entry* ent = *entp;

  if ( null == ent)

    return null;

  else {

    void* tekey = ent->key;

    if ( 0 == ht->keycomp( key, tekey)){

      void* value = ent->value;

      if ( null != entolder)
	entolder->sibling = ent->sibling;
      else
	*entp = ent->sibling;

      free(ent);

      if (freekey)
	free(tekey);

      return value;
    }
    else {

      hashtable_entry* sib = ent->sibling;

      if ( null != sib)
	return ent_rm( ht, ent, &sib, key, freekey);
      else
	return null;
    }
  }
}
/*
 * 
 */
void* hashtable_remove ( hashtable* ht, void* key){

  if ( null != ht && null != key) {

    unsigned long tablen ;

    hashtable_entry** table ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    tablen = ht->tablelen;

    table = ht->table;

    if ( 0 < tablen){

      int tidx = (ht->keyhash(key)) % tablen;

      void* value = ent_rm( ht, null, &(table[tidx]), key, true);

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return value;
    }
    else {

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return null;
    }
  }
  else
    return null;
}
void* hashtable_remove_value ( hashtable* ht, void* key){

  if ( null != ht && null != key) {

    unsigned long tablen ;

    hashtable_entry** table ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    tablen = ht->tablelen;

    table = ht->table;

    if ( 0 < tablen){

      int tidx = (ht->keyhash(key)) % tablen;

      void* value = ent_rm( ht, null, &(table[tidx]), key, false);

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return value;
    }
    else {

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return null;
    }
  }
  else
    return null;
}

static hashtable_entry* rehash_ent_append ( hashtable_entry* list, hashtable_entry* append){

  if ( null == append)

    return list;

  else if ( null == list)

    return append;

  else {

    hashtable_entry* sib = list->sibling;

    if ( null != sib)

      return rehash_ent_append( sib, append);

    else {

      list->sibling = append;

      return append;
    }
  }
}

/*
 * Destroy existing table
 */
static hashtable_entry* rehash_enumerate_table ( hashtable* ht){
  
  if ( null == ht)

    return null;

  else {

    hashtable_entry** table = ht->table;

    hashtable_entry* entlist = null, *entp = null;

    int tabc, tablen = ht->tablelen;

    if ( 0 < tablen){

      for ( tabc = 0; tabc < tablen; tabc++){

	entp = rehash_ent_append( entp, table[tabc]);

	if ( null == entlist)
	  entlist = entp;

      }

      return entlist;
    }
    else
      return null;
  }
}
/*
 * Called from inside `put' when depth becomes excessive.
 */
static void rehash ( hashtable* ht){

  unsigned int size = hashtable_size( ht), tidx;

  unsigned int ntablen = (size * HASHTABLE_REHASH_FACTOR), ntabytes;

  hashtable_entry* list = rehash_enumerate_table ( ht), *ent, *tent, **table;

  if ( 0 == (ntablen & 0x1))
    ntablen += 1;

  ntabytes = (ntablen * sizeof(void*));

  ht->tablelen = ntablen;

  table = ht->table = realloc ( ht->table, ntabytes);

  memset( table, 0, ntabytes);

  while ( null != list){

    ent = list;

    list = ent->sibling;

    ent->sibling = null;

    tidx = (ent->hash) % ntablen;

    tent = table[tidx];

    if ( null == tent)

      table[tidx] = ent;

    else 
      rehash_ent_append( tent, ent);
  }
}

/*
 * Returns depth of new location in branch
 */
static int ent_put ( hashtable* ht, hashtable_entry* ent, void* key, unsigned long keyhash, void* value){

  if ( 0 == ht->keycomp( key, ent->key)){

    ent->value = value;

    return 1;
  }
  else if ( null == ent->sibling){

    hashtable_entry* sib = ent->sibling = (hashtable_entry*) calloc( 1, sizeof(hashtable_entry));

    sib->hash = keyhash;

    sib->key = key;

    sib->value = value;

    return 1;
  }
  else 
    return ent_put ( ht, ent->sibling, key, keyhash, value)+ 1;
}
/*
 * Return value
 */
void* hashtable_put ( hashtable* ht, void* key, void* value){

  if ( null != ht && null != key && null != value) {

    unsigned long tablen ;

    hashtable_entry** table ;

    hashtable_entry* ent ;

    unsigned long keyhash;

    int tidx ;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
    if ( ht->mtsafety)
      pthread_mutex_lock( &(ht->mutex));
#endif

    tablen = ht->tablelen;

    table = ht->table;

    if ( 0 == tablen){

      tablen = ht->tablelen = ht->tablelen_init;

      table = ht->table = (hashtable_entry**) calloc ( tablen, sizeof(void*));

      if ( null == table){

	fprintf( stderr, "Out of memory allocating table in hashtable.");

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
	if ( ht->mtsafety)
	  pthread_mutex_unlock( &(ht->mutex)); 
#endif

	return null;
      }
      else {
	keyhash = ht->keyhash(key);

	tidx = keyhash % tablen;
      }
    }
    else {

      keyhash = ht->keyhash(key);

      tidx = keyhash % tablen;
    }

    ent = table[tidx];

    if ( null == ent){

      ent = (hashtable_entry*) calloc( 1, sizeof(hashtable_entry));

      ent->hash = keyhash;

      ent->key = key;

      ent->value = value;

      table[tidx] = ent;

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return value;
    }
    else {

      int depth = ent_put( ht, ent, key, keyhash, value);

      if ( HASHTABLE_DEPTH_THRESHOLD < depth)
	rehash( ht);

#if defined(_HASHTABLE_PTHREAD_SEMANTICS)
      if ( ht->mtsafety)
	pthread_mutex_unlock( &(ht->mutex)); 
#endif

      return value;
    }
  }
  else
    return null;
}

/*
 * Standard ELF hash function.
 */
unsigned long hashtable_strhash ( void* string){

  unsigned char *name = (char*)string;

  register unsigned int h = 0, g;

  while (*name) {

    h = (h << 4) + *name++;

    if ((g = h & 0xf0000000))
      h ^= g >> 24;

    h &= ~g;
  }
  return h;
}
