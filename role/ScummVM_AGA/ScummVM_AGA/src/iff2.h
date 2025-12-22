#ifndef LIBRARIES_IFF_H
#define LIBRARIES_IFF_H
/*
**
**	$Id: iff.h,v 23.2 93/05/24 16:03:28 chris Exp $
**	$Revision: 23.2 $
**
**	$Filename: Libraries/iff.h $
**	$Author: Christian A. Weber $
**	$Release: 23.2 $
**	$Date: 93/05/24 16:03:28 $
**
**	Standard header file for programs using iff.library
**
**	COPYRIGHT (C) 1987-1993 BY CHRISTIAN A. WEBER, BRUGGERWEG 2,
**	CH-8037 ZUERICH, SWITZERLAND (chris@mighty.adsp.sub.org).
**	THIS FILE MAY BE FREELY DISTRIBUTED. USE AT YOUR OWN RISK.
**
*/

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

#define IFFNAME "iff.library"
#define IFFVERSION 23L					/* Current library version */

/****************************************************************************
**	Error codes (returned by IFFL_IFFError())
*/

#define IFFL_ERROR_BADTASK			-1	/* IFFL_IFFError() called by wrong task */
#define IFFL_ERROR_OPEN				16	/* Can't open file */
#define IFFL_ERROR_READ				17	/* Error reading file */
#define IFFL_ERROR_NOMEM			18	/* Not enough memory */
#define IFFL_ERROR_NOTIFF			19	/* File is not an IFF file */
#define IFFL_ERROR_WRITE			20	/* Error writing file */
#define IFFL_ERROR_NOILBM			24	/* IFF file is not of type ILBM */
#define IFFL_ERROR_NOBMHD			25	/* BMHD chunk not found */
#define IFFL_ERROR_NOBODY			26	/* BODY chunk not found */
#define IFFL_ERROR_BADCOMPRESSION	28	/* Unknown compression type */
#define IFFL_ERROR_NOANHD			29	/* ANHD chunk not found */
#define IFFL_ERROR_NODLTA			30	/* DLTA chunk not found */

#ifdef IFFLIB_PRE21NAMES
#define IFF_BADTASK -1
#define IFF_CANTOPENFILE 16
#define IFF_READERROR 17
#define IFF_NOMEM 18
#define IFF_NOTIFF 19
#define IFF_WRITEERROR 20
#define IFF_NOILBM 24
#define IFF_NOBMHD 25
#define IFF_NOBODY 26
#define IFF_TOOMANYPLANES 27
#define IFF_UNKNOWNCOMPRESSION 28
#define IFF_NOANHD 29
#define IFF_NODLTA 30
#endif


/****************************************************************************
**	Common IFF IDs
*/

#define IFFL_MAKE_ID(a,b,c,d) ((ULONG)(a)<<24L|(ULONG)(b)<<16L|(c)<<8|(d))

/*
**	Generic IFF IDs
*/
#ifndef ID_FORM		/* don't redefine these if iffparse.h is included */
#define ID_FORM IFFL_MAKE_ID('F','O','R','M')
#define ID_CAT  IFFL_MAKE_ID('C','A','T',' ')
#define ID_LIST IFFL_MAKE_ID('L','I','S','T')
#define ID_PROP IFFL_MAKE_ID('P','R','O','P')
#endif

/*
**	Specific IFF IDs
*/
#define ID_ANIM IFFL_MAKE_ID('A','N','I','M')
#define ID_ANHD IFFL_MAKE_ID('A','N','H','D')
#define ID_ANNO IFFL_MAKE_ID('A','N','N','O')
#define ID_BMHD IFFL_MAKE_ID('B','M','H','D')
#define ID_BODY IFFL_MAKE_ID('B','O','D','Y')
#define ID_CAMG IFFL_MAKE_ID('C','A','M','G')
#define ID_CLUT IFFL_MAKE_ID('C','L','U','T')
#define ID_CMAP IFFL_MAKE_ID('C','M','A','P')
#define ID_CRNG IFFL_MAKE_ID('C','R','N','G')
#define ID_CTBL IFFL_MAKE_ID('C','T','B','L')
#define ID_DLTA IFFL_MAKE_ID('D','L','T','A')
#define ID_ILBM IFFL_MAKE_ID('I','L','B','M')
#define ID_SHAM IFFL_MAKE_ID('S','H','A','M')

#define ID_8SVX IFFL_MAKE_ID('8','S','V','X')
#define ID_ATAK IFFL_MAKE_ID('A','T','A','K')
#ifndef ID_NAME
#define ID_NAME IFFL_MAKE_ID('N','A','M','E')
#endif
#define ID_RLSE IFFL_MAKE_ID('R','L','S','E')
#define ID_VHDR IFFL_MAKE_ID('V','H','D','R')

