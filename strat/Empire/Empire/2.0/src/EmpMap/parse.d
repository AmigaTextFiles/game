#drinc:libraries/dos.g
#drinc:util.g
#EmpMap.g

uint BUFFER_SIZE = 1000;

uint OWNER_ME = OWNER_UNKNOWN + 1;

Handle_t Fd;
[BUFFER_SIZE] char FileBuffer;
uint BufferLength, BufferPos;
bool HadEof;

/***************** routines for reading from an input file **************/

/*
 * get a buffered character from the current input file.
 *	Return '\e' on end-of-file.
 */

proc getChar()char:

    if HadEof then
	'\e'
    elif BufferPos = BufferLength then
	BufferLength := Read(Fd, pretend(&FileBuffer[0], *byte), BUFFER_SIZE);
	if BufferLength = 0 then
	    HadEof := true;
	    '\e'
	else
	    BufferPos := 1;
	    FileBuffer[0]
	fi
    else
	BufferPos := BufferPos + 1;
	FileBuffer[BufferPos - 1]
    fi
corp;

/*
 * readLine - read a line into the passed buffer. Return the line length.
 *	NOTE: any leading blanks are not included in the length.
 */

proc readLine(register *char buffer)uint:
    register uint length;
    register char ch;

    while
	ch := getChar();
	ch = ' '
    do
    od;
    length := 0;
    while ch ~= '\n' and ch ~= '\e' do
	buffer* := ch;
	buffer := buffer + sizeof(char);
	length := length + 1;
	ch := getChar();
    od;
    buffer* := '\e';
    length
corp;

/********************* routines for writing to an output text file **********/

/*
 * flush - flush the output buffer.
 */

proc flush()void:

    ignore Write(Fd, &FileBuffer[0], BufferPos);
    BufferPos := 0;
corp;

/*
 * putChar - output a single character.
 */

proc putChar(char ch)void:

    if BufferPos = BUFFER_SIZE then
	flush();
    fi;
    FileBuffer[BufferPos] := ch;
    BufferPos := BufferPos + 1;
corp;

/* routines to print coordinate digits. */

proc pDigit1(register int n)void:

    putChar(
	if n <= -100 then
	    -n / 100 + '0'
	elif n <= -10 then
	    '-'
	elif n >= 100 then
	    n / 100 + '0'
	elif n >= 10 then
	    '+'
	else
	    ' '
	fi
    );
corp;

proc pDigit2(register int n)void:

    putChar(
	if n <= -100 then
	    -n / 10 % 10 + '0'
	elif n <= -10 then
	    -n / 10 + '0'
	elif n < 0 then
	    '-'
	elif n >= 100 then
	    n / 10 % 10 + '0'
	elif n >= 10 then
	    n / 10 + '0'
	elif n ~= 0 then
	    '+'
	else
	    ' '
	fi
    );
corp;

proc pDigit3(int n)void:

    putChar(|n % 10 + '0');
corp;

proc pCols(int c1, c2; bool compressed)void:
    register int c;

    putChar(' ');
    putChar(' ');
    putChar(' ');
    for c from c1 upto c2 do
	if not compressed then
	    putChar(' ');
	fi;
	pDigit1(c);
    od;
    putChar('\n');
    putChar(' ');
    putChar(' ');
    putChar(' ');
    for c from c1 upto c2 do
	if not compressed then
	    putChar(' ');
	fi;
	pDigit2(c);
    od;
    putChar('\n');
    putChar(' ');
    putChar(' ');
    putChar(' ');
    for c from c1 upto c2 do
	if not compressed then
	    putChar(' ');
	fi;
	pDigit3(c);
    od;
    putChar('\n');
corp;

proc pRow(register int r)void:

    pDigit1(r);
    pDigit2(r);
    pDigit3(r);
corp;

/********************* routines to aid in parsing of map/radar **************/

/*
 * int2 - turn 2 characters into an integer.
 */

proc int2(char ch1, ch2)int:

    if ch1 = '-' then
	- (ch2 - '0')
    else
	(ch1 - '0') * 10 + (ch2 - '0')
    fi
corp;

/*
 * int3 - turn 3 characters into an integer.
 */

proc int3(char ch1, ch2, ch3)int:

    if ch1 = '-' then
	- ((ch2 - '0') * 10 + (ch3 - '0'))
    else
	(ch1 - '0') * 100 + (ch2 - '0') * 10 + (ch3 - '0')
    fi
corp;

/*
 * mapRow - handle the data from a given map line.
 */

