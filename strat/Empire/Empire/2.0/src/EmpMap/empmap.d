#drinc:exec/miscellaneous.g
#drinc:exec/memory.g
#drinc:exec/tasks.g
#drinc:exec/ports.g
#drinc:intuition/miscellaneous.g
#drinc:intuition/screen.g
#drinc:intuition/window.g
#drinc:intuition/intuiText.g
#drinc:intuition/intuiMessage.g
#drinc:intuition/image.g
#drinc:intuition/border.g
#drinc:intuition/menu.g
#drinc:intuition/gadget.g
#drinc:intuition/requester.g
#drinc:graphics/gfx.g
#drinc:graphics/view.g
#drinc:graphics/rastport.g
#drinc:graphics/gfxbase.g
#drinc:graphics/clip.g
#drinc:libraries/dos.g
#drinc:libraries/dosextens.g
#drinc:devices/inputEvent.g
#drinc:workbench/startup.g
#EmpMap.g
#drinc:intuiTools.g

*char DEFAULT_DATA_FILE = "EmpMap.data";

uint
    MAX_SIZE = 128,

    TEXT_WIDTH = 8,
    TEXT_HEIGHT = 8,
    TEXT_BASELINE = 6,
    TITLE_BAR_HEIGHT = 10,

    HORIZ_SCROLL_HEIGHT = 11,
    VERT_SCROLL_WIDTH = 13,
    ARROW_WIDTH = 14,
    ARROW_HEIGHT = 12,

    COLOUR_DEITY = 1,
    COLOUR_UNKNOWN = 2,
    COLOUR_BASE = 3,
    MAP_WIDTH = (WIDTH - TEXT_WIDTH * 3 - VERT_SCROLL_WIDTH) / TEXT_WIDTH,
    MAP_HEIGHT = (HEIGHT - TITLE_BAR_HEIGHT - 1 - TEXT_HEIGHT * 3 -
		  HORIZ_SCROLL_HEIGHT) / TEXT_HEIGHT,

    VIEW_SIZE = MAX_SIZE;

ushort
    COLOUR_BLACK = 0,
    COLOUR_WHITE = 1,

    BACKGROUND_PEN = COLOUR_WHITE,
    FOREGROUND_PEN = COLOUR_BLACK;

[COLOURS] uint DEFAULT_COLOUR_MAP = (
    0x000, /*  0 - black */
    0xfff, /*  1 - white */
    0x777, /*  2 - dark grey */
    0x61f, /*  3 - bright blue */
    0x0f0, /*  4 - green */
    0xd00, /*  5 - brick red */
    0xfd0, /*  6 - cadmium yellow */
    0x91f, /*  7 - purple */
    0xdb9, /*  8 - tan */
    0x999, /*  9 - medium grey */
    0x6fe, /* 10 - sky blue */
    0xbf0, /* 11 - lime green */
    0xf00, /* 12 - red */
    0xff0, /* 13 - lemon yellow */
    0xc1f, /* 14 - violet */
    0xc80, /* 15 - brown */
    0xccc, /* 16 - light grey */
    0x6ce, /* 17 - light blue */
    0x8e0, /* 18 - light green */
    0xf80, /* 19 - red-orange */
    0xfb0, /* 20 - golden orange */
    0xf1f, /* 21 - magenta */
    0xa87, /* 22 - dark brown */
    0x2c0, /* 23 - dark green */
    0x00f, /* 24 - blue */
    0xf90, /* 25 - orange */
    0x0b1, /* 26 - forest green */
    0x0db, /* 27 - aqua */
    0x06d, /* 28 - dark blue */
    0xfac, /* 29 - pink */
    0x0bb, /* 30 - blue-green */
    0x1fb  /* 31 - light aqua */
);

type
    BoxXY_t = [5 * 2] int,
    ArrowXY_t = [5 * 2] int;

*Screen_t Screen;
*Window_t Window, ViewWindow;
*RastPort_t RastPort, ViewRastPort;
*Menu_t MainMenu;

Gadget_t
    HorizScrollGadget,
    VertScrollGadget,
    LeftScrollGadget,
    RightScrollGadget,
    UpScrollGadget,
    DownScrollGadget;
PropInfo_t
    HorizPropInfo,
    VertPropInfo;
Image_t
    HorizKnob,
    VertKnob;
Border_t
    LeftArrow,
    RightArrow,
    UpArrow,
    DownArrow,
    LeftRightBox,
    UpDownBox;
ArrowXY_t
    LeftArrowXY,
    RightArrowXY,
    UpArrowXY,
    DownArrowXY;
BoxXY_t
    LeftRightBoxXY,
    UpDownBoxXY;

Header_t Header;
*[MAX_SIZE * MAX_SIZE]Sector_t Sectors;
uint SectorShift, SectorMask;
int HorizOffset, VertOffset;		/* co-ords of upper left corner */
uint ViewFactor;			/* pixels per sector in view */
bool ViewOpen;

/*
 * emError - externally callable routine to display an error message.
 */

proc emError(*char message)void:

    errorReport(Window, message);
corp;

/*
 * getSize - do a requester for the size of a new map.
 */

