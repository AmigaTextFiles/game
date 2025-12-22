#include "NCString.h"

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

/**
 * ctor
 */
//====================================================================
NCString::NCString()
	:
	dsize(0),
	ddata(NULL)
{
}

/**
 * ctor
 */
//====================================================================
NCString::NCString(int size)
	:
	dsize(0),
	ddata(NULL)
{
	if(size > 0)
		resize(size);
}

/**
 * ctor
 */
//====================================================================
NCString::NCString(const char *data)
	:
	dsize(0),
	ddata(NULL)
{
	set(data); 
}

/**
 * ctor
 */
//====================================================================
NCString::NCString(const char *data, uint maxlen)
	:
	dsize(0),
	ddata(NULL)
{
	set(data); 
	truncate(maxlen);
}

/**
 * copy ctor
 */
//====================================================================
NCString::NCString(const NCString &toCopy)
	:
	dsize(0),
	ddata(NULL)
{
	if(resize(toCopy.dsize))
		memcpy(ddata, toCopy.ddata, toCopy.dsize);
}

/**
 * dtor
 */
//====================================================================
NCString::~NCString()
{
	deleteData();
}

/** set to NULL string */
//----------------------------------------------------------
void NCString::deleteData()
{
	delete [] ddata;
	ddata = NULL;
	dsize = 0;
}

static char nullChar = '\0';

/**  Allows direct read-only access to the string array. */
NCString::operator const char *() const	
{	
	return ddata; 
}
/** deep copy */
NCString&	NCString::operator  = (const NCString &in)	
{	
	set((const char*)in); 
	return *this;	
}
/** deep copy */
NCString&	NCString::operator  = (const char *in)		
{	
	set((const char*)in); 
	return *this;	
}

/** 
 * Returns a reference to the element at position index in the array. 
 * This can be used to both read and set an element. 
 * @see at()
 */
//----------------------------------------------------------
char& NCString::operator [] (int i) const
{
	if(i < 0)
		i = 0;
	if(i < (int)length())
		return *(ddata+i);
	else
	{
		fprintf(stderr, "NCString::operator[]: Absolute index %d out of range\n", i);
		nullChar = '\0';
		if(ddata)
			return *ddata;		// consistent w/ qt
		else
			return nullChar;	// qt segfaults in this instance, but we don't...
	}
}

/** 
 * Returns a reference to the element at position index in the array. 
 * This can be used to both read and set an element. 
 * @see operator[]()
 */
//----------------------------------------------------------
char& NCString::at (uint i) const 
{
	if(i <= length()) 
		return *(ddata+i);
	else
	{
		fprintf(stderr, "NCString::at: Absolute index %d out of range\n", i);
		nullChar = '\0';
		if(ddata)
			return *ddata;		// consistent w/ qt
		else
			return nullChar;	// qt segfaults in this instance, but we don't...
	}
}

/** @see QCString::isNull() */
bool NCString::isNull() const	
{	return !((bool)ddata);	}

/** @see QCString::isEmpty() */
//----------------------------------------------------------
bool NCString::isEmpty() const 
{ 
	if(ddata)
		if(ddata[0] == '\0')
			return true;
	return false;
}

/** @see QCString::resize() */
//----------------------------------------------------------
bool NCString::resize(uint len)
{
	if(len == 0)
	{
		deleteData();
		return true;
	}
	char	*oldData = ddata;
	ddata = new char[len];
	if(ddata)
	{
		dsize = len;
		if(oldData)
		{
			strncpy(ddata, oldData, (size_t)dsize);
			ddata[dsize-1] = '\0';	// ensure NULL termination
			delete [] oldData;
		}
		else
			ddata[0] = '\0';
		return true;
	}
	else
	{
		fprintf(stderr, "SEVERE ERROR: NCString::resize() failed to allocate memory! (%s, line %d)\n", __FILE__, __LINE__);
		ddata = oldData;
		return false;
	}
}

