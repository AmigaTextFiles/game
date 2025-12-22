#!/usr/bin/perl -w
# Stupid little script to change *nix text into CRLF text
# (that *is* what dos + windows use, right?)
while(<>) {
 s/\n/\r\n/gs;
 print"$_";
}
