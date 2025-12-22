;cowboy
fire     dat  0
beg      dat  0
fence    mov  success  switch
demon    sub  #1       bison
help     spl  demon
bombing  mov  fire     <fire
         jmn  help     bison
         mov  bomb     help
bomb     dat  0
bison    dat  64
count    jmp  fence
wellc1   jmp  <0
wellc2   jmp  @0
start    mov  rest     switch
         mov  #575     firecnt
         mov  #64      bison
         spl  radar
cont     mov  #4098    wellc1
         mov  #-4099   wellc2
loop     mov  wellc1   @wellc2
         mov  wellc2   @wellc1
         add #7        wellc1
         sub #7        wellc2
switch   djn loop      firecnt
new      mov bomb      fire
         mov bomb      kill
shoot    mov fire      <fire
         jmz shoot     kill
forward  jmp new
success  mov -15       0
rest     djn -4        20
radar    mov #638      forward
         mov #-638     back
         mov #25       count
make     mov count     <forward
         mov count     <back
         djn make      count
test     mov #638      forward
         mov #-638     back
         mov #25       count
compare  cmp <forward  <back
back     jmp alarm
kill     djn compare   count
firecnt  jmp test
alarm    mov bomb      switch
         mov #50       beg
         mov #3310     forward
copy     mov @beg      <forward
         djn copy      beg
         mov new       bombing
         add #11       forward
finish   jmp @forward
         end