/** Returns the length of the string. */
uint NCString::length() const 
{ if(ddata) return (uint)strlen(ddata); else return 0;	}

/** @see QCString::truncate() */
bool NCString::truncate(uint len)	
{	return resize(len+1);	}

/** @see QCString::fill() */
//----------------------------------------------------------
bool NCString::fill(char c, int len)
{
	if(len < 0)
		len = length();
	if( minsize((uint)(len)) == false )
		return false;
	for(int i = 0; i < len; i++)
		ddata[i] = c;
	if(ddata)
		ddata[len] = '\0';
	return true;
}

/**
 * Sets the contents of the string to be the same as the passed-in data.
 */
//----------------------------------------------------------
void NCString::set(const char *dataIn)
{
	if(dataIn)
	{
		uint sz = (uint)strlen(dataIn)+1;
		minsize(sz);
		strcpy(ddata, dataIn);
	}
	else 
	{
		deleteData();
	}
}

/** append a string */
//----------------------------------------------------------
NCString&	NCString::operator += (const NCString &in)
{
	return (*this += (const char*)in);
}
/** append a string */
NCString&	NCString::operator += (const char *in)
{
	uint isz = strlen(in)+1;
	uint nsz = length()+1+isz;
	minsize(nsz);
	char *tail = ddata+length();
	strcpy(tail, in);
	return *this;
}
/** append a single character */
//----------------------------------------------------------
NCString&	NCString::operator += (char in)
{
	uint l = length();
	uint nsz = l+2;
	minsize(nsz);
	ddata[l] = in;
	ddata[l+1] = '\0';
	return *this;
}

/**
 * Create a formatted string, same behavior as sprintf(). Unlike 
 * QCString::sprintf(), there is no size limitation. 
 */
//----------------------------------------------------------
NCString& NCString::sprintf(const char *format, ...)
{
	const int startBuffSize = 512;
	int	buffSize	= startBuffSize;
	char	quickBuffer[startBuffSize];
	char	*slowBuffer	= 0;
	char	*buffer		= quickBuffer;
	int		w;
	va_list args;
	
	bool	success = false;
	while(!success)
	{
		va_start(args, format);
		w = vsnprintf(buffer, buffSize, format, args);
		va_end(args);
		
		if(w < 0 || w > buffSize) // not enough room in buffer
		{
			buffSize *= 2;
			delete [] slowBuffer;
			slowBuffer = new char[buffSize];
			buffer = slowBuffer;
		}
		else
		{
			success = true;
			set(buffer);
		}
	}
	delete [] slowBuffer;
	return *this;
}

/**
 * @param c character to find
 * @param index index into string to start search
 * @param cs case sensitive
 */
//----------------------------------------------------------
int NCString::find(char c, int index, bool cs) const
{
	if(index >= 0 && index < (int)length())
	{
		char u = c;
		char l = c;
		if(!cs)
		{
			u = (char)toupper(c);
			l = (char)tolower(c);
		}
		char *walk = (char*)(ddata+index);
		while(*walk != '\0')
		{
			if(*walk == u || *walk == l)
				return walk-ddata;
			walk++;
		}
	}
	return -1;
}

/**
 * @param str substring to find
 * @param index index into string to start search
 * @param cs case sensitive
 */
//----------------------------------------------------------
int NCString::find(const char *str, int index, bool cs) const
{
	char *loc = 0;
	if(str && index >= 0 && index < (int)length())
	{
		if(cs)
		{
			loc = strstr(ddata+index, str);
		}
		else
		{
			char	*walk = (char*)(ddata+index);
			char	u = (char)toupper(str[0]);
			char	l = (char)tolower(str[0]);
			size_t	len = strlen(str);
			while(*walk != '\0')
			{
				if(*walk == u || *walk == l)
				{
					if(strncasecmp(walk, str, len) == 0)
					{
						loc = walk;
						break;
					}
				}
				walk++;
				}
		}
		if(loc)
			return loc-ddata;
	}
	return -1;
}

