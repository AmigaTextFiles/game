#drinc:exec/miscellaneous.g
#drinc:exec/ports.g
#drinc:exec/tasks.g
#drinc:exec/memory.g
#drinc:graphics/gfx.g
#drinc:graphics/gfxBase.g
#drinc:graphics/view.g
#drinc:libraries/dos.g
#drinc:libraries/dosextens.g
#drinc:workbench/workbench.g
#drinc:workbench/icon.g
#drinc:workbench/startup.g
#drinc:util.g
#/Include/Empire.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 * $Id: EmpCre.d,v 1.12 90/08/21 00:32:53 DaveWT Exp $
 * $Log:	EmpCre.d,v $
Revision 1.12  90/08/21  00:32:53  DaveWT
Sets w_doingPower to FALSE just to be safe (was w_tmp3).

Revision 1.11  90/08/15  00:35:33  DaveWT
Now initializes the w_tmp3 variable to false, and also the w_userFlush
to false (was w_tmp4).

Revision 1.10  90/06/02  01:38:31  DaveWT
Now initializes the w_doFlush element of World_t

Revision 1.9  90/05/10  11:44:01  DaveWT
Now initializes the gold and ore in sea and mountain sectors, to make it
easier to convert them to land later on, as per CG's version.

Revision 1.8  90/05/05  00:58:17  DaveWT
c_tmp1 is now c_compressed

Revision 1.7  90/04/30  23:17:37  DaveWT
initializeCountry() now sets the defaults for inChat, tmp1, and tmp2.

Revision 1.6  90/04/11  09:56:26  DaveWT
CHanged the window titles so people would know which console handler
was being used, and so they would know this EmpCre was for 2.1w.

 */

*char DEFAULT_PATH = "";                /* default to current directory */

/* arrays giving default values for several things which the Deity can
   adjust in Empire. See the actual code for many others */

[4, 4] uint ATTACK_MOBILITY_COST = (
      125,   208,   291, 21300,
      167,   250,   333, 21300,
      208,   291,   375, 21400,
    10700, 10800, 10900, 31900
);

[range(ShipType_t)] uint
    SHIP_COST = (30, 70, 127, 60, 80, 50, 100, 127),
    SHIP_SIZE = (6, 1, 25, 15, 20, 20, 20, 25),    /* visability   */
    SHIP_RANGE = (40, 30, 60, 40, 30, 30, 30, 40), /* visual range */
    SHIP_SPEED = (480, 960, 960, 685, 1200, 1200, 800, 960),
    SHIP_SH_RANGE = (1, 2, 8, 3, 0, 1, 1, 2),      /* shelling range */
    SHIP_DAMAGE = (3, 2, 1, 2, 2, 2, 2, 1);        /* sensitivity to damage */

[range(ItemType_t)][range(ShipType_t)] uint SHIP_CAPACITY = (
    ( 0,  0,   0,  0, 127,  0,   0,   0),  /* civ */
    (10, 25, 127, 80,   0, 25, 100,  60),  /* mil */
    (10, 27, 127, 40, 127, 10, 127,  60),  /* she */
    ( 1,  2,   4,  2, 127,  1,  30,   3),  /* gun */
    ( 0,  0,   0,  0,   5,  0,   2, 127),  /* pla */
    ( 0,  0,   0,  0, 127,  0,   0,   0),  /* ore */
    ( 0,  0,   0,  0, 127,  0,   0,   0)   /* bar */
); /* PT  sub  btl des fre min  ten carr   */

/* attempt counters, array sizes, etc. */

uint
    MAX_ORE_TRIES = 10000;             /* big, to allow for large world */

uint
    MAX_TERRAIN_TRIES = 100,
    MAX_SANCTUARY_TRIES_OUTER = 100,
    MAX_SANCTUARY_TRIES_INNER = 100,
    MIN_SIZE = 4,                       /* minimum power of two world size */
    MAX_SIZE = 8,                       /* maxium power of two world size */
    MAX_COUNT = 1 << MAX_SIZE,          /* maximum dimension of world */
    COUNT_COUNT = 128;                  /* count of height counters */

[MAX_SIZE] uint

    /* values for Size = 4 */

    TERRAIN_RANGE_4 = (14, 18,  8,  2,  0,  0, 0, 0),
        ORE_RANGE_4 = ( 4,  4,  4,  2,  0,  0, 0, 0),

    /* values for Size = 5 */

    TERRAIN_RANGE_5 = (28, 14, 18,  8,  2,  0, 0, 0),
        ORE_RANGE_5 = ( 4,  4,  4,  4,  2,  0, 0, 0),

    /* values for Size = 6 */

    TERRAIN_RANGE_6 = (20, 28, 14, 18,  8,  2, 0, 0),
        ORE_RANGE_6 = ( 4,  4,  4,  4,  4,  2, 0, 0),

    /* values for Size = 7 */

    TERRAIN_RANGE_7 = (28, 20, 28, 14, 18,  8, 2, 0),
        ORE_RANGE_7 = ( 8,  8,  8,  8,  4,  4, 2, 0),

    /* values for Size = 8 */

    TERRAIN_RANGE_8 = (20, 20, 18, 16, 14, 12, 8, 2),
        ORE_RANGE_8 = ( 8,  8,  8,  8,  8,  4, 4, 2);

/*****************************************************************************/

type LineStatus_t = enum {l_eof, l_empty, l_ok};
type NumberStatus_t = enum {rn_eof, rn_empty, rn_error, rn_ok};

/* values used as bits to describe sectors being built */

byte
    CELL_WATER = 0b00,
    CELL_WILD  = 0b01,
    CELL_MOUNT = 0b10,
    CELL_SANCT = 0b11,
    CELL_TERR  = 0b11,
    CELL_IRON  = 1 << 2,
    CELL_GOLD  = 1 << 3,
    CELL_REACH = 1 << 4,
    CELL_TAKEN = 1 << 5;

uint BUFF_SIZE = 150;

/* general purpose globals */

[150] char Path;                        /* path to access files */
[BUFF_SIZE] char InputBuff, InputLine, OutputLine;
uint InputBuffMax, InputBuffPos, InputLinePos, OutputLinePos;
[150] char FileName;
Handle_t StdOut, StdIn, NameFd;
bool WindowOpen;                        /* true -> WorkBench window open */
bool NonShell;                          /* true -> not on standard shell */

ulong CountSq;                          /* need to force more accuracy */
uint Seed;                              /* seed for random number generator */
bool Alloced;                           /* true -> arrays allocated */

/* configurable variables and their defaults */

uint
    DEF_POWER_TWO = 5,
    PowerTwo,                           /* power of two size of world */
    Count,                              /* size of world */
    DEF_MOUNTAIN = 5,
    Mountain,                           /* desired percent of mountain */
    DEF_WILDERNESS = 38,
    Wilderness,                         /* desired percent of wilderness */
    DEF_IRON_LEVEL = 20,
    IronLevel,                          /* desired percent * 10 of good iron */
    DEF_GOLD_LEVEL = 20,
    GoldLevel,                          /* desired percent * 10 of good gold */
    DEF_MIN_DIST = 10,
    MinDist,                            /* minimum sanctuary separation */
    DEF_MIN_NEAR = 4,
    MinNear,                            /* minimum wilderness beside sanct */
    DEF_MIN_REACHABLE = 40,
    MinReachable,                       /* minimum wilderness per sanctuary */
    DEF_MAX_REACH = 15,
    MaxReach,                           /* they must be within this distance */
    DEF_MAX_IRON_SPREAD = 4,
    MaxIronSpread,                      /* maximum range of rich iron counts */
    DEF_MAX_GOLD_SPREAD = 4,
    MaxGoldSpread,                      /* maximum range of rich gold counts */
    DEF_GOOD_IRON_BASE = 32,
    GoodIronBase,                       /* minimum iron level in good */
    DEF_GOOD_IRON_RAND = 96,
    GoodIronRand,                       /* maximum iron bonus level in good */
    DEF_NORM_IRON_BASE = 0,
    NormIronBase,                       /* minimum iron level in normal */
    DEF_NORM_IRON_RAND = 96,
    NormIronRand,                       /* maximum iron bonus in normal */
    DEF_GOOD_GOLD_BASE = 32,
    GoodGoldBase,                       /* minimum gold level in good */
    DEF_GOOD_GOLD_RAND = 96,
    GoodGoldRand,                       /* maximum gold bonus level in good */
    DEF_NORM_GOLD_BASE = 0,
    NormGoldBase,                       /* minimum gold level in normal */
    DEF_NORM_GOLD_RAND = 96,
    NormGoldRand,                       /* maximum gold bonus in normal */
    DEF_INITIAL_MONEY = 5000,
    InitialMoney;                       /* initial money in each country */

