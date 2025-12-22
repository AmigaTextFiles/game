/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
#include "General.h"

///////////////////////////////////////////////////////////////////
// General Methods
///////////////////////////////////////////////////////////////////

Uint32 getPixel(SDL_Surface *surface, int x, int y)
{
	int bpp = surface->format->BytesPerPixel;
	// Here p is the address to the pixel we want to retrieve
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

	switch(bpp)
	{
	case 1:
		return *p;
	case 2:
		return *(Uint16 *)p;
	case 3:
		if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
			return p[0] << 16 | p[1] << 8 | p[2];
		else
			return p[0] | p[1] << 8 | p[2] << 16;
	case 4:
		return *(Uint32 *)p;
	default:
		return 0; // shouldn't happen, but avoids SV_WARNINGs
	}
}



// Set the pixel at (x, y) to the given value
// NOTE: The surface must be locked before calling this!
void putPixel(SDL_Surface *surface, int x, int y, Uint32 pixel)
{
	// Check to make sure the pixel is in range first.
	if (x < 0 || x > surface->w)
		return;
	if (y < 0 || y > surface->h)
		return;
		
	int bpp = surface->format->BytesPerPixel;
	// Here p is the address to the pixel we want to set
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

	switch(bpp)
	{
	case 1:
		*p = pixel;
		break;
	case 2:
		*(Uint16 *)p = pixel;
		break;
	case 3:
		if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
		{
			p[0] = (pixel >> 16) & 0xff;
			p[1] = (pixel >> 8) & 0xff;
			p[2] = pixel & 0xff;
		} 
		else
		{
			p[0] = pixel & 0xff;
			p[1] = (pixel >> 8) & 0xff;
			p[2] = (pixel >> 16) & 0xff;
		}
		break;
	case 4:
		*(Uint32 *)p = pixel;
		break;
	}
}

// Calculate the angles between the start and end point
// If we need it in terms of the screen then flip the y component
// I.e. 0,0 to be in the top left corner of the screen - screen mode
// or 0,0 at bottom left
double quadrantise(Point start, Point end, bool screen = false)
{
	return quadrantise(end.x - start.x, end.y - start.y, screen);
}

double quadrantise(double x, double y, bool screen = false)
{
	double angle = 0.0;

	if (screen)
		y *= -1;

	if (y != 0 and x != 0)
		angle = fabs(atan(y/x));
 
	if (x < 0 and y > 0) // #left and down
		angle = M_PI - angle;
	else if (x < 0 and y < 0) // #left and up
		angle = M_PI + angle;
	else if (x > 0 and y < 0) // #right and up
		angle = 2*M_PI - angle;
	else if (x == 0 and y > 0) // #vertical axis
		angle = M_PI/2;
	else if (x == 0 and y < 0)
		angle = 3*M_PI/2;
	else if (y == 0 and x < 0) //#horizontal axis
		angle = M_PI;
	else if (y == 0 and x > 0)
		angle = 0;

	return float(angle);
}

// Attach a filename to the end of a path
void mergeFilename(const char* path, const char* filename, char* fullFilename)
{
	strcpy(fullFilename, path);
	
	strcat(fullFilename, filename);
}

///////////////////////////////////////////////////////////////////
// XML Methods
///////////////////////////////////////////////////////////////////

xmlDocPtr loadXMLDocument(const char* filename)
{
	xmlDocPtr doc;
	
	LIBXML_TEST_VERSION
	xmlKeepBlanksDefault(0);

	// build an XML tree from a the file;
	doc = xmlParseFile(filename);
	if (doc == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "loadXMLDocument failed loading file %s", filename);
		return NULL;
	}

	return doc;
}

// Check the root node is the same as the rootName expected
bool checkRootNode(xmlDocPtr doc, const char* rootName)
{
	xmlNodePtr root;
	
	// Check the document is of the right kind
	root = xmlDocGetRootElement(doc);
	if (root == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "checkRootNode failed [Empty Document]");
		return false;
	}
	// Check that the root node is game otherwise not our xml
	if (strcmp((const char*)root->name, rootName))
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "checkRootNode failed [root node not %s]", rootName);
		return false;
	}

	return true;
}

