/*
	pathutil.c
	filename handling utilities

	$Id: pathutil.h 3961 2011-05-20 16:32:36Z sezero $
*/

#ifndef __PATHUTIL_H
#define __PATHUTIL_H

#define PATHSEPERATOR	'/'

#ifdef _MAX_PATH
#define	MAX_OSPATH	_MAX_PATH
#else
#define	MAX_OSPATH	256
#endif

void	DefaultExtension (char *path, const char *extension, size_t len);
void	DefaultPath (char *path, const char *basepath, size_t len);
void	StripFilename (char *path);
void	StripExtension (char *path);

void	ExtractFilePath (const char *in, char *out, size_t outsize);
void	ExtractFileBase (const char *in, char *out, size_t outsize);
void	ExtractFileExtension (const char *in, char *out, size_t outsize);

const char *FileGetExtension (const char *in); /* doesn't return NULL */

#endif	/* __PATHUTIL_H */