proc getSize()bool:
    uint
	SIZE_COUNT = 4,
	REQ_WIDTH = 20 * TEXT_WIDTH + 20,
	REQ_HEIGHT = TEXT_HEIGHT * 5;
    [SIZE_COUNT] Gadget_t sizeGadget;
    [SIZE_COUNT] IntuiText_t sizeText;
    Border_t sizeBorder;
    BoxXY_t sizeBox;
    IntuiText_t reqText;
    Requester_t requester;
    Border_t reqBorder;
    BoxXY_t reqBox;
    register *IntuiMessage_t im;
    ulong oldIDCMP;
    register uint i;

    InitRequester(&requester);
    requester.r_LeftEdge := (WIDTH - REQ_WIDTH) / 2;
    requester.r_TopEdge := (HEIGHT - REQ_HEIGHT) / 2;
    requester.r_Width := REQ_WIDTH;
    requester.r_Height := REQ_HEIGHT;
    requester.r_ReqGadget := &sizeGadget[0];
    requester.r_BackFill := BACKGROUND_PEN;
    requester.r_ReqText := &reqText;
    requester.r_ReqBorder := &reqBorder;
    reqBorder := Border_t(
	0, 0, FOREGROUND_PEN, BACKGROUND_PEN, JAM1, 5, nil, nil
    );
    reqBorder.b_XY := &reqBox[0];
    reqBox := BoxXY_t(
	2, 2,
	REQ_WIDTH - 3, 2,
	REQ_WIDTH - 3, REQ_HEIGHT - 3,
	2, REQ_HEIGHT - 3,
	2, 2
    );
    reqText := IntuiText_t(
	FOREGROUND_PEN, BACKGROUND_PEN, JAM1, 10, 8, nil, nil, nil
    );
    reqText.it_IText := "Select world size:";
    for i from 0 upto SIZE_COUNT - 1 do
	sizeGadget[i] := Gadget_t(
	    nil, 0, 19,
	    TEXT_WIDTH * 3 + 2 * 2, TEXT_HEIGHT + 2 * 2,
	    GADGHCOMP, RELVERIFY | ENDGADGET, BOOLGADGET | REQGADGET,
	    (nil), (nil), nil, 0x0, (nil), 1, nil
	);
	sizeGadget[i].g_GadgetID := i;
	sizeGadget[i].g_LeftEdge := i * 4 * TEXT_WIDTH + 26;
	sizeGadget[i].g_NextGadget := &sizeGadget[i + 1];
	sizeGadget[i].g_GadgetRender.gBorder := &sizeBorder;
	sizeGadget[i].g_GadgetText := &sizeText[i];
	sizeText[i] := IntuiText_t(
	    FOREGROUND_PEN, BACKGROUND_PEN, JAM1,
	    2 * 1, 2 * 1, nil, nil, nil
	);
    od;
    sizeBorder := Border_t(
	0, 0, FOREGROUND_PEN, BACKGROUND_PEN, JAM1, 5, nil, nil
    );
    sizeBorder.b_XY := &sizeBox[0];
    sizeBox := BoxXY_t(
	0, 0,
	TEXT_WIDTH * 3 + 2 * 2 - 1, 0,
	TEXT_WIDTH * 3 + 2 * 2 - 1, TEXT_HEIGHT + 2 * 2 - 1,
	0, TEXT_HEIGHT + 2 * 2 - 1,
	0, 0
    );
    sizeGadget[3].g_NextGadget := nil;
    sizeText[0].it_IText := " 16";
    sizeText[1].it_IText := " 32";
    sizeText[2].it_IText := " 64";
    sizeText[3].it_IText := "128";
    if Request(&requester, Window) then
	oldIDCMP := Window*.w_IDCMPFlags;
	ModifyIDCMP(Window, GADGETUP);
	ignore Wait(1 << Window*.w_UserPort*.mp_SigBit);
	while
	    im := pretend(GetMsg(Window*.w_UserPort), *IntuiMessage_t);
	    im ~= nil
	do
	    if im*.im_Class = GADGETUP then
		SectorShift :=
		    pretend(im*.im_IAddress, *Gadget_t)*.g_GadgetID + 4;
		Header.h_size := 1 << SectorShift;
		SectorMask := Header.h_size - 1;
		ViewFactor := VIEW_SIZE / Header.h_size;
	    fi;
	    ReplyMsg(&im*.im_ExecMessage);
	od;
	ModifyIDCMP(Window, oldIDCMP);
	EndRequest(&requester, Window);
	true
    else
	false
    fi
corp;

/*
 * readMap - read the initial map file. Return 'true' if succeeded.
 */

proc readMap(*char fileName)bool:
    register *Sector_t s;
    register *char p, q;
    Handle_t fd;
    register uint i, j;

    fd := Open(fileName, MODE_OLDFILE);
    if fd ~= 0 then
	if Read(fd, &Header, sizeof(Header_t)) ~= sizeof(Header_t) then
	    emError("bad data - can't read header");
	    Close(fd);
	    false
	else
	    SectorShift :=
		case Header.h_size
		incase 16:
		    4
		incase 32:
		    5
		incase 64:
		    6
		incase 128:
		    7
		esac;
	    SectorMask := Header.h_size - 1;
	    ViewFactor := VIEW_SIZE / Header.h_size;
	    i := Header.h_size << SectorShift * sizeof(Sector_t);
	    Sectors := AllocMem(i, 0x0);
	    if Sectors ~= nil then
		if Read(fd, Sectors, i) ~= i then
		    FreeMem(Sectors, i);
		    emError("bad data - can't read sectors");
		    Close(fd);
		    false
		else
		    Close(fd);
		    LoadRGB4(&Screen*.sc_ViewPort,
			     &Header.h_colourMap[0], COLOURS);
		    true
		fi
	    else
		emError("no space for sectors");
		Close(fd);
		false
	    fi
	fi
    else
	if getSize() then
	    Sectors :=
		AllocMem(Header.h_size << SectorShift * sizeof(Sector_t), 0x0);
	    if Sectors ~= nil then
		for i from 0 upto COUNTRY_MAX - 1 do
		    Header.h_country[i].c_colour := COLOUR_BASE + i;
		    p := &Header.h_country[i].c_name[0];
		    q := "Country \#xx";
		    while
			p* := q*;
			p* ~= '\e'
		    do
			p := p + sizeof(char);
			q := q + sizeof(char);
		    od;
		    Header.h_country[i].c_name[9] := i / 10 + '0';
		    Header.h_country[i].c_name[10] := i % 10 + '0';
		od;
		for i from 0 upto Header.h_size - 1 do
		    for j from 0 upto Header.h_size - 1 do
			s := &Sectors*[i << SectorShift + j];
			s*.s_owner := OWNER_UNKNOWN;
			s*.s_designation := ' ';
		    od;
		od;
		true
	    else
		emError("no space for sectors");
		false
	    fi
	else
	    emError("can't make size requester");
	    false
	fi
    fi
corp;

/*
 * writeMap - write the final map file.
 */

proc writeMap(*char fileName)bool:
    Handle_t fd;
    uint len;

    fd := Open(fileName, MODE_NEWFILE);
    if fd ~= 0 then
	len := Header.h_size << SectorShift * sizeof(Sector_t);
	if Write(fd, &Header, sizeof(Header_t)) ~= sizeof(Header_t) then
	    emError("can't write header");
	    Close(fd);
	    false
	elif Write(fd, Sectors, len) ~= len then
	    emError("can't write sectors");
	    Close(fd);
	    false
	else
	    Close(fd);
	    true
	fi
    else
	emError("can't open output file");
	false
    fi
corp;

/*
 * getHeader - externally callable routine to return a pointer to the header.
 */

proc getHeader()*Header_t:

    &Header
corp;

/*
 * getCountry - externally callable routine to return a pointer to the
 *	specified country.
 */

proc getCountry(uint i)*Country_t:

    &Header.h_country[i]
corp;

/*
 * getSector - externally callable routine to return a pointer to the
 *	specified sector.
 */

proc getSector(register int r, c)*Sector_t:

    while r < 0 do
	r := r + Header.h_size;
    od;
    r := r & SectorMask;
    while c < 0 do
	c := c + Header.h_size;
    od;
    c := make(c, uint) & SectorMask;
    &Sectors*[make(r, uint) << SectorShift + c]