/* arrays needed during terrain and mineral construction */

[MAX_SIZE] uint Range, TerrainRange, OreRange;

[MAX_COUNT] * [MAX_COUNT] int Cell;     /* array of pointers to array of int */

[COUNT_COUNT * 2] uint Counts;

[MAX_COUNT] * [MAX_COUNT] byte Bits;    /* array of pointers to array of byte*/

World_t World;
[COUNTRY_MAX] Country_t Country;

/*
 * flush - flush the output buffer.
 */

proc flush()void:

    if OutputLinePos ~= 0 then
        ignore Write(StdOut, &OutputLine[0], OutputLinePos);
        OutputLinePos := 0;
    fi;
corp;

/*
 * putChar - add a character to the output buffer.
 */

proc putChar(char ch)void:

    OutputLine[OutputLinePos] := ch;
    OutputLinePos := OutputLinePos + 1;
    if OutputLinePos = BUFF_SIZE or ch = '\n' then
        flush();
    fi;
corp;

/*
 * mess - output a string.
 */

proc mess(register *char p)void:

    while p* ~= '\e' do
        putChar(p*);
        p := p + sizeof(char);
    od;
corp;

/*
 * num - output a signed numeric value.
 */

proc num(register long n)void:
    [12] char buffer;
    register *char p;
    bool isNeg;

    if n >= 0 then
        n := -n;
        isNeg := false;
    else
        isNeg := true;
    fi;
    p := &buffer[11];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := '0' - make(n % 10, ushort);
        n := n / 10;
        n ~= 0
    do
    od;
    if isNeg then
        p := p - sizeof(char);
        p* := '-';
    fi;
    mess(p);
corp;

/*
 * random - return a random number 0 - passed range.
 */

proc random(uint rang)uint:

    if rang = 0 then
        0
    else
        Seed := Seed * 17137 + 4287;
        Seed := (Seed >> 8) >< (Seed << 8);
        Seed % rang
    fi
corp;

/*
 * set - set a given spot in Cell.
 */

proc set(uint l, c, size; register int height)void:
    uint rang;

    rang := Range[size];
    height := height + make(random(rang) - (rang + 1) / 2, int);
    Cell[l]*[c] := height;
    if height < - COUNT_COUNT then
        Counts[0] := Counts[0] + 1;
    elif height >= COUNT_COUNT then
        Counts[COUNT_COUNT * 2 - 1] := Counts[COUNT_COUNT * 2 - 1] + 1;
    else
        Counts[height + COUNT_COUNT] := Counts[height + COUNT_COUNT] + 1;
    fi;
corp;

/*
 * grow - grow the basic scenery heights.
 *      This routine is used to grow the terrain and the mineral deposits.
 */

proc grow()void:
    register uint l, c, c1, c2;
    uint i, step, nextStep, l1, l2;

    for i from COUNT_COUNT * 2 - 1 downto 0 do
        Counts[i] := 0;
    od;
    Cell[0]*[0] := 0;
    Counts[COUNT_COUNT] := 1;
    step := Count;
    for i from 0 upto PowerTwo - 1 do
        nextStep := step / 2;
        for l from 0 by step upto Count - 1 do
            l1 := l + nextStep;
            l2 := l + step;
            if l2 = Count then
                l2 := 0;
            fi;
            for c from 0 by step upto Count - 1 do
                c1 := c + nextStep;
                c2 := c + step;
                if c2 = Count then
                     c2 := 0;
                fi;
                set(l, c1, i, (Cell[l]*[c] + Cell[l]*[c2] + 1) / 2);
                set(l1, c, i, (Cell[l]*[c] + Cell[l2]*[c] + 1) / 2);
                set(l1, c1, i, (Cell[l]*[c] + Cell[l]*[c2] +
                                Cell[l2]*[c] + Cell[l2]*[c2] + 2) / 4);
            od;
        od;
        step := nextStep;
    od;
corp;

/*
 * fixTerrain - move levels to get the right proportions for terrain, and
 *              transfer info to Bits array. Return 'false' if we didn't
 *              come within 1% of our goals, and we will try again.
 */

proc fixTerrain()bool:
    register uint i, l, c;
    uint mountainFactor, wildernessFactor;
    uint mountainLevel, wildernessLevel;
    uint mountainSum, wildernessSum;
    int mountainDiff, wildernessDiff;

    mountainFactor := CountSq * Mountain / 100;
    wildernessFactor := CountSq * Wilderness / 100;
    i := COUNT_COUNT * 2 - 1;
    mountainSum := 0;
    while i ~= 0 and mountainSum < mountainFactor do
        mountainSum := mountainSum + Counts[i];
        i := i - 1;
    od;
    if mountainSum - mountainFactor >
            mountainFactor - (mountainSum - Counts[i]) and
        i ~= COUNT_COUNT * 2 - 1
    then
        i := i + 1;
    fi;
    mountainLevel := i - COUNT_COUNT;
    wildernessSum := 0;
    while i ~= 0 and wildernessSum < wildernessFactor do
        wildernessSum := wildernessSum + Counts[i];
        i := i - 1;
    od;
    if wildernessSum - wildernessFactor >
            wildernessFactor - (wildernessSum - Counts[i]) and
        i ~= COUNT_COUNT * 2 - 1
    then
        i := i + 1;
    fi;
    wildernessLevel := i - COUNT_COUNT;
    mountainSum := 0;
    wildernessSum := 0;
    for l from Count - 1 downto 0 do
        for c from Count - 1 downto 0 do
            Bits[l]*[c] :=
                if Cell[l]*[c] <= make(wildernessLevel, int) then
                    CELL_WATER
                elif Cell[l]*[c] > make(mountainLevel, int) then
                    mountainSum := mountainSum + 1;
                    CELL_MOUNT
                else
                    wildernessSum := wildernessSum + 1;
                    CELL_WILD
                fi;
        od;
    od;
    mountainDiff := mountainSum - mountainFactor;
    wildernessDiff := wildernessSum - wildernessFactor;
    mess("Mountains out by ");
    num(mountainDiff);
    mess(", wilderness out by ");
    num(wildernessDiff);
    mess(" out of ");
    num(CountSq / 100);
    mess("\n");
    make(| mountainDiff, uint) <= CountSq / 100 and
        make(| wildernessDiff, uint) <= CountSq / 100
corp;

/*
 * growTerrain - attempt to grow decent terrain. Return 'false' if fail.
 */

proc growTerrain()bool:
    register uint i;

    Range := TerrainRange;
    i := 0;
    while
        grow();
        if SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C ~= 0 then
            i := MAX_TERRAIN_TRIES;
        fi;
        not fixTerrain() and i ~= MAX_TERRAIN_TRIES
    do
        mess("Not good enough - retrying.\n");
        i := i + 1;
    od;
    i ~= MAX_TERRAIN_TRIES
corp;

/*
 * clearOre - clear the given ore type out of Bits - we need to regrow it.
 */

