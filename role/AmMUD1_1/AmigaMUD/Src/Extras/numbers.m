/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * numbers.m - code for English numbers.
 */

private proc utility units(int n)string:
    string s;

    s := SubString(
	    "*****"
	    "one  "
	    "two  "
	    "three"
	    "four "
	    "five "
	    "six  "
	    "seven"
	    "eight"
	    "nine ",
	    n * 5, 5);
    Trim(s)
corp;

private proc utility hundreds(int n)string:
    string s;

    s := "";
    if n >= 100 then
	s := units(n / 100) + " hundred";
	n := n % 100;
	if n ~= 0 then
	    s := s + " and ";
	fi;
    fi;
    if n >= 20 then
	s := s + Trim(SubString(
			"twenty "
			"thirty "
			"forty  "
			"fifty  "
			"sixty  "
			"seventy"
			"eighty "
			"ninety ",
			(n / 10 - 2) * 7, 7));
	n := n % 10;
	if n ~= 0 then
	    s := s + " ";
	fi;
    elif n >= 10 then
	s := s + Trim(SubString(
			"ten      "
			"eleven   "
			"twelve   "
			"thirteen "
			"fourteen "
			"fifteen  "
			"sixteen  "
			"seventeen"
			"eighteen "
			"nineteen ",
			(n - 10) * 9, 9));
	n := 0;
    fi;
    if n ~= 0 then
	s := s + units(n);
    fi;
    s
corp;

public proc utility EnglishNumber(int n)string:
    string s;
    int frac;
    bool needComma;

    if n = 0 then
	"zero"
    else
	if n < 0 then
	    s := "minus ";
	    n := -n;
	else
	    s := "";
	fi;
	needComma := false;
	frac := n / 1000000000;
	if frac ~= 0 then
	    s := s + hundreds(frac) + " billion";
	    needComma := true;
	    n := n % 1000000000;
	fi;
	frac := n / 1000000;
	if frac ~= 0 then
	    if needComma then
		s := s + ", ";
	    fi;
	    s := s + hundreds(frac) + " million";
	    needComma := true;
	    n := n % 1000000;
	fi;
	frac := n / 1000;
	if frac ~= 0 then
	    if needComma then
		s := s + ", ";
	    fi;
	    s := s + hundreds(frac) + " thousand";
	    needComma := true;
	    n := n % 1000;
	fi;
	if n ~= 0 then
	    if needComma then
		s := s + if n >= 100 then ", " else " and " fi;
	    fi;
	    s := s + hundreds(n);
	fi;
	s
    fi
corp;
