
/*
   compile_shipnames.rexx - read the given text file of ship names and
   translate them into a form more easily digestible by Invasion Force
*/

parse arg filename
if filename='' then
   filename='ship_names.text'
if ~open('infile',filename,'r') then do
   say "Sorry, can't read" filename "."
   exit
end
line=readln('infile')
fileopen=0
do while ~eof('infile')
   if left(line,1)='*' then do
      if fileopen then
         call close('outfile')
      line='NAMES.'||right(line,length(line)-1)
      say 'Processing' line
      if exists(line) then
         address command "delete >nil: "||line
      fileopen=open('outfile',line,'w')
   end
   else
      if fileopen then do
         say '   '||line
         call writeln('outfile',substr(line,1,19,'00'X))
      end
   line=readln('infile')
end
if fileopen then
   call close('outfile');
say 'Processing of ship names is completed!'
exit

/* end of listing */