// Search the current node using an xpath
xmlXPathObjectPtr searchDocXpath(xmlDocPtr doc, xmlNodePtr node, char* xPath)
{
	xmlXPathContextPtr xpathCtx; 
	xmlXPathObjectPtr xpathObj;
	
	// Create xpath evaluation context
	xpathCtx = xmlXPathNewContext(doc);
	if(xpathCtx == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR,"XPath: unable to create new XPath context\n");
		return NULL;
	}

	xpathCtx->node = node;
	xpathCtx->here = node;

	// Evaluate xpath expression
	xpathObj = xmlXPathEvalExpression((const xmlChar*)xPath, xpathCtx);
	if(xpathObj == NULL)
	{
		xmlXPathFreeContext(xpathCtx); 
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR,"XPath: unable to evaluate xpath expression \"%s\"\n", xPath);
		return NULL;
	}

	xmlXPathFreeContext(xpathCtx); 
	
	return xpathObj;
}

///////////////////////////////////////////////////////////////////
// Map strings to enums
///////////////////////////////////////////////////////////////////

Colour mapColour(const char* col)
{
	if (!strcmp(col,"red"))
		return COL_RED;
	else if (!strcmp(col,"yellow"))
		return COL_YELLOW;
	else if (!strcmp(col,"blue"))
		return COL_BLUE;
	else if (!strcmp(col,"green"))
		return COL_GREEN;
	else if (!strcmp(col,"orange"))
		return COL_ORANGE;
	
	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "MapColour: colour %s not found defaulting to red", col);
	return COL_RED;	
}

GfxRes mapGfxResourceID(const char* res)
{
	if (!strcmp(res,"GFX_BUBBLE_RED"))
		return GFX_BUBBLE_RED;
	else if (!strcmp(res,"GFX_BUBBLE_ORANGE"))
		return GFX_BUBBLE_ORANGE;
	else if (!strcmp(res,"GFX_BUBBLE_GREEN"))
		return GFX_BUBBLE_GREEN;
	else if (!strcmp(res,"GFX_BUBBLE_BLUE"))
		return GFX_BUBBLE_BLUE;
	else if (!strcmp(res,"GFX_BUBBLE_YELLOW"))
		return GFX_BUBBLE_YELLOW;
	else if (!strcmp(res,"GFX_BUBBLE_BOMB"))
		return GFX_BUBBLE_BOMB;
	else if (!strcmp(res,"GFX_BUBBLE_COLOURBOMB"))
		return GFX_BUBBLE_COLOURBOMB;
	else if (!strcmp(res,"GFX_BUBBLE_SPEED"))
		return GFX_BUBBLE_SPEED;
	else if (!strcmp(res,"GFX_CANNON"))
		return GFX_CANNON;
	else if (!strcmp(res,"GFX_BACKGROUND"))
		return GFX_BACKGROUND;
	else if (!strcmp(res,"GFX_HUD"))
		return GFX_HUD;
	
	Log::Instance()->die(1, SV_ERROR, "MapGfxResourceID: gfx resource %s not found dying", res);
	
	// Keep the compiler quiet
	return (GfxRes)NULL;
}

FontRes mapFontResourceID(const char* res)
{
	if (!strcmp(res,"FONT_DEFAULT_LARGE"))
		return FONT_DEFAULT_LARGE;
	else if (!strcmp(res,"FONT_DEFAULT"))
		return FONT_DEFAULT;
	else if (!strcmp(res,"FONT_DEFAULT_SMALL"))
		return FONT_DEFAULT_SMALL;
	else if (!strcmp(res,"FONT_SCORE"))
		return FONT_SCORE;
	else if (!strcmp(res,"FONT_MENU"))
		return FONT_MENU;
	else if (!strcmp(res,"FONT_BUTTON"))
		return FONT_BUTTON;
	else if (!strcmp(res,"FONT_DIALOG"))
		return FONT_DIALOG;
	
	Log::Instance()->die(1, SV_ERROR, "mapFontResourceID: font resource %s not found dying", res);
	
	// Keep the compiler quiet
	return (FontRes)NULL;
}