corp;

/*
 * displayChar - display a character at the given position.
 */

proc displayChar(uint x, y; char ch)void:

    Move(RastPort, (x + 3) * TEXT_WIDTH,
	 1 + TEXT_BASELINE + TEXT_HEIGHT * (y + 3));
    Text(RastPort, &ch, 1);
corp;

/*
 * viewSector - draw a sector's representation in the view window.
 *	It is assumed that the appropiate APen is already set. The
 *	passed co-ordinates are absolute ones in the View window.
 */

proc viewSector(register uint r, c)void:
    register uint i, j;

    r := r * ViewFactor;
    c := c * ViewFactor;
    for i from 0 upto ViewFactor - 1 do
	for j from 0 upto ViewFactor - 1 do
	    ignore WritePixel(ViewRastPort,
			      c + j + 2, r + i + TITLE_BAR_HEIGHT);
	od;
    od;
corp;

/*
 * refreshSector - externally callable routine to display the screen data
 *	for the requested sector, if it is visible.
 */

proc refreshSector(register int r, c)void:
    register *Sector_t s;
    register uint i, j;

    s := getSector(r, c);
    while r > VertOffset do
	r := r - Header.h_size;
    od;
    while r < VertOffset do
	r := r + Header.h_size;
    od;
    while c > HorizOffset do
	c := c - Header.h_size;
    od;
    while c < HorizOffset do
	c := c + Header.h_size;
    od;
    if r < VertOffset + MAP_HEIGHT and c < HorizOffset + MAP_WIDTH then
	SetAPen(RastPort,
		if s*.s_owner = OWNER_UNKNOWN then
		    COLOUR_UNKNOWN
		elif s*.s_owner = OWNER_DEITY then
		    COLOUR_DEITY
		else
		    Header.h_country[s*.s_owner].c_colour
		fi);
	SetBPen(RastPort, COLOUR_BLACK);
	for i from 0 upto MAP_HEIGHT / Header.h_size do
	    if r + i << SectorShift - VertOffset < MAP_HEIGHT then
		for j from 0 upto MAP_WIDTH / Header.h_size do
		    if c + j << SectorShift - HorizOffset < MAP_WIDTH then
			displayChar(c + j << SectorShift - HorizOffset,
				    r + i << SectorShift - VertOffset,
				    s*.s_designation);
		    fi;
		od;
	    fi;
	od;
    fi;
    if ViewOpen then
	SetAPen(ViewRastPort,
		if s*.s_designation = '.' or s*.s_designation = ' ' then
		    COLOUR_BLACK
		elif s*.s_owner = OWNER_UNKNOWN then
		    COLOUR_UNKNOWN
		elif s*.s_owner = OWNER_DEITY then
		    COLOUR_DEITY
		else
		    Header.h_country[s*.s_owner].c_colour
		fi);
	r := r - VertOffset - MAP_HEIGHT / 2 + Header.h_size * 3 / 2;
	c := c - HorizOffset - MAP_WIDTH / 2 + Header.h_size * 3 / 2;
	viewSector(make(r, uint) & SectorMask, make(c, uint) & SectorMask);
    fi;
corp;

/*
 * displayMap - display the portion of the map within the given rectangle
 */

proc displayMap(uint xmin, ymin, xmax, ymax)void:
    register uint j, jj;
    uint i, ii;
    register *Sector_t s;

    SetBPen(RastPort, COLOUR_BLACK);
    for i from ymin upto ymax - 1 do
	ii := i + VertOffset + Header.h_size * 2;
	ii := ii & SectorMask << SectorShift;
	Move(RastPort,
	     xmin * TEXT_WIDTH + TEXT_WIDTH * 3,
	     i * TEXT_HEIGHT + (1 + TEXT_HEIGHT * 3 + TEXT_BASELINE));
	for j from xmin upto xmax - 1 do
	    jj := j + HorizOffset + Header.h_size * 3;
	    s := &Sectors*[ii + jj & SectorMask];
	    SetAPen(RastPort,
		    if s*.s_owner = OWNER_UNKNOWN then
			COLOUR_UNKNOWN
		    elif s*.s_owner = OWNER_DEITY then
			COLOUR_DEITY
		    else
			Header.h_country[s*.s_owner].c_colour
		    fi);
	    Text(RastPort, &s*.s_designation, 1);
	od;
    od;
corp;

/*
 * displayView - display the selected portion of the View sectors.
 */

proc displayView(uint xmin, ymin, xmax, ymax)void:
    register uint j, jj;
    uint i, ii;
    register *Sector_t s;

    for i from ymin upto ymax - 1 do
	ii := i + VertOffset + MAP_HEIGHT / 2 + Header.h_size * 5 / 2;
	ii := ii & SectorMask << SectorShift;
	for j from xmin upto xmax - 1 do
	    jj := j + HorizOffset + MAP_WIDTH / 2 + Header.h_size * 7 / 2;
	    s := &Sectors*[ii + jj & SectorMask];
	    SetAPen(ViewRastPort,
		    if s*.s_designation = '.' or s*.s_designation = ' ' then
			COLOUR_BLACK
		    elif s*.s_owner = OWNER_UNKNOWN then
			COLOUR_UNKNOWN
		    elif s*.s_owner = OWNER_DEITY then
			COLOUR_DEITY
		    else
			Header.h_country[s*.s_owner].c_colour
		    fi);
	    viewSector(i, j);
	od;
    od;
corp;

/*
 * routines to display digits.
 */

proc digit1(register int n)void:
    char ch;

    ch :=
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
	fi;
    Text(RastPort, &ch, 1);
corp;

proc digit2(register int n)void:
    char ch;

    ch :=
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
	fi;
    Text(RastPort, &ch, 1);
corp;

proc digit3(int n)void:
    char ch;

    ch := |n % 10 + '0';
    Text(RastPort, &ch, 1);
corp;

/*
 * newCursorX - display the new X co-ordinate of the cursor.
 */

proc newCursorX(int cursorX)void:

    SetAPen(RastPort, COLOUR_WHITE);
    SetBPen(RastPort, COLOUR_BLACK);
    Move(RastPort, 0, 1 + TEXT_BASELINE + TEXT_HEIGHT + TEXT_HEIGHT * 2 / 3);
    digit1(cursorX);
    digit2(cursorX);
    digit3(cursorX);
corp;

/*
 * newCursorY - display the new Y co-ordinate of the cursor.
 */

proc newCursorY(int cursorY)void:

    SetAPen(RastPort, COLOUR_WHITE);
    SetBPen(RastPort, COLOUR_BLACK);
    Move(RastPort, 0, 1 + TEXT_BASELINE + TEXT_HEIGHT / 3);
    digit1(cursorY);
    digit2(cursorY);
    digit3(cursorY);