proc clearOre(register byte oreBit)void:
    register uint l, c;

    oreBit := ~oreBit;
    for l from Count - 1 downto 0 do
        for c from Count - 1 downto 0 do
            Bits[l]*[c] := Bits[l]*[c] & oreBit;
        od;
    od;
corp;

/*
 * fixOre - based on current Cell, set up the given ore type.
 */

proc fixOre(byte oreBit; uint targetLevel)uint:
    register uint oreSum;
    uint level, try;
    register uint i, l, c;
    uint oreLevel;

    level := CountSq * targetLevel / 1000;
    i := COUNT_COUNT * 2 - 1;
    oreSum := 0;
    while i ~= 0 and oreSum < level do
        oreSum := oreSum + Counts[i];
        i := i - 1;
    od;
    oreLevel := i - COUNT_COUNT;
    oreSum := 0;
    for l from Count - 1 downto 0 do
        for c from Count - 1 downto 0 do
            if Cell[l]*[c] >= make(oreLevel, int) and
                Bits[l]*[c] & CELL_TERR = CELL_WILD
            then
                Bits[l]*[c] := Bits[l]*[c] | oreBit;
                oreSum := oreSum + 1;
            fi;
        od;
    od;
    try := 0;
    if oreSum > level then
        while oreSum > level and try ~= MAX_ORE_TRIES do
            try := try + 1;
            l := random(Count);
            c := random(Count);
            if Bits[l]*[c] & oreBit ~= 0 then
                Bits[l]*[c] := Bits[l]*[c] & ~oreBit;
                oreSum := oreSum - 1;
            fi;
        od;
    else
        while oreSum < level and try ~= MAX_ORE_TRIES do
            try := try + 1;
            l := random(Count);
            c := random(Count);
            if Bits[l]*[c] & oreBit = 0 and Bits[l]*[c] & CELL_TERR = CELL_WILD
            then
                Bits[l]*[c] := Bits[l]*[c] | oreBit;
                oreSum := oreSum + 1;
            fi;
        od;
    fi;
    oreSum
corp;

/*
 * growOre - grow ore deposits of the given type.
 */

proc growOre(byte oreBit; uint targetLevel)void:
    register uint oreSum, try;
    uint level;
    register uint l, c;

    grow();
    /* grow half of the target level, do the other half randomly */
    oreSum := fixOre(oreBit, targetLevel / 2);
    level := CountSq * targetLevel / 2000;
    try := 0;
    while oreSum < level and try ~= MAX_ORE_TRIES do
        try := try + 1;
        l := random(Count);
        c := random(Count);
        if Bits[l]*[c] & oreBit = 0 and Bits[l]*[c] & CELL_TERR = CELL_WILD
        then
            Bits[l]*[c] := Bits[l]*[c] | oreBit;
            oreSum := oreSum + 1;
        fi;
    od;
corp;

/*
 * prev - return previous index, wrapping if needed.
 */

proc prev(uint i)uint:

    if i = 0 then Count - 1 else i - 1 fi
corp;

/*
 * next - return next index, wrapping if needed.
 */

proc next(uint i)uint:

    if i = Count - 1 then 0 else i + 1 fi
corp;

/*
 * isWild - return 'true' if the indicated cell is wilderness.
 */

proc isWild(uint r, c)bool:

    Bits[r]*[c] & CELL_TERR = CELL_WILD
corp;

/*
 * findSanctuaries - find free spaces to put sanctuaries.
 */

proc findSanctuaries()bool:
    register uint r, c, rt, ct;
    uint ironCount, goldCount, count;
    uint tryOuter, tryInner, i, c1, j, distance, d1, d2;
    uint rp, rn, ironMin, ironMax, goldMin, goldMax;
    int r2, c2;
    bool failed, tooClose, addedOne;

    Country[0].c_centerRow := 0;
    Country[0].c_centerCol := 0;
    tryOuter := 0;
    while
        failed := false;
        ironMin := range(uint);
        ironMax := 0;
        goldMin := range(uint);
        goldMax := 0;
        i := 1;
        while i ~= World.w_maxCountries and not failed do
            tryInner := 0;
            tooClose := true;
            while tooClose and tryInner ~= MAX_SANCTUARY_TRIES_INNER do
                tooClose := false;
                r := random(Count);
                c := random(Count);
                c1 := next(c);
/* #1 : sanctuaries must be both wildernesses */
                if isWild(r, c) and isWild(r, c1) then
                    for j from 1 upto i - 1 do
/* #2 : sanctuaries must be at least MinDist sectors apart */
                        d1 := (r + Count - Country[j].c_centerRow) % Count;
                        d2 := (Country[j].c_centerRow + Count - r) % Count;
                        rt := if d1 < d2 then d1 else d2 fi;
                        d1 := (c + Count - Country[j].c_centerCol) % Count;
                        d2 := (Country[j].c_centerCol + Count - c) % Count;
                        ct := if d1 < d2 then d1 else d2 fi;
                        if rt * rt + ct * ct < MinDist * MinDist then
                            tooClose := true;
                        else
/* #3 : sanctuaries must have at least MinNear neighbouring wildernesses */
                            rp := prev(r);
                            rn := next(r);
                            count := 0;
                            if isWild(rp, prev(c)) then
                                count := count + 1;
                            fi;
                            if isWild(rp, c) then
                                count := count + 1;
                            fi;
                            if isWild(rp, c1) then
                                count := count + 1;
                            fi;
                            if isWild(rp, next(c1)) then
                                count := count + 1;
                            fi;
                            if isWild(r, prev(c)) then
                                count := count + 1;
                            fi;
                            if isWild(r, next(c1)) then
                                count := count + 1;
                            fi;
                            if isWild(rn, prev(c)) then
                                count := count + 1;
                            fi;
                            if isWild(rn, c) then
                                count := count + 1;
                            fi;
                            if isWild(rn, c1) then
                                count := count + 1;
                            fi;
                            if isWild(rn, next(c1)) then
                                count := count + 1;
                            fi;
                            if count < MinNear then
                                tooClose := true;
                            fi;
                        fi;
                    od;
                else
                    tooClose := true;
                fi;
                tryInner := tryInner + 1;
                if SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C ~= 0 then
                    tryInner := MAX_SANCTUARY_TRIES_INNER;
                fi;
            od;
            if tooClose then
                mess(
"Sanctuaries too close together, or too few neighbouring wilderness sectors.\n"
                );
                failed := true;
            else