/**
 * @param c character to find
 * @param index index into string to start search
 * @param cs case sensitive
 */
//----------------------------------------------------------
int NCString::findRev(char c, int index, bool cs) const
{
	if(ddata && index < (int)length())
	{
		if(index <= 0)
			index = length();
		char u = c;
		char l = c;
		if(!cs)
		{
			u = (char)toupper(c);
			l = (char)tolower(c);
		}
		char *walk = (char*)(ddata+index);
		
		while(walk >= ddata)
		{
			if(*walk == u || *walk == l)
				return walk-ddata;
			walk--;
		}
	}
	return -1;
}

/**
 * @param str substring to find
 * @param index index into string to start search
 * @param cs case sensitive
 */
//----------------------------------------------------------
int NCString::findRev(const char *str, int index, bool cs) const
{
	char *loc = 0;
	if(str && ddata && index < (int)length())
	{
		if(index < 0)
			index = length();
		char	*walk = (char*)(ddata+index);
		size_t	len = strlen(str);
		
		int (*stringcompare)(const char*, const char *, size_t);
		if(cs)
			stringcompare = strncmp;
		else
			stringcompare = strncasecmp;
		
		while(walk >= ddata)
		{
			if(*walk == str[0])
			{
				if((*stringcompare)(walk, str, len) == 0)
				{
					loc = walk;
					break;
				}
			}
			walk--;
		}
		if(loc)
			return loc-ddata;
	}
	return -1;
}

/**
 * @param c character to match
 * @param cs case sensitive
 * @see QCString::contains()
 */
//----------------------------------------------------------
int NCString::contains(char c, bool cs) const
{
	int count = 0;
	if(ddata)
	{
		char u = c;
		char l = c;
		if(!cs)
		{
			u = (char)toupper(c);
			l = (char)tolower(c);
		}
		char	*walk = (char*)ddata;
		while(*walk != 0)
		{
			if(*walk == u || *walk == l)
				count++;
			walk++;
		}
	}
	return count;
}

/**
 * @param str string to match
 * @param cs case sensitive
 * @see QCString::contains()
 */
//----------------------------------------------------------
int NCString::contains(const char *str, bool cs) const
{
	int count = 0;
	if(ddata)
	{
		int (*stringcompare)(const char*, const char *, size_t);
		if(cs)
			stringcompare = strncmp;
		else
			stringcompare = strncasecmp;
		char	*walk = (char*)ddata;
		size_t	len = strlen(str);
		while(*walk != 0)
		{
			if( !cs || *walk == str[0])
			{
				if((*stringcompare)(walk, str, len) == 0)
					count++;
			}
			walk++;
		}
	}
	return count;
}

/**
 * @see QCString::left()
 */
//----------------------------------------------------------
NCString NCString::left(uint len) const
{
	NCString tmpString;
	if(ddata)
	{
		uint l = length();
		if(len < l)
			l = len;
		tmpString = ddata;
		*(tmpString.ddata+len) = '\0';
	}
	return tmpString;
}

/**
 * @see QCString::right()
 */
//----------------------------------------------------------
NCString NCString::right(uint len) const
{
	NCString tmpString;
	if(ddata)
	{
		uint l = length();
		int i = (int)l - (int)len;
		if(i < 0)
			i = 0;
		else
			l = len;
		tmpString = ddata+i;
	}
	return tmpString;
}

/**
 * @see QCString::mid()
 */
//----------------------------------------------------------
NCString NCString::mid(uint index, uint len) const
{
	NCString tmpString;
	uint l = length();
	if( index >= l )
	{
		tmpString = NULL;
	}
	else
	{
		tmpString = ddata+index;
		tmpString.truncate(len);
	}
	return tmpString;
}

/**
 * @see QCString::leftJustify()
 */
