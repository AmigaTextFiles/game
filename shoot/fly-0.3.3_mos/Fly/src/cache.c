#include "hashtable.h"
#include "object3d.h"

hashtable *cache = NULL;

void Cache_init()
{
    cache = hashtable_init( hashtable_strhash, (int (*)(void*,void*))strcmp);
}


Object3d *Cache_get_object3d(char *filename)
{
    Object3d *o = 
        (Object3d *)hashtable_get(cache, filename);

    if(o == NULL) {
        o = (Object3d *)malloc(sizeof(Object3d));
        Object3d_load(o, filename);
        //Object3d_calc_normals(o);
        Object3d_gen_list(o);
        hashtable_put(cache, filename, o);
    }

    return o;
}