proc mapRow(register *char p; int r; register int c;
	    uint owner, length; bool isMap)void:
    register *Sector_t s;

    if p* ~= '\e' and p* ~= '\n' then
	while p* ~= ' ' and p* ~= '\e' and p* ~= '\n' do
	    p := p + sizeof(char);
	od;
	if p* = ' ' then
	    p := p + sizeof(char);
	    while p* ~= '\e' and p* ~= '\n' and length ~= 0 do
		s := getSector(r, c);
		if p* ~= ' ' then
		    /* i.e. the map shows something for the sector */
		    if p* >= 'A' and p* <= 'Z' then
			/* there is a ship there */
			if s*.s_designation = '?' then
			    s*.s_designation := 'h';
			fi;
		    elif p* ~= '?' or s*.s_designation = ' ' then
			/* either the map shows something, or we know nothing
			   about it yet */
			s*.s_designation := p*;
			if p* = '.' then
			    /* only god can own water (normally) */
			    s*.s_owner := OWNER_DEITY;
			elif isMap and p* ~= '^' and p* ~= '-' and
			    p* ~= 's' and p* ~= '?' or owner ~= OWNER_ME
			then
			    /* owner ~= OWNER_ME is a god-map, in which only
			       those sectors owned by the given person are
			       shown; otherwise, if its not a special one
			       (^,-,s,?), the current player must own it */
			    s*.s_owner :=
				if owner = OWNER_ME then 0 else owner fi;
			fi;
		    fi;
		    refreshSector(r, c);
		elif owner = OWNER_DEITY then
		    s*.s_designation := '.';
		    s*.s_owner := OWNER_DEITY;
		    refreshSector(r, c);
		fi;
		p := p + sizeof(char);
		length := length - 1;
		if p* = ' ' and length ~= 0 then
		    p := p + sizeof(char);
		    length := length - 1;
		fi;
		c := c + 1;
	    od;
	fi;
    fi;
corp;

/*
 * parseMap - open and parse a map or radar file.
 */

proc parseMap(*char fileName, name; bool isMap)void:
    int minCol, maxCol, row2;
    register int row1;
    [500] char line1, line2, line3;
    register uint owner, length, i;
    char ch1, ch2;
    bool wide, hadError, hadMinus;

    hadError := false;
    if name ~= nil then
	if CharsEqual(name, "god") then
	    owner := OWNER_DEITY;
	else
	    owner := 0;
	    while owner ~= COUNTRY_MAX and
		not CharsEqual(&getCountry(owner)*.c_name[0], name)
	    do
		owner := owner + 1;
	    od;
	    if owner = COUNTRY_MAX then
		emError("unknown country");
		hadError := true;
	    fi;
	fi;
    else
	owner := OWNER_ME;
    fi;
    if not hadError then
	Fd := Open(fileName, MODE_OLDFILE);
	if Fd = 0 then
	    emError("can't open map/radar file");
	else
	    BufferPos := 0;
	    BufferLength := 0;
	    HadEof := false;
	    while
		while
		    length := readLine(&line1[0]);
		    not HadEof and
			(length <= 1 or line1[0] ~= '-' and
			    (line1[0] < '0' or line1[0] > '9'))
		do
		od;
		not HadEof
	    do
		if length > 0 and line1[length - 1] = '\n' then
		    length := length - 1;
		fi;
		pretend(readLine(&line2[0]), void);
		pretend(readLine(&line3[0]), void);
		ch1 := line1[length - 1];
		ch2 := line2[length - 1];
		if line3[0] = '\e' or line3[0] = '\n' then
		    /* line all blanks, therefore only have 2-digit columns */
		    wide := false;
		    minCol := int2(line1[0], line2[0]);
		    maxCol := int2(ch1, ch2);
		else
		    wide := true;
		    minCol := int3(line1[0], line2[0], line3[0]);
		    maxCol := int3(ch1, ch2, line3[length - 1]);
		    pretend(readLine(&line3[0]), void);
		fi;
		hadMinus := false;
		for i from 0 upto length - 1 do
		    if line1[i] = '-' then
			hadMinus := true;
		    fi;
		od;
		if hadMinus then
		    if minCol > 0 then
			minCol := - minCol;
		    fi;
		    if maxCol > 0 and maxCol < minCol then
			maxCol := - maxCol;
		    fi;
		else
		    if minCol > maxCol then
			minCol := - minCol;
			maxCol := - maxCol;
		    fi;
		fi;
		pretend(readLine(&line1[0]), void);
		pretend(readLine(&line2[0]), void);
		if line1[2] = ' ' then
		    /* two digit row numbers */
		    row1 := int2(line1[0], line1[1]);
		    row2 := int2(line2[0], line2[1]);
		else
		    /* three digit row numbers */
		    row1 := int3(line1[0], line1[1], line1[2]);
		    row2 := int3(line2[0], line2[1], line2[2]);
		fi;
		if row1 > row2 then
		    row1 := - row1;
		fi;
		mapRow(&line1[0], row1, minCol, owner, length, isMap);
		row1 := row1 + 1;
		mapRow(&line2[0], row1, minCol, owner, length, isMap);
		while
		    pretend(readLine(&line1[0]), void);
		    line1[0] ~= '\e' and line1[0] ~= '\n' and not HadEof
		do
		    row1 := row1 + 1;
		    mapRow(&line1[0], row1, minCol, owner, length, isMap);
		od;
		pretend(readLine(&line1[0]), void);
		pretend(readLine(&line1[0]), void);
		if wide then
		    pretend(readLine(&line1[0]), void);
		fi;
	    od;
	    Close(Fd);
	fi;
    fi;
