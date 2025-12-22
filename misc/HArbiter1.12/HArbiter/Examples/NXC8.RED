; N razy (X) Cios co 8 pol 
;    nxc8
; Tadeusz Moron
; ul. Sikorskiego 5
; 32-620 Brzeszcze

bomba   dat     $8      $8
start   mov     #8      $juz
        mov     #4      $to
st      mov     <to     <tam
juz     djn     $st     #8
to      spl     @tam    $4
cios    mov     $bomba  $-12
        sub     #8      $cios
tam     jmp     $cios   $3457
    
