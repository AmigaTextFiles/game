private proc IntToHex(int n)string:
    string s;
    int i;

    s := "0x";
    for i from 0 upto 7 do
	s := s + SubString("0123456789abcdef", n >> (28 - i * 4) & 0xf, 1);
    od;
    s
corp;

private proc IntToBin(int n)string:
    string s;
    int i;

    s := "0b";
    for i from 0 upto 31 do
	s := s + SubString("01", n >> (31 - i) & 0b1, 1);
    od;
    s
corp;