corp;

/*
 * displayRowNumbers - display some row numbers.
 */

proc displayRowNumbers(register int lower;register uint rowTop, rowBottom)void:

    SetAPen(RastPort, COLOUR_BLACK);
    SetBPen(RastPort, COLOUR_WHITE);
    while rowTop < rowBottom do
	Move(RastPort, 0, 1 + TEXT_BASELINE + TEXT_HEIGHT * (rowTop + 3));
	digit1(lower);
	digit2(lower);
	digit3(lower);
	rowTop := rowTop + 1;
	lower := lower + 1;
    od;
corp;

/*
 * displayColumnNumbers - display some column numbers.
 */

proc displayColumnNumbers(int lower; uint colLeft; register uint colRight)void:
    register uint cl;
    register int l;

    SetAPen(RastPort, COLOUR_BLACK);
    SetBPen(RastPort, COLOUR_WHITE);
    l := lower;
    cl := colLeft;
    Move(RastPort, (cl + 3) * TEXT_WIDTH, 1 + TEXT_BASELINE + 0);
    while cl < colRight do
	cl := cl + 1;
	digit1(l);
	l := l + 1;
    od;
    l := lower;
    cl := colLeft;
    Move(RastPort, (cl + 3) * TEXT_WIDTH, 1 + TEXT_BASELINE + TEXT_HEIGHT * 1);
    while cl < colRight do
	cl := cl + 1;
	digit2(l);
	l := l + 1;
    od;
    l := lower;
    cl := colLeft;
    Move(RastPort, (cl + 3) * TEXT_WIDTH, 1 + TEXT_BASELINE + TEXT_HEIGHT * 2);
    while cl < colRight do
	cl := cl + 1;
	digit3(l);
	l := l + 1;
    od;
corp;

/*
 * displayFull - display a full screen of data at the current offset.
 */

proc displayFull()void:

    displayRowNumbers(VertOffset, 0, MAP_HEIGHT);
    displayColumnNumbers(HorizOffset, 0, MAP_WIDTH);
    displayMap(0, 0, MAP_WIDTH, MAP_HEIGHT);
    if ViewOpen then
	displayView(0, 0, Header.h_size, Header.h_size);
    fi;
corp;

/*
 * scrollMap - use ScrollRaster to scroll the map.
 */

proc scrollMap(int deltaX, deltaY)void:

    SetBPen(RastPort, COLOUR_BLACK);
    ScrollRaster(RastPort, deltaX * TEXT_WIDTH, deltaY * TEXT_HEIGHT,
		 if deltaX = 0 then
		     0
		 else
		     TEXT_WIDTH * 3
		 fi,
		 if deltaX = 0 then
		     1 + TEXT_HEIGHT * 3
		 else
		     1
		 fi,
		 TEXT_WIDTH * (MAP_WIDTH + 3) - 1,
		 TEXT_HEIGHT * (MAP_HEIGHT + 3));
corp;

/*
 * scrollView - use ScrollRaster to scroll the view.
 */

proc scrollView(int deltaX, deltaY)void:

    SetBPen(ViewRastPort, COLOUR_BLACK);
    ScrollRaster(ViewRastPort, deltaX * ViewFactor, deltaY * ViewFactor,
		 2, TITLE_BAR_HEIGHT,
		 VIEW_SIZE + 2 - 1, VIEW_SIZE + TITLE_BAR_HEIGHT - 1);
corp;

/*
 * leftScroll - scroll 'amount' columns to the left.
 */

proc leftScroll(register int amount)void:

    HorizOffset := HorizOffset - amount;
    scrollMap(-amount, 0);
    displayColumnNumbers(HorizOffset, 0, amount);
    displayMap(0, 0, amount, MAP_HEIGHT);
    if ViewOpen then
	scrollView(-amount, 0);
	displayView(0, 0, amount, Header.h_size);
    fi;
corp;

/*
 * rightScroll - scroll 'amount' columns to the right.
 */

proc rightScroll(register int amount)void:

    HorizOffset := HorizOffset + amount;
    scrollMap(amount, 0);
    displayColumnNumbers(HorizOffset + MAP_WIDTH - amount,
			 MAP_WIDTH - amount, MAP_WIDTH);
    displayMap(MAP_WIDTH - amount, 0, MAP_WIDTH, MAP_HEIGHT);
    if ViewOpen then
	scrollView(amount, 0);
	displayView(Header.h_size - amount, 0, Header.h_size, Header.h_size);
    fi;
corp;

/*
 * upScroll - scroll 'amount' rows up.
 */

proc upScroll(register int amount)void:

    VertOffset := VertOffset - amount;
    scrollMap(0, -amount);
    displayRowNumbers(VertOffset, 0, amount);
    displayMap(0, 0, MAP_WIDTH, amount);
    if ViewOpen then
	scrollView(0, -amount);
	displayView(0, 0, Header.h_size, amount);
    fi;
corp;

/*
 * downScroll - scroll 'amount' rows down.
 */

proc downScroll(register int amount)void:

    VertOffset := VertOffset + amount;
    scrollMap(0, amount);
    displayRowNumbers(VertOffset + MAP_HEIGHT - amount,
		      MAP_HEIGHT - amount, MAP_HEIGHT);
    displayMap(0, MAP_HEIGHT - amount, MAP_WIDTH, MAP_HEIGHT);
    if ViewOpen then
	scrollView(0, amount);
	displayView(0, Header.h_size - amount, Header.h_size, Header.h_size);
    fi;
corp;

/*
 * horizontalScroll - the user has played with the horizontal scrolling gadget.
 */

proc horizontalScroll()void:
    register int amount, newPos;

    newPos := (make(HorizPropInfo.pi_HorizPot, ulong) + 1) *
	(Header.h_size * 3 - MAP_WIDTH) / 0x10000 - Header.h_size * 3 / 2;
    if newPos ~= HorizOffset then
	if newPos > HorizOffset then
	    amount := newPos - HorizOffset;
	    if amount >= MAP_WIDTH then
		HorizOffset := newPos;
		displayFull();
	    else
		rightScroll(amount);
	    fi;
	else
	    amount := HorizOffset - newPos;
	    if amount >= MAP_WIDTH then
		HorizOffset := newPos;
		displayFull();
	    else
		leftScroll(amount);
	    fi;
	fi;
    fi;
corp;

/*
 * verticalScroll - the user has played with the vertical scrolling gadget.
 */

