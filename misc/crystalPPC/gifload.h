typedef struct {
     unsigned char red, green, blue;
} RGBcolor;

typedef enum { formatGIF87, formatGIF89, formatPPM, formatUnknown } 
   Graphic_file_format;

typedef enum { gfTrueColor, gfPaletted } Graphic_file_type;

typedef struct Graphic_file {
     Graphic_file_type type;
     int height, width;
     int palette_entries;
     long transparent_entry;
     RGBcolor *palette;
     unsigned char *bitmap;
} Graphic_file;


extern Graphic_file *new_graphic_file();
extern void free_graphic_file(Graphic_file *gfile);
extern int graphic_file_pixel(Graphic_file *gfile, int x, int y,
				  RGBcolor *rgb);
extern Graphic_file *read_graphic_file(char *filename);

extern Graphic_file *LoadGIF(FILE *fp, char *fname );