/* #4 : sanctuaries must have private access to MinReachable wildernesses
    within MaxReach distance */
                Bits[r]*[c] := Bits[r]*[c] | CELL_WILD | CELL_REACH;
                Bits[r]*[c1] := Bits[r]*[c1] | CELL_WILD | CELL_REACH;
                count := 2;
                addedOne := true;
                distance := 1;
                ironCount := 0;
                goldCount := 0;
                while count < MinReachable and addedOne and
                    distance <= MaxReach
                do
                    addedOne := false;
                    for r2 from r - distance upto r + distance do
                        rt :=
                            if r2 < 0 then
                                r2 + Count
                            elif r2 >= make(Count, int) then
                                r2 - Count
                            else
                                r2
                            fi;
                        for c2 from c - distance upto c + distance do
                            ct :=
                                if c2 < 0 then
                                    c2 + Count
                                elif c2 >= make(Count, int) then
                                    c2 - Count
                                else
                                    c2
                                fi;
                            if isWild(rt, ct) and
                                Bits[rt]*[ct] & (CELL_REACH|CELL_TAKEN) = 0 and
                                (Bits[prev(rt)]*[prev(ct)] & CELL_REACH ~= 0 or
                                 Bits[prev(rt)]*[     ct ] & CELL_REACH ~= 0 or
                                 Bits[prev(rt)]*[next(ct)] & CELL_REACH ~= 0 or
                                 Bits[     rt ]*[prev(ct)] & CELL_REACH ~= 0 or
                                 Bits[     rt ]*[next(ct)] & CELL_REACH ~= 0 or
                                 Bits[next(rt)]*[prev(ct)] & CELL_REACH ~= 0 or
                                 Bits[next(rt)]*[     ct ] & CELL_REACH ~= 0 or
                                 Bits[next(rt)]*[next(ct)] & CELL_REACH ~= 0)
                            then
                                Bits[rt]*[ct] := Bits[rt]*[ct] | CELL_REACH;
                                count := count + 1;
                                addedOne := true;
                                if Bits[rt]*[ct] & CELL_IRON ~= 0 then
                                    ironCount := ironCount + 1;
                                fi;
                                if Bits[rt]*[ct] & CELL_GOLD ~= 0 then
                                    goldCount := goldCount + 1;
                                fi;
                            fi;
                        od;
                    od;
                    distance := distance + 1;
                od;
                if count < MinReachable then
                    mess("Too few unclaimed reachable wildernesses.\n");
                    failed := true;
                else
                    if ironCount < ironMin then
                        ironMin := ironCount;
                    fi;
                    if ironCount > ironMax then
                        ironMax := ironCount;
                    fi;
                    if goldCount < goldMin then
                        goldMin := goldCount;
                    fi;
                    if goldCount > goldMax then
                        goldMax := goldCount;
                    fi;
                fi;
                distance := distance - 1;
                for r2 from r - distance upto r + distance do
                    rt :=
                        if r2 < 0 then
                            r2 + Count
                        elif r2 >= make(Count, int) then
                            r2 - Count
                        else
                            r2
                        fi;
                    for c2 from c - distance upto c + distance do
                        ct :=
                            if c2 < 0 then
                                c2 + Count
                            elif c2 >= make(Count, int) then
                                c2 - Count
                            else
                                c2
                            fi;
                        if Bits[rt]*[ct] & CELL_REACH ~= 0 then
                            Bits[rt]*[ct] := Bits[rt]*[ct] & ~CELL_REACH |
                                if failed then
                                    0
                                else
                                    CELL_TAKEN
                                fi;
                        fi;
                    od;
                od;
                if not failed then
                    Bits[r]*[c] := Bits[r]*[c] & ~CELL_TERR | CELL_SANCT;
                    Bits[r]*[c1] := Bits[r]*[c1] & ~CELL_TERR | CELL_SANCT;
                    Country[i].c_centerRow := r;
                    Country[i].c_centerCol := c;
                    i := i + 1;
                fi;
            fi;
        od;
        if not failed and tryOuter ~= MAX_SANCTUARY_TRIES_OUTER - 1 then
            if ironMax - ironMin > MaxIronSpread then
                mess("Rich iron spread too large - ");
                num(ironMin);
                mess(" vs ");
                num(ironMax);
                mess(" - regrowing.\n");
                clearOre(CELL_IRON);
                growOre(CELL_IRON, IronLevel);
                failed := true;
            fi;
            if goldMax - goldMin > MaxGoldSpread then
                mess("Rich gold spread too large - ");
                num(goldMin);
                mess(" vs ");
                num(goldMax);
                mess(" - regrowing.\n");
                clearOre(CELL_GOLD);
                growOre(CELL_GOLD, GoldLevel);
                failed := true;
            fi;
        fi;
        if SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C ~= 0 then
            tryOuter := MAX_SANCTUARY_TRIES_OUTER;
        fi;
        failed and tryOuter ~= MAX_SANCTUARY_TRIES_OUTER
    do
        /* need to undo any initial sanctuaries placed before failure */
        for r from Count - 1 downto 0 do
            for c from Count - 1 downto 0 do
                if isWild(r, c) or Bits[r]*[c] & CELL_TERR = CELL_SANCT then
                    Bits[r]*[c] :=
                        Bits[r]*[c] & ~(CELL_TERR | CELL_TAKEN) | CELL_WILD;
                fi;
            od;
        od;
        tryOuter := tryOuter + 1;
        if tryOuter ~= MAX_SANCTUARY_TRIES_OUTER then
            mess("Sanctuary placement failed, trying again.\n");
        fi;
    od;
    tryOuter ~= MAX_SANCTUARY_TRIES_OUTER
corp;

/*
 * initializeCountry - initialize the stats for a new user.
 */

proc initializeCountry(uint country)void:
    register uint i;
    register *Country_t c;

    c := &Country[country];
    c*.c_status := cs_idle;
    c*.c_techLevel := 0;
    c*.c_resLevel := 0;
    c*.c_sectorCount := 2;
    c*.c_money := InitialMoney;
    c*.c_btu := World.w_maxBTUs;
    c*.c_lastOn := 0;
    c*.c_timeLeft := World.w_maxConnect;
    for i from 0 upto REALM_MAX - 1 do
        c*.c_realms[i].r_top := -1;
        c*.c_realms[i].r_bottom := 1;
        c*.c_realms[i].r_left := -1;
        c*.c_realms[i].r_right := 2;
    od;
    c*.c_telegramsNew := 0;
    c*.c_telegramsTail := 0;
    for i from 0 upto COUNTRY_MAX - 1 do
        c*.c_relations[i] := r_neutral;
    od;
    for i from 0 upto 26 + 26 - 1 do
        c*.c_fleets[i] := NO_FLEET;
    od;
    c*.c_notify := nt_message;
    c*.c_loggedOn := false;
    c*.c_inChat := false;
    c*.c_compressed := false;
    c*.c_tmp2 := false;
corp;

/*
 * initializeSector - set up the stats for a sector.
 */

proc initializeSector(register *Sector_t s; register uint r, c)void:
    [4] SectorType_t DESIGS = (s_water, s_wilderness, s_mountain, s_sanctuary);
    register uint i;
    uint owner, c1;
    register ItemType_t it @ i;
    bool isSanctuary;

    isSanctuary := false;
    if Bits[r]*[c] & CELL_TERR = CELL_SANCT then
        c1 := prev(c);
        for i from 1 upto World.w_maxCountries - 1 do
            if Country[i].c_centerRow = r and
                (Country[i].c_centerCol = c or Country[i].c_centerCol = c1)
            then
                isSanctuary := true;
                owner := i;
            fi;
        od;
    fi;
    s*.s_lastUpdate := 0;
    s*.s_owner := if isSanctuary then owner else 0 fi;
    s*.s_iron :=
        if Bits[r]*[c] & CELL_IRON ~= 0 then
            random(GoodIronRand) + GoodIronBase
        else
            random(NormIronRand) + NormIronBase
        fi;
    s*.s_gold :=
        if Bits[r]*[c] & CELL_GOLD ~= 0 then
            random(GoodGoldRand) + GoodGoldBase
        else
            random(NormGoldRand) + NormGoldBase
        fi;
    s*.s_checkPoint := 0;
    s*.s_shipCount := 0;
    s*.s_quantity[it_civilians] := if isSanctuary then 64 else 0 fi;
    s*.s_quantity[it_military] := if isSanctuary then 64 else 0 fi;
    s*.s_type := DESIGS[Bits[r]*[c] & CELL_TERR];
    s*.s_production := 0;
    s*.s_mobility := if isSanctuary then 100 else 0 fi;
    s*.s_efficiency := if isSanctuary then 100 else 0 fi;
    s*.s_plagueStage := 0;
    s*.s_plagueTime := 0;
    for it from it_shells upto it_bars do
        s*.s_quantity[it] := 0;
    od;
    s*.s_quantity[it_ore] := if isSanctuary then 64 else 0 fi;
    s*.s_defender := NO_DEFEND;
    for it from it_first upto it_last do
        s*.s_direction[it] := NO_DELIVER;
        s*.s_threshold[it] := 0;
    od;
    s*.s_price := 0;
corp;

/*
 * cleanup - free our resources, then exit with the given status.
 */

