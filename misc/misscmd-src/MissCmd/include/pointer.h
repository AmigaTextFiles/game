#ifndef POINTER_H
#define POINTER_H 1

typedef struct {
	Object *ptr;
	int32 width, height;
	struct BitMap bm;
} pointer;

pointer *CreatePointer (char * filename, int32 xoffs, int32 yoffs);
void DeletePointer (pointer *ptr);
void SetDisplayPointer (display *disp, pointer *ptr);

#endif
