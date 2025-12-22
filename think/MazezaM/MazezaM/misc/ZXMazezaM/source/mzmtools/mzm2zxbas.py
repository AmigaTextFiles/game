# mzm2zxbas.py - parses MazezaM .mzm files and writes the mazezams in ZXBasic
#                to standard out.
#
# Copyright (C) 2002 Malcolm Tyrrell
# tyrrelmr@cs.tcd.ie
#
# This code may be used and distributed under the terms of the GNU General
# Public Licence.

from MazezaM import MazezamList, MZMParseError
from sys import argv, stderr, stdout, exit

# make sure that there are files to parse

if len(argv) < 2:
    stderr.write("mzm2zxbas.py: please provide a filename\n")
    exit(1)

# create the MazezamList to hold the mazezams

mazezamList = MazezamList()

# for all the filenames provided on the command-line, open each file, parse
# it into mazezamList and close it.

for filename in argv[1:]:
    try:
        input = open(filename,'r')
    except:
        stderr.write("mzm2zxbas.py: cannot open input file "+filename+"\n")
        exit(2)
    try:
        mazezamList.readFromMZMLines(input.readlines())
    except MZMParseError, thatError:
        thatError.filename = filename
	stderr.write("mzm2zxbas.py: "+str(thatError)+"\n")
	exit(3)
    input.close()

mazezamList.write2zxbas(stdout)
