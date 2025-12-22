#include "texture.h"

//----------------------------------------------//
class_texture::class_texture ()
{
	texture[0]= 0;
	textureImage[0]= NULL;
}
//----------------------------------------------//
class_texture::~class_texture ()
{
	del ();
}
//----------------------------------------------//
SDL_Surface *class_texture::fileBMP (char *input_fileName)
{
	Uint8 *rowhi, *rowlo;
	Uint8 *tmpbuf, tmpch;
	SDL_Surface *image;
	int i, j;

	image= SDL_LoadBMP (input_fileName);
	if (image == NULL)
		return (NULL);
	tmpbuf= new Uint8[image->pitch];
	if (tmpbuf == NULL)
		return (NULL);
	rowhi= (Uint8 *) image->pixels;
	rowlo= rowhi + (image->h * image->pitch) - image->pitch;
	for (i= 0; i < image->h/2; ++i)
	{
		for (j= 0; j < image->w; ++j)
		{
			tmpch= rowhi[j*3];
			rowhi[j*3]= rowhi[j*3+2];
			rowhi[j*3+2]= tmpch;
			tmpch= rowlo[j*3];
			rowlo[j*3]= rowlo[j*3+2];
			rowlo[j*3+2]= tmpch;
		}
		memcpy (tmpbuf, rowhi, image->pitch);
		memcpy (rowhi, rowlo, image->pitch);
		memcpy (rowlo, tmpbuf, image->pitch);
		rowhi+= image->pitch;
		rowlo-= image->pitch;
	}
	delete [] tmpbuf;
	return (image);
}
//----------------------------------------------//
int class_texture::loadBMP (char *input_fileName)
{
	del ();
	if (!(textureImage[0]= fileBMP (input_fileName)))
      return _ERR_;
	glGenTextures (1, &texture[0]);
	glBindTexture (GL_TEXTURE_2D, texture[0]);
	glTexImage2D (GL_TEXTURE_2D, 0, 3, textureImage[0]->w, textureImage[0]->h, 0, GL_RGB, GL_UNSIGNED_BYTE, textureImage[0]->pixels);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
	if (textureImage[0])
		SDL_FreeSurface (textureImage[0]);
	return _OK_;
}
//----------------------------------------------//
int class_texture::use ()
{
	if (texture[0])
	{
		glBindTexture(GL_TEXTURE_2D, texture[0]);
		return _OK_;
	}
	return _ERR_;
}
//----------------------------------------------//
int class_texture::del ()
{
	if (texture[0])
	{
		glDeleteTextures (1, texture);
		return _OK_;
	}
	return _ERR_;
}
//----------------------------------------------//