proc cleanup(ulong status)void:
    uint i;

    if Alloced then
        for i from Count - 1 downto 0 do
            if Cell[i] ~= nil then
                FreeMem(Cell[i], Count * sizeof(int));
            fi;
            if Bits[i] ~= nil then
                FreeMem(Bits[i], Count * sizeof(byte));
            fi;
        od;
    fi;
    if NameFd ~= 0 then
        Close(NameFd);
    fi;
    if WindowOpen then
        Delay(5 * 50);
        Close(StdOut);
    fi;
    Exit(status);
corp;

/*
 * abort - print a message, then exit with an error return.
 */

proc abort(*char message)void:

    mess("*** ");
    mess(message);
    mess(" *** - aborting.\n");
    cleanup(RETURN_FAIL);
corp;

/*
 * getFileName - get the next file name from the name file. If the name file
 *      isn't open, use the passed name.
 */

proc getFileName(*char defName)void:
    register uint pos;

    if NameFd = 0 then
        CharsCopy(&FileName[0], &Path[0]);
        CharsConcat(&FileName[0], defName);
    else
        pos := 0;
        while Read(NameFd, &FileName[pos], 1) = 1 and FileName[pos] ~= '\n' do
            pos := pos + 1;
        od;
        if FileName[pos] ~= '\n' then
            abort("bad file name from name file");
        fi;
        FileName[pos] := '\e';
    fi;
corp;

/*
 * zapFile - delete and recreate the file whose name is in FileName.
 */

proc zapFile()void:
    Handle_t fd;

    DeleteFile(&FileName[0]);
    fd := Open(&FileName[0], MODE_NEWFILE);
    if fd = 0 then
        mess("Can't create ");
        mess(&FileName[0]);
        mess(".\n");
        cleanup(RETURN_FAIL);
    fi;
    Close(fd);
corp;

/*
 * newFile - delete and recreate the next file name in the name file.
 */

proc newFile(*char defName)void:

    getFileName(defName);
    zapFile();
corp;

/*
 * newEmptyFile - set up a new file that starts off empty.
 */

proc newEmptyFile(*char defName)void:

    newFile(defName);
    mess("Cleared ");
    mess(&FileName[0]);
    mess(".\n");
corp;

/*
 * clearFile - delete a file and say we are doing so.
 */

proc clearFile(*char fileName)void:

    CharsCopy(&FileName[0], &Path[0]);
    CharsConcat(&FileName[0], fileName);
    mess("Deleting ");
    mess(&FileName[0]);
    mess(":\n");
    DeleteFile(&FileName[0]);
corp;

/*
 * getLine - read an input line from standard input.
 *      RETURN: 0 - EOF, 1 - empty line, 2 - characters
 */

proc getLine()LineStatus_t:
    register uint pos;

    flush();
    pos := 0;
    while
        if InputBuffPos = InputBuffMax then
            InputBuffPos := 0;
            InputBuffMax := Read(StdIn, &InputBuff[0], BUFF_SIZE);
            if InputBuffMax = 0 then
                return(l_eof);
            fi;
        fi;
        InputLine[pos] := InputBuff[InputBuffPos];
        InputBuffPos := InputBuffPos + 1;
        InputLine[pos] ~= '\n' and pos ~= BUFF_SIZE - 1
    do
        pos := pos + 1;
    od;
    if InputLine[pos] ~= '\n' then
        l_eof
    else
        pos := 0;
        while InputLine[pos] = ' ' do
            pos := pos + 1;
        od;
        if InputLine[pos] = '\n' then
            l_empty
        else
            InputLinePos := pos;
            l_ok
        fi
    fi
corp;

/*
 * getPassword - read a password from the input.
 */

proc getPassword(*char prompt, buffer)void:
    char CSI = '\(0x9b)';
    register uint p;

    if IsInteractive(StdIn) then
        mess(prompt);
        if not NonShell then
            mess("\(CSI)30;40m");
        fi;
    fi;
    if getLine() = l_ok then
        p := 0;
        while p ~= PASSWORD_LEN - 1 and InputLine[p] ~= '\n' do
            buffer* := InputLine[p];
            buffer := buffer + sizeof(char);
            p := p + 1;
        od;
    fi;
    buffer* := '\e';
    if IsInteractive(StdIn) then
        if not NonShell then
            mess("\(CSI)31;40m");
        fi;
        flush();
    fi;
corp;

/*
 * writeFiles - create and write the empire data files.
 */

proc writeFiles()void:
    Handle_t fd;
    Sector_t s;
    register uint i, j;

    /* If we can't open "empire.files", we use some default names which will
       all be in the Path directory. */
    CharsCopy(&FileName[0], &Path[0]);
    CharsConcat(&FileName[0], "empire.files");
    NameFd := Open(&FileName[0], MODE_OLDFILE);

    /* log file */
    getFileName("RAM:empire.log");
    DeleteFile(&FileName[0]);

    /* world file */
    newFile("empire.world");
    fd := Open(&FileName[0], MODE_READWRITE);
    if fd = 0 then
        abort("can't open world file");
    fi;
    CharsCopy(&Country[0].c_name[0], "god");
    getPassword("Enter god password: ", &Country[0].c_password[0]);
    getPassword("Enter creation password: ", &World.w_password[0]);
    mess("Writing ");
    mess(&FileName[0]);
    mess(":\n");
    if Write(fd, &World, sizeof(World_t)) ~= sizeof(World_t) then
        Close(fd);
        abort("can't write world");
    fi;
    Close(fd);

    /* country file */
    newFile("empire.country");
    fd := Open(&FileName[0], MODE_READWRITE);
    if fd = 0 then
        abort("can't open country file");
    fi;
    mess("Writing ");
    mess(&FileName[0]);
    mess(":\n");
    for i from 0 upto COUNTRY_MAX - 1 do
        initializeCountry(i);
    od;
    Country[0].c_status := cs_deity;
    Country[0].c_timeLeft := 999;
    if Write(fd, &Country, sizeof(Country_t) * COUNTRY_MAX) ~=
            sizeof(Country_t) * COUNTRY_MAX
    then
        Close(fd);
        abort("can't write countries");
    fi;
    Close(fd);

    /* sector file */
    newFile("empire.sector");
    fd := Open(&FileName[0], MODE_READWRITE);
    if fd = 0 then
        abort("can't open sector file");
    fi;
    mess("Writing ");
    mess(&FileName[0]);
    mess(":\n");
    for i from 0 upto Count - 1 do
        for j from 0 upto Count - 1 do
            initializeSector(&s, i, j);
            if Write(fd, &s, sizeof(Sector_t)) ~= sizeof(Sector_t) then
                Close(fd);
                abort("can't write sector");
            fi;
        od;
    od;
    Close(fd);

    /* ship file */
    newEmptyFile("empire.ship");

    /* fleet file */
    newEmptyFile("empire.fleet");

    /* loan file */
    newEmptyFile("empire.loan");

    /* offer file */
    newEmptyFile("empire.offer");

    if NameFd ~= 0 then
        Close(NameFd);
        NameFd := 0;
    fi;

/*    clearFile(CONNECT_MESSAGE_FILE);
    clearFile(LOGIN_MESSAGE_FILE);
    clearFile(LOGOUT_MESSAGE_FILE); */ /* I have NO IDEA why you would */
    clearFile(BULLETIN_FILE);          /* want those files cleared, but*/
    clearFile(POWER_FILE);             /* if you really do.....        */

    mess("Writing telegram files:\n");
    CharsCopy(&FileName[0], &Path[0]);
    j := CharsLen(&Path[0]) + 10;
    CharsConcat(&FileName[0], "telegrams.XX");
    for i from 0 upto World.w_maxCountries - 1 do
        FileName[j] := i / 10 + '0';
        FileName[j + 1] := i % 10 + '0';
        zapFile();
    od;
    mess("\nEmpire world created!\n\n");