corp;

/*
 * mapDesig - map a sector-type name into the designation letter.
 */

proc mapDesig(*char name)char:
    type map_t = struct {
	[21] char m_name;
	char m_desig;
    };
    uint DESIG_COUNT = 23;
    [DESIG_COUNT] map_t MAP = (
	("sea\e"		, '.'),
	("mountain\e"		, '^'),
	("wilderness\e" 	, '-'),
	("sanctuary\e"		, 's'),
	("capital\e"		, 'c'),
	("urban area\e" 	, 'u'),
	("defense plant\e"	, 'd'),
	("shell industry\e"	, 'i'),
	("mine\e"		, 'm'),
	("gold mine\e"		, 'g'),
	("harbor\e"		, 'h'),
	("warehouse\e"		, 'w'),
	("technical center\e"	, 't'),
	("fortress\e"		, 'f'),
	("airport\e"		, '*'),
	("research laboratory\e", 'r'),
	("highway\e"		, '+'),
	("radar station\e"	, ')'),
	("weather station\e"	, '!'),
	("bridge head\e"	, '\#'),
	("bridge span\e"	, '='),
	("bank\e"		, 'b'),
	("exchange\e"		, 'x')
    );
    register *map_t m;
    register uint i;

    m := &MAP[0];
    i := 0;
    while i ~= DESIG_COUNT and not CharsEqual(&m*.m_name[0], name) do
	i := i + 1;
	m := m + sizeof(map_t);
    od;
    if i = DESIG_COUNT then
	' '
    else
	m*.m_desig
    fi
corp;

/*
 * parseLookout - parse a lookout file to set sector ownership.
 */

proc parseLookout(*char fileName)void:
    [500] char line;
    *Sector_t s;
    register *char p;
    register uint owner;
    register int row, col;
    register long index;
    bool isNeg;
    char designation;

    Fd := Open(fileName, MODE_OLDFILE);
    if Fd = 0 then
	emError("can't open map/radar file");
    else
	BufferPos := 0;
	BufferLength := 0;
	HadEof := false;
	while
	    while
		pretend(readLine(&line[0]), void);
		line[0] = '\n' and not HadEof
	    do
	    od;
	    not HadEof
	do
	    index := CharsIndex(&line[0], "sector");
	    if index > 0 then
		line[index - 1] := '\e';
		owner := 0;
		while owner ~= COUNTRY_MAX and
		    not CharsEqual(&getCountry(owner)*.c_name[0], &line[0])
		do
		    owner := owner + 1;
		od;
		if owner = COUNTRY_MAX then
		    owner := OWNER_UNKNOWN;
		fi;
		line[index - 1] := ' ';
		p := &line[index + 7];
		row := 0;
		isNeg := false;
		if p* = '-' then
		    p := p + 1;
		    isNeg := true;
		fi;
		while p* >= '0' and p* <= '9' do
		    row := row * 10 + (p* - '0');
		    p := p + 1;
		od;
		if isNeg then
		    row := -row;
		fi;
		if p* = ',' then
		    p := p + 1;
		    col := 0;
		    isNeg := false;
		    if p* = '-' then
			p := p + 1;
			isNeg := true;
		    fi;
		    while p* >= '0' and p* <= '9' do
			col := col * 10 + (p* - '0');
			p := p + 1;
		    od;
		    if isNeg then
			col := -col;
		    fi;
		    index := CharsIndex(&line[0], "% efficient ");
		    if index > 0 then
			p := &line[index + 12];
			index := CharsIndex(&line[0], ".");
			if index > 0 then
			    line[index] := '\e';
			    designation := mapDesig(p);
			    s := getSector(row, col);
			    s*.s_owner := owner;
			    if designation ~= ' ' then
				s*.s_designation := designation;
			    fi;
			    refreshSector(row, col);
			fi;
		    fi;
		fi;
	    fi;
	od;
	Close(Fd);
    fi;
corp;

/*
 * printMapFile - print the selected region of the map to the given file.
 */

proc printMapFile(*char name; int r1, r2, c1, c2; bool compressed)void:
    register int r, c;

    Fd := Open(name, MODE_NEWFILE);
    if Fd = 0 then
	emError("can't open output file");
    else
	pCols(c1, c2, compressed);
	putChar('\n');
	for r from r1 upto r2 do
	    pRow(r);
	    for c from c1 upto c2 do
		if not compressed then
		    putChar(' ');
		fi;
		putChar(getSector(r, c)*.s_designation);
	    od;
	    putChar(' ');
	    pRow(r);
	    putChar('\n');
	od;
	putChar('\n');
	pCols(c1, c2, compressed);
	flush();
	Close(Fd);
    fi;
corp;