//----------------------------------------------------------
NCString	NCString::leftJustify(uint width, char fill, bool trunc) const
{
	NCString tmpString;
	tmpString.resize(width+1);
	tmpString = ddata;
	if(trunc && tmpString.length() > width)
		tmpString.truncate(width);
	else
	{
		uint w = tmpString.length();
		while( w < width )
		{
			*(tmpString.ddata+w) = fill;
			w++;
		}
		*(tmpString.ddata+w) = '\0';
	}
	return tmpString;
}

/**
 * @see QCString::rightJustify()
 */
//----------------------------------------------------------
NCString	NCString::rightJustify(uint width, char fill, bool trunc) const
{
	NCString tmpString;
	uint l = length();
	if(width < l)
	{
		if(trunc)
			tmpString = left(width);
		else
			tmpString = *this;
	}
	else
	{
		uint f = width-l;
		tmpString.fill(fill, f);
		tmpString += *this;
	}
	return tmpString;
}

/**
 * @see QCString::lower()
 */
//----------------------------------------------------------
NCString	NCString::lower() const
{
	NCString tmpString(*this);
	char *walk = tmpString.ddata;
	if(walk)
	{
		while(*walk)
		{
			*walk = tolower(*walk);
			walk++;
		}
	}
	return tmpString;
}

/**
 * @see QCString::upper()
 */
//----------------------------------------------------------
NCString	NCString::upper() const
{
	NCString tmpString(*this);
	char *walk = tmpString.ddata;
	if(walk)
	{
		while(*walk)
		{
			*walk = toupper(*walk);
			walk++;
		}
	}
	return tmpString;
}

//----------------------------------------------------------
static bool isWhite(char c)
{
	bool retVal = false;
	switch(c)
	{
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 32:
			retVal = true;
			break;
		default:
			break;
	}
	return retVal;
}

/**
 * @see QCString::simplifyWhiteSpace()
 */
//----------------------------------------------------------
NCString	NCString::simplifyWhiteSpace() const
{
	NCString tmpString(*this);
	if(ddata)
	{
		char *iwalk	= (char*)ddata;
		char *owalk	= tmpString.ddata;
		bool one	= false;
		bool begin	= true;
		while(*iwalk)
		{
			//-- strip whitespace at beginning
			if(begin)	
			{
				if(isWhite(*iwalk))
				{	iwalk++; continue; }
				else
					begin = false;
			}
			//-- fill tmpString
			if(isWhite(*iwalk))
			{
				if(!one)
				{
					one = true;
					*owalk = ' ';
					owalk++;
				}
			}
			else
			{
				one = false;
				*owalk = *iwalk;
				owalk++;
			}
			iwalk++;
		}
		if(*(owalk-1) == ' ')
			*(owalk-1) = '\0';
	}
	return tmpString;
}

/**
 * @see QCString::stripWhiteSpace()
 */
//----------------------------------------------------------
NCString	NCString::stripWhiteSpace() const
{
	NCString tmpString(*this);
	if(ddata)
	{
		char *iwalk	= (char*)ddata;
		char *owalk	= tmpString.ddata;
		bool begin	= true;
		while(*iwalk)
		{
			//-- strip whitespace at beginning
			if(begin)	
			{
				if(isWhite(*iwalk))
				{	iwalk++; continue; }
				else
					begin = false;
			}
			//-- fill tmpString
			*owalk = *iwalk;
			owalk++;
			iwalk++;
		}
		*owalk = '\0';
		while( isWhite(*(--owalk)) )
			*owalk = '\0';
	}

	return tmpString;
}

/**
 * @see QCString::insert()
 */
//----------------------------------------------------------
NCString&	NCString::insert(uint index, const char *str)
{
	if(str)
	{
		uint l	= length();
		uint sl	= strlen(str);
		if( minsize(index+sl+1) )
		{
			if(index < l)
			{
				memmove(ddata+index+sl, ddata+index, l-index+1);
				strncpy(ddata+index, str, sl);
			}
			else
			{
				uint start = length();
				while(start < index)
				{
					*(ddata+start) = ' ';
					start++;
				}
				strcpy(ddata+index, str);
			}
		}
	}
	return *this;
}