#ifdef IFFLIB_PRE21NAMES
#define MakeID(a,b,c,d) ((ULONG)(a)<<24L|(ULONG)(b)<<16L|(c)<<8|(d))
#endif


/****************************************************************************
**	Modes for IFFL_OpenIFF()
*/

#define IFFL_MODE_READ	0
#define IFFL_MODE_WRITE	1


/****************************************************************************
**	Modes for IFFL_CompressBlock() and IFFL_DecompressBlock()
*/

#define IFFL_COMPR_NONE		0x0000		/* generic */
#define IFFL_COMPR_BYTERUN1	0x0001		/* ILBM */
#define IFFL_COMPR_FIBDELTA	0x0101		/* 8SVX */


/****************************************************************************
**	Structure definitions
*/

/*
**	The private IFF 'FileHandle' structure
*/
typedef void *IFFL_HANDLE;


/*
**	Generic IFF chunk structure
*/
struct IFFL_Chunk
{
	LONG  ckID;
	LONG  ckSize;
/*  UBYTE ckData[ckSize] (variable sized data) */
};


/*
**	BMHD chunk (BitMapHeader) of ILBM files
*/
struct IFFL_BMHD
{
	UWORD w,h;
	WORD  x,y;
	UBYTE nPlanes;
	UBYTE masking;
	UBYTE compression;
	UBYTE pad1;
	UWORD transparentColor;
	UBYTE xAspect,yAspect;
	WORD  pageWidth,pageHeight;
};


/*
**	ANHD chunk (AnimHeader) of ANIM files
*/
struct IFFL_ANHD
{
	UBYTE	Operation;
	UBYTE	Mask;
	UWORD	W;
	UWORD	H;
	WORD	X;
	WORD	Y;
	ULONG	AbsTime;
	ULONG	RelTime;
	UBYTE	Interleave;
	UBYTE	pad0;
	ULONG	Bits;
	UBYTE	pad[16];
};

#ifdef IFFLIB_PRE21NAMES
#define Chunk IFFL_Chunk
#define BitMapHeader IFFL_BMHD
#define AnimHeader IFFL_ANHD
#endif


/****************************************************************************
**	IFF library function prototypes (ANSI C)
*/

void				 IFFL_CloseIFF        ( void * );
ULONG				 IFFL_CompressBlock   ( APTR, APTR, ULONG, ULONG );
BOOL				 IFFL_DecodePic       ( void *, struct BitMap * );
ULONG				 IFFL_DecompressBlock ( APTR, APTR, ULONG, ULONG );
void				*IFFL_FindChunk       ( void *, LONG );
struct IFFL_BMHD	*IFFL_GetBMHD         ( void * );
LONG				 IFFL_GetColorTab     ( void *, WORD * );
ULONG				 IFFL_GetViewModes    ( void * );
LONG				 IFFL_IFFError        ( void );
BOOL				 IFFL_ModifyFrame     ( void *, struct BitMap * );
APTR				 IFFL_NewOpenIFF      ( char *, LONG );
void *     			 IFFL_OpenIFF         ( char *, ULONG );
LONG				 IFFL_PopChunk        ( void * );
void *     			 IFFL_PPOpenIFF       ( char *, char * );
LONG				 IFFL_PushChunk       ( void *, ULONG, ULONG );
BOOL				 IFFL_SaveBitMap      ( char *, struct BitMap *, WORD *, LONG );
BOOL				 IFFL_SaveClip        ( char *, struct BitMap *, WORD *, LONG,
														LONG, LONG, LONG, LONG );
LONG				 IFFL_WriteChunkBytes ( void *, void *, LONG );


#ifdef IFFLIB_PRE21NAMES
void *OpenIFF(char *);
void CloseIFF(void *);
void *FindChunk(void *,LONG);
struct BitMapHeader *GetBMHD(void *);
LONG GetColorTab(void *,WORD *);
BOOL DecodePic(void *,struct BitMap *);
BOOL SaveBitMap(char *,struct BitMap *,WORD *,LONG);
BOOL SaveClip(char *,struct BitMap *,WORD *,LONG,LONG,LONG,LONG,LONG);
LONG IFFError(void);
ULONG GetViewModes(void *);
APTR NewOpenIFF(char *,LONG);
BOOL ModifyFrame(void *,struct BitMap *);
void *PPOpenIFF(char *,char *);
#endif


/****************************************************************************
**	Pragmas for SAS/C
**	(generated with: 'fd2pragma iff_lib.fd iff_pragmas.h')
*/

extern struct Library *IFFBase;


#endif