corp;

/*
 * readNumber - read an integer from the input.
 */

proc readNumber(*uint pNumber)NumberStatus_t:
    register int n;
    bool isNegative, hadDigit;

    case getLine()
    incase l_eof:
        rn_eof
    incase l_empty:
        rn_empty
    incase l_ok:
        if InputLine[InputLinePos] = '-' then
            InputLinePos := InputLinePos + 1;
            isNegative := true;
        else
            isNegative := false;
        fi;
        hadDigit := false;
        n := 0;
        while InputLine[InputLinePos] >= '0' and
            InputLine[InputLinePos] <= '9'
        do
            hadDigit := true;
            n := n * 10;
            n := n - (InputLine[InputLinePos] - '0');
            InputLinePos := InputLinePos + 1;
        od;
        if hadDigit then
            pNumber* := if isNegative then n else -n fi;
            rn_ok
        else
            rn_error
        fi
    esac
corp;

/*
 * repNum - get a value for an adjustable parameter.
 */

proc repNum(*char prompt; uint def, min, max)uint:
    register uint len, pos;
    uint n;
    bool isNeg;

    if IsInteractive(StdIn) then
        while
            mess(prompt);
            mess(" (");
            num(min);
            mess(" - ");
            num(max);
            mess(", def ");
            num(def);
            mess("): ");
            case readNumber(&n)
            incase rn_eof:
                cleanup(RETURN_ERROR);
                false
            incase rn_empty:
                n := def;
                false
            incase rn_error:
                mess("Invalid number, try again.\n");
                true
            incase rn_ok:
                if n < min then
                    mess("Value too small, try again.\n");
                    true
                elif n > max then
                    mess("Value too large, try again.\n");
                    true
                else
                    false
                fi
            esac
        do
        od;
    else
        case readNumber(&n)
        incase rn_eof:
        incase rn_empty:
        incase rn_error:
            mess("Couldn't read value for ");
            mess(prompt);
            mess(" - aborting.\n");
            cleanup(RETURN_ERROR);
        incase rn_ok:
            if n < min then
                mess("Value for ");
                mess(prompt);
                mess(" too small - aborting.\n");
                cleanup(RETURN_ERROR);
            elif n > max then
                mess("Value for ");
                mess(prompt);
                mess(" too large - aborting.\n");
                cleanup(RETURN_ERROR);
            fi;
        esac;
    fi;
    n
corp;

/*
 * ask - ask a question and return the boolean answer.
 */

proc ask(*char question)bool:
    register char ch;
    ushort status;

    if IsInteractive(StdIn) then
        while
            mess(question);
            case getLine()
            incase l_eof:
                cleanup(RETURN_ERROR);
                false
            incase l_empty:
                ch := 'y';
                false
            incase l_ok:
                ch := InputLine[InputLinePos];
                if ch = 'y' or ch = 'Y' or ch = 'n' or ch = 'N' then
                    false
                else
                    mess("Please answer with a y or an n.\n");
                    true
                fi
            esac
        do
        od;
    else
        case getLine()
        incase l_eof:
        incase l_empty:
            mess("Couldn't read answer for >");
            mess(question);
            mess("< - aborting.\n");
            cleanup(RETURN_ERROR);
        incase l_ok:
            ch := InputLine[InputLinePos];
            if ch ~= 'y' and ch ~= 'Y' and ch ~= 'n' and ch ~= 'N' then
                mess("Invalid answer for >");
                mess(question);
                mess("< - aborting.\n");
                cleanup(RETURN_ERROR);
            fi;
        esac
    fi;
    ch = 'y' or ch = 'Y'
corp;

/*
 * build - main routine of world building.
 */

