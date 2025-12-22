;Ferret
;standard CWS'88 i WA'91
;
start   mov     #4908   daleko
test    cmp     <blisko <daleko
        mov     sznury  @daleko
        cmp     <blisko <daleko
blisko  mov     sznury  -5
        djn     test    daleko
ostrze  mov     bomba   <bomba
        djn     ostrze  <bomba
        add     #3      bomba
daleko  jmp     ostrze
bomba   dat             -10
sznury  spl     0
        end