proc verticalScroll()void:
    register int amount, newPos;

    newPos := (make(VertPropInfo.pi_VertPot, ulong) + 1) *
	(Header.h_size * 3 - MAP_HEIGHT) / 0x10000 - Header.h_size * 3 / 2;
    if newPos ~= VertOffset then
	if newPos > VertOffset then
	    amount := newPos - VertOffset;
	    if amount >= MAP_HEIGHT then
		VertOffset := newPos;
		displayFull();
	    else
		downScroll(amount);
	    fi;
	else
	    amount := VertOffset - newPos;
	    if amount >= MAP_HEIGHT then
		VertOffset := newPos;
		displayFull();
	    else
		upScroll(amount);
	    fi;
	fi;
    fi;
corp;

/*
 * setHorizBar - put the horizontal scroll bar in the proper place.
 */

proc setHorizBar()void:
    uint horizBody, horizPot;

    horizBody := MAP_WIDTH * 0x10000 / make(Header.h_size * 3, ulong);
    horizPot :=
	(make(HorizOffset + Header.h_size * 3 / 2, long) * 0x10000 - 1) /
	    (Header.h_size * 3 - MAP_WIDTH);
    NewModifyProp(&HorizScrollGadget, Window, nil, AUTOKNOB | FREEHORIZ,
		  horizPot, 0, horizBody, 0, 1);
corp;

/*
 * setVertBar - put the vertical scroll bar in the proper place.
 */

proc setVertBar()void:
    uint vertBody, vertPot;

    vertBody := MAP_HEIGHT * 0x10000 / make(Header.h_size * 3, ulong);
    vertPot :=
	(make(VertOffset + Header.h_size * 3 / 2, long) * 0x10000 - 1) /
	    (Header.h_size * 3 - MAP_HEIGHT);
    NewModifyProp(&VertScrollGadget, Window, nil, AUTOKNOB | FREEVERT,
		  0, vertPot, 0, vertBody, 1);
corp;

/*
 * view - open or close the view window, as desired.
 */

proc view()void:
    NewWindow_t newWindow;

    if ViewOpen then
	ViewOpen := false;
	CloseWindow(ViewWindow);
    else
	newWindow := NewWindow_t(
	    (WIDTH - (VIEW_SIZE + 4)) / 2,
	    (HEIGHT - (VIEW_SIZE + TITLE_BAR_HEIGHT + 1)) / 2,
	    VIEW_SIZE + 4, VIEW_SIZE + TITLE_BAR_HEIGHT + 1,
	    FREEPEN, FREEPEN,
	    CLOSEWINDOW,
	    WINDOWDRAG | WINDOWCLOSE | SMART_REFRESH | NOCAREREFRESH,
	    nil, nil, nil, nil, nil, 0, 0, 0, 0,
	    CUSTOMSCREEN);
	newWindow.nw_Screen := Screen;
	newWindow.nw_Title := "View";
	ViewWindow := OpenWindow(&newWindow);
	if ViewWindow ~= nil then
	    ViewOpen := true;
	    ViewRastPort := ViewWindow*.w_RPort;
	    displayView(0, 0, Header.h_size, Header.h_size);
	else
	    emError("can't open view window");
	fi;
    fi;
corp;

/*
 * getNumber - request a number.
 */

proc getNumber(*char prompt; *int pNum)bool:
    uint NUMBER_SIZE = 10;
    [NUMBER_SIZE] char buffer;
    register uint i;
    register int n;
    bool isNeg;

    buffer[0] := '\e';
    buffer[NUMBER_SIZE - 1] := '\e';
    if stringRequester(Window, prompt, &buffer[0], NUMBER_SIZE) then
	i := 0;
	while i ~= NUMBER_SIZE and buffer[i] = ' ' do
	    i := i + 1;
	od;
	if i = NUMBER_SIZE then
	    false
	else
	    if buffer[i] = '-' then
		i := i + 1;
		isNeg := true;
	    else
		isNeg := false;
	    fi;
	    n := 0;
	    while i ~= NUMBER_SIZE and
		(buffer[i] >= '0' and buffer[i] <= '9')
	    do
		n := n * 10 + (buffer[i] - '0');
		i := i + 1;
	    od;
	    pNum* := if isNeg then -n else n fi;
	    if i ~= NUMBER_SIZE and buffer[i] ~= '\e' then
		emError("invalid number - print aborted");
		false
	    else
		true
	    fi
	fi
    else
	false
    fi
corp;

/*
 * doPrint - print to a file a region of the map.
 */

proc doPrint(bool compressed)void:
    extern printMapFile(*char fileName; int top, bottom, left, right;
			bool compressed)void;
    [MAX_FILE_NAME] char fileName;
    int top, bottom, left, right;
    register int r, c;

    fileName[0] := '\e';
    if getNumber("Top:", &top) and getNumber("Bottom:", &bottom) and
	getNumber("Left:", &left) and getNumber("Right:", &right) and
	getFileName(Window, &fileName)
    then
	if top > bottom then
	    emError("top must be <= bottom");
	elif left > right then
	    emError("left must be <= right");
	else
	    printMapFile(&fileName[0], top, bottom, left, right, compressed);
	    emError("Map completed");
	fi;
    fi;
corp;

/*
 * doStuff - main processing loop
 */

