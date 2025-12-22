#include "main.h"
#include <intuition/pointerclass.h>

#define OK 0
#define NOTOK 1

static uint32 BRUN_Unpack (BPTR file, uint8 *buf, int32 size) {
	int32 stat, len, rw;
	int c;

	stat = size;
	while (stat > 0) {
		c = FGetC(file);
		if (c == -1) break;
		c = (int8)c;
		if (c == -128) continue;
		if (c >= 0) {
			len = ((c+1) > stat) ? stat : (c+1);
			rw = FRead(file, buf, 1, len);
			stat -= rw; buf += rw;
			if (rw != len) break;
		} else {
			len = ((-c+1) > stat) ? stat : (-c+1);
			c = FGetC(file);
			if (c == -1) break;
			memset(buf, c, len);
			stat -= len; buf += len;
		}
	}
	return size - stat;
}

pointer *CreatePointer (char * filename, int32 xoffs, int32 yoffs) {
	pointer *ptr;
	BPTR file;

	ptr = NULL;
	file = Open(filename, MODE_OLDFILE);

	if (file) {
		int32 stat, err = OK;

		{
			struct { uint32 id, size, type; } hdr;

			stat = Read(file, &hdr, sizeof(hdr));
			if (stat != sizeof(hdr) || hdr.id != ID_FORM || hdr.type != ID_ILBM)
				err = NOTOK;
		}

		{
			struct { uint32 id, size; } ch;

			int bmh_found = FALSE;
			int32 width, height, bpr;

			while (!ptr && err == OK && Read(file, &ch, sizeof(ch)) == sizeof(ch)) {
				switch (ch.id) {

					case ID_BMHD:
						bmh_found = TRUE;
						{
							struct BitMapHeader bmh;
							stat = Read(file, &bmh, sizeof(bmh));
							if (stat != sizeof(bmh)) {
								err = NOTOK;
								break;
							}
							width = bmh.bmh_Width;
							height = bmh.bmh_Height;
							bpr = ((width+15) >> 4) << 1;
							if (bmh.bmh_Compression != cmpByteRun1 || bmh.bmh_Depth != 2) {
								err = NOTOK;
								break;
							}
						}
						break;

					case ID_BODY:
						if (bmh_found != TRUE)
							break;
						ptr = AllocMem(sizeof(*ptr), MEMF_ANY|MEMF_CLEAR);
						if (ptr) {
							struct BitMap *bm = &ptr->bm;
							int32 n, y, mod;

							ptr->width = width;
							ptr->height = height;
							InitBitMap(bm, 2, width, height);
							bm->Planes[0] = AllocRaster(width, height);
							bm->Planes[1] = AllocRaster(width, height);
							if (bm->Planes[0] == NULL || bm->Planes[1] == NULL) {
								err = NOTOK;
								break;
							}
							for (y = 0; y < height && err == OK; y++) {
								for (n = 0; n < 2; n++) {
									stat = BRUN_Unpack(file, (uint8 *)bm->Planes[n] + (y*bpr), bpr);
									if (stat != bpr) {
										err = NOTOK;
										break;
									}
								}
							}
							if (err == OK) {
								ptr->ptr = NewObject(NULL, "pointerclass",
									POINTERA_BitMap,		bm,
									POINTERA_WordWidth,	bpr >> 1,
									POINTERA_XOffset,		xoffs,
									POINTERA_YOffset,		yoffs,
									TAG_END);
								if (ptr->ptr == NULL) err = NOTOK;
							}
						}
						break;

					default:
						if (Seek(file, (ch.size+1)&~1, OFFSET_CURRENT) == -1)
							err = NOTOK;
						break;

				}
			}
		}
		if (ptr && err != OK) {
			DeletePointer(ptr);
			ptr = NULL;
		}
		Close(file);
	}
	return ptr;
}

void DeletePointer (pointer *ptr) {
	if (ptr == NULL) return;
	DisposeObject(ptr->ptr);
	if (ptr->bm.Planes[0]) FreeRaster(ptr->bm.Planes[0], ptr->width, ptr->height);
	if (ptr->bm.Planes[1]) FreeRaster(ptr->bm.Planes[1], ptr->width, ptr->height);
	FreeMem(ptr, sizeof(*ptr));
}

void SetDisplayPointer (display *disp, pointer *ptr) {
	if (ptr == NULL)
		SetWindowPointer(disp->win, WA_Pointer, NULL, TAG_END);
	else
		SetWindowPointer(disp->win, WA_Pointer, ptr->ptr, TAG_END);
}
