/* go-exe-check rexx */

parse arg exe .

if exe = '' then
  ret = 5
else do

  if open('in',exe,'R') then do

    id = c2x(readch('in',4))
    call close('in')

    if id = '000003F3' then
      ret = 0
    else
      ret = 5

  end
  else
    ret = 5

end

exit ret

