#ifndef	DATATYPES_SOUNDCLASSEXT_H
#define	DATATYPES_SOUNDCLASSEXT_H
/*
**  $VER: soundclassext.h 41.1 (28.11.98)
**  Includes Release 41.1
**
**  Interface definitions for DataType sound objects -
**  v41 extensions
**
**  (C) Copyright 1998 by Stephan Rupprecht
**	All Rights Reserved
*/

#ifndef DATATYPES_SOUNDCLASS_H
#include <datatypes/soundclass.h>
#endif

/****************************************************************************/

/* type of sample, one of the definitions below */
#define SDTA_SampleType	(SDTA_Dummy + 30)
/* describes the stereo field when playing a mono sample on two stereo
   channels. range 0 - 0x10000. 0 mutes the right channel, 0x10000 the
   left one, 0x8000 centers the sample in the stereo field (default).
   This attribute may affect a playing sound. */
#define SDTA_Panning		(SDTA_Dummy + 31)
/* set and get sample frequency. This attribute may affect a playing sound. */
#define SDTA_Frequency	(SDTA_Dummy + 32)

/****************************************************************************/

/* definitions for SDTA_SampleType (all types are signed) */
enum {
	SDTST_M8S,	// 8bit mono sample (default)
	SDTST_S8S,	// 8bit stereo sample (samplewise left/right)
	SDTST_M16S,	// same as SDTST_M8S but 16bit
	SDTST_S16S,	// same as SDTST_S8S but 16bit
};

/****************************************************************************/

/* some handy macros */
#define SDTM_ISSTEREO( SampleType )	( ( SampleType ) & 1 )
#define SDTM_CHANNELS( SampleType )	( SDTM_ISSTEREO( SampleType ) + 1 )
#define SDTM_BYTESPERSAMPLE( ST )	( ( ( ST ) >= SDTST_M16S ) ? 2 : 1 )
#define SDTM_BYTESPERPOINT( ST )	( SDTM_CHANNELS( ST ) * SDTM_BYTESPERSAMPLE( ST ) )

/****************************************************************************/

#endif