proc doStuff(*char fileName)void:
    extern
	parseMap(*char fileName, countryName; bool isMap)void,
	parseLookout(*char fileName)void,
	parseGodMap(*char fileName, countryName)void;
    register *IntuiMessage_t im;
    *MenuItem_t mi;
    *Gadget_t g;
    *ColorMap_t cm;
    ulong mainBit, viewBit, gotBit, class;
    register uint i, which;
    uint owner;
    int prevX, prevY, mouseX, mouseY, cursorX, cursorY;
    register char des;
    bool quit, mouseMoved, settingOwner, settingDesignation;
    [MAX_FILE_NAME] char mapName;
    [NAME_LENGTH] char name;
    [2] char buffer;

    mapName[0] := '\e';
    buffer[0] := '\e';
    buffer[1] := '\e';
    name[0] := '\e';
    ViewOpen := false;
    HorizOffset := - (MAP_WIDTH / 2);
    setHorizBar();
    VertOffset := - (MAP_HEIGHT / 2);
    setVertBar();
    displayFull();
    cm := Screen*.sc_ViewPort.vp_ColorMap;
    prevX := 0x7fff;
    prevY := 0x7fff;
    cursorX := HorizOffset;
    cursorY := VertOffset;
    settingOwner := false;
    settingDesignation := false;
    quit := false;
    mainBit := 1 << Window*.w_UserPort*.mp_SigBit;
    viewBit := 0;
    while not quit do
	gotBit := Wait(mainBit | viewBit);
	if gotBit = viewBit then
	    while
		im := pretend(GetMsg(ViewWindow*.w_UserPort), *IntuiMessage_t);
		im ~= nil
	    do
		ReplyMsg(&im*.im_ExecMessage);
	    od;
	    view();
	else
	    mouseMoved := false;
	    while
		im := pretend(GetMsg(Window*.w_UserPort), *IntuiMessage_t);
		im ~= nil
	    do
		class := im*.im_Class;
		which := im*.im_Code;
		mouseX := im*.im_MouseX;
		mouseY := im*.im_MouseY;
		g := pretend(im*.im_IAddress, *Gadget_t);
		ReplyMsg(&im*.im_ExecMessage);
		/* be careful to just flush anything that happened after we
		   started the file write preparatory to quitting. */
		if not quit then
		    case class
		    incase MOUSEMOVE:
			mouseMoved := true;
		    incase MOUSEBUTTONS:
			if which = IECODE_UP_PREFIX | IECODE_LBUTTON then
			    if settingOwner then
				getSector(cursorY, cursorX)*.s_owner := owner;
				refreshSector(cursorY, cursorX);
			    elif settingDesignation then
				getSector(cursorY, cursorX)*.s_designation :=
				    des;
				if des = ' ' then
				    getSector(cursorY, cursorX)*.s_owner :=
					OWNER_UNKNOWN;
				fi;
				refreshSector(cursorY, cursorX);
			    fi;
			fi;
		    incase GADGETUP:
			case g*.g_GadgetID
			incase 0:
			    /* vertical scroll gadget */
			    verticalScroll();
			incase 1:
			    /* horizontal scroll gadget */
			    horizontalScroll();
			incase 2:
			    /* left arrow */
			    if HorizOffset ~= - Header.h_size * 3 / 2 then
				leftScroll(1);
				setHorizBar();
			    fi;
			incase 3:
			    /* right arrow */
			    if HorizOffset + MAP_WIDTH - 1 ~=
				    (Header.h_size * 3 - 1) / 2 then
				rightScroll(1);
				setHorizBar();
			    fi;
			incase 4:
			    /* up arrow */
			    if VertOffset ~= - Header.h_size * 3 / 2 then
				upScroll(1);
				setVertBar();
			    fi;
			incase 5:
			    /* down arrow */
			    if VertOffset + MAP_HEIGHT - 1 ~=
				    (Header.h_size * 3 - 1) / 2 then
				downScroll(1);
				setVertBar();
			    fi;
			esac;
		    incase MENUPICK:
			settingOwner := false;
			settingDesignation := false;
			while which ~= MENUNULL do
			    mi := ItemAddress(MainMenu, which);
			    case MENUNUM(which)
			    incase 0:
				/* General */
				case ITEMNUM(which)
				incase 0:
				    /* Colours */
				    SetAPen(RastPort, COLOUR_BLACK);
				    SetBPen(RastPort, COLOUR_WHITE);
				    paletteEditor(Window);
				    for i from 0 upto COLOURS - 1 do
					Header.h_colourMap[i] :=
					    GetRGB4(cm, i);
				    od;
				incase 1:
				    /* View */
				    view();
				    viewBit :=
					if ViewOpen then
					    1 << ViewWindow*.w_UserPort*.
						    mp_SigBit
					else
					    0
					fi;
				incase 2:
				    /* Print */
				    case SUBNUM(which)
				    incase 0:
					/* Normal */
					doPrint(false);
				    incase 1:
					/* Compressed */
					doPrint(true);
				    esac;
				incase 3:
				    /* Abort */
				    ClearMenuStrip(Window);
				    quit := true;
				incase 4:
				    /* Quit */
				    if writeMap(fileName) then
					ClearMenuStrip(Window);
					quit := true;
				    fi;
				incase 5:
				    /* About */
				    emError("EmpMap, by Chris Gray");
				esac;
			    incase 1:
				/* Parse */
				case ITEMNUM(which)
				incase 0:
				    /* Map */
				    if getFileName(Window, &mapName) then
					parseMap(&mapName[0], nil, true);
				    fi;
				incase 1:
				    /* Radar */
				    if getFileName(Window, &mapName) then
					parseMap(&mapName[0], nil, false);
				    fi;
				incase 2:
				    /* Lookout */
				    if getFileName(Window, &mapName) then
					parseLookout(&mapName[0]);
				    fi;
				incase 3:
				    /* God Map */
				    if getFileName(Window, &mapName) and
					stringRequester(Window,
							"Which country? ",
							&name[0], NAME_LENGTH)
				    then
					parseMap(&mapName[0],&name[0],false);
				    fi;
				esac;
			    incase 2:
				/* Set */
				case ITEMNUM(which)
				incase 0:
				    /* Name1 */
				    which := SUBNUM(which);
				    ignore
					stringRequester(Window,
					    "Enter new country name: ",
					    &Header.h_country[which].c_name[0],
					    NAME_LENGTH);
				incase 1:
				    /* Name2 */
				    which := SUBNUM(which) + 15;
				    ignore
					stringRequester(Window,
					    "Enter new country name: ",
					    &Header.h_country[which].c_name[0],
					    NAME_LENGTH);
				incase 2:
				    /* Owner1 */
				    owner := SUBNUM(which);
				    if owner = 0 then
					owner := OWNER_DEITY
				    elif owner = 1 then
					owner := OWNER_UNKNOWN;
				    else
					owner := owner - 2;
				    fi;
				    settingOwner := true;
				incase 3:
				    /* Owner2 */
				    owner := SUBNUM(which) + 15;
				    settingOwner := true;
				incase 4:
				    /* Designation */
				    if stringRequester(Window,
					    "Enter designation character: ",
					    &buffer[0], 2)
				    then
					des := buffer[0];
					if des = '.' or des = '^' or
					    des = '-' or des = 's' or
					    des = 'c' or des = 'u' or
					    des = 'd' or des = 'i' or
					    des = 'm' or des = 'g' or
					    des = 'h' or des = 'w' or
					    des = 't' or des = 'f' or
					    des = '*' or des = 'r' or
					    des = '+' or des = ')' or
					    des = '!' or des = '\#' or
					    des = '=' or des = 'b' or
					    des = 'x' or des = ' '
					then
					    settingDesignation := true;
					else
					    emError("invalid designation");
					fi;
				    fi;
				esac;
			    esac;
			    which := mi*.mi_NextSelect;
			od;
		    esac;
		fi;
	    od;
	    if mouseMoved then
		if mouseX / TEXT_WIDTH ~= prevX / TEXT_WIDTH or
		    mouseY / TEXT_HEIGHT ~= prevY / TEXT_HEIGHT
		then
		    prevX := mouseX;
		    prevY := mouseY;
		    if prevX > TEXT_WIDTH * 3 and prevY > TEXT_HEIGHT * 3 and
			prevX <= TEXT_WIDTH * (MAP_WIDTH + 3) and
			prevY <= TEXT_HEIGHT * (MAP_HEIGHT + 3)
		    then
			cursorX := prevX / TEXT_WIDTH - 3 + HorizOffset;
			newCursorX(cursorX);
			cursorY := prevY / TEXT_HEIGHT - 3 + VertOffset;
			newCursorY(cursorY);
		    fi;
		fi;
	    fi;
	fi;
    od;
    if ViewOpen then
	view();
    fi;
