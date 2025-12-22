
/* AddCommas.rexx - add a comma to each line of a text file */

parse arg filename
if ~open('infile',filename,'r') then do
        say "Sorry, can't read" filename "."
        exit
end
call open('outfile',"T:OUTPUT",'w')
line=readln('infile')
do while ~eof('infile')
        line=line","
        call writeln('outfile',line)
        line=readln('infile')
end
call close('infile')
call close('outfile')

address command "copy T:OUTPUT to" filename
address command "delete >nil: T:OUTPUT"

exit
/* end of listing */
