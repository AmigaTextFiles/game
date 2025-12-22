/*
 * set_country.rexx - This macro is to be used from the keyboard
 * with "rx set_country" while Empfe is running.
 */

say 'Set Empfe countries, I assume god is #0 so we start with #1'
say 'Enter country name for each number, end entering numbers'
say 'by hitting a return with no input.'

call put_country('name',0,'god')

n = 1
do forever
    say 'Enter country #'n
    parse pull c
    if c = '' then exit(0)
    call put_country('name',n,c)
    n = n + 1
    end


exit(0)



