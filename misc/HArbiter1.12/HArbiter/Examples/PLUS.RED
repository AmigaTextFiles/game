;Plus - A. Stasiewicz
;proces 1------------------------------
proces_1    mov     -1          @osa_1
            add     #-5         osa_1
osa_1       jmp     -2          -10
;proces ini.---------------------------
start       spl     proces_1    <200
            spl     proces_2    <400
            spl     mama_a      <600
            spl     mama_b      <800
            spl     mama_c      <900
            spl     mama_d      <1000
            spl     mama_e      <1200
            spl     mama_f      <1400
            spl     mama_g      <1600
            spl     mama_h      <1800
            dat     0
;proces A------------------------------
            mov     -1          @osa_a
            add     #5          osa_a
osa_a       jmp     -2          10

mama_a      mov     -1          <cel_a
            mov     -3          <cel_a
            mov     -5          <cel_a
cel_a       spl     @cel_a      $200
            add     #100        cel_a
            jmp     mama_a
;proces B------------------------------
            mov     -1          @osa_b
            add     #5          osa_b
osa_b       jmp     -2          10

mama_b      mov     -1          <cel_b
            mov     -3          <cel_b
            mov     -5          <cel_b
cel_b       spl     @cel_b      $400
            add     #100        cel_a
            jmp     mama_b
;proces C------------------------------
            mov     -1          @osa_c
            add     #5          osa_c
osa_c       jmp     -2          10

mama_c      mov     -1          <cel_c
            mov     -3          <cel_c
            mov     -5          <cel_c
cel_c       spl     @cel_c      $600
            add     #100        cel_a
            jmp     mama_c
;proces D------------------------------
            mov     -1          @osa_d
            add     #5          osa_d
osa_d       jmp     -2          10

mama_d      mov     -1          <cel_d
            mov     -3          <cel_d
            mov     -5          <cel_d
cel_d       spl     @cel_d      $800
            add     #100        cel_a
            jmp     mama_d
;proces E------------------------------
            mov     -1          @osa_e
            add     #-5         osa_e
osa_e       jmp     -2          -10

mama_e      mov     -1          <cel_e
            mov     -3          <cel_e
            mov     -5          <cel_e
cel_e       spl     @cel_e      $-200
            add     #-100       cel_a
            jmp     mama_e
;proces F------------------------------
            mov     -1          @osa_f
            add     #-5         osa_f
osa_f       jmp     -2          -10

mama_f      mov     -1          <cel_f
            mov     -3          <cel_f
            mov     -5          <cel_f
cel_f       spl     @cel_f      $-400
            add     #-100       cel_a
            jmp     mama_f
;proces G------------------------------
            mov     -1          @osa_g
            add     #-5         osa_g
osa_g       jmp     -2          -10

mama_g      mov     -1          <cel_g
            mov     -3          <cel_g
            mov     -5          <cel_g
cel_g       spl     @cel_g      $-600
            add     #-100       cel_a
            jmp     mama_g
;proces H------------------------------
            mov     -1          @osa_h
            add     #-5         osa_h
osa_h       jmp     -2          -10

mama_h      mov     -1          <cel_h
            mov     -3          <cel_h
            mov     -5          <cel_h
cel_h       spl     @cel_h      $-800
            add     #-100       cel_a
            jmp     mama_h
;proces 2------------------------------
proces_2    mov     -1          @osa_2
            add     #5          osa_2
osa_2       jmp     -2          90
            end
