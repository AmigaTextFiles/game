;agent
dana1:    dat       20
dana2:    dat       -120
start:    spl       dana2        
          mov       skok      dana1
          spl       dana1
          sub       #20       dana2
          add       #20       dana1
          jmp       start
skok:     mov       0         1