SndRes mapSndResourceID(const char* res)
{

	if (!strcmp(res,"SND_FIREBULLET"))
		return SND_FIREBULLET;
	else if (!strcmp(res,"SND_CANNONMOVE"))
		return SND_CANNONMOVE;
	else if (!strcmp(res,"SND_CANNONRELOAD"))
		return SND_CANNONRELOAD;
	else if (!strcmp(res,"SND_REMOVEDGROUP"))
		return SND_REMOVEDGROUP;
	else if (!strcmp(res,"SND_GAMEOVER"))
		return SND_GAMEOVER;
	else if (!strcmp(res,"SND_GAMEWON"))
		return SND_GAMEWON;
	else if (!strcmp(res,"SND_BOMB"))
		return SND_BOMB;
	else if (!strcmp(res,"SND_COLOURBOMB"))
		return SND_COLOURBOMB;
	else if (!strcmp(res,"SND_CLICK"))
		return SND_CLICK;		
						
	Log::Instance()->die(1, SV_ERROR, "mapSndResourceID: Sound resource %s not found dying", res);
	
	// Keep the compiler quiet
	return (SndRes)NULL;
}

SFX mapSfxResourceID(const char* res)
{
	if (!strcmp(res,"SFX_RAINBOW"))
		return SFX_RAINBOW;
	else if (!strcmp(res,"SFX_SPEED"))
		return SFX_SPEED;
	else if (!strcmp(res,"SFX_BOMB"))
		return SFX_BOMB;		
	else if (!strcmp(res,"SFX_COLOUR_BOMB"))
		return SFX_COLOUR_BOMB;
	else
		return SFX_NORMAL;
}