proc build()void:
    DateStamp_t ds;
    register *World_t w;
    register uint i, j;

    InputBuffPos := 0;
    InputBuffMax := 0;
    OutputLinePos := 0;
    Alloced := false;
    NameFd := 0;
    w := &World;

    /* initialize adjustable parameters */

    PowerTwo := repNum("Power of two size of world", DEF_POWER_TWO,
                       MIN_SIZE, MAX_SIZE);
    Mountain := repNum("Percent mountain", DEF_MOUNTAIN, 0, 75);
    Wilderness :=
        repNum("Percent wilderness", DEF_WILDERNESS, 5, 99 - Mountain);
    IronLevel := repNum("Percent x 10 good iron", DEF_IRON_LEVEL, 0, 100);
    GoldLevel := repNum("Percent x 10 good gold", DEF_GOLD_LEVEL, 0, 100);
    w*.w_maxCountries := repNum(
            "Maximum number of countries (including deity)",
            case PowerTwo
            incase 4:
                3
            incase 5:
                7
            incase 6:
                16
            incase 7:
                COUNTRY_MAX
            incase 8:
                COUNTRY_MAX
            esac, 2, COUNTRY_MAX);
    MinDist := repNum("Minimum sanctuary spacing", DEF_MIN_DIST, 3, 100);
    MinNear := repNum("Minimum wilderness adjacent to sanctuary",
                      DEF_MIN_NEAR, 0, 10);
    MinReachable := repNum("Minimum unclaimed reachable sectors",
                           DEF_MIN_REACHABLE, MinNear, 200);
    MaxReach := repNum("Maximum distance for those sectors", DEF_MAX_REACH,
                       4, 100);
    MaxIronSpread := repNum("Maximum spread of rich iron counts",
                            DEF_MAX_IRON_SPREAD, 0, 1000);
    MaxGoldSpread := repNum("Maximum spread of rich gold counts",
                            DEF_MAX_GOLD_SPREAD, 0, 1000);
    GoodIronBase := repNum("Base level for good iron", DEF_GOOD_IRON_BASE,
                           0, 127);
    GoodIronRand := repNum("Maximum random addition for good iron",
                           DEF_GOOD_IRON_RAND, 1, 128);
    NormIronBase := repNum("Base level for normal iron", DEF_NORM_IRON_BASE,
                           0, 127);
    NormIronRand := repNum("Maximum random addition for normal iron",
                           DEF_NORM_IRON_RAND, 1, 128);
    GoodGoldBase := repNum("Base level for good gold", DEF_GOOD_GOLD_BASE,
                           0, 127);
    GoodGoldRand := repNum("Maximum random addition for good gold",
                           DEF_GOOD_GOLD_RAND, 1, 128);
    NormGoldBase := repNum("Base level for normal gold", DEF_NORM_GOLD_BASE,
                           0, 127);
    NormGoldRand := repNum("Maximum random addition for normal gold",
                           DEF_NORM_GOLD_RAND, 1, 128);
    w*.w_maxConnect := repNum(
            "Maximum connect time per day in minutes", 60, 1, 60 * 24);
    /* GACK! I want to use 60 * 60 * 24 = 86400, but that won't fit!!! */
    w*.w_secondsPerETU := repNum("Seconds per ETU", 1800, 1, 0xffff);
    InitialMoney := repNum("Initial amount of money per country",
                           DEF_INITIAL_MONEY, 0, 50000);
    if IsInteractive(StdIn) then
        mess("World last conquered by:");
    fi;
    i := 0;
    if getLine() = l_ok then
        while
           i ~= NAME_LEN - 1 and InputLine[i] ~= '\n'
        do
            w*.w_winName[i] := InputLine[i];
            i := i + 1;
        od;
    fi;
    w*.w_winName[i] := '\e';
    if ask("Allow public messages? (Y/N):") then
       w*.w_sendAll := true;
    else
       w*.w_sendAll := false;
    fi;
    if ask("Allow changing countries? (Y/N):") then
       w*.w_chaCou := true;
    else
       w*.w_chaCou := false;
    fi;

    /* By default, do NOT flush buffers after logging off  */
    w*.w_doFlush := false;
	/* By default, do NOT allow normal users to use the flush cmd */
	w*.w_userFlush := false;
	/* Set false just to be safe */
	w*.w_doingPower := false;

    /* initialize based on the selected world size */

    Count := 1 << PowerTwo;
    CountSq := make(Count, ulong) * Count;
    w*.w_rows := Count;
    w*.w_columns := Count;
    case PowerTwo
    incase 4:
        TerrainRange := TERRAIN_RANGE_4;
        OreRange := ORE_RANGE_4;
    incase 5:
        TerrainRange := TERRAIN_RANGE_5;
        OreRange := ORE_RANGE_5;
    incase 6:
        TerrainRange := TERRAIN_RANGE_6;
        OreRange := ORE_RANGE_6;
    incase 7:
        TerrainRange := TERRAIN_RANGE_7;
        OreRange := ORE_RANGE_7;
    incase 8:
        TerrainRange := TERRAIN_RANGE_8;
        OreRange := ORE_RANGE_8;
    esac;

    /* initialize and default various fields in the the World_t structure */

    w*.w_lastRun := GetCurrentTime();           /* last time Empire run */
    w*.w_buildDate := w*.w_lastRun;
    w*.w_currCountries := 1;                    /* only deity so far */
    w*.w_maxBTUs := 96;                         /* traditional default */

    w*.w_weather.we_update := 0;
    w*.w_weather.we_hiRowInc := 4 - random(9);
    w*.w_weather.we_hiColInc := 4 - random(9);
    w*.w_weather.we_loRowInc := 4 - random(9);
    w*.w_weather.we_loColInc := 4 - random(9);
    w*.w_weather.we_hiRow := random(Count * 4);
    w*.w_weather.we_hiCol := random(Count * 4);
    w*.w_weather.we_loRow := random(Count * 4);
    w*.w_weather.we_loCol := random(Count * 4);
    w*.w_weather.we_seed := Seed;
    w*.w_weather.we_hiPressure := random(6) + 5;
    w*.w_weather.we_loPressure := - (random(6) + 5);
    w*.w_weather.we_hiMin := 5;
    w*.w_weather.we_hiMax := 15;
    w*.w_weather.we_loMin := -15;
    w*.w_weather.we_loMax := -5;

    w*.w_loanNext := 0;                         /* none so far */
    w*.w_treatyNext := 0;
    w*.w_offerNext := 0;
    w*.w_shipNext := 0;
    w*.w_fleetNext := 0;

    w*.w_resCost := 25;
    w*.w_techCost := 25;
    w*.w_gunCost := 10;
    w*.w_shellCost := 2;
    w*.w_planeCost := 25;
    w*.w_barCost := 5;

    w*.w_mountMob := 30;
    w*.w_wildMob := 2;
    w*.w_defMob := 1;
    w*.w_civMob := 1;
    w*.w_milMob := 1;
    w*.w_shellMob := 2;
    w*.w_gunMob := 2;
    w*.w_planeMob := 4;
    w*.w_oreMob := 1;
    w*.w_barMob := 10;

    w*.w_plagueKiller := 227;
    w*.w_plagueBooster := 100;
    w*.w_plagueOneBase := 32;
    w*.w_plagueOneRand := 33;
    w*.w_plagueTwoBase := 32;
    w*.w_plagueTwoRand := 33;
    w*.w_plagueThreeBase := 32;
    w*.w_plagueThreeRand := 33;

    w*.w_efficCost := 1;
    w*.w_milSuppliesCost := 8;
    w*.w_utilityRate := 1;
    w*.w_interestRate := 12;
    w*.w_bridgeCost := 2000;
    w*.w_shipCostMult := 9;
    w*.w_refurbCost := 1;

    w*.w_resScale := 100;
    w*.w_techScale := 100;
    w*.w_defenseScale := 100;
    w*.w_shellScale := 100;
    w*.w_airportScale := 100;
    w*.w_harborScale := 100;
    w*.w_bridgeScale := 100;
    w*.w_goldScale := 100;
    w*.w_ironScale := 100;
    w*.w_shipWorkScale := 100;

    w*.w_efficScale := 100;
    w*.w_mobilScale := 100;
    w*.w_urbanGrowthFactor := 100;
    w*.w_bridgeDieFactor := 400;
    w*.w_highGrowthFactor := 200;
    w*.w_lowGrowthFactor := 400;
    w*.w_BTUDivisor := 5000;
    w*.w_resDecreaser := 10;
    w*.w_techDecreaser := 10;
    w*.w_hurricaneLandBase := 70;
    w*.w_hurricaneLandRand := 21;
    w*.w_hurricaneSeaBase := 10;
    w*.w_hurricaneSeaRand := 21;

    w*.w_assFortAdv := 2;
    w*.w_assCapAdv := 2;
    w*.w_assBankAdv := 1;
    w*.w_attFortAdv := 4;
    w*.w_attCapAdv := 2;
    w*.w_attBankAdv := 2;
    w*.w_assAdv := 125;
    w*.w_fortAdv := 2;
    w*.w_boardAdv := 125;

    w*.w_torpCost := 3;
    w*.w_torpMobCost := 5;
    w*.w_torpRange := 4;
    w*.w_torpAcc0 := 90;
    w*.w_torpAcc1 := 50;
    w*.w_torpAcc2 := 20;
    w*.w_torpAcc3 := 5;
    w*.w_torpBase := 21;
    w*.w_torpRand := 38;
    w*.w_chargeCost := 2;
    w*.w_chargeMobCost := 5;
    w*.w_chargeBase := 30;
    w*.w_chargeRand := 11;
    w*.w_mineBase := 20;
    w*.w_mineRand := 10;

    w*.w_fuelTankSize := 32;
    w*.w_fuelRichness := 4;
    w*.w_flakFactor := 7;
    w*.w_landScale := 100;
    w*.w_bombBase := 13;
    w*.w_bombRand := 10;
    w*.w_planeBase := 7;
    w*.w_planeRand := 10;

    w*.w_contractScale := 100;
    w*.w_deathFactor := 15;
    w*.w_gunMax := 12;
    w*.w_rangeDivisor := 100;
    w*.w_gunScale := 100;
    w*.w_lookShipFact := 2036;
    w*.w_collectScale := 100;
    w*.w_radarFactor := 61;
    w*.w_spyFactor := 150;
    w*.w_shipTechDecreaser := 10;

    w*.w_nonDeityPower := true;
    w*.w_sortCountries := true;

    w*.w_attackMobilityCost := ATTACK_MOBILITY_COST;

    w*.w_shipCost := SHIP_COST;
    w*.w_shipSize := SHIP_SIZE;
    w*.w_shipRange := SHIP_RANGE;
    w*.w_shipSpeed := SHIP_SPEED;
    w*.w_shipShRange := SHIP_SH_RANGE;
    w*.w_shipDamage := SHIP_DAMAGE;
    w*.w_shipCapacity := SHIP_CAPACITY;

    /* set up the random number generator seed */

    DateStamp(&ds);
    Seed := (ds.ds_Minute >< ds.ds_Tick) | 1;

    /* now go create the world */

    mess("Growing terrain:\n");
    for i from Count - 1 downto 0 do
        Cell[i] := nil;
        Bits[i] := nil;
    od;
    Alloced := true;
    for i from Count - 1 downto 0 do
        Cell[i] := AllocMem(Count * sizeof(int), 0);
        if Cell[i] = nil then
            mess("Can't allocate memory for 'Cell' - aborting.\n");
            cleanup(RETURN_FAIL);
        fi;
        Bits[i] := AllocMem(Count * sizeof(byte), 0);
        if Bits[i] = nil then
            mess("Can't allocate memory for 'Bits' - aborting.\n");
            cleanup(RETURN_FAIL);
        fi;
        for j from Count - 1 downto 0 do
            Bits[i]*[j] := 0;
        od;
    od;
    if growTerrain() then

        /* terrain grown - grow rich ore deposits */

        mess("Growing iron ore deposits:\n");
        Range := OreRange;
        growOre(CELL_IRON, IronLevel);
        mess("Growing gold ore deposits:\n");
        growOre(CELL_GOLD, GoldLevel);

        /* rich ore grown - try to place sanctuaries */

        mess("Placing sanctuaries:\n");
        if findSanctuaries() then

            /* world created - display it if requested */

            if ask("Display the resulting terrain? ") then
                for i from 0 upto Count - 1 do
                    for j from 0 upto Count - 1 do
                        mess(
                            case Bits[i]*[j] & CELL_TERR
                            incase CELL_MOUNT:
                                "^"
                            incase CELL_WATER:
                                "."
                            incase CELL_SANCT:
                                "s"
                            incase CELL_WILD:
                                if Bits[i]*[j] & CELL_GOLD ~= 0 then
                                    if Bits[i]*[j] & CELL_IRON ~= 0 then
                                        "X"
                                    else
                                        "G"
                                    fi
                                elif Bits[i]*[j] & CELL_IRON ~= 0 then
                                    "I"
                                else
                                    "-"
                                fi
                            esac
                        );
                    od;
                    mess("\n");
                od;
            fi;

            /* write out all the files if so requested */

            if ask("Write world data files? ") then
                writeFiles();
            fi;
            cleanup(RETURN_OK);

        else
            mess("Can't place sanctuaries - giving up.\n");
            cleanup(RETURN_WARN);
        fi;

    else
        mess("Can't grow terrain - giving up.\n");
        cleanup(RETURN_WARN);
    fi;
