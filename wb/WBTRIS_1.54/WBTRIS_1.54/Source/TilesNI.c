#include "WBTRIS.h"

__chip UWORD GruenDataNI[] =
{
/* Plane 0 */
    0x0001,0x2AAB,0x5555,0x2AAB,0x5555,0x2AAB,0x5555,0x7FFF,
/* Plane 1 */
    0xFFFE,0x8000,0x8000,0x8000,0x8000,0x8000,0x8000,0x8000,
};

struct Image GruenNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    GruenDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD GruenWeissDataNI[] =
{
/* Plane 0 */
    0x0001,0x0001,0x0001,0x0001,0x0001,0x0001,0x0001,0x7FFF,
/* Plane 1 */
    0xFFFE,0xAAAA,0xD554,0xAAAA,0xD554,0xAAAA,0xD554,0x8000,
};

struct Image GruenWeissNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    GruenWeissDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD GruenWeissSchachDataNI[] =
{
/* Plane 0 */
    0x0001,0x2AAB,0x5555,0x2AAB,0x5555,0x2AAB,0x5555,0x7FFF,
/* Plane 1 */
    0xFFFE,0xD554,0xAAAA,0xD554,0xAAAA,0xD554,0xAAAA,0x8000,
};

struct Image GruenWeissSchachNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    GruenWeissSchachDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD GruenWeissSchraegDataNI[] =
{
/* Plane 0 */
    0x0001,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,
/* Plane 1 */
    0xFFFE,0xD554,0xAAAA,0xD554,0xAAAA,0xD554,0xAAAA,0x8000,
};

struct Image GruenWeissSchraegNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    GruenWeissSchraegDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD SchwarzDataNI[] =
{
/* Plane 0 */
    0x0001,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7FFF,
/* Plane 1 */
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0x8000,
};

struct Image SchwarzNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    SchwarzDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD SchwarzGruenDataNI[] =
{
/* Plane 0 */
    0x0001,0x2AAB,0x5555,0x2AAB,0x5555,0x2AAB,0x5555,0x7FFF,
/* Plane 1 */
    0xFFFE,0xAAAA,0xD554,0xAAAA,0xD554,0xAAAA,0xD554,0x8000,
};

struct Image SchwarzGruenNI =
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    SchwarzGruenDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};

__chip UWORD SchwarzWeissDataNI[] =
{
/* Plane 0 */
    0x0001,0x5555,0x2AAB,0x5555,0x2AAB,0x5555,0x2AAB,0x7FFF,
/* Plane 1 */
    0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0xFFFE,0x8000,
};

struct Image SchwarzWeissNI=
{
    0, 0,			/* Upper left corner */
    16, 8, 2,			/* Width, Height, Depth */
    SchwarzWeissDataNI,		/* Image data */
    0x0003, 0x0000,		/* PlanePick, PlaneOnOff */
    NULL			/* Next image */
};