/**
 * @see QCString::insert()
 */
//----------------------------------------------------------
NCString&	NCString::insert(uint index, char c)
{
	uint l	= length();
	if( minsize(index+2) )
	{
		if(index < l)
		{
			memmove(ddata+index+1, ddata+index, l-index+1);
			*(ddata+index) = c;
		}
		else
		{
			uint start = length();
			while(start < index)
			{
				*(ddata+start) = ' ';
				start++;
			}
			*(ddata+index) = c;
			*(ddata+index+1) = '\0';
		}
	}
	return *this;
}

/**
 * @see QCString::append()
 */
//----------------------------------------------------------
NCString&	NCString::append(const char* str)
{
	return (*this += str);
}

/**
 * @see QCString::prepend()
 */
//----------------------------------------------------------
NCString&	NCString::prepend(const char* str)
{
	char *oldData = ddata;
	ddata = 0;
	dsize = 0;
	set(str);
	*this += oldData;
	delete [] oldData;
	return *this;
}

/**
 * @see QCString::remove()
 */
//----------------------------------------------------------
NCString&	NCString::remove(uint index, uint len)
{
	if(ddata)
	{
		uint l = length();
		if(index < l)
		{
			if( index+len >= l )
				*(ddata+index) = '\0';
  			else
			{
				memmove(ddata+index, ddata+index+len, l-(index+len)+1);
			}
		}
	}
	return *this;
}

/**
 * @see QCString::replace()
 */
//----------------------------------------------------------
NCString&	NCString::replace(uint index, uint len, const char *str)
{
	remove(index, len);
	insert(index, str);
	return *this;
}

/** @see QCString::toShort() */
short NCString::toShort (bool *ok) const  
{   return NCString::toShort (ddata, ok);   } 
/** @see QCString::toUShort() */  
ushort NCString::toUShort(bool *ok) const  
{   return NCString::toUShort(ddata, ok);   }   
/** @see QCString::toInt() */
int NCString::toInt   (bool *ok) const  
{   return NCString::toInt   (ddata, ok);   }   
/** @see QCString::toUInt() */
uint NCString::toUInt  (bool *ok) const  
{   return NCString::toUInt  (ddata, ok);   }   
/** @see QCString::toLong() */
int NCString::toLong  (bool *ok) const  
{   return NCString::toLong  (ddata, ok);   }  
/** @see QCString::toULong() */
uint NCString::toULong (bool *ok) const  
{   return NCString::toULong (ddata, ok);   }   
/** @see QCString::toFloat() */
float NCString::toFloat (bool *ok) const  
{   return NCString::toFloat (ddata, ok);   }   
/** @see QCString::toDouble() */
double NCString::toDouble(bool *ok) const  
{   return NCString::toDouble(ddata, ok);   }   

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toShort()
 */
