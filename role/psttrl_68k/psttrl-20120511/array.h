#ifndef __KSMN_ARRAY_H__
#define __KSMN_ARRAY_H__

int **array2_new(int size_x, int size_y);
void array2_delete(int **p, int size_x, int size_y);
int ***array3_new(int size_z, int size_x, int size_y);
void array3_delete(int ***p, int size_z, int size_x, int size_y);

#endif /* not __KSMN_ARRAY_H__ */