corp;

/*
 * buildGadgets - build the scroll bar gadgets.
 */

proc buildGadgets()void:

    VertScrollGadget := Gadget_t(
	nil, - (VERT_SCROLL_WIDTH - 1), ARROW_HEIGHT + 1,
	VERT_SCROLL_WIDTH,
	- (1 + HORIZ_SCROLL_HEIGHT + ARROW_HEIGHT * 2),
	GADGHNONE | GADGIMAGE | GRELRIGHT | GRELHEIGHT,
	RELVERIFY | RIGHTBORDER, PROPGADGET,
	(nil), (nil), nil, 0x0, (nil), 0, nil
    );
    VertScrollGadget.g_NextGadget := &HorizScrollGadget;
    VertScrollGadget.g_GadgetRender.gImage := &VertKnob;
    VertScrollGadget.g_SpecialInfo.gProp := &VertPropInfo;
    VertPropInfo := PropInfo_t(
	AUTOKNOB | FREEVERT, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    );

    HorizScrollGadget := Gadget_t(
	nil, ARROW_WIDTH, - HORIZ_SCROLL_HEIGHT,
	- (VERT_SCROLL_WIDTH + ARROW_WIDTH * 2 - 1),
	HORIZ_SCROLL_HEIGHT,
	GADGHNONE | GADGIMAGE | GRELBOTTOM | GRELWIDTH,
	RELVERIFY | BOTTOMBORDER, PROPGADGET,
	(nil), (nil), nil, 0x0, (nil), 1, nil
    );
    HorizScrollGadget.g_NextGadget := &LeftScrollGadget;
    HorizScrollGadget.g_GadgetRender.gImage := &HorizKnob;
    HorizScrollGadget.g_SpecialInfo.gProp := &HorizPropInfo;
    HorizPropInfo := PropInfo_t(
	AUTOKNOB | FREEHORIZ, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    );

    LeftScrollGadget := Gadget_t(
	nil, 0, - HORIZ_SCROLL_HEIGHT,
	ARROW_WIDTH, HORIZ_SCROLL_HEIGHT,
	GADGHCOMP | GRELBOTTOM,
	RELVERIFY | BOTTOMBORDER, BOOLGADGET,
	(nil), (nil), nil, 0x0, (nil), 2, nil
    );
    LeftScrollGadget.g_NextGadget := &RightScrollGadget;
    LeftScrollGadget.g_GadgetRender.gBorder := &LeftArrow;
    LeftArrow := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    LeftArrow.b_XY := &LeftArrowXY[0];
    LeftArrow.b_NextBorder := &LeftRightBox;
    LeftArrowXY := ArrowXY_t(
	10, 5, 3, 5, 6, 2, 3, 5, 6, 8
    );

    RightScrollGadget := Gadget_t(
	nil, - (VERT_SCROLL_WIDTH + ARROW_WIDTH - 2),
	- HORIZ_SCROLL_HEIGHT,
	ARROW_WIDTH, HORIZ_SCROLL_HEIGHT,
	GADGHCOMP | GRELBOTTOM | GRELRIGHT,
	RELVERIFY | BOTTOMBORDER, BOOLGADGET,
	(nil), (nil), nil, 0x0, (nil), 3, nil
    );
    RightScrollGadget.g_NextGadget := &UpScrollGadget;
    RightScrollGadget.g_GadgetRender.gBorder := &RightArrow;
    RightArrow := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    RightArrow.b_XY := &RightArrowXY[0];
    RightArrow.b_NextBorder := &LeftRightBox;
    RightArrowXY := ArrowXY_t(
	3, 5, 10, 5, 7, 2, 10, 5, 7, 8
    );

    LeftRightBox := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    LeftRightBox.b_XY := &LeftRightBoxXY[0];
    LeftRightBoxXY := BoxXY_t(
	0, 0,
	ARROW_WIDTH - 1, 0,
	ARROW_WIDTH - 1, HORIZ_SCROLL_HEIGHT - 1,
	0, HORIZ_SCROLL_HEIGHT - 1,
	0, 0
    );

    UpScrollGadget := Gadget_t(
	nil, - (VERT_SCROLL_WIDTH - 1), 1,
	VERT_SCROLL_WIDTH, ARROW_HEIGHT,
	GADGHCOMP | GRELRIGHT,
	RELVERIFY | RIGHTBORDER, BOOLGADGET,
	(nil), (nil), nil, 0x0, (nil), 4, nil
    );
    UpScrollGadget.g_NextGadget := &DownScrollGadget;
    UpScrollGadget.g_GadgetRender.gBorder := &UpArrow;
    UpArrow := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    UpArrow.b_XY := &UpArrowXY[0];
    UpArrow.b_NextBorder := &UpDownBox;
    UpArrowXY := ArrowXY_t(
	6, 9, 6, 2, 3, 5, 6, 2, 9, 5
    );

    DownScrollGadget := Gadget_t(
	nil, - (VERT_SCROLL_WIDTH - 1),
	- (HORIZ_SCROLL_HEIGHT + ARROW_HEIGHT - 1),
	VERT_SCROLL_WIDTH, ARROW_HEIGHT,
	GADGHCOMP | GRELRIGHT | GRELBOTTOM,
	RELVERIFY | RIGHTBORDER, BOOLGADGET,
	(nil), (nil), nil, 0x0, (nil), 5, nil
    );
    DownScrollGadget.g_GadgetRender.gBorder := &DownArrow;
    DownArrow := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    DownArrow.b_XY := &DownArrowXY[0];
    DownArrow.b_NextBorder := &UpDownBox;
    DownArrowXY := ArrowXY_t(
	6, 2, 6, 9, 3, 6, 6, 9, 9, 6
    );

    UpDownBox := Border_t(
	0, 0, BACKGROUND_PEN, FOREGROUND_PEN, JAM1, 5, nil, nil
    );
    UpDownBox.b_XY := &UpDownBoxXY[0];
    UpDownBoxXY := BoxXY_t(
	0, 0,
	VERT_SCROLL_WIDTH - 1, 0,
	VERT_SCROLL_WIDTH - 1, ARROW_HEIGHT - 1,
	0, ARROW_HEIGHT - 1,
	0, 0
    );
corp;

