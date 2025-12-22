;Armitage III
;Mirek Kaim, kl.3B (Presto/6Killer/Ryoko/ALIENS)
.WA91
start:  mov target,1017
        mov target-1,<start
        mov target-2,<start
        mov target-3,<start
        mov target-4,<start
        mov target-5,<start
        mov target-6,<start
        spl @start
        add #717,start
        jmp start
        mov death <1
        jmp -1 <-1
death:  dat 2
killer: mov hiv <target
        jmp -1 <target
hiv:    spl 2
target: dat -7
        end start