//----------------------------------------------------------
short NCString::toShort(const char *str, bool *ok)
{
	int n;
	long tmp = 0;
	
	if(str)
	{
		n = sscanf(str, "%ld", &tmp);
		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
		if(tmp > SHRT_MAX || tmp < SHRT_MIN)
			*ok = false;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return (short)tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toUShort()
 * @attention this function does a slow kludge to detect negative number strings
 */
//----------------------------------------------------------
ushort NCString::toUShort(const char *str, bool *ok)
{
	int n;
	uint tmp = 0;
//	foo bar = 0;
//	sscanf("hello", "%d", &bar);
	if(str)
	{
		n = sscanf(str, "%u", &tmp);
		NCString neg = NCString(str).stripWhiteSpace(); // kludge detection of negatives
		if(neg.ddata[0] == '-')
			n = 0;
		if(ok)
			*ok = (bool)n;
		if(tmp > USHRT_MAX)
			*ok = false;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return (ushort)tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toInt()
 */
//----------------------------------------------------------
int NCString::toInt(const char *str, bool *ok)
{
	int n;
	int tmp = 0;
	if(str)
	{
		n = sscanf(str, "%d", &tmp);
		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toUInt()
 * @attention this function does a slow kludge to detect negative number strings
 */
//----------------------------------------------------------
uint NCString::toUInt(const char *str, bool *ok)
{
	int n;
	uint tmp = 0;
	
	if(str)
	{
		n = sscanf(str, "%u", &tmp);
		NCString neg = NCString(str).stripWhiteSpace(); // kludge detection of negatives
		if(neg.ddata[0] == '-')
			n = 0;

		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toLong()
 */
//----------------------------------------------------------
int NCString::toLong(const char *str, bool *ok)
{
	int n;
	long tmp = 0;
	if(str)
	{
		n = sscanf(str, "%ld", &tmp);
		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return (int)tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toULong()
 * @attention this function does a slow kludge to detect negative number strings
 */
//----------------------------------------------------------
uint NCString::toULong(const char *str, bool *ok)
{
	int n;
	ulong tmp = 0;
	if(str)
	{
		n = sscanf(str, "%lu", &tmp);

		NCString neg = NCString(str).stripWhiteSpace(); // kludge detection of negatives
		if(neg.ddata[0] == '-')
			n = 0;

		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return (uint)tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toFloat()
 */
//----------------------------------------------------------
float NCString::toFloat(const char *str, bool *ok)
{
	int n;
	float tmp = 0;
	if(str)
	{
		n = sscanf(str, "%g", &tmp);
		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return tmp;
}

/**
 * QCString does NOT have this static function. It is provided for 
 * convinence so if you have a char* string you want converted to a
 * number, it can be done w/o allocating an NCString
 * @see QCString::toDouble()
 */
//----------------------------------------------------------
double NCString::toDouble(const char *str, bool *ok)
{
	int n;
	double tmp = 0.0;
	if(str)
	{
		n = sscanf(str, "%lg", &tmp);
		if(ok)
			*ok = (bool)n;
		if(!n)
			tmp = 0;
	}
	else
	{
		if(ok)
			*ok = false;
	}
	return tmp;
}

/**
 * set to s
 */
//----------------------------------------------------------
NCString&	NCString::setStr(const char *s)
{
	set(s);
	return *this;
}

static const int MIN_NUM_STR = 32;
/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(short val)
{
	if(minsize(MIN_NUM_STR))
	{
		::sprintf(ddata, "%hd", val);
	}
	return *this;
}

/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(ushort val)
{
	if(minsize(MIN_NUM_STR))
	{
		::sprintf(ddata, "%hu", val);
	}
	return *this;
}

/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(int val)
{
	if(minsize(MIN_NUM_STR))
	{
		::sprintf(ddata, "%d", val);
	}
	return *this;
}

/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(uint val)
{
	if(minsize(MIN_NUM_STR))
	{
		::sprintf(ddata, "%u", val);
	}
	return *this;
}

//// XXX - Temporarily disabled. What's the format specifier for long long?
///**
// * @see QCString::setNum()
// */
////----------------------------------------------------------
//NCString&	NCString::setNum(int64_t val)
//{
//	int truncVal = (int) val;
//	if(minsize(MIN_NUM_STR))
//	{
//		::sprintf(ddata, "%ld", truncVal);
//	}
//	return *this;
//}

//// XXX - Temporarily disabled. What's the format specifier for unsigned long long?
///**
// * @see QCString::setNum()
// */
////----------------------------------------------------------
//NCString&	NCString::setNum(uint64_t val)
//{
//	uint truncVal = (uint) val;
//	if(minsize(MIN_NUM_STR))
//	{
//		::sprintf(ddata, "%lu", truncVal);
//	}
//	return *this;
//}

/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(float val, char f, int prec)
{
	if(minsize(MIN_NUM_STR+prec))
	{
		char format[MIN_NUM_STR];
		::sprintf(format, "%%.%d%c", prec, f);
		if( f == 'g' || f == 'G' || f == 'e' || f == 'E' || f == 'f')
			::sprintf(ddata, format, val);
		else
		{
			fprintf(stderr, "NCString::setNum: Invalid format char \'%c\'\n", f);
			set(format);
		}
	}
	return *this;
}

/**
 * @see QCString::setNum()
 */
//----------------------------------------------------------
NCString&	NCString::setNum(double val, char f, int prec)
{
	if(minsize(MIN_NUM_STR+prec))
	{
		char format[MIN_NUM_STR];
		::sprintf(format, "%%.%d%c", prec, f);
		//-- valid conversions only...
		if( f == 'g' || f == 'G' || f == 'e' || f == 'E' || f == 'f')
			::sprintf(ddata, format, val);
		else
		{
			fprintf(stderr, "NCString::setNum: Invalid format char \'%c\'\n", f);
			set(format);
		}
	}
	return *this;
}

/**
 * @see QCString::setExpand()
 */
//----------------------------------------------------------
bool	NCString::setExpand(uint index, char c)
{
	bool retVal = true;
	if(index >= length())
	{
		retVal = minsize(index+2);
		if(retVal)
		{
			uint start = length();
			while(start < dsize)
			{
				*(ddata+start) = ' ';
				start++;
			}
			ddata[index]   = c;
			ddata[index+1] = '\0';
		}
	}
	else
	{
		ddata[index] = c;
	}
	return retVal;
}

/**
 * NOT IN QCString!
 * Splits a string in two - the left half is removed and returned. Example:
 * <pre>
 * NCString str1("/usr/bin:/usr/local/bin:.");
 * NCString str2 = str1.split(':');
 * fprintf(stdout, "str1 = %%s\nstr2 = %%s\\n", (const char*)str1, (const char*)str2); 
 * ...
 * OUTPUT:
 * str1 = /usr/local/bin:.
 * str2 = /usr/bin
 * </pre>
 * @param sep character which separates fields
 * @returns a token, or NULL if string is empty
 */
//----------------------------------------------------------
NCString	NCString::split(char sep)
{
	NCString retVal;
	
	if(ddata)
	{
		char *chr;
		chr = strchr(ddata, sep);
		if(chr)
		{
			*chr = '\0';
			retVal	= ddata;
			int len = strlen(chr+1);
			memmove(ddata, chr+1, len+1);
		}
		else
		{
			retVal = *this;
			this->resize(0);
		}
	}
	
	return retVal;
}

/**
 * to be used on CSV (Comma Separated Value) strings, which have quoted fields.
 * @see split()
 * @param sep character which separates fields
 * @returns a token, or NULL if string is empty
 */
//----------------------------------------------------------
NCString	NCString::splitCSV(char sep)
{
	NCString retVal;
	
	if(ddata)
	{
		{	//-- get rid of trailing newline, if any
			int l = strlen(ddata);
			if( ddata[l-1] == '\n')
				ddata[l-1] = '\0';
		}
		//-- only attempt if first character is a quote
		if(ddata[0] == '\"')
		{
			int	qi1;
			int	qi2 = 1;
			//-- look for closing quote, followed by separator or NULL
			while( (qi1 = find('\"', qi2)) > 0 )
			{
				char &a = at(qi1+1);
				if( a == '\0' )
					break;
				if( a == sep )
				{
					char &b = at(qi1+2);
					if( b == '\"' || b == '\0' )
						break;
				}
				qi2 = qi1+1;
			}
			if(qi1 > 0) //-- we found closing quote
			{
				char &a = at(qi1+1);
				at(qi1) = '\0';		// replace end quote with NULL
				retVal = ddata+1;	// copy token w/o begin quote
				if( a == '\0' )
					resize(0);
				else
				{
					char *src = ddata+qi1+2;
					int len = strlen(src);
					memmove(ddata, src, len+1);
				}
				//-- remove any "" in string and replace with "
				int dq1 = 0;
				int dq2 = 0;
				while( (dq1 = retVal.find("\"\"", dq2)) >= 0 )
				{
					retVal.replace(dq1, 2, "\"");
					dq2 = dq1+1;
				}
			}
		}
	}
	
	return retVal;
}

//------------------------------------------------------------------------------
//******************************************************************************
//------------------------------------------------------------------------------
static int compare(const char *s1, const char *s2)
{
	int retVal = 0;
	if(!s1 && !s2)
		retVal = 0;
	else if(!s1 && s2)
		retVal = 1;
	else if(s1 && !s2)
		retVal = -1;
	else
		retVal = strcmp(s1, s2);
	return retVal;
}

//-----------------------------------------------------
bool operator == (const NCString &s1, const char *    s2)  {   return (bool)(!compare((const char*)s1, (const char*)s2));  } 
bool operator == (const char *    s1, const NCString &s2)  {   return (bool)(!compare((const char*)s1, (const char*)s2));  }
bool operator == (const NCString &s1, const NCString &s2)  {   return (bool)(!compare((const char*)s1, (const char*)s2));  }
//-----------------------------------------------------
bool operator != (const NCString &s1, const char	 *s2)  {   return (bool)compare((const char*)s1, (const char*)s2); }
bool operator != (const char	 *s1, const NCString &s2)  {   return (bool)compare((const char*)s1, (const char*)s2); }
bool operator != (const NCString &s1, const NCString &s2)  {   return (bool)compare((const char*)s1, (const char*)s2); }
//-----------------------------------------------------
bool operator >  (const NCString &s1, const char	 *s2)  {   return ( compare((const char*) s1, (const char*) s2) >  0 ? true : false);  }
bool operator >  (const char	 *s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) >  0 ? true : false);  }
bool operator >  (const NCString &s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) >  0 ? true : false);  }
//-----------------------------------------------------
bool operator <  (const NCString &s1, const char	 *s2)  {   return ( compare((const char*) s1, (const char*) s2) <  0 ? true : false);  }
bool operator <  (const char	 *s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) <  0 ? true : false);  }
bool operator <  (const NCString &s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) <  0 ? true : false);  }
//-----------------------------------------------------
bool operator >= (const NCString &s1, const char	 *s2)  {   return ( compare((const char*) s1, (const char*) s2) >= 0 ? true : false);  }
bool operator >= (const char	 *s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) >= 0 ? true : false);  }
bool operator >= (const NCString &s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) >= 0 ? true : false);  }
//-----------------------------------------------------
bool operator <= (const NCString &s1, const char	 *s2)  {   return ( compare((const char*) s1, (const char*) s2) <= 0 ? true : false);  }
bool operator <= (const char	 *s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) <= 0 ? true : false);  }
bool operator <= (const NCString &s1, const NCString &s2)  {   return ( compare((const char*) s1, (const char*) s2) <= 0 ? true : false);  }
//-----------------------------------------------------
NCString operator + (const NCString &s1, char c)
{
	NCString tmp;
	tmp  = s1;
	tmp += c;
	return tmp;
}
NCString operator + (char c, const NCString &s1)
{
	NCString tmp;
	tmp.setExpand(0, c);
	tmp += s1;
	return tmp;
}
//-----------------------------------------------------
NCString operator + (const NCString &s1, const NCString &s2)   {   NCString tmp(s1);   tmp += s2;  return tmp; }
NCString operator + (const char 	*s1, const NCString &s2)   {   NCString tmp(s1);   tmp += s2;  return tmp; }
NCString operator + (const NCString &s1, const char 	*s2)   {   NCString tmp(s1);   tmp += s2;  return tmp; }
//-----------------------------------------------------
ostream& operator << (ostream &os, const NCString &s1)
{
	return os << (const char*)s1;
}


