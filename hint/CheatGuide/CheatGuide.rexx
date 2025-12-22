/*                                                                */
/* Arexx program to create Amiga Games Cheats AmigaGuide database */
/*                                                                */
/* Written by: Dave Lowrey - dwl10@juts.ccc.amdahl.com            */
/*                                                                */
/* Usage: rx CheatGuide infile outfile                            */
/*        infile = The amiga cheats list, edited so that the      */
/*                 line is the name of the first program, and all */
/*                 lines that start out with "_______", other     */
/*                 than the ones separating the program names,    */
/*                 have been deleted.                             */
/*        outfile = The name of the AmigaGuide file that will     */
/*                  contain the output from this program          */
/*                                                                */
/* Also requires that the AmigaDos commands "join" and "delete"   */
/* be available.                                                  */
/*                                                                */
/* Version 1.0 - April 6, 1993                                    */
/*                                                                */

tempfilename = "T:cgtemp1"     /* move to disk if you are short on ram */
tempfile2name = "T:cgtemp2"    /* same for this one */
seperator = "______"           /* string that seperates programs in list */

parse arg infile outfile

infilename=strip(infile)
outfilename=strip(outfile)

if length(infilename) = 0 then do
	say "usage: CheatGuide infile tempfile2"
	exit
end
if length(outfilename) = 0 then do
	say "usage: CheatGuide infile outfile"
	exit
end

if ~open(tempfile, tempfilename, 'w') then do
	say "Error opening temp file"
	exit
end

if ~open(tempfile2, tempfile2name, 'w') then do
	say "Error opening temp file 2"
	address command "delete" tempfilename "quiet"
	exit
end

if ~open(infile, infile, 'r') then do
	say "Error opening input file"
	exit
end

count = 1
do forever
	line = readln(infile)
	if eof(infile) then break
	line = strip(line)
	line = compress(line, ":")
	if length(line) > 0 then do
		TITLE.count = line
		line = '@node "'TITLE.count'"'
		z = writeln(tempfile, line)
		z = writeln(tempfile, TITLE.count)
		count = count + 1
		do forever
			line = readln(infile)
			if eof(infile) then break
			if substr(line,1,6) = seperator then break
			z = writeln(tempfile, line)
		end
		z = writeln(tempfile,'@endnode')
	end
end
z=close(infile)
z=close(tempfile)

z=writeln(tempfile2, '@database "cheats.guide"')
z=writeln(tempfile2, '@remark')
z=writeln(tempfile2, '@remark Database created by CheatGuide.rexx')
z=writeln(tempfile2, '@remark CheatGuide.rexx written by Dave Lowrey')
z=writeln(tempfile2, '@remark dwl10@juts.ccc.amdahl.com')
z=writeln(tempfile2, '@remark')
z=writeln(tempfile2, '@master "cheats"')
z=writeln(tempfile2, '@node Main "Amiga Game Cheats Guide by D. Lowrey"')
z=writeln(tempfile2, " ");
z=writeln(tempfile2, "Table of Contents:")
z=writeln(tempfile2, " ")

do i=1 to count-1
	line = '        @{"'TITLE.i'" link "'TITLE.i'"}'
	z=writeln(tempfile2, line)
end

z=writeln(tempfile2, '@endnode')
z=close(tempfile2)

address command "join" tempfile2name tempfilename "as" outfile
address command "delete" tempfilename tempfile2name "quiet"