corp;

/*
 * fmtNum - little utility for 'openWindow'.
 */

proc fmtNum(*char desc; register uint n)void:
    register *char p;
    [6] char buffer;

    p := &buffer[5];
    p* := '\e';
    while
        p := p - sizeof(char);
        p* := n % 10 + '0';
        n := n / 10;
        n ~= 0
    do
    od;
    CharsConcat(desc, p);
corp;

/*
 * openWindow - open an appropriate window for WorkBench startup.
 */

proc openWindow(*Process_t thisProcess)bool:
    register *GfxBase_t gfxBase;
    register *View_t v;
    *Window_t saveWindow;
    uint rows, cols;
    [100] char windowDesc;

    rows := 200;
    cols := 640;
    gfxBase := OpenGraphicsLibrary(0);
    if gfxBase ~= nil then
        rows := gfxBase*.gb_NormalDisplayRows;
        cols := gfxBase*.gb_NormalDisplayColumns;
        v := gfxBase*.gb_ActiView;
        if v ~= nil and v*.v_Modes & LACE ~= 0 then
            rows := rows * 2;
        fi;
        CloseGraphicsLibrary();
    fi;
    CharsCopy(&windowDesc[0], "NEWCON:0/0/");
    fmtNum(&windowDesc[0], cols);
    CharsConcat(&windowDesc[0], "/");
    fmtNum(&windowDesc[0], rows);
    CharsConcat(&windowDesc[0],
        "/EmpCre 2.2w by Chris Gray & David Wright {newcon:}");
    saveWindow := thisProcess*.pr_WindowPtr;
    thisProcess*.pr_WindowPtr := pretend(-1, *Window_t);
    StdOut := Open(&windowDesc[0], MODE_NEWFILE);
    thisProcess*.pr_WindowPtr := saveWindow;
    if StdOut = 0 then
        CharsCopy(&windowDesc[0], "CON:0/0/");
        fmtNum(&windowDesc[0], cols);
        CharsConcat(&windowDesc[0], "/");
        fmtNum(&windowDesc[0], rows);
        CharsConcat(&windowDesc[0],
            "/EmpCre 2.2w by Chris Gray & David Wright {con:}");
        StdOut := Open(&windowDesc[0], MODE_NEWFILE);
    fi;
    StdOut ~= 0
corp;

/*
 * useage - print a CLI useage message.
 */

proc useage()void:

    mess("Use is: EmpCre [-a]\n");
corp;

/*
 * main - open libraries and windows, etc.
 */

proc main()void:
    extern _d_pars_initialize()void;
    *char par;
    *Process_t thisProcess;
    *WBStartup_t sm;
    register *WBArg_t wa;
    register Lock_t oldDir;
    register *DiskObject_t dob;
    register *char value;
    bool hadError, doneRun;

    if OpenExecLibrary(0) ~= nil then
        if OpenDosLibrary(0) ~= nil then
            CharsCopy(&Path[0], DEFAULT_PATH);
            NonShell := false;
            thisProcess := pretend(FindTask(nil), *Process_t);
            if thisProcess*.pr_CLI = 0 then
                /* running from WorkBench */
                if OpenIconLibrary(0) ~= nil then
                    ignore WaitPort(&thisProcess*.pr_MsgPort);
                    doneRun := false;
                    sm := pretend(GetMsg(&thisProcess*.pr_MsgPort),
                                  *WBStartup_t);
                    wa := sm*.sm_ArgList;
                    if wa ~= nil then
                        if sm*.sm_NumArgs <= 1 then
                            if wa*.wa_Lock ~= 0 then
                                oldDir := CurrentDir(wa*.wa_Lock);
                                if wa*.wa_Name ~= nil and
                                    wa*.wa_Name* ~= '\e' and
                                    wa*.wa_Name* ~= ' '
                                then
                                    dob := GetDiskObject(wa*.wa_Name);
                                    if dob ~= nil then
                                        value :=
                                            FindToolType(dob*.do_ToolTypes,
                                                         "PATH");
                                        if value ~= nil then
                                            CharsCopy(&Path[0], value);
                                        fi;
                                        FreeDiskObject(dob);
                                    fi;
                                fi;
                                
                                ignore CurrentDir(oldDir);
                            fi;
                        else
                            wa := wa + sizeof(WBArg_t);
                            if wa*.wa_Lock ~= 0 then
                                oldDir := CurrentDir(wa*.wa_Lock);
                                if wa*.wa_Name ~= nil and
                                    wa*.wa_Name* ~= '\e' and
                                    wa*.wa_Name* ~= ' '
                                then
                                    dob := GetDiskObject(wa*.wa_Name);
                                    if dob ~= nil then
                                        value :=
                                            FindToolType(dob*.do_ToolTypes,
                                                         "PATH");
                                        if value ~= nil then
                                            CharsCopy(&Path[0], value);
                                        fi;
                                        FreeDiskObject(dob);
                                    fi;
                                    if openWindow(thisProcess) then
                                        WindowOpen := true;
                                        StdIn :=
                                            Open(wa*.wa_Name, MODE_OLDFILE);
                                        if StdIn ~= 0 then
                                            build();
                                            Close(StdIn);
                                            doneRun := true;
                                        fi;
                                        Close(StdOut);
                                    fi;
                                fi;
                                ignore CurrentDir(oldDir);
                            fi;
                        fi;
                    fi;
                    if not doneRun and openWindow(thisProcess) then
                        WindowOpen := true;
                        StdIn := StdOut;
                        build();
                        Close(StdOut);
                    fi;
                    Forbid();
                    ReplyMsg(&sm*.sm_Message);
                    CloseIconLibrary();
                fi;
            else
                /* running from CLI */
                StdOut := Output();
                _d_pars_initialize();
                hadError := false;
                while
                    par := GetPar();
                    par ~= nil
                do
                    if par* = '-' then
                        par := par + sizeof(char);
                    fi;
                    while par* ~= '\e' do
                        case par*
                        incase 'a':
                            NonShell := true;
                        default:
                            hadError := true;
                        esac;
                        par := par + sizeof(char);
                    od;
                od;
                if hadError then
                    useage();
                else
                    StdIn := Input();
                    WindowOpen := false;
                    build();
                fi;
            fi;
            CloseDosLibrary();
        fi;
        CloseExecLibrary();
    fi;
corp;