// Map keys to strings
const char* getKeyText(int key)
{
	switch (key)
	{
		case  0:
			return "FIRST";
			break;
		case  8:
			return "BACKSPACE";
			break;
		case  9:
			return "TAB";
			break;
		case  12:
			return "CLEAR";
			break;
		case  13:
			return "RETURN";
			break;
		case  19:
			return "PAUSE";
			break;
		case  27:
			return "ESCAPE";
			break;
		case  32:
			return "SPACE";
			break;
		case  33:
			return "EXCLAIM";
			break;
		case  34:
			return "DBL QUOTE";
			break;
		case  35:
			return "HASH";
			break;
		case  36:
			return "DOLLAR";
			break;
		case  38:
			return "AMPERSAND";
			break;
		case  39:
			return "QUOTE";
			break;
		case  40:
			return "LEFT PAREN";
			break;
		case  41:
			return "RIGH TPAREN";
			break;
		case  42:
			return "ASTERISK";
			break;
		case  43:
			return "PLUS";
			break;
		case  44:
			return "COMMA";
			break;
		case  45:
			return "MINUS";
			break;
		case  46:
			return "PERIOD";
			break;
		case  47:
			return "SLASH";
			break;
		case  48:
			return "0";
			break;
		case  49:
			return "1";
			break;
		case  50:
			return "2";
			break;
		case  51:
			return "3";
			break;
		case  52:
			return "4";
			break;
		case  53:
			return "5";
			break;
		case  54:
			return "6";
			break;
		case  55:
			return "7";
			break;
		case  56:
			return "8";
			break;
		case  57:
			return "9";
			break;
		case  58:
			return "COLON";
			break;
		case  59:
			return "SEMICOLON";
			break;
		case  60:
			return "LESS";
			break;
		case  61:
			return "EQUALS";
			break;
		case  62:
			return "GREATER";
			break;
		case  63:
			return "QUESTION";
			break;
		case  64:
			return "AT";
			break;
		case  91:
			return "LEFT BRACKET";
			break;
		case  92:
			return "BACKSLASH";
			break;
		case  93:
			return "RIGHT BRACKET";
			break;
		case  94:
			return "CARET";
			break;
		case  95:
			return "UNDERSCORE";
			break;
		case  96:
			return "BACKQUOTE";
			break;
		case  97:
			return "a";
			break;
		case  98:
			return "b";
			break;
		case  99:
			return "c";
			break;
		case  100:
			return "d";
			break;
		case  101:
			return "e";
			break;
		case  102:
			return "f";
			break;
		case  103:
			return "g";
			break;
		case  104:
			return "h";
			break;
		case  105:
			return "i";
			break;
		case  106:
			return "j";
			break;
		case  107:
			return "k";
			break;
		case  108:
			return "l";
			break;
		case  109:
			return "m";
			break;
		case  110:
			return "n";
			break;
		case  111:
			return "o";
			break;
		case  112:
			return "p";
			break;
		case  113:
			return "q";
			break;
		case  114:
			return "r";
			break;
		case  115:
			return "s";
			break;
		case  116:
			return "t";
			break;
		case  117:
			return "u";
			break;
		case  118:
			return "v";
			break;
		case  119:
			return "w";
			break;
		case  120:
			return "x";
			break;
		case  121:
			return "y";
			break;
		case  122:
			return "z";
			break;
		case  127:
			return "DELETE";
			break;
		
		/* Numeric keypad */
		case  256:
			return "KEYPAD 0";
			break;
		case  257:
			return "KEYPAD 1";
			break;
		case  258:
			return "KEYPAD 2";
			break;
		case  259:
			return "KEYPAD 3";
			break;
		case  260:
			return "KEYPAD 4";
			break;
		case  261:
			return "KEYPAD 5";
			break;
		case  262:
			return "KEYPAD 6";
			break;
		case  263:
			return "KEYPAD 7";
			break;
		case  264:
			return "KEYPAD 8";
			break;
		case  265:
			return "KEYPAD 9";
			break;
		case  266:
			return "KEYPAD PERIOD";
			break;
		case  267:
			return "KEYPAD DIVIDE";
			break;
		case  268:
			return "KEYPAD MULTIPLY";
			break;
		case  269:
			return "KEYPAD MINUS";
			break;
		case  270:
			return "KEYPAD PLUS";
			break;
		case  271:
			return "KEYPAD ENTER";
			break;
		case  272:
			return "KEYPAD EQUALS";
			break;
		
		/* Arrows + Home/End pad */
		case  273:
			return "UP Arrow";
			break;
		case  274:
			return "DOWN Arrow";
			break;
		case  275:
			return "RIGHT Arrow";
			break;
		case  276:
			return "LEFT Arrow";
			break;
		case  277:
			return "INSERT";
			break;
		case  278:
			return "HOME";
			break;
		case  279:
			return "END";
			break;
		case  280:
			return "PAGE UP";
			break;
		case  281:
			return "PAGE DOWN";
			break;
		
		/* Function keys */
		case  282:
			return "F1";
			break;
		case  283:
			return "F2";
			break;
		case  284:
			return "F3";
			break;
		case  285:
			return "F4";
			break;
		case  286:
			return "F5";
			break;
		case  287:
			return "F6";
			break;
		case  288:
			return "F7";
			break;
		case  289:
			return "F8";
			break;
		case  290:
			return "F9";
			break;
		case  291:
			return "F10";
			break;
		case  292:
			return "F11";
			break;
		case  293:
			return "F12";
			break;
		case  294:
			return "F13";
			break;
		case  295:
			return "F14";
			break;
		case 296:
			return "F15";
			break;
		default:
			return "";
			break;	
	}	
}

bool fileExist(const char* filename)
{
	std::ifstream the_file (filename);
	// Always check to see if file opening succeeded
	if (the_file.is_open())
	{
		the_file.close();
		return true;
	}
	return false;
}


int compareChars (const void * a, const void * b)
{
	// Return - result so they appear in aplhabetical order
	return stricmp(*(char**)a,*(char**)b);
}