/*
 * appendCountries - append a set of subItems with country numbers.
 */

proc appendCountries(*Menu_t m; uint low; uint high)bool:
    bool working;

    working := true;
    while working and low ~= high do
	if not appendTextSubItem(m, &Header.h_country[low].c_name[0], 0x0, ' ')
	    and setPens(m, Header.h_country[low].c_colour, COLOUR_BLACK)
	then
	    working := false;
	fi;
	low := low + 1;
    od;
    working
corp;

/*
 * buildMenus - try to build the menus we need
 */

proc buildMenus()bool:
    register *Menu_t m;

    m := newMenu("General");
    MainMenu := m;
    if m ~= nil and
	    appendTextItem(m, "Colours",     COMMSEQ, 'C') and
	    appendTextItem(m, "View",	     COMMSEQ, 'V') and
	    appendTextItem(m, "Print",	     0x0    , ' ') and
		appendTextSubItem(m, "Normal",	   0x0, ' ') and
		appendTextSubItem(m, "Compressed", 0x0, ' ') and
	    appendTextItem(m, "Abort",	     COMMSEQ, 'A') and
	    appendTextItem(m, "Quit",	     COMMSEQ, 'Q') and
	    appendTextItem(m, "About",	     0x0    , ' ')
    then
	m := newMenu("Parse");
	appendMenu(MainMenu, m);
	if m ~= nil and
		appendTextItem(m, "Map"    , COMMSEQ, 'M') and
		appendTextItem(m, "Radar"  , COMMSEQ, 'R') and
		appendTextItem(m, "Lookout", COMMSEQ, 'L') and
		appendTextItem(m, "God Map", COMMSEQ, 'G')
	then
	    m := newMenu("Set");
	    appendMenu(MainMenu, m);
	    m ~= nil and
		appendTextItem(m, "Name1"      , 0x0	, ' ') and
		    appendCountries(m, 0, 15) and
		appendTextItem(m, "Name2"      , 0x0	, ' ') and
		    appendCountries(m, 15, COUNTRY_MAX) and
		appendTextItem(m, "Owner1"     , 0x0	, ' ') and
		    appendTextSubItem(m, " DEITY "  , 0x0, ' ') and
		    appendTextSubItem(m, " UNKNOWN ", 0x0, ' ') and
		    appendCountries(m, 0, 15) and
		appendTextItem(m, "Owner2"     , 0x0	, ' ') and
		    appendCountries(m, 15, COUNTRY_MAX) and
		appendTextItem(m, "Designation", COMMSEQ, 'D')
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * runEmpMap - run the whole program, using the given data file name.
 */

proc runEmpMap(*char fileName)void:
    NewScreen_t newScreen;
    NewWindow_t newWindow;

    newScreen := NewScreen_t(
	    0, 0, WIDTH, HEIGHT, DEPTH, 0, 1,
	    0x0, CUSTOMSCREEN, nil, nil, nil, nil);
    newScreen.ns_DefaultTitle := fileName;
    Screen := OpenScreen(&newScreen);
    if Screen ~= nil then
	Header.h_colourMap := DEFAULT_COLOUR_MAP;
	LoadRGB4(&Screen*.sc_ViewPort, &Header.h_colourMap[0], COLOURS);
	Header.h_size := 1;
	buildGadgets();
	newWindow := NewWindow_t(
	    0, TITLE_BAR_HEIGHT, WIDTH, HEIGHT - TITLE_BAR_HEIGHT,
	    FREEPEN, FREEPEN,
	    MENUPICK | GADGETUP | MOUSEMOVE | MOUSEBUTTONS,
	    BORDERLESS | REPORTMOUSE |
		SMART_REFRESH | ACTIVATE | NOCAREREFRESH,
	    nil, nil, nil, nil, nil, 0, 0, 0, 0, CUSTOMSCREEN);
	newWindow.nw_Screen := Screen;
	newWindow.nw_FirstGadget := &VertScrollGadget;
	Window := OpenWindow(&newWindow);
	if Window ~= nil then
	    /* want 'readMap' call before 'buildMenus' call
	       since the menus refer to the country names
	       read in from the data file (also colours) */
	    if readMap(fileName) then
		if buildMenus() then
		    SetMenuStrip(Window, MainMenu);
		    RastPort := Window*.w_RPort;
		    doStuff(fileName);
		fi;
		freeMenu(MainMenu);
		FreeMem(Sectors,
			Header.h_size << SectorShift * sizeof(Sector_t));
	    fi;
	    CloseWindow(Window);
	fi;
	CloseScreen(Screen);
    fi;
corp;

/*
 * main program.
 */

proc main()void:
    extern
	_d_pars_initialize()void,
	GetPar()*char;
    *Process_t thisProcess;
    *Message_t mess;
    register *WBStartup_t sm;
    register *WBArg_t wa;
    register *char par;
    register Lock_t oldDir;
    register uint i;

    if OpenExecLibrary(0) ~= nil then
	if OpenIntuitionLibrary(0) ~= nil then
	    if OpenGraphicsLibrary(0) ~= nil then
		if OpenDosLibrary(0) ~= nil then
		    thisProcess := pretend(FindTask(nil), *Process_t);
		    if thisProcess*.pr_CLI = 0 then
			/* running from WorkBench */
			mess := WaitPort(&thisProcess*.pr_MsgPort);
			mess := GetMsg(&thisProcess*.pr_MsgPort);
			sm := pretend(mess, *WBStartup_t);
			wa := sm*.sm_ArgList;
			if wa ~= nil and sm*.sm_NumArgs > 1 then
			    for i from 1 upto sm*.sm_NumArgs - 1 do
				wa := wa + sizeof(WBArg_t);
				if wa*.wa_Lock ~= 0 then
				    oldDir := CurrentDir(wa*.wa_Lock);
				    runEmpMap(wa*.wa_Name);
				    ignore CurrentDir(oldDir);
				fi;
			    od;
			else
			    if wa*.wa_Lock ~= 0 then
				oldDir := CurrentDir(wa*.wa_Lock);
				runEmpMap(DEFAULT_DATA_FILE);
				ignore CurrentDir(oldDir);
			    fi;
			fi;
			Forbid();
			ReplyMsg(&sm*.sm_Message);
		    else
			/* running from CLI */
			_d_pars_initialize();
			par := GetPar();
			if par ~= nil then
			    while
				runEmpMap(par);
				par := GetPar();
				par ~= nil
			    do
			    od;
			else
			    runEmpMap(DEFAULT_DATA_FILE);
			fi;
		    fi;
		    CloseDosLibrary();
		fi;
		CloseGraphicsLibrary();
	    fi;
	    CloseIntuitionLibrary();
	fi;
	CloseExecLibrary();
    fi;
corp;
