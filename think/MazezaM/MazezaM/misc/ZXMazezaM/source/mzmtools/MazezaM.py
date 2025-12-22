# MazezaM.py - classes for storing mazezams and parsing .mzm files.
#              Can output the mazezams in .mzm and ZXBasic format.
#
# Copyright (C) 2002 Malcolm Tyrrell
# tyrrelmr@cs.tcd.ie
#
# This code may be used and distributed under the terms of the GNU General
# Public Licence.

import string

def mazezamline(line):
    "returns true if the provided string is a mazezam line"
    if line == "\n":
        return 0
    for c in line:
        if c not in [' ','#','$','+','*','\n']:
            return 0
    return 1

def horizwall(line):
    "returns true if the provided string consists only of the character '#'"
    for c in line:
        if c not in ['#']:
            return 0
    return 1

class MZMParseError (Exception):
    "Class of errors raised when a .mzm file has incorrect syntax"
    def __init__(self,lineno,msg,filename="?"):
        self.filename = filename
        self.msg = msg
        self.lineno = lineno

    def __str__(self):
        return ("Parse error in file "+self.filename
            +", line "+str(self.lineno)
            +". "+self.msg)


class Mazezam:
    "A class which store a single mazezam"
    #
    # Currently, the interior of the mazezam is stored as strings exactly
    # as in the .mzm format.
    #
    def __init__(self,title="",author=""):
        self.lines  = []
        self.title  = title
        self.author = author
        self.height = 0
        self.width  = 0
        self.leftExit  = 0
        self.rightExit  = 0

    def appendMZMLine(self,line):
        if horizwall(line):
            self.width = len(line)-2
        else:
            self.height = self.height + 1
            self.lines.append(line[1:-1])
            if line[0] == '+':
                self.leftExit = self.height
            if line[len(line)-1] == '*':
                self.rightExit = self.height

    def empty(self):
        "returns true if the mazezam is empty"
        return self.lines == []
    
    def write2zxbas(self,outfile):
        "writes the mazezam to the file as two ZX Basic DATA statements"
        outfile.write('  DATA "'+self.title+'","\*')
        outfile.write(self.author+'",')
        outfile.write(str(self.width)+','+str(self.height)+',')
        outfile.write(str(self.leftExit)+','+str(self.rightExit)+'\n')
        outfile.write('  DATA "')
        for l in self.lines[:-1]:
            self.line2zxbas(l,outfile)
            outfile.write('","')
        self.line2zxbas(self.lines[-1],outfile)
        outfile.write('"\n')

    def line2zxbas(self,l,outfile):
        "writes a line of the mazezam in ZX Basic to the file"
        cold1 = l[0]
        cold2 = ' '
        for c in l[1:]:
            if cold1==' ':
                outfile.write(" ")
            elif cold2==' ' and cold1=='$' and c=='$':
                outfile.write("\\c")
            elif cold2=='$' and cold1=='$' and c=='$':
                outfile.write("\\d")
            elif cold2=='$' and cold1=='$' and c==' ':
                outfile.write("\\e")
            else:
                outfile.write("\\b")
            cold2 = cold1
            cold1 = c
        c = l[-1]
        cold1 = l[-2]
        if c==' ':
            outfile.write(" ")
        elif cold1=='$' and c=='$':
            outfile.write("\\e")
        else:
            outfile.write("\\b")

    def write2mzm(self,outfile):
        "writes the mazezam to the file in .mzm format"
        if self.title != "":
	    outfile.write(";;Title: "+self.title+"\n")
        if self.author != "":
	    outfile.write(";;Author: "+self.author+"\n")
	outfile.write(("#"*self.width)+"##\n")
        for i in range(self.height):
            if i == self.leftExit-1:
                outfile.write("+")
            else:
                outfile.write("#")
            outfile.write(self.lines[i])
            if i == self.rightExit-1:
                outfile.write("*\n")
            else:
                outfile.write("#\n")
	outfile.write(("#"*self.width)+"##\n\n")


class MazezamList:
    "stores a list of mazezams"
    # mazezams = [Mazezam]
    # maxwidth = int
    # maxheight = int

    def __init__(self):
        self.mazezams = []
        self.maxwidth = 0
        self.maxheight = 0

    def __len__(self):
        "returns the number of mazezams in the mazezam list"
        return len(self.mazezams)

    def __getitem__(self,key):
        "returns a specific mazezam in the mazezam list"
        return self.mazezams[key]

    def append(self,newmazezam):
        "adds a mazezam to the end of the mazezam list"
        if newmazezam.width > self.maxwidth:
            self.maxwidth = newmazezam.width
        if newmazezam.height > self.maxheight:
            self.maxheight = newmazezam.height
        self.mazezams.append(newmazezam)

    def readFromMZMLines(self,mzmlines):
        "parses the file for mazezams"
	# can raise a MZMParseError (and other more typical errors)
        lineno = 0
        mazezam = Mazezam()
        for line in mzmlines:
            lineno = lineno + 1
            title = ""
            author = ""
            if mazezamline(line):
                mazezam.appendMZMLine(string.strip(line))
            else:
                if not mazezam.empty():
                    self.append(mazezam)
                    title = mazezam.title
                    author = mazezam.author
                    mazezam = Mazezam(title, author)
                if string.upper(line[:9]) == ";;TITLE: ":
                    if len(line)-10 <= 28:
                        mazezam.title = line[9:-1]
                    else:
                        raise MZMParseError(lineno,"Title string too long.")
                elif string.upper(line[:10]) == ";;AUTHOR: ":
                    mazezam.author = line[10:-1]    
                elif string.upper(line[:11]) == ";;VERSION: ":
	    	    if string.strip(line[11:]) != "1":
                        raise MZMParseError(lineno,"This program can only handle version 1 mazezams.")
                elif line == "\n":
                    pass
                elif line[0:1] == ";":
                    pass
                else: raise MZMParseError(lineno,"Invalid line.")
        if not mazezam.empty():
	    self.append(mazezam)

    def write2zxbas(self,outfile):
        "writes all the mazezams to the file in ZX Basic as DATA statements"
        outfile.write("@MAZEVALUES: REM ** Maze Values **\n")
        outfile.write("  DATA "+str(len(self.mazezams)))
        outfile.write(","+str(self.maxwidth))
	outfile.write(","+str(self.maxheight)+"\n")
        outfile.write("@MAZEDATA: REM ** Maze Data **\n")
        for m in self.mazezams:
            m.write2zxbas(outfile)

    def write2mzm(self,outfile):
        "writes all the mazezams to the file in .mzm format"
        outfile.write(";;Version: 1\n\n")
        for m in self.mazezams:
            m.write2mzm(outfile)
